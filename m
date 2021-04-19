Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D86364664
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Apr 2021 16:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240270AbhDSOsa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Apr 2021 10:48:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240158AbhDSOsa (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Apr 2021 10:48:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72C2360FEF
        for <linux-nfs@vger.kernel.org>; Mon, 19 Apr 2021 14:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618843680;
        bh=T97p+6570ccrtjZwCyLc7/y2oqyNhjOf8D40hUaSDX8=;
        h=From:To:Subject:Date:From;
        b=YVq6BlkBJHdDMdrOPIV/cNnFqhbCd/nNzsyvI0VGMpz4GfPsWa3o3OKa2ft37ax0U
         py02zP3OkA3BhrpcsMzWTUj+C5DnckpYtUqdUleNylN15q7OMuoz2SaMBHrgBbubdA
         wHUI+fO6ov6HbrB34kwhAVnHxoprmjF1dsFEDvm+uP2z0oLW3Nobvsmq99H03uGYyV
         LFnDkDVftbkHPxVOgt82G3BQlI/E36mghz+xofB9ZUwuOtDbFbX4HLPt6lhaNP06AF
         gD8jV5XMW1UuUx63e3AKo+kOfeCq9n7HqJRbG/Vx6E0MzXxN6MMc2AH1lzAl+jcqKy
         gr+/wML42s5hg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/4] NFSv4.x: Don't return NFS4ERR_NOMATCHING_LAYOUT if we're unmounting
Date:   Mon, 19 Apr 2021 10:47:56 -0400
Message-Id: <20210419144759.41900-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the NFS super block is being unmounted, then we currently may end up
telling the server that we've forgotten the layout while it is actually
still in use by the client.
In that case, just assume that the client will soon return the layout
anyway, and so return NFS4ERR_DELAY in response to the layout recall.

Fixes: 58ac3e59235f ("NFSv4/pnfs: Clean up nfs_layout_find_inode()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/callback_proc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index f7786e00a6a7..ed9d580826f5 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -137,12 +137,12 @@ static struct inode *nfs_layout_find_inode_by_stateid(struct nfs_client *clp,
 		list_for_each_entry_rcu(lo, &server->layouts, plh_layouts) {
 			if (!pnfs_layout_is_valid(lo))
 				continue;
-			if (stateid != NULL &&
-			    !nfs4_stateid_match_other(stateid, &lo->plh_stateid))
+			if (!nfs4_stateid_match_other(stateid, &lo->plh_stateid))
 				continue;
-			if (!nfs_sb_active(server->super))
-				continue;
-			inode = igrab(lo->plh_inode);
+			if (nfs_sb_active(server->super))
+				inode = igrab(lo->plh_inode);
+			else
+				inode = ERR_PTR(-EAGAIN);
 			rcu_read_unlock();
 			if (inode)
 				return inode;
@@ -176,9 +176,10 @@ static struct inode *nfs_layout_find_inode_by_fh(struct nfs_client *clp,
 				continue;
 			if (nfsi->layout != lo)
 				continue;
-			if (!nfs_sb_active(server->super))
-				continue;
-			inode = igrab(lo->plh_inode);
+			if (nfs_sb_active(server->super))
+				inode = igrab(lo->plh_inode);
+			else
+				inode = ERR_PTR(-EAGAIN);
 			rcu_read_unlock();
 			if (inode)
 				return inode;
-- 
2.31.1

