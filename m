Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06D22D7CCA
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Dec 2020 18:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395175AbgLKR0f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Dec 2020 12:26:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:50692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395211AbgLKR0D (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 11 Dec 2020 12:26:03 -0500
From:   trondmy@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 02/15] SUNRPC: Fixes for xdr_align_data()
Date:   Fri, 11 Dec 2020 12:25:08 -0500
Message-Id: <20201211172521.5567-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201211172521.5567-2-trondmy@kernel.org>
References: <20201211172521.5567-1-trondmy@kernel.org>
 <20201211172521.5567-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The main use case right now for xdr_align_data() is to shift the page
data to the left, and in practice shrink the total XDR data buffer.
This patch ensures that we fix up the accounting for the buffer length
as we shift that data around.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/sunrpc/xdr.h |   2 +-
 net/sunrpc/xdr.c           | 174 ++++++++++++++++++++++++++++---------
 2 files changed, 133 insertions(+), 43 deletions(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 9548d075e06d..2b4e44bb0654 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -252,7 +252,7 @@ extern __be32 *xdr_inline_decode(struct xdr_stream *xdr, size_t nbytes);
 extern unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len);
 extern void xdr_enter_page(struct xdr_stream *xdr, unsigned int len);
 extern int xdr_process_buf(struct xdr_buf *buf, unsigned int offset, unsigned int len, int (*actor)(struct scatterlist *, void *), void *data);
