Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDD45766DE
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Jul 2022 20:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiGOSoi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Jul 2022 14:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGOSoh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Jul 2022 14:44:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE27414D14
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 11:44:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80D7962340
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 18:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81983C385A5;
        Fri, 15 Jul 2022 18:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657910675;
        bh=/rdMpVPibNoV+V4UZpxODig15LN1SP1snCf7ckUe3vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D2Fc86nxGI1OMxQq1/uM4o5FSpFdeV4+BjyS8pZGefBwLODq/QJkez+K9SipYaFu8
         275KybF1SiYz1s3Zz+AsV7Ux+3NcIM9zGaFI3rs6D/FmHbTJb84twtAF440xwHMIS8
         0A4p+g6XP6NrY0QiOJp0sAEuOHkLpvJ/HSMjS57S/qPuXC/Mou1u9iIY/oIGQcLkpC
         VcXhjjoLMj1xsj0w3sTa9QQ/xRj/j/RQgAEf67ZXFW7s4F1Q6+QwqCKzH6ZhYJaIqS
         /2iU/x1XPb2WasD4rPkZj1Oysq1NAePDWUNzZ8XXkW45074L60EKHkY+D9US5lAIkU
         FwjaqxhM6SCiQ==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, chuck.lever@oracle.com
Cc:     anna@kernel.org
Subject: [PATCH v3 1/6] SUNRPC: Introduce xdr_stream_move_subsegment()
Date:   Fri, 15 Jul 2022 14:44:28 -0400
Message-Id: <20220715184433.838521-2-anna@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220715184433.838521-1-anna@kernel.org>
References: <20220715184433.838521-1-anna@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

I do this by creating an xdr subsegment for the range we will be
operating over. This lets me shift data to the correct place without
potentially overwriting anything already there.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 include/linux/sunrpc/xdr.h |  2 ++
 net/sunrpc/xdr.c           | 59 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 5860f32e3958..7dcc6c31fe29 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -262,6 +262,8 @@ extern unsigned int xdr_align_data(struct xdr_stream *, unsigned int offset, uns
 extern unsigned int xdr_expand_hole(struct xdr_stream *, unsigned int offset, unsigned int length);
 extern bool xdr_stream_subsegment(struct xdr_stream *xdr, struct xdr_buf *subbuf,
 				  unsigned int len);
+extern unsigned int xdr_stream_move_subsegment(struct xdr_stream *xdr, unsigned int offset,
+					       unsigned int target, unsigned int length);
 
 /**
  * xdr_set_scratch_buffer - Attach a scratch buffer for decoding data.
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 5d2b3e6979fb..8ba11a754297 100644
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
@@ -1680,6 +1708,37 @@ bool xdr_stream_subsegment(struct xdr_stream *xdr, struct xdr_buf *subbuf,
 }
 EXPORT_SYMBOL_GPL(xdr_stream_subsegment);
 
+/**
+ * xdr_stream_move_subsegment - Move part of a stream to another position
+ * @xdr: the source xdr_stream
+ * @offset: the source offset of the segment
+ * @target: the target offset of the segment
+ * @length: the number of bytes to move
+ *
+ * Moves @length bytes from @offset to @target in the xdr_stream, overwriting
+ * anything in its space. Returns the number of bytes in the segment.
+ */
+unsigned int xdr_stream_move_subsegment(struct xdr_stream *xdr, unsigned int offset,
+					unsigned int target, unsigned int length)
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
+EXPORT_SYMBOL_GPL(xdr_stream_move_subsegment);
+
 /**
  * xdr_buf_trim - lop at most "len" bytes off the end of "buf"
  * @buf: buf to be trimmed
-- 
2.37.1

