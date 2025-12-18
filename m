Return-Path: <linux-nfs+bounces-17204-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9779ECCD7C5
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0FFAF305399A
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D912D8792;
	Thu, 18 Dec 2025 20:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djhmcfKC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8483F2D839C
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088842; cv=none; b=Q+Jl/CN2XuYNDVRFVNxaPzH+4LpZYGpHr3KOqC0SYxciCo3IkVZ3JvFuhcDDtjU09V0ha6JEK/7zfQj/Yoj0NLOvUhLCsoqciFAb8uQlADgs40hp93F1s1AOE3p+0aNmvtQocRdonxx39A5HcQB7zs9tVM5VODxK2Y9BDF9kZ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088842; c=relaxed/simple;
	bh=fLBkvOI2Z8qWLN/rpsvoeASXjdi8THsNotmLV18Wmt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRGeekDGCR4RLsMbME2JBhT4gac6iwBxyXr2rH62tlxNT05Zh8/Rr4wlTSjLC9DxRBvbRVMVK/TvBkb+avZAOsMas5oG0NxGiyGtwR0E74BBU32lPiN4OovCuEkoxEOmXBYUzD/8bjASPcya73603qrOQSur5gC1jnQVC0gnluA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djhmcfKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C38C16AAE;
	Thu, 18 Dec 2025 20:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088842;
	bh=fLBkvOI2Z8qWLN/rpsvoeASXjdi8THsNotmLV18Wmt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=djhmcfKC6g23jj1hiDEjMVzyYr5iZjqXHB1/uZYtk6DnpD495B+9Q6Fe6lCYB+qSR
	 MR1J+G05BW6qB+pXcEh17v7Wn77JaTjjEx9qdZTJhnZkr37UARTatADg+/xgdsZAS0
	 pGmgG18g1nV3DqzFIBYU8b0sktnpreETX+SzcFw/WXmWjFQEU+watS0yE+hPVKs5e8
	 klYjFUL4oeI1kbRfbFlMe77LIRRNuckarbm9SNPah6HtGPcaUKRppxC7DNL6wFxQxE
	 hAlkOD/Dq5kXS4UFYgq0t/65LR86XwovX6Kjb7AzPaiuIu6aE8g37+vvE9W3lSuUo0
	 Na+OmY7yg/5Zw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 16/36] lockd: Refactor nlm4svc_callback()
Date: Thu, 18 Dec 2025 15:13:26 -0500
Message-ID: <20251218201346.1190928-17-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218201346.1190928-1-cel@kernel.org>
References: <20251218201346.1190928-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

With xdrgen, each RPC procedure can have a distinct argument struct,
so each PROC_YADA_MSG procedure needs to sort its own arguments.

No behavior change is expected.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 68 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 15 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index fc446639095a..0e6ab31733c6 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -607,20 +607,13 @@ static const struct rpc_call_ops nlm4svc_callback_ops = {
  * because we send the callback before the reply proper. I hope this
  * doesn't break any clients.
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
@@ -640,32 +633,77 @@ static __be32 nlm4svc_callback(struct svc_rqst *rqstp, u32 proc,
 
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


