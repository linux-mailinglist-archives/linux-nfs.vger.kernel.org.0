Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D7F479324
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 18:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239945AbhLQRyh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 12:54:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49885 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239469AbhLQRyh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Dec 2021 12:54:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639763676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=pEHE4ikxqvUR43IkzjOxVJZdFBIJ0LMj1GJyxF0P2sE=;
        b=BTpCKivqxQSc4PBUN2Vi70cLa4xqfIQlWSHfaHYSPeDQPJDVyAkOBRredOM9sxXNxQfrwO
        fanklfrxZVV8TRZx3LFP381UhAS5qN7Mj6y584/8gsglqOJ7/yyRDcBNh6Bz0Ji0fhHFCR
        dTXjJ1JvOPI3o7NomAH7tvn967v41Kk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-iLRdMRwiMEyQYshQUev8nw-1; Fri, 17 Dec 2021 12:54:33 -0500
X-MC-Unique: iLRdMRwiMEyQYshQUev8nw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FE3594DC1;
        Fri, 17 Dec 2021 17:54:32 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 002371037F39;
        Fri, 17 Dec 2021 17:54:31 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: [PATCH v2 2/4] NFS: Rename fscache read and write pages functions
Date:   Fri, 17 Dec 2021 12:54:23 -0500
Message-Id: <1639763665-4917-3-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1639763665-4917-1-git-send-email-dwysocha@redhat.com>
References: <1639763665-4917-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Rename NFS fscache functions in a more consistent fashion
to better reflect when we read from and write to fscache.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/fscache.c |  6 +++---
 fs/nfs/fscache.h | 27 ++++++++++-----------------
 fs/nfs/read.c    |  4 ++--
 3 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 81bd2770e640..62fbce28fe85 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -317,7 +317,7 @@ static int fscache_fallback_write_page(struct inode *inode, struct page *page,
 /*
  * Retrieve a page from fscache
  */
-int __nfs_readpage_from_fscache(struct inode *inode, struct page *page)
+int __nfs_fscache_read_page(struct inode *inode, struct page *page)
 {
 	int ret;
 
@@ -351,7 +351,7 @@ int __nfs_readpage_from_fscache(struct inode *inode, struct page *page)
  * Store a newly fetched page in fscache.  We can be certain there's no page
  * stored in the cache as yet otherwise we would've read it from there.
  */
-void __nfs_readpage_to_fscache(struct inode *inode, struct page *page)
+void __nfs_fscache_write_page(struct inode *inode, struct page *page)
 {
 	int ret;
 
@@ -362,7 +362,7 @@ void __nfs_readpage_to_fscache(struct inode *inode, struct page *page)
 	ret = fscache_fallback_write_page(inode, page, true);
 
 	dfprintk(FSCACHE,
-		 "NFS:     readpage_to_fscache: p:%p(i:%lu f:%lx) ret %d\n",
+		 "NFS:     nfs_fscache_write_page: p:%p(i:%lu f:%lx) ret %d\n",
 		 page, page->index, page->flags, ret);
 
 	if (ret != 0) {
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 5cf7238e4886..ab7962ffe5f0 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -44,10 +44,8 @@ struct nfs_fscache_inode_auxdata {
 extern void nfs_fscache_open_file(struct inode *, struct file *);
 extern void nfs_fscache_release_file(struct inode *, struct file *);
 
-extern int __nfs_readpage_from_fscache(struct inode *, struct page *);
-extern void __nfs_read_completion_to_fscache(struct nfs_pgio_header *hdr,
-					     unsigned long bytes);
-extern void __nfs_readpage_to_fscache(struct inode *, struct page *);
+extern int __nfs_fscache_read_page(struct inode *, struct page *);
+extern void __nfs_fscache_write_page(struct inode *, struct page *);
 
 static inline int nfs_fscache_release_page(struct page *page, gfp_t gfp)
 {
@@ -65,11 +63,10 @@ static inline int nfs_fscache_release_page(struct page *page, gfp_t gfp)
 /*
  * Retrieve a page from an inode data storage object.
  */
-static inline int nfs_readpage_from_fscache(struct inode *inode,
-					    struct page *page)
+static inline int nfs_fscache_read_page(struct inode *inode, struct page *page)
 {
-	if (NFS_I(inode)->fscache)
-		return __nfs_readpage_from_fscache(inode, page);
+	if (nfs_i_fscache(inode))
+		return __nfs_fscache_read_page(inode, page);
 	return -ENOBUFS;
 }
 
@@ -77,11 +74,11 @@ static inline int nfs_readpage_from_fscache(struct inode *inode,
  * Store a page newly fetched from the server in an inode data storage object
  * in the cache.
  */
-static inline void nfs_readpage_to_fscache(struct inode *inode,
+static inline void nfs_fscache_write_page(struct inode *inode,
 					   struct page *page)
 {
-	if (NFS_I(inode)->fscache)
-		__nfs_readpage_to_fscache(inode, page);
+	if (nfs_i_fscache(inode))
+		__nfs_fscache_write_page(inode, page);
 }
 
 static inline void nfs_fscache_update_auxdata(struct nfs_fscache_inode_auxdata *auxdata,
@@ -135,15 +132,11 @@ static inline int nfs_fscache_release_page(struct page *page, gfp_t gfp)
 {
 	return 1; /* True: may release page */
 }
-static inline int nfs_readpage_from_fscache(struct inode *inode,
-					    struct page *page)
+static inline int nfs_fscache_read_page(struct inode *inode, struct page *page)
 {
 	return -ENOBUFS;
 }
-static inline void nfs_readpage_to_fscache(struct inode *inode,
-					   struct page *page) {}
-
-
+static inline void nfs_fscache_write_page(struct inode *inode, struct page *page) {}
 static inline void nfs_fscache_invalidate(struct inode *inode, int flags) {}
 
 static inline const char *nfs_server_fscache_state(struct nfs_server *server)
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index eb00229c1a50..f84b6b73c45b 100644
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

