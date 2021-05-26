Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C6B3915AB
	for <lists+linux-nfs@lfdr.de>; Wed, 26 May 2021 13:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbhEZLDy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 May 2021 07:03:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234060AbhEZLDx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 26 May 2021 07:03:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D8DE6108D
        for <linux-nfs@vger.kernel.org>; Wed, 26 May 2021 11:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622026942;
        bh=xlrt19UqMBm/Zec+p4sfPI8NoGd5wUUQGNPO1DYfz2g=;
        h=From:To:Subject:Date:From;
        b=Bt2VMJFCtY0GGiZR63ffiyeV+QLitgtQaa8SBq7A2PeGPG2wdp02Ll2ln30QrfgC/
         LtfOm/1pS9WAi5LiuO2OA185v9IZcd9GbraQSNLIJZqt7wI+1JwMDQUYL7ZZOAyjWg
         s3MN8Q7kiXcPhY/PpchBMXJzNmUnWewMGeqoVVNWDuw2panH9ucCFcAQZP3yz5VXXY
         w2eRSzCPWXSgxcV2ArEqC+PzEcyu+/LGPgtq6YSix5c9iTRIOE6bbU6Bd7lBaJE6PZ
         FPVc/vwK/tA4ld7UlRYdBbh8/FB3jTg+hUfKYvyEhA5mnYcB2SND2mXljgid9Aabi0
         i5NDsGxT2OSgg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] SUNRPC: More fixes for backlog congestion
Date:   Wed, 26 May 2021 07:02:21 -0400
Message-Id: <20210526110221.338870-1-trondmy@kernel.org>
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
v2: Ensure we release the RDMA reply buffer

 include/linux/sunrpc/xprt.h     |  2 ++
 net/sunrpc/xprt.c               | 58 ++++++++++++++++-----------------
 net/sunrpc/xprtrdma/transport.c | 12 +++----
 net/sunrpc/xprtrdma/verbs.c     | 18 ++++++++--
 net/sunrpc/xprtrdma/xprt_rdma.h |  1 +
 5 files changed, 52 insertions(+), 39 deletions(-)

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
index 09953597d055..19a49d26b1e4 100644
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
@@ -537,10 +536,11 @@ xprt_rdma_free_slot(struct rpc_xprt *xprt, struct rpc_rqst *rqst)
 	struct rpcrdma_xprt *r_xprt =
 		container_of(xprt, struct rpcrdma_xprt, rx_xprt);
 
-	memset(rqst, 0, sizeof(*rqst));
-	rpcrdma_buffer_put(&r_xprt->rx_buf, rpcr_to_rdmar(rqst));
-	if (unlikely(!rpc_wake_up_next(&xprt->backlog)))
-		clear_bit(XPRT_CONGESTED, &xprt->state);
+	rpcrdma_reply_put(&r_xprt->rx_buf, rpcr_to_rdmar(rqst));
+	if (!xprt_wake_up_backlog(xprt, rqst)) {
+		memset(rqst, 0, sizeof(*rqst));
+		rpcrdma_buffer_put(&r_xprt->rx_buf, rpcr_to_rdmar(rqst));
+	}
 }
 
 static bool rpcrdma_check_regbuf(struct rpcrdma_xprt *r_xprt,
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 1e965a380896..649c23518ec0 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1200,6 +1200,20 @@ rpcrdma_mr_get(struct rpcrdma_xprt *r_xprt)
 	return mr;
 }
 
+/**
+ * rpcrdma_reply_put - Put reply buffers back into pool
+ * @buffers: buffer pool
+ * @req: object to return
+ *
+ */
+void rpcrdma_reply_put(struct rpcrdma_buffer *buffers, struct rpcrdma_req *req)
+{
+	if (req->rl_reply) {
+		rpcrdma_rep_put(buffers, req->rl_reply);
+		req->rl_reply = NULL;
+	}
+}
+
 /**
  * rpcrdma_buffer_get - Get a request buffer
  * @buffers: Buffer pool from which to obtain a buffer
@@ -1228,9 +1242,7 @@ rpcrdma_buffer_get(struct rpcrdma_buffer *buffers)
  */
 void rpcrdma_buffer_put(struct rpcrdma_buffer *buffers, struct rpcrdma_req *req)
 {
-	if (req->rl_reply)
-		rpcrdma_rep_put(buffers, req->rl_reply);
-	req->rl_reply = NULL;
+	rpcrdma_reply_put(buffers, req);
 
 	spin_lock(&buffers->rb_lock);
 	list_add(&req->rl_list, &buffers->rb_send_bufs);
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 436ad7312614..5d231d94e944 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -479,6 +479,7 @@ struct rpcrdma_req *rpcrdma_buffer_get(struct rpcrdma_buffer *);
 void rpcrdma_buffer_put(struct rpcrdma_buffer *buffers,
 			struct rpcrdma_req *req);
 void rpcrdma_rep_put(struct rpcrdma_buffer *buf, struct rpcrdma_rep *rep);
+void rpcrdma_reply_put(struct rpcrdma_buffer *buffers, struct rpcrdma_req *req);
 
 bool rpcrdma_regbuf_realloc(struct rpcrdma_regbuf *rb, size_t size,
 			    gfp_t flags);
-- 
2.31.1

