Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7B5221087
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jul 2020 17:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgGOPL0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jul 2020 11:11:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37913 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725770AbgGOPLZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jul 2020 11:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594825884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=AkoXwSmUvRgaP310gBvw+uj06qrHBNPSt/TdXLCHm9g=;
        b=gwge8XhEMrNl0JACpZ2dNeCIHFDFGmPiCWYByQzDPDSrNXv2FIMcsBsrcrQLNEGdNclLW1
        plliQaaGnDKRIn7IWTY9g+WdULqvx8GOd36Cl0+albNoWJpl5N+hgRqtLDz/IO7xPYMP54
        pSu6UsMP6UUPI0LFTIWjurcug4hi8aI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-Th0OVKLcNwSXUFKtQgZRDw-1; Wed, 15 Jul 2020 11:11:19 -0400
X-MC-Unique: Th0OVKLcNwSXUFKtQgZRDw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63EC71093A03;
        Wed, 15 Jul 2020 15:10:54 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-118-79.rdu2.redhat.com [10.10.118.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EBA1E60BF1;
        Wed, 15 Jul 2020 15:10:53 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: [RFC PATCH v1 05/13] NFS: Add nfs_pageio_complete_read() and remove nfs_readpage_async()
Date:   Wed, 15 Jul 2020 11:10:41 -0400
Message-Id: <1594825849-24991-6-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1594825849-24991-1-git-send-email-dwysocha@redhat.com>
References: <1594825849-24991-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add nfs_pageio_complete_read() and call this from both nfs_readpage()
and nfs_readpages(), since the submission and accounting is the same
for both functions.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/read.c | 137 ++++++++++++++++++++++++++--------------------------------
 1 file changed, 61 insertions(+), 76 deletions(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 600c17c2b409..32d359604220 100644
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
-	struct nfs_readdesc *desc = (struct nfs_readdesc *)data;
-	struct nfs_pgio_mirror *pgm;
-	int error;
-
-	nfs_pageio_init_read(desc->pgio, inode, false,
-			     &nfs_async_read_completion_ops);
-
-	error = readpage_async_filler(desc, page);
-	if (error)
-		goto out;
-
-	nfs_pageio_complete(desc->pgio);
-
-	/* It doesn't make sense to do mirrored reads! */
-	WARN_ON_ONCE(desc->pgio->pg_mirror_count != 1);
-
-	pgm = &desc->pgio->pg_mirrors[0];
-	NFS_I(inode)->read_io += pgm->pg_bytes_written;
-
-	return desc->pgio->pg_error < 0 ? desc->pgio->pg_error : 0;
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
+	struct nfs_readdesc *desc = (struct nfs_readdesc *)data;
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
+	if (!nfs_pageio_add_request(desc->pgio, new)) {
+		nfs_list_remove_request(new);
+		error = desc->pgio->pg_error;
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
@@ -353,13 +372,20 @@ int nfs_readpage(struct file *filp, struct page *page)
 
 	desc.pgio = &pgio;
 	xchg(&desc.ctx->error, 0);
-	ret = nfs_readpage_async(&desc, inode, page);
+	nfs_pageio_init_read(desc.pgio, inode, false,
+			     &nfs_async_read_completion_ops);
+
+	ret = readpage_async_filler(desc.pgio, page);
+
+	if (!ret)
+		nfs_pageio_complete_read(desc.pgio, inode);
+
+	ret = desc.pgio->pg_error < 0 ? desc.pgio->pg_error : 0;
 	if (!ret) {
 		ret = wait_on_page_locked_killable(page);
 		if (!PageUptodate(page) && !ret)
 			ret = xchg(&desc.ctx->error, 0);
 	}
-	nfs_add_stats(inode, NFSIOS_READPAGES, 1);
 out:
 	put_nfs_open_context(desc.ctx);
 	return ret;
@@ -368,46 +394,12 @@ int nfs_readpage(struct file *filp, struct page *page)
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
-	if (!nfs_pageio_add_request(desc->pgio, new)) {
-		nfs_list_remove_request(new);
-		error = desc->pgio->pg_error;
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
 int nfs_readpages(struct file *filp, struct address_space *mapping,
 		struct list_head *pages, unsigned nr_pages)
 {
 	struct nfs_pageio_descriptor pgio;
-	struct nfs_pgio_mirror *pgm;
 	struct nfs_readdesc desc;
 	struct inode *inode = mapping->host;
-	unsigned long npages;
 	int ret;
 
 	dprintk("NFS: nfs_readpages (%s/%Lu %d)\n",
@@ -441,16 +433,9 @@ int nfs_readpages(struct file *filp, struct address_space *mapping,
 			     &nfs_async_read_completion_ops);
 
 	ret = read_cache_pages(mapping, pages, readpage_async_filler, &desc);
-	nfs_pageio_complete(&pgio);
 
-	/* It doesn't make sense to do mirrored reads! */
-	WARN_ON_ONCE(pgio.pg_mirror_count != 1);
+	nfs_pageio_complete_read(desc.pgio, inode);
 
-	pgm = &pgio.pg_mirrors[0];
-	NFS_I(inode)->read_io += pgm->pg_bytes_written;
-	npages = (pgm->pg_bytes_written + PAGE_SIZE - 1) >>
-		 PAGE_SHIFT;
-	nfs_add_stats(inode, NFSIOS_READPAGES, npages);
 read_complete:
 	put_nfs_open_context(desc.ctx);
 out:
-- 
1.8.3.1

