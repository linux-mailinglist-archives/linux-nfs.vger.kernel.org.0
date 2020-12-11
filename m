Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD0E2D7CCF
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Dec 2020 18:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403941AbgLKR1H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Dec 2020 12:27:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:50798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395235AbgLKR0p (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 11 Dec 2020 12:26:45 -0500
From:   trondmy@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 06/15] SUNRPC: Clean up open coded setting of the xdr_stream 'nwords' field
Date:   Fri, 11 Dec 2020 12:25:12 -0500
Message-Id: <20201211172521.5567-7-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201211172521.5567-6-trondmy@kernel.org>
References: <20201211172521.5567-1-trondmy@kernel.org>
 <20201211172521.5567-2-trondmy@kernel.org>
 <20201211172521.5567-3-trondmy@kernel.org>
 <20201211172521.5567-4-trondmy@kernel.org>
 <20201211172521.5567-5-trondmy@kernel.org>
 <20201211172521.5567-6-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Move the setting of the xdr_stream 'nwords' field into the helpers that
reset the xdr_stream cursor.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xdr.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 01918e60b67b..f0444bf5617c 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1183,6 +1183,15 @@ static unsigned int xdr_set_iov(struct xdr_stream *xdr, struct kvec *iov,
 	return len - base;
 }
 
+static unsigned int xdr_set_tail_base(struct xdr_stream *xdr,
+				      unsigned int base, unsigned int len)
+{
+	struct xdr_buf *buf = xdr->buf;
+
+	xdr_stream_set_pos(xdr, base + buf->page_len + buf->head->iov_len);
+	return xdr_set_iov(xdr, buf->tail, base, len);
+}
+
 static unsigned int xdr_set_page_base(struct xdr_stream *xdr,
 				      unsigned int base, unsigned int len)
 {
@@ -1201,6 +1210,7 @@ static unsigned int xdr_set_page_base(struct xdr_stream *xdr,
 	if (len > maxlen)
 		len = maxlen;
 
+	xdr_stream_page_set_pos(xdr, base);
 	base += xdr->buf->page_base;
 
 	pgnr = base >> PAGE_SHIFT;
@@ -1223,7 +1233,7 @@ static void xdr_set_page(struct xdr_stream *xdr, unsigned int base,
 {
 	if (xdr_set_page_base(xdr, base, len) == 0) {
 		base -= xdr->buf->page_len;
-		xdr_set_iov(xdr, xdr->buf->tail, base, len);
+		xdr_set_tail_base(xdr, base, len);
 	}
 }
 
@@ -1236,7 +1246,7 @@ static void xdr_set_next_page(struct xdr_stream *xdr)
 	if (newbase < xdr->buf->page_len)
 		xdr_set_page_base(xdr, newbase, xdr_stream_remaining(xdr));
 	else
-		xdr_set_iov(xdr, xdr->buf->tail, 0, xdr_stream_remaining(xdr));
+		xdr_set_tail_base(xdr, 0, xdr_stream_remaining(xdr));
 }
 
 static bool xdr_set_next_buffer(struct xdr_stream *xdr)
@@ -1388,7 +1398,7 @@ static void xdr_realign_pages(struct xdr_stream *xdr)
 	if (iov->iov_len > cur) {
 		copied = xdr_shrink_bufhead(buf, cur);
 		trace_rpc_xdr_alignment(xdr, cur, copied);
-		xdr->nwords = XDR_QUADLEN(buf->len - cur);
+		xdr_set_page(xdr, 0, buf->page_len);
 	}
 }
 
@@ -1396,7 +1406,6 @@ static unsigned int xdr_align_pages(struct xdr_stream *xdr, unsigned int len)
 {
 	struct xdr_buf *buf = xdr->buf;
 	unsigned int nwords = XDR_QUADLEN(len);
-	unsigned int cur = xdr_stream_pos(xdr);
 	unsigned int copied;
 
 	if (xdr->nwords == 0)
@@ -1413,7 +1422,6 @@ static unsigned int xdr_align_pages(struct xdr_stream *xdr, unsigned int len)
 		/* Truncate page data and move it into the tail */
 		copied = xdr_shrink_pagelen(buf, len);
 		trace_rpc_xdr_alignment(xdr, len, copied);
-		xdr->nwords = XDR_QUADLEN(buf->len - cur);
 	}
 	return len;
 }
@@ -1439,12 +1447,10 @@ unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len)
 	if (pglen == 0)
 		return 0;
 
-	xdr->nwords -= nwords;
 	base = (nwords << 2) - pglen;
 	end = xdr_stream_remaining(xdr) - pglen;
 
-	if (xdr_set_iov(xdr, xdr->buf->tail, base, end) == 0)
-		xdr->nwords = 0;
+	xdr_set_tail_base(xdr, base, end);
 	return len <= pglen ? len : pglen;
 }
 EXPORT_SYMBOL_GPL(xdr_read_pages);
@@ -1478,15 +1484,13 @@ unsigned int xdr_align_data(struct xdr_stream *xdr, unsigned int offset,
 	/* Move page data to the left */
 	shift = from - offset;
 	xdr_buf_pages_shift_left(buf, from, len, shift);
-	xdr->buf->len -= shift;
-	xdr->nwords -= XDR_QUADLEN(shift);
 
 	bytes = xdr_stream_remaining(xdr);
 	if (length > bytes)
 		length = bytes;
 	bytes -= length;
 
-	xdr->nwords -= XDR_QUADLEN(length);
+	xdr->buf->len -= shift;
 	xdr_set_page(xdr, offset + length, bytes);
 	return length;
 }
@@ -1508,12 +1512,11 @@ unsigned int xdr_expand_hole(struct xdr_stream *xdr, unsigned int offset,
 		shift = to - from;
 		xdr_buf_try_expand(buf, shift);
 		xdr_buf_pages_shift_right(buf, from, buflen, shift);
-		xdr_stream_page_set_pos(xdr, to);
+		xdr_set_page(xdr, to, xdr_stream_remaining(xdr));
 	} else if (to != from)
 		xdr_align_data(xdr, to, 0);
 	xdr_buf_pages_zero(buf, offset, length);
 
-	xdr_set_page(xdr, to, xdr_stream_remaining(xdr));
 	return length;
 }
 EXPORT_SYMBOL_GPL(xdr_expand_hole);
-- 
2.29.2

