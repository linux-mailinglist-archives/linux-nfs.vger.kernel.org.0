Return-Path: <linux-nfs+bounces-18398-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMTdBtDDc2kCygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18398-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:08 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCF179D40
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0A603011A2B
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B776D257821;
	Fri, 23 Jan 2026 18:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCIe94t1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A2D29BD8C
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194412; cv=none; b=tN5aI7BPosr1ZM9czEZa4kgswQV7PG5vg+haQAfWNuTzBs+xEUFCqjLilw4z5hkS0BJpwSpXOyBhQZbVtFfahTHYlkgee+ba5D0GebKEnnfimf9L4YtuJw4/69pdmczPoUXbosqrkr2/1PUlhvvi/aOds4asUrEageOVMOIYduA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194412; c=relaxed/simple;
	bh=ZLVQ4xxKZamDFtuUQIpaUdDnli9mRArxMmYn6qArF/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOJXxkHA7WC0/3E4X5treloJ8QpGujuhX92JXD5suC6Je5lndfoyxR+MDdg8jYMEe2y4yPxQtbB8FV7zlKR6Ddy2roC8QWOO9Jhj9Pnd0mMn8DyRwTLvcAvWuMz+YiXJokpo84/XE14ymXExA/9GEJ3EEEI84KmNzKCjacLHlSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCIe94t1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDCFC19423;
	Fri, 23 Jan 2026 18:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194412;
	bh=ZLVQ4xxKZamDFtuUQIpaUdDnli9mRArxMmYn6qArF/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uCIe94t1IPU8uPH/u7YQzRwDcsCoIfGoKdvUkCyvU/T0S1YJvKvfCIx5hDxoetwPc
	 VkBwf8LQBunCG5bphEY2nsyjXvTGr8+nlTpNS0B0ElqvMGs36mUTYK6xcJ4qqEnXwX
	 rFub53fG+RPGJtJ3lQ7Q/CgcBrrDprQW625Ru12o1TaGGyfrK98lQX3GVeNcOTw8Mx
	 TISORCHZIJMLs/VRYJ5CAXii49i+uhcs2mQjLe1qivpEGDlTNdNh4jz2bXzbXpAhvW
	 v+AKcw5cxQQ6s8FwC+ejrVTsWF3qDcepqEktKPhS08LHeBrxIZ/jAkSF0C/m4PRslx
	 ZADv5Wo8wz3rA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 37/42] lockd: Use xdrgen XDR functions for the NLMv4 UNSHARE procedure
Date: Fri, 23 Jan 2026 13:52:54 -0500
Message-ID: <20260123185259.1215767-38-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18398-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: ECCF179D40
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Now that the share helpers have been decoupled from the
NLMv3-specific struct nlm_args and file_lock initialization
has been hoisted into the procedure handler, the NLMv4 UNSHARE
procedure can be converted to use xdrgen-generated XDR
functions.

Replace the NLMPROC4_UNSHARE entry in the nlm_procedures4
array with an entry that uses xdrgen-built XDR decoders and
encoders. The procedure handler is updated to use the new
wrapper structures (nlm4_shareargs_wrapper and
nlm4_shareres_wrapper) and access arguments through the
argp->xdrgen hierarchy.

The .pc_argzero field is set to zero because xdrgen decoders
fully initialize all fields in argp->xdrgen, making the early
defensive memset unnecessary. The remaining argp fields that
fall outside the xdrgen structures are cleared explicitly as
needed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 97 +++++++++++++++++++++++++++++----------------
 1 file changed, 62 insertions(+), 35 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 74a8821e2bce..316b4d623130 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -1115,43 +1115,70 @@ static __be32 nlm4svc_proc_share(struct svc_rqst *rqstp)
 		rpc_drop_reply : rpc_success;
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
+ * RPC synopsis:
+ *   nlm4_shareres NLMPROC4_UNSHARE(nlm4_shareargs) = 21;
+ *
+ * Permissible procedure status codes:
+ *   %NLM4_GRANTED:		The share reservation was released.
+ *   %NLM4_DENIED_GRACE_PERIOD:	The server has recently restarted and is
+ *				re-establishing existing locks, and is not
+ *				yet ready to accept normal service requests.
+ *
+ * The Linux NLM server implementation also returns:
+ *   %NLM4_DENIED_NOLOCKS:	A needed resource could not be allocated.
+ *   %NLM4_STALE_FH:		The request specified an invalid file handle.
+ *   %NLM4_FBIG:		The request specified a length or offset
+ *				that exceeds the range supported by the
+ *				server.
+ *   %NLM4_FAILED:		The request failed for an unspecified reason.
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
+	resp->xdrgen.stat = nlmsvc_unshare_file(host, file, &lock->oh);
 
-	dprintk("lockd: UNSHARE       status %d\n", ntohl(resp->status));
 	nlmsvc_release_lockowner(lock);
+
+out:
+	if (file)
+		nlm_release_file(file);
 	nlmsvc_release_host(host);
-	nlm_release_file(file);
-	return rpc_success;
+	return resp->xdrgen.stat == nlm_drop_reply ?
+		rpc_drop_reply : rpc_success;
 }
 
 /*
@@ -1409,15 +1436,15 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
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


