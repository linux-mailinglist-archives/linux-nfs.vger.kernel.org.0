Return-Path: <linux-nfs+bounces-17214-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B49CCD801
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 56B9A302F6B3
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C10A2957C2;
	Thu, 18 Dec 2025 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBxUU7x8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573812D8370
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088850; cv=none; b=JSgUUDZFHFrXSXnSd3uC3kbsuTUSNpZiRI8zXCFPPYouw4SzAcQm9xqYQ5pNWb+A+Kx9W8xX3FGOiax00xUo7xSZfCuPm5zkTg2WDxA6pYNOCXo6W6eQVnZwZjTD+zt+its3PBJPf+XBh4WPUWZ4NSXasjXWki/0LI6D2lzA480=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088850; c=relaxed/simple;
	bh=vQSkaAMUFhsNYfLm8MknT4dgo0zQRdB1wM7nGH8bCGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QerLoHvqMJJ5wSt2S2rdGH79VOrTcagLW46zbm3q9GfIKCo+D5VL6V+ej7OK0BC26GmvUuRp2BE17pdIPoOknbRzvAbxC6LUpvvPcr3nRg1UroM/J3VNfl8793Qvzr+jktvJToqze0d7GOwxFua2en0oGTxphm3nWTfqKb04B3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBxUU7x8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35EFC19422;
	Thu, 18 Dec 2025 20:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088850;
	bh=vQSkaAMUFhsNYfLm8MknT4dgo0zQRdB1wM7nGH8bCGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lBxUU7x8dRmHNJnz7WVbegv9ZrjQFlF3gTQs35H14c900wfmFFzSfIoWB4lPkXidC
	 QkdUYUxw228qqtXZxwKub2TZZZD3zYFYSmEfbOvnnn1XEnqAVzQ/EwsAxpTa8WHbZz
	 TMqj+HGmt4C9+1aXic3+gG52xZQEQpYFASETs2uJmJadBsfOH95tamTxVUHsjRKM0N
	 X+nSBuLFgRqTW6yN0RPRG9o+P/yWFE4cFFAcLGxGy61rtzd9/heIn3IRN7OvKSiLT1
	 Du9iuViPTYbPSqKOgds5wnPPRR+cHXXPjcJOFaj3I0w+vBv2EYDM2Y2+tjyUUse0KP
	 CofA/imKWk/KA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 26/36] lockd: Convert server-side NLMPROC4_GRANTED_RES to use xdrgen
Date: Thu, 18 Dec 2025 15:13:36 -0500
Message-ID: <20251218201346.1190928-27-cel@kernel.org>
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
 fs/lockd/svc4proc.c | 56 ++++++++++++++++++++++++---------------------
 fs/lockd/xdr4.h     |  1 +
 2 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 6ca06c2051f5..fb610e390aa9 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -768,6 +768,27 @@ static __be32 nlm4svc_proc_granted_msg(struct svc_rqst *rqstp)
 				__nlm4svc_proc_granted_msg);
 }
 
+/**
+ * nlm4svc_proc_granted_res - GRANTED_RES: Lock Granted result
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ */
+static __be32 nlm4svc_proc_granted_res(struct svc_rqst *rqstp)
+{
+	struct nlm4_res_wrapper *argp = rqstp->rq_argp;
+
+	if (!nlmsvc_ops)
+		return rpc_success;
+
+	if (nlm4_netobj_to_cookie(&argp->cookie, &argp->xdrgen.cookie))
+		return rpc_success;
+	nlmsvc_grant_reply(&argp->cookie, argp->xdrgen.stat.stat);
+
+	return rpc_success;
+}
+
 /*
  * SHARE: create a DOS share or alter existing share.
  */
@@ -891,23 +912,6 @@ nlm4svc_proc_sm_notify(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
-/*
- * client sent a GRANTED_RES, let's remove the associated block
- */
-static __be32
-nlm4svc_proc_granted_res(struct svc_rqst *rqstp)
-{
-	struct nlm_res *argp = rqstp->rq_argp;
-
-        if (!nlmsvc_ops)
-                return rpc_success;
-
-        dprintk("lockd: GRANTED_RES   called\n");
-
-        nlmsvc_grant_reply(&argp->cookie, argp->status);
-        return rpc_success;
-}
-
 static __be32
 nlm4svc_proc_unused(struct svc_rqst *rqstp)
 {
@@ -1077,15 +1081,15 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "UNLOCK_RES",
 	},
-	[NLMPROC_GRANTED_RES] = {
-		.pc_func = nlm4svc_proc_granted_res,
-		.pc_decode = nlm4svc_decode_res,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_res),
-		.pc_argzero = sizeof(struct nlm_res),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "GRANTED_RES",
+	[NLMPROC4_GRANTED_RES] = {
+		.pc_func	= nlm4svc_proc_granted_res,
+		.pc_decode	= nlm4_svc_decode_nlm4_res,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm4_res_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "GRANTED_RES",
 	},
 	[NLMPROC_NSM_NOTIFY] = {
 		.pc_func = nlm4svc_proc_sm_notify,
diff --git a/fs/lockd/xdr4.h b/fs/lockd/xdr4.h
index e323a7f88308..c4c7f8222cf1 100644
--- a/fs/lockd/xdr4.h
+++ b/fs/lockd/xdr4.h
@@ -55,6 +55,7 @@ static_assert(offsetof(struct nlm4_testres_wrapper, xdrgen) == 0);
 
 struct nlm4_res_wrapper {
 	struct nlm4_res			xdrgen;
+	struct nlm_cookie		cookie;
 };
 
 static_assert(offsetof(struct nlm4_res_wrapper, xdrgen) == 0);
-- 
2.52.0


