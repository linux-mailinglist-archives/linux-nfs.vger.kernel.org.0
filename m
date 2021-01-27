Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B5C305547
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jan 2021 09:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbhA0IJE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jan 2021 03:09:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46821 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234469AbhA0IFA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jan 2021 03:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611734614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=GqegtzEauQ47jneuF47CwVXnjZkhNfAS1QyCvi9fBjk=;
        b=Lu8+so5GzeDmjIyQytt8JdwzOSvL4duoLiD7GPSmiTafBbd2qkMlVBGT2DW6PaMlTcx8LU
        3mSm/Tdg7QjS9FJLtT/I2mH4mtABruRK54Ab4zmESCQRUETG5xk2rvGoWoz5Uvwxua5qJw
        03I4bCYVSpv3fRatZWCVB1dj+yMxBlc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-xcHvINrzPVK-g-V7BNUw-Q-1; Wed, 27 Jan 2021 03:03:32 -0500
X-MC-Unique: xcHvINrzPVK-g-V7BNUw-Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A1A7180A093;
        Wed, 27 Jan 2021 08:03:31 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-112-111.rdu2.redhat.com [10.10.112.111])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CD0901F0;
        Wed, 27 Jan 2021 08:03:30 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 5/8] NFS: Add nfs_pageio_complete_read() and remove nfs_readpage_async()
Date:   Wed, 27 Jan 2021 03:03:14 -0500
Message-Id: <1611734597-14754-6-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1611734597-14754-2-git-send-email-dwysocha@redhat.com>
References: <1611734597-14754-2-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add nfs_pageio_complete_read() and call this from both nfs_readpage()
and nfs_readpages(), since the submission and accounting is the same
for both functions.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/fscache.c       |   4 --
 fs/nfs/read.c          | 137 ++++++++++++++++++++++---------------------------
 include/linux/nfs_fs.h |   1 -
 3 files changed, 61 insertions(+), 81 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index a60df88efc40..c4c021c6ebbd 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -390,10 +390,6 @@ static void nfs_readpage_from_fscache_complete(struct page *page,
 	if (!error) {
 		SetPageUptodate(page);
 		unlock_page(page);
-	} else {
-		error = nfs_readpage_async(context, page->mapping->host, page);
-		if (error)
-			unlock_page(page);
 	}
 }
 
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 0ed79e6bc486..d2b6dce1f99f 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -74,6 +74,24 @@ void nfs_pageio_init_read(struct nfs_pageio_descriptor *pgio,
 }
 EXPORT_SYMBOL_GPL(nfs_pageio_init_read);
 
