Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27BB69CCDE
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Feb 2023 14:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjBTNoI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Feb 2023 08:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjBTNoG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Feb 2023 08:44:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D901C585
        for <linux-nfs@vger.kernel.org>; Mon, 20 Feb 2023 05:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676900593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y3EjzB0OOl0TQdFJ8eoQ91vfL3E1hDWFQA6V6T6kY+k=;
        b=PRI3kBvubnvGdFJfSMIBE66RkPEsUfIXsPsib7k6+8dMXCdF9WyxBEafnV394jGZ/v+YHa
        7410q3QpMaUKrtgfuZ6jB+DIBRFYh0C4JQaqLw4BsZb9lMtvsvKCFHqVDMYCN1Qn4X00eM
        szqvujwSYTDrx4PHOcgNIGcHhuiRJZU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-278-aKVzqjynPfCh65w_jFmJ1w-1; Mon, 20 Feb 2023 08:43:10 -0500
X-MC-Unique: aKVzqjynPfCh65w_jFmJ1w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 044C1802D32;
        Mon, 20 Feb 2023 13:43:10 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B9207404CD84;
        Mon, 20 Feb 2023 13:43:09 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>,
        Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: [PATCH v11 1/5] NFS: Rename readpage_async_filler to nfs_read_add_folio
Date:   Mon, 20 Feb 2023 08:43:04 -0500
Message-Id: <20230220134308.1193219-2-dwysocha@redhat.com>
In-Reply-To: <20230220134308.1193219-1-dwysocha@redhat.com>
References: <20230220134308.1193219-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Rename readpage_async_filler to nfs_read_add_folio to
better reflect what this function does (add a folio to
the nfs_pageio_descriptor), and simplify arguments to
this function by removing struct nfs_readdesc.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/read.c | 54 +++++++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index c380cff4108e..4cb3991c4735 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -126,11 +126,6 @@ static void nfs_readpage_release(struct nfs_page *req, int error)
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
@@ -152,7 +147,8 @@ static void nfs_read_completion(struct nfs_pgio_header *hdr)
 
 		if (test_bit(NFS_IOHDR_EOF, &hdr->flags)) {
 			/* note: regions of the page not covered by a
-			 * request are zeroed in readpage_async_filler */
+			 * request are zeroed in nfs_read_add_folio
+			 */
 			if (bytes > hdr->good_bytes) {
 				/* nothing in this request was good, so zero
 				 * the full extent of the request */
@@ -280,7 +276,9 @@ static void nfs_readpage_result(struct rpc_task *task,
 		nfs_readpage_retry(task, hdr);
 }
 
-static int readpage_async_filler(struct nfs_readdesc *desc, struct folio *folio)
+static int nfs_read_add_folio(struct nfs_pageio_descriptor *pgio,
+			      struct nfs_open_context *ctx,
+			      struct folio *folio)
 {
 	struct inode *inode = folio_file_mapping(folio)->host;
 	struct nfs_server *server = NFS_SERVER(inode);
@@ -302,15 +300,15 @@ static int readpage_async_filler(struct nfs_readdesc *desc, struct folio *folio)
 			goto out_unlock;
 	}
 
-	new = nfs_page_create_from_folio(desc->ctx, folio, 0, aligned_len);
+	new = nfs_page_create_from_folio(ctx, folio, 0, aligned_len);
 	if (IS_ERR(new))
 		goto out_error;
 
 	if (len < fsize)
 		folio_zero_segment(folio, len, fsize);
-	if (!nfs_pageio_add_request(&desc->pgio, new)) {
+	if (!nfs_pageio_add_request(pgio, new)) {
 		nfs_list_remove_request(new);
-		error = desc->pgio.pg_error;
+		error = pgio->pg_error;
 		nfs_readpage_release(new, error);
 		goto out;
 	}
@@ -331,8 +329,9 @@ static int readpage_async_filler(struct nfs_readdesc *desc, struct folio *folio)
  */
 int nfs_read_folio(struct file *file, struct folio *folio)
 {
-	struct nfs_readdesc desc;
 	struct inode *inode = file_inode(file);
+	struct nfs_pageio_descriptor pgio;
+	struct nfs_open_context *ctx;
 	int ret;
 
 	trace_nfs_aop_readpage(inode, folio);
@@ -355,25 +354,25 @@ int nfs_read_folio(struct file *file, struct folio *folio)
 	if (NFS_STALE(inode))
 		goto out_unlock;
 
-	desc.ctx = get_nfs_open_context(nfs_file_open_context(file));
+	ctx = get_nfs_open_context(nfs_file_open_context(file));
 
-	xchg(&desc.ctx->error, 0);
-	nfs_pageio_init_read(&desc.pgio, inode, false,
+	xchg(&ctx->error, 0);
+	nfs_pageio_init_read(&pgio, inode, false,
 			     &nfs_async_read_completion_ops);
 
-	ret = readpage_async_filler(&desc, folio);
+	ret = nfs_read_add_folio(&pgio, ctx, folio);
 	if (ret)
 		goto out;
 
-	nfs_pageio_complete_read(&desc.pgio);
-	ret = desc.pgio.pg_error < 0 ? desc.pgio.pg_error : 0;
+	nfs_pageio_complete_read(&pgio);
+	ret = pgio.pg_error < 0 ? pgio.pg_error : 0;
 	if (!ret) {
 		ret = folio_wait_locked_killable(folio);
 		if (!folio_test_uptodate(folio) && !ret)
-			ret = xchg(&desc.ctx->error, 0);
+			ret = xchg(&ctx->error, 0);
 	}
 out:
-	put_nfs_open_context(desc.ctx);
+	put_nfs_open_context(ctx);
 	trace_nfs_aop_readpage_done(inode, folio, ret);
 	return ret;
 out_unlock:
@@ -384,9 +383,10 @@ int nfs_read_folio(struct file *file, struct folio *folio)
 
 void nfs_readahead(struct readahead_control *ractl)
 {
+	struct nfs_pageio_descriptor pgio;
+	struct nfs_open_context *ctx;
 	unsigned int nr_pages = readahead_count(ractl);
 	struct file *file = ractl->file;
-	struct nfs_readdesc desc;
 	struct inode *inode = ractl->mapping->host;
 	struct folio *folio;
 	int ret;
@@ -400,24 +400,24 @@ void nfs_readahead(struct readahead_control *ractl)
 
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
 
 	while ((folio = readahead_folio(ractl)) != NULL) {
-		ret = readpage_async_filler(&desc, folio);
+		ret = nfs_read_add_folio(&pgio, ctx, folio);
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

