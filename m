Return-Path: <linux-nfs+bounces-22047-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNh9LIaYGGqklQgAu9opvQ
	(envelope-from <linux-nfs+bounces-22047-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:33:26 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6305E5F7297
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95F803047059
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 19:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F9B351C0B;
	Thu, 28 May 2026 19:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhcUv9GO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E4A3396F4;
	Thu, 28 May 2026 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779996750; cv=none; b=srdD8f+u/VwGGqN/KtGs4sri+N3zxVkvFX9DnTLdqOlRKrHcHTnb/YO1fKNGnw3tojsKbLaZEthNSUR2Eu8einxYHDfJB96DEx7EtYIa/dCWWAAe99gweUoPO3P8SYmgPsfufON6HNDjb8corbUNanryyKZ1rfBtjZLFZyXlt3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779996750; c=relaxed/simple;
	bh=HK8n9Fyp5AdWlODbW4pWD3+rSBTPmFMsRFd2zkNjP+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mHMiqlMUTuKYdWyMuTzggCgZWrIJaRqSUIBo3UHdiAtDvjD2S1Cbr5sxyqVFGZiA8w/sb3SDvNCCkvYKtZ7HTjM/cWAnTF40/XQpsOG/XOxCphNpBj3R9Fte1jUqoK4O8t1Fu88mpTkV0f1BOQHjyc3Yh4yR1/qUrGkh9AGVRZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhcUv9GO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922751F00A3D;
	Thu, 28 May 2026 19:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779996749;
	bh=/cqRwLseA3GojhPJggnXmaP3dzOWmCdeNBLscr756Zs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lhcUv9GO5XSCWrkpjbj50ukwT7IaWszF4gbvxOITqbC+jILoT11hkAQAHlVA7909z
	 7lOzI13v3x13P9f3zNg9BKBUUkYPGtPc2YQSflBapSxo5ZepMTqAYxxnvkpxKptgbU
	 r9xv3KQqn4O0YZiw2dNY17M9fFcMeY2DvdhpmdgNB+as1aXThQpbSpPA6sPLlfFRlR
	 aZtcu4RrDKCsZji0h9jrwFKbWkIIDBITocEMBdly0gJs9i7QSf2D01Gw/aM6GtAuaY
	 NvlkifiyK07AEQXLEP9kvEB8qqnlk7wImmSLUeW+fGA3cM1FUo1UK5lNjKLYzLGivC
	 j/OHixAEYLCOg==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 28 May 2026 15:32:11 -0400
Subject: [PATCH 4/6] SUNRPC: Guard svcauth_gss_release() dispatch on
 rq_auth_stat
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-tier2-v1-4-d026a1415e0b@oracle.com>
References: <20260528-tier2-v1-0-d026a1415e0b@oracle.com>
In-Reply-To: <20260528-tier2-v1-0-d026a1415e0b@oracle.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
 Simo Sorce <simo@redhat.com>, Chris Mason <clm@meta.com>, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=1930;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=A2zwvrG4rGnYhdSB+2VUMtkZmXTLjk9/W9hf34amaM0=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqGJhIfLU/ypknOdLOCu2/YYTCseftYbLCl0hJ5
 k+gu9Sx6l2JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahiYSAAKCRAzarMzb2Z/
 lwS7EACLjNTdS3PQpgbgO0BljeSwjd9pw8dFARh+Rio8dwozhmCFEegWKDJdiWbPUdoGVW1jlBC
 PVaaJlZKDMNv4HxNx3weeFlVPlYywYFPkdokrUIR6+nAa0poFdqN8P3LpW11o9WgGpW+kond5/I
 eKk9JXPvg8TMeMNzCsjiEwx1Z/OTU0wU54gT4YFnEK56JoKzFZ+h4RWV3xe4DbVXMkBRyMETsYN
 WKazAZ58MsBPHvFYiEeOpBgV7d3ZQnSCU3FPX+TVlleaPy5pc4lbc4ybTbwawWchCWoMRajROhK
 tpK2dYtZr+TT1Ml4eKuKYq2WYMMrvyrQG+hf06OyBWMNJ+WWMKkyT6zDRNUa/esxIHgBtD0lgwH
 ImPlOzeJ2qe3I8hQMy/cbYx5DcHa7dZrE5ZSahZ4nkFiSrFDh0F7mu3Ji7oHuJaV6ShTvW38EsO
 fs5GyYTO/BatWhAetBsupZkqaoNm+d/MGOra69QCiASLpawp9i9Rps0s8x+o3S31NzTXADcj5sa
 npgXNANcDjh5gY35aigPlpBuyqifrvn/sio4fhu+zOd3lThLmmE7OOVusWzfZU2l9QnuZRLcv0t
 cYy/xf1UmE6z3YMw7qm2qi+Jjs3CV9Mg+JN9sx6HOxU+cr7KTlSD8Yq+TYOtFm/OcsAu0aGmh2H
 gXm6VQR0pIcFIRQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22047-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Queue-Id: 6305E5F7297
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chris Mason <clm@meta.com>

svcauth_gss_release() reads gc_proc and switches on gc_svc before
consulting rq_auth_stat.  On the SVC_DENIED path after a failed
svcauth_gss_accept(), those fields may hold stale values from a
prior request or uninitialized slab residue: svcauth_gss_accept()
allocates gss_svc_data with non-zeroing kmalloc and clears only
gsd_databody_offset and rsci per request, not clcred.

Because RPC_GSS_PROC_DATA is zero, a zeroed or stale-zero gc_proc
passes the existing guard and falls through into the gc_svc switch,
which can dispatch to svcauth_gss_wrap_integ() or
svcauth_gss_wrap_priv().  Both wrap helpers call
svcauth_gss_prepare_to_wrap() before any rsci->mechctx dereference,
and that helper already returns early when rq_auth_stat is not
rpc_auth_ok, so the downstream NULL dereference is blocked.  The
dispatch itself remains structurally wrong: it reads scalars that
the caller has no contract to have initialized after a failed
authentication.

Mirror the existing rq_auth_stat gate in
svcauth_gss_prepare_to_wrap() one frame up, so
svcauth_gss_release() skips the clcred dispatch entirely when
authentication has not succeeded.  The cleanup tail that releases
rq_client, rq_gssclient, cr_group_info, and rsci still runs.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Chris Mason <clm@meta.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 8e8aceb31270..4eb537410cb5 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1944,6 +1944,8 @@ svcauth_gss_release(struct svc_rqst *rqstp)
 
 	if (!gsd)
 		goto out;
+	if (rqstp->rq_auth_stat != rpc_auth_ok)
+		goto out;
 	gc = &gsd->clcred;
 	if (gc->gc_proc != RPC_GSS_PROC_DATA)
 		goto out;

-- 
2.54.0


