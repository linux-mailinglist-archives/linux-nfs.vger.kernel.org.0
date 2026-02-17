Return-Path: <linux-nfs+bounces-19008-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNeVDrbmlGmjIgIAu9opvQ
	(envelope-from <linux-nfs+bounces-19008-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:07:50 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 251D91514C9
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 322AD3023699
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 22:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5D4313525;
	Tue, 17 Feb 2026 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7+nmDdo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB00A31328B
	for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366066; cv=none; b=IpBWr3fgrgF1UDGoItlK76vUHres7yIrUZ+gv8WgsNKpCXI0aA66RN8VYOPGjsn76syiQxHeiA7Sx2zUXM/qOBo+MZO5rMYVok2xWq8zvWx8QMr3Jq3OrWA9X+ZaqXj7mNTPVGP4tMWMcnxh7by+BDlEZKEKtRcuwGQ8NNVXWu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366066; c=relaxed/simple;
	bh=5bjKPV6a4kv998TDS8ngfS2MJIjn2wLWKR/TOawapDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtwuSeUX6fpFeiK2yelWct3cxLVauajGX6UKuzU7+Xv2iSsqAyLtf0B+wrM8a8oZOF4bPQDOL3YYbPh/y+VJh9PWyY4liCXVBwGtuv7d7YrUqczqV4H7u4EfeeCmF+//sc0cPdapQrFRMhz/l6tfcToctiELLUiqOccgxH/eTgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7+nmDdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EDEC4CEF7;
	Tue, 17 Feb 2026 22:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771366066;
	bh=5bjKPV6a4kv998TDS8ngfS2MJIjn2wLWKR/TOawapDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t7+nmDdoQ6ZCTi8MQxxqHCbk5ims0bFqCMaH3zyzkRzgNaQYSoaJcnPr8uoGV/GG7
	 JvmIeap07GTj2fQRa7l5AFB8NRvIpRh0d3l1ctNMx2oACdi21ZigMEjrHPK20V0g6b
	 QL+qayklt0pYtJFzr3T8L551mKar+EwdYvx79KKY4eX0kspw+UypqT9Sucu2yU2Gez
	 waY90s4UyUozb55gwIhc0fQSwMylY8RtlJTMLbMqpXd6jIGJDxLb1Y4352xZ2O9t6p
	 L3X0++txih57x2WXaaOyTC9vK3beuRU56zxiO1g0uPathbG887Qrt2AD7TuQzvExGV
	 W0I45QH7IzGzw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 25/29] lockd: Use xdrgen XDR functions for the NLMv4 NM_LOCK procedure
Date: Tue, 17 Feb 2026 17:07:17 -0500
Message-ID: <20260217220721.1928847-26-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-19008-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 251D91514C9
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Now that nlm4svc_do_lock() has been introduced to handle both
monitored and non-monitored lock requests, the NLMv4 NM_LOCK
procedure can be converted to use xdrgen-generated XDR
functions. This conversion allows the removal of
__nlm4svc_proc_lock(), a helper function that was previously
shared between the LOCK and NM_LOCK procedures.

Replace the NLMPROC4_NM_LOCK entry in the nlm_procedures4
array with an entry that uses xdrgen-built XDR decoders and
encoders. The procedure handler is updated to call
nlm4svc_do_lock() directly and access arguments through the
argp->xdrgen hierarchy.

The .pc_argzero field is set to zero because xdrgen decoders
fully initialize all fields in argp->xdrgen, making the early
defensive memset unnecessary. The remaining argp fields that
fall outside the xdrgen structures are cleared explicitly as
needed.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 101 +++++++++++++++++++-------------------------
 1 file changed, 44 insertions(+), 57 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 5d85f888fdf4..62c90827dfae 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -358,44 +358,6 @@ static __be32 nlm4svc_proc_test(struct svc_rqst *rqstp)
 		rpc_drop_reply : rpc_success;
 }
 
