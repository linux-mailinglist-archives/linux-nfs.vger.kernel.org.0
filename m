Return-Path: <linux-nfs+bounces-22048-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABN7JpOYGGqklQgAu9opvQ
	(envelope-from <linux-nfs+bounces-22048-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:33:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 146DF5F72A1
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E32C1305D112
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 19:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90CF3396F4;
	Thu, 28 May 2026 19:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbWeNdT9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6461352013;
	Thu, 28 May 2026 19:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779996751; cv=none; b=e3mNrAgLh1txayHz1NA5zVBUY6UKPXzAO3StgKYheLsmDQoN+zVj9sR/WAnfCG75YhbjUkNZKzyarSTep0TDldXSjIwyE4vqic32ou4SHsuzXRc4hQF3LSVpeOd9Unlcy3XzE1jgAKRv9hiY+JdUmJyX0SjZM8tr/e59tGigKH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779996751; c=relaxed/simple;
	bh=gjP5TWIpTmQYEumgjYABh6YRCksUVvwpjjdwDbh9clw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q5MOZo8NhlzbVna//n9kjnGCH1IRpPNWhkyfmf+knQVnfXl0eoWQ3GOM2DO5/uuFiIbBVsghhGq774IYU/S/hSWxzM/T7C4g+yntJrjjQfqVpKi8T2dXmxgIiQhXLEq+3rM58ImEfvmm38mdvCkJcjCkwZLzr/DMzwO3uMwGVzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbWeNdT9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20311F00A3A;
	Thu, 28 May 2026 19:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779996750;
	bh=Xwlgv4t7qvvGoLIJgN3yPLkhln+QWKZ/K5UUmgekc8U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WbWeNdT9K2dHjJDOhgVFP/q0fqnSKCOwaHk4cyihsNIggtxZS2MY+XS4BdTCMDFav
	 NWTnbNH7G34W//FCh01oLaQfGk3Mrrec21gYxv8IiCz3bPbYGNNhsKzZRXFH2o36n9
	 29kP9B+kTsOHLLBujrDi7ZFnD59OrEFdTheSS6ShkVHpVMVfO8nLfceRx0trHTc1GJ
	 89y5MNUjYu3soLFhIWSOVgtmYJrleWw/49rOBFkfKXGBOZEAL64noUQJSuXS31iI1P
	 fjtvIRAHzDGGFvMtV0kiAjZflQ18u2zIqF8IJhKnha2EJ3UghaptEYWv4qdqiSFGM9
	 V8iHxmCDCESQA==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 28 May 2026 15:32:12 -0400
Subject: [PATCH 5/6] SUNRPC: Zero rpc_gss_wire_cred at
 svcauth_gss_decode_credbody() entry
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-tier2-v1-5-d026a1415e0b@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1821;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=KdWrlgaIW/zn1fwbiJpoUIJuGSHeK+ImSB3+sxqM8xw=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqGJhIE2kj6Xpkneh+qONu4IGUbDHvCdaIHJ70t
 Oegg/xo7PiJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahiYSAAKCRAzarMzb2Z/
 lyRND/9dt7JDX+6UoBdCiALXfhojEZZ1EaosrfNW1UGwCIhM+vGBM+Y/DZmwKB85bK1BNboXHy9
 Jkx14e3EECi0tn30DKnD2OsxN4/dEFBxmAlMuRT4vvi2TAcAsBYH5LiCPI0QELZM2dqcQbLr0nS
 xRNTVResUDx7GQrwTc3HKptYZMWIYVPRDv+IhgnRRjA5Z4HkoEdKOQ+6aiZ+ZbQ8QBSH2ic3JDe
 wu+AVj8ZKZNgqu5HLYikPCNw8lQNp+zM7y5OCJ1LQGEg2eoPsJS5o5knAyHO9Uglg03J+rsWchf
 7gLkGk1irXnEZbuFP/Ia/iN+xmSYsueui6uzNNiwPCwL7IJIClG4HJlnmiqgJZIpchQZSkdMV1t
 71RemMmC/3TlV59zkSEQuBZCGGzvcJ+ECAzA+44XZ+Vm1THbB6WqYmU098eLoCUia38sDSukaFA
 aZFiXIolvDq/AL1dkXpoAmfvYe0e6e2Myv3rhkqVhfSH+rBTNscFQMNweAnwJX7VtKUnyU1tGPG
 mX6PJjOstfG/LhKPeCuCjiZ1TF81n0OOEJLZ8s52ihA9dmki0bZz+pfu8GMwaZFvQhLSk3huAjK
 srLEqw8JX+5SJiCpM9QoO0TPWYEPsHWW+ONK//U9m6uN051kbi/QcKRTr3S3oaL7uWgECd0GfDH
 FAJt8b/tfWWzhTw==
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
	TAGGED_FROM(0.00)[bounces-22048-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Queue-Id: 146DF5F72A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chris Mason <clm@meta.com>

svcauth_gss_decode_credbody() writes the caller's
rpc_gss_wire_cred field by field and assigns gc_ctx.len only on
the success tail.  The caller storage is svcdata->clcred, which
lives in the per-svc_rqst gss_svc_data and is reused across
requests.  Early decode failures leave partially decoded state
mixed with residue from the prior request.

The trailing body_len tightness check is the sharpest case:
xdr_stream_decode_opaque_inline() has already written gc_ctx.data
with a borrowed inline pointer into the current request's XDR
pages, but gc_ctx.len retains its prior value.  Once the request
pages are released the pooled clcred carries a dangling pointer
paired with a stale length.

Zero the caller's rpc_gss_wire_cred at function entry so that
every early-return path leaves a deterministic all-zero cred.
On the trailing tightness-check path, gc_ctx.len is now zero
instead of stale, which neuters length-driven consumers such as
gss_svc_searchbyctx() that would otherwise walk the dangling
data pointer.

Fixes: b0bc53470d1a ("SUNRPC: Convert the svcauth_gss_accept() pre-amble to use xdr_stream")
Signed-off-by: Chris Mason <clm@meta.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 4eb537410cb5..764b4d82951d 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1575,6 +1575,9 @@ svcauth_gss_decode_credbody(struct xdr_stream *xdr,
 	u32 body_len;
 	__be32 *p;
 
+	/* Early-return paths leave deterministic state, not stale residue. */
+	memset(gc, 0, sizeof(*gc));
+
 	p = xdr_inline_decode(xdr, XDR_UNIT);
 	if (!p)
 		return false;

-- 
2.54.0


