Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473C52BC95D
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Nov 2020 21:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgKVUwf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 22 Nov 2020 15:52:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:57546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbgKVUwf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 22 Nov 2020 15:52:35 -0500
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA6D120789
        for <linux-nfs@vger.kernel.org>; Sun, 22 Nov 2020 20:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606078355;
        bh=pVN1NYJXByzgbl+Gege54jjNGn2XTbEaz6hjagDwx50=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cgHjdQb+xTxg0QF5MOAvz/2wbHvgYggRL0jQTMXo2FrWiMcEvaHFCqKr4CEio7LtJ
         jGTdpfTErCAeV9wEnw7/9i14pz/UEripEYRm0euJjclIKvjDhUnwgJMCn11vFwAUTB
         T1/C0fjqBmelzAHRXhVBpJUwZJZC+g51AYfP4sco=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/8] SUNRPC: Clean up helpers xdr_set_iov() and xdr_set_page_base()
Date:   Sun, 22 Nov 2020 15:52:24 -0500
Message-Id: <20201122205229.3826-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201122205229.3826-3-trondmy@kernel.org>
References: <20201122205229.3826-1-trondmy@kernel.org>
 <20201122205229.3826-2-trondmy@kernel.org>
 <20201122205229.3826-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Allow xdr_set_iov() to set a base so that we can use it to set the
cursor to a specific position in the kvec buffer.

If the new base overflows the kvec/pages buffer in either xdr_set_iov()
or xdr_set_page_base(), then truncate it so that we point to the end of
the buffer.

Finally, change both function to return the number of bytes remaining to
read in their buffers.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xdr.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index bc7a622016ee..394297ec1cb9 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -970,19 +970,22 @@ void xdr_write_pages(struct xdr_stream *xdr, struct page **pages, unsigned int b
 }
 EXPORT_SYMBOL_GPL(xdr_write_pages);
 
-static void xdr_set_iov(struct xdr_stream *xdr, struct kvec *iov,
-		unsigned int len)
+static unsigned int xdr_set_iov(struct xdr_stream *xdr, struct kvec *iov,
+				unsigned int base, unsigned int len)
 {
 	if (len > iov->iov_len)
 		len = iov->iov_len;
-	xdr->p = (__be32*)iov->iov_base;
+	if (unlikely(base > len))
+		base = len;
+	xdr->p = (__be32*)(iov->iov_base + base);
 	xdr->end = (__be32*)(iov->iov_base + len);
 	xdr->iov = iov;
 	xdr->page_ptr = NULL;
+	return len - base;
 }
 
-static int xdr_set_page_base(struct xdr_stream *xdr,
-		unsigned int base, unsigned int len)
+static unsigned int xdr_set_page_base(struct xdr_stream *xdr,
+				      unsigned int base, unsigned int len)
 {
 	unsigned int pgnr;
 	unsigned int maxlen;
@@ -991,9 +994,11 @@ static int xdr_set_page_base(struct xdr_stream *xdr,
 	void *kaddr;
 
 	maxlen = xdr->buf->page_len;
-	if (base >= maxlen)
-		return -EINVAL;
-	maxlen -= base;
+	if (base >= maxlen) {
+		base = maxlen;
+		maxlen = 0;
+	} else
+		maxlen -= base;
 	if (len > maxlen)
 		len = maxlen;
 
@@ -1011,14 +1016,14 @@ static int xdr_set_page_base(struct xdr_stream *xdr,
 		pgend = PAGE_SIZE;
 	xdr->end = (__be32*)(kaddr + pgend);
 	xdr->iov = NULL;
-	return 0;
+	return len;
 }
 
 static void xdr_set_page(struct xdr_stream *xdr, unsigned int base,
 			 unsigned int len)
 {
-	if (xdr_set_page_base(xdr, base, len) < 0)
-		xdr_set_iov(xdr, xdr->buf->tail, xdr->nwords << 2);
+	if (xdr_set_page_base(xdr, base, len) == 0)
+		xdr_set_iov(xdr, xdr->buf->tail, 0, xdr_stream_remaining(xdr));
 }
 
 static void xdr_set_next_page(struct xdr_stream *xdr)
@@ -1055,12 +1060,9 @@ void xdr_init_decode(struct xdr_stream *xdr, struct xdr_buf *buf, __be32 *p,
 	xdr->scratch.iov_base = NULL;
 	xdr->scratch.iov_len = 0;
 	xdr->nwords = XDR_QUADLEN(buf->len);
-	if (buf->head[0].iov_len != 0)
-		xdr_set_iov(xdr, buf->head, buf->len);
-	else if (buf->page_len != 0)
-		xdr_set_page_base(xdr, 0, buf->len);
-	else
-		xdr_set_iov(xdr, buf->tail, buf->len);
+	if (xdr_set_iov(xdr, buf->head, 0, buf->len) == 0 &&
+	    xdr_set_page_base(xdr, 0, buf->len) == 0)
+		xdr_set_iov(xdr, buf->tail, 0, buf->len);
 	if (p != NULL && p > xdr->p && xdr->end >= p) {
 		xdr->nwords -= p - xdr->p;
 		xdr->p = p;
-- 
2.28.0

