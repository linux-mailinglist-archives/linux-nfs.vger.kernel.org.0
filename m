Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE8A3078E1
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jan 2021 16:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhA1O54 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jan 2021 09:57:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37699 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232116AbhA1O4p (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jan 2021 09:56:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611845718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=2P/rwSjNCoYd4avmdMx0l+RddiVM5l4pLZya+yBf2Mg=;
        b=Q7gI8MNlLGPl00VmBRiSO2R2a37eiXHDKogVYvkDI/CJscyPZIcguaOeG//v5XSviFYcMF
        hbY1sVEXODxYYb5bz/Y2UnfZFK36RgncewwaC9KAiORhN1PXxKuA5nax/BEO+OyMoHcV9I
        mitA0X9nlA5cP/UDIHpGXoFapJ9XwHc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-7Y4N65r2MF20EMgpM4Ru9w-1; Thu, 28 Jan 2021 09:55:16 -0500
X-MC-Unique: 7Y4N65r2MF20EMgpM4Ru9w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81803195D562;
        Thu, 28 Jan 2021 14:55:15 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-112-111.rdu2.redhat.com [10.10.112.111])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F07F179B3;
        Thu, 28 Jan 2021 14:55:15 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 10/10] NFS: update various invalidation code paths for new IO API
Date:   Thu, 28 Jan 2021 09:55:08 -0500
Message-Id: <1611845708-6752-11-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1611845708-6752-1-git-send-email-dwysocha@redhat.com>
References: <1611845708-6752-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The new fscache IO API removes the following invalidation related
older APIs: fscache_uncache_all_inode_pages, fscache_uncache_page,
and fscache_wait_on_page_write.  Update various code paths to the
new API which only requires we wait for PG_fscache which indicates
fscache IO in progress on the page.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/file.c    |  9 +++++----
 fs/nfs/fscache.c | 23 +----------------------
 fs/nfs/fscache.h | 28 +---------------------------
 3 files changed, 7 insertions(+), 53 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 9e41745c3faf..e81e11603b9a 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -416,7 +416,7 @@ static void nfs_invalidate_page(struct page *page, unsigned int offset,
 	/* Cancel any unstarted writes on this page */
 	nfs_wb_page_cancel(page_file_mapping(page)->host, page);
 
-	nfs_fscache_invalidate_page(page, page->mapping->host);
+	wait_on_page_fscache(page);
 }
 
 /*
@@ -482,12 +482,11 @@ static void nfs_check_dirty_writeback(struct page *page,
 static int nfs_launder_page(struct page *page)
 {
 	struct inode *inode = page_file_mapping(page)->host;
-	struct nfs_inode *nfsi = NFS_I(inode);
 
 	dfprintk(PAGECACHE, "NFS: launder_page(%ld, %llu)\n",
 		inode->i_ino, (long long)page_offset(page));
 
-	nfs_fscache_wait_on_page_write(nfsi, page);
+	wait_on_page_fscache(page);
 	return nfs_wb_page(inode, page);
 }
 
@@ -562,7 +561,9 @@ static vm_fault_t nfs_vm_page_mkwrite(struct vm_fault *vmf)
 	sb_start_pagefault(inode->i_sb);
 
 	/* make sure the cache has finished storing the page */
-	nfs_fscache_wait_on_page_write(NFS_I(inode), page);
+	if (PageFsCache(vmf->page) &&
+		wait_on_page_bit_killable(vmf->page, PG_fscache) < 0)
+		return VM_FAULT_RETRY;
 
 	wait_on_bit_action(&NFS_I(inode)->flags, NFS_INO_INVALIDATING,
 			nfs_wait_bit_killable, TASK_KILLABLE);
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index dd8cf3cfed0a..d18eeea9c1b5 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/iversion.h>
 #include <linux/xarray.h>
+#define FSCACHE_USE_NEW_IO_API
 #include <linux/fscache.h>
 #include <linux/netfs.h>
 
