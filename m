Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E065A57D336
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jul 2022 20:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiGUSVp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jul 2022 14:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiGUSVn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jul 2022 14:21:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2180182117
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 11:21:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA34CB82622
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 18:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E0DC341CE;
        Thu, 21 Jul 2022 18:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658427699;
        bh=5gVy3UOK8O0QTv/b285IFCzYGj7S8sJU3VHZ/2qt80Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H8Cl/aSbLzHGJhEJy8PGADZ3oV8SY2YAJxV6BDPxKCdSnCW+HUBRrMdQ04o1Qvls5
         w9g7reD2n2cMQnwszfmXw4H+8ahbtTWjipnGP4aGLxzGWmobVU6SUPXIYHdW45fsGp
         tjUhLWxt7apo0UgBbO49DMviMNKo8JPU/YF5FomU//FyeCxH4rnvur/2UL/iOswyL7
         OLog9dnDpQbys6yAzjDbJNLqS4lFVFWTnqwWXfG4gFTxZctU4CcrvtKGKcRm9coHJ8
         XCStIBY+ps8O4qyaS4TS9Lc0HJz3zlKnzBLU/f00plhzV4yH+u9zBZLzcy+uwBR6Ov
         SU0ESXarRaD+A==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org
Subject: [PATCH v3 3/5] SUNRPC: Add a function for zeroing out a portion of an xdr_stream
Date:   Thu, 21 Jul 2022 14:21:33 -0400
Message-Id: <20220721182135.1885071-4-anna@kernel.org>
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

This will be used during READ_PLUS decoding for handling HOLE segments.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 include/linux/sunrpc/xdr.h |  2 ++
 net/sunrpc/xdr.c           | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 8cd38a9994ca..f0ab06acab61 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -265,6 +265,8 @@ extern bool xdr_stream_subsegment(struct xdr_stream *xdr, struct xdr_buf *subbuf
 				  unsigned int len);
 extern unsigned int xdr_stream_move_subsegment(struct xdr_stream *xdr, unsigned int offset,
 					       unsigned int target, unsigned int length);
+extern unsigned int xdr_stream_zero(struct xdr_stream *xdr, unsigned int offset,
+				    unsigned int length);
 
 /**
  * xdr_set_scratch_buffer - Attach a scratch buffer for decoding data.
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index e4ac700ca554..f09a7ab1a82b 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1769,6 +1769,29 @@ unsigned int xdr_stream_move_subsegment(struct xdr_stream *xdr, unsigned int off
 }
 EXPORT_SYMBOL_GPL(xdr_stream_move_subsegment);
 
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
2.37.1

