Return-Path: <linux-nfs+bounces-7211-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4041F9A10F4
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 19:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049EB285AD4
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 17:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB3620F5C6;
	Wed, 16 Oct 2024 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHFzFcXP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DE118BC23
	for <linux-nfs@vger.kernel.org>; Wed, 16 Oct 2024 17:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101091; cv=none; b=eMzK8xci7+ZURJh0168O3x99an+0lxAqCj6YyTWgna5PNs+SPtjzayUMchW8ObvCyq6h3gvhEc/wjlLcLD+nwVDB3F+jjpQlyr0HhC9NdmoNepPOjPGMKODppOnSLcUc9AQ2vp13FMzTIOCCW0s9uoapJo5iZP3/wHr09ohQktY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101091; c=relaxed/simple;
	bh=huz6mul38ZnYS7rHkuaQsVhVXBXZPsjEcMwBnKWclAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fgo1wBIXgRvtTiNgtNO+KW/tF86HOZMAZzoZG1fH0tAjdUHtUAoGiBuc4gLoMpixmz+oZvsDSP50aErQBdEgmGdjnjuR0Tz2sMvCvOoRC0HceXka6F0AFNEVEd0f8+N7oGkaTr4Jb/G3CopnVjqErfYBQJlfvth+hSfVDwD8g2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WHFzFcXP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729101088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l/1/Thx3W/Mo/C+jR0SOsYyZfYxBfxmy+o+NRETtE6o=;
	b=WHFzFcXP4cgtcCc57wTitTyJW/T3qAiNOXz1vKQFafofIExeAwIwnoJTRicdEI7BXT7DOp
	XWoX7tmm/BMs39u1QN0Wot5eUBQzCENK+cW57XgBUBoBBZTa5m7Zx+8y0nckpGRTR25KLO
	BGirNdYlOWNnBe3zjdspG2rXSpVeVYw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-UG85GRUlMqeVULO9ZiSSqA-1; Wed,
 16 Oct 2024 13:51:24 -0400
X-MC-Unique: UG85GRUlMqeVULO9ZiSSqA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34AF119560AD;
	Wed, 16 Oct 2024 17:51:23 +0000 (UTC)
Received: from bighat.boston.devel.redhat.com (unknown [10.22.89.39])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 79BC01955F41;
	Wed, 16 Oct 2024 17:51:22 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] configure.ac: Using autoupdate updated to the latest autoconf macros
Date: Wed, 16 Oct 2024 13:51:21 -0400
Message-ID: <20241016175121.85450-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 configure.ac | 54 +++++++++++++++++++---------------------------------
 1 file changed, 20 insertions(+), 34 deletions(-)

diff --git a/configure.ac b/configure.ac
index ee2433f..bd099ff 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,4 +1,4 @@
-AC_INIT(libtirpc, 1.3.5)
+AC_INIT([libtirpc],[1.3.5])
 AM_INIT_AUTOMAKE([silent-rules])
 AM_SILENT_RULES([yes])
 AC_CONFIG_SRCDIR([src/auth_des.c])
@@ -35,7 +35,7 @@ AC_SUBST([LT_VERSION_INFO])
 AC_CHECK_HEADER([gssapi/gssapi.h], [HAVE_GSSAPI_H=yes], [HAVE_GSSAPI_H=no])
 
 AC_ARG_ENABLE(gssapi,
-	[AC_HELP_STRING([--disable-gssapi], [Disable GSSAPI support @<:@default=no@:>@])],
+	[AS_HELP_STRING([--disable-gssapi],[Disable GSSAPI support @<:@default=no@:>@])],
       [],[enable_gssapi=yes])
 AM_CONDITIONAL(GSS, test "x$enable_gssapi" = xyes)
 
@@ -62,7 +62,7 @@ if test "x$enable_gssapi" = xyes; then
 fi
 
 AC_ARG_ENABLE(authdes,
-	[AC_HELP_STRING([--enable-authdes], [Enable AUTH_DES support @<:@default=no@:>@])],
+	[AS_HELP_STRING([--enable-authdes],[Enable AUTH_DES support @<:@default=no@:>@])],
       [],[enable_authdes=no])
 AM_CONDITIONAL(AUTHDES, test "x$enable_authdes" = xyes)
 if test "x$enable_authdes" != xno; then
