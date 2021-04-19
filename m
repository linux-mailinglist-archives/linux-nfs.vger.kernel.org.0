Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB06E364990
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Apr 2021 20:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240595AbhDSSEV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Apr 2021 14:04:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240024AbhDSSEV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Apr 2021 14:04:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5AFFA61107;
        Mon, 19 Apr 2021 18:03:51 +0000 (UTC)
Subject: [PATCH v3 21/26] xprtrdma: Remove the RPC/RDMA QP event handler
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Apr 2021 14:03:50 -0400
Message-ID: <161885543057.38598.9405758492183834010.stgit@manet.1015granger.net>
In-Reply-To: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
References: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: The handler only recorded a trace event. If indeed no
action is needed by the RPC/RDMA consumer, then the event can be
ignored.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h |   32 --------------------------------
 net/sunrpc/xprtrdma/verbs.c    |   18 ------------------
 2 files changed, 50 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index e38b8e33be2d..ef6166b840e7 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -577,38 +577,6 @@ TRACE_EVENT(xprtrdma_op_set_cto,
 	)
 );
 
-TRACE_EVENT(xprtrdma_qp_event,
-	TP_PROTO(
-		const struct rpcrdma_ep *ep,
-		const struct ib_event *event
-	),
-
-	TP_ARGS(ep, event),
-
-	TP_STRUCT__entry(
-		__field(unsigned long, event)
-		__string(name, event->device->name)
-		__array(unsigned char, srcaddr, sizeof(struct sockaddr_in6))
-		__array(unsigned char, dstaddr, sizeof(struct sockaddr_in6))
-	),
-
-	TP_fast_assign(
-		const struct rdma_cm_id *id = ep->re_id;
-
-		__entry->event = event->event;
-		__assign_str(name, event->device->name);
-		memcpy(__entry->srcaddr, &id->route.addr.src_addr,
-		       sizeof(struct sockaddr_in6));
-		memcpy(__entry->dstaddr, &id->route.addr.dst_addr,
-		       sizeof(struct sockaddr_in6));
-	),
-
-	TP_printk("%pISpc -> %pISpc device=%s %s (%lu)",
-		__entry->srcaddr, __entry->dstaddr, __get_str(name),
-		rdma_show_ib_event(__entry->event), __entry->event
-	)
-);
-
 /**
  ** Call events
  **/
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 55c45cad2c8a..0aba8273b23e 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -120,22 +120,6 @@ static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
 	rpcrdma_ep_put(ep);
 }
 
-/**
- * rpcrdma_qp_event_handler - Handle one QP event (error notification)
- * @event: details of the event
- * @context: ep that owns QP where event occurred
- *
- * Called from the RDMA provider (device driver) possibly in an interrupt
- * context. The QP is always destroyed before the ID, so the ID will be
- * reliably available when this handler is invoked.
- */
-static void rpcrdma_qp_event_handler(struct ib_event *event, void *context)
-{
-	struct rpcrdma_ep *ep = context;
-
-	trace_xprtrdma_qp_event(ep, event);
-}
-
 /* Ensure xprt_force_disconnect() is invoked exactly once when a
  * connection is closed or lost. (The important thing is it needs
  * to be invoked "at least" once).
@@ -431,8 +415,6 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 
 	r_xprt->rx_buf.rb_max_requests = cpu_to_be32(ep->re_max_requests);
 
-	ep->re_attr.event_handler = rpcrdma_qp_event_handler;
-	ep->re_attr.qp_context = ep;
 	ep->re_attr.srq = NULL;
 	ep->re_attr.cap.max_inline_data = 0;
 	ep->re_attr.sq_sig_type = IB_SIGNAL_REQ_WR;


