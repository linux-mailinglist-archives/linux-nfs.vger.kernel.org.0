Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8621F65B58D
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jan 2023 18:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236346AbjABRHW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Jan 2023 12:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236520AbjABRHK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Jan 2023 12:07:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B157B861
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 09:07:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07B1B60018
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:07:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E51FC433D2
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672679228;
        bh=C0x96nQASVt+axlnBmA/K3jSzXD1dHwRfjwPnZqK7NM=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=cJPH8mjOJDAghumubZXlriUaYlZXYHeNgPrr6Xi95XvO/Gzya0iBXjp8d5S2uk9F1
         U1kdK4cXmUBGGkVIVEC5pXKd4BboSqJJwNIQRWeskrqsx+fxONabQIXe1mwQ6lKXRU
         FVRtUUkwkA9go6LjoVL/GXHh/CXrYj+a8EnC0Jsf8lZ2OLMvmHll89JtD78ZQPmEk8
         GuqVx/AH9CHRtrYBXhnz51S/Wzh+LPuhmcrkqnSfqvxrpQb6KcxIaqD/v9+V03HOuH
         Arz6bjYV+QLN65x+tKY/YvaYQw3ChGOz67f6s9KtBD+roIA8bz5h3O+duEXJBXZ3jj
         0jVoVBItrvB0g==
Subject: [PATCH v1 16/25] SUNRPC: Convert unwrap_priv_data() to use xdr_stream
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 02 Jan 2023 12:07:07 -0500
Message-ID: <167267922728.112521.2176591481507062449.stgit@manet.1015granger.net>
In-Reply-To: <167267753484.112521.4826748148788735127.stgit@manet.1015granger.net>
References: <167267753484.112521.4826748148788735127.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Done as part of hardening the server-side RPC header decoding path.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/xdr.h        |    1 -
 net/sunrpc/auth_gss/svcauth_gss.c |   65 ++++++++++++-------------------------
 net/sunrpc/xdr.c                  |    7 ----
 3 files changed, 21 insertions(+), 52 deletions(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index accfe8d6e283..884df67009f4 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -188,7 +188,6 @@ xdr_adjust_iovec(struct kvec *iov, __be32 *p)
 /*
  * XDR buffer helper functions
  */
-extern void xdr_shift_buf(struct xdr_buf *, size_t);
 extern void xdr_buf_from_iov(const struct kvec *, struct xdr_buf *);
 extern int xdr_buf_subsegment(const struct xdr_buf *, struct xdr_buf *, unsigned int, unsigned int);
 extern void xdr_buf_trim(struct xdr_buf *, unsigned int);
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 8f91768d0be0..074bfe9fb838 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -982,17 +982,6 @@ total_buf_len(struct xdr_buf *buf)
 	return buf->head[0].iov_len + buf->page_len + buf->tail[0].iov_len;
 }
 
-static void
-fix_priv_head(struct xdr_buf *buf, int pad)
-{
-	if (buf->page_len == 0) {
-		/* We need to adjust head and buf->len in tandem in this
-		 * case to make svc_defer() work--it finds the original
-		 * buffer start using buf->len - buf->head[0].iov_len. */
-		buf->head[0].iov_len -= pad;
-	}
-}
-
 /*
  * RFC 2203, Section 5.3.2.3
  *
@@ -1005,49 +994,37 @@ fix_priv_head(struct xdr_buf *buf, int pad)
  *		proc_req_arg_t arg;
  *	};
  */
-static int
-svcauth_gss_unwrap_priv(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq,
-			struct gss_ctx *ctx)
+static noinline_for_stack int
+svcauth_gss_unwrap_priv(struct svc_rqst *rqstp, u32 seq, struct gss_ctx *ctx)
 {
-	u32 len, seq_num, maj_stat;
-	int pad, remaining_len, offset;
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
+	u32 len, maj_stat, seq_num, offset;
+	struct xdr_buf *buf = xdr->buf;
+	unsigned int saved_len;
 
 	__clear_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
 
-	len = svc_getnl(&buf->head[0]);
+	if (xdr_stream_decode_u32(xdr, &len) < 0)
+		goto unwrap_failed;
 	if (rqstp->rq_deferred) {
 		/* Already decrypted last time through! The sequence number
 		 * check at out_seq is unnecessary but harmless: */
 		goto out_seq;
 	}
-	/* buf->len is the number of bytes from the original start of the
-	 * request to the end, where head[0].iov_len is just the bytes
-	 * not yet read from the head, so these two values are different: */
-	remaining_len = total_buf_len(buf);
-	if (len > remaining_len)
+	if (len > xdr_stream_remaining(xdr))
 		goto unwrap_failed;
-	pad = remaining_len - len;
-	buf->len -= pad;
-	fix_priv_head(buf, pad);
-
-	maj_stat = gss_unwrap(ctx, 0, len, buf);
-	pad = len - buf->len;
-	/* The upper layers assume the buffer is aligned on 4-byte boundaries.
-	 * In the krb5p case, at least, the data ends up offset, so we need to
-	 * move it around. */
-	/* XXX: This is very inefficient.  It would be better to either do
-	 * this while we encrypt, or maybe in the receive code, if we can peak
-	 * ahead and work out the service and mechanism there. */
-	offset = xdr_pad_size(buf->head[0].iov_len);
-	if (offset) {
-		buf->buflen = RPCSVC_MAXPAYLOAD;
-		xdr_shift_buf(buf, offset);
-		fix_priv_head(buf, pad);
-	}
+	offset = xdr_stream_pos(xdr);
+
+	saved_len = buf->len;
+	maj_stat = gss_unwrap(ctx, offset, offset + len, buf);
 	if (maj_stat != GSS_S_COMPLETE)
 		goto bad_unwrap;
+	xdr->nwords -= XDR_QUADLEN(saved_len - buf->len);
+
 out_seq:
-	seq_num = svc_getnl(&buf->head[0]);
+	/* gss_unwrap() decrypted the sequence number. */
+	if (xdr_stream_decode_u32(xdr, &seq_num) < 0)
+		goto unwrap_failed;
 	if (seq_num != seq)
 		goto bad_seqno;
 	return 0;
@@ -1689,11 +1666,11 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 			/* placeholders for length and seq. number: */
 			svc_putnl(resv, 0);
 			svc_putnl(resv, 0);
-			if (svcauth_gss_unwrap_priv(rqstp, &rqstp->rq_arg,
-						    gc->gc_seq, rsci->mechctx))
+			svcxdr_init_decode(rqstp);
+			if (svcauth_gss_unwrap_priv(rqstp, gc->gc_seq,
+						    rsci->mechctx))
 				goto garbage_args;
 			rqstp->rq_auth_slack = RPC_MAX_AUTH_SIZE * 2;
-			svcxdr_init_decode(rqstp);
 			break;
 		default:
 			goto auth_err;
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index c7e89921d511..56d87c784c9e 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -863,13 +863,6 @@ static unsigned int xdr_shrink_pagelen(struct xdr_buf *buf, unsigned int len)
 	return shift;
 }
 
-void
-xdr_shift_buf(struct xdr_buf *buf, size_t len)
-{
-	xdr_shrink_bufhead(buf, buf->head->iov_len - len);
-}
-EXPORT_SYMBOL_GPL(xdr_shift_buf);
-
 /**
  * xdr_stream_pos - Return the current offset from the start of the xdr_stream
  * @xdr: pointer to struct xdr_stream


