Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB4841C60D
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Sep 2021 15:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344273AbhI2Nv1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Sep 2021 09:51:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344315AbhI2Nv1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 Sep 2021 09:51:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E34460551
        for <linux-nfs@vger.kernel.org>; Wed, 29 Sep 2021 13:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632923386;
        bh=eTf0iQMTb0ecW1foq9M5+Q1gWkI7peNiwLztp0hy9ck=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aE6OgEOmdB0rwvQ2yPcGmhIFLXYgp6sWzn/3VLkqMT2mQgk+zu/R/vElIVoFm0I2w
         rir4MJiCoL5/fkX3R5mgKeSSu/ucNxgnxiW9Lb5XO8R1KmvKbynQ4UJ1kRYP43EvAS
         TMM4CDUaW41xIjUT0J1Hg7hd77E8dK7UAH/nsU4HV24uf05p7vTBOXlGCmyUVernu/
         7ilXrBm5FE6xLaLZk64QlQjT2SdzQFBEAmfhpWF0buEa6uYaYOc6i3YABmw+DmeQb8
         GiMd39sA3T+7OH2EsNKOiZqKsdayiAf67C93PzH1qY6MtpCiHE2oNq/7JZl7RC3ltV
         eAkkVXlAyFSCA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/5] NFS: Ignore the directory size when marking for revalidation
Date:   Wed, 29 Sep 2021 09:49:41 -0400
Message-Id: <20210929134944.632844-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210929134944.632844-1-trondmy@kernel.org>
References: <20210929134944.632844-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If we want to revalidate the directory, then just mark the change
attribute as invalid.

Fixes: 13c0b082b6a9 ("NFS: Replace use of NFS_INO_REVAL_PAGECACHE when checking cache validity")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 1ce1fa0a5926..f2df664db020 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1413,7 +1413,7 @@ int nfs_lookup_verify_inode(struct inode *inode, unsigned int flags)
 static void nfs_mark_dir_for_revalidate(struct inode *inode)
 {
 	spin_lock(&inode->i_lock);
-	nfs_set_cache_invalid(inode, NFS_INO_REVAL_PAGECACHE);
+	nfs_set_cache_invalid(inode, NFS_INO_INVALID_CHANGE);
 	spin_unlock(&inode->i_lock);
 }
 
-- 
2.31.1

