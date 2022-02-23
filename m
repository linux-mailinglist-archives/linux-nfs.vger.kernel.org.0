Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3DC4C1D93
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 22:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242415AbiBWVUG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 16:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242419AbiBWVUE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 16:20:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C174ECD3
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:19:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A32FA6189D
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 21:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8840C340EC
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 21:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645651175;
        bh=TGSJC7Js5XmSyTQa1OnBY3flsCBN5F0w5Hij78e4jDo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FZr8mls6JfPbzlo+//yumLSfzaAzrJKGROotq4c3AZtFrFb7rxx1w8/UxAZRX27MZ
         Xoqm8jOkCAxri4DpRlwwg/k4e6/AqBaoVMp4VSMKF4zqcXZO/6nA6NTB/sqnLMsnT+
         APZQ8eRQIPZxCxoG1ds3uDSU9NTYCoLZZELSo6FyRF6n2roNRdrwH+N+9Uye4ppeA5
         uucIiQzBDirFW8ycp1hWrUBWrEglpNa9sB/4duyE7TvtHqlK6RhXbB+X0rLpZbEhDu
         AYiXwCCx/+viK9Q+vXJdVKkMbLkRBo4+ou5cXPy9Y+zrfUK4j8YXq2+qT7eEsx6Vbh
         OodxBZiW9yhAg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 08/21] NFS: Adjust the amount of readahead performed by NFS readdir
Date:   Wed, 23 Feb 2022 16:12:52 -0500
Message-Id: <20220223211305.296816-9-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220223211305.296816-8-trondmy@kernel.org>
References: <20220223211305.296816-1-trondmy@kernel.org>
 <20220223211305.296816-2-trondmy@kernel.org>
 <20220223211305.296816-3-trondmy@kernel.org>
 <20220223211305.296816-4-trondmy@kernel.org>
 <20220223211305.296816-5-trondmy@kernel.org>
 <20220223211305.296816-6-trondmy@kernel.org>
 <20220223211305.296816-7-trondmy@kernel.org>
 <20220223211305.296816-8-trondmy@kernel.org>
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
 fs/nfs/dir.c           | 55 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/nfs_fs.h |  1 +
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 70c0db877815..83933b7018ea 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -69,6 +69,8 @@ const struct address_space_operations nfs_dir_aops = {
 	.freepage = nfs_readdir_clear_array,
 };
 
