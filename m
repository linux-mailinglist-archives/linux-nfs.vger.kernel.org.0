Return-Path: <linux-nfs+bounces-1760-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2167484918A
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 00:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6DD2824A3
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Feb 2024 23:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA9A3D72;
	Sun,  4 Feb 2024 23:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaGyc8Et"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53984BE5A;
	Sun,  4 Feb 2024 23:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707088650; cv=none; b=cCFV4Vo4bFaJ5lv0IzEwbddLRF6E5X+GFEv+I5tnCkwX2a0mtKvaWKt0IsW8Zrj0on1kmMc00QJmRfgb7t6upoxQ7wRxiTqPtVwAiRx0BBnCPyMURt6Nj6ahduIUZAU5tV1QYz9SX5nLHOyBktK9eZM8MzrPuCkObcyyb7tLzzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707088650; c=relaxed/simple;
	bh=fACfSyyk+VkhtS87Z3tlQNfR2YjBL1g1e2LN2YXkIm0=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K8J7B2XTFfTmDvyIBEUVlGOqs8UtHZrMoLfjh+R9sR3Udlr1EX/Ab+w6vBjSG8bjpphKFk059voga/FCaK9JXcdIF/CCOkij7eg3/Zc24CUgD2LdCfO6SgL0pORn+ls/rVQlUN3S+iq7yNkV246JhC2QqZjwKjjefdbQlWE1oyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaGyc8Et; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9163EC433F1;
	Sun,  4 Feb 2024 23:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707088649;
	bh=fACfSyyk+VkhtS87Z3tlQNfR2YjBL1g1e2LN2YXkIm0=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=SaGyc8EtK43fG/zkLUi5EKbu1IcxRI+PBNCw1BLLc9fCBHp+3mMb5AVvjzDncnAoj
	 o9smOakPFALabWZkIZwEqa/5sJtnSKqhhSgjTmMCyyKCfX4M7LtelgnhPdRGAMkG5M
	 p7e3Gk4KgRmVrKsyR8HYfXT1xtTG/wXXhWmMNiluEI+tG2tkrU3UxMD1DXgMybKuOS
	 sdDp3zwtJr4elr97cMlv/1wTrOxVr8Sj6u4rCvECFl5egSpXr2uE+Min30WxUMS4fZ
	 ujMczbKrQM3Y8WT2lDAxdkXpc2eEPOkxLYx4HcyrdOnnkUs42O2wA3GmNb2Cg1ds/F
	 rAfEQjr81EYhw==
Subject: [PATCH v2 09/12] svcrdma: Move write_info for Reply chunks into
 struct svc_rdma_send_ctxt
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Sun, 04 Feb 2024 18:17:28 -0500
Message-ID: 
 <170708864867.28128.3022494799132344584.stgit@bazille.1015granger.net>
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

Since the RPC transaction's svc_rdma_send_ctxt will stay around for
the duration of the RDMA Write operation, the write_info structure
for the Reply chunk can reside in the request's svc_rdma_send_ctxt
instead of being allocated separately.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h       |   25 +++++++++
 include/trace/events/rpcrdma.h        |    4 +
 net/sunrpc/xprtrdma/svc_rdma_rw.c     |   91 +++++++++++++++++++--------------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |    2 -
 4 files changed, 82 insertions(+), 40 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index ee05087d6499..918cf4fda728 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -203,6 +203,29 @@ struct svc_rdma_recv_ctxt {
 	struct page		*rc_pages[RPCSVC_MAXPAGES];
 };
 
