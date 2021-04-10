Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BCB35AFF3
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Apr 2021 20:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbhDJS5b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 10 Apr 2021 14:57:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234975AbhDJS5b (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 10 Apr 2021 14:57:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3A96600D4;
        Sat, 10 Apr 2021 18:57:15 +0000 (UTC)
Subject: [PATCH v1 2/5] xprtrdma: Move cqe to struct rpcrdma_mr
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 10 Apr 2021 14:57:15 -0400
Message-ID: <161808103521.21544.1921779542227931907.stgit@manet.1015granger.net>
In-Reply-To: <161808077437.21544.8496120800134971916.stgit@manet.1015granger.net>
References: <161808077437.21544.8496120800134971916.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up.

- Simplify variable initialization in the completion handlers.

- Move another field out of struct rpcrdma_frwr.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |   35 +++++++++++++++--------------------
 net/sunrpc/xprtrdma/xprt_rdma.h |    2 +-
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index d3c18c776bf9..2a886a28d82b 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -366,9 +366,7 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 static void frwr_wc_fastreg(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct ib_cqe *cqe = wc->wr_cqe;
-	struct rpcrdma_frwr *frwr =
-		container_of(cqe, struct rpcrdma_frwr, fr_cqe);
-	struct rpcrdma_mr *mr = container_of(frwr, struct rpcrdma_mr, frwr);
+	struct rpcrdma_mr *mr = container_of(cqe, struct rpcrdma_mr, mr_cqe);
 
 	/* WARNING: Only wr_cqe and status are reliable at this point */
 	trace_xprtrdma_wc_fastreg(wc, &mr->mr_cid);
@@ -405,9 +403,9 @@ int frwr_send(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 		trace_xprtrdma_mr_fastreg(mr);
 		frwr = &mr->frwr;
 
-		frwr->fr_cqe.done = frwr_wc_fastreg;
+		mr->mr_cqe.done = frwr_wc_fastreg;
 		frwr->fr_regwr.wr.next = post_wr;
-		frwr->fr_regwr.wr.wr_cqe = &frwr->fr_cqe;
+		frwr->fr_regwr.wr.wr_cqe = &mr->mr_cqe;
 		frwr->fr_regwr.wr.num_sge = 0;
 		frwr->fr_regwr.wr.opcode = IB_WR_REG_MR;
 		frwr->fr_regwr.wr.send_flags = 0;
@@ -463,9 +461,7 @@ static void frwr_mr_done(struct ib_wc *wc, struct rpcrdma_mr *mr)
 static void frwr_wc_localinv(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct ib_cqe *cqe = wc->wr_cqe;
-	struct rpcrdma_frwr *frwr =
-		container_of(cqe, struct rpcrdma_frwr, fr_cqe);
-	struct rpcrdma_mr *mr = container_of(frwr, struct rpcrdma_mr, frwr);
+	struct rpcrdma_mr *mr = container_of(cqe, struct rpcrdma_mr, mr_cqe);
 
 	/* WARNING: Only wr_cqe and status are reliable at this point */
 	trace_xprtrdma_wc_li(wc, &mr->mr_cid);
@@ -484,9 +480,8 @@ static void frwr_wc_localinv(struct ib_cq *cq, struct ib_wc *wc)
 static void frwr_wc_localinv_wake(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct ib_cqe *cqe = wc->wr_cqe;
-	struct rpcrdma_frwr *frwr =
-		container_of(cqe, struct rpcrdma_frwr, fr_cqe);
-	struct rpcrdma_mr *mr = container_of(frwr, struct rpcrdma_mr, frwr);
+	struct rpcrdma_mr *mr = container_of(cqe, struct rpcrdma_mr, mr_cqe);
+	struct rpcrdma_frwr *frwr = &mr->frwr;
 
 	/* WARNING: Only wr_cqe and status are reliable at this point */
 	trace_xprtrdma_wc_li_wake(wc, &mr->mr_cid);
@@ -529,16 +524,17 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 		r_xprt->rx_stats.local_inv_needed++;
 
 		frwr = &mr->frwr;
-		frwr->fr_cqe.done = frwr_wc_localinv;
 		last = &frwr->fr_invwr;
 		last->next = NULL;
-		last->wr_cqe = &frwr->fr_cqe;
+		last->wr_cqe = &mr->mr_cqe;
 		last->sg_list = NULL;
 		last->num_sge = 0;
 		last->opcode = IB_WR_LOCAL_INV;
 		last->send_flags = IB_SEND_SIGNALED;
 		last->ex.invalidate_rkey = mr->mr_handle;
 
+		last->wr_cqe->done = frwr_wc_localinv;
+
 		*prev = last;
 		prev = &last->next;
 	}
@@ -547,7 +543,7 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	 * last WR in the chain completes, all WRs in the chain
 	 * are complete.
 	 */
-	frwr->fr_cqe.done = frwr_wc_localinv_wake;
+	last->wr_cqe->done = frwr_wc_localinv_wake;
 	reinit_completion(&frwr->fr_linv_done);
 
 	/* Transport disconnect drains the receive CQ before it
@@ -579,9 +575,7 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 static void frwr_wc_localinv_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct ib_cqe *cqe = wc->wr_cqe;
-	struct rpcrdma_frwr *frwr =
-		container_of(cqe, struct rpcrdma_frwr, fr_cqe);
-	struct rpcrdma_mr *mr = container_of(frwr, struct rpcrdma_mr, frwr);
+	struct rpcrdma_mr *mr = container_of(cqe, struct rpcrdma_mr, mr_cqe);
 	struct rpcrdma_rep *rep;
 
 	/* WARNING: Only wr_cqe and status are reliable at this point */
@@ -630,16 +624,17 @@ void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 		r_xprt->rx_stats.local_inv_needed++;
 
 		frwr = &mr->frwr;
-		frwr->fr_cqe.done = frwr_wc_localinv;
 		last = &frwr->fr_invwr;
 		last->next = NULL;
-		last->wr_cqe = &frwr->fr_cqe;
+		last->wr_cqe = &mr->mr_cqe;
 		last->sg_list = NULL;
 		last->num_sge = 0;
 		last->opcode = IB_WR_LOCAL_INV;
 		last->send_flags = IB_SEND_SIGNALED;
 		last->ex.invalidate_rkey = mr->mr_handle;
 
+		last->wr_cqe->done = frwr_wc_localinv;
+
 		*prev = last;
 		prev = &last->next;
 	}
@@ -649,7 +644,7 @@ void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	 * are complete. The last completion will wake up the
 	 * RPC waiter.
 	 */
-	frwr->fr_cqe.done = frwr_wc_localinv_done;
+	last->wr_cqe->done = frwr_wc_localinv_done;
 
 	/* Transport disconnect drains the receive CQ before it
 	 * replaces the QP. The RPC reply handler won't call us
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 0cf073f0ee64..f72b69c3f0ea 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -231,7 +231,6 @@ struct rpcrdma_sendctx {
  */
 struct rpcrdma_frwr {
 	struct ib_mr			*fr_mr;
-	struct ib_cqe			fr_cqe;
 	struct completion		fr_linv_done;
 	union {
 		struct ib_reg_wr	fr_regwr;
@@ -247,6 +246,7 @@ struct rpcrdma_mr {
 	struct scatterlist	*mr_sg;
 	int			mr_nents;
 	enum dma_data_direction	mr_dir;
+	struct ib_cqe		mr_cqe;
 	struct rpcrdma_frwr	frwr;
 	struct rpcrdma_xprt	*mr_xprt;
 	u32			mr_handle;


