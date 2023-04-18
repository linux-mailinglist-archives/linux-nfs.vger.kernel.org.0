Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF9C6E5D7C
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Apr 2023 11:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjDRJe3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Apr 2023 05:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjDRJeW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Apr 2023 05:34:22 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB8749C6
        for <linux-nfs@vger.kernel.org>; Tue, 18 Apr 2023 02:34:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7B23F6431C43;
        Tue, 18 Apr 2023 11:34:13 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UEsjpteqFu33; Tue, 18 Apr 2023 11:34:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9ACF26431C51;
        Tue, 18 Apr 2023 11:34:12 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 44Lr3zcOngWF; Tue, 18 Apr 2023 11:34:12 +0200 (CEST)
Received: from blindfold.corp.sigma-star.at (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 49D076431C43;
        Tue, 18 Apr 2023 11:34:12 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     david@sigma-star.at, david.oberhollenzer@sigma-star.at,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com, chris.chilvers@appsbroker.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/8] Add reexport helper library
Date:   Tue, 18 Apr 2023 11:33:43 +0200
Message-Id: <20230418093350.4550-2-richard@nod.at>
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

Add some helper functions which will be used by the reexport
mechanism to create and find fsidnums for re-exported NFS shares.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 configure.ac                 |   1 +
 support/Makefile.am          |   2 +-
 support/export/Makefile.am   |   2 +
 support/include/nfslib.h     |   1 +
 support/reexport/Makefile.am |   6 +
 support/reexport/reexport.c  | 326 +++++++++++++++++++++++++++++++++++
 support/reexport/reexport.h  |  18 ++
 7 files changed, 355 insertions(+), 1 deletion(-)
 create mode 100644 support/reexport/Makefile.am
 create mode 100644 support/reexport/reexport.c
 create mode 100644 support/reexport/reexport.h

