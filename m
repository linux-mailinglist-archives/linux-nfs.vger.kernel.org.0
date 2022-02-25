Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD004C4DD0
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 19:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbiBYSfY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Feb 2022 13:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbiBYSfS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Feb 2022 13:35:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF08F1B8FE8
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 10:34:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CBC7B8330B
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3672C340F1
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645814084;
        bh=3HV235tnrfcx7IisWbBZr1k8UdD4TrKQqnEYYXEhPHI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZTpAboCwb9hHOCMyb4T9pD7UvLU867M6fzGVZsOZq848MWAEOotmZ4grL6YeKnI61
         nxGka2hT45A9KnuFF5EIioYaDqj5l7AgW6SnM+71t2fdFSg1JhLeibvcO6qsIESQnG
         x0FEPRoKB9Jda4G+6Od0dI51y+RAkIFFsFbkAytCWWFDmMRqzTRwNrTwClng3KG4QF
         McxRhrltCCRXJ4FAS07im6kPHaBeK+Dry574GD95Y9S0ChVdrP4bKQjV15yf9GWCUV
         CRQZWXj1fdeol7uWwJsaZG444k/i5s5VGBTJplnCdu7mBtXJ4MilsAP9e8v8NMXAbQ
         O5GCYE8Jl0aJg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 22/24] NFS: Fix up forced readdirplus
Date:   Fri, 25 Feb 2022 13:28:27 -0500
Message-Id: <20220225182829.1236093-23-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225182829.1236093-22-trondmy@kernel.org>
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

