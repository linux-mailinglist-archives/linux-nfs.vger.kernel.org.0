Return-Path: <linux-nfs+bounces-21829-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA+kLwKyEGpWcgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21829-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:44:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 741695B98D5
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C9633019E49
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 19:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B143038737B;
	Fri, 22 May 2026 19:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLn2RcYQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93698384CEF;
	Fri, 22 May 2026 19:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779478981; cv=none; b=ZsqTEQU4K73d++/zBZnixNiALL9q5afhRH3bw8nrwfzrMjqxEOJfRpDpu+HSJ0iZwF/yuUOWnCzeHRRNzEI/HdfW6eyVk5hu1sePzS3VQi9KB+UVItn/PolZt2Max//Ln3NStWv1ohaFkaeix/oIDBGVahswHOLtbekWwlx3+zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779478981; c=relaxed/simple;
	bh=/nJ1xNNDJ9rJbf9EQXkdUUjwKKr61STzhNKZjVXGJbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ETLAseYGGRQyDQRo2zHSc4Xa79szk6/wI3pBT5aWlbbZqphrnIuzGL0qyfS1LMi6fzRmqE3iM9KIM2iYZ1azHiim/xLCD7l95Fo2w2or5TyTrsLg9Z67DYEe9DtoQAYQKzp0ZocBKcJOKqtVNB0R1ZKysNdR+Q2DILhmfFKKYD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLn2RcYQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FE61F00A3D;
	Fri, 22 May 2026 19:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779478977;
	bh=0psYgh/U78Yx/gV/O/+YpCNlLQ0kiZOK/pcEbcuUCHM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WLn2RcYQ6elAS0QO4hkYfS9zg4eucCdfmOBLOSLgA9+MZNjvEnkjrBrjaLje4wngH
	 l9rAZnvvZxL+Knx1xwIOd6jvYzg5IsKANpZTP87+wjvowvdOLRCYJdJhDRASoX/J9t
	 PaJz+cNRnZhCMQ6zEWAc+ehmqnVdCTy0FwBdqrCqdVqeLyQIeBV6/RpbHxdL8imxjQ
	 c3lBMy1OszmXL50+boqAjMGH4ocKWGJCD/oCtBW0nStW1ADwWgCM1ArNOCj+/mT0fu
	 2ynx8dw6339L0T6FaNJRAsxxbbk/84Riwsmc/QTArspQ7vJvqggaIBkUxZkMz1owMV
	 /jhJlhgUFMnpg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 15:42:19 -0400
Subject: [PATCH v5 14/21] nfsd: allow nfsd4_encode_fattr4_change() to work
 with no export
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v5-14-542cddfad576@kernel.org>
References: <20260522-dir-deleg-v5-0-542cddfad576@kernel.org>
In-Reply-To: <20260522-dir-deleg-v5-0-542cddfad576@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 Alexander Aring <alex.aring@gmail.com>, Amir Goldstein <amir73il@gmail.com>, 
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=846; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=/nJ1xNNDJ9rJbf9EQXkdUUjwKKr61STzhNKZjVXGJbQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqELGhVRmVV1RdAbO5AF90jTEqpqzLmS5q5Ef6d
 YFBjQYzw7uJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahCxoQAKCRAADmhBGVaC
 FYt1D/4gDF21xjGVeK2OCgNDJDwwQIAhQ+POJRW/LnUCyBsCodppfZgvOlztiRxTQY8hDln7pkA
 /0JBBL5d3Wm5z17lRzJer29pJX2RnxyHJNE4EW8GUhCCfgsEMpQ+8K24h+BP2GS45JqjLXuuCAQ
 AOxXkSg3co40fpNg5HoRTvTNMCBGZu0uO+uFPz+jEXouihz0LAAcFOt4XHYvy20xnAaxDIMvpSr
 X9QCRhnBITWU4+YuI7lIAymK2kYu0yOiJMrRr2k4iy7lUx0AhS7ox+64wJgEAVE5xyAnhRsRplR
 FEcV9sNWyh3PNNXA3gROeqkOkIyofFHUeGftyvxg4CRGcT+XQgfHnOuCvfAUxeZJ73BSLte9iy1
 SjeceyT18Sx089vx2L8GaDJxBsxSRnORbFkW6rC8CyQxUFKLEgUpp7R6MAjEzCDdqn0VoDy+ThW
 TerSDdP2CfmfKB09+/h3NS2HfOeqo5p4VzGkexzQMYn9TRzmZ1fIRP/Rq7P4+aNMiquVk8Ak0xj
 yA5DeWdIMtY2YJcLfa0PuBDkHDHkvT2Fp3uC+L7tWrUo1kEynA+M9I44sSfN3fWUQhXNd8/yLea
 AA1i8e592Ht9S+THZ1rNKVuNsiulM00HkfKIiyULDKqIeWJaZpI7IHPCK263be5r8YkjCyyJP90
 d4H9BqMYUkzuMgg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21829-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 741695B98D5
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


