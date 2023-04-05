Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F656D8927
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Apr 2023 22:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjDEU70 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Apr 2023 16:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDEU7X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Apr 2023 16:59:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98DC5583
        for <linux-nfs@vger.kernel.org>; Wed,  5 Apr 2023 13:59:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 443FF6363B
        for <linux-nfs@vger.kernel.org>; Wed,  5 Apr 2023 20:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F633C433D2;
        Wed,  5 Apr 2023 20:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680728360;
        bh=zVLjjOW7dxBEZSWUTdqq/WPt6w2yYT/c1QCizLHO+f4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cMizTafECGwnTJqZ+HSDmBjS9Z5ago4tlopxHVZ/eMRjM+lpRUwHQ23Q6DmzM0sE3
         VYJy1itlhcxEnYMDDRsaXq3K8TOaPw/Xf8gG2kos20rEtkd+wbMzlUm9MdmVWPie0q
         7pkSPtZUvn1zEz8jghK+X3M2bn/Bn+kC1MH28L+ZCPjmXhauTMPGrl2bY2CMD9n3XT
         FtdKi/rheNuheH6XqSbngrMF/jOw31kQMzlhae5fBKAuhW7+CR0w0ebZGH0+j0rf87
         /b3xKiTfXzX0/uCnSUF6HGc8487Qoryop78yw/oxsfC4CPYKLXn6ujv9eaQTCLGfL2
         nitFHzEkMZ3Jg==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org
Subject: [PATCH 1/2] NFS: Convert the readdir array-of-pages into an array-of-folios
Date:   Wed,  5 Apr 2023 16:59:17 -0400
Message-Id: <20230405205918.228394-2-anna@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405205918.228394-1-anna@kernel.org>
References: <20230405205918.228394-1-anna@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This patch only converts the actual array, but doesn't touch the
individual nfs_cache_array pages and related functions (that will be
done in the next patch).

I also adjust the names of the fields in the nfs_readdir_descriptor to
say "folio" instead of "page".

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/dir.c | 129 ++++++++++++++++++++++++++-------------------------
 1 file changed, 65 insertions(+), 64 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 6fbcbb8d6587..9edb0584c6d1 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -154,10 +154,10 @@ struct nfs_cache_array {
 
 struct nfs_readdir_descriptor {
 	struct file	*file;
-	struct page	*page;
+	struct folio	*folio;
 	struct dir_context *ctx;
-	pgoff_t		page_index;
-	pgoff_t		page_index_max;
+	pgoff_t		folio_index;
+	pgoff_t		folio_index_max;
 	u64		dir_cookie;
 	u64		last_cookie;
 	loff_t		current_index;
@@ -312,8 +312,8 @@ static int nfs_readdir_array_can_expand(struct nfs_cache_array *array)
 }
 
 static int nfs_readdir_page_array_append(struct page *page,
-					 const struct nfs_entry *entry,
-					 u64 *cookie)
+					  const struct nfs_entry *entry,
+					  u64 *cookie)
 {
 	struct nfs_cache_array *array;
 	struct nfs_cache_array_entry *cache_entry;
@@ -485,7 +485,7 @@ static void nfs_readdir_seek_next_array(struct nfs_cache_array *array,
 		desc->last_cookie = array->last_cookie;
 		desc->current_index += array->size;
 		desc->cache_entry_index = 0;
-		desc->page_index++;
+		desc->folio_index++;
 	} else
 		desc->last_cookie = nfs_readdir_array_index_cookie(array);
 }
