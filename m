Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F41132DE6E
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Mar 2021 01:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhCEAos (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Mar 2021 19:44:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:39558 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230408AbhCEAos (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 4 Mar 2021 19:44:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DF052AD29;
        Fri,  5 Mar 2021 00:44:46 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <SteveD@RedHat.com>
Date:   Fri, 05 Mar 2021 11:43:24 +1100
Subject: [PATCH 4/7] mountd: add logging for authentication results for
 accesses.
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Message-ID: <161490500400.15291.1321839163191458161.stgit@noble>
In-Reply-To: <161490464823.15291.13358214486203434566.stgit@noble>
References: <161490464823.15291.13358214486203434566.stgit@noble>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: NeilBrown <neil@brown.name>

When NFSv3 is used to mount a filesystem, success/failure messages are
logged by mountd and can be used for auditing.
When NFSv4 is used, there is no distinct "MOUNT" request, and nothing is
logged.

We can instead log authentication requests from the kernel.  These will
happen regularly - typically every 15 minutes of ongoing access - so
they may be too noisy, or might be more useful.  As they might not be
wanted, make them selectable with the "AUTH" facility in xlog().

Add a "-l" to enable these logs.  Alternately "debug = auth" will have
the same effect.

The same changes are made to both rpc.mountd and nfsv4.exportd.

Signed-off-by: NeilBrown <neil@brown.name>
---
 support/export/cache.c    |   18 +++++++++++++++++-
 systemd/nfs.conf.man      |   16 ++++++++++++++++
 utils/exportd/exportd.c   |    9 +++++++--
 utils/exportd/exportd.man |   17 +++++++++++++++++
 utils/mountd/mountd.c     |    8 +++++++-
 utils/mountd/mountd.man   |   21 +++++++++++++++++++++
 6 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index 49a761749ec6..50f7c7a15ceb 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -145,6 +145,15 @@ static void auth_unix_ip(int f)
 		client = client_compose(ai);
 		nfs_freeaddrinfo(ai);
 	}
+	if (!client)
+		xlog(D_AUTH, "failed authentication for IP %s", ipaddr);
+	else if	(!use_ipaddr)
+		xlog(D_AUTH, "successful authentication for IP %s as %s",
+		     ipaddr, *client ? client : "DEFAULT");
+	else
+		xlog(D_AUTH, "successful authentication for IP %s",
+			     ipaddr);
+
 	bp = buf; blen = sizeof(buf);
 	qword_add(&bp, &blen, "nfsd");
 	qword_add(&bp, &blen, ipaddr);
@@ -896,6 +905,8 @@ static void nfsd_fh(int f)
 	qword_addeol(&bp, &blen);
 	if (blen <= 0 || cache_write(f, buf, bp - buf) != bp - buf)
 		xlog(L_ERROR, "nfsd_fh: error writing reply");
+	if (!found)
+		xlog(D_AUTH, "denied access to %s", *dom == '$' ? dom+1 : dom);
 out:
 	if (found_path)
 		free(found_path);
@@ -987,8 +998,13 @@ static int dump_to_cache(int f, char *buf, int blen, char *domain,
 			qword_add(&bp, &blen, "uuid");
 			qword_addhex(&bp, &blen, u, 16);
 		}
-	} else
+		xlog(D_AUTH, "granted access to %s for %s",
+		     path, *domain == '$' ? domain+1 : domain);
+	} else {
 		qword_adduint(&bp, &blen, now + ttl);
+		xlog(D_AUTH, "denied access to %s for %s",
+		     path, *domain == '$' ? domain+1 : domain);
+	}
 	qword_addeol(&bp, &blen);
 	if (blen <= 0) {
 		errno = ENOBUFS;
diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
index d2187f8aca1a..8a02e154b1a2 100644
--- a/systemd/nfs.conf.man
+++ b/systemd/nfs.conf.man
@@ -138,6 +138,14 @@ See
 .BR exportd (8)
 for details.
 
+Note that setting 
+.B "\[dq]debug = auth\[dq]"
+for
+.B exportd
+is equivalent to providing the
+.B \-\-log\-auth
+option.
+
 .TP
 .B nfsdcltrack
 Recognized values:
@@ -197,6 +205,14 @@ section, are used to configure mountd.  See
 .BR rpc.mountd (8)
 for details.
 
+Note that setting 
+.B "\[dq]debug = auth\[dq]"
+for
+.B mountd
+is equivalent to providing the
+.B \-\-log\-auth
+option.
+
 The
 .B state-directory-path
 value in the
diff --git a/utils/exportd/exportd.c b/utils/exportd/exportd.c
index 0d7782becd51..8ea2f160773e 100644
--- a/utils/exportd/exportd.c
+++ b/utils/exportd/exportd.c
@@ -44,8 +44,10 @@ static struct option longopts[] =
 	{ "help", 0, 0, 'h' },
 	{ "manage-gids", 0, 0, 'g' },
 	{ "num-threads", 1, 0, 't' },
+	{ "log-auth", 0, 0, 'l' },
 	{ NULL, 0, 0, 0 }
 };
