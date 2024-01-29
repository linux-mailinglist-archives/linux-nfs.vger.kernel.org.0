Return-Path: <linux-nfs+bounces-1558-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC338408FD
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 15:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06E4EB226DE
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 14:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329F5152DE8;
	Mon, 29 Jan 2024 14:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiRLXvij"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF2414460B;
	Mon, 29 Jan 2024 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539877; cv=none; b=SQQDxfkjo1Grc3MY8GAgEbrrfyb85B+CFau3hU0LzFpwdIvWQE1zka2erCgvTbN3cJKlpT2lVQFe5apOzDJuDuHOjcZ2KdrP/FqsFEdpztNIaWSlcc72vumEUvGcSp5xYWwtcdPuKRqDd5ECO67Xdjhtm4xnCmmOgHmkEXSz3hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539877; c=relaxed/simple;
	bh=rPH08YEEIQsOio03nQ7ZFxrHGUJoeYPgGbyedryQQy8=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dt9gquUND0FjrDOrSl0BmEQ6iWjl1VyNfPMAWxzGUQD6fPGhMkRvb6pmTz6mQnej5223VnYbNZ44PspC4fMq/hx6adrLRAZatYs35F6rdWYcrWgjLOKtjBEcefBB7dsYsfrnFBtvp/PZsXgf31Km+kdmeUPKIAa3uU6w/NR6p24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiRLXvij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C04FC433C7;
	Mon, 29 Jan 2024 14:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706539876;
	bh=rPH08YEEIQsOio03nQ7ZFxrHGUJoeYPgGbyedryQQy8=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=tiRLXvijUio9p9U6K0PBbTAwVRK9VTg6MYpKFy1J3C8ueBcgWN13Lz1w/Qi4oj7Id
	 uitKthZm2fn0P0ceNx3IPhBbQj3DtxJjHtidjdqjbGEGB4f0VyWY8WifrkVp34l53m
	 8llcO6OiNbfmS0tWQvfDmVVGz3Fdv3prxAzG8gbS0jV+C6G9G6B1I6by5ICxU4mXZ2
	 urw3W4C4ZMwYdNej18FGPW8UL6ccJ0PVCu+NIW2VtQ7rQn/6G3zEoxNm10aH+f0yP2
	 3VAuG3zz+hBCru581R9mwDO09iOMQXIPEIzulWm7y0mPXATx17L1MXSRLqc4Eee7DL
	 eGcFlYVFEKe/Q==
Subject: [PATCH v1 07/11] svcrdma: Post Send WR chain
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Mon, 29 Jan 2024 09:51:15 -0500
Message-ID: 
 <170653987543.24162.18059205281166429623.stgit@manet.1015granger.net>
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

Eventually I'd like the server to post the reply's Send WR along
with any Write WRs using only a single call to ib_post_send(), in
order to reduce the NIC's doorbell rate.

