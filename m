Return-Path: <linux-nfs+bounces-22615-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7mNJAEY8MWqgegUAu9opvQ
	(envelope-from <linux-nfs+bounces-22615-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:06:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EB568F189
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:06:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=b44X9Yhv;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22615-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22615-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A3BD30A43D9
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 12:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D464C4657D6;
	Tue, 16 Jun 2026 11:59:32 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A0D4611EE;
	Tue, 16 Jun 2026 11:59:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781611172; cv=none; b=JPhBMs4RmFvmxkRKCKTr1VLDL9ZTpjnm1iGDM1Q6wInFQXn5Y0PwXtJ90OSVjD6EEbfXw2uxG3vxb9oB1R6VUYLG6S16oPRdgvQT3MbqAzXU+XaFAceOmFVmUD50OFl+NrQiK8+CKxDW9b947WI4J15Iy2rsv2VoFmQGtmSfFJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781611172; c=relaxed/simple;
	bh=cffANrtCXh/imI370SCYvhEjst7LP+Bk4eoA/eFpoVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TAGh6SHedcNztm+3+xqwKWIC6w1NGydllSKPOYtFM10/m8sS6iM9PXHzjXk7IELoXJkhaP2jGvpL5qpA3Lj3x6HVmqVbbxQn76rGTyCRk5xFUazSgqblrunjmiVxdJf/SL2vvC06tIvs0asfZpIzAAM7NTthObjGQ2XimJ8t984=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b44X9Yhv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA291F00A3A;
	Tue, 16 Jun 2026 11:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781611171;
	bh=GlkScdNKeX2xOwgwx8NgKZRoCFZsb3SBS8PG3Y+Pq4o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=b44X9YhvZe7fj3u4R+GM21LMt1psWHDZfzf+OXRFcvRrRY+blhNWSbfFZ8DK6bgeV
	 2vATo2B0E6W3mnjcEYquXmIobcfEXVIzFw9/a39ljQf3COEa5oDRV5dJd5mmNRnb7a
	 Zz9osFdMGU0S975ozS/p2Wxda9Blc5dLDEPymBD/UX0LvErA6LOO9MJQF1gO9pVWqa
	 7C5Kg/H0Mh3jxl6Om3NIKfyqmTkQ1YQH1XVpsbKpXJZ/KWnoyMRfUZRCtbONb9HGhB
	 EAjUHtf8QYcELHlG/eIQ3kKvPsdEXhnTFhF/bVvpCLLgAMK5+d+0fxIVETGZG0ZZEy
	 8w3+EUzdZG1Sg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jun 2026 07:58:56 -0400
Subject: [PATCH v7 13/20] nfsd: allow nfsd4_encode_fattr4_change() to work
 with no export
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-dir-deleg-v7-13-6cbc7eac0ade@kernel.org>
References: <20260616-dir-deleg-v7-0-6cbc7eac0ade@kernel.org>
In-Reply-To: <20260616-dir-deleg-v7-0-6cbc7eac0ade@kernel.org>
To: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Chuck Lever <cel@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 Alexander Aring <alex.aring@gmail.com>, Amir Goldstein <amir73il@gmail.com>, 
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=846; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=cffANrtCXh/imI370SCYvhEjst7LP+Bk4eoA/eFpoVM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqMTqH8d4cC/mvMYjTXatVFeTfnZO28aWK+8CQH
 pXrNYxnv8SJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajE6hwAKCRAADmhBGVaC
 FXBGEACoN8WyqjmIBjW+VgcTc3AzrsEVlCSmR4iuMey6kvFyR9/RH87+Y1D9CcoGXkVaqAIbeGz
 wTLgvwdlYHQk5sLs8pX0f+/GSVs1gTN+kIn3lFVZAMWHNF0wXGx3k5uyxLgJbwBQXnGS3K/8pk2
 Un8ohjHlNmvC0oVyCGXNL0rjZSih3qDrpSL61jTVKTn9n7PR1Mp6dun8OIbPTk3ZkG+qensaMhw
 HDX4DK8BCXMUX9WuKvTlaEpNx5MA2pCXDque3bBsKIz5DlWZoe5593Rn9z94FxFx7kTMLhEz6cQ
 cQCfMQlE7zpkGI819n296eFCdKSOFxr0HXisaWLnQE1p2N8VtgWpS5TqMCsD6WNTttFCxI49KtI
 54UmRmwFD3588y1zITHXSK1lx6odumTvAjFu+q+VnZ15gCtyetw4t22Nu2mJ+48c4UBYDxcrBb8
 ecOyM9xpHrzQAk9z2pWnuhKLZlRB2tupC6ay8zTWzQrac8uWRcLBPltot2Za0to3kLR5cj7qzJG
 1uzpKNYa4kuh6lvwnLdTR7UWTbeKNUMVqGSzSuzT5dZXoYpErELa0E+8/qaytH84vKRQljoO3gL
 bpjIZciN8EZo0emERvQZGl1OMwwkeWD5R+Tw/QA9/VNDanKmAhgVumDrA9F8BiaW/Zyl5eigVS0
 S0//NODSQADbKtQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22615-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cel@kernel.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99EB568F189

In the context of a CB_NOTIFY callback, we may not have easy access to
a svc_export. nfsd will not currently grant a delegation on a the V4 root
however, so this should be safe.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 54a7902935b5..6f5b0c032d64 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3277,7 +3277,7 @@ static __be32 nfsd4_encode_fattr4_change(struct xdr_stream *xdr,
 {
 	const struct svc_export *exp = args->exp;
 
-	if (unlikely(exp->ex_flags & NFSEXP_V4ROOT)) {
+	if (exp && unlikely(exp->ex_flags & NFSEXP_V4ROOT)) {
 		u32 flush_time = convert_to_wallclock(exp->cd->flush_time);
 
 		if (xdr_stream_encode_u32(xdr, flush_time) != XDR_UNIT)

-- 
2.54.0


