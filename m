Return-Path: <linux-nfs+bounces-17199-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B06CCD7EF
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F4223021F81
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C372C3248;
	Thu, 18 Dec 2025 20:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j58WJyEz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8B72D7DF5
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088838; cv=none; b=ge3hV2VNCWOOyM/5VHvUM2DA0OjyPfRvCJhVILGO0ke2BInSoreTfX3EcViKF2zOMeIebOXsLbfv2jEQ/60LYjmtym/bKFrcJjycWyWS76KN7AnaaWM+Z+8MVs3O8E1/BCo6y2X9nQMXfWkS9xfXaTri6WTz1SlhblflbYGZAII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088838; c=relaxed/simple;
	bh=DFI2unmuS+hMsUajG0CimeikuzdxUWbgYTmHY6SAIr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZjS0CnMoO09WU7gGAalNb0dnTKIhw8mvoZ4tjND9rrFBM2taEvbXWmiV4WK7VagEPQJqsLovykQjJdNz34hF7n/V8LCwrJGaOw7+jfAIFzfXhRTQXx+3kzif+qQjDP6n9B+omoMm6OIgg8mGN+Bd0gbbC3YaMbF6r4I9wECt9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j58WJyEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1C9C4CEFB;
	Thu, 18 Dec 2025 20:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088838;
	bh=DFI2unmuS+hMsUajG0CimeikuzdxUWbgYTmHY6SAIr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j58WJyEzqE3VXjMgm2xYG2NiYJa9PpZKefIQFH2YtZOjVmTS9MAVwJURn8MWkEnzI
	 pL72OWbW59zLFPSN6l21NdGJGSRbyvyug6bbipRh6Gg7APmQn6rtInYxI1IiH3xHgc
	 iVkPcTN7EwmBrCHCY1kuBDiDH5Fs3OW+YLyAqflrizDZAQ/dyIq/0c8VEXTAFeTGBi
	 NPH4HRwjOzp6tc3QCex9aiaD8HB+zomvaXdApL7d+MZfxogg5Vz7PNRg8+THp3+NPn
	 u44RIl4WOR5e+7RnNFQBJxawatWuhq+ECtW+X3YGZgEBWkf2JPMJzEmiWUpxb7T6DQ
	 X/abwh2PrXMAQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 11/36] lockd: Use xdrgen XDR functions for the NLMv4 TEST procedure
Date: Thu, 18 Dec 2025 15:13:21 -0500
Message-ID: <20251218201346.1190928-12-cel@kernel.org>
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

Replace the NLMPROC4_TEST entry in the nlm_procedures4 array with
an entry that uses the xdrgen-built XDR functions for that
procedure. Helper functions are introduced which will be used here
and in subsequent patches.

The .pc_argzero field is now set to zero for the NLMv4 TEST
procedure. The xdrgen decoders are trusted to initialize all
arguments in the argp->xdrgen field, making the early defensive
memset unnecessary. The remaining argp fields are cleared as needed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 149 ++++++++++++++++++++++++++++++++++++++++----
 fs/lockd/xdr4.h     |  14 +++++
 2 files changed, 151 insertions(+), 12 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 468aa5060462..59001c1b21c6 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -19,6 +19,68 @@
 
 #define NLMDBG_FACILITY		NLMDBG_CLIENT
 
+static struct nlm_host *
+nlm4svc_lookup_host(struct svc_rqst *rqstp, string caller, bool monitored)
+{
+	struct nlm_host *host;
+
+	if (!nlmsvc_ops)
+		return NULL;
+	host = nlmsvc_lookup_host(rqstp, caller.data, caller.len);
+	if (!host)
+		return NULL;
+	if (monitored && nsm_monitor(host) < 0) {
+		nlmsvc_release_host(host);
+		return NULL;
+	}
+	return host;
+}
+
+static __be32
+nlm4svc_lookup_file(struct svc_rqst *rqstp, struct nlm_host *host,
+		    struct nlm_lock *lock, struct nlm_file **filp,
+		    struct nlm4_lock *xdr_lock, unsigned char type)
+{
+	struct file_lock *fl = &lock->fl;
+	struct nlm_file *file = NULL;
+	__be32 error;
+
+	if (xdr_lock->fh.len > NFS_MAXFHSIZE)
+		return nlm_lck_denied_nolocks;
+	lock->fh.size = xdr_lock->fh.len;
+	memcpy(lock->fh.data, xdr_lock->fh.data, xdr_lock->fh.len);
+
+	lock->oh.len = xdr_lock->oh.len;
+	lock->oh.data = xdr_lock->oh.data;
+
+	lock->svid = xdr_lock->svid;
+	lock->lock_start = xdr_lock->l_offset;
+	lock->lock_len = xdr_lock->l_len;
+
+	if (lock->lock_start > OFFSET_MAX ||
+	    (lock->lock_len && ((lock->lock_len - 1) > (OFFSET_MAX - lock->lock_start))))
+		return nlm4_fbig;
+
+	locks_init_lock(fl);
+	fl->c.flc_type = type;
+	nlm4svc_set_file_lock_range(fl, lock->lock_start, lock->lock_len);
+
+	error = nlm_lookup_file(rqstp, &file, lock);
+	if (error)
+		return error;
+	*filp = file;
+
+	fl->c.flc_flags = FL_POSIX;
+	fl->c.flc_file = file->f_file[lock_to_openmode(fl)];
+	fl->c.flc_pid = current->tgid;
+	fl->fl_lmops = &nlmsvc_lock_operations;
+	nlmsvc_locks_init_private(fl, host, (pid_t)lock->svid);
+	if (!fl->c.flc_owner)
+		return nlm_lck_denied_nolocks;
+
+	return nlm_granted;
+}
+
 /*
  * Obtain client and file from arguments
  */
