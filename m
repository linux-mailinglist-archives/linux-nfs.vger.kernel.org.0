Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B36511689BA
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2020 23:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgBUWAx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Feb 2020 17:00:53 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35139 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728722AbgBUWAx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Feb 2020 17:00:53 -0500
Received: by mail-yb1-f196.google.com with SMTP id p123so1883951ybp.2;
        Fri, 21 Feb 2020 14:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Fe8bA31WE75e6o9IYgMetxv2xQXN91HnbdrrwARzobU=;
        b=biLbtRTNlSKcyiRGHGQU9QeNGHZrlZvTdn0JsgmboKpfZa3M8r1cy0F6D/aC9wbdeY
         TytFQKXUMUzVRVZ5J/69ADui6rhpU9i9U79WVtOawHy60CnU//L5YcXhR6geJbNp/UOn
         Os9+VocuZg2pivxGttxZXHbBnOuIJHL18rMSZl+t9svjTROy4akuARMMJfu1pwCLuJwT
         m3D/Lvnk9ZdRSbxFow3UTjDiA9a0fZ2xKTl/ntN0STLjIy1DMZIL2rg8NfS1E3OMhCfx
         ExVVa9KjJMrHIu7fNpa710JZohsSPtOfPiy5eYNZs+UM2p7TP6yYNc1FpQvlKAGMuDfh
         CY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Fe8bA31WE75e6o9IYgMetxv2xQXN91HnbdrrwARzobU=;
        b=VoSYW5c8b5IinpE4BT2E64bLj3xKgXKbIsYgEBMzfBYxyApbB0SC+MQvU8WylgP5Jy
         nIIE00cBNDUuclfqKHX2H2eWcEUYiCE0PIegPyvrKCHEi4c3xmn/vkw4T7TeogQwE8A3
         5414dRg41WMu7hOK9KhvDYVvS3FhNbXSO1oqXBngmysmaExgDVRJZkL0F+v1WqVDeQpc
         fpmcjIARO5ShRqgaqrtOxo2pW/nLXRnhTba2x5/L2ylBwlxjote9MEACS+eCELa3FJBI
         tEkdEhOfk/wl4xoFOrQPmft7wmlekmEgt3DVbKebZssuYduE/sG+dI90hTAv0WhQ8tR7
         CJjQ==
X-Gm-Message-State: APjAAAWW5g6jcoIb4tDnqRFMCu5X2oy4dmK6rj0Zw+lgO1CyPNCwo/Fx
        q8xGReZqQrWezIasWoqpa9vPoIx1
X-Google-Smtp-Source: APXvYqz+SnUFN7llZ2WrTV1EbAt9efdpuvtBemp9zcEsCa5Mcp/As5OpQGIU6UGZTd5BaREGrx/d1Q==
X-Received: by 2002:a25:581:: with SMTP id 123mr30853646ybf.508.1582322450916;
        Fri, 21 Feb 2020 14:00:50 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e186sm1835227ywb.73.2020.02.21.14.00.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2020 14:00:50 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 01LM0ngG019000;
        Fri, 21 Feb 2020 22:00:49 GMT
Subject: [PATCH v1 08/11] xprtrdma: Disconnect on flushed completion
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 21 Feb 2020 17:00:49 -0500
Message-ID: <20200221220049.2072.12038.stgit@manet.1015granger.net>
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

Completion errors after a disconnect often occur much sooner than a
CM_DISCONNECT event. Use this to try to detect connection loss more
quickly.

Note that other kernel ULPs do take care to disconnect explicitly
when a WR is flushed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h  |    3 ++-
 net/sunrpc/xprtrdma/frwr_ops.c  |   24 ++++++++++++++++--------
 net/sunrpc/xprtrdma/verbs.c     |   37 ++++++++++++++++++++++++++++---------
 net/sunrpc/xprtrdma/xprt_rdma.h |    1 +
 4 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index ce2126a90806..18369943da61 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -109,7 +109,7 @@
 		__assign_str(port, rpcrdma_portstr(r_xprt));
 	),
 
