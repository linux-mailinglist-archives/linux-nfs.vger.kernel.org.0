Return-Path: <linux-nfs+bounces-13730-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C40C0B2AC39
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 17:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BC4F2A30D6
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 15:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EC42475E3;
	Mon, 18 Aug 2025 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ui/pJbMX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806FE233133
	for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529728; cv=none; b=LHEiouhx4LEplLgwb6I4ygOifyFo+tXLfmkn1W6Kw/epKofAVr2fvKlEKIDUEGTJcj1GQ5lCyD5FR0QNeiY+hEX/ZVDAtKu1LpPDip/MZ6OoGOAjuYMKTBpN8QDDfR604rmq6K5rYqHp7RsMScov0vOkIQZs+zdnZg0WhtwtuyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529728; c=relaxed/simple;
	bh=WwbBntAsInaEWOVHP3mt0H1skv0RZEWCYplwAM9zaCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1O5TfhBJC89EpFhXUBxEwHtM9OoYAt2g+e9PddyyjfncThCo7t0wOOADTKq8cXb1nIgFwLYf5FBs8Kz6HbRitLug9xsyTYqXE1BWm1r+Yh15GVzhlKbdieWiH0Pd1pYbkUxCuPg6FoxGIel35WMZpVVQNi58ufcOOw6+MJvURs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ui/pJbMX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755529725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WmCskgcjBP4CD96wP31W1EwCbTJ7w08nKt+oSGi9aFo=;
	b=Ui/pJbMXYWhDt83JKXubMvgLgSdlrcq1cC1Ac8X6VWwGx9FT6jn/f6hYBw0XzQ1vLDlT7L
	7Ma0kREs9/QpLcrD4dq5XGimFd3+27YcjRxGzevWVRVdw3ll0R6k8u9lgJiMA/+YOJWDev
	MPs8qMXD57wPdnduwvzZ8ZChBNl2Mts=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-uKjv39-EOriL3pKsOLVxhw-1; Mon,
 18 Aug 2025 11:08:41 -0400
X-MC-Unique: uKjv39-EOriL3pKsOLVxhw-1
X-Mimecast-MFC-AGG-ID: uKjv39-EOriL3pKsOLVxhw_1755529720
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A727C1956096;
	Mon, 18 Aug 2025 15:08:40 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.22.64.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EB15330001A8;
	Mon, 18 Aug 2025 15:08:39 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 07/12] Convert old-style function definitions into modern-style definitions
Date: Mon, 18 Aug 2025 11:08:24 -0400
Message-ID: <20250818150829.1044948-8-steved@redhat.com>
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
 src/netname.c  | 19 +++++++++----------
 src/netnamer.c | 31 ++++++++++++++++---------------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/src/netname.c b/src/netname.c
index ea61b1a..d62fa26 100644
--- a/src/netname.c
+++ b/src/netname.c
@@ -74,8 +74,7 @@ static char *OPSYS = "unix";
  * Figure out my fully qualified network name
  */
 int
-getnetname(name)
-	char name[MAXNETNAMELEN+1];
+getnetname(char *name)
 {
 	uid_t uid;
 
@@ -92,10 +91,10 @@ getnetname(name)
  * Convert unix cred to network-name
  */
 int
-user2netname(netname, uid, domain)
-	char netname[MAXNETNAMELEN + 1];
-	const uid_t uid;
-	const char *domain;
+user2netname(
+	char *netname,
+	const uid_t uid,
+	const char *domain)
 {
 	char *dfltdom;
 
@@ -117,10 +116,10 @@ user2netname(netname, uid, domain)
  * Convert host to network-name
  */
 int
-host2netname(netname, host, domain)
-	char netname[MAXNETNAMELEN + 1];
-	const char *host;
-	const char *domain;
+host2netname(
+	char *netname,
+	const char *host,
+	const char *domain)
 {
 	char *dfltdom;
 	char hostname[MAXHOSTNAMELEN+1];
diff --git a/src/netnamer.c b/src/netnamer.c
index 6b6c8e0..862a4de 100644
--- a/src/netnamer.c
+++ b/src/netnamer.c
@@ -66,12 +66,12 @@ static int _getgroups( char *, gid_t * );
  * Convert network-name into unix credential
  */
 int
-netname2user(netname, uidp, gidp, gidlenp, gidlist)
-	char            netname[MAXNETNAMELEN + 1];
-	uid_t            *uidp;
-	gid_t            *gidp;
-	int            *gidlenp;
-	gid_t	       *gidlist;
+netname2user(
+	char            *netname,
+	uid_t            *uidp,
+	gid_t            *gidp,
+	int            *gidlenp,
+	gid_t	       *gidlist)
 {
 	char           *p;
 	int             gidlen;
@@ -148,9 +148,9 @@ netname2user(netname, uidp, gidp, gidlenp, gidlist)
  */
 
 static int
-_getgroups(uname, groups)
-	char           *uname;
-	gid_t          groups[NGROUPS];
+_getgroups(
+	char           *uname,
+	gid_t          *groups)
 {
 	gid_t           ngroups = 0;
 	struct group *grp;
@@ -187,10 +187,10 @@ toomany:
  * Convert network-name to hostname
  */
 int
-netname2host(netname, hostname, hostlen)
-	char            netname[MAXNETNAMELEN + 1];
-	char           *hostname;
-	int             hostlen;
+netname2host(
+	char            *netname,
+	char           *hostname,
+	int             hostlen)
 {
 	int             err;
 	char            valbuf[1024];
@@ -236,8 +236,9 @@ netname2host(netname, hostname, hostlen)
  * network information service.
  */
 static int
-getnetid(key, ret)
-	char           *key, *ret;
+getnetid(
+	char *key, 
+	char *ret)
 {
 	char            buf[1024];	/* big enough */
 	char           *res;
-- 
2.50.1


