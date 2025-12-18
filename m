Return-Path: <linux-nfs+bounces-17207-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A35CCD7F0
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82ECF302E2D2
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E082D8796;
	Thu, 18 Dec 2025 20:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5FEcYPB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91822D8370
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088844; cv=none; b=tbJnGuyn6jET3tHK2tbZJVlD4xLv5rrJAxfBwsDpB8yIxNTy46fZxYW1/Xk+f1zgC7r42Vvc725CM5mgm/OOPCYKSiaKJLPqtWZ9Qgl6IFRv5F/OtHKB+0KujcYB5j+QuTmreDI1lem3daBQ14hrjHvIJfLo+RiVKhI+yauXLEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088844; c=relaxed/simple;
	bh=yCz1ZhVY7BCXOU56Uc8E8C3DXSE5sODNfNsgydpDWTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RViRpny25DeiyTnCO157fjIw4znAZyPkhHRisX15f4QHwIqGG0FtjR6TWuZdxvaGoRkTFQWrLfTwNDChpUUrP7hf1ZCPoIo8/za6nm4mvST90HsLEL5jOLBNEUhIAX13+DOD4top6W2soZb46g6M0jzWLq+yT/A4ReiowqROk+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5FEcYPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3248FC4CEFB;
	Thu, 18 Dec 2025 20:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088844;
	bh=yCz1ZhVY7BCXOU56Uc8E8C3DXSE5sODNfNsgydpDWTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E5FEcYPBDuyliZP6KDLXYBVXW4XpQ4dA9Femx8zDdWI+5gdcT5GjBnBqASdIOp6lr
	 FVr359lkzg06uVh9yei/IQ9dpEk/naJ0hMRS22QF9HQleYBUSJVuszp7rumtl6FZcD
	 FzyKgPhf0psZ52XvbZjeHpXhrKWFIq/aAPaXX0yZJKHTciOXwODgib0Dn5r0nB0fkC
	 J66Ze8QRWdsQPvb0ejBcun6TGstgDKej/qxFI3hMApKpcBXTLaK3MIVxPF/L2R42C7
	 C4lKBXStZ/JbEZyYdI1HhPAbZcwgCcEqRN17HWxtWbx94uTSR7WH63CLHaoYg6/YSb
	 szEXIc3Saruyg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 19/36] lockd: Use xdrgen XDR functions for the NLMv4 CANCEL_MSG procedure
Date: Thu, 18 Dec 2025 15:13:29 -0500
Message-ID: <20251218201346.1190928-20-cel@kernel.org>
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

Replace the NLMPROC4_CANCEL_MSG entry in the nlm_procedures4 array with
an entry that uses the xdrgen-built XDR functions for that
procedure. Helper functions are introduced which will be used here
and in subsequent patches.

The .pc_argzero field is now set to zero for the NLMv4 CANCEL_MSG
procedure. The xdrgen decoders are trusted to initialize all
arguments in the argp->xdrgen field, making the early defensive
memset unnecessary. The remaining argp fields are cleared as needed.

The NLM async callback mechanism uses client-side functions, which
continue to take old-school results like struct nlm_res. That means
that for now, NLMPROC4_CANCEL and NLMPROC4_CANCEL_MSG cannot share code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 108 +++++++++++++++++++++++++-------------------
 1 file changed, 61 insertions(+), 47 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index c62e4c420dfa..8199cdd1d37e 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -296,37 +296,6 @@ nlm4svc_proc_lock(struct svc_rqst *rqstp)
 		rpc_drop_reply : rpc_success;
 }
 
