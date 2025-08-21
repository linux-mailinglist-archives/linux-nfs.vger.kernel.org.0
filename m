Return-Path: <linux-nfs+bounces-13823-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A87B2F649
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 13:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9351CC7502
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 11:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A82E30EF86;
	Thu, 21 Aug 2025 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBmBiImb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F58D30E847
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774944; cv=none; b=a6Q7w5Cjq6Z/X3Ne+3b+1fuMYC8D7Czp+W9DrYsNRmPPe0pIVgbcu2kiwrfyXcGPon5lCT49t+e/IHt02zKXpq+bSHWnYuhox+F7Lo5qJHL1ccNAtTdUFLjiRJ9X/xTewP8QamzeUMq90o5Jz8qsl5f3KtCtZjfTHGTBiXVeuY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774944; c=relaxed/simple;
	bh=vrIoLsVItoTOb7nH0w9tNMZSf5fIhHKHrIwB4mjUuoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dc2OaWYfwqy+jP6RMrOwel7YXMKmDLufrU3SVKwmFXAjqKLwZVLCMWvx92casx5000sNPX36Lie3rh81azbWu4uNHaNZ2pZ1+B/pU9fwQGJoN6jo82R2Kf5/VB2egfBOEwGXrltlXws7UfjFxssvPZpinwXtoOHkXaNH066RMpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gBmBiImb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755774941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CEILlEoWEY0+4hTI+xF7ktsJ+DkXQzGH9CWk4i/HENo=;
	b=gBmBiImbEJeIvetxktORlxgae2pIKhwBZH2oGDVcxGS+nNhPZsgKXvBbcUsQ5HAUZIf1B8
	gWZizYrZ4eeqHFZkzilLq1p+TuhdEKBo74vPPCKCZcvr70wvSapRQsHaRDmzrbdKTRjQiZ
	eDE2ZEqIa2Hj0W3RzBaxTx47h0kqcQM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-ZS2JvSWPNT20rby07x3s9g-1; Thu,
 21 Aug 2025 07:15:38 -0400
X-MC-Unique: ZS2JvSWPNT20rby07x3s9g-1
X-Mimecast-MFC-AGG-ID: ZS2JvSWPNT20rby07x3s9g_1755774937
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0937B1805ECC;
	Thu, 21 Aug 2025 11:15:34 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.22.80.72])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 427431977689;
	Thu, 21 Aug 2025 11:15:33 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 06/12] Convert old-style function definitions into modern-style definitions
Date: Thu, 21 Aug 2025 07:15:17 -0400
Message-ID: <20250821111524.1379577-7-steved@redhat.com>
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


