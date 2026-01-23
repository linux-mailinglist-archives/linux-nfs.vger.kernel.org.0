Return-Path: <linux-nfs+bounces-18387-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECxtBuvDc2kCygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18387-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:35 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF1679D81
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6FB530498E6
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECB92877CF;
	Fri, 23 Jan 2026 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSype9kW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E030926B2D2
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194404; cv=none; b=sCgHM3rP0TVdzhyQjxlfvsEM4iRTqYdJelMOCcF5WKa1RBTChaCbTZUWCCC94FpyoeMsFQqxCWOrzYAeVB1nbQTVeHi8BhGmyQgc9SR9Rnbc439SOL+a4Oy4v/UV6s5QEHsJ0L1sMG1WbPejI36vQTaLREOEBMYTz305i7rGlMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194404; c=relaxed/simple;
	bh=qdx6H9I6LXr/ctG6I49eBN2pxAYccTCyAZnrkOOIuoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEK0yW+dGYQuXBUKC9BZcZUDomxPBjrVfvUUa6NZJyd/jbrh/ARSEUd8gGAxHF0n01BtrljNTQ7L1ZbDgzHFQcwA3OL12KR9Q6njAp7N+s8KvOGnBziA1i9jifzu8donHMhHyXLH2kxJX3p33xj/mn6YPxHsQBawTv4AONfvuPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSype9kW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B67C4CEF1;
	Fri, 23 Jan 2026 18:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194403;
	bh=qdx6H9I6LXr/ctG6I49eBN2pxAYccTCyAZnrkOOIuoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HSype9kWoJ1zHTiyh+UJG7gt9XO9pqPv3hCjvc91HFRXzPoMVvyx10fKTmMu5MZYR
	 Q4OIHqfaDdBBcvjp0R0diZ3tmyFxYJQVCOGfJv0HkYtORcOakwIrJDg33pqo9ByTUa
	 0jLtjVVth7ZBm4J9TpRk7dTav4Y5sGfcCUaSBIH/ppDX7mzrxp3OI4Y/zQyuFkfgK+
	 HiXc9sMIOxiTwnRFsbUPWoexViO2xmMcUsaW+d25TEtDpG8l6q+233CVWEv7gVzvP6
	 vATySLfi4LwWUevCd6nYfho0wC1O2eU0FXhc24+QhRNAcrwOiZjeR1TVyHwHnTOARB
	 jDhPNdQ9YBelg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 26/42] lockd: Use xdrgen XDR functions for the NLMv4 GRANTED_MSG procedure
Date: Fri, 23 Jan 2026 13:52:43 -0500
Message-ID: <20260123185259.1215767-27-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18387-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: BFF1679D81
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Convert the GRANTED_MSG procedure to use xdrgen functions
nlm4_svc_decode_nlm4_testargs and nlm4_svc_encode_void.
The procedure handler uses the nlm4_testargs_wrapper
structure that bridges between xdrgen types and the legacy
nlm_lock representation.

The pc_argzero field is set to zero because xdrgen decoders
reliably initialize all arguments, making the early
defensive memset unnecessary.

The NLM async callback mechanism uses client-side functions
which continue to take legacy struct nlm_res, preventing
GRANTED and GRANTED_MSG from sharing code for now.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 78 ++++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 33 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index dafc1ea70cd7..171ee5ff2289 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -579,23 +579,6 @@ nlm4svc_proc_unlock(struct svc_rqst *rqstp)
 		rpc_drop_reply : rpc_success;
 }
 
-/*
- * GRANTED: A server calls us to tell that a process' lock request
- * was granted
- */
-static __be32
-__nlm4svc_proc_granted(struct svc_rqst *rqstp, struct nlm_res *resp)
-{
-	struct nlm_args *argp = rqstp->rq_argp;
-
-	resp->cookie = argp->cookie;
-
-	dprintk("lockd: GRANTED       called\n");
-	resp->status = nlmclnt_grant(svc_addr(rqstp), &argp->lock);
-	dprintk("lockd: GRANTED       status %d\n", ntohl(resp->status));
-	return rpc_success;
-}
-
 /**
  * nlm4svc_proc_granted - GRANTED: Server grants a previously blocked lock
  * @rqstp: RPC transaction context
@@ -923,19 +906,48 @@ static __be32 nlm4svc_proc_unlock_msg(struct svc_rqst *rqstp)
 				__nlm4svc_proc_unlock_msg);
 }
 
+static __be32
+__nlm4svc_proc_granted_msg(struct svc_rqst *rqstp, struct nlm_res *resp)
+{
+	struct nlm4_testargs_wrapper *argp = rqstp->rq_argp;
+
+	resp->status = nlm_lck_denied;
+	if (nlm4_netobj_to_cookie(&resp->cookie, &argp->xdrgen.cookie))
+		goto out;
+
+	if (nlm4_lock_to_nlm_lock(&argp->lock, &argp->xdrgen.alock))
+		goto out;
+
+	resp->status = nlmclnt_grant(svc_addr(rqstp), &argp->lock);
+
+out:
+	return rpc_success;
+}
+
+/**
+ * nlm4svc_proc_granted_msg - GRANTED_MSG: Blocked lock has been granted
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_system_err:		RPC execution failed.
+ *
+ * RPC synopsis:
+ *   void NLMPROC4_GRANTED_MSG(nlm4_testargs) = 10;
+ *
+ * The response to this request is delivered via the GRANTED_RES procedure.
+ */
 static __be32 nlm4svc_proc_granted_msg(struct svc_rqst *rqstp)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
-	struct nlm_host	*host;
+	struct nlm4_testargs_wrapper *argp = rqstp->rq_argp;
+	struct nlm_host *host;
 
-	dprintk("lockd: GRANTED_MSG   called\n");
-
-	host = nlmsvc_lookup_host(rqstp, argp->lock.caller, argp->lock.len);
+	host = nlm4svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, false);
 	if (!host)
 		return rpc_system_err;
 
-	return nlm4svc_callback(rqstp, host, NLMPROC_GRANTED_RES,
-				__nlm4svc_proc_granted);
+	return nlm4svc_callback(rqstp, host, NLMPROC4_GRANTED_RES,
+				__nlm4svc_proc_granted_msg);
 }
 
 /*
@@ -1197,15 +1209,15 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "UNLOCK_MSG",
 	},
-	[NLMPROC_GRANTED_MSG] = {
-		.pc_func = nlm4svc_proc_granted_msg,
-		.pc_decode = nlm4svc_decode_testargs,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "GRANTED_MSG",
+	[NLMPROC4_GRANTED_MSG] = {
+		.pc_func	= nlm4svc_proc_granted_msg,
+		.pc_decode	= nlm4_svc_decode_nlm4_testargs,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm4_testargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "GRANTED_MSG",
 	},
 	[NLMPROC_TEST_RES] = {
 		.pc_func = nlm4svc_proc_null,
-- 
2.52.0


