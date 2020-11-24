Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96222C28B0
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Nov 2020 14:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388601AbgKXNub (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 08:50:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:44680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388575AbgKXNub (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Nov 2020 08:50:31 -0500
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3761520897
        for <linux-nfs@vger.kernel.org>; Tue, 24 Nov 2020 13:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606225830;
        bh=81c8hXVAexxERZg1aSClqsGHLBDQbE4w7uJ52QJYrmA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=vyMZSYcce+9lV1XFygpjq7kKwuhmgqiKs9MQBdS6ib6/ZIljgM3/qK/IA4UwKDVlW
         9e9zPWM+HfGboSUGa+BfRxHY+AunfOTWcp0OJQ+Es9aZ6FRO9w2sJtXKrUT3OZVXxj
         XWgu8D3zeW53A0Fv7GYVwFBMJPHPmwQvTwbZFy4Y=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 6/9] SUNRPC: Fix up xdr_set_page()
Date:   Tue, 24 Nov 2020 08:50:22 -0500
Message-Id: <20201124135025.1097571-7-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201124135025.1097571-6-trondmy@kernel.org>
References: <20201124135025.1097571-1-trondmy@kernel.org>
 <20201124135025.1097571-2-trondmy@kernel.org>
 <20201124135025.1097571-3-trondmy@kernel.org>
 <20201124135025.1097571-4-trondmy@kernel.org>
 <20201124135025.1097571-5-trondmy@kernel.org>
 <20201124135025.1097571-6-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

While we always want to align to the next page and/or the beginning of
the tail buffer when we call xdr_set_next_page(), the functions
xdr_align_data() and xdr_expand_hole() really want to align to the next
object in that next page or tail.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xdr.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 5a450055469f..ddd5cc2281ab 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1019,8 +1019,10 @@ static unsigned int xdr_set_page_base(struct xdr_stream *xdr,
 static void xdr_set_page(struct xdr_stream *xdr, unsigned int base,
 			 unsigned int len)
 {
-	if (xdr_set_page_base(xdr, base, len) == 0)
-		xdr_set_iov(xdr, xdr->buf->tail, 0, xdr_stream_remaining(xdr));
+	if (xdr_set_page_base(xdr, base, len) == 0) {
+		base -= xdr->buf->page_len;
+		xdr_set_iov(xdr, xdr->buf->tail, base, len);
+	}
 }
 
 static void xdr_set_next_page(struct xdr_stream *xdr)
@@ -1029,17 +1031,18 @@ static void xdr_set_next_page(struct xdr_stream *xdr)
 
 	newbase = (1 + xdr->page_ptr - xdr->buf->pages) << PAGE_SHIFT;
 	newbase -= xdr->buf->page_base;
-
-	xdr_set_page(xdr, newbase, PAGE_SIZE);
+	if (newbase < xdr->buf->page_len)
+		xdr_set_page_base(xdr, newbase, xdr_stream_remaining(xdr));
+	else
+		xdr_set_iov(xdr, xdr->buf->tail, 0, xdr_stream_remaining(xdr));
 }
 
 static bool xdr_set_next_buffer(struct xdr_stream *xdr)
 {
 	if (xdr->page_ptr != NULL)
 		xdr_set_next_page(xdr);
-	else if (xdr->iov == xdr->buf->head) {
-		xdr_set_page(xdr, 0, PAGE_SIZE);
-	}
+	else if (xdr->iov == xdr->buf->head)
+		xdr_set_page(xdr, 0, xdr_stream_remaining(xdr));
 	return xdr->p != xdr->end;
 }
 
@@ -1277,7 +1280,7 @@ uint64_t xdr_align_data(struct xdr_stream *xdr, uint64_t offset, uint32_t length
 	}
 
 	xdr->nwords -= XDR_QUADLEN(length);
-	xdr_set_page(xdr, from + length, PAGE_SIZE);
+	xdr_set_page(xdr, from + length, xdr_stream_remaining(xdr));
 	return length;
 }
 EXPORT_SYMBOL_GPL(xdr_align_data);
@@ -1314,7 +1317,7 @@ uint64_t xdr_expand_hole(struct xdr_stream *xdr, uint64_t offset, uint64_t lengt
 	_zero_pages(buf->pages, buf->page_base + offset, length);
 
 	buf->len += length - (from - offset) - truncated;
-	xdr_set_page(xdr, offset + length, PAGE_SIZE);
+	xdr_set_page(xdr, offset + length, xdr_stream_remaining(xdr));
 	return length;
 }
 EXPORT_SYMBOL_GPL(xdr_expand_hole);
-- 
2.28.0

