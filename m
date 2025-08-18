Return-Path: <linux-nfs+bounces-13729-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C04B2AC3A
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 17:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4AB717FEE5
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 15:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B640B248F77;
	Mon, 18 Aug 2025 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVwr5zw/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E2224A054
	for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529727; cv=none; b=CjUGfTMwhary504i6ET9OzBJvX7NN0TLN/pv0gIFVkRyGezdgvA0/NIoX0XPCWfqjQXWCjo2rYmBLS8+oleMgNtzinsRJSiQCQp5CKPoqygtIPjBR9E/uwzAvEABRWdyseRTIARnJ7z7UEV8vYDurGyr4JfltauvSwONCHvb8vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529727; c=relaxed/simple;
	bh=e56qtqvaKL8yAekg1GaBJuXt3qq61GZsq46u/rN8Jps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IoECY8Ui2q0Oyx5JcO+Q2/nCpjsVjFZBqBnuhErfDTf8jhAiqmE8GMji0iiCmSBl5RDw86Tc+lxu6PqCqFBysVjgbSeo7fNkC4QfdQhSphFjak9e/mzAnL4aCVS0UnT+tuDIpgz9KCYMiXUfHdYyfT6AC73fnu/ExkLCF7DBEA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVwr5zw/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755529725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QoBGAZsbL3lkJ1FEOAMexwaU+uU24VZVXrNRvNYxVrw=;
	b=AVwr5zw/KmEHENzbIebH4d/yOzi+RrRH2jnJP/b35UhK45fCy3vzmYM9Mc1KJtAJwLZ0T8
	NsLkNxNOBfwPtjK4NprWJU43yfL/6tRlU4df3DiPI3BE5dsDQvTg3RIO0vCrK6OxAGsTUw
	nePYnC+fydbpuyEU62ftSD6FAVmn3Fk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561--lhUXn1wMUS5ElMX8rqHWg-1; Mon,
 18 Aug 2025 11:08:43 -0400
X-MC-Unique: -lhUXn1wMUS5ElMX8rqHWg-1
X-Mimecast-MFC-AGG-ID: -lhUXn1wMUS5ElMX8rqHWg_1755529722
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF83C1955BE4;
	Mon, 18 Aug 2025 15:08:42 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.22.64.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 03A3E30001A8;
	Mon, 18 Aug 2025 15:08:41 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 09/12] Convert old-style function definitions into modern-style definitions
Date: Mon, 18 Aug 2025 11:08:26 -0400
Message-ID: <20250818150829.1044948-10-steved@redhat.com>
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
 src/getnetconfig.c | 24 +++++++++---------------
 src/getnetpath.c   | 12 +++++-------
 src/getpublickey.c | 20 ++++++++++----------
 src/getrpcport.c   |  8 +++++---
 4 files changed, 29 insertions(+), 35 deletions(-)

diff --git a/src/getnetconfig.c b/src/getnetconfig.c
index d547dce..58c4a5c 100644
--- a/src/getnetconfig.c
+++ b/src/getnetconfig.c
@@ -218,8 +218,7 @@ setnetconfig()
  */
 
 struct netconfig *
-getnetconfig(handlep)
-void *handlep;
+getnetconfig(void *handlep)
 {
     struct netconfig_vars *ncp = (struct netconfig_vars *)handlep;
     char *stringp;		/* tmp string pointer */
@@ -354,8 +353,7 @@ void *handlep;
  * previously).
  */
 int
