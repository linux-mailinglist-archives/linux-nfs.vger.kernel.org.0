Return-Path: <linux-nfs+bounces-3060-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9730C8B5DA4
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 17:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7C61C21DBC
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 15:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B975B82C8E;
	Mon, 29 Apr 2024 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qc0SD1Vt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E6682899;
	Mon, 29 Apr 2024 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404344; cv=none; b=miOxgg5jOqjsWDzFzeqx3cpuoCv9zqPM1W9R2eziKF0fU+dWGsZ+4i0IisHJDx+0aDBbizN5G5SfDTFkECYvy1r5tCZR1KKBYEKK3Fj17hU71L2JnqQSh/c8auFahtg9/xjqJ7ou02K0drJoDx6WGlsBTVAQDxKI8SkgdBrt3h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404344; c=relaxed/simple;
	bh=SBTI5/HIEyy11LCUlDCzM8NfKdiPa85kJMeTkvD+bHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZ2XwiR9zo6PMJxX+Fu6eh6VDba3hGRyvnFStxfMs1NJNomh+CXNbfxq6/ACtmhIgxrpTyG4NxvF9emyzYgb3mFJ4jKc5Jc07DdKNdP3RXJoht9SrfLktJk3t+r6YewCJSXt85y99PCWQqkn1O9wQ3ZGb+cwT0Df4Mfs93vJFSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qc0SD1Vt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D247FC116B1;
	Mon, 29 Apr 2024 15:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714404344;
	bh=SBTI5/HIEyy11LCUlDCzM8NfKdiPa85kJMeTkvD+bHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qc0SD1VtRGa6pDnFuq0SBfXZ3cMgmEPMqgl6xhcRaYbQR6t9Le9xEHl5LsXG/0+HJ
	 XHTbrhlPHmaVVUdGkGAQ3QTdqzxfViJZOQJlxG1aSg4+TYRACX+sx5TqvhENGoAnce
	 hh1QTULR359HJ6gGcuN0SskxA7muDaDDFGDgJF1Npg20Du3IXq+U6BDtEjrhk+MXb2
	 b9DoU6DLQMLFiV8hy0ibWilv/ObAnUSoSGbkBzc1WfryeADwSSJE/q1gY4T8KXymFE
	 Hr9PAmCkod5eazis8d7uPIcdpl/bCvoGaajOA7/mFbpUel2cqmhty+mD6lQGi/gfKB
	 tyHhqTq6rp/9A==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 1/4] xprtrdma: Remove temp allocation of rpcrdma_rep objects
Date: Mon, 29 Apr 2024 11:25:39 -0400
Message-ID: <20240429152537.212958-7-cel@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429152537.212958-6-cel@kernel.org>
References: <20240429152537.212958-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8024; i=chuck.lever@oracle.com; h=from:subject; bh=WT9JnHTpv+JT0VdzN6n3GQ5CG6EnAUnEZK9i4sSYjWE=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmL7vxZkNcn7DWsYB4s+m0yfgWtAvqqIpxe8fa/ P4qZJEqE06JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZi+78QAKCRAzarMzb2Z/ l1qiEACZuqE/x5goHCMz7Z4V5sa/tpkJ5pE4k8uwYQheDI20aR/i8hE3nzF4RxH7oXUyTqau5n3 ClfMSfixhn82ROo6UaOT/e+ksmTfCqSCamohnWIm5/YmpyEIg5cIVKy1gW9m/sBzchI3J4W0ic8 YMj+DJSO+dBN206Bx2rs7F3iWlRRuPrlF6Z5YuoaOF3/NFSldeZhF+jG67kxJ2LB4qyokNuDnYD 0mW9KVxtfJejGVVEeST8/eQ6FVeDkZVZJoGhmnZXfYRH6tjU5eDY4KjQIOWjTX2cY2jQ10Ku4Fg rfpK///O4KUGLddckkjnMgZ/uJiO0vi/6sJ2OCzk6hy/zyT12Nfot3rUHB+TnkjmSHlG59xnWF4 VgsmXaZBXZZL4EI4o0WMICsgHAXSCZBhmaBLYELWoqHLOAndF1wM9GhZSICL2s9mzYFtP1sFbFO uIyf5IS/NanSarmWc/NIhA6jTpND/buEEVbpnkDaFqs1DoAfS0vtvP3BgaXjSk7lv9o3X7g98Z4 cEKs62zeYCDPn6S2nfUtpg2yi96Cnsc9ee15BGGUKcgId5XisElsitqui7/CVS8rfnIYkhfgaTv X23OK/6TwWKZrzMj2FEq5pwXzIA+hLas4sRF4eCFNzu062y/O83L6nr6ZSUBjolIVWMs2b/hg5W 1pjgRUMdNOroGaw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The original code was designed so that most calls to
rpcrdma_rep_create() would occur on the NUMA node that the device
preferred. There are a few cases where that's not possible, so
those reps are marked as temporary.

