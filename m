Return-Path: <linux-nfs+bounces-13727-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B516CB2AC38
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 17:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6163317EE79
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 15:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9958222422A;
	Mon, 18 Aug 2025 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GxrGBvHu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2219524A067
	for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529724; cv=none; b=sB/BrPTdEnssNHk/2qnYKQmzVqUUpJPXfo4uqC5TpwLZ3sfQJrD8P4fSO4eS+8XRHKZDRYNtbYeP7thAhj9lPUaOAX/nQzx6KXBELClYR1eblK/n6F5YZwSfqpDcNLNJm3tmcD/xEYE8G498cut4TJBpqPJx+OSfTQb2ilZOKfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529724; c=relaxed/simple;
	bh=zVDFq/2Bx6x/lMmuo5zCX360ifVX4S7iopDbNC4iw/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDRK/mzX073BfxBMyLyaJgc7eYPujxSnjHTPFfFKAwHKyShDJcyHN83+FPdkTi8Kjp0LvqoI7zDtsZn3cWo1J1x/fnraDhKIcA77x+bvYn/b2mR7Xj7wpTAQcHFVr7LscMGaHnP1W+vPf9I+Z/EpuffkacyXJDCvGERTjfEbGpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GxrGBvHu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755529721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fGDOC7sMbdUIQTpv0vRfQR4wtbug7qDkKEBdPnHQ+30=;
	b=GxrGBvHu4Gmn7vIW1dsw4ZT5Rx9lvxBQy5XRqjNUs1edBfWANpLsmAuzczt2qKnUOiVpLX
	APomfEpVgVKLGBRUBA5JM/SgPTmTCax4l53xO8DU2k89GQlIh3nk3MOvs7uTwOegs5iXb5
	x6BSK5jEa/vuttj4qquO/dceE3R0Phg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-RezMbefmPg-bBBkVhcfeCw-1; Mon,
 18 Aug 2025 11:08:39 -0400
X-MC-Unique: RezMbefmPg-bBBkVhcfeCw-1
X-Mimecast-MFC-AGG-ID: RezMbefmPg-bBBkVhcfeCw_1755529718
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A679195F162;
	Mon, 18 Aug 2025 15:08:38 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.22.64.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E189730001A8;
	Mon, 18 Aug 2025 15:08:37 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 05/12] Convert old-style function definitions into modern-style definitions
Date: Mon, 18 Aug 2025 11:08:22 -0400
Message-ID: <20250818150829.1044948-6-steved@redhat.com>
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
 src/rpc_callmsg.c |   4 +-
 src/rpc_generic.c |  31 ++---
 src/rpc_prot.c    |  36 ++----
 src/rpc_soc.c     | 310 +++++++++++++++++++++++-----------------------
 4 files changed, 180 insertions(+), 201 deletions(-)

diff --git a/src/rpc_callmsg.c b/src/rpc_callmsg.c
index d5f7d0c..190f34a 100644
--- a/src/rpc_callmsg.c
+++ b/src/rpc_callmsg.c
@@ -46,9 +46,7 @@
  * XDR a call message
  */
 bool_t
