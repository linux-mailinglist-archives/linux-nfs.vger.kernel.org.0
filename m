Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9203D22108E
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jul 2020 17:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbgGOPLz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jul 2020 11:11:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51132 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726332AbgGOPLy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jul 2020 11:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594825912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=buXyeDqhJk3lr2ZvPH0W6IIv0GhiX9VQVRcp4DWDrA4=;
        b=ek5pdtQVg9kPrmmCuvlk5Vlads2XEYOYZ7QITNxMojLebfbN57HQGYkR6/u9Qt/gyPYHiV
        QXmq1J5WWp4xSpd7GV8Hja0E0HH0P5EhBFBRGnw9lxMAnZZtt3/9xox3RaP1NXckIfzBhw
        oQll2fbX2QDJpjEwj+cjkS2Ro95gJH8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-81lF-cP7NoiILralwkQh1A-1; Wed, 15 Jul 2020 11:11:51 -0400
X-MC-Unique: 81lF-cP7NoiILralwkQh1A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2123F108A6ED;
        Wed, 15 Jul 2020 15:10:52 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-118-79.rdu2.redhat.com [10.10.118.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A8AC860C84;
        Wed, 15 Jul 2020 15:10:51 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: [RFC PATCH v1 01/13] NFS: Clean up nfs_readpage() and nfs_readpages()
Date:   Wed, 15 Jul 2020 11:10:37 -0400
Message-Id: <1594825849-24991-2-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1594825849-24991-1-git-send-email-dwysocha@redhat.com>
References: <1594825849-24991-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-nfs-owner@vger.kernel.org
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
index eb854f1f86e2..a05fb3904ddf 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -310,11 +310,11 @@ static void nfs_readpage_result(struct rpc_task *task,
  *  -	The error flag is set for this page. This happens only when a
  *	previous async read operation failed.
  */
-int nfs_readpage(struct file *file, struct page *page)
+int nfs_readpage(struct file *filp, struct page *page)
 {
 	struct nfs_open_context *ctx;
 	struct inode *inode = page_file_mapping(page)->host;
-	int		error;
+	int ret;
 
 	dprintk("NFS: nfs_readpage (%p %ld@%lu)\n",
 		page, PAGE_SIZE, page_index(page));
@@ -328,43 +328,43 @@ int nfs_readpage(struct file *file, struct page *page)
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
 
-	if (file == NULL) {
-		error = -EBADF;
+	if (filp == NULL) {
+		ret = -EBADF;
 		ctx = nfs_find_open_context(inode, NULL, FMODE_READ);
 		if (ctx == NULL)
 			goto out_unlock;
 	} else
-		ctx = get_nfs_open_context(nfs_file_open_context(file));
+		ctx = get_nfs_open_context(nfs_file_open_context(filp));
 
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
@@ -409,12 +409,10 @@ int nfs_readpages(struct file *filp, struct address_space *mapping,
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
@@ -422,13 +420,15 @@ int nfs_readpages(struct file *filp, struct address_space *mapping,
 			nr_pages);
 	nfs_inc_stats(inode, NFSIOS_VFSREADPAGES);
 
+	ret = -ESTALE;
 	if (NFS_STALE(inode))
 		goto out;
 
 	if (filp == NULL) {
+		ret = -EBADF;
 		desc.ctx = nfs_find_open_context(inode, NULL, FMODE_READ);
 		if (desc.ctx == NULL)
-			return -EBADF;
+			goto out;
 	} else
 		desc.ctx = get_nfs_open_context(nfs_file_open_context(filp));
 
@@ -440,6 +440,7 @@ int nfs_readpages(struct file *filp, struct address_space *mapping,
 	if (ret == 0)
 		goto read_complete; /* all pages were read */
 
+	desc.pgio = &pgio;
 	nfs_pageio_init_read(&pgio, inode, false,
 			     &nfs_async_read_completion_ops);
 
-- 
1.8.3.1

