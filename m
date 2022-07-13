Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C77C573CEB
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jul 2022 21:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiGMTIb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jul 2022 15:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiGMTIa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jul 2022 15:08:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774DD2CDEA
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 12:08:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0776961DC6
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 19:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAE0C3411E;
        Wed, 13 Jul 2022 19:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657739308;
        bh=OH9h/JTS87YVQ2CrWGISefPug2oRlihUAgfsHSj3hOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mHtqT6gvMMyqsLwxITvxgbOpSoiG/H6QQ1y4dzrPltiP9BFFxdG2lBvFsZaVkNoLh
         +EfjQYayG69C/74Txu7a6oxkDVcDvnuYXBCWomOrC4VYxbNYer/DaRyn07Zs578+sH
         zgRLV94f8mFOfOo2zsGIiVlVbjPRdIBgOp3JCeFCzJMJ+lnhUUZiOzpuP68bVZGyWZ
         orJh9tjVuEVJ1Amsut/9wVnxTssGEpq2lN/a//NoQ0nzl9R5eistlcbF5AKSXGm0nv
         jme4n+5DKZ5AgtUBfUWYG2upOzUVLYvFlqkGk/T7+S/AxzdzKCV0zSAikZKdjYhStV
         3lxWXomEl959g==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, chuck.lever@oracle.com
Cc:     anna@kernel.org
Subject: [PATCH v2 1/6] SUNRPC: Introduce xdr_stream_move_subsegment()
Date:   Wed, 13 Jul 2022 15:08:20 -0400
Message-Id: <20220713190825.615678-2-anna@kernel.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220713190825.615678-1-anna@kernel.org>
References: <20220713190825.615678-1-anna@kernel.org>
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
2.37.0