-	TP_printk("peer=[%s]:%s r_xprt=%p: rc=%d connect status=%d",
+	TP_printk("peer=[%s]:%s r_xprt=%p: rc=%d connection status=%d",
 		__get_str(addr), __get_str(port), __entry->r_xprt,
 		__entry->rc, __entry->connect_status
 	)
@@ -409,6 +409,7 @@
 
 DEFINE_CONN_EVENT(connect);
 DEFINE_CONN_EVENT(disconnect);
+DEFINE_CONN_EVENT(flush_dct);
 
 DEFINE_RXPRT_EVENT(xprtrdma_create);
 DEFINE_RXPRT_EVENT(xprtrdma_op_destroy);
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 1f34aa49679c..69d5910f04a0 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -358,8 +358,8 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 
 /**
  * frwr_wc_fastreg - Invoked by RDMA provider for a flushed FastReg WC
- * @cq:	completion queue (ignored)
- * @wc:	completed WR
+ * @cq: completion queue
+ * @wc: WCE for a completed FastReg WR
  *
  */
 static void frwr_wc_fastreg(struct ib_cq *cq, struct ib_wc *wc)
@@ -371,6 +371,8 @@ static void frwr_wc_fastreg(struct ib_cq *cq, struct ib_wc *wc)
 	/* WARNING: Only wr_cqe and status are reliable at this point */
 	trace_xprtrdma_wc_fastreg(wc, frwr);
 	/* The MR will get recycled when the associated req is retransmitted */
+
+	rpcrdma_flush_disconnect(cq, wc);
 }
 
 /**
@@ -441,8 +443,8 @@ static void __frwr_release_mr(struct ib_wc *wc, struct rpcrdma_mr *mr)
 
 /**
  * frwr_wc_localinv - Invoked by RDMA provider for a LOCAL_INV WC
- * @cq:	completion queue (ignored)
- * @wc:	completed WR
+ * @cq: completion queue
+ * @wc: WCE for a completed LocalInv WR
  *
  */
 static void frwr_wc_localinv(struct ib_cq *cq, struct ib_wc *wc)
@@ -455,12 +457,14 @@ static void frwr_wc_localinv(struct ib_cq *cq, struct ib_wc *wc)
 	/* WARNING: Only wr_cqe and status are reliable at this point */
 	trace_xprtrdma_wc_li(wc, frwr);
 	__frwr_release_mr(wc, mr);
+
+	rpcrdma_flush_disconnect(cq, wc);
 }
 
 /**
  * frwr_wc_localinv_wake - Invoked by RDMA provider for a LOCAL_INV WC
- * @cq:	completion queue (ignored)
- * @wc:	completed WR
+ * @cq: completion queue
+ * @wc: WCE for a completed LocalInv WR
  *
  * Awaken anyone waiting for an MR to finish being fenced.
  */
@@ -475,6 +479,8 @@ static void frwr_wc_localinv_wake(struct ib_cq *cq, struct ib_wc *wc)
 	trace_xprtrdma_wc_li_wake(wc, frwr);
 	__frwr_release_mr(wc, mr);
 	complete(&frwr->fr_linv_done);
+
+	rpcrdma_flush_disconnect(cq, wc);
 }
 
 /**
@@ -562,8 +568,8 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 
 /**
  * frwr_wc_localinv_done - Invoked by RDMA provider for a signaled LOCAL_INV WC
- * @cq:	completion queue (ignored)
- * @wc:	completed WR
+ * @cq:	completion queue
+ * @wc:	WCE for a completed LocalInv WR
  *
  */
 static void frwr_wc_localinv_done(struct ib_cq *cq, struct ib_wc *wc)