@@ -70,7 +70,7 @@ if test "x$enable_authdes" != xno; then
 fi
 
 AC_ARG_ENABLE(ipv6,
-	[AC_HELP_STRING([--disable-ipv6], [Disable IPv6 support @<:@default=no@:>@])],
+	[AS_HELP_STRING([--disable-ipv6],[Disable IPv6 support @<:@default=no@:>@])],
 	[],[enable_ipv6=yes])
 AM_CONDITIONAL(INET6, test "x$enable_ipv6" != xno)
 if test "x$enable_ipv6" != xno; then
@@ -78,7 +78,7 @@ if test "x$enable_ipv6" != xno; then
 fi
 
 AC_ARG_ENABLE(symvers,
-	[AC_HELP_STRING([--disable-symvers], [Disable symbol versioning @<:@default=no@:>@])],
+	[AS_HELP_STRING([--disable-symvers],[Disable symbol versioning @<:@default=no@:>@])],
       [],[enable_symvers=maybe])
 
 if test "x$enable_symvers" = xmaybe; then
@@ -113,63 +113,48 @@ esac
 
 
 AC_MSG_CHECKING(for SOL_IP)
-AC_TRY_COMPILE([#include <netdb.h>], [
+AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <netdb.h>]], [[
     int ipproto = SOL_IP;
-], [
+]])],[
     AC_MSG_RESULT(yes)
     AC_DEFINE(HAVE_SOL_IP, 1, [Have SOL_IP])
-], [
+],[
     AC_MSG_RESULT(no)
 ])
 
 AC_MSG_CHECKING(for SOL_IPV6)
-AC_TRY_COMPILE([#include <netdb.h>], [
+AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <netdb.h>]], [[
     int ipproto = SOL_IPV6;
-], [
+]])],[
     AC_MSG_RESULT(yes)
     AC_DEFINE(HAVE_SOL_IPV6, 1, [Have SOL_IPV6])
-], [
+],[
     AC_MSG_RESULT(no)
 ])
 
 AC_MSG_CHECKING(for IPPROTO_IP)
-AC_TRY_COMPILE([#include <netinet/in.h>], [
+AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <netinet/in.h>]], [[
     int ipproto = IPPROTO_IP;
-], [
+]])],[
     AC_MSG_RESULT(yes)
     AC_DEFINE(HAVE_IPPROTO_IP, 1, [Have IPPROTO_IP])
-], [
+],[
     AC_MSG_RESULT(no)
 ])
 
 AC_MSG_CHECKING(for IPPROTO_IPV6)
-AC_TRY_COMPILE([#include <netinet/in.h>], [
+AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <netinet/in.h>]], [[
     int ipproto = IPPROTO_IPV6;
-], [
+]])],[
     AC_MSG_RESULT(yes)
     AC_DEFINE(HAVE_IPPROTO_IPV6, 1, [Have IPPROTO_IPV6])
-], [
+],[
     AC_MSG_RESULT(no)
 ])
 AC_MSG_CHECKING([for IPV6_PKTINFO])
-AC_TRY_COMPILE([#include <netdb.h>], [
-  int opt = IPV6_PKTINFO;
-], [
-  AC_MSG_RESULT([yes])
-], [
-AC_TRY_COMPILE([#define __APPLE_USE_RFC_3542
-            #include <netdb.h>], [
-  int opt = IPV6_PKTINFO;
-], [
-  AC_MSG_RESULT([yes with __APPLE_USE_RFC_3542])
-  AC_DEFINE([__APPLE_USE_RFC_3542], [1], [show IPV6_PKTINFO internals on macos])
-], [
-  AC_MSG_RESULT([no])
-])
-])
 
 AC_CONFIG_HEADERS([config.h])
-AC_PROG_LIBTOOL
+LT_INIT
 AC_HEADER_DIRENT
 AC_PREFIX_DEFAULT(/usr)
 AC_CHECK_HEADERS([arpa/inet.h fcntl.h libintl.h limits.h locale.h
@@ -182,6 +167,7 @@ AC_CHECK_FUNCS([getpeereid getrpcbyname getrpcbynumber setrpcent endrpcent getrp
 AC_CHECK_TYPES(struct rpcent,,, [
       #include <netdb.h>])
 AC_CONFIG_FILES([Makefile src/Makefile man/Makefile doc/Makefile])
-AC_OUTPUT(libtirpc.pc)
+AC_CONFIG_FILES([libtirpc.pc])
+AC_OUTPUT
 
 
-- 
2.46.2


