Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0604BA101
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 14:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiBQNXL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Feb 2022 08:23:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240747AbiBQNXJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 08:23:09 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1C398F7A
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 05:22:52 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D6A1760ED821;
        Thu, 17 Feb 2022 14:16:40 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8HEKE043ZNLK; Thu, 17 Feb 2022 14:16:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7408E60765A3;
        Thu, 17 Feb 2022 14:16:39 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id w30w7zKvo9uz; Thu, 17 Feb 2022 14:16:39 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id EAC65608898A;
        Thu, 17 Feb 2022 14:16:38 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     david@sigma-star.at, bfields@fieldses.org,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        david.oberhollenzer@sigma-star.at, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, chris.chilvers@appsbroker.com,
        Richard Weinberger <richard@nod.at>
Subject: [RFC PATCH 3/6] export: Implement logic behind reexport=
Date:   Thu, 17 Feb 2022 14:15:28 +0100
Message-Id: <20220217131531.2890-4-richard@nod.at>
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

This covers the cross mount case. When mountd/exportd detect
a cross mount on a re-exported NFS volume a identifier has to
be found to make nfsd happy.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 support/export/Makefile.am |   2 +
 support/export/cache.c     | 140 +++++++++++++++++++++++++++++++++----
 utils/exportd/Makefile.am  |   8 ++-
 utils/exportd/exportd.c    |   2 +
 utils/mountd/Makefile.am   |   6 ++
 5 files changed, 144 insertions(+), 14 deletions(-)

diff --git a/support/export/Makefile.am b/support/export/Makefile.am
index eec737f6..90109b1e 100644
--- a/support/export/Makefile.am
+++ b/support/export/Makefile.am
@@ -14,6 +14,8 @@ libexport_a_SOURCES =3D client.c export.c hostname.c \
 		      xtab.c mount_clnt.c mount_xdr.c \
 		      cache.c auth.c v4root.c fsloc.c \
 		      v4clients.c
+libexport_a_CPPFLAGS =3D -I$(top_srcdir)/support/reexport
+
 BUILT_SOURCES 	=3D $(GENFILES)
=20
 noinst_HEADERS =3D mount.h
diff --git a/support/export/cache.c b/support/export/cache.c
index a5823e92..6039745e 100644
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
@@ -331,7 +342,52 @@ static const unsigned long nonblkid_filesystems[] =3D=
 {
     0        /* last */
 };
=20
-static int uuid_by_path(char *path, int type, size_t uuidlen, char *uuid=
)
+static int get_uuid_from_fsid(char *path, char *uuid_str, size_t len)
+{
+	unsigned int min_dev, maj_dev, min_fsid, maj_fsid;
+	int rc, n, found =3D 0, header_seen =3D 0;
+	struct stat stb;
+	FILE *nfsfs_fd;
+	char line[128];
+
+	rc =3D nfsd_path_stat(path, &stb);
+	if (rc) {
+		xlog(L_WARNING, "Unable to stat %s", path);
+		return 0;
+	}
+
+	nfsfs_fd =3D fopen("/proc/fs/nfsfs/volumes", "r");
+	if (nfsfs_fd =3D=3D NULL) {
+		xlog(L_WARNING, "Unable to open nfsfs volume file: %m");
+		return 0;
+	}
+
+	while (fgets(line, sizeof(line), nfsfs_fd) !=3D NULL) {
+		if (!header_seen) {
+			header_seen =3D 1;
+			continue;
+		}
+		n =3D sscanf(line, "v%*u %*x %*u %u:%u %x:%x %*s", &maj_dev,
+			   &min_dev, &maj_fsid, &min_fsid);
+
+		if (n !=3D 4) {
+			xlog(L_WARNING, "Unable to parse nfsfs volume line: %d, %s", n, line)=
;
+			continue;
+		}
+
+		if (makedev(maj_dev, min_dev) =3D=3D stb.st_dev) {
+			found =3D 1;
+			snprintf(uuid_str, len, "%08x%08x", maj_fsid, min_fsid);
+			break;
+		}
+	}
+
+	fclose(nfsfs_fd);
+
+	return found;
+}
+
+static int uuid_by_path(struct exportent *exp, char *path, int type, siz=
e_t uuidlen, char *uuid)
 {
 	/* get a uuid for the filesystem found at 'path'.
 	 * There are several possible ways of generating the
@@ -362,7 +418,7 @@ static int uuid_by_path(char *path, int type, size_t =
uuidlen, char *uuid)
 	 */
 	struct statfs64 st;
 	char fsid_val[17];
-	const char *blkid_val =3D NULL;
+	const char *fsuuid_val =3D NULL;
 	const char *val;
 	int rc;
=20
@@ -375,7 +431,20 @@ static int uuid_by_path(char *path, int type, size_t=
 uuidlen, char *uuid)
 				break;
 		}
 		if (*bad =3D=3D 0)
-			blkid_val =3D get_uuid_blkdev(path);
+			fsuuid_val =3D get_uuid_blkdev(path);
+		else if (exp->e_reexport =3D=3D REEXP_REMOTE_DEVFSID &&
+			 *bad =3D=3D 0x6969 /* NFS_SUPER_MAGIC */) {
+			char tmp[17];
+			int ret =3D get_uuid_from_fsid(path, tmp, sizeof(tmp));
+
+			if (ret < 0) {
+				xlog(L_WARNING, "Unable to read nfsfs volume file: %i", ret);
+			} else if (ret =3D=3D 0) {
+				xlog(L_WARNING, "Unable to find nfsfs volume entry for %s", path);
+			} else {
+				fsuuid_val =3D tmp;
+			}
+		}
 	}
