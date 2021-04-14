Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAF835F52E
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 15:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347403AbhDNNog (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 09:44:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351591AbhDNNoU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Apr 2021 09:44:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F2DB611C9
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 13:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618407838;
        bh=Pzcw2Ix0QUqNjfS77IWr1o1qt0+dmj2vkUZSzC0GNzE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ffI5Z7i/EK7MR8VotoWtgD4tQ5ICJBCbeYStraJcoShHpyckdXAopYlmalSruI8gG
         xBrpGP2C3C+ojjtfgZ4sd/h/dMqECD7TZ39wddkIqH+H3T3IG0hOyw0QuwqJ3K4+IP
         6fCdtWDrGuh6xPXg0qo4NUpT+Lt2Lee2LhHDVjX7qgyo00HCfz6O1l8ixboEodFljN
         nIsM2qfbLQNWPrMKABEDZerhxEYRoZm/cuQzyupUNAdmM4/KS2LxmDm4pquf+u5GEj
         bf7WO1nmznAYT3vN/3Go9cwCa11N4ljQ1wPXsOTraaVidLAs8Rd7t/yhq0BmFF6TRn
         N/IDNXYmYKA8Q==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 07/26] NFS: Fix up statx() results
Date:   Wed, 14 Apr 2021 09:43:34 -0400
Message-Id: <20210414134353.11860-8-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414134353.11860-7-trondmy@kernel.org>
References: <20210414134353.11860-1-trondmy@kernel.org>
 <20210414134353.11860-2-trondmy@kernel.org>
 <20210414134353.11860-3-trondmy@kernel.org>
 <20210414134353.11860-4-trondmy@kernel.org>
 <20210414134353.11860-5-trondmy@kernel.org>
 <20210414134353.11860-6-trondmy@kernel.org>
 <20210414134353.11860-7-trondmy@kernel.org>
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
index 4982bc18ee26..8c2d5f333e81 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -806,6 +806,28 @@ static bool nfs_need_revalidate_inode(struct inode *inode)
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
@@ -824,7 +846,7 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 
 	if ((query_flags & AT_STATX_DONT_SYNC) && !force_sync) {
 		nfs_readdirplus_parent_cache_hit(path->dentry);
-		goto out_no_update;
+		goto out_no_revalidate;
 	}
 
 	/* Flush out writes to the server in order to update c/mtime.  */
@@ -870,6 +892,7 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		do_update |= cache_validity & NFS_INO_INVALID_OTHER;
 	if (request_mask & STATX_BLOCKS)
 		do_update |= cache_validity & NFS_INO_INVALID_BLOCKS;
+
 	if (do_update) {
 		/* Update the attribute cache */
 		if (!(server->flags & NFS_MOUNT_NOAC))
@@ -883,8 +906,8 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
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

