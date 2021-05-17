Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD61382388
	for <lists+linux-nfs@lfdr.de>; Mon, 17 May 2021 06:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhEQErg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Mon, 17 May 2021 00:47:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:59770 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229808AbhEQErf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 17 May 2021 00:47:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 37625B02E;
        Mon, 17 May 2021 04:45:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Petr Vorel" <pvorel@suse.cz>
Cc:     "J . Bruce Fields" <bfields@fieldses.org>,
        linux-nfs@vger.kernel.org, "Steve Dickson" <steved@redhat.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Alexey Kodanev" <alexey.kodanev@oracle.com>
Subject: [PATCH/RFC v2 nfs-utils] Fix NFSv4 export of tmpfs filesystems.
In-reply-to: <162035212343.24322.12361160756597283121@noble.neil.brown.name>
References: <20210422191803.31511-1-pvorel@suse.cz>,
 <20210422202334.GB25415@fieldses.org>, <YILQip3nAxhpXP9+@pevik>,
 <162035212343.24322.12361160756597283121@noble.neil.brown.name>
Date:   Mon, 17 May 2021 14:45:31 +1000
Message-id: <162122673178.19062.96081788305923933@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Some filesystems cannot be exported without an fsid or uuid.
tmpfs is the main example.

When mountd (or exportd) creates nfsv4 pseudo-root exports for the path
leading down to an export point it exports each directory without any
fsid or uuid.  If one of these directories is on tmp, that will fail.

The net result is that exporting a subdirectory of a tmpfs filesystem
will not work over NFSv4 as the parents within the filesystem cannot be
exported.  It will either fail, or fall-back to NFSv3 (depending on the
version of the mount.nfs program).

To fix this we need to provide an fsid or uuid for these pseudo-root
exports.  This patch does that by creating an RFC-4122 V5 compatible
UUID based on an arbitrary seed and the path to the export.

To check if an export needs a uuid, text_export() is moved from exportfs
to libexport.a, modified slightly and renamed to export_test().

Signed-off-by: NeilBrown <neilb@suse.de>
---

