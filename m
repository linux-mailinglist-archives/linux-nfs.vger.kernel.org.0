Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0384E36497D
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Apr 2021 20:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240519AbhDSSDT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Apr 2021 14:03:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240548AbhDSSDS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Apr 2021 14:03:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84F1661107;
        Mon, 19 Apr 2021 18:02:48 +0000 (UTC)
Subject: [PATCH v3 11/26] xprtrdma: Delete rpcrdma_recv_buffer_put()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Apr 2021 14:02:47 -0400
Message-ID: <161885536773.38598.3850081701796072071.stgit@manet.1015granger.net>
In-Reply-To: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
References: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: The name recv_buffer_put() is a vestige of older code,
and the function is just a wrapper for the newer rpcrdma_rep_put().
In most of the existing call sites, a pointer to the owning
rpcrdma_buffer is already available.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/backchannel.c |    4 +++-
 net/sunrpc/xprtrdma/rpc_rdma.c    |    4 ++--
 net/sunrpc/xprtrdma/verbs.c       |   24 ++++++++----------------
 net/sunrpc/xprtrdma/xprt_rdma.h   |    2 +-
 4 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/net/sunrpc/xprtrdma/backchannel.c b/net/sunrpc/xprtrdma/backchannel.c
index a249837d6a55..1151efd09b27 100644
--- a/net/sunrpc/xprtrdma/backchannel.c
+++ b/net/sunrpc/xprtrdma/backchannel.c
@@ -155,9 +155,11 @@ void xprt_rdma_bc_destroy(struct rpc_xprt *xprt, unsigned int reqs)
 void xprt_rdma_bc_free_rqst(struct rpc_rqst *rqst)
 {
 	struct rpcrdma_req *req = rpcr_to_rdmar(rqst);
+	struct rpcrdma_rep *rep = req->rl_reply;
 	struct rpc_xprt *xprt = rqst->rq_xprt;
+	struct rpcrdma_xprt *r_xprt = rpcx_to_rdmax(xprt);
 
-	rpcrdma_recv_buffer_put(req->rl_reply);
+	rpcrdma_rep_put(&r_xprt->rx_buf, rep);
 	req->rl_reply = NULL;
 
 	spin_lock(&xprt->bc_pa_lock);
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 21ddd78a8c35..be4e888e78a3 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1437,7 +1437,7 @@ void rpcrdma_reply_handler(struct rpcrdma_rep *rep)
 
 	req = rpcr_to_rdmar(rqst);
 	if (unlikely(req->rl_reply))
-		rpcrdma_recv_buffer_put(req->rl_reply);
+		rpcrdma_rep_put(buf, req->rl_reply);
 	req->rl_reply = rep;
 	rep->rr_rqst = rqst;
 
@@ -1465,5 +1465,5 @@ void rpcrdma_reply_handler(struct rpcrdma_rep *rep)
 	trace_xprtrdma_reply_short_err(rep);
 
 out:
-	rpcrdma_recv_buffer_put(rep);
+	rpcrdma_rep_put(buf, rep);
 }
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 5a2871c4561f..098d5c550e9b 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -80,8 +80,6 @@ static void rpcrdma_sendctx_put_locked(struct rpcrdma_xprt *r_xprt,
 				       struct rpcrdma_sendctx *sc);
 static int rpcrdma_reqs_setup(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_reqs_reset(struct rpcrdma_xprt *r_xprt);
-static void rpcrdma_rep_put(struct rpcrdma_buffer *buf,
-			    struct rpcrdma_rep *rep);
 static void rpcrdma_rep_destroy(struct rpcrdma_rep *rep);
 static void rpcrdma_reps_unmap(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt);
@@ -1036,8 +1034,13 @@ static struct rpcrdma_rep *rpcrdma_rep_get_locked(struct rpcrdma_buffer *buf)
 	return llist_entry(node, struct rpcrdma_rep, rr_node);
 }
 
-static void rpcrdma_rep_put(struct rpcrdma_buffer *buf,
-			    struct rpcrdma_rep *rep)
+/**
+ * rpcrdma_rep_put - Release rpcrdma_rep back to free list
+ * @buf: buffer pool
+ * @rep: rep to release
+ *
+ */
+void rpcrdma_rep_put(struct rpcrdma_buffer *buf, struct rpcrdma_rep *rep)
 {
 	llist_add(&rep->rr_node, &buf->rb_free_reps);
 }
@@ -1252,17 +1255,6 @@ void rpcrdma_buffer_put(struct rpcrdma_buffer *buffers, struct rpcrdma_req *req)
 	spin_unlock(&buffers->rb_lock);
 }
 
-/**
- * rpcrdma_recv_buffer_put - Release rpcrdma_rep back to free list
- * @rep: rep to release
- *
- * Used after error conditions.
- */
-void rpcrdma_recv_buffer_put(struct rpcrdma_rep *rep)
-{
-	rpcrdma_rep_put(&rep->rr_rxprt->rx_buf, rep);
-}
-
 /* Returns a pointer to a rpcrdma_regbuf object, or NULL.
  *
  * xprtrdma uses a regbuf for posting an outgoing RDMA SEND, or for
@@ -1455,7 +1447,7 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool temp)
 
 			rep = container_of(wr, struct rpcrdma_rep, rr_recv_wr);
 			wr = wr->next;
-			rpcrdma_recv_buffer_put(rep);
+			rpcrdma_rep_put(buf, rep);
 			--count;
 		}
 	}
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 2504f67af63e..9c5039d4634a 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -481,7 +481,7 @@ void rpcrdma_mrs_refresh(struct rpcrdma_xprt *r_xprt);
 struct rpcrdma_req *rpcrdma_buffer_get(struct rpcrdma_buffer *);
 void rpcrdma_buffer_put(struct rpcrdma_buffer *buffers,
 			struct rpcrdma_req *req);
-void rpcrdma_recv_buffer_put(struct rpcrdma_rep *);
+void rpcrdma_rep_put(struct rpcrdma_buffer *buf, struct rpcrdma_rep *rep);
 
 bool rpcrdma_regbuf_realloc(struct rpcrdma_regbuf *rb, size_t size,
 			    gfp_t flags);


