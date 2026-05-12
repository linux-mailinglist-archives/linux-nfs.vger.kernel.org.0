Return-Path: <linux-nfs+bounces-21547-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLUmOMtxA2q55wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21547-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:30:35 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E138527AAD
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0FA032F464B
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27A336C5A1;
	Tue, 12 May 2026 18:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBUMG7ca"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA70368972
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609646; cv=none; b=XtrAwX3wNA8EDDyHJuVTMR12PeZR4po0IgM/BT2kCH0KUSlrcyXfThUmIcqDfO5ukkWx2N+wlpBSeGKS9Kv9QCjxXsCS/0wuPNSIpJqOqSxCTOam9pWSW4dpXFb+RONLnz8Pqq4PtOIWAHr3os7xpt1bJUl0Pm3T9IPMTZqRy50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609646; c=relaxed/simple;
	bh=a8JaBXnzBfIqb34W0aoA9iNRUTTsipK6hsBsudW0YJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gBHqFRjb89Tn9vOBZrnDeBKc6VGN0rdwyfQKau25+MU8CsWaxQcFHpUAvZWGypeKTq7EOUi13xIbDsV7pGk9WwgeCo2QLuiKq5pXsldb7hiz0EMgXodBjFMN7VoYo359thrufeQqzftQaM1WJqYP2BlahHllsa1lGZ4eopaY8YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBUMG7ca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C913EC2BCFA;
	Tue, 12 May 2026 18:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609646;
	bh=a8JaBXnzBfIqb34W0aoA9iNRUTTsipK6hsBsudW0YJg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RBUMG7cajj5hlF/zsNQJZ2gxlcuB4aZBmgVIhr9S4svrT57SUFhUCg+bFMrFU+oM6
	 AZ5eFJknAksWUCPNjkEBHK0bjG0H2MXbo4FqTVnhaLMtXmQ9i6NmL+osq3iHHFeqC6
	 1sCjEp+pBKvwQnfWksueB7SP8Y2bl5C7xbXBvTBtP0FJoMxXCYqxH3zHd9KncYSN6H
	 WUYWzTZLKvXlEc6jWxl3Ts/rOqebLOaTWcXHBViYEgscgjD4hQ2rc5exzNd8gs/S4q
	 /D9AeA6bPc8TZQqoxMu5IZ39rc65r87LOJLhzfmnx6e9eub00HWZalorN2OsguPn3A
	 xoZ2hhfk5xSjw==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:13:42 -0400
Subject: [PATCH 07/38] lockd: Rename struct nlm_cookie to lockd_cookie
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-7-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=9434;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=FP3MUWwf/0H7zrJRD73LSd3m8PpWbnNLHhqGQpL/9GU=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23k3xMgj5YQv6jE7cWgbDD3NafYbL/xc/q1V
 /W+U7hFGXeJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5AAKCRAzarMzb2Z/
 l5YKD/4uSFKqzeNrDXSUFXuFeOREz4nGog5iSbgO7jgGMzzvHTbDkD+g7n2+jWcKSZ3gqmLQcO8
 2JCzb8Q3kNdahA/9ayKwxMGhUTabylhGlRi62/lEmP/Ud1VO5d/zPxFpign38WVNrPMkOr8JoWH
 k/OfRlEUmVkaHTcnjwsCv/yNzOBntYIYOrdVcgOWVEK+l8m76hTx/II+foaORrqx4K03zVbDni4
 EqL0nfndMGUT2Lpj2srxw8129WY0Y9v8HYkIPkHwsdKnH6fisXe4H7AuIbf0Y8GxD7eBWppZF2y
 exBbwYvzoenMyDiHkcLkBrvbPv/V7emZlF8hT3HzJnJ+456JtUdSwhP1wHukuTy2e4g2OsTvLGw
 s0ST6HH9ONLP29SCn1UZ7QZO1PreyW7T6+a8YslbsGdBobY01UgL22HXoid4POAJ9gQXJYR9MPb
 26lGIBbc4VDrWAUgdGglcqgmduR4jviwpj8+3ddW4JG61iVynjQSIAMZ0PXq6m6mtXRb4kJzagK
 J91wVz1MgvGrkVRjRUxt8dqs0ixGIi+c6xuBgqFwzXJiSWc+P4dFpHM8VTd0QqHZIer8KlFfutn
 6tAljG7fSjsIlAtTOOB5KlZ6IMM+MmCHTfE8BDaZ3HwWcIHwwuEQseJWo/tdVRfHDPzr0t1VXHC
 d4w6/44i+EWt9gQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 7E138527AAD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21547-lists,linux-nfs=lfdr.de];
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

