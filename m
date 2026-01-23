Return-Path: <linux-nfs+bounces-18378-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gExzJNnDc2kCygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18378-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:17 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD3E79D57
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E3F13032DF3
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA0D3EBF37;
	Fri, 23 Jan 2026 18:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdQ7b60O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CAD2741AB
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194396; cv=none; b=BjEr+ErFgaAqdpMxJz5fHbIk+TgrCb68VaEefEl+B4dIVcIxwXKFYwOMZZNwM+1kQ/18K8diiSPlyyJINXbGUqZDE9Tv9H+r1UtE+/fHgZx6074Q5En/e5ZN1Pyq+czTtrpM7iANQJmJ3Y5xjLW7rWOVz9tuk8rxN5teu8/MAys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194396; c=relaxed/simple;
	bh=KGW9gxyGVsi4sOG033bFKdd75i1fVL4gPkb69FndrQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGRgUMn1RvyrcpD4ce2RnN2xs3w2errv1ZhvZ4RRkhNyxrGED8uIytxzE97ef4FoWNxOpEEFTEm2uLPc5FjGFpEmk/25XdsArAZs0uDbKLlbW+HzK+IDpvHGvLYKPkqMo4jiNdcAOGmYWosB6em4tqNSG0iHqcTcTVVCT6JA7yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdQ7b60O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4F8C19424;
	Fri, 23 Jan 2026 18:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194396;
	bh=KGW9gxyGVsi4sOG033bFKdd75i1fVL4gPkb69FndrQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LdQ7b60OaU0T9iGaIUmvDqjXpU5SW4LbB+gjEtpQGoaK0Tq9GtE71ploKigdEWOHF
	 OE4iLk9fAyIHF6CsN4CLbSV/GC1zAAGvMCyIRgR/RzO8RNvFDmbvnYE1um4BstiJse
	 Ru0c6GEXP3LcQ9tUzPX1J3T/rdrnvL2Led6prjXpk2BQu/7BSA4Q+TwTbdSWJIq126
	 eXBbeHy0u9I8mfx5hoAFUXqZzsmPFe6d4K2dYpDVXLDMT/kB4XFyT779QKhrHlbO0e
	 sXnz64ahnm+Sn4mitd8+fxoDhLrXdAbM1TypE68Vf7nxarMz29FIL0/JWHyx89Iw+X
	 EzQKqyZ+aj8LA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 17/42] lockd: Use xdrgen XDR functions for the NLMv4 LOCK procedure
Date: Fri, 23 Jan 2026 13:52:34 -0500
Message-ID: <20260123185259.1215767-18-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-18378-lists,linux-nfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 2BD3E79D57
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Replace legacy XDR handling in the LOCK procedure with xdrgen-
generated functions nlm4_svc_decode_lockargs and
nlm4_svc_encode_res.

The new nlm4svc_do_lock() handler replaces __nlm4svc_proc_lock()
at the NLMPROC4_LOCK entry point. Wrapper structures bridge
xdrgen types to the legacy nlm_lock representation used by core
lockd. The nlm4svc_lookup_host() and nlm4svc_lookup_file()
helpers from the TEST conversion handle host and file lookup.

