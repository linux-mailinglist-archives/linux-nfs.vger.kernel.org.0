Return-Path: <linux-nfs+bounces-13825-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7F4B2F64A
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 13:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782991CC7595
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 11:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D9C30EF9B;
	Thu, 21 Aug 2025 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LoAt9aVT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8756D30EF71
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 11:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774945; cv=none; b=LGZi+I2IYCaAqY443FW7BjHv1vn6U+O7RrfMcry+YLgkGpTCDJY+i9Y3pfTkKFKnh3xchCYd0zwxa7CPqaCmCnaai9U3HQM/Jz4PLdue8w9TLEqZUtRjKG6DFy/PG6UQQYSnRtbJrY/Z3e0XnPJDCtBl8A+uxava2/YqyDof0WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774945; c=relaxed/simple;
	bh=uR1/HhoDYeFmP5nIUboqmsdt1zeR8R/NaLExwghmLOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFrJYZvwrXoFwBploIfQmCljN+2G1umRoHAbK8yDwMFDvVN7tjP1DyKsh0e9AHscv2LAnJSkSQonDPIv0i49sQ2pFjFN+WXsqyGhiQIYmqqiJJkZlsLoUwISU00PLOR9sysjTfYPACO/GJJyEOMFW2bMp4e6CliV/j8qKe9L3RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LoAt9aVT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755774942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzuHkaiUgFOFNEV3OY/I9gEsVGOngRiBNxTVDWcdEuw=;
	b=LoAt9aVT1qVV4VPYF188XhznPclA8g0nw2taiwLSaKDjxvSprPYU4/PDuUlGAgBLHd1Svo
	lwxnPLWUQhjskVi/XXv4DNSQSqRcPVpt/76c+9LFT3fvKYRzH7ZEYILpdJ4aWN4Sd780tH
	WHpx99vbOs58CSyCmW1YAo9DZAno+/I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-CLijDnKMPfmDSsPiU1nGdA-1; Thu,
 21 Aug 2025 07:15:40 -0400
X-MC-Unique: CLijDnKMPfmDSsPiU1nGdA-1
X-Mimecast-MFC-AGG-ID: CLijDnKMPfmDSsPiU1nGdA_1755774940
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A6EB19541BF;
	Thu, 21 Aug 2025 11:15:40 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.22.80.72])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 67329197768A;
	Thu, 21 Aug 2025 11:15:39 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 12/12] Convert old-style function definitions into modern-style definitions
Date: Thu, 21 Aug 2025 07:15:23 -0400
Message-ID: <20250821111524.1379577-13-steved@redhat.com>
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


