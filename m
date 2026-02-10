Return-Path: <linux-nfs+bounces-18844-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJnNEp9di2mYUAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18844-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:32:31 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7342A11D361
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41A1E30193BB
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 16:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98FB303CAB;
	Tue, 10 Feb 2026 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVdraZz+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C588A3EBF03;
	Tue, 10 Feb 2026 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770741147; cv=none; b=KaOKPPUdKUrCfDd8KXxAK5F/R627PZYjiLq81pCmNBBcLV1t5BRZdQWTfe4DghQoWTOdcO44eXKTumIrMD3Xrr30sHsum3qEzxdgslW0JmoVNcIEHmVX8Spo+4815Ez7Hl2b8dx1JSDH4iECTNB2XmsrKHbBf3L9eQKRp1cpjpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770741147; c=relaxed/simple;
	bh=fLNtHQ59kGVGMPDb4dTNz5OfOoHPT8NFSdrqci9DxeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXAQYxIUO+xT0ELl47n/jGr9cSxqYPglpufaqM36wgxNOYmrDUXMa5Jyz6DfD0AxVNVXFlIfpJihWriFSg3E6JwEVYPaLTJX5St0dKgqXovtUGRJ2PHnWof251ka4mJAyj6yaHhgyJNA8RUXWR4gT/J+5zNwJ2wxAbSs3uZKRMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVdraZz+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4133C19425;
	Tue, 10 Feb 2026 16:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770741147;
	bh=fLNtHQ59kGVGMPDb4dTNz5OfOoHPT8NFSdrqci9DxeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KVdraZz+w4+gkQ25Ozp4A5fv5sS1wBFojaVhqP9fKfowpHlCO5bjwlttIa9TiVzYh
	 SZ2a6qUhWHY743GzVgRmpEQBifRt4JwubmVX1eCgtKMRW+9emd7pQxvIturdc7q5cb
	 fO2ZFs+IgTufqnlRY/442EnWzmTed3H28c5XAJ8cVmZe9Ipw3kz2DItCwtxJKjISd/
	 ULrBaVlMDNBTzdqS+Hq2QW1PvgGVDPRhn2rIUl94dNuz8/yqwBXNEpmtis1tsklvYq
	 e90N/jLj19392L+f1tkVU4+ozdmS2a7ryHsLwVRVWvt9QuntGlnHQrG+vcxDA6B1P1
	 mkyy+AzuvslBQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 01/15] svcrdma: Add fair queuing for Send Queue access
Date: Tue, 10 Feb 2026 11:32:08 -0500
Message-ID: <20260210163222.2356793-2-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260210163222.2356793-1-cel@kernel.org>
References: <20260210163222.2356793-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-18844-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7342A11D361
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

When the Send Queue fills, multiple threads may wait for SQ slots.
The previous implementation had no ordering guarantee, allowing
starvation when one thread repeatedly acquires slots while others
wait indefinitely.

Introduce a ticket-based fair queuing system. Each waiter takes a
ticket number and is served in FIFO order. This ensures forward
progress for all waiters when SQ capacity is constrained.

The implementation has two phases:
1. Fast path: attempt to reserve SQ slots without waiting
2. Slow path: take a ticket, wait for turn, then wait for slots

The ticket system adds two atomic counters to the transport:
- sc_sq_ticket_head: next ticket to issue
- sc_sq_ticket_tail: ticket currently being served

When a waiter successfully reserves slots, it advances the tail
counter and wakes the next waiter. This creates an orderly handoff
that prevents starvation while maintaining good throughput on the
fast path when contention is low.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h          |   4 +
 net/sunrpc/xprtrdma/svc_rdma_rw.c        |  42 ++++-----
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    | 113 +++++++++++++++--------
 net/sunrpc/xprtrdma/svc_rdma_transport.c |   2 +
 4 files changed, 98 insertions(+), 63 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 57f4fd94166a..f68ac035fec6 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -84,6 +84,8 @@ struct svcxprt_rdma {
 
 	atomic_t             sc_sq_avail;	/* SQEs ready to be consumed */
 	unsigned int	     sc_sq_depth;	/* Depth of SQ */
+	atomic_t	     sc_sq_ticket_head;	/* Next ticket to issue */
+	atomic_t	     sc_sq_ticket_tail;	/* Ticket currently serving */
 	__be32		     sc_fc_credits;	/* Forward credits */
 	u32		     sc_max_requests;	/* Max requests */
 	u32		     sc_max_bc_requests;/* Backward credits */
@@ -306,6 +308,8 @@ extern void svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 				    struct svc_rdma_recv_ctxt *rctxt,
 				    int status);
 extern void svc_rdma_wake_send_waiters(struct svcxprt_rdma *rdma, int avail);
