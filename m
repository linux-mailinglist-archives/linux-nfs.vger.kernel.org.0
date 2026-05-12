Return-Path: <linux-nfs+bounces-21575-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB5zNkBuA2pS5wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21575-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:15:28 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BF80852726D
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B59E3055A67
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184D0377567;
	Tue, 12 May 2026 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+GrjqNv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97BB36CDE0
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609671; cv=none; b=DOwRTf/MlfjMZ4BPVI8OHbqAw7cxvzfXmk1DvFhVPB73ARsSfjT5HFGXVmkbEd4YPfTe6gI0RY5nHfYW58UGI4Wakr17EVZEEmw6coOFrBRSety0c4yfJlna+7+13/co0oKqYxVrYuF3A+R2vEi+lGyAZjefM1a//j43Dm0o5qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609671; c=relaxed/simple;
	bh=DtzLIwru2zik2i7VErwzHfXEBU5fbTyjZRfuEht99e0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OR68JinWLcPg/BFdjj23AHMV9Fezs4s6y/XYf4onuNGw2Fr7Vsk0k6yXPwSgNxXUfcPyouVWxDu/G2qnllmV/IVkr6MuPg3JNm1t24+4FJ+rJI/7gCKiVtqUHi25QmTMYZNYY9ofm5Yg+0QqF3+Aft/2AKN6rgBfGpK69AzdPf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+GrjqNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F31C2BCF5;
	Tue, 12 May 2026 18:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609670;
	bh=DtzLIwru2zik2i7VErwzHfXEBU5fbTyjZRfuEht99e0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C+GrjqNvTQaJxngpGh1/5P0ortBwr2+XLSXW/fD+rL90jQlUvJODCicz27d4Sjfe8
	 LBapuqqmbDdCeO3IjZyLAp31ZTd89ersnAptxHdDxgm541RSRthc/2Iga2fhuUoYgi
	 xCsbLqkJ/n99IvIv0aqval9luj14lKHIvx5I3kWwX0eBxl9vPCEUIpiT9potA08axk
	 oBdU6A0onRQeiZzPwhmZOuF8yoht+klZF/TVdnIjXcr2sYj1RNtap4xlwM9dz4V243
	 lPnlYOHHzExmC/1k4cDfWKXX1xRHgiD/c7w/pO771dyjxuIn+uo464LD+6IQRen/B2
	 08+vrCB8wuH9w==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:14:10 -0400
Subject: [PATCH 35/38] lockd: Use xdrgen XDR functions for the NLMv3
 FREE_ALL procedure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-35-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=5772;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=H7BRW9Ci86txcR+pwd0Z51xWT6wlJm9nM47rfx7BuxU=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23n/jJL3dEFFlW5xqAiufcWndiPuSSOp1Wkz
 j+677JEZOWJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5wAKCRAzarMzb2Z/
 lxYtEACm5V+P6tWzfcfMjcF4cr3/vBhVcwyKSDZ3JbI/f0Qc+wES/NG6lUqACJewWN/FHf/Utwl
 xHAknqam90zwQUZOn0aTtEM7hAwCK6agO5Qga4fzU935blTLOY51XHgnTc5ndyuAvVDf85f1R2s
 N0tyLcWgo9a8p3c5FumxMTzHC4Rb15eEZilE8ifpaOhR0soh6XIV+rq82eORm0jKPVeXPlwGoqD
 BXRxZGiawNpp+DS7mZVklD/WUSGvy+ygj/m+sKs/SCO98to7ZGaZawqZSo2PTW6rCdMGRAx76xU
 FTuDgFjERrpVFt4ZQ2xgeA7GnsIFwl9IvNl4HRgKy0Hj/ml2vzXQFHyLK5lsVHT0EQDYt+Jw2D9
 66Xe+HBkcMLR8fRV/LP+vyw/RTNeFNiK7F7blu9p95UeQNcNiwmBTURuOSV0j0a1jkvfWHZRLWw
 L1nuzEmCC8j2mqgeQdYbc7UHIi39NAd3+ailV/NJ9EdazOvK3uXfh4/obPzNG7H/6dtSckCVzxW
 YaWIRJ34VfJ52BHo9bA4x5cYphgs8zUf38NZwQIe1D5sRRh9eRHxyagaJmbi5q6TreELpi/JH0K
 KBpsJ9sgDR7yJfA1MiL8xwkMok4FQVaHl145pR8iolyfeNX4gwjdqb8kpor4Wd7XeREbi8QO9Ve
 BUvqml+DG6DDXWA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: BF80852726D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21575-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

With all other NLMv3 procedures now converted to xdrgen-generated
XDR functions, the FREE_ALL procedure can be converted as well.
This conversion allows the removal of nlmsvc_retrieve_args(),
a 52-line helper function that was used only by FREE_ALL to
retrieve client information from lockd's internal data
structures.

Replace the NLMPROC_FREE_ALL entry in the nlmsvc_procedures
array with an entry that uses xdrgen-built XDR decoders and
encoders. The procedure handler is updated to use the new
wrapper structure (nlm_notify_wrapper) and call
nlm3svc_lookup_host() directly, eliminating the need for the
now-removed helper function.

Setting pc_argzero to zero is safe because the generated decoder
fills the argp->xdrgen subfields before the procedure runs, so the
zeroing memset performed by the dispatch layer is not needed. The
nlm_notify_wrapper structure has no members beyond the xdrgen
substructure, so no further initialization is required.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcproc.c | 113 ++++++++++++++++-------------------------------------
 1 file changed, 33 insertions(+), 80 deletions(-)

diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 4ca0eaef2966..ef1ae701b43b 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -100,6 +100,12 @@ struct nlm_shareres_wrapper {
 
 static_assert(offsetof(struct nlm_shareres_wrapper, xdrgen) == 0);
 
+struct nlm_notify_wrapper {
+	struct nlm_notify		xdrgen;
+};
+
+static_assert(offsetof(struct nlm_notify_wrapper, xdrgen) == 0);
+
 static __be32
 nlm_netobj_to_cookie(struct lockd_cookie *cookie, netobj *object)
 {
@@ -240,68 +246,6 @@ static inline __be32 cast_status(__be32 status)
 }
 #endif
 
-/*
- * Obtain client and file from arguments
- */
-static __be32
-nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct lockd_args *argp,
-			struct nlm_host **hostp, struct nlm_file **filp)
-{
-	struct nlm_host		*host = NULL;
-	struct nlm_file		*file = NULL;
-	struct lockd_lock	*lock = &argp->lock;
-	bool			is_test = (rqstp->rq_proc == NLMPROC_TEST ||
-					   rqstp->rq_proc == NLMPROC_TEST_MSG);
-	int			mode;
-	__be32			error = 0;
-
-	/* nfsd callbacks must have been installed for this procedure */
-	if (!nlmsvc_ops)
-		return nlm_lck_denied_nolocks;
-
-	/* Obtain host handle */
-	if (!(host = nlmsvc_lookup_host(rqstp, lock->caller, lock->len))
-	 || (argp->monitor && nsm_monitor(host) < 0))
-		goto no_locks;
-	*hostp = host;
-
-	/* Obtain file pointer. Not used by FREE_ALL call. */
-	if (filp != NULL) {
-		mode = lock_to_openmode(&lock->fl);
-
-		if (is_test)
-			mode = O_RDWR;
-
-		error = cast_status(nlm_lookup_file(rqstp, &file, lock, mode));
-		if (error != 0)
-			goto no_locks;
-		*filp = file;
-
-		/* Set up the missing parts of the file_lock structure */
-		lock->fl.c.flc_flags = FL_POSIX;
-		if (is_test)
-			lock->fl.c.flc_file = nlmsvc_file_file(file);
-		else
-			lock->fl.c.flc_file = file->f_file[mode];
-		lock->fl.c.flc_pid = current->tgid;
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
-	if (error)
-		return error;
-	return nlm_lck_denied_nolocks;
-}
-
 /**
  * nlmsvc_proc_null - NULL: Test for presence of service
  * @rqstp: RPC transaction context
@@ -1216,21 +1160,30 @@ static __be32 nlmsvc_proc_nm_lock(struct svc_rqst *rqstp)
 	return nlmsvc_do_lock(rqstp, false);
 }
 
-/*
- * FREE_ALL: Release all locks and shares held by client
+/**
+ * nlmsvc_proc_free_all - FREE_ALL: Discard client's lock and share state
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *
+ * RPC synopsis:
+ *   void NLMPROC_FREE_ALL(nlm_notify) = 23;
  */
-static __be32
-nlmsvc_proc_free_all(struct svc_rqst *rqstp)
+static __be32 nlmsvc_proc_free_all(struct svc_rqst *rqstp)
 {
-	struct lockd_args *argp = rqstp->rq_argp;
+	struct nlm_notify_wrapper *argp = rqstp->rq_argp;
 	struct nlm_host	*host;
 
-	/* Obtain client */
-	if (nlmsvc_retrieve_args(rqstp, argp, &host, NULL))
-		return rpc_success;
+	host = nlm3svc_lookup_host(rqstp, argp->xdrgen.name, false);
+	if (!host)
+		goto out;
 
 	nlmsvc_free_host_resources(host);
+
 	nlmsvc_release_host(host);
+
+out:
 	return rpc_success;
 }
 
@@ -1476,15 +1429,15 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_xdrressize	= NLM3_nlm_res_sz,
 		.pc_name	= "NM_LOCK",
 	},
-	[NLMPROC_FREE_ALL] = {
-		.pc_func = nlmsvc_proc_free_all,
-		.pc_decode = nlmsvc_decode_notify,
-		.pc_encode = nlmsvc_encode_void,
-		.pc_argsize = sizeof(struct lockd_args),
-		.pc_argzero = sizeof(struct lockd_args),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = 0,
-		.pc_name = "FREE_ALL",
+	[NLM_FREE_ALL] = {
+		.pc_func	= nlmsvc_proc_free_all,
+		.pc_decode	= nlm_svc_decode_nlm_notify,
+		.pc_encode	= nlm_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm_notify_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "FREE_ALL",
 	},
 };
 
@@ -1498,10 +1451,10 @@ union nlmsvc_xdrstore {
 	struct nlm_unlockargs_wrapper	unlockargs;
 	struct nlm_notifyargs_wrapper	notifyargs;
 	struct nlm_shareargs_wrapper	shareargs;
+	struct nlm_notify_wrapper	notify;
 	struct nlm_testres_wrapper	testres;
 	struct nlm_res_wrapper		res;
 	struct nlm_shareres_wrapper	shareres;
-	struct lockd_args		args;
 };
 
 /*

-- 
2.54.0


