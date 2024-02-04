Return-Path: <linux-nfs+bounces-1763-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA82B849190
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 00:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202AA2827DB
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Feb 2024 23:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8331D3D72;
	Sun,  4 Feb 2024 23:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVKgYlfO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A66ABE58;
	Sun,  4 Feb 2024 23:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707088669; cv=none; b=DmMrlRtTvCz4TNRJI4jS3U/1eLr4ETBBpJaXflImJPSRk9TvP74eUXIwrluhjbI6RjY/zuJDI34ndZwk7h4v5oRoG3C/GDTRs9egh/eev4D1wN1N3+fncRD7PZJWo/G6OViT870yl+/Uo6G5lk6vVWFpokEPzZ6808xAuen9YSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707088669; c=relaxed/simple;
	bh=fp9acj4ZEwK1Xq922shpXg6CpeNaFsC5ZBGJptxgrSI=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ar+LmMblstz94SilbJxPXRiSWppdx/8+2Tlk6nvkdti/3Y+cm72zZpuaQe8h8Hsy1kXtKr9vqlQsSN3qhaeqmX9s4XuLhPLF/872Z0pLWuxtRScFg73NhejeBLB/OMebkLd6YpvdRj3mApFiOEBjFjzgtdSRuNIqMVWbqr/K+B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVKgYlfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA1FC433C7;
	Sun,  4 Feb 2024 23:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707088668;
	bh=fp9acj4ZEwK1Xq922shpXg6CpeNaFsC5ZBGJptxgrSI=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=kVKgYlfOH3H8pGy/JciO7mEDiyvFgvBtogZFKPayJXY6S5JOQoG1XaGzTLcx5NbYt
	 QStZ8RzKP/6Bb3pzDLABD1IKfJU7W2n/ScuX7Wa8l0CWKOjTBc0RRYEqrd+zHOHgPt
	 m1c3y+ggNWw/cFujx+kAcsDTaMIWhFbadD09BAmZXAy6Z8aqOv5oJnY6UpkHpNzWro
	 7p9O7wBuoR2lAN3lOdVtS0pvPpPdT+yqpN81oLiavlC/uFudoBSXROW8nFkwO8zYOG
	 YB0EaIyijK6eGxV8w6AL+ekzx5FLejLmIiBGRoG/4/2WnANgLji/DkCYEZ+5nnKV8B
	 JIr0fBUXGC9cw==
Subject: [PATCH v2 12/12] svcrdma: Add Write chunk WRs to the RPC's Send WR
 chain
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Sun, 04 Feb 2024 18:17:47 -0500
Message-ID: 
 <170708866774.28128.5360136470502302905.stgit@bazille.1015granger.net>
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

