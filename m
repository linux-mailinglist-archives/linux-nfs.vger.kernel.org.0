Return-Path: <linux-nfs+bounces-19398-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CXoCemooWm1vQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19398-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:23:37 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA9B1B8D26
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 729A5324E0CD
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 14:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA8D40FD80;
	Fri, 27 Feb 2026 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvKnaQwA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89F42BE7CD
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201028; cv=none; b=j6bxY8WNV5UIhGwzdA+Wx8M9Zv977CCWteSoaQ7rPpaeGdns+2V72CIyzR9qEGGfd0M3d9AhDwlV4Cqs3aqyhppBDFyHMGfXmRU7uKMcw4UGDP6Jn/EdHPcSh1/xw4soyhlgFCR6H7cnAFJqVGhgYMdfpYAZ/NyuScJKT/nR6/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201028; c=relaxed/simple;
	bh=v/LUjVgylezS7gkDFj6s717WJVG34zfWA/mh0/rQkuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvZFN7bzB2MnLe7utGaX+RzsyEGiDIdFQAg/a2R1AkcmBUujoa63+zVa2yJnBp7ej/9prOHvZSp3Y/KInpF2G6RBGvaFSS9AnsdYkzlSC0i+VKjtWTthwPaEJlXrrueKJmjfVpd6u6x7ri0i5rqEMgY40xREh5JJfJoAvckj2bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvKnaQwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159C6C19423;
	Fri, 27 Feb 2026 14:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772201028;
	bh=v/LUjVgylezS7gkDFj6s717WJVG34zfWA/mh0/rQkuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YvKnaQwAWJ8Q+FLEaMVQ0Usn76VJltJwx/Bx/vRGcfXSiLaVyLmNnh1/KNBGv8t+6
	 tvc7AYguIhgTSUJIdHZV2M+cSxy6ufXJM77R61vcqPBqqKrVNr3XGyVo9xot5mOybt
	 NIBO/J8Ts3fv106C9x/IWQXjvMsVeqZ38RlQnuiXL30PKvcrvxetZCSAzQPhQ2nP0H
	 3JhCE2tkmwlVn8QGhbHEN/8bQvZOGgRyZAzkF0CzAjs0zE7BFcD1cmyUaFwuttTkN5
	 uWNuxYX1MoJRsBN2KpS6xhRHlbBWFgm7MtfkjZvVY7++b0tFW4zgMj48WQtbiua3pp
	 fs0n0X+lIQTZA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 01/18] svcrdma: Add fair queuing for Send Queue access
Date: Fri, 27 Feb 2026 09:03:28 -0500
Message-ID: <20260227140345.40488-2-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227140345.40488-1-cel@kernel.org>
References: <20260227140345.40488-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19398-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 7EA9B1B8D26
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

A dedicated wait queue (sc_sq_ticket_wait) handles ticket
ordering, separate from sc_send_wait which handles SQ capacity.
This separation ensures that send completions (the high-frequency
wake source) wake only the current ticket holder rather than all
queued waiters. Ticket handoff wakes only the ticket wait queue,
and each ticket holder that exits via connection close propagates
the wake to the next waiter in line.

When a waiter successfully reserves slots, it advances the tail
counter and wakes the next waiter. This creates an orderly handoff
that prevents starvation while maintaining good throughput on the
fast path when contention is low.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h          |  10 ++
 net/sunrpc/xprtrdma/svc_rdma_rw.c        |  37 ++----
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    | 160 +++++++++++++++++------
 net/sunrpc/xprtrdma/svc_rdma_transport.c |   6 +-
 4 files changed, 145 insertions(+), 68 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 57f4fd94166a..658b8498177e 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -84,6 +84,9 @@ struct svcxprt_rdma {
 
 	atomic_t             sc_sq_avail;	/* SQEs ready to be consumed */
 	unsigned int	     sc_sq_depth;	/* Depth of SQ */
+	atomic_t	     sc_sq_ticket_head;	/* Next ticket to issue */
+	atomic_t	     sc_sq_ticket_tail;	/* Ticket currently serving */
+	wait_queue_head_t    sc_sq_ticket_wait;	/* Ticket ordering waitlist */
 	__be32		     sc_fc_credits;	/* Forward credits */
 	u32		     sc_max_requests;	/* Max requests */
 	u32		     sc_max_bc_requests;/* Backward credits */
@@ -306,6 +309,13 @@ extern void svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 				    struct svc_rdma_recv_ctxt *rctxt,
 				    int status);
 extern void svc_rdma_wake_send_waiters(struct svcxprt_rdma *rdma, int avail);
