Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545714C5FE0
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 00:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbiB0XTY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 27 Feb 2022 18:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbiB0XTX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 27 Feb 2022 18:19:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4052022501
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 15:18:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D92B4B80CE0
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6088AC340EE
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646003923;
        bh=WxqPPrvlYDHsWN+9VWwMGl4ZxrweJ514FOqMjQ84thA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PqUuvAP6ePbHTxPivZOjjb/04EuXKYEroI6/MredgSmhSSd254aPYdQbkOGIqRL8m
         JHcsoO1PZJlUGPzuxGt7b8Vm/vbhZLM6v+l3MJcjXPdCDvlqNZEmuO/syux1eW1114
         1+5S4YnSG68gEklLsc10V+CvKz9aM6M8zVh0QCs/pnCk1x0nWrKqkWmhuwusCxw4uV
         Dd1U1J0MhaFoldCZ/3F3D7kqEYPayvfweUn4SOl+zVcrNDLtkiDxYCfDcYH46gXfZk
         cUr1Ha1UrcEwKgyTB5h0oo0HO8Y0xjYJA6gMa/NjgqLj9pkX4f3o9VGR/0T0bpFWWY
         DSMqjf8qgmYeQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 24/27] NFS: Fix up forced readdirplus
Date:   Sun, 27 Feb 2022 18:12:24 -0500
Message-Id: <20220227231227.9038-25-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227231227.9038-24-trondmy@kernel.org>
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
 <20220227231227.9038-24-trondmy@kernel.org>
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

Avoid clearing the entire readdir page cache if we're just doing forced
readdirplus for the 'ls -l' heuristic.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c           | 56 +++++++++++++++++++++++++++++-------------
 fs/nfs/nfstrace.h      |  1 +
 include/linux/nfs_fs.h |  1 +
 3 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 707ad0fd5a4e..68b0f19053ac 100644
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
@@ -958,9 +965,15 @@ nfs_readdir_page_get_cached(struct nfs_readdir_descriptor *desc)
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
@@ -1011,6 +1024,7 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 			trace_nfs_readdir_invalidate_cache_range(
 				inode, 1, MAX_LFS_FILESIZE);
 		}
+		desc->clear_cache = false;
 	}
 	res = nfs_readdir_search_array(desc);
 	if (res == 0)
@@ -1145,16 +1159,17 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 
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
@@ -1169,6 +1184,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	struct nfs_open_dir_context *dir_ctx = file->private_data;
 	struct nfs_readdir_descriptor *desc;
 	unsigned int cache_hits, cache_misses;
+	bool force_clear;
 	int res;
 
 	dfprintk(FILE, "NFS: readdir(%pD2) starting at cookie %llu\n",
@@ -1201,6 +1217,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	memcpy(desc->verf, dir_ctx->verf, sizeof(desc->verf));
 	cache_hits = atomic_xchg(&dir_ctx->cache_hits, 0);
 	cache_misses = atomic_xchg(&dir_ctx->cache_misses, 0);
+	force_clear = dir_ctx->force_clear;
 	spin_unlock(&file->f_lock);
 
 	if (desc->eof) {
@@ -1209,7 +1226,9 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	}
 
 	desc->plus = nfs_use_readdirplus(inode, ctx, cache_hits, cache_misses);
-	nfs_readdir_handle_cache_misses(inode, desc, cache_misses);
+	force_clear = nfs_readdir_handle_cache_misses(inode, desc, cache_misses,
+						      force_clear);
+	desc->clear_cache = force_clear;
 
 	do {
 		res = readdir_search_pagecache(desc);
@@ -1238,6 +1257,8 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 
 		nfs_do_filldir(desc, nfsi->cookieverf);
 		nfs_readdir_page_unlock_and_put_cached(desc);
+		if (desc->page_index == desc->page_index_max)
+			desc->clear_cache = force_clear;
 	} while (!desc->eob && !desc->eof);
 
 	spin_lock(&file->f_lock);
@@ -1245,6 +1266,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
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

