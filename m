Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEFD218BAE1
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2020 16:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgCSPUt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Mar 2020 11:20:49 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34405 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgCSPUt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Mar 2020 11:20:49 -0400
Received: by mail-qk1-f194.google.com with SMTP id f3so3465044qkh.1;
        Thu, 19 Mar 2020 08:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=vN2rA0AcWEDMwd9QdhqOqb4NZAXp+ArWLgjdCEOp1tc=;
        b=gg4FsZzBRQZbimoD6T0dQwLD6gJodg4OUqUwzKyM3dX3LhaiaTUQzOxGd2ROLRO0BM
         BW/OcA4AXk7XYebfaaA7elk1yaup/kNDpx8mDOANgZErEc0i4BzwXiAhVSOHCMyzylMC
         +eK8A7S10nuK6m/ArYbku5dM6QKfYNQLzUHIqpGSUOc9DVuQZQdjGQz7NhDKLz1USvDY
         c4yeyJ3CprYPImyryS3wNJu3+x9lZFbjwyPIYuMAFGHe8AT2x+vAIJz4VHoqX7aYiCcL
         XshSoDq6hw54LIwG6XU6DyCg4nhCeMZw/91gMwVsksoHE8g7TThjiIPzkhEZJJ+T52pP
         OsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=vN2rA0AcWEDMwd9QdhqOqb4NZAXp+ArWLgjdCEOp1tc=;
        b=Fq4ZQbSNQu2qQzMSDNXNcLdEIqAtiulWeAathTLrevcleV5jf5rP2Pmfyzt9mJq4EO
         iYWpp47gxyZf3wnMbF7jPRGsOPwSHxjYTjLXVvQrHUKHlKntGBliThHGTFTC6emihSTC
         tYJGQsnIvyYsAIUDaEMJ0oODe0WNDL/jeNuNc8EKbLXcpOAx/L4siQYUkdmO3tKp1DNT
         96940bcpPSRCwDvdeDPTjIVdw9ezjSPdfNyU5Q/vja/IJ+gSiAudshBEOENusN2u88qz
         qJ0WB4uzMyuvI/ORgPwslH2OiRGzmD0Mhb3cRCuMPLtG0KGzVbKB4WFXJO0TCB0SPuHA
         8Vxw==
X-Gm-Message-State: ANhLgQ3+bRgfCZKUEb7D0kKxIIvYOMARDLEHTuJOOOaJ0JE+9hSm8fzH
        Qepc+TlpPRL956MqWrUW76fzYicNy/k=
X-Google-Smtp-Source: ADFU+vt+zZDGE3+yVq5SVz6fUzEXc3I63oFWmqdoIFrHKBRkJpJtirfHDnJJms+KN9dnULf96oeMXg==
X-Received: by 2002:a37:391:: with SMTP id 139mr3475752qkd.6.1584631246160;
        Thu, 19 Mar 2020 08:20:46 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id n46sm1827607qtb.48.2020.03.19.08.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 08:20:45 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 02JFKirW011157;
        Thu, 19 Mar 2020 15:20:44 GMT
Subject: [PATCH RFC 04/11] svcrdma: Post RDMA Writes while XDR encoding
 replies
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 19 Mar 2020 11:20:44 -0400
Message-ID: <20200319152044.16298.90383.stgit@klimt.1015granger.net>
In-Reply-To: <20200319150136.16298.68813.stgit@klimt.1015granger.net>
References: <20200319150136.16298.68813.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The only RPC/RDMA ordering requirement between RDMA Writes and RDMA
Sends is that the responder must post the Writes on the Send queue
before posting the Send that conveys the RPC Reply for that Write
payload.

The Linux NFS server implementation now has a transport method that
can post READ Payload Writes earlier than svc_rdma_sendto:

   ->xpo_read_payload.

Goals:
- Get RDMA Writes going earlier so they are more likely to be
  complete at the remote end before the Send completes.
- Allow more parallelism when dispatching RDMA operations by
  posting RDMA Writes before taking xpt_mutex.

