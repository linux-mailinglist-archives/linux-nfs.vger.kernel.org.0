Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3051D4BA0FD
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 14:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240666AbiBQNXK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Feb 2022 08:23:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238854AbiBQNXJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 08:23:09 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA91799ECF
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 05:22:52 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C33CA608898A;
        Thu, 17 Feb 2022 14:16:39 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id GlwiPVsXDZHd; Thu, 17 Feb 2022 14:16:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id F33DE608A38A;
        Thu, 17 Feb 2022 14:16:38 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 86VoNR_wcpn6; Thu, 17 Feb 2022 14:16:38 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 8A069605DEBB;
        Thu, 17 Feb 2022 14:16:38 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     david@sigma-star.at, bfields@fieldses.org,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        david.oberhollenzer@sigma-star.at, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, chris.chilvers@appsbroker.com,
        Richard Weinberger <richard@nod.at>
Subject: [RFC PATCH 2/6] exports: Implement new export option reexport=
Date:   Thu, 17 Feb 2022 14:15:27 +0100
Message-Id: <20220217131531.2890-3-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220217131531.2890-1-richard@nod.at>
References: <20220217131531.2890-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When re-exporting a NFS volume it is mandatory to specify
either a UUID or numerical fsid=3D option because nfsd is unable
to derive a identifier on its own.

For NFS cross mounts this becomes a problem because nfsd also
needs a identifier for every crossed mount.
A common workaround is stating every single subvolume in the
exports list too.
But this defeats the purpose of the crossmnt option and is tedious.

This is where the reexport=3D tries to help.
It offers various strategies to automatically derive a identifier
for NFS volumes and sub volumes.
Each have their pros and cons.

Currently three modes are implemented:

1. auto-fsidnum
   In this mode mountd/exportd will create a new numerical fsid
   for a NFS volume and subvolume. The numbers are stored in a database
   such that the server will always use the same fsid.
   The entry in the exports file allowed to skip fsid=3D entiry but
   stating a UUID is allowed, if needed.

   This mode has the obvious downside that load balancing is not
   possible since multiple re-exporting NFS servers would generate
   different ids.

2. predefined-fsidnum
   This mode works just like auto-fsidnum but does not generate ids
   for you. It helps in the load balancing case. A system administrator
   has to manually maintain the database and install it on all re-exporti=
ng
   NFS servers. If you have a massive amount of subvolumes this mode
   will help because you don't have to bloat the exports list.

3. remote-devfsid
   If this mode is selected mountd/exportd will derive an UUID from the
   re-exported NFS volume's fsid (rfc7530 section-5.8.1.9).
   No further local state is needed on the re-exporting server.
   The export list entry still needs a fsid=3D setting because while
   parsing the exports file the NFS mounts might be not there yet.
   This mode is dangerous, use only of you're absolutely sure that the
   NFS server you're re-exporting has a stable fsid. Chances are good
   that it can change.
   Since an UUID is derived, reexporting from NFSv3 to NFSv3 is not
   possible. The file handle space is too small.
   NFSv3 to NFSv4 works, though.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 support/include/nfslib.h   |  1 +
 support/nfs/Makefile.am    |  1 +
 support/nfs/exports.c      | 73 ++++++++++++++++++++++++++++++++++++++
 utils/exportfs/Makefile.am |  4 +++
 utils/mount/Makefile.am    |  6 ++++
 5 files changed, 85 insertions(+)

diff --git a/support/include/nfslib.h b/support/include/nfslib.h
index 6faba71b..0465a1ff 100644
--- a/support/include/nfslib.h
+++ b/support/include/nfslib.h
@@ -85,6 +85,7 @@ struct exportent {
 	struct sec_entry e_secinfo[SECFLAVOR_COUNT+1];
 	unsigned int	e_ttl;
 	char *		e_realpath;
+	int		e_reexport;
 };
