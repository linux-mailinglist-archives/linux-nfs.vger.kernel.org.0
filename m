Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036A16E5D7A
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Apr 2023 11:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjDRJe1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Apr 2023 05:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjDRJeV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Apr 2023 05:34:21 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC10259CC
        for <linux-nfs@vger.kernel.org>; Tue, 18 Apr 2023 02:34:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 046BC6431C4A;
        Tue, 18 Apr 2023 11:34:14 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9PY6-9HQh7KW; Tue, 18 Apr 2023 11:34:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id F17B36431C58;
        Tue, 18 Apr 2023 11:34:12 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BBppqH7DqBGX; Tue, 18 Apr 2023 11:34:12 +0200 (CEST)
Received: from blindfold.corp.sigma-star.at (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 952AE63CC168;
        Tue, 18 Apr 2023 11:34:12 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     david@sigma-star.at, david.oberhollenzer@sigma-star.at,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com, chris.chilvers@appsbroker.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/8] Implement reexport= export option
Date:   Tue, 18 Apr 2023 11:33:44 +0200
Message-Id: <20230418093350.4550-3-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230418093350.4550-1-richard@nod.at>
References: <20230418093350.4550-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When re-exporting a NFS volume it is mandatory to specify
either a UUID or numerical fsid=3D option because nfsd is unable
to derive an identifier on its own.

For NFS cross mounts this becomes a problem because nfsd also
needs an identifier for every crossed mount.
A common workaround is stating every single subvolume in the
exports list too.
But this defeats the purpose of the crossmnt option and is tedious.

This is where the reexport=3D tries to help.
It offers various strategies to automatically derive a identifier
for NFS volumes and sub volumes.

Currently two strategies are implemented:

1. auto-fsidnum
    In this mode mountd/exportd will create a new numerical fsid
    for a NFS volume and subvolume. The numbers are stored in a database,
    via fsidd, such that the server will always use the same fsid.
    The entry in the exports file allowed to skip the fsid=3D option but
    stating a UUID is allowed, if needed.

    This mode has the obvious downside that load balancing is by default =
not
    possible since multiple re-exporting NFS servers would generate
    different ids.
    It is possible if all load balancers use the same database.
    This can be achieved by using nfs-utils' fsidd and placing it's sqlit
    database on a network share which supports file locks or by implement=
ing
    your own fsidd which is able to provide consistent fsids across multi=
ple
    re-exporting nfs servers.

2. predefined-fsidnum
    This mode works just like auto-fsidnum but does not generate ids
    for you. It helps in the load balancing case. A system administrator
    has to manually maintain the database and install it on all re-export=
ing
    NFS servers. If you have a massive amount of subvolumes this mode
    will help because you don't have to bloat the exports list.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 support/export/export.c    | 20 ++++++++++++
 support/nfs/Makefile.am    |  1 +
 support/nfs/exports.c      | 62 ++++++++++++++++++++++++++++++++++++++
 systemd/Makefile.am        |  2 ++
 utils/exportd/Makefile.am  |  4 ++-
 utils/exportfs/Makefile.am |  3 ++
 utils/exportfs/exportfs.c  | 11 +++++++
 utils/mount/Makefile.am    |  3 +-
 utils/mountd/Makefile.am   |  2 ++
 9 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/support/export/export.c b/support/export/export.c
index 03390dfc..3e48c42d 100644
--- a/support/export/export.c
+++ b/support/export/export.c
@@ -25,6 +25,7 @@
 #include "exportfs.h"
 #include "nfsd_path.h"
 #include "xlog.h"
+#include "reexport.h"
=20
 exp_hash_table exportlist[MCL_MAXTYPES] =3D {{NULL, {{NULL,NULL}, }}, };=
=20
 static int export_hash(char *);
@@ -115,6 +116,7 @@ export_read(char *fname, int ignore_hosts)
 	nfs_export		*exp;
=20
 	int volumes =3D 0;
