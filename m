Return-Path: <linux-nfs+bounces-13259-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF3AB12C7E
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Jul 2025 23:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289C53BC510
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Jul 2025 20:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2401D5AD4;
	Sat, 26 Jul 2025 21:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTqE7GcV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9925421ADCB
	for <linux-nfs@vger.kernel.org>; Sat, 26 Jul 2025 21:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753563610; cv=none; b=E3k5TZ/xhu9tBiTbzsOp5E+qiSrz7vQFcJBfsfUFi5Gdk2K6GQBsFnqpi23iLN/oueeLMluggs4VRhi7FvnWVTt4c1lL1SbU7fsjQEX6CFisDzTWFZzCjD7vWPebth8aXSwD9KBezSjj2xQsd4JsWWTA17cUtzzQIcDHk/JxO4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753563610; c=relaxed/simple;
	bh=J4e+PMguq26rySrN8p7Jh3ZzjhierrVcY/HLFM7UkGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c0c2jAepLA5UeENCxGEWPQxBNBkaciLv5znMNkeZmjAHwftKhJLqFQg5v57YZaU3KYzKKXm36FhEHqm3dpso+elUmx22u67pngRNJEg2mA5rl44RBdMchoeFsQy4pH959EViA3FSpRPoyrR4xb9dmYMP9MVccA2Pg6WQRQju+k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CTqE7GcV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753563606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wW1xHQ323V/Odu/sPjL1A9f7bC2w/H12IN0ERvq/5l4=;
	b=CTqE7GcVyw5YIa54yeau5Ud2QgSZCdTClshFXlB4v7WCobsk7wVLE8RrNwN31jYVhd/QeP
	cScHev9Av7m2rAR+2w7Qdm5Tn7iispEaR81v4jd5ZVMxZtCoAiM+FclVxzCjIR+myppetk
	z1TkUcO30idzcxdt3/snTOyWpPFpLF0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-KfM7Y1N2OtiGCZL5Syqzqw-1; Sat,
 26 Jul 2025 17:00:04 -0400
X-MC-Unique: KfM7Y1N2OtiGCZL5Syqzqw-1
X-Mimecast-MFC-AGG-ID: KfM7Y1N2OtiGCZL5Syqzqw_1753563603
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5535D1800876;
	Sat, 26 Jul 2025 21:00:03 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.22.80.42])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B2A3219560AA;
	Sat, 26 Jul 2025 21:00:02 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] rpcinfo: Removed a number of "old-style function definition" warnings
Date: Sat, 26 Jul 2025 17:00:00 -0400
Message-ID: <20250726210000.37744-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 src/rpcinfo.c | 142 +++++++++++++++++++++-----------------------------
 1 file changed, 58 insertions(+), 84 deletions(-)

diff --git a/src/rpcinfo.c b/src/rpcinfo.c
index 006057a..c59e8b4 100644
--- a/src/rpcinfo.c
+++ b/src/rpcinfo.c
@@ -356,9 +356,7 @@ local_rpcb (rpcprog_t prog, rpcvers_t vers)
 
 #ifdef PORTMAP
 static enum clnt_stat
