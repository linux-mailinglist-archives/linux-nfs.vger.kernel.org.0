Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE1835AFF9
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Apr 2021 20:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbhDJS5u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 10 Apr 2021 14:57:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234768AbhDJS5t (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 10 Apr 2021 14:57:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 121A1600D4;
        Sat, 10 Apr 2021 18:57:34 +0000 (UTC)
Subject: [PATCH v1 5/5] xprtrdma: Move fr_mr field to struct rpcrdma_mr
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 10 Apr 2021 14:57:33 -0400
Message-ID: <161808105334.21544.13290885158284047691.stgit@manet.1015granger.net>
In-Reply-To: <161808077437.21544.8496120800134971916.stgit@manet.1015granger.net>
References: <161808077437.21544.8496120800134971916.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: The last remaining field in struct rpcrdma_frwr has been
removed, so the struct can be eliminated.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h  |   12 ++++++------
 net/sunrpc/xprtrdma/frwr_ops.c  |    8 ++++----
 net/sunrpc/xprtrdma/xprt_rdma.h |    7 ++-----
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index ef6166b840e7..bd55908c1bef 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -379,7 +379,7 @@ DECLARE_EVENT_CLASS(xprtrdma_mr_class,
 
 		__entry->task_id = task->tk_pid;
 		__entry->client_id = task->tk_client->cl_clid;
-		__entry->mr_id  = mr->frwr.fr_mr->res.id;
+		__entry->mr_id  = mr->mr_ibmr->res.id;
 		__entry->nents  = mr->mr_nents;
 		__entry->handle = mr->mr_handle;
 		__entry->length = mr->mr_length;
@@ -420,7 +420,7 @@ DECLARE_EVENT_CLASS(xprtrdma_anonymous_mr_class,
 	),
 
 	TP_fast_assign(
-		__entry->mr_id  = mr->frwr.fr_mr->res.id;
+		__entry->mr_id  = mr->mr_ibmr->res.id;
 		__entry->nents  = mr->mr_nents;
 		__entry->handle = mr->mr_handle;
 		__entry->length = mr->mr_length;
@@ -903,7 +903,7 @@ TRACE_EVENT(xprtrdma_frwr_alloc,
 	),
 
 	TP_fast_assign(
-		__entry->mr_id = mr->frwr.fr_mr->res.id;
+		__entry->mr_id = mr->mr_ibmr->res.id;
 		__entry->rc = rc;
 	),
 
@@ -931,7 +931,7 @@ TRACE_EVENT(xprtrdma_frwr_dereg,
 	),
 
 	TP_fast_assign(
-		__entry->mr_id  = mr->frwr.fr_mr->res.id;
+		__entry->mr_id  = mr->mr_ibmr->res.id;
 		__entry->nents  = mr->mr_nents;
 		__entry->handle = mr->mr_handle;
 		__entry->length = mr->mr_length;
@@ -964,7 +964,7 @@ TRACE_EVENT(xprtrdma_frwr_sgerr,
 	),
 
 	TP_fast_assign(
-		__entry->mr_id = mr->frwr.fr_mr->res.id;
+		__entry->mr_id = mr->mr_ibmr->res.id;
 		__entry->addr = mr->mr_sg->dma_address;
 		__entry->dir = mr->mr_dir;
 		__entry->nents = sg_nents;
@@ -994,7 +994,7 @@ TRACE_EVENT(xprtrdma_frwr_maperr,
 	),
 
 	TP_fast_assign(
-		__entry->mr_id = mr->frwr.fr_mr->res.id;
+		__entry->mr_id = mr->mr_ibmr->res.id;
 		__entry->addr = mr->mr_sg->dma_address;
 		__entry->dir = mr->mr_dir;
 		__entry->num_mapped = num_mapped;
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index bb2b9c607c71..285d73246fc2 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -55,7 +55,7 @@ static void frwr_cid_init(struct rpcrdma_ep *ep,
 	struct rpc_rdma_cid *cid = &mr->mr_cid;
 
 	cid->ci_queue_id = ep->re_attr.send_cq->res.id;
-	cid->ci_completion_id = mr->frwr.fr_mr->res.id;
+	cid->ci_completion_id = mr->mr_ibmr->res.id;
 }
 
 static void frwr_mr_unmap(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
@@ -79,7 +79,7 @@ void frwr_mr_release(struct rpcrdma_mr *mr)
 
 	frwr_mr_unmap(mr->mr_xprt, mr);
 
-	rc = ib_dereg_mr(mr->frwr.fr_mr);
+	rc = ib_dereg_mr(mr->mr_ibmr);
 	if (rc)
 		trace_xprtrdma_frwr_dereg(mr, rc);
 	kfree(mr->mr_sg);
@@ -139,7 +139,7 @@ int frwr_mr_init(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
 		goto out_list_err;
 
 	mr->mr_xprt = r_xprt;
-	mr->frwr.fr_mr = frmr;
+	mr->mr_ibmr = frmr;
 	mr->mr_device = NULL;
 	INIT_LIST_HEAD(&mr->mr_list);
 	init_completion(&mr->mr_linv_done);
@@ -323,7 +323,7 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 		goto out_dmamap_err;
 	mr->mr_device = ep->re_id->device;
 
-	ibmr = mr->frwr.fr_mr;
+	ibmr = mr->mr_ibmr;
 	n = ib_map_mr_sg(ibmr, mr->mr_sg, dma_nents, NULL, PAGE_SIZE);
 	if (n != dma_nents)
 		goto out_mapmr_err;
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 99ef83d673d6..436ad7312614 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -229,14 +229,12 @@ struct rpcrdma_sendctx {
  * An external memory region is any buffer or page that is registered
  * on the fly (ie, not pre-registered).
  */
-struct rpcrdma_frwr {
-	struct ib_mr			*fr_mr;
-};
-
 struct rpcrdma_req;
 struct rpcrdma_mr {
 	struct list_head	mr_list;
 	struct rpcrdma_req	*mr_req;
+
+	struct ib_mr		*mr_ibmr;
 	struct ib_device	*mr_device;
 	struct scatterlist	*mr_sg;
 	int			mr_nents;
@@ -247,7 +245,6 @@ struct rpcrdma_mr {
 		struct ib_reg_wr	mr_regwr;
 		struct ib_send_wr	mr_invwr;
 	};
-	struct rpcrdma_frwr	frwr;
 	struct rpcrdma_xprt	*mr_xprt;
 	u32			mr_handle;
 	u32			mr_length;


