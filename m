Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384093F35D4
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Aug 2021 23:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240308AbhHTVCz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Aug 2021 17:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240286AbhHTVCs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Aug 2021 17:02:48 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C7AC061764
        for <linux-nfs@vger.kernel.org>; Fri, 20 Aug 2021 14:02:10 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 977BB5BAF; Fri, 20 Aug 2021 17:02:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 977BB5BAF
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>
Cc:     daire@dneg.com, linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 7/8] lockd: don't attempt blocking locks on nfs reexports
Date:   Fri, 20 Aug 2021 17:02:05 -0400
Message-Id: <1629493326-28336-8-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1629493326-28336-1-git-send-email-bfields@redhat.com>
References: <1629493326-28336-1-git-send-email-bfields@redhat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

As in the v4 case, it doesn't work well to block waiting for a lock on
an nfs filesystem.

As in the v4 case, that means we're depending on the client to poll.
It's probably incorrect to depend on that, but I *think* clients do poll
in practice.  In any case, it's an improvement over hanging the lockd
thread indefinitely as we currently are.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/lockd/svclock.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index d60e6eea2d57..c99acefb9ec9 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -31,6 +31,7 @@
 #include <linux/lockd/nlm.h>
 #include <linux/lockd/lockd.h>
 #include <linux/kthread.h>
+#include <linux/exportfs.h>
 
 #define NLMDBG_FACILITY		NLMDBG_SVCLOCK
 
@@ -470,18 +471,24 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 	    struct nlm_cookie *cookie, int reclaim)
 {
 	struct nlm_block	*block = NULL;
+	struct inode		*inode = nlmsvc_file_inode(file);
 	int			error;
 	int			mode;
+	int			async_block = 0;
 	__be32			ret;
 
 	dprintk("lockd: nlmsvc_lock(%s/%ld, ty=%d, pi=%d, %Ld-%Ld, bl=%d)\n",
-				nlmsvc_file_inode(file)->i_sb->s_id,
-				nlmsvc_file_inode(file)->i_ino,
+				inode->i_sb->s_id, inode->i_ino,
 				lock->fl.fl_type, lock->fl.fl_pid,
 				(long long)lock->fl.fl_start,
 				(long long)lock->fl.fl_end,
 				wait);
 
+	if (inode->i_sb->s_export_op->flags & EXPORT_OP_SYNC_LOCKS) {
+		async_block = wait;
+		wait = 0;
+	}
+
 	/* Lock file against concurrent access */
 	mutex_lock(&file->f_mutex);
 	/* Get existing block (in case client is busy-waiting)
@@ -542,7 +549,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 			 */
 			if (wait)
 				break;
-			ret = nlm_lck_denied;
+			ret = async_block ? nlm_lck_blocked : nlm_lck_denied;
 			goto out;
 		case FILE_LOCK_DEFERRED:
 			if (wait)
-- 
2.31.1

