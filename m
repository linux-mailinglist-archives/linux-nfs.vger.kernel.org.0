Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F922D7CCB
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Dec 2020 18:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395211AbgLKR0g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Dec 2020 12:26:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:50700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395218AbgLKR0F (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 11 Dec 2020 12:26:05 -0500
From:   trondmy@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 04/15] SUNRPC: Cleanup xdr_shrink_bufhead()
Date:   Fri, 11 Dec 2020 12:25:10 -0500
Message-Id: <20201211172521.5567-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201211172521.5567-4-trondmy@kernel.org>
References: <20201211172521.5567-1-trondmy@kernel.org>
 <20201211172521.5567-2-trondmy@kernel.org>
 <20201211172521.5567-3-trondmy@kernel.org>
 <20201211172521.5567-4-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Clean up xdr_shrink_bufhead() to use the new helpers instead of doing
its own thing.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xdr.c | 164 +++++++++++++++++++++++++----------------------
 1 file changed, 87 insertions(+), 77 deletions(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index e0906ed24374..19eaa38f7d16 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -550,6 +550,53 @@ static void xdr_buf_pages_copy_right(const struct xdr_buf *buf,
 				buf->page_base + base, pglen);
 }
 
+static void xdr_buf_head_copy_right(const struct xdr_buf *buf,
+				    unsigned int base, unsigned int len,
+				    unsigned int shift)
+{
+	const struct kvec *head = buf->head;
+	const struct kvec *tail = buf->tail;
+	unsigned int to = base + shift;
+	unsigned int pglen = 0, pgto = 0;
+	unsigned int talen = 0, tato = 0;
+
+	if (base >= head->iov_len)
+		return;
+	if (len > head->iov_len - base)
+		len = head->iov_len - base;
+	if (to >= buf->page_len + head->iov_len) {
+		tato = to - buf->page_len - head->iov_len;
+		talen = len;
+	} else if (to >= head->iov_len) {
+		pgto = to - head->iov_len;
+		pglen = len;
+		if (pgto + pglen > buf->page_len) {
+			talen = pgto + pglen - buf->page_len;
+			pglen -= talen;
+		}
+	} else {
+		pglen = len - to;
+		if (pglen > buf->page_len) {
+			talen = pglen - buf->page_len;
+			pglen = buf->page_len;
+		}
+	}
+
+	len -= talen;
+	base += len;
+	if (talen + tato > tail->iov_len)
+		talen = tail->iov_len > tato ? tail->iov_len - tato : 0;
+	memcpy(tail->iov_base + tato, head->iov_base + base, talen);
+
+	len -= pglen;
+	base -= pglen;
+	_copy_to_pages(buf->pages, buf->page_base + pgto, head->iov_base + base,
+		       pglen);
+
+	base -= len;
+	memmove(head->iov_base + to, head->iov_base + base, len);
+}
+
 static void xdr_buf_tail_shift_right(const struct xdr_buf *buf,
 				     unsigned int base, unsigned int len,
 				     unsigned int shift)
@@ -577,6 +624,25 @@ static void xdr_buf_pages_shift_right(const struct xdr_buf *buf,
 	xdr_buf_pages_copy_right(buf, base, len, shift);
 }
 
