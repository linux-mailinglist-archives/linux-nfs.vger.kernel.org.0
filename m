Return-Path: <linux-nfs+bounces-13573-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF98B21CB8
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 07:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B834669CA
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 05:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9E11991D4;
	Tue, 12 Aug 2025 05:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DW8PpyTw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B7C1A23A0
	for <linux-nfs@vger.kernel.org>; Tue, 12 Aug 2025 05:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754975248; cv=none; b=brCAc/xBfDjPEvsCv6mJcR/r5MqlGi0zaFxY28vrO34DC6Y8j5Xu2hsYW7RMfsWGbI+8WykGbhyEJmoqNZ562f8hzWn5Lkx74RFC/BKKDhuPlpF7XJQSCz8Ji7AvdO5HabnOD+YWjYgvxEk6nH3+0aao9RkmvzcLS6Ly+Ak+N+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754975248; c=relaxed/simple;
	bh=rVg2FtVDZPWczFl3POFf557wHJLFvgb9u7DraVSiaoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J5NL9/kgLXc4P0j7+/DJ8McbUaQo40TlFNVhuLr8144DrUs8pR2eDkxCfPksPlbybC+HNO9vuXesD3RWZ162+TnR0EiAe3UTJtBwcqOdNjavSHbFBGIZxAjlFYHpzDn3tSDvdgc+V/s6YQZ6bHnls/nDY6mcNZ1Lm1vDDDn2ry0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DW8PpyTw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23ffa7b3b30so46853895ad.1
        for <linux-nfs@vger.kernel.org>; Mon, 11 Aug 2025 22:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754975246; x=1755580046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O9yjQnIWOwZSDxZg11uLNIMzLA1f7JIsD184DCpFF/0=;
        b=DW8PpyTwnbCpb6REKpJY5HW+FUXpxVsCEeJJPHhq2afxqwu0kCnflAitbW9fR5/mHB
         3HwQBuls2IqnaGMGEPReAyYJxFuPc6yaSeI9KfoOuobi9wv+GRwxwvH6N3NItFEUy4iz
         pkc/4mAFalHeUOLoWRLbLWPgl/5SxgJo0uErbN2knpIyRfL8kB31jxmpEr0+sLWy0gt2
         7RUHgcxtgHUWMCLFU9eMNxY2zU8pN74z2KyT4GHp3GqMpGCa/OHwDQVfdS8z2UUbEqMI
         mRNqf4n7w6SoMsSBV7yepo7uwpHYQm8pAjWoLBAtfUE3riD/1c7R1LQrGaLobIlZ987h
         Dv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754975246; x=1755580046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O9yjQnIWOwZSDxZg11uLNIMzLA1f7JIsD184DCpFF/0=;
        b=hSg7lrCNSzOYW3gJ38394GboIohKvNGL5MqE6klsaq3azAORWg2eFlLjZWtKIYGRU7
         RKEnAN1+tlGo9rWqapIGp7Y+ObsNmniZ4JxDtFvgtV3OXXF+ms35n3RYTFpaapBmy2Ha
         FUIX4EJwOC6uis7K6a30H/zyaV523W62jzFMgMxAfnUlcKDVNvJF8AV81+/F/jfIrQn6
         WfGIgQM8bZn1xzDHgtj6Y0rUEClpMqGKKsK45MM5Y3fhN5A2hEtGqpeMSqXjR3naFuo+
         LMZu+IhtU7vWl32EuDuvuSLPjOFqMPHpaVHehr8Ex142XIU1MC+oMredBB8ie0zGHAv8
         mNHw==
X-Gm-Message-State: AOJu0Yxv5hYd3vjpuSqr5VXcXQS4Sm3brAoFRIh62me0U0ST3BMKwV2e
	tho23b196DJ7PoM1KCo6SzYQb64XjD+K1zwDhSR0CFptZ0mjHKZ/B00j
