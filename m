Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D0C2D7CCC
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Dec 2020 18:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395218AbgLKR0g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Dec 2020 12:26:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:50698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395212AbgLKR0F (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 11 Dec 2020 12:26:05 -0500
From:   trondmy@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 03/15] SUNRPC: Fix xdr_expand_hole()
Date:   Fri, 11 Dec 2020 12:25:09 -0500
Message-Id: <20201211172521.5567-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201211172521.5567-3-trondmy@kernel.org>
References: <20201211172521.5567-1-trondmy@kernel.org>
 <20201211172521.5567-2-trondmy@kernel.org>
 <20201211172521.5567-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We do want to try to grow the buffer if possible, but if that attempt
fails, we still want to move the data and truncate the XDR message.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/sunrpc/xdr.h |   2 +-
 net/sunrpc/xdr.c           | 274 ++++++++++++++++++++++++-------------
 2 files changed, 180 insertions(+), 96 deletions(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 2b4e44bb0654..178f499e2283 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -253,7 +253,7 @@ extern unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len);
 extern void xdr_enter_page(struct xdr_stream *xdr, unsigned int len);
 extern int xdr_process_buf(struct xdr_buf *buf, unsigned int offset, unsigned int len, int (*actor)(struct scatterlist *, void *), void *data);
 extern unsigned int xdr_align_data(struct xdr_stream *, unsigned int offset, unsigned int length);
-extern uint64_t xdr_expand_hole(struct xdr_stream *, uint64_t, uint64_t);
+extern unsigned int xdr_expand_hole(struct xdr_stream *, unsigned int offset, unsigned int length);
 
 /**
  * xdr_stream_remaining - Return the number of bytes remaining in the stream
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index c474339ba9ac..e0906ed24374 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -334,46 +334,6 @@ _shift_data_right_pages(struct page **pages, size_t pgto_base,
 	} while ((len -= copy) != 0);
 }
 
-static unsigned int
-_shift_data_right_tail(struct xdr_buf *buf, unsigned int pgfrom, size_t len)
-{
-	struct kvec *tail = buf->tail;
-	unsigned int tailbuf_len;
-	unsigned int result = 0;
-	size_t copy;
-
-	tailbuf_len = buf->buflen - buf->head->iov_len - buf->page_len;
-
-	/* Shift the tail first */
-	if (tailbuf_len != 0) {
-		unsigned int free_space = tailbuf_len - tail->iov_len;
-
-		if (len < free_space)
-			free_space = len;
-		if (len > free_space)
-			len = free_space;
-
-		tail->iov_len += free_space;
-		copy = len;
-
-		if (tail->iov_len > len) {
-			char *p = (char *)tail->iov_base + len;
-			memmove(p, tail->iov_base, tail->iov_len - free_space);
-			result += tail->iov_len - free_space;
-		} else
-			copy = tail->iov_len;
-
-		/* Copy from the inlined pages into the tail */
-		_copy_from_pages((char *)tail->iov_base,
-					 buf->pages,
-					 buf->page_base + pgfrom,
-					 copy);
-		result += copy;
-	}
-
-	return result;
-}
-
 /**
  * _copy_to_pages
  * @pages: array of pages
@@ -464,18 +424,42 @@ _copy_from_pages(char *p, struct page **pages, size_t pgbase, size_t len)
 }
 EXPORT_SYMBOL_GPL(_copy_from_pages);
 
+static void xdr_buf_iov_zero(const struct kvec *iov, unsigned int base,
+			     unsigned int len)
+{
+	if (base >= iov->iov_len)
+		return;
+	if (len > iov->iov_len - base)
+		len = iov->iov_len - base;
+	memset(iov->iov_base + base, 0, len);
+}
+
 /**
- * _zero_pages
- * @pages: array of pages
- * @pgbase: beginning page vector address
+ * xdr_buf_pages_zero
+ * @buf: xdr_buf
+ * @pgbase: beginning offset
  * @len: length
  */
-static void
-_zero_pages(struct page **pages, size_t pgbase, size_t len)
+static void xdr_buf_pages_zero(const struct xdr_buf *buf, unsigned int pgbase,
+			       unsigned int len)
 {
+	struct page **pages = buf->pages;
 	struct page **page;
 	char *vpage;
-	size_t zero;
+	unsigned int zero;
+
+	if (!len)
+		return;
+	if (pgbase >= buf->page_len) {
+		xdr_buf_iov_zero(buf->tail, pgbase - buf->page_len, len);
+		return;
+	}
+	if (pgbase + len > buf->page_len) {
+		xdr_buf_iov_zero(buf->tail, 0, pgbase + len - buf->page_len);
+		len = buf->page_len - pgbase;
+	}
+
+	pgbase += buf->page_base;
 
 	page = pages + (pgbase >> PAGE_SHIFT);
 	pgbase &= ~PAGE_MASK;
@@ -496,6 +480,103 @@ _zero_pages(struct page **pages, size_t pgbase, size_t len)
 	} while ((len -= zero) != 0);
 }
 