+static void xdr_buf_head_shift_right(const struct xdr_buf *buf,
+				     unsigned int base, unsigned int len,
+				     unsigned int shift)
+{
+	const struct kvec *head = buf->head;
+
+	if (!shift)
+		return;
+	if (base >= head->iov_len) {
+		xdr_buf_pages_shift_right(buf, head->iov_len - base, len,
+					  shift);
+		return;
+	}
+	if (base + len > head->iov_len)
+		xdr_buf_pages_shift_right(buf, 0, base + len - head->iov_len,
+					  shift);
+	xdr_buf_head_copy_right(buf, base, len, shift);
+}
+
 static void xdr_buf_tail_copy_left(const struct xdr_buf *buf, unsigned int base,
 				   unsigned int len, unsigned int shift)
 {
@@ -683,86 +749,31 @@ static void xdr_buf_pages_shift_left(const struct xdr_buf *buf,
 /**
  * xdr_shrink_bufhead
  * @buf: xdr_buf
- * @len: bytes to remove from buf->head[0]
+ * @len: new length of buf->head[0]
  *
- * Shrinks XDR buffer's header kvec buf->head[0] by
+ * Shrinks XDR buffer's header kvec buf->head[0], setting it to
  * 'len' bytes. The extra data is not lost, but is instead
  * moved into the inlined pages and/or the tail.
  */
-static unsigned int
-xdr_shrink_bufhead(struct xdr_buf *buf, size_t len)
+static unsigned int xdr_shrink_bufhead(struct xdr_buf *buf, unsigned int len)
 {
-	struct kvec *head, *tail;
-	size_t copy, offs;
-	unsigned int pglen = buf->page_len;
-	unsigned int result;
-
-	result = 0;
-	tail = buf->tail;
-	head = buf->head;
+	struct kvec *head = buf->head;
+	unsigned int shift, buflen = max(buf->len, len);
 
 	WARN_ON_ONCE(len > head->iov_len);
-	if (len > head->iov_len)
-		len = head->iov_len;
-
-	/* Shift the tail first */
-	if (tail->iov_len != 0) {
-		if (tail->iov_len > len) {
-			copy = tail->iov_len - len;
-			memmove((char *)tail->iov_base + len,
-					tail->iov_base, copy);
-			result += copy;
-		}
-		/* Copy from the inlined pages into the tail */
-		copy = len;
-		if (copy > pglen)
-			copy = pglen;
-		offs = len - copy;
-		if (offs >= tail->iov_len)
-			copy = 0;
-		else if (copy > tail->iov_len - offs)
-			copy = tail->iov_len - offs;
-		if (copy != 0) {
-			_copy_from_pages((char *)tail->iov_base + offs,
-					buf->pages,
-					buf->page_base + pglen + offs - len,
-					copy);
-			result += copy;
-		}
-		/* Do we also need to copy data from the head into the tail ? */
-		if (len > pglen) {
-			offs = copy = len - pglen;
-			if (copy > tail->iov_len)
-				copy = tail->iov_len;
-			memcpy(tail->iov_base,
-					(char *)head->iov_base +
-					head->iov_len - offs,
-					copy);
-			result += copy;
-		}
+	if (head->iov_len > buflen) {
+		buf->buflen -= head->iov_len - buflen;
+		head->iov_len = buflen;
 	}
-	/* Now handle pages */
-	if (pglen != 0) {
-		if (pglen > len)
-			_shift_data_right_pages(buf->pages,
-					buf->page_base + len,
-					buf->page_base,
-					pglen - len);
-		copy = len;
-		if (len > pglen)
-			copy = pglen;
-		_copy_to_pages(buf->pages, buf->page_base,
-				(char *)head->iov_base + head->iov_len - len,
-				copy);
-		result += copy;
-	}
-	head->iov_len -= len;
-	buf->buflen -= len;
-	/* Have we truncated the message? */
-	if (buf->len > buf->buflen)
-		buf->len = buf->buflen;
-
-	return result;
+	if (len >= head->iov_len)
+		return 0;
+	shift = head->iov_len - len;
+	xdr_buf_try_expand(buf, shift);
+	xdr_buf_head_shift_right(buf, len, buflen - len, shift);
+	head->iov_len = len;
+	buf->buflen -= shift;
+	buf->len -= shift;
+	return shift;
 }
 
 /**
@@ -798,7 +809,7 @@ static unsigned int xdr_shrink_pagelen(struct xdr_buf *buf, unsigned int len)
 void
 xdr_shift_buf(struct xdr_buf *buf, size_t len)
 {
-	xdr_shrink_bufhead(buf, len);
+	xdr_shrink_bufhead(buf, buf->head->iov_len - len);
 }
 EXPORT_SYMBOL_GPL(xdr_shift_buf);
 
@@ -1371,13 +1382,12 @@ static void xdr_realign_pages(struct xdr_stream *xdr)
 	struct xdr_buf *buf = xdr->buf;
 	struct kvec *iov = buf->head;
 	unsigned int cur = xdr_stream_pos(xdr);
-	unsigned int copied, offset;
+	unsigned int copied;
 
 	/* Realign pages to current pointer position */
 	if (iov->iov_len > cur) {
-		offset = iov->iov_len - cur;
-		copied = xdr_shrink_bufhead(buf, offset);
-		trace_rpc_xdr_alignment(xdr, offset, copied);
+		copied = xdr_shrink_bufhead(buf, cur);
+		trace_rpc_xdr_alignment(xdr, cur, copied);
 		xdr->nwords = XDR_QUADLEN(buf->len - cur);
 	}
 }
-- 
2.29.2

