Return-Path: <linux-nfs+bounces-21556-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJR2DeBxA2q55wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21556-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:30:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93902527ACB
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDF5A31B4340
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956D9374187;
	Tue, 12 May 2026 18:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEXeCf9c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728CA372B3C
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609654; cv=none; b=sonlA6AH1wN7L/IA6U9H8G2Rd57YEcF25j5JlZX63oO8n5kkaIPSK9pOYnLsXRObP23A9Zrk6NbUGdTW6Pviz6RXzkCwXXjM/WNXx8ReIBQjfLqAX1mIiI3FOIZ0EGrwe16L4bdLtB63ycskWkvMMEPpGElVtSdtg9NdeLvV8RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609654; c=relaxed/simple;
	bh=JSRHar89Nw+C5QGupXtKdWAdYnhJ/c1jLikkP7r9iFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KVCxRgDEiyThH7pSPaMe5HJwy+TG0iutHe6n4+w+BuwHmTVHnnQbLAdYtyKkPSV6RBf2W/RiHE/3uJ8bqlTMN6cnbt6cawXlaW9iiuosKkDk5ftw2lWv/yO0iQ8rOERhNDUrSuKCpur70+qPfBuaqBQy/RkB/64XpLptk2ETh2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEXeCf9c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFA6C2BCF6;
	Tue, 12 May 2026 18:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609654;
	bh=JSRHar89Nw+C5QGupXtKdWAdYnhJ/c1jLikkP7r9iFg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MEXeCf9csJvS79F9FwmjJh8BIP9CRJ/vYdSwcZXkCCQIUgzK9INNLm1L6AZNuMRx8
	 JPnx61LEnnhxOTovhE/PSlCJo0xxIRaC6NEASiUMSmBn5CWA1CvrXAGDo7FQvNK24Q
	 rbQA+ZDNsdEmIyb6SG4MZQjFdL7dCfYcDVgudl8eaLBu0WedCpJzbAIoyCjhu3GB/i
	 BcbenjSj7Qj2L+sl6VNZvc6LKKvKL13QURcAJfdSG9B4aVD/X5OLIL2540Vc3WE3Rp
	 eMr6ZPsniR6DR+vMYX3H0POIBlTM9N22x0vpjYVVkoKDiwayBVIkxJ2an15q9ZjfIo
	 tYUqunrZ6AOaw==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:13:51 -0400
Subject: [PATCH 16/38] lockd: Use xdrgen XDR functions for the NLMv3 CANCEL
 procedure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-16-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=5002;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=vX4PXBWt20uLosGoDselpGPNxi/0TzUAFSMRkkAgY+k=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23lf5RLYvltkNfSNi9yajfBNjZN2hiERgzfJ
 kFkPM9Wxi6JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5QAKCRAzarMzb2Z/
 l+D3EADCCriMqfdWsMlA+ii3wG4eNe0+VIEWteWAtvu9w2KkaWE/bVmkreTEixfs2jEWft3RU8+
 eG3w6TFSkaOdIyT2vfyCRbvG8phiPjIUTrDDGtZ6PFz/0OMH0mCH1fRUl4ikz1J/+kgXCA65dBx
 QJPij8BqLJG6IQgTEpmUjfJ8cBhq+O4KvcI++FuRl0hNEvftM/tCsSKsBAUED19zAL8CwqccNP0
 sWXCxWy/5g8QKs9ClMmvTm2ZNuAbTj9IYI5SZcqVwKNxvrqCN1M3caABR7Qfj8IgNcwC6Lri3Mu
 oS7CTNWNVTcvid5HzHPmLvS6ebx5UFBCGf7c3Xs9JocOk+a+McisK4estqLhLQc5VhVAmqqShYW
 4FuOR2MFwTdYsYnExI6dXUqAvV4665Link7EYw7+f49eSbr2nQvioOgebNshWsnQvZ2OH/X/VtT
 8ruUU4mzSp0pfRTPvFrbjBENyabn2UEeCBPnujmWItEPGuiFFBzPSBStlkuNiVFlUEu2axh/gwV
 3vBRu+nH8YJ9+gEvD1Cx9nktwFfVQhUMgxEj86MlA5BIvaAiz34HYEf5RYJ1xAs2ON42Bx8Op2P
 RsCUfqA6gpAlJ0baT5iKv5MxyKg04/bNITqa2SmE5pkV3JoZzwG08/+leVj5mSrP9PZxVNQTNsR
 2OlAz4Wni3jeMKw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 93902527ACB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21556-lists,linux-nfs=lfdr.de];
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

The NLM CANCEL procedure allows clients to cancel outstanding
blocked lock requests. This patch continues the xdrgen migration
by converting the CANCEL procedure. CANCEL reuses the
nlm3svc_lookup_host() and nlm3svc_lookup_file() helpers
established in the TEST procedure conversion.

This patch converts the CANCEL procedure to use xdrgen functions
nlm_svc_decode_nlm_cancargs and nlm_svc_encode_nlm_res generated
from the NLM version 3 protocol specification. The procedure
handler uses xdrgen types through a wrapper structure that
bridges between generated code and the legacy lockd_lock
representation still used by the core lockd logic.

