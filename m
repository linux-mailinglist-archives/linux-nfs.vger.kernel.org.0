Return-Path: <linux-nfs+bounces-1761-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E12084918D
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 00:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF23AB2137D
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Feb 2024 23:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7723D72;
	Sun,  4 Feb 2024 23:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mD32fxV9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3700BE4E;
	Sun,  4 Feb 2024 23:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707088656; cv=none; b=A/iT21G6tjRTgLmKSC603BNVK6QLD62YIDDspznbmQeBbm0eZzWac/JR0V6AL2DNDV5LOjO12xtG1awanNMsd+FMjliseCoyvUCzb3iwfFNYUdO1afx3nMCSCvv0gjEGuvlc6JIoUsKbdDR+p1huk5Jvc2dbDwgF7NNupobnM88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707088656; c=relaxed/simple;
	bh=4V5S/JIS1CnIKji7O7YFq/SoJn6dnb/EkM8BkRXCb1w=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QFXj/EcqkGtqP0b9j4HohJ5kGAo9L6jL4tsvlkfV3QOdyM0Ve9vcxnq8lh9+6u6aFoDlB2IB8tDph2ozXnD2RDawugHZqrsDijX70pjlZ7suzyCj2KtTbYEDD3j0hXo52LdIV8KNsg96bc3BDR1l4eQUMH998HsipFOHbm1O+8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mD32fxV9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BB8C433C7;
	Sun,  4 Feb 2024 23:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707088656;
	bh=4V5S/JIS1CnIKji7O7YFq/SoJn6dnb/EkM8BkRXCb1w=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=mD32fxV9IWxVF1iTZBIPh70isLNERx4GJy0VuaEkTCi/Xc/SWPvpvfGWE6XiIZ5Hw
	 Co2jC0uMHOdMZKq8DfeNeDAIKxlncEOZTnOna1Ds//yovVibgGePUf3ChtaKf2sl8I
	 feQucCyIOLL6uRrJKYhthgqfEKBxTnf7KUp6GWAuI2DP4eh8Tdm0S90eyRxM+nlaGi
	 i4rZp5QJSl6eGVT2aVHws/3ClCHGh9Mcgm6dxI4MrCBvgA1wjpvRCDC/jxg7K+Yocy
	 x5rsHJ5jmHZI9lP6A2iYbWJ7M85ShxLHP6DyDZlZ93uDFkbOcldHF4n7CsgnBsDvzM
	 xLiA7+OZCgRhw==
Subject: [PATCH v2 10/12] svcrdma: Post the Reply chunk and Send WR together
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Sun, 04 Feb 2024 18:17:34 -0500
Message-ID: 
 <170708865497.28128.14505363034918718792.stgit@bazille.1015granger.net>
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

Reduce the doorbell and Send completion rates when sending RPC/RDMA
replies that have Reply chunks. NFS READDIR procedures typically
return their result in a Reply chunk, for example.

Instead of calling ib_post_send() to post the Write WRs for the
Reply chunk, and then calling it again to post the Send WR that
conveys the transport header, chain the Write WRs to the Send WR
and call ib_post_send() only once.

Thanks to the Send Queue completion ordering rules, when the Send
WR completes, that guarantees that Write WRs posted before it have
also completed successfully. Thus all Write WRs for the Reply chunk
can remain unsignaled. Instead of handling a Write completion and
then a Send completion, only the Send completion is seen, and it
handles clean up for both the Writes and the Send.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h       |   13 +++++--
 net/sunrpc/xprtrdma/svc_rdma_rw.c     |   58 +++++++++++++++++++++------------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   34 +++++++++++--------
 3 files changed, 66 insertions(+), 39 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 918cf4fda728..ac882bd23ca2 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -262,19 +262,24 @@ extern void svc_rdma_release_ctxt(struct svc_xprt *xprt, void *ctxt);
 extern int svc_rdma_recvfrom(struct svc_rqst *);
 
 /* svc_rdma_rw.c */
+extern void svc_rdma_cc_init(struct svcxprt_rdma *rdma,
+			     struct svc_rdma_chunk_ctxt *cc);
 extern void svc_rdma_destroy_rw_ctxts(struct svcxprt_rdma *rdma);
 extern void svc_rdma_cc_init(struct svcxprt_rdma *rdma,
 			     struct svc_rdma_chunk_ctxt *cc);
 extern void svc_rdma_cc_release(struct svcxprt_rdma *rdma,
 				struct svc_rdma_chunk_ctxt *cc,
 				enum dma_data_direction dir);
+extern void svc_rdma_reply_chunk_release(struct svcxprt_rdma *rdma,
+					 struct svc_rdma_send_ctxt *ctxt);
 extern int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
 				     const struct svc_rdma_chunk *chunk,
 				     const struct xdr_buf *xdr);
