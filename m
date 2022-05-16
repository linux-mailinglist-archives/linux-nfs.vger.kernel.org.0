Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F197752921C
	for <lists+linux-nfs@lfdr.de>; Mon, 16 May 2022 23:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348920AbiEPVBr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 May 2022 17:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349217AbiEPVBI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 May 2022 17:01:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EADB867
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 13:36:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BAC06B81643
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 20:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACBEC34100;
        Mon, 16 May 2022 20:36:24 +0000 (UTC)
From:   Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v1 2/5] SUNRPC: Add a function for zeroing out a portion of an xdr_stream
Date:   Mon, 16 May 2022 16:36:19 -0400
Message-Id: <20220516203622.2605713-3-Anna.Schumaker@Netapp.com>
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

This will be used during READ_PLUS decoding for handling HOLE segments.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 include/linux/sunrpc/xdr.h |  2 ++
 net/sunrpc/xdr.c           | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 607340fa1fd4..d632fd170bf6 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -269,6 +269,8 @@ extern bool xdr_stream_subsegment(struct xdr_stream *xdr, struct xdr_buf *subbuf
 				  unsigned int len);
 extern unsigned int xdr_stream_move_segment(struct xdr_stream *xdr, unsigned int offset,
 					    unsigned int target, unsigned int length);
+extern unsigned int xdr_stream_zero(struct xdr_stream *xdr, unsigned int offset,
+				    unsigned int length);
 
 /**
  * xdr_set_scratch_buffer - Attach a scratch buffer for decoding data.
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index ff36a20aab89..7c7c4d360950 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1795,6 +1795,29 @@ void xdr_buf_trim_head(struct xdr_buf *buf, unsigned int len)
 }
 EXPORT_SYMBOL_GPL(xdr_buf_trim_head);
 
+/**
+ * xdr_stream_zero - zero out a portion of an xdr_stream
+ * @xdr: an xdr_stream to zero out
+ * @offset: the starting point in the stream
+ * @length: the number of bytes to zero
+ */
+unsigned int xdr_stream_zero(struct xdr_stream *xdr, unsigned int offset,
+			     unsigned int length)
+{
+	struct xdr_buf buf;
+
+	if (xdr_buf_subsegment(xdr->buf, &buf, offset, length) < 0)
+		return 0;
+	if (buf.head[0].iov_len)
+		xdr_buf_iov_zero(buf.head, 0, buf.head[0].iov_len);
+	if (buf.page_len > 0)
+		xdr_buf_pages_zero(&buf, 0, buf.page_len);
+	if (buf.tail[0].iov_len)
+		xdr_buf_iov_zero(buf.tail, 0, buf.tail[0].iov_len);
+	return length;
+}
+EXPORT_SYMBOL_GPL(xdr_stream_zero);
+
 /**
  * xdr_buf_trim - lop at most "len" bytes off the end of "buf"
  * @buf: buf to be trimmed
-- 
2.36.1

