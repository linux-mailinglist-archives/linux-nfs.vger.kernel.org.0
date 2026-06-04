Return-Path: <linux-nfs+bounces-22282-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1E0QNG+xIWqMLQEAu9opvQ
	(envelope-from <linux-nfs+bounces-22282-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 19:10:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C52642354
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 19:10:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XutBp6Be;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22282-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22282-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF5F63012D40
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2026 17:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8FB336896;
	Thu,  4 Jun 2026 17:06:49 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E49C3BB121;
	Thu,  4 Jun 2026 17:06:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780592809; cv=none; b=RyJTlS/RQc19sijkKc9nL4DIU78/dbROWU/o85MzoBWnNCx4bQaiBw0c0dGQpj8+tONGRlSGb5XPU7Pz1dr8ak4orq7eNMPxODpbZElSBmieXYC9gd2ikLaZXnnGVrRqJpH+VZxNfU1y1PimjJmByJTqFqll506xSip9b13bJGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780592809; c=relaxed/simple;
	bh=PewpbnQPTPmV0/+IG36YuLswNCAuqZVH48PhpTg0G7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ultZ9veBWmPn8qhePi7DlxpmSQvPl/Hqfw+oi8lp4KLj+lZAWG2cXkTwcev/efd4c4Ufg34OsJKe4FNez5wXSGokeBHkYfrhNwQsKfbSMEM60QOQMLrshLYZ8Cz7mszL3NSZSmhW1oj85mw4NeuW2CY8EssGMkoVr7WBXOJp0MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XutBp6Be; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98F01F00898;
	Thu,  4 Jun 2026 17:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780592807;
	bh=8zMuVnz8cGyGYAzF4b4EMUrTnrJorhs9poxr18YhbG0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XutBp6BewwoY49ButB+npROhtAUZNY90vA5LpYoAsy2wnw912diX00S/br80MgA33
	 7RyP2jC7yzvwpR+2XEVmRcWdDmbp9hItDICNxlY9yJqFtwmn8dTKd87KjvLpSr82XI
	 aZseU4XUTpVFo+aypw62TUzyTXWAblBMkoJdjQEM2QVvFM8uoKDbeeWUVcxoMQtal5
	 dW1A5evosO7YvqtfkQg0NKiEjuUN939aFbUZKdONj/WDJAdb279aCXVQAINVM6KV1y
	 +Wa3dIN0i73LNnHi00rsu7MVtti6xWh0DdYQS2bVsWjAIXakLpr+f4K0OkoxNEqmCp
	 ZDKU8spm6E/+g==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 04 Jun 2026 13:06:33 -0400
Subject: [PATCH 1/8] xprtrdma: Fix ep kref imbalance on ADDR_CHANGE
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-xprtrdma-refcount-v1-1-f74553f461e9@oracle.com>
References: <20260604-xprtrdma-refcount-v1-0-f74553f461e9@oracle.com>
In-Reply-To: <20260604-xprtrdma-refcount-v1-0-f74553f461e9@oracle.com>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Chris Mason <clm@meta.com>, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=3034;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=+Fu/1gS5pqE9P+Vm2kR3fHRRjn4ybzuALfFeqOfVCQo=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqIbClGvgH5l8a8c0aME+D1KsI1xLTeH1HDZJUA
 dnlAnV/UEKJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaiGwpQAKCRAzarMzb2Z/
 lx6GD/9xj9fV/SVdanrPC4Yk/t16NopYvPIKy39NEO0XoglHsPs0fQcqQi+0jI4r1WwygQub1c6
 SJ3derzcydCB30cCdafKdT2/8okGvKmAKwpFtyIAFRTVNEUA06NG02xZq/AnTeRI1HtEFftmsno
 RxOUd3UTzGLKOtUmVaJX37aMzOg2zUVrOkuAZIsjLc3ElE77I5OXD108g0BbqBfYSM4yW4h8RiH
 7vLnlrm079h07AnUO0KDZ5glG2BpJqj84dxMnacEsHC/+Tgz/Ms/Zx7Xl6dywhq/leE8x65tYkm
 Q7Ym7RKPUB4K5onSHXLaA05EfDVGjWTAo6nW8BBD6CQQINNEZ5QKSPJrMKAtT4mrss3HZ399CoN
 2tLTRzSezrIhqPuijXrdJyaAt7zNJ9jIw9F9yOPxgVeErFUzPQX6GDXxMnGpsWqRA3/mc1sv+CD
 M4Nzi2akLMt72fKYPITqtaDRUO/UwG6fLgEZVFoPlL49G6FGuB8ibcjSa2a/CCmm1UUGLnPD4WD
 +fib938O4sQ+n2xQ8hXErfYxLCpahEf7JthUQsZ860wQJ0J1wpZwEQrlIDIiFCy4QPJ7v/1itiv
 haHlSgIpXJKFYebvcUqjKKII/p2R3j0XSjUmEulJgo5RchGpMcs8cLV76BkqfXILLWcSBEqVPrw
 WgVwq1L8zJJfouw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:clm@meta.com,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22282-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,meta.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86C52642354

From: Chris Mason <clm@meta.com>

rpcrdma_cm_event_handler() falls through to the disconnected: label
on RDMA_CM_EVENT_ADDR_CHANGE and calls rpcrdma_ep_put() with no
matching get when the event arrives before RDMA_CM_EVENT_ESTABLISHED.
The kref then underflows during connect teardown and
rpcrdma_xprt_disconnect() operates on a freed ep.

Reference counts across a normal connection lifecycle:

    rpcrdma_ep_create()             kref_init     ->1
    rpcrdma_xprt_connect()          ep_get        ->2  (before post_recvs)
    RDMA_CM_EVENT_ESTABLISHED       ep_get        ->3
    RDMA_CM_EVENT_DISCONNECTED      ep_put        ->2
    rpcrdma_xprt_drain()            ep_put        ->1
    rpcrdma_xprt_disconnect() tail  ep_put        ->0  (ep_destroy)

The connect-time get in rpcrdma_xprt_connect(), taken just before
rpcrdma_post_recvs() "while there are outstanding Receives," is
balanced by rpcrdma_xprt_drain. ADDR_CHANGE before ESTABLISHED has
no get to consume, so its put drops the count to 1 and the drain
put then frees the ep while rpcrdma_xprt_disconnect() still holds a
pointer to it.

Fix by dispatching on the prior re_connect_status via xchg(): for
prev == 0 (pre-ESTABLISHED) wake the connect waiter and return with
no put; for prev == 1 call rpcrdma_force_disconnect() and return.
The case-1 arm relies on the subsequent RDMA_CM_EVENT_DISCONNECTED
event -- reliably delivered when rdma_disconnect() is called on a
still-connected cm_id -- to balance the ESTABLISHED get;
rpcrdma_xprt_drain() continues to balance only that connect-time
get. Any other prior value means teardown is already in flight.

Fixes: 2acc5cae2923 ("xprtrdma: Prevent dereferencing r_xprt->rx_ep after it is freed")
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Chris Mason <clm@meta.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 92c691d2521f..354d5c0eb04f 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -245,8 +245,17 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 		complete(&ep->re_done);
 		return 0;
 	case RDMA_CM_EVENT_ADDR_CHANGE:
-		ep->re_connect_status = -ENODEV;
-		goto disconnected;
+		switch (xchg(&ep->re_connect_status, -ENODEV)) {
+		case 0:
+			goto wake_connect_worker;
+		case 1:
+			/* The later DISCONNECTED event balances the
+			 * ESTABLISHED get; do not put here.
+			 */
+			rpcrdma_force_disconnect(ep);
+			return 0;
+		}
+		return 0;
 	case RDMA_CM_EVENT_ESTABLISHED:
 		rpcrdma_ep_get(ep);
 		ep->re_connect_status = 1;
@@ -269,7 +278,6 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 		return 0;
 	case RDMA_CM_EVENT_DISCONNECTED:
 		ep->re_connect_status = -ECONNABORTED;
-disconnected:
 		rpcrdma_force_disconnect(ep);
 		return rpcrdma_ep_put(ep);
 	default:

-- 
2.54.0


