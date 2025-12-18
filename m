Return-Path: <linux-nfs+bounces-17202-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9430DCCD7D7
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82CFD302A77B
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4532D7DC1;
	Thu, 18 Dec 2025 20:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMatbHCb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2972D7DF5
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088841; cv=none; b=DYjmfhHnd5qIrqTZPYN8IudVD8LtBSp8FWLvcii1iM40IiubP/wLG6tIBmplRXkER3L4caWCVzovS+xAoav6pso3bVokeQRANnLiyOzgjlV1B5zCBMlVY7ex85aHDIe5BMbONpF6svAC1uF/TP7L3uHY15XjjD/gPl0JUafEAGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088841; c=relaxed/simple;
	bh=tuF2Di8RXJs11nzzo4lzt3agL1xsXkzEqn8lARVckKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9fC9ucxPQRUX0Ll55O7e4cV5VyTO28lAoSp0OPuaqYufWSSPevH38agmGDAZWdTaNGiRt0J/076LRGNVGUR1Iubhfw7L6iDuC5BpIHoiXpzBkOoCJuN3aAnn0fS7PXsw8fBx1ynwF8mEIS+n+VkSQzVt9fXONddVGZ/FgFddwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMatbHCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DAAC19421;
	Thu, 18 Dec 2025 20:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088840;
	bh=tuF2Di8RXJs11nzzo4lzt3agL1xsXkzEqn8lARVckKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gMatbHCbbmNQW11DWGIIMya3lLioHPtvNVyLoPp3aADnCA0x5ioc4h9gm1MnL4VND
	 HOee5hrfcAk0ndtCzaCOn1fYz//Bu8RRGj+y3hFswHHgpZe3iEGQNqYGqz6piqma2Y
	 f6Dzd2kcrWt7yOlYoZTAnswvDfhF1quZw6/hYJ7b67VXcmCwbzd0LFn715zuVPhehL
	 XY3uMTNKY5xlEUF5zW4dDEC1xEejq2tUOUUP+gP+3pNkEpLTHtQ3b+Se33akWHy2DY
	 nxRE9FHjF5g6BH6GM0Pc/EBWbo3KHjkBbXl1+ieuc6NHYqTyKt1+YFF5xNV1ErZT0F
	 4SCOl2KUX4yrA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 14/36] lockd: Use xdrgen XDR functions for the NLMv4 UNLOCK procedure
Date: Thu, 18 Dec 2025 15:13:24 -0500
Message-ID: <20251218201346.1190928-15-cel@kernel.org>
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

Replace the NLMPROC4_UNLOCK entry in the nlm_procedures4 array with
an entry that uses the xdrgen-built XDR functions for that
procedure. Helper functions are introduced which will be used here
and in subsequent patches.

The .pc_argzero field is now set to zero for the NLMv4 UNLOCK
procedure. The xdrgen decoders are trusted to initialize all
arguments in the argp->xdrgen field, making the early defensive
memset unnecessary. The remaining argp fields are cleared as needed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 65 ++++++++++++++++++++++++++++++++++++++-------
 fs/lockd/xdr4.h     |  7 +++++
 2 files changed, 62 insertions(+), 10 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 66d300626f66..22f676df16e8 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -477,10 +477,55 @@ __nlm4svc_proc_unlock(struct svc_rqst *rqstp, struct nlm_res *resp)
 	return rpc_success;
 }
 
+/**
+ * nlm4svc_proc_unlock - UNLOCK: Remove a lock
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_drop_reply:		Do not send an RPC reply.
+ *
+ * Permissible procedure status codes:
+ *   %NLM4_GRANTED:		The requested lock was granted.
+ *   %NLM4_DENIED_GRACE_PERIOD:	The server has recently restarted and is
+ *				re-establishing existing locks, and is not
+ *				yet ready to accept normal service requests.
+ */
 static __be32
 nlm4svc_proc_unlock(struct svc_rqst *rqstp)
 {
-	return __nlm4svc_proc_unlock(rqstp, rqstp->rq_resp);
+	struct nlm4_unlockargs_wrapper *argp = rqstp->rq_argp;
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
+						     F_UNLCK);
+	if (resp->xdrgen.stat.stat)
+		goto out;
+
+	resp->xdrgen.stat.stat = nlmsvc_unlock(net, file, &argp->lock);
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
@@ -788,15 +833,15 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_xdrressize	= NLM4_nlm4_res_sz,
 		.pc_name	= "CANCEL",
 	},
-	[NLMPROC_UNLOCK] = {
-		.pc_func = nlm4svc_proc_unlock,
-		.pc_decode = nlm4svc_decode_unlockargs,
-		.pc_encode = nlm4svc_encode_res,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
-		.pc_ressize = sizeof(struct nlm_res),
-		.pc_xdrressize = Ck+St,
-		.pc_name = "UNLOCK",
+	[NLMPROC4_UNLOCK] = {
+		.pc_func	= nlm4svc_proc_unlock,
+		.pc_decode	= nlm4_svc_decode_nlm4_unlockargs,
+		.pc_encode	= nlm4_svc_encode_nlm4_res,
+		.pc_argsize	= sizeof(struct nlm4_unlockargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= sizeof(struct nlm4_res_wrapper),
+		.pc_xdrressize	= NLM4_nlm4_res_sz,
+		.pc_name	= "UNLOCK",
 	},
 	[NLMPROC_GRANTED] = {
 		.pc_func = nlm4svc_proc_granted,
diff --git a/fs/lockd/xdr4.h b/fs/lockd/xdr4.h
index 8fef6b53eee3..e323a7f88308 100644
--- a/fs/lockd/xdr4.h
+++ b/fs/lockd/xdr4.h
@@ -39,6 +39,13 @@ struct nlm4_cancargs_wrapper {
 
 static_assert(offsetof(struct nlm4_cancargs_wrapper, xdrgen) == 0);
 
+struct nlm4_unlockargs_wrapper {
+	struct nlm4_unlockargs		xdrgen;
+	struct nlm_lock			lock;
+};
+
+static_assert(offsetof(struct nlm4_unlockargs_wrapper, xdrgen) == 0);
+
 struct nlm4_testres_wrapper {
 	struct nlm4_testres		xdrgen;
 	struct nlm_lock			lock;
-- 
2.52.0


