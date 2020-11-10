Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969522AE207
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Nov 2020 22:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731880AbgKJVr4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 16:47:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:43108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731746AbgKJVr4 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Nov 2020 16:47:56 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB5AF20825
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 21:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605044875;
        bh=Z9toTdwSRegDhl6O1z6E1k0DrSTbATOIZpAKrQrSzbU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=xStwQ1rq6aO2CQEMVFJHu2KALmLul5ShkL7UfSY/uXrbq3XxOvW5Gv/Sn6bBDX6Gv
         dkmEfKJqUyZKCdrbtYs4WMuQ/cHoxTahtv1KBp0RbvI5IX0SZ1B3RnCjkgZbKv+EhG
         BRodkVnn3G8vBCYvft3g/r2SRxpkBBBKAvZOUuuI=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 05/22] NFS: Clean up readdir struct nfs_cache_array
Date:   Tue, 10 Nov 2020 16:37:24 -0500
Message-Id: <20201110213741.860745-6-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110213741.860745-5-trondmy@kernel.org>
References: <20201110213741.860745-1-trondmy@kernel.org>
 <20201110213741.860745-2-trondmy@kernel.org>
 <20201110213741.860745-3-trondmy@kernel.org>
 <20201110213741.860745-4-trondmy@kernel.org>
 <20201110213741.860745-5-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Since the 'eof_index' is only ever used as a flag, make it so.
Also add a flag to detect if the page has been completely filled.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Tested-by: Benjamin Coddington <bcodding@redhat.com>
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

