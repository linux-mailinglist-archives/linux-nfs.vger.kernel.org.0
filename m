Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7A15AC389
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Sep 2022 11:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiIDJGG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 4 Sep 2022 05:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiIDJGF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 4 Sep 2022 05:06:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E278491D3
        for <linux-nfs@vger.kernel.org>; Sun,  4 Sep 2022 02:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662282363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QPbW0Esww+n7KzM4XoHJMPjD26OFWFqNl0Aq83pM10s=;
        b=YHuKGj6lI1TWYvNVwDSFszk01HKwtHJ8Ow4X66Pm+EWNvCNTGQKYhAU41EGIeEjczODkFs
        6ymS2/tlT0AuN58gObIf1esbj2NCioWx3Zw61R/GV8AevGJBAnyqUV0pGr5nh3QK+XNBn/
        bB8U3zKRwcqWnSzBOgzPA8sNVoesP/Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-DwHpwH8xOOSyHkV9i6_0Cg-1; Sun, 04 Sep 2022 05:05:59 -0400
X-MC-Unique: DwHpwH8xOOSyHkV9i6_0Cg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A5C138173C5;
        Sun,  4 Sep 2022 09:05:59 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.98])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C8DEA1415102;
        Sun,  4 Sep 2022 09:05:58 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>
Subject: [PATCH v6 1/3] NFS: Rename readpage_async_filler to nfs_pageio_add_page
Date:   Sun,  4 Sep 2022 05:05:55 -0400
Message-Id: <20220904090557.1901131-2-dwysocha@redhat.com>
In-Reply-To: <20220904090557.1901131-1-dwysocha@redhat.com>
References: <20220904090557.1901131-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Rename readpage_async_filler to nfs_pageio_add_page to
better reflect what this function does (add a page to
the nfs_pageio_descriptor), and simplify arguments to
this function by removing struct nfs_readdesc.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/read.c | 60 +++++++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 8ae2c8d1219d..525e82ea9a9e 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -127,11 +127,6 @@ static void nfs_readpage_release(struct nfs_page *req, int error)
 	nfs_release_request(req);
 }
 
