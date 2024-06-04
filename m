Return-Path: <linux-nfs+bounces-3557-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 944258FBE7F
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2024 00:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF1C2B221EC
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 22:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2E41422C2;
	Tue,  4 Jun 2024 22:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8PYQen4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73E2320C
	for <linux-nfs@vger.kernel.org>; Tue,  4 Jun 2024 22:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717538865; cv=none; b=OwTduV5soB0ptSkUHvXM73wUTkFDUUZD1IWFgdWu9iykEjapuRMVRVoIYmY7qodf04+5VYK9fFegdACCDuJjZLK36CXRo0hL5YYKHbd7J1MjocGguZxmT7kRdVZS9YIklfZ8WkVirD6jUPRzwAFFFqfXqfujiImAUgRtmKNcuTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717538865; c=relaxed/simple;
	bh=YTkxykNN7zk2r2FEv2IGXjzZ4Kkn2BRuPEAVVHx2pCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ER3q5mN7Ri6XPCTN4iqzvdRBTL2ShJgE9AjiCPVqx9T11o33gSSW7KbW/aRnsc+INyUhS/GDkIKwJnELRR+F298SftcSOynE9KaSmtQEQ46XIWTWxRKDoTJsY918av4cLkAsZX19GJUOp0BzTQw8hPOVEEL7U0V/tUHd86XEXl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8PYQen4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C257C2BBFC;
	Tue,  4 Jun 2024 22:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717538865;
	bh=YTkxykNN7zk2r2FEv2IGXjzZ4Kkn2BRuPEAVVHx2pCY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f8PYQen4a9OvDj1hyJPLy8E3rcyfdyaL9WE2KK8QPmQ4VnTXEiICutf3Ly8mf341p
	 rFayD3tD0EvyJcSSbqBzM+8tNTtPWOzrwyQ2ZxFF80DOLLj2flnwAUi0W6QGu9i+ST
	 sFZY3gJBEu+2m0Ca8/BLwwtTGVyMDoepvzAa8JMN9ZEOkuF/EIGUcXlgZv/Xt9QnXW
	 5f9CIEW514m5RM5rZY20IW/KQbp1pG45VNnwkefmsnMAvzY1vVZH3rBnqnV5pUQs3a
	 eL9pPl0XH2qVdhmD7M9ctm9XzxeXwyHTOqb57cmBwxhp8qJ1engG/Hyp6R8gC43RAy
	 iU3/NrlxY1JzQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 04 Jun 2024 18:07:30 -0400
Subject: [PATCH nfs-utils v4 2/3] nfsdctl: asciidoc source for the manpage
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-nfsdctl-v4-2-a2941f782e4c@kernel.org>
References: <20240604-nfsdctl-v4-0-a2941f782e4c@kernel.org>
In-Reply-To: <20240604-nfsdctl-v4-0-a2941f782e4c@kernel.org>
To: Steve Dickson <steved@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Neil Brown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5211; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=YTkxykNN7zk2r2FEv2IGXjzZ4Kkn2BRuPEAVVHx2pCY=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmX5AuGx/pYchBrB+cLdLNVqtElYmPz7RAdYnme
 Eod+12GjdSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZl+QLgAKCRAADmhBGVaC
 Fbs1D/9TWC19qdefuxFHmrKO+rQKrDu0OoJBSVRXpWPMBTS0lGhyIp+1F+uyNpN8yenfR7oGjfj
 YMF6lAcJY+EaVzWpzGQvZwW/x77185EvRcXd2WMxfGIvcmmQnr2S4huKkP65wqjJutIpI9f+Q1H
 aEFUjDFUPRXbS74131/HGJvg2wG6vEMXV7jW0qTIT4R10sNrsgvH3e8+q6FD3iOJZyLUN3PvrsJ
 56LM7CcKdrSHVkYg5rqtuOqaL3oYY9iPwnrd62s8KQ0f7sGJFHG2tGlI8fTFkQzSdGqHNWHbw4Q
 GsaJ3XuW4ppYECpbYlCwdGMtd3p90fEN2Chw3RoP45WmZaL34a7b7xtdMJCUtiXjmaJs2zlgjez
 fETjj3RadieJMKtX3Po1ClwYJUQl3C41V5c9LX9PnmwBbBwn3YWhRBjsXyFzlxKsBia49y/Kuo4
 1ObZPE7+o/ubuk0JtQGuqxK736xQ/IuqsWuii2MQCg2FW7nQiLI11ZqPwyZyn+QACL5cpcbWVk0
 W8hQJL5jUnUSilLgMAPgA4SqK0W7IPmfFIP3JPpEH3GrZmFTHIvF6/ruQTXpl1qqf5aYn2eW0W5
 NhenrMeVgDY2iOvKEhVRf2OvTe+zp1he+1j0kps+H5zE5a0gPjRNgIq9FApuGYs2g0NoJNKAsL3
 2tkAPHxKtL9C2KA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Convert to manpage with:

    asciidoctor -b manpage nfsdctl.adoc

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 configure.ac               |   2 +-
 utils/nfsdctl/nfsdctl.adoc | 140 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index f965865465ae..5a976b108d13 100644
