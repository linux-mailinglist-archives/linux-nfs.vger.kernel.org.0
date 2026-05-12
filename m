Return-Path: <linux-nfs+bounces-21572-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGGaLAByA2q55wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21572-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:31:28 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5545A527B23
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57C1E330AE59
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803C637DEA6;
	Tue, 12 May 2026 18:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWpANMNn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3E2343D9D
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609668; cv=none; b=AWPKEIUCQOjSJmbZ3XrcpE+p+jyfESrAAqbTNoEGIBHevTF2CZDInjewv/ghm7bSuSw5/kv+250XACXPOgS5MCFhQk7QkZVnBLRJft+AFIOkhTZMEzQioNxR8lpvOoMTM5rQggmtMG943UdyY7Xzd+UOMAL6I+hhDPlvuCaBuMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609668; c=relaxed/simple;
	bh=5igmDKBTdydO1cCr4JaXDkLt5dbcxdFZ47PiauiyJX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rc/Ean4RcedyrA9GZ6AKTCaaLIzpsuRbDKTRprZPImrAOoYB9JWQdu0DD8YsVcDALEnFyVE5zFhwQ6Y45o9ndst8qp0f/q5gS6gOBManmnXQgqQg8iOizHaayvMjy6tCPztE/wWOYmzVjfdOPbBn4dyo0Hf+qS9oe/i2ZKGAZ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWpANMNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2A6C2BCF5;
	Tue, 12 May 2026 18:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609668;
	bh=5igmDKBTdydO1cCr4JaXDkLt5dbcxdFZ47PiauiyJX8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bWpANMNncnttHRqj3TYhb775NdCb5cZQT8uQytHPIJqxEefKdiB98pHPvH8MoDkHO
	 PjmiJ6KxGnbuXxAMR9dgHN7UVWmzJtPUHeqTIQ9StnygRvDKKqLs+yywylbvpz6JuX
	 nQ3F/OEWAdFd9jTK0kZzmdKe70FYYS6vZ/cUaGXZGvb4tDM9x91zGKIMdcKZqsBTVI
	 KN3Aeu78egMsBbmRqsGcD7M75TnaTy6DgTQjDg5/QJNt5Fwj5pL/7mLA4uVeRR6zEK
	 jDsmK6hNvrawbdFAMMrHdE4lo2BVJWTV8XoGsq2aSFOyhPVnRBN77GDlB2loGVXCXw
	 pTA4tTnXWp70Q==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:14:07 -0400
Subject: [PATCH 32/38] lockd: Use xdrgen XDR functions for the NLMv3 SHARE
 procedure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-32-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=6098;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=kYoJBYCwrerp4PV8M2arwU5QXvatP5Y+oUxdLC1+62c=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23mQXWiM+V+G89RBfgXxmgrIw2AT3klQkD65
 cRQ7Hq5V/+JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5gAKCRAzarMzb2Z/
 l6q4D/9sls8BLR8H/XjfTlUwryKabuPNixlFYYubjrHGUgRMzA17xGyJSUesabRnHWDGUSt/Lqr
 dkyFcCz4mGhYXvbLpJvrkvukbIdyyLMTPoskKfJwbKwvYohop4gLoPcRLgHC3ZZP5EnsCQLk+ga
 61BYfwaxzd5VWbhghn7cPN/kBIVD/OItZaZLIcEfo2w1+YIBJGLSbBy/FUkvhRRNZXqqCyWjsqN
 LucGuCxOXGf7PEm+5S6pTGXriSFKO0LCgOrSz1bqct9ta+SRn9kJTfNCgmxTsSUaS6WSk1lvIDU
 v8e+18n/LHEv3AUaluE6dYEog9IsWMTyofwPbQylW0Q3avYLT96BGJ8l6Y8pTT5ASV2hdTwxjsq
 iwD7MdpAadqCqGWN8NZUy9FALFg+MxYCW+GQvo0ojUxPzRxr/SkMuCcDYuqrwxltbTwsYcvqIRJ
 E5pmbxGy3SEnezkT7PiqkukHuguL20kJaPgXWuZx1x8mXOCOwMcJIa9AW8MhgKVsDtHz49/Kunc
 DYWO2f3cKhWQi8Bfr2Lw/xzduKFvdkYy1kNq5f5wnJiljhoIKVjKzaKJUYsiL+568yYvkeBIdrC
 FsDv1WjN6LKRgolV0EZkKJmNybybEaIP8ne/l1Mi3YXDpWfZueSCIwFaGqchHleqGh748/BuS7l
 A85PzNmJ/+aQlQg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 5545A527B23
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21572-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Convert the NLMv3 SHARE procedure to use xdrgen-generated XDR
functions nlm_svc_decode_nlm_shareargs and
nlm_svc_encode_nlm_shareres.

