Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5526D8928
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Apr 2023 22:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjDEU71 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Apr 2023 16:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjDEU7Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Apr 2023 16:59:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C97946B0
        for <linux-nfs@vger.kernel.org>; Wed,  5 Apr 2023 13:59:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEB1A62AAE
        for <linux-nfs@vger.kernel.org>; Wed,  5 Apr 2023 20:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF507C433EF;
        Wed,  5 Apr 2023 20:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680728361;
        bh=8QaW/kA7+fFuKxFnrs2AehaA00VFh7bJjhws3eC2FFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQbQ03uE1hJmPCyazdSxFlqULzgI43Oq+jovMJAfZhq0J83k3+gjQF4HfB8qzytIN
         mghLme80HCMjX8/GfEifKSulgZAg6siel6hALpBYJ7x2EoEaJLX63btQGCk65RQjqX
         n8m7ucdCeQN8GmniX2ou+vkTfe/pputHHgnPx1HYghgZGG6AfUbra0p63IvEO7vm+R
         HeujemBa5wqoJTCUPdX16EK67cdlgvi/mn8am7amQxL3lO+xKeSZN//2p/l+KwuYD8
         rQac0b2F9+57XeIT8yibf5z6ISAMJ5gAKu44HyDPOxjeuFqBYJ8UJJuKbhHEXmgrsC
         IVBRkUjt/+bWQ==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org
Subject: [PATCH 2/2] NFS: Convert readdir page array functions to use a folio
Date:   Wed,  5 Apr 2023 16:59:18 -0400
Message-Id: <20230405205918.228394-3-anna@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405205918.228394-1-anna@kernel.org>
References: <20230405205918.228394-1-anna@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/dir.c | 201 +++++++++++++++++++++++++--------------------------
 1 file changed, 99 insertions(+), 102 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 9edb0584c6d1..8257de6dba45 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -55,7 +55,7 @@ static int nfs_closedir(struct inode *, struct file *);
 static int nfs_readdir(struct file *, struct dir_context *);
 static int nfs_fsync_dir(struct file *, loff_t, loff_t, int);
 static loff_t nfs_llseek_dir(struct file *, loff_t, int);
-static void nfs_readdir_free_folio(struct folio *);
+static void nfs_readdir_clear_array(struct folio *);
 
 const struct file_operations nfs_dir_operations = {
 	.llseek		= nfs_llseek_dir,
@@ -67,7 +67,7 @@ const struct file_operations nfs_dir_operations = {
 };
 
 const struct address_space_operations nfs_dir_aops = {
-	.free_folio = nfs_readdir_free_folio,
+	.free_folio = nfs_readdir_clear_array,
 };
 
 #define NFS_INIT_DTSIZE PAGE_SIZE
@@ -146,8 +146,8 @@ struct nfs_cache_array {
 	u64 change_attr;
 	u64 last_cookie;
 	unsigned int size;
-	unsigned char page_full : 1,
-		      page_is_eof : 1,
+	unsigned char folio_full : 1,
+		      folio_is_eof : 1,
 		      cookies_are_ordered : 1;
 	struct nfs_cache_array_entry array[];
 };
@@ -198,17 +198,17 @@ static void nfs_grow_dtsize(struct nfs_readdir_descriptor *desc)
 	nfs_set_dtsize(desc, desc->dtsize << 1);
 }
 
-static void nfs_readdir_page_init_array(struct page *page, u64 last_cookie,
-					u64 change_attr)
+static void nfs_readdir_folio_init_array(struct folio *folio, u64 last_cookie,
+					 u64 change_attr)
 {
 	struct nfs_cache_array *array;
 
-	array = kmap_local_page(page);
+	array = kmap_local_folio(folio, 0);
 	array->change_attr = change_attr;
 	array->last_cookie = last_cookie;
 	array->size = 0;
-	array->page_full = 0;
-	array->page_is_eof = 0;
+	array->folio_full = 0;
+	array->folio_is_eof = 0;
 	array->cookies_are_ordered = 1;
 	kunmap_local(array);
 }
