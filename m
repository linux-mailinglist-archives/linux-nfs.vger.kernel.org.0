Return-Path: <linux-nfs+bounces-18379-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AKyG9vDc2kCygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18379-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:19 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F8D79D5E
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AB413045000
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BC42741AB;
	Fri, 23 Jan 2026 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ka9Fjfv+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B488C284880
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194397; cv=none; b=evwLkmpSEpbEGoQM6FOhoy5CvTMHut9zKZfiqpIAqVtEWtqXc4GHqX8heQgYUjF7mMRyFL9DB/zbgiC5mGL/e7ZfKdZH83hVs7kuDmC1/NvMDwE80edNeXpu0Fg7vEDCXWFuth2gK8jJQATe+t+T3rS2LKwrynGA24QQ7ndH9rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194397; c=relaxed/simple;
	bh=QsjMzW4C8a+s7Vr174cWB4ZwKXG5s1Bi8I8FdZ8tus4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9s7REkfsyKawT02rNjPbBMbnBhTWfRiiXsPw9gLwkwKa5bL6524HyydNumUUo3I0b60lAp/vmDN0jYcvtk4batoCMYXxA8s5ohefxU2WZeeyhkWCKVajOoSyoFAD0TLje/clR5cEiT1xPPoFSlh8I+nE53Hp1NlEoCv9mvuCOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ka9Fjfv+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC5BC19425;
	Fri, 23 Jan 2026 18:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194397;
	bh=QsjMzW4C8a+s7Vr174cWB4ZwKXG5s1Bi8I8FdZ8tus4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ka9Fjfv+cI55dubKh5XlfKDWXp6XJq15F1Dlxjh3W57JqH8sQaKhATRApjcE7p7kK
	 Ebv3RcDDPUrGAn70lSzl18zo+XqKs2Bpga19KmQhO4hwbPcCGM3glCJRQlUr/fvMWf
	 Ix6jfuFD3ie7omm8tM6UxsGgd7h4FNnaFMX2L3Nemy1S4sszFTOGBvQdnzQHrCxfEL
	 hZDXO8qj1QUOiMFVvP8CjizCNobuuK45BjW6vIxNTMzu4RcxUgRFbeeECkZGRxQ98v
	 9FYLG8DgDUDZC7HRt+OOupt32MHTTp+KfcomPbJ99nnwPUN5OhV33D14U/bB2mQC7u
	 3TYcEvASyCOrg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 18/42] lockd: Use xdrgen XDR functions for the NLMv4 CANCEL procedure
Date: Fri, 23 Jan 2026 13:52:35 -0500
Message-ID: <20260123185259.1215767-19-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18379-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 22F8D79D5E
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The NLM CANCEL procedure allows clients to cancel outstanding
blocked lock requests, completing the set of lock-related
operations that share common lookup patterns. This patch
continues the xdrgen migration by converting the CANCEL
procedure, leveraging the same nlm4svc_lookup_host() and
nlm4svc_lookup_file() helpers established in the TEST procedure
conversion to maintain consistency across the series.

This patch converts the CANCEL procedure to use xdrgen functions
nlm4_svc_decode_nlm4_cancargs and nlm4_svc_encode_nlm4_res
generated from the NLM version 4 protocol specification. The
procedure handler uses xdrgen types through a wrapper structure
that bridges between generated code and the legacy nlm_lock
representation still used by the core lockd logic.

The pc_argzero field is set to zero because xdrgen decoders
reliably initialize all arguments in the argp->xdrgen field,
making the early defensive memset unnecessary. Remaining argp
fields are cleared as needed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 86 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 76 insertions(+), 10 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 2da3ff76be5a..1b70935df4d0 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -48,6 +48,13 @@ struct nlm4_lockargs_wrapper {
 
 static_assert(offsetof(struct nlm4_lockargs_wrapper, xdrgen) == 0);
 
+struct nlm4_cancargs_wrapper {
+	struct nlm4_cancargs		xdrgen;
+	struct nlm_lock			lock;
+};
+
+static_assert(offsetof(struct nlm4_cancargs_wrapper, xdrgen) == 0);
+
 struct nlm4_testres_wrapper {
 	struct nlm4_testres		xdrgen;
 	struct nlm_lock			lock;
@@ -487,10 +494,68 @@ __nlm4svc_proc_cancel(struct svc_rqst *rqstp, struct nlm_res *resp)
 	return rpc_success;
 }
 
+/**
+ * nlm4svc_proc_cancel - CANCEL: Cancel an outstanding blocked lock request
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully
+ *   %rpc_drop_reply:		Do not send an RPC reply
+ *
+ * RPC synopsis:
+ *   nlm4_res NLMPROC4_CANCEL(nlm4_cancargs) = 3;
+ *
+ * Permissible procedure status codes:
+ *   %NLM4_LCK_GRANTED:		The requested lock was canceled.
+ *   %NLM4_LCK_DENIED:		There was no lock to cancel.
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
 nlm4svc_proc_cancel(struct svc_rqst *rqstp)
 {
-	return __nlm4svc_proc_cancel(rqstp, rqstp->rq_resp);
+	struct nlm4_cancargs_wrapper *argp = rqstp->rq_argp;
+	unsigned char type = argp->xdrgen.exclusive ? F_WRLCK : F_RDLCK;
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
+	return resp->xdrgen.stat.stat == nlm_drop_reply ?
+		rpc_drop_reply : rpc_success;
 }
 
 /*
@@ -828,15 +893,15 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 		.pc_xdrressize	= NLM4_nlm4_res_sz,
 		.pc_name	= "LOCK",
 	},
-	[NLMPROC_CANCEL] = {
-		.pc_func = nlm4svc_proc_cancel,
-		.pc_decode = nlm4svc_decode_cancargs,
-		.pc_encode = nlm4svc_encode_res,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
-		.pc_ressize = sizeof(struct nlm_res),
-		.pc_xdrressize = Ck+St,
-		.pc_name = "CANCEL",
+	[NLMPROC4_CANCEL] = {
+		.pc_func	= nlm4svc_proc_cancel,
+		.pc_decode	= nlm4_svc_decode_nlm4_cancargs,
+		.pc_encode	= nlm4_svc_encode_nlm4_res,
+		.pc_argsize	= sizeof(struct nlm4_cancargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= sizeof(struct nlm4_res_wrapper),
+		.pc_xdrressize	= NLM4_nlm4_res_sz,
+		.pc_name	= "CANCEL",
 	},
 	[NLMPROC_UNLOCK] = {
 		.pc_func = nlm4svc_proc_unlock,
@@ -1046,6 +1111,7 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 union nlm4svc_xdrstore {
 	struct nlm4_testargs_wrapper	testargs;
 	struct nlm4_lockargs_wrapper	lockargs;
+	struct nlm4_cancargs_wrapper	cancargs;
 	struct nlm4_testres_wrapper	testres;
 	struct nlm4_res_wrapper		res;
 	struct nlm_args			args;
-- 
2.52.0


