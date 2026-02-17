Return-Path: <linux-nfs+bounces-18997-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OZxFCrnlGmjIgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18997-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:09:46 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFC5151553
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52F85306DF30
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 22:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25D9313525;
	Tue, 17 Feb 2026 22:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEff5a0O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0068313276
	for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 22:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366057; cv=none; b=LIh1Jq5geVDRC4tvOysRHzbuSf3pO0azYkUj/iT+yzemUHd8Bl+WXW1REUoLrclpoRLn70+Y+bMCl7cRXleHzrvHM0zeH3nBreA8U8n1qmUvTyu7wzCVqjtjxyQX8AKRzoufzjRF4XGYUdR6eW32KgKVS2Wg7MvpGjQE5t3A628=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366057; c=relaxed/simple;
	bh=lIwU82ZHgRoBIt3ZSjjKr1uLU8ZD+KuqrynmAQBNG+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+6WBiH1UKpAMvhmSxV52Ul+WGO1gDok2YjYxMQpxUbIbNCM3Qp4YXUdUq2NmWGqUtpUtYAC4dswPjflPvaIjOChMYlOTqMIm5P7z/7QzG/nO8+19gTxmyS71l/UsZVPLX4VYTWM7oeZOCR6z4W2nq/1vPvHCe1e45t3NOPKuHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEff5a0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1186BC4CEF7;
	Tue, 17 Feb 2026 22:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771366057;
	bh=lIwU82ZHgRoBIt3ZSjjKr1uLU8ZD+KuqrynmAQBNG+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QEff5a0OYS7nnBz3A1t8wWxhZpGW+jr4VOzqf24ohQH0dxb6mHhLZtAMIJ0mbI3by
	 jM0yaLE07dY8dLPm0zYik5PyRWXrdMzPmna33E+Rdvn88AecQlNbvsO9GOxRBp+20R
	 vEI1DImtxFjc9varDATFhBKB78tCzGKXTg7o2dn/PBXIzrgE9EKfYyiYD2bXlMBej/
	 iGjGyJQi4WhDmX/ejQtfKlVszESYm4rVqdNClhvLKH+M3Qs3kd8S3LtGmWJx3NIack
	 rFDkTjeUUumHZUeOEYT19pBI1uzlEjmzXNspMx3wy0S/U+Q1NlHCIgtKIX4l3Y8hJs
	 p18yLFXAJrsPg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 14/29] lockd: Use xdrgen XDR functions for the NLMv4 TEST_RES procedure
Date: Tue, 17 Feb 2026 17:07:06 -0500
Message-ID: <20260217220721.1928847-15-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-18997-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DCFC5151553
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Convert the TEST_RES procedure to use xdrgen functions
nlm4_svc_decode_nlm4_testres and nlm4_svc_encode_void.
TEST_RES is a callback procedure where the client sends
test lock results back to the server after an async TEST
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
index 306ecc21154e..6b391ec49341 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -1230,15 +1230,15 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "GRANTED_MSG",
 	},
-	[NLMPROC_TEST_RES] = {
-		.pc_func = nlm4svc_proc_null,
-		.pc_decode = nlm4svc_decode_void,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_res),
-		.pc_argzero = sizeof(struct nlm_res),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "TEST_RES",
+	[NLMPROC4_TEST_RES] = {
+		.pc_func	= nlm4svc_proc_null,
+		.pc_decode	= nlm4_svc_decode_nlm4_testres,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm4_testres),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "TEST_RES",
 	},
 	[NLMPROC_LOCK_RES] = {
 		.pc_func = nlm4svc_proc_null,
-- 
2.53.0


