Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4084631FFB0
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Feb 2021 21:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhBSUIM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Feb 2021 15:08:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41097 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229623AbhBSUIJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Feb 2021 15:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613765202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ktjIfm0wbpWrOkylT3NrSSvWBYPpllwBUbdQgtij/Jw=;
        b=P/yOCOnWByYXFHSCn1yDydGcXskgafSbO9MzzLGx324gUKzchetEqKBBJzJCz5XEPQ4mIe
        8rZR+7SNOiXw3zqM1n9l3zAJVJkQToow56N5k7/23s5HwzchGsySfAt4Vz765x13yj9n7L
        z8i/lTCVuKy6+xdGKqGmedwV2Rk0l9E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-3L2gavSTOwSy_MgNRJbzwQ-1; Fri, 19 Feb 2021 15:06:40 -0500
X-MC-Unique: 3L2gavSTOwSy_MgNRJbzwQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F7CA1E561
        for <linux-nfs@vger.kernel.org>; Fri, 19 Feb 2021 20:06:39 +0000 (UTC)
Received: from madhat.home.dicksonnet.net (ovpn-112-108.phx2.redhat.com [10.3.112.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE1312B161
        for <linux-nfs@vger.kernel.org>; Fri, 19 Feb 2021 20:06:38 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 1/7] exportd: the initial shell of the v4 export support
Date:   Fri, 19 Feb 2021 15:08:09 -0500
Message-Id: <20210219200815.792667-2-steved@redhat.com>
In-Reply-To: <20210219200815.792667-1-steved@redhat.com>
References: <20210219200815.792667-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 .gitignore                |   1 +
 configure.ac              |   1 +
 utils/Makefile.am         |   1 +
 utils/exportd/Makefile.am |  58 ++++++++++++++++++
 utils/exportd/exportd.c   | 121 ++++++++++++++++++++++++++++++++++++++
 utils/exportd/exportd.man |  74 +++++++++++++++++++++++
 6 files changed, 256 insertions(+)
 create mode 100644 utils/exportd/Makefile.am
 create mode 100644 utils/exportd/exportd.c
 create mode 100644 utils/exportd/exportd.man

diff --git a/.gitignore b/.gitignore
index e97b31f..c89d1cd 100644
--- a/.gitignore
+++ b/.gitignore
@@ -47,6 +47,7 @@ utils/idmapd/idmapd
 utils/lockd/lockd
 utils/mount/mount.nfs
 utils/mountd/mountd
+utils/exportd/exportd
 utils/nfsd/nfsd
 utils/nfsstat/nfsstat
 utils/nhfsstone/nhfsstone
diff --git a/configure.ac b/configure.ac
index 50847d8..ffd6247 100644
--- a/configure.ac
+++ b/configure.ac
@@ -706,6 +706,7 @@ AC_CONFIG_FILES([
 	utils/idmapd/Makefile
 	utils/mount/Makefile
 	utils/mountd/Makefile
+	utils/exportd/Makefile
 	utils/nfsd/Makefile
 	utils/nfsref/Makefile
 	utils/nfsstat/Makefile
diff --git a/utils/Makefile.am b/utils/Makefile.am
index 4c930a4..2a54b90 100644
--- a/utils/Makefile.am
+++ b/utils/Makefile.am
@@ -5,6 +5,7 @@ OPTDIRS =
 if CONFIG_NFSV4
 OPTDIRS += idmapd
 OPTDIRS += nfsidmap
+OPTDIRS += exportd
 endif
 
 if CONFIG_NFSV41
diff --git a/utils/exportd/Makefile.am b/utils/exportd/Makefile.am
new file mode 100644
index 0000000..6e61267
--- /dev/null
+++ b/utils/exportd/Makefile.am
@@ -0,0 +1,58 @@
+## Process this file with automake to produce Makefile.in
+
+OPTLIBS		=
+
+man8_MANS	= exportd.man
+EXTRA_DIST	= $(man8_MANS)
+
+NFSPREFIX	= nfsv4.
+KPREFIX		= @kprefix@
+sbin_PROGRAMS	= exportd
+
+exportd_SOURCES = exportd.c
+exportd_LDADD = ../../support/nfs/libnfs.la
+
+exportd_CPPFLAGS = $(AM_CPPFLAGS) $(CPPFLAGS)
+
+MAINTAINERCLEANFILES = Makefile.in
+
+#######################################################################
+# The following allows the current practice of having
+# daemons renamed during the install to include NFSPREFIX
+# and the KPREFIX
+# This could all be done much easier with program_transform_name
+# ( program_transform_name = s/^/$(NFSPREFIX)$(KPREFIX)/ )
+# but that also renames the man pages, which the current
+# practice does not do.
+install-exec-hook:
+	(cd $(DESTDIR)$(sbindir) && \
+	  for p in $(sbin_PROGRAMS); do \
+	    mv -f $$p$(EXEEXT) $(NFSPREFIX)$(KPREFIX)$$p$(EXEEXT) ;\
+	  done)
+uninstall-hook:
+	(cd $(DESTDIR)$(sbindir) && \
+	  for p in $(sbin_PROGRAMS); do \
+	    rm -f $(NFSPREFIX)$(KPREFIX)$$p$(EXEEXT) ;\
+	  done)
+
+
+# XXX This makes some assumptions about what automake does.
+# XXX But there is no install-man-hook or install-man-local.
+install-man: install-man8 install-man-links
+uninstall-man: uninstall-man8 uninstall-man-links
+
+install-man-links:
+	(cd $(DESTDIR)$(man8dir) && \
+	  for m in $(man8_MANS) $(dist_man8_MANS) $(nodist_man8_MANS); do \
+	    inst=`echo $$m | sed -e 's/man$$/8/'`; \
+	    rm -f $(NFSPREFIX)$$inst ; \
+	    $(LN_S) $$inst $(NFSPREFIX)$$inst ; \
+	  done)
+
+uninstall-man-links:
+	(cd $(DESTDIR)$(man8dir) && \
+	  for m in $(man8_MANS) $(dist_man8_MANS) $(nodist_man8_MANS); do \
+	    inst=`echo $$m | sed -e 's/man$$/8/'`; \
+	    rm -f $(NFSPREFIX)$$inst ; \
+	  done)
+
diff --git a/utils/exportd/exportd.c b/utils/exportd/exportd.c
new file mode 100644
index 0000000..3a3dea6
--- /dev/null
+++ b/utils/exportd/exportd.c
@@ -0,0 +1,121 @@
+/*
+ * Copyright (C) 2021 Red Hat <nfs@redhat.com>
+ *
+ * support/exportd/exportd.c
+ *
+ * Routines used to support NFSv4 exports
+ *
+ */
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stddef.h>
+#include <unistd.h>
+#include <signal.h>
+#include <string.h>
+#include <getopt.h>
+
+#include "nfslib.h"
+#include "conffile.h"
+
+
+static struct option longopts[] =
+{
+	{ "foreground", 0, 0, 'F' },
+	{ "debug", 1, 0, 'd' },
+	{ "help", 0, 0, 'h' },
+	{ NULL, 0, 0, 0 }
+};
+
+/*
+ * Signal handlers.
+ */
+inline static void set_signals(void);
+
+static void 
+killer (int sig)
+{
+	xlog (L_NOTICE, "Caught signal %d, un-registering and exiting.", sig);
+	exit(0);
+}
+static void
+sig_hup (int UNUSED(sig))
+{
+	/* don't exit on SIGHUP */
+	xlog (L_NOTICE, "Received SIGHUP... Ignoring.\n");
+	return;
+}
+inline static void 
+set_signals(void) 
+{
+	struct sigaction sa;
+
+	sa.sa_handler = SIG_IGN;
+	sa.sa_flags = 0;
+	sigemptyset(&sa.sa_mask);
+	sigaction(SIGPIPE, &sa, NULL);
+	/* WARNING: the following works on Linux and SysV, but not BSD! */
+	sigaction(SIGCHLD, &sa, NULL);
+
+	sa.sa_handler = killer;
+	sigaction(SIGINT, &sa, NULL);
+	sigaction(SIGTERM, &sa, NULL);
+
+	sa.sa_handler = sig_hup;
+	sigaction(SIGHUP, &sa, NULL);
+}
+static void
+usage(const char *prog, int n)
+{
+	fprintf(stderr,
+		"Usage: %s [-f|--foreground] [-h|--help] [-d kind|--debug kind]\n", prog);
+	exit(n);
+}
+
+int
+main(int argc, char **argv)
+{
+	char *progname;
+	int	foreground = 0;
+	int	 c;
+
+	/* Set the basename */
+	if ((progname = strrchr(argv[0], '/')) != NULL)
+		progname++;
+	else
+		progname = argv[0];
+
+	/* Initialize logging. */
+	xlog_open(progname);
+
+	conf_init_file(NFS_CONFFILE);
+	xlog_set_debug(progname);
+
+	while ((c = getopt_long(argc, argv, "d:fh", longopts, NULL)) != EOF) {
+		switch (c) {
+		case 'd':
+			xlog_sconfig(optarg, 1);
+			break;
+		case 'f':
+			foreground++;
+			break;
+		case 'h':
+			usage(progname, 0);
+			break;
+		case '?':
+		default:
+			usage(progname, 1);
+		}
+
+	}
+
+	if (!foreground) 
+		xlog_stderr(0);
+
+	daemon_init(foreground);
+
+	set_signals();
+	
+	daemon_ready();
+}
diff --git a/utils/exportd/exportd.man b/utils/exportd/exportd.man
new file mode 100644
index 0000000..d786e57
--- /dev/null
+++ b/utils/exportd/exportd.man
@@ -0,0 +1,74 @@
+.\"@(#)nfsv4.exportd.8"
+.\"
+.\" Copyright (C) 2021 Red Hat <nfs@redhat.com>
+.\"
+.TH nfsv4.exportd 8 "02 Feb 2021"
+.SH NAME
+nfsv4.exportd \- NFSv4 Server Mount Daemon
+.SH SYNOPSIS
+.BI "/usr/sbin/nfsv4.exportd [" options "]"
+.SH DESCRIPTION
+The
+.B nfsv4.exportd
+is used to manage NFSv4 exports. The NFSv4 server
+receives a mount request from a client and pass it up to 
+.B nfsv4.exportd. 
+.B nfsv4.exportd 
+then uses the exports(5) export
+table to verify the validity of the mount request.
+.PP
+An NFS server maintains a table of local physical file systems
+that are accessible to NFS clients.
+Each file system in this table is referred to as an
+.IR "exported file system" ,
+or
+.IR export ,
+for short.
+.PP
+Each file system in the export table has an access control list.
+.B nfsv4.exportd
+uses these access control lists to determine
+whether an NFS client is permitted to access a given file system.
+For details on how to manage your NFS server's export table, see the
+.BR exports (5)
+and
+.BR exportfs (8)
+man pages.
+.SH OPTIONS
+.TP
+.B \-d kind " or " \-\-debug kind
+Turn on debugging. Valid kinds are: all, auth, call, general and parse.
+.TP
+.B \-F " or " \-\-foreground
+Run in foreground (do not daemonize)
+.TP
+.B \-h " or " \-\-help
+Display usage message.
+.SH CONFIGURATION FILE
+Many of the options that can be set on the command line can also be
+controlled through values set in the
+.B [exportd]
+or, in some cases, the
+.B [nfsd]
+sections of the
+.I /etc/nfs.conf
+configuration file.
+Values recognized in the
+.B [exportd]
+section include 
+.B debug 
+which each have the same effect as the option with the same name.
+.SH FILES
+.TP 2.5i
+.I /etc/exports
+input file for
+.BR exportfs ,
+listing exports, export options, and access control lists
+.SH SEE ALSO
+.BR exportfs (8),
+.BR exports (5),
+.BR showmount (8),
+.BR nfs.conf (5),
+.BR firwall-cmd (1),
+.sp
+RFC 3530 - "Network File System (NFS) version 4 Protocol"
-- 
2.29.2

