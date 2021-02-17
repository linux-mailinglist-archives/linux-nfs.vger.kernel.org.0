Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9450331DFC0
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Feb 2021 20:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhBQTmf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Feb 2021 14:42:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50583 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233374AbhBQTme (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Feb 2021 14:42:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613590867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wE+fMXUcVEsuXdUx1P7iy+Wcubauj8G6lDryuKeSjH4=;
        b=PrM+KWklUflep9tJGHJbdw5pf1eFFeifCEHkZaoWqrWcJ8dSRV8KBAI7zAYAndQlk/PzcA
        6fAL+35sEdHQw2I2HmLe8guCN9t3tfAtow/252TAfXu+/HIOK70Np2/I5oCYX+UCyz7jGZ
        a5WTM71cEeVaen7H4IxGhImKWCmRFY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-ksiN4iT-NPmjpv1M5nUzvQ-1; Wed, 17 Feb 2021 14:41:06 -0500
X-MC-Unique: ksiN4iT-NPmjpv1M5nUzvQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33F32107ACE3
        for <linux-nfs@vger.kernel.org>; Wed, 17 Feb 2021 19:41:05 +0000 (UTC)
Received: from madhat.home.dicksonnet.net (ovpn-112-108.phx2.redhat.com [10.3.112.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E783618B5E
        for <linux-nfs@vger.kernel.org>; Wed, 17 Feb 2021 19:41:04 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 3/6] exportd: multiple threads
Date:   Wed, 17 Feb 2021 14:42:37 -0500
Message-Id: <20210217194240.79915-4-steved@redhat.com>
In-Reply-To: <20210217194240.79915-1-steved@redhat.com>
References: <20210217194240.79915-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ported the multiple thread code from mountd (commit 11d34d11)

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 nfs.conf                  |   3 +
 systemd/nfs.conf.man      |   9 +++
 utils/exportd/exportd.c   | 118 ++++++++++++++++++++++++++++++++++++--
 utils/exportd/exportd.man |   7 +++
 4 files changed, 133 insertions(+), 4 deletions(-)

diff --git a/nfs.conf b/nfs.conf
index 9fcf1bf..4b344fa 100644
--- a/nfs.conf
+++ b/nfs.conf
@@ -29,6 +29,9 @@
 # port=0
 # udp-port=0
 #
+[exportd]
+# debug="all|auth|call|general|parse"
+# threads=1
 [mountd]
 # debug="all|auth|call|general|parse"
 # manage-gids=n
diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
index 16e0ec4..a4379fd 100644
--- a/systemd/nfs.conf.man
+++ b/systemd/nfs.conf.man
@@ -128,6 +128,15 @@ then the client will be able to mount the path as
 but on the server, this will resolve to the path
 .BR /my/root/filesystem .
 
+.TP
+.B exportd
+Recognized values:
+.B threads
+
+See
+.BR exportd (8)
+for details.
+
 .TP
 .B nfsdcltrack
 Recognized values:
diff --git a/utils/exportd/exportd.c b/utils/exportd/exportd.c
index 150938c..bf5f431 100644
--- a/utils/exportd/exportd.c
+++ b/utils/exportd/exportd.c
@@ -15,6 +15,8 @@
 #include <signal.h>
 #include <string.h>
 #include <getopt.h>
+#include <errno.h>
+#include <wait.h>
 
 #include "nfslib.h"
 #include "conffile.h"
@@ -26,6 +28,13 @@ extern void my_svc_run(void);
 struct state_paths etab;
 struct state_paths rmtab;
 
+/* Number of mountd threads to start.   Default is 1 and
+ * that's probably enough unless you need hundreds of
+ * clients to be able to mount at once.  */
+static int num_threads = 1;
+/* Arbitrary limit on number of threads */
+#define MAX_THREADS 64
+
 int manage_gids;
 int use_ipaddr = -1;
 
@@ -34,6 +43,7 @@ static struct option longopts[] =
 	{ "foreground", 0, 0, 'F' },
 	{ "debug", 1, 0, 'd' },
 	{ "help", 0, 0, 'h' },
+	{ "num-threads", 1, 0, 't' },
 	{ NULL, 0, 0, 0 }
 };
 
@@ -42,10 +52,85 @@ static struct option longopts[] =
  */
 inline static void set_signals(void);
 
+/* Wait for all worker child processes to exit and reap them */
+static void
+wait_for_workers (void)
+{
+	int status;
+	pid_t pid;
+
+	for (;;) {
+
+		pid = waitpid(0, &status, 0);
+
+		if (pid < 0) {
+			if (errno == ECHILD)
+				return; /* no more children */
+			xlog(L_FATAL, "mountd: can't wait: %s\n",
+					strerror(errno));
+		}
+
+		/* Note: because we SIG_IGN'd SIGCHLD earlier, this
+		 * does not happen on 2.6 kernels, and waitpid() blocks
+		 * until all the children are dead then returns with
+		 * -ECHILD.  But, we don't need to do anything on the
+		 * death of individual workers, so we don't care. */
+		xlog(L_NOTICE, "mountd: reaped child %d, status %d\n",
+				(int)pid, status);
+	}
+}
+
+/* Fork num_threads worker children and wait for them */
+static void
+fork_workers(void)
+{
+	int i;
+	pid_t pid;
+
+	xlog(L_NOTICE, "mountd: starting %d threads\n", num_threads);
+
+	for (i = 0 ; i < num_threads ; i++) {
+		pid = fork();
+		if (pid < 0) {
+			xlog(L_FATAL, "mountd: cannot fork: %s\n",
+					strerror(errno));
+		}
+		if (pid == 0) {
+			/* worker child */
+
+			/* Re-enable the default action on SIGTERM et al
+			 * so that workers die naturally when sent them.
+			 * Only the parent unregisters with pmap and
+			 * hence needs to do special SIGTERM handling. */
+			struct sigaction sa;
+			sa.sa_handler = SIG_DFL;
+			sa.sa_flags = 0;
+			sigemptyset(&sa.sa_mask);
+			sigaction(SIGHUP, &sa, NULL);
+			sigaction(SIGINT, &sa, NULL);
+			sigaction(SIGTERM, &sa, NULL);
+
+			/* fall into my_svc_run in caller */
+			return;
+		}
+	}
+
+	/* in parent */
+	wait_for_workers();
+	xlog(L_NOTICE, "exportd: no more workers, exiting\n");
+	exit(0);
+}
+
 static void 
 killer (int sig)
 {
+	if (num_threads > 1) {
+		/* play Kronos and eat our children */
+		kill(0, SIGTERM);
+		wait_for_workers();
+	}
 	xlog (L_NOTICE, "Caught signal %d, exiting.", sig);
+
 	exit(0);
 }
 static void
@@ -78,10 +163,20 @@ static void
 usage(const char *prog, int n)
 {
 	fprintf(stderr,
-		"Usage: %s [-f|--foreground] [-h|--help] [-d kind|--debug kind]\n", prog);
+		"Usage: %s [-f|--foreground] [-h|--help] [-d kind|--debug kind]\n"
+"	[-t num|--num-threads=num]\n", prog);
 	exit(n);
 }
 
