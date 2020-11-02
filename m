Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902E82A32B4
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 19:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgKBSR2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 13:17:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:40862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbgKBSR1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 2 Nov 2020 13:17:27 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FE402222B
        for <linux-nfs@vger.kernel.org>; Mon,  2 Nov 2020 18:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604341046;
        bh=XVXBt4Tj7nqalGynpZA6CSK0J9bdcHzViYb2QRauuk4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=k6rLGh6GwPmS8ff+9KocyWM4cmzA+7QX3RzZc6qAO8zRP9XueXGGkDwsIckEakatQ
         3qfc9z669Y1Fls5fZCrlPU7GZwpRCQh2D++oxAISkDucrGzJrnw1AHG1ZR2Ko+ZPNd
         X5MzSWQ4uoBPdJhaQgkFRvw5p0P0Tj3nhgyt3b64=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 12/12] NFS: Reduce readdir stack usage
Date:   Mon,  2 Nov 2020 13:06:58 -0500
Message-Id: <20201102180658.6218-13-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201102180658.6218-12-trondmy@kernel.org>
References: <20201102180658.6218-1-trondmy@kernel.org>
 <20201102180658.6218-2-trondmy@kernel.org>
 <20201102180658.6218-3-trondmy@kernel.org>
 <20201102180658.6218-4-trondmy@kernel.org>
 <20201102180658.6218-5-trondmy@kernel.org>
 <20201102180658.6218-6-trondmy@kernel.org>
 <20201102180658.6218-7-trondmy@kernel.org>
 <20201102180658.6218-8-trondmy@kernel.org>
 <20201102180658.6218-9-trondmy@kernel.org>
 <20201102180658.6218-10-trondmy@kernel.org>
 <20201102180658.6218-11-trondmy@kernel.org>
 <20201102180658.6218-12-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The descriptor and the struct nfs_entry are both large structures,
so don't allocate them from the stack.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 88 +++++++++++++++++++++++++++-------------------------
 1 file changed, 46 insertions(+), 42 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index a2cebd365948..966e8fc6c9b7 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -144,7 +144,7 @@ struct nfs_cache_array {
 	struct nfs_cache_array_entry array[];
 };
 
