Return-Path: <linux-nfs+bounces-17216-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 116FCCCD816
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CD5D3056C4F
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D772D8DCA;
	Thu, 18 Dec 2025 20:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HI1F5O6V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10522D8DAF
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088852; cv=none; b=LkbsIh1WyWzwQgexa5w+6gtdacIhGM6CeWvnSmeWM+TOCeTBBn+s7dytBcBk5bkj4E5D82HmJejSKOAtWCJuOzsgh97wKNirKSkPyq2N+4DqdzwissXcN6obIMUzBRfy4xmPKWbbxnPaoY967Y0s8znpX2hSsbxKFxI3siXoCHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088852; c=relaxed/simple;
	bh=ejBZC2TRv1CmKGVrlswb5Ury9jBncOdgdsuTxW+bJ34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekPQq/Wc0Jj3iuUbgMzHpDOJon8I4nF5DFTEBPbWrLCN4FJY7/nuMEeG2wnvsuzMi6l79uhkbSgQ7uCLnOkPEHcoM4agFsmpVdyJTw2xAO6lDKNETf3BZa6Bv6XQ052dJxyKrS+f2Tvmkm6D5fp02BvcIVseaGMePGiMitFYWT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HI1F5O6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C000C116D0;
	Thu, 18 Dec 2025 20:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088851;
	bh=ejBZC2TRv1CmKGVrlswb5Ury9jBncOdgdsuTxW+bJ34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HI1F5O6V77VBJbbNM4Mgq68sPgTTc2hRyEzJTwubPWNte9VfVunFd77D4kR3SCK9/
	 Vn80hVJFM7gQcczBLk6PVXfKEEmVYtMyI1zXvEVYs3ArNNHpOizmyn46LSLpmA/YXF
	 wlO3JxegOlPn6dygyX2rhWu0QgsnQTklSX0AaMLjDzNtSpVrlRBZJz+6Cj9zGiOxBd
	 dxqMYUke45J4mJ+99Eg6qn1xcisNpFYRyGIP/oMCJaPNYAlJDyHaPI4/0N7mGA3C2L
	 wzJjQUIaqizFVCAGY7kvL7KSpCZ4ZJUxUpA85INl8j79N3U4Pvrn8zTHjtvttjamdv
	 QDOdd8kurLN1w==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 28/36] lockd: Convert server-side undefined procedures to xdrgen
Date: Thu, 18 Dec 2025 15:13:38 -0500
Message-ID: <20251218201346.1190928-29-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218201346.1190928-1-cel@kernel.org>
References: <20251218201346.1190928-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 66 ++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 8a4ca46cf48b..c6baf0a73620 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -824,6 +824,18 @@ static __be32 nlm4svc_proc_sm_notify(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
+/**
+ * nlm4svc_proc_unused - stub for unused procedures
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_proc_unavailable:	Program can't support procedure.
+ */
+static __be32 nlm4svc_proc_unused(struct svc_rqst *rqstp)
+{
+	return rpc_proc_unavail;
+}
+
 /*
  * SHARE: create a DOS share or alter existing share.
  */
@@ -926,12 +938,6 @@ nlm4svc_proc_free_all(struct svc_rqst *rqstp)
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
@@ -1116,34 +1122,34 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
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
2.52.0