+extern int svc_rdma_sq_wait(struct svcxprt_rdma *rdma,
+			    const struct rpc_rdma_cid *cid, int sqecount);
 extern int svc_rdma_sendto(struct svc_rqst *);
 extern int svc_rdma_result_payload(struct svc_rqst *rqstp, unsigned int offset,
 				   unsigned int length);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 310de7a80be5..921dd2542d0d 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -384,34 +384,24 @@ static int svc_rdma_post_chunk_ctxt(struct svcxprt_rdma *rdma,
 		cqe = NULL;
 	}
 
-	do {
-		if (atomic_sub_return(cc->cc_sqecount,
-				      &rdma->sc_sq_avail) > 0) {
-			cc->cc_posttime = ktime_get();
-			ret = ib_post_send(rdma->sc_qp, first_wr, &bad_wr);
-			if (ret)
-				break;
+	ret = svc_rdma_sq_wait(rdma, &cc->cc_cid, cc->cc_sqecount);
+	if (ret < 0)
+		return ret;
+
+	cc->cc_posttime = ktime_get();
+	ret = ib_post_send(rdma->sc_qp, first_wr, &bad_wr);
+	if (ret) {
+		trace_svcrdma_sq_post_err(rdma, &cc->cc_cid, ret);
+		svc_xprt_deferred_close(&rdma->sc_xprt);
+
+		/* If even one was posted, there will be a completion. */
+		if (bad_wr != first_wr)
 			return 0;
-		}
 
-		percpu_counter_inc(&svcrdma_stat_sq_starve);
-		trace_svcrdma_sq_full(rdma, &cc->cc_cid);
-		atomic_add(cc->cc_sqecount, &rdma->sc_sq_avail);
-		wait_event(rdma->sc_send_wait,
-			   atomic_read(&rdma->sc_sq_avail) > cc->cc_sqecount);
-		trace_svcrdma_sq_retry(rdma, &cc->cc_cid);
-	} while (1);
-
-	trace_svcrdma_sq_post_err(rdma, &cc->cc_cid, ret);
-	svc_xprt_deferred_close(&rdma->sc_xprt);
-
-	/* If even one was posted, there will be a completion. */
-	if (bad_wr != first_wr)
-		return 0;
-
-	atomic_add(cc->cc_sqecount, &rdma->sc_sq_avail);
-	wake_up(&rdma->sc_send_wait);
-	return -ENOTCONN;
+		svc_rdma_wake_send_waiters(rdma, cc->cc_sqecount);
+		return -ENOTCONN;
+	}
+	return 0;
 }
 
 /* Build and DMA-map an SGL that covers one kvec in an xdr_buf
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 914cd263c2f1..da0d637ba4fb 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -294,6 +294,66 @@ void svc_rdma_wake_send_waiters(struct svcxprt_rdma *rdma, int avail)
 		wake_up(&rdma->sc_send_wait);
 }
 
+/**
+ * svc_rdma_sq_wait - Wait for SQ slots using fair queuing
+ * @rdma: controlling transport
+ * @cid: completion ID for tracing
+ * @sqecount: number of SQ entries needed
+ *
+ * A ticket-based system ensures fair ordering when multiple threads
+ * wait for Send Queue capacity. Each waiter takes a ticket and is
+ * served in order, preventing starvation.
+ *
+ * Return values:
+ *   %0: SQ slots were reserved successfully
+ *   %-ENOTCONN: The connection was lost
+ */
+int svc_rdma_sq_wait(struct svcxprt_rdma *rdma,
+		     const struct rpc_rdma_cid *cid, int sqecount)
+{
+	int ticket;
+
+	/* Fast path: try to reserve SQ slots without waiting */
+	if (likely(atomic_sub_return(sqecount, &rdma->sc_sq_avail) >= 0))
+		return 0;
+	atomic_add(sqecount, &rdma->sc_sq_avail);
+
+	/* Slow path: take a ticket and wait in line */
+	ticket = atomic_fetch_inc(&rdma->sc_sq_ticket_head);
+
+	percpu_counter_inc(&svcrdma_stat_sq_starve);
+	trace_svcrdma_sq_full(rdma, cid);
+
+	/* Wait until all earlier tickets have been served */
+	wait_event(rdma->sc_send_wait,
+		   test_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags) ||
+		   atomic_read(&rdma->sc_sq_ticket_tail) == ticket);
+	if (test_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags))
+		goto out_close;
+
+	/* It's our turn. Wait for enough SQ slots to be available. */
+	while (atomic_sub_return(sqecount, &rdma->sc_sq_avail) < 0) {
+		atomic_add(sqecount, &rdma->sc_sq_avail);
+
+		wait_event(rdma->sc_send_wait,
+			   test_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags) ||
+			   atomic_read(&rdma->sc_sq_avail) >= sqecount);
+		if (test_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags))
+			goto out_close;
+	}
+
+	/* Slots reserved successfully. Let the next waiter proceed. */
+	atomic_inc(&rdma->sc_sq_ticket_tail);
+	wake_up(&rdma->sc_send_wait);
+	trace_svcrdma_sq_retry(rdma, cid);
+	return 0;
+
+out_close:
+	atomic_inc(&rdma->sc_sq_ticket_tail);
+	wake_up(&rdma->sc_send_wait);
+	return -ENOTCONN;
+}
+
 /**
  * svc_rdma_wc_send - Invoked by RDMA provider for each polled Send WC
  * @cq: Completion Queue context
@@ -336,11 +396,6 @@ static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc)
  * that these values remain available after the ib_post_send() call.
  * In some error flow cases, svc_rdma_wc_send() releases @ctxt.
  *
- * Note there is potential for starvation when the Send Queue is
- * full because there is no order to when waiting threads are
- * awoken. The transport is typically provisioned with a deep
- * enough Send Queue that SQ exhaustion should be a rare event.
- *
  * Return values:
  *   %0: @ctxt's WR chain was posted successfully
  *   %-ENOTCONN: The connection was lost
@@ -362,42 +417,26 @@ int svc_rdma_post_send(struct svcxprt_rdma *rdma,
 				      send_wr->sg_list[0].length,
 				      DMA_TO_DEVICE);
 
-	/* If the SQ is full, wait until an SQ entry is available */
-	while (!test_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags)) {
-		if (atomic_sub_return(sqecount, &rdma->sc_sq_avail) < 0) {
-			svc_rdma_wake_send_waiters(rdma, sqecount);
+	ret = svc_rdma_sq_wait(rdma, &cid, sqecount);
+	if (ret < 0)
+		return ret;
 
-			/* When the transport is torn down, assume
-			 * ib_drain_sq() will trigger enough Send
-			 * completions to wake us. The XPT_CLOSE test
-			 * above should then cause the while loop to
-			 * exit.
-			 */
-			percpu_counter_inc(&svcrdma_stat_sq_starve);
-			trace_svcrdma_sq_full(rdma, &cid);
-			wait_event(rdma->sc_send_wait,
-				   atomic_read(&rdma->sc_sq_avail) > 0);
-			trace_svcrdma_sq_retry(rdma, &cid);
-			continue;
-		}
+	trace_svcrdma_post_send(ctxt);
+	ret = ib_post_send(rdma->sc_qp, first_wr, &bad_wr);
+	if (ret) {
+		trace_svcrdma_sq_post_err(rdma, &cid, ret);
+		svc_xprt_deferred_close(&rdma->sc_xprt);
 
-		trace_svcrdma_post_send(ctxt);
-		ret = ib_post_send(rdma->sc_qp, first_wr, &bad_wr);
-		if (ret) {
-			trace_svcrdma_sq_post_err(rdma, &cid, ret);
-			svc_xprt_deferred_close(&rdma->sc_xprt);
+		/* If even one WR was posted, there will be a
+		 * Send completion that bumps sc_sq_avail.
+		 */
+		if (bad_wr != first_wr)
+			return 0;
 
-			/* If even one WR was posted, there will be a
-			 * Send completion that bumps sc_sq_avail.
-			 */
-			if (bad_wr == first_wr) {
-				svc_rdma_wake_send_waiters(rdma, sqecount);
-				break;
-			}
-		}
-		return 0;
+		svc_rdma_wake_send_waiters(rdma, sqecount);
+		return -ENOTCONN;
 	}
-	return -ENOTCONN;
+	return 0;
 }
 
 /**
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index b7b318ad25c4..d1dcffbf2fe7 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -474,6 +474,8 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	if (newxprt->sc_sq_depth > dev->attrs.max_qp_wr)
 		newxprt->sc_sq_depth = dev->attrs.max_qp_wr;
 	atomic_set(&newxprt->sc_sq_avail, newxprt->sc_sq_depth);
+	atomic_set(&newxprt->sc_sq_ticket_head, 0);
+	atomic_set(&newxprt->sc_sq_ticket_tail, 0);
 
 	newxprt->sc_pd = ib_alloc_pd(dev, 0);
 	if (IS_ERR(newxprt->sc_pd)) {
-- 
2.52.0