diff --git a/configure.ac b/configure.ac
index 7672a760..9f43267c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -717,6 +717,7 @@ AC_CONFIG_FILES([
 	support/nsm/Makefile
 	support/nfsidmap/Makefile
 	support/nfsidmap/libnfsidmap.pc
+	support/reexport/Makefile
 	tools/Makefile
 	tools/locktest/Makefile
 	tools/nlmtest/Makefile
diff --git a/support/Makefile.am b/support/Makefile.am
index c962d4d4..07cfd87e 100644
--- a/support/Makefile.am
+++ b/support/Makefile.am
@@ -10,7 +10,7 @@ if CONFIG_JUNCTION
 OPTDIRS +=3D junction
 endif
=20
-SUBDIRS =3D export include misc nfs nsm $(OPTDIRS)
+SUBDIRS =3D export include misc nfs nsm reexport $(OPTDIRS)
=20
 MAINTAINERCLEANFILES =3D Makefile.in
=20
diff --git a/support/export/Makefile.am b/support/export/Makefile.am
index eec737f6..7338e1c7 100644
--- a/support/export/Makefile.am
+++ b/support/export/Makefile.am
@@ -14,6 +14,8 @@ libexport_a_SOURCES =3D client.c export.c hostname.c \
 		      xtab.c mount_clnt.c mount_xdr.c \
 		      cache.c auth.c v4root.c fsloc.c \
 		      v4clients.c
+libexport_a_CPPFLAGS =3D $(AM_CPPFLAGS) $(CPPFLAGS) -I$(top_srcdir)/supp=
ort/reexport
+
 BUILT_SOURCES 	=3D $(GENFILES)
=20
 noinst_HEADERS =3D mount.h
diff --git a/support/include/nfslib.h b/support/include/nfslib.h
index 61c19933..bdbde78d 100644
--- a/support/include/nfslib.h
+++ b/support/include/nfslib.h
@@ -98,6 +98,7 @@ struct exportent {
 	struct xprtsec_entry e_xprtsec[XPRTSECMODE_COUNT + 1];
 	unsigned int	e_ttl;
 	char *		e_realpath;
+	int		e_reexport;
 };
=20
 struct rmtabent {
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
index 00000000..eddc9bf4
--- /dev/null
+++ b/support/reexport/reexport.c
@@ -0,0 +1,326 @@
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <dlfcn.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <sys/random.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/vfs.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+
+#include "nfsd_path.h"
+#include "conffile.h"
+#include "nfslib.h"
+#include "reexport.h"
+#include "xcommon.h"
+#include "xlog.h"
+
+static int fsidd_srv =3D -1;
+
+static bool connect_fsid_service(void)
+{
+	struct sockaddr_un addr;
+	char *sock_file;
+	int ret;
+	int s;
+
+	if (fsidd_srv !=3D -1)
+		return true;
+
+	sock_file =3D conf_get_str_with_def("reexport", "fsidd_socket", FSID_SO=
CKET_NAME);
+
+	memset(&addr, 0, sizeof(struct sockaddr_un));
+	addr.sun_family =3D AF_UNIX;
+	strncpy(addr.sun_path, sock_file, sizeof(addr.sun_path) - 1);
+
+	s =3D socket(AF_UNIX, SOCK_SEQPACKET, 0);
+	if (s =3D=3D -1) {
+		xlog(L_WARNING, "Unable to create AF_UNIX socket for %s: %m\n", sock_f=
ile);
+		return false;
+	}
+
+	ret =3D connect(s, (const struct sockaddr *)&addr, sizeof(struct sockad=
dr_un));
+	if (ret =3D=3D -1) {
+		xlog(L_WARNING, "Unable to connect %s: %m, is fsidd running?\n", sock_=
file);
+		return false;
+	}
+
+	fsidd_srv =3D s;
+
+	return true;
+}
+
+int reexpdb_init(void)
+{
+	int try_count =3D 3;
+
+	while (try_count > 0 && !connect_fsid_service()) {
+		sleep(1);
+		try_count--;
+	}
+
+	return try_count > 0;
+}
+
+void reexpdb_destroy(void)
+{
+	close(fsidd_srv);
+	fsidd_srv =3D -1;
+}
+
+static bool parse_fsidd_reply(const char *cmd_info, char *buf, size_t le=
n, char **result)
+{
+	if (len =3D=3D 0) {
+		xlog(L_WARNING, "Unable to read %s result: server closed the connectio=
n", cmd_info);
+		return false;
+	} else if (len < 2) {
+		xlog(L_WARNING, "Unable to read %s result: server sent too few bytes",=
 cmd_info);
+		return false;
+	}
+
+	if (buf[0] =3D=3D '-') {
+		if (len > 2) {
+			char *reason =3D buf + 2;
+			xlog(L_WARNING, "Command %s failed, server said: %s", cmd_info, reaso=
n);
+		} else {
+			xlog(L_WARNING, "Command %s failed at server side", cmd_info);
+		}
+
+		return false;
+	}
+
+	if (buf[0] !=3D '+') {
+		xlog(L_WARNING, "Unable to read %s result: server sent malformed answe=
r", cmd_info);
+		return false;
+	}
+
+	if (len > 2) {
+		*result =3D strdup(buf + 2);
+	} else {
+		*result =3D NULL;
+	}
+
+	return true;
+}
+
+static bool do_fsidd_cmd(const char *cmd_info, char *msg, size_t len, ch=
ar **result)
+{
+	char recvbuf[1024];
+	int n;
+
+	if (fsidd_srv =3D=3D -1) {
+		xlog(L_NOTICE, "Reconnecting to fsid services");
+		if (reexpdb_init() =3D=3D false)
+			return false;
+	}
+
+	xlog(D_GENERAL, "Request to fsidd: msg=3D\"%s\" len=3D%zd", msg, len);
+
+	if (write(fsidd_srv, msg, len) =3D=3D -1) {
+		xlog(L_WARNING, "Unable to send %s command: %m", cmd_info);
+		goto out_close;
+	}
+
+	n =3D read(fsidd_srv, recvbuf, sizeof(recvbuf) - 1);
+	if (n <=3D -1) {
+		xlog(L_WARNING, "Unable to recv %s answer: %m", cmd_info);
+		goto out_close;
+	} else if (n =3D=3D sizeof(recvbuf) - 1) {
+		//TODO: use better way to detect truncation
+		xlog(L_WARNING, "Unable to recv %s answer: answer truncated", cmd_info=
);
+		goto out_close;
+	}
+	recvbuf[n] =3D '\0';
+
+	xlog(D_GENERAL, "Answer from fsidd: msg=3D\"%s\" len=3D%i", recvbuf, n)=
;
+
+	if (parse_fsidd_reply(cmd_info, recvbuf, n, result) =3D=3D false) {
+		goto out_close;
+	}
+
+	return true;
+
+out_close:
+	close(fsidd_srv);
+	fsidd_srv =3D -1;
+	return false;
+}
+
+static bool fsidnum_get_by_path(char *path, uint32_t *fsidnum, bool may_=
create)
+{
+	char *msg, *result;
+	bool ret =3D false;
+	int len;
+
+	char *cmd =3D may_create ? "get_or_create_fsidnum" : "get_fsidnum";
+
+	len =3D asprintf(&msg, "%s %s", cmd, path);
+	if (len =3D=3D -1) {
+		xlog(L_WARNING, "Unable to build %s command: %m", cmd);
+		goto out;
+	}
+
+	if (do_fsidd_cmd(cmd, msg, len, &result) =3D=3D false) {
+		goto out;
+	}
+
+	if (result) {
+		bool bad_input =3D true;
+		char *endp;
+
+		errno =3D 0;
+		*fsidnum =3D strtoul(result, &endp, 10);
+		if (errno =3D=3D 0 && *endp =3D=3D '\0') {
+			bad_input =3D false;
+		}
+
+		free(result);
+
+		if (!bad_input) {
+			ret =3D true;
+		} else {
+			xlog(L_NOTICE, "Got malformed fsid for path %s", path);
+		}
+	} else {
+		xlog(L_NOTICE, "No fsid found for path %s", path);
+	}
+
+out:
+	free(msg);
+	return ret;
+}
+
+static bool path_by_fsidnum(uint32_t fsidnum, char **path)
+{
+	char *msg, *result;
+	bool ret =3D false;
+	int len;
+
+	len =3D asprintf(&msg, "get_path %d", (unsigned int)fsidnum);
+	if (len =3D=3D -1) {
+		xlog(L_WARNING, "Unable to build get_path command: %m");
+		goto out;
+	}
+
+	if (do_fsidd_cmd("get_path", msg, len, &result) =3D=3D false) {
+		goto out;
+	}
+
+	if (result) {
+		*path =3D result;
+		ret =3D true;
+	} else {
+		xlog(L_NOTICE, "No path found for fsid %u", (unsigned int)fsidnum);
+	}
+
+out:
+	free(msg);
+	return ret;
+}
+
+/*
+ * reexpdb_fsidnum_by_path - Lookup a fsid by path.
+ *
+ * @path: File system path used as lookup key
+ * @fsidnum: Pointer where found fsid is written to
+ * @may_create: If non-zero, allocate new fsid if lookup failed
+ *
+ */
+int reexpdb_fsidnum_by_path(char *path, uint32_t *fsidnum, int may_creat=
e)
+{
+	return fsidnum_get_by_path(path, fsidnum, may_create);
+}
+
+/*
+ * reexpdb_uncover_subvolume - Make sure a subvolume is present.
+ *
+ * @fsidnum: Numerical fsid number to look for
+ *
+ * Subvolumes (NFS cross mounts) get automatically mounted upon first
+ * access and can vanish after fs.nfs.nfs_mountpoint_timeout seconds.
+ * Also if the NFS server reboots, clients can still have valid file
+ * handles for such a subvolume.
+ *
+ * If kNFSd asks mountd for the path of a given fsidnum it can
+ * trigger an automount by calling statfs() on the given path.
+ */
+void reexpdb_uncover_subvolume(uint32_t fsidnum)
+{
+	struct statfs st;
+	char *path =3D NULL;
+	int ret;
+
+	if (path_by_fsidnum(fsidnum, &path)) {
+		ret =3D nfsd_path_statfs(path, &st);
+		if (ret =3D=3D -1)
+			xlog(L_WARNING, "statfs() failed");
+	}
+
+	free(path);
+}
+
+/*
+ * reexpdb_apply_reexport_settings - Apply reexport specific settings to=
 an exportent
+ *
+ * @ep: exportent to apply to
+ * @flname: Current export file, only useful for logging
+ * @flline: Current line, only useful for logging
+ *
+ * This is a helper function for applying reexport specific settings to =
an exportent.
+ * It searches a suitable fsid an sets @ep->e_fsid.
+ */
+int reexpdb_apply_reexport_settings(struct exportent *ep, char *flname, =
int flline)
+{
+	uint32_t fsidnum;
+	bool found, is_v4root =3D ((ep->e_flags & NFSEXP_FSID) && !ep->e_fsid);
+	int ret =3D 0;
+
+	if (ep->e_reexport =3D=3D REEXP_NONE)
+		goto out;
+
+	if (ep->e_uuid)
+		goto out;
+
+	if (is_v4root)
+		goto out;
+
+	found =3D reexpdb_fsidnum_by_path(ep->e_path, &fsidnum, 0);
+	if (!found) {
+		if (ep->e_reexport =3D=3D REEXP_AUTO_FSIDNUM) {
+			found =3D reexpdb_fsidnum_by_path(ep->e_path, &fsidnum, 1);
+			if (!found) {
+				xlog(L_ERROR, "%s:%i: Unable to generate fsid for %s",
+				     flname, flline, ep->e_path);
+				ret =3D -1;
+				goto out;
+			}
+		} else {
+			if (!ep->e_fsid) {
+				xlog(L_ERROR, "%s:%i: Selected 'reexport=3D' mode requires either a =
UUID 'fsid=3D' or a numerical 'fsid=3D' or a reexport db entry %d",
+				     flname, flline, ep->e_fsid);
+				ret =3D -1;
+			}
+
+			goto out;
+		}
+	}
+
+	if (ep->e_fsid) {
+		if (ep->e_fsid !=3D fsidnum) {
+			xlog(L_ERROR, "%s:%i: Selected 'reexport=3D' mode requires configured=
 numerical 'fsid=3D' to agree with reexport db entry",
+			     flname, flline);
+			ret =3D -1;
+		}
+	} else {
+		ep->e_fsid =3D fsidnum;
+	}
+
+out:
+	return ret;
+}
diff --git a/support/reexport/reexport.h b/support/reexport/reexport.h
new file mode 100644
index 00000000..3bed03a9
--- /dev/null
+++ b/support/reexport/reexport.h
@@ -0,0 +1,18 @@
+#ifndef REEXPORT_H
+#define REEXPORT_H
+
+enum {
+	REEXP_NONE =3D 0,
+	REEXP_AUTO_FSIDNUM,
+	REEXP_PREDEFINED_FSIDNUM,
+};
+
+int reexpdb_init(void);
+void reexpdb_destroy(void);
+int reexpdb_fsidnum_by_path(char *path, uint32_t *fsidnum, int may_creat=
e);
+int reexpdb_apply_reexport_settings(struct exportent *ep, char *flname, =
int flline);
+void reexpdb_uncover_subvolume(uint32_t fsidnum);
+
+#define FSID_SOCKET_NAME "fsid.sock"
+
+#endif /* REEXPORT_H */
--=20
2.31.1

