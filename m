Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4B46D5EBB
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Apr 2023 13:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbjDDLNW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Apr 2023 07:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbjDDLNV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Apr 2023 07:13:21 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A8919B6
        for <linux-nfs@vger.kernel.org>; Tue,  4 Apr 2023 04:13:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9606A64548A5;
        Tue,  4 Apr 2023 13:13:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UBQKpiIQ0_0D; Tue,  4 Apr 2023 13:13:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9AE7464548A3;
        Tue,  4 Apr 2023 13:13:14 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ugVogZ_Mhnue; Tue,  4 Apr 2023 13:13:14 +0200 (CEST)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 0E8956431C2D;
        Tue,  4 Apr 2023 13:13:14 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     david@sigma-star.at, david.oberhollenzer@sigma-star.at,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com, chris.chilvers@appsbroker.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/2] Implement fsidd
Date:   Tue,  4 Apr 2023 13:13:08 +0200
Message-Id: <20230404111308.23465-3-richard@nod.at>
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

The file system id service is a small daemon which serves and creates
fsids by a given path. Currently it supports only on backend,
a sqlite database.
Every nfs related service, such as mountd or exportfs can query it
using a local domain socket.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 support/reexport/Makefile.am        |  12 ++
 support/reexport/backend_sqlite.c   | 267 ++++++++++++++++++++++++++++
 support/reexport/fsidd.c            | 198 +++++++++++++++++++++
 support/reexport/reexport_backend.h |  47 +++++
 systemd/fsidd.service               |   9 +
 5 files changed, 533 insertions(+)
 create mode 100644 support/reexport/backend_sqlite.c
 create mode 100644 support/reexport/fsidd.c
 create mode 100644 support/reexport/reexport_backend.h
 create mode 100644 systemd/fsidd.service

diff --git a/support/reexport/Makefile.am b/support/reexport/Makefile.am
index 9d544a8f..fbd66a20 100644
--- a/support/reexport/Makefile.am
+++ b/support/reexport/Makefile.am
@@ -3,4 +3,16 @@
 noinst_LIBRARIES =3D libreexport.a
 libreexport_a_SOURCES =3D reexport.c
