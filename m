Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669865F56D3
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Oct 2022 16:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiJEO40 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Oct 2022 10:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJEO4Z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Oct 2022 10:56:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4354B10DE
        for <linux-nfs@vger.kernel.org>; Wed,  5 Oct 2022 07:56:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC4DCB81DED
        for <linux-nfs@vger.kernel.org>; Wed,  5 Oct 2022 14:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4DAC433D6
        for <linux-nfs@vger.kernel.org>; Wed,  5 Oct 2022 14:56:21 +0000 (UTC)
Subject: [PATCH RFC 7/9] NFSD: Use rhashtable for managing nfs4_file objects
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 05 Oct 2022 10:56:20 -0400
Message-ID: <166498178061.1527.15489022568685172014.stgit@manet.1015granger.net>
In-Reply-To: <166497916751.1527.11190362197003358927.stgit@manet.1015granger.net>
References: <166497916751.1527.11190362197003358927.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

fh_match() is expensive to use for hash chains that contain more
than a few objects. With common workloads, I see multiple thousands
of objects stored in file_hashtbl[], which always has only 256
buckets.

Replace it with an rhashtable, which dynamically resizes its bucket
array to keep hash chains short.

This also enables the removal of the use of state_lock to serialize
operations on the new rhashtable.

The result is an improvement in the latency of NFSv4 operations
and the reduction of nfsd CPU utilization due to the cache misses
of walking long hash chains in file_hashtbl.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |  229 +++++++++++++++++++++++++++++++++++----------------
 fs/nfsd/state.h     |    5 -
 2 files changed, 158 insertions(+), 76 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2b850de288cf..06499b9481a6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -44,7 +44,9 @@
 #include <linux/jhash.h>
 #include <linux/string_helpers.h>
 #include <linux/fsnotify.h>
+#include <linux/rhashtable.h>
 #include <linux/nfs_ssc.h>
+
 #include "xdr4.h"
 #include "xdr4cb.h"
 #include "vfs.h"
@@ -84,6 +86,7 @@ static bool check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
 static void nfs4_free_ol_stateid(struct nfs4_stid *stid);
 void nfsd4_end_grace(struct nfsd_net *nn);
 static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_state *cps);
+static void unhash_nfs4_file(struct nfs4_file *fp);
 
 /* Locking: */
 
