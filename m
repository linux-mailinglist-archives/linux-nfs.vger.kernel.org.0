Return-Path: <linux-nfs+bounces-18989-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGnCEw3nlGmjIgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18989-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:09:17 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5D9151519
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B0C23063D6C
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 22:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B46313527;
	Tue, 17 Feb 2026 22:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlAiqJCu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56971313276
	for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 22:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366051; cv=none; b=du0HZMaqhwBkfI+9x19/VYX+gP6++lRec4NSC/ciaXrKEx/7D1d4i9LAtCbRJfrvi92r9Ur49Cotqhzsn5XNaDNAUvpmTBrnBmqSynsKKEX7jexcuM+2L83Q2Ju5saZC4NUM1sTBKtj5qgHJRgRoa3/T61hSmBv44iVDC/cL0C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366051; c=relaxed/simple;
	bh=DFvHCC5oNIZ1Y9lMOq7JP6MsqWyZXZOpOqBoDY5TrNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uM75QoshbPSYZVY3I74dSvLnjHaSmbn2oQS6uzUFUcjBLQHZ9cZrYjT364Ju4dI2G2R9HzXw4e7+HCyU12qF8Y+X2Zy3pWIvHbHMyusaAV3RAQrn0iS6Gy+AIMfnsn9vrZtIt73Hi2bzgpfFqvtW6mhJAgZFt2+prRd40ZhIQtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlAiqJCu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6A1C19421;
	Tue, 17 Feb 2026 22:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771366051;
	bh=DFvHCC5oNIZ1Y9lMOq7JP6MsqWyZXZOpOqBoDY5TrNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XlAiqJCu3VA2gfYIZ+ymiq8SscJYEjZf6/kGPK8U2JIRbQoVHgDPnfbbLDRi4sK8Y
	 PaL+2p4nGcpq30dQ5dGpoDMfYFZAJOS4hgQBHgNv8k+b7mgP4/sPc9q9AXZdmAx7FO
	 /pCBdmYrkvmiXRxqbfiumVUkNyxwFJ+v9TU2RNqlHirINep0Ac++TH08w5vjKV6jIR
	 9IDNvqk9EFl8f43Db7+9LIWKQrIXJGVK+W4H2dTjwk67gLoPSPMrOeQACNwON6lcqs
	 PXRpNFuKdHslsdOwwYTC1/mOajUV7LR50pPzsR2jyIIIGT4nJI90YI8xaCjyOekFEd
	 c5qcMmPC7ncTw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 06/29] lockd: Use xdrgen XDR functions for the NLMv4 UNLOCK procedure
Date: Tue, 17 Feb 2026 17:06:58 -0500
Message-ID: <20260217220721.1928847-7-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-18989-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D5D9151519
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

UNLOCK releases locks acquired via the LOCK procedure. Conversion
of TEST, LOCK, CANCEL, and UNLOCK provides the complete set of
lock lifecycle operations required by the NLM protocol, enabling
clients to test for conflicts, acquire locks, abort pending lock
requests, and release held locks.

The procedure handler converts arguments from the xdrgen-generated
nlm4_unlockargs structure to the legacy nlm_lock representation
through nlm4_unlockargs_wrapper. This maintains compatibility with
core lockd logic while using XDR decoders and encoders generated
from the NLMv4 protocol specification.

The original __nlm4svc_proc_unlock function is retained because
the asynchronous callback path invokes it directly, bypassing
the RPC dispatch mechanism.

