Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519614BA100
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 14:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240887AbiBQNXO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Feb 2022 08:23:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240884AbiBQNXM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 08:23:12 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141B9B0A73
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 05:22:56 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 27E3D60765A3;
        Thu, 17 Feb 2022 14:16:43 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 84PNtuXwNWDs; Thu, 17 Feb 2022 14:16:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 925A260765A1;
        Thu, 17 Feb 2022 14:16:38 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zgUuE5thLYNQ; Thu, 17 Feb 2022 14:16:38 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 27E2C608A38A;
        Thu, 17 Feb 2022 14:16:38 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     david@sigma-star.at, bfields@fieldses.org,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        david.oberhollenzer@sigma-star.at, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, chris.chilvers@appsbroker.com,
        Richard Weinberger <richard@nod.at>
Subject: [RFC PATCH 1/6] Implement reexport helper library
Date:   Thu, 17 Feb 2022 14:15:26 +0100
Message-Id: <20220217131531.2890-2-richard@nod.at>
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

This internal library contains code that will be used by various
tools within the nfs-utils package to deal better with NFS re-export,
especially cross mounts.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 configure.ac                 |  12 +
 support/Makefile.am          |   4 +
 support/reexport/Makefile.am |   6 +
 support/reexport/reexport.c  | 477 +++++++++++++++++++++++++++++++++++
 support/reexport/reexport.h  |  53 ++++
 5 files changed, 552 insertions(+)
 create mode 100644 support/reexport/Makefile.am
 create mode 100644 support/reexport/reexport.c
 create mode 100644 support/reexport/reexport.h