-static __be32
-__nlm4svc_proc_lock(struct svc_rqst *rqstp, struct nlm_res *resp)
-{
-	struct nlm_args *argp = rqstp->rq_argp;
-	struct nlm_host	*host;
-	struct nlm_file	*file;
-	__be32 rc = rpc_success;
-
-	dprintk("lockd: LOCK          called\n");
-
-	resp->cookie = argp->cookie;
-
-	/* Obtain client and file */
-	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
-		return resp->status == nlm__int__drop_reply ?
-			rpc_drop_reply : rpc_success;
-
-	/* Now try to lock the file */
-	resp->status = nlmsvc_lock(rqstp, file, host, &argp->lock,
-					argp->block, &argp->cookie,
-					argp->reclaim);
-	switch (resp->status) {
-	case nlm__int__drop_reply:
-		rc = rpc_drop_reply;
-		break;
-	case nlm__int__deadlock:
-		resp->status = nlm4_deadlock;
-		fallthrough;
-	default:
-		dprintk("lockd: LOCK         status %d\n", ntohl(resp->status));
-	}
-
-	nlmsvc_release_lockowner(&argp->lock);
-	nlmsvc_release_host(host);
-	nlm_release_file(file);
-	return rc;
-}
-
 static __be32
 nlm4svc_do_lock(struct svc_rqst *rqstp, bool monitored)
 {
@@ -1190,18 +1152,43 @@ static __be32 nlm4svc_proc_unshare(struct svc_rqst *rqstp)
 		rpc_drop_reply : rpc_success;
 }
 
-/*
- * NM_LOCK: Create an unmonitored lock
+/**
+ * nlm4svc_proc_nm_lock - NM_LOCK: Establish a non-monitored lock
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_drop_reply:		Do not send an RPC reply.
+ *
+ * RPC synopsis:
+ *   nlm4_res NLMPROC4_NM_LOCK(nlm4_lockargs) = 22;
+ *
+ * Permissible procedure status codes:
+ *   %NLM4_GRANTED:		The requested lock was granted.
+ *   %NLM4_DENIED:		The requested lock conflicted with existing
+ *				lock reservations for the file.
+ *   %NLM4_DENIED_NOLOCKS:	The server could not allocate the resources
+ *				needed to process the request.
+ *   %NLM4_BLOCKED:		The blocking request cannot be granted
+ *				immediately. The server will send an
+ *				NLMPROC4_GRANTED callback to the client when
+ *				the lock can be granted.
+ *   %NLM4_DENIED_GRACE_PERIOD:	The server has recently restarted and is
+ *				re-establishing existing locks, and is not
+ *				yet ready to accept normal service requests.
+ *
+ * The Linux NLM server implementation also returns:
+ *   %NLM4_DEADLCK:		The request could not be granted and
+ *				blocking would cause a deadlock.
+ *   %NLM4_STALE_FH:		The request specified an invalid file handle.
+ *   %NLM4_FBIG:		The request specified a length or offset
+ *				that exceeds the range supported by the
+ *				server.
+ *   %NLM4_FAILED:		The request failed for an unspecified reason.
  */
-static __be32
-nlm4svc_proc_nm_lock(struct svc_rqst *rqstp)
+static __be32 nlm4svc_proc_nm_lock(struct svc_rqst *rqstp)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
-
-	dprintk("lockd: NM_LOCK       called\n");
-
-	argp->monitor = 0;		/* just clean the monitor flag */
-	return __nlm4svc_proc_lock(rqstp, rqstp->rq_resp);
+	return nlm4svc_do_lock(rqstp, false);
 }
 
 /*
@@ -1455,15 +1442,15 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 		.pc_xdrressize	= NLM4_nlm4_shareres_sz,
 		.pc_name	= "UNSHARE",
 	},
-	[NLMPROC_NM_LOCK] = {
-		.pc_func = nlm4svc_proc_nm_lock,
-		.pc_decode = nlm4svc_decode_lockargs,
-		.pc_encode = nlm4svc_encode_res,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
-		.pc_ressize = sizeof(struct nlm_res),
-		.pc_xdrressize = Ck+St,
-		.pc_name = "NM_LOCK",
+	[NLMPROC4_NM_LOCK] = {
+		.pc_func	= nlm4svc_proc_nm_lock,
+		.pc_decode	= nlm4_svc_decode_nlm4_lockargs,
+		.pc_encode	= nlm4_svc_encode_nlm4_res,
+		.pc_argsize	= sizeof(struct nlm4_lockargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= sizeof(struct nlm4_res_wrapper),
+		.pc_xdrressize	= NLM4_nlm4_res_sz,
+		.pc_name	= "NM_LOCK",
 	},
 	[NLMPROC_FREE_ALL] = {
 		.pc_func = nlm4svc_proc_free_all,
-- 
2.53.0


