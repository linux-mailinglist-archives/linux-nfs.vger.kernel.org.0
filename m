Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81534C4DD1
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 19:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbiBYSf0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Feb 2022 13:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbiBYSfT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Feb 2022 13:35:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B72C1AAA53
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 10:34:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADDD9B83308
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A21C340F2
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645814085;
        bh=APbzb+dbzxi0ECXJXEhtBGtDPobWDyYbHE3W8LVlQL4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Q0L9/HN0cNLxHUAX2lBH+INpcO9ry5HutwWAyC51zO2ijIPN/4O+CzGy7tBFZa9RP
         79EFwNhzjE8haW81WYrWqbGXfUaIKoF4Kb7aWvI7GXQsyA8vxrbFWjbUDxxdFA6SD4
         AX8DXzNK0HWTF3R0+2DdTXxIvBaORSklEU3qO+Jm6hLMoE500vXPSOs4xntm22aRyE
         ovkyP33oiZ1UC2MvfcNFEFrNbqKk6nyuAiLHgs1luci8F56GjIc6l/hPT5znzFtFQS
         9TEsdZZBzFCTTa4yZq3T5LNSTLmcKDugrWvnVyoZG+nT9LLTw/ep84iPGyNUbg7gh/
         Ym0PlOe+RuVYA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 23/24] NFS: Remove unnecessary cache invalidations for directories
Date:   Fri, 25 Feb 2022 13:28:28 -0500
Message-Id: <20220225182829.1236093-24-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225182829.1236093-23-trondmy@kernel.org>
References: <20220225182829.1236093-1-trondmy@kernel.org>
 <20220225182829.1236093-2-trondmy@kernel.org>
 <20220225182829.1236093-3-trondmy@kernel.org>
 <20220225182829.1236093-4-trondmy@kernel.org>
 <20220225182829.1236093-5-trondmy@kernel.org>
 <20220225182829.1236093-6-trondmy@kernel.org>
 <20220225182829.1236093-7-trondmy@kernel.org>
 <20220225182829.1236093-8-trondmy@kernel.org>
 <20220225182829.1236093-9-trondmy@kernel.org>
 <20220225182829.1236093-10-trondmy@kernel.org>
 <20220225182829.1236093-11-trondmy@kernel.org>
 <20220225182829.1236093-12-trondmy@kernel.org>
 <20220225182829.1236093-13-trondmy@kernel.org>
 <20220225182829.1236093-14-trondmy@kernel.org>
 <20220225182829.1236093-15-trondmy@kernel.org>
 <20220225182829.1236093-16-trondmy@kernel.org>
 <20220225182829.1236093-17-trondmy@kernel.org>
 <20220225182829.1236093-18-trondmy@kernel.org>
 <20220225182829.1236093-19-trondmy@kernel.org>
 <20220225182829.1236093-20-trondmy@kernel.org>
 <20220225182829.1236093-21-trondmy@kernel.org>
 <20220225182829.1236093-22-trondmy@kernel.org>
 <20220225182829.1236093-23-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Now that the directory page cache entries police themselves, don't
bother with marking the page cache for invalidation.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c           | 5 -----
 fs/nfs/inode.c         | 9 +++------
 fs/nfs/nfs4proc.c      | 2 --
 include/linux/nfs_fs.h | 2 --
 4 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 4af00465806f..71f61565c72c 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -83,11 +83,6 @@ alloc_nfs_open_dir_context(struct inode *dir)
 		ctx->attr_gencount = nfsi->attr_gencount;
 		ctx->dtsize = NFS_INIT_DTSIZE;
 		spin_lock(&dir->i_lock);
-		if (list_empty(&nfsi->open_files) &&
-		    (nfsi->cache_validity & NFS_INO_DATA_INVAL_DEFER))
-			nfs_set_cache_invalid(dir,
-					      NFS_INO_INVALID_DATA |
-						      NFS_INO_REVAL_FORCED);
 		list_add_tail_rcu(&ctx->list, &nfsi->open_files);
 		memcpy(ctx->verf, nfsi->cookieverf, sizeof(ctx->verf));
 		spin_unlock(&dir->i_lock);
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 10d17cfb8639..43af1b6de5a6 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -210,6 +210,8 @@ void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 	if (flags & NFS_INO_INVALID_DATA)
 		nfs_fscache_invalidate(inode, 0);
 	flags &= ~NFS_INO_REVAL_FORCED;
+	if (S_ISDIR(inode->i_mode))
+		flags &= ~(NFS_INO_INVALID_DATA | NFS_INO_DATA_INVAL_DEFER);
 
 	nfsi->cache_validity |= flags;
 
@@ -1429,10 +1431,7 @@ static void nfs_wcc_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			&& (fattr->valid & NFS_ATTR_FATTR_CHANGE)
 			&& inode_eq_iversion_raw(inode, fattr->pre_change_attr)) {
 		inode_set_iversion_raw(inode, fattr->change_attr);
-		if (S_ISDIR(inode->i_mode))
-			nfs_set_cache_invalid(inode, NFS_INO_INVALID_DATA);
-		else if (nfs_server_capable(inode, NFS_CAP_XATTR))
-			nfs_set_cache_invalid(inode, NFS_INO_INVALID_XATTR);
+		nfs_set_cache_invalid(inode, NFS_INO_INVALID_XATTR);
 	}
 	/* If we have atomic WCC data, we may update some attributes */
 	ts = inode->i_ctime;
@@ -1851,8 +1850,6 @@ EXPORT_SYMBOL_GPL(nfs_refresh_inode);
 static int nfs_post_op_update_inode_locked(struct inode *inode,
 		struct nfs_fattr *fattr, unsigned int invalid)
 {
-	if (S_ISDIR(inode->i_mode))
-		invalid |= NFS_INO_INVALID_DATA;
 	nfs_set_cache_invalid(inode, invalid);
 	if ((fattr->valid & NFS_ATTR_FATTR) == 0)
 		return 0;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 8b875355824b..f1aa6b3c8523 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1206,8 +1206,6 @@ nfs4_update_changeattr_locked(struct inode *inode,
 	u64 change_attr = inode_peek_iversion_raw(inode);
 
 	cache_validity |= NFS_INO_INVALID_CTIME | NFS_INO_INVALID_MTIME;
-	if (S_ISDIR(inode->i_mode))
-		cache_validity |= NFS_INO_INVALID_DATA;
 
 	switch (NFS_SERVER(inode)->change_attr_type) {
 	case NFS4_CHANGE_TYPE_IS_UNDEFINED:
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 3f9625c7d0ef..08ba4db0db4a 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -360,8 +360,6 @@ static inline void nfs_mark_for_revalidate(struct inode *inode)
 	nfsi->cache_validity |= NFS_INO_INVALID_ACCESS | NFS_INO_INVALID_ACL |
 				NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_CTIME |
 				NFS_INO_INVALID_SIZE;
-	if (S_ISDIR(inode->i_mode))
-		nfsi->cache_validity |= NFS_INO_INVALID_DATA;
 	spin_unlock(&inode->i_lock);
 }
 
-- 
2.35.1

