Return-Path: <linux-nfs+bounces-18991-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ad8LBPnlGmjIgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18991-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:09:23 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEC6151527
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4061C3067052
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 22:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0F631328B;
	Tue, 17 Feb 2026 22:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRbc+QYX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE41C313276
	for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366053; cv=none; b=PZ4dczpBlHZQp/1D+orR5y/flHOzPFZIvf8cnj7KkeuNaImuPRUWsK8/KtRwIzXZNdflK4kgAWExlDLfHH5lArJj/wCOmqbsKAsfdXP6FiqOcJH2p/+y82QQoK+j7u26bF6vtokBur68v9f6XVgf2d19NsEsBsNi+CHtKws4L8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366053; c=relaxed/simple;
	bh=ibYWtvQv0NcjssxE6dCa0YlQrFt9MHrk6D7oZ6TPTI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvxC9+DBeUOO4vqJ7S5SjUZyIqjmb9/tBP6HYp3oZzyvuJIWvf9G/3YKpO4VxYboLPqL/NwPpk9P00gtPlbs/SfxT0r4Ohl3QCup6qiuYOt7Se+7ACQ8LeyGsLdH2j6lp3A5DLduyeYZPDu6XZk7/Khn9+y17Omrq2KchpVni5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRbc+QYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424C6C19425;
	Tue, 17 Feb 2026 22:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771366052;
	bh=ibYWtvQv0NcjssxE6dCa0YlQrFt9MHrk6D7oZ6TPTI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TRbc+QYXyoBVUGn4LDAP79Otm0aTuA9beRyXuor1kyFaqGaOdJO5jLjppqBVCBlfY
	 TlRKvSvcNn879pAYIYkqoy824J32uikGPMUngHO5WQG5TMzpDnwaf3sHsBWFPNU9b0
	 yAnEG45vBJs5GX1AR2mH5nv62U7q0UaW6Aw+kmls1YuH7iNYC4BjDXxJj5uEowWYgd
	 d6hHj+34eS9QmYH2jZiRskmMVDKoI+1LCvb9F9s3qNMVQaQZjEbbCob/ZdLE/uLei8
	 pnaSCtUCj2AUIe3EF3rLXB3NNUJe7okM2f3IAG1BhBX7PMGV5AaO1PWLkU8hQupsSh
	 t145DUjfzHJjA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 08/29] lockd: Refactor nlm4svc_callback()
Date: Tue, 17 Feb 2026 17:07:00 -0500
Message-ID: <20260217220721.1928847-9-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-18991-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 5EEC6151527
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The xdrgen-based XDR conversion requires each RPC procedure
to handle its own argument extraction, since xdrgen generates
distinct argument structures for each procedure rather than
using a single shared type.

This patch moves the host lookup logic from nlm4svc_callback()
into each of the five MSG procedure handlers (TEST_MSG,
LOCK_MSG, CANCEL_MSG, UNLOCK_MSG, and GRANTED_MSG). Each
handler now performs its own host lookup from rqstp->rq_argp
and passes the resulting host pointer to nlm4svc_callback(),
which is reduced to a simpler helper that only dispatches
the callback.

This refactoring enables the subsequent xdrgen conversion
patches by establishing the pattern where each procedure
handles its own argument extraction, while preserving
existing callback behavior unchanged.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 80 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 62 insertions(+), 18 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 2e1a0392d68a..f1a692f72a39 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -757,24 +757,17 @@ static const struct rpc_call_ops nlm4svc_callback_ops = {
 };
 
 /*
- * `Async' versions of the above service routines. They aren't really,
- * because we send the callback before the reply proper. I hope this
- * doesn't break any clients.
+ * Dispatch an async callback RPC to a client with a pre-resolved host.
+ * Caller provides a reference to @host; this function takes ownership
+ * and releases it via nlmsvc_release_host() before returning.
  */