+extern int svc_rdma_sq_wait(struct svcxprt_rdma *rdma,
+			    const struct rpc_rdma_cid *cid, int sqecount);
+extern int svc_rdma_post_send_err(struct svcxprt_rdma *rdma,
+				  const struct rpc_rdma_cid *cid,
+				  const struct ib_send_wr *bad_wr,
+				  const struct ib_send_wr *first_wr,
+				  int sqecount, int ret);
 extern int svc_rdma_sendto(struct svc_rqst *);
 extern int svc_rdma_result_payload(struct svc_rqst *rqstp, unsigned int offset,
 				   unsigned int length);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 4ec2f9ae06aa..6626f18de55e 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -405,34 +405,17 @@ static int svc_rdma_post_chunk_ctxt(struct svcxprt_rdma *rdma,
 		cqe = NULL;
 	}
 
-	do {
-		if (atomic_sub_return(cc->cc_sqecount,
-				      &rdma->sc_sq_avail) > 0) {
-			cc->cc_posttime = ktime_get();
-			ret = ib_post_send(rdma->sc_qp, first_wr, &bad_wr);
-			if (ret)
-				break;
-			return 0;
-		}
+	ret = svc_rdma_sq_wait(rdma, &cc->cc_cid, cc->cc_sqecount);
+	if (ret < 0)
+		return ret;
 
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
+	cc->cc_posttime = ktime_get();
+	ret = ib_post_send(rdma->sc_qp, first_wr, &bad_wr);
+	if (ret)
+		return svc_rdma_post_send_err(rdma, &cc->cc_cid, bad_wr,
+					      first_wr, cc->cc_sqecount,
+					      ret);
+	return 0;
 }
 
 /* Build a bvec that covers one kvec in an xdr_buf.
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 914cd263c2f1..22354e12d390 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -294,6 +294,117 @@ void svc_rdma_wake_send_waiters(struct svcxprt_rdma *rdma, int avail)
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
+ * Protocol invariant: every ticket holder must increment
+ * sc_sq_ticket_tail exactly once, whether the reservation
+ * succeeds or the connection closes. Failing to advance the
+ * tail stalls all subsequent waiters.
+ *
+ * The ticket counters are signed 32-bit atomics. After
+ * wrapping through INT_MAX, the equality check
+ * (tail == ticket) remains correct because both counters
+ * advance monotonically and the comparison uses exact
+ * equality rather than relational operators.
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
+	/* Fast path: try to reserve SQ slots without waiting.
+	 *
+	 * A failed reservation temporarily understates sc_sq_avail
+	 * until the compensating atomic_add restores it. A Send
+	 * completion arriving in that window sees a lower count
+	 * than reality, but the value self-corrects once the add
+	 * completes. No ordering guarantee is needed here because
+	 * the slow path serializes all contended waiters.
+	 */
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
+	wait_event(rdma->sc_sq_ticket_wait,
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
+	wake_up(&rdma->sc_sq_ticket_wait);
+	trace_svcrdma_sq_retry(rdma, cid);
+	return 0;
+
+out_close:
+	atomic_inc(&rdma->sc_sq_ticket_tail);
+	wake_up(&rdma->sc_sq_ticket_wait);
+	return -ENOTCONN;
+}
+
+/**
+ * svc_rdma_post_send_err - Handle ib_post_send failure
+ * @rdma: controlling transport
+ * @cid: completion ID for tracing
+ * @bad_wr: first WR that was not posted
+ * @first_wr: first WR in the chain
+ * @sqecount: number of SQ entries that were reserved
+ * @ret: error code from ib_post_send
+ *
+ * Return values:
+ *   %0: At least one WR was posted; a completion handles cleanup
+ *   %-ENOTCONN: No WRs were posted; SQ slots are released
+ */
+int svc_rdma_post_send_err(struct svcxprt_rdma *rdma,
+			   const struct rpc_rdma_cid *cid,
+			   const struct ib_send_wr *bad_wr,
+			   const struct ib_send_wr *first_wr,
+			   int sqecount, int ret)
+{
+	trace_svcrdma_sq_post_err(rdma, cid, ret);
+	svc_xprt_deferred_close(&rdma->sc_xprt);
+
+	/* If even one WR was posted, a Send completion will
+	 * return the reserved SQ slots.
+	 */
+	if (bad_wr != first_wr)
+		return 0;
+
+	svc_rdma_wake_send_waiters(rdma, sqecount);
+	return -ENOTCONN;
+}
+
 /**
  * svc_rdma_wc_send - Invoked by RDMA provider for each polled Send WC
  * @cq: Completion Queue context
@@ -336,11 +447,6 @@ static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc)
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
@@ -362,42 +468,16 @@ int svc_rdma_post_send(struct svcxprt_rdma *rdma,
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
-
-		trace_svcrdma_post_send(ctxt);
-		ret = ib_post_send(rdma->sc_qp, first_wr, &bad_wr);
-		if (ret) {
-			trace_svcrdma_sq_post_err(rdma, &cid, ret);
-			svc_xprt_deferred_close(&rdma->sc_xprt);
-
-			/* If even one WR was posted, there will be a
-			 * Send completion that bumps sc_sq_avail.
-			 */
-			if (bad_wr == first_wr) {
-				svc_rdma_wake_send_waiters(rdma, sqecount);
-				break;
-			}
-		}
-		return 0;
-	}
-	return -ENOTCONN;
+	trace_svcrdma_post_send(ctxt);
+	ret = ib_post_send(rdma->sc_qp, first_wr, &bad_wr);
+	if (ret)
+		return svc_rdma_post_send_err(rdma, &cid, bad_wr,
+					      first_wr, sqecount, ret);
+	return 0;
 }
 
 /**
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 9b623849723e..b62d0a0ea816 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -179,6 +179,7 @@ static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
 	init_llist_head(&cma_xprt->sc_recv_ctxts);
 	init_llist_head(&cma_xprt->sc_rw_ctxts);
 	init_waitqueue_head(&cma_xprt->sc_send_wait);
+	init_waitqueue_head(&cma_xprt->sc_sq_ticket_wait);
 
 	spin_lock_init(&cma_xprt->sc_lock);
 	spin_lock_init(&cma_xprt->sc_rq_dto_lock);
@@ -478,6 +479,8 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	if (newxprt->sc_sq_depth > dev->attrs.max_qp_wr)
 		newxprt->sc_sq_depth = dev->attrs.max_qp_wr;
 	atomic_set(&newxprt->sc_sq_avail, newxprt->sc_sq_depth);
+	atomic_set(&newxprt->sc_sq_ticket_head, 0);
+	atomic_set(&newxprt->sc_sq_ticket_tail, 0);
 
 	newxprt->sc_pd = ib_alloc_pd(dev, 0);
 	if (IS_ERR(newxprt->sc_pd)) {
@@ -648,7 +651,8 @@ static int svc_rdma_has_wspace(struct svc_xprt *xprt)
 	 * If there are already waiters on the SQ,
 	 * return false.
 	 */
-	if (waitqueue_active(&rdma->sc_send_wait))
+	if (waitqueue_active(&rdma->sc_send_wait) ||
+	    waitqueue_active(&rdma->sc_sq_ticket_wait))
 		return 0;
 
 	/* Otherwise return true. */
-- 
2.53.0


