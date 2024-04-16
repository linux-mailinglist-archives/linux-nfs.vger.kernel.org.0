Return-Path: <linux-nfs+bounces-2843-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3BC8A71A9
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Apr 2024 18:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06A31F22273
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Apr 2024 16:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFB9132493;
	Tue, 16 Apr 2024 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dypIdppU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A63686255
	for <linux-nfs@vger.kernel.org>; Tue, 16 Apr 2024 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713286152; cv=none; b=gf/TCjat9+17Ip9u+6FGZsZAbbY1yukfAZOOO2KeDNeDlldWLasLLOwPO0CH/E+DjVDvWZoIgHJmLBRnYNa6/c2MnILUYj2iDkfYaEeTM9tEK+AVZNGsCRfMfXJi9KluqtaDLJ6xEQv4N4/DSMGWijnRn04JRwAYx0Ljhcu9I/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713286152; c=relaxed/simple;
	bh=ScXtFmff0fsV2+xYq8jvW6HK6XPAAFIL+celfMPm5b0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iXmW1ZUTH8J13PBSuXm7f7k4Q3nQj4HX7/0IcgTsWk79dIA1oOi87KdWit0VmNCaJxWEb44kLlMGY6qvhZ+czFGXdfCizyQ2m2qzCxsf/6FkFMhteESuREXri4JmaCEUU3Z+26D8dyGlu75Zi0ouhREqhUY/eiMx+ICRc5wXuOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dypIdppU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740FAC32786;
	Tue, 16 Apr 2024 16:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713286152;
	bh=ScXtFmff0fsV2+xYq8jvW6HK6XPAAFIL+celfMPm5b0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dypIdppUkxx3CWZ+c8EjwoGfHz4JvEF+ik9Pvhh5WocnwbxbAkvMH5tAHo6u0fb2f
	 vWbUPNhwzJxQsh6Kcq5mdbX9GvSYSjq+HU0HkpIpU6Xyqj9N6Yd5OmfYrpZvweYRXr
	 US9nKlZ1F2/YNHhzxUKfooaAqgUYIlQ9n8uAjBSX2H7h53lCXfjAI9HVntYnFbi+Mj
	 7tpA/7yj24j1E7e/m/rUzlDB9xKe8Ki+jshStHvphDoSGATTVvSQRf4pHoV8Lwhqjx
	 k32q1Ofh+lHZ1yQ/Ors6ZHoHsxJfulq4qsaYgLIxlsqE2cVEr+q3VkDDzTSiS3kBiw
	 GlqK463Tf+XYg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Apr 2024 12:48:47 -0400
Subject: [PATCH nfs-utils v2 1/4] nfsdctl: add the nfsdctl utility to
 nfs-utils
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-nfsdctl-v2-1-9a4367b710d2@kernel.org>
References: <20240416-nfsdctl-v2-0-9a4367b710d2@kernel.org>
In-Reply-To: <20240416-nfsdctl-v2-0-9a4367b710d2@kernel.org>
To: Steve Dickson <steved@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Neil Brown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=20248; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=7djCjTlDgQGVvnzzgbNb0txtozj8bnic/+xG0EMruxA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmHqwGzaV4aM/Ejeg0a0+eeE4i7IcjJIVz2aYpD
 sKDPTZnIJaJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZh6sBgAKCRAADmhBGVaC
 FSDZD/4ikPkgTP3NmhPCuNIz4Bl9SlHfc1/SdLg3yA/aygTLCv2NJP0f+YbT8irq1GBvGY7+lGS
 xAguqzCyMm0JCoh+jq5GoL3kxOcTsD6Obcy39CbU5wUiIWmXms+YScFEQduUUAfNym22EXwBlXr
 iUJCSL2fT/KnwfS6uN4oWOftDlMzo2n4Sh6ToaaDJLNF0aMaz2xGBwVV7yZpk7X6kKf0gTcxR9B
 dla/OhfWs8rJhmz6++H1cgobc39v0I78Wcuh9nbtqT0Gs/8w15zFEPhA3tfw7c1X4BGXmnQ5Wg9
 BAv+9KxgWd9UGs8uytv8rLCINc3JSM5wkzR4Ozv10+p16P2loODUOZWWBGXy3i45HLkIY1kg3HB
 rt5ILnPG76ruzCWCen8syxCT7Sf+G/f76hcxAj4kVRetj9TY5JeY6Vo+oFQaPdRk/5rm3JmiFR5
 e53vpkflkaNra3jRq4cMiz+4FQ4K3xzmyHQPHVG7XKvN4pjxEWgmmvnxtla/oaOKl51CbcNmlZI
 rOCo7TiGOjlBttbxIewHiIOWz33Pt24lCa6dL3fK3NyKg1fHPY6hznGhI9WBozBzA3g6EuGasBb
 89WE4ZGS0ivjmcBpgFwO8M1wCNiC9zB2NBzbvlV9faNvwkLp60CIPOPFQdLR1NGnidXtrBw5di7
 uOON4gigg7tZ3Fw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

