Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD7D4D772D
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Mar 2022 18:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbiCMRN0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 13 Mar 2022 13:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbiCMRNX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 13 Mar 2022 13:13:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34492139CEB
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 10:12:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB799B80CD8
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA1EC340E8
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647191533;
        bh=y80OtaDy8blzpRxJPa3PZHt2pagX+oHatq8MJe7DSfo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VZPCs6KAAmTp7dOW8VoCWaKXCgldrXjB8xkWjC8jYAqwtadM3qA9Ulh71ZW551992
         oQnvU8lB8fZfQP9xWfYNnIFv2pqB7gCZ6x8nI5TYHYYrWrxT9bXaY5G71+CrE44F5M
         AWCx+4AWV9G/2JsYBFHUVYl1GOxTtQn3yZcey5uhwYK38BWYXCnpZCkAF3ebDaugx/
         PKyCcdONUgmt4jLmBnquNr0DhGyOmWTcsX8HElA4BsT6Py0wfZ93qbNKo35J2m8rdv
         udAH71ya6c45kadvmU+5HL6HH9d6UGNza+GF1pUEfXmtPdby9ZLsK1b+iRi1FEppYz
         DbVhp4oQ5phTw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 24/26] NFS: Fix up forced readdirplus
Date:   Sun, 13 Mar 2022 13:05:55 -0400
Message-Id: <20220313170557.5940-25-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220313170557.5940-24-trondmy@kernel.org>
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
 <20220313170557.5940-11-trondmy@kernel.org>
 <20220313170557.5940-12-trondmy@kernel.org>
 <20220313170557.5940-13-trondmy@kernel.org>
 <20220313170557.5940-14-trondmy@kernel.org>
 <20220313170557.5940-15-trondmy@kernel.org>
 <20220313170557.5940-16-trondmy@kernel.org>
 <20220313170557.5940-17-trondmy@kernel.org>
 <20220313170557.5940-18-trondmy@kernel.org>
 <20220313170557.5940-19-trondmy@kernel.org>
 <20220313170557.5940-20-trondmy@kernel.org>
 <20220313170557.5940-21-trondmy@kernel.org>
 <20220313170557.5940-22-trondmy@kernel.org>
 <20220313170557.5940-23-trondmy@kernel.org>
 <20220313170557.5940-24-trondmy@kernel.org>
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

Avoid clearing the entire readdir page cache if we're just doing forced
readdirplus for the 'ls -l' heuristic.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c           | 56 +++++++++++++++++++++++++++++-------------
 fs/nfs/nfstrace.h      |  1 +
 include/linux/nfs_fs.h |  1 +
 3 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 8c2552d89310..f6aac1e8a8b9 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -170,6 +170,7 @@ struct nfs_readdir_descriptor {
 	unsigned int	cache_entry_index;
 	unsigned int	buffer_fills;
 	unsigned int	dtsize;
+	bool clear_cache;
 	bool plus;
 	bool eob;
 	bool eof;
@@ -227,6 +228,13 @@ static void nfs_readdir_clear_array(struct page *page)
 	kunmap_atomic(array);
 }
 
