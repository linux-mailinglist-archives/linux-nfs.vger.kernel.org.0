Return-Path: <linux-nfs+bounces-21743-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAhrGaT4DWqR5AUAu9opvQ
	(envelope-from <linux-nfs+bounces-21743-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 20:08:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 335D9595602
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 20:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE545305ECB2
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 17:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8933C4576;
	Wed, 20 May 2026 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXgMrW0z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA44F233933
	for <linux-nfs@vger.kernel.org>; Wed, 20 May 2026 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299420; cv=none; b=PpHvSGQVHMJNbixjklZbB0HaZDB2judK0qTWdzzC+zxUYSko53cNsTxNVFoSTgxSV3fhg/ZrXCzVYFoCIdZkOTb08I6tB/1oAfHe3fJ/mwMXweoCn41BonKZmIJfHdOSVFkpQzgfObbF4ppI4xAvdgwzPv93DKyq41loXq/p8Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299420; c=relaxed/simple;
	bh=BabuZuZtvdF74prT0/D18jXnQhT7nJlRP055itkdnJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g7WaZ+r7DlKlcT7PxKEHJOKTpAVXcVj54/ieaBt5SpKNtwjIYs9u42WXrnBnV+1JdGHcgqF3eDL4yvzBk3VDmPVsGy2lLhmR08swU4B5N6NrLrNS71Ylm9QPrYk0wBNLhK8Awa4FMoPtjZBg6RAoOFMA29xKcZzE9hQxuWKgs4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXgMrW0z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527DA1F00894;
	Wed, 20 May 2026 17:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779299418;
	bh=pDcBY212Mx8S23EfwN2Dz0Gj4phJJcsvQbwMB0Goges=;
	h=From:To:Cc:Subject:Date;
	b=QXgMrW0ztTm+n/PKLNq1xGeHofkNL6MenABpk+wPwQU0V4+7ot1ZGleZilYx9SfoK
	 sR8KzipBwJUjh5mBDWoyfXaR/v+i+xT7vE/wZpjnTD0+dWZ382Dn6qYEoNGcxOgeDb
	 RAeS7J/dCK+8cHY7V9wxR4B0tVqf3ePgIoyLXzjyLsOG71KVA2NRuOuftIet0RDgl7
	 l2FttfphaDERb3Djpnz56QXQPKXYnKWkfrUR7BmGxgOBC2i+xlfZIcaA3GEBdhDZ6Z
	 3UigXgUwxhpuJ1R+n5S5m1Rf0Rd8xIIR/WlmQ+mVnlw6o1bV8SGhlSGS4j5lElzeth
	 fzY6lnQwksiuA==
From: Chuck Lever <cel@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] xprtrdma: Decouple RPC completion from Send completion
Date: Wed, 20 May 2026 13:50:16 -0400
Message-ID: <20260520175016.29480-1-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21743-lists,linux-nfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 335D9595602
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

rl_kref currently coordinates RPC completion with both the Send
carrying an RPC Call and the Receive carrying its reply. The
kref_get in the marshal path is conditional on sc_unmap_count, so
a Send carrying only pre-registered buffers takes no Send-side
reference. When the Reply then arrives before the Send completes,
rpcrdma_reply_handler() drops the kref from 1 to 0, freeing the
req for reuse while the HCA may still be DMA-reading from its
send buffer. A retransmission can put different data on the wire.

Forcing a kref_get on every Send is not viable: xprtrdma leaves
most Sends unsignaled, relying on the strong ordering of Send
completions to limit interrupt rate. The sendctx ring releases
each send buffer only on the next signaled completion, not when
each Send is observed on the wire. Unconditionally gating RPC
completion on Send completion deadlocks NFS callers waiting on an
RPC whose Send completion never fires.

Decouple the two instead. The Receive path completes the RPC
immediately without touching rl_kref. rl_kref now gates req
recycling rather than RPC completion. An rpc_rqst owner holds one
reference, and rpcrdma_prepare_send_sges() takes one reference
for the prepared Send. xprt_rdma_free_slot() or
xprt_rdma_bc_free_rqst() drops the RPC-layer reference, and
rpcrdma_sendctx_unmap() drops the Send-side reference. The req
returns to rb_send_bufs only after both have signed off.

