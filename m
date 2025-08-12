Return-Path: <linux-nfs+bounces-13572-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19192B21C10
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 06:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271201A230BC
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 04:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56A5242930;
	Tue, 12 Aug 2025 04:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LesdMIdO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318061F09B3
	for <linux-nfs@vger.kernel.org>; Tue, 12 Aug 2025 04:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754972393; cv=none; b=aV2gdYzTDd97AqJ0P7rSfdZTGVCM8JWLTEFU/FF7AR3Gma8LpIghURd/Lbywj/oH1SSQxuYiapZj88phx7oxg0Uk9p933Nh+2PVZPlSkCVSQNm74kR/8ytd3iZq6nunIX+6A8gXpjZWwSkRMsc/2GZg362CihORekOAw++IRdC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754972393; c=relaxed/simple;
	bh=3P9zUfxwp9CP/JN/diUDTm121QR6VqUpDL0bnNFX+lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lk0kI1bEKNTetRrCE1s0277+xC1oUoPm8dPnyKSaS4Liw/oBVZflxTK6ODQeIQ/OQbqiJOKUivXhMKoWmzHjcNtSWiOezc5cFytZ5UyGhUSEeK+i3KNGW4dqrOuDFU3FwujizyZiQ9okGAxgFY+a9L+lRiuqVYnRdbgDQ3Olg0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LesdMIdO; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23ffdea3575so32743385ad.2
        for <linux-nfs@vger.kernel.org>; Mon, 11 Aug 2025 21:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754972391; x=1755577191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yJEivR5X+ZkF/tFOdvGaWwQsCXUwbe7Sc3qIr/F1TT0=;
        b=LesdMIdO2Y7tMyNnqy/P6R0zR1MneRQn82CGH24sb15j5v/qpotVAXUNP00b/Ecx8m
         qzbWhmdcay8RnCE8jrB9s04TF6b1KydIsMeCNOfAb7DxFsSw1TVaZ/ZzBvMk5mNSPoKr
         4VQIxZCParAkOwj7X0g514m+GKngr6qwdjzbZ4cs/wq7wwoQIG5TrAaVG3kgjq62sFc8
         L7azLp63dJGEUAqRiPiZprBmlZlKNDwLnrFCJfINWv7HDlDiNOCU65fbJIxIg4Pp43xw
         p+70iHgch7LHqp35UW7k8kQwNHpxBOsin1BKjra+aLbwELh6Ws4O6nLkbaVMfm6Zp4r4
         094w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754972391; x=1755577191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJEivR5X+ZkF/tFOdvGaWwQsCXUwbe7Sc3qIr/F1TT0=;
        b=IhA6x0lrmgY5IUMqKAaZ3E+ImQgizedCprzemMPFjdeiQtHzulwOsWmUC4NA3I5o+6
         Z6zFuJBsoiSa7WNU64ltsVwX0JtmT/yLWd2ttQ8qFsWE353gY0BBQZ2Ula+RDOMK4D6w
         ylXFgalB3GHCsi0iFYaKrDzWIcSwLBBXlj6Nmg0fnmbHiQtg4XfTao+MfmNcXINBE1hm
         YW6i2UST+NAlOZcV7ziWFB++Pw2xN21wmNuDtnxjt4aWpVzRBrB6KwBKZL38xSZJzVZX
         du7CaoNjXK/C6a3kuOvJwCTOfPqc12MSfz7HHsV6rUOrB/C1f2IeiYi58DmV4HJ4C62V
         eKQA==
X-Gm-Message-State: AOJu0Ywt1CUPGxh7DJ+nbvzD+i6T166jZcmJ0brbNuUyGvLvoKmNY+ci
	hS3CqdDKxMZnDjI/9QKYFwiwyTo3CQoBHELZtKHBZOCfsW7JxZZtSq7Q
X-Gm-Gg: ASbGncunen5bOPx7Is/F4VGEP9agMKbuiXItxux3bY0f6QQ5Vl1Qxo6oahPjuq5IB9I
	hLcTNu+6wNoaY9RGdDPzZd5Lr1Y1SA98ci15svt6iSuoUA1418Wf5SCDv4TydmYqmdXxJcGQ6Ft
	XwFNkObpsD7jE4+72B6k8dTjaPahsFgecM9a+hTmry/PaXCqftEmzax9lqsDynBEfQpVsUjMapY
	b3vr3ulu42NMoLkAx/smd7jlCKTBS6gVOvYww9s0+V0ItdlyYQWdRvK0A9OHVby3yPd6korKH4q
	U7pa6J84EKNRQVqqdMSGZMhXAMTmVEPrg8YgRU6ZuI3O+v+YN/HKEcWOiFBFy/KH9qrD8GfZCKP
	QvTL81ZJMdb/mMiclsaODXA==
X-Google-Smtp-Source: AGHT+IHhBZI05sdLvlulxjTyQFvoFed1pkjRc7e5Johjn8cI0BzFOJVpDpLC4LNpTPF2OJ0pjD8rHQ==
X-Received: by 2002:a17:903:3583:b0:240:3e73:6df with SMTP id d9443c01a7336-242c203d426mr178273885ad.14.1754972391202;
        Mon, 11 Aug 2025 21:19:51 -0700 (PDT)
Received: from apollo.tail3ccdd3.ts.net ([2601:646:8201:fd20::ee1b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef5970sm285414305ad.20.2025.08.11.21.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 21:19:50 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: libtirpc-devel@lists.sourceforge.net
Cc: linux-nfs@vger.kernel.org,
	Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] Add conditional version script support
Date: Mon, 11 Aug 2025 21:19:44 -0700
Message-ID: <20250812041944.2767074-1-raj.khem@gmail.com>
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
 configure.ac                          | 50 +++++++++++++++++++++++++++
 src/Makefile.am                       | 21 +++++++++--
 src/{libtirpc.map => libtirpc.map.in} | 48 +++++--------------------
 3 files changed, 77 insertions(+), 42 deletions(-)
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
index 0cef093..5f37254 100644
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