However, we have the device (and its preferred node) already in
rpcrdma_rep_create(), so let's use that.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c  |  3 +-
 net/sunrpc/xprtrdma/verbs.c     | 57 ++++++++++++++-------------------
 net/sunrpc/xprtrdma/xprt_rdma.h |  3 +-
 3 files changed, 26 insertions(+), 37 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 190a4de239c8..1478c41c7e9d 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1471,8 +1471,7 @@ void rpcrdma_reply_handler(struct rpcrdma_rep *rep)
 		credits = 1;	/* don't deadlock */
 	else if (credits > r_xprt->rx_ep->re_max_requests)
 		credits = r_xprt->rx_ep->re_max_requests;
-	rpcrdma_post_recvs(r_xprt, credits + (buf->rb_bc_srv_max_requests << 1),
-			   false);
+	rpcrdma_post_recvs(r_xprt, credits + (buf->rb_bc_srv_max_requests << 1));
 	if (buf->rb_credits != credits)
 		rpcrdma_update_cwnd(r_xprt, credits);
 
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 4f8d7efa469f..c6d9d94c28ba 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -69,13 +69,15 @@ static void rpcrdma_sendctx_put_locked(struct rpcrdma_xprt *r_xprt,
 				       struct rpcrdma_sendctx *sc);
 static int rpcrdma_reqs_setup(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_reqs_reset(struct rpcrdma_xprt *r_xprt);
-static void rpcrdma_rep_destroy(struct rpcrdma_rep *rep);
 static void rpcrdma_reps_unmap(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_mrs_destroy(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_ep_get(struct rpcrdma_ep *ep);
 static int rpcrdma_ep_put(struct rpcrdma_ep *ep);
 static struct rpcrdma_regbuf *
+rpcrdma_regbuf_alloc_node(size_t size, enum dma_data_direction direction,
+			  int node);
+static struct rpcrdma_regbuf *
 rpcrdma_regbuf_alloc(size_t size, enum dma_data_direction direction);
 static void rpcrdma_regbuf_dma_unmap(struct rpcrdma_regbuf *rb);
 static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb);
@@ -501,7 +503,7 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
 	 * outstanding Receives.
 	 */
 	rpcrdma_ep_get(ep);
-	rpcrdma_post_recvs(r_xprt, 1, true);
+	rpcrdma_post_recvs(r_xprt, 1);
 
 	rc = rdma_connect(ep->re_id, &ep->re_remote_cma);
 	if (rc)
@@ -920,18 +922,20 @@ static void rpcrdma_reqs_reset(struct rpcrdma_xprt *r_xprt)
 }
 
 static noinline
-struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
-				       bool temp)
+struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt)
 {
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
+	struct rpcrdma_ep *ep = r_xprt->rx_ep;
+	struct ib_device *device = ep->re_id->device;
 	struct rpcrdma_rep *rep;
 
 	rep = kzalloc(sizeof(*rep), XPRTRDMA_GFP_FLAGS);
 	if (rep == NULL)
 		goto out;
 
-	rep->rr_rdmabuf = rpcrdma_regbuf_alloc(r_xprt->rx_ep->re_inline_recv,
-					       DMA_FROM_DEVICE);
+	rep->rr_rdmabuf = rpcrdma_regbuf_alloc_node(ep->re_inline_recv,
+						    DMA_FROM_DEVICE,
+						    ibdev_to_node(device));
 	if (!rep->rr_rdmabuf)
 		goto out_free;
 
@@ -946,7 +950,6 @@ struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
 	rep->rr_recv_wr.wr_cqe = &rep->rr_cqe;
 	rep->rr_recv_wr.sg_list = &rep->rr_rdmabuf->rg_iov;
 	rep->rr_recv_wr.num_sge = 1;
-	rep->rr_temp = temp;
 
 	spin_lock(&buf->rb_lock);
 	list_add(&rep->rr_all, &buf->rb_all_reps);
@@ -965,17 +968,6 @@ static void rpcrdma_rep_free(struct rpcrdma_rep *rep)
 	kfree(rep);
 }
 
