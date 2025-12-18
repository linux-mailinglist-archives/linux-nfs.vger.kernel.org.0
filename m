Return-Path: <linux-nfs+bounces-17203-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D402ECCD7FB
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 210A93048D84
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCAF2D7DC1;
	Thu, 18 Dec 2025 20:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJiKQsHS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EFE2D739D
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088841; cv=none; b=gcwS7+DgMc7kRvOYQIoduv28qvavVHyF+nONwOactW49tj7mGIc+70FMhWLnVqjqcpFUanJvyI1wtQk7tCiUDkfjoK4IB9jcn9fk+CrHef9tXuDXvtXumjcgV7ByeMhWP1OodCIw3Pa6Fehtoq3VEukwA+PcG56WoRJEzWUrsV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088841; c=relaxed/simple;
	bh=TSyYM+eFSXkquZRN5VM4pPfmmwf9ljmN0JPiWC/G80M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFnIx69ZsMLKdylb16HQqmC0aajrnhMiPCj3SuVUrHr7vbq5moZRjnEajjlRA+MMYcwNIzcS41xM8KWY7tg8ZxMlSR9ZbXIH/RIyjy05Og7VFmKwe+1xcna0vvD8tDBEZUM1DCFGzr7tpWpL1P4v3XIFjQ0vQBvVSpc6w7GPgT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJiKQsHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2CDC116D0;
	Thu, 18 Dec 2025 20:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088841;
	bh=TSyYM+eFSXkquZRN5VM4pPfmmwf9ljmN0JPiWC/G80M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aJiKQsHSIz2zlmivb2r7Qg5Joegg8apUT6F3bE45dJm5ji7xCoj8/QxiLyGnTGXAh
	 FPAuy+MPPse+fVQ/LnWOM4LQIgnX4hbj0SlK9Vmjm2PU7iOpzNJDrEu8aw2jPkhVSj
	 L2dRLj6lyCcaQm/Srfuydtd8ocDe7225VJVfLDUX3lLryRgQ/O6TAKBBl/FoXqf1/K
	 PgUn2M+5W60twwLgAPAFh6mIZje9I8y/vR2sTyrW7rKq9MyUq405l4wuwBqcsSz+Xq
	 dOtnqWXp3IuFgBDvQfXnGns8OFa2j68pYjHWTseFEMOX2mfroFqXhitMYGZwIHvwv9
	 NwDrtO2HNszdA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 15/36] lockd: Use xdrgen XDR functions for the NLMv4 GRANTED procedure
Date: Thu, 18 Dec 2025 15:13:25 -0500
Message-ID: <20251218201346.1190928-16-cel@kernel.org>
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

Replace the NLMPROC4_GRANTED entry in the nlm_procedures4 array with
an entry that uses the xdrgen-built XDR functions for that
procedure. Helper functions are introduced which will be used here
and in subsequent patches.

The .pc_argzero field is now set to zero for the NLMv4 GRANTED
procedure. The xdrgen decoders are trusted to initialize all
arguments in the argp->xdrgen field, making the early defensive
memset unnecessary. The remaining argp fields are cleared as needed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 54 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 10 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 22f676df16e8..fc446639095a 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -545,10 +545,44 @@ __nlm4svc_proc_granted(struct svc_rqst *rqstp, struct nlm_res *resp)
 	return rpc_success;
 }
 
+/**
+ * nlm4svc_proc_granted - GRANTED: Blocked lock has been granted
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *
+ * Permissible procedure status codes:
+ *   %NLM4_GRANTED:		The requested lock was granted.
+ *   %NLM4_DENIED:		The server could not allocate the resources
+ *				needed to process the request.
+ *   %NLM4_DENIED_GRACE_PERIOD:	The server has recently restarted and is
+ *				re-establishing existing locks, and is not
+ *				yet ready to accept normal service requests.
+ */
 static __be32
 nlm4svc_proc_granted(struct svc_rqst *rqstp)
 {
-	return __nlm4svc_proc_granted(rqstp, rqstp->rq_resp);
+	struct nlm4_testargs_wrapper *argp = rqstp->rq_argp;
+	struct nlm4_res_wrapper *resp = rqstp->rq_resp;
+	struct nlm4_lock *alock = &argp->xdrgen.alock;
+	struct nlm_lock *lock = &argp->lock;
+
+	resp->xdrgen.cookie = argp->xdrgen.cookie;
+
+	resp->xdrgen.stat.stat = nlm_lck_denied;
+	if (alock->fh.len > NFS_MAXFHSIZE)
+		goto out;
+
+	lock->fh.size = alock->fh.len;
+	memcpy(lock->fh.data, alock->fh.data, alock->fh.len);
+	lock->svid = alock->svid;
+	nlm4svc_set_file_lock_range(&lock->fl, alock->l_offset, alock->l_len);
+
+	resp->xdrgen.stat.stat = nlmclnt_grant(svc_addr(rqstp), lock);
+
+out:
+	return rpc_success;
 }
 
 /*
@@ -843,15 +877,15 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_xdrressize	= NLM4_nlm4_res_sz,
 		.pc_name	= "UNLOCK",
 	},
-	[NLMPROC_GRANTED] = {
-		.pc_func = nlm4svc_proc_granted,
-		.pc_decode = nlm4svc_decode_testargs,
-		.pc_encode = nlm4svc_encode_res,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
-		.pc_ressize = sizeof(struct nlm_res),
-		.pc_xdrressize = Ck+St,
-		.pc_name = "GRANTED",
+	[NLMPROC4_GRANTED] = {
+		.pc_func	= nlm4svc_proc_granted,
+		.pc_decode	= nlm4_svc_decode_nlm4_testargs,
+		.pc_encode	= nlm4_svc_encode_nlm4_res,
+		.pc_argsize	= sizeof(struct nlm4_testargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= sizeof(struct nlm4_res_wrapper),
+		.pc_xdrressize	= NLM4_nlm4_res_sz,
+		.pc_name	= "GRANTED",
 	},
 	[NLMPROC_TEST_MSG] = {
 		.pc_func = nlm4svc_proc_test_msg,
-- 
2.52.0


