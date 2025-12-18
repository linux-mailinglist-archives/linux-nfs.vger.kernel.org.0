Return-Path: <linux-nfs+bounces-17219-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B2571CCD810
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1DEC302E2C2
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F832D7DF5;
	Thu, 18 Dec 2025 20:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b49Kyi/r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A83B263C8C
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088854; cv=none; b=hCVOMOcAkeIAh/Uvwe74+2KMkpc6PED3WHNrJk9H/zUyRjQTh7kvam/RfR3gbhkZxZcaO8HHePMLXMshXZXZpa969UnSMGpXRlOw05fBPzyOHcdyoQFnftBGz7aoMf/pdZ3Ljrga8YtNx14Z8jf5O60w5qZfP1XVdwJU8P/NsCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088854; c=relaxed/simple;
	bh=vo/h0L9El2X1jXKw3C+BGOsolkeldt8ZiOCLPEp6Hl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTpXMmNcJqeHrqXl3/NsqTIKZjYNI8+QNygHzzQeDFVw6wxgL8NFOY0kbF7oyabZkKODGboPion14Yjv+Bwbce3FZ7fFgE9DeGE3LE/4drfMKgLTpDvCSDsbofXfn4+6jTbovEpvzuAch3QkNbD93upJeL7SDQo7oSGbvJpmnMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b49Kyi/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96313C19421;
	Thu, 18 Dec 2025 20:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088854;
	bh=vo/h0L9El2X1jXKw3C+BGOsolkeldt8ZiOCLPEp6Hl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b49Kyi/rM6KraTD18IgKoi0VOpFiZvzib4AfqkP2DDWeqgO667rFDpxicq2kfkTmm
	 5kZ7xf5Y3hjlNqJYiViojGoLdRHYG91F/Ngti5vILFtK+u8AQODnLv5QxCfta6a8Xo
	 9jwb4h1vDGZDOQz/0gGkRr6AMj3Sg5EuwrJUVNIzn4R28v3ZWS/q7DrexM/tLcwk9C
	 TT/lIlQLi1bDKD9WkJIUxlF1uGsmYGVbOquFV4xdiEc1BTRtKNCSiVC0SAeTCD1w+n
	 6c79Kz50ewZ0MXGbZbM81gSReAoiC6XKGiOuAoAuhEXNSV8i4MlapFR139b8o+T1Uv
	 UPV1HLyvNvxzQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 31/36] lockd: Use xdrgen XDR functions for the NLMv4 SHARE procedure
Date: Thu, 18 Dec 2025 15:13:41 -0500
Message-ID: <20251218201346.1190928-32-cel@kernel.org>
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

Replace the NLMPROC4_SHARE entry in the nlm_procedures4 array with
an entry that uses the xdrgen-built XDR functions for that
procedure. Helper functions are introduced which will be used here
and in subsequent patches.

The .pc_argzero field is now set to zero for the NLMv4 SHARE
procedure. The xdrgen decoders are trusted to initialize all
arguments in the argp->xdrgen field, making the early defensive
memset unnecessary. The remaining argp fields are cleared as needed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 90 +++++++++++++++++++++++++++------------------
 fs/lockd/xdr4.h     | 13 +++++++
 2 files changed, 68 insertions(+), 35 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 67b9dcfce19c..5f44d475c30e 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -836,43 +836,63 @@ static __be32 nlm4svc_proc_unused(struct svc_rqst *rqstp)
 	return rpc_proc_unavail;
 }
 
-/*
- * SHARE: create a DOS share or alter existing share.
+/**
+ * nlm4svc_proc_share - SHARE: Open a file using DOS file-sharing modes
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_drop_reply:		Do not send an RPC reply.
+ *
+ * Permissible procedure status codes:
+ *   %NLM4_GRANTED:		The requested share lock was granted.
+ *   %NLM4_DENIED:		The requested lock conflicted with existing
+ *				lock reservations for the file.
+ *   %NLM4_DENIED_NOLOCKS:	The server could not allocate the resources
+ *				needed to process the request.
+ *   %NLM4_DENIED_GRACE_PERIOD:	The server has recently restarted and is
+ *				re-establishing existing locks, and is not
+ *				yet ready to accept normal service requests.
  */