Machine-generated XDR types derived from the NLM specification
use names that match the protocol. Internal lockd types with
identical names cause compilation failures when machine-generated
encoders replace hand-coded ones.

Rename the internal struct nlm_cookie type to lockd_cookie to
prevent such collisions. The "lockd_" prefix distinguishes
implementation-specific types from specified NLM protocol types.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/clnt4xdr.c |  4 ++--
 fs/lockd/clntproc.c |  2 +-
 fs/lockd/clntxdr.c  |  4 ++--
 fs/lockd/lockd.h    |  6 +++---
 fs/lockd/svc4proc.c |  6 +++---
 fs/lockd/svclock.c  | 16 ++++++++--------
 fs/lockd/svcxdr.h   |  4 ++--
 fs/lockd/xdr.h      |  7 +++----
 8 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/fs/lockd/clnt4xdr.c b/fs/lockd/clnt4xdr.c
index 2058733eacf8..6d881f9702a9 100644
--- a/fs/lockd/clnt4xdr.c
+++ b/fs/lockd/clnt4xdr.c
@@ -132,13 +132,13 @@ static int decode_netobj(struct xdr_stream *xdr,
  *	netobj cookie;
  */
 static void encode_cookie(struct xdr_stream *xdr,
-			  const struct nlm_cookie *cookie)
+			  const struct lockd_cookie *cookie)
 {
 	encode_netobj(xdr, (u8 *)&cookie->data, cookie->len);
 }
 
 static int decode_cookie(struct xdr_stream *xdr,
-			     struct nlm_cookie *cookie)
+			     struct lockd_cookie *cookie)
 {
 	u32 length;
 	__be32 *p;
diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index 7f211008a5d2..50cfab2f31c7 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -42,7 +42,7 @@ static const struct rpc_call_ops nlmclnt_cancel_ops;
  */
 static atomic_t	nlm_cookie = ATOMIC_INIT(0x1234);
 
-void nlmclnt_next_cookie(struct nlm_cookie *c)
+void nlmclnt_next_cookie(struct lockd_cookie *c)
 {
 	u32	cookie = atomic_inc_return(&nlm_cookie);
 
diff --git a/fs/lockd/clntxdr.c b/fs/lockd/clntxdr.c
index 65555f5224b1..2a4d28847254 100644
--- a/fs/lockd/clntxdr.c
+++ b/fs/lockd/clntxdr.c
@@ -130,13 +130,13 @@ static int decode_netobj(struct xdr_stream *xdr,
  *	netobj cookie;
  */
 static void encode_cookie(struct xdr_stream *xdr,
-			  const struct nlm_cookie *cookie)
+			  const struct lockd_cookie *cookie)
 {
 	encode_netobj(xdr, (u8 *)&cookie->data, cookie->len);
 }
 
 static int decode_cookie(struct xdr_stream *xdr,
-			 struct nlm_cookie *cookie)
+			 struct lockd_cookie *cookie)
 {
 	u32 length;
 	__be32 *p;
diff --git a/fs/lockd/lockd.h b/fs/lockd/lockd.h
index 1db6cb352542..119818568507 100644
--- a/fs/lockd/lockd.h
+++ b/fs/lockd/lockd.h
@@ -257,7 +257,7 @@ __be32		  nlmclnt_grant(const struct sockaddr *addr,
 void		  nlmclnt_recovery(struct nlm_host *);
 int		  nlmclnt_reclaim(struct nlm_host *, struct file_lock *,
 				  struct nlm_rqst *);
-void		  nlmclnt_next_cookie(struct nlm_cookie *);
+void		  nlmclnt_next_cookie(struct lockd_cookie *);
 
 #ifdef CONFIG_LOCKD_V4
 extern const struct rpc_version nlm_version4;
@@ -314,7 +314,7 @@ typedef int	  (*nlm_host_match_fn_t)(void *cur, struct nlm_host *ref);
 int		  lock_to_openmode(struct file_lock *);
 __be32		  nlmsvc_lock(struct svc_rqst *, struct nlm_file *,
 			      struct nlm_host *, struct nlm_lock *, int,
-			      struct nlm_cookie *, int);
+			      struct lockd_cookie *, int);
 __be32		  nlmsvc_unlock(struct net *net, struct nlm_file *, struct nlm_lock *);
 __be32		  nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 			struct nlm_host *host, struct nlm_lock *lock,
@@ -323,7 +323,7 @@ __be32		  nlmsvc_cancel_blocked(struct net *net, struct nlm_file *, struct nlm_l
 void		  nlmsvc_retry_blocked(struct svc_rqst *rqstp);
 void		  nlmsvc_traverse_blocks(struct nlm_host *, struct nlm_file *,
 					nlm_host_match_fn_t match);
-void		  nlmsvc_grant_reply(struct nlm_cookie *, __be32);
+void		  nlmsvc_grant_reply(struct lockd_cookie *, __be32);
 void		  nlmsvc_release_call(struct nlm_rqst *);
 void		  nlmsvc_locks_init_private(struct file_lock *, struct nlm_host *, pid_t);
 int		  nlmsvc_dispatch(struct svc_rqst *rqstp);
diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index e3a6d69c1fa6..249ef49f1bcd 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -39,7 +39,7 @@ static_assert(offsetof(struct nlm4_testargs_wrapper, xdrgen) == 0);
 
 struct nlm4_lockargs_wrapper {
 	struct nlm4_lockargs		xdrgen;
-	struct nlm_cookie		cookie;
+	struct lockd_cookie		cookie;
 	struct nlm_lock			lock;
 };
 
@@ -88,7 +88,7 @@ static_assert(offsetof(struct nlm4_testres_wrapper, xdrgen) == 0);
 
 struct nlm4_res_wrapper {
 	struct nlm4_res			xdrgen;
-	struct nlm_cookie		cookie;
+	struct lockd_cookie		cookie;
 };
 
 static_assert(offsetof(struct nlm4_res_wrapper, xdrgen) == 0);
@@ -100,7 +100,7 @@ struct nlm4_shareres_wrapper {
 static_assert(offsetof(struct nlm4_shareres_wrapper, xdrgen) == 0);
 
 static __be32
-nlm4_netobj_to_cookie(struct nlm_cookie *cookie, netobj *object)
+nlm4_netobj_to_cookie(struct lockd_cookie *cookie, netobj *object)
 {
 	if (object->len > NLM_MAXCOOKIELEN)
 		return nlm_lck_denied_nolocks;
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index f4520149d6d7..7fb03042ebee 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -48,7 +48,7 @@ static LIST_HEAD(nlm_blocked);
 static DEFINE_SPINLOCK(nlm_blocked_lock);
 
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
-static const char *nlmdbg_cookie2a(const struct nlm_cookie *cookie)
+static const char *nlmdbg_cookie2a(const struct lockd_cookie *cookie)
 {
 	/*
 	 * We can get away with a static buffer because this is only called
@@ -75,7 +75,7 @@ static const char *nlmdbg_cookie2a(const struct nlm_cookie *cookie)
 	return buf;
 }
 #else
-static inline const char *nlmdbg_cookie2a(const struct nlm_cookie *cookie)
+static inline const char *nlmdbg_cookie2a(const struct lockd_cookie *cookie)
 {
 	return "???";
 }
@@ -171,7 +171,7 @@ nlmsvc_lookup_block(struct nlm_file *file, struct nlm_lock *lock)
 	return NULL;
 }
 
-static inline int nlm_cookie_match(struct nlm_cookie *a, struct nlm_cookie *b)
+static int lockd_cookie_match(struct lockd_cookie *a, struct lockd_cookie *b)
 {
 	if (a->len != b->len)
 		return 0;
@@ -184,13 +184,13 @@ static inline int nlm_cookie_match(struct nlm_cookie *a, struct nlm_cookie *b)
  * Find a block with a given NLM cookie.
  */
 static inline struct nlm_block *
-nlmsvc_find_block(struct nlm_cookie *cookie)
+nlmsvc_find_block(struct lockd_cookie *cookie)
 {
 	struct nlm_block *block;
 
 	spin_lock(&nlm_blocked_lock);
 	list_for_each_entry(block, &nlm_blocked, b_list) {
-		if (nlm_cookie_match(&block->b_call->a_args.cookie,cookie))
+		if (lockd_cookie_match(&block->b_call->a_args.cookie, cookie))
 			goto found;
 	}
 	spin_unlock(&nlm_blocked_lock);
@@ -222,7 +222,7 @@ nlmsvc_find_block(struct nlm_cookie *cookie)
 static struct nlm_block *
 nlmsvc_create_block(struct svc_rqst *rqstp, struct nlm_host *host,
 		    struct nlm_file *file, struct nlm_lock *lock,
-		    struct nlm_cookie *cookie)
+		    struct lockd_cookie *cookie)
 {
 	struct nlm_block	*block;
 	struct nlm_rqst		*call = NULL;
@@ -477,7 +477,7 @@ nlmsvc_defer_lock_rqst(struct svc_rqst *rqstp, struct nlm_block *block)
 __be32
 nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 	    struct nlm_host *host, struct nlm_lock *lock, int wait,
-	    struct nlm_cookie *cookie, int reclaim)
+	    struct lockd_cookie *cookie, int reclaim)
 {
 	struct inode		*inode __maybe_unused = nlmsvc_file_inode(file);
 	struct nlm_block	*block = NULL;
@@ -982,7 +982,7 @@ static const struct rpc_call_ops nlmsvc_grant_ops = {
  * block.
  */
 void
-nlmsvc_grant_reply(struct nlm_cookie *cookie, __be32 status)
+nlmsvc_grant_reply(struct lockd_cookie *cookie, __be32 status)
 {
 	struct nlm_block	*block;
 	struct file_lock	*fl;
diff --git a/fs/lockd/svcxdr.h b/fs/lockd/svcxdr.h
index 4f1a451da5ba..911b5fd707b1 100644
--- a/fs/lockd/svcxdr.h
+++ b/fs/lockd/svcxdr.h
@@ -70,7 +70,7 @@ svcxdr_decode_string(struct xdr_stream *xdr, char **data, unsigned int *data_len
  * specially.
  */
 static inline bool
-svcxdr_decode_cookie(struct xdr_stream *xdr, struct nlm_cookie *cookie)
+svcxdr_decode_cookie(struct xdr_stream *xdr, struct lockd_cookie *cookie)
 {
 	__be32 *p;
 	u32 len;
@@ -98,7 +98,7 @@ svcxdr_decode_cookie(struct xdr_stream *xdr, struct nlm_cookie *cookie)
 }
 
 static inline bool
-svcxdr_encode_cookie(struct xdr_stream *xdr, const struct nlm_cookie *cookie)
+svcxdr_encode_cookie(struct xdr_stream *xdr, const struct lockd_cookie *cookie)
 {
 	__be32 *p;
 
diff --git a/fs/lockd/xdr.h b/fs/lockd/xdr.h
index 3c60817c4349..c7e0518862d7 100644
--- a/fs/lockd/xdr.h
+++ b/fs/lockd/xdr.h
@@ -49,8 +49,7 @@ struct nlm_lock {
  *	32 bytes.
  */
 
-struct nlm_cookie
-{
+struct lockd_cookie {
 	unsigned char data[NLM_MAXCOOKIELEN];
 	unsigned int len;
 };
@@ -59,7 +58,7 @@ struct nlm_cookie
  * Generic lockd arguments for all but sm_notify
  */
 struct nlm_args {
-	struct nlm_cookie	cookie;
+	struct lockd_cookie	cookie;
 	struct nlm_lock		lock;
 	u32			block;
 	u32			reclaim;
@@ -73,7 +72,7 @@ struct nlm_args {
  * Generic lockd result
  */
 struct nlm_res {
-	struct nlm_cookie	cookie;
+	struct lockd_cookie	cookie;
 	__be32			status;
 	struct nlm_lock		lock;
 };

-- 
2.54.0


