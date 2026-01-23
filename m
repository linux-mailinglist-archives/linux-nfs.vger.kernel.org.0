Return-Path: <linux-nfs+bounces-18385-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QL1WEN/Dc2kCygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18385-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:23 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A143E79D6C
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B178300A256
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A142C08C4;
	Fri, 23 Jan 2026 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRgQI/mC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78519288C20
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194402; cv=none; b=gwd0bEfKpvKyIlJNDLTwL9upgDst5Aznbaj1/6YpNNSOeYxNSCDHLFgaitujzE/PiR1tTMsNok2cF+Bi/0KSOjEwErUr1D4t2Ni7+1MVxwNr5+Ve2NhWFQI68Za69G47sS17qsOHXZE10JtMfkab7BKmGsvM3eAz29Qk47JDDBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194402; c=relaxed/simple;
	bh=7MTDiNnaYjacXBGZrmHxgfklPRkgebY/oW8wIE11NV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8vWGywkYE7jEeVL71bN6LFmUi6BQOzJHMAZLUXLnku1xOcsG6IwSSY9YQkfNr135Tf4kvKrCwtCcvpQjePwGsaXcvz6U05TuU+MRgiY7a9Y1GpdK8alSPVwsZ4F5ctuqM5jLZpqT2DGHAyzerxs+eILAUlWyQf5Z0nj7yGP6Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRgQI/mC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9458AC19424;
	Fri, 23 Jan 2026 18:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194402;
	bh=7MTDiNnaYjacXBGZrmHxgfklPRkgebY/oW8wIE11NV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qRgQI/mCliQ6fo52HbINoXXf7ffStrLGd7Yv2n3v9V54CN5AnyjM6DBeBPeK10B0F
	 OlYD2QVprQ19N3Skg/9/twbzJizawoWabN4a4tbvmcd6DSJ83ZeQFvaARb8ml3OFcL
	 asGingWpfqBm8ZwT9zaPaeNHchBeD1CE3OQpB12W0dAieYHmexO0x5zqaXiBfxsShB
	 yp6ZIzLREHsmSedxFpu9WBy1nYJUxHKToRYNCGJ3PmKwDL2QNS1Lnb/WTy4hX3ttMZ
	 5WyXaAIAi1B1tLUp11B/239yeuf+tpxPUFNWUC+xEjwHtmjeXQH62lwdQkoXYp0JcY
	 uARkm1mzGlEzQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 24/42] lockd: Use xdrgen XDR functions for the NLMv4 CANCEL_MSG procedure
Date: Fri, 23 Jan 2026 13:52:41 -0500
Message-ID: <20260123185259.1215767-25-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18385-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: A143E79D6C
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The CANCEL_MSG procedure is part of NLM's asynchronous lock
request flow, where clients send CANCEL_MSG to cancel pending
lock requests. This patch continues the xdrgen migration by
converting CANCEL_MSG to use generated XDR functions.

This patch converts the CANCEL_MSG procedure to use xdrgen
functions nlm4_svc_decode_nlm4_cancargs and
nlm4_svc_encode_void generated from the NLM version 4 protocol
specification. The procedure handler uses xdrgen types through
the nlm4_cancargs_wrapper structure that bridges between
generated code and the legacy nlm_lock representation.

The pc_argzero field is set to zero because xdrgen decoders
reliably initialize all arguments in the argp->xdrgen field,
making the early defensive memset unnecessary. Remaining argp
fields are cleared as needed.

The NLM async callback mechanism uses client-side functions
which continue to take legacy results like struct nlm_res,
preventing CANCEL and CANCEL_MSG from sharing code for now.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 111 +++++++++++++++++++++++++-------------------
 1 file changed, 64 insertions(+), 47 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 7ab458648637..4c983a04e9f1 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -453,37 +453,6 @@ nlm4svc_proc_lock(struct svc_rqst *rqstp)
 	return nlm4svc_do_lock(rqstp, true);
 }
 
