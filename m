Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C3E348237
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Mar 2021 20:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbhCXTxW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Mar 2021 15:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237905AbhCXTxO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 24 Mar 2021 15:53:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDB1261A25
        for <linux-nfs@vger.kernel.org>; Wed, 24 Mar 2021 19:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616615594;
        bh=LXQcHXXrEN+g/1Bx7K1EpfbZKoB+6aP8grpxK7MpYoc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=b4MoRGIgn4+ptUl9Qt+bHvTxAHIjrEdSGgAZ+vfbWWzf8dByv7Yba0vb8eef/P/J8
         aWL9LOmRBn6A/2v6HozYa1VBYPMB3eSOKedmm4dQ7Wtp6gPkFoyqdTaD/S3g/t4tB6
         U25ILeQi/NZ6H+zjghTZlysLmKRlRLey+le4EMOC/C8XJB/3O9eUuPldnM0OoSadzI
         6oU9ML/y5SKtuTM2fKI4U50g5abnk1f/I3K4IpPtIHOglrHBEtkq6+cv6yILd9FpiH
         JTcO9h3MXpy12mRVOhG6JHy5e6qNgz5S46UkW+FFiXAPkRexkN4GF+3QusxrEBglE/
         WbkG8sKzSqQnA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFS: Fix up statx() results
Date:   Wed, 24 Mar 2021 15:53:11 -0400
Message-Id: <20210324195311.577373-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210324195311.577373-2-trondmy@kernel.org>
References: <20210324195311.577373-1-trondmy@kernel.org>
 <20210324195311.577373-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If statx has valid attributes available that weren't asked for, then
return them and set the result mask appropriately.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 001a6e4aabfd..3699f9fc8e15 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -805,6 +805,28 @@ static bool nfs_need_revalidate_inode(struct inode *inode)
 	return false;
 }
 
+static u32 nfs_get_valid_attrmask(struct inode *inode)
+{
+	unsigned long cache_validity = READ_ONCE(NFS_I(inode)->cache_validity);
+	u32 reply_mask = STATX_INO | STATX_TYPE;
+
+	if (!(cache_validity & NFS_INO_INVALID_ATIME))
+		reply_mask |= STATX_ATIME;
+	if (!(cache_validity & NFS_INO_REVAL_PAGECACHE)) {
+		if (!(cache_validity & NFS_INO_INVALID_CTIME))
+			reply_mask |= STATX_CTIME;
+		if (!(cache_validity & NFS_INO_INVALID_MTIME))
+			reply_mask |= STATX_MTIME;
+		if (!(cache_validity & NFS_INO_INVALID_SIZE))
+			reply_mask |= STATX_SIZE;
+	}
+	if (!(cache_validity & NFS_INO_INVALID_OTHER))
+		reply_mask |= STATX_UID | STATX_GID | STATX_MODE | STATX_NLINK;
+	if (!(cache_validity & NFS_INO_INVALID_BLOCKS))
+		reply_mask |= STATX_BLOCKS;
+	return reply_mask;
+}
+
 int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		struct kstat *stat, u32 request_mask, unsigned int query_flags)
 {
@@ -819,7 +841,7 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 
 	if ((query_flags & AT_STATX_DONT_SYNC) && !force_sync) {
 		nfs_readdirplus_parent_cache_hit(path->dentry);
-		goto out_no_update;
+		goto out_no_revalidate;
 	}
 
 	/* Flush out writes to the server in order to update c/mtime.  */
@@ -868,6 +890,7 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		do_update |= cache_validity & NFS_INO_INVALID_OTHER;
 	if (request_mask & STATX_BLOCKS)
 		do_update |= cache_validity & NFS_INO_INVALID_BLOCKS;
+
 	if (do_update) {
 		/* Update the attribute cache */
 		if (!(server->flags & NFS_MOUNT_NOAC))
@@ -881,8 +904,8 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		nfs_readdirplus_parent_cache_hit(path->dentry);
 out_no_revalidate:
 	/* Only return attributes that were revalidated. */
-	stat->result_mask &= request_mask;
-out_no_update:
+	stat->result_mask = nfs_get_valid_attrmask(inode) | request_mask;
+
 	generic_fillattr(&init_user_ns, inode, stat);
 	stat->ino = nfs_compat_user_ino64(NFS_FILEID(inode));
 	if (S_ISDIR(inode->i_mode))
-- 
2.30.2

