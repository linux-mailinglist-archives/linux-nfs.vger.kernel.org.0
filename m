Return-Path: <linux-nfs+bounces-21549-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DN9H89xA2q55wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21549-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:30:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 201FB527ABC
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DF5F310001C
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A26D36B043;
	Tue, 12 May 2026 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjjKwdnv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5612434E744
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609648; cv=none; b=rz3+0jrQLjsGi24AgKfeaHnd4zGnIxCCskpUKob+wafmHmnfCHU14AfnVZZafyCLiAkJwI62zSd/0F43cqrILA/7+ntWWbRXdT5FP21/dJXQQNKZb8RcimebR6QD3ZcNVJLp2VFMzUOjlfik9vDeqEQXUFTgqEvBsrYN+0sqTMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609648; c=relaxed/simple;
	bh=ITbUiXRb98FTLShz/fCDkV8yVAUXrOiWqT4nhFMyExQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eqFdUewMRjTWZAUlkagrdXPvYmRCIzE5uZD8CZ5uD54k/7X8OSfGzEspTZdVMnW25m1ubIjBjh7C1tb9Q0VvF0kvRTseQ9WdKKZzybN4TJq5vrY3bnZjUNFP5rABr2kGRYAxB5Fn8sfvQuShJ3FcVc3IqbmFWjvgOm9UKz9hlQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjjKwdnv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F864C2BCB0;
	Tue, 12 May 2026 18:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609648;
	bh=ITbUiXRb98FTLShz/fCDkV8yVAUXrOiWqT4nhFMyExQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hjjKwdnvaeCLYBsxuAuY26r6cRWRx/5qm29j8dFBfvUKyDdRN04g3Ln5tGRaXFngo
	 YGK5WTw20dqP5IizkO1HR1iJ4q/lbCgOCQKY1C41TOyAQjYtJuXqtKwFYNXg+aR2A1
	 H2CqBgu5hDAK8MCHfRufY4I8DLi9MvetJLS7OVv1AJinw7TXCYo3xDidcZr/N47x33
	 3r+quFp2RxH+U4Ijyu1a+YTHSDmipAT+Qmm7LS2se+pI9YghZsjN2OGyaJDBujXWBx
	 RSPbnrVsXxnK6knr91LUNMqdwdbJ/wqknFFUeixVQpYiT84RhFS/vTdQLx2F3H7emc
	 FVdslpbFaPlCw==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:13:44 -0400
Subject: [PATCH 09/38] lockd: Rename struct nlm_args to lockd_args
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-9-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=17934;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=YPTdJEQ/cS2o2tddvS6hrOaql+3VpUcyQiYTVwtIRyI=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23kQHDTqQ8xkJxsmME5HMiWIkX6ozrCNfjX4
 UOV+vqUG1yJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5AAKCRAzarMzb2Z/
 lzOfD/4kK8RnqgodxRF1I4zLak6d0pzreqIcTfwRRxpXFB6lAXc3Ldn7MBtBMmPKIjtOaxx7XFI
 tCkRIbu1Ey9A+xFq2WgBvuLZ3YJivHJ+xO7KUBma1CRe5EOjMyfg5j+MXRJIE+3J99M0jZx6ImQ
 vP90NLz+LOmztzZ1c30Dee5tIOTC3Q/RMxk5LCvJ/+nOoWzXFj0pTLMOsrvbEWikW5GObh2lnL0
 4qPMQ7KiHsRxeRPmekXHFvelrAdv1D2wimDu7eIVf1XYrr5BVmjqPcnxtJGFqOdhYTroCM7E056
 MWOVhKIEHx0Pg6kG6S61myLZM6m+tWA4CsLr35aiwp5wkkCxTkx219rtiFRGZ8tQ2P+ZjFhggH3
 Dq0YzAnWTXX7BMR861PTwJ/ajZv9Oa9Y5xwbZ1fUQyhUIKnxv2VGcryBYba+H5FJvcPTwLKSkGj
 4E9aui3RPnsC/zexF4NblM4RSOdmsL2aUY215m5sRMfWhLzuoqcKTPCwXffzAgvRGk7wAjnRpen
 KELpVGCThLW/ELS+bnpw9vnBeCTLZenI3DShzQzX8+kDclz/4yi/k1lhAWsycl/I+G8f0r3FOD9
 w6/W3BHTzBdKZxJkxSNEhUIKZDgrqEnnsVKikOZjIQbSHs4R1mmlc1F8xZeovkyfhjkUEcYue+4
 ZlOLdZRN77P5eIw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 201FB527ABC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21549-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

