Return-Path: <linux-nfs+bounces-13817-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FFEB2F652
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 13:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 731B6AC29BE
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 11:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0F730E853;
	Thu, 21 Aug 2025 11:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LC4zSkM1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D26130E849
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 11:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774939; cv=none; b=i9/raOzrOgtDw5Wn2j7GcTF5BZ0QWrNL87d9NBqaWsUpRWiOsdqNJuV0l4UdxBBMSwZXPWYrF3CUbWq8cDXZiXC4FQdpQQzA0/ZccbwfRSxbeXchN8zW/lUkCf1Fh5cNBGH5nADU4N7KAerjs07ftWjBVwmP4qGeunll3clkZ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774939; c=relaxed/simple;
	bh=1JdBzv2RLX0x0GZCj/LY/ehThMMubKQgWW85FWGxydA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqyrSWgPf+m5NpX9r5LeHvkCQPEouU6ZuyQS9avTjMDcmWGNG0biNaiPAa9M7ZivqkkOLy8UNrwq2g2xUBVVbe/fGIdjbJhjXQ8kE27DgXn6XZRfqTi/rUNPZslU2vVEUdqa+F/rGNNhbZk6/hTKNcGNFLZJbUGWXnl0SQe2w84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LC4zSkM1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755774934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZcwebYsDwakXI9lM/Owj1Hc1XrR2pAJKhTuQdxhMEVM=;
	b=LC4zSkM19+3Wg+2Hm7cfSgfVTPs62MgxN8wqKgmWJbWXY8VEc58BlpsDLLkARcZN0rncRn
	lM8TSFmOWZU0cwhG00cOiXwRNpHsPFCen5OwjoA+7ie8ZKHp3Cz8zo6zl4n4ZzckNVyQR0
	oKFqAxHcl62Ka3eH4A8A9ggr3E5yjMY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-PJsf5kIvN3-lK8x1Y3B92g-1; Thu,
 21 Aug 2025 07:15:30 -0400
X-MC-Unique: PJsf5kIvN3-lK8x1Y3B92g-1
X-Mimecast-MFC-AGG-ID: PJsf5kIvN3-lK8x1Y3B92g_1755774929
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BDED61956056;
	Thu, 21 Aug 2025 11:15:29 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.22.80.72])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D33AE1977692;
	Thu, 21 Aug 2025 11:15:28 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 02/12] Convert old-style function definitions into modern-style definitions
Date: Thu, 21 Aug 2025 07:15:13 -0400
Message-ID: <20250821111524.1379577-3-steved@redhat.com>
In-Reply-To: <20250821111524.1379577-1-steved@redhat.com>
References: <20250821111524.1379577-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

With newer compilers (gcc 15.1.1) -Wold-style-definition
flag is set by default which causes warnings for
most of the functions in these files.

    warning: old-style function definition [-Wold-style-definition]

The warnings are remove by converting the old-style
function definitions into modern-style definitions

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 src/svc.c           | 107 +++++++++++++++++++-----------------------
 src/svc_auth.c      |  14 +++---
 src/svc_auth_unix.c |  12 ++---
 src/svc_dg.c        |  75 ++++++++++++++----------------
 src/svc_generic.c   |  32 ++++++-------
 src/svc_raw.c       |  46 +++++++++---------
 src/svc_simple.c    |  19 ++++----
 src/svc_vc.c        | 111 +++++++++++++++++++++-----------------------
 8 files changed, 197 insertions(+), 219 deletions(-)

diff --git a/src/svc.c b/src/svc.c
index 9b932a5..944afd5 100644
--- a/src/svc.c
+++ b/src/svc.c
@@ -88,8 +88,7 @@ static void __xprt_do_unregister (SVCXPRT * xprt, bool_t dolock);
  * Activate a transport handle.
  */
 void
