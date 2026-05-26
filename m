Return-Path: <linux-nfs+bounces-21967-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IG1bK86sFWrgXgcAu9opvQ
	(envelope-from <linux-nfs+bounces-21967-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 16:23:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 537135D7648
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 16:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC03E3042E55
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 14:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54773FD13B;
	Tue, 26 May 2026 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/cLW7Qh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51023B9935;
	Tue, 26 May 2026 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804851; cv=none; b=W22tBAk3kCKVOjv3ht011PwQBxA/jw7P06K7BfJgC2ohYT0nt5COEU1pmc7xHRVF44Amx/SqROEVgvdxP6GPjB0WPIRxQkSK/uEWrz/nUTja/NKDEARETQn0oZ8uE0zMkhcyG3iw3PxuuSYzKGrdLDnzTSr+pcuEycHqteV2V1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804851; c=relaxed/simple;
	bh=XWTefVIn7GASisAnJeS9nBFWwYBW/22XnkQB1XyYkVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWM/xSI4se2l5GAlA75a7K6TWTAzjn39qg0/NjPAU6Rzq/TMrrO1ADPO8QvIApHTev7x4jIddvuovVffjtcMqv8Z9wCCzx1KlL9zIgSellgm3QZJSE4OhHdnivLEsVn2hdoGnO+gUrAcqJFj4jaSSgiju6jgpR+9Kc/dU4ZQO9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/cLW7Qh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462EA1F00A3A;
	Tue, 26 May 2026 14:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779804850;
	bh=3qFxGfNI+DFzjVRcQB858Php3hAsReJ35Zc57upwwU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W/cLW7QhkS1i6BmTdus7xAxEAR0qoJST+VgdDxhDJvBtDVsP/MjfS492LAZVkGAzG
	 GxoWrHzO2LWDfAcS6XnHvujWfaM06hfeXN/9W4GyvTwKt4CIQFCJx0OVdRjf9ki6A9
	 tP32ovfp0PHayNi8AQ1IS4Ec8YZFwn06FmwC+ak16KSLHR3wuo2KJG9AuPI8spDXHV
	 zPGrJtGSLGSQ6RmOwJlMdhMK2xhBBBNEIRq7ZG/D+I2Hi3NrU0ozPmMun+iU1a6xE+
	 WF/X3PkRza0oYNtQRSuzupSsiyya616oNDC4FA7BCM16wRIp6S0WWhtfTsdOcZjl+v
	 4VfLlb82uoH9A==
From: Chuck Lever <cel@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: <linux-rdma@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 1/5] xprtrdma: Use sendctx DMA state for Send signaling
Date: Tue, 26 May 2026 10:14:01 -0400
Message-ID: <20260526141405.39877-2-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-21967-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 537135D7648
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Send signaling matters only when the prepared Send has page
mappings to unmap. Today that test is expressed indirectly with
rl_kref, because the Send-side reference is taken only for Sends
with mapped SGEs.

Split the SGE DMA unmap loop into its own helper and use
sc_unmap_count directly for the signaling decision. This keeps the
current behavior but removes one dependency on the old rl_kref
semantics before the request lifetime rules are changed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c |  2 +-
 net/sunrpc/xprtrdma/rpc_rdma.c | 22 +++++++++++++---------
 2 files changed, 14 insertions(+), 10 deletions(-)

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
index 0e0f21974710..16b9987858d6 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -477,19 +477,11 @@ static void rpcrdma_sendctx_done(struct kref *kref)
 	rep->rr_rxprt->rx_stats.reply_waits_for_send++;
 }
 
-/**
- * rpcrdma_sendctx_unmap - DMA-unmap Send buffer
- * @sc: sendctx containing SGEs to unmap
- *
- */
-void rpcrdma_sendctx_unmap(struct rpcrdma_sendctx *sc)
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
@@ -498,7 +490,19 @@ void rpcrdma_sendctx_unmap(struct rpcrdma_sendctx *sc)
 	     ++sge, --sc->sc_unmap_count)
 		ib_dma_unmap_page(rdmab_device(rb), sge->addr, sge->length,
 				  DMA_TO_DEVICE);
+}
 
+/**
+ * rpcrdma_sendctx_unmap - DMA-unmap Send buffer
+ * @sc: sendctx containing SGEs to unmap
+ *
+ */
+void rpcrdma_sendctx_unmap(struct rpcrdma_sendctx *sc)
+{
+	if (!sc->sc_unmap_count)
+		return;
+
+	rpcrdma_sendctx_dma_unmap(sc);
 	kref_put(&sc->sc_req->rl_kref, rpcrdma_sendctx_done);
 }
 
-- 
2.54.0


