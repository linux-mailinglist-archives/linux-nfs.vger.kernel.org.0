Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FB42FD66C
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Jan 2021 18:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390516AbhATRFR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Jan 2021 12:05:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31225 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391640AbhATRBf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Jan 2021 12:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611161998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GL8zcAAOe0LOWtBilVqSl72jNLzxzlhtqp7dMQVcB9E=;
        b=Prhb4AY8TFCJZcwOk3111Bb8PjHzsTxLSVkXgY9ZibKUV3xIRsi80BQYGRy/2F4Gepvx8K
        wSECTf7wg/beZGNxOM7lo7+e4I5QQAvG5Y9uiOHXTDQfjgcyKYoqbFpWpS6vllhCt10xMT
        B+wwGA30iTcUZ+q0W4q8FBzZ1UOdpZA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-sA0O7YooOLWUi1ARmmSdzQ-1; Wed, 20 Jan 2021 11:59:56 -0500
X-MC-Unique: sA0O7YooOLWUi1ARmmSdzQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F7908735C6
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jan 2021 16:59:55 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CBAF5D9C2
        for <linux-nfs@vger.kernel.org>; Wed, 20 Jan 2021 16:59:55 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id AC16810E3EFE; Wed, 20 Jan 2021 11:59:54 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 05/10] NFS: readdir per-page cache validation
Date:   Wed, 20 Jan 2021 11:59:49 -0500
Message-Id: <885cd036b5400bd637b41003cdcae30ef28018fa.1611160121.git.bcodding@redhat.com>
In-Reply-To: <cover.1611160120.git.bcodding@redhat.com>
References: <cover.1611160120.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The current implementation of the readdir page cache requires that all
pages contain entries ordered such that the cookie references lead to the
first entry as represented by cookie 0.  The invalidation of the cache
truncates either the entire cache or every page beyond a known good page.

A process that wants to emit directory entries near the end of a directory
must first fill in any entries missing in the cache near the beginning of
the directory in order that the entries decoded from READDIR XDR are
appropriately page-aligned for any readers thay may come later (and for
some error handling).

However, if we're careful to check the alignment of directory entries on
each page when the page is read, then it should be permissable to allow
"disconnected" filling of the pagecache.  Rather than requiring pagecache
data to always be positionally aligned, we can instead validate that each
page is properly aligned to the reading process' directory context. If it
doesn't match our alignment, we'll refresh the entries in the page so that
it does.

This patch implements a check for validity for each page as it is obtained
from the pagecache.  A page is valid if it was filled within the client's
current version of the directory and if the entries are aligned with the
current reader's directory context.

Invalid pages are re-filled by READDIR operations before being used to emit
entries for the current reader.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/dir.c | 71 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 57 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 7f6c84c8a412..5fc22d97054a 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -188,13 +188,16 @@ static void nfs_readdir_page_init_array(struct page *page, u64 last_cookie)
 	array->last_cookie = last_cookie;
 	array->cookies_are_ordered = 1;
 	kunmap_atomic(array);
-	set_page_private(page, 0);
+	if (page->mapping)
+		set_page_private(page, nfs_save_change_attribute(page->mapping->host));
+	SetPageUptodate(page);
 }
 
 static int
 nfs_readdir_clear_page(struct page *page, gfp_t gfp_mask)
 {
-	detach_page_private(page);
+	unsigned long change_attr;
+	change_attr = (unsigned long)detach_page_private(page);
 	return 1;
 }
 
@@ -225,6 +228,15 @@ void nfs_readdir_clear_array(struct page *page)
 		kfree(array->array[i].name);
 	nfs_readdir_array_init(array);
 	kunmap_atomic(array);
+	ClearPageUptodate(page);
+}
+
+static void
+nfs_readdir_recycle_page(struct page *page, u64 last_cookie)
+{
+	nfs_readdir_clear_array(page);
+	nfs_readdir_invalidatepage(page, 0, 0);
+	nfs_readdir_page_init_array(page, last_cookie);
 }
 
 static struct page *
@@ -341,18 +353,47 @@ int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
 	return ret;
 }
 
+static bool
+nfs_readdir_page_valid(struct page *page, unsigned int entry_index, u64 index_cookie)
+{
+	bool ret = false;
+	struct nfs_cache_array *array;
+
+	if (page_private(page) != nfs_save_change_attribute(page->mapping->host))
+		goto out;
+
+	ret = true;
+	array = kmap_atomic(page);
+
+	if (array->size == 0 && array->last_cookie == index_cookie)
+		goto out_unmap;
+
+	if (array->size > entry_index &&
+		array->array[entry_index].cookie == index_cookie)
+		goto out_unmap;
+
+	ret = false;
+out_unmap:
+	kunmap_atomic(array);
+out:
+	return ret;
+}
+
 static struct page *nfs_readdir_page_get_locked(struct address_space *mapping,
-						pgoff_t index, u64 last_cookie)
+						struct nfs_dir_page_cursor *pgc)
 {
 	struct page *page;
 
-	page = grab_cache_page(mapping, index);
-	if (page && !PageUptodate(page)) {
-		nfs_readdir_page_init_array(page, last_cookie);
-		if (invalidate_inode_pages2_range(mapping, index + 1, -1) < 0)
-			nfs_zap_mapping(mapping->host, mapping);
-		SetPageUptodate(page);
-	}
+	page = grab_cache_page(mapping, pgc->page_index);
+
+	if (!page)
+		return page;
+
+	if (!PageUptodate(page))
+		nfs_readdir_page_init_array(page, pgc->index_cookie);
+
+	if (!nfs_readdir_page_valid(page, pgc->entry_index, pgc->index_cookie))
+		nfs_readdir_recycle_page(page, pgc->index_cookie);
 
 	return page;
 }
@@ -398,8 +439,12 @@ static struct page *nfs_readdir_page_get_next(struct address_space *mapping,
 					      pgoff_t index, u64 cookie)
 {
 	struct page *page;
+	struct nfs_dir_page_cursor pgc = {
+		.page_index = index,
+		.index_cookie = cookie,
+	};
 
-	page = nfs_readdir_page_get_locked(mapping, index, cookie);
+	page = nfs_readdir_page_get_locked(mapping, &pgc);
 	if (page) {
 		if (nfs_readdir_page_last_cookie(page) == cookie)
 			return page;
@@ -943,9 +988,7 @@ nfs_readdir_page_unlock_and_put_cached(struct nfs_readdir_descriptor *desc)
 static struct page *
 nfs_readdir_page_get_cached(struct nfs_readdir_descriptor *desc)
 {
-	return nfs_readdir_page_get_locked(desc->file->f_mapping,
-					   desc->pgc.page_index,
-					   desc->pgc.index_cookie);
+	return nfs_readdir_page_get_locked(desc->file->f_mapping, &desc->pgc);
 }
 
 /*
-- 
2.25.4

