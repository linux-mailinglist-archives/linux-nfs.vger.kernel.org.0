Return-Path: <linux-nfs+bounces-13728-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B7FB2AC5D
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 17:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40FD74E0953
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 15:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2E224CEE8;
	Mon, 18 Aug 2025 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlOVUagL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C76524A06A
	for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529724; cv=none; b=sPnqzzOU7bwnlsBKIeVmcRol4xJ4IvyOJUaXOhSHdya5bdvySvZojaqTBGsbPp4cGBBWBy6085QP8Ej7T6L2hSptWpa992O5JO4BqAXkC8+TdE527aCI1ABXva4RTvtcnboSn2PX8+y2XytJgKlQAN7yRzbYlAbcEBQpXDdMelU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529724; c=relaxed/simple;
	bh=vrIoLsVItoTOb7nH0w9tNMZSf5fIhHKHrIwB4mjUuoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AP5PFt256l8WfRfccJaZY5q4M+z9VW5a6XewPcQK13gzntLcvFhK0Mr0eUuN6POsopDoEZgLWUgrCfErA+omyIbxNDiyy10t+97NgNDWXeqUKXzVhpYX6lfgWVEF/gkgLpYAZ7TeT8tgepmSeB4ghyA6vMlFU077uhZn3NTYsHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PlOVUagL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755529722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CEILlEoWEY0+4hTI+xF7ktsJ+DkXQzGH9CWk4i/HENo=;
	b=PlOVUagLSFrBbeEsG13+l37iMZC56kGH870jWCGUMS9QOPw7cnoGXiTVELlSCbG81UJd+t
	pC3izZKpsvCMqzE/PuCiPu7auOskRM5EecfHPAmB4JA/iRm11rsBEqz/z4lSTKswTWBR0l
	l9+N7bbcrqX+YluX3Q2hKrgQLWacT20=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-dBeWHUX8My6EWw-fFsfRlw-1; Mon,
 18 Aug 2025 11:08:40 -0400
X-MC-Unique: dBeWHUX8My6EWw-fFsfRlw-1
X-Mimecast-MFC-AGG-ID: dBeWHUX8My6EWw-fFsfRlw_1755529719
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F5CB180047F;
	Mon, 18 Aug 2025 15:08:39 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.22.64.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E7CE130001A8;
	Mon, 18 Aug 2025 15:08:38 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 06/12] Convert old-style function definitions into modern-style definitions
Date: Mon, 18 Aug 2025 11:08:23 -0400
Message-ID: <20250818150829.1044948-7-steved@redhat.com>
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
 src/pmap_getmaps.c |  3 +--
 src/pmap_getport.c | 10 +++++-----
 src/pmap_prot.c    |  4 +---
 src/pmap_prot2.c   |  8 ++------
 src/pmap_rmt.c     | 31 +++++++++++++++++--------------
 5 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/src/pmap_getmaps.c b/src/pmap_getmaps.c
index 853f724..61e3dcf 100644
--- a/src/pmap_getmaps.c
+++ b/src/pmap_getmaps.c
@@ -60,8 +60,7 @@
  * Calls the pmap service remotely to do get the maps.
  */
 struct pmaplist *
-pmap_getmaps(address)
-	 struct sockaddr_in *address;
+pmap_getmaps(struct sockaddr_in *address)
 {
 	struct pmaplist *head = NULL;
 	int sock = -1;
diff --git a/src/pmap_getport.c b/src/pmap_getport.c
index 72853a0..7687030 100644
--- a/src/pmap_getport.c
+++ b/src/pmap_getport.c
@@ -54,11 +54,11 @@ static const struct timeval tottimeout = { 60, 0 };
  * Returns 0 if no map exists.
  */
 u_short
-pmap_getport(address, program, version, protocol)
-	struct sockaddr_in *address;
-	u_long program;
-	u_long version;
-	u_int protocol;
+pmap_getport(
+	struct sockaddr_in *address,
+	u_long program,
+	u_long version,
+	u_int protocol)
 {
 	u_short port = 0;
 	int sock = -1;
diff --git a/src/pmap_prot.c b/src/pmap_prot.c
index c0a642b..2445c65 100644
--- a/src/pmap_prot.c
+++ b/src/pmap_prot.c
@@ -41,9 +41,7 @@
 
 
 bool_t
-xdr_pmap(xdrs, regs)
-	XDR *xdrs;
-	struct pmap *regs;
+xdr_pmap(XDR *xdrs, struct pmap *regs)
 {
 
 	assert(xdrs != NULL);
diff --git a/src/pmap_prot2.c b/src/pmap_prot2.c
index 5583ff0..bbac74f 100644
--- a/src/pmap_prot2.c
+++ b/src/pmap_prot2.c
@@ -79,9 +79,7 @@
  * this sounds like a job for xdr_reference!
  */
 bool_t
-xdr_pmaplist(xdrs, rp)
-	XDR *xdrs;
-	struct pmaplist **rp;
+xdr_pmaplist(XDR *xdrs, struct pmaplist **rp)
 {
 	/*
 	 * more_elements is pre-computed in case the direction is
@@ -123,9 +121,7 @@ xdr_pmaplist(xdrs, rp)
  * functionality to xdr_pmaplist().
  */
 bool_t
-xdr_pmaplist_ptr(xdrs, rp)
-	XDR *xdrs;
-	struct pmaplist *rp;
+xdr_pmaplist_ptr(XDR *xdrs, struct pmaplist *rp)
 {
 	return xdr_pmaplist(xdrs, (struct pmaplist **)(void *)rp);
 }
diff --git a/src/pmap_rmt.c b/src/pmap_rmt.c
index 1c76114..bfa694d 100644
--- a/src/pmap_rmt.c
+++ b/src/pmap_rmt.c
@@ -69,14 +69,17 @@ static const struct timeval timeout = { 3, 0 };
  * programs to do a lookup and call in one step.
 */
 enum clnt_stat
-pmap_rmtcall(addr, prog, vers, proc, xdrargs, argsp, xdrres, resp, tout,
-    port_ptr)
-	struct sockaddr_in *addr;
-	u_long prog, vers, proc;
-	xdrproc_t xdrargs, xdrres;
-	caddr_t argsp, resp;
-	struct timeval tout;
-	u_long *port_ptr;
+pmap_rmtcall(
+	struct sockaddr_in *addr,
+	u_long prog, 
+	u_long vers, 
+	u_long proc,
+	xdrproc_t xdrargs, 
+	caddr_t argsp,
+	xdrproc_t xdrres,
+	caddr_t resp,
+	struct timeval tout,
+	u_long *port_ptr)
 {
 	int sock = -1;
 	CLIENT *client;
@@ -115,9 +118,9 @@ pmap_rmtcall(addr, prog, vers, proc, xdrargs, argsp, xdrres, resp, tout,
  * written for XDR_ENCODE direction only
  */
 bool_t
-xdr_rmtcall_args(xdrs, cap)
-	XDR *xdrs;
-	struct rmtcallargs *cap;
+xdr_rmtcall_args(
+	XDR *xdrs,
+	struct rmtcallargs *cap)
 {
 	u_int lenposition, argposition, position;
 
@@ -149,9 +152,9 @@ xdr_rmtcall_args(xdrs, cap)
  * written for XDR_DECODE direction only
  */
 bool_t
-xdr_rmtcallres(xdrs, crp)
-	XDR *xdrs;
-	struct rmtcallres *crp;
+xdr_rmtcallres(
+	XDR *xdrs,
+	struct rmtcallres *crp)
 {
 	caddr_t port_ptr;
 
-- 
2.50.1