+inline static void 
+read_exportd_conf(char *progname)
+{
+	conf_init_file(NFS_CONFFILE);
+
+	xlog_from_conffile(progname);
+
+	num_threads = conf_get_num("exportd", "threads", num_threads);
+}
 int
 main(int argc, char **argv)
 {
@@ -98,10 +193,10 @@ main(int argc, char **argv)
 	/* Initialize logging. */
 	xlog_open(progname);
 
-	conf_init_file(NFS_CONFFILE);
-	xlog_from_conffile(progname);
+	/* Read in config setting */
+	read_exportd_conf(progname);
 
-	while ((c = getopt_long(argc, argv, "d:fh", longopts, NULL)) != EOF) {
+	while ((c = getopt_long(argc, argv, "d:fht:", longopts, NULL)) != EOF) {
 		switch (c) {
 		case 'd':
 			xlog_sconfig(optarg, 1);
@@ -112,6 +207,9 @@ main(int argc, char **argv)
 		case 'h':
 			usage(progname, 0);
 			break;
+		case 't':
+			num_threads = atoi (optarg);
+			break;
 		case '?':
 		default:
 			usage(progname, 1);
@@ -132,6 +230,18 @@ main(int argc, char **argv)
 	set_signals();
 	daemon_ready();
 
+	/* silently bounds check num_threads */
+	if (foreground)
+		num_threads = 1;
+	else if (num_threads < 1)
+		num_threads = 1;
+	else if (num_threads > MAX_THREADS)
+		num_threads = MAX_THREADS;
+
+	if (num_threads > 1)
+		fork_workers();
+
+
 	/* Open files now to avoid sharing descriptors among forked processes */
 	cache_open();
 
diff --git a/utils/exportd/exportd.man b/utils/exportd/exportd.man
index 96e133c..fae47d0 100644
--- a/utils/exportd/exportd.man
+++ b/utils/exportd/exportd.man
@@ -44,6 +44,13 @@ Run in foreground (do not daemonize)
 .TP
 .B \-h " or " \-\-help
 Display usage message.
+.TP
+.BR "\-t N" " or " "\-\-num\-threads=N " or  " \-\-num\-threads N "
+This option specifies the number of worker threads that rpc.mountd
+spawns.  The default is 1 thread, which is probably enough.  More
+threads are usually only needed for NFS servers which need to handle
+mount storms of hundreds of NFS mounts in a few seconds, or when
+your DNS server is slow or unreliable.
 .SH CONFIGURATION FILE
 Many of the options that can be set on the command line can also be
 controlled through values set in the
-- 
2.29.2

