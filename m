Return-Path: <linux-nfs+bounces-18382-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2M8yJeHDc2kCygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18382-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:25 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E32979D73
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C03C302C353
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303B51EE01A;
	Fri, 23 Jan 2026 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdgDEk8p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF40294A10
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194400; cv=none; b=egBaEorrNqZSvYi4lW6Sp5xwrUHztT/9ZEfwCuLIlMWGSlrpB5sQpy+y8n1uIEjBC7GAjrWQ2IBASBYWc0h0LKiOpwn+z+KlOd8R6wAvsD1XaOIv3STPRsLUljB0cabLDtEmY56X93F5m9Knu4OcRHt/Pdc8DDjdq1gWXW/XL8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194400; c=relaxed/simple;
	bh=d91T8Njh39I7PpPAW6ftQbYinUJ6x1WHj0CcrbymrzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EuFhS3C6Mw5t0kLjUpN9t8WS4f7x2MxJYANk94I7SkvbA974T9PvJ+iMEPMTCjVjgWobI7C2LlpFuViDkWuXRQZW7WyhSRI+Cquo9ycwyxgD3Al7GegWdOK19dJCFZ/ifYg4b33QcW0/kncw8/3yySEzcvQVWaer7uPA+pukkfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdgDEk8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAE9C116D0;
	Fri, 23 Jan 2026 18:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194399;
	bh=d91T8Njh39I7PpPAW6ftQbYinUJ6x1WHj0CcrbymrzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KdgDEk8p8agZ2J7CEi/MbJrVEOjfzDm/pz6OqTrvm/HDaBP0t31TF1MX8zpzLM5Pc
	 UQRJHuavQ1shBiXHB4zA51CHNaaJEK4Wvrene4jo/rVli7wX+6tVwGaOyRGXqlFWex
	 KfGTMU+Jm7FvbppdJHpbT4QxTzqQ32xM3DjDjd3dlvM+NOZMZZjBg5FJyzNR3nXIsh
	 Tp8w2O90JBZoUE/PE4g/qNMtH0/QGCmoKrKSY0XjncfnSqzVRbNSteQV2256ghce2Q
	 7MV6F9AlHMLg1CkTNn2IykdwZUKI4PfFE6GiSvjL4n4wr9OQDPn1wR1LVE0eH3BWgK
	 MDqodq+7JuR/w==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 21/42] lockd: Refactor nlm4svc_callback()
Date: Fri, 23 Jan 2026 13:52:38 -0500
Message-ID: <20260123185259.1215767-22-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-18382-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 3E32979D73
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 80 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 62 insertions(+), 18 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index fb0ff4a04ced..e3af1f4a56c4 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -748,24 +748,17 @@ static const struct rpc_call_ops nlm4svc_callback_ops = {
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
@@ -783,34 +776,85 @@ static __be32 nlm4svc_callback(struct svc_rqst *rqstp, u32 proc,
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
2.52.0


