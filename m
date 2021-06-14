Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980DF3A693F
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jun 2021 16:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbhFNOuY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Jun 2021 10:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbhFNOuY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Jun 2021 10:50:24 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27503C061574
        for <linux-nfs@vger.kernel.org>; Mon, 14 Jun 2021 07:48:21 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 72D6248F; Mon, 14 Jun 2021 10:48:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 72D6248F
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>
Cc:     daire@dneg.com, linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 3/3] nfs: don't allow reexport reclaims
Date:   Mon, 14 Jun 2021 10:48:18 -0400
Message-Id: <1623682098-13236-4-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1623682098-13236-1-git-send-email-bfields@redhat.com>
References: <1623682098-13236-1-git-send-email-bfields@redhat.com>
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
 fs/nfs/file.c       | 3 +++
 fs/nfsd/nfs4state.c | 3 +++
 fs/nfsd/nfsproc.c   | 1 +
 include/linux/fs.h  | 1 +
 4 files changed, 8 insertions(+)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 1fef107961bc..35a29b440e3e 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -806,6 +806,9 @@ int nfs_lock(struct file *filp, int cmd, struct file_lock *fl)
 
 	nfs_inc_stats(inode, NFSIOS_VFSLOCK);
 
+	if (fl->fl_flags & FL_RECLAIM)
+		return -NFSERR_NO_GRACE;
+
 	/* No mandatory locks over NFS */
 	if (__mandatory_lock(inode) && fl->fl_type != F_UNLCK)
 		goto out_err;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 00d98bbab2a6..3ef42c0d5d38 100644
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
index 60d7c59e7935..80c430c37ab7 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -881,6 +881,7 @@ nfserrno (int errno)
 		{ nfserr_serverfault, -ENFILE },
 		{ nfserr_io, -EUCLEAN },
 		{ nfserr_perm, -ENOKEY },
+		{ nfserr_no_grace, -NFSERR_NO_GRACE},
 	};
 	int	i;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c3c88fdb9b2a..9be479999109 100644
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