-ip_ping_one(client, vers)
-     CLIENT *client;
-     u_int32_t vers;
+ip_ping_one(CLIENT * client, u_int32_t vers)
 {
   struct timeval to = { .tv_sec = 10, .tv_usec = 0 };
 
@@ -376,11 +374,7 @@ ip_ping_one(client, vers)
  * version 0 calls succeeds, it tries for MAXVERS call and repeats the same.
  */
 static void
-ip_ping (portnum, proto, argc, argv)
-     u_short portnum;
-     char *proto;
-     int argc;
-     char **argv;
+ip_ping (u_short portnum, char *proto, int argc, char **argv)
 {
   CLIENT *client;
   enum clnt_stat rpc_stat;
@@ -480,9 +474,7 @@ ip_ping (portnum, proto, argc, argv)
  * Dump all the portmapper registerations
  */
 static void
-pmapdump (argc, argv)
-     int argc;
-     char **argv;
+pmapdump (int argc, char **argv)
 {
   struct pmaplist *head = NULL;
   struct timeval minutetimeout;
@@ -581,11 +573,8 @@ pmapdump (argc, argv)
  * the address using rpcb_getaddr.
  */
 CLIENT *
-ip_getclient(hostname, prognum, versnum, proto)
-     const char *hostname;
-     rpcprog_t prognum;
-     rpcvers_t versnum;
-     const char *proto;
+ip_getclient(const char *hostname, rpcprog_t prognum, 
+	rpcvers_t versnum, const char *proto)
 {
   void *handle;
   enum clnt_stat saved_stat = RPC_SUCCESS;
@@ -674,10 +663,10 @@ sa_len(struct sockaddr *sa)
  */
 
  /*ARGSUSED*/ static bool_t
-reply_proc (res, who, nconf)
-     void *res;			/* Nothing comes back */
-     struct netbuf *who;	/* Who sent us the reply */
-     struct netconfig *nconf;	/* On which transport the reply came */
+reply_proc (
+     void *res,			/* Nothing comes back */
+     struct netbuf *who,	/* Who sent us the reply */
+     struct netconfig *nconf)	/* On which transport the reply came */
 {
   char *uaddr;
   char hostbuf[NI_MAXHOST];
@@ -703,9 +692,7 @@ reply_proc (res, who, nconf)
 }
 
 static void
-brdcst (argc, argv)
-     int argc;
-     char **argv;
+brdcst (int argc, char **argv)
 {
   enum clnt_stat rpc_stat;
   u_long prognum, vers;
@@ -731,9 +718,7 @@ brdcst (argc, argv)
 }
 
 static bool_t
-add_version (rs, vers)
-     struct rpcbdump_short *rs;
-     u_long vers;
+add_version (struct rpcbdump_short *rs, u_long vers)
 {
   struct verslist *vl;
 
@@ -752,9 +737,7 @@ add_version (rs, vers)
 }
 
 static bool_t
-add_netid (rs, netid)
-     struct rpcbdump_short *rs;
-     char *netid;
+add_netid (struct rpcbdump_short *rs, char *netid)
 {
   struct netidlist *nl;
 
@@ -773,11 +756,11 @@ add_netid (rs, netid)
 }
 
 static void
-rpcbdump (dumptype, netid, argc, argv)
-     int dumptype;
-     char *netid;
-     int argc;
-     char **argv;
+rpcbdump (
+     int dumptype,
+     char *netid,
+     int argc,
+     char **argv)
 {
   rpcblist_ptr head = NULL;
   struct timeval minutetimeout;
@@ -1021,10 +1004,10 @@ error:fprintf (stderr, "rpcinfo: no memory\n");
 static char nullstring[] = "\000";
 
 static void
-rpcbaddrlist (netid, argc, argv)
-     char *netid;
-     int argc;
-     char **argv;
+rpcbaddrlist (
+     char *netid,
+     int argc,
+     char **argv)
 {
   rpcb_entry_list_ptr head = NULL;
   struct timeval minutetimeout;
@@ -1143,9 +1126,7 @@ rpcbaddrlist (netid, argc, argv)
  * monitor rpcbind
  */
 static void
-rpcbgetstat (argc, argv)
-     int argc;
-     char **argv;
+rpcbgetstat (int argc, char **argv)
 {
   rpcb_stat_byvers inf;
   struct timeval minutetimeout;
@@ -1379,10 +1360,10 @@ rpcbgetstat (argc, argv)
  * Delete registeration for this (prog, vers, netid)
  */
 static void
-deletereg (netid, argc, argv)
-     char *netid;
-     int argc;
-     char **argv;
+deletereg (
+     char *netid,
+     int argc,
+     char **argv)
 {
   struct netconfig *nconf = NULL;
 
@@ -1414,11 +1395,11 @@ deletereg (netid, argc, argv)
  * Exit if cannot create handle.
  */
 static CLIENT *
-clnt_addr_create (address, nconf, prog, vers)
-     char *address;
-     struct netconfig *nconf;
-     u_long prog;
-     u_long vers;
+clnt_addr_create (
+     char *address,
+     struct netconfig *nconf,
+     u_long prog,
+     u_long vers)
 {
   CLIENT *client;
   static struct netbuf *nbuf;
@@ -1456,11 +1437,11 @@ clnt_addr_create (address, nconf, prog, vers)
  * sent directly to the services themselves.
  */
 static void
-addrping (address, netid, argc, argv)
-     char *address;
-     char *netid;
-     int argc;
-     char **argv;
+addrping (
+     char *address,
+     char *netid,
+     int argc,
+     char **argv)
 {
   CLIENT *client;
   struct timeval to;
@@ -1583,10 +1564,10 @@ addrping (address, netid, argc, argv)
  * then sent directly to the services themselves.
  */
 static void
-progping (netid, argc, argv)
-     char *netid;
-     int argc;
-     char **argv;
+progping (
+     char *netid,
+     int argc,
+     char **argv)
 {
   CLIENT *client;
   struct timeval to;
@@ -1729,8 +1710,7 @@ usage ()
 }
 
 static u_long
-getprognum (arg)
-     char *arg;
+getprognum (char *arg)
 {
   char *strptr;
   register struct rpcent *rpc;
@@ -1761,8 +1741,7 @@ getprognum (arg)
 }
 
 static u_long
-getvers (arg)
-     char *arg;
+getvers (char *arg)
 {
   char *strptr;
   register u_long vers;
@@ -1784,10 +1763,10 @@ getvers (arg)
  * a good error message.
  */
 static int
-pstatus (client, prog, vers)
-     register CLIENT *client;
-     u_long prog;
-     u_long vers;
+pstatus (
+     register CLIENT *client,
+     u_long prog,
+     u_long vers)
 {
   struct rpc_err rpcerr;
 
@@ -1806,10 +1785,10 @@ pstatus (client, prog, vers)
 }
 
 static CLIENT *
-clnt_rpcbind_create (host, rpcbversnum, targaddr)
-     char *host;
-     int rpcbversnum;
-     struct netbuf **targaddr;
+clnt_rpcbind_create (
+     char *host,
+     int rpcbversnum,
+     struct netbuf **targaddr)
 {
   static char *tlist[3] = {
     "circuit_n", "circuit_v", "datagram_v"
@@ -1842,11 +1821,11 @@ clnt_rpcbind_create (host, rpcbversnum, targaddr)
 }
 
 static CLIENT *
-getclnthandle (host, nconf, rpcbversnum, targaddr)
-     char *host;
-     struct netconfig *nconf;
-     u_long rpcbversnum;
-     struct netbuf **targaddr;
+getclnthandle (
+     char *host,
+     struct netconfig *nconf,
+     u_long rpcbversnum,
+     struct netbuf **targaddr)
 {
   struct netbuf addr;
   struct addrinfo hints, *res;
@@ -1898,9 +1877,7 @@ getclnthandle (host, nconf, rpcbversnum, targaddr)
 }
 
 static void
-print_rmtcallstat (rtype, infp)
-     int rtype;
-     rpcb_stat *infp;
+print_rmtcallstat (int rtype, rpcb_stat *infp)
 {
   register rpcbs_rmtcalllist_ptr pr;
   struct rpcent *rpc;
@@ -1924,9 +1901,7 @@ print_rmtcallstat (rtype, infp)
 }
 
 static void
-print_getaddrstat (rtype, infp)
-     int rtype;
-     rpcb_stat *infp;
+print_getaddrstat (int rtype, rpcb_stat *infp)
 {
   rpcbs_addrlist_ptr al;
   register struct rpcent *rpc;
@@ -1945,8 +1920,7 @@ print_getaddrstat (rtype, infp)
 }
 
 static char *
-spaces (howmany)
-     int howmany;
+spaces (int howmany)
 {
   static char space_array[] =	/* 64 spaces */
     "                                                                ";
-- 
2.50.1


