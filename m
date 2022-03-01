Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2E54C9476
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Mar 2022 20:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbiCATjT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Mar 2022 14:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237000AbiCATjT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Mar 2022 14:39:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5E5965788
        for <linux-nfs@vger.kernel.org>; Tue,  1 Mar 2022 11:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646163517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9lB9EWWYFT1wEN+KAIdnZdcfS9M43ml3k+kfsW2gq8=;
        b=C47Pl978d0iEmz/Ert45qyGwlA4McF8SwwGlZr2Oa4oM+0DgbOBuaQLTkh/ViICpbgtBZ5
        rWgp94TDM2KnWmuZ+YolnZXhIxNRLssU6RKdPu5FJv8Bq5zYz6EpYwawvHhMYFFDF8mMKC
        NQ9R9lht4KQ7XPDSst8C8UD/F8fkFJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55-IEWoewYzPFer3aoA6vrlPw-1; Tue, 01 Mar 2022 14:38:34 -0500
X-MC-Unique: IEWoewYzPFer3aoA6vrlPw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D94EF1006AA5;
        Tue,  1 Mar 2022 19:38:32 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.9.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D446F5DF37;
        Tue,  1 Mar 2022 19:38:31 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        David Howells <dhowells@redhat.com>
Subject: [PATCH 2/4] NFS: Rename fscache read and write pages functions
Date:   Tue,  1 Mar 2022 14:37:25 -0500
Message-Id: <20220301193727.18847-3-dwysocha@redhat.com>
In-Reply-To: <20220301193727.18847-1-dwysocha@redhat.com>
References: <20220301193727.18847-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 4c7afaabbf9f..4e980cc04779 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -45,10 +45,8 @@ extern void nfs_fscache_clear_inode(struct inode *);
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
@@ -66,11 +64,10 @@ static inline int nfs_fscache_release_page(struct page *page, gfp_t gfp)
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
 
@@ -78,11 +75,11 @@ static inline int nfs_readpage_from_fscache(struct inode *inode,
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
@@ -136,15 +133,11 @@ static inline int nfs_fscache_release_page(struct page *page, gfp_t gfp)
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
@@ -306,7 +306,7 @@ readpage_async_filler(void *data, struct page *page)
 	aligned_len = min_t(unsigned int, ALIGN(len, rsize), PAGE_SIZE);
 
 	if (!IS_SYNC(page->mapping->host)) {
-		error = nfs_readpage_from_fscache(page->mapping->host, page);
+		error = nfs_fscache_read_page(page->mapping->host, page);
 		if (error == 0)
 			goto out_unlock;
 	}
-- 
2.27.1

