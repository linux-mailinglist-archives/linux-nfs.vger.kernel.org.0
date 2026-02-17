Return-Path: <linux-nfs+bounces-19000-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA7IE7zmlGmjIgIAu9opvQ
	(envelope-from <linux-nfs+bounces-19000-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:07:56 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 736D21514D7
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F4B63008631
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 22:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFE631328B;
	Tue, 17 Feb 2026 22:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFEIZAWP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD28313276
	for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 22:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366060; cv=none; b=dYjbRgIxuwDqY7Hmn8xEHnH5hTJuVPg0Cmm5ngdfzZw/XvtGt/4hAomzNwTU4T/VuQBI9m+g92pZtfLAXg39QlwD5A/nfJDSBpVuDVkckjmfdEyJPMVc1XTPFhI38FmjJJ2kkHbrBRwUdB+0wzvuvFEbBJcxyzFeRywwdx3I+NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366060; c=relaxed/simple;
	bh=IF2fo2LPToMfB7GRwQVUgPXdg7M9ePDuZeofLdGqfCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAp5spZbmlllOnP4YOwE80DspuCjy1rNM5LSk9d9t2f3n8WlaYdzP6xoa2SHNXhAojwIJYDPtDZvVl0DDQq+KOkgBa53kIsmCqjMTxBNcwULiKaNJoGBjzg2Soub5DfKDfOTDFryJShvEwelYs5bGOIsjNZ3KS6qFkUUekvNZSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFEIZAWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0D5C19423;
	Tue, 17 Feb 2026 22:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771366060;
	bh=IF2fo2LPToMfB7GRwQVUgPXdg7M9ePDuZeofLdGqfCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bFEIZAWPicp6oOcHu/woKGppq1G51dDE352dIyjiEJ6T+KdoeEPsosRTjNhKXgjOw
	 BADS9uB3RAN8qII164bNDv2csZKnm5a4ULCAgZbGYXU/yJYhLLi/3kmulnLwbyG7Db
	 T5sjVaiHbLrV66F699pgZJauzVo5OmoDsCwF5+TDiqFVHQD/sbGKLnUZT1ehJd6vxd
	 7OYLdLFEGIuoWQ2cLj5+x78l3k2Wh+hqOkifGcgxNDewdodmqPDs3es9r7hW79NFlt
	 b6GeoDx6SRgtwS6YyjzGbgKn1o9H1j9nYN+hnMw1BST78aHhG8R5w1DAu0yXpH5UAo
	 y1oQYEbuZ/00A==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 17/29] lockd: Use xdrgen XDR functions for the NLMv4 UNLOCK_RES procedure
Date: Tue, 17 Feb 2026 17:07:09 -0500
Message-ID: <20260217220721.1928847-18-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217220721.1928847-1-cel@kernel.org>
References: <20260217220721.1928847-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-19000-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 736D21514D7
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Update the NLMPROC4_UNLOCK_RES entry in nlm_procedures4 to invoke
xdrgen-generated XDR functions.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index e9834b0077a0..f730da7d1168 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -1260,15 +1260,15 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "CANCEL_RES",
 	},
-	[NLMPROC_UNLOCK_RES] = {
-		.pc_func = nlm4svc_proc_null,
-		.pc_decode = nlm4svc_decode_void,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_res),
-		.pc_argzero = sizeof(struct nlm_res),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "UNLOCK_RES",
+	[NLMPROC4_UNLOCK_RES] = {
+		.pc_func	= nlm4svc_proc_null,
+		.pc_decode	= nlm4_svc_decode_nlm4_res,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm4_res),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "UNLOCK_RES",
 	},
 	[NLMPROC_GRANTED_RES] = {
 		.pc_func = nlm4svc_proc_granted_res,
-- 
2.53.0


