Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3E8601280
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Oct 2022 17:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJQPLS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Oct 2022 11:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJQPLL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Oct 2022 11:11:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECED19C18
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 08:11:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26BD2B80D42
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 15:02:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F9BC433C1;
        Mon, 17 Oct 2022 15:02:48 +0000 (UTC)
Subject: [PATCH v3 5/7] NFSD: Use rhashtable for managing nfs4_file objects
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     neilb@suse.de
Date:   Mon, 17 Oct 2022 11:02:47 -0400
Message-ID: <166601896774.1714.13588888415522640611.stgit@manet.1015granger.net>
In-Reply-To: <166601838800.1714.17970169995665888062.stgit@manet.1015granger.net>
References: <166601838800.1714.17970169995665888062.stgit@manet.1015granger.net>
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

fh_match() is costly, especially when filehandles are large (as is
the case for NFSv4). It needs to be used sparingly when searching
data structures. Unfortunately, With common workloads, I see
multiple thousands of objects stored in file_hashtbl[], which always
has only 256 buckets, which makes the hash chains quite lengthy.

Walking long hash chains with the state_lock held blocks other
activity that needs that lock.

To help mitigate the cost of searching with fh_match(), replace the
nfs4_file hash table with an rhashtable, which can dynamically
resize its bucket array to minimize hash chain length. The ideal for
this use case is one bucket per inode.

The result is an improvement in the latency of NFSv4 operations
and the reduction of nfsd CPU utilization due to the cost of
fh_match() and the CPU cache misses incurred while walking long
hash chains in the nfs4_file hash table.

Note that hash removal is no longer protected by the state_lock.
This is because insert_nfs4_file() takes the RCU read lock then the
state_lock. rhltable_remove() takes the RCU read lock internally;
if remove_nfs4_file() took the state_lock before calling
rhltable_remove(), that would result in a lock inversion.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |  214 +++++++++++++++++++++++++++++++++++----------------
 fs/nfsd/state.h     |    5 -
 2 files changed, 146 insertions(+), 73 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2b850de288cf..9ebf99498647 100644
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
+static void remove_nfs4_file(struct nfs4_file *fi);
 
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
+		remove_nfs4_file(fi);
 		WARN_ON_ONCE(!list_empty(&fi->fi_clnt_odstate));
 		WARN_ON_ONCE(!list_empty(&fi->fi_delegations));
 		call_rcu(&fi->fi_rcu, nfsd4_free_file_rcu);
@@ -695,19 +695,82 @@ static unsigned int ownerstr_hashval(struct xdr_netobj *ownername)
 	return ret & OWNER_HASH_MASK;
 }
 
-/* hash table for nfs4_file */
-#define FILE_HASH_BITS                   8
-#define FILE_HASH_SIZE                  (1 << FILE_HASH_BITS)
+static struct rhltable nfs4_file_rhltable ____cacheline_aligned_in_smp;
+
+/*
+ * The returned hash value is based solely on the address of an in-code
+ * inode, a pointer to a slab-allocated object. The entropy in such a
+ * pointer is concentrated in its middle bits.
+ */
+static u32 nfs4_file_inode_hash(const struct inode *inode, u32 seed)
+{
+	u32 k;
+
+	k = ((unsigned long)inode) >> L1_CACHE_SHIFT;
+	return jhash2(&k, 1, seed);
+}
 
-static unsigned int file_hashval(struct svc_fh *fh)
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
+ *   %0 - Success; item matches search criteria
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
@@ -4251,11 +4314,8 @@ static struct nfs4_file *nfsd4_alloc_file(void)
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
@@ -4273,7 +4333,6 @@ static void nfsd4_init_file(struct svc_fh *fh, unsigned int hashval,
 	INIT_LIST_HEAD(&fp->fi_lo_states);
 	atomic_set(&fp->fi_lo_recalls, 0);
 #endif
-	hlist_add_head_rcu(&fp->fi_hash, &file_hashtbl[hashval]);
 }
 
 void
@@ -4626,71 +4685,74 @@ move_to_close_lru(struct nfs4_ol_stateid *s, struct net *net)
 		nfs4_put_stid(&last->st_stid);
 }
 
