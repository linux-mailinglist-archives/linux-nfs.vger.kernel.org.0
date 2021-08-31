Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450BE3FCD76
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Aug 2021 21:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240031AbhHaTGX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Aug 2021 15:06:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240163AbhHaTGS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 31 Aug 2021 15:06:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B157161041;
        Tue, 31 Aug 2021 19:05:22 +0000 (UTC)
Subject: [PATCH RFC 2/6] SUNRPC: xdr_stream_subsegment() must handle non-zero
 page_bases
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 31 Aug 2021 15:05:22 -0400
Message-ID: <163043672202.1415.7895822540426489041.stgit@klimt.1015granger.net>
In-Reply-To: <163043485613.1415.4979286233971984855.stgit@klimt.1015granger.net>
References: <163043485613.1415.4979286233971984855.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

xdr_stream_subsegment() was introduced in commit c1346a1216ab
("NFSD: Replace the internals of the READ_BUF() macro").

There are two call sites for xdr_stream_subsegment(). One is
nfsd4_decode_write(), and the other is nfsd4_decode_setxattr().
Currently neither of these call sites calls this API when
xdr_buf::page_base is a non-zero value.

However, I'm about to add a case where page_base will sometimes not
be zero when nfsd4_decode_write() invokes this API. Replace the
logic in xdr_stream_subsegment() that advances to the next data item
in the xdr_stream with something more generic in order to handle
this new use case.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xdr.c |   32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index ca10ba2626f2..df194cc07035 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1633,7 +1633,7 @@ EXPORT_SYMBOL_GPL(xdr_buf_subsegment);
  * Sets up @subbuf to represent a portion of @xdr. The portion
  * starts at the current offset in @xdr, and extends for a length
  * of @nbytes. If this is successful, @xdr is advanced to the next
- * position following that portion.
+ * XDR data item following that portion.
  *
  * Return values:
  *   %true: @subbuf has been initialized, and @xdr has been advanced.
@@ -1642,29 +1642,31 @@ EXPORT_SYMBOL_GPL(xdr_buf_subsegment);
 bool xdr_stream_subsegment(struct xdr_stream *xdr, struct xdr_buf *subbuf,
 			   unsigned int nbytes)
 {
-	unsigned int remaining, offset, len;
+	unsigned int start = xdr_stream_pos(xdr);
+	unsigned int remaining, len;
 
-	if (xdr_buf_subsegment(xdr->buf, subbuf, xdr_stream_pos(xdr), nbytes))
+	/* Extract @subbuf and bounds-check the fn arguments */
+	if (xdr_buf_subsegment(xdr->buf, subbuf, start, nbytes))
 		return false;
 
-	if (subbuf->head[0].iov_len)
-		if (!__xdr_inline_decode(xdr, subbuf->head[0].iov_len))
-			return false;
-
-	remaining = subbuf->page_len;
-	offset = subbuf->page_base;
-	while (remaining) {
-		len = min_t(unsigned int, remaining, PAGE_SIZE) - offset;
-
+	/* Advance @xdr by @nbytes */
+	for (remaining = nbytes; remaining;) {
 		if (xdr->p == xdr->end && !xdr_set_next_buffer(xdr))
 			return false;
-		if (!__xdr_inline_decode(xdr, len))
-			return false;
 
+		len = (char *)xdr->end - (char *)xdr->p;
+		if (remaining <= len) {
+			xdr->p = (__be32 *)((char *)xdr->p +
+					(remaining + xdr_pad_size(nbytes)));
+			break;
+		}
+
+		xdr->p = (__be32 *)((char *)xdr->p + len);
+		xdr->end = xdr->p;
 		remaining -= len;
-		offset = 0;
 	}
 
+	xdr_stream_set_pos(xdr, start + nbytes);
 	return true;
 }
 EXPORT_SYMBOL_GPL(xdr_stream_subsegment);


