Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9091E52C74B
	for <lists+linux-nfs@lfdr.de>; Thu, 19 May 2022 01:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiERXFt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 May 2022 19:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiERXFs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 May 2022 19:05:48 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72A3242
        for <linux-nfs@vger.kernel.org>; Wed, 18 May 2022 16:05:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B21966081104;
        Thu, 19 May 2022 01:05:40 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ezB2VAGgf4R5; Thu, 19 May 2022 01:05:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6B4BD608110A;
        Thu, 19 May 2022 01:05:39 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zdCOymEa7ngi; Thu, 19 May 2022 01:05:39 +0200 (CEST)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id DA0FA6081104;
        Thu, 19 May 2022 01:05:38 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     david@sigma-star.at, bfields@fieldses.org,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        david.oberhollenzer@sigma-star.at, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, chris.chilvers@appsbroker.com,
        steved@redhat.com, Richard Weinberger <richard@nod.at>
Subject: [PATCH] RFC: Reexport state database backend plugin support
Date:   Thu, 19 May 2022 01:05:13 +0200
Message-Id: <20220518230513.15307-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
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

Since I talked about the feature already I though it is time to show some=
 code.

sqlite is not a perfect fit for everyone.
Especially when the re-exporting NFS server is part of a load balancer,
a more sophisticated distributed database is preferable.
This RFC patch implements support for different databases using a simple
plugin interface on top of my previous patch series.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 support/reexport/Makefile.am        |   7 +
 support/reexport/backend_sqlite.c   | 251 ++++++++++++++++++++++++++++
 support/reexport/reexport.c         | 237 +++-----------------------
 support/reexport/reexport_backend.h |  48 ++++++
 systemd/Makefile.am                 |   2 +-
 systemd/nfs.conf.man                |   5 +-
 utils/exportd/Makefile.am           |   2 +-
 utils/exportfs/Makefile.am          |   2 +-
 utils/mount/Makefile.am             |   4 +-
 utils/mountd/Makefile.am            |   2 +-
 10 files changed, 335 insertions(+), 225 deletions(-)
 create mode 100644 support/reexport/backend_sqlite.c
 create mode 100644 support/reexport/reexport_backend.h

diff --git a/support/reexport/Makefile.am b/support/reexport/Makefile.am
index 9d544a8f..d45007be 100644
--- a/support/reexport/Makefile.am
+++ b/support/reexport/Makefile.am
@@ -3,4 +3,11 @@
 noinst_LIBRARIES =3D libreexport.a
 libreexport_a_SOURCES =3D reexport.c
=20
+pkgplugindir=3D$(libdir)/libnfsreexport_backends/
+pkgplugin_LTLIBRARIES =3D sqlite.la
+
+sqlite_la_SOURCES =3D backend_sqlite.c
+sqlite_la_LDFLAGS =3D -module -avoid-version
+sqlite_la_LIBADD =3D ../../support/nfs/libnfsconf.la $(LIBSQLITE)
+
 MAINTAINERCLEANFILES =3D Makefile.in
