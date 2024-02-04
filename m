Return-Path: <linux-nfs+bounces-1762-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE6884918F
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 00:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7BA7B21272
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Feb 2024 23:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6B33D72;
	Sun,  4 Feb 2024 23:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiDQVBon"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06128BE58;
	Sun,  4 Feb 2024 23:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707088663; cv=none; b=XKXik1BtBxOOXWNlFHgZPZurBtGHoROsGwFyofZXurytLpdD2ZIihMy12dO2yIaCv1SW5V0b0B6A1ujDEkogRPpQBzQvxw5Z5mvjrSHYYGRuhGGy6rWYt0l40dNt4kR1w34WWorES+3wCnyy8BtOofGCyUFyDa+TKvj8Xupe68c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707088663; c=relaxed/simple;
	bh=L0X3dLyOPy67nt8GCLWy13o2002WEL1KVLp4Q4jt1ZU=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OL0bmSMf7yuEdIy6Nzkilyz9oqGwPr/ZK7P6yDbeogvmor69uXPVFWMZAKNAvoW3xArWZOFgVZZhC1drwCPw14AsZDfn3tjkzFSWLijUSYUtvPisKQDgTCDC/j9DbXqnAEsXKfL8wNugJWfI1YKx8a3Rnq8+cZbA/1ndSuUbmjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiDQVBon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B49C433F1;
	Sun,  4 Feb 2024 23:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707088662;
	bh=L0X3dLyOPy67nt8GCLWy13o2002WEL1KVLp4Q4jt1ZU=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=OiDQVBonmoILjdvYTeiC/d2qZdKkSD2wYmiGUxFRV+7HXlN+XRPu13BPN87HBBOGb
	 fn7KqzvdPaCfJBACDBm7bcza1FLFsNKvi/7Cd5fgUISyO5MTzo8r/6z6iKJxM0rqw/
	 zKXNHilS3ouFIVId2/GmV0X5Xw2v+DYHRvKQIXWlNUGfpUcStavsYH1DzPwOWrEsHS
	 /xXzgflPZfHi790elyIRnwibSUylstzNx0E1+ZqNnxriA5Zuu2oFEIxGTOTbYeCYSh
	 P1He3LHodUVjj8F8fv3z043+TnCaweF5oGPUNn57O51Qs+SXX7Akxlsae5FLkgHnhm
	 3nVik/x18yqTg==
Subject: [PATCH v2 11/12] svcrdma: Post WRs for Write chunks in
 svc_rdma_sendto()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Sun, 04 Feb 2024 18:17:41 -0500
Message-ID: 
 <170708866136.28128.13586205078240226182.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170708844422.28128.2979813721958631192.stgit@bazille.1015granger.net>
References: 
 <170708844422.28128.2979813721958631192.stgit@bazille.1015granger.net>
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



