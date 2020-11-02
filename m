Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752AC2A32AC
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 19:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgKBSRY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 13:17:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:40862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbgKBSRX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 2 Nov 2020 13:17:23 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25DD720786
        for <linux-nfs@vger.kernel.org>; Mon,  2 Nov 2020 18:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604341042;
        bh=MX9gUOTiRzTC7Q1Br1xS9KHS6tTZWrUZdvjwOWS+MtA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=chJ7gxPjTawpPEZHj7YdQ2KlPH0YujDIpZtyutetz88LuKmdcs7ZX8+k8luMy0aCV
         ktWkZA8CUuukiu1hk/O2FetWUrlWYPpWCD+krguaa9v8TlKJd9opV3/9M2pwRj3I0v
         CBKjhOw6AJ1zXVvQfBUzKagUsS0Oa4/mmRNn+OsM=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 04/12] NFS: Clean up directory array handling
Date:   Mon,  2 Nov 2020 13:06:50 -0500
Message-Id: <20201102180658.6218-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201102180658.6218-4-trondmy@kernel.org>
References: <20201102180658.6218-1-trondmy@kernel.org>
 <20201102180658.6218-2-trondmy@kernel.org>
 <20201102180658.6218-3-trondmy@kernel.org>
 <20201102180658.6218-4-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Refactor to use pagecache_get_page() so that we can fill the page
in multiple stages.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 134 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 73 insertions(+), 61 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 68acbde3f914..89cd8d5d9d3e 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -149,7 +149,7 @@ typedef struct nfs_readdir_descriptor {
 	struct file	*file;
 	struct page	*page;
 	struct dir_context *ctx;
-	unsigned long	page_index;
+	pgoff_t		page_index;
 	u64		dir_cookie;
 	u64		last_cookie;
 	u64		dup_cookie;
@@ -166,13 +166,18 @@ typedef struct nfs_readdir_descriptor {
 	bool eof;
 } nfs_readdir_descriptor_t;
 
-static
-void nfs_readdir_init_array(struct page *page)
+static void nfs_readdir_array_init(struct nfs_cache_array *array)
+{
+	memset(array, 0, sizeof(struct nfs_cache_array));
+}
+
+static void nfs_readdir_page_init_array(struct page *page, u64 last_cookie)
 {
 	struct nfs_cache_array *array;
 
 	array = kmap_atomic(page);
-	memset(array, 0, sizeof(struct nfs_cache_array));
+	nfs_readdir_array_init(array);
+	array->last_cookie = last_cookie;
 	kunmap_atomic(array);
 }
 
@@ -188,7 +193,7 @@ void nfs_readdir_clear_array(struct page *page)
 	array = kmap_atomic(page);
 	for (i = 0; i < array->size; i++)
 		kfree(array->array[i].string.name);
-	array->size = 0;
+	nfs_readdir_array_init(array);
 	kunmap_atomic(array);
 }
 
@@ -268,6 +273,45 @@ int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
 	return ret;
 }
 
+static struct page *nfs_readdir_page_get_locked(struct address_space *mapping,
+						pgoff_t index, u64 last_cookie)
+{
+	struct page *page;
+
+	page = pagecache_get_page(mapping, index, FGP_LOCK|FGP_WRITE|FGP_CREAT,
+				  mapping_gfp_mask(mapping));
+	if (page && !PageUptodate(page)) {
+		nfs_readdir_page_init_array(page, last_cookie);
+		if (invalidate_inode_pages2_range(mapping, index + 1, -1) < 0)
+			nfs_zap_mapping(mapping->host, mapping);
+		SetPageUptodate(page);
+	}
+
+	return page;
+}
+
+static u64 nfs_readdir_page_last_cookie(struct page *page)
+{
+	struct nfs_cache_array *array;
+	u64 ret;
+
+	array = kmap_atomic(page);
+	ret = array->last_cookie;
+	kunmap_atomic(array);
+	return ret;
+}
+
+static bool nfs_readdir_page_needs_filling(struct page *page)
+{
+	struct nfs_cache_array *array;
+	bool ret;
+
+	array = kmap_atomic(page);
+	ret = !nfs_readdir_array_is_full(array);
+	kunmap_atomic(array);
+	return ret;
+}
+
 static void nfs_readdir_page_set_eof(struct page *page)
 {
 	struct nfs_cache_array *array;
@@ -682,10 +726,8 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
 	int status = -ENOMEM;
 	unsigned int array_size = ARRAY_SIZE(pages);
 
-	nfs_readdir_init_array(page);
-
 	entry.prev_cookie = 0;
-	entry.cookie = desc->last_cookie;
+	entry.cookie = nfs_readdir_page_last_cookie(page);
 	entry.eof = 0;
 	entry.fh = nfs_alloc_fhandle();
 	entry.fattr = nfs_alloc_fattr();
@@ -730,48 +772,18 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
 	return status;
 }
 
