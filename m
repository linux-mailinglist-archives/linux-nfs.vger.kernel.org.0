Return-Path: <linux-nfs+bounces-17201-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D44CCD7D4
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1A53302A1CB
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EB2263C8C;
	Thu, 18 Dec 2025 20:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwItzfv3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF362D3A6A
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088840; cv=none; b=nIo+BfWAKTPaIHkf4bOHW0alVv24JkFD/4uAfuIlhOZHqK3d/IKvC7c5CJHLkEh3HKj3GQXmHiI8eulnwHG8uDX6+gSyOTyHFVhLBaHpPQ7wtbzoDxviLpC8BWr8gvXC09GM1v3zSF5tmMxwejI1M3xT09d58DN+eBDpvhWE72g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088840; c=relaxed/simple;
	bh=xARH+3RMqi/fQw+GStFlQWbHuCuEKN1V8XaGCZgu9Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZuZzqwlaq4cIg49h+8QaOhVIEfhjslVOq6czV4VgbPgZLoME8MkZbWl3ZSib+4DeH8DoiT4i64e5yd1H52IJFys9TxXzvQ8LL6DaMkmXOdvm9eJSJRUvDH7Ws7AgABvko2hliSqZ1IqC0SE3wS6Er2JUQEIgWW13Yj4CWSz+F7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwItzfv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77970C16AAE;
	Thu, 18 Dec 2025 20:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088840;
	bh=xARH+3RMqi/fQw+GStFlQWbHuCuEKN1V8XaGCZgu9Lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EwItzfv36bDsMSo43Thc3EwFyDokmioC4mC7LUvqIOMmWFVTisJF0nZauIWRf2c8u
	 5EbpK5KvZSjpvCz61RCebMY8L7pON40ZmdxW2+WYQedcsgzdDtebcA0f2L5thT/hnM
	 wKI38nL8TypMgxRER1L3TsvQ5WzZU2POJLh8HdR1oqN+qvkvlNeAa37JGB8D72T/yK
	 6HbyUP0sPGgvm8XH7uFTKePuSOn/MUTMgrARtEjJ8SxxYb9uCKe5RD2mmUlieucgLv
	 WVY/wCMJpq8nTm31XtFX05z7WEzuPbdeUabxlEWn2lFt1ZSX/Rg4nJbqdFtJp0f+NF
	 FFqG8ptlZKIAA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 13/36] lockd: Use xdrgen XDR functions for the NLMv4 CANCEL procedure
Date: Thu, 18 Dec 2025 15:13:23 -0500
Message-ID: <20251218201346.1190928-14-cel@kernel.org>
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

Replace the NLMPROC4_CANCEL entry in the nlm_procedures4 array with
an entry that uses the xdrgen-built XDR functions for that
procedure. Helper functions are introduced which will be used here
and in subsequent patches.

The .pc_argzero field is now set to zero for the NLMv4 CANCEL
procedure. The xdrgen decoders are trusted to initialize all
arguments in the argp->xdrgen field, making the early defensive
memset unnecessary. The remaining argp fields are cleared as needed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 67 ++++++++++++++++++++++++++++++++++++++-------
 fs/lockd/xdr4.h     |  7 +++++
 2 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index e1d100014567..66d300626f66 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -390,10 +390,57 @@ __nlm4svc_proc_cancel(struct svc_rqst *rqstp, struct nlm_res *resp)
 	return rpc_success;
 }
 
+/**
+ * nlm4svc_proc_cancel - CANCEL: Cancel an outstanding blocked lock request
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully
+ *   %rpc_drop_reply:		Do not send an RPC reply
+ *
+ * Permissible procedure status codes:
+ *   %NLM4_LCK_GRANTED:		The requested lock was canceled.
+ *   %NLM4_LCK_DENIED:		There was no lock to cancel.
+ *   %NLM4_DENIED_GRACE_PERIOD:	The server has recently restarted and is
+ *				re-establishing existing locks, and is not
+ *				yet ready to accept normal service requests.
+ */
 static __be32
 nlm4svc_proc_cancel(struct svc_rqst *rqstp)
 {
-	return __nlm4svc_proc_cancel(rqstp, rqstp->rq_resp);
+	struct nlm4_cancargs_wrapper *argp = rqstp->rq_argp;
+	unsigned char type = argp->xdrgen.exclusive ? F_WRLCK : F_RDLCK;
+	struct nlm4_res_wrapper *resp = rqstp->rq_resp;
+	struct net *net = SVC_NET(rqstp);
+	struct nlm_host	*host = NULL;
+	struct nlm_file	*file = NULL;
+
+	resp->xdrgen.cookie = argp->xdrgen.cookie;
+
+	resp->xdrgen.stat.stat = nlm_lck_denied_grace_period;
+	if (locks_in_grace(net))
+		goto out;
+
+	resp->xdrgen.stat.stat = nlm_lck_denied_nolocks;
+	host = nlm4svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, false);
+	if (!host)
+		goto out;
+
+	resp->xdrgen.stat.stat = nlm4svc_lookup_file(rqstp, host, &argp->lock,
+						     &file, &argp->xdrgen.alock,
+						     type);
+	if (resp->xdrgen.stat.stat)
+		goto out;
+
+	resp->xdrgen.stat.stat = nlmsvc_cancel_blocked(net, file, &argp->lock);
+	nlmsvc_release_lockowner(&argp->lock);
+
+out:
+	if (file)
+		nlm_release_file(file);
+	nlmsvc_release_host(host);
+	return resp->xdrgen.stat.stat == nlm_drop_reply ?
+		rpc_drop_reply : rpc_success;
 }
 
 /*
@@ -731,15 +778,15 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_xdrressize	= NLM4_nlm4_res_sz,
 		.pc_name	= "LOCK",
 	},
-	[NLMPROC_CANCEL] = {
-		.pc_func = nlm4svc_proc_cancel,
-		.pc_decode = nlm4svc_decode_cancargs,
-		.pc_encode = nlm4svc_encode_res,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
-		.pc_ressize = sizeof(struct nlm_res),
-		.pc_xdrressize = Ck+St,
-		.pc_name = "CANCEL",
+	[NLMPROC4_CANCEL] = {
+		.pc_func	= nlm4svc_proc_cancel,
+		.pc_decode	= nlm4_svc_decode_nlm4_cancargs,
+		.pc_encode	= nlm4_svc_encode_nlm4_res,
+		.pc_argsize	= sizeof(struct nlm4_cancargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= sizeof(struct nlm4_res_wrapper),
+		.pc_xdrressize	= NLM4_nlm4_res_sz,
+		.pc_name	= "CANCEL",
 	},
 	[NLMPROC_UNLOCK] = {
 		.pc_func = nlm4svc_proc_unlock,
diff --git a/fs/lockd/xdr4.h b/fs/lockd/xdr4.h
index 2bd22bad9cb0..8fef6b53eee3 100644
--- a/fs/lockd/xdr4.h
+++ b/fs/lockd/xdr4.h
@@ -32,6 +32,13 @@ struct nlm4_lockargs_wrapper {
 
 static_assert(offsetof(struct nlm4_lockargs_wrapper, xdrgen) == 0);
 
+struct nlm4_cancargs_wrapper {
+	struct nlm4_cancargs		xdrgen;
+	struct nlm_lock			lock;
+};
+
+static_assert(offsetof(struct nlm4_cancargs_wrapper, xdrgen) == 0);
+
 struct nlm4_testres_wrapper {
 	struct nlm4_testres		xdrgen;
 	struct nlm_lock			lock;
-- 
2.52.0


