Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD56390F7F
	for <lists+linux-nfs@lfdr.de>; Wed, 26 May 2021 06:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhEZE33 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 May 2021 00:29:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhEZE33 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 26 May 2021 00:29:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 605A661402
        for <linux-nfs@vger.kernel.org>; Wed, 26 May 2021 04:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622003278;
        bh=Q9oUQP1vJGel5PqVddm5L3PF/MjzKGmTdbZekTT1Hok=;
        h=From:To:Subject:Date:From;
        b=h2rt9dRILn57ZaSLrE23pyzq3iOUKGX0D+xa0A57Lqoc4tLz/uCjJF/gdrBbj1Vm1
         uVbze4Fzx2AVRkBbjRVUz64QTYr9fH9H1WGo628Pw5p/D3Nnx+9n34greF/sRV5wPt
         cFzpqP/FYb75DQ8Se0VSNvgi+P+TQh4uSLAQCX/Dp3yOE755cpz1pAGTdb80SOoIUX
         IuuSop+rJc5iEUG0OOUSY6xKOj1qBD0XSZBZ/pP74KMdrM9HFJIMqcA9vfv2AOdI2e
         4o556t6oBvjLEiVm/NQTxmzx6YfC6ahs5IjU5XAw1wAC1/iUioCDoG/yQAn5pgxeVT
         Lhj59oUB1QrfA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: More fixes for backlog congestion
Date:   Wed, 26 May 2021 00:27:57 -0400
Message-Id: <20210526042757.333605-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that we fix the XPRT_CONGESTED starvation issue for RDMA as well
as socket based transports.
Ensure we always initialise the request after waking up from the backlog
list.

Fixes: e877a88d1f06 ("SUNRPC in case of backlog, hand free slots directly to waiting task")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/sunrpc/xprt.h     |  2 ++
 net/sunrpc/xprt.c               | 58 ++++++++++++++++-----------------
 net/sunrpc/xprtrdma/transport.c |  6 ++--
 3 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index d81fe8b364d0..61b622e334ee 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -368,6 +368,8 @@ struct rpc_xprt *	xprt_alloc(struct net *net, size_t size,
 				unsigned int num_prealloc,
 				unsigned int max_req);
 void			xprt_free(struct rpc_xprt *);
+void			xprt_add_backlog(struct rpc_xprt *xprt, struct rpc_task *task);
+bool			xprt_wake_up_backlog(struct rpc_xprt *xprt, struct rpc_rqst *req);
 
 static inline int
 xprt_enable_swap(struct rpc_xprt *xprt)
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 5b3981fd3783..3509a7f139b9 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1607,11 +1607,18 @@ xprt_transmit(struct rpc_task *task)
 	spin_unlock(&xprt->queue_lock);
 }
 
-static void xprt_add_backlog(struct rpc_xprt *xprt, struct rpc_task *task)
+static void xprt_complete_request_init(struct rpc_task *task)
+{
+	if (task->tk_rqstp)
+		xprt_request_init(task);
+}
+
+void xprt_add_backlog(struct rpc_xprt *xprt, struct rpc_task *task)
 {
 	set_bit(XPRT_CONGESTED, &xprt->state);
-	rpc_sleep_on(&xprt->backlog, task, NULL);
+	rpc_sleep_on(&xprt->backlog, task, xprt_complete_request_init);
 }
+EXPORT_SYMBOL_GPL(xprt_add_backlog);
 
 static bool __xprt_set_rq(struct rpc_task *task, void *data)
 {
@@ -1619,14 +1626,13 @@ static bool __xprt_set_rq(struct rpc_task *task, void *data)
 
 	if (task->tk_rqstp == NULL) {
 		memset(req, 0, sizeof(*req));	/* mark unused */
-		task->tk_status = -EAGAIN;
 		task->tk_rqstp = req;
 		return true;
 	}
 	return false;
 }
 
-static bool xprt_wake_up_backlog(struct rpc_xprt *xprt, struct rpc_rqst *req)
+bool xprt_wake_up_backlog(struct rpc_xprt *xprt, struct rpc_rqst *req)
 {
 	if (rpc_wake_up_first(&xprt->backlog, __xprt_set_rq, req) == NULL) {
 		clear_bit(XPRT_CONGESTED, &xprt->state);
@@ -1634,6 +1640,7 @@ static bool xprt_wake_up_backlog(struct rpc_xprt *xprt, struct rpc_rqst *req)
 	}
 	return true;
 }
