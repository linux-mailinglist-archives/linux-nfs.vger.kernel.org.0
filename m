Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96B84BA0FC
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 14:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238854AbiBQNXL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Feb 2022 08:23:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiBQNXJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 08:23:09 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA54399ECE
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 05:22:52 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A7713605DEBB;
        Thu, 17 Feb 2022 14:16:41 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id epkojYBpEXMZ; Thu, 17 Feb 2022 14:16:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 030CD60765A6;
        Thu, 17 Feb 2022 14:16:41 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id u5LINtTGGjJ2; Thu, 17 Feb 2022 14:16:40 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 5D644605DED6;
        Thu, 17 Feb 2022 14:16:40 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     david@sigma-star.at, bfields@fieldses.org,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        david.oberhollenzer@sigma-star.at, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, chris.chilvers@appsbroker.com,
        Richard Weinberger <richard@nod.at>
Subject: [RFC PATCH 6/6] export: Garbage collect orphaned subvolumes upon start
Date:   Thu, 17 Feb 2022 14:15:31 +0100
Message-Id: <20220217131531.2890-7-richard@nod.at>
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

Make sure the database contains no orphaned subvolumes.
We have to be careful.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 support/export/cache.c  | 97 +++++++++++++++++++++++++++++++++++++++++
 support/export/export.h |  3 ++
 utils/exportd/exportd.c | 17 +++++++-
 utils/mountd/mountd.c   |  1 +
 utils/mountd/svc_run.c  | 18 ++++++++
 5 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index b5763b1d..94a0d79a 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -1181,6 +1181,103 @@ lookup_export(char *dom, char *path, struct addri=
nfo *ai)
 	return found;
 }
=20
+static char *get_export_path(char *path)
+{
+	int i;
+	nfs_export *exp;
+	nfs_export *found =3D NULL;
+
+	for (i =3D 0; i < MCL_MAXTYPES; i++) {
+		for (exp =3D exportlist[i].p_head; exp; exp =3D exp->m_next) {
+			if (!path_matches(exp, path))
+				continue;
+
+			if (!found) {
+				found =3D exp;
+				continue;
+			}
+
+			/* Always prefer non-V4ROOT exports */
+			if (exp->m_export.e_flags & NFSEXP_V4ROOT)
+				continue;
+			if (found->m_export.e_flags & NFSEXP_V4ROOT) {
+				found =3D exp;
+				continue;
+			}
+
+			/* If one is a CROSSMOUNT, then prefer the longest path */
+			if (((found->m_export.e_flags & NFSEXP_CROSSMOUNT) ||
+			     (exp->m_export.e_flags & NFSEXP_CROSSMOUNT)) &&
+			    strlen(found->m_export.e_path) !=3D
+			    strlen(exp->m_export.e_path)) {
+
+				if (strlen(exp->m_export.e_path) >
+				    strlen(found->m_export.e_path)) {
+					found =3D exp;
+				}
+				continue;
+			}
+		}
+	}
+
+	if (found)
+		return found->m_export.e_path;
+	else
+		return NULL;
+}
+
+int export_subvol_orphaned(char *path)
+{
+	struct statfs st, stp;
+	char *path_parent;
+	int ret;
+
+	path_parent =3D get_export_path(path);
+	if (!path_parent)
+		/*
+		 * Path has no parent in export list.
+		 * Must be orphaned.
+		 */
+		return 1;
+
+	ret =3D statfs(path_parent, &stp);
+	if (ret =3D=3D -1)
+		/*
+		 * Parent path is not statfs'able. Maybe not yet mounted?
+		 * Can't be sure, don't treat path as orphaned.
+		 */
+		return 0;
+
+	if (strcmp(path_parent, path) =3D=3D 0)
+		/*
+		 * This is not a subvolume, it is listed in exports.
+		 * No need to keep tack of it.
+		 */
+		return 1;
+
+	if (stp.f_type !=3D 0x6969)
+		/*
+		 * Parent is not a NFS mount. Maybe not yet mounted?
+		 * Can't be sure either.
+		 */
+		return 0;
+
+	ret =3D statfs(path, &st);
+	if (ret =3D=3D -1) {
+		if (errno =3D=3D ENOENT)
+			/*
+			 * Parent is a NFS mount but path is gone.
+			 * Must be orphaned.
+			 */
+			return 1;
+	}
+
+	/*
+	 * For all remaining cases we can't be sure either.
+	 */
+	return 0;
+}
+
 #ifdef HAVE_JUNCTION_SUPPORT
=20
 #include <libxml/parser.h>
diff --git a/support/export/export.h b/support/export/export.h
index 8d5a0d30..45dd3da4 100644
--- a/support/export/export.h
+++ b/support/export/export.h
@@ -38,4 +38,7 @@ static inline bool is_ipaddr_client(char *dom)
 {
 	return dom[0] =3D=3D '$';
 }
+
+int export_subvol_orphaned(char *path);
+
 #endif /* EXPORT__H */
diff --git a/utils/exportd/exportd.c b/utils/exportd/exportd.c
index 4ddfed35..6dc51a32 100644
--- a/utils/exportd/exportd.c
+++ b/utils/exportd/exportd.c
@@ -208,6 +208,12 @@ read_exportd_conf(char *progname, char **argv)
 		default_ttl =3D ttl;
 }
=20
+static void subvol_cb(char *path)
+{
+	if (export_subvol_orphaned(path))
+		reexpdb_drop_subvolume_unlocked(path);
+}
+
 int
 main(int argc, char **argv)
 {
@@ -297,7 +303,16 @@ main(int argc, char **argv)
 	/* Open files now to avoid sharing descriptors among forked processes *=
/
 	cache_open();
 	v4clients_init();
-	reexpdb_init();
+	if (reexpdb_init() !=3D 0) {
+		xlog(L_ERROR, "%s: Failed to init reexport database", __func__);
+		exit(1);
+	}
+
+	/*
+	 * Load exports into memory and garbage collect orphaned subvolumes.
+	 */
+	auth_reload();
+	reexpdb_uncover_subvolumes(subvol_cb);
=20
 	/* Process incoming upcalls */
 	cache_process_loop();
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
index 167b9757..9a891ff0 100644
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
@@ -87,6 +88,12 @@ my_svc_getreqset (fd_set *readfds)
=20
 #endif
=20
+static void subvol_cb(char *path)
+{
+	if (export_subvol_orphaned(path))
+		reexpdb_drop_subvolume_unlocked(path);
+}
+
 /*
  * The heart of the server.  A crib from libc for the most part...
  */
@@ -96,6 +103,17 @@ my_svc_run(void)
 	fd_set	readfds;
 	int	selret;
=20
+	if (reexpdb_init() !=3D 0) {
+		xlog(L_ERROR, "%s: Failed to init reexport database", __func__);
+		return;
+	}
+
+	/*
+	 * Load exports into memory and garbage collect orphaned subvolumes.
+	 */
+	auth_reload();
+	reexpdb_uncover_subvolumes(subvol_cb);
+
 	for (;;) {
=20
 		readfds =3D svc_fdset;
--=20
2.31.1

