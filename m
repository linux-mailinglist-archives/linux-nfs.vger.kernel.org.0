Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF940327612
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 03:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhCACSi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Feb 2021 21:18:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:58506 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231802AbhCACSh (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 28 Feb 2021 21:18:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 45C0AAF7F;
        Mon,  1 Mar 2021 02:17:56 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <SteveD@RedHat.com>
Date:   Mon, 01 Mar 2021 13:17:15 +1100
Subject: [PATCH 4/5] mountd: add --cache-use-ipaddr option to force use_ipaddr
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Message-ID: <161456503509.22801.5697064120235155947.stgit@noble>
In-Reply-To: <161456493684.22801.323431390819102360.stgit@noble>
References: <161456493684.22801.323431390819102360.stgit@noble>
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
 support/export/auth.c   |    4 ++++
 utils/mountd/mountd.c   |   10 ++++++++--
 utils/mountd/mountd.man |   18 ++++++++++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

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
index df4e5356cb05..44d237e56110 100644
--- a/utils/mountd/mountd.man
+++ b/utils/mountd/mountd.man
@@ -118,6 +118,23 @@ section.
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
@@ -248,6 +265,7 @@ Values recognized in the
 .B [mountd]
 section include
 .BR manage-gids ,
+.BR cache\-use\-ipaddr ,
 .BR descriptors ,
 .BR port ,
 .BR threads ,


