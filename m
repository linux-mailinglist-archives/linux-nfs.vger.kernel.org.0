Return-Path: <linux-nfs+bounces-13584-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C63C5B23228
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 20:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA561AA72D0
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 18:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1D5305E08;
	Tue, 12 Aug 2025 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzTvGBmD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4631C84C7
	for <linux-nfs@vger.kernel.org>; Tue, 12 Aug 2025 18:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022096; cv=none; b=hSU428AJZxV9X8n0BoCAOKFLEf7TGYXQB488QreoqWstFCqFf7/rL6VA/i/VA/k6ugcbstIOAN/EGpsj1YqZAr/k/+7cSKC4pl5kF5aabC8R5CL1MFC0OReMPrDMKRCc7GkGUIjmgkodZaefxeRGyCXH6O5+et/lzrO35k70G38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022096; c=relaxed/simple;
	bh=vnq7kY6beKi3b3qZGPvJIoEXPGBzXU4AO7NEEoqSD7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aeJwBiJpqqWAVEPzIhbjLEmoJCudYLQ6EnqvRzUgqE/9fVtPcfWkbnJq4T8X/GUoTJHsZZV70rMTs19R6mDGbOA8GeSGxrFCe+lNUmjNgsMJFRKwTGk5Aou0D15hI1JwRt6VxU18ujv/pG6NZ1eFUnVs0CumQeHVBgIZQ5P6gmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzTvGBmD; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76bc5e68e26so5443135b3a.0
        for <linux-nfs@vger.kernel.org>; Tue, 12 Aug 2025 11:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755022093; x=1755626893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w6LbqY8XPRsF+7O83V1DzGJCuE2Pm9IgL7HhFEa3PYc=;
        b=hzTvGBmDbaDnlTuO3xfia4tPTWHA6wxUN8IuVKifKy05ILoMyOd/tACB0VZQEffQLn
         snNjCNPQU2PLubIKTYm3GQvq1DmBdzZU9Y35MNsGZN5ohbjyGZq4LM4Jpkimt7D60OAS
         7MgnCzJ5aTNNja0oNk0nGXNDtBXqwXSzdUCi0HmWDxMX+yvX/eEocDBqmUr+IfuEQY5D
         z3e0Hf9pExFuS7At/039JW/EWijG4/07t6oY0LQq4d7B8548r3grAdLzEW9ttZu7IQbV
         UR4l3ajls1JF7wFdO6FQ4ubv5a9wLhaQ1Ij4lelG+xGpyvBnrjz9wpsM+51mXgzvWYut
         +Zqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755022093; x=1755626893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w6LbqY8XPRsF+7O83V1DzGJCuE2Pm9IgL7HhFEa3PYc=;
        b=UcSTNHgqHNnhT+lVLTH0taxe/aFB7gFSSfMhHOcVvu8TzkTSkeDcDwBAQp8hSgtGU0
         uydyBbwMmF5i6ZwwZIFqctMad4hh2Nl5WgTqYSwnIthxWtX9ADJHJOY6PwVjvyX+qFMh
         U/vLoqIuS8k9SIo6uDoYogVZKBQ9bUE+ewj2LD7/R6SxUZm9NQYTxJD6TJge8s++tREZ
         N8BWfE/r8/Rqd/K4THCGjz+I2c0NsU73o+RVMoFIeRgbJxkVjdNX7CbHgQrh1Wu8vPNH
         E/AUjeXHR7feP27vsafQ5bjGPK1AYkgITIlJBN8wKRnbs/XedIXlSSD5WKEdZpedjqrF
         9H+w==
X-Gm-Message-State: AOJu0YxnTj/1wSGSs3cyXyE81sEMCO5olgN85KnT6nmJalHMFR/0HvB0
	vqi53Yj7J43QZEItsYziBLeUJOzswN8JYRCb3RrEWPAQii8zGmjG2ZKO2LRaAomD+Ts=
