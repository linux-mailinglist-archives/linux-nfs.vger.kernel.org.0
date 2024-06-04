Return-Path: <linux-nfs+bounces-3556-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E9C8FBE7D
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2024 00:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4D8FB21F97
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 22:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BBF132135;
	Tue,  4 Jun 2024 22:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXhq9Lkq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1BE320C
	for <linux-nfs@vger.kernel.org>; Tue,  4 Jun 2024 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717538865; cv=none; b=UvN9sOAZZrXzyVM8uK3FoW2ac8lt6n7ek/poLed1Jy5JL3xM3fa2zRgC+NmHcEYWlkkRYQxJHMzHB8S97sppiLIOVSR10itJBslxsBv88wEcF4i24Ct7bCsFNKK+YuK/GxWEgEF7YVSamZ1UAWdEM8oYKWaF8+cddc0kZkqiNEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717538865; c=relaxed/simple;
	bh=2eOOVCjUt/GCf9FGv8zEW4pxdV50jeVdHDATqm6mfrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JJnB4CIi1BQ3wj26RvykeIoxyPFmKHEeeXUcmQlS5CATUXF5l6K2wPJpIgySorpsCGV0GMXu3SuF7v1h8ec3fWkm6ISqf0e98vr2H4FBTI/4Nl5eJV3242dQUA4q0ZUr3fiomcqebFJeZbqrmyhnbo+imX2Og7DLDcIryddUQ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXhq9Lkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A87C3277B;
	Tue,  4 Jun 2024 22:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717538864;
	bh=2eOOVCjUt/GCf9FGv8zEW4pxdV50jeVdHDATqm6mfrc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MXhq9LkqscntvccYUoPiN10vmU8EKF4LbY6rupxk9NJOX7JMquiA5KQDm6o8SkcGP
	 dYSiGd+q7oBKWWZLtQdNtZeu1iZLL+1plVc1bOpii3cXHNXIkOkYO1MtzwZkrqOJJf
	 6gs/4dyIBfj1PsFTcYsB0MG/1qjUDRQWWbKqNzNAu4irhKxfI3J7V29mqXIF39lS6n
	 1Gfj5+uEUXGE7+w/czH2xVc0Cyn9KIpEsubpludbXNbOhMeoE7GXXR4kDBZrxXDIVF
	 6viGJa2mN6GTnqV6spFsMGalMGfpeWA0zenB1WGrniF/pokBl8vPzuD0WOZ7T3rVYJ
	 VbBu4WCfYmLrA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 04 Jun 2024 18:07:29 -0400
Subject: [PATCH nfs-utils v4 1/3] nfsdctl: add the nfsdctl utility to
 nfs-utils
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-nfsdctl-v4-1-a2941f782e4c@kernel.org>
References: <20240604-nfsdctl-v4-0-a2941f782e4c@kernel.org>
In-Reply-To: <20240604-nfsdctl-v4-0-a2941f782e4c@kernel.org>
To: Steve Dickson <steved@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Neil Brown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=50158; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=hz0C7GGwcy2FZr1TqTwtPKAjHyZvj/NQG9yoPEcvySA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmX5Au7K9yrkw/EP+UO3AKsOZzU/dJRC6JB1+B1
 VQ7paxsxKuJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZl+QLgAKCRAADmhBGVaC
 FV2JD/4y0mDeruc0iEZyBUzL+Y0RLjHd98oGQuC3x5chXErX26XoRRfUM20gQeJcV+uIC8ovTdO
 5p/206ueWCrEH4Ip663eFvSX9SLRRIkGh77kLHCkf0Hn1CfQhiBnMq5yW7TFZ+wu+QLgIBsKasr
 Ka/z9SFf8j1dAwml/7tPSaORv9OsVARLzp7AU9TWTmk/4GeXtlHHU1x4qmbcJct21sTF8EWuxR2
 +0ZJVJLjdNGfU+L6jCLAsNUe91N5Y3yIlVYRop0kMfeBNFIsmmmRJ6yKxBN5PQ2tGA6M5CHNkv+
 3updQrs/QNHR9qHhlUUiax30gWBgz78GQHcnu9l7XBiifguQhCq7fqUCqD/t2SM1LYO6wRPcxGP
 xYRXk4IdhPtJ5xkfRf5hD+EntdejQZhzelHmoRoAuo4wJsTgvrGGnLSxP9RI2gDykcwr/m8H0AF
 9De4KFYhVodSs924ssulJLYlSDCpeQn/0INex0sijuyikyky4PXYzgOw5oETaZAcACCcwlAYxjl
 1medJ/S74BaKL9ZVrQJ8J/RWH3ro4pGWKdEn1JkEt8Du3HZDrBCIEoDgVoQG/dJkKTqJhOyGJnz
 5U4lxR1Am6A82PpKv4idD2oF2wUgqCLu8/B/rTnlx9kGqAjkjWwUTmQq7aZ/IN9UbxzEC0F98Qc
 6DoHuZv05qppAiA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