+EXPORT_SYMBOL_GPL(xprt_wake_up_backlog);
 
 static bool xprt_throttle_congested(struct rpc_xprt *xprt, struct rpc_task *task)
 {
@@ -1643,7 +1650,7 @@ static bool xprt_throttle_congested(struct rpc_xprt *xprt, struct rpc_task *task
 		goto out;
 	spin_lock(&xprt->reserve_lock);
 	if (test_bit(XPRT_CONGESTED, &xprt->state)) {
-		rpc_sleep_on(&xprt->backlog, task, NULL);
+		xprt_add_backlog(xprt, task);
 		ret = true;
 	}
 	spin_unlock(&xprt->reserve_lock);
@@ -1812,10 +1819,6 @@ xprt_request_init(struct rpc_task *task)
 	struct rpc_xprt *xprt = task->tk_xprt;
 	struct rpc_rqst	*req = task->tk_rqstp;
 
-	if (req->rq_task)
-		/* Already initialized */
-		return;
-
 	req->rq_task	= task;
 	req->rq_xprt    = xprt;
 	req->rq_buffer  = NULL;
@@ -1876,10 +1879,8 @@ void xprt_retry_reserve(struct rpc_task *task)
 	struct rpc_xprt *xprt = task->tk_xprt;
 
 	task->tk_status = 0;
-	if (task->tk_rqstp != NULL) {
-		xprt_request_init(task);
+	if (task->tk_rqstp != NULL)
 		return;
-	}
 
 	task->tk_status = -EAGAIN;
 	xprt_do_reserve(xprt, task);
@@ -1904,24 +1905,21 @@ void xprt_release(struct rpc_task *task)
 	}
 
 	xprt = req->rq_xprt;
-	if (xprt) {
-		xprt_request_dequeue_xprt(task);
-		spin_lock(&xprt->transport_lock);
-		xprt->ops->release_xprt(xprt, task);
-		if (xprt->ops->release_request)
-			xprt->ops->release_request(task);
-		xprt_schedule_autodisconnect(xprt);
-		spin_unlock(&xprt->transport_lock);
-		if (req->rq_buffer)
-			xprt->ops->buf_free(task);
-		xdr_free_bvec(&req->rq_rcv_buf);
-		xdr_free_bvec(&req->rq_snd_buf);
-		if (req->rq_cred != NULL)
-			put_rpccred(req->rq_cred);
-		if (req->rq_release_snd_buf)
-			req->rq_release_snd_buf(req);
-	} else
-		xprt = task->tk_xprt;
+	xprt_request_dequeue_xprt(task);
+	spin_lock(&xprt->transport_lock);
+	xprt->ops->release_xprt(xprt, task);
+	if (xprt->ops->release_request)
+		xprt->ops->release_request(task);
+	xprt_schedule_autodisconnect(xprt);
+	spin_unlock(&xprt->transport_lock);
+	if (req->rq_buffer)
+		xprt->ops->buf_free(task);
+	xdr_free_bvec(&req->rq_rcv_buf);
+	xdr_free_bvec(&req->rq_snd_buf);
+	if (req->rq_cred != NULL)
+		put_rpccred(req->rq_cred);
+	if (req->rq_release_snd_buf)
+		req->rq_release_snd_buf(req);
 
 	task->tk_rqstp = NULL;
 	if (likely(!bc_prealloc(req)))
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 09953597d055..4a8f92ef99ae 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -520,9 +520,8 @@ xprt_rdma_alloc_slot(struct rpc_xprt *xprt, struct rpc_task *task)
 	return;
 
 out_sleep:
-	set_bit(XPRT_CONGESTED, &xprt->state);
-	rpc_sleep_on(&xprt->backlog, task, NULL);
 	task->tk_status = -EAGAIN;
+	xprt_add_backlog(xprt, task);
 }
 
 /**
@@ -539,8 +538,7 @@ xprt_rdma_free_slot(struct rpc_xprt *xprt, struct rpc_rqst *rqst)
 
 	memset(rqst, 0, sizeof(*rqst));
 	rpcrdma_buffer_put(&r_xprt->rx_buf, rpcr_to_rdmar(rqst));
-	if (unlikely(!rpc_wake_up_next(&xprt->backlog)))
-		clear_bit(XPRT_CONGESTED, &xprt->state);
+	xprt_wake_up_backlog(xprt, rqst);
 }
 
 static bool rpcrdma_check_regbuf(struct rpcrdma_xprt *r_xprt,
-- 
2.31.1

