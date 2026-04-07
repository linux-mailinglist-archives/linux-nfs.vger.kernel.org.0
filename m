Return-Path: <linux-nfs+bounces-20704-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJIVNC0H1WnMzgcAu9opvQ
	(envelope-from <linux-nfs+bounces-20704-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:31:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CFF3AF284
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC480308FD69
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2026 13:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F833BED3C;
	Tue,  7 Apr 2026 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pL6TIqPQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACEF3B9604;
	Tue,  7 Apr 2026 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568181; cv=none; b=p+MUTYKWgHzJspgy7JWTv/hPgeD8wiNg3mithaWdFMrfW7D5PjR5QIUP/Ry0DFi2y0cR4zebMFMZjIL7yHBN8HfHoalNG76A7tJRW0IA02fqZsIYZSR97iNltdWU4x1uhfqcO3eCqlqXWsfEk0GxETUFm4DOl2GqNpa7268PS9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568181; c=relaxed/simple;
	bh=dvFkfIFmNTD6FOkMvIBtui2fVHcj2XA+6eKjVJjIZY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M3/7yFf2bhAOKeljzhlmORUnd9imLZorHTvdf9z8XdazPlwScqYdXWOMCB4q8XsGTar9R+/mS1HHb3eXrVN8jv+FDtY8M1PLoEsJvXjdzAwyO6n9MvsW6DZ+gFwpkAk9U7EmLBsQypZyQOWj5pl7Ep3ujiBd9saU+YgpJWnzYWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pL6TIqPQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EE4C2BCAF;
	Tue,  7 Apr 2026 13:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775568181;
	bh=dvFkfIFmNTD6FOkMvIBtui2fVHcj2XA+6eKjVJjIZY4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pL6TIqPQV3+IOw9Sr8XOaOHwZtBhOpBNnXb/WM0pgfDbu+Gebs5UwlW1E1rUlAopQ
	 giPTT6UPIzG9eJaT9nEDRei3f4Ls0GVq6scEc3wrjA6JzrSOQyilyQcNI9TO5GnXnG
	 f/a7nRGYDh0KXXbQIl6urYt9nloUibokPwHqmZiZSClyTO0LFLF2EXw1Duq2eBEeB6
	 omIToIxNYOAS+PshsXNy6fQU4phmHBiXg6txREMXrW4N9OzHo/jGDOTOjZRj9dAt3j
	 MY890Op0o4iwWiGOFBg+AJNqpWUCL1SXq5ujckz3dswsU6slH5S7KqqbNmJ2KTJLkM
	 rTzz8RG/0nVAA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 07 Apr 2026 09:21:30 -0400
Subject: [PATCH 17/24] nfsd: allow nfsd4_encode_fattr4_change() to work
 with no export
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-dir-deleg-v1-17-aaf68c478abd@kernel.org>
References: <20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org>
In-Reply-To: <20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org>
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
 h=from:subject:message-id; bh=dvFkfIFmNTD6FOkMvIBtui2fVHcj2XA+6eKjVJjIZY4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp1QUIF7cZXNXHX75V5YV9w/FPIeBvaOl1/Uz5F
 14bcqZWly+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCadUFCAAKCRAADmhBGVaC
 Ffr2EADFFuWcZQwYe//XnyyuQw55HjrbtGQJxDVx2EbQkCqzyBWSMStF74Tv2BnNb6eGZji/ehq
 SKUYqZoHxuuIAAgI1kLm+La9CXU56Kztjpw+chDeeRf6FNyAWz5EMWO4dX3P4IalT/WnxNESvw8
 ojsOXWgtMNapqfQ0U2Rdle3plGIQA3lMeTJTTPluOuidLR8DOGBMujZAGKON5AeqI/0qzbQYJCW
 45S26VnHKgmE2SbEONh6uB6UcewNjtXY47obAa9vGxrY6FmF4ZgRWiz+wxw3XLIzoN4deIwvf1k
 cwHZhTs2vL8LnesfT1Q3eAKWwJabfWF3Rp4dgi3g8JJ9PsOmeihbSGOi34q/QxC6FPTW0VtexyY
 ul7FZbAGwyHEPj3Bmb8V9NN0MPe9sEMJXinRJ+X4UgK9OkfwBobxuj+fymMB1+Dmw+/BlUhiPcv
 QVkGYsmXkgXyPFcF+0RF8F6JT921nEyA5KzLuLO0UHTYV3ve0e9XAWAu1x4Bwe7l9OgeiLgniN2
 L9E/G2Mn5V6TpWgS13TJ4kDtNEY/2k/3Rhxp30GPQIUErT9GnJI8vDSv4gaxwkJSQiBlmBBJueR
 G/LWxumo9PTHnqISF5OvTnjDMNBnj0yoEfD4S3bw7ZtyvCQyE4n0POwLRfg+uzBN+O1hx5S2S49
 f455uDXXMnDztMA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20704-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,goodmis.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,talpey.com];
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
X-Rspamd-Queue-Id: 62CFF3AF284
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
index 2ba3fcadb742..49ca24851707 100644
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


