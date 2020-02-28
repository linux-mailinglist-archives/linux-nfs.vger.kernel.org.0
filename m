Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94DCC172D60
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 01:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbgB1AcG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Feb 2020 19:32:06 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40056 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbgB1AcF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Feb 2020 19:32:05 -0500
Received: by mail-pf1-f195.google.com with SMTP id b185so737625pfb.7;
        Thu, 27 Feb 2020 16:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=7AG58vC9RtqnN57bg63Far7VqfXiBw6/6793+Cm3LCY=;
        b=Amu9h+PROlVuSEmyvQ3TZ6b74kc9KVxDVSO9GIuqb5QcW4hWUEHDmdLM2ayYUvq6wo
         xgn/CfnC4m3K2zdqq5uMn/WslISvogU8DGDLkdZGgX/7ZReDKXkgtH/Fy+viHrj4S2j8
         q9kO9Y90iIEMP4Bb0DPLOY0b0cQsiUCL/OLNL/fHoXGgYHNLn81cbOzUbzzWUJwATI5Z
         hy1msjsFQC+NzQfqNdQpekgaR5cceZSZ7cADCLkM20Swh29E5Nlj1eSJq5ap/pK2O25X
         vEGtJjNUezhqWIS8yAImFbjb03RJ6oOZIATJbyEviazv8g5+wcXRBOJhfenFt7pV1wMP
         o8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=7AG58vC9RtqnN57bg63Far7VqfXiBw6/6793+Cm3LCY=;
        b=OHa+xF2oQNhVaKAlM4lujGyzF/O8XSs0Nc37n9APMz3QCZq88RjN236WayiTRp6Pyo
         I6/wqhY+G+v+8yKbLvWcvhcTu8zivzz32BbQAhsYcLTJX+M4qDuxIN5lEqcD/X8oWPSC
         D79nWAiSZBgAvbPmkfrhzXT5kUYO6wLaIZwRTKz0j90d4ggZYnDFLHapOpi2rQjDNxFH
         wJdWEeGWTZ0q0Y91uyLNf00zp/Krw/jT5pMjk8ne50Qn5kou9yfDDESjShWljXR5tWK9
         CyeWB1zItXUwDVk+RvH5YHwgL3AT9nmS3TsYvesBz6ywVCMqNlBdP8CPtCtcR7hXRbcd
         f2xQ==
X-Gm-Message-State: APjAAAVcgdVyG6Pjdevj2JVcIVAsu2Kr4X8Jg7dY2FQXjQUIsctC+i1r
        OPwQh85Zsb0SMk0NX+63dBM=
X-Google-Smtp-Source: APXvYqwTLuz5hZhRjzfHbZUMlxZoYQ7Du11FOhcwQto4EchsJrZ016LjgO1QcTxcE6SniDHO787aQg==
X-Received: by 2002:a63:731c:: with SMTP id o28mr1851311pgc.139.1582849924135;
        Thu, 27 Feb 2020 16:32:04 -0800 (PST)
Received: from seurat29.1015granger.net (ip-184-250-247-225.sanjca.spcsdns.net. [184.250.247.225])
        by smtp.gmail.com with ESMTPSA id r3sm252684pfq.126.2020.02.27.16.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:32:03 -0800 (PST)
Subject: [PATCH v1 14/16] svcrdma: Refactor chunk list encoders
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 27 Feb 2020 19:32:02 -0500
Message-ID: <158284992227.38468.5375514646117410024.stgit@seurat29.1015granger.net>
In-Reply-To: <158284930886.38468.17045380766660946827.stgit@seurat29.1015granger.net>
References: <158284930886.38468.17045380766660946827.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Same idea as the receive-side changes I did a while back: use
xdr_stream helpers rather than open-coding the XDR chunk list
encoders. This builds the Reply transport header from beginning to
end without backtracking.

