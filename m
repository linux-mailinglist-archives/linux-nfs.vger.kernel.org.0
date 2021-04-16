Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A1436203E
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Apr 2021 14:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbhDPMvr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 16 Apr 2021 08:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234914AbhDPMvr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 16 Apr 2021 08:51:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40ED361107
        for <linux-nfs@vger.kernel.org>; Fri, 16 Apr 2021 12:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618577482;
        bh=XwhwI5O70I53p3eCI1cotWC82Z5xWdWRLUHkXEBNUUg=;
        h=From:To:Subject:Date:From;
        b=q3uZ4Ibfl1XpnuPzzsNYybk02s4OOyvKdzc+u0DafHjBxbccr6FO/C8LsIu+QhhDC
         138e1z/PqYTc17UrUm4aH30X184em+V7KphVZAK/dxiO99xhCTU+7S37pIJkpUF3lj
         RCmiEjiOAt/0ThR5+MIWrza0EEP5EQzogudVjk/4PvUjTTimaXfZJyUlq3pL+38LpF
         x6uf64dqwew+2hzbwwAd9SCzWwGVJxeLMg15sxThvUeICmks23v0wojP/hkQJpzQqS
         zHe6vAoWt+f2J5BrCG2sgwf9HR6C9bRg+EYxkw0XQA1CIhbvlOTCIpUuBAoveqAUQ9
         u9t3poqpZFq6g==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFSv4.x: Don't return NFS4ERR_NOMATCHING_LAYOUT if we're unmounting
Date:   Fri, 16 Apr 2021 08:51:19 -0400
Message-Id: <20210416125121.5753-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
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
2.30.2

