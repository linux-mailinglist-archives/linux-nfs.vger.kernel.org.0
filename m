Return-Path: <linux-nfs+bounces-2850-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B61988A75BF
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Apr 2024 22:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42FD01F22652
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Apr 2024 20:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6982D376E5;
	Tue, 16 Apr 2024 20:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsNZUelp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E522AF02;
	Tue, 16 Apr 2024 20:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713299622; cv=none; b=dbTI+M/G2mhOO10vi2fnD73ThTa5jh3T7zncYngsmwANT1FNsoy9bH8/pw9+tqg7NKRMg7EbweDDylGee8wEr6+/r1jnYsd/vmjqrmT7k21vx9WXaHYFcO/UUVJ4fVRD4LxxTH//zLQw6YAO9/mtMHvNCBED9IfcHKd/twYpXR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713299622; c=relaxed/simple;
	bh=eXSPYBxn/l0S9sMtImb1xGWJp1lG0mtVRN4XUUEEJAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jVRKaAomz0A3/7kfU1LWwh3/gcHymL5se9JT2p8CvqkExl1EN8YpmE/ngvcrimVhoBo3nL2fleQLY6RMBSG1E+uvlQVGNVgDA3WElSP8Ew7qb4UBKh197ZcSk7Tf9TD9VkPP0uep2XzxDb88xWRscABjHwZfTIU1c3UCtnQW0cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsNZUelp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7F5C3277B;
	Tue, 16 Apr 2024 20:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713299620;
	bh=eXSPYBxn/l0S9sMtImb1xGWJp1lG0mtVRN4XUUEEJAk=;
	h=From:To:Cc:Subject:Date:From;
	b=gsNZUelpP2j1WUWxiS1tQJEM//Aasq1+7B7GoqKe4j8VTIOqwU9uewx4Lj/j4u8n8
	 Yyid7TaF/jYWt7+UuPdzEPZgvS0NGvgTPRFBeXxlCBlIgbiDKV3+MvxvDncGlyeI/d
	 oc3f6mSUJwUdD5ZX5IkKRmQPWkG0jOLU+0D8mOKrqNU0B/t1SY8cJ+tHn6lYxyw0+r
	 kY/RTp8+VWXIaboAguAnKW6s5Nv5cvDMVfZ5pfLEsGf4y4VWTTqR+R5DsutWbTYTJg
	 A+fHq9a7w6sF6xxigfovCHqH+hUo4/jooMD7r0a/zl3fAFarOIMfolnZTuxKpLFJK9
	 /TbYbhgpXdNyw==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH] Revert 2267b2e84593bd3d61a1188e68fba06307fa9dab
Date: Tue, 16 Apr 2024 16:33:37 -0400
Message-ID: <20240416203337.10248-1-cel@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

ltp test fcntl17 fails on v5.15.154. This was bisected to commit
2267b2e84593 ("lockd: introduce safe async lock op").

Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 Documentation/filesystems/nfs/exporting.rst |  7 -------
 fs/lockd/svclock.c                          |  4 +++-
 fs/nfsd/nfs4state.c                         | 10 +++-------
 include/linux/exportfs.h                    | 14 --------------
 4 files changed, 6 insertions(+), 29 deletions(-)

diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
index 6a1cbd7de38d..6f59a364f84c 100644
--- a/Documentation/filesystems/nfs/exporting.rst
+++ b/Documentation/filesystems/nfs/exporting.rst
@@ -241,10 +241,3 @@ following flags are defined:
     all of an inode's dirty data on last close. Exports that behave this
     way should set EXPORT_OP_FLUSH_ON_CLOSE so that NFSD knows to skip
     waiting for writeback when closing such files.
-
-  EXPORT_OP_ASYNC_LOCK - Indicates a capable filesystem to do async lock
-    requests from lockd. Only set EXPORT_OP_ASYNC_LOCK if the filesystem has
-    it's own ->lock() functionality as core posix_lock_file() implementation
-    has no async lock request handling yet. For more information about how to
-    indicate an async lock request from a ->lock() file_operations struct, see
-    fs/locks.c and comment for the function vfs_lock_file().
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 55c0a0331188..4e30f3c50970 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -470,7 +470,9 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 	    struct nlm_host *host, struct nlm_lock *lock, int wait,
 	    struct nlm_cookie *cookie, int reclaim)
 {
+#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 	struct inode		*inode = nlmsvc_file_inode(file);
+#endif
 	struct nlm_block	*block = NULL;
 	int			error;
 	int			mode;
@@ -484,7 +486,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 				(long long)lock->fl.fl_end,
 				wait);
 
-	if (!exportfs_lock_op_is_async(inode->i_sb->s_export_op)) {
+	if (nlmsvc_file_file(file)->f_op->lock) {
 		async_block = wait;
 		wait = 0;
 	}
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 40b5b226e504..d07176eee935 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7420,7 +7420,6 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_blocked_lock *nbl = NULL;
 	struct file_lock *file_lock = NULL;
 	struct file_lock *conflock = NULL;
-	struct super_block *sb;
 	__be32 status = 0;
 	int lkflg;
 	int err;
@@ -7442,7 +7441,6 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		dprintk("NFSD: nfsd4_lock: permission denied!\n");
 		return status;
 	}
-	sb = cstate->current_fh.fh_dentry->d_sb;
 
 	if (lock->lk_is_new) {
 		if (nfsd4_has_session(cstate))
@@ -7494,8 +7492,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	fp = lock_stp->st_stid.sc_file;
 	switch (lock->lk_type) {
 		case NFS4_READW_LT:
-			if (nfsd4_has_session(cstate) ||
-			    exportfs_lock_op_is_async(sb->s_export_op))
+			if (nfsd4_has_session(cstate))
 				fl_flags |= FL_SLEEP;
 			fallthrough;
 		case NFS4_READ_LT:
@@ -7507,8 +7504,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			fl_type = F_RDLCK;
 			break;
 		case NFS4_WRITEW_LT:
-			if (nfsd4_has_session(cstate) ||
-			    exportfs_lock_op_is_async(sb->s_export_op))
+			if (nfsd4_has_session(cstate))
 				fl_flags |= FL_SLEEP;
 			fallthrough;
 		case NFS4_WRITE_LT:
@@ -7536,7 +7532,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 * for file locks), so don't attempt blocking lock notifications
 	 * on those filesystems:
 	 */
-	if (!exportfs_lock_op_is_async(sb->s_export_op))
+	if (nf->nf_file->f_op->lock)
 		fl_flags &= ~FL_SLEEP;
 
 	nbl = find_or_allocate_block(lock_sop, &fp->fi_fhandle, nn);
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 6525f4b7eb97..218fc5c54e90 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -222,23 +222,9 @@ struct export_operations {
 						  atomic attribute updates
 						*/
 #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
-#define EXPORT_OP_ASYNC_LOCK		(0x40) /* fs can do async lock request */
 	unsigned long	flags;
 };
 
-/**
- * exportfs_lock_op_is_async() - export op supports async lock operation
- * @export_ops:	the nfs export operations to check
- *
- * Returns true if the nfs export_operations structure has
- * EXPORT_OP_ASYNC_LOCK in their flags set
- */
-static inline bool
-exportfs_lock_op_is_async(const struct export_operations *export_ops)
-{
-	return export_ops->flags & EXPORT_OP_ASYNC_LOCK;
-}
-
 extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
 				    int *max_len, struct inode *parent);
 extern int exportfs_encode_fh(struct dentry *dentry, struct fid *fid,
-- 
2.44.0


