Return-Path: <linux-nfs+bounces-18993-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yG4AKBnnlGmjIgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18993-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:09:29 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEF1151536
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E9B0306824C
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 22:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DA3313555;
	Tue, 17 Feb 2026 22:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nqy+EZPU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCBD313276
	for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 22:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366054; cv=none; b=JFza2XBvmONWX5BV0ke9w+lnyVcrChtJR7Y+eiF37r2wS8PUjWH7ttAzl3mW/mLu3NZxhYQjFdbzIVI4IVVYXgkLOBp0WyXzr6XNUnphNamDGHQ1PJPbBzxRfa1krTfHdXZai1Fm9gN8PKfIqdHMz6BQvdZN1qx165hTrHEe6xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366054; c=relaxed/simple;
	bh=dypMUzLQ4dz3LdLWNsVJKDTPpff9ydikcJYoZCMCefw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXPx/lY6/9wdcERkyZfbwLBF5YiXs1eE+DpRBBCqy+E/viJhRJkiIpStzFSR5IFj+X5Fvei+JwVyQcu6WeCQkUvM17J2iEGLpDrbxCiAoXw3o3/KwLxFAV/l/oqaYdJC2fKqkMKqp9guGwOClk9lIscyxcoa4Ajj/R+/tGyh4cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nqy+EZPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CD2C19421;
	Tue, 17 Feb 2026 22:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771366054;
	bh=dypMUzLQ4dz3LdLWNsVJKDTPpff9ydikcJYoZCMCefw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nqy+EZPUZdT3jmuVCYMWp3dS1XBoa2mEB5bK8n7NhErdl2Xk7lL42TKWUB9ejIvJn
	 7Sc1hlDA2X6JjhVm0bxbLoY0yvIe4RbB5ETVwmdKUFpr1BC1Y6SAZijhd68/0DAlMF
	 rWNeSceMquzgQ1n1FvJ4kmQXKxxobwrVSiNr4lvNiPAg60L2QERIl4dQ+W9Ab9RB2R
	 gK0AHqZiU3R/ABSEjXip3tqlQnF7pdx175wEkniXjathsxYKswzj4IznG5SOYlmsmA
	 gEPaKigrp9Ro3DIH+M0cQivI9N5huYXjIcv6rt61j+XjcqNjN7gUAcYtgITySGRh8S
	 K5zA+X3HJ2EmA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 10/29] lockd: Use xdrgen XDR functions for the NLMv4 LOCK_MSG procedure
Date: Tue, 17 Feb 2026 17:07:02 -0500
Message-ID: <20260217220721.1928847-11-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-18993-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 4EEF1151536
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The LOCK_MSG procedure is part of NLM's asynchronous lock
request flow, where clients send LOCK_MSG to request locks
that may block. This patch continues the xdrgen migration by
converting LOCK_MSG to use generated XDR functions.

This patch converts the LOCK_MSG procedure to use xdrgen
functions nlm4_svc_decode_nlm4_lockargs and
nlm4_svc_encode_void generated from the NLM version 4
protocol specification. The procedure handler uses xdrgen
types through the nlm4_lockargs_wrapper structure that
bridges between generated code and the legacy nlm_lock
representation.

The pc_argzero field is set to zero because xdrgen decoders
reliably initialize all arguments in the argp->xdrgen field,
making the early defensive memset unnecessary. Remaining
argp fields are cleared as needed.

The NLM async callback mechanism uses client-side functions
which continue to take legacy results like struct nlm_res,
preventing LOCK and LOCK_MSG from sharing code for now.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 77 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 61 insertions(+), 16 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index afce778b62d3..d9406a4ab176 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -812,19 +812,64 @@ static __be32 nlm4svc_proc_test_msg(struct svc_rqst *rqstp)
 				__nlm4svc_proc_test_msg);
 }
 
+static __be32
+__nlm4svc_proc_lock_msg(struct svc_rqst *rqstp, struct nlm_res *resp)
+{
+	struct nlm4_lockargs_wrapper *argp = rqstp->rq_argp;
+	unsigned char type = argp->xdrgen.exclusive ? F_WRLCK : F_RDLCK;
+	struct nlm_file	*file = NULL;
+	struct nlm_host	*host = NULL;
+
+	resp->status = nlm_lck_denied_nolocks;
+	if (nlm4_netobj_to_cookie(&resp->cookie, &argp->xdrgen.cookie))
+		goto out;
+
+	host = nlm4svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, true);
+	if (!host)
+		goto out;
+
+	resp->status = nlm4svc_lookup_file(rqstp, host, &argp->lock,
+					   &file, &argp->xdrgen.alock, type);
+	if (resp->status)
+		goto out;
+
+	resp->status = nlmsvc_lock(rqstp, file, host, &argp->lock,
+				   argp->xdrgen.block, &resp->cookie,
+				   argp->xdrgen.reclaim);
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
+ * nlm4svc_proc_lock_msg - LOCK_MSG: Establish a monitored lock
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_system_err:		RPC execution failed.
+ *
+ * RPC synopsis:
+ *   void NLMPROC4_LOCK_MSG(nlm4_lockargs) = 7;
+ *
+ * The response to this request is delivered via the LOCK_RES procedure.
+ */
 static __be32 nlm4svc_proc_lock_msg(struct svc_rqst *rqstp)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
-	struct nlm_host	*host;
+	struct nlm4_lockargs_wrapper *argp = rqstp->rq_argp;
+	struct nlm_host *host;
 
-	dprintk("lockd: LOCK_MSG      called\n");
-
-	host = nlmsvc_lookup_host(rqstp, argp->lock.caller, argp->lock.len);
+	host = nlm4svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, true);
 	if (!host)
 		return rpc_system_err;
 
-	return nlm4svc_callback(rqstp, host, NLMPROC_LOCK_RES,
-				__nlm4svc_proc_lock);
+	return nlm4svc_callback(rqstp, host, NLMPROC4_LOCK_RES,
+				__nlm4svc_proc_lock_msg);
 }
 
 static __be32 nlm4svc_proc_cancel_msg(struct svc_rqst *rqstp)
@@ -1103,15 +1148,15 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "TEST_MSG",
 	},
-	[NLMPROC_LOCK_MSG] = {
-		.pc_func = nlm4svc_proc_lock_msg,
-		.pc_decode = nlm4svc_decode_lockargs,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "LOCK_MSG",
+	[NLMPROC4_LOCK_MSG] = {
+		.pc_func	= nlm4svc_proc_lock_msg,
+		.pc_decode	= nlm4_svc_decode_nlm4_lockargs,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm4_lockargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "LOCK_MSG",
 	},
 	[NLMPROC_CANCEL_MSG] = {
 		.pc_func = nlm4svc_proc_cancel_msg,
-- 
2.53.0


