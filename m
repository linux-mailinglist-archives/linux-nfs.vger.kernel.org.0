Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05B64B14D6
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Feb 2022 19:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243363AbiBJSBm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Feb 2022 13:01:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239511AbiBJSBm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Feb 2022 13:01:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81CF6109E
        for <linux-nfs@vger.kernel.org>; Thu, 10 Feb 2022 10:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644516097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AME8S9WYB8mbcemS2tTCVkJSNPZSKtYrlmO1enu8khk=;
        b=etkzsQvH629IJ+5LfL2MQ6VttjSmZYrEkxkPUk52wwcx7HcZx4bVUDlBBmX+9XcZwJzcVk
        8RWcqnh6MGeV3RPRMmlgUr3/9fsDqYO1Oj+bsJfOIR0mIqgv/aB2mYv/cKfd8quJG4HHE2
        Ph6AIImksMISoRfytkvesCN2NLdngNk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-N2IcO3K3NQeZr0dJ-P5q2g-1; Thu, 10 Feb 2022 13:01:35 -0500
X-MC-Unique: N2IcO3K3NQeZr0dJ-P5q2g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6CA0887642
        for <linux-nfs@vger.kernel.org>; Thu, 10 Feb 2022 18:01:11 +0000 (UTC)
Received: from bcodding.csb (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8FA4F7747D;
        Thu, 10 Feb 2022 18:01:11 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 1564110C30F1; Thu, 10 Feb 2022 13:01:11 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/2] nfsuuid: a tool to create and persist nfs4 client uniquifiers
Date:   Thu, 10 Feb 2022 13:01:10 -0500
Message-Id: <9c046648bfd9c8260ec7bd37e0a93f7821e0842f.1644515977.git.bcodding@redhat.com>
In-Reply-To: <cover.1644515977.git.bcodding@redhat.com>
References: <cover.1644515977.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The nfsuuid program will either create a new UUID from a random source or
derive it from /etc/machine-id, else it returns a UUID that has already
been written to /etc/nfsuuid or the file specified.  This small,
lightweight tool is suitable for execution by systemd-udev in rules to
populate the nfs4 client uniquifier.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 .gitignore                |   1 +
 aclocal/libuuid.m4        |  17 ++++
 configure.ac              |   4 +
 tools/Makefile.am         |   1 +
 tools/nfsuuid/Makefile.am |   8 ++
 tools/nfsuuid/nfsuuid.c   | 203 ++++++++++++++++++++++++++++++++++++++
 tools/nfsuuid/nfsuuid.man |  33 +++++++
 7 files changed, 267 insertions(+)
 create mode 100644 aclocal/libuuid.m4
 create mode 100644 tools/nfsuuid/Makefile.am
 create mode 100644 tools/nfsuuid/nfsuuid.c
 create mode 100644 tools/nfsuuid/nfsuuid.man

diff --git a/.gitignore b/.gitignore
index c89d1cd2583d..4d63ee93b2dc 100644
--- a/.gitignore
+++ b/.gitignore
@@ -61,6 +61,7 @@ utils/statd/statd
 tools/locktest/testlk
 tools/getiversion/getiversion
 tools/nfsconf/nfsconf
+tools/nfsuuid/nfsuuid
 support/export/mount.h
 support/export/mount_clnt.c
 support/export/mount_xdr.c
diff --git a/aclocal/libuuid.m4 b/aclocal/libuuid.m4
new file mode 100644
index 000000000000..f64085010d1d
--- /dev/null
+++ b/aclocal/libuuid.m4
@@ -0,0 +1,17 @@
+AC_DEFUN([AC_LIBUUID], [
+        LIBUUID=
+
+        AC_CHECK_LIB([uuid], [uuid_generate_random], [], [AC_MSG_FAILURE(
+                [Missing libuuid uuid_generate_random, needed to build nfs4id])])
+
+        AC_CHECK_LIB([uuid], [uuid_generate_sha1], [], [AC_MSG_FAILURE(
+                [Missing libuuid uuid_generate_sha1, needed to build nfs4id])])
+
+        AC_CHECK_LIB([uuid], [uuid_unparse], [], [AC_MSG_FAILURE(
+                [Missing libuuid uuid_unparse, needed to build nfs4id])])
+
+        AC_CHECK_HEADER([uuid/uuid.h], [], [AC_MSG_FAILURE(
+                [Missing uuid/uuid.h, needed to build nfs4id])])
+
+        AC_SUBST([LIBUUID], ["-luuid"])
+])
diff --git a/configure.ac b/configure.ac
index 50e9b321dcf3..1342c471f142 100644
--- a/configure.ac
+++ b/configure.ac
@@ -355,6 +355,9 @@ if test "$enable_nfsv4" = yes; then
   dnl check for the keyutils libraries and headers
   AC_KEYUTILS
 
