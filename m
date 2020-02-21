Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0DA21689AA
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2020 23:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgBUWAQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Feb 2020 17:00:16 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39259 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgBUWAQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Feb 2020 17:00:16 -0500
Received: by mail-yw1-f66.google.com with SMTP id h126so1798908ywc.6;
        Fri, 21 Feb 2020 14:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jUIMfBsvQvHWA6mdFJZHB8WU0COv8Z+WuJ6GEe7He7w=;
        b=B6ijhXrocJS49+sApSm4HbCqQmNd0EIi7naYIW8bT4MsrwAR7N7UIfY3zsibcw0Qk5
         BlOIS7WWX4TRF2KRvkKDr7GZtN/lADSOI/4shLSrwjcd4yZ9qZeX+WplrEe8/qN0m9E5
         mzS7+81wy7kYZgoFvWrCuuonU/HbrdAKb875loWYwJ7nQMBhehAJkBuz3h5BsoKvKcnQ
         jb2M+FQMcXiaEHgSNzY4EX3IhvixK7HMlDxHC7+3WsknZHINxPoI1QMVvqAE8smQW2yl
         3tk80/vBe/YpEusXkl+kBRuhptx5IhJ7c/LxG7Cp/NRLHK27/Pw4qb39f3fKfcXxi+Ku
         DJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=jUIMfBsvQvHWA6mdFJZHB8WU0COv8Z+WuJ6GEe7He7w=;
        b=EMHR7HwQEOD/ess4qQLklhvbpzjJuH9IywFeaGhmoOtygRtoewLF0haS0f/dRcRbz8
         WxDL41kP3tjMgaxAAruTOvntGSK69owZDupXsNp6F+/CMPkPSCTGVZXCkLgh3aY+xUJR
         9GUZ6mJQkYAYuoefnJs8+g5rHSiNg/waFAS9nhV3zLpf+of75zFeuVKTJfNEZKzhGOvE
         PrkFHqpFRI//iyMUUP0a6vcm9kPRDyp1Fqvu49QjravAtyX+rGvhj7hSHuTcxB69VRzZ
         ta186gmLGCnsZPQSqCKpYzVEvmUsD8YSll4ACW/9JYAGnBtq2S7yYyfVCaDo1B+n+OCJ
         KbTw==
X-Gm-Message-State: APjAAAUUl41CTyuxmQ/awVtfvN3zkgKOoLtVcqrgEFX9FCbXl6Zu9fiZ
        XwTcgg4Safql+Z5bB0+RRNosIvoy
X-Google-Smtp-Source: APXvYqzb2MbPZhZhDpXYqh+boX62CtPrQz8bmFyLB+dXBt12qaaxsCCCU5wQg6z8RKeAtcg6RBQ27Q==
X-Received: by 2002:a81:5595:: with SMTP id j143mr30701706ywb.16.1582322413683;
        Fri, 21 Feb 2020 14:00:13 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id h23sm1816142ywc.105.2020.02.21.14.00.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2020 14:00:13 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 01LM0Cuj018978;
        Fri, 21 Feb 2020 22:00:12 GMT
Subject: [PATCH v1 01/11] xprtrdma: Invoke rpcrdma_ep_create() in the
 connect worker
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 21 Feb 2020 17:00:12 -0500
Message-ID: <20200221220012.2072.79679.stgit@manet.1015granger.net>
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

Refactor rpcrdma_ep_create(), rpcrdma_ep_disconnect(), and
rpcrdma_ep_destroy().

rpcrdma_ep_create will be invoked at connect time instead of at
transport set-up time. It will be responsible for allocating per-
connection resources. In this patch it allocates the CQs and
creates a QP. More to come.

rpcrdma_ep_destroy() is the inverse functionality that is
invoked at disconnect time. It will be responsible for releasing
the CQs and QP.

These changes should be safe to do because both connect and
disconnect is guaranteed to be serialized by the transport send
lock.