From: Lorenzo Bianconi <lorenzo@kernel.org>

This tool is based on Lorenzo's original nfsdctl tool [1]. His original
tool used getopt_long to indicate the command, but that's somewhat
limiting. This converts it to a subcommand-based interface, where each
subcommand can take its own options, in the spirit of commands like
nmcli or virsh.

There are currently 5 different subcommands:

    listener             get/set listener info
    version              get/set supported NFS versions
    threads              get/set nfsd thread settings
    status               get current RPC processing info
    autostart            start server with settings from /etc/nfs.conf

Each can take different options, and we can expand this interface later
with more commands as necessary.

[1]: https://github.com/LorenzoBianconi/nfsdctl

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 configure.ac                 |   13 +
 utils/Makefile.am            |    4 +
 utils/nfsdctl/Makefile.am    |   13 +
 utils/nfsdctl/nfsd_netlink.h |   86 +++
 utils/nfsdctl/nfsdctl.8      |  274 ++++++++
 utils/nfsdctl/nfsdctl.c      | 1450 ++++++++++++++++++++++++++++++++++++++++++
 utils/nfsdctl/nfsdctl.h      |   93 +++
 7 files changed, 1933 insertions(+)

diff --git a/configure.ac b/configure.ac
index 58d1728c5bc6..f965865465ae 100644
--- a/configure.ac
+++ b/configure.ac
@@ -252,6 +252,18 @@ AC_ARG_ENABLE(nfsdcltrack,
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
+		PKG_CHECK_MODULES(LIBREADLINE, readline)
+	fi
+
 AC_ARG_ENABLE(nfsv4server,
 	[AS_HELP_STRING([--enable-nfsv4server],[enable support for NFSv4 only server  @<:@default=no@:>@])],
 	enable_nfsv4server=$enableval,
@@ -739,6 +751,7 @@ AC_CONFIG_FILES([
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
index 000000000000..89c7ecd6f30b
--- /dev/null
+++ b/utils/nfsdctl/Makefile.am
@@ -0,0 +1,13 @@
+## Process this file with automake to produce Makefile.in
+
+man8_MANS       = nfsdctl.8
+EXTRA_DIST      = $(man8_MANS)
+
+sbin_PROGRAMS	= nfsdctl
+
+noinst_HEADERS = nfsdctl.h
+nfsdctl_SOURCES = nfsdctl.c
+nfsdctl_CFLAGS = $(LIBNL3_CFLAGS) $(LIBNLGENL3_CFLAGS) $(LIBREADLINE_CFLAGS)
+nfsdctl_LDADD = ../../support/nfs/libnfs.la $(LIBNL3_LIBS) $(LIBNLGENL3_LIBS) $(LIBREADLINE_LIBS)
+
+MAINTAINERCLEANFILES = Makefile.in
diff --git a/utils/nfsdctl/nfsd_netlink.h b/utils/nfsdctl/nfsd_netlink.h
new file mode 100644
index 000000000000..24c86dbc7ed5
--- /dev/null
+++ b/utils/nfsdctl/nfsd_netlink.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/nfsd.yaml */
+/* YNL-GEN uapi header */
+
+#ifndef _UAPI_LINUX_NFSD_NETLINK_H
+#define _UAPI_LINUX_NFSD_NETLINK_H
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
+	NFSD_A_SERVER_THREADS = 1,
+	NFSD_A_SERVER_GRACETIME,
+	NFSD_A_SERVER_LEASETIME,
+	NFSD_A_SERVER_SCOPE,
+
+	__NFSD_A_SERVER_MAX,
+	NFSD_A_SERVER_MAX = (__NFSD_A_SERVER_MAX - 1)
+};
+
+enum {
+	NFSD_A_VERSION_MAJOR = 1,
+	NFSD_A_VERSION_MINOR,
+	NFSD_A_VERSION_ENABLED,
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
+
+	__NFSD_CMD_MAX,
+	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
+};
+
+#endif /* _UAPI_LINUX_NFSD_NETLINK_H */
diff --git a/utils/nfsdctl/nfsdctl.8 b/utils/nfsdctl/nfsdctl.8
new file mode 100644
index 000000000000..7f5d981042a5
--- /dev/null
+++ b/utils/nfsdctl/nfsdctl.8
@@ -0,0 +1,274 @@
+'\" t
+.\"     Title: nfsdctl
+.\"    Author: Jeff Layton
+.\" Generator: Asciidoctor 2.0.20
+.\"      Date: 2024-04-23
+.\"    Manual: \ \&
+.\"    Source: \ \&
+.\"  Language: English
+.\"
+.TH "NFSDCTL" "8" "2024-04-23" "\ \&" "\ \&"
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
+Get/set the number of running nfsd threads in each pool. Pass a list of
+integers to change the currently active number of threads. Passing it a
+value of 0 will shut down the NFS server. Run this without arguments to
+get the current number of running threads in each pool.
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
+Change the number of running threads in first pool to 256:
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
new file mode 100644
index 000000000000..90c524a470ec
--- /dev/null
+++ b/utils/nfsdctl/nfsdctl.c
@@ -0,0 +1,1450 @@
+#define _GNU_SOURCE 1
+#include <linux/module.h>
+#include <linux/version.h>
+#include <netlink/genl/genl.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <time.h>
+#include <stdbool.h>
+#include <arpa/inet.h>
+#include <unistd.h>
+#include <getopt.h>
+#include <string.h>
+#include <sched.h>
+#include <sys/queue.h>
+
+#include <netlink/genl/family.h>
+#include <netlink/genl/ctrl.h>
+#include <netlink/msg.h>
+#include <netlink/attr.h>
+#include <linux/netlink.h>
+
+#include <readline/readline.h>
+#include <readline/history.h>
+
+#include "nfsd_netlink.h"
+#include "nfsdctl.h"
+#include "conffile.h"
+#include "xlog.h"
+
+/* compile note:
+ * gcc -I/usr/include/libnl3/ -o <prog-name> <prog-name>.c -lnl-3 -lnl-genl-3
+ */
+
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
+	int rem, idx = 0;
+
+	/* clear the nfsd_versions array */
+	memset(nfsd_versions, '\0', sizeof(*nfsd_versions) * MAX_NFS_VERSIONS);
+
+	nla_for_each_attr(attr, genlmsg_attrdata(gnlh, 0),
+			  genlmsg_attrlen(gnlh, 0), rem) {
+		struct nlattr *a;
+		int i;
+
+		nla_for_each_nested(a, attr, i) {
+			switch (nla_type(a)) {
+			case NFSD_A_VERSION_MAJOR:
+				nfsd_versions[idx].major = nla_get_u32(a);
+				break;
+			case NFSD_A_VERSION_MINOR:
+				nfsd_versions[idx].minor = nla_get_u32(a);
+				break;
+			case NFSD_A_VERSION_ENABLED:
+				nfsd_versions[idx].enabled = nla_get_flag(a);
+				break;
+			default:
+				break;
+			}
+		}
+		++idx;
+	}
+}
+
+static void parse_listener_get(struct genlmsghdr *gnlh)
+{
+	struct nlattr *attr;
+	int rem, idx = 0;
+
+	/* clear the nfsd_sockets array */
+	memset(nfsd_sockets, '\0', sizeof(*nfsd_sockets) * MAX_NFSD_SOCKETS);
+
+	nla_for_each_attr(attr, genlmsg_attrdata(gnlh, 0),
+			  genlmsg_attrlen(gnlh, 0), rem) {
+		struct nlattr *a;
+		char *res;
+		int i;
+
+		nla_for_each_nested(a, attr, i) {
+			switch (nla_type(a)) {
+			case NFSD_A_SOCK_TRANSPORT_NAME:
+				res = strncpy(nfsd_sockets[idx].name, nla_data(a),
+					      MAX_CLASS_NAME_LEN);
+				res[MAX_CLASS_NAME_LEN - 1] = '\0'; // just to be sure
+				break;
+			case NFSD_A_SOCK_ADDR:
+				memcpy(&nfsd_sockets[idx].ss, nla_data(a),
+					sizeof(nfsd_sockets[idx].ss));
+				break;
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
+	int rem, pools = 0, i = 0;
+	uint32_t *pool_threads = NULL;
+
+	nla_for_each_attr(attr, genlmsg_attrdata(gnlh, 0),
+			  genlmsg_attrlen(gnlh, 0), rem)
+		if (nla_type(attr) == NFSD_A_SERVER_THREADS)
+			++pools;
+
+	pool_threads = alloca(pools * sizeof(*pool_threads));
+
+	nla_for_each_attr(attr, genlmsg_attrdata(gnlh, 0),
+			  genlmsg_attrlen(gnlh, 0), rem) {
+		struct nlattr *a;
+
+		switch (nla_type(attr)) {
+			case NFSD_A_SERVER_GRACETIME:
+				printf("gracetime: %u\n", nla_get_u32(attr));
+				break;
+			case NFSD_A_SERVER_LEASETIME:
+				printf("leasetime: %u\n", nla_get_u32(attr));
+				break;
+			case NFSD_A_SERVER_SCOPE:
+				printf("scope: %s\n", nla_data(attr));
+				break;
+			case NFSD_A_SERVER_THREADS:
+				pool_threads[i++] = nla_get_u32(attr);
+				break;
+			default:
+				break;
+		}
+	}
+
+	printf("pool-threads:");
+	for (i = 0; i < pools; ++i)
+		printf(" %d", pool_threads[i]);
+	putchar('\n');
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
+		parse_threads_get(gnlh);
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
+#define BUFFER_SIZE	8192
+static struct nl_sock *netlink_sock_alloc(void)
+{
+	struct nl_sock *sock;
+	int ret;
+
+	sock = nl_socket_alloc();
+	if (!sock)
+		return NULL;
+
+	if (genl_connect(sock)) {
+		fprintf(stderr, "Failed to connect to generic netlink\n");
+		nl_socket_free(sock);
+		return NULL;
+	}
+
+	nl_socket_set_buffer_size(sock, BUFFER_SIZE, BUFFER_SIZE);
+	setsockopt(nl_socket_get_fd(sock), SOL_NETLINK, NETLINK_EXT_ACK,
+		   &ret, sizeof(ret));
+
+	return sock;
+}
+
+static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock)
+{
+	struct nl_msg *msg;
+	int id;
+
+	id = genl_ctrl_resolve(sock, NFSD_FAMILY_NAME);
+	if (id < 0) {
+		fprintf(stderr, "%s not found\n", NFSD_FAMILY_NAME);
+		return NULL;
+	}
+
+	msg = nlmsg_alloc();
+	if (!msg) {
+		fprintf(stderr, "failed to allocate netlink message\n");
+		return NULL;
+	}
+
+	if (!genlmsg_put(msg, 0, 0, id, 0, 0, 0, 0)) {
+		fprintf(stderr, "failed to allocate netlink message\n");
+		nlmsg_free(msg);
+		return NULL;
+	}
+
+	return msg;
+}
+
+static void status_usage(void)
+{
+	printf("Usage: %s status\n", taskname);
+	printf("    Display RPC jobs currently in flight on the server.\n");
+}
+
+static int status_func(struct nl_sock *sock, int argc, char ** argv)
+{
+	struct genlmsghdr *ghdr;
+	struct nlmsghdr *nlh;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int opt, ret;
+
+	optind = 1;
+	while ((opt = getopt_long(argc, argv, "h", help_only_options, NULL)) != -1) {
+		switch (opt) {
+		case 'h':
+			status_usage();
+			return 0;
+		}
+	}
+
+	msg = netlink_msg_alloc(sock);
+	if (!msg)
+		return 1;
+
+	nlh = nlmsg_hdr(msg);
+	nlh->nlmsg_flags |= NLM_F_DUMP;
+	ghdr = nlmsg_data(nlh);
+	ghdr->cmd = NFSD_CMD_RPC_STATUS_GET;
+
+	cb = nl_cb_alloc(NL_CB_CUSTOM);
+	if (!cb) {
+		fprintf(stderr, "failed to allocate netlink callbacks\n");
+		ret = 1;
+		goto out;
+	}
+
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
+static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
+			int pool_count, int *pool_threads, char *scope)
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
+		int i;
+
+		if (grace)
+			nla_put_u32(msg, NFSD_A_SERVER_GRACETIME, grace);
+		if (lease)
+			nla_put_u32(msg, NFSD_A_SERVER_LEASETIME, lease);
+		if (scope)
+			nla_put_string(msg, NFSD_A_SERVER_SCOPE, scope);
+		for (i = 0; i < pool_count; ++i)
+			nla_put_u32(msg, NFSD_A_SERVER_THREADS, pool_threads[i]);
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
+	printf("Usage: %s threads [ pool0_count ] [ pool1_count ] ...\n", taskname);
+	printf("    pool0_count: thread count for pool0, etc...\n");
+	printf("Omit any arguments to show current thread counts.\n");
+}
+
+static int threads_func(struct nl_sock *sock, int argc, char **argv)
+{
+	uint8_t cmd = NFSD_CMD_THREADS_GET;
+	uint32_t *pool_threads = NULL;
+	int opt, pools = 0;
+
+	optind = 1;
+	while ((opt = getopt_long(argc, argv, "h", help_only_options, NULL)) != -1) {
+		switch (opt) {
+		case 'h':
+			threads_usage();
+			return 0;
+		}
+	}
+
+	if (optind < argc) {
+		char **targv = &argv[optind];
+		int i;
+
+		pools = argc - optind, i;
+		pool_threads = alloca(pools * sizeof(*pool_threads));
+		cmd = NFSD_CMD_THREADS_SET;
+
+		for (i = 0; i < pools; ++i) {
+			char *endptr = NULL;
+
+			/* empty string? */
+			if (targv[i][0] == '\0') {
+				fprintf(stderr, "Invalid threads value %s.\n", targv[i]);
+				return 1;
+			}
+
+			pool_threads[i] = strtol(targv[i], &endptr, 0);
+			if (!endptr || *endptr != '\0') {
+				fprintf(stderr, "Invalid threads value %s.\n", argv[1]);
+				return 1;
+			}
+		}
+	}
+	return threads_doit(sock, cmd, 0, 0, pools, pool_threads, NULL);
+}
+
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
+			break;
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
+
+		if (nfsd_versions[i].major == 0)
+			break;
+
+		a = nla_nest_start(msg, NLA_F_NESTED | NFSD_A_SERVER_PROTO_VERSION);
+		if (!a) {
+			fprintf(stderr, "Unable to allocate version nest!\n");
+			ret = 1;
+			goto out;
+		}
+
+		nla_put_u32(msg, NFSD_A_VERSION_MAJOR, nfsd_versions[i].major);
+		nla_put_u32(msg, NFSD_A_VERSION_MINOR, nfsd_versions[i].minor);
+		if (nfsd_versions[i].enabled)
+			nla_put_flag(msg, NFSD_A_VERSION_ENABLED);
+		nla_nest_end(msg, a);
+	}
+
+	ghdr = nlmsg_data(nlh);
+	ghdr->cmd = NFSD_CMD_VERSION_SET;
+
+	cb = nl_cb_alloc(NL_CB_CUSTOM);
+	if (!cb) {
+		fprintf(stderr, "Failed to allocate netlink callbacks\n");
+		ret = 1;
+		goto out;
+	}
+
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
+			break;
+		if (nfsd_versions[i].major == major && nfsd_versions[i].minor == minor) {
+			nfsd_versions[i].enabled = enabled;
+			return 0;
+		}
+	}
+	/* the kernel doesn't support this version */
+	if (!enabled)
+		return 0;
+	fprintf(stderr, "This kernel does not support NFS version %d.%d\n", major, minor);
+	return -EINVAL;
+}
+
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
+
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
+
+			ret = sscanf(str, "%c%d.%d\n", &sign, &major, &minor);
+			if (ret < 2) {
+				fprintf(stderr, "Invalid version string (%d) %s\n", ret, str);
+				return -EINVAL;
+			}
+
+			switch(sign) {
+			case '+':
+				enabled = true;
+				break;
+			case '-':
+				enabled = false;
+				break;
+			default:
+				fprintf(stderr, "Invalid version string %s\n", str);
+				return -EINVAL;
+			}
+
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
+			}
+			sock->active = (sign == '+');
+			found = true;
+			break;
+		}
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
+			break;
+
+		if (!sock->active)
+			continue;
+
+		a = nla_nest_start(msg, NLA_F_NESTED | NFSD_A_SERVER_SOCK_ADDR);
+		if (!a) {
+			fprintf(stderr, "Unable to allocate listener nest!\n");
+			ret = 1;
+			goto out;
+		}
+
+		nla_put(msg, NFSD_A_SOCK_ADDR, sizeof(sock->ss), &sock->ss);
+		nla_put_string(msg, NFSD_A_SOCK_TRANSPORT_NAME, sock->name);
+		nla_nest_end(msg, a);
+	}
+
+	ghdr = nlmsg_data(nlh);
+	ghdr->cmd = NFSD_CMD_LISTENER_SET;
+
+	cb = nl_cb_alloc(NL_CB_CUSTOM);
+	if (!cb) {
+		fprintf(stderr, "Failed to allocate netlink callbacks\n");
+		ret = 1;
+		goto out;
+	}
+
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
+	if (ret)
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
+	int *threads, grace, lease, idx, ret, opt;
+	struct conf_list *thread_str;
+	struct conf_list_node *n;
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
+	scope = conf_get_str("nfsd", "scope");
+
+	thread_str = conf_get_list("nfsd", "threads");
+	if (!thread_str || thread_str->cnt == 0)
+		return 0;
+
+	threads = calloc(thread_str->cnt, sizeof(int));
+	if (!threads)
+		return -ENOMEM;
+
+	idx = 0;
+	TAILQ_FOREACH(n, &(thread_str->fields), link) {
+		char *endptr = NULL;
+
+		threads[idx++] = strtol(n->field, &endptr, 0);
+		if (!endptr || *endptr != '\0') {
+			fprintf(stderr, "Invalid threads value %s.\n", n->field);
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	ret = threads_doit(sock, NFSD_CMD_THREADS_SET, grace, lease, thread_str->cnt,
+			   threads, scope);
+out:
+	free(threads);
+	return ret;
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
+	nl_socket_free(sock);
+	return ret;
+}
diff --git a/utils/nfsdctl/nfsdctl.h b/utils/nfsdctl/nfsdctl.h
new file mode 100644
index 000000000000..f0aa3ab862c2
--- /dev/null
+++ b/utils/nfsdctl/nfsdctl.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/nfsd.yaml */
+/* YNL-GEN uapi header */
+
+#ifndef _UTILS_NFSDCTL_NFSDCTL_H
+#define _UTILS_NFSDCTL_NFSDCTL_H
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
+#endif /* _UTILS_NFSDCTL_NFSDCTL_H */

-- 
2.45.1