-endnetconfig(handlep)
-void *handlep;
+endnetconfig(void *handlep)
 {
     struct netconfig_vars *nc_handlep = (struct netconfig_vars *)handlep;
 
@@ -417,8 +415,7 @@ void *handlep;
  */
 
 struct netconfig *
-getnetconfigent(netid)
-	const char *netid;
+getnetconfigent(const char *netid)
 {
     FILE *file;		/* NETCONFIG db's file pointer */
     char *linep;	/* holds current netconfig line */
@@ -516,8 +513,7 @@ getnetconfigent(netid)
  */
 
 void
-freenetconfigent(netconfigp)
-	struct netconfig *netconfigp;
+freenetconfigent(struct netconfig *netconfigp)
 {
     if (netconfigp != NULL) {
 	free(netconfigp->nc_netid);	/* holds all netconfigp's strings */
@@ -541,9 +537,9 @@ freenetconfigent(netconfigp)
  */
 
 static int
-parse_ncp(stringp, ncp)
-char *stringp;		/* string to parse */
-struct netconfig *ncp;	/* where to put results */
+parse_ncp(
+char *stringp,		/* string to parse */
+struct netconfig *ncp)	/* where to put results */
 {
     char    *tokenp;	/* for processing tokens */
     char    *lasts;
@@ -661,8 +657,7 @@ nc_sperror()
  * Prints a message onto standard error describing the reason for failure.
  */
 void
-nc_perror(s)
-	const char *s;
+nc_perror(const char *s)
 {
     fprintf(stderr, "%s: %s\n", s, nc_sperror());
 }
@@ -671,8 +666,7 @@ nc_perror(s)
  * Duplicates the matched netconfig buffer.
  */
 static struct netconfig *
-dup_ncp(ncp)
-struct netconfig	*ncp;
+dup_ncp(struct netconfig	*ncp)
 {
     struct netconfig	*p;
     char	*tmp;
diff --git a/src/getnetpath.c b/src/getnetpath.c
index ea1a18c..795ea26 100644
--- a/src/getnetpath.c
+++ b/src/getnetpath.c
@@ -129,8 +129,7 @@ setnetpath()
  */
 
 struct netconfig *
-getnetpath(handlep)
-    void *handlep;
+getnetpath(void *handlep)
 {
     struct netpath_vars *np_sessionp = (struct netpath_vars *)handlep;
     struct netconfig *ncp = NULL;   /* temp. holds a netconfig session */
@@ -185,8 +184,7 @@ getnetpath(handlep)
  * (e.g. if setnetpath() was not called previously.
  */
 int
-endnetpath(handlep)
-    void *handlep;
+endnetpath(void *handlep)
 {
     struct netpath_vars *np_sessionp = (struct netpath_vars *)handlep;
     struct netpath_chain *chainp, *lastp;
@@ -222,9 +220,9 @@ endnetpath(handlep)
  */
 
 char *
-_get_next_token(npp, token)
-char *npp;		/* string */
-int token;		/* char to parse string for */
+_get_next_token(
+char *npp,		/* string */
+int token)		/* char to parse string for */
 {
     char  *cp;		/* char pointer */
     char  *np;		/* netpath pointer */
diff --git a/src/getpublickey.c b/src/getpublickey.c
index 4e96c7c..9d6b58c 100644
--- a/src/getpublickey.c
+++ b/src/getpublickey.c
@@ -58,16 +58,16 @@ int (*__getpublickey_LOCAL)(const char *, char *) = 0;
  * Get somebody's public key
  */
 int
-__getpublickey_real(netname, publickey)
-	char *netname;
-	char *publickey;
+__getpublickey_real(
+	const char *netname,
+	char *publickey)
 {
 	char lookup[3 * HEXKEYBYTES];
 	char *p;
 
 	if (publickey == NULL)
 		return (0);
-	if (!getpublicandprivatekey(netname, lookup))
+	if (!getpublicandprivatekey((char *)netname, lookup))
 		return (0);
 	p = strchr(lookup, ':');
 	if (p == NULL) {
@@ -85,9 +85,9 @@ __getpublickey_real(netname, publickey)
  */
 
 int
-getpublicandprivatekey(key, ret)
-	char *key;
-	char *ret;
+getpublicandprivatekey(
+	char *key,
+	char *ret)
 {
 	char buf[1024];	/* big enough */
 	char *res;
@@ -159,9 +159,9 @@ getpublicandprivatekey(key, ret)
 	}
 }
 
-int getpublickey(netname, publickey)
-	const char *netname;
-	char *publickey;
+int getpublickey(
+	const char *netname,
+	char *publickey)
 {
 	if (__getpublickey_LOCAL != NULL)
 		return(__getpublickey_LOCAL(netname, publickey));
diff --git a/src/getrpcport.c b/src/getrpcport.c
index c28cd61..497a2a2 100644
--- a/src/getrpcport.c
+++ b/src/getrpcport.c
@@ -43,9 +43,11 @@
 #include <rpc/pmap_clnt.h>
 
 int
-getrpcport(host, prognum, versnum, proto)
-	char *host;
-	int prognum, versnum, proto;
+getrpcport(
+	char *host,
+	int prognum, 
+	int versnum, 
+	int proto)
 {
 	struct sockaddr_in addr;
 	struct hostent *hp;
-- 
2.50.1


