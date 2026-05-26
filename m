Return-Path: <linux-nfs+bounces-21971-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBkpOtmsFWrgXgcAu9opvQ
	(envelope-from <linux-nfs+bounces-21971-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 16:23:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 720A05D7665
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 16:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4146304892F
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 14:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F503FD140;
	Tue, 26 May 2026 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a06xeVq2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B663FE641;
	Tue, 26 May 2026 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804854; cv=none; b=pjS0/omtUwLgcOJXWrnTp2oADR96gkIjaq9XjaXDOcpfVomqEXpq8sw6MoXQfatItcFqaXL/gA6SQgE1ZWBLtqBa176oIQDTjRLA5XexSfdbtko0mxAgznogefA2AmPJhhCA0FG9ZN3z54y8UxDRVfKpodtXogTba9tJpMuz03E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804854; c=relaxed/simple;
	bh=q2RkpUxIlXmZfLSZtMfKFrjyfuQgxTT4YvjRAvXt8kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNxcFG5qOoD+vQL3cufl2UrRyDH/+e3Sx5SaiyZBPAAfTHk9vyHQR+c171tDQLtlw11sG+330pa2kFreeXb9ETtfnECeZqtELyZMglRQcHMIilhO0z5PawXaFXzroHVcfQQ+E9YvbgZNsOkTt+1Y/Twk4voM1H8ApwTj2+TjPtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a06xeVq2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C207A1F00A3E;
	Tue, 26 May 2026 14:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779804853;
	bh=8MtHOuz/pGDUezQdwB47SzjgtT2rpQX01Ql5drdrHVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a06xeVq20U4iUhXaMIa+wQd6Vpda+8lBxFy+fS3BphKQxrkVzSTREiyuGLKn9w1g5
	 h/nkF7RPm8A64A53WhkjB/Vrrgt/nirSJs2SEs4h5rq48l7enj1w2qKHtvOiHx5APw
	 F7AXV2CHLdjxoOiVrMkx7/keBXLhP2wxrtOtWlw8sRz2DPyLf+MATDXITxXwmSyc0H
	 WiyPli8Wzs/8SS8OsBq0rAm1OGEGMwZtXYnWgcrIZdzyWk7rJePqmmYBCHcKBqw75y
	 qzPQABbAx9j0bzjbFfghamlJep7qd6yAqqcgnBGCZCzt3Npy9xcVxDg5pCd0m45y1K
	 ZFqjmrFWdCSwQ==
From: Chuck Lever <cel@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: <linux-rdma@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 5/5] xprtrdma: Document and assert reply-handler invariants
Date: Tue, 26 May 2026 10:14:05 -0400
Message-ID: <20260526141405.39877-6-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526141405.39877-1-cel@kernel.org>
References: <20260526141405.39877-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21971-lists,linux-nfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 720A05D7665
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

