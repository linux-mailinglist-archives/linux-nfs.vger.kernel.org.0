Return-Path: <linux-nfs+bounces-18760-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBQDE/m9hGnG4wMAu9opvQ
	(envelope-from <linux-nfs+bounces-18760-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Feb 2026 16:57:45 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 338D1F4D84
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Feb 2026 16:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A54D30065FA
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Feb 2026 15:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C9342DFE8;
	Thu,  5 Feb 2026 15:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+fHP68w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EC5421F10
	for <linux-nfs@vger.kernel.org>; Thu,  5 Feb 2026 15:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307057; cv=none; b=jrWmue7l6P6gKDRRvcVHwID3GvwlpOI9WBP01luPsfXQ7zQTRe59nyOeDz733GMS+i44FpWYBm1Pl244zwmaEle+tB2PPsQyzW3LPM13A414wiFlnLC/7Zr+MFWhdus/eXh6sF/8+JO8NZtdYYTI3gis6cYGDZIO34pKnodB4bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307057; c=relaxed/simple;
	bh=lMwoxKgL4uH8hi0S6zx2jsHdmyWiIkkkQ6ulLkp2m7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdbwMPYuQzOF7SnroVQBWlasP4rbvd+2tymTlSQ1M63tAim9TVTSAUWS/wXWpb+XMvsRhh6w92egMSbtZ6c/ldnyeOfwr6KPaxZMUrthD7EHzmqGivugcuH+xh/zE/W1BZbFDiFJpTMOqd3VF6kNKptrag1tAMpi5k6GA4Vrpz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+fHP68w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3ECC19424;
	Thu,  5 Feb 2026 15:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770307057;
	bh=lMwoxKgL4uH8hi0S6zx2jsHdmyWiIkkkQ6ulLkp2m7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L+fHP68wWnXEur/cqs6Xz96w/IKCfKdGQk6tPfxCeXjs3oZ5mxZoQWudK8GybRFAu
	 PemizrCO91leZGsfkSxuaW9nk85DoWIlSU5csaWFxFuHVCmU0hzawUR0XxyeSDvS7e
	 CnbHU5Dx1YN0vQVRuTYGjfzlj6Bjbc1fdMRrfvPw4/rsc50m63beRldIe+b3cB+x7Q
	 pGlr9etyW8/kquCz4KW7objZX/ZjO/UN68/C5x0gC4QpltE8zx2XudsdM34DFRJJMu
	 1HbNtMyYfVqDgbVcY4locCMX2/F1r3B9IAw+9Ki/lGMKfHkvel8IvaPAWV8+wBejIY
	 ttLR/2fWZIl9g==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	daire@dneg.com,
	Mike Snitzer <snitzer@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 5/7] sunrpc: implement flat combining for TCP socket sends
Date: Thu,  5 Feb 2026 10:57:27 -0500
Message-ID: <20260205155729.6841-6-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205155729.6841-1-cel@kernel.org>
References: <20260205155729.6841-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18760-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,dneg.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 338D1F4D84
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

High contention on xpt_mutex during TCP reply transmission limits
nfsd scalability. When multiple threads send replies on the same
connection, mutex handoff triggers optimistic spinning that consumes
substantial CPU time. Profiling on high-throughput workloads shows
approximately 15% of cycles spent in the spin-wait path.

The flat combining pattern addresses this by allowing one thread to
perform send operations on behalf of multiple waiting threads. Rather
than each thread acquiring xpt_mutex independently, threads enqueue
their send requests to a lock-free llist. The first thread to
acquire the mutex becomes the combiner and processes all pending
sends in a batch. Other threads wait on a per-request completion
structure instead of spinning on the lock.

The combiner continues processing the queue until empty before
releasing xpt_mutex, amortizing acquisition cost across multiple
sends. Setting MSG_MORE on all but the final send in each batch
hints TCP to coalesce segments, reducing protocol overhead when
multiple replies transmit in quick succession.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svcsock.h |   2 +
 net/sunrpc/svcsock.c           | 190 ++++++++++++++++++++++++++++-----
 2 files changed, 165 insertions(+), 27 deletions(-)

diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index 391ce9c14f2d..d085093769a1 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -54,6 +54,8 @@ struct svc_sock {
 
 	/* For sends (protected by xpt_mutex) */
 	struct bio_vec		*sk_bvec;
+	struct llist_head	sk_send_queue;	/* pending sends for combining */
+	u64			sk_drain_avg_ns; /* EMA of combiner drain time */
 
 	/* private TCP part */
 	/* On-the-wire fragment header: */
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index fa486a01ee3a..0a8f5695daf3 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1661,16 +1661,128 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 	return len;
 }
 
