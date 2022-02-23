Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E954C1D9E
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 22:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242552AbiBWVVL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 16:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242503AbiBWVUK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 16:20:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7260B4EA25
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:19:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22B0BB821B3
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 21:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45D0C340F3
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 21:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645651179;
        bh=qJhJnNTOIFtE1tHwTGzE5AhMobSpjIlVEhJr0soq6w0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qDEudrWYxS6EHZ6vwiwIsuTVVAH2kgzpLMIhoAWL4oEyy1AYeAUXJELHzLKMp0Ue+
         qKUoGeRIiFj5/f1QplageLIVJp6+ar2tBAqIwa7tdm13rCDzIdfhYFI75zbHR6zzDT
         Y4kmJieM91TAvpdBlMVkLn9hW94+b8xvJ4odYu9C3FScE/oqeLoRdno9ObraykvAZw
         bWR6TmJaHxCZXgNKIfQoJw0O0lwjnX9GKEdhMdDqqtlwau8Kwna0Y9PvgPfKWcGIk/
         EDri2wr44E0PlsZ0ElRTB0gSDtuN5/TPDl5CcF+LhVcWQjzn6CuHJsdnVRhfBaLGF6
         qh5ospTMC2KPw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 20/21] NFS: Fix up forced readdirplus
Date:   Wed, 23 Feb 2022 16:13:04 -0500
Message-Id: <20220223211305.296816-21-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220223211305.296816-20-trondmy@kernel.org>
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
 <20220223211305.296816-20-trondmy@kernel.org>
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
 fs/nfs/dir.c           | 49 ++++++++++++++++++++++++++----------------
 include/linux/nfs_fs.h |  1 +
 2 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 2007eebfb5cf..d41ea614edec 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -169,6 +169,7 @@ struct nfs_readdir_descriptor {
 	unsigned int	cache_entry_index;
 	unsigned int	buffer_fills;
 	unsigned int	dtsize;
+	bool force_plus;
 	bool plus;
 	bool eob;
 	bool eof;
@@ -352,6 +353,16 @@ static bool nfs_readdir_page_cookie_match(struct page *page, u64 last_cookie,
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
@@ -359,7 +370,7 @@ static void nfs_readdir_page_unlock_and_put(struct page *page)
 }
 
 static struct page *nfs_readdir_page_get_locked(struct address_space *mapping,
-						u64 last_cookie)
+						u64 last_cookie, bool clear)
 {
 	pgoff_t index = nfs_readdir_page_cookie_hash(last_cookie);
 	struct page *page;
@@ -371,8 +382,10 @@ static struct page *nfs_readdir_page_get_locked(struct address_space *mapping,
 	change_attr = inode_peek_iversion_raw(mapping->host);
 	if (PageUptodate(page)) {
 		if (nfs_readdir_page_cookie_match(page, last_cookie,
-						  change_attr))
-			return page;
+						  change_attr)) {
+			if (!clear || !nfs_readdir_page_is_full(page))
+				return page;
+		}
 		nfs_readdir_clear_array(page);
 	}
 	nfs_readdir_page_init_array(page, last_cookie, change_attr);
@@ -393,13 +406,7 @@ static u64 nfs_readdir_page_last_cookie(struct page *page)
 
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
@@ -412,11 +419,11 @@ static void nfs_readdir_page_set_eof(struct page *page)
 }
 
 static struct page *nfs_readdir_page_get_next(struct address_space *mapping,
-					      u64 cookie)
+					      u64 cookie, bool clear)
 {
 	struct page *page;
 
-	page = nfs_readdir_page_get_locked(mapping, cookie);
+	page = nfs_readdir_page_get_locked(mapping, cookie, clear);
 	if (page) {
 		if (nfs_readdir_page_last_cookie(page) == cookie)
 			return page;
@@ -808,7 +815,8 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 			*arrays = page = new;
 		} else {
 			new = nfs_readdir_page_get_next(mapping,
-							entry->prev_cookie);
+							entry->prev_cookie,
+							desc->force_plus);
 			if (!new)
 				break;
 			if (page != *arrays)
@@ -937,8 +945,8 @@ nfs_readdir_page_unlock_and_put_cached(struct nfs_readdir_descriptor *desc)
 static struct page *
 nfs_readdir_page_get_cached(struct nfs_readdir_descriptor *desc)
 {
-	return nfs_readdir_page_get_locked(desc->file->f_mapping,
-					   desc->last_cookie);
+	return nfs_readdir_page_get_locked(
+		desc->file->f_mapping, desc->last_cookie, desc->force_plus);
 }
 
 /*
@@ -1124,9 +1132,7 @@ static void nfs_readdir_handle_cache_misses(struct inode *inode,
 	if (desc->ctx->pos == 0 ||
 	    cache_misses <= NFS_READDIR_CACHE_MISS_THRESHOLD)
 		return;
-	if (invalidate_mapping_pages(inode->i_mapping, 0, -1) == 0)
-		return;
-	trace_nfs_readdir_invalidate_cache_range(inode, 0, MAX_LFS_FILESIZE);
+	desc->force_plus = true;
 }
 
 /* The file offset position represents the dirent entry number.  A
@@ -1170,6 +1176,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	desc->page_index = page_index;
 	desc->last_cookie = dir_ctx->last_cookie;
 	desc->attr_gencount = dir_ctx->attr_gencount;
+	desc->force_plus = dir_ctx->force_plus;
 	desc->eof = dir_ctx->eof;
 	nfs_set_dtsize(desc, dir_ctx->dtsize);
 	memcpy(desc->verf, dir_ctx->verf, sizeof(desc->verf));
@@ -1183,7 +1190,10 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	}
 
 	desc->plus = nfs_use_readdirplus(inode, ctx, cache_hits, cache_misses);
-	nfs_readdir_handle_cache_misses(inode, desc, cache_misses);
+	if (desc->plus)
+		nfs_readdir_handle_cache_misses(inode, desc, cache_misses);
+	else
+		desc->force_plus = false;
 
 	do {
 		res = readdir_search_pagecache(desc);
@@ -1224,6 +1234,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	dir_ctx->last_cookie = desc->last_cookie;
 	dir_ctx->attr_gencount = desc->attr_gencount;
 	dir_ctx->page_index = desc->page_index;
+	dir_ctx->force_plus = desc->force_plus;
 	dir_ctx->eof = desc->eof;
 	dir_ctx->dtsize = desc->dtsize;
 	memcpy(dir_ctx->verf, desc->verf, sizeof(dir_ctx->verf));
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

