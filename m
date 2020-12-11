Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A424C2D7CDF
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Dec 2020 18:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391813AbgLKR1z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Dec 2020 12:27:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395212AbgLKR0p (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 11 Dec 2020 12:26:45 -0500
From:   trondmy@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 07/15] SUNRPC: Cleanup - constify a number of xdr_buf helpers
Date:   Fri, 11 Dec 2020 12:25:13 -0500
Message-Id: <20201211172521.5567-8-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201211172521.5567-7-trondmy@kernel.org>
References: <20201211172521.5567-1-trondmy@kernel.org>
 <20201211172521.5567-2-trondmy@kernel.org>
 <20201211172521.5567-3-trondmy@kernel.org>
 <20201211172521.5567-4-trondmy@kernel.org>
 <20201211172521.5567-5-trondmy@kernel.org>
 <20201211172521.5567-6-trondmy@kernel.org>
 <20201211172521.5567-7-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

There are a number of xdr helpers for struct xdr_buf that do not change
the structure itself. Mark those as taking const pointers for
documentation purposes.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/sunrpc/xdr.h | 22 ++++++++--------
 net/sunrpc/xdr.c           | 53 +++++++++++++++++---------------------
 2 files changed, 35 insertions(+), 40 deletions(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 178f499e2283..68d49fdc4ee9 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -128,8 +128,8 @@ __be32 *xdr_decode_netobj(__be32 *p, struct xdr_netobj *);
 
 void	xdr_inline_pages(struct xdr_buf *, unsigned int,
 			 struct page **, unsigned int, unsigned int);
-void	xdr_terminate_string(struct xdr_buf *, const u32);
-size_t	xdr_buf_pagecount(struct xdr_buf *buf);
+void	xdr_terminate_string(const struct xdr_buf *, const u32);
+size_t	xdr_buf_pagecount(const struct xdr_buf *buf);
 int	xdr_alloc_bvec(struct xdr_buf *buf, gfp_t gfp);
 void	xdr_free_bvec(struct xdr_buf *buf);
 
@@ -182,14 +182,14 @@ xdr_adjust_iovec(struct kvec *iov, __be32 *p)
  * XDR buffer helper functions
  */
 extern void xdr_shift_buf(struct xdr_buf *, size_t);
-extern void xdr_buf_from_iov(struct kvec *, struct xdr_buf *);
-extern int xdr_buf_subsegment(struct xdr_buf *, struct xdr_buf *, unsigned int, unsigned int);
+extern void xdr_buf_from_iov(const struct kvec *, struct xdr_buf *);
+extern int xdr_buf_subsegment(const struct xdr_buf *, struct xdr_buf *, unsigned int, unsigned int);
 extern void xdr_buf_trim(struct xdr_buf *, unsigned int);
-extern int read_bytes_from_xdr_buf(struct xdr_buf *, unsigned int, void *, unsigned int);
-extern int write_bytes_to_xdr_buf(struct xdr_buf *, unsigned int, void *, unsigned int);
+extern int read_bytes_from_xdr_buf(const struct xdr_buf *, unsigned int, void *, unsigned int);
+extern int write_bytes_to_xdr_buf(const struct xdr_buf *, unsigned int, void *, unsigned int);
 
-extern int xdr_encode_word(struct xdr_buf *, unsigned int, u32);
-extern int xdr_decode_word(struct xdr_buf *, unsigned int, u32 *);
+extern int xdr_encode_word(const struct xdr_buf *, unsigned int, u32);
+extern int xdr_decode_word(const struct xdr_buf *, unsigned int, u32 *);
 
 struct xdr_array2_desc;
 typedef int (*xdr_xcode_elem_t)(struct xdr_array2_desc *desc, void *elem);
@@ -200,9 +200,9 @@ struct xdr_array2_desc {
 	xdr_xcode_elem_t xcode;
 };
 
-extern int xdr_decode_array2(struct xdr_buf *buf, unsigned int base,
+extern int xdr_decode_array2(const struct xdr_buf *buf, unsigned int base,
 			     struct xdr_array2_desc *desc);
-extern int xdr_encode_array2(struct xdr_buf *buf, unsigned int base,
+extern int xdr_encode_array2(const struct xdr_buf *buf, unsigned int base,
 			     struct xdr_array2_desc *desc);
 extern void _copy_from_pages(char *p, struct page **pages, size_t pgbase,
 			     size_t len);
@@ -251,7 +251,7 @@ extern void xdr_set_scratch_buffer(struct xdr_stream *xdr, void *buf, size_t buf
 extern __be32 *xdr_inline_decode(struct xdr_stream *xdr, size_t nbytes);
 extern unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len);
 extern void xdr_enter_page(struct xdr_stream *xdr, unsigned int len);
-extern int xdr_process_buf(struct xdr_buf *buf, unsigned int offset, unsigned int len, int (*actor)(struct scatterlist *, void *), void *data);
+extern int xdr_process_buf(const struct xdr_buf *buf, unsigned int offset, unsigned int len, int (*actor)(struct scatterlist *, void *), void *data);
 extern unsigned int xdr_align_data(struct xdr_stream *, unsigned int offset, unsigned int length);
 extern unsigned int xdr_expand_hole(struct xdr_stream *, unsigned int offset, unsigned int length);
 
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index f0444bf5617c..2e91fbd70f11 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -123,8 +123,7 @@ EXPORT_SYMBOL_GPL(xdr_decode_string_inplace);
  * @len: length of string, in bytes
  *
  */
-void
-xdr_terminate_string(struct xdr_buf *buf, const u32 len)
+void xdr_terminate_string(const struct xdr_buf *buf, const u32 len)
 {
 	char *kaddr;
 
@@ -134,8 +133,7 @@ xdr_terminate_string(struct xdr_buf *buf, const u32 len)
 }
 EXPORT_SYMBOL_GPL(xdr_terminate_string);
 
-size_t
-xdr_buf_pagecount(struct xdr_buf *buf)
+size_t xdr_buf_pagecount(const struct xdr_buf *buf)
 {
 	if (!buf->page_len)
 		return 0;
@@ -1545,8 +1543,7 @@ EXPORT_SYMBOL_GPL(xdr_enter_page);
 
 static const struct kvec empty_iov = {.iov_base = NULL, .iov_len = 0};
 
-void
-xdr_buf_from_iov(struct kvec *iov, struct xdr_buf *buf)
+void xdr_buf_from_iov(const struct kvec *iov, struct xdr_buf *buf)
 {
 	buf->head[0] = *iov;
 	buf->tail[0] = empty_iov;
@@ -1569,9 +1566,8 @@ EXPORT_SYMBOL_GPL(xdr_buf_from_iov);
  *
  * Returns -1 if base of length are out of bounds.
  */
-int
-xdr_buf_subsegment(struct xdr_buf *buf, struct xdr_buf *subbuf,
-			unsigned int base, unsigned int len)
+int xdr_buf_subsegment(const struct xdr_buf *buf, struct xdr_buf *subbuf,
+		       unsigned int base, unsigned int len)
 {
 	subbuf->buflen = subbuf->len = len;
 	if (base < buf->head[0].iov_len) {
@@ -1659,7 +1655,8 @@ void xdr_buf_trim(struct xdr_buf *buf, unsigned int len)
 }
 EXPORT_SYMBOL_GPL(xdr_buf_trim);
 
-static void __read_bytes_from_xdr_buf(struct xdr_buf *subbuf, void *obj, unsigned int len)
+static void __read_bytes_from_xdr_buf(const struct xdr_buf *subbuf,
+				      void *obj, unsigned int len)
 {
 	unsigned int this_len;
 
@@ -1676,7 +1673,8 @@ static void __read_bytes_from_xdr_buf(struct xdr_buf *subbuf, void *obj, unsigne
 }
 
 /* obj is assumed to point to allocated memory of size at least len: */
-int read_bytes_from_xdr_buf(struct xdr_buf *buf, unsigned int base, void *obj, unsigned int len)
+int read_bytes_from_xdr_buf(const struct xdr_buf *buf, unsigned int base,
+			    void *obj, unsigned int len)
 {
 	struct xdr_buf subbuf;
 	int status;
@@ -1689,7 +1687,8 @@ int read_bytes_from_xdr_buf(struct xdr_buf *buf, unsigned int base, void *obj, u
 }
 EXPORT_SYMBOL_GPL(read_bytes_from_xdr_buf);
 
-static void __write_bytes_to_xdr_buf(struct xdr_buf *subbuf, void *obj, unsigned int len)
+static void __write_bytes_to_xdr_buf(const struct xdr_buf *subbuf,
+				     void *obj, unsigned int len)
 {
 	unsigned int this_len;
 
@@ -1706,7 +1705,8 @@ static void __write_bytes_to_xdr_buf(struct xdr_buf *subbuf, void *obj, unsigned
 }
 
 /* obj is assumed to point to allocated memory of size at least len: */
-int write_bytes_to_xdr_buf(struct xdr_buf *buf, unsigned int base, void *obj, unsigned int len)
+int write_bytes_to_xdr_buf(const struct xdr_buf *buf, unsigned int base,
+			   void *obj, unsigned int len)
 {
 	struct xdr_buf subbuf;
 	int status;
@@ -1719,8 +1719,7 @@ int write_bytes_to_xdr_buf(struct xdr_buf *buf, unsigned int base, void *obj, un
 }
 EXPORT_SYMBOL_GPL(write_bytes_to_xdr_buf);
 
-int
-xdr_decode_word(struct xdr_buf *buf, unsigned int base, u32 *obj)
+int xdr_decode_word(const struct xdr_buf *buf, unsigned int base, u32 *obj)
 {
 	__be32	raw;
 	int	status;
@@ -1733,8 +1732,7 @@ xdr_decode_word(struct xdr_buf *buf, unsigned int base, u32 *obj)
 }
 EXPORT_SYMBOL_GPL(xdr_decode_word);
 
-int
-xdr_encode_word(struct xdr_buf *buf, unsigned int base, u32 obj)
+int xdr_encode_word(const struct xdr_buf *buf, unsigned int base, u32 obj)
 {
 	__be32	raw = cpu_to_be32(obj);
 
@@ -1743,9 +1741,8 @@ xdr_encode_word(struct xdr_buf *buf, unsigned int base, u32 obj)
 EXPORT_SYMBOL_GPL(xdr_encode_word);
 
 /* Returns 0 on success, or else a negative error code. */
-static int
-xdr_xcode_array2(struct xdr_buf *buf, unsigned int base,
-		 struct xdr_array2_desc *desc, int encode)
+static int xdr_xcode_array2(const struct xdr_buf *buf, unsigned int base,
+			    struct xdr_array2_desc *desc, int encode)
 {
 	char *elem = NULL, *c;
 	unsigned int copied = 0, todo, avail_here;
@@ -1937,9 +1934,8 @@ xdr_xcode_array2(struct xdr_buf *buf, unsigned int base,
 	return err;
 }
 
-int
-xdr_decode_array2(struct xdr_buf *buf, unsigned int base,
-		  struct xdr_array2_desc *desc)
+int xdr_decode_array2(const struct xdr_buf *buf, unsigned int base,
+		      struct xdr_array2_desc *desc)
 {
 	if (base >= buf->len)
 		return -EINVAL;
@@ -1948,9 +1944,8 @@ xdr_decode_array2(struct xdr_buf *buf, unsigned int base,
 }
 EXPORT_SYMBOL_GPL(xdr_decode_array2);
 
-int
-xdr_encode_array2(struct xdr_buf *buf, unsigned int base,
-		  struct xdr_array2_desc *desc)
+int xdr_encode_array2(const struct xdr_buf *buf, unsigned int base,
+		      struct xdr_array2_desc *desc)
 {
 	if ((unsigned long) base + 4 + desc->array_len * desc->elem_size >
 	    buf->head->iov_len + buf->page_len + buf->tail->iov_len)
@@ -1960,9 +1955,9 @@ xdr_encode_array2(struct xdr_buf *buf, unsigned int base,
 }
 EXPORT_SYMBOL_GPL(xdr_encode_array2);
 
-int
-xdr_process_buf(struct xdr_buf *buf, unsigned int offset, unsigned int len,
-		int (*actor)(struct scatterlist *, void *), void *data)
+int xdr_process_buf(const struct xdr_buf *buf, unsigned int offset,
+		    unsigned int len,
+		    int (*actor)(struct scatterlist *, void *), void *data)
 {
 	int i, ret = 0;
 	unsigned int page_len, thislen, page_offset;
-- 
2.29.2