@@ -494,7 +494,7 @@ static void nfs_readdir_rewind_search(struct nfs_readdir_descriptor *desc)
 {
 	desc->current_index = 0;
 	desc->last_cookie = 0;
-	desc->page_index = 0;
+	desc->folio_index = 0;
 }
 
 static int nfs_readdir_search_for_pos(struct nfs_cache_array *array,
@@ -568,7 +568,7 @@ static int nfs_readdir_search_array(struct nfs_readdir_descriptor *desc)
 	struct nfs_cache_array *array;
 	int status;
 
-	array = kmap_local_page(desc->page);
+	array = kmap_local_folio(desc->folio, 0);
 
 	if (desc->dir_cookie == 0)
 		status = nfs_readdir_search_for_pos(array, desc);
@@ -819,16 +819,17 @@ static int nfs_readdir_entry_decode(struct nfs_readdir_descriptor *desc,
 }
 
 /* Perform conversion from xdr to cache array */
-static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
-				   struct nfs_entry *entry,
-				   struct page **xdr_pages, unsigned int buflen,
-				   struct page **arrays, size_t narrays,
-				   u64 change_attr)
+static int nfs_readdir_folio_filler(struct nfs_readdir_descriptor *desc,
+				    struct nfs_entry *entry,
+				    struct page **xdr_pages, unsigned int buflen,
+				    struct folio **arrays, size_t narrays,
+				    u64 change_attr)
 {
 	struct address_space *mapping = desc->file->f_mapping;
+	struct folio *folio = *arrays;
 	struct xdr_stream stream;
+	struct page *scratch, *new;
 	struct xdr_buf buf;
-	struct page *scratch, *new, *page = *arrays;
 	u64 cookie;
 	int status;
 
@@ -844,36 +845,36 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 		if (status != 0)
 			break;
 
-		status = nfs_readdir_page_array_append(page, entry, &cookie);
+		status = nfs_readdir_page_array_append(folio_page(folio, 0), entry, &cookie);
 		if (status != -ENOSPC)
 			continue;
 
-		if (page->mapping != mapping) {
+		if (folio->mapping != mapping) {
 			if (!--narrays)
 				break;
 			new = nfs_readdir_page_array_alloc(cookie, GFP_KERNEL);
 			if (!new)
 				break;
 			arrays++;
-			*arrays = page = new;
+			*arrays = folio = page_folio(new);
 		} else {
 			new = nfs_readdir_page_get_next(mapping, cookie,
 							change_attr);
 			if (!new)
 				break;
-			if (page != *arrays)
-				nfs_readdir_page_unlock_and_put(page);
-			page = new;
+			if (folio != *arrays)
+				nfs_readdir_page_unlock_and_put(folio_page(folio, 0));
+			folio = page_folio(new);
 		}
-		desc->page_index_max++;
-		status = nfs_readdir_page_array_append(page, entry, &cookie);
+		desc->folio_index_max++;
+		status = nfs_readdir_page_array_append(folio_page(folio, 0), entry, &cookie);
 	} while (!status && !entry->eof);
 
 	switch (status) {
 	case -EBADCOOKIE:
 		if (!entry->eof)
 			break;
-		nfs_readdir_page_set_eof(page);
+		nfs_readdir_page_set_eof(folio_page(folio, 0));
 		fallthrough;
 	case -EAGAIN:
 		status = 0;
@@ -886,8 +887,8 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 			;
 	}
 
-	if (page != *arrays)
-		nfs_readdir_page_unlock_and_put(page);
+	if (folio != *arrays)
+		nfs_readdir_page_unlock_and_put(folio_page(folio, 0));
 
 	put_page(scratch);
 	return status;
@@ -927,11 +928,11 @@ static struct page **nfs_readdir_alloc_pages(size_t npages)
 
 static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 				    __be32 *verf_arg, __be32 *verf_res,
-				    struct page **arrays, size_t narrays)
+				    struct folio **arrays, size_t narrays)
 {
 	u64 change_attr;
 	struct page **pages;
-	struct page *page = *arrays;
+	struct folio *folio = *arrays;
 	struct nfs_entry *entry;
 	size_t array_size;
 	struct inode *inode = file_inode(desc->file);
@@ -942,7 +943,7 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
 		return -ENOMEM;
-	entry->cookie = nfs_readdir_page_last_cookie(page);
+	entry->cookie = nfs_readdir_page_last_cookie(folio_page(folio, 0));
 	entry->fh = nfs_alloc_fhandle();
 	entry->fattr = nfs_alloc_fattr_with_label(NFS_SERVER(inode));
 	entry->server = NFS_SERVER(inode);
@@ -962,10 +963,10 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 
 	pglen = status;
 	if (pglen != 0)
-		status = nfs_readdir_page_filler(desc, entry, pages, pglen,
-						 arrays, narrays, change_attr);
+		status = nfs_readdir_folio_filler(desc, entry, pages, pglen,
+						  arrays, narrays, change_attr);
 	else
-		nfs_readdir_page_set_eof(page);
+		nfs_readdir_page_set_eof(folio_page(folio, 0));
 	desc->buffer_fills++;
 
 free_pages:
@@ -977,21 +978,21 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 	return status;
 }
 
