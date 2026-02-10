Return-Path: <linux-nfs+bounces-18854-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOQKOCpei2mYUAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18854-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:34:50 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AF411D41F
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C5363074F1B
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 16:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A1F305E3B;
	Tue, 10 Feb 2026 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAqG5YBe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CA02DECCC;
	Tue, 10 Feb 2026 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770741156; cv=none; b=L7a5xXJEnxnAvfRvleEzcG+ESRKaT+ZIw0ysVQEJf21AL3FdUqypGLeYwDeBJHYBWtc1ZoDSiDcFnkR2pwtA75bSyqPG1T1lOE3ccQwfQ0oWW6UMdJnotDL2ZtDp3yhLYwBHy+2OBJHOnO6nfr0QvKrP83M80rimBp+fLkzaPHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770741156; c=relaxed/simple;
	bh=y3e+HK3AJAQ1H4PVuUZR0LNCdZjtQgJv0MxfBK8U5QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjBg/uwuMMcZLBepDdsgX/a5OP+Wtod3cylsP4RUQqZAnvXdV9oxoqydsXkyP685f2a95fwX7fPuFzCqVSijRVnfNi00aZ1QKePppKZdvR9mxtBzibO89diQtcVZ/HfpLtut4bLDRWYi3YH86zEf+KcZCXc2R28YPtwCAJCLSY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAqG5YBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B73CC19421;
	Tue, 10 Feb 2026 16:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770741155;
	bh=y3e+HK3AJAQ1H4PVuUZR0LNCdZjtQgJv0MxfBK8U5QA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OAqG5YBeeJYD4zWnQiFxZVPZuGn+885as6J1Kb0chAqZVJax7rYBCbcq7R0ljsq5F
	 FZCThL/vjXy2NJfiGQHQdgMIOYUnVHdh2+JWb4lZAzydZZciPlimXa1ufxFTfNDwU7
	 1tWYeE5oGYkwig5cGSLBJfEgdt/thGKbHoCN381vH3bgUNg0tIr5wkro+Qi5R/r2fv
	 G99QsZrmhY46okE4UiaPhkiIjqdQGct/kLT1QJrj9726Xa1PDoJ1wY8KbQEtFkv/kV
	 m/gUL5jr4Q9fK6vwM5aRgVvbb3dAIaO+rEW2WPn0AP3WjBxkc3yegDpDc10ON33s8Z
	 6v9eeY/PvbKgA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 11/15] svcrdma: Use watermark-based Receive Queue replenishment
