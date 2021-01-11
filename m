Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E142F0AC5
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jan 2021 02:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbhAKBZx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 10 Jan 2021 20:25:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:54790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbhAKBZx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 10 Jan 2021 20:25:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF02A223E8
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jan 2021 01:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610328312;
        bh=GgfCvg5s70m4I7mmTFRRgO/y+kEz2CWRZZqQG+mAX+0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YczjH6l/8pLvHUCkPMtV0KFNSZDtg5Owkn8bhd3FqtrS1XN6uLfbjgybhk7NX2yFG
         ldmmd3zVMT3JNgk3bLRpElifvWwQfayS3L5UpW//T27i/wG83hKSbfgueCRVNhPg55
         g27EQapeX2uUm+oq1IjEyHoslIRCeRBTzMsMb9KHhG6L4GP+GGE5zWsJyYpkXHaOae
         edQWxBSQbT0Yi9n2qqx8TwGTHJzZob6fjaNX6/DbsZKW6uLdZgmV6AUfzO0EZDZBvk
         0c3XAauAcLQKpFxFz8SSp+jUs6D0DxuufBjYjuNKZafjSCiF6t0YoouZmnmQW2Sywq
         7Co6e5RFNXCrA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFS: nfs_igrab_and_active must first reference the superblock
Date:   Sun, 10 Jan 2021 20:25:11 -0500
Message-Id: <20210111012511.481829-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210111012511.481829-1-trondmy@kernel.org>
References: <20210111012511.481829-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Before referencing the inode, we must ensure that the superblock can be
referenced. Otherwise, we can end up with iput() calling superblock
operations that are no longer valid or accessible.

Fixes: ea7c38fef0b7 ("NFSv4: Ensure we reference the inode for return-on-close in delegreturn")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/internal.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 6bdee7ab3a6c..62d3189745cd 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -599,12 +599,14 @@ extern void nfs4_test_session_trunk(struct rpc_clnt *clnt,
 
 static inline struct inode *nfs_igrab_and_active(struct inode *inode)
 {
-	inode = igrab(inode);
-	if (inode != NULL && !nfs_sb_active(inode->i_sb)) {
-		iput(inode);
-		inode = NULL;
+	struct super_block *sb = inode->i_sb;
+
+	if (sb && nfs_sb_active(sb)) {
+		if (igrab(inode))
+			return inode;
+		nfs_sb_deactive(sb);
 	}
-	return inode;
+	return NULL;
 }
 
 static inline void nfs_iput_and_deactive(struct inode *inode)
-- 
2.29.2

