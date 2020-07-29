Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1DD231FFD
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jul 2020 16:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgG2OMs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Jul 2020 10:12:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28373 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726476AbgG2OMr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Jul 2020 10:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596031966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=uQebwg5vaxrR5jpcB+PPEOO7rFTxGryVYKK6jYJh8VY=;
        b=Jo8VycElQS1o6LhRTcShf6T+zvvFZHQQ5pBXwwIuLs7sZ87Li5B6w/6UzQM3LAnVfHD3fQ
        A8E/Jj+703EIgXlv++N1VYqdkXOIpmUWhPOd1/edkJ+h8mTDGsnZMa058UOZqoGSdjskf9
        lfrkglZ+FCOOeYljZwYwvRD2JxG7dgA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-ThDuCV1tNci3k4h5SwFnPA-1; Wed, 29 Jul 2020 10:12:44 -0400
X-MC-Unique: ThDuCV1tNci3k4h5SwFnPA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 229D2800475;
        Wed, 29 Jul 2020 14:12:43 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-113-23.rdu2.redhat.com [10.10.113.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C4DC71906;
        Wed, 29 Jul 2020 14:12:42 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: [RFC PATCH v2 03/14] NFS: Refactor nfs_readpage() and nfs_readpage_async() to use nfs_readdesc
Date:   Wed, 29 Jul 2020 10:12:18 -0400
Message-Id: <1596031949-26793-4-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1596031949-26793-1-git-send-email-dwysocha@redhat.com>
References: <1596031949-26793-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Both nfs_readpage() and nfs_readpages() use similar code.
This patch should be no functional change, and refactors
nfs_readpage_async() to use nfs_readdesc to enable future
merging of nfs_readpage_async() and nfs_readpage_async_filler().

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/read.c          | 62 ++++++++++++++++++++++++--------------------------
 include/linux/nfs_fs.h |  3 +--
 2 files changed, 31 insertions(+), 34 deletions(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 1153c4e0a155..5fda30742a32 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -114,18 +114,23 @@ static void nfs_readpage_release(struct nfs_page *req, int error)
 	nfs_release_request(req);
 }
 
-int nfs_readpage_async(struct nfs_open_context *ctx, struct inode *inode,
+struct nfs_readdesc {
+	struct nfs_pageio_descriptor pgio;
+	struct nfs_open_context *ctx;
+};
+
+int nfs_readpage_async(void *data, struct inode *inode,
 		       struct page *page)
 {
+	struct nfs_readdesc *desc = (struct nfs_readdesc *)data;
 	struct nfs_page	*new;
 	unsigned int len;
-	struct nfs_pageio_descriptor pgio;
 	struct nfs_pgio_mirror *pgm;
 
 	len = nfs_page_length(page);
 	if (len == 0)
 		return nfs_return_empty_page(page);
-	new = nfs_create_request(ctx, page, 0, len);
+	new = nfs_create_request(desc->ctx, page, 0, len);
 	if (IS_ERR(new)) {
 		unlock_page(page);
 		return PTR_ERR(new);
@@ -133,21 +138,21 @@ int nfs_readpage_async(struct nfs_open_context *ctx, struct inode *inode,
 	if (len < PAGE_SIZE)
 		zero_user_segment(page, len, PAGE_SIZE);
 
-	nfs_pageio_init_read(&pgio, inode, false,
+	nfs_pageio_init_read(&desc->pgio, inode, false,
 			     &nfs_async_read_completion_ops);
-	if (!nfs_pageio_add_request(&pgio, new)) {
+	if (!nfs_pageio_add_request(&desc->pgio, new)) {
 		nfs_list_remove_request(new);
-		nfs_readpage_release(new, pgio.pg_error);
+		nfs_readpage_release(new, desc->pgio.pg_error);
 	}
-	nfs_pageio_complete(&pgio);
+	nfs_pageio_complete(&desc->pgio);
 
 	/* It doesn't make sense to do mirrored reads! */
-	WARN_ON_ONCE(pgio.pg_mirror_count != 1);
+	WARN_ON_ONCE(desc->pgio.pg_mirror_count != 1);
 
-	pgm = &pgio.pg_mirrors[0];
+	pgm = &desc->pgio.pg_mirrors[0];
 	NFS_I(inode)->read_io += pgm->pg_bytes_written;
 
-	return pgio.pg_error < 0 ? pgio.pg_error : 0;
+	return desc->pgio.pg_error < 0 ? desc->pgio.pg_error : 0;
 }
 
 static void nfs_page_group_set_uptodate(struct nfs_page *req)
@@ -312,7 +317,7 @@ static void nfs_readpage_result(struct rpc_task *task,
  */
 int nfs_readpage(struct file *filp, struct page *page)
 {
-	struct nfs_open_context *ctx;
+	struct nfs_readdesc desc;
 	struct inode *inode = page_file_mapping(page)->host;
 	int ret;
 
@@ -339,39 +344,34 @@ int nfs_readpage(struct file *filp, struct page *page)
 
 	if (filp == NULL) {
 		ret = -EBADF;
-		ctx = nfs_find_open_context(inode, NULL, FMODE_READ);
-		if (ctx == NULL)
+		desc.ctx = nfs_find_open_context(inode, NULL, FMODE_READ);
+		if (desc.ctx == NULL)
 			goto out_unlock;
 	} else
-		ctx = get_nfs_open_context(nfs_file_open_context(filp));
+		desc.ctx = get_nfs_open_context(nfs_file_open_context(filp));
 
 	if (!IS_SYNC(inode)) {
-		ret = nfs_readpage_from_fscache(ctx, inode, page);
+		ret = nfs_readpage_from_fscache(desc.ctx, inode, page);
 		if (ret == 0)
 			goto out;
 	}
 
-	xchg(&ctx->error, 0);
-	ret = nfs_readpage_async(ctx, inode, page);
+	xchg(&desc.ctx->error, 0);
+	ret = nfs_readpage_async(&desc, inode, page);
 	if (!ret) {
 		ret = wait_on_page_locked_killable(page);
 		if (!PageUptodate(page) && !ret)
-			ret = xchg(&ctx->error, 0);
+			ret = xchg(&desc.ctx->error, 0);
 	}
 	nfs_add_stats(inode, NFSIOS_READPAGES, 1);
 out:
-	put_nfs_open_context(ctx);
+	put_nfs_open_context(desc.ctx);
 	return ret;
 out_unlock:
 	unlock_page(page);
 	return ret;
 }
 
-struct nfs_readdesc {
-	struct nfs_pageio_descriptor *pgio;
-	struct nfs_open_context *ctx;
-};
-
 static int
 readpage_async_filler(void *data, struct page *page)
 {
@@ -390,9 +390,9 @@ struct nfs_readdesc {
 
 	if (len < PAGE_SIZE)
 		zero_user_segment(page, len, PAGE_SIZE);
-	if (!nfs_pageio_add_request(desc->pgio, new)) {
+	if (!nfs_pageio_add_request(&desc->pgio, new)) {
 		nfs_list_remove_request(new);
-		error = desc->pgio->pg_error;
+		error = desc->pgio.pg_error;
 		nfs_readpage_release(new, error);
 		goto out;
 	}
@@ -407,7 +407,6 @@ struct nfs_readdesc {
 int nfs_readpages(struct file *filp, struct address_space *mapping,
 		struct list_head *pages, unsigned nr_pages)
 {
-	struct nfs_pageio_descriptor pgio;
 	struct nfs_pgio_mirror *pgm;
 	struct nfs_readdesc desc;
 	struct inode *inode = mapping->host;
@@ -440,17 +439,16 @@ int nfs_readpages(struct file *filp, struct address_space *mapping,
 	if (ret == 0)
 		goto read_complete; /* all pages were read */
 
-	desc.pgio = &pgio;
-	nfs_pageio_init_read(&pgio, inode, false,
+	nfs_pageio_init_read(&desc.pgio, inode, false,
 			     &nfs_async_read_completion_ops);
 
 	ret = read_cache_pages(mapping, pages, readpage_async_filler, &desc);
-	nfs_pageio_complete(&pgio);
+	nfs_pageio_complete(&desc.pgio);
 
 	/* It doesn't make sense to do mirrored reads! */
-	WARN_ON_ONCE(pgio.pg_mirror_count != 1);
+	WARN_ON_ONCE(desc.pgio.pg_mirror_count != 1);
 
-	pgm = &pgio.pg_mirrors[0];
+	pgm = &desc.pgio.pg_mirrors[0];
 	NFS_I(inode)->read_io += pgm->pg_bytes_written;
 	npages = (pgm->pg_bytes_written + PAGE_SIZE - 1) >>
 		 PAGE_SHIFT;
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 6ee9119acc5d..7e5b9df9cfe6 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -553,8 +553,7 @@ extern int nfs_instantiate(struct dentry *dentry, struct nfs_fh *fh,
 extern int  nfs_readpage(struct file *, struct page *);
 extern int  nfs_readpages(struct file *, struct address_space *,
 		struct list_head *, unsigned);
-extern int  nfs_readpage_async(struct nfs_open_context *, struct inode *,
-			       struct page *);
+extern int  nfs_readpage_async(void *, struct inode *, struct page *);
 
 /*
  * inline functions
-- 
1.8.3.1

