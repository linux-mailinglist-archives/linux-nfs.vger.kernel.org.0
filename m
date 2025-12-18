Return-Path: <linux-nfs+bounces-17206-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB46CCD7EC
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4400302280F
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5E82D7DF5;
	Thu, 18 Dec 2025 20:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWXZRcb7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737782D7DC1
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088844; cv=none; b=i857w1WZKRM0o+jdL+KS1+zPQQFpfZT/0s/4MR76jKK8evMPJfGUafahfM5/TgTQaJC/BBsIurlOEnYSJPlo6SumJv3IUGpaXQ6aFJOLCJ6NZDnOvUZhKUGXs38QGU0Wx12MBBglBEzJo541drCmWzk3G8slQG4NCgfpZNPKdxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088844; c=relaxed/simple;
	bh=0as1ZZfpyYPMQVOu7/c0p/Sz7AbH8GDG/T4IPwg/x8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBt+XBk0sryO4B46kMMOHamSXcJwfsbc1i/JViQ4fhrQVM4jfbMseTuemLo3hzl4NoSbJ1VElTbzJczG5mXAGRzL2fTl8+tNhQGeK9asGcl0c1M/t2NlW40CuqdygbeeFb+3vy+khQrBjN0NIO9ixxOOjFPXsOQAuq5Ixj+YKKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWXZRcb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EB6C116D0;
	Thu, 18 Dec 2025 20:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088844;
	bh=0as1ZZfpyYPMQVOu7/c0p/Sz7AbH8GDG/T4IPwg/x8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NWXZRcb7MjAd5wSvnTv6pGO9F2hOqrBc1/9An87bTYbLk/ah4OXiXsgA0yFWxAxHK
	 /6B7PMcnhYiNFkbx+iOkTKDcwGvEiOEf4w07uvTn6aWl046EJocXqkB9AYaxByqNKa
	 nR16unZodyn1PIDSgyg/sq3XOkYhAmpk3Jsj//pBotWnsTeOAxqF25R78p0JPRi6RS
	 imonA3aMuQ/bhYjLMtl+8mw8u+ZYvLrrePy2J/+sMRB3kOywcbpwISBeGohBJENsBj
	 qR1OVimrfsT6Yn6MdHo1zHhgo7h4b9QWe0LIYVzXkPZa/wlU9ThlHdFbaulsfjRDuc
	 2ui+phCdKFLSg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 18/36] lockd: Use xdrgen XDR functions for the NLMv4 LOCK_MSG procedure
Date: Thu, 18 Dec 2025 15:13:28 -0500
Message-ID: <20251218201346.1190928-19-cel@kernel.org>
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

Replace the NLMPROC4_LOCK_MSG entry in the nlm_procedures4 array with
an entry that uses the xdrgen-built XDR functions for that
procedure. Helper functions are introduced which will be used here
and in subsequent patches.

The .pc_argzero field is now set to zero for the NLMv4 LOCK_MSG
procedure. The xdrgen decoders are trusted to initialize all
arguments in the argp->xdrgen field, making the early defensive
memset unnecessary. The remaining argp fields are cleared as needed.

The NLM async callback mechanism uses client-side functions, which
continue to take old-school results like struct nlm_res. That means
that for now, NLMPROC4_TEST and NLMPROC4_LOCK_MSG cannot share code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 106 ++++++++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 47 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index e2509c9e179a..c62e4c420dfa 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -235,37 +235,6 @@ static __be32 nlm4svc_proc_test(struct svc_rqst *rqstp)
 		rpc_drop_reply : rpc_success;
 }
 
