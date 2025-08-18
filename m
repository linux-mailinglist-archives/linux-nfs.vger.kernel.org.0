Return-Path: <linux-nfs+bounces-13724-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1065B2AC35
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 17:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EA4617E97D
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 15:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1187924A046;
	Mon, 18 Aug 2025 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5JaIhK3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2195F2494F8
	for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529723; cv=none; b=Oq1uEyBqJt37KlXxsZS2GlEPe8inAcH9Ioej13q5IE7YzAo4EinLbh3687UOK+XsJC7cl6DhvoG5WSAy65t6MKqqKlJRjpj0Q3YTLvyIkDffbFk4letAsJ1qriSXWFGorrFtJI6ZsKItYD9dzm/iBq6Zzhj6IObVhrM6SaQd9wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529723; c=relaxed/simple;
	bh=bY5C9OXhWIjQl+YmHm08nIWoQ8Em4vwCgkIj1P1Adpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMcf7ihCXV8vR9P80y0l5fXHkHAR6MdRj1sUYn/KeFJgXTz40+uX+QC0APLiEwnnIvRgHqHEcNG5il5e8Vxt6X02lLSnQRPazH9AioT5Y64snX0Qqi64z9kctsr3bOokKrf4F90g1A58uUReNamWm4UdHBCyIVaX4Lh18Nug4mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h5JaIhK3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755529719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RleD0ujB8NeuvdCAsD1Bf5jN3B3l0tRvcKHUkf27tUs=;
	b=h5JaIhK3HR8O8f/kCPdTYdY1GHdOPV86Ps7VzZIYDxTw/tZJmuatf2JawmP/xwWy35DaWs
	VaHwOIKwFK6CQQpIMr4UXyjCS6MX1gEgQpcqpEDn0Q42dPTVCppcxe/IfOTsSwTZ3nswJI
	ezTIGIe5SsD95xp0wf0FpJ+Lzo+B/jc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-7n2AHUucNUybYp1aMOmwAg-1; Mon,
 18 Aug 2025 11:08:38 -0400
X-MC-Unique: 7n2AHUucNUybYp1aMOmwAg-1
X-Mimecast-MFC-AGG-ID: 7n2AHUucNUybYp1aMOmwAg_1755529717
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9145F19560B3;
	Mon, 18 Aug 2025 15:08:37 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.22.64.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D9B7330001A8;
	Mon, 18 Aug 2025 15:08:36 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 04/12] Convert old-style function definitions into modern-style definitions
Date: Mon, 18 Aug 2025 11:08:21 -0400
Message-ID: <20250818150829.1044948-5-steved@redhat.com>
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
 src/rpcdname.c |  3 +--
 src/rtime.c    | 11 +++++------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/src/rpcdname.c b/src/rpcdname.c
index 3e6a988..c3d1353 100644
--- a/src/rpcdname.c
+++ b/src/rpcdname.c
@@ -63,8 +63,7 @@ get_default_domain()
  * get rejected elsewhere in the NIS client package.
  */
 int
-__rpc_get_default_domain(domain)
-	char **domain;
+__rpc_get_default_domain(char **domain)
 {
 	if ((*domain = get_default_domain()) != 0)
 		return (0);
diff --git a/src/rtime.c b/src/rtime.c
index 29fbf0a..5bc52a8 100644
--- a/src/rtime.c
+++ b/src/rtime.c
@@ -62,10 +62,10 @@ extern int _rpc_dtablesize( void );
 static void do_close( int );
 
 int
-rtime(addrp, timep, timeout)
-	struct sockaddr_in *addrp;
-	struct timeval *timep;
-	struct timeval *timeout;
+rtime(
+	struct sockaddr_in *addrp,
+	struct timeval *timep,
+	struct timeval *timeout)
 {
 	int s;
 	struct pollfd fd;
@@ -146,8 +146,7 @@ rtime(addrp, timep, timeout)
 }
 
 static void
-do_close(s)
-	int s;
+do_close(int s)
 {
 	int save;
 
-- 
2.50.1