-struct nfs_readdesc {
-	struct nfs_pageio_descriptor pgio;
-	struct nfs_open_context *ctx;
-};
-
 static void nfs_page_group_set_uptodate(struct nfs_page *req)
 {
 	if (nfs_page_group_sync_on_bit(req, PG_UPTODATE))
@@ -153,7 +148,8 @@ static void nfs_read_completion(struct nfs_pgio_header *hdr)
 
 		if (test_bit(NFS_IOHDR_EOF, &hdr->flags)) {
 			/* note: regions of the page not covered by a
-			 * request are zeroed in readpage_async_filler */
+			 * request are zeroed in nfs_pageio_add_page
+			 */
 			if (bytes > hdr->good_bytes) {
 				/* nothing in this request was good, so zero
 				 * the full extent of the request */
@@ -281,8 +277,10 @@ static void nfs_readpage_result(struct rpc_task *task,
 		nfs_readpage_retry(task, hdr);
 }
 
-static int
-readpage_async_filler(struct nfs_readdesc *desc, struct page *page)
+int
+nfs_pageio_add_page(struct nfs_pageio_descriptor *pgio,
+		    struct nfs_open_context *ctx,
+		    struct page *page)
 {
 	struct inode *inode = page_file_mapping(page)->host;
 	unsigned int rsize = NFS_SERVER(inode)->rsize;
@@ -302,15 +300,15 @@ readpage_async_filler(struct nfs_readdesc *desc, struct page *page)
 			goto out_unlock;
 	}
 
-	new = nfs_create_request(desc->ctx, page, 0, aligned_len);
+	new = nfs_create_request(ctx, page, 0, aligned_len);
 	if (IS_ERR(new))
 		goto out_error;
 
 	if (len < PAGE_SIZE)
 		zero_user_segment(page, len, PAGE_SIZE);
-	if (!nfs_pageio_add_request(&desc->pgio, new)) {
+	if (!nfs_pageio_add_request(pgio, new)) {
 		nfs_list_remove_request(new);
-		error = desc->pgio.pg_error;
+		error = pgio->pg_error;
 		nfs_readpage_release(new, error);
 		goto out;
 	}
@@ -332,7 +330,8 @@ readpage_async_filler(struct nfs_readdesc *desc, struct page *page)
 int nfs_read_folio(struct file *file, struct folio *folio)
 {
 	struct page *page = &folio->page;
-	struct nfs_readdesc desc;
+	struct nfs_pageio_descriptor pgio;
+	struct nfs_open_context *ctx;
 	struct inode *inode = page_file_mapping(page)->host;
 	int ret;
 
@@ -358,29 +357,29 @@ int nfs_read_folio(struct file *file, struct folio *folio)
 
 	if (file == NULL) {
 		ret = -EBADF;
-		desc.ctx = nfs_find_open_context(inode, NULL, FMODE_READ);
-		if (desc.ctx == NULL)
+		ctx = nfs_find_open_context(inode, NULL, FMODE_READ);
+		if (ctx == NULL)
 			goto out_unlock;
 	} else
-		desc.ctx = get_nfs_open_context(nfs_file_open_context(file));
+		ctx = get_nfs_open_context(nfs_file_open_context(file));
 
-	xchg(&desc.ctx->error, 0);
-	nfs_pageio_init_read(&desc.pgio, inode, false,
+	xchg(&ctx->error, 0);
+	nfs_pageio_init_read(&pgio, inode, false,
 			     &nfs_async_read_completion_ops);
 
-	ret = readpage_async_filler(&desc, page);
+	ret = nfs_pageio_add_page(&pgio, ctx, page);
 	if (ret)
 		goto out;
 
-	nfs_pageio_complete_read(&desc.pgio);
-	ret = desc.pgio.pg_error < 0 ? desc.pgio.pg_error : 0;
+	nfs_pageio_complete_read(&pgio);
+	ret = pgio.pg_error < 0 ? pgio.pg_error : 0;
 	if (!ret) {
 		ret = wait_on_page_locked_killable(page);
 		if (!PageUptodate(page) && !ret)
-			ret = xchg(&desc.ctx->error, 0);
+			ret = xchg(&ctx->error, 0);
 	}
 out:
-	put_nfs_open_context(desc.ctx);
+	put_nfs_open_context(ctx);
 	trace_nfs_aop_readpage_done(inode, page, ret);
 	return ret;
 out_unlock:
@@ -391,9 +390,10 @@ int nfs_read_folio(struct file *file, struct folio *folio)
 
 void nfs_readahead(struct readahead_control *ractl)
 {
+	struct nfs_pageio_descriptor pgio;
+	struct nfs_open_context *ctx;
 	unsigned int nr_pages = readahead_count(ractl);
 	struct file *file = ractl->file;
-	struct nfs_readdesc desc;
 	struct inode *inode = ractl->mapping->host;
 	struct page *page;
 	int ret;
@@ -407,25 +407,25 @@ void nfs_readahead(struct readahead_control *ractl)
 
 	if (file == NULL) {
 		ret = -EBADF;
-		desc.ctx = nfs_find_open_context(inode, NULL, FMODE_READ);
-		if (desc.ctx == NULL)
+		ctx = nfs_find_open_context(inode, NULL, FMODE_READ);
+		if (ctx == NULL)
 			goto out;
 	} else
-		desc.ctx = get_nfs_open_context(nfs_file_open_context(file));
+		ctx = get_nfs_open_context(nfs_file_open_context(file));
 
-	nfs_pageio_init_read(&desc.pgio, inode, false,
+	nfs_pageio_init_read(&pgio, inode, false,
 			     &nfs_async_read_completion_ops);
 
 	while ((page = readahead_page(ractl)) != NULL) {
-		ret = readpage_async_filler(&desc, page);
+		ret = nfs_pageio_add_page(&pgio, ctx, page);
 		put_page(page);
 		if (ret)
 			break;
 	}
 
-	nfs_pageio_complete_read(&desc.pgio);
+	nfs_pageio_complete_read(&pgio);
 
-	put_nfs_open_context(desc.ctx);
+	put_nfs_open_context(ctx);
 out:
 	trace_nfs_aop_readahead_done(inode, nr_pages, ret);
 }
-- 
2.31.1

