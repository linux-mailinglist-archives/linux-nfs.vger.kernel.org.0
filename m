Return-Path: <linux-nfs+bounces-20893-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FdIEkch4WnMpQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20893-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:49:59 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D611F4134C2
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01AA53252A86
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEBD3EAC77;
	Thu, 16 Apr 2026 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnZAC47M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1FE3E9F8D;
	Thu, 16 Apr 2026 17:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360954; cv=none; b=iZFgo7JOfgBjAsfDe7KuL+ROUM/mYZmPBF8TIYorXmiwdfcDys4MGSFAO42djs2IXZXrgBkId5uckj2sel0GaWWVbzw/saADTInIwGH7Jfq+5Xn3deeKowe6yBf7MT53h9iPsnsZhGl0/zEh8QU397UCQBb0ynvUOv/TvSl0/Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360954; c=relaxed/simple;
	bh=K2ldbf6BYM/COXf9fXWWOXeQSvNqNCKWjcngztoWlgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ktYbGA0D/CkTK1qNFMzXhvg/6PlNTcu7dNLsZAeuvReoy02nFb2ulAcmzAEs2YCBjsTsSSolvpwCJFdO2I3A/+q8fai3GKE3FDiueOv9a5W+PImqeU7ibliB1bDaX6GLUPFSARTTMVI7UT12dz/3tTHYSWx0e56mjGdEHlTxFoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnZAC47M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D6DC2BCAF;
	Thu, 16 Apr 2026 17:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776360954;
	bh=K2ldbf6BYM/COXf9fXWWOXeQSvNqNCKWjcngztoWlgk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cnZAC47MXuc73sWMch/yI8fRkOcaGz+arxfxglmy1nXVO7v7Ge/kJHFIOzz0EcyZS
	 Bipn9lzyi382r1IpZmUNL5ueeB2DouuAO2U6JWcG5kBKgsLp2vd0Qgs9CVifAjqRPU
	 Xm78pmSC61xXcdOcy5LiHNmTsDQAiooTpZwgFK+LeqqckLcJKY9G/dBkY01SaeEb+G
	 ZJy6YgGgK/Gq0/hDlrZTok03iK1r21Zxw9ze0ug3ZWv0kt/zurbDVTdpDkc/IDDth/
	 CutR22S2OyQ/YNGCLLRFIAol3/UxiW6RXrWwZIsdBlkaR547AsGMLuyrIvptBs2b+Z
	 fCH2Q8B6K2M8A==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 10:35:22 -0700
Subject: [PATCH v2 21/28] nfsd: allow nfsd4_encode_fattr4_change() to work
 with no export
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-21-851426a550f6@kernel.org>
References: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
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
 h=from:subject:message-id; bh=K2ldbf6BYM/COXf9fXWWOXeQSvNqNCKWjcngztoWlgk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4R3mdRTKe+hDMq09KpDoKQs6mbheocA/eZ5oI
 6Zb4j4z4KaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEd5gAKCRAADmhBGVaC
 FXIMEACohJQC7PrWij/EMBa4ELiXqZfcvPGcnolVetflBXxVEf7ey3sg44S2hqngMKReqzC6l0a
 wGtA+q/NpSGuXBIOX0NmffcPjiP5PSSd6k+mCb7zWWhi7AumpsRA2Ijcodsd1YByF0b5tIXxiol
 f72kbQDDTGtz32voQoJh1wrYQwXA1Oegzp2m1ZVTUuYryXaAuZ7cUP6SQRU94Za1kr+y7j/6pW3
 jJ7iWnmcVhVdUB/j86dhdb852uo26BBJT/Ur4/BDRgR6JI6/RZLMgW05efXHXqSpFVNoauXStk8
 sczg5CNUbBvSoLIxHVVDxY1yCH37cR8LgEZtsVfvf0/e82yeMwyburrFY7dxZVFYOmQ1QSD324C
 OBVpkvvzwekz0yT6zet+/kbdexc11T3IaNE/O6SgT49wilMxMRsGyVUcg19OF0W82tZifYpyAl6
 sBjA3pGYPhxoW9RpZgf5p0ZPn5T2fOtVSY4sPznXpcxd4CS/LMIkZ4x+/KgerFI+Dh40NnW5uo9
 1CsFueaOsXnBrVL3jQVgg5HSKhw3V1Iubir/+WEfmSNFjxpEeW4OsFpChV3s/J3k+aIogoK5hop
 BU6TovOugNGpCNPcal1n55qMvikhC01EYB/NZWx6sYmJMLlFPR26MvG0yJu2CSZcsDuHpDvQL7y
 Yv2wAHTFlfP5UUA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20893-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D611F4134C2
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
2.53.0