X-Gm-Gg: ASbGnctW1p3hgMyt/ccv/ADMYntTEAwM6X0cMuaPv9d6HkZOM/h1zR6m/VuKdEj2Cr4
	jZLRmeHAO9flhqAtA16mVMEcMKug+ZT10DRuUvt6NoLWp5rVpfjIi4cl9w17iApWIBWGZrECrRL
	23Yp8PSoQ1V0vhQr+p8jNniROLCJiH/uS+HrjnDW9IDBXWE4dCn4FvaFXWdeTrxZZaLQRDddR1n
	Q2REblXS0c1YnHhOy0NHJIhNLMhfi9nQVB+QdpMMahY3+WjnWBs4YmBgCG7JLURX4vvRec8sYQV
	lf7JU6x9A/wzTIE4F5wSfejLFt8PWrVSNQpFbfxrXaeF3xBKVBsowPsZYVZXjckadX5v/VuQapo
	xRzXZxDtHQY7We4pTx5S3v4gnYhpjHKRD
X-Google-Smtp-Source: AGHT+IGjmeLhMlOd6n7wjCrLCP0HgBayGCqXfngAgtI6ABo9jEa70Q9dBnrvZbmzTZgpdXbdg5YQ9Q==
X-Received: by 2002:a17:903:19cc:b0:242:a3fc:5900 with SMTP id d9443c01a7336-242c1ffce82mr202974935ad.8.1754975245705;
        Mon, 11 Aug 2025 22:07:25 -0700 (PDT)
Received: from apollo.tail3ccdd3.ts.net ([2601:646:8201:fd20::ee1b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aabdedsm288266765ad.167.2025.08.11.22.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 22:07:25 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: libtirpc-devel@lists.sourceforge.net
Cc: linux-nfs@vger.kernel.org,
	Khem Raj <raj.khem@gmail.com>
Subject: [PATCH v2] Add conditional version script support
Date: Mon, 11 Aug 2025 22:07:22 -0700
Message-ID: <20250812050722.4033349-1-raj.khem@gmail.com>
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

 configure.ac                          | 50 +++++++++++++++++++++++++++
 src/Makefile.am                       | 23 ++++++++++--
 src/{libtirpc.map => libtirpc.map.in} | 48 +++++--------------------
 3 files changed, 78 insertions(+), 43 deletions(-)
 rename src/{libtirpc.map => libtirpc.map.in} (84%)

diff --git a/configure.ac b/configure.ac
index e813b14..e8ff741 100644
--- a/configure.ac
+++ b/configure.ac
@@ -77,6 +77,20 @@ if test "x$enable_ipv6" != xno; then
 	AC_DEFINE(INET6, 1, [Define to 1 if IPv6 is available])
 fi
 
+# RPC database support
+AC_ARG_ENABLE(rpcdb,
+    [AS_HELP_STRING([--enable-rpcdb], [Enable RPC Database support @<:@default=no@:>@])],
+    [], [enable_rpcdb=no],
+    [enable_rpcdb=auto])
+if test "x$enable_rpcdb" != "xno"; then
+    AC_CHECK_FUNCS([getrpcent getrpcbyname getrpcbynumber], [have_rpcdb=yes])
+
+    if test "x$have_rpcdb" = "xyes"; then
+        AC_DEFINE([RPCDB], [1], [Define if RPC database support is available])
+    fi
+fi
+AM_CONDITIONAL(RPCDB, test "x$enable_rpcdb" != xno)
+
 AC_ARG_ENABLE(symvers,
 	[AS_HELP_STRING([--disable-symvers],[Disable symbol versioning @<:@default=no@:>@])],
       [],[enable_symvers=maybe])
@@ -97,6 +111,33 @@ fi
 
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
@@ -167,7 +208,16 @@ AC_CHECK_FUNCS([getpeereid getrpcbyname getrpcbynumber setrpcent endrpcent getrp
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
index 0cef093..bae14ca 100644
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
@@ -34,7 +46,7 @@ endif
 libtirpc_la_SOURCES += xdr.c xdr_rec.c xdr_array.c xdr_float.c xdr_mem.c xdr_reference.c xdr_stdio.c xdr_sizeof.c
 
 if SYMVERS
-    libtirpc_la_LDFLAGS += -Wl,--version-script=$(srcdir)/libtirpc.map
+    libtirpc_la_LDFLAGS += -Wl,--version-script=$(builddir)/libtirpc.map
 endif
 
 ## Secure-RPC
@@ -45,8 +57,13 @@ if GSS
     libtirpc_la_CFLAGS = -DHAVE_RPCSEC_GSS $(GSSAPI_CFLAGS)
 endif
 
+# Conditionally add RPC database sources
+if RPCDB
+		libtirpc_la_SOURCES += getrpcent.c
+endif
+
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

