Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3826315F2B1
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2020 19:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbgBNPu2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Feb 2020 10:50:28 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33309 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730469AbgBNPu1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Feb 2020 10:50:27 -0500
Received: by mail-yb1-f195.google.com with SMTP id b6so4974142ybr.0;
        Fri, 14 Feb 2020 07:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=UHr7Egb239EH8xYPRJJNLMkIYC7QjqSp3fLfoqGYkbo=;
        b=bH2TjtkuGmyZ9RQT/dpqSYS3GxyEQFaVeyOzTpUFSlsZNWqU6vAgk2VD1/pzVsKzY3
         W5ADw+7f0fVRZhYZWXAWKVWloowH29UosCmiINpPq6nUhlSFaLGDfPmvuLh5ykx1LNG8
         8652RoR+/SdZ3AXwUjI6j2KnbLLG1gxvv1F8JLteMJfLZXAkrP34IkJMFQvJxnpuq8nt
         JPL0MswytQ125Tvz6IkFRWppDjEI4F802lCRsUNub5kd60TUjglJNvGMZT3QG/o4+jrw
         Khdd8DJv/ZeSYNipRVefBr3DYmb2UQpHiX5aBU+GFCorDPxHqMiJbql8j4OplIJHn7oQ
         HNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=UHr7Egb239EH8xYPRJJNLMkIYC7QjqSp3fLfoqGYkbo=;
        b=lnnkp2l0KPezUxwyVT1JvjkbBxzROSfcPQXg21gYq66vhFCMKxmMLj5eVJB/JnO0jY
         GWkAQ26MEIRTHACoTZWuliLWvmd2fR68plqG1PJj1NoK3YPnxVqs0ZIwd6xqW34g3kEo
         6Cttbkg6+K6Ry8lJmSJFmru8X1Oa1ycfNSXxrq+B2JRV90btSwRfDosPZzcFeiztnEJC
         BVZyx+bPbaSKmpK4eYoBAiU9tr30c8vlx923obuBC5orxXt0xvL1olV7ajDjT2EsSDes
         StMGXtv3jpcNZk7nVziS0BY8rBar9E88DAxLt7mgRmYfG96Nl1LF5RfzmPcKxdpEZpnC
         GR2g==
X-Gm-Message-State: APjAAAUzJBt3NOSaABJgOnl0BbmWO2Riq5rnTxXAdPz4cTeh0GDBApc5
        9ryfc/+gdUPAYp2V9Dyq1G9SUvm9
X-Google-Smtp-Source: APXvYqwOyrXE9iE96+z2QS8eWrDoaz3BtMwqe8sJkdU+SNedSrTr/eg8FN9f29sCgNDBGLb4B1zzYg==
X-Received: by 2002:a25:2c02:: with SMTP id s2mr3020157ybs.155.1581695426106;
        Fri, 14 Feb 2020 07:50:26 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d13sm2547484ywj.91.2020.02.14.07.50.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 07:50:25 -0800 (PST)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 01EFoOkN029181;
        Fri, 14 Feb 2020 15:50:24 GMT
Subject: [PATCH RFC 8/9] svcrdma: Refactor svc_rdma_sendto()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 14 Feb 2020 10:50:24 -0500
Message-ID: <20200214155024.3848.32817.stgit@klimt.1015granger.net>
In-Reply-To: <20200214151427.3848.49739.stgit@klimt.1015granger.net>
References: <20200214151427.3848.49739.stgit@klimt.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

No behavior change expected, just preparing for subsequent patches.

Pass the RPC request's svc_rdma_recv_ctxt deeper into the sendto()
path. This will enable us to subsequent pass more information about
the Reply into those lower-level functions.

Since we're touching the synopses of these functions, let's also
change the header encoding to work like other areas: Instead of
walking over the beginning of the header when encoding each
chunk list, use the "p = xdr_encode_blob(p);" style that is
consistent with most other XDR-related code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h       |    2 -
 net/sunrpc/xprtrdma/svc_rdma_rw.c     |   12 ++--
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   98 ++++++++++++++-------------------
 3 files changed, 50 insertions(+), 62 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 07baeb5f93c1..c1c4563066d9 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -178,7 +178,7 @@ extern int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
 				     unsigned int offset,
 				     unsigned long length);
 extern int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
-				     __be32 *rp_ch, bool writelist,
+				     const struct svc_rdma_recv_ctxt *rctxt,
 				     struct xdr_buf *xdr);
 
 /* svc_rdma_sendto.c */
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index b0ac535c8728..ca9d414bef9d 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -545,8 +545,7 @@ int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma, __be32 *wr_ch,
 /**
  * svc_rdma_send_reply_chunk - Write all segments in the Reply chunk
  * @rdma: controlling RDMA transport
- * @rp_ch: Reply chunk provided by client
- * @writelist: true if client provided a Write list
+ * @rctxt: chunk list information
  * @xdr: xdr_buf containing an RPC Reply
  *
  * Returns a non-negative number of bytes the chunk consumed, or
@@ -556,13 +555,14 @@ int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma, __be32 *wr_ch,
  *	%-ENOTCONN if posting failed (connection is lost),
  *	%-EIO if rdma_rw initialization failed (DMA mapping, etc).
  */