As part of the effort to enable lockd's server-side XDR functions to
be generated from the NLM protocol specification (using xdrgen), the
internal type names must be changed to avoid conflicts with the
machine-generated type names.

Rename struct nlm_args to struct lockd_args to avoid conflicts with
the NLMv3 XDR type definitions that will be introduced when
svcproc.c is converted to use xdrgen.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/clnt4xdr.c |  8 +++---
 fs/lockd/clntproc.c |  4 +--
 fs/lockd/clntxdr.c  |  8 +++---
 fs/lockd/lockd.h    |  2 +-
 fs/lockd/svcproc.c  | 80 ++++++++++++++++++++++++++---------------------------
 fs/lockd/xdr.c      | 12 ++++----
 fs/lockd/xdr.h      |  2 +-
 7 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/fs/lockd/clnt4xdr.c b/fs/lockd/clnt4xdr.c
index 8973711264cb..d0b08a12fe45 100644
--- a/fs/lockd/clnt4xdr.c
+++ b/fs/lockd/clnt4xdr.c
@@ -354,7 +354,7 @@ static void nlm4_xdr_enc_testargs(struct rpc_rqst *req,
 				  struct xdr_stream *xdr,
 				  const void *data)
 {
-	const struct nlm_args *args = data;
+	const struct lockd_args *args = data;
 	const struct lockd_lock *lock = &args->lock;
 
 	encode_cookie(xdr, &args->cookie);
@@ -376,7 +376,7 @@ static void nlm4_xdr_enc_lockargs(struct rpc_rqst *req,
 				  struct xdr_stream *xdr,
 				  const void *data)
 {
-	const struct nlm_args *args = data;
+	const struct lockd_args *args = data;
 	const struct lockd_lock *lock = &args->lock;
 
 	encode_cookie(xdr, &args->cookie);
@@ -399,7 +399,7 @@ static void nlm4_xdr_enc_cancargs(struct rpc_rqst *req,
 				  struct xdr_stream *xdr,
 				  const void *data)
 {
-	const struct nlm_args *args = data;
+	const struct lockd_args *args = data;
 	const struct lockd_lock *lock = &args->lock;
 
 	encode_cookie(xdr, &args->cookie);
@@ -418,7 +418,7 @@ static void nlm4_xdr_enc_unlockargs(struct rpc_rqst *req,
 				    struct xdr_stream *xdr,
 				    const void *data)
 {
-	const struct nlm_args *args = data;
+	const struct lockd_args *args = data;
 	const struct lockd_lock *lock = &args->lock;
 
 	encode_cookie(xdr, &args->cookie);
diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index 1aa6597ae0b7..abdf2a51caf2 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -128,7 +128,7 @@ static struct nlm_lockowner *nlmclnt_find_lockowner(struct nlm_host *host, fl_ow
  */
 static void nlmclnt_setlockargs(struct nlm_rqst *req, struct file_lock *fl)
 {
-	struct nlm_args	*argp = &req->a_args;
+	struct lockd_args *argp = &req->a_args;
 	struct lockd_lock *lock = &argp->lock;
 	char *nodename = req->a_host->h_rpcclnt->cl_nodename;
 
@@ -266,7 +266,7 @@ nlmclnt_call(const struct cred *cred, struct nlm_rqst *req, u32 proc)
 {
 	struct nlm_host	*host = req->a_host;
 	struct rpc_clnt	*clnt;
-	struct nlm_args	*argp = &req->a_args;
+	struct lockd_args *argp = &req->a_args;
 	struct nlm_res	*resp = &req->a_res;
 	struct rpc_message msg = {
 		.rpc_argp	= argp,
diff --git a/fs/lockd/clntxdr.c b/fs/lockd/clntxdr.c
index efa45f12960d..444a34bc799a 100644
--- a/fs/lockd/clntxdr.c
+++ b/fs/lockd/clntxdr.c
@@ -355,7 +355,7 @@ static void nlm_xdr_enc_testargs(struct rpc_rqst *req,
 				 struct xdr_stream *xdr,
 				 const void *data)
 {
-	const struct nlm_args *args = data;
+	const struct lockd_args *args = data;
 	const struct lockd_lock *lock = &args->lock;
 
 	encode_cookie(xdr, &args->cookie);
@@ -377,7 +377,7 @@ static void nlm_xdr_enc_lockargs(struct rpc_rqst *req,
 				 struct xdr_stream *xdr,
 				 const void *data)
 {
-	const struct nlm_args *args = data;
+	const struct lockd_args *args = data;
 	const struct lockd_lock *lock = &args->lock;
 
 	encode_cookie(xdr, &args->cookie);
@@ -400,7 +400,7 @@ static void nlm_xdr_enc_cancargs(struct rpc_rqst *req,
 				 struct xdr_stream *xdr,
 				 const void *data)
 {
-	const struct nlm_args *args = data;
+	const struct lockd_args *args = data;
 	const struct lockd_lock *lock = &args->lock;
 
 	encode_cookie(xdr, &args->cookie);
@@ -419,7 +419,7 @@ static void nlm_xdr_enc_unlockargs(struct rpc_rqst *req,
 				   struct xdr_stream *xdr,
 				   const void *data)
 {
-	const struct nlm_args *args = data;
+	const struct lockd_args *args = data;
 	const struct lockd_lock *lock = &args->lock;
 
 	encode_cookie(xdr, &args->cookie);
diff --git a/fs/lockd/lockd.h b/fs/lockd/lockd.h
index 032790834c7e..a97676639d3e 100644
--- a/fs/lockd/lockd.h
+++ b/fs/lockd/lockd.h
@@ -171,7 +171,7 @@ struct nlm_rqst {
 	refcount_t		a_count;
 	unsigned int		a_flags;	/* initial RPC task flags */
 	struct nlm_host *	a_host;		/* host handle */
-	struct nlm_args		a_args;		/* arguments */
+	struct lockd_args	a_args;		/* arguments */
 	struct nlm_res		a_res;		/* result */
 	struct nlm_block *	a_block;
 	unsigned int		a_retries;	/* Retry count */
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 2e1dbd4e1df9..8a49b864f6ee 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -62,7 +62,7 @@ static inline __be32 cast_status(__be32 status)
  * Obtain client and file from arguments
  */
 static __be32
-nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
+nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct lockd_args *argp,
 			struct nlm_host **hostp, struct nlm_file **filp)
 {
 	struct nlm_host		*host = NULL;
@@ -136,7 +136,7 @@ nlmsvc_proc_null(struct svc_rqst *rqstp)
 static __be32
 __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
+	struct lockd_args *argp = rqstp->rq_argp;
 	struct nlm_host	*host;
 	struct nlm_file	*file;
 	__be32 rc = rpc_success;
@@ -173,7 +173,7 @@ nlmsvc_proc_test(struct svc_rqst *rqstp)
 static __be32
 __nlmsvc_proc_lock(struct svc_rqst *rqstp, struct nlm_res *resp)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
+	struct lockd_args *argp = rqstp->rq_argp;
 	struct nlm_host	*host;
 	struct nlm_file	*file;
 	__be32 rc = rpc_success;
@@ -211,7 +211,7 @@ nlmsvc_proc_lock(struct svc_rqst *rqstp)
 static __be32
 __nlmsvc_proc_cancel(struct svc_rqst *rqstp, struct nlm_res *resp)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
+	struct lockd_args *argp = rqstp->rq_argp;
 	struct nlm_host	*host;
 	struct nlm_file	*file;
 	struct net *net = SVC_NET(rqstp);
@@ -253,7 +253,7 @@ nlmsvc_proc_cancel(struct svc_rqst *rqstp)
 static __be32
 __nlmsvc_proc_unlock(struct svc_rqst *rqstp, struct nlm_res *resp)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
+	struct lockd_args *argp = rqstp->rq_argp;
 	struct nlm_host	*host;
 	struct nlm_file	*file;
 	struct net *net = SVC_NET(rqstp);
@@ -296,7 +296,7 @@ nlmsvc_proc_unlock(struct svc_rqst *rqstp)
 static __be32
 __nlmsvc_proc_granted(struct svc_rqst *rqstp, struct nlm_res *resp)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
+	struct lockd_args *argp = rqstp->rq_argp;
 
 	resp->cookie = argp->cookie;
 
@@ -345,7 +345,7 @@ static const struct rpc_call_ops nlmsvc_callback_ops = {
 static __be32 nlmsvc_callback(struct svc_rqst *rqstp, u32 proc,
 		__be32 (*func)(struct svc_rqst *, struct nlm_res *))
 {
-	struct nlm_args *argp = rqstp->rq_argp;
+	struct lockd_args *argp = rqstp->rq_argp;
 	struct nlm_host	*host;
 	struct nlm_rqst	*call;
 	__be32 stat;
@@ -411,7 +411,7 @@ nlmsvc_proc_granted_msg(struct svc_rqst *rqstp)
 static __be32
 nlmsvc_proc_share(struct svc_rqst *rqstp)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
+	struct lockd_args *argp = rqstp->rq_argp;
 	struct nlm_res *resp = rqstp->rq_resp;
 	struct nlm_host	*host;
 	struct nlm_file	*file;
@@ -449,7 +449,7 @@ nlmsvc_proc_share(struct svc_rqst *rqstp)
 static __be32
 nlmsvc_proc_unshare(struct svc_rqst *rqstp)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
+	struct lockd_args *argp = rqstp->rq_argp;
 	struct nlm_res *resp = rqstp->rq_resp;
 	struct nlm_host	*host;
 	struct nlm_file	*file;
@@ -486,7 +486,7 @@ nlmsvc_proc_unshare(struct svc_rqst *rqstp)
 static __be32
 nlmsvc_proc_nm_lock(struct svc_rqst *rqstp)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
+	struct lockd_args *argp = rqstp->rq_argp;
 
 	dprintk("lockd: NM_LOCK       called\n");
 
@@ -500,7 +500,7 @@ nlmsvc_proc_nm_lock(struct svc_rqst *rqstp)
 static __be32
 nlmsvc_proc_free_all(struct svc_rqst *rqstp)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
+	struct lockd_args *argp = rqstp->rq_argp;
 	struct nlm_host	*host;
 
 	/* Obtain client */
@@ -582,8 +582,8 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_func = nlmsvc_proc_test,
 		.pc_decode = nlmsvc_decode_testargs,
 		.pc_encode = nlmsvc_encode_testres,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
+		.pc_argsize = sizeof(struct lockd_args),
+		.pc_argzero = sizeof(struct lockd_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+2+No+Rg,
 		.pc_name = "TEST",
@@ -592,8 +592,8 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_func = nlmsvc_proc_lock,
 		.pc_decode = nlmsvc_decode_lockargs,
 		.pc_encode = nlmsvc_encode_res,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
+		.pc_argsize = sizeof(struct lockd_args),
+		.pc_argzero = sizeof(struct lockd_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "LOCK",
@@ -602,8 +602,8 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_func = nlmsvc_proc_cancel,
 		.pc_decode = nlmsvc_decode_cancargs,
 		.pc_encode = nlmsvc_encode_res,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
+		.pc_argsize = sizeof(struct lockd_args),
+		.pc_argzero = sizeof(struct lockd_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "CANCEL",
@@ -612,8 +612,8 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_func = nlmsvc_proc_unlock,
 		.pc_decode = nlmsvc_decode_unlockargs,
 		.pc_encode = nlmsvc_encode_res,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
+		.pc_argsize = sizeof(struct lockd_args),
+		.pc_argzero = sizeof(struct lockd_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "UNLOCK",
@@ -622,8 +622,8 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_func = nlmsvc_proc_granted,
 		.pc_decode = nlmsvc_decode_testargs,
 		.pc_encode = nlmsvc_encode_res,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
+		.pc_argsize = sizeof(struct lockd_args),
+		.pc_argzero = sizeof(struct lockd_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "GRANTED",
@@ -632,8 +632,8 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_func = nlmsvc_proc_test_msg,
 		.pc_decode = nlmsvc_decode_testargs,
 		.pc_encode = nlmsvc_encode_void,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
+		.pc_argsize = sizeof(struct lockd_args),
+		.pc_argzero = sizeof(struct lockd_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "TEST_MSG",
@@ -642,8 +642,8 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_func = nlmsvc_proc_lock_msg,
 		.pc_decode = nlmsvc_decode_lockargs,
 		.pc_encode = nlmsvc_encode_void,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
+		.pc_argsize = sizeof(struct lockd_args),
+		.pc_argzero = sizeof(struct lockd_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "LOCK_MSG",
@@ -652,8 +652,8 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_func = nlmsvc_proc_cancel_msg,
 		.pc_decode = nlmsvc_decode_cancargs,
 		.pc_encode = nlmsvc_encode_void,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
+		.pc_argsize = sizeof(struct lockd_args),
+		.pc_argzero = sizeof(struct lockd_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "CANCEL_MSG",
@@ -662,8 +662,8 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_func = nlmsvc_proc_unlock_msg,
 		.pc_decode = nlmsvc_decode_unlockargs,
 		.pc_encode = nlmsvc_encode_void,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
+		.pc_argsize = sizeof(struct lockd_args),
+		.pc_argzero = sizeof(struct lockd_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "UNLOCK_MSG",
@@ -672,8 +672,8 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_func = nlmsvc_proc_granted_msg,
 		.pc_decode = nlmsvc_decode_testargs,
 		.pc_encode = nlmsvc_encode_void,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
+		.pc_argsize = sizeof(struct lockd_args),
+		.pc_argzero = sizeof(struct lockd_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "GRANTED_MSG",
@@ -772,8 +772,8 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_func = nlmsvc_proc_share,
 		.pc_decode = nlmsvc_decode_shareargs,
 		.pc_encode = nlmsvc_encode_shareres,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
+		.pc_argsize = sizeof(struct lockd_args),
+		.pc_argzero = sizeof(struct lockd_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+1,
 		.pc_name = "SHARE",
@@ -782,8 +782,8 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_func = nlmsvc_proc_unshare,
 		.pc_decode = nlmsvc_decode_shareargs,
 		.pc_encode = nlmsvc_encode_shareres,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
+		.pc_argsize = sizeof(struct lockd_args),
+		.pc_argzero = sizeof(struct lockd_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St+1,
 		.pc_name = "UNSHARE",
@@ -792,8 +792,8 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_func = nlmsvc_proc_nm_lock,
 		.pc_decode = nlmsvc_decode_lockargs,
 		.pc_encode = nlmsvc_encode_res,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
+		.pc_argsize = sizeof(struct lockd_args),
+		.pc_argzero = sizeof(struct lockd_args),
 		.pc_ressize = sizeof(struct nlm_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "NM_LOCK",
@@ -802,8 +802,8 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_func = nlmsvc_proc_free_all,
 		.pc_decode = nlmsvc_decode_notify,
 		.pc_encode = nlmsvc_encode_void,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
+		.pc_argsize = sizeof(struct lockd_args),
+		.pc_argzero = sizeof(struct lockd_args),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = 0,
 		.pc_name = "FREE_ALL",
@@ -814,7 +814,7 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
  * Storage requirements for XDR arguments and results
  */
 union nlmsvc_xdrstore {
-	struct nlm_args			args;
+	struct lockd_args		args;
 	struct nlm_res			res;
 	struct nlm_reboot		reboot;
 };
diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index 55868222984a..0130cdea5642 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -154,7 +154,7 @@ nlmsvc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 bool
 nlmsvc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
+	struct lockd_args *argp = rqstp->rq_argp;
 	u32 exclusive;
 
 	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
@@ -172,7 +172,7 @@ nlmsvc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 bool
 nlmsvc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
+	struct lockd_args *argp = rqstp->rq_argp;
 	u32 exclusive;
 
 	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
@@ -197,7 +197,7 @@ nlmsvc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 bool
 nlmsvc_decode_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
+	struct lockd_args *argp = rqstp->rq_argp;
 	u32 exclusive;
 
 	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
@@ -217,7 +217,7 @@ nlmsvc_decode_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 bool
 nlmsvc_decode_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
+	struct lockd_args *argp = rqstp->rq_argp;
 
 	if (!svcxdr_decode_cookie(xdr, &argp->cookie))
 		return false;
@@ -270,7 +270,7 @@ nlmsvc_decode_reboot(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 bool
 nlmsvc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
+	struct lockd_args *argp = rqstp->rq_argp;
 	struct lockd_lock *lock = &argp->lock;
 
 	memset(lock, 0, sizeof(*lock));
@@ -297,7 +297,7 @@ nlmsvc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 bool
 nlmsvc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
+	struct lockd_args *argp = rqstp->rq_argp;
 	struct lockd_lock *lock = &argp->lock;
 
 	if (!svcxdr_decode_string(xdr, &lock->caller, &lock->len))
diff --git a/fs/lockd/xdr.h b/fs/lockd/xdr.h
index 805027d9b0fe..ffdcad0f8680 100644
--- a/fs/lockd/xdr.h
+++ b/fs/lockd/xdr.h
@@ -57,7 +57,7 @@ struct lockd_cookie {
 /*
  * Generic lockd arguments for all but sm_notify
  */
-struct nlm_args {
+struct lockd_args {
 	struct lockd_cookie	cookie;
 	struct lockd_lock	lock;
 	u32			block;

-- 
2.54.0