The xprtrdma reply path has been the subject of recurring
LLM-driven review claims that 'an RPC can complete while
receive buffers are still DMA-mapped' or that 'the req can be
freed while the HCA still owns the send buffer.'  No runtime
reproducer has surfaced, but the absence of a written-down
invariant set lets each pass of automated review reach the
same hypothetical conclusion.  Subsequent fixes against
ce2f9a4d9ccc ('xprtrdma: Decouple req recycling from RPC
completion') closed the underlying races but did not document
the closure where future readers will look for it.

State the invariants explicitly in a comment above
rpcrdma_reply_handler() and back four of them with
WARN_ON_ONCE() probes positioned where each invariant is
locally checkable on the previous patch's cleaned-up
ownership state:

- I1 (Receive WR ownership): WARN at rpcrdma_post_recvs() that
  a rep pulled from rb_free_reps carries rr_rqst == NULL.

- I2 (rep attachment): WARN at rpcrdma_reply_put() that
  req->rl_reply was NULLed before the matching rep_put.

- I3 (Registered-MR fence): WARN at rpcrdma_complete_rqst()
  that req->rl_registered is empty.  Strong send-queue
  ordering of the LocalInv WR chain makes the last
  completion observe the ib_dma_unmap_sg() of every earlier
  MR, so 'list empty' implies 'all MRs unmapped'.

- I4 (Send-buffer release): WARN at rpcrdma_req_release()
  that req->rl_sendctx is NULL.  Reaching the kref release
  callback requires both the RPC-layer and Send-side
  references to have dropped; the Send-side drop runs in
  rpcrdma_sendctx_unmap(), which clears rl_sendctx
  (previous patch).  A non-NULL rl_sendctx here would mean
  the Send-side owner had not run -- a contradiction.

The XXX comment in xprt_rdma_free() about signal-driven
release racing the Send completion described the pre-decouple
state.  Replace it with a one-line note pointing at the
invariant set, since the kref scheme now holds the req across
the in-flight Send regardless of which path released the
rpc_task.

I5 (req lifecycle) is stated in the comment but not probed:
making it locally assertible would require moving kref_init
out of rpcrdma_req_release(), which in turn requires adding
kref_init to the bc_pa_list and backlog-wake reuse paths.
That restructuring is deferred -- the invariant is unchanged
either way.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c  | 69 +++++++++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/transport.c | 13 +++++--
 net/sunrpc/xprtrdma/verbs.c     |  6 +++
 3 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index f4b4abefc4e0..626cadec4555 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1336,6 +1336,11 @@ void rpcrdma_complete_rqst(struct rpcrdma_rep *rep)
 	struct rpc_rqst *rqst = rep->rr_rqst;
 	int status;
 
+	/* I3: every registered MR has been invalidated and
+	 * ib_dma_unmap_sg()'d before complete_rqst runs.
+	 */
+	WARN_ON_ONCE(!list_empty(&rpcr_to_rdmar(rqst)->rl_registered));
+
 	switch (rep->rr_proc) {
 	case rdma_msg:
 		status = rpcrdma_decode_msg(r_xprt, rep, rqst);
@@ -1367,6 +1372,70 @@ void rpcrdma_complete_rqst(struct rpcrdma_rep *rep)
 	goto out;
 }
 
+/* Reply-side ownership invariants
+ *
+ * I1 (Receive WR ownership).  A struct rpcrdma_rep is owned by the
+ *    HCA between ib_post_recv() and the matching Receive completion.
+ *    After ib_dma_sync_single_for_cpu() in rpcrdma_wc_receive() it is
+ *    owned by the CPU until rpcrdma_rep_put() returns it to
+ *    rb_free_reps; a rep on rb_free_reps is not re-posted until
+ *    rpcrdma_post_recvs() pulls it off.  Asserted: rpcrdma_post_recvs()
+ *    WARNs that a pulled rep has rr_rqst == NULL.
+ *
+ * I2 (rep attachment).  While req->rl_reply == rep, the rep cannot be
+ *    re-posted.  rpcrdma_reply_put() NULLs req->rl_reply before handing
+ *    the rep to rpcrdma_rep_put().  Asserted: rpcrdma_reply_put() WARNs
+ *    that rl_reply is NULL after the put.
+ *
+ * I3 (Registered-MR fence).  On entry to rpcrdma_complete_rqst() every
+ *    MR that was on req->rl_registered has had its rkey invalidated
+ *    (remotely via IB_WC_WITH_INVALIDATE or locally via IB_WR_LOCAL_INV)
+ *    and its pages ib_dma_unmap_sg()'d.  The LocalInv chain is posted
+ *    on a single QP; strong send-queue ordering makes the last
+ *    completion (frwr_wc_localinv_done) observe the
+ *    ib_dma_unmap_sg() that ran from each earlier completion's
+ *    frwr_mr_put() before complete_rqst is called.  The inline
+ *    frwr_reminv() path unmaps its one MR synchronously before
+ *    rpcrdma_reply_handler() reaches complete_rqst.  Asserted:
+ *    rpcrdma_complete_rqst() WARNs that rl_registered is empty.
+ *
+ * I4 (Send-buffer release).  req->rl_kref carries two unconditional
+ *    owners while a Send is outstanding: the RPC-layer reference (set
+ *    at xprt_rdma_alloc_slot / xprt_rdma_bc_rqst_get / rpcrdma_req_release
+ *    pool-entry) and the Send-side reference (kref_get() in
+ *    rpcrdma_prepare_send_sges()).  rpcrdma_req_release() runs only
+ *    after both have dropped, so the req does not return to its free
+ *    pool until rpcrdma_sendctx_unmap() has fired -- the HCA has
+ *    released the send buffer before the req can be reused.  Asserted:
+ *    rpcrdma_req_release() WARNs that rl_sendctx is NULL.
+ *
+ * I5 (req lifecycle).  A req is owned by the RPC layer between slot
+ *    acquisition and the matching xprt_rdma_free_slot() (or, for the
+ *    backchannel, xprt_rdma_bc_free_rqst()).  While owned, rl_kref >= 1.
+ *    The pools (rb_send_bufs, bc_pa_list, backlog wake target) never
+ *    contain a req with outstanding Send-side or Reply-side work.
+ *
+ * Non-hazards.  The following claims have been raised by adversarial
+ * review and are each closed by the invariants above:
+ *
+ *   * "Reply completes the RPC while the HCA still holds the send
+ *     buffer" -- excluded by I4.  The Send-side kref reference is held
+ *     until rpcrdma_sendctx_unmap() runs from Send completion.
+ *
+ *   * "Signal-driven release races the in-flight Send" -- same
+ *     resolution.  xprt_rdma_free() does not touch rl_kref; the
+ *     Send-side reference keeps the req out of its pool until Send
+ *     completion fires.
+ *
+ *   * "Receive completion races rep reuse" -- excluded by I1.  A rep
+ *     is on rb_free_reps only after rpcrdma_rep_put() has been called
+ *     and rpcrdma_post_recvs() owns the next transition back to the HCA.
+ *
+ *   * "Pages still DMA-mapped when call_decode reads them" -- excluded
+ *     by I3.  The matching ib_dma_unmap_sg() for every MR has run on
+ *     the same CPU thread that calls rpcrdma_complete_rqst().
+ */
+
 /**
  * rpcrdma_reply_handler - Process received RPC/RDMA messages
  * @rep: Incoming rpcrdma_rep object to process
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 5569f17fdd9b..5ff8e5126a6c 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -509,6 +509,11 @@ static void rpcrdma_req_release(struct kref *kref)
 	struct rpc_xprt *xprt = rqst->rq_xprt;
 	struct rpcrdma_xprt *r_xprt;
 
+	/* I4: both the RPC-layer and Send-side owners have dropped,
+	 * so rpcrdma_sendctx_unmap() has cleared rl_sendctx.
+	 */
+	WARN_ON_ONCE(req->rl_sendctx);
+
 	kref_init(&req->rl_kref);
 
 #if defined(CONFIG_SUNRPC_BACKCHANNEL)
@@ -652,10 +657,10 @@ xprt_rdma_free(struct rpc_task *task)
 		frwr_unmap_sync(rpcx_to_rdmax(rqst->rq_xprt), req);
 	}
 
