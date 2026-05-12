Return-Path: <linux-nfs+bounces-21569-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBmhE/1xA2q55wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21569-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:31:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B281B527B1C
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CD5D330823E
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E625534405B;
	Tue, 12 May 2026 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+mRypNj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F5A343D9D
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609665; cv=none; b=DeViRBZL/P875pz0iECWz6Jy1CwARUYCwaM7qIuis4HKQDCiW0/Gt4obHzKZ5fD40YClWW6ZkHayuyuaGk+JtsVhJvPojHD7to8J4S+d+i8tCtL4IVlNmN5MlVFvHsHdSMDVOEv91HyhVQ5fFtdJuc4wRaHmZQgoeZ/k3I8bsJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609665; c=relaxed/simple;
	bh=2zS2DJBb2GyUbCN00QUgXKSM3mLh45DzN46pqEicdOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WOJByv/fpQAI49sanML8sxlucc4nByIjSWQPr/dBcoAaOlniCCOY5DAvitxjKb40NPp8kS2l1KxCItcSV+aX94NI2yMwvAe2s4oaEyimnRtVSkS5piy8M6wFwpudxsxLqSTdb5S240bZh1gUYBKSsh4Uok7nT3nZ5dQCSmyGAQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+mRypNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E094C2BCC7;
	Tue, 12 May 2026 18:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609665;
	bh=2zS2DJBb2GyUbCN00QUgXKSM3mLh45DzN46pqEicdOg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e+mRypNjYRJAaFjpU7C2TTujCkpNzdW66AKuE2a5Qh7dUI1VzYR0zEHZmGaRsw1Fs
	 Aa8CJ55AAeGv+cvJSmsT+G8Wvtaos63uFdd0td5NVe0LoYPrp6vFdEvltbtQ/JGN+k
	 k0Lk375qtk2ragnly/o51MG3fbzWLxT+Fivmv2rb8MpTA+LpLv+LHhp1KfXbrbhw/s
	 fv5OkU+3HSOJ5jafRlnF+/9bW6XZhD6Ivk+53E5hvBgGydGZ/SiLYg4mmecgTsZq8h
	 XwftfDMqWcbBe7oND6sTFHTdEBU7kjTbWyP7ZhOs7wKDEK8UFFy8jBpT/w9PQ/BmMb
	 lvDcftTSLeuzw==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:14:04 -0400
Subject: [PATCH 29/38] lockd: Use xdrgen XDR functions for the NLMv3
 GRANTED_RES procedure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-29-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=3450;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=UcSbVA6rXPYb4ISaLvwwF9XpynNmYINtVJUmxRW3tdk=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23msT8+VtLlMBqHYGiNWE3JDhkVFHJTCSd8j
 SSWMbctJySJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5gAKCRAzarMzb2Z/
 lxS2D/9XQRk28NI6C3xBwp6QsxpwSrbUFn/FK2HralA2GJ8wMItQNW30oFHVNqZ9GMgQ/JmYjUc
 IXaW3KWrGVdFGMw7TPddk6tCG/nvKb4X6/jn4MZSyFLZbKgi1vyIIFQYnNxm5Ucso+NQt/j4Uf0
 onTrRJV7DtTcgB0TjnS3k0azlNh123UOLgDWO6awWajGn0gW/B4khzbIFq50Xpa0cwU8w7p6kgt
 5Rz+rm8YJcSy9NMQv8BIBOcJhFDwjaX4/UvVYKnDu8llH0LxrVH4Cpug3bvou3C+PHC3cfJKTJc
 sxMokv4k+Ry4g2G5K0PeJcjADOvArAFxDqUkN8FZM/7ULtev6gbfejg360ep8aH0iaC3EmLuwMt
 R1mIAFMJDDqkJFWITCcvmFl3G563dA1XPQhHVrZfowDOjQx8amMbaJ+O/dDtIWEjC8DUyGCA1tV
 7wg4ljTDt3sj6PnF0wvDRtg3J9gLnE44aBwtJkED3SOSi1X2RHDRQZdnJxlcthHqCFrVQ5+kHF+
 YKW1HCefrhI5yWUr/gg9osPz0RnjnPU+UBvQmdF/1rDxN4mMOVTHojma5FEEKLNTbYU0UQtiKbZ
 YUYjdjABQ1VRV/Ey8gbDTg0r5a7gQHgLGzxKFD1xZeS36Khj/LLJX95NcftcUUKvPkLEhIwEU/W
 wPwx0NVeXoF4fZw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: B281B527B1C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21569-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Continue the xdrgen migration by converting NLMv3 GRANTED_RES,
