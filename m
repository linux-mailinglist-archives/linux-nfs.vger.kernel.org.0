Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832F94C5FDC
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 00:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbiB0XTW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 27 Feb 2022 18:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiB0XTV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 27 Feb 2022 18:19:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B1D22504
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 15:18:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52DB2611CE
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B1FC340E9
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646003923;
        bh=fhh1U4QR70Pa0Y1fZaEq0+cls0jdtmFosvUwDv450tc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BZcU+IJ+ccCoPysIlry3wkCsAKPU3z1diO8dqj2eVKvQZdqzWHNrR/HlqVVQfWAPr
         mPpnYfz4F5+ll3RKXVsSgwfEn7RdtLd/kYM17BTjAmcUak0kbWr8Hqsvn3h7xG2sSG
         lkc7D2zDOIpsPypSq2T6HFNlTh211xfzRyJY7TMDRkjEtAh8O07+mn9zViJfyNcz3V
         kVjAYV9V6jvY6P1nDkGoh2muN5dJn6ViX4ckEd8/k09cxJ0IFPTzJ1GXo/g7PWqIMJ
         FZyN//C3t8+EGk5fXRoUdZL/T/C6t2TzOb/ljGz+h/rLYtaHh7xVlz15D7zcWKtc2p
         rIGU7lX//T5kQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 23/27] NFS: Convert readdir page cache to use a cookie based index
Date:   Sun, 27 Feb 2022 18:12:23 -0500
Message-Id: <20220227231227.9038-24-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227231227.9038-23-trondmy@kernel.org>
References: <20220227231227.9038-1-trondmy@kernel.org>
 <20220227231227.9038-2-trondmy@kernel.org>
 <20220227231227.9038-3-trondmy@kernel.org>
 <20220227231227.9038-4-trondmy@kernel.org>
 <20220227231227.9038-5-trondmy@kernel.org>
 <20220227231227.9038-6-trondmy@kernel.org>
 <20220227231227.9038-7-trondmy@kernel.org>
 <20220227231227.9038-8-trondmy@kernel.org>
 <20220227231227.9038-9-trondmy@kernel.org>
 <20220227231227.9038-10-trondmy@kernel.org>
 <20220227231227.9038-11-trondmy@kernel.org>
 <20220227231227.9038-12-trondmy@kernel.org>
 <20220227231227.9038-13-trondmy@kernel.org>
 <20220227231227.9038-14-trondmy@kernel.org>
 <20220227231227.9038-15-trondmy@kernel.org>
 <20220227231227.9038-16-trondmy@kernel.org>
 <20220227231227.9038-17-trondmy@kernel.org>
 <20220227231227.9038-18-trondmy@kernel.org>
 <20220227231227.9038-19-trondmy@kernel.org>
 <20220227231227.9038-20-trondmy@kernel.org>
 <20220227231227.9038-21-trondmy@kernel.org>
 <20220227231227.9038-22-trondmy@kernel.org>
 <20220227231227.9038-23-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Instead of using a linear index to address the pages, use the cookie of
the first entry, since that is what we use to match the page anyway.

This allows us to avoid re-reading the entire cache on a seekdir() type
of operation. The latter is very common when re-exporting NFS, and is a
major performance drain.

The change does affect our duplicate cookie detection, since we can no
longer rely on the page index as a linear offset for detecting whether
we looped backwards. However since we no longer do a linear search
through all the pages on each call to nfs_readdir(), this is less of a
concern than it was previously.
The other downside is that invalidate_mapping_pages() no longer can use
the page index to avoid clearing pages that have been read. A subsequent
patch will restore the functionality this provides to the 'ls -l'
heuristic.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/Kconfig         |   4 ++
 fs/nfs/dir.c           | 149 ++++++++++++++++++-----------------------
 include/linux/nfs_fs.h |   2 -
 3 files changed, 69 insertions(+), 86 deletions(-)

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 14a72224b657..47a53b3362b6 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -4,6 +4,10 @@ config NFS_FS
 	depends on INET && FILE_LOCKING && MULTIUSER
 	select LOCKD
 	select SUNRPC
