Return-Path: <linux-nfs+bounces-21557-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAuLMXR1A2rf5wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21557-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:46:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24621528173
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEA3432FC803
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F33379EE2;
	Tue, 12 May 2026 18:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjflyQXx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7073A372B3C
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609655; cv=none; b=P31GpXhU4QCgl6gCRoP4FyjQ4L/aeEQ2NexR9JinZifb7Ya5etHubAGtWTpPn9ekaRd3s6GtA2268HCeoa5RHTLvXWsg/mDE8p61CJg3QgyaDR7GrwJx27rBcaUKnx1L5FVkRn643JkJfXfBvX47ZkIbpO4mg6WxXl/+tZpQvq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609655; c=relaxed/simple;
	bh=sXJ7h1J4MzTKy+Hdtvm7/XTGtILEG3bSXmv6vXhpH38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XMQVROG2+fgjgbqRdDHXSxKg6mX4aO0SI/rlZWS3R8VauVyltrqz4OTvxSLtiIYwL/3jUei7IbQxfLkK2L9DSckH27JHSb6QUxq4Uh6mJEgorHOBfaZfzJe1fm0/CjhlAwIcfApQjQTsmscgYgtvBMokHouFRuap+nn2XIAu82g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjflyQXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907CDC2BCB0;
	Tue, 12 May 2026 18:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609655;
	bh=sXJ7h1J4MzTKy+Hdtvm7/XTGtILEG3bSXmv6vXhpH38=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VjflyQXxuj5ZLLOb/BOHulSq5rJh9Bg4yyzLDQnG1SnQkwVVSDNT5WtsnChcivQSU
	 w5zwACodaWII2yxyZrE7HYu49TMDxvGDLj/88LTXsGNT5zx8MbiF+YMV+0WEWJOcdP
	 RLYtQn8zYo115kbINeHkG1f/9ZWx6JltwX6emoMr4aLNkgErExGFA7MxYZZLYrSYTk
	 ITael4Sd3OdhjEBnZd5WdTDxjf7SQdbsOefpnKaUXIWIWx8jDq1cEWsd1puiJbjefG
	 1Zft42bqUnVDz2RT37q2nZV/oCaEpy1SkCe706ix8u1EVFSvuWF8ZnKvNYhDzbjvL/
	 oc5ujXwnvxq3g==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:13:52 -0400
Subject: [PATCH 17/38] lockd: Use xdrgen XDR functions for the NLMv3 UNLOCK
 procedure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-17-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=4840;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=AnJ1SR6GV9MlDaLAGCs2xg9jK/0y9JfHlFMFnPA4XEA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23lSZDdh5ZH+OsYI1p143Ys7uj4qUhH2Zq8v
 y5BMl7VGLiJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5QAKCRAzarMzb2Z/
 l7yhD/9nyU8wYLQsZoOGiUZ1B5JXuAVWBALFRSJdFZ7IpgrzkRM2LXnOyAZwB3GnBhXkxUIe2G3
 ujMh9u0CvYuHrq9uTtuqQsFxxBi0QHvLid5uBAcCz1jELH4/RfiQf/bIkjU3/4W0pNf+OyGV5Jp
 h3H0aqt/jX75n5zLKOjGevl/rkc578/+jYltKVRkPj6svOriyZVfQFoLVEKYiismUYRHvUaSh+2
 IwZQVbEYpSIXNu9sSV3hLmRR1sRTgemtqFDNcBLaEg4T1IqjVs5WUeuM580B43R8fJgeJUL8iiq
 y6NYeN5tpFEuYbxghoQp2pxrCz7b0IBGBVyEBdHBNLSgKIOM4tRL0l8SIQFYwYfhtk5XJK+54Xn
 1iQAgVMW3HQ1l6aWw0SztEncZEC+pLKI6KVhudltRmGkU5mg7gWgPnZRDyjJod1NxjcSi9xem63
 NdBac33eI6Phgl6RT/y0ZZslsSnLinvBXwNrRnZvEtp31Kfn/2aOOQGDR/vJDGxgX2EqdbzwUmK
 DuTHI5U0wjOSvZZz9ulpV22f6BLfIuy/wRd5L2fWr9BmOlPow0mZFsczVY6u7hNhd6ais/z4BbM
 x7gMgTz3o4N3Nqduh16vQd3Qmv7dg9ndkfMELWU/r2TB/BtxwkwTLbKd/bgAFQXgsmaXVZZdZ9h
 +ZdQ/+4UxvKqG6w==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 24621528173
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21557-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The NLM UNLOCK procedure allows clients to release held locks,
completing the basic lock lifecycle alongside TEST, LOCK, and
CANCEL procedures already converted in this series.

