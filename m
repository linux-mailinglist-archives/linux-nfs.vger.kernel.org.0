Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0286D573CEE
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jul 2022 21:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbiGMTIg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jul 2022 15:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236502AbiGMTIf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jul 2022 15:08:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4D62BF
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 12:08:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B00BFB82130
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 19:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C304C341C6;
        Wed, 13 Jul 2022 19:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657739309;
        bh=z6eXA65BD09Jyev3T8fHrTGmJnWKOLPXSDRw9hwPTyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c0JoZKQSo8uhlvcRvMlTS7cvzOqpQYkpvumnvhQPsjkOzUdjSgG0aYmRglXLJmnqr
         IiMc7XziWtcPBuJl3gqhoOsofQxm4aETwlIT7RA5QnXr1I8ctxSrrPYVr4OnXwFTdu
         Tncp49BxJDG7T8zyKtp+njv9PZOsY7Xa7xoMfT7Jo2aVvLxIVfJDdjtulI1S6tyc+s
         +K6NQakJsM4hcIAmGxzWW4SUYRzqke8zE3D0eB28XmVvdjei4DshBOVCfgvBnu1Ohk
         pMR9n8GfKQ9uFCz7Q+THvpI9+qtLhJT6BuPFLdwh/NS0rrqjh8bUX3yfYEp3ObTnEj
         OONYTBgaZ727Q==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, chuck.lever@oracle.com
Cc:     anna@kernel.org
Subject: [PATCH v2 3/6] SUNRPC: Introduce xdr_buf_trim_head()
Date:   Wed, 13 Jul 2022 15:08:22 -0400
Message-Id: <20220713190825.615678-4-anna@kernel.org>
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
index e26047d474b2..bdaf048edde0 100644
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
index 63d9cdc989da..37956a274f81 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1739,6 +1739,23 @@ unsigned int xdr_stream_move_subsegment(struct xdr_stream *xdr, unsigned int off
 }
 EXPORT_SYMBOL_GPL(xdr_stream_move_subsegment);
 
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
2.37.0