-extern int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
-				     const struct svc_rdma_recv_ctxt *rctxt,
-				     struct svc_rdma_send_ctxt *sctxt,
-				     const struct xdr_buf *xdr);
+extern int svc_rdma_prepare_reply_chunk(struct svcxprt_rdma *rdma,
+					const struct svc_rdma_pcl *write_pcl,
+					const struct svc_rdma_pcl *reply_pcl,
+					struct svc_rdma_send_ctxt *sctxt,
+					const struct xdr_buf *xdr);
 extern int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
 				      struct svc_rqst *rqstp,
 				      struct svc_rdma_recv_ctxt *head);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 2ca3c6311c5e..2b25edc6c73c 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -230,10 +230,18 @@ static void svc_rdma_write_info_free(struct svc_rdma_write_info *info)
 	queue_work(svcrdma_wq, &info->wi_work);
 }
 
-static void svc_rdma_reply_chunk_release(struct svcxprt_rdma *rdma,
-					 struct svc_rdma_chunk_ctxt *cc)
+/**
+ * svc_rdma_reply_chunk_release - Release Reply chunk I/O resources
+ * @rdma: controlling transport
+ * @ctxt: Send context that is being released
+ */
+void svc_rdma_reply_chunk_release(struct svcxprt_rdma *rdma,
+				  struct svc_rdma_send_ctxt *ctxt)
 {
-	svc_rdma_wake_send_waiters(rdma, cc->cc_sqecount);
+	struct svc_rdma_chunk_ctxt *cc = &ctxt->sc_reply_info.wi_cc;
+
+	if (!cc->cc_sqecount)
+		return;
 	svc_rdma_cc_release(rdma, cc, DMA_TO_DEVICE);
 }
 
@@ -254,7 +262,6 @@ static void svc_rdma_reply_done(struct ib_cq *cq, struct ib_wc *wc)
 	switch (wc->status) {
 	case IB_WC_SUCCESS:
 		trace_svcrdma_wc_reply(&cc->cc_cid);
-		svc_rdma_reply_chunk_release(rdma, cc);
 		return;
 	case IB_WC_WR_FLUSH_ERR:
 		trace_svcrdma_wc_reply_flush(wc, &cc->cc_cid);
@@ -263,7 +270,6 @@ static void svc_rdma_reply_done(struct ib_cq *cq, struct ib_wc *wc)
 		trace_svcrdma_wc_reply_err(wc, &cc->cc_cid);
 	}
 
-	svc_rdma_reply_chunk_release(rdma, cc);
 	svc_xprt_deferred_close(&rdma->sc_xprt);
 }
 
@@ -637,9 +643,10 @@ int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
 }
 
 /**
- * svc_rdma_send_reply_chunk - Write all segments in the Reply chunk
+ * svc_rdma_prepare_reply_chunk - Construct WR chain for writing the Reply chunk
  * @rdma: controlling RDMA transport
- * @rctxt: Write and Reply chunks provisioned by the client
+ * @write_pcl: Write chunk list provided by client
+ * @reply_pcl: Reply chunk provided by client
  * @sctxt: Send WR resources
  * @xdr: xdr_buf containing an RPC Reply
  *
@@ -650,35 +657,44 @@ int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
  *	%-ENOTCONN if posting failed (connection is lost),
  *	%-EIO if rdma_rw initialization failed (DMA mapping, etc).
  */
