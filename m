Return-Path: <linux-nfs+bounces-21795-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HN8BG1OEGpnWAYAu9opvQ
	(envelope-from <linux-nfs+bounces-21795-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:39:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A325B4412
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51F5030E3C46
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 12:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567F23A6F18;
	Fri, 22 May 2026 12:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3MOTyB2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEC538D41E;
	Fri, 22 May 2026 12:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452976; cv=none; b=n1nWaL1Nq++em3ELozWGPoGQ6FVyTFPeJZzdU7oWnepTowOZYv7fzKsmi2iWnF5RrhE+wpWahI9b9ZwHPQk1Z8RsRN1GGnjthpjLt9rxMJjn19YMonGhCjQY+6WbFEM1KQyjAWKLyKi/eSuv4hV3jy7LYgjtcfI9lmuuqlrD4Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452976; c=relaxed/simple;
	bh=/nJ1xNNDJ9rJbf9EQXkdUUjwKKr61STzhNKZjVXGJbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jtzd0lTd1GCoCRzXGEoeFMhwrGx13RUFleOykpjZJYR+jFI9iIx1zkW9DuELTW+qdrw+zNAqiueHRrI7sP/FJKFHuGhW/dgwFGZOfJpgNXGJihQmU8kkMb50VKx5/HF5tfO1kNMhh1e5r/D6+UY9FidePr4TbAIB8MzJuDJz1Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3MOTyB2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83121F00A3D;
	Fri, 22 May 2026 12:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779452973;
	bh=0psYgh/U78Yx/gV/O/+YpCNlLQ0kiZOK/pcEbcuUCHM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=E3MOTyB2uzyPZfZg9w3hupua6pYUhICZ7zgOz5jF1hq1h4/8Y1TKQy473Ii3d1viG
	 zSwHoeizkAhBZrU5wdYlcGneYk338L4F1yWhpdubW4Z1rdP0B+CGLlVbt9/bOTPXXS
	 wPU1Ul/QhN2jAVqfGmsBIsXAnBjVSncIfw76jamHZTKk/vevP9xuM+Y4ixESItOgsT
	 1cMAaYh2KmNsLpEfzlm6dp2HcxAj9gEQjoZFiJU9BhME+8Y1/6sAjDnaST5n4fZKJg
	 4PH1kwb3g/f3P8PEQYM1Tjf56vtPyMz3XtsFFLJLeIfta3bPEZPyRJFgK9nNqPOlmk
	 LlDP3XlmyicOA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 08:29:03 -0400
Subject: [PATCH v4 14/21] nfsd: allow nfsd4_encode_fattr4_change() to work
 with no export
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v4-14-2acb883ac6bc@kernel.org>
References: <20260522-dir-deleg-v4-0-2acb883ac6bc@kernel.org>
In-Reply-To: <20260522-dir-deleg-v4-0-2acb883ac6bc@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Alexander Aring <alex.aring@gmail.com>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=846; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=/nJ1xNNDJ9rJbf9EQXkdUUjwKKr61STzhNKZjVXGJbQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqEEwRj6eihuUUzU2n1LZSLtq5yqJVFVEmCi5ML
 m0/pfbwIWCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahBMEQAKCRAADmhBGVaC
 FQkqD/0b/+W7P/ZPj6Y3VwDFVLoiSj395pW+ThnHLTlRNXvsDsdN/g0sn8uCTuNzZmFQy8F8qVl
 CJhRlj1HQHFqNi5KOBqKQYxXNY2RVbbSNre2z7LA6hzodwNGAT/LzWWyEc6OTmw51vsWDV57cLE
 2gD9QFuLJZhYdAi6oGaC5IABbeo9LvE6ouu6+trqdn++A6F3l2mGGYxLHA3TbECxg06AU4Tdozl
 BVpo1AH0XDxsWnKpeb4JbcIbvZH2RRrEL9hKRFoOfcrPEBxFboSmqXjzop9mbsy8n1ei51MINAP
 V+bOPIWkYZvpPIoQQPckuNH4XgaghnV0iRAAL12kPwhQQ14rCsY73D7Y2ZXj3w6lcsskQ68vM+4
 VrUbgUQdqAbhC26IktQArwVhodDu6bU7R2FyYbUYvjNah5360TqrZfTn4LetWQfYYvbnxIe/SW3
 ir6HvGMnkrksOFCvgv1HAbisvJKcmrwuLn+msiDk7iznJ1af6YkwiNyETvIYiitHNwfiGkK1eSv
 aM4p+MYnfu7NI8AlEOXGJeDKcsXVbWYMa+3WZLrY7iCLh/vKnAZzuIUc04OKZAVMItTc25VRaQy
 Z4yHU5B8ubb2SLZuFI+zzCB58YibUCOBWHr4UWpyB7WRmMwOT3kki1pSpNuHfLYmUN+vujv98Th
 z3COQl1Hm0l2cLw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21795-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 94A325B4412
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the context of a CB_NOTIFY callback, we may not have easy access to
a svc_export. nfsd will not currently grant a delegation on a the V4 root
however, so this should be safe.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 703caa2ee7dc..1fc4ce2357c0 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3260,7 +3260,7 @@ static __be32 nfsd4_encode_fattr4_change(struct xdr_stream *xdr,
 {
 	const struct svc_export *exp = args->exp;
 
-	if (unlikely(exp->ex_flags & NFSEXP_V4ROOT)) {
+	if (exp && unlikely(exp->ex_flags & NFSEXP_V4ROOT)) {
 		u32 flush_time = convert_to_wallclock(exp->cd->flush_time);
 
 		if (xdr_stream_encode_u32(xdr, flush_time) != XDR_UNIT)

-- 
2.54.0