@@ -216,44 +216,39 @@ static void nfs_readdir_page_init_array(struct page *page, u64 last_cookie,
 /*
  * we are freeing strings created by nfs_add_to_readdir_array()
  */
-static void nfs_readdir_clear_array(struct page *page)
+static void nfs_readdir_clear_array(struct folio *folio)
 {
 	struct nfs_cache_array *array;
 	unsigned int i;
 
-	array = kmap_local_page(page);
+	array = kmap_local_folio(folio, 0);
 	for (i = 0; i < array->size; i++)
 		kfree(array->array[i].name);
 	array->size = 0;
 	kunmap_local(array);
 }
 
-static void nfs_readdir_free_folio(struct folio *folio)
+static void nfs_readdir_folio_reinit_array(struct folio *folio, u64 last_cookie,
+					   u64 change_attr)
 {
-	nfs_readdir_clear_array(&folio->page);
+	nfs_readdir_clear_array(folio);
+	nfs_readdir_folio_init_array(folio, last_cookie, change_attr);
 }
 
-static void nfs_readdir_page_reinit_array(struct page *page, u64 last_cookie,
-					  u64 change_attr)
+static struct folio *
+nfs_readdir_folio_array_alloc(u64 last_cookie, gfp_t gfp_flags)
 {
-	nfs_readdir_clear_array(page);
-	nfs_readdir_page_init_array(page, last_cookie, change_attr);
+	struct folio *folio = folio_alloc(gfp_flags, 0);
+	if (folio)
+		nfs_readdir_folio_init_array(folio, last_cookie, 0);
+	return folio;
 }
 
-static struct page *
-nfs_readdir_page_array_alloc(u64 last_cookie, gfp_t gfp_flags)
+static void nfs_readdir_folio_array_free(struct folio *folio)
 {
-	struct page *page = alloc_page(gfp_flags);
-	if (page)
-		nfs_readdir_page_init_array(page, last_cookie, 0);
-	return page;
-}
-
-static void nfs_readdir_page_array_free(struct page *page)
-{
-	if (page) {
-		nfs_readdir_clear_array(page);
-		put_page(page);
+	if (folio) {
+		nfs_readdir_clear_array(folio);
+		folio_put(folio);
 	}
 }
 
@@ -264,13 +259,13 @@ static u64 nfs_readdir_array_index_cookie(struct nfs_cache_array *array)
 
 static void nfs_readdir_array_set_eof(struct nfs_cache_array *array)
 {
-	array->page_is_eof = 1;
-	array->page_full = 1;
+	array->folio_is_eof = 1;
+	array->folio_full = 1;
 }
 
 static bool nfs_readdir_array_is_full(struct nfs_cache_array *array)
 {
-	return array->page_full;
+	return array->folio_full;
 }
 
 /*
@@ -302,16 +297,16 @@ static size_t nfs_readdir_array_maxentries(void)
  */
 static int nfs_readdir_array_can_expand(struct nfs_cache_array *array)
 {
-	if (array->page_full)
+	if (array->folio_full)
 		return -ENOSPC;
 	if (array->size == nfs_readdir_array_maxentries()) {
-		array->page_full = 1;
+		array->folio_full = 1;
 		return -ENOSPC;
 	}
 	return 0;
 }
 
-static int nfs_readdir_page_array_append(struct page *page,
+static int nfs_readdir_folio_array_append(struct folio *folio,
 					  const struct nfs_entry *entry,
 					  u64 *cookie)
 {
@@ -322,7 +317,7 @@ static int nfs_readdir_page_array_append(struct page *page,
 
 	name = nfs_readdir_copy_name(entry->name, entry->len);
 
-	array = kmap_atomic(page);
+	array = kmap_atomic(folio_page(folio, 0));
 	if (!name)
 		goto out;
 	ret = nfs_readdir_array_can_expand(array);
@@ -361,17 +356,17 @@ static int nfs_readdir_page_array_append(struct page *page,
  * 127 readdir entries for a typical 64-bit system, that works out to a
  * cache of ~ 33 million entries per directory.
  */
-static pgoff_t nfs_readdir_page_cookie_hash(u64 cookie)
+static pgoff_t nfs_readdir_folio_cookie_hash(u64 cookie)
 {
 	if (cookie == 0)
 		return 0;
 	return hash_64(cookie, 18);
 }
 
-static bool nfs_readdir_page_validate(struct page *page, u64 last_cookie,
-				      u64 change_attr)
+static bool nfs_readdir_folio_validate(struct folio *folio, u64 last_cookie,
+				       u64 change_attr)
 {
-	struct nfs_cache_array *array = kmap_local_page(page);
+	struct nfs_cache_array *array = kmap_local_folio(folio, 0);
 	int ret = true;
 
 	if (array->change_attr != change_attr)
@@ -382,81 +377,83 @@ static bool nfs_readdir_page_validate(struct page *page, u64 last_cookie,
 	return ret;
 }
 
-static void nfs_readdir_page_unlock_and_put(struct page *page)
+static void nfs_readdir_folio_unlock_and_put(struct folio *folio)
 {
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 }
 
-static void nfs_readdir_page_init_and_validate(struct page *page, u64 cookie,
-					       u64 change_attr)
+static void nfs_readdir_folio_init_and_validate(struct folio *folio, u64 cookie,
+						u64 change_attr)
 {
-	if (PageUptodate(page)) {
-		if (nfs_readdir_page_validate(page, cookie, change_attr))
+	if (folio_test_uptodate(folio)) {
+		if (nfs_readdir_folio_validate(folio, cookie, change_attr))
 			return;
-		nfs_readdir_clear_array(page);
+		nfs_readdir_clear_array(folio);
 	}
-	nfs_readdir_page_init_array(page, cookie, change_attr);
-	SetPageUptodate(page);
+	nfs_readdir_folio_init_array(folio, cookie, change_attr);
+	folio_mark_uptodate(folio);
 }
 
-static struct page *nfs_readdir_page_get_locked(struct address_space *mapping,
-						u64 cookie, u64 change_attr)
+static struct folio *nfs_readdir_folio_get_locked(struct address_space *mapping,
+						  u64 cookie, u64 change_attr)
 {
-	pgoff_t index = nfs_readdir_page_cookie_hash(cookie);
-	struct page *page;
+	pgoff_t index = nfs_readdir_folio_cookie_hash(cookie);
+	struct folio *folio;
 
-	page = grab_cache_page(mapping, index);
-	if (!page)
+	folio = filemap_grab_folio(mapping, index);
+	if (!folio)
 		return NULL;
-	nfs_readdir_page_init_and_validate(page, cookie, change_attr);
-	return page;
+	nfs_readdir_folio_init_and_validate(folio, cookie, change_attr);
+	return folio;
 }
 
-static u64 nfs_readdir_page_last_cookie(struct page *page)
+static u64 nfs_readdir_folio_last_cookie(struct folio *folio)
 {
 	struct nfs_cache_array *array;
 	u64 ret;
 
-	array = kmap_local_page(page);
+	array = kmap_local_folio(folio, 0);
 	ret = array->last_cookie;
 	kunmap_local(array);
 	return ret;
 }
 
-static bool nfs_readdir_page_needs_filling(struct page *page)
+static bool nfs_readdir_folio_needs_filling(struct folio *folio)
 {
 	struct nfs_cache_array *array;
 	bool ret;
 
-	array = kmap_local_page(page);
+	array = kmap_local_folio(folio, 0);
 	ret = !nfs_readdir_array_is_full(array);
 	kunmap_local(array);
 	return ret;
 }
 
-static void nfs_readdir_page_set_eof(struct page *page)
+static void nfs_readdir_folio_set_eof(struct folio *folio)
 {
 	struct nfs_cache_array *array;
 
-	array = kmap_local_page(page);
+	array = kmap_local_folio(folio, 0);
 	nfs_readdir_array_set_eof(array);
 	kunmap_local(array);
 }
 
-static struct page *nfs_readdir_page_get_next(struct address_space *mapping,
-					      u64 cookie, u64 change_attr)
+static struct folio *nfs_readdir_folio_get_next(struct address_space *mapping,
+						u64 cookie, u64 change_attr)
 {
-	pgoff_t index = nfs_readdir_page_cookie_hash(cookie);
-	struct page *page;
+	pgoff_t index = nfs_readdir_folio_cookie_hash(cookie);
+	struct folio *folio;
 
-	page = grab_cache_page_nowait(mapping, index);
-	if (!page)
+	folio = __filemap_get_folio(mapping, index,
+			FGP_LOCK|FGP_CREAT|FGP_NOFS|FGP_NOWAIT,
+			mapping_gfp_mask(mapping));
+	if (!folio)
 		return NULL;
-	nfs_readdir_page_init_and_validate(page, cookie, change_attr);
-	if (nfs_readdir_page_last_cookie(page) != cookie)
-		nfs_readdir_page_reinit_array(page, cookie, change_attr);
-	return page;
+	nfs_readdir_folio_init_and_validate(folio, cookie, change_attr);
+	if (nfs_readdir_folio_last_cookie(folio) != cookie)
+		nfs_readdir_folio_reinit_array(folio, cookie, change_attr);
+	return folio;
 }
 
 static inline
@@ -481,7 +478,7 @@ bool nfs_readdir_use_cookie(const struct file *filp)
 static void nfs_readdir_seek_next_array(struct nfs_cache_array *array,
 					struct nfs_readdir_descriptor *desc)
 {
-	if (array->page_full) {
+	if (array->folio_full) {
 		desc->last_cookie = array->last_cookie;
 		desc->current_index += array->size;
 		desc->cache_entry_index = 0;
@@ -506,7 +503,7 @@ static int nfs_readdir_search_for_pos(struct nfs_cache_array *array,
 	if (diff < 0)
 		goto out_eof;
 	if (diff >= array->size) {
-		if (array->page_is_eof)
+		if (array->folio_is_eof)
 			goto out_eof;
 		nfs_readdir_seek_next_array(array, desc);
 		return -EAGAIN;
@@ -554,7 +551,7 @@ static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
 		}
 	}
 check_eof:
-	if (array->page_is_eof) {
+	if (array->folio_is_eof) {
 		status = -EBADCOOKIE;
 		if (desc->dir_cookie == array->last_cookie)
 			desc->eof = true;
@@ -826,9 +823,9 @@ static int nfs_readdir_folio_filler(struct nfs_readdir_descriptor *desc,
 				    u64 change_attr)
 {
 	struct address_space *mapping = desc->file->f_mapping;
-	struct folio *folio = *arrays;
+	struct folio *new, *folio = *arrays;
 	struct xdr_stream stream;
-	struct page *scratch, *new;
+	struct page *scratch;
 	struct xdr_buf buf;
 	u64 cookie;
 	int status;
@@ -845,36 +842,36 @@ static int nfs_readdir_folio_filler(struct nfs_readdir_descriptor *desc,
 		if (status != 0)
 			break;
 
-		status = nfs_readdir_page_array_append(folio_page(folio, 0), entry, &cookie);
+		status = nfs_readdir_folio_array_append(folio, entry, &cookie);
 		if (status != -ENOSPC)
 			continue;
 
 		if (folio->mapping != mapping) {
 			if (!--narrays)
 				break;
-			new = nfs_readdir_page_array_alloc(cookie, GFP_KERNEL);
+			new = nfs_readdir_folio_array_alloc(cookie, GFP_KERNEL);
 			if (!new)
 				break;
 			arrays++;
-			*arrays = folio = page_folio(new);
+			*arrays = folio = new;
 		} else {
-			new = nfs_readdir_page_get_next(mapping, cookie,
-							change_attr);
+			new = nfs_readdir_folio_get_next(mapping, cookie,
+							 change_attr);
 			if (!new)
 				break;
 			if (folio != *arrays)
-				nfs_readdir_page_unlock_and_put(folio_page(folio, 0));
-			folio = page_folio(new);
+				nfs_readdir_folio_unlock_and_put(folio);
+			folio = new;
 		}
 		desc->folio_index_max++;
-		status = nfs_readdir_page_array_append(folio_page(folio, 0), entry, &cookie);
+		status = nfs_readdir_folio_array_append(folio, entry, &cookie);
 	} while (!status && !entry->eof);
 
 	switch (status) {
 	case -EBADCOOKIE:
 		if (!entry->eof)
 			break;
-		nfs_readdir_page_set_eof(folio_page(folio, 0));
+		nfs_readdir_folio_set_eof(folio);
 		fallthrough;
 	case -EAGAIN:
 		status = 0;
@@ -888,7 +885,7 @@ static int nfs_readdir_folio_filler(struct nfs_readdir_descriptor *desc,
 	}
 
 	if (folio != *arrays)
-		nfs_readdir_page_unlock_and_put(folio_page(folio, 0));
+		nfs_readdir_folio_unlock_and_put(folio);
 
 	put_page(scratch);
 	return status;
@@ -943,7 +940,7 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
 		return -ENOMEM;
-	entry->cookie = nfs_readdir_page_last_cookie(folio_page(folio, 0));
+	entry->cookie = nfs_readdir_folio_last_cookie(folio);
 	entry->fh = nfs_alloc_fhandle();
 	entry->fattr = nfs_alloc_fattr_with_label(NFS_SERVER(inode));
 	entry->server = NFS_SERVER(inode);
@@ -966,7 +963,7 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 		status = nfs_readdir_folio_filler(desc, entry, pages, pglen,
 						  arrays, narrays, change_attr);
 	else
-		nfs_readdir_page_set_eof(folio_page(folio, 0));
+		nfs_readdir_folio_set_eof(folio);
 	desc->buffer_fills++;
 
 free_pages:
@@ -997,14 +994,14 @@ nfs_readdir_folio_get_cached(struct nfs_readdir_descriptor *desc)
 	struct address_space *mapping = desc->file->f_mapping;
 	u64 change_attr = inode_peek_iversion_raw(mapping->host);
 	u64 cookie = desc->last_cookie;
-	struct page *page;
+	struct folio *folio;
 
-	page = nfs_readdir_page_get_locked(mapping, cookie, change_attr);
-	if (!page)
+	folio = nfs_readdir_folio_get_locked(mapping, cookie, change_attr);
+	if (!folio)
 		return NULL;
-	if (desc->clear_cache && !nfs_readdir_page_needs_filling(page))
-		nfs_readdir_page_reinit_array(page, cookie, change_attr);
-	return page_folio(page);
+	if (desc->clear_cache && !nfs_readdir_folio_needs_filling(folio))
+		nfs_readdir_folio_reinit_array(folio, cookie, change_attr);
+	return folio;
 }
 
 /*
@@ -1021,7 +1018,7 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 	desc->folio = nfs_readdir_folio_get_cached(desc);
 	if (!desc->folio)
 		return -ENOMEM;
-	if (nfs_readdir_page_needs_filling(folio_page(desc->folio, 0))) {
+	if (nfs_readdir_folio_needs_filling(desc->folio)) {
 		/* Grow the dtsize if we had to go back for more pages */
 		if (desc->folio_index == desc->folio_index_max)
 			nfs_grow_dtsize(desc);
@@ -1115,7 +1112,7 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
 			break;
 		}
 	}
-	if (array->page_is_eof)
+	if (array->folio_is_eof)
 		desc->eof = !desc->eob;
 
 	kunmap_local(array);
@@ -1148,7 +1145,7 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 	arrays = kcalloc(sz, sizeof(*arrays), GFP_KERNEL);
 	if (!arrays)
 		goto out;
-	arrays[0] = page_folio(nfs_readdir_page_array_alloc(desc->dir_cookie, GFP_KERNEL));
+	arrays[0] = nfs_readdir_folio_array_alloc(desc->dir_cookie, GFP_KERNEL);
 	if (!arrays[0])
 		goto out;
 
@@ -1185,7 +1182,7 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 	}
 out_free:
 	for (i = 0; i < sz && arrays[i]; i++)
-		nfs_readdir_page_array_free(folio_page(arrays[i], 0));
+		nfs_readdir_folio_array_free(arrays[i]);
 out:
 	if (!nfs_readdir_use_cookie(desc->file))
 		nfs_readdir_rewind_search(desc);
-- 
2.40.0

