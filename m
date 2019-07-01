Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3A621F19
	for <lists+linux-nfs@lfdr.de>; Fri, 17 May 2019 22:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfEQUd7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 May 2019 16:33:59 -0400
Received: from fieldses.org ([173.255.197.46]:54150 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbfEQUd7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 17 May 2019 16:33:59 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 34F091C81; Fri, 17 May 2019 16:33:58 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 1/2] nfsd4: drc containerization
Date:   Fri, 17 May 2019 16:33:56 -0400
Message-Id: <1558125237-21030-1-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

The nfsd duplicate reply cache should not be shared between network
namespaces.

The most straightforward way to fix this is just to move every global in
the code to per-net-namespace memory, so that's what we do.

Still todo: sort out which members of nfsd_stats should be global and
which per-net-namespace.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/cache.h    |   5 +-
 fs/nfsd/netns.h    |  33 +++++++
 fs/nfsd/nfscache.c | 226 ++++++++++++++++++++++-----------------------
 fs/nfsd/nfsctl.c   |  14 +--
 4 files changed, 153 insertions(+), 125 deletions(-)

diff --git a/fs/nfsd/cache.h b/fs/nfsd/cache.h
index 4a98537efb0f..10ec5ecdf117 100644
--- a/fs/nfsd/cache.h
+++ b/fs/nfsd/cache.h
@@ -10,6 +10,7 @@
 #define NFSCACHE_H
 
 #include <linux/sunrpc/svc.h>
+#include "netns.h"
 
 /*
  * Representation of a reply cache entry.
@@ -77,8 +78,8 @@ enum {
 /* Checksum this amount of the request */
 #define RC_CSUMLEN		(256U)
 
-int	nfsd_reply_cache_init(void);
-void	nfsd_reply_cache_shutdown(void);
+int	nfsd_reply_cache_init(struct nfsd_net *);
+void	nfsd_reply_cache_shutdown(struct nfsd_net *);
 int	nfsd_cache_lookup(struct svc_rqst *);
 void	nfsd_cache_update(struct svc_rqst *, int, __be32 *);
 int	nfsd_reply_cache_stats_open(struct inode *, struct file *);
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 32cb8c027483..4146dca94c5f 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -131,6 +131,39 @@ struct nfsd_net {
 	u32		s2s_cp_cl_id;
 	struct idr	s2s_cp_stateids;
 	spinlock_t	s2s_cp_lock;
+
+	/* Duplicate reply cache: */
+	struct nfsd_drc_bucket   *drc_hashtbl;
+	struct kmem_cache        *drc_slab;
+
+	/* max number of entries allowed in the cache */
+	unsigned int             max_drc_entries;
+
+	/* number of significant bits in the hash value */
+	unsigned int             maskbits;
+	unsigned int             drc_hashsize;
+
+	/*
+	 * Stats and other tracking of on the duplicate reply cache. All of these and
+	 * the "rc" fields in nfsdstats are protected by the cache_lock
+	 */
+
+	/* total number of entries */
+	atomic_t                 num_drc_entries;
+
+	/* cache misses due only to checksum comparison failures */
+	unsigned int             payload_misses;
+
+	/* amount of memory (in bytes) currently consumed by the DRC */
+	unsigned int             drc_mem_usage;
+
+	/* longest hash chain seen */
+	unsigned int             longest_chain;
+
+	/* size of cache when we saw the longest hash chain */
+	unsigned int             longest_chain_cachesize;
+
+	struct shrinker		nfsd_reply_cache_shrinker;
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index da52b594362a..b4202c861af4 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -9,6 +9,7 @@
  * Copyright (C) 1995, 1996 Olaf Kirch <okir@monad.swb.de>
  */
 
+#include <linux/sunrpc/svc_xprt.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/sunrpc/addr.h>
@@ -35,48 +36,12 @@ struct nfsd_drc_bucket {
 	spinlock_t cache_lock;
 };
 
-static struct nfsd_drc_bucket	*drc_hashtbl;
-static struct kmem_cache	*drc_slab;
-
-/* max number of entries allowed in the cache */
-static unsigned int		max_drc_entries;
-
-/* number of significant bits in the hash value */
-static unsigned int		maskbits;
-static unsigned int		drc_hashsize;
-
-/*
- * Stats and other tracking of on the duplicate reply cache. All of these and
- * the "rc" fields in nfsdstats are protected by the cache_lock
- */
-
-/* total number of entries */
-static atomic_t			num_drc_entries;
-
-/* cache misses due only to checksum comparison failures */
-static unsigned int		payload_misses;
-
-/* amount of memory (in bytes) currently consumed by the DRC */
-static unsigned int		drc_mem_usage;
-
-/* longest hash chain seen */
-static unsigned int		longest_chain;
-
-/* size of cache when we saw the longest hash chain */
-static unsigned int		longest_chain_cachesize;
-
 static int	nfsd_cache_append(struct svc_rqst *rqstp, struct kvec *vec);
 static unsigned long nfsd_reply_cache_count(struct shrinker *shrink,
 					    struct shrink_control *sc);
 static unsigned long nfsd_reply_cache_scan(struct shrinker *shrink,
 					   struct shrink_control *sc);
 
-static struct shrinker nfsd_reply_cache_shrinker = {
-	.scan_objects = nfsd_reply_cache_scan,
-	.count_objects = nfsd_reply_cache_count,
-	.seeks	= 1,
-};
-
 /*
  * Put a cap on the size of the DRC based on the amount of available
  * low memory in the machine.
@@ -94,6 +59,9 @@ static struct shrinker nfsd_reply_cache_shrinker = {
  * ...with a hard cap of 256k entries. In the worst case, each entry will be
  * ~1k, so the above numbers should give a rough max of the amount of memory
  * used in k.
+ *
+ * XXX: these limits are per-container, so memory used will increase
+ * linearly with number of containers.  Maybe that's OK.
  */
 static unsigned int
 nfsd_cache_size_limit(void)
@@ -116,17 +84,18 @@ nfsd_hashsize(unsigned int limit)
 }
 
 static u32
