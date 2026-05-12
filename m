Return-Path: <linux-nfs+bounces-21562-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPJzNOxxA2q55wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21562-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:31:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F66527AF1
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3790E3301328
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5274371CEA;
	Tue, 12 May 2026 18:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQQ4wajO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2FA36D4E4
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609659; cv=none; b=RTHsRjQX+KJmEGmvBJz6ksFIroshMcRMQ5j4fiAA+gvW04oHdT9T6LDF1qXF+fZkFepz+CNta4EEBLt+K7tZwKSUWhOX1XvUxitOWRZkq45AXtYOyAlkFTT1wiL6KpUTu3YthImdN2lnk0qjVOYUILzJ48dYsGTwShf4OH9bbFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609659; c=relaxed/simple;
	bh=N/8y1k9+H1YLdX/TexsYK2J3LBf/9SsZHE0q6JqyoPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QzBFPKwG278kwaHxs/lCj6vjw0PotkGB8UKW+jipRhfOgjY7v2A7TU3Z5tEuELKAB9IO1vLmsR00ar3VoDGxZBGjt6vHJakOmyGzYUtsmeWthtsp3TyA7Vto1kGS5Rhea3jl6rNfZ0j2zM1gS1vUgu2Km2nLZmXhhOMjuYIym9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQQ4wajO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E488EC2BCB0;
	Tue, 12 May 2026 18:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609659;
	bh=N/8y1k9+H1YLdX/TexsYK2J3LBf/9SsZHE0q6JqyoPQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sQQ4wajOs33wakEiHp5FMDaJm77pEESBkuYbSLF1E8M+iXk2cbRAsD+Qr949TjSWC
	 H691fSB4bdeL17aiHe0unZV758k452ulX/tHlsxb3JYiHL8Djbzq006SRrYP1dSgTg
	 iPnjgKDApP6sMS5K6l7NNd5dIZeNfg7Aw4o33FmxBofSPWgfGBzrShSE7XMezuGW7T
	 f5jqxNg2dWMbRzgb6qXj0DQMH2eauCS827CNmt374zgXpaXhjZptrjgkhV5mAk7cw9
	 fBqCt6xLguZDcMdwm3DHwufr+KiDE0drwYmJSz1WB2EqfFJYCkLWa2Ng0GaR+FGgfM
	 Yapw5UgND+Lzg==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:13:57 -0400
Subject: [PATCH 22/38] lockd: Use xdrgen XDR functions for the NLMv3
 CANCEL_MSG procedure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-22-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=6526;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=6nyWVywWqsuMDTUYjkHwd6Y8NwVpbzizB7aZAP1GZAs=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23lgKl3DgvnqsIiID995EhMcvhkUyHULMtup
 6Ygheg047KJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5QAKCRAzarMzb2Z/
 l5AFD/466G4+kYuL/4hV5C4qr3hmFaC2d6BvdrbLMnP/VaWkl+OaROqDBaoRh5lv+TtjkjHYmR7
 5MxBAM1E1IQG0swi/FKAQpUs3zDvNWkacZa915/czVoZWl7TbyxAyLPpA1RT0scSYgK8dsBTthi
 kHe296Sqnly0y/fHdHCL+VNLKHSFJb0cKvPCGK2QXjiG02FHyENRsuio+Jcj4bJ31AAD9qMRoUI
 ptEQBDmf0CVuZ2QzyPv6cPuE/7AqbgEbNPKg5oeuz7ZmkTRvtdpqOIcxxHv1HM5jY5MiACk1SeE
 +6rny1eldsGERuXH7IkFRjl+O1kI5TA6gy4Lbypbo98OuNVGFpvE2OVayyV57GbzmgwZHmLRnoj
 MYygsuA+s7ty6tqxPxTVFnLRqNXgjVqfH+q0r0fLq6B/3ghhewT+A8QImtgnU/mZM1UlH4pOteW
 bhboR7v9buu03ncLK4lYDX+9F58SFJsi4cXeKX6AlfMz780SHKYaqwrMyRPNyFvv1TnSBBfXvm2
 LiA4CN6XO8oBytwQYSUBgB5vvJsjBkNFOo6oujoTC83jn7GkM9YWNfpZuJdrL46zR/volVlDrzC
 RHH/1e+2hSJBFBPxwmOiBe52n42DzRdYyMLnJ3os1eqkLfNSCssuidoGCtWSbciYBonsvdmNFJ9
 YUJqCvIa9siA/oA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 34F66527AF1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21562-lists,linux-nfs=lfdr.de];
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

The CANCEL_MSG procedure is part of NLM's asynchronous lock
request flow, where clients send CANCEL_MSG to cancel pending
lock requests. This patch continues the xdrgen migration by
converting CANCEL_MSG to use generated XDR functions.

This patch converts the CANCEL_MSG procedure to use xdrgen
functions nlm_svc_decode_nlm_cancargs and nlm_svc_encode_void
generated from the NLM version 3 protocol specification. The
procedure handler uses xdrgen types through the
nlm_cancargs_wrapper structure that bridges between generated
code and the legacy lockd_lock representation.

