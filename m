Return-Path: <linux-nfs+bounces-21550-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGG8CwVuA2pS5wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21550-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:14:29 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C964652717F
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 151E030449A3
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5514B36CDE0;
	Tue, 12 May 2026 18:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIEpzW51"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AD3368972
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609649; cv=none; b=OrOB9PbHea2UGuV1mPDQnHQCMWeq9/hPrcojos5PORMyPpzAwuIopWy7a8MWESpF9Z5uUFSlBRXnPAp4TIo6B8lN0pI0C0fpqtq50gXoEiNAfCJwrkAXDQqgrWp3t7Sh36QlTRWbXHvS8ORAeuHexAqIcmIVsbv5URlX0twLVvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609649; c=relaxed/simple;
	bh=TmHmHIxi6Jv3xvT13ptxguoAY7BywZFAL2D9ohe1L/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JZ6mGyn+Bv9ILAIQm5eNFHCUvuYAI4iy3wFbym9z78GTUWwdAS//64A5pEMhEeNWTKA41lj3temrHL7MZk7XXoMWVKxfB9QAFqP8G558gJo4ZoMxsZa+AXZ5FtKnaE5hBJkIygzgvP7Fpf5dOQxEC+hu7ElDwhJbUUPMSdcn1Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIEpzW51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709B8C2BCFA;
	Tue, 12 May 2026 18:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609649;
	bh=TmHmHIxi6Jv3xvT13ptxguoAY7BywZFAL2D9ohe1L/o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kIEpzW51/E1WVbQu3rm/Hw3lYwsgQGarU4/zn9wRNXMcXS6StKiIK91QBB+N6IdRV
	 10xfU+sQh1g68uzjnrlf50tIkhXx0t4BtoeOe4Lg8B/mupDEWcW6tW8lercgGhNZl1
	 YOFN9lbcBXtzGxEuNAvXeFi3TivmYFB2G/7F4S2UZh/QUaVUWDJjjpWY9IJbgm7Xoi
	 EFnRnn8WCu4dUKfM+dgVU7Gxi3h1ygVgq6IZFLbMniR+op/1V9Ljt84bf3P9UDnYZf
	 hNX2haM4Rmo7/JsJ/jEU9agSFt6x5C1dd+dXSGsPnf8PPzI4OGRjRt55a0xAgs2P3g
	 S5r2qZVPFEUwQ==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:13:45 -0400
Subject: [PATCH 10/38] lockd: Rename struct nlm_res to lockd_res
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-10-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=19939;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=uqM+oKZ6R6K8L7cYGYfaZo466qu+i+3AKaOl93XnHNs=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23kE0w5448lX6VzEGN0MVKBrm5KWrtE+3SYM
 8qfNFWISleJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5AAKCRAzarMzb2Z/
 l/w7D/wMz166SXCjk377BkF0k9PfCf3w4vFIS+dIf6Woe+BVC8MgEIDx6SvQz+wO+cIDqFa7VlK
 72oHKNnrT2+OD9OYSFhYjntF3pTX2MF977iy7IbqvhBl9xCFEnHmvVGDR+18sOnLEYQOiaQOl1S
 vruNRB+h1cWua60JqvphKU1DvqGVbrhMQWA6+bUF8aUDKZ2ojSOVuV8MF7+WPdk9evE7db8tZhN
 3aRLXY7E8/NS/tcS6Ixy908oDwiMQwKv72p4LEBeRxTErPCwqocwAkIA3Je3tv5+tvXiC2SYoq+
 iL+hVgUMfWVEV/+KVlitnbtkL9Pbvr/Qdb2xZtUvo1TMEYV8OjGuv7x+S4sEyZNO5htWjKDBxDy
 9SIxavZZvFjw8fA9yAjP5eGnZ3mqImhYKhRGr1gcvWA7FcEHhtebafZiJDzpj4bvSKttKNF/ePl
 0nZ/W41I3kJGASiacX5WNbQEjZCVC9DJMUhAljQuddVoHzFzgcYUDNYRLiVtcghRwFKI5uk2GBj
 mQeB3Ht+QScmRKUaJvDhXNQe8xTco3HWQprGUayi0kcr2gp13ti9JOuJG/RO5fGdx3sGkOuZswi
 3Qs4yJcG6c3SAXbYJybSfgutWNnDfJeSoLRiHQ3jQithcV8ZCWMj8I8zvalyKTiDl3r45aMuD8v
 56lC6yvmTGXfleg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: C964652717F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21550-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

