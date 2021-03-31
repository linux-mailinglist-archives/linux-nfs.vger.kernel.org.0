Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B040E35077F
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Mar 2021 21:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbhCaThB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 15:37:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235933AbhCaTgm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 31 Mar 2021 15:36:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 780826101E;
        Wed, 31 Mar 2021 19:36:42 +0000 (UTC)
Subject: [PATCH v1 7/8] xprtrdma: Fix cwnd update ordering
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 31 Mar 2021 15:36:41 -0400
Message-ID: <161721940170.515226.389858159579607870.stgit@manet.1015granger.net>
In-Reply-To: <161721926778.515226.9805598788670386587.stgit@manet.1015granger.net>
References: <161721926778.515226.9805598788670386587.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

After a reconnect, the reply handler is opening the cwnd (and thus
enabling more RPC Calls to be sent) /before/ rpcrdma_post_recvs()
can post enough Receive WRs to receive their replies. This causes an
RNR and the new connection is lost immediately.

The race is most clearly exposed when KASAN and disconnect injection
are enabled. This slows down rpcrdma_rep_create() considerably.

Fixes: 2ae50ad68cd7 ("xprtrdma: Close window between waking RPC senders and posting Receives")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c  |    3 ++-
 net/sunrpc/xprtrdma/verbs.c     |   10 +++++-----
 net/sunrpc/xprtrdma/xprt_rdma.h |    2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 292f066d006e..21ddd78a8c35 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1430,9 +1430,10 @@ void rpcrdma_reply_handler(struct rpcrdma_rep *rep)
 		credits = 1;	/* don't deadlock */
 	else if (credits > r_xprt->rx_ep->re_max_requests)
 		credits = r_xprt->rx_ep->re_max_requests;
+	rpcrdma_post_recvs(r_xprt, credits + (buf->rb_bc_srv_max_requests << 1),
+			   false);
 	if (buf->rb_credits != credits)
 		rpcrdma_update_cwnd(r_xprt, credits);
-	rpcrdma_post_recvs(r_xprt, false);
 
 	req = rpcr_to_rdmar(rqst);
 	if (unlikely(req->rl_reply))
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 2fde805edb64..82489f527ece 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -537,7 +537,7 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
 	 * outstanding Receives.
 	 */
 	rpcrdma_ep_get(ep);
-	rpcrdma_post_recvs(r_xprt, true);
+	rpcrdma_post_recvs(r_xprt, 1, true);
 
 	rc = rdma_connect(ep->re_id, &ep->re_remote_cma);
 	if (rc)
@@ -1388,10 +1388,11 @@ int rpcrdma_post_sends(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 /**
  * rpcrdma_post_recvs - Refill the Receive Queue
  * @r_xprt: controlling transport instance
- * @temp: mark Receive buffers to be deleted after use
+ * @needed: current credit grant
+ * @temp: mark Receive buffers to be deleted after one use
  *
  */
-void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp)
+void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool temp)
 {
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_ep *ep = r_xprt->rx_ep;
@@ -1399,12 +1400,11 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp)
 	struct ib_recv_wr *wr, *bad_wr;
 	struct rpcrdma_rep *rep;
 	struct ib_qp_attr attr;
-	int needed, count, rc;
+	int count, rc;
 
 	rc = 0;
 	count = 0;
 
-	needed = buf->rb_credits + (buf->rb_bc_srv_max_requests << 1);
 	if (likely(ep->re_receive_count > needed))
 		goto out;
 	needed -= ep->re_receive_count;
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index fe3be985e239..28af11fbe643 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -461,7 +461,7 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt);
 void rpcrdma_xprt_disconnect(struct rpcrdma_xprt *r_xprt);
 
 int rpcrdma_post_sends(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req);
-void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp);
+void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool temp);
 
 /*
  * Buffer calls - xprtrdma/verbs.c


