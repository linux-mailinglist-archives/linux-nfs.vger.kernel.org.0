Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2236E5D7F
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Apr 2023 11:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjDRJec (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Apr 2023 05:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjDRJeX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Apr 2023 05:34:23 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D7E5596
        for <linux-nfs@vger.kernel.org>; Tue, 18 Apr 2023 02:34:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 33CEF64548AF;
        Tue, 18 Apr 2023 11:34:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id b_tpgwT8aUka; Tue, 18 Apr 2023 11:34:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7C1F36431C58;
        Tue, 18 Apr 2023 11:34:14 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OnY6b6er0FND; Tue, 18 Apr 2023 11:34:14 +0200 (CEST)
Received: from blindfold.corp.sigma-star.at (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 13F3064548AB;
        Tue, 18 Apr 2023 11:34:14 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     david@sigma-star.at, david.oberhollenzer@sigma-star.at,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com, chris.chilvers@appsbroker.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 6/8] reexport: Add sqlite backend
Date:   Tue, 18 Apr 2023 11:33:48 +0200
Message-Id: <20230418093350.4550-7-richard@nod.at>
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

The reexport database code is designed to support multiple ways
to store the state.
So far only SQlite is implemented.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 support/reexport/backend_sqlite.c   | 267 ++++++++++++++++++++++++++++
 support/reexport/reexport_backend.h |  47 +++++
 2 files changed, 314 insertions(+)
 create mode 100644 support/reexport/backend_sqlite.c
 create mode 100644 support/reexport/reexport_backend.h

diff --git a/support/reexport/backend_sqlite.c b/support/reexport/backend=
_sqlite.c
new file mode 100644
index 00000000..132f30c4
--- /dev/null
+++ b/support/reexport/backend_sqlite.c
@@ -0,0 +1,267 @@
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
+static bool get_fsidnum_by_path(char *path, uint32_t *fsidnum, bool *fou=
nd)
+{
+	static const char fsidnum_by_path_sql[] =3D "SELECT num FROM fsidnums W=
HERE path =3D ?1;";
+	sqlite3_stmt *stmt =3D NULL;
+	bool success =3D false;
+	int ret;
+
+	*found =3D false;
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
+		success =3D true;
+		*found =3D true;
+		break;
+	case SQLITE_DONE:
+		/* No hit */
+		success =3D true;
+		*found =3D false;
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
+	return success;
+}
+
+static bool sqlite_plug_path_by_fsidnum(uint32_t fsidnum, char **path, b=
ool *found)
+{
+	static const char path_by_fsidnum_sql[] =3D "SELECT path FROM fsidnums =
WHERE num =3D ?1;";
+	sqlite3_stmt *stmt =3D NULL;
+	bool success =3D false;
+	int ret;
+
+	*found =3D false;
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
+		if (*path) {
+			*found =3D true;
+			success =3D true;
+		} else {
+			xlog(L_WARNING, "Out of memory");
+		}
+		break;
+	case SQLITE_DONE:
+		/* No hit */
+		*found =3D false;
+		success =3D true;
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
+	return success;
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
+	bool success =3D false;
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
+		success =3D true;
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
+		bool found =3D false;
+
+		get_fsidnum_by_path(path, fsidnum, &found);
+		if (!found)
+			xlog(L_WARNING, "SQLITE_CONSTRAINT error while inserting '%s' in data=
base", path);
+	}
+
+	return success;
+}
+
+static bool sqlite_plug_fsidnum_by_path(char *path, uint32_t *fsidnum, i=
nt may_create, bool *found)
+{
+	bool success;
+
+	success =3D get_fsidnum_by_path(path, fsidnum, found);
+	if (success) {
+		if (!*found && may_create) {
+			success =3D new_fsidnum_by_path(path, fsidnum);
+			if (success)
+				*found =3D true;
+		}
+	}
+
+	return success;
+}
+
+struct reexpdb_backend_plugin sqlite_plug_ops =3D {
+	.fsidnum_by_path =3D sqlite_plug_fsidnum_by_path,
+	.path_by_fsidnum =3D sqlite_plug_path_by_fsidnum,
+	.initdb =3D sqlite_plug_init,
+	.destroydb =3D sqlite_plug_destroy,
+};
diff --git a/support/reexport/reexport_backend.h b/support/reexport/reexp=
ort_backend.h
new file mode 100644
index 00000000..4940f06f
--- /dev/null
+++ b/support/reexport/reexport_backend.h
@@ -0,0 +1,47 @@
+#ifndef REEXPORT_BACKEND_H
+#define REEXPORT_BACKEND_H
+
+extern struct reexpdb_backend_plugin sqlite_plug_ops;
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
+	bool (*fsidnum_by_path)(char *path, uint32_t *fsidnum, int may_create, =
bool *found);
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
+	bool (*path_by_fsidnum)(uint32_t fsidnum, char **path, bool *found);
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
--=20
2.31.1