The pc_argzero field is zero because nlm4_svc_decode_nlm4_unlockargs
initializes all fields in argp->xdrgen, eliminating the need for
early memset of the argument buffer. Remaining argp fields outside
the xdrgen structure are cleared explicitly where needed.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 84 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 10 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 4a3815599a65..de1a9cf416ec 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -55,6 +55,13 @@ struct nlm4_cancargs_wrapper {
 
 static_assert(offsetof(struct nlm4_cancargs_wrapper, xdrgen) == 0);
 
+struct nlm4_unlockargs_wrapper {
+	struct nlm4_unlockargs		xdrgen;
+	struct nlm_lock			lock;
+};
+
+static_assert(offsetof(struct nlm4_unlockargs_wrapper, xdrgen) == 0);
+
 struct nlm4_testres_wrapper {
 	struct nlm4_testres		xdrgen;
 	struct nlm_lock			lock;
@@ -601,10 +608,66 @@ __nlm4svc_proc_unlock(struct svc_rqst *rqstp, struct nlm_res *resp)
 	return rpc_success;
 }
 
+/**
+ * nlm4svc_proc_unlock - UNLOCK: Remove a lock
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_drop_reply:		Do not send an RPC reply.
+ *
+ * RPC synopsis:
+ *   nlm4_res NLMPROC4_UNLOCK(nlm4_unlockargs) = 4;
+ *
+ * Permissible procedure status codes:
+ *   %NLM4_GRANTED:		The requested lock was released.
+ *   %NLM4_DENIED_GRACE_PERIOD:	The server has recently restarted and is
+ *				re-establishing existing locks, and is not
+ *				yet ready to accept normal service requests.
+ *
+ * The Linux NLM server implementation also returns:
+ *   %NLM4_DENIED_NOLOCKS:	A needed resource could not be allocated.
+ *   %NLM4_STALE_FH:		The request specified an invalid file handle.
+ *   %NLM4_FBIG:		The request specified a length or offset
+ *				that exceeds the range supported by the
+ *				server.
+ *   %NLM4_FAILED:		The request failed for an unspecified reason.
+ */
 static __be32
 nlm4svc_proc_unlock(struct svc_rqst *rqstp)
 {
-	return __nlm4svc_proc_unlock(rqstp, rqstp->rq_resp);
+	struct nlm4_unlockargs_wrapper *argp = rqstp->rq_argp;
+	struct nlm4_res_wrapper *resp = rqstp->rq_resp;
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
+	host = nlm4svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, false);
+	if (!host)
+		goto out;
+
+	resp->xdrgen.stat.stat = nlm4svc_lookup_file(rqstp, host, &argp->lock,
+						     &file, &argp->xdrgen.alock,
+						     F_UNLCK);
+	if (resp->xdrgen.stat.stat)
+		goto out;
+
+	resp->xdrgen.stat.stat = nlmsvc_unlock(net, file, &argp->lock);
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
@@ -914,15 +977,15 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 		.pc_xdrressize	= NLM4_nlm4_res_sz,
 		.pc_name	= "CANCEL",
 	},
-	[NLMPROC_UNLOCK] = {
-		.pc_func = nlm4svc_proc_unlock,
-		.pc_decode = nlm4svc_decode_unlockargs,
-		.pc_encode = nlm4svc_encode_res,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
-		.pc_ressize = sizeof(struct nlm_res),
-		.pc_xdrressize = Ck+St,
-		.pc_name = "UNLOCK",
+	[NLMPROC4_UNLOCK] = {
+		.pc_func	= nlm4svc_proc_unlock,
+		.pc_decode	= nlm4_svc_decode_nlm4_unlockargs,
+		.pc_encode	= nlm4_svc_encode_nlm4_res,
+		.pc_argsize	= sizeof(struct nlm4_unlockargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= sizeof(struct nlm4_res_wrapper),
+		.pc_xdrressize	= NLM4_nlm4_res_sz,
+		.pc_name	= "UNLOCK",
 	},
 	[NLMPROC_GRANTED] = {
 		.pc_func = nlm4svc_proc_granted,
@@ -1123,6 +1186,7 @@ union nlm4svc_xdrstore {
 	struct nlm4_testargs_wrapper	testargs;
 	struct nlm4_lockargs_wrapper	lockargs;
 	struct nlm4_cancargs_wrapper	cancargs;
+	struct nlm4_unlockargs_wrapper	unlockargs;
 	struct nlm4_testres_wrapper	testres;
 	struct nlm4_res_wrapper		res;
 	struct nlm_args			args;
-- 
2.53.0


