Return-Path: <linux-nfs+bounces-21574-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDm4Az9uA2rF5gEAu9opvQ
	(envelope-from <linux-nfs+bounces-21574-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:15:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7D5527264
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 490D3306B52D
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39929343D9D;
	Tue, 12 May 2026 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7ZwOMj7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ABB36CDE0
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609670; cv=none; b=kiSHwaA0ONVa73NiRBvS3cv4URvbzs88tsw5gPZ5ykr9TDOdXW2ZBEfuielfA5gWNdAvkMExyiDCr4mmLO5uA2tQY0AUZAEVfSyNJPukdVS6w0SQIQKYqyVVKSqFepy51m86RFhqrgUXBONeyuhX9BoMaEUvp1R7RbAPZI/chcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609670; c=relaxed/simple;
	bh=ZmTkSSSzzmLB1jbCUjBbLTPuAzswavyoBWIOX7Tc9/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jh8a8qDxx+EkUuN60Iy6GbciGaqaf6RKWW1KujmY2ujB2dX4fHEFayDVuENNwCIKVsC3h5HzU83NGM5U9BADuqpBKUxMyw5vDQCT3E1WLFjK+RCwzAzP1RMQFUnO2tseKpJgAqE7ILdy0gxXeIIkf2D10u0sVJrn3NTIZLUSD8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7ZwOMj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F99C2BCC7;
	Tue, 12 May 2026 18:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609670;
	bh=ZmTkSSSzzmLB1jbCUjBbLTPuAzswavyoBWIOX7Tc9/c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E7ZwOMj7kVrh+j7mrOCMRDGkELW73o66OeoYFqqitzLha//Zb9m2E8hw3/RYSERCx
	 he/Dzf1Qe40voTOOBUOf4a3KY3OZXVJHiiXKGGdx5FC+6YaXW6G7+AYKj8HUE/GGj4
	 muR45lsIQvvO3nc+nT9cCs3JGxPrgQLwUWgvNFM0qzKXVZiur2xs3+laBPN6nedprY
	 0Nsy4a67SNKKgaarziJa7hvxxgK0tOeXM3Ir2vEO9pg64X7+cEKDDRrLHnEY4eZuH3
	 uiVeZDZLX4RsW+AHHksI4pAbxXQzskNI9N+lSsUkdVB2IFbPRkk3BcgD/ZQLRTvat0
	 +oCsvJXPs25hQ==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:14:09 -0400
Subject: [PATCH 34/38] lockd: Use xdrgen XDR functions for the NLMv3
 NM_LOCK procedure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-34-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=4687;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=SbIec7lOhU/U+dU5ro2kHmeyIa5zD+YlefBhnQvpeKQ=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23mRYiXGMEtDH2mZwlNlT1uKoIEjuqpg16qh
 j44XIVpDIOJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5gAKCRAzarMzb2Z/
 l5Z3EACU657xBQTZUj67SaAGFm6NdcjpVSD7CUXw0dZt8M+8d7bGjt7eHaiXz+Gur3YtIkjXn8E
 cxhyfOrCB0PSV0q++21HBCHMlgXJOBWL8mnhQMnpjE2oktwFZtxBuK1OOqu39OhZvP6CYd461x5
 3HK/i/wgO/yNPZ5EyJ1fPaO1xDVN+BOo7idNI7skgQf7PUWl7szuZCweAsOOcxURmbfdckusTK4
 NezA29EbxJkdvUA76yiGv/HfFHBo++h3OdCm7kYfEowg6ZPrcnxdrEKYnGjg9JbVTDlzfokxi/l
 B6AT82RAv+SIIPpPEwp1I/zAHw95QwxdKVpiRMHVTQFKa2ZsZdqxZAIXw8l1ErfRH+wgIPe6StP
 cmfWAm3vUKSh0gtsvzPnLfkAqONBbBiAlTIthP+4lZG/yD1pwLydTDV5TWdlNn2+hBtGoDlvOwC
 m7jTqH8QWNbjVIKO0CRMQFlT5IydWWxl183WNuRRnRPl47AV9naJj3uITCmjB7+yDMnwct0Lkpd
 U6ukJSsrflIYEdbm+UxdUSrmIsUb/tg1twne0P7ZGniFqUREfX6EWj5poWrKIOtWlgQfa7pRVSN
 6mAkJc9anoNOBZf7scLM0gWH7sl5hHJFC6/X1wpS/rsY4lHmZ78jQ71YrgmSPJnEYOTDpXdTF0L
 9qRBzt80F3xLE2w==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: EB7D5527264
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21574-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Now that nlmsvc_do_lock() has been introduced to handle both
monitored and non-monitored lock requests, the NLMv3 NM_LOCK
procedure can be converted to use xdrgen-generated XDR
functions. This conversion allows the removal of
__nlmsvc_proc_lock(), a helper function that was previously
shared between the LOCK and NM_LOCK procedures.

Replace the NLMPROC_NM_LOCK entry in the nlmsvc_procedures
array with an entry that uses xdrgen-built XDR decoders and
encoders. The procedure handler is reduced to a thin wrapper
around nlmsvc_do_lock() with the monitored flag set to false.

The pc_argzero=0 choice was justified for the LOCK conversion
and applies unchanged here, since both procedures share the
same nlm_lockargs_wrapper layout and decoder.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcproc.c | 86 ++++++++++++++++++++++--------------------------------
 1 file changed, 35 insertions(+), 51 deletions(-)

diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index de4c15aa725c..4ca0eaef2966 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -392,38 +392,6 @@ static __be32 nlmsvc_proc_test(struct svc_rqst *rqstp)
 		rpc_drop_reply : rpc_success;
 }
 