the callback that a remote NLM uses to return async GRANTED
results to this lockd.  The procedure now uses
nlm_svc_decode_nlm_res and nlm_svc_encode_void, generated
from the NLM version 3 protocol specification.

Setting pc_argzero to zero is safe because the generated
decoder fills the argp->xdrgen subfields before the procedure
runs, so the zeroing memset performed by the dispatch layer
is no longer needed.

Setting pc_xdrressize to XDR_void reflects that GRANTED_RES, as
a callback, returns no data; the previous value of St
over-reserved a status word in the reply buffer.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcproc.c | 60 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index f17d3f8d85ec..a2ac747e96ce 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -61,6 +61,7 @@ static_assert(offsetof(struct nlm_lockargs_wrapper, xdrgen) == 0);
 
 struct nlm_res_wrapper {
 	struct nlm_res			xdrgen;
+	struct lockd_cookie		cookie;
 };
 
 static_assert(offsetof(struct nlm_res_wrapper, xdrgen) == 0);
@@ -997,6 +998,30 @@ static __be32 nlmsvc_proc_granted_msg(struct svc_rqst *rqstp)
 			       __nlmsvc_proc_granted_msg);
 }
 
+/**
+ * nlmsvc_proc_granted_res - GRANTED_RES: Lock Granted result
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *
+ * RPC synopsis:
+ *   void NLMPROC_GRANTED_RES(nlm_res) = 15;
+ */
+static __be32 nlmsvc_proc_granted_res(struct svc_rqst *rqstp)
+{
+	struct nlm_res_wrapper *argp = rqstp->rq_argp;
+
+	if (!nlmsvc_ops)
+		return rpc_success;
+
+	if (nlm_netobj_to_cookie(&argp->cookie, &argp->xdrgen.cookie))
+		return rpc_success;
+	nlmsvc_grant_reply(&argp->cookie, argp->xdrgen.stat.stat);
+
+	return rpc_success;
+}
+
 /*
  * SHARE: create a DOS share or alter existing share.
  */
@@ -1125,23 +1150,6 @@ nlmsvc_proc_sm_notify(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
-/*
- * client sent a GRANTED_RES, let's remove the associated block
- */
-static __be32
-nlmsvc_proc_granted_res(struct svc_rqst *rqstp)
-{
-	struct lockd_res *argp = rqstp->rq_argp;
-
-	if (!nlmsvc_ops)
-		return rpc_success;
-
-	dprintk("lockd: GRANTED_RES   called\n");
-
-	nlmsvc_grant_reply(&argp->cookie, argp->status);
-	return rpc_success;
-}
-
 static __be32
 nlmsvc_proc_unused(struct svc_rqst *rqstp)
 {
@@ -1310,15 +1318,15 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "UNLOCK_RES",
 	},
-	[NLMPROC_GRANTED_RES] = {
-		.pc_func = nlmsvc_proc_granted_res,
-		.pc_decode = nlmsvc_decode_res,
-		.pc_encode = nlmsvc_encode_void,
-		.pc_argsize = sizeof(struct lockd_res),
-		.pc_argzero = sizeof(struct lockd_res),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "GRANTED_RES",
+	[NLM_GRANTED_RES] = {
+		.pc_func	= nlmsvc_proc_granted_res,
+		.pc_decode	= nlm_svc_decode_nlm_res,
+		.pc_encode	= nlm_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm_res_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "GRANTED_RES",
 	},
 	[NLMPROC_NSM_NOTIFY] = {
 		.pc_func = nlmsvc_proc_sm_notify,

-- 
2.54.0


