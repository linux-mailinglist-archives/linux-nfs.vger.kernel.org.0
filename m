Return-Path: <linux-nfs+bounces-17222-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71500CCD81F
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC1D63059378
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56BF2D94AD;
	Thu, 18 Dec 2025 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeN4oT2O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7222D8370
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088857; cv=none; b=dlPWwPDoNvOKRbbSAR5np6l4r+Ntd96dysmL0vHPPUnnj1BN8OoB9uGlAh3wmHwJuYt2z44BJ1NdDQbIIyZdHOf/xL3+NzVeQK60N5Ef5aQ2vBMpWhO8pac8Z9FAB6fh4SNQDJkknvNgiEHssP4WAAYvAP3uaM51cd1Hugs4WTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088857; c=relaxed/simple;
	bh=YAwDTMmpr6hogxrGa9JJVPscF751peDKwtNbGCukY6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVpPWn9PxY0tr10y9nEJlrl0MOYb3XNC8xL9hBQ68vcB2hZX1EpIuKY+vuEfVEar0oljoMH2njfEMQKPlXDmeHvm/k6qIFR17zpRXbRUFLyoyzpr0+EXHG66qwxLo7WuJtAl6xdqrMo7jXq2LNMlCfx4L9jHmVAuYYTLAd5sEyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeN4oT2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BC1C19422;
	Thu, 18 Dec 2025 20:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088856;
	bh=YAwDTMmpr6hogxrGa9JJVPscF751peDKwtNbGCukY6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AeN4oT2O7atf5TB8rd4M4Tzy9YbxPA0RssrMpwnLrdvoJ2bDqjzx77oVyluO0YJfy
	 BP5mhG8vylOmQcoqBlAOM1rKRGLVyJ5pd9Dujst5izEZx/S759Yz7fkBt7XqLYThCL
	 PVeJNPPGu5F64TW0q9DU93CjpCCzklJHEicW+PuzO/32aUDTmv3+k/BQHgmThpkRcz
	 5cQ/BW9Q8/Cc2hiciLK7jpD69E1xQD0/Hbrd/UlCn8ah3UrDBQA8BH8uTogtOu6xko
	 GgSVLtm8H2uF2UDyuEuAXE0fPEmJcrpAl1rsou4zTTgo3zvIXABGXhAdpr9JIpPHcn
	 W/1MSOPkv4j7Q==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 34/36] lockd: Use xdrgen XDR functions for the NLMv4 FREE_ALL procedure
Date: Thu, 18 Dec 2025 15:13:44 -0500
Message-ID: <20251218201346.1190928-35-cel@kernel.org>
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

Replace the NLMPROC4_FREE_ALL entry in the nlm_procedures4 array
with an entry that uses the xdrgen-built XDR functions for that
procedure. Helper functions are introduced which will be used here
and in subsequent patches.

The .pc_argzero field is now set to zero for the NLMv4 FREE_ALL
procedure. The xdrgen decoders are trusted to initialize all
arguments in the argp->xdrgen field, making the early defensive
memset unnecessary. The remaining argp fields are cleared as needed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 102 ++++++++++----------------------------------
 fs/lockd/xdr4.h     |   6 +++
 2 files changed, 29 insertions(+), 79 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index b5bc8e7125a3..ea5b502e1983 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -91,68 +91,6 @@ nlm4svc_lookup_file(struct svc_rqst *rqstp, struct nlm_host *host,
 	return nlm_granted;
 }
 
