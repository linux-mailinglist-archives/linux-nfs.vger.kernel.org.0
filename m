Return-Path: <linux-nfs+bounces-2844-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BDF8A71AA
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Apr 2024 18:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752CF2852EE
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Apr 2024 16:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D6F12AAE3;
	Tue, 16 Apr 2024 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJtsTx5V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2AD86255
	for <linux-nfs@vger.kernel.org>; Tue, 16 Apr 2024 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713286153; cv=none; b=apEGHZXeQU4thQiidupZfKGBNHeZSCif2j/BOaHcheFDtsBq8L/NUg0+E7Gan4CewYlwZl+/514piPTjKlTkeH0vnbWEQjXQE/jvM+YgXXSBZSR7Z/tTEZQyBr5mJZopWINGI036D9pW0lPD8Rp+CVeiSYC3zkvSg5WB+mffqXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713286153; c=relaxed/simple;
	bh=mohXsMFLi2krShdWMM/X+Cird1/pIa825w7EzaxWGcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EZp2pehQwGKCYJUiBLtA3MwE5Eskt0OP8L2xic3XnL4rIHQZbVgLLe8tR/sy8K1CciDpebFcR4Q+b/eISvDguMWhwpvpftAaq6GVRRcys3k+K/ToKHv93qmltYw+t0eZNs5EmuXUJZSCSw8Qt+EB3l1QQpvfoENkYbzyW6DxkZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJtsTx5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48620C4AF09;
	Tue, 16 Apr 2024 16:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713286152;
	bh=mohXsMFLi2krShdWMM/X+Cird1/pIa825w7EzaxWGcU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QJtsTx5VkHwTsTIrO4amZWBvj7OcTx1bWv4EQUISO6/IC3xm6ET5JVpLzO7YNVpi0
	 /SJjvGBGU1HP7lJVmU6mAuOheDMYz9icIcvTMLzsmxj+gt9xbkXRDhm89BU/OCsImV
	 6lqrlUaepL2T8VBrdf+63hYCdN+gK6C/rsxWB0EiwR2gvUF5NdGGjQCDNCW1PiMVBf
	 R6eGDih4TXYz0WPnmgSQEJQH2ktseU4UjHRXhsULDHvHjY4dybhTbhr1JlJjy0AE5k
	 tqfD8b5u5VcEpMlSTCquiSOASroJoWfidhjMkgUQced5DPUiLYyQd6au/rjgvKappa
	 Bwgf+Z9WC/5wA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Apr 2024 12:48:48 -0400
Subject: [PATCH nfs-utils v2 2/4] nfsdctl: convert it to a command-line
 based interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-nfsdctl-v2-2-9a4367b710d2@kernel.org>
References: <20240416-nfsdctl-v2-0-9a4367b710d2@kernel.org>
In-Reply-To: <20240416-nfsdctl-v2-0-9a4367b710d2@kernel.org>
To: Steve Dickson <steved@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Neil Brown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=45736; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=mohXsMFLi2krShdWMM/X+Cird1/pIa825w7EzaxWGcU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmHqwGhMmb7N4E6pdPDJIPrq1QN3bD07pRdf/Ef
 11+UVR49XWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZh6sBgAKCRAADmhBGVaC
 FQXZD/0T/ycg2dHCuiii9JwAlXuzCeINkFPSIA0sH9ynH7Qxl8K4uDyghhCD7IWfHo/88WnCxaa
 7KXEVYx1CJbi3uNtvID10Fo7xsCUFlcJebmkzuYUVVCg6nXE4UY5Jn95f2cYZzf9kxQo8BCNDX+
 7//nloLaCl2cltNzxhzX7o1Qa/Pt6sf8dV8h3DaicYqNgA7c5WnDIVsVtsPajJ22tMLpLks+ha+
 oXvo4QbTOuxxfMRghQqZnR2Sp3mMRn00poNOfc+TuJumlUolYyx+mlAqPahfMLpBOCSy8ShZgo3
 lGFuoDee2PRorTOW23Aa6D3UORCBUxvUqrO7gO660IM0vm6c913oNay20DK+6QYTFVbwBfvHeEv
 GtSY4pAtXRH5k7AFdEUf0APMNKBl+DRlp7Qo7lG6Z8AZvCJ9KheTPp+R4Rj+YQBXG82emJIvjRB
 vEn9wZF9zqKI2ZidaNCyM8NoPfN5tOug+cnpEEC0dOoDERTSlqAfboUGNXDtg1OCxw0PP1F3WCn
 StD3/uA8K/c3hxMlclMKhJgXvWSWK3QqAqiq3nd1NjJAp/wkwVTpAqmqOPbS5NK9vsyUPLx6HTq
 Dn76AR/9exoGUXinNDxf891K/Om7zUMcMBxZ+12J+jMEGLKkSguAlUBdEYew/ovMadZjQssi7ZG
 YgUzRIeuZhM5XXw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Lorenzo's original tool used getopt_long to indicate the command, but
that's somewhat limiting. This switches it to a subcommand-based
interface, where each subcommand can take its own getopt options, in the
spirit of commands like nmcli or virsh.

There are currently 5 different subcommands:

    listener             get/set listener info
    version              get/set supported NFS versions
    threads              get/set nfsd thread settings
    status               get current RPC processing info
    autostart            start server with settings from /etc/nfs.conf

Each can take different options, and we can expand this interface later
with more commands as necessary.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 configure.ac              |    1 +
 utils/nfsdctl/Makefile.am |    7 +-
 utils/nfsdctl/nfsdctl.8   |  274 ++++++++++
 utils/nfsdctl/nfsdctl.c   | 1278 +++++++++++++++++++++++++++++++++++++--------
 utils/nfsdctl/nfsdctl.h   |    3 +
 5 files changed, 1357 insertions(+), 206 deletions(-)

