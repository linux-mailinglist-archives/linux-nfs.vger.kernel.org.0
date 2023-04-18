Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384866E5D80
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Apr 2023 11:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjDRJed (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Apr 2023 05:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjDRJeX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Apr 2023 05:34:23 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010FB5FEC
        for <linux-nfs@vger.kernel.org>; Tue, 18 Apr 2023 02:34:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4EAC164548B1;
        Tue, 18 Apr 2023 11:34:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Q4IQ6SWj06lV; Tue, 18 Apr 2023 11:34:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C6CC764548AC;
        Tue, 18 Apr 2023 11:34:14 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BHMV77PK6W5L; Tue, 18 Apr 2023 11:34:14 +0200 (CEST)
Received: from blindfold.corp.sigma-star.at (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 714906431C51;
        Tue, 18 Apr 2023 11:34:14 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     david@sigma-star.at, david.oberhollenzer@sigma-star.at,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com, chris.chilvers@appsbroker.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 7/8] export: Add fsidd
Date:   Tue, 18 Apr 2023 11:33:49 +0200
Message-Id: <20230418093350.4550-8-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230418093350.4550-1-richard@nod.at>
References: <20230418093350.4550-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The fsidnum daemon offers a local UNIX domain socket interface
for all NFS userspace to query the reexport database.
Currently fsidd just uses the SQlite backend.

fsidd serves also as an example on how to implement more complex
backends for the load balancing use case.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 support/reexport/Makefile.am |  12 +++
 support/reexport/fsidd.c     | 198 +++++++++++++++++++++++++++++++++++
 2 files changed, 210 insertions(+)
 create mode 100644 support/reexport/fsidd.c

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
--=20
2.31.1

