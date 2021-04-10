Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C574C35AFB5
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Apr 2021 20:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbhDJSwX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 10 Apr 2021 14:52:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234903AbhDJSwW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 10 Apr 2021 14:52:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E73E6113A;
        Sat, 10 Apr 2021 18:52:07 +0000 (UTC)
Subject: [PATCH v1 3/4] xprtrdma: Don't display r_xprt memory addresses in
 tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 10 Apr 2021 14:52:06 -0400
Message-ID: <161808072658.21449.13205367185606177955.stgit@manet.1015granger.net>
In-Reply-To: <161808067409.21449.15778528150201556096.stgit@manet.1015granger.net>
References: <161808067409.21449.15778528150201556096.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The remote peer's IP address is sufficient, and does not expose
details of the kernel's memory layout.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h |   51 +++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 32 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 3e6e4c69b533..e38b8e33be2d 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -190,19 +190,17 @@ DECLARE_EVENT_CLASS(xprtrdma_rxprt,
 	TP_ARGS(r_xprt),
 
 	TP_STRUCT__entry(
-		__field(const void *, r_xprt)
 		__string(addr, rpcrdma_addrstr(r_xprt))
 		__string(port, rpcrdma_portstr(r_xprt))
 	),
 
 	TP_fast_assign(
-		__entry->r_xprt = r_xprt;
 		__assign_str(addr, rpcrdma_addrstr(r_xprt));
 		__assign_str(port, rpcrdma_portstr(r_xprt));
 	),
 
-	TP_printk("peer=[%s]:%s r_xprt=%p",
-		__get_str(addr), __get_str(port), __entry->r_xprt
+	TP_printk("peer=[%s]:%s",
+		__get_str(addr), __get_str(port)
 	)
 );
 