+#define NFS_INIT_DTSIZE PAGE_SIZE
+
 static struct nfs_open_dir_context *
 alloc_nfs_open_dir_context(struct inode *dir)
 {
@@ -78,6 +80,7 @@ alloc_nfs_open_dir_context(struct inode *dir)
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
 	if (ctx != NULL) {
 		ctx->attr_gencount = nfsi->attr_gencount;
+		ctx->dtsize = NFS_INIT_DTSIZE;
 		spin_lock(&dir->i_lock);
 		if (list_empty(&nfsi->open_files) &&
 		    (nfsi->cache_validity & NFS_INO_DATA_INVAL_DEFER))
@@ -153,6 +156,7 @@ struct nfs_readdir_descriptor {
 	struct page	*page;
 	struct dir_context *ctx;
 	pgoff_t		page_index;
+	pgoff_t		page_index_max;
 	u64		dir_cookie;
 	u64		last_cookie;
 	u64		dup_cookie;
@@ -165,12 +169,36 @@ struct nfs_readdir_descriptor {
 	unsigned long	gencount;
 	unsigned long	attr_gencount;
 	unsigned int	cache_entry_index;
+	unsigned int	buffer_fills;
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
@@ -774,6 +802,7 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 				break;
 			arrays++;
 			*arrays = page = new;
+			desc->page_index_max++;
 		} else {
 			new = nfs_readdir_page_get_next(mapping,
 							page->index + 1,
@@ -783,6 +812,7 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 			if (page != *arrays)
 				nfs_readdir_page_unlock_and_put(page);
 			page = new;
+			desc->page_index_max = new->index;
 		}
 		status = nfs_readdir_add_to_array(entry, page);
 	} while (!status && !entry->eof);
@@ -848,7 +878,7 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 	struct nfs_entry *entry;
 	size_t array_size;
 	struct inode *inode = file_inode(desc->file);
-	size_t dtsize = NFS_SERVER(inode)->dtsize;
+	unsigned int dtsize = desc->dtsize;
 	int status = -ENOMEM;
 
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
@@ -884,6 +914,7 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 
 		status = nfs_readdir_page_filler(desc, entry, pages, pglen,
 						 arrays, narrays);
+		desc->buffer_fills++;
 	} while (!status && nfs_readdir_page_needs_filling(page) &&
 		page_mapping(page));
 
@@ -931,6 +962,7 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 	if (!desc->page)
 		return -ENOMEM;
 	if (nfs_readdir_page_needs_filling(desc->page)) {
+		desc->page_index_max = desc->page_index;
 		res = nfs_readdir_xdr_to_array(desc, nfsi->cookieverf, verf,
 					       &desc->page, 1);
 		if (res < 0) {
@@ -1067,6 +1099,7 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 	desc->cache_entry_index = 0;
 	desc->last_cookie = desc->dir_cookie;
 	desc->duped = 0;
+	desc->page_index_max = 0;
 
 	status = nfs_readdir_xdr_to_array(desc, desc->verf, verf, arrays, sz);
 
@@ -1076,10 +1109,22 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 	}
 	desc->page = NULL;
 
+	/*
+	 * Grow the dtsize if we have to go back for more pages,
+	 * or shrink it if we're reading too many.
+	 */
+	if (!desc->eof) {
+		if (!desc->eob)
+			nfs_grow_dtsize(desc);
+		else if (desc->buffer_fills == 1 &&
+			 i < (desc->page_index_max >> 1))
+			nfs_shrink_dtsize(desc);
+	}
 
 	for (i = 0; i < sz && arrays[i]; i++)
 		nfs_readdir_page_array_free(arrays[i]);
 out:
+	desc->page_index_max = -1;
 	kfree(arrays);
 	dfprintk(DIRCACHE, "NFS: %s: returns %d\n", __func__, status);
 	return status;
@@ -1118,6 +1163,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	desc->file = file;
 	desc->ctx = ctx;
 	desc->plus = nfs_use_readdirplus(inode, ctx);
+	desc->page_index_max = -1;
 
 	spin_lock(&file->f_lock);
 	desc->dir_cookie = dir_ctx->dir_cookie;
@@ -1128,6 +1174,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	desc->last_cookie = dir_ctx->last_cookie;
 	desc->attr_gencount = dir_ctx->attr_gencount;
 	desc->eof = dir_ctx->eof;
+	nfs_set_dtsize(desc, dir_ctx->dtsize);
 	memcpy(desc->verf, dir_ctx->verf, sizeof(desc->verf));
 	spin_unlock(&file->f_lock);
 
@@ -1169,6 +1216,11 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 
 		nfs_do_filldir(desc, nfsi->cookieverf);
 		nfs_readdir_page_unlock_and_put_cached(desc);
+		if (desc->eob || desc->eof)
+			break;
+		/* Grow the dtsize if we have to go back for more pages */
+		if (desc->page_index == desc->page_index_max)
+			nfs_grow_dtsize(desc);
 	} while (!desc->eob && !desc->eof);
 
 	spin_lock(&file->f_lock);
@@ -1179,6 +1231,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	dir_ctx->attr_gencount = desc->attr_gencount;
 	dir_ctx->page_index = desc->page_index;
 	dir_ctx->eof = desc->eof;
+	dir_ctx->dtsize = desc->dtsize;
 	memcpy(dir_ctx->verf, desc->verf, sizeof(dir_ctx->verf));
 	spin_unlock(&file->f_lock);
 out_free:
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 1c533f2c1f36..691a27936849 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -107,6 +107,7 @@ struct nfs_open_dir_context {
 	__u64 dup_cookie;
 	__u64 last_cookie;
 	pgoff_t page_index;
+	unsigned int dtsize;
 	signed char duped;
 	bool eof;
 };
-- 
2.35.1

