Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D282141FEDD
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Oct 2021 02:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbhJCAKL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 2 Oct 2021 20:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234236AbhJCAKK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 2 Oct 2021 20:10:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3682361AA9
        for <linux-nfs@vger.kernel.org>; Sun,  3 Oct 2021 00:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633219704;
        bh=mDFl0IAuVfb1sHEObHVutH+9MmnJqyoNzljR8RYwlbI=;
        h=From:To:Subject:Date:From;
        b=Xt/MznQiuZz7zBWdk4E7u+20EhjqLskf5Ci+2vYX0Ox8Chm6uGtaz8cVqxfsx2uxw
         8aCj+mggECjwAGWZImIFVVCU5/D4RNeHQDYFWEm+5qQ3Tsdn19bGEWMOjkdXGCNna8
         AdXbe8Kc7HKeZ1mmkrFaxVfIhAS+yJ5Dds3K6VXD7zWaCqtuV9N9kOoVJiNG7RQgrK
         mC2y4FMuXAxfNSqJam/QgqKnGj0IRiZbzcTORLZNbWxTnMWHEnl6BHiov36BHJPRkz
         c7keas5yGmTfV50/IBmErSCmoA9UNbMWNHaQpSxNL8HBH85bjsL6BvhyN+aMuTRlZF
         2ILo38Ry9K0QQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Remove unnecessary page cache invalidations
Date:   Sat,  2 Oct 2021 20:08:23 -0400
Message-Id: <20211003000823.65728-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Remove cache invalidations that are already covered by change attribute
updates.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index dcb885b7ad73..3bd0ae438663 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1451,8 +1451,6 @@ static void nfs_wcc_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			&& (fattr->valid & NFS_ATTR_FATTR_MTIME)
 			&& timespec64_equal(&ts, &fattr->pre_mtime)) {
 		inode->i_mtime = fattr->mtime;
-		if (S_ISDIR(inode->i_mode))
-			nfs_set_cache_invalid(inode, NFS_INO_INVALID_DATA);
 	}
 	if ((fattr->valid & NFS_ATTR_FATTR_PRESIZE)
 			&& (fattr->valid & NFS_ATTR_FATTR_SIZE)
@@ -2162,11 +2160,8 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			save_cache_validity & NFS_INO_INVALID_OTHER;
 
 	if (fattr->valid & NFS_ATTR_FATTR_NLINK) {
-		if (inode->i_nlink != fattr->nlink) {
-			if (S_ISDIR(inode->i_mode))
-				invalid |= NFS_INO_INVALID_DATA;
+		if (inode->i_nlink != fattr->nlink)
 			set_nlink(inode, fattr->nlink);
-		}
 	} else if (fattr_supported & NFS_ATTR_FATTR_NLINK)
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_NLINK;
-- 
2.31.1

