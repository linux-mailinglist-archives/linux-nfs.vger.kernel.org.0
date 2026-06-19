Return-Path: <linux-nfs+bounces-22698-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /FdIIQyXNWql0gYAu9opvQ
	(envelope-from <linux-nfs+bounces-22698-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:22:52 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA016A77B1
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:22:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aMoOhbyA;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22698-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22698-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7B1FC300C7C4
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 19:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9B3344D86;
	Fri, 19 Jun 2026 19:22:46 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2208D33F5B1
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 19:22:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781896966; cv=none; b=h1b5CfI8nydsyoVAiTv8Z8WGnEWylibRCJ9ptlP+i0Fxe8hxK7PoIMb1dCE5W3PXMZL/04teTYjx19DwJ+Wq0zgzKadokVS89Wl+oqsztJ7oE5ZejTPlNcEx9jGtcuVautAI7efdXJJZlBgbPq8NP+/QDXKGe40iiwKCG/ud3tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781896966; c=relaxed/simple;
	bh=2MRzBSnBEI/i391jncWiqh+/Y6Ze4OYAUy+Y9+I+EK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fWr5aJ+DUWIiV6BuSAl2oVJRWvZLlSCyvx3IFQz8m8UJ2aWL4ZtcCJuSdfkMdAlK+fL13HDq2CQ7QCQC9VF+nB3NPsmaeR7G455eQayh3oo76w05uZfiZFKglP/Tl0PfzmB12vy4PFbnm8hVwgBRHGn3Na8rfRQJwHuoguz70M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMoOhbyA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E030A1F00A3A;
	Fri, 19 Jun 2026 19:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781896960;
	bh=B4YpVedY36tpoXIRX+fw80QizEK8IcG+ieKj4MS4dDA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aMoOhbyABuk8oWazljOemRiiptbUO9LCZMQVlnjTIq6r24rTRHs6B5RQQuhPZdGkG
	 W7avHLoajWTyKm1YTHE7Ul5I4R3QSs/p2i6stcxGmc7Ux+IPkOILeampXYYTvud4CL
	 yVOigc30qMm4pCh/jjiX0R8vItAXk/Bv0VkxZfCjV3SD/uAaT2oSdDNZzIeuRmOyer
	 CUCdCMy6B9zVIqTsR2+qz4sRjxGNs6RBRRdZ6TIxoIpVZkcjalonyDY3jBdr/316Hi
	 rmZsZYfvU9prTaNoagdxK4HlGWzp+yoRJZI6XoBavtaQmb51iKUMxQse1DX4X2D1KU
	 K1jsSbNMGpsqw==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 19 Jun 2026 15:22:20 -0400
Subject: [PATCH pynfs v3 01/26] nfs4.1: add proposed NOTIFY4_GFLAG_EXTEND
 flag
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-dir-deleg-v3-1-1077ce8aab1b@kernel.org>
References: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
In-Reply-To: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Scott Mayhew <smayhew@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=968; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=2MRzBSnBEI/i391jncWiqh+/Y6Ze4OYAUy+Y9+I+EK0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNZb4C8q52kw7PTXaWRz0I+SzEUrNLPEDvG8Qu
 TmOfMHabXmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajWW+AAKCRAADmhBGVaC
 FVSxD/4oFJC2SZQA97MItW6eckkfa4oo0MEFNgEujWXE/f/0Lo4oFUioS2NCFeEe1O0VZ/mNSug
 DPgjGJxasWkxq3/p/GCpp8ykmwQ5FmFX28fNaXDaJHmkDWtvtua5csJ5hVKfggmEPfXqAcMSXxx
 IpqDeSiYKi6aTC48TqmnWJPFDnEGnUKem8nNIaW9QkVAPfmNfTjfFnn5Q0G3a3ZMLaeJUMdVUDP
 YQSHfhJ3gtwbphOipvNPSDVi2qz+aRoOPBBPwf4Hl9i0BgtQfX2qolk5Yb1Lc6AA8WwlRF1W2ns
 gEsTCDrXohTxOTD6fyMLW4lp7/5Lh3eITsUGjvRVAMjkWTf/dJOuZpT14hHHbf+6gizBM2R/bgW
 CCxhvikZN0KTPhx5+DKo+tm6py6bhVjtuv5VpaNWGetm2qDsy6a6OzbhC50B8Fo2Sm3nYyq9h2/
 2bZR6+FSGUdCFTqF9DMY/RNLffR5gw0efq4/+k2r1N4l3Xkk0hgGZ/tuQ86B0356stNtFAUYbk3
 CYynRTAK5r2vrR4um55BzPCYX0ACu3q3n+BpIiRZqAO5GLolGlZUl5zathFz+jdr81Sh5o9yc36
 g6YpdB0RFaNWKFJBvimzqnKCg1GdYC3eBdxUgSRmGM3LLIbTENNSmAcysYyQGHEm/eECQG40fmk
 5I9dL/SqDEcUIxg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22698-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:calum.mackay@oracle.com,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:smayhew@redhat.com,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7BA016A77B1

This flag has been proposed as part of RFC8881bis. This flag is used to
negotiate extensions to the original directory delegations originally
specified in RFC8881.

In practice, the Linux nfs server requires that the client support this
flag if it's requesting anything other than a recall-only delegation.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/xdrdef/nfs4.x | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/nfs4.1/xdrdef/nfs4.x b/nfs4.1/xdrdef/nfs4.x
index ee3da8aa7a34..f03eb538a298 100644
--- a/nfs4.1/xdrdef/nfs4.x
+++ b/nfs4.1/xdrdef/nfs4.x
@@ -3611,7 +3611,8 @@ enum notify_type4 {
         NOTIFY4_REMOVE_ENTRY = 2,
         NOTIFY4_ADD_ENTRY = 3,
         NOTIFY4_RENAME_ENTRY = 4,
-        NOTIFY4_CHANGE_COOKIE_VERIFIER = 5
+        NOTIFY4_CHANGE_COOKIE_VERIFIER = 5,
+        NOTIFY4_GFLAG_EXTEND = 6 /* proposed in rfc8881bis */
 };
 
 /* Changed entry information.  */

-- 
2.54.0


