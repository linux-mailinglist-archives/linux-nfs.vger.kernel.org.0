Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBE14C146A
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 14:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237639AbiBWNlI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 08:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241000AbiBWNlI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 08:41:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FD7BAC069
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 05:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645623639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FAtltKz/f+X4fOyD4r1GJP5vrXhW8/0cnZDFjVmWsxY=;
        b=ixOYNi2VQ8s7KSV1+1IVltaPWdI5HpyghBlQ9BIQBFjYG3UK3Y/TW1fqq3NaKFOzw3RJH5
        e+iNoJJ6xyR/hN5ng1giTX9KSxVJEcrV2McoFL4t6uWBaD9+fsohpRFv0U1IuxwcK63BAW
        K3lgCjUfCeNljLpRq6zUoOuoSaYx5vQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-h-K_Ed_lNAi0r5YKjkOvVQ-1; Wed, 23 Feb 2022 08:40:37 -0500
X-MC-Unique: h-K_Ed_lNAi0r5YKjkOvVQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2239C10247A7
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:40:37 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E972E84979
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:40:36 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 10FD810C3110; Wed, 23 Feb 2022 08:40:36 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 7/8] NFS: Support headless readdir pagecache pages
Date:   Wed, 23 Feb 2022 08:40:34 -0500
Message-Id: <71835b457fb123f8e4d51ea9fb586e46016562ff.1645623510.git.bcodding@redhat.com>
In-Reply-To: <19ef38cda6b0eb6548c65c2bff7a4d4dd1baa122.1645623510.git.bcodding@redhat.com>
References: <d759b6df8acd82b8d44e2afcf11a7a94dcf85ba6.1645623510.git.bcodding@redhat.com> <eedb07d14a96caef1de663a436a326b2c5012ab4.1645623510.git.bcodding@redhat.com> <aaedb2e378800a5cdb7071d65690b981274f2c22.1645623510.git.bcodding@redhat.com> <5479c8c5be9cf3f387edac54f170461f8f7b89e2.1645623510.git.bcodding@redhat.com> <c597a8ae5ea99de277b3f2e6486fe3bde1c5f64a.1645623510.git.bcodding@redhat.com> <19ef38cda6b0eb6548c65c2bff7a4d4dd1baa122.1645623510.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

It is now possible that a reader will resume a directory listing after an
invalidation and fill the rest of the pages with the offset left over from
the last partially-filled page.  These pages will then be recycled and
refilled by the next reader since their alignment is incorrect.

Add an index to the nfs_cache_array that will indicate where the next entry
should be filled.  This allows partially-filled pages to have the best
alignment possible.  They are more likely to be useful to readers that
follow.

This optimization targets the case when there are multiple processes
listing the directory simultaneously.  Often the processes will collect and
block on the same page waiting for a READDIR call to fill the pagecache.
If the pagecache is invalidated, a partially-filled page will usually
result.  This partially-filled page can immediately be used by all
processes to emit entries rather than having to discard and refill it for
every process.

