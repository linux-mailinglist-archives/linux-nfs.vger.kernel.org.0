Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C345327613
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 03:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhCACTG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Feb 2021 21:19:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:58540 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231802AbhCACTE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 28 Feb 2021 21:19:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6C0FEAF84;
        Mon,  1 Mar 2021 02:18:00 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <SteveD@RedHat.com>
Date:   Mon, 01 Mar 2021 13:17:15 +1100
Subject: [PATCH 5/5] mountd: make default ttl settable by option
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Message-ID: <161456503510.22801.14509641806602250672.stgit@noble>
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

The DEFAULT_TTL affects the rate at which authentication messages are
logged.  So it is useful to make it settable.

Add "-ttl" and "-T", and add clear statement in the documentation of
both the benefits and the possible negative effects of choosing a larger
value

Signed-off-by: NeilBrown <neil@brown.name>
---
 support/export/cache.c     |    6 +++---
 support/export/v4root.c    |    3 ++-
 support/include/exportfs.h |    3 ++-
 support/nfs/exports.c      |    4 +++-
 utils/mountd/mountd.c      |   20 ++++++++++++++++++--
 utils/mountd/mountd.man    |   19 ++++++++++++++++---
 6 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index 50f7c7a15ceb..c0848c3e437b 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -157,7 +157,7 @@ static void auth_unix_ip(int f)
 	bp = buf; blen = sizeof(buf);
 	qword_add(&bp, &blen, "nfsd");
 	qword_add(&bp, &blen, ipaddr);