@@ -577,11 +580,8 @@ static void nfsd4_free_file_rcu(struct rcu_head *rcu)
 void
 put_nfs4_file(struct nfs4_file *fi)
 {
-	might_lock(&state_lock);
-
-	if (refcount_dec_and_lock(&fi->fi_ref, &state_lock)) {
-		hlist_del_rcu(&fi->fi_hash);
-		spin_unlock(&state_lock);
+	if (refcount_dec_and_test(&fi->fi_ref)) {
+		unhash_nfs4_file(fi);
 		WARN_ON_ONCE(!list_empty(&fi->fi_clnt_odstate));
 		WARN_ON_ONCE(!list_empty(&fi->fi_delegations));
 		call_rcu(&fi->fi_rcu, nfsd4_free_file_rcu);
@@ -695,19 +695,85 @@ static unsigned int ownerstr_hashval(struct xdr_netobj *ownername)
 	return ret & OWNER_HASH_MASK;
 }
 
-/* hash table for nfs4_file */
-#define FILE_HASH_BITS                   8
-#define FILE_HASH_SIZE                  (1 << FILE_HASH_BITS)
+static struct rhashtable nfs4_file_rhashtbl ____cacheline_aligned_in_smp;
 
-static unsigned int file_hashval(struct svc_fh *fh)
+/*
+ * The returned hash value is based solely on the address of an in-code
+ * inode, a pointer to a slab-allocated object. The entropy in such a
+ * pointer is concentrated in its middle bits.
+ */
+static u32 nfs4_file_inode_hash(const struct inode *inode, u32 seed)
+{
+	unsigned long ptr = (unsigned long)inode;
+	u32 k;
+
+	k = ptr >> L1_CACHE_SHIFT;
+	k &= 0x00ffffff;
+	return jhash2(&k, 1, seed);
+}
+
+/**
+ * nfs4_file_key_hashfn - Compute the hash value of a lookup key
+ * @data: key on which to compute the hash value
+ * @len: rhash table's key_len parameter (unused)
+ * @seed: rhash table's random seed of the day
+ *
+ * Return value:
+ *   Computed 32-bit hash value
+ */
+static u32 nfs4_file_key_hashfn(const void *data, u32 len, u32 seed)
 {
-	struct inode *inode = d_inode(fh->fh_dentry);
+	const struct svc_fh *fhp = data;
 
-	/* XXX: why not (here & in file cache) use inode? */
-	return (unsigned int)hash_long(inode->i_ino, FILE_HASH_BITS);
+	return nfs4_file_inode_hash(d_inode(fhp->fh_dentry), seed);
 }
 
-static struct hlist_head file_hashtbl[FILE_HASH_SIZE];
+/**
+ * nfs4_file_obj_hashfn - Compute the hash value of an nfs4_file object
+ * @data: object on which to compute the hash value
+ * @len: rhash table's key_len parameter (unused)
+ * @seed: rhash table's random seed of the day
+ *
+ * Return value:
+ *   Computed 32-bit hash value
+ */
+static u32 nfs4_file_obj_hashfn(const void *data, u32 len, u32 seed)
+{
+	const struct nfs4_file *fi = data;
+
+	return nfs4_file_inode_hash(fi->fi_inode, seed);
+}
+
+/**
+ * nfs4_file_obj_cmpfn - Match a cache item against search criteria
+ * @arg: search criteria
+ * @ptr: cache item to check
+ *
+ * Return values:
+ *   %0 - Item matches search criteria
+ *   %1 - Item does not match search criteria
+ */
+static int nfs4_file_obj_cmpfn(struct rhashtable_compare_arg *arg,
+			       const void *ptr)
+{
+	const struct svc_fh *fhp = arg->key;
+	const struct nfs4_file *fi = ptr;
+
+	return fh_match(&fi->fi_fhandle, &fhp->fh_handle) ? 0 : 1;
+}
+
+static const struct rhashtable_params nfs4_file_rhash_params = {
+	.key_len		= sizeof_field(struct nfs4_file, fi_inode),
+	.key_offset		= offsetof(struct nfs4_file, fi_inode),
+	.head_offset		= offsetof(struct nfs4_file, fi_rhash),
+	.hashfn			= nfs4_file_key_hashfn,
+	.obj_hashfn		= nfs4_file_obj_hashfn,
+	.obj_cmpfn		= nfs4_file_obj_cmpfn,
+
+	/* Reduce resizing churn on light workloads */
+	.min_size		= 512,		/* buckets */
+	.automatic_shrinking	= true,
+};
 
 /*
  * Check if courtesy clients have conflicting access and resolve it if possible
@@ -4251,11 +4317,8 @@ static struct nfs4_file *nfsd4_alloc_file(void)
 }
 
 /* OPEN Share state helper functions */
-static void nfsd4_init_file(struct svc_fh *fh, unsigned int hashval,
-				struct nfs4_file *fp)
+static void init_nfs4_file(const struct svc_fh *fh, struct nfs4_file *fp)
 {
-	lockdep_assert_held(&state_lock);
-
 	refcount_set(&fp->fi_ref, 1);
 	spin_lock_init(&fp->fi_lock);
 	INIT_LIST_HEAD(&fp->fi_stateids);
@@ -4273,7 +4336,6 @@ static void nfsd4_init_file(struct svc_fh *fh, unsigned int hashval,
 	INIT_LIST_HEAD(&fp->fi_lo_states);
 	atomic_set(&fp->fi_lo_recalls, 0);
 #endif
-	hlist_add_head_rcu(&fp->fi_hash, &file_hashtbl[hashval]);
 }
 
 void
@@ -4626,71 +4688,84 @@ move_to_close_lru(struct nfs4_ol_stateid *s, struct net *net)
 		nfs4_put_stid(&last->st_stid);
 }
 
-/* search file_hashtbl[] for file */
-static struct nfs4_file *
-find_file_locked(struct svc_fh *fh, unsigned int hashval)
+static struct nfs4_file *find_nfs4_file(const struct svc_fh *fhp)
 {
-	struct nfs4_file *fp;
+	struct nfs4_file *fi;
 
-	hlist_for_each_entry_rcu(fp, &file_hashtbl[hashval], fi_hash,
-				lockdep_is_held(&state_lock)) {
-		if (fh_match(&fp->fi_fhandle, &fh->fh_handle)) {
-			if (refcount_inc_not_zero(&fp->fi_ref))
-				return fp;
-		}
-	}
-	return NULL;
+	rcu_read_lock();
+	fi = rhashtable_lookup(&nfs4_file_rhashtbl, fhp,
+			       nfs4_file_rhash_params);
+	if (fi)
+		if (!refcount_inc_not_zero(&fi->fi_ref))
+			fi = NULL;
+	rcu_read_unlock();
+	return fi;
 }
 
-static struct nfs4_file *insert_file(struct nfs4_file *new, struct svc_fh *fh,
-				     unsigned int hashval)
+static void check_nfs4_file_aliases_locked(struct nfs4_file *new,
+					   const struct svc_fh *fhp)
 {
-	struct nfs4_file *fp;
-	struct nfs4_file *ret = NULL;
-	bool alias_found = false;
+	struct rhashtable *ht = &nfs4_file_rhashtbl;
+	struct rhash_lock_head __rcu *const *bkt;
+	struct rhashtable_compare_arg arg = {
+		.ht	= ht,
+		.key	= fhp,
+	};
+	struct bucket_table *tbl;
+	struct rhash_head *he;
+	unsigned int hash;
 
-	spin_lock(&state_lock);
-	hlist_for_each_entry_rcu(fp, &file_hashtbl[hashval], fi_hash,
-				 lockdep_is_held(&state_lock)) {
-		if (fh_match(&fp->fi_fhandle, &fh->fh_handle)) {
-			if (refcount_inc_not_zero(&fp->fi_ref))
-				ret = fp;
-		} else if (d_inode(fh->fh_dentry) == fp->fi_inode)
-			fp->fi_aliased = alias_found = true;
-	}
-	if (likely(ret == NULL)) {
-		nfsd4_init_file(fh, hashval, new);
-		new->fi_aliased = alias_found;
-		ret = new;
+	/*
+	 * rhashtable guarantees small buckets, thus this loop stays
+	 * efficient.
+	 */
+	rcu_read_lock();
+	tbl = rht_dereference_rcu(ht->tbl, ht);
+	hash = rht_key_hashfn(ht, tbl, fhp, nfs4_file_rhash_params);
+	bkt = rht_bucket(tbl, hash);
+	rht_for_each_rcu_from(he, rht_ptr_rcu(bkt), tbl, hash) {
+		struct nfs4_file *fi;
+
+		fi = rht_obj(ht, he);
+		if (nfs4_file_obj_cmpfn(&arg, fi) == 0)
+			continue;
+		if (d_inode(fhp->fh_dentry) == fi->fi_inode) {
+			fi->fi_aliased = true;
+			new->fi_aliased = true;
+		}
 	}
-	spin_unlock(&state_lock);
-	return ret;
+	rcu_read_unlock();
 }
 
-static struct nfs4_file * find_file(struct svc_fh *fh)
+static noinline struct nfs4_file *
+find_or_hash_nfs4_file(struct nfs4_file *new, const struct svc_fh *fhp)
 {
-	struct nfs4_file *fp;
-	unsigned int hashval = file_hashval(fh);
+	struct nfs4_file *fi;
 
-	rcu_read_lock();
-	fp = find_file_locked(fh, hashval);
-	rcu_read_unlock();
-	return fp;
-}
+	init_nfs4_file(fhp, new);
 
-static struct nfs4_file *
-find_or_add_file(struct nfs4_file *new, struct svc_fh *fh)
-{
-	struct nfs4_file *fp;
-	unsigned int hashval = file_hashval(fh);
+	fi = rhashtable_lookup_get_insert_key(&nfs4_file_rhashtbl,
+					      fhp, &new->fi_rhash,
+					      nfs4_file_rhash_params);
+	if (!fi) {
+		fi = new;
+		goto check_aliases;
+	}
+	if (IS_ERR(fi))		/* or BUG? */
+		return NULL;
+	if (!refcount_inc_not_zero(&fi->fi_ref))
+		fi = new;
 
-	rcu_read_lock();
-	fp = find_file_locked(fh, hashval);
-	rcu_read_unlock();
-	if (fp)
-		return fp;
+check_aliases:
+	check_nfs4_file_aliases_locked(fi, fhp);
+
+	return fi;
+}
 
-	return insert_file(new, fh, hashval);
+static void unhash_nfs4_file(struct nfs4_file *fi)
+{
+	rhashtable_remove_fast(&nfs4_file_rhashtbl, &fi->fi_rhash,
+			       nfs4_file_rhash_params);
 }
 
 /*
@@ -4703,9 +4778,10 @@ nfs4_share_conflict(struct svc_fh *current_fh, unsigned int deny_type)
 	struct nfs4_file *fp;
 	__be32 ret = nfs_ok;
 
-	fp = find_file(current_fh);
+	fp = find_nfs4_file(current_fh);
 	if (!fp)
 		return ret;
+
 	/* Check for conflicting share reservations */
 	spin_lock(&fp->fi_lock);
 	if (fp->fi_share_deny & deny_type)
@@ -5548,7 +5624,9 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	 * and check for delegations in the process of being recalled.
 	 * If not found, create the nfs4_file struct
 	 */
-	fp = find_or_add_file(open->op_file, current_fh);
+	fp = find_or_hash_nfs4_file(open->op_file, current_fh);
+	if (unlikely(!fp))
+		return nfserr_jukebox;
 	if (fp != open->op_file) {
 		status = nfs4_check_deleg(cl, open, &dp);
 		if (status)
@@ -7905,10 +7983,16 @@ nfs4_state_start(void)
 {
 	int ret;
 
-	ret = nfsd4_create_callback_queue();
+	ret = rhashtable_init(&nfs4_file_rhashtbl, &nfs4_file_rhash_params);
 	if (ret)
 		return ret;
 
+	ret = nfsd4_create_callback_queue();
+	if (ret) {
+		rhashtable_destroy(&nfs4_file_rhashtbl);
+		return ret;
+	}
+
 	set_max_delegations();
 	return 0;
 }
@@ -7939,6 +8023,7 @@ nfs4_state_shutdown_net(struct net *net)
 
 	nfsd4_client_tracking_exit(net);
 	nfs4_state_destroy_net(net);
+	rhashtable_destroy(&nfs4_file_rhashtbl);
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
 	nfsd4_ssc_shutdown_umount(nn);
 #endif
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index ae596dbf8667..879f085bc39e 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -536,16 +536,13 @@ struct nfs4_clnt_odstate {
  * inode can have multiple filehandles associated with it, so there is
  * (potentially) a many to one relationship between this struct and struct
  * inode.
- *
- * These are hashed by filehandle in the file_hashtbl, which is protected by
- * the global state_lock spinlock.
  */
 struct nfs4_file {
 	refcount_t		fi_ref;
 	struct inode *		fi_inode;
 	bool			fi_aliased;
 	spinlock_t		fi_lock;
-	struct hlist_node       fi_hash;	/* hash on fi_fhandle */
+	struct rhash_head	fi_rhash;
 	struct list_head        fi_stateids;
 	union {
 		struct list_head	fi_delegations;


