Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516866D5EBC
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Apr 2023 13:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbjDDLNX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Apr 2023 07:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjDDLNW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Apr 2023 07:13:22 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A2110DD
        for <linux-nfs@vger.kernel.org>; Tue,  4 Apr 2023 04:13:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 83FCC64548A1;
        Tue,  4 Apr 2023 13:13:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id CbikqNIsVKfR; Tue,  4 Apr 2023 13:13:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 141436431C2E;
        Tue,  4 Apr 2023 13:13:14 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Rq1_05RhCb3D; Tue,  4 Apr 2023 13:13:14 +0200 (CEST)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id A0D4B63CC199;
        Tue,  4 Apr 2023 13:13:13 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     david@sigma-star.at, david.oberhollenzer@sigma-star.at,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com, chris.chilvers@appsbroker.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/2] export: Add reexport= option
Date:   Tue,  4 Apr 2023 13:13:07 +0200
Message-Id: <20230404111308.23465-2-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230404111308.23465-1-richard@nod.at>
References: <20230404111308.23465-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 configure.ac                 |   1 +
 support/Makefile.am          |   2 +-
 support/export/Makefile.am   |   2 +
 support/export/cache.c       |  74 +++++++-
 support/export/export.c      |  27 ++-
 support/include/nfslib.h     |   1 +
 support/nfs/Makefile.am      |   1 +
 support/nfs/exports.c        |  62 +++++++
 support/reexport/Makefile.am |   6 +
 support/reexport/reexport.c  | 327 +++++++++++++++++++++++++++++++++++
 support/reexport/reexport.h  |  18 ++
 systemd/Makefile.am          |   2 +
 utils/exportd/Makefile.am    |   6 +-
 utils/exportd/exportd.c      |   5 +
 utils/exportfs/Makefile.am   |   3 +
 utils/exportfs/exportfs.c    |  11 ++
 utils/exportfs/exports.man   |  31 ++++
 utils/mount/Makefile.am      |   3 +-
 utils/mountd/Makefile.am     |   2 +
 19 files changed, 573 insertions(+), 11 deletions(-)
 create mode 100644 support/reexport/Makefile.am
 create mode 100644 support/reexport/reexport.c
 create mode 100644 support/reexport/reexport.h

diff --git a/configure.ac b/configure.ac
index 7672a760..9f43267c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -717,6 +717,7 @@ AC_CONFIG_FILES([
 	support/nsm/Makefile
 	support/nfsidmap/Makefile
 	support/nfsidmap/libnfsidmap.pc
+	support/reexport/Makefile
 	tools/Makefile
 	tools/locktest/Makefile
 	tools/nlmtest/Makefile
diff --git a/support/Makefile.am b/support/Makefile.am
index c962d4d4..07cfd87e 100644
--- a/support/Makefile.am
+++ b/support/Makefile.am
@@ -10,7 +10,7 @@ if CONFIG_JUNCTION
 OPTDIRS +=3D junction
 endif
=20
-SUBDIRS =3D export include misc nfs nsm $(OPTDIRS)
+SUBDIRS =3D export include misc nfs nsm reexport $(OPTDIRS)
=20
 MAINTAINERCLEANFILES =3D Makefile.in
=20
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
diff --git a/support/export/cache.c b/support/export/cache.c
index 2497d4f4..d0a58e0c 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -33,6 +33,7 @@
 #include "export.h"
 #include "pseudoflavors.h"
 #include "xcommon.h"
+#include "reexport.h"
=20
 #ifdef HAVE_JUNCTION_SUPPORT
 #include "fsloc.h"
@@ -235,6 +236,16 @@ static void auth_unix_gid(int f)
 		xlog(L_ERROR, "auth_unix_gid: error writing reply");
 }
=20
+static int match_crossmnt_fsidnum(uint32_t parsed_fsidnum, char *path)
+{
+	uint32_t fsidnum;
+
+	if (reexpdb_fsidnum_by_path(path, &fsidnum, 0) =3D=3D 0)
+		return 0;
+
+	return fsidnum =3D=3D parsed_fsidnum;
+}
+
 #ifdef USE_BLKID
 static const char *get_uuid_blkdev(char *path)
 {
@@ -684,8 +695,13 @@ static int match_fsid(struct parsed_fsid *parsed, nf=
s_export *exp, char *path)
 		goto match;
 	case FSID_NUM:
 		if (((exp->m_export.e_flags & NFSEXP_FSID) =3D=3D 0 ||
-		     exp->m_export.e_fsid !=3D parsed->fsidnum))
+		     exp->m_export.e_fsid !=3D parsed->fsidnum)) {
+			if ((exp->m_export.e_flags & NFSEXP_CROSSMOUNT) && exp->m_export.e_re=
export !=3D REEXP_NONE &&
+			    match_crossmnt_fsidnum(parsed->fsidnum, path))
+				goto match;
+
 			goto nomatch;
+		}
 		goto match;
 	case FSID_UUID4_INUM:
 	case FSID_UUID16_INUM:
@@ -758,6 +774,7 @@ static void nfsd_fh(int f)
 	int dev_missing =3D 0;
 	char buf[RPC_CHAN_BUF_SIZE], *bp;
 	int blen;
+	int did_uncover =3D 0;
=20
 	blen =3D cache_read(f, buf, sizeof(buf));
 	if (blen <=3D 0 || buf[blen-1] !=3D '\n') return;
@@ -795,6 +812,11 @@ static void nfsd_fh(int f)
 		for (exp =3D exportlist[i].p_head; exp; exp =3D next_exp) {
 			char *path;
=20
+			if (!did_uncover && parsed.fsidnum && parsed.fsidtype =3D=3D FSID_NUM=
 && exp->m_export.e_reexport !=3D REEXP_NONE) {
+				reexpdb_uncover_subvolume(parsed.fsidnum);
+				did_uncover =3D 1;
+			}
+
 			if (exp->m_export.e_flags & NFSEXP_CROSSMOUNT) {
 				static nfs_export *prev =3D NULL;
 				static void *mnt =3D NULL;
@@ -932,7 +954,7 @@ static void write_fsloc(char **bp, int *blen, struct =
exportent *ep)
 	release_replicas(servers);
 }
 #endif
-static void write_secinfo(char **bp, int *blen, struct exportent *ep, in=
t flag_mask)
+static void write_secinfo(char **bp, int *blen, struct exportent *ep, in=
t flag_mask, int extra_flag)
 {
 	struct sec_entry *p;
=20
@@ -947,11 +969,20 @@ static void write_secinfo(char **bp, int *blen, str=
uct exportent *ep, int flag_m
 	qword_addint(bp, blen, p - ep->e_secinfo);
 	for (p =3D ep->e_secinfo; p->flav; p++) {
 		qword_addint(bp, blen, p->flav->fnum);
-		qword_addint(bp, blen, p->flags & flag_mask);
+		qword_addint(bp, blen, (p->flags | extra_flag) & flag_mask);
 	}
=20
 }
=20
+static int can_reexport_via_fsidnum(struct exportent *exp, struct statfs=
 *st)
+{
+	if (st->f_type !=3D 0x6969 /* NFS_SUPER_MAGIC */)
+		return 0;
+
+	return exp->e_reexport =3D=3D REEXP_PREDEFINED_FSIDNUM ||
+	       exp->e_reexport =3D=3D REEXP_AUTO_FSIDNUM;
+}
+
 static int dump_to_cache(int f, char *buf, int blen, char *domain,
 			 char *path, struct exportent *exp, int ttl)
 {
@@ -968,17 +999,48 @@ static int dump_to_cache(int f, char *buf, int blen=
, char *domain,
 	if (exp) {
 		int different_fs =3D strcmp(path, exp->e_path) !=3D 0;
 		int flag_mask =3D different_fs ? ~NFSEXP_FSID : ~0;
+		int rc, do_fsidnum =3D 0;
+		uint32_t fsidnum =3D exp->e_fsid;
+
+		if (different_fs) {
+			struct statfs st;
+
+			rc =3D nfsd_path_statfs(path, &st);
+			if (rc) {
+				xlog(L_WARNING, "unable to statfs %s", path);
+				errno =3D EINVAL;
+				return -1;
+			}
+
+			if (can_reexport_via_fsidnum(exp, &st)) {
+				do_fsidnum =3D 1;
+				flag_mask =3D ~0;
+			}
+		}
=20
 		qword_adduint(&bp, &blen, now + exp->e_ttl);
-		qword_addint(&bp, &blen, exp->e_flags & flag_mask);
+
+		if (do_fsidnum) {
+			uint32_t search_fsidnum =3D 0;
+			if (exp->e_reexport !=3D REEXP_NONE && reexpdb_fsidnum_by_path(path, =
&search_fsidnum,
+			    exp->e_reexport =3D=3D REEXP_AUTO_FSIDNUM) =3D=3D 0) {
+				errno =3D EINVAL;
+				return -1;
+			}
+			fsidnum =3D search_fsidnum;
+			qword_addint(&bp, &blen, exp->e_flags | NFSEXP_FSID);
+		} else {
+			qword_addint(&bp, &blen, exp->e_flags & flag_mask);
+		}
+
 		qword_addint(&bp, &blen, exp->e_anonuid);
 		qword_addint(&bp, &blen, exp->e_anongid);
-		qword_addint(&bp, &blen, exp->e_fsid);
+		qword_addint(&bp, &blen, fsidnum);
=20
 #ifdef HAVE_JUNCTION_SUPPORT
 		write_fsloc(&bp, &blen, exp);
 #endif
-		write_secinfo(&bp, &blen, exp, flag_mask);
+		write_secinfo(&bp, &blen, exp, flag_mask, do_fsidnum ? NFSEXP_FSID : 0=
);
 		if (exp->e_uuid =3D=3D NULL || different_fs) {
 			char u[16];
 			if ((exp->e_flags & flag_mask & NFSEXP_FSID) =3D=3D 0 &&
diff --git a/support/export/export.c b/support/export/export.c
index 03390dfc..c5e56b1a 100644
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
+	}
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
 	}
+
 	endexportent();
=20
 	return volumes;
@@ -147,7 +167,7 @@ export_d_read(const char *dname, int ignore_hosts)
 	int n =3D 0, i;
 	struct dirent **namelist =3D NULL;
 	int volumes =3D 0;
-
+	int num_exports;
=20
 	n =3D scandir(dname, &namelist, NULL, versionsort);
 	if (n < 0) {
@@ -186,7 +206,10 @@ export_d_read(const char *dname, int ignore_hosts)
 			continue;
 		}
=20
-		volumes +=3D export_read(fname, ignore_hosts);
+		num_exports =3D export_read(fname, ignore_hosts);
+		if (num_exports < 0)
+			return -1;
+		volumes +=3D num_exports;
 	}
=20
 	for (i =3D 0; i < n; i++)
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
index 2c8f0752..1d7e5228 100644
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
@@ -688,6 +715,41 @@ bad_option:
 			active =3D parse_flavors(opt+4, ep);
 			if (!active)
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
diff --git a/support/reexport/Makefile.am b/support/reexport/Makefile.am
new file mode 100644
index 00000000..9d544a8f
--- /dev/null
+++ b/support/reexport/Makefile.am
@@ -0,0 +1,6 @@
+## Process this file with automake to produce Makefile.in
+
+noinst_LIBRARIES =3D libreexport.a
+libreexport_a_SOURCES =3D reexport.c
+
+MAINTAINERCLEANFILES =3D Makefile.in
diff --git a/support/reexport/reexport.c b/support/reexport/reexport.c
new file mode 100644
index 00000000..d04d7c44
--- /dev/null
+++ b/support/reexport/reexport.c
@@ -0,0 +1,327 @@
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <dlfcn.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <sys/random.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/vfs.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+
+#include "nfsd_path.h"
+#include "conffile.h"
+#include "nfslib.h"
+#include "reexport.h"
+#include "reexport_backend.h"
+#include "xcommon.h"
+#include "xlog.h"
+
+static int fsidd_srv =3D -1;
+
+static bool connect_fsid_service(void)
+{
+	struct sockaddr_un addr;
+	char *sock_file;
+	int ret;
+	int s;
+
+	if (fsidd_srv !=3D -1)
+		return true;
+
+	sock_file =3D conf_get_str_with_def("reexport", "fsidd_socket", FSID_SO=
CKET_NAME);
+
+	memset(&addr, 0, sizeof(struct sockaddr_un));
+	addr.sun_family =3D AF_UNIX;
+	strncpy(addr.sun_path, sock_file, sizeof(addr.sun_path) - 1);
+
+	s =3D socket(AF_UNIX, SOCK_SEQPACKET, 0);
+	if (s =3D=3D -1) {
+		xlog(L_WARNING, "Unable to create AF_UNIX socket for %s: %m\n", sock_f=
ile);
+		return false;
+	}
+
+	ret =3D connect(s, (const struct sockaddr *)&addr, sizeof(struct sockad=
dr_un));
+	if (ret =3D=3D -1) {
+		xlog(L_WARNING, "Unable to connect %s: %m, is fsidd running?\n", sock_=
file);
+		return false;
+	}
+
+	fsidd_srv =3D s;
+
+	return true;
+}
+
+int reexpdb_init(void)
+{
+	int try_count =3D 3;
+
+	while (try_count > 0 && !connect_fsid_service()) {
+		sleep(1);
+		try_count--;
+	}
+
+	return try_count > 0;
+}
+
+void reexpdb_destroy(void)
+{
+	close(fsidd_srv);
+	fsidd_srv =3D -1;
+}
+
+static bool parse_fsidd_reply(const char *cmd_info, char *buf, size_t le=
n, char **result)
+{
+	if (len =3D=3D 0) {
+		xlog(L_WARNING, "Unable to read %s result: server closed the connectio=
n", cmd_info);
+		return false;
+	} else if (len < 2) {
+		xlog(L_WARNING, "Unable to read %s result: server sent too few bytes",=
 cmd_info);
+		return false;
+	}
+
+	if (buf[0] =3D=3D '-') {
+		if (len > 2) {
+			char *reason =3D buf + 2;
+			xlog(L_WARNING, "Command %s failed, server said: %s", cmd_info, reaso=
n);
+		} else {
+			xlog(L_WARNING, "Command %s failed at server side", cmd_info);
+		}
+
+		return false;
+	}
+
+	if (buf[0] !=3D '+') {
+		xlog(L_WARNING, "Unable to read %s result: server sent malformed answe=
r", cmd_info);
+		return false;
+	}
+
+	if (len > 2) {
+		*result =3D strdup(buf + 2);
+	} else {
+		*result =3D NULL;
+	}
+
+	return true;
+}
+
+static bool do_fsidd_cmd(const char *cmd_info, char *msg, size_t len, ch=
ar **result)
+{
+	char recvbuf[1024];
+	int n;
+
+	if (fsidd_srv =3D=3D -1) {
+		xlog(L_NOTICE, "Reconnecting to fsid services");
+		if (reexpdb_init() =3D=3D false)
+			return false;
+	}
+
+	xlog(D_GENERAL, "Request to fsidd: msg=3D\"%s\" len=3D%zd", msg, len);
+
+	if (write(fsidd_srv, msg, len) =3D=3D -1) {
+		xlog(L_WARNING, "Unable to send %s command: %m", cmd_info);
+		goto out_close;
+	}
+
+	n =3D read(fsidd_srv, recvbuf, sizeof(recvbuf) - 1);
+	if (n <=3D -1) {
+		xlog(L_WARNING, "Unable to recv %s answer: %m", cmd_info);
+		goto out_close;
+	} else if (n =3D=3D sizeof(recvbuf) - 1) {
+		//TODO: use better way to detect truncation
+		xlog(L_WARNING, "Unable to recv %s answer: answer truncated", cmd_info=
);
+		goto out_close;
+	}
+	recvbuf[n] =3D '\0';
+
+	xlog(D_GENERAL, "Answer from fsidd: msg=3D\"%s\" len=3D%i", recvbuf, n)=
;
+
+	if (parse_fsidd_reply(cmd_info, recvbuf, n, result) =3D=3D false) {
+		goto out_close;
+	}
+
+	return true;
+
+out_close:
+	close(fsidd_srv);
+	fsidd_srv =3D -1;
+	return false;
+}
+
+static bool fsidnum_get_by_path(char *path, uint32_t *fsidnum, bool may_=
create)
+{
+	char *msg, *result;
+	bool ret =3D false;
+	int len;
+
+	char *cmd =3D may_create ? "get_or_create_fsidnum" : "get_fsidnum";
+
+	len =3D asprintf(&msg, "%s %s", cmd, path);
+	if (len =3D=3D -1) {
+		xlog(L_WARNING, "Unable to build %s command: %m", cmd);
+		goto out;
+	}
+
+	if (do_fsidd_cmd(cmd, msg, len, &result) =3D=3D false) {
+		goto out;
+	}
+
+	if (result) {
+		bool bad_input =3D true;
+		char *endp;
+
+		errno =3D 0;
+		*fsidnum =3D strtoul(result, &endp, 10);
+		if (errno =3D=3D 0 && *endp =3D=3D '\0') {
+			bad_input =3D false;
+		}
+
+		free(result);
+
+		if (!bad_input) {
+			ret =3D true;
+		} else {
+			xlog(L_NOTICE, "Got malformed fsid for path %s", path);
+		}
+	} else {
+		xlog(L_NOTICE, "No fsid found for path %s", path);
+	}
+
+out:
+	free(msg);
+	return ret;
+}
+
+static bool path_by_fsidnum(uint32_t fsidnum, char **path)
+{
+	char *msg, *result;
+	bool ret =3D false;
+	int len;
+
+	len =3D asprintf(&msg, "get_path %d", (unsigned int)fsidnum);
+	if (len =3D=3D -1) {
+		xlog(L_WARNING, "Unable to build get_path command: %m");
+		goto out;
+	}
+
+	if (do_fsidd_cmd("get_path", msg, len, &result) =3D=3D false) {
+		goto out;
+	}
+
+	if (result) {
+		*path =3D result;
+		ret =3D true;
+	} else {
+		xlog(L_NOTICE, "No path found for fsid %u", (unsigned int)fsidnum);
+	}
+
+out:
+	free(msg);
+	return ret;
+}
+
+/*
+ * reexpdb_fsidnum_by_path - Lookup a fsid by path.
+ *
+ * @path: File system path used as lookup key
+ * @fsidnum: Pointer where found fsid is written to
+ * @may_create: If non-zero, allocate new fsid if lookup failed
+ *
+ */
+int reexpdb_fsidnum_by_path(char *path, uint32_t *fsidnum, int may_creat=
e)
+{
+	return fsidnum_get_by_path(path, fsidnum, may_create);
+}
+
+/*
+ * reexpdb_uncover_subvolume - Make sure a subvolume is present.
+ *
+ * @fsidnum: Numerical fsid number to look for
+ *
+ * Subvolumes (NFS cross mounts) get automatically mounted upon first
+ * access and can vanish after fs.nfs.nfs_mountpoint_timeout seconds.
+ * Also if the NFS server reboots, clients can still have valid file
+ * handles for such a subvolume.
+ *
+ * If kNFSd asks mountd for the path of a given fsidnum it can
+ * trigger an automount by calling statfs() on the given path.
+ */
+void reexpdb_uncover_subvolume(uint32_t fsidnum)
+{
+	struct statfs st;
+	char *path =3D NULL;
+	int ret;
+
+	if (path_by_fsidnum(fsidnum, &path)) {
+		ret =3D nfsd_path_statfs(path, &st);
+		if (ret =3D=3D -1)
+			xlog(L_WARNING, "statfs() failed");
+	}
+
+	free(path);
+}
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
+	bool found, is_v4root =3D ((ep->e_flags & NFSEXP_FSID) && !ep->e_fsid);
+	int ret =3D 0;
+
+	if (ep->e_reexport =3D=3D REEXP_NONE)
+		goto out;
+
+	if (ep->e_uuid)
+		goto out;
+
+	if (is_v4root)
+		goto out;
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
+out:
+	return ret;
+}
diff --git a/support/reexport/reexport.h b/support/reexport/reexport.h
new file mode 100644
index 00000000..3bed03a9
--- /dev/null
+++ b/support/reexport/reexport.h
@@ -0,0 +1,18 @@
+#ifndef REEXPORT_H
+#define REEXPORT_H
+
+enum {
+	REEXP_NONE =3D 0,
+	REEXP_AUTO_FSIDNUM,
+	REEXP_PREDEFINED_FSIDNUM,
+};
+
+int reexpdb_init(void);
+void reexpdb_destroy(void);
+int reexpdb_fsidnum_by_path(char *path, uint32_t *fsidnum, int may_creat=
e);
+int reexpdb_apply_reexport_settings(struct exportent *ep, char *flname, =
int flline);
+void reexpdb_uncover_subvolume(uint32_t fsidnum);
+
+#define FSID_SOCKET_NAME "fsid.sock"
+
+#endif /* REEXPORT_H */
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
index c95bdee7..e9ffe6c0 100644
--- a/utils/exportd/Makefile.am
+++ b/utils/exportd/Makefile.am
@@ -16,11 +16,15 @@ exportd_SOURCES =3D exportd.c
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
=20
+exportd_CPPFLAGS +=3D -I$(top_srcdir)/support/reexport
+
 MAINTAINERCLEANFILES =3D Makefile.in
=20
 #######################################################################
diff --git a/utils/exportd/exportd.c b/utils/exportd/exportd.c
index 2dd12cb6..e076a295 100644
--- a/utils/exportd/exportd.c
+++ b/utils/exportd/exportd.c
@@ -22,6 +22,7 @@
 #include "conffile.h"
 #include "exportfs.h"
 #include "export.h"
+#include "reexport.h"
=20
 extern void my_svc_run(void);
=20
@@ -296,6 +297,10 @@ main(int argc, char **argv)
 	/* Open files now to avoid sharing descriptors among forked processes *=
/
 	cache_open();
 	v4clients_init();
+	if (reexpdb_init() !=3D 0) {
+		xlog(L_ERROR, "%s: Failed to init reexport database", __func__);
+		exit(1);
+	}
=20
 	/* Process incoming upcalls */
 	cache_process_loop();
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
index 6d79a5b3..a874d448 100644
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

