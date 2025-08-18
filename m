Return-Path: <linux-nfs+bounces-13732-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF59BB2AC5F
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 17:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E12A4E13A0
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 15:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A90F24BBFD;
	Mon, 18 Aug 2025 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1Eq3VTX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3238F223337
	for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529729; cv=none; b=j+6qW1W4yCfsA40RgZUMi5KFS/LMiblRhNAhUygETGWzDF3kEbt/pwK314O8WPOzpWihcZzvOBZBv7Q3jAEEcEZhEmLPkvs1ZpnhRNOhCJoYc/kzssPL74Tx1t4dZx6Nt5/s6ri71CjW0sIBx95oUmA95xrdcnKQeTBOWC2WJBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529729; c=relaxed/simple;
	bh=U5OhrQUsXfIkGUp/t7kOzpAV+c6HIQT+sRQzzkp1qsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZncidrCUQlU8shIP/5WAoGMW/bv7chy4YkDXzcBh3rSLnkeTpG+EMSehGRYbzUYeISiu9l/5vQessh3wRBHRwxFr5+sXT2TxVM9P7mfP4er/JMEnpyTHEdZcHIFSmXZLJKorY9lHJhv+6rtrr0GlWNcqpq9AgTR4cyLlV5D8ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L1Eq3VTX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755529726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uHytpWmfXBO8AIaPcan7uTzBOH59JhFv0vhwqjcntvc=;
	b=L1Eq3VTXiVNn//i4C+vpWnRiLAts3kxNckYQN1ENLCxyHxfkz7MGZ5OqNX+XEJG1TrbBwH
	6Ax1+F4T6Aqc38kJeogLRVxs8xtD0XPingbH7HXnzF6NWz96cKX+PqO5bvB8EB3A6B0S/L
	qwTmE1uvKxn3GusKOEFRTXVetuJwIGA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-xPo6No9bOZepcr5GefQZxQ-1; Mon,
 18 Aug 2025 11:08:44 -0400
X-MC-Unique: xPo6No9bOZepcr5GefQZxQ-1
X-Mimecast-MFC-AGG-ID: xPo6No9bOZepcr5GefQZxQ_1755529723
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D23031800294;
	Mon, 18 Aug 2025 15:08:43 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.22.64.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 08E7C30001A8;
	Mon, 18 Aug 2025 15:08:42 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 10/12] Convert old-style function definitions into modern-style definitions
Date: Mon, 18 Aug 2025 11:08:27 -0400
Message-ID: <20250818150829.1044948-11-steved@redhat.com>
In-Reply-To: <20250818150829.1044948-1-steved@redhat.com>
References: <20250818150829.1044948-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

With newer compilers (gcc 15.1.1) -Wold-style-definition
flag is set by default which causes warnings for
most of the functions in these files.

    warning: old-style function definition [-Wold-style-definition]

The warnings are remove by converting the old-style
function definitions into modern-style definitions

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 src/clnt_bcast.c  | 46 ++++++++++++++---------------
 src/clnt_dg.c     | 59 +++++++++++++++++--------------------
 src/clnt_perror.c | 23 +++++----------
 src/clnt_raw.c    | 46 +++++++++++++----------------
 src/clnt_simple.c | 19 ++++++------
 src/clnt_vc.c     | 75 ++++++++++++++++++++++-------------------------
 6 files changed, 121 insertions(+), 147 deletions(-)

diff --git a/src/clnt_bcast.c b/src/clnt_bcast.c
index 2ad6c89..1103b36 100644
--- a/src/clnt_bcast.c
+++ b/src/clnt_bcast.c
@@ -257,19 +257,18 @@ __ipv6v4_fixup(struct sockaddr_storage *ss, const char *uaddr)
 }
 
 enum clnt_stat