+static void nfs_readdir_page_reinit_array(struct page *page, u64 last_cookie,
+					  u64 change_attr)
+{
+	nfs_readdir_clear_array(page);
+	nfs_readdir_page_init_array(page, last_cookie, change_attr);
+}
+
 static struct page *
 nfs_readdir_page_array_alloc(u64 last_cookie, gfp_t gfp_flags)
 {
@@ -428,12 +436,11 @@ static struct page *nfs_readdir_page_get_next(struct address_space *mapping,
 	struct page *page;
 
 	page = nfs_readdir_page_get_locked(mapping, cookie, change_attr);
-	if (page) {
-		if (nfs_readdir_page_last_cookie(page) == cookie)
-			return page;
-		nfs_readdir_page_unlock_and_put(page);
-	}
-	return NULL;
+	if (!page)
+		return NULL;
+	if (nfs_readdir_page_last_cookie(page) != cookie)
+		nfs_readdir_page_reinit_array(page, cookie, change_attr);
+	return page;
 }
 
 static inline
@@ -960,9 +967,15 @@ nfs_readdir_page_get_cached(struct nfs_readdir_descriptor *desc)
 {
 	struct address_space *mapping = desc->file->f_mapping;
 	u64 change_attr = inode_peek_iversion_raw(mapping->host);
+	u64 cookie = desc->last_cookie;
+	struct page *page;
 
-	return nfs_readdir_page_get_locked(mapping, desc->last_cookie,
-					   change_attr);
+	page = nfs_readdir_page_get_locked(mapping, cookie, change_attr);
+	if (!page)
+		return NULL;
+	if (desc->clear_cache && !nfs_readdir_page_needs_filling(page))
+		nfs_readdir_page_reinit_array(page, cookie, change_attr);
+	return page;
 }
 
 /*
@@ -1013,6 +1026,7 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 			trace_nfs_readdir_invalidate_cache_range(
 				inode, 1, MAX_LFS_FILESIZE);
 		}
+		desc->clear_cache = false;
 	}
 	res = nfs_readdir_search_array(desc);
 	if (res == 0)
@@ -1147,16 +1161,17 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 
 #define NFS_READDIR_CACHE_MISS_THRESHOLD (16UL)
 
-static void nfs_readdir_handle_cache_misses(struct inode *inode,
+static bool nfs_readdir_handle_cache_misses(struct inode *inode,
 					    struct nfs_readdir_descriptor *desc,
-					    unsigned int cache_misses)
+					    unsigned int cache_misses,
+					    bool force_clear)
 {
-	if (desc->ctx->pos == 0 ||
-	    cache_misses <= NFS_READDIR_CACHE_MISS_THRESHOLD)
-		return;
-	if (invalidate_mapping_pages(inode->i_mapping, 0, -1) == 0)
-		return;
-	trace_nfs_readdir_invalidate_cache_range(inode, 0, MAX_LFS_FILESIZE);
+	if (desc->ctx->pos == 0 || !desc->plus)
+		return false;
+	if (cache_misses <= NFS_READDIR_CACHE_MISS_THRESHOLD && !force_clear)
+		return false;
+	trace_nfs_readdir_force_readdirplus(inode);
+	return true;
 }
 
 /* The file offset position represents the dirent entry number.  A
@@ -1171,6 +1186,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	struct nfs_open_dir_context *dir_ctx = file->private_data;
 	struct nfs_readdir_descriptor *desc;
 	unsigned int cache_hits, cache_misses;
+	bool force_clear;
 	int res;
 
 	dfprintk(FILE, "NFS: readdir(%pD2) starting at cookie %llu\n",
@@ -1203,6 +1219,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	memcpy(desc->verf, dir_ctx->verf, sizeof(desc->verf));
 	cache_hits = atomic_xchg(&dir_ctx->cache_hits, 0);
 	cache_misses = atomic_xchg(&dir_ctx->cache_misses, 0);
+	force_clear = dir_ctx->force_clear;
 	spin_unlock(&file->f_lock);
 
 	if (desc->eof) {
@@ -1211,7 +1228,9 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	}
 
 	desc->plus = nfs_use_readdirplus(inode, ctx, cache_hits, cache_misses);
-	nfs_readdir_handle_cache_misses(inode, desc, cache_misses);
+	force_clear = nfs_readdir_handle_cache_misses(inode, desc, cache_misses,
+						      force_clear);
+	desc->clear_cache = force_clear;
 
 	do {
 		res = readdir_search_pagecache(desc);
@@ -1240,6 +1259,8 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 
 		nfs_do_filldir(desc, nfsi->cookieverf);
 		nfs_readdir_page_unlock_and_put_cached(desc);
+		if (desc->page_index == desc->page_index_max)
+			desc->clear_cache = force_clear;
 	} while (!desc->eob && !desc->eof);
 
 	spin_lock(&file->f_lock);
@@ -1247,6 +1268,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	dir_ctx->last_cookie = desc->last_cookie;
 	dir_ctx->attr_gencount = desc->attr_gencount;
 	dir_ctx->page_index = desc->page_index;
+	dir_ctx->force_clear = force_clear;
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
index 42aad886d3c0..3893386ceaed 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -109,6 +109,7 @@ struct nfs_open_dir_context {
 	__u64 last_cookie;
 	pgoff_t page_index;
 	unsigned int dtsize;
+	bool force_clear;
 	bool eof;
 	struct rcu_head rcu_head;
 };
-- 
2.35.1

