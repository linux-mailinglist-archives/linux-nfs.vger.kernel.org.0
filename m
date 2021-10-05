Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C621422ED8
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Oct 2021 19:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbhJERQD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Oct 2021 13:16:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233961AbhJERQC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 5 Oct 2021 13:16:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEDC36117A
        for <linux-nfs@vger.kernel.org>; Tue,  5 Oct 2021 17:14:11 +0000 (UTC)
Subject: [PATCH RFC 2/5] SUNRPC: Avoid NULL pointer dereferences in
 tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Oct 2021 13:14:11 -0400
Message-ID: <163345405106.524558.10270064007943192582.stgit@morisot.1015granger.net>
In-Reply-To: <163345354511.524558.1980332041837428746.stgit@morisot.1015granger.net>
References: <163345354511.524558.1980332041837428746.stgit@morisot.1015granger.net>
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On occasion, a NULL rpc_task pointer is passed into tracepoints.
We've open-coded a few places where this is expected, but let's
be defensive and protect every place that wants to dereference
a task to assign the tk_pid and cl_clid.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs4trace.h                 |    8 +---
 fs/nfs/nfstrace.h                  |    3 -
 include/trace/events/rpcgss.h      |   18 +++-----
 include/trace/events/rpcrdma.h     |   62 ++++++++---------------------
 include/trace/events/sunrpc.h      |   77 +++++++++---------------------------
 include/trace/events/sunrpc_base.h |   15 +++++++
 6 files changed, 61 insertions(+), 122 deletions(-)

diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index d4f061046c09..66fbd3c33c15 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -686,10 +686,8 @@ TRACE_EVENT(nfs4_xdr_bad_operation,
 
 		TP_fast_assign(
 			const struct rpc_rqst *rqstp = xdr->rqst;
-			const struct rpc_task *task = rqstp->rq_task;
 
-			__entry->task_id = task->tk_pid;
-			__entry->client_id = task->tk_client->cl_clid;
+			SUNRPC_TRACE_TASK_ASSIGN(rqstp->rq_task);
 			__entry->xid = be32_to_cpu(rqstp->rq_xid);
 			__entry->op = op;
 			__entry->expected = expected;
@@ -721,10 +719,8 @@ DECLARE_EVENT_CLASS(nfs4_xdr_event,
 
 		TP_fast_assign(
 			const struct rpc_rqst *rqstp = xdr->rqst;
-			const struct rpc_task *task = rqstp->rq_task;
 
-			__entry->task_id = task->tk_pid;
-			__entry->client_id = task->tk_client->cl_clid;
+			SUNRPC_TRACE_TASK_ASSIGN(rqstp->rq_task);
 			__entry->xid = be32_to_cpu(rqstp->rq_xid);
 			__entry->op = op;
 			__entry->error = error;
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 82b51120450f..e9be65b52bfe 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1401,8 +1401,7 @@ DECLARE_EVENT_CLASS(nfs_xdr_event,
 			const struct rpc_rqst *rqstp = xdr->rqst;
 			const struct rpc_task *task = rqstp->rq_task;
 
-			__entry->task_id = task->tk_pid;
-			__entry->client_id = task->tk_client->cl_clid;
+			SUNRPC_TRACE_TASK_ASSIGN(task);
 			__entry->xid = be32_to_cpu(rqstp->rq_xid);
 			__entry->version = task->tk_client->cl_vers;
 			__entry->error = error;
diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.h
index 3ba63319af3c..87b17ebd09c3 100644
--- a/include/trace/events/rpcgss.h
+++ b/include/trace/events/rpcgss.h
@@ -96,8 +96,7 @@ DECLARE_EVENT_CLASS(rpcgss_gssapi_event,
 	),
 
 	TP_fast_assign(
-		__entry->task_id = task->tk_pid;
-		__entry->client_id = task->tk_client->cl_clid;
+		SUNRPC_TRACE_TASK_ASSIGN(task);
 		__entry->maj_stat = maj_stat;
 	),
 
@@ -330,8 +329,7 @@ TRACE_EVENT(rpcgss_unwrap_failed,
 	),
 
 	TP_fast_assign(
-		__entry->task_id = task->tk_pid;
-		__entry->client_id = task->tk_client->cl_clid;
+		SUNRPC_TRACE_TASK_ASSIGN(task);
 	),
 
 	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER,
@@ -355,8 +353,7 @@ TRACE_EVENT(rpcgss_bad_seqno,
 	),
 
 	TP_fast_assign(
-		__entry->task_id = task->tk_pid;
-		__entry->client_id = task->tk_client->cl_clid;
+		SUNRPC_TRACE_TASK_ASSIGN(task);
 		__entry->expected = expected;
 		__entry->received = received;
 	),
@@ -384,8 +381,7 @@ TRACE_EVENT(rpcgss_seqno,
 	TP_fast_assign(
 		const struct rpc_rqst *rqst = task->tk_rqstp;
 
-		__entry->task_id = task->tk_pid;
-		__entry->client_id = task->tk_client->cl_clid;
+		SUNRPC_TRACE_TASK_ASSIGN(task);
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
 		__entry->seqno = rqst->rq_seqno;
 	),
@@ -414,8 +410,7 @@ TRACE_EVENT(rpcgss_need_reencode,
 	),
 
 	TP_fast_assign(
-		__entry->task_id = task->tk_pid;
-		__entry->client_id = task->tk_client->cl_clid;
+		SUNRPC_TRACE_TASK_ASSIGN(task);
 		__entry->xid = be32_to_cpu(task->tk_rqstp->rq_xid);
 		__entry->seq_xmit = seq_xmit;
 		__entry->seqno = task->tk_rqstp->rq_seqno;
@@ -448,8 +443,7 @@ TRACE_EVENT(rpcgss_update_slack,
 	),
 
 	TP_fast_assign(
-		__entry->task_id = task->tk_pid;
-		__entry->client_id = task->tk_client->cl_clid;
+		SUNRPC_TRACE_TASK_ASSIGN(task);
 		__entry->xid = be32_to_cpu(task->tk_rqstp->rq_xid);
 		__entry->auth = auth;
 		__entry->rslack = auth->au_rslack;
diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 7f46ef621c95..c2ab9e5d775b 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -271,8 +271,7 @@ DECLARE_EVENT_CLASS(xprtrdma_rdch_event,
 	),
 
 	TP_fast_assign(
-		__entry->task_id = task->tk_pid;
-		__entry->client_id = task->tk_client->cl_clid;
+		SUNRPC_TRACE_TASK_ASSIGN(task);
 		__entry->pos = pos;
 		__entry->nents = mr->mr_nents;
 		__entry->handle = mr->mr_handle;
@@ -320,8 +319,7 @@ DECLARE_EVENT_CLASS(xprtrdma_wrch_event,
 	),
 
 	TP_fast_assign(
-		__entry->task_id = task->tk_pid;
-		__entry->client_id = task->tk_client->cl_clid;
+		SUNRPC_TRACE_TASK_ASSIGN(task);
 		__entry->nents = mr->mr_nents;
 		__entry->handle = mr->mr_handle;
 		__entry->length = mr->mr_length;
@@ -380,15 +378,8 @@ DECLARE_EVENT_CLASS(xprtrdma_mr_class,
 	TP_fast_assign(
 		const struct rpcrdma_req *req = mr->mr_req;
 
-		if (req) {
-			const struct rpc_task *task = req->rl_slot.rq_task;
-
-			__entry->task_id = task->tk_pid;
-			__entry->client_id = task->tk_client->cl_clid;
-		} else {
-			__entry->task_id = 0;
-			__entry->client_id = -1;
-		}
+		if (req)
+			SUNRPC_TRACE_TASK_ASSIGN(req->rl_slot.rq_task);
 		__entry->mr_id  = mr->mr_ibmr->res.id;
 		__entry->nents  = mr->mr_nents;
 		__entry->handle = mr->mr_handle;
@@ -633,10 +624,7 @@ TRACE_EVENT(xprtrdma_nomrs_err,
 	),
 
 	TP_fast_assign(
-		const struct rpc_rqst *rqst = &req->rl_slot;
-
-		__entry->task_id = rqst->rq_task->tk_pid;
-		__entry->client_id = rqst->rq_task->tk_client->cl_clid;
+		SUNRPC_TRACE_TASK_ASSIGN(req->rl_slot.rq_task);
 		__assign_str(addr, rpcrdma_addrstr(r_xprt));
 		__assign_str(port, rpcrdma_portstr(r_xprt));
 	),
@@ -694,8 +682,7 @@ TRACE_EVENT(xprtrdma_marshal,
 	TP_fast_assign(
 		const struct rpc_rqst *rqst = &req->rl_slot;
 
-		__entry->task_id = rqst->rq_task->tk_pid;
-		__entry->client_id = rqst->rq_task->tk_client->cl_clid;
+		SUNRPC_TRACE_TASK_ASSIGN(rqst->rq_task);
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
 		__entry->hdrlen = req->rl_hdrbuf.len;
 		__entry->headlen = rqst->rq_snd_buf.head[0].iov_len;
@@ -730,8 +717,7 @@ TRACE_EVENT(xprtrdma_marshal_failed,
 	),
 
 	TP_fast_assign(
-		__entry->task_id = rqst->rq_task->tk_pid;
-		__entry->client_id = rqst->rq_task->tk_client->cl_clid;
+		SUNRPC_TRACE_TASK_ASSIGN(rqst->rq_task);
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
 		__entry->ret = ret;
 	),
@@ -757,8 +743,7 @@ TRACE_EVENT(xprtrdma_prepsend_failed,
 	),
 
 	TP_fast_assign(
-		__entry->task_id = rqst->rq_task->tk_pid;
-		__entry->client_id = rqst->rq_task->tk_client->cl_clid;
+		SUNRPC_TRACE_TASK_ASSIGN(rqst->rq_task);
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
 		__entry->ret = ret;
 	),
@@ -791,9 +776,7 @@ TRACE_EVENT(xprtrdma_post_send,
 
 		__entry->cq_id = sc->sc_cid.ci_queue_id;
 		__entry->completion_id = sc->sc_cid.ci_completion_id;
-		__entry->task_id = rqst->rq_task->tk_pid;
-		__entry->client_id = rqst->rq_task->tk_client ?
-				     rqst->rq_task->tk_client->cl_clid : -1;
+		SUNRPC_TRACE_TASK_ASSIGN(rqst->rq_task);
 		__entry->num_sge = req->rl_wr.num_sge;
 		__entry->signaled = req->rl_wr.send_flags & IB_SEND_SIGNALED;
 	),
@@ -827,9 +810,7 @@ TRACE_EVENT(xprtrdma_post_send_err,
 		const struct rpcrdma_ep *ep = r_xprt->rx_ep;
 
 		__entry->cq_id = ep ? ep->re_attr.recv_cq->res.id : 0;
-		__entry->task_id = rqst->rq_task->tk_pid;
-		__entry->client_id = rqst->rq_task->tk_client ?
-				     rqst->rq_task->tk_client->cl_clid : -1;
+		SUNRPC_TRACE_TASK_ASSIGN(rqst->rq_task);
 		__entry->rc = rc;
 	),
 
@@ -938,10 +919,7 @@ TRACE_EVENT(xprtrdma_post_linv_err,
 	),
 
 	TP_fast_assign(
-		const struct rpc_task *task = req->rl_slot.rq_task;
-
-		__entry->task_id = task->tk_pid;
-		__entry->client_id = task->tk_client->cl_clid;
+		SUNRPC_TRACE_TASK_ASSIGN(req->rl_slot.rq_task);
 		__entry->status = status;
 	),
 
@@ -1127,8 +1105,7 @@ TRACE_EVENT(xprtrdma_reply,
 	),
 
 	TP_fast_assign(
-		__entry->task_id = task->tk_pid;
-		__entry->client_id = task->tk_client->cl_clid;
+		SUNRPC_TRACE_TASK_ASSIGN(task);
 		__entry->xid = be32_to_cpu(rep->rr_xid);
 		__entry->credits = credits;
 	),
@@ -1162,8 +1139,7 @@ TRACE_EVENT(xprtrdma_err_vers,
 	),
 
 	TP_fast_assign(
-		__entry->task_id = rqst->rq_task->tk_pid;
-		__entry->client_id = rqst->rq_task->tk_client->cl_clid;
+		SUNRPC_TRACE_TASK_ASSIGN(rqst->rq_task);
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
 		__entry->min = be32_to_cpup(min);
 		__entry->max = be32_to_cpup(max);
@@ -1189,8 +1165,7 @@ TRACE_EVENT(xprtrdma_err_chunk,
 	),
 
 	TP_fast_assign(
-		__entry->task_id = rqst->rq_task->tk_pid;
-		__entry->client_id = rqst->rq_task->tk_client->cl_clid;
+		SUNRPC_TRACE_TASK_ASSIGN(rqst->rq_task);
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
 	),
 
@@ -1215,8 +1190,7 @@ TRACE_EVENT(xprtrdma_err_unrecognized,
 	),
 
 	TP_fast_assign(
-		__entry->task_id = rqst->rq_task->tk_pid;
-		__entry->client_id = rqst->rq_task->tk_client->cl_clid;
+		SUNRPC_TRACE_TASK_ASSIGN(rqst->rq_task);
 		__entry->procedure = be32_to_cpup(procedure);
 	),
 
@@ -1244,8 +1218,7 @@ TRACE_EVENT(xprtrdma_fixup,
 	),
 
 	TP_fast_assign(
-		__entry->task_id = rqst->rq_task->tk_pid;
-		__entry->client_id = rqst->rq_task->tk_client->cl_clid;
+		SUNRPC_TRACE_TASK_ASSIGN(rqst->rq_task);
 		__entry->fixup = fixup;
 		__entry->headlen = rqst->rq_rcv_buf.head[0].iov_len;
 		__entry->pagelen = rqst->rq_rcv_buf.page_len;
@@ -1298,8 +1271,7 @@ TRACE_EVENT(xprtrdma_mrs_zap,
 	),
 
 	TP_fast_assign(
-		__entry->task_id = task->tk_pid;
-		__entry->client_id = task->tk_client->cl_clid;
+		SUNRPC_TRACE_TASK_ASSIGN(task);
 	),
 
 	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER,
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 92def7d6663e..4fd6299bc907 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -69,9 +69,7 @@ DECLARE_EVENT_CLASS(rpc_xdr_buf_class,
 	),
 
 	TP_fast_assign(
-		__entry->task_id = task->tk_pid;
-		__entry->client_id = task->tk_client ?
-				     task->tk_client->cl_clid : -1;
+		SUNRPC_TRACE_TASK_ASSIGN(task);
 		__entry->head_base = xdr->head[0].iov_base;
 		__entry->head_len = xdr->head[0].iov_len;
 		__entry->tail_base = xdr->tail[0].iov_base;
@@ -248,8 +246,7 @@ DECLARE_EVENT_CLASS(rpc_task_status,
 	),
 
 	TP_fast_assign(
-		__entry->task_id = task->tk_pid;
-		__entry->client_id = task->tk_client->cl_clid;
+		SUNRPC_TRACE_TASK_ASSIGN(task);
 		__entry->status = task->tk_status;
 	),
 
@@ -285,8 +282,7 @@ TRACE_EVENT(rpc_request,
 	),
 
 	TP_fast_assign(
-		__entry->task_id = task->tk_pid;
-		__entry->client_id = task->tk_client->cl_clid;
+		SUNRPC_TRACE_TASK_ASSIGN(task);
 		__entry->version = task->tk_client->cl_vers;
 		__entry->async = RPC_IS_ASYNC(task);
 		__assign_str(progname, task->tk_client->cl_program->name);
@@ -344,9 +340,7 @@ DECLARE_EVENT_CLASS(rpc_task_running,
 		),
 
 	TP_fast_assign(
-		__entry->client_id = task->tk_client ?
-				     task->tk_client->cl_clid : -1;
-		__entry->task_id = task->tk_pid;
+		SUNRPC_TRACE_TASK_ASSIGN(task);
 		__entry->action = action;
 		__entry->runstate = task->tk_runstate;
 		__entry->status = task->tk_status;
@@ -396,9 +390,7 @@ DECLARE_EVENT_CLASS(rpc_task_queued,
 		),
 
 	TP_fast_assign(
-		__entry->client_id = task->tk_client ?
-				     task->tk_client->cl_clid : -1;
-		__entry->task_id = task->tk_pid;
+		SUNRPC_TRACE_TASK_ASSIGN(task);
 		__entry->timeout = rpc_task_timeout(task);
 		__entry->runstate = task->tk_runstate;
 		__entry->status = task->tk_status;
@@ -439,8 +431,7 @@ DECLARE_EVENT_CLASS(rpc_failure,
 	),
 
 	TP_fast_assign(
-		__entry->task_id = task->tk_pid;
-		__entry->client_id = task->tk_client->cl_clid;
+		SUNRPC_TRACE_TASK_ASSIGN(task);
 	),
 
 	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER,
@@ -476,8 +467,7 @@ DECLARE_EVENT_CLASS(rpc_reply_event,
 	),
 
 	TP_fast_assign(
-		__entry->task_id = task->tk_pid;
-		__entry->client_id = task->tk_client->cl_clid;
+		SUNRPC_TRACE_TASK_ASSIGN(task);
 		__entry->xid = be32_to_cpu(task->tk_rqstp->rq_xid);
 		__assign_str(progname, task->tk_client->cl_program->name);
 		__entry->version = task->tk_client->cl_vers;
@@ -539,8 +529,7 @@ TRACE_EVENT(rpc_buf_alloc,
 	),
 
 	TP_fast_assign(
-		__entry->task_id = task->tk_pid;
-		__entry->client_id = task->tk_client->cl_clid;
+		SUNRPC_TRACE_TASK_ASSIGN(task);
 		__entry->callsize = task->tk_rqstp->rq_callsize;
 		__entry->recvsize = task->tk_rqstp->rq_rcvsize;
 		__entry->status = status;
@@ -570,8 +559,7 @@ TRACE_EVENT(rpc_call_rpcerror,
 	),
 
 	TP_fast_assign(
-		__entry->client_id = task->tk_client->cl_clid;
-		__entry->task_id = task->tk_pid;
+		SUNRPC_TRACE_TASK_ASSIGN(task);
 		__entry->tk_status = tk_status;
 		__entry->rpc_status = rpc_status;
 	),
@@ -606,8 +594,7 @@ TRACE_EVENT(rpc_stats_latency,
 	),
 
 	TP_fast_assign(
-		__entry->client_id = task->tk_client->cl_clid;
-		__entry->task_id = task->tk_pid;
+		SUNRPC_TRACE_TASK_ASSIGN(task);
 		__entry->xid = be32_to_cpu(task->tk_rqstp->rq_xid);
 		__entry->version = task->tk_client->cl_vers;
 		__assign_str(progname, task->tk_client->cl_program->name);
@@ -655,8 +642,7 @@ TRACE_EVENT(rpc_xdr_overflow,
 		if (xdr->rqst) {
 			const struct rpc_task *task = xdr->rqst->rq_task;
 
-			__entry->task_id = task->tk_pid;
-			__entry->client_id = task->tk_client->cl_clid;
+			SUNRPC_TRACE_TASK_ASSIGN(task);
 			__assign_str(progname,
 				     task->tk_client->cl_program->name);
 			__entry->version = task->tk_client->cl_vers;
@@ -721,8 +707,7 @@ TRACE_EVENT(rpc_xdr_alignment,
 	TP_fast_assign(
 		const struct rpc_task *task = xdr->rqst->rq_task;
 
-		__entry->task_id = task->tk_pid;
-		__entry->client_id = task->tk_client->cl_clid;
+		SUNRPC_TRACE_TASK_ASSIGN(task);
 		__assign_str(progname,
 			     task->tk_client->cl_program->name);
 		__entry->version = task->tk_client->cl_vers;
@@ -922,8 +907,7 @@ TRACE_EVENT(rpc_socket_nospace,
 	),
 
 	TP_fast_assign(
-		__entry->task_id = rqst->rq_task->tk_pid;
-		__entry->client_id = rqst->rq_task->tk_client->cl_clid;
+		SUNRPC_TRACE_TASK_ASSIGN(rqst->rq_task);
 		__entry->total = rqst->rq_slen;
 		__entry->remaining = rqst->rq_slen - transport->xmit.offset;
 	),
@@ -1046,9 +1030,7 @@ TRACE_EVENT(xprt_transmit,
 	),
 
 	TP_fast_assign(
-		__entry->task_id = rqst->rq_task->tk_pid;
-		__entry->client_id = rqst->rq_task->tk_client ?
-			rqst->rq_task->tk_client->cl_clid : -1;
+		SUNRPC_TRACE_TASK_ASSIGN(rqst->rq_task);
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
 		__entry->seqno = rqst->rq_seqno;
 		__entry->status = status;
@@ -1082,9 +1064,7 @@ TRACE_EVENT(xprt_retransmit,
 	TP_fast_assign(
 		struct rpc_task *task = rqst->rq_task;
 
-		__entry->task_id = task->tk_pid;
-		__entry->client_id = task->tk_client ?
-			task->tk_client->cl_clid : -1;
+		SUNRPC_TRACE_TASK_ASSIGN(task);
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
 		__entry->ntrans = rqst->rq_ntrans;
 		__entry->timeout = task->tk_timeout;
@@ -1137,14 +1117,7 @@ DECLARE_EVENT_CLASS(xprt_writelock_event,
 	),
 
 	TP_fast_assign(
-		if (task) {
-			__entry->task_id = task->tk_pid;
-			__entry->client_id = task->tk_client ?
-					     task->tk_client->cl_clid : -1;
-		} else {
-			__entry->task_id = -1;
-			__entry->client_id = -1;
-		}
+		SUNRPC_TRACE_TASK_ASSIGN(task);
 		__entry->snd_task_id = xprt->snd_task ?
 					xprt->snd_task->tk_pid : -1;
 	),
@@ -1183,14 +1156,7 @@ DECLARE_EVENT_CLASS(xprt_cong_event,
 	),
 
 	TP_fast_assign(
-		if (task) {
-			__entry->task_id = task->tk_pid;
-			__entry->client_id = task->tk_client ?
-					     task->tk_client->cl_clid : -1;
-		} else {
-			__entry->task_id = -1;
-			__entry->client_id = -1;
-		}
+		SUNRPC_TRACE_TASK_ASSIGN(task);
 		__entry->snd_task_id = xprt->snd_task ?
 					xprt->snd_task->tk_pid : -1;
 		__entry->cong = xprt->cong;
@@ -1233,8 +1199,7 @@ TRACE_EVENT(xprt_reserve,
 	),
 
 	TP_fast_assign(
-		__entry->task_id = rqst->rq_task->tk_pid;
-		__entry->client_id = rqst->rq_task->tk_client->cl_clid;
+		SUNRPC_TRACE_TASK_ASSIGN(rqst->rq_task);
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
 	),
 
@@ -1318,8 +1283,7 @@ TRACE_EVENT(rpcb_getport,
 	),
 
 	TP_fast_assign(
-		__entry->task_id = task->tk_pid;
-		__entry->client_id = clnt->cl_clid;
+		SUNRPC_TRACE_TASK_ASSIGN(task);
 		__entry->program = clnt->cl_prog;
 		__entry->version = clnt->cl_vers;
 		__entry->protocol = task->tk_xprt->prot;
@@ -1352,8 +1316,7 @@ TRACE_EVENT(rpcb_setport,
 	),
 
 	TP_fast_assign(
-		__entry->task_id = task->tk_pid;
-		__entry->client_id = task->tk_client->cl_clid;
+		SUNRPC_TRACE_TASK_ASSIGN(task);
 		__entry->status = status;
 		__entry->port = port;
 	),
diff --git a/include/trace/events/sunrpc_base.h b/include/trace/events/sunrpc_base.h
index 588557d07ea8..2cbed4a9a63a 100644
--- a/include/trace/events/sunrpc_base.h
+++ b/include/trace/events/sunrpc_base.h
@@ -10,6 +10,21 @@
 
 #include <linux/tracepoint.h>
 
+#define SUNRPC_TRACE_PID_SPECIAL	(-1)
+
+#define SUNRPC_TRACE_TASK_ASSIGN(t) \
+	do { \
+		if ((t) != NULL) { \
+			__entry->task_id = (t)->tk_pid; \
+			__entry->client_id = (t)->tk_client ? \
+					     (t)->tk_client->cl_clid : \
+					     SUNRPC_TRACE_PID_SPECIAL; \
+		} else { \
+			__entry->task_id = SUNRPC_TRACE_PID_SPECIAL; \
+			__entry->client_id = SUNRPC_TRACE_PID_SPECIAL; \
+		} \
+	} while (0);
+
 #define SUNRPC_TRACE_PID_SPECIFIER	"%08x"
 #define SUNRPC_TRACE_CLID_SPECIFIER	"%08x"
 #define SUNRPC_TRACE_TASK_SPECIFIER \


