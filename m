Return-Path: <linux-nfs+bounces-13733-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B66B2AC60
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 17:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2CF4E1707
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 15:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23CA2494F8;
	Mon, 18 Aug 2025 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmQ7TbLn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2666E24A078
	for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529730; cv=none; b=NS1X4BUmYFuQ1yd6ExgxYd4HtuiPzVHRI98HZpJ62pHJNlnGPY9jYeO10aGZ1tH06Sm8SJq6yR8oQHFpzpA6yeRoPPlHZ6RO7zLvRMNLSqlqpnuAlc9mBOMZDYqzQQErkHgjphXOBGwBLRLKqck+rljb9O5ovPq8Qcg1VyP6ab0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529730; c=relaxed/simple;
	bh=uR1/HhoDYeFmP5nIUboqmsdt1zeR8R/NaLExwghmLOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/R/HbBP0AbLkzKy/77Vbo2hQnctn//oYRSAbV51C1aqndxD2EoRPYIw9zIe8ClVupIAE0011D4Zg0yzFgh7DHPtrPsBwgwAzQZuHC8ymxa6soQVZ8i1sEa/xPtBhOqNIrRsQt976xi3jhcZugvDbSTSU0f6CZ4QDvSXe+KNLBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dmQ7TbLn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755529728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzuHkaiUgFOFNEV3OY/I9gEsVGOngRiBNxTVDWcdEuw=;
	b=dmQ7TbLni/tTnuj18/jRIgqfxVj7siiMXBIRahb20v2ixzFrqlmFvyTo2zVaKWvG+ykSkc
	HdANk8PcdLWbJXznUmpXzHCASnRN4Kr6yVBRkqgEDClLHTSY97lQC6zschDaEp7mAyxa+X
	rHtdMwMMgX0hg8qyPtAs+7bE+scrucQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-9v7BD60SMkGmggbY4exKRg-1; Mon,
 18 Aug 2025 11:08:46 -0400
X-MC-Unique: 9v7BD60SMkGmggbY4exKRg-1
X-Mimecast-MFC-AGG-ID: 9v7BD60SMkGmggbY4exKRg_1755529725
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB9E5197753E;
	Mon, 18 Aug 2025 15:08:45 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.22.64.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E4E830001A8;
	Mon, 18 Aug 2025 15:08:44 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 12/12] Convert old-style function definitions into modern-style definitions
Date: Mon, 18 Aug 2025 11:08:29 -0400
Message-ID: <20250818150829.1044948-13-steved@redhat.com>
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
 src/auth_time.c     | 42 +++++++++++++++++++-----------------------
 src/auth_unix.c     | 29 +++++++++++------------------
 src/authunix_prot.c |  4 +---
 3 files changed, 31 insertions(+), 44 deletions(-)

diff --git a/src/auth_time.c b/src/auth_time.c
index c21b1df..16de1aa 100644
--- a/src/auth_time.c
+++ b/src/auth_time.c
@@ -58,8 +58,7 @@
 static int saw_alarm = 0;
 
 static void