To do this, add an anchor for a WR chain to svc_rdma_send_ctxt, and
refactor svc_rdma_send() to post this WR chain to the Send Queue. For
the moment, the posted chain will continue to contain a single Send
WR.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h            |    6 ++-
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |    2 +
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      |   49 +++++++++++++++++++---------
 3 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index e7595ae62fe2..ee05087d6499 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -210,6 +210,8 @@ struct svc_rdma_send_ctxt {
 
 	struct svcxprt_rdma	*sc_rdma;
 	struct ib_send_wr	sc_send_wr;
+	struct ib_send_wr	*sc_wr_chain;
+	int			sc_sqecount;
 	struct ib_cqe		sc_cqe;
 	struct xdr_buf		sc_hdrbuf;
 	struct xdr_stream	sc_stream;
@@ -258,8 +260,8 @@ extern struct svc_rdma_send_ctxt *
 		svc_rdma_send_ctxt_get(struct svcxprt_rdma *rdma);
 extern void svc_rdma_send_ctxt_put(struct svcxprt_rdma *rdma,
 				   struct svc_rdma_send_ctxt *ctxt);
-extern int svc_rdma_send(struct svcxprt_rdma *rdma,
-			 struct svc_rdma_send_ctxt *ctxt);
+extern int svc_rdma_post_send(struct svcxprt_rdma *rdma,
+			      struct svc_rdma_send_ctxt *ctxt);
 extern int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 				  struct svc_rdma_send_ctxt *sctxt,
 				  const struct svc_rdma_pcl *write_pcl,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
index c9be6778643b..e5a78b761012 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -90,7 +90,7 @@ static int svc_rdma_bc_sendto(struct svcxprt_rdma *rdma,
 	 */
 	get_page(virt_to_page(rqst->rq_buffer));
 	sctxt->sc_send_wr.opcode = IB_WR_SEND;
-	return svc_rdma_send(rdma, sctxt);
+	return svc_rdma_post_send(rdma, sctxt);
 }
 
 /* Server-side transport endpoint wants a whole page for its send
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 0ee9185f5f3f..0f02fb09d5b0 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -208,6 +208,9 @@ struct svc_rdma_send_ctxt *svc_rdma_send_ctxt_get(struct svcxprt_rdma *rdma)
 	ctxt->sc_send_wr.num_sge = 0;
 	ctxt->sc_cur_sge_no = 0;
 	ctxt->sc_page_count = 0;
+	ctxt->sc_wr_chain = &ctxt->sc_send_wr;
+	ctxt->sc_sqecount = 1;
+
 	return ctxt;
 
 out_empty:
@@ -293,7 +296,7 @@ static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc)
 	struct svc_rdma_send_ctxt *ctxt =
 		container_of(cqe, struct svc_rdma_send_ctxt, sc_cqe);
 
-	svc_rdma_wake_send_waiters(rdma, 1);
+	svc_rdma_wake_send_waiters(rdma, ctxt->sc_sqecount);
 
 	if (unlikely(wc->status != IB_WC_SUCCESS))
 		goto flushed;
@@ -312,36 +315,44 @@ static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc)
 }
 
 /**
- * svc_rdma_send - Post a single Send WR
- * @rdma: transport on which to post the WR
- * @ctxt: send ctxt with a Send WR ready to post
+ * svc_rdma_post_send - Post a WR chain to the Send Queue
+ * @rdma: transport context
+ * @ctxt: WR chain to post
  *
  * Copy fields in @ctxt to stack variables in order to guarantee
  * that these values remain available after the ib_post_send() call.
  * In some error flow cases, svc_rdma_wc_send() releases @ctxt.
  *
+ * Note there is potential for starvation when the Send Queue is
+ * full because there is no order to when waiting threads are
+ * awoken. The transport is typically provisioned with a deep
+ * enough Send Queue that SQ exhaustion should be a rare event.
+ *
  * Return values:
  *   %0: @ctxt's WR chain was posted successfully
  *   %-ENOTCONN: The connection was lost
  */
-int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
+int svc_rdma_post_send(struct svcxprt_rdma *rdma,
+		       struct svc_rdma_send_ctxt *ctxt)
 {
-	struct ib_send_wr *wr = &ctxt->sc_send_wr;
+	struct ib_send_wr *first_wr = ctxt->sc_wr_chain;
+	struct ib_send_wr *send_wr = &ctxt->sc_send_wr;
+	const struct ib_send_wr *bad_wr = first_wr;
 	struct rpc_rdma_cid cid = ctxt->sc_cid;
-	int ret;
+	int ret, sqecount = ctxt->sc_sqecount;
 
 	might_sleep();
 
 	/* Sync the transport header buffer */
 	ib_dma_sync_single_for_device(rdma->sc_pd->device,
-				      wr->sg_list[0].addr,
-				      wr->sg_list[0].length,
+				      send_wr->sg_list[0].addr,
+				      send_wr->sg_list[0].length,
 				      DMA_TO_DEVICE);
 
 	/* If the SQ is full, wait until an SQ entry is available */
 	while (!test_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags)) {
-		if ((atomic_dec_return(&rdma->sc_sq_avail) < 0)) {
-			svc_rdma_wake_send_waiters(rdma, 1);
+		if (atomic_sub_return(sqecount, &rdma->sc_sq_avail) < 0) {
+			svc_rdma_wake_send_waiters(rdma, sqecount);
 
 			/* When the transport is torn down, assume
 			 * ib_drain_sq() will trigger enough Send
@@ -358,12 +369,18 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
 		}
 
 		trace_svcrdma_post_send(ctxt);
-		ret = ib_post_send(rdma->sc_qp, wr, NULL);
+		ret = ib_post_send(rdma->sc_qp, first_wr, &bad_wr);
 		if (ret) {
 			trace_svcrdma_sq_post_err(rdma, &cid, ret);
 			svc_xprt_deferred_close(&rdma->sc_xprt);
-			svc_rdma_wake_send_waiters(rdma, 1);
-			break;
+
+			/* If even one WR was posted, there will be a
+			 * Send completion that bumps sc_sq_avail.
+			 */
+			if (bad_wr == first_wr) {
+				svc_rdma_wake_send_waiters(rdma, sqecount);
+				break;
+			}
 		}
 		return 0;
 	}
@@ -884,7 +901,7 @@ static int svc_rdma_send_reply_msg(struct svcxprt_rdma *rdma,
 		sctxt->sc_send_wr.opcode = IB_WR_SEND;
 	}
 
-	return svc_rdma_send(rdma, sctxt);
+	return svc_rdma_post_send(rdma, sctxt);
 }
 
 /**
@@ -948,7 +965,7 @@ void svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 	sctxt->sc_send_wr.num_sge = 1;
 	sctxt->sc_send_wr.opcode = IB_WR_SEND;
 	sctxt->sc_sges[0].length = sctxt->sc_hdrbuf.len;
-	if (svc_rdma_send(rdma, sctxt))
+	if (svc_rdma_post_send(rdma, sctxt))
 		goto put_ctxt;
 	return;
 



