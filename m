Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BB14BC215
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Feb 2022 22:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbiBRVbK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Feb 2022 16:31:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239869AbiBRVbJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Feb 2022 16:31:09 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DB4178958
        for <linux-nfs@vger.kernel.org>; Fri, 18 Feb 2022 13:30:52 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id v5so6896105qkj.4
        for <linux-nfs@vger.kernel.org>; Fri, 18 Feb 2022 13:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8CqIC3rEvBzQgJVGzgW7Ii250S7Vlb4dINZzcr3ePAc=;
        b=ZzqWDQ3V4I4HtuKaC9tOqgxGAJ/WuY84bn4wUkUrmyGJZn605a5DShESKW4tplWKuk
         hbSq4zDNvQRsMWPINmXDv7j8OlhsFc21ELbFX0Zz1pnGm2lfNIccUvJcpJQ9wLgop9eE
         iocaBOSvmC7oSqJMGwbWBra7xFoOejNyN7sefaLgfEZPOFKCzHqxze8Dvg00UuEGxA0X
         p1C2Sq4M/7ggDb22aIa7Ed2unzq4SM7vYTWbXY3BkTKmVBGy0ZqzldwBKlGVNb7Z/biS
         /61rlk1Q2+xcgqbUlJs3YTmzAfYPs2DWwNQ7VBgrc6yRZH6srGYzlENDoTkpZeBNTQft
         VEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8CqIC3rEvBzQgJVGzgW7Ii250S7Vlb4dINZzcr3ePAc=;
        b=0vKgS23B02/ExEsivyZnK5rfPIQRzxgvNevqjW5wJxVIsFg8surcpsQ3WI5bIZ8YlU
         TaW53B5j94RhJuyTZ7faRZBVu40ZLvIxqY2HnByGYrf0bbcXp/QZW+ZiCyTc/5hmAOac
         Ht+HpG7xRDB8FMjGY6BahGCg/T6aP4JmWy7F9H2rwqw+VZZuRgi7F623vlld9nP3rniT
         aL0ZNhlWL6asK4ZQmmbwbgASZnxN44f0LgTcC+9JctJZYUkPd3DMM9LrPCysqHLf7Qlu
         +UyxoMtL+OQw1Ye8a+4vj3V/tDg2g1sRA/NG93bu42qiibZylkw3V9k0RSpTNBdrDQwq
         1H9w==
X-Gm-Message-State: AOAM531T4yEAsrHdO+XffErR0lu2mx0x4CaShkwuy7FdLRRyEm279ig8
        cV0n3mBO1Xpr4Xuv26seYg5JpK/91w==
X-Google-Smtp-Source: ABdhPJzUki3plQCAxOHwVzTbRJO1O0GLzgqJtO6yvGCic+x8itx2ww80YefdglEUxQxZblM1z/8p/w==
X-Received: by 2002:a37:747:0:b0:60d:d709:2e20 with SMTP id 68-20020a370747000000b0060dd7092e20mr5709500qkh.579.1645219851012;
        Fri, 18 Feb 2022 13:30:51 -0800 (PST)
Received: from localhost.localdomain (c-68-56-145-227.hsd1.mi.comcast.net. [68.56.145.227])
        by smtp.gmail.com with ESMTPSA id w22sm26928656qtk.7.2022.02.18.13.30.49
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 13:30:50 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 3/6] NFS: Improve algorithm for falling back to uncached readdir
Date:   Fri, 18 Feb 2022 16:24:21 -0500
Message-Id: <20220218212424.1840077-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218212424.1840077-3-trond.myklebust@hammerspace.com>
References: <20220218212424.1840077-1-trond.myklebust@hammerspace.com>
 <20220218212424.1840077-2-trond.myklebust@hammerspace.com>
 <20220218212424.1840077-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When reading a very large directory, we want to try to keep the page
cache up to date if doing so is inexpensive. Right now, we will try to
refill the page cache if it is non-empty, irrespective of whether or not
doing so is going to take a long time.

