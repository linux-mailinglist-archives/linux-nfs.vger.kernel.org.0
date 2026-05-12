Return-Path: <linux-nfs+bounces-21573-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE3ELzxuA2rF5gEAu9opvQ
	(envelope-from <linux-nfs+bounces-21573-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:15:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89815527254
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A735A3069E24
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF7437C113;
	Tue, 12 May 2026 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPNnCxnr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1D8343D9D
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609669; cv=none; b=PBpiTTL9lhGifsCKvBkRV8fA2rfuMShjjmX5K7r7vM4jlrtY6FzVIWH6Co2icZfLP0oMYWUJkm15sSuAeVpBA3w+aAfUUDm9NT8Vj2c0Jgon8p3EgvG0iC2E4WsAKmvd6x+RlWXaPUhXa95vZySn4rR6wTWtyvfgzapHbsWPOtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609669; c=relaxed/simple;
	bh=+N/B/nnXfwnX3fhu9BIjPTmspcEB03pYOubiO2vldYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ligh7NjdjlG5DJRjefJSY53+Inz6dgfFTubQAyrM9xB4zGvdBf9Y11lOicu4gmy+hzA3JBO3//7d+pdqG8XmEmA50yM5ZzDUf9oEIziuGSJmn+SKPCpOal19003EUSjsC2+j8W75k5rXfuFpmyaCjSBqcowSIap1IcrKyvXHuGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPNnCxnr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77ACBC2BCB0;
	Tue, 12 May 2026 18:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609669;
	bh=+N/B/nnXfwnX3fhu9BIjPTmspcEB03pYOubiO2vldYw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mPNnCxnrvdDfxi+hTj7vHE3xraO3BU0++LQ94z3ZBYKEcwurBatyRpHNBD+mRamYF
	 LdddV/ZwFGSNpsjb7DYrg/UwXGrBgyBQkV+UbusnnCdR8mwKWdPgFYKeaqZKaj0ShH
	 JaeIWpq/yszXO96Duqp8UExDj8fdDIqIahu3DrWCzuj1AK4+dFMLB+Y+Eduk3U3QeW
	 7iGDiNRfHnLxxpPu3fRPAqvxGl+SVSocVD8GFZn5hm2LwmpaRvrcxFTCbCIanLEsSe
	 +/XideYcvEBNdgikMuqnQJr5Sf7qRbAjpi0du6WkGfsNeXFqgofp4p4Qw6ZH77L52T
	 dbqGuVO3o1Qww==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:14:08 -0400
Subject: [PATCH 33/38] lockd: Use xdrgen XDR functions for the NLMv3
 UNSHARE procedure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-33-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=4796;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=HEXQkC8BQkOSoLR33mneIXXTUDdBrzo6jqk3YA/1X2M=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23m/vrnfHtRCkByLGhciN/m3oN9MYiVbNk5o
 oiaNTzvIEqJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5gAKCRAzarMzb2Z/
 l+cMD/9uFfx/KsVcWQ0BCaQnfHLOUJ/Kh+uv0Ig+UILjkCr/0XSYU/SnaOQ+pOGPwPkwznpW8Ms
 KYknOA1RZh5mrgH0xK1mye0Gi6XvxVN6Kv4nXzYsc8UCczs58x6Crxlt5UQ+LnADZVbRmayYjqc
 /bLFtpMpzSLBHYtvIrkB4Nds5gM36feNQ6jS5T5WQ8jOUi/CnpP+PWZLRl27uWML/GcvBJY9dIW
 R5zRcBjCWCaCbPyhr8TOzo7vKbYmkNp1gxZII07vxQS9rnVCrZSV83BbKEmgns55YroUMqBtSNB
 mqNqsQgts+XK/OeCRmabAKQ7CBrF0y6s/DgBV/FhHIxaJ5BHmH9P9vr+c3+yjUL9gzLaTNNe14t
 pueU0/ZEAdaxOrmAZQvTQqVrLbRWTbhmVoh0y4bw4YP7HqizZUHLb5nfT/0dyyS6NvljfLCdREm
 nOy0DgDbPuwCK9nTM1ePVGloJQpgd7FhUlzyJyJOwpgSHGDA1o84QCAblAJFqtRS4cSru+c0c8H
 iwaMhP531uv1/i4ZwqGeYViemgeYEPzlF9ObmtGoOvP5oioeUqWphm/GFSjwJweIpKk7D96L0Ky
 I9v/vMh2ZlpLjmLuwq1EEjtV41APiriv8Fjhj2ku4xOmj6IcTYNW5kxuMTNKq/blxbjoI1mbolN
 ya5mQEhLoM/xj0Q==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 89815527254
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21573-lists,linux-nfs=lfdr.de];
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