+static void xdr_buf_try_expand(struct xdr_buf *buf, unsigned int len)
+{
+	struct kvec *head = buf->head;
+	struct kvec *tail = buf->tail;
+	unsigned int sum = head->iov_len + buf->page_len + tail->iov_len;
+	unsigned int free_space;
+
+	if (sum > buf->len) {
+		free_space = min_t(unsigned int, sum - buf->len, len);
+		buf->len += free_space;
+		len -= free_space;
+		if (!len)
+			return;
+	}
+
+	if (buf->buflen > sum) {
+		/* Expand the tail buffer */
+		free_space = min_t(unsigned int, buf->buflen - sum, len);
+		tail->iov_len += free_space;
+		buf->len += free_space;
+	}
+}
+
+static void xdr_buf_tail_copy_right(const struct xdr_buf *buf,
+				    unsigned int base, unsigned int len,
+				    unsigned int shift)
+{
+	const struct kvec *tail = buf->tail;
+	unsigned int to = base + shift;
+
+	if (to >= tail->iov_len)
+		return;
+	if (len + to > tail->iov_len)
+		len = tail->iov_len - to;
+	memmove(tail->iov_base + to, tail->iov_base + base, len);
+}
+
+static void xdr_buf_pages_copy_right(const struct xdr_buf *buf,
+				     unsigned int base, unsigned int len,
+				     unsigned int shift)
+{
+	const struct kvec *tail = buf->tail;
+	unsigned int to = base + shift;
+	unsigned int pglen = 0;
+	unsigned int talen = 0, tato = 0;
+
+	if (base >= buf->page_len)
+		return;
+	if (len > buf->page_len - base)
+		len = buf->page_len - base;
+	if (to >= buf->page_len) {
+		tato = to - buf->page_len;
+		if (tail->iov_len >= len + tato)
+			talen = len;
+		else if (tail->iov_len > tato)
+			talen = tail->iov_len - tato;
+	} else if (len + to >= buf->page_len) {
+		pglen = buf->page_len - to;
+		talen = len - pglen;
+		if (talen > tail->iov_len)
+			talen = tail->iov_len;
+	} else
+		pglen = len;
+
+	_copy_from_pages(tail->iov_base + tato, buf->pages,
+			 buf->page_base + base + pglen, talen);
+	_shift_data_right_pages(buf->pages, buf->page_base + to,
+				buf->page_base + base, pglen);
+}
+
+static void xdr_buf_tail_shift_right(const struct xdr_buf *buf,
+				     unsigned int base, unsigned int len,
+				     unsigned int shift)
+{
+	const struct kvec *tail = buf->tail;
+
+	if (base >= tail->iov_len || !shift || !len)
+		return;
+	xdr_buf_tail_copy_right(buf, base, len, shift);
+}
+
+static void xdr_buf_pages_shift_right(const struct xdr_buf *buf,
+				      unsigned int base, unsigned int len,
+				      unsigned int shift)
+{
+	if (!shift || !len)
+		return;
+	if (base >= buf->page_len) {
+		xdr_buf_tail_shift_right(buf, base - buf->page_len, len, shift);
+		return;
+	}
+	if (base + len > buf->page_len)
+		xdr_buf_tail_shift_right(buf, 0, base + len - buf->page_len,
+					 shift);
+	xdr_buf_pages_copy_right(buf, base, len, shift);
+}
+
 static void xdr_buf_tail_copy_left(const struct xdr_buf *buf, unsigned int base,
 				   unsigned int len, unsigned int shift)
 {
@@ -685,30 +766,33 @@ xdr_shrink_bufhead(struct xdr_buf *buf, size_t len)
 }
 
 /**
- * xdr_shrink_pagelen - shrinks buf->pages by up to @len bytes
+ * xdr_shrink_pagelen - shrinks buf->pages to @len bytes
  * @buf: xdr_buf
- * @len: bytes to remove from buf->pages
+ * @len: new page buffer length
  *
  * The extra data is not lost, but is instead moved into buf->tail.
  * Returns the actual number of bytes moved.
  */
-static unsigned int
-xdr_shrink_pagelen(struct xdr_buf *buf, size_t len)
+static unsigned int xdr_shrink_pagelen(struct xdr_buf *buf, unsigned int len)
 {
-	unsigned int pglen = buf->page_len;
-	unsigned int result;
-
-	if (len > buf->page_len)
-		len = buf-> page_len;
-
-	result = _shift_data_right_tail(buf, pglen - len, len);
-	buf->page_len -= len;
-	buf->buflen -= len;
-	/* Have we truncated the message? */
-	if (buf->len > buf->buflen)
-		buf->len = buf->buflen;
+	unsigned int shift, buflen = buf->len - buf->head->iov_len;
 
-	return result;
+	WARN_ON_ONCE(len > buf->page_len);
+	if (buf->head->iov_len >= buf->len || len > buflen)
+		buflen = len;
+	if (buf->page_len > buflen) {
+		buf->buflen -= buf->page_len - buflen;
+		buf->page_len = buflen;
+	}
+	if (len >= buf->page_len)
+		return 0;
+	shift = buf->page_len - len;
+	xdr_buf_try_expand(buf, shift);
+	xdr_buf_pages_shift_right(buf, len, buflen - len, shift);
+	buf->page_len = len;
+	buf->len -= shift;
+	buf->buflen -= shift;
+	return shift;
 }
 
 void
