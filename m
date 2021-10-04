Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BBA421106
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Oct 2021 16:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhJDOLy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Oct 2021 10:11:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhJDOLx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 4 Oct 2021 10:11:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A620611C1;
        Mon,  4 Oct 2021 14:10:04 +0000 (UTC)
Subject: [PATCH 2/4] SUNRPC: Tracepoints should store tk_pid and cl_clid as a
 signed int
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 04 Oct 2021 10:10:03 -0400
Message-ID: <163335660381.1225.8730120749232774829.stgit@morisot.1015granger.net>
In-Reply-To: <163335628674.1225.6965764965914263799.stgit@morisot.1015granger.net>
References: <163335628674.1225.6965764965914263799.stgit@morisot.1015granger.net>
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

ida_simple_get() returns a signed integer. Negative values are error
returns, but this suggests the range of valid client IDs is zero to
2^31 - 1.

tk_pid is currently an unsigned short, so its range is zero to
65535.

For certain special cases, RPC-related tracepoints record a -1 as
the task ID or the client ID. It's ugly for a trace event to display
4 billion in these cases.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs4trace.h             |   12 ++-
 fs/nfs/nfstrace.h              |    6 +-
 include/linux/sunrpc/clnt.h    |    2 -
 include/trace/events/rpcgss.h  |   30 ++++-----
 include/trace/events/rpcrdma.h |   90 +++++++++++++-------------
 include/trace/events/sunrpc.h  |  140 ++++++++++++++++++++--------------------
 6 files changed, 140 insertions(+), 140 deletions(-)

diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 7a2567aa2b86..440f88ec20b8 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -676,8 +676,8 @@ TRACE_EVENT(nfs4_xdr_bad_operation,
 		TP_ARGS(xdr, op, expected),
 
 		TP_STRUCT__entry(
-			__field(unsigned int, task_id)
-			__field(unsigned int, client_id)
+			__field(int, task_id)
+			__field(int, client_id)
 			__field(u32, xid)
 			__field(u32, op)
 			__field(u32, expected)
@@ -695,7 +695,7 @@ TRACE_EVENT(nfs4_xdr_bad_operation,
 		),
 
 		TP_printk(
-			"task:%u@%d xid=0x%08x operation=%u, expected=%u",
+			"task:%d@%d xid=0x%08x operation=%u, expected=%u",
 			__entry->task_id, __entry->client_id, __entry->xid,
 			__entry->op, __entry->expected
 		)
@@ -711,8 +711,8 @@ DECLARE_EVENT_CLASS(nfs4_xdr_event,
 		TP_ARGS(xdr, op, error),
 
 		TP_STRUCT__entry(
-			__field(unsigned int, task_id)
-			__field(unsigned int, client_id)
+			__field(int, task_id)
+			__field(int, client_id)
 			__field(u32, xid)
 			__field(u32, op)
 			__field(unsigned long, error)
@@ -730,7 +730,7 @@ DECLARE_EVENT_CLASS(nfs4_xdr_event,
 		),
 
 		TP_printk(
-			"task:%u@%d xid=0x%08x error=%ld (%s) operation=%u",
+			"task:%d@%d xid=0x%08x error=%ld (%s) operation=%u",
 			__entry->task_id, __entry->client_id, __entry->xid,
 			-__entry->error, show_nfsv4_errors(__entry->error),
 			__entry->op
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 589f32fdbe63..4094e2856cf9 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1334,8 +1334,8 @@ DECLARE_EVENT_CLASS(nfs_xdr_event,
 		TP_ARGS(xdr, error),
 
 		TP_STRUCT__entry(
-			__field(unsigned int, task_id)
-			__field(unsigned int, client_id)
+			__field(int, task_id)
+			__field(int, client_id)
 			__field(u32, xid)
 			__field(int, version)
 			__field(unsigned long, error)
@@ -1360,7 +1360,7 @@ DECLARE_EVENT_CLASS(nfs_xdr_event,
 		),
 
 		TP_printk(
-			"task:%u@%d xid=0x%08x %sv%d %s error=%ld (%s)",
+			"task:%d@%d xid=0x%08x %sv%d %s error=%ld (%s)",
 			__entry->task_id, __entry->client_id, __entry->xid,
 			__get_str(program), __entry->version,
 			__get_str(procedure), -__entry->error,
diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index a4661646adc9..bd22f14c4b19 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -37,7 +37,7 @@ struct rpc_sysfs_client;
  */
 struct rpc_clnt {
 	refcount_t		cl_count;	/* Number of references */
-	unsigned int		cl_clid;	/* client id */
+	int			cl_clid;	/* client id */
 	struct list_head	cl_clients;	/* Global list of clients */
 	struct list_head	cl_tasks;	/* List of tasks */
 	spinlock_t		cl_lock;	/* spinlock */
diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.h
index b2a2672e6632..746965228585 100644
--- a/include/trace/events/rpcgss.h
+++ b/include/trace/events/rpcgss.h
@@ -87,8 +87,8 @@ DECLARE_EVENT_CLASS(rpcgss_gssapi_event,
 	TP_ARGS(task, maj_stat),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(u32, maj_stat)
 
 	),
@@ -99,7 +99,7 @@ DECLARE_EVENT_CLASS(rpcgss_gssapi_event,
 		__entry->maj_stat = maj_stat;
 	),
 
-	TP_printk("task:%u@%u maj_stat=%s",
+	TP_printk("task:%d@%d maj_stat=%s",
 		__entry->task_id, __entry->client_id,
 		__entry->maj_stat == 0 ?
 		"GSS_S_COMPLETE" : show_gss_status(__entry->maj_stat))
@@ -323,8 +323,8 @@ TRACE_EVENT(rpcgss_unwrap_failed,
 	TP_ARGS(task),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 	),
 
 	TP_fast_assign(
@@ -332,7 +332,7 @@ TRACE_EVENT(rpcgss_unwrap_failed,
 		__entry->client_id = task->tk_client->cl_clid;
 	),
 
-	TP_printk("task:%u@%u", __entry->task_id, __entry->client_id)
+	TP_printk("task:%d@%d", __entry->task_id, __entry->client_id)
 );
 
 TRACE_EVENT(rpcgss_bad_seqno,
@@ -345,8 +345,8 @@ TRACE_EVENT(rpcgss_bad_seqno,
 	TP_ARGS(task, expected, received),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(u32, expected)
 		__field(u32, received)
 	),
@@ -358,7 +358,7 @@ TRACE_EVENT(rpcgss_bad_seqno,
 		__entry->received = received;
 	),
 
-	TP_printk("task:%u@%u expected seqno %u, received seqno %u",
+	TP_printk("task:%d@%d expected seqno %u, received seqno %u",
 		__entry->task_id, __entry->client_id,
 		__entry->expected, __entry->received)
 );
@@ -372,7 +372,7 @@ TRACE_EVENT(rpcgss_seqno,
 
 	TP_STRUCT__entry(
 		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, client_id)
 		__field(u32, xid)
 		__field(u32, seqno)
 	),
@@ -386,7 +386,7 @@ TRACE_EVENT(rpcgss_seqno,
 		__entry->seqno = rqst->rq_seqno;
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x seqno=%u",
+	TP_printk("task:%u@%d xid=0x%08x seqno=%u",
 		__entry->task_id, __entry->client_id,
 		__entry->xid, __entry->seqno)
 );
@@ -402,7 +402,7 @@ TRACE_EVENT(rpcgss_need_reencode,
 
 	TP_STRUCT__entry(
 		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, client_id)
 		__field(u32, xid)
 		__field(u32, seq_xmit)
 		__field(u32, seqno)
@@ -418,7 +418,7 @@ TRACE_EVENT(rpcgss_need_reencode,
 		__entry->ret = ret;
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x rq_seqno=%u seq_xmit=%u reencode %sneeded",
+	TP_printk("task:%u@%d xid=0x%08x rq_seqno=%u seq_xmit=%u reencode %sneeded",
 		__entry->task_id, __entry->client_id,
 		__entry->xid, __entry->seqno, __entry->seq_xmit,
 		__entry->ret ? "" : "un")
@@ -434,7 +434,7 @@ TRACE_EVENT(rpcgss_update_slack,
 
 	TP_STRUCT__entry(
 		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, client_id)
 		__field(u32, xid)
 		__field(const void *, auth)
 		__field(unsigned int, rslack)
@@ -452,7 +452,7 @@ TRACE_EVENT(rpcgss_update_slack,
 		__entry->verfsize = auth->au_verfsize;
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x auth=%p rslack=%u ralign=%u verfsize=%u\n",
+	TP_printk("task:%u@%d xid=0x%08x auth=%p rslack=%u ralign=%u verfsize=%u\n",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->auth, __entry->rslack, __entry->ralign,
 		__entry->verfsize)
diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index afb2e394797c..b174ef8d168e 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -258,8 +258,8 @@ DECLARE_EVENT_CLASS(xprtrdma_rdch_event,
 	TP_ARGS(task, pos, mr, nsegs),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(unsigned int, pos)
 		__field(int, nents)
 		__field(u32, handle)
@@ -279,7 +279,7 @@ DECLARE_EVENT_CLASS(xprtrdma_rdch_event,
 		__entry->nsegs = nsegs;
 	),
 
-	TP_printk("task:%u@%u pos=%u %u@0x%016llx:0x%08x (%s)",
+	TP_printk("task:%d@%d pos=%u %u@0x%016llx:0x%08x (%s)",
 		__entry->task_id, __entry->client_id,
 		__entry->pos, __entry->length,
 		(unsigned long long)__entry->offset, __entry->handle,
@@ -307,8 +307,8 @@ DECLARE_EVENT_CLASS(xprtrdma_wrch_event,
 	TP_ARGS(task, mr, nsegs),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(int, nents)
 		__field(u32, handle)
 		__field(u32, length)
@@ -326,7 +326,7 @@ DECLARE_EVENT_CLASS(xprtrdma_wrch_event,
 		__entry->nsegs = nsegs;
 	),
 
-	TP_printk("task:%u@%u %u@0x%016llx:0x%08x (%s)",
+	TP_printk("task:%d@%d %u@0x%016llx:0x%08x (%s)",
 		__entry->task_id, __entry->client_id,
 		__entry->length, (unsigned long long)__entry->offset,
 		__entry->handle,
@@ -363,8 +363,8 @@ DECLARE_EVENT_CLASS(xprtrdma_mr_class,
 	TP_ARGS(mr),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(u32, mr_id)
 		__field(int, nents)
 		__field(u32, handle)
@@ -393,7 +393,7 @@ DECLARE_EVENT_CLASS(xprtrdma_mr_class,
 		__entry->dir    = mr->mr_dir;
 	),
 
-	TP_printk("task:%u@%u mr.id=%u nents=%d %u@0x%016llx:0x%08x (%s)",
+	TP_printk("task:%d@%d mr.id=%u nents=%d %u@0x%016llx:0x%08x (%s)",
 		__entry->task_id, __entry->client_id,
 		__entry->mr_id, __entry->nents, __entry->length,
 		(unsigned long long)__entry->offset, __entry->handle,
@@ -621,8 +621,8 @@ TRACE_EVENT(xprtrdma_nomrs_err,
 	TP_ARGS(r_xprt, req),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__string(addr, rpcrdma_addrstr(r_xprt))
 		__string(port, rpcrdma_portstr(r_xprt))
 	),
@@ -636,7 +636,7 @@ TRACE_EVENT(xprtrdma_nomrs_err,
 		__assign_str(port, rpcrdma_portstr(r_xprt));
 	),
 
-	TP_printk("peer=[%s]:%s task:%u@%u",
+	TP_printk("peer=[%s]:%s task:%d@%d",
 		__get_str(addr), __get_str(port),
 		__entry->task_id, __entry->client_id
 	)
@@ -675,8 +675,8 @@ TRACE_EVENT(xprtrdma_marshal,
 	TP_ARGS(req, rtype, wtype),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(u32, xid)
 		__field(unsigned int, hdrlen)
 		__field(unsigned int, headlen)
@@ -700,7 +700,7 @@ TRACE_EVENT(xprtrdma_marshal,
 		__entry->wtype = wtype;
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x: hdr=%u xdr=%u/%u/%u %s/%s",
+	TP_printk("task:%d@%d xid=0x%08x: hdr=%u xdr=%u/%u/%u %s/%s",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->hdrlen,
 		__entry->headlen, __entry->pagelen, __entry->taillen,
@@ -717,8 +717,8 @@ TRACE_EVENT(xprtrdma_marshal_failed,
 	TP_ARGS(rqst, ret),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(u32, xid)
 		__field(int, ret)
 	),
@@ -730,7 +730,7 @@ TRACE_EVENT(xprtrdma_marshal_failed,
 		__entry->ret = ret;
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x: ret=%d",
+	TP_printk("task:%d@%d xid=0x%08x: ret=%d",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->ret
 	)
@@ -744,8 +744,8 @@ TRACE_EVENT(xprtrdma_prepsend_failed,
 	TP_ARGS(rqst, ret),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(u32, xid)
 		__field(int, ret)
 	),
@@ -757,7 +757,7 @@ TRACE_EVENT(xprtrdma_prepsend_failed,
 		__entry->ret = ret;
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x: ret=%d",
+	TP_printk("task:%d@%d xid=0x%08x: ret=%d",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->ret
 	)
@@ -773,8 +773,8 @@ TRACE_EVENT(xprtrdma_post_send,
 	TP_STRUCT__entry(
 		__field(u32, cq_id)
 		__field(int, completion_id)
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(int, num_sge)
 		__field(int, signaled)
 	),
@@ -792,7 +792,7 @@ TRACE_EVENT(xprtrdma_post_send,
 		__entry->signaled = req->rl_wr.send_flags & IB_SEND_SIGNALED;
 	),
 
-	TP_printk("task:%u@%u cq.id=%u cid=%d (%d SGE%s) %s",
+	TP_printk("task:%d@%d cq.id=%u cid=%d (%d SGE%s) %s",
 		__entry->task_id, __entry->client_id,
 		__entry->cq_id, __entry->completion_id,
 		__entry->num_sge, (__entry->num_sge == 1 ? "" : "s"),
@@ -926,8 +926,8 @@ TRACE_EVENT(xprtrdma_post_linv_err,
 	TP_ARGS(req, status),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(int, status)
 	),
 
@@ -939,7 +939,7 @@ TRACE_EVENT(xprtrdma_post_linv_err,
 		__entry->status = status;
 	),
 
-	TP_printk("task:%u@%u status=%d",
+	TP_printk("task:%d@%d status=%d",
 		__entry->task_id, __entry->client_id, __entry->status
 	)
 );
@@ -1114,8 +1114,8 @@ TRACE_EVENT(xprtrdma_reply,
 	TP_ARGS(task, rep, credits),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(u32, xid)
 		__field(unsigned int, credits)
 	),
@@ -1127,7 +1127,7 @@ TRACE_EVENT(xprtrdma_reply,
 		__entry->credits = credits;
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x credits=%u",
+	TP_printk("task:%d@%d xid=0x%08x credits=%u",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->credits
 	)
@@ -1148,8 +1148,8 @@ TRACE_EVENT(xprtrdma_err_vers,
 	TP_ARGS(rqst, min, max),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(u32, xid)
 		__field(u32, min)
 		__field(u32, max)
@@ -1163,7 +1163,7 @@ TRACE_EVENT(xprtrdma_err_vers,
 		__entry->max = be32_to_cpup(max);
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x versions=[%u, %u]",
+	TP_printk("task:%d@%d xid=0x%08x versions=[%u, %u]",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->min, __entry->max
 	)
@@ -1177,8 +1177,8 @@ TRACE_EVENT(xprtrdma_err_chunk,
 	TP_ARGS(rqst),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(u32, xid)
 	),
 
@@ -1188,7 +1188,7 @@ TRACE_EVENT(xprtrdma_err_chunk,
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x",
+	TP_printk("task:%d@%d xid=0x%08x",
 		__entry->task_id, __entry->client_id, __entry->xid
 	)
 );
@@ -1202,8 +1202,8 @@ TRACE_EVENT(xprtrdma_err_unrecognized,
 	TP_ARGS(rqst, procedure),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(u32, xid)
 		__field(u32, procedure)
 	),
@@ -1214,7 +1214,7 @@ TRACE_EVENT(xprtrdma_err_unrecognized,
 		__entry->procedure = be32_to_cpup(procedure);
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x procedure=%u",
+	TP_printk("task:%d@%d xid=0x%08x procedure=%u",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->procedure
 	)
@@ -1229,8 +1229,8 @@ TRACE_EVENT(xprtrdma_fixup,
 	TP_ARGS(rqst, fixup),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(unsigned long, fixup)
 		__field(size_t, headlen)
 		__field(unsigned int, pagelen)
@@ -1246,7 +1246,7 @@ TRACE_EVENT(xprtrdma_fixup,
 		__entry->taillen = rqst->rq_rcv_buf.tail[0].iov_len;
 	),
 
-	TP_printk("task:%u@%u fixup=%lu xdr=%zu/%u/%zu",
+	TP_printk("task:%d@%d fixup=%lu xdr=%zu/%u/%zu",
 		__entry->task_id, __entry->client_id, __entry->fixup,
 		__entry->headlen, __entry->pagelen, __entry->taillen
 	)
@@ -1287,8 +1287,8 @@ TRACE_EVENT(xprtrdma_mrs_zap,
 	TP_ARGS(task),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 	),
 
 	TP_fast_assign(
@@ -1296,7 +1296,7 @@ TRACE_EVENT(xprtrdma_mrs_zap,
 		__entry->client_id = task->tk_client->cl_clid;
 	),
 
-	TP_printk("task:%u@%u",
+	TP_printk("task:%d@%d",
 		__entry->task_id, __entry->client_id
 	)
 );
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 2d04eb96d418..ce6f717efac3 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -56,8 +56,8 @@ DECLARE_EVENT_CLASS(rpc_xdr_buf_class,
 	TP_ARGS(task, xdr),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(const void *, head_base)
 		__field(size_t, head_len)
 		__field(const void *, tail_base)
@@ -78,7 +78,7 @@ DECLARE_EVENT_CLASS(rpc_xdr_buf_class,
 		__entry->msg_len = xdr->len;
 	),
 
-	TP_printk("task:%u@%u head=[%p,%zu] page=%u tail=[%p,%zu] len=%u",
+	TP_printk("task:%d@%d head=[%p,%zu] page=%u tail=[%p,%zu] len=%u",
 		__entry->task_id, __entry->client_id,
 		__entry->head_base, __entry->head_len, __entry->page_len,
 		__entry->tail_base, __entry->tail_len, __entry->msg_len
@@ -107,14 +107,14 @@ DECLARE_EVENT_CLASS(rpc_clnt_class,
 	TP_ARGS(clnt),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, client_id)
+		__field(int, client_id)
 	),
 
 	TP_fast_assign(
 		__entry->client_id = clnt->cl_clid;
 	),
 
-	TP_printk("clid=%u", __entry->client_id)
+	TP_printk("clid=%d", __entry->client_id)
 );
 
 #define DEFINE_RPC_CLNT_EVENT(name)					\
@@ -143,7 +143,7 @@ TRACE_EVENT(rpc_clnt_new,
 	TP_ARGS(clnt, xprt, program, server),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, client_id)
+		__field(int, client_id)
 		__string(addr, xprt->address_strings[RPC_DISPLAY_ADDR])
 		__string(port, xprt->address_strings[RPC_DISPLAY_PORT])
 		__string(program, program)
@@ -158,7 +158,7 @@ TRACE_EVENT(rpc_clnt_new,
 		__assign_str(server, server);
 	),
 
-	TP_printk("client=%u peer=[%s]:%s program=%s server=%s",
+	TP_printk("client=%d peer=[%s]:%s program=%s server=%s",
 		__entry->client_id, __get_str(addr), __get_str(port),
 		__get_str(program), __get_str(server))
 );
@@ -197,7 +197,7 @@ TRACE_EVENT(rpc_clnt_clone_err,
 	TP_ARGS(clnt, error),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, client_id)
+		__field(int, client_id)
 		__field(int, error)
 	),
 
@@ -206,7 +206,7 @@ TRACE_EVENT(rpc_clnt_clone_err,
 		__entry->error = error;
 	),
 
-	TP_printk("client=%u error=%d", __entry->client_id, __entry->error)
+	TP_printk("client=%d error=%d", __entry->client_id, __entry->error)
 );
 
 
@@ -237,8 +237,8 @@ DECLARE_EVENT_CLASS(rpc_task_status,
 	TP_ARGS(task),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(int, status)
 	),
 
@@ -248,7 +248,7 @@ DECLARE_EVENT_CLASS(rpc_task_status,
 		__entry->status = task->tk_status;
 	),
 
-	TP_printk("task:%u@%u status=%d",
+	TP_printk("task:%d@%d status=%d",
 		__entry->task_id, __entry->client_id,
 		__entry->status)
 );
@@ -271,8 +271,8 @@ TRACE_EVENT(rpc_request,
 	TP_ARGS(task),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(int, version)
 		__field(bool, async)
 		__string(progname, task->tk_client->cl_program->name)
@@ -288,7 +288,7 @@ TRACE_EVENT(rpc_request,
 		__assign_str(procname, rpc_proc_name(task));
 	),
 
-	TP_printk("task:%u@%u %sv%d %s (%ssync)",
+	TP_printk("task:%d@%d %sv%d %s (%ssync)",
 		__entry->task_id, __entry->client_id,
 		__get_str(progname), __entry->version,
 		__get_str(procname), __entry->async ? "a": ""
@@ -330,8 +330,8 @@ DECLARE_EVENT_CLASS(rpc_task_running,
 	TP_ARGS(task, action),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(const void *, action)
 		__field(unsigned long, runstate)
 		__field(int, status)
@@ -348,7 +348,7 @@ DECLARE_EVENT_CLASS(rpc_task_running,
 		__entry->flags = task->tk_flags;
 		),
 
-	TP_printk("task:%u@%d flags=%s runstate=%s status=%d action=%ps",
+	TP_printk("task:%d@%d flags=%s runstate=%s status=%d action=%ps",
 		__entry->task_id, __entry->client_id,
 		rpc_show_task_flags(__entry->flags),
 		rpc_show_runstate(__entry->runstate),
@@ -380,8 +380,8 @@ DECLARE_EVENT_CLASS(rpc_task_queued,
 	TP_ARGS(task, q),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(unsigned long, timeout)
 		__field(unsigned long, runstate)
 		__field(int, status)
@@ -400,7 +400,7 @@ DECLARE_EVENT_CLASS(rpc_task_queued,
 		__assign_str(q_name, rpc_qname(q));
 		),
 
-	TP_printk("task:%u@%d flags=%s runstate=%s status=%d timeout=%lu queue=%s",
+	TP_printk("task:%d@%d flags=%s runstate=%s status=%d timeout=%lu queue=%s",
 		__entry->task_id, __entry->client_id,
 		rpc_show_task_flags(__entry->flags),
 		rpc_show_runstate(__entry->runstate),
@@ -427,8 +427,8 @@ DECLARE_EVENT_CLASS(rpc_failure,
 	TP_ARGS(task),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 	),
 
 	TP_fast_assign(
@@ -436,7 +436,7 @@ DECLARE_EVENT_CLASS(rpc_failure,
 		__entry->client_id = task->tk_client->cl_clid;
 	),
 
-	TP_printk("task:%u@%u",
+	TP_printk("task:%d@%d",
 		__entry->task_id, __entry->client_id)
 );
 
@@ -459,8 +459,8 @@ DECLARE_EVENT_CLASS(rpc_reply_event,
 	TP_ARGS(task),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(u32, xid)
 		__string(progname, task->tk_client->cl_program->name)
 		__field(u32, version)
@@ -478,7 +478,7 @@ DECLARE_EVENT_CLASS(rpc_reply_event,
 		__assign_str(servername, task->tk_xprt->servername);
 	),
 
-	TP_printk("task:%u@%d server=%s xid=0x%08x %sv%d %s",
+	TP_printk("task:%d@%d server=%s xid=0x%08x %sv%d %s",
 		__entry->task_id, __entry->client_id, __get_str(servername),
 		__entry->xid, __get_str(progname), __entry->version,
 		__get_str(procname))
@@ -523,8 +523,8 @@ TRACE_EVENT(rpc_buf_alloc,
 	TP_ARGS(task, status),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(size_t, callsize)
 		__field(size_t, recvsize)
 		__field(int, status)
@@ -538,7 +538,7 @@ TRACE_EVENT(rpc_buf_alloc,
 		__entry->status = status;
 	),
 
-	TP_printk("task:%u@%u callsize=%zu recvsize=%zu status=%d",
+	TP_printk("task:%d@%d callsize=%zu recvsize=%zu status=%d",
 		__entry->task_id, __entry->client_id,
 		__entry->callsize, __entry->recvsize, __entry->status
 	)
@@ -554,8 +554,8 @@ TRACE_EVENT(rpc_call_rpcerror,
 	TP_ARGS(task, tk_status, rpc_status),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(int, tk_status)
 		__field(int, rpc_status)
 	),
@@ -567,7 +567,7 @@ TRACE_EVENT(rpc_call_rpcerror,
 		__entry->rpc_status = rpc_status;
 	),
 
-	TP_printk("task:%u@%u tk_status=%d rpc_status=%d",
+	TP_printk("task:%d@%d tk_status=%d rpc_status=%d",
 		__entry->task_id, __entry->client_id,
 		__entry->tk_status, __entry->rpc_status)
 );
@@ -584,8 +584,8 @@ TRACE_EVENT(rpc_stats_latency,
 	TP_ARGS(task, backlog, rtt, execute),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(u32, xid)
 		__field(int, version)
 		__string(progname, task->tk_client->cl_program->name)
@@ -607,7 +607,7 @@ TRACE_EVENT(rpc_stats_latency,
 		__entry->execute = ktime_to_us(execute);
 	),
 
-	TP_printk("task:%u@%d xid=0x%08x %sv%d %s backlog=%lu rtt=%lu execute=%lu",
+	TP_printk("task:%d@%d xid=0x%08x %sv%d %s backlog=%lu rtt=%lu execute=%lu",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__get_str(progname), __entry->version, __get_str(procname),
 		__entry->backlog, __entry->rtt, __entry->execute)
@@ -622,8 +622,8 @@ TRACE_EVENT(rpc_xdr_overflow,
 	TP_ARGS(xdr, requested),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(int, version)
 		__field(size_t, requested)
 		__field(const void *, end)
@@ -651,8 +651,8 @@ TRACE_EVENT(rpc_xdr_overflow,
 			__entry->version = task->tk_client->cl_vers;
 			__assign_str(procedure, task->tk_msg.rpc_proc->p_name);
 		} else {
-			__entry->task_id = 0;
-			__entry->client_id = 0;
+			__entry->task_id = -1;
+			__entry->client_id = -1;
 			__assign_str(progname, "unknown");
 			__entry->version = 0;
 			__assign_str(procedure, "unknown");
@@ -669,7 +669,7 @@ TRACE_EVENT(rpc_xdr_overflow,
 	),
 
 	TP_printk(
-		"task:%u@%u %sv%d %s requested=%zu p=%p end=%p xdr=[%p,%zu]/%u/[%p,%zu]/%u\n",
+		"task:%d@%d %sv%d %s requested=%zu p=%p end=%p xdr=[%p,%zu]/%u/[%p,%zu]/%u\n",
 		__entry->task_id, __entry->client_id,
 		__get_str(progname), __entry->version, __get_str(procedure),
 		__entry->requested, __entry->p, __entry->end,
@@ -690,8 +690,8 @@ TRACE_EVENT(rpc_xdr_alignment,
 	TP_ARGS(xdr, offset, copied),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(int, version)
 		__field(size_t, offset)
 		__field(unsigned int, copied)
@@ -728,7 +728,7 @@ TRACE_EVENT(rpc_xdr_alignment,
 	),
 
 	TP_printk(
-		"task:%u@%u %sv%d %s offset=%zu copied=%u xdr=[%p,%zu]/%u/[%p,%zu]/%u\n",
+		"task:%d@%d %sv%d %s offset=%zu copied=%u xdr=[%p,%zu]/%u/[%p,%zu]/%u\n",
 		__entry->task_id, __entry->client_id,
 		__get_str(progname), __entry->version, __get_str(procedure),
 		__entry->offset, __entry->copied,
@@ -904,8 +904,8 @@ TRACE_EVENT(rpc_socket_nospace,
 	TP_ARGS(rqst, transport),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(unsigned int, total)
 		__field(unsigned int, remaining)
 	),
@@ -917,7 +917,7 @@ TRACE_EVENT(rpc_socket_nospace,
 		__entry->remaining = rqst->rq_slen - transport->xmit.offset;
 	),
 
-	TP_printk("task:%u@%u total=%u remaining=%u",
+	TP_printk("task:%d@%d total=%u remaining=%u",
 		__entry->task_id, __entry->client_id,
 		__entry->total, __entry->remaining
 	)
@@ -1026,8 +1026,8 @@ TRACE_EVENT(xprt_transmit,
 	TP_ARGS(rqst, status),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(u32, xid)
 		__field(u32, seqno)
 		__field(int, status)
@@ -1043,7 +1043,7 @@ TRACE_EVENT(xprt_transmit,
 	),
 
 	TP_printk(
-		"task:%u@%u xid=0x%08x seqno=%u status=%d",
+		"task:%d@%d xid=0x%08x seqno=%u status=%d",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->seqno, __entry->status)
 );
@@ -1056,8 +1056,8 @@ TRACE_EVENT(xprt_retransmit,
 	TP_ARGS(rqst),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(u32, xid)
 		__field(int, ntrans)
 		__field(int, version)
@@ -1083,7 +1083,7 @@ TRACE_EVENT(xprt_retransmit,
 	),
 
 	TP_printk(
-		"task:%u@%u xid=0x%08x %sv%d %s ntrans=%d timeout=%lu",
+		"task:%d@%d xid=0x%08x %sv%d %s ntrans=%d timeout=%lu",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__get_str(progname), __entry->version, __get_str(procname),
 		__entry->ntrans, __entry->timeout
@@ -1119,9 +1119,9 @@ DECLARE_EVENT_CLASS(xprt_writelock_event,
 	TP_ARGS(xprt, task),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
-		__field(unsigned int, snd_task_id)
+		__field(int, task_id)
+		__field(int, client_id)
+		__field(int, snd_task_id)
 	),
 
 	TP_fast_assign(
@@ -1137,7 +1137,7 @@ DECLARE_EVENT_CLASS(xprt_writelock_event,
 					xprt->snd_task->tk_pid : -1;
 	),
 
-	TP_printk("task:%u@%u snd_task:%u",
+	TP_printk("task:%d@%d snd_task:%d",
 			__entry->task_id, __entry->client_id,
 			__entry->snd_task_id)
 );
@@ -1161,9 +1161,9 @@ DECLARE_EVENT_CLASS(xprt_cong_event,
 	TP_ARGS(xprt, task),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
-		__field(unsigned int, snd_task_id)
+		__field(int, task_id)
+		__field(int, client_id)
+		__field(int, snd_task_id)
 		__field(unsigned long, cong)
 		__field(unsigned long, cwnd)
 		__field(bool, wait)
@@ -1185,7 +1185,7 @@ DECLARE_EVENT_CLASS(xprt_cong_event,
 		__entry->wait = test_bit(XPRT_CWND_WAIT, &xprt->state);
 	),
 
-	TP_printk("task:%u@%u snd_task:%u cong=%lu cwnd=%lu%s",
+	TP_printk("task:%d@%d snd_task:%d cong=%lu cwnd=%lu%s",
 			__entry->task_id, __entry->client_id,
 			__entry->snd_task_id, __entry->cong, __entry->cwnd,
 			__entry->wait ? " (wait)" : "")
@@ -1212,8 +1212,8 @@ TRACE_EVENT(xprt_reserve,
 	TP_ARGS(rqst),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(u32, xid)
 	),
 
@@ -1223,7 +1223,7 @@ TRACE_EVENT(xprt_reserve,
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x",
+	TP_printk("task:%d@%d xid=0x%08x",
 		__entry->task_id, __entry->client_id, __entry->xid
 	)
 );
@@ -1293,8 +1293,8 @@ TRACE_EVENT(rpcb_getport,
 	TP_ARGS(clnt, task, bind_version),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(unsigned int, program)
 		__field(unsigned int, version)
 		__field(int, protocol)
@@ -1312,7 +1312,7 @@ TRACE_EVENT(rpcb_getport,
 		__assign_str(servername, task->tk_xprt->servername);
 	),
 
-	TP_printk("task:%u@%u server=%s program=%u version=%u protocol=%d bind_version=%u",
+	TP_printk("task:%d@%d server=%s program=%u version=%u protocol=%d bind_version=%u",
 		__entry->task_id, __entry->client_id, __get_str(servername),
 		__entry->program, __entry->version, __entry->protocol,
 		__entry->bind_version
@@ -1329,8 +1329,8 @@ TRACE_EVENT(rpcb_setport,
 	TP_ARGS(task, status, port),
 
 	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
+		__field(int, task_id)
+		__field(int, client_id)
 		__field(int, status)
 		__field(unsigned short, port)
 	),
@@ -1342,7 +1342,7 @@ TRACE_EVENT(rpcb_setport,
 		__entry->port = port;
 	),
 
-	TP_printk("task:%u@%u status=%d port=%u",
+	TP_printk("task:%d@%d status=%d port=%u",
 		__entry->task_id, __entry->client_id,
 		__entry->status, __entry->port
 	)


