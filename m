Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED830639837
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Nov 2022 21:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiKZUza (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 26 Nov 2022 15:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKZUz3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 26 Nov 2022 15:55:29 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE3B17AA6
        for <linux-nfs@vger.kernel.org>; Sat, 26 Nov 2022 12:55:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 53BEFCE0A4C
        for <linux-nfs@vger.kernel.org>; Sat, 26 Nov 2022 20:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73419C433D6
        for <linux-nfs@vger.kernel.org>; Sat, 26 Nov 2022 20:55:25 +0000 (UTC)
Subject: [PATCH 2/4] SUNRPC: Clean up xdr_write_pages()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sat, 26 Nov 2022 15:55:24 -0500
Message-ID: <166949612452.106845.16079864294324208424.stgit@klimt.1015granger.net>
In-Reply-To: <166949601705.106845.10614964159272504008.stgit@klimt.1015granger.net>
References: <166949601705.106845.10614964159272504008.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5.dev3+g9561319
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Make it more evident how xdr_write_pages() updates the tail buffer
by using the convention of naming the iov pointer variable "tail".
I spent more than a couple of hours chasing through code to
understand this, so someone is likely to find this useful later.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xdr.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 336a7c7833e4..f7767bf22406 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1224,30 +1224,34 @@ EXPORT_SYMBOL(xdr_restrict_buflen);
 /**
  * xdr_write_pages - Insert a list of pages into an XDR buffer for sending
  * @xdr: pointer to xdr_stream
- * @pages: list of pages
- * @base: offset of first byte
- * @len: length of data in bytes
+ * @pages: array of pages to insert
+ * @base: starting offset of first data byte in @pages
+ * @len: number of data bytes in @pages to insert
  *
+ * After the @pages are added, the tail iovec is instantiated pointing to
+ * end of the head buffer, and the stream is set up to encode subsequent
+ * items into the tail.
  */
 void xdr_write_pages(struct xdr_stream *xdr, struct page **pages, unsigned int base,
 		 unsigned int len)
 {
 	struct xdr_buf *buf = xdr->buf;
-	struct kvec *iov = buf->tail;
+	struct kvec *tail = buf->tail;
+
 	buf->pages = pages;
 	buf->page_base = base;
 	buf->page_len = len;
 
-	iov->iov_base = (char *)xdr->p;
-	iov->iov_len  = 0;
-	xdr->iov = iov;
+	tail->iov_base = xdr->p;
+	tail->iov_len = 0;
+	xdr->iov = tail;
 
 	if (len & 3) {
 		unsigned int pad = 4 - (len & 3);
 
 		BUG_ON(xdr->p >= xdr->end);
-		iov->iov_base = (char *)xdr->p + (len & 3);
-		iov->iov_len  += pad;
+		tail->iov_base = (char *)xdr->p + (len & 3);
+		tail->iov_len += pad;
 		len += pad;
 		*xdr->p++ = 0;
 	}


