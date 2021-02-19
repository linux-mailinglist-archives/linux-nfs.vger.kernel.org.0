Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A6431FFAF
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Feb 2021 21:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhBSUIL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Feb 2021 15:08:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56395 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229722AbhBSUIJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Feb 2021 15:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613765203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C852xBmX9sqhFt2KctvOtg+o/FhIV7JjeKkxhkSwoLU=;
        b=TiF1q4UJEb6YQl1VDg2OSmF7JAsZqZ4EK4OBlyTZYTuznvbGLfQLJw0Jv2Er56yo0DAxhz
        tpW+4f5ROySkZoAznqLGtA1PLM/YogKf22k1dMFwh1qgG/y88o5SN018GWyUI9r6q5Ilp7
        WWrze7M+UqpzKVulbQh+rxE87CJ9mfQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-cSLLG_nTO8KS66MpGmVP9A-1; Fri, 19 Feb 2021 15:06:41 -0500
X-MC-Unique: cSLLG_nTO8KS66MpGmVP9A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A17B1E564
        for <linux-nfs@vger.kernel.org>; Fri, 19 Feb 2021 20:06:40 +0000 (UTC)
Received: from madhat.home.dicksonnet.net (ovpn-112-108.phx2.redhat.com [10.3.112.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4788519801
        for <linux-nfs@vger.kernel.org>; Fri, 19 Feb 2021 20:06:40 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 4/7] exportd/exportfs: Add the state-directory-path option
Date:   Fri, 19 Feb 2021 15:08:12 -0500
Message-Id: <20210219200815.792667-5-steved@redhat.com>
In-Reply-To: <20210219200815.792667-1-steved@redhat.com>
References: <20210219200815.792667-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ported state-directory-path option from mountd (commit a15bd948)
Signed-off-by: Steve Dickson <steved@redhat.com>
---
 nfs.conf                    |  1 +
 systemd/nfs.conf.man        |  3 ++-
 utils/exportd/exportd.c     | 35 +++++++++++++++++++++++++++--------
 utils/exportfs/exportfs.c   | 21 +++++++++++++--------
 utils/exportfs/exportfs.man |  7 +++++--
 5 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/nfs.conf b/nfs.conf
index 4b344fa..bebb2e3 100644
--- a/nfs.conf
+++ b/nfs.conf
@@ -31,6 +31,7 @@
 #
 [exportd]
 # debug="all|auth|call|general|parse"
+# state-directory-path=/var/lib/nfs
 # threads=1
 [mountd]
 # debug="all|auth|call|general|parse"
diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
index a4379fd..d2187f8 100644
--- a/systemd/nfs.conf.man
+++ b/systemd/nfs.conf.man
@@ -131,7 +131,8 @@ but on the server, this will resolve to the path
 .TP
 .B exportd
 Recognized values:
-.B threads
+.BR threads ,
+.BR state-directory-path
 
 See
 .BR exportd (8)
diff --git a/utils/exportd/exportd.c b/utils/exportd/exportd.c
index c814503..7130bcb 100644
--- a/utils/exportd/exportd.c
+++ b/utils/exportd/exportd.c
@@ -26,7 +26,6 @@
 extern void my_svc_run(void);
 
 struct state_paths etab;
-struct state_paths rmtab;
 
 /* Number of mountd threads to start.   Default is 1 and
  * that's probably enough unless you need hundreds of
@@ -80,6 +79,12 @@ wait_for_workers (void)
 	}
 }
 
+inline void
+cleanup_lockfiles (void)
+{
+	unlink(etab.lockfn);
+}
+
 /* Fork num_threads worker children and wait for them */
 static void
 fork_workers(void)
@@ -117,6 +122,8 @@ fork_workers(void)
 
 	/* in parent */
 	wait_for_workers();
+	cleanup_lockfiles();
+	free_state_path_names(&etab);
 	xlog(L_NOTICE, "exportd: no more workers, exiting\n");
 	exit(0);
 }
@@ -129,6 +136,8 @@ killer (int sig)
 		kill(0, SIGTERM);
 		wait_for_workers();
 	}
+	cleanup_lockfiles();
+	free_state_path_names(&etab);
 	xlog (L_NOTICE, "Caught signal %d, exiting.", sig);
 
 	exit(0);
@@ -159,24 +168,33 @@ set_signals(void)
 	sa.sa_handler = sig_hup;
 	sigaction(SIGHUP, &sa, NULL);
 }
+
 static void
 usage(const char *prog, int n)
 {
 	fprintf(stderr,
 		"Usage: %s [-f|--foreground] [-h|--help] [-d kind|--debug kind]\n"
+"	[-s|--state-directory-path path]\n"
 "	[-t num|--num-threads=num]\n", prog);
 	exit(n);
 }
 
 inline static void 