As part of the effort to enable lockd's server-side XDR functions to
be generated from the NLM protocol specification (using xdrgen), the
internal type names must be changed to avoid conflicts with the
machine-generated type names.

Rename struct nlm_res to struct lockd_res to avoid conflicts with
the NLMv3 XDR type definitions that will be introduced when svcproc.c
is converted to use xdrgen.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/clnt4xdr.c | 14 +++++++-------
 fs/lockd/clntproc.c |  6 +++---
 fs/lockd/clntxdr.c  | 16 +++++++--------
 fs/lockd/lockd.h    |  2 +-
 fs/lockd/svc4proc.c | 12 ++++++------
 fs/lockd/svcproc.c  | 56 ++++++++++++++++++++++++++---------------------------
 fs/lockd/xdr.c      | 10 +++++-----
 fs/lockd/xdr.h      |  2 +-
 8 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/fs/lockd/clnt4xdr.c b/fs/lockd/clnt4xdr.c
index d0b08a12fe45..96a4a1e6a6b6 100644
--- a/fs/lockd/clnt4xdr.c
+++ b/fs/lockd/clnt4xdr.c
@@ -238,7 +238,7 @@ static int decode_nlm4_stat(struct xdr_stream *xdr, __be32 *stat)
  *	};
  */
 static void encode_nlm4_holder(struct xdr_stream *xdr,
-			       const struct nlm_res *result)
+			       const struct lockd_res *result)
 {
 	const struct lockd_lock *lock = &result->lock;
 	u64 l_offset, l_len;
@@ -254,7 +254,7 @@ static void encode_nlm4_holder(struct xdr_stream *xdr,
 	xdr_encode_hyper(p, l_len);
 }
 
-static int decode_nlm4_holder(struct xdr_stream *xdr, struct nlm_res *result)
+static int decode_nlm4_holder(struct xdr_stream *xdr, struct lockd_res *result)
 {
 	struct lockd_lock *lock = &result->lock;
 	struct file_lock *fl = &lock->fl;
@@ -435,7 +435,7 @@ static void nlm4_xdr_enc_res(struct rpc_rqst *req,
 			     struct xdr_stream *xdr,
 			     const void *data)
 {
-	const struct nlm_res *result = data;
+	const struct lockd_res *result = data;
 
 	encode_cookie(xdr, &result->cookie);
 	encode_nlm4_stat(xdr, result->status);
@@ -458,7 +458,7 @@ static void nlm4_xdr_enc_testres(struct rpc_rqst *req,
 				 struct xdr_stream *xdr,
 				 const void *data)
 {
-	const struct nlm_res *result = data;
+	const struct lockd_res *result = data;
 
 	encode_cookie(xdr, &result->cookie);
 	encode_nlm4_stat(xdr, result->status);
@@ -489,7 +489,7 @@ static void nlm4_xdr_enc_testres(struct rpc_rqst *req,
  *	};
  */
 static int decode_nlm4_testrply(struct xdr_stream *xdr,
-				struct nlm_res *result)
+				struct lockd_res *result)
 {
 	int error;
 
@@ -506,7 +506,7 @@ static int nlm4_xdr_dec_testres(struct rpc_rqst *req,
 				struct xdr_stream *xdr,
 				void *data)
 {
-	struct nlm_res *result = data;
+	struct lockd_res *result = data;
 	int error;
 
 	error = decode_cookie(xdr, &result->cookie);
@@ -527,7 +527,7 @@ static int nlm4_xdr_dec_res(struct rpc_rqst *req,
 			    struct xdr_stream *xdr,
 			    void *data)
 {
-	struct nlm_res *result = data;
+	struct lockd_res *result = data;
 	int error;
 
 	error = decode_cookie(xdr, &result->cookie);
diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index abdf2a51caf2..f06faf577cea 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -267,7 +267,7 @@ nlmclnt_call(const struct cred *cred, struct nlm_rqst *req, u32 proc)
 	struct nlm_host	*host = req->a_host;
 	struct rpc_clnt	*clnt;
 	struct lockd_args *argp = &req->a_args;
-	struct nlm_res	*resp = &req->a_res;
+	struct lockd_res *resp = &req->a_res;
 	struct rpc_message msg = {
 		.rpc_argp	= argp,
 		.rpc_resp	= resp,
@@ -523,7 +523,7 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 {
 	const struct cred *cred = nfs_file_cred(fl->c.flc_file);
 	struct nlm_host	*host = req->a_host;
-	struct nlm_res	*resp = &req->a_res;
+	struct lockd_res *resp = &req->a_res;
 	struct nlm_wait block;
 	unsigned char flags = fl->c.flc_flags;
 	unsigned char type;
@@ -686,7 +686,7 @@ static int
 nlmclnt_unlock(struct nlm_rqst *req, struct file_lock *fl)
 {
 	struct nlm_host	*host = req->a_host;
-	struct nlm_res	*resp = &req->a_res;
+	struct lockd_res *resp = &req->a_res;
 	int status;
 	unsigned char flags = fl->c.flc_flags;
 
diff --git a/fs/lockd/clntxdr.c b/fs/lockd/clntxdr.c
index 444a34bc799a..3789ecb0b984 100644
--- a/fs/lockd/clntxdr.c
+++ b/fs/lockd/clntxdr.c
@@ -234,7 +234,7 @@ static int decode_nlm_stat(struct xdr_stream *xdr,
  *	};
  */
 static void encode_nlm_holder(struct xdr_stream *xdr,
-			      const struct nlm_res *result)
+			      const struct lockd_res *result)
 {
 	const struct lockd_lock *lock = &result->lock;
 	u32 l_offset, l_len;
@@ -250,7 +250,7 @@ static void encode_nlm_holder(struct xdr_stream *xdr,
 	*p   = cpu_to_be32(l_len);
 }
 
-static int decode_nlm_holder(struct xdr_stream *xdr, struct nlm_res *result)
+static int decode_nlm_holder(struct xdr_stream *xdr, struct lockd_res *result)
 {
 	struct lockd_lock *lock = &result->lock;
 	struct file_lock *fl = &lock->fl;
@@ -436,7 +436,7 @@ static void nlm_xdr_enc_res(struct rpc_rqst *req,
 			    struct xdr_stream *xdr,
 			    const void *data)
 {
-	const struct nlm_res *result = data;
+	const struct lockd_res *result = data;
 
 	encode_cookie(xdr, &result->cookie);
 	encode_nlm_stat(xdr, result->status);
@@ -456,7 +456,7 @@ static void nlm_xdr_enc_res(struct rpc_rqst *req,
  *	};
  */
 static void encode_nlm_testrply(struct xdr_stream *xdr,
-				const struct nlm_res *result)
+				const struct lockd_res *result)
 {
 	if (result->status == nlm_lck_denied)
 		encode_nlm_holder(xdr, result);
@@ -466,7 +466,7 @@ static void nlm_xdr_enc_testres(struct rpc_rqst *req,
 				struct xdr_stream *xdr,
 				const void *data)
 {
-	const struct nlm_res *result = data;
+	const struct lockd_res *result = data;
 
 	encode_cookie(xdr, &result->cookie);
 	encode_nlm_stat(xdr, result->status);
@@ -495,7 +495,7 @@ static void nlm_xdr_enc_testres(struct rpc_rqst *req,
  *	};
  */
 static int decode_nlm_testrply(struct xdr_stream *xdr,
-			       struct nlm_res *result)
+			       struct lockd_res *result)
 {
 	int error;
 
@@ -512,7 +512,7 @@ static int nlm_xdr_dec_testres(struct rpc_rqst *req,
 			       struct xdr_stream *xdr,
 			       void *data)
 {
-	struct nlm_res *result = data;
+	struct lockd_res *result = data;
 	int error;
 
 	error = decode_cookie(xdr, &result->cookie);
@@ -533,7 +533,7 @@ static int nlm_xdr_dec_res(struct rpc_rqst *req,
 			   struct xdr_stream *xdr,
 			   void *data)
 {
-	struct nlm_res *result = data;
+	struct lockd_res *result = data;
 	int error;
 
 	error = decode_cookie(xdr, &result->cookie);
diff --git a/fs/lockd/lockd.h b/fs/lockd/lockd.h
index a97676639d3e..4054e97723d8 100644
--- a/fs/lockd/lockd.h
+++ b/fs/lockd/lockd.h
@@ -172,7 +172,7 @@ struct nlm_rqst {
 	unsigned int		a_flags;	/* initial RPC task flags */
 	struct nlm_host *	a_host;		/* host handle */
 	struct lockd_args	a_args;		/* arguments */
-	struct nlm_res		a_res;		/* result */
+	struct lockd_res	a_res;		/* result */
 	struct nlm_block *	a_block;
 	unsigned int		a_retries;	/* Retry count */
 	u8			a_owner[NLMCLNT_OHSIZE];
diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index f7067fae6c86..1682a7c91a78 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -562,7 +562,7 @@ static const struct rpc_call_ops nlm4svc_callback_ops = {
  */
 static __be32
 nlm4svc_callback(struct svc_rqst *rqstp, struct nlm_host *host, u32 proc,
-		 __be32 (*func)(struct svc_rqst *,  struct nlm_res *))
+		 __be32 (*func)(struct svc_rqst *,  struct lockd_res *))
 {
 	struct nlm_rqst	*call;
 	__be32 stat;
@@ -585,7 +585,7 @@ nlm4svc_callback(struct svc_rqst *rqstp, struct nlm_host *host, u32 proc,
 }
 
 static __be32
-__nlm4svc_proc_test_msg(struct svc_rqst *rqstp, struct nlm_res *resp)
+__nlm4svc_proc_test_msg(struct svc_rqst *rqstp, struct lockd_res *resp)
 {
 	struct nlm4_testargs_wrapper *argp = rqstp->rq_argp;
 	unsigned char type = argp->xdrgen.exclusive ? F_WRLCK : F_RDLCK;
@@ -645,7 +645,7 @@ static __be32 nlm4svc_proc_test_msg(struct svc_rqst *rqstp)
 }
 
 static __be32
-__nlm4svc_proc_lock_msg(struct svc_rqst *rqstp, struct nlm_res *resp)
+__nlm4svc_proc_lock_msg(struct svc_rqst *rqstp, struct lockd_res *resp)
 {
 	struct nlm4_lockargs_wrapper *argp = rqstp->rq_argp;
 	unsigned char type = argp->xdrgen.exclusive ? F_WRLCK : F_RDLCK;
@@ -707,7 +707,7 @@ static __be32 nlm4svc_proc_lock_msg(struct svc_rqst *rqstp)
 }
 
 static __be32
-__nlm4svc_proc_cancel_msg(struct svc_rqst *rqstp, struct nlm_res *resp)
+__nlm4svc_proc_cancel_msg(struct svc_rqst *rqstp, struct lockd_res *resp)
 {
 	struct nlm4_cancargs_wrapper *argp = rqstp->rq_argp;
 	unsigned char type = argp->xdrgen.exclusive ? F_WRLCK : F_RDLCK;
@@ -771,7 +771,7 @@ static __be32 nlm4svc_proc_cancel_msg(struct svc_rqst *rqstp)
 }
 
 static __be32
-__nlm4svc_proc_unlock_msg(struct svc_rqst *rqstp, struct nlm_res *resp)
+__nlm4svc_proc_unlock_msg(struct svc_rqst *rqstp, struct lockd_res *resp)
 {
 	struct nlm4_unlockargs_wrapper *argp = rqstp->rq_argp;
 	struct net *net = SVC_NET(rqstp);
@@ -834,7 +834,7 @@ static __be32 nlm4svc_proc_unlock_msg(struct svc_rqst *rqstp)
 }
 
 static __be32
-__nlm4svc_proc_granted_msg(struct svc_rqst *rqstp, struct nlm_res *resp)
+__nlm4svc_proc_granted_msg(struct svc_rqst *rqstp, struct lockd_res *resp)
 {
 	struct nlm4_testargs_wrapper *argp = rqstp->rq_argp;
 
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 8a49b864f6ee..e033320b840f 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -134,7 +134,7 @@ nlmsvc_proc_null(struct svc_rqst *rqstp)
  * TEST: Check for conflicting lock
  */
 static __be32
-__nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
+__nlmsvc_proc_test(struct svc_rqst *rqstp, struct lockd_res *resp)
 {
 	struct lockd_args *argp = rqstp->rq_argp;
 	struct nlm_host	*host;
@@ -171,7 +171,7 @@ nlmsvc_proc_test(struct svc_rqst *rqstp)
 }
 
 static __be32
-__nlmsvc_proc_lock(struct svc_rqst *rqstp, struct nlm_res *resp)
+__nlmsvc_proc_lock(struct svc_rqst *rqstp, struct lockd_res *resp)
 {
 	struct lockd_args *argp = rqstp->rq_argp;
 	struct nlm_host	*host;
@@ -209,7 +209,7 @@ nlmsvc_proc_lock(struct svc_rqst *rqstp)
 }
 
 static __be32
-__nlmsvc_proc_cancel(struct svc_rqst *rqstp, struct nlm_res *resp)
+__nlmsvc_proc_cancel(struct svc_rqst *rqstp, struct lockd_res *resp)
 {
 	struct lockd_args *argp = rqstp->rq_argp;
 	struct nlm_host	*host;
@@ -251,7 +251,7 @@ nlmsvc_proc_cancel(struct svc_rqst *rqstp)
  * UNLOCK: release a lock
  */
 static __be32
-__nlmsvc_proc_unlock(struct svc_rqst *rqstp, struct nlm_res *resp)
+__nlmsvc_proc_unlock(struct svc_rqst *rqstp, struct lockd_res *resp)
 {
 	struct lockd_args *argp = rqstp->rq_argp;
 	struct nlm_host	*host;
@@ -294,7 +294,7 @@ nlmsvc_proc_unlock(struct svc_rqst *rqstp)
  * was granted
  */
 static __be32
-__nlmsvc_proc_granted(struct svc_rqst *rqstp, struct nlm_res *resp)
+__nlmsvc_proc_granted(struct svc_rqst *rqstp, struct lockd_res *resp)
 {
 	struct lockd_args *argp = rqstp->rq_argp;
 
@@ -343,7 +343,7 @@ static const struct rpc_call_ops nlmsvc_callback_ops = {
  * doesn't break any clients.
  */
 static __be32 nlmsvc_callback(struct svc_rqst *rqstp, u32 proc,
-		__be32 (*func)(struct svc_rqst *, struct nlm_res *))
+		__be32 (*func)(struct svc_rqst *, struct lockd_res *))
 {
 	struct lockd_args *argp = rqstp->rq_argp;
 	struct nlm_host	*host;
@@ -412,7 +412,7 @@ static __be32
 nlmsvc_proc_share(struct svc_rqst *rqstp)
 {
 	struct lockd_args *argp = rqstp->rq_argp;
-	struct nlm_res *resp = rqstp->rq_resp;
+	struct lockd_res *resp = rqstp->rq_resp;
 	struct nlm_host	*host;
 	struct nlm_file	*file;
 
@@ -450,7 +450,7 @@ static __be32
 nlmsvc_proc_unshare(struct svc_rqst *rqstp)
 {
 	struct lockd_args *argp = rqstp->rq_argp;
-	struct nlm_res *resp = rqstp->rq_resp;
+	struct lockd_res *resp = rqstp->rq_resp;
 	struct nlm_host	*host;
 	struct nlm_file	*file;
 
@@ -539,7 +539,7 @@ nlmsvc_proc_sm_notify(struct svc_rqst *rqstp)
 static __be32
 nlmsvc_proc_granted_res(struct svc_rqst *rqstp)
 {
-	struct nlm_res *argp = rqstp->rq_argp;
+	struct lockd_res *argp = rqstp->rq_argp;
 
 	if (!nlmsvc_ops)
 		return rpc_success;
@@ -584,7 +584,7 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_encode = nlmsvc_encode_testres,
 		.pc_argsize = sizeof(struct lockd_args),
 		.pc_argzero = sizeof(struct lockd_args),
-		.pc_ressize = sizeof(struct nlm_res),
+		.pc_ressize = sizeof(struct lockd_res),
 		.pc_xdrressize = Ck+St+2+No+Rg,
 		.pc_name = "TEST",
 	},
@@ -594,7 +594,7 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_encode = nlmsvc_encode_res,
 		.pc_argsize = sizeof(struct lockd_args),
 		.pc_argzero = sizeof(struct lockd_args),
-		.pc_ressize = sizeof(struct nlm_res),
+		.pc_ressize = sizeof(struct lockd_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "LOCK",
 	},
@@ -604,7 +604,7 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_encode = nlmsvc_encode_res,
 		.pc_argsize = sizeof(struct lockd_args),
 		.pc_argzero = sizeof(struct lockd_args),
-		.pc_ressize = sizeof(struct nlm_res),
+		.pc_ressize = sizeof(struct lockd_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "CANCEL",
 	},
@@ -614,7 +614,7 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_encode = nlmsvc_encode_res,
 		.pc_argsize = sizeof(struct lockd_args),
 		.pc_argzero = sizeof(struct lockd_args),
-		.pc_ressize = sizeof(struct nlm_res),
+		.pc_ressize = sizeof(struct lockd_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "UNLOCK",
 	},
@@ -624,7 +624,7 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_encode = nlmsvc_encode_res,
 		.pc_argsize = sizeof(struct lockd_args),
 		.pc_argzero = sizeof(struct lockd_args),
-		.pc_ressize = sizeof(struct nlm_res),
+		.pc_ressize = sizeof(struct lockd_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "GRANTED",
 	},
@@ -682,8 +682,8 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_func = nlmsvc_proc_null,
 		.pc_decode = nlmsvc_decode_void,
 		.pc_encode = nlmsvc_encode_void,
-		.pc_argsize = sizeof(struct nlm_res),
-		.pc_argzero = sizeof(struct nlm_res),
+		.pc_argsize = sizeof(struct lockd_res),
+		.pc_argzero = sizeof(struct lockd_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "TEST_RES",
@@ -692,8 +692,8 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_func = nlmsvc_proc_null,
 		.pc_decode = nlmsvc_decode_void,
 		.pc_encode = nlmsvc_encode_void,
-		.pc_argsize = sizeof(struct nlm_res),
-		.pc_argzero = sizeof(struct nlm_res),
+		.pc_argsize = sizeof(struct lockd_res),
+		.pc_argzero = sizeof(struct lockd_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "LOCK_RES",
@@ -702,8 +702,8 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_func = nlmsvc_proc_null,
 		.pc_decode = nlmsvc_decode_void,
 		.pc_encode = nlmsvc_encode_void,
-		.pc_argsize = sizeof(struct nlm_res),
-		.pc_argzero = sizeof(struct nlm_res),
+		.pc_argsize = sizeof(struct lockd_res),
+		.pc_argzero = sizeof(struct lockd_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "CANCEL_RES",
@@ -712,8 +712,8 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_func = nlmsvc_proc_null,
 		.pc_decode = nlmsvc_decode_void,
 		.pc_encode = nlmsvc_encode_void,
-		.pc_argsize = sizeof(struct nlm_res),
-		.pc_argzero = sizeof(struct nlm_res),
+		.pc_argsize = sizeof(struct lockd_res),
+		.pc_argzero = sizeof(struct lockd_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "UNLOCK_RES",
@@ -722,8 +722,8 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_func = nlmsvc_proc_granted_res,
 		.pc_decode = nlmsvc_decode_res,
 		.pc_encode = nlmsvc_encode_void,
-		.pc_argsize = sizeof(struct nlm_res),
-		.pc_argzero = sizeof(struct nlm_res),
+		.pc_argsize = sizeof(struct lockd_res),
+		.pc_argzero = sizeof(struct lockd_res),
 		.pc_ressize = sizeof(struct nlm_void),
 		.pc_xdrressize = St,
 		.pc_name = "GRANTED_RES",
@@ -774,7 +774,7 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_encode = nlmsvc_encode_shareres,
 		.pc_argsize = sizeof(struct lockd_args),
 		.pc_argzero = sizeof(struct lockd_args),
-		.pc_ressize = sizeof(struct nlm_res),
+		.pc_ressize = sizeof(struct lockd_res),
 		.pc_xdrressize = Ck+St+1,
 		.pc_name = "SHARE",
 	},
@@ -784,7 +784,7 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_encode = nlmsvc_encode_shareres,
 		.pc_argsize = sizeof(struct lockd_args),
 		.pc_argzero = sizeof(struct lockd_args),
-		.pc_ressize = sizeof(struct nlm_res),
+		.pc_ressize = sizeof(struct lockd_res),
 		.pc_xdrressize = Ck+St+1,
 		.pc_name = "UNSHARE",
 	},
@@ -794,7 +794,7 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_encode = nlmsvc_encode_res,
 		.pc_argsize = sizeof(struct lockd_args),
 		.pc_argzero = sizeof(struct lockd_args),
-		.pc_ressize = sizeof(struct nlm_res),
+		.pc_ressize = sizeof(struct lockd_res),
 		.pc_xdrressize = Ck+St,
 		.pc_name = "NM_LOCK",
 	},
@@ -815,7 +815,7 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
  */
 union nlmsvc_xdrstore {
 	struct lockd_args		args;
-	struct nlm_res			res;
+	struct lockd_res		res;
 	struct nlm_reboot		reboot;
 };
 
diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index 0130cdea5642..bcf65152a436 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -127,7 +127,7 @@ svcxdr_encode_holder(struct xdr_stream *xdr, const struct lockd_lock *lock)
 }
 
 static bool
-svcxdr_encode_testrply(struct xdr_stream *xdr, const struct nlm_res *resp)
+svcxdr_encode_testrply(struct xdr_stream *xdr, const struct lockd_res *resp)
 {
 	if (!svcxdr_encode_stats(xdr, resp->status))
 		return false;
@@ -231,7 +231,7 @@ nlmsvc_decode_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 bool
 nlmsvc_decode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct nlm_res *resp = rqstp->rq_argp;
+	struct lockd_res *resp = rqstp->rq_argp;
 
 	if (!svcxdr_decode_cookie(xdr, &resp->cookie))
 		return false;
@@ -322,7 +322,7 @@ nlmsvc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 bool
 nlmsvc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct nlm_res *resp = rqstp->rq_resp;
+	struct lockd_res *resp = rqstp->rq_resp;
 
 	return svcxdr_encode_cookie(xdr, &resp->cookie) &&
 		svcxdr_encode_testrply(xdr, resp);
@@ -331,7 +331,7 @@ nlmsvc_encode_testres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 bool
 nlmsvc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct nlm_res *resp = rqstp->rq_resp;
+	struct lockd_res *resp = rqstp->rq_resp;
 
 	return svcxdr_encode_cookie(xdr, &resp->cookie) &&
 		svcxdr_encode_stats(xdr, resp->status);
@@ -340,7 +340,7 @@ nlmsvc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 bool
 nlmsvc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
-	struct nlm_res *resp = rqstp->rq_resp;
+	struct lockd_res *resp = rqstp->rq_resp;
 
 	if (!svcxdr_encode_cookie(xdr, &resp->cookie))
 		return false;
diff --git a/fs/lockd/xdr.h b/fs/lockd/xdr.h
index ffdcad0f8680..a480df7cae31 100644
--- a/fs/lockd/xdr.h
+++ b/fs/lockd/xdr.h
@@ -71,7 +71,7 @@ struct lockd_args {
 /*
  * Generic lockd result
  */
-struct nlm_res {
+struct lockd_res {
 	struct lockd_cookie	cookie;
 	__be32			status;
 	struct lockd_lock	lock;

-- 
2.54.0