-xprt_register (xprt)
-     SVCXPRT *xprt;
+xprt_register (SVCXPRT *xprt)
 {
   int sock;
 
@@ -158,9 +157,9 @@ __xprt_unregister_unlocked (SVCXPRT * xprt)
  * De-activate a transport handle.
  */
 static void
-__xprt_do_unregister (xprt, dolock)
-     SVCXPRT *xprt;
-     bool_t dolock;
+__xprt_do_unregister (
+     SVCXPRT *xprt,
+     bool_t dolock)
 {
   int sock;
 
@@ -215,12 +214,12 @@ svc_open_fds()
  * program number comes in.
  */
 bool_t
-svc_reg (xprt, prog, vers, dispatch, nconf)
-     SVCXPRT *xprt;
-     const rpcprog_t prog;
-     const rpcvers_t vers;
-     void (*dispatch) (struct svc_req *, SVCXPRT *);
-     const struct netconfig *nconf;
+svc_reg (
+     SVCXPRT *xprt,
+     const rpcprog_t prog,
+     const rpcvers_t vers,
+     void (*dispatch) (struct svc_req *, SVCXPRT *),
+     const struct netconfig *nconf)
 {
   bool_t dummy;
   struct svc_callout *prev;
@@ -297,9 +296,9 @@ rpcb_it:
  * Remove a service program from the callout list.
  */
 void
-svc_unreg (prog, vers)
-     const rpcprog_t prog;
-     const rpcvers_t vers;
+svc_unreg (
+     const rpcprog_t prog,
+     const rpcvers_t vers)
 {
   struct svc_callout *prev;
   struct svc_callout *s;
@@ -334,12 +333,12 @@ svc_unreg (prog, vers)
  * program number comes in.
  */
 bool_t
-svc_register (xprt, prog, vers, dispatch, protocol)
-     SVCXPRT *xprt;
-     u_long prog;
-     u_long vers;
-     void (*dispatch) (struct svc_req *, SVCXPRT *);
-     int protocol;
+svc_register (
+     SVCXPRT *xprt,
+     u_long prog,
+     u_long vers,
+     void (*dispatch) (struct svc_req *, SVCXPRT *),
+     int protocol)
 {
   struct svc_callout *prev;
   struct svc_callout *s;
@@ -377,9 +376,9 @@ pmap_it:
  * Remove a service program from the callout list.
  */
 void
-svc_unregister (prog, vers)
-     u_long prog;
-     u_long vers;
+svc_unregister (
+     u_long prog,
+     u_long vers)
 {
   struct svc_callout *prev;
   struct svc_callout *s;
@@ -407,11 +406,11 @@ svc_unregister (prog, vers)
  * struct.
  */
 static struct svc_callout *
-svc_find (prog, vers, prev, netid)
-     rpcprog_t prog;
-     rpcvers_t vers;
-     struct svc_callout **prev;
-     char *netid;
+svc_find (
+     rpcprog_t prog,
+     rpcvers_t vers,
+     struct svc_callout **prev,
+     char *netid)
 {
   struct svc_callout *s, *p;
 
@@ -436,10 +435,10 @@ svc_find (prog, vers, prev, netid)
  * Send a reply to an rpc request
  */
 bool_t
-svc_sendreply (xprt, xdr_results, xdr_location)
-     SVCXPRT *xprt;
-     xdrproc_t xdr_results;
-     void *xdr_location;
+svc_sendreply (
+     SVCXPRT *xprt,
+     xdrproc_t xdr_results,
+     void *xdr_location)
 {
   struct rpc_msg rply;
 
@@ -458,8 +457,7 @@ svc_sendreply (xprt, xdr_results, xdr_location)
  * No procedure error reply
  */
 void
-svcerr_noproc (xprt)
-     SVCXPRT *xprt;
+svcerr_noproc (SVCXPRT *xprt)
 {
   struct rpc_msg rply;
 
@@ -476,8 +474,7 @@ svcerr_noproc (xprt)
  * Can't decode args error reply
  */
 void
-svcerr_decode (xprt)
-     SVCXPRT *xprt;
+svcerr_decode (SVCXPRT *xprt)
 {
   struct rpc_msg rply;
 
@@ -494,8 +491,7 @@ svcerr_decode (xprt)
  * Some system error
  */
 void
-svcerr_systemerr (xprt)
-     SVCXPRT *xprt;
+svcerr_systemerr (SVCXPRT *xprt)
 {
   struct rpc_msg rply;
 
@@ -548,9 +544,9 @@ __svc_versquiet_get (xprt)
  * Authentication error reply
  */
 void
-svcerr_auth (xprt, why)
-     SVCXPRT *xprt;
-     enum auth_stat why;
+svcerr_auth (
+     SVCXPRT *xprt,
+     enum auth_stat why)
 {
   struct rpc_msg rply;
 
@@ -567,8 +563,7 @@ svcerr_auth (xprt, why)
  * Auth too weak error reply
  */
 void
-svcerr_weakauth (xprt)
-     SVCXPRT *xprt;
+svcerr_weakauth (SVCXPRT *xprt)
 {
 
   assert (xprt != NULL);
@@ -580,8 +575,7 @@ svcerr_weakauth (xprt)
  * Program unavailable error reply
  */
 void
-svcerr_noprog (xprt)
-     SVCXPRT *xprt;
+svcerr_noprog (SVCXPRT *xprt)
 {
   struct rpc_msg rply;
 
@@ -598,10 +592,10 @@ svcerr_noprog (xprt)
  * Program version mismatch error reply
  */
 void
-svcerr_progvers (xprt, low_vers, high_vers)
-     SVCXPRT *xprt;
-     rpcvers_t low_vers;
-     rpcvers_t high_vers;
+svcerr_progvers (
+     SVCXPRT *xprt,
+     rpcvers_t low_vers,
+     rpcvers_t high_vers)
 {
   struct rpc_msg rply;
 
@@ -635,8 +629,7 @@ svcerr_progvers (xprt, low_vers, high_vers)
  */
 
 void
-svc_getreq (rdfds)
-     int rdfds;
+svc_getreq (int rdfds)
 {
   fd_set readfds;
 
@@ -646,8 +639,7 @@ svc_getreq (rdfds)
 }
 
 void
-svc_getreqset (readfds)
-     fd_set *readfds;
+svc_getreqset (fd_set *readfds)
 {
   int bit, fd;
   fd_mask mask, *maskp;
@@ -670,8 +662,7 @@ svc_getreqset (readfds)
 }
 
 void
-svc_getreq_common (fd)
-     int fd;
+svc_getreq_common (int fd)
 {
   SVCXPRT *xprt;
   struct svc_req r;
@@ -772,9 +763,9 @@ svc_getreq_common (fd)
 
 
 void
-svc_getreq_poll (pfdp, pollretval)
-     struct pollfd *pfdp;
-     int pollretval;
+svc_getreq_poll (
+     struct pollfd *pfdp,
+     int pollretval)
 {
   int fds_found, i;
 
diff --git a/src/svc_auth.c b/src/svc_auth.c
index 789d6af..1b9d5e8 100644
--- a/src/svc_auth.c
+++ b/src/svc_auth.c
@@ -88,10 +88,10 @@ extern enum auth_stat _svcauth_des(struct svc_req *rqst, struct rpc_msg *msg);
  * invalid.
  */
 enum auth_stat
-_gss_authenticate(rqst, msg, no_dispatch)
-	struct svc_req *rqst;
-	struct rpc_msg *msg;
-	bool_t *no_dispatch;
+_gss_authenticate(
+	struct svc_req *rqst,
+	struct rpc_msg *msg,
+	bool_t *no_dispatch)
 {
 	int cred_flavor;
 	struct authsvc *asp;
@@ -171,9 +171,9 @@ _authenticate(struct svc_req *rqst, struct rpc_msg *msg)
  */
 
 int
-svc_auth_reg(cred_flavor, handler)
-	int cred_flavor;
-	enum auth_stat (*handler)(struct svc_req *, struct rpc_msg *);
+svc_auth_reg(
+	int cred_flavor,
+	enum auth_stat (*handler)(struct svc_req *, struct rpc_msg *))
 {
 	struct authsvc *asp;
 	extern mutex_t authsvc_lock;
diff --git a/src/svc_auth_unix.c b/src/svc_auth_unix.c
index 8f992a4..f3e9813 100644
--- a/src/svc_auth_unix.c
+++ b/src/svc_auth_unix.c
@@ -49,9 +49,9 @@ extern SVCAUTH svc_auth_none;
  * Unix longhand authenticator
  */
 enum auth_stat
-_svcauth_unix(rqst, msg)
-	struct svc_req *rqst;
-	struct rpc_msg *msg;
+_svcauth_unix(
+	struct svc_req *rqst,
+	struct rpc_msg *msg)
 {
 	enum auth_stat stat;
 	XDR xdrs;
@@ -140,9 +140,9 @@ done:
  */
 /*ARGSUSED*/
 enum auth_stat 
-_svcauth_short(rqst, msg)
-	struct svc_req *rqst;
-	struct rpc_msg *msg;
+_svcauth_short(
+	struct svc_req *rqst,
+	struct rpc_msg *msg)
 {
 	return (AUTH_REJECTEDCRED);
 }
diff --git a/src/svc_dg.c b/src/svc_dg.c
index 7677cb3..3d42b6a 100644
--- a/src/svc_dg.c
+++ b/src/svc_dg.c
@@ -93,10 +93,10 @@ static const char svc_dg_err2[] = " transport does not support data transfer";
 static const char __no_mem_str[] = "out of memory";
 
 SVCXPRT *
-svc_dg_create(fd, sendsize, recvsize)
-	int fd;
-	u_int sendsize;
-	u_int recvsize;
+svc_dg_create(
+	int fd,
+	u_int sendsize,
+	u_int recvsize)
 {
 	SVCXPRT *xprt;
 	SVCXPRT_EXT *ext = NULL;
@@ -169,16 +169,15 @@ freedata:
 
 /*ARGSUSED*/
 static enum xprt_stat
-svc_dg_stat(xprt)
-	SVCXPRT *xprt;
+svc_dg_stat(SVCXPRT *xprt)
 {
 	return (XPRT_IDLE);
 }
 
 static bool_t
-svc_dg_recv(xprt, msg)
-	SVCXPRT *xprt;
-	struct rpc_msg *msg;
+svc_dg_recv(
+	SVCXPRT *xprt,
+	struct rpc_msg *msg)
 {
 	struct svc_dg_data *su = su_data(xprt);
 	XDR *xdrs = &(su->su_xdrs);
@@ -234,9 +233,9 @@ again:
 }
 
 static bool_t
-svc_dg_reply(xprt, msg)
-	SVCXPRT *xprt;
-	struct rpc_msg *msg;
+svc_dg_reply(
+	SVCXPRT *xprt,
+	struct rpc_msg *msg)
 {
 	struct svc_dg_data *su = su_data(xprt);
 	XDR *xdrs = &(su->su_xdrs);
@@ -286,10 +285,10 @@ svc_dg_reply(xprt, msg)
 }
 
 static bool_t
-svc_dg_getargs(xprt, xdr_args, args_ptr)
-	SVCXPRT *xprt;
-	xdrproc_t xdr_args;
-	void *args_ptr;
+svc_dg_getargs(
+	SVCXPRT *xprt,
+	xdrproc_t xdr_args,
+	void *args_ptr)
 {
 	if (!SVCAUTH_UNWRAP(&SVC_XP_AUTH(xprt),
 			    &(su_data(xprt)->su_xdrs),
@@ -300,10 +299,10 @@ svc_dg_getargs(xprt, xdr_args, args_ptr)
 }
 
 static bool_t
-svc_dg_freeargs(xprt, xdr_args, args_ptr)
-	SVCXPRT *xprt;
-	xdrproc_t xdr_args;
-	void *args_ptr;
+svc_dg_freeargs(
+	SVCXPRT *xprt,
+	xdrproc_t xdr_args,
+	void *args_ptr)
 {
 	XDR *xdrs = &(su_data(xprt)->su_xdrs);
 
@@ -312,8 +311,7 @@ svc_dg_freeargs(xprt, xdr_args, args_ptr)
 }
 
 static void
-svc_dg_destroy(xprt)
-	SVCXPRT *xprt;
+svc_dg_destroy(SVCXPRT *xprt)
 {
 	SVCXPRT_EXT *ext = SVCEXT(xprt);
 	struct svc_dg_data *su = su_data(xprt);
@@ -338,17 +336,16 @@ svc_dg_destroy(xprt)
 
 static bool_t
 /*ARGSUSED*/
-svc_dg_control(xprt, rq, in)
-	SVCXPRT *xprt;
-	const u_int	rq;
-	void		*in;
+svc_dg_control(
+	SVCXPRT *xprt,
+	const u_int	rq,
+	void		*in)
 {
 	return (FALSE);
 }
 
 static void
-svc_dg_ops(xprt)
-	SVCXPRT *xprt;
+svc_dg_ops(SVCXPRT *xprt)
 {
 	static struct xp_ops ops;
 	static struct xp_ops2 ops2;
@@ -449,9 +446,9 @@ static const char alloc_err[] = "could not allocate cache ";
 static const char enable_err[] = "cache already enabled";
 
 int
-svc_dg_enablecache(transp, size)
-	SVCXPRT *transp;
-	u_int size;
+svc_dg_enablecache(
+	SVCXPRT *transp,
+	u_int size)
 {
 	struct svc_dg_data *su = su_data(transp);
 	struct cl_cache *uc;
@@ -506,9 +503,9 @@ static const char cache_set_err2[] = "victim alloc failed";
 static const char cache_set_err3[] = "could not allocate new rpc buffer";
 
 static void
-cache_set(xprt, replylen)
-	SVCXPRT *xprt;
-	size_t replylen;
+cache_set(
+	SVCXPRT *xprt,
+	size_t replylen)
 {
 	cache_ptr victim;
 	cache_ptr *vicp;
@@ -594,11 +591,11 @@ cache_set(xprt, replylen)
  * return 1 if found, 0 if not found and set the stage for cache_set()
  */
 static int
-cache_get(xprt, msg, replyp, replylenp)
-	SVCXPRT *xprt;
-	struct rpc_msg *msg;
-	char **replyp;
-	size_t *replylenp;
+cache_get(
+	SVCXPRT *xprt,
+	struct rpc_msg *msg,
+	char **replyp,
+	size_t *replylenp)
 {
 	u_int loc;
 	cache_ptr ent;
diff --git a/src/svc_generic.c b/src/svc_generic.c
index 20abaa2..0eaa6fe 100644
--- a/src/svc_generic.c
+++ b/src/svc_generic.c
@@ -65,11 +65,11 @@ extern int __binddynport(int fd);
  * created earlier instead of creating a new handle every time.
  */
 int
-svc_create(dispatch, prognum, versnum, nettype)
-	void (*dispatch)(struct svc_req *, SVCXPRT *);
-	rpcprog_t prognum;		/* Program number */
-	rpcvers_t versnum;		/* Version number */
-	const char *nettype;		/* Networktype token */
+svc_create(
+	void (*dispatch)(struct svc_req *, SVCXPRT *),
+	rpcprog_t prognum,		/* Program number */
+	rpcvers_t versnum,		/* Version number */
+	const char *nettype)		/* Networktype token */
 {
 	struct xlist {
 		SVCXPRT *xprt;		/* Server handle */
@@ -138,11 +138,11 @@ svc_create(dispatch, prognum, versnum, nettype)
  * with the rpcbind. It calls svc_tli_create();
  */
 SVCXPRT *
-svc_tp_create(dispatch, prognum, versnum, nconf)
-	void (*dispatch)(struct svc_req *, SVCXPRT *);
-	rpcprog_t prognum;		/* Program number */
-	rpcvers_t versnum;		/* Version number */
-	const struct netconfig *nconf; /* Netconfig structure for the network */
+svc_tp_create(
+	void (*dispatch)(struct svc_req *, SVCXPRT *),
+	rpcprog_t prognum,		/* Program number */
+	rpcvers_t versnum,		/* Version number */
+	const struct netconfig *nconf) /* Netconfig structure for the network */
 {
 	SVCXPRT *xprt;
 
@@ -179,12 +179,12 @@ svc_tp_create(dispatch, prognum, versnum, nconf)
  * If sendsz or recvsz are zero, their default values are chosen.
  */
 SVCXPRT *
-svc_tli_create(fd, nconf, bindaddr, sendsz, recvsz)
-	int fd;				/* Connection end point */
-	const struct netconfig *nconf;	/* Netconfig struct for nettoken */
-	const struct t_bind *bindaddr;	/* Local bind address */
-	u_int sendsz;			/* Max sendsize */
-	u_int recvsz;			/* Max recvsize */
+svc_tli_create(
+	int fd,				/* Connection end point */
+	const struct netconfig *nconf,	/* Netconfig struct for nettoken */
+	const struct t_bind *bindaddr,	/* Local bind address */
+	u_int sendsz,			/* Max sendsize */
+	u_int recvsz)			/* Max recvsize */
 {
 	SVCXPRT *xprt = NULL;		/* service handle */
 	bool_t madefd = FALSE;		/* whether fd opened here  */
diff --git a/src/svc_raw.c b/src/svc_raw.c
index 1f0bf97..293d3ba 100644
--- a/src/svc_raw.c
+++ b/src/svc_raw.c
@@ -115,17 +115,17 @@ svc_raw_create()
 
 /*ARGSUSED*/
 static enum xprt_stat
-svc_raw_stat(xprt)
-SVCXPRT *xprt; /* args needed to satisfy ANSI-C typechecking */
+svc_raw_stat(
+SVCXPRT *xprt) /* args needed to satisfy ANSI-C typechecking */
 {
 	return (XPRT_IDLE);
 }
 
 /*ARGSUSED*/
 static bool_t
-svc_raw_recv(xprt, msg)
-	SVCXPRT *xprt;
-	struct rpc_msg *msg;
+svc_raw_recv(
+	SVCXPRT *xprt,
+	struct rpc_msg *msg)
 {
 	struct svc_raw_private *srp;
 	XDR *xdrs;
@@ -149,9 +149,9 @@ svc_raw_recv(xprt, msg)
 
 /*ARGSUSED*/
 static bool_t
-svc_raw_reply(xprt, msg)
-	SVCXPRT *xprt;
-	struct rpc_msg *msg;
+svc_raw_reply(
+	SVCXPRT *xprt,
+	struct rpc_msg *msg)
 {
 	struct svc_raw_private *srp;
 	XDR *xdrs;
@@ -176,10 +176,10 @@ svc_raw_reply(xprt, msg)
 
 /*ARGSUSED*/
 static bool_t
-svc_raw_getargs(xprt, xdr_args, args_ptr)
-	SVCXPRT *xprt;
-	xdrproc_t xdr_args;
-	void *args_ptr;
+svc_raw_getargs(
+	SVCXPRT *xprt,
+	xdrproc_t xdr_args,
+	void *args_ptr)
 {
 	struct svc_raw_private *srp;
 
@@ -195,10 +195,10 @@ svc_raw_getargs(xprt, xdr_args, args_ptr)
 
 /*ARGSUSED*/
 static bool_t
-svc_raw_freeargs(xprt, xdr_args, args_ptr)
-	SVCXPRT *xprt;
-	xdrproc_t xdr_args;
-	void *args_ptr;
+svc_raw_freeargs(
+	SVCXPRT *xprt,
+	xdrproc_t xdr_args,
+	void *args_ptr)
 {
 	struct svc_raw_private *srp;
 	XDR *xdrs;
@@ -218,24 +218,22 @@ svc_raw_freeargs(xprt, xdr_args, args_ptr)
 
 /*ARGSUSED*/
 static void
-svc_raw_destroy(xprt)
-SVCXPRT *xprt;
+svc_raw_destroy(SVCXPRT *xprt)
 {
 }
 
 /*ARGSUSED*/
 static bool_t
-svc_raw_control(xprt, rq, in)
-	SVCXPRT *xprt;
-	const u_int	rq;
-	void		*in;
+svc_raw_control(
+	SVCXPRT *xprt,
+	const u_int	rq,
+	void		*in)
 {
 	return (FALSE);
 }
 
 static void
-svc_raw_ops(xprt)
-	SVCXPRT *xprt;
+svc_raw_ops(SVCXPRT *xprt)
 {
 	static struct xp_ops ops;
 	static struct xp_ops2 ops2;
diff --git a/src/svc_simple.c b/src/svc_simple.c
index c32fe0a..e2ef276 100644
--- a/src/svc_simple.c
+++ b/src/svc_simple.c
@@ -87,13 +87,14 @@ static const char __no_mem_str[] = "out of memory";
  */
 
 int
-rpc_reg(prognum, versnum, procnum, progname, inproc, outproc, nettype)
-	rpcprog_t prognum;			/* program number */
-	rpcvers_t versnum;			/* version number */
-	rpcproc_t procnum;			/* procedure number */
-	char *(*progname)(char *); /* Server routine */
-	xdrproc_t inproc, outproc;	/* in/out XDR procedures */
-	char *nettype;			/* nettype */
+rpc_reg(
+	rpcprog_t prognum,			/* program number */
+	rpcvers_t versnum,			/* version number */
+	rpcproc_t procnum,			/* procedure number */
+	char *(*progname)(char *), /* Server routine */
+	xdrproc_t inproc, 		/* in XDR procedures */
+	xdrproc_t outproc,		/* out XDR procedures */
+	char *nettype)			/* nettype */
 {
 	struct netconfig *nconf;
 	int done = FALSE;
@@ -231,9 +232,7 @@ rpc_reg(prognum, versnum, procnum, progname, inproc, outproc, nettype)
  */
 
 static void
-universal(rqstp, transp)
-	struct svc_req *rqstp;
-	SVCXPRT *transp;
+universal(struct svc_req *rqstp, SVCXPRT *transp)
 {
 	rpcprog_t prog;
 	rpcvers_t vers;
diff --git a/src/svc_vc.c b/src/svc_vc.c
index ac6cdd1..ddea947 100644
--- a/src/svc_vc.c
+++ b/src/svc_vc.c
@@ -145,10 +145,10 @@ __xprt_set_raddr(SVCXPRT *xprt, const struct sockaddr_storage *ss)
  * 0 => use the system default.
  */
 SVCXPRT *
-svc_vc_create(fd, sendsize, recvsize)
-	int fd;
-	u_int sendsize;
-	u_int recvsize;
+svc_vc_create(
+	int fd,
+	u_int sendsize,
+	u_int recvsize)
 {
 	SVCXPRT *xprt = NULL;
 	SVCXPRT_EXT *ext = NULL;
@@ -216,10 +216,10 @@ cleanup_svc_vc_create:
  * descriptor as its first input.
  */
 SVCXPRT *
-svc_fd_create(fd, sendsize, recvsize)
-	int fd;
-	u_int sendsize;
-	u_int recvsize;
+svc_fd_create(
+	int fd,
+	u_int sendsize,
+	u_int recvsize)
 {
 	struct sockaddr_storage ss;
 	socklen_t slen;
@@ -271,10 +271,10 @@ freedata:
 }
 
 static SVCXPRT *
-makefd_xprt(fd, sendsize, recvsize)
-	int fd;
-	u_int sendsize;
-	u_int recvsize;
+makefd_xprt(
+	int fd,
+	u_int sendsize,
+	u_int recvsize)
 {
 	SVCXPRT *xprt;
 	SVCXPRT_EXT *ext;
@@ -326,9 +326,9 @@ done:
 
 /*ARGSUSED*/
 static bool_t
-rendezvous_request(xprt, msg)
-	SVCXPRT *xprt;
-	struct rpc_msg *msg;
+rendezvous_request(
+	SVCXPRT *xprt,
+	struct rpc_msg *msg)
 {
 	int sock, flags, nfds, cnt;
 	struct cf_rendezvous *r;
@@ -405,16 +405,14 @@ again:
 
 /*ARGSUSED*/
 static enum xprt_stat
-rendezvous_stat(xprt)
-	SVCXPRT *xprt;
+rendezvous_stat(SVCXPRT *xprt)
 {
 
 	return (XPRT_IDLE);
 }
 
 static void
-svc_vc_destroy(xprt)
-	SVCXPRT *xprt;
+svc_vc_destroy(SVCXPRT *xprt)
 {
 	assert(xprt != NULL);
 	
@@ -423,14 +421,12 @@ svc_vc_destroy(xprt)
 }
 
 static bool_t
-__svc_rendezvous_socket(xprt)
-	SVCXPRT *xprt;
+__svc_rendezvous_socket(SVCXPRT *xprt)
 {
 	return (xprt->xp_ops->xp_recv == rendezvous_request);
 }
 static void
-__svc_vc_dodestroy(xprt)
-	SVCXPRT *xprt;
+__svc_vc_dodestroy(SVCXPRT *xprt)
 {
 	SVCXPRT_EXT *ext = SVCEXT(xprt);
 	struct cf_conn *cd;
@@ -465,19 +461,19 @@ __svc_vc_dodestroy(xprt)
 
 /*ARGSUSED*/
 static bool_t
-svc_vc_control(xprt, rq, in)
-	SVCXPRT *xprt;
-	const u_int rq;
-	void *in;
+svc_vc_control(
+	SVCXPRT *xprt,
+	const u_int rq,
+	void *in)
 {
 	return (FALSE);
 }
 
 static bool_t
-svc_vc_rendezvous_control(xprt, rq, in)
-	SVCXPRT *xprt;
-	const u_int rq;
-	void *in;
+svc_vc_rendezvous_control(
+	SVCXPRT *xprt,
+	const u_int rq,
+	void *in)
 {
 	struct cf_rendezvous *cfp;
 
@@ -505,10 +501,10 @@ svc_vc_rendezvous_control(xprt, rq, in)
  * fatal for the connection.
  */
 static int
-read_vc(xprtp, buf, len)
-	void *xprtp;
-	void *buf;
-	int len;
+read_vc(
+	void *xprtp,
+	void *buf,
+	int len)
 {
 	SVCXPRT *xprt;
 	int sock;
@@ -573,10 +569,10 @@ fatal_err:
  * Any error is fatal and the connection is closed.
  */
 static int
-write_vc(xprtp, buf, len)
-	void *xprtp;
-	void *buf;
-	int len;
+write_vc(
+	void *xprtp,
+	void *buf,
+	int len)
 {
 	SVCXPRT *xprt;
 	int i, cnt;
@@ -618,8 +614,7 @@ write_vc(xprtp, buf, len)
 }
 
 static enum xprt_stat
-svc_vc_stat(xprt)
-	SVCXPRT *xprt;
+svc_vc_stat(SVCXPRT *xprt)
 {
 	struct cf_conn *cd;
 
@@ -635,9 +630,9 @@ svc_vc_stat(xprt)
 }
 
 static bool_t
-svc_vc_recv(xprt, msg)
-	SVCXPRT *xprt;
-	struct rpc_msg *msg;
+svc_vc_recv(
+	SVCXPRT *xprt,
+	struct rpc_msg *msg)
 {
 	struct cf_conn *cd;
 	XDR *xdrs;
@@ -668,10 +663,10 @@ svc_vc_recv(xprt, msg)
 }
 
 static bool_t
-svc_vc_getargs(xprt, xdr_args, args_ptr)
-	SVCXPRT *xprt;
-	xdrproc_t xdr_args;
-	void *args_ptr;
+svc_vc_getargs(
+	SVCXPRT *xprt,
+	xdrproc_t xdr_args,
+	void *args_ptr)
 {
 
 	assert(xprt != NULL);
@@ -686,10 +681,10 @@ svc_vc_getargs(xprt, xdr_args, args_ptr)
 }
 
 static bool_t
-svc_vc_freeargs(xprt, xdr_args, args_ptr)
-	SVCXPRT *xprt;
-	xdrproc_t xdr_args;
-	void *args_ptr;
+svc_vc_freeargs(
+	SVCXPRT *xprt,
+	xdrproc_t xdr_args,
+	void *args_ptr)
 {
 	XDR *xdrs;
 
@@ -703,9 +698,9 @@ svc_vc_freeargs(xprt, xdr_args, args_ptr)
 }
 
 static bool_t
-svc_vc_reply(xprt, msg)
-	SVCXPRT *xprt;
-	struct rpc_msg *msg;
+svc_vc_reply(
+	SVCXPRT *xprt,
+	struct rpc_msg *msg)
 {
 	struct cf_conn *cd;
 	XDR *xdrs;
@@ -746,8 +741,7 @@ svc_vc_reply(xprt, msg)
 }
 
 static void
-svc_vc_ops(xprt)
-	SVCXPRT *xprt;
+svc_vc_ops(SVCXPRT *xprt)
 {
 	static struct xp_ops ops;
 	static struct xp_ops2 ops2;
@@ -771,8 +765,7 @@ svc_vc_ops(xprt)
 }
 
 static void
-svc_vc_rendezvous_ops(xprt)
-	SVCXPRT *xprt;
+svc_vc_rendezvous_ops(SVCXPRT *xprt)
 {
 	static struct xp_ops ops;
 	static struct xp_ops2 ops2;
-- 
2.50.1


