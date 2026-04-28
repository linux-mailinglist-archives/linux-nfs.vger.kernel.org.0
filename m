Return-Path: <linux-nfs+bounces-21233-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +J1yEChg8GnDSQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21233-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:22:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A32547EBA9
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 53ADF30236EB
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 07:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E452C3D3CED;
	Tue, 28 Apr 2026 07:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raxXBAJ/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCB63AE183;
	Tue, 28 Apr 2026 07:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360318; cv=none; b=Fk5LrdOOzrZf4op8LixsxFo+APwaTm0w4qDBvl3ttXlq9mxJwmNzxM/WuGkBOjZ34Ty/8oZDBrw3Td7jFW//WCwhF58N+OqBYZyFoJPFESt6fwz/sfEdYYpBJfj7lj7Amng97n4UUeArBi0RA06qe+7AmYKxhoSVwvBNAgShNkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360318; c=relaxed/simple;
	bh=EZs5JSXgff2XMAUBaSSNR38ZRXCvpIIGiMGLXDvobow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T1pe+hkyr45cOkwiMpCVfuzoQ/7n1AMxhi5/vVPPse+okRryWoqGEiiaslbeGXBysR7u9cqr34VVyLCiZRSE0BQ0ygYXXxts+bod5aEZY+8rCDWh9a2SSn54w49xaUY3IfvZtom0demfRO1p39D+TKdBziQragA10cohNSKlaDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raxXBAJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5BBC2BCB5;
	Tue, 28 Apr 2026 07:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777360318;
	bh=EZs5JSXgff2XMAUBaSSNR38ZRXCvpIIGiMGLXDvobow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=raxXBAJ//miBst9b3cEXgjBEO2SsR1s/k5tJvxS91j4Co5bUTnhyvMcWDIUhtOxLI
	 WfAmIizEeLCmR6tWx9ml0Aou1GI6RxLYjGuaDlQunG0evBwWO/9lfzh1a0jyCo3lpS
	 4r9Zz2hVom9Fua3fZyuI8oHBPcvJaPoC6aSIU4kC17erRM4KMkBK2mkmDZafYV7pDK
	 qmylg131SNQQWA9voMxTrezyfcqT4DdcQI+ZyOvOZF/B5OuZNf05e3YYqIgGLZG3F+
	 8bVSNrDri0+4iEEzxvQY/twUA447vhXhj45GqvG1qE/WCHmadOnIcEs2YSzf2eY5Cb
	 9bEEWk8ISpcBg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 28 Apr 2026 08:10:05 +0100
Subject: [PATCH v3 21/28] nfsd: allow nfsd4_encode_fattr4_change() to work
 with no export
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-dir-deleg-v3-21-5a0780ba9def@kernel.org>
References: <20260428-dir-deleg-v3-0-5a0780ba9def@kernel.org>
In-Reply-To: <20260428-dir-deleg-v3-0-5a0780ba9def@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=846; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=EZs5JSXgff2XMAUBaSSNR38ZRXCvpIIGiMGLXDvobow=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp8F1TOUYP/lYvkXxIvVYP4JJwhZpoS1cK43W91
 dYl+CbtxmCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCafBdUwAKCRAADmhBGVaC
 FYOMEACUsZ1TyUGr1mFVXjxhL9qwr+E/eroeJ4vO2eTXHhgjqT38V0c01s7FK60t0Bn9LC7TBDC
 OiQ4ms7BelDvDsWrFi5o1z3F1FSd4kusrWqfIo61jxdxyjTDspOqoYd0iM3Z8EITb8j1P8b7Kll
 XZwITbWESI8CXp53CKHSplWP331NB6KnBPyrL5z2iKOPZ9mg/CJPDc8QNlieJ6Fs/zNbA2Grp0T
 xQnsiBtV7BEwbL5HYNV1/CCzLwnmRqL7uPGU87qR8JtIgnNWAKnmZ0bZGuKFYGV7PjplqK6SQBY
 6CbxwzKXP+N8Uf9UtiPUm5xVnjJIwaB0Oq2VDq68GYA8Y+tHVJG71N8QekPMfvtIx1W375jIqWG
 1fa9/aVQE3Qje7jLp32NhMedUuG2pMcALZqajIHcCIhbYsVMf0ic/9d2RQYpBHoD9NNzkptRh4Q
 l3cmQvKp7K96Qrj+hTLZgwDHScGk+RcV6d/Kl0calUYGBq1g2PQYvpDFVxJ/yWoD27pRNIj1pu7
 bWN9IHsMjoAFMjBiJD54aLOeHSf09biE/5M7D4TATdHrkLKrmsUAQbwS1oUntFu0hXeyf8PcC4f
 8DsCP8SdZn7R85tJajT1wM3YCmw7CSa+hirXVY5EtAEaKWRHAq1+/0D65hTuuaK3SFKLHd2Ob/U
 3AwOvfzVqpQ1kzA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 4A32547EBA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21233-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,goodmis.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

In the context of a CB_NOTIFY callback, we may not have easy access to
a svc_export. nfsd will not currently grant a delegation on a the V4 root
however, so this should be safe.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index b9b173ec7421..91681aea9d7f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3257,7 +3257,7 @@ static __be32 nfsd4_encode_fattr4_change(struct xdr_stream *xdr,
 {
 	const struct svc_export *exp = args->exp;
 
-	if (unlikely(exp->ex_flags & NFSEXP_V4ROOT)) {
+	if (exp && unlikely(exp->ex_flags & NFSEXP_V4ROOT)) {
 		u32 flush_time = convert_to_wallclock(exp->cd->flush_time);
 
 		if (xdr_stream_encode_u32(xdr, flush_time) != XDR_UNIT)

-- 
2.54.0