@@ -581,6 +587,8 @@ static void frwr_wc_localinv_done(struct ib_cq *cq, struct ib_wc *wc)
 	/* Ensure @rep is generated before __frwr_release_mr */
 	smp_rmb();
 	rpcrdma_complete_rqst(rep);
+
+	rpcrdma_flush_disconnect(cq, wc);
 }
 
 /**
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index a7f46bbbf017..dfe680e3234a 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -129,13 +129,31 @@ static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
 }
 
 /**
+ * rpcrdma_flush_disconnect - Disconnect on flushed completion
+ * @cq: completion queue
+ * @wc: work completion entry
+ *
+ * Must be called in process context.
+ */
+void rpcrdma_flush_disconnect(struct ib_cq *cq, struct ib_wc *wc)
+{
+	struct rpcrdma_xprt *r_xprt = cq->cq_context;
+	struct rpc_xprt *xprt = &r_xprt->rx_xprt;
+
+	if (wc->status != IB_WC_SUCCESS && r_xprt->rx_ep.rep_connected == 1) {
+		r_xprt->rx_ep.rep_connected = -ECONNABORTED;
+		trace_xprtrdma_flush_dct(r_xprt, wc->status);
+		xprt_force_disconnect(xprt);
+	}
+}
+
+/**
  * rpcrdma_wc_send - Invoked by RDMA provider for each polled Send WC
  * @cq:	completion queue
- * @wc:	completed WR
+ * @wc:	WCE for a completed Send WR
  *
  */
-static void
-rpcrdma_wc_send(struct ib_cq *cq, struct ib_wc *wc)
+static void rpcrdma_wc_send(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct ib_cqe *cqe = wc->wr_cqe;
 	struct rpcrdma_sendctx *sc =
@@ -144,21 +162,21 @@ static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
 	/* WARNING: Only wr_cqe and status are reliable at this point */
 	trace_xprtrdma_wc_send(sc, wc);
 	rpcrdma_sendctx_put_locked((struct rpcrdma_xprt *)cq->cq_context, sc);
+	rpcrdma_flush_disconnect(cq, wc);
 }
 
 /**
  * rpcrdma_wc_receive - Invoked by RDMA provider for each polled Receive WC
- * @cq:	completion queue (ignored)
- * @wc:	completed WR
+ * @cq:	completion queue
+ * @wc:	WCE for a completed Receive WR
  *
  */
-static void
-rpcrdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
+static void rpcrdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct ib_cqe *cqe = wc->wr_cqe;
 	struct rpcrdma_rep *rep = container_of(cqe, struct rpcrdma_rep,
 					       rr_cqe);
-	struct rpcrdma_xprt *r_xprt = rep->rr_rxprt;
+	struct rpcrdma_xprt *r_xprt = cq->cq_context;
 
 	/* WARNING: Only wr_cqe and status are reliable at this point */
 	trace_xprtrdma_wc_receive(wc);
@@ -179,6 +197,7 @@ static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
 	return;
 
 out_flushed:
+	rpcrdma_flush_disconnect(cq, wc);
 	rpcrdma_rep_destroy(rep);
 }
 
@@ -395,7 +414,7 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 		goto out_destroy;
 	}
 
-	ep->rep_attr.recv_cq = ib_alloc_cq_any(id->device, NULL,
+	ep->rep_attr.recv_cq = ib_alloc_cq_any(id->device, r_xprt,
 					       ep->rep_attr.cap.max_recv_wr,
 					       IB_POLL_WORKQUEUE);
 	if (IS_ERR(ep->rep_attr.recv_cq)) {
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index d2a0f125f7a8..8a3ac9d7ee81 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -452,6 +452,7 @@ struct rpcrdma_xprt {
 /*
  * Endpoint calls - xprtrdma/verbs.c
  */
+void rpcrdma_flush_disconnect(struct ib_cq *cq, struct ib_wc *wc);
 int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt);
 void rpcrdma_xprt_disconnect(struct rpcrdma_xprt *r_xprt);
 

