Return-Path: <linux-nfs+bounces-21969-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAdwOMaqFWpuXgcAu9opvQ
	(envelope-from <linux-nfs+bounces-21969-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 16:14:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CFD5D73D2
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 16:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 230B63013EDC
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 14:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEB93FE660;
	Tue, 26 May 2026 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5rtFL1Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268A43FE357;
	Tue, 26 May 2026 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804853; cv=none; b=EuH0xEJe4E5yMyTJd9E7rgqA64AOXLfhu9k7UZcPcgG1zmMx2ws9K5Z4k39W5DjIKtiX8ht5RBu2XMgDGuZD4rj4RKWT5sxELR/EJkVTI/jVcq+JLzRl4V0n+SaSWfwSAKTz+dyw3P0RqlNVMwgoPnKdfxzbV1uQdttlO+UfGHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804853; c=relaxed/simple;
	bh=7mkquXFd/dd4EOdIJ5PnAu7GZA16S+ZjbZQ7lTghWaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NdjMzl5Plu6KJKUUWMX1eDxzFkNAgGu8D+1h8bjYimsJRAwHXZ6ExHNiSOa2YvUA3rPvOZPum1knuLmp8BlfF47aInAs1c1sxx/lyFjEfeqfufv3p8oyS/lN/CFAdgRDD+MCSFczI2vk27bJPH1NRfD0Ng8397tB4VPuU1EeSRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5rtFL1Y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895B41F00A3C;
	Tue, 26 May 2026 14:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779804851;
	bh=LXxk4hWKGM9djPc2N7eE7IWZCzTCa9JDU/sCbqIRC7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m5rtFL1YohIS/UPtkW85+Xl/sHf8ZaqofdOAQuWABFVi+GZd/z/fbKYUFVUPn9et/
	 8wPAFvX3YGMwB9YEQ2+XXBRQw7wfCy3NunsHct7pGlXvHJ4KOaXgD3hBU+gA0XLBAz
	 x98FnwEx7xZk59yO5DMLWFih/HzjZl0wisy1QQdjFO+PkP09Nom0ORwfDk22m8SXHt
	 Dtzks4vUSJYiK0ons8RgOR/7E6rK7DpDE14/gC7B4T/+/0ug0Ktump8Y98dCZ+ImSD
	 XnFfaoAcXQoYyZSsQOL00z5PCi2W0ugQ6yjXsQTZTaAC+rVL1FI53ZSvGtFGrvst3z
	 VLjyPVr9mcD3A==
From: Chuck Lever <cel@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: <linux-rdma@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 3/5] xprtrdma: Add request-pool slack for delayed recycling
Date: Tue, 26 May 2026 10:14:03 -0400
Message-ID: <20260526141405.39877-4-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21969-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 67CFD5D73D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

After the previous patch gates req recycling on Send completion,
a completed RPC's rpcrdma_req can remain pinned by the sendctx
ring until the next signaled Send completion releases it. The
transmitted-RPC ceiling is unchanged: xprt_request_get_cong()
gates Sends against xprt->cwnd, the RPC/RDMA credit window fed
by server-granted credits and capped at re_max_requests. The
req pool, however, must exceed max_reqs by enough that this
recycle delay does not stall a slot allocation that the credit
window would admit.

The headroom is bounded. frwr_open() sets re_send_batch to
re_max_requests >> 3 -- one in every eight Sends is signaled --
so at most re_send_batch unsignaled Sends can be outstanding
before the next signaled completion releases them. That equals
max_reqs / 8 reqs in the worst case, with a one-slot floor for
small max_reqs values where the right-shift rounds to zero.

The sendctx ring and the hardware Send Queue are not enlarged
to match. Both are sized in rpcrdma_sendctxs_create() and
frwr_query_device() for re_max_requests in-flight Sends, which
is the ceiling the credit window enforces. The pool slack does
not raise that ceiling -- it only lets allocation keep pace
with the credit window during the brief interval in which
earlier reqs are pinned waiting for the next signaled
completion. At any moment, at most re_send_batch sendctxes are
held by unswept unsignaled Sends, leaving the rest of the ring
available for newly admitted Sends.

Allocate max_reqs + DIV_ROUND_UP(max_reqs, 8) request objects
and name the slack calculation at the allocation site so the
1/8 bound stays tied to the Send-signaling batch size.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 97b8b2376602..98bd965787e6 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1080,6 +1080,22 @@ static void rpcrdma_reps_destroy(struct rpcrdma_buffer *buf)
 	spin_unlock(&buf->rb_lock);
 }
 
+static unsigned int rpcrdma_req_pool_slack(unsigned int max_reqs)
+{
+	/* The sendctx ring can hold up to one Send-signaling batch
+	 * (re_send_batch, set by frwr_open() to re_max_requests >> 3)
+	 * of unfinished Sends. Each pins its req until a signaled Send
+	 * completion releases the sendctx. Size the pool above max_reqs
+	 * by that batch so the recycle delay does not stall a slot
+	 * allocation that the RPC/RDMA credit window would admit.
+	 *
+	 * Round up: re_max_requests >> 3 is zero when max_reqs < 8, but
+	 * a single unsignaled Send is still enough to pin one req. One
+	 * slack slot covers that case.
+	 */
+	return DIV_ROUND_UP(max_reqs, 8);
+}
+
 /**
  * rpcrdma_buffer_create - Create initial set of req/rep objects
  * @r_xprt: transport instance to (re)initialize
@@ -1089,6 +1105,7 @@ static void rpcrdma_reps_destroy(struct rpcrdma_buffer *buf)
 int rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
 {
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
+	unsigned int max_reqs;
 	int i, rc;
 
 	buf->rb_bc_srv_max_requests = 0;
@@ -1102,7 +1119,9 @@ int rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
 	INIT_LIST_HEAD(&buf->rb_all_reps);
 
 	rc = -ENOMEM;
-	for (i = 0; i < r_xprt->rx_xprt.max_reqs; i++) {
+	max_reqs = r_xprt->rx_xprt.max_reqs;
+	max_reqs += rpcrdma_req_pool_slack(max_reqs);
+	for (i = 0; i < max_reqs; i++) {
 		struct rpcrdma_req *req;
 
 		req = rpcrdma_req_create(r_xprt,
-- 
2.54.0


