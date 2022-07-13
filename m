Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624B8573CF7
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jul 2022 21:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbiGMTI6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jul 2022 15:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbiGMTIz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jul 2022 15:08:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AE315A31
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 12:08:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2487E61DC9
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 19:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2C6C341CA;
        Wed, 13 Jul 2022 19:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657739332;
        bh=ZXVyj+klF5+8XVdPkOoi7hu08hBRUWVSqWaG+aU8Hu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FzCluZv6lBeuME0dC5+PDYQCFTiFfsURNjLuTqHPe5+Tw3w3WQJ/qQoQnKntL2JZG
         EqJmggeT7QOJ3SmAVT+CoNMYCw0WF+tn/gAkFqDjESYV9YpjDGIwvqcy9ZPZkW2wU8
         gC1Li/A/q3Qq4UQ+gNkk2lqzf43yEwPjCKy9S5HlfrsZRsXLpuWd0FFifcGomJ7yY/
         lpPNjJIDeJSwc9zUnkYIocDNxTAuYPUR2SduqWR4ZceCzrf/N1/9OW3EfPZB4tsStU
         4japoplUhzoxCHgacOabRkPGNd285Wfn32oWFh77VhT85Upe8LmLnOCGN6MVLVyoTC
         SKI2mWNgoL0sw==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org
Subject: [PATCH v2 2/5] SUNRPC: Add a function for zeroing out a portion of an xdr_stream
Date:   Wed, 13 Jul 2022 15:08:46 -0400
Message-Id: <20220713190849.615778-3-anna@kernel.org>
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

This will be used during READ_PLUS decoding for handling HOLE segments.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 include/linux/sunrpc/xdr.h |  2 ++
 net/sunrpc/xdr.c           | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index b8f3011e109b..4fd208da1a5e 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -269,6 +269,8 @@ extern bool xdr_stream_subsegment(struct xdr_stream *xdr, struct xdr_buf *subbuf
 				  unsigned int len);
 extern unsigned int xdr_stream_move_subsegment(struct xdr_stream *xdr, unsigned int offset,
 					       unsigned int target, unsigned int length);
+extern unsigned int xdr_stream_zero(struct xdr_stream *xdr, unsigned int offset,
+				    unsigned int length);
 
 /**
  * xdr_set_scratch_buffer - Attach a scratch buffer for decoding data.
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 9d7c93645f01..5c9ba26875cf 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1804,6 +1804,29 @@ void xdr_buf_trim_head(struct xdr_buf *buf, unsigned int len)
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
2.37.0

