Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62B465EF89
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jan 2023 15:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjAEO7O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Jan 2023 09:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbjAEO6p (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Jan 2023 09:58:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F129E5C907
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 06:58:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E05361AD2
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 14:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B65DC433D2;
        Thu,  5 Jan 2023 14:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672930722;
        bh=5h+aXJ0i7Nbx6gz7mYJPeAIwJe63HDbez4N1Eb1Sags=;
        h=Subject:From:To:Cc:Date:From;
        b=fXuHx7MTyEXSGstDUsJgUtMErtmeSpgNT3pnPFU891Azwq3Dr0/L176XkpM+jJ+u+
         X/i8prU0DaZmLhl10gDQFhusCdFvmsw6ACij6gVBsGjdNAD/wKsDiq2fd1uYsLGqH0
         LmUnWNLHCsmnmS8C6sM0PFgYbZkNhX7e8kJnEgbOqHuNBGfnoXGdEaL72nqxNeLQ70
         6Bcx9xzrpjHDwnHjMx4Ki9fw20B8G8E5YsL3Rq53jCOzgmgI6xfFWKF0cXb4/nQnmb
         JXgzp7BtspPspRvegXr1EjntZEfS53FGV04RQQy1w9xVqkLcWRqIm5KfdeASYCGLG0
         SE+qcGAmRPOSg==
Subject: [PATCH RFC] NFSD: Convert filecache to rhltable
From:   Chuck Lever <cel@kernel.org>
To:     jlayton@redhat.com, neilb@suse.de
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 05 Jan 2023 09:58:41 -0500
Message-ID: <167293053710.2587608.15966496749656663379.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

While we were converting the nfs4_file hashtable to use the kernel's
resizable hashtable data structure, Neil Brown observed that the
list variant (rhltable) would be better for managing nfsd_file items
as well. The nfsd_file hash table will contain multiple entries for
the same inode -- these should be kept together on a list. And, it
could be possible for exotic or malicious client behavior to cause
the hash table to resize itself on every insertion.

A nice simplification is that rhltable_lookup() can return a list
that contains only nfsd_file items that match a given inode, which
enables us to eliminate specialized hash table helper functions and
use the default functions provided by the rhashtable implementation).

Since we are now storing nfsd_file items for the same inode on a
single list, that effectively reduces the number of hash entries
that have to be tracked in the hash table. The mininum bucket count
is therefore lowered.

Suggested-by: Neil Brown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c |  289 +++++++++++++++++++--------------------------------
 fs/nfsd/filecache.h |    9 +-
 2 files changed, 115 insertions(+), 183 deletions(-)

Just to note that this work is still in the wings. It would need to
be rebased on Jeff's recent fixes and clean-ups. I'm reluctant to
apply this until there is more evidence that the instability in v6.0
has been duly addressed.


diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 45b2c9e3f636..f04e722bb6bc 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -74,70 +74,9 @@ static struct list_lru			nfsd_file_lru;
 static unsigned long			nfsd_file_flags;
 static struct fsnotify_group		*nfsd_file_fsnotify_group;
 static struct delayed_work		nfsd_filecache_laundrette;
-static struct rhashtable		nfsd_file_rhash_tbl
+static struct rhltable			nfsd_file_rhltable
 						____cacheline_aligned_in_smp;
 
