Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF31C2A69A0
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Nov 2020 17:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbgKDQ1F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 11:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgKDQ1E (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Nov 2020 11:27:04 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1D5C0613D3
        for <linux-nfs@vger.kernel.org>; Wed,  4 Nov 2020 08:27:04 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id t5so4017512qtp.2
        for <linux-nfs@vger.kernel.org>; Wed, 04 Nov 2020 08:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Za2MbFKOf0ZIVMwa6n7rZb8vFe0Gn0ItEgc063hxwd8=;
        b=KH87ngbsXicGB2rpmOuSdMdXu9J0t0W2LG0/kHRfzXoWe3FpTis7WsYw4IMx7DSOGV
         FqmJdGshWQs33aEmBWgrcauyfdCRoPB/rNy9DoDLbEcMgtfjGlWp5daOs1dm1HHEG/No
         LKjk/xZqAKkxrCxdRTkQSYjk5n/AYXxNhKA9b/rZeM9Lqe4dfD+7vM+mv3Zu1gm9Hal+
         wdMWKU7xaUPcyybT11AKC1Ze2N6fGvEE9NzIim9KhOMbG+zRfhMRAxVpx2BSAyOhnjHF
         9jt7Q8DDFbgVXlKPGAydtFzzCXP2V0Lq8phofCzwIcv5CJBQKPYAB8VBq9TpuWAf36Gm
         ZE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Za2MbFKOf0ZIVMwa6n7rZb8vFe0Gn0ItEgc063hxwd8=;
        b=RQlFWS+1I3+aF4Nf8PfclX8bD3VUyZ5/simi61gE4pB4D/UN25ymiJcXfQLF7ruwa9
         5x15RqwkqzYb0+/2WDHYUt4Ex1h7ERq1s/rjaPsIQvIBHzp1DwcuqsXKm7IYXZJ5JKxM
         XePfvxctpuvaEsT83VQaew3DcVcStd7881bVjL8JYA7M0GJC3WHGNkYVq0kip6cISmss
         YcXdBrfeP3pJkzx5mJdeLnivClKWVPE2LmPZBn2OZBmjy3lAzGTYC4nFU1Ju7SKN9LYs
         AKZNJtomRH5qm6DJGRgtMAcm89oM7qDimMts6hzAx/e3xpzNPuKo27fXPLtWd2wNSsi+
         fOnw==
X-Gm-Message-State: AOAM532DpFamwVlmPzS0nb3J6sVTz43Jlk7Dy7DP0ZpTpwOD9pBPktHD
        2R9E2tzXlVSFJF8J+pWOzyGt6yM49rgl
X-Google-Smtp-Source: ABdhPJxZcZnFrn9k84546CHQchTO+t8kLkLzjjUbe0kfYbQket5Bv7o8F8I64Tr9gVw2z+gSVOsZCQ==
X-Received: by 2002:ac8:41d4:: with SMTP id o20mr9396491qtm.313.1604507223473;
        Wed, 04 Nov 2020 08:27:03 -0800 (PST)
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id g78sm2896924qke.88.2020.11.04.08.27.02
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:27:02 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 02/17] NFS: Clean up readdir struct nfs_cache_array
Date:   Wed,  4 Nov 2020 11:16:23 -0500
Message-Id: <20201104161638.300324-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104161638.300324-2-trond.myklebust@hammerspace.com>
References: <20201104161638.300324-1-trond.myklebust@hammerspace.com>
 <20201104161638.300324-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Since the 'eof_index' is only ever used as a flag, make it so.
Also add a flag to detect if the page has been completely filled.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 66 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 67d8595cd6e5..604ebe015387 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -138,9 +138,10 @@ struct nfs_cache_array_entry {
 };
 
 struct nfs_cache_array {
-	int size;
-	int eof_index;
 	u64 last_cookie;
+	unsigned int size;
+	unsigned char page_full : 1,
+		      page_is_eof : 1;
 	struct nfs_cache_array_entry array[];
 };
 
@@ -172,7 +173,6 @@ void nfs_readdir_init_array(struct page *page)
 
 	array = kmap_atomic(page);
 	memset(array, 0, sizeof(struct nfs_cache_array));
-	array->eof_index = -1;
 	kunmap_atomic(array);
 }
 
@@ -192,6 +192,17 @@ void nfs_readdir_clear_array(struct page *page)
 	kunmap_atomic(array);
 }
 
