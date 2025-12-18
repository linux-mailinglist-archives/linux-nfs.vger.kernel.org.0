Return-Path: <linux-nfs+bounces-17220-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A395ACCD819
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAA603041E35
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD652D8795;
	Thu, 18 Dec 2025 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2I4/5qW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75DD2D9796
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088855; cv=none; b=g3w/z5UmgC+uVu4OrfSEIj0wLbBj9O8qlmitibCq39FFMI7lyV2Sbhc5GLXVt10mGGub7SxzDofXV+OqGQizjUge6iTyatYvfiKDt4Vk8RbmVS6GEQ4+tuTXDpDPKfD5JaS0DW575MCohNftV1x5hkVUsg9GyHKo2ACUkYbQUPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088855; c=relaxed/simple;
	bh=6Pm/Cxi5NgAVtKbuNIuCcxDFMQNrT1eRhEN5HPJQVXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJsoL/Q0aAZZBBN6W3xM3D8Myzi+gFrw90VQKGMLpS8iLZOThwVc4vbDn0Vh7a+QbPjD7KgZH9cqSg1kgjbgkxFmU4P+DI2cpRnEnq1kG33h9Y9XhLOYk4cBEd+pXczo//DBYX+G/H/rB+al36PasAAUnkp5Mf8Hf+jXZC6oCdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2I4/5qW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFB9C4CEFB;
	Thu, 18 Dec 2025 20:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088855;
	bh=6Pm/Cxi5NgAVtKbuNIuCcxDFMQNrT1eRhEN5HPJQVXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D2I4/5qWkBNbVeSfH5rlvcYHPAxEoGNvzeT4YvYD3Lk3Mzl1tqyiBGj2QVICS6exQ
	 DByTJMMdx9ulihdWZp0/HEwAE+zrPjCzP6rb0OkrL3E1VCuadaNrYw2hK7IjNcIlFC
	 P256A4Y12bm3e8wxd9/aP+6nmk11PiGOvHqT6jhX7yHMvq7tOyrnVuSbwobQPqZsfq
	 dOQoJRJIwu6KTs6QMQpGBsOZucqD749pFmpiAkQ/v+HmhiCoMNGpXezRASN9Q/bFLr
	 NfctCFdGiRmS1/4CbSro2OMXIqfywrQ3WQ+KcZPMLFoIV05lm6oW3h6WE8nX+Dzm/b
	 faN9c5K7R6yCA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 32/36] lockd: Use xdrgen XDR functions for the NLMv4 UNSHARE procedure
Date: Thu, 18 Dec 2025 15:13:42 -0500
Message-ID: <20251218201346.1190928-33-cel@kernel.org>
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

Replace the NLMPROC4_UNSHARE entry in the nlm_procedures4 array with
an entry that uses the xdrgen-built XDR functions for that
procedure. Helper functions are introduced which will be used here
and in subsequent patches.

The .pc_argzero field is now set to zero for the NLMv4 UNSHARE
procedure. The xdrgen decoders are trusted to initialize all
arguments in the argp->xdrgen field, making the early defensive
memset unnecessary. The remaining argp fields are cleared as needed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 84 +++++++++++++++++++++++++++------------------
 1 file changed, 50 insertions(+), 34 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 5f44d475c30e..678b5b203955 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -896,42 +896,58 @@ static __be32 nlm4svc_proc_share(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
-/*
- * UNSHARE: Release a DOS share.
+/**
+ * nlm4svc_proc_unshare - UNSHARE: Release a share reservation
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_drop_reply:		Do not send an RPC reply.
+ *
+ * Permissible procedure status codes:
+ *   %NLM4_GRANTED:		The requested share lock was granted.
+ *   %NLM4_DENIED_GRACE_PERIOD:	The server has recently restarted and is
+ *				re-establishing existing locks, and is not
+ *				yet ready to accept normal service requests.
  */
-static __be32
-nlm4svc_proc_unshare(struct svc_rqst *rqstp)
+static __be32 nlm4svc_proc_unshare(struct svc_rqst *rqstp)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
-	struct nlm_res *resp = rqstp->rq_resp;
+	struct nlm4_shareargs_wrapper *argp = rqstp->rq_argp;
+	struct nlm4_shareres_wrapper *resp = rqstp->rq_resp;
 	struct nlm_lock	*lock = &argp->lock;
-	struct nlm_host	*host;
-	struct nlm_file	*file;
+	struct nlm4_lock xdr_lock = {
+		.fh		= argp->xdrgen.share.fh,
+		.oh		= argp->xdrgen.share.oh,
+		.svid		= ~(u32)0,
+	};
+	struct nlm_host	*host = NULL;
+	struct nlm_file	*file = NULL;
 
-	dprintk("lockd: UNSHARE       called\n");
+	resp->xdrgen.cookie = argp->xdrgen.cookie;
 
-	resp->cookie = argp->cookie;
+	resp->xdrgen.stat = nlm_lck_denied_grace_period;
+	if (locks_in_grace(SVC_NET(rqstp)))
+		goto out;
 
-	/* Don't accept requests during grace period */
-	if (locks_in_grace(SVC_NET(rqstp))) {
-		resp->status = nlm_lck_denied_grace_period;
-		return rpc_success;
-	}
+	resp->xdrgen.stat = nlm_lck_denied_nolocks;
+	host = nlm4svc_lookup_host(rqstp, argp->xdrgen.share.caller_name, true);
+	if (!host)
+		goto out;
 
-	/* Obtain client and file */
-	locks_init_lock(&lock->fl);
-	lock->svid = ~(u32)0;
-	resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file);
-	if (resp->status)
-		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
+	resp->xdrgen.stat = nlm4svc_lookup_file(rqstp, host, lock, &file,
+						&xdr_lock, F_RDLCK);
+	if (resp->xdrgen.stat)
+		goto out;
 
-	/* Now try to unshare the file */
-	resp->status = nlmsvc_unshare_file(host, file, &lock->oh);
 
-	dprintk("lockd: UNSHARE       status %d\n", ntohl(resp->status));
+	resp->xdrgen.stat = nlmsvc_unshare_file(host, file, &lock->oh);
+
 	nlmsvc_release_lockowner(lock);
+
+out:
+	if (file)
+		nlm_release_file(file);
 	nlmsvc_release_host(host);
-	nlm_release_file(file);
 	return rpc_success;
 }
 
@@ -1190,15 +1206,15 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_xdrressize	= NLM4_nlm4_shareres_sz,
 		.pc_name	= "SHARE",
 	},
-	[NLMPROC_UNSHARE] = {
-		.pc_func = nlm4svc_proc_unshare,
-		.pc_decode = nlm4svc_decode_shareargs,
-		.pc_encode = nlm4svc_encode_shareres,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
-		.pc_ressize = sizeof(struct nlm_res),
-		.pc_xdrressize = Ck+St+1,
-		.pc_name = "UNSHARE",
+	[NLMPROC4_UNSHARE] = {
+		.pc_func	= nlm4svc_proc_unshare,
+		.pc_decode	= nlm4_svc_decode_nlm4_shareargs,
+		.pc_encode	= nlm4_svc_encode_nlm4_shareres,
+		.pc_argsize	= sizeof(struct nlm4_shareargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= sizeof(struct nlm4_shareres_wrapper),
+		.pc_xdrressize	= NLM4_nlm4_shareres_sz,
+		.pc_name	= "UNSHARE",
 	},
 	[NLMPROC_NM_LOCK] = {
 		.pc_func = nlm4svc_proc_nm_lock,
-- 
2.52.0