Avoid clearing the entire readdir page cache if we're just doing forced
readdirplus for the 'ls -l' heuristic.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c           | 57 ++++++++++++++++++++++++++++--------------
 fs/nfs/nfstrace.h      |  1 +
 include/linux/nfs_fs.h |  1 +
 3 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 827ca1ed0cb7..4af00465806f 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -170,6 +170,8 @@ struct nfs_readdir_descriptor {
 	unsigned int	cache_entry_index;
 	unsigned int	buffer_fills;
 	unsigned int	dtsize;
+	bool clear_cache;
+	bool force_plus;
 	bool plus;
 	bool eob;
 	bool eof;
@@ -368,6 +370,16 @@ static bool nfs_readdir_page_validate(struct page *page, u64 last_cookie,
 	return ret;
 }
 
+static bool nfs_readdir_page_is_full(struct page *page)
+{
+	struct nfs_cache_array *array = kmap_atomic(page);
+	int ret;
+
+	ret = nfs_readdir_array_is_full(array);
+	kunmap_atomic(array);
+	return ret;
+}
+
 static void nfs_readdir_page_unlock_and_put(struct page *page)
 {
 	unlock_page(page);
@@ -376,7 +388,7 @@ static void nfs_readdir_page_unlock_and_put(struct page *page)
 
 static struct page *nfs_readdir_page_get_locked(struct address_space *mapping,
 						u64 last_cookie,
-						u64 change_attr)
+						u64 change_attr, bool clear)
 {
 	pgoff_t index = nfs_readdir_page_cookie_hash(last_cookie);
 	struct page *page;
@@ -385,8 +397,10 @@ static struct page *nfs_readdir_page_get_locked(struct address_space *mapping,
 	if (!page)
 		return NULL;
 	if (PageUptodate(page)) {
-		if (nfs_readdir_page_validate(page, last_cookie, change_attr))
-			return page;
+		if (nfs_readdir_page_validate(page, last_cookie, change_attr)) {
+			if (!clear || !nfs_readdir_page_is_full(page))
+				return page;
+		}
 		nfs_readdir_clear_array(page);
 	}
 	nfs_readdir_page_init_array(page, last_cookie, change_attr);
@@ -407,13 +421,7 @@ static u64 nfs_readdir_page_last_cookie(struct page *page)
 
 static bool nfs_readdir_page_needs_filling(struct page *page)
 {
-	struct nfs_cache_array *array;
-	bool ret;
-
-	array = kmap_atomic(page);
-	ret = !nfs_readdir_array_is_full(array);
-	kunmap_atomic(array);
-	return ret;
+	return !nfs_readdir_page_is_full(page);
 }
 
 static void nfs_readdir_page_set_eof(struct page *page)
@@ -426,11 +434,12 @@ static void nfs_readdir_page_set_eof(struct page *page)
 }
 
 static struct page *nfs_readdir_page_get_next(struct address_space *mapping,
-					      u64 cookie, u64 change_attr)
+					      u64 cookie, u64 change_attr,
+					      bool clear)
 {
 	struct page *page;
 
-	page = nfs_readdir_page_get_locked(mapping, cookie, change_attr);
+	page = nfs_readdir_page_get_locked(mapping, cookie, change_attr, clear);
 	if (page) {
 		if (nfs_readdir_page_last_cookie(page) == cookie)
 			return page;
@@ -820,8 +829,10 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 			arrays++;
 			*arrays = page = new;
 		} else {
-			new = nfs_readdir_page_get_next(
-				mapping, entry->prev_cookie, change_attr);
+			new = nfs_readdir_page_get_next(mapping,
+							entry->prev_cookie,
+							change_attr,
+							desc->clear_cache);
 			if (!new)
 				break;
 			if (page != *arrays)
@@ -956,7 +967,7 @@ nfs_readdir_page_get_cached(struct nfs_readdir_descriptor *desc)
 	u64 change_attr = inode_peek_iversion_raw(mapping->host);
 
 	return nfs_readdir_page_get_locked(mapping, desc->last_cookie,
-					   change_attr);
+					   change_attr, desc->clear_cache);
 }
 
 /*
@@ -1007,6 +1018,7 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 			trace_nfs_readdir_invalidate_cache_range(
 				inode, 1, MAX_LFS_FILESIZE);
 		}
+		desc->clear_cache = false;
 	}
 	res = nfs_readdir_search_array(desc);
 	if (res == 0)
@@ -1145,9 +1157,8 @@ static void nfs_readdir_handle_cache_misses(struct inode *inode,
 	if (desc->ctx->pos == 0 ||
 	    cache_misses <= NFS_READDIR_CACHE_MISS_THRESHOLD)
 		return;
-	if (invalidate_mapping_pages(inode->i_mapping, 0, -1) == 0)
-		return;
-	trace_nfs_readdir_invalidate_cache_range(inode, 0, MAX_LFS_FILESIZE);
+	desc->force_plus = true;
+	trace_nfs_readdir_force_readdirplus(inode);
 }
 
 /* The file offset position represents the dirent entry number.  A
@@ -1191,6 +1202,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	desc->page_index = page_index;
 	desc->last_cookie = dir_ctx->last_cookie;
 	desc->attr_gencount = dir_ctx->attr_gencount;
+	desc->force_plus = dir_ctx->force_plus;
 	desc->eof = dir_ctx->eof;
 	nfs_set_dtsize(desc, dir_ctx->dtsize);
 	memcpy(desc->verf, dir_ctx->verf, sizeof(desc->verf));
@@ -1204,7 +1216,11 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	}
 
 	desc->plus = nfs_use_readdirplus(inode, ctx, cache_hits, cache_misses);
-	nfs_readdir_handle_cache_misses(inode, desc, cache_misses);
+	if (desc->plus)
+		nfs_readdir_handle_cache_misses(inode, desc, cache_misses);
+	else
+		desc->force_plus = false;
+	desc->clear_cache = desc->force_plus;
 
 	do {
 		res = readdir_search_pagecache(desc);
@@ -1233,6 +1249,8 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 
 		nfs_do_filldir(desc, nfsi->cookieverf);
 		nfs_readdir_page_unlock_and_put_cached(desc);
+		if (desc->page_index == desc->page_index_max)
+			desc->clear_cache = desc->force_plus;
 	} while (!desc->eob && !desc->eof);
 
 	spin_lock(&file->f_lock);
@@ -1240,6 +1258,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	dir_ctx->last_cookie = desc->last_cookie;
 	dir_ctx->attr_gencount = desc->attr_gencount;
 	dir_ctx->page_index = desc->page_index;
+	dir_ctx->force_plus = desc->force_plus;
 	dir_ctx->eof = desc->eof;
 	dir_ctx->dtsize = desc->dtsize;
 	memcpy(dir_ctx->verf, desc->verf, sizeof(dir_ctx->verf));
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index ec2645d20abf..59f4ca803fd0 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -160,6 +160,7 @@ DEFINE_NFS_INODE_EVENT(nfs_fsync_enter);
 DEFINE_NFS_INODE_EVENT_DONE(nfs_fsync_exit);
 DEFINE_NFS_INODE_EVENT(nfs_access_enter);
 DEFINE_NFS_INODE_EVENT_DONE(nfs_set_cache_invalid);
+DEFINE_NFS_INODE_EVENT(nfs_readdir_force_readdirplus);
 DEFINE_NFS_INODE_EVENT_DONE(nfs_readdir_cache_fill_done);
 DEFINE_NFS_INODE_EVENT_DONE(nfs_readdir_uncached_done);
 
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 42aad886d3c0..3f9625c7d0ef 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -109,6 +109,7 @@ struct nfs_open_dir_context {
 	__u64 last_cookie;
 	pgoff_t page_index;
 	unsigned int dtsize;
+	bool force_plus;
 	bool eof;
 	struct rcu_head rcu_head;
 };
-- 
2.35.1

