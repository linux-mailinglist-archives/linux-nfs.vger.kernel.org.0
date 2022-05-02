Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261B6516C8B
	for <lists+linux-nfs@lfdr.de>; Mon,  2 May 2022 10:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383921AbiEBIzP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 May 2022 04:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381887AbiEBIzF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 May 2022 04:55:05 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BEA13DDE
        for <linux-nfs@vger.kernel.org>; Mon,  2 May 2022 01:51:33 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E368C6081119;
        Mon,  2 May 2022 10:51:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5XhSRD7E-Qeb; Mon,  2 May 2022 10:51:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 097FC6081105;
        Mon,  2 May 2022 10:51:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Z0iOYGqj9WiB; Mon,  2 May 2022 10:51:29 +0200 (CEST)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 73871608F44C;
        Mon,  2 May 2022 10:51:29 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     david@sigma-star.at, bfields@fieldses.org,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        david.oberhollenzer@sigma-star.at, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, steved@redhat.com,
        chris.chilvers@appsbroker.com, Richard Weinberger <richard@nod.at>
Subject: [PATCH 4/5] export: Avoid fsid= conflicts
Date:   Mon,  2 May 2022 10:50:44 +0200
Message-Id: <20220502085045.13038-5-richard@nod.at>
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

As soon reexport=3D is used, numerical fsids are automatically
assigned, therefore other fsid=3D options are no longer possible
without the risk of a conflict.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 support/export/export.c        | 27 +++++++++++++++++++++++++--
 systemd/nfs-server-generator.c | 14 ++++++++++++--
 utils/exportfs/exportfs.c      | 10 ++++++++--
 3 files changed, 45 insertions(+), 6 deletions(-)

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
diff --git a/systemd/nfs-server-generator.c b/systemd/nfs-server-generato=
r.c
index eec98fd2..e4202954 100644
--- a/systemd/nfs-server-generator.c
+++ b/systemd/nfs-server-generator.c
@@ -89,6 +89,8 @@ int main(int argc, char *argv[])
 	struct list	*list =3D NULL;
 	FILE		*f, *fstab;
 	struct mntent	*mnt;
+	int		num_exports;
+	int		num_exports_d;
=20
 	/* Avoid using any external services */
 	xlog_syslog(0);
@@ -102,8 +104,16 @@ int main(int argc, char *argv[])
 	path =3D alloca(strlen(argv[1]) + sizeof(dirbase) + sizeof(filebase));
 	if (!path)
 		exit(2);
-	if (export_read(_PATH_EXPORTS, 1) +
-	    export_d_read(_PATH_EXPORTS_D, 1) =3D=3D 0)
+
+	num_exports =3D export_read(_PATH_EXPORTS, 1);
+	if (num_exports < 0)
+		exit(1);
+
+	num_exports_d =3D export_d_read(_PATH_EXPORTS_D, 1);
+	if (num_exports_d < 0)
+		exit(1);
+
+	if (num_exports + num_exports_d =3D=3D 0)
 		/* Nothing is exported, so nothing to do */
 		exit(0);
=20
diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index 7f21edcf..7a67c4d3 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -206,8 +206,14 @@ main(int argc, char **argv)
 	atexit(release_lockfile);
=20
 	if (f_export && ! f_ignore) {
-		if (! (export_read(_PATH_EXPORTS, 0) +
-		       export_d_read(_PATH_EXPORTS_D, 0))) {
+		int num_exports, num_exports_d;
+
+		num_exports =3D export_read(_PATH_EXPORTS, 0);
+		num_exports_d =3D export_d_read(_PATH_EXPORTS_D, 0);
+		if (num_exports < 0 || num_exports_d < 0)
+			return 1;
+
+		if (!(num_exports + num_exports_d)) {
 			if (f_verbose)
 				xlog(L_WARNING, "No file systems exported!");
 		}
--=20
2.31.1

