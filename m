Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D8D364986
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Apr 2021 20:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240566AbhDSSDw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Apr 2021 14:03:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240553AbhDSSDu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Apr 2021 14:03:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9EE361001;
        Mon, 19 Apr 2021 18:03:19 +0000 (UTC)
Subject: [PATCH v3 16/26] xprtrdma: Do not wake RPC consumer on a failed
 LocalInv
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Apr 2021 14:03:19 -0400
Message-ID: <161885539919.38598.16197910600306542657.stgit@manet.1015granger.net>
In-Reply-To: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
References: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Throw away any reply where the LocalInv flushes or could not be
posted. The registered memory region is in an unknown state until
the disconnect completes.

rpcrdma_xprt_disconnect() will find and release the MR. No need to
put it back on the MR free list in this case.

The client retransmits pending RPC requests once it reestablishes a
fresh connection, so a replacement reply should be forthcoming on
the next connection instance.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |   17 +++++++++++------
 net/sunrpc/xprtrdma/rpc_rdma.c  |   32 +++++++++++++++++++++++++++++---
 net/sunrpc/xprtrdma/xprt_rdma.h |    1 +
 3 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 27087dc8ba3c..951ae20485f3 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -576,10 +576,14 @@ static void frwr_wc_localinv_done(struct ib_cq *cq, struct ib_wc *wc)
 	rep = mr->mr_req->rl_reply;
 	smp_rmb();
 
-	frwr_mr_done(wc, mr);
+	if (wc->status != IB_WC_SUCCESS) {
+		if (rep)
+			rpcrdma_unpin_rqst(rep);
+		rpcrdma_flush_disconnect(cq->cq_context, wc);
+		return;
+	}
+	frwr_mr_put(mr);
 	rpcrdma_complete_rqst(rep);
-
-	rpcrdma_flush_disconnect(cq->cq_context, wc);
 }
 
 /**
@@ -645,8 +649,9 @@ void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	trace_xprtrdma_post_linv_err(req, rc);
 
 	/* The final LOCAL_INV WR in the chain is supposed to
-	 * do the wake. If it was never posted, the wake will
-	 * not happen, so wake here in that case.
+	 * do the wake. If it was never posted, the wake does
+	 * not happen. Unpin the rqst in preparation for its
+	 * retransmission.
 	 */
-	rpcrdma_complete_rqst(req->rl_reply);
+	rpcrdma_unpin_rqst(req->rl_reply);
 }
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index be4e888e78a3..649f7d8b9733 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1326,9 +1326,35 @@ rpcrdma_decode_error(struct rpcrdma_xprt *r_xprt, struct rpcrdma_rep *rep,
 	return -EIO;
 }
 
-/* Perform XID lookup, reconstruction of the RPC reply, and
- * RPC completion while holding the transport lock to ensure
- * the rep, rqst, and rq_task pointers remain stable.
+/**
+ * rpcrdma_unpin_rqst - Release rqst without completing it
+ * @rep: RPC/RDMA Receive context
+ *
+ * This is done when a connection is lost so that a Reply
+ * can be dropped and its matching Call can be subsequently
+ * retransmitted on a new connection.
+ */
+void rpcrdma_unpin_rqst(struct rpcrdma_rep *rep)
+{
+	struct rpc_xprt *xprt = &rep->rr_rxprt->rx_xprt;
+	struct rpc_rqst *rqst = rep->rr_rqst;
+	struct rpcrdma_req *req = rpcr_to_rdmar(rqst);
+
+	req->rl_reply = NULL;
+	rep->rr_rqst = NULL;
+
+	spin_lock(&xprt->queue_lock);
+	xprt_unpin_rqst(rqst);
+	spin_unlock(&xprt->queue_lock);
+}
+
+/**
+ * rpcrdma_complete_rqst - Pass completed rqst back to RPC
+ * @rep: RPC/RDMA Receive context
+ *
+ * Reconstruct the RPC reply and complete the transaction
+ * while @rqst is still pinned to ensure the rep, rqst, and
+ * rq_task pointers remain stable.
  */
 void rpcrdma_complete_rqst(struct rpcrdma_rep *rep)
 {
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 1b187d1dee8a..bb8aba390b88 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -561,6 +561,7 @@ int rpcrdma_marshal_req(struct rpcrdma_xprt *r_xprt, struct rpc_rqst *rqst);
 void rpcrdma_set_max_header_sizes(struct rpcrdma_ep *ep);
 void rpcrdma_reset_cwnd(struct rpcrdma_xprt *r_xprt);
 void rpcrdma_complete_rqst(struct rpcrdma_rep *rep);
+void rpcrdma_unpin_rqst(struct rpcrdma_rep *rep);
 void rpcrdma_reply_handler(struct rpcrdma_rep *rep);
 
 static inline void rpcrdma_set_xdrlen(struct xdr_buf *xdr, size_t len)


