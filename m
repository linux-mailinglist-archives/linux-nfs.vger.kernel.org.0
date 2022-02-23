Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6706E4C1D9D
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 22:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242588AbiBWVVL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 16:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242497AbiBWVUK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 16:20:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317CF4EA0A
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:19:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6C6EB8212F
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 21:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496F1C340F1
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 21:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645651179;
        bh=wC/Iuh9TiAFJhNOx7yqp4b/DX+FY+Q9iNdfYCRkaUsw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=P+0Z6/7pu5G0PGMbY9FcHLlfgjiqsimbIFKsWuK0ZOHnuf3ms4e1bazzfWoYY5g/i
         VuDpLyeFqNTnUoudwRuAcMKeFfuXdV7JKoVM9nP9mWE5xLXx/FUNN8Bhby6CIGokxy
         PKWUfSuyzoID8RRZYPgbaFKdoK2IRIuBtiL0RolSKUngy0jWdNXl8cP8fcm2RXAo1h
         ukmo/NuQwuzDsHIT2sX6WQJj4HsfhnW3UJU5SiE14dHn33+JU5loRcwDH1JYNR8G+n
         sZSZ8ztBTRQ1o4aXifxZ/SmG0oitT4tLtlwBCBheAAK2a98/fDGDSfg80qjQQrxD6t
         BXhaHbh4Yqb6Q==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 19/21] NFS: Convert readdir page cache to use a cookie based index
Date:   Wed, 23 Feb 2022 16:13:03 -0500
Message-Id: <20220223211305.296816-20-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220223211305.296816-19-trondmy@kernel.org>
References: <20220223211305.296816-1-trondmy@kernel.org>
 <20220223211305.296816-2-trondmy@kernel.org>
 <20220223211305.296816-3-trondmy@kernel.org>
 <20220223211305.296816-4-trondmy@kernel.org>
 <20220223211305.296816-5-trondmy@kernel.org>
 <20220223211305.296816-6-trondmy@kernel.org>
 <20220223211305.296816-7-trondmy@kernel.org>
 <20220223211305.296816-8-trondmy@kernel.org>
 <20220223211305.296816-9-trondmy@kernel.org>
 <20220223211305.296816-10-trondmy@kernel.org>
 <20220223211305.296816-11-trondmy@kernel.org>
 <20220223211305.296816-12-trondmy@kernel.org>
 <20220223211305.296816-13-trondmy@kernel.org>
 <20220223211305.296816-14-trondmy@kernel.org>
 <20220223211305.296816-15-trondmy@kernel.org>
 <20220223211305.296816-16-trondmy@kernel.org>
 <20220223211305.296816-17-trondmy@kernel.org>
 <20220223211305.296816-18-trondmy@kernel.org>
 <20220223211305.296816-19-trondmy@kernel.org>
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
 fs/nfs/dir.c           | 99 +++++++++++++++---------------------------
 include/linux/nfs_fs.h |  2 -
 2 files changed, 34 insertions(+), 67 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 06bd612296d5..2007eebfb5cf 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -39,6 +39,7 @@
 #include <linux/sched.h>
 #include <linux/kmemleak.h>
 #include <linux/xattr.h>
+#include <linux/xxhash.h>
 
 #include "delegation.h"
 #include "iostat.h"
@@ -158,9 +159,7 @@ struct nfs_readdir_descriptor {
 	pgoff_t		page_index_max;
 	u64		dir_cookie;
 	u64		last_cookie;
-	u64		dup_cookie;
 	loff_t		current_index;
-	loff_t		prev_index;
 
 	__be32		verf[NFS_DIR_VERIFIER_SIZE];
 	unsigned long	dir_verifier;
@@ -170,7 +169,6 @@ struct nfs_readdir_descriptor {
 	unsigned int	cache_entry_index;
 	unsigned int	buffer_fills;
 	unsigned int	dtsize;
-	signed char duped;
 	bool plus;
 	bool eob;
 	bool eof;
@@ -333,6 +331,13 @@ int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
 	return ret;
 }
 
+static pgoff_t nfs_readdir_page_cookie_hash(u64 cookie)
+{
+	if (cookie == 0)
+		return 0;
+	return xxhash(&cookie, sizeof(cookie), 0);
+}
+
 static bool nfs_readdir_page_cookie_match(struct page *page, u64 last_cookie,
 					  u64 change_attr)
 {
@@ -354,8 +359,9 @@ static void nfs_readdir_page_unlock_and_put(struct page *page)
 }
 
 static struct page *nfs_readdir_page_get_locked(struct address_space *mapping,
-						pgoff_t index, u64 last_cookie)
+						u64 last_cookie)
 {
+	pgoff_t index = nfs_readdir_page_cookie_hash(last_cookie);
 	struct page *page;
 	u64 change_attr;
 
@@ -374,11 +380,6 @@ static struct page *nfs_readdir_page_get_locked(struct address_space *mapping,
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
@@ -411,11 +412,11 @@ static void nfs_readdir_page_set_eof(struct page *page)
 }
 
 static struct page *nfs_readdir_page_get_next(struct address_space *mapping,
-					      pgoff_t index, u64 cookie)
+					      u64 cookie)
 {
 	struct page *page;
 
-	page = nfs_readdir_page_get_locked(mapping, index, cookie);
+	page = nfs_readdir_page_get_locked(mapping, cookie);
 	if (page) {
 		if (nfs_readdir_page_last_cookie(page) == cookie)
 			return page;
@@ -443,6 +444,13 @@ bool nfs_readdir_use_cookie(const struct file *filp)
 	return true;
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
@@ -491,32 +499,11 @@ static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
 
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
+			new_pos = desc->current_index + i;
 			if (nfs_readdir_use_cookie(desc->file))
 				desc->ctx->pos = desc->dir_cookie;
 			else
 				desc->ctx->pos = new_pos;
-			desc->prev_index = new_pos;
 			desc->cache_entry_index = i;
 			return 0;
 		}
@@ -527,7 +514,6 @@ static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
 		if (desc->dir_cookie == array->last_cookie)
 			desc->eof = true;
 	}