Convert the NLMv3 UNSHARE procedure to use xdrgen-generated XDR
functions nlm_svc_decode_nlm_shareargs and
nlm_svc_encode_nlm_shareres.

The procedure handler is updated to use the wrapper structures
(nlm_shareargs_wrapper and nlm_shareres_wrapper) introduced by
the SHARE conversion patch and accesses arguments through the
argp->xdrgen hierarchy.

The .pc_argzero field is set to zero because the generated
decoder fills argp->xdrgen before the procedure runs, so the
zeroing memset performed by the dispatch layer is no longer
needed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcproc.c | 94 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 35 deletions(-)

diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 32625ee07c35..de4c15aa725c 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -1157,41 +1157,65 @@ static __be32 nlmsvc_proc_share(struct svc_rqst *rqstp)
 		rpc_drop_reply : rpc_success;
 }
 
-/*
- * UNSHARE: Release a DOS share.
+/**
+ * nlmsvc_proc_unshare - UNSHARE: Release a share reservation
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_drop_reply:		Do not send an RPC reply.
+ *
+ * RPC synopsis:
+ *   nlm_shareres NLM_UNSHARE(nlm_shareargs) = 21;
+ *
+ * Permissible procedure status codes:
+ *   %LCK_GRANTED:		The share reservation was released.
+ *   %LCK_DENIED_GRACE_PERIOD:	The server has recently restarted and is
+ *				re-establishing existing locks, and is not
+ *				yet ready to accept normal service requests.
+ *
+ * The Linux NLM server implementation also returns:
+ *   %LCK_DENIED_NOLOCKS:	A needed resource could not be allocated.
  */
-static __be32
-nlmsvc_proc_unshare(struct svc_rqst *rqstp)
+static __be32 nlmsvc_proc_unshare(struct svc_rqst *rqstp)
 {
-	struct lockd_args *argp = rqstp->rq_argp;
-	struct lockd_res *resp = rqstp->rq_resp;
-	struct nlm_host	*host;
-	struct nlm_file	*file;
+	struct nlm_shareargs_wrapper *argp = rqstp->rq_argp;
+	struct nlm_shareres_wrapper *resp = rqstp->rq_resp;
+	struct lockd_lock *lock = &argp->lock;
+	struct nlm_lock xdr_lock = {
+		.fh		= argp->xdrgen.share.fh,
+		.oh		= argp->xdrgen.share.oh,
+		.uppid		= LOCKD_SHARE_SVID,
+	};
+	struct nlm_host	*host = NULL;
+	struct nlm_file	*file = NULL;
 
-	dprintk("lockd: UNSHARE       called\n");
+	resp->xdrgen.cookie = argp->xdrgen.cookie;
 
-	resp->cookie = argp->cookie;
+	resp->xdrgen.stat = nlm_lck_denied_grace_period;
+	if (locks_in_grace(SVC_NET(rqstp)))
+		goto out;
 
-	/* Don't accept requests during grace period */
-	if (locks_in_grace(SVC_NET(rqstp))) {
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
 
-	/* Now try to unshare the file */
-	resp->status = cast_status(nlmsvc_unshare_file(host, file,
-						       &argp->lock.oh));
+	resp->xdrgen.stat = nlmsvc_unshare_file(host, file, &lock->oh);
 
-	dprintk("lockd: UNSHARE       status %d\n", ntohl(resp->status));
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
@@ -1448,15 +1472,15 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_xdrressize	= NLM3_nlm_shareres_sz,
 		.pc_name	= "SHARE",
 	},
-	[NLMPROC_UNSHARE] = {
-		.pc_func = nlmsvc_proc_unshare,
-		.pc_decode = nlmsvc_decode_shareargs,
-		.pc_encode = nlmsvc_encode_shareres,
-		.pc_argsize = sizeof(struct lockd_args),
-		.pc_argzero = sizeof(struct lockd_args),
-		.pc_ressize = sizeof(struct lockd_res),
-		.pc_xdrressize = Ck+St+1,
-		.pc_name = "UNSHARE",
+	[NLM_UNSHARE] = {
+		.pc_func	= nlmsvc_proc_unshare,
+		.pc_decode	= nlm_svc_decode_nlm_shareargs,
+		.pc_encode	= nlm_svc_encode_nlm_shareres,
+		.pc_argsize	= sizeof(struct nlm_shareargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= sizeof(struct nlm_shareres_wrapper),
+		.pc_xdrressize	= NLM3_nlm_shareres_sz,
+		.pc_name	= "UNSHARE",
 	},
 	[NLMPROC_NM_LOCK] = {
 		.pc_func = nlmsvc_proc_nm_lock,

-- 
2.54.0


