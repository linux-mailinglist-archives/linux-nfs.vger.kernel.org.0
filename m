Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF3732DE6F
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Mar 2021 01:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhCEAow (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Mar 2021 19:44:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:39592 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230408AbhCEAow (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 4 Mar 2021 19:44:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 25B07AD29;
        Fri,  5 Mar 2021 00:44:51 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <SteveD@RedHat.com>
Date:   Fri, 05 Mar 2021 11:43:24 +1100
Subject: [PATCH 5/7] mountd: add --cache-use-ipaddr option to force use_ipaddr
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Message-ID: <161490500400.15291.3579997095787553405.stgit@noble>
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

When logging authentication requests, it can be easier to read the logs
if clients are always identified by IP address, not intermediate names
like netgroups or subnets.

To allow this, add --cache-use-ipaddr or -i which tell mountd to always
enable use_ipaddr.

Signed-off-by: NeilBrown <neil@brown.name>
---
 nfs.conf                  |    2 ++
 support/export/auth.c     |    4 ++++
 systemd/nfs.conf.man      |    2 ++
 utils/exportd/exportd.c   |   16 +++++++++++-----
 utils/exportd/exportd.man |   18 ++++++++++++++++++
 utils/mountd/mountd.c     |   10 ++++++++--
 utils/mountd/mountd.man   |   18 ++++++++++++++++++
 7 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/nfs.conf b/nfs.conf
index e69ec16d9c19..0c32eed1a5be 100644
--- a/nfs.conf
+++ b/nfs.conf
@@ -34,6 +34,7 @@
 # manage-gids=n
 # state-directory-path=/var/lib/nfs
 # threads=1
+# cache-use-ipaddr=n
 [mountd]
 # debug="all|auth|call|general|parse"
 # manage-gids=n
@@ -43,6 +44,7 @@
 # reverse-lookup=n
 # state-directory-path=/var/lib/nfs
 # ha-callout=
+# cache-use-ipaddr=n
 #
 [nfsdcld]
 # debug=0
diff --git a/support/export/auth.c b/support/export/auth.c
index 0bfa77d18469..cea376300d01 100644
--- a/support/export/auth.c
+++ b/support/export/auth.c
@@ -66,6 +66,10 @@ check_useipaddr(void)
 	int old_use_ipaddr = use_ipaddr;
 	unsigned int len = 0;
 
+	if (use_ipaddr > 1)
+		/* fixed - don't check */
+		return;
+
 	/* add length of m_hostname + 1 for the comma */
 	for (clp = clientlist[MCL_NETGROUP]; clp; clp = clp->m_next)
 		len += (strlen(clp->m_hostname) + 1);
diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
index 8a02e154b1a2..8af4445d49c9 100644
--- a/systemd/nfs.conf.man
+++ b/systemd/nfs.conf.man
@@ -132,6 +132,7 @@ but on the server, this will resolve to the path
 .B exportd
 Recognized values:
 .BR threads ,
+.BR cache-use-upaddr ,
 .BR state-directory-path
 
 See
@@ -196,6 +197,7 @@ Recognized values:
 .BR port ,
 .BR threads ,
 .BR reverse-lookup ,
+.BR cache-use-upaddr ,
 .BR state-directory-path ,
 .BR ha-callout .
 
diff --git a/utils/exportd/exportd.c b/utils/exportd/exportd.c
index 8ea2f160773e..f2f209028284 100644
--- a/utils/exportd/exportd.c
+++ b/utils/exportd/exportd.c
@@ -45,9 +45,10 @@ static struct option longopts[] =
 	{ "manage-gids", 0, 0, 'g' },
 	{ "num-threads", 1, 0, 't' },
 	{ "log-auth", 0, 0, 'l' },
+	{ "cache-use-ipaddr", 0, 0, 'i'},
 	{ NULL, 0, 0, 0 }
 };
-static char shortopts[] = "d:fghs:t:l"
+static char shortopts[] = "d:fghs:t:li"
 
 /*
  * Signal handlers.
@@ -177,13 +178,13 @@ usage(const char *prog, int n)
 {
 	fprintf(stderr,
 		"Usage: %s [-f|--foreground] [-h|--help] [-d kind|--debug kind]\n"
-"	[-g|--manage-gids] [-l|--log-auth]\n"
+"	[-g|--manage-gids] [-l|--log-auth] [-i|--cache-use-ipaddr]\n"
 "	[-s|--state-directory-path path]\n"
 "	[-t num|--num-threads=num]\n", prog);
 	exit(n);
 }
 
-inline static void 
+inline static void
 read_exportd_conf(char *progname, char **argv)
 {
 	char *s;
@@ -194,6 +195,8 @@ read_exportd_conf(char *progname, char **argv)
 
 	manage_gids = conf_get_bool("exportd", "manage-gids", manage_gids);
 	num_threads = conf_get_num("exportd", "threads", num_threads);
+	if (conf_get_bool("mountd", "cache-use-ipaddr", 0))
+		use_ipaddr = 2;
 
 	s = conf_get_str("exportd", "state-directory-path");
 	if (s && !state_setup_basedir(argv[0], s))
@@ -236,6 +239,9 @@ main(int argc, char **argv)
 		case 'h':
 			usage(progname, 0);
 			break;
+		case 'i':
+			use_ipaddr = 2;
+			break;
 		case 's':
 			if (!state_setup_basedir(argv[0], optarg))
 				exit(1);
@@ -252,8 +258,8 @@ main(int argc, char **argv)
 
 	if (!setup_state_path_names(progname, ETAB, ETABTMP, ETABLCK, &etab))
 		return 1;
-	
-	if (!foreground) 
+
+	if (!foreground)
 		xlog_stderr(0);
 
 	daemon_init(foreground);
diff --git a/utils/exportd/exportd.man b/utils/exportd/exportd.man
index 9435e98703e1..a4e659f5fa4a 100644
--- a/utils/exportd/exportd.man
+++ b/utils/exportd/exportd.man
@@ -49,6 +49,23 @@ in the
 .B "[exportd]"
 section.
 .TP
+.BR \-i " or " \-\-cache\-use\-ipaddr
+Normally each client IP address is matched against each host identifier
+(name, wildcard, netgroup etc) found in
+.B /etc/exports
+and a combined identity is formed from all matching identifiers.
+Often many clients will map to the same combined identity so performing
+this mapping reduces the number of distinct access details that the
+kernel needs to store.
+Specifying the
+.B \-i
+option suppresses this mapping so that access to each filesystem is
+requested and cached separately for each client IP address.  Doing this
+can increase the burden of updating the cache slightly, but can make the
+log messages produced by the
+.B -l
+option easier to read.
+.TP
 .B \-F " or " \-\-foreground
 Run in foreground (do not daemonize)
 .TP
@@ -89,6 +106,7 @@ configuration file.
 Values recognized in the
 .B [exportd]
 section include 
+.B cache\-use\-ipaddr ,
 .BR manage-gids ", and"
 .B debug 
 which each have the same effect as the option with the same name.
diff --git a/utils/mountd/mountd.c b/utils/mountd/mountd.c
index 9fecf2f04c3b..b9260aeb86a3 100644
--- a/utils/mountd/mountd.c
+++ b/utils/mountd/mountd.c
@@ -75,9 +75,10 @@ static struct option longopts[] =
 	{ "manage-gids", 0, 0, 'g' },
 	{ "no-udp", 0, 0, 'u' },
 	{ "log-auth", 0, 0, 'l'},
+	{ "cache-use-ipaddr", 0, 0, 'i'},
 	{ NULL, 0, 0, 0 }
 };
-static char shortopts[] = "o:nFd:p:P:hH:N:V:vurs:t:gl";
+static char shortopts[] = "o:nFd:p:P:hH:N:V:vurs:t:gli";
 
 #define NFSVERSBIT(vers)	(0x1 << (vers - 1))
 #define NFSVERSBIT_ALL		(NFSVERSBIT(2) | NFSVERSBIT(3) | NFSVERSBIT(4))
@@ -681,6 +682,8 @@ read_mountd_conf(char **argv)
 	num_threads = conf_get_num("mountd", "threads", num_threads);
 	reverse_resolve = conf_get_bool("mountd", "reverse-lookup", reverse_resolve);
 	ha_callout_prog = conf_get_str("mountd", "ha-callout");
+	if (conf_get_bool("mountd", "cache-use-ipaddr", 0))
+		use_ipaddr = 2;
 
 	s = conf_get_str("mountd", "state-directory-path");
 	if (s && !state_setup_basedir(argv[0], s))
@@ -803,6 +806,9 @@ main(int argc, char **argv)
 		case 'l':
 			xlog_sconfig("auth", 1);
 			break;
+		case 'i':
+			use_ipaddr = 2;
+			break;
 		case 0:
 			break;
 		case '?':
@@ -918,7 +924,7 @@ usage(const char *prog, int n)
 {
 	fprintf(stderr,
 "Usage: %s [-F|--foreground] [-h|--help] [-v|--version] [-d kind|--debug kind]\n"
-"	[-l|--log-auth]\n"
+"	[-l|--log-auth] [-i|--cache-use-ipaddr]\n"
 "	[-o num|--descriptors num]\n"
 "	[-p|--port port] [-V version|--nfs-version version]\n"
 "	[-N version|--no-nfs-version version] [-n|--no-tcp]\n"
diff --git a/utils/mountd/mountd.man b/utils/mountd/mountd.man
index f6d6fdddda95..97d4518fa2e6 100644
--- a/utils/mountd/mountd.man
+++ b/utils/mountd/mountd.man
@@ -112,6 +112,23 @@ section.
 will always log authentication responses to MOUNT requests when NFSv3 is
 used, but to get similar logs for NFSv4, this option is required.
 .TP
+.BR \-i " or " \-\-cache\-use\-ipaddr
+Normally each client IP address is matched against each host identifier
+(name, wildcard, netgroup etc) found in
+.B /etc/exports
+and a combined identity is formed from all matching identifiers.
+Often many clients will map to the same combined identity so performing
+this mapping reduces the number of distinct access details that the
+kernel needs to store.
+Specifying the
+.B \-i
+option suppresses this mapping so that access to each filesystem is
+requested and cached separately for each client IP address.  Doing this
+can increase the burden of updating the cache slightly, but can make the
+log messages produced by the
+.B -l
+option easier to read.
+.TP
 .B \-F " or " \-\-foreground
 Run in foreground (do not daemonize)
 .TP
@@ -242,6 +259,7 @@ Values recognized in the
 .B [mountd]
 section include
 .BR manage-gids ,
+.BR cache\-use\-ipaddr ,
 .BR descriptors ,
 .BR port ,
 .BR threads ,