@@ -222,7 +220,6 @@ DECLARE_EVENT_CLASS(xprtrdma_connect_class,
 	TP_ARGS(r_xprt, rc),
 
 	TP_STRUCT__entry(
-		__field(const void *, r_xprt)
 		__field(int, rc)
 		__field(int, connect_status)
 		__string(addr, rpcrdma_addrstr(r_xprt))
@@ -230,15 +227,14 @@ DECLARE_EVENT_CLASS(xprtrdma_connect_class,
 	),
 
 	TP_fast_assign(
-		__entry->r_xprt = r_xprt;
 		__entry->rc = rc;
 		__entry->connect_status = r_xprt->rx_ep->re_connect_status;
 		__assign_str(addr, rpcrdma_addrstr(r_xprt));
 		__assign_str(port, rpcrdma_portstr(r_xprt));
 	),
 
-	TP_printk("peer=[%s]:%s r_xprt=%p: rc=%d connection status=%d",
-		__get_str(addr), __get_str(port), __entry->r_xprt,
+	TP_printk("peer=[%s]:%s rc=%d connection status=%d",
+		__get_str(addr), __get_str(port),
 		__entry->rc, __entry->connect_status
 	)
 );
@@ -535,22 +531,19 @@ TRACE_EVENT(xprtrdma_op_connect,
 	TP_ARGS(r_xprt, delay),
 
 	TP_STRUCT__entry(
-		__field(const void *, r_xprt)
 		__field(unsigned long, delay)
 		__string(addr, rpcrdma_addrstr(r_xprt))
 		__string(port, rpcrdma_portstr(r_xprt))
 	),
 
 	TP_fast_assign(
-		__entry->r_xprt = r_xprt;
 		__entry->delay = delay;
 		__assign_str(addr, rpcrdma_addrstr(r_xprt));
 		__assign_str(port, rpcrdma_portstr(r_xprt));
 	),
 
-	TP_printk("peer=[%s]:%s r_xprt=%p delay=%lu",
-		__get_str(addr), __get_str(port), __entry->r_xprt,
-		__entry->delay
+	TP_printk("peer=[%s]:%s delay=%lu",
+		__get_str(addr), __get_str(port), __entry->delay
 	)
 );
 
@@ -565,7 +558,6 @@ TRACE_EVENT(xprtrdma_op_set_cto,
 	TP_ARGS(r_xprt, connect, reconnect),
 
 	TP_STRUCT__entry(
-		__field(const void *, r_xprt)
 		__field(unsigned long, connect)
 		__field(unsigned long, reconnect)
 		__string(addr, rpcrdma_addrstr(r_xprt))
@@ -573,15 +565,14 @@ TRACE_EVENT(xprtrdma_op_set_cto,
 	),
 
 	TP_fast_assign(
-		__entry->r_xprt = r_xprt;
 		__entry->connect = connect;
 		__entry->reconnect = reconnect;
 		__assign_str(addr, rpcrdma_addrstr(r_xprt));
 		__assign_str(port, rpcrdma_portstr(r_xprt));
 	),
 
-	TP_printk("peer=[%s]:%s r_xprt=%p: connect=%lu reconnect=%lu",
-		__get_str(addr), __get_str(port), __entry->r_xprt,
+	TP_printk("peer=[%s]:%s connect=%lu reconnect=%lu",
+		__get_str(addr), __get_str(port),
 		__entry->connect / HZ, __entry->reconnect / HZ
 	)
 );
@@ -631,22 +622,19 @@ TRACE_EVENT(xprtrdma_createmrs,
 	TP_ARGS(r_xprt, count),
 
 	TP_STRUCT__entry(
-		__field(const void *, r_xprt)
 		__string(addr, rpcrdma_addrstr(r_xprt))
 		__string(port, rpcrdma_portstr(r_xprt))
 		__field(unsigned int, count)
 	),
 
 	TP_fast_assign(
-		__entry->r_xprt = r_xprt;
 		__entry->count = count;
 		__assign_str(addr, rpcrdma_addrstr(r_xprt));
 		__assign_str(port, rpcrdma_portstr(r_xprt));
 	),
 
-	TP_printk("peer=[%s]:%s r_xprt=%p: created %u MRs",
-		__get_str(addr), __get_str(port), __entry->r_xprt,
-		__entry->count
+	TP_printk("peer=[%s]:%s created %u MRs",
+		__get_str(addr), __get_str(port), __entry->count
 	)
 );
 
@@ -869,7 +857,7 @@ TRACE_EVENT(xprtrdma_post_recvs,
 	TP_ARGS(r_xprt, count, status),
 
 	TP_STRUCT__entry(
-		__field(const void *, r_xprt)
+		__field(u32, cq_id)
 		__field(unsigned int, count)
 		__field(int, status)
 		__field(int, posted)
@@ -878,16 +866,18 @@ TRACE_EVENT(xprtrdma_post_recvs,
 	),
 
 	TP_fast_assign(
-		__entry->r_xprt = r_xprt;
+		const struct rpcrdma_ep *ep = r_xprt->rx_ep;
+
+		__entry->cq_id = ep->re_attr.recv_cq->res.id;
 		__entry->count = count;
 		__entry->status = status;
-		__entry->posted = r_xprt->rx_ep->re_receive_count;
+		__entry->posted = ep->re_receive_count;
 		__assign_str(addr, rpcrdma_addrstr(r_xprt));
 		__assign_str(port, rpcrdma_portstr(r_xprt));
 	),
 
-	TP_printk("peer=[%s]:%s r_xprt=%p: %u new recvs, %d active (rc %d)",
-		__get_str(addr), __get_str(port), __entry->r_xprt,
+	TP_printk("peer=[%s]:%s cq.id=%d %u new recvs, %d active (rc %d)",
+		__get_str(addr), __get_str(port), __entry->cq_id,
 		__entry->count, __entry->posted, __entry->status
 	)
 );
@@ -1289,22 +1279,19 @@ TRACE_EVENT(xprtrdma_cb_setup,
 	TP_ARGS(r_xprt, reqs),
 
 	TP_STRUCT__entry(
-		__field(const void *, r_xprt)
 		__field(unsigned int, reqs)
 		__string(addr, rpcrdma_addrstr(r_xprt))
 		__string(port, rpcrdma_portstr(r_xprt))
 	),
 
 	TP_fast_assign(
-		__entry->r_xprt = r_xprt;
 		__entry->reqs = reqs;
 		__assign_str(addr, rpcrdma_addrstr(r_xprt));
 		__assign_str(port, rpcrdma_portstr(r_xprt));
 	),
 
-	TP_printk("peer=[%s]:%s r_xprt=%p: %u reqs",
-		__get_str(addr), __get_str(port),
-		__entry->r_xprt, __entry->reqs
+	TP_printk("peer=[%s]:%s %u reqs",
+		__get_str(addr), __get_str(port), __entry->reqs
 	)
 );
 


