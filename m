Return-Path: <linux-nfs+bounces-22286-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yIZ5E62xIWqtLQEAu9opvQ
	(envelope-from <linux-nfs+bounces-22286-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 19:11:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CD9642384
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 19:11:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oxAli7J2;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22286-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22286-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CC08308CD02
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2026 17:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F9F4963A8;
	Thu,  4 Jun 2026 17:06:50 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65B9494A07;
	Thu,  4 Jun 2026 17:06:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780592810; cv=none; b=jd0QnFIbkZxINhlBLaxssp08lKDE8uin+TTS7r4S7BhmcKa3OQTmo5EwKb8Qh2KPGWO9GXnI+2Mu3iSISbYEr5tHndAuswYBqi9MG2lUP/1pxxBKGwyp027FKg+b4rIe/93jfMdYgTDe5ul0trU7+e2aPBGDlySBKrxHrnqXUVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780592810; c=relaxed/simple;
	bh=WSt37mqLg4T/lpAoJ2+IxZNJCQyq4ptxzIeH7vtI66Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=shFO8ZyRKGI7FvW5FrTWVWK5ioGTfJM2pT8NHu/3Rb6g2oDUct9JPxYYmJist9ub9Q3RFvCznVEDRiF4SzDjlVH4/I5jY17+PHQQyHrcKoamu8nhqzOW9rJkocEF4+DDC20Wi5VRewCAxh+3pLGbOk8lKb+KyE+cv9+WSGk+VBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxAli7J2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D761F00899;
	Thu,  4 Jun 2026 17:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780592807;
	bh=g4NRllA3XT6u6W1+IYioyO9GYcM9STt7Pby46vN7Jd8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oxAli7J2ldHbL9z1TkJZx+rT9Iqu17hnBFZcL0np4oLCNasr3jTjEu8Xb5q5tuFB6
	 9K3x22W8J+oVS3/WVp0g5ii3mEibuNOSKf4Zez+LRmgVuydodUpEKBCPQYNd0TiyAC
	 GjLEUMoUDhXE6JTnkRxQ0Qa0TLrGwdneXc+BiqBO2M4KAmcAVcMqIdpLFFGF3um11C
	 zGjCTHUnqd4n35dxQEaamduQD33j5YpsWLY6zmsZIUXOCe3IUv/y2U/B2Zli7IWwcf
	 OeuvpYSIh5H7nWR1oeiZ1uWvHnIQmBxK3GnSyfdOw5gG554YUNmQR37I0GPGkOlwx2
	 /NTUWYW2pDnxA==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 04 Jun 2026 13:06:36 -0400
Subject: [PATCH 4/8] xprtrdma: Resize reply buffers before reposting
 receives
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-xprtrdma-refcount-v1-4-f74553f461e9@oracle.com>
References: <20260604-xprtrdma-refcount-v1-0-f74553f461e9@oracle.com>
In-Reply-To: <20260604-xprtrdma-refcount-v1-0-f74553f461e9@oracle.com>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=4656;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=Ma9g3Hu8VaQQXVI1XexKA5+0me9Ipx8+UfQ6g2osfuA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqIbCmBnnGTOlAl3Ey9flnXf1VdugT9Ks+yGMeT
 NjNk1G9zV+JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaiGwpgAKCRAzarMzb2Z/
 l1G3D/0X5d4+TwwGNU1rblJx4osJ4YdigvGJAL1pjVlydFrGpDrpGnVhnEn3HWPaEsmrgY9WS+i
 ZyTV49piZIc4rPYKQjjLuCjxBbhYS77pGJcasijiIRAB1n5VFLFyVR+qeaZsNJpwxGl9gSy88VT
 Z6ZFnlJBalvxSG05TYGS6/7J+4aCRlppyMjH3LeBQdjv/Nax/68YOZPMk7k8Eb5K+S2T8vDQYxm
 oX4t/nDAIehDxXL4Y2/qGBgDv+Js6huuKRXgwd9ZP6KAh6ChVrxFY0TiJtiXgs90whSiVNbe7vA
 XywFYZgyDwv8UkSL10ahoTfUtoX6+qXjo3I4PNJqew6fRnPDv31d8t+T+ISqkDFLAnBHcOuNlBH
 9dHY19ki2I+0Xbuyx/s2XlHZ8LN8fKPAfCMPcqBiNGqyRBuPoCA9kQGFPPhdo3Hkk/5D9i8krl5
 7wioMsgfZWy77ci3QyD0FzBXTkEAWpccI3QsecFtw9HfOxZY03NgBjKCJ0abDxawlWeqdXK8wjC
 u1jv3mGAELAy+E0iF5jb7ceZCzJR9cgUYmO7GMbGIPBa275Xl/c6yrLKa+/Y6K2ljoJKka9va5Z
 5RwpL3783mYljppFWvZL43nEsUp4af/WCHNqqJH0ZzLNGqkH+TKpptWJmzXKzaes90i2IbbbMZp
 KvXXnKDj4lOuTuQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22286-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14CD9642384

From: Chuck Lever <chuck.lever@oracle.com>

Commit 0e13dd9ea8be ("xprtrdma: Remove temp allocation of
rpcrdma_rep objects") made rpcrdma_rep objects survive disconnects.
That is normally fine, but it also means their receive regbufs keep
the size they had when they were first allocated.

Each rep's receive buffer is sized to ep->re_inline_recv when the rep
is created. rpcrdma_ep_create() resets that threshold to the
rdma_max_inline_read ceiling for every new endpoint, and the connect
handshake then shrinks it to the peer's advertised inline send size.
A rep allocated under a smaller negotiated threshold keeps that size:
on disconnect, rpcrdma_xprt_disconnect() drains and DMA-unmaps the
surviving reps but does not free or resize them.

The threshold can come back larger on the next connection. The first
peer may supply no RPC-over-RDMA CM private data, defaulting its send
size to 1024, while the reconnect target is an ordinary server
offering 4096; or, with rdma_max_inline_read raised above its default,
the reconnect target may advertise a larger svcrdma_max_req_size than
the first. rpcrdma_post_recvs() then reposts a surviving rep whose SGE
length is still the old, smaller value, and a larger inline Reply hits
a receive length error and forces another disconnect.

The undersized rep returns to the free list when its failed Receive
flushes, so the following reconnect reposts the same rep and fails the
same way. The transport flaps without making forward progress for as
long as the peer keeps advertising the larger inline size.

This is local/admin-triggerable rather than remote-triggerable: a local
administrator must create and maintain the NFS/RDMA mount, while the
server or reconnect target has to advertise a larger inline send size
and return a reply that uses it.

Fix this by checking each rep before it is reposted. If the receive
regbuf is smaller than the current endpoint's inline receive size,
reallocate it on the current RDMA device's NUMA node and reinitialize
the rep's xdr_buf before DMA-mapping and posting the Receive WR.

Fixes: 0e13dd9ea8be ("xprtrdma: Remove temp allocation of rpcrdma_rep objects")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 04b4b0b40a3b..4f763961547b 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -81,6 +81,8 @@ rpcrdma_regbuf_alloc_node(size_t size, enum dma_data_direction direction,
 			  int node);
 static struct rpcrdma_regbuf *
 rpcrdma_regbuf_alloc(size_t size, enum dma_data_direction direction);
+static bool rpcrdma_regbuf_realloc_node(struct rpcrdma_regbuf *rb,
+					size_t size, gfp_t flags, int node);
 static void rpcrdma_regbuf_dma_unmap(struct rpcrdma_regbuf *rb);
 static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb);
 
@@ -1357,10 +1359,16 @@ rpcrdma_regbuf_alloc(size_t size, enum dma_data_direction direction)
  * returned, @rb is left untouched.
  */
 bool rpcrdma_regbuf_realloc(struct rpcrdma_regbuf *rb, size_t size, gfp_t flags)
+{
+	return rpcrdma_regbuf_realloc_node(rb, size, flags, NUMA_NO_NODE);
+}
+
+static bool rpcrdma_regbuf_realloc_node(struct rpcrdma_regbuf *rb,
+					size_t size, gfp_t flags, int node)
 {
 	void *buf;
 
-	buf = kmalloc(size, flags);
+	buf = kmalloc_node(size, flags, node);
 	if (!buf)
 		return false;
 
@@ -1372,6 +1380,23 @@ bool rpcrdma_regbuf_realloc(struct rpcrdma_regbuf *rb, size_t size, gfp_t flags)
 	return true;
 }
 
+static bool rpcrdma_rep_resize(struct rpcrdma_xprt *r_xprt,
+			       struct rpcrdma_rep *rep)
+{
+	struct rpcrdma_regbuf *rb = rep->rr_rdmabuf;
+	struct rpcrdma_ep *ep = r_xprt->rx_ep;
+	size_t size = ep->re_inline_recv;
+
+	if (likely(rdmab_length(rb) >= size))
+		return true;
+	if (!rpcrdma_regbuf_realloc_node(rb, size, XPRTRDMA_GFP_FLAGS,
+					 ibdev_to_node(ep->re_id->device)))
+		return false;
+
+	xdr_buf_init(&rep->rr_hdrbuf, rdmab_data(rb), rdmab_length(rb));
+	return true;
+}
+
 /**
  * __rpcrdma_regbuf_dma_map - DMA-map a regbuf
  * @r_xprt: controlling transport instance
@@ -1455,6 +1480,10 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed)
 			break;
 		/* I1: a rep on rb_free_reps must carry no rqst pointer. */
 		WARN_ON_ONCE(rep->rr_rqst);
+		if (!rpcrdma_rep_resize(r_xprt, rep)) {
+			rpcrdma_rep_put(buf, rep);
+			break;
+		}
 		if (!rpcrdma_regbuf_dma_map(r_xprt, rep->rr_rdmabuf)) {
 			rpcrdma_rep_put(buf, rep);
 			break;

-- 
2.54.0


