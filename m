Return-Path: <linux-nfs+bounces-18994-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CrkGx7nlGmjIgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18994-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:09:34 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BB015153D
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D80C30699A8
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 22:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD67313E1B;
	Tue, 17 Feb 2026 22:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyUzF3TF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC76313276
	for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 22:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366055; cv=none; b=YCGP5W3hbOkgMNAy3ZX7d+DCYi8nUA+dPfNtFb47/sA9mjZWPMEJKhp8K5kfrai7Mw28SoUyjK6R4dibpwQjbwfMFBRG1DIKb68H3gBiS7ZteodB3KP39GYcH9Cr2a910j8UpSucFPx4vbaC28gz63V1g2+om0p3lNj576rwYeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366055; c=relaxed/simple;
	bh=EUER0GHQxwW01h9ljdhoW8nAazzT/fwHmYUurdAdK7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPaA7AXyfvczScdQCn/AST19H84xaU6z6BzBAMg4U5h5UI9Rw2//hGLesYO3njKSNrds9d4E2mUVcrYIAsIudBjiboinW9aNlmUK0rYxx2PfJC3ERRkP5Vd63615+JFnp0VQ3K8o4/LcryrwRO7XYYWYWP5DpAWf0Fw3EOI6MzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyUzF3TF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D9DC19425;
	Tue, 17 Feb 2026 22:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771366055;
	bh=EUER0GHQxwW01h9ljdhoW8nAazzT/fwHmYUurdAdK7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pyUzF3TF9fTjGMlu4U6TyiDVeDIVPTFqRwVyHUPl4z99u35e/IXYYzkbBVMMobbmY
	 NIxiw7HH7tdAGjfRXbI9LWkCwYMRc+EPtuxhD8GNnP7ILJjA+NrlXwpdvYOkmOY/dA
	 Mq2AOqdGV0xITk28t7x6gKOppOHt2Xls5UlI9fKp1pxTI3ugVWLgTZ040m+5USWr2y
	 /JkifpMmdncCaKYbjrd/CUeNA2hXIknJ4JIclM/if4UB/fgXe3mxO/a7li1uchCZO4
	 o21/3fwJDdn2lMhU9FgReoiRgWYSMYKyNMvS97o4H5JrMqNo6kDC5XB3xi1Hh0amv1
	 G0H+oaIX+omrw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 11/29] lockd: Use xdrgen XDR functions for the NLMv4 CANCEL_MSG procedure
Date: Tue, 17 Feb 2026 17:07:03 -0500
Message-ID: <20260217220721.1928847-12-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217220721.1928847-1-cel@kernel.org>
References: <20260217220721.1928847-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-18994-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5BB015153D
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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 113 +++++++++++++++++++++++++-------------------
 1 file changed, 65 insertions(+), 48 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index d9406a4ab176..01e21b0a8956 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -459,38 +459,6 @@ nlm4svc_proc_lock(struct svc_rqst *rqstp)
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
-		return resp->status == nlm__int__drop_reply ?
-			rpc_drop_reply : rpc_success;
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
@@ -872,19 +840,68 @@ static __be32 nlm4svc_proc_lock_msg(struct svc_rqst *rqstp)
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
+	return resp->status == nlm__int__drop_reply ?
+		rpc_drop_reply : rpc_success;
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
@@ -1158,15 +1175,15 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
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
2.53.0


