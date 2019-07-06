Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C019A612BB
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2019 20:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfGFSzC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 6 Jul 2019 14:55:02 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:32998 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbfGFSzC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 6 Jul 2019 14:55:02 -0400
Received: by mail-io1-f68.google.com with SMTP id z3so11049247iog.0
        for <linux-nfs@vger.kernel.org>; Sat, 06 Jul 2019 11:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=952lcyFF6G9xGAlj62HYi8JnFmlYvsdRdnp/06gbFsM=;
        b=i3xUTTgUeboVFw2atA6kG1c4//v/CF4rAFsc6VTnBzQ7ubIkoeF94TFJVjS+oHYNCj
         yN5pfCajbR/jZanWIxGhJmw3nNIrYDW59VGJfjhQ/1Lo1xtBtgqsE+6hLeu8LLq6+ojC
         xDOVbKDtRPnz/XwEl5Im3tbzHLuY5Klxuni1p7LV3mZkhr5buKSO3xfl+ZsRhlx+jRxQ
         hHZdWN2asiu+m4xJnpEHmhU14FPNTqX4SSFGMZ9XKRl3ECTXOflOa8KAjf7+wkblfh9/
         sjUtxzIxYPGClyeKbsQzwXcmw/YfBxt5vW2k1DvpklsV5NUUjVU8NDI+vkPMBf8UjhtE
         F+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=952lcyFF6G9xGAlj62HYi8JnFmlYvsdRdnp/06gbFsM=;
        b=RV2aQRJaFzSFz1+dcmZVUQvqh4gt5cNq9yjmM5lM/zzmNHEU0IYlIwq3DFKAXPGZvL
         nJAQdNKUU3rfQ9fdExviGa31QlmDnOjdBqbdMq7iCAzpppt3h4pu0n0kOqJ9k9QKn6T3
         GImuH8xmNDbduKgAD8sCSneyunKoLz30mt707eX0uNp5eknvIw6T73+KY9GDzou1OnuJ
         3eoi0hxr9uh/BHGB9Sv+xdg5G/b8AhSPvONX4cKWXqFKJWXJqMSxmslL15XqbBMFCT6L
         KIz1ILisnlxDSBkkzK/9Hid4HXcat6AreGHYHmdVY1VW0RwsatWSxrmvgddqnqxqU+3/
         rBzw==
X-Gm-Message-State: APjAAAUoGDVgxKleYE8ufiZZii6Di2OIc8HLql7Msu/uc7DUJg3+MFZ3
        zXv0pEIfUsffNtrmmhY13LU1kF462g==
X-Google-Smtp-Source: APXvYqyDqX/ndd/FZeRIQD5f4VBLlRDekiSkqpPLIa9JKtOiZzWV8QBQAXHIbckA5FR9Ky8DdloHgA==
X-Received: by 2002:a5d:885a:: with SMTP id t26mr10105303ios.218.1562439300732;
        Sat, 06 Jul 2019 11:55:00 -0700 (PDT)
Received: from localhost.localdomain (50-124-245-189.alma.mi.frontiernet.net. [50.124.245.189])
        by smtp.gmail.com with ESMTPSA id x22sm9117780ioh.87.2019.07.06.11.54.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 06 Jul 2019 11:55:00 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Cc:     Liguang Zhang <zhangliguang@linux.alibaba.com>
Subject: [PATCH 1/3] NFS: Fix off-by-one errors in nfs_readdir
Date:   Sat,  6 Jul 2019 14:52:50 -0400
Message-Id: <20190706185252.32488-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In C, the array size and the maximum index are not the same. In this
case, the field desc->pvec.nr is being used as a cursor but is
occasionally being treated as if it the array size.
This patch renames it to desc->pvec.cursor in order to make clear that
it is tracking an index.

