Return-Path: <linux-nfs+bounces-20216-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2B05DWAhuGmdZQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20216-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:27:28 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C922029C529
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF671305BAB8
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA573A2571;
	Mon, 16 Mar 2026 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OirX2h60"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199EC3A3816
	for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674232; cv=none; b=Yu3sh1kLFjF8IHQNd4eqiY/a+Sli2rc8/Mgmxa4CwFla5y3FmFN3ncUIfZeyK+xhxLMOLdUI46UkopjV/2r4dKM5DQtRqqpEw3pnSGs/iPZTK/5b8ShAi8agwX1+kRh6T8XHiAlnLZJ4e42Gb/wBNaPK4KLpN+Jy5S5Xc8dfZ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674232; c=relaxed/simple;
	bh=c0wTAeigXa0cicK7m+WEkjgYJJqcTEdXlSUEAebMHXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o0H8/BHEYUULRD91ShbPJtSpVxBFV++A7dOyaO8JInjG+b3dJaHO+LEoju2/rVBGtjwgY8iX7u+vk6u/Yby7NqVUSQrq+0sevAolK1z6Vq4rVabNyIagUJ+Z5RB7pdSnyeGoIzeNVR6eRsAdINo1ILKGkQyMqAsY8oE696rw4LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OirX2h60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11772C2BC9E;
	Mon, 16 Mar 2026 15:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674231;
	bh=c0wTAeigXa0cicK7m+WEkjgYJJqcTEdXlSUEAebMHXo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OirX2h60IvwpwyROTRUzJ7pScPsRDzy4D5Xm2hFUCiwd5JkHnLAuvWa53enE67mUn
	 lAmG/owE2CZqOWjX26IBKtD6m/taNvliCFbUUDtM4C48+I96FXYDjT4ibsHK0nbm1h
	 IFHK241Yt1YJgdH7r7FvidSVxaQ4N4JvNDZ8+nwCw6uGKBNFkWLUMXH5eaqsweYz+u
	 G1nR/K8+zhzlMT8y0RFWvWqlXkccjuPVjIYv/cxJW5V9NoC8lPohWeslI6vnbiI3xq
	 E1NF/kJbcJrldeS4XpgT+4jzFwHHTu7QkQnZvD3/0MNzIf6PaBMjmBAniXHyh+/yg/
	 sggO/pd6UPB0Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 11:16:55 -0400
Subject: [PATCH nfs-utils 17/17] mountd/exportd/exportfs: add --no-netlink
 option to disable netlink
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-exportd-netlink-v1-17-9a408a0b389d@kernel.org>
References: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
In-Reply-To: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11992; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=c0wTAeigXa0cicK7m+WEkjgYJJqcTEdXlSUEAebMHXo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB7jKsN7PnaCN/aL62Rrzfueaz4cJhd0i2OvE
 Hj2d7AWuyeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabge4wAKCRAADmhBGVaC
 FV22D/0Xy/xxnm2+FXFVKz4xkV7IoXZrDew65ZB/hKoAbDOJCMwnXiQsPxImSJUu/0yg0Jj7l3S
 arGQ6Y4utkjWmxPb9Xje1nurMUvqpVfd1bldOkU2qPe5Uib7tPc+gwSpP6SnJe0Uf4C295mlEUV
 hwrr12Yxlze+Pf8DVemSdgYf79qukt1ZZedORtotZtwfA2gapNk9m8blpgIp5LYxUWNJJha/ZlQ
 Es0HX/MlHi5IkEo3U9dKNgV5Ykl2x40IznmKbHWIzDVlbIZZSijTXVcwcBRsYKTudD8N3QgRRJ+
 XknOSGg+PEwyvnFqYT4eUE8WuGu/399gqIO8Il1cwb/gQ9/wbMRP0vjQHKNVedogPvDMaN9A1Lp
 gVUcgtaLs4tsFqIC5XvAwvgoLZFJtpMR2Ol2UJuSGidEsNY6/CKWXiYCTMMQeuE48wlUB0yjin8
 MTJznGXn0UPqa56kaseOpayCvf1VVSvzdsf/+6CZsnRpAGbOs2oZkPS2Cy74WOaVfzmZCabr98i
 qI2lnqEgVtgBSmuW8KkHjyWx2zRY7Ix0GkfYWxAeME2QS6+3Q6osx/jzlfbUPFujyQcLSJmb7jV
 vyivpCv6d6AO2i6m8HG1TGDbOQATSnsQWOmDgser7sNt4urMNBcueKv1KG12h2p2N/juM7NqFv5
 W9naJZGbaKmIUWQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20216-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C922029C529
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a --no-netlink command-line option (short: -L) and no-netlink=
config file setting that disables netlink support, forcing the use of
/proc interfaces instead.