@@ -320,7 +321,6 @@ void nfs_fscache_open_file(struct inode *inode, struct file *filp)
 		dfprintk(FSCACHE, "NFS: nfsi 0x%p disabling cache\n", nfsi);
 		clear_bit(NFS_INO_FSCACHE, &nfsi->flags);
 		fscache_disable_cookie(cookie, &auxdata, true);
-		fscache_uncache_all_inode_pages(cookie, inode);
 	} else {
 		dfprintk(FSCACHE, "NFS: nfsi 0x%p enabling cache\n", nfsi);
 		fscache_enable_cookie(cookie, &auxdata, nfsi->vfs_inode.i_size,
@@ -331,27 +331,6 @@ void nfs_fscache_open_file(struct inode *inode, struct file *filp)
 }
 EXPORT_SYMBOL_GPL(nfs_fscache_open_file);
 
-/*
- * Release the caching state associated with a page if undergoing complete page
- * invalidation.
- */
-void __nfs_fscache_invalidate_page(struct page *page, struct inode *inode)
-{
-	struct fscache_cookie *cookie = nfs_i_fscache(inode);
-
-	BUG_ON(!cookie);
-
-	dfprintk(FSCACHE, "NFS: fscache invalidatepage (0x%p/0x%p/0x%p)\n",
-		 cookie, page, NFS_I(inode));
-
-	fscache_wait_on_page_write(cookie, page);
-
-	BUG_ON(!PageLocked(page));
-	fscache_uncache_page(cookie, page);
-	nfs_inc_fscache_stats(page->mapping->host,
-			      NFSIOS_FSCACHE_PAGES_UNCACHED);
-}
-
 static void nfs_issue_op(struct netfs_read_subrequest *subreq)
 {
 	struct inode *inode = subreq->rreq->inode;
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 9f8b1f8e69f3..f9d0464188af 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -11,6 +11,7 @@
 #include <linux/nfs_fs.h>
 #include <linux/nfs_mount.h>
 #include <linux/nfs4_mount.h>
+#define FSCACHE_USE_NEW_IO_API
 #include <linux/fscache.h>
 
 #ifdef CONFIG_NFS_FSCACHE
@@ -93,7 +94,6 @@ struct nfs_fscache_inode_auxdata {
 extern void nfs_fscache_clear_inode(struct inode *);
 extern void nfs_fscache_open_file(struct inode *, struct file *);
 
-extern void __nfs_fscache_invalidate_page(struct page *, struct inode *);
 extern int nfs_readpage_from_fscache(struct file *file,
 				     struct page *page,
 				     struct nfs_readdesc *desc);
@@ -102,27 +102,6 @@ extern int nfs_readahead_from_fscache(struct nfs_readdesc *desc,
 extern void nfs_read_completion_to_fscache(struct nfs_pgio_header *hdr,
 					   unsigned long bytes);
 /*
- * wait for a page to complete writing to the cache
- */
-static inline void nfs_fscache_wait_on_page_write(struct nfs_inode *nfsi,
-						  struct page *page)
-{
-	if (PageFsCache(page))
-		fscache_wait_on_page_write(nfsi->fscache, page);
-}
-
-/*
- * release the caching state associated with a page if undergoing complete page
- * invalidation
- */
-static inline void nfs_fscache_invalidate_page(struct page *page,
-					       struct inode *inode)
-{
-	if (PageFsCache(page))
-		__nfs_fscache_invalidate_page(page, inode);
-}
-
-/*
  * Invalidate the contents of fscache for this inode.  This will not sleep.
  */
 static inline void nfs_fscache_invalidate(struct inode *inode)
@@ -162,11 +141,6 @@ static inline void nfs_fscache_clear_inode(struct inode *inode) {}
 static inline void nfs_fscache_open_file(struct inode *inode,
 					 struct file *filp) {}
 
-static inline void nfs_fscache_invalidate_page(struct page *page,
-					       struct inode *inode) {}
-static inline void nfs_fscache_wait_on_page_write(struct nfs_inode *nfsi,
-						  struct page *page) {}
-
 static inline int nfs_readpage_from_fscache(struct file *file,
 					    struct page *page,
 					    struct nfs_readdesc *desc)
-- 
1.8.3.1