-enum nfsd_file_lookup_type {
-	NFSD_FILE_KEY_INODE,
-	NFSD_FILE_KEY_FULL,
-};
-
-struct nfsd_file_lookup_key {
-	struct inode			*inode;
-	struct net			*net;
-	const struct cred		*cred;
-	unsigned char			need;
-	bool				gc;
-	enum nfsd_file_lookup_type	type;
-};
-
-/*
- * The returned hash value is based solely on the address of an in-code
- * inode, a pointer to a slab-allocated object. The entropy in such a
- * pointer is concentrated in its middle bits.
- */
-static u32 nfsd_file_inode_hash(const struct inode *inode, u32 seed)
-{
-	unsigned long ptr = (unsigned long)inode;
-	u32 k;
-
-	k = ptr >> L1_CACHE_SHIFT;
-	k &= 0x00ffffff;
-	return jhash2(&k, 1, seed);
-}
-
-/**
- * nfsd_file_key_hashfn - Compute the hash value of a lookup key
- * @data: key on which to compute the hash value
- * @len: rhash table's key_len parameter (unused)
- * @seed: rhash table's random seed of the day
- *
- * Return value:
- *   Computed 32-bit hash value
- */
-static u32 nfsd_file_key_hashfn(const void *data, u32 len, u32 seed)
-{
-	const struct nfsd_file_lookup_key *key = data;
-
-	return nfsd_file_inode_hash(key->inode, seed);
-}
-
-/**
- * nfsd_file_obj_hashfn - Compute the hash value of an nfsd_file
- * @data: object on which to compute the hash value
- * @len: rhash table's key_len parameter (unused)
- * @seed: rhash table's random seed of the day
- *
- * Return value:
- *   Computed 32-bit hash value
- */
-static u32 nfsd_file_obj_hashfn(const void *data, u32 len, u32 seed)
-{
-	const struct nfsd_file *nf = data;
-
-	return nfsd_file_inode_hash(nf->nf_inode, seed);
-}
-
 static bool
 nfsd_match_cred(const struct cred *c1, const struct cred *c2)
 {
@@ -158,53 +97,16 @@ nfsd_match_cred(const struct cred *c1, const struct cred *c2)
 	return true;
 }
 
-/**
- * nfsd_file_obj_cmpfn - Match a cache item against search criteria
- * @arg: search criteria
- * @ptr: cache item to check
- *
- * Return values:
- *   %0 - Item matches search criteria
- *   %1 - Item does not match search criteria
- */
-static int nfsd_file_obj_cmpfn(struct rhashtable_compare_arg *arg,
-			       const void *ptr)
-{
-	const struct nfsd_file_lookup_key *key = arg->key;
-	const struct nfsd_file *nf = ptr;
-
-	switch (key->type) {
-	case NFSD_FILE_KEY_INODE:
-		if (nf->nf_inode != key->inode)
-			return 1;
-		break;
-	case NFSD_FILE_KEY_FULL:
-		if (nf->nf_inode != key->inode)
-			return 1;
-		if (nf->nf_may != key->need)
-			return 1;
-		if (nf->nf_net != key->net)
-			return 1;
-		if (!nfsd_match_cred(nf->nf_cred, key->cred))
-			return 1;
-		if (!!test_bit(NFSD_FILE_GC, &nf->nf_flags) != key->gc)
-			return 1;
-		if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) == 0)
-			return 1;
-		break;
-	}
-	return 0;
-}
-
 static const struct rhashtable_params nfsd_file_rhash_params = {
 	.key_len		= sizeof_field(struct nfsd_file, nf_inode),
 	.key_offset		= offsetof(struct nfsd_file, nf_inode),
-	.head_offset		= offsetof(struct nfsd_file, nf_rhash),
-	.hashfn			= nfsd_file_key_hashfn,
-	.obj_hashfn		= nfsd_file_obj_hashfn,
-	.obj_cmpfn		= nfsd_file_obj_cmpfn,
-	/* Reduce resizing churn on light workloads */
-	.min_size		= 512,		/* buckets */
+	.head_offset		= offsetof(struct nfsd_file, nf_rlist),
+
+	/*
+	 * Start with a single page hash table to reduce resizing churn
+	 * on light workloads.
+	 */
+	.min_size		= 256,
 	.automatic_shrinking	= true,
 };
 
@@ -307,27 +209,27 @@ nfsd_file_mark_find_or_create(struct nfsd_file *nf, struct inode *inode)
 }
 
 static struct nfsd_file *
