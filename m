Return-Path: <linux-nfs+bounces-1561-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A424840903
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 15:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA0F3B22B89
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 14:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3911A152DFE;
	Mon, 29 Jan 2024 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHlBcmXK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CD214460B;
	Mon, 29 Jan 2024 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539896; cv=none; b=Y4gcVFS3mc+qX3t6M9bK6l8ROIZELWUjPHII+20wFFn2l4ouHaVnitrsFzUUKQrCKZk2kkoRYbEB6leWHM7WEb615MSDu5jgZdKkA/tXpcQO8zS74yuUTsFrEX2goczb7GBL3nm38nNZsww3UMlCTJpU2I9kzYsDv33YH+F3pdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539896; c=relaxed/simple;
	bh=L0X3dLyOPy67nt8GCLWy13o2002WEL1KVLp4Q4jt1ZU=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OErnceIZ/0Qd9CCc3AjELJoJbK/f4WSbU/3p+kRICMU5Rgium7ll9bkeQ12HnIUorPd2nXlCNqGhx0eLHwKkIK8vOLn+b4IXrq+2KpZigoDXd6gOxri3JZBO5VEBskuAYUpUzVSLmtAKpf1CfUQtjrUfvBSNr53iuwWwqUc+8MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHlBcmXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541DCC433F1;
	Mon, 29 Jan 2024 14:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706539895;
	bh=L0X3dLyOPy67nt8GCLWy13o2002WEL1KVLp4Q4jt1ZU=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=LHlBcmXKHf0boe5XGZkjpuRzJr+v3DH99t7pucSkpV/ptjSx3yQ5tCvupjq588i8J
	 cwV1c1ehTOKZsF6c9kF0vCymu1fTIxTOmxy9r06BDF4fEhp+BXT8IJU4gfuec1v5BX
	 jge5nxXKxVPrRtx6SxC+2MQPWRpuExjhSaw5NsXUTcYzyxz82oV9kcpS/vDxTBfK4F
	 5+hYkBTBNU/8+TPuLzy4EyumldiJPKnxtMIcbTkVmC2tgU4B6MChN4wbum/oVH+0DR
	 k53AgEEvzneRtPk14OhmVjI/kLEzeUrv8hNHVMSqMOr+xK1PJtMkl7j8UK7PDQVdQB
	 ukUOcIeSeZ2Eg==
Subject: [PATCH v1 10/11] svcrdma: Post WRs for Write chunks in
 svc_rdma_sendto()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Mon, 29 Jan 2024 09:51:34 -0500
Message-ID: 
 <170653989440.24162.14938748106287967969.stgit@manet.1015granger.net>
In-Reply-To: 
 <170653967395.24162.4661804176845293777.stgit@manet.1015granger.net>
References: 
 <170653967395.24162.4661804176845293777.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

Refactor to eventually enable svcrdma to post the Write WRs for each
RPC response using the same ib_post_send() as the Send WR (ie, as a
single WR chain).

svc_rdma_result_payload (originally svc_rdma_read_payload) was added
so that the upper layer XDR encoder could identify a range of bytes
to be possibly conveyed by RDMA (if a Write chunk was provided by
the client).

The purpose of commit f6ad77590a5d ("svcrdma: Post RDMA Writes while
XDR encoding replies") was to post as much of the result payload
outside of svc_rdma_sendto() as possible because svc_rdma_sendto()
used to be called with the xpt_mutex held.

However, since commit ca4faf543a33 ("SUNRPC: Move xpt_mutex into
socket xpo_sendto methods"), the xpt_mutex is no longer held when
calling svc_rdma_sendto(). Thus, that benefit is no longer an issue.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h       |    6 ++--
 net/sunrpc/xprtrdma/svc_rdma_rw.c     |   56 ++++++++++++++++++++++-----------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   30 ++++++------------
 3 files changed, 51 insertions(+), 41 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index ac882bd23ca2..d33bab33099a 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -272,9 +272,9 @@ extern void svc_rdma_cc_release(struct svcxprt_rdma *rdma,
 				enum dma_data_direction dir);
 extern void svc_rdma_reply_chunk_release(struct svcxprt_rdma *rdma,
 					 struct svc_rdma_send_ctxt *ctxt);
-extern int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
-				     const struct svc_rdma_chunk *chunk,
-				     const struct xdr_buf *xdr);
+extern int svc_rdma_send_write_list(struct svcxprt_rdma *rdma,
+				    const struct svc_rdma_recv_ctxt *rctxt,
+				    const struct xdr_buf *xdr);
 extern int svc_rdma_prepare_reply_chunk(struct svcxprt_rdma *rdma,
 					const struct svc_rdma_pcl *write_pcl,
 					const struct svc_rdma_pcl *reply_pcl,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 2b25edc6c73c..40797114d50a 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -601,47 +601,65 @@ static int svc_rdma_xb_write(const struct xdr_buf *xdr, void *data)
 	return xdr->len;
 }
 
-/**
- * svc_rdma_send_write_chunk - Write all segments in a Write chunk
- * @rdma: controlling RDMA transport
- * @chunk: Write chunk provided by the client
- * @xdr: xdr_buf containing the data payload
- *
- * Returns a non-negative number of bytes the chunk consumed, or
- *	%-E2BIG if the payload was larger than the Write chunk,
- *	%-EINVAL if client provided too many segments,
- *	%-ENOMEM if rdma_rw context pool was exhausted,
- *	%-ENOTCONN if posting failed (connection is lost),
- *	%-EIO if rdma_rw initialization failed (DMA mapping, etc).
- */
-int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
-			      const struct svc_rdma_chunk *chunk,
-			      const struct xdr_buf *xdr)
+static int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
+				     const struct svc_rdma_chunk *chunk,
+				     const struct xdr_buf *xdr)
 {
 	struct svc_rdma_write_info *info;
 	struct svc_rdma_chunk_ctxt *cc;
+	struct xdr_buf payload;
 	int ret;
 
+	if (xdr_buf_subsegment(xdr, &payload, chunk->ch_position,
+			       chunk->ch_payload_length))
+		return -EMSGSIZE;
+
 	info = svc_rdma_write_info_alloc(rdma, chunk);
 	if (!info)
 		return -ENOMEM;
 	cc = &info->wi_cc;
 
-	ret = svc_rdma_xb_write(xdr, info);
-	if (ret != xdr->len)
+	ret = svc_rdma_xb_write(&payload, info);
+	if (ret != payload.len)
 		goto out_err;
 
 	trace_svcrdma_post_write_chunk(&cc->cc_cid, cc->cc_sqecount);
 	ret = svc_rdma_post_chunk_ctxt(rdma, cc);
 	if (ret < 0)
 		goto out_err;
-	return xdr->len;
+	return 0;
 
 out_err:
 	svc_rdma_write_info_free(info);
 	return ret;
 }
 