-static __be32
-nlm4svc_proc_share(struct svc_rqst *rqstp)
+static __be32 nlm4svc_proc_share(struct svc_rqst *rqstp)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
-	struct nlm_res *resp = rqstp->rq_resp;
+	struct nlm4_shareargs_wrapper *argp = rqstp->rq_argp;
+	struct nlm4_shareres_wrapper *resp = rqstp->rq_resp;
 	struct nlm_lock	*lock = &argp->lock;
-	struct nlm_host	*host;
-	struct nlm_file	*file;
+	struct nlm_host	*host = NULL;
+	struct nlm_file	*file = NULL;
+	struct nlm4_lock xdr_lock = {
+		.fh		= argp->xdrgen.share.fh,
+		.oh		= argp->xdrgen.share.oh,
+		.svid		= ~(u32)0,
+	};
 
-	dprintk("lockd: SHARE         called\n");
+	resp->xdrgen.cookie = argp->xdrgen.cookie;
 
-	resp->cookie = argp->cookie;
+	resp->xdrgen.stat = nlm_lck_denied_grace_period;
+	if (locks_in_grace(SVC_NET(rqstp)) && !argp->xdrgen.reclaim)
+		goto out;
 
-	/* Don't accept new lock requests during grace period */
-	if (locks_in_grace(SVC_NET(rqstp)) && !argp->reclaim) {
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
 
-	/* Now try to create the share */
-	resp->status = nlmsvc_share_file(host, file, &lock->oh,
-					 argp->fsm_access, argp->fsm_mode);
+	resp->xdrgen.stat = nlmsvc_share_file(host, file, &lock->oh,
+					      argp->xdrgen.share.access,
+					      argp->xdrgen.share.mode);
 
-	dprintk("lockd: SHARE         status %d\n", ntohl(resp->status));
 	nlmsvc_release_lockowner(lock);
+
+out:
+	if (file)
+		nlm_release_file(file);
 	nlmsvc_release_host(host);
-	nlm_release_file(file);
 	return rpc_success;
 }
 
@@ -1160,15 +1180,15 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "UNUSED",
 	},
-	[NLMPROC_SHARE] = {
-		.pc_func = nlm4svc_proc_share,
-		.pc_decode = nlm4svc_decode_shareargs,
-		.pc_encode = nlm4svc_encode_shareres,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
-		.pc_ressize = sizeof(struct nlm_res),
-		.pc_xdrressize = Ck+St+1,
-		.pc_name = "SHARE",
+	[NLMPROC4_SHARE] = {
+		.pc_func	= nlm4svc_proc_share,
+		.pc_decode	= nlm4_svc_decode_nlm4_shareargs,
+		.pc_encode	= nlm4_svc_encode_nlm4_shareres,
+		.pc_argsize	= sizeof(struct nlm4_shareargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= sizeof(struct nlm4_shareres_wrapper),
+		.pc_xdrressize	= NLM4_nlm4_shareres_sz,
+		.pc_name	= "SHARE",
 	},
 	[NLMPROC_UNSHARE] = {
 		.pc_func = nlm4svc_proc_unshare,
diff --git a/fs/lockd/xdr4.h b/fs/lockd/xdr4.h
index edfbe7c06644..39e7c953d3fd 100644
--- a/fs/lockd/xdr4.h
+++ b/fs/lockd/xdr4.h
@@ -53,6 +53,13 @@ struct nlm4_notifyargs_wrapper {
 
 static_assert(offsetof(struct nlm4_notifyargs_wrapper, xdrgen) == 0);
 
+struct nlm4_shareargs_wrapper {
+	struct nlm4_shareargs		xdrgen;
+	struct nlm_lock			lock;
+};
+
+static_assert(offsetof(struct nlm4_shareargs_wrapper, xdrgen) == 0);
+
 struct nlm4_testres_wrapper {
 	struct nlm4_testres		xdrgen;
 	struct nlm_lock			lock;
@@ -67,6 +74,12 @@ struct nlm4_res_wrapper {
 
 static_assert(offsetof(struct nlm4_res_wrapper, xdrgen) == 0);
 
+struct nlm4_shareres_wrapper {
+	struct nlm4_shareres		xdrgen;
+};
+
+static_assert(offsetof(struct nlm4_shareres_wrapper, xdrgen) == 0);
+
 void	nlm4svc_set_file_lock_range(struct file_lock *fl, u64 off, u64 len);
 bool	nlm4svc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlm4svc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-- 
2.52.0


