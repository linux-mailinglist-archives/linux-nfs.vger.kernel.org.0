Return-Path: <linux-nfs+bounces-21548-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLqmNM1xA2q55wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21548-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:30:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77315527AB5
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C2B032F5F0E
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D77E374187;
	Tue, 12 May 2026 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNkc23ld"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3B3373BF4
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609647; cv=none; b=m1e+oat3grTtl8K6lFf5lA4RqMrvMJzhsYWI3MQ6a1FE+KFUaRFcE7DLBJF8YySJmYZ0wcerzn9xYZvbRIqfUXKCOtCurgb5eTg5qAtaJ/h7qyq1dNg95hFn6gszKlp0QyZ3IwbHXzUOS98EV01bpk7Tjp8zl+cPHuVfPJgwduY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609647; c=relaxed/simple;
	bh=987jDKqm96JOE3qDKIGFJ7iBKp81SomQNHkQz12wLd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X24q98XokBmsB8g6mJm68FoUedzXUl3/iOuLLSLBnFRqsblrk8gzK14MVLfxHLZFtweE8gUOlMmLlzWvMuH/KqD77gr/PFZoOyh68rDc97YSU/8m0b36tua/ylbx0uV3UaiORPWIYJ42yMcyhyR346yix7Tx5UYg7t6jxM+5vV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNkc23ld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD2EC4AF0C;
	Tue, 12 May 2026 18:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609647;
	bh=987jDKqm96JOE3qDKIGFJ7iBKp81SomQNHkQz12wLd8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rNkc23ld8ZwWRB/p5GHUxpGVHjTaeEOkUTTXvlW6Sf6+WlYF+LkTUmPGchlZ4hr0k
	 XFQbHMLsbfGMeO3Uth00rgrE+svxTkvSILFWi2PpTYoQi/h1hP+Xvuyyq5GzfJayl+
	 h1v5fv9kqBKIYHdOP3rkIS7BgDRJXTH4pnqZ4fnSNpv4DGSmZcAW4IxzlQrr+bV7J6
	 gJ2jQPIyZfrU3OKkYFB3w62r3QF7q0e49PW/WITXrY+tAXoMtWD/4EDxD78mSH34Zd
	 cqQt1ZEnxTBgg3me6VxeZWxPsiJYNhf8SsF5PA1G4LEYUVGbiyiTNWvrSLygmFm2+I
	 krVqjs/9rLzmw==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:13:43 -0400
Subject: [PATCH 08/38] lockd: Rename struct nlm_lock to lockd_lock
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-8-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=21922;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=coI3ZaRz2M6kxBIkqRSP4QMoOgKUJRQbg5xtt34O/WU=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23kGOSPCxM/hxFgAmn9r1DxHU5wbO7yT2NYI
 KLOtPenixGJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5AAKCRAzarMzb2Z/
 l4n7D/0Q7fAUcfe/Ip1H4Ok4K3AO4gIkEcgNb+3eB+1B7LxKS6nGcfrzpASaloFuqgOYCYggKp+
 ztvquEqpvVovyszi4qiZSOQBOujTI5wB24xr1+tyxuq4FvtQvGfFxbO9pR2L/L3V2hh/tccp9F7
 EpbRI5tKFdtxcWg9Ke9VQS/Q0+fGW0Kvo9fze5qi8l9ykbfW7LDWiNhIuCUdsLUIEVkvMurXixi
 uNYMgOEHDLNyFmzhxry/RR/6+1spVhSrj3bbuoAsGCtTG8QyusXJik5cYD2zMBJUcfrOZKg7uou
 jl9cQni/hD93+Tz++t+DKseFChMz4auqd/r5Or1VuNKOpq7a+mtBbAre+JdoMcBJbCNe7SmM1vA
 6jpCCK+dNbnCM4TprCO3WzwkRLgOnxcB7k/VLxyk/m+5+RNLO2xxRAg6AtzIkTRPUNEgkctRf5l
 yb1AauIPECC9cBpDcHgoIkv44MWuXb7dRGWIt4ERRlLwUtrxDGo/+bRWTeDLU2jiw9f1jShb630
 BffdgB30rqcv9aGYCQK4izKCt9xiJaj2/DaoXyWzMPp7R4h1EYn6hDrAl882H6IF5PCbAgolVSG
 w3Mg/9Rc4KaME5vxFEYHhrM29P3MpDT0zPLpai2z4LJmsNSdVrfPw6IJHl74cpyzOtpuShjWUjL
 QnGu//DcDFjMcgA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 77315527AB5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21548-lists,linux-nfs=lfdr.de];
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