For mountd and exportd, the setting lives in their respective [mountd]
and [exportd] sections of nfs.conf. For exportfs, it's in the
[exportfs] section.

This is useful for debugging, testing the /proc fallback path, or
working around kernel netlink issues.
---
 support/export/cache.c       |  3 ++-
 support/export/cache_flush.c |  4 ++-
 utils/exportd/exportd.c      | 10 ++++++--
 utils/exportd/exportd.man    | 12 +++++++--
 utils/exportfs/exportfs.c    | 13 +++++++++-
 utils/exportfs/exportfs.man  | 58 ++++++++++++++++++++++++++++++++++++++------
 utils/mountd/mountd.c        |  9 ++++++-
 utils/mountd/mountd.man      |  9 +++++++
 8 files changed, 102 insertions(+), 16 deletions(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index 5a2c5760cb5410845971ba831a9ae779d17a6d87..2f128d7db7bd63d86530f0c4003af58327db2c70 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -111,6 +111,7 @@ static bool path_lookup_error(int err)
 
 extern int use_ipaddr;
 extern int manage_gids;
+extern int no_netlink;
 
 static void auth_unix_ip(int f)
 {
@@ -3064,7 +3065,7 @@ void cache_open(void)
 {
 	int i;
 
-	if (cache_nfsd_nl_open() == 0) {
+	if (!no_netlink && cache_nfsd_nl_open() == 0) {
 		if (cache_sunrpc_nl_open() == 0) {
 			/*
 			 * Check for pending requests, in case any
diff --git a/support/export/cache_flush.c b/support/export/cache_flush.c
index 7d7f12b212967e5b3d1a2357de07bc3ba5f0b674..ed7b964f9d5372f4accba21254ee9c5f40ffd44d 100644
--- a/support/export/cache_flush.c
+++ b/support/export/cache_flush.c
@@ -20,6 +20,8 @@
 #include "nfslib.h"
 #include "xlog.h"
 
+extern int no_netlink;
+
 #include <netlink/genl/genl.h>
 #include <netlink/genl/ctrl.h>
 #include <netlink/msg.h>
@@ -155,7 +157,7 @@ static void cache_proc_flush(void)
 void
 cache_flush(void)
 {
-	if (cache_nl_flush() == 0) {
+	if (!no_netlink && cache_nl_flush() == 0) {
 		xlog(D_NETLINK, "cache flush via netlink succeeded");
 		return;
 	}
diff --git a/utils/exportd/exportd.c b/utils/exportd/exportd.c
index a2e370ac506f56d0feab306bd252c32ef58ba009..a08aaaccbc2f2ec8504c53bbf07daf1ac2be0c32 100644
--- a/utils/exportd/exportd.c
+++ b/utils/exportd/exportd.c
@@ -32,6 +32,7 @@ static int num_threads = 1;
 #define MAX_THREADS 64
 
 int manage_gids;
+int no_netlink;
 int use_ipaddr = -1;
 
 static struct option longopts[] =
@@ -40,13 +41,14 @@ static struct option longopts[] =
 	{ "debug", 1, 0, 'd' },
 	{ "help", 0, 0, 'h' },
 	{ "manage-gids", 0, 0, 'g' },
+	{ "no-netlink", 0, 0, 'L' },
 	{ "num-threads", 1, 0, 't' },
 	{ "log-auth", 0, 0, 'l' },
 	{ "cache-use-ipaddr", 0, 0, 'i' },
 	{ "ttl", 0, 0, 'T' },
 	{ NULL, 0, 0, 0 }
 };
-static char shortopts[] = "d:fghs:t:liT:";
+static char shortopts[] = "d:fghs:t:liLT:";
 
 /*
  * Signal handlers.
@@ -109,7 +111,7 @@ usage(const char *prog, int n)
 		"Usage: %s [-f|--foreground] [-h|--help] [-d kind|--debug kind]\n"
 "	[-g|--manage-gids] [-l|--log-auth] [-i|--cache-use-ipaddr] [-T|--ttl ttl]\n"
 "	[-s|--state-directory-path path]\n"
-"	[-t num|--num-threads=num]\n", prog);
+"	[-t num|--num-threads=num] [-L|--no-netlink]\n", prog);
 	exit(n);
 }
 
@@ -124,6 +126,7 @@ read_exportd_conf(char *progname, char **argv)
 	xlog_set_debug(progname);
 
 	manage_gids = conf_get_bool("exportd", "manage-gids", manage_gids);
+	no_netlink = conf_get_bool("exportd", "no-netlink", no_netlink);
 	num_threads = conf_get_num("exportd", "threads", num_threads);
 	if (conf_get_bool("mountd", "cache-use-ipaddr", 0))
 		use_ipaddr = 2;
@@ -171,6 +174,9 @@ main(int argc, char **argv)
 		case 'g':
 			manage_gids = 1;
 			break;
+		case 'L':
+			no_netlink = 1;
+			break;
 		case 'h':
 			usage(progname, 0);
 			break;
diff --git a/utils/exportd/exportd.man b/utils/exportd/exportd.man
index fae434b5f03bfb5a252f1e5c6d7fc8fc2a3f5567..d024868c6471c60f6804f427317a2627cbddb0af 100644
--- a/utils/exportd/exportd.man
+++ b/utils/exportd/exportd.man
@@ -106,6 +106,13 @@ the server. Note that the 'primary' group id is not affected so a
 .B newgroup
 command on the client will still be effective.  This function requires
 a Linux Kernel with version at least 2.6.21.
+.TP
+.B \-L " or " \-\-no-netlink
+Disable the use of netlink for kernel communication and force the use
+of the legacy
+.I /proc/net/rpc
+interfaces instead.  This can be useful for debugging or working around
+kernel netlink issues.
 .SH CONFIGURATION FILE
 Many of the options that can be set on the command line can also be
 controlled through values set in the
@@ -120,8 +127,9 @@ Values recognized in the
 section include 
 .B cache\-use\-ipaddr ,
 .BR ttl ,
-.BR manage-gids ", and"
-.B debug 
+.BR manage-gids ,
+.BR no\-netlink ", and"
+.B debug
 which each have the same effect as the option with the same name.
 .SH FILES
 .TP 2.5i
diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index 04753fa169f97c6b07893613197739ff36e0d09b..9eedb750e316a2ef42bb541d4df4925deeee4874 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -49,6 +49,8 @@
 #include "sunrpc_netlink.h"
 #endif
 
+int no_netlink;
+
 static void	export_all(int verbose);
 static void	exportfs(char *arg, char *options, int verbose);
 static void	unexportfs(char *arg, int verbose);
@@ -109,8 +111,11 @@ read_exportfs_conf(char **argv)
 	xlog_set_debug("exportfs");
 
 	/* NOTE: following uses "mountd" section of nfs.conf !!!! */
+	no_netlink = conf_get_bool("mountd", "no-netlink", no_netlink);
 	s = conf_get_str("mountd", "state-directory-path");
 	/* Also look in the exportd section */
+	if (!no_netlink)
+		no_netlink = conf_get_bool("exportd", "no-netlink", no_netlink);
 	if (s == NULL)
 		s = conf_get_str("exportd", "state-directory-path");
 	if (s && !state_setup_basedir(argv[0], s))
@@ -145,7 +150,7 @@ main(int argc, char **argv)
 
 	nfsd_path_init();
 
-	while ((c = getopt(argc, argv, "ad:fhio:ruvs")) != EOF) {
+	while ((c = getopt(argc, argv, "ad:fhiLo:ruvs")) != EOF) {
 		switch(c) {
 		case 'a':
 			f_all = 1;
@@ -162,6 +167,9 @@ main(int argc, char **argv)
 		case 'i':
 			f_ignore = 1;
 			break;
+		case 'L':
+			no_netlink = 1;
+			break;
 		case 'o':
 			options = optarg;
 			break;
@@ -500,6 +508,8 @@ static int can_test(void)
 	size_t bufsiz = sizeof(buf);
 
 	/* Try netlink first: resolve sunrpc genl family */
+	if (no_netlink)
+		goto try_proc;
 	sock = nl_socket_alloc();
 	if (sock) {
 		if (genl_connect(sock) == 0) {
@@ -513,6 +523,7 @@ static int can_test(void)
 	}
 
 	/* Fallback: /proc probe */
+try_proc:
 	fd = open("/proc/net/rpc/auth.unix.ip/channel", O_WRONLY);
 	if (fd < 0)
 		return 0;
diff --git a/utils/exportfs/exportfs.man b/utils/exportfs/exportfs.man
index af0e5571cef83d4f3de6915608b4871690a8853a..3737ee81ab275aa65e942ec1602f33a7abbfc80e 100644
--- a/utils/exportfs/exportfs.man
+++ b/utils/exportfs/exportfs.man
@@ -53,14 +53,41 @@ by using the
 command.
 .PP
 .B exportfs
-does not give any information to the kernel directly, but provides it
-only to
-.B rpc.mountd
-through the
+does not communicate with the kernel directly.
+It writes export information to
 .I /var/lib/nfs/etab
-file.
+and relies on its partner programs
+.B rpc.mountd
+and
+.B nfsv4.exportd
+to manage kernel communication.
+These daemons work in one of two modes: a netlink mode and a
+.I /proc
+mode.
+.PP
+In the netlink mode, available on sufficiently recent kernels,
 .B rpc.mountd
-then manages kernel requests for information about exports, as needed.
+(or
+.BR nfsv4.exportd )
+communicates with the kernel via generic netlink sockets.
+The kernel sends multicast notifications when cache entries need to be
+resolved, and the daemon responds with the appropriate export
+information.
+Cache flushing (via
+.BR "exportfs \-f" )
+is also performed over netlink.
+This mode can be disabled with the
+.B \-L
+option.
+.PP
+In the
+.I /proc
+mode, used when netlink is unavailable,
+.B rpc.mountd
+manages kernel requests for information about exports
+via the
+.I /proc/net/rpc
+channel files.
 .SH OPTIONS
 .TP
 .B \-d kind " or " \-\-debug kind
@@ -123,6 +150,12 @@ options.
 .TP
 .B -s
 Display the current export list suitable for /etc/exports.
+.TP
+.B -L
+Disable the use of netlink for kernel communication and force the use
+of the legacy
+.I /proc
+interfaces for cache flushing and export validation.
 
 .SH CONFIGURATION FILE
 The
@@ -142,11 +175,20 @@ When a list is given, the members should be comma-separated.
 .B exportfs
 will also recognize the
 .B state-directory-path
-value from both the 
+and
+.B no\-netlink
+values from both the
 .B [mountd]
 section and the
 .B [exportd]
-section
+section.
+When
+.B no\-netlink
+is set,
+.B exportfs
+will skip the netlink probe and use the legacy
+.I /proc
+interfaces for cache flushing and export validation
 
 .SH DISCUSSION
 .SS Exporting Directories
diff --git a/utils/mountd/mountd.c b/utils/mountd/mountd.c
index 6e6777cd1daa0227f3ff81f826c1cbc8627b4a8a..92d8c4690efc48fcfa12d9618cac9172c4752f4f 100644
--- a/utils/mountd/mountd.c
+++ b/utils/mountd/mountd.c
@@ -41,6 +41,7 @@ static struct nfs_fh_len *get_rootfh(struct svc_req *, dirpath *, nfs_export **,
 
 int reverse_resolve = 0;
 int manage_gids;
+int no_netlink;
 int apply_root_cred;
 int use_ipaddr = -1;
 
@@ -72,6 +73,7 @@ static struct option longopts[] =
 	{ "num-threads", 1, 0, 't' },
 	{ "reverse-lookup", 0, 0, 'r' },
 	{ "manage-gids", 0, 0, 'g' },
+	{ "no-netlink", 0, 0, 'L' },
 	{ "no-udp", 0, 0, 'u' },
 	{ "log-auth", 0, 0, 'l'},
 	{ "cache-use-ipaddr", 0, 0, 'i'},
@@ -667,6 +669,7 @@ read_mountd_conf(char **argv)
 
 	xlog_set_debug("mountd");
 	manage_gids = conf_get_bool("mountd", "manage-gids", manage_gids);
+	no_netlink = conf_get_bool("mountd", "no-netlink", no_netlink);
 	descriptors = conf_get_num("mountd", "descriptors", descriptors);
 	port = conf_get_num("mountd", "port", port);
 	num_threads = conf_get_num("mountd", "threads", num_threads);
@@ -734,6 +737,9 @@ main(int argc, char **argv)
 		case 'g':
 			manage_gids = 1;
 			break;
+		case 'L':
+			no_netlink = 1;
+			break;
 		case 'o':
 			descriptors = atoi(optarg);
 			if (descriptors <= 0) {
@@ -951,6 +957,7 @@ usage(const char *prog, int n)
 "	[-N version|--no-nfs-version version] [-n|--no-tcp]\n"
 "	[-H prog |--ha-callout prog] [-r |--reverse-lookup]\n"
 "	[-s|--state-directory-path path] [-g|--manage-gids]\n"
-"	[-t num|--num-threads=num] [-u|--no-udp]\n", prog);
+"	[-t num|--num-threads=num] [-u|--no-udp]\n"
+"	[-L|--no-netlink]\n", prog);
 	exit(n);
 }
diff --git a/utils/mountd/mountd.man b/utils/mountd/mountd.man
index 2fa396c3288f37b1afa247b54a6166ca4f1b5e06..8bec38db131d9f70d1e04a000133023cca955fe1 100644
--- a/utils/mountd/mountd.man
+++ b/utils/mountd/mountd.man
@@ -284,6 +284,14 @@ the server. Note that the 'primary' group id is not affected so a
 command on the client will still be effective.  This function requires
 a Linux Kernel with version at least 2.6.21.
 
+.TP
+.B \-L " or " \-\-no-netlink
+Disable the use of netlink for kernel communication and force the use
+of the legacy
+.I /proc/net/rpc
+interfaces instead.  This can be useful for debugging or working around
+kernel netlink issues.
+
 .SH CONFIGURATION FILE
 Many of the options that can be set on the command line can also be
 controlled through values set in the
@@ -297,6 +305,7 @@ Values recognized in the
 .B [mountd]
 section include
 .BR manage-gids ,
+.BR no\-netlink ,
 .BR cache\-use\-ipaddr ,
 .BR descriptors ,
 .BR port ,

-- 
2.53.0