-static void rpcrdma_rep_destroy(struct rpcrdma_rep *rep)
-{
-	struct rpcrdma_buffer *buf = &rep->rr_rxprt->rx_buf;
-
-	spin_lock(&buf->rb_lock);
-	list_del(&rep->rr_all);
-	spin_unlock(&buf->rb_lock);
-
-	rpcrdma_rep_free(rep);
-}
-
 static struct rpcrdma_rep *rpcrdma_rep_get_locked(struct rpcrdma_buffer *buf)
 {
 	struct llist_node *node;
@@ -1007,10 +999,8 @@ static void rpcrdma_reps_unmap(struct rpcrdma_xprt *r_xprt)
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_rep *rep;
 
-	list_for_each_entry(rep, &buf->rb_all_reps, rr_all) {
+	list_for_each_entry(rep, &buf->rb_all_reps, rr_all)
 		rpcrdma_regbuf_dma_unmap(rep->rr_rdmabuf);
-		rep->rr_temp = true;	/* Mark this rep for destruction */
-	}
 }
 
 static void rpcrdma_reps_destroy(struct rpcrdma_buffer *buf)
@@ -1227,14 +1217,15 @@ void rpcrdma_buffer_put(struct rpcrdma_buffer *buffers, struct rpcrdma_req *req)
  * or Replies they may be registered externally via frwr_map.
  */
 static struct rpcrdma_regbuf *
-rpcrdma_regbuf_alloc(size_t size, enum dma_data_direction direction)
+rpcrdma_regbuf_alloc_node(size_t size, enum dma_data_direction direction,
+			  int node)
 {
 	struct rpcrdma_regbuf *rb;
 
-	rb = kmalloc(sizeof(*rb), XPRTRDMA_GFP_FLAGS);
+	rb = kmalloc_node(sizeof(*rb), XPRTRDMA_GFP_FLAGS, node);
 	if (!rb)
 		return NULL;
-	rb->rg_data = kmalloc(size, XPRTRDMA_GFP_FLAGS);
+	rb->rg_data = kmalloc_node(size, XPRTRDMA_GFP_FLAGS, node);
 	if (!rb->rg_data) {
 		kfree(rb);
 		return NULL;
@@ -1246,6 +1237,12 @@ rpcrdma_regbuf_alloc(size_t size, enum dma_data_direction direction)
 	return rb;
 }
 
+static struct rpcrdma_regbuf *
+rpcrdma_regbuf_alloc(size_t size, enum dma_data_direction direction)
+{
+	return rpcrdma_regbuf_alloc_node(size, direction, NUMA_NO_NODE);
+}
+
 /**
  * rpcrdma_regbuf_realloc - re-allocate a SEND/RECV buffer
  * @rb: regbuf to reallocate
@@ -1323,10 +1320,9 @@ static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb)
  * rpcrdma_post_recvs - Refill the Receive Queue
  * @r_xprt: controlling transport instance
  * @needed: current credit grant
- * @temp: mark Receive buffers to be deleted after one use
  *
  */
-void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool temp)
+void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed)
 {
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_ep *ep = r_xprt->rx_ep;
@@ -1340,8 +1336,7 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool temp)
 	if (likely(ep->re_receive_count > needed))
 		goto out;
 	needed -= ep->re_receive_count;
-	if (!temp)
-		needed += RPCRDMA_MAX_RECV_BATCH;
+	needed += RPCRDMA_MAX_RECV_BATCH;
 
 	if (atomic_inc_return(&ep->re_receiving) > 1)
 		goto out;
@@ -1350,12 +1345,8 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool temp)
 	wr = NULL;
 	while (needed) {
 		rep = rpcrdma_rep_get_locked(buf);
-		if (rep && rep->rr_temp) {
-			rpcrdma_rep_destroy(rep);
-			continue;
-		}
 		if (!rep)
-			rep = rpcrdma_rep_create(r_xprt, temp);
+			rep = rpcrdma_rep_create(r_xprt);
 		if (!rep)
 			break;
 		if (!rpcrdma_regbuf_dma_map(r_xprt, rep->rr_rdmabuf)) {
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index da409450dfc0..08bda29ed953 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -198,7 +198,6 @@ struct rpcrdma_rep {
 	__be32			rr_proc;
 	int			rr_wc_flags;
 	u32			rr_inv_rkey;
-	bool			rr_temp;
 	struct rpcrdma_regbuf	*rr_rdmabuf;
 	struct rpcrdma_xprt	*rr_rxprt;
 	struct rpc_rqst		*rr_rqst;
@@ -466,7 +465,7 @@ void rpcrdma_flush_disconnect(struct rpcrdma_xprt *r_xprt, struct ib_wc *wc);
 int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt);
 void rpcrdma_xprt_disconnect(struct rpcrdma_xprt *r_xprt);
 
-void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool temp);
+void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed);
 
 /*
  * Buffer calls - xprtrdma/verbs.c
-- 
2.44.0