From: Lorenzo Bianconi <lorenzo@kernel.org>

This is a snapshot of Lorenzo Bianconi's nfsdctl tool[1], integrated
into the nfs-utils tree.

This tool is intended as an eventual replacement for rpc.nfsd that will
use netlink to control and query the kernel nfs server. Add it to the
tree with all of the autoconf stuff necessary for it to build.

[1]: https://github.com/LorenzoBianconi/nfsdctl

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 configure.ac              |  12 ++
 utils/Makefile.am         |   4 +
 utils/nfsdctl/Makefile.am |  10 +
 utils/nfsdctl/nfsdctl.c   | 531 ++++++++++++++++++++++++++++++++++++++++++++++
 utils/nfsdctl/nfsdctl.h   | 183 ++++++++++++++++
 5 files changed, 740 insertions(+)

diff --git a/configure.ac b/configure.ac
index 58d1728c5bc6..ec5eea79a957 100644
--- a/configure.ac
+++ b/configure.ac
@@ -252,6 +252,17 @@ AC_ARG_ENABLE(nfsdcltrack,
 	enable_nfsdcltrack=$enableval,
 	enable_nfsdcltrack="yes")
 
+AC_ARG_ENABLE(nfsdctl,
+	[AS_HELP_STRING([--disable-nfsdctl],[disable nfsdctl program for controlling nfsd@<:@default=no@:>@])],
+	enable_nfsdctl=$enableval,
+	enable_nfsdctl="yes")
+	AM_CONDITIONAL(CONFIG_NFSDCTL, [test "$enable_nfsdctl" = "yes" ])
+	if test "$enable_nfsdctl" = yes; then
+		dnl Check for libnl3
+		PKG_CHECK_MODULES(LIBNL3, libnl-3.0 >= 3.1)
+		PKG_CHECK_MODULES(LIBNLGENL3, libnl-genl-3.0 >= 3.1)
+	fi
+
 AC_ARG_ENABLE(nfsv4server,
 	[AS_HELP_STRING([--enable-nfsv4server],[enable support for NFSv4 only server  @<:@default=no@:>@])],
 	enable_nfsv4server=$enableval,
@@ -739,6 +750,7 @@ AC_CONFIG_FILES([
 	utils/mountd/Makefile
 	utils/exportd/Makefile
 	utils/nfsd/Makefile
+	utils/nfsdctl/Makefile
 	utils/nfsref/Makefile
 	utils/nfsstat/Makefile
 	utils/nfsidmap/Makefile
diff --git a/utils/Makefile.am b/utils/Makefile.am
index ab584190f17e..e5cb81e796bd 100644
--- a/utils/Makefile.am
+++ b/utils/Makefile.am
@@ -35,6 +35,10 @@ if CONFIG_JUNCTION
 OPTDIRS += nfsref
 endif
 
+if CONFIG_NFSDCTL
+OPTDIRS += nfsdctl
+endif
+
 SUBDIRS = \
 	exportfs \
 	mountd \
diff --git a/utils/nfsdctl/Makefile.am b/utils/nfsdctl/Makefile.am
new file mode 100644
index 000000000000..9b8484a81a3f
--- /dev/null
+++ b/utils/nfsdctl/Makefile.am
@@ -0,0 +1,10 @@
+## Process this file with automake to produce Makefile.in
+
+sbin_PROGRAMS	= nfsdctl
+
+noinst_HEADERS = nfsdctl.h
+nfsdctl_SOURCES = nfsdctl.c
+nfsdctl_CFLAGS = $(LIBNL3_CFLAGS) $(LIBNLGENL3_CFLAGS)
+nfsdctl_LDADD = ../../support/nfs/libnfs.la $(LIBNL3_LIBS) $(LIBNLGENL3_LIBS)
+
+MAINTAINERCLEANFILES = Makefile.in
diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
new file mode 100644
index 000000000000..d80a6ef5102b
--- /dev/null
+++ b/utils/nfsdctl/nfsdctl.c
@@ -0,0 +1,531 @@
+#include <linux/module.h>
+#include <linux/version.h>
+#include <netlink/genl/genl.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <time.h>
+#include <stdbool.h>
+#include <arpa/inet.h>
+#include <unistd.h>
+#include <getopt.h>
+
+#include <netlink/genl/family.h>
+#include <netlink/genl/ctrl.h>
+#include <netlink/msg.h>
+#include <netlink/attr.h>
+#include <linux/netlink.h>
+
+#include "nfsdctl.h"
+
+/* compile note:
+ * gcc -I/usr/include/libnl3/ -o <prog-name> <prog-name>.c -lnl-3 -lnl-genl-3
+ */
+
+#define NFSD4_OPS_MAX_LEN	sizeof(nfsd4_ops) / sizeof(nfsd4_ops[0])
+static const char *nfsd4_ops[] = {
+	[OP_ACCESS]		= "OP_ACCESS",
+	[OP_CLOSE]		= "OP_CLOSE",
+	[OP_COMMIT]		= "OP_COMMIT",
+	[OP_CREATE]		= "OP_CREATE",
+	[OP_DELEGRETURN]	= "OP_DELEGRETURN",
+	[OP_GETATTR]		= "OP_GETATTR",
+	[OP_GETFH]		= "OP_GETFH",
+	[OP_LINK]		= "OP_LINK",
+	[OP_LOCK]		= "OP_LOCK",
+	[OP_LOCKT]		= "OP_LOCKT",
+	[OP_LOCKU]		= "OP_LOCKU",
+	[OP_LOOKUP]		= "OP_LOOKUP",
+	[OP_LOOKUPP]		= "OP_LOOKUPP",
+	[OP_NVERIFY]		= "OP_NVERIFY",
+	[OP_OPEN]		= "OP_OPEN",
+	[OP_OPEN_CONFIRM]	= "OP_OPEN_CONFIRM",
+	[OP_OPEN_DOWNGRADE]	= "OP_OPEN_DOWNGRADE",
+	[OP_PUTFH]		= "OP_PUTFH",
+	[OP_PUTPUBFH]		= "OP_PUTPUBFH",
+	[OP_PUTROOTFH]		= "OP_PUTROOTFH",
+	[OP_READ]		= "OP_READ",
+	[OP_READDIR]		= "OP_READDIR",
+	[OP_READLINK]		= "OP_READLINK",
+	[OP_REMOVE]		= "OP_REMOVE",
+	[OP_RENAME]		= "OP_RENAME",
+	[OP_RENEW]		= "OP_RENEW",
+	[OP_RESTOREFH]		= "OP_RESTOREFH",
+	[OP_SAVEFH]		= "OP_SAVEFH",
+	[OP_SECINFO]		= "OP_SECINFO",
+	[OP_SETATTR]		= "OP_SETATTR",
+	[OP_SETCLIENTID]	= "OP_SETCLIENTID",
+	[OP_SETCLIENTID_CONFIRM] = "OP_SETCLIENTID_CONFIRM",
+	[OP_VERIFY]		= "OP_VERIFY",
+	[OP_WRITE]		= "OP_WRITE",
+	[OP_RELEASE_LOCKOWNER]	= "OP_RELEASE_LOCKOWNER",
+	/* NFSv4.1 operations */
+	[OP_EXCHANGE_ID]	= "OP_EXCHANGE_ID",
+	[OP_BACKCHANNEL_CTL]	= "OP_BACKCHANNEL_CTL",
+	[OP_BIND_CONN_TO_SESSION] = "OP_BIND_CONN_TO_SESSION",
+	[OP_CREATE_SESSION]	= "OP_CREATE_SESSION",
+	[OP_DESTROY_SESSION]	= "OP_DESTROY_SESSION",
+	[OP_SEQUENCE]		= "OP_SEQUENCE",
+	[OP_DESTROY_CLIENTID]	= "OP_DESTROY_CLIENTID",
+	[OP_RECLAIM_COMPLETE]	= "OP_RECLAIM_COMPLETE",
+	[OP_SECINFO_NO_NAME]	= "OP_SECINFO_NO_NAME",
+	[OP_TEST_STATEID]	= "OP_TEST_STATEID",
+	[OP_FREE_STATEID]	= "OP_FREE_STATEID",
+	[OP_GETDEVICEINFO]	= "OP_GETDEVICEINFO",
+	[OP_LAYOUTGET]		= "OP_LAYOUTGET",
+	[OP_LAYOUTCOMMIT]	= "OP_LAYOUTCOMMIT",
+	[OP_LAYOUTRETURN]	= "OP_LAYOUTRETURN",
+	/* NFSv4.2 operations */
+	[OP_ALLOCATE]		= "OP_ALLOCATE",
+	[OP_DEALLOCATE]		= "OP_DEALLOCATE",
+	[OP_CLONE]		= "OP_CLONE",
+	[OP_COPY]		= "OP_COPY",
+	[OP_READ_PLUS]		= "OP_READ_PLUS",
+	[OP_SEEK]		= "OP_SEEK",
+	[OP_OFFLOAD_STATUS]	= "OP_OFFLOAD_STATUS",
+	[OP_OFFLOAD_CANCEL]	= "OP_OFFLOAD_CANCEL",
+	[OP_COPY_NOTIFY]	= "OP_COPY_NOTIFY",
+	[OP_GETXATTR]		= "OP_GETXATTR",
+	[OP_SETXATTR]		= "OP_SETXATTR",
+	[OP_LISTXATTRS]		= "OP_LISTXATTRS",
+	[OP_REMOVEXATTR]	= "OP_REMOVEXATTR",
+};
+
+static int error_handler(struct sockaddr_nl *nla, struct nlmsgerr *err,
+			 void *arg)
+{
+	int *ret = arg;
+
+	*ret = err->error;
+	return NL_SKIP;
+}
+
+static int finish_handler(struct nl_msg *msg, void *arg)
+{
+	int *ret = arg;
+
+	*ret = 0;
+	return NL_SKIP;
+}
+
+static int ack_handler(struct nl_msg *msg, void *arg)
+{
+	int *ret = arg;
+
+	*ret = 0;
+	return NL_STOP;
+}
+
+static void parse_rpc_status_get(struct genlmsghdr *gnlh)
+{
+	struct nlattr *attr;
+	int rem;
+
+	nla_for_each_attr(attr, genlmsg_attrdata(gnlh, 0),
+			  genlmsg_attrlen(gnlh, 0), rem) {
+		switch (nla_type(attr)) {
+		case NFSD_A_RPC_STATUS_XID:
+		case NFSD_A_RPC_STATUS_FLAGS:
+			printf(" 0x%08x", nla_get_u32(attr));
+			break;
+		case NFSD_A_RPC_STATUS_PROC:
+		case NFSD_A_RPC_STATUS_PROG:
+			printf(" %d", nla_get_u32(attr));
+			break;
+		case NFSD_A_RPC_STATUS_VERSION:
+			printf(" NFS%d", nla_get_u8(attr));
+			break;
+		case NFSD_A_RPC_STATUS_SERVICE_TIME:
+			printf(" %ld", nla_get_u64(attr));
+			break;
+		case NFSD_A_RPC_STATUS_DADDR4:
+		case NFSD_A_RPC_STATUS_SADDR4: {
+			struct in_addr addr = {
+				.s_addr = nla_get_u32(attr),
+			};
+
+			printf(" %s", inet_ntoa(addr));
+			break;
+		}
+		case NFSD_A_RPC_STATUS_DPORT:
+		case NFSD_A_RPC_STATUS_SPORT:
+			printf(" %hu", nla_get_u16(attr));
+			break;
+		case NFSD_A_RPC_STATUS_COMPOUND_OPS: {
+			unsigned int op = nla_get_u32(attr);
+
+			if (op < NFSD4_OPS_MAX_LEN)
+				printf(" %s", nfsd4_ops[op]);
+			break;
+		}
+		default:
+			break;
+		}
+	}
+	printf("\n");
+}
+
+static void parse_version_get(struct genlmsghdr *gnlh)
+{
+	struct nlattr *attr;
+	int rem;
+
+	printf("Server Versions:");
+	nla_for_each_attr(attr, genlmsg_attrdata(gnlh, 0),
+			  genlmsg_attrlen(gnlh, 0), rem) {
+		struct nlattr *a;
+		int i;
+
+		nla_for_each_nested(a, attr, i) {
+			switch (nla_type(a)) {
+			case NFSD_A_VERSION_MAJOR:
+				printf("\t%d", nla_get_u32(a));
+				break;
+			case NFSD_A_VERSION_MINOR:
+				printf(":%d", nla_get_u32(a));
+				break;
+			default:
+				break;
+			}
+		}
+	}
+	printf("\n");
+}
+
+static void parse_listener_get(struct genlmsghdr *gnlh)
+{
+	int rem, major, minor;
+	struct nlattr *attr;
+
+	printf("Server Listeners:");
+	nla_for_each_attr(attr, genlmsg_attrdata(gnlh, 0),
+			  genlmsg_attrlen(gnlh, 0), rem) {
+		unsigned short proto = 0;
+		const char *name = NULL;
+		unsigned port = 0;
+		struct nlattr *a;
+		int i;
+
+		nla_for_each_nested(a, attr, i) {
+			switch (nla_type(a)) {
+			case NFSD_A_LISTENER_TRANSPORT_NAME:
+				name = nla_data(a);
+				break;
+			case NFSD_A_LISTENER_PORT:
+				port = nla_get_u32(a);
+				break;
+			case NFSD_A_LISTENER_INET_PROTO:
+				proto = nla_get_u16(a);
+				break;
+			default:
+				break;
+			}
+		}
+
+		if (name && port && proto)
+			printf("\n\t%s%s:%d",
+			       name, proto == AF_INET6 ? "6" : "4", port);
+	}
+	printf("\n");
+}
+
+static int recv_handler(struct nl_msg *msg, void *arg)
+{
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	const struct nlattr *attr = genlmsg_attrdata(gnlh, 0);
+
+	switch (gnlh->cmd) {
+	case NFSD_CMD_RPC_STATUS_GET:
+		parse_rpc_status_get(gnlh);
+		break;
+	case NFSD_CMD_THREADS_GET:
+		if (nla_type(attr) == NFSD_A_SERVER_WORKER_THREADS)
+			printf("Running threads\t: %d\n", nla_get_u32(attr));
+		break;
+	case NFSD_CMD_VERSION_GET:
+		parse_version_get(gnlh);
+		break;
+	case NFSD_CMD_LISTENER_GET:
+		parse_listener_get(gnlh);
+		break;
+	default:
+		break;
+	}
+
+	return NL_SKIP;
+}
+
+static const struct option long_options[] = {
+	{ "help", no_argument, NULL, 'h'		},
+	{ "rpc-status", no_argument, NULL, 'R'		},
+	{ "set-threads", required_argument, NULL, 't'	},
+	{ "get-threads", no_argument, NULL, 'T'		},
+	{ "set-version", required_argument, NULL, 'v'	},
+	{ "get-versions", no_argument, NULL, 'V'	},
+	{ "set-sockaddr", required_argument, NULL, 's'	},
+	{ "set-listener", required_argument, NULL, 'p'	},
+	{ "get-listeners", no_argument, NULL, 'P'	},
+	{ },
+};
+
+static int get_cmd_type(int arg)
+{
+	switch (arg) {
+	case 'R':
+		return NFSD_CMD_RPC_STATUS_GET;
+	case 't':
+		return NFSD_CMD_THREADS_SET;
+	case 'T':
+		return NFSD_CMD_THREADS_GET;
+	case 'v':
+		return NFSD_CMD_VERSION_SET;
+	case 'V':
+		return NFSD_CMD_VERSION_GET;
+	case 'p':
+		return NFSD_CMD_LISTENER_SET;
+	case 'P':
+		return NFSD_CMD_LISTENER_GET;
+	case 's':
+		return NFSD_CMD_SOCK_SET;
+	case 'h':
+	default:
+		return -EINVAL;
+	}
+}
+
+static void usage(char *argv[], const struct option *long_options)
+{
+	int i;
+
+	printf("\nOption for %s:\n", argv[0]);
+	for (i = 0; long_options[i].name != 0; i++) {
+		printf(" --%-15s", long_options[i].name);
+		if (long_options[i].flag != NULL)
+			printf(" flag (internal value: %d)",
+			       *long_options[i].flag);
+		else
+			printf("\t short-option: -%c", long_options[i].val);
+		printf("\n");
+	}
+	printf("\n");
+}
+
+#define BUFFER_SIZE	8192
+static struct nl_msg *netlink_sock_and_msg_alloc(struct nl_sock **sock)
+{
+	struct nl_msg *msg = NULL;
+	int ret, id;
+
+	*sock = nl_socket_alloc();
+	if (!(*sock))
+		return NULL;
+
+	if (genl_connect(*sock)) {
+		fprintf(stderr, "Failed to connect to generic netlink\n");
+		goto error;
+	}
+
+	nl_socket_set_buffer_size(*sock, BUFFER_SIZE, BUFFER_SIZE);
+	setsockopt(nl_socket_get_fd(*sock), SOL_NETLINK, NETLINK_EXT_ACK,
+		   &ret, sizeof(ret));
+
+	id = genl_ctrl_resolve(*sock, NFSD_FAMILY_NAME);
+	if (id < 0) {
+		fprintf(stderr, "%s not found\n", NFSD_FAMILY_NAME);
+		goto error;
+	}
+
+	msg = nlmsg_alloc();
+	if (!msg) {
+		fprintf(stderr, "failed to allocate netlink message\n");
+		goto error;
+	}
+
+	if (!genlmsg_put(msg, 0, 0, id, 0, 0, 0, 0)) {
+		fprintf(stderr, "failed to allocate netlink message\n");
+		goto error;
+	}
+
+	return msg;
+error:
+	nl_socket_free(*sock);
+	nlmsg_free(msg);
+	return NULL;
+}
+
+int main(char argc, char **argv)
+{
+	int port, proto, nl_cmd = 0, longindex = 0, opt, ret = 1;
+	char transport[64], addr[64];
+	struct genlmsghdr *ghdr;
+	struct nlmsghdr *nlh;
+	struct nl_sock *sock;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+
+	if (argc == 1) {
+		usage(argv, long_options);
+		return -EINVAL;
+	}
+
+	msg = netlink_sock_and_msg_alloc(&sock);
+	if (!msg)
+		return -ENOMEM;
+
+	ret = EINVAL;
+	nlh = nlmsg_hdr(msg);
+
+	while ((opt = getopt_long(argc, argv, "Rt:Tv:Vp:Ps:h",
+				  long_options, &longindex)) != -1) {
+		int cmd = get_cmd_type(opt);
+		struct nlattr *a;
+
+		if (cmd < 0) {
+			usage(argv, long_options);
+			goto out;
+		}
+
+		if (nl_cmd && cmd != nl_cmd) {
+			usage(argv, long_options);
+			goto out;
+		}
+
+		nl_cmd = cmd;
+		switch (nl_cmd) {
+		case NFSD_CMD_RPC_STATUS_GET:
+			nlh->nlmsg_flags |= NLM_F_DUMP;
+			break;
+		case NFSD_CMD_THREADS_SET: {
+			int thread = strtoul(optarg, NULL, 0);
+
+			nla_put_u32(msg, NFSD_A_SERVER_WORKER_THREADS, thread);
+			break;
+		}
+		case NFSD_CMD_VERSION_SET: {
+			int major, minor;
+
+			if (sscanf(optarg, "%d.%d", &major, &minor) != 2) {
+				usage(argv, long_options);
+				goto out;
+			}
+
+
+			a = nla_nest_start(msg,
+					   NLA_F_NESTED | NFSD_A_SERVER_PROTO_VERSION);
+			if (!a) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			nla_put_u32(msg, NFSD_A_VERSION_MAJOR, major);
+			nla_put_u32(msg, NFSD_A_VERSION_MINOR, minor);
+			nla_nest_end(msg, a);
+			break;
+		}
+		case NFSD_CMD_LISTENER_SET:
+			if (sscanf(optarg, "%s.%d.%d",
+				   transport, &port, &proto) != 3) {
+				usage(argv, long_options);
+				goto out;
+			}
+
+
+			a = nla_nest_start(msg,
+					   NLA_F_NESTED | NFSD_A_SERVER_LISTENER_INSTANCE);
+			if (!a) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			nla_put_string(msg, NFSD_A_LISTENER_TRANSPORT_NAME,
+				       transport);
+			nla_put_u32(msg, NFSD_A_LISTENER_PORT, port);
+			nla_put_u16(msg, NFSD_A_LISTENER_INET_PROTO, proto);
+			nla_nest_end(msg, a);
+			break;
+		case NFSD_CMD_SOCK_SET: {
+			struct sockaddr_storage sa_storage = {};
+
+			if (sscanf(optarg, "[%s].%s.%d.%d",
+				   addr, &port, transport, &proto) != 4) {
+				usage(argv, long_options);
+				goto out;
+			}
+
+			switch (proto) {
+			case AF_INET: {
+				struct sockaddr_in *sin = (void *)&sa_storage;
+
+				sin->sin_family = AF_INET;
+				sin->sin_port = htons(port);
+				if (inet_pton(AF_INET, addr,
+					      &sin->sin_addr) != 1) {
+					ret = -EINVAL;
+					goto out;
+				}
+				break;
+			}
+			case AF_INET6: {
+				struct sockaddr_in6 *sin6 = (void *)&sa_storage;
+
+				sin6->sin6_family = AF_INET6;
+				sin6->sin6_port = htons(port);
+				if (inet_pton(AF_INET6, addr,
+					      &sin6->sin6_addr) != 1) {
+					ret = -EINVAL;
+					goto out;
+				}
+				break;
+			}
+			default:
+				ret = -EINVAL;
+				goto out;
+			}
+
+			a = nla_nest_start(msg,
+					   NLA_F_NESTED | NFSD_A_SERVER_SOCK_ADDR);
+			if (!a) {
+				ret = -ENOMEM;
+				goto out_cb;
+			}
+			nla_put(msg, NFSD_A_SOCK_ADDR, sizeof(sa_storage),
+				&sa_storage);
+			nla_put_string(msg, NFSD_A_SOCK_TRANSPORT_NAME,
+				       transport);
+			nla_nest_end(msg, a);
+			break;
+		}
+		default:
+			break;
+		}
+	}
+
+	ghdr = nlmsg_data(nlh);
+	ghdr->cmd = nl_cmd;
+
+	cb = nl_cb_alloc(NL_CB_CUSTOM);
+	if (!cb) {
+		fprintf(stderr, "failed to allocate netlink callbacks\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = nl_send_auto_complete(sock, msg);
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
+out_cb:
+	nl_cb_put(cb);
+out:
+	if (ret)
+		nlmsg_free(msg);
+	nl_socket_free(sock);
+	return ret;
+}
diff --git a/utils/nfsdctl/nfsdctl.h b/utils/nfsdctl/nfsdctl.h
new file mode 100644
index 000000000000..6084435c05d9
--- /dev/null
+++ b/utils/nfsdctl/nfsdctl.h
@@ -0,0 +1,183 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/nfsd.yaml */
+/* YNL-GEN uapi header */
+
+#ifndef _UAPI_LINUX_NFSD_H
+#define _UAPI_LINUX_NFSD_H
+
+#define NFSD_FAMILY_NAME	"nfsd"
+#define NFSD_FAMILY_VERSION	1
+
+enum {
+	NFSD_A_RPC_STATUS_XID = 1,
+	NFSD_A_RPC_STATUS_FLAGS,
+	NFSD_A_RPC_STATUS_PROG,
+	NFSD_A_RPC_STATUS_VERSION,
+	NFSD_A_RPC_STATUS_PROC,
+	NFSD_A_RPC_STATUS_SERVICE_TIME,
+	NFSD_A_RPC_STATUS_PAD,
+	NFSD_A_RPC_STATUS_SADDR4,
+	NFSD_A_RPC_STATUS_DADDR4,
+	NFSD_A_RPC_STATUS_SADDR6,
+	NFSD_A_RPC_STATUS_DADDR6,
+	NFSD_A_RPC_STATUS_SPORT,
+	NFSD_A_RPC_STATUS_DPORT,
+	NFSD_A_RPC_STATUS_COMPOUND_OPS,
+
+	__NFSD_A_RPC_STATUS_MAX,
+	NFSD_A_RPC_STATUS_MAX = (__NFSD_A_RPC_STATUS_MAX - 1)
+};
+
+enum {
+	NFSD_A_SERVER_WORKER_THREADS = 1,
+
+	__NFSD_A_SERVER_WORKER_MAX,
+	NFSD_A_SERVER_WORKER_MAX = (__NFSD_A_SERVER_WORKER_MAX - 1)
+};
+
+enum {
+	NFSD_A_VERSION_MAJOR = 1,
+	NFSD_A_VERSION_MINOR,
+
+	__NFSD_A_VERSION_MAX,
+	NFSD_A_VERSION_MAX = (__NFSD_A_VERSION_MAX - 1)
+};
+
+enum {
+	NFSD_A_SERVER_PROTO_VERSION = 1,
+
+	__NFSD_A_SERVER_PROTO_MAX,
+	NFSD_A_SERVER_PROTO_MAX = (__NFSD_A_SERVER_PROTO_MAX - 1)
+};
+
+enum {
+	NFSD_A_LISTENER_TRANSPORT_NAME = 1,
+	NFSD_A_LISTENER_PORT,
+	NFSD_A_LISTENER_INET_PROTO,
+
+	__NFSD_A_LISTENER_MAX,
+	NFSD_A_LISTENER_MAX = (__NFSD_A_LISTENER_MAX - 1)
+};
+
+enum {
+	NFSD_A_SERVER_LISTENER_INSTANCE = 1,
+
+	__NFSD_A_SERVER_LISTENER_MAX,
+	NFSD_A_SERVER_LISTENER_MAX = (__NFSD_A_SERVER_LISTENER_MAX - 1)
+};
+
+enum {
+	NFSD_A_SOCK_ADDR = 1,
+	NFSD_A_SOCK_TRANSPORT_NAME,
+
+	__NFSD_A_SOCK_MAX,
+	NFSD_A_SOCK_MAX = (__NFSD_A_SOCK_MAX - 1)
+};
+
+enum {
+	NFSD_A_SERVER_SOCK_ADDR = 1,
+
+	__NFSD_A_SERVER_SOCK_MAX,
+	NFSD_A_SERVER_SOCK_MAX = (__NFSD_A_SERVER_SOCK_MAX - 1)
+};
+
+enum {
+	NFSD_CMD_RPC_STATUS_GET = 1,
+	NFSD_CMD_THREADS_SET,
+	NFSD_CMD_THREADS_GET,
+	NFSD_CMD_VERSION_SET,
+	NFSD_CMD_VERSION_GET,
+	NFSD_CMD_LISTENER_SET,
+	NFSD_CMD_LISTENER_GET,
+	NFSD_CMD_SOCK_SET,
+
+	__NFSD_CMD_MAX,
+	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
+};
+
+enum nfs_opnum4 {
+	OP_ACCESS = 3,
+	OP_CLOSE = 4,
+	OP_COMMIT = 5,
+	OP_CREATE = 6,
+	OP_DELEGPURGE = 7,
+	OP_DELEGRETURN = 8,
+	OP_GETATTR = 9,
+	OP_GETFH = 10,
+	OP_LINK = 11,
+	OP_LOCK = 12,
+	OP_LOCKT = 13,
+	OP_LOCKU = 14,
+	OP_LOOKUP = 15,
+	OP_LOOKUPP = 16,
+	OP_NVERIFY = 17,
+	OP_OPEN = 18,
+	OP_OPENATTR = 19,
+	OP_OPEN_CONFIRM = 20,
+	OP_OPEN_DOWNGRADE = 21,
+	OP_PUTFH = 22,
+	OP_PUTPUBFH = 23,
+	OP_PUTROOTFH = 24,
+	OP_READ = 25,
+	OP_READDIR = 26,
+	OP_READLINK = 27,
+	OP_REMOVE = 28,
+	OP_RENAME = 29,
+	OP_RENEW = 30,
+	OP_RESTOREFH = 31,
+	OP_SAVEFH = 32,
+	OP_SECINFO = 33,
+	OP_SETATTR = 34,
+	OP_SETCLIENTID = 35,
+	OP_SETCLIENTID_CONFIRM = 36,
+	OP_VERIFY = 37,
+	OP_WRITE = 38,
+	OP_RELEASE_LOCKOWNER = 39,
+
+	/* nfs41 */
+	OP_BACKCHANNEL_CTL = 40,
+	OP_BIND_CONN_TO_SESSION = 41,
+	OP_EXCHANGE_ID = 42,
+	OP_CREATE_SESSION = 43,
+	OP_DESTROY_SESSION = 44,
+	OP_FREE_STATEID = 45,
+	OP_GET_DIR_DELEGATION = 46,
+	OP_GETDEVICEINFO = 47,
+	OP_GETDEVICELIST = 48,
+	OP_LAYOUTCOMMIT = 49,
+	OP_LAYOUTGET = 50,
+	OP_LAYOUTRETURN = 51,
+	OP_SECINFO_NO_NAME = 52,
+	OP_SEQUENCE = 53,
+	OP_SET_SSV = 54,
+	OP_TEST_STATEID = 55,
+	OP_WANT_DELEGATION = 56,
+	OP_DESTROY_CLIENTID = 57,
+	OP_RECLAIM_COMPLETE = 58,
+
+	/* nfs42 */
+	OP_ALLOCATE = 59,
+	OP_COPY = 60,
+	OP_COPY_NOTIFY = 61,
+	OP_DEALLOCATE = 62,
+	OP_IO_ADVISE = 63,
+	OP_LAYOUTERROR = 64,
+	OP_LAYOUTSTATS = 65,
+	OP_OFFLOAD_CANCEL = 66,
+	OP_OFFLOAD_STATUS = 67,
+	OP_READ_PLUS = 68,
+	OP_SEEK = 69,
+	OP_WRITE_SAME = 70,
+	OP_CLONE = 71,
+
+	/* xattr support (RFC8726) */
+	OP_GETXATTR                = 72,
+	OP_SETXATTR                = 73,
+	OP_LISTXATTRS              = 74,
+	OP_REMOVEXATTR             = 75,
+
+	OP_ILLEGAL = 10044,
+};
+
+#endif /* _UAPI_LINUX_NFSD_H */

-- 
2.44.0