-typedef struct nfs_readdir_descriptor {
+struct nfs_readdir_descriptor {
 	struct file	*file;
 	struct page	*page;
 	struct dir_context *ctx;
@@ -163,7 +163,7 @@ typedef struct nfs_readdir_descriptor {
 	signed char duped;
 	bool plus;
 	bool eof;
-} nfs_readdir_descriptor_t;
+};
 
 static void nfs_readdir_array_init(struct nfs_cache_array *array)
 {
@@ -358,8 +358,8 @@ bool nfs_readdir_use_cookie(const struct file *filp)
 	return true;
 }
 
-static
-int nfs_readdir_search_for_pos(struct nfs_cache_array *array, nfs_readdir_descriptor_t *desc)
+static int nfs_readdir_search_for_pos(struct nfs_cache_array *array,
+				      struct nfs_readdir_descriptor *desc)
 {
 	loff_t diff = desc->ctx->pos - desc->current_index;
 	unsigned int index;
@@ -390,8 +390,8 @@ nfs_readdir_inode_mapping_valid(struct nfs_inode *nfsi)
 	return !test_bit(NFS_INO_INVALIDATING, &nfsi->flags);
 }
 
-static
-int nfs_readdir_search_for_cookie(struct nfs_cache_array *array, nfs_readdir_descriptor_t *desc)
+static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
+					 struct nfs_readdir_descriptor *desc)
 {
 	int i;
 	loff_t new_pos;
@@ -439,8 +439,7 @@ int nfs_readdir_search_for_cookie(struct nfs_cache_array *array, nfs_readdir_des
 	return status;
 }
 
-static
-int nfs_readdir_search_array(nfs_readdir_descriptor_t *desc)
+static int nfs_readdir_search_array(struct nfs_readdir_descriptor *desc)
 {
 	struct nfs_cache_array *array;
 	int status;
@@ -493,7 +492,7 @@ static int nfs_readdir_xdr_filler(struct nfs_readdir_descriptor *desc,
 	return error;
 }
 
-static int xdr_decode(nfs_readdir_descriptor_t *desc,
+static int xdr_decode(struct nfs_readdir_descriptor *desc,
 		      struct nfs_entry *entry, struct xdr_stream *xdr)
 {
 	struct inode *inode = file_inode(desc->file);
@@ -757,27 +756,28 @@ static struct page **nfs_readdir_alloc_pages(size_t npages)
 	return NULL;
 }
 
-static
-int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page, struct inode *inode)
+static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
+				    struct page *page, struct inode *inode)
 {
 	struct page **pages;
-	struct nfs_entry entry;
+	struct nfs_entry *entry;
 	size_t array_size;
 	size_t dtsize = NFS_SERVER(inode)->dtsize;
 	int status = -ENOMEM;
 
-	entry.prev_cookie = 0;
-	entry.cookie = nfs_readdir_page_last_cookie(page);
-	entry.eof = 0;
-	entry.fh = nfs_alloc_fhandle();
-	entry.fattr = nfs_alloc_fattr();
-	entry.server = NFS_SERVER(inode);
-	if (entry.fh == NULL || entry.fattr == NULL)
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+	entry->cookie = nfs_readdir_page_last_cookie(page);
+	entry->fh = nfs_alloc_fhandle();
+	entry->fattr = nfs_alloc_fattr();
+	entry->server = NFS_SERVER(inode);
+	if (entry->fh == NULL || entry->fattr == NULL)
 		goto out;
 
-	entry.label = nfs4_label_alloc(NFS_SERVER(inode), GFP_NOWAIT);
-	if (IS_ERR(entry.label)) {
-		status = PTR_ERR(entry.label);
+	entry->label = nfs4_label_alloc(NFS_SERVER(inode), GFP_NOWAIT);
+	if (IS_ERR(entry->label)) {
+		status = PTR_ERR(entry->label);
 		goto out;
 	}
 
@@ -788,7 +788,7 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
 
 	do {
 		unsigned int pglen;
-		status = nfs_readdir_xdr_filler(desc, entry.cookie,
+		status = nfs_readdir_xdr_filler(desc, entry->cookie,
 						pages, dtsize);
 		if (status < 0)
 			break;
@@ -799,15 +799,16 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
 			break;
 		}
 
-		status = nfs_readdir_page_filler(desc, &entry, pages, page, pglen);
+		status = nfs_readdir_page_filler(desc, entry, pages, page, pglen);
 	} while (!status && nfs_readdir_page_needs_filling(page));
 
 	nfs_readdir_free_pages(pages, array_size);
 out_release_label:
-	nfs4_label_free(entry.label);
+	nfs4_label_free(entry->label);
 out:
-	nfs_free_fattr(entry.fattr);
-	nfs_free_fhandle(entry.fh);
+	nfs_free_fattr(entry->fattr);
+	nfs_free_fhandle(entry->fh);
+	kfree(entry);
 	return status;
 }
 
@@ -829,8 +830,7 @@ nfs_readdir_page_get_cached(struct nfs_readdir_descriptor *desc)
  * Returns 0 if desc->dir_cookie was found on page desc->page_index
  * and locks the page to prevent removal from the page cache.
  */
-static
-int find_and_lock_cache_page(nfs_readdir_descriptor_t *desc)
+static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 {
 	struct inode *inode = file_inode(desc->file);
 	struct nfs_inode *nfsi = NFS_I(inode);
@@ -856,8 +856,7 @@ int find_and_lock_cache_page(nfs_readdir_descriptor_t *desc)
 }
 
 /* Search for desc->dir_cookie from the beginning of the page cache */
-static inline
-int readdir_search_pagecache(nfs_readdir_descriptor_t *desc)
+static int readdir_search_pagecache(struct nfs_readdir_descriptor *desc)
 {
 	int res;
 
@@ -922,8 +921,7 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc)
  *	 we should already have a complete representation of the
  *	 directory in the page cache by the time we get here.
  */
-static inline
-int uncached_readdir(nfs_readdir_descriptor_t *desc)
+static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 {
 	struct page	*page = NULL;
 	int		status;
@@ -968,13 +966,8 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	struct dentry	*dentry = file_dentry(file);
 	struct inode	*inode = d_inode(dentry);
 	struct nfs_open_dir_context *dir_ctx = file->private_data;
-	nfs_readdir_descriptor_t my_desc = {
-		.file = file,
-		.ctx = ctx,
-		.plus = nfs_use_readdirplus(inode, ctx),
-	},
-			*desc = &my_desc;
-	int res = 0;
+	struct nfs_readdir_descriptor *desc;
+	int res;
 
 	dfprintk(FILE, "NFS: readdir(%pD2) starting at cookie %llu\n",
 			file, (long long)ctx->pos);
@@ -986,10 +979,19 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	 * to either find the entry with the appropriate number or
 	 * revalidate the cookie.
 	 */
-	if (ctx->pos == 0 || nfs_attribute_cache_expired(inode))
+	if (ctx->pos == 0 || nfs_attribute_cache_expired(inode)) {
 		res = nfs_revalidate_mapping(inode, file->f_mapping);
-	if (res < 0)
+		if (res < 0)
+			goto out;
+	}
+
+	res = -ENOMEM;
+	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+	if (!desc)
 		goto out;
+	desc->file = file;
+	desc->ctx = ctx;
+	desc->plus = nfs_use_readdirplus(inode, ctx);
 
 	spin_lock(&file->f_lock);
 	desc->dir_cookie = dir_ctx->dir_cookie;
@@ -1035,6 +1037,8 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	dir_ctx->attr_gencount = desc->attr_gencount;
 	spin_unlock(&file->f_lock);
 
+	kfree(desc);
+
 out:
 	dfprintk(FILE, "NFS: readdir(%pD2) returns %d\n", file, res);
 	return res;
-- 
2.28.0

