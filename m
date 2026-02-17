Return-Path: <linux-nfs+bounces-18990-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAg/DhDnlGmjIgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18990-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:09:20 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB20D151520
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E14E3064F22
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 22:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49589313525;
	Tue, 17 Feb 2026 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1wXZuas"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27311313276
	for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366052; cv=none; b=NUtnMxyMZTzacIwXVKztTCFJMx3orp4VaFUVQeFj0TfO8jSvF2BdG+AUmrLZPmeaORWpLi3UiAJpwWTYOYsU59/yEWs3izzijF+QpENhl2HNgOchl3nOwHe1TQl0MNxPLUS6/XE6YF4cghdzaJOZYaH+8JrLgk9w/RaN+1dCVO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366052; c=relaxed/simple;
	bh=cL9KPLjG9cQTdbDehcApfh1znvKKq7d181UpnAVM6IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLxzIkAq3xQfKy6555HWBdBLmZc/W+orD8Zgsmi3bR570Y0hBS0mtGptS06O9R5k04eiSvUkGTqgevQG0qtGRxddlH23IRQWtnOQAVhS5elVu5dGqmghx4yddXlZQjfJJCBD3IToRvJ9NXufK5O94z3VDUPaEWBMhxXYogLVRcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1wXZuas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713FEC19423;
	Tue, 17 Feb 2026 22:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771366052;
	bh=cL9KPLjG9cQTdbDehcApfh1znvKKq7d181UpnAVM6IY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A1wXZuaszPOj9JQiR4wNj2ZoODBmc9/L12GMpdFBFb3e8t0i9kZ9sZFMCkq/OYZnC
	 baqaJ8vwb0zWb166vuOdH73spMdIB/lpurkmzT49HxgBQUNxvJSer+blRyWuhvSe8a
	 VizelU1sieID7v4ihIOvtZOOyuzGZDaV3UGli7MqEdhP1MHlfg3KCQNpMDu+j7ubBZ
	 KMT4mU7BcObMFmhSqxyIAZUiOs5FPTshAU6n0rTzs/dTFqT/LmHIFP3KJd0ZJ0y6rW
	 7U+MEvOhXFvP/D8u490cYf8gb1/jQLbWy5poKiM4kz/fGv2I75Um+tvotj+n+aylA0
	 dZbQgnW+3VbBQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 07/29] lockd: Use xdrgen XDR functions for the NLMv4 GRANTED procedure
Date: Tue, 17 Feb 2026 17:06:59 -0500
Message-ID: <20260217220721.1928847-8-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-18990-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: CB20D151520
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The NLM GRANTED procedure provides server-to-client notification
when a previously blocked lock request has been granted,
completing the asynchronous lock request flow. This patch
completes the xdrgen migration for basic NLMv4 procedures by
converting the GRANTED procedure, the final one in this
conversion series.

This patch converts the GRANTED procedure to use xdrgen
functions nlm4_svc_decode_nlm4_testargs and
nlm4_svc_encode_nlm4_res generated from the NLM version 4
protocol specification. The procedure handler uses xdrgen types
through a wrapper structure that bridges between generated code
and the legacy nlm_lock representation still used by the core
lockd logic.

A new helper function nlm4_lock_to_nlm_lock() is introduced to
convert xdrgen nlm4_lock structures to the legacy nlm_lock
format. This helper complements the existing
nlm4svc_lookup_host() and nlm4svc_lookup_file() functions used
throughout this series.

The pc_argzero field is set to zero because xdrgen decoders
reliably initialize all arguments in the argp->xdrgen field,
making the early defensive memset unnecessary. Remaining argp
fields are cleared as needed.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 66 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 56 insertions(+), 10 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index de1a9cf416ec..2e1a0392d68a 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -85,6 +85,21 @@ nlm4_netobj_to_cookie(struct nlm_cookie *cookie, netobj *object)
 	return nlm_granted;
 }
 
+static __be32
+nlm4_lock_to_nlm_lock(struct nlm_lock *lock, struct nlm4_lock *alock)
+{
+	if (alock->fh.len > NFS_MAXFHSIZE)
+		return nlm_lck_denied;
+	lock->fh.size = alock->fh.len;
+	memcpy(lock->fh.data, alock->fh.data, alock->fh.len);
+	lock->oh.len = alock->oh.len;
+	lock->oh.data = alock->oh.data;
+	lock->svid = alock->svid;
+	locks_init_lock(&lock->fl);
+	lockd_set_file_lock_range4(&lock->fl, alock->l_offset, alock->l_len);
+	return nlm_granted;
+}
+
 static struct nlm_host *
 nlm4svc_lookup_host(struct svc_rqst *rqstp, string caller, bool monitored)
 {
@@ -687,10 +702,41 @@ __nlm4svc_proc_granted(struct svc_rqst *rqstp, struct nlm_res *resp)
 	return rpc_success;
 }
 
+/**
+ * nlm4svc_proc_granted - GRANTED: Server grants a previously blocked lock
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *
+ * RPC synopsis:
+ *   nlm4_res NLMPROC4_GRANTED(nlm4_testargs) = 5;
+ *
+ * Permissible procedure status codes:
+ *   %NLM4_GRANTED:		The requested lock was granted.
+ *   %NLM4_DENIED:		The server could not allocate the resources
+ *				needed to process the request.
+ *   %NLM4_DENIED_GRACE_PERIOD:	The server has recently restarted and is
+ *				re-establishing existing locks, and is not
+ *				yet ready to accept normal service requests.
+ */
 static __be32
 nlm4svc_proc_granted(struct svc_rqst *rqstp)
 {
-	return __nlm4svc_proc_granted(rqstp, rqstp->rq_resp);
+	struct nlm4_testargs_wrapper *argp = rqstp->rq_argp;
+	struct nlm4_res_wrapper *resp = rqstp->rq_resp;
+
+	resp->xdrgen.cookie = argp->xdrgen.cookie;
+
+	resp->xdrgen.stat.stat = nlm4_lock_to_nlm_lock(&argp->lock,
+						       &argp->xdrgen.alock);
+	if (resp->xdrgen.stat.stat)
+		goto out;
+
+	resp->xdrgen.stat.stat = nlmclnt_grant(svc_addr(rqstp), &argp->lock);
+
+out:
+	return rpc_success;
 }
 
 /*
@@ -987,15 +1033,15 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 		.pc_xdrressize	= NLM4_nlm4_res_sz,
 		.pc_name	= "UNLOCK",
 	},
-	[NLMPROC_GRANTED] = {
-		.pc_func = nlm4svc_proc_granted,
-		.pc_decode = nlm4svc_decode_testargs,
-		.pc_encode = nlm4svc_encode_res,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
-		.pc_ressize = sizeof(struct nlm_res),
-		.pc_xdrressize = Ck+St,
-		.pc_name = "GRANTED",
+	[NLMPROC4_GRANTED] = {
+		.pc_func	= nlm4svc_proc_granted,
+		.pc_decode	= nlm4_svc_decode_nlm4_testargs,
+		.pc_encode	= nlm4_svc_encode_nlm4_res,
+		.pc_argsize	= sizeof(struct nlm4_testargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= sizeof(struct nlm4_res_wrapper),
+		.pc_xdrressize	= NLM4_nlm4_res_sz,
+		.pc_name	= "GRANTED",
 	},
 	[NLMPROC_TEST_MSG] = {
 		.pc_func = nlm4svc_proc_test_msg,
-- 
2.53.0


