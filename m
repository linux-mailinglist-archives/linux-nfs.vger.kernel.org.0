Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4DB299605
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Oct 2020 19:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782364AbgJZSzA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Oct 2020 14:55:00 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33102 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781766AbgJZSzA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Oct 2020 14:55:00 -0400
Received: by mail-qk1-f193.google.com with SMTP id t128so4355208qke.0;
        Mon, 26 Oct 2020 11:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=N39Q7UiVa1pF0nSVJzC+DPeVrvgMGrHN67iQxvGi/EM=;
        b=GJB40w/9yLIMIo89ENelN6PU/F3eKgo5eZHLIS2AxtZtYHX4ZT0fy7EhD7q4RosLOo
         +n9NSxh+J8zGiAMX99fpp25/e07LByo4swpa1MTg6w92rZ6uG85BtiUuZHwFtC53aWzX
         +Y9EY1a0BTogkOfcuo//GS44+y7BWFB35v1IVOuqeOSoIFzBfGtjrSHRuTQRPyttXaPG
         4OZbflC/Ut6FgfrBhcydsiWZI/5jhmPEyaX0WASlNDJWcvtbmTglFwqG1+3SIHQ+SmLE
         kK3V3eu+SwDZbYW0yp4lM293wXlsroyImFgTg6jdUvJeCoFtujjdj11zqPHqPnmMVK60
         BltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=N39Q7UiVa1pF0nSVJzC+DPeVrvgMGrHN67iQxvGi/EM=;
        b=l6ALtHiVffJD9ShngAcuPnVVytphAE/c0ZfXhmklaz9OODg0YFHVGpX7cFYBOGkF0N
         UoOjS2UV7VNYu/Sp9yzh7ljEDIGAFO4yddHIra7k0cc3/girivOBwgfMS79TbcYvlXRB
         EInpiCEyJX1x/n/ijzC9Tq9jVeufP5vQuniAxkZkFEUCXLErfUTnmGkM9I9HqsWNPxhm
         dkj2A+5+V7NBkFUpncK4/emcWpBwZPhogPtfuq4ZzQIXKrF0ko2z/8TbeARPbO6eN3Gg
         PBG5EiIgQ9z4LzvHyX9jIsw88FOzpah76HLRPab0QRmz+huK18gTPJbBzukqnEDXajqx
         /Dcg==
X-Gm-Message-State: AOAM530uRqRQ+ON62leA1hxyYnRAcnpp+yo0c0wKGhvV3stApTP9oEl4
        TuxdhFaY13GLa+SHpJwIHqYIjGu/OtA=
X-Google-Smtp-Source: ABdhPJwqhEmMKrdvJHKEUFCFncTiSwZvIUQxThf9IAMXPK0z6e15cTQo1hDQZaz7eXgdGhkk1b/xOg==
X-Received: by 2002:a37:aa91:: with SMTP id t139mr16372072qke.124.1603738498474;
        Mon, 26 Oct 2020 11:54:58 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z30sm1527895qtc.15.2020.10.26.11.54.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 11:54:57 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 09QIsutI013649;
        Mon, 26 Oct 2020 18:54:56 GMT
Subject: [PATCH 12/20] svcrdma: Use parsed chunk lists to encode Reply
 transport headers
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 26 Oct 2020 14:54:56 -0400
Message-ID: <160373849677.1886.2727168886556909829.stgit@klimt.1015granger.net>
In-Reply-To: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
References: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor: Instead of re-parsing the ingress RPC Call transport
header when constructing the egress RPC Reply transport header, use
the new parsed Write list and Reply chunk, which are version-
agnostic and already XDR decoded.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h        |   37 +++++++++++-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |  105 ++++++++++++++-------------------
 2 files changed, 80 insertions(+), 62 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 72b941aef43b..5218e0f9596a 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1447,9 +1447,44 @@ DECLARE_EVENT_CLASS(svcrdma_segment_event,
 				TP_ARGS(handle, length, offset))
 
 DEFINE_SEGMENT_EVENT(send_rseg);
-DEFINE_SEGMENT_EVENT(encode_wseg);
 DEFINE_SEGMENT_EVENT(send_wseg);
 
