Return-Path: <linux-nfs+bounces-18400-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEc4MgTEc2kpygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18400-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:55:00 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4657479DCF
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AE43302E7DA
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D50271469;
	Fri, 23 Jan 2026 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLITGsDn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320BB26F47D
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194414; cv=none; b=NFZkmo+smUnwcgSEjUMPHQYty4B3ubXYcaBo94ikNmErOe6BaQxvns6azhhhmYgtEf0viv/CM/XkJ6sNBGizgyy3NA1RxFXE+GfPDSm2QfuogY1zYz6yQkMzeIL397XALI8mmrg93rsfmZqkMIAXAPHDH5TdZONqszUS/uPUnro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194414; c=relaxed/simple;
	bh=q41keQbRwAhC5bMOYIZ6VDgzem1pz0AHiMXV9C3IJGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dL75lbnRSJF/V9TGwWzDw3PWpzAKkYIjvZsP/WOmVXvLsTW5M9w0IWuqeyiQrhpdyJFoRqSJ02+1+KO0It1xxdcWqkksZAHFXHGSKvyr07nY5TtjIEnGPiUTxoCTTZObkp11juE5bTcW9s4RSVWY+Gq2lQoBNuK317OdUW+ZmzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLITGsDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D14DC19424;
	Fri, 23 Jan 2026 18:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194414;
	bh=q41keQbRwAhC5bMOYIZ6VDgzem1pz0AHiMXV9C3IJGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cLITGsDnhxRm0V4bb9pabCX3fmaZ49gmdRjlfefhmLGuPAQTcfOZBBgxAfO3ehkZV
	 oQJPegB5HB0XPfchIeEOpI1K2j6v9LREqAGdTbGrz2tt2xusNoN8qFtUiVop7EjV6I
	 l7h087Nt+iGe82RqP5UKKlG2PqlwVa4ddr2LXd7SPvb0+1juLk9FqKUhzdy57wy1MO
	 rQnKkWKHFMX5O+rBdyHpQDum/FGT86Ab4Wajf0DhMFUA/DfkSu9hwCovzr6TORG0l/
	 Zs7DzQ4a1BM3o3caa/n5+3l56ulpsp42nco1msfmLJJXi+sK/ilWfOFMlqFeeB96wS
	 j08rf9Ap91BpQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 39/42] lockd: Use xdrgen XDR functions for the NLMv4 FREE_ALL procedure
Date: Fri, 23 Jan 2026 13:52:56 -0500
Message-ID: <20260123185259.1215767-40-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123185259.1215767-1-cel@kernel.org>
References: <20260123185259.1215767-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18400-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 4657479DCF
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

With all other NLMv4 procedures now converted to xdrgen-generated
XDR functions, the FREE_ALL procedure can be converted as well.
This conversion allows the removal of nlm4svc_retrieve_args(),
a 79-line helper function that was used only by FREE_ALL to
retrieve client information from lockd's internal data
structures.

Replace the NLMPROC4_FREE_ALL entry in the nlm_procedures4
array with an entry that uses xdrgen-built XDR decoders and
encoders. The procedure handler is updated to use the new
wrapper structure (nlm4_notify_wrapper) and call
nlm4svc_lookup_host() directly, eliminating the need for the
now-removed helper function.

The .pc_argzero field is set to zero because xdrgen decoders
fully initialize all fields in argp->xdrgen, making the early
defensive memset unnecessary. The remaining argp fields that
fall outside the xdrgen structures are cleared explicitly as
needed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 120 ++++++++++++--------------------------------
 1 file changed, 33 insertions(+), 87 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 76d259658604..6b1a80084d1a 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -69,6 +69,12 @@ struct nlm4_notifyargs_wrapper {
 
 static_assert(offsetof(struct nlm4_notifyargs_wrapper, xdrgen) == 0);
 
+struct nlm4_notify_wrapper {
+	struct nlm4_notify		xdrgen;
+};
+
+static_assert(offsetof(struct nlm4_notify_wrapper, xdrgen) == 0);
+
 struct nlm4_testres_wrapper {
 	struct nlm4_testres		xdrgen;
 	struct nlm_lock			lock;
@@ -191,75 +197,6 @@ nlm4svc_lookup_file(struct svc_rqst *rqstp, struct nlm_host *host,
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
-	switch (error) {
-	case nlm_granted:
-		return nlm_lck_denied_nolocks;
-	case nlm__int__stale_fh:
-		return nlm4_stale_fh;
-	case nlm__int__failed:
-		return nlm4_failed;
-	default:
-		return error;
-	}
-}
-
 /**
  * nlm4svc_proc_null - NULL: Test for presence of service
  * @rqstp: RPC transaction context
@@ -1183,21 +1120,30 @@ static __be32 nlm4svc_proc_nm_lock(struct svc_rqst *rqstp)
 	return nlm4svc_do_lock(rqstp, false);
 }
 
-/*
- * FREE_ALL: Release all locks and shares held by client
+/**
+ * nlm4svc_proc_free_all - FREE_ALL: Discard client's lock and share state
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *
+ * RPC synopsis:
+ *   void NLMPROC4_FREE_ALL(nlm4_notify) = 23;
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
 
@@ -1444,15 +1390,15 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
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
+		.pc_argsize	= sizeof(struct nlm4_notify_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "FREE_ALL",
 	},
 };
 
@@ -1466,10 +1412,10 @@ union nlm4svc_xdrstore {
 	struct nlm4_unlockargs_wrapper	unlockargs;
 	struct nlm4_notifyargs_wrapper	notifyargs;
 	struct nlm4_shareargs_wrapper	shareargs;
+	struct nlm4_notify_wrapper	notify;
 	struct nlm4_testres_wrapper	testres;
 	struct nlm4_res_wrapper		res;
 	struct nlm4_shareres_wrapper	shareres;
-	struct nlm_args			args;
 };
 
 static DEFINE_PER_CPU_ALIGNED(unsigned long,
-- 
2.52.0


