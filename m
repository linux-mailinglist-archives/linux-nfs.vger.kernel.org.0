Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C666E31F297
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Feb 2021 23:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhBRWyq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Feb 2021 17:54:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59421 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229691AbhBRWyp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Feb 2021 17:54:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613688798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YLwgB55zz6wz0rZn1ajTGbZqejrcEaFo9EnSSyYIBok=;
        b=jJTTTRRfRyzsLd3cAUbapSLOKR6zqrKGmlX8n76V3988Lkrsn+TEMxLaZmkyhmCKktbeyP
        CoMEb0goIcsjbD6Ib6wVKxvB0mJn1CxUmLlBlJtjzxO+cCPHHy7wBdX2Dd2q6f/m7rpOyP
        QJpphKLApTkqE5Vt+DPj6pJldDYscL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-RYStrU0KOCeVjZxyTH6uCg-1; Thu, 18 Feb 2021 17:53:15 -0500
X-MC-Unique: RYStrU0KOCeVjZxyTH6uCg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 443BD6EE22
        for <linux-nfs@vger.kernel.org>; Thu, 18 Feb 2021 22:53:14 +0000 (UTC)
Received: from madhat.home.dicksonnet.net (ovpn-112-108.phx2.redhat.com [10.3.112.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03DDC60BE5
        for <linux-nfs@vger.kernel.org>; Thu, 18 Feb 2021 22:53:13 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 2/6] exportd: Moved cache upcalls routines into libexport.a
Date:   Thu, 18 Feb 2021 17:54:46 -0500
Message-Id: <20210218225450.674466-3-steved@redhat.com>
In-Reply-To: <20210218225450.674466-1-steved@redhat.com>
References: <20210218225450.674466-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Move the cache management code into libexport.a
so both mountd and exportd can use it.

Introduce cache_proccess_loop() which will
be used by exportd, instead of my_svc_run().

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 support/export/Makefile.am                |  3 +-
 {utils/mountd => support/export}/auth.c   |  4 +-
 {utils/mountd => support/export}/cache.c  | 46 +++++++++++++++++++++--
 support/export/export.h                   | 34 +++++++++++++++++
 {utils/mountd => support/export}/v4root.c |  0
 utils/exportd/Makefile.am                 |  8 +++-
 utils/exportd/exportd.c                   | 30 ++++++++++++++-
 utils/mountd/Makefile.am                  |  4 +-
 8 files changed, 118 insertions(+), 11 deletions(-)
 rename {utils/mountd => support/export}/auth.c (99%)
 rename {utils/mountd => support/export}/cache.c (98%)
 create mode 100644 support/export/export.h
 rename {utils/mountd => support/export}/v4root.c (100%)

diff --git a/support/export/Makefile.am b/support/export/Makefile.am
index 13f7a49..7de82a8 100644
--- a/support/export/Makefile.am
+++ b/support/export/Makefile.am
@@ -11,7 +11,8 @@ EXTRA_DIST	= mount.x
 
 noinst_LIBRARIES = libexport.a
 libexport_a_SOURCES = client.c export.c hostname.c \
-		      xtab.c mount_clnt.c mount_xdr.c
+		      xtab.c mount_clnt.c mount_xdr.c \
+			  cache.c auth.c v4root.c
 BUILT_SOURCES 	= $(GENFILES)
 
 noinst_HEADERS = mount.h
diff --git a/utils/mountd/auth.c b/support/export/auth.c
similarity index 99%
rename from utils/mountd/auth.c
rename to support/export/auth.c
index 67627f7..0bfa77d 100644
--- a/utils/mountd/auth.c
+++ b/support/export/auth.c
@@ -22,7 +22,7 @@
 #include "misc.h"
 #include "nfslib.h"
 #include "exportfs.h"
-#include "mountd.h"
+#include "export.h"
 #include "v4root.h"
 
 enum auth_error
@@ -43,11 +43,13 @@ extern int use_ipaddr;
 
 extern struct state_paths etab;
 
+/*
 void
 auth_init(void)
 {
 	auth_reload();
 }
+*/
 
 /*
  * A client can match many different netgroups and it's tough to know
diff --git a/utils/mountd/cache.c b/support/export/cache.c
similarity index 98%
rename from utils/mountd/cache.c
rename to support/export/cache.c
index a81e820..f1569af 100644
--- a/utils/mountd/cache.c
+++ b/support/export/cache.c
@@ -30,11 +30,14 @@
 #include "nfsd_path.h"
 #include "nfslib.h"
 #include "exportfs.h"
-#include "mountd.h"
-#include "fsloc.h"
+#include "export.h"
 #include "pseudoflavors.h"
 #include "xcommon.h"
 
+#ifdef HAVE_JUNCTION_SUPPORT
+#include "fsloc.h"
+#endif
+
 #ifdef USE_BLKID
 #include "blkid/blkid.h"
 #endif
@@ -44,6 +47,7 @@
  */
 void	cache_set_fds(fd_set *fdset);
 int	cache_process_req(fd_set *readfds);
+void cache_process_loop(void);
 
 enum nfsd_fsid {
 	FSID_DEV = 0,
@@ -909,6 +913,7 @@ out:
 	xlog(D_CALL, "nfsd_fh: found %p path %s", found, found ? found->e_path : NULL);
 }
 
+#ifdef HAVE_JUNCTION_SUPPORT
 static void write_fsloc(char **bp, int *blen, struct exportent *ep)
 {
 	struct servers *servers;
@@ -931,7 +936,7 @@ static void write_fsloc(char **bp, int *blen, struct exportent *ep)
 	qword_addint(bp, blen, servers->h_referral);
 	release_replicas(servers);
 }
-
+#endif
 static void write_secinfo(char **bp, int *blen, struct exportent *ep, int flag_mask)
 {
 	struct sec_entry *p;
@@ -974,7 +979,10 @@ static int dump_to_cache(int f, char *buf, int blen, char *domain,
 		qword_addint(&bp, &blen, exp->e_anonuid);
 		qword_addint(&bp, &blen, exp->e_anongid);
 		qword_addint(&bp, &blen, exp->e_fsid);
+
+#ifdef HAVE_JUNCTION_SUPPORT
 		write_fsloc(&bp, &blen, exp);
+#endif
 		write_secinfo(&bp, &blen, exp, flag_mask);
 		if (exp->e_uuid == NULL || different_fs) {
 			char u[16];
@@ -1509,6 +1517,38 @@ int cache_process_req(fd_set *readfds)
 	return cnt;
 }
 
+/**
+ * cache_process_loop - process incoming upcalls
+ */
+void cache_process_loop(void)
+{
+	fd_set	readfds;
+	int	selret;
+
+	FD_ZERO(&readfds);
+
+	for (;;) {
+
+		cache_set_fds(&readfds);
+
+		selret = select(FD_SETSIZE, &readfds,
+				(void *) 0, (void *) 0, (struct timeval *) 0);
+
+
+		switch (selret) {
+		case -1:
+			if (errno == EINTR || errno == ECONNREFUSED
+			 || errno == ENETUNREACH || errno == EHOSTUNREACH)
+				continue;
+			xlog(L_ERROR, "my_svc_run() - select: %m");
+			return;
+
+		default:
+			cache_process_req(&readfds);
+		}
+	}
+}
+
 
 /*
  * Give IP->domain and domain+path->options to kernel
diff --git a/support/export/export.h b/support/export/export.h
new file mode 100644
index 0000000..4296db1
--- /dev/null
+++ b/support/export/export.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) 2021 Red Hat <nfs@redhat.com>
+ *
+ * support/export/export.h
+ *
+ * Declarations for export support 
+ */
+
+#ifndef EXPORT_H
+#define EXPORT_H
+
+#include "nfslib.h"
+
+unsigned int	auth_reload(void);
+nfs_export *	auth_authenticate(const char *what,
+					const struct sockaddr *caller,
+					const char *path);
+
+void		cache_open(void);
+void		cache_process_loop(void);
+
+struct nfs_fh_len *
+		cache_get_filehandle(nfs_export *exp, int len, char *p);
+int		cache_export(nfs_export *exp, char *path);
+
+bool ipaddr_client_matches(nfs_export *exp, struct addrinfo *ai);
+bool namelist_client_matches(nfs_export *exp, char *dom);
+bool client_matches(nfs_export *exp, char *dom, struct addrinfo *ai);
+
+static inline bool is_ipaddr_client(char *dom)
+{
+	return dom[0] == '$';
+}
+#endif /* EXPORT__H */
diff --git a/utils/mountd/v4root.c b/support/export/v4root.c
similarity index 100%
rename from utils/mountd/v4root.c
rename to support/export/v4root.c
diff --git a/utils/exportd/Makefile.am b/utils/exportd/Makefile.am
index 6e61267..eb0f0a8 100644
--- a/utils/exportd/Makefile.am
+++ b/utils/exportd/Makefile.am
@@ -10,9 +10,13 @@ KPREFIX		= @kprefix@
 sbin_PROGRAMS	= exportd
 
 exportd_SOURCES = exportd.c
-exportd_LDADD = ../../support/nfs/libnfs.la
+exportd_LDADD = ../../support/export/libexport.a \
+			../../support/nfs/libnfs.la \
+			../../support/misc/libmisc.a \
+			$(OPTLIBS) $(LIBBLKID) $(LIBPTHREAD) 
 
-exportd_CPPFLAGS = $(AM_CPPFLAGS) $(CPPFLAGS)
+exportd_CPPFLAGS = $(AM_CPPFLAGS) $(CPPFLAGS) \
+		-I$(top_srcdir)/support/export
 
 MAINTAINERCLEANFILES = Makefile.in
 
diff --git a/utils/exportd/exportd.c b/utils/exportd/exportd.c
index 3a3dea6..2f67e3b 100644
--- a/utils/exportd/exportd.c
+++ b/utils/exportd/exportd.c
@@ -18,7 +18,16 @@
 
 #include "nfslib.h"
 #include "conffile.h"
+#include "exportfs.h"
+#include "export.h"
 
+extern void my_svc_run(void);
+
+struct state_paths etab;
+struct state_paths rmtab;
+
+int manage_gids;
+int use_ipaddr = -1;
 
 static struct option longopts[] =
 {
@@ -36,7 +45,7 @@ inline static void set_signals(void);
 static void 
 killer (int sig)
 {
-	xlog (L_NOTICE, "Caught signal %d, un-registering and exiting.", sig);
+	xlog (L_NOTICE, "Caught signal %d, exiting.", sig);
 	exit(0);
 }
 static void
@@ -110,12 +119,29 @@ main(int argc, char **argv)
 
 	}
 
+	if (!setup_state_path_names(progname, ETAB, ETABTMP, ETABLCK, &etab))
+		return 1;
+	if (!setup_state_path_names(progname, RMTAB, RMTABTMP, RMTABLCK, &rmtab))
+		return 1;
+
 	if (!foreground) 
 		xlog_stderr(0);
 
 	daemon_init(foreground);
 
 	set_signals();
-	
 	daemon_ready();
+
+	/* Open files now to avoid sharing descriptors among forked processes */
+	cache_open();
+
+	/* Process incoming upcalls */
+	cache_process_loop();
+
+	xlog(L_ERROR, "%s: process loop terminated unexpectedly. Exiting...\n",
+		progname);
+
+	free_state_path_names(&etab);
+	free_state_path_names(&rmtab);
+	exit(1);
 }
diff --git a/utils/mountd/Makefile.am b/utils/mountd/Makefile.am
index 18610f1..cac3275 100644
--- a/utils/mountd/Makefile.am
+++ b/utils/mountd/Makefile.am
@@ -13,8 +13,8 @@ KPREFIX		= @kprefix@
 sbin_PROGRAMS	= mountd
 
 noinst_HEADERS = fsloc.h
-mountd_SOURCES = mountd.c mount_dispatch.c auth.c rmtab.c cache.c \
-		 svc_run.c fsloc.c v4root.c mountd.h
+mountd_SOURCES = mountd.c mount_dispatch.c rmtab.c \
+		 svc_run.c fsloc.c mountd.h
 mountd_LDADD = ../../support/export/libexport.a \
 	       ../../support/nfs/libnfs.la \
 	       ../../support/misc/libmisc.a \
-- 
2.29.2