-nfsd_cache_hash(__be32 xid)
+nfsd_cache_hash(__be32 xid, struct nfsd_net *nn)
 {
-	return hash_32(be32_to_cpu(xid), maskbits);
+	return hash_32(be32_to_cpu(xid), nn->maskbits);
 }
 
 static struct svc_cacherep *
-nfsd_reply_cache_alloc(struct svc_rqst *rqstp, __wsum csum)
+nfsd_reply_cache_alloc(struct svc_rqst *rqstp, __wsum csum,
+			struct nfsd_net *nn)
 {
 	struct svc_cacherep	*rp;
 
-	rp = kmem_cache_alloc(drc_slab, GFP_KERNEL);
+	rp = kmem_cache_alloc(nn->drc_slab, GFP_KERNEL);
 	if (rp) {
 		rp->c_state = RC_UNUSED;
 		rp->c_type = RC_NOCACHE;
@@ -147,62 +116,68 @@ nfsd_reply_cache_alloc(struct svc_rqst *rqstp, __wsum csum)
 }
 
 static void
-nfsd_reply_cache_free_locked(struct nfsd_drc_bucket *b, struct svc_cacherep *rp)
+nfsd_reply_cache_free_locked(struct nfsd_drc_bucket *b, struct svc_cacherep *rp,
+				struct nfsd_net *nn)
 {
 	if (rp->c_type == RC_REPLBUFF && rp->c_replvec.iov_base) {
-		drc_mem_usage -= rp->c_replvec.iov_len;
+		nn->drc_mem_usage -= rp->c_replvec.iov_len;
 		kfree(rp->c_replvec.iov_base);
 	}
 	if (rp->c_state != RC_UNUSED) {
 		rb_erase(&rp->c_node, &b->rb_head);
 		list_del(&rp->c_lru);
-		atomic_dec(&num_drc_entries);
-		drc_mem_usage -= sizeof(*rp);
+		atomic_dec(&nn->num_drc_entries);
+		nn->drc_mem_usage -= sizeof(*rp);
 	}
-	kmem_cache_free(drc_slab, rp);
+	kmem_cache_free(nn->drc_slab, rp);
 }
 
 static void
-nfsd_reply_cache_free(struct nfsd_drc_bucket *b, struct svc_cacherep *rp)
+nfsd_reply_cache_free(struct nfsd_drc_bucket *b, struct svc_cacherep *rp,
+			struct nfsd_net *nn)
 {
 	spin_lock(&b->cache_lock);
-	nfsd_reply_cache_free_locked(b, rp);
+	nfsd_reply_cache_free_locked(b, rp, nn);
 	spin_unlock(&b->cache_lock);
 }
 
-int nfsd_reply_cache_init(void)
+int nfsd_reply_cache_init(struct nfsd_net *nn)
 {
 	unsigned int hashsize;
 	unsigned int i;
 	int status = 0;
 
-	max_drc_entries = nfsd_cache_size_limit();
-	atomic_set(&num_drc_entries, 0);
-	hashsize = nfsd_hashsize(max_drc_entries);
-	maskbits = ilog2(hashsize);
+	nn->max_drc_entries = nfsd_cache_size_limit();
+	atomic_set(&nn->num_drc_entries, 0);
+	hashsize = nfsd_hashsize(nn->max_drc_entries);
+	nn->maskbits = ilog2(hashsize);
 
-	status = register_shrinker(&nfsd_reply_cache_shrinker);
+	nn->nfsd_reply_cache_shrinker.scan_objects = nfsd_reply_cache_scan;
+	nn->nfsd_reply_cache_shrinker.count_objects = nfsd_reply_cache_count;
+	nn->nfsd_reply_cache_shrinker.seeks = 1;
+	status = register_shrinker(&nn->nfsd_reply_cache_shrinker);
 	if (status)
 		return status;
 
-	drc_slab = kmem_cache_create("nfsd_drc", sizeof(struct svc_cacherep),
-					0, 0, NULL);
-	if (!drc_slab)
+	nn->drc_slab = kmem_cache_create("nfsd_drc",
+				sizeof(struct svc_cacherep), 0, 0, NULL);
+	if (!nn->drc_slab)
 		goto out_nomem;
 
-	drc_hashtbl = kcalloc(hashsize, sizeof(*drc_hashtbl), GFP_KERNEL);
-	if (!drc_hashtbl) {
-		drc_hashtbl = vzalloc(array_size(hashsize,
-						 sizeof(*drc_hashtbl)));
-		if (!drc_hashtbl)
+	nn->drc_hashtbl = kcalloc(hashsize,
+				sizeof(*nn->drc_hashtbl), GFP_KERNEL);
+	if (!nn->drc_hashtbl) {
+		nn->drc_hashtbl = vzalloc(array_size(hashsize,
+						 sizeof(*nn->drc_hashtbl)));
+		if (!nn->drc_hashtbl)
 			goto out_nomem;
 	}
 
 	for (i = 0; i < hashsize; i++) {
-		INIT_LIST_HEAD(&drc_hashtbl[i].lru_head);
-		spin_lock_init(&drc_hashtbl[i].cache_lock);
+		INIT_LIST_HEAD(&nn->drc_hashtbl[i].lru_head);
+		spin_lock_init(&nn->drc_hashtbl[i].cache_lock);
 	}
-	drc_hashsize = hashsize;
+	nn->drc_hashsize = hashsize;
 
 	return 0;
 out_nomem:
@@ -211,27 +186,29 @@ int nfsd_reply_cache_init(void)
 	return -ENOMEM;
 }
 
-void nfsd_reply_cache_shutdown(void)
+void nfsd_reply_cache_shutdown(struct nfsd_net *nn)
 {
 	struct svc_cacherep	*rp;
 	unsigned int i;
 
-	unregister_shrinker(&nfsd_reply_cache_shrinker);
+	/* XXX: global: */
+	unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
 
-	for (i = 0; i < drc_hashsize; i++) {
-		struct list_head *head = &drc_hashtbl[i].lru_head;
+	for (i = 0; i < nn->drc_hashsize; i++) {
+		struct list_head *head = &nn->drc_hashtbl[i].lru_head;
 		while (!list_empty(head)) {
 			rp = list_first_entry(head, struct svc_cacherep, c_lru);
-			nfsd_reply_cache_free_locked(&drc_hashtbl[i], rp);
+			nfsd_reply_cache_free_locked(&nn->drc_hashtbl[i],
+									rp, nn);
 		}
 	}
 
-	kvfree(drc_hashtbl);
-	drc_hashtbl = NULL;
-	drc_hashsize = 0;
+	kvfree(nn->drc_hashtbl);
+	nn->drc_hashtbl = NULL;
+	nn->drc_hashsize = 0;
 
-	kmem_cache_destroy(drc_slab);
-	drc_slab = NULL;
+	kmem_cache_destroy(nn->drc_slab);
+	nn->drc_slab = NULL;
 }
 
 /*
@@ -246,7 +223,7 @@ lru_put_end(struct nfsd_drc_bucket *b, struct svc_cacherep *rp)
 }
 
 static long
-prune_bucket(struct nfsd_drc_bucket *b)
+prune_bucket(struct nfsd_drc_bucket *b, struct nfsd_net *nn)
 {
 	struct svc_cacherep *rp, *tmp;
 	long freed = 0;
@@ -258,10 +235,10 @@ prune_bucket(struct nfsd_drc_bucket *b)
 		 */
 		if (rp->c_state == RC_INPROG)
 			continue;
-		if (atomic_read(&num_drc_entries) <= max_drc_entries &&
+		if (atomic_read(&nn->num_drc_entries) <= nn->max_drc_entries &&
 		    time_before(jiffies, rp->c_timestamp + RC_EXPIRE))
 			break;
-		nfsd_reply_cache_free_locked(b, rp);
+		nfsd_reply_cache_free_locked(b, rp, nn);
 		freed++;
 	}
 	return freed;
@@ -272,18 +249,18 @@ prune_bucket(struct nfsd_drc_bucket *b)
  * Also prune the oldest ones when the total exceeds the max number of entries.
  */
 static long
-prune_cache_entries(void)
+prune_cache_entries(struct nfsd_net *nn)
 {
 	unsigned int i;
 	long freed = 0;
 
-	for (i = 0; i < drc_hashsize; i++) {
-		struct nfsd_drc_bucket *b = &drc_hashtbl[i];
+	for (i = 0; i < nn->drc_hashsize; i++) {
+		struct nfsd_drc_bucket *b = &nn->drc_hashtbl[i];
 
 		if (list_empty(&b->lru_head))
 			continue;
 		spin_lock(&b->cache_lock);
-		freed += prune_bucket(b);
+		freed += prune_bucket(b, nn);
 		spin_unlock(&b->cache_lock);
 	}
 	return freed;
@@ -292,13 +269,19 @@ prune_cache_entries(void)
 static unsigned long
 nfsd_reply_cache_count(struct shrinker *shrink, struct shrink_control *sc)
 {
-	return atomic_read(&num_drc_entries);
+	struct nfsd_net *nn = container_of(shrink,
+				struct nfsd_net, nfsd_reply_cache_shrinker);
+
+	return atomic_read(&nn->num_drc_entries);
 }
 
 static unsigned long
 nfsd_reply_cache_scan(struct shrinker *shrink, struct shrink_control *sc)
 {
-	return prune_cache_entries();
+	struct nfsd_net *nn = container_of(shrink,
+				struct nfsd_net, nfsd_reply_cache_shrinker);
+
+	return prune_cache_entries(nn);
 }
 /*
  * Walk an xdr_buf and get a CRC for at most the first RC_CSUMLEN bytes
@@ -334,11 +317,12 @@ nfsd_cache_csum(struct svc_rqst *rqstp)
 }
 
 static int
-nfsd_cache_key_cmp(const struct svc_cacherep *key, const struct svc_cacherep *rp)
+nfsd_cache_key_cmp(const struct svc_cacherep *key,
+			const struct svc_cacherep *rp, struct nfsd_net *nn)
 {
 	if (key->c_key.k_xid == rp->c_key.k_xid &&
 	    key->c_key.k_csum != rp->c_key.k_csum)
-		++payload_misses;
+		++nn->payload_misses;
 
 	return memcmp(&key->c_key, &rp->c_key, sizeof(key->c_key));
 }
@@ -349,7 +333,8 @@ nfsd_cache_key_cmp(const struct svc_cacherep *key, const struct svc_cacherep *rp
  * inserts an empty key on failure.
  */
 static struct svc_cacherep *
-nfsd_cache_insert(struct nfsd_drc_bucket *b, struct svc_cacherep *key)
+nfsd_cache_insert(struct nfsd_drc_bucket *b, struct svc_cacherep *key,
+			struct nfsd_net *nn)
 {
 	struct svc_cacherep	*rp, *ret = key;
 	struct rb_node		**p = &b->rb_head.rb_node,
@@ -362,7 +347,7 @@ nfsd_cache_insert(struct nfsd_drc_bucket *b, struct svc_cacherep *key)
 		parent = *p;
 		rp = rb_entry(parent, struct svc_cacherep, c_node);
 
-		cmp = nfsd_cache_key_cmp(key, rp);
+		cmp = nfsd_cache_key_cmp(key, rp, nn);
 		if (cmp < 0)
 			p = &parent->rb_left;
 		else if (cmp > 0)
@@ -376,14 +361,14 @@ nfsd_cache_insert(struct nfsd_drc_bucket *b, struct svc_cacherep *key)
 	rb_insert_color(&key->c_node, &b->rb_head);
 out:
 	/* tally hash chain length stats */
-	if (entries > longest_chain) {
-		longest_chain = entries;
-		longest_chain_cachesize = atomic_read(&num_drc_entries);
-	} else if (entries == longest_chain) {
+	if (entries > nn->longest_chain) {
+		nn->longest_chain = entries;
+		nn->longest_chain_cachesize = atomic_read(&nn->num_drc_entries);
+	} else if (entries == nn->longest_chain) {
 		/* prefer to keep the smallest cachesize possible here */
-		longest_chain_cachesize = min_t(unsigned int,
-				longest_chain_cachesize,
-				atomic_read(&num_drc_entries));
+		nn->longest_chain_cachesize = min_t(unsigned int,
+				nn->longest_chain_cachesize,
+				atomic_read(&nn->num_drc_entries));
 	}
 
 	lru_put_end(b, ret);
@@ -400,11 +385,12 @@ nfsd_cache_insert(struct nfsd_drc_bucket *b, struct svc_cacherep *key)
 int
 nfsd_cache_lookup(struct svc_rqst *rqstp)
 {
+	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct svc_cacherep	*rp, *found;
 	__be32			xid = rqstp->rq_xid;
 	__wsum			csum;
-	u32 hash = nfsd_cache_hash(xid);
-	struct nfsd_drc_bucket *b = &drc_hashtbl[hash];
+	u32 hash = nfsd_cache_hash(xid, nn);
+	struct nfsd_drc_bucket *b = &nn->drc_hashtbl[hash];
 	int type = rqstp->rq_cachetype;
 	int rtn = RC_DOIT;
 
@@ -420,16 +406,16 @@ nfsd_cache_lookup(struct svc_rqst *rqstp)
 	 * Since the common case is a cache miss followed by an insert,
 	 * preallocate an entry.
 	 */
-	rp = nfsd_reply_cache_alloc(rqstp, csum);
+	rp = nfsd_reply_cache_alloc(rqstp, csum, nn);
 	if (!rp) {
 		dprintk("nfsd: unable to allocate DRC entry!\n");
 		return rtn;
 	}
 
 	spin_lock(&b->cache_lock);
-	found = nfsd_cache_insert(b, rp);
+	found = nfsd_cache_insert(b, rp, nn);
 	if (found != rp) {
-		nfsd_reply_cache_free_locked(NULL, rp);
+		nfsd_reply_cache_free_locked(NULL, rp, nn);
 		rp = found;
 		goto found_entry;
 	}
@@ -438,11 +424,11 @@ nfsd_cache_lookup(struct svc_rqst *rqstp)
 	rqstp->rq_cacherep = rp;
 	rp->c_state = RC_INPROG;
 
-	atomic_inc(&num_drc_entries);
-	drc_mem_usage += sizeof(*rp);
+	atomic_inc(&nn->num_drc_entries);
+	nn->drc_mem_usage += sizeof(*rp);
 
 	/* go ahead and prune the cache */
-	prune_bucket(b);
+	prune_bucket(b, nn);
  out:
 	spin_unlock(&b->cache_lock);
 	return rtn;
@@ -477,7 +463,7 @@ nfsd_cache_lookup(struct svc_rqst *rqstp)
 		break;
 	default:
 		printk(KERN_WARNING "nfsd: bad repcache type %d\n", rp->c_type);
-		nfsd_reply_cache_free_locked(b, rp);
+		nfsd_reply_cache_free_locked(b, rp, nn);
 	}
 
 	goto out;
@@ -502,6 +488,7 @@ nfsd_cache_lookup(struct svc_rqst *rqstp)
 void
 nfsd_cache_update(struct svc_rqst *rqstp, int cachetype, __be32 *statp)
 {
+	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct svc_cacherep *rp = rqstp->rq_cacherep;
 	struct kvec	*resv = &rqstp->rq_res.head[0], *cachv;
 	u32		hash;
@@ -512,15 +499,15 @@ nfsd_cache_update(struct svc_rqst *rqstp, int cachetype, __be32 *statp)
 	if (!rp)
 		return;
 
-	hash = nfsd_cache_hash(rp->c_key.k_xid);
-	b = &drc_hashtbl[hash];
+	hash = nfsd_cache_hash(rp->c_key.k_xid, nn);
+	b = &nn->drc_hashtbl[hash];
 
 	len = resv->iov_len - ((char*)statp - (char*)resv->iov_base);
 	len >>= 2;
 
 	/* Don't cache excessive amounts of data and XDR failures */
 	if (!statp || len > (256 >> 2)) {
-		nfsd_reply_cache_free(b, rp);
+		nfsd_reply_cache_free(b, rp, nn);
 		return;
 	}
 
@@ -535,18 +522,18 @@ nfsd_cache_update(struct svc_rqst *rqstp, int cachetype, __be32 *statp)
 		bufsize = len << 2;
 		cachv->iov_base = kmalloc(bufsize, GFP_KERNEL);
 		if (!cachv->iov_base) {
-			nfsd_reply_cache_free(b, rp);
+			nfsd_reply_cache_free(b, rp, nn);
 			return;
 		}
 		cachv->iov_len = bufsize;
 		memcpy(cachv->iov_base, statp, bufsize);
 		break;
 	case RC_NOCACHE:
-		nfsd_reply_cache_free(b, rp);
+		nfsd_reply_cache_free(b, rp, nn);
 		return;
 	}
 	spin_lock(&b->cache_lock);
-	drc_mem_usage += bufsize;
+	nn->drc_mem_usage += bufsize;
 	lru_put_end(b, rp);
 	rp->c_secure = test_bit(RQ_SECURE, &rqstp->rq_flags);
 	rp->c_type = cachetype;
@@ -582,21 +569,26 @@ nfsd_cache_append(struct svc_rqst *rqstp, struct kvec *data)
  */
 static int nfsd_reply_cache_stats_show(struct seq_file *m, void *v)
 {
-	seq_printf(m, "max entries:           %u\n", max_drc_entries);
+	struct nfsd_net *nn = v;
+
+	seq_printf(m, "max entries:           %u\n", nn->max_drc_entries);
 	seq_printf(m, "num entries:           %u\n",
-			atomic_read(&num_drc_entries));
-	seq_printf(m, "hash buckets:          %u\n", 1 << maskbits);
-	seq_printf(m, "mem usage:             %u\n", drc_mem_usage);
+			atomic_read(&nn->num_drc_entries));
+	seq_printf(m, "hash buckets:          %u\n", 1 << nn->maskbits);
+	seq_printf(m, "mem usage:             %u\n", nn->drc_mem_usage);
 	seq_printf(m, "cache hits:            %u\n", nfsdstats.rchits);
 	seq_printf(m, "cache misses:          %u\n", nfsdstats.rcmisses);
 	seq_printf(m, "not cached:            %u\n", nfsdstats.rcnocache);
-	seq_printf(m, "payload misses:        %u\n", payload_misses);
-	seq_printf(m, "longest chain len:     %u\n", longest_chain);
-	seq_printf(m, "cachesize at longest:  %u\n", longest_chain_cachesize);
+	seq_printf(m, "payload misses:        %u\n", nn->payload_misses);
+	seq_printf(m, "longest chain len:     %u\n", nn->longest_chain);
+	seq_printf(m, "cachesize at longest:  %u\n", nn->longest_chain_cachesize);
 	return 0;
 }
 
 int nfsd_reply_cache_stats_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, nfsd_reply_cache_stats_show, NULL);
+	struct nfsd_net *nn = net_generic(file_inode(file)->i_sb->s_fs_info,
+								nfsd_net_id);
+
+	return single_open(file, nfsd_reply_cache_stats_show, nn);
 }
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index f2feb2d11bae..9e2d038c3426 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1239,6 +1239,9 @@ static __net_init int nfsd_init_net(struct net *net)
 	retval = nfsd_idmap_init(net);
 	if (retval)
 		goto out_idmap_error;
+	retval = nfsd_reply_cache_init(nn);
+	if (retval)
+		goto out_drc_error;
 	nn->nfsd4_lease = 90;	/* default lease time */
 	nn->nfsd4_grace = 90;
 	nn->somebody_reclaimed = false;
@@ -1250,6 +1253,8 @@ static __net_init int nfsd_init_net(struct net *net)
 	init_waitqueue_head(&nn->ntf_wq);
 	return 0;
 
+out_drc_error:
+	nfsd_idmap_shutdown(net);
 out_idmap_error:
 	nfsd_export_shutdown(net);
 out_export_error:
@@ -1258,6 +1263,9 @@ static __net_init int nfsd_init_net(struct net *net)
 
 static __net_exit void nfsd_exit_net(struct net *net)
 {
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
+	nfsd_reply_cache_shutdown(nn);
 	nfsd_idmap_shutdown(net);
 	nfsd_export_shutdown(net);
 }
@@ -1290,9 +1298,6 @@ static int __init init_nfsd(void)
 	if (retval)
 		goto out_exit_pnfs;
 	nfsd_stat_init();	/* Statistics */
-	retval = nfsd_reply_cache_init();
-	if (retval)
-		goto out_free_stat;
 	nfsd_lockd_init();	/* lockd->nfsd callbacks */
 	retval = create_proc_exports_entry();
 	if (retval)
@@ -1306,8 +1311,6 @@ static int __init init_nfsd(void)
 	remove_proc_entry("fs/nfs", NULL);
 out_free_lockd:
 	nfsd_lockd_shutdown();
-	nfsd_reply_cache_shutdown();
-out_free_stat:
 	nfsd_stat_shutdown();
 	nfsd_fault_inject_cleanup();
 out_exit_pnfs:
@@ -1323,7 +1326,6 @@ static int __init init_nfsd(void)
 
 static void __exit exit_nfsd(void)
 {
-	nfsd_reply_cache_shutdown();
 	remove_proc_entry("fs/nfs/exports", NULL);
 	remove_proc_entry("fs/nfs", NULL);
 	nfsd_stat_shutdown();
-- 
2.21.0

