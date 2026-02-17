Return-Path: <linux-nfs+bounces-18987-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIfeKwXnlGmjIgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18987-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:09:09 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5353B15150A
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1519C30620D0
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 22:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E3A313526;
	Tue, 17 Feb 2026 22:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wok8zMWc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C443D31328B
	for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 22:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366049; cv=none; b=CGgh4c7gRcYum4uS2424KDfho+BSjBL/NL/gnPHJzpy1aQ4eCXWsmfPelM+1HlRF+VZQxsHUcpLL/1HEJ/q6wK6Mxkf7HbJQvKujTGfXlV7bV11P6bmhIVCwjajinS7PQtQcb4l3nJ6tRocJzqlKtunDykfkhbkzH2loLBZURcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366049; c=relaxed/simple;
	bh=yioTrCItEo/gAvPmFKB4nn1+5f509okxKUcfVTRouEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eD8MaVV1hW32lDB+qFo9R41Cff80mVym44/TZYN9zZ4aHXQ93cblRZd/rXIeQ7uoeDQ889ZrOCj+eKAKoB6UYaTViWvfTT6xWf/AzRqUVnfoUmyu6q1TRbcsZaKqs1fiNTofO26SGH25LznMjQu5NMAa7dBpMC2Ldjno0Nwoqdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wok8zMWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAF0C19421;
	Tue, 17 Feb 2026 22:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771366049;
	bh=yioTrCItEo/gAvPmFKB4nn1+5f509okxKUcfVTRouEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wok8zMWcQJaGUMyKeKKyCWZze/QoYgQPX8fkeykij1Sea93/TDt3QnxHt5teafjox
	 t1533AB3Dz3AUMziPiBEE7+AGVp1IxOx4TU7JWqRvBT0QD9QMnLawrx9qQizQzPNe7
	 U5Bd/ZUrlKq/Hz2i/icpEudj4MShqflkcCcLgPABHo4ndGjhY0Cu+BjSdfYlEZ2njN
	 OT83xEH7TqtAV++nbx7CBNzyUdvx88dqS2rLDbNCOyAfuOOwz9RQ0bBwYvwGDiRePw
	 Du9CiuzHQAKetuvVu7Ba4ERmQhVr7zzZz0l79PyLOxpH8tep7+e67iBcyccu++Dzk3
	 FUMSjk0wmU1PQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 04/29] lockd: Use xdrgen XDR functions for the NLMv4 LOCK procedure
Date: Tue, 17 Feb 2026 17:06:56 -0500
Message-ID: <20260217220721.1928847-5-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-18987-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 5353B15150A
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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 127 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 115 insertions(+), 12 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index b07ab4d60871..2cad72562ef2 100644
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
@@ -355,10 +379,88 @@ __nlm4svc_proc_lock(struct svc_rqst *rqstp, struct nlm_res *resp)
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
+	return resp->xdrgen.stat.stat == nlm__int__drop_reply ?
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
@@ -629,7 +731,7 @@ nlm4svc_proc_nm_lock(struct svc_rqst *rqstp)
 	dprintk("lockd: NM_LOCK       called\n");
 
 	argp->monitor = 0;		/* just clean the monitor flag */
-	return nlm4svc_proc_lock(rqstp);
+	return __nlm4svc_proc_lock(rqstp, rqstp->rq_resp);
 }
 
 /*
@@ -727,15 +829,15 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
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
@@ -954,9 +1056,10 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
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
2.53.0