-/* search file_hashtbl[] for file */
-static struct nfs4_file *
-find_file_locked(struct svc_fh *fh, unsigned int hashval)
+static struct nfs4_file *find_nfs4_file(const struct svc_fh *fhp)
 {
-	struct nfs4_file *fp;
+	struct rhlist_head *tmp, *list;
+	struct nfs4_file *fi = NULL;
 
-	hlist_for_each_entry_rcu(fp, &file_hashtbl[hashval], fi_hash,
-				lockdep_is_held(&state_lock)) {
-		if (fh_match(&fp->fi_fhandle, &fh->fh_handle)) {
-			if (refcount_inc_not_zero(&fp->fi_ref))
-				return fp;
+	list = rhltable_lookup(&nfs4_file_rhltable, fhp,
+			       nfs4_file_rhash_params);
+	rhl_for_each_entry_rcu(fi, tmp, list, fi_rhash)
+		if (fh_match(&fi->fi_fhandle, &fhp->fh_handle)) {
+			if (!refcount_inc_not_zero(&fi->fi_ref))
+				fi = NULL;
+			break;
 		}
-	}
-	return NULL;
+	return fi;
 }
 
-static struct nfs4_file *insert_file(struct nfs4_file *new, struct svc_fh *fh,
-				     unsigned int hashval)
+/*
+ * On hash insertion, identify entries with the same inode but
+ * distinct filehandles. They will all be in the same hash bucket
+ * because we hash by the address of the nfs4_file's struct inode.
+ */
+static struct nfs4_file *insert_file(struct nfs4_file *new,
+				     const struct svc_fh *fhp)
 {
-	struct nfs4_file *fp;
-	struct nfs4_file *ret = NULL;
-	bool alias_found = false;
+	struct rhlist_head *tmp, *list;
+	struct nfs4_file *fi;
+	int err;
 
 	spin_lock(&state_lock);
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
+
+	err = rhltable_insert_key(&nfs4_file_rhltable, fhp,
+				  &new->fi_rhash,
+				  nfs4_file_rhash_params);
+	if (err) {
+		spin_unlock(&state_lock);
+		return NULL;
 	}
+
+	list = rhltable_lookup(&nfs4_file_rhltable, fhp,
+			       nfs4_file_rhash_params);
+	rhl_for_each_entry_rcu(fi, tmp, list, fi_rhash)
+		if (!fh_match(&fi->fi_fhandle, &fhp->fh_handle)) {
+			fi->fi_aliased = true;
+			new->fi_aliased = true;
+		}
+
 	spin_unlock(&state_lock);
-	return ret;
+	return new;
 }
 
-static struct nfs4_file * find_file(struct svc_fh *fh)
+static noinline struct nfs4_file *
+insert_nfs4_file(struct nfs4_file *new, const struct svc_fh *fhp)
 {
-	struct nfs4_file *fp;
-	unsigned int hashval = file_hashval(fh);
+	struct nfs4_file *fi;
 
-	rcu_read_lock();
-	fp = find_file_locked(fh, hashval);
-	rcu_read_unlock();
-	return fp;
+	/* Do not hash the same filehandle more than once */
+	fi = find_nfs4_file(fhp);
+	if (unlikely(fi))
+		return fi;
+
+	init_nfs4_file(fhp, new);
+	return insert_file(new, fhp);
 }
 
-static struct nfs4_file *
-find_or_add_file(struct nfs4_file *new, struct svc_fh *fh)
+static noinline void remove_nfs4_file(struct nfs4_file *fi)
 {
-	struct nfs4_file *fp;
-	unsigned int hashval = file_hashval(fh);
-
-	rcu_read_lock();
-	fp = find_file_locked(fh, hashval);
-	rcu_read_unlock();
-	if (fp)
-		return fp;
-
-	return insert_file(new, fh, hashval);
+	rhltable_remove(&nfs4_file_rhltable, &fi->fi_rhash,
+			nfs4_file_rhash_params);
 }
 
 /*
@@ -4703,9 +4765,12 @@ nfs4_share_conflict(struct svc_fh *current_fh, unsigned int deny_type)
 	struct nfs4_file *fp;
 	__be32 ret = nfs_ok;
 
-	fp = find_file(current_fh);
+	rcu_read_lock();
+	fp = find_nfs4_file(current_fh);
+	rcu_read_unlock();
 	if (!fp)
 		return ret;
+
 	/* Check for conflicting share reservations */
 	spin_lock(&fp->fi_lock);
 	if (fp->fi_share_deny & deny_type)
@@ -5548,7 +5613,11 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	 * and check for delegations in the process of being recalled.
 	 * If not found, create the nfs4_file struct
 	 */
-	fp = find_or_add_file(open->op_file, current_fh);
+	rcu_read_lock();
+	fp = insert_nfs4_file(open->op_file, current_fh);
+	rcu_read_unlock();
+	if (unlikely(!fp))
+		return nfserr_jukebox;
 	if (fp != open->op_file) {
 		status = nfs4_check_deleg(cl, open, &dp);
 		if (status)
@@ -7905,10 +7974,16 @@ nfs4_state_start(void)
 {
 	int ret;
 
-	ret = nfsd4_create_callback_queue();
+	ret = rhltable_init(&nfs4_file_rhltable, &nfs4_file_rhash_params);
 	if (ret)
 		return ret;
 
+	ret = nfsd4_create_callback_queue();
+	if (ret) {
+		rhltable_destroy(&nfs4_file_rhltable);
+		return ret;
+	}
+
 	set_max_delegations();
 	return 0;
 }
@@ -7939,6 +8014,7 @@ nfs4_state_shutdown_net(struct net *net)
 
 	nfsd4_client_tracking_exit(net);
 	nfs4_state_destroy_net(net);
+	rhltable_destroy(&nfs4_file_rhltable);
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
 	nfsd4_ssc_shutdown_umount(nn);
 #endif
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index ae596dbf8667..ad20467c9dee 100644
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
+	struct rhlist_head	fi_rhash;
 	struct list_head        fi_stateids;
 	union {
 		struct list_head	fi_delegations;


