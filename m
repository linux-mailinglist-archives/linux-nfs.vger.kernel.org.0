Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BC833177D
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Mar 2021 20:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhCHTnM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Mar 2021 14:43:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230173AbhCHTm5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 8 Mar 2021 14:42:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1979E652B3;
        Mon,  8 Mar 2021 19:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615232577;
        bh=8y1DWKatjPA48Z1tsHvNCvxIvoci0f18KkuAVxomkR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bmgA8jc66viJmW0TbhMx6zZ2obE/ndGygJ6APf990OKdTgbur5UWi8r0gRYgLm+Re
         Znsvq0CyZVq3gnpIYMxfsKX9YCPKtFpul3uX34MsnV14rfyXv4wo1U7ka8vXGtIc8G
         rnpYjhtna3JUbd8X/mrWO9TY6nQGbOQ+TAFAjh5c4HLk3Nuy1irDYo2kX6rwExqqGT
         5RST1X6pNSLaBlPWXISRDsLQ3d2ywMaaVLs7LmQgnruagiNCK4CBwpsIBUq2+ung5F
         hAxlIzuI6dobUW9yrQl/z5RKWQFzQJhVXBcofJynfAnwN7PA66H756AEG/OlU+pAMk
         IVS1O/EpK9J4Q==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Cc:     Geert Jansen <gerardu@amazon.com>
Subject: [PATCH v2 2/5] NFS: Don't gratuitously clear the inode cache when lookup failed
Date:   Mon,  8 Mar 2021 14:42:52 -0500
Message-Id: <20210308194255.7873-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210308194255.7873-1-trondmy@kernel.org>
References: <20210308194255.7873-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The fact that the lookup revalidation failed, does not mean that the
inode contents have changed.

Fixes: 5ceb9d7fdaaf ("NFS: Refactor nfs_lookup_revalidate()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 08b162de627f..a91f324cca49 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1444,18 +1444,14 @@ nfs_lookup_revalidate_done(struct inode *dir, struct dentry *dentry,
 			__func__, dentry);
 		return 1;
 	case 0:
-		if (inode && S_ISDIR(inode->i_mode)) {
-			/* Purge readdir caches. */
-			nfs_zap_caches(inode);
-			/*
-			 * We can't d_drop the root of a disconnected tree:
-			 * its d_hash is on the s_anon list and d_drop() would hide
-			 * it from shrink_dcache_for_unmount(), leading to busy
-			 * inodes on unmount and further oopses.
-			 */
-			if (IS_ROOT(dentry))
-				return 1;
-		}
+		/*
+		 * We can't d_drop the root of a disconnected tree:
+		 * its d_hash is on the s_anon list and d_drop() would hide
+		 * it from shrink_dcache_for_unmount(), leading to busy
+		 * inodes on unmount and further oopses.
+		 */
+		if (inode && IS_ROOT(dentry))
+			return 1;
 		dfprintk(LOOKUPCACHE, "NFS: %s(%pd2) is invalid\n",
 				__func__, dentry);
 		return 0;
-- 
2.29.2