diff --git a/support/reexport/backend_sqlite.c b/support/reexport/backend=
_sqlite.c
new file mode 100644
index 00000000..a54d64ea
--- /dev/null
+++ b/support/reexport/backend_sqlite.c
@@ -0,0 +1,251 @@
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <sqlite3.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/random.h>
+#include <unistd.h>
+
+#include "conffile.h"
+#include "reexport_backend.h"
+#include "xlog.h"
+
+#define REEXPDB_DBFILE NFS_STATEDIR "/reexpdb.sqlite3"
+#define REEXPDB_DBFILE_WAIT_USEC (5000)
+
+static sqlite3 *db;
+static int init_done;
+
+static int prng_init(void)
+{
+	int seed;
+
+	if (getrandom(&seed, sizeof(seed), 0) !=3D sizeof(seed)) {
+		xlog(L_ERROR, "Unable to obtain seed for PRNG via getrandom()");
+		return -1;
+	}
+
+	srand(seed);
+	return 0;
+}
+
+static void wait_for_dbaccess(void)
+{
+	usleep(REEXPDB_DBFILE_WAIT_USEC + (rand() % REEXPDB_DBFILE_WAIT_USEC));
+}
+
+static bool sqlite_plug_init(void)
+{
+	char *sqlerr;
+	int ret;
+
+	if (init_done)
+		return true;
+
+	if (prng_init() !=3D 0)
+		return false;
+
+	ret =3D sqlite3_open_v2(conf_get_str_with_def("reexport", "sqlitedb", R=
EEXPDB_DBFILE),
+			      &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE | SQLITE_OPEN_F=
ULLMUTEX,
+			      NULL);
+	if (ret !=3D SQLITE_OK) {
+		xlog(L_ERROR, "Unable to open reexport database: %s", sqlite3_errstr(r=
et));
+		return false;
+	}
+
+again:
+	ret =3D sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS fsidnums (num INTE=
GER PRIMARY KEY CHECK (num > 0 AND num < 4294967296), path TEXT UNIQUE); =
CREATE INDEX IF NOT EXISTS idx_ids_path ON fsidnums (path);", NULL, NULL,=
 &sqlerr);
