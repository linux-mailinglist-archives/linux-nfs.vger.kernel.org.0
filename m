Return-Path: <linux-nfs+bounces-3549-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516A38FBCBF
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 21:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73AB11C22048
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 19:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F6313E88B;
	Tue,  4 Jun 2024 19:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4D20+lz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F627372
	for <linux-nfs@vger.kernel.org>; Tue,  4 Jun 2024 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717530364; cv=none; b=tdhtc6J4i1duqTsnpuVFdbgPNx25Z/xiDrnBi7bU7/u4O67C+b3qKnZtUnzBLARE0CUysB9GK5Q2HCRlQS+vItib601kc8ypV+taNrDYwo9si0MVYjken2JXeo0myMyeYaHsLbhrJeZo09zzX4oCx9VIHXtWBPV2q3b4jmFT/3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717530364; c=relaxed/simple;
	bh=T2/IdJWwy+XEhDObzFebo9E1rinfU8oQ+aELTr1pF7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aEWoqiVSAMKipvvOt7TD9nl3L8hCYhFvjzekYSCnR5VhH0Xi10x0qGt5MUdpoSwrY2TutMJSkQCY9zV5ousx/OUsUgVJcYDWtqAN4RSoQVW9KV5XpDHaEihiomzJO3xuzDwViF/ztTjk0Ck0DmY42jIpoocWhSdUlfHYs/f6JlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4D20+lz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2909CC32782;
	Tue,  4 Jun 2024 19:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717530363;
	bh=T2/IdJWwy+XEhDObzFebo9E1rinfU8oQ+aELTr1pF7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T4D20+lzhCRmlMkB9JOipulRcnS8jhTxGDMi5GIhbeGIDBq/PHm6MEn5g4H7Vwnlg
	 nus1+mOLChUsCKvAqSrPLdoCSIrrYXNOY13WcJTAS1zZPtTgBritztoRarSXddyty8
	 AmJ7bUD/S//A+4fTnNZPOXl6b31xd5dQ/QEnq/JghupykLytSgwq9M2HMnpmJ9GqU6
	 lkwtQDgGeS5cbhvSaqhkxPTwTj7CWyTEDH8ixIUi5jQ97NApb+sQKJhgj55JlqfFkZ
	 kHgaeM42rT5nIZdEo8oJ+KuzwS54AeRnUqZK0wGQViId+oMLGiP0bzlZyZcOHzbm33
	 dk6HoO76Y+h+Q==
From: cel@kernel.org
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5/5] xprtrdma: Remove temp allocation of rpcrdma_rep objects
Date: Tue,  4 Jun 2024 15:45:27 -0400
Message-ID: <20240604194522.10390-10-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604194522.10390-6-cel@kernel.org>
References: <20240604194522.10390-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8085; i=chuck.lever@oracle.com; h=from:subject; bh=OomxY48fgJGqLDrBcl8N07rZ8h9bmtJbaqTSN0km27o=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmX27gT1QIAwRvFYi9mu24uwT1GmeW/aqKY7WsP +TD+/n5immJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZl9u4AAKCRAzarMzb2Z/ l2UKEACO8AdqiizL62SXXrFl1Z8vmRd5cwiZ0OfVD4kyrwrFFGPlvfJ8ivkN4PrA0+VtgJ3zfhq 8E4OAiQB1+UhSeBsmp4BiHi/bJH5wnfG4gnmQYDRKi57ayqGlNQULQQZ9aAPQqY6VJiannCKMWo 3DQSRgnEuA3GW6osV9AAsKGfYdiHuIqQccoR/RUHNtwvRsqqGQ/tjaqMF9QkKD+XPU2bt4BZ2DB zt2v1OxiLc0kybtbnNFJlxpvYmZsr3QbZS4z6hHu2esJckt16CAcDdlMe0AI/Xpgku9dpClpbHB IbpRBCB52u8w94OHdMvMC86hGvXcXNPlTBDSgEJRBeLERUYrCUcf2aMmzQiNDd8HeQKxrDgjA7Y ySxSvK6wfOWx3413nl+AZnPrIj3DuobSnYsydWXCAVfPBXE52qHflLX5WAYH8quE5iUd9U6g6CI whA/izSB1ULDi9+JZM43x4mYFIvOZK8raqRD/718kTQzUmhxzm8pSBs9jeq11YDTcCMVSMwv5sP 2TxU1cDd2rBQ9uICo8VHcC96rcdz7HS2rGZPTNQLyqSIE4Rjt3//nF+zagX1enrmlPPV2tiLWdi Howw3JJfNoIjc5j/EXHihzKF51n9yIYy+FeEYM/deEkZF5jW/m56509u6GGXAR6uuVQ7+ldg1RO ahqEQxDaKaocymg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The original code was designed so that most calls to
rpcrdma_rep_create() would occur on the NUMA node that the device
preferred. There are a few cases where that's not possible, so
those reps are marked as temporary.

