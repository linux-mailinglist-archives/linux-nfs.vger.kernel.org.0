Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5571F6E5D78
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Apr 2023 11:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjDRJe0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Apr 2023 05:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjDRJeV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Apr 2023 05:34:21 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC083AA4
        for <linux-nfs@vger.kernel.org>; Tue, 18 Apr 2023 02:34:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 12B3164548AA;
        Tue, 18 Apr 2023 11:34:14 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jGXi2-WbQWM7; Tue, 18 Apr 2023 11:34:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 612C663CC168;
        Tue, 18 Apr 2023 11:34:13 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 07kss81YGmSn; Tue, 18 Apr 2023 11:34:13 +0200 (CEST)
Received: from blindfold.corp.sigma-star.at (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id EACA06431C43;
        Tue, 18 Apr 2023 11:34:12 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     david@sigma-star.at, david.oberhollenzer@sigma-star.at,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com, chris.chilvers@appsbroker.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 3/8] export: Wireup reexport mechanism
Date:   Tue, 18 Apr 2023 11:33:45 +0200
Message-Id: <20230418093350.4550-4-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230418093350.4550-1-richard@nod.at>
References: <20230418093350.4550-1-richard@nod.at>
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

Detect the case when a NFS share is re-exported and assign an
fsidnum to it.
The fsidnum is read (or created) from the reexport database.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 support/export/cache.c | 68 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 6 deletions(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index 0a37703b..42a694d0 100644
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
@@ -688,8 +699,13 @@ static int match_fsid(struct parsed_fsid *parsed, nf=
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
@@ -937,7 +953,7 @@ static void write_fsloc(char **bp, int *blen, struct =
exportent *ep)
 }
 #endif
=20
-static void write_secinfo(char **bp, int *blen, struct exportent *ep, in=
t flag_mask)
+static void write_secinfo(char **bp, int *blen, struct exportent *ep, in=
t flag_mask, int extra_flag)
 {
 	struct sec_entry *p;
=20
@@ -952,7 +968,7 @@ static void write_secinfo(char **bp, int *blen, struc=
t exportent *ep, int flag_m
 	qword_addint(bp, blen, p - ep->e_secinfo);
 	for (p =3D ep->e_secinfo; p->flav; p++) {
 		qword_addint(bp, blen, p->flav->fnum);
-		qword_addint(bp, blen, p->flags & flag_mask);
+		qword_addint(bp, blen, (p->flags | extra_flag) & flag_mask);
 	}
 }
=20
@@ -970,6 +986,15 @@ static void write_xprtsec(char **bp, int *blen, stru=
ct exportent *ep)
 		qword_addint(bp, blen, p->info->number);
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
@@ -986,17 +1011,48 @@ static int dump_to_cache(int f, char *buf, int ble=
n, char *domain,
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
--=20
2.31.1

