Return-Path: <linux-nfs+bounces-21561-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMR4Ih5uA2pS5wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21561-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:14:54 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 769AB5271FC
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6CEDC306194C
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC49352F86;
	Tue, 12 May 2026 18:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoAPg77j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82E136CE06
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609658; cv=none; b=tBfxI0dFCdbaQWu3mfJi8ltj36vKztNshMcOhgswX67U/TKei/KbYHdutNGKBfwJzfkt28w2tMZLiw2GKnxjyxHXRHhowOd8vighQlrjptiroeyO349sE7kt28r7SCEmI9SZKTG5HAmuJ4dQz8Y6/9GqRDW9AA8+0D2XC1nEn08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609658; c=relaxed/simple;
	bh=P/CLZ5fFbzsvfNLP0xv4CmuRarIShUpXFZjKjdSjmBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QGAqtYFJpmJ1th7eki3/vLMTHqENG5L9IutlfeBSAT6oqgaB2dwHRLHTTEdsisgi/8k68wz0S8M3Y43n99kFyQa7i9HR52W8bhRSH5+mKBjQK3P70Uc3mMinsc9VdcyBjqkpMC9JJYKhXOMGo/i7kMb6OfKjDhQBLDAj7YDzO+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoAPg77j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BEB4C2BCC7;
	Tue, 12 May 2026 18:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609658;
	bh=P/CLZ5fFbzsvfNLP0xv4CmuRarIShUpXFZjKjdSjmBI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SoAPg77jn743C1Y+0SEQier9Xb2tMCdlIs3Umfsv+j/FIMo/MT7ROQH9MRioQtDCn
	 vLB4Rx8ppgYaVKW4uawEhiPq+LADzZreMgM7kDNkg4HFlx+JK+Ejw+wQJXtrqMfLSS
	 0GSsYFoP8Brrk7JhzAhT6TkRK7rPV9fueiAUNfY2Qksucbk+Oa4QbeN2vq97tJc4pf
	 /pwtUAW8Im0JHfVHCGfG8GNCO2ciGe1viUI8Z/Wx9CVr6K6HEZ5+plafXvQNzruO8/
	 DtuyzpRrwcJiOWkgkWpKas8TWuKo2hdACz5fWYTdRcgmq7/AjHj0iH3onGWZnGuCZW
	 wSCCEPuZJcBAw==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:13:56 -0400
Subject: [PATCH 21/38] lockd: Use xdrgen XDR functions for the NLMv3
 LOCK_MSG procedure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-21-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=4553;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=PrEOVWKjIuaJ9OeEYBy2YVwjJF9LD0t7gZcQMFeMRSo=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23l/JtsBId3W3GptEBXETgKd1p/XpZwISCMW
 VkSUz/7o+WJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5QAKCRAzarMzb2Z/
 l/IfD/4uEAUSo/T6/rUz3F6T0qBWLBggj5bbvmquYxH5eR5LsOeyDRFlC7GuMcP8e6WEPXmfF1c
 SSIgMtCJsOQknd2yE4ISV9tWribA9JiuNqxrAktDWTvs9WGstY8HxNtZIVQJQrh6N9WvMUN9opd
 xsW4jP4Sj7X85tCOU7A5OEtZot2ufFEsr9+v6Ita53vw6HAaZiSXbuXC/TrswTNEScMKGQW8WvW
 N2/F+/wEH5Ib/AnWEO8Ysc66MqJflHzGtGRMsdgWHC/Z3LrXH7uXgniPZZaSztSyhWADrbaX8GZ
 vDnNT/JDJbLBuUDYg+BhnfUtDHJIwg/GrOTAZiivq0h71HWOAHsVt1QB1gYRk5SGywM7VrW/zGP
 hcIPGhxK72ih5MjkEbykOTOuum3D3DxLbui2n1f2MYVqclCk38p8KfxqaaBs97lLl3R6Wipu2tg
 QzA+MEZZb42nlgGmjSR2sWVaRtS8rh5mtUqgeL/Y8pmy46wHAqC4ek57p9RxZrfMvykVt55yugc
 WOoPRcktLel08tR00VaTsjZ4Fmaz8oYZLpUAR6BRsabBCazHJ3lUQ/ce1aQ1f2wkTdf+WXeBhmQ
 rtyc8xHArNaOMFoxUeMzoK/d12ToM9zLzmiFbh1+Kdzl0hTjNEzQKcbIzJE28nCZCK2vH6vqmHL
 PZmdcoxrFo4SdKg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 769AB5271FC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21561-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Continue the xdrgen migration by converting NLMv3 LOCK_MSG, the
