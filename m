Return-Path: <linux-nfs+bounces-17200-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F27CCD7CE
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 247BC3028C60
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAD52C3248;
	Thu, 18 Dec 2025 20:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+kFVrVa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69A02D7DF5
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088839; cv=none; b=TKS6d7Dhc/kPatTViQEWyj10NGL8gGItnbhc+wtAH4vh49vVR0pzYRI6kdWs3YldaO8Rw4ceRmk5/EsgIx7pTR3BLVwl6ux2KEemE0mbqX/9oo0U6Co3+ZDT93e6XqV4hwFFfaJunIOowpPZwDOyOFCRxOFUCw9R7jZcnsY1lsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088839; c=relaxed/simple;
	bh=8HsT3Y770G72CuBNOuknlZi/4esciEBFMoFSfR1ZLHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqZfV6GWl3GpsTcSWcSU+00zQGgBbzTliHybxxMvwdzYU6Jm6AoqN2STo/gLVGhMkandx61FBk3uS6NG/vDIZgLAOQaLEirzUgAEX0GkP2eF/pU89eLpfhuWeWa2Y7CBMLkwdFd5PzfhgauzewzeDvq4T8vzVENZcRnxPMUSfHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+kFVrVa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6D3C116D0;
	Thu, 18 Dec 2025 20:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088839;
	bh=8HsT3Y770G72CuBNOuknlZi/4esciEBFMoFSfR1ZLHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U+kFVrVaN+vbdlcQvvM49dy4FUBPheXknajZZm3VmAtThe+4DrmFrCj5WHpusAJce
	 SlBrGw0oFue7nVnXeYkNLU1+0QzY0I4eEP2tnCU6FO3NCfaY/dHYEzqEKUZ8IuW5HE
	 P0+8x608yY/JgTt2AEg7fiU8dP4MfTgPK4AY/VXA3LMmqyufboDjZGOuTk/GkBcBWN
	 Wu1tDU3UbBR2QRPWh9wuq2JuP+qX+RhiSxmYxAudJax0p7YISroUO3hMMW5JKEcVUx
	 VD71EyF4GPDqEWfHS+Jbhv9BsUxGGTVEN4T5hW25UI4yBzl0CkqKTjQQIKJ6m8x2QG
	 a54T530Xx44rQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 12/36] lockd: Use xdrgen XDR functions for the NLMv4 LOCK procedure
Date: Thu, 18 Dec 2025 15:13:22 -0500
Message-ID: <20251218201346.1190928-13-cel@kernel.org>
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

Replace the NLMPROC4_LOCK entry in the nlm_procedures4 array with
an entry that uses the xdrgen-built XDR functions for that
procedure. Helper functions are introduced which will be used here
and in subsequent patches.

The .pc_argzero field is now set to zero for the NLMv4 LOCK
procedure. The xdrgen decoders are trusted to initialize all
arguments in the argp->xdrgen field, making the early defensive
memset unnecessary. The remaining argp fields are cleared as needed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 85 +++++++++++++++++++++++++++++++++++++++------
 fs/lockd/xdr4.h     | 14 ++++++++
 2 files changed, 89 insertions(+), 10 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 59001c1b21c6..e1d100014567 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -19,6 +19,16 @@
 
 #define NLMDBG_FACILITY		NLMDBG_CLIENT
 
+static __be32
+nlm4_netobj_to_cookie(struct nlm_cookie *cookie, netobj *object)
+{
+	if (object->len > NLM_MAXCOOKIELEN)
+		return nlm_lck_denied_nolocks;
+	cookie->len = object->len;
+	memcpy(cookie->data, object->data, object->len);
+	return nlm_granted;
+}
+
 static struct nlm_host *
 nlm4svc_lookup_host(struct svc_rqst *rqstp, string caller, bool monitored)
 {
@@ -288,10 +298,65 @@ __nlm4svc_proc_lock(struct svc_rqst *rqstp, struct nlm_res *resp)
 	return rc;
 }
 