A subsequent patch will convert fs/lockd/svcproc.c to use
machine-generated XDR encoding and decoding functions in a
manner similar to fs/lockd/svc4proc.c. Machine-generated
types derived from the NLM specification will conflict with
the internal types of the same name.

Rename the internal struct nlm_lock type to lockd_lock to
avoid such naming conflicts.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/clnt4xdr.c | 16 ++++++++--------
 fs/lockd/clntlock.c |  2 +-
 fs/lockd/clntproc.c |  2 +-
 fs/lockd/clntxdr.c  | 16 ++++++++--------
 fs/lockd/lockd.h    | 16 ++++++++--------
 fs/lockd/svc4proc.c | 30 +++++++++++++++---------------
 fs/lockd/svclock.c  | 22 +++++++++++-----------
 fs/lockd/svcproc.c  |  2 +-
 fs/lockd/svcsubs.c  |  2 +-
 fs/lockd/trace.h    |  4 ++--
 fs/lockd/xdr.c      |  8 ++++----
 fs/lockd/xdr.h      |  6 +++---
 12 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/fs/lockd/clnt4xdr.c b/fs/lockd/clnt4xdr.c
index 6d881f9702a9..8973711264cb 100644
--- a/fs/lockd/clnt4xdr.c
+++ b/fs/lockd/clnt4xdr.c
@@ -63,7 +63,7 @@ static s64 loff_t_to_s64(loff_t offset)
 	return res;
 }
 
