Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FB94BACC2
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 23:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343923AbiBQWjr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Feb 2022 17:39:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343922AbiBQWjr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 17:39:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6EB811B9
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 14:39:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D14C61802
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 22:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5961C340ED
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 22:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645137570;
        bh=oh3IjPsXmzVp2dPWVKYBhimnjPTuPfgarHiOstm+bGg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Msf/cc+z0eGILVj1neT6/Yea2zeqGjsA9bwyiPTzVWDbwdMCUiv/Jsc24944MGIQa
         8+lQlg6GJC5h/wHk9G0WipttIAQepeoD/QlQSlta7DQW8aCRxLcm5NBeJao1P49Fv6
         TNzEWYOM1l0L9XC6kTjR2ez7EGoto7e64anOZn+6OhmKX2WvF6rtIvoX5sJFVzbcez
         xfpGYSqUgKuKhbeOKBWeCpAQAEkFB85eJ2U9z5+TCDKYY4HHIQMpdVW1OC0eokbLsP
         sSKsZ2h+M6w4/e4I3pJ46AdxYeNKXNwnAKSqoRmL6gym3fbaKCmjmQP/mGIP3Wn7YP
         ckn9vnj2Trmlw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 3/5] NFS: Improve algorithm for falling back to uncached readdir
Date:   Thu, 17 Feb 2022 17:33:21 -0500
Message-Id: <20220217223323.696173-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220217223323.696173-3-trondmy@kernel.org>
References: <20220217223323.696173-1-trondmy@kernel.org>
 <20220217223323.696173-2-trondmy@kernel.org>
 <20220217223323.696173-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 98120f2d7e0b..9e5fc29723c2 100644
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

