Return-Path: <linux-nfs+bounces-22046-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH1hAHmYGGqklQgAu9opvQ
	(envelope-from <linux-nfs+bounces-22046-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:33:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 658355F726A
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B34F0303FB48
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 19:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1212348C66;
	Thu, 28 May 2026 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEYRDmWk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B597340410;
	Thu, 28 May 2026 19:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779996749; cv=none; b=Ugsm2cKtOthzVyljQo3er0Bmm7NqfNAFAeFfZcdNwFRN25Qjax/gLReTiuG8e1Bcj5YUcGkc6oy0QmSNJiihCctc/wECR5J3kfKj0qx1FUvS4p3YHqnL8vVQiKIB1OBElYXQM6ySx/PoQNQR61xz6X88BXrAFGpkNu96sYcEuTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779996749; c=relaxed/simple;
	bh=qfp8SOZC3Rlcm9DOre/hORJUYeHVfTDb2XSv1KdLe8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e4G+a4SI8UDJVTMnrJ/flGW7npURkPHnaq563LoLxy8DiATF0s/z8xcePsu3ky6gKQqi2uCgxWSSQZFpkOqE4IExQgkd7dNEDlU7qTRZ3tk/je3bO6kMY2HzFt50aAvQqyZ+l7QWZhQFdpJcdE6x0EOAiSGWhSybwmDvIo2cciQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEYRDmWk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9C21F000E9;
	Thu, 28 May 2026 19:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779996748;
	bh=3vHwyYV/7YcxLddTEjbH1UHTQ5i5JELK6+v/H6bubtw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MEYRDmWktnA1ZMEgl0Hm5M53fWP6mxl97WY3AcnhmIdpAC9IGpJjqASE9OOLDJZJ+
	 kyjhyEcxBbrbUq4fj5m4/s+BJJ5zh/9TPeqJic+EumKVjvU6k6y5BH2IjgKSgVZDIv
	 mj7zhMRatfpOdW7mcXyd6ZhhMtkwKKtOxCu01Kyn+gcEwJytxwFTuI+2U8l6tio/No
	 qTjQXvorgGyP8Y2ftaiIpOiwqgYwer4qMbXOwR8vs1pNsFXgvlOiCScRG+s72fzbP/
	 jJw9d1JdD9qKlQkowrY9DhYGZ4fLkz6dXo4l8mP9turXIbeH4dIXhrre3yXbWyg8FO
	 BSZ2McLTc/i0A==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 28 May 2026 15:32:10 -0400
Subject: [PATCH 3/6] SUNRPC: reject duplicate CREDS_VALUE options
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-tier2-v1-3-d026a1415e0b@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2484;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=tCQPJI2a6RtuHkgB9lLYd6+bbAJ7t7+75Q5kSmHne9w=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqGJhHu/3Szef3VXs1ShGZZfdH/nJz6b2AaG+GV
 6iyjZh4Pj2JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahiYRwAKCRAzarMzb2Z/
 lxXrD/9obANzLKnxB84KevFR3QHW6rNgH5SYIz2rS1VMkuMDM3PKkJIMegrrBklHgzl5LiqrMbF
 RAv4CcXcbpNb/jyFN4pTipFQElHu77yBL1A9bK5h9FG8bG0fi49Oh1zEAP6UNcpRMzsdUOAqZtv
 MvzZ7Hx7Dcz+IbcGFR0A/MZ+NxiOMUz1o6likuOMnUY3MV5mqsVr247VdS+lkDLhvhHZaMaAJ4W
 RqNdw+qnKxdkqRY97Z+wc1u24HXJptxUnhkB/zQw18myMQ5BBwFywQS7q8d+Nt70An15oGYM31B
 klL/NrCR5tE4w1dym9k5NIhvGCRLyEC+TsP/VKIjOzvj/8Bq9JEUKYTGR0sYZcqXWOywF4cV+4W
 lJK08Mvb8uPqJH91mlFkfj9i7r6Sbtqp4Ebm0J9CDYapIR0eTHaVtlQbG63Qhromf8QvssgSOQ0
 FDlqdUgYg34X+EsseEMIlq7tj7+nzGigMchlwftNmUVtdtpfBXpIM16mBLp+w21070smm81Uw6T
 5cGZC90ravVz3BcVAQZ1erJtHixgNIj9D9L8+uInO720P/4zryqhfQ0qd1oJPxY2aQIOsri9lQp
 /J/GRebXPhqkb7LdDuZwd9dOCpMZvPZOX8/CyBgeVpSB8v4Tmv3JJ5gOjN39eAslqSofW+oyYZ1
 IUhsY3E1YaAVVyg==
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
	TAGGED_FROM(0.00)[bounces-22046-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Queue-Id: 658355F726A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chris Mason <clm@meta.com>

gssx_dec_option_array() walks the wire-supplied option array and, for
every entry whose name matches CREDS_VALUE, calls
gssx_dec_linux_creds() on the same struct svc_cred. That helper
unconditionally installs a fresh groups_alloc() result into
creds->cr_group_info without releasing whatever pointer was already
there:

    for (i = 0; i < count; i++) {
        ... decode name ...
        if (length == sizeof(CREDS_VALUE) &&
            memcmp(p, CREDS_VALUE, sizeof(CREDS_VALUE)) == 0) {
            err = gssx_dec_linux_creds(xdr, creds);
            ...
        }
    }

A reply that carries two CREDS_VALUE entries therefore overwrites
cr_group_info on the second iteration and orphans the group_info
allocated by the first call. The earlier free_creds path only
releases the last cr_group_info via free_svc_cred(), so the first
allocation's refcount stays at one and its kvmalloc-backed storage
is leaked. No in-tree caller of gssp_accept_sec_context_upcall()
expects more than one CREDS_VALUE per reply.

Fix by tracking whether a CREDS_VALUE option has already been
decoded and returning -EINVAL on any subsequent match, so the
free_creds path releases the single group_info that was installed.

Fixes: 1d658336b05f ("SUNRPC: Add RPC based upcall mechanism for RPCGSS auth")
Assisted-by: kres (claude-opus-4-7)
Signed-off-by: Chris Mason <clm@meta.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_rpc_xdr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sunrpc/auth_gss/gss_rpc_xdr.c b/net/sunrpc/auth_gss/gss_rpc_xdr.c
index f2b8f919adea..0549edae1ebe 100644
--- a/net/sunrpc/auth_gss/gss_rpc_xdr.c
+++ b/net/sunrpc/auth_gss/gss_rpc_xdr.c
@@ -231,6 +231,7 @@ static int gssx_dec_option_array(struct xdr_stream *xdr,
 				 struct gssx_option_array *oa)
 {
 	struct svc_cred *creds;
+	bool creds_decoded = false;
 	u32 count, i;
 	__be32 *p;
 	int err;
@@ -281,9 +282,14 @@ static int gssx_dec_option_array(struct xdr_stream *xdr,
 		if (length == sizeof(CREDS_VALUE) &&
 		    memcmp(p, CREDS_VALUE, sizeof(CREDS_VALUE)) == 0) {
 			/* We have creds here. parse them */
+			if (creds_decoded) {
+				err = -EINVAL;
+				goto free_creds;
+			}
 			err = gssx_dec_linux_creds(xdr, creds);
 			if (err)
 				goto free_creds;
+			creds_decoded = true;
 			oa->data[0].value.len = 1; /* presence */
 		} else {
 			/* consume uninteresting buffer */

-- 
2.54.0


