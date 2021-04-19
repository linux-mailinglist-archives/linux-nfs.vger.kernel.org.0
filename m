Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D5B364992
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Apr 2021 20:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbhDSSE2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Apr 2021 14:04:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240024AbhDSSE1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Apr 2021 14:04:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CDB461107;
        Mon, 19 Apr 2021 18:03:57 +0000 (UTC)
Subject: [PATCH v3 22/26] xprtrdma: Move fr_cid to struct rpcrdma_mr
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Apr 2021 14:03:56 -0400
Message-ID: <161885543679.38598.1649488810821797098.stgit@manet.1015granger.net>
In-Reply-To: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
References: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up (for several purposes):

- The MR's cid is initialized sooner so that tracepoints can show
  something reasonable even if the MR is never posted.
- The MR's res.id doesn't change so the cid won't change either.
  Initializing the cid once is sufficient.
- struct rpcrdma_frwr is going away soon.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |   31 +++++++++++++++----------------
 net/sunrpc/xprtrdma/xprt_rdma.h |    2 +-
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 0f47c1e24037..d3c18c776bf9 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -49,6 +49,15 @@
 # define RPCDBG_FACILITY	RPCDBG_TRANS
 #endif
 
+static void frwr_cid_init(struct rpcrdma_ep *ep,
+			  struct rpcrdma_mr *mr)
+{
+	struct rpc_rdma_cid *cid = &mr->mr_cid;
+
+	cid->ci_queue_id = ep->re_attr.send_cq->res.id;
+	cid->ci_completion_id = mr->frwr.fr_mr->res.id;
+}
+
 static void frwr_mr_unmap(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
 {
 	if (mr->mr_device) {
@@ -134,6 +143,7 @@ int frwr_mr_init(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
 	mr->mr_device = NULL;
 	INIT_LIST_HEAD(&mr->mr_list);
 	init_completion(&mr->frwr.fr_linv_done);
+	frwr_cid_init(ep, mr);
 
 	sg_init_table(sg, depth);
 	mr->mr_sg = sg;
@@ -358,22 +368,14 @@ static void frwr_wc_fastreg(struct ib_cq *cq, struct ib_wc *wc)
 	struct ib_cqe *cqe = wc->wr_cqe;
 	struct rpcrdma_frwr *frwr =
 		container_of(cqe, struct rpcrdma_frwr, fr_cqe);
+	struct rpcrdma_mr *mr = container_of(frwr, struct rpcrdma_mr, frwr);
 
 	/* WARNING: Only wr_cqe and status are reliable at this point */
-	trace_xprtrdma_wc_fastreg(wc, &frwr->fr_cid);
+	trace_xprtrdma_wc_fastreg(wc, &mr->mr_cid);
 
 	rpcrdma_flush_disconnect(cq->cq_context, wc);
 }
 
-static void frwr_cid_init(struct rpcrdma_ep *ep,
-			  struct rpcrdma_frwr *frwr)
-{
-	struct rpc_rdma_cid *cid = &frwr->fr_cid;
-
-	cid->ci_queue_id = ep->re_attr.send_cq->res.id;
-	cid->ci_completion_id = frwr->fr_mr->res.id;
-}
-
 /**
  * frwr_send - post Send WRs containing the RPC Call message
  * @r_xprt: controlling transport instance
@@ -404,7 +406,6 @@ int frwr_send(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 		frwr = &mr->frwr;
 
 		frwr->fr_cqe.done = frwr_wc_fastreg;
-		frwr_cid_init(ep, frwr);
 		frwr->fr_regwr.wr.next = post_wr;
 		frwr->fr_regwr.wr.wr_cqe = &frwr->fr_cqe;
 		frwr->fr_regwr.wr.num_sge = 0;
@@ -467,7 +468,7 @@ static void frwr_wc_localinv(struct ib_cq *cq, struct ib_wc *wc)
 	struct rpcrdma_mr *mr = container_of(frwr, struct rpcrdma_mr, frwr);
 
 	/* WARNING: Only wr_cqe and status are reliable at this point */
-	trace_xprtrdma_wc_li(wc, &frwr->fr_cid);
+	trace_xprtrdma_wc_li(wc, &mr->mr_cid);
 	frwr_mr_done(wc, mr);
 
 	rpcrdma_flush_disconnect(cq->cq_context, wc);
@@ -488,7 +489,7 @@ static void frwr_wc_localinv_wake(struct ib_cq *cq, struct ib_wc *wc)
 	struct rpcrdma_mr *mr = container_of(frwr, struct rpcrdma_mr, frwr);
 
 	/* WARNING: Only wr_cqe and status are reliable at this point */
-	trace_xprtrdma_wc_li_wake(wc, &frwr->fr_cid);
+	trace_xprtrdma_wc_li_wake(wc, &mr->mr_cid);
 	frwr_mr_done(wc, mr);
 	complete(&frwr->fr_linv_done);
 
@@ -529,7 +530,6 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 
 		frwr = &mr->frwr;
 		frwr->fr_cqe.done = frwr_wc_localinv;
-		frwr_cid_init(ep, frwr);
 		last = &frwr->fr_invwr;
 		last->next = NULL;
 		last->wr_cqe = &frwr->fr_cqe;
@@ -585,7 +585,7 @@ static void frwr_wc_localinv_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct rpcrdma_rep *rep;
 
 	/* WARNING: Only wr_cqe and status are reliable at this point */
-	trace_xprtrdma_wc_li_done(wc, &frwr->fr_cid);
+	trace_xprtrdma_wc_li_done(wc, &mr->mr_cid);
 
 	/* Ensure that @rep is generated before the MR is released */
 	rep = mr->mr_req->rl_reply;
@@ -631,7 +631,6 @@ void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 
 		frwr = &mr->frwr;
 		frwr->fr_cqe.done = frwr_wc_localinv;
-		frwr_cid_init(ep, frwr);
 		last = &frwr->fr_invwr;
 		last->next = NULL;
 		last->wr_cqe = &frwr->fr_cqe;
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index bb8aba390b88..0cf073f0ee64 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -232,7 +232,6 @@ struct rpcrdma_sendctx {
 struct rpcrdma_frwr {
 	struct ib_mr			*fr_mr;
 	struct ib_cqe			fr_cqe;
-	struct rpc_rdma_cid		fr_cid;
 	struct completion		fr_linv_done;
 	union {
 		struct ib_reg_wr	fr_regwr;
@@ -254,6 +253,7 @@ struct rpcrdma_mr {
 	u32			mr_length;
 	u64			mr_offset;
 	struct list_head	mr_all;
+	struct rpc_rdma_cid	mr_cid;
 };
 
 /*