However, we have the device (and its preferred node) already in
rpcrdma_rep_create(), so let's use that to guarantee the memory
is allocated from the correct node.

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
index 04558c99e9f4..110933745e5d 100644
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
@@ -510,7 +512,7 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
 	 * outstanding Receives.
 	 */
 	rpcrdma_ep_get(ep);
-	rpcrdma_post_recvs(r_xprt, 1, true);
+	rpcrdma_post_recvs(r_xprt, 1);
 
 	rc = rdma_connect(ep->re_id, &ep->re_remote_cma);
 	if (rc)
@@ -943,18 +945,20 @@ static void rpcrdma_reqs_reset(struct rpcrdma_xprt *r_xprt)
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
 
@@ -969,7 +973,6 @@ struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
 	rep->rr_recv_wr.wr_cqe = &rep->rr_cqe;
 	rep->rr_recv_wr.sg_list = &rep->rr_rdmabuf->rg_iov;
 	rep->rr_recv_wr.num_sge = 1;
-	rep->rr_temp = temp;
 
 	spin_lock(&buf->rb_lock);
 	list_add(&rep->rr_all, &buf->rb_all_reps);
@@ -988,17 +991,6 @@ static void rpcrdma_rep_free(struct rpcrdma_rep *rep)
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
@@ -1030,10 +1022,8 @@ static void rpcrdma_reps_unmap(struct rpcrdma_xprt *r_xprt)
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_rep *rep;
 
-	list_for_each_entry(rep, &buf->rb_all_reps, rr_all) {
+	list_for_each_entry(rep, &buf->rb_all_reps, rr_all)
 		rpcrdma_regbuf_dma_unmap(rep->rr_rdmabuf);
-		rep->rr_temp = true;	/* Mark this rep for destruction */
-	}
 }
 
 static void rpcrdma_reps_destroy(struct rpcrdma_buffer *buf)
@@ -1250,14 +1240,15 @@ void rpcrdma_buffer_put(struct rpcrdma_buffer *buffers, struct rpcrdma_req *req)
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
@@ -1269,6 +1260,12 @@ rpcrdma_regbuf_alloc(size_t size, enum dma_data_direction direction)
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
@@ -1346,10 +1343,9 @@ static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb)
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
@@ -1363,8 +1359,7 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool temp)
 	if (likely(ep->re_receive_count > needed))
 		goto out;
 	needed -= ep->re_receive_count;
-	if (!temp)
-		needed += RPCRDMA_MAX_RECV_BATCH;
+	needed += RPCRDMA_MAX_RECV_BATCH;
 
 	if (atomic_inc_return(&ep->re_receiving) > 1)
 		goto out;
@@ -1373,12 +1368,8 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool temp)
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
index 341725c66ec8..8147d2b41494 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -200,7 +200,6 @@ struct rpcrdma_rep {
 	__be32			rr_proc;
 	int			rr_wc_flags;
 	u32			rr_inv_rkey;
-	bool			rr_temp;
 	struct rpcrdma_regbuf	*rr_rdmabuf;
 	struct rpcrdma_xprt	*rr_rxprt;
 	struct rpc_rqst		*rr_rqst;
@@ -468,7 +467,7 @@ void rpcrdma_flush_disconnect(struct rpcrdma_xprt *r_xprt, struct ib_wc *wc);
 int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt);
 void rpcrdma_xprt_disconnect(struct rpcrdma_xprt *r_xprt);
 
-void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool temp);
+void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed);
 
 /*
  * Buffer calls - xprtrdma/verbs.c
-- 
2.45.1