This takes us another step closer to resolving the address and route
only at connect time so that connection failover to another device
will work correctly.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/transport.c |   10 +--
 net/sunrpc/xprtrdma/verbs.c     |  147 ++++++++++++++-------------------------
 net/sunrpc/xprtrdma/xprt_rdma.h |    2 -
 3 files changed, 56 insertions(+), 103 deletions(-)

diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 3cfeba68ee9a..d915524a8e68 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -284,7 +284,7 @@
 
 	cancel_delayed_work_sync(&r_xprt->rx_connect_worker);
 
-	rpcrdma_ep_destroy(r_xprt);
+	rpcrdma_ep_disconnect(&r_xprt->rx_ep, &r_xprt->rx_ia);
 	rpcrdma_buffer_destroy(&r_xprt->rx_buf);
 	rpcrdma_ia_close(&r_xprt->rx_ia);
 
@@ -351,13 +351,9 @@
 	if (rc)
 		goto out1;
 
-	rc = rpcrdma_ep_create(new_xprt);
-	if (rc)
-		goto out2;
-
 	rc = rpcrdma_buffer_create(new_xprt);
 	if (rc)
-		goto out3;
+		goto out2;
 
 	if (!try_module_get(THIS_MODULE))
 		goto out4;
@@ -375,8 +371,6 @@
 out4:
 	rpcrdma_buffer_destroy(&new_xprt->rx_buf);
 	rc = -ENODEV;