Some care must be taken with pulled-up Replies. We don't want to
push the Write chunk and then send the same payload data via Send.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h         |   14 +++--
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |    6 +-
 net/sunrpc/xprtrdma/svc_rdma_rw.c       |   94 ++++++++++++++++++++++++-------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c   |   84 +++++++++++++++-------------
 4 files changed, 128 insertions(+), 70 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 78fe2ac6dc6c..49864264a9a5 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -125,6 +125,12 @@ enum {
 
 #define RPCSVC_MAXPAYLOAD_RDMA	RPCSVC_MAXPAYLOAD
 
+struct svc_rdma_payload {
+	__be32			*rp_chunk;
+	unsigned int		rp_offset;
+	unsigned int		rp_length;
+};
+
 struct svc_rdma_recv_ctxt {
 	struct llist_node	rc_node;
 	struct list_head	rc_list;
@@ -139,10 +145,8 @@ struct svc_rdma_recv_ctxt {
 	unsigned int		rc_page_count;
 	unsigned int		rc_hdr_count;
 	u32			rc_inv_rkey;
-	__be32			*rc_write_list;
+	struct svc_rdma_payload rc_read_payload;
 	__be32			*rc_reply_chunk;
-	unsigned int		rc_read_payload_offset;
-	unsigned int		rc_read_payload_length;
 	struct page		*rc_pages[RPCSVC_MAXPAGES];
 };
 
@@ -178,9 +182,7 @@ extern int svc_rdma_recv_read_chunk(struct svcxprt_rdma *rdma,
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
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 54469b72b25f..3e02dfa351ff 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -193,7 +193,7 @@ svc_rdma_recv_ctxt_get(struct svcxprt_rdma *rdma)
 
 out:
 	ctxt->rc_page_count = 0;
-	ctxt->rc_read_payload_length = 0;
+	ctxt->rc_read_payload.rp_length = 0;
 	return ctxt;
 
 out_empty:
@@ -479,7 +479,7 @@ static bool xdr_check_write_list(struct svc_rdma_recv_ctxt *rctxt)
 	p = xdr_inline_decode(&rctxt->rc_stream, sizeof(*p));
 	if (!p)
 		return false;
-	rctxt->rc_write_list = p;
+	rctxt->rc_read_payload.rp_chunk = p;
 	while (*p != xdr_zero) {
 		if (!xdr_check_write_chunk(rctxt, MAX_BYTES_WRITE_CHUNK))
 			return false;
@@ -489,7 +489,7 @@ static bool xdr_check_write_list(struct svc_rdma_recv_ctxt *rctxt)
 			return false;
 	}
 	if (!chcount)
-		rctxt->rc_write_list = NULL;
+		rctxt->rc_read_payload.rp_chunk = NULL;
 	return chcount < 2;
 }
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 529f00a6896c..065dfd8b5b22 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -470,19 +470,39 @@ svc_rdma_build_writes(struct svc_rdma_write_info *info,
 	return -EIO;
 }
 
-/* RDMA Write an iov.
+/**
+ * svc_rdma_iov_write - Construct RDMA Writes from an iov
+ * @info: pointer to write arguments
+ * @iov: kvec to write
+ *
+ * Returns:
+ *   On succes, returns zero
+ *   %-E2BIG if the client-provided Write chunk is too small
+ *   %-ENOMEM if a resource has been exhausted
+ *   %-EIO if an rdma-rw error occurred
  */
-static int svc_rdma_write_vec(struct svc_rdma_write_info *info,
-			      const struct kvec *vec)
+static int svc_rdma_iov_write(struct svc_rdma_write_info *info,
+			      const struct kvec *iov)
 {
-	info->wi_base = vec->iov_base;
+	info->wi_base = iov->iov_base;
 	return svc_rdma_build_writes(info, svc_rdma_vec_to_sg,
-				     vec->iov_len);
+				     iov->iov_len);
 }
 
-/* RDMA Write an xdr_buf's page list by itself.
+/**
+ * svc_rdma_pages_write - Construct RDMA Writes from pages
+ * @info: pointer to write arguments
+ * @xdr: xdr_buf with pages to write
+ * @offset: offset into the content of @xdr
+ * @length: number of bytes to write
+ *
+ * Returns:
+ *   On succes, returns zero
+ *   %-E2BIG if the client-provided Write chunk is too small
+ *   %-ENOMEM if a resource has been exhausted
+ *   %-EIO if an rdma-rw error occurred
  */
-static int svc_rdma_write_pages(struct svc_rdma_write_info *info,
+static int svc_rdma_pages_write(struct svc_rdma_write_info *info,
 				const struct xdr_buf *xdr,
 				unsigned int offset,
 				unsigned long length)
@@ -493,13 +513,49 @@ static int svc_rdma_write_pages(struct svc_rdma_write_info *info,
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
@@ -509,21 +565,17 @@ static int svc_rdma_write_pages(struct svc_rdma_write_info *info,
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
 
-	ret = svc_rdma_write_pages(info, xdr, offset, length);
-	if (ret < 0)
+	ret = svc_rdma_xb_write(xdr, info);
+	if (ret != xdr->len)
 		goto out_err;
 
 	ret = svc_rdma_post_chunk_ctxt(&info->wi_cc);
@@ -531,7 +583,7 @@ int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma, __be32 *wr_ch,
 		goto out_err;
 
 	trace_svcrdma_send_write_chunk(xdr->page_len);
-	return length;
+	return xdr->len;
 
 out_err:
 	svc_rdma_write_info_free(info);
@@ -562,7 +614,7 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 	if (!info)
 		return -ENOMEM;
 
-	ret = svc_rdma_write_vec(info, &xdr->head[0]);
+	ret = svc_rdma_iov_write(info, &xdr->head[0]);
 	if (ret < 0)
 		goto out_err;
 	consumed = xdr->head[0].iov_len;
@@ -570,8 +622,8 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 	/* Send the page list in the Reply chunk only if the
 	 * client did not provide Write chunks.
 	 */
-	if (!rctxt->rc_write_list && xdr->page_len) {
-		ret = svc_rdma_write_pages(info, xdr, xdr->head[0].iov_len,
+	if (!rctxt->rc_read_payload.rp_chunk && xdr->page_len) {
+		ret = svc_rdma_pages_write(info, xdr, xdr->head[0].iov_len,
 					   xdr->page_len);
 		if (ret < 0)
 			goto out_err;
@@ -579,7 +631,7 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 	}
 
 	if (xdr->tail[0].iov_len) {
-		ret = svc_rdma_write_vec(info, &xdr->tail[0]);
+		ret = svc_rdma_iov_write(info, &xdr->tail[0]);
 		if (ret < 0)
 			goto out_err;
 		consumed += xdr->tail[0].iov_len;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 0e6372a13018..94adeb2a43cf 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -395,9 +395,8 @@ static ssize_t svc_rdma_encode_write_segment(__be32 *src,
 
 /**
  * svc_rdma_encode_write_chunk - Encode one Write chunk
- * @src: matching Write chunk in the RPC Call header
  * @sctxt: Send context for the RPC Reply
- * @remaining: size in bytes of the payload in the Write chunk
+ * @payload: Write chunk information to encode
  *
  * Copy a Write chunk from the Call transport header to the
  * Reply transport header. Update each segment's length field
@@ -408,14 +407,16 @@ static ssize_t svc_rdma_encode_write_segment(__be32 *src,
  *   that was consumed by the Write chunk
  *   %-EMSGSIZE on XDR buffer overflow
  */
-static ssize_t svc_rdma_encode_write_chunk(__be32 *src,
-					   struct svc_rdma_send_ctxt *sctxt,
-					   unsigned int remaining)
+static ssize_t svc_rdma_encode_write_chunk(struct svc_rdma_send_ctxt *sctxt,
+					   const struct svc_rdma_payload *payload)
 {
-	unsigned int i, nsegs;
+	unsigned int i, nsegs, remaining;
 	ssize_t len, ret;
+	__be32 *src;
 
 	len = 0;
+	src = payload->rp_chunk;
+	remaining = payload->rp_length;
 	trace_svcrdma_encode_write_chunk(remaining);
 
 	src++;
@@ -465,11 +466,14 @@ svc_rdma_encode_write_list(const struct svc_rdma_recv_ctxt *rctxt,
 {
 	ssize_t len, ret;
 
-	ret = svc_rdma_encode_write_chunk(rctxt->rc_write_list, sctxt,
-					  rctxt->rc_read_payload_length);
-	if (ret < 0)
-		return ret;
-	len = ret;
+	len = 0;
+	if (rctxt->rc_read_payload.rp_chunk) {
+		ret = svc_rdma_encode_write_chunk(sctxt,
+						  &rctxt->rc_read_payload);
+		if (ret < 0)
+			return ret;
+		len += ret;
+	}
 
 	/* Terminate the Write list */
 	ret = xdr_stream_encode_item_absent(&sctxt->sc_stream);
@@ -498,8 +502,12 @@ svc_rdma_encode_reply_chunk(const struct svc_rdma_recv_ctxt *rctxt,
 			    struct svc_rdma_send_ctxt *sctxt,
 			    unsigned int length)
 {
-	return svc_rdma_encode_write_chunk(rctxt->rc_reply_chunk, sctxt,
-					   length);
+	struct svc_rdma_payload payload = {
+		.rp_chunk	= rctxt->rc_reply_chunk,
+		.rp_length	= length,
+	};
+
+	return svc_rdma_encode_write_chunk(sctxt, &payload);
 }
 
 static int svc_rdma_dma_map_page(struct svcxprt_rdma *rdma,
@@ -553,11 +561,13 @@ static bool svc_rdma_pull_up_needed(struct svcxprt_rdma *rdma,
 				    const struct svc_rdma_recv_ctxt *rctxt,
 				    struct xdr_buf *xdr)
 {
+	bool read_payload_present = rctxt && rctxt->rc_read_payload.rp_chunk;
 	int elements;
 
 	/* For small messages, copying bytes is cheaper than DMA mapping.
 	 */
-	if (sctxt->sc_hdrbuf.len + xdr->len < RPCRDMA_PULLUP_THRESH)
+	if (!read_payload_present &&
+	    sctxt->sc_hdrbuf.len + xdr->len < RPCRDMA_PULLUP_THRESH)
 		return true;
 
 	/* Check whether the xdr_buf has more elements than can
@@ -567,7 +577,7 @@ static bool svc_rdma_pull_up_needed(struct svcxprt_rdma *rdma,
 	elements = 1;
 
 	/* xdr->pages */
-	if (!rctxt || !rctxt->rc_write_list) {
+	if (!read_payload_present) {
 		unsigned int remaining;
 		unsigned long pageoff;
 
@@ -615,7 +625,7 @@ static int svc_rdma_pull_up_reply_msg(struct svcxprt_rdma *rdma,
 
 	tailbase = xdr->tail[0].iov_base;
 	taillen = xdr->tail[0].iov_len;
-	if (rctxt && rctxt->rc_write_list) {
+	if (rctxt && rctxt->rc_read_payload.rp_chunk) {
 		u32 xdrpad;
 
 		xdrpad = xdr_pad_size(xdr->page_len);
@@ -700,7 +710,7 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 	 * have added XDR padding in the tail buffer, and that
 	 * should not be included inline.
 	 */
-	if (rctxt && rctxt->rc_write_list) {
+	if (rctxt && rctxt->rc_read_payload.rp_chunk) {
 		base = xdr->tail[0].iov_base;
 		len = xdr->tail[0].iov_len;
 		xdr_pad = xdr_pad_size(xdr->page_len);
@@ -858,9 +868,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 		container_of(xprt, struct svcxprt_rdma, sc_xprt);
 	struct svc_rdma_recv_ctxt *rctxt = rqstp->rq_xprt_ctxt;
 	__be32 *rdma_argp = rctxt->rc_recv_buf;
-	__be32 *wr_lst = rctxt->rc_write_list;
 	__be32 *rp_ch = rctxt->rc_reply_chunk;
-	struct xdr_buf *xdr = &rqstp->rq_res;
 	struct svc_rdma_send_ctxt *sctxt;
 	__be32 *p;
 	int ret;
@@ -887,19 +895,8 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 
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
@@ -946,23 +943,30 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
  * @offset: payload's byte offset in @xdr
  * @length: size of payload, in bytes
  *
- * Returns zero on success.
- *
- * For the moment, just record the xdr_buf location of the READ
- * payload. svc_rdma_sendto will use that location later when
- * we actually send the payload.
+ * Returns:
+ *     %-EMSGSIZE on XDR buffer overflow
  */
 int svc_rdma_read_payload(struct svc_rqst *rqstp, unsigned int offset,
 			  unsigned int length)
 {
 	struct svc_rdma_recv_ctxt *rctxt = rqstp->rq_xprt_ctxt;
+	struct xdr_buf uninitialized_var(subbuf);
+	struct svcxprt_rdma *rdma;
+
+	if (!rctxt->rc_read_payload.rp_chunk || !length)
+		return 0;
 
 	/* XXX: Just one READ payload slot for now, since our
 	 * transport implementation currently supports only one
 	 * Write chunk.
 	 */
-	rctxt->rc_read_payload_offset = offset;
-	rctxt->rc_read_payload_length = length;
+	rctxt->rc_read_payload.rp_offset = offset;
+	rctxt->rc_read_payload.rp_length = length;
 
-	return 0;
+	if (xdr_buf_subsegment(&rqstp->rq_res, &subbuf, offset, length))
+		return -EMSGSIZE;
+
+	rdma = container_of(rqstp->rq_xprt, struct svcxprt_rdma, sc_xprt);
+	return svc_rdma_send_write_chunk(rdma, rctxt->rc_read_payload.rp_chunk,
+					 &subbuf);
 }

