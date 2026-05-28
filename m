Return-Path: <linux-nfs+bounces-22043-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MQfAE+YGGqklQgAu9opvQ
	(envelope-from <linux-nfs+bounces-22043-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:32:31 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCF95F7234
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 667F5301584D
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 19:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67FC30E851;
	Thu, 28 May 2026 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5bjGFq0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BA2233923;
	Thu, 28 May 2026 19:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779996746; cv=none; b=oiIR5iV/Vo2Os+PoIs+cF0Q5DgFKDuK+UvzWzb/e767wJEAVIOQjx4eiTF812fIQZ5bAW9mOHT7c99aRMaL2A29CXCKdLl5Gv92r8meENpBEWpdTVgbKyTjVeaCo/AchWC/c2UGLznXnm2ZOpTZIKaKPdH24XGV2IEVrj0e5wTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779996746; c=relaxed/simple;
	bh=bBC1zMklkyGOLxMXvLdHUJx1qJjp+5sgSaf4Bvn8dFM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NxXf2wyRDaIdy82LC0abOZ++uCAUwQ9j5PKfgjucflu5j6Wu2AVH0i2Hyx+z87BZpfc/U5//a5cGaHWe6lKOhKdRKv/6GwM1WIPOBy4lAS9uuvpwJNAw0OgMh3lGf7PksEr2z9XJ3OSgQe+QGwAmE8UVk0SkgcjLQkSnwR53r0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5bjGFq0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606AC1F000E9;
	Thu, 28 May 2026 19:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779996745;
	bh=9PR8Pckb0wsvK5xrAPQL3W29k1GHHm2ov8DlfhE7Kq4=;
	h=From:Subject:Date:To:Cc;
	b=O5bjGFq0Bm574GrrvP+IECXFUGdphQKUS6TjChi+MhChHIqYk0lVZIs2Mnj6u/57l
	 a0Xg1KZAjynOIN8aPDOdxGL7tk42yPq3oBhuRgK7dVehQSsiNW9YUcMfoVXcqWy5AD
	 opvxZBC72VzNj7R0iIni/LGnx1QWXhi2inZ4X02RSCtCq07NK4gDJQSHiPd6zK8oBG
	 0iik7F3eia2UoOO2rOLqY1nicll+9kZrNKsWwv1dFbkodnXG9gxOLHwajSUxpQIEqo
	 Lxco8kdOL+p6EFN45p+NxYG4RMqkEvcZ6hydR4YF93IlVLnCGGOj9a9QzzHfnxxH9Z
	 Kcf6NnoRYOOdg==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH 0/6] Harden server-side RPCSEC GSS decode and backchannel
 teardown
Date: Thu, 28 May 2026 15:32:07 -0400
Message-Id: <20260528-tier2-v1-0-d026a1415e0b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMywrCMBBFf6XM2mCMD6y/Ulwkmdt2RKJkogil/
 26iy3M55y6kyAKlS7dQxltUHqnCbtNRnH2aYIQrk7PuZI/ubIogO8OWwaE/9GHPVN1nxiif389
 w/bO+wg2xtLgZwStMyD7FuU0R920alU2BFkkTresX4Rv/uYwAAAA=