-rpc_broadcast_exp(prog, vers, proc, xargs, argsp, xresults, resultsp,
-	eachresult, inittime, waittime, nettype)
-	rpcprog_t	prog;		/* program number */
-	rpcvers_t	vers;		/* version number */
-	rpcproc_t	proc;		/* procedure number */
-	xdrproc_t	xargs;		/* xdr routine for args */
-	caddr_t		argsp;		/* pointer to args */
-	xdrproc_t	xresults;	/* xdr routine for results */
-	caddr_t		resultsp;	/* pointer to results */
-	resultproc_t	eachresult;	/* call with each result obtained */
-	int 		inittime;	/* how long to wait initially */
-	int 		waittime;	/* maximum time to wait */
-	const char		*nettype;	/* transport type */
+rpc_broadcast_exp(
+	rpcprog_t	prog,		/* program number */
+	rpcvers_t	vers,		/* version number */
+	rpcproc_t	proc,		/* procedure number */
+	xdrproc_t	xargs,		/* xdr routine for args */
+	caddr_t		argsp,		/* pointer to args */
+	xdrproc_t	xresults,	/* xdr routine for results */
+	caddr_t		resultsp,	/* pointer to results */
+	resultproc_t	eachresult,	/* call with each result obtained */
+	int 		inittime,	/* how long to wait initially */
+	int 		waittime,	/* maximum time to wait */
+	const char		*nettype)	/* transport type */
 {
 	enum clnt_stat	stat = RPC_SUCCESS; /* Return status */
 	XDR 		xdr_stream; /* XDR stream */
@@ -677,17 +676,16 @@ done_broad:
 
 
 enum clnt_stat
-rpc_broadcast(prog, vers, proc, xargs, argsp, xresults, resultsp,
-			eachresult, nettype)
-	rpcprog_t	prog;		/* program number */
-	rpcvers_t	vers;		/* version number */
-	rpcproc_t	proc;		/* procedure number */
-	xdrproc_t	xargs;		/* xdr routine for args */
-	caddr_t		argsp;		/* pointer to args */
-	xdrproc_t	xresults;	/* xdr routine for results */
-	caddr_t		resultsp;	/* pointer to results */
-	resultproc_t	eachresult;	/* call with each result obtained */
-	const char		*nettype;	/* transport type */
+rpc_broadcast(
+	rpcprog_t	prog,		/* program number */
+	rpcvers_t	vers,		/* version number */
+	rpcproc_t	proc,		/* procedure number */
+	xdrproc_t	xargs,		/* xdr routine for args */
+	caddr_t		argsp,		/* pointer to args */
+	xdrproc_t	xresults,	/* xdr routine for results */
+	caddr_t		resultsp,	/* pointer to results */
+	resultproc_t	eachresult,	/* call with each result obtained */
+	const char		*nettype)	/* transport type */
 {
 	enum clnt_stat	dummy;
 
diff --git a/src/clnt_dg.c b/src/clnt_dg.c
index 166af63..526a0b5 100644
--- a/src/clnt_dg.c
+++ b/src/clnt_dg.c
@@ -149,13 +149,13 @@ struct cu_data {
  * If svcaddr is NULL, returns NULL.
  */
 CLIENT *
-clnt_dg_create(fd, svcaddr, program, version, sendsz, recvsz)
-	int fd;				/* open file descriptor */
-	const struct netbuf *svcaddr;	/* servers address */
-	rpcprog_t program;		/* program number */
-	rpcvers_t version;		/* version number */
-	u_int sendsz;			/* buffer recv size */
-	u_int recvsz;			/* buffer send size */
+clnt_dg_create(
+	int fd,				/* open file descriptor */
+	const struct netbuf *svcaddr,	/* servers address */
+	rpcprog_t program,		/* program number */
+	rpcvers_t version,		/* version number */
+	u_int sendsz,			/* buffer recv size */
+	u_int recvsz)			/* buffer send size */
 {
 	CLIENT *cl = NULL;		/* client handle */
 	struct cu_data *cu = NULL;	/* private data */
@@ -282,14 +282,14 @@ err2:
 }
 
 static enum clnt_stat
-clnt_dg_call(cl, proc, xargs, argsp, xresults, resultsp, utimeout)
-	CLIENT	*cl;			/* client handle */
-	rpcproc_t	proc;		/* procedure number */
-	xdrproc_t	xargs;		/* xdr routine for args */
-	void		*argsp;		/* pointer to args */
-	xdrproc_t	xresults;	/* xdr routine for results */
-	void		*resultsp;	/* pointer to results */
-	struct timeval	utimeout;	/* seconds to wait before giving up */
+clnt_dg_call(
+	CLIENT	*cl,			/* client handle */
+	rpcproc_t	proc,		/* procedure number */
+	xdrproc_t	xargs,		/* xdr routine for args */
+	void		*argsp,		/* pointer to args */
+	xdrproc_t	xresults,	/* xdr routine for results */
+	void		*resultsp,	/* pointer to results */
+	struct timeval	utimeout)	/* seconds to wait before giving up */
 {
 	struct cu_data *cu = (struct cu_data *)cl->cl_private;
 	XDR *xdrs;
@@ -549,9 +549,7 @@ out:
 }
 
 static void
-clnt_dg_geterr(cl, errp)
-	CLIENT *cl;
-	struct rpc_err *errp;
+clnt_dg_geterr(CLIENT *cl, struct rpc_err *errp)
 {
 	struct cu_data *cu = (struct cu_data *)cl->cl_private;
 
@@ -559,10 +557,10 @@ clnt_dg_geterr(cl, errp)
 }
 
 static bool_t
-clnt_dg_freeres(cl, xdr_res, res_ptr)
-	CLIENT *cl;
-	xdrproc_t xdr_res;
-	void *res_ptr;
+clnt_dg_freeres(
+	CLIENT *cl,
+	xdrproc_t xdr_res,
+	void *res_ptr)
 {
 	struct cu_data *cu = (struct cu_data *)cl->cl_private;
 	XDR *xdrs = &(cu->cu_outxdrs);
@@ -587,16 +585,15 @@ clnt_dg_freeres(cl, xdr_res, res_ptr)
 
 /*ARGSUSED*/
 static void
-clnt_dg_abort(h)
-	CLIENT *h;
+clnt_dg_abort(CLIENT *h)
 {
 }
 
 static bool_t
-clnt_dg_control(cl, request, info)
-	CLIENT *cl;
-	u_int request;
-	void *info;
+clnt_dg_control(
+	CLIENT *cl,
+	u_int request,
+	void *info)
 {
 	struct cu_data *cu = (struct cu_data *)cl->cl_private;
 	struct netbuf *addr;
@@ -735,8 +732,7 @@ clnt_dg_control(cl, request, info)
 }
 
 static void
-clnt_dg_destroy(cl)
-	CLIENT *cl;
+clnt_dg_destroy(CLIENT *cl)
 {
 	struct cu_data *cu = (struct cu_data *)cl->cl_private;
 	int cu_fd = cu->cu_fd;
@@ -800,8 +796,7 @@ clnt_dg_ops()
  * Make sure that the time is not garbage.  -1 value is allowed.
  */
 static bool_t
-time_not_ok(t)
-	struct timeval *t;
+time_not_ok(struct timeval *t)
 {
 	return (t->tv_sec < -1 || t->tv_sec > 100000000 ||
 		t->tv_usec < -1 || t->tv_usec > 1000000);
diff --git a/src/clnt_perror.c b/src/clnt_perror.c
index fb7fb80..7c2ec21 100644
--- a/src/clnt_perror.c
+++ b/src/clnt_perror.c
@@ -60,9 +60,7 @@ _buf()
  * Print reply error info
  */
 char *
-clnt_sperror(rpch, s)
-	CLIENT *rpch;
-	const char *s;
+clnt_sperror(CLIENT *rpch, const char *s)
 {
 	struct rpc_err e;
 	char *err;
@@ -174,9 +172,7 @@ clnt_sperror(rpch, s)
 }
 
 void
-clnt_perror(rpch, s)
-	CLIENT *rpch;
-	const char *s;
+clnt_perror(CLIENT *rpch, const char *s)
 {
 
 	if (rpch == NULL || s == NULL)
@@ -211,8 +207,7 @@ static const char *const rpc_errlist[] = {
  * This interface for use by clntrpc
  */
 char *
-clnt_sperrno(stat)
-	enum clnt_stat stat;
+clnt_sperrno(enum clnt_stat stat)
 {
 	unsigned int errnum = stat;
 
@@ -224,16 +219,14 @@ clnt_sperrno(stat)
 }
 
 void
-clnt_perrno(num)
-	enum clnt_stat num;
+clnt_perrno(enum clnt_stat num)
 {
 	(void) fprintf(stderr, "%s\n", clnt_sperrno(num));
 }
 
 
 char *
-clnt_spcreateerror(s)
-	const char *s;
+clnt_spcreateerror(const char *s)
 {
 	char *str, *err;
 	size_t len, i;
@@ -300,8 +293,7 @@ clnt_spcreateerror(s)
 }
 
 void
-clnt_pcreateerror(s)
-	const char *s;
+clnt_pcreateerror(const char *s)
 {
 
 	if (s == NULL)
@@ -322,8 +314,7 @@ static const char *const auth_errlist[] = {
 };
 
 static char *
-auth_errmsg(stat)
-	enum auth_stat stat;
+auth_errmsg(enum auth_stat stat)
 {
 	unsigned int errnum = stat;
 
diff --git a/src/clnt_raw.c b/src/clnt_raw.c
index 03f839d..4e00a76 100644
--- a/src/clnt_raw.c
+++ b/src/clnt_raw.c
@@ -77,9 +77,7 @@ static struct clnt_ops *clnt_raw_ops(void);
  * Create a client handle for memory based rpc.
  */
 CLIENT *
-clnt_raw_create(prog, vers)
-	rpcprog_t prog;
-	rpcvers_t vers;
+clnt_raw_create(rpcprog_t prog, rpcvers_t vers)
 {
 	struct clntraw_private *clp;
 	struct rpc_msg call_msg;
@@ -132,14 +130,14 @@ clnt_raw_create(prog, vers)
 
 /* ARGSUSED */
 static enum clnt_stat 
-clnt_raw_call(h, proc, xargs, argsp, xresults, resultsp, timeout)
-	CLIENT *h;
-	rpcproc_t proc;
-	xdrproc_t xargs;
-	void *argsp;
-	xdrproc_t xresults;
-	void *resultsp;
-	struct timeval timeout;
+clnt_raw_call(
+	CLIENT *h,
+	rpcproc_t proc,
+	xdrproc_t xargs,
+	void *argsp,
+	xdrproc_t xresults,
+	void *resultsp,
+	struct timeval timeout)
 {
 	struct clntraw_private *clp = clntraw_private;
 	XDR *xdrs;
@@ -231,19 +229,17 @@ call_again:
 
 /*ARGSUSED*/
 static void
-clnt_raw_geterr(cl, err)
-	CLIENT *cl;
-	struct rpc_err *err;
+clnt_raw_geterr(CLIENT *cl, struct rpc_err *err)
 {
 }
 
 
 /* ARGSUSED */
 static bool_t
-clnt_raw_freeres(cl, xdr_res, res_ptr)
-	CLIENT *cl;
-	xdrproc_t xdr_res;
-	void *res_ptr;
+clnt_raw_freeres(
+	CLIENT *cl,
+	xdrproc_t xdr_res,
+	void *res_ptr)
 {
 	struct clntraw_private *clp = clntraw_private;
 	XDR *xdrs;
@@ -263,25 +259,23 @@ clnt_raw_freeres(cl, xdr_res, res_ptr)
 
 /*ARGSUSED*/
 static void
-clnt_raw_abort(cl)
-	CLIENT *cl;
+clnt_raw_abort(CLIENT *cl)
 {
 }
 
 /*ARGSUSED*/
 static bool_t
-clnt_raw_control(cl, ui, str)
-	CLIENT *cl;
-	u_int ui;
-	void *str;
+clnt_raw_control(
+	CLIENT *cl,
+	u_int ui,
+	void *str)
 {
 	return (FALSE);
 }
 
 /*ARGSUSED*/
 static void
-clnt_raw_destroy(cl)
-	CLIENT *cl;
+clnt_raw_destroy(CLIENT *cl)
 {
 }
 
diff --git a/src/clnt_simple.c b/src/clnt_simple.c
index 1700060..b0e29ba 100644
--- a/src/clnt_simple.c
+++ b/src/clnt_simple.c
@@ -87,15 +87,16 @@ rpc_call_destroy(void *vp)
  * The total time available is 25 seconds.
  */
 enum clnt_stat
-rpc_call(host, prognum, versnum, procnum, inproc, in, outproc, out, nettype)
-	const char *host;			/* host name */
-	rpcprog_t prognum;			/* program number */
-	rpcvers_t versnum;			/* version number */
-	rpcproc_t procnum;			/* procedure number */
-	xdrproc_t inproc, outproc;	/* in/out XDR procedures */
-	const char *in;
-	char  *out;			/* recv/send data */
-	const char *nettype;			/* nettype */
+rpc_call(
+	const char *host,			/* host name */
+	rpcprog_t prognum,			/* program number */
+	rpcvers_t versnum,			/* version number */
+	rpcproc_t procnum,			/* procedure number */
+	xdrproc_t inproc,			/* recv data */
+	const char *in,				/* recv XDR data */
+	xdrproc_t outproc,			/* out XDR procedures */
+	char  *out,				/* send data */
+	const char *nettype)		/* nettype */
 {
   	struct rpc_call_private *rcp = (struct rpc_call_private *) 0;
 	enum clnt_stat clnt_stat;
diff --git a/src/clnt_vc.c b/src/clnt_vc.c
index 5bbc78b..e94313b 100644
--- a/src/clnt_vc.c
+++ b/src/clnt_vc.c
@@ -175,13 +175,13 @@ static const char __no_mem_str[] = "out of memory";
  * fd should be an open socket
  */
 CLIENT *
-clnt_vc_create(fd, raddr, prog, vers, sendsz, recvsz)
-	int fd;				/* open file descriptor */
-	const struct netbuf *raddr;	/* servers address */
-	const rpcprog_t prog;			/* program number */
-	const rpcvers_t vers;			/* version number */
-	u_int sendsz;			/* buffer recv size */
-	u_int recvsz;			/* buffer send size */
+clnt_vc_create(
+	int fd,				/* open file descriptor */
+	const struct netbuf *raddr,	/* servers address */
+	const rpcprog_t prog,			/* program number */
+	const rpcvers_t vers,			/* version number */
+	u_int sendsz,			/* buffer recv size */
+	u_int recvsz)			/* buffer send size */
 {
 	CLIENT *cl;			/* client handle */
 	struct ct_data *ct = NULL;	/* client handle */
@@ -335,14 +335,14 @@ err:
 }
 
 static enum clnt_stat
-clnt_vc_call(cl, proc, xdr_args, args_ptr, xdr_results, results_ptr, timeout)
-	CLIENT *cl;
-	rpcproc_t proc;
-	xdrproc_t xdr_args;
-	void *args_ptr;
-	xdrproc_t xdr_results;
-	void *results_ptr;
-	struct timeval timeout;
+clnt_vc_call(
+	CLIENT *cl,
+	rpcproc_t proc,
+	xdrproc_t xdr_args,
+	void *args_ptr,
+	xdrproc_t xdr_results,
+	void *results_ptr,
+	struct timeval timeout)
 {
 	struct ct_data *ct = (struct ct_data *) cl->cl_private;
 	XDR *xdrs = &(ct->ct_xdrs);
@@ -464,9 +464,7 @@ call_again:
 }
 
 static void
-clnt_vc_geterr(cl, errp)
-	CLIENT *cl;
-	struct rpc_err *errp;
+clnt_vc_geterr(CLIENT *cl, struct rpc_err *errp)
 {
 	struct ct_data *ct;
 
@@ -478,10 +476,10 @@ clnt_vc_geterr(cl, errp)
 }
 
 static bool_t
-clnt_vc_freeres(cl, xdr_res, res_ptr)
-	CLIENT *cl;
-	xdrproc_t xdr_res;
-	void *res_ptr;
+clnt_vc_freeres(
+	CLIENT *cl,
+	xdrproc_t xdr_res,
+	void *res_ptr)
 {
 	struct ct_data *ct;
 	XDR *xdrs;
@@ -512,16 +510,15 @@ clnt_vc_freeres(cl, xdr_res, res_ptr)
 
 /*ARGSUSED*/
 static void
-clnt_vc_abort(cl)
-	CLIENT *cl;
+clnt_vc_abort(CLIENT *cl)
 {
 }
 
 static bool_t
-clnt_vc_control(cl, request, info)
-	CLIENT *cl;
-	u_int request;
-	void *info;
+clnt_vc_control(
+	CLIENT *cl,
+	u_int request,
+	void *info)
 {
 	struct ct_data *ct;
 	void *infop = info;
@@ -647,8 +644,7 @@ clnt_vc_control(cl, request, info)
 
 
 static void
-clnt_vc_destroy(cl)
-	CLIENT *cl;
+clnt_vc_destroy(CLIENT *cl)
 {
 	assert(cl != NULL);
 	struct ct_data *ct = (struct ct_data *) cl->cl_private;
@@ -692,10 +688,10 @@ clnt_vc_destroy(cl)
  * around for the rpc level.
  */
 static int
-read_vc(ctp, buf, len)
-	void *ctp;
-	void *buf;
-	int len;
+read_vc(
+	void *ctp,
+	void *buf,
+	int len)
 {
 	/*
 	struct sockaddr sa;
@@ -745,10 +741,10 @@ read_vc(ctp, buf, len)
 }
 
 static int
-write_vc(ctp, buf, len)
-	void *ctp;
-	void *buf;
-	int len;
+write_vc(
+	void *ctp,
+	void *buf,
+	int len)
 {
 	struct ct_data *ct = (struct ct_data *)ctp;
 	int i = 0, cnt;
@@ -793,8 +789,7 @@ clnt_vc_ops()
  * Note this is different from time_not_ok in clnt_dg.c
  */
 static bool_t
-time_not_ok(t)
-	struct timeval *t;
+time_not_ok(struct timeval *t)
 {
 	return (t->tv_sec <= -1 || t->tv_sec > 100000000 ||
 		t->tv_usec <= -1 || t->tv_usec > 1000000);
-- 
2.50.1