The addition of another integer to struct nfs_cache_array increases its
size to 24 bytes. We do not lose the original capacity of 127 entries per
page.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/dir.c | 47 ++++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 4f4a139f3181..a570f14633ab 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -147,6 +147,7 @@ struct nfs_cache_array_entry {
 
 struct nfs_cache_array {
 	u64 last_cookie;
+	unsigned int index;
 	unsigned int size;
 	unsigned char page_full : 1,
 		      page_is_eof : 1,
@@ -210,13 +211,15 @@ static void nfs_readdir_array_init(struct nfs_cache_array *array)
 	memset(array, 0, sizeof(struct nfs_cache_array));
 }
 
-static void nfs_readdir_page_init_array(struct page *page, u64 last_cookie)
+static void
+nfs_readdir_page_init_array(struct page *page, struct nfs_dir_page_cursor *pgc)
 {
 	struct nfs_cache_array *array;
 
 	array = kmap_atomic(page);
 	nfs_readdir_array_init(array);
-	array->last_cookie = last_cookie;
+	array->last_cookie = pgc->index_cookie;
+	array->index = pgc->entry_index;
 	array->cookies_are_ordered = 1;
 	kunmap_atomic(array);
 	if (page->mapping)
@@ -254,7 +257,7 @@ void nfs_readdir_clear_array(struct page *page)
 	int i;
 
 	array = kmap_atomic(page);
-	for (i = 0; i < array->size; i++)
+	for (i = array->index - array->size; i < array->size; i++)
 		kfree(array->array[i].name);
 	nfs_readdir_array_init(array);
 	kunmap_atomic(array);
@@ -262,19 +265,20 @@ void nfs_readdir_clear_array(struct page *page)
 }
 
 static void
-nfs_readdir_recycle_page(struct page *page, u64 last_cookie)
+nfs_readdir_recycle_page(struct page *page, struct nfs_dir_page_cursor *pgc)
 {
 	nfs_readdir_clear_array(page);
 	nfs_readdir_invalidatepage(page, 0, 0);
-	nfs_readdir_page_init_array(page, last_cookie);
+	nfs_readdir_page_init_array(page, pgc);
 }
 
 static struct page *
 nfs_readdir_page_array_alloc(u64 last_cookie, gfp_t gfp_flags)
 {
 	struct page *page = alloc_page(gfp_flags);
+	struct nfs_dir_page_cursor pgc = { .index_cookie = last_cookie };
 	if (page)
-		nfs_readdir_page_init_array(page, last_cookie);
+		nfs_readdir_page_init_array(page, &pgc);
 	return page;
 }
 
@@ -339,7 +343,7 @@ static int nfs_readdir_array_can_expand(struct nfs_cache_array *array)
 
 	if (array->page_full)
 		return -ENOSPC;
-	cache_entry = &array->array[array->size + 1];
+	cache_entry = &array->array[array->index + 1];
 	if ((char *)cache_entry - (char *)array > PAGE_SIZE) {
 		array->page_full = 1;
 		return -ENOSPC;
@@ -366,7 +370,7 @@ int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
 		goto out;
 	}
 
-	cache_entry = &array->array[array->size];
+	cache_entry = &array->array[array->index];
 	cache_entry->cookie = entry->prev_cookie;
 	cache_entry->ino = entry->ino;
 	cache_entry->d_type = entry->d_type;
@@ -375,6 +379,7 @@ int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
 	array->last_cookie = entry->cookie;
 	if (array->last_cookie <= cache_entry->cookie)
 		array->cookies_are_ordered = 0;
+	array->index++;
 	array->size++;
 	if (entry->eof != 0)
 		nfs_readdir_array_set_eof(array);
@@ -395,13 +400,15 @@ nfs_readdir_page_valid(struct page *page, unsigned int entry_index, u64 index_co
 	ret = true;
 	array = kmap_atomic(page);
 
-	if ((array->size == 0 || array->size == entry_index)
-		&& array->last_cookie == index_cookie)
-		goto out_unmap;
+	if (entry_index >= array->index - array->size) {
+		if ((array->size == 0 || array->size == entry_index)
+			&& array->last_cookie == index_cookie)
+			goto out_unmap;
 
-	if (array->size > entry_index &&
-		array->array[entry_index].cookie == index_cookie)
-		goto out_unmap;
+		if (array->size > entry_index &&
+			array->array[entry_index].cookie == index_cookie)
+			goto out_unmap;
+	}
 
 	ret = false;
 out_unmap:
@@ -421,10 +428,10 @@ static struct page *nfs_readdir_page_get_locked(struct address_space *mapping,
 		return page;
 
 	if (!PageUptodate(page))
-		nfs_readdir_page_init_array(page, pgc->index_cookie);
+		nfs_readdir_page_init_array(page, pgc);
 
 	if (!nfs_readdir_page_valid(page, pgc->entry_index, pgc->index_cookie))
-		nfs_readdir_recycle_page(page, pgc->index_cookie);
+		nfs_readdir_recycle_page(page, pgc);
 
 	return page;
 }
@@ -544,7 +551,7 @@ static bool nfs_readdir_array_cookie_in_range(struct nfs_cache_array *array,
 	/* Optimisation for monotonically increasing cookies */
 	if (cookie >= array->last_cookie)
 		return false;
-	if (array->size && cookie < array->array[0].cookie)
+	if (array->size && cookie < array->array[array->index - array->size].cookie)
 		return false;
 	return true;
 }
@@ -559,7 +566,7 @@ static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
 	if (!nfs_readdir_array_cookie_in_range(array, desc->dir_cookie))
 		goto check_eof;
 
-	for (i = 0; i < array->size; i++) {
+	for (i = array->index - array->size; i < array->index; i++) {
 		if (array->array[i].cookie == desc->dir_cookie) {
 			struct nfs_inode *nfsi = NFS_I(file_inode(desc->file));
 
@@ -1120,7 +1127,7 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
 	unsigned int i = 0;
 
 	array = kmap(desc->page);
-	for (i = desc->pgc.entry_index; i < array->size; i++) {
+	for (i = desc->pgc.entry_index; i < array->index; i++) {
 		struct nfs_cache_array_entry *ent;
 
 		ent = &array->array[i];
@@ -1387,6 +1394,8 @@ static loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int whence)
 		else
 			dir_ctx->pgc.index_cookie = 0;
 		dir_ctx->page_fill_misses = 0;
+		dir_ctx->pgc.page_index = 0;
+		dir_ctx->pgc.entry_index = 0;
 		if (offset == 0)
 			memset(dir_ctx->verf, 0, sizeof(dir_ctx->verf));
 		dir_ctx->duped = 0;
-- 
2.31.1

