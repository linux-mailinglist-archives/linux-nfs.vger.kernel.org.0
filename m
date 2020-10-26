Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6C12995F4
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Oct 2020 19:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781671AbgJZSy2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Oct 2020 14:54:28 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41274 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781485AbgJZSy2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Oct 2020 14:54:28 -0400
Received: by mail-qt1-f193.google.com with SMTP id z33so7511343qth.8;
        Mon, 26 Oct 2020 11:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=QupHDxG9OyvXv5W0PToGomC+N8agkcUWuF2MeaqeYdo=;
        b=Gs7X3+70Gf30pYKl5L5yOWIECGijXesF87gSaYtNSwxT9hQZ5+ft9pEtpo+XTRq8cB
         frFkD8tzUIDvHzQmtpIDTR5txsl2qGyC7HWMbjO7Lu++Eyen8KUK7hMIkHYmQP4cuvlj
         Y1bXvKZJnl1lpcAt1vBB9st2j68DJre//MxUEOoGQasWs3mNLnI1B0Bk3jpvCNVok2Sr
         zuA3hakXiv6D1Wb1OHAxfIfHsXaX8qmqqjb3vcK8rOPVsvezniKOsnuj7jy8XzGu/MXK
         bhzy/T8ZNwDaFPp7Pg2xMpIRAMhPkL2qVY/E0Vdpc/R26h7jRjyHYRA77zixD0efAikH
         Pz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=QupHDxG9OyvXv5W0PToGomC+N8agkcUWuF2MeaqeYdo=;
        b=ZPtDFfi6j3FGDAaKlxK4vl0iF5WCH8CTJYIWbaFukX2zDR25XRdI4MIeYR/UZFX7td
         ML9/bnKCvQK9i9Ji8GSLDkiDYA1EK4RfXUNcdIgJBCydzwGGx5Lhn9YeYvpobAletcNx
         drTlEjKml6I/11+nI7XSOeCYDJ7lqLh1k2WqZfGk1toc2r3zQy5NEJWnqoJdNsDS1Gbh
         d7aPb4/C1pWO4LoNjSv50Bi1xyfat0COBVV5K+Cw3Z97zbqbve20KbszMTZRChe3CXAv
         TlXRRDbw4UnizF4t5DmtHCyZ1XWg2gxtzksi85mx2CJAH8WSgmiyuwtbpR8Z8hQWsGN9
         1/Ug==
X-Gm-Message-State: AOAM532UmkkN5nVrIsu53f6i4G+qcYyy5PW+ZFynfOHDC7yW0HnMzSp7
        A5NwP4X2rP8DBaxxDhdyuclpre8tbK4=
X-Google-Smtp-Source: ABdhPJxBFoIiV+mXsoSLb5WjXaZxhb/wH/7C4v2Ygi9bS6Fvwzi8XSh3wFeYacVFPBUEBM8zTYYMDw==
X-Received: by 2002:ac8:4808:: with SMTP id g8mr17621071qtq.18.1603738466678;
        Mon, 26 Oct 2020 11:54:26 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q38sm7687156qtc.56.2020.10.26.11.54.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 11:54:25 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 09QIsOs0013631;
        Mon, 26 Oct 2020 18:54:24 GMT
Subject: [PATCH 06/20] svcrdma: Post RDMA Writes while XDR encoding replies
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 26 Oct 2020 14:54:24 -0400
Message-ID: <160373846482.1886.10871991261377476320.stgit@klimt.1015granger.net>
In-Reply-To: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
References: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The only RPC/RDMA ordering requirement between RDMA Writes and RDMA
Sends is that the responder must post the Writes on the Send queue
before posting the Send that conveys the RPC Reply for that Write
payload.

The Linux NFS server implementation now has a transport method that
can post result Payload Writes earlier than svc_rdma_sendto:

   ->xpo_result_payload()

This gets RDMA Writes going earlier so they are more likely to be
complete at the remote end before the Send completes.

Some care must be taken with pulled-up Replies. We don't want to
push the Write chunk and then send the same payload data via Send.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h       |    4 +-
 net/sunrpc/xprtrdma/svc_rdma_rw.c     |   52 +++++++++++++++++++++++------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   59 ++++++++++++++++++---------------
 3 files changed, 75 insertions(+), 40 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 2b870a3f391b..f5a3c852bb90 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -183,9 +183,7 @@ extern int svc_rdma_recv_read_chunk(struct svcxprt_rdma *rdma,
 				    struct svc_rqst *rqstp,
 				    struct svc_rdma_recv_ctxt *head, __be32 *p);
 extern int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
