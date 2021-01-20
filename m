Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68712FD664
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Jan 2021 18:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391243AbhATRDQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Jan 2021 12:03:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39949 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391610AbhATRBf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Jan 2021 12:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611161998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t125QmRUZ6lWveNo9xy4Ip66ayIlsdPL9LtMwbw8Qvw=;
        b=Ow9lSxZzUoIURNjnfYy+/KW8M6e3jsZPoqEYASG56upTLjhfuhEiKp4g3J4U/CnLuGcaZM
        QKZnTrXkHmz4XIBdMGi5oB2anUXBTgu+TC1DiKahn/9TsXmEpFx56aBaj9mLr3SycRyykm
        zLjd+D6nzXULxvYchcGo7LG+vr0jOJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-usLKWE44OYCBa53xXoCVeA-1; Wed, 20 Jan 2021 11:59:56 -0500
X-MC-Unique: usLKWE44OYCBa53xXoCVeA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A436E100C602
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jan 2021 16:59:55 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 704C55D767
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jan 2021 16:59:55 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id C6B1310E5BCF; Wed, 20 Jan 2021 11:59:54 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 07/10] NFS: Support headless readdir pagecache pages
Date:   Wed, 20 Jan 2021 11:59:51 -0500
Message-Id: <7394b4d348d0c92b64cd0fb4fbf74bfa6e676d24.1611160121.git.bcodding@redhat.com>
In-Reply-To: <cover.1611160120.git.bcodding@redhat.com>
References: <cover.1611160120.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
 fs/nfs/dir.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 4e21b21c75d0..d6101e45fd66 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -143,6 +143,7 @@ struct nfs_cache_array_entry {
 
 struct nfs_cache_array {
 	u64 last_cookie;
+	unsigned int index;
 	unsigned int size;
 	unsigned char page_full : 1,
 		      page_is_eof : 1,
@@ -179,13 +180,15 @@ static void nfs_readdir_array_init(struct nfs_cache_array *array)
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
@@ -224,7 +227,7 @@ void nfs_readdir_clear_array(struct page *page)
 	int i;
 
 	array = kmap_atomic(page);
-	for (i = 0; i < array->size; i++)
+	for (i = array->index - array->size; i < array->size; i++)
 		kfree(array->array[i].name);
 	nfs_readdir_array_init(array);
 	kunmap_atomic(array);
@@ -232,19 +235,20 @@ void nfs_readdir_clear_array(struct page *page)
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
 
@@ -309,7 +313,7 @@ static int nfs_readdir_array_can_expand(struct nfs_cache_array *array)
 
 	if (array->page_full)
 		return -ENOSPC;
-	cache_entry = &array->array[array->size + 1];
+	cache_entry = &array->array[array->index + 1];
 	if ((char *)cache_entry - (char *)array > PAGE_SIZE) {
 		array->page_full = 1;
 		return -ENOSPC;
@@ -336,7 +340,7 @@ int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
 		goto out;
 	}
 
-	cache_entry = &array->array[array->size];
+	cache_entry = &array->array[array->index];
 	cache_entry->cookie = entry->prev_cookie;
 	cache_entry->ino = entry->ino;
 	cache_entry->d_type = entry->d_type;
@@ -345,6 +349,7 @@ int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
 	array->last_cookie = entry->cookie;
 	if (array->last_cookie <= cache_entry->cookie)
 		array->cookies_are_ordered = 0;
+	array->index++;
 	array->size++;
 	if (entry->eof != 0)
 		nfs_readdir_array_set_eof(array);
@@ -365,13 +370,15 @@ nfs_readdir_page_valid(struct page *page, unsigned int entry_index, u64 index_co
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
@@ -391,10 +398,10 @@ static struct page *nfs_readdir_page_get_locked(struct address_space *mapping,
 		return page;
 
 	if (!PageUptodate(page))
-		nfs_readdir_page_init_array(page, pgc->index_cookie);
+		nfs_readdir_page_init_array(page, pgc);
 
 	if (!nfs_readdir_page_valid(page, pgc->entry_index, pgc->index_cookie))
-		nfs_readdir_recycle_page(page, pgc->index_cookie);
+		nfs_readdir_recycle_page(page, pgc);
 
 	return page;
 }
@@ -513,7 +520,7 @@ static bool nfs_readdir_array_cookie_in_range(struct nfs_cache_array *array,
 	/* Optimisation for monotonically increasing cookies */
 	if (cookie >= array->last_cookie)
 		return false;
-	if (array->size && cookie < array->array[0].cookie)
+	if (array->size && cookie < array->array[array->index - array->size].cookie)
 		return false;
 	return true;
 }
@@ -528,7 +535,7 @@ static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
 	if (!nfs_readdir_array_cookie_in_range(array, desc->dir_cookie))
 		goto check_eof;
 
-	for (i = 0; i < array->size; i++) {
+	for (i = array->index - array->size; i < array->index; i++) {
 		if (array->array[i].cookie == desc->dir_cookie) {
 			struct nfs_inode *nfsi = NFS_I(file_inode(desc->file));
 
@@ -1072,7 +1079,7 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc)
 	unsigned int i = 0;
 
 	array = kmap(desc->page);
-	for (i = desc->pgc.entry_index; i < array->size; i++) {
+	for (i = desc->pgc.entry_index; i < array->index; i++) {
 		struct nfs_cache_array_entry *ent;
 
 		ent = &array->array[i];
-- 
2.25.4