Date: Tue, 10 Feb 2026 11:32:18 -0500
Message-ID: <20260210163222.2356793-12-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-18854-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 82AF411D41F
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
 include/linux/sunrpc/svc_rdma.h          | 22 ++++++++++++-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  | 41 ++++++++++++++++--------
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 11 +++----
 3 files changed, 54 insertions(+), 20 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 874941b22485..8e78f958fa46 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -106,7 +106,6 @@ struct svcxprt_rdma {
 
 	/* Receive path */
 	u32		     sc_pending_recvs ____cacheline_aligned_in_smp;
-	u32		     sc_recv_batch;
 	struct llist_head    sc_rq_dto_q;
 	struct llist_head    sc_read_complete_q;
 
@@ -143,6 +142,27 @@ enum {
 	RPCRDMA_MAX_BC_REQUESTS	= 2,
 };
 
+/*
+ * Receive Queue provisioning constants for watermark-based replenishment.
+ *
+ * The Receive Queue is sized at twice the credit limit to enable
+ * batched posting that reduces doorbell overhead. Replenishment
+ * occurs when posted receives drop below the credit limit (the
+ * low watermark), refilling to full capacity.
+ */
+enum {
+	/* Queue depth = sc_max_requests * multiplier */
+	SVCRDMA_RQ_DEPTH_MULT		= 2,
+
+	/* Total recv_ctxt pool = sc_max_requests * multiplier
+	 * (RQ_DEPTH_MULT for posted receives + 1 for RPCs in process)
+	 */
+	SVCRDMA_RECV_CTXT_MULT		= 3,
+
+	/* Overhead entries in RQ: sc_max_bc_requests + drain sentinel */
+	SVCRDMA_RQ_OVERHEAD		= 3,
+};
+
 #define RPCSVC_MAXPAYLOAD_RDMA	RPCSVC_MAXPAYLOAD
 
 /**
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 0c048eaf2b8e..333b9468a15b 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -301,10 +301,11 @@ bool svc_rdma_post_recvs(struct svcxprt_rdma *rdma)
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
 
@@ -314,7 +315,8 @@ bool svc_rdma_post_recvs(struct svcxprt_rdma *rdma)
 		llist_add(&ctxt->rc_node, &rdma->sc_recv_ctxts);
 	}
 
-	return svc_rdma_refresh_recvs(rdma, rdma->sc_max_requests);
+	return svc_rdma_refresh_recvs(rdma,
+				rdma->sc_max_requests * SVCRDMA_RQ_DEPTH_MULT);
 }
 
 /**
@@ -338,18 +340,31 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 		goto flushed;
 	trace_svcrdma_wc_recv(wc, &ctxt->rc_cid);
 
-	/* If receive posting fails, the connection is about to be
-	 * lost anyway. The server will not be able to send a reply
-	 * for this RPC, and the client will retransmit this RPC
-	 * anyway when it reconnects.
+	/* Watermark-based receive posting: The Receive Queue is
+	 * provisioned with SVCRDMA_RQ_DEPTH_MULT times the number of
+	 * credits (sc_max_requests). Replenish when posted Receives
+	 * drops below sc_max_requests (the low watermark), posting
+	 * back to full capacity.
 	 *
-	 * Therefore we drop the Receive, even if status was SUCCESS
-	 * to reduce the likelihood of replayed requests once the
-	 * client reconnects.
+	 * This batching reduces doorbell rate compared to posting a
+	 * fixed small batch on every completion, while ensuring
+	 * the Receive Queue is never empty.
+	 *
+	 * If posting fails, a connection teardown is imminent. The
+	 * server will not be able to send a reply for this RPC, and
+	 * the client will retransmit this RPC anyway when it
+	 * reconnects. Therefore drop the Receive, even if status was
+	 * SUCCESS, to reduce the likelihood of replayed requests once
+	 * the client reconnects.
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
index 0a3969d36a80..5982006c65a0 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -439,7 +439,6 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	newxprt->sc_max_req_size = svcrdma_max_req_size;
 	newxprt->sc_max_requests = svcrdma_max_requests;
 	newxprt->sc_max_bc_requests = svcrdma_max_bc_requests;
-	newxprt->sc_recv_batch = RPCRDMA_MAX_RECV_BATCH;
 	newxprt->sc_fc_credits = cpu_to_be32(newxprt->sc_max_requests);
 
 	/* Qualify the transport's resource defaults with the
@@ -452,12 +451,12 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	newxprt->sc_max_send_sges += (svcrdma_max_req_size / PAGE_SIZE) + 1;
 	if (newxprt->sc_max_send_sges > dev->attrs.max_send_sge)
 		newxprt->sc_max_send_sges = dev->attrs.max_send_sge;
-	rq_depth = newxprt->sc_max_requests + newxprt->sc_max_bc_requests +
-		   newxprt->sc_recv_batch + 1 /* drain */;
+	rq_depth = (newxprt->sc_max_requests * SVCRDMA_RQ_DEPTH_MULT) +
+		   newxprt->sc_max_bc_requests + 1 /* drain */;
 	if (rq_depth > dev->attrs.max_qp_wr) {
 		rq_depth = dev->attrs.max_qp_wr;
-		newxprt->sc_recv_batch = 1;
-		newxprt->sc_max_requests = rq_depth - 2;
+		newxprt->sc_max_requests =
+			(rq_depth - SVCRDMA_RQ_OVERHEAD) / SVCRDMA_RQ_DEPTH_MULT;
 		newxprt->sc_max_bc_requests = 2;
 	}
 
@@ -465,7 +464,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	 */
 	maxpayload = min(xprt->xpt_server->sv_max_payload,
 			 RPCSVC_MAXPAYLOAD_RDMA);
-	ctxts = newxprt->sc_max_requests * 3 *
+	ctxts = newxprt->sc_max_requests * SVCRDMA_RECV_CTXT_MULT *
 		rdma_rw_mr_factor(dev, newxprt->sc_port_num,
 				  maxpayload >> PAGE_SHIFT);
 
-- 
2.52.0


