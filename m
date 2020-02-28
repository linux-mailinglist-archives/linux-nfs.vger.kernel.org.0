Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6955C172D4F
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 01:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbgB1AbT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Feb 2020 19:31:19 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43449 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbgB1AbS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Feb 2020 19:31:18 -0500
Received: by mail-pl1-f195.google.com with SMTP id p11so489252plq.10;
        Thu, 27 Feb 2020 16:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=JvPz9meT5Rq1J6C53cftMDXWbrZconUYoyP9oaQmm4g=;
        b=RUcR/iWqBqp+W8xwuyAfoqistRB++apA4ETj3SyXCQGNIOwunQ06J7SpyuktXQuW0m
         /QIkDFvioRSljLlWvTHwQJ7+Ppq7RNHcK8WKIlm0bIBaCr3m3rJlYtinakdjjOwGuGDL
         7T+o8I6Br+xQrfAtoQ0/mnYRKpf051xLqI+FO8jCpfPfoS0/qcxyF4aeI8/YRHsyciUq
         ggujHUqOiulpFWb19cEdSZ649FfWiQeoO0yM9ZVoVQ81qzbScMBTzU+Abh8fV1AD8s0p
         7J3dnyzODIjoltrL4LYtirEXyI6aOl5dtxgGOeb+N7ETr08tjkuW5TPQ6DGUMmHCmtrK
         jDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=JvPz9meT5Rq1J6C53cftMDXWbrZconUYoyP9oaQmm4g=;
        b=LivwbDz1+1MBJ2cANwGwNKchNWfOtdke5+Izc9nZosUFWZR9Yh4XcvhZBipqbswFw2
         G4ysAHiepnvmjOSKI/JrOawKun9bIoYLZHP2fMUi+/lqE0wi/9srkYTicaEA569xjnj7
         kG4t7MiYggn88++W1Fa4YWFUJJYt347Y+MgFNTabLl7EVHghN8RwQcvTA6+b5oAWiQSe
         x8XhMyoNdjM2GogM7bjTTefIm5V/FgZv9gJR4bCI+VU6WeGKHAOfkRjG/9vlJbXo0wyI
         njSNxQ+GZNQP5o6wK3F1hG8dgvYZtWOlOhgibP+//a5D4u9GvraaYrQh0Zc1xYxghC7P
         VBSQ==
X-Gm-Message-State: APjAAAUVtRaKZM4eGfBIjfJttBElo4Z5mHZHYKhvkcA8IA6b7znlPw5V
        3fQQps5F+hMOrGAmUXuqaGg=
X-Google-Smtp-Source: APXvYqzhF9BZE1G6fgfOfMkac5opXCuVm/heclFDOqTYxhYR1wc0RXQSiuMjIItwTwXRPO6gCcHdbw==
X-Received: by 2002:a17:90a:664c:: with SMTP id f12mr251890pjm.61.1582849875409;
        Thu, 27 Feb 2020 16:31:15 -0800 (PST)
Received: from seurat29.1015granger.net (ip-184-250-247-225.sanjca.spcsdns.net. [184.250.247.225])
        by smtp.gmail.com with ESMTPSA id q12sm8337945pfh.158.2020.02.27.16.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:31:14 -0800 (PST)
Subject: [PATCH v1 07/16] svcrdma: Use struct xdr_stream to decode ingress
 transport headers
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 27 Feb 2020 19:31:13 -0500
Message-ID: <158284987376.38468.8418651624640545176.stgit@seurat29.1015granger.net>
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

The logic that checks incoming network headers has to be scrupulous.

De-duplicate: replace open-coded buffer overflow checks with the use
of xdr_stream helpers that are used most everywhere else XDR
decoding is done.

One minor change to the sanity checks: instead of checking the
length of individual segments, cap the length of the whole chunk
to be sure it can fit in the set of pages available in rq_pages.
This should be a better test of whether the server can handle the
chunks in each request.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/rpc_rdma.h         |    3 
 include/linux/sunrpc/svc_rdma.h         |    1 
 include/trace/events/rpcrdma.h          |    7 +
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |  207 +++++++++++++++++++------------
 4 files changed, 131 insertions(+), 87 deletions(-)

