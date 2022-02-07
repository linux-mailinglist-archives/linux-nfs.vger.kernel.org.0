Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5614ACBA9
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Feb 2022 22:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243124AbiBGVw0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Feb 2022 16:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243125AbiBGVwY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Feb 2022 16:52:24 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC9DC061355
        for <linux-nfs@vger.kernel.org>; Mon,  7 Feb 2022 13:52:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7B153CE12B6
        for <linux-nfs@vger.kernel.org>; Mon,  7 Feb 2022 21:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A4AC340F1
        for <linux-nfs@vger.kernel.org>; Mon,  7 Feb 2022 21:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644270737;
        bh=yak7xVGYyDQdAKF/E60hbp8thIlYMLaOBETWgwUbO4M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nQzAbGxFyemnK7ax7LobnhAnA93BMJODv8Q7U8JJYCRBC9QkkMHwyougrcorY8zd+
         ccUdTUsRpqwI2/9McPKg9PKmg2Ef486n4C+sXjMN7LM4ev2abvcg9Q84H534C90sW0
         ws1h/jF+Or9iQQ+ZBV7irfIjEN0XfiU88WGRpg17vDG9q14asbjDUfD5KjmrMwhiji
         OlJsmIPLNUqg6EQVbUiLQXMAEecSKwMJ0RjJS6U3K6BAsK9i7aFzhorJXg+eYEAuSB
         dKebozIV7RotqkVfKoT9bnqse6qEmiz8oNAG4GGUH4WppVtcePmJMbLPfE5WWk2ujy
         e5BYBLGl0F6Pw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFS: Adjust the amount of readahead performed by NFS readdir
Date:   Mon,  7 Feb 2022 16:46:09 -0500
Message-Id: <20220207214610.803566-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207214610.803566-1-trondmy@kernel.org>
References: <20220207214610.803566-1-trondmy@kernel.org>
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

The current NFS readdir code will always try to maximise the amount of
readahead it performs on the assumption that we can cache anything that
isn't immediately read by the process.
There are several cases where this assumption breaks down, including
when the 'ls -l' heuristic kicks in to try to force use of readdirplus
as a batch replacement for lookup/getattr.

This patch therefore tries to tone down the amount of readahead we
perform, and adjust it to try to match the amount of data being
requested by user space.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c           | 64 +++++++++++++++++++++++++++++++++++++++---
 include/linux/nfs_fs.h |  1 +
 2 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 71fa551da956..c8b62c231080 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -69,6 +69,8 @@ const struct address_space_operations nfs_dir_aops = {
 	.freepage = nfs_readdir_clear_array,
 };
 
