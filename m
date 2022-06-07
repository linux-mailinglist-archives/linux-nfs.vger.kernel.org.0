Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE84D5422A5
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jun 2022 08:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbiFHAse (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Jun 2022 20:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1450007AbiFGXKo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Jun 2022 19:10:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDDA38EB8A
        for <linux-nfs@vger.kernel.org>; Tue,  7 Jun 2022 13:48:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86C9A6166B
        for <linux-nfs@vger.kernel.org>; Tue,  7 Jun 2022 20:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFEDC3411C;
        Tue,  7 Jun 2022 20:47:59 +0000 (UTC)
Subject: [PATCH v2 2/5] SUNRPC: Optimize xdr_reserve_space()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Date:   Tue, 07 Jun 2022 16:47:58 -0400
Message-ID: <165463487881.38298.620791710948316864.stgit@bazille.1015granger.net>
In-Reply-To: <165463444560.38298.18296069287423675496.stgit@bazille.1015granger.net>
References: <165463444560.38298.18296069287423675496.stgit@bazille.1015granger.net>
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

Transitioning between encode buffers is quite infrequent. It happens
about 1 time in 400 calls to xdr_reserve_space(), measured on NFSD
with a typical build/test workload.

Force the compiler to remove that code from xdr_reserve_space(),
which is a hot path on both the server and the client. This change
reduces the size of xdr_reserve_space() from 10 cache lines to 2
when compiled with -Os.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/xdr.h |   16 +++++++++++++++-
 net/sunrpc/xdr.c           |   17 ++++++++++-------
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 4417f667c757..5860f32e3958 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -243,7 +243,7 @@ extern void xdr_init_encode(struct xdr_stream *xdr, struct xdr_buf *buf,
 extern __be32 *xdr_reserve_space(struct xdr_stream *xdr, size_t nbytes);
 extern int xdr_reserve_space_vec(struct xdr_stream *xdr, struct kvec *vec,
 		size_t nbytes);
-extern void xdr_commit_encode(struct xdr_stream *xdr);
+extern void __xdr_commit_encode(struct xdr_stream *xdr);
 extern void xdr_truncate_encode(struct xdr_stream *xdr, size_t len);
 extern int xdr_restrict_buflen(struct xdr_stream *xdr, int newbuflen);
 extern void xdr_write_pages(struct xdr_stream *xdr, struct page **pages,
@@ -306,6 +306,20 @@ xdr_reset_scratch_buffer(struct xdr_stream *xdr)
 	xdr_set_scratch_buffer(xdr, NULL, 0);
 }
 
+/**
+ * xdr_commit_encode - Ensure all data is written to xdr->buf
+ * @xdr: pointer to xdr_stream
+ *
+ * Handle encoding across page boundaries by giving the caller a
+ * temporary location to write to, then later copying the data into
+ * place. __xdr_commit_encode() does that copying.
+ */
+static inline void xdr_commit_encode(struct xdr_stream *xdr)
+{
+	if (unlikely(xdr->scratch.iov_len))
+		__xdr_commit_encode(xdr);
+}
+
 /**
  * xdr_stream_remaining - Return the number of bytes remaining in the stream
  * @xdr: pointer to struct xdr_stream
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index b57cf9df4de8..1ad8b4ef14de 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -919,7 +919,7 @@ void xdr_init_encode(struct xdr_stream *xdr, struct xdr_buf *buf, __be32 *p,
 EXPORT_SYMBOL_GPL(xdr_init_encode);
 
 /**
- * xdr_commit_encode - Ensure all data is written to buffer
+ * __xdr_commit_encode - Ensure all data is written to buffer
  * @xdr: pointer to xdr_stream
  *
  * We handle encoding across page boundaries by giving the caller a
@@ -931,22 +931,25 @@ EXPORT_SYMBOL_GPL(xdr_init_encode);
  * required at the end of encoding, or any other time when the xdr_buf
  * data might be read.
  */
-inline void xdr_commit_encode(struct xdr_stream *xdr)
+void __xdr_commit_encode(struct xdr_stream *xdr)
 {
 	int shift = xdr->scratch.iov_len;
 	void *page;
 
-	if (shift == 0)
-		return;
 	page = page_address(*xdr->page_ptr);
 	memcpy(xdr->scratch.iov_base, page, shift);
 	memmove(page, page + shift, (void *)xdr->p - page);
 	xdr_reset_scratch_buffer(xdr);
 }
-EXPORT_SYMBOL_GPL(xdr_commit_encode);
+EXPORT_SYMBOL_GPL(__xdr_commit_encode);
 
-static __be32 *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
-		size_t nbytes)
+/*
+ * The buffer space to be reserved crosses the boundary between
+ * xdr->buf->head and xdr->buf->pages, or between two pages
+ * in xdr->buf->pages.
+ */
+static noinline __be32 *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
+						   size_t nbytes)
 {
 	__be32 *p;
 	int space_left;