-static void nfs_readdir_page_put(struct nfs_readdir_descriptor *desc)
+static void nfs_readdir_folio_put(struct nfs_readdir_descriptor *desc)
 {
-	put_page(desc->page);
-	desc->page = NULL;
+	folio_put(desc->folio);
+	desc->folio = NULL;
 }
 
 static void
-nfs_readdir_page_unlock_and_put_cached(struct nfs_readdir_descriptor *desc)
+nfs_readdir_folio_unlock_and_put_cached(struct nfs_readdir_descriptor *desc)
 {
-	unlock_page(desc->page);
-	nfs_readdir_page_put(desc);
+	folio_unlock(desc->folio);
+	nfs_readdir_folio_put(desc);
 }
 
-static struct page *
-nfs_readdir_page_get_cached(struct nfs_readdir_descriptor *desc)
+static struct folio *
+nfs_readdir_folio_get_cached(struct nfs_readdir_descriptor *desc)
 {
 	struct address_space *mapping = desc->file->f_mapping;
 	u64 change_attr = inode_peek_iversion_raw(mapping->host);
@@ -1003,7 +1004,7 @@ nfs_readdir_page_get_cached(struct nfs_readdir_descriptor *desc)
 		return NULL;
 	if (desc->clear_cache && !nfs_readdir_page_needs_filling(page))
 		nfs_readdir_page_reinit_array(page, cookie, change_attr);
-	return page;
+	return page_folio(page);
 }
 
 /*
@@ -1017,21 +1018,21 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 	__be32 verf[NFS_DIR_VERIFIER_SIZE];
 	int res;
 
-	desc->page = nfs_readdir_page_get_cached(desc);
-	if (!desc->page)
+	desc->folio = nfs_readdir_folio_get_cached(desc);
+	if (!desc->folio)
 		return -ENOMEM;
-	if (nfs_readdir_page_needs_filling(desc->page)) {
+	if (nfs_readdir_page_needs_filling(folio_page(desc->folio, 0))) {
 		/* Grow the dtsize if we had to go back for more pages */
-		if (desc->page_index == desc->page_index_max)
+		if (desc->folio_index == desc->folio_index_max)
 			nfs_grow_dtsize(desc);