X-Gm-Gg: ASbGncvsOfZlL3C5eoTeGi5wHOEwtgvwsC9Rjj7miDcVl6BClJziXmX9W/jKv+JtUQd
	bCXZe2NoISH3DkRm0HfpaF/b9rFW5sVOTgSKm/MZcNgKWScejYyKjmFXajHkHb9hnifqtJkcCOf
	LqX45CgHMesfkVbE7Ikq+UI8bmxWRp2BG+Z3TruBKkxobdRtBBfB+8uw0MksTg0dCmaUfKkzvbT
	YNG/m176dDDRi5u6MpjlxbUc2JnxDyA+FnIdsTwQspSbbRfybfJZKxriiXL9JP453uznjmMGDCn
	dwnwueDONQUsVBXonDHpUVu1Zo2avs/5/8gknUyZAjSjugpJJN6HLvObmYu+5bFuHQtZ1oD2gLB
	oG24k6Q5f7PApBwF+n3Aenw==
X-Google-Smtp-Source: AGHT+IHT/BCR3d3z8L6FQtzAfefoZu0WPaMME31P44MGUQpo7wtCdVFkMlyFIlyRjl8WNgvpgUMG3g==
X-Received: by 2002:a05:6a00:8c2:b0:76b:6288:e2e7 with SMTP id d2e1a72fcca58-76e20f8fa30mr192145b3a.20.1755022093381;
        Tue, 12 Aug 2025 11:08:13 -0700 (PDT)
