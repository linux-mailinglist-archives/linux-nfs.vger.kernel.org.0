Return-Path: <linux-nfs+bounces-18390-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mG8FFvHDc2kCygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18390-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:41 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAC479D8F
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCE57304B806
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2BA26E6FA;
	Fri, 23 Jan 2026 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJZW3nE5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476A429E115
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194406; cv=none; b=u9MRxXv1/HZc1o91UoLD6nnDg+GwMEcTBQKrR1cqejpBv07mdkvjrDakr56IyMm+RNrxZ2uAu3M5xLdn8KN+MbTMHJoGovXdEzTESKL7yMy32DVStpU6nPe9Sv1ttFCiXJaxtRRQJo4TtegZsAi5GTMJ6ixLbFl5lG4DXhLld7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194406; c=relaxed/simple;
	bh=OeUVR5ZwfwqPzgorJHA6aCybp2CHmImwRwenuGSa1zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=turt+vaxtK/8bme4OHTDY/MV3ZmcQvR98loXTkNCv8z5rCrtSunIayaWqFtYeTD4u6kQUDsXQw5yptzcCKTaQBaQ3I3aGJjDzJmE5z14/XUEzF8RHry6NrdS5WjwlOGLku2J/HvmNXoyA1e89YBVmuAbTJ49KM2rBbTR9yK1mZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJZW3nE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A6EC4CEF1;
	Fri, 23 Jan 2026 18:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194406;
	bh=OeUVR5ZwfwqPzgorJHA6aCybp2CHmImwRwenuGSa1zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pJZW3nE5VgOpcide7Kx8gn0f1Jm3Udsou9k/HtpUCSvrblF27VkyNp8oGf7SoYocc
	 pnYSYkU+KcIoYPCO2Z9lg9Jxw29EVH57eT043/IhMX6OpwkXDpCKe0Wi3p8nhxAp1N
	 Bx6n76haRRiIZJyBXvGbNIcxwjk8iz8MGy6E8/KMgnEDuTkfkMaGxYostWwmEp2DbU
	 +UotQdQG9UdpLP4B9klWUiputWtlJZ1+4WK0wV93sPNGZRj85JBLw0kdBohAUuh66Z
	 6XhY2GI+G1Xitx6QoNLTG9bzrMGzcf/t/ST3CMGzb0vIfQWKmR+rRdBT+FgGX7TqBl
	 htvzUO3p+eXFQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 29/42] lockd: Use xdrgen XDR functions for the NLMv4 CANCEL_RES procedure
Date: Fri, 23 Jan 2026 13:52:46 -0500
Message-ID: <20260123185259.1215767-30-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123185259.1215767-1-cel@kernel.org>
References: <20260123185259.1215767-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18390-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: DEAC479D8F
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index fce3defd1cb3..d4b624e1e318 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -1239,15 +1239,15 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
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
2.52.0


