Return-Path: <linux-nfs+bounces-22013-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HLzFIwIF2oo1wcAu9opvQ
	(envelope-from <linux-nfs+bounces-22013-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 17:06:52 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0025E68AA
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 17:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 080AF3100F04
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 15:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D394279E3;
	Wed, 27 May 2026 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFv348OZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B79426EBF;
	Wed, 27 May 2026 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894024; cv=none; b=Z59Hestjs5bGGWi6SRSHRWfFBdaJP4qqDTMpbiuD4q1z1ftjcHOwPCO9lEmV0e9VgojvYfL2x4zEJFDSHAX862Qa2QlS1Lv5G7X9BdF9AwkrleRoem3td7Ko91pL0Rydia8N06dl2r6YB66DhZpImwiDGcbk4G8e2wphl9rRcNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894024; c=relaxed/simple;
	bh=5NSA58XYzOs73r7v3MTKy7f4lWXADDZhjvIOYFv4/I0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VcXwJ4nJ2dbyf2GccSSTHX/4sew9Qg1K7UliBOb3Bl+RerSokrSQiiaWx+0T9ieb2a0MYUzNAA29BzISU/qt+6xbTAOs9SC5rl12TJyxZeQSLWUMUAQ6BGNnmgGEn1lDoMsEc7JudskIdI/z+XP1ARjDvq6MtaYAOm8bTYVd1/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFv348OZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43971F00A3F;
	Wed, 27 May 2026 15:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779894023;
	bh=Ca1Pd3hUXMkOdUrUsArW+u2jDm9LE7QyggvtSSSQNTo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DFv348OZZ9mG8IZPbr4r8Sfq+LHV/MaU9PUolpwySf5iw9OwnBOoLtoNosxQeEKtn
	 sm+ABOrNN+/43uun/66MP4AHNyD1WyPFia9Wij/SK761zFXEsa4xT2iL+hj86V8rSY
	 fAYWe1os0cOdeWrxPDtUUqgNDgj+JugxYuhYIGiHCDjb7r5fIXCbDOhaVOY+djzpNd
	 pwfBLael6exQTFwa/R6pr374eJ9e/JABOTApqfz/K93gU/Fmke8pZr7SBVVz/Gmhej
	 KFYcZhk3DN2a7IgzMHhzoPYGd4eGz67/6f7HcldgavHa/pkA8q24dSpB606opMUN9N
	 c1ZJO2jo78O2A==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 27 May 2026 11:00:12 -0400
Subject: [PATCH 2/5] svcrdma: Reorder rpcrdma_rn_unregister before
 rdma_destroy_id
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-rdma-follow-on-v1-2-1b09bd87b6cd@oracle.com>
References: <20260527-rdma-follow-on-v1-0-1b09bd87b6cd@oracle.com>
In-Reply-To: <20260527-rdma-follow-on-v1-0-1b09bd87b6cd@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=2210;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=Uboj4cVaJD6ndsfGv7Cr/7D26feEb9EhMer1lmIFtsI=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFwcE8Y+Nc/pUWE8uj05xbfvdru3g1VdvUaXgr
 LSQupNwePKJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahcHBAAKCRAzarMzb2Z/
 l1j6EAC4R3Z/z6gQ+eklr0hcjfnQXGZs71jazZUvfmXI5iw5DkE2b5G5eGQbeEBVAgQC58fZa6S
 0Bk8DmBU0GQsNl4WwJaG2T9N5WVyIezgtiq+OSJFcJKVQTqxu1en674DkAp/SWgoid4xvtaB2wp
 j+WNKOl8/FBHTjbQj7Kov33rhA7ETt5Kn1arrfjKaxW9CtcKslOGu0QjAjP/gfdvvXBPpLAkYEU
 625uXImXBri6qcnJt1uTpaYmVE+o3kFLqSy7U6j3UMb9zjunUm51lycfzzyO+E4iHbGrHfAzbO+
 8vjI+nki++H050zuNeKuNtcDGMMaL0WZyqw3vQSdg5kP/lPpn0Um8BDRTwXnEJBfYBoffWLG6kr
 7FZU5znLLSOspLED40I57sY7/bPHiOqGfCHQy/0siyG4yCNe4Jh+mxRxgMFyDlEW1Fzk7pEfzlM
 D4O+yvyhz9rXlS4FxjQSQgmqJpfg4CaNcgr1x70k2BqruR9D1TzlHiy6loTSoijcSaLJfV9sDQf
 wi+uNgDik4WE1JjqfYvYmPuClv0x97t6p/COSnvsP9t9m2B02ut/50/JtXJOAWae+3EpG3WSIAs
 r6XM69YPb4AJ1kyOz4t6bNrO0hPFE0fmG7bJ5gHSO/NOn6K84pwnmqeLYTSfmowVbAsYhSsaZ/a
 Yx8ewt9W/qopGVA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22013-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: BE0025E68AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

svc_rdma_free() caches rdma->sc_cm_id->device before teardown,
then calls rdma_destroy_id(sc_cm_id) which frees the cm_id.
rpcrdma_rn_unregister() follows, but between those two calls
the transport's sc_rn entry is still installed in the device's
rd_xa. A concurrent ib_unregister_device walk can dispatch
svc_rdma_xprt_done() against the now-freed sc_cm_id.

Move rpcrdma_rn_unregister() before rdma_destroy_id() so the
transport's notification entry is removed from the xarray before
the cm_id it references is destroyed.

Also guard the sc_cm_id dereference with a NULL check: the
following patches introduce paths that reach svc_rdma_free()
with sc_cm_id == NULL (listener create failure, ADDR_CHANGE
replacement failure).

Fixes: c4de97f7c454 ("svcrdma: Handle device removal outside of the CM event handler")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 9268b6105a74..55e2ca036584 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -648,10 +648,15 @@ static void svc_rdma_free(struct svc_xprt *xprt)
 {
 	struct svcxprt_rdma *rdma =
 		container_of(xprt, struct svcxprt_rdma, sc_xprt);
-	struct ib_device *device = rdma->sc_cm_id->device;
+	struct ib_device *device;
 
 	might_sleep();
 
+	if (!rdma->sc_cm_id)
+		goto out_free;
+
+	device = rdma->sc_cm_id->device;
+
 	/* This blocks until the Completion Queues are empty */
 	if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
 		ib_drain_qp(rdma->sc_qp);
@@ -676,11 +681,13 @@ static void svc_rdma_free(struct svc_xprt *xprt)
 	if (rdma->sc_pd && !IS_ERR(rdma->sc_pd))
 		ib_dealloc_pd(rdma->sc_pd);
 
+	if (!test_bit(XPT_LISTENER, &rdma->sc_xprt.xpt_flags))
+		rpcrdma_rn_unregister(device, &rdma->sc_rn);
+
 	/* Destroy the CM ID */
 	rdma_destroy_id(rdma->sc_cm_id);
 
-	if (!test_bit(XPT_LISTENER, &rdma->sc_xprt.xpt_flags))
-		rpcrdma_rn_unregister(device, &rdma->sc_rn);
+out_free:
 	kfree(rdma);
 }
 

-- 
2.54.0