+TRACE_EVENT(svcrdma_encode_wseg,
+	TP_PROTO(
+		const struct svc_rdma_send_ctxt *ctxt,
+		u32 segno,
+		u32 handle,
+		u32 length,
+		u64 offset
+	),
+
+	TP_ARGS(ctxt, segno, handle, length, offset),
+
+	TP_STRUCT__entry(
+		__field(u32, cq_id)
+		__field(int, completion_id)
+		__field(u32, segno)
+		__field(u32, handle)
+		__field(u32, length)
+		__field(u64, offset)
+	),
+
+	TP_fast_assign(
+		__entry->cq_id = ctxt->sc_cid.ci_queue_id;
+		__entry->completion_id = ctxt->sc_cid.ci_completion_id;
+		__entry->segno = segno;
+		__entry->handle = handle;
+		__entry->length = length;
+		__entry->offset = offset;
+	),
+
+	TP_printk("cq_id=%u cid=%d segno=%u %u@0x%016llx:0x%08x",
+		__entry->cq_id, __entry->completion_id,
+		__entry->segno, __entry->length,
+		(unsigned long long)__entry->offset, __entry->handle
+	)
+);
+
 TRACE_EVENT(svcrdma_decode_rseg,
 	TP_PROTO(
 		const struct rpc_rdma_cid *cid,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index f697e79757a6..fd8d62b1e640 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -358,49 +358,42 @@ static ssize_t svc_rdma_encode_read_list(struct svc_rdma_send_ctxt *sctxt)
 
 /**
  * svc_rdma_encode_write_segment - Encode one Write segment
- * @src: matching Write chunk in the RPC Call header
  * @sctxt: Send context for the RPC Reply
+ * @chunk: Write chunk to push
  * @remaining: remaining bytes of the payload left in the Write chunk
+ * @segno: which segment in the chunk
  *
  * Return values:
  *   On success, returns length in bytes of the Reply XDR buffer
- *   that was consumed by the Write segment
+ *   that was consumed by the Write segment, and updates @remaining
  *   %-EMSGSIZE on XDR buffer overflow
  */
-static ssize_t svc_rdma_encode_write_segment(__be32 *src,
-					     struct svc_rdma_send_ctxt *sctxt,
-					     unsigned int *remaining)
+static ssize_t svc_rdma_encode_write_segment(struct svc_rdma_send_ctxt *sctxt,
+					     const struct svc_rdma_chunk *chunk,
+					     u32 *remaining, unsigned int segno)
 {
+	const struct svc_rdma_segment *segment = &chunk->ch_segments[segno];
+	const size_t len = rpcrdma_segment_maxsz * sizeof(__be32);
+	u32 length;
 	__be32 *p;
-	const size_t len = rpcrdma_segment_maxsz * sizeof(*p);
-	u32 handle, length;
-	u64 offset;
 
 	p = xdr_reserve_space(&sctxt->sc_stream, len);
 	if (!p)
 		return -EMSGSIZE;
 
-	xdr_decode_rdma_segment(src, &handle, &length, &offset);
-
-	if (*remaining < length) {
-		/* segment only partly filled */
-		length = *remaining;
-		*remaining = 0;
-	} else {
-		/* entire segment was consumed */
-		*remaining -= length;
-	}
-	xdr_encode_rdma_segment(p, handle, length, offset);
-
-	trace_svcrdma_encode_wseg(handle, length, offset);
+	length = min_t(u32, *remaining, segment->rs_length);
+	*remaining -= length;
+	xdr_encode_rdma_segment(p, segment->rs_handle, length,
+				segment->rs_offset);
+	trace_svcrdma_encode_wseg(sctxt, segno, segment->rs_handle, length,
+				  segment->rs_offset);
 	return len;
 }
 
 /**
  * svc_rdma_encode_write_chunk - Encode one Write chunk
- * @src: matching Write chunk in the RPC Call header
  * @sctxt: Send context for the RPC Reply
- * @remaining: size in bytes of the payload in the Write chunk
+ * @chunk: Write chunk to push
  *
  * Copy a Write chunk from the Call transport header to the
  * Reply transport header. Update each segment's length field
@@ -411,33 +404,30 @@ static ssize_t svc_rdma_encode_write_segment(__be32 *src,
  *   that was consumed by the Write chunk
  *   %-EMSGSIZE on XDR buffer overflow
  */
-static ssize_t svc_rdma_encode_write_chunk(__be32 *src,
-					   struct svc_rdma_send_ctxt *sctxt,
-					   unsigned int remaining)
+static ssize_t svc_rdma_encode_write_chunk(struct svc_rdma_send_ctxt *sctxt,
+					   const struct svc_rdma_chunk *chunk)
 {
-	unsigned int i, nsegs;
+	u32 remaining = chunk->ch_payload_length;
+	unsigned int segno;
 	ssize_t len, ret;
 
-	len = 0;
 	trace_svcrdma_encode_write_chunk(remaining);
 
-	src++;
+	len = 0;
 	ret = xdr_stream_encode_item_present(&sctxt->sc_stream);
 	if (ret < 0)
-		return -EMSGSIZE;
+		return ret;
 	len += ret;
 
-	nsegs = be32_to_cpup(src++);
-	ret = xdr_stream_encode_u32(&sctxt->sc_stream, nsegs);
+	ret = xdr_stream_encode_u32(&sctxt->sc_stream, chunk->ch_segcount);
 	if (ret < 0)
-		return -EMSGSIZE;
+		return ret;
 	len += ret;
 
-	for (i = nsegs; i; i--) {
-		ret = svc_rdma_encode_write_segment(src, sctxt, &remaining);
+	for (segno = 0; segno < chunk->ch_segcount; segno++) {
+		ret = svc_rdma_encode_write_segment(sctxt, chunk, &remaining, segno);
 		if (ret < 0)
-			return -EMSGSIZE;
-		src += rpcrdma_segment_maxsz;
+			return ret;
 		len += ret;
 	}
 
@@ -449,34 +439,23 @@ static ssize_t svc_rdma_encode_write_chunk(__be32 *src,
  * @rctxt: Reply context with information about the RPC Call
  * @sctxt: Send context for the RPC Reply
  *
- * The client provides a Write chunk list in the Call message. Fill
- * in the segments in the first Write chunk in the Reply's transport
- * header with the number of bytes consumed in each segment.
- * Remaining chunks are returned unused.
- *
- * Assumptions:
- *  - Client has provided only one Write chunk
- *
  * Return values:
  *   On success, returns length in bytes of the Reply XDR buffer
  *   that was consumed by the Reply's Write list
  *   %-EMSGSIZE on XDR buffer overflow
  */
-static ssize_t
-svc_rdma_encode_write_list(const struct svc_rdma_recv_ctxt *rctxt,
-			   struct svc_rdma_send_ctxt *sctxt)
+static ssize_t svc_rdma_encode_write_list(struct svc_rdma_recv_ctxt *rctxt,
+					  struct svc_rdma_send_ctxt *sctxt)
 {
 	struct svc_rdma_chunk *chunk;
 	ssize_t len, ret;
 
 	len = 0;
-	if (rctxt->rc_write_list) {
-		chunk = pcl_first_chunk(&rctxt->rc_write_pcl);
-		ret = svc_rdma_encode_write_chunk(rctxt->rc_write_list, sctxt,
-						  chunk->ch_payload_length);
+	pcl_for_each_chunk(chunk, &rctxt->rc_write_pcl) {
+		ret = svc_rdma_encode_write_chunk(sctxt, chunk);
 		if (ret < 0)
 			return ret;
-		len = ret;
+		len += ret;
 	}
 
 	/* Terminate the Write list */
@@ -493,24 +472,28 @@ svc_rdma_encode_write_list(const struct svc_rdma_recv_ctxt *rctxt,
  * @sctxt: Send context for the RPC Reply
  * @length: size in bytes of the payload in the Reply chunk
  *
- * Assumptions:
- * - Reply can always fit in the client-provided Reply chunk
- *
  * Return values:
  *   On success, returns length in bytes of the Reply XDR buffer
  *   that was consumed by the Reply's Reply chunk
  *   %-EMSGSIZE on XDR buffer overflow
+ *   %-E2BIG if the RPC message is larger than the Reply chunk
  */
 static ssize_t
-svc_rdma_encode_reply_chunk(const struct svc_rdma_recv_ctxt *rctxt,
+svc_rdma_encode_reply_chunk(struct svc_rdma_recv_ctxt *rctxt,
 			    struct svc_rdma_send_ctxt *sctxt,
 			    unsigned int length)
 {
-	if (!rctxt->rc_reply_chunk)
+	struct svc_rdma_chunk *chunk;
+
+	if (pcl_is_empty(&rctxt->rc_reply_pcl))
 		return xdr_stream_encode_item_absent(&sctxt->sc_stream);
 
-	return svc_rdma_encode_write_chunk(rctxt->rc_reply_chunk, sctxt,
-					   length);
+	chunk = pcl_first_chunk(&rctxt->rc_reply_pcl);
+	if (length > chunk->ch_length)
+		return -E2BIG;
+
+	chunk->ch_payload_length = length;
+	return svc_rdma_encode_write_chunk(sctxt, chunk);
 }
 
 static int svc_rdma_dma_map_page(struct svcxprt_rdma *rdma,
@@ -928,7 +911,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	*p++ = *rdma_argp;
 	*p++ = *(rdma_argp + 1);
 	*p++ = rdma->sc_fc_credits;
-	*p = rctxt->rc_reply_chunk ? rdma_nomsg : rdma_msg;
+	*p = pcl_is_empty(&rctxt->rc_reply_pcl) ? rdma_msg : rdma_nomsg;
 
 	if (svc_rdma_encode_read_list(sctxt) < 0)
 		goto err0;