Fixes: be4c2d4723a4 ("NFS: readdirplus optimization by cache mechanism")
Cc: Liguang Zhang <zhangliguang@linux.alibaba.com>
Cc: stable@vger.kernel.org # v5.1+
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 53 +++++++++++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 57b6a45576ad..e44f3c9fad5b 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -134,14 +134,14 @@ struct nfs_cache_array_entry {
 };
 
 struct nfs_cache_array {
-	int size;
-	int eof_index;
 	u64 last_cookie;
+	unsigned int size;
+	bool eof;
 	struct nfs_cache_array_entry array[0];
 };
 
 struct readdirvec {
-	unsigned long nr;
+	unsigned long cursor;
 	unsigned long index;
 	struct page *pages[NFS_MAX_READDIR_RAPAGES];
 };
@@ -172,7 +172,7 @@ static
 void nfs_readdir_clear_array(struct page *page)
 {
 	struct nfs_cache_array *array;
-	int i;
+	unsigned int i;
 
 	array = kmap_atomic(page);
 	for (i = 0; i < array->size; i++)
@@ -224,7 +224,7 @@ int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
 	array->last_cookie = entry->cookie;
 	array->size++;
 	if (entry->eof != 0)
-		array->eof_index = array->size;
+		array->eof = true;
 out:
 	kunmap(page);
 	return ret;
@@ -239,7 +239,7 @@ int nfs_readdir_search_for_pos(struct nfs_cache_array *array, nfs_readdir_descri
 	if (diff < 0)
 		goto out_eof;
 	if (diff >= array->size) {
-		if (array->eof_index >= 0)
+		if (array->eof)
 			goto out_eof;
 		return -EAGAIN;
 	}
@@ -265,7 +265,7 @@ nfs_readdir_inode_mapping_valid(struct nfs_inode *nfsi)
 static
 int nfs_readdir_search_for_cookie(struct nfs_cache_array *array, nfs_readdir_descriptor_t *desc)
 {
-	int i;
+	unsigned int i;
 	loff_t new_pos;
 	int status = -EAGAIN;
 
@@ -300,7 +300,7 @@ int nfs_readdir_search_for_cookie(struct nfs_cache_array *array, nfs_readdir_des
 			return 0;
 		}
 	}
-	if (array->eof_index >= 0) {
+	if (array->eof) {
 		status = -EBADCOOKIE;
 		if (*desc->dir_cookie == array->last_cookie)
 			desc->eof = true;
@@ -532,10 +532,9 @@ int nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct nfs_entry *en
 	struct nfs_cache_array *array;
 	unsigned int count = 0;
 	int status;
-	int max_rapages = NFS_MAX_READDIR_RAPAGES;
 
 	desc->pvec.index = desc->page_index;
-	desc->pvec.nr = 0;
+	desc->pvec.cursor = 0;
 
 	scratch = alloc_page(GFP_KERNEL);
 	if (scratch == NULL)
@@ -560,12 +559,12 @@ int nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct nfs_entry *en
 		if (desc->plus)
 			nfs_prime_dcache(file_dentry(desc->file), entry);
 
-		status = nfs_readdir_add_to_array(entry, desc->pvec.pages[desc->pvec.nr]);
+		status = nfs_readdir_add_to_array(entry, desc->pvec.pages[desc->pvec.cursor]);
 		if (status == -ENOSPC) {
-			desc->pvec.nr++;
-			if (desc->pvec.nr == max_rapages)
+			if (desc->pvec.cursor == ARRAY_SIZE(desc->pvec.pages) - 1)
 				break;
-			status = nfs_readdir_add_to_array(entry, desc->pvec.pages[desc->pvec.nr]);
+			desc->pvec.cursor++;
+			status = nfs_readdir_add_to_array(entry, desc->pvec.pages[desc->pvec.cursor]);
 		}
 		if (status != 0)
 			break;
@@ -579,8 +578,8 @@ int nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct nfs_entry *en
 
 out_nopages:
 	if (count == 0 || (status == -EBADCOOKIE && entry->eof != 0)) {
-		array = kmap_atomic(desc->pvec.pages[desc->pvec.nr]);
-		array->eof_index = array->size;
+		array = kmap_atomic(desc->pvec.pages[desc->pvec.cursor]);
+		array->eof = true;
 		status = 0;
 		kunmap_atomic(array);
 	}
@@ -588,11 +587,11 @@ int nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct nfs_entry *en
 	put_page(scratch);
 
 	/*
-	 * desc->pvec.nr > 0 means at least one page was completely filled,
+	 * desc->pvec.cursor > 0 means at least one page was completely filled,
 	 * we should return -ENOSPC. Otherwise function
 	 * nfs_readdir_xdr_to_array will enter infinite loop.
 	 */
-	if (desc->pvec.nr > 0)
+	if (desc->pvec.cursor > 0)
 		return -ENOSPC;
 	return status;
 }
@@ -634,13 +633,12 @@ static
 void nfs_readdir_rapages_init(nfs_readdir_descriptor_t *desc)
 {
 	struct nfs_cache_array *array;
-	int max_rapages = NFS_MAX_READDIR_RAPAGES;
-	int index;
+	unsigned int max_rapages = NFS_MAX_READDIR_RAPAGES;
+	unsigned int index;
 
 	for (index = 0; index < max_rapages; index++) {
 		array = kmap_atomic(desc->pvec.pages[index]);
 		memset(array, 0, sizeof(struct nfs_cache_array));
-		array->eof_index = -1;
 		kunmap_atomic(array);
 	}
 }
@@ -678,7 +676,6 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
 
 	array = kmap(page);
 	memset(array, 0, sizeof(struct nfs_cache_array));
-	array->eof_index = -1;
 
 	status = nfs_readdir_alloc_pages(pages, array_size);
 	if (status < 0)
@@ -696,7 +693,7 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
 				status = 0;
 			break;
 		}
-	} while (array->eof_index < 0);
+	} while (!array->eof);
 
 	nfs_readdir_free_pages(pages, array_size);
 out_release_array:
