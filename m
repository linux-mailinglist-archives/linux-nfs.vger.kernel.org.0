Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B54D3078E3
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jan 2021 16:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhA1O6C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jan 2021 09:58:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21347 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232134AbhA1O4q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jan 2021 09:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611845719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=BMhrW6GJykdISJQaY56THPUPrEYogzbrxwncoRyUcIo=;
        b=IpIYOTuZ/v9g2DTqxDtzJ0XCJj5OEKRKxio/x4LD/0XX9+r4nSCr07q6AUN4hFM0X/xqUN
        kau2ua/gmgb9Y+39QMvRTyOVyYqPeE0cZhUjnX4NiO3x9lgRC+1JneZnzyWB8x6/XaS8PD
        9Sc/MK1V3iHv1ujXHbf8tCu4e9W8gYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-ggNabo8_Mmu2BmEpNgOkQg-1; Thu, 28 Jan 2021 09:55:16 -0500
X-MC-Unique: ggNabo8_Mmu2BmEpNgOkQg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F147D59;
        Thu, 28 Jan 2021 14:55:14 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-112-111.rdu2.redhat.com [10.10.112.111])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F417179B3;
        Thu, 28 Jan 2021 14:55:14 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 09/10] NFS: Update releasepage to handle new fscache kiocb IO API
Date:   Thu, 28 Jan 2021 09:55:07 -0500
Message-Id: <1611845708-6752-10-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1611845708-6752-1-git-send-email-dwysocha@redhat.com>
References: <1611845708-6752-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When using the new fscache kiocb IO API, netfs callers should
no longer use fscache_maybe_release_page() in releasepage, but
instead should just wait PG_fscache as needed.  The PG_fscache
page bit now means the page is being written to the cache.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/file.c    | 11 +++++++++--
 fs/nfs/fscache.c | 24 ------------------------
 fs/nfs/fscache.h |  5 -----
 fs/nfs/write.c   | 10 ++++------
 4 files changed, 13 insertions(+), 37 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index ebcaa164db5f..9e41745c3faf 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -431,8 +431,15 @@ static int nfs_release_page(struct page *page, gfp_t gfp)
 
 	/* If PagePrivate() is set, then the page is not freeable */
 	if (PagePrivate(page))
-		return 0;
-	return nfs_fscache_release_page(page, gfp);
+		return false;
+
+	if (PageFsCache(page)) {
+		if (!(gfp & __GFP_DIRECT_RECLAIM) || !(gfp & __GFP_FS))
+			return false;
+		wait_on_page_fscache(page);
+	}
+
+	return true;
 }
 
 static void nfs_check_dirty_writeback(struct page *page,
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 2ff631da62ec..dd8cf3cfed0a 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -332,30 +332,6 @@ void nfs_fscache_open_file(struct inode *inode, struct file *filp)
 EXPORT_SYMBOL_GPL(nfs_fscache_open_file);
 
 /*
- * Release the caching state associated with a page, if the page isn't busy
- * interacting with the cache.
- * - Returns true (can release page) or false (page busy).
- */
-int nfs_fscache_release_page(struct page *page, gfp_t gfp)
-{
-	if (PageFsCache(page)) {
-		struct fscache_cookie *cookie = nfs_i_fscache(page->mapping->host);
-
-		BUG_ON(!cookie);
-		dfprintk(FSCACHE, "NFS: fscache releasepage (0x%p/0x%p/0x%p)\n",
-			 cookie, page, NFS_I(page->mapping->host));
-
-		if (!fscache_maybe_release_page(cookie, page, gfp))
-			return 0;
-
-		nfs_inc_fscache_stats(page->mapping->host,
-				      NFSIOS_FSCACHE_PAGES_UNCACHED);
-	}
-
-	return 1;
-}
-
-/*
  * Release the caching state associated with a page if undergoing complete page
  * invalidation.
  */
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index faccf4549d55..9f8b1f8e69f3 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -94,7 +94,6 @@ struct nfs_fscache_inode_auxdata {
 extern void nfs_fscache_open_file(struct inode *, struct file *);
 
 extern void __nfs_fscache_invalidate_page(struct page *, struct inode *);
-extern int nfs_fscache_release_page(struct page *, gfp_t);
 extern int nfs_readpage_from_fscache(struct file *file,
 				     struct page *page,
 				     struct nfs_readdesc *desc);
@@ -163,10 +162,6 @@ static inline void nfs_fscache_clear_inode(struct inode *inode) {}
 static inline void nfs_fscache_open_file(struct inode *inode,
 					 struct file *filp) {}
 
-static inline int nfs_fscache_release_page(struct page *page, gfp_t gfp)
-{
-	return 1; /* True: may release page */
-}
 static inline void nfs_fscache_invalidate_page(struct page *page,
 					       struct inode *inode) {}
 static inline void nfs_fscache_wait_on_page_write(struct nfs_inode *nfsi,
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 639c34fec04a..156508fb6730 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -2102,17 +2102,15 @@ int nfs_migrate_page(struct address_space *mapping, struct page *newpage,
 		struct page *page, enum migrate_mode mode)
 {
 	/*
-	 * If PagePrivate is set, then the page is currently associated with
-	 * an in-progress read or write request. Don't try to migrate it.
+	 * If PagePrivate or PageFsCache is set, then the page is currently
+	 * associated with an in-progress read or write request.  Don't try
+	 * to migrate it.
 	 *
 	 * FIXME: we could do this in principle, but we'll need a way to ensure
 	 *        that we can safely release the inode reference while holding
 	 *        the page lock.
 	 */
-	if (PagePrivate(page))
-		return -EBUSY;
-
-	if (!nfs_fscache_release_page(page, GFP_KERNEL))
+	if (PagePrivate(page) || PageFsCache(page))
 		return -EBUSY;
 
 	return migrate_page(mapping, newpage, page, mode);
-- 
1.8.3.1

