Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECA13ED849
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Aug 2021 16:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhHPOAu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Aug 2021 10:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbhHPOAX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Aug 2021 10:00:23 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E716DC06129F
        for <linux-nfs@vger.kernel.org>; Mon, 16 Aug 2021 06:59:30 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 89995620D; Mon, 16 Aug 2021 09:59:28 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 89995620D
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>
Cc:     daire@dneg.com, linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 8/8] nfs: don't allow reexport reclaims
Date:   Mon, 16 Aug 2021 09:59:27 -0400
Message-Id: <1629122367-18541-9-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1629122367-18541-1-git-send-email-bfields@redhat.com>
References: <1629122367-18541-1-git-send-email-bfields@redhat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

In the reexport case, nfsd is currently passing along locks with the
reclaim bit set.  The client sends a new lock request, which is granted
if there's currently no conflict--even if it's possible a conflicting
lock could have been briefly held in the interim.

We don't currently have any way to safely grant reclaim, so for now
let's just deny them all.

I'm doing this by passing the reclaim bit to nfs and letting it fail the
call, with the idea that eventually the client might be able to do
something more forgiving here.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfs/file.c         | 3 +++
 fs/nfsd/nfs4state.c   | 3 +++
 fs/nfsd/nfsproc.c     | 1 +
 include/linux/errno.h | 1 +
 include/linux/fs.h    | 1 +
 5 files changed, 9 insertions(+)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 1fef107961bc..7411658f8b05 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -806,6 +806,9 @@ int nfs_lock(struct file *filp, int cmd, struct file_lock *fl)
 
 	nfs_inc_stats(inode, NFSIOS_VFSLOCK);
 
+	if (fl->fl_flags & FL_RECLAIM)
+		return -ENOGRACE;
+
 	/* No mandatory locks over NFS */
 	if (__mandatory_lock(inode) && fl->fl_type != F_UNLCK)
 		goto out_err;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index bebe86cce7c7..212f43fa5cba 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6903,6 +6903,9 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (!locks_in_grace(net) && lock->lk_reclaim)
 		goto out;
 
+	if (lock->lk_reclaim)
+		fl_flags |= FL_RECLAIM;
+
 	fp = lock_stp->st_stid.sc_file;
 	switch (lock->lk_type) {
 		case NFS4_READW_LT:
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 60d7c59e7935..90fcd6178823 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -881,6 +881,7 @@ nfserrno (int errno)
 		{ nfserr_serverfault, -ENFILE },
 		{ nfserr_io, -EUCLEAN },
 		{ nfserr_perm, -ENOKEY },
+		{ nfserr_no_grace, -ENOGRACE},
 	};
 	int	i;
 
diff --git a/include/linux/errno.h b/include/linux/errno.h
index d73f597a2484..8b0c754bab02 100644
--- a/include/linux/errno.h
+++ b/include/linux/errno.h
@@ -31,5 +31,6 @@
 #define EJUKEBOX	528	/* Request initiated, but will not complete before timeout */
 #define EIOCBQUEUED	529	/* iocb queued, will get completion event */
 #define ERECALLCONFLICT	530	/* conflict with recalled state */
+#define ENOGRACE	531	/* NFS file lock reclaim refused */
 
 #endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 640574294216..1f5c3dbce1da 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -997,6 +997,7 @@ static inline struct file *get_file(struct file *f)
 #define FL_UNLOCK_PENDING	512 /* Lease is being broken */
 #define FL_OFDLCK	1024	/* lock is "owned" by struct file */
 #define FL_LAYOUT	2048	/* outstanding pNFS layout */
+#define FL_RECLAIM	4096	/* reclaiming from a reboot server */
 
 #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
 
-- 
2.31.1

