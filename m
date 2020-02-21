Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30B811689C0
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2020 23:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgBUWBK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Feb 2020 17:01:10 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42582 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbgBUWBK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Feb 2020 17:01:10 -0500
Received: by mail-yw1-f65.google.com with SMTP id b81so1786027ywe.9;
        Fri, 21 Feb 2020 14:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=M/EsiuOxE3xClDkGM6B/JMuVZG1jdGZ4ZOccG4Cqrl0=;
        b=bExoxoO9I66la7OPIsRpTwWy9oMqEknUr9b4Bxgs19O43DlP1tJNWLt6u2rQ4sz6YI
         ULSk0foJwmEslCd+JRKL60AszxoxtO6YvCo3tiKsc5mLjccJa+quI7lkVpdORuJJZ0Wg
         dsT4sE7moi7xiNbaoo7TiMKd2eFFm6hmgNTYasopcY5kdss5mzNPPvQqoa2jMPj57Mjo
         1eWK/5F2Mng6KrOA8H6/dZRpf95iG7Mdo5C9eYMYQsE7BwPvts828ymhXVTh8/BK7pYO
         ubProGibBZoEj1yTHNHb78U3dXHfmXeCscOz/LLYO51iUSSnREmVhGB6X7a4SYnD6TQw
         4vcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=M/EsiuOxE3xClDkGM6B/JMuVZG1jdGZ4ZOccG4Cqrl0=;
        b=diwlrbPqmNIRAB1lyciH2Q6qjwJGlTVs+uENL8fQDstIYdILyTPjdDsFsewNwCwdGU
         MWeYACoGgO+Y4xnOQHRXQtg2EPHthfZvXwWi9URCNpy2LziJ5vfntPDs3d3uBsBK5bLX
         P+NpwzGlfxRS41VBRjc6KlpJj/sD+24GB0rheeTis39JCFIXrN0idl2AmgxRiMH/p2eQ
         gNcT/b5nifl3UBvBaAOaq1VDhqwp7JV2yR4kpLZgoRg4aCu/gMkyIUZtPr988/sCFXgQ
         m4z5rInf5aULlQYwdkAxHxUX/CZ/XAV+A7Z9BxO3ZdA+ixYSezs2YCD/oRjpx3XsmXbY
         pWQg==
X-Gm-Message-State: APjAAAWlZCKJ5iCQ/PDVgma01mnLlKihy7ILt3YiXPHD9SBrUUrmiups
        DdyGRWtFg2hwd3oBHnCEq5WETiQc
X-Google-Smtp-Source: APXvYqzMHB9japPklIHxjJYkxnrJRSvAGhZgNfLT8ZBUOGUgnKfOJtOcSOnlhLurrfm5w3md0xNNFg==
X-Received: by 2002:a81:6d4e:: with SMTP id i75mr33334993ywc.487.1582322467318;
        Fri, 21 Feb 2020 14:01:07 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id x184sm1795600ywg.4.2020.02.21.14.01.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2020 14:01:06 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 01LM15eY019025;
        Fri, 21 Feb 2020 22:01:05 GMT
Subject: [PATCH v1 11/11] xprtrdma: kmalloc rpcrdma_ep separate from
 rpcrdma_xprt
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 21 Feb 2020 17:01:05 -0500
Message-ID: <20200221220105.2072.88651.stgit@manet.1015granger.net>
In-Reply-To: <20200221214906.2072.32572.stgit@manet.1015granger.net>
References: <20200221214906.2072.32572.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Change the rpcrdma_xprt_disconnect() function so that it no longer
waits for the DISCONNECTED event.  This prevents blocking if the
remote is unresponsive.

In rpcrdma_xprt_disconnect(), the transport's rpcrdma_ep is
detached. Upon return from rpcrdma_xprt_disconnect(), the transport
(r_xprt) is ready immediately for a new connection.

The RDMA_CM_DEVICE_REMOVAL and RDMA_CM_DISCONNECTED events are now
handled almost identically.

However, because the lifetimes of rpcrdma_xprt structures and
rpcrdma_ep structures are now independent, creating an rpcrdma_ep
needs to take a module ref count. The ep now owns most of the
hardware resources for a transport.

Also, a kref is needed to ensure that rpcrdma_ep sticks around
long enough for the cm_event_handler to finish.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h    |   63 ------------
 net/sunrpc/xprtrdma/backchannel.c |    4 -
 net/sunrpc/xprtrdma/frwr_ops.c    |   12 +-
 net/sunrpc/xprtrdma/rpc_rdma.c    |   17 ++-
 net/sunrpc/xprtrdma/transport.c   |   37 +++----
 net/sunrpc/xprtrdma/verbs.c       |  194 ++++++++++++++++++++-----------------
 net/sunrpc/xprtrdma/xprt_rdma.h   |    7 +
 7 files changed, 143 insertions(+), 191 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index a6d3a2122e9b..0c980b1224ef 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -104,7 +104,7 @@
 	TP_fast_assign(
 		__entry->r_xprt = r_xprt;
 		__entry->rc = rc;
-		__entry->connect_status = r_xprt->rx_ep.re_connect_status;
+		__entry->connect_status = r_xprt->rx_ep->re_connect_status;
 		__assign_str(addr, rpcrdma_addrstr(r_xprt));
 		__assign_str(port, rpcrdma_portstr(r_xprt));
 	),