-xdr_callmsg(xdrs, cmsg)
-	XDR *xdrs;
-	struct rpc_msg *cmsg;
+xdr_callmsg(XDR *xdrs, struct rpc_msg *cmsg)
 {
 	int32_t *buf;
 	struct opaque_auth *oa;
diff --git a/src/rpc_generic.c b/src/rpc_generic.c
index ee44c8d..db21903 100644
--- a/src/rpc_generic.c
+++ b/src/rpc_generic.c
@@ -127,9 +127,10 @@ __rpc_dtbsize()
  */
 u_int
 /*ARGSUSED*/
-__rpc_get_t_size(af, proto, size)
-	int af, proto;
-	int size;	/* Size requested */
+__rpc_get_t_size(
+	int af, 
+	int proto,
+	int size)	/* Size requested */
 {
 	int maxsize, defsize;
 
@@ -156,8 +157,7 @@ __rpc_get_t_size(af, proto, size)
  * Find the appropriate address buffer size
  */
 u_int
-__rpc_get_a_size(af)
-	int af;
+__rpc_get_a_size(int af)
 {
 	switch (af) {
 	case AF_INET:
@@ -193,8 +193,7 @@ strlocase(p)
  * If nettype is NULL, it defaults to NETPATH.
  */
 static int
-getnettype(nettype)
-	const char *nettype;
+getnettype(const char *nettype)
 {
 	int i;
 
@@ -218,8 +217,7 @@ getnettype(nettype)
  * This should be freed by calling freenetconfigent()
  */
 struct netconfig *
-__rpc_getconfip(nettype)
-	const char *nettype;
+__rpc_getconfip(const char *nettype)
 {
 	char *netid;
 	char *netid_tcp = (char *) NULL;
@@ -287,8 +285,7 @@ __rpc_getconfip(nettype)
  * __rpc_getconf().
  */
 void *
-__rpc_setconf(nettype)
-	const char *nettype;
+__rpc_setconf(const char *nettype)
 {
 	struct handle *handle;
 
@@ -331,8 +328,7 @@ __rpc_setconf(nettype)
  * __rpc_setconf() should have been called previously.
  */
 struct netconfig *
-__rpc_getconf(vhandle)
-	void *vhandle;
+__rpc_getconf(void *vhandle)
 {
 	struct handle *handle;
 	struct netconfig *nconf;
@@ -408,8 +404,7 @@ __rpc_getconf(vhandle)
 }
 
 void
-__rpc_endconf(vhandle)
-	void * vhandle;
+__rpc_endconf(void * vhandle)
 {
 	struct handle *handle;
 
@@ -430,8 +425,7 @@ __rpc_endconf(vhandle)
  * Returns NULL if fails, else a non-NULL pointer.
  */
 void *
-rpc_nullproc(clnt)
-	CLIENT *clnt;
+rpc_nullproc(CLIENT *clnt)
 {
 	struct timeval TIMEOUT = {25, 0};
 
@@ -447,8 +441,7 @@ rpc_nullproc(clnt)
  * one succeeds in finding the netconf for the given fd.
  */
 struct netconfig *
-__rpcgettp(fd)
-	int fd;
+__rpcgettp(int fd)
 {
 	const char *netid;
 	struct __rpc_sockinfo si;
diff --git a/src/rpc_prot.c b/src/rpc_prot.c
index 5841e51..3516d65 100644
--- a/src/rpc_prot.c
+++ b/src/rpc_prot.c
@@ -57,9 +57,7 @@ extern struct opaque_auth _null_auth;
  * (see auth.h)
  */
 bool_t
-xdr_opaque_auth(xdrs, ap)
-	XDR *xdrs;
-	struct opaque_auth *ap;
+xdr_opaque_auth(XDR *xdrs, struct opaque_auth *ap)
 {
 
 	assert(xdrs != NULL);
@@ -75,9 +73,7 @@ xdr_opaque_auth(xdrs, ap)
  * XDR a DES block
  */
 bool_t
-xdr_des_block(xdrs, blkp)
-	XDR *xdrs;
-	des_block *blkp;
+xdr_des_block(XDR *xdrs, des_block *blkp)
 {
 
 	assert(xdrs != NULL);
@@ -92,9 +88,7 @@ xdr_des_block(xdrs, blkp)
  * XDR the MSG_ACCEPTED part of a reply message union
  */
 bool_t
-xdr_accepted_reply(xdrs, ar)
-	XDR *xdrs;   
-	struct accepted_reply *ar;
+xdr_accepted_reply(XDR *xdrs, struct accepted_reply *ar)
 {
 
 	assert(xdrs != NULL);
@@ -128,9 +122,7 @@ xdr_accepted_reply(xdrs, ar)
  * XDR the MSG_DENIED part of a reply message union
  */
 bool_t 
-xdr_rejected_reply(xdrs, rr)
-	XDR *xdrs;
-	struct rejected_reply *rr;
+xdr_rejected_reply(XDR *xdrs, struct rejected_reply *rr)
 {
 
 	assert(xdrs != NULL);
@@ -162,9 +154,7 @@ static const struct xdr_discrim reply_dscrm[3] = {
  * XDR a reply message
  */
 bool_t
-xdr_replymsg(xdrs, rmsg)
-	XDR *xdrs;
-	struct rpc_msg *rmsg;
+xdr_replymsg(XDR *xdrs, struct rpc_msg *rmsg)
 {
 	assert(xdrs != NULL);
 	assert(rmsg != NULL);
@@ -186,9 +176,7 @@ xdr_replymsg(xdrs, rmsg)
  * The rm_xid is not really static, but the user can easily munge on the fly.
  */
 bool_t
-xdr_callhdr(xdrs, cmsg)
-	XDR *xdrs;
-	struct rpc_msg *cmsg;
+xdr_callhdr(XDR *xdrs, struct rpc_msg *cmsg)
 {
 
 	assert(xdrs != NULL);
@@ -209,9 +197,7 @@ xdr_callhdr(xdrs, cmsg)
 /* ************************** Client utility routine ************* */
 
 static void
-accepted(acpt_stat, error)
-	enum accept_stat acpt_stat;
-	struct rpc_err *error;
+accepted(enum accept_stat acpt_stat, struct rpc_err *error)
 {
 
 	assert(error != NULL);
@@ -250,9 +236,7 @@ accepted(acpt_stat, error)
 }
 
 static void 
-rejected(rjct_stat, error)
-	enum reject_stat rjct_stat;
-	struct rpc_err *error;
+rejected(enum reject_stat rjct_stat, struct rpc_err *error)
 {
 
 	assert(error != NULL);
@@ -277,9 +261,7 @@ rejected(rjct_stat, error)
  * given a reply message, fills in the error
  */
 void
-_seterr_reply(msg, error)
-	struct rpc_msg *msg;
-	struct rpc_err *error;
+_seterr_reply(struct rpc_msg *msg, struct rpc_err *error)
 {
 
 	assert(msg != NULL);
diff --git a/src/rpc_soc.c b/src/rpc_soc.c
index c6c93b5..3102c85 100644
--- a/src/rpc_soc.c
+++ b/src/rpc_soc.c
@@ -80,15 +80,15 @@ static bool_t rpc_wrap_bcast(char *, struct netbuf *, struct netconfig *);
  * A common clnt create routine
  */
 static CLIENT *
-clnt_com_create(raddr, prog, vers, sockp, sendsz, recvsz, tp, flags)
-	struct sockaddr_in *raddr;
-	rpcprog_t prog;
-	rpcvers_t vers;
-	int *sockp;
-	u_int sendsz;
-	u_int recvsz;
-	char *tp;
-	int flags;
+clnt_com_create(
+	struct sockaddr_in *raddr,
+	rpcprog_t prog,
+	rpcvers_t vers,
+	int *sockp,
+	u_int sendsz,
+	u_int recvsz,
+	char *tp,
+	int flags)
 {
 	CLIENT *cl;
 	int madefd = FALSE;
@@ -174,15 +174,15 @@ err:	if (madefd == TRUE)
 }
 
 CLIENT *
-__libc_clntudp_bufcreate(raddr, prog, vers, wait, sockp, sendsz, recvsz, flags)
-	struct sockaddr_in *raddr;
-	u_long prog;
-	u_long vers;
-	struct timeval wait;
-	int *sockp;
-	u_int sendsz;
-	u_int recvsz;
-	int flags;
+__libc_clntudp_bufcreate(
+	struct sockaddr_in *raddr,
+	u_long prog,
+	u_long vers,
+	struct timeval wait,
+	int *sockp,
+	u_int sendsz,
+	u_int recvsz,
+	int flags)
 {
 	CLIENT *cl;
 
@@ -196,14 +196,14 @@ __libc_clntudp_bufcreate(raddr, prog, vers, wait, sockp, sendsz, recvsz, flags)
 }
 
 CLIENT *
-clntudp_bufcreate(raddr, prog, vers, wait, sockp, sendsz, recvsz)
-	struct sockaddr_in *raddr;
-	u_long prog;
-	u_long vers;
-	struct timeval wait;
-	int *sockp;
-	u_int sendsz;
-	u_int recvsz;
+clntudp_bufcreate(
+	struct sockaddr_in *raddr,
+	u_long prog,
+	u_long vers,
+	struct timeval wait,
+	int *sockp,
+	u_int sendsz,
+	u_int recvsz)
 {
 	CLIENT *cl;
 
@@ -217,24 +217,24 @@ clntudp_bufcreate(raddr, prog, vers, wait, sockp, sendsz, recvsz)
 }
 
 CLIENT *
-clntudp_create(raddr, program, version, wait, sockp)
-	struct sockaddr_in *raddr;
-	u_long program;
-	u_long version;
-	struct timeval wait;
-	int *sockp;
+clntudp_create(
+	struct sockaddr_in *raddr,
+	u_long program,
+	u_long version,
+	struct timeval wait,
+	int *sockp)
 {
 	return clntudp_bufcreate(raddr, program, version, wait, sockp, UDPMSGSIZE, UDPMSGSIZE);
 }
 
 CLIENT *
-clnttcp_create(raddr, prog, vers, sockp, sendsz, recvsz)
-	struct sockaddr_in *raddr;
-	u_long prog;
-	u_long vers;
-	int *sockp;
-	u_int sendsz;
-	u_int recvsz;
+clnttcp_create(
+	struct sockaddr_in *raddr,
+	u_long prog,
+	u_long vers,
+	int *sockp,
+	u_int sendsz,
+	u_int recvsz)
 {
 	return clnt_com_create(raddr, (rpcprog_t)prog, (rpcvers_t)vers, sockp,
 	    sendsz, recvsz, "tcp", 0);
@@ -245,14 +245,14 @@ clnttcp_create(raddr, prog, vers, sockp, sendsz, recvsz)
 #ifdef INET6_NOT_USED
 
 CLIENT *
-clntudp6_bufcreate(raddr, prog, vers, wait, sockp, sendsz, recvsz)
-	struct sockaddr_in6 *raddr;
-	u_long prog;
-	u_long vers;
-	struct timeval wait;
-	int *sockp;
-	u_int sendsz;
-	u_int recvsz;
+clntudp6_bufcreate(
+	struct sockaddr_in6 *raddr,
+	u_long prog,
+	u_long vers,
+	struct timeval wait,
+	int *sockp,
+	u_int sendsz,
+	u_int recvsz)
 {
 	CLIENT *cl;
 
@@ -266,24 +266,24 @@ clntudp6_bufcreate(raddr, prog, vers, wait, sockp, sendsz, recvsz)
 }
 
 CLIENT *
-clntudp6_create(raddr, program, version, wait, sockp)
-	struct sockaddr_in6 *raddr;
-	u_long program;
-	u_long version;
-	struct timeval wait;
-	int *sockp;
+clntudp6_create(
+	struct sockaddr_in6 *raddr,
+	u_long program,
+	u_long version,
+	struct timeval wait,
+	int *sockp)
 {
 	return clntudp6_bufcreate(raddr, program, version, wait, sockp, UDPMSGSIZE, UDPMSGSIZE);
 }
 
 CLIENT *
-clnttcp6_create(raddr, prog, vers, sockp, sendsz, recvsz)
-	struct sockaddr_in6 *raddr;
-	u_long prog;
-	u_long vers;
-	int *sockp;
-	u_int sendsz;
-	u_int recvsz;
+clnttcp6_create(
+	struct sockaddr_in6 *raddr,
+	u_long prog,
+	u_long vers,
+	int *sockp,
+	u_int sendsz,
+	u_int recvsz)
 {
 	return clnt_com_create(raddr, (rpcprog_t)prog, (rpcvers_t)vers, sockp,
 	    sendsz, recvsz, "tcp6", 0);
@@ -292,9 +292,9 @@ clnttcp6_create(raddr, prog, vers, sockp, sendsz, recvsz)
 #endif
 
 CLIENT *
-clntraw_create(prog, vers)
-	u_long prog;
-	u_long vers;
+clntraw_create(
+	u_long prog,
+	u_long vers)
 {
 	return clnt_raw_create((rpcprog_t)prog, (rpcvers_t)vers);
 }
@@ -303,11 +303,11 @@ clntraw_create(prog, vers)
  * A common server create routine
  */
 static SVCXPRT *
-svc_com_create(fd, sendsize, recvsize, netid)
-	int fd;
-	u_int sendsize;
-	u_int recvsize;
-	char *netid;
+svc_com_create(
+	int fd,
+	u_int sendsize,
+	u_int recvsize,
+	char *netid)
 {
 	struct netconfig *nconf;
 	SVCXPRT *svc;
@@ -342,10 +342,10 @@ svc_com_create(fd, sendsize, recvsize, netid)
 }
 
 SVCXPRT *
-svctcp_create(fd, sendsize, recvsize)
-	int fd;
-	u_int sendsize;
-	u_int recvsize;
+svctcp_create(
+	int fd,
+	u_int sendsize,
+	u_int recvsize)
 {
 
 	return svc_com_create(fd, sendsize, recvsize, "tcp");
@@ -354,9 +354,10 @@ svctcp_create(fd, sendsize, recvsize)
 
 
 SVCXPRT *
-svcudp_bufcreate(fd, sendsz, recvsz)
-	int fd;
-	u_int sendsz, recvsz;
+svcudp_bufcreate(
+	int fd,
+	u_int sendsz, 
+	u_int recvsz)
 {
 
 	return svc_com_create(fd, sendsz, recvsz, "udp");
@@ -365,10 +366,10 @@ svcudp_bufcreate(fd, sendsz, recvsz)
 
 
 SVCXPRT *
-svcfd_create(fd, sendsize, recvsize)
-	int fd;
-	u_int sendsize;
-	u_int recvsize;
+svcfd_create(
+	int fd,
+	u_int sendsize,
+	u_int recvsize)
 {
 
 	return svc_fd_create(fd, sendsize, recvsize);
@@ -376,8 +377,7 @@ svcfd_create(fd, sendsize, recvsize)
 
 
 SVCXPRT *
-svcudp_create(fd)
-	int fd;
+svcudp_create(int fd)
 {
 
 	return svc_com_create(fd, UDPMSGSIZE, UDPMSGSIZE, "udp");
@@ -395,35 +395,34 @@ svcraw_create()
 /* IPV6 version */
 #ifdef INET6_NOT_USED
 SVCXPRT *
-svcudp6_bufcreate(fd, sendsz, recvsz)
-	int fd;
-	u_int sendsz, recvsz;
+svcudp6_bufcreate(
+	int fd,
+	u_int sendsz, 
+	u_int recvsz)
 {
 	return svc_com_create(fd, sendsz, recvsz, "udp6");
 }
 
 
 SVCXPRT *
-svctcp6_create(fd, sendsize, recvsize)
-	int fd;
-	u_int sendsize;
-	u_int recvsize;
+svctcp6_create(
+	int fd,
+	u_int sendsize,
+	u_int recvsize)
 {
 	return svc_com_create(fd, sendsize, recvsize, "tcp6");
 }
 
 
 SVCXPRT *
-svcudp6_create(fd)
-	int fd;
+svcudp6_create(int fd)
 {
 	return svc_com_create(fd, UDPMSGSIZE, UDPMSGSIZE, "udp6");
 }
 #endif
 
 int
-get_myaddress(addr)
-	struct sockaddr_in *addr;
+get_myaddress(struct sockaddr_in *addr)
 {
 
 	memset((void *) addr, 0, sizeof(*addr));
@@ -437,11 +436,15 @@ get_myaddress(addr)
  * For connectionless "udp" transport. Obsoleted by rpc_call().
  */
 int
-callrpc(host, prognum, versnum, procnum, inproc, in, outproc, out)
-	const char *host;
-	int prognum, versnum, procnum;
-	xdrproc_t inproc, outproc;
-	void *in, *out;
+callrpc(
+	const char *host,
+	int prognum, 
+	int versnum, 
+	int procnum,
+	xdrproc_t inproc,
+	void *in,
+	xdrproc_t outproc,
+	void *out)
 {
 
 	return (int)rpc_call(host, (rpcprog_t)prognum, (rpcvers_t)versnum,
@@ -452,10 +455,13 @@ callrpc(host, prognum, versnum, procnum, inproc, in, outproc, out)
  * For connectionless kind of transport. Obsoleted by rpc_reg()
  */
 int
-registerrpc(prognum, versnum, procnum, progname, inproc, outproc)
-	int prognum, versnum, procnum;
-	char *(*progname)(char [UDPMSGSIZE]);
-	xdrproc_t inproc, outproc;
+registerrpc(
+	int prognum, 
+	int versnum, 
+	int procnum,
+	char *(*progname)(char [UDPMSGSIZE]),
+	xdrproc_t inproc, 
+	xdrproc_t outproc)
 {
 
 	return rpc_reg((rpcprog_t)prognum, (rpcvers_t)versnum,
@@ -474,10 +480,10 @@ extern thread_key_t	clnt_broadcast_key;
  */
 /* ARGSUSED */
 static bool_t
-rpc_wrap_bcast(resultp, addr, nconf)
-	char *resultp;		/* results of the call */
-	struct netbuf *addr;	/* address of the guy who responded */
-	struct netconfig *nconf; /* Netconf of the transport */
+rpc_wrap_bcast(
+	char *resultp,		/* results of the call */
+	struct netbuf *addr,	/* address of the guy who responded */
+	struct netconfig *nconf) /* Netconf of the transport */
 {
 	resultproc_t clnt_broadcast_result;
 
@@ -492,15 +498,15 @@ rpc_wrap_bcast(resultp, addr, nconf)
  * Broadcasts on UDP transport. Obsoleted by rpc_broadcast().
  */
 enum clnt_stat
-clnt_broadcast(prog, vers, proc, xargs, argsp, xresults, resultsp, eachresult)
-	u_long		prog;		/* program number */
-	u_long		vers;		/* version number */
-	u_long		proc;		/* procedure number */
-	xdrproc_t	xargs;		/* xdr routine for args */
-	void	       *argsp;		/* pointer to args */
-	xdrproc_t	xresults;	/* xdr routine for results */
-	void	       *resultsp;	/* pointer to results */
-	resultproc_t	eachresult;	/* call with each result obtained */
+clnt_broadcast(
+	u_long		prog,		/* program number */
+	u_long		vers,		/* version number */
+	u_long		proc,		/* procedure number */
+	xdrproc_t	xargs,		/* xdr routine for args */
+	void	       *argsp,		/* pointer to args */
+	xdrproc_t	xresults,	/* xdr routine for results */
+	void	       *resultsp,	/* pointer to results */
+	resultproc_t	eachresult)	/* call with each result obtained */
 {
 	extern mutex_t tsd_lock;
 
@@ -522,11 +528,11 @@ clnt_broadcast(prog, vers, proc, xargs, argsp, xresults, resultsp, eachresult)
  * authdes_seccreate().
  */
 AUTH *
-authdes_create(servername, window, syncaddr, ckey)
-	char *servername;		/* network name of server */
-	u_int window;			/* time to live */
-	struct sockaddr *syncaddr;	/* optional hostaddr to sync with */
-	des_block *ckey;		/* optional conversation key to use */
+authdes_create(
+	char *servername,		/* network name of server */
+	u_int window,			/* time to live */
+	struct sockaddr *syncaddr,	/* optional hostaddr to sync with */
+	des_block *ckey)		/* optional conversation key to use */
 {
 	AUTH *nauth;
 	char hostname[NI_MAXHOST];
@@ -565,12 +571,12 @@ extern AUTH *authdes_pk_seccreate(const char *, netobj *, u_int, const char *,
         const des_block *, nis_server *);
 
 AUTH *
-authdes_pk_create(servername, pkey, window, syncaddr, ckey)
-	char *servername;		/* network name of server */
-	netobj *pkey;			/* public key */
-	u_int window;			/* time to live */
-	struct sockaddr *syncaddr;	/* optional hostaddr to sync with */
-	des_block *ckey;		/* optional conversation key to use */
+authdes_pk_create(
+	char *servername,		/* network name of server */
+	netobj *pkey,			/* public key */
+	u_int window,			/* time to live */
+	struct sockaddr *syncaddr,	/* optional hostaddr to sync with */
+	des_block *ckey)		/* optional conversation key to use */
 {
 	AUTH *nauth;
 	char hostname[NI_MAXHOST];
@@ -597,20 +603,20 @@ fallback:
 }
 #else
 AUTH *
-authdes_create(servername, window, syncaddr, ckey)
-	char *servername;		/* network name of server */
-	u_int window;			/* time to live */
-	struct sockaddr *syncaddr;	/* optional hostaddr to sync with */
-	des_block *ckey;		/* optional conversation key to use */
+authdes_create(
+	char *servername,		/* network name of server */
+	u_int window,			/* time to live */
+	struct sockaddr *syncaddr,	/* optional hostaddr to sync with */
+	des_block *ckey)		/* optional conversation key to use */
 { return (NULL); }
 
 AUTH *
-authdes_pk_create(servername, pkey, window, syncaddr, ckey)
-	char *servername;		/* network name of server */
-	netobj *pkey;			/* public key */
-	u_int window;			/* time to live */
-	struct sockaddr *syncaddr;	/* optional hostaddr to sync with */
-	des_block *ckey;		/* optional conversation key to use */
+authdes_pk_create(
+	char *servername,		/* network name of server */
+	netobj *pkey,			/* public key */
+	u_int window,			/* time to live */
+	struct sockaddr *syncaddr,	/* optional hostaddr to sync with */
+	des_block *ckey)		/* optional conversation key to use */
 { return (NULL); }
 
 AUTH *
@@ -627,13 +633,13 @@ authdes_seccreate(const char *servername, const u_int win,
  * Create a client handle for a unix connection. Obsoleted by clnt_vc_create()
  */
 CLIENT *
-clntunix_create(raddr, prog, vers, sockp, sendsz, recvsz)
-	struct sockaddr_un *raddr;
-	u_long prog;
-	u_long vers;
-	int *sockp;
-	u_int sendsz;
-	u_int recvsz;
+clntunix_create(
+	struct sockaddr_un *raddr,
+	u_long prog,
+	u_long vers,
+	int *sockp,
+	u_int sendsz,
+	u_int recvsz)
 {
 	struct netbuf svcaddr = {0, 0, NULL};
 	CLIENT *cl = NULL;
@@ -669,11 +675,11 @@ done:
  * Obsoleted by svc_vc_create().
  */
 SVCXPRT *
-svcunix_create(sock, sendsize, recvsize, path)
-	int sock;
-	u_int sendsize;
-	u_int recvsize;
-	char *path;
+svcunix_create(
+	int sock,
+	u_int sendsize,
+	u_int recvsize,
+	char *path)
 {
 	struct netconfig *nconf;
 	void *localhandle;
@@ -738,10 +744,10 @@ done:
  * descriptor as its first input. Obsoleted by svc_fd_create();
  */
 SVCXPRT *
-svcunixfd_create(fd, sendsize, recvsize)
-	int fd;
-	u_int sendsize;
-	u_int recvsize;
+svcunixfd_create(
+	int fd,
+	u_int sendsize,
+	u_int recvsize)
 {
  	return (svc_fd_create(fd, sendsize, recvsize));
 }
-- 
2.50.1


