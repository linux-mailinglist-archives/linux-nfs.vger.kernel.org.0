Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27036529242
	for <lists+linux-nfs@lfdr.de>; Mon, 16 May 2022 23:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240349AbiEPVCJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 May 2022 17:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349209AbiEPVBI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 May 2022 17:01:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A835B85E
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 13:36:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53F86B8160F
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 20:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BDFC34115;
        Mon, 16 May 2022 20:36:23 +0000 (UTC)
From:   Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v1 1/5] SUNRPC: Add a function for directly setting the xdr page len
Date:   Mon, 16 May 2022 16:36:18 -0400
Message-Id: <20220516203622.2605713-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220516203622.2605713-1-Anna.Schumaker@Netapp.com>
References: <20220516203622.2605713-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

We need to do this step during READ_PLUS decoding so that we know pages
are the right length and any extra data has been preserved in the tail.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 include/linux/sunrpc/xdr.h |  1 +
 net/sunrpc/xdr.c           | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index b375b284afbe..607340fa1fd4 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -262,6 +262,7 @@ extern __be32 *xdr_inline_decode(struct xdr_stream *xdr, size_t nbytes);
 extern unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len);
 extern void xdr_enter_page(struct xdr_stream *xdr, unsigned int len);
 extern int xdr_process_buf(const struct xdr_buf *buf, unsigned int offset, unsigned int len, int (*actor)(struct scatterlist *, void *), void *data);
+extern void xdr_set_pagelen(struct xdr_stream *, unsigned int len);
 extern unsigned int xdr_align_data(struct xdr_stream *, unsigned int offset, unsigned int length);
 extern unsigned int xdr_expand_hole(struct xdr_stream *, unsigned int offset, unsigned int length);
 extern bool xdr_stream_subsegment(struct xdr_stream *xdr, struct xdr_buf *subbuf,
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index d71c90552fa2..ff36a20aab89 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1509,6 +1509,36 @@ unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len)
 }
 EXPORT_SYMBOL_GPL(xdr_read_pages);
 
+/**
+ * xdr_set_pagelen - Sets the length of the XDR pages
+ * @xdr: pointer to xdr_stream struct
+ * @len: new length of the XDR page data
+ *
+ * Either grows or shrinks the length of the xdr pages by setting pagelen to
+ * @len bytes. When shrinking, any extra data is moved into buf->tail, whereas
+ * when growing any data beyond the current pointer is moved into the tail.
+ *
+ * Returns True if the operation was successful, and False otherwise.
+ */
+void xdr_set_pagelen(struct xdr_stream *xdr, unsigned int len)
+{
+	struct xdr_buf *buf = xdr->buf;
+	size_t remaining = xdr_stream_remaining(xdr);
+	size_t base = 0;
+
+	if (len < buf->page_len) {
+		base = buf->page_len - len;
+		xdr_shrink_pagelen(buf, len);
+	} else {
+		xdr_buf_head_shift_right(buf, xdr_stream_pos(xdr),
+					 buf->page_len, remaining);
+		if (len > buf->page_len)
+			xdr_buf_try_expand(buf, len - buf->page_len);
+	}
+	xdr_set_tail_base(xdr, base, remaining);
+}
+EXPORT_SYMBOL_GPL(xdr_set_pagelen);
+
 unsigned int xdr_align_data(struct xdr_stream *xdr, unsigned int offset,
 			    unsigned int length)
 {
-- 
2.36.1

