Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400A22D44B7
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Dec 2020 15:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733106AbgLIOt3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Dec 2020 09:49:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:50666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733076AbgLIOt3 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 9 Dec 2020 09:49:29 -0500
From:   trondmy@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 08/16] SUNRPC: Avoid unnecessary copies in xdr_buf_pages_copy_left/right()
Date:   Wed,  9 Dec 2020 09:47:53 -0500
Message-Id: <20201209144801.700778-9-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209144801.700778-8-trondmy@kernel.org>
References: <20201209144801.700778-1-trondmy@kernel.org>
 <20201209144801.700778-2-trondmy@kernel.org>
 <20201209144801.700778-3-trondmy@kernel.org>
 <20201209144801.700778-4-trondmy@kernel.org>
 <20201209144801.700778-5-trondmy@kernel.org>
 <20201209144801.700778-6-trondmy@kernel.org>
 <20201209144801.700778-7-trondmy@kernel.org>
 <20201209144801.700778-8-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Moving data in the XDR page arrays can be expensive, since it can
involve touching up to a megabyte of data. Try to avoid doing so for the
case where the server returned less data than we preallocated.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xdr.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 7ca6208e7623..86a48c4cdcfc 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -600,14 +600,20 @@ static void xdr_buf_tail_shift_right(const struct xdr_buf *buf,
 static void xdr_buf_pages_shift_right(const struct xdr_buf *buf,
 				      unsigned int base, unsigned int shift)
 {
+	struct xdr_buf subbuf;
+
 	if (!shift)
 		return;
 	if (base >= buf->page_len) {
 		xdr_buf_tail_shift_right(buf, base - buf->page_len, shift);
 		return;
 	}
-	xdr_buf_tail_shift_right(buf, 0, shift);
-	xdr_buf_pages_copy_right(buf, base, shift);
+	base += buf->head->iov_len;
+	if (base >= buf->len)
+		return;
+	xdr_buf_subsegment(buf, &subbuf, base, buf->len - base);
+	xdr_buf_tail_shift_right(&subbuf, 0, shift);
+	xdr_buf_pages_copy_right(&subbuf, 0, shift);
 }
 
 static void xdr_buf_head_shift_right(const struct xdr_buf *buf,
@@ -710,14 +716,16 @@ static void xdr_buf_tail_shift_left(const struct xdr_buf *buf,
 static void xdr_buf_pages_shift_left(const struct xdr_buf *buf,
 				     unsigned int base, unsigned int shift)
 {
+	struct xdr_buf subbuf;
 	if (!shift)
 		return;
 	if (base >= buf->page_len) {
 		xdr_buf_tail_shift_left(buf, base - buf->page_len, shift);
 		return;
 	}
-	xdr_buf_pages_copy_left(buf, base, shift);
-	xdr_buf_tail_shift_left(buf, 0, shift);
+	xdr_buf_subsegment(buf, &subbuf, 0, buf->len);
+	xdr_buf_pages_copy_left(&subbuf, base, shift);
+	xdr_buf_tail_shift_left(&subbuf, 0, shift);
 }
 
 /**
-- 
2.29.2