+  dnl check for the libuuid library and headers
+  AC_LIBUUID
+
   dnl Check for sqlite3
   AC_SQLITE3_VERS
 
@@ -740,6 +743,7 @@ AC_CONFIG_FILES([
 	tools/nfsdclnts/Makefile
 	tools/nfsconf/Makefile
 	tools/nfsdclddb/Makefile
+	tools/nfsuuid/Makefile
 	utils/Makefile
 	utils/blkmapd/Makefile
 	utils/nfsdcld/Makefile
diff --git a/tools/Makefile.am b/tools/Makefile.am
index 9b4b0803db39..a12b0f34f4e7 100644
--- a/tools/Makefile.am
+++ b/tools/Makefile.am
@@ -7,6 +7,7 @@ OPTDIRS += rpcgen
 endif
 
 OPTDIRS += nfsconf
+OPTDIRS += nfsuuid
 
 if CONFIG_NFSDCLD
 OPTDIRS += nfsdclddb
diff --git a/tools/nfsuuid/Makefile.am b/tools/nfsuuid/Makefile.am
new file mode 100644
index 000000000000..7b3a54c30d50
--- /dev/null
+++ b/tools/nfsuuid/Makefile.am
@@ -0,0 +1,8 @@
+## Process this file with automake to produce Makefile.in
+
+man8_MANS	= nfsuuid.man
+
+bin_PROGRAMS = nfsuuid
+
+nfsuuid_SOURCES = nfsuuid.c
+nfsuuid_LDADD = $(LIBUUID)
diff --git a/tools/nfsuuid/nfsuuid.c b/tools/nfsuuid/nfsuuid.c
new file mode 100644
index 000000000000..bbdec59f1afe
--- /dev/null
+++ b/tools/nfsuuid/nfsuuid.c
@@ -0,0 +1,203 @@
+/*
+ * nfsuuid.c -- create and persist uniquifiers for nfs4 clients
+ *
+ * Copyright (C) 2022  Red Hat, Benjamin Coddington <bcodding@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor,
+ * Boston, MA 02110-1301, USA.
+ */
+
+#include <stdio.h>
+#include <stdarg.h>
+#include <getopt.h>
+#include <string.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <uuid/uuid.h>
+
+#define DEFAULT_ID_FILE "/etc/nfsuuid"
+
+UUID_DEFINE(nfs4_clientid_uuid_template,
+	0xa2, 0x25, 0x68, 0xb2, 0x7a, 0x5f, 0x49, 0x90,
+	0x8f, 0x98, 0xc5, 0xf0, 0x67, 0x78, 0xcc, 0xf1);
+
+static char *prog;
+static char *source = NULL;
+static char *id_file = DEFAULT_ID_FILE;
+static char nfs_unique_id[64];
+static int replace = 0;
+
+static void usage(void)
+{
+	fprintf(stderr, "usage: %s [-r|--replace] [-f <file> |--file <file> ] [machine]\n", prog);
+}
+
+static void fatal(const char *fmt, ...)
+{
+	int err = errno;
+	va_list args;
+	char fatal_msg[256] = "fatal: ";
+
+	va_start(args, fmt);
+	vsnprintf(&fatal_msg[7], 255, fmt, args);
+	if (err)
+		fprintf(stderr, "%s: %s\n", fatal_msg, strerror(err));
+	else
+		fprintf(stderr, "%s\n", fatal_msg);
+	exit(-1);
+}
+
+static int read_nfs_unique_id(void)
+{
+	int fd;
+	ssize_t len;
+
+	if (replace) {
+		errno = ENOENT;
+		return -1;
+	}
+
+	fd = open(id_file, O_RDONLY);
+	if (fd < 0)
+		return fd;
+	len = read(fd, nfs_unique_id, 64);
+	close(fd);
+	return len;
+}
+
+static void write_nfs_unique_id(void)
+{
+	int fd;
+
+	fd = open(id_file, O_RDWR|O_TRUNC|O_CREAT, S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH);
+	if (fd < 0)
+		fatal("could not write id to %s", id_file);
+	write(fd, nfs_unique_id, 37);
+}
+
+static void print_nfs_unique_id(void)
+{
+	fprintf(stdout, "%s", nfs_unique_id);
+}
+
+static void check_or_make_id(void)
+{
+	int ret;
+	uuid_t uuid;
+
+	ret = read_nfs_unique_id();
+	if (ret < 1) {
+		if (errno != ENOENT )
+			fatal("reading file %s", id_file);
+		uuid_generate_random(uuid);
+		uuid_unparse(uuid, nfs_unique_id);
+		nfs_unique_id[36] = '\n';
+		nfs_unique_id[37] = '\0';
+		write_nfs_unique_id();
+	}
+	print_nfs_unique_id();
+}
+
+static void check_or_make_id_from_machine(void)
+{
+	int fd, ret;
+	char machineid[32];
+	uuid_t uuid;
+
+	ret = read_nfs_unique_id();
+	if (ret < 1) {
+		if (errno != ENOENT )
+			fatal("reading file %s", id_file);
+
+		fd = open("/etc/machine-id", O_RDONLY);
+		if (fd < 0)
+			fatal("unable to read /etc/machine-id");
+
+		read(fd, machineid, 32);
+		close(fd);
+
+		uuid_generate_sha1(uuid, nfs4_clientid_uuid_template, machineid, 32);
+		uuid_unparse(uuid, nfs_unique_id);
+		nfs_unique_id[36] = '\n';
+		nfs_unique_id[37] = '\0';
+		write_nfs_unique_id();
+	}
+	print_nfs_unique_id();
+}
+
+int main(int argc, char **argv)
+{
+	prog = argv[0];
+
+	while (1) {
+		int opt, prev_ind;
+		int option_index = 0;
+		static struct option long_options[] = {
+			{"replace",	no_argument,		0, 'r' },
+			{"file",	required_argument,	0, 'f' },
+			{ 0, 0, 0, 0 }
+		};
+
+		errno = 0;
+		prev_ind = optind;
+		opt = getopt_long(argc, argv, ":rf:", long_options, &option_index);
+		if (opt == -1)
+			break;
+
+		/* Let's detect missing options in the middle of an option list */
+		if (optind == prev_ind + 2 && *optarg == '-') {
+			opt = ':';
+			--optind;
+		}
+
+		switch (opt) {
+		case 'r':
+			replace = 1;
+			break;
+		case 'f':
+			id_file = optarg;
+			break;
+		case ':':
+			usage();
+			fatal("option \"%s\" requires an argument", argv[prev_ind]);
+			break;
+		case '?':
+			usage();
+			fatal("unexpected arg \"%s\"", argv[optind - 1]);
+			break;
+		}
+	}
+
+	argc -= optind;
+
+	if (argc > 1) {
+		usage();
+		fatal("Too many arguments");
+	}
+
+	if (argc)
+		source = argv[optind++];
+
+	if (!source)
+		check_or_make_id();
+	else if (strcmp(source, "machine") == 0)
+		check_or_make_id_from_machine();
+	else {
+		usage();
+		fatal("unrecognized source %s\n", source);
+	}
+}
diff --git a/tools/nfsuuid/nfsuuid.man b/tools/nfsuuid/nfsuuid.man
new file mode 100644
index 000000000000..856d2f383e0f
--- /dev/null
+++ b/tools/nfsuuid/nfsuuid.man
@@ -0,0 +1,33 @@
+.\"
+.\" nfsuuid(8)
+.\"
+.TH nfsuuid 8 "10 Feb 2022"
+.SH NAME
+nfsuuid \- Generate or return nfs client id uniquifiers
+.SH SYNOPSIS
+.B nfsuuid [ -r | --replace ] [ -f | --file <file> ] [<source>]
+
+.SH DESCRIPTION
+The
+.B nfsuuid
+command provides a simple utility to help NFS Version 4 clients use unique
+and persistent client id values.  The command checks for the existence of a
+file /etc/nfsuuid and returns the first 64 chars read from that file.  If
+the file is not found, a UUID is generated from the specified source and
+written to the file and returned.
+.SH OPTIONS
+.TP
+.BR \-r,\ \-\-replace
+Overwrite the <file> with a UUID generated from <source>.
+.TP
+.BR \-f,\ \-\-file
+Use the specified file to lookup or store any generated UUID.  If <file> is
+not specified, the default file used is /etc/nfsuuid.
+.SH Sources
+If <source> is not specified, nfsuuid will generate a new random UUID.
+
+If <source> is "machine", nfsuuid will generate a deterministic UUID value
+derived from a sha1 hash of the contents of /etc/machine-id and a static
+key.
+.SH SEE ALSO
+.BR machine-id (5)
-- 
2.31.1