@@ -728,6 +812,18 @@ unsigned int xdr_stream_pos(const struct xdr_stream *xdr)
 }
 EXPORT_SYMBOL_GPL(xdr_stream_pos);
 
+static void xdr_stream_set_pos(struct xdr_stream *xdr, unsigned int pos)
+{
+	unsigned int blen = xdr->buf->len;
+
+	xdr->nwords = blen > pos ? XDR_QUADLEN(blen) - XDR_QUADLEN(pos) : 0;
+}
+
+static void xdr_stream_page_set_pos(struct xdr_stream *xdr, unsigned int pos)
+{
+	xdr_stream_set_pos(xdr, pos + xdr->buf->head[0].iov_len);
+}
+
 /**
  * xdr_page_pos - Return the current offset from the start of the xdr pages
  * @xdr: pointer to struct xdr_stream
@@ -1291,7 +1387,7 @@ static unsigned int xdr_align_pages(struct xdr_stream *xdr, unsigned int len)
 	struct xdr_buf *buf = xdr->buf;
 	unsigned int nwords = XDR_QUADLEN(len);
 	unsigned int cur = xdr_stream_pos(xdr);
-	unsigned int copied, offset;
+	unsigned int copied;
 
 	if (xdr->nwords == 0)
 		return 0;
@@ -1305,9 +1401,8 @@ static unsigned int xdr_align_pages(struct xdr_stream *xdr, unsigned int len)
 		len = buf->page_len;
 	else if (nwords < xdr->nwords) {
 		/* Truncate page data and move it into the tail */
-		offset = buf->page_len - len;
-		copied = xdr_shrink_pagelen(buf, offset);
-		trace_rpc_xdr_alignment(xdr, offset, copied);
+		copied = xdr_shrink_pagelen(buf, len);
+		trace_rpc_xdr_alignment(xdr, len, copied);
 		xdr->nwords = XDR_QUADLEN(buf->len - cur);
 	}
 	return len;
@@ -1387,39 +1482,28 @@ unsigned int xdr_align_data(struct xdr_stream *xdr, unsigned int offset,
 }
 EXPORT_SYMBOL_GPL(xdr_align_data);
 
-uint64_t xdr_expand_hole(struct xdr_stream *xdr, uint64_t offset, uint64_t length)
+unsigned int xdr_expand_hole(struct xdr_stream *xdr, unsigned int offset,
+			     unsigned int length)
 {
 	struct xdr_buf *buf = xdr->buf;
-	unsigned int bytes;
-	unsigned int from;
-	unsigned int truncated = 0;
-
-	if ((offset + length) < offset ||
-	    (offset + length) > buf->page_len)
-		length = buf->page_len - offset;
+	unsigned int from, to, shift;
 
 	xdr_realign_pages(xdr);
 	from = xdr_page_pos(xdr);
-	bytes = xdr_stream_remaining(xdr);
-
-	if (offset + length + bytes > buf->page_len) {
-		unsigned int shift = (offset + length + bytes) - buf->page_len;
-		unsigned int res = _shift_data_right_tail(buf, from + bytes - shift, shift);
-		truncated = shift - res;
-		xdr->nwords -= XDR_QUADLEN(truncated);
-		bytes -= shift;
-	}
-
-	/* Now move the page data over and zero pages */
-	if (bytes > 0)
-		_shift_data_right_pages(buf->pages,
-					buf->page_base + offset + length,
-					buf->page_base + from,
-					bytes);
-	_zero_pages(buf->pages, buf->page_base + offset, length);
-
-	buf->len += length - (from - offset) - truncated;
-	xdr_set_page(xdr, offset + length, xdr_stream_remaining(xdr));
+	to = xdr_align_size(offset + length);
+
+	/* Could the hole be behind us? */
+	if (to > from) {
+		unsigned int buflen = buf->len - buf->head->iov_len;
+		shift = to - from;
+		xdr_buf_try_expand(buf, shift);
+		xdr_buf_pages_shift_right(buf, from, buflen, shift);
+		xdr_stream_page_set_pos(xdr, to);
+	} else if (to != from)
+		xdr_align_data(xdr, to, 0);
+	xdr_buf_pages_zero(buf, offset, length);
+
+	xdr_set_page(xdr, to, xdr_stream_remaining(xdr));
 	return length;
 }
 EXPORT_SYMBOL_GPL(xdr_expand_hole);
-- 
2.29.2

