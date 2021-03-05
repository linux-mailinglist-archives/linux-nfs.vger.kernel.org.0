Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10B632DE71
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Mar 2021 01:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhCEApB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Mar 2021 19:45:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:39694 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230408AbhCEApB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 4 Mar 2021 19:45:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BD55AAD2B;
        Fri,  5 Mar 2021 00:44:59 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <SteveD@RedHat.com>
Date:   Fri, 05 Mar 2021 11:43:24 +1100
Subject: [PATCH 7/7] mountd: add logging of NFSv4 clients attaching and
 detaching.
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Message-ID: <161490500401.15291.5928922406076481746.stgit@noble>
In-Reply-To: <161490464823.15291.13358214486203434566.stgit@noble>
References: <161490464823.15291.13358214486203434566.stgit@noble>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

NFSv4 does not have a MOUNT request like NFSv3 does (via the MOUNT
protocol).  So these cannot be logged.
NFSv4 does have SETCLIENTID and EXCHANGE_ID.  These are indirectly
visible though changes in /proc/fs/nfsd/clients.
When a new client attaches, a directory appears.  When the client
detaches, through a timeout (v4.0) or DESTROY_SESSION (v4.1+)
the directory disappears.

This patch adds tracking of these changes using inotify, with log
messages when a client attaches or detaches.

Unfortuantely clients are created in two steps, the second being a
confirmation.  This results in a temporary client appearing and
disappearing.  It is not possible (in Linux 5.10) to detect the
unconfirmed client, so extra attach/detach messages are generated.

This patch also moves some cache* function declarations into a header
file, and makes a few related changes to #includes.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 support/export/Makefile.am |    3 -
 support/export/cache.c     |    9 --
 support/export/export.h    |    9 ++
 support/export/v4clients.c |  177 ++++++++++++++++++++++++++++++++++++++++++++
 utils/exportd/exportd.c    |    1 
 utils/mountd/mountd.c      |    2 
 utils/mountd/mountd.h      |    5 -
 utils/mountd/svc_run.c     |    5 +
 8 files changed, 195 insertions(+), 16 deletions(-)
 create mode 100644 support/export/v4clients.c

diff --git a/support/export/Makefile.am b/support/export/Makefile.am
index a9e710c00ae8..eec737f66149 100644
--- a/support/export/Makefile.am
+++ b/support/export/Makefile.am
@@ -12,7 +12,8 @@ EXTRA_DIST	= mount.x
 noinst_LIBRARIES = libexport.a
 libexport_a_SOURCES = client.c export.c hostname.c \
 		      xtab.c mount_clnt.c mount_xdr.c \
-			  cache.c auth.c v4root.c fsloc.c
+		      cache.c auth.c v4root.c fsloc.c \
+		      v4clients.c
 BUILT_SOURCES 	= $(GENFILES)
 
 noinst_HEADERS = mount.h
diff --git a/support/export/cache.c b/support/export/cache.c
index c0848c3e437b..3e4f53c0a32e 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -42,13 +42,6 @@
 #include "blkid/blkid.h"
 #endif
 
-/*
- * Invoked by RPC service loop
- */
-void	cache_set_fds(fd_set *fdset);
-int	cache_process_req(fd_set *readfds);
-void cache_process_loop(void);
-
 enum nfsd_fsid {
 	FSID_DEV = 0,
 	FSID_NUM,
@@ -1537,6 +1530,7 @@ void cache_process_loop(void)
 	for (;;) {
 
 		cache_set_fds(&readfds);
+		v4clients_set_fds(&readfds);
 
 		selret = select(FD_SETSIZE, &readfds,
 				(void *) 0, (void *) 0, (struct timeval *) 0);
@@ -1552,6 +1546,7 @@ void cache_process_loop(void)
 
 		default:
 			cache_process_req(&readfds);
+			v4clients_process(&readfds);
 		}
 	}
 }
diff --git a/support/export/export.h b/support/export/export.h
index 4296db1ad9b1..8d5a0d3004ef 100644
--- a/support/export/export.h
+++ b/support/export/export.h
@@ -3,13 +3,14 @@
  *
  * support/export/export.h
  *
- * Declarations for export support 
+ * Declarations for export support
  */
 
 #ifndef EXPORT_H
 #define EXPORT_H
 
 #include "nfslib.h"
