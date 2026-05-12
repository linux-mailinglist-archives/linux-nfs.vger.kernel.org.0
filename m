Return-Path: <linux-nfs+bounces-21566-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qF9kIPRxA2rH5wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21566-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:31:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D217527B06
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEC59330529C
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68431374186;
	Tue, 12 May 2026 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANF/Xfip"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454B2371D10
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609663; cv=none; b=tyeegNyMnDW07xA1rjyWgUBKb39f74Lk855Gj/zIQ0G6u47yuq+QhXa6Mt0KefTFevdMSVzS6PzgRI1n3JsaVXuEAl+6L1eeEt9BXNNp0OEyT86XwXY1GjgOGq9VIdfzwGJtbiqEVMAUTebKMIUQJsSxBpazsNmVSAK6FH3fL94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609663; c=relaxed/simple;
	bh=wheS+upA7HnFwdEmtR1nM224BYxXqgH5BWaKBAh/+Z0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I1v5d8vLAibxRI37lJx/Mj8MRxHY33SIa05vgtHOQIoGYEy7zzOs2HJ9l9zEsuO/SDfHl/5vducNemI4J5gWinqP3IQceOgWTCKFH+RZI7QQPcAtURVN9skSb/ecSMga8OlDz1MOzyVSHE3Io3TGSRvEgWfgZraA4D8uUhQMJfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANF/Xfip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68713C2BCB0;
	Tue, 12 May 2026 18:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609663;
	bh=wheS+upA7HnFwdEmtR1nM224BYxXqgH5BWaKBAh/+Z0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ANF/Xfip/irub4bWgp7rjwzlUC7oI8nDMbI/V8+cBPAlHGKfpr6a6nr4kWIjSHVtI
	 1YxBeIqI93nye4LwM4R0NrDKWQuTCbdo5yQItkswOj/WElIxg5zA4dZBEJk/9VFHOY
	 gigmrlDjIpAjIDuEeaH50gVolhhJ+RKkTOt4G2xqaNeMLqS72OpZO06krLwH/ohTe8
	 C6uuEbVfvC+vEnrR9PbmFKbbckS+rda/yoEh5oMjUTAy2nF0hb1AVSdhcxiG/V2oil
	 NbUziot2xYfbhkOh+gN5df2rAo2Nu2NK71P/GvNCWFFjo3D9UlcVyIan3pUlAiDN3A
	 n34KPLRRVZTSQ==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:14:01 -0400
Subject: [PATCH 26/38] lockd: Use xdrgen XDR functions for the NLMv3
 LOCK_RES procedure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-26-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=1776;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=uUQ2X6Z6sYGhfgdZl1vkt+yg7lCQoBzBT1EWmMM3Krk=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23mhtMHb7o0GczXhoBsrDbvu+fK/zZIrcb/J
 ZvPjyWxNKWJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5gAKCRAzarMzb2Z/
 l2wMD/9zNCLMRpAqHrLgboo9QPBllxAF8DkGMBIIZAkO6ldbim7VaLQByoVJslfReGU0cdowph4
 h3TrHkst67xlKWdA0ODvt6WO4ToER/xytRsPJoA5OpO1q8VFkjpKnCHgEadm1paL4WnHvFB/GeC
 iJ2uZVtEnbE8ZmaMpuURuCStzIEvzisizNdXOZvO/eCBrCqCixXC8f9h/QV9fhIgT4JQ4I1SbG3
 SMb3flLg680vzMeQ9HMv+26w3+eIGozIsLRsw8owceCogzFnIQEwVtAFh97Ra0ay14mg8sxtDW9
 36uRSs+H9jX7ugwVFvMUjV1WkEpHqQ6/7o4v/jEPoKur7rjcFGFNMHObod/dQwpoDawvWdnsZPA
 J85JxuSwZY8vxdvgLocg7oh9fRbC0PsYPzt3EErsmjciRx1556Vwn74KK4XsnmGUjYeJz09p0hj
 kO4idV9HaLLb0Lo8+HK4NqHF+yoNgPhluhO9S4EF4gIsGQTGVT4JNYRUk0H2XRtYNd+QTTRIPOf
 quxlGnerUHI1mCFrqnryvNkjXV0ll8iumAmIhOF5zZOBvYUgauEfOhpi/2WCVwuDMLzc/J85+mN
 HmO2GAk1rJ+zxcAKSxyuqy4+z2gZJWO2CzbQNHtKeDGVG8F3JO2BbjyWFUs66gqeMXzY470kcFE
 dpIPKdniwb57nUQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 2D217527B06
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21566-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Continue the xdrgen migration by converting NLMv3 LOCK_RES,
the callback that a remote NLM uses to return async LOCK
results to this lockd.  The procedure now uses
nlm_svc_decode_nlm_res and nlm_svc_encode_void, generated
from the NLM version 3 protocol specification.

Setting pc_argzero to zero is safe because the generated
decoder fills the argp->xdrgen subfields before the procedure
runs, so the zeroing memset performed by the dispatch layer
is no longer needed.

Setting pc_xdrressize to XDR_void reflects that LOCK_RES, as
a callback, returns no data; the previous value of St
over-reserved a status word in the reply buffer.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcproc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index ed1164ff431a..c86ba0b94793 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -1280,15 +1280,15 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "TEST_RES",
 	},
-	[NLMPROC_LOCK_RES] = {
-		.pc_func = nlmsvc_proc_null,
-		.pc_decode = nlmsvc_decode_void,
-		.pc_encode = nlmsvc_encode_void,
-		.pc_argsize = sizeof(struct lockd_res),
-		.pc_argzero = sizeof(struct lockd_res),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "LOCK_RES",
+	[NLM_LOCK_RES] = {
+		.pc_func	= nlmsvc_proc_null,
+		.pc_decode	= nlm_svc_decode_nlm_res,
+		.pc_encode	= nlm_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm_res),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "LOCK_RES",
 	},
 	[NLMPROC_CANCEL_RES] = {
 		.pc_func = nlmsvc_proc_null,

-- 
2.54.0