As additional clean-ups, fill in documenting comments for the XDR
encoders and sprinkle some trace points in the new encoding
functions.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h            |    2 
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |   15 +-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c    |   34 +++
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      |  279 +++++++++++++++++-----------
 4 files changed, 209 insertions(+), 121 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index c506732886b3..d001aac13c2f 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -149,6 +149,8 @@ struct svc_rdma_send_ctxt {
 	struct list_head	sc_list;
 	struct ib_send_wr	sc_send_wr;
 	struct ib_cqe		sc_cqe;
+	struct xdr_buf		sc_hdrbuf;
+	struct xdr_stream	sc_stream;
 	void			*sc_xprt_buf;
 	int			sc_page_count;
 	int			sc_cur_sge_no;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
index ce1a7a706f36..9830748c58d2 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -181,7 +181,9 @@ rpcrdma_bc_send_request(struct svcxprt_rdma *rdma, struct rpc_rqst *rqst)
 	if (!ctxt)
 		goto drop_connection;
 
-	p = ctxt->sc_xprt_buf;
+	p = xdr_reserve_space(&ctxt->sc_stream, RPCRDMA_HDRLEN_MIN);
+	if (!p)
+		goto put_ctxt;
 	*p++ = rqst->rq_xid;
 	*p++ = rpcrdma_version;
 	*p++ = cpu_to_be32(r_xprt->rx_buf.rb_bc_max_requests);
@@ -189,7 +191,7 @@ rpcrdma_bc_send_request(struct svcxprt_rdma *rdma, struct rpc_rqst *rqst)
 	*p++ = xdr_zero;
 	*p++ = xdr_zero;
 	*p   = xdr_zero;
-	svc_rdma_sync_reply_hdr(rdma, ctxt, RPCRDMA_HDRLEN_MIN);
+	svc_rdma_sync_reply_hdr(rdma, ctxt, ctxt->sc_hdrbuf.len);
 
 #ifdef SVCRDMA_BACKCHANNEL_DEBUG
 	pr_info("%s: %*ph\n", __func__, 64, rqst->rq_buffer);
@@ -197,12 +199,13 @@ rpcrdma_bc_send_request(struct svcxprt_rdma *rdma, struct rpc_rqst *rqst)
 
 	rqst->rq_xtime = ktime_get();
 	rc = svc_rdma_bc_sendto(rdma, rqst, ctxt);
-	if (rc) {
-		svc_rdma_send_ctxt_put(rdma, ctxt);
-		goto drop_connection;
-	}
+	if (rc)
+		goto put_ctxt;
 	return 0;
 
+put_ctxt:
+	svc_rdma_send_ctxt_put(rdma, ctxt);
+
 drop_connection:
 	dprintk("svcrdma: failed to send bc call\n");
 	return -ENOTCONN;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index f9a3c413491c..447060dbd6fd 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -698,7 +698,6 @@ static void svc_rdma_send_error(struct svcxprt_rdma *xprt,
 				__be32 *rdma_argp, int status)
 {
 	struct svc_rdma_send_ctxt *ctxt;
-	unsigned int length;
 	__be32 *p;
 	int ret;
 
@@ -706,29 +705,48 @@ static void svc_rdma_send_error(struct svcxprt_rdma *xprt,
 	if (!ctxt)
 		return;
 
-	p = ctxt->sc_xprt_buf;
+	p = xdr_reserve_space(&ctxt->sc_stream,
+			      rpcrdma_fixed_maxsz * sizeof(*p));
+	if (!p)
+		goto put_ctxt;
+
 	*p++ = *rdma_argp;
 	*p++ = *(rdma_argp + 1);
 	*p++ = xprt->sc_fc_credits;
-	*p++ = rdma_error;
+	*p = rdma_error;
+
 	switch (status) {
 	case -EPROTONOSUPPORT:
+		p = xdr_reserve_space(&ctxt->sc_stream,
+				      3 * sizeof(*p));
+		if (!p)
+			goto put_ctxt;
+
 		*p++ = err_vers;
 		*p++ = rpcrdma_version;
-		*p++ = rpcrdma_version;
+		*p = rpcrdma_version;
 		trace_svcrdma_err_vers(*rdma_argp);
 		break;
 	default:
-		*p++ = err_chunk;
+		p = xdr_reserve_space(&ctxt->sc_stream,
+				      sizeof(*p));
+		if (!p)
+			goto put_ctxt;
+
+		*p = err_chunk;
 		trace_svcrdma_err_chunk(*rdma_argp);
 	}
-	length = (unsigned long)p - (unsigned long)ctxt->sc_xprt_buf;
-	svc_rdma_sync_reply_hdr(xprt, ctxt, length);
+
+	svc_rdma_sync_reply_hdr(xprt, ctxt, ctxt->sc_hdrbuf.len);
 
 	ctxt->sc_send_wr.opcode = IB_WR_SEND;
 	ret = svc_rdma_send(xprt, &ctxt->sc_send_wr);
 	if (ret)
-		svc_rdma_send_ctxt_put(xprt, ctxt);
+		goto put_ctxt;
+	return;
+
+put_ctxt:
+	svc_rdma_send_ctxt_put(xprt, ctxt);
 }
 
 /* By convention, backchannel calls arrive via rdma_msg type
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 1035df3a3b5c..f557e1cc5694 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -151,6 +151,8 @@ svc_rdma_send_ctxt_alloc(struct svcxprt_rdma *rdma)
 	ctxt->sc_send_wr.send_flags = IB_SEND_SIGNALED;
 	ctxt->sc_cqe.done = svc_rdma_wc_send;
 	ctxt->sc_xprt_buf = buffer;
+	xdr_buf_init(&ctxt->sc_hdrbuf, ctxt->sc_xprt_buf,
+		     rdma->sc_max_req_size);
 	ctxt->sc_sges[0].addr = addr;
 
 	for (i = 0; i < rdma->sc_max_send_sges; i++)
@@ -204,6 +206,10 @@ struct svc_rdma_send_ctxt *svc_rdma_send_ctxt_get(struct svcxprt_rdma *rdma)
 	spin_unlock(&rdma->sc_send_lock);
 
 out:
+	rpcrdma_set_xdrlen(&ctxt->sc_hdrbuf, 0);
+	xdr_init_encode(&ctxt->sc_stream, &ctxt->sc_hdrbuf,
+			ctxt->sc_xprt_buf, NULL);
+
 	ctxt->sc_send_wr.num_sge = 0;
 	ctxt->sc_cur_sge_no = 0;
 	ctxt->sc_page_count = 0;
@@ -322,131 +328,171 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct ib_send_wr *wr)
 	return ret;
 }
 
-/* Returns length of transport header, in bytes.
+/**
+ * svc_rdma_encode_read_list - Encode RPC Reply's Read chunk list
+ * @sctxt: Send context for the RPC Reply
+ *
+ * Return values:
+ *   On success, returns length in bytes of the Reply XDR buffer
+ *   that was consumed by the Reply Read list
+ *   %-EMSGSIZE on XDR buffer overflow
  */
-static unsigned int svc_rdma_reply_hdr_len(__be32 *rdma_resp)
+static ssize_t svc_rdma_encode_read_list(struct svc_rdma_send_ctxt *sctxt)
 {
-	unsigned int nsegs;
-	__be32 *p;
-
-	p = rdma_resp;
-
-	/* RPC-over-RDMA V1 replies never have a Read list. */
-	p += rpcrdma_fixed_maxsz + 1;
-
-	/* Skip Write list. */
-	while (*p++ != xdr_zero) {
-		nsegs = be32_to_cpup(p++);
-		p += nsegs * rpcrdma_segment_maxsz;
-	}
+	/* RPC-over-RDMA version 1 replies never have a Read list. */
+	return xdr_stream_encode_item_absent(&sctxt->sc_stream);
+}
 
-	/* Skip Reply chunk. */
-	if (*p++ != xdr_zero) {
-		nsegs = be32_to_cpup(p++);
-		p += nsegs * rpcrdma_segment_maxsz;
+/**
+ * svc_rdma_encode_write_segment - Encode one Write segment
+ * @src: matching Write chunk in the RPC Call header
+ * @sctxt: Send context for the RPC Reply
+ * @remaining: remaining bytes of the payload left in the Write chunk
+ *
+ * Return values:
+ *   On success, returns length in bytes of the Reply XDR buffer
+ *   that was consumed by the Write segment
+ *   %-EMSGSIZE on XDR buffer overflow
+ */
+static ssize_t svc_rdma_encode_write_segment(__be32 *src,
+					     struct svc_rdma_send_ctxt *sctxt,
+					     unsigned int *remaining)
+{
+	__be32 *p;
+	const size_t len = rpcrdma_segment_maxsz * sizeof(*p);
+	u32 handle, length;
+	u64 offset;
+
+	p = xdr_reserve_space(&sctxt->sc_stream, len);
+	if (!p)
+		return -EMSGSIZE;
+
+	handle = be32_to_cpup(src++);
+	length = be32_to_cpup(src++);
+	xdr_decode_hyper(src, &offset);
+
+	*p++ = cpu_to_be32(handle);
+	if (*remaining < length) {
+		/* segment only partly filled */
+		length = *remaining;
+		*remaining = 0;
+	} else {
+		/* entire segment was consumed */
+		*remaining -= length;
 	}
+	*p++ = cpu_to_be32(length);
+	xdr_encode_hyper(p, offset);
 
-	return (unsigned long)p - (unsigned long)rdma_resp;
+	trace_svcrdma_encode_wseg(handle, length, offset);
+	return len;
 }
 
-/* One Write chunk is copied from Call transport header to Reply
- * transport header. Each segment's length field is updated to
- * reflect number of bytes consumed in the segment.
- *
- * Returns number of segments in this chunk.
+/**
+ * svc_rdma_encode_write_chunk - Encode one Write chunk
+ * @src: matching Write chunk in the RPC Call header
+ * @sctxt: Send context for the RPC Reply
+ * @remaining: size in bytes of the payload in the Write chunk
+ *
+ * Copy a Write chunk from the Call transport header to the
+ * Reply transport header. Update each segment's length field
+ * to reflect the number of bytes written in that segment.
+ *
+ * Return values:
+ *   On success, returns length in bytes of the Reply XDR buffer
+ *   that was consumed by the Write chunk
+ *   %-EMSGSIZE on XDR buffer overflow
  */
-static unsigned int xdr_encode_write_chunk(__be32 *dst, __be32 *src,
+static ssize_t svc_rdma_encode_write_chunk(__be32 *src,
+					   struct svc_rdma_send_ctxt *sctxt,
 					   unsigned int remaining)
 {
 	unsigned int i, nsegs;
-	u32 seg_len;
+	ssize_t len, ret;
 
-	/* Write list discriminator */
-	*dst++ = *src++;
+	len = 0;
+	trace_svcrdma_encode_write_chunk(remaining);
 
-	/* number of segments in this chunk */
-	nsegs = be32_to_cpup(src);
-	*dst++ = *src++;
+	src++;
+	ret = xdr_stream_encode_item_present(&sctxt->sc_stream);
+	if (ret < 0)
+		return -EMSGSIZE;
+	len += ret;
 
-	for (i = nsegs; i; i--) {
-		/* segment's RDMA handle */
-		*dst++ = *src++;
-
-		/* bytes returned in this segment */
-		seg_len = be32_to_cpu(*src);
-		if (remaining >= seg_len) {
-			/* entire segment was consumed */
-			*dst = *src;
-			remaining -= seg_len;
-		} else {
-			/* segment only partly filled */
-			*dst = cpu_to_be32(remaining);
-			remaining = 0;
-		}
-		dst++; src++;
+	nsegs = be32_to_cpup(src++);
+	ret = xdr_stream_encode_u32(&sctxt->sc_stream, nsegs);
+	if (ret < 0)
+		return -EMSGSIZE;
+	len += ret;
 
-		/* segment's RDMA offset */
-		*dst++ = *src++;
-		*dst++ = *src++;
+	for (i = nsegs; i; i--) {
+		ret = svc_rdma_encode_write_segment(src, sctxt, &remaining);
+		if (ret < 0)
+			return -EMSGSIZE;
+		src += rpcrdma_segment_maxsz;
+		len += ret;
 	}
 
-	return nsegs;
+	return len;
 }
 
-/* The client provided a Write list in the Call message. Fill in
- * the segments in the first Write chunk in the Reply's transport
+/**
+ * svc_rdma_encode_write_list - Encode RPC Reply's Write chunk list
+ * @rctxt: Reply context with information about the RPC Call
+ * @sctxt: Send context for the RPC Reply
+ * @length: size in bytes of the payload in the first Write chunk
+ *
+ * The client provides a Write chunk list in the Call message. Fill
+ * in the segments in the first Write chunk in the Reply's transport
  * header with the number of bytes consumed in each segment.
  * Remaining chunks are returned unused.
  *
  * Assumptions:
  *  - Client has provided only one Write chunk
+ *
+ * Return values:
+ *   On success, returns length in bytes of the Reply XDR buffer
+ *   that was consumed by the Reply's Write list
+ *   %-EMSGSIZE on XDR buffer overflow
  */
-static void svc_rdma_xdr_encode_write_list(__be32 *rdma_resp, __be32 *wr_ch,
-					   unsigned int consumed)
+static ssize_t svc_rdma_encode_write_list(const struct svc_rdma_recv_ctxt *rctxt,
+					  struct svc_rdma_send_ctxt *sctxt,
+					  unsigned int length)
 {
-	unsigned int nsegs;
-	__be32 *p, *q;
-
-	/* RPC-over-RDMA V1 replies never have a Read list. */
-	p = rdma_resp + rpcrdma_fixed_maxsz + 1;
-
-	q = wr_ch;
-	while (*q != xdr_zero) {
-		nsegs = xdr_encode_write_chunk(p, q, consumed);
-		q += 2 + nsegs * rpcrdma_segment_maxsz;
-		p += 2 + nsegs * rpcrdma_segment_maxsz;
-		consumed = 0;
-	}
+	ssize_t len, ret;
 
-	/* Terminate Write list */
-	*p++ = xdr_zero;
+	ret = svc_rdma_encode_write_chunk(rctxt->rc_write_list, sctxt, length);
+	if (ret < 0)
+		return ret;
+	len = ret;
 
-	/* Reply chunk discriminator; may be replaced later */
-	*p = xdr_zero;
+	/* Terminate the Write list */
+	ret = xdr_stream_encode_item_absent(&sctxt->sc_stream);
+	if (ret < 0)
+		return ret;
+
+	return len + ret;
 }
 
-/* The client provided a Reply chunk in the Call message. Fill in
- * the segments in the Reply chunk in the Reply message with the
- * number of bytes consumed in each segment.
+/**
+ * svc_rdma_encode_reply_chunk - Encode RPC Reply's Reply chunk
+ * @rctxt: Reply context with information about the RPC Call
+ * @sctxt: Send context for the RPC Reply
+ * @length: size in bytes of the payload in the Reply chunk
  *
  * Assumptions:
- * - Reply can always fit in the provided Reply chunk
+ * - Reply can always fit in the client-provided Reply chunk
+ *
+ * Return values:
+ *   On success, returns length in bytes of the Reply XDR buffer
+ *   that was consumed by the Reply's Reply chunk
+ *   %-EMSGSIZE on XDR buffer overflow
  */
-static void svc_rdma_xdr_encode_reply_chunk(__be32 *rdma_resp, __be32 *rp_ch,
-					    unsigned int consumed)
+static ssize_t svc_rdma_encode_reply_chunk(const struct svc_rdma_recv_ctxt *rctxt,
+					   struct svc_rdma_send_ctxt *sctxt,
+					   unsigned int length)
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
+	return svc_rdma_encode_write_chunk(rctxt->rc_reply_chunk, sctxt,
+					   length);
 }
 
 static int svc_rdma_dma_map_page(struct svcxprt_rdma *rdma,
@@ -765,14 +811,26 @@ static int svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 				   struct svc_rdma_send_ctxt *ctxt,
 				   struct svc_rqst *rqstp)
 {
+	struct svc_rdma_recv_ctxt *rctxt = rqstp->rq_xprt_ctxt;
+	__be32 *rdma_argp = rctxt->rc_recv_buf;
 	__be32 *p;
 
-	p = ctxt->sc_xprt_buf;
-	trace_svcrdma_err_chunk(*p);
-	p += 3;
+	rpcrdma_set_xdrlen(&ctxt->sc_hdrbuf, 0);
+	xdr_init_encode(&ctxt->sc_stream, &ctxt->sc_hdrbuf,
+			ctxt->sc_xprt_buf, NULL);
+
+	p = xdr_reserve_space(&ctxt->sc_stream, RPCRDMA_HDRLEN_ERR);
+	if (!p)
+		return -ENOMSG;
+
+	*p++ = *rdma_argp;
+	*p++ = *(rdma_argp + 1);
+	*p++ = rdma->sc_fc_credits;
 	*p++ = rdma_error;
 	*p   = err_chunk;
-	svc_rdma_sync_reply_hdr(rdma, ctxt, RPCRDMA_HDRLEN_ERR);
+	trace_svcrdma_err_chunk(*rdma_argp);
+
+	svc_rdma_sync_reply_hdr(rdma, ctxt, ctxt->sc_hdrbuf.len);
 
 	svc_rdma_save_io_pages(rqstp, ctxt);
 
@@ -803,7 +861,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	__be32 *rp_ch = rctxt->rc_reply_chunk;
 	struct xdr_buf *xdr = &rqstp->rq_res;
 	struct svc_rdma_send_ctxt *sctxt;
-	__be32 *p, *rdma_resp;
+	__be32 *p;
 	int ret;
 
 	/* Create the RDMA response header. xprt->xpt_mutex,
@@ -816,19 +874,18 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	sctxt = svc_rdma_send_ctxt_get(rdma);
 	if (!sctxt)
 		goto err0;
-	rdma_resp = sctxt->sc_xprt_buf;
 
-	p = rdma_resp;
+	p = xdr_reserve_space(&sctxt->sc_stream,
+			      rpcrdma_fixed_maxsz * sizeof(*p));
+	if (!p)
+		goto err0;
 	*p++ = *rdma_argp;
 	*p++ = *(rdma_argp + 1);
 	*p++ = rdma->sc_fc_credits;
-	*p++ = rp_ch ? rdma_nomsg : rdma_msg;
-
-	/* Start with empty chunks */
-	*p++ = xdr_zero;
-	*p++ = xdr_zero;
-	*p   = xdr_zero;
+	*p   = rp_ch ? rdma_nomsg : rdma_msg;
 
+	if (svc_rdma_encode_read_list(sctxt) < 0)
+		goto err0;
 	if (wr_lst) {
 		/* XXX: Presume the client sent only one Write chunk */
 		unsigned long offset;
@@ -845,16 +902,24 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 						length);
 		if (ret < 0)
 			goto err2;
-		svc_rdma_xdr_encode_write_list(rdma_resp, wr_lst, ret);
+		if (svc_rdma_encode_write_list(rctxt, sctxt, length) < 0)
+			goto err0;
+	} else {
+		if (xdr_stream_encode_item_absent(&sctxt->sc_stream) < 0)
+			goto err0;
 	}
 	if (rp_ch) {
 		ret = svc_rdma_send_reply_chunk(rdma, rctxt, &rqstp->rq_res);
 		if (ret < 0)
 			goto err2;
-		svc_rdma_xdr_encode_reply_chunk(rdma_resp, rp_ch, ret);
+		if (svc_rdma_encode_reply_chunk(rctxt, sctxt, ret) < 0)
+			goto err0;
+	} else {
+		if (xdr_stream_encode_item_absent(&sctxt->sc_stream) < 0)
+			goto err0;
 	}
 
-	svc_rdma_sync_reply_hdr(rdma, sctxt, svc_rdma_reply_hdr_len(rdma_resp));
+	svc_rdma_sync_reply_hdr(rdma, sctxt, sctxt->sc_hdrbuf.len);
 	ret = svc_rdma_send_reply_msg(rdma, sctxt, rctxt, rqstp);
 	if (ret < 0)
 		goto err1;