@@ -340,37 +340,6 @@
  ** Connection events
  **/
 
-TRACE_EVENT(xprtrdma_cm_event,
-	TP_PROTO(
-		const struct rpcrdma_xprt *r_xprt,
-		struct rdma_cm_event *event
-	),
-
-	TP_ARGS(r_xprt, event),
-
-	TP_STRUCT__entry(
-		__field(const void *, r_xprt)
-		__field(unsigned int, event)
-		__field(int, status)
-		__string(addr, rpcrdma_addrstr(r_xprt))
-		__string(port, rpcrdma_portstr(r_xprt))
-	),
-
-	TP_fast_assign(
-		__entry->r_xprt = r_xprt;
-		__entry->event = event->event;
-		__entry->status = event->status;
-		__assign_str(addr, rpcrdma_addrstr(r_xprt));
-		__assign_str(port, rpcrdma_portstr(r_xprt));
-	),
-
-	TP_printk("peer=[%s]:%s r_xprt=%p: %s (%u/%d)",
-		__get_str(addr), __get_str(port),
-		__entry->r_xprt, rdma_show_cm_event(__entry->event),
-		__entry->event, __entry->status
-	)
-);
-
 TRACE_EVENT(xprtrdma_inline_thresh,
 	TP_PROTO(
 		const struct rpcrdma_ep *ep
@@ -407,34 +376,6 @@
 	)
 );
 
-TRACE_EVENT(xprtrdma_remove,
-	TP_PROTO(
-		const struct rpcrdma_ep *ep
-	),
-
-	TP_ARGS(ep),
-
-	TP_STRUCT__entry(
-		__array(unsigned char, srcaddr, sizeof(struct sockaddr_in6))
-		__array(unsigned char, dstaddr, sizeof(struct sockaddr_in6))
-		__string(name, ep->re_id->device->name)
-	),
-
-	TP_fast_assign(
-		const struct rdma_cm_id *id = ep->re_id;
-
-		memcpy(__entry->srcaddr, &id->route.addr.src_addr,
-		       sizeof(struct sockaddr_in6));
-		memcpy(__entry->dstaddr, &id->route.addr.dst_addr,
-		       sizeof(struct sockaddr_in6));
-		__assign_str(name, id->device->name);
-	),
-
-	TP_printk("%pISpc -> %pISpc device=%s",
-		__entry->srcaddr, __entry->dstaddr, __get_str(name)
-	)
-);
-
 DEFINE_CONN_EVENT(connect);
 DEFINE_CONN_EVENT(disconnect);
 DEFINE_CONN_EVENT(flush_dct);
@@ -829,7 +770,7 @@
 		__entry->r_xprt = r_xprt;
 		__entry->count = count;
 		__entry->status = status;
-		__entry->posted = r_xprt->rx_ep.re_receive_count;
+		__entry->posted = r_xprt->rx_ep->re_receive_count;
 		__assign_str(addr, rpcrdma_addrstr(r_xprt));
 		__assign_str(port, rpcrdma_portstr(r_xprt));
 	),
