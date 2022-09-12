Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298705B62A7
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Sep 2022 23:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiILVXA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Sep 2022 17:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiILVW7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Sep 2022 17:22:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084174055B
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 14:22:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95B4961297
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 21:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00013C433D7
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 21:22:56 +0000 (UTC)
Subject: [PATCH v1 05/12] NFSD: Refactor common code out of dirlist helpers
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 12 Sep 2022 17:22:56 -0400
Message-ID: <166301777615.89884.16374274815216182549.stgit@oracle-102.nfsv4.dev>
In-Reply-To: <166301759113.89884.7985359396842428444.stgit@oracle-102.nfsv4.dev>
References: <166301759113.89884.7985359396842428444.stgit@oracle-102.nfsv4.dev>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The dust has settled a bit and it's become obvious what code is
totally common between nfsd_init_dirlist_pages() and
nfsd3_init_dirlist_pages(). Move that common code to SUNRPC.

The new helper brackets the existing xdr_init_decode_pages() API.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c         |   10 +---------
 fs/nfsd/nfsproc.c          |   10 +---------
 include/linux/sunrpc/xdr.h |    2 ++
 net/sunrpc/xdr.c           |   22 ++++++++++++++++++++++
 4 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 58695e4e18b4..923d9a80df92 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -574,15 +574,7 @@ static void nfsd3_init_dirlist_pages(struct svc_rqst *rqstp,
 	buf->pages = rqstp->rq_next_page;
 	rqstp->rq_next_page += (buf->buflen + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
-	/* This is xdr_init_encode(), but it assumes that
-	 * the head kvec has already been consumed. */
-	xdr_set_scratch_buffer(xdr, NULL, 0);
-	xdr->buf = buf;
-	xdr->page_ptr = buf->pages;
-	xdr->iov = NULL;
-	xdr->p = page_address(*buf->pages);
-	xdr->end = (void *)xdr->p + min_t(u32, buf->buflen, PAGE_SIZE);
-	xdr->rqst = NULL;
+	xdr_init_encode_pages(xdr, buf, buf->pages,  NULL);
 }
 
 /*
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 49778ff410e3..82b3ddeacc33 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -575,15 +575,7 @@ static void nfsd_init_dirlist_pages(struct svc_rqst *rqstp,
 	buf->pages = rqstp->rq_next_page;
 	rqstp->rq_next_page++;
 
-	/* This is xdr_init_encode(), but it assumes that
-	 * the head kvec has already been consumed. */
-	xdr_set_scratch_buffer(xdr, NULL, 0);
-	xdr->buf = buf;
-	xdr->page_ptr = buf->pages;
-	xdr->iov = NULL;
-	xdr->p = page_address(*buf->pages);
-	xdr->end = (void *)xdr->p + min_t(u32, buf->buflen, PAGE_SIZE);
-	xdr->rqst = NULL;
+	xdr_init_encode_pages(xdr, buf, buf->pages,  NULL);
 }
 
 /*
diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 69175029abbb..f84e2a1358e1 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -240,6 +240,8 @@ typedef int	(*kxdrdproc_t)(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
 
 extern void xdr_init_encode(struct xdr_stream *xdr, struct xdr_buf *buf,
 			    __be32 *p, struct rpc_rqst *rqst);
+extern void xdr_init_encode_pages(struct xdr_stream *xdr, struct xdr_buf *buf,
+			   struct page **pages, struct rpc_rqst *rqst);
 extern __be32 *xdr_reserve_space(struct xdr_stream *xdr, size_t nbytes);
 extern int xdr_reserve_space_vec(struct xdr_stream *xdr, struct kvec *vec,
 		size_t nbytes);
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 482586c23fdd..b7a7e1467a1b 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -946,6 +946,28 @@ void xdr_init_encode(struct xdr_stream *xdr, struct xdr_buf *buf, __be32 *p,
 }
 EXPORT_SYMBOL_GPL(xdr_init_encode);
 
+/**
+ * xdr_init_encode_pages - Initialize an xdr_stream for encoding into pages
+ * @xdr: pointer to xdr_stream struct
+ * @buf: pointer to XDR buffer into which to encode data
+ * @pages: list of pages to decode into
+ * @rqst: pointer to controlling rpc_rqst, for debugging
+ *
+ */
+void xdr_init_encode_pages(struct xdr_stream *xdr, struct xdr_buf *buf,
+			   struct page **pages, struct rpc_rqst *rqst)
+{
+	xdr_reset_scratch_buffer(xdr);
+
+	xdr->buf = buf;
+	xdr->page_ptr = pages;
+	xdr->iov = NULL;
+	xdr->p = page_address(*pages);
+	xdr->end = (void *)xdr->p + min_t(u32, buf->buflen, PAGE_SIZE);
+	xdr->rqst = rqst;
+}
+EXPORT_SYMBOL_GPL(xdr_init_encode_pages);
+
 /**
  * __xdr_commit_encode - Ensure all data is written to buffer
  * @xdr: pointer to xdr_stream


