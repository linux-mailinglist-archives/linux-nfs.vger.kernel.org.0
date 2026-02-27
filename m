Return-Path: <linux-nfs+bounces-19408-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KqKBmamoWmqvQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19408-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:12:54 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4FE1B8853
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA5B430E9121
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 14:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F46410D2B;
	Fri, 27 Feb 2026 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MULq5GKh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3775B28A72B
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201037; cv=none; b=MB7mEvfm5Ypi9QtWV3Xz1tKpTjgpLQFtuWpJpwyCqqzsQp6jsp1ASjkO126f7qao2QZkOvqp3HSCxdCViX/ycmULHTuSxRjv8htPBX7K646RkYAMNZVqHzkVAH8R6zvIWiau3RR4B134m/IVIOcKQEYR7fzb31Wb2YRYqzzk0lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201037; c=relaxed/simple;
	bh=Q59zENFuGAAMIS/To3m+H7Ea/DPf2z8HZ2bJXwwDOEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfHblImpwxIh3sLF2MloIsGzaNYO5E8Nr97EbUh8j+3iCC4HMW5xHoVX+NQNGpm4l3K5VAwsykaqrDdk/1ewH8ibcGc9ouz1zZwli5X2QwKz9+mZ42hgiVoitzzyH3pXQwsmseLeUqdYztIzsldqydmsOYta22Hw6Y9iMISOUPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MULq5GKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F0BC2BC86;
	Fri, 27 Feb 2026 14:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772201036;
	bh=Q59zENFuGAAMIS/To3m+H7Ea/DPf2z8HZ2bJXwwDOEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MULq5GKhzHadCUa0DG/xOy9B3Xxd4K3vGyz9BqLUFj/oPGjAMUGVcwmlrF9r40uYp
	 F/Un5gwN5mQlg7h7tiHkjR5upbEKIVjKvnyVsmD5vFGGHZdMDMVqnCNx/OR/L4ZnLl
	 2E2O2C7TTvGFsVJGGuq4LBlQtPdhyVUJ1Rw33AYlhvz3jvIFP7qgVmuZeMrK2QMQCs
	 kgDaUhIOkLaH3AaNXjP1rgTDEd2JCXqGjIZpCWylVzSvQ1kbUWw92hKrErHKYr8mKK
	 3hI75u1MOfYbaUaqYgceU1L9aMNoSObqbJ1JgDq3YxS/xbReuq2W5yHa1q+a/cT7KP
	 Sff2YXssD3cGw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 11/18] svcrdma: Use watermark-based Receive Queue replenishment
Date: Fri, 27 Feb 2026 09:03:38 -0500
Message-ID: <20260227140345.40488-12-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19408-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 8C4FE1B8853
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The current Receive posting strategy posts a small fixed batch of
Receives on every completion when the queue depth drops below the
maximum. At high message rates this results in frequent
ib_post_recv() calls, each incurring doorbell overhead.

The Receive Queue is now provisioned with twice the negotiated
credit limit (sc_max_requests). Replenishment is triggered when the
number of posted Receives drops below the credit limit (the low
watermark), posting enough Receives to refill the queue to capacity.

For a typical configuration with a credit limit of 128:
- Receive Queue depth: 256
- Low watermark: 128 (replenish when half consumed)
- Batch size: ~128 Receives per posting

