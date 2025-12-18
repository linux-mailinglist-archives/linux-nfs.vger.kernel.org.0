Return-Path: <linux-nfs+bounces-17205-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E99CCD7E9
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB1A33022D17
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836AE2D8370;
	Thu, 18 Dec 2025 20:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyuQkaXK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5250D2C08C0
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088843; cv=none; b=m0tNOYH75C+cbfZp/VYOAWqgwJJtNMt8+/8JhlSrDJ+NnMTuYynVVVGrJKct0LILo8l77d5K/YjsPcvXqm338q5ImVAj7Xv0wWEsFKRenaW3eUgndRGF8NScgw3PvFarvAlVqK6ZaN7t6T8bxV8oPt5UJbPD/44rEaUnbiFFKh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088843; c=relaxed/simple;
	bh=JblDuyR7mN/7ltvm/+vYpF3XFAsXlBc7Pge5/tX18as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DI0kP5j5IY0y9sY+75nVCy7zpxdaRREr0Pk38p0nR65LftXlYEoGTJHMWmWiQRdut8UsDD1+6iss96ZZWJtedRDRGcNB2XJfiCfMVP0M5l/Bf4/XS+UL7NlGSFJqkXJdH2wlfBAAOi85/RxjpV+4eVJLHpFwhwugoNBY7gmgnCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyuQkaXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C152C113D0;
	Thu, 18 Dec 2025 20:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088843;
	bh=JblDuyR7mN/7ltvm/+vYpF3XFAsXlBc7Pge5/tX18as=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JyuQkaXKJMfMnBwu0rtjQT+EYfiST1oWv2t6YUZ8c3rCnrulPG83xbwSzCVk8CvyQ
	 ZCzKoa3eKU2+CDjXmv356gj+oofQl0dnaCkRUIwYBmXLg+J9mUgDCNYjhdRuXZLW+e
	 c62pY25RVFPrEfyzxG1eA8/t90+BdxeA9XUsUg4wHAv7FhgTvrWS6+K8HU41aJM5WG
	 NrD9XRvJFkpUSdllcdpZGdnhkWn7D/dc7XvQOb7YT0rIoMn3dvcXSuW9U5Jyf8lff3
	 87RXC0H9MIXzOfu47n0G47qFOhmCjMWt6oWbEWyOn08WbDD82Xf5gAf3ZrDZoZR1kn
	 bwYIJz519NhSg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 17/36] lockd: Use xdrgen XDR functions for the NLMv4 TEST_MSG procedure
Date: Thu, 18 Dec 2025 15:13:27 -0500
Message-ID: <20251218201346.1190928-18-cel@kernel.org>
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

Replace the NLMPROC4_TEST_MSG entry in the nlm_procedures4 array with
an entry that uses the xdrgen-built XDR functions for that
procedure. Helper functions are introduced which will be used here
and in subsequent patches.

The .pc_argzero field is now set to zero for the NLMv4 TEST_MSG
procedure. The xdrgen decoders are trusted to initialize all
arguments in the argp->xdrgen field, making the early defensive
memset unnecessary. The remaining argp fields are cleared as needed.

