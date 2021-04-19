Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3ECA364984
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Apr 2021 20:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240559AbhDSSDo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Apr 2021 14:03:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240553AbhDSSDo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Apr 2021 14:03:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD2F561001;
        Mon, 19 Apr 2021 18:03:13 +0000 (UTC)
Subject: [PATCH v3 15/26] xprtrdma: Do not recycle MR after FastReg/LocalInv
 flushes
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Apr 2021 14:03:12 -0400
Message-ID: <161885539285.38598.13978652738422395833.stgit@manet.1015granger.net>
In-Reply-To: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
References: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Better not to touch MRs involved in a flush or post error until the
Send and Receive Queues are drained and the transport is fully
quiescent. Simply don't insert such MRs back onto the free list.
They remain on mr_all and will be released when the connection is
torn down.

I had thought that recycling would prevent hardware resources from
being tied up for a long time. However, since v5.7, a transport
disconnect destroys the QP and other hardware-owned resources. The
MRs get cleaned up nicely at that point.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h |    1 -
 net/sunrpc/xprtrdma/frwr_ops.c |   69 ++++++++++------------------------------
 2 files changed, 17 insertions(+), 53 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index c838e7ac1c2d..e38e745d13b0 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1014,7 +1014,6 @@ DEFINE_MR_EVENT(localinv);
 DEFINE_MR_EVENT(map);
 
 DEFINE_ANON_MR_EVENT(unmap);
-DEFINE_ANON_MR_EVENT(recycle);
 
 TRACE_EVENT(xprtrdma_dma_maperr,
 	TP_PROTO(
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index af85cec0ce31..27087dc8ba3c 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -49,6 +49,16 @@
 # define RPCDBG_FACILITY	RPCDBG_TRANS
 #endif
 
+static void frwr_mr_unmap(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
+{
+	if (mr->mr_device) {
+		trace_xprtrdma_mr_unmap(mr);
+		ib_dma_unmap_sg(mr->mr_device, mr->mr_sg, mr->mr_nents,
+				mr->mr_dir);
+		mr->mr_device = NULL;
+	}
+}
+
 /**
  * frwr_mr_release - Destroy one MR
  * @mr: MR allocated by frwr_mr_init
@@ -58,6 +68,8 @@ void frwr_mr_release(struct rpcrdma_mr *mr)
 {
 	int rc;
 
+	frwr_mr_unmap(mr->mr_xprt, mr);
+
 	rc = ib_dereg_mr(mr->frwr.fr_mr);
 	if (rc)
 		trace_xprtrdma_frwr_dereg(mr, rc);
@@ -65,32 +77,6 @@ void frwr_mr_release(struct rpcrdma_mr *mr)
 	kfree(mr);
 }
 
-static void frwr_mr_unmap(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
-{
-	if (mr->mr_device) {
-		trace_xprtrdma_mr_unmap(mr);
-		ib_dma_unmap_sg(mr->mr_device, mr->mr_sg, mr->mr_nents,
-				mr->mr_dir);
-		mr->mr_device = NULL;
-	}
-}
-
-static void frwr_mr_recycle(struct rpcrdma_mr *mr)
-{
-	struct rpcrdma_xprt *r_xprt = mr->mr_xprt;
-
-	trace_xprtrdma_mr_recycle(mr);
-
-	frwr_mr_unmap(r_xprt, mr);
-
-	spin_lock(&r_xprt->rx_buf.rb_lock);
-	list_del(&mr->mr_all);
-	r_xprt->rx_stats.mrs_recycled++;
-	spin_unlock(&r_xprt->rx_buf.rb_lock);
-
-	frwr_mr_release(mr);
-}
-
 static void frwr_mr_put(struct rpcrdma_mr *mr)
 {
 	frwr_mr_unmap(mr->mr_xprt, mr);
@@ -365,6 +351,7 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
  * @cq: completion queue
  * @wc: WCE for a completed FastReg WR
  *
+ * Each flushed MR gets destroyed after the QP has drained.
  */
 static void frwr_wc_fastreg(struct ib_cq *cq, struct ib_wc *wc)
 {
@@ -374,7 +361,6 @@ static void frwr_wc_fastreg(struct ib_cq *cq, struct ib_wc *wc)
 
 	/* WARNING: Only wr_cqe and status are reliable at this point */
 	trace_xprtrdma_wc_fastreg(wc, &frwr->fr_cid);
-	/* The MR will get recycled when the associated req is retransmitted */
 
 	rpcrdma_flush_disconnect(cq->cq_context, wc);
 }
@@ -448,9 +434,7 @@ void frwr_reminv(struct rpcrdma_rep *rep, struct list_head *mrs)
 
 static void frwr_mr_done(struct ib_wc *wc, struct rpcrdma_mr *mr)
 {
-	if (wc->status != IB_WC_SUCCESS)
-		frwr_mr_recycle(mr);
-	else
+	if (likely(wc->status == IB_WC_SUCCESS))
 		frwr_mr_put(mr);
 }
 
@@ -567,17 +551,8 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	if (!rc)
 		return;
 
-	/* Recycle MRs in the LOCAL_INV chain that did not get posted.
-	 */
+	/* On error, the MRs get destroyed once the QP has drained. */
 	trace_xprtrdma_post_linv_err(req, rc);
-	while (bad_wr) {
-		frwr = container_of(bad_wr, struct rpcrdma_frwr,
-				    fr_invwr);
-		mr = container_of(frwr, struct rpcrdma_mr, frwr);
-		bad_wr = bad_wr->next;
-
-		frwr_mr_recycle(mr);
-	}
 }
 
 /**
@@ -621,7 +596,6 @@ void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 {
 	struct ib_send_wr *first, *last, **prev;
 	struct rpcrdma_ep *ep = r_xprt->rx_ep;
-	const struct ib_send_wr *bad_wr;
 	struct rpcrdma_frwr *frwr;
 	struct rpcrdma_mr *mr;
 	int rc;
@@ -663,21 +637,12 @@ void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	 * replaces the QP. The RPC reply handler won't call us
 	 * unless re_id->qp is a valid pointer.
 	 */
-	bad_wr = NULL;
-	rc = ib_post_send(ep->re_id->qp, first, &bad_wr);
+	rc = ib_post_send(ep->re_id->qp, first, NULL);
 	if (!rc)
 		return;
 
-	/* Recycle MRs in the LOCAL_INV chain that did not get posted.
-	 */
+	/* On error, the MRs get destroyed once the QP has drained. */
 	trace_xprtrdma_post_linv_err(req, rc);
-	while (bad_wr) {
-		frwr = container_of(bad_wr, struct rpcrdma_frwr, fr_invwr);
-		mr = container_of(frwr, struct rpcrdma_mr, frwr);
-		bad_wr = bad_wr->next;
-
-		frwr_mr_recycle(mr);
-	}
 
 	/* The final LOCAL_INV WR in the chain is supposed to
 	 * do the wake. If it was never posted, the wake will


