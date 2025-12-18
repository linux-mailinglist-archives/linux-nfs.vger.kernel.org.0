Return-Path: <linux-nfs+bounces-17209-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC25CCD7F8
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F8943029F47
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E372D8DD0;
	Thu, 18 Dec 2025 20:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWhvbnHF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBAF2D8370
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088846; cv=none; b=n403jObRsLJf+VsYM5uKEQ8EbMZNLE+0I1IzEkOZPaEShKV974zdo9BuE+GloMuqO5zwTkgagOJJAKQsNuIUtGcLXhcoYrY5k5Qtji8hOyO37GLuI6Do9vfq+hXG3y7Mdvnf95qbyNvJvKlJrYB3v7w16/BrL8Wf3fjFwhzGa/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088846; c=relaxed/simple;
	bh=fFbz5jrDjRPinvFrLhS1JaggAnIVQ6A1ZxBIzY67nmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6qZ6I6v4Wjc/6HbLUVW2njOXLD54n+ZBFu1djvmXQRJajOjdpqXOqFqj94i0Ik0KtIxTRHwuENX/584POgcjb1e+T0oC7v913pU6jb08tUT80NK74Os6mJdQK3I3cIK+tGaJUzBRUzanNVDODxbwbkd8AHovO77xU53dXGwKzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWhvbnHF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF4EC113D0;
	Thu, 18 Dec 2025 20:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088846;
	bh=fFbz5jrDjRPinvFrLhS1JaggAnIVQ6A1ZxBIzY67nmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mWhvbnHFY8Cli7EqZCUQwDL+tDiUdR1wC9FYeRNmDwfyVdKs1RrTw3lz502R/WjVv
	 zhNPF8XZB2rAhAkXmdNi6S9SX5v1rM5Sq3IkT2xWRY4YtnNHI5/+wFyVwfbJQe1UTP
	 0b5rRohZ3ijpibYvf9l9d2NofDR64TEHZURAcetERc7qM9/G8iST8O5Yu4WJoFyYnC
	 M6lFhcinDaeV6Ln7hJ5MqhqxG/wkDmFsJMmq+VbQAeywHhRhq+++BYRHUQiNKic1kO
	 2E/TGdUYTWyYjNbZxgv3yo9v0PioDjuAGconeSTVkGZ2ORlI0OjEd1iw5SQ9hKcWFb
	 40Cydb1Y5+qXg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 21/36] lockd: Use xdrgen XDR functions for the NLMv4 GRANTED_MSG procedure
Date: Thu, 18 Dec 2025 15:13:31 -0500
Message-ID: <20251218201346.1190928-22-cel@kernel.org>
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

Replace the NLMPROC4_GRANTED_MSG entry in the nlm_procedures4 array
with an entry that uses the xdrgen-built XDR functions for that
procedure. Helper functions are introduced which will be used here
and in subsequent patches.

The .pc_argzero field is now set to zero for the NLMv4 GRANTED_MSG
procedure. The xdrgen decoders are trusted to initialize all
arguments in the argp->xdrgen field, making the early defensive
memset unnecessary. The remaining argp fields are cleared as needed.

The NLM async callback mechanism uses client-side functions, which
continue to take old-school results like struct nlm_res. That means
that for now, NLMPROC4_GRANTED and NLMPROC4_GRANTED_MSG cannot share
code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 82 +++++++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 33 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index c53b9ffdc2f0..f037281f93cc 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -400,23 +400,6 @@ nlm4svc_proc_unlock(struct svc_rqst *rqstp)
 		rpc_drop_reply : rpc_success;
 }
 
-/*
- * GRANTED: A server calls us to tell that a process' lock request
- * was granted
- */
-static __be32
-__nlm4svc_proc_granted(struct svc_rqst *rqstp, struct nlm_res *resp)
-{
-	struct nlm_args *argp = rqstp->rq_argp;
-
-	resp->cookie = argp->cookie;
-
-	dprintk("lockd: GRANTED       called\n");
-	resp->status = nlmclnt_grant(svc_addr(rqstp), &argp->lock);
-	dprintk("lockd: GRANTED       status %d\n", ntohl(resp->status));
-	return rpc_success;
-}
-
 /**
  * nlm4svc_proc_granted - GRANTED: Blocked lock has been granted
  * @rqstp: RPC transaction context
@@ -737,19 +720,52 @@ static __be32 nlm4svc_proc_unlock_msg(struct svc_rqst *rqstp)
 				__nlm4svc_proc_unlock_msg);
 }
 
+static __be32
+__nlm4svc_proc_granted_msg(struct svc_rqst *rqstp, struct nlm_res *resp)
+{
+	struct nlm4_testargs_wrapper *argp = rqstp->rq_argp;
+	struct nlm4_lock *alock = &argp->xdrgen.alock;
+	struct nlm_lock *lock = &argp->lock;
+
+	resp->status = nlm_lck_denied;
+	if (nlm4_netobj_to_cookie(&resp->cookie, &argp->xdrgen.cookie))
+		goto out;
+
+	if (alock->fh.len > NFS_MAXFHSIZE)
+		goto out;
+
+	lock->fh.size = alock->fh.len;
+	memcpy(lock->fh.data, alock->fh.data, alock->fh.len);
+	lock->svid = alock->svid;
+	nlm4svc_set_file_lock_range(&lock->fl, alock->l_offset, alock->l_len);
+
+	resp->status = nlmclnt_grant(svc_addr(rqstp), lock);
+
+out:
+	return rpc_success;
+}
+
+/**
+ * nlm4svc_proc_granted_msg - GRANTED_MSG: Blocked lock has been granted
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_system_err:		RPC execution failed.
+ *
+ * The response to this request is delivered via the GRANTED_RES procedure.
+ */
 static __be32 nlm4svc_proc_granted_msg(struct svc_rqst *rqstp)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
-	struct nlm_host	*host;
+	struct nlm4_testargs_wrapper *argp = rqstp->rq_argp;
+	struct nlm_host *host;
 
-	dprintk("lockd: GRANTED_MSG   called\n");
-
-	host = nlmsvc_lookup_host(rqstp, argp->lock.caller, argp->lock.len);
+	host = nlm4svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, false);
 	if (!host)
 		return rpc_system_err;
 
-	return nlm4svc_callback(rqstp, host, NLMPROC_GRANTED_RES,
-				__nlm4svc_proc_granted);
+	return nlm4svc_callback(rqstp, host, NLMPROC4_GRANTED_RES,
+				__nlm4svc_proc_granted_msg);
 }
 
 /*
@@ -1011,15 +1027,15 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "UNLOCK_MSG",
 	},
-	[NLMPROC_GRANTED_MSG] = {
-		.pc_func = nlm4svc_proc_granted_msg,
-		.pc_decode = nlm4svc_decode_testargs,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "GRANTED_MSG",
+	[NLMPROC4_GRANTED_MSG] = {
+		.pc_func	= nlm4svc_proc_granted_msg,
+		.pc_decode	= nlm4_svc_decode_nlm4_testargs,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm4_testargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "GRANTED_MSG",
 	},
 	[NLMPROC_TEST_RES] = {
 		.pc_func = nlm4svc_proc_null,
-- 
2.52.0