+#include "exportfs.h"
 
 unsigned int	auth_reload(void);
 nfs_export *	auth_authenticate(const char *what,
@@ -17,8 +18,14 @@ nfs_export *	auth_authenticate(const char *what,
 					const char *path);
 
 void		cache_open(void);
+void		cache_set_fds(fd_set *fdset);
+int		cache_process_req(fd_set *readfds);
 void		cache_process_loop(void);
 
+void		v4clients_init(void);
+void		v4clients_set_fds(fd_set *fdset);
+int		v4clients_process(fd_set *fdset);
+
 struct nfs_fh_len *
 		cache_get_filehandle(nfs_export *exp, int len, char *p);
 int		cache_export(nfs_export *exp, char *path);
diff --git a/support/export/v4clients.c b/support/export/v4clients.c
new file mode 100644
index 000000000000..ab1454e4c34e
--- /dev/null
+++ b/support/export/v4clients.c
@@ -0,0 +1,177 @@
+/*
+ * support/export/v4clients.c
+ *
+ * Montior clients appearing in, and disappearing from, /proc/fs/nfsd/clients
+ * and log relevant information.
+ */
+
+#include <unistd.h>
+#include <stdlib.h>
+#include <sys/inotify.h>
+#include <errno.h>
+#include "export.h"
+
+/* search.h declares 'struct entry' and nfs_prot.h
+ * does too.  Easiest fix is to trick search.h into
+ * calling its struct "struct Entry".
+ */
+#define entry Entry
+#include <search.h>
+#undef entry
+
+static int clients_fd = -1;
+
+void v4clients_init(void)
+{
+	if (clients_fd >= 0)
+		return;
+	clients_fd = inotify_init1(IN_NONBLOCK);
+	if (clients_fd < 0) {
+		xlog_err("Unable to initialise v4clients watcher: %s\n",
+			 strerror(errno));
+		return;
+	}
+	if (inotify_add_watch(clients_fd, "/proc/fs/nfsd/clients",
+			      IN_CREATE | IN_DELETE) < 0) {
+		xlog_err("Unable to watch /proc/fs/nfsd/clients: %s\n",
+			 strerror(errno));
+		close(clients_fd);
+		clients_fd = -1;
+		return;
+	}
+}
+
+void v4clients_set_fds(fd_set *fdset)
+{
+	if (clients_fd >= 0)
+		FD_SET(clients_fd, fdset);
+}
+
+static void *tree_root;
+
+struct ent {
+	unsigned long num;
+	char *clientid;
+	char *addr;
+	int vers;
+};
+
+static int ent_cmp(const void *av, const void *bv)
+{
+	const struct ent *a = av;
+	const struct ent *b = bv;
+
+	if (a->num < b->num)
+		return -1;
+	if (a->num > b->num)
+		return 1;
+	return 0;
+}
+
+static void free_ent(struct ent *ent)
+{
+	free(ent->clientid);
+	free(ent->addr);
+	free(ent);
+}
+
+static char *dup_line(char *line)
+{
+	char *ret;
+	char *e = strchr(line, '\n');
+	if (!e)
+		e = line + strlen(line);
+	ret = malloc(e - line + 1);
+	if (ret) {
+		memcpy(ret, line, e - line);
+		ret[e-line] = 0;
+	}
+	return ret;
+}
+
+static void add_id(int id)
+{
+	char buf[2048];
+	struct ent **ent;
+	struct ent *key;
+	char *path;
+	FILE *f;
+
+	asprintf(&path, "/proc/fs/nfsd/clients/%d/info", id);
+	f = fopen(path, "r");
+	if (!f) {
+		free(path);
+		return;
+	}
+	key = calloc(1, sizeof(*key));
+	if (!key) {
+		fclose(f);
+		free(path);
+		return;
+	}
+	key->num = id;
+	while (fgets(buf, sizeof(buf), f)) {
+		if (strncmp(buf, "clientid: ", 10) == 0)
+			key->clientid = dup_line(buf+10);
+		if (strncmp(buf, "address: ", 9) == 0)
+			key->addr = dup_line(buf+9);
+		if (strncmp(buf, "minor version: ", 15) == 0)
+			key->vers = atoi(buf+15);
+	}
+	fclose(f);
+	free(path);
+
+	xlog(L_NOTICE, "v4.%d client attached: %s from %s",
+	     key->vers, key->clientid, key->addr);
+
+	ent = tsearch(key, &tree_root, ent_cmp);
+
+	if (!ent || *ent != key)
+		/* Already existed, or insertion failed */
+		free_ent(key);
+}
+
+static void del_id(int id)
+{
+	struct ent key = {.num = id};
+	struct ent **e, *ent;
+
+	e = tfind(&key, &tree_root, ent_cmp);
+	if (!e || !*e)
+		return;
+	ent = *e;
+	tdelete(ent, &tree_root, ent_cmp);
+	xlog(L_NOTICE, "v4.%d client detached: %s from %s",
+	     ent->vers, ent->clientid, ent->addr);
+	free_ent(ent);
+}
+
+int v4clients_process(fd_set *fdset)
+{
+	char buf[4096] __attribute__((aligned(__alignof__(struct inotify_event))));
+	const struct inotify_event *ev;
+	ssize_t len;
+	char *ptr;
+
+	if (clients_fd < 0 ||
+	    !FD_ISSET(clients_fd, fdset))
+		return 0;
+
+	while ((len = read(clients_fd, buf, sizeof(buf))) > 0) {
+		for (ptr = buf; ptr < buf + len;
+		     ptr += sizeof(struct inotify_event) + ev->len) {
+			int id;
+			ev = (const struct inotify_event *)ptr;
+
+			id = atoi(ev->name);
+			if (id <= 0)
+				continue;
+			if (ev->mask & IN_CREATE)
+				add_id(id);
+			if (ev->mask & IN_DELETE)
+				del_id(id);
+		}
+	}
+	return 1;
+}
+
diff --git a/utils/exportd/exportd.c b/utils/exportd/exportd.c
index 76aad97375dc..25c41be6bc77 100644
--- a/utils/exportd/exportd.c
+++ b/utils/exportd/exportd.c
@@ -297,6 +297,7 @@ main(int argc, char **argv)
 
 	/* Open files now to avoid sharing descriptors among forked processes */
 	cache_open();
+	v4clients_init();
 
 	/* Process incoming upcalls */
 	cache_process_loop();
diff --git a/utils/mountd/mountd.c b/utils/mountd/mountd.c
index fce389661e7a..39e85fd53a87 100644
--- a/utils/mountd/mountd.c
+++ b/utils/mountd/mountd.c
@@ -31,6 +31,7 @@
 #include "pseudoflavors.h"
 #include "nfsd_path.h"
 #include "nfslib.h"
+#include "export.h"
 
 extern void my_svc_run(void);
 
@@ -924,6 +925,7 @@ main(int argc, char **argv)
 	nfsd_path_init();
 	/* Open files now to avoid sharing descriptors among forked processes */
 	cache_open();
+	v4clients_init();
 
 	xlog(L_NOTICE, "Version " VERSION " starting");
 	my_svc_run();
diff --git a/utils/mountd/mountd.h b/utils/mountd/mountd.h
index f058f01d3584..d30775313f66 100644
--- a/utils/mountd/mountd.h
+++ b/utils/mountd/mountd.h
@@ -60,9 +60,4 @@ bool ipaddr_client_matches(nfs_export *exp, struct addrinfo *ai);
 bool namelist_client_matches(nfs_export *exp, char *dom);
 bool client_matches(nfs_export *exp, char *dom, struct addrinfo *ai);
 
-static inline bool is_ipaddr_client(char *dom)
-{
-	return dom[0] == '$';
-}
-
 #endif /* MOUNTD_H */
diff --git a/utils/mountd/svc_run.c b/utils/mountd/svc_run.c
index 41b96d7fd1c3..167b9757bde2 100644
--- a/utils/mountd/svc_run.c
+++ b/utils/mountd/svc_run.c
@@ -56,10 +56,9 @@
 #ifdef HAVE_LIBTIRPC
 #include <rpc/rpc_com.h>
 #endif
+#include "export.h"
 
 void my_svc_run(void);
-void cache_set_fds(fd_set *fdset);
-int cache_process_req(fd_set *readfds);
 
 #if defined(__GLIBC__) && LONG_MAX != INT_MAX
 /* bug in glibc 2.3.6 and earlier, we need
@@ -101,6 +100,7 @@ my_svc_run(void)
 
 		readfds = svc_fdset;
 		cache_set_fds(&readfds);
+		v4clients_set_fds(&readfds);
 
 		selret = select(FD_SETSIZE, &readfds,
 				(void *) 0, (void *) 0, (struct timeval *) 0);
@@ -116,6 +116,7 @@ my_svc_run(void)
 
 		default:
 			selret -= cache_process_req(&readfds);
+			selret -= v4clients_process(&readfds);
 			if (selret)
 				svc_getreqset(&readfds);
 		}


