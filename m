Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBB42F4CED
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jan 2021 15:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbhAMOQk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jan 2021 09:16:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:44152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbhAMOQj (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 13 Jan 2021 09:16:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A764233FD
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jan 2021 14:15:58 +0000 (UTC)
Subject: [PATCH v1] SUNRPC: Move the svc_xdr_recvfrom tracepoint again
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 13 Jan 2021 09:15:56 -0500
Message-ID: <161054735612.4381.18219085679623183363.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit 156708adf2d9 ("SUNRPC: Move the svc_xdr_recvfrom()
tracepoint") tried to capture the correct XID in the trace record,
but this line in svc_recv:

	rqstp->rq_xid = svc_getu32(&rqstp->rq_arg.head[0]);

alters the size of rq_arg.head[0].iov_len. The tracepoint records
the correct XID but an incorrect value for the length of the
xdr_buf's head.

To keep the trace callsites simple, I've created two trace classes.
One assumes the xdr_buf contains a full RPC message, and the XID
can be extracted from it. The other assumes the contents of the
xdr_buf are arbitrary, and the xid will be provided by the caller.

Currently there is only one user of each class, but I expect we will
need a few more tracepoints using each class as time goes on.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   59 +++++++++++++++++++++++++++++++++++++----
 net/sunrpc/svc_xprt.c         |    4 +--
 2 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 58994e013022..6f89c27265f5 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1424,13 +1424,61 @@ TRACE_EVENT(rpcb_unregister,
 	)
 );
 
+/* Record an xdr_buf containing a fully-formed RPC message */
+DECLARE_EVENT_CLASS(svc_xdr_msg_class,
+	TP_PROTO(
+		const struct xdr_buf *xdr
+	),
+
+	TP_ARGS(xdr),
+
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(const void *, head_base)
+		__field(size_t, head_len)
+		__field(const void *, tail_base)
+		__field(size_t, tail_len)
+		__field(unsigned int, page_len)
+		__field(unsigned int, msg_len)
+	),
+
+	TP_fast_assign(
+		__be32 *p = (__be32 *)xdr->head[0].iov_base;
+
+		__entry->xid = be32_to_cpu(*p);
+		__entry->head_base = p;
+		__entry->head_len = xdr->head[0].iov_len;
+		__entry->tail_base = xdr->tail[0].iov_base;
+		__entry->tail_len = xdr->tail[0].iov_len;
+		__entry->page_len = xdr->page_len;
+		__entry->msg_len = xdr->len;
+	),
+
+	TP_printk("xid=0x%08x head=[%p,%zu] page=%u tail=[%p,%zu] len=%u",
+		__entry->xid,
+		__entry->head_base, __entry->head_len, __entry->page_len,
+		__entry->tail_base, __entry->tail_len, __entry->msg_len
+	)
+);
+
+#define DEFINE_SVCXDRMSG_EVENT(name)					\
+		DEFINE_EVENT(svc_xdr_msg_class,				\
+				svc_xdr_##name,				\
+				TP_PROTO(				\
+					const struct xdr_buf *xdr	\
+				),					\
+				TP_ARGS(xdr))
+
+DEFINE_SVCXDRMSG_EVENT(recvfrom);
+
+/* Record an xdr_buf containing arbitrary data, tagged with an XID */
 DECLARE_EVENT_CLASS(svc_xdr_buf_class,
 	TP_PROTO(
-		const struct svc_rqst *rqst,
+		__be32 xid,
 		const struct xdr_buf *xdr
 	),
 
-	TP_ARGS(rqst, xdr),
+	TP_ARGS(xid, xdr),
 
 	TP_STRUCT__entry(
 		__field(u32, xid)
@@ -1443,7 +1491,7 @@ DECLARE_EVENT_CLASS(svc_xdr_buf_class,
 	),
 
 	TP_fast_assign(
-		__entry->xid = be32_to_cpu(rqst->rq_xid);
+		__entry->xid = be32_to_cpu(xid);
 		__entry->head_base = xdr->head[0].iov_base;
 		__entry->head_len = xdr->head[0].iov_len;
 		__entry->tail_base = xdr->tail[0].iov_base;
@@ -1463,12 +1511,11 @@ DECLARE_EVENT_CLASS(svc_xdr_buf_class,
 		DEFINE_EVENT(svc_xdr_buf_class,				\
 				svc_xdr_##name,				\
 				TP_PROTO(				\
-					const struct svc_rqst *rqst,	\
+					__be32 xid,			\
 					const struct xdr_buf *xdr	\
 				),					\
-				TP_ARGS(rqst, xdr))
+				TP_ARGS(xid, xdr))
 
-DEFINE_SVCXDRBUF_EVENT(recvfrom);
 DEFINE_SVCXDRBUF_EVENT(sendto);
 
 /*
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 5fb9164aa690..dcc50ae54550 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -857,6 +857,7 @@ int svc_recv(struct svc_rqst *rqstp, long timeout)
 	err = -EAGAIN;
 	if (len <= 0)
 		goto out_release;
+	trace_svc_xdr_recvfrom(&rqstp->rq_arg);
 
 	clear_bit(XPT_OLD, &xprt->xpt_flags);
 
@@ -866,7 +867,6 @@ int svc_recv(struct svc_rqst *rqstp, long timeout)
 
 	if (serv->sv_stats)
 		serv->sv_stats->netcnt++;
-	trace_svc_xdr_recvfrom(rqstp, &rqstp->rq_arg);
 	return len;
 out_release:
 	rqstp->rq_res.len = 0;
@@ -904,7 +904,7 @@ int svc_send(struct svc_rqst *rqstp)
 	xb->len = xb->head[0].iov_len +
 		xb->page_len +
 		xb->tail[0].iov_len;
-	trace_svc_xdr_sendto(rqstp, xb);
+	trace_svc_xdr_sendto(rqstp->rq_xid, xb);
 	trace_svc_stats_latency(rqstp);
 
 	len = xprt->xpt_ops->xpo_sendto(rqstp);


