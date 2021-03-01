Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4DF327611
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 03:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhCACSg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Feb 2021 21:18:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:58494 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231802AbhCACSe (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 28 Feb 2021 21:18:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1DF1FAF7E;
        Mon,  1 Mar 2021 02:17:52 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <SteveD@RedHat.com>
Date:   Mon, 01 Mar 2021 13:17:15 +1100
Subject: [PATCH 3/5] mountd: add logging for authentication results for
 accesses.
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Message-ID: <161456503509.22801.10248959706273331431.stgit@noble>
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

Signed-off-by: NeilBrown <neil@brown.name>
---
 support/export/cache.c  |   18 +++++++++++++++++-
 utils/mountd/mountd.c   |    8 +++++++-
 utils/mountd/mountd.man |   39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 2 deletions(-)

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
index 9978afcdb4cc..df4e5356cb05 100644
--- a/utils/mountd/mountd.man
+++ b/utils/mountd/mountd.man
@@ -13,6 +13,8 @@ The
 .B rpc.mountd
 daemon implements the server side of the NFS MOUNT protocol,
 an NFS side protocol used by NFS version 2 [RFC1094] and NFS version 3 [RFC1813].
+It also responds to requests from the Linux kernel to authenticate
+clients and provides details of access permissions.
 .PP
 An NFS server maintains a table of local physical file systems
 that are accessible to NFS clients.
@@ -78,11 +80,44 @@ A client may continue accessing an export even after invoking UMNT.
 If the client reboots without sending a UMNT request, stale entries
 remain for that client in
 .IR /var/lib/nfs/rmtab .
+.SS Mounting File Systems with NFSv4
+Version 4 (and later) of NFS does not use a separate NFS MOUNT
+protocol.  Instead mounting is performed using regular NFS requests
+handled by the NFS server in the Linux kernel
+.RI ( nfsd ).
+When
+.I nfsd
+needs to confirm if a client has access to a particular filesystem, it
+communicates with
+.B rpc.mountd
+to authenticate the client and to then determine what access that client
+has to a given filesystem.
 .SH OPTIONS
 .TP
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
@@ -295,5 +330,9 @@ table of clients accessing server's exports
 RFC 1094 - "NFS: Network File System Protocol Specification"
 .br
 RFC 1813 - "NFS Version 3 Protocol Specification"
+.br
+RFC 7530 - "Network File System (NFS) Version 4 Protocol"
+.br
+RFC 8881 - "Network File System (NFS) Version 4 Minor Version 1 Protocol"
 .SH AUTHOR
 Olaf Kirch, H. J. Lu, G. Allan Morris III, and a host of others.


