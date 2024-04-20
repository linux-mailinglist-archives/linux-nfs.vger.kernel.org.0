Return-Path: <linux-nfs+bounces-2901-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5CB8ABC29
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Apr 2024 17:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B0C1F212E4
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Apr 2024 15:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8820926291;
	Sat, 20 Apr 2024 15:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNsTAu/Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A65E17552;
	Sat, 20 Apr 2024 15:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713626323; cv=none; b=NJzl0RsESbYKaaMIbBCuWXhnjjx9e67k5zAw9+Pka8XfUE7c/L41VC/NtxRfxw/VnNOLOWFEQ8fO4PeiqgebzMxyzDsEVbzzZU5ANxAojc6r591m+n0/7tTDm1Ireoyr8bACf5is6GHZ/LdZpHa6+ckbo6nM4fpIFDm8Y5SOYIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713626323; c=relaxed/simple;
	bh=xPDpV0hJKhQqWHl5SPwdFGEjfiLi4Md8/X1oaCOjla8=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=k/2d0o75J4oA4fMGCDuwh+Ux7FLqdwqGtjxEm4LybiWfaFLXXVstDLkSM411lXmzLBuP2U4Si9W3l+8C3N6RIUv3Kad6ZiGOyCleIOUMLh4L+tg3Mlgb4CmZ6pQmZX4tWVg998v3fN0q4CfHop/M4oyCLd/f/yIo4PaIMriklDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNsTAu/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF82C072AA;
	Sat, 20 Apr 2024 15:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713626323;
	bh=xPDpV0hJKhQqWHl5SPwdFGEjfiLi4Md8/X1oaCOjla8=;
	h=Subject:From:To:Cc:Date:From;
	b=fNsTAu/ZxO5i02nOuC7qMxg+Br2z4hmTGf6tMNu53eKDWL4sPF8pttieCdDAKHxki
	 gln56fBuzD4aIqNvZxoVLUZGEBLK8E7aNKhXBGVYBRvUlPtJ6y6mcVB2FXXnd/xd28
	 gvfl4xp1Iz9wsl5AMp49WfwJ7KIRn7Fh1Ty+IydAv5iwHoPJEYlV5VHVwvMkyt/Imo
	 KdFMoJ1bu4+ujj36yP7ljzz973VD/UsJ/nTwnYOtjnbKVh7GKIEZsAYBSVVaGwwHJn
	 v5wwqHT7D+jUsP1cNbLf+pFH1nWeywXQLu63FKLErSsVmKA2Se/aH9C0Dq2yd211e1
	 4MvlGXW4GKlmg==
Subject: [PATCH] Revert "svcrdma: Add Write chunk WRs to the RPC's Send WR
 chain"
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: linux-rdma@vger.kernel.org
Date: Sat, 20 Apr 2024 11:18:41 -0400
Message-ID: 
 <171362632165.3080.2245136667286784440.stgit@klimt.1015granger.net>
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

Performance regression reported with NFS/RDMA using Omnipath.
Tracing on the server reports:

  nfsd-7771  [060]  1758.891809: svcrdma_sq_post_err:
	cq.id=205 cid=226 sc_sq_avail=13643/851 status=-12

sq_post_err reports ENOMEM, and the rdma->sc_sq_avail (13643) is
larger than rdma->sc_sq_depth (851). The number of available Send
Queue entries is always supposed to be smaller than the Send Queue
depth. That seems like a Send Queue accounting bug in svcrdma.