-nfsd_file_alloc(struct nfsd_file_lookup_key *key, unsigned int may)
+nfsd_file_alloc(struct net *net, struct inode *inode, unsigned char need,
+		bool want_gc)
 {
 	struct nfsd_file *nf;
 
 	nf = kmem_cache_alloc(nfsd_file_slab, GFP_KERNEL);
-	if (nf) {
-		INIT_LIST_HEAD(&nf->nf_lru);
-		nf->nf_birthtime = ktime_get();
-		nf->nf_file = NULL;
-		nf->nf_cred = get_current_cred();
-		nf->nf_net = key->net;
-		nf->nf_flags = 0;
-		__set_bit(NFSD_FILE_HASHED, &nf->nf_flags);
-		__set_bit(NFSD_FILE_PENDING, &nf->nf_flags);
-		if (key->gc)
-			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
-		nf->nf_inode = key->inode;
-		refcount_set(&nf->nf_ref, 1);
-		nf->nf_may = key->need;
-		nf->nf_mark = NULL;
-	}
+	if (unlikely(!nf))
+		return NULL;
+
+	INIT_LIST_HEAD(&nf->nf_lru);
+	nf->nf_birthtime = ktime_get();
+	nf->nf_file = NULL;
+	nf->nf_cred = get_current_cred();
+	nf->nf_net = net;
+	nf->nf_flags = want_gc ?
+		BIT(NFSD_FILE_HASHED) | BIT(NFSD_FILE_PENDING) | BIT(NFSD_FILE_GC) :
+		BIT(NFSD_FILE_HASHED) | BIT(NFSD_FILE_PENDING);
+	nf->nf_inode = inode;
+	refcount_set(&nf->nf_ref, 1);
+	nf->nf_may = need;
+	nf->nf_mark = NULL;
 	return nf;
 }
 
@@ -362,8 +264,8 @@ nfsd_file_hash_remove(struct nfsd_file *nf)
 
 	if (nfsd_file_check_write_error(nf))
 		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
-	rhashtable_remove_fast(&nfsd_file_rhash_tbl, &nf->nf_rhash,
-			       nfsd_file_rhash_params);
+	rhltable_remove(&nfsd_file_rhltable, &nf->nf_rlist,
+			nfsd_file_rhash_params);
 }
 
 static bool
