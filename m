Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66E552923B
	for <lists+linux-nfs@lfdr.de>; Mon, 16 May 2022 23:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348721AbiEPVBl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 May 2022 17:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348947AbiEPVBA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 May 2022 17:01:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C1D2ADB
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 13:35:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98118B81610
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 20:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256EAC36AE2;
        Mon, 16 May 2022 20:35:52 +0000 (UTC)
From:   Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v1 3/6] SUNRPC: Introduce xdr_buf_trim_head()
Date:   Mon, 16 May 2022 16:35:46 -0400
Message-Id: <20220516203549.2605575-4-Anna.Schumaker@Netapp.com>
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

The READ_PLUS operation uses a 32-bit length field for encoding a DATA
segment, but 64-bit length field for encoding a HOLE segment. When
setting up our reply buffer, we need to reserve enough space to encode
a HOLE before reading the file data and use this function if the first
segment turns out to be DATA.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 include/linux/sunrpc/xdr.h |  1 +
 net/sunrpc/xdr.c           | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index e502fe576813..344c820484ba 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -191,6 +191,7 @@ xdr_adjust_iovec(struct kvec *iov, __be32 *p)
 extern void xdr_shift_buf(struct xdr_buf *, size_t);
 extern void xdr_buf_from_iov(const struct kvec *, struct xdr_buf *);
 extern int xdr_buf_subsegment(const struct xdr_buf *, struct xdr_buf *, unsigned int, unsigned int);
+extern void xdr_buf_trim_head(struct xdr_buf *, unsigned int);
 extern void xdr_buf_trim(struct xdr_buf *, unsigned int);
 extern int read_bytes_from_xdr_buf(const struct xdr_buf *, unsigned int, void *, unsigned int);
 extern int write_bytes_to_xdr_buf(const struct xdr_buf *, unsigned int, void *, unsigned int);
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 87526bce9e15..3ecc444b27be 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1730,6 +1730,23 @@ unsigned int xdr_stream_move_segment(struct xdr_stream *xdr, unsigned int offset
 }
 EXPORT_SYMBOL_GPL(xdr_stream_move_segment);
 
+/**
+ * xdr_buf_trim_head - lop at most "len" bytes off the end of "buf"->head
+ * @buf: buf to be trimmed
+ * @len: number of bytes to reduce "buf"->head by
+ *
+ * Trim an xdr_buf->head by the given number of bytes by fixing up the lengths.
+ * Note that it's possible that we'll trim less than that amount if the
+ *  xdr_buf->head is too small.
+ */
+void xdr_buf_trim_head(struct xdr_buf *buf, unsigned int len)
+{
+	size_t trim = min_t(size_t, buf->head[0].iov_len, len);
+	buf->head[0].iov_len -= trim;
+	buf->len -= trim;
+}
+EXPORT_SYMBOL_GPL(xdr_buf_trim_head);
+
 /**
  * xdr_buf_trim - lop at most "len" bytes off the end of "buf"
  * @buf: buf to be trimmed
-- 
2.36.1

