Return-Path: <linux-nfs+bounces-18999-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCGWIbfmlGmjIgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18999-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:07:51 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F24D41514D0
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD2E1300B9C6
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 22:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817C6313527;
	Tue, 17 Feb 2026 22:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ay8G8pf/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F936313276
	for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 22:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366059; cv=none; b=DR4Jq4j9MgsHC4ngGB9M9t0fKbO9BYEI5/cS02LkDw3wqhPdty3hg3ZtJuQ0h2qfRndP3nrkHxRQFFV1VBff28+BEJwN1/4T+Tjz8zdoGM+pX6eUCZUPkjPl7tbRWlsCBIQgaALUaYzCRsgp0UeWHF7IfuVjFVrysf6+HgJxV14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366059; c=relaxed/simple;
	bh=3veHAv+302ELqqfK+vGtHUHVOqejOIZszYbyCHzPX/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYwqsuN2uODm9+hlNE4+fNI1qfCz8URxMV7+VB/gLR91HrAYx1vHDcw5ZxpbPUlHv4uoK9glNdCGEwdH1nLC+J46nwsIgbiuC4a2di9ckDPKPIPjucOKzCSOqs7BVnuOzIs/HPJqOefrq9//MNigXXjRVskDn36Us809U9B8JlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ay8G8pf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9234C19421;
	Tue, 17 Feb 2026 22:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771366059;
	bh=3veHAv+302ELqqfK+vGtHUHVOqejOIZszYbyCHzPX/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ay8G8pf/TLFJ5r/Nlkz3Oxo/PvKRBRWSy3FF6BKGd2bc7TGJ9QFP7kFuDJoup1w3s
	 NVHS65qtH9U1OlbzU61oagXOmSIBdiloALyHHxOVXH5whaWjBPUSlisUV/jIIIceA7
	 Qc9mGcVDh90KktkScnbvljtzAoNHLSuhTI0eWCpFs9cSLDtIQRb/LjqDUZRsn79NVY
	 uh1Nz8Id0U+5lPmnpTfvIhxSfiZkZi1vl/DVvgKn4g9c8gh8BordThcG9vlZT/j4Om
	 jgTHsLz70tiyMODP6xZ1e0JByRkJh+a1HIhtVMWK+WrBGgCHlgIsN4LxseLj1siqb6
	 FvlW60KNt54Mg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 16/29] lockd: Use xdrgen XDR functions for the NLMv4 CANCEL_RES procedure
Date: Tue, 17 Feb 2026 17:07:08 -0500
Message-ID: <20260217220721.1928847-17-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-18999-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: F24D41514D0
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Convert the CANCEL_RES procedure to use xdrgen functions
nlm4_svc_decode_nlm4_res and nlm4_svc_encode_void.
CANCEL_RES is a callback procedure where the client sends
cancel results back to the server after an async CANCEL
request.

The pc_argzero field is set to zero because xdrgen decoders
reliably initialize all arguments, making the early
defensive memset unnecessary.

This change also corrects the pc_xdrressize field, which
previously contained a placeholder value.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index c5f21fc2228c..e9834b0077a0 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -1250,15 +1250,15 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "LOCK_RES",
 	},
-	[NLMPROC_CANCEL_RES] = {
-		.pc_func = nlm4svc_proc_null,
-		.pc_decode = nlm4svc_decode_void,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_res),
-		.pc_argzero = sizeof(struct nlm_res),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "CANCEL_RES",
+	[NLMPROC4_CANCEL_RES] = {
+		.pc_func	= nlm4svc_proc_null,
+		.pc_decode	= nlm4_svc_decode_nlm4_res,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm4_res),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "CANCEL_RES",
 	},
 	[NLMPROC_UNLOCK_RES] = {
 		.pc_func = nlm4svc_proc_null,
-- 
2.53.0


