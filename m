Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521693DDF84
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Aug 2021 20:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhHBSor (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Aug 2021 14:44:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231357AbhHBSor (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 2 Aug 2021 14:44:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A7B660F6E;
        Mon,  2 Aug 2021 18:44:37 +0000 (UTC)
Subject: [PATCH v1 4/5] xprtrdma: Add an xprtrdma_post_send_err tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 02 Aug 2021 14:44:36 -0400
Message-ID: <162792987652.3902.10509303607593172210.stgit@manet.1015granger.net>
In-Reply-To: <162792979429.3902.11831790821518477892.stgit@manet.1015granger.net>
References: <162792979429.3902.11831790821518477892.stgit@manet.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Unlike xprtrdma_post_send(), this one can be left enabled all the
time, and should almost never fire. But we do want to know about
immediate errors when they happen.

Note that there is already a similar post_linv_err tracepoint.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h |   33 +++++++++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/frwr_ops.c |    6 +++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index d65a84bd040c..de4195499592 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -793,6 +793,39 @@ TRACE_EVENT(xprtrdma_post_send,
 	)
 );
 
+TRACE_EVENT(xprtrdma_post_send_err,
+	TP_PROTO(
+		const struct rpcrdma_xprt *r_xprt,
+		const struct rpcrdma_req *req,
+		int rc
+	),
+
+	TP_ARGS(r_xprt, req, rc),
+
+	TP_STRUCT__entry(
+		__field(u32, cq_id)
+		__field(unsigned int, task_id)
+		__field(unsigned int, client_id)
+		__field(int, rc)
+	),
+
+	TP_fast_assign(
+		const struct rpc_rqst *rqst = &req->rl_slot;
+		const struct rpcrdma_ep *ep = r_xprt->rx_ep;
+
+		__entry->cq_id = ep ? ep->re_attr.recv_cq->res.id : 0;
+		__entry->task_id = rqst->rq_task->tk_pid;
+		__entry->client_id = rqst->rq_task->tk_client ?
+				     rqst->rq_task->tk_client->cl_clid : -1;
+		__entry->rc = rc;
+	),
+
+	TP_printk("task:%u@%u cq.id=%u rc=%d",
+		__entry->task_id, __entry->client_id,
+		__entry->cq_id, __entry->rc
+	)
+);
+
 TRACE_EVENT(xprtrdma_post_recv,
 	TP_PROTO(
 		const struct rpcrdma_rep *rep
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 754c5dffe127..f700b34a5bfd 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -394,6 +394,7 @@ int frwr_send(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	struct rpcrdma_ep *ep = r_xprt->rx_ep;
 	struct rpcrdma_mr *mr;
 	unsigned int num_wrs;
+	int ret;
 
 	num_wrs = 1;
 	post_wr = send_wr;
@@ -420,7 +421,10 @@ int frwr_send(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	}
 
 	trace_xprtrdma_post_send(req);
-	return ib_post_send(ep->re_id->qp, post_wr, NULL);
+	ret = ib_post_send(ep->re_id->qp, post_wr, NULL);
+	if (ret)
+		trace_xprtrdma_post_send_err(r_xprt, req, ret);
+	return ret;
 }
 
 /**