+	select CRYPTO
+	select CRYPTO_HASH
+	select XXHASH
+	select CRYPTO_XXHASH
 	select NFS_ACL_SUPPORT if NFS_V3_ACL
 	help
 	  Choose Y here if you want to access files residing on other
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 95a29a973dc8..707ad0fd5a4e 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -39,6 +39,7 @@
 #include <linux/sched.h>
 #include <linux/kmemleak.h>
 #include <linux/xattr.h>
+#include <linux/xxhash.h>
 
 #include "delegation.h"
 #include "iostat.h"
@@ -159,9 +160,7 @@ struct nfs_readdir_descriptor {
 	pgoff_t		page_index_max;
 	u64		dir_cookie;
 	u64		last_cookie;
-	u64		dup_cookie;
 	loff_t		current_index;
-	loff_t		prev_index;
 
 	__be32		verf[NFS_DIR_VERIFIER_SIZE];
 	unsigned long	dir_verifier;
@@ -171,7 +170,6 @@ struct nfs_readdir_descriptor {
 	unsigned int	cache_entry_index;
 	unsigned int	buffer_fills;
 	unsigned int	dtsize;
-	signed char duped;
 	bool plus;
 	bool eob;
 	bool eof;
@@ -331,6 +329,28 @@ int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
 	return ret;
 }
 
+#define NFS_READDIR_COOKIE_MASK (U32_MAX >> 14)
+/*
+ * Hash algorithm allowing content addressible access to sequences
+ * of directory cookies. Content is addressed by the value of the
+ * cookie index of the first readdir entry in a page.
+ *
+ * The xxhash algorithm is chosen because it is fast, and is supposed
+ * to result in a decent flat distribution of hashes.
+ *
+ * We then select only the first 18 bits to avoid issues with excessive
+ * memory use for the page cache XArray. 18 bits should allow the caching
+ * of 262144 pages of sequences of readdir entries. Since each page holds
+ * 127 readdir entries for a typical 64-bit system, that works out to a
+ * cache of ~ 33 million entries per directory.
+ */
+static pgoff_t nfs_readdir_page_cookie_hash(u64 cookie)
+{
+	if (cookie == 0)
+		return 0;
+	return xxhash(&cookie, sizeof(cookie), 0) & NFS_READDIR_COOKIE_MASK;
+}
+
 static bool nfs_readdir_page_validate(struct page *page, u64 last_cookie,
 				      u64 change_attr)
 {
@@ -352,15 +372,15 @@ static void nfs_readdir_page_unlock_and_put(struct page *page)
 }
 
 static struct page *nfs_readdir_page_get_locked(struct address_space *mapping,
-						pgoff_t index, u64 last_cookie)
+						u64 last_cookie,
+						u64 change_attr)
 {
+	pgoff_t index = nfs_readdir_page_cookie_hash(last_cookie);
 	struct page *page;
-	u64 change_attr;
 
 	page = grab_cache_page(mapping, index);
 	if (!page)
 		return NULL;
-	change_attr = inode_peek_iversion_raw(mapping->host);
 	if (PageUptodate(page)) {
 		if (nfs_readdir_page_validate(page, last_cookie, change_attr))
 			return page;
@@ -371,11 +391,6 @@ static struct page *nfs_readdir_page_get_locked(struct address_space *mapping,
 	return page;
 }
 
-static loff_t nfs_readdir_page_offset(struct page *page)
-{
-	return (loff_t)page->index * (loff_t)nfs_readdir_array_maxentries();
-}
-
 static u64 nfs_readdir_page_last_cookie(struct page *page)
 {
 	struct nfs_cache_array *array;
@@ -408,11 +423,11 @@ static void nfs_readdir_page_set_eof(struct page *page)
 }
 
 static struct page *nfs_readdir_page_get_next(struct address_space *mapping,
-					      pgoff_t index, u64 cookie)
+					      u64 cookie, u64 change_attr)
 {
 	struct page *page;
 
-	page = nfs_readdir_page_get_locked(mapping, index, cookie);
+	page = nfs_readdir_page_get_locked(mapping, cookie, change_attr);
 	if (page) {
 		if (nfs_readdir_page_last_cookie(page) == cookie)
 			return page;
@@ -452,6 +467,13 @@ static void nfs_readdir_seek_next_array(struct nfs_cache_array *array,
 		desc->last_cookie = array->array[0].cookie;
 }
 
+static void nfs_readdir_rewind_search(struct nfs_readdir_descriptor *desc)
+{
+	desc->current_index = 0;
+	desc->last_cookie = 0;
+	desc->page_index = 0;
+}
+
 static int nfs_readdir_search_for_pos(struct nfs_cache_array *array,
 				      struct nfs_readdir_descriptor *desc)
 {
@@ -492,8 +514,7 @@ static bool nfs_readdir_array_cookie_in_range(struct nfs_cache_array *array,
 static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
 					 struct nfs_readdir_descriptor *desc)
 {
-	int i;
-	loff_t new_pos;
+	unsigned int i;
 	int status = -EAGAIN;
 
 	if (!nfs_readdir_array_cookie_in_range(array, desc->dir_cookie))
@@ -501,32 +522,10 @@ static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
 
 	for (i = 0; i < array->size; i++) {
 		if (array->array[i].cookie == desc->dir_cookie) {
-			struct nfs_inode *nfsi = NFS_I(file_inode(desc->file));
-
-			new_pos = nfs_readdir_page_offset(desc->page) + i;
-			if (desc->attr_gencount != nfsi->attr_gencount) {
-				desc->duped = 0;
-				desc->attr_gencount = nfsi->attr_gencount;
-			} else if (new_pos < desc->prev_index) {
-				if (desc->duped > 0
-				    && desc->dup_cookie == desc->dir_cookie) {
-					if (printk_ratelimit()) {
-						pr_notice("NFS: directory %pD2 contains a readdir loop."
-								"Please contact your server vendor.  "
-								"The file: %s has duplicate cookie %llu\n",
-								desc->file, array->array[i].name, desc->dir_cookie);
-					}
-					status = -ELOOP;
-					goto out;
-				}
-				desc->dup_cookie = desc->dir_cookie;
-				desc->duped = -1;
-			}
 			if (nfs_readdir_use_cookie(desc->file))
 				desc->ctx->pos = desc->dir_cookie;
 			else
-				desc->ctx->pos = new_pos;
-			desc->prev_index = new_pos;
+				desc->ctx->pos = desc->current_index + i;
 			desc->cache_entry_index = i;
 			return 0;
 		}
@@ -538,7 +537,6 @@ static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
 			desc->eof = true;
 	} else
 		nfs_readdir_seek_next_array(array, desc);
-out:
 	return status;
 }
 
@@ -783,10 +781,9 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 /* Perform conversion from xdr to cache array */
 static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 				   struct nfs_entry *entry,
-				   struct page **xdr_pages,
-				   unsigned int buflen,
-				   struct page **arrays,
-				   size_t narrays)
+				   struct page **xdr_pages, unsigned int buflen,
+				   struct page **arrays, size_t narrays,
+				   u64 change_attr)
 {
 	struct address_space *mapping = desc->file->f_mapping;
 	struct xdr_stream stream;
@@ -826,18 +823,16 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 				break;
 			arrays++;
 			*arrays = page = new;
-			desc->page_index_max++;
 		} else {
-			new = nfs_readdir_page_get_next(mapping,
-							page->index + 1,
-							entry->prev_cookie);
+			new = nfs_readdir_page_get_next(
+				mapping, entry->prev_cookie, change_attr);
 			if (!new)
 				break;
 			if (page != *arrays)
 				nfs_readdir_page_unlock_and_put(page);
 			page = new;
-			desc->page_index_max = new->index;
 		}
+		desc->page_index_max++;
 		status = nfs_readdir_add_to_array(entry, page);
 	} while (!status && !entry->eof);
 
@@ -897,6 +892,7 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 				    __be32 *verf_arg, __be32 *verf_res,
 				    struct page **arrays, size_t narrays)
 {
+	u64 change_attr;
 	struct page **pages;
 	struct page *page = *arrays;
 	struct nfs_entry *entry;
@@ -921,6 +917,7 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 	if (!pages)
 		goto out;
 
+	change_attr = inode_peek_iversion_raw(inode);
 	status = nfs_readdir_xdr_filler(desc, verf_arg, entry->cookie, pages,
 					dtsize, verf_res);
 	if (status < 0)
@@ -929,7 +926,7 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 	pglen = status;
 	if (pglen != 0)
 		status = nfs_readdir_page_filler(desc, entry, pages, pglen,
-						 arrays, narrays);
+						 arrays, narrays, change_attr);
 	else
 		nfs_readdir_page_set_eof(page);
 	desc->buffer_fills++;
