Return-Path: <linux-nfs+bounces-7400-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043549AD656
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 23:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04822807AB
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 21:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEB3158868;
	Wed, 23 Oct 2024 21:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWhWPsNz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8819A155757
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 21:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717680; cv=none; b=UhkW7Us46MkbYULnV4nEE8LTSv9wa6kK76cWYYyHcTdNYuuSm6fCOi1DSdoR8evo+ol8EmIWCHJpT7vsrUBWY9gpTSFR3whsfEfb0obNkmvbhhXXdtqcWnrS8mPJTfE7540PcKT7+n5pe+l9BwDlGmklLosDQ+skCtueWVbXjHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717680; c=relaxed/simple;
	bh=NzYEzfxLXukmLpTUQLyr3Gb3xnox7NS67izDNqt2gDM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=D/OnRhnqL6Lp6aLJZQywneT8v6xJtFJTqstpjasyG5p9ACEi0SR2ySf699+G+GhTOQuSl+WbMPFIsHNRms4l55jenEusb/snhU8dl5CxgL7pE4qkvxRT9Pp7FJV0kZzDQM0gJJ1c1eGfX+5Mh/Yv1TH3rLy9wmtIuezdx1LA+S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWhWPsNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40DEC4CEC6
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 21:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729717680;
	bh=NzYEzfxLXukmLpTUQLyr3Gb3xnox7NS67izDNqt2gDM=;
	h=From:To:Subject:Date:From;
	b=sWhWPsNzxIIXg387uL2f7ovYGvgdVb27z1InWmJoQd7WCcklmaxZoBwupOyzBQCXy
	 eMz8curef0z2hzQ1nROpWismR9p+dQQ3EAmP/0fZx5AJw53Ivbb4BjMw8FENKZXw3W
	 /O6Pw6jRgq3RgfIdrXKOH0SJWGzhtDgDFUzqxhhIKYk0HvgrJlGW6y181M1AuKtB/X
	 9QNsShaekavb7lUffoxeyEuXeIF7GOcdLMhA6MJAyPnsklwxQS+pxbL8qod5mfSjpI
	 8D5AvUujuqKQzXQcAnlcTfLeAmu1Y2y5XICX8DS3Zp91dPus/7jkNxvwW+LvH7OG7U
	 jouko1NlwFL1A==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Further fixes to attribute delegation a/mtime changes
Date: Wed, 23 Oct 2024 17:05:48 -0400
Message-ID: <ffad960d3b76af5dff9f3f4e1c7152423b7ae30e.1729717515.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When asked to set both an atime and an mtime to the current system time,
ensure that the setting is atomic by calling inode_update_timestamps()
only once with the appropriate flags.

Fixes: e12912d94137 ("NFSv4: Add support for delegated atime and mtime attributes")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c | 49 +++++++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 542c7d97b235..55acbd5f9399 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -628,23 +628,35 @@ nfs_fattr_fixup_delegated(struct inode *inode, struct nfs_fattr *fattr)
 	}
 }
 
+static void nfs_update_timestamps(struct inode *inode, unsigned int ia_valid)
+{
+	enum file_time_flags time_flags = 0;
+	unsigned int cache_flags = 0;
+
+	if (ia_valid & ATTR_MTIME) {
+		time_flags |= S_MTIME | S_CTIME;
+		cache_flags |= NFS_INO_INVALID_CTIME | NFS_INO_INVALID_MTIME;
+	}
+	if (ia_valid & ATTR_ATIME) {
+		time_flags |= S_ATIME;
+		cache_flags |= NFS_INO_INVALID_ATIME;
+	}
+	inode_update_timestamps(inode, time_flags);
+	NFS_I(inode)->cache_validity &= ~cache_flags;
+}
+
 void nfs_update_delegated_atime(struct inode *inode)
 {
 	spin_lock(&inode->i_lock);
-	if (nfs_have_delegated_atime(inode)) {
-		inode_update_timestamps(inode, S_ATIME);
-		NFS_I(inode)->cache_validity &= ~NFS_INO_INVALID_ATIME;
-	}
+	if (nfs_have_delegated_atime(inode))
+		nfs_update_timestamps(inode, ATTR_ATIME);
 	spin_unlock(&inode->i_lock);
 }
 
 void nfs_update_delegated_mtime_locked(struct inode *inode)
 {
-	if (nfs_have_delegated_mtime(inode)) {
-		inode_update_timestamps(inode, S_CTIME | S_MTIME);
-		NFS_I(inode)->cache_validity &= ~(NFS_INO_INVALID_CTIME |
-						  NFS_INO_INVALID_MTIME);
-	}
+	if (nfs_have_delegated_mtime(inode))
+		nfs_update_timestamps(inode, ATTR_MTIME);
 }
 
 void nfs_update_delegated_mtime(struct inode *inode)
@@ -682,15 +694,16 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			attr->ia_valid &= ~ATTR_SIZE;
 	}
 
-	if (nfs_have_delegated_mtime(inode)) {
-		if (attr->ia_valid & ATTR_MTIME) {
-			nfs_update_delegated_mtime(inode);
-			attr->ia_valid &= ~ATTR_MTIME;
-		}
-		if (attr->ia_valid & ATTR_ATIME) {
-			nfs_update_delegated_atime(inode);
-			attr->ia_valid &= ~ATTR_ATIME;
-		}
+	if (nfs_have_delegated_mtime(inode) && attr->ia_valid & ATTR_MTIME) {
+		spin_lock(&inode->i_lock);
+		nfs_update_timestamps(inode, attr->ia_valid);
+		spin_unlock(&inode->i_lock);
+		attr->ia_valid &= ~(ATTR_MTIME | ATTR_ATIME);
+	} else if (nfs_have_delegated_atime(inode) &&
+		   attr->ia_valid & ATTR_ATIME &&
+		   !(attr->ia_valid & ATTR_MTIME)) {
+		nfs_update_delegated_atime(inode);
+		attr->ia_valid &= ~ATTR_ATIME;
 	}
 
 	/* Optimization: if the end result is no change, don't RPC */
-- 
2.47.0


