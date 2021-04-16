Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA00E362757
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Apr 2021 20:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243829AbhDPSAr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 16 Apr 2021 14:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbhDPSAr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 16 Apr 2021 14:00:47 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C5EC06175F
        for <linux-nfs@vger.kernel.org>; Fri, 16 Apr 2021 11:00:21 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id E4EBB6A45; Fri, 16 Apr 2021 14:00:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E4EBB6A45
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 2/5] nfsd: hash nfs4_files by inode number
Date:   Fri, 16 Apr 2021 14:00:15 -0400
Message-Id: <1618596018-9899-2-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1618596018-9899-1-git-send-email-bfields@redhat.com>
References: <1618596018-9899-1-git-send-email-bfields@redhat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

The nfs4_file structure is per-filehandle, not per-inode, because the
spec requires open and other state to be per filehandle.

But it will turn out to be convenient for nfs4_files associated with the
same inode to be hashed to the same bucket, so let's hash on the inode
instead of the filehandle.

Filehandle aliasing is rare, so that shouldn't have much performance
impact.

(If you have a ton of exported filesystems, though, and all of them have
a root with inode number 2, could that get you an overlong has chain?
Perhaps this (and the v4 open file cache) should be hashed on the inode
pointer instead.)

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 27 ++++++++++++---------------
 fs/nfsd/state.h     |  1 -
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 886e50ed07c2..b0c74dbde07b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -542,14 +542,12 @@ static unsigned int ownerstr_hashval(struct xdr_netobj *ownername)
 #define FILE_HASH_BITS                   8
 #define FILE_HASH_SIZE                  (1 << FILE_HASH_BITS)
 
-static unsigned int nfsd_fh_hashval(struct knfsd_fh *fh)
+static unsigned int file_hashval(struct svc_fh *fh)
 {
-	return jhash2(fh->fh_base.fh_pad, XDR_QUADLEN(fh->fh_size), 0);
-}
+	struct inode *inode = d_inode(fh->fh_dentry);
 
-static unsigned int file_hashval(struct knfsd_fh *fh)
-{
-	return nfsd_fh_hashval(fh) & (FILE_HASH_SIZE - 1);
+	/* XXX: why not (here & in file cache) use inode? */
+	return (unsigned int)hash_long(inode->i_ino, FILE_HASH_SIZE);
 }
 
 static struct hlist_head file_hashtbl[FILE_HASH_SIZE];
@@ -4061,7 +4059,7 @@ static struct nfs4_file *nfsd4_alloc_file(void)
 }
 
 /* OPEN Share state helper functions */
-static void nfsd4_init_file(struct knfsd_fh *fh, unsigned int hashval,
+static void nfsd4_init_file(struct svc_fh *fh, unsigned int hashval,
 				struct nfs4_file *fp)
 {
 	lockdep_assert_held(&state_lock);
@@ -4071,7 +4069,7 @@ static void nfsd4_init_file(struct knfsd_fh *fh, unsigned int hashval,
 	INIT_LIST_HEAD(&fp->fi_stateids);
 	INIT_LIST_HEAD(&fp->fi_delegations);
 	INIT_LIST_HEAD(&fp->fi_clnt_odstate);
-	fh_copy_shallow(&fp->fi_fhandle, fh);
+	fh_copy_shallow(&fp->fi_fhandle, &fh->fh_handle);
 	fp->fi_deleg_file = NULL;
 	fp->fi_had_conflict = false;
 	fp->fi_share_deny = 0;
@@ -4415,13 +4413,13 @@ move_to_close_lru(struct nfs4_ol_stateid *s, struct net *net)
 
 /* search file_hashtbl[] for file */
 static struct nfs4_file *
-find_file_locked(struct knfsd_fh *fh, unsigned int hashval)
+find_file_locked(struct svc_fh *fh, unsigned int hashval)
 {
 	struct nfs4_file *fp;
 
 	hlist_for_each_entry_rcu(fp, &file_hashtbl[hashval], fi_hash,
 				lockdep_is_held(&state_lock)) {
-		if (fh_match(&fp->fi_fhandle, fh)) {
+		if (fh_match(&fp->fi_fhandle, &fh->fh_handle)) {
 			if (refcount_inc_not_zero(&fp->fi_ref))
 				return fp;
 		}
@@ -4429,8 +4427,7 @@ find_file_locked(struct knfsd_fh *fh, unsigned int hashval)
 	return NULL;
 }
 
-struct nfs4_file *
-find_file(struct knfsd_fh *fh)
+static struct nfs4_file * find_file(struct svc_fh *fh)
 {
 	struct nfs4_file *fp;
 	unsigned int hashval = file_hashval(fh);
@@ -4442,7 +4439,7 @@ find_file(struct knfsd_fh *fh)
 }
 
 static struct nfs4_file *
-find_or_add_file(struct nfs4_file *new, struct knfsd_fh *fh)
+find_or_add_file(struct nfs4_file *new, struct svc_fh *fh)
 {
 	struct nfs4_file *fp;
 	unsigned int hashval = file_hashval(fh);
@@ -4474,7 +4471,7 @@ nfs4_share_conflict(struct svc_fh *current_fh, unsigned int deny_type)
 	struct nfs4_file *fp;
 	__be32 ret = nfs_ok;
 
-	fp = find_file(&current_fh->fh_handle);
+	fp = find_file(current_fh);
 	if (!fp)
 		return ret;
 	/* Check for conflicting share reservations */
@@ -5155,7 +5152,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	 * and check for delegations in the process of being recalled.
 	 * If not found, create the nfs4_file struct
 	 */
-	fp = find_or_add_file(open->op_file, &current_fh->fh_handle);
+	fp = find_or_add_file(open->op_file, current_fh);
 	if (fp != open->op_file) {
 		status = nfs4_check_deleg(cl, open, &dp);
 		if (status)
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 73deea353169..af1d9f2e373e 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -665,7 +665,6 @@ extern struct nfs4_client_reclaim *nfs4_client_to_reclaim(struct xdr_netobj name
 				struct xdr_netobj princhash, struct nfsd_net *nn);
 extern bool nfs4_has_reclaimed_state(struct xdr_netobj name, struct nfsd_net *nn);
 
-struct nfs4_file *find_file(struct knfsd_fh *fh);
 void put_nfs4_file(struct nfs4_file *fi);
 extern void nfs4_put_copy(struct nfsd4_copy *copy);
 extern struct nfsd4_copy *
-- 
2.30.2