+/**
+ * nlm4svc_proc_lock - LOCK: Establish a monitored lock
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_drop_reply:		Do not send an RPC reply.
+ *
+ * Permissible procedure status codes:
+ *   %NLM4_GRANTED:		The requested lock was granted.
+ *   %NLM4_DENIED:		The requested lock conflicted with existing
+ *				lock reservations for the file.
+ *   %NLM4_DENIED_NOLOCKS:	The server could not allocate the resources
+ *				needed to process the request.
+ *   %NLM4_BLOCKED:		The blocking request cannot be granted
+ *				immediately. The server will send an
+ *				NLM_GRANTED procedure to the client when the
+ *				lock can be granted.
+ *   %NLM4_DENIED_GRACE_PERIOD:	The server has recently restarted and is
+ *				re-establishing existing locks, and is not
+ *				yet ready to accept normal service requests.
+ */
 static __be32
 nlm4svc_proc_lock(struct svc_rqst *rqstp)
 {
-	return __nlm4svc_proc_lock(rqstp, rqstp->rq_resp);
+	struct nlm4_lockargs_wrapper *argp = rqstp->rq_argp;
+	unsigned char type = argp->xdrgen.exclusive ? F_WRLCK : F_RDLCK;
+	struct nlm4_res_wrapper *resp = rqstp->rq_resp;
+	struct nlm_file	*file = NULL;
+	struct nlm_host	*host;
+
+	resp->xdrgen.cookie = argp->xdrgen.cookie;
+
+	resp->xdrgen.stat.stat = nlm_lck_denied_nolocks;
+	host = nlm4svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, true);
+	if (!host)
+		goto out;
+
+	resp->xdrgen.stat.stat = nlm4svc_lookup_file(rqstp, host, &argp->lock,
+						     &file, &argp->xdrgen.alock,
+						     type);
+	if (resp->xdrgen.stat.stat)
+		goto out;
+
+	resp->xdrgen.stat.stat = nlm4_netobj_to_cookie(&argp->cookie,
+						       &argp->xdrgen.cookie);
+	if (resp->xdrgen.stat.stat)
+		goto out;
+	resp->xdrgen.stat.stat = nlmsvc_lock(rqstp, file, host, &argp->lock,
+					     argp->xdrgen.block, &argp->cookie,
+					     argp->xdrgen.reclaim);
+	nlmsvc_release_lockowner(&argp->lock);
+
+out:
+	if (file)
+		nlm_release_file(file);
+	nlmsvc_release_host(host);
+	return resp->xdrgen.stat.stat == nlm_drop_reply ?
+		rpc_drop_reply : rpc_success;
 }
 
 static __be32
@@ -656,15 +721,15 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_xdrressize	= NLM4_nlm4_testres_sz,
 		.pc_name	= "TEST",
 	},
-	[NLMPROC_LOCK] = {
-		.pc_func = nlm4svc_proc_lock,
-		.pc_decode = nlm4svc_decode_lockargs,
-		.pc_encode = nlm4svc_encode_res,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
-		.pc_ressize = sizeof(struct nlm_res),
-		.pc_xdrressize = Ck+St,
-		.pc_name = "LOCK",
+	[NLMPROC4_LOCK] = {
+		.pc_func	= nlm4svc_proc_lock,
+		.pc_decode	= nlm4_svc_decode_nlm4_lockargs,
+		.pc_encode	= nlm4_svc_encode_nlm4_res,
+		.pc_argsize	= sizeof(struct nlm4_lockargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= sizeof(struct nlm4_res_wrapper),
+		.pc_xdrressize	= NLM4_nlm4_res_sz,
+		.pc_name	= "LOCK",
 	},
 	[NLMPROC_CANCEL] = {
 		.pc_func = nlm4svc_proc_cancel,
diff --git a/fs/lockd/xdr4.h b/fs/lockd/xdr4.h
index 03219801fcb4..2bd22bad9cb0 100644
--- a/fs/lockd/xdr4.h
+++ b/fs/lockd/xdr4.h
@@ -24,6 +24,14 @@ struct nlm4_testargs_wrapper {
 
 static_assert(offsetof(struct nlm4_testargs_wrapper, xdrgen) == 0);
 
+struct nlm4_lockargs_wrapper {
+	struct nlm4_lockargs		xdrgen;
+	struct nlm_cookie		cookie;
+	struct nlm_lock			lock;
+};
+
+static_assert(offsetof(struct nlm4_lockargs_wrapper, xdrgen) == 0);
+
 struct nlm4_testres_wrapper {
 	struct nlm4_testres		xdrgen;
 	struct nlm_lock			lock;
@@ -31,6 +39,12 @@ struct nlm4_testres_wrapper {
 
 static_assert(offsetof(struct nlm4_testres_wrapper, xdrgen) == 0);
 
+struct nlm4_res_wrapper {
+	struct nlm4_res			xdrgen;
+};
+
+static_assert(offsetof(struct nlm4_res_wrapper, xdrgen) == 0);
+
 void	nlm4svc_set_file_lock_range(struct file_lock *fl, u64 off, u64 len);
 bool	nlm4svc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlm4svc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-- 
2.52.0


