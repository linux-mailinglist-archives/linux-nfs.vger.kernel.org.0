Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5B94D7723
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Mar 2022 18:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbiCMRNR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 13 Mar 2022 13:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbiCMRNQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 13 Mar 2022 13:13:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EBD139CE2
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 10:12:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE28D6121F
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8407AC340F3
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647191527;
        bh=iKa6SQHOjFANMI96z/WwaVY3DGKkOSydArykZuyDR/E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GAk43Y+/EfFKFlTa0PoDzvvGZzZYkvRNUpFW5z47Ccf9BJTerqNKphqC8Bo/rlNfa
         margaMImTMUVqHmazbrJrKEqBl4f76oM2VVNeLw0ggDcYOfNWdJj3rolAMUeP7ShRa
         Cp5KuarpyhlSQvO/PY9WlgAFDZKM5ZQPOvBQXz1qDpmWQwufi2uVvxpkBWMj5XIAdA
         aMU7wm+yeJCk5972fYN6eqmDqv4NoypD3jy1deQ3jxUg9yq/y2Jtow7wB/UlAf7GgJ
         HRelWtMfgfBQpW4hLL5uXI7uU4TZqUlEMiNR75ah+uu7p01bNlRzI9J2nXdHwu7IFO
         PoQuyxGnh+6UQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 10/26] NFS: Adjust the amount of readahead performed by NFS readdir
Date:   Sun, 13 Mar 2022 13:05:41 -0400
Message-Id: <20220313170557.5940-11-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220313170557.5940-10-trondmy@kernel.org>
References: <20220313170557.5940-1-trondmy@kernel.org>
 <20220313170557.5940-2-trondmy@kernel.org>
 <20220313170557.5940-3-trondmy@kernel.org>
 <20220313170557.5940-4-trondmy@kernel.org>
 <20220313170557.5940-5-trondmy@kernel.org>
 <20220313170557.5940-6-trondmy@kernel.org>
 <20220313170557.5940-7-trondmy@kernel.org>
 <20220313170557.5940-8-trondmy@kernel.org>
 <20220313170557.5940-9-trondmy@kernel.org>
 <20220313170557.5940-10-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 fs/nfs/dir.c           | 53 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/nfs_fs.h |  1 +
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 60f7feee0a16..520dc3ec4aef 100644
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
@@ -154,6 +157,7 @@ struct nfs_readdir_descriptor {
 	struct page	*page;
 	struct dir_context *ctx;
 	pgoff_t		page_index;
+	pgoff_t		page_index_max;
 	u64		dir_cookie;
 	u64		last_cookie;
 	u64		dup_cookie;
@@ -166,12 +170,36 @@ struct nfs_readdir_descriptor {
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
@@ -784,6 +812,7 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 				break;
 			arrays++;
 			*arrays = page = new;
+			desc->page_index_max++;
 		} else {
 			new = nfs_readdir_page_get_next(mapping,
 							page->index + 1,
@@ -793,6 +822,7 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 			if (page != *arrays)
 				nfs_readdir_page_unlock_and_put(page);
 			page = new;
+			desc->page_index_max = new->index;
 		}
 		status = nfs_readdir_add_to_array(entry, page);
 	} while (!status && !entry->eof);
@@ -858,7 +888,7 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 	struct nfs_entry *entry;
 	size_t array_size;
 	struct inode *inode = file_inode(desc->file);
-	size_t dtsize = NFS_SERVER(inode)->dtsize;
+	unsigned int dtsize = desc->dtsize;
 	int status = -ENOMEM;
 
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
@@ -894,6 +924,7 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 
 		status = nfs_readdir_page_filler(desc, entry, pages, pglen,
 						 arrays, narrays);
+		desc->buffer_fills++;
 	} while (!status && nfs_readdir_page_needs_filling(page) &&
 		page_mapping(page));
 
@@ -941,6 +972,10 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 	if (!desc->page)
 		return -ENOMEM;
 	if (nfs_readdir_page_needs_filling(desc->page)) {
+		/* Grow the dtsize if we had to go back for more pages */
+		if (desc->page_index == desc->page_index_max)
+			nfs_grow_dtsize(desc);
+		desc->page_index_max = desc->page_index;
 		res = nfs_readdir_xdr_to_array(desc, nfsi->cookieverf, verf,
 					       &desc->page, 1);
 		if (res < 0) {
@@ -1075,6 +1110,7 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 	desc->cache_entry_index = 0;
 	desc->last_cookie = desc->dir_cookie;
 	desc->duped = 0;
+	desc->page_index_max = 0;
 
 	status = nfs_readdir_xdr_to_array(desc, desc->verf, verf, arrays, sz);
 
@@ -1084,10 +1120,22 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
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
@@ -1126,6 +1174,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	desc->file = file;
 	desc->ctx = ctx;
 	desc->plus = nfs_use_readdirplus(inode, ctx);
+	desc->page_index_max = -1;
 
 	spin_lock(&file->f_lock);
 	desc->dir_cookie = dir_ctx->dir_cookie;
@@ -1136,6 +1185,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	desc->last_cookie = dir_ctx->last_cookie;
 	desc->attr_gencount = dir_ctx->attr_gencount;
 	desc->eof = dir_ctx->eof;
+	nfs_set_dtsize(desc, dir_ctx->dtsize);
 	memcpy(desc->verf, dir_ctx->verf, sizeof(desc->verf));
 	spin_unlock(&file->f_lock);
 
@@ -1187,6 +1237,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
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