async counterpart to LOCK that clients use to request locks that
may block. The procedure now uses nlm_svc_decode_nlm_lockargs and
nlm_svc_encode_void, generated from the NLM version 3 protocol
specification. The procedure handler reaches the xdrgen types
through the nlm_lockargs_wrapper structure, which bridges between
generated code and the legacy lockd_lock representation.

Setting pc_argzero to zero is safe because the generated decoder
fills the argp->xdrgen subfields before the procedure runs,
so the zeroing memset performed by the dispatch layer is not
needed. The lock member of the wrapper is populated explicitly in
nlm3svc_lookup_file() rather than relying on zero-initialization.

The NLM async callback mechanism uses client-side functions which
continue to take legacy results like struct lockd_res, preventing
LOCK and LOCK_MSG from sharing code for now.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcproc.c | 77 ++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 14 deletions(-)

diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index cd32cfc62338..17625d43dc37 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -836,19 +836,68 @@ static __be32 nlmsvc_proc_test_msg(struct svc_rqst *rqstp)
 			       __nlmsvc_proc_test_msg);
 }
 
+static __be32
+__nlmsvc_proc_lock_msg(struct svc_rqst *rqstp, struct lockd_res *resp)
+{
+	struct nlm_lockargs_wrapper *argp = rqstp->rq_argp;
+	unsigned char type = argp->xdrgen.exclusive ? F_WRLCK : F_RDLCK;
+	struct nlm_file	*file = NULL;
+	struct nlm_host	*host = NULL;
+
+	resp->status = nlm_lck_denied_nolocks;
+	if (nlm_netobj_to_cookie(&resp->cookie, &argp->xdrgen.cookie))
+		goto out;
+
+	host = nlm3svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, true);
+	if (!host)
+		goto out;
+
+	resp->status = nlm3svc_lookup_file(rqstp, host, &argp->lock,
+					   &file, &argp->xdrgen.alock, type);
+	if (resp->status)
+		goto out;
+
+	resp->status = cast_status(nlmsvc_lock(rqstp, file, host, &argp->lock,
+					       argp->xdrgen.block, &resp->cookie,
+					       argp->xdrgen.reclaim));
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
+ * nlmsvc_proc_lock_msg - LOCK_MSG: Establish a monitored lock
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_drop_reply:		Do not send an RPC reply.
+ *   %rpc_garbage_args:	The request arguments are malformed.
+ *   %rpc_system_err:		RPC execution failed.
+ *
+ * RPC synopsis:
+ *   void NLMPROC_LOCK_MSG(nlm_lockargs) = 7;
+ *
+ * The response to this request is delivered via the LOCK_RES procedure.
+ */
 static __be32 nlmsvc_proc_lock_msg(struct svc_rqst *rqstp)
 {
-	struct lockd_args *argp = rqstp->rq_argp;
-	struct nlm_host	*host;
+	struct nlm_lockargs_wrapper *argp = rqstp->rq_argp;
+	struct nlm_host *host;
 
-	dprintk("lockd: LOCK_MSG      called\n");
+	if (argp->xdrgen.cookie.len > NLM_MAXCOOKIELEN)
+		return rpc_garbage_args;
 
-	host = nlmsvc_lookup_host(rqstp, argp->lock.caller, argp->lock.len);
+	host = nlm3svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, false);
 	if (!host)
 		return rpc_system_err;
 
 	return nlmsvc_callback(rqstp, host, NLMPROC_LOCK_RES,
-			       __nlmsvc_proc_lock);
+			       __nlmsvc_proc_lock_msg);
 }
 
 static __be32 nlmsvc_proc_cancel_msg(struct svc_rqst *rqstp)
@@ -1129,15 +1178,15 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "TEST_MSG",
 	},
-	[NLMPROC_LOCK_MSG] = {
-		.pc_func = nlmsvc_proc_lock_msg,
-		.pc_decode = nlmsvc_decode_lockargs,
-		.pc_encode = nlmsvc_encode_void,
-		.pc_argsize = sizeof(struct lockd_args),
-		.pc_argzero = sizeof(struct lockd_args),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "LOCK_MSG",
+	[NLM_LOCK_MSG] = {
+		.pc_func	= nlmsvc_proc_lock_msg,
+		.pc_decode	= nlm_svc_decode_nlm_lockargs,
+		.pc_encode	= nlm_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm_lockargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "LOCK_MSG",
 	},
 	[NLMPROC_CANCEL_MSG] = {
 		.pc_func = nlmsvc_proc_cancel_msg,

-- 
2.54.0