diff --git a/net/sunrpc/xprtrdma/backchannel.c b/net/sunrpc/xprtrdma/backchannel.c
index 4b20102cf060..c92c1aac270a 100644
--- a/net/sunrpc/xprtrdma/backchannel.c
+++ b/net/sunrpc/xprtrdma/backchannel.c
@@ -44,7 +44,7 @@ int xprt_rdma_bc_setup(struct rpc_xprt *xprt, unsigned int reqs)
 size_t xprt_rdma_bc_maxpayload(struct rpc_xprt *xprt)
 {
 	struct rpcrdma_xprt *r_xprt = rpcx_to_rdmax(xprt);
-	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
+	struct rpcrdma_ep *ep = r_xprt->rx_ep;
 	size_t maxmsg;
 
 	maxmsg = min_t(unsigned int, ep->re_inline_send, ep->re_inline_recv);
@@ -190,7 +190,7 @@ static struct rpc_rqst *rpcrdma_bc_rqst_get(struct rpcrdma_xprt *r_xprt)
 	if (xprt->bc_alloc_count >= RPCRDMA_BACKWARD_WRS)
 		return NULL;
 
-	size = min_t(size_t, r_xprt->rx_ep.re_inline_recv, PAGE_SIZE);
+	size = min_t(size_t, r_xprt->rx_ep->re_inline_recv, PAGE_SIZE);
 	req = rpcrdma_req_create(r_xprt, size, GFP_KERNEL);
 	if (!req)
 		return NULL;
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index c48f3f2dacde..e18ab28570bc 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -74,7 +74,7 @@ static void frwr_mr_recycle(struct rpcrdma_mr *mr)
 
 	if (mr->mr_dir != DMA_NONE) {
 		trace_xprtrdma_mr_unmap(mr);
-		ib_dma_unmap_sg(r_xprt->rx_ep.re_id->device,
+		ib_dma_unmap_sg(r_xprt->rx_ep->re_id->device,
 				mr->mr_sg, mr->mr_nents, mr->mr_dir);
 		mr->mr_dir = DMA_NONE;
 	}
@@ -115,7 +115,7 @@ void frwr_reset(struct rpcrdma_req *req)
  */
 int frwr_mr_init(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
 {
-	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
+	struct rpcrdma_ep *ep = r_xprt->rx_ep;
 	unsigned int depth = ep->re_max_fr_depth;
 	struct scatterlist *sg;
 	struct ib_mr *frmr;
@@ -283,7 +283,7 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 				int nsegs, bool writing, __be32 xid,
 				struct rpcrdma_mr *mr)
 {
-	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
+	struct rpcrdma_ep *ep = r_xprt->rx_ep;
 	struct ib_reg_wr *reg_wr;
 	int i, n, dma_nents;
 	struct ib_mr *ibmr;
@@ -405,7 +405,7 @@ int frwr_send(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 		post_wr = &frwr->fr_regwr.wr;
 	}
 
-	return ib_post_send(r_xprt->rx_ep.re_id->qp, post_wr, NULL);
+	return ib_post_send(r_xprt->rx_ep->re_id->qp, post_wr, NULL);
 }
 
 /**
@@ -535,7 +535,7 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	 * unless re_id->qp is a valid pointer.
 	 */
 	bad_wr = NULL;
-	rc = ib_post_send(r_xprt->rx_ep.re_id->qp, first, &bad_wr);
+	rc = ib_post_send(r_xprt->rx_ep->re_id->qp, first, &bad_wr);
 
 	/* The final LOCAL_INV WR in the chain is supposed to
 	 * do the wake. If it was never posted, the wake will
@@ -640,7 +640,7 @@ void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	 * unless re_id->qp is a valid pointer.
 	 */
 	bad_wr = NULL;
-	rc = ib_post_send(r_xprt->rx_ep.re_id->qp, first, &bad_wr);
+	rc = ib_post_send(r_xprt->rx_ep->re_id->qp, first, &bad_wr);
 	if (!rc)
 		return;
 
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index ad7e6b0187bd..d1af48e0139c 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -131,9 +131,10 @@ static bool rpcrdma_args_inline(struct rpcrdma_xprt *r_xprt,
 				struct rpc_rqst *rqst)
 {
 	struct xdr_buf *xdr = &rqst->rq_snd_buf;
+	struct rpcrdma_ep *ep = r_xprt->rx_ep;
 	unsigned int count, remaining, offset;
 
-	if (xdr->len > r_xprt->rx_ep.re_max_inline_send)
+	if (xdr->len > ep->re_max_inline_send)
 		return false;
 
 	if (xdr->page_len) {
@@ -144,7 +145,7 @@ static bool rpcrdma_args_inline(struct rpcrdma_xprt *r_xprt,
 			remaining -= min_t(unsigned int,
 					   PAGE_SIZE - offset, remaining);
 			offset = 0;
-			if (++count > r_xprt->rx_ep.re_attr.cap.max_send_sge)
+			if (++count > ep->re_attr.cap.max_send_sge)
 				return false;
 		}
 	}
@@ -161,7 +162,7 @@ static bool rpcrdma_args_inline(struct rpcrdma_xprt *r_xprt,
 static bool rpcrdma_results_inline(struct rpcrdma_xprt *r_xprt,
 				   struct rpc_rqst *rqst)
 {
-	return rqst->rq_rcv_buf.buflen <= r_xprt->rx_ep.re_max_inline_recv;
+	return rqst->rq_rcv_buf.buflen <= r_xprt->rx_ep->re_max_inline_recv;
 }
 
 /* The client is required to provide a Reply chunk if the maximum
@@ -175,7 +176,7 @@ static bool rpcrdma_results_inline(struct rpcrdma_xprt *r_xprt,
 	const struct xdr_buf *buf = &rqst->rq_rcv_buf;
 
 	return (buf->head[0].iov_len + buf->tail[0].iov_len) <
-		r_xprt->rx_ep.re_max_inline_recv;
+		r_xprt->rx_ep->re_max_inline_recv;
 }
 
 /* Split @vec on page boundaries into SGEs. FMR registers pages, not
@@ -254,7 +255,7 @@ static bool rpcrdma_results_inline(struct rpcrdma_xprt *r_xprt,
 	/* When encoding a Read chunk, the tail iovec contains an
 	 * XDR pad and may be omitted.
 	 */
-	if (type == rpcrdma_readch && r_xprt->rx_ep.re_implicit_roundup)
+	if (type == rpcrdma_readch && r_xprt->rx_ep->re_implicit_roundup)
 		goto out;
 
 	/* When encoding a Write chunk, some servers need to see an
@@ -262,7 +263,7 @@ static bool rpcrdma_results_inline(struct rpcrdma_xprt *r_xprt,
 	 * layer provides space in the tail iovec that may be used
 	 * for this purpose.
 	 */
-	if (type == rpcrdma_writech && r_xprt->rx_ep.re_implicit_roundup)
+	if (type == rpcrdma_writech && r_xprt->rx_ep->re_implicit_roundup)
 		goto out;
 
 	if (xdrbuf->tail[0].iov_len)
@@ -1475,8 +1476,8 @@ void rpcrdma_reply_handler(struct rpcrdma_rep *rep)
 
 	if (credits == 0)
 		credits = 1;	/* don't deadlock */
-	else if (credits > r_xprt->rx_ep.re_max_requests)
-		credits = r_xprt->rx_ep.re_max_requests;
+	else if (credits > r_xprt->rx_ep->re_max_requests)
+		credits = r_xprt->rx_ep->re_max_requests;
 	if (buf->rb_credits != credits)
 		rpcrdma_update_cwnd(r_xprt, credits);
 	rpcrdma_post_recvs(r_xprt, false);
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 4352fd6e9817..659da37020a4 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -238,12 +238,12 @@
 	struct rpcrdma_xprt *r_xprt = container_of(work, struct rpcrdma_xprt,
 						   rx_connect_worker.work);
 	struct rpc_xprt *xprt = &r_xprt->rx_xprt;
-	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
 	int rc;
 
 	rc = rpcrdma_xprt_connect(r_xprt);
 	xprt_clear_connecting(xprt);
-	if (ep->re_connect_status > 0) {
+	if (r_xprt->rx_ep && r_xprt->rx_ep->re_connect_status > 0) {
+		xprt->connect_cookie++;
 		xprt->stat.connect_count++;
 		xprt->stat.connect_time += (long)jiffies -
 					   xprt->stat.connect_start;
@@ -266,7 +266,7 @@
 	struct rpcrdma_xprt *r_xprt = rpcx_to_rdmax(xprt);
 
 	trace_xprtrdma_op_inject_dsc(r_xprt);
-	rdma_disconnect(r_xprt->rx_ep.re_id);
+	rdma_disconnect(r_xprt->rx_ep->re_id);
 }
 
 /**
@@ -316,10 +316,15 @@
 	if (args->addrlen > sizeof(xprt->addr))
 		return ERR_PTR(-EBADF);
 
+	if (!try_module_get(THIS_MODULE))
+		return ERR_PTR(-EIO);
+
 	xprt = xprt_alloc(args->net, sizeof(struct rpcrdma_xprt), 0,
 			  xprt_rdma_slot_table_entries);
-	if (!xprt)
+	if (!xprt) {
+		module_put(THIS_MODULE);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	xprt->timeout = &xprt_rdma_default_timeout;
 	xprt->connect_timeout = xprt->timeout->to_initval;
@@ -348,11 +353,12 @@
 
 	new_xprt = rpcx_to_rdmax(xprt);
 	rc = rpcrdma_buffer_create(new_xprt);
-	if (rc)
-		goto out2;
-
-	if (!try_module_get(THIS_MODULE))
-		goto out4;
+	if (rc) {
+		xprt_rdma_free_addresses(xprt);
+		xprt_free(xprt);
+		module_put(THIS_MODULE);
+		return ERR_PTR(rc);
+	}
 
 	INIT_DELAYED_WORK(&new_xprt->rx_connect_worker,
 			  xprt_rdma_connect_worker);
@@ -364,15 +370,6 @@
 		xprt->address_strings[RPC_DISPLAY_PORT]);
 	trace_xprtrdma_create(new_xprt);
 	return xprt;
-
-out4:
-	rpcrdma_buffer_destroy(&new_xprt->rx_buf);
-	rc = -ENODEV;
-out2:
-	trace_xprtrdma_op_destroy(new_xprt);
-	xprt_rdma_free_addresses(xprt);
-	xprt_free(xprt);
-	return ERR_PTR(rc);
 }
 
 /**
@@ -491,11 +488,11 @@ static void xprt_rdma_set_connect_timeout(struct rpc_xprt *xprt,
 xprt_rdma_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 {
 	struct rpcrdma_xprt *r_xprt = rpcx_to_rdmax(xprt);
-	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
+	struct rpcrdma_ep *ep = r_xprt->rx_ep;
 	unsigned long delay;
 
 	delay = 0;
-	if (ep->re_connect_status != 0) {
+	if (ep && ep->re_connect_status != 0) {
 		delay = xprt_reconnect_delay(xprt);
 		xprt_reconnect_backoff(xprt, RPCRDMA_INIT_REEST_TO);
 	}
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 5cb308fb4f0f..2e3be706956d 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -84,7 +84,7 @@ static void rpcrdma_sendctx_put_locked(struct rpcrdma_xprt *r_xprt,
 static void rpcrdma_reps_unmap(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_mrs_destroy(struct rpcrdma_xprt *r_xprt);
-static void rpcrdma_ep_destroy(struct rpcrdma_xprt *r_xprt);
+static int rpcrdma_ep_destroy(struct rpcrdma_ep *ep);
 static struct rpcrdma_regbuf *
 rpcrdma_regbuf_alloc(size_t size, enum dma_data_direction direction,
 		     gfp_t flags);
@@ -97,7 +97,7 @@ static void rpcrdma_sendctx_put_locked(struct rpcrdma_xprt *r_xprt,
  */
 static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
 {
-	struct rdma_cm_id *id = r_xprt->rx_ep.re_id;
+	struct rdma_cm_id *id = r_xprt->rx_ep->re_id;
 
 	/* Flush Receives, then wait for deferred Reply work
 	 * to complete.
@@ -139,8 +139,8 @@ void rpcrdma_flush_disconnect(struct ib_cq *cq, struct ib_wc *wc)
 	struct rpc_xprt *xprt = &r_xprt->rx_xprt;
 
 	if (wc->status != IB_WC_SUCCESS &&
-	    r_xprt->rx_ep.re_connect_status == 1) {
-		r_xprt->rx_ep.re_connect_status = -ECONNABORTED;
+	    r_xprt->rx_ep->re_connect_status == 1) {
+		r_xprt->rx_ep->re_connect_status = -ECONNABORTED;
 		trace_xprtrdma_flush_dct(r_xprt, wc->status);
 		xprt_force_disconnect(xprt);
 	}
@@ -179,7 +179,7 @@ static void rpcrdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 
 	/* WARNING: Only wr_cqe and status are reliable at this point */
 	trace_xprtrdma_wc_receive(wc);
-	--r_xprt->rx_ep.re_receive_count;
+	--r_xprt->rx_ep->re_receive_count;
 	if (wc->status != IB_WC_SUCCESS)
 		goto out_flushed;
 
@@ -239,13 +239,11 @@ static void rpcrdma_update_cm_private(struct rpcrdma_ep *ep,
 rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 {
 	struct sockaddr *sap = (struct sockaddr *)&id->route.addr.dst_addr;
-	struct rpcrdma_xprt *r_xprt = id->context;
-	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
-	struct rpc_xprt *xprt = &r_xprt->rx_xprt;
+	struct rpcrdma_ep *ep = id->context;
+	struct rpc_xprt *xprt = ep->re_xprt;
 
 	might_sleep();
 
-	trace_xprtrdma_cm_event(r_xprt, event);
 	switch (event->event) {
 	case RDMA_CM_EVENT_ADDR_RESOLVED:
 	case RDMA_CM_EVENT_ROUTE_RESOLVED:
@@ -265,16 +263,13 @@ static void rpcrdma_update_cm_private(struct rpcrdma_ep *ep,
 		pr_info("rpcrdma: removing device %s for %pISpc\n",
 			ep->re_id->device->name, sap);
 #endif
-		init_completion(&ep->re_remove_done);
+		/* fall through */
+	case RDMA_CM_EVENT_ADDR_CHANGE:
 		ep->re_connect_status = -ENODEV;
 		xprt_force_disconnect(xprt);
-		wait_for_completion(&ep->re_remove_done);
-		trace_xprtrdma_remove(ep);
-
-		/* Return 1 to ensure the core destroys the id. */
-		return 1;
+		goto disconnected;
 	case RDMA_CM_EVENT_ESTABLISHED:
-		++xprt->connect_cookie;
+		kref_get(&ep->re_kref);
 		ep->re_connect_status = 1;
 		rpcrdma_update_cm_private(ep, &event->param.conn);
 		trace_xprtrdma_inline_thresh(ep);
@@ -296,9 +291,7 @@ static void rpcrdma_update_cm_private(struct rpcrdma_ep *ep,
 	case RDMA_CM_EVENT_DISCONNECTED:
 		ep->re_connect_status = -ECONNABORTED;
 disconnected:
-		xprt_force_disconnect(xprt);
-		wake_up_all(&ep->re_connect_wait);
-		break;
+		return rpcrdma_ep_destroy(ep);
 	default:
 		break;
 	}
@@ -318,7 +311,7 @@ static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
 
 	init_completion(&ep->re_done);
 
-	id = rdma_create_id(xprt->xprt_net, rpcrdma_cm_event_handler, r_xprt,
+	id = rdma_create_id(xprt->xprt_net, rpcrdma_cm_event_handler, ep,
 			    RDMA_PS_TCP, IB_QPT_RC);
 	if (IS_ERR(id))
 		return id;
@@ -354,25 +347,66 @@ static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
 	return ERR_PTR(rc);
 }
 
-/*
- * Exported functions.
+static void rpcrdma_ep_put(struct kref *kref)
+{
+	struct rpcrdma_ep *ep = container_of(kref, struct rpcrdma_ep, re_kref);
+
+	if (ep->re_id->qp) {
+		rdma_destroy_qp(ep->re_id);
+		ep->re_id->qp = NULL;
+	}
+
+	if (ep->re_attr.recv_cq)
+		ib_free_cq(ep->re_attr.recv_cq);
+	ep->re_attr.recv_cq = NULL;
+	if (ep->re_attr.send_cq)
+		ib_free_cq(ep->re_attr.send_cq);
+	ep->re_attr.send_cq = NULL;
+
+	if (ep->re_pd)
+		ib_dealloc_pd(ep->re_pd);
+	ep->re_pd = NULL;
+
+	kfree(ep);
+	module_put(THIS_MODULE);
+}
+
+/* Returns:
+ *     %0 if @ep still has a positive kref count, or
+ *     %1 if @ep was destroyed successfully.
  */
+static int rpcrdma_ep_destroy(struct rpcrdma_ep *ep)
+{
+	return kref_put(&ep->re_kref, rpcrdma_ep_put);
+}
 
 static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 {
-	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
-	struct rpcrdma_connect_private *pmsg = &ep->re_cm_private;
+	struct rpcrdma_connect_private *pmsg;
+	struct ib_device *device;
 	struct rdma_cm_id *id;
+	struct rpcrdma_ep *ep;
 	int rc;
 
+	ep = kzalloc(sizeof(*ep), GFP_NOFS);
+	if (!ep)
+		return -EAGAIN;
+	ep->re_xprt = &r_xprt->rx_xprt;
+	kref_init(&ep->re_kref);
+
 	id = rpcrdma_create_id(r_xprt, ep);
-	if (IS_ERR(id))
-		return PTR_ERR(id);
+	if (IS_ERR(id)) {
+		rc = PTR_ERR(id);
+		goto out_free;
+	}
+	__module_get(THIS_MODULE);
+	device = id->device;
+	ep->re_id = id;
 
 	ep->re_max_requests = r_xprt->rx_xprt.max_reqs;
 	ep->re_inline_send = xprt_rdma_max_inline_write;
 	ep->re_inline_recv = xprt_rdma_max_inline_read;
-	rc = frwr_query_device(ep, id->device);
+	rc = frwr_query_device(ep, device);
 	if (rc)
 		goto out_destroy;
 
@@ -398,7 +432,7 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 	ep->re_send_count = ep->re_send_batch;
 	init_waitqueue_head(&ep->re_connect_wait);
 
-	ep->re_attr.send_cq = ib_alloc_cq_any(id->device, r_xprt,
+	ep->re_attr.send_cq = ib_alloc_cq_any(device, r_xprt,
 					      ep->re_attr.cap.max_send_wr,
 					      IB_POLL_WORKQUEUE);
 	if (IS_ERR(ep->re_attr.send_cq)) {
@@ -406,7 +440,7 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 		goto out_destroy;
 	}
 
-	ep->re_attr.recv_cq = ib_alloc_cq_any(id->device, r_xprt,
+	ep->re_attr.recv_cq = ib_alloc_cq_any(device, r_xprt,
 					      ep->re_attr.cap.max_recv_wr,
 					      IB_POLL_WORKQUEUE);
 	if (IS_ERR(ep->re_attr.recv_cq)) {
@@ -419,6 +453,7 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 	memset(&ep->re_remote_cma, 0, sizeof(ep->re_remote_cma));
 
 	/* Prepare RDMA-CM private message */
+	pmsg = &ep->re_cm_private;
 	pmsg->cp_magic = rpcrdma_cmp_magic;
 	pmsg->cp_version = RPCRDMA_CMP_VERSION;
 	pmsg->cp_flags |= RPCRDMA_CMP_F_SND_W_INV_OK;
@@ -430,7 +465,7 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 	/* Client offers RDMA Read but does not initiate */
 	ep->re_remote_cma.initiator_depth = 0;
 	ep->re_remote_cma.responder_resources =
-		min_t(int, U8_MAX, id->device->attrs.max_qp_rd_atom);
+		min_t(int, U8_MAX, device->attrs.max_qp_rd_atom);
 
 	/* Limit transport retries so client can detect server
 	 * GID changes quickly. RPC layer handles re-establishing
@@ -445,7 +480,7 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 	ep->re_remote_cma.flow_control = 0;
 	ep->re_remote_cma.rnr_retry_count = 0;
 
-	ep->re_pd = ib_alloc_pd(id->device, 0);
+	ep->re_pd = ib_alloc_pd(device, 0);
 	if (IS_ERR(ep->re_pd)) {
 		rc = PTR_ERR(ep->re_pd);
 		goto out_destroy;
@@ -455,50 +490,36 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 	if (rc)
 		goto out_destroy;
 
-	ep->re_id = id;
+	r_xprt->rx_ep = ep;
 	return 0;
 
 out_destroy:
-	rpcrdma_ep_destroy(r_xprt);
+	rpcrdma_ep_destroy(ep);
 	rdma_destroy_id(id);
+out_free:
+	kfree(ep);
+	r_xprt->rx_ep = NULL;
 	return rc;
 }
 
-static void rpcrdma_ep_destroy(struct rpcrdma_xprt *r_xprt)
-{
-	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
-
-	if (ep->re_id && ep->re_id->qp) {
-		rdma_destroy_qp(ep->re_id);
-		ep->re_id->qp = NULL;
-	}
-
-	if (ep->re_attr.recv_cq)
-		ib_free_cq(ep->re_attr.recv_cq);
-	ep->re_attr.recv_cq = NULL;
-	if (ep->re_attr.send_cq)
-		ib_free_cq(ep->re_attr.send_cq);
-	ep->re_attr.send_cq = NULL;
-
-	if (ep->re_pd)
-		ib_dealloc_pd(ep->re_pd);
-	ep->re_pd = NULL;
-}
-
-/*
- * Connect unconnected endpoint.
+/**
+ * rpcrdma_xprt_connect - Connect an unconnected transport
+ * @r_xprt: controlling transport instance
+ *
+ * Returns 0 on success or a negative errno.
  */
 int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
 {
 	struct rpc_xprt *xprt = &r_xprt->rx_xprt;
-	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
+	struct rpcrdma_ep *ep;
 	int rc;
 
 retry:
 	rpcrdma_xprt_disconnect(r_xprt);
 	rc = rpcrdma_ep_create(r_xprt);
 	if (rc)
-		goto out_noupdate;
+		return rc;
+	ep = r_xprt->rx_ep;
 
 	ep->re_connect_status = 0;
 	xprt_clear_connected(xprt);
@@ -535,8 +556,6 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
 out:
 	if (rc)
 		ep->re_connect_status = rc;
-
-out_noupdate:
 	trace_xprtrdma_connect(r_xprt, rc);
 	return rc;
 }
@@ -547,40 +566,33 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
  *
  * Caller serializes. Either the transport send lock is held,
  * or we're being called to destroy the transport.
+ *
+ * On return, @r_xprt is completely divested of all hardware
+ * resources and prepared for the next ->connect operation.
  */
 void rpcrdma_xprt_disconnect(struct rpcrdma_xprt *r_xprt)
 {
-	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
-	struct rdma_cm_id *id = ep->re_id;
-	int rc, status = ep->re_connect_status;
-
-	might_sleep();
+	struct rpcrdma_ep *ep = r_xprt->rx_ep;
+	struct rdma_cm_id *id;
+	int rc;
 
-	if (!id)
+	if (!ep)
 		return;
 
+	id = ep->re_id;
 	rc = rdma_disconnect(id);
-	if (!rc)
-		wait_event_interruptible(ep->re_connect_wait,
-					 ep->re_connect_status != 1);
-	else
-		ep->re_connect_status = rc;
 	trace_xprtrdma_disconnect(r_xprt, rc);
 
-	if (id->qp)
-		rpcrdma_xprt_drain(r_xprt);
+	rpcrdma_xprt_drain(r_xprt);
 	rpcrdma_reps_unmap(r_xprt);
 	rpcrdma_reqs_reset(r_xprt);
 	rpcrdma_mrs_destroy(r_xprt);
 	rpcrdma_sendctxs_destroy(r_xprt);
 
-	rpcrdma_ep_destroy(r_xprt);
-
-	if (status == -ENODEV)
-		complete(&ep->re_remove_done);
-	else
+	if (rpcrdma_ep_destroy(ep))
 		rdma_destroy_id(id);
-	ep->re_id = NULL;
+
+	r_xprt->rx_ep = NULL;
 }
 
 /* Fixed-size circular FIFO queue. This implementation is wait-free and
@@ -637,14 +649,14 @@ static int rpcrdma_sendctxs_create(struct rpcrdma_xprt *r_xprt)
 	 * the ->send_request call to fail temporarily before too many
 	 * Sends are posted.
 	 */
-	i = r_xprt->rx_ep.re_max_requests + RPCRDMA_MAX_BC_REQUESTS;
+	i = r_xprt->rx_ep->re_max_requests + RPCRDMA_MAX_BC_REQUESTS;
 	buf->rb_sc_ctxs = kcalloc(i, sizeof(sc), GFP_KERNEL);
 	if (!buf->rb_sc_ctxs)
 		return -ENOMEM;
 
 	buf->rb_sc_last = i - 1;
 	for (i = 0; i <= buf->rb_sc_last; i++) {
-		sc = rpcrdma_sendctx_create(&r_xprt->rx_ep);
+		sc = rpcrdma_sendctx_create(r_xprt->rx_ep);
 		if (!sc)
 			return -ENOMEM;
 
@@ -748,7 +760,7 @@ static void rpcrdma_sendctx_put_locked(struct rpcrdma_xprt *r_xprt,
 rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt)
 {
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
-	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
+	struct rpcrdma_ep *ep = r_xprt->rx_ep;
 	unsigned int count;
 
 	for (count = 0; count < ep->re_max_rdma_segs; count++) {
@@ -795,7 +807,7 @@ static void rpcrdma_sendctx_put_locked(struct rpcrdma_xprt *r_xprt,
 void rpcrdma_mrs_refresh(struct rpcrdma_xprt *r_xprt)
 {
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
-	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
+	struct rpcrdma_ep *ep = r_xprt->rx_ep;
 
 	/* If there is no underlying connection, it's no use
 	 * to wake the refresh worker.
@@ -864,7 +876,7 @@ int rpcrdma_req_setup(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 
 	/* Compute maximum header buffer size in bytes */
 	maxhdrsize = rpcrdma_fixed_maxsz + 3 +
-		     r_xprt->rx_ep.re_max_rdma_segs * rpcrdma_readchunk_maxsz;
+		     r_xprt->rx_ep->re_max_rdma_segs * rpcrdma_readchunk_maxsz;
 	maxhdrsize *= sizeof(__be32);
 	rb = rpcrdma_regbuf_alloc(__roundup_pow_of_two(maxhdrsize),
 				  DMA_TO_DEVICE, GFP_KERNEL);
@@ -942,7 +954,7 @@ struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
 	if (rep == NULL)
 		goto out;
 
-	rep->rr_rdmabuf = rpcrdma_regbuf_alloc(r_xprt->rx_ep.re_inline_recv,
+	rep->rr_rdmabuf = rpcrdma_regbuf_alloc(r_xprt->rx_ep->re_inline_recv,
 					       DMA_FROM_DEVICE, GFP_KERNEL);
 	if (!rep->rr_rdmabuf)
 		goto out_free;
@@ -1167,7 +1179,7 @@ void rpcrdma_mr_put(struct rpcrdma_mr *mr)
 
 	if (mr->mr_dir != DMA_NONE) {
 		trace_xprtrdma_mr_unmap(mr);
-		ib_dma_unmap_sg(r_xprt->rx_ep.re_id->device,
+		ib_dma_unmap_sg(r_xprt->rx_ep->re_id->device,
 				mr->mr_sg, mr->mr_nents, mr->mr_dir);
 		mr->mr_dir = DMA_NONE;
 	}
@@ -1285,7 +1297,7 @@ bool rpcrdma_regbuf_realloc(struct rpcrdma_regbuf *rb, size_t size, gfp_t flags)
 bool __rpcrdma_regbuf_dma_map(struct rpcrdma_xprt *r_xprt,
 			      struct rpcrdma_regbuf *rb)
 {
-	struct ib_device *device = r_xprt->rx_ep.re_id->device;
+	struct ib_device *device = r_xprt->rx_ep->re_id->device;
 
 	if (rb->rg_direction == DMA_NONE)
 		return false;
@@ -1298,7 +1310,7 @@ bool __rpcrdma_regbuf_dma_map(struct rpcrdma_xprt *r_xprt,
 	}
 
 	rb->rg_device = device;
-	rb->rg_iov.lkey = r_xprt->rx_ep.re_pd->local_dma_lkey;
+	rb->rg_iov.lkey = r_xprt->rx_ep->re_pd->local_dma_lkey;
 	return true;
 }
 
@@ -1334,7 +1346,7 @@ static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb)
 int rpcrdma_post_sends(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 {
 	struct ib_send_wr *send_wr = &req->rl_wr;
-	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
+	struct rpcrdma_ep *ep = r_xprt->rx_ep;
 	int rc;
 
 	if (!ep->re_send_count || kref_read(&req->rl_kref) > 1) {
@@ -1361,7 +1373,7 @@ int rpcrdma_post_sends(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp)
 {
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
-	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
+	struct rpcrdma_ep *ep = r_xprt->rx_ep;
 	struct ib_recv_wr *wr, *bad_wr;
 	struct rpcrdma_rep *rep;
 	int needed, count, rc;
@@ -1398,7 +1410,7 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp)
 	if (!wr)
 		goto out;
 
-	rc = ib_post_recv(r_xprt->rx_ep.re_id->qp, wr,
+	rc = ib_post_recv(ep->re_id->qp, wr,
 			  (const struct ib_recv_wr **)&bad_wr);
 out:
 	trace_xprtrdma_post_recvs(r_xprt, count, rc);
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index f3c0b826c9ed..0a16fdb09b2c 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -68,6 +68,7 @@
  * RDMA Endpoint -- connection endpoint details
  */
 struct rpcrdma_ep {
+	struct kref		re_kref;
 	struct rdma_cm_id 	*re_id;
 	struct ib_pd		*re_pd;
 	unsigned int		re_max_rdma_segs;
@@ -75,7 +76,6 @@ struct rpcrdma_ep {
 	bool			re_implicit_roundup;
 	enum ib_mr_type		re_mrtype;
 	struct completion	re_done;
-	struct completion	re_remove_done;
 	unsigned int		re_send_count;
 	unsigned int		re_send_batch;
 	unsigned int		re_max_inline_send;
@@ -83,7 +83,8 @@ struct rpcrdma_ep {
 	int			re_async_rc;
 	int			re_connect_status;
 	struct ib_qp_init_attr	re_attr;
-	wait_queue_head_t	re_connect_wait;
+	wait_queue_head_t       re_connect_wait;
+	struct rpc_xprt		*re_xprt;
 	struct rpcrdma_connect_private
 				re_cm_private;
 	struct rdma_conn_param	re_remote_cma;
@@ -411,7 +412,7 @@ struct rpcrdma_stats {
  */
 struct rpcrdma_xprt {
 	struct rpc_xprt		rx_xprt;
-	struct rpcrdma_ep	rx_ep;
+	struct rpcrdma_ep	*rx_ep;
 	struct rpcrdma_buffer	rx_buf;
 	struct delayed_work	rx_connect_worker;
 	struct rpc_timeout	rx_timeout;

