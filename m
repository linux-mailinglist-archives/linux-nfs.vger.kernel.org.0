Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D58516C87
	for <lists+linux-nfs@lfdr.de>; Mon,  2 May 2022 10:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382427AbiEBIzN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 May 2022 04:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359557AbiEBIzF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 May 2022 04:55:05 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E4B13DED
        for <linux-nfs@vger.kernel.org>; Mon,  2 May 2022 01:51:33 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 709AD6081104;
        Mon,  2 May 2022 10:51:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1tChSvcnhhWD; Mon,  2 May 2022 10:51:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E7F53607198E;
        Mon,  2 May 2022 10:51:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id s9mt91i9Et8Q; Mon,  2 May 2022 10:51:28 +0200 (CEST)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 795776081105;
        Mon,  2 May 2022 10:51:28 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     david@sigma-star.at, bfields@fieldses.org,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        david.oberhollenzer@sigma-star.at, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, steved@redhat.com,
        chris.chilvers@appsbroker.com, Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/5] exports: Implement new export option reexport=
Date:   Mon,  2 May 2022 10:50:42 +0200
Message-Id: <20220502085045.13038-3-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220502085045.13038-1-richard@nod.at>
References: <20220502085045.13038-1-richard@nod.at>
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

Currently two modes are implemented:

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
	has to manually maintain the database and install it on all re-exporting
	NFS servers. If you have a massive amount of subvolumes this mode
	will help because you don't have to bloat the exports list.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 support/export/Makefile.am  |  2 ++
 support/include/nfslib.h    |  1 +
 support/nfs/Makefile.am     |  1 +
 support/nfs/exports.c       | 68 +++++++++++++++++++++++++++++++++++++
 support/reexport/reexport.c | 65 +++++++++++++++++++++++++++++++++++
 systemd/Makefile.am         |  4 +++
 utils/exportfs/Makefile.am  |  6 ++++
 utils/exportfs/exportfs.c   | 11 ++++++
 utils/exportfs/exports.man  | 31 +++++++++++++++++
 utils/mount/Makefile.am     |  7 ++++
 10 files changed, 196 insertions(+)

diff --git a/support/export/Makefile.am b/support/export/Makefile.am
index eec737f6..7338e1c7 100644
--- a/support/export/Makefile.am
+++ b/support/export/Makefile.am
@@ -14,6 +14,8 @@ libexport_a_SOURCES =3D client.c export.c hostname.c \
 		      xtab.c mount_clnt.c mount_xdr.c \
 		      cache.c auth.c v4root.c fsloc.c \
 		      v4clients.c
+libexport_a_CPPFLAGS =3D $(AM_CPPFLAGS) $(CPPFLAGS) -I$(top_srcdir)/supp=
ort/reexport
+
 BUILT_SOURCES 	=3D $(GENFILES)
=20
 noinst_HEADERS =3D mount.h
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
index 2c8f0752..bc2b1d93 100644
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
@@ -302,6 +304,23 @@ putexportent(struct exportent *ep)
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
@@ -538,6 +557,7 @@ parseopts(char *cp, struct exportent *ep, int warn, i=
nt *had_subtree_opt_ptr)
 	char 	*flname =3D efname?efname:"command line";
 	int	flline =3D efp?efp->x_line:0;
 	unsigned int active =3D 0;
+	int saw_reexport =3D 0;
=20
 	squids =3D ep->e_squids; nsquids =3D ep->e_nsquids;
 	sqgids =3D ep->e_sqgids; nsqgids =3D ep->e_nsqgids;
@@ -644,6 +664,13 @@ bad_option:
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
@@ -688,6 +715,47 @@ bad_option:
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
diff --git a/support/reexport/reexport.c b/support/reexport/reexport.c
index 5474a21f..a9529b2b 100644
--- a/support/reexport/reexport.c
+++ b/support/reexport/reexport.c
@@ -283,3 +283,68 @@ void reexpdb_uncover_subvolume(uint32_t fsidnum)
=20
 	free(path);
 }