+/*
+ * State for sending a Write chunk.
+ *  - Tracks progress of writing one chunk over all its segments
+ *  - Stores arguments for the SGL constructor functions
+ */
+struct svc_rdma_write_info {
+	struct svcxprt_rdma	*wi_rdma;
+
+	const struct svc_rdma_chunk	*wi_chunk;
+
+	/* write state of this chunk */
+	unsigned int		wi_seg_off;
+	unsigned int		wi_seg_no;
+
+	/* SGL constructor arguments */
+	const struct xdr_buf	*wi_xdr;
+	unsigned char		*wi_base;
+	unsigned int		wi_next_off;
+
+	struct svc_rdma_chunk_ctxt	wi_cc;
+	struct work_struct	wi_work;
+};
+
 struct svc_rdma_send_ctxt {
 	struct llist_node	sc_node;
 	struct rpc_rdma_cid	sc_cid;
@@ -215,6 +238,7 @@ struct svc_rdma_send_ctxt {
 	struct ib_cqe		sc_cqe;
 	struct xdr_buf		sc_hdrbuf;
 	struct xdr_stream	sc_stream;
+	struct svc_rdma_write_info sc_reply_info;
 	void			*sc_xprt_buf;
 	int			sc_page_count;
 	int			sc_cur_sge_no;
@@ -249,6 +273,7 @@ extern int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
 				     const struct xdr_buf *xdr);
 extern int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 				     const struct svc_rdma_recv_ctxt *rctxt,
+				     struct svc_rdma_send_ctxt *sctxt,
 				     const struct xdr_buf *xdr);
 extern int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
 				      struct svc_rqst *rqstp,
diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 110c1475c527..027ac3ab457d 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -2118,6 +2118,10 @@ DEFINE_SIMPLE_CID_EVENT(svcrdma_wc_write);
 DEFINE_SEND_FLUSH_EVENT(svcrdma_wc_write_flush);
 DEFINE_SEND_FLUSH_EVENT(svcrdma_wc_write_err);
 
