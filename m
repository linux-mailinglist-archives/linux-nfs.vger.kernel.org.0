Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D48632B754
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Mar 2021 12:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345001AbhCCK6Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 05:58:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:56560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1444005AbhCCE3U (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 2 Mar 2021 23:29:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8878564EC0;
        Wed,  3 Mar 2021 04:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614745718;
        bh=0stP7r4ZoXAMNXgPuZItc5apuDtDXhbakYQ5nIw0v10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gk/JY9pCIpF+oc6tEhkAIL/Jao/GnvTE7m+JmxXowom+YLx70/9J4EV/x+xx8sZ0p
         WuBXsUCx8VVQG15ut3DAWUlDgyVd11qvnfDsmb3jcXY29YI5SSOxjjRlqC3vizW3co
         tgUaSCaLFZErxa1lgmw4bzOkUD4FQE+1a6V4E5zpxT0USNPPLA/h0LrXnTu/1EXY5I
         DqpOMN1+0qbRKDaebSjiAG4jzvNFap/jAF7CH5CNRSYqPWNgUCRYMh5VtdPkFXxtbD
         7Ge4BN37sHu/pQph5p3jRbBv7NAyjZR29/UM/ZDfGhA11Ghg22O8Me6D/nAHKleuSn
         UBJ6Vnxxg/BwA==
From:   trondmy@kernel.org
To:     Geert Jansen <gerardu@amazon.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFS: Don't gratuitously clear the inode cache when lookup failed
Date:   Tue,  2 Mar 2021 23:28:36 -0500
Message-Id: <20210303042836.200413-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210303042836.200413-1-trondmy@kernel.org>
References: <20210303042836.200413-1-trondmy@kernel.org>
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
index 6350873cb8bd..deb6ad0622ed 100644
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