Replace that algorithm with something that looks at how many times we've
refilled the page cache without seeing a cache hit.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c           | 51 +++++++++++++++++++++---------------------
 include/linux/nfs_fs.h |  1 +
 2 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 10421b5331ca..43a559b34f4a 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -71,19 +71,16 @@ const struct address_space_operations nfs_dir_aops = {
 
 #define NFS_INIT_DTSIZE PAGE_SIZE
 
-static struct nfs_open_dir_context *alloc_nfs_open_dir_context(struct inode *dir)
+static struct nfs_open_dir_context *
+alloc_nfs_open_dir_context(struct inode *dir)
 {
 	struct nfs_inode *nfsi = NFS_I(dir);
 	struct nfs_open_dir_context *ctx;
-	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
 	if (ctx != NULL) {
-		ctx->duped = 0;
 		ctx->attr_gencount = nfsi->attr_gencount;
-		ctx->dir_cookie = 0;
-		ctx->dup_cookie = 0;
-		ctx->page_index = 0;
 		ctx->dtsize = NFS_INIT_DTSIZE;
-		ctx->eof = false;
 		spin_lock(&dir->i_lock);
 		if (list_empty(&nfsi->open_files) &&
 		    (nfsi->cache_validity & NFS_INO_DATA_INVAL_DEFER))
@@ -170,6 +167,7 @@ struct nfs_readdir_descriptor {
 	unsigned long	timestamp;
 	unsigned long	gencount;
 	unsigned long	attr_gencount;
+	unsigned int	page_fill_misses;
 	unsigned int	cache_entry_index;
 	unsigned int	buffer_fills;
 	unsigned int	dtsize;
@@ -925,6 +923,18 @@ nfs_readdir_page_get_cached(struct nfs_readdir_descriptor *desc)
 					   desc->last_cookie);
 }
 
+#define NFS_READDIR_PAGE_FILL_MISS_MAX 5
+/*
+ * If we've tried to refill the page cache more than 5 times, and
+ * still not found our cookie, then we should stop and fall back
+ * to uncached readdir
+ */
+static bool nfs_readdir_may_fill_pagecache(struct nfs_readdir_descriptor *desc)
+{
+	return desc->dir_cookie == 0 ||
+	       desc->page_fill_misses < NFS_READDIR_PAGE_FILL_MISS_MAX;
+}
+
 /*
  * Returns 0 if desc->dir_cookie was found on page desc->page_index
  * and locks the page to prevent removal from the page cache.
@@ -940,6 +950,8 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 	if (!desc->page)
 		return -ENOMEM;
 	if (nfs_readdir_page_needs_filling(desc->page)) {
+		if (!nfs_readdir_may_fill_pagecache(desc))
+			return -EBADCOOKIE;
 		desc->page_index_max = desc->page_index;
 		res = nfs_readdir_xdr_to_array(desc, nfsi->cookieverf, verf,
 					       &desc->page, 1);
@@ -958,36 +970,22 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 		if (desc->page_index == 0)
 			memcpy(nfsi->cookieverf, verf,
 			       sizeof(nfsi->cookieverf));
+		desc->page_fill_misses++;
 	}
 	res = nfs_readdir_search_array(desc);
-	if (res == 0)
+	if (res == 0) {
+		desc->page_fill_misses = 0;
 		return 0;
+	}
 	nfs_readdir_page_unlock_and_put_cached(desc);
 	return res;
 }
 
-static bool nfs_readdir_dont_search_cache(struct nfs_readdir_descriptor *desc)
-{
-	struct address_space *mapping = desc->file->f_mapping;
-	struct inode *dir = file_inode(desc->file);
-	unsigned int dtsize = NFS_SERVER(dir)->dtsize;
-	loff_t size = i_size_read(dir);
-
-	/*
-	 * Default to uncached readdir if the page cache is empty, and
-	 * we're looking for a non-zero cookie in a large directory.
-	 */
-	return desc->dir_cookie != 0 && mapping->nrpages == 0 && size > dtsize;
-}
-
 /* Search for desc->dir_cookie from the beginning of the page cache */
 static int readdir_search_pagecache(struct nfs_readdir_descriptor *desc)
 {
 	int res;
 
-	if (nfs_readdir_dont_search_cache(desc))
-		return -EBADCOOKIE;
-
 	do {
 		if (desc->page_index == 0) {
 			desc->current_index = 0;
@@ -1149,6 +1147,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	page_index = dir_ctx->page_index;
 	desc->attr_gencount = dir_ctx->attr_gencount;
 	desc->eof = dir_ctx->eof;
+	desc->page_fill_misses = dir_ctx->page_fill_misses;
 	nfs_set_dtsize(desc, dir_ctx->dtsize);
 	memcpy(desc->verf, dir_ctx->verf, sizeof(desc->verf));
 	spin_unlock(&file->f_lock);
@@ -1204,6 +1203,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	dir_ctx->duped = desc->duped;
 	dir_ctx->attr_gencount = desc->attr_gencount;
 	dir_ctx->page_index = desc->page_index;
+	dir_ctx->page_fill_misses = desc->page_fill_misses;
 	dir_ctx->eof = desc->eof;
 	dir_ctx->dtsize = desc->dtsize;
 	memcpy(dir_ctx->verf, desc->verf, sizeof(dir_ctx->verf));
@@ -1247,6 +1247,7 @@ static loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int whence)
 			dir_ctx->dir_cookie = offset;
 		else
 			dir_ctx->dir_cookie = 0;
+		dir_ctx->page_fill_misses = 0;
 		if (offset == 0)
 			memset(dir_ctx->verf, 0, sizeof(dir_ctx->verf));
 		dir_ctx->duped = 0;
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index d27f7e788624..3165927048e4 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -106,6 +106,7 @@ struct nfs_open_dir_context {
 	__u64 dir_cookie;
 	__u64 dup_cookie;
 	pgoff_t page_index;
+	unsigned int page_fill_misses;
 	unsigned int dtsize;
 	signed char duped;
 	bool eof;
-- 
2.35.1

