Return-Path: <linux-nfs+bounces-17221-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D17ECCCD81A
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37AA1302AFB4
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C942D8DB0;
	Thu, 18 Dec 2025 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJ/2ip3j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF44D2D5419
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088857; cv=none; b=gauJUThpjH50e0NWpBWKUAFEmbuhXFUyslPbqivHGqi8Lzc0ZpVW6z747hIa7kjDys778E1uVg1sTUBG0GOqVORWBu1ZvwufzHzqyxwcBmEdlfsSZ0lvPYgNDi9EVz5XrjLP01zLgZ2J/K9dzXQnk72WgWba3AfghTs8MvFDRn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088857; c=relaxed/simple;
	bh=7PCpnE4OlZ6FI1NaJzJBaAXrQ/Op+XHNcRjYrGOT+SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pt7iX8CImoDPBKDzSxidFgN+dWmz8zrkUgGl71bsv2Wlww6NgaZtNKed5evylARewfFOyAklEjlw6/seSYn/X5cxQHZsG6ktVsJJKINl8IcsVFjIfUkczQds1e9u6X3JQXsx75euWDKDSTrNtuzbIs0W9o2zTe1/apwH9cCKQkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJ/2ip3j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B79AC116D0;
	Thu, 18 Dec 2025 20:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088855;
	bh=7PCpnE4OlZ6FI1NaJzJBaAXrQ/Op+XHNcRjYrGOT+SI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MJ/2ip3jVqJBVvDQz6ilFzQtDj1s8+EoWF+BGktBZXq52f1W1f5BkM66VRavxLKrC
	 Q+OH77vcct3T2cQV19X77bE56b12f+Rj1UcCBNHUJHzvGGNb+DzRvQObAubo7HVPY+
	 tzHxaZ8ycNqkue7VEdrSul7E0Ho31Rs5QkVnnyaQag3qhpi2SatKu64SP8bmiyLZBq
	 JqwZyZMXyu/R13fTKLoEwCyWoPv0sZq6KwhWmbhDm6ln8RaNRnSS2I0dm2CqWZi0ZC
	 vV2HnLVs5u8DkYAPwxVGWi/qzOeq8Mm6SS33W14O9ikiej7LRFR5scZQ20ty/o356U
	 b22Ctxi767Lbg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 33/36] lockd: Use xdrgen XDR functions for the NLMv4 NM_LOCK procedure
Date: Thu, 18 Dec 2025 15:13:43 -0500
Message-ID: <20251218201346.1190928-34-cel@kernel.org>
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

Replace the NLMPROC4_NM_LOCK entry in the nlm_procedures4 array with
an entry that uses the xdrgen-built XDR functions for that
procedure. Helper functions are introduced which will be used here
and in subsequent patches.

The .pc_argzero field is now set to zero for the NLMv4 NM_LOCK
procedure. The xdrgen decoders are trusted to initialize all
arguments in the argp->xdrgen field, making the early defensive
memset unnecessary. The remaining argp fields are cleared as needed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 80 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 17 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 678b5b203955..b5bc8e7125a3 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -951,18 +951,64 @@ static __be32 nlm4svc_proc_unshare(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
-/*
- * NM_LOCK: Create an unmonitored lock
+/**
+ * nlm4svc_proc_nm_lock - NM_LOCK: Establish a non-monitored lock
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
  */
-static __be32
-nlm4svc_proc_nm_lock(struct svc_rqst *rqstp)
+static __be32 nlm4svc_proc_nm_lock(struct svc_rqst *rqstp)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
+	struct nlm4_lockargs_wrapper *argp = rqstp->rq_argp;
+	unsigned char type = argp->xdrgen.exclusive ? F_WRLCK : F_RDLCK;
+	struct nlm4_res_wrapper *resp = rqstp->rq_resp;
+	struct nlm_file	*file = NULL;
+	struct nlm_host	*host;
 
-	dprintk("lockd: NM_LOCK       called\n");
+	resp->xdrgen.cookie = argp->xdrgen.cookie;
 
-	argp->monitor = 0;		/* just clean the monitor flag */
-	return nlm4svc_proc_lock(rqstp);
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
 
 /*
@@ -1216,15 +1262,15 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_xdrressize	= NLM4_nlm4_shareres_sz,
 		.pc_name	= "UNSHARE",
 	},
-	[NLMPROC_NM_LOCK] = {
-		.pc_func = nlm4svc_proc_nm_lock,
-		.pc_decode = nlm4svc_decode_lockargs,
-		.pc_encode = nlm4svc_encode_res,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
-		.pc_ressize = sizeof(struct nlm_res),
-		.pc_xdrressize = Ck+St,
-		.pc_name = "NM_LOCK",
+	[NLMPROC4_NM_LOCK] = {
+		.pc_func	= nlm4svc_proc_nm_lock,
+		.pc_decode	= nlm4_svc_decode_nlm4_lockargs,
+		.pc_encode	= nlm4_svc_encode_nlm4_res,
+		.pc_argsize	= sizeof(struct nlm4_lockargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= sizeof(struct nlm4_res_wrapper),
+		.pc_xdrressize	= NLM4_nlm4_res_sz,
+		.pc_name	= "NM_LOCK",
 	},
 	[NLMPROC_FREE_ALL] = {
 		.pc_func = nlm4svc_proc_free_all,
-- 
2.52.0


