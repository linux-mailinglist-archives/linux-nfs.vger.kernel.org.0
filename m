Return-Path: <linux-nfs+bounces-22619-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IiS9DU0+MWo0fAUAu9opvQ
	(envelope-from <linux-nfs+bounces-22619-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:15:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1E768F33B
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:15:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=A2JeWfVX;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22619-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22619-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF76D304CE04
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 12:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291B146AF39;
	Tue, 16 Jun 2026 11:59:40 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFB146AF16;
	Tue, 16 Jun 2026 11:59:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781611180; cv=none; b=cSjWlQjrG9gZjDk3qqiV5X1uyC65V00KUPr89h4YRTwIDXCEjbxBpyVjdxlObbs5Bt2TwcEto18Yjoe6EsZY47x9EaRlUDgSAVyGp6/OyT3nI6xqagPHdSJNxZwP1FebeRgxKy+n4fgehlAyFJrZzUmujfIHKcZaOMzUa3wPuac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781611180; c=relaxed/simple;
	bh=K9UhRpNlzYu8d+VL4G3IsoS7r4SN4fAHAZhF1Stpfok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OysOHSQnLw5MOv95OSvR3MRtHyC3a7af0ULyWA9nYfQqu90IqF5gqXl5D1zAI/qUv+bJVaSK0+7bWL3WRK230LOd/qb6OPuZXJpfkZz5RFzdrwEBOXSvJlaElmW9Bsa+WAI4ObPwaD0LPHI/5WxxlPFltctBrhS7ymmsBqyn/6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2JeWfVX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1091F00A3A;
	Tue, 16 Jun 2026 11:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781611179;
	bh=VH4vh0l6rT3tb6ScrgutK/Cw5Qa0NTvwCeeQIBAZhRI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=A2JeWfVXdV0EMy7VJi1ah3owxFJlPLGf/Uio0Uk5DMtBbwmdTKzksuhu9r6ggOa1+
	 O04N/ymwkdrZ89HqO8weF0/A6neojtHYZlMKXrlfnK7VEpPtz3b+FoWf7yV5ZMqylX
	 GsmOrixWWfwd3bEtl8781ho0ZhVq8LGqeprGkGLfZfgwG4rVlwkOYHWeei73WP2ggJ
	 AgrjYQJUvrslTpmoF0M9SHVxpC3hoU5bA3tFpC83+qvo6rkcVPQgu3oiVt/VgOqILj
	 dBQ4pEpGPx/P1RYsqvz5wkY2qHwopztXVsy/3iayzNUh3R8vpoAwJ4e3jz9wfC7RH6
	 MMuiLyoqYa9EQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jun 2026 07:59:00 -0400
Subject: [PATCH v7 17/20] nfsd: fix reply size estimate for
 GET_DIR_DELEGATION
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-dir-deleg-v7-17-6cbc7eac0ade@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1321; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=K9UhRpNlzYu8d+VL4G3IsoS7r4SN4fAHAZhF1Stpfok=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqMTqHX7HO71PzaZja73s5e/jTU+la/NyntTVkB
 RLovIiypROJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajE6hwAKCRAADmhBGVaC
 FdBsD/9lAminPfaYkxxPV0sy6HQdyxcEalTrBcMu34nXONNg7KyMcw/xPB9DF+pd1Nj/lSDstJm
 xLbh9dsSJkyiRdRrBz1TyXU4xYOCFZXIzPqeoGVv/YPbrAIBJKMViCvF4160o6Q9Tvr1O7NbgBP
 ewiRMozoGRk82qjMhLvnZQR4Sf08EgAsnU/eFR1r36EclPRf0/QNWVwZJO8Gt/Z+a2w0CuT/qVG
 AtW9fJFfeqc/GQua/cbpCfbdOW1ckC33sVLT3tgHy2ZMdOsTM8AWDGLepfXLJn0ARXvBTlkWe3q
 CLEqbUMbOVPb4hiIT7P2TeTuHf7EEQdsK8s+GjqANDQqhSM7JqzdQdxGmSU3N9DxCEuyDJUxFLj
 aKcGwYjbS9q7p/8zyTCx530+UKnfMRe+OCUxGQ0QnrLq0uz03fndCcMnJQrdjGt8x7lYWDTe8GB
 LKt1eHAZaaucPHW+b9kVMiYMt6r4pncmJMOMepjP8nSvvgC2F+XtDw5eL4UrAZ4EMgJx0PNycLS
 pgOOIMIaZXCOsZqtIQZgGHrmMq+Gg+1JwtdmSA6G8i82RKICjKrdw218S5Kmc9BftF4rAqzFfMC
 vMWEflAmdYC7gHuKnBS0ryQAy6MtE7n0y1uxdxssQtsgZySADScfeh/9CQy2s2bTdE4TMOQghGE
 YzVAkCw/a5YsxIg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22619-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cel@kernel.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E1E768F33B

nfsd4_get_dir_delegation_rsize() returns its estimate in XDR words, but
the COMPOUND reply-size machinery works in bytes: every other op's
_rsize helper multiplies its word count by sizeof(__be32). Since
GET_DIR_DELEGATION is OP_MODIFIES_SOMETHING, this estimate is consulted
before the op executes to ensure the reply will fit. The ~4x too-small
estimate lets a compound near the session/reply limit pass the check,
grant a directory delegation, and then fail to encode the reply with
NFS4ERR_RESOURCE/REP_TOO_BIG, leaving the client without the returned
stateid.

Multiply the estimate by sizeof(__be32) like the other _rsize helpers.

Fixes: 33a1e6ea73e5 ("nfsd: trivial GET_DIR_DELEGATION support")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 565bf76c08ed..be79b6063afe 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -3575,7 +3575,7 @@ static u32 nfsd4_get_dir_delegation_rsize(const struct svc_rqst *rqstp,
 		op_encode_stateid_maxsz +
 		2 /* gddr_notification */ +
 		2 /* gddr_child_attributes */ +
-		2 /* gddr_dir_attributes */);
+		2 /* gddr_dir_attributes */) * sizeof(__be32);
 }
 
 #ifdef CONFIG_NFSD_PNFS

-- 
2.54.0