=20
 	if (rc =3D=3D 0 &&
@@ -385,8 +454,8 @@ static int uuid_by_path(char *path, int type, size_t =
uuidlen, char *uuid)
 	else
 		fsid_val[0] =3D 0;
=20
-	if (blkid_val && (type--) =3D=3D 0)
-		val =3D blkid_val;
+	if (fsuuid_val && (type--) =3D=3D 0)
+		val =3D fsuuid_val;
 	else if (fsid_val[0] && (type--) =3D=3D 0)
 		val =3D fsid_val;
 	else
@@ -684,8 +753,13 @@ static int match_fsid(struct parsed_fsid *parsed, nf=
s_export *exp, char *path)
 		goto match;
 	case FSID_NUM:
 		if (((exp->m_export.e_flags & NFSEXP_FSID) =3D=3D 0 ||
-		     exp->m_export.e_fsid !=3D parsed->fsidnum))
+		     exp->m_export.e_fsid !=3D parsed->fsidnum)) {
+			if (exp->m_export.e_flags & NFSEXP_CROSSMOUNT &&
+			    match_crossmnt_fsidnum(parsed->fsidnum, path))
+				goto match;
+
 			goto nomatch;
+		}
 		goto match;
 	case FSID_UUID4_INUM:
 	case FSID_UUID16_INUM:
@@ -708,7 +782,7 @@ static int match_fsid(struct parsed_fsid *parsed, nfs=
_export *exp, char *path)
 		}
 		else
 			for (type =3D 0;
-			     uuid_by_path(path, type, parsed->uuidlen, u);
+			     uuid_by_path(&exp->m_export, path, type, parsed->uuidlen, u);
 			     type++)
 				if (memcmp(u, parsed->fhuuid, parsed->uuidlen) =3D=3D 0)
 					goto match;
@@ -932,7 +1006,7 @@ static void write_fsloc(char **bp, int *blen, struct=
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
@@ -947,11 +1021,20 @@ static void write_secinfo(char **bp, int *blen, st=
ruct exportent *ep, int flag_m
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
64 *st)
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
@@ -968,21 +1051,52 @@ static int dump_to_cache(int f, char *buf, int ble=
n, char *domain,
 	if (exp) {
 		int different_fs =3D strcmp(path, exp->e_path) !=3D 0;
 		int flag_mask =3D different_fs ? ~NFSEXP_FSID : ~0;
+		int rc, do_fsidnum =3D 0;
+		uint32_t fsidnum =3D exp->e_fsid;
+
+		if (different_fs) {
+			struct statfs64 st;
+=09
+			rc =3D nfsd_path_statfs64(path, &st);
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
+			if (reexpdb_fsidnum_by_path(path, &search_fsidnum,
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
-			    uuid_by_path(path, 0, 16, u)) {
+			    uuid_by_path(exp, path, 0, 16, u)) {
 				qword_add(&bp, &blen, "uuid");
 				qword_addhex(&bp, &blen, u, 16);
 			}
diff --git a/utils/exportd/Makefile.am b/utils/exportd/Makefile.am
index c95bdee7..b0ec9034 100644
--- a/utils/exportd/Makefile.am
+++ b/utils/exportd/Makefile.am
@@ -16,11 +16,17 @@ exportd_SOURCES =3D exportd.c
 exportd_LDADD =3D ../../support/export/libexport.a \
 			../../support/nfs/libnfs.la \
 			../../support/misc/libmisc.a \
-			$(OPTLIBS) $(LIBBLKID) $(LIBPTHREAD) -luuid
+			$(OPTLIBS) $(LIBBLKID) $(LIBPTHREAD) \
+			-luuid
+if CONFIG_REEXPORT
+exportd_LDADD +=3D ../../support/reexport/libreexport.a $(LIBSQLITE) -lr=
t
+endif
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
index 2dd12cb6..4ddfed35 100644
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
@@ -296,6 +297,7 @@ main(int argc, char **argv)
 	/* Open files now to avoid sharing descriptors among forked processes *=
/
 	cache_open();
 	v4clients_init();
+	reexpdb_init();
=20
 	/* Process incoming upcalls */
 	cache_process_loop();
diff --git a/utils/mountd/Makefile.am b/utils/mountd/Makefile.am
index 13b25c90..569d335a 100644
--- a/utils/mountd/Makefile.am
+++ b/utils/mountd/Makefile.am
@@ -20,10 +20,16 @@ mountd_LDADD =3D ../../support/export/libexport.a \
 	       $(OPTLIBS) \
 	       $(LIBBSD) $(LIBWRAP) $(LIBNSL) $(LIBBLKID) -luuid $(LIBTIRPC) \
 	       $(LIBPTHREAD)
+if CONFIG_REEXPORT
+mountd_LDADD +=3D ../../support/reexport/libreexport.a $(LIBSQLITE) -lrt
+endif
+
 mountd_CPPFLAGS =3D $(AM_CPPFLAGS) $(CPPFLAGS) \
 		  -I$(top_builddir)/support/include \
 		  -I$(top_srcdir)/support/export
=20
+mountd_CPPFLAGS +=3D -I$(top_srcdir)/support/reexport
+
 MAINTAINERCLEANFILES =3D Makefile.in
=20
 #######################################################################
--=20
2.31.1