+/*
+ * Pending send request for flat combining.
+ * Stack-allocated by each thread that wants to send on a TCP socket.
+ */
+struct svc_pending_send {
+	struct llist_node	node;
+	struct svc_rqst		*rqstp;
+	rpc_fraghdr		marker;
+	struct completion	done;
+	int			result;
+};
+
+static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
+			   rpc_fraghdr marker, int msg_flags);
+
+/*
+ * svc_tcp_wait_timeout - Compute adaptive timeout for flat combining wait
+ * @svsk: the socket with drain time statistics
+ *
+ * Waiting threads need a timeout that balances two concerns: too short
+ * causes premature wakeups and unnecessary mutex acquisitions; too long
+ * delays threads when the combiner has already finished.
+ *
+ * LAN environments with fast networks and consistent latencies work well
+ * with fixed timeouts. WAN links exhibit higher variance in send times
+ * due to congestion, packet loss, and bandwidth constraints. An adaptive
+ * timeout based on observed drain times accommodates both cases without
+ * manual tuning.
+ *
+ * The timeout targets 2x the recent average drain time, clamped to
+ * [1ms, 100ms]. The multiplier provides headroom for variance while the
+ * floor prevents excessive wakeups and the ceiling bounds worst-case
+ * latency when measurements are anomalous.
+ *
+ * Returns: timeout in jiffies
+ */
+static unsigned long svc_tcp_wait_timeout(struct svc_sock *svsk)
+{
+	u64 avg_ns = READ_ONCE(svsk->sk_drain_avg_ns);
+	unsigned long timeout;
+
+	/* Initial timeout before measurements are available */
+	if (!avg_ns)
+		return msecs_to_jiffies(10);
+
+	timeout = nsecs_to_jiffies(avg_ns * 2);
+	return clamp(timeout, msecs_to_jiffies(1), msecs_to_jiffies(100));
+}
+
+/*
+ * svc_tcp_combine_sends - Process batched send requests as combiner
+ * @svsk: the socket to send on
+ * @xprt: the transport (for dead check and close)
+ *
+ * Called with xpt_mutex held. Drains sk_send_queue and processes each
+ * pending send. All items are completed before returning, even on error.
+ */
+static void svc_tcp_combine_sends(struct svc_sock *svsk, struct svc_xprt *xprt)
+{
+	struct llist_node *pending, *node, *next;
+	struct svc_pending_send *ps;
+	bool transport_dead = false;
+	u64 start, elapsed, avg;
+	int sent;
+
+	/* Take a snapshot of queued items; new arrivals go to next combiner */
+	pending = llist_del_all(&svsk->sk_send_queue);
+	if (!pending)
+		return;
+
+	start = ktime_get_ns();
+
+	for (node = pending; node; node = next) {
+		next = node->next;
+		ps = container_of(node, struct svc_pending_send, node);
+
+		if (transport_dead || svc_xprt_is_dead(xprt)) {
+			transport_dead = true;
+			ps->result = -ENOTCONN;
+			complete(&ps->done);
+			continue;
+		}
+
+		/*
+		 * Set MSG_MORE if there are more items queued, hinting
+		 * TCP to delay pushing until the batch completes.
+		 */
+		sent = svc_tcp_sendmsg(svsk, ps->rqstp, ps->marker,
+				       next ? MSG_MORE : 0);
+		trace_svcsock_tcp_send(xprt, sent);
+
+		if (sent == ps->rqstp->rq_res.len + sizeof(ps->marker)) {
+			ps->result = sent;
+		} else {
+			pr_notice("rpc-srv/tcp: %s: %s (%d of %zu bytes) - shutting down socket\n",
+				  xprt->xpt_server->sv_name,
+				  sent < 0 ? "send error" : "short send", sent,
+				  ps->rqstp->rq_res.len + sizeof(ps->marker));
+			svc_xprt_deferred_close(xprt);
+			transport_dead = true;
+			ps->result = -EAGAIN;
+		}
+
+		complete(&ps->done);
+	}
+
+	/* Update drain time EMA: new = (7 * old + measured) / 8 */
+	elapsed = ktime_get_ns() - start;
+	avg = READ_ONCE(svsk->sk_drain_avg_ns);
+	WRITE_ONCE(svsk->sk_drain_avg_ns, avg ? (7 * avg + elapsed) / 8 : elapsed);
+}
+
 /*
  * MSG_SPLICE_PAGES is used exclusively to reduce the number of
  * copy operations in this path. Therefore the caller must ensure
  * that the pages backing @xdr are unchanging.
  */
 static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