X-Change-ID: 20260528-tier2-d0dedb949b3d
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
 Simo Sorce <simo@redhat.com>, Chuck Lever <chuck.lever@oracle.com>, 
 Chris Mason <clm@meta.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=2216;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=bBC1zMklkyGOLxMXvLdHUJx1qJjp+5sgSaf4Bvn8dFM=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqGJg8fE5Gzzsyj8dbDQYdhHgMWdVOqLLzxSAIh
 Vq+wLfNmJKJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahiYPAAKCRAzarMzb2Z/
 l45rD/9DEn3kjUatsJ7QI3RdxjsQQSB9nfbexJkOoIkvqr8O14E8sNmLU0GxmUozZoAKK+lvKsF
 Nd6OGieJn0O0kPKdZ21C5BtC6nQitcV7/w4GvEhB10TUddBPhtRiAJp4l7vcB11JvvDIgLAuqQt
 Vq023GaTWnpEK+SfenaEgBr444o3wzID4Qsd6/S7piPnh+FsMXAtdIycippfnYj2OD3hlN8O/0y
 v8KZ+P8LVzXp8F0cy8+wbTbV/Rv6LKDQ1MBbEiSHoCFBy0fM7IJK95DYJy/hW2mK5dLtPHcR8IW
 UTw/iqXhuy/no0URKC/qHSoS87gGYy73saVBtIjB2SYUFvwWwtiZpLwTHfAWfAXu4y3KvPBriYH
 JDUV7yywJvBlmDlb0AipvA4LbVK/E18TJLLZUbl39msvNPf1qOrN9kHe5JXzV+yicQ14ut+ctwA
 EuOvLMg2ES3uUXGvZPu6VLdtI5Ars7YSCTFk7GecC7lWt92vD+uY/to9wC66XFIodXkBLb0Y5od
 I/IrJ4Iv8qQjIL4NPAaNkPzZBcltRsaS5gvwDONK8mpf4IVfVWbi/vB682qhkB/lurMMWo1Cnep
 RJsU2UVYU0rpTVvFSO6GA/wnPuGmJ7tplaSf65MOzT2M9B+ot20e89MUJSTYzo5pEDCi45yp2DE
 A7Cb+3fUq+uPEfA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	TAGGED_FROM(0.00)[bounces-22043-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Queue-Id: 6FCF95F7234
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Address findings from an audit of how the server-side RPCSEC GSS
accept path handles partially decoded and stale credential state.
The common defect class: gss_svc_data and the rpc_gss_wire_cred it
embeds (svcdata->clcred) are allocated with non-zeroing kmalloc and
reused across requests, so an early decode failure leaves this
request's partial writes mixed with the previous request's residue
for a later consumer to trust.

The two gssx option-array decoder patches carry a hard ordering
dependency. The error-path fix must come first: it wires
free_svc_cred() into free_creds: and converts the out_free_groups:
teardown to the refcount-aware put_group_info(). Only once that
refcount-aware free path exists does rejecting a duplicate CREDS_VALUE
option actually release the single installed group_info instead of
leaking it. Reviewed out of order, the duplicate-rejection patch looks
incomplete.

The backchannel patch stands apart from the GSS decode work: a genuine
race and use-after-free in callback-service teardown. It closes the
producer side -- clearing xprt->bc_serv under bc_pa_lock -- before the
callback threads stop, then drains any request that raced in before
svc_destroy() frees the service.

---
Chris Mason (4):
      SUNRPC: fix gssx_dec_option_array error path bugs
      SUNRPC: reject duplicate CREDS_VALUE options
      SUNRPC: Guard svcauth_gss_release() dispatch on rq_auth_stat
      SUNRPC: Zero rpc_gss_wire_cred at svcauth_gss_decode_credbody() entry

Chuck Lever (2):
      SUNRPC: Reject krb5 v2 wrap tokens with oversized ec field
      SUNRPC: close backchannel before destroying callback service

 fs/nfs/callback.c                   |  4 +++-
 include/linux/sunrpc/bc_xprt.h      |  5 +++++
 net/sunrpc/auth_gss/gss_krb5_wrap.c |  2 ++
 net/sunrpc/auth_gss/gss_rpc_xdr.c   | 15 ++++++++++++---
 net/sunrpc/auth_gss/svcauth_gss.c   |  5 +++++
 net/sunrpc/backchannel_rqst.c       | 38 ++++++++++++++++++++++++++++++-------
 6 files changed, 58 insertions(+), 11 deletions(-)
---
base-commit: 4d4d6605de5f91a40335729b6a7cc15e83b280f3
change-id: 20260528-tier2-d0dedb949b3d

Best regards,
--  
Chuck Lever <chuck.lever@oracle.com>