-int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
-			      const struct svc_rdma_recv_ctxt *rctxt,
-			      struct svc_rdma_send_ctxt *sctxt,
-			      const struct xdr_buf *xdr)
+int svc_rdma_prepare_reply_chunk(struct svcxprt_rdma *rdma,
+				 const struct svc_rdma_pcl *write_pcl,
+				 const struct svc_rdma_pcl *reply_pcl,
+				 struct svc_rdma_send_ctxt *sctxt,
+				 const struct xdr_buf *xdr)
 {
 	struct svc_rdma_write_info *info = &sctxt->sc_reply_info;
 	struct svc_rdma_chunk_ctxt *cc = &info->wi_cc;
+	struct ib_send_wr *first_wr;
+	struct list_head *pos;
+	struct ib_cqe *cqe;
 	int ret;
 
-	if (likely(pcl_is_empty(&rctxt->rc_reply_pcl)))
-		return 0;	/* client provided no Reply chunk */
-
 	info->wi_rdma = rdma;
-	info->wi_chunk = pcl_first_chunk(&rctxt->rc_reply_pcl);
+	info->wi_chunk = pcl_first_chunk(reply_pcl);
 	info->wi_seg_off = 0;
 	info->wi_seg_no = 0;
-	svc_rdma_cc_init(rdma, &info->wi_cc);
 	info->wi_cc.cc_cqe.done = svc_rdma_reply_done;
 
-	ret = pcl_process_nonpayloads(&rctxt->rc_write_pcl, xdr,
+	ret = pcl_process_nonpayloads(write_pcl, xdr,
 				      svc_rdma_xb_write, info);
 	if (ret < 0)
 		return ret;
 
-	trace_svcrdma_post_reply_chunk(&cc->cc_cid, cc->cc_sqecount);
-	ret = svc_rdma_post_chunk_ctxt(rdma, cc);
-	if (ret < 0)
-		return ret;
+	first_wr = sctxt->sc_wr_chain;
+	cqe = &cc->cc_cqe;
+	list_for_each(pos, &cc->cc_rwctxts) {
+		struct svc_rdma_rw_ctxt *rwc;
 
+		rwc = list_entry(pos, struct svc_rdma_rw_ctxt, rw_list);
+		first_wr = rdma_rw_ctx_wrs(&rwc->rw_ctx, rdma->sc_qp,
+					   rdma->sc_port_num, cqe, first_wr);
+		cqe = NULL;
+	}
+	sctxt->sc_wr_chain = first_wr;
+	sctxt->sc_sqecount += cc->cc_sqecount;
+
+	trace_svcrdma_post_reply_chunk(&cc->cc_cid, cc->cc_sqecount);
 	return xdr->len;
 }
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index d8e079be36e2..6dfd2232ce5b 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -205,6 +205,7 @@ struct svc_rdma_send_ctxt *svc_rdma_send_ctxt_get(struct svcxprt_rdma *rdma)
 	xdr_init_encode(&ctxt->sc_stream, &ctxt->sc_hdrbuf,
 			ctxt->sc_xprt_buf, NULL);
 
+	svc_rdma_cc_init(rdma, &ctxt->sc_reply_info.wi_cc);
 	ctxt->sc_send_wr.num_sge = 0;
 	ctxt->sc_cur_sge_no = 0;
 	ctxt->sc_page_count = 0;
@@ -226,6 +227,8 @@ static void svc_rdma_send_ctxt_release(struct svcxprt_rdma *rdma,
 	struct ib_device *device = rdma->sc_cm_id->device;
 	unsigned int i;
 
+	svc_rdma_reply_chunk_release(rdma, ctxt);
+
 	if (ctxt->sc_page_count)
 		release_pages(ctxt->sc_pages, ctxt->sc_page_count);
 
@@ -867,16 +870,10 @@ static void svc_rdma_save_io_pages(struct svc_rqst *rqstp,
  * in sc_sges[0], and the RPC xdr_buf is prepared in following sges.
  *
  * Depending on whether a Write list or Reply chunk is present,
- * the server may send all, a portion of, or none of the xdr_buf.
+ * the server may Send all, a portion of, or none of the xdr_buf.
  * In the latter case, only the transport header (sc_sges[0]) is
  * transmitted.
  *
- * RDMA Send is the last step of transmitting an RPC reply. Pages
- * involved in the earlier RDMA Writes are here transferred out
- * of the rqstp and into the sctxt's page array. These pages are
- * DMA unmapped by each Write completion, but the subsequent Send
- * completion finally releases these pages.
- *
  * Assumptions:
  * - The Reply's transport header will never be larger than a page.
  */
@@ -885,6 +882,7 @@ static int svc_rdma_send_reply_msg(struct svcxprt_rdma *rdma,
 				   const struct svc_rdma_recv_ctxt *rctxt,
 				   struct svc_rqst *rqstp)
 {
+	struct ib_send_wr *send_wr = &sctxt->sc_send_wr;
 	int ret;
 
 	ret = svc_rdma_map_reply_msg(rdma, sctxt, &rctxt->rc_write_pcl,
@@ -892,13 +890,16 @@ static int svc_rdma_send_reply_msg(struct svcxprt_rdma *rdma,
 	if (ret < 0)
 		return ret;
 
+	/* Transfer pages involved in RDMA Writes to the sctxt's
+	 * page array. Completion handling releases these pages.
+	 */
 	svc_rdma_save_io_pages(rqstp, sctxt);
 
 	if (rctxt->rc_inv_rkey) {
-		sctxt->sc_send_wr.opcode = IB_WR_SEND_WITH_INV;
-		sctxt->sc_send_wr.ex.invalidate_rkey = rctxt->rc_inv_rkey;
+		send_wr->opcode = IB_WR_SEND_WITH_INV;
+		send_wr->ex.invalidate_rkey = rctxt->rc_inv_rkey;
 	} else {
-		sctxt->sc_send_wr.opcode = IB_WR_SEND;
+		send_wr->opcode = IB_WR_SEND;
 	}
 
 	return svc_rdma_post_send(rdma, sctxt);
@@ -1012,10 +1013,15 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	if (!p)
 		goto put_ctxt;
 
-	ret = svc_rdma_send_reply_chunk(rdma, rctxt, sctxt, &rqstp->rq_res);
-	if (ret < 0)
-		goto reply_chunk;
-	rc_size = ret;
+	rc_size = 0;
+	if (!pcl_is_empty(&rctxt->rc_reply_pcl)) {
+		ret = svc_rdma_prepare_reply_chunk(rdma, &rctxt->rc_write_pcl,
+						   &rctxt->rc_reply_pcl, sctxt,
+						   &rqstp->rq_res);
+		if (ret < 0)
+			goto reply_chunk;
+		rc_size = ret;
+	}
 
 	*p++ = *rdma_argp;
 	*p++ = *(rdma_argp + 1);