-static __be32 nlm4svc_callback(struct svc_rqst *rqstp, u32 proc,
-		__be32 (*func)(struct svc_rqst *,  struct nlm_res *))
+static __be32
+nlm4svc_callback(struct svc_rqst *rqstp, struct nlm_host *host, u32 proc,
+		 __be32 (*func)(struct svc_rqst *,  struct nlm_res *))
 {
-	struct nlm_args *argp = rqstp->rq_argp;
-	struct nlm_host	*host;
 	struct nlm_rqst	*call;
 	__be32 stat;
 
-	host = nlmsvc_lookup_host(rqstp,
-				  argp->lock.caller,
-				  argp->lock.len);
-	if (host == NULL)
-		return rpc_system_err;
-
 	call = nlm_alloc_call(host);
 	nlmsvc_release_host(host);
 	if (call == NULL)
@@ -792,34 +785,85 @@ static __be32 nlm4svc_callback(struct svc_rqst *rqstp, u32 proc,
 	return rpc_success;
 }
 
+/*
+ * 'Async' versions of the above service routines. They aren't really,
+ * because we send the callback before the reply proper. I hope this
+ * doesn't break any clients.
+ */
+
 static __be32 nlm4svc_proc_test_msg(struct svc_rqst *rqstp)
 {
+	struct nlm_args *argp = rqstp->rq_argp;
+	struct nlm_host	*host;
+
 	dprintk("lockd: TEST_MSG      called\n");
-	return nlm4svc_callback(rqstp, NLMPROC_TEST_RES, __nlm4svc_proc_test);
+
+	host = nlmsvc_lookup_host(rqstp, argp->lock.caller, argp->lock.len);
+	if (!host)
+		return rpc_system_err;
+
+	return nlm4svc_callback(rqstp, host, NLMPROC_TEST_RES,
+				__nlm4svc_proc_test);
 }
 
 static __be32 nlm4svc_proc_lock_msg(struct svc_rqst *rqstp)
 {
+	struct nlm_args *argp = rqstp->rq_argp;
+	struct nlm_host	*host;
+
 	dprintk("lockd: LOCK_MSG      called\n");
-	return nlm4svc_callback(rqstp, NLMPROC_LOCK_RES, __nlm4svc_proc_lock);
+
+	host = nlmsvc_lookup_host(rqstp, argp->lock.caller, argp->lock.len);
+	if (!host)
+		return rpc_system_err;
+
+	return nlm4svc_callback(rqstp, host, NLMPROC_LOCK_RES,
+				__nlm4svc_proc_lock);
 }
 
 static __be32 nlm4svc_proc_cancel_msg(struct svc_rqst *rqstp)
 {
+	struct nlm_args *argp = rqstp->rq_argp;
+	struct nlm_host	*host;
+
 	dprintk("lockd: CANCEL_MSG    called\n");
-	return nlm4svc_callback(rqstp, NLMPROC_CANCEL_RES, __nlm4svc_proc_cancel);
+
+	host = nlmsvc_lookup_host(rqstp, argp->lock.caller, argp->lock.len);
+	if (!host)
+		return rpc_system_err;
+
+	return nlm4svc_callback(rqstp, host, NLMPROC_CANCEL_RES,
+				__nlm4svc_proc_cancel);
 }
 
 static __be32 nlm4svc_proc_unlock_msg(struct svc_rqst *rqstp)
 {
+	struct nlm_args *argp = rqstp->rq_argp;
+	struct nlm_host	*host;
+
 	dprintk("lockd: UNLOCK_MSG    called\n");
-	return nlm4svc_callback(rqstp, NLMPROC_UNLOCK_RES, __nlm4svc_proc_unlock);
+
+	host = nlmsvc_lookup_host(rqstp, argp->lock.caller, argp->lock.len);
+	if (!host)
+		return rpc_system_err;
+
+	return nlm4svc_callback(rqstp, host, NLMPROC_UNLOCK_RES,
+				__nlm4svc_proc_unlock);
 }
 
 static __be32 nlm4svc_proc_granted_msg(struct svc_rqst *rqstp)
 {
+	struct nlm_args *argp = rqstp->rq_argp;
+	struct nlm_host	*host;
+
 	dprintk("lockd: GRANTED_MSG   called\n");
-	return nlm4svc_callback(rqstp, NLMPROC_GRANTED_RES, __nlm4svc_proc_granted);
+
+	host = nlmsvc_lookup_host(rqstp, argp->lock.caller, argp->lock.len);
+	if (!host)
+		return rpc_system_err;
+
+	return nlm4svc_callback(rqstp, host, NLMPROC_GRANTED_RES,
+				__nlm4svc_proc_granted);
 }
 
 /*
-- 
2.53.0