+static char shortopts[] = "d:fghs:t:l"
 
 /*
  * Signal handlers.
@@ -175,7 +177,7 @@ usage(const char *prog, int n)
 {
 	fprintf(stderr,
 		"Usage: %s [-f|--foreground] [-h|--help] [-d kind|--debug kind]\n"
-"	[-g|--manage-gids]\n"
+"	[-g|--manage-gids] [-l|--log-auth]\n"
 "	[-s|--state-directory-path path]\n"
 "	[-t num|--num-threads=num]\n", prog);
 	exit(n);
@@ -217,11 +219,14 @@ main(int argc, char **argv)
 	/* Read in config setting */
 	read_exportd_conf(progname, argv);
 
-	while ((c = getopt_long(argc, argv, "d:fghs:t:", longopts, NULL)) != EOF) {
+	while ((c = getopt_long(argc, argv, shortopts, longopts, NULL)) != EOF) {
 		switch (c) {
 		case 'd':
 			xlog_sconfig(optarg, 1);
 			break;
+		case 'l':
+			xlog_sconfig("auth", 1);
+			break;
 		case 'f':
 			foreground++;
 			break;
diff --git a/utils/exportd/exportd.man b/utils/exportd/exportd.man
index 0dbf0c80466a..9435e98703e1 100644
--- a/utils/exportd/exportd.man
+++ b/utils/exportd/exportd.man
@@ -32,6 +32,23 @@ to respond to each request.
 .B \-d kind " or " \-\-debug kind
 Turn on debugging. Valid kinds are: all, auth, call, general and parse.
 .TP
+.BR \-l " or " \-\-log\-auth
+Enable logging of responses to authentication and access requests from
+nfsd.  Each response is then cached by the kernel for 30 minutes, and
+will be refreshed after 15 minutes if the relevant client remains
+active.
+Note that
+.B -l
+is equivalent to
+.B "-d auth"
+and so can be enabled in
+.B /etc/nfs.conf
+with
+.B "\[dq]debug = auth\[dq]"
+in the
+.B "[exportd]"
+section.
+.TP
 .B \-F " or " \-\-foreground
 Run in foreground (do not daemonize)
 .TP
diff --git a/utils/mountd/mountd.c b/utils/mountd/mountd.c
index 612063ba2340..9fecf2f04c3b 100644
--- a/utils/mountd/mountd.c
+++ b/utils/mountd/mountd.c
@@ -74,8 +74,10 @@ static struct option longopts[] =
 	{ "reverse-lookup", 0, 0, 'r' },
 	{ "manage-gids", 0, 0, 'g' },
 	{ "no-udp", 0, 0, 'u' },
+	{ "log-auth", 0, 0, 'l'},
 	{ NULL, 0, 0, 0 }
 };
+static char shortopts[] = "o:nFd:p:P:hH:N:V:vurs:t:gl";
 
 #define NFSVERSBIT(vers)	(0x1 << (vers - 1))
 #define NFSVERSBIT_ALL		(NFSVERSBIT(2) | NFSVERSBIT(3) | NFSVERSBIT(4))
@@ -727,7 +729,7 @@ main(int argc, char **argv)
 
 	/* Parse the command line options and arguments. */
 	opterr = 0;
-	while ((c = getopt_long(argc, argv, "o:nFd:p:P:hH:N:V:vurs:t:g", longopts, NULL)) != EOF)
+	while ((c = getopt_long(argc, argv, shortopts, longopts, NULL)) != EOF)
 		switch (c) {
 		case 'g':
 			manage_gids = 1;
@@ -798,6 +800,9 @@ main(int argc, char **argv)
 		case 'u':
 			NFSCTL_UDPUNSET(_rpcprotobits);
 			break;
+		case 'l':
+			xlog_sconfig("auth", 1);
+			break;
 		case 0:
 			break;
 		case '?':
@@ -913,6 +918,7 @@ usage(const char *prog, int n)
 {
 	fprintf(stderr,
 "Usage: %s [-F|--foreground] [-h|--help] [-v|--version] [-d kind|--debug kind]\n"
+"	[-l|--log-auth]\n"
 "	[-o num|--descriptors num]\n"
 "	[-p|--port port] [-V version|--nfs-version version]\n"
 "	[-N version|--no-nfs-version version] [-n|--no-tcp]\n"
diff --git a/utils/mountd/mountd.man b/utils/mountd/mountd.man
index 2e191074c65f..f6d6fdddda95 100644
--- a/utils/mountd/mountd.man
+++ b/utils/mountd/mountd.man
@@ -91,6 +91,27 @@ is not updated to reflect any NFSv4 activity.
 .B \-d kind " or " \-\-debug kind
 Turn on debugging. Valid kinds are: all, auth, call, general and parse.
 .TP
+.BR \-l " or " \-\-log\-auth
+Enable logging of responses to authentication and access requests from
+nfsd.  Each response is then cached by the kernel for 30 minutes, and
+will be refreshed after 15 minutes if the relevant client remains
+active.
+Note that
+.B -l
+is equivalent to
+.B "-d auth"
+and so can be enabled in
+.B /etc/nfs.conf
+with
+.B "\[dq]debug = auth\[dq]"
+in the
+.B "[mountd]"
+section.
+.IP
+.B rpc.mountd
+will always log authentication responses to MOUNT requests when NFSv3 is
+used, but to get similar logs for NFSv4, this option is required.
+.TP
 .B \-F " or " \-\-foreground
 Run in foreground (do not daemonize)
 .TP