This patch introduces struct nlm_shareargs_wrapper and struct
nlm_shareres_wrapper to bridge between the xdrgen-generated
structures and the internal lockd types. The procedure handler
is updated to access arguments through the argp->xdrgen
hierarchy and uses nlm3svc_lookup_host and nlm3svc_lookup_file
for host and file resolution.

The .pc_argzero field is set to zero because the generated
decoder fills argp->xdrgen before the procedure runs, so the
zeroing memset performed by the dispatch layer is no longer
needed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcproc.c | 114 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 78 insertions(+), 36 deletions(-)

diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 79c410a75156..32625ee07c35 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -87,6 +87,19 @@ struct nlm_notifyargs_wrapper {
 
 static_assert(offsetof(struct nlm_notifyargs_wrapper, xdrgen) == 0);
 
+struct nlm_shareargs_wrapper {
+	struct nlm_shareargs		xdrgen;
+	struct lockd_lock		lock;
+};
+
+static_assert(offsetof(struct nlm_shareargs_wrapper, xdrgen) == 0);
+
+struct nlm_shareres_wrapper {
+	struct nlm_shareres		xdrgen;
+};
+
+static_assert(offsetof(struct nlm_shareres_wrapper, xdrgen) == 0);
+
 static __be32
 nlm_netobj_to_cookie(struct lockd_cookie *cookie, netobj *object)
 {
@@ -1079,42 +1092,69 @@ static __be32 nlmsvc_proc_unused(struct svc_rqst *rqstp)
 	return rpc_proc_unavail;
 }
 
-/*
- * SHARE: create a DOS share or alter existing share.
+/**
+ * nlmsvc_proc_share - SHARE: Open a file using DOS file-sharing modes
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_drop_reply:		Do not send an RPC reply.
+ *
+ * RPC synopsis:
+ *   nlm_shareres NLM_SHARE(nlm_shareargs) = 20;
+ *
+ * Permissible procedure status codes:
+ *   %LCK_GRANTED:		The requested share lock was granted.
+ *   %LCK_DENIED:		The requested lock conflicted with existing
+ *				lock reservations for the file.
+ *   %LCK_DENIED_GRACE_PERIOD:	The server has recently restarted and is
+ *				re-establishing existing locks, and is not
+ *				yet ready to accept normal service requests.
+ *
+ * The Linux NLM server implementation also returns:
+ *   %LCK_DENIED_NOLOCKS:	A needed resource could not be allocated.
  */
-static __be32
-nlmsvc_proc_share(struct svc_rqst *rqstp)
+static __be32 nlmsvc_proc_share(struct svc_rqst *rqstp)
 {
-	struct lockd_args *argp = rqstp->rq_argp;
-	struct lockd_res *resp = rqstp->rq_resp;
-	struct nlm_host	*host;
-	struct nlm_file	*file;
+	struct nlm_shareargs_wrapper *argp = rqstp->rq_argp;
+	struct nlm_shareres_wrapper *resp = rqstp->rq_resp;
+	struct lockd_lock *lock = &argp->lock;
+	struct nlm_host	*host = NULL;
+	struct nlm_file	*file = NULL;
+	struct nlm_lock xdr_lock = {
+		.fh		= argp->xdrgen.share.fh,
+		.oh		= argp->xdrgen.share.oh,
+		.uppid		= LOCKD_SHARE_SVID,
+	};
 
-	dprintk("lockd: SHARE         called\n");
+	resp->xdrgen.cookie = argp->xdrgen.cookie;
 
-	resp->cookie = argp->cookie;
+	resp->xdrgen.stat = nlm_lck_denied_grace_period;
+	if (locks_in_grace(SVC_NET(rqstp)) && !argp->xdrgen.reclaim)
+		goto out;
 
-	/* Don't accept new lock requests during grace period */
-	if (locks_in_grace(SVC_NET(rqstp)) && !argp->reclaim) {
-		resp->status = nlm_lck_denied_grace_period;
-		return rpc_success;
-	}
+	resp->xdrgen.stat = nlm_lck_denied_nolocks;
+	host = nlm3svc_lookup_host(rqstp, argp->xdrgen.share.caller_name, false);
+	if (!host)
+		goto out;
 
-	/* Obtain client and file */
-	if ((resp->status = nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
-		return resp->status == nlm__int__drop_reply ?
-			rpc_drop_reply : rpc_success;
+	resp->xdrgen.stat = nlm3svc_lookup_file(rqstp, host, lock, &file,
+						&xdr_lock, F_RDLCK);
+	if (resp->xdrgen.stat)
+		goto out;
 
-	/* Now try to create the share */
-	resp->status = cast_status(nlmsvc_share_file(host, file, &argp->lock.oh,
-						     argp->fsm_access,
-						     argp->fsm_mode));
+	resp->xdrgen.stat = nlmsvc_share_file(host, file, &lock->oh,
+					      argp->xdrgen.share.access,
+					      argp->xdrgen.share.mode);
 
-	dprintk("lockd: SHARE         status %d\n", ntohl(resp->status));
-	nlmsvc_release_lockowner(&argp->lock);
+	nlmsvc_release_lockowner(lock);
+
+out:
+	if (file)
+		nlm_release_file(file);
 	nlmsvc_release_host(host);
-	nlm_release_file(file);
-	return rpc_success;
+	return resp->xdrgen.stat == nlm__int__drop_reply ?
+		rpc_drop_reply : rpc_success;
 }
 
 /*
@@ -1398,15 +1438,15 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "UNUSED",
 	},
-	[NLMPROC_SHARE] = {
-		.pc_func = nlmsvc_proc_share,
-		.pc_decode = nlmsvc_decode_shareargs,
-		.pc_encode = nlmsvc_encode_shareres,
-		.pc_argsize = sizeof(struct lockd_args),
-		.pc_argzero = sizeof(struct lockd_args),
-		.pc_ressize = sizeof(struct lockd_res),
-		.pc_xdrressize = Ck+St+1,
-		.pc_name = "SHARE",
+	[NLM_SHARE] = {
+		.pc_func	= nlmsvc_proc_share,
+		.pc_decode	= nlm_svc_decode_nlm_shareargs,
+		.pc_encode	= nlm_svc_encode_nlm_shareres,
+		.pc_argsize	= sizeof(struct nlm_shareargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= sizeof(struct nlm_shareres_wrapper),
+		.pc_xdrressize	= NLM3_nlm_shareres_sz,
+		.pc_name	= "SHARE",
 	},
 	[NLMPROC_UNSHARE] = {
 		.pc_func = nlmsvc_proc_unshare,
@@ -1449,8 +1489,10 @@ union nlmsvc_xdrstore {
 	struct nlm_cancargs_wrapper	cancargs;
 	struct nlm_unlockargs_wrapper	unlockargs;
 	struct nlm_notifyargs_wrapper	notifyargs;
+	struct nlm_shareargs_wrapper	shareargs;
 	struct nlm_testres_wrapper	testres;
 	struct nlm_res_wrapper		res;
+	struct nlm_shareres_wrapper	shareres;
 	struct lockd_args		args;
 };
 

-- 
2.54.0