-out:
 	return status;
 }
 
@@ -820,18 +806,16 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 				break;
 			arrays++;
 			*arrays = page = new;
-			desc->page_index_max++;
 		} else {
 			new = nfs_readdir_page_get_next(mapping,
-							page->index + 1,
 							entry->prev_cookie);
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
 
@@ -954,7 +938,6 @@ static struct page *
 nfs_readdir_page_get_cached(struct nfs_readdir_descriptor *desc)
 {
 	return nfs_readdir_page_get_locked(desc->file->f_mapping,
-					   desc->page_index,
 					   desc->last_cookie);
 }
 
@@ -984,7 +967,7 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 			trace_nfs_readdir_cache_fill_done(inode, res);
 			if (res == -EBADCOOKIE || res == -ENOTSYNC) {
 				invalidate_inode_pages2(desc->file->f_mapping);
-				desc->page_index = 0;
+				nfs_readdir_rewind_search(desc);
 				trace_nfs_readdir_invalidate_cache_range(
 					inode, 0, MAX_LFS_FILESIZE);
 				return -EAGAIN;
@@ -998,12 +981,10 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
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
@@ -1019,11 +1000,6 @@ static int readdir_search_pagecache(struct nfs_readdir_descriptor *desc)
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
@@ -1058,8 +1034,6 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
 			desc->ctx->pos = desc->dir_cookie;
 		else
 			desc->ctx->pos++;
-		if (desc->duped != 0)
-			desc->duped = 1;
 	}
 	if (array->page_is_eof)
 		desc->eof = !desc->eob;
@@ -1101,7 +1075,6 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 	desc->page_index = 0;
 	desc->cache_entry_index = 0;
 	desc->last_cookie = desc->dir_cookie;
-	desc->duped = 0;
 	desc->page_index_max = 0;
 
 	trace_nfs_readdir_uncached(desc->file, desc->verf, desc->last_cookie,
@@ -1134,6 +1107,8 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 	for (i = 0; i < sz && arrays[i]; i++)
 		nfs_readdir_page_array_free(arrays[i]);
 out:
+	if (!nfs_readdir_use_cookie(desc->file))
+		nfs_readdir_rewind_search(desc);
 	desc->page_index_max = -1;
 	kfree(arrays);
 	dfprintk(DIRCACHE, "NFS: %s: returns %d\n", __func__, status);
@@ -1144,17 +1119,14 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 
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
@@ -1194,8 +1166,6 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 
 	spin_lock(&file->f_lock);
 	desc->dir_cookie = dir_ctx->dir_cookie;
-	desc->dup_cookie = dir_ctx->dup_cookie;
-	desc->duped = dir_ctx->duped;
 	page_index = dir_ctx->page_index;
 	desc->page_index = page_index;
 	desc->last_cookie = dir_ctx->last_cookie;
@@ -1213,7 +1183,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	}
 
 	desc->plus = nfs_use_readdirplus(inode, ctx, cache_hits, cache_misses);
-	nfs_readdir_handle_cache_misses(inode, desc, page_index, cache_misses);
+	nfs_readdir_handle_cache_misses(inode, desc, cache_misses);
 
 	do {
 		res = readdir_search_pagecache(desc);
@@ -1233,7 +1203,6 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 		}
 		if (res == -ETOOSMALL && desc->plus) {
 			nfs_zap_caches(inode);
-			desc->page_index = 0;
 			desc->plus = false;
 			desc->eof = false;
 			continue;
@@ -1252,9 +1221,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 
 	spin_lock(&file->f_lock);
 	dir_ctx->dir_cookie = desc->dir_cookie;
-	dir_ctx->dup_cookie = desc->dup_cookie;
 	dir_ctx->last_cookie = desc->last_cookie;
-	dir_ctx->duped = desc->duped;
 	dir_ctx->attr_gencount = desc->attr_gencount;
 	dir_ctx->page_index = desc->page_index;
 	dir_ctx->eof = desc->eof;
@@ -1297,13 +1264,15 @@ static loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int whence)
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
+			dir_ctx->last_cookie = offset;
+		}
 		if (offset == 0)
 			memset(dir_ctx->verf, 0, sizeof(dir_ctx->verf));
-		dir_ctx->duped = 0;
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