diff --git a/configure.ac b/configure.ac
index ec5eea79a957..f965865465ae 100644
--- a/configure.ac
+++ b/configure.ac
@@ -261,6 +261,7 @@ AC_ARG_ENABLE(nfsdctl,
 		dnl Check for libnl3
 		PKG_CHECK_MODULES(LIBNL3, libnl-3.0 >= 3.1)
 		PKG_CHECK_MODULES(LIBNLGENL3, libnl-genl-3.0 >= 3.1)
+		PKG_CHECK_MODULES(LIBREADLINE, readline)
 	fi
 
 AC_ARG_ENABLE(nfsv4server,
diff --git a/utils/nfsdctl/Makefile.am b/utils/nfsdctl/Makefile.am
index 9b8484a81a3f..89c7ecd6f30b 100644
--- a/utils/nfsdctl/Makefile.am
+++ b/utils/nfsdctl/Makefile.am
@@ -1,10 +1,13 @@
 ## Process this file with automake to produce Makefile.in
 
+man8_MANS       = nfsdctl.8
+EXTRA_DIST      = $(man8_MANS)
+
 sbin_PROGRAMS	= nfsdctl
 
 noinst_HEADERS = nfsdctl.h
 nfsdctl_SOURCES = nfsdctl.c
-nfsdctl_CFLAGS = $(LIBNL3_CFLAGS) $(LIBNLGENL3_CFLAGS)
-nfsdctl_LDADD = ../../support/nfs/libnfs.la $(LIBNL3_LIBS) $(LIBNLGENL3_LIBS)
+nfsdctl_CFLAGS = $(LIBNL3_CFLAGS) $(LIBNLGENL3_CFLAGS) $(LIBREADLINE_CFLAGS)
+nfsdctl_LDADD = ../../support/nfs/libnfs.la $(LIBNL3_LIBS) $(LIBNLGENL3_LIBS) $(LIBREADLINE_LIBS)
 
 MAINTAINERCLEANFILES = Makefile.in
diff --git a/utils/nfsdctl/nfsdctl.8 b/utils/nfsdctl/nfsdctl.8
new file mode 100644
index 000000000000..89d1a09c1a1a
--- /dev/null
+++ b/utils/nfsdctl/nfsdctl.8
@@ -0,0 +1,274 @@
+'\" t
+.\"     Title: nfsdctl
+.\"    Author: Jeff Layton
+.\" Generator: Asciidoctor 2.0.20
+.\"      Date: 2024-04-16
+.\"    Manual: \ \&
+.\"    Source: \ \&
+.\"  Language: English
+.\"
+.TH "NFSDCTL" "8" "2024-04-16" "\ \&" "\ \&"
+.ie \n(.g .ds Aq \(aq
+.el       .ds Aq '
+.ss \n[.ss] 0
+.nh
+.ad l
+.de URL
+\fI\\$2\fP <\\$1>\\$3
+..
+.als MTO URL
+.if \n[.g] \{\
+.  mso www.tmac
+.  am URL
+.    ad l
+.  .
+.  am MTO
+.    ad l
+.  .
+.  LINKSTYLE blue R < >
+.\}
+.SH "NAME"
+nfsdctl \- control program for the Linux kernel NFS server
+.SH "SYNOPSIS"
+.sp
+\fBnfsdctl\fP [ \fIOPTION\fP ] COMMAND ...
+.SH "DESCRIPTION"
+.sp
+nfsdctl is a control and query program for the in\-kernel NFS server. There are several
+subcommands (documented below) that allow the admin to configure or query different
+aspects of the NFS server.
+.sp
+To get information about different subcommand usage, pass the subcommand the
+\-\-help parameter. For example:
+.sp
+.if n .RS 4
+.nf
+.fam C
+nfsdctl listener \-\-help
+.fam
+.fi
+.if n .RE
+.SH "OPTIONS"
+.sp
+\fB\-d, \-\-debug\fP
+.RS 4
+Enable debug logging
+.RE
+.sp
+\fB\-h, \-\-help\fP
+.RS 4
+Print program help text
+.RE
+.sp
+\fB\-V, \-\-version\fP
+.RS 4
+Print program version
+.RE
+.SH "SUBCOMMANDS"
+.sp
+Each subcommand can also accept its own set of options and arguments. The
+\-\-help option is standard for all subcommands:
+.sp
+\fBautostart\fP
+.RS 4
+Start the server using the settings in the [nfsd] section of /etc/nfs.conf.
+This subcommand takes no arguments.
+.RE
+.sp
+\fBlistener\fP
+.RS 4
+Get/set the listening sockets for the server. Run this without arguments to
+get a list of the sockets on which the server is currently listening. To add
+or remove sockets, pass it whitespace\-separated strings in the format:
+.sp
+.if n .RS 4
+.nf
+.fam C
+{ +|\- }{ protocol }:{ address }:{ port }
+.fam
+.fi
+.if n .RE
+.sp
+.if n .RS 4
+.nf
+.fam C
+The fields are:
+.fam
+.fi
+.if n .RE
+.sp
+.if n .RS 4
+.nf
+.fam C
++ to add a listener, \- to remove one
+protocol: protocol name (e.g. tcp, udp, rdma)
+address: hostname or address
+port: port number or service name
+.fam
+.fi
+.if n .RE
+.sp
+.if n .RS 4
+.nf
+.fam C
+All fields are required, except for the address. If address is an empty string,
+then the listeners will be opened for INADDR_ANY and IN6ADDR_ANY_INIT for ipv6
+(if enabled). The address can be either a hostname or an IP address. IPv4
+addresses must be in dotted\-quad form. IPv6 addresses should be in standard
+colon separated form, and must be enclosed in square brackets.
+.fam
+.fi
+.if n .RE
+.RE
+.sp
+\fBstatus\fP
+.RS 4
+Get information about RPCs currently executing in the server. This subcommand
+takes no arguments.
+.RE
+.sp
+\fBthreads\fP
+.RS 4
+Get/set the number of running nfsd threads. Pass this subcommand a positive
+integer to change the currently active number of threads. Passing it a value
+of 0 will shut down the NFS server. Run this without arguments to get the
+current number of running threads.
+.RE
+.sp
+\fBversion\fP
+.RS 4
+Get/set the enabled NFS versions for the server. Run without arguments to
+get a list of supported versions and whether they are currently enabled or
+disabled. To enable or disable a version, pass it a string in the format:
+.sp
+.if n .RS 4
+.nf
+.fam C
+{ +|\- }{ MAJOR }{.{ MINOR }}
+.fam
+.fi
+.if n .RE
+.sp
+.if n .RS 4
+.nf
+.fam C
+The fields are:
+.fam
+.fi
+.if n .RE
+.sp
+.if n .RS 4
+.nf
+.fam C
++ to enable a version, \- to disable
+MAJOR: the major version integer value
+MINOR: the minor version integet value
+.fam
+.fi
+.if n .RE
+.sp
+.if n .RS 4
+.nf
+.fam C
+The minorversion field is optional. If not given, it will disable or enable
+all minorversions for that major version.
+.fam
+.fi
+.if n .RE
+.RE
+.SH "EXAMPLES"
+.sp
+Start the server with the settings in nfs.conf:
+.sp
+.if n .RS 4
+.nf
+.fam C
+nfsdctl autostart
+.fam
+.fi
+.if n .RE
+.sp
+Get a list of current listening sockets:
+.sp
+.if n .RS 4
+.nf
+.fam C
+nfsdctl listener
+.fam
+.fi
+.if n .RE
+.sp
+Show the supported and enabled NFS versions:
+.sp
+.if n .RS 4
+.nf
+.fam C
+nfsdctl version
+.fam
+.fi
+.if n .RE
+.sp
+Add TCP listener on all addresses (both v4 and v6), port 2049:
+.sp
+.if n .RS 4
+.nf
+.fam C
+nfsdctl listener +tcp::2049
+.fam
+.fi
+.if n .RE
+.sp
+Add RDMA listener on 1.2.3.4 port 20049:
+.sp
+.if n .RS 4
+.nf
+.fam C
+nfsdctl listener +rdma:1.2.3.4:20049
+.fam
+.fi
+.if n .RE
+.sp
+Add same listener on IPv6 address f00::ba4 port 20050:
+.sp
+.if n .RS 4
+.nf
+.fam C
+nfsdctl listener +rdma:[f00::ba4]:20050
+.fam
+.fi
+.if n .RE
+.sp
+Enable NFS version 3, disable v4.0:
+.sp
+.if n .RS 4
+.nf
+.fam C
+nfsdctl version +3 \-4.0
+.fam
+.fi
+.if n .RE
+.sp
+Change the number of running threads to 256:
+.sp
+.if n .RS 4
+.nf
+.fam C
+nfsdctl threads 256
+.fam
+.fi
+.if n .RE
+.SH "NOTES"
+.sp
+nfsdctl is intended to supersede rpc.nfsd(8), which controls the nfs server
+using the files under /proc/fs/nfsd. nfsdctl instead uses a netlink(7)
+interface to achieve the same goals.
+.sp
+Most of the commands that query the NFS server can be run as an unprivileged
+user, but configuring the server typically requires an account with elevated
+privileges.
+.SH "SEE ALSO"
+.sp
+nfs.conf(5), rpc.nfsd(8), rpc.mountd(8), exports(5), exportfs(8), nfs.conf(5), rpc.rquotad(8),  nfsstat(8), netconfig(5)
+.SH "AUTHOR"
+.sp
+Jeff Layton
\ No newline at end of file
diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index d80a6ef5102b..f1669393b911 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -1,14 +1,19 @@
+#define _GNU_SOURCE 1
 #include <linux/module.h>
 #include <linux/version.h>
 #include <netlink/genl/genl.h>
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdarg.h>
 #include <time.h>
 #include <stdbool.h>
 #include <arpa/inet.h>
 #include <unistd.h>
 #include <getopt.h>
+#include <string.h>
+#include <sched.h>
+#include <sys/queue.h>
 
 #include <netlink/genl/family.h>
 #include <netlink/genl/ctrl.h>
@@ -16,12 +21,68 @@
 #include <netlink/attr.h>
 #include <linux/netlink.h>
 
+#include <readline/readline.h>
+#include <readline/history.h>
+
 #include "nfsdctl.h"
+#include "conffile.h"
+#include "xlog.h"
 
 /* compile note:
  * gcc -I/usr/include/libnl3/ -o <prog-name> <prog-name>.c -lnl-3 -lnl-genl-3
  */
 
+static int debug_level;
+static int nl_family_id;
+
+struct nfs_version {
+	uint8_t	major;
+	uint8_t	minor;
+	bool enabled;
+};
+
+/*
+ * The NFS server should only have around 5 versions or so, so we don't bother
+ * with memory allocation here, and just use a global array.
+ */
+#define MAX_NFS_VERSIONS	16
+
+struct nfs_version nfsd_versions[MAX_NFS_VERSIONS];
+
+/*
+ * All of the existing netids are short strings (3-4 chars), but let's allow
+ * for up to 16.
+ */
+#define MAX_CLASS_NAME_LEN	16
+
+struct server_socket {
+	struct sockaddr_storage	ss;
+	char name[MAX_CLASS_NAME_LEN];
+	bool active;
+};
+
+#define MAX_NFSD_SOCKETS		256
+
+int nfsd_socket_count;
+struct server_socket nfsd_sockets[MAX_NFSD_SOCKETS];
+
+const char *taskname;
+
+static const struct option help_only_options[] = {
+	{ "help", no_argument, NULL, 'h' },
+	{ },
+};
+
+static void debug(int level, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	if (level <= debug_level)
+		vprintf(fmt, args);
+	va_end(args);
+}
+
 #define NFSD4_OPS_MAX_LEN	sizeof(nfsd4_ops) / sizeof(nfsd4_ops[0])
 static const char *nfsd4_ops[] = {
 	[OP_ACCESS]		= "OP_ACCESS",
@@ -168,9 +229,11 @@ static void parse_rpc_status_get(struct genlmsghdr *gnlh)
 static void parse_version_get(struct genlmsghdr *gnlh)
 {
 	struct nlattr *attr;
-	int rem;
+	int rem, idx = 0;
+
+	/* clear the nfsd_versions array */
+	memset(nfsd_versions, '\0', sizeof(*nfsd_versions) * MAX_NFS_VERSIONS);
 
-	printf("Server Versions:");
 	nla_for_each_attr(attr, genlmsg_attrdata(gnlh, 0),
 			  genlmsg_attrlen(gnlh, 0), rem) {
 		struct nlattr *a;
@@ -179,54 +242,79 @@ static void parse_version_get(struct genlmsghdr *gnlh)
 		nla_for_each_nested(a, attr, i) {
 			switch (nla_type(a)) {
 			case NFSD_A_VERSION_MAJOR:
-				printf("\t%d", nla_get_u32(a));
+				nfsd_versions[idx].major = nla_get_u32(a);
 				break;
 			case NFSD_A_VERSION_MINOR:
-				printf(":%d", nla_get_u32(a));
+				nfsd_versions[idx].minor = nla_get_u32(a);
+				break;
+			case NFSD_A_VERSION_ENABLED:
+				nfsd_versions[idx].enabled = nla_get_flag(a);
 				break;
 			default:
 				break;
 			}
 		}
+		++idx;
 	}
-	printf("\n");
 }
 
 static void parse_listener_get(struct genlmsghdr *gnlh)
 {
-	int rem, major, minor;
 	struct nlattr *attr;
+	int rem, idx = 0;
+
+	/* clear the nfsd_sockets array */
+	memset(nfsd_sockets, '\0', sizeof(*nfsd_sockets) * MAX_NFSD_SOCKETS);
 
-	printf("Server Listeners:");
 	nla_for_each_attr(attr, genlmsg_attrdata(gnlh, 0),
 			  genlmsg_attrlen(gnlh, 0), rem) {
-		unsigned short proto = 0;
-		const char *name = NULL;
-		unsigned port = 0;
 		struct nlattr *a;
+		char *res;
 		int i;
 
 		nla_for_each_nested(a, attr, i) {
 			switch (nla_type(a)) {
-			case NFSD_A_LISTENER_TRANSPORT_NAME:
-				name = nla_data(a);
+			case NFSD_A_SOCK_TRANSPORT_NAME:
+				res = strncpy(nfsd_sockets[idx].name, nla_data(a),
+					      MAX_CLASS_NAME_LEN);
+				res[MAX_CLASS_NAME_LEN - 1] = '\0'; // just to be sure
 				break;
-			case NFSD_A_LISTENER_PORT:
-				port = nla_get_u32(a);
+			case NFSD_A_SOCK_ADDR:
+				memcpy(&nfsd_sockets[idx].ss, nla_data(a),
+					sizeof(nfsd_sockets[idx].ss));
 				break;
-			case NFSD_A_LISTENER_INET_PROTO:
-				proto = nla_get_u16(a);
+			}
+			nfsd_sockets[idx].active = true;
+		}
+		++idx;
+	}
+	nfsd_socket_count = idx;
+}
+
+static void parse_threads_get(struct genlmsghdr *gnlh)
+{
+	struct nlattr *attr;
+	int rem, idx = 0;
+
+	nla_for_each_attr(attr, genlmsg_attrdata(gnlh, 0),
+			  genlmsg_attrlen(gnlh, 0), rem) {
+		struct nlattr *a;
+		int i;
+
+		switch (nla_type(attr)) {
+			case NFSD_A_SERVER_WORKER_GRACETIME:
+				printf("gracetime: %u\n", nla_get_u32(attr));
+				break;
+			case NFSD_A_SERVER_WORKER_LEASETIME:
+				printf("leasetime: %u\n", nla_get_u32(attr));
+				break;
+			case NFSD_A_SERVER_WORKER_THREADS:
+				printf("threads: %u\n", nla_get_u32(attr));
 				break;
 			default:
 				break;
-			}
 		}
-
-		if (name && port && proto)
-			printf("\n\t%s%s:%d",
-			       name, proto == AF_INET6 ? "6" : "4", port);
 	}
-	printf("\n");
 }
 
 static int recv_handler(struct nl_msg *msg, void *arg)
@@ -239,8 +327,7 @@ static int recv_handler(struct nl_msg *msg, void *arg)
 		parse_rpc_status_get(gnlh);
 		break;
 	case NFSD_CMD_THREADS_GET:
-		if (nla_type(attr) == NFSD_A_SERVER_WORKER_THREADS)
-			printf("Running threads\t: %d\n", nla_get_u32(attr));
+		parse_threads_get(gnlh);
 		break;
 	case NFSD_CMD_VERSION_GET:
 		parse_version_get(gnlh);
@@ -255,263 +342,714 @@ static int recv_handler(struct nl_msg *msg, void *arg)
 	return NL_SKIP;
 }
 
-static const struct option long_options[] = {
-	{ "help", no_argument, NULL, 'h'		},
-	{ "rpc-status", no_argument, NULL, 'R'		},
-	{ "set-threads", required_argument, NULL, 't'	},
-	{ "get-threads", no_argument, NULL, 'T'		},
-	{ "set-version", required_argument, NULL, 'v'	},
-	{ "get-versions", no_argument, NULL, 'V'	},
-	{ "set-sockaddr", required_argument, NULL, 's'	},
-	{ "set-listener", required_argument, NULL, 'p'	},
-	{ "get-listeners", no_argument, NULL, 'P'	},
-	{ },
-};
-
-static int get_cmd_type(int arg)
-{
-	switch (arg) {
-	case 'R':
-		return NFSD_CMD_RPC_STATUS_GET;
-	case 't':
-		return NFSD_CMD_THREADS_SET;
-	case 'T':
-		return NFSD_CMD_THREADS_GET;
-	case 'v':
-		return NFSD_CMD_VERSION_SET;
-	case 'V':
-		return NFSD_CMD_VERSION_GET;
-	case 'p':
-		return NFSD_CMD_LISTENER_SET;
-	case 'P':
-		return NFSD_CMD_LISTENER_GET;
-	case 's':
-		return NFSD_CMD_SOCK_SET;
-	case 'h':
-	default:
-		return -EINVAL;
-	}
-}
-
-static void usage(char *argv[], const struct option *long_options)
-{
-	int i;
-
-	printf("\nOption for %s:\n", argv[0]);
-	for (i = 0; long_options[i].name != 0; i++) {
-		printf(" --%-15s", long_options[i].name);
-		if (long_options[i].flag != NULL)
-			printf(" flag (internal value: %d)",
-			       *long_options[i].flag);
-		else
-			printf("\t short-option: -%c", long_options[i].val);
-		printf("\n");
-	}
-	printf("\n");
-}
-
 #define BUFFER_SIZE	8192
-static struct nl_msg *netlink_sock_and_msg_alloc(struct nl_sock **sock)
+static struct nl_sock *netlink_sock_alloc(void)
 {
-	struct nl_msg *msg = NULL;
-	int ret, id;
+	struct nl_sock *sock;
+	int ret;
 
-	*sock = nl_socket_alloc();
-	if (!(*sock))
+	sock = nl_socket_alloc();
+	if (!sock)
 		return NULL;
 
-	if (genl_connect(*sock)) {
+	if (genl_connect(sock)) {
 		fprintf(stderr, "Failed to connect to generic netlink\n");
-		goto error;
+		nl_socket_free(sock);
+		return NULL;
 	}
 
-	nl_socket_set_buffer_size(*sock, BUFFER_SIZE, BUFFER_SIZE);
-	setsockopt(nl_socket_get_fd(*sock), SOL_NETLINK, NETLINK_EXT_ACK,
+	nl_socket_set_buffer_size(sock, BUFFER_SIZE, BUFFER_SIZE);
+	setsockopt(nl_socket_get_fd(sock), SOL_NETLINK, NETLINK_EXT_ACK,
 		   &ret, sizeof(ret));
 
-	id = genl_ctrl_resolve(*sock, NFSD_FAMILY_NAME);
+	return sock;
+}
+
+static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock)
+{
+	struct nl_msg *msg;
+	int id;
+
+	id = genl_ctrl_resolve(sock, NFSD_FAMILY_NAME);
 	if (id < 0) {
 		fprintf(stderr, "%s not found\n", NFSD_FAMILY_NAME);
-		goto error;
+		return NULL;
 	}
 
 	msg = nlmsg_alloc();
 	if (!msg) {
 		fprintf(stderr, "failed to allocate netlink message\n");
-		goto error;
+		return NULL;
 	}
 
 	if (!genlmsg_put(msg, 0, 0, id, 0, 0, 0, 0)) {
 		fprintf(stderr, "failed to allocate netlink message\n");
-		goto error;
+		nlmsg_free(msg);
+		return NULL;
 	}
 
 	return msg;
-error:
-	nl_socket_free(*sock);
-	nlmsg_free(msg);
-	return NULL;
 }
 
-int main(char argc, char **argv)
+static void status_usage(void)
+{
+	printf("Usage: %s status\n", taskname);
+	printf("    Display RPC jobs currently in flight on the server.\n");
+}
+
+static int status_func(struct nl_sock *sock, int argc, char ** argv)
 {
-	int port, proto, nl_cmd = 0, longindex = 0, opt, ret = 1;
-	char transport[64], addr[64];
 	struct genlmsghdr *ghdr;
 	struct nlmsghdr *nlh;
-	struct nl_sock *sock;
 	struct nl_msg *msg;
 	struct nl_cb *cb;
+	int opt, ret;
 
-	if (argc == 1) {
-		usage(argv, long_options);
-		return -EINVAL;
+	optind = 1;
+	while ((opt = getopt_long(argc, argv, "h", help_only_options, NULL)) != -1) {
+		switch (opt) {
+		case 'h':
+			status_usage();
+			return 0;
+		}
 	}
 
-	msg = netlink_sock_and_msg_alloc(&sock);
+	msg = netlink_msg_alloc(sock);
 	if (!msg)
-		return -ENOMEM;
+		return 1;
 
-	ret = EINVAL;
 	nlh = nlmsg_hdr(msg);
+	nlh->nlmsg_flags |= NLM_F_DUMP;
+	ghdr = nlmsg_data(nlh);
+	ghdr->cmd = NFSD_CMD_RPC_STATUS_GET;
 
-	while ((opt = getopt_long(argc, argv, "Rt:Tv:Vp:Ps:h",
-				  long_options, &longindex)) != -1) {
-		int cmd = get_cmd_type(opt);
-		struct nlattr *a;
+	cb = nl_cb_alloc(NL_CB_CUSTOM);
+	if (!cb) {
+		fprintf(stderr, "failed to allocate netlink callbacks\n");
+		ret = 1;
+		goto out;
+	}
 
-		if (cmd < 0) {
-			usage(argv, long_options);
-			goto out;
+	ret = nl_send_auto(sock, msg);
+	if (ret < 0)
+		goto out_cb;
+
+	ret = 1;
+	nl_cb_err(cb, NL_CB_CUSTOM, error_handler, &ret);
+	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, finish_handler, &ret);
+	nl_cb_set(cb, NL_CB_ACK, NL_CB_CUSTOM, ack_handler, &ret);
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, recv_handler, NULL);
+
+	while (ret > 0)
+		nl_recvmsgs(sock, cb);
+	if (ret < 0) {
+		fprintf(stderr, "Error: %s\n", strerror(-ret));
+		ret = 1;
+	}
+out_cb:
+	nl_cb_put(cb);
+out:
+	nlmsg_free(msg);
+	return ret;
+}
+
+static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease, int threads)
+{
+	struct genlmsghdr *ghdr;
+	struct nlmsghdr *nlh;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int ret;
+
+	msg = netlink_msg_alloc(sock);
+	if (!msg)
+		return 1;
+
+	nlh = nlmsg_hdr(msg);
+	if (cmd == NFSD_CMD_THREADS_SET) {
+		if (grace)
+			nla_put_u32(msg, NFSD_A_SERVER_WORKER_GRACETIME, grace);
+		if (lease)
+			nla_put_u32(msg, NFSD_A_SERVER_WORKER_LEASETIME, lease);
+		nla_put_u32(msg, NFSD_A_SERVER_WORKER_THREADS, threads);
+	}
+	ghdr = nlmsg_data(nlh);
+	ghdr->cmd = cmd;
+
+	cb = nl_cb_alloc(NL_CB_CUSTOM);
+	if (!cb) {
+		fprintf(stderr, "failed to allocate netlink callbacks\n");
+		ret = 1;
+		goto out;
+	}
+
+	ret = nl_send_auto(sock, msg);
+	if (ret < 0) {
+		fprintf(stderr, "send failed (%d)!\n", ret);
+		goto out_cb;
+	}
+
+	ret = 1;
+	nl_cb_err(cb, NL_CB_CUSTOM, error_handler, &ret);
+	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, finish_handler, &ret);
+	nl_cb_set(cb, NL_CB_ACK, NL_CB_CUSTOM, ack_handler, &ret);
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, recv_handler, NULL);
+
+	while (ret > 0)
+		nl_recvmsgs(sock, cb);
+	if (ret < 0) {
+		fprintf(stderr, "Error: %s\n", strerror(-ret));
+		ret = 1;
+	}
+out_cb:
+	nl_cb_put(cb);
+out:
+	nlmsg_free(msg);
+	return ret;
+}
+
+static void threads_usage(void)
+{
+	printf("Usage: %s threads [ count ]\n", taskname);
+	printf("    @threads: number of threads the server should run\n\n");
+	printf("Omit the count to show the current threads value. Set threads\n");
+	printf("to zero to shut down the server.\n");
+}
+
+static int threads_func(struct nl_sock *sock, int argc, char ** argv)
+{
+	uint8_t cmd = NFSD_CMD_THREADS_GET;
+	char *endptr = NULL;
+	int opt, threads = 0;
+
+	optind = 1;
+	while ((opt = getopt_long(argc, argv, "h", help_only_options, NULL)) != -1) {
+		switch (opt) {
+		case 'h':
+			threads_usage();
+			return 0;
 		}
+	}
 
-		if (nl_cmd && cmd != nl_cmd) {
-			usage(argv, long_options);
-			goto out;
+	if (optind < argc) {
+		/* empty string? */
+		if (argv[optind][0] == '\0') {
+			fprintf(stderr, "Invalid threads value %s.\n", argv[1]);
+			return 1;
+		}
+
+		threads = strtol(argv[optind], &endptr, 0);
+		if (!endptr || *endptr != '\0') {
+			fprintf(stderr, "Invalid threads value %s.\n", argv[1]);
+			return 1;
 		}
+		cmd = NFSD_CMD_THREADS_SET;
+	}
+	return threads_doit(sock, cmd, 0, 0, threads);
+}
 
-		nl_cmd = cmd;
-		switch (nl_cmd) {
-		case NFSD_CMD_RPC_STATUS_GET:
-			nlh->nlmsg_flags |= NLM_F_DUMP;
+/*
+ * Update the nfsd_versions array with the latest info from the kernel
+ */
+static int fetch_nfsd_versions(struct nl_sock *sock)
+{
+	struct genlmsghdr *ghdr;
+	struct nlmsghdr *nlh;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int ret;
+
+	msg = netlink_msg_alloc(sock);
+	if (!msg)
+		return 1;
+
+	nlh = nlmsg_hdr(msg);
+	ghdr = nlmsg_data(nlh);
+	ghdr->cmd = NFSD_CMD_VERSION_GET;
+
+	cb = nl_cb_alloc(NL_CB_CUSTOM);
+	if (!cb) {
+		fprintf(stderr, "failed to allocate netlink callbacks\n");
+		ret = 1;
+		goto out;
+	}
+
+	ret = nl_send_auto(sock, msg);
+	if (ret < 0) {
+		fprintf(stderr, "send failed: %d\n", ret);
+		goto out_cb;
+	}
+
+	ret = 1;
+	nl_cb_err(cb, NL_CB_CUSTOM, error_handler, &ret);
+	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, finish_handler, &ret);
+	nl_cb_set(cb, NL_CB_ACK, NL_CB_CUSTOM, ack_handler, &ret);
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, recv_handler, NULL);
+
+	while (ret > 0)
+		nl_recvmsgs(sock, cb);
+	if (ret < 0) {
+		fprintf(stderr, "Error: %s\n", strerror(-ret));
+		ret = 1;
+	}
+out_cb:
+	nl_cb_put(cb);
+out:
+	nlmsg_free(msg);
+	return ret;
+}
+
+static void print_versions_array(void)
+{
+	int i;
+
+	for (i = 0; i < MAX_NFS_VERSIONS; ++i) {
+		/* A major of zero indicates the end of the array */
+		if (nfsd_versions[i].major == 0)
 			break;
-		case NFSD_CMD_THREADS_SET: {
-			int thread = strtoul(optarg, NULL, 0);
+		if (i != 0)
+			printf(" ");
+		printf("%c%hhd.%hhd",
+			nfsd_versions[i].enabled ? '+' : '-',
+			nfsd_versions[i].major, nfsd_versions[i].minor);
+	}
+	putchar('\n');
+}
+
+static int set_nfsd_versions(struct nl_sock *sock)
+{
+	struct genlmsghdr *ghdr;
+	struct nlmsghdr *nlh;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int i, ret;
+
+	msg = netlink_msg_alloc(sock);
+	if (!msg)
+		return 1;
+
+	nlh = nlmsg_hdr(msg);
+
+	for (i = 0; i < MAX_NFS_VERSIONS; ++i) {
+		struct nlattr *a;
 
-			nla_put_u32(msg, NFSD_A_SERVER_WORKER_THREADS, thread);
+		if (nfsd_versions[i].major == 0)
 			break;
+
+		a = nla_nest_start(msg, NLA_F_NESTED | NFSD_A_SERVER_PROTO_VERSION);
+		if (!a) {
+			fprintf(stderr, "Unable to allocate version nest!\n");
+			ret = 1;
+			goto out;
 		}
-		case NFSD_CMD_VERSION_SET: {
-			int major, minor;
 
-			if (sscanf(optarg, "%d.%d", &major, &minor) != 2) {
-				usage(argv, long_options);
-				goto out;
-			}
+		nla_put_u32(msg, NFSD_A_VERSION_MAJOR, nfsd_versions[i].major);
+		nla_put_u32(msg, NFSD_A_VERSION_MINOR, nfsd_versions[i].minor);
+		if (nfsd_versions[i].enabled)
+			nla_put_flag(msg, NFSD_A_VERSION_ENABLED);
+		nla_nest_end(msg, a);
+	}
 
+	ghdr = nlmsg_data(nlh);
+	ghdr->cmd = NFSD_CMD_VERSION_SET;
 
-			a = nla_nest_start(msg,
-					   NLA_F_NESTED | NFSD_A_SERVER_PROTO_VERSION);
-			if (!a) {
-				ret = -ENOMEM;
-				goto out;
-			}
+	cb = nl_cb_alloc(NL_CB_CUSTOM);
+	if (!cb) {
+		fprintf(stderr, "Failed to allocate netlink callbacks\n");
+		ret = 1;
+		goto out;
+	}
 
-			nla_put_u32(msg, NFSD_A_VERSION_MAJOR, major);
-			nla_put_u32(msg, NFSD_A_VERSION_MINOR, minor);
-			nla_nest_end(msg, a);
+	ret = nl_send_auto(sock, msg);
+	if (ret < 0) {
+		fprintf(stderr, "Send failed: %d\n", ret);
+		goto out_cb;
+	}
+
+	ret = 1;
+	nl_cb_err(cb, NL_CB_CUSTOM, error_handler, &ret);
+	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, finish_handler, &ret);
+	nl_cb_set(cb, NL_CB_ACK, NL_CB_CUSTOM, ack_handler, &ret);
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, recv_handler, NULL);
+
+	while (ret > 0)
+		nl_recvmsgs(sock, cb);
+	if (ret < 0) {
+		fprintf(stderr, "Error: %s\n", strerror(-ret));
+		ret = 1;
+	}
+out_cb:
+	nl_cb_put(cb);
+out:
+	nlmsg_free(msg);
+	return ret;
+}
+
+static int update_nfsd_version(int major, int minor, bool enabled)
+{
+	int i;
+
+	for (i = 0; i < MAX_NFS_VERSIONS; ++i) {
+		if (nfsd_versions[i].major == 0)
 			break;
+		if (nfsd_versions[i].major == major && nfsd_versions[i].minor == minor) {
+			nfsd_versions[i].enabled = enabled;
+			return 0;
 		}
-		case NFSD_CMD_LISTENER_SET:
-			if (sscanf(optarg, "%s.%d.%d",
-				   transport, &port, &proto) != 3) {
-				usage(argv, long_options);
-				goto out;
-			}
+	}
+	/* the kernel doesn't support this version */
+	if (!enabled)
+		return 0;
+	fprintf(stderr, "This kernel does not support NFS version %d.%d\n", major, minor);
+	return -EINVAL;
+}
 
+static void version_usage(void)
+{
+	printf("Usage: %s version { {+,-}major.minor } ...\n", taskname);
+	printf("    + to enable a version, - to disable it\n");
+	printf("    @major: major version number\n");
+	printf("    @minor: minor version number\n");
+	printf("Examples:\n");
+	printf("    Display currently enabled and disabled versions:\n");
+	printf("        version\n");
+	printf("    Disable NFSv4.0:\n");
+	printf("        version -v4.0\n");
+	printf("    Enable v4.1, v4.2, disable v2, v3 and v4.0:\n");
+	printf("        version -2 -3 -v4.0 +4.1 +v4.2\n");
+}
 
-			a = nla_nest_start(msg,
-					   NLA_F_NESTED | NFSD_A_SERVER_LISTENER_INSTANCE);
-			if (!a) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			nla_put_string(msg, NFSD_A_LISTENER_TRANSPORT_NAME,
-				       transport);
-			nla_put_u32(msg, NFSD_A_LISTENER_PORT, port);
-			nla_put_u16(msg, NFSD_A_LISTENER_INET_PROTO, proto);
-			nla_nest_end(msg, a);
-			break;
-		case NFSD_CMD_SOCK_SET: {
-			struct sockaddr_storage sa_storage = {};
+static int version_func(struct nl_sock *sock, int argc, char ** argv)
+{
+	char *endptr = NULL;
+	int opt, ret, threads, i;
+
+	/* help is only valid as first argument after command */
+	if (argc > 1 &&
+	    (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help"))) {
+		version_usage();
+		return 0;
+	}
+
+	ret = fetch_nfsd_versions(sock);
+	if (ret)
+		return ret;
+
+	if (argc > 1) {
+		for (i = 1; i < argc; ++i) {
+			int ret, major, minor = 0;
+			char sign = '\0', *str = argv[i];
+			bool enabled;
 
-			if (sscanf(optarg, "[%s].%s.%d.%d",
-				   addr, &port, transport, &proto) != 4) {
-				usage(argv, long_options);
-				goto out;
+			ret = sscanf(str, "%c%d.%d\n", &sign, &major, &minor);
+			if (ret < 2) {
+				fprintf(stderr, "Invalid version string (%d) %s\n", ret, str);
+				return -EINVAL;
 			}
 
-			switch (proto) {
-			case AF_INET: {
-				struct sockaddr_in *sin = (void *)&sa_storage;
-
-				sin->sin_family = AF_INET;
-				sin->sin_port = htons(port);
-				if (inet_pton(AF_INET, addr,
-					      &sin->sin_addr) != 1) {
-					ret = -EINVAL;
-					goto out;
-				}
+			switch(sign) {
+			case '+':
+				enabled = true;
 				break;
-			}
-			case AF_INET6: {
-				struct sockaddr_in6 *sin6 = (void *)&sa_storage;
-
-				sin6->sin6_family = AF_INET6;
-				sin6->sin6_port = htons(port);
-				if (inet_pton(AF_INET6, addr,
-					      &sin6->sin6_addr) != 1) {
-					ret = -EINVAL;
-					goto out;
-				}
+			case '-':
+				enabled = false;
 				break;
-			}
 			default:
-				ret = -EINVAL;
-				goto out;
+				fprintf(stderr, "Invalid version string %s\n", str);
+				return -EINVAL;
 			}
 
-			a = nla_nest_start(msg,
-					   NLA_F_NESTED | NFSD_A_SERVER_SOCK_ADDR);
-			if (!a) {
-				ret = -ENOMEM;
-				goto out_cb;
+			ret = update_nfsd_version(major, minor, enabled);
+			if (ret)
+				return ret;
+		}
+		return set_nfsd_versions(sock);
+	}
+
+	print_versions_array();
+	return 0;
+}
+
+static int fetch_current_listeners(struct nl_sock *sock)
+{
+	struct genlmsghdr *ghdr;
+	struct nlmsghdr *nlh;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int ret;
+
+	msg = netlink_msg_alloc(sock);
+	if (!msg)
+		return 1;
+
+	nlh = nlmsg_hdr(msg);
+	ghdr = nlmsg_data(nlh);
+	ghdr->cmd = NFSD_CMD_LISTENER_GET;
+
+	cb = nl_cb_alloc(NL_CB_CUSTOM);
+	if (!cb) {
+		fprintf(stderr, "failed to allocate netlink callbacks\n");
+		ret = 1;
+		goto out;
+	}
+
+	ret = nl_send_auto(sock, msg);
+	if (ret < 0) {
+		fprintf(stderr, "send failed: %d\n", ret);
+		goto out_cb;
+	}
+
+	ret = 1;
+	nl_cb_err(cb, NL_CB_CUSTOM, error_handler, &ret);
+	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, finish_handler, &ret);
+	nl_cb_set(cb, NL_CB_ACK, NL_CB_CUSTOM, ack_handler, &ret);
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, recv_handler, NULL);
+
+	while (ret > 0)
+		nl_recvmsgs(sock, cb);
+	if (ret < 0) {
+		fprintf(stderr, "Error: %s\n", strerror(-ret));
+		ret = 1;
+	}
+out_cb:
+	nl_cb_put(cb);
+out:
+	nlmsg_free(msg);
+	return ret;
+}
+
+static void print_listeners(void)
+{
+	int i;
+	const char *res;
+
+	for (i = 0; i < MAX_NFSD_SOCKETS; ++i) {
+		struct server_socket *sock = &nfsd_sockets[i];
+		char addr[INET6_ADDRSTRLEN + 1];
+		in_port_t port = 0;
+
+		if (*sock->name == '\0')
+			break;
+
+		if (!sock->active)
+			continue;
+
+		switch(sock->ss.ss_family) {
+		case AF_INET:
+			res = inet_ntop(AF_INET, &((struct sockaddr_in *)(&sock->ss))->sin_addr,
+					addr, INET6_ADDRSTRLEN);
+			port = ((struct sockaddr_in *)(&sock->ss))->sin_port;
+			if (res == NULL)
+				perror("inet_ntop");
+			else
+				printf("%s:%s:%hu\n", sock->name, addr, ntohs(port));
+			break;
+		case AF_INET6:
+			res = inet_ntop(AF_INET6, &((struct sockaddr_in6 *)(&sock->ss))->sin6_addr,
+					addr, INET6_ADDRSTRLEN);
+			port = ((struct sockaddr_in6 *)(&sock->ss))->sin6_port;
+			if (res == NULL)
+				perror("inet_ntop");
+			else
+				printf("%s:[%s]:%hu\n", sock->name, addr, ntohs(port));
+			break;
+		default:
+			snprintf(addr, INET6_ADDRSTRLEN, "Unknown address family: %d\n",
+					sock->ss.ss_family);
+			addr[INET6_ADDRSTRLEN - 1] = '\0';
+		}
+	}
+}
+
+#define BUFLEN (INET6_ADDRSTRLEN + 16)
+
+/*
+ * Format is <+/-><netid>:<address>:port
+ *
+ * + or -: denotes whether we're adding or removing a socket
+ * netid: tcp, udp, rdma (something else in the future?(
+ * address: IPv4 or IPv6 address. IPv6 addr should be in square brackets
+ * port: decimal port value
+ */
+static int update_listeners(const char *str)
+{
+	char buf[INET6_ADDRSTRLEN + 16];
+	char sign = *str;
+	char *netid, *addr, *port, *end;
+	struct addrinfo *res, *ai;
+	int i, ret;
+	struct addrinfo hints = { .ai_flags = AI_PASSIVE,
+				  .ai_family = AF_INET,
+				  .ai_socktype = SOCK_STREAM,
+				  .ai_protocol = IPPROTO_TCP };
+
+	if (sign != '+' && sign != '-')
+		goto out_inval;
+
+	strcpy(buf, str + 1);
+
+	/* netid is start */
+	netid = buf;
+
+	/* find first ':' */
+	addr = strchr(buf, ':');
+	if (!addr)
+		goto out_inval;
+
+	if (addr == buf) {
+		/* empty netid */
+		goto out_inval;
+	}
+	*addr = '\0';
+	++addr;
+
+	port = strrchr(addr, ':');
+	if (!port)
+		goto out_inval;
+	if (port == addr) {
+		/* empty address, give gai a NULL ptr */
+		addr = NULL;
+	}
+	*port = '\0';
+	port++;
+
+	if (*port == '\0') {
+		/* empty port */
+		goto out_inval;
+	}
+
+	/* IPv6 addrs must be in square brackets */
+	if (addr && *addr == '[') {
+		hints.ai_family = AF_INET6;
+		++addr;
+		end = strchr(addr, ']');
+		if (!end)
+			goto out_inval;
+		if (end == addr)
+			addr = NULL;
+		*end = '\0';
+	}
+
+	/*
+	 * If we're looking for wildcard address, look for both
+	 * families.
+	 */
+	if (!addr)
+		hints.ai_family = AF_UNSPEC;
+
+	/*
+	 * Note that we hint for a stream/tcp socket just to limit the number of
+	 * entries that come back. We're only interested in the sockaddrs.
+	 */
+	ret = getaddrinfo(addr, port, &hints, &res);
+	if (ret) {
+		fprintf(stderr, "getaddrinfo of \"%s\" failed: %s\n",
+			addr, gai_strerror(ret));
+		return -EINVAL;
+	}
+
+	for ( ; res; res = res->ai_next) {
+		struct sockaddr_in6 *r6 = (struct sockaddr_in6 *)res->ai_addr;
+		struct sockaddr_in *r4 = (struct sockaddr_in *)res->ai_addr;
+		bool found = false;
+
+		for (i = 0; i < MAX_NFSD_SOCKETS; ++i) {
+			struct server_socket *sock = &nfsd_sockets[i];
+			struct sockaddr_in6 *l6 = (struct sockaddr_in6 *)&sock->ss;
+			struct sockaddr_in *l4 = (struct sockaddr_in *)&sock->ss;
+
+			if (sock->ss.ss_family == AF_UNSPEC)
+				break;
+
+			if (sock->ss.ss_family != res->ai_addr->sa_family)
+				continue;
+
+			if (strcmp(sock->name, netid))
+				continue;
+
+			switch(sock->ss.ss_family) {
+			case AF_INET:
+				if (r4->sin_port != l4->sin_port ||
+				    memcmp(&r4->sin_addr, &l4->sin_addr, sizeof(l4->sin_addr)))
+					continue;
+			case AF_INET6:
+				if (r6->sin6_port != l6->sin6_port ||
+				    memcmp(&r6->sin6_addr, &l6->sin6_addr, sizeof(l6->sin6_addr)))
+					continue;
+			default:
+
 			}
-			nla_put(msg, NFSD_A_SOCK_ADDR, sizeof(sa_storage),
-				&sa_storage);
-			nla_put_string(msg, NFSD_A_SOCK_TRANSPORT_NAME,
-				       transport);
-			nla_nest_end(msg, a);
+			sock->active = (sign == '+');
+			found = true;
 			break;
 		}
-		default:
+		if (!found && sign == '+') {
+			struct server_socket *sock = &nfsd_sockets[nfsd_socket_count];
+
+			memcpy(&sock->ss, res->ai_addr, res->ai_addrlen);
+			strncpy(sock->name, netid, MAX_CLASS_NAME_LEN);
+			sock->name[MAX_CLASS_NAME_LEN - 1] = '\0';
+			sock->active = true;
+			++nfsd_socket_count;
+		}
+	}
+	return 0;
+out_inval:
+	fprintf(stderr, "Invalid listener update string: %s", str);
+	return -EINVAL;
+}
+
+static int set_listeners(struct nl_sock *sock)
+{
+	struct genlmsghdr *ghdr;
+	struct nlmsghdr *nlh;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int i, ret;
+
+	msg = netlink_msg_alloc(sock);
+	if (!msg)
+		return 1;
+
+	nlh = nlmsg_hdr(msg);
+
+	for (i = 0; i < MAX_NFSD_SOCKETS; ++i) {
+		struct server_socket *sock = &nfsd_sockets[i];
+		struct nlattr *a;
+
+		if (sock->ss.ss_family == 0)
 			break;
+
+		if (!sock->active)
+			continue;
+
+		a = nla_nest_start(msg, NLA_F_NESTED | NFSD_A_SERVER_SOCK_ADDR);
+		if (!a) {
+			fprintf(stderr, "Unable to allocate listener nest!\n");
+			ret = 1;
+			goto out;
 		}
+
+		nla_put(msg, NFSD_A_SOCK_ADDR, sizeof(sock->ss), &sock->ss);
+		nla_put_string(msg, NFSD_A_SOCK_TRANSPORT_NAME, sock->name);
+		nla_nest_end(msg, a);
 	}
 
 	ghdr = nlmsg_data(nlh);
-	ghdr->cmd = nl_cmd;
+	ghdr->cmd = NFSD_CMD_LISTENER_SET;
 
 	cb = nl_cb_alloc(NL_CB_CUSTOM);
 	if (!cb) {
-		fprintf(stderr, "failed to allocate netlink callbacks\n");
-		ret = -ENOMEM;
+		fprintf(stderr, "Failed to allocate netlink callbacks\n");
+		ret = 1;
 		goto out;
 	}
 
-	ret = nl_send_auto_complete(sock, msg);
-	if (ret < 0)
+	ret = nl_send_auto(sock, msg);
+	if (ret < 0) {
+		fprintf(stderr, "Send failed: %d\n", ret);
 		goto out_cb;
+	}
 
 	ret = 1;
 	nl_cb_err(cb, NL_CB_CUSTOM, error_handler, &ret);
@@ -521,11 +1059,343 @@ int main(char argc, char **argv)
 
 	while (ret > 0)
 		nl_recvmsgs(sock, cb);
+	if (ret < 0) {
+		fprintf(stderr, "Error: %s\n", strerror(-ret));
+		ret = 1;
+	}
 out_cb:
 	nl_cb_put(cb);
 out:
+	nlmsg_free(msg);
+	return ret;
+}
+
+static void listener_usage(void)
+{
+	printf("Usage: %s listener { {+,-}proto:addr:port } ...\n", taskname);
+	printf("    + to add a listener, - to remove one\n");
+	printf("    @proto: protocol (e.g. tcp, udp, rdma)\n");
+	printf("    @addr: hostname or address to listen on (blank string == wildcard addresses)\n");
+	printf("    @port: port number or service name to listen on\n\n");
+	printf("Examples:\n");
+	printf("    Display currently configured listeners:\n");
+	printf("        listener\n");
+	printf("    Add TCP listener on all addresses (both v4 and v6), port 2049:\n");
+	printf("        listener +tcp::2049\n");
+	printf("    Add RDMA listener on 1.2.3.4 port 20049:\n");
+	printf("        listener +rdma:1.2.3.4:20049\n");
+	printf("    Add same listener on IPv6 address f00::ba4 port 20050:\n");
+	printf("        listener +rdma:[f00::ba4]:20050\n");
+	printf("    Remove UDP listener from nfsserver.example.org, nfs port:\n");
+	printf("        listener -udp:nfsserver.example.org:nfs\n\n");
+}
+
+static int listener_func(struct nl_sock *sock, int argc, char ** argv)
+{
+	char *endptr = NULL;
+	int ret, opt, threads, i;
+	int argidx;
+
+	/* help is only valid as first argument after command */
+	if (argc > 1 &&
+	    (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help"))) {
+		listener_usage();
+		return 0;
+	}
+
+	ret = fetch_current_listeners(sock);
 	if (ret)
-		nlmsg_free(msg);
+		return ret;
+
+	if (argc > 1) {
+		for (i = 1; i < argc; ++i)
+			update_listeners(argv[i]);
+		return set_listeners(sock);
+	}
+
+	print_listeners();
+	return 0;
+}
+
+#define MAX_LISTENER_LEN (64 * 2 + 16)
+
+static int
+add_listener(const char *netid, const char *addr, const char *port)
+{
+		char buf[MAX_LISTENER_LEN];
+		int ret;
+
+		if (strchr(addr, ':'))
+			ret = snprintf(buf, MAX_LISTENER_LEN, "+%s:[%s]:%s",
+					netid, addr, port);
+		else
+			ret = snprintf(buf, MAX_LISTENER_LEN, "+%s:%s:%s",
+					netid, addr, port);
+		buf[MAX_LISTENER_LEN - 1] = '\0';
+		update_listeners(buf);
+}
+
+static void
+read_nfsd_conf(void)
+{
+	conf_init_file(NFS_CONFFILE);
+	xlog_set_debug("nfsd");
+}
+
+static void configure_versions(void)
+{
+	bool v4 = conf_get_bool("nfsd", "vers4", true);
+
+	update_nfsd_version(2, 0, conf_get_bool("nfsd", "vers2", false));
+	update_nfsd_version(3, 0, conf_get_bool("nfsd", "vers3", true));
+	update_nfsd_version(4, 0, v4 && conf_get_bool("nfsd", "vers4.0", true));
+	update_nfsd_version(4, 1, v4 && conf_get_bool("nfsd", "vers4.1", true));
+	update_nfsd_version(4, 2, v4 && conf_get_bool("nfsd", "vers4.2", true));
+}
+
+static void configure_listeners(void)
+{
+	char *port, *rdma_port;
+	bool rdma, udp, tcp;
+	struct conf_list *hosts;
+
+	udp = conf_get_bool("nfsd", "udp", false);
+	tcp = conf_get_bool("nfsd", "tcp", true);
+	port = conf_get_str("nfsd", "port");
+	if (!port)
+		port = "nfs";
+
+	rdma = conf_get_bool("nfsd", "rdma", false);
+	if (rdma) {
+		rdma_port = conf_get_str("nfsd", "rdma-port");
+		if (!rdma_port)
+			rdma_port = "nfsrdma";
+	}
+
+	/* backward compatibility - nfs.conf used to set rdma port directly */
+	if (!rdma_port)
+		rdma_port = conf_get_str("nfsd", "rdma");
+
+	hosts = conf_get_list("nfsd", "host");
+	if (hosts && hosts->cnt) {
+		struct conf_list_node *n;
+		TAILQ_FOREACH(n, &(hosts->fields), link) {
+			if (udp)
+				add_listener("udp", n->field, port);
+			if (tcp)
+				add_listener("tcp", n->field, port);
+			if (rdma)
+				add_listener("rdma", n->field, rdma_port);
+		}
+	} else {
+		if (udp)
+			add_listener("udp", "", port);
+		if (tcp)
+			add_listener("tcp", "", port);
+		if (rdma)
+			add_listener("rdma", "", rdma_port);
+	}
+}
+
+static void autostart_usage(void)
+{
+	printf("Usage: %s autostart\n", taskname);
+	printf("    Start the server with the settings in /etc/nfs.conf.\n");
+}
+
+static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
+{
+	int threads, grace, lease, idx, ret, opt;
+	char *scope;
+
+	optind = 1;
+	while ((opt = getopt_long(argc, argv, "h", help_only_options, NULL)) != -1) {
+		switch (opt) {
+		case 'h':
+			autostart_usage();
+			return 0;
+		}
+	}
+
+	read_nfsd_conf();
+
+	scope = conf_get_str("nfsd", "scope");
+	if (scope) {
+		if (unshare(CLONE_NEWUTS) < 0 ||
+		    sethostname(scope, strlen(scope)) < 0) {
+			fprintf(stderr, "Unable to set server scope: %m");
+			return 1;
+		}
+	}
+
+	ret = fetch_nfsd_versions(sock);
+	if (ret)
+		return ret;
+	configure_versions();
+	ret = set_nfsd_versions(sock);
+	if (ret)
+		return ret;
+
+	configure_listeners();
+	ret = set_listeners(sock);
+	if (ret)
+		return ret;
+
+	grace = conf_get_num("nfsd", "grace-time", 0);
+	lease = conf_get_num("nfsd", "lease-time", 0);
+	threads = conf_get_num("nfsd", "threads", 128);
+	return threads_doit(sock, NFSD_CMD_THREADS_SET, grace, lease, threads);
+}
+
+enum nfsdctl_commands {
+	NFSDCTL_STATUS,
+	NFSDCTL_THREADS,
+	NFSDCTL_VERSION,
+	NFSDCTL_LISTENER,
+	NFSDCTL_AUTOSTART,
+};
+
+static int parse_command(char *str)
+{
+	if (!strcmp(str, "status"))
+		return NFSDCTL_STATUS;
+	if (!strcmp(str, "threads"))
+		return NFSDCTL_THREADS;
+	if (!strcmp(str, "version"))
+		return NFSDCTL_VERSION;
+	if (!strcmp(str, "listener"))
+		return NFSDCTL_LISTENER;
+	if (!strcmp(str, "autostart"))
+		return NFSDCTL_AUTOSTART;
+	return -1;
+}
+
+typedef int (*nfsdctl_func)(struct nl_sock *sock, int argc, char **argv);
+
+static nfsdctl_func func[] = {
+	[NFSDCTL_STATUS] = status_func,
+	[NFSDCTL_THREADS] = threads_func,
+	[NFSDCTL_VERSION] = version_func,
+	[NFSDCTL_LISTENER] = listener_func,
+	[NFSDCTL_AUTOSTART] = autostart_func,
+};
+
+static void usage(void)
+{
+	printf("Usage:\n");
+	printf("%s [-hv] [COMMAND] [ARGS]\n", taskname);
+	printf("  options:\n");
+	printf("    -h | --help          usage info\n");
+	printf("    -d | --debug=NUM     enable debugging\n");
+	printf("    -V | --version       print version info\n");
+	printf("  commands:\n");
+	printf("    listener             get/set listener info\n");
+	printf("    version              get/set supported NFS versions\n");
+	printf("    threads              get/set nfsd thread settings\n");
+	printf("    status               get current RPC processing info\n");
+	printf("    autostart            start server with settings from /etc/nfs.conf\n");
+}
+
+/* Options given before the command string */
+static const struct option pre_options[] = {
+	{ "help", no_argument, NULL, 'h' },
+	{ "debug", required_argument, NULL, 'd' },
+	{ "version", no_argument, NULL, 'V' },
+	{ },
+};
+
+static int run_one_command(struct nl_sock *sock, int argc, char **argv)
+{
+	int cmd = parse_command(argv[0]);
+
+	if (cmd < 0) {
+		usage();
+		return 1;
+	}
+	return func[cmd](sock, argc, argv);
+}
+
+#define MAX_ARGUMENTS 256
+
+static int tokenize_string(char *line, int *argc, char **argv)
+{
+	int idx = 0;
+	char *arg, *save;
+
+	memset(argv, '\0', sizeof(*argv) * MAX_ARGUMENTS);
+
+	arg = strtok_r(line, " \t", &save);
+	while(arg) {
+		argv[idx] = arg;
+		++idx;
+		if (idx >= MAX_ARGUMENTS)
+			return -E2BIG;
+		arg = strtok_r(NULL, " \t", &save);
+	}
+	*argc = idx;
+	return 0;
+}
+
+static int run_commandline(struct nl_sock *sock)
+{
+	char *argv[MAX_ARGUMENTS];
+	char *line;
+	int ret, argc;
+
+	for (;;) {
+		line = readline("nfsdctl> ");
+		if (!line || !strcmp(line, "quit"))
+			break;
+		if (*line == '\0')
+			continue;
+		add_history(line);
+		ret = tokenize_string(line, &argc, argv);
+		if (!ret)
+			ret = run_one_command(sock, argc, argv);
+		if (ret)
+			fprintf(stderr, "Error: %s\n", strerror(ret));
+		free(line);
+	}
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	int opt, ret;
+	struct nl_sock *sock = netlink_sock_alloc();
+
+	if (!sock) {
+		fprintf(stderr, "Unable to allocate netlink socket!");
+		return 1;
+	}
+
+	taskname = argv[0];
+
+	/* Parse the preliminary options */
+	while ((opt = getopt_long(argc, argv, "+hd:V", pre_options, NULL)) != -1) {
+		switch (opt) {
+		case 'h':
+			usage();
+			return 0;
+		case 'd':
+			debug_level = atoi(optarg);
+			break;
+		case 'V':
+			// FIXME: print_version();
+			return 0;
+		}
+	}
+
+	if (optind > argc) {
+		usage();
+		return 1;
+	}
+
+	if (optind == argc)
+		ret = run_commandline(sock);
+	else
+		ret = run_one_command(sock, argc - optind, &argv[optind]);
+
 	nl_socket_free(sock);
 	return ret;
 }
diff --git a/utils/nfsdctl/nfsdctl.h b/utils/nfsdctl/nfsdctl.h
index 6084435c05d9..5f55c5a79f4f 100644
--- a/utils/nfsdctl/nfsdctl.h
+++ b/utils/nfsdctl/nfsdctl.h
@@ -31,6 +31,8 @@ enum {
 
 enum {
 	NFSD_A_SERVER_WORKER_THREADS = 1,
+	NFSD_A_SERVER_WORKER_GRACETIME,
+	NFSD_A_SERVER_WORKER_LEASETIME,
 
 	__NFSD_A_SERVER_WORKER_MAX,
 	NFSD_A_SERVER_WORKER_MAX = (__NFSD_A_SERVER_WORKER_MAX - 1)
@@ -39,6 +41,7 @@ enum {
 enum {
 	NFSD_A_VERSION_MAJOR = 1,
 	NFSD_A_VERSION_MINOR,
+	NFSD_A_VERSION_ENABLED,
 
 	__NFSD_A_VERSION_MAX,
 	NFSD_A_VERSION_MAX = (__NFSD_A_VERSION_MAX - 1)

-- 
2.44.0