+	int reexport_found =3D 0;
=20
 	setexportent(fname, "r");
 	while ((eep =3D getexportent(0,1)) !=3D NULL) {
@@ -126,7 +128,25 @@ export_read(char *fname, int ignore_hosts)
 		}
 		else
 			warn_duplicated_exports(exp, eep);
+
+		if (eep->e_reexport)
+			reexport_found =3D 1;
 	}
+
+	if (reexport_found) {
+		for (int i =3D 0; i < MCL_MAXTYPES; i++) {
+			for (exp =3D exportlist[i].p_head; exp; exp =3D exp->m_next) {
+				if (exp->m_export.e_reexport)
+					continue;
+
+				if (exp->m_export.e_flags & NFSEXP_FSID) {
+					xlog(L_ERROR, "When a reexport=3D option is present no manully assi=
gned numerical fsid=3D options are allowed");
+					return -1;
+				}
+			}
+		}
+	}
+
 	endexportent();
=20
 	return volumes;
diff --git a/support/nfs/Makefile.am b/support/nfs/Makefile.am
index 67e3a8e1..2e1577cc 100644
--- a/support/nfs/Makefile.am
+++ b/support/nfs/Makefile.am
@@ -9,6 +9,7 @@ libnfs_la_SOURCES =3D exports.c rmtab.c xio.c rpcmisc.c r=
pcdispatch.c \
 		   svc_socket.c cacheio.c closeall.c nfs_mntent.c \
 		   svc_create.c atomicio.c strlcat.c strlcpy.c
 libnfs_la_LIBADD =3D libnfsconf.la
+libnfs_la_CPPFLAGS =3D $(AM_CPPFLAGS) $(CPPFLAGS) -I$(top_srcdir)/suppor=
t/reexport
=20
 libnfsconf_la_SOURCES =3D conffile.c xlog.c
=20
diff --git a/support/nfs/exports.c b/support/nfs/exports.c
index da8ace3a..72e632f4 100644
--- a/support/nfs/exports.c
+++ b/support/nfs/exports.c
@@ -31,6 +31,7 @@
 #include "xlog.h"
 #include "xio.h"
 #include "pseudoflavors.h"
+#include "reexport.h"
=20
 #define EXPORT_DEFAULT_FLAGS	\
   (NFSEXP_READONLY|NFSEXP_ROOTSQUASH|NFSEXP_GATHERED_WRITES|NFSEXP_NOSUB=
TREECHECK)
@@ -104,6 +105,7 @@ static void init_exportent (struct exportent *ee, int=
 fromkernel)
 	ee->e_nsqgids =3D 0;
 	ee->e_uuid =3D NULL;
 	ee->e_ttl =3D default_ttl;
+	ee->e_reexport =3D REEXP_NONE;
 }
=20
 struct exportent *
@@ -313,6 +315,23 @@ putexportent(struct exportent *ep)
 	}
 	if (ep->e_uuid)
 		fprintf(fp, "fsid=3D%s,", ep->e_uuid);
+
+	if (ep->e_reexport) {
+		fprintf(fp, "reexport=3D");
+		switch (ep->e_reexport) {
+			case REEXP_AUTO_FSIDNUM:
+				fprintf(fp, "auto-fsidnum");
+				break;
+			case REEXP_PREDEFINED_FSIDNUM:
+				fprintf(fp, "predefined-fsidnum");
+				break;
+			default:
+				xlog(L_ERROR, "unknown reexport method %i", ep->e_reexport);
+				fprintf(fp, "none");
+		}
+		fprintf(fp, ",");
+	}
+
 	if (ep->e_mountpoint)
 		fprintf(fp, "mountpoint%s%s,",
 			ep->e_mountpoint[0]?"=3D":"", ep->e_mountpoint);
@@ -619,6 +638,7 @@ parseopts(char *cp, struct exportent *ep, int warn, i=
nt *had_subtree_opt_ptr)
 	char 	*flname =3D efname?efname:"command line";
 	int	flline =3D efp?efp->x_line:0;
 	unsigned int active =3D 0;