-				     __be32 *wr_ch, struct xdr_buf *xdr,
-				     unsigned int offset,
-				     unsigned long length);
+				     __be32 *wr_ch, const struct xdr_buf *xdr);
 extern int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 				     const struct svc_rdma_recv_ctxt *rctxt,
 				     struct xdr_buf *xdr);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 03c32b441d32..d732785d0380 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -536,13 +536,49 @@ static int svc_rdma_pages_write(struct svc_rdma_write_info *info,
 				     length);
 }
 
+/**
+ * svc_rdma_xb_write - Construct RDMA Writes to write an xdr_buf
+ * @xdr: xdr_buf to write
+ * @info: pointer to write arguments
+ *
+ * Returns:
+ *   On succes, returns zero
+ *   %-E2BIG if the client-provided Write chunk is too small
+ *   %-ENOMEM if a resource has been exhausted
+ *   %-EIO if an rdma-rw error occurred
+ */
+static int svc_rdma_xb_write(const struct xdr_buf *xdr,
+			     struct svc_rdma_write_info *info)
+{
+	int ret;
+
+	if (xdr->head[0].iov_len) {
+		ret = svc_rdma_iov_write(info, &xdr->head[0]);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (xdr->page_len) {
+		ret = svc_rdma_pages_write(info, xdr, xdr->head[0].iov_len,
+					   xdr->page_len);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (xdr->tail[0].iov_len) {
+		ret = svc_rdma_iov_write(info, &xdr->tail[0]);
+		if (ret < 0)
+			return ret;
+	}
+
+	return xdr->len;
+}
+
 /**
  * svc_rdma_send_write_chunk - Write all segments in a Write chunk
  * @rdma: controlling RDMA transport
  * @wr_ch: Write chunk provided by client
  * @xdr: xdr_buf containing the data payload
- * @offset: payload's byte offset in @xdr
- * @length: size of payload, in bytes
  *
  * Returns a non-negative number of bytes the chunk consumed, or
  *	%-E2BIG if the payload was larger than the Write chunk,
@@ -552,21 +588,17 @@ static int svc_rdma_pages_write(struct svc_rdma_write_info *info,
  *	%-EIO if rdma_rw initialization failed (DMA mapping, etc).
  */
 int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma, __be32 *wr_ch,
-			      struct xdr_buf *xdr,
-			      unsigned int offset, unsigned long length)
+			      const struct xdr_buf *xdr)
 {
 	struct svc_rdma_write_info *info;
 	int ret;
 
-	if (!length)
-		return 0;
-
 	info = svc_rdma_write_info_alloc(rdma, wr_ch);
 	if (!info)
 		return -ENOMEM;
 
-	ret = svc_rdma_pages_write(info, xdr, offset, length);
-	if (ret < 0)
+	ret = svc_rdma_xb_write(xdr, info);
+	if (ret != xdr->len)
 		goto out_err;
 
 	ret = svc_rdma_post_chunk_ctxt(&info->wi_cc);
@@ -574,7 +606,7 @@ int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma, __be32 *wr_ch,
 		goto out_err;
 
 	trace_svcrdma_send_write_chunk(xdr->page_len);
-	return length;
+	return xdr->len;
 
 out_err:
 	svc_rdma_write_info_free(info);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index d6436c13d5c4..fb6ba1177fd8 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -468,11 +468,14 @@ svc_rdma_encode_write_list(const struct svc_rdma_recv_ctxt *rctxt,
 {
 	ssize_t len, ret;
 
-	ret = svc_rdma_encode_write_chunk(rctxt->rc_write_list, sctxt,
-					  rctxt->rc_read_payload_length);
-	if (ret < 0)
-		return ret;
-	len = ret;
+	len = 0;
+	if (rctxt->rc_write_list) {
+		ret = svc_rdma_encode_write_chunk(rctxt->rc_write_list, sctxt,
+						  rctxt->rc_read_payload_length);
+		if (ret < 0)
+			return ret;
+		len = ret;
+	}
 
 	/* Terminate the Write list */
 	ret = xdr_stream_encode_item_absent(&sctxt->sc_stream);
@@ -556,11 +559,13 @@ static bool svc_rdma_pull_up_needed(struct svcxprt_rdma *rdma,
 				    const struct svc_rdma_recv_ctxt *rctxt,
 				    struct xdr_buf *xdr)
 {
+	bool write_chunk_present = rctxt && rctxt->rc_write_list;
 	int elements;
 
 	/* For small messages, copying bytes is cheaper than DMA mapping.
 	 */
-	if (sctxt->sc_hdrbuf.len + xdr->len < RPCRDMA_PULLUP_THRESH)
+	if (!write_chunk_present &&
+	    sctxt->sc_hdrbuf.len + xdr->len < RPCRDMA_PULLUP_THRESH)
 		return true;
 
 	/* Check whether the xdr_buf has more elements than can
@@ -893,9 +898,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 		container_of(xprt, struct svcxprt_rdma, sc_xprt);
 	struct svc_rdma_recv_ctxt *rctxt = rqstp->rq_xprt_ctxt;
 	__be32 *rdma_argp = rctxt->rc_recv_buf;
-	__be32 *wr_lst = rctxt->rc_write_list;
 	__be32 *rp_ch = rctxt->rc_reply_chunk;
-	struct xdr_buf *xdr = &rqstp->rq_res;
 	struct svc_rdma_send_ctxt *sctxt;
 	__be32 *p;
 	int ret;
@@ -920,19 +923,8 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 
 	if (svc_rdma_encode_read_list(sctxt) < 0)
 		goto err0;
-	if (wr_lst) {
-		/* XXX: Presume the client sent only one Write chunk */
-		ret = svc_rdma_send_write_chunk(rdma, wr_lst, xdr,
-						rctxt->rc_read_payload_offset,
-						rctxt->rc_read_payload_length);
-		if (ret < 0)
-			goto err2;
-		if (svc_rdma_encode_write_list(rctxt, sctxt) < 0)
-			goto err0;
-	} else {
-		if (xdr_stream_encode_item_absent(&sctxt->sc_stream) < 0)
-			goto err0;
-	}
+	if (svc_rdma_encode_write_list(rctxt, sctxt) < 0)
+		goto err0;
 	if (rp_ch) {
 		ret = svc_rdma_send_reply_chunk(rdma, rctxt, &rqstp->rq_res);
 		if (ret < 0)
@@ -974,16 +966,25 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
  * @offset: payload's byte offset in @xdr
  * @length: size of payload, in bytes
  *
- * Returns zero on success.
- *
- * For the moment, just record the xdr_buf location of the result
- * payload. svc_rdma_sendto will use that location later when
- * we actually send the payload.
+ * Return values:
+ *   On success, returns the number of bytes in the payload
+ *   If nothing needs to be done, returns zero
+ *   %-EMSGSIZE on XDR buffer overflow
+ *   %-E2BIG if the payload was larger than the Write chunk
+ *   %-EINVAL if client provided too many segments
+ *   %-ENOMEM if rdma_rw context pool was exhausted
+ *   %-ENOTCONN if posting failed (connection is lost)
+ *   %-EIO if rdma_rw initialization failed (DMA mapping, etc)
  */
 int svc_rdma_result_payload(struct svc_rqst *rqstp, unsigned int offset,
 			    unsigned int length)
 {
 	struct svc_rdma_recv_ctxt *rctxt = rqstp->rq_xprt_ctxt;
+	struct svcxprt_rdma *rdma;
+	struct xdr_buf subbuf;
+
+	if (!rctxt->rc_write_list || !length)
+		return 0;
 
 	/* XXX: Just one READ payload slot for now, since our
 	 * transport implementation currently supports only one
@@ -992,5 +993,9 @@ int svc_rdma_result_payload(struct svc_rqst *rqstp, unsigned int offset,
 	rctxt->rc_read_payload_offset = offset;
 	rctxt->rc_read_payload_length = length;
 
-	return 0;
+	if (xdr_buf_subsegment(&rqstp->rq_res, &subbuf, offset, length))
+		return -EMSGSIZE;
+
+	rdma = container_of(rqstp->rq_xprt, struct svcxprt_rdma, sc_xprt);
+	return svc_rdma_send_write_chunk(rdma, rctxt->rc_write_list, &subbuf);
 }