+/**
+ * svc_rdma_send_write_list - Send all chunks on the Write list
+ * @rdma: controlling RDMA transport
+ * @rctxt: Write list provisioned by the client
+ * @xdr: xdr_buf containing an RPC Reply message
+ *
+ * Returns zero on success, or a negative errno if one or more
+ * Write chunks could not be sent.
+ */
+int svc_rdma_send_write_list(struct svcxprt_rdma *rdma,
+			     const struct svc_rdma_recv_ctxt *rctxt,
+			     const struct xdr_buf *xdr)
+{
+	struct svc_rdma_chunk *chunk;
+	int ret;
+
+	pcl_for_each_chunk(chunk, &rctxt->rc_write_pcl) {
+		if (!chunk->ch_payload_length)
+			break;
+		ret = svc_rdma_send_write_chunk(rdma, chunk, xdr);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
 /**
  * svc_rdma_prepare_reply_chunk - Construct WR chain for writing the Reply chunk
  * @rdma: controlling RDMA transport
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 6dfd2232ce5b..bb5436b719e0 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -1013,6 +1013,10 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	if (!p)
 		goto put_ctxt;
 
+	ret = svc_rdma_send_write_list(rdma, rctxt, &rqstp->rq_res);
+	if (ret < 0)
+		goto put_ctxt;
+
 	rc_size = 0;
 	if (!pcl_is_empty(&rctxt->rc_reply_pcl)) {
 		ret = svc_rdma_prepare_reply_chunk(rdma, &rctxt->rc_write_pcl,
@@ -1064,45 +1068,33 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 
 /**
  * svc_rdma_result_payload - special processing for a result payload
- * @rqstp: svc_rqst to operate on
- * @offset: payload's byte offset in @xdr
+ * @rqstp: RPC transaction context
+ * @offset: payload's byte offset in @rqstp->rq_res
  * @length: size of payload, in bytes
  *
+ * Assign the passed-in result payload to the current Write chunk,
+ * and advance to cur_result_payload to the next Write chunk, if
+ * there is one.
+ *
  * Return values:
  *   %0 if successful or nothing needed to be done
- *   %-EMSGSIZE on XDR buffer overflow
  *   %-E2BIG if the payload was larger than the Write chunk
- *   %-EINVAL if client provided too many segments
- *   %-ENOMEM if rdma_rw context pool was exhausted
- *   %-ENOTCONN if posting failed (connection is lost)
- *   %-EIO if rdma_rw initialization failed (DMA mapping, etc)
  */
 int svc_rdma_result_payload(struct svc_rqst *rqstp, unsigned int offset,
 			    unsigned int length)
 {
 	struct svc_rdma_recv_ctxt *rctxt = rqstp->rq_xprt_ctxt;
 	struct svc_rdma_chunk *chunk;
-	struct svcxprt_rdma *rdma;
-	struct xdr_buf subbuf;
-	int ret;
 
 	chunk = rctxt->rc_cur_result_payload;
 	if (!length || !chunk)
 		return 0;
 	rctxt->rc_cur_result_payload =
 		pcl_next_chunk(&rctxt->rc_write_pcl, chunk);
+
 	if (length > chunk->ch_length)
 		return -E2BIG;
-
 	chunk->ch_position = offset;
 	chunk->ch_payload_length = length;
-
-	if (xdr_buf_subsegment(&rqstp->rq_res, &subbuf, offset, length))
-		return -EMSGSIZE;
-
-	rdma = container_of(rqstp->rq_xprt, struct svcxprt_rdma, sc_xprt);
-	ret = svc_rdma_send_write_chunk(rdma, chunk, &subbuf);
-	if (ret < 0)
-		return ret;
 	return 0;
 }