=20
 struct rmtabent {
diff --git a/support/nfs/Makefile.am b/support/nfs/Makefile.am
index 67e3a8e1..c4357e7d 100644
--- a/support/nfs/Makefile.am
+++ b/support/nfs/Makefile.am
@@ -9,6 +9,7 @@ libnfs_la_SOURCES =3D exports.c rmtab.c xio.c rpcmisc.c r=
pcdispatch.c \
 		   svc_socket.c cacheio.c closeall.c nfs_mntent.c \
 		   svc_create.c atomicio.c strlcat.c strlcpy.c
 libnfs_la_LIBADD =3D libnfsconf.la
+libnfs_la_CPPFLAGS =3D -I$(top_srcdir)/support/reexport
=20
 libnfsconf_la_SOURCES =3D conffile.c xlog.c
=20
diff --git a/support/nfs/exports.c b/support/nfs/exports.c
index 2c8f0752..13129d68 100644
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
@@ -103,6 +104,7 @@ static void init_exportent (struct exportent *ee, int=
 fromkernel)
 	ee->e_nsqgids =3D 0;
 	ee->e_uuid =3D NULL;
 	ee->e_ttl =3D default_ttl;
+	ee->e_reexport =3D REEXP_NONE;
 }
=20
 struct exportent *
@@ -302,6 +304,26 @@ putexportent(struct exportent *ep)
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
+			case REEXP_REMOTE_DEVFSID:
+				fprintf(fp, "remote-devfsid");
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
@@ -538,6 +560,7 @@ parseopts(char *cp, struct exportent *ep, int warn, i=
nt *had_subtree_opt_ptr)
 	char 	*flname =3D efname?efname:"command line";
 	int	flline =3D efp?efp->x_line:0;
 	unsigned int active =3D 0;
+	int saw_reexport =3D 0;
=20
 	squids =3D ep->e_squids; nsquids =3D ep->e_nsquids;
 	sqgids =3D ep->e_sqgids; nsqgids =3D ep->e_nsqgids;
@@ -644,6 +667,13 @@ bad_option:
 			}
 		} else if (strncmp(opt, "fsid=3D", 5) =3D=3D 0) {
 			char *oe;
+
+			if (saw_reexport) {
+				xlog(L_ERROR, "%s:%d: 'fsid=3D' has to be after 'reexport=3D' %s\n",
+				     flname, flline, opt);
+				goto bad_option;
+			}
+
 			if (strcmp(opt+5, "root") =3D=3D 0) {
 				ep->e_fsid =3D 0;
 				setflags(NFSEXP_FSID, active, ep);
@@ -688,6 +718,49 @@ bad_option:
 			active =3D parse_flavors(opt+4, ep);
 			if (!active)
 				goto bad_option;
+		} else if (strncmp(opt, "reexport=3D", 9) =3D=3D 0) {
+#ifdef HAVE_REEXPORT_SUPPORT
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
+			} else if (strcmp(strategy, "remote-devfsid") =3D=3D 0) {
+				ep->e_reexport =3D REEXP_REMOTE_DEVFSID;
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
+#else
+			xlog(L_ERROR, "%s:%d: 'reexport=3D' not available, rebuild with --ena=
ble-reexport\n",
+			     flname, flline);
+			goto bad_option;
+#endif
 		} else {
 			xlog(L_ERROR, "%s:%d: unknown keyword \"%s\"\n",
 					flname, flline, opt);
diff --git a/utils/exportfs/Makefile.am b/utils/exportfs/Makefile.am
index 96524c72..9eabef14 100644
--- a/utils/exportfs/Makefile.am
+++ b/utils/exportfs/Makefile.am
@@ -12,4 +12,8 @@ exportfs_LDADD =3D ../../support/export/libexport.a \
 		 ../../support/misc/libmisc.a \
 		 $(LIBWRAP) $(LIBNSL) $(LIBPTHREAD)
=20
+if CONFIG_REEXPORT
+exportfs_LDADD +=3D ../../support/reexport/libreexport.a $(LIBSQLITE) -l=
rt
+endif
+
 MAINTAINERCLEANFILES =3D Makefile.in
diff --git a/utils/mount/Makefile.am b/utils/mount/Makefile.am
index 3101f7ab..f4d5b182 100644
--- a/utils/mount/Makefile.am
+++ b/utils/mount/Makefile.am
@@ -32,6 +32,12 @@ mount_nfs_LDADD =3D ../../support/nfs/libnfs.la \
 		  ../../support/misc/libmisc.a \
 		  $(LIBTIRPC)
=20
+if CONFIG_REEXPORT
+mount_nfs_LDADD +=3D ../../support/reexport/libreexport.a \
+		   $(LIBSQLITE) -lrt $(LIBPTHREAD)
+endif
+
+
 mount_nfs_SOURCES =3D $(mount_common)
=20
 if CONFIG_LIBMOUNT
--=20
2.31.1

