Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2724477A72
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Dec 2021 18:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235896AbhLPRUO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Dec 2021 12:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbhLPRUO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Dec 2021 12:20:14 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F819C061574
        for <linux-nfs@vger.kernel.org>; Thu, 16 Dec 2021 09:20:14 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 5546D6CDC; Thu, 16 Dec 2021 12:20:13 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 5546D6CDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1639675213;
        bh=YpTeEzxHCHZobKO5Pt4GJ4WQ8La4TjjrObY3ucHLLlQ=;
        h=Date:To:Cc:Subject:From:From;
        b=rFpyf+YsZtGtbxnpF29n7DlGrys0fdjDZlWU9UXYZGVXvjfYBXKLfFS8t7ha+Td1n
         QwOo9KBlew0bheOhVrlszFdds0rNrNOdPSmiD27BauMsQI2MNSLYl8lD1XGRp6vSg+
         2ihgnNAN4ss2zEE0+KOxgJ2mKIfV6PzIZmSdgTn0=
Date:   Thu, 16 Dec 2021 12:20:13 -0500
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Jeff Layton <jlayton@kernel.org>,
        "Denis V. Lunev" <den@virtuozzo.com>,
        Cyrill Gorcunov <gorcunov@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: [PATCH] nfs: block notification on fs with its own ->lock
Message-ID: <20211216172013.GA13418@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

NFSv4.1 supports an optional lock notification feature which notifies
the client when a lock comes available.  (Normally NFSv4 clients just
poll for locks if necessary.)  To make that work, we need to request a
blocking lock from the filesystem.

We turned that off for NFS in f657f8eef3ff "nfs: don't atempt blocking
locks on nfs reexports" because it actually blocks the nfsd thread while
waiting for the lock.

Thanks to Vasily Averin for pointing out that NFS isn't the only
filesystem with that problem.

Any filesystem that leaves ->lock NULL will use posix_lock_file(), which
does the right thing.  Simplest is just to assume that any filesystem
that defines its own ->lock is not safe to request a blocking lock from.

So, this patch mostly reverts f657f8eef3ff and b840be2f00c0, and instead
uses a check of ->lock (Vasily's suggestion) to decide whether to
support blocking lock notifications on a given filesystem.  Also add a
little documentation.

Perhaps someday we could add back an export flag later to allow
filesystems with "good" ->lock methods to support blocking lock
notifications.

Reported-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/lockd/svclock.c          |  2 +-
 fs/nfs/export.c             |  2 +-
 fs/nfsd/nfs4state.c         | 18 ++++++++++++------
 include/linux/exportfs.h    |  2 --
 include/linux/lockd/lockd.h |  9 +++++++--
 5 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index e9b85d8fd5fe..98e2f9b32e21 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -484,7 +484,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 				(long long)lock->fl.fl_end,
 				wait);
 
-	if (inode->i_sb->s_export_op->flags & EXPORT_OP_SYNC_LOCKS) {
+	if (nlmsvc_file_file(file)->f_op->lock) {
 		async_block = wait;
 		wait = 0;
 	}
diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index 171c424cb6d5..01596f2d0a1e 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -158,5 +158,5 @@ const struct export_operations nfs_export_ops = {
 	.fetch_iversion = nfs_fetch_iversion,
 	.flags = EXPORT_OP_NOWCC|EXPORT_OP_NOSUBTREECHK|
 		EXPORT_OP_CLOSE_BEFORE_UNLINK|EXPORT_OP_REMOTE_FS|
-		EXPORT_OP_NOATOMIC_ATTR|EXPORT_OP_SYNC_LOCKS,
+		EXPORT_OP_NOATOMIC_ATTR,
 };
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 1956d377d1a6..3317493d2750 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6836,7 +6836,6 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_blocked_lock *nbl = NULL;
 	struct file_lock *file_lock = NULL;
 	struct file_lock *conflock = NULL;
-	struct super_block *sb;
 	__be32 status = 0;
 	int lkflg;
 	int err;
@@ -6858,7 +6857,6 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		dprintk("NFSD: nfsd4_lock: permission denied!\n");
 		return status;
 	}
-	sb = cstate->current_fh.fh_dentry->d_sb;
 
 	if (lock->lk_is_new) {
 		if (nfsd4_has_session(cstate))
@@ -6910,8 +6908,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	fp = lock_stp->st_stid.sc_file;
 	switch (lock->lk_type) {
 		case NFS4_READW_LT:
-			if (nfsd4_has_session(cstate) &&
-			    !(sb->s_export_op->flags & EXPORT_OP_SYNC_LOCKS))
+			if (nfsd4_has_session(cstate))
 				fl_flags |= FL_SLEEP;
 			fallthrough;
 		case NFS4_READ_LT:
@@ -6923,8 +6920,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			fl_type = F_RDLCK;
 			break;
 		case NFS4_WRITEW_LT:
-			if (nfsd4_has_session(cstate) &&
-			    !(sb->s_export_op->flags & EXPORT_OP_SYNC_LOCKS))
+			if (nfsd4_has_session(cstate))
 				fl_flags |= FL_SLEEP;
 			fallthrough;
 		case NFS4_WRITE_LT:
@@ -6940,6 +6936,16 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto out;
 	}
 
+	/*
+	 * Most filesystems with their own ->lock operations will block
+	 * the nfsd thread waiting to acquire the lock.  That leads to
+	 * deadlocks (we don't want every nfsd thread tied up waiting
+	 * for file locks), so don't attempt blocking lock notifications
+	 * on those filesystems:
+	 */
+	if (nf->nf_file->f_op->lock)
+		fl_flags &= ~FL_SLEEP;
+
 	if (!nf) {
 		status = nfserr_openmode;
 		goto out;
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 3260fe714846..fe848901fcc3 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -221,8 +221,6 @@ struct export_operations {
 #define EXPORT_OP_NOATOMIC_ATTR		(0x10) /* Filesystem cannot supply
 						  atomic attribute updates
 						*/
-#define EXPORT_OP_SYNC_LOCKS		(0x20) /* Filesystem can't do
-						  asychronous blocking locks */
 	unsigned long	flags;
 };
 
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index c4ae6506b8b3..fcef192e5e45 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -303,10 +303,15 @@ void		  nlmsvc_invalidate_all(void);
 int           nlmsvc_unlock_all_by_sb(struct super_block *sb);
 int           nlmsvc_unlock_all_by_ip(struct sockaddr *server_addr);
 
+static inline struct file *nlmsvc_file_file(struct nlm_file *file)
+{
+	return file->f_file[O_RDONLY] ?
+	       file->f_file[O_RDONLY] : file->f_file[O_WRONLY];
+}
+
 static inline struct inode *nlmsvc_file_inode(struct nlm_file *file)
 {
-	return locks_inode(file->f_file[O_RDONLY] ?
-			   file->f_file[O_RDONLY] : file->f_file[O_WRONLY]);
+	return locks_inode(nlmsvc_file_file(file));
 }
 
 static inline int __nlm_privileged_request4(const struct sockaddr *sap)
-- 
2.33.1

