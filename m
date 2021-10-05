Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F467422ED7
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Oct 2021 19:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbhJERP5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Oct 2021 13:15:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233961AbhJERP4 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 5 Oct 2021 13:15:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4983611CA
        for <linux-nfs@vger.kernel.org>; Tue,  5 Oct 2021 17:14:05 +0000 (UTC)
Subject: [PATCH RFC 1/5] SUNRPC: Tracepoints should display tk_pid and cl_clid
 as a fixed-size field
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Oct 2021 13:14:05 -0400
Message-ID: <163345404500.524558.12071341905323113184.stgit@morisot.1015granger.net>
In-Reply-To: <163345354511.524558.1980332041837428746.stgit@morisot.1015granger.net>
References: <163345354511.524558.1980332041837428746.stgit@morisot.1015granger.net>
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

For certain special cases, RPC-related tracepoints record a -1 as
the task ID or the client ID. It's ugly for a trace event to display
4 billion in these cases.

To help keep SUNRPC tracepoints consistent, create a macro that
defines the print format specifiers for tk_pid and cl_clid. At some
point in the future we might try tk_pid with a wider range of values
than 0..64K so this makes it easier to make that change.

RPC tracepoints now look like this:

<...>-1276  [009]   149.720358: rpc_clnt_new:         client=00000005 peer=[192.168.2.55]:20049 program=nfs server=klimt.ib

<...>-1342  [004]   149.921234: rpc_xdr_recvfrom:     task:0000001a@00000005 head=[0xff1242d9ab6dc01c,144] page=0 tail=[(nil),0] len=144
<...>-1342  [004]   149.921235: xprt_release_cong:    task:0000001a@00000005 snd_task:ffffffff cong=256 cwnd=16384
<...>-1342  [004]   149.921235: xprt_put_cong:        task:0000001a@00000005 snd_task:ffffffff cong=0 cwnd=16384

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs4trace.h                 |    9 ++--
 fs/nfs/nfstrace.h                  |    6 ++-
 include/trace/events/rpcgss.h      |   18 ++++++---
 include/trace/events/rpcrdma.h     |   42 ++++++++++++--------
 include/trace/events/sunrpc.h      |   74 ++++++++++++++++++++++--------------
 include/trace/events/sunrpc_base.h |   18 +++++++++
 6 files changed, 108 insertions(+), 59 deletions(-)
 create mode 100644 include/trace/events/sunrpc_base.h

diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 7a2567aa2b86..d4f061046c09 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -9,6 +9,7 @@
 #define _TRACE_NFS4_H
 
 #include <linux/tracepoint.h>
+#include <trace/events/sunrpc_base.h>
 
 TRACE_DEFINE_ENUM(EPERM);
 TRACE_DEFINE_ENUM(ENOENT);
@@ -694,8 +695,8 @@ TRACE_EVENT(nfs4_xdr_bad_operation,
 			__entry->expected = expected;
 		),
 
-		TP_printk(
-			"task:%u@%d xid=0x%08x operation=%u, expected=%u",
+		TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+			  " xid=0x%08x operation=%u, expected=%u",
 			__entry->task_id, __entry->client_id, __entry->xid,
 			__entry->op, __entry->expected
 		)
@@ -729,8 +730,8 @@ DECLARE_EVENT_CLASS(nfs4_xdr_event,
 			__entry->error = error;
 		),
 
