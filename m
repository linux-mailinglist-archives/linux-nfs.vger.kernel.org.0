Return-Path: <linux-nfs+bounces-22500-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G1OLEkMUK2o22QMAu9opvQ
	(envelope-from <linux-nfs+bounces-22500-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:02:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BAD674E86
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:02:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HYIFznuW;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22500-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22500-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74C413054043
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 20:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73CD38F951;
	Thu, 11 Jun 2026 20:01:13 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B926636A37C;
	Thu, 11 Jun 2026 20:01:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208073; cv=none; b=tOopC9Vkn2GQsf832YOOdF/EZFhApJNWb1WVFasIy6fAVp+PPIxfcwdwW7NtLyGWgll5HSjfJYDOp0smsPmJi9dBYf5AkTY9Uueg7trTXENhR494f8JnD/wL1/YaXSzqEZAT64GEVHFa2a64Cjt2oAx2zWPsNUOorPyB7Zn81jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208073; c=relaxed/simple;
	bh=ttPeNBQ6IttaetSPaFtIcQvgl/tFv7m2KeWjU58Xf14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i/xzUS3fgN48PdaLbTKjfy6sOFaBFj0Ttp8C52E6yUjClmMxLuIWacmaY4pXIRIJT/7Ad8Fd+Dud53GWkX5Z6LZ0Fkk5saMGFldkIqsO6k9DgKe2oNzgUbmp/vAMlgx3WUs6RXUPJQPeesTwXdUPyCVXEMSSJdtqXj39ZcWMkEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYIFznuW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0F01F00A3D;
	Thu, 11 Jun 2026 20:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781208072;
	bh=J5XSLWBhxZwo3MK1VaKdU6Tew9q1kHJ9lpnItfzyFV0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HYIFznuWj6spDbP8V3zB9r0gSOAcUWV7XWzbts+qVLN+SMZHqMKDYJUiKKAAj1KCg
	 6I0YZm/G/plkivWWY12FJJDBMIMQ94DnDlwLFVtHCf1J4b8bUjUkhiMYJfKgSXgySi
	 IegbynA3k9a8h1EA6/CwDDMCSMn4Wu/mKX2///podR0wUCc3DiIjWpUuViIM6b6NWO
	 m9X/ooga3uws/3D264/ZA9New+7+9A16ymsjOFc1QuDHi21X5MuFB23hJCwiP72OPi
	 5K3VPjaqQRME1WWxmxcoUyQ63wZQnsaYobxNbPED7rZ6LWliCsZ9cT6TMPgx7Xn1gl
	 5IIGbpAJrVFcg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 16:00:49 -0400
Subject: [PATCH v2 06/21] nfsd: add filehandle match check to
 nfsd4_delegreturn()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-nfsd-testing-v2-6-5b90e276f2d9@kernel.org>
References: <20260611-nfsd-testing-v2-0-5b90e276f2d9@kernel.org>
In-Reply-To: <20260611-nfsd-testing-v2-0-5b90e276f2d9@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ttPeNBQ6IttaetSPaFtIcQvgl/tFv7m2KeWjU58Xf14=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKxP9nYXxo/BxEksbnqDQZH9lfOfKRmeO02cf6
 rFUTozHhjyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaisT/QAKCRAADmhBGVaC
 FQEaEACPPRlDOSkvm6KttOlumpsgVcrAX5q/sXvBOztPZaeceMYrOiDCO3/yGagw9YqIaD0im0d
 AbApwwMOUvOAkUXAvaysaJTFSzYv5pbna52ZuPL4WB31amEQRfLiL2rPSRA9Vk1PfFOb22H38kd
 XTvwLObkj5000BjTCSd6pT0uRz0gZ2TOclWfUCKB3CK/0fu+/AJdiqWZvjZT1NJVrLz8EO9k9Gf
 sQqt62yO1b3zmNEV8b/cbMmxgeVs7FQ92FquVC8/8Gw0vnm99KkdXoWVpa2mi2ZOTT8uB7A+OdZ
 Yrh19vyIWVixGK7ixGv9vSrql57s/sKVSbZskrJkQtdnsMSq38DToGZB74wEjdWLwWSvQskP4Ld
 cfk+OnJgec0YkHAlK81Qqo/mUCAo8rtTSMRPCKRiA4G5WPy01sktA6C/fsjCNTBGpzsLtJn5L+m
 m65EzGt+9gALy1Z3OKKwA27ftMXvfKMtwZYkMkVk1gXjbs8xxZex5RbbhudNQbc4Y3+g0jKT75L
 mH9j3QPLtCjUFe4dRMrikbR4Jj0+JIJdKhR8+IBVYJugonXkWCYxOC2b9+bM9yTApmjCtlKtmfQ
 D31J1QWCYZKTc34YXH+YBF/OugLjGxSavWvjH2dFNYL6Hc/v2LJdKMwo8TpBsMFxW5QNQ40sAy+
 3m7+Rnye5vqR6sQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22500-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24BAD674E86

nfsd4_delegreturn() is the only stateful NFSv4 operation that does
not call nfs4_check_fh() to verify the delegation's file matches
cstate->current_fh. A client can DELEGRETURN with a mismatched
filehandle, destroying the correct delegation but waking the wrong
inode's waiters.

Add the missing nfs4_check_fh() call after the generation check.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e59aec57e9e8..eb832e996364 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8126,6 +8126,10 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (status)
 		goto put_stateid;
 
+	status = nfs4_check_fh(&cstate->current_fh, &dp->dl_stid);
+	if (status)
+		goto put_stateid;
+
 	trace_nfsd_deleg_return(stateid);
 	destroy_delegation(dp);
 	smp_mb__after_atomic();

-- 
2.54.0


