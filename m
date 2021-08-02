Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159453DDF7F
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Aug 2021 20:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhHBSol (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Aug 2021 14:44:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhHBSol (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 2 Aug 2021 14:44:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EB6B60EC0;
        Mon,  2 Aug 2021 18:44:30 +0000 (UTC)
Subject: [PATCH v1 3/5] xprtrdma: Add xprtrdma_post_recvs_err() tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 02 Aug 2021 14:44:30 -0400
Message-ID: <162792987034.3902.11838917235968655780.stgit@manet.1015granger.net>
In-Reply-To: <162792979429.3902.11831790821518477892.stgit@manet.1015granger.net>
References: <162792979429.3902.11831790821518477892.stgit@manet.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In the vast majority of cases, rc=0. Don't record that in the
post_recvs tracepoint. Instead, add a separate tracepoint that can
be left enabled all the time to capture the very rare immediate
errors returned by ib_post_recv().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h |   41 +++++++++++++++++++++++++++++++++-------
 net/sunrpc/xprtrdma/verbs.c    |    3 ++-
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index bd55908c1bef..d65a84bd040c 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -818,16 +818,14 @@ TRACE_EVENT(xprtrdma_post_recv,
 TRACE_EVENT(xprtrdma_post_recvs,
 	TP_PROTO(
 		const struct rpcrdma_xprt *r_xprt,
-		unsigned int count,
-		int status
+		unsigned int count
 	),
 
-	TP_ARGS(r_xprt, count, status),
+	TP_ARGS(r_xprt, count),
 
 	TP_STRUCT__entry(
 		__field(u32, cq_id)
 		__field(unsigned int, count)
-		__field(int, status)
 		__field(int, posted)
 		__string(addr, rpcrdma_addrstr(r_xprt))
 		__string(port, rpcrdma_portstr(r_xprt))
@@ -838,15 +836,44 @@ TRACE_EVENT(xprtrdma_post_recvs,
 
 		__entry->cq_id = ep->re_attr.recv_cq->res.id;
 		__entry->count = count;
-		__entry->status = status;
 		__entry->posted = ep->re_receive_count;
 		__assign_str(addr, rpcrdma_addrstr(r_xprt));
 		__assign_str(port, rpcrdma_portstr(r_xprt));
 	),
 
-	TP_printk("peer=[%s]:%s cq.id=%d %u new recvs, %d active (rc %d)",
+	TP_printk("peer=[%s]:%s cq.id=%d %u new recvs, %d active",
+		__get_str(addr), __get_str(port), __entry->cq_id,
+		__entry->count, __entry->posted
+	)
+);
+
+TRACE_EVENT(xprtrdma_post_recvs_err,
+	TP_PROTO(
+		const struct rpcrdma_xprt *r_xprt,
+		int status
+	),
+
+	TP_ARGS(r_xprt, status),
+
+	TP_STRUCT__entry(
+		__field(u32, cq_id)
+		__field(int, status)
+		__string(addr, rpcrdma_addrstr(r_xprt))
+		__string(port, rpcrdma_portstr(r_xprt))
+	),
+
+	TP_fast_assign(
+		const struct rpcrdma_ep *ep = r_xprt->rx_ep;
+
+		__entry->cq_id = ep->re_attr.recv_cq->res.id;
+		__entry->status = status;
+		__assign_str(addr, rpcrdma_addrstr(r_xprt));
+		__assign_str(port, rpcrdma_portstr(r_xprt));
+	),
+
+	TP_printk("peer=[%s]:%s cq.id=%d rc=%d",
 		__get_str(addr), __get_str(port), __entry->cq_id,
-		__entry->count, __entry->posted, __entry->status
+		__entry->status
 	)
 );
 
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 016f10a781b4..1e9041c022b6 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1417,6 +1417,7 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool temp)
 	rc = ib_post_recv(ep->re_id->qp, wr,
 			  (const struct ib_recv_wr **)&bad_wr);
 	if (rc) {
+		trace_xprtrdma_post_recvs_err(r_xprt, rc);
 		for (wr = bad_wr; wr;) {
 			struct rpcrdma_rep *rep;
 
@@ -1430,7 +1431,7 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool temp)
 		complete(&ep->re_done);
 
 out:
-	trace_xprtrdma_post_recvs(r_xprt, count, rc);
+	trace_xprtrdma_post_recvs(r_xprt, count);
 	ep->re_receive_count += count;
 	return;
 }