-	/* XXX: If the RPC is completing because of a signal and
-	 * not because a reply was received, we ought to ensure
-	 * that the Send completion has fired, so that memory
-	 * involved with the Send is not still visible to the NIC.
+	/* The Send-side rl_kref owner keeps req out of its free pool
+	 * until rpcrdma_sendctx_unmap() has fired -- see I4 above
+	 * rpcrdma_reply_handler() -- so signal-driven release here
+	 * does not let the HCA touch a recycled send buffer.
 	 */
 }
 
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 60cbc14c5299..da2c6fa44154 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1259,6 +1259,10 @@ void rpcrdma_reply_put(struct rpcrdma_buffer *buffers, struct rpcrdma_req *req)
 		req->rl_reply = NULL;
 		rpcrdma_rep_put(buffers, rep);
 	}
+	/* I2: rl_reply NULL after the put closes the
+	 * 'rep on rb_free_reps still referenced by req' window.
+	 */
+	WARN_ON_ONCE(req->rl_reply);
 }
 
 /**
@@ -1435,6 +1439,8 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed)
 			rep = rpcrdma_rep_create(r_xprt);
 		if (!rep)
 			break;
+		/* I1: a rep on rb_free_reps must carry no rqst pointer. */
+		WARN_ON_ONCE(rep->rr_rqst);
 		if (!rpcrdma_regbuf_dma_map(r_xprt, rep->rr_rdmabuf)) {
 			rpcrdma_rep_put(buf, rep);
 			break;
-- 
2.54.0