+
+/*
+ * reexpdb_apply_reexport_settings - Apply reexport specific settings to=
 an exportent
+ *
+ * @ep: exportent to apply to
+ * @flname: Current export file, only useful for logging
+ * @flline: Current line, only useful for logging
+ *
+ * This is a helper function for applying reexport specific settings to =
an exportent.
+ * It searches a suitable fsid an sets @ep->e_fsid.
+ */
+int reexpdb_apply_reexport_settings(struct exportent *ep, char *flname, =
int flline)
+{
+	uint32_t fsidnum;
+	int found;
+	int ret =3D 0;
+
+	if (ep->e_reexport =3D=3D REEXP_NONE)
+		goto out;
+
+	if (ep->e_uuid)
+		goto out;
+
+	/*
+	 * We do a lazy database init because we want to init the db only
+	 * when at least one reexport=3D option is present.
+	 */
+	if (reexpdb_init() !=3D 0) {
+		ret =3D -1;
+		goto out;
+	}
+
+	found =3D reexpdb_fsidnum_by_path(ep->e_path, &fsidnum, 0);
+	if (!found) {
+		if (ep->e_reexport =3D=3D REEXP_AUTO_FSIDNUM) {
+			found =3D reexpdb_fsidnum_by_path(ep->e_path, &fsidnum, 1);
+			if (!found) {
+				xlog(L_ERROR, "%s:%i: Unable to generate fsid for %s",
+				     flname, flline, ep->e_path);
+				ret =3D -1;
+				goto out;
+			}
+		} else {
+			if (!ep->e_fsid) {
+				xlog(L_ERROR, "%s:%i: Selected 'reexport=3D' mode requires either a =
UUID 'fsid=3D' or a numerical 'fsid=3D' or a reexport db entry %d",
+				     flname, flline, ep->e_fsid);
+				ret =3D -1;
+			}
+
+			goto out;
+		}
+	}
+
+	if (ep->e_fsid) {
+		if (ep->e_fsid !=3D fsidnum) {
+			xlog(L_ERROR, "%s:%i: Selected 'reexport=3D' mode requires configured=
 numerical 'fsid=3D' to agree with reexport db entry",
+			     flname, flline);
+			ret =3D -1;
+		}
+	} else {
+		ep->e_fsid =3D fsidnum;
+	}
+
+	return ret;
+}
diff --git a/systemd/Makefile.am b/systemd/Makefile.am
index e7f5d818..f254b218 100644
--- a/systemd/Makefile.am
+++ b/systemd/Makefile.am
@@ -69,6 +69,10 @@ nfs_server_generator_LDADD =3D ../support/export/libex=
port.a \
 			     ../support/misc/libmisc.a \
 			     $(LIBPTHREAD)
=20
+if CONFIG_REEXPORT
+nfs_server_generator_LDADD +=3D ../support/reexport/libreexport.a $(LIBS=
QLITE) -lrt
+endif
+
 rpc_pipefs_generator_LDADD =3D ../support/nfs/libnfs.la
=20
 if INSTALL_SYSTEMD
diff --git a/utils/exportfs/Makefile.am b/utils/exportfs/Makefile.am
index 96524c72..451637a0 100644
--- a/utils/exportfs/Makefile.am
+++ b/utils/exportfs/Makefile.am
@@ -12,4 +12,10 @@ exportfs_LDADD =3D ../../support/export/libexport.a \
 		 ../../support/misc/libmisc.a \
 		 $(LIBWRAP) $(LIBNSL) $(LIBPTHREAD)
=20
+if CONFIG_REEXPORT
+exportfs_LDADD +=3D ../../support/reexport/libreexport.a $(LIBSQLITE) -l=
rt
+endif
+
+exportfs_CPPFLAGS =3D $(AM_CPPFLAGS) $(CPPFLAGS) -I$(top_srcdir)/support=
/reexport
+
 MAINTAINERCLEANFILES =3D Makefile.in
diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index 6ba615d1..7f21edcf 100644
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
diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
index 54b3f877..ad2c2c59 100644
--- a/utils/exportfs/exports.man
+++ b/utils/exportfs/exports.man
@@ -420,6 +420,37 @@ will only work if all clients use a consistent secur=
ity policy.  Note
 that early kernels did not support this export option, and instead
 enabled security labels by default.
=20
+.TP
+.IR reexport=3D auto-fsidnum|predefined-fsidnum
+This option helps when a NFS share is re-exported. Since the NFS server
+needs a unique identifier for each exported filesystem and a NFS share
+cannot provide such, usually a manual fsid is needed.
+As soon
+.IR crossmnt
+is used manually assigning fsid won't work anymore. This is where this
+option becomes handy. It will automatically assign a numerical fsid
+to exported NFS shares. The fsid and path relations are stored in a SQLi=
te
+database. If
+.IR auto-fsidnum
+is selected, the fsid is also autmatically allocated.
+.IR predefined-fsidnum
+assumes pre-allocated fsid numbers and will just look them up.
+This option depends also on the kernel, you will need at least kernel ve=
rsion
+5.19.
+Since
+.IR reexport=3D
+can automatically allocate and assign numerical fsids, it is no longer p=
ossible
+to have numerical fsids in other exports as soon this option is used in =
at least
+one export entry.
+
+The association between fsid numbers and paths is stored in a SQLite dat=
abase.
+Don't edit or remove the database unless you know exactly what you're do=
ing.
+.IR predefined-fsidnum
+is useful when you have used
+.IR auto-fsidnum
+before and don't want further entries stored.
+
+
 .SS User ID Mapping
 .PP
 .B nfsd
diff --git a/utils/mount/Makefile.am b/utils/mount/Makefile.am
index 3101f7ab..0268488c 100644
--- a/utils/mount/Makefile.am
+++ b/utils/mount/Makefile.am
@@ -32,6 +32,13 @@ mount_nfs_LDADD =3D ../../support/nfs/libnfs.la \
 		  ../../support/misc/libmisc.a \
 		  $(LIBTIRPC)
=20
+if CONFIG_REEXPORT
+mount_nfs_LDADD +=3D ../../support/reexport/libreexport.a \
+		   ../../support/misc/libmisc.a \
+		   $(LIBSQLITE) -lrt $(LIBPTHREAD)
+endif
+
+
 mount_nfs_SOURCES =3D $(mount_common)
=20
 if CONFIG_LIBMOUNT
--=20
2.31.1