-			   rpc_fraghdr marker)
+			   rpc_fraghdr marker, int msg_flags)
 {
 	struct msghdr msg = {
-		.msg_flags	= MSG_SPLICE_PAGES,
+		.msg_flags	= MSG_SPLICE_PAGES | msg_flags,
 	};
 	unsigned int count;
 	void *buf;
@@ -1700,44 +1812,68 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
  * svc_tcp_sendto - Send out a reply on a TCP socket
  * @rqstp: completed svc_rqst
  *
- * xpt_mutex ensures @rqstp's whole message is written to the socket
- * without interruption.
+ * Uses flat combining to reduce mutex contention: threads enqueue their
+ * send requests and one thread (the "combiner") processes the batch.
+ * xpt_mutex ensures RPC-level serialization while the combiner holds it.
  *
  * Returns the number of bytes sent, or a negative errno.
  */
 static int svc_tcp_sendto(struct svc_rqst *rqstp)
 {
 	struct svc_xprt *xprt = rqstp->rq_xprt;
-	struct svc_sock	*svsk = container_of(xprt, struct svc_sock, sk_xprt);
+	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
 	struct xdr_buf *xdr = &rqstp->rq_res;
-	rpc_fraghdr marker = cpu_to_be32(RPC_LAST_STREAM_FRAGMENT |
-					 (u32)xdr->len);
-	int sent;
+	struct svc_pending_send ps = {
+		.rqstp = rqstp,
+		.marker = cpu_to_be32(RPC_LAST_STREAM_FRAGMENT | (u32)xdr->len),
+	};
 
 	svc_tcp_release_ctxt(xprt, rqstp->rq_xprt_ctxt);
 	rqstp->rq_xprt_ctxt = NULL;
 
-	mutex_lock(&xprt->xpt_mutex);
-	if (svc_xprt_is_dead(xprt))
-		goto out_notconn;
-	sent = svc_tcp_sendmsg(svsk, rqstp, marker);
-	trace_svcsock_tcp_send(xprt, sent);
-	if (sent < 0 || sent != (xdr->len + sizeof(marker)))
-		goto out_close;
-	mutex_unlock(&xprt->xpt_mutex);
-	return sent;
+	init_completion(&ps.done);
 
-out_notconn:
+	/* Enqueue this send request; lock-free via llist */
+	llist_add(&ps.node, &svsk->sk_send_queue);
+
+	/*
+	 * Flat combining: threads compete for xpt_mutex; the winner becomes
+	 * the combiner and processes all queued requests. The mutex provides
+	 * RPC-level serialization while combining reduces lock handoff overhead.
+	 *
+	 * Use trylock first for the fast path. On contention, wait briefly
+	 * to see if the current combiner handles our request, then fall back
+	 * to blocking mutex_lock.
+	 */
+	if (mutex_trylock(&xprt->xpt_mutex))
+		goto combine;
+
+	/*
+	 * Combiner holds the lock. Wait for completion with a timeout;
+	 * the combiner may process our request while we wait.
+	 */
+	if (wait_for_completion_timeout(&ps.done, svc_tcp_wait_timeout(svsk))) {
+		/* Completed by the combiner */
+		return ps.result;
+	}
+
+	/*
+	 * Timed out waiting. Acquire mutex to either become the new combiner
+	 * or find that our request was completed in the meantime.
+	 */
+	mutex_lock(&xprt->xpt_mutex);
+	if (completion_done(&ps.done)) {
+		mutex_unlock(&xprt->xpt_mutex);
+		return ps.result;
+	}
+
+combine:
+	/* We are the combiner. Process until queue is empty. */
+	while (!llist_empty(&svsk->sk_send_queue))
+		svc_tcp_combine_sends(svsk, xprt);
 	mutex_unlock(&xprt->xpt_mutex);
-	return -ENOTCONN;
-out_close:
-	pr_notice("rpc-srv/tcp: %s: %s %d when sending %zu bytes - shutting down socket\n",
-		  xprt->xpt_server->sv_name,
-		  (sent < 0) ? "got error" : "sent",
-		  sent, xdr->len + sizeof(marker));
-	svc_xprt_deferred_close(xprt);
-	mutex_unlock(&xprt->xpt_mutex);
-	return -EAGAIN;
+
+	return ps.result;
 }
 
 static struct svc_xprt *svc_tcp_create(struct svc_serv *serv,
-- 
2.52.0