-static __be32
-__nlm4svc_proc_lock(struct svc_rqst *rqstp, struct nlm_res *resp)
-{
-	struct nlm_args *argp = rqstp->rq_argp;
-	struct nlm_host	*host;
-	struct nlm_file	*file;
-	__be32 rc = rpc_success;
-
-	dprintk("lockd: LOCK          called\n");
-
-	resp->cookie = argp->cookie;
-
-	/* Obtain client and file */
-	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
-		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
-
-	/* Now try to lock the file */
-	resp->status = nlmsvc_lock(rqstp, file, host, &argp->lock,
-					argp->block, &argp->cookie,
-					argp->reclaim);
-	if (resp->status == nlm_drop_reply)
-		rc = rpc_drop_reply;
-	else
-		dprintk("lockd: LOCK         status %d\n", ntohl(resp->status));
-
-	nlmsvc_release_lockowner(&argp->lock);
-	nlmsvc_release_host(host);
-	nlm_release_file(file);
-	return rc;
-}
-
 /**
  * nlm4svc_proc_lock - LOCK: Establish a monitored lock
  * @rqstp: RPC transaction context
@@ -656,19 +625,62 @@ static __be32 nlm4svc_proc_test_msg(struct svc_rqst *rqstp)
 				__nlm4svc_proc_test_msg);
 }
 
+static __be32
+__nlm4svc_proc_lock_msg(struct svc_rqst *rqstp, struct nlm_res *resp)
+{
+	struct nlm4_lockargs_wrapper *argp = rqstp->rq_argp;
+	unsigned char type = argp->xdrgen.exclusive ? F_WRLCK : F_RDLCK;
+	struct nlm_file	*file = NULL;
+	struct nlm_host	*host = NULL;
+
+	resp->status = nlm_lck_denied_nolocks;
+	if (nlm4_netobj_to_cookie(&resp->cookie, &argp->xdrgen.cookie))
+		goto out;
+
+	host = nlm4svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, true);
+	if (!host)
+		goto out;
+
+	resp->status = nlm4svc_lookup_file(rqstp, host, &argp->lock,
+					   &file, &argp->xdrgen.alock, type);
+	if (resp->status)
+		goto out;
+
+	if (nlm4_netobj_to_cookie(&argp->cookie, &argp->xdrgen.cookie))
+		goto out;
+	resp->status = nlmsvc_lock(rqstp, file, host, &argp->lock,
+				   argp->xdrgen.block, &argp->cookie,
+				   argp->xdrgen.reclaim);
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
+ * nlm4svc_proc_lock_msg - LOCK_MSG: Establish a monitored lock
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_system_err:		RPC execution failed.
+ *
+ * The response to this request is delivered via the LOCK_RES procedure.
+ */
 static __be32 nlm4svc_proc_lock_msg(struct svc_rqst *rqstp)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
-	struct nlm_host	*host;
+	struct nlm4_lockargs_wrapper *argp = rqstp->rq_argp;
+	struct nlm_host *host;
 
-	dprintk("lockd: LOCK_MSG      called\n");
-
-	host = nlmsvc_lookup_host(rqstp, argp->lock.caller, argp->lock.len);
+	host = nlm4svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, true);
 	if (!host)
 		return rpc_system_err;
 
-	return nlm4svc_callback(rqstp, host, NLMPROC_LOCK_RES,
-				__nlm4svc_proc_lock);
+	return nlm4svc_callback(rqstp, host, NLMPROC4_LOCK_RES,
+				__nlm4svc_proc_lock_msg);
 }
 
 static __be32 nlm4svc_proc_cancel_msg(struct svc_rqst *rqstp)
@@ -945,15 +957,15 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "TEST_MSG",
 	},
-	[NLMPROC_LOCK_MSG] = {
-		.pc_func = nlm4svc_proc_lock_msg,
-		.pc_decode = nlm4svc_decode_lockargs,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "LOCK_MSG",
+	[NLMPROC4_LOCK_MSG] = {
+		.pc_func	= nlm4svc_proc_lock_msg,
+		.pc_decode	= nlm4_svc_decode_nlm4_lockargs,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm4_lockargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "LOCK_MSG",
 	},
 	[NLMPROC_CANCEL_MSG] = {
 		.pc_func = nlm4svc_proc_cancel_msg,
-- 
2.52.0


