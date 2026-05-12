Return-Path: <linux-nfs+bounces-21565-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA9FBdBvA2p15wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21565-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:22:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B28CE5276CC
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B943B3161A56
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7113236C5A1;
	Tue, 12 May 2026 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLbxeCI+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3EA366831
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609662; cv=none; b=rlv7jSDm+7RGb4LF8gTRrxHALWBvfgPGPvNqrirvPNp0dPCBr8RHNhvdQwpUkIfRH07qRF62It70n+jxwcKOi2mRZiT0Ar9WBGhvpPUAFwHLitz+MwSk6EjhEGBg48I6tOKDBjwXqX6+PK2QultW57OirTHNmhu3sPhpapreCGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609662; c=relaxed/simple;
	bh=5arR/Y0FA+93HoH2VeQYEPiqRawCzbdxXEnjZPE6ZXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wz/KBQ/9xwqPpa8tI5tXEwWMe128cyzEvvlUnYloFWPkrM7soKvPuqaMZ33iK2kc5hBODv+XLHwcb2huyaLN2d1TBnlQw6R8FzCyNVBNlprf/AukUr+Yc1kPwE69oty9BNIV/WAIyGkTaB3xYt/it9V/o/tydZuCMR6iSDkAcBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLbxeCI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FA4C2BCF6;
	Tue, 12 May 2026 18:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609662;
	bh=5arR/Y0FA+93HoH2VeQYEPiqRawCzbdxXEnjZPE6ZXE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gLbxeCI+eIS1oSFG6yUKEsrw/5KapIV5UcjcN5CKnApWD5tM9pZWD/sE66XWn2Ae5
	 PHu8TmjJMOm0R6pUAwhMBbtQfexsGrhCdkKZdr9bFuu3DcMc5SWds6cCUoMQOodi2G
	 z2r0JW59AIKoDm+KG6WnQXHBTgFJMKzDmMZCBGtrP+7nqj3jJN8b18e7iUdJxVykOY
	 sOjWSNTILxTdWp+1wpX6GrJz7WErv+H7b3Iw8hKOzQ/f3GiTB4zACfXV5n3sfUkAYP
	 Gj71Z35lf721fqsPFhbsj6YsK+DjdqmO/t/VL9t9w3nA51WV7BAPHQ2nKzQjoUFPvM
	 mcdxwth+JxFaA==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:14:00 -0400
Subject: [PATCH 25/38] lockd: Use xdrgen XDR functions for the NLMv3
 TEST_RES procedure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-25-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=1788;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=9CLLbMl8fKvKUw72W/2fg3tMYzDYxunRUx/7JWi9G7c=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23mVFVpzZEwcnOgMuTv8/7rzHJTj/BKxccz9
 JMlho4RZYCJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5gAKCRAzarMzb2Z/
 l1xkD/4789KFcKscHLm3SALXRfqiGyJgYCZAIa5guBUJjsuMELVTcEnKb4og+8VKRdL6j1ZolI8
 9OWx2AUoZ0rZSYDslA54XdGkBnG5gR5USEULTgcpvstvY3hDnnplqsFwuSMSTStsT8he7Kr591B
 oPLYpSpP1tRtt4dEzx/00nYl9ziQBw59pmBZ51Iz74mh3tSRAevkBV4sFSFm8jbXL9C7bj9Wak5
 xxWPk0jnPnZmDv6amaKfyWrLev/ZwxcOp3Wzba29FjSILYdDiLEa2NFZeT3zQYjDacRFrZFR3H1
 w9FN76SEzHzItyc4eDQ6fxKrEl3qnQCQNdBzg8PFPVADvaUozgFpwxsNNFFNLDpMGbICRIHJ7hp
 6RV3GlMTDSPTssBmmAmLk7Y41kbqWqte7/S/uJI2R6yGMb1DLqFw868XPGeyeu12geJMZ/xktSR
 y3eauxeNCAdHQwYCVvdLkaD7l5L3iP3kL1Lf6RDePKAShKQ+7pE6TMlQ2Ol/LKFHCCJSf+QjoqA
 kQFs1U2pnxLG3s+fOx1k+6qib0GvoPgq26Kzbg4DfYp7TjDLhytOQiVVvmBlyczg+6gp619wxVL
 cdnJYKSvXgBJ+lnlk8uaa1Dzq5IGepw/4DpSGFQXZmizRhGNFbDMKrbJ3DZ8yUjAjxqftrXgDYe
 74hwTlwMlqjqBzw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: B28CE5276CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21565-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Continue the xdrgen migration by converting NLMv3 TEST_RES,
the callback that a remote NLM uses to return async TEST
results to this lockd. The procedure now uses
nlm_svc_decode_nlm_testres and nlm_svc_encode_void, generated
from the NLM version 3 protocol specification.

Setting pc_argzero to zero is safe because the generated
decoder fills the argp->xdrgen subfields before the procedure
runs, so the zeroing memset performed by the dispatch layer
is no longer needed.

Setting pc_xdrressize to XDR_void reflects that TEST_RES, as
a callback, returns no data; the previous value of St
over-reserved a status word in the reply buffer.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcproc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 21a363450d59..ed1164ff431a 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -1270,15 +1270,15 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "GRANTED_MSG",
 	},
-	[NLMPROC_TEST_RES] = {
-		.pc_func = nlmsvc_proc_null,
-		.pc_decode = nlmsvc_decode_void,
-		.pc_encode = nlmsvc_encode_void,
-		.pc_argsize = sizeof(struct lockd_res),
-		.pc_argzero = sizeof(struct lockd_res),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "TEST_RES",
+	[NLM_TEST_RES] = {
+		.pc_func	= nlmsvc_proc_null,
+		.pc_decode	= nlm_svc_decode_nlm_testres,
+		.pc_encode	= nlm_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm_testres),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "TEST_RES",
 	},
 	[NLMPROC_LOCK_RES] = {
 		.pc_func = nlmsvc_proc_null,

-- 
2.54.0


