Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C86141FEDB
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Oct 2021 02:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbhJCAJw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 2 Oct 2021 20:09:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234236AbhJCAJw (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 2 Oct 2021 20:09:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BE8961AA9
        for <linux-nfs@vger.kernel.org>; Sun,  3 Oct 2021 00:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633219685;
        bh=8vRNBmIxbflQsC0Gsd4s5uXvnN4ZrvTwKRf1LikfBhw=;
        h=From:To:Subject:Date:From;
        b=RELbbSfRSV5AnEdxUjxBQgKIEnW/35j6JssK9sCS4NbcJBS/rauEgxNHdUPm+wWMC
         ArHklHF3lDEI69PZvRZLr48SSNja6o1Q+iUzW9IKwPtisL0L0VkXoeQg9iEsNcRPFI
         /Z9dgEfYr98UvnGc31tKYTFEPmqV+kM2FA1bj5UHvKLCzfhdFvYYIR1URAFqtZKMGd
         qjaOvZD1wYP4lwnqI3dKJBS1C3nB/RGN++1KcdO4tK8q0NJYCr2HkOR/FY6dwPoaWB
         tdWwEUuxX42NQqq9JRHLsB8Oa+Rmyv10chZzTm9Fi4UdsqSvaJZ4C9oOTLFCX8ahEl
         B8NlXe4qda7zQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Do not flush the readdir cache in nfs_dentry_iput()
Date:   Sat,  2 Oct 2021 20:08:04 -0400
Message-Id: <20211003000804.65661-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The original premise in commit 83672d392f7b ("NFS: Fix directory caching
problem - with test case and patch.") was that readdirplus was caching
attribute information and replaying it later. This is no longer the
case.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 3fafecdb2070..210c5945ac2b 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1727,10 +1727,6 @@ static void nfs_drop_nlink(struct inode *inode)
  */
 static void nfs_dentry_iput(struct dentry *dentry, struct inode *inode)
 {
-	if (S_ISDIR(inode->i_mode))
-		/* drop any readdir cache as it could easily be old */
-		nfs_set_cache_invalid(inode, NFS_INO_INVALID_DATA);
-
 	if (dentry->d_flags & DCACHE_NFSFS_RENAMED) {
 		nfs_complete_unlink(dentry, inode);
 		nfs_drop_nlink(inode);
-- 
2.31.1

