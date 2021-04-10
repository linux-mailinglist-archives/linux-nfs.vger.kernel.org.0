Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C15235AFF5
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Apr 2021 20:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbhDJS5h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 10 Apr 2021 14:57:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234992AbhDJS5h (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 10 Apr 2021 14:57:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F050F600D4;
        Sat, 10 Apr 2021 18:57:21 +0000 (UTC)
Subject: [PATCH v1 3/5] xprtrdma: Move fr_linv_done field to struct rpcrdma_mr
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 10 Apr 2021 14:57:21 -0400
Message-ID: <161808104126.21544.2370381333723823140.stgit@manet.1015granger.net>
In-Reply-To: <161808077437.21544.8496120800134971916.stgit@manet.1015granger.net>
References: <161808077437.21544.8496120800134971916.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: Move more of struct rpcrdma_frwr into its parent.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |    9 ++++-----
 net/sunrpc/xprtrdma/xprt_rdma.h |    2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 2a886a28d82b..7d7a64d2ca4a 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -142,7 +142,7 @@ int frwr_mr_init(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
 	mr->frwr.fr_mr = frmr;
 	mr->mr_device = NULL;
 	INIT_LIST_HEAD(&mr->mr_list);
-	init_completion(&mr->frwr.fr_linv_done);
+	init_completion(&mr->mr_linv_done);
 	frwr_cid_init(ep, mr);
 
 	sg_init_table(sg, depth);
@@ -481,12 +481,11 @@ static void frwr_wc_localinv_wake(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct ib_cqe *cqe = wc->wr_cqe;
 	struct rpcrdma_mr *mr = container_of(cqe, struct rpcrdma_mr, mr_cqe);
-	struct rpcrdma_frwr *frwr = &mr->frwr;
 
 	/* WARNING: Only wr_cqe and status are reliable at this point */
 	trace_xprtrdma_wc_li_wake(wc, &mr->mr_cid);
 	frwr_mr_done(wc, mr);
-	complete(&frwr->fr_linv_done);
+	complete(&mr->mr_linv_done);
 
 	rpcrdma_flush_disconnect(cq->cq_context, wc);
 }
@@ -544,7 +543,7 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	 * are complete.
 	 */
 	last->wr_cqe->done = frwr_wc_localinv_wake;
-	reinit_completion(&frwr->fr_linv_done);
+	reinit_completion(&mr->mr_linv_done);
 
 	/* Transport disconnect drains the receive CQ before it
 	 * replaces the QP. The RPC reply handler won't call us
@@ -558,7 +557,7 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	 * not happen, so don't wait in that case.
 	 */
 	if (bad_wr != first)
-		wait_for_completion(&frwr->fr_linv_done);
+		wait_for_completion(&mr->mr_linv_done);
 	if (!rc)
 		return;
 
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index f72b69c3f0ea..1374054b73fd 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -231,7 +231,6 @@ struct rpcrdma_sendctx {
  */
 struct rpcrdma_frwr {
 	struct ib_mr			*fr_mr;
-	struct completion		fr_linv_done;
 	union {
 		struct ib_reg_wr	fr_regwr;
 		struct ib_send_wr	fr_invwr;
@@ -247,6 +246,7 @@ struct rpcrdma_mr {
 	int			mr_nents;
 	enum dma_data_direction	mr_dir;
 	struct ib_cqe		mr_cqe;
+	struct completion	mr_linv_done;
 	struct rpcrdma_frwr	frwr;
 	struct rpcrdma_xprt	*mr_xprt;
 	u32			mr_handle;


