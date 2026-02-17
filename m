Return-Path: <linux-nfs+bounces-18996-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4M3JIybnlGmjIgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18996-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:09:42 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 240E415154C
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11ECC306C518
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 22:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C0B314A62;
	Tue, 17 Feb 2026 22:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUTpQzL2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20360313276
	for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 22:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366057; cv=none; b=L6ASpuPfuhu9AelAA7hb7N5FAzp30ZnidrrTMx+Gl5VrTro2g5naV97DLqjWd8dLilsoBX6AdcDkzQ8i5fJFKWUt933VsBPy2/sbXD7dmHSarK/Q6Uu0YzLjPEGGWAT1ghPCOE/+/yM0LTOVo1oEZEjBfindkT8nh/ydrusyMSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366057; c=relaxed/simple;
	bh=wXaoZy7KDdC2FXE46XK4IY/rMFwv00bBV0CrS6jhFSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZc0RVoifSEVg5pIZ4Gf4lOPugXeeQD0MGA3IB+NypktmeFvcQH8fGK2u0Cw5PAkzowq9Cl38oTkwvxtGLgTqVRTj1+fSSca8MPnH6dMI8D2OOR0seoB74I5Jer2jMnBQF3HPTW+be5/oAdsBrBWPln+cdQ31rO/Indx9ppx5KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUTpQzL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42869C19421;
	Tue, 17 Feb 2026 22:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771366056;
	bh=wXaoZy7KDdC2FXE46XK4IY/rMFwv00bBV0CrS6jhFSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kUTpQzL28OcOzZhh/UY/mUhYycHdLNDqrvEPpfaCsN+R7T3yjB7O2OjLof8HmcSaj
	 DKTcYHuxoQViz2g8NHZkt0mXqpjV6+LsDjT79MfKSP2UTYFJFsnCWBs3H6BQlMJ0U9
	 DQVNkRyQcpIPWVnY0wPsN8dyWv7FydRm7qDI1owBr496V7WK9e3jea/rByT208d7n0
	 ak+8j0svmGtTzlG7TRPb7l24lhel0OAz+JmHGyZpTeiwTiIkPgpjicrx0BU7OfQQQa
	 TWQ/TSjh+pA7lfAEvkEbY3SvQF+6gwPLX5Iun2EKlA+K3myZfBGDf/rj9Z3GQgE3g5
	 3HjrqUWvrD5Aw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 13/29] lockd: Use xdrgen XDR functions for the NLMv4 GRANTED_MSG procedure
Date: Tue, 17 Feb 2026 17:07:05 -0500
Message-ID: <20260217220721.1928847-14-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-18996-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 240E415154C
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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 78 ++++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 33 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index c42c641dc5b6..306ecc21154e 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -585,23 +585,6 @@ nlm4svc_proc_unlock(struct svc_rqst *rqstp)
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
@@ -932,19 +915,48 @@ static __be32 nlm4svc_proc_unlock_msg(struct svc_rqst *rqstp)
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
@@ -1208,15 +1220,15 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
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
2.53.0


