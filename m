Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145F2425FED
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Oct 2021 00:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241270AbhJGWcv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Oct 2021 18:32:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34919 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240809AbhJGWcu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Oct 2021 18:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633645855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=MEo8GUP9+zCWYYHUjC1q3ticNz8MZfaRuvNyfJRbAus=;
        b=D+LaIg2RppWGjCZev+VsL+6TOzXADPjMrGa+VLtqdynIiPZD3q3bmV790BE59CZxrdRI0Y
        VTvj2dD/B4L7rMTg0kLZ9UgKFS2DqVcoQzkjBxeBURTkzXZDC5p2O/67gO7Wnrhg9XBjHb
        QxAXJCmzOHNgeGyrtLgVq4/I3LyEBVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-ZrcSbyJ3M8ydpVnvJTEJEA-1; Thu, 07 Oct 2021 18:30:47 -0400
X-MC-Unique: ZrcSbyJ3M8ydpVnvJTEJEA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC8F5801AA7;
        Thu,  7 Oct 2021 22:30:46 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.139])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A4195D9C6;
        Thu,  7 Oct 2021 22:30:46 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-nfs@vger.kernel.org
Subject: [PATCH v2  4/7] NFS: Rename fscache read and write pages functions
Date:   Thu,  7 Oct 2021 18:30:20 -0400
Message-Id: <1633645823-31235-5-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1633645823-31235-1-git-send-email-dwysocha@redhat.com>
References: <1633645823-31235-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Rename NFS fscache functions to read from and write to the cache
to better reflect the new fscache fallback API naming.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/fscache.c |  4 ++--
 fs/nfs/fscache.h | 17 ++++++++---------
 fs/nfs/read.c    |  4 ++--
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 5f9be4a1b5f8..50d68cb946c8 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -331,7 +331,7 @@ void nfs_fscache_open_file(struct inode *inode, struct file *filp)
 /*
  * Retrieve a page from fscache
  */
-int __nfs_readpage_from_fscache(struct inode *inode, struct page *page)
+int __nfs_fscache_read_page(struct inode *inode, struct page *page)
 {
 	int ret;
 
@@ -364,7 +364,7 @@ int __nfs_readpage_from_fscache(struct inode *inode, struct page *page)
 /*
  * Store a newly fetched page in fscache
  */
-void __nfs_readpage_to_fscache(struct inode *inode, struct page *page)
+void __nfs_fscache_write_page(struct inode *inode, struct page *page)
 {
 	int ret;
 
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index f4deea2908e9..a2c669ce8217 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -94,19 +94,18 @@ struct nfs_fscache_inode_auxdata {
 extern void nfs_fscache_clear_inode(struct inode *);
 extern void nfs_fscache_open_file(struct inode *, struct file *);
 
-extern int __nfs_readpage_from_fscache(struct inode *, struct page *);
+extern int __nfs_fscache_read_page(struct inode *, struct page *);
 extern void __nfs_read_completion_to_fscache(struct nfs_pgio_header *hdr,
 					     unsigned long bytes);
-extern void __nfs_readpage_to_fscache(struct inode *, struct page *);
+extern void __nfs_fscache_write_page(struct inode *, struct page *);
 
 /*
  * Retrieve a page from an inode data storage object.
  */
-static inline int nfs_readpage_from_fscache(struct inode *inode,
-					    struct page *page)
+static inline int nfs_fscache_read_page(struct inode *inode, struct page *page)
 {
 	if (nfs_i_fscache(inode))
-		return __nfs_readpage_from_fscache(inode, page);
+		return __nfs_fscache_read_page(inode, page);
 	return -ENOBUFS;
 }
 
@@ -114,11 +113,11 @@ static inline int nfs_readpage_from_fscache(struct inode *inode,
  * Store a page newly fetched from the server in an inode data storage object
  * in the cache.
  */
-static inline void nfs_readpage_to_fscache(struct inode *inode,
+static inline void nfs_fscache_write_page(struct inode *inode,
 					   struct page *page)
 {
 	if (nfs_i_fscache(inode))
-		__nfs_readpage_to_fscache(inode, page);
+		__nfs_fscache_write_page(inode, page);
 }
 
 /*
@@ -161,12 +160,12 @@ static inline void nfs_fscache_clear_inode(struct inode *inode) {}
 static inline void nfs_fscache_open_file(struct inode *inode,
 					 struct file *filp) {}
 
-static inline int nfs_readpage_from_fscache(struct inode *inode,
+static inline int nfs_fscache_read_page(struct inode *inode,
 					    struct page *page)
 {
 	return -ENOBUFS;
 }
-static inline void nfs_readpage_to_fscache(struct inode *inode,
+static inline void nfs_fscache_write_page(struct inode *inode,
 					   struct page *page) {}
 
 
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 06ed827a67e8..c65663f217a4 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -123,7 +123,7 @@ static void nfs_readpage_release(struct nfs_page *req, int error)
 		struct address_space *mapping = page_file_mapping(page);
 
 		if (PageUptodate(page))
-			nfs_readpage_to_fscache(inode, page);
+			nfs_fscache_write_page(inode, page);
 		else if (!PageError(page) && !PagePrivate(page))
 			generic_error_remove_page(mapping, page);
 		unlock_page(page);
@@ -306,7 +306,7 @@ static void nfs_readpage_result(struct rpc_task *task,
 	aligned_len = min_t(unsigned int, ALIGN(len, rsize), PAGE_SIZE);
 
 	if (!IS_SYNC(page->mapping->host)) {
-		error = nfs_readpage_from_fscache(page->mapping->host, page);
+		error = nfs_fscache_read_page(page->mapping->host, page);
 		if (error == 0)
 			goto out_unlock;
 	}
-- 
1.8.3.1