-static __be32
-__nlm4svc_proc_cancel(struct svc_rqst *rqstp, struct nlm_res *resp)
-{
-	struct nlm_args *argp = rqstp->rq_argp;
-	struct nlm_host	*host;
-	struct nlm_file	*file;
-
-	dprintk("lockd: CANCEL        called\n");
-
-	resp->cookie = argp->cookie;
-
-	/* Don't accept requests during grace period */
-	if (locks_in_grace(SVC_NET(rqstp))) {
-		resp->status = nlm_lck_denied_grace_period;
-		return rpc_success;
-	}
-
-	/* Obtain client and file */
-	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
-		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
-
-	/* Try to cancel request. */
-	resp->status = nlmsvc_cancel_blocked(SVC_NET(rqstp), file, &argp->lock);
-
-	dprintk("lockd: CANCEL        status %d\n", ntohl(resp->status));
-	nlmsvc_release_lockowner(&argp->lock);
-	nlmsvc_release_host(host);
-	nlm_release_file(file);
-	return rpc_success;
-}
-
 /**
  * nlm4svc_proc_cancel - CANCEL: Cancel an outstanding blocked lock request
  * @rqstp: RPC transaction context
@@ -863,19 +832,67 @@ static __be32 nlm4svc_proc_lock_msg(struct svc_rqst *rqstp)
 				__nlm4svc_proc_lock_msg);
 }
 
+static __be32
+__nlm4svc_proc_cancel_msg(struct svc_rqst *rqstp, struct nlm_res *resp)
+{
+	struct nlm4_cancargs_wrapper *argp = rqstp->rq_argp;
+	unsigned char type = argp->xdrgen.exclusive ? F_WRLCK : F_RDLCK;
+	struct net *net = SVC_NET(rqstp);
+	struct nlm_file	*file = NULL;
+	struct nlm_host	*host = NULL;
+
+	resp->status = nlm_lck_denied_nolocks;
+	if (nlm4_netobj_to_cookie(&resp->cookie, &argp->xdrgen.cookie))
+		goto out;
+
+	resp->status = nlm_lck_denied_grace_period;
+	if (locks_in_grace(net))
+		goto out;
+
+	resp->status = nlm_lck_denied_nolocks;
+	host = nlm4svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, false);
+	if (!host)
+		goto out;
+
+	resp->status = nlm4svc_lookup_file(rqstp, host, &argp->lock,
+					   &file, &argp->xdrgen.alock, type);
+	if (resp->status)
+		goto out;
+
+	resp->status = nlmsvc_cancel_blocked(net, file, &argp->lock);
+	nlmsvc_release_lockowner(&argp->lock);
+
+out:
+	if (file)
+		nlm_release_file(file);
+	nlmsvc_release_host(host);
+	return resp->status == nlm_drop_reply ? rpc_drop_reply : rpc_success;
+}
+
+/**
+ * nlm4svc_proc_cancel_msg - CANCEL_MSG: Cancel an outstanding lock request
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_system_err:		RPC execution failed.
+ *
+ * RPC synopsis:
+ *   void NLMPROC4_CANCEL_MSG(nlm4_cancargs) = 8;
+ *
+ * The response to this request is delivered via the CANCEL_RES procedure.
+ */
 static __be32 nlm4svc_proc_cancel_msg(struct svc_rqst *rqstp)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
-	struct nlm_host	*host;
+	struct nlm4_cancargs_wrapper *argp = rqstp->rq_argp;
+	struct nlm_host *host;
 
-	dprintk("lockd: CANCEL_MSG    called\n");
-
-	host = nlmsvc_lookup_host(rqstp, argp->lock.caller, argp->lock.len);
+	host = nlm4svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, false);
 	if (!host)
 		return rpc_system_err;
 
-	return nlm4svc_callback(rqstp, host, NLMPROC_CANCEL_RES,
-				__nlm4svc_proc_cancel);
+	return nlm4svc_callback(rqstp, host, NLMPROC4_CANCEL_RES,
+				__nlm4svc_proc_cancel_msg);
 }
 
 static __be32 nlm4svc_proc_unlock_msg(struct svc_rqst *rqstp)
@@ -1147,15 +1164,15 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "LOCK_MSG",
 	},
-	[NLMPROC_CANCEL_MSG] = {
-		.pc_func = nlm4svc_proc_cancel_msg,
-		.pc_decode = nlm4svc_decode_cancargs,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "CANCEL_MSG",
+	[NLMPROC4_CANCEL_MSG] = {
+		.pc_func	= nlm4svc_proc_cancel_msg,
+		.pc_decode	= nlm4_svc_decode_nlm4_cancargs,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm4_cancargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "CANCEL_MSG",
 	},
 	[NLMPROC_UNLOCK_MSG] = {
 		.pc_func = nlm4svc_proc_unlock_msg,
-- 
2.52.0