This version contains Chuck's suggestion for improving the uuid, and
general clean-up.

 support/export/cache.c     |  3 ++-
 support/export/export.c    | 29 +++++++++++++++++++++++++++++
 support/export/v4root.c    | 23 ++++++++++++++++++++++-
 support/include/exportfs.h |  1 +
 utils/exportd/Makefile.am  |  2 +-
 utils/exportfs/exportfs.c  | 38 +++-----------------------------------
 utils/mountd/Makefile.am   |  2 +-
 7 files changed, 59 insertions(+), 39 deletions(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index 3e4f53c0a32e..a5823e92e9f2 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -981,7 +981,8 @@ static int dump_to_cache(int f, char *buf, int blen, char *domain,
 		write_secinfo(&bp, &blen, exp, flag_mask);
 		if (exp->e_uuid == NULL || different_fs) {
 			char u[16];
-			if (uuid_by_path(path, 0, 16, u)) {
+			if ((exp->e_flags & flag_mask & NFSEXP_FSID) == 0 &&
+			    uuid_by_path(path, 0, 16, u)) {
 				qword_add(&bp, &blen, "uuid");
 				qword_addhex(&bp, &blen, u, 16);
 			}
diff --git a/support/export/export.c b/support/export/export.c
index c753f68e4d63..03390dfc1de8 100644
--- a/support/export/export.c
+++ b/support/export/export.c
@@ -10,9 +10,11 @@
 #include <config.h>
 #endif
 
+#include <unistd.h>
 #include <string.h>
 #include <sys/types.h>
 #include <sys/param.h>
+#include <fcntl.h>
 #include <netinet/in.h>
 #include <limits.h>
 #include <stdlib.h>
@@ -420,3 +422,30 @@ export_hash(char *str)
 
 	return num % HASH_TABLE_SIZE;
 }
+
+int export_test(struct exportent *eep, int with_fsid)
+{
+	char *path = eep->e_path;
+	int flags = eep->e_flags | (with_fsid ? NFSEXP_FSID : 0);
+	/* beside max path, buf size should take protocol str into account */
+	char buf[NFS_MAXPATHLEN+1+64] = { 0 };
+	char *bp = buf;
+	int len = sizeof(buf);
+	int fd, n;
+
+	n = snprintf(buf, len, "-test-client- ");
+	bp += n;
+	len -= n;
+	qword_add(&bp, &len, path);
+	if (len < 1)
+		return 0;
+	snprintf(bp, len, " 3 %d 65534 65534 0\n", flags);
+	fd = open("/proc/net/rpc/nfsd.export/channel", O_WRONLY);
+	if (fd < 0)
+		return 0;
+	n = nfsd_path_write(fd, buf, strlen(buf));
+	close(fd);
+	if (n < 0)
+		return 0;
+	return 1;
+}
diff --git a/support/export/v4root.c b/support/export/v4root.c
index 3654bd7c10c0..c12a7d8562b2 100644
--- a/support/export/v4root.c
+++ b/support/export/v4root.c
@@ -20,6 +20,7 @@
 
 #include <unistd.h>
 #include <errno.h>
+#include <uuid/uuid.h>
 
 #include "xlog.h"
 #include "exportfs.h"
@@ -89,11 +90,31 @@ v4root_create(char *path, nfs_export *export)
 	strncpy(eep.e_path, path, sizeof(eep.e_path)-1);
 	if (strcmp(path, "/") != 0)
 		eep.e_flags &= ~NFSEXP_FSID;
+
+	if (strcmp(path, "/") != 0 &&
+	    !export_test(&eep, 0)) {
+		/* Need a uuid - base it on path using a fixed seed that
+		 * was generated randomly.
+		 */
+		const char seed_s[] = "39c6b5c1-3f24-4f4e-977c-7fe6546b8a25";
+		uuid_t seed, uuid;
+		char uuid_s[UUID_STR_LEN];
+		unsigned int i, j;
+
+		uuid_parse(seed_s, seed);
+		uuid_generate_sha1(uuid, seed, path, strlen(path));
+		uuid_unparse_upper(uuid, uuid_s);
+		/* strip hyhens */
+		for (i = j = 0; uuid_s[i]; i++)
+			if (uuid_s[i] != '-')
+				uuid_s[j++] = uuid_s[i];
+		eep.e_uuid = uuid_s;
+	}
 	set_pseudofs_security(&eep);
 	exp = export_create(&eep, 0);
 	if (exp == NULL)
 		return NULL;
-	xlog(D_CALL, "v4root_create: path '%s' flags 0x%x", 
+	xlog(D_CALL, "v4root_create: path '%s' flags 0x%x",
 		exp->m_export.e_path, exp->m_export.e_flags);
 	return &exp->m_export;
 }
diff --git a/support/include/exportfs.h b/support/include/exportfs.h
index 81d137210862..7c1b74537186 100644
--- a/support/include/exportfs.h
+++ b/support/include/exportfs.h
@@ -173,5 +173,6 @@ struct export_features {
 struct export_features *get_export_features(void);
 void fix_pseudoflavor_flags(struct exportent *ep);
 char *exportent_realpath(struct exportent *eep);
+int export_test(struct exportent *eep, int with_fsid);
 
 #endif /* EXPORTFS_H */
diff --git a/utils/exportd/Makefile.am b/utils/exportd/Makefile.am
index eb521f15032d..c95bdee76d3f 100644
--- a/utils/exportd/Makefile.am
+++ b/utils/exportd/Makefile.am
@@ -16,7 +16,7 @@ exportd_SOURCES = exportd.c
 exportd_LDADD = ../../support/export/libexport.a \
 			../../support/nfs/libnfs.la \
 			../../support/misc/libmisc.a \
-			$(OPTLIBS) $(LIBBLKID) $(LIBPTHREAD) 
+			$(OPTLIBS) $(LIBBLKID) $(LIBPTHREAD) -luuid
 
 exportd_CPPFLAGS = $(AM_CPPFLAGS) $(CPPFLAGS) \
 		-I$(top_srcdir)/support/export
diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index 25d757d8b4b4..bc76aaaf8714 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -54,11 +54,6 @@ static int _lockfd = -1;
 
 struct state_paths etab;
 
-static ssize_t exportfs_write(int fd, const char *buf, size_t len)
-{
-	return nfsd_path_write(fd, buf, len);
-}
-
 /*
  * If we aren't careful, changes made by exportfs can be lost
  * when multiple exports process run at once:
@@ -510,33 +505,6 @@ static int can_test(void)
 	return 1;
 }
 
-static int test_export(nfs_export *exp, int with_fsid)
-{
-	char *path = exp->m_export.e_path;
-	int flags = exp->m_export.e_flags | (with_fsid ? NFSEXP_FSID : 0);
-	/* beside max path, buf size should take protocol str into account */
-	char buf[NFS_MAXPATHLEN+1+64] = { 0 };
-	char *bp = buf;
-	int len = sizeof(buf);
-	int fd, n;
-
-	n = snprintf(buf, len, "-test-client- ");
-	bp += n;
-	len -= n;
-	qword_add(&bp, &len, path);
-	if (len < 1)
-		return 0;
-	snprintf(bp, len, " 3 %d 65534 65534 0\n", flags);
-	fd = open("/proc/net/rpc/nfsd.export/channel", O_WRONLY);
-	if (fd < 0)
-		return 0;
-	n = exportfs_write(fd, buf, strlen(buf));
-	close(fd);
-	if (n < 0)
-		return 0;
-	return 1;
-}
-
 static void
 validate_export(nfs_export *exp)
 {
@@ -568,12 +536,12 @@ validate_export(nfs_export *exp)
 
 	if ((exp->m_export.e_flags & NFSEXP_FSID) || exp->m_export.e_uuid ||
 	    fs_has_fsid) {
-		if ( !test_export(exp, 1)) {
+		if ( !export_test(&exp->m_export, 1)) {
 			xlog(L_ERROR, "%s does not support NFS export", path);
 			return;
 		}
-	} else if ( !test_export(exp, 0)) {
-		if (test_export(exp, 1))
+	} else if ( !export_test(&exp->m_export, 0)) {
+		if (export_test(&exp->m_export, 1))
 			xlog(L_ERROR, "%s requires fsid= for NFS export", path);
 		else
 			xlog(L_ERROR, "%s does not support NFS export", path);
diff --git a/utils/mountd/Makefile.am b/utils/mountd/Makefile.am
index 859f28ecd6f3..13b25c90f06e 100644
--- a/utils/mountd/Makefile.am
+++ b/utils/mountd/Makefile.am
@@ -18,7 +18,7 @@ mountd_LDADD = ../../support/export/libexport.a \
 	       ../../support/nfs/libnfs.la \
 	       ../../support/misc/libmisc.a \
 	       $(OPTLIBS) \
-	       $(LIBBSD) $(LIBWRAP) $(LIBNSL) $(LIBBLKID) $(LIBTIRPC) \
+	       $(LIBBSD) $(LIBWRAP) $(LIBNSL) $(LIBBLKID) -luuid $(LIBTIRPC) \
 	       $(LIBPTHREAD)
 mountd_CPPFLAGS = $(AM_CPPFLAGS) $(CPPFLAGS) \
 		  -I$(top_builddir)/support/include \
-- 
2.31.1