Chain RDMA Writes that convey Write chunks onto the local Send
chain. This means all WRs for an RPC Reply are now posted with a
single ib_post_send() call, and there is a single Send completion
when all of these are done. That reduces both the per-transport
doorbell rate and completion rate.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h       |   13 ++++-
 net/sunrpc/xprtrdma/svc_rdma_rw.c     |   86 +++++++++++++++++++++++++--------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |    5 ++
 3 files changed, 78 insertions(+), 26 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index d33bab33099a..24cd199dd6f3 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -210,6 +210,7 @@ struct svc_rdma_recv_ctxt {
  */
 struct svc_rdma_write_info {
 	struct svcxprt_rdma	*wi_rdma;
+	struct list_head	wi_list;
 
 	const struct svc_rdma_chunk	*wi_chunk;
 
@@ -238,7 +239,10 @@ struct svc_rdma_send_ctxt {
 	struct ib_cqe		sc_cqe;
 	struct xdr_buf		sc_hdrbuf;
 	struct xdr_stream	sc_stream;
+
+	struct list_head	sc_write_info_list;
 	struct svc_rdma_write_info sc_reply_info;
+
 	void			*sc_xprt_buf;
 	int			sc_page_count;
 	int			sc_cur_sge_no;
@@ -270,11 +274,14 @@ extern void svc_rdma_cc_init(struct svcxprt_rdma *rdma,
 extern void svc_rdma_cc_release(struct svcxprt_rdma *rdma,
 				struct svc_rdma_chunk_ctxt *cc,
 				enum dma_data_direction dir);
+extern void svc_rdma_write_chunk_release(struct svcxprt_rdma *rdma,
+					 struct svc_rdma_send_ctxt *ctxt);
 extern void svc_rdma_reply_chunk_release(struct svcxprt_rdma *rdma,
 					 struct svc_rdma_send_ctxt *ctxt);
-extern int svc_rdma_send_write_list(struct svcxprt_rdma *rdma,
-				    const struct svc_rdma_recv_ctxt *rctxt,
-				    const struct xdr_buf *xdr);
+extern int svc_rdma_prepare_write_list(struct svcxprt_rdma *rdma,
+				       const struct svc_rdma_pcl *write_pcl,
+				       struct svc_rdma_send_ctxt *sctxt,
+				       const struct xdr_buf *xdr);
 extern int svc_rdma_prepare_reply_chunk(struct svcxprt_rdma *rdma,
 					const struct svc_rdma_pcl *write_pcl,
 					const struct svc_rdma_pcl *reply_pcl,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 40797114d50a..f2a100c4c81f 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -230,6 +230,28 @@ static void svc_rdma_write_info_free(struct svc_rdma_write_info *info)
 	queue_work(svcrdma_wq, &info->wi_work);
 }
 
+/**
+ * svc_rdma_write_chunk_release - Release Write chunk I/O resources
+ * @rdma: controlling transport
+ * @ctxt: Send context that is being released
+ */
+void svc_rdma_write_chunk_release(struct svcxprt_rdma *rdma,
+				  struct svc_rdma_send_ctxt *ctxt)
+{
+	struct svc_rdma_write_info *info;
+	struct svc_rdma_chunk_ctxt *cc;
+
+	while (!list_empty(&ctxt->sc_write_info_list)) {
+		info = list_first_entry(&ctxt->sc_write_info_list,
+					struct svc_rdma_write_info, wi_list);
+		list_del(&info->wi_list);
+
+		cc = &info->wi_cc;
+		svc_rdma_wake_send_waiters(rdma, cc->cc_sqecount);
+		svc_rdma_write_info_free(info);
+	}
+}
+
 /**
  * svc_rdma_reply_chunk_release - Release Reply chunk I/O resources
  * @rdma: controlling transport
@@ -286,13 +308,11 @@ static void svc_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct ib_cqe *cqe = wc->wr_cqe;
 	struct svc_rdma_chunk_ctxt *cc =
 			container_of(cqe, struct svc_rdma_chunk_ctxt, cc_cqe);
-	struct svc_rdma_write_info *info =
-			container_of(cc, struct svc_rdma_write_info, wi_cc);
 
 	switch (wc->status) {
 	case IB_WC_SUCCESS:
 		trace_svcrdma_wc_write(&cc->cc_cid);
-		break;
+		return;
 	case IB_WC_WR_FLUSH_ERR:
 		trace_svcrdma_wc_write_flush(wc, &cc->cc_cid);
 		break;
@@ -300,12 +320,11 @@ static void svc_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc)
 		trace_svcrdma_wc_write_err(wc, &cc->cc_cid);
 	}
 
-	svc_rdma_wake_send_waiters(rdma, cc->cc_sqecount);
-
-	if (unlikely(wc->status != IB_WC_SUCCESS))
-		svc_xprt_deferred_close(&rdma->sc_xprt);
-
-	svc_rdma_write_info_free(info);
+	/* The RDMA Write has flushed, so the client won't get
+	 * some of the outgoing RPC message. Signal the loss
+	 * to the client by closing the connection.
+	 */
+	svc_xprt_deferred_close(&rdma->sc_xprt);
 }
 
 /**
@@ -601,13 +620,19 @@ static int svc_rdma_xb_write(const struct xdr_buf *xdr, void *data)
 	return xdr->len;
 }
 
-static int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
-				     const struct svc_rdma_chunk *chunk,
-				     const struct xdr_buf *xdr)
+/* Link Write WRs for @chunk onto @sctxt's WR chain.
+ */
+static int svc_rdma_prepare_write_chunk(struct svcxprt_rdma *rdma,
+					struct svc_rdma_send_ctxt *sctxt,
+					const struct svc_rdma_chunk *chunk,
+					const struct xdr_buf *xdr)
 {
 	struct svc_rdma_write_info *info;
 	struct svc_rdma_chunk_ctxt *cc;
+	struct ib_send_wr *first_wr;
 	struct xdr_buf payload;
+	struct list_head *pos;
+	struct ib_cqe *cqe;
 	int ret;
 
 	if (xdr_buf_subsegment(xdr, &payload, chunk->ch_position,
@@ -623,10 +648,25 @@ static int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
 	if (ret != payload.len)
 		goto out_err;
 
-	trace_svcrdma_post_write_chunk(&cc->cc_cid, cc->cc_sqecount);
-	ret = svc_rdma_post_chunk_ctxt(rdma, cc);
-	if (ret < 0)
+	ret = -EINVAL;
+	if (unlikely(cc->cc_sqecount > rdma->sc_sq_depth))
 		goto out_err;
+
+	first_wr = sctxt->sc_wr_chain;
+	cqe = &cc->cc_cqe;
+	list_for_each(pos, &cc->cc_rwctxts) {
+		struct svc_rdma_rw_ctxt *rwc;
+
+		rwc = list_entry(pos, struct svc_rdma_rw_ctxt, rw_list);
+		first_wr = rdma_rw_ctx_wrs(&rwc->rw_ctx, rdma->sc_qp,
+					   rdma->sc_port_num, cqe, first_wr);
+		cqe = NULL;
+	}
+	sctxt->sc_wr_chain = first_wr;
+	sctxt->sc_sqecount += cc->cc_sqecount;
+	list_add(&info->wi_list, &sctxt->sc_write_info_list);
+
+	trace_svcrdma_post_write_chunk(&cc->cc_cid, cc->cc_sqecount);
 	return 0;
 
 out_err:
@@ -635,25 +675,27 @@ static int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
 }
 
 /**
- * svc_rdma_send_write_list - Send all chunks on the Write list
+ * svc_rdma_prepare_write_list - Construct WR chain for sending Write list
  * @rdma: controlling RDMA transport
- * @rctxt: Write list provisioned by the client
+ * @write_pcl: Write list provisioned by the client
+ * @sctxt: Send WR resources
  * @xdr: xdr_buf containing an RPC Reply message
  *
  * Returns zero on success, or a negative errno if one or more
  * Write chunks could not be sent.
  */
-int svc_rdma_send_write_list(struct svcxprt_rdma *rdma,
-			     const struct svc_rdma_recv_ctxt *rctxt,
-			     const struct xdr_buf *xdr)
+int svc_rdma_prepare_write_list(struct svcxprt_rdma *rdma,
+				const struct svc_rdma_pcl *write_pcl,
+				struct svc_rdma_send_ctxt *sctxt,
+				const struct xdr_buf *xdr)
 {
 	struct svc_rdma_chunk *chunk;
 	int ret;
 
-	pcl_for_each_chunk(chunk, &rctxt->rc_write_pcl) {
+	pcl_for_each_chunk(chunk, write_pcl) {
 		if (!chunk->ch_payload_length)
 			break;
-		ret = svc_rdma_send_write_chunk(rdma, chunk, xdr);
+		ret = svc_rdma_prepare_write_chunk(rdma, sctxt, chunk, xdr);
 		if (ret < 0)
 			return ret;
 	}
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index bb5436b719e0..dfca39abd16c 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -142,6 +142,7 @@ svc_rdma_send_ctxt_alloc(struct svcxprt_rdma *rdma)
 	ctxt->sc_send_wr.sg_list = ctxt->sc_sges;
 	ctxt->sc_send_wr.send_flags = IB_SEND_SIGNALED;
 	ctxt->sc_cqe.done = svc_rdma_wc_send;
+	INIT_LIST_HEAD(&ctxt->sc_write_info_list);
 	ctxt->sc_xprt_buf = buffer;
 	xdr_buf_init(&ctxt->sc_hdrbuf, ctxt->sc_xprt_buf,
 		     rdma->sc_max_req_size);
@@ -227,6 +228,7 @@ static void svc_rdma_send_ctxt_release(struct svcxprt_rdma *rdma,
 	struct ib_device *device = rdma->sc_cm_id->device;
 	unsigned int i;
 
+	svc_rdma_write_chunk_release(rdma, ctxt);
 	svc_rdma_reply_chunk_release(rdma, ctxt);
 
 	if (ctxt->sc_page_count)
@@ -1013,7 +1015,8 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	if (!p)
 		goto put_ctxt;
 
-	ret = svc_rdma_send_write_list(rdma, rctxt, &rqstp->rq_res);
+	ret = svc_rdma_prepare_write_list(rdma, &rctxt->rc_write_pcl, sctxt,
+					  &rqstp->rq_res);
 	if (ret < 0)
 		goto put_ctxt;
 