-		TP_printk(
-			"task:%u@%d xid=0x%08x error=%ld (%s) operation=%u",
+		TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+			  " xid=0x%08x error=%ld (%s) operation=%u",
 			__entry->task_id, __entry->client_id, __entry->xid,
 			-__entry->error, show_nfsv4_errors(__entry->error),
 			__entry->op
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 44fd016a8e65..82b51120450f 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -11,6 +11,8 @@
 #include <linux/tracepoint.h>
 #include <linux/iversion.h>
 
+#include <trace/events/sunrpc_base.h>
+
 #define nfs_show_file_type(ftype) \
 	__print_symbolic(ftype, \
 			{ DT_UNKNOWN, "UNKNOWN" }, \
@@ -1409,8 +1411,8 @@ DECLARE_EVENT_CLASS(nfs_xdr_event,
 			__assign_str(procedure, task->tk_msg.rpc_proc->p_name);
 		),
 
-		TP_printk(
-			"task:%u@%d xid=0x%08x %sv%d %s error=%ld (%s)",
+		TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+			  " xid=0x%08x %sv%d %s error=%ld (%s)",
 			__entry->task_id, __entry->client_id, __entry->xid,
 			__get_str(program), __entry->version,
 			__get_str(procedure), -__entry->error,
diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.h
index b2a2672e6632..3ba63319af3c 100644
--- a/include/trace/events/rpcgss.h
+++ b/include/trace/events/rpcgss.h
@@ -13,6 +13,8 @@
 
 #include <linux/tracepoint.h>
 
+#include <trace/events/sunrpc_base.h>
+
 /**
  ** GSS-API related trace events
  **/
@@ -99,7 +101,7 @@ DECLARE_EVENT_CLASS(rpcgss_gssapi_event,
 		__entry->maj_stat = maj_stat;
 	),
 
-	TP_printk("task:%u@%u maj_stat=%s",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " maj_stat=%s",
 		__entry->task_id, __entry->client_id,
 		__entry->maj_stat == 0 ?
 		"GSS_S_COMPLETE" : show_gss_status(__entry->maj_stat))
@@ -332,7 +334,8 @@ TRACE_EVENT(rpcgss_unwrap_failed,
 		__entry->client_id = task->tk_client->cl_clid;
 	),
 
-	TP_printk("task:%u@%u", __entry->task_id, __entry->client_id)
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER,
+		__entry->task_id, __entry->client_id)
 );
 
 TRACE_EVENT(rpcgss_bad_seqno,
@@ -358,7 +361,8 @@ TRACE_EVENT(rpcgss_bad_seqno,
 		__entry->received = received;
 	),
 
-	TP_printk("task:%u@%u expected seqno %u, received seqno %u",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " expected seqno %u, received seqno %u",
 		__entry->task_id, __entry->client_id,
 		__entry->expected, __entry->received)
 );
@@ -386,7 +390,7 @@ TRACE_EVENT(rpcgss_seqno,
 		__entry->seqno = rqst->rq_seqno;
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x seqno=%u",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " xid=0x%08x seqno=%u",
 		__entry->task_id, __entry->client_id,
 		__entry->xid, __entry->seqno)
 );
@@ -418,7 +422,8 @@ TRACE_EVENT(rpcgss_need_reencode,
 		__entry->ret = ret;
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x rq_seqno=%u seq_xmit=%u reencode %sneeded",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " xid=0x%08x rq_seqno=%u seq_xmit=%u reencode %sneeded",
 		__entry->task_id, __entry->client_id,
 		__entry->xid, __entry->seqno, __entry->seq_xmit,
 		__entry->ret ? "" : "un")
@@ -452,7 +457,8 @@ TRACE_EVENT(rpcgss_update_slack,
 		__entry->verfsize = auth->au_verfsize;
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x auth=%p rslack=%u ralign=%u verfsize=%u\n",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " xid=0x%08x auth=%p rslack=%u ralign=%u verfsize=%u\n",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->auth, __entry->rslack, __entry->ralign,
 		__entry->verfsize)
diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index afb2e394797c..7f46ef621c95 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -14,7 +14,9 @@
 #include <linux/sunrpc/rpc_rdma_cid.h>
 #include <linux/tracepoint.h>
 #include <rdma/ib_cm.h>
+
 #include <trace/events/rdma.h>
