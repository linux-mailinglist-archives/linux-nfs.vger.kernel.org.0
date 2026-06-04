Return-Path: <linux-nfs+bounces-22289-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DYQLKb2xIWq4LQEAu9opvQ
	(envelope-from <linux-nfs+bounces-22289-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 19:11:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A9A642396
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 19:11:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jItz5Tdv;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22289-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22289-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 123283016C6A
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2026 17:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFB94963BB;
	Thu,  4 Jun 2026 17:06:50 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F014495519;
	Thu,  4 Jun 2026 17:06:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780592810; cv=none; b=HJMfQdLjOFINRyAv1RQWf1WZE14GFnutm/6l2M4GB0cpBXn3aE5tgsUYZ10eoYuc5xTxuoxp97fBvqVHLYhLPozK2L/tWf1JLmnnEli1uqN++5mPQ9obIf75c1UiJQx6dxMkP6+WdXIDvegHKssYIsgT9aJv9xX/7EMIo1NxHzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780592810; c=relaxed/simple;
	bh=QqlBST48x7sfgP3SYnNPEyFKwkY45K4sFmfPeWa6Rs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pQGi3dhe0liwg70kEq/RO0c1RfUgjFnladkfDnDgczEY//XR2YcaQaXL/5bxg0Mkex0UhQpKShmzwZIBfAIjphPS8ZdfsXMXsiIFPwRYrB5kLQ8uJqZNuJNVQkEcXC7X9UEYvrFB/7EA0IU8RgAuZFinP43xIKaOZeCpnFYGSbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jItz5Tdv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9897B1F0089F;
	Thu,  4 Jun 2026 17:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780592808;
	bh=mbzOJLS8NQtpn3vuZXtMB8I4Kf/vOtds2b8zgM28xP8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jItz5TdvF6CSwf9JTPlgMHl86tjOt++VOaDV4rmuehalohgzdRhunRLP2NZIBuHu0
	 73Ayz2tzHByHHQMSLEuELyT9GPyLCAtzA+GIt03AW/vir9jSa//KcSkBPKv5g5fhyU
	 vjPR0GwrK0cNMd4nN9E1iVBLbjxCabIyhtR/mC6R/C5iCsiqeyKDTOJNmxXZ2B19xf
	 EwzJNJ7eu1insPmansECT0enePEVSQ6zE7WjcmwsKOwR/r/vUDBliEmh2XcSZo+faU
	 ZmtSiSMdYLHMMT6bthLS2lw861qhTzo4pwDYIqyypMVcceffl9+2rE/T5BfsODT79w
	 Uwgtr3FwfzYyg==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 04 Jun 2026 13:06:39 -0400
Subject: [PATCH 7/8] xprtrdma: Repost Receive buffers for malformed replies
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-xprtrdma-refcount-v1-7-f74553f461e9@oracle.com>
References: <20260604-xprtrdma-refcount-v1-0-f74553f461e9@oracle.com>
In-Reply-To: <20260604-xprtrdma-refcount-v1-0-f74553f461e9@oracle.com>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=3003;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=WqHbhEYUNFtr4eJy5eAr+NvK5Z91m/B18idlwv6odqc=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqIbCmGog+xSYgRlxTWWgDoQimiYsqvB5CI+9rL
 smcdRJBruCJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaiGwpgAKCRAzarMzb2Z/
 l0lbD/9eDChxWL51zyadY4kWbAHVvtQYYA57ehZVLRwSxZr9x4MWubIIn+959jlAB9o23pp0h8p
 HOrffaazVDvo41jJBC72ikYI3crYoMfjmBbDp86BDfKarMWynpS2iJrQsNkEmrs5t7MZ53XV5S5
 FXeJs9LVME2KEI5V9PLVKYRex7/uYkg68Kdu3Eq0cz/nr8umOg+MseJyyXoGLlv4HJ1gFlmuDyi
 qthEv0Cks41utqvBAcVJ1gd1VAm8SeSNyfjyemq23Y+vOUvkSvKeOUZQ2fPDWgGyQyINUiwuauz
 FHyTKikwqZPQa1o1zvahO/wsQcy+JxA/A/QuDZg/luUp/44fF1NcP8haMHAC4dZli6ioirEF4QZ
 KNjNOwkMl9i2hqEn8zokRWCUPf0UQLtgqohGQKcQHzhz3QUTXJzJ/wz0XWmmAIs5NUv02EJa7a2
 hSawRL4MWKxYMQchhyLXcNw5koqnyjtWeql00rsOvQbtU8ZCKnM6XHZ48uZXNZoR0f0vUCEh2bg
 ho5EyzzdH3MBpcmqFkhcnx3gaqJMvtW1zyBdsuHXFnGxTKsUhe0IbebV5fYHOjuDCYJqdvWl74+
 wjbj45BqmYzbpgqdb4sOcpxe9MYX3N3lY/xtRj2DEqCLcW3ihGbvT9YCyknmZGungo2/VBQWDlv
 MqJnvp2uhOdy3+Q==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22289-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oracle.com:mid,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78A9A642396

From: Chuck Lever <chuck.lever@oracle.com>

rpcrdma_wc_receive() decrements the transport's Receive count for
every completion before it dispatches a successful Receive to
rpcrdma_reply_handler(). The handler must post a replacement
Receive WR before returning unless ownership of the rep has moved
elsewhere, as on the backchannel path.

Commit 2ae50ad68cd7 ("xprtrdma: Close window between waking RPC
senders and posting Receives") moved the Receive refill out of
rpcrdma_wc_receive(), where it had run ahead of every reply, into
rpcrdma_reply_handler() so that the responder's credit grant could
be parsed before reposting. The bad-version and short-reply exits
never reach that refill: they recycle the rep and return without
calling rpcrdma_post_recvs().

A remote peer can therefore drain the client's posted Receive
queue by sending a sustained stream of replies that are shorter
than the fixed transport header or that carry an unrecognized
RPC/RDMA version. Each such reply consumes one posted Receive
without replacing it. Once the queue empties, the peer's next
Send finds no posted Receive and the transport stalls until
reconnect.

Route both malformed-reply exits through the shared repost tail
after recycling the rep, refilling against buf->rb_credits, the
most recent accepted credit grant. Neither exit updates the
congestion window, so RPCs admitted under the previous grant
remain in flight awaiting replies. A smaller refill target would
let a stream of malformed replies ratchet the posted Receive count
down to the batch floor while the congestion window still admits
rb_credits RPCs; a burst of valid replies to those RPCs could then
overrun the posted Receives, and because the client connects with
rnr_retry_count of zero, a single RNR NAK terminates the
connection. Refilling against rb_credits also restores the target
that applied to malformed replies before commit 2ae50ad68cd7
("xprtrdma: Close window between waking RPC senders and posting
Receives") when rpcrdma_post_recvs() computed it from rb_credits
internally. rb_credits is at least one from connection
establishment onward, so the repost path always keeps Receives
posted.

Fixes: 2ae50ad68cd7 ("xprtrdma: Close window between waking RPC senders and posting Receives")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 5ff086ccd259..3f50828802de 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1528,11 +1528,13 @@ void rpcrdma_reply_handler(struct rpcrdma_rep *rep)
 
 out_badversion:
 	trace_xprtrdma_reply_vers_err(rep);
-	goto out;
+	rpcrdma_rep_put(buf, rep);
+	credits = buf->rb_credits;
+	goto out_post;
 
 out_shortreply:
 	trace_xprtrdma_reply_short_err(rep);
-
-out:
 	rpcrdma_rep_put(buf, rep);
+	credits = buf->rb_credits;
+	goto out_post;
 }

-- 
2.54.0