@@ -680,21 +582,19 @@ static struct shrinker	nfsd_file_shrinker = {
 static void
 nfsd_file_queue_for_close(struct inode *inode, struct list_head *dispose)
 {
-	struct nfsd_file_lookup_key key = {
-		.type	= NFSD_FILE_KEY_INODE,
-		.inode	= inode,
-	};
-	struct nfsd_file *nf;
-
 	rcu_read_lock();
 	do {
+		struct rhlist_head *list;
+		struct nfsd_file *nf;
 		int decrement = 1;
 
-		nf = rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
+		list = rhltable_lookup(&nfsd_file_rhltable, &inode,
 				       nfsd_file_rhash_params);
-		if (!nf)
+		if (!list)
 			break;
 
+		nf = container_of(list, struct nfsd_file, nf_rlist);
+
 		/* If we raced with someone else unhashing, ignore it */
 		if (!nfsd_file_unhash(nf))
 			continue;
@@ -836,7 +736,7 @@ nfsd_file_cache_init(void)
 	if (test_and_set_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) == 1)
 		return 0;
 
-	ret = rhashtable_init(&nfsd_file_rhash_tbl, &nfsd_file_rhash_params);
+	ret = rhltable_init(&nfsd_file_rhltable, &nfsd_file_rhash_params);
 	if (ret)
 		return ret;
 
@@ -904,7 +804,7 @@ nfsd_file_cache_init(void)
 	nfsd_file_mark_slab = NULL;
 	destroy_workqueue(nfsd_filecache_wq);
 	nfsd_filecache_wq = NULL;
-	rhashtable_destroy(&nfsd_file_rhash_tbl);
+	rhltable_destroy(&nfsd_file_rhltable);
 	goto out;
 }
 
@@ -922,7 +822,7 @@ __nfsd_file_cache_purge(struct net *net)
 	struct nfsd_file *nf;
 	LIST_HEAD(dispose);
 
-	rhashtable_walk_enter(&nfsd_file_rhash_tbl, &iter);
+	rhltable_walk_enter(&nfsd_file_rhltable, &iter);
 	do {
 		rhashtable_walk_start(&iter);
 
@@ -1031,7 +931,7 @@ nfsd_file_cache_shutdown(void)
 	nfsd_file_mark_slab = NULL;
 	destroy_workqueue(nfsd_filecache_wq);
 	nfsd_filecache_wq = NULL;
-	rhashtable_destroy(&nfsd_file_rhash_tbl);
+	rhltable_destroy(&nfsd_file_rhltable);
 
 	for_each_possible_cpu(i) {
 		per_cpu(nfsd_file_cache_hits, i) = 0;
@@ -1042,6 +942,36 @@ nfsd_file_cache_shutdown(void)
 	}
 }
 
+static struct nfsd_file *
+nfsd_file_lookup_locked(const struct net *net, const struct cred *cred,
+			struct inode *inode, unsigned char need,
+			bool want_gc)
+{
+	struct rhlist_head *tmp, *list;
+	struct nfsd_file *nf;
+
+	list = rhltable_lookup(&nfsd_file_rhltable, &inode,
+			       nfsd_file_rhash_params);
+	rhl_for_each_entry_rcu(nf, tmp, list, nf_rlist) {
+		if (nf->nf_may != need)
+			continue;
+		if (nf->nf_net != net)
+			continue;
+		if (!nfsd_match_cred(nf->nf_cred, cred))
+			continue;
+		if (!!test_bit(NFSD_FILE_GC, &nf->nf_flags) != want_gc)
+			continue;
+		if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) == 0)
+			continue;
+
+		/* If it was on the LRU, reuse that reference. */
+		if (nfsd_file_lru_remove(nf))
+			WARN_ON_ONCE(refcount_dec_and_test(&nf->nf_ref));
+		return nf;
+	}
+	return NULL;
+}
+
 /**
  * nfsd_file_is_cached - are there any cached open files for this inode?
  * @inode: inode to check
@@ -1056,15 +986,12 @@ nfsd_file_cache_shutdown(void)
 bool
 nfsd_file_is_cached(struct inode *inode)
 {
-	struct nfsd_file_lookup_key key = {
-		.type	= NFSD_FILE_KEY_INODE,
-		.inode	= inode,
-	};
-	bool ret = false;
-
-	if (rhashtable_lookup_fast(&nfsd_file_rhash_tbl, &key,
-				   nfsd_file_rhash_params) != NULL)
-		ret = true;
+	bool ret;
+
+	rcu_read_lock();
+	ret = (rhltable_lookup(&nfsd_file_rhltable, &inode,
+			       nfsd_file_rhash_params) != NULL);
+	rcu_read_unlock();
 	trace_nfsd_file_is_cached(inode, (int)ret);
 	return ret;
 }
@@ -1074,14 +1001,12 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		     unsigned int may_flags, struct nfsd_file **pnf,
 		     bool open, bool want_gc)
 {
-	struct nfsd_file_lookup_key key = {
-		.type	= NFSD_FILE_KEY_FULL,
-		.need	= may_flags & NFSD_FILE_MAY_MASK,
-		.net	= SVC_NET(rqstp),
-		.gc	= want_gc,
-	};
+	unsigned char need = may_flags & NFSD_FILE_MAY_MASK;
+	struct net *net = SVC_NET(rqstp);
+	struct nfsd_file *new, *nf;
+	const struct cred *cred;
 	bool open_retry = true;
-	struct nfsd_file *nf;
+	struct inode *inode;
 	__be32 status;
 	int ret;
 
@@ -1089,32 +1014,38 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				may_flags|NFSD_MAY_OWNER_OVERRIDE);
 	if (status != nfs_ok)
 		return status;
-	key.inode = d_inode(fhp->fh_dentry);
-	key.cred = get_current_cred();
+	inode = d_inode(fhp->fh_dentry);
+	cred = get_current_cred();
 
 retry:
-	rcu_read_lock();
-	nf = rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
-			       nfsd_file_rhash_params);
-	if (nf)
-		nf = nfsd_file_get(nf);
-	rcu_read_unlock();
-
-	if (nf) {
-		if (nfsd_file_lru_remove(nf))
-			WARN_ON_ONCE(refcount_dec_and_test(&nf->nf_ref));
-		goto wait_for_construction;
+	if (open) {
+		rcu_read_lock();
+		nf = nfsd_file_lookup_locked(net, cred, inode, need, want_gc);
+		rcu_read_unlock();
+		if (nf)
+			goto wait_for_construction;
 	}
 
-	nf = nfsd_file_alloc(&key, may_flags);
-	if (!nf) {
+	new = nfsd_file_alloc(net, inode, need, want_gc);
+	if (!new) {
 		status = nfserr_jukebox;
 		goto out_status;
 	}
+	rcu_read_lock();
+	spin_lock(&inode->i_lock);
+	nf = nfsd_file_lookup_locked(net, cred, inode, need, want_gc);
+	if (unlikely(nf)) {
+		spin_unlock(&inode->i_lock);
+		rcu_read_unlock();
+		nfsd_file_slab_free(&new->nf_rcu);
+		goto wait_for_construction;
+	}
+	nf = new;
+	ret = rhltable_insert(&nfsd_file_rhltable, &nf->nf_rlist,
+			      nfsd_file_rhash_params);
+	spin_unlock(&inode->i_lock);
+	rcu_read_unlock();
 
-	ret = rhashtable_lookup_insert_key(&nfsd_file_rhash_tbl,
-					   &key, &nf->nf_rhash,
-					   nfsd_file_rhash_params);
 	if (likely(ret == 0))
 		goto open_file;
 
@@ -1122,7 +1053,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	nf = NULL;
 	if (ret == -EEXIST)
 		goto retry;
-	trace_nfsd_file_insert_err(rqstp, key.inode, may_flags, ret);
+	trace_nfsd_file_insert_err(rqstp, inode, may_flags, ret);
 	status = nfserr_jukebox;
 	goto out_status;
 
@@ -1131,7 +1062,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	/* Did construction of this file fail? */
 	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