+#include <trace/events/sunrpc_base.h>
 
 /**
  ** Event classes
@@ -279,7 +281,8 @@ DECLARE_EVENT_CLASS(xprtrdma_rdch_event,
 		__entry->nsegs = nsegs;
 	),
 
-	TP_printk("task:%u@%u pos=%u %u@0x%016llx:0x%08x (%s)",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " pos=%u %u@0x%016llx:0x%08x (%s)",
 		__entry->task_id, __entry->client_id,
 		__entry->pos, __entry->length,
 		(unsigned long long)__entry->offset, __entry->handle,
@@ -326,7 +329,8 @@ DECLARE_EVENT_CLASS(xprtrdma_wrch_event,
 		__entry->nsegs = nsegs;
 	),
 
-	TP_printk("task:%u@%u %u@0x%016llx:0x%08x (%s)",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " %u@0x%016llx:0x%08x (%s)",
 		__entry->task_id, __entry->client_id,
 		__entry->length, (unsigned long long)__entry->offset,
 		__entry->handle,
@@ -393,7 +397,8 @@ DECLARE_EVENT_CLASS(xprtrdma_mr_class,
 		__entry->dir    = mr->mr_dir;
 	),
 
-	TP_printk("task:%u@%u mr.id=%u nents=%d %u@0x%016llx:0x%08x (%s)",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " mr.id=%u nents=%d %u@0x%016llx:0x%08x (%s)",
 		__entry->task_id, __entry->client_id,
 		__entry->mr_id, __entry->nents, __entry->length,
 		(unsigned long long)__entry->offset, __entry->handle,
@@ -636,9 +641,9 @@ TRACE_EVENT(xprtrdma_nomrs_err,
 		__assign_str(port, rpcrdma_portstr(r_xprt));
 	),
 
-	TP_printk("peer=[%s]:%s task:%u@%u",
-		__get_str(addr), __get_str(port),
-		__entry->task_id, __entry->client_id
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " peer=[%s]:%s",
+		__entry->task_id, __entry->client_id,
+		__get_str(addr), __get_str(port)
 	)
 );
 
@@ -700,7 +705,8 @@ TRACE_EVENT(xprtrdma_marshal,
 		__entry->wtype = wtype;
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x: hdr=%u xdr=%u/%u/%u %s/%s",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " xid=0x%08x hdr=%u xdr=%u/%u/%u %s/%s",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->hdrlen,
 		__entry->headlen, __entry->pagelen, __entry->taillen,
@@ -730,7 +736,7 @@ TRACE_EVENT(xprtrdma_marshal_failed,
 		__entry->ret = ret;
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x: ret=%d",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " xid=0x%08x ret=%d",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->ret
 	)
@@ -757,7 +763,7 @@ TRACE_EVENT(xprtrdma_prepsend_failed,
 		__entry->ret = ret;
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x: ret=%d",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " xid=0x%08x ret=%d",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->ret
 	)
@@ -792,7 +798,7 @@ TRACE_EVENT(xprtrdma_post_send,
 		__entry->signaled = req->rl_wr.send_flags & IB_SEND_SIGNALED;
 	),
 
-	TP_printk("task:%u@%u cq.id=%u cid=%d (%d SGE%s) %s",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " cq.id=%u cid=%d (%d SGE%s) %s",
 		__entry->task_id, __entry->client_id,
 		__entry->cq_id, __entry->completion_id,
 		__entry->num_sge, (__entry->num_sge == 1 ? "" : "s"),
@@ -827,7 +833,7 @@ TRACE_EVENT(xprtrdma_post_send_err,
 		__entry->rc = rc;
 	),
 
-	TP_printk("task:%u@%u cq.id=%u rc=%d",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " cq.id=%u rc=%d",
 		__entry->task_id, __entry->client_id,
 		__entry->cq_id, __entry->rc
 	)
@@ -939,7 +945,7 @@ TRACE_EVENT(xprtrdma_post_linv_err,
 		__entry->status = status;
 	),
 
-	TP_printk("task:%u@%u status=%d",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " status=%d",
 		__entry->task_id, __entry->client_id, __entry->status
 	)
 );
@@ -1127,7 +1133,7 @@ TRACE_EVENT(xprtrdma_reply,
 		__entry->credits = credits;
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x credits=%u",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " xid=0x%08x credits=%u",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->credits
 	)
@@ -1163,7 +1169,7 @@ TRACE_EVENT(xprtrdma_err_vers,
 		__entry->max = be32_to_cpup(max);
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x versions=[%u, %u]",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " xid=0x%08x versions=[%u, %u]",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->min, __entry->max
 	)
@@ -1188,7 +1194,7 @@ TRACE_EVENT(xprtrdma_err_chunk,
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " xid=0x%08x",
 		__entry->task_id, __entry->client_id, __entry->xid
 	)
 );
@@ -1214,7 +1220,7 @@ TRACE_EVENT(xprtrdma_err_unrecognized,
 		__entry->procedure = be32_to_cpup(procedure);
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x procedure=%u",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " xid=0x%08x procedure=%u",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->procedure
 	)
@@ -1246,7 +1252,7 @@ TRACE_EVENT(xprtrdma_fixup,
 		__entry->taillen = rqst->rq_rcv_buf.tail[0].iov_len;
 	),
 
-	TP_printk("task:%u@%u fixup=%lu xdr=%zu/%u/%zu",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " fixup=%lu xdr=%zu/%u/%zu",
 		__entry->task_id, __entry->client_id, __entry->fixup,
 		__entry->headlen, __entry->pagelen, __entry->taillen
 	)
@@ -1296,7 +1302,7 @@ TRACE_EVENT(xprtrdma_mrs_zap,
 		__entry->client_id = task->tk_client->cl_clid;
 	),
 
-	TP_printk("task:%u@%u",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER,
 		__entry->task_id, __entry->client_id
 	)
 );
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 2d04eb96d418..92def7d6663e 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -14,6 +14,8 @@
 #include <linux/net.h>
 #include <linux/tracepoint.h>
 
+#include <trace/events/sunrpc_base.h>
+
 TRACE_DEFINE_ENUM(SOCK_STREAM);
 TRACE_DEFINE_ENUM(SOCK_DGRAM);
 TRACE_DEFINE_ENUM(SOCK_RAW);
@@ -78,7 +80,8 @@ DECLARE_EVENT_CLASS(rpc_xdr_buf_class,
 		__entry->msg_len = xdr->len;
 	),
 
-	TP_printk("task:%u@%u head=[%p,%zu] page=%u tail=[%p,%zu] len=%u",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " head=[%p,%zu] page=%u tail=[%p,%zu] len=%u",
 		__entry->task_id, __entry->client_id,
 		__entry->head_base, __entry->head_len, __entry->page_len,
 		__entry->tail_base, __entry->tail_len, __entry->msg_len
@@ -114,7 +117,7 @@ DECLARE_EVENT_CLASS(rpc_clnt_class,
 		__entry->client_id = clnt->cl_clid;
 	),
 
-	TP_printk("clid=%u", __entry->client_id)
+	TP_printk("client=" SUNRPC_TRACE_CLID_SPECIFIER, __entry->client_id)
 );
 
 #define DEFINE_RPC_CLNT_EVENT(name)					\
@@ -158,7 +161,8 @@ TRACE_EVENT(rpc_clnt_new,
 		__assign_str(server, server);
 	),
 
-	TP_printk("client=%u peer=[%s]:%s program=%s server=%s",
+	TP_printk("client=" SUNRPC_TRACE_CLID_SPECIFIER
+		  " peer=[%s]:%s program=%s server=%s",
 		__entry->client_id, __get_str(addr), __get_str(port),
 		__get_str(program), __get_str(server))
 );
@@ -206,7 +210,8 @@ TRACE_EVENT(rpc_clnt_clone_err,
 		__entry->error = error;
 	),
 
-	TP_printk("client=%u error=%d", __entry->client_id, __entry->error)
+	TP_printk("client=" SUNRPC_TRACE_CLID_SPECIFIER " error=%d",
+		__entry->client_id, __entry->error)
 );
 
 
@@ -248,7 +253,7 @@ DECLARE_EVENT_CLASS(rpc_task_status,
 		__entry->status = task->tk_status;
 	),
 
-	TP_printk("task:%u@%u status=%d",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " status=%d",
 		__entry->task_id, __entry->client_id,
 		__entry->status)
 );
@@ -288,7 +293,7 @@ TRACE_EVENT(rpc_request,
 		__assign_str(procname, rpc_proc_name(task));
 	),
 
-	TP_printk("task:%u@%u %sv%d %s (%ssync)",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " %sv%d %s (%ssync)",
 		__entry->task_id, __entry->client_id,
 		__get_str(progname), __entry->version,
 		__get_str(procname), __entry->async ? "a": ""
@@ -348,7 +353,8 @@ DECLARE_EVENT_CLASS(rpc_task_running,
 		__entry->flags = task->tk_flags;
 		),
 
-	TP_printk("task:%u@%d flags=%s runstate=%s status=%d action=%ps",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " flags=%s runstate=%s status=%d action=%ps",
 		__entry->task_id, __entry->client_id,
 		rpc_show_task_flags(__entry->flags),
 		rpc_show_runstate(__entry->runstate),
@@ -400,7 +406,8 @@ DECLARE_EVENT_CLASS(rpc_task_queued,
 		__assign_str(q_name, rpc_qname(q));
 		),
 
-	TP_printk("task:%u@%d flags=%s runstate=%s status=%d timeout=%lu queue=%s",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " flags=%s runstate=%s status=%d timeout=%lu queue=%s",
 		__entry->task_id, __entry->client_id,
 		rpc_show_task_flags(__entry->flags),
 		rpc_show_runstate(__entry->runstate),
@@ -436,7 +443,7 @@ DECLARE_EVENT_CLASS(rpc_failure,
 		__entry->client_id = task->tk_client->cl_clid;
 	),
 
-	TP_printk("task:%u@%u",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER,
 		__entry->task_id, __entry->client_id)
 );
 
@@ -478,7 +485,8 @@ DECLARE_EVENT_CLASS(rpc_reply_event,
 		__assign_str(servername, task->tk_xprt->servername);
 	),
 
-	TP_printk("task:%u@%d server=%s xid=0x%08x %sv%d %s",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " server=%s xid=0x%08x %sv%d %s",
 		__entry->task_id, __entry->client_id, __get_str(servername),
 		__entry->xid, __get_str(progname), __entry->version,
 		__get_str(procname))
@@ -538,7 +546,8 @@ TRACE_EVENT(rpc_buf_alloc,
 		__entry->status = status;
 	),
 
-	TP_printk("task:%u@%u callsize=%zu recvsize=%zu status=%d",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " callsize=%zu recvsize=%zu status=%d",
 		__entry->task_id, __entry->client_id,
 		__entry->callsize, __entry->recvsize, __entry->status
 	)
@@ -567,7 +576,8 @@ TRACE_EVENT(rpc_call_rpcerror,
 		__entry->rpc_status = rpc_status;
 	),
 
-	TP_printk("task:%u@%u tk_status=%d rpc_status=%d",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " tk_status=%d rpc_status=%d",
 		__entry->task_id, __entry->client_id,
 		__entry->tk_status, __entry->rpc_status)
 );
@@ -607,7 +617,8 @@ TRACE_EVENT(rpc_stats_latency,
 		__entry->execute = ktime_to_us(execute);
 	),
 
-	TP_printk("task:%u@%d xid=0x%08x %sv%d %s backlog=%lu rtt=%lu execute=%lu",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " xid=0x%08x %sv%d %s backlog=%lu rtt=%lu execute=%lu",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__get_str(progname), __entry->version, __get_str(procname),
 		__entry->backlog, __entry->rtt, __entry->execute)
@@ -651,8 +662,8 @@ TRACE_EVENT(rpc_xdr_overflow,
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
@@ -668,8 +679,8 @@ TRACE_EVENT(rpc_xdr_overflow,
 		__entry->len = xdr->buf->len;
 	),
 
-	TP_printk(
-		"task:%u@%u %sv%d %s requested=%zu p=%p end=%p xdr=[%p,%zu]/%u/[%p,%zu]/%u\n",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " %sv%d %s requested=%zu p=%p end=%p xdr=[%p,%zu]/%u/[%p,%zu]/%u\n",
 		__entry->task_id, __entry->client_id,
 		__get_str(progname), __entry->version, __get_str(procedure),
 		__entry->requested, __entry->p, __entry->end,
@@ -727,8 +738,8 @@ TRACE_EVENT(rpc_xdr_alignment,
 		__entry->len = xdr->buf->len;
 	),
 
-	TP_printk(
-		"task:%u@%u %sv%d %s offset=%zu copied=%u xdr=[%p,%zu]/%u/[%p,%zu]/%u\n",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " %sv%d %s offset=%zu copied=%u xdr=[%p,%zu]/%u/[%p,%zu]/%u\n",
 		__entry->task_id, __entry->client_id,
 		__get_str(progname), __entry->version, __get_str(procedure),
 		__entry->offset, __entry->copied,
@@ -917,7 +928,8 @@ TRACE_EVENT(rpc_socket_nospace,
 		__entry->remaining = rqst->rq_slen - transport->xmit.offset;
 	),
 
-	TP_printk("task:%u@%u total=%u remaining=%u",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " total=%u remaining=%u",
 		__entry->task_id, __entry->client_id,
 		__entry->total, __entry->remaining
 	)
@@ -1042,8 +1054,8 @@ TRACE_EVENT(xprt_transmit,
 		__entry->status = status;
 	),
 
-	TP_printk(
-		"task:%u@%u xid=0x%08x seqno=%u status=%d",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " xid=0x%08x seqno=%u status=%d",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__entry->seqno, __entry->status)
 );
@@ -1082,8 +1094,8 @@ TRACE_EVENT(xprt_retransmit,
 		__assign_str(procname, rpc_proc_name(task));
 	),
 
-	TP_printk(
-		"task:%u@%u xid=0x%08x %sv%d %s ntrans=%d timeout=%lu",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " xid=0x%08x %sv%d %s ntrans=%d timeout=%lu",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__get_str(progname), __entry->version, __get_str(procname),
 		__entry->ntrans, __entry->timeout
@@ -1137,7 +1149,8 @@ DECLARE_EVENT_CLASS(xprt_writelock_event,
 					xprt->snd_task->tk_pid : -1;
 	),
 
-	TP_printk("task:%u@%u snd_task:%u",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " snd_task:" SUNRPC_TRACE_PID_SPECIFIER,
 			__entry->task_id, __entry->client_id,
 			__entry->snd_task_id)
 );
@@ -1185,7 +1198,9 @@ DECLARE_EVENT_CLASS(xprt_cong_event,
 		__entry->wait = test_bit(XPRT_CWND_WAIT, &xprt->state);
 	),
 
-	TP_printk("task:%u@%u snd_task:%u cong=%lu cwnd=%lu%s",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " snd_task:" SUNRPC_TRACE_PID_SPECIFIER
+		  " cong=%lu cwnd=%lu%s",
 			__entry->task_id, __entry->client_id,
 			__entry->snd_task_id, __entry->cong, __entry->cwnd,
 			__entry->wait ? " (wait)" : "")
@@ -1223,7 +1238,7 @@ TRACE_EVENT(xprt_reserve,
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " xid=0x%08x",
 		__entry->task_id, __entry->client_id, __entry->xid
 	)
 );
@@ -1312,7 +1327,8 @@ TRACE_EVENT(rpcb_getport,
 		__assign_str(servername, task->tk_xprt->servername);
 	),
 
-	TP_printk("task:%u@%u server=%s program=%u version=%u protocol=%d bind_version=%u",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		  " server=%s program=%u version=%u protocol=%d bind_version=%u",
 		__entry->task_id, __entry->client_id, __get_str(servername),
 		__entry->program, __entry->version, __entry->protocol,
 		__entry->bind_version
@@ -1342,7 +1358,7 @@ TRACE_EVENT(rpcb_setport,
 		__entry->port = port;
 	),
 
-	TP_printk("task:%u@%u status=%d port=%u",
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER " status=%d port=%u",
 		__entry->task_id, __entry->client_id,
 		__entry->status, __entry->port
 	)
diff --git a/include/trace/events/sunrpc_base.h b/include/trace/events/sunrpc_base.h
new file mode 100644
index 000000000000..588557d07ea8
--- /dev/null
+++ b/include/trace/events/sunrpc_base.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Oracle and/or its affiliates.
+ *
+ * Common types and format specifiers for sunrpc.
+ */
+
+#if !defined(_TRACE_SUNRPC_BASE_H)
+#define _TRACE_SUNRPC_BASE_H
+
+#include <linux/tracepoint.h>
+
+#define SUNRPC_TRACE_PID_SPECIFIER	"%08x"
+#define SUNRPC_TRACE_CLID_SPECIFIER	"%08x"
+#define SUNRPC_TRACE_TASK_SPECIFIER \
+	"task:" SUNRPC_TRACE_PID_SPECIFIER "@" SUNRPC_TRACE_CLID_SPECIFIER
+
+#endif /* _TRACE_SUNRPC_BASE_H */