--- a/configure.ac
+++ b/configure.ac
@@ -258,10 +258,10 @@ AC_ARG_ENABLE(nfsdctl,
 	enable_nfsdctl="yes")
 	AM_CONDITIONAL(CONFIG_NFSDCTL, [test "$enable_nfsdctl" = "yes" ])
 	if test "$enable_nfsdctl" = yes; then
-		dnl Check for libnl3
 		PKG_CHECK_MODULES(LIBNL3, libnl-3.0 >= 3.1)
 		PKG_CHECK_MODULES(LIBNLGENL3, libnl-genl-3.0 >= 3.1)
 		PKG_CHECK_MODULES(LIBREADLINE, readline)
+		AC_CHECK_HEADERS(linux/nfsd_netlink.h)
 	fi
 
 AC_ARG_ENABLE(nfsv4server,
diff --git a/utils/nfsdctl/nfsdctl.adoc b/utils/nfsdctl/nfsdctl.adoc
new file mode 100644
index 000000000000..b2f00c11829e
--- /dev/null
+++ b/utils/nfsdctl/nfsdctl.adoc
@@ -0,0 +1,140 @@
+= nfsdctl(8)
+Jeff Layton
+:doctype: manpage
+
+== NAME
+
+nfsdctl - control program for the Linux kernel NFS server
+
+== SYNOPSIS
+
+*nfsdctl* [ _OPTION_ ] COMMAND ...
+
+== DESCRIPTION
+
+nfsdctl is a control and query program for the in-kernel NFS server. There are several
+subcommands (documented below) that allow the admin to configure or query different
+aspects of the NFS server.
+
+To get information about different subcommand usage, pass the subcommand the
+--help parameter. For example:
+
+    nfsdctl listener --help
+
+== OPTIONS
+
+*-d, --debug*::
+  Enable debug logging
+
+*-h, --help*::
+  Print program help text
+
+*-V, --version*::
+  Print program version
+
+== SUBCOMMANDS
+
+Each subcommand can also accept its own set of options and arguments. The
+--help option is standard for all subcommands:
+
+*autostart*::
+  Start the server using the settings in the [nfsd] section of /etc/nfs.conf.
+  This subcommand takes no arguments.
+
+*listener*::
+
+  Get/set the listening sockets for the server. Run this without arguments to
+  get a list of the sockets on which the server is currently listening. To add
+  or remove sockets, pass it whitespace-separated strings in the format:
+
+    { +|- }{ protocol }:{ address }:{ port }
+
+  The fields are:
+
+    + to add a listener, - to remove one
+    protocol: protocol name (e.g. tcp, udp, rdma)
+    address: hostname or address
+    port: port number or service name
+
+  All fields are required, except for the address. If address is an empty string,
+  then the listeners will be opened for INADDR_ANY and IN6ADDR_ANY_INIT for ipv6
+  (if enabled). The address can be either a hostname or an IP address. IPv4
+  addresses must be in dotted-quad form. IPv6 addresses should be in standard
+  colon separated form, and must be enclosed in square brackets.
+
+*status*::
+
+  Get information about RPCs currently executing in the server. This subcommand
+  takes no arguments.
+
+*threads*::
+
+  Get/set the number of running nfsd threads in each pool. Pass a list of
+  integers to change the currently active number of threads. Passing it a
+  value of 0 will shut down the NFS server. Run this without arguments to
+  get the current number of running threads in each pool.
+
+*version*::
+
+  Get/set the enabled NFS versions for the server. Run without arguments to
+  get a list of supported versions and whether they are currently enabled or
+  disabled. To enable or disable a version, pass it a string in the format:
+
+        { +|- }{ MAJOR }{.{ MINOR }}
+
+  The fields are:
+
+    + to enable a version, - to disable
+    MAJOR: the major version integer value
+    MINOR: the minor version integet value
+
+  The minorversion field is optional. If not given, it will disable or enable
+  all minorversions for that major version.
+
+== EXAMPLES
+
+Start the server with the settings in nfs.conf:
+
+  nfsdctl autostart
+
+Get a list of current listening sockets:
+
+  nfsdctl listener
+
+Show the supported and enabled NFS versions:
+
+  nfsdctl version
+
+Add TCP listener on all addresses (both v4 and v6), port 2049:
+
+  nfsdctl listener +tcp::2049
+
+Add RDMA listener on 1.2.3.4 port 20049:
+
+  nfsdctl listener +rdma:1.2.3.4:20049
+
+Add same listener on IPv6 address f00::ba4 port 20050:
+
+  nfsdctl listener +rdma:[f00::ba4]:20050
+
+Enable NFS version 3, disable v4.0:
+
+  nfsdctl version +3 -4.0
+
+Change the number of running threads in first pool to 256:
+
+  nfsdctl threads 256
+
+== NOTES
+
+nfsdctl is intended to supersede rpc.nfsd(8), which controls the nfs server
+using the files under /proc/fs/nfsd. nfsdctl instead uses a netlink(7)
+interface to achieve the same goals.
+
+Most of the commands that query the NFS server can be run as an unprivileged
+user, but configuring the server typically requires an account with elevated
+privileges.
+
+== SEE ALSO
+
+nfs.conf(5), rpc.nfsd(8), rpc.mountd(8), exports(5), exportfs(8), nfs.conf(5), rpc.rquotad(8),  nfsstat(8), netconfig(5)

-- 
2.45.1