+	int saw_reexport =3D 0;
=20
 	squids =3D ep->e_squids; nsquids =3D ep->e_nsquids;
 	sqgids =3D ep->e_sqgids; nsqgids =3D ep->e_nsqgids;
@@ -725,6 +745,13 @@ bad_option:
 			}
 		} else if (strncmp(opt, "fsid=3D", 5) =3D=3D 0) {
 			char *oe;
+
+			if (saw_reexport) {
+				xlog(L_ERROR, "%s:%d: 'fsid=3D' has to be before 'reexport=3D' %s\n"=
,
+				     flname, flline, opt);
+				goto bad_option;
+			}
+
 			if (strcmp(opt+5, "root") =3D=3D 0) {
 				ep->e_fsid =3D 0;
 				setflags(NFSEXP_FSID, active, ep);
@@ -772,6 +799,41 @@ bad_option:
 		} else if (strncmp(opt, "xprtsec=3D", 8) =3D=3D 0) {
 			if (!parse_xprtsec(opt + 8, ep))
 				goto bad_option;
+		} else if (strncmp(opt, "reexport=3D", 9) =3D=3D 0) {
+			char *strategy =3D strchr(opt, '=3D');
+
+			if (!strategy) {
+				xlog(L_ERROR, "%s:%d: bad option %s\n",
+				     flname, flline, opt);
+				goto bad_option;
+			}
+			strategy++;
+
+			if (saw_reexport) {
+				xlog(L_ERROR, "%s:%d: only one 'reexport=3D' is allowed%s\n",
+				     flname, flline, opt);
+				goto bad_option;
+			}
+
+			if (strcmp(strategy, "auto-fsidnum") =3D=3D 0) {
+				ep->e_reexport =3D REEXP_AUTO_FSIDNUM;
+			} else if (strcmp(strategy, "predefined-fsidnum") =3D=3D 0) {
+				ep->e_reexport =3D REEXP_PREDEFINED_FSIDNUM;
+			} else if (strcmp(strategy, "none") =3D=3D 0) {
+				ep->e_reexport =3D REEXP_NONE;
+			} else {
+				xlog(L_ERROR, "%s:%d: bad option %s\n",
+				     flname, flline, strategy);
+				goto bad_option;
+			}
+
+			if (reexpdb_apply_reexport_settings(ep, flname, flline) !=3D 0)
+				goto bad_option;
+
+			if (ep->e_fsid)
+				setflags(NFSEXP_FSID, active, ep);
+
+			saw_reexport =3D 1;
 		} else {
 			xlog(L_ERROR, "%s:%d: unknown keyword \"%s\"\n",
 					flname, flline, opt);
diff --git a/systemd/Makefile.am b/systemd/Makefile.am
index 577c6a22..2e250dca 100644
--- a/systemd/Makefile.am
+++ b/systemd/Makefile.am
@@ -70,8 +70,10 @@ rpc_pipefs_generator_SOURCES =3D $(COMMON_SRCS) rpc-pi=
pefs-generator.c
 nfs_server_generator_LDADD =3D ../support/export/libexport.a \
 			     ../support/nfs/libnfs.la \
 			     ../support/misc/libmisc.a \
+			     ../support/reexport/libreexport.a \
 			     $(LIBPTHREAD)
=20
+
 rpc_pipefs_generator_LDADD =3D ../support/nfs/libnfs.la
=20
 if INSTALL_SYSTEMD
diff --git a/utils/exportd/Makefile.am b/utils/exportd/Makefile.am
index c95bdee7..83024958 100644
--- a/utils/exportd/Makefile.am
+++ b/utils/exportd/Makefile.am
@@ -16,7 +16,9 @@ exportd_SOURCES =3D exportd.c
 exportd_LDADD =3D ../../support/export/libexport.a \
 			../../support/nfs/libnfs.la \
 			../../support/misc/libmisc.a \
-			$(OPTLIBS) $(LIBBLKID) $(LIBPTHREAD) -luuid
+			../support/reexport/libreexport.a \
+			$(OPTLIBS) $(LIBBLKID) $(LIBPTHREAD) \
+			-luuid
=20
 exportd_CPPFLAGS =3D $(AM_CPPFLAGS) $(CPPFLAGS) \
 		-I$(top_srcdir)/support/export
diff --git a/utils/exportfs/Makefile.am b/utils/exportfs/Makefile.am
index 96524c72..7f8ce9fa 100644
--- a/utils/exportfs/Makefile.am
+++ b/utils/exportfs/Makefile.am
@@ -10,6 +10,9 @@ exportfs_SOURCES =3D exportfs.c
 exportfs_LDADD =3D ../../support/export/libexport.a \
 	       	 ../../support/nfs/libnfs.la \
 		 ../../support/misc/libmisc.a \
+		 ../../support/reexport/libreexport.a \
 		 $(LIBWRAP) $(LIBNSL) $(LIBPTHREAD)
=20
+exportfs_CPPFLAGS =3D $(AM_CPPFLAGS) $(CPPFLAGS) -I$(top_srcdir)/support=
/reexport
+
 MAINTAINERCLEANFILES =3D Makefile.in
diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index 37b9e4b3..b03a047b 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -38,6 +38,7 @@
 #include "exportfs.h"
 #include "xlog.h"
 #include "conffile.h"
+#include "reexport.h"
=20
 static void	export_all(int verbose);
 static void	exportfs(char *arg, char *options, int verbose);
@@ -719,6 +720,16 @@ dump(int verbose, int export_format)
 				c =3D dumpopt(c, "fsid=3D%d", ep->e_fsid);
 			if (ep->e_uuid)
 				c =3D dumpopt(c, "fsid=3D%s", ep->e_uuid);
+			if (ep->e_reexport) {
+				switch (ep->e_reexport) {
+					case REEXP_AUTO_FSIDNUM:
+						c =3D dumpopt(c, "reexport=3D%s", "auto-fsidnum");
+						break;
+					case REEXP_PREDEFINED_FSIDNUM:
+						c =3D dumpopt(c, "reexport=3D%s", "predefined-fsidnum");
+						break;
+				}
+			}
 			if (ep->e_mountpoint)
 				c =3D dumpopt(c, "mountpoint%s%s",
 					    ep->e_mountpoint[0]?"=3D":"",
diff --git a/utils/mount/Makefile.am b/utils/mount/Makefile.am
index 3101f7ab..5ff1148c 100644
--- a/utils/mount/Makefile.am
+++ b/utils/mount/Makefile.am
@@ -29,8 +29,9 @@ endif
=20
 mount_nfs_LDADD =3D ../../support/nfs/libnfs.la \
 		  ../../support/export/libexport.a \
+		  ../../support/reexport/libreexport.a \
 		  ../../support/misc/libmisc.a \
-		  $(LIBTIRPC)
+		   $(LIBTIRPC) $(LIBPTHREAD)
=20
 mount_nfs_SOURCES =3D $(mount_common)
=20
diff --git a/utils/mountd/Makefile.am b/utils/mountd/Makefile.am
index 13b25c90..197ef29b 100644
--- a/utils/mountd/Makefile.am
+++ b/utils/mountd/Makefile.am
@@ -17,9 +17,11 @@ mountd_SOURCES =3D mountd.c mount_dispatch.c rmtab.c \
 mountd_LDADD =3D ../../support/export/libexport.a \
 	       ../../support/nfs/libnfs.la \
 	       ../../support/misc/libmisc.a \
+	       ../../support/reexport/libreexport.a \
 	       $(OPTLIBS) \
 	       $(LIBBSD) $(LIBWRAP) $(LIBNSL) $(LIBBLKID) -luuid $(LIBTIRPC) \
 	       $(LIBPTHREAD)
+
 mountd_CPPFLAGS =3D $(AM_CPPFLAGS) $(CPPFLAGS) \
 		  -I$(top_builddir)/support/include \
 		  -I$(top_srcdir)/support/export
--=20
2.31.1