@@ -959,9 +956,11 @@ nfs_readdir_page_unlock_and_put_cached(struct nfs_readdir_descriptor *desc)
 static struct page *
 nfs_readdir_page_get_cached(struct nfs_readdir_descriptor *desc)
 {
-	return nfs_readdir_page_get_locked(desc->file->f_mapping,
-					   desc->page_index,
-					   desc->last_cookie);
+	struct address_space *mapping = desc->file->f_mapping;
+	u64 change_attr = inode_peek_iversion_raw(mapping->host);
+
+	return nfs_readdir_page_get_locked(mapping, desc->last_cookie,
+					   change_attr);
 }
 
 /*
@@ -993,7 +992,7 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 			trace_nfs_readdir_cache_fill_done(inode, res);
 			if (res == -EBADCOOKIE || res == -ENOTSYNC) {
 				invalidate_inode_pages2(desc->file->f_mapping);
-				desc->page_index = 0;
+				nfs_readdir_rewind_search(desc);
 				trace_nfs_readdir_invalidate_cache_range(
 					inode, 0, MAX_LFS_FILESIZE);
 				return -EAGAIN;
@@ -1007,12 +1006,10 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 		    memcmp(nfsi->cookieverf, verf, sizeof(nfsi->cookieverf))) {
 			memcpy(nfsi->cookieverf, verf,
 			       sizeof(nfsi->cookieverf));
-			invalidate_inode_pages2_range(desc->file->f_mapping,
-						      desc->page_index_max + 1,
+			invalidate_inode_pages2_range(desc->file->f_mapping, 1,
 						      -1);
 			trace_nfs_readdir_invalidate_cache_range(
-				inode, desc->page_index_max + 1,
-				MAX_LFS_FILESIZE);
+				inode, 1, MAX_LFS_FILESIZE);
 		}
 	}
 	res = nfs_readdir_search_array(desc);
@@ -1028,11 +1025,6 @@ static int readdir_search_pagecache(struct nfs_readdir_descriptor *desc)
 	int res;
 
 	do {
-		if (desc->page_index == 0) {
-			desc->current_index = 0;
-			desc->prev_index = 0;
-			desc->last_cookie = 0;
-		}
 		res = find_and_lock_cache_page(desc);
 	} while (res == -EAGAIN);
 	return res;
@@ -1070,8 +1062,6 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
 			desc->ctx->pos = desc->dir_cookie;
 		else
 			desc->ctx->pos++;
-		if (desc->duped != 0)
-			desc->duped = 1;
 	}
 	if (array->page_is_eof)
 		desc->eof = !desc->eob;
@@ -1113,7 +1103,6 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 	desc->page_index = 0;
 	desc->cache_entry_index = 0;
 	desc->last_cookie = desc->dir_cookie;
-	desc->duped = 0;
 	desc->page_index_max = 0;
 
 	trace_nfs_readdir_uncached(desc->file, desc->verf, desc->last_cookie,
@@ -1146,6 +1135,8 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 	for (i = 0; i < sz && arrays[i]; i++)
 		nfs_readdir_page_array_free(arrays[i]);
 out:
+	if (!nfs_readdir_use_cookie(desc->file))
+		nfs_readdir_rewind_search(desc);
 	desc->page_index_max = -1;
 	kfree(arrays);
 	dfprintk(DIRCACHE, "NFS: %s: returns %d\n", __func__, status);
@@ -1156,17 +1147,14 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 
 static void nfs_readdir_handle_cache_misses(struct inode *inode,
 					    struct nfs_readdir_descriptor *desc,
-					    pgoff_t page_index,
 					    unsigned int cache_misses)
 {
 	if (desc->ctx->pos == 0 ||
 	    cache_misses <= NFS_READDIR_CACHE_MISS_THRESHOLD)
 		return;
-	if (invalidate_mapping_pages(inode->i_mapping, page_index + 1, -1) == 0)
+	if (invalidate_mapping_pages(inode->i_mapping, 0, -1) == 0)
 		return;
-	trace_nfs_readdir_invalidate_cache_range(
-		inode, (loff_t)(page_index + 1) << PAGE_SHIFT,
-		MAX_LFS_FILESIZE);
+	trace_nfs_readdir_invalidate_cache_range(inode, 0, MAX_LFS_FILESIZE);
 }
 
 /* The file offset position represents the dirent entry number.  A
@@ -1181,7 +1169,6 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	struct nfs_open_dir_context *dir_ctx = file->private_data;
 	struct nfs_readdir_descriptor *desc;
 	unsigned int cache_hits, cache_misses;
-	pgoff_t page_index;
 	int res;
 
 	dfprintk(FILE, "NFS: readdir(%pD2) starting at cookie %llu\n",
@@ -1206,10 +1193,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 
 	spin_lock(&file->f_lock);
 	desc->dir_cookie = dir_ctx->dir_cookie;
-	desc->dup_cookie = dir_ctx->dup_cookie;
-	desc->duped = dir_ctx->duped;
-	page_index = dir_ctx->page_index;
-	desc->page_index = page_index;
+	desc->page_index = dir_ctx->page_index;
 	desc->last_cookie = dir_ctx->last_cookie;
 	desc->attr_gencount = dir_ctx->attr_gencount;
 	desc->eof = dir_ctx->eof;
@@ -1225,7 +1209,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	}
 
 	desc->plus = nfs_use_readdirplus(inode, ctx, cache_hits, cache_misses);
-	nfs_readdir_handle_cache_misses(inode, desc, page_index, cache_misses);
+	nfs_readdir_handle_cache_misses(inode, desc, cache_misses);
 
 	do {
 		res = readdir_search_pagecache(desc);
@@ -1245,7 +1229,6 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 		}
 		if (res == -ETOOSMALL && desc->plus) {
 			nfs_zap_caches(inode);
-			desc->page_index = 0;
 			desc->plus = false;
 			desc->eof = false;
 			continue;
@@ -1259,9 +1242,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 
 	spin_lock(&file->f_lock);
 	dir_ctx->dir_cookie = desc->dir_cookie;
-	dir_ctx->dup_cookie = desc->dup_cookie;
 	dir_ctx->last_cookie = desc->last_cookie;
-	dir_ctx->duped = desc->duped;
 	dir_ctx->attr_gencount = desc->attr_gencount;
 	dir_ctx->page_index = desc->page_index;
 	dir_ctx->eof = desc->eof;
@@ -1304,13 +1285,13 @@ static loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int whence)
 	if (offset != filp->f_pos) {
 		filp->f_pos = offset;
 		dir_ctx->page_index = 0;
-		if (!nfs_readdir_use_cookie(filp))
+		if (!nfs_readdir_use_cookie(filp)) {
 			dir_ctx->dir_cookie = 0;
-		else
+			dir_ctx->last_cookie = 0;
+		} else {
 			dir_ctx->dir_cookie = offset;
-		if (offset == 0)
-			memset(dir_ctx->verf, 0, sizeof(dir_ctx->verf));
-		dir_ctx->duped = 0;
+			dir_ctx->last_cookie = offset;
+		}
 		dir_ctx->eof = false;
 	}
 	spin_unlock(&filp->f_lock);
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 20a4cf0acad2..42aad886d3c0 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -106,11 +106,9 @@ struct nfs_open_dir_context {
 	unsigned long attr_gencount;
 	__be32	verf[NFS_DIR_VERIFIER_SIZE];
 	__u64 dir_cookie;
-	__u64 dup_cookie;
 	__u64 last_cookie;
 	pgoff_t page_index;
 	unsigned int dtsize;
-	signed char duped;
 	bool eof;
 	struct rcu_head rcu_head;
 };
-- 
2.35.1