+DEFINE_SIMPLE_CID_EVENT(svcrdma_wc_reply);
+DEFINE_SEND_FLUSH_EVENT(svcrdma_wc_reply_flush);
+DEFINE_SEND_FLUSH_EVENT(svcrdma_wc_reply_err);
+
 TRACE_EVENT(svcrdma_qp_error,
 	TP_PROTO(
 		const struct ib_event *event,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index c00fcce61d1e..2ca3c6311c5e 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -197,28 +197,6 @@ void svc_rdma_cc_release(struct svcxprt_rdma *rdma,
 		llist_add_batch(first, last, &rdma->sc_rw_ctxts);
 }
 
-/* State for sending a Write or Reply chunk.
- *  - Tracks progress of writing one chunk over all its segments
- *  - Stores arguments for the SGL constructor functions
- */
-struct svc_rdma_write_info {
-	struct svcxprt_rdma	*wi_rdma;
-
-	const struct svc_rdma_chunk	*wi_chunk;
-
-	/* write state of this chunk */
-	unsigned int		wi_seg_off;
-	unsigned int		wi_seg_no;
-
-	/* SGL constructor arguments */
-	const struct xdr_buf	*wi_xdr;
-	unsigned char		*wi_base;
-	unsigned int		wi_next_off;
-
-	struct svc_rdma_chunk_ctxt	wi_cc;
-	struct work_struct	wi_work;
-};
-
 static struct svc_rdma_write_info *
 svc_rdma_write_info_alloc(struct svcxprt_rdma *rdma,
 			  const struct svc_rdma_chunk *chunk)
@@ -252,6 +230,43 @@ static void svc_rdma_write_info_free(struct svc_rdma_write_info *info)
 	queue_work(svcrdma_wq, &info->wi_work);
 }
 
+static void svc_rdma_reply_chunk_release(struct svcxprt_rdma *rdma,
+					 struct svc_rdma_chunk_ctxt *cc)
+{
+	svc_rdma_wake_send_waiters(rdma, cc->cc_sqecount);
+	svc_rdma_cc_release(rdma, cc, DMA_TO_DEVICE);
+}
+
+/**
+ * svc_rdma_reply_done - Reply chunk Write completion handler
+ * @cq: controlling Completion Queue
+ * @wc: Work Completion report
+ *
+ * Pages under I/O are released by a subsequent Send completion.
+ */
+static void svc_rdma_reply_done(struct ib_cq *cq, struct ib_wc *wc)
+{
+	struct ib_cqe *cqe = wc->wr_cqe;
+	struct svc_rdma_chunk_ctxt *cc =
+			container_of(cqe, struct svc_rdma_chunk_ctxt, cc_cqe);
+	struct svcxprt_rdma *rdma = cq->cq_context;
+
+	switch (wc->status) {
+	case IB_WC_SUCCESS:
+		trace_svcrdma_wc_reply(&cc->cc_cid);
+		svc_rdma_reply_chunk_release(rdma, cc);
+		return;
+	case IB_WC_WR_FLUSH_ERR:
+		trace_svcrdma_wc_reply_flush(wc, &cc->cc_cid);
+		break;
+	default:
+		trace_svcrdma_wc_reply_err(wc, &cc->cc_cid);
+	}
+
+	svc_rdma_reply_chunk_release(rdma, cc);
+	svc_xprt_deferred_close(&rdma->sc_xprt);
+}
+
 /**
  * svc_rdma_write_done - Write chunk completion
  * @cq: controlling Completion Queue
@@ -624,7 +639,8 @@ int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
 /**
  * svc_rdma_send_reply_chunk - Write all segments in the Reply chunk
  * @rdma: controlling RDMA transport
- * @rctxt: Write and Reply chunks from client
+ * @rctxt: Write and Reply chunks provisioned by the client
+ * @sctxt: Send WR resources
  * @xdr: xdr_buf containing an RPC Reply
  *
  * Returns a non-negative number of bytes the chunk consumed, or
@@ -636,37 +652,34 @@ int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
  */
 int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 			      const struct svc_rdma_recv_ctxt *rctxt,
+			      struct svc_rdma_send_ctxt *sctxt,
 			      const struct xdr_buf *xdr)
 {
-	struct svc_rdma_write_info *info;
-	struct svc_rdma_chunk_ctxt *cc;
-	struct svc_rdma_chunk *chunk;
+	struct svc_rdma_write_info *info = &sctxt->sc_reply_info;
+	struct svc_rdma_chunk_ctxt *cc = &info->wi_cc;
 	int ret;
 
-	if (pcl_is_empty(&rctxt->rc_reply_pcl))
-		return 0;
+	if (likely(pcl_is_empty(&rctxt->rc_reply_pcl)))
+		return 0;	/* client provided no Reply chunk */
 
-	chunk = pcl_first_chunk(&rctxt->rc_reply_pcl);
-	info = svc_rdma_write_info_alloc(rdma, chunk);
-	if (!info)
-		return -ENOMEM;
-	cc = &info->wi_cc;
+	info->wi_rdma = rdma;
+	info->wi_chunk = pcl_first_chunk(&rctxt->rc_reply_pcl);
+	info->wi_seg_off = 0;
+	info->wi_seg_no = 0;
+	svc_rdma_cc_init(rdma, &info->wi_cc);
+	info->wi_cc.cc_cqe.done = svc_rdma_reply_done;
 
 	ret = pcl_process_nonpayloads(&rctxt->rc_write_pcl, xdr,
 				      svc_rdma_xb_write, info);
 	if (ret < 0)
-		goto out_err;
+		return ret;
 
 	trace_svcrdma_post_reply_chunk(&cc->cc_cid, cc->cc_sqecount);
 	ret = svc_rdma_post_chunk_ctxt(rdma, cc);
 	if (ret < 0)
-		goto out_err;
+		return ret;
 
 	return xdr->len;
-
-out_err:
-	svc_rdma_write_info_free(info);
-	return ret;
 }
 
 /**
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 0f02fb09d5b0..d8e079be36e2 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -1012,7 +1012,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	if (!p)
 		goto put_ctxt;
 
-	ret = svc_rdma_send_reply_chunk(rdma, rctxt, &rqstp->rq_res);
+	ret = svc_rdma_send_reply_chunk(rdma, rctxt, sctxt, &rqstp->rq_res);
 	if (ret < 0)
 		goto reply_chunk;
 	rc_size = ret;



