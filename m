Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B17364998
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Apr 2021 20:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240623AbhDSSEs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Apr 2021 14:04:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240024AbhDSSEq (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Apr 2021 14:04:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63A5D61001;
        Mon, 19 Apr 2021 18:04:16 +0000 (UTC)
Subject: [PATCH v3 25/26] xprtrdma: Move the Work Request union to struct
 rpcrdma_mr
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Apr 2021 14:04:15 -0400
Message-ID: <161885545557.38598.16489265835992496901.stgit@manet.1015granger.net>
In-Reply-To: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
References: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |   28 +++++++++-------------------
 net/sunrpc/xprtrdma/xprt_rdma.h |    8 ++++----
 2 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 7d7a64d2ca4a..bb2b9c607c71 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -333,7 +333,7 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 	key = (u8)(ibmr->rkey & 0x000000FF);
 	ib_update_fast_reg_key(ibmr, ++key);
 
-	reg_wr = &mr->frwr.fr_regwr;
+	reg_wr = &mr->mr_regwr;
 	reg_wr->mr = ibmr;
 	reg_wr->key = ibmr->rkey;
 	reg_wr->access = writing ?
@@ -398,19 +398,15 @@ int frwr_send(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	num_wrs = 1;
 	post_wr = send_wr;
 	list_for_each_entry(mr, &req->rl_registered, mr_list) {
-		struct rpcrdma_frwr *frwr;
-
 		trace_xprtrdma_mr_fastreg(mr);
-		frwr = &mr->frwr;
 
 		mr->mr_cqe.done = frwr_wc_fastreg;
-		frwr->fr_regwr.wr.next = post_wr;
-		frwr->fr_regwr.wr.wr_cqe = &mr->mr_cqe;
-		frwr->fr_regwr.wr.num_sge = 0;
-		frwr->fr_regwr.wr.opcode = IB_WR_REG_MR;
-		frwr->fr_regwr.wr.send_flags = 0;
-
-		post_wr = &frwr->fr_regwr.wr;
+		mr->mr_regwr.wr.next = post_wr;
+		mr->mr_regwr.wr.wr_cqe = &mr->mr_cqe;
+		mr->mr_regwr.wr.num_sge = 0;
+		mr->mr_regwr.wr.opcode = IB_WR_REG_MR;
+		mr->mr_regwr.wr.send_flags = 0;
+		post_wr = &mr->mr_regwr.wr;
 		++num_wrs;
 	}
 
@@ -506,7 +502,6 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	struct ib_send_wr *first, **prev, *last;
 	struct rpcrdma_ep *ep = r_xprt->rx_ep;
 	const struct ib_send_wr *bad_wr;
-	struct rpcrdma_frwr *frwr;
 	struct rpcrdma_mr *mr;
 	int rc;
 
@@ -515,15 +510,13 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	 * Chain the LOCAL_INV Work Requests and post them with
 	 * a single ib_post_send() call.
 	 */
-	frwr = NULL;
 	prev = &first;
 	while ((mr = rpcrdma_mr_pop(&req->rl_registered))) {
 
 		trace_xprtrdma_mr_localinv(mr);
 		r_xprt->rx_stats.local_inv_needed++;
 
-		frwr = &mr->frwr;
-		last = &frwr->fr_invwr;
+		last = &mr->mr_invwr;
 		last->next = NULL;
 		last->wr_cqe = &mr->mr_cqe;
 		last->sg_list = NULL;
@@ -608,22 +601,19 @@ void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 {
 	struct ib_send_wr *first, *last, **prev;
 	struct rpcrdma_ep *ep = r_xprt->rx_ep;
-	struct rpcrdma_frwr *frwr;
 	struct rpcrdma_mr *mr;
 	int rc;
 
 	/* Chain the LOCAL_INV Work Requests and post them with
 	 * a single ib_post_send() call.
 	 */
-	frwr = NULL;
 	prev = &first;
 	while ((mr = rpcrdma_mr_pop(&req->rl_registered))) {
 
 		trace_xprtrdma_mr_localinv(mr);
 		r_xprt->rx_stats.local_inv_needed++;
 
-		frwr = &mr->frwr;
-		last = &frwr->fr_invwr;
+		last = &mr->mr_invwr;
 		last->next = NULL;
 		last->wr_cqe = &mr->mr_cqe;
 		last->sg_list = NULL;
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 1374054b73fd..99ef83d673d6 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -231,10 +231,6 @@ struct rpcrdma_sendctx {
  */
 struct rpcrdma_frwr {
 	struct ib_mr			*fr_mr;
-	union {
-		struct ib_reg_wr	fr_regwr;
-		struct ib_send_wr	fr_invwr;
-	};
 };
 
 struct rpcrdma_req;
@@ -247,6 +243,10 @@ struct rpcrdma_mr {
 	enum dma_data_direction	mr_dir;
 	struct ib_cqe		mr_cqe;
 	struct completion	mr_linv_done;
+	union {
+		struct ib_reg_wr	mr_regwr;
+		struct ib_send_wr	mr_invwr;
+	};
 	struct rpcrdma_frwr	frwr;
 	struct rpcrdma_xprt	*mr_xprt;
 	u32			mr_handle;