diff --git a/configure.ac b/configure.ac
index 93626d62..86bf8ba9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -274,6 +274,17 @@ AC_ARG_ENABLE(nfsv4server,
 	fi
 	AM_CONDITIONAL(CONFIG_NFSV4SERVER, [test "$enable_nfsv4server" =3D "yes=
" ])
=20
+AC_ARG_ENABLE(reexport,
+	[AC_HELP_STRING([--enable-reexport],
+			[enable support for re-exporting NFS mounts  @<:@default=3Dno@:>@])],
+	enable_reexport=3D$enableval,
+	enable_reexport=3D"no")
+	if test "$enable_reexport" =3D yes; then
+		AC_DEFINE(HAVE_REEXPORT_SUPPORT, 1,
+                          [Define this if you want NFS re-export support=
 compiled in])
+	fi
+	AM_CONDITIONAL(CONFIG_REEXPORT, [test "$enable_reexport" =3D "yes" ])
+
 dnl Check for TI-RPC library and headers
 AC_LIBTIRPC
=20
@@ -730,6 +741,7 @@ AC_CONFIG_FILES([
 	support/nsm/Makefile
 	support/nfsidmap/Makefile
 	support/nfsidmap/libnfsidmap.pc
+	support/reexport/Makefile
 	tools/Makefile
 	tools/locktest/Makefile
 	tools/nlmtest/Makefile
diff --git a/support/Makefile.am b/support/Makefile.am
index c962d4d4..986e9b5f 100644
--- a/support/Makefile.am
+++ b/support/Makefile.am
@@ -10,6 +10,10 @@ if CONFIG_JUNCTION
 OPTDIRS +=3D junction
 endif
=20
+if CONFIG_REEXPORT
+OPTDIRS +=3D reexport
+endif
+
 SUBDIRS =3D export include misc nfs nsm $(OPTDIRS)
=20
 MAINTAINERCLEANFILES =3D Makefile.in
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
index 00000000..551ec278
--- /dev/null
+++ b/support/reexport/reexport.c
@@ -0,0 +1,477 @@
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include <sqlite3.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <sys/file.h>
+#include <sys/mman.h>
+#include <sys/shm.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/vfs.h>
+#include <unistd.h>
+
+#include "nfslib.h"
+#include "reexport.h"
+#include "xlog.h"
+
+#define REEXPDB_SHM_NAME "/nfs_reexport_db_lock"
+#define REEXPDB_SHM_SZ 4096
+#define REEXPDB_INIT_LOCK NFS_STATEDIR "/reexpdb_init.lock"
+#define REEXPDB_DBFILE NFS_STATEDIR "/reexpdb.sqlite3"
+
+static const char initdb_sql[] =3D "CREATE TABLE IF NOT EXISTS fsidnums =
(num INTEGER PRIMARY KEY CHECK (num > 0 AND num < 4294967296), path TEXT =
UNIQUE); CREATE TABLE IF NOT EXISTS subvolumes (path TEXT PRIMARY KEY); C=
REATE INDEX IF NOT EXISTS idx_ids_path ON fsidnums (path);";
+/*
+ * This query is a little tricky. We use SQL to find and claim the small=
est free fsid number.
+ * To find a free fsid the fsidnums is left joined to itself but with an=
 offset of 1.
+ * Everything after the UNION statement is to handle the corner case whe=
re fsidnums
+ * is empty. In this case we want 1 as first fsid number.
+ */
+static const char new_fsidnum_by_path_sql[] =3D "INSERT INTO fsidnums VA=
LUES ((SELECT ids1.num + 1 FROM fsidnums AS ids1 LEFT JOIN fsidnums AS id=
s2 ON ids2.num =3D ids1.num + 1 WHERE ids2.num IS NULL UNION SELECT 1 WHE=
RE NOT EXISTS (SELECT NULL FROM fsidnums WHERE num =3D 1) LIMIT 1), ?1) R=
ETURNING num;";
+static const char fsidnum_by_path_sql[] =3D "SELECT num FROM fsidnums WH=
ERE path =3D ?1;";
+static const char add_crossed_volume_sql[] =3D "REPLACE INTO subvolumes =
VALUES(?1);";
+static const char drop_crossed_volume_sql[] =3D "DELETE FROM subvolumes =
WHERE path =3D ?1;";
+static const char get_crossed_volumes_sql[] =3D "SELECT path from subvol=
umes;";
+
+static sqlite3 *db;
+static pthread_rwlock_t *reexpdb_rwlock;
+static int init_done;
+
+static void reexpdb_wrlock(void)
+{
+	assert(pthread_rwlock_wrlock(reexpdb_rwlock) =3D=3D 0);
+}
+
+static void reexpdb_rdlock(void)
+{
+	assert(pthread_rwlock_rdlock(reexpdb_rwlock) =3D=3D 0);
+}
+
+static void reexpdb_unlock(void)
+{
+	assert(pthread_rwlock_unlock(reexpdb_rwlock) =3D=3D 0);
+}
+
+static int init_shm_lock(void)
+{
+	int lockfd =3D -1, shmfd =3D -1;
+	int initlock =3D 0;
+	int ret =3D 0;
+
+	assert(sizeof(*reexpdb_rwlock) <=3D REEXPDB_SHM_SZ);
+
+	lockfd =3D open(REEXPDB_INIT_LOCK, O_RDWR | O_CREAT, 0600);
+	if (lockfd =3D=3D -1) {
+		ret =3D -1;
+		xlog(L_FATAL, "Unable to open %s: %m", REEXPDB_INIT_LOCK);
+
+		goto out;
+	}
+
+	ret =3D flock(lockfd, LOCK_EX);
+	if (ret =3D=3D -1) {
+		ret =3D -1;
+		xlog(L_FATAL, "Unable to lock %s: %m", REEXPDB_INIT_LOCK);
+
+		goto out_close;
+	}
+
+	shmfd =3D shm_open(REEXPDB_SHM_NAME, O_RDWR, 0600);
+	if (shmfd =3D=3D -1 && errno =3D=3D ENOENT) {
+		shmfd =3D shm_open(REEXPDB_SHM_NAME, O_RDWR | O_CREAT, 0600);
+		if (shmfd =3D=3D -1) {
+			ret =3D -1;
+			xlog(L_FATAL, "Unable to create shared memory: %m");
+			goto out_unflock;
+		}
+
+		ret =3D ftruncate(shmfd, REEXPDB_SHM_SZ);
+		if (ret =3D=3D -1) {
+			ret =3D -1;
+			xlog(L_FATAL, "Unable to ftruncate shared memory: %m");
+			goto out_unflock;
+		}
+
+		initlock =3D 1;
+	} else if (shmfd =3D=3D -1) {
+		ret =3D -1;
+		xlog(L_FATAL, "Unable to open shared memory: %m");
+		goto out_unflock;
+	}
+
+        reexpdb_rwlock =3D mmap(NULL, REEXPDB_SHM_SZ, PROT_READ | PROT_W=
RITE, MAP_SHARED, shmfd, 0);
+	close(shmfd);
+        if (reexpdb_rwlock =3D=3D (void *)-1) {
+                xlog(L_FATAL, "Unable to mmap shared memory: %m");
+		ret =3D -1;
+		goto out_unflock;
+        }
+
+	if (initlock) {
+		pthread_rwlockattr_t attr;
+
+		ret =3D pthread_rwlockattr_init(&attr);
+		if (ret !=3D 0) {
+			xlog(L_FATAL, "Unable to pthread_rwlockattr_init: %m");
+			ret =3D -1;
+			goto out_unflock;
+		}
+
+		ret =3D pthread_rwlockattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
+		if (ret !=3D 0) {
+			xlog(L_FATAL, "Unable to set PTHREAD_PROCESS_SHARED: %m");
+			ret =3D -1;
+			goto out_unflock;
+		}
+
+		ret =3D pthread_rwlock_init(reexpdb_rwlock, &attr);
+		if (ret !=3D 0) {
+			xlog(L_FATAL, "Unable to pthread_rwlock_init: %m");
+			ret =3D -1;
+			goto out_unflock;
+		}
+	}
+
+	ret =3D 0;
+
+out_unflock:
+	flock(lockfd, LOCK_UN);
+out_close:
+	close(lockfd);
+out:
+	return ret;
+}=20
+
+/*
+ * reexpdb_init - Initialize reexport database
+ *
+ * Setup shared lock (database is concurrently used by multiple processe=
s),
+ * if needed create tables and create database handle.
+ * It is okay to call this function multiple times per process.
+ */
+int reexpdb_init(void)
+{
+	char *sqlerr;
+	int ret;
+
+	if (init_done)
+		return 0;
+
+	ret =3D init_shm_lock();
+	if (ret)
+		return -1;
+
+	ret =3D sqlite3_open_v2(REEXPDB_DBFILE, &db, SQLITE_OPEN_READWRITE | SQ=
LITE_OPEN_CREATE | SQLITE_OPEN_FULLMUTEX, NULL);
+	if (ret !=3D SQLITE_OK) {
+		xlog(L_ERROR, "Unable to open reexport database: %s", sqlite3_errstr(r=
et));
+		return -1;
+	}
+
+	reexpdb_wrlock();
+	ret =3D sqlite3_exec(db, initdb_sql, NULL, NULL, &sqlerr);
+	reexpdb_unlock();
+	if (ret !=3D SQLITE_OK) {
+		xlog(L_ERROR, "Unable to init reexport database: %s", sqlite3_errstr(r=
et));
+		sqlite3_free(sqlerr);
+		sqlite3_close_v2(db);
+		ret =3D -1;
+	} else {
+		init_done =3D 1;
+		ret =3D 0;
+	}
+
+	return ret;
+}
+
+/*
+ * reexpdb_destroy - Undo reexpdb_init().
+ *
+ * The shared lock keeps. We cannot know which other
+ * processes are still use the database.
+ */
+void reexpdb_destroy(void)
+{
+	if (!init_done)
+		return;
+
+	sqlite3_close_v2(db);
+	munmap((void *)reexpdb_rwlock, REEXPDB_SHM_SZ);
+	reexpdb_rwlock =3D NULL;
+}
+
+static int get_fsidnum_by_path(char *path, uint32_t *fsidnum)
+{
+	sqlite3_stmt *stmt =3D NULL;
+	int found =3D 0;
+	int ret;
+
+	ret =3D sqlite3_prepare_v2(db, fsidnum_by_path_sql, sizeof(fsidnum_by_p=
ath_sql), &stmt, NULL);
+	if (ret !=3D SQLITE_OK) {
+		xlog(L_WARNING, "Unable to prepare SQL query: %s", sqlite3_errstr(ret)=
);
+		goto out;
+	}
+
+	ret =3D sqlite3_bind_text(stmt, 1, path, -1, NULL);
+	if (ret !=3D SQLITE_OK) {
+		xlog(L_WARNING, "Unable to bind \"%s\" SQL query: %s", __func__, sqlit=
e3_errstr(ret));
+		goto out;
+	}
+
+	reexpdb_rdlock();
+	ret =3D sqlite3_step(stmt);
+	if (ret =3D=3D SQLITE_ROW) {
+		*fsidnum =3D sqlite3_column_int(stmt, 0);
+		found =3D 1;
+	} else if (ret =3D=3D SQLITE_DONE) {
+		/* No hit */
+		found =3D 0;
+	} else {
+		xlog(L_WARNING, "Error while looking up \"%s\" in database: %s", path,=
 sqlite3_errstr(ret));
+	}
+	reexpdb_unlock();
+
+out:
+	sqlite3_finalize(stmt);
+	return found;
+}
+
+static int new_fsidnum_by_path(char *path, uint32_t *fsidnum)
+{
+	sqlite3_stmt *stmt =3D NULL;
+	int found =3D 0, check =3D 0;
+	int ret;
+
+	ret =3D sqlite3_prepare_v2(db, new_fsidnum_by_path_sql, sizeof(new_fsid=
num_by_path_sql), &stmt, NULL);
+	if (ret !=3D SQLITE_OK) {
+		xlog(L_WARNING, "Unable to prepare SQL query: %s", sqlite3_errstr(ret)=
);
+		goto out;
+	}
+
+	ret =3D sqlite3_bind_text(stmt, 1, path, -1, NULL);
+	if (ret !=3D SQLITE_OK) {
+		xlog(L_WARNING, "Unable to bind \"%s\" SQL query: %s", path, sqlite3_e=
rrstr(ret));
+		goto out;
+	}
+
+	reexpdb_wrlock();
+	ret =3D sqlite3_step(stmt);
+	if (ret =3D=3D SQLITE_ROW) {
+		*fsidnum =3D sqlite3_column_int(stmt, 0);
+		found =3D 1;
+	} else if (ret =3D=3D SQLITE_CONSTRAINT) {
+		/* Maybe we lost the race against another writer and the path is now p=
resent. */
+		check =3D 1;
+	} else {
+		xlog(L_WARNING, "Error while looking up \"%s\" in database: %s", path,=
 sqlite3_errstr(ret));
+	}
+	reexpdb_unlock();
+
+out:
+	sqlite3_finalize(stmt);
+
+	if (check) {
+		found =3D get_fsidnum_by_path(path, fsidnum);
+		if (!found)
+			xlog(L_WARNING, "SQLITE_CONSTRAINT error while inserting \"%s\" in da=
tabase", path);
+	}
+
+	return found;
+}
+
+int reexpdb_fsidnum_by_path(char *path, uint32_t *fsidnum, int may_creat=
e)
+{
+	int found;
+
+	found =3D get_fsidnum_by_path(path, fsidnum);
+
+	if (!found && may_create)
+		found =3D new_fsidnum_by_path(path, fsidnum);
+
+	return found;
+}
+
+int reexpdb_apply_reexport_settings(struct exportent *ep, char *flname, =
int flline)
+{
+	int ret =3D 0;
+
+	switch (ep->e_reexport) {
+	case REEXP_REMOTE_DEVFSID:
+		if (!ep->e_fsid && !ep->e_uuid) {
+			xlog(L_ERROR, "%s:%i: Selected 'reexport=3D' mode needs either a nume=
rical or UUID 'fsid=3D'\n",
+			     flname, flline);
+			ret =3D -1;
+		}
+		break;
+	case REEXP_AUTO_FSIDNUM:
+	case REEXP_PREDEFINED_FSIDNUM: {
+		uint32_t fsidnum;
+		int found;
+
+		if (ep->e_uuid)
+			break;
+
+		if (reexpdb_init() !=3D 0) {
+			ret =3D -1;
+
+			break;
+		}
+
+		found =3D reexpdb_fsidnum_by_path(ep->e_path, &fsidnum, 0);
+		if (!found) {
+			if (ep->e_reexport =3D=3D REEXP_AUTO_FSIDNUM) {
+				found =3D reexpdb_fsidnum_by_path(ep->e_path, &fsidnum, 1);
+				if (!found) {
+					xlog(L_ERROR, "%s:%i: Unable to generate fsid for %s",
+					     flname, flline, ep->e_path);
+					ret =3D -1;
+
+					break;
+				}
+			} else {
+				if (!ep->e_fsid) {
+					xlog(L_ERROR, "%s:%i: Selected 'reexport=3D' mode requires either a=
 UUID 'fsid=3D' or a numerical 'fsid=3D' or a reexport db entry %d",
+					     flname, flline, ep->e_fsid);
+					ret =3D -1;
+				}
+
+				break;
+			}
+		}
+
+		if (ep->e_fsid) {
+			if (ep->e_fsid !=3D fsidnum) {
+				xlog(L_ERROR, "%s:%i: Selected 'reexport=3D' mode requires configure=
d numerical 'fsid=3D' to agree with reexport db entry",
+				     flname, flline);
+				ret =3D -1;
+			}
+
+			break;
+		}
+
+		ep->e_fsid =3D fsidnum;
+
+		break;
+	}
+	}
+
+	return ret;
+}
+
+int reexpdb_add_subvolume(char *path)
+{
+	sqlite3_stmt *stmt =3D NULL;
+	int ret;
+
+	reexpdb_wrlock();
+	ret =3D sqlite3_prepare_v2(db, add_crossed_volume_sql, sizeof(add_cross=
ed_volume_sql), &stmt, NULL);
+	if (ret !=3D SQLITE_OK) {
+		xlog(L_WARNING, "Unable to prepare SQL query: %s", sqlite3_errstr(ret)=
);
+		ret =3D -1;
+		goto out;
+	}
+
+	ret =3D sqlite3_bind_text(stmt, 1, path, -1, NULL);
+	if (ret !=3D SQLITE_OK) {
+		xlog(L_WARNING, "Unable to bind \"%s\" SQL query: %s", __func__, sqlit=
e3_errstr(ret));
+		ret =3D -1;
+		goto out;
+	}
+
+	ret =3D sqlite3_step(stmt);
+	if (ret !=3D SQLITE_DONE) {
+		xlog(L_WARNING, "Error while adding \"%s\" from database: %s", path, s=
qlite3_errstr(ret));
+		ret =3D -1;
+	} else {
+		ret =3D 0;
+	}
+
+out:
+	reexpdb_unlock();
+	sqlite3_finalize(stmt);
+	return ret;
+}
+
+int reexpdb_drop_subvolume_unlocked(char *path)
+{
+	sqlite3_stmt *stmt =3D NULL;
+	int ret;
+
+	ret =3D sqlite3_prepare_v2(db, drop_crossed_volume_sql, sizeof(drop_cro=
ssed_volume_sql), &stmt, NULL);
+	if (ret !=3D SQLITE_OK) {
+		xlog(L_WARNING, "Unable to prepare SQL query: %s", sqlite3_errstr(ret)=
);
+		ret =3D -1;
+		goto out;
+	}
+
+	ret =3D sqlite3_bind_text(stmt, 1, path, -1, NULL);
+	if (ret !=3D SQLITE_OK) {
+		xlog(L_WARNING, "Unable to bind \"%s\" SQL query: %s", __func__, sqlit=
e3_errstr(ret));
+		ret =3D -1;
+		goto out;
+	}
+
+	ret =3D sqlite3_step(stmt);
+	if (ret !=3D SQLITE_DONE) {
+		xlog(L_WARNING, "Error while deleting \"%s\" from database: %s", path,=
 sqlite3_errstr(ret));
+		ret =3D -1;
+	} else {
+		ret =3D 0;
+	}
+
+out:
+	sqlite3_finalize(stmt);
+	return ret;
+}
+
+
+int reexpdb_uncover_subvolumes(void (*cb)(char *path))
+{
+	sqlite3_stmt *stmt =3D NULL;
+	struct statfs st;
+	const unsigned char *path;
+	int ret;
+
+	if (cb)
+		reexpdb_wrlock();
+	else
+		reexpdb_rdlock();
+
+	ret =3D sqlite3_prepare_v2(db, get_crossed_volumes_sql, sizeof(get_cros=
sed_volumes_sql), &stmt, NULL);
+	if (ret !=3D SQLITE_OK) {
+		xlog(L_WARNING, "Unable to prepare SQL query: %s", sqlite3_errstr(ret)=
);
+		ret =3D -1;
+		goto out;
+	}
+
+	for (;;) {
+		ret =3D sqlite3_step(stmt);
+		if (ret !=3D SQLITE_ROW)
+			break;
+
+		path =3D sqlite3_column_text(stmt, 0);
+		if (cb)
+			cb((char *)path);
+		else
+			statfs((char *)path, &st);
+	}
+
+	if (ret !=3D SQLITE_DONE) {
+		xlog(L_WARNING, "Error while reading all subvolumes: %s", sqlite3_errs=
tr(ret));
+		ret =3D -1;
+		goto out_unlock;
+	}
+
+	ret =3D 0;
+
+out_unlock:
+	reexpdb_unlock();
+	sqlite3_finalize(stmt);
+out:
+	return ret;
+}
diff --git a/support/reexport/reexport.h b/support/reexport/reexport.h
new file mode 100644
index 00000000..46ec8a96
--- /dev/null
+++ b/support/reexport/reexport.h
@@ -0,0 +1,53 @@
+#ifndef REEXPORT_H
+#define REEXPORT_H
+
+enum {
+	REEXP_NONE =3D 0,
+	REEXP_AUTO_FSIDNUM,
+	REEXP_PREDEFINED_FSIDNUM,
+	REEXP_REMOTE_DEVFSID,
+};
+
+#ifdef HAVE_REEXPORT_SUPPORT
+int reexpdb_init(void);
+void reexpdb_destroy(void);
+int reexpdb_fsidnum_by_path(char *path, uint32_t *fsidnum, int may_creat=
e);
+int reexpdb_apply_reexport_settings(struct exportent *ep, char *flname, =
int flline);
+int reexpdb_add_subvolume(char *path);
+int reexpdb_uncover_subvolumes(void (*cb)(char *path));
+int reexpdb_drop_subvolume_unlocked(char *path);
+#else
+static inline int reexpdb_init(void) { return 0; }
+static inline void reexpdb_destroy(void) {}
+static inline int reexpdb_fsidnum_by_path(char *path, uint32_t *fsidnum,=
 int may_create)
+{
+	(void)path;
+	(void)may_create;
+	*fsidnum =3D 0;
+	return 0;
+}
+static inline int reexpdb_apply_reexport_settings(struct exportent *ep, =
char *flname, int flline)
+{
+	(void)ep;
+	(void)flname;
+	(void)flline;
+	return 0;
+}
+static inline int reexpdb_add_subvolume(char *path)
+{
+	(void)path;
+	return 0;
+}
+static inline int reexpdb_uncover_subvolumes(void (*cb)(char *path))
+{
+	(void)cb;
+	return 0;
+}
+static inline int reexpdb_drop_subvolume_unlocked(char *path)
+{
+	(void)path;
+	return 0;
+}
+#endif /* HAVE_REEXPORT_SUPPORT */
+
+#endif /* REEXPORT_H */
--=20
2.31.1

