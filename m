Return-Path: <linux-nfs+bounces-18392-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OA+GPXDc2kCygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18392-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:45 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BE679D96
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58953304CB69
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FD03EBF37;
	Fri, 23 Jan 2026 18:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvKcy/Sr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D375C29BDB0
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194407; cv=none; b=ggd1ovp1cJb/oCuNKXk6I7wT4g5o7w7/UYw7rsDTZiJjRKvRmvB0TgO1EDl1sO/mDmzLdO360MRtPugtOHo+eBs1D3/IAb55vIyG00ZK0sL9Gfl/vWRbpzFecJP7k0mhHw8/IliiqjqEOw/TOeslgKdBVsrNBw7ZzgMYPn4TRK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194407; c=relaxed/simple;
	bh=IulOR4sjpIiEIot9UY21H6beYe3Jhpas/a0/4hwXjws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPLVCo5q+my61hlPzlyfo31LwvwX8mcNBXz5Vt2aLbolZ71JQScQAlnqa67DUti4f3fSMxbakZLS58OfN4e8+CzNmqfIs7b2fkmCpvtxfJMr1m+o2TbgRrvgUWsZrk+Tz/BHcDtc1JXTrPqZxjYKS0KZJFuJ7f61MDeEkj4sCug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvKcy/Sr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B13CC4CEF1;
	Fri, 23 Jan 2026 18:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194407;
	bh=IulOR4sjpIiEIot9UY21H6beYe3Jhpas/a0/4hwXjws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CvKcy/SrLqEy2Odwn2j1oFKooJSb1gt40DCyFL59bCXYDz/xnTWuascKU1VzHzEgF
	 wtjIF6jZntpzATK9cPg4bgBbNIp5iD2II/eEXgNNzR41tcRJF10/loOJWs8ySR6fHS
	 7LzvLlG7oW1ubD3WCYmJ9tQNVzhcdjNyGK1J4nbi37eV8ZaFvSIzHEiDFIc11Hp4zx
	 y+/JN9vMDDb7Mzcg91RbYLUxtIhuj1d66zDDgRHaMoWs9tEpzh+p4pSJ1zAU6rTsTD
	 FBN2QTWYBEXxtGU5+u9cFNbIVS3HbFqslyqWU1xz/BD41ehZ6VW5UjEl+TyQ/RKbuf
	 aS9oz4VDxCVVg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 31/42] lockd: Use xdrgen XDR functions for the NLMv4 GRANTED_RES procedure
Date: Fri, 23 Jan 2026 13:52:48 -0500
Message-ID: <20260123185259.1215767-32-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18392-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: E4BE679D96
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Convert the GRANTED_RES procedure to use xdrgen functions
nlm4_svc_decode_nlm4_res and nlm4_svc_encode_void.
GRANTED_RES is a callback procedure where the client sends
granted lock results back to the server after an async
GRANTED request.

The pc_argzero field is set to zero because xdrgen decoders
reliably initialize all arguments, making the early
defensive memset unnecessary.

This change also corrects the pc_xdrressize field, which
previously contained a placeholder value.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 60 +++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index d7f4079d56f3..59d818bf1523 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -71,6 +71,7 @@ static_assert(offsetof(struct nlm4_testres_wrapper, xdrgen) == 0);
 
 struct nlm4_res_wrapper {
 	struct nlm4_res			xdrgen;
+	struct nlm_cookie		cookie;
 };
 
 static_assert(offsetof(struct nlm4_res_wrapper, xdrgen) == 0);
@@ -950,6 +951,30 @@ static __be32 nlm4svc_proc_granted_msg(struct svc_rqst *rqstp)
 				__nlm4svc_proc_granted_msg);
 }
 
+/**
+ * nlm4svc_proc_granted_res - GRANTED_RES: Lock Granted result
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *
+ * RPC synopsis:
+ *   void NLMPROC4_GRANTED_RES(nlm4_res) = 15;
+ */
+static __be32 nlm4svc_proc_granted_res(struct svc_rqst *rqstp)
+{
+	struct nlm4_res_wrapper *argp = rqstp->rq_argp;
+
+	if (!nlmsvc_ops)
+		return rpc_success;
+
+	if (nlm4_netobj_to_cookie(&argp->cookie, &argp->xdrgen.cookie))
+		return rpc_success;
+	nlmsvc_grant_reply(&argp->cookie, argp->xdrgen.stat.stat);
+
+	return rpc_success;
+}
+
 /*
  * SHARE: create a DOS share or alter existing share.
  */
@@ -1073,23 +1098,6 @@ nlm4svc_proc_sm_notify(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
-/*
- * client sent a GRANTED_RES, let's remove the associated block
- */
-static __be32
-nlm4svc_proc_granted_res(struct svc_rqst *rqstp)
-{
-	struct nlm_res *argp = rqstp->rq_argp;
-
-        if (!nlmsvc_ops)
-                return rpc_success;
-
-        dprintk("lockd: GRANTED_RES   called\n");
-
-        nlmsvc_grant_reply(&argp->cookie, argp->status);
-        return rpc_success;
-}
-
 static __be32
 nlm4svc_proc_unused(struct svc_rqst *rqstp)
 {
@@ -1259,15 +1267,15 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "UNLOCK_RES",
 	},
-	[NLMPROC_GRANTED_RES] = {
-		.pc_func = nlm4svc_proc_granted_res,
-		.pc_decode = nlm4svc_decode_res,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_res),
-		.pc_argzero = sizeof(struct nlm_res),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "GRANTED_RES",
+	[NLMPROC4_GRANTED_RES] = {
+		.pc_func	= nlm4svc_proc_granted_res,
+		.pc_decode	= nlm4_svc_decode_nlm4_res,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm4_res_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "GRANTED_RES",
 	},
 	[NLMPROC_NSM_NOTIFY] = {
 		.pc_func = nlm4svc_proc_sm_notify,
-- 
2.52.0


