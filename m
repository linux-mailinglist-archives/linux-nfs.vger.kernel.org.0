Return-Path: <linux-nfs+bounces-21970-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IApKO46sFWoZXwcAu9opvQ
	(envelope-from <linux-nfs+bounces-21970-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 16:22:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8229E5D7607
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 16:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFB6D3046D67
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 14:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086743FF1A1;
	Tue, 26 May 2026 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwyyBDa1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73C73FE377;
	Tue, 26 May 2026 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804853; cv=none; b=Nhz+KkEtQmhXRgL3Hk3nfVY1pI7tGtTCAeyQIkpci0rAFKFC5wIZ5GZiWLCm/57Y8PqGt5K+6LnELQLswoncn2in5vdvD5WRDA1gH+QJaKOUx64QoNQnzXbQRPs1b8BcZu0SN3OJUkude1oklAlBsAInnB8qmb5D5OoVXJfUhkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804853; c=relaxed/simple;
	bh=IV7nuttzZXIhY+W38QqbvWvXZO39R3M5kSwMdCidel8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qT/6NkuNpxv3vqd+yCPyUJA0Flj/4lrnvo/Za9MRFp5jm5ZdvV8qbjghVofpPRZIQc+rav9ESbf994+apWVcen9r4bRgO0dU33cwVsqwGAQnbspZAdOp38MuQOcLQBMDbzwij+CJ3VBaw8v/2cT5yYTwKVR2j9gZVaz/bDpoomU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwyyBDa1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296691F000E9;
	Tue, 26 May 2026 14:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779804852;
	bh=Am3DWXR8uqhXYxeA9vZk67rwWUUEEQb67gNSXHX+kGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bwyyBDa1movU7VNirqmSDFTZfnJAwqWLEqlCqaQGQnfDfKr3QJKJRog5BUzTBzSgo
	 00DRXRh0fqvquEULb6D4Dnvq6fOLBNKGDxNlgh87sO9RTv2j7O586ot4bt2ZVRbhTP
	 xCmOMtot+Zf3nPXSDPGNjS9T+QhmcVm1fiFiHjNsDuqU/2m2t0QQF/+hMAenlJyFp8
	 2biV2r3JAdnE7y60ihncPULAnNT5wmAz9rsCaHjaHRhFimzrr5bxTe/ZmPSZ0UGcoa
	 E+ruRu9r7B0+XyBpHC5UQd/utwwHT5biSrVDUd5YvAZMSX8VZnFm2+K63IEVbXzlB2
	 LEzGiQbLknb4w==
From: Chuck Lever <cel@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: <linux-rdma@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 4/5] xprtrdma: Clear receive-side ownership pointers on release
Date: Tue, 26 May 2026 10:14:04 -0400
Message-ID: <20260526141405.39877-5-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-21970-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Queue-Id: 8229E5D7607
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Three small ownership-state cleanups land the transport in a
state that lets future reviewers reason about each pointer
locally rather than tracing the whole reply path:

rpcrdma_rep_put() clears rep->rr_rqst before the rep enters
rb_free_reps so that no rep on the free list still carries a
stale rqst pointer.  rpcrdma_reply_handler() and
rpcrdma_unpin_rqst() are the only sites that set rr_rqst;
rpcrdma_reply_handler() hands the rep through
rpcrdma_rep_put(), and rpcrdma_unpin_rqst() NULLs rr_rqst
directly because its error path abandons the rep for
teardown cleanup rather than returning it to rb_free_reps.

rpcrdma_reply_put() NULLs req->rl_reply before calling
rpcrdma_rep_put().  The previous order placed the rep on
rb_free_reps while req->rl_reply still pointed at it; the
window was harmless because xprt_rdma_free_slot() holds the
req exclusively across the pair, but closing it makes the
invariant 'rep on rb_free_reps implies no req references it'
strictly checkable.

rpcrdma_sendctx_unmap() and rpcrdma_sendctx_cancel() clear
req->rl_sendctx after dropping the sendctx pointer in the
sendctx ring.  Without this, req->rl_sendctx survives across
Send completion and points at a sendctx that may already have
been reassigned by rpcrdma_sendctx_get_locked() to a different
req.  No caller dereferences the stale pointer today --
rpcrdma_prepare_send_sges() overwrites it before the next
Send -- but a NULL is a more honest representation of 'the
Send is no longer outstanding' and lets the assertion patch
that follows trip on any future regression.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c |  4 ++++
 net/sunrpc/xprtrdma/verbs.c    | 12 ++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 69380f9dfa49..f4b4abefc4e0 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -493,6 +493,7 @@ void rpcrdma_sendctx_unmap(struct rpcrdma_sendctx *sc)
 
 	rpcrdma_sendctx_dma_unmap(sc);
 	sc->sc_req = NULL;
+	req->rl_sendctx = NULL;
 	rpcrdma_req_put(req);
 }
 
@@ -501,8 +502,11 @@ void rpcrdma_sendctx_unmap(struct rpcrdma_sendctx *sc)
  */
 static void rpcrdma_sendctx_cancel(struct rpcrdma_sendctx *sc)
 {
+	struct rpcrdma_req *req = sc->sc_req;
+
 	rpcrdma_sendctx_dma_unmap(sc);
 	sc->sc_req = NULL;
+	req->rl_sendctx = NULL;
 }
 
 /* Prepare an SGE for the RPC-over-RDMA transport header.
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 98bd965787e6..60cbc14c5299 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1043,9 +1043,15 @@ static struct rpcrdma_rep *rpcrdma_rep_get_locked(struct rpcrdma_buffer *buf)
  * @buf: buffer pool
  * @rep: rep to release
  *
+ * The rep's transient association with an rpc_rqst, established
+ * by rpcrdma_reply_handler() and torn down here, must not survive
+ * onto rb_free_reps: rpcrdma_post_recvs() pulls reps from the free
+ * list to re-post them, and a non-NULL rr_rqst on a free-listed rep
+ * would imply the rep is still referenced by a req.
  */
 void rpcrdma_rep_put(struct rpcrdma_buffer *buf, struct rpcrdma_rep *rep)
 {
+	rep->rr_rqst = NULL;
 	llist_add(&rep->rr_node, &buf->rb_free_reps);
 }
 
@@ -1247,9 +1253,11 @@ rpcrdma_mr_get(struct rpcrdma_xprt *r_xprt)
  */
 void rpcrdma_reply_put(struct rpcrdma_buffer *buffers, struct rpcrdma_req *req)
 {
-	if (req->rl_reply) {
-		rpcrdma_rep_put(buffers, req->rl_reply);
+	struct rpcrdma_rep *rep = req->rl_reply;
+
+	if (rep) {
 		req->rl_reply = NULL;
+		rpcrdma_rep_put(buffers, rep);
 	}
 }
 
-- 
2.54.0