-extern uint64_t xdr_align_data(struct xdr_stream *, uint64_t, uint32_t);
+extern unsigned int xdr_align_data(struct xdr_stream *, unsigned int offset, unsigned int length);
 extern uint64_t xdr_expand_hole(struct xdr_stream *, uint64_t, uint64_t);
 
 /**
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 5833329c132c..c474339ba9ac 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -266,26 +266,6 @@ _shift_data_left_pages(struct page **pages, size_t pgto_base,
 	} while ((len -= copy) != 0);
 }
 
-static void
-_shift_data_left_tail(struct xdr_buf *buf, unsigned int pgto, size_t len)
-{
-	struct kvec *tail = buf->tail;
-
-	if (len > tail->iov_len)
-		len = tail->iov_len;
-
-	_copy_to_pages(buf->pages,
-		       buf->page_base + pgto,
-		       (char *)tail->iov_base,
-		       len);
-	tail->iov_len -= len;
-
-	if (tail->iov_len > 0)
-		memmove((char *)tail->iov_base,
-				tail->iov_base + len,
-				tail->iov_len);
-}
-
 /**
  * _shift_data_right_pages
  * @pages: vector of pages containing both the source and dest memory area.
@@ -516,6 +496,109 @@ _zero_pages(struct page **pages, size_t pgbase, size_t len)
 	} while ((len -= zero) != 0);
 }
 
+static void xdr_buf_tail_copy_left(const struct xdr_buf *buf, unsigned int base,
+				   unsigned int len, unsigned int shift)
+{
+	const struct kvec *tail = buf->tail;
+
+	if (base >= tail->iov_len)
+		return;
+	if (len > tail->iov_len - base)
+		len = tail->iov_len - base;
+	/* Shift data into head */
+	if (shift > buf->page_len + base) {
+		const struct kvec *head = buf->head;
+		unsigned int hdto =
+			head->iov_len + buf->page_len + base - shift;
+		unsigned int hdlen = len;
+
+		if (WARN_ONCE(shift > head->iov_len + buf->page_len + base,
+			      "SUNRPC: Misaligned data.\n"))
+			return;
+		if (hdto + hdlen > head->iov_len)
+			hdlen = head->iov_len - hdto;
+		memcpy(head->iov_base + hdto, tail->iov_base + base, hdlen);
+		base += hdlen;
+		len -= hdlen;
+		if (!len)
+			return;
+	}
+	/* Shift data into pages */
+	if (shift > base) {
+		unsigned int pgto = buf->page_len + base - shift;
+		unsigned int pglen = len;
+
+		if (pgto + pglen > buf->page_len)
+			pglen = buf->page_len - pgto;
+		_copy_to_pages(buf->pages, buf->page_base + pgto,
+			       tail->iov_base + base, pglen);
+		base += pglen;
+		len -= pglen;
+		if (!len)
+			return;
+	}
+	memmove(tail->iov_base + base - shift, tail->iov_base + base, len);
+}
+
+static void xdr_buf_pages_copy_left(const struct xdr_buf *buf,
+				    unsigned int base, unsigned int len,
+				    unsigned int shift)
+{
+	unsigned int pgto;
+
+	if (base >= buf->page_len)
+		return;
+	if (len > buf->page_len - base)
+		len = buf->page_len - base;
+	/* Shift data into head */
+	if (shift > base) {
+		const struct kvec *head = buf->head;
+		unsigned int hdto = head->iov_len + base - shift;
+		unsigned int hdlen = len;
+
+		if (WARN_ONCE(shift > head->iov_len + base,
+			      "SUNRPC: Misaligned data.\n"))
+			return;
+		if (hdto + hdlen > head->iov_len)
+			hdlen = head->iov_len - hdto;
+		_copy_from_pages(head->iov_base + hdto, buf->pages,
+				 buf->page_base + base, hdlen);
+		base += hdlen;
+		len -= hdlen;
+		if (!len)
+			return;
+	}
+	pgto = base - shift;
+	_shift_data_left_pages(buf->pages, buf->page_base + pgto,
+			       buf->page_base + base, len);
+}
+
+static void xdr_buf_tail_shift_left(const struct xdr_buf *buf,
+				    unsigned int base, unsigned int len,
+				    unsigned int shift)
+{
+	if (!shift || !len)
+		return;
+	xdr_buf_tail_copy_left(buf, base, len, shift);
+}
+
+static void xdr_buf_pages_shift_left(const struct xdr_buf *buf,
+				     unsigned int base, unsigned int len,
+				     unsigned int shift)
+{
+	if (!shift || !len)
+		return;
+	if (base >= buf->page_len) {
+		xdr_buf_tail_shift_left(buf, base - buf->page_len, len, shift);
+		return;
+	}
+	xdr_buf_pages_copy_left(buf, base, len, shift);
+	len += base;
+	if (len <= buf->page_len)
+		return;
+	xdr_buf_tail_copy_left(buf, 0, len - buf->page_len, shift);
+}
+
 /**
  * xdr_shrink_bufhead
  * @buf: xdr_buf
@@ -1261,38 +1344,45 @@ unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len)
 }
 EXPORT_SYMBOL_GPL(xdr_read_pages);
 
-uint64_t xdr_align_data(struct xdr_stream *xdr, uint64_t offset, uint32_t length)
+unsigned int xdr_align_data(struct xdr_stream *xdr, unsigned int offset,
+			    unsigned int length)
 {
 	struct xdr_buf *buf = xdr->buf;
-	unsigned int from, bytes;
-	unsigned int shift = 0;
-
-	if ((offset + length) < offset ||
-	    (offset + length) > buf->page_len)
-		length = buf->page_len - offset;
+	unsigned int from, bytes, len;
+	unsigned int shift;
 
 	xdr_realign_pages(xdr);
 	from = xdr_page_pos(xdr);
-	bytes = xdr_stream_remaining(xdr);
-	if (length < bytes)
-		bytes = length;
+
+	if (from >= buf->page_len + buf->tail->iov_len)
+		return 0;
+	if (from + buf->head->iov_len >= buf->len)
+		return 0;
+
+	len = buf->len - buf->head->iov_len;
+
+	/* We only shift data left! */
+	if (WARN_ONCE(from < offset, "SUNRPC: misaligned data src=%u dst=%u\n",
+		      from, offset))
+		return 0;
+	if (WARN_ONCE(offset > buf->page_len,
+		      "SUNRPC: buffer overflow. offset=%u, page_len=%u\n",
+		      offset, buf->page_len))
+		return 0;
 
 	/* Move page data to the left */
-	if (from > offset) {
-		shift = min_t(unsigned int, bytes, buf->page_len - from);
-		_shift_data_left_pages(buf->pages,
-				       buf->page_base + offset,
-				       buf->page_base + from,
-				       shift);
-		bytes -= shift;
+	shift = from - offset;
+	xdr_buf_pages_shift_left(buf, from, len, shift);
+	xdr->buf->len -= shift;
+	xdr->nwords -= XDR_QUADLEN(shift);
 
-		/* Move tail data into the pages, if necessary */
-		if (bytes > 0)
-			_shift_data_left_tail(buf, offset + shift, bytes);
-	}
+	bytes = xdr_stream_remaining(xdr);
+	if (length > bytes)
+		length = bytes;
+	bytes -= length;
 
 	xdr->nwords -= XDR_QUADLEN(length);
-	xdr_set_page(xdr, from + length, xdr_stream_remaining(xdr));
+	xdr_set_page(xdr, offset + length, bytes);
 	return length;
 }
 EXPORT_SYMBOL_GPL(xdr_align_data);
-- 
2.29.2

