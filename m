Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB3D529258
	for <lists+linux-nfs@lfdr.de>; Mon, 16 May 2022 23:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348537AbiEPVCE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 May 2022 17:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348993AbiEPVBC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 May 2022 17:01:02 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B192AD0
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 13:35:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0C781CE17F9
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 20:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2361AC34100;
        Mon, 16 May 2022 20:35:51 +0000 (UTC)
From:   Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v1 1/6] SUNRPC: Introduce xdr_stream_move_segment()
Date:   Mon, 16 May 2022 16:35:44 -0400
Message-Id: <20220516203549.2605575-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220516203549.2605575-1-Anna.Schumaker@Netapp.com>
References: <20220516203549.2605575-1-Anna.Schumaker@Netapp.com>
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

I do this by creating an xdr subsegment for the range we will be
operating over. This lets me shift data to the correct place without
potentially overwriting anything outside the region.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 include/linux/sunrpc/xdr.h |  2 ++
 net/sunrpc/xdr.c           | 59 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 4417f667c757..04d47a096f8a 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -262,6 +262,8 @@ extern unsigned int xdr_align_data(struct xdr_stream *, unsigned int offset, uns
 extern unsigned int xdr_expand_hole(struct xdr_stream *, unsigned int offset, unsigned int length);
 extern bool xdr_stream_subsegment(struct xdr_stream *xdr, struct xdr_buf *subbuf,
 				  unsigned int len);
+extern unsigned int xdr_stream_move_segment(struct xdr_stream *xdr, unsigned int offset,
+					    unsigned int target, unsigned int length);
 
 /**
  * xdr_set_scratch_buffer - Attach a scratch buffer for decoding data.
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index df194cc07035..26559c08f68f 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -775,6 +775,34 @@ static void xdr_buf_pages_shift_left(const struct xdr_buf *buf,
 	xdr_buf_tail_copy_left(buf, 0, len - buf->page_len, shift);
 }
 
+static void xdr_buf_head_shift_left(const struct xdr_buf *buf,
+				    unsigned int base, unsigned int len,
+				    unsigned int shift)
+{
+	const struct kvec *head = buf->head;
+	unsigned int bytes;
+
+	if (!shift || !len)
+		return;
+
+	if (shift > base) {
+		bytes = (shift - base);
+		if (bytes >= len)
+			return;
+		base += bytes;
+		len -= bytes;
+	}
+
+	if (base < head->iov_len) {
+		bytes = min_t(unsigned int, len, head->iov_len - base);
+		memmove(head->iov_base + (base - shift),
+			head->iov_base + base, bytes);
+		base += bytes;
+		len -= bytes;
+	}
+	xdr_buf_pages_shift_left(buf, base - head->iov_len, len, shift);
+}
+
 /**
  * xdr_shrink_bufhead
  * @buf: xdr_buf
@@ -1671,6 +1699,37 @@ bool xdr_stream_subsegment(struct xdr_stream *xdr, struct xdr_buf *subbuf,
 }
 EXPORT_SYMBOL_GPL(xdr_stream_subsegment);
 
+/**
+ * xdr_stream_move_segment - Move part of a stream to another position
+ * @xdr: the source xdr_stream
+ * @offset: the source offset of the segment
+ * @target: the target offset of the segment
+ * @length: the number of bytes to move
+ *
+ * Moves @length bytes from @offset to @target in the xdr_stream, overwriting
+ * anything in its space. Returns the number of bytes in the segment.
+ */
+unsigned int xdr_stream_move_segment(struct xdr_stream *xdr, unsigned int offset,
+				     unsigned int target, unsigned int length)
+{
+	struct xdr_buf buf;
+	unsigned int shift;
+
+	if (offset < target) {
+		shift = target - offset;
+		if (xdr_buf_subsegment(xdr->buf, &buf, offset, shift + length) < 0)
+			return 0;
+		xdr_buf_head_shift_right(&buf, 0, length, shift);
+	} else if (offset > target) {
+		shift = offset - target;
+		if (xdr_buf_subsegment(xdr->buf, &buf, target, shift + length) < 0)
+			return 0;
+		xdr_buf_head_shift_left(&buf, shift, length, shift);
+	}
+	return length;
+}
+EXPORT_SYMBOL_GPL(xdr_stream_move_segment);
+
 /**
  * xdr_buf_trim - lop at most "len" bytes off the end of "buf"
  * @buf: buf to be trimmed
-- 
2.36.1