Received: from apollo.tail3ccdd3.ts.net ([2601:646:8201:fd20::86a5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bea205365sm25487604b3a.83.2025.08.12.11.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 11:08:12 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: libtirpc-devel@lists.sourceforge.net
Cc: linux-nfs@vger.kernel.org,
	Khem Raj <raj.khem@gmail.com>
Subject: [PATCH v3] Add conditional version script support
Date: Tue, 12 Aug 2025 11:08:09 -0700
Message-ID: <20250812180809.2182301-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds conditional symbol versioning to libtirpc, allowing
GSS-API, DES crypto, and RPC database symbols to be conditionally
included in the version script based on build configuration.

LLD is strict about undefined symbols referenced in a version script.
Some libtirpc symbols (rpcsec_gss, old DES helpers, rpc database
helpers) are optional and may not be built depending on configure
options or missing deps. GNU ld tolerated this; LLD errors out.

This change keeps the canonical symbol map in src/libtirpc.map, but
adds a make-time rule to generate a filtered copy
where names from disabled features are deleted. The lib is then linked
against the generated linker map file.

Fixes linking errors when these features are not available.

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
v2: Fix access to generated libtirpc.map when Srcdir != Builddir
v3: Fix problems where getrpcent.c was not being built with --enable-rpcdb

 configure.ac                          | 49 +++++++++++++++++++++++++++
 src/Makefile.am                       | 30 ++++++++++++----
 src/{libtirpc.map => libtirpc.map.in} | 48 +++++---------------------
 3 files changed, 80 insertions(+), 47 deletions(-)
 rename src/{libtirpc.map => libtirpc.map.in} (84%)

diff --git a/configure.ac b/configure.ac
index e813b14..e79bf59 100644
--- a/configure.ac
+++ b/configure.ac
@@ -77,6 +77,19 @@ if test "x$enable_ipv6" != xno; then
 	AC_DEFINE(INET6, 1, [Define to 1 if IPv6 is available])
 fi
 
+# RPC database support
+AC_ARG_ENABLE(rpcdb,
+    [AS_HELP_STRING([--enable-rpcdb], [Enable RPC Database support @<:@default=no@:>@])],
+    [], [enable_rpcdb=no])
+AM_CONDITIONAL(RPCDB, test "x$enable_rpcdb" = xyes)
+if test "x$enable_rpcdb" != "xno"; then
+    AC_CHECK_FUNCS([getrpcent getrpcbyname getrpcbynumber], [have_rpcdb=yes])
+
+    if test "x$have_rpcdb" = "xyes"; then
+        AC_DEFINE([RPCDB], [1], [Define if RPC database support is available])
+    fi
+fi
+
 AC_ARG_ENABLE(symvers,
 	[AS_HELP_STRING([--disable-symvers],[Disable symbol versioning @<:@default=no@:>@])],
       [],[enable_symvers=maybe])
@@ -97,6 +110,33 @@ fi
 
 AM_CONDITIONAL(SYMVERS, test "x$enable_symvers" = xyes)
 
+# Generate symbol lists for version script
+if test "x$enable_gssapi" = "xyes"; then
+    GSS_SYMBOLS="_svcauth_gss; authgss_create; authgss_create_default; authgss_free_private_data; authgss_get_private_data; authgss_service; gss_log_debug; gss_log_hexdump; gss_log_status; rpc_gss_get_error; rpc_gss_get_mech_info; rpc_gss_get_mechanisms; rpc_gss_get_principal_name; rpc_gss_get_versions; rpc_gss_qop_to_num; rpc_gss_seccreate; rpc_gss_set_callback; rpc_gss_set_defaults; rpc_gss_set_svc_name; rpc_gss_svc_max_data_length;"
+
+    GSS_SYMBOLS_031="svcauth_gss_get_principal; svcauth_gss_set_svc_name;"
+else
+    GSS_SYMBOLS=""
+    GSS_SYMBOLS_031=""
+fi
+
+if test "x$enable_authdes" = "xyes"; then
+    DES_SYMBOLS="cbc_crypt; ecb_crypt; xdr_authdes_cred; xdr_authdes_verf; xdr_rpc_gss_cred; xdr_rpc_gss_data; xdr_rpc_gss_init_args; xdr_rpc_gss_init_res;"
+else
+    DES_SYMBOLS=""
+fi
+
+if test "x$enable_rpcdb" = "xyes"; then
+    RPCDB_SYMBOLS="endrpcent; getrpcent; getrpcbynumber; getrpcbyname; setrpcent;"
+else
+    RPCDB_SYMBOLS=""
+fi
+
+AC_SUBST([GSS_SYMBOLS])
+AC_SUBST([GSS_SYMBOLS_031])
+AC_SUBST([DES_SYMBOLS])
+AC_SUBST([RPCDB_SYMBOLS])
+
 AC_CANONICAL_BUILD
 # Check for which host we are on and setup a few things
 # specifically based on the host
@@ -167,7 +207,16 @@ AC_CHECK_FUNCS([getpeereid getrpcbyname getrpcbynumber setrpcent endrpcent getrp
 AC_CHECK_TYPES(struct rpcent,,, [
       #include <netdb.h>])
 AC_CONFIG_FILES([Makefile src/Makefile man/Makefile doc/Makefile])
+AC_CONFIG_FILES([src/libtirpc.map])
 AC_CONFIG_FILES([libtirpc.pc])
 AC_OUTPUT
 
+# Configuration summary
+AC_MSG_NOTICE([
+libtirpc configuration summary:
+  GSS-API support: $enable_gssapi
+  DES crypto support: $enable_authdes
+  RPC database support: $enable_rpcdb
+  Symbol versioning: $enable_symvers
+])
 
diff --git a/src/Makefile.am b/src/Makefile.am
index 0cef093..cfda770 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -6,6 +6,9 @@
 ## anything like that.
 
 noinst_HEADERS = rpc_com.h debug.h
+EXTRA_DIST = libtirpc.map.in
+# Generated files
+BUILT_SOURCES = libtirpc.map
 
 AM_CPPFLAGS = -I$(top_srcdir)/tirpc -include config.h -DPORTMAP -DINET6 \
 		-D_GNU_SOURCE -Wall -pipe
@@ -15,10 +18,19 @@ lib_LTLIBRARIES = libtirpc.la
 libtirpc_la_LDFLAGS = @LDFLAG_NOUNDEFINED@ -no-undefined @PTHREAD_LIBS@
 libtirpc_la_LDFLAGS += -version-info @LT_VERSION_INFO@
 
+# Generate version script from template
+libtirpc.map: $(srcdir)/libtirpc.map.in
+	$(AM_V_GEN)$(SED) \
+		-e 's|@GSS_SYMBOLS@|$(GSS_SYMBOLS)|g' \
+		-e 's|@GSS_SYMBOLS_031@|$(GSS_SYMBOLS_031)|g' \
+		-e 's|@DES_SYMBOLS@|$(DES_SYMBOLS)|g' \
+		-e 's|@RPCDB_SYMBOLS@|$(RPCDB_SYMBOLS)|g' \
+		< $(srcdir)/libtirpc.map.in > $@ || rm -f $@
+
 libtirpc_la_SOURCES = auth_none.c auth_unix.c authunix_prot.c \
         binddynport.c bindresvport.c \
         clnt_bcast.c clnt_dg.c clnt_generic.c clnt_perror.c clnt_raw.c clnt_simple.c \
-        clnt_vc.c rpc_dtablesize.c getnetconfig.c getnetpath.c getrpcent.c \
+        clnt_vc.c rpc_dtablesize.c getnetconfig.c getnetpath.c \
         getrpcport.c mt_misc.c pmap_clnt.c pmap_getmaps.c pmap_getport.c \
         pmap_prot.c pmap_prot2.c pmap_rmt.c rpc_prot.c rpc_commondata.c \
         rpc_callmsg.c rpc_generic.c rpc_soc.c rpcb_clnt.c rpcb_prot.c \
@@ -34,19 +46,23 @@ endif
 libtirpc_la_SOURCES += xdr.c xdr_rec.c xdr_array.c xdr_float.c xdr_mem.c xdr_reference.c xdr_stdio.c xdr_sizeof.c
 
 if SYMVERS
-    libtirpc_la_LDFLAGS += -Wl,--version-script=$(srcdir)/libtirpc.map
+    libtirpc_la_LDFLAGS += -Wl,--version-script=$(builddir)/libtirpc.map
 endif
 
 ## Secure-RPC
 if GSS
-    libtirpc_la_SOURCES += auth_gss.c authgss_prot.c svc_auth_gss.c \
-			   rpc_gss_utils.c
-    libtirpc_la_LIBADD = $(GSSAPI_LIBS)
-    libtirpc_la_CFLAGS = -DHAVE_RPCSEC_GSS $(GSSAPI_CFLAGS)
+libtirpc_la_SOURCES += auth_gss.c authgss_prot.c svc_auth_gss.c rpc_gss_utils.c
+libtirpc_la_LIBADD = $(GSSAPI_LIBS)
+libtirpc_la_CFLAGS = -DHAVE_RPCSEC_GSS $(GSSAPI_CFLAGS)
+endif
+
+# Conditionally add RPC database sources
+if RPCDB
+libtirpc_la_SOURCES += getrpcent.c
 endif
 
 libtirpc_la_SOURCES += key_call.c key_prot_xdr.c getpublickey.c
 libtirpc_la_SOURCES += netname.c netnamer.c rpcdname.c rtime.c
 
-CLEANFILES	       = cscope.* *~
+CLEANFILES	       = cscope.* libtirpc.map *~
 DISTCLEANFILES	       = Makefile.in
diff --git a/src/libtirpc.map b/src/libtirpc.map.in
similarity index 84%
rename from src/libtirpc.map
rename to src/libtirpc.map.in
index 21d6065..6cf563b 100644
--- a/src/libtirpc.map
+++ b/src/libtirpc.map.in
@@ -34,16 +34,10 @@ TIRPC_0.3.0 {
     _svcauth_none;
     _svcauth_short;
     _svcauth_unix;
-    _svcauth_gss;
 
     # a*
     authdes_create;
     authdes_seccreate;
-    authgss_create;
-    authgss_create_default;
-    authgss_free_private_data;
-    authgss_get_private_data;
-    authgss_service;
     authnone_create;
     authunix_create;
     authunix_create_default;
@@ -54,7 +48,6 @@ TIRPC_0.3.0 {
 
     # c*
     callrpc;
-    cbc_crypt;
     clnt_broadcast;
     clnt_create;
     clnt_create_timed;
@@ -79,10 +72,8 @@ TIRPC_0.3.0 {
     clntunix_create;
 
     # e*
-    ecb_crypt;
     endnetconfig;
     endnetpath;
-    endrpcent;
 
     # f*
     freenetconfigent;
@@ -92,13 +83,7 @@ TIRPC_0.3.0 {
     getnetconfig;
     getnetconfigent;
     getnetpath;
-    getrpcent;
-    getrpcbynumber;
-    getrpcbyname;
     getrpcport;
-    gss_log_debug;
-    gss_log_hexdump;
-    gss_log_status;
 
     # n*
     nc_perror;
@@ -118,21 +103,6 @@ TIRPC_0.3.0 {
     rpc_call;
     rpc_control;
     rpc_createerr;
-    rpc_gss_get_error;
-    rpc_gss_get_mech_info;
-    rpc_gss_get_mechanisms;
-    rpc_gss_get_principal_name;
-    rpc_gss_get_versions;
-    rpc_gss_getcred;
-    rpc_gss_is_installed;
-    rpc_gss_max_data_length;
-    rpc_gss_mech_to_oid;
-    rpc_gss_qop_to_num;
-    rpc_gss_seccreate;
-    rpc_gss_set_callback;
-    rpc_gss_set_defaults;
-    rpc_gss_set_svc_name;
-    rpc_gss_svc_max_data_length;
     rpc_nullproc;
     rpc_reg;
     rpcb_getaddr;
@@ -147,7 +117,6 @@ TIRPC_0.3.0 {
     # s*
     setnetconfig;
     setnetpath;
-    setrpcent;
     svc_auth_reg;
     svc_create;
     svc_dg_create;
@@ -194,8 +163,6 @@ TIRPC_0.3.0 {
     # x*
     xdr_accepted_reply;
     xdr_array;
-    xdr_authdes_cred;
-    xdr_authdes_verf;
     xdr_authunix_parms;
     xdr_bool;
     xdr_bytes;
@@ -228,10 +195,6 @@ TIRPC_0.3.0 {
     xdr_replymsg;
     xdr_rmtcall_args;
     xdr_rmtcallres;
-    xdr_rpc_gss_cred;
-    xdr_rpc_gss_data;
-    xdr_rpc_gss_init_args;
-    xdr_rpc_gss_init_res;
     xdr_rpcb;
     xdr_rpcb_entry;
     xdr_rpcb_entry_list_ptr;
@@ -275,14 +238,20 @@ TIRPC_0.3.0 {
     xdrstdio_create;
     xprt_register;
     xprt_unregister;
+    # GSS-API symbols (conditionally included)
+@GSS_SYMBOLS@
+    # DES crypto symbols (conditionally included)
+@DES_SYMBOLS@
+    # RPC database symbols (conditionally included)
+@RPCDB_SYMBOLS@
 
   local:
     *;
 };
 
 TIRPC_0.3.1 {
-    svcauth_gss_get_principal;
-    svcauth_gss_set_svc_name;
+# GSS-API symbols (conditionally included)
+@GSS_SYMBOLS_031@
 } TIRPC_0.3.0;
 
 TIRPC_0.3.2 {
@@ -290,7 +259,6 @@ TIRPC_0.3.2 {
     getpublicandprivatekey;
     getpublickey;
     host2netname;
-    key_call_destroy;
     key_decryptsession;
     key_decryptsession_pk;
     key_encryptsession;