-out3:
-	rpcrdma_ep_destroy(new_xprt);
 out2:
 	rpcrdma_ia_close(&new_xprt->rx_ia);
 out1:
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 353f61ac8d51..042e6cc4f767 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -84,6 +84,7 @@ static void rpcrdma_sendctx_put_locked(struct rpcrdma_xprt *r_xprt,
 static void rpcrdma_reps_unmap(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_mrs_destroy(struct rpcrdma_xprt *r_xprt);
+static void rpcrdma_ep_destroy(struct rpcrdma_xprt *r_xprt);
 static struct rpcrdma_regbuf *
 rpcrdma_regbuf_alloc(size_t size, enum dma_data_direction direction,
 		     gfp_t flags);
@@ -391,32 +392,17 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
 {
 	struct rpcrdma_xprt *r_xprt = container_of(ia, struct rpcrdma_xprt,
 						   rx_ia);
-	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
 
-	/* This is similar to rpcrdma_ep_destroy, but:
-	 * - Don't cancel the connect worker.
-	 * - Don't call rpcrdma_ep_disconnect, which waits
-	 *   for another conn upcall, which will deadlock.
-	 * - rdma_disconnect is unneeded, the underlying
-	 *   connection is already gone.
-	 */
-	if (ia->ri_id->qp) {
+	if (ia->ri_id->qp)
 		rpcrdma_xprt_drain(r_xprt);
-		rdma_destroy_qp(ia->ri_id);
-		ia->ri_id->qp = NULL;
-	}
-	ib_free_cq(ep->rep_attr.recv_cq);
-	ep->rep_attr.recv_cq = NULL;
-	ib_free_cq(ep->rep_attr.send_cq);
-	ep->rep_attr.send_cq = NULL;
 
-	/* The ULP is responsible for ensuring all DMA
-	 * mappings and MRs are gone.
-	 */
 	rpcrdma_reps_unmap(r_xprt);
 	rpcrdma_reqs_reset(r_xprt);
 	rpcrdma_mrs_destroy(r_xprt);
 	rpcrdma_sendctxs_destroy(r_xprt);
+
+	rpcrdma_ep_destroy(r_xprt);
+
 	ib_dealloc_pd(ia->ri_pd);
 	ia->ri_pd = NULL;
 
@@ -434,11 +420,8 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
 void
 rpcrdma_ia_close(struct rpcrdma_ia *ia)
 {
-	if (ia->ri_id != NULL && !IS_ERR(ia->ri_id)) {
-		if (ia->ri_id->qp)
-			rdma_destroy_qp(ia->ri_id);
+	if (ia->ri_id && !IS_ERR(ia->ri_id))
 		rdma_destroy_id(ia->ri_id);
-	}
 	ia->ri_id = NULL;
 
 	/* If the pd is still busy, xprtrdma missed freeing a resource */
@@ -447,25 +430,19 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
 	ia->ri_pd = NULL;
 }
 
-/**
- * rpcrdma_ep_create - Create unconnected endpoint
- * @r_xprt: transport to instantiate
- *
- * Returns zero on success, or a negative errno.
- */
-int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
+static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt,
+			     struct rdma_cm_id *id)
 {
 	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
 	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
 	struct rpcrdma_connect_private *pmsg = &ep->rep_cm_private;
-	struct ib_cq *sendcq, *recvcq;
 	int rc;
 
 	ep->rep_max_requests = r_xprt->rx_xprt.max_reqs;
 	ep->rep_inline_send = xprt_rdma_max_inline_write;
 	ep->rep_inline_recv = xprt_rdma_max_inline_read;
 
-	rc = frwr_query_device(r_xprt, ia->ri_id->device);
+	rc = frwr_query_device(r_xprt, id->device);
 	if (rc)
 		return rc;
 	r_xprt->rx_buf.rb_max_requests = cpu_to_be32(ep->rep_max_requests);
@@ -491,25 +468,22 @@ int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 	init_waitqueue_head(&ep->rep_connect_wait);
 	ep->rep_receive_count = 0;
 
-	sendcq = ib_alloc_cq_any(ia->ri_id->device, r_xprt,
-				 ep->rep_attr.cap.max_send_wr + 1,
-				 IB_POLL_WORKQUEUE);
-	if (IS_ERR(sendcq)) {
-		rc = PTR_ERR(sendcq);
-		goto out1;
+	ep->rep_attr.send_cq = ib_alloc_cq_any(id->device, r_xprt,
+					       ep->rep_attr.cap.max_send_wr,
+					       IB_POLL_WORKQUEUE);
+	if (IS_ERR(ep->rep_attr.send_cq)) {
+		rc = PTR_ERR(ep->rep_attr.send_cq);
+		goto out_destroy;
 	}
 
-	recvcq = ib_alloc_cq_any(ia->ri_id->device, NULL,
-				 ep->rep_attr.cap.max_recv_wr + 1,
-				 IB_POLL_WORKQUEUE);
-	if (IS_ERR(recvcq)) {
-		rc = PTR_ERR(recvcq);
-		goto out2;
+	ep->rep_attr.recv_cq = ib_alloc_cq_any(id->device, NULL,
+					       ep->rep_attr.cap.max_recv_wr,
+					       IB_POLL_WORKQUEUE);
+	if (IS_ERR(ep->rep_attr.recv_cq)) {
+		rc = PTR_ERR(ep->rep_attr.recv_cq);
+		goto out_destroy;
 	}
 
-	ep->rep_attr.send_cq = sendcq;
-	ep->rep_attr.recv_cq = recvcq;
-
 	/* Initialize cma parameters */
 	memset(&ep->rep_remote_cma, 0, sizeof(ep->rep_remote_cma));
 
@@ -525,7 +499,7 @@ int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 	/* Client offers RDMA Read but does not initiate */
 	ep->rep_remote_cma.initiator_depth = 0;
 	ep->rep_remote_cma.responder_resources =
-		min_t(int, U8_MAX, ia->ri_id->device->attrs.max_qp_rd_atom);
+		min_t(int, U8_MAX, id->device->attrs.max_qp_rd_atom);
 
 	/* Limit transport retries so client can detect server
 	 * GID changes quickly. RPC layer handles re-establishing
@@ -540,45 +514,41 @@ int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 	ep->rep_remote_cma.flow_control = 0;
 	ep->rep_remote_cma.rnr_retry_count = 0;
 
+	rc = rdma_create_qp(id, ia->ri_pd, &ep->rep_attr);
+	if (rc)
+		goto out_destroy;
 	return 0;
 
-out2:
-	ib_free_cq(sendcq);
-out1:
+out_destroy:
+	rpcrdma_ep_destroy(r_xprt);
 	return rc;
 }
 
-/**
- * rpcrdma_ep_destroy - Disconnect and destroy endpoint.
- * @r_xprt: transport instance to shut down
- *
- */
-void rpcrdma_ep_destroy(struct rpcrdma_xprt *r_xprt)
+static void rpcrdma_ep_destroy(struct rpcrdma_xprt *r_xprt)
 {
 	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
 	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
 
 	if (ia->ri_id && ia->ri_id->qp) {
-		rpcrdma_ep_disconnect(ep, ia);
 		rdma_destroy_qp(ia->ri_id);
 		ia->ri_id->qp = NULL;
 	}
 
 	if (ep->rep_attr.recv_cq)
 		ib_free_cq(ep->rep_attr.recv_cq);
+	ep->rep_attr.recv_cq = NULL;
 	if (ep->rep_attr.send_cq)
 		ib_free_cq(ep->rep_attr.send_cq);
+	ep->rep_attr.send_cq = NULL;
 }
 
 /* Re-establish a connection after a device removal event.
  * Unlike a normal reconnection, a fresh PD and a new set
  * of MRs and buffers is needed.
  */
-static int rpcrdma_ep_recreate_xprt(struct rpcrdma_xprt *r_xprt,
-				    struct ib_qp_init_attr *qp_init_attr)
+static int rpcrdma_ep_recreate_xprt(struct rpcrdma_xprt *r_xprt)
 {
 	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
-	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
 	int rc, err;
 
 	trace_xprtrdma_reinsert(r_xprt);
@@ -587,39 +557,24 @@ static int rpcrdma_ep_recreate_xprt(struct rpcrdma_xprt *r_xprt,
 	if (rpcrdma_ia_open(r_xprt))
 		goto out1;
 
-	rc = -ENOMEM;
-	err = rpcrdma_ep_create(r_xprt);
-	if (err) {
-		pr_err("rpcrdma: rpcrdma_ep_create returned %d\n", err);
-		goto out2;
-	}
-	memcpy(qp_init_attr, &ep->rep_attr, sizeof(*qp_init_attr));
-
 	rc = -ENETUNREACH;
-	err = rdma_create_qp(ia->ri_id, ia->ri_pd, qp_init_attr);
-	if (err) {
-		pr_err("rpcrdma: rdma_create_qp returned %d\n", err);
-		goto out3;
-	}
+	err = rpcrdma_ep_create(r_xprt, ia->ri_id);
+	if (err)
+		goto out2;
 	return 0;
 
-out3:
-	rpcrdma_ep_destroy(r_xprt);
 out2:
 	rpcrdma_ia_close(ia);
 out1:
 	return rc;
 }
 
-static int rpcrdma_ep_reconnect(struct rpcrdma_xprt *r_xprt,
-				struct ib_qp_init_attr *qp_init_attr)
+static int rpcrdma_ep_reconnect(struct rpcrdma_xprt *r_xprt)
 {
 	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
 	struct rdma_cm_id *id, *old;
 	int err, rc;
 
-	rpcrdma_ep_disconnect(&r_xprt->rx_ep, ia);
-
 	rc = -EHOSTUNREACH;
 	id = rpcrdma_create_id(r_xprt, ia);
 	if (IS_ERR(id))
@@ -640,15 +595,14 @@ static int rpcrdma_ep_reconnect(struct rpcrdma_xprt *r_xprt,
 		goto out_destroy;
 	}
 
-	err = rdma_create_qp(id, ia->ri_pd, qp_init_attr);
+	err = rpcrdma_ep_create(r_xprt, id);
 	if (err)
 		goto out_destroy;
 
-	/* Atomically replace the transport's ID and QP. */
+	/* Atomically replace the transport's ID. */
 	rc = 0;
 	old = ia->ri_id;
 	ia->ri_id = id;
-	rdma_destroy_qp(old);
 
 out_destroy:
 	rdma_destroy_id(old);
@@ -665,26 +619,25 @@ static int rpcrdma_ep_reconnect(struct rpcrdma_xprt *r_xprt,
 	struct rpcrdma_xprt *r_xprt = container_of(ia, struct rpcrdma_xprt,
 						   rx_ia);
 	struct rpc_xprt *xprt = &r_xprt->rx_xprt;
-	struct ib_qp_init_attr qp_init_attr;
 	int rc;
 
 retry:
-	memcpy(&qp_init_attr, &ep->rep_attr, sizeof(qp_init_attr));
 	switch (ep->rep_connected) {
 	case 0:
-		rc = rdma_create_qp(ia->ri_id, ia->ri_pd, &qp_init_attr);
-		if (rc) {
-			rc = -ENETUNREACH;
+		rc = -ENETUNREACH;
+		if (rpcrdma_ep_create(r_xprt, ia->ri_id))
 			goto out_noupdate;
-		}
 		break;
 	case -ENODEV:
-		rc = rpcrdma_ep_recreate_xprt(r_xprt, &qp_init_attr);
+		rc = rpcrdma_ep_recreate_xprt(r_xprt);
 		if (rc)
 			goto out_noupdate;
 		break;
+	case 1:
+		rpcrdma_ep_disconnect(ep, ia);
+		/* fall through */
 	default:
-		rc = rpcrdma_ep_reconnect(r_xprt, &qp_init_attr);
+		rc = rpcrdma_ep_reconnect(r_xprt);
 		if (rc)
 			goto out;
 	}
@@ -742,10 +695,14 @@ static int rpcrdma_ep_reconnect(struct rpcrdma_xprt *r_xprt,
 {
 	struct rpcrdma_xprt *r_xprt = container_of(ep, struct rpcrdma_xprt,
 						   rx_ep);
+	struct rdma_cm_id *id = ia->ri_id;
 	int rc;
 
+	if (!id)
+		goto out;
+
 	/* returns without wait if ID is not connected */
-	rc = rdma_disconnect(ia->ri_id);
+	rc = rdma_disconnect(id);
 	if (!rc)
 		wait_event_interruptible(ep->rep_connect_wait,
 							ep->rep_connected != 1);
@@ -753,10 +710,14 @@ static int rpcrdma_ep_reconnect(struct rpcrdma_xprt *r_xprt,
 		ep->rep_connected = rc;
 	trace_xprtrdma_disconnect(r_xprt, rc);
 
-	rpcrdma_xprt_drain(r_xprt);
+	if (id->qp)
+		rpcrdma_xprt_drain(r_xprt);
+out:
 	rpcrdma_reqs_reset(r_xprt);
 	rpcrdma_mrs_destroy(r_xprt);
 	rpcrdma_sendctxs_destroy(r_xprt);
+
+	rpcrdma_ep_destroy(r_xprt);
 }
 
 /* Fixed-size circular FIFO queue. This implementation is wait-free and
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 37d5080c250b..9a536319557e 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -464,8 +464,6 @@ struct rpcrdma_xprt {
 /*
  * Endpoint calls - xprtrdma/verbs.c
  */
-int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt);
-void rpcrdma_ep_destroy(struct rpcrdma_xprt *r_xprt);
 int rpcrdma_ep_connect(struct rpcrdma_ep *, struct rpcrdma_ia *);
 void rpcrdma_ep_disconnect(struct rpcrdma_ep *, struct rpcrdma_ia *);
 

