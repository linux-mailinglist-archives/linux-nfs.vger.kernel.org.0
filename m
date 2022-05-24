Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B2E532082
	for <lists+linux-nfs@lfdr.de>; Tue, 24 May 2022 04:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbiEXCBL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 May 2022 22:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiEXCBI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 May 2022 22:01:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18C6F6C
        for <linux-nfs@vger.kernel.org>; Mon, 23 May 2022 19:01:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 26EA221A5D;
        Tue, 24 May 2022 02:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653357661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=msRT2Ko1lmpbuE3SlaAtCc+Tu3M4HWUHMoIF7khXb00=;
        b=Dls0/2XL2+FcfnRsWUV/yFbViesYD9pyjAgpjPl0i2yHKTUdfF1cOEff+5uiRWMTAvLKhd
        PZxvkLjlg+EinIacTfHjCQkK1WUT/Kt7KgTHSPq6JyIZtwS5yePU0Bwaxl/JbUNdGOKBYm
        foZeOdEw2ZeOoqWzhxbZGUUWQwORKug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653357661;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=msRT2Ko1lmpbuE3SlaAtCc+Tu3M4HWUHMoIF7khXb00=;
        b=hXCB41AvEfwKhax56BYucvSh6Lx6Ziu/FDglvMHEKMJCyXjlFIHYqRWLdeqRca8mIPSuFf
        zN1zkh189E23J5Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0899C13521;
        Tue, 24 May 2022 02:00:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lgdJLVs8jGJuYwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 24 May 2022 02:00:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH nfs-utils] Update autoconfig files to work with v2.71
Date:   Tue, 24 May 2022 12:00:56 +1000
Message-id: <165335765658.22265.136811943333028416@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


OpenSUSE recently updated autoconf to v2.71, and nfs-utils now doesn't
build.  This patch fixes it.  It was mostly achieved with the autoupdate
program.

I haven't updated the AC_PREREQ(), but nor have I confirmed that it
still works with v2.59.  It does seem to work with 2.69.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 aclocal/bsdsignals.m4  |  5 +--
 aclocal/kerberos5.m4   |  2 +-
 aclocal/libblkid.m4    |  5 +--
 aclocal/libsqlite3.m4  |  5 +--
 aclocal/libtirpc.m4    |  6 +--
 aclocal/nfs-utils.m4   |  5 +--
 aclocal/rpcsec_vers.m4 |  2 +-
 configure.ac           | 87 ++++++++++++++++--------------------------
 8 files changed, 45 insertions(+), 72 deletions(-)

