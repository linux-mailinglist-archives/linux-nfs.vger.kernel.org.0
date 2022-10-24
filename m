Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C4760BF6B
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Oct 2022 02:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiJYASW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 20:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbiJYAR4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 20:17:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C73833406
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 15:38:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69394615EB
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 22:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB87C433D7;
        Mon, 24 Oct 2022 22:38:15 +0000 (UTC)
Subject: [PATCH v5 13/13] NFSD: Use rhashtable for managing nfs4_file objects
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     neilb@suse.de
Date:   Mon, 24 Oct 2022 18:38:14 -0400
Message-ID: <166665109477.50761.4457095370494745929.stgit@klimt.1015granger.net>
In-Reply-To: <166664935937.50761.7812494396457965637.stgit@klimt.1015granger.net>
References: <166664935937.50761.7812494396457965637.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5.dev3+g9561319
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
data structures. Unfortunately, with common workloads, I see
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |   64 +++++++++++++++++++++++++--------------------------
 fs/nfsd/state.h     |    4 ---
 2 files changed, 31 insertions(+), 37 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 681cb2daa843..5b90e5a6a04f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -591,11 +591,8 @@ static void nfsd4_free_file_rcu(struct rcu_head *rcu)
 void
 put_nfs4_file(struct nfs4_file *fi)
 {
-	might_lock(&state_lock);
-
-	if (refcount_dec_and_lock(&fi->fi_ref, &state_lock)) {
+	if (refcount_dec_and_test(&fi->fi_ref)) {
 		remove_nfs4_file_locked(fi);
-		spin_unlock(&state_lock);
 		WARN_ON_ONCE(!list_empty(&fi->fi_clnt_odstate));
 		WARN_ON_ONCE(!list_empty(&fi->fi_delegations));
 		call_rcu(&fi->fi_rcu, nfsd4_free_file_rcu);
@@ -709,20 +706,6 @@ static unsigned int ownerstr_hashval(struct xdr_netobj *ownername)
 	return ret & OWNER_HASH_MASK;
 }
 
-/* hash table for nfs4_file */
-#define FILE_HASH_BITS                   8
-#define FILE_HASH_SIZE                  (1 << FILE_HASH_BITS)
-
-static unsigned int file_hashval(const struct svc_fh *fh)
-{
-	struct inode *inode = d_inode(fh->fh_dentry);
-
-	/* XXX: why not (here & in file cache) use inode? */
-	return (unsigned int)hash_long(inode->i_ino, FILE_HASH_BITS);
-}
-
-static struct hlist_head file_hashtbl[FILE_HASH_SIZE];
-
 static struct rhltable nfs4_file_rhltable ____cacheline_aligned_in_smp;
 
 static const struct rhashtable_params nfs4_file_rhash_params = {
@@ -4683,12 +4666,13 @@ move_to_close_lru(struct nfs4_ol_stateid *s, struct net *net)
 static noinline_for_stack struct nfs4_file *
 find_nfs4_file(const struct svc_fh *fhp)
 {
-	unsigned int hashval = file_hashval(fhp);
+	struct rhlist_head *tmp, *list;
 	struct nfs4_file *fi = NULL;
 
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(fi, &file_hashtbl[hashval], fi_hash,
-				 lockdep_is_held(&state_lock)) {
+	list = rhltable_lookup(&nfs4_file_rhltable, fhp,
+			       nfs4_file_rhash_params);
+	rhl_for_each_entry_rcu(fi, tmp, list, fi_rlist) {
 		if (fh_match(&fi->fi_fhandle, &fhp->fh_handle)) {
 			if (!refcount_inc_not_zero(&fi->fi_ref))
 				fi = NULL;
@@ -4708,33 +4692,45 @@ find_nfs4_file(const struct svc_fh *fhp)
 static noinline_for_stack struct nfs4_file *
 insert_nfs4_file(struct nfs4_file *new, const struct svc_fh *fhp)
 {
-	unsigned int hashval = file_hashval(fhp);
+	struct rhlist_head *tmp, *list;
 	struct nfs4_file *ret = NULL;
 	bool alias_found = false;
 	struct nfs4_file *fi;
+	int err;
 
-	spin_lock(&state_lock);
-	hlist_for_each_entry_rcu(fi, &file_hashtbl[hashval], fi_hash,
-				 lockdep_is_held(&state_lock)) {
+	rcu_read_lock();
+
+	list = rhltable_lookup(&nfs4_file_rhltable, fhp,
+			       nfs4_file_rhash_params);
+	rhl_for_each_entry_rcu(fi, tmp, list, fi_rlist) {
 		if (fh_match(&fi->fi_fhandle, &fhp->fh_handle)) {
 			if (refcount_inc_not_zero(&fi->fi_ref))
 				ret = fi;
 		} else if (d_inode(fhp->fh_dentry) == fi->fi_inode)
 			fi->fi_aliased = alias_found = true;
 	}
-	if (likely(ret == NULL)) {
-		init_nfs4_file(fhp, new);
-		hlist_add_head_rcu(&new->fi_hash, &file_hashtbl[hashval]);
-		new->fi_aliased = alias_found;
-		ret = new;
-	}
-	spin_unlock(&state_lock);
+	if (ret)
+		goto out_unlock;
+
+	init_nfs4_file(fhp, new);
+	err = rhltable_insert_key(&nfs4_file_rhltable, fhp,
+				  &new->fi_rlist,
+				  nfs4_file_rhash_params);
+	if (err)
+		goto out_unlock;
+
+	new->fi_aliased = alias_found;
+	ret = new;
+
+out_unlock:
+	rcu_read_unlock();
 	return ret;
 }
 
 static noinline_for_stack void remove_nfs4_file_locked(struct nfs4_file *fi)
 {
-	hlist_del_rcu(&fi->fi_hash);
+	rhltable_remove(&nfs4_file_rhltable, &fi->fi_rlist,
+			nfs4_file_rhash_params);
 }
 
 /*
@@ -5624,6 +5620,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	 * If not found, create the nfs4_file struct
 	 */
 	fp = insert_nfs4_file(open->op_file, current_fh);
+	if (unlikely(!fp))
+		return nfserr_jukebox;
 	if (fp != open->op_file) {
 		status = nfs4_check_deleg(cl, open, &dp);
 		if (status)
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 190fc7e418a4..eadd7f465bf5 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -536,16 +536,12 @@ struct nfs4_clnt_odstate {
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
 	struct rhlist_head	fi_rlist;
 	struct list_head        fi_stateids;
 	union {