+static void nfs_readdir_array_set_eof(struct nfs_cache_array *array)
+{
+	array->page_is_eof = 1;
+	array->page_full = 1;
+}
+
+static bool nfs_readdir_array_is_full(struct nfs_cache_array *array)
+{
+	return array->page_full;
+}
+
 /*
  * the caller is responsible for freeing qstr.name
  * when called by nfs_readdir_add_to_array, the strings will be freed in
@@ -213,6 +224,23 @@ int nfs_readdir_make_qstr(struct qstr *string, const char *name, unsigned int le
 	return 0;
 }
 
+/*
+ * Check that the next array entry lies entirely within the page bounds
+ */
+static int nfs_readdir_array_can_expand(struct nfs_cache_array *array)
+{
+	struct nfs_cache_array_entry *cache_entry;
+
+	if (array->page_full)
+		return -ENOSPC;
+	cache_entry = &array->array[array->size + 1];
+	if ((char *)cache_entry - (char *)array > PAGE_SIZE) {
+		array->page_full = 1;
+		return -ENOSPC;
+	}
+	return 0;
+}
+
 static
 int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
 {
@@ -220,13 +248,11 @@ int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
 	struct nfs_cache_array_entry *cache_entry;
 	int ret;
 
-	cache_entry = &array->array[array->size];
-
-	/* Check that this entry lies within the page bounds */
-	ret = -ENOSPC;
-	if ((char *)&cache_entry[1] - (char *)page_address(page) > PAGE_SIZE)
+	ret = nfs_readdir_array_can_expand(array);
+	if (ret)
 		goto out;
 
+	cache_entry = &array->array[array->size];
 	cache_entry->cookie = entry->prev_cookie;
 	cache_entry->ino = entry->ino;
 	cache_entry->d_type = entry->d_type;
@@ -236,12 +262,21 @@ int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
 	array->last_cookie = entry->cookie;
 	array->size++;
 	if (entry->eof != 0)
-		array->eof_index = array->size;
+		nfs_readdir_array_set_eof(array);
 out:
 	kunmap(page);
 	return ret;
 }
 
+static void nfs_readdir_page_set_eof(struct page *page)
+{
+	struct nfs_cache_array *array;
+
+	array = kmap_atomic(page);
+	nfs_readdir_array_set_eof(array);
+	kunmap_atomic(array);
+}
+
 static inline
 int is_32bit_api(void)
 {
@@ -270,7 +305,7 @@ int nfs_readdir_search_for_pos(struct nfs_cache_array *array, nfs_readdir_descri
 	if (diff < 0)
 		goto out_eof;
 	if (diff >= array->size) {
-		if (array->eof_index >= 0)
+		if (array->page_is_eof)
 			goto out_eof;
 		return -EAGAIN;
 	}
@@ -334,7 +369,7 @@ int nfs_readdir_search_for_cookie(struct nfs_cache_array *array, nfs_readdir_des
 			return 0;
 		}
 	}
-	if (array->eof_index >= 0) {
+	if (array->page_is_eof) {
 		status = -EBADCOOKIE;
 		if (desc->dir_cookie == array->last_cookie)
 			desc->eof = true;
@@ -566,7 +601,6 @@ int nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct nfs_entry *en
 	struct xdr_stream stream;
 	struct xdr_buf buf;
 	struct page *scratch;
-	struct nfs_cache_array *array;
 	unsigned int count = 0;
 	int status;
 
@@ -604,10 +638,8 @@ int nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct nfs_entry *en
 
 out_nopages:
 	if (count == 0 || (status == -EBADCOOKIE && entry->eof != 0)) {
-		array = kmap(page);
-		array->eof_index = array->size;
+		nfs_readdir_page_set_eof(page);
 		status = 0;
-		kunmap(page);
 	}
 
 	put_page(scratch);
@@ -689,7 +721,7 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
 				status = 0;
 			break;
 		}
-	} while (array->eof_index < 0);
+	} while (!nfs_readdir_array_is_full(array));
 
 	nfs_readdir_free_pages(pages, array_size);
 out_release_array:
@@ -825,7 +857,7 @@ int nfs_do_filldir(nfs_readdir_descriptor_t *desc)
 		if (desc->duped != 0)
 			desc->duped = 1;
 	}
-	if (array->eof_index >= 0)
+	if (array->page_is_eof)
 		desc->eof = true;
 
 	kunmap(desc->page);
-- 
2.28.0

