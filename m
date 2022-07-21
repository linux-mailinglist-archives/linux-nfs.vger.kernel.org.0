Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3302357D335
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jul 2022 20:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiGUSVl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jul 2022 14:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiGUSVk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jul 2022 14:21:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A87582117
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 11:21:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35CD061FC8
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 18:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41465C341C0;
        Thu, 21 Jul 2022 18:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658427698;
        bh=mWaQeKFwusCVldo8R2eermzlT0tF5iUjW1pL24dk1x4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ssneteS0hzF5ILsy68kY1gFPiMrblrVDtzARlBXLouzb9CgrEIeWNOxDINbWfYtid
         /aYawLfmACbxdNGtmJL5PnWspFnO6u4vltenMsdwpVPh0lexDaq5nQvo2HOYfODbIo
         UrtO34VJ9GGbu7s1AzR3+hQkziBFVHlJEKMeaSl86sPCoLLy5JTYPkkjV/0M04ucev
         CKK+ia+0OWxnrsKsSoTbw0N8hs+pbLUJTcLd8U8LrIFkcrW8+TU1s5uwyL10tamk1o
         WCa3hJQPv5s+G7vOBrFMEHq0nJ0qSOusSOZj5Lmt9ZznEKEuBVKNLEYilIB3okCyCt
         e3U1e4nRw4Gwg==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org
Subject: [PATCH v3 2/5] SUNRPC: Add a function for directly setting the xdr page len
Date:   Thu, 21 Jul 2022 14:21:32 -0400
Message-Id: <20220721182135.1885071-3-anna@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220721182135.1885071-1-anna@kernel.org>
References: <20220721182135.1885071-1-anna@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 7dcc6c31fe29..8cd38a9994ca 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -258,6 +258,7 @@ extern __be32 *xdr_inline_decode(struct xdr_stream *xdr, size_t nbytes);
 extern unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len);
 extern void xdr_enter_page(struct xdr_stream *xdr, unsigned int len);
 extern int xdr_process_buf(const struct xdr_buf *buf, unsigned int offset, unsigned int len, int (*actor)(struct scatterlist *, void *), void *data);
+extern void xdr_set_pagelen(struct xdr_stream *, unsigned int len);
 extern unsigned int xdr_align_data(struct xdr_stream *, unsigned int offset, unsigned int length);
 extern unsigned int xdr_expand_hole(struct xdr_stream *, unsigned int offset, unsigned int length);
 extern bool xdr_stream_subsegment(struct xdr_stream *xdr, struct xdr_buf *subbuf,
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 8ba11a754297..e4ac700ca554 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1500,6 +1500,36 @@ unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len)
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
2.37.1