+static void nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio,
+				     struct inode *inode)
+{
+	struct nfs_pgio_mirror *pgm;
+	unsigned long npages;
+
+	nfs_pageio_complete(pgio);
+
+	/* It doesn't make sense to do mirrored reads! */
+	WARN_ON_ONCE(pgio->pg_mirror_count != 1);
+
+	pgm = &pgio->pg_mirrors[0];
+	NFS_I(inode)->read_io += pgm->pg_bytes_written;
+	npages = (pgm->pg_bytes_written + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	nfs_add_stats(inode, NFSIOS_READPAGES, npages);
+}
+
+
 void nfs_pageio_reset_read_mds(struct nfs_pageio_descriptor *pgio)
 {
 	struct nfs_pgio_mirror *mirror;
@@ -119,36 +137,6 @@ struct nfs_readdesc {
 	struct nfs_open_context *ctx;
 };
 
-static int readpage_async_filler(void *data, struct page *page);
-
-int nfs_readpage_async(void *data, struct inode *inode,
-		       struct page *page)
-{
-	struct nfs_readdesc *desc = data;
-	struct nfs_pgio_mirror *pgm;
-	int error;
-
-	nfs_pageio_init_read(&desc->pgio, inode, false,
-			     &nfs_async_read_completion_ops);
-
-	error = readpage_async_filler(desc, page);
-	if (error)
-		goto out;
-
-	nfs_pageio_complete(&desc->pgio);
-
-	/* It doesn't make sense to do mirrored reads! */
-	WARN_ON_ONCE(desc->pgio.pg_mirror_count != 1);
-
-	pgm = &desc->pgio.pg_mirrors[0];
-	NFS_I(inode)->read_io += pgm->pg_bytes_written;
-
-	return desc->pgio.pg_error < 0 ? desc->pgio.pg_error : 0;
-
-out:
-	return error;
-}
-
 static void nfs_page_group_set_uptodate(struct nfs_page *req)
 {
 	if (nfs_page_group_sync_on_bit(req, PG_UPTODATE))
@@ -170,8 +158,7 @@ static void nfs_read_completion(struct nfs_pgio_header *hdr)
 
 		if (test_bit(NFS_IOHDR_EOF, &hdr->flags)) {
 			/* note: regions of the page not covered by a
-			 * request are zeroed in nfs_readpage_async /
-			 * readpage_async_filler */
+			 * request are zeroed in readpage_async_filler */
 			if (bytes > hdr->good_bytes) {
 				/* nothing in this request was good, so zero
 				 * the full extent of the request */
@@ -303,6 +290,38 @@ static void nfs_readpage_result(struct rpc_task *task,
 		nfs_readpage_retry(task, hdr);
 }
 
+static int
+readpage_async_filler(void *data, struct page *page)
+{
+	struct nfs_readdesc *desc = data;
+	struct nfs_page *new;
+	unsigned int len;
+	int error;
+
+	len = nfs_page_length(page);
+	if (len == 0)
+		return nfs_return_empty_page(page);
+
+	new = nfs_create_request(desc->ctx, page, 0, len);
+	if (IS_ERR(new))
+		goto out_error;
+
+	if (len < PAGE_SIZE)
+		zero_user_segment(page, len, PAGE_SIZE);
+	if (!nfs_pageio_add_request(&desc->pgio, new)) {
+		nfs_list_remove_request(new);
+		error = desc->pgio.pg_error;
+		nfs_readpage_release(new, error);
+		goto out;
+	}
+	return 0;
+out_error:
+	error = PTR_ERR(new);
+	unlock_page(page);
+out:
+	return error;
+}
+
 /*
  * Read a page over NFS.
  * We read the page synchronously in the following case:
@@ -351,13 +370,20 @@ int nfs_readpage(struct file *file, struct page *page)
 	}
 
 	xchg(&desc.ctx->error, 0);
-	ret = nfs_readpage_async(&desc, inode, page);
+	nfs_pageio_init_read(&desc.pgio, inode, false,
+			     &nfs_async_read_completion_ops);
+
+	ret = readpage_async_filler(&desc, page);
+
+	if (!ret)
+		nfs_pageio_complete_read(&desc.pgio, inode);
+
+	ret = desc.pgio.pg_error < 0 ? desc.pgio.pg_error : 0;
 	if (!ret) {
 		ret = wait_on_page_locked_killable(page);
 		if (!PageUptodate(page) && !ret)
 			ret = xchg(&desc.ctx->error, 0);
 	}
-	nfs_add_stats(inode, NFSIOS_READPAGES, 1);
 out:
 	put_nfs_open_context(desc.ctx);
 	return ret;
@@ -366,45 +392,11 @@ int nfs_readpage(struct file *file, struct page *page)
 	return ret;
 }
 
-static int
-readpage_async_filler(void *data, struct page *page)
-{
-	struct nfs_readdesc *desc = (struct nfs_readdesc *)data;
-	struct nfs_page *new;
-	unsigned int len;
-	int error;
-
-	len = nfs_page_length(page);
-	if (len == 0)
-		return nfs_return_empty_page(page);
-
-	new = nfs_create_request(desc->ctx, page, 0, len);
-	if (IS_ERR(new))
-		goto out_error;
-
-	if (len < PAGE_SIZE)
-		zero_user_segment(page, len, PAGE_SIZE);
-	if (!nfs_pageio_add_request(&desc->pgio, new)) {
-		nfs_list_remove_request(new);
-		error = desc->pgio.pg_error;
-		nfs_readpage_release(new, error);
-		goto out;
-	}
-	return 0;
-out_error:
-	error = PTR_ERR(new);
-	unlock_page(page);
-out:
-	return error;
-}
-
 int nfs_readpages(struct file *file, struct address_space *mapping,
 		struct list_head *pages, unsigned nr_pages)
 {
-	struct nfs_pgio_mirror *pgm;
 	struct nfs_readdesc desc;
 	struct inode *inode = mapping->host;
-	unsigned long npages;
 	int ret;
 
 	dprintk("NFS: nfs_readpages (%s/%Lu %d)\n",
@@ -437,16 +429,9 @@ int nfs_readpages(struct file *file, struct address_space *mapping,
 			     &nfs_async_read_completion_ops);
 
 	ret = read_cache_pages(mapping, pages, readpage_async_filler, &desc);
-	nfs_pageio_complete(&desc.pgio);
 
-	/* It doesn't make sense to do mirrored reads! */
-	WARN_ON_ONCE(desc.pgio.pg_mirror_count != 1);
+	nfs_pageio_complete_read(&desc.pgio, inode);
 
-	pgm = &desc.pgio.pg_mirrors[0];
-	NFS_I(inode)->read_io += pgm->pg_bytes_written;
-	npages = (pgm->pg_bytes_written + PAGE_SIZE - 1) >>
-		 PAGE_SHIFT;
-	nfs_add_stats(inode, NFSIOS_READPAGES, npages);
 read_complete:
 	put_nfs_open_context(desc.ctx);
 out:
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index cb0248a34518..3cfcf219e96b 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -570,7 +570,6 @@ extern int nfs_access_get_cached(struct inode *inode, const struct cred *cred, s
 extern int  nfs_readpage(struct file *, struct page *);
 extern int  nfs_readpages(struct file *, struct address_space *,
 		struct list_head *, unsigned);
-extern int  nfs_readpage_async(void *, struct inode *, struct page *);
 
 /*
  * inline functions
-- 
1.8.3.1