-/*
- * Obtain client and file from arguments
- */
-static __be32
-nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
-			struct nlm_host **hostp, struct nlm_file **filp)
-{
-	struct nlm_host		*host = NULL;
-	struct nlm_file		*file = NULL;
-	struct nlm_lock		*lock = &argp->lock;
-	__be32			error = 0;
-
-	/* nfsd callbacks must have been installed for this procedure */
-	if (!nlmsvc_ops)
-		return nlm_lck_denied_nolocks;
-
-	if (lock->lock_start > OFFSET_MAX ||
-	    (lock->lock_len && ((lock->lock_len - 1) > (OFFSET_MAX - lock->lock_start))))
-		return nlm4_fbig;
-
-	/* Obtain host handle */
-	if (!(host = nlmsvc_lookup_host(rqstp, lock->caller, lock->len))
-	 || (argp->monitor && nsm_monitor(host) < 0))
-		goto no_locks;
-	*hostp = host;
-
-	/* Obtain file pointer. Not used by FREE_ALL call. */
-	if (filp != NULL) {
-		int mode = lock_to_openmode(&lock->fl);
-
-		lock->fl.c.flc_flags = FL_POSIX;
-
-		error = nlm_lookup_file(rqstp, &file, lock);
-		if (error)
-			goto no_locks;
-		*filp = file;
-
-		/* Set up the missing parts of the file_lock structure */
-		lock->fl.c.flc_file = file->f_file[mode];
-		lock->fl.c.flc_pid = current->tgid;
-		lock->fl.fl_start = (loff_t)lock->lock_start;
-		lock->fl.fl_end = lock->lock_len ?
-				   (loff_t)(lock->lock_start + lock->lock_len - 1) :
-				   OFFSET_MAX;
-		lock->fl.fl_lmops = &nlmsvc_lock_operations;
-		nlmsvc_locks_init_private(&lock->fl, host, (pid_t)lock->svid);
-		if (!lock->fl.c.flc_owner) {
-			/* lockowner allocation has failed */
-			nlmsvc_release_host(host);
-			return nlm_lck_denied_nolocks;
-		}
-	}
-
-	return 0;
-
-no_locks:
-	nlmsvc_release_host(host);
- 	if (error)
-		return error;	
-	return nlm_lck_denied_nolocks;
-}
-
 /**
  * nlm4svc_proc_null - NULL: Do nothing
  * @rqstp: RPC transaction context
@@ -1011,21 +949,27 @@ static __be32 nlm4svc_proc_nm_lock(struct svc_rqst *rqstp)
 		rpc_drop_reply : rpc_success;
 }
 
-/*
- * FREE_ALL: Release all locks and shares held by client
+/**
+ * nlm4svc_proc_free_all - FREE_ALL: Discard client's lock and share state
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
  */
-static __be32
-nlm4svc_proc_free_all(struct svc_rqst *rqstp)
+static __be32 nlm4svc_proc_free_all(struct svc_rqst *rqstp)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
+	struct nlm4_notify_wrapper *argp = rqstp->rq_argp;
 	struct nlm_host	*host;
 
-	/* Obtain client */
-	if (nlm4svc_retrieve_args(rqstp, argp, &host, NULL))
-		return rpc_success;
+	host = nlm4svc_lookup_host(rqstp, argp->xdrgen.name, false);
+	if (!host)
+		goto out;
 
 	nlmsvc_free_host_resources(host);
+
 	nlmsvc_release_host(host);
+
+out:
 	return rpc_success;
 }
 
@@ -1272,14 +1216,14 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_xdrressize	= NLM4_nlm4_res_sz,
 		.pc_name	= "NM_LOCK",
 	},
-	[NLMPROC_FREE_ALL] = {
-		.pc_func = nlm4svc_proc_free_all,
-		.pc_decode = nlm4svc_decode_notify,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "FREE_ALL",
+	[NLMPROC4_FREE_ALL] = {
+		.pc_func	= nlm4svc_proc_free_all,
+		.pc_decode	= nlm4_svc_decode_nlm4_notify,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm4_notify),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "FREE_ALL",
 	},
 };
diff --git a/fs/lockd/xdr4.h b/fs/lockd/xdr4.h
index 39e7c953d3fd..b08e35abbd5d 100644
--- a/fs/lockd/xdr4.h
+++ b/fs/lockd/xdr4.h
@@ -60,6 +60,12 @@ struct nlm4_shareargs_wrapper {
 
 static_assert(offsetof(struct nlm4_shareargs_wrapper, xdrgen) == 0);
 
+struct nlm4_notify_wrapper {
+	struct nlm4_notify		xdrgen;
+};
+
+static_assert(offsetof(struct nlm4_notify_wrapper, xdrgen) == 0);
+
 struct nlm4_testres_wrapper {
 	struct nlm4_testres		xdrgen;
 	struct nlm_lock			lock;
-- 
2.52.0


