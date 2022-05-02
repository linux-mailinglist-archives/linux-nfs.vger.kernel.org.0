Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E080516C88
	for <lists+linux-nfs@lfdr.de>; Mon,  2 May 2022 10:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359557AbiEBIzN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 May 2022 04:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383908AbiEBIzK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 May 2022 04:55:10 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B395E13DD1
        for <linux-nfs@vger.kernel.org>; Mon,  2 May 2022 01:51:33 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C1993608110A;
        Mon,  2 May 2022 10:51:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id fB0IaWk0pL7G; Mon,  2 May 2022 10:51:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 81B15607198F;
        Mon,  2 May 2022 10:51:29 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id G_sgC80wEfVO; Mon,  2 May 2022 10:51:29 +0200 (CEST)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id E3360607198B;
        Mon,  2 May 2022 10:51:28 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     david@sigma-star.at, bfields@fieldses.org,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        david.oberhollenzer@sigma-star.at, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, steved@redhat.com,
        chris.chilvers@appsbroker.com, Richard Weinberger <richard@nod.at>
Subject: [PATCH 3/5] export: Implement logic behind reexport=
Date:   Mon,  2 May 2022 10:50:43 +0200
Message-Id: <20220502085045.13038-4-richard@nod.at>
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

This covers the cross mount case. When mountd/exportd detect
a cross mount on a re-exported NFS volume a identifier has to
be found to make nfsd happy.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 support/export/cache.c      | 71 +++++++++++++++++++++++++++++++++----
 support/reexport/reexport.c |  1 +
 utils/exportd/Makefile.am   |  8 ++++-
 utils/exportd/exportd.c     |  5 +++
 utils/mountd/Makefile.am    |  6 ++++
 utils/mountd/mountd.c       |  1 +
 utils/mountd/svc_run.c      |  6 ++++
 7 files changed, 91 insertions(+), 7 deletions(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index a5823e92..307d183b 100644
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
+			if (exp->m_export.e_flags & NFSEXP_CROSSMOUNT &&
+			    match_crossmnt_fsidnum(parsed->fsidnum, path))
+				goto match;
+
 			goto nomatch;
+		}
 		goto match;
 	case FSID_UUID4_INUM:
 	case FSID_UUID16_INUM:
@@ -789,6 +805,9 @@ static void nfsd_fh(int f)
 			goto out;
 	}
=20
+	if (parsed.fsidtype =3D=3D FSID_NUM)
+		reexpdb_uncover_subvolume(parsed.fsidnum);
+
 	/* Now determine export point for this fsid/domain */
 	for (i=3D0 ; i < MCL_MAXTYPES; i++) {
 		nfs_export *next_exp;
@@ -932,7 +951,7 @@ static void write_fsloc(char **bp, int *blen, struct =
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
@@ -947,11 +966,20 @@ static void write_secinfo(char **bp, int *blen, str=
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
@@ -968,17 +996,48 @@ static int dump_to_cache(int f, char *buf, int blen=
, char *domain,
 	if (exp) {
 		int different_fs =3D strcmp(path, exp->e_path) !=3D 0;
 		int flag_mask =3D different_fs ? ~NFSEXP_FSID : ~0;
+		int rc, do_fsidnum =3D 0;
+		uint32_t fsidnum =3D exp->e_fsid;
+
+		if (different_fs) {
+			struct statfs64 st;
+
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
diff --git a/support/reexport/reexport.c b/support/reexport/reexport.c
index a9529b2b..51e49834 100644
--- a/support/reexport/reexport.c
+++ b/support/reexport/reexport.c
@@ -346,5 +346,6 @@ int reexpdb_apply_reexport_settings(struct exportent =
*ep, char *flname, int flli
 		ep->e_fsid =3D fsidnum;
 	}
=20
+out:
 	return ret;
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
diff --git a/utils/mountd/mountd.c b/utils/mountd/mountd.c
index bcf749fa..8555d746 100644
--- a/utils/mountd/mountd.c
+++ b/utils/mountd/mountd.c
@@ -32,6 +32,7 @@
 #include "nfsd_path.h"
 #include "nfslib.h"
 #include "export.h"
+#include "reexport.h"
=20
 extern void my_svc_run(void);
=20
diff --git a/utils/mountd/svc_run.c b/utils/mountd/svc_run.c
index 167b9757..6b5f47f1 100644
--- a/utils/mountd/svc_run.c
+++ b/utils/mountd/svc_run.c
@@ -57,6 +57,7 @@
 #include <rpc/rpc_com.h>
 #endif
 #include "export.h"
+#include "reexport.h"
=20
 void my_svc_run(void);
=20
@@ -96,6 +97,11 @@ my_svc_run(void)
 	fd_set	readfds;
 	int	selret;
=20
+	if (reexpdb_init() !=3D 0) {
+		xlog(L_ERROR, "%s: Failed to init reexport database", __func__);
+		return;
+	}
+
 	for (;;) {
=20
 		readfds =3D svc_fdset;
--=20
2.31.1

