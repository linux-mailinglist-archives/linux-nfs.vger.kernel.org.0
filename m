Return-Path: <linux-nfs+bounces-17208-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C68ECCD7F5
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27442303016D
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64AA2C08C0;
	Thu, 18 Dec 2025 20:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxMrjd+j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6562D8370
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088845; cv=none; b=h/mFDRMAVQY+jKqRvj/fUCL0x6c8NffoZKJYJPjMZJuRSSXxq1VcMGWncZ90U85lYuxsOa/26n64dvlwMSyjI6Q7+b/NkkU3bXTe4bB3zllh5l0E1NnTTOc5RXEtlYkh7R6w/4wcD9JojXc2+caCHEjyCntN0xQyLnf3kbT03Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088845; c=relaxed/simple;
	bh=WcelyARo6yYn++ysSbgHXAXnfHKBRJFap/3MCdyhgjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTe0X4SOHZnXGuL/BbaiylpkD1N3Lfrt7rAuX1qHTeE4HsFnXdcd2XeEavMFp40w1kC1WcaGE7MIq5TZce81T3eq2hdVwNtsWu8Qf40nIUR44HOvH8l76qH5dVAHTvShT4nM5stGGMecwXVorr5ZroLi3DO36cgSUN74ogACz8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxMrjd+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC3FC16AAE;
	Thu, 18 Dec 2025 20:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088845;
	bh=WcelyARo6yYn++ysSbgHXAXnfHKBRJFap/3MCdyhgjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mxMrjd+jX5Gy9BIbJZ7iG2Eh1tQCmv7aZbv23cb7Z4/FzrZSFB9du/HQWgsqbAz+O
	 hDkLy6U5aGQHyWtq1VLt9jABEnwiPIu5edWLUxW/D5tiu4vHniL2zoBlc648OPH6k/
	 gyrBuYXdaTDLeH6nQ/5elf5LEIa0Arwx38hNgOD7EG7z3Ipngk3ACw+bE10ZkTgkIK
	 GgrVa3HN/xfBDcUIhVnqTNY8OJ+Lc41WXW7kWfoqPm3Ngoex2BhJkGMgO9Kl7tu/S2
	 ZTXiIkH0Xl27Lj7OUdNd2wQK3WDLYUUxNKcDX0dyy2bMGIP4fwL2i3CMkSbfod0bCH
	 bGtrhhV4NEuhQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 20/36] lockd: Use xdrgen XDR functions for the NLMv4 UNLOCK_MSG procedure
Date: Thu, 18 Dec 2025 15:13:30 -0500
Message-ID: <20251218201346.1190928-21-cel@kernel.org>
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

Replace the NLMPROC4_UNLOCK_MSG entry in the nlm_procedures4 array with
an entry that uses the xdrgen-built XDR functions for that
procedure. Helper functions are introduced which will be used here
and in subsequent patches.

The .pc_argzero field is now set to zero for the NLMv4 UNLOCK_MSG
procedure. The xdrgen decoders are trusted to initialize all
arguments in the argp->xdrgen field, making the early defensive
memset unnecessary. The remaining argp fields are cleared as needed.

The NLM async callback mechanism uses client-side functions, which
continue to take old-school results like struct nlm_res. That means
that for now, NLMPROC4_UNLOCK and NLMPROC4_UNLOCK_MSG cannot share
code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 110 ++++++++++++++++++++++++--------------------
 1 file changed, 60 insertions(+), 50 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 8199cdd1d37e..c53b9ffdc2f0 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -349,40 +349,6 @@ nlm4svc_proc_cancel(struct svc_rqst *rqstp)
 		rpc_drop_reply : rpc_success;
 }
 
-/*
- * UNLOCK: release a lock
- */
-static __be32
-__nlm4svc_proc_unlock(struct svc_rqst *rqstp, struct nlm_res *resp)
-{
-	struct nlm_args *argp = rqstp->rq_argp;
-	struct nlm_host	*host;
-	struct nlm_file	*file;
-
-	dprintk("lockd: UNLOCK        called\n");
-
-	resp->cookie = argp->cookie;
-
-	/* Don't accept new lock requests during grace period */
-	if (locks_in_grace(SVC_NET(rqstp))) {
-		resp->status = nlm_lck_denied_grace_period;
-		return rpc_success;
-	}
-
-	/* Obtain client and file */
-	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
-		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
-
-	/* Now try to remove the lock */
-	resp->status = nlmsvc_unlock(SVC_NET(rqstp), file, &argp->lock);
-
-	dprintk("lockd: UNLOCK        status %d\n", ntohl(resp->status));
-	nlmsvc_release_lockowner(&argp->lock);
-	nlmsvc_release_host(host);
-	nlm_release_file(file);
-	return rpc_success;
-}
-
 /**
  * nlm4svc_proc_unlock - UNLOCK: Remove a lock
  * @rqstp: RPC transaction context
@@ -712,19 +678,63 @@ static __be32 nlm4svc_proc_cancel_msg(struct svc_rqst *rqstp)
 				__nlm4svc_proc_cancel_msg);
 }
 
+static __be32
+__nlm4svc_proc_unlock_msg(struct svc_rqst *rqstp, struct nlm_res *resp)
+{
+	struct nlm4_unlockargs_wrapper *argp = rqstp->rq_argp;
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
+					   &file, &argp->xdrgen.alock, F_UNLCK);
+	if (resp->status)
+		goto out;
+
+	resp->status = nlmsvc_unlock(net, file, &argp->lock);
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
+ * nlm4svc_proc_unlock_msg - UNLOCK_MSG: Remove an existing lock
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_system_err:		RPC execution failed.
+ *
+ * The response to this request is delivered via the UNLOCK_RES procedure.
+ */
 static __be32 nlm4svc_proc_unlock_msg(struct svc_rqst *rqstp)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
-	struct nlm_host	*host;
+	struct nlm4_unlockargs_wrapper *argp = rqstp->rq_argp;
+	struct nlm_host *host;
 
-	dprintk("lockd: UNLOCK_MSG    called\n");
-
-	host = nlmsvc_lookup_host(rqstp, argp->lock.caller, argp->lock.len);
+	host = nlm4svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, false);
 	if (!host)
 		return rpc_system_err;
 
-	return nlm4svc_callback(rqstp, host, NLMPROC_UNLOCK_RES,
-				__nlm4svc_proc_unlock);
+	return nlm4svc_callback(rqstp, host, NLMPROC4_UNLOCK_RES,
+				__nlm4svc_proc_unlock_msg);
 }
 
 static __be32 nlm4svc_proc_granted_msg(struct svc_rqst *rqstp)
@@ -991,15 +1001,15 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "CANCEL_MSG",
 	},
-	[NLMPROC_UNLOCK_MSG] = {
-		.pc_func = nlm4svc_proc_unlock_msg,
-		.pc_decode = nlm4svc_decode_unlockargs,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "UNLOCK_MSG",
+	[NLMPROC4_UNLOCK_MSG] = {
+		.pc_func	= nlm4svc_proc_unlock_msg,
+		.pc_decode	= nlm4_svc_decode_nlm4_unlockargs,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm4_unlockargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "UNLOCK_MSG",
 	},
 	[NLMPROC_GRANTED_MSG] = {
 		.pc_func = nlm4svc_proc_granted_msg,
-- 
2.52.0