-		trace_nfsd_file_cons_err(rqstp, key.inode, may_flags, nf);
+		trace_nfsd_file_cons_err(rqstp, inode, may_flags, nf);
 		if (!open_retry) {
 			status = nfserr_jukebox;
 			goto out;
@@ -1157,14 +1088,14 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 out_status:
-	put_cred(key.cred);
+	put_cred(cred);
 	if (open)
-		trace_nfsd_file_acquire(rqstp, key.inode, may_flags, nf, status);
+		trace_nfsd_file_acquire(rqstp, inode, may_flags, nf, status);
 	return status;
 
 open_file:
 	trace_nfsd_file_alloc(nf);
-	nf->nf_mark = nfsd_file_mark_find_or_create(nf, key.inode);
+	nf->nf_mark = nfsd_file_mark_find_or_create(nf, inode);
 	if (nf->nf_mark) {
 		if (open) {
 			status = nfsd_open_verified(rqstp, fhp, may_flags,
@@ -1178,7 +1109,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	 * If construction failed, or we raced with a call to unlink()
 	 * then unhash.
 	 */
-	if (status == nfs_ok && key.inode->i_nlink == 0)
+	if (status != nfs_ok || inode->i_nlink == 0)
 		status = nfserr_jukebox;
 	if (status != nfs_ok)
 		nfsd_file_unhash(nf);
@@ -1273,7 +1204,7 @@ int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
 		lru = list_lru_count(&nfsd_file_lru);
 
 		rcu_read_lock();
-		ht = &nfsd_file_rhash_tbl;
+		ht = &nfsd_file_rhltable.ht;
 		count = atomic_read(&ht->nelems);
 		tbl = rht_dereference_rcu(ht->tbl, ht);
 		buckets = tbl->size;
@@ -1289,7 +1220,7 @@ int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
 		evictions += per_cpu(nfsd_file_evictions, i);
 	}
 
-	seq_printf(m, "total entries: %u\n", count);
+	seq_printf(m, "total inodes: %u\n", count);
 	seq_printf(m, "hash buckets:  %u\n", buckets);
 	seq_printf(m, "lru entries:   %lu\n", lru);
 	seq_printf(m, "cache hits:    %lu\n", hits);
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index b7efb2c3ddb1..7d3b35771565 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -29,9 +29,8 @@ struct nfsd_file_mark {
  * never be dereferenced, only used for comparison.
  */
 struct nfsd_file {
-	struct rhash_head	nf_rhash;
-	struct list_head	nf_lru;
-	struct rcu_head		nf_rcu;
+	struct rhlist_head	nf_rlist;
+	void			*nf_inode;
 	struct file		*nf_file;
 	const struct cred	*nf_cred;
 	struct net		*nf_net;
@@ -40,10 +39,12 @@ struct nfsd_file {
 #define NFSD_FILE_REFERENCED	(2)
 #define NFSD_FILE_GC		(3)
 	unsigned long		nf_flags;
-	struct inode		*nf_inode;	/* don't deref */
 	refcount_t		nf_ref;
 	unsigned char		nf_may;
+
 	struct nfsd_file_mark	*nf_mark;
+	struct list_head	nf_lru;
+	struct rcu_head		nf_rcu;
 	ktime_t			nf_birthtime;
 };
 