diff --git a/aclocal/bsdsignals.m4 b/aclocal/bsdsignals.m4
index 24572aa721d6..c7b85d066006 100644
--- a/aclocal/bsdsignals.m4
+++ b/aclocal/bsdsignals.m4
@@ -2,7 +2,7 @@ dnl *********** BSD vs. POSIX signal handling **************
 AC_DEFUN([AC_BSD_SIGNALS], [
   AC_MSG_CHECKING(for BSD signal semantics)
   AC_CACHE_VAL(knfsd_cv_bsd_signals,
-    [AC_TRY_RUN([
+    [AC_RUN_IFELSE([AC_LANG_SOURCE([[
 	#include <signal.h>
 	#include <unistd.h>
 	#include <sys/wait.h>
@@ -23,8 +23,7 @@ AC_DEFUN([AC_BSD_SIGNALS], [
 		kill(getpid(), SIGHUP); kill(getpid(), SIGHUP);
 		return (counter =3D=3D 2)? 0 : 1;
 	}
-    ], knfsd_cv_bsd_signals=3Dyes, knfsd_cv_bsd_signals=3Dno,
-    [
+    ]])],[knfsd_cv_bsd_signals=3Dyes],[knfsd_cv_bsd_signals=3Dno],[
       case "$host_os" in
         *linux*) knfsd_cv_bsd_signals=3Dno;;
         *bsd*)   knfsd_cv_bsd_signals=3Dyes;;
diff --git a/aclocal/kerberos5.m4 b/aclocal/kerberos5.m4
index bf0e88bc57f4..fb9e9b4cdfad 100644
--- a/aclocal/kerberos5.m4
+++ b/aclocal/kerberos5.m4
@@ -6,7 +6,7 @@ dnl The Kerberos gssapi library will be dynamically loaded?
 AC_DEFUN([AC_KERBEROS_V5],[
   AC_MSG_CHECKING(for Kerberos v5)
   AC_ARG_WITH(krb5,
-  [AC_HELP_STRING([--with-krb5=3DDIR], [use Kerberos v5 installation in DIR]=
)],
+  [AS_HELP_STRING([--with-krb5=3DDIR], [use Kerberos v5 installation in DIR]=
)],
   [ case "$withval" in
     yes|no)
        krb5_with=3D""
diff --git a/aclocal/libblkid.m4 b/aclocal/libblkid.m4
index 10824e9f58f1..1b8884ce6bcd 100644
--- a/aclocal/libblkid.m4
+++ b/aclocal/libblkid.m4
@@ -5,15 +5,14 @@ AC_DEFUN([AC_BLKID_VERS], [
    [
     saved_LIBS=3D"$LIBS"
     LIBS=3D-lblkid
-    AC_TRY_RUN([
+    AC_RUN_IFELSE([AC_LANG_SOURCE([[
 	#include <blkid/blkid.h>
 	int main()
 	{
 		int vers =3D blkid_get_library_version(0, 0);
 		return vers >=3D 140 ? 0 : 1;
 	}
-       ], [libblkid_cv_is_recent=3Dyes], [libblkid_cv_is_recent=3Dno],
-       [libblkid_cv_is_recent=3Dunknown])
+       ]])],[libblkid_cv_is_recent=3Dyes],[libblkid_cv_is_recent=3Dno],[libb=
lkid_cv_is_recent=3Dunknown])
     LIBS=3D"$saved_LIBS"])
   AC_MSG_RESULT($libblkid_cv_is_recent)
 ])dnl
diff --git a/aclocal/libsqlite3.m4 b/aclocal/libsqlite3.m4
index 8c38993cbba8..16b8c8a1d565 100644
--- a/aclocal/libsqlite3.m4
+++ b/aclocal/libsqlite3.m4
@@ -14,7 +14,7 @@ AC_DEFUN([AC_SQLITE3_VERS], [
    [
     saved_LIBS=3D"$LIBS"
     LIBS=3D-lsqlite3
-    AC_TRY_RUN([
+    AC_RUN_IFELSE([AC_LANG_SOURCE([[
 	#include <stdio.h>
 	#include <sqlite3.h>
 	int main()
@@ -24,8 +24,7 @@ AC_DEFUN([AC_SQLITE3_VERS], [
 		return vers !=3D SQLITE_VERSION_NUMBER ||
 			vers < 3003000;
 	}
-       ], [libsqlite3_cv_is_recent=3Dyes], [libsqlite3_cv_is_recent=3Dno],
-       [libsqlite3_cv_is_recent=3Dunknown])
+       ]])],[libsqlite3_cv_is_recent=3Dyes],[libsqlite3_cv_is_recent=3Dno],[=
libsqlite3_cv_is_recent=3Dunknown])
     LIBS=3D"$saved_LIBS"])
=20
   AC_MSG_RESULT($libsqlite3_cv_is_recent)
diff --git a/aclocal/libtirpc.m4 b/aclocal/libtirpc.m4
index 27368ff24ef1..24ba42e6533c 100644
--- a/aclocal/libtirpc.m4
+++ b/aclocal/libtirpc.m4
@@ -37,7 +37,7 @@ dnl
 AC_DEFUN([AC_LIBTIRPC_OLD], [
=20
   AC_ARG_WITH([tirpcinclude],
-              [AC_HELP_STRING([--with-tirpcinclude=3DDIR],
+              [AS_HELP_STRING([--with-tirpcinclude=3DDIR],
                               [use TI-RPC headers in DIR])],
               [tirpc_header_dir=3D$withval],
               [tirpc_header_dir=3D/usr/include/tirpc])
@@ -50,8 +50,8 @@ AC_DEFUN([AC_LIBTIRPC_OLD], [
   dnl Also must have the headers installed where we expect
   dnl to look for headers; add -I compiler option if found
   AS_IF([test "$has_libtirpc" =3D "yes"],
-        [AC_CHECK_HEADERS([${tirpc_header_dir}/netconfig.h],
-                          [AC_SUBST([AM_CPPFLAGS], ["-I${tirpc_header_dir}"]=
)],
+        [AC_CHECK_HEADERS([/usr/include/tirpc/netconfig.h],
+                          [AC_SUBST([AM_CPPFLAGS], ["-I/usr/include/tirpc"])=
],
                           [has_libtirpc=3D"no"])])
=20
   dnl Now set $LIBTIRPC accordingly
diff --git a/aclocal/nfs-utils.m4 b/aclocal/nfs-utils.m4
index fae8b95fe533..5f3ab0c2b301 100644
--- a/aclocal/nfs-utils.m4
+++ b/aclocal/nfs-utils.m4
@@ -2,13 +2,12 @@ dnl *********** GNU libc 2 ***************
 AC_DEFUN([AC_GNULIBC],[
   AC_MSG_CHECKING(for GNU libc2)
   AC_CACHE_VAL(knfsd_cv_glibc2,
-  [AC_TRY_CPP([
+  [AC_PREPROC_IFELSE([AC_LANG_SOURCE([[
       #include <features.h>
       #if !defined(__GLIBC__)
       # error Nope
       #endif
-      ],
-  knfsd_cv_glibc2=3Dyes, knfsd_cv_glibc2=3Dno)])
+      ]])],[knfsd_cv_glibc2=3Dyes],[knfsd_cv_glibc2=3Dno])])
   AC_MSG_RESULT($knfsd_cv_glibc2)
   if test $knfsd_cv_glibc2 =3D yes; then
     CPPFLAGS=3D"$CPPFLAGS -D_GNU_SOURCE"
diff --git a/aclocal/rpcsec_vers.m4 b/aclocal/rpcsec_vers.m4
index 11d2f18cb241..c3c386587131 100644
--- a/aclocal/rpcsec_vers.m4
+++ b/aclocal/rpcsec_vers.m4
@@ -2,7 +2,7 @@ dnl Checks librpcsec version
 AC_DEFUN([AC_RPCSEC_VERSION], [
=20
   AC_ARG_WITH([gssglue],
-	[AC_HELP_STRING([--with-gssglue], [Use libgssglue for GSS support])])
+	[AS_HELP_STRING([--with-gssglue], [Use libgssglue for GSS support])])
   if test x"$with_gssglue" =3D x"yes"; then
     PKG_CHECK_MODULES([GSSGLUE], [libgssglue >=3D 0.3])
     AC_CHECK_LIB([gssglue], [gss_set_allowable_enctypes])
diff --git a/configure.ac b/configure.ac
index 3e1c183b6a07..f7f87e82f695 100644
--- a/configure.ac
+++ b/configure.ac
@@ -5,7 +5,7 @@ AC_CANONICAL_BUILD([])
 AC_CANONICAL_HOST([])
 AC_CONFIG_MACRO_DIR(aclocal)
 AM_INIT_AUTOMAKE
-AC_PREREQ(2.59)
+AC_PREREQ([2.59])
 AC_PREFIX_DEFAULT(/usr)
 AM_MAINTAINER_MODE
 AC_USE_SYSTEM_EXTENSIONS
@@ -14,33 +14,29 @@ dnl *****************************************************=
********
 dnl * Define the set of applicable options
 dnl *************************************************************
 AC_ARG_WITH(release,
-	[AC_HELP_STRING([--with-release=3DXXX], [set release to XXX [1]])],
+	[AS_HELP_STRING([--with-release=3DXXX],[set release to XXX [1]])],
 	RELEASE=3D$withval,
 	RELEASE=3D1)
 	AC_SUBST(RELEASE)
 AC_ARG_WITH(statedir,
-	[AC_HELP_STRING([--with-statedir=3D/foo],
-			[use state dir /foo @<:@default=3D/var/lib/nfs@:>@])],
+	[AS_HELP_STRING([--with-statedir=3D/foo],[use state dir /foo @<:@default=3D=
/var/lib/nfs@:>@])],
 	statedir=3D$withval,
 	statedir=3D/var/lib/nfs)
 	AC_SUBST(statedir)
 AC_ARG_WITH(nfsconfig,
-	[AC_HELP_STRING([--with-nfsconfig=3D/config/file],
-			[use general config file /config/file @<:@default=3D/etc/nfs.conf@:>@])],
+	[AS_HELP_STRING([--with-nfsconfig=3D/config/file],[use general config file =
/config/file @<:@default=3D/etc/nfs.conf@:>@])],
 	nfsconfig=3D$withval,
 	nfsconfig=3D/etc/nfs.conf)
 	AC_SUBST(nfsconfig)
 AC_ARG_WITH(statdpath,
-	[AC_HELP_STRING([--with-statdpath=3D/foo],
-			[define the statd state dir as /foo instead of the NFS statedir @<:@defau=
lt=3D/var/lib/nfs@:>@])],
+	[AS_HELP_STRING([--with-statdpath=3D/foo],[define the statd state dir as /f=
oo instead of the NFS statedir @<:@default=3D/var/lib/nfs@:>@])],
 	statdpath=3D$withval,
 	statdpath=3D$statedir
 	)
 	AC_SUBST(statdpath)
 AC_ARG_WITH(statduser,
-	[AC_HELP_STRING([--with-statduser=3Drpcuser],
-                        [statd to run under @<:@rpcuser or nobody@:>@]
-	)],
+	[AS_HELP_STRING([--with-statduser=3Drpcuser],[statd to run under @<:@rpcuse=
r or nobody@:>@
+	])],
 	statduser=3D$withval,
 	if test "x$cross_compiling" =3D "xno"; then
 		if grep -s '^rpcuser:' /etc/passwd > /dev/null; then
@@ -53,9 +49,8 @@ AC_ARG_WITH(statduser,
 	fi)
 	AC_SUBST(statduser)
 AC_ARG_WITH(start-statd,
-	[AC_HELP_STRING([--with-start-statd=3Dscriptname],
-			[When an nfs filesystems is mounted with locking, run this script]
-	)],
+	[AS_HELP_STRING([--with-start-statd=3Dscriptname],[When an nfs filesystems =
is mounted with locking, run this script
+	])],
 	startstatd=3D$withval,
 	startstatd=3D/usr/sbin/start-statd
 	)
@@ -63,8 +58,7 @@ AC_ARG_WITH(start-statd,
 	AC_DEFINE_UNQUOTED(START_STATD, "$startstatd", [Define this to a script whi=
ch can start statd on mount])
 unitdir=3D/usr/lib/systemd/system
 AC_ARG_WITH(systemd,
-	[AC_HELP_STRING([--with-systemd@<:@=3Dunit-dir-path@:>@],
-			[install systemd unit files @<:@Default: no, and path defaults to /usr/li=
b/systemd/system if not given@:>@])],
+	[AS_HELP_STRING([--with-systemd@<:@=3Dunit-dir-path@:>@],[install systemd u=
nit files @<:@Default: no, and path defaults to /usr/lib/systemd/system if no=
t given@:>@])],
 	if test "$withval" !=3D "no" ; then=20
 		use_systemd=3D1
 		if test "$withval" !=3D "yes" ; then=20
@@ -78,8 +72,7 @@ AC_ARG_WITH(systemd,
 	AC_SUBST(unitdir)
=20
 AC_ARG_ENABLE(nfsv4,
-	[AC_HELP_STRING([--disable-nfsv4],
-                        [disable support for NFSv4 @<:@default=3Dno@:>@])],
+	[AS_HELP_STRING([--disable-nfsv4],[disable support for NFSv4 @<:@default=3D=
no@:>@])],
 	enable_nfsv4=3D$enableval,
 	enable_nfsv4=3Dyes)
 	if test "$enable_nfsv4" =3D yes; then
@@ -93,8 +86,7 @@ AC_ARG_ENABLE(nfsv4,
 	AM_CONDITIONAL(CONFIG_NFSV4, [test "$enable_nfsv4" =3D "yes"])
=20
 AC_ARG_ENABLE(nfsv41,
-	[AC_HELP_STRING([--disable-nfsv41],
-                        [disable support for NFSv41 @<:@default=3Dno@:>@])],
+	[AS_HELP_STRING([--disable-nfsv41],[disable support for NFSv41 @<:@default=
=3Dno@:>@])],
 	enable_nfsv41=3D$enableval,
 	enable_nfsv41=3Dyes)
 	if test "$enable_nfsv41" =3D yes; then
@@ -111,8 +103,7 @@ AC_ARG_ENABLE(nfsv41,
 	AM_CONDITIONAL(CONFIG_NFSV41, [test "$enable_nfsv41" =3D "yes"])
=20
 AC_ARG_ENABLE(gss,
-	[AC_HELP_STRING([--disable-gss],
-              [disable client support for rpcsec_gss @<:@default=3Dno@:>@])],
+	[AS_HELP_STRING([--disable-gss],[disable client support for rpcsec_gss @<:@=
default=3Dno@:>@])],
 	enable_gss=3D$enableval,
 	enable_gss=3Dyes)
 	if test "$enable_gss" =3D yes; then
@@ -126,8 +117,7 @@ AC_ARG_ENABLE(gss,
 	AM_CONDITIONAL(CONFIG_GSS, [test "$enable_gss" =3D "yes"])
=20
 AC_ARG_ENABLE(svcgss,
-	[AC_HELP_STRING([--enable-svcgss],
-    [enable building svcgssd for rpcsec_gss server support @<:@default=3Dno@=
:>@])],
+	[AS_HELP_STRING([--enable-svcgss],[enable building svcgssd for rpcsec_gss s=
erver support @<:@default=3Dno@:>@])],
 	enable_svcgss=3D$enableval,
 	enable_svcgss=3Dno)
 	if test "$enable_gss" =3D yes -a "$enable_svcgss" =3D yes; then
@@ -141,12 +131,12 @@ AC_ARG_ENABLE(svcgss,
 	AM_CONDITIONAL(CONFIG_SVCGSS, [test "$enable_svcgss" =3D "yes"])
=20
 AC_ARG_ENABLE(kprefix,
-	[AC_HELP_STRING([--enable-kprefix], [install progs as rpc.knfsd etc])],
+	[AS_HELP_STRING([--enable-kprefix],[install progs as rpc.knfsd etc])],
 	test "$enableval" =3D "yes" && kprefix=3Dk,
 	kprefix=3D)
 	AC_SUBST(kprefix)
 AC_ARG_WITH(rpcgen,
-	[AC_HELP_STRING([--with-rpcgen=3Dinternal], [use internal rpcgen instead of=
 system one])],
+	[AS_HELP_STRING([--with-rpcgen=3Dinternal],[use internal rpcgen instead of =
system one])],
 	rpcgen_path=3D$withval,
 	rpcgen_path=3Dyes )
 	rpcgen_cflags=3D-Werror=3Dstrict-prototypes
@@ -166,21 +156,18 @@ AC_ARG_WITH(rpcgen,
 	AC_SUBST(RPCGEN_PATH)
 	AM_CONDITIONAL(CONFIG_RPCGEN, [test "$RPCGEN_PATH" =3D "internal"])
 AC_ARG_ENABLE(uuid,
-	[AC_HELP_STRING([--disable-uuid],=20
-		[Exclude uuid support to avoid buggy libblkid. @<:@default=3Dno@:>@])],
+	[AS_HELP_STRING([--disable-uuid],[Exclude uuid support to avoid buggy libbl=
kid. @<:@default=3Dno@:>@])],
 	if test "$enableval" =3D "yes" ; then choose_blkid=3Dyes; else choose_blkid=
=3Dno; fi,
 	choose_blkid=3Ddefault)
 AC_ARG_ENABLE(mount,
-	[AC_HELP_STRING([--disable-mount],
-		[Do not build mount.nfs and do use the util-linux mount(8) functionality. =
@<:@default=3Dno@:>@])],
+	[AS_HELP_STRING([--disable-mount],[Do not build mount.nfs and do use the ut=
il-linux mount(8) functionality. @<:@default=3Dno@:>@])],
 	enable_mount=3D$enableval,
 	enable_mount=3Dyes)
 	AM_CONDITIONAL(CONFIG_MOUNT, [test "$enable_mount" =3D "yes"])
=20
 if test "$enable_mount" =3D yes; then
 	AC_ARG_ENABLE(libmount-mount,
-		[AC_HELP_STRING([--enable-libmount-mount],
-				[Link mount.nfs with libmount @<:@default=3Dno@:>@])],
+		[AS_HELP_STRING([--enable-libmount-mount],[Link mount.nfs with libmount @<=
:@default=3Dno@:>@])],
 		enable_libmount=3D$enableval,
 		enable_libmount=3Dno)
 else
@@ -188,14 +175,12 @@ else
 fi
=20
 AC_ARG_ENABLE(sbin-override,
-	[AC_HELP_STRING([--disable-sbin-override],
-		[Don't force nfsdcltrack and mount helpers into /sbin: always honour --sbi=
ndir])],
+	[AS_HELP_STRING([--disable-sbin-override],[Don't force nfsdcltrack and moun=
t helpers into /sbin: always honour --sbindir])],
 	enable_sbin_override=3D$enableval,
 	enable_sbin_override=3Dyes)
 	AM_CONDITIONAL(CONFIG_SBIN_OVERRIDE, [test "$enable_sbin_override" =3D "yes=
"])
 AC_ARG_ENABLE(junction,
-	[AC_HELP_STRING([--enable-junction],
-			[enable support for NFS junctions @<:@default=3Dno@:>@])],
+	[AS_HELP_STRING([--enable-junction],[enable support for NFS junctions @<:@d=
efault=3Dno@:>@])],
 	enable_junction=3D$enableval,
 	enable_junction=3Dno)
 	if test "$enable_junction" =3D yes; then
@@ -207,13 +192,11 @@ AC_ARG_ENABLE(junction,
 	AM_CONDITIONAL(CONFIG_JUNCTION, [test "$enable_junction" =3D "yes" ])
=20
 AC_ARG_ENABLE(tirpc,
-	[AC_HELP_STRING([--disable-tirpc],
-			[disable use of TI-RPC library @<:@default=3Dno@:>@])],
+	[AS_HELP_STRING([--disable-tirpc],[disable use of TI-RPC library @<:@defaul=
t=3Dno@:>@])],
 	enable_tirpc=3D$enableval,
 	enable_tirpc=3Dyes)
 AC_ARG_ENABLE(ipv6,
-	[AC_HELP_STRING([--disable-ipv6],
-                        [disable support for IPv6 @<:@default=3Dno@:>@])],
+	[AS_HELP_STRING([--disable-ipv6],[disable support for IPv6 @<:@default=3Dno=
@:>@])],
 	enable_ipv6=3D$enableval,
 	enable_ipv6=3Dyes)
 	if test "$enable_ipv6" =3D yes; then
@@ -226,8 +209,7 @@ AC_ARG_ENABLE(ipv6,
=20
 if test "$enable_mount" =3D yes; then
 	AC_ARG_ENABLE(mountconfig,
-	[AC_HELP_STRING([--disable-mountconfig],
-        [disable mount to use a configuration file @<:@default=3Dno@:>@])],
+	[AS_HELP_STRING([--disable-mountconfig],[disable mount to use a configurati=
on file @<:@default=3Dno@:>@])],
 	enable_mountconfig=3D$enableval,
 	enable_mountconfig=3Dyes)
 	if test "$enable_mountconfig" =3D no; then
@@ -236,9 +218,8 @@ if test "$enable_mount" =3D yes; then
 		AC_DEFINE(MOUNT_CONFIG, 1,=20
 			[Define this if you want mount to read a configuration file])
 		AC_ARG_WITH(mountfile,
-			[AC_HELP_STRING([--with-mountfile=3Dfilename],
-			[Using filename as the NFS mount options file [/etc/nfsmounts.conf]]
-			)],
+			[AS_HELP_STRING([--with-mountfile=3Dfilename],[Using filename as the NFS =
mount options file [/etc/nfsmounts.conf]
+			])],
 		mountfile=3D$withval,
 		mountfile=3D/etc/nfsmount.conf)
 		AC_SUBST(mountfile)
@@ -252,20 +233,17 @@ else
 fi
=20
 AC_ARG_ENABLE(nfsdcld,
-	[AC_HELP_STRING([--disable-nfsdcld],
-			[disable NFSv4 clientid tracking daemon @<:@default=3Dno@:>@])],
+	[AS_HELP_STRING([--disable-nfsdcld],[disable NFSv4 clientid tracking daemon=
 @<:@default=3Dno@:>@])],
 	enable_nfsdcld=3D$enableval,
 	enable_nfsdcld=3D"yes")
=20
 AC_ARG_ENABLE(nfsdcltrack,
-	[AC_HELP_STRING([--disable-nfsdcltrack],
-			[disable NFSv4 clientid tracking programs @<:@default=3Dno@:>@])],
+	[AS_HELP_STRING([--disable-nfsdcltrack],[disable NFSv4 clientid tracking pr=
ograms @<:@default=3Dno@:>@])],
 	enable_nfsdcltrack=3D$enableval,
 	enable_nfsdcltrack=3D"yes")
=20
 AC_ARG_ENABLE(nfsv4server,
-	[AC_HELP_STRING([--enable-nfsv4server],
-			[enable support for NFSv4 only server  @<:@default=3Dno@:>@])],
+	[AS_HELP_STRING([--enable-nfsv4server],[enable support for NFSv4 only serve=
r  @<:@default=3Dno@:>@])],
 	enable_nfsv4server=3D$enableval,
 	enable_nfsv4server=3D"no")
 	if test "$enable_nfsv4server" =3D yes; then
@@ -299,7 +277,7 @@ AC_PROG_CPP
 AC_PROG_INSTALL
 AC_PROG_LN_S
 AC_PROG_MAKE_SET
-AC_PROG_LIBTOOL
+LT_INIT
 AM_PROG_CC_C_O
=20
 if test "x$cross_compiling" =3D "xno"; then
@@ -313,7 +291,6 @@ AC_SUBST(CC_FOR_BUILD)
 AC_CHECK_TOOL(AR, ar)
 AC_CHECK_TOOL(LD, ld)
=20
-AC_HEADER_STDC([])
 AC_GNULIBC
 AC_BSD_SIGNALS
=20
@@ -553,7 +530,7 @@ AC_C_INLINE
 AC_TYPE_OFF_T
 AC_TYPE_PID_T
 AC_TYPE_SIZE_T
-AC_HEADER_TIME
+
 AC_STRUCT_TM
 AC_CHECK_TYPES([struct file_handle], [], [], [[
 		#define _GNU_SOURCE
@@ -579,7 +556,7 @@ AC_HEADER_MAJOR
 AC_FUNC_MEMCMP
 #AC_FUNC_REALLOC
 AC_FUNC_SELECT_ARGTYPES
-AC_TYPE_SIGNAL
+
 AC_FUNC_STAT
 AC_FUNC_VPRINTF
 AC_CHECK_FUNCS([alarm atexit dup2 fdatasync ftruncate getcwd \
--=20
2.36.1