-		desc->page_index_max = desc->page_index;
+		desc->folio_index_max = desc->folio_index;
 		trace_nfs_readdir_cache_fill(desc->file, nfsi->cookieverf,
 					     desc->last_cookie,
-					     desc->page->index, desc->dtsize);
+					     desc->folio->index, desc->dtsize);
 		res = nfs_readdir_xdr_to_array(desc, nfsi->cookieverf, verf,
-					       &desc->page, 1);
+					       &desc->folio, 1);
 		if (res < 0) {
-			nfs_readdir_page_unlock_and_put_cached(desc);
+			nfs_readdir_folio_unlock_and_put_cached(desc);
 			trace_nfs_readdir_cache_fill_done(inode, res);
 			if (res == -EBADCOOKIE || res == -ENOTSYNC) {
 				invalidate_inode_pages2(desc->file->f_mapping);
@@ -1059,7 +1060,7 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 	res = nfs_readdir_search_array(desc);
 	if (res == 0)
 		return 0;
-	nfs_readdir_page_unlock_and_put_cached(desc);
+	nfs_readdir_folio_unlock_and_put_cached(desc);
 	return res;
 }
 
@@ -1087,7 +1088,7 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
 	unsigned int i;
 	bool first_emit = !desc->dir_cookie;
 
-	array = kmap_local_page(desc->page);
+	array = kmap_local_folio(desc->folio, 0);
 	for (i = desc->cache_entry_index; i < array->size; i++) {
 		struct nfs_cache_array_entry *ent;
 
@@ -1136,7 +1137,7 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
  */
 static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 {
-	struct page	**arrays;
+	struct folio	**arrays;
 	size_t		i, sz = 512;
 	__be32		verf[NFS_DIR_VERIFIER_SIZE];
 	int		status = -ENOMEM;
@@ -1147,14 +1148,14 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 	arrays = kcalloc(sz, sizeof(*arrays), GFP_KERNEL);
 	if (!arrays)
 		goto out;
-	arrays[0] = nfs_readdir_page_array_alloc(desc->dir_cookie, GFP_KERNEL);
+	arrays[0] = page_folio(nfs_readdir_page_array_alloc(desc->dir_cookie, GFP_KERNEL));
 	if (!arrays[0])
 		goto out;
 
-	desc->page_index = 0;
+	desc->folio_index = 0;
 	desc->cache_entry_index = 0;
 	desc->last_cookie = desc->dir_cookie;
-	desc->page_index_max = 0;
+	desc->folio_index_max = 0;
 
 	trace_nfs_readdir_uncached(desc->file, desc->verf, desc->last_cookie,
 				   -1, desc->dtsize);
@@ -1166,10 +1167,10 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 	}
 
 	for (i = 0; !desc->eob && i < sz && arrays[i]; i++) {
-		desc->page = arrays[i];
+		desc->folio = arrays[i];
 		nfs_do_filldir(desc, verf);
 	}
-	desc->page = NULL;
+	desc->folio = NULL;
 
 	/*
 	 * Grow the dtsize if we have to go back for more pages,
@@ -1179,16 +1180,16 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 		if (!desc->eob)
 			nfs_grow_dtsize(desc);
 		else if (desc->buffer_fills == 1 &&
-			 i < (desc->page_index_max >> 1))
+			 i < (desc->folio_index_max >> 1))
 			nfs_shrink_dtsize(desc);
 	}
 out_free:
 	for (i = 0; i < sz && arrays[i]; i++)
-		nfs_readdir_page_array_free(arrays[i]);
+		nfs_readdir_page_array_free(folio_page(arrays[i], 0));
 out:
 	if (!nfs_readdir_use_cookie(desc->file))
 		nfs_readdir_rewind_search(desc);
-	desc->page_index_max = -1;
+	desc->folio_index_max = -1;
 	kfree(arrays);
 	dfprintk(DIRCACHE, "NFS: %s: returns %d\n", __func__, status);
 	return status;
@@ -1240,11 +1241,11 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 		goto out;
 	desc->file = file;
 	desc->ctx = ctx;
-	desc->page_index_max = -1;
+	desc->folio_index_max = -1;
 
 	spin_lock(&file->f_lock);
 	desc->dir_cookie = dir_ctx->dir_cookie;
-	desc->page_index = dir_ctx->page_index;
+	desc->folio_index = dir_ctx->page_index;
 	desc->last_cookie = dir_ctx->last_cookie;
 	desc->attr_gencount = dir_ctx->attr_gencount;
 	desc->eof = dir_ctx->eof;
@@ -1291,8 +1292,8 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 			break;
 
 		nfs_do_filldir(desc, nfsi->cookieverf);
-		nfs_readdir_page_unlock_and_put_cached(desc);
-		if (desc->page_index == desc->page_index_max)
+		nfs_readdir_folio_unlock_and_put_cached(desc);
+		if (desc->folio_index == desc->folio_index_max)
 			desc->clear_cache = force_clear;
 	} while (!desc->eob && !desc->eof);
 
@@ -1300,7 +1301,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	dir_ctx->dir_cookie = desc->dir_cookie;
 	dir_ctx->last_cookie = desc->last_cookie;
 	dir_ctx->attr_gencount = desc->attr_gencount;
-	dir_ctx->page_index = desc->page_index;
+	dir_ctx->page_index = desc->folio_index;
 	dir_ctx->force_clear = force_clear;
 	dir_ctx->eof = desc->eof;
 	dir_ctx->dtsize = desc->dtsize;
-- 
2.40.0