Setting pc_argzero to zero is safe because the generated decoder
fills the argp->xdrgen subfields before the procedure runs, so the
zeroing memset performed by the dispatch layer is not needed. The
lock member of the wrapper is populated explicitly in
nlm3svc_lookup_file() rather than relying on zero-initialization.

The previous hand-written decoder in svcxdr_decode_cookie()
rewrote a zero-length NLM cookie into a four-byte zero cookie,
with a comment attributing the substitution to HP-UX clients.
The xdrgen-generated netobj decoder performs no such rewrite, so
a zero-length request cookie now round-trips unchanged into the
CANCEL_RES reply. HP-UX has reached end of support, and CANCEL_MSG
is fire-and-forget with no client-side reply matching on the NLM
cookie, so the workaround is dropped intentionally here.

The NLM async callback mechanism uses client-side functions
which continue to take legacy results like struct lockd_res,
preventing CANCEL and CANCEL_MSG from sharing code for now.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcproc.c | 114 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 67 insertions(+), 47 deletions(-)

diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 17625d43dc37..d055079c9485 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -478,39 +478,6 @@ nlmsvc_proc_lock(struct svc_rqst *rqstp)
 	return nlmsvc_do_lock(rqstp, true);
 }
 
-static __be32
-__nlmsvc_proc_cancel(struct svc_rqst *rqstp, struct lockd_res *resp)
-{
-	struct lockd_args *argp = rqstp->rq_argp;
-	struct nlm_host	*host;
-	struct nlm_file	*file;
-	struct net *net = SVC_NET(rqstp);
-
-	dprintk("lockd: CANCEL        called\n");
-
-	resp->cookie = argp->cookie;
-
-	/* Don't accept requests during grace period */
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
-	/* Try to cancel request. */
-	resp->status = cast_status(nlmsvc_cancel_blocked(net, file, &argp->lock));
-
-	dprintk("lockd: CANCEL        status %d\n", ntohl(resp->status));
-	nlmsvc_release_lockowner(&argp->lock);
-	nlmsvc_release_host(host);
-	nlm_release_file(file);
-	return rpc_success;
-}
-
 /**
  * nlmsvc_proc_cancel - CANCEL: Cancel an outstanding blocked lock request
  * @rqstp: RPC transaction context
@@ -900,19 +867,72 @@ static __be32 nlmsvc_proc_lock_msg(struct svc_rqst *rqstp)
 			       __nlmsvc_proc_lock_msg);
 }
 
+static __be32
+__nlmsvc_proc_cancel_msg(struct svc_rqst *rqstp, struct lockd_res *resp)
+{
+	struct nlm_cancargs_wrapper *argp = rqstp->rq_argp;
+	unsigned char type = argp->xdrgen.exclusive ? F_WRLCK : F_RDLCK;
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
+	return resp->status == nlm__int__drop_reply ? rpc_drop_reply : rpc_success;
+}
+
+/**
+ * nlmsvc_proc_cancel_msg - CANCEL_MSG: Cancel an outstanding lock request
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_drop_reply:		Do not send an RPC reply.
+ *   %rpc_garbage_args:	The request arguments are malformed.
+ *   %rpc_system_err:		RPC execution failed.
+ *
+ * RPC synopsis:
+ *   void NLMPROC_CANCEL_MSG(nlm_cancargs) = 8;
+ *
+ * The response to this request is delivered via the CANCEL_RES procedure.
+ */
 static __be32 nlmsvc_proc_cancel_msg(struct svc_rqst *rqstp)
 {
-	struct lockd_args *argp = rqstp->rq_argp;
-	struct nlm_host	*host;
+	struct nlm_cancargs_wrapper *argp = rqstp->rq_argp;
+	struct nlm_host *host;
 
-	dprintk("lockd: CANCEL_MSG    called\n");
+	if (argp->xdrgen.cookie.len > NLM_MAXCOOKIELEN)
+		return rpc_garbage_args;
 
-	host = nlmsvc_lookup_host(rqstp, argp->lock.caller, argp->lock.len);
+	host = nlm3svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, false);
 	if (!host)
 		return rpc_system_err;
 
 	return nlmsvc_callback(rqstp, host, NLMPROC_CANCEL_RES,
-			       __nlmsvc_proc_cancel);
+			       __nlmsvc_proc_cancel_msg);
 }
 
 static __be32 nlmsvc_proc_unlock_msg(struct svc_rqst *rqstp)
@@ -1188,15 +1208,15 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "LOCK_MSG",
 	},
-	[NLMPROC_CANCEL_MSG] = {
-		.pc_func = nlmsvc_proc_cancel_msg,
-		.pc_decode = nlmsvc_decode_cancargs,
-		.pc_encode = nlmsvc_encode_void,
-		.pc_argsize = sizeof(struct lockd_args),
-		.pc_argzero = sizeof(struct lockd_args),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "CANCEL_MSG",
+	[NLM_CANCEL_MSG] = {
+		.pc_func	= nlmsvc_proc_cancel_msg,
+		.pc_decode	= nlm_svc_decode_nlm_cancargs,
+		.pc_encode	= nlm_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm_cancargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "CANCEL_MSG",
 	},
 	[NLMPROC_UNLOCK_MSG] = {
 		.pc_func = nlmsvc_proc_unlock_msg,

-- 
2.54.0


