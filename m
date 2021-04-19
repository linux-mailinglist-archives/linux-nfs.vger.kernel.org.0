Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E050936496A
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Apr 2021 20:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240468AbhDSSC2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Apr 2021 14:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240433AbhDSSC2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Apr 2021 14:02:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39B0961107;
        Mon, 19 Apr 2021 18:01:58 +0000 (UTC)
Subject: [PATCH v3 03/26] SUNRPC: Add tracepoint that fires when an RPC is
 retransmitted
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Apr 2021 14:01:57 -0400
Message-ID: <161885531743.38598.12834180318353718088.stgit@manet.1015granger.net>
In-Reply-To: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
References: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A separate tracepoint can be left enabled all the time to capture
rare but important retransmission events. So for example:

kworker/u26:3-568   [009]   156.967933: xprt_retransmit:      task:44093@5 xid=0xa25dbc79 nfsv3 WRITE ntrans=2

Or, for example, enable all nfs and nfs4 tracepoints, and set up a
trigger to disable tracing when xprt_retransmit fires to capture
everything that leads up to it.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   40 ++++++++++++++++++++++++++++++++++++++++
 net/sunrpc/xprt.c             |    4 +++-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 2f01314de73a..3c3c4c843c62 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1079,6 +1079,46 @@ TRACE_EVENT(xprt_transmit,
 		__entry->seqno, __entry->status)
 );
 
+TRACE_EVENT(xprt_retransmit,
+	TP_PROTO(
+		const struct rpc_rqst *rqst
+	),
+
+	TP_ARGS(rqst),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, task_id)
+		__field(unsigned int, client_id)
+		__field(u32, xid)
+		__field(int, ntrans)
+		__field(int, version)
+		__string(progname,
+			 rqst->rq_task->tk_client->cl_program->name)
+		__string(procedure,
+			 rqst->rq_task->tk_msg.rpc_proc->p_name)
+	),
+
+	TP_fast_assign(
+		struct rpc_task *task = rqst->rq_task;
+
+		__entry->task_id = task->tk_pid;
+		__entry->client_id = task->tk_client ?
+			task->tk_client->cl_clid : -1;
+		__entry->xid = be32_to_cpu(rqst->rq_xid);
+		__entry->ntrans = rqst->rq_ntrans;
+		__assign_str(progname,
+			     task->tk_client->cl_program->name)
+		__entry->version = task->tk_client->cl_vers;
+		__assign_str(procedure, task->tk_msg.rpc_proc->p_name)
+	),
+
+	TP_printk(
+		"task:%u@%u xid=0x%08x %sv%d %s ntrans=%d",
+		__entry->task_id, __entry->client_id, __entry->xid,
+		__get_str(progname), __entry->version, __get_str(procedure),
+		__entry->ntrans)
+);
+
 TRACE_EVENT(xprt_ping,
 	TP_PROTO(const struct rpc_xprt *xprt, int status),
 
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 11ebe8a127b8..43bc093c66b9 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1538,8 +1538,10 @@ xprt_request_transmit(struct rpc_rqst *req, struct rpc_task *snd_task)
 		return status;
 	}
 
-	if (is_retrans)
+	if (is_retrans) {
 		task->tk_client->cl_stats->rpcretrans++;
+		trace_xprt_retransmit(req);
+	}
 
 	xprt_inject_disconnect(xprt);
 