+	switch (ret) {
+	case SQLITE_OK:
+		init_done =3D 1;
+		ret =3D 0;
+		break;
+	case SQLITE_BUSY:
+	case SQLITE_LOCKED:
+		wait_for_dbaccess();
+		goto again;
+	default:
+		xlog(L_ERROR, "Unable to init reexport database: %s", sqlite3_errstr(r=
et));
+		sqlite3_free(sqlerr);
+		sqlite3_close_v2(db);
+		ret =3D -1;
+	}
+
+	return ret =3D=3D 0 ? true : false;
+}
+
+static void sqlite_plug_destroy(void)
+{
+	if (!init_done)
+		return;
+
+	sqlite3_close_v2(db);
+}
+
+static bool get_fsidnum_by_path(char *path, uint32_t *fsidnum)
+{
+	static const char fsidnum_by_path_sql[] =3D "SELECT num FROM fsidnums W=
HERE path =3D ?1;";
+	sqlite3_stmt *stmt =3D NULL;
+	bool found =3D false;
+	int ret;
+
+	ret =3D sqlite3_prepare_v2(db, fsidnum_by_path_sql, sizeof(fsidnum_by_p=
ath_sql), &stmt, NULL);
+	if (ret !=3D SQLITE_OK) {
+		xlog(L_WARNING, "Unable to prepare SQL query '%s': %s", fsidnum_by_pat=
h_sql, sqlite3_errstr(ret));
+		goto out;
+	}
+
+	ret =3D sqlite3_bind_text(stmt, 1, path, -1, NULL);
+	if (ret !=3D SQLITE_OK) {
+		xlog(L_WARNING, "Unable to bind SQL query '%s': %s", fsidnum_by_path_s=
ql, sqlite3_errstr(ret));
+		goto out;
+	}
+
+again:
+	ret =3D sqlite3_step(stmt);
+	switch (ret) {
+	case SQLITE_ROW:
+		*fsidnum =3D sqlite3_column_int(stmt, 0);
+		found =3D true;
+		break;
+	case SQLITE_DONE:
+		/* No hit */
+		found =3D false;
+		break;
+	case SQLITE_BUSY:
+	case SQLITE_LOCKED:
+		wait_for_dbaccess();
+		goto again;
+	default:
+		xlog(L_WARNING, "Error while looking up '%s' in database: %s", path, s=
qlite3_errstr(ret));
+	}
+
+out:
+	sqlite3_finalize(stmt);
+	return found;
+}
+
+static bool sqlite_plug_path_by_fsidnum(uint32_t fsidnum, char **path)
+{
+	static const char path_by_fsidnum_sql[] =3D "SELECT path FROM fsidnums =
WHERE num =3D ?1;";
+	sqlite3_stmt *stmt =3D NULL;
+	bool found =3D false;
+	int ret;
+
+	ret =3D sqlite3_prepare_v2(db, path_by_fsidnum_sql, sizeof(path_by_fsid=
num_sql), &stmt, NULL);
+	if (ret !=3D SQLITE_OK) {
+		xlog(L_WARNING, "Unable to prepare SQL query '%s': %s", path_by_fsidnu=
m_sql, sqlite3_errstr(ret));
+		goto out;
+	}
+
+	ret =3D sqlite3_bind_int(stmt, 1, fsidnum);
+	if (ret !=3D SQLITE_OK) {
+		xlog(L_WARNING, "Unable to bind SQL query '%s': %s", path_by_fsidnum_s=
ql, sqlite3_errstr(ret));
+		goto out;
+	}
+
+again:
+	ret =3D sqlite3_step(stmt);
+	switch (ret) {
+	case SQLITE_ROW:
+		*path =3D strdup((char *)sqlite3_column_text(stmt, 0));
+		if (*path)
+			found =3D true;
+		break;
+	case SQLITE_DONE:
+		/* No hit */
+		found =3D false;
+		break;
+	case SQLITE_BUSY:
+	case SQLITE_LOCKED:
+		wait_for_dbaccess();
+		goto again;
+	default:
+		xlog(L_WARNING, "Error while looking up '%i' in database: %s", fsidnum=
, sqlite3_errstr(ret));
+	}
+
+out:
+	sqlite3_finalize(stmt);
+	return found;
+}
+
+static bool new_fsidnum_by_path(char *path, uint32_t *fsidnum)
+{
+	/*
+	 * This query is a little tricky. We use SQL to find and claim the smal=
lest free fsid number.
+	 * To find a free fsid the fsidnums is left joined to itself but with a=
n offset of 1.
+	 * Everything after the UNION statement is to handle the corner case wh=
ere fsidnums
+	 * is empty. In this case we want 1 as first fsid number.
+	 */
+	static const char new_fsidnum_by_path_sql[] =3D "INSERT INTO fsidnums V=
ALUES ((SELECT ids1.num + 1 FROM fsidnums AS ids1 LEFT JOIN fsidnums AS i=
ds2 ON ids2.num =3D ids1.num + 1 WHERE ids2.num IS NULL UNION SELECT 1 WH=
ERE NOT EXISTS (SELECT NULL FROM fsidnums WHERE num =3D 1) LIMIT 1), ?1) =
RETURNING num;";
+
+	sqlite3_stmt *stmt =3D NULL;
+	int ret, check =3D 0;
+	bool found =3D false;
+
+	ret =3D sqlite3_prepare_v2(db, new_fsidnum_by_path_sql, sizeof(new_fsid=
num_by_path_sql), &stmt, NULL);
+	if (ret !=3D SQLITE_OK) {
+		xlog(L_WARNING, "Unable to prepare SQL query '%s': %s", new_fsidnum_by=
_path_sql, sqlite3_errstr(ret));
+		goto out;
+	}
+
+	ret =3D sqlite3_bind_text(stmt, 1, path, -1, NULL);
+	if (ret !=3D SQLITE_OK) {
+		xlog(L_WARNING, "Unable to bind SQL query '%s': %s", new_fsidnum_by_pa=
th_sql, sqlite3_errstr(ret));
+		goto out;
+	}
+
+again:
+	ret =3D sqlite3_step(stmt);
+	switch (ret) {
+	case SQLITE_ROW:
+		*fsidnum =3D sqlite3_column_int(stmt, 0);
+		found =3D true;
+		break;
+	case SQLITE_CONSTRAINT:
+		/* Maybe we lost the race against another writer and the path is now p=
resent. */
+		check =3D 1;
+		break;
+	case SQLITE_BUSY:
+	case SQLITE_LOCKED:
+		wait_for_dbaccess();
+		goto again;
+	default:
+		xlog(L_WARNING, "Error while looking up '%s' in database: %s", path, s=
qlite3_errstr(ret));
+	}
+
+out:
+	sqlite3_finalize(stmt);
+
+	if (check) {
+		found =3D get_fsidnum_by_path(path, fsidnum);
+		if (!found)
+			xlog(L_WARNING, "SQLITE_CONSTRAINT error while inserting '%s' in data=
base", path);
+	}
+
+	return found;
+}
+
+static bool sqlite_plug_fsidnum_by_path(char *path, uint32_t *fsidnum, i=
nt may_create)
+{
+	bool found;
+
+	found =3D get_fsidnum_by_path(path, fsidnum);
+
+	if (!found && may_create)
+		found =3D new_fsidnum_by_path(path, fsidnum);
+
+	return found;
+}
+
+struct reexpdb_backend_plugin plug_ops =3D {
+	.fsidnum_by_path =3D sqlite_plug_fsidnum_by_path,
+	.path_by_fsidnum =3D sqlite_plug_path_by_fsidnum,
+	.initdb =3D sqlite_plug_init,
+	.destroydb =3D sqlite_plug_destroy,
+};
+
diff --git a/support/reexport/reexport.c b/support/reexport/reexport.c
index 61574fc5..112fcfb9 100644
--- a/support/reexport/reexport.c
+++ b/support/reexport/reexport.c
@@ -2,7 +2,7 @@
 #include <config.h>
 #endif
=20
-#include <sqlite3.h>
+#include <dlfcn.h>
 #include <stdint.h>
 #include <stdio.h>
 #include <sys/random.h>
@@ -15,228 +15,38 @@
 #include "conffile.h"
 #include "nfslib.h"
 #include "reexport.h"
+#include "reexport_backend.h"
 #include "xcommon.h"
 #include "xlog.h"
=20
-#define REEXPDB_DBFILE NFS_STATEDIR "/reexpdb.sqlite3"
-#define REEXPDB_DBFILE_WAIT_USEC (5000)
+struct reexpdb_backend_plugin *plg;
+static void *backend_dl;
=20
-static sqlite3 *db;
-static int init_done;
-
-static int prng_init(void)
-{
-	int seed;
-
-	if (getrandom(&seed, sizeof(seed), 0) !=3D sizeof(seed)) {
-		xlog(L_ERROR, "Unable to obtain seed for PRNG via getrandom()");
-		return -1;
-	}
-
-	srand(seed);
-	return 0;
-}
-
-static void wait_for_dbaccess(void)
-{
-	usleep(REEXPDB_DBFILE_WAIT_USEC + (rand() % REEXPDB_DBFILE_WAIT_USEC));
-}
-
-/*
- * reexpdb_init - Initialize reexport database
- */
 int reexpdb_init(void)
 {
-	char *sqlerr;
-	int ret;
-
-	if (init_done)
-		return 0;
+	char *sofile =3D conf_get_str_with_def("reexport", "backend_plugin", RE=
EXPDB_BACKEND_DEFAULT);
=20
-	if (prng_init() !=3D 0)
-		return -1;
-
-	ret =3D sqlite3_open_v2(conf_get_str_with_def("reexport", "sqlitedb", R=
EEXPDB_DBFILE),
-			      &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE | SQLITE_OPEN_F=
ULLMUTEX,
-			      NULL);
-	if (ret !=3D SQLITE_OK) {
-		xlog(L_ERROR, "Unable to open reexport database: %s", sqlite3_errstr(r=
et));
+	backend_dl =3D dlopen(sofile, RTLD_NOW | RTLD_LOCAL);
+	if (!backend_dl) {
+		xlog(L_WARNING, "Unable to open %s: %s", sofile, dlerror());
 		return -1;
 	}
=20
-again:
-	ret =3D sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS fsidnums (num INTE=
GER PRIMARY KEY CHECK (num > 0 AND num < 4294967296), path TEXT UNIQUE); =
CREATE INDEX IF NOT EXISTS idx_ids_path ON fsidnums (path);", NULL, NULL,=
 &sqlerr);
-	switch (ret) {
-	case SQLITE_OK:
-		init_done =3D 1;
-		ret =3D 0;
-		break;
-	case SQLITE_BUSY:
-	case SQLITE_LOCKED:
-		wait_for_dbaccess();
-		goto again;
-	default:
-		xlog(L_ERROR, "Unable to init reexport database: %s", sqlite3_errstr(r=
et));
-		sqlite3_free(sqlerr);
-		sqlite3_close_v2(db);
-		ret =3D -1;
+	plg =3D (struct reexpdb_backend_plugin *)dlsym(backend_dl, REEXPDB_BACK=
END_OPS);
+	if (plg =3D=3D NULL) {
+		xlog(L_WARNING, "Unable to locate plug_ops in %s: %s", sofile, dlerror=
());
+		dlclose(backend_dl);
+		return -1;
 	}
=20
-	return ret;
+	return plg->initdb() =3D=3D true;
 }
=20
-/*
- * reexpdb_destroy - Undo reexpdb_init().
- */
 void reexpdb_destroy(void)
 {
-	if (!init_done)
-		return;
-
-	sqlite3_close_v2(db);
-}
-
-static int get_fsidnum_by_path(char *path, uint32_t *fsidnum)
-{
-	static const char fsidnum_by_path_sql[] =3D "SELECT num FROM fsidnums W=
HERE path =3D ?1;";
-	sqlite3_stmt *stmt =3D NULL;
-	int found =3D 0;
-	int ret;
-
-	ret =3D sqlite3_prepare_v2(db, fsidnum_by_path_sql, sizeof(fsidnum_by_p=
ath_sql), &stmt, NULL);
-	if (ret !=3D SQLITE_OK) {
-		xlog(L_WARNING, "Unable to prepare SQL query '%s': %s", fsidnum_by_pat=
h_sql, sqlite3_errstr(ret));
-		goto out;
-	}
-
-	ret =3D sqlite3_bind_text(stmt, 1, path, -1, NULL);
-	if (ret !=3D SQLITE_OK) {
-		xlog(L_WARNING, "Unable to bind SQL query '%s': %s", fsidnum_by_path_s=
ql, sqlite3_errstr(ret));
-		goto out;
-	}
-
-again:
-	ret =3D sqlite3_step(stmt);
-	switch (ret) {
-	case SQLITE_ROW:
-		*fsidnum =3D sqlite3_column_int(stmt, 0);
-		found =3D 1;
-		break;
-	case SQLITE_DONE:
-		/* No hit */
-		found =3D 0;
-		break;
-	case SQLITE_BUSY:
-	case SQLITE_LOCKED:
-		wait_for_dbaccess();
-		goto again;
-	default:
-		xlog(L_WARNING, "Error while looking up '%s' in database: %s", path, s=
qlite3_errstr(ret));
-	}
-
-out:
-	sqlite3_finalize(stmt);
-	return found;
-}
-
-static int get_path_by_fsidnum(uint32_t fsidnum, char **path)
-{
-	static const char path_by_fsidnum_sql[] =3D "SELECT path FROM fsidnums =
WHERE num =3D ?1;";
-	sqlite3_stmt *stmt =3D NULL;
-	int found =3D 0;
-	int ret;
-
-	ret =3D sqlite3_prepare_v2(db, path_by_fsidnum_sql, sizeof(path_by_fsid=
num_sql), &stmt, NULL);
-	if (ret !=3D SQLITE_OK) {
-		xlog(L_WARNING, "Unable to prepare SQL query '%s': %s", path_by_fsidnu=
m_sql, sqlite3_errstr(ret));
-		goto out;
-	}
-
-	ret =3D sqlite3_bind_int(stmt, 1, fsidnum);
-	if (ret !=3D SQLITE_OK) {
-		xlog(L_WARNING, "Unable to bind SQL query '%s': %s", path_by_fsidnum_s=
ql, sqlite3_errstr(ret));
-		goto out;
-	}
-
-again:
-	ret =3D sqlite3_step(stmt);
-	switch (ret) {
-	case SQLITE_ROW:
-		*path =3D xstrdup((char *)sqlite3_column_text(stmt, 0));
-		found =3D 1;
-		break;
-	case SQLITE_DONE:
-		/* No hit */
-		found =3D 0;
-		break;
-	case SQLITE_BUSY:
-	case SQLITE_LOCKED:
-		wait_for_dbaccess();
-		goto again;
-	default:
-		xlog(L_WARNING, "Error while looking up '%i' in database: %s", fsidnum=
, sqlite3_errstr(ret));
-	}
-
-out:
-	sqlite3_finalize(stmt);
-	return found;
-}
-
-static int new_fsidnum_by_path(char *path, uint32_t *fsidnum)
-{
-	/*
-	 * This query is a little tricky. We use SQL to find and claim the smal=
lest free fsid number.
-	 * To find a free fsid the fsidnums is left joined to itself but with a=
n offset of 1.
-	 * Everything after the UNION statement is to handle the corner case wh=
ere fsidnums
-	 * is empty. In this case we want 1 as first fsid number.
-	 */
-	static const char new_fsidnum_by_path_sql[] =3D "INSERT INTO fsidnums V=
ALUES ((SELECT ids1.num + 1 FROM fsidnums AS ids1 LEFT JOIN fsidnums AS i=
ds2 ON ids2.num =3D ids1.num + 1 WHERE ids2.num IS NULL UNION SELECT 1 WH=
ERE NOT EXISTS (SELECT NULL FROM fsidnums WHERE num =3D 1) LIMIT 1), ?1) =
RETURNING num;";
-
-	sqlite3_stmt *stmt =3D NULL;
-	int found =3D 0, check =3D 0;
-	int ret;
-
-	ret =3D sqlite3_prepare_v2(db, new_fsidnum_by_path_sql, sizeof(new_fsid=
num_by_path_sql), &stmt, NULL);
-	if (ret !=3D SQLITE_OK) {
-		xlog(L_WARNING, "Unable to prepare SQL query '%s': %s", new_fsidnum_by=
_path_sql, sqlite3_errstr(ret));
-		goto out;
-	}
-
-	ret =3D sqlite3_bind_text(stmt, 1, path, -1, NULL);
-	if (ret !=3D SQLITE_OK) {
-		xlog(L_WARNING, "Unable to bind SQL query '%s': %s", new_fsidnum_by_pa=
th_sql, sqlite3_errstr(ret));
-		goto out;
-	}
-
-again:
-	ret =3D sqlite3_step(stmt);
-	switch (ret) {
-	case SQLITE_ROW:
-		*fsidnum =3D sqlite3_column_int(stmt, 0);
-		found =3D 1;
-		break;
-	case SQLITE_CONSTRAINT:
-		/* Maybe we lost the race against another writer and the path is now p=
resent. */
-		check =3D 1;
-		break;
-	case SQLITE_BUSY:
-	case SQLITE_LOCKED:
-		wait_for_dbaccess();
-		goto again;
-	default:
-		xlog(L_WARNING, "Error while looking up '%s' in database: %s", path, s=
qlite3_errstr(ret));
-	}
-
-out:
-	sqlite3_finalize(stmt);
-
-	if (check) {
-		found =3D get_fsidnum_by_path(path, fsidnum);
-		if (!found)
-			xlog(L_WARNING, "SQLITE_CONSTRAINT error while inserting '%s' in data=
base", path);
-	}
-
-	return found;
+	plg->destroydb();
+	plg =3D NULL;
+	dlclose(backend_dl);
 }
=20
 /*
@@ -249,14 +59,7 @@ out:
  */
 int reexpdb_fsidnum_by_path(char *path, uint32_t *fsidnum, int may_creat=
e)
 {
-	int found;
-
-	found =3D get_fsidnum_by_path(path, fsidnum);
-
-	if (!found && may_create)
-		found =3D new_fsidnum_by_path(path, fsidnum);
-
-	return found;
+	return plg->fsidnum_by_path(path, fsidnum, may_create);
 }
=20
 /*
@@ -278,7 +81,7 @@ void reexpdb_uncover_subvolume(uint32_t fsidnum)
 	char *path =3D NULL;
 	int ret;
=20
-	if (get_path_by_fsidnum(fsidnum, &path)) {
+	if (plg->path_by_fsidnum(fsidnum, &path)) {
 		ret =3D nfsd_path_statfs64(path, &st);
 		if (ret =3D=3D -1)
 			xlog(L_WARNING, "statfs() failed");
@@ -300,7 +103,7 @@ void reexpdb_uncover_subvolume(uint32_t fsidnum)
 int reexpdb_apply_reexport_settings(struct exportent *ep, char *flname, =
int flline)
 {
 	uint32_t fsidnum;
-	int found;
+	bool found;
 	int ret =3D 0;
=20
 	if (ep->e_reexport =3D=3D REEXP_NONE)
diff --git a/support/reexport/reexport_backend.h b/support/reexport/reexp=
ort_backend.h
new file mode 100644
index 00000000..9e5e5c43
--- /dev/null
+++ b/support/reexport/reexport_backend.h
@@ -0,0 +1,48 @@
+#ifndef REEXPORT_BACKEND_H
+#define REEXPORT_BACKEND_H
+
+#define REEXPDB_BACKEND_DEFAULT "sqlite.so"
+#define REEXPDB_BACKEND_OPS "plug_ops"
+
+struct reexpdb_backend_plugin {
+	/*
+	 * Find or allocate a fsidnum for a given path.
+	 *
+	 * @path: Path to look for
+	 * @fsidnum: Pointer to an uint32_t variable
+	 * @may_create: If non-zero, a fsidnum will be allocated if none was fo=
und
+	 *
+	 * Returns true if either an fsidnum was found or successfully allocate=
d,
+	 * false otherwise.
+	 * On success, the fsidnum will be stored into @fsidnum.
+	 * Upon errors, false is returned and errors are logged.
+	 */
+	bool (*fsidnum_by_path)(char *path, uint32_t *fsidnum, int may_create);
+
+	/*
+	 * Lookup path by a given fsidnum
+	 *
+	 * @fsidnum: fsidnum to look for
+	 * @path: address of a char pointer
+	 *
+	 * Returns true if a path was found, false otherwise.
+	 * Upon errors, false is returned and errors are logged.
+	 * In case of success, the function returns the found path
+	 * via @path, @path will point to a freshly allocated buffer
+	 * which is free()'able.
+	 */
+	bool (*path_by_fsidnum)(uint32_t fsidnum, char **path);
+
+	/*
+	 * Init database connection, can get called multiple times.
+	 * Returns true on success, false otherwise.
+	 */
+	bool (*initdb)(void);
+
+	/*
+	 * Undoes initdb().
+	 */
+	void (*destroydb)(void);
+};
+
+#endif /* REEXPORT_BACKEND_H */
diff --git a/systemd/Makefile.am b/systemd/Makefile.am
index f254b218..70182600 100644
--- a/systemd/Makefile.am
+++ b/systemd/Makefile.am
@@ -70,7 +70,7 @@ nfs_server_generator_LDADD =3D ../support/export/libexp=
ort.a \
 			     $(LIBPTHREAD)
=20
 if CONFIG_REEXPORT
-nfs_server_generator_LDADD +=3D ../support/reexport/libreexport.a $(LIBS=
QLITE) -lrt
+nfs_server_generator_LDADD +=3D ../support/reexport/libreexport.a -ldl
 endif
=20
 rpc_pipefs_generator_LDADD =3D ../support/nfs/libnfs.la
diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
index afd2b3f8..0d083171 100644
--- a/systemd/nfs.conf.man
+++ b/systemd/nfs.conf.man
@@ -297,9 +297,10 @@ is recognized.
=20
 .TP
 .B reexport
-Only
 .B sqlitedb=3D
-is recognized, path to the state database.
+, path to the state database, if sqlite backend is used.
+.B backend_plugin=3D
+, path to database backend plugin, default is sqlite.so.
=20
 .SH FILES
 .TP 10n
diff --git a/utils/exportd/Makefile.am b/utils/exportd/Makefile.am
index b0ec9034..6f23ed97 100644
--- a/utils/exportd/Makefile.am
+++ b/utils/exportd/Makefile.am
@@ -19,7 +19,7 @@ exportd_LDADD =3D ../../support/export/libexport.a \
 			$(OPTLIBS) $(LIBBLKID) $(LIBPTHREAD) \
 			-luuid
 if CONFIG_REEXPORT
-exportd_LDADD +=3D ../../support/reexport/libreexport.a $(LIBSQLITE) -lr=
t
+exportd_LDADD +=3D ../../support/reexport/libreexport.a -ldl
 endif
=20
 exportd_CPPFLAGS =3D $(AM_CPPFLAGS) $(CPPFLAGS) \
diff --git a/utils/exportfs/Makefile.am b/utils/exportfs/Makefile.am
index 451637a0..a17ed130 100644
--- a/utils/exportfs/Makefile.am
+++ b/utils/exportfs/Makefile.am
@@ -13,7 +13,7 @@ exportfs_LDADD =3D ../../support/export/libexport.a \
 		 $(LIBWRAP) $(LIBNSL) $(LIBPTHREAD)
=20
 if CONFIG_REEXPORT
-exportfs_LDADD +=3D ../../support/reexport/libreexport.a $(LIBSQLITE) -l=
rt
+exportfs_LDADD +=3D ../../support/reexport/libreexport.a -ldl
 endif
=20
 exportfs_CPPFLAGS =3D $(AM_CPPFLAGS) $(CPPFLAGS) -I$(top_srcdir)/support=
/reexport
diff --git a/utils/mount/Makefile.am b/utils/mount/Makefile.am
index 0268488c..d569b127 100644
--- a/utils/mount/Makefile.am
+++ b/utils/mount/Makefile.am
@@ -33,9 +33,9 @@ mount_nfs_LDADD =3D ../../support/nfs/libnfs.la \
 		  $(LIBTIRPC)
=20
 if CONFIG_REEXPORT
-mount_nfs_LDADD +=3D ../../support/reexport/libreexport.a \
+mount_nfs_LDADD +=3D ../../support/reexport/libreexport.a -ldl \
 		   ../../support/misc/libmisc.a \
-		   $(LIBSQLITE) -lrt $(LIBPTHREAD)
+		   -lrt $(LIBPTHREAD)
 endif
=20
=20
diff --git a/utils/mountd/Makefile.am b/utils/mountd/Makefile.am
index 569d335a..d9a5c374 100644
--- a/utils/mountd/Makefile.am
+++ b/utils/mountd/Makefile.am
@@ -21,7 +21,7 @@ mountd_LDADD =3D ../../support/export/libexport.a \
 	       $(LIBBSD) $(LIBWRAP) $(LIBNSL) $(LIBBLKID) -luuid $(LIBTIRPC) \
 	       $(LIBPTHREAD)
 if CONFIG_REEXPORT
-mountd_LDADD +=3D ../../support/reexport/libreexport.a $(LIBSQLITE) -lrt
+mountd_LDADD +=3D ../../support/reexport/libreexport.a -ldl
 endif
=20
 mountd_CPPFLAGS =3D $(AM_CPPFLAGS) $(CPPFLAGS) \
--=20
2.31.1

