Return-Path: <linux-nfs+bounces-13726-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D20B2AC36
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 17:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78AD2A2DD4
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 15:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9961A24BC0A;
	Mon, 18 Aug 2025 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/P/8Lz/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3733624A06B
	for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529724; cv=none; b=gbyA6A+FHzVEL5NV5C97Fi+ifjO44ZHVrLLQNYaPsZbLoSWodjhLKlCgpZkvDWuk8lFT0m/cPRYk6Sh1MVNfIUFZu7SMjEg89Khy2/gxZFX/S/MShHyvY6pbOPf7Qq4Xrru6C8vAxygAkI8azAhQNcQOixGqE+yqI1O36nV/xRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529724; c=relaxed/simple;
	bh=TMmJBgQuVOkxk5ZLpk0/ZAQBngeKQ0yTTcMBJ0DYzRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZThLz1NwbMncM6LrV2hnY7f+/jKwP8ZV6kQjFgCqHRJfSc2w69palAP1EilNo2o2KaMZJoxK+43RWbrVbFIWhEjM/ivSZDYYbq20IOeyefDhpcCtvPMB73LsrXYK1YIniEhdRVdPCOS/kTdpvYozeXMnCrWF52vwpKnL8EtcMU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O/P/8Lz/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755529721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ES9IVglS6W2jyNbTFKZDZDtjwfneH7MfMJB17PV7pLA=;
	b=O/P/8Lz/BUvgPG6Z2JNNCvkwew704U64bX5tQAGi6MZV1TpgHSqttGOIZC4VRsTceLC8Cq
	ddc/x6r8TLqhgnR4IOh83xcwR+N1/stSADJGxkW2Df3t3ahIXPxxsT1MZyhk8v90XOu44y
	D8leFdE0D84eF6i/ePCIgrl66brg7L8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-JPfcuVBLN0OB1JVq-YFgCA-1; Mon,
 18 Aug 2025 11:08:37 -0400
X-MC-Unique: JPfcuVBLN0OB1JVq-YFgCA-1
X-Mimecast-MFC-AGG-ID: JPfcuVBLN0OB1JVq-YFgCA_1755529716
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C0EA18003FD;
	Mon, 18 Aug 2025 15:08:36 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.22.64.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D147430001A8;
	Mon, 18 Aug 2025 15:08:35 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 03/12] Convert old-style function definitions into modern-style definitions
Date: Mon, 18 Aug 2025 11:08:20 -0400
Message-ID: <20250818150829.1044948-4-steved@redhat.com>
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
 src/rpcb_clnt.c   | 154 ++++++++++++++++++++++------------------------
 src/rpcb_prot.c   |  48 +++++++--------
 src/rpcb_st_xdr.c |  42 ++++++-------
 3 files changed, 119 insertions(+), 125 deletions(-)

diff --git a/src/rpcb_clnt.c b/src/rpcb_clnt.c
index 32b6a47..826d685 100644
--- a/src/rpcb_clnt.c
+++ b/src/rpcb_clnt.c
@@ -99,8 +99,7 @@ static struct netbuf *got_entry(rpcb_entry_list_ptr, const struct netconfig *);
  *
  */
 static void
