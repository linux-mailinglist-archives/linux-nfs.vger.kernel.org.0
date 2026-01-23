Return-Path: <linux-nfs+bounces-18388-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPAnI8TDc2kCygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18388-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:53:56 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB6779D08
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 964F0300A30E
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B3428727F;
	Fri, 23 Jan 2026 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/K29rsn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4BB299927
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194404; cv=none; b=pwKFUVq4n37CCLykbGC+zNdPiflhsSSVN/ue7V+eQaJHHJIFp5xIMQ7ZdrsT9XMutwjI5zcmDBZHQDhiBUEYezqAeACsCdh1i37X56OXj3/WlK0P9z1Md6rBNTwLEzdvRk3ojoYJkewF3+b/CTP4NncCdegACtingj1vMdtpj9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194404; c=relaxed/simple;
	bh=CrG6a99mAEtm+pR8cCZSNHnnxRBvbtfOj4V7IJoiHt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxLVwfbk45299RnMOke2lToD5ncOEr/qzDXBhnU4PLaoMXJp9L7cxV4HdfiX0C9c0aWpYRrYnpYQwlB9krlq+s+R8ydHO8pHJEcKjAW6qtv7ka4pVsgez+AbR8XU6mTJu+36sY2LK5/TFW5QCPv34JJ6ORwGFd9WknR2KlyYDhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/K29rsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FC5C19423;
	Fri, 23 Jan 2026 18:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194404;
	bh=CrG6a99mAEtm+pR8cCZSNHnnxRBvbtfOj4V7IJoiHt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e/K29rsnrXF6kC/VX8N3y7RQFoCsRmXNGO/f3FcMfiLxDJViA+zjCll+HfdUOc0/O
	 WFQhK7NULX+7Q23F+7MiFuZGSaLoWdbg/wP8St64KXZoh3mfVMBf48cU60H1rs9RmL
	 mjAfw9SmEqclUTp1MAFb4MMskwog6FWF1vNZ0+/MuyAm+DETlCw5BDfpYr43IJf2e3
	 UxkSDXhRzIHJtzShegA1l3vM8qGkhgcasXeIiX0FxCOedgT3CcSPqvW31+nlPtA3K2
	 L3yS3hrzhdNxtGQl8A1JR0B6OYEQwDYOwBVPn6GzKiDkP1OsXNTFs9s2fTNjeFslVb
	 UwDf6Er9XzgPg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 27/42] lockd: Use xdrgen XDR functions for the NLMv4 TEST_RES procedure
Date: Fri, 23 Jan 2026 13:52:44 -0500
Message-ID: <20260123185259.1215767-28-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18388-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 6FB6779D08
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 171ee5ff2289..60c5082cd447 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -1219,15 +1219,15 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
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
2.52.0