Convert UNLOCK to use the xdrgen functions
nlm_svc_decode_nlm_unlockargs and nlm_svc_encode_nlm_res
generated from the NLM version 3 protocol specification, reusing
the nlm3svc_lookup_host() and nlm3svc_lookup_file() helpers
introduced earlier in the series. The procedure handler uses
xdrgen types through a wrapper structure that bridges between
generated code and the legacy lockd_lock representation still
used by the core lockd logic.

Setting pc_argzero to zero is safe because the generated decoder
fills the argp->xdrgen subfields before the procedure runs, so
the zeroing memset performed by the dispatch layer is not needed.
The lock member of the wrapper is populated explicitly in
nlm3svc_lookup_file() rather than relying on zero-initialization.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcproc.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 69 insertions(+), 10 deletions(-)

diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index a5e40ca3f109..ccc6a633df7b 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -72,6 +72,13 @@ struct nlm_cancargs_wrapper {
 
 static_assert(offsetof(struct nlm_cancargs_wrapper, xdrgen) == 0);
 
+struct nlm_unlockargs_wrapper {
+	struct nlm_unlockargs		xdrgen;
+	struct lockd_lock		lock;
+};
+
+static_assert(offsetof(struct nlm_unlockargs_wrapper, xdrgen) == 0);
+
 static __be32
 nlm_netobj_to_cookie(struct lockd_cookie *cookie, netobj *object)
 {
@@ -619,10 +626,61 @@ __nlmsvc_proc_unlock(struct svc_rqst *rqstp, struct lockd_res *resp)
 	return rpc_success;
 }
 
+/**
+ * nlmsvc_proc_unlock - UNLOCK: Remove a lock
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_drop_reply:		Do not send an RPC reply.
+ *
+ * RPC synopsis:
+ *   nlm_res NLM_UNLOCK(nlm_unlockargs) = 4;
+ *
+ * Permissible procedure status codes:
+ *   %LCK_GRANTED:		The requested lock was released.
+ *   %LCK_DENIED_GRACE_PERIOD:	The server has recently restarted and is
+ *				re-establishing existing locks, and is not
+ *				yet ready to accept normal service requests.
+ *
+ * The Linux NLM server implementation also returns:
+ *   %LCK_DENIED_NOLOCKS:	A needed resource could not be allocated.
+ */
 static __be32
 nlmsvc_proc_unlock(struct svc_rqst *rqstp)
 {
-	return __nlmsvc_proc_unlock(rqstp, rqstp->rq_resp);
+	struct nlm_unlockargs_wrapper *argp = rqstp->rq_argp;
+	struct nlm_res_wrapper *resp = rqstp->rq_resp;
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
+	host = nlm3svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, false);
+	if (!host)
+		goto out;
+
+	resp->xdrgen.stat.stat = nlm3svc_lookup_file(rqstp, host, &argp->lock,
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
@@ -944,15 +1002,15 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_xdrressize	= NLM3_nlm_res_sz,
 		.pc_name	= "CANCEL",
 	},
-	[NLMPROC_UNLOCK] = {
-		.pc_func = nlmsvc_proc_unlock,
-		.pc_decode = nlmsvc_decode_unlockargs,
-		.pc_encode = nlmsvc_encode_res,
-		.pc_argsize = sizeof(struct lockd_args),
-		.pc_argzero = sizeof(struct lockd_args),
-		.pc_ressize = sizeof(struct lockd_res),
-		.pc_xdrressize = Ck+St,
-		.pc_name = "UNLOCK",
+	[NLM_UNLOCK] = {
+		.pc_func	= nlmsvc_proc_unlock,
+		.pc_decode	= nlm_svc_decode_nlm_unlockargs,
+		.pc_encode	= nlm_svc_encode_nlm_res,
+		.pc_argsize	= sizeof(struct nlm_unlockargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= sizeof(struct nlm_res_wrapper),
+		.pc_xdrressize	= NLM3_nlm_res_sz,
+		.pc_name	= "UNLOCK",
 	},
 	[NLMPROC_GRANTED] = {
 		.pc_func = nlmsvc_proc_granted,
@@ -1153,6 +1211,7 @@ union nlmsvc_xdrstore {
 	struct nlm_testargs_wrapper	testargs;
 	struct nlm_lockargs_wrapper	lockargs;
 	struct nlm_cancargs_wrapper	cancargs;
+	struct nlm_unlockargs_wrapper	unlockargs;
 	struct nlm_testres_wrapper	testres;
 	struct nlm_res_wrapper		res;
 	struct lockd_args		args;

-- 
2.54.0