The NLM async callback mechanism uses client-side functions, which
continue to take old-school results like struct nlm_res. That means
that for now, NLMPROC4_TEST and NLMPROC4_TEST_MSG cannot share code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 106 ++++++++++++++++++++++++--------------------
 1 file changed, 58 insertions(+), 48 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 0e6ab31733c6..e2509c9e179a 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -166,38 +166,6 @@ nlm4svc_proc_null(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
-/*
- * TEST: Check for conflicting lock
- */
-static __be32
-__nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
-{
-	struct nlm_args *argp = rqstp->rq_argp;
-	struct nlm_host	*host;
-	struct nlm_file	*file;
-	__be32 rc = rpc_success;
-
-	dprintk("lockd: TEST4        called\n");
-	resp->cookie = argp->cookie;
-
-	/* Obtain client and file */
-	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
-		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
-
-	/* Now check for conflicting locks */
-	resp->status = nlmsvc_testlock(rqstp, file, host, &argp->lock,
-				       &resp->lock);
-	if (resp->status == nlm_drop_reply)
-		rc = rpc_drop_reply;
-	else
-		dprintk("lockd: TEST4        status %d\n", ntohl(resp->status));
-
-	nlmsvc_release_lockowner(&argp->lock);
-	nlmsvc_release_host(host);
-	nlm_release_file(file);
-	return rc;
-}
-
 /**
  * nlm4svc_proc_test - TEST: Check for conflicting lock
  * @rqstp: RPC transaction context
@@ -631,19 +599,61 @@ nlm4svc_callback(struct svc_rqst *rqstp, struct nlm_host *host, u32 proc,
 	return rpc_success;
 }
 
+static __be32
+__nlm4svc_proc_test_msg(struct svc_rqst *rqstp, struct nlm_res *resp)
+{
+	struct nlm4_testargs_wrapper *argp = rqstp->rq_argp;
+	unsigned char type = argp->xdrgen.exclusive ? F_WRLCK : F_RDLCK;
+	struct nlm_lockowner *owner;
+	struct nlm_file	*file = NULL;
+	struct nlm_host	*host = NULL;
+
+	resp->status = nlm_lck_denied_nolocks;
+	if (nlm4_netobj_to_cookie(&resp->cookie, &argp->xdrgen.cookie))
+		goto out;
+
+	host = nlm4svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, false);
+	if (!host)
+		goto out;
+
+	resp->status = nlm4svc_lookup_file(rqstp, host, &argp->lock,
+					   &file, &argp->xdrgen.alock, type);
+	if (resp->status)
+		goto out;
+
+	owner = argp->lock.fl.c.flc_owner;
+	resp->status = nlmsvc_testlock(rqstp, file, host, &argp->lock,
+				       &resp->lock);
+	nlmsvc_put_lockowner(owner);
+
+out:
+	if (file)
+		nlm_release_file(file);
+	nlmsvc_release_host(host);
+	return resp->status == nlm_drop_reply ? rpc_drop_reply : rpc_success;
+}
+
+/**
+ * nlm4svc_proc_test_msg - TEST_MSG: Check for conflicting lock
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_system_err:		RPC execution failed.
+ *
+ * The response to this request is delivered via the TEST_RES procedure.
+ */
 static __be32 nlm4svc_proc_test_msg(struct svc_rqst *rqstp)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
-	struct nlm_host	*host;
+	struct nlm4_testargs_wrapper *argp = rqstp->rq_argp;
+	struct nlm_host *host;
 
-	dprintk("lockd: TEST_MSG      called\n");
-
-	host = nlmsvc_lookup_host(rqstp, argp->lock.caller, argp->lock.len);
+	host = nlm4svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, false);
 	if (!host)
 		return rpc_system_err;
 
-	return nlm4svc_callback(rqstp, host, NLMPROC_TEST_RES,
-				__nlm4svc_proc_test);
+	return nlm4svc_callback(rqstp, host, NLMPROC4_TEST_RES,
+				__nlm4svc_proc_test_msg);
 }
 
 static __be32 nlm4svc_proc_lock_msg(struct svc_rqst *rqstp)
@@ -925,15 +935,15 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_xdrressize	= NLM4_nlm4_res_sz,
 		.pc_name	= "GRANTED",
 	},
-	[NLMPROC_TEST_MSG] = {
-		.pc_func = nlm4svc_proc_test_msg,
-		.pc_decode = nlm4svc_decode_testargs,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "TEST_MSG",
+	[NLMPROC4_TEST_MSG] = {
+		.pc_func	= nlm4svc_proc_test_msg,
+		.pc_decode	= nlm4_svc_decode_nlm4_testargs,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm4_testargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "TEST_MSG",
 	},
 	[NLMPROC_LOCK_MSG] = {
 		.pc_func = nlm4svc_proc_lock_msg,
-- 
2.52.0