-static void nlm4_compute_offsets(const struct nlm_lock *lock,
+static void nlm4_compute_offsets(const struct lockd_lock *lock,
 				 u64 *l_offset, u64 *l_len)
 {
 	const struct file_lock *fl = &lock->fl;
@@ -240,7 +240,7 @@ static int decode_nlm4_stat(struct xdr_stream *xdr, __be32 *stat)
 static void encode_nlm4_holder(struct xdr_stream *xdr,
 			       const struct nlm_res *result)
 {
-	const struct nlm_lock *lock = &result->lock;
+	const struct lockd_lock *lock = &result->lock;
 	u64 l_offset, l_len;
 	__be32 *p;
 
@@ -256,7 +256,7 @@ static void encode_nlm4_holder(struct xdr_stream *xdr,
 
 static int decode_nlm4_holder(struct xdr_stream *xdr, struct nlm_res *result)
 {
-	struct nlm_lock *lock = &result->lock;
+	struct lockd_lock *lock = &result->lock;
 	struct file_lock *fl = &lock->fl;
 	u64 l_offset, l_len;
 	u32 exclusive;
@@ -317,7 +317,7 @@ static void encode_caller_name(struct xdr_stream *xdr, const char *name)
  *	};
  */
 static void encode_nlm4_lock(struct xdr_stream *xdr,
-			     const struct nlm_lock *lock)
+			     const struct lockd_lock *lock)
 {
 	u64 l_offset, l_len;
 	__be32 *p;
@@ -355,7 +355,7 @@ static void nlm4_xdr_enc_testargs(struct rpc_rqst *req,
 				  const void *data)
 {
 	const struct nlm_args *args = data;
-	const struct nlm_lock *lock = &args->lock;
+	const struct lockd_lock *lock = &args->lock;
 
 	encode_cookie(xdr, &args->cookie);
 	encode_bool(xdr, lock->fl.c.flc_type == F_WRLCK);
@@ -377,7 +377,7 @@ static void nlm4_xdr_enc_lockargs(struct rpc_rqst *req,
 				  const void *data)
 {
 	const struct nlm_args *args = data;
-	const struct nlm_lock *lock = &args->lock;
+	const struct lockd_lock *lock = &args->lock;
 
 	encode_cookie(xdr, &args->cookie);
 	encode_bool(xdr, args->block);
@@ -400,7 +400,7 @@ static void nlm4_xdr_enc_cancargs(struct rpc_rqst *req,
 				  const void *data)
 {
 	const struct nlm_args *args = data;
-	const struct nlm_lock *lock = &args->lock;
+	const struct lockd_lock *lock = &args->lock;
 
 	encode_cookie(xdr, &args->cookie);
 	encode_bool(xdr, args->block);
@@ -419,7 +419,7 @@ static void nlm4_xdr_enc_unlockargs(struct rpc_rqst *req,
 				    const void *data)
 {
 	const struct nlm_args *args = data;
-	const struct nlm_lock *lock = &args->lock;
+	const struct lockd_lock *lock = &args->lock;
 
 	encode_cookie(xdr, &args->cookie);
 	encode_nlm4_lock(xdr, lock);
diff --git a/fs/lockd/clntlock.c b/fs/lockd/clntlock.c
index 8fa30c42c92a..f797cc99f94d 100644
--- a/fs/lockd/clntlock.c
+++ b/fs/lockd/clntlock.c
@@ -158,7 +158,7 @@ int nlmclnt_wait(struct nlm_wait *block, struct nlm_rqst *req, long timeout)
 /*
  * The server lockd has called us back to tell us the lock was granted
  */
-__be32 nlmclnt_grant(const struct sockaddr *addr, const struct nlm_lock *lock)
+__be32 nlmclnt_grant(const struct sockaddr *addr, const struct lockd_lock *lock)
 {
 	const struct file_lock *fl = &lock->fl;
 	const struct nfs_fh *fh = &lock->fh;
diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index 50cfab2f31c7..1aa6597ae0b7 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -129,7 +129,7 @@ static struct nlm_lockowner *nlmclnt_find_lockowner(struct nlm_host *host, fl_ow
 static void nlmclnt_setlockargs(struct nlm_rqst *req, struct file_lock *fl)
 {
 	struct nlm_args	*argp = &req->a_args;
-	struct nlm_lock	*lock = &argp->lock;
+	struct lockd_lock *lock = &argp->lock;
 	char *nodename = req->a_host->h_rpcclnt->cl_nodename;
 
 	nlmclnt_next_cookie(&argp->cookie);
diff --git a/fs/lockd/clntxdr.c b/fs/lockd/clntxdr.c
index 2a4d28847254..efa45f12960d 100644
--- a/fs/lockd/clntxdr.c
+++ b/fs/lockd/clntxdr.c
@@ -60,7 +60,7 @@ static s32 loff_t_to_s32(loff_t offset)
 	return res;
 }
 
-static void nlm_compute_offsets(const struct nlm_lock *lock,
+static void nlm_compute_offsets(const struct lockd_lock *lock,
 				u32 *l_offset, u32 *l_len)
 {
 	const struct file_lock *fl = &lock->fl;
@@ -236,7 +236,7 @@ static int decode_nlm_stat(struct xdr_stream *xdr,
 static void encode_nlm_holder(struct xdr_stream *xdr,
 			      const struct nlm_res *result)
 {
-	const struct nlm_lock *lock = &result->lock;
+	const struct lockd_lock *lock = &result->lock;
 	u32 l_offset, l_len;
 	__be32 *p;
 
@@ -252,7 +252,7 @@ static void encode_nlm_holder(struct xdr_stream *xdr,
 
 static int decode_nlm_holder(struct xdr_stream *xdr, struct nlm_res *result)
 {
-	struct nlm_lock *lock = &result->lock;
+	struct lockd_lock *lock = &result->lock;
 	struct file_lock *fl = &lock->fl;
 	u32 exclusive, l_offset, l_len;
 	int error;
@@ -319,7 +319,7 @@ static void encode_caller_name(struct xdr_stream *xdr, const char *name)
  *	};
  */
 static void encode_nlm_lock(struct xdr_stream *xdr,
-			    const struct nlm_lock *lock)
+			    const struct lockd_lock *lock)
 {
 	u32 l_offset, l_len;
 	__be32 *p;
@@ -356,7 +356,7 @@ static void nlm_xdr_enc_testargs(struct rpc_rqst *req,
 				 const void *data)
 {
 	const struct nlm_args *args = data;
-	const struct nlm_lock *lock = &args->lock;
+	const struct lockd_lock *lock = &args->lock;
 
 	encode_cookie(xdr, &args->cookie);
 	encode_bool(xdr, lock->fl.c.flc_type == F_WRLCK);
@@ -378,7 +378,7 @@ static void nlm_xdr_enc_lockargs(struct rpc_rqst *req,
 				 const void *data)
 {
 	const struct nlm_args *args = data;
-	const struct nlm_lock *lock = &args->lock;
+	const struct lockd_lock *lock = &args->lock;
 
 	encode_cookie(xdr, &args->cookie);
 	encode_bool(xdr, args->block);
@@ -401,7 +401,7 @@ static void nlm_xdr_enc_cancargs(struct rpc_rqst *req,
 				 const void *data)
 {
 	const struct nlm_args *args = data;
-	const struct nlm_lock *lock = &args->lock;
+	const struct lockd_lock *lock = &args->lock;
 
 	encode_cookie(xdr, &args->cookie);
 	encode_bool(xdr, args->block);
@@ -420,7 +420,7 @@ static void nlm_xdr_enc_unlockargs(struct rpc_rqst *req,
 				   const void *data)
 {
 	const struct nlm_args *args = data;
-	const struct nlm_lock *lock = &args->lock;
+	const struct lockd_lock *lock = &args->lock;
 
 	encode_cookie(xdr, &args->cookie);
 	encode_nlm_lock(xdr, lock);
diff --git a/fs/lockd/lockd.h b/fs/lockd/lockd.h
index 119818568507..032790834c7e 100644
--- a/fs/lockd/lockd.h
+++ b/fs/lockd/lockd.h
@@ -253,7 +253,7 @@ void		  nlmclnt_queue_block(struct nlm_wait *block);
 __be32		  nlmclnt_dequeue_block(struct nlm_wait *block);
 int		  nlmclnt_wait(struct nlm_wait *block, struct nlm_rqst *req, long timeout);
 __be32		  nlmclnt_grant(const struct sockaddr *addr,
-				const struct nlm_lock *lock);
+				const struct lockd_lock *lock);
 void		  nlmclnt_recovery(struct nlm_host *);
 int		  nlmclnt_reclaim(struct nlm_host *, struct file_lock *,
 				  struct nlm_rqst *);
@@ -313,13 +313,13 @@ typedef int	  (*nlm_host_match_fn_t)(void *cur, struct nlm_host *ref);
  */
 int		  lock_to_openmode(struct file_lock *);
 __be32		  nlmsvc_lock(struct svc_rqst *, struct nlm_file *,
-			      struct nlm_host *, struct nlm_lock *, int,
+			      struct nlm_host *, struct lockd_lock *, int,
 			      struct lockd_cookie *, int);
-__be32		  nlmsvc_unlock(struct net *net, struct nlm_file *, struct nlm_lock *);
+__be32		  nlmsvc_unlock(struct net *net, struct nlm_file *, struct lockd_lock *);
 __be32		  nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
-			struct nlm_host *host, struct nlm_lock *lock,
-			struct nlm_lock *conflock);
-__be32		  nlmsvc_cancel_blocked(struct net *net, struct nlm_file *, struct nlm_lock *);
+			struct nlm_host *host, struct lockd_lock *lock,
+			struct lockd_lock *conflock);
+__be32		  nlmsvc_cancel_blocked(struct net *net, struct nlm_file *, struct lockd_lock *);
 void		  nlmsvc_retry_blocked(struct svc_rqst *rqstp);
 void		  nlmsvc_traverse_blocks(struct nlm_host *, struct nlm_file *,
 					nlm_host_match_fn_t match);
@@ -332,10 +332,10 @@ int		  nlmsvc_dispatch(struct svc_rqst *rqstp);
  * File handling for the server personality
  */
 __be32		  nlm_lookup_file(struct svc_rqst *, struct nlm_file **,
-				  struct nlm_lock *, int);
+				  struct lockd_lock *, int);
 void		  nlm_release_file(struct nlm_file *);
 void		  nlmsvc_put_lockowner(struct nlm_lockowner *);
-void		  nlmsvc_release_lockowner(struct nlm_lock *);
+void		  nlmsvc_release_lockowner(struct lockd_lock *);
 void		  nlmsvc_mark_resources(struct net *);
 void		  nlmsvc_free_host_resources(struct nlm_host *);
 void		  nlmsvc_invalidate_all(void);
diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 249ef49f1bcd..f7067fae6c86 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -26,13 +26,13 @@
 #include "nlm4xdr_gen.h"
 
 /*
- * Wrapper structures combine xdrgen types with legacy nlm_lock.
+ * Wrapper structures combine xdrgen types with legacy lockd_lock.
  * The xdrgen field must be first so the structure can be cast
  * to its XDR type for the RPC dispatch layer.
  */
 struct nlm4_testargs_wrapper {
 	struct nlm4_testargs		xdrgen;
-	struct nlm_lock			lock;
+	struct lockd_lock		lock;
 };
 
 static_assert(offsetof(struct nlm4_testargs_wrapper, xdrgen) == 0);
@@ -40,21 +40,21 @@ static_assert(offsetof(struct nlm4_testargs_wrapper, xdrgen) == 0);
 struct nlm4_lockargs_wrapper {
 	struct nlm4_lockargs		xdrgen;
 	struct lockd_cookie		cookie;
-	struct nlm_lock			lock;
+	struct lockd_lock		lock;
 };
 
 static_assert(offsetof(struct nlm4_lockargs_wrapper, xdrgen) == 0);
 
 struct nlm4_cancargs_wrapper {
 	struct nlm4_cancargs		xdrgen;
-	struct nlm_lock			lock;
+	struct lockd_lock		lock;
 };
 
 static_assert(offsetof(struct nlm4_cancargs_wrapper, xdrgen) == 0);
 
 struct nlm4_unlockargs_wrapper {
 	struct nlm4_unlockargs		xdrgen;
-	struct nlm_lock			lock;
+	struct lockd_lock		lock;
 };
 
 static_assert(offsetof(struct nlm4_unlockargs_wrapper, xdrgen) == 0);
@@ -74,12 +74,12 @@ static_assert(offsetof(struct nlm4_notify_wrapper, xdrgen) == 0);
 
 struct nlm4_testres_wrapper {
 	struct nlm4_testres		xdrgen;
-	struct nlm_lock			lock;
+	struct lockd_lock		lock;
 };
 
 struct nlm4_shareargs_wrapper {
 	struct nlm4_shareargs		xdrgen;
-	struct nlm_lock			lock;
+	struct lockd_lock		lock;
 };
 
 static_assert(offsetof(struct nlm4_shareargs_wrapper, xdrgen) == 0);
@@ -110,7 +110,7 @@ nlm4_netobj_to_cookie(struct lockd_cookie *cookie, netobj *object)
 }
 
 static __be32
-nlm4_lock_to_nlm_lock(struct nlm_lock *lock, struct nlm4_lock *alock)
+nlm4_lock_to_lockd_lock(struct lockd_lock *lock, struct nlm4_lock *alock)
 {
 	if (alock->fh.len > NFS_MAXFHSIZE)
 		return nlm_lck_denied;
@@ -142,7 +142,7 @@ nlm4svc_lookup_host(struct svc_rqst *rqstp, string caller, bool monitored)
 
 static __be32
 nlm4svc_lookup_file(struct svc_rqst *rqstp, struct nlm_host *host,
-		    struct nlm_lock *lock, struct nlm_file **filp,
+		    struct lockd_lock *lock, struct nlm_file **filp,
 		    struct nlm4_lock *xdr_lock, unsigned char type)
 {
 	bool is_test = (rqstp->rq_proc == NLMPROC4_TEST ||
@@ -269,7 +269,7 @@ static __be32 nlm4svc_proc_test(struct svc_rqst *rqstp)
 	nlmsvc_release_lockowner(&argp->lock);
 
 	if (resp->xdrgen.stat.stat == nlm_lck_denied) {
-		struct nlm_lock *conf = &resp->lock;
+		struct lockd_lock *conf = &resp->lock;
 		struct nlm4_holder *holder = &resp->xdrgen.stat.u.holder;
 
 		holder->exclusive = (conf->fl.c.flc_type != F_RDLCK);
@@ -527,8 +527,8 @@ nlm4svc_proc_granted(struct svc_rqst *rqstp)
 
 	resp->xdrgen.cookie = argp->xdrgen.cookie;
 
-	resp->xdrgen.stat.stat = nlm4_lock_to_nlm_lock(&argp->lock,
-						       &argp->xdrgen.alock);
+	resp->xdrgen.stat.stat = nlm4_lock_to_lockd_lock(&argp->lock,
+							 &argp->xdrgen.alock);
 	if (resp->xdrgen.stat.stat)
 		goto out;
 
@@ -842,7 +842,7 @@ __nlm4svc_proc_granted_msg(struct svc_rqst *rqstp, struct nlm_res *resp)
 	if (nlm4_netobj_to_cookie(&resp->cookie, &argp->xdrgen.cookie))
 		goto out;
 
-	if (nlm4_lock_to_nlm_lock(&argp->lock, &argp->xdrgen.alock))
+	if (nlm4_lock_to_lockd_lock(&argp->lock, &argp->xdrgen.alock))
 		goto out;
 
 	resp->status = nlmclnt_grant(svc_addr(rqstp), &argp->lock);
@@ -982,7 +982,7 @@ static __be32 nlm4svc_proc_share(struct svc_rqst *rqstp)
 {
 	struct nlm4_shareargs_wrapper *argp = rqstp->rq_argp;
 	struct nlm4_shareres_wrapper *resp = rqstp->rq_resp;
-	struct nlm_lock	*lock = &argp->lock;
+	struct lockd_lock *lock = &argp->lock;
 	struct nlm_host	*host = NULL;
 	struct nlm_file	*file = NULL;
 	struct nlm4_lock xdr_lock = {
@@ -1050,7 +1050,7 @@ static __be32 nlm4svc_proc_unshare(struct svc_rqst *rqstp)
 {
 	struct nlm4_shareargs_wrapper *argp = rqstp->rq_argp;
 	struct nlm4_shareres_wrapper *resp = rqstp->rq_resp;
-	struct nlm_lock	*lock = &argp->lock;
+	struct lockd_lock *lock = &argp->lock;
 	struct nlm4_lock xdr_lock = {
 		.fh		= argp->xdrgen.share.fh,
 		.oh		= argp->xdrgen.share.oh,
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 7fb03042ebee..e48d31f14a65 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -37,7 +37,7 @@ static void nlmsvc_release_block(struct nlm_block *block);
 static void	nlmsvc_insert_block(struct nlm_block *block, unsigned long);
 static void	nlmsvc_remove_block(struct nlm_block *block);
 
-static int nlmsvc_setgrantargs(struct nlm_rqst *call, struct nlm_lock *lock);
+static int nlmsvc_setgrantargs(struct nlm_rqst *call, struct lockd_lock *lock);
 static void nlmsvc_freegrantargs(struct nlm_rqst *call);
 static const struct rpc_call_ops nlmsvc_grant_ops;
 
@@ -142,7 +142,7 @@ nlmsvc_remove_block(struct nlm_block *block)
  * Find a block for a given lock
  */
 static struct nlm_block *
-nlmsvc_lookup_block(struct nlm_file *file, struct nlm_lock *lock)
+nlmsvc_lookup_block(struct nlm_file *file, struct lockd_lock *lock)
 {
 	struct nlm_block	*block;
 	struct file_lock	*fl;
@@ -221,7 +221,7 @@ nlmsvc_find_block(struct lockd_cookie *cookie)
  */
 static struct nlm_block *
 nlmsvc_create_block(struct svc_rqst *rqstp, struct nlm_host *host,
-		    struct nlm_file *file, struct nlm_lock *lock,
+		    struct nlm_file *file, struct lockd_lock *lock,
 		    struct lockd_cookie *cookie)
 {
 	struct nlm_block	*block;
@@ -399,7 +399,7 @@ static struct nlm_lockowner *nlmsvc_find_lockowner(struct nlm_host *host, pid_t
 }
 
 void
-nlmsvc_release_lockowner(struct nlm_lock *lock)
+nlmsvc_release_lockowner(struct lockd_lock *lock)
 {
 	if (lock->fl.c.flc_owner)
 		nlmsvc_put_lockowner(lock->fl.c.flc_owner);
@@ -415,7 +415,7 @@ void nlmsvc_locks_init_private(struct file_lock *fl, struct nlm_host *host,
  * Initialize arguments for GRANTED call. The nlm_rqst structure
  * has been cleared already.
  */
-static int nlmsvc_setgrantargs(struct nlm_rqst *call, struct nlm_lock *lock)
+static int nlmsvc_setgrantargs(struct nlm_rqst *call, struct lockd_lock *lock)
 {
 	locks_copy_lock(&call->a_args.lock.fl, &lock->fl);
 	memcpy(&call->a_args.lock.fh, &lock->fh, sizeof(call->a_args.lock.fh));
@@ -476,7 +476,7 @@ nlmsvc_defer_lock_rqst(struct svc_rqst *rqstp, struct nlm_block *block)
  */
 __be32
 nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
-	    struct nlm_host *host, struct nlm_lock *lock, int wait,
+	    struct nlm_host *host, struct lockd_lock *lock, int wait,
 	    struct lockd_cookie *cookie, int reclaim)
 {
 	struct inode		*inode __maybe_unused = nlmsvc_file_inode(file);
@@ -609,8 +609,8 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
  */
 __be32
 nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
-		struct nlm_host *host, struct nlm_lock *lock,
-		struct nlm_lock *conflock)
+		struct nlm_host *host, struct lockd_lock *lock,
+		struct lockd_lock *conflock)
 {
 	int			error;
 	__be32			ret;
@@ -669,7 +669,7 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
  * must be removed.
  */
 __be32
-nlmsvc_unlock(struct net *net, struct nlm_file *file, struct nlm_lock *lock)
+nlmsvc_unlock(struct net *net, struct nlm_file *file, struct lockd_lock *lock)
 {
 	int	error = 0;
 
@@ -707,7 +707,7 @@ nlmsvc_unlock(struct net *net, struct nlm_file *file, struct nlm_lock *lock)
  * The calling procedure must check whether the file can be closed.
  */
 __be32
-nlmsvc_cancel_blocked(struct net *net, struct nlm_file *file, struct nlm_lock *lock)
+nlmsvc_cancel_blocked(struct net *net, struct nlm_file *file, struct lockd_lock *lock)
 {
 	struct nlm_block	*block;
 	int status = 0;
@@ -848,7 +848,7 @@ static void
 nlmsvc_grant_blocked(struct nlm_block *block)
 {
 	struct nlm_file		*file = block->b_file;
-	struct nlm_lock		*lock = &block->b_call->a_args.lock;
+	struct lockd_lock	*lock = &block->b_call->a_args.lock;
 	int			mode;
 	int			error;
 	loff_t			fl_start, fl_end;
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 110e186802b6..2e1dbd4e1df9 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -67,7 +67,7 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 {
 	struct nlm_host		*host = NULL;
 	struct nlm_file		*file = NULL;
-	struct nlm_lock		*lock = &argp->lock;
+	struct lockd_lock	*lock = &argp->lock;
 	bool			is_test = (rqstp->rq_proc == NLMPROC_TEST ||
 					   rqstp->rq_proc == NLMPROC_TEST_MSG);
 	int			mode;
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index 9da9d6e0b42e..e24bacea7e03 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -132,7 +132,7 @@ static __be32 nlm_do_fopen(struct svc_rqst *rqstp,
  */
 __be32
 nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_file **result,
-		struct nlm_lock *lock, int mode)
+		struct lockd_lock *lock, int mode)
 {
 	struct nlm_file	*file;
 	unsigned int	hash;
diff --git a/fs/lockd/trace.h b/fs/lockd/trace.h
index 7214d7e96a42..aa858d9d406d 100644
--- a/fs/lockd/trace.h
+++ b/fs/lockd/trace.h
@@ -48,7 +48,7 @@ NLM_STATUS_LIST
 
 DECLARE_EVENT_CLASS(nlmclnt_lock_event,
 		TP_PROTO(
-			const struct nlm_lock *lock,
+			const struct lockd_lock *lock,
 			const struct sockaddr *addr,
 			unsigned int addrlen,
 			__be32 status
@@ -87,7 +87,7 @@ DECLARE_EVENT_CLASS(nlmclnt_lock_event,
 #define DEFINE_NLMCLNT_EVENT(name)				\
 	DEFINE_EVENT(nlmclnt_lock_event, name,			\
 			TP_PROTO(				\
-				const struct nlm_lock *lock,	\
+				const struct lockd_lock *lock,	\
 				const struct sockaddr *addr,	\
 				unsigned int addrlen,		\
 				__be32	status			\
diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index dfca8b8dab73..55868222984a 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -69,7 +69,7 @@ svcxdr_decode_fhandle(struct xdr_stream *xdr, struct nfs_fh *fh)
 }
 
 static bool
-svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_lock *lock)
+svcxdr_decode_lock(struct xdr_stream *xdr, struct lockd_lock *lock)
 {
 	struct file_lock *fl = &lock->fl;
 	s32 start, len, end;
@@ -101,7 +101,7 @@ svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_lock *lock)
 }
 
 static bool
-svcxdr_encode_holder(struct xdr_stream *xdr, const struct nlm_lock *lock)
+svcxdr_encode_holder(struct xdr_stream *xdr, const struct lockd_lock *lock)
 {
 	const struct file_lock *fl = &lock->fl;
 	s32 start, len;
@@ -271,7 +271,7 @@ bool
 nlmsvc_decode_shareargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
-	struct nlm_lock	*lock = &argp->lock;
+	struct lockd_lock *lock = &argp->lock;
 
 	memset(lock, 0, sizeof(*lock));
 	locks_init_lock(&lock->fl);
@@ -298,7 +298,7 @@ bool
 nlmsvc_decode_notify(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 {
 	struct nlm_args *argp = rqstp->rq_argp;
-	struct nlm_lock	*lock = &argp->lock;
+	struct lockd_lock *lock = &argp->lock;
 
 	if (!svcxdr_decode_string(xdr, &lock->caller, &lock->len))
 		return false;
diff --git a/fs/lockd/xdr.h b/fs/lockd/xdr.h
index c7e0518862d7..805027d9b0fe 100644
--- a/fs/lockd/xdr.h
+++ b/fs/lockd/xdr.h
@@ -32,7 +32,7 @@ struct svc_rqst;
 #define	nlm_lck_denied_grace_period	cpu_to_be32(NLM_LCK_DENIED_GRACE_PERIOD)
 
 /* Lock info passed via NLM */
-struct nlm_lock {
+struct lockd_lock {
 	char *			caller;
 	unsigned int		len; 	/* length of "caller" */
 	struct nfs_fh		fh;
@@ -59,7 +59,7 @@ struct lockd_cookie {
  */
 struct nlm_args {
 	struct lockd_cookie	cookie;
-	struct nlm_lock		lock;
+	struct lockd_lock	lock;
 	u32			block;
 	u32			reclaim;
 	u32			state;
@@ -74,7 +74,7 @@ struct nlm_args {
 struct nlm_res {
 	struct lockd_cookie	cookie;
 	__be32			status;
-	struct nlm_lock		lock;
+	struct lockd_lock	lock;
 };
 
 /*

-- 
2.54.0


