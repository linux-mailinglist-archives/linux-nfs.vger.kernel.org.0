Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2FE41C60F
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Sep 2021 15:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344316AbhI2Nv2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Sep 2021 09:51:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344318AbhI2Nv2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 Sep 2021 09:51:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F27B60551
        for <linux-nfs@vger.kernel.org>; Wed, 29 Sep 2021 13:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632923387;
        bh=vIOq9W1Rsx3gdspMHf+PbQXGe8mt80iF3KdwiSArgV0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FVIdhViWYmWqxvF0llppMlOCn2MA0raUtESQPZSVAFjigwUP6MMpYx6CkHjjtT+dr
         ByNKrMzLIEM3gKxVWqfDlae6GS0jPay1EJu3JrtcNXhQdWbpCEGw72VFpO54wZwei4
         b8sKtS19GKfAHiWoctWG/4nEDD+bXnrVCO5LyLe13QxBsAAOUSkY2+RuAdRUKbYDT8
         Xjs+L+eluNboI/056AqjkLwqi//YDCcMQfKofCWyeEAHgFGflhMGJtcD4OgB1LW4mW
         SycHS/B85e+KrGKHbTbJ2t0H1OqDEjjlSYL941zgeMb7nkm4f8YXR7eO2A25g9ZN5K
         HmCiYbwePszMw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/5] NFS: Further optimisations for 'ls -l'
Date:   Wed, 29 Sep 2021 09:49:43 -0400
Message-Id: <20210929134944.632844-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210929134944.632844-3-trondmy@kernel.org>
References: <20210929134944.632844-1-trondmy@kernel.org>
 <20210929134944.632844-2-trondmy@kernel.org>
 <20210929134944.632844-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If a user is doing 'ls -l', we have a heuristic in GETATTR that tells
the readdir code to try to use READDIRPLUS in order to refresh the inode
attributes. In certain cirumstances, we also try to invalidate the
remaining directory entries in order to ensure this refresh.

If there are multiple readers of the directory, we probably should avoid
invalidating the page cache, since the heuristic breaks down in that
situation anyway.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c           | 16 +++++++++++-----
 include/linux/nfs_fs.h |  5 ++---
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index fa4d33687d2b..358033aea235 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -78,6 +78,7 @@ static struct nfs_open_dir_context *alloc_nfs_open_dir_context(struct inode *dir
 		ctx->attr_gencount = nfsi->attr_gencount;
 		ctx->dir_cookie = 0;
 		ctx->dup_cookie = 0;
+		ctx->page_index = 0;
 		spin_lock(&dir->i_lock);
 		if (list_empty(&nfsi->open_files) &&
 		    (nfsi->cache_validity & NFS_INO_DATA_INVAL_DEFER))
@@ -85,6 +86,7 @@ static struct nfs_open_dir_context *alloc_nfs_open_dir_context(struct inode *dir
 					      NFS_INO_INVALID_DATA |
 						      NFS_INO_REVAL_FORCED);
 		list_add(&ctx->list, &nfsi->open_files);
+		clear_bit(NFS_INO_FORCE_READDIR, &nfsi->flags);
 		spin_unlock(&dir->i_lock);
 		return ctx;
 	}
@@ -627,8 +629,7 @@ void nfs_force_use_readdirplus(struct inode *dir)
 	if (nfs_server_capable(dir, NFS_CAP_READDIRPLUS) &&
 	    !list_empty(&nfsi->open_files)) {
 		set_bit(NFS_INO_ADVISE_RDPLUS, &nfsi->flags);
-		invalidate_mapping_pages(dir->i_mapping,
-			nfsi->page_index + 1, -1);
+		set_bit(NFS_INO_FORCE_READDIR, &nfsi->flags);
 	}
 }
 
@@ -938,10 +939,8 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 			       sizeof(nfsi->cookieverf));
 	}
 	res = nfs_readdir_search_array(desc);
-	if (res == 0) {
-		nfsi->page_index = desc->page_index;
+	if (res == 0)
 		return 0;
-	}
 	nfs_readdir_page_unlock_and_put_cached(desc);
 	return res;
 }
@@ -1080,6 +1079,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_open_dir_context *dir_ctx = file->private_data;
 	struct nfs_readdir_descriptor *desc;
+	pgoff_t page_index;
 	int res;
 
 	dfprintk(FILE, "NFS: readdir(%pD2) starting at cookie %llu\n",
@@ -1110,10 +1110,15 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	desc->dir_cookie = dir_ctx->dir_cookie;
 	desc->dup_cookie = dir_ctx->dup_cookie;
 	desc->duped = dir_ctx->duped;
+	page_index = dir_ctx->page_index;
 	desc->attr_gencount = dir_ctx->attr_gencount;
 	memcpy(desc->verf, dir_ctx->verf, sizeof(desc->verf));
 	spin_unlock(&file->f_lock);
 
+	if (test_and_clear_bit(NFS_INO_FORCE_READDIR, &nfsi->flags) &&
+	    list_is_singular(&nfsi->open_files))
+		invalidate_mapping_pages(inode->i_mapping, page_index, -1);
+
 	do {
 		res = readdir_search_pagecache(desc);
 
@@ -1150,6 +1155,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	dir_ctx->dup_cookie = desc->dup_cookie;
 	dir_ctx->duped = desc->duped;
 	dir_ctx->attr_gencount = desc->attr_gencount;
+	dir_ctx->page_index = desc->page_index;
 	memcpy(dir_ctx->verf, desc->verf, sizeof(dir_ctx->verf));
 	spin_unlock(&file->f_lock);
 
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 9b75448ce0df..ca547cc5458c 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -103,6 +103,7 @@ struct nfs_open_dir_context {
 	__be32	verf[NFS_DIR_VERIFIER_SIZE];
 	__u64 dir_cookie;
 	__u64 dup_cookie;
+	pgoff_t page_index;
 	signed char duped;
 };
 
@@ -181,9 +182,6 @@ struct nfs_inode {
 	struct rw_semaphore	rmdir_sem;
 	struct mutex		commit_mutex;
 
-	/* track last access to cached pages */
-	unsigned long		page_index;
-
 #if IS_ENABLED(CONFIG_NFS_V4)
 	struct nfs4_cached_acl	*nfs4_acl;
         /* NFSv4 state */
@@ -272,6 +270,7 @@ struct nfs4_copy_state {
 #define NFS_INO_INVALIDATING	(3)		/* inode is being invalidated */
 #define NFS_INO_FSCACHE		(5)		/* inode can be cached by FS-Cache */
 #define NFS_INO_FSCACHE_LOCK	(6)		/* FS-Cache cookie management lock */
+#define NFS_INO_FORCE_READDIR	(7)		/* force readdirplus */
 #define NFS_INO_LAYOUTCOMMIT	(9)		/* layoutcommit required */
 #define NFS_INO_LAYOUTCOMMITTING (10)		/* layoutcommit inflight */
 #define NFS_INO_LAYOUTSTATS	(11)		/* layoutstats inflight */
-- 
2.31.1