rl_kref carries the invariant that any req held by an rpc_rqst
has a refcount of at least one. xprt_rdma_alloc_slot(),
rpcrdma_req_release() on the wake-up-backlog branch, and
rpcrdma_bc_rqst_get() each re-arm rl_kref before handing the req
to a new owner. Without that invariant, an RPC task that aborts
between slot allocation and marshal -- a gss_refresh failure or a
signal during call_connect, for example -- would drive
xprt_release() -> xprt_rdma_free_slot() -> kref_put against a
refcount of zero, saturating refcount_t and stranding the slot.

Because Send-side references can now outlive RPC completion,
connection teardown has to drain sendctx entries that never
receive a completion. These include orphans left by a failed
rpcrdma_prepare_send_sges(), and unsignaled Sends whose
completion never arrived before shutdown. rpcrdma_sendctxs_destroy()
walks the active range of the ring and runs rpcrdma_sendctx_unmap()
on each entry so the held krefs are released before the ring is
freed.

The send buffer stays stable until the HCA is finished with it,
RPC completion no longer waits on Send completion, and unsignaled
Send batching is preserved. rpcrdma_reply_handler() no longer
performs a cache-cold atomic kref_put on every reply. This brings
xprtrdma into alignment with the two other in-kernel RDMA ULPs
that batch Sends into groups where only one is signaled. Since an
RPC reply no longer waits for a Send completion, the
reply_waits_for_send counter is removed.

The new lifetime can hold reqs off rb_send_bufs after RPC
completion until a later signaled Send completion walks the
sendctx ring. Allocate one-eighth more reqs than max_reqs so the
transport does not regress the effective concurrency advertised by
the SUNRPC slot table; the slot table still limits in-flight RPCs
to max_reqs.

Fixes: 0ab115237025 ("xprtrdma: Wake RPCs directly in rpcrdma_wc_send path")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/backchannel.c |  6 +--
 net/sunrpc/xprtrdma/frwr_ops.c    |  2 +-
 net/sunrpc/xprtrdma/rpc_rdma.c    | 88 ++++++++++++++++++++++---------
 net/sunrpc/xprtrdma/transport.c   |  9 ++--
 net/sunrpc/xprtrdma/verbs.c       | 22 +++++++-
 net/sunrpc/xprtrdma/xprt_rdma.h   |  2 +-
 6 files changed, 93 insertions(+), 36 deletions(-)

diff --git a/net/sunrpc/xprtrdma/backchannel.c b/net/sunrpc/xprtrdma/backchannel.c
index 2f0f9618dd05..d823d22d4e19 100644
--- a/net/sunrpc/xprtrdma/backchannel.c
+++ b/net/sunrpc/xprtrdma/backchannel.c
@@ -159,9 +159,7 @@ void xprt_rdma_bc_free_rqst(struct rpc_rqst *rqst)
 	rpcrdma_rep_put(&r_xprt->rx_buf, rep);
 	req->rl_reply = NULL;
 
-	spin_lock(&xprt->bc_pa_lock);
-	list_add_tail(&rqst->rq_bc_pa_list, &xprt->bc_pa_list);
-	spin_unlock(&xprt->bc_pa_lock);
+	rpcrdma_req_put(req);
 	xprt_put(xprt);
 }
 
@@ -179,6 +177,7 @@ static struct rpc_rqst *rpcrdma_bc_rqst_get(struct rpcrdma_xprt *r_xprt)
 		goto create_req;
 	list_del(&rqst->rq_bc_pa_list);
 	spin_unlock(&xprt->bc_pa_lock);
+	kref_init(&rpcr_to_rdmar(rqst)->rl_kref);
 	return rqst;
 
 create_req:
@@ -203,6 +202,7 @@ static struct rpc_rqst *rpcrdma_bc_rqst_get(struct rpcrdma_xprt *r_xprt)
 	rqst->rq_xprt = xprt;
 	__set_bit(RPC_BC_PA_IN_USE, &rqst->rq_bc_pa_state);
 	xdr_buf_init(&rqst->rq_snd_buf, rdmab_data(req->rl_sendbuf), size);
+	kref_init(&req->rl_kref);
 	return rqst;
 }
 
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 7f79a0a2601e..e5c71cf705a3 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -474,7 +474,7 @@ int frwr_send(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 		++num_wrs;
 	}
 
