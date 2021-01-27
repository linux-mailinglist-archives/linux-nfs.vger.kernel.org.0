Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C9E30554A
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jan 2021 09:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhA0IJT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jan 2021 03:09:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37252 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234435AbhA0IE6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jan 2021 03:04:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611734611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=C7JSaegbH3sjrXxobnyvZOPnCDkpgSHCAZrjn1vGB3A=;
        b=F3gUOVQO3zUoBE2uxIhsslpTvOnt9DJRAE2SXUtCcEGeYnPf0upsV5msz3SwiQ3KyRZc2e
        ljKQYz91ICMBfCAU59nlUF6jewc3Gxp8C1PiPJ5A5u9Hf7E7SNdsFUYJT/XE3Q02nPLBZQ
        H1jRd71TCFSUFFtkgtndF5xzrgnJS/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-WyjPaEqWOke9YcV3yt6sbA-1; Wed, 27 Jan 2021 03:03:29 -0500
X-MC-Unique: WyjPaEqWOke9YcV3yt6sbA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B445C801AB8;
        Wed, 27 Jan 2021 08:03:28 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-112-111.rdu2.redhat.com [10.10.112.111])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B8D26F92F;
        Wed, 27 Jan 2021 08:03:28 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/8] NFS: Clean up nfs_readpage() and nfs_readpages()
Date:   Wed, 27 Jan 2021 03:03:10 -0500
Message-Id: <1611734597-14754-2-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In prep for the new fscache netfs API, refactor nfs_readpage()
and nfs_readpages() for future patches.  No functional change.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/read.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index eb854f1f86e2..dd92156e27c5 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -314,7 +314,7 @@ int nfs_readpage(struct file *file, struct page *page)
 {
 	struct nfs_open_context *ctx;
 	struct inode *inode = page_file_mapping(page)->host;
-	int		error;
+	int ret;
 
 	dprintk("NFS: nfs_readpage (%p %ld@%lu)\n",
 		page, PAGE_SIZE, page_index(page));
@@ -328,18 +328,18 @@ int nfs_readpage(struct file *file, struct page *page)
 	 * be any new pending writes generated at this point
 	 * for this page (other pages can be written to).
 	 */
-	error = nfs_wb_page(inode, page);
-	if (error)
+	ret = nfs_wb_page(inode, page);
+	if (ret)
 		goto out_unlock;
 	if (PageUptodate(page))
 		goto out_unlock;
 
-	error = -ESTALE;
+	ret = -ESTALE;
 	if (NFS_STALE(inode))
 		goto out_unlock;
 
 	if (file == NULL) {
-		error = -EBADF;
+		ret = -EBADF;
 		ctx = nfs_find_open_context(inode, NULL, FMODE_READ);
 		if (ctx == NULL)
 			goto out_unlock;
@@ -347,24 +347,24 @@ int nfs_readpage(struct file *file, struct page *page)
 		ctx = get_nfs_open_context(nfs_file_open_context(file));
 
 	if (!IS_SYNC(inode)) {
-		error = nfs_readpage_from_fscache(ctx, inode, page);
-		if (error == 0)
+		ret = nfs_readpage_from_fscache(ctx, inode, page);
+		if (ret == 0)
 			goto out;
 	}
 
 	xchg(&ctx->error, 0);
-	error = nfs_readpage_async(ctx, inode, page);
-	if (!error) {
-		error = wait_on_page_locked_killable(page);
-		if (!PageUptodate(page) && !error)
-			error = xchg(&ctx->error, 0);
+	ret = nfs_readpage_async(ctx, inode, page);
+	if (!ret) {
+		ret = wait_on_page_locked_killable(page);
+		if (!PageUptodate(page) && !ret)
+			ret = xchg(&ctx->error, 0);
 	}
 out:
 	put_nfs_open_context(ctx);
-	return error;
+	return ret;
 out_unlock:
 	unlock_page(page);
-	return error;
+	return ret;
 }
 
 struct nfs_readdesc {
@@ -404,17 +404,15 @@ struct nfs_readdesc {
 	return error;
 }
 
-int nfs_readpages(struct file *filp, struct address_space *mapping,
+int nfs_readpages(struct file *file, struct address_space *mapping,
 		struct list_head *pages, unsigned nr_pages)
 {
 	struct nfs_pageio_descriptor pgio;
 	struct nfs_pgio_mirror *pgm;
-	struct nfs_readdesc desc = {
-		.pgio = &pgio,
-	};
+	struct nfs_readdesc desc;
 	struct inode *inode = mapping->host;
 	unsigned long npages;
-	int ret = -ESTALE;
+	int ret;
 
 	dprintk("NFS: nfs_readpages (%s/%Lu %d)\n",
 			inode->i_sb->s_id,
@@ -422,15 +420,17 @@ int nfs_readpages(struct file *filp, struct address_space *mapping,
 			nr_pages);
 	nfs_inc_stats(inode, NFSIOS_VFSREADPAGES);
 
+	ret = -ESTALE;
 	if (NFS_STALE(inode))
 		goto out;
 
-	if (filp == NULL) {
+	if (file == NULL) {
+		ret = -EBADF;
 		desc.ctx = nfs_find_open_context(inode, NULL, FMODE_READ);
 		if (desc.ctx == NULL)
-			return -EBADF;
+			goto out;
 	} else
-		desc.ctx = get_nfs_open_context(nfs_file_open_context(filp));
+		desc.ctx = get_nfs_open_context(nfs_file_open_context(file));
 
 	/* attempt to read as many of the pages as possible from the cache
 	 * - this returns -ENOBUFS immediately if the cookie is negative
@@ -440,6 +440,7 @@ int nfs_readpages(struct file *filp, struct address_space *mapping,
 	if (ret == 0)
 		goto read_complete; /* all pages were read */
 
+	desc.pgio = &pgio;
 	nfs_pageio_init_read(&pgio, inode, false,
 			     &nfs_async_read_completion_ops);
 
-- 
1.8.3.1

