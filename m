Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825E2573CFA
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jul 2022 21:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbiGMTJL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jul 2022 15:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236898AbiGMTI6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jul 2022 15:08:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD25F20F54
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 12:08:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26AB6B8212F
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 19:08:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665B6C341C0;
        Wed, 13 Jul 2022 19:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657739333;
        bh=EGEcbeldv7v0DFGbKs8GWbBOOtMo98ON6Zyw/hkcD4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sz+F2kQDNEqxHvPSea/l5w4wZkXe0IGFWyesqkK9SUpWGY1Z6wyQsTsyUHVpZmsaM
         A6ut2gLzzXN10/QMoIGjr43FbqOPH/sL/2OGeluDlSMZl+53lKG5ATPMgSCBvDcnnD
         9ifnE25cfSH9snd9jrRKOp7/wYs+0Osa7Mqv8HwDSB5R2XpCvadwqifwO8yjx9ybSa
         SU2FSpfzqVCPgjfR4cYrItxxn9wrBHvkvSknme43ij1QnmCZfwMzyo9YbU7Sti3XMT
         mAm5nHUAr5DCXbKDzFbtNLDl3Wg9nwooT68qemOj6BYt4Fp2Ff+7+eOs/blru7LZd2
         UBUyYlQAco7dw==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org
Subject: [PATCH v2 4/5] SUNRPC: Remove xdr_align_data() and xdr_expand_hole()
Date:   Wed, 13 Jul 2022 15:08:48 -0400
Message-Id: <20220713190849.615778-5-anna@kernel.org>
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

These functions are no longer needed now that the NFS client places data
and hole segments directly.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 include/linux/sunrpc/xdr.h |  2 --
 net/sunrpc/xdr.c           | 66 --------------------------------------
 2 files changed, 68 deletions(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 4fd208da1a5e..bc21e313e2e3 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -263,8 +263,6 @@ extern unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len);
 extern void xdr_enter_page(struct xdr_stream *xdr, unsigned int len);
 extern int xdr_process_buf(const struct xdr_buf *buf, unsigned int offset, unsigned int len, int (*actor)(struct scatterlist *, void *), void *data);
 extern void xdr_set_pagelen(struct xdr_stream *, unsigned int len);
-extern unsigned int xdr_align_data(struct xdr_stream *, unsigned int offset, unsigned int length);
-extern unsigned int xdr_expand_hole(struct xdr_stream *, unsigned int offset, unsigned int length);
 extern bool xdr_stream_subsegment(struct xdr_stream *xdr, struct xdr_buf *subbuf,
 				  unsigned int len);
 extern unsigned int xdr_stream_move_subsegment(struct xdr_stream *xdr, unsigned int offset,
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 5c9ba26875cf..6a3781b2f378 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1548,72 +1548,6 @@ void xdr_set_pagelen(struct xdr_stream *xdr, unsigned int len)
 }
 EXPORT_SYMBOL_GPL(xdr_set_pagelen);
 
-unsigned int xdr_align_data(struct xdr_stream *xdr, unsigned int offset,
-			    unsigned int length)
-{
-	struct xdr_buf *buf = xdr->buf;
-	unsigned int from, bytes, len;
-	unsigned int shift;
-
-	xdr_realign_pages(xdr);
-	from = xdr_page_pos(xdr);
-
-	if (from >= buf->page_len + buf->tail->iov_len)
-		return 0;
-	if (from + buf->head->iov_len >= buf->len)
-		return 0;
-
-	len = buf->len - buf->head->iov_len;
-
-	/* We only shift data left! */
-	if (WARN_ONCE(from < offset, "SUNRPC: misaligned data src=%u dst=%u\n",
-		      from, offset))
-		return 0;
-	if (WARN_ONCE(offset > buf->page_len,
-		      "SUNRPC: buffer overflow. offset=%u, page_len=%u\n",
-		      offset, buf->page_len))
-		return 0;
-
-	/* Move page data to the left */
-	shift = from - offset;
-	xdr_buf_pages_shift_left(buf, from, len, shift);
-
-	bytes = xdr_stream_remaining(xdr);
-	if (length > bytes)
-		length = bytes;
-	bytes -= length;
-
-	xdr->buf->len -= shift;
-	xdr_set_page(xdr, offset + length, bytes);
-	return length;
-}
-EXPORT_SYMBOL_GPL(xdr_align_data);
-
-unsigned int xdr_expand_hole(struct xdr_stream *xdr, unsigned int offset,
-			     unsigned int length)
-{
-	struct xdr_buf *buf = xdr->buf;
-	unsigned int from, to, shift;
-
-	xdr_realign_pages(xdr);
-	from = xdr_page_pos(xdr);
-	to = xdr_align_size(offset + length);
-
-	/* Could the hole be behind us? */
-	if (to > from) {
-		unsigned int buflen = buf->len - buf->head->iov_len;
-		shift = to - from;
-		xdr_buf_try_expand(buf, shift);
-		xdr_buf_pages_shift_right(buf, from, buflen, shift);
-		xdr_set_page(xdr, to, xdr_stream_remaining(xdr));
-	} else if (to != from)
-		xdr_align_data(xdr, to, 0);
-	xdr_buf_pages_zero(buf, offset, length);
-
-	return length;
-}
-EXPORT_SYMBOL_GPL(xdr_expand_hole);
-
 /**
  * xdr_enter_page - decode data from the XDR page
  * @xdr: pointer to xdr_stream struct
-- 
2.37.0