As it's getting to be late in the 6.9-rc cycle, revert this commit.
It can be revisited in a subsequent kernel release.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218743
Fixes: e084ee673c77 ("svcrdma: Add Write chunk WRs to the RPC's Send WR chain")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h       |   13 +----
 net/sunrpc/xprtrdma/svc_rdma_rw.c     |   86 ++++++++-------------------------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |    5 --
 3 files changed, 26 insertions(+), 78 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 24cd199dd6f3..d33bab33099a 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -210,7 +210,6 @@ struct svc_rdma_recv_ctxt {
  */
 struct svc_rdma_write_info {
 	struct svcxprt_rdma	*wi_rdma;
-	struct list_head	wi_list;
 
 	const struct svc_rdma_chunk	*wi_chunk;
 
@@ -239,10 +238,7 @@ struct svc_rdma_send_ctxt {
 	struct ib_cqe		sc_cqe;
 	struct xdr_buf		sc_hdrbuf;
 	struct xdr_stream	sc_stream;
-
-	struct list_head	sc_write_info_list;
 	struct svc_rdma_write_info sc_reply_info;
-
 	void			*sc_xprt_buf;
 	int			sc_page_count;
 	int			sc_cur_sge_no;
@@ -274,14 +270,11 @@ extern void svc_rdma_cc_init(struct svcxprt_rdma *rdma,
 extern void svc_rdma_cc_release(struct svcxprt_rdma *rdma,
 				struct svc_rdma_chunk_ctxt *cc,
 				enum dma_data_direction dir);
-extern void svc_rdma_write_chunk_release(struct svcxprt_rdma *rdma,
-					 struct svc_rdma_send_ctxt *ctxt);
 extern void svc_rdma_reply_chunk_release(struct svcxprt_rdma *rdma,
 					 struct svc_rdma_send_ctxt *ctxt);
-extern int svc_rdma_prepare_write_list(struct svcxprt_rdma *rdma,
-				       const struct svc_rdma_pcl *write_pcl,
-				       struct svc_rdma_send_ctxt *sctxt,
-				       const struct xdr_buf *xdr);
+extern int svc_rdma_send_write_list(struct svcxprt_rdma *rdma,
+				    const struct svc_rdma_recv_ctxt *rctxt,
+				    const struct xdr_buf *xdr);
 extern int svc_rdma_prepare_reply_chunk(struct svcxprt_rdma *rdma,
 					const struct svc_rdma_pcl *write_pcl,
 					const struct svc_rdma_pcl *reply_pcl,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index f2a100c4c81f..40797114d50a 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -230,28 +230,6 @@ static void svc_rdma_write_info_free(struct svc_rdma_write_info *info)
 	queue_work(svcrdma_wq, &info->wi_work);
 }
 
-/**
- * svc_rdma_write_chunk_release - Release Write chunk I/O resources
- * @rdma: controlling transport
- * @ctxt: Send context that is being released
- */
-void svc_rdma_write_chunk_release(struct svcxprt_rdma *rdma,
-				  struct svc_rdma_send_ctxt *ctxt)
-{
-	struct svc_rdma_write_info *info;
-	struct svc_rdma_chunk_ctxt *cc;
-
-	while (!list_empty(&ctxt->sc_write_info_list)) {
-		info = list_first_entry(&ctxt->sc_write_info_list,
-					struct svc_rdma_write_info, wi_list);
-		list_del(&info->wi_list);
-
-		cc = &info->wi_cc;
-		svc_rdma_wake_send_waiters(rdma, cc->cc_sqecount);
-		svc_rdma_write_info_free(info);
-	}
-}
-
 /**
  * svc_rdma_reply_chunk_release - Release Reply chunk I/O resources
  * @rdma: controlling transport
@@ -308,11 +286,13 @@ static void svc_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct ib_cqe *cqe = wc->wr_cqe;
 	struct svc_rdma_chunk_ctxt *cc =
 			container_of(cqe, struct svc_rdma_chunk_ctxt, cc_cqe);
+	struct svc_rdma_write_info *info =
+			container_of(cc, struct svc_rdma_write_info, wi_cc);
 
 	switch (wc->status) {
 	case IB_WC_SUCCESS:
 		trace_svcrdma_wc_write(&cc->cc_cid);
-		return;
+		break;
 	case IB_WC_WR_FLUSH_ERR:
 		trace_svcrdma_wc_write_flush(wc, &cc->cc_cid);
 		break;
@@ -320,11 +300,12 @@ static void svc_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc)
 		trace_svcrdma_wc_write_err(wc, &cc->cc_cid);
 	}
 
-	/* The RDMA Write has flushed, so the client won't get
-	 * some of the outgoing RPC message. Signal the loss
-	 * to the client by closing the connection.
-	 */
-	svc_xprt_deferred_close(&rdma->sc_xprt);
+	svc_rdma_wake_send_waiters(rdma, cc->cc_sqecount);
+
+	if (unlikely(wc->status != IB_WC_SUCCESS))
+		svc_xprt_deferred_close(&rdma->sc_xprt);
+
+	svc_rdma_write_info_free(info);
 }
 
 /**
@@ -620,19 +601,13 @@ static int svc_rdma_xb_write(const struct xdr_buf *xdr, void *data)
 	return xdr->len;
 }
 
-/* Link Write WRs for @chunk onto @sctxt's WR chain.
- */
-static int svc_rdma_prepare_write_chunk(struct svcxprt_rdma *rdma,
-					struct svc_rdma_send_ctxt *sctxt,
-					const struct svc_rdma_chunk *chunk,
-					const struct xdr_buf *xdr)
+static int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
+				     const struct svc_rdma_chunk *chunk,
+				     const struct xdr_buf *xdr)
 {
 	struct svc_rdma_write_info *info;
 	struct svc_rdma_chunk_ctxt *cc;
-	struct ib_send_wr *first_wr;
 	struct xdr_buf payload;
-	struct list_head *pos;
-	struct ib_cqe *cqe;
 	int ret;
 
 	if (xdr_buf_subsegment(xdr, &payload, chunk->ch_position,
@@ -648,25 +623,10 @@ static int svc_rdma_prepare_write_chunk(struct svcxprt_rdma *rdma,
 	if (ret != payload.len)
 		goto out_err;
 
-	ret = -EINVAL;
-	if (unlikely(cc->cc_sqecount > rdma->sc_sq_depth))
-		goto out_err;
-
-	first_wr = sctxt->sc_wr_chain;
-	cqe = &cc->cc_cqe;
-	list_for_each(pos, &cc->cc_rwctxts) {
-		struct svc_rdma_rw_ctxt *rwc;
-
-		rwc = list_entry(pos, struct svc_rdma_rw_ctxt, rw_list);
-		first_wr = rdma_rw_ctx_wrs(&rwc->rw_ctx, rdma->sc_qp,
-					   rdma->sc_port_num, cqe, first_wr);
-		cqe = NULL;
-	}
-	sctxt->sc_wr_chain = first_wr;
-	sctxt->sc_sqecount += cc->cc_sqecount;
-	list_add(&info->wi_list, &sctxt->sc_write_info_list);
-
 	trace_svcrdma_post_write_chunk(&cc->cc_cid, cc->cc_sqecount);
+	ret = svc_rdma_post_chunk_ctxt(rdma, cc);
+	if (ret < 0)
+		goto out_err;
 	return 0;
 
 out_err:
@@ -675,27 +635,25 @@ static int svc_rdma_prepare_write_chunk(struct svcxprt_rdma *rdma,
 }
 
 /**
- * svc_rdma_prepare_write_list - Construct WR chain for sending Write list
+ * svc_rdma_send_write_list - Send all chunks on the Write list
  * @rdma: controlling RDMA transport
- * @write_pcl: Write list provisioned by the client
- * @sctxt: Send WR resources
+ * @rctxt: Write list provisioned by the client
  * @xdr: xdr_buf containing an RPC Reply message
  *
  * Returns zero on success, or a negative errno if one or more
  * Write chunks could not be sent.
  */
-int svc_rdma_prepare_write_list(struct svcxprt_rdma *rdma,
-				const struct svc_rdma_pcl *write_pcl,
-				struct svc_rdma_send_ctxt *sctxt,
-				const struct xdr_buf *xdr)
+int svc_rdma_send_write_list(struct svcxprt_rdma *rdma,
+			     const struct svc_rdma_recv_ctxt *rctxt,
+			     const struct xdr_buf *xdr)
 {
 	struct svc_rdma_chunk *chunk;
 	int ret;
 
-	pcl_for_each_chunk(chunk, write_pcl) {
+	pcl_for_each_chunk(chunk, &rctxt->rc_write_pcl) {
 		if (!chunk->ch_payload_length)
 			break;
-		ret = svc_rdma_prepare_write_chunk(rdma, sctxt, chunk, xdr);
+		ret = svc_rdma_send_write_chunk(rdma, chunk, xdr);
 		if (ret < 0)
 			return ret;
 	}
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index dfca39abd16c..bb5436b719e0 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -142,7 +142,6 @@ svc_rdma_send_ctxt_alloc(struct svcxprt_rdma *rdma)
 	ctxt->sc_send_wr.sg_list = ctxt->sc_sges;
 	ctxt->sc_send_wr.send_flags = IB_SEND_SIGNALED;
 	ctxt->sc_cqe.done = svc_rdma_wc_send;
-	INIT_LIST_HEAD(&ctxt->sc_write_info_list);
 	ctxt->sc_xprt_buf = buffer;
 	xdr_buf_init(&ctxt->sc_hdrbuf, ctxt->sc_xprt_buf,
 		     rdma->sc_max_req_size);
@@ -228,7 +227,6 @@ static void svc_rdma_send_ctxt_release(struct svcxprt_rdma *rdma,
 	struct ib_device *device = rdma->sc_cm_id->device;
 	unsigned int i;
 
-	svc_rdma_write_chunk_release(rdma, ctxt);
 	svc_rdma_reply_chunk_release(rdma, ctxt);
 
 	if (ctxt->sc_page_count)
@@ -1015,8 +1013,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	if (!p)
 		goto put_ctxt;
 
-	ret = svc_rdma_prepare_write_list(rdma, &rctxt->rc_write_pcl, sctxt,
-					  &rqstp->rq_res);
+	ret = svc_rdma_send_write_list(rdma, rctxt, &rqstp->rq_res);
 	if (ret < 0)
 		goto put_ctxt;
 



