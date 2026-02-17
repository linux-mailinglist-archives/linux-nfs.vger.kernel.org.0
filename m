Return-Path: <linux-nfs+bounces-19003-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBneED3nlGmjIgIAu9opvQ
	(envelope-from <linux-nfs+bounces-19003-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:10:05 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F9B151561
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8AE33075FA8
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 22:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1480313555;
	Tue, 17 Feb 2026 22:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSHLTvzU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E818313276
	for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 22:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366062; cv=none; b=Gqy2FbhSjLvrczjDRHPJwI444yYEvJ+5//giqEL8SPv9NeTola1/RtomOVBjJEyyZz9AaIbaJRx8R2TKRD9+QwJUz0xk+GsWJTUn2HcxeCnwIDoWSjplwOCLKdWDTir3vFfjGbSCQgxu2GaBRskuGB1UPO6MdvNZLvN4BrgcX6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366062; c=relaxed/simple;
	bh=nR3RFyhiUIy6wY20suTCNgLAt6HshQkyBppuUdxAGsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFu8aAI9WJFu0c9ziON2XvrgmOYffKDEW7sveTt4hUMfWIY3fmCVaP66KoBJRemxes/dNy9D9eW0A8T62G9IWCGsbWKw6OsK7IT/n4hSuldNtB/S3x8VUi8UfUEYUaBlMKVLbfqtKscfUSsIHEpNU4cGr7z+KR6gwnYk7fUTnYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSHLTvzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5835C19421;
	Tue, 17 Feb 2026 22:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771366062;
	bh=nR3RFyhiUIy6wY20suTCNgLAt6HshQkyBppuUdxAGsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TSHLTvzU+newSsL+3NMGhNzKvxF8uQ/F0iY/bPtdq2svObw1nkCR0jFpzhSo+ZX3r
	 j5S4Clfe6pY5dxo+UeG0xCF2rAMNNRANo/ZuiGavIMvxBFtK6ncnNUgL7Pj1yvj2Dh
	 mhKnXdsiGN6PonKNOeeZaLitHHVCEVPRLUPIBQKuUsOWS82IvoVw1pihkBYGUST8yt
	 SHyNSJ6Y8h08oEXuJHE/pcPR5kmF9hyBjoPIkVg5ctywfiK3iHAcFJVFMw0ncHH97C
	 SLFts8aAYUUUvmMsWn/wmFZMqwNxax5JdlNBYcgwb65jDV/rVDtx0FvO/IIEovRSHs
	 wvQ/2Ac88OVRg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 20/29] lockd: Convert server-side undefined procedures to xdrgen
Date: Tue, 17 Feb 2026 17:07:12 -0500
Message-ID: <20260217220721.1928847-21-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-19003-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: C6F9B151561
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The NLMv4 protocol defines several procedure slots that are
not implemented. These undefined procedures need proper
handling to return rpc_proc_unavail to clients that
mistakenly invoke them.

This patch converts the three undefined procedure entries
(slots 17, 18, and 19) to use xdrgen functions
nlm4_svc_decode_void and nlm4_svc_encode_void. The
nlm4svc_proc_unused function is also moved earlier in the
file to follow the convention of placing procedure
implementations before the procedure table.

The pc_argsize, pc_ressize, and pc_argzero fields are now
correctly set to zero since no arguments or results are
processed. The pc_xdrressize field is updated to XDR_void
to accurately reflect the response size.

This conversion completes the migration of all NLMv4
server-side procedures to use xdrgen-generated XDR
functions, improving type safety and eliminating
hand-written XDR code.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 66 ++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 4f8c41046ed6..b4ed77125f68 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -1029,6 +1029,18 @@ static __be32 nlm4svc_proc_sm_notify(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
+/**
+ * nlm4svc_proc_unused - stub for unused procedures
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_proc_unavail:	Program can't support procedure.
+ */
+static __be32 nlm4svc_proc_unused(struct svc_rqst *rqstp)
+{
+	return rpc_proc_unavail;
+}
+
 /*
  * SHARE: create a DOS share or alter existing share.
  */
@@ -1133,12 +1145,6 @@ nlm4svc_proc_free_all(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
-static __be32
-nlm4svc_proc_unused(struct svc_rqst *rqstp)
-{
-	return rpc_proc_unavail;
-}
-
 
 /*
  * NLM Server procedures.
@@ -1323,34 +1329,34 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 		.pc_name	= "SM_NOTIFY",
 	},
 	[17] = {
-		.pc_func = nlm4svc_proc_unused,
-		.pc_decode = nlm4svc_decode_void,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_void),
-		.pc_argzero = sizeof(struct nlm_void),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = 0,
-		.pc_name = "UNUSED",
+		.pc_func	= nlm4svc_proc_unused,
+		.pc_decode	= nlm4_svc_decode_void,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= 0,
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "UNUSED",
 	},
 	[18] = {
-		.pc_func = nlm4svc_proc_unused,
-		.pc_decode = nlm4svc_decode_void,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_void),
-		.pc_argzero = sizeof(struct nlm_void),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = 0,
-		.pc_name = "UNUSED",
+		.pc_func	= nlm4svc_proc_unused,
+		.pc_decode	= nlm4_svc_decode_void,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= 0,
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "UNUSED",
 	},
 	[19] = {
-		.pc_func = nlm4svc_proc_unused,
-		.pc_decode = nlm4svc_decode_void,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_void),
-		.pc_argzero = sizeof(struct nlm_void),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = 0,
-		.pc_name = "UNUSED",
+		.pc_func	= nlm4svc_proc_unused,
+		.pc_decode	= nlm4_svc_decode_void,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= 0,
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "UNUSED",
 	},
 	[NLMPROC_SHARE] = {
 		.pc_func = nlm4svc_proc_share,
-- 
2.53.0