-/*
- * Now we cache directories properly, by converting xdr information
- * to an array that can be used for lookups later.  This results in
- * fewer cache pages, since we can store more information on each page.
- * We only need to convert from xdr once so future lookups are much simpler
- */
-static
-int nfs_readdir_filler(void *data, struct page* page)
-{
-	nfs_readdir_descriptor_t *desc = data;
-	struct inode	*inode = file_inode(desc->file);
-	int ret;
-
-	ret = nfs_readdir_xdr_to_array(desc, page, inode);
-	if (ret < 0)
-		goto error;
-	SetPageUptodate(page);
-
-	if (invalidate_inode_pages2_range(inode->i_mapping, page->index + 1, -1) < 0) {
-		/* Should never happen */
-		nfs_zap_mapping(inode, inode->i_mapping);
-	}
-	unlock_page(page);
-	return 0;
- error:
-	nfs_readdir_clear_array(page);
-	unlock_page(page);
-	return ret;
-}
-
-static
-void cache_page_release(nfs_readdir_descriptor_t *desc)
+static void nfs_readdir_page_put(struct nfs_readdir_descriptor *desc)
 {
 	put_page(desc->page);
 	desc->page = NULL;
 }
 
-static
-struct page *get_cache_page(nfs_readdir_descriptor_t *desc)
+static struct page *
+nfs_readdir_page_get_cached(struct nfs_readdir_descriptor *desc)
 {
-	return read_cache_page(desc->file->f_mapping, desc->page_index,
-			nfs_readdir_filler, desc);
+	return nfs_readdir_page_get_locked(desc->file->f_mapping,
+					   desc->page_index,
+					   desc->last_cookie);
 }
 
 /*
@@ -785,23 +797,22 @@ int find_and_lock_cache_page(nfs_readdir_descriptor_t *desc)
 	struct nfs_inode *nfsi = NFS_I(inode);
 	int res;
 
-	desc->page = get_cache_page(desc);
-	if (IS_ERR(desc->page))
-		return PTR_ERR(desc->page);
-	res = lock_page_killable(desc->page);
-	if (res != 0)
-		goto error;
-	res = -EAGAIN;
-	if (desc->page->mapping != NULL) {
-		res = nfs_readdir_search_array(desc);
-		if (res == 0) {
-			nfsi->page_index = desc->page_index;
-			return 0;
-		}
+	desc->page = nfs_readdir_page_get_cached(desc);
+	if (!desc->page)
+		return -ENOMEM;
+	if (nfs_readdir_page_needs_filling(desc->page)) {
+		res = nfs_readdir_xdr_to_array(desc, desc->page, inode);
+		if (res < 0)
+			goto error;
+	}
+	res = nfs_readdir_search_array(desc);
+	if (res == 0) {
+		nfsi->page_index = desc->page_index;
+		return 0;
 	}
-	unlock_page(desc->page);
 error:
-	cache_page_release(desc);
+	unlock_page(desc->page);
+	nfs_readdir_page_put(desc);
 	return res;
 }
 
@@ -896,6 +907,7 @@ int uncached_readdir(nfs_readdir_descriptor_t *desc)
 	desc->page = page;
 	desc->duped = 0;
 
+	nfs_readdir_page_init_array(page, desc->dir_cookie);
 	status = nfs_readdir_xdr_to_array(desc, page, inode);
 	if (status < 0)
 		goto out_release;
@@ -904,7 +916,7 @@ int uncached_readdir(nfs_readdir_descriptor_t *desc)
 
  out_release:
 	nfs_readdir_clear_array(desc->page);
-	cache_page_release(desc);
+	nfs_readdir_page_put(desc);
  out:
 	dfprintk(DIRCACHE, "NFS: %s: returns %d\n",
 			__func__, status);
@@ -977,7 +989,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 
 		res = nfs_do_filldir(desc);
 		unlock_page(desc->page);
-		cache_page_release(desc);
+		nfs_readdir_page_put(desc);
 		if (res < 0)
 			break;
 	} while (!desc->eof);
-- 
2.28.0