Tying the watermark to the credit limit rather than a percentage of
queue capacity ensures adequate buffering regardless of the
configured credit limit. Even with a small credit limit, at least
one full credit window remains posted, guaranteeing forward
progress.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h          | 23 +++++++++++++-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  | 40 ++++++++++++++++--------
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 13 ++++----
 3 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 562a5f78cd3f..ef52af656581 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -128,7 +128,6 @@ struct svcxprt_rdma {
 
 	/* Receive path */
 	u32		     sc_pending_recvs ____cacheline_aligned_in_smp;
-	u32		     sc_recv_batch;
 	struct llist_head    sc_rq_dto_q;
 	struct llist_head    sc_read_complete_q;
 
@@ -163,6 +162,28 @@ enum {
 	RPCRDMA_MAX_BC_REQUESTS	= 2,
 };
 
+/*
+ * Receive Queue provisioning constants for watermark-based replenishment.
+ *
+ * Queue depth is twice the credit limit to support batched
+ * posting that reduces doorbell overhead. When posted receives
+ * drop below the credit limit (the low watermark),
+ * svc_rdma_wc_receive() posts enough Receives to refill the
+ * queue to capacity.
+ */
+enum {
+	/* Queue depth = sc_max_requests * multiplier */
+	SVCRDMA_RQ_DEPTH_MULT		= 2,
+
+	/* Total recv_ctxt pool = sc_max_requests * multiplier
+	 * (RQ_DEPTH_MULT for posted receives + 1 for RPCs in process)
+	 */
+	SVCRDMA_RECV_CTXT_MULT		= SVCRDMA_RQ_DEPTH_MULT + 1,
+
+	/* rdma_rw contexts per request: Read + Write + Reply chunks */
+	SVCRDMA_RW_CTXT_MULT		= 3,
+};
+
 #define RPCSVC_MAXPAYLOAD_RDMA	RPCSVC_MAXPAYLOAD
 
 /**
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 2281f9adc9f3..a11e845a7113 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -303,10 +303,11 @@ bool svc_rdma_post_recvs(struct svcxprt_rdma *rdma)
 {
 	unsigned int total;
 
-	/* For each credit, allocate enough recv_ctxts for one
-	 * posted Receive and one RPC in process.
+	/* Allocate enough recv_ctxts for:
+	 * - SVCRDMA_RQ_DEPTH_MULT * sc_max_requests posted on the RQ
+	 * - sc_max_requests RPCs in process
 	 */
-	total = (rdma->sc_max_requests * 2) + rdma->sc_recv_batch;
+	total = rdma->sc_max_requests * SVCRDMA_RECV_CTXT_MULT;
 	while (total--) {
 		struct svc_rdma_recv_ctxt *ctxt;
 
@@ -316,7 +317,8 @@ bool svc_rdma_post_recvs(struct svcxprt_rdma *rdma)
 		llist_add(&ctxt->rc_node, &rdma->sc_recv_ctxts);
 	}
 
-	return svc_rdma_refresh_recvs(rdma, rdma->sc_max_requests);
+	return svc_rdma_refresh_recvs(rdma,
+				rdma->sc_max_requests * SVCRDMA_RQ_DEPTH_MULT);
 }
 
 /**
@@ -340,18 +342,30 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 		goto flushed;
 	trace_svcrdma_wc_recv(wc, &ctxt->rc_cid);
 
-	/* If receive posting fails, the connection is about to be
-	 * lost anyway. The server will not be able to send a reply
-	 * for this RPC, and the client will retransmit this RPC
-	 * anyway when it reconnects.
+	/* Watermark-based receive posting: The Receive Queue is
+	 * provisioned at SVCRDMA_RQ_DEPTH_MULT times the credit
+	 * count (sc_max_requests). When posted Receives drop below
+	 * sc_max_requests (the low watermark), this handler posts
+	 * enough Receives to refill the queue to capacity.
 	 *
-	 * Therefore we drop the Receive, even if status was SUCCESS
-	 * to reduce the likelihood of replayed requests once the
-	 * client reconnects.
+	 * Batched posting reduces doorbell rate compared to posting
+	 * a fixed small batch on every completion, while keeping
+	 * the Receive Queue populated.
+	 *
+	 * If posting fails, connection teardown is imminent. No
+	 * reply can be sent for this RPC, and the client will
+	 * retransmit after reconnecting. Drop the Receive, even
+	 * if status was SUCCESS, to reduce replay likelihood after
+	 * reconnection.
 	 */
-	if (rdma->sc_pending_recvs < rdma->sc_max_requests)
-		if (!svc_rdma_refresh_recvs(rdma, rdma->sc_recv_batch))
+	if (rdma->sc_pending_recvs < rdma->sc_max_requests) {
+		unsigned int target =
+			(rdma->sc_max_requests * SVCRDMA_RQ_DEPTH_MULT) -
+			rdma->sc_pending_recvs;
+
+		if (!svc_rdma_refresh_recvs(rdma, target))
 			goto dropped;
+	}
 
 	/* All wc fields are now known to be valid */
 	ctxt->rc_byte_len = wc->byte_len;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 719566234277..772f02317895 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -439,7 +439,6 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	newxprt->sc_max_req_size = svcrdma_max_req_size;
 	newxprt->sc_max_requests = svcrdma_max_requests;
 	newxprt->sc_max_bc_requests = svcrdma_max_bc_requests;
-	newxprt->sc_recv_batch = RPCRDMA_MAX_RECV_BATCH;
 	newxprt->sc_fc_credits = cpu_to_be32(newxprt->sc_max_requests);
 
 	/* Qualify the transport's resource defaults with the
@@ -452,12 +451,14 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	newxprt->sc_max_send_sges += (svcrdma_max_req_size / PAGE_SIZE) + 1;
 	if (newxprt->sc_max_send_sges > dev->attrs.max_send_sge)
 		newxprt->sc_max_send_sges = dev->attrs.max_send_sge;
-	rq_depth = newxprt->sc_max_requests + newxprt->sc_max_bc_requests +
-		   newxprt->sc_recv_batch + 1 /* drain */;
+	rq_depth = (newxprt->sc_max_requests * SVCRDMA_RQ_DEPTH_MULT) +
+		   newxprt->sc_max_bc_requests + 1 /* drain */;
 	if (rq_depth > dev->attrs.max_qp_wr) {
+		unsigned int overhead = newxprt->sc_max_bc_requests + 1;
+
 		rq_depth = dev->attrs.max_qp_wr;
-		newxprt->sc_recv_batch = 1;
-		newxprt->sc_max_requests = rq_depth - 2;
+		newxprt->sc_max_requests =
+			(rq_depth - overhead) / SVCRDMA_RQ_DEPTH_MULT;
 		newxprt->sc_max_bc_requests = 2;
 	}
 
@@ -468,7 +469,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	 */
 	maxpayload = min(xprt->xpt_server->sv_max_payload,
 			 RPCSVC_MAXPAYLOAD_RDMA);
-	ctxts = newxprt->sc_max_requests * 3 *
+	ctxts = newxprt->sc_max_requests * SVCRDMA_RW_CTXT_MULT *
 		rdma_rw_mr_factor(dev, newxprt->sc_port_num,
 				  maxpayload >> PAGE_SHIFT);
 
-- 
2.53.0