-alarm_hndler(s)
-	int	s;
+alarm_hndler(int s)
 {
 	saw_alarm = 1;
 	return;
@@ -80,12 +79,9 @@ alarm_hndler(s)
  * Turn a 'universal address' into a struct sockaddr_in.
  * Bletch.
  */
-static int uaddr_to_sockaddr(uaddr, sin)
-#ifdef foo
-	endpoint		*endpt;
-#endif
-	char			*uaddr;
-	struct sockaddr_in	*sin;
+static int uaddr_to_sockaddr(
+	char *uaddr,
+	struct sockaddr_in *sin)
 {
 	unsigned char		p_bytes[2];
 	int			i;
@@ -115,9 +111,9 @@ static int uaddr_to_sockaddr(uaddr, sin)
  * Free the strings that were strduped into the eps structure.
  */
 static void
-free_eps(eps, num)
-	endpoint	eps[];
-	int		num;
+free_eps(
+	endpoint	eps[],
+	int		num)
 {
 	int		i;
 
@@ -141,12 +137,12 @@ free_eps(eps, num)
  * structure already populated.
  */
 static nis_server *
-get_server(sin, host, srv, eps, maxep)
-	struct sockaddr_in *sin;
-	char		*host;	/* name of the time host	*/
-	nis_server	*srv;	/* nis_server struct to use.	*/
-	endpoint	eps[];	/* array of endpoints		*/
-	int		maxep;	/* max array size		*/
+get_server(
+	struct sockaddr_in *sin,
+	char		*host,	/* name of the time host	*/
+	nis_server	*srv,	/* nis_server struct to use.	*/
+	endpoint	eps[],	/* array of endpoints		*/
+	int		maxep)	/* max array size		*/
 {
 	char			hname[256];
 	int			num_ep = 0, i;
@@ -226,12 +222,12 @@ get_server(sin, host, srv, eps, maxep)
  * td = "server" - "client"
  */
 int
-__rpc_get_time_offset(td, srv, thost, uaddr, netid)
-	struct timeval	*td;	 /* Time difference			*/
-	nis_server	*srv;	 /* NIS Server description 		*/
-	char		*thost;	 /* if no server, this is the timehost	*/
-	char		**uaddr; /* known universal address		*/
-	struct sockaddr_in *netid; /* known network identifier		*/
+__rpc_get_time_offset(
+	struct timeval	*td,	 /* Time difference			*/
+	nis_server	*srv,	 /* NIS Server description 		*/
+	char		*thost,	 /* if no server, this is the timehost	*/
+	char		**uaddr, /* known universal address		*/
+	struct sockaddr_in *netid) /* known network identifier		*/
 {
 	CLIENT			*clnt; 		/* Client handle 	*/
 	endpoint		*ep,		/* useful endpoints	*/
diff --git a/src/auth_unix.c b/src/auth_unix.c
index fc2be02..78a76b6 100644
--- a/src/auth_unix.c
+++ b/src/auth_unix.c
@@ -82,12 +82,12 @@ struct audata {
  * Returns an auth handle with the given stuff in it.
  */
 AUTH *
-authunix_create(machname, uid, gid, len, aup_gids)
-	char *machname;
-	uid_t uid;
-	gid_t gid;
-	int len;
-	gid_t *aup_gids;
+authunix_create(
+	char *machname,
+	uid_t uid,
+	gid_t gid,
+	int len,
+	gid_t *aup_gids)
 {
 	struct authunix_parms aup;
 	char mymem[MAX_AUTH_BYTES];
@@ -251,16 +251,13 @@ out_err:
 
 /* ARGSUSED */
 static void
-authunix_nextverf(auth)
-	AUTH *auth;
+authunix_nextverf(AUTH *auth)
 {
 	/* no action necessary */
 }
 
 static bool_t
-authunix_marshal(auth, xdrs)
-	AUTH *auth;
-	XDR *xdrs;
+authunix_marshal(AUTH *auth, XDR *xdrs)
 {
 	struct audata *au;
 
@@ -272,9 +269,7 @@ authunix_marshal(auth, xdrs)
 }
 
 static bool_t
-authunix_validate(auth, verf)
-	AUTH *auth;
-	struct opaque_auth *verf;
+authunix_validate(AUTH *auth, struct opaque_auth *verf)
 {
 	struct audata *au;
 	XDR xdrs;
@@ -350,8 +345,7 @@ done:
 }
 
 static void
-authunix_destroy(auth)
-	AUTH *auth;
+authunix_destroy(AUTH *auth)
 {
 	struct audata *au;
 
@@ -376,8 +370,7 @@ authunix_destroy(auth)
  * sets private data, au_marshed and au_mpos
  */
 static void
-marshal_new_auth(auth)
-	AUTH *auth;
+marshal_new_auth(AUTH *auth)
 {
 	XDR	xdr_stream;
 	XDR	*xdrs = &xdr_stream;
diff --git a/src/authunix_prot.c b/src/authunix_prot.c
index 0a04336..32e6f8b 100644
--- a/src/authunix_prot.c
+++ b/src/authunix_prot.c
@@ -45,9 +45,7 @@
  * XDR for unix authentication parameters.
  */
 bool_t
-xdr_authunix_parms(xdrs, p)
-	XDR *xdrs;
-	struct authunix_parms *p;
+xdr_authunix_parms(XDR *xdrs, struct authunix_parms *p)
 {
 
 	assert(xdrs != NULL);
-- 
2.50.1