-static __be32
-__nlm4svc_proc_cancel(struct svc_rqst *rqstp, struct nlm_res *resp)
-{
-	struct nlm_args *argp = rqstp->rq_argp;
-	struct nlm_host	*host;
-	struct nlm_file	*file;
-
-	dprintk("lockd: CANCEL        called\n");
-
-	resp->cookie = argp->cookie;
-
-	/* Don't accept requests during grace period */
-	if (locks_in_grace(SVC_NET(rqstp))) {
-		resp->status = nlm_lck_denied_grace_period;
-		return rpc_success;
-	}
-
-	/* Obtain client and file */
-	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
-		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
-
-	/* Try to cancel request. */
-	resp->status = nlmsvc_cancel_blocked(SVC_NET(rqstp), file, &argp->lock);
-
-	dprintk("lockd: CANCEL        status %d\n", ntohl(resp->status));
-	nlmsvc_release_lockowner(&argp->lock);
-	nlmsvc_release_host(host);
-	nlm_release_file(file);
-	return rpc_success;
-}
-
 /**
  * nlm4svc_proc_cancel - CANCEL: Cancel an outstanding blocked lock request
  * @rqstp: RPC transaction context
@@ -683,19 +652,64 @@ static __be32 nlm4svc_proc_lock_msg(struct svc_rqst *rqstp)
 				__nlm4svc_proc_lock_msg);
 }
 
+static __be32
+__nlm4svc_proc_cancel_msg(struct svc_rqst *rqstp, struct nlm_res *resp)
+{
+	struct nlm4_cancargs_wrapper *argp = rqstp->rq_argp;
+	unsigned char type = argp->xdrgen.exclusive ? F_WRLCK : F_RDLCK;
+	struct net *net = SVC_NET(rqstp);
+	struct nlm_file	*file = NULL;
+	struct nlm_host	*host = NULL;
+
+	resp->status = nlm_lck_denied_nolocks;
+	if (nlm4_netobj_to_cookie(&resp->cookie, &argp->xdrgen.cookie))
+		goto out;
+
+	resp->status = nlm_lck_denied_grace_period;
+	if (locks_in_grace(net))
+		goto out;
+
+	resp->status = nlm_lck_denied_nolocks;
+	host = nlm4svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, false);
+	if (!host)
+		goto out;
+
+	resp->status = nlm4svc_lookup_file(rqstp, host, &argp->lock,
+					   &file, &argp->xdrgen.alock, type);
+	if (resp->status)
+		goto out;
+
+	resp->status = nlmsvc_cancel_blocked(net, file, &argp->lock);
+	nlmsvc_release_lockowner(&argp->lock);
+
+out:
+	if (file)
+		nlm_release_file(file);
+	nlmsvc_release_host(host);
+	return resp->status == nlm_drop_reply ? rpc_drop_reply : rpc_success;
+}
+
+/**
+ * nlm4svc_proc_cancel_msg - CANCEL_MSG: Cancel an outstanding lock request
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_system_err:		RPC execution failed.
+ *
+ * The response to this request is delivered via the CANCEL_RES procedure.
+ */
 static __be32 nlm4svc_proc_cancel_msg(struct svc_rqst *rqstp)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
-	struct nlm_host	*host;
+	struct nlm4_cancargs_wrapper *argp = rqstp->rq_argp;
+	struct nlm_host *host;
 
-	dprintk("lockd: CANCEL_MSG    called\n");
-
-	host = nlmsvc_lookup_host(rqstp, argp->lock.caller, argp->lock.len);
+	host = nlm4svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, false);
 	if (!host)
 		return rpc_system_err;
 
-	return nlm4svc_callback(rqstp, host, NLMPROC_CANCEL_RES,
-				__nlm4svc_proc_cancel);
+	return nlm4svc_callback(rqstp, host, NLMPROC4_CANCEL_RES,
+				__nlm4svc_proc_cancel_msg);
 }
 
 static __be32 nlm4svc_proc_unlock_msg(struct svc_rqst *rqstp)
@@ -967,15 +981,15 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "LOCK_MSG",
 	},
-	[NLMPROC_CANCEL_MSG] = {
-		.pc_func = nlm4svc_proc_cancel_msg,
-		.pc_decode = nlm4svc_decode_cancargs,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "CANCEL_MSG",
+	[NLMPROC4_CANCEL_MSG] = {
+		.pc_func	= nlm4svc_proc_cancel_msg,
+		.pc_decode	= nlm4_svc_decode_nlm4_cancargs,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm4_cancargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "CANCEL_MSG",
 	},
 	[NLMPROC_UNLOCK_MSG] = {
 		.pc_func = nlm4svc_proc_unlock_msg,
-- 
2.52.0


