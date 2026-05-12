Return-Path: <linux-nfs+bounces-21563-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDOaHe1xA2q55wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21563-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:31:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A6A527AF2
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63457308FDCB
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE86634A773;
	Tue, 12 May 2026 18:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJpneKn/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2DB378D70
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609660; cv=none; b=bIq7dlBspBN6aFlK/IlN4J2ZWqnUoYJ9oBcaNxONQ9V9ZMa0vDZXnJdZ4CbPhepCJQIcj6t1bCqwBndNVFaaEwQIUPvrLnLcb6fKCE+7h7tFwwceDJJgieRvhiVhWFkCBVTSVbHm+6+PxTxLRmM0RQNlLWidDG95MkC/C1tXo7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609660; c=relaxed/simple;
	bh=KQyJ+vFKctn+8gaiak7X6unkvfI1qR2aNxyd2G/9GNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yp9RS62FFnTrkeKkqukUutiFGzQBLxnDtrVa5wiCEK6ClQlG3wZKMjeVbrQUgpfVKAb4hg+39g+CLMKnhvZwRTR5cocCGWpEmZ6OCNKNOnR8AmuEcvgvNzT9dS0Dt3HPKMD5REUyOAYmQyJZ2143LQ0PHBVgO5YhoxkfAWAnPsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJpneKn/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63C1C2BCC7;
	Tue, 12 May 2026 18:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609660;
	bh=KQyJ+vFKctn+8gaiak7X6unkvfI1qR2aNxyd2G/9GNc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZJpneKn/jRJKRLpgI3GlfdsmGBuu760uEoIJuVxcEGNVNk5q/YxvE9DD7ABdsAQMf
	 SIO7VF7Ts6vLNxtOPumCycfGStV8PHOR7oavh1+oGvhZDWh2f/rl8NnPYQq9aG9Jnx
	 tNVdWvaYinsdmED8pcy1GARGEYCRsYoNKKkVLOoTo0ATCAesBg0XCsdcZ+KKuP2HtV
	 UqxHo0vY8oTEefuAZru/BVcfCytwpCCJjhx4fu/BMECLxuIxclSZ8rrhwvjT8FcU2C
	 VX+lILZQGZk9PuXqZPl7uzt74tE6i4sF7ddLTRhagO5EpZhs3IUv8vfZCXi2xHHeDu
	 7bU9dpguxHW2w==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:13:58 -0400
Subject: [PATCH 23/38] lockd: Use xdrgen XDR functions for the NLMv3
 UNLOCK_MSG procedure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-23-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=5847;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=AxZiF/WMox8AcLa9paJUj1tijCk5rqSiXPvogO5oRmo=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23lTgU1kRrQnPl1pxSfopK70v3iKlnCmSUSI
 YS/D2n6sCGJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5QAKCRAzarMzb2Z/
 lzcND/4qwd6xRyrdFG4mYE2jdTgZzN92LJNtFPc0BeEiI0B1V/BRPSL+67Apd42iCVvraP4T0Ll
 xhYAW5R+jRsMrvxwfRbcMxDQsrmKinJ2Lx6KW41zCGoFPIiqcMEUq/AwLN5pDWRAw7slF5qilri
 xTsn0X454vTi0mx13vaNqYqQ0Jkc+PJHU4Qw0KIzRnYG07IAgv45iQHlwuG5L22seB/Vc3RkiIP
 0TFprMlSde52Y2R70GMwOvA1VpgK74uf+SvbbwSQPhDnrW9+ckkEZ9v7sQA5LZ1lKdhUvh6W8ET
 gkwF9m74e0AEFanwUIuXXo+yoDiswVa5VzuatPdO62MXY+P6hdWluoidlYRiHiQRvoxpbUeg9ta
 q597as6MtH/1tE10kL2/uEwOgK5onrMdbURMHYCiwiSswJw/7bs6kRPZp0Tcue50YY5XdJRG3CU
 h1Clu9hCjySSfQrfL8Lp+ndoaHrQmy65tzkYWPTT/2Pt9+O4W2x8zsVEUI6e8Zyb2mmNspa2lI7
 h4HE0adnJ6X+eQq0cdp5FjK/dDiC8V4I79lL3axap7zS2MS39QZG7r+treFJw0ycIOFjvbfsx3y
 IOcpmsJDA0h/HzyQ8kiUUvV72OLdRVJZ1NWLxx2WA7PBaJolKOWQHblcTkWsDTKEPPgzg1HR7X5
 XlTlUllzdj27KFQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: D6A6A527AF2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21563-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Continue the xdrgen migration by converting NLMv3 UNLOCK_MSG, the
async counterpart to UNLOCK that clients use to release locks
without waiting for a reply. The procedure now uses
nlm_svc_decode_nlm_unlockargs and nlm_svc_encode_void, generated
from the NLM version 3 protocol specification. The procedure
handler reaches the xdrgen types through the
nlm_unlockargs_wrapper structure, which bridges between generated
code and the legacy lockd_lock representation.

Setting pc_argzero to zero is safe because the generated decoder
fills the argp->xdrgen subfields before the procedure runs, so
the zeroing memset performed by the dispatch layer is not needed.
The lock member of the wrapper is populated explicitly in
nlm3svc_lookup_file() rather than relying on zero-initialization.

The NLM async callback mechanism uses client-side functions which
continue to take legacy results like struct lockd_res, preventing
UNLOCK and UNLOCK_MSG from sharing code for now.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcproc.c | 116 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 66 insertions(+), 50 deletions(-)

diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index d055079c9485..d059accfdebd 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -537,42 +537,6 @@ nlmsvc_proc_cancel(struct svc_rqst *rqstp)
 		rpc_drop_reply : rpc_success;
 }
 
-/*
- * UNLOCK: release a lock
- */
-static __be32
-__nlmsvc_proc_unlock(struct svc_rqst *rqstp, struct lockd_res *resp)
-{
-	struct lockd_args *argp = rqstp->rq_argp;
-	struct nlm_host	*host;
-	struct nlm_file	*file;
-	struct net *net = SVC_NET(rqstp);
-
-	dprintk("lockd: UNLOCK        called\n");
-
-	resp->cookie = argp->cookie;
-
-	/* Don't accept new lock requests during grace period */
-	if (locks_in_grace(net)) {
-		resp->status = nlm_lck_denied_grace_period;
-		return rpc_success;
-	}
-
-	/* Obtain client and file */
-	if ((resp->status = nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
-		return resp->status == nlm__int__drop_reply ?
-			rpc_drop_reply : rpc_success;
-
-	/* Now try to remove the lock */
-	resp->status = cast_status(nlmsvc_unlock(net, file, &argp->lock));
-
-	dprintk("lockd: UNLOCK        status %d\n", ntohl(resp->status));
-	nlmsvc_release_lockowner(&argp->lock);
-	nlmsvc_release_host(host);
-	nlm_release_file(file);
-	return rpc_success;
-}
-
 /**
  * nlmsvc_proc_unlock - UNLOCK: Remove a lock
  * @rqstp: RPC transaction context
@@ -935,19 +899,71 @@ static __be32 nlmsvc_proc_cancel_msg(struct svc_rqst *rqstp)
 			       __nlmsvc_proc_cancel_msg);
 }
 
+static __be32
+__nlmsvc_proc_unlock_msg(struct svc_rqst *rqstp, struct lockd_res *resp)
+{
+	struct nlm_unlockargs_wrapper *argp = rqstp->rq_argp;
+	struct net *net = SVC_NET(rqstp);
+	struct nlm_file	*file = NULL;
+	struct nlm_host	*host = NULL;
+
+	resp->status = nlm_lck_denied_nolocks;
+	if (nlm_netobj_to_cookie(&resp->cookie, &argp->xdrgen.cookie))
+		goto out;
+
+	resp->status = nlm_lck_denied_grace_period;
+	if (locks_in_grace(net))
+		goto out;
+
+	resp->status = nlm_lck_denied_nolocks;
+	host = nlm3svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, false);
+	if (!host)
+		goto out;
+
+	resp->status = nlm3svc_lookup_file(rqstp, host, &argp->lock,
+					   &file, &argp->xdrgen.alock, F_UNLCK);
+	if (resp->status)
+		goto out;
+
+	resp->status = nlmsvc_unlock(net, file, &argp->lock);
+	nlmsvc_release_lockowner(&argp->lock);
+
+out:
+	if (file)
+		nlm_release_file(file);
+	nlmsvc_release_host(host);
+	return resp->status == nlm__int__drop_reply ? rpc_drop_reply : rpc_success;
+}
+
+/**
+ * nlmsvc_proc_unlock_msg - UNLOCK_MSG: Remove an existing lock
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_drop_reply:		Do not send an RPC reply.
+ *   %rpc_garbage_args:	The request arguments are malformed.
+ *   %rpc_system_err:		RPC execution failed.
+ *
+ * RPC synopsis:
+ *   void NLMPROC_UNLOCK_MSG(nlm_unlockargs) = 9;
+ *
+ * The response to this request is delivered via the UNLOCK_RES procedure.
+ */
 static __be32 nlmsvc_proc_unlock_msg(struct svc_rqst *rqstp)
 {
-	struct lockd_args *argp = rqstp->rq_argp;
-	struct nlm_host	*host;
+	struct nlm_unlockargs_wrapper *argp = rqstp->rq_argp;
+	struct nlm_host *host;
 
-	dprintk("lockd: UNLOCK_MSG    called\n");
+	if (argp->xdrgen.cookie.len > NLM_MAXCOOKIELEN)
+		return rpc_garbage_args;
 
-	host = nlmsvc_lookup_host(rqstp, argp->lock.caller, argp->lock.len);
+	host = nlm3svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, false);
 	if (!host)
 		return rpc_system_err;
 
 	return nlmsvc_callback(rqstp, host, NLMPROC_UNLOCK_RES,
-			       __nlmsvc_proc_unlock);
+			       __nlmsvc_proc_unlock_msg);
 }
 
 static __be32 nlmsvc_proc_granted_msg(struct svc_rqst *rqstp)
@@ -1218,15 +1234,15 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "CANCEL_MSG",
 	},
-	[NLMPROC_UNLOCK_MSG] = {
-		.pc_func = nlmsvc_proc_unlock_msg,
-		.pc_decode = nlmsvc_decode_unlockargs,
-		.pc_encode = nlmsvc_encode_void,
-		.pc_argsize = sizeof(struct lockd_args),
-		.pc_argzero = sizeof(struct lockd_args),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "UNLOCK_MSG",
+	[NLM_UNLOCK_MSG] = {
+		.pc_func	= nlmsvc_proc_unlock_msg,
+		.pc_decode	= nlm_svc_decode_nlm_unlockargs,
+		.pc_encode	= nlm_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm_unlockargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "UNLOCK_MSG",
 	},
 	[NLMPROC_GRANTED_MSG] = {
 		.pc_func = nlmsvc_proc_granted_msg,

-- 
2.54.0