@@ -723,10 +720,10 @@ int nfs_readdir_filler(void *data, struct page* page)
 
 	/*
 	 * If desc->page_index in range desc->pvec.index and
-	 * desc->pvec.index + desc->pvec.nr, we get readdir cache hit.
+	 * desc->pvec.index + desc->pvec.cursor, we get readdir cache hit.
 	 */
 	if (desc->page_index >= desc->pvec.index &&
-		desc->page_index < (desc->pvec.index + desc->pvec.nr)) {
+		desc->page_index <= (desc->pvec.index + desc->pvec.cursor)) {
 		/*
 		 * page and desc->pvec.pages[x] are valid, don't need to check
 		 * whether or not to be NULL.
@@ -809,7 +806,7 @@ static
 int nfs_do_filldir(nfs_readdir_descriptor_t *desc)
 {
 	struct file	*file = desc->file;
-	int i = 0;
+	unsigned int i = 0;
 	int res = 0;
 	struct nfs_cache_array *array = NULL;
 	struct nfs_open_dir_context *ctx = file->private_data;
@@ -832,7 +829,7 @@ int nfs_do_filldir(nfs_readdir_descriptor_t *desc)
 		if (ctx->duped != 0)
 			ctx->duped = 1;
 	}
-	if (array->eof_index >= 0)
+	if (array->eof)
 		desc->eof = true;
 
 	kunmap(desc->page);
@@ -903,7 +900,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 			*desc = &my_desc;
 	struct nfs_open_dir_context *dir_ctx = file->private_data;
 	int res = 0;
-	int max_rapages = NFS_MAX_READDIR_RAPAGES;
+	unsigned int max_rapages = NFS_MAX_READDIR_RAPAGES;
 
 	dfprintk(FILE, "NFS: readdir(%pD2) starting at cookie %llu\n",
 			file, (long long)ctx->pos);
-- 
2.21.0