@@ -126,10 +188,73 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 	return rc;
 }
 
-static __be32
-nlm4svc_proc_test(struct svc_rqst *rqstp)
+/**
+ * nlm4svc_proc_test - TEST: Check for conflicting lock
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_drop_reply:		Do not send an RPC reply.
+ *
+ * Permissible procedure status codes:
+ *   %NLM4_GRANTED:		The server would be able to grant the
+ *				requested lock.
+ *   %NLM4_DENIED:		The requested lock conflicted with existing
+ *				lock reservations for the file.
+ *   %NLM4_DENIED_NOLOCKS:	The server could not allocate the resources
+ *				needed to process the request.
+ *   %NLM4_DENIED_GRACE_PERIOD:	The server has recently restarted and is
+ *				re-establishing existing locks, and is not
+ *				yet ready to accept normal service requests.
+ */
+static __be32 nlm4svc_proc_test(struct svc_rqst *rqstp)
 {
-	return __nlm4svc_proc_test(rqstp, rqstp->rq_resp);
+	struct nlm4_testargs_wrapper *argp = rqstp->rq_argp;
+	unsigned char type = argp->xdrgen.exclusive ? F_WRLCK : F_RDLCK;
+	struct nlm4_testres_wrapper *resp = rqstp->rq_resp;
+	struct nlm_file	*file = NULL;
+	struct nlm_lockowner *owner;
+	struct nlm_host	*host;
+
+	resp->xdrgen.cookie = argp->xdrgen.cookie;
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
+	owner = argp->lock.fl.c.flc_owner;
+	resp->xdrgen.stat.stat = nlmsvc_testlock(rqstp, file, host,
+						 &argp->lock, &resp->lock);
+	nlmsvc_put_lockowner(owner);
+
+	if (resp->xdrgen.stat.stat == nlm_lck_denied) {
+		struct nlm_lock *conf = &resp->lock;
+		struct nlm4_holder *holder = &resp->xdrgen.stat.u.holder;
+
+		holder->exclusive = (conf->fl.c.flc_type != F_RDLCK);
+		holder->svid = conf->svid;
+		holder->oh.len = conf->oh.len;
+		holder->oh.data = conf->oh.data;
+		holder->l_offset = conf->fl.fl_start;
+		if (conf->fl.fl_end == OFFSET_MAX)
+			holder->l_len = 0;
+		else
+			holder->l_len = conf->fl.fl_end - conf->fl.fl_start + 1;
+	}
+
+out:
+	if (file)
+		nlm_release_file(file);
+	nlmsvc_release_host(host);
+	return resp->xdrgen.stat.stat == nlm_drop_reply ?
+		rpc_drop_reply : rpc_success;
 }
 
 static __be32
@@ -521,15 +646,15 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "NULL",
 	},
-	[NLMPROC_TEST] = {
-		.pc_func = nlm4svc_proc_test,
-		.pc_decode = nlm4svc_decode_testargs,
-		.pc_encode = nlm4svc_encode_testres,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
-		.pc_ressize = sizeof(struct nlm_res),
-		.pc_xdrressize = Ck+St+2+No+Rg,
-		.pc_name = "TEST",
+	[NLMPROC4_TEST] = {
+		.pc_func	= nlm4svc_proc_test,
+		.pc_decode	= nlm4_svc_decode_nlm4_testargs,
+		.pc_encode	= nlm4_svc_encode_nlm4_testres,
+		.pc_argsize	= sizeof(struct nlm4_testargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= sizeof(struct nlm4_testres_wrapper),
+		.pc_xdrressize	= NLM4_nlm4_testres_sz,
+		.pc_name	= "TEST",
 	},
 	[NLMPROC_LOCK] = {
 		.pc_func = nlm4svc_proc_lock,
diff --git a/fs/lockd/xdr4.h b/fs/lockd/xdr4.h
index 7167ae50485c..03219801fcb4 100644
--- a/fs/lockd/xdr4.h
+++ b/fs/lockd/xdr4.h
@@ -17,6 +17,20 @@
 #define	nlm4_fbig		cpu_to_be32(NLM_FBIG)
 #define	nlm4_failed		cpu_to_be32(NLM_FAILED)
 
+struct nlm4_testargs_wrapper {
+	struct nlm4_testargs		xdrgen;
+	struct nlm_lock			lock;
+};
+
+static_assert(offsetof(struct nlm4_testargs_wrapper, xdrgen) == 0);
+
+struct nlm4_testres_wrapper {
+	struct nlm4_testres		xdrgen;
+	struct nlm_lock			lock;
+};
+
+static_assert(offsetof(struct nlm4_testres_wrapper, xdrgen) == 0);
+
 void	nlm4svc_set_file_lock_range(struct file_lock *fl, u64 off, u64 len);
 bool	nlm4svc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlm4svc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-- 
2.52.0