-int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma, __be32 *rp_ch,
-			      bool writelist, struct xdr_buf *xdr)
+int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
+			      const struct svc_rdma_recv_ctxt *rctxt,
+			      struct xdr_buf *xdr)
 {
 	struct svc_rdma_write_info *info;
 	int consumed, ret;
 
-	info = svc_rdma_write_info_alloc(rdma, rp_ch);
+	info = svc_rdma_write_info_alloc(rdma, rctxt->rc_reply_chunk);
 	if (!info)
 		return -ENOMEM;
 
@@ -574,7 +574,7 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma, __be32 *rp_ch,
 	/* Send the page list in the Reply chunk only if the
 	 * client did not provide Write chunks.
 	 */
-	if (!writelist && xdr->page_len) {
+	if (!rctxt->rc_write_list && xdr->page_len) {
 		ret = svc_rdma_send_xdr_pagelist(info, xdr,
 						 xdr->head[0].iov_len,
 						 xdr->page_len);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 273453a336b0..7349a3f9aa5d 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -354,6 +354,14 @@ static unsigned int svc_rdma_reply_hdr_len(__be32 *rdma_resp)
 	return (unsigned long)p - (unsigned long)rdma_resp;
 }
 
+/* RPC-over-RDMA V1 replies never have a Read list.
+ */
+static __be32 *xdr_encode_read_list(__be32 *p)
+{
+	*p++ = xdr_zero;
+	return p;
+}
+
 /* One Write chunk is copied from Call transport header to Reply
  * transport header. Each segment's length field is updated to
  * reflect number of bytes consumed in the segment.
@@ -406,16 +414,17 @@ static unsigned int xdr_encode_write_chunk(__be32 *dst, __be32 *src,
  * Assumptions:
  *  - Client has provided only one Write chunk
  */
-static void svc_rdma_xdr_encode_write_list(__be32 *rdma_resp, __be32 *wr_ch,
-					   unsigned int consumed)
+static __be32 *xdr_encode_write_list(__be32 *p,
+				     const struct svc_rdma_recv_ctxt *rctxt)
 {
-	unsigned int nsegs;
-	__be32 *p, *q;
+	unsigned int consumed, nsegs;
+	__be32 *q;
 
-	/* RPC-over-RDMA V1 replies never have a Read list. */
-	p = rdma_resp + rpcrdma_fixed_maxsz + 1;
+	q = rctxt->rc_write_list;
+	if (!q)
+		goto out;
 
-	q = wr_ch;
+	consumed = rctxt->rc_read_payload_length;
 	while (*q != xdr_zero) {
 		nsegs = xdr_encode_write_chunk(p, q, consumed);
 		q += 2 + nsegs * rpcrdma_segment_maxsz;
@@ -424,10 +433,9 @@ static void svc_rdma_xdr_encode_write_list(__be32 *rdma_resp, __be32 *wr_ch,
 	}
 
 	/* Terminate Write list */
+out:
 	*p++ = xdr_zero;
-
-	/* Reply chunk discriminator; may be replaced later */
-	*p = xdr_zero;
+	return p;
 }
 
 /* The client provided a Reply chunk in the Call message. Fill in
@@ -435,23 +443,13 @@ static void svc_rdma_xdr_encode_write_list(__be32 *rdma_resp, __be32 *wr_ch,
  * number of bytes consumed in each segment.
  *
  * Assumptions:
- * - Reply can always fit in the provided Reply chunk
+ * - Reply can always fit in the client-provided Reply chunk
  */
-static void svc_rdma_xdr_encode_reply_chunk(__be32 *rdma_resp, __be32 *rp_ch,
-					    unsigned int consumed)
+static void xdr_encode_reply_chunk(__be32 *p,
+				   const struct svc_rdma_recv_ctxt *rctxt,
+				   unsigned int length)
 {
-	__be32 *p;
-
-	/* Find the Reply chunk in the Reply's xprt header.
-	 * RPC-over-RDMA V1 replies never have a Read list.
-	 */
-	p = rdma_resp + rpcrdma_fixed_maxsz + 1;
-
-	/* Skip past Write list */
-	while (*p++ != xdr_zero)
-		p += 1 + be32_to_cpup(p) * rpcrdma_segment_maxsz;
-
-	xdr_encode_write_chunk(p, rp_ch, consumed);
+	xdr_encode_write_chunk(p, rctxt->rc_reply_chunk, length);
 }
 
 static int svc_rdma_dma_map_page(struct svcxprt_rdma *rdma,
@@ -735,15 +733,15 @@ static void svc_rdma_save_io_pages(struct svc_rqst *rqstp,
  */
 static int svc_rdma_send_reply_msg(struct svcxprt_rdma *rdma,
 				   struct svc_rdma_send_ctxt *sctxt,
-				   struct svc_rdma_recv_ctxt *rctxt,
-				   struct svc_rqst *rqstp,
-				   __be32 *wr_lst, __be32 *rp_ch)
+				   const struct svc_rdma_recv_ctxt *rctxt,
+				   struct svc_rqst *rqstp)
 {
 	int ret;
 
-	if (!rp_ch) {
+	if (!rctxt->rc_reply_chunk) {
 		ret = svc_rdma_map_reply_msg(rdma, sctxt,
-					     &rqstp->rq_res, wr_lst);
+					     &rqstp->rq_res,
+					     rctxt->rc_write_list);
 		if (ret < 0)
 			return ret;
 	}
@@ -808,16 +806,12 @@ static int svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
  */
 int svc_rdma_sendto(struct svc_rqst *rqstp)
 {
-	struct svc_xprt *xprt = rqstp->rq_xprt;
 	struct svcxprt_rdma *rdma =
-		container_of(xprt, struct svcxprt_rdma, sc_xprt);
+		container_of(rqstp->rq_xprt, struct svcxprt_rdma, sc_xprt);
 	struct svc_rdma_recv_ctxt *rctxt = rqstp->rq_xprt_ctxt;
 	__be32 *rdma_argp = rctxt->rc_recv_buf;
-	__be32 *wr_lst = rctxt->rc_write_list;
-	__be32 *rp_ch = rctxt->rc_reply_chunk;
-	struct xdr_buf *xdr = &rqstp->rq_res;
 	struct svc_rdma_send_ctxt *sctxt;
-	__be32 *p, *rdma_resp;
+	__be32 *p;
 	int ret;
 
 	/* Create the RDMA response header. xprt->xpt_mutex,
@@ -830,32 +824,26 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	sctxt = svc_rdma_send_ctxt_get(rdma);
 	if (!sctxt)
 		goto err0;
-	rdma_resp = sctxt->sc_xprt_buf;
 
-	p = rdma_resp;
+	p = sctxt->sc_xprt_buf;
 	*p++ = *rdma_argp;
 	*p++ = *(rdma_argp + 1);
 	*p++ = rdma->sc_fc_credits;
-	*p++ = rp_ch ? rdma_nomsg : rdma_msg;
+	*p++ = rctxt->rc_reply_chunk ? rdma_nomsg : rdma_msg;
 
-	/* Start with empty chunks */
-	*p++ = xdr_zero;
-	*p++ = xdr_zero;
-	*p   = xdr_zero;
-
-	if (wr_lst)
-		svc_rdma_xdr_encode_write_list(rdma_resp, wr_lst,
-					       rctxt->rc_read_payload_length);
-	if (rp_ch) {
-		ret = svc_rdma_send_reply_chunk(rdma, rp_ch, wr_lst, xdr);
+	p = xdr_encode_read_list(p);
+	p = xdr_encode_write_list(p, rctxt);
+	if (rctxt->rc_reply_chunk) {
+		ret = svc_rdma_send_reply_chunk(rdma, rctxt, &rqstp->rq_res);
 		if (ret < 0)
 			goto err2;
-		svc_rdma_xdr_encode_reply_chunk(rdma_resp, rp_ch, ret);
-	}
+		xdr_encode_reply_chunk(p, rctxt, ret);
+	} else
+		*p = xdr_zero;
 
-	svc_rdma_sync_reply_hdr(rdma, sctxt, svc_rdma_reply_hdr_len(rdma_resp));
-	ret = svc_rdma_send_reply_msg(rdma, sctxt, rctxt, rqstp,
-				      wr_lst, rp_ch);
+	svc_rdma_sync_reply_hdr(rdma, sctxt,
+				svc_rdma_reply_hdr_len(sctxt->sc_xprt_buf));
+	ret = svc_rdma_send_reply_msg(rdma, sctxt, rctxt, rqstp);
 	if (ret < 0)
 		goto err1;
 	ret = 0;
@@ -879,7 +867,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	svc_rdma_send_ctxt_put(rdma, sctxt);
  err0:
 	trace_svcrdma_send_failed(rqstp, ret);
-	set_bit(XPT_CLOSE, &xprt->xpt_flags);
+	set_bit(XPT_CLOSE, &rqstp->rq_xprt->xpt_flags);
 	ret = -ENOTCONN;
 	goto out;
 }