diff --git a/include/linux/sunrpc/rpc_rdma.h b/include/linux/sunrpc/rpc_rdma.h
index 92d182fd8e3b..320c672d84de 100644
--- a/include/linux/sunrpc/rpc_rdma.h
+++ b/include/linux/sunrpc/rpc_rdma.h
@@ -58,7 +58,8 @@ enum {
 enum {
 	rpcrdma_fixed_maxsz	= 4,
 	rpcrdma_segment_maxsz	= 4,
-	rpcrdma_readchunk_maxsz	= 2 + rpcrdma_segment_maxsz,
+	rpcrdma_readseg_maxsz	= 1 + rpcrdma_segment_maxsz,
+	rpcrdma_readchunk_maxsz	= 1 + rpcrdma_readseg_maxsz,
 };
 
 /*
diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 04e4a34d1c6a..c790dbb0dd90 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -132,6 +132,7 @@ struct svc_rdma_recv_ctxt {
 	struct ib_sge		rc_recv_sge;
 	void			*rc_recv_buf;
 	struct xdr_buf		rc_arg;
+	struct xdr_stream	rc_stream;
 	bool			rc_temp;
 	u32			rc_byte_len;
 	unsigned int		rc_page_count;
diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 545fe936a0cc..814b73bd2cc7 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1469,7 +1469,7 @@ DECLARE_EVENT_CLASS(svcrdma_segment_event,
 );
 
 #define DEFINE_SEGMENT_EVENT(name)					\
-		DEFINE_EVENT(svcrdma_segment_event, svcrdma_encode_##name,\
+		DEFINE_EVENT(svcrdma_segment_event, svcrdma_##name,\
 				TP_PROTO(				\
 					u32 handle,			\
 					u32 length,			\
@@ -1477,8 +1477,9 @@ DECLARE_EVENT_CLASS(svcrdma_segment_event,
 				),					\
 				TP_ARGS(handle, length, offset))
 
-DEFINE_SEGMENT_EVENT(rseg);
-DEFINE_SEGMENT_EVENT(wseg);
+DEFINE_SEGMENT_EVENT(decode_wseg);
+DEFINE_SEGMENT_EVENT(encode_rseg);
+DEFINE_SEGMENT_EVENT(encode_wseg);
 
 DECLARE_EVENT_CLASS(svcrdma_chunk_event,
 	TP_PROTO(
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 71127d898562..7db151b7dfd3 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -358,15 +358,14 @@ static void svc_rdma_build_arg_xdr(struct svc_rqst *rqstp,
 	arg->len = ctxt->rc_byte_len;
 }
 
-/* This accommodates the largest possible Write chunk,
- * in one segment.
+/* This accommodates the largest possible Write chunk.
  */
-#define MAX_BYTES_WRITE_SEG	((u32)(RPCSVC_MAXPAGES << PAGE_SHIFT))
+#define MAX_BYTES_WRITE_CHUNK	((u32)(RPCSVC_MAXPAGES << PAGE_SHIFT))
 
 /* This accommodates the largest possible Position-Zero
- * Read chunk or Reply chunk, in one segment.
+ * Read chunk or Reply chunk.
  */
-#define MAX_BYTES_SPECIAL_SEG	((u32)((RPCSVC_MAXPAGES + 2) << PAGE_SHIFT))
+#define MAX_BYTES_SPECIAL_CHUNK	((u32)((RPCSVC_MAXPAGES + 2) << PAGE_SHIFT))
 
 /* Sanity check the Read list.
  *
@@ -374,7 +373,7 @@ static void svc_rdma_build_arg_xdr(struct svc_rqst *rqstp,
  * - This implementation supports only one Read chunk.
  *
  * Sanity checks:
- * - Read list does not overflow buffer.
+ * - Read list does not overflow Receive buffer.
  * - Segment size limited by largest NFS data payload.
  *
  * The segment count is limited to how many segments can
@@ -382,30 +381,44 @@ static void svc_rdma_build_arg_xdr(struct svc_rqst *rqstp,
  * buffer. That's about 40 Read segments for a 1KB inline
  * threshold.
  *
- * Returns pointer to the following Write list.
+ * Return values:
+ *       %true: Read list is valid. @rctxt's xdr_stream is updated
+ *		to point to the first byte past the Read list.
+ *      %false: Read list is corrupt. @rctxt's xdr_stream is left
+ *      	in an unknown state.
  */
-static __be32 *xdr_check_read_list(__be32 *p, const __be32 *end)
+static bool xdr_check_read_list(struct svc_rdma_recv_ctxt *rctxt)
 {
-	u32 position;
+	u32 position, len;
 	bool first;
+	__be32 *p;
+
+	p = xdr_inline_decode(&rctxt->rc_stream, sizeof(*p));
+	if (!p)
+		return false;
 
+	len = 0;
 	first = true;
-	while (*p++ != xdr_zero) {
+	while (*p != xdr_zero) {
+		p = xdr_inline_decode(&rctxt->rc_stream,
+				      rpcrdma_readseg_maxsz * sizeof(*p));
+		if (!p)
+			return false;
+
 		if (first) {
-			position = be32_to_cpup(p++);
+			position = be32_to_cpup(p);
 			first = false;
-		} else if (be32_to_cpup(p++) != position) {
-			return NULL;
+		} else if (be32_to_cpup(p) != position) {
+			return false;
 		}
-		p++;	/* handle */
-		if (be32_to_cpup(p++) > MAX_BYTES_SPECIAL_SEG)
-			return NULL;
-		p += 2;	/* offset */
+		p += 2;
+		len += be32_to_cpup(p);
 
-		if (p > end)
-			return NULL;
+		p = xdr_inline_decode(&rctxt->rc_stream, sizeof(*p));
+		if (!p)
+			return false;
 	}
-	return p;
+	return len <= MAX_BYTES_SPECIAL_CHUNK;
 }
 
 /* The segment count is limited to how many segments can
@@ -413,67 +426,94 @@ static __be32 *xdr_check_read_list(__be32 *p, const __be32 *end)
  * buffer. That's about 60 Write segments for a 1KB inline
  * threshold.
  */
-static __be32 *xdr_check_write_chunk(__be32 *p, const __be32 *end,
-				     u32 maxlen)
+static bool xdr_check_write_chunk(struct svc_rdma_recv_ctxt *rctxt,
+				  u32 maxlen)
 {
-	u32 i, segcount;
+	u32 i, segcount, total;
+	__be32 *p;
+
+	p = xdr_inline_decode(&rctxt->rc_stream, sizeof(*p));
+	if (!p)
+		return false;
+	segcount = be32_to_cpup(p);
 
-	segcount = be32_to_cpup(p++);
+	total = 0;
 	for (i = 0; i < segcount; i++) {
-		p++;	/* handle */
-		if (be32_to_cpup(p++) > maxlen)
-			return NULL;
-		p += 2;	/* offset */
+		u32 handle, length;
+		u64 offset;
 
-		if (p > end)
-			return NULL;
-	}
+		p = xdr_inline_decode(&rctxt->rc_stream,
+				      rpcrdma_segment_maxsz * sizeof(*p));
+		if (!p)
+			return false;
+
+		handle = be32_to_cpup(p++);
+		length = be32_to_cpup(p++);
+		xdr_decode_hyper(p, &offset);
+		trace_svcrdma_decode_wseg(handle, length, offset);
 
-	return p;
+		total += length;
+	}
+	return total <= maxlen;
 }
 
 /* Sanity check the Write list.
  *
  * Implementation limits:
- * - This implementation supports only one Write chunk.
+ * - This implementation currently supports only one Write chunk.
  *
  * Sanity checks:
- * - Write list does not overflow buffer.
- * - Segment size limited by largest NFS data payload.
- *
- * Returns pointer to the following Reply chunk.
+ * - Write list does not overflow Receive buffer.
+ * - Chunk size limited by largest NFS data payload.
+ *
+ * Return values:
+ *       %true: Write list is valid. @rctxt's xdr_stream is updated
+ *		to point to the first byte past the Write list.
+ *      %false: Write list is corrupt. @rctxt's xdr_stream is left
+ *      	in an unknown state.
  */
-static __be32 *xdr_check_write_list(__be32 *p, const __be32 *end)
+static bool xdr_check_write_list(struct svc_rdma_recv_ctxt *rctxt)
 {
-	u32 chcount;
+	u32 chcount = 0;
+	__be32 *p;
 
-	chcount = 0;
-	while (*p++ != xdr_zero) {
-		p = xdr_check_write_chunk(p, end, MAX_BYTES_WRITE_SEG);
+	p = xdr_inline_decode(&rctxt->rc_stream, sizeof(*p));
+	if (!p)
+		return false;
+	while (*p != xdr_zero) {
+		if (!xdr_check_write_chunk(rctxt, MAX_BYTES_WRITE_CHUNK))
+			return false;
+		++chcount;
+		p = xdr_inline_decode(&rctxt->rc_stream, sizeof(*p));
 		if (!p)
-			return NULL;
-		if (chcount++ > 1)
-			return NULL;
+			return false;
 	}
-	return p;
+	return chcount < 2;
 }
 
 /* Sanity check the Reply chunk.
  *
  * Sanity checks:
- * - Reply chunk does not overflow buffer.
- * - Segment size limited by largest NFS data payload.
- *
- * Returns pointer to the following RPC header.
+ * - Reply chunk does not overflow Receive buffer.
+ * - Chunk size limited by largest NFS data payload.
+ *
+ * Return values:
+ *       %true: Reply chunk is valid. @rctxt's xdr_stream is updated
+ *		to point to the first byte past the Reply chunk.
+ *      %false: Reply chunk is corrupt. @rctxt's xdr_stream is left
+ *      	in an unknown state.
  */
-static __be32 *xdr_check_reply_chunk(__be32 *p, const __be32 *end)
+static bool xdr_check_reply_chunk(struct svc_rdma_recv_ctxt *rctxt)
 {
-	if (*p++ != xdr_zero) {
-		p = xdr_check_write_chunk(p, end, MAX_BYTES_SPECIAL_SEG);
-		if (!p)
-			return NULL;
-	}
-	return p;
+	__be32 *p;
+
+	p = xdr_inline_decode(&rctxt->rc_stream, sizeof(*p));
+	if (!p)
+		return false;
+	if (*p != xdr_zero)
+		if (!xdr_check_write_chunk(rctxt, MAX_BYTES_SPECIAL_CHUNK))
+			return false;
+	return true;
 }
 
 /* RPC-over-RDMA Version One private extension: Remote Invalidation.
@@ -538,60 +578,61 @@ static void svc_rdma_get_inv_rkey(struct svcxprt_rdma *rdma,
 	ctxt->rc_inv_rkey = be32_to_cpu(inv_rkey);
 }
 
-/* On entry, xdr->head[0].iov_base points to first byte in the
- * RPC-over-RDMA header.
+/**
+ * svc_rdma_xdr_decode_req - Decode the transport header
+ * @rq_arg: xdr_buf containing ingress RPC/RDMA message
+ * @rctxt: state of decoding
+ *
+ * On entry, xdr->head[0].iov_base points to first byte of the
+ * RPC-over-RDMA transport header.
  *
  * On successful exit, head[0] points to first byte past the
  * RPC-over-RDMA header. For RDMA_MSG, this is the RPC message.
+ *
  * The length of the RPC-over-RDMA header is returned.
  *
  * Assumptions:
  * - The transport header is entirely contained in the head iovec.
  */
-static int svc_rdma_xdr_decode_req(struct xdr_buf *rq_arg)
+static int svc_rdma_xdr_decode_req(struct xdr_buf *rq_arg,
+				   struct svc_rdma_recv_ctxt *rctxt)
 {
-	__be32 *p, *end, *rdma_argp;
+	__be32 *p, *rdma_argp;
 	unsigned int hdr_len;
 
-	/* Verify that there's enough bytes for header + something */
-	if (rq_arg->len <= RPCRDMA_HDRLEN_ERR)
-		goto out_short;
-
 	rdma_argp = rq_arg->head[0].iov_base;
-	if (*(rdma_argp + 1) != rpcrdma_version)
-		goto out_version;
+	xdr_init_decode(&rctxt->rc_stream, rq_arg, rdma_argp, NULL);
 
-	switch (*(rdma_argp + 3)) {
+	p = xdr_inline_decode(&rctxt->rc_stream,
+			      rpcrdma_fixed_maxsz * sizeof(*p));
+	if (unlikely(!p))
+		goto out_short;
+	p++;
+	if (*p != rpcrdma_version)
+		goto out_version;
+	p += 2;
+	switch (*p) {
 	case rdma_msg:
 		break;
 	case rdma_nomsg:
 		break;
-
 	case rdma_done:
 		goto out_drop;
-
 	case rdma_error:
 		goto out_drop;
-
 	default:
 		goto out_proc;
 	}
 
-	end = (__be32 *)((unsigned long)rdma_argp + rq_arg->len);
-	p = xdr_check_read_list(rdma_argp + 4, end);
-	if (!p)
+	if (!xdr_check_read_list(rctxt))
 		goto out_inval;
-	p = xdr_check_write_list(p, end);
-	if (!p)
-		goto out_inval;
-	p = xdr_check_reply_chunk(p, end);
-	if (!p)
+	if (!xdr_check_write_list(rctxt))
 		goto out_inval;
-	if (p > end)
+	if (!xdr_check_reply_chunk(rctxt))
 		goto out_inval;
 
-	rq_arg->head[0].iov_base = p;
-	hdr_len = (unsigned long)p - (unsigned long)rdma_argp;
+	rq_arg->head[0].iov_base = rctxt->rc_stream.p;
+	hdr_len = xdr_stream_pos(&rctxt->rc_stream);
 	rq_arg->head[0].iov_len -= hdr_len;
 	rq_arg->len -= hdr_len;
 	trace_svcrdma_decode_rqst(rdma_argp, hdr_len);
@@ -786,7 +827,7 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	rqstp->rq_next_page = rqstp->rq_respages;
 
 	p = (__be32 *)rqstp->rq_arg.head[0].iov_base;
-	ret = svc_rdma_xdr_decode_req(&rqstp->rq_arg);
+	ret = svc_rdma_xdr_decode_req(&rqstp->rq_arg, ctxt);
 	if (ret < 0)
 		goto out_err;
 	if (ret == 0)