-read_exportd_conf(char *progname)
+read_exportd_conf(char *progname, char **argv)
 {
+	char *s;
+
 	conf_init_file(NFS_CONFFILE);
 
 	xlog_set_debug(progname);
 
 	num_threads = conf_get_num("exportd", "threads", num_threads);
+
+	s = conf_get_str("exportd", "state-directory-path");
+	if (s && !state_setup_basedir(argv[0], s))
+		exit(1);
 }
+
 int
 main(int argc, char **argv)
 {
@@ -194,9 +212,9 @@ main(int argc, char **argv)
 	xlog_open(progname);
 
 	/* Read in config setting */
-	read_exportd_conf(progname);
+	read_exportd_conf(progname, argv);
 
-	while ((c = getopt_long(argc, argv, "d:fht:", longopts, NULL)) != EOF) {
+	while ((c = getopt_long(argc, argv, "d:fhs:t:", longopts, NULL)) != EOF) {
 		switch (c) {
 		case 'd':
 			xlog_sconfig(optarg, 1);
@@ -207,6 +225,10 @@ main(int argc, char **argv)
 		case 'h':
 			usage(progname, 0);
 			break;
+		case 's':
+			if (!state_setup_basedir(argv[0], optarg))
+				exit(1);
+			break;
 		case 't':
 			num_threads = atoi (optarg);
 			break;
@@ -219,9 +241,7 @@ main(int argc, char **argv)
 
 	if (!setup_state_path_names(progname, ETAB, ETABTMP, ETABLCK, &etab))
 		return 1;
-	if (!setup_state_path_names(progname, RMTAB, RMTABTMP, RMTABLCK, &rmtab))
-		return 1;
-
+	
 	if (!foreground) 
 		xlog_stderr(0);
 
@@ -252,6 +272,5 @@ main(int argc, char **argv)
 		progname);
 
 	free_state_path_names(&etab);
-	free_state_path_names(&rmtab);
 	exit(1);
 }
diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index f8b446a..262dd19 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -92,10 +92,21 @@ release_lockfile()
 	}
 }
 inline static void 
-read_exportfs_conf(void)
+read_exportfs_conf(char **argv)
 {
+	char *s;
+
 	conf_init_file(NFS_CONFFILE);
 	xlog_set_debug("exportfs");
+
+	/* NOTE: following uses "mountd" section of nfs.conf !!!! */
+	s = conf_get_str("mountd", "state-directory-path");
+	/* Also look in the exportd section */
+	if (s == NULL)
+		s = conf_get_str("exportd", "state-directory-path");
+	if (s && !state_setup_basedir(argv[0], s))
+		exit(1);
+
 }
 int
 main(int argc, char **argv)
@@ -110,7 +121,6 @@ main(int argc, char **argv)
 	int	f_ignore = 0;
 	int	i, c;
 	int	force_flush = 0;
-	char	*s;
 
 	if ((progname = strrchr(argv[0], '/')) != NULL)
 		progname++;
@@ -122,15 +132,10 @@ main(int argc, char **argv)
 	xlog_syslog(0);
 
 	/* Read in config setting */
-	read_exportfs_conf();
+	read_exportfs_conf(argv);
 
 	nfsd_path_init();
 
-	/* NOTE: following uses "mountd" section of nfs.conf !!!! */
-	s = conf_get_str("mountd", "state-directory-path");
-	if (s && !state_setup_basedir(argv[0], s))
-		exit(1);
-
 	while ((c = getopt(argc, argv, "ad:fhio:ruvs")) != EOF) {
 		switch(c) {
 		case 'a':
diff --git a/utils/exportfs/exportfs.man b/utils/exportfs/exportfs.man
index 91d3589..6d417a7 100644
--- a/utils/exportfs/exportfs.man
+++ b/utils/exportfs/exportfs.man
@@ -167,9 +167,11 @@ When a list is given, the members should be comma-separated.
 .B exportfs
 will also recognize the
 .B state-directory-path
-value from the
+value from both the 
 .B [mountd]
-section.
+section and the
+.B [exportd]
+section
 
 .SH DISCUSSION
 .SS Exporting Directories
@@ -327,6 +329,7 @@ table of clients accessing server's exports
 .BR exports (5),
 .BR nfs.conf (5),
 .BR rpc.mountd (8),
+.BR exportd (8),
 .BR netgroup (5)
 .SH AUTHORS
 Olaf Kirch <okir@monad.swb.de>
-- 
2.29.2