-destroy_addr(addr)
-	struct address_cache *addr;
+destroy_addr(struct address_cache *addr)
 {
 	if (addr == NULL)
 		return;
@@ -133,8 +132,7 @@ destroy_addr(addr)
  * or the new entry cannot be allocated then NULL is returned.
  */
 static struct address_cache *
-copy_addr(addr)
-	const struct address_cache *addr;
+copy_addr(const struct address_cache *addr)
 {
 	struct address_cache *copy;
 
@@ -188,9 +186,7 @@ err:
  * These are private routines that may not be provided in future releases.
  */
 bool_t
-__rpc_control(request, info)
-	int	request;
-	void	*info;
+__rpc_control(int request, void	*info)
 {
 	switch (request) {
 	case CLCR_GET_RPCB_TIMEOUT:
@@ -231,9 +227,9 @@ extern pthread_mutex_t	rpcbaddr_cache_lock;
  */
 
 static struct address_cache *
-copy_of_cached(host, netid)
-	const char *host; 
-	char *netid;
+copy_of_cached(
+	const char *host, 
+	char *netid)
 {
 	struct address_cache *cptr, *copy = NULL;
 
@@ -252,8 +248,7 @@ copy_of_cached(host, netid)
 }
 
 static void
-delete_cache(addr)
-	struct netbuf *addr;
+delete_cache(struct netbuf *addr)
 {
 	struct address_cache *cptr = NULL, *prevptr = NULL;
 
@@ -283,10 +278,11 @@ delete_cache(addr)
 }
 
 static void
-add_cache(host, netid, taddr, uaddr)
-	const char *host, *netid;
-	char *uaddr;
-	struct netbuf *taddr;
+add_cache(
+	const char *host, 
+	const char *netid,
+	struct netbuf *taddr,
+	char *uaddr)
 {
 	struct address_cache  *ad_cache, *cptr, *prevptr;
 
@@ -364,10 +360,10 @@ out_free:
  * On error, returns NULL and free's everything.
  */
 static CLIENT *
-getclnthandle(host, nconf, targaddr)
-	const char *host;
-	const struct netconfig *nconf;
-	char **targaddr;
+getclnthandle(
+	const char *host,
+	const struct netconfig *nconf,
+	char **targaddr)
 {
 	CLIENT *client;
 	struct netbuf taddr;
@@ -497,10 +493,10 @@ out_err:
  * Create a PMAP client handle.
  */
 static CLIENT *
-getpmaphandle(nconf, hostname, tgtaddr)
-	const struct netconfig *nconf;
-	const char *hostname;
-	char **tgtaddr;
+getpmaphandle(
+	const struct netconfig *nconf,
+	const char *hostname,
+	char **tgtaddr)
 {
 	CLIENT *client = NULL;
 	rpcvers_t pmapvers = 2;
@@ -537,8 +533,7 @@ getpmaphandle(nconf, hostname, tgtaddr)
  * rpcbind. Returns NULL on error and free's everything.
  */
 static CLIENT *
-local_rpcb(targaddr)
-	char **targaddr;
+local_rpcb(char **targaddr)
 {
 	CLIENT *client;
 	static struct netconfig *loopnconf;
@@ -654,11 +649,11 @@ try_nconf:
  * Calls the rpcbind service to do the mapping.
  */
 bool_t
-rpcb_set(program, version, nconf, address)
-	rpcprog_t program;
-	rpcvers_t version;
-	const struct netconfig *nconf;	/* Network structure of transport */
-	const struct netbuf *address;		/* Services netconfig address */
+rpcb_set(
+	rpcprog_t program,
+	rpcvers_t version,
+	const struct netconfig *nconf,	/* Network structure of transport */
+	const struct netbuf *address)		/* Services netconfig address */
 {
 	CLIENT *client;
 	bool_t rslt = FALSE;
@@ -715,10 +710,10 @@ rpcb_set(program, version, nconf, address)
  * only for the given transport.
  */
 bool_t
-rpcb_unset(program, version, nconf)
-	rpcprog_t program;
-	rpcvers_t version;
-	const struct netconfig *nconf;
+rpcb_unset(
+	rpcprog_t program,
+	rpcvers_t version,
+	const struct netconfig *nconf)
 {
 	CLIENT *client;
 	bool_t rslt = FALSE;
@@ -756,9 +751,9 @@ rpcb_unset(program, version, nconf)
  * From the merged list, find the appropriate entry
  */
 static struct netbuf *
-got_entry(relp, nconf)
-	rpcb_entry_list_ptr relp;
-	const struct netconfig *nconf;
+got_entry(
+	rpcb_entry_list_ptr relp,
+	const struct netconfig *nconf)
 {
 	struct netbuf *na = NULL;
 	rpcb_entry_list_ptr sp;
@@ -829,12 +824,12 @@ __rpcbind_is_up()
 
 #ifdef PORTMAP
 static struct netbuf *
-__try_protocol_version_2(program, version, nconf, host, tp)
-	rpcprog_t program;
-	rpcvers_t version;
-	const struct netconfig *nconf;
-	const char *host;
-	struct timeval *tp;
+__try_protocol_version_2(
+	rpcprog_t program,
+	rpcvers_t version,
+	const struct netconfig *nconf,
+	const char *host,
+	struct timeval *tp)
 {
 	u_short port = 0;
 	struct netbuf remote;
@@ -934,13 +929,13 @@ error:
  * starts working properly.  Also look under clnt_vc.c.
  */
 struct netbuf *
-__rpcb_findaddr_timed(program, version, nconf, host, clpp, tp)
-	rpcprog_t program;
-	rpcvers_t version;
-	const struct netconfig *nconf;
-	const char *host;
-	CLIENT **clpp;
-	struct timeval *tp;
+__rpcb_findaddr_timed(
+	rpcprog_t program,
+	rpcvers_t version,
+	const struct netconfig *nconf,
+	const char *host,
+	CLIENT **clpp,
+	struct timeval *tp)
 {
 #ifdef NOTUSED
 	static bool_t check_rpcbind = TRUE;
@@ -1116,12 +1111,12 @@ done:
  * Assuming that the address is all properly allocated
  */
 int
-rpcb_getaddr(program, version, nconf, address, host)
-	rpcprog_t program;
-	rpcvers_t version;
-	const struct netconfig *nconf;
-	struct netbuf *address;
-	const char *host;
+rpcb_getaddr(
+	rpcprog_t program,
+	rpcvers_t version,
+	const struct netconfig *nconf,
+	struct netbuf *address,
+	const char *host)
 {
 	struct netbuf *na;
 
@@ -1152,9 +1147,9 @@ rpcb_getaddr(program, version, nconf, address, host)
  * It returns NULL on failure.
  */
 rpcblist *
-rpcb_getmaps(nconf, host)
-	const struct netconfig *nconf;
-	const char *host;
+rpcb_getmaps(
+	const struct netconfig *nconf,
+	const char *host)
 {
 	rpcblist_ptr head = NULL;
 	CLIENT *client;
@@ -1204,17 +1199,18 @@ done:
  * programs to do a lookup and call in one step.
 */
 enum clnt_stat
-rpcb_rmtcall(nconf, host, prog, vers, proc, xdrargs, argsp,
-		xdrres, resp, tout, addr_ptr)
-	const struct netconfig *nconf;	/* Netconfig structure */
-	const char *host;			/* Remote host name */
-	rpcprog_t prog;
-	rpcvers_t vers;
-	rpcproc_t proc;			/* Remote proc identifiers */
-	xdrproc_t xdrargs, xdrres;	/* XDR routines */
-	caddr_t argsp, resp;		/* Argument and Result */
-	struct timeval tout;		/* Timeout value for this call */
-	const struct netbuf *addr_ptr;	/* Preallocated netbuf address */
+rpcb_rmtcall(
+	const struct netconfig *nconf,	/* Netconfig structure */
+	const char *host,			/* Remote host name */
+	rpcprog_t prog,
+	rpcvers_t vers,
+	rpcproc_t proc,			/* Remote proc identifiers */
+	xdrproc_t xdrargs,      /* In XDR routines */ 
+	caddr_t argsp,			/* In Argument */
+	xdrproc_t xdrres,		/* Out XDR routines */
+	caddr_t resp,			/* out Result */
+	struct timeval tout,		/* Timeout value for this call */
+	const struct netbuf *addr_ptr)	/* Preallocated netbuf address */
 {
 	CLIENT *client;
 	enum clnt_stat stat;
@@ -1285,9 +1281,7 @@ error:
  * Returns 1 if succeeds else 0.
  */
 bool_t
-rpcb_gettime(host, timep)
-	const char *host;
-	time_t *timep;
+rpcb_gettime(const char *host, time_t *timep)
 {
 	CLIENT *client = NULL;
 	void *handle;
@@ -1345,9 +1339,9 @@ rpcb_gettime(host, timep)
  * really be called because local n2a libraries are always provided.
  */
 char *
-rpcb_taddr2uaddr(nconf, taddr)
-	struct netconfig *nconf;
-	struct netbuf *taddr;
+rpcb_taddr2uaddr(
+	struct netconfig *nconf,
+	struct netbuf *taddr)
 {
 	CLIENT *client;
 	char *uaddr = NULL;
@@ -1379,9 +1373,9 @@ rpcb_taddr2uaddr(nconf, taddr)
  * really be called because local n2a libraries are always provided.
  */
 struct netbuf *
-rpcb_uaddr2taddr(nconf, uaddr)
-	struct netconfig *nconf;
-	char *uaddr;
+rpcb_uaddr2taddr(
+	struct netconfig *nconf,
+	char *uaddr)
 {
 	CLIENT *client;
 	struct netbuf *taddr;
diff --git a/src/rpcb_prot.c b/src/rpcb_prot.c
index a923c8e..809feb0 100644
--- a/src/rpcb_prot.c
+++ b/src/rpcb_prot.c
@@ -44,9 +44,9 @@
 #include "rpc_com.h"
 
 bool_t
-xdr_rpcb(xdrs, objp)
-	XDR *xdrs;
-	RPCB *objp;
+xdr_rpcb(
+	XDR *xdrs,
+	RPCB *objp)
 {
 	if (!xdr_u_int32_t(xdrs, &objp->r_prog)) {
 		return (FALSE);
@@ -90,9 +90,9 @@ xdr_rpcb(xdrs, objp)
  */
 
 bool_t
-xdr_rpcblist_ptr(xdrs, rp)
-	XDR *xdrs;
-	rpcblist_ptr *rp;
+xdr_rpcblist_ptr(
+	XDR *xdrs,
+	rpcblist_ptr *rp)
 {
 	/*
 	 * more_elements is pre-computed in case the direction is
@@ -144,9 +144,9 @@ xdr_rpcblist_ptr(xdrs, rp)
  * functionality to xdr_rpcblist_ptr().
  */
 bool_t
-xdr_rpcblist(xdrs, rp)
-	XDR *xdrs;
-	RPCBLIST **rp;
+xdr_rpcblist(
+	XDR *xdrs,
+	RPCBLIST **rp)
 {
 	bool_t	dummy;
 
@@ -156,9 +156,9 @@ xdr_rpcblist(xdrs, rp)
 
 
 bool_t
-xdr_rpcb_entry(xdrs, objp)
-	XDR *xdrs;
-	rpcb_entry *objp;
+xdr_rpcb_entry(
+	XDR *xdrs,
+	rpcb_entry *objp)
 {
 	if (!xdr_string(xdrs, &objp->r_maddr, RPC_MAXDATASIZE)) {
 		return (FALSE);
@@ -179,9 +179,9 @@ xdr_rpcb_entry(xdrs, objp)
 }
 
 bool_t
-xdr_rpcb_entry_list_ptr(xdrs, rp)
-	XDR *xdrs;
-	rpcb_entry_list_ptr *rp;
+xdr_rpcb_entry_list_ptr(
+	XDR *xdrs,
+	rpcb_entry_list_ptr *rp)
 {
 	/*
 	 * more_elements is pre-computed in case the direction is
@@ -234,9 +234,9 @@ xdr_rpcb_entry_list_ptr(xdrs, rp)
  * written for XDR_ENCODE direction only
  */
 bool_t
-xdr_rpcb_rmtcallargs(xdrs, p)
-	XDR *xdrs;
-	struct rpcb_rmtcallargs *p;
+xdr_rpcb_rmtcallargs(
+	XDR *xdrs,
+	struct rpcb_rmtcallargs *p)
 {
 	struct r_rpcb_rmtcallargs *objp =
 	    (struct r_rpcb_rmtcallargs *)(void *)p;
@@ -286,9 +286,9 @@ xdr_rpcb_rmtcallargs(xdrs, p)
  * written for XDR_DECODE direction only
  */
 bool_t
-xdr_rpcb_rmtcallres(xdrs, p)
-	XDR *xdrs;
-	struct rpcb_rmtcallres *p;
+xdr_rpcb_rmtcallres(
+	XDR *xdrs,
+	struct rpcb_rmtcallres *p)
 {
 	bool_t dummy;
 	struct r_rpcb_rmtcallres *objp = (struct r_rpcb_rmtcallres *)(void *)p;
@@ -304,9 +304,9 @@ xdr_rpcb_rmtcallres(xdrs, p)
 }
 
 bool_t
-xdr_netbuf(xdrs, objp)
-	XDR *xdrs;
-	struct netbuf *objp;
+xdr_netbuf(
+	XDR *xdrs,
+	struct netbuf *objp)
 {
 	bool_t dummy;
 
diff --git a/src/rpcb_st_xdr.c b/src/rpcb_st_xdr.c
index 28e6a48..7ee23a8 100644
--- a/src/rpcb_st_xdr.c
+++ b/src/rpcb_st_xdr.c
@@ -42,9 +42,9 @@
 /* Link list of all the stats about getport and getaddr */
 
 bool_t
-xdr_rpcbs_addrlist(xdrs, objp)
-	XDR *xdrs;
-	rpcbs_addrlist *objp;
+xdr_rpcbs_addrlist(
+	XDR *xdrs,
+	rpcbs_addrlist *objp)
 {
 
 	    if (!xdr_u_int32_t(xdrs, &objp->prog)) {
@@ -75,9 +75,9 @@ xdr_rpcbs_addrlist(xdrs, objp)
 /* Link list of all the stats about rmtcall */
 
 bool_t
-xdr_rpcbs_rmtcalllist(xdrs, objp)
-	XDR *xdrs;
-	rpcbs_rmtcalllist *objp;
+xdr_rpcbs_rmtcalllist(
+	XDR *xdrs,
+	rpcbs_rmtcalllist *objp)
 {
 	int32_t *buf;
 
@@ -188,9 +188,9 @@ xdr_rpcbs_rmtcalllist(xdrs, objp)
 }
 
 bool_t
-xdr_rpcbs_proc(xdrs, objp)
-	XDR *xdrs;
-	rpcbs_proc objp;
+xdr_rpcbs_proc(
+	XDR *xdrs,
+	rpcbs_proc objp)
 {
 	if (!xdr_vector(xdrs, (char *)(void *)objp, RPCBSTAT_HIGHPROC,
 	    sizeof (int), (xdrproc_t)xdr_int)) {
@@ -200,9 +200,9 @@ xdr_rpcbs_proc(xdrs, objp)
 }
 
 bool_t
-xdr_rpcbs_addrlist_ptr(xdrs, objp)
-	XDR *xdrs;
-	rpcbs_addrlist_ptr *objp;
+xdr_rpcbs_addrlist_ptr(
+	XDR *xdrs,
+	rpcbs_addrlist_ptr *objp)
 {
 	if (!xdr_pointer(xdrs, (char **)objp, sizeof (rpcbs_addrlist),
 			(xdrproc_t)xdr_rpcbs_addrlist)) {
@@ -212,9 +212,9 @@ xdr_rpcbs_addrlist_ptr(xdrs, objp)
 }
 
 bool_t
-xdr_rpcbs_rmtcalllist_ptr(xdrs, objp)
-	XDR *xdrs;
-	rpcbs_rmtcalllist_ptr *objp;
+xdr_rpcbs_rmtcalllist_ptr(
+	XDR *xdrs,
+	rpcbs_rmtcalllist_ptr *objp)
 {
 	if (!xdr_pointer(xdrs, (char **)objp, sizeof (rpcbs_rmtcalllist),
 			(xdrproc_t)xdr_rpcbs_rmtcalllist)) {
@@ -224,9 +224,9 @@ xdr_rpcbs_rmtcalllist_ptr(xdrs, objp)
 }
 
 bool_t
-xdr_rpcb_stat(xdrs, objp)
-	XDR *xdrs;
-	rpcb_stat *objp;
+xdr_rpcb_stat(
+	XDR *xdrs,
+	rpcb_stat *objp)
 {
 
 	if (!xdr_rpcbs_proc(xdrs, objp->info)) {
@@ -252,9 +252,9 @@ xdr_rpcb_stat(xdrs, objp)
  * being monitored.
  */
 bool_t
-xdr_rpcb_stat_byvers(xdrs, objp)
-    XDR *xdrs;
-    rpcb_stat_byvers objp;
+xdr_rpcb_stat_byvers(
+    XDR *xdrs,
+    rpcb_stat_byvers objp)
 {
 	if (!xdr_vector(xdrs, (char *)(void *)objp, RPCBVERS_STAT,
 	    sizeof (rpcb_stat), (xdrproc_t)xdr_rpcb_stat)) {
-- 
2.50.1


