Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B6A573CF6
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jul 2022 21:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbiGMTJA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jul 2022 15:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236885AbiGMTIz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jul 2022 15:08:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736091EC5F
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 12:08:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F7D5B82130
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 19:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD55C341C0;
        Wed, 13 Jul 2022 19:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657739331;
        bh=MoEnAgAkrZFeK8lW3w10TAccR4+ENUqcgZQSw8DGZIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p1Lj2KxcAt9gn4C3dOx9zs7UF5n6mhZGJ80iA85/zacewAp65T5lkSnnTaqpnBeK9
         6pK6B0GmQy4TpZ6z9HfGOcFx+wW4R7LAzcVU8hwE6ldOb6YxT89pcwO7xje+8FLQtD
         ed9N/98YrwjeSwFQLXyWFC2ilJYw/aSslmDB596ZqRxe6709TFpwr+aNYlk07nnlYn
         e72iZmNLinJHHMtvE8eG3Tm2MjYX1lwqJQfqcwbJ3wEu5WZgj/POaXMNZXfHZD2dqd
         wERqgsEfpE+QNzes9juqC0At9DA1FXAZKZ0A59Xs+R0+cum8TsnS3PbJcRwBtlbX4o
         i/HH3QsPcqttg==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org
Subject: [PATCH v2 1/5] SUNRPC: Add a function for directly setting the xdr page len
Date:   Wed, 13 Jul 2022 15:08:45 -0400
Message-Id: <20220713190849.615778-2-anna@kernel.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220713190849.615778-1-anna@kernel.org>
References: <20220713190849.615778-1-anna@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 79824fea4529..b8f3011e109b 100644
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
index ea734b14af0f..9d7c93645f01 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1518,6 +1518,36 @@ unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len)
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
2.37.0

