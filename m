Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B053ED85F
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Aug 2021 16:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhHPOBJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Aug 2021 10:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbhHPOAX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Aug 2021 10:00:23 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9E6C0612A5
        for <linux-nfs@vger.kernel.org>; Mon, 16 Aug 2021 06:59:30 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 681527C62; Mon, 16 Aug 2021 09:59:28 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 681527C62
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>
Cc:     daire@dneg.com, linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 6/8] nfs: don't atempt blocking locks on nfs reexports
Date:   Mon, 16 Aug 2021 09:59:25 -0400
Message-Id: <1629122367-18541-7-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1629122367-18541-1-git-send-email-bfields@redhat.com>
References: <1629122367-18541-1-git-send-email-bfields@redhat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

NFS implements blocking locks by blocking inside its lock method.  In
the reexport case, this blocks the nfs server thread, which could lead
to deadlocks since an nfs server thread might be required to unlock the
conflicting lock.  It also causes a crash, since the nfs server thread
assumes it can free the lock when its lm_notify lock callback is called.

Ideal would be to make the nfs lock method return without blocking in
this case, but for now it works just not to attempt blocking locks.  The
difference is just that the original client will have to poll (as it
does in the v4.0 case) instead of getting a callback when the lock's
available.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfs/export.c          | 2 +-
 fs/nfsd/nfs4state.c      | 8 ++++++--
 include/linux/exportfs.h | 2 ++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index 37a1a88df771..d772c20bbfd1 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -180,5 +180,5 @@ const struct export_operations nfs_export_ops = {
 	.fetch_iversion = nfs_fetch_iversion,
 	.flags = EXPORT_OP_NOWCC|EXPORT_OP_NOSUBTREECHK|
 		EXPORT_OP_CLOSE_BEFORE_UNLINK|EXPORT_OP_REMOTE_FS|
-		EXPORT_OP_NOATOMIC_ATTR,
+		EXPORT_OP_NOATOMIC_ATTR|EXPORT_OP_SYNC_LOCKS,
 };
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index fa67ecd5fe63..bebe86cce7c7 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6835,6 +6835,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_blocked_lock *nbl = NULL;
 	struct file_lock *file_lock = NULL;
 	struct file_lock *conflock = NULL;
+	struct super_block *sb;
 	__be32 status = 0;
 	int lkflg;
 	int err;
@@ -6856,6 +6857,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		dprintk("NFSD: nfsd4_lock: permission denied!\n");
 		return status;
 	}
+	sb = cstate->current_fh.fh_dentry->d_sb;
 
 	if (lock->lk_is_new) {
 		if (nfsd4_has_session(cstate))
@@ -6904,7 +6906,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	fp = lock_stp->st_stid.sc_file;
 	switch (lock->lk_type) {
 		case NFS4_READW_LT:
-			if (nfsd4_has_session(cstate))
+			if (nfsd4_has_session(cstate) &&
+			    !(sb->s_export_op->flags & EXPORT_OP_SYNC_LOCKS))
 				fl_flags |= FL_SLEEP;
 			fallthrough;
 		case NFS4_READ_LT:
@@ -6916,7 +6919,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			fl_type = F_RDLCK;
 			break;
 		case NFS4_WRITEW_LT:
-			if (nfsd4_has_session(cstate))
+			if (nfsd4_has_session(cstate) &&
+			    !(sb->s_export_op->flags & EXPORT_OP_SYNC_LOCKS))
 				fl_flags |= FL_SLEEP;
 			fallthrough;
 		case NFS4_WRITE_LT:
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index fe848901fcc3..3260fe714846 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -221,6 +221,8 @@ struct export_operations {
 #define EXPORT_OP_NOATOMIC_ATTR		(0x10) /* Filesystem cannot supply
 						  atomic attribute updates
 						*/
+#define EXPORT_OP_SYNC_LOCKS		(0x20) /* Filesystem can't do
+						  asychronous blocking locks */
 	unsigned long	flags;
 };
 
-- 
2.31.1