The pc_argzero field is set to zero: xdrgen-generated decoders
initialize all fields in argp->xdrgen, so a defensive memset is
unnecessary. The wrapper's cookie and lock fields are cleared
by nlm4svc_do_lock() before use.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 127 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 115 insertions(+), 12 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 200544f0977f..2da3ff76be5a 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -40,6 +40,14 @@ struct nlm4_testargs_wrapper {
 
 static_assert(offsetof(struct nlm4_testargs_wrapper, xdrgen) == 0);
 
+struct nlm4_lockargs_wrapper {
+	struct nlm4_lockargs		xdrgen;
+	struct nlm_cookie		cookie;
+	struct nlm_lock			lock;
+};
+
+static_assert(offsetof(struct nlm4_lockargs_wrapper, xdrgen) == 0);
+
 struct nlm4_testres_wrapper {
 	struct nlm4_testres		xdrgen;
 	struct nlm_lock			lock;
@@ -47,6 +55,22 @@ struct nlm4_testres_wrapper {
 
 static_assert(offsetof(struct nlm4_testres_wrapper, xdrgen) == 0);
 
+struct nlm4_res_wrapper {
+	struct nlm4_res			xdrgen;
+};
+
+static_assert(offsetof(struct nlm4_res_wrapper, xdrgen) == 0);
+
+static __be32
+nlm4_netobj_to_cookie(struct nlm_cookie *cookie, netobj *object)
+{
+	if (object->len > NLM_MAXCOOKIELEN)
+		return nlm_lck_denied_nolocks;
+	cookie->len = object->len;
+	memcpy(cookie->data, object->data, object->len);
+	return nlm_granted;
+}
+
 static struct nlm_host *
 nlm4svc_lookup_host(struct svc_rqst *rqstp, string caller, bool monitored)
 {
@@ -348,10 +372,88 @@ __nlm4svc_proc_lock(struct svc_rqst *rqstp, struct nlm_res *resp)
 	return rc;
 }
 
+static __be32
+nlm4svc_do_lock(struct svc_rqst *rqstp, bool monitored)
+{
+	struct nlm4_lockargs_wrapper *argp = rqstp->rq_argp;
+	unsigned char type = argp->xdrgen.exclusive ? F_WRLCK : F_RDLCK;
+	struct nlm4_res_wrapper *resp = rqstp->rq_resp;
+	struct nlm_file	*file = NULL;
+	struct nlm_host	*host = NULL;
+
+	resp->xdrgen.cookie = argp->xdrgen.cookie;
+
+	resp->xdrgen.stat.stat = nlm4_netobj_to_cookie(&argp->cookie,
+						       &argp->xdrgen.cookie);
+	if (resp->xdrgen.stat.stat)
+		goto out;
+
+	resp->xdrgen.stat.stat = nlm_lck_denied_nolocks;
+	host = nlm4svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name,
+				   monitored);
+	if (!host)
+		goto out;
+
+	resp->xdrgen.stat.stat = nlm4svc_lookup_file(rqstp, host, &argp->lock,
+						     &file, &argp->xdrgen.alock,
+						     type);
+	if (resp->xdrgen.stat.stat)
+		goto out;
+
+	resp->xdrgen.stat.stat = nlmsvc_lock(rqstp, file, host, &argp->lock,
+					     argp->xdrgen.block, &argp->cookie,
+					     argp->xdrgen.reclaim);
+	if (resp->xdrgen.stat.stat == nlm__int__deadlock)
+		resp->xdrgen.stat.stat = nlm4_deadlock;
+
+	nlmsvc_release_lockowner(&argp->lock);
+
+out:
+	if (file)
+		nlm_release_file(file);
+	nlmsvc_release_host(host);
+	return resp->xdrgen.stat.stat == nlm_drop_reply ?
+		rpc_drop_reply : rpc_success;
+}
+
+/**
+ * nlm4svc_proc_lock - LOCK: Establish a monitored lock
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_drop_reply:		Do not send an RPC reply.
+ *
+ * RPC synopsis:
+ *   nlm4_res NLMPROC4_LOCK(nlm4_lockargs) = 2;
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
+ */
 static __be32
 nlm4svc_proc_lock(struct svc_rqst *rqstp)
 {
-	return __nlm4svc_proc_lock(rqstp, rqstp->rq_resp);
+	return nlm4svc_do_lock(rqstp, true);
 }
 
 static __be32
@@ -618,7 +720,7 @@ nlm4svc_proc_nm_lock(struct svc_rqst *rqstp)
 	dprintk("lockd: NM_LOCK       called\n");
 
 	argp->monitor = 0;		/* just clean the monitor flag */
-	return nlm4svc_proc_lock(rqstp);
+	return __nlm4svc_proc_lock(rqstp, rqstp->rq_resp);
 }
 
 /*
@@ -716,15 +818,15 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 		.pc_xdrressize	= NLM4_nlm4_testres_sz,
 		.pc_name	= "TEST",
 	},
-	[NLMPROC_LOCK] = {
-		.pc_func = nlm4svc_proc_lock,
-		.pc_decode = nlm4svc_decode_lockargs,
-		.pc_encode = nlm4svc_encode_res,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
-		.pc_ressize = sizeof(struct nlm_res),
-		.pc_xdrressize = Ck+St,
-		.pc_name = "LOCK",
+	[NLMPROC4_LOCK] = {
+		.pc_func	= nlm4svc_proc_lock,
+		.pc_decode	= nlm4_svc_decode_nlm4_lockargs,
+		.pc_encode	= nlm4_svc_encode_nlm4_res,
+		.pc_argsize	= sizeof(struct nlm4_lockargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= sizeof(struct nlm4_res_wrapper),
+		.pc_xdrressize	= NLM4_nlm4_res_sz,
+		.pc_name	= "LOCK",
 	},
 	[NLMPROC_CANCEL] = {
 		.pc_func = nlm4svc_proc_cancel,
@@ -943,9 +1045,10 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
  */
 union nlm4svc_xdrstore {
 	struct nlm4_testargs_wrapper	testargs;
+	struct nlm4_lockargs_wrapper	lockargs;
 	struct nlm4_testres_wrapper	testres;
+	struct nlm4_res_wrapper		res;
 	struct nlm_args			args;
-	struct nlm_res			res;
 	struct nlm_reboot		reboot;
 };
 
-- 
2.52.0


