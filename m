Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4B04C1466
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 14:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241004AbiBWNlJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 08:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240996AbiBWNlI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 08:41:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8C46AC066
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 05:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645623639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zswve9h+bHX8YWfrXdD3Pg2yvfY2GXiIjZiSYIOdGgE=;
        b=Flmzlh+sqWjCNOWQoAlcGXDCgLVWJb9ZHwZ7RZYTVanloMWXejeltzDsM7lgX0xL7ITakF
        +lvJgiW07ysSL7ZZ3WXfV2GQuXShiF0WYfBwWfcA3JtD/hSXznMWTZPiTBH/OethE2cdx9
        utQNkWnz6SUEO204eivKMwQh/AeFTgw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-Kn1-SXN2POWDkQB5HA-OBA-1; Wed, 23 Feb 2022 08:40:37 -0500
X-MC-Unique: Kn1-SXN2POWDkQB5HA-OBA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0A5D1854E27
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:40:36 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 60944832B9
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:40:36 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 05E6D10C3106; Wed, 23 Feb 2022 08:40:36 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 5/8] NFS: readdir per-page cache validation
Date:   Wed, 23 Feb 2022 08:40:32 -0500
Message-Id: <c597a8ae5ea99de277b3f2e6486fe3bde1c5f64a.1645623510.git.bcodding@redhat.com>
In-Reply-To: <5479c8c5be9cf3f387edac54f170461f8f7b89e2.1645623510.git.bcodding@redhat.com>
References: <d759b6df8acd82b8d44e2afcf11a7a94dcf85ba6.1645623510.git.bcodding@redhat.com> <eedb07d14a96caef1de663a436a326b2c5012ab4.1645623510.git.bcodding@redhat.com> <aaedb2e378800a5cdb7071d65690b981274f2c22.1645623510.git.bcodding@redhat.com> <5479c8c5be9cf3f387edac54f170461f8f7b89e2.1645623510.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 fs/nfs/dir.c | 68 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 55 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 2b1a0c1cdce4..ba75a9593dae 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -219,7 +219,9 @@ static void nfs_readdir_page_init_array(struct page *page, u64 last_cookie)
 	array->last_cookie = last_cookie;
 	array->cookies_are_ordered = 1;
 	kunmap_atomic(array);
-	set_page_private(page, 0);
+	if (page->mapping)
+		set_page_private(page, nfs_save_change_attribute(page->mapping->host));
+	SetPageUptodate(page);
 }
 
 static int
@@ -256,6 +258,15 @@ void nfs_readdir_clear_array(struct page *page)
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
@@ -372,18 +383,47 @@ int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
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
@@ -429,8 +469,12 @@ static struct page *nfs_readdir_page_get_next(struct address_space *mapping,
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
@@ -984,9 +1028,7 @@ nfs_readdir_page_unlock_and_put_cached(struct nfs_readdir_descriptor *desc)
 static struct page *
 nfs_readdir_page_get_cached(struct nfs_readdir_descriptor *desc)
 {
-	return nfs_readdir_page_get_locked(desc->file->f_mapping,
-					   desc->pgc.page_index,
-					   desc->pgc.index_cookie);
+	return nfs_readdir_page_get_locked(desc->file->f_mapping, &desc->pgc);
 }
 
 #define NFS_READDIR_PAGE_FILL_MISS_MAX 5
-- 
2.31.1