+#define NFS_INIT_DTSIZE	PAGE_SIZE
+
 static struct nfs_open_dir_context *alloc_nfs_open_dir_context(struct inode *dir)
 {
 	struct nfs_inode *nfsi = NFS_I(dir);
@@ -80,6 +82,7 @@ static struct nfs_open_dir_context *alloc_nfs_open_dir_context(struct inode *dir
 		ctx->dir_cookie = 0;
 		ctx->dup_cookie = 0;
 		ctx->page_index = 0;
+		ctx->dtsize = NFS_INIT_DTSIZE;
 		ctx->eof = false;
 		spin_lock(&dir->i_lock);
 		if (list_empty(&nfsi->open_files) &&
@@ -155,6 +158,7 @@ struct nfs_readdir_descriptor {
 	struct page	*page;
 	struct dir_context *ctx;
 	pgoff_t		page_index;
+	pgoff_t		page_index_max;
 	u64		dir_cookie;
 	u64		last_cookie;
 	u64		dup_cookie;
@@ -167,12 +171,40 @@ struct nfs_readdir_descriptor {
 	unsigned long	gencount;
 	unsigned long	attr_gencount;
 	unsigned int	cache_entry_index;
+	unsigned int	dtsize;
 	signed char duped;
 	bool plus;
 	bool eob;
 	bool eof;
 };
 
+static void nfs_set_dtsize(struct nfs_readdir_descriptor *desc, unsigned int sz)
+{
+	struct nfs_server *server = NFS_SERVER(file_inode(desc->file));
+	unsigned int maxsize = server->dtsize;
+
+	if (sz > maxsize)
+		sz = maxsize;
+	if (sz < NFS_MIN_FILE_IO_SIZE)
+		sz = NFS_MIN_FILE_IO_SIZE;
+	desc->dtsize = sz;
+}
+
+static void nfs_reset_dtsize(struct nfs_readdir_descriptor *desc)
+{
+	nfs_set_dtsize(desc, NFS_INIT_DTSIZE);
+}
+
+static void nfs_shrink_dtsize(struct nfs_readdir_descriptor *desc)
+{
+	nfs_set_dtsize(desc, desc->dtsize >> 1);
+}
+
+static void nfs_grow_dtsize(struct nfs_readdir_descriptor *desc)
+{
+	nfs_set_dtsize(desc, desc->dtsize << 1);
+}
+
 static void nfs_readdir_array_init(struct nfs_cache_array *array)
 {
 	memset(array, 0, sizeof(struct nfs_cache_array));
@@ -759,6 +791,7 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 				break;
 			arrays++;
 			*arrays = page = new;
+			desc->page_index_max++;
 		} else {
 			new = nfs_readdir_page_get_next(mapping,
 							page->index + 1,
@@ -768,6 +801,7 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 			if (page != *arrays)
 				nfs_readdir_page_unlock_and_put(page);
 			page = new;
+			desc->page_index_max = new->index;
 		}
 		status = nfs_readdir_add_to_array(entry, page);
 	} while (!status && !entry->eof);
@@ -833,7 +867,7 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 	struct nfs_entry *entry;
 	size_t array_size;
 	struct inode *inode = file_inode(desc->file);
-	size_t dtsize = NFS_SERVER(inode)->dtsize;
+	unsigned int dtsize = desc->dtsize;
 	int status = -ENOMEM;
 
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
@@ -916,6 +950,7 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 	if (!desc->page)
 		return -ENOMEM;
 	if (nfs_readdir_page_needs_filling(desc->page)) {
+		desc->page_index_max = desc->page_index;
 		res = nfs_readdir_xdr_to_array(desc, nfsi->cookieverf, verf,
 					       &desc->page, 1);
 		if (res < 0) {
@@ -1047,6 +1082,7 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 	desc->cache_entry_index = 0;
 	desc->last_cookie = desc->dir_cookie;
 	desc->duped = 0;
+	desc->page_index_max = 0;
 
 	status = nfs_readdir_xdr_to_array(desc, desc->verf, verf, arrays, sz);
 
@@ -1056,10 +1092,19 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 	}
 	desc->page = NULL;
 
+	/*
+	 * Grow the dtsize if we have to go back for more pages,
+	 * or shrink it if we're reading too many.
+	 */
+	if (!desc->eob)
+		nfs_grow_dtsize(desc);
+	else if (desc->page_index_max && i <= (desc->page_index_max >> 1))
+		nfs_shrink_dtsize(desc);
 
 	for (i = 0; i < sz && arrays[i]; i++)
 		nfs_readdir_page_array_free(arrays[i]);
 out:
+	desc->page_index_max = -1;
 	kfree(arrays);
 	dfprintk(DIRCACHE, "NFS: %s: returns %d\n", __func__, status);
 	return status;
@@ -1102,6 +1147,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	desc->file = file;
 	desc->ctx = ctx;
 	desc->plus = nfs_use_readdirplus(inode, ctx);
+	desc->page_index_max = -1;
 
 	spin_lock(&file->f_lock);
 	desc->dir_cookie = dir_ctx->dir_cookie;
@@ -1110,6 +1156,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	page_index = dir_ctx->page_index;
 	desc->attr_gencount = dir_ctx->attr_gencount;
 	desc->eof = dir_ctx->eof;
+	nfs_set_dtsize(desc, dir_ctx->dtsize);
 	memcpy(desc->verf, dir_ctx->verf, sizeof(desc->verf));
 	spin_unlock(&file->f_lock);
 
@@ -1118,9 +1165,12 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 		goto out_free;
 	}
 
-	if (test_and_clear_bit(NFS_INO_FORCE_READDIR, &nfsi->flags) &&
-	    list_is_singular(&nfsi->open_files))
-		invalidate_mapping_pages(inode->i_mapping, page_index + 1, -1);
+	if (test_and_clear_bit(NFS_INO_FORCE_READDIR, &nfsi->flags)) {
+		nfs_reset_dtsize(desc);
+		if (list_is_singular(&nfsi->open_files))
+			invalidate_mapping_pages(inode->i_mapping,
+						 page_index + 1, -1);
+	}
 
 	do {
 		res = readdir_search_pagecache(desc);
@@ -1151,6 +1201,11 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 
 		nfs_do_filldir(desc, nfsi->cookieverf);
 		nfs_readdir_page_unlock_and_put_cached(desc);
+		if (desc->eob || desc->eof)
+			break;
+		/* Grow the dtsize if we have to go back for more pages */
+		if (desc->page_index == desc->page_index_max)
+			nfs_grow_dtsize(desc);
 	} while (!desc->eob && !desc->eof);
 
 	spin_lock(&file->f_lock);
@@ -1160,6 +1215,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	dir_ctx->attr_gencount = desc->attr_gencount;
 	dir_ctx->page_index = desc->page_index;
 	dir_ctx->eof = desc->eof;
+	dir_ctx->dtsize = desc->dtsize;
 	memcpy(dir_ctx->verf, desc->verf, sizeof(dir_ctx->verf));
 	spin_unlock(&file->f_lock);
 out_free:
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 333ea05e2531..034d95809b97 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -106,6 +106,7 @@ struct nfs_open_dir_context {
 	__u64 dir_cookie;
 	__u64 dup_cookie;
 	pgoff_t page_index;
+	unsigned int dtsize;
 	signed char duped;
 	bool eof;
 };
-- 
2.34.1