Setting pc_argzero to zero is safe because the generated decoder
fills the argp->xdrgen subfields before the procedure runs, so the
zeroing memset performed by the dispatch layer is not needed. The
lock member of the wrapper is populated explicitly in
nlm3svc_lookup_file() rather than relying on zero-initialization.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcproc.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 71 insertions(+), 10 deletions(-)

diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 66bc9a2efddb..a5e40ca3f109 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -65,6 +65,13 @@ struct nlm_res_wrapper {
 
 static_assert(offsetof(struct nlm_res_wrapper, xdrgen) == 0);
 
+struct nlm_cancargs_wrapper {
+	struct nlm_cancargs		xdrgen;
+	struct lockd_lock		lock;
+};
+
+static_assert(offsetof(struct nlm_cancargs_wrapper, xdrgen) == 0);
+
 static __be32
 nlm_netobj_to_cookie(struct lockd_cookie *cookie, netobj *object)
 {
@@ -517,10 +524,63 @@ __nlmsvc_proc_cancel(struct svc_rqst *rqstp, struct lockd_res *resp)
 	return rpc_success;
 }
 
+/**
+ * nlmsvc_proc_cancel - CANCEL: Cancel an outstanding blocked lock request
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_drop_reply:		Do not send an RPC reply.
+ *
+ * RPC synopsis:
+ *   nlm_res NLM_CANCEL(nlm_cancargs) = 3;
+ *
+ * Permissible procedure status codes:
+ *   %LCK_GRANTED:		The requested lock was canceled.
+ *   %LCK_DENIED:		There was no lock to cancel.
+ *   %LCK_DENIED_GRACE_PERIOD:	The server has recently restarted and is
+ *				re-establishing existing locks, and is not
+ *				yet ready to accept normal service requests.
+ *
+ * The Linux NLM server implementation also returns:
+ *   %LCK_DENIED_NOLOCKS:	A needed resource could not be allocated.
+ */
 static __be32
 nlmsvc_proc_cancel(struct svc_rqst *rqstp)
 {
-	return __nlmsvc_proc_cancel(rqstp, rqstp->rq_resp);
+	struct nlm_cancargs_wrapper *argp = rqstp->rq_argp;
+	unsigned char type = argp->xdrgen.exclusive ? F_WRLCK : F_RDLCK;
+	struct nlm_res_wrapper *resp = rqstp->rq_resp;
+	struct net *net = SVC_NET(rqstp);
+	struct nlm_host	*host = NULL;
+	struct nlm_file	*file = NULL;
+
+	resp->xdrgen.cookie = argp->xdrgen.cookie;
+
+	resp->xdrgen.stat.stat = nlm_lck_denied_grace_period;
+	if (locks_in_grace(net))
+		goto out;
+
+	resp->xdrgen.stat.stat = nlm_lck_denied_nolocks;
+	host = nlm3svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, false);
+	if (!host)
+		goto out;
+
+	resp->xdrgen.stat.stat = nlm3svc_lookup_file(rqstp, host, &argp->lock,
+						     &file, &argp->xdrgen.alock,
+						     type);
+	if (resp->xdrgen.stat.stat)
+		goto out;
+
+	resp->xdrgen.stat.stat = nlmsvc_cancel_blocked(net, file, &argp->lock);
+	nlmsvc_release_lockowner(&argp->lock);
+
+out:
+	if (file)
+		nlm_release_file(file);
+	nlmsvc_release_host(host);
+	return resp->xdrgen.stat.stat == nlm__int__drop_reply ?
+		rpc_drop_reply : rpc_success;
 }
 
 /*
@@ -874,15 +934,15 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_xdrressize	= NLM3_nlm_res_sz,
 		.pc_name	= "LOCK",
 	},
-	[NLMPROC_CANCEL] = {
-		.pc_func = nlmsvc_proc_cancel,
-		.pc_decode = nlmsvc_decode_cancargs,
-		.pc_encode = nlmsvc_encode_res,
-		.pc_argsize = sizeof(struct lockd_args),
-		.pc_argzero = sizeof(struct lockd_args),
-		.pc_ressize = sizeof(struct lockd_res),
-		.pc_xdrressize = Ck+St,
-		.pc_name = "CANCEL",
+	[NLM_CANCEL] = {
+		.pc_func	= nlmsvc_proc_cancel,
+		.pc_decode	= nlm_svc_decode_nlm_cancargs,
+		.pc_encode	= nlm_svc_encode_nlm_res,
+		.pc_argsize	= sizeof(struct nlm_cancargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= sizeof(struct nlm_res_wrapper),
+		.pc_xdrressize	= NLM3_nlm_res_sz,
+		.pc_name	= "CANCEL",
 	},
 	[NLMPROC_UNLOCK] = {
 		.pc_func = nlmsvc_proc_unlock,
@@ -1092,6 +1152,7 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 union nlmsvc_xdrstore {
 	struct nlm_testargs_wrapper	testargs;
 	struct nlm_lockargs_wrapper	lockargs;
+	struct nlm_cancargs_wrapper	cancargs;
 	struct nlm_testres_wrapper	testres;
 	struct nlm_res_wrapper		res;
 	struct lockd_args		args;

-- 
2.54.0