-	if ((kref_read(&req->rl_kref) > 1) || num_wrs > ep->re_send_count) {
+	if (req->rl_sendctx->sc_unmap_count || num_wrs > ep->re_send_count) {
 		send_wr->send_flags |= IB_SEND_SIGNALED;
 		ep->re_send_count = min_t(unsigned int, ep->re_send_batch,
 					  num_wrs - ep->re_send_count);
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 0e0f21974710..6be31a3c21d8 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -467,29 +467,62 @@ static int rpcrdma_encode_reply_chunk(struct rpcrdma_xprt *r_xprt,
 	return 0;
 }
 
-static void rpcrdma_sendctx_done(struct kref *kref)
+/* rl_kref has two owners while a Send is outstanding: the rpc_rqst
+ * owner and the sendctx. Replies complete the RPC but do not drop
+ * either reference. The req returns to rb_send_bufs only after
+ * xprt_rdma_free_slot() or xprt_rdma_bc_free_rqst() has dropped the
+ * RPC-layer reference and rpcrdma_sendctx_unmap() has dropped the
+ * Send-side reference.
+ *
+ * Any req held by an rpc_rqst has rl_kref >= 1. Hand-off sites
+ * reinitialize rl_kref before assigning a recycled req to a new owner;
+ * rpcrdma_prepare_send_sges() then takes the Send-side reference.
+ */
+static void rpcrdma_req_release(struct kref *kref)
 {
 	struct rpcrdma_req *req =
 		container_of(kref, struct rpcrdma_req, rl_kref);
-	struct rpcrdma_rep *rep = req->rl_reply;
+	struct rpc_rqst *rqst = &req->rl_slot;
+	struct rpc_xprt *xprt = rqst->rq_xprt;
+	struct rpcrdma_xprt *r_xprt =
+		container_of(xprt, struct rpcrdma_xprt, rx_xprt);
 
-	rpcrdma_complete_rqst(rep);
-	rep->rr_rxprt->rx_stats.reply_waits_for_send++;
+	if (bc_prealloc(rqst)) {
+		spin_lock(&xprt->bc_pa_lock);
+		list_add_tail(&rqst->rq_bc_pa_list, &xprt->bc_pa_list);
+		spin_unlock(&xprt->bc_pa_lock);
+		return;
+	}
+
+	/* Re-arm rl_kref before the hand-off so the next owner of
+	 * this slot sees a positive refcount.
+	 */
+	kref_init(&req->rl_kref);
+	if (!xprt_wake_up_backlog(xprt, rqst)) {
+		memset(rqst, 0, sizeof(*rqst));
+		rpcrdma_buffer_put(&r_xprt->rx_buf, req);
+	}
 }
 
 /**
- * rpcrdma_sendctx_unmap - DMA-unmap Send buffer
- * @sc: sendctx containing SGEs to unmap
+ * rpcrdma_req_put - Drop one kref reference on an rpcrdma_req
+ * @req: request whose reference is to be released
  *
+ * When both the Send completion and the RPC layer have released
+ * their references, the req is returned to the free pool.
  */
-void rpcrdma_sendctx_unmap(struct rpcrdma_sendctx *sc)
+void rpcrdma_req_put(struct rpcrdma_req *req)
+{
+	kref_put(&req->rl_kref, rpcrdma_req_release);
+}
+
+/* DMA-unmap Send buffer SGEs without releasing the kref.
+ */
+static void rpcrdma_sendctx_dma_unmap(struct rpcrdma_sendctx *sc)
 {
 	struct rpcrdma_regbuf *rb = sc->sc_req->rl_sendbuf;
 	struct ib_sge *sge;
 
-	if (!sc->sc_unmap_count)
-		return;
-
 	/* The first two SGEs contain the transport header and
 	 * the inline buffer. These are always left mapped so
 	 * they can be cheaply re-used.
@@ -498,8 +531,16 @@ void rpcrdma_sendctx_unmap(struct rpcrdma_sendctx *sc)
 	     ++sge, --sc->sc_unmap_count)
 		ib_dma_unmap_page(rdmab_device(rb), sge->addr, sge->length,
 				  DMA_TO_DEVICE);
+}
 
-	kref_put(&sc->sc_req->rl_kref, rpcrdma_sendctx_done);
+/**
+ * rpcrdma_sendctx_unmap - DMA-unmap Send buffer and release Send kref
+ * @sc: sendctx containing SGEs to unmap
+ */
+void rpcrdma_sendctx_unmap(struct rpcrdma_sendctx *sc)
+{
+	rpcrdma_sendctx_dma_unmap(sc);
+	rpcrdma_req_put(sc->sc_req);
 }
 
 /* Prepare an SGE for the RPC-over-RDMA transport header.
@@ -691,8 +732,6 @@ static bool rpcrdma_prepare_noch_mapped(struct rpcrdma_xprt *r_xprt,
 					      tail->iov_len))
 			return false;
 
-	if (req->rl_sendctx->sc_unmap_count)
-		kref_get(&req->rl_kref);
 	return true;
 }
 
@@ -722,7 +761,6 @@ static bool rpcrdma_prepare_readch(struct rpcrdma_xprt *r_xprt,
 		len -= len & 3;
 		if (!rpcrdma_prepare_tail_iov(req, xdr, page_base, len))
 			return false;
-		kref_get(&req->rl_kref);
 	}
 
 	return true;
@@ -751,7 +789,10 @@ inline int rpcrdma_prepare_send_sges(struct rpcrdma_xprt *r_xprt,
 		goto out_nosc;
 	req->rl_sendctx->sc_unmap_count = 0;
 	req->rl_sendctx->sc_req = req;
-	kref_init(&req->rl_kref);
+	/* Take the Send-side reference. The hand-off site that
+	 * gave us this req has already armed rl_kref to >= 1.
+	 */
+	kref_get(&req->rl_kref);
 	req->rl_wr.wr_cqe = &req->rl_sendctx->sc_cqe;
 	req->rl_wr.sg_list = req->rl_sendctx->sc_sges;
 	req->rl_wr.num_sge = 0;
@@ -782,7 +823,12 @@ inline int rpcrdma_prepare_send_sges(struct rpcrdma_xprt *r_xprt,
 	return 0;
 
 out_unmap:
-	rpcrdma_sendctx_unmap(req->rl_sendctx);
+	/* Unmap DMA SGEs without releasing the Send kref. The
+	 * sendctx remains in the ring, so the ring walk in
+	 * rpcrdma_sendctx_put_locked() handles the Send-side
+	 * kref_put when a later Send completion is signaled.
+	 */
+	rpcrdma_sendctx_dma_unmap(req->rl_sendctx);
 out_nosc:
 	trace_xprtrdma_prepsend_failed(&req->rl_slot, ret);
 	return ret;
@@ -1360,14 +1406,6 @@ void rpcrdma_complete_rqst(struct rpcrdma_rep *rep)
 	goto out;
 }
 
-static void rpcrdma_reply_done(struct kref *kref)
-{
-	struct rpcrdma_req *req =
-		container_of(kref, struct rpcrdma_req, rl_kref);
-
-	rpcrdma_complete_rqst(req->rl_reply);
-}
-
 /**
  * rpcrdma_reply_handler - Process received RPC/RDMA messages
  * @rep: Incoming rpcrdma_rep object to process
@@ -1439,7 +1477,7 @@ void rpcrdma_reply_handler(struct rpcrdma_rep *rep)
 		frwr_unmap_async(r_xprt, req);
 		/* LocalInv completion will complete the RPC */
 	else
-		kref_put(&req->rl_kref, rpcrdma_reply_done);
+		rpcrdma_complete_rqst(rep);
 
 out_post:
 	rpcrdma_post_recvs(r_xprt,
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 61706df5e485..72d6b685bac8 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -505,6 +505,7 @@ xprt_rdma_alloc_slot(struct rpc_xprt *xprt, struct rpc_task *task)
 	req = rpcrdma_buffer_get(&r_xprt->rx_buf);
 	if (!req)
 		goto out_sleep;
+	kref_init(&req->rl_kref);
 	task->tk_rqstp = &req->rl_slot;
 	task->tk_status = 0;
 	return;
@@ -520,6 +521,7 @@ xprt_rdma_alloc_slot(struct rpc_xprt *xprt, struct rpc_task *task)
 	if (req) {
 		struct rpc_rqst *rqst = &req->rl_slot;
 
+		kref_init(&req->rl_kref);
 		if (!xprt_wake_up_backlog(xprt, rqst)) {
 			memset(rqst, 0, sizeof(*rqst));
 			rpcrdma_buffer_put(&r_xprt->rx_buf, req);
@@ -540,10 +542,7 @@ xprt_rdma_free_slot(struct rpc_xprt *xprt, struct rpc_rqst *rqst)
 		container_of(xprt, struct rpcrdma_xprt, rx_xprt);
 
 	rpcrdma_reply_put(&r_xprt->rx_buf, rpcr_to_rdmar(rqst));
-	if (!xprt_wake_up_backlog(xprt, rqst)) {
-		memset(rqst, 0, sizeof(*rqst));
-		rpcrdma_buffer_put(&r_xprt->rx_buf, rpcr_to_rdmar(rqst));
-	}
+	rpcrdma_req_put(rpcr_to_rdmar(rqst));
 }
 
 static bool rpcrdma_check_regbuf(struct rpcrdma_xprt *r_xprt,
@@ -716,7 +715,7 @@ void xprt_rdma_print_stats(struct rpc_xprt *xprt, struct seq_file *seq)
 		   r_xprt->rx_stats.mrs_allocated,
 		   r_xprt->rx_stats.local_inv_needed,
 		   r_xprt->rx_stats.empty_sendctx_q,
-		   r_xprt->rx_stats.reply_waits_for_send);
+		   0LU); /* Was reply_waits_for_send */
 }
 
 static int
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index aecf9c0a153f..3ce3acd19b90 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -65,6 +65,8 @@
 
 static int rpcrdma_sendctxs_create(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_sendctxs_destroy(struct rpcrdma_xprt *r_xprt);
+static unsigned long rpcrdma_sendctx_next(struct rpcrdma_buffer *buf,
+					  unsigned long item);
 static void rpcrdma_sendctx_put_locked(struct rpcrdma_xprt *r_xprt,
 				       struct rpcrdma_sendctx *sc);
 static int rpcrdma_reqs_setup(struct rpcrdma_xprt *r_xprt);
@@ -605,6 +607,23 @@ static void rpcrdma_sendctxs_destroy(struct rpcrdma_xprt *r_xprt)
 
 	if (!buf->rb_sc_ctxs)
 		return;
+
+	/* Release any Send-side kref still held by sendctxs the HCA
+	 * never signaled: orphans left by a rpcrdma_prepare_send_sges()
+	 * failure, and entries past rb_sc_tail whose unsignaled Sends
+	 * never had a later signaled completion to drive the ring walk.
+	 * Without this drain those reqs would stay off rb_send_bufs and
+	 * their slots would be leaked across reconnect.
+	 */
+	for (i = rpcrdma_sendctx_next(buf, buf->rb_sc_tail);
+	     i != rpcrdma_sendctx_next(buf, buf->rb_sc_head);
+	     i = rpcrdma_sendctx_next(buf, i)) {
+		struct rpcrdma_sendctx *sc = buf->rb_sc_ctxs[i];
+
+		if (sc && sc->sc_req)
+			rpcrdma_sendctx_unmap(sc);
+	}
+
 	for (i = 0; i <= buf->rb_sc_last; i++)
 		kfree(buf->rb_sc_ctxs[i]);
 	kfree(buf->rb_sc_ctxs);
@@ -1081,7 +1100,8 @@ int rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
 	INIT_LIST_HEAD(&buf->rb_all_reps);
 
 	rc = -ENOMEM;
-	for (i = 0; i < r_xprt->rx_xprt.max_reqs; i++) {
+	for (i = 0; i < r_xprt->rx_xprt.max_reqs +
+			(r_xprt->rx_xprt.max_reqs >> 3); i++) {
 		struct rpcrdma_req *req;
 
 		req = rpcrdma_req_create(r_xprt,
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index f53a77472724..39b3a6eff567 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -427,7 +427,6 @@ struct rpcrdma_stats {
 	/* accessed when receiving a reply */
 	unsigned long long	total_rdma_reply;
 	unsigned long long	fixup_copy_count;
-	unsigned long		reply_waits_for_send;
 	unsigned long		local_inv_needed;
 	unsigned long		nomsg_call_count;
 	unsigned long		bcall_count;
@@ -580,6 +579,7 @@ int rpcrdma_prepare_send_sges(struct rpcrdma_xprt *r_xprt,
 			      struct rpcrdma_req *req, u32 hdrlen,
 			      struct xdr_buf *xdr,
 			      enum rpcrdma_chunktype rtype);
+void rpcrdma_req_put(struct rpcrdma_req *req);
 void rpcrdma_sendctx_unmap(struct rpcrdma_sendctx *sc);
 int rpcrdma_marshal_req(struct rpcrdma_xprt *r_xprt, struct rpc_rqst *rqst);
 void rpcrdma_set_max_header_sizes(struct rpcrdma_ep *ep);
-- 
2.54.0