-	qword_adduint(&bp, &blen, time(0) + DEFAULT_TTL);
+	qword_adduint(&bp, &blen, time(0) + default_ttl);
 	if (use_ipaddr && client) {
 		memmove(ipaddr + 1, ipaddr, strlen(ipaddr) + 1);
 		ipaddr[0] = '$';
@@ -230,7 +230,7 @@ static void auth_unix_gid(int f)
 
 	bp = buf; blen = sizeof(buf);
 	qword_adduint(&bp, &blen, uid);
-	qword_adduint(&bp, &blen, time(0) + DEFAULT_TTL);
+	qword_adduint(&bp, &blen, time(0) + default_ttl);
 	if (rv >= 0) {
 		qword_adduint(&bp, &blen, ngroups);
 		for (i=0; i<ngroups; i++)
@@ -968,7 +968,7 @@ static int dump_to_cache(int f, char *buf, int blen, char *domain,
 	ssize_t err;
 
 	if (ttl <= 1)
-		ttl = DEFAULT_TTL;
+		ttl = default_ttl;
 
 	qword_add(&bp, &blen, domain);
 	qword_add(&bp, &blen, path);
diff --git a/support/export/v4root.c b/support/export/v4root.c
index 6f640aa9aa3f..3654bd7c10c0 100644
--- a/support/export/v4root.c
+++ b/support/export/v4root.c
@@ -45,7 +45,7 @@ static nfs_export pseudo_root = {
 		.e_nsqgids = 0,
 		.e_fsid = 0,
 		.e_mountpoint = NULL,
-		.e_ttl = DEFAULT_TTL,
+		.e_ttl = 0,
 	},
 	.m_exported = 0,
 	.m_xtabent = 1,
@@ -84,6 +84,7 @@ v4root_create(char *path, nfs_export *export)
 	struct exportent *curexp = &export->m_export;
 
 	dupexportent(&eep, &pseudo_root.m_export);
+	eep.e_ttl = default_ttl;
 	eep.e_hostname = curexp->e_hostname;
 	strncpy(eep.e_path, path, sizeof(eep.e_path)-1);
 	if (strcmp(path, "/") != 0)
diff --git a/support/include/exportfs.h b/support/include/exportfs.h
index daa7e2a06d82..81d137210862 100644
--- a/support/include/exportfs.h
+++ b/support/include/exportfs.h
@@ -105,7 +105,8 @@ typedef struct mexport {
 } nfs_export;
 
 #define HASH_TABLE_SIZE 1021
-#define DEFAULT_TTL	(30 * 60)
+
+extern int default_ttl;
 
 typedef struct _exp_hash_entry {
 	nfs_export * p_first;
diff --git a/support/nfs/exports.c b/support/nfs/exports.c
index 037febd08d9b..2c8f0752ad9d 100644
--- a/support/nfs/exports.c
+++ b/support/nfs/exports.c
@@ -47,6 +47,8 @@ struct flav_info flav_map[] = {
 
 const int flav_map_size = sizeof(flav_map)/sizeof(flav_map[0]);
 
+int default_ttl = 30 * 60;
+
 static char	*efname = NULL;
 static XFILE	*efp = NULL;
 static int	first;
@@ -100,7 +102,7 @@ static void init_exportent (struct exportent *ee, int fromkernel)
 	ee->e_nsquids = 0;
 	ee->e_nsqgids = 0;
 	ee->e_uuid = NULL;
-	ee->e_ttl = DEFAULT_TTL;
+	ee->e_ttl = default_ttl;
 }
 
 struct exportent *
diff --git a/utils/mountd/mountd.c b/utils/mountd/mountd.c
index b9260aeb86a3..fce389661e7a 100644
--- a/utils/mountd/mountd.c
+++ b/utils/mountd/mountd.c
@@ -76,9 +76,10 @@ static struct option longopts[] =
 	{ "no-udp", 0, 0, 'u' },
 	{ "log-auth", 0, 0, 'l'},
 	{ "cache-use-ipaddr", 0, 0, 'i'},
+	{ "ttl", 1, 0, 'T'},
 	{ NULL, 0, 0, 0 }
 };
-static char shortopts[] = "o:nFd:p:P:hH:N:V:vurs:t:gli";
+static char shortopts[] = "o:nFd:p:P:hH:N:V:vurs:t:gliT:";
 
 #define NFSVERSBIT(vers)	(0x1 << (vers - 1))
 #define NFSVERSBIT_ALL		(NFSVERSBIT(2) | NFSVERSBIT(3) | NFSVERSBIT(4))
@@ -672,6 +673,7 @@ inline static void
 read_mountd_conf(char **argv)
 {
 	char	*s;
+	int	ttl;
 
 	conf_init_file(NFS_CONFFILE);
 
@@ -706,6 +708,10 @@ read_mountd_conf(char **argv)
 		else
 			NFSCTL_VERUNSET(nfs_version, vers);
 	}
+
+	ttl = conf_get_num("mountd", "ttl", default_ttl);
+	if (ttl > 0)
+		default_ttl = ttl;
 }
 
 int
@@ -715,6 +721,7 @@ main(int argc, char **argv)
 	unsigned int listeners = 0;
 	int	foreground = 0;
 	int	c;
+	int	ttl;
 	struct sigaction sa;
 	struct rlimit rlim;
 
@@ -809,6 +816,15 @@ main(int argc, char **argv)
 		case 'i':
 			use_ipaddr = 2;
 			break;
+		case 'T':
+			ttl = atoi(optarg);
+			if (ttl <= 0) {
+				fprintf(stderr, "%s: bad ttl number of seconds: %s\n",
+					argv[0], optarg);
+				usage(argv[0], 1);
+			}
+			default_ttl = ttl;
+			break;
 		case 0:
 			break;
 		case '?':
@@ -924,7 +940,7 @@ usage(const char *prog, int n)
 {
 	fprintf(stderr,
 "Usage: %s [-F|--foreground] [-h|--help] [-v|--version] [-d kind|--debug kind]\n"
-"	[-l|--log-auth] [-i|--cache-use-ipaddr]\n"
+"	[-l|--log-auth] [-i|--cache-use-ipaddr] [-T|--ttl ttl]\n"
 "	[-o num|--descriptors num]\n"
 "	[-p|--port port] [-V version|--nfs-version version]\n"
 "	[-N version|--no-nfs-version version] [-n|--no-tcp]\n"
diff --git a/utils/mountd/mountd.man b/utils/mountd/mountd.man
index 44d237e56110..82e07cf221fa 100644
--- a/utils/mountd/mountd.man
+++ b/utils/mountd/mountd.man
@@ -99,9 +99,10 @@ Turn on debugging. Valid kinds are: all, auth, call, general and parse.
 .TP
 .BR \-l " or " \-\-log\-auth
 Enable logging of responses to authentication and access requests from
-nfsd.  Each response is then cached by the kernel for 30 minutes, and
-will be refreshed after 15 minutes if the relevant client remains
-active.
+nfsd.  Each response is then cached by the kernel for 30 minutes (or as set by
+.B \-\-ttl
+below), and will be refreshed after 15 minutes (half the ttl time) if
+the relevant client remains active.
 Note that
 .B -l
 is equivalent to
@@ -135,6 +136,17 @@ log messages produced by the
 .B -l
 option easier to read.
 .TP
+.B \-T " or " \-\-ttl
+Provide a time-to-live (TTL) for cached information given to the kernel.
+The kernel will normally request an update if the information is needed
+after half of this time has expired.  Increasing the provided number,
+which is in seconds, reduces the rate of cache update requests, and this
+is particularly noticeable when these requests are logged with
+.BR \-l .
+However increasing also means that changes to hostname to address
+mappings can take longer to be noticed.
+The default TTL is 1800 (30 minutes).
+.TP
 .B \-F " or " \-\-foreground
 Run in foreground (do not daemonize)
 .TP
@@ -269,6 +281,7 @@ section include
 .BR descriptors ,
 .BR port ,
 .BR threads ,
+.BR ttl ,
 .BR reverse-lookup ", and"
 .BR state-directory-path ,
 .B ha-callout


