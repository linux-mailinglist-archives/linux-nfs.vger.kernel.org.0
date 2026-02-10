Return-Path: <linux-nfs+bounces-18839-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHr0G+Fai2ljUAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18839-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:20:49 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1240111D102
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 728D8304021D
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 16:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BC52E7BCC;
	Tue, 10 Feb 2026 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpbmfYO2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F28C31B114
	for <linux-nfs@vger.kernel.org>; Tue, 10 Feb 2026 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770740433; cv=none; b=rzh8YGZ48uUbhdcSJlZhPyNg/0KPUTSVWhlYhJODLjiTw8/+1ze7+ZNAhPhkzI2lW63DHiIQHmcZjJYGQRrGn9bsVllAv3FTDhpGJZ3GJPK0o4Om/tocHxmWM858xLeKgY5COLBVM2Rf0gemHBYdaOVesX1B3UhCng6N0IS0oHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770740433; c=relaxed/simple;
	bh=iiw+T3/I+JexHeGIy00LYkshjG97a2byqseX1TRPN7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFEoI592fNSZ8w+tFFWKyuX1KYTrVg9CIBfvedNorGf4gEvgEgneSTAQ4w6pz5mLrwc0Esh0Ze3tQX7qheta4auhkrODd4Rlf8iSUyfokQKe0RvGL97lcNkPrADBNwK2jsx9In9yoyqoYUSzb6K2eUJrx+MLn0zhdZ8sO6I5Tx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpbmfYO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3FAC19424;
	Tue, 10 Feb 2026 16:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770740433;
	bh=iiw+T3/I+JexHeGIy00LYkshjG97a2byqseX1TRPN7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OpbmfYO2QQGG8J2d4DVuSONw8WCd3TQEFOC+l9mAcXgehxRqN0lY5bjx/I8UD8UTK
	 DsuAhJ9kMoxrrpWj4fUMC9XmNHntya7YtPqEszfm0IoIacFIWC9sIUjRRKRQwXyPAm
	 QOOA0geE/dc+xmojAwzDzD2ZWGxmWMg7zZg25NH0riowBjwXEGeR8LeF2dRy8p0FZ3
	 TS4gfvBX1yJDlxdm3LvPh3SCB3K8LffrOGgahKRDOXsO8M2ZSFeczFvOKqU7Kvss88
	 I4foC+5uzD4BVXs6lRSYjuGQeBikXEwAGtVSWmB4+ExjIp0lLQd+r8wbqmSddxn59X
	 rTJ/ciWN+ar3g==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 6/8] sunrpc: implement flat combining for TCP socket sends
Date: Tue, 10 Feb 2026 11:20:23 -0500
Message-ID: <20260210162025.2356389-7-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260210162025.2356389-1-cel@kernel.org>
References: <20260210162025.2356389-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-18839-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1240111D102
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
sends. TCP auto-corking naturally coalesces segments once the
first send places data in flight, avoiding the need for explicit
corking hints that would delay initial replies.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svcsock.h |   2 +
 net/sunrpc/svcsock.c           | 181 ++++++++++++++++++++++++++++-----
 2 files changed, 158 insertions(+), 25 deletions(-)

diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index b94096eeb890..fae760eaa9f7 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -54,6 +54,8 @@ struct svc_sock {
 
 	/* For sends (protected by xpt_mutex) */
 	struct bio_vec		*sk_bvec;
+	struct llist_head	sk_send_queue;	/* queued sends awaiting batch processing */
+	u64			sk_drain_avg_ns; /* EMA of batch drain time */
 
 	/* private TCP part */
 	/* On-the-wire fragment header: */
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index a89427b5fc70..e3fa81b63191 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1677,6 +1677,113 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 	return len;
 }
 
+/*
+ * Pending send request for flat combining.
+ * Stack-allocated by each thread enqueuing a send on a TCP socket.
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
+			   rpc_fraghdr marker);
+
+/*
+ * svc_tcp_wait_timeout - Compute adaptive timeout for flat combining wait
+ * @svsk: the socket with drain time statistics
+ *
+ * Timeout selection balances two constraints: short timeouts cause
+ * premature wakeups and unnecessary mutex acquisitions; long timeouts
+ * delay threads after batch processing completes.
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
+ * svc_tcp_combine_sends - Process batched send requests
+ * @svsk: the socket to send on
+ * @xprt: the transport (for dead check and close)
+ *
+ * Caller holds xpt_mutex. Drains sk_send_queue and processes each
+ * pending send. All items are completed before return, even on error.
+ */
+static void svc_tcp_combine_sends(struct svc_sock *svsk, struct svc_xprt *xprt)
+{
+	struct llist_node *pending, *node, *next;
+	struct svc_pending_send *ps;
+	bool transport_dead = false;
+	u64 start, elapsed, avg;
+	int sent;
+
+	/* Snapshot queued items; subsequent arrivals processed in next batch */
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
+		sent = svc_tcp_sendmsg(svsk, ps->rqstp, ps->marker);
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
+	/* EMA update: new = (7 * old + measured) / 8 */
+	elapsed = ktime_get_ns() - start;
+	avg = READ_ONCE(svsk->sk_drain_avg_ns);
+	WRITE_ONCE(svsk->sk_drain_avg_ns, avg ? (7 * avg + elapsed) / 8 : elapsed);
+}
+
 /*
  * MSG_SPLICE_PAGES is used exclusively to reduce the number of
  * copy operations in this path. Therefore the caller must ensure
@@ -1716,44 +1823,68 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
  * svc_tcp_sendto - Send out a reply on a TCP socket
  * @rqstp: completed svc_rqst
  *
- * xpt_mutex ensures @rqstp's whole message is written to the socket
- * without interruption.
+ * Flat combining reduces mutex contention: threads enqueue send
+ * requests; a single thread processes the batch while holding xpt_mutex
+ * to ensure RPC-level serialization.
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
+	/* Enqueue send request; lock-free via llist */
+	llist_add(&ps.node, &svsk->sk_send_queue);
+
+	/*
+	 * Flat combining: trylock attempts xpt_mutex acquisition; success
+	 * enables processing all queued requests. The mutex provides RPC-level
+	 * serialization while batching reduces lock handoff overhead.
+	 *
+	 * Trylock first for fast path. On contention, wait briefly for batch
+	 * processing to complete this request, then fall back to blocking
+	 * mutex_lock.
+	 */
+	if (mutex_trylock(&xprt->xpt_mutex))
+		goto combine;
+
+	/*
+	 * Lock held for batch processing. Wait for completion with timeout;
+	 * batch processing may complete this request during the wait.
+	 */
+	if (wait_for_completion_timeout(&ps.done, svc_tcp_wait_timeout(svsk))) {
+		/* Completed by batch processing */
+		return ps.result;
+	}
+
+	/*
+	 * Timeout expired. Acquire mutex to enable batch processing or
+	 * discover completion occurred during mutex acquisition.
+	 */
+	mutex_lock(&xprt->xpt_mutex);
+	if (completion_done(&ps.done)) {
+		mutex_unlock(&xprt->xpt_mutex);
+		return ps.result;
+	}
+
+combine:
+	/* Mutex held; process batches until queue drains. */
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