-static __be32
-__nlmsvc_proc_lock(struct svc_rqst *rqstp, struct lockd_res *resp)
-{
-	struct lockd_args *argp = rqstp->rq_argp;
-	struct nlm_host	*host;
-	struct nlm_file	*file;
-	__be32 rc = rpc_success;
-
-	dprintk("lockd: LOCK          called\n");
-
-	resp->cookie = argp->cookie;
-
-	/* Obtain client and file */
-	if ((resp->status = nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
-		return resp->status == nlm__int__drop_reply ?
-			rpc_drop_reply : rpc_success;
-
-	/* Now try to lock the file */
-	resp->status = cast_status(nlmsvc_lock(rqstp, file, host, &argp->lock,
-					       argp->block, &argp->cookie,
-					       argp->reclaim));
-	if (resp->status == nlm__int__drop_reply)
-		rc = rpc_drop_reply;
-	else
-		dprintk("lockd: LOCK         status %d\n", ntohl(resp->status));
-
-	nlmsvc_release_lockowner(&argp->lock);
-	nlmsvc_release_host(host);
-	nlm_release_file(file);
-	return rc;
-}
-
 static __be32
 nlmsvc_do_lock(struct svc_rqst *rqstp, bool monitored)
 {
@@ -1218,18 +1186,34 @@ static __be32 nlmsvc_proc_unshare(struct svc_rqst *rqstp)
 		rpc_drop_reply : rpc_success;
 }
 
-/*
- * NM_LOCK: Create an unmonitored lock
+/**
+ * nlmsvc_proc_nm_lock - NM_LOCK: Establish a non-monitored lock
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_drop_reply:		Do not send an RPC reply.
+ *
+ * RPC synopsis:
+ *   nlm_res NLM_NM_LOCK(nlm_lockargs) = 22;
+ *
+ * Permissible procedure status codes:
+ *   %LCK_GRANTED:		The requested lock was granted.
+ *   %LCK_DENIED:		The requested lock conflicted with existing
+ *				lock reservations for the file.
+ *   %LCK_DENIED_NOLOCKS:	The server could not allocate the resources
+ *				needed to process the request.
+ *   %LCK_BLOCKED:		The blocking request cannot be granted
+ *				immediately. The server will send an
+ *				NLM_GRANTED callback to the client when
+ *				the lock can be granted.
+ *   %LCK_DENIED_GRACE_PERIOD:	The server has recently restarted and is
+ *				re-establishing existing locks, and is not
+ *				yet ready to accept normal service requests.
  */
-static __be32
-nlmsvc_proc_nm_lock(struct svc_rqst *rqstp)
+static __be32 nlmsvc_proc_nm_lock(struct svc_rqst *rqstp)
 {
-	struct lockd_args *argp = rqstp->rq_argp;
-
-	dprintk("lockd: NM_LOCK       called\n");
-
-	argp->monitor = 0;		/* just clean the monitor flag */
-	return __nlmsvc_proc_lock(rqstp, rqstp->rq_resp);
+	return nlmsvc_do_lock(rqstp, false);
 }
 
 /*
@@ -1482,15 +1466,15 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_xdrressize	= NLM3_nlm_shareres_sz,
 		.pc_name	= "UNSHARE",
 	},
-	[NLMPROC_NM_LOCK] = {
-		.pc_func = nlmsvc_proc_nm_lock,
-		.pc_decode = nlmsvc_decode_lockargs,
-		.pc_encode = nlmsvc_encode_res,
-		.pc_argsize = sizeof(struct lockd_args),
-		.pc_argzero = sizeof(struct lockd_args),
-		.pc_ressize = sizeof(struct lockd_res),
-		.pc_xdrressize = Ck+St,
-		.pc_name = "NM_LOCK",
+	[NLM_NM_LOCK] = {
+		.pc_func	= nlmsvc_proc_nm_lock,
+		.pc_decode	= nlm_svc_decode_nlm_lockargs,
+		.pc_encode	= nlm_svc_encode_nlm_res,
+		.pc_argsize	= sizeof(struct nlm_lockargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= sizeof(struct nlm_res_wrapper),
+		.pc_xdrressize	= NLM3_nlm_res_sz,
+		.pc_name	= "NM_LOCK",
 	},
 	[NLMPROC_FREE_ALL] = {
 		.pc_func = nlmsvc_proc_free_all,

-- 
2.54.0


