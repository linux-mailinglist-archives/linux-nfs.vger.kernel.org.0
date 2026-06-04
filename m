Return-Path: <linux-nfs+bounces-22285-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RGSnI6qxIWqsLQEAu9opvQ
	(envelope-from <linux-nfs+bounces-22285-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 19:11:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF2A642381
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 19:11:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=asZQxmJI;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22285-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22285-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33F4E308C11F
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2026 17:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDA6495501;
	Thu,  4 Jun 2026 17:06:50 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278B7495506;
	Thu,  4 Jun 2026 17:06:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780592810; cv=none; b=DIJPein59lHCaRvBrdeUzaaX+AiVc3QOY75N7jiKFSNr2PiYBNO14p+8jMZK+5vbwoqpORfHWZ9vl7rGv5zAPXaJJ8uYWLOt/BXrBdhOvpkkEz0RL8TFJ8HUbissSVl5qrpIv37tmuUlcCZExfTKctkJEwMmLbkQdRuQ6pC9emw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780592810; c=relaxed/simple;
	bh=XYVLyAOgKNoBxrNZdMaFQroynLzEBdUCTDGVKAkjLW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zc5zdJIrYFlTM/+xN1ppOVR1N7peSxcJkZXOEH1nrwtB4feIEFpzfx3GUNnPxKtkuxMM7kIZu8yxhuOwgpswi/l7nwR4YokvYOpW6sa7kWG3yZrxye5pb57+H0k6sDXMq/5c0snmVMo8B84Lq7BZ+66VdI8BwsQYRMb4l6owISw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asZQxmJI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8161F0089D;
	Thu,  4 Jun 2026 17:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780592808;
	bh=GzVXmQBXbXNJdUcl2ivNzB2hxUdWoq7gIQ22NP6MJRI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=asZQxmJIGVzdwLqhNWEMnpL7E7EEgANmjULUq52W6gZeIgm6+FcN+8qRfG/d2eQCK
	 8cP7kRTO847VrLnC68bQmw9LnaQ1YWzTctxEwNIK6CimdXkTHN/nurwPnb6OcmPPsB
	 bflc2o6rZU0kGFaCz1mhfmCTCFkFTcKexAjyPpaGhki+CCx0J+tEDgrtSBihWf91fF
	 KtOAEDAZoN+b1XO+eUn3bW+a+Q1Od+le0hVqpOu9jC4GHiwzCAxzCVbqZ/vQq24bfY
	 qocwwJenkIc5A5xkSmSJXfA9jCsFKK2iKgJG0MqjFF1ivBzUhCn9W4QFCOEl6YS8fI
	 b0+MRFMqZHE/A==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 04 Jun 2026 13:06:38 -0400
Subject: [PATCH 6/8] xprtrdma: Sanitize the reply credit grant after
 parsing
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-xprtrdma-refcount-v1-6-f74553f461e9@oracle.com>
References: <20260604-xprtrdma-refcount-v1-0-f74553f461e9@oracle.com>
In-Reply-To: <20260604-xprtrdma-refcount-v1-0-f74553f461e9@oracle.com>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=2077;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=++oY3pKCugxl9QCRR5HpHthsN/KvO9lG3F+V861oiSc=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqIbCmTWeNOiLmoif/ciLQodBgmz/aj3tCFO9td
 oHQPm9SfaKJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaiGwpgAKCRAzarMzb2Z/
 lwZND/9j59Q+2KIcyg0rjnoNvxHygmkyVnaIFCMmhLwMxOmuR19CQ4VuV6OZwfcfFs2j1ztLycD
 UyE6VPGRVR2fOS0G2CqKdYpOYzKkizmrdnvGo6jAS2q1UxbB+wrMtUXQFvATMNbLoCkWY7w7lBJ
 hGi1Gzs+V3v4HZKsK5M57bAOJDx10VFXlrHlvRCUP8rn4yq87wwi0WkDh8q6G/GEyuJLxWw881p
 z20YX+oQWU/+3VvI5hN1wl4XqAjCKU1Yn9sQ7zRazD+W0gPYADnbhaiOYzyjj9ZCg47q3pT7d4H
 VYzwKiCztONWWgHAT53U1p+DT3BhhQmw+IWzfT34pctLU8xl4LpN9S1zkYxjyAV36keoESW/aai
 MR4xg3UmX5Jz/sX8ANBbo/Jy/gt89IqciG7dvHnPlXK0OMf6osuoXtxkED3HwLhZJQjX8jJs88v
 yULFO0ySw92t9IhN2Lw9hP+rUCat4LXof7mfd3LCAFLmm6/xzOyr1yYbmj1pGX6/XJS+PBiyMwv
 CzqaLtmBg0V/VCRW4VDl8YmWN1X7US+l/fQeA26MsdNiQaUSeOMycjr1mN0ACMviKQo+JJUasOb
 QyVF85zkhLQS55UZdKHcfZgrVgN8cwHL6zwv+lZXALuTEGO3kF0pIWQJ5y/8P1GNp49WBH9Pz7+
 IAS92ejE1xeZYHQ==
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
	TAGGED_FROM(0.00)[bounces-22285-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oracle.com:mid,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FF2A642381

From: Chuck Lever <chuck.lever@oracle.com>

The out_norqst exit in rpcrdma_reply_handler() branches away before
the credit clamp, so a reply that matches no pending request reaches
out_post carrying the raw credit value parsed from the wire.
rpcrdma_post_recvs() does not bound its @needed argument: the refill
loop allocates and chains Receive WRs until the count is satisfied or
allocation fails. A peer that sends a well-formed reply carrying an
unknown XID and an inflated credit grant therefore drives rep
allocation and Receive posting past re_max_requests on every such
reply.

Move the clamp to immediately after the credit field is parsed,
ahead of the first branch that can reach out_post, so every later
consumer sees a sanitized value. The cwnd update stays on the
matched-request path.

Fixes: 704f3f640f72 ("xprtrdma: Post receive buffers after RPC completion")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 63e64d53e289..5ff086ccd259 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1472,6 +1472,14 @@ void rpcrdma_reply_handler(struct rpcrdma_rep *rep)
 	credits = be32_to_cpu(*p++);
 	rep->rr_proc = *p++;
 
+	/* The credit grant from the wire is not trustworthy;
+	 * sanitize it before any code path consumes it.
+	 */
+	if (credits == 0)
+		credits = 1;	/* don't deadlock */
+	else if (credits > r_xprt->rx_ep->re_max_requests)
+		credits = r_xprt->rx_ep->re_max_requests;
+
 	if (rep->rr_vers != rpcrdma_version)
 		goto out_badversion;
 
@@ -1488,10 +1496,6 @@ void rpcrdma_reply_handler(struct rpcrdma_rep *rep)
 	xprt_pin_rqst(rqst);
 	spin_unlock(&xprt->queue_lock);
 
-	if (credits == 0)
-		credits = 1;	/* don't deadlock */
-	else if (credits > r_xprt->rx_ep->re_max_requests)
-		credits = r_xprt->rx_ep->re_max_requests;
 	if (buf->rb_credits != credits)
 		rpcrdma_update_cwnd(r_xprt, credits);
 

-- 
2.54.0


