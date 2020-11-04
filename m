Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29F02A69A3
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Nov 2020 17:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbgKDQ1H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 11:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgKDQ1H (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Nov 2020 11:27:07 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD35EC0613D3
        for <linux-nfs@vger.kernel.org>; Wed,  4 Nov 2020 08:27:06 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id 11so233502qkd.5
        for <linux-nfs@vger.kernel.org>; Wed, 04 Nov 2020 08:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eO4ZArDyu+ZJfn/p+xFmiVG0Khc/7s1KCX+UczswKpc=;
        b=YXzs7v1qcjubqB6lqjBI/EkH8Ew5ePJ/+qs7DUDiUZtQHkHUl8CDiWTDxHMjEtVAEq
         y4DPEZGdMgikiCCz1iyoEBCACTTj5NfGBqSBxtM4YhASJmjPzw3Ru1sW1/DvnieRwjTY
         4W98oB17g5t4pTfldW/XY9g8XZz54SIVyNEA+eDHIcdTgOtv5P0p5xDKWB96QJhBjlTG
         7vF50/aNDIq9TfCV6mwLSugUN/DNAAwFZx1LqbaVrBZqJuYQx5mKey+iKOAqomZn4u0p
         zBLv07vp9g3sK/N9lDG12as7K9XEJwMIIw642FeU7yR2RQOcTHRliOOpraIaU7RXo3eM
         jkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eO4ZArDyu+ZJfn/p+xFmiVG0Khc/7s1KCX+UczswKpc=;
        b=l7rqcUs7Soo4G9mhLKKxeowCN+EI//QbXdOgYkJPFi/TY9LH+myQMRJId0+M+IJrIQ
         CTwG1E02iQkWLoXbrfACCZxPKBL/NNCnnuC1BU+4yhmFqW2ExDrznwm/6YJKHsAkHVfD
         j+F83Yuz4AHBFsju+r0CvQlAKK+wFbH5GjuQr/YE7Zut5okK5Xie3lRdqekj6DhWiuA3
         mZDb3S+NhbUfZhrbS0BGpT7DKvLkBL2IaJDCTCdINHIFgGz3nWP2zYOSj7beXIyuQj1R
         mESvtbaKIqDbEM/CmDxn6B6Zt9rvq9ZY1/5+7NQP8U8Py/DFpVgHMQZkdPYC8C1L7Mup
         jMfQ==
X-Gm-Message-State: AOAM5320XNFMMMRGXKzq9w2BS2S6hIH0MOvgoN0GAOE141HRB51ks5lM
        49z/6H6W8jE8na2WEzHWH/fey1TQxxeR
X-Google-Smtp-Source: ABdhPJzaQ2ewvrj5i5bzEvHHn6xoaf9cZJUFKtk9MIxXvX6xcaouJZMD+AXPTTLhfL0ezubnT85EEw==
X-Received: by 2002:a37:c44c:: with SMTP id h12mr23189908qkm.166.1604507225709;
        Wed, 04 Nov 2020 08:27:05 -0800 (PST)
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id g78sm2896924qke.88.2020.11.04.08.27.04
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:27:04 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 04/17] NFS: Clean up directory array handling
Date:   Wed,  4 Nov 2020 11:16:25 -0500
Message-Id: <20201104161638.300324-5-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104161638.300324-4-trond.myklebust@hammerspace.com>
References: <20201104161638.300324-1-trond.myklebust@hammerspace.com>
 <20201104161638.300324-2-trond.myklebust@hammerspace.com>
 <20201104161638.300324-3-trond.myklebust@hammerspace.com>
 <20201104161638.300324-4-trond.myklebust@hammerspace.com>
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
 fs/nfs/dir.c | 138 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 77 insertions(+), 61 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 68acbde3f914..842f69120a01 100644
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
 
@@ -268,6 +273,44 @@ int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
 	return ret;
 }
 
+static struct page *nfs_readdir_page_get_locked(struct address_space *mapping,
+						pgoff_t index, u64 last_cookie)
+{
+	struct page *page;
+
+	page = grab_cache_page(mapping, index);
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
@@ -682,10 +725,8 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
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
@@ -730,48 +771,25 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
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
+static void nfs_readdir_page_put(struct nfs_readdir_descriptor *desc)
 {
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
+	put_page(desc->page);
+	desc->page = NULL;
 }
 
-static
-void cache_page_release(nfs_readdir_descriptor_t *desc)
+static void
+nfs_readdir_page_unlock_and_put_cached(struct nfs_readdir_descriptor *desc)
 {
-	put_page(desc->page);
-	desc->page = NULL;
+	unlock_page(desc->page);
+	nfs_readdir_page_put(desc);
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
@@ -785,23 +803,21 @@ int find_and_lock_cache_page(nfs_readdir_descriptor_t *desc)
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
+	nfs_readdir_page_unlock_and_put_cached(desc);
 	return res;
 }
 
@@ -896,6 +912,7 @@ int uncached_readdir(nfs_readdir_descriptor_t *desc)
 	desc->page = page;
 	desc->duped = 0;
 
+	nfs_readdir_page_init_array(page, desc->dir_cookie);
 	status = nfs_readdir_xdr_to_array(desc, page, inode);
 	if (status < 0)
 		goto out_release;
@@ -904,7 +921,7 @@ int uncached_readdir(nfs_readdir_descriptor_t *desc)
 
  out_release:
 	nfs_readdir_clear_array(desc->page);
-	cache_page_release(desc);
+	nfs_readdir_page_put(desc);
  out:
 	dfprintk(DIRCACHE, "NFS: %s: returns %d\n",
 			__func__, status);
@@ -976,8 +993,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 			break;
 
 		res = nfs_do_filldir(desc);
-		unlock_page(desc->page);
-		cache_page_release(desc);
+		nfs_readdir_page_unlock_and_put_cached(desc);
 		if (res < 0)
 			break;
 	} while (!desc->eof);
-- 
2.28.0