=20
+sbin_PROGRAMS	=3D fsidd
+
+fsidd_SOURCES =3D fsidd.c backend_sqlite.c
+
+fsidd_LDADD =3D ../../support/misc/libmisc.a \
+	      ../../support/nfs/libnfs.la \
+	       $(LIBPTHREAD) $(LIBEVENT) $(LIBSQLITE) \
+	       $(OPTLIBS)
+
+fsidd_CPPFLAGS =3D $(AM_CPPFLAGS) $(CPPFLAGS) \
+		  -I$(top_builddir)/support/include
+
 MAINTAINERCLEANFILES =3D Makefile.in
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
diff --git a/support/reexport/fsidd.c b/support/reexport/fsidd.c
new file mode 100644
index 00000000..410b3a37
--- /dev/null
+++ b/support/reexport/fsidd.c
@@ -0,0 +1,198 @@
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <assert.h>
+#include <dlfcn.h>
+#include <event2/event.h>
+#include <limits.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <sys/random.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/un.h>
+#include <sys/vfs.h>
+#include <unistd.h>
+
+#include "conffile.h"
+#include "reexport_backend.h"
+#include "xcommon.h"
+#include "xlog.h"
+
+#define FSID_SOCKET_NAME "fsid.sock"
+
+static struct event_base *evbase;
+static struct reexpdb_backend_plugin *dbbackend =3D &sqlite_plug_ops;
+
+static void client_cb(evutil_socket_t cl, short ev, void *d)
+{
+	struct event *me =3D d;
+	char buf[PATH_MAX * 2];
+	int n;
+
+	(void)ev;
+
+	n =3D recv(cl, buf, sizeof(buf) - 1, 0);
+	if (n <=3D 0) {
+		event_del(me);
+		event_free(me);
+		close(cl);
+		return;
+	}
+
+	buf[n] =3D '\0';
+
+	if (strncmp(buf, "get_fsidnum ", strlen("get_fsidnum ")) =3D=3D 0) {
+		char *req_path =3D buf + strlen("get_fsidnum ");
+		uint32_t fsidnum;
+		char *answer =3D NULL;
+		bool found;
+
+		assert(req_path < buf + n );
+
+		printf("client asks for %s\n", req_path);
+
+		if (dbbackend->fsidnum_by_path(req_path, &fsidnum, false, &found)) {
+			if (found)
+				assert(asprintf(&answer, "+ %u", fsidnum) !=3D -1);
+			else
+				assert(asprintf(&answer, "+ ") !=3D -1);
+	=09
+		} else {
+			assert(asprintf(&answer, "- %s", "Command failed") !=3D -1);
+		}
+
+		(void)send(cl, answer, strlen(answer), 0);
+
+		free(answer);
+	} else if (strncmp(buf, "get_or_create_fsidnum ", strlen("get_or_create=
_fsidnum ")) =3D=3D 0) {
+		char *req_path =3D buf + strlen("get_or_create_fsidnum ");
+		uint32_t fsidnum;
+		char *answer =3D NULL;
+		bool found;
+
+		assert(req_path < buf + n );
+
+
+		if (dbbackend->fsidnum_by_path(req_path, &fsidnum, true, &found)) {
+			if (found) {
+				assert(asprintf(&answer, "+ %u", fsidnum) !=3D -1);
+			} else {
+				assert(asprintf(&answer, "+ ") !=3D -1);
+			}
+	=09
+		} else {
+			assert(asprintf(&answer, "- %s", "Command failed") !=3D -1);
+		}
+
+		(void)send(cl, answer, strlen(answer), 0);
+
+		free(answer);
+	} else if (strncmp(buf, "get_path ", strlen("get_path ")) =3D=3D 0) {
+		char *req_fsidnum =3D buf + strlen("get_path ");
+		char *path =3D NULL, *answer =3D NULL, *endp;
+		bool bad_input =3D true;
+		uint32_t fsidnum;
+		bool found;
+
+		assert(req_fsidnum < buf + n );
+
+		errno =3D 0;
+		fsidnum =3D strtoul(req_fsidnum, &endp, 10);
+		if (errno =3D=3D 0 && *endp =3D=3D '\0') {
+			bad_input =3D false;
+		}
+
+		if (bad_input) {
+			assert(asprintf(&answer, "- %s", "Command failed: Bad input") !=3D -1=
);
+		} else {
+			if (dbbackend->path_by_fsidnum(fsidnum, &path, &found)) {
+				if (found)
+					assert(asprintf(&answer, "+ %s", path) !=3D -1);
+				else
+					assert(asprintf(&answer, "+ ") !=3D -1);
+			} else {
+				assert(asprintf(&answer, "+ ") !=3D -1);
+			}
+		}
+
+		(void)send(cl, answer, strlen(answer), 0);
+
+		free(path);
+		free(answer);
+	} else if (strcmp(buf, "version") =3D=3D 0) {
+		char answer[] =3D "+ 1";
+
+		(void)send(cl, answer, strlen(answer), 0);
+	} else {
+		char *answer =3D NULL;
+
+		assert(asprintf(&answer, "- bad command") !=3D -1);
+		(void)send(cl, answer, strlen(answer), 0);
+
+		free(answer);
+	}
+}
+
+static void srv_cb(evutil_socket_t fd, short ev, void *d)
+{
+	int cl =3D accept4(fd, NULL, NULL, SOCK_NONBLOCK);
+	struct event *client_ev;
+=09
+	(void)ev;
+	(void)d;
+
+	client_ev =3D event_new(evbase, cl, EV_READ | EV_PERSIST | EV_CLOSED, c=
lient_cb, event_self_cbarg());
+	event_add(client_ev, NULL);
+}
+
+int main(void)
+{
+	struct event *srv_ev;
+	struct sockaddr_un addr;
+	char *sock_file;
+	int srv;
+
+	conf_init_file(NFS_CONFFILE);
+
+	if (!dbbackend->initdb()) {
+		return 1;
+	}
+
+	sock_file =3D conf_get_str_with_def("reexport", "fsidd_socket", FSID_SO=
CKET_NAME);
+
+	unlink(sock_file);
+
+	memset(&addr, 0, sizeof(struct sockaddr_un));
+	addr.sun_family =3D AF_UNIX;
+	strncpy(addr.sun_path, sock_file, sizeof(addr.sun_path) - 1);
+
+	srv =3D socket(AF_UNIX, SOCK_SEQPACKET | SOCK_NONBLOCK, 0);
+	if (srv =3D=3D -1) {
+		xlog(L_WARNING, "Unable to create AF_UNIX socket for %s: %m\n", sock_f=
ile);
+		return 1;
+	}
+
+	if (bind(srv, (const struct sockaddr *)&addr, sizeof(struct sockaddr_un=
)) =3D=3D -1) {
+		xlog(L_WARNING, "Unable to bind %s: %m\n", sock_file);
+		return 1;
+	}
+
+	if (listen(srv, 5) =3D=3D -1) {
+		xlog(L_WARNING, "Unable to listen on %s: %m\n", sock_file);
+		return 1;
+	}
+
+	evbase =3D event_base_new();
+
+	srv_ev =3D event_new(evbase, srv, EV_READ | EV_PERSIST, srv_cb, NULL);
+	event_add(srv_ev, NULL);
+
+	event_base_dispatch(evbase);
+
+	dbbackend->destroydb();
+
+	return 0;
+}
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
diff --git a/systemd/fsidd.service b/systemd/fsidd.service
new file mode 100644
index 00000000..505a3e96
--- /dev/null
+++ b/systemd/fsidd.service
@@ -0,0 +1,9 @@
+[Unit]
+Description=3DFilesystem ID service for NFS re-exporting
+DefaultDependencies=3Dno
+Conflicts=3Dumount.target
+Before=3Dnfs-server.service
+
+[Service]
+Type=3Dsimple
+ExecStart=3D/usr/sbin/fsidd
--=20
2.31.1

