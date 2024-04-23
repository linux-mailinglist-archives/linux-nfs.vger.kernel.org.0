Return-Path: <linux-nfs+bounces-2962-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5688AF427
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 18:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD9D1C22D77
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 16:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8006B13CF91;
	Tue, 23 Apr 2024 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gadu8aLj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B76F1E485
	for <linux-nfs@vger.kernel.org>; Tue, 23 Apr 2024 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889923; cv=none; b=PIMXzW2Yk9IpOZbXQQ7dzwpLJp6GWD+OpL8hCIRzNS0M1UyKfkvzykiaAr2kUOoPAum/uRiuxV9KXzIIWtN0IFyVwe6nupk4NJcquqnQS5eXAojXQglxIRrAC3LQpuboWEZw96aWWZAqwafBoruOYUwmTx0tcFcrSb2bok9or1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889923; c=relaxed/simple;
	bh=a0EnQ378XXET5hkafaPlW5YEAn7pfqETxUy/LCo+MBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WM46KCPuVaK6UL6XGJjm+YoBI6NxAQJj6uVeYkkUbth9AXNu0QXfoNq6w5Lr1jZoZol2rMujG0CLU12ksys3CjLIq0KpUoo7Q7uasocH3FdX5ZgJ+vOfx7mFf6Mpqom+GJtSy8/Hjj/FBNnSSIo2mJW/AvI4o+w0QQzsIyZZ4AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gadu8aLj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A19C3277B;
	Tue, 23 Apr 2024 16:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713889922;
	bh=a0EnQ378XXET5hkafaPlW5YEAn7pfqETxUy/LCo+MBw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gadu8aLj33j5GvlDPtIuuF9VFzYINIG6Mdj89jLrlc3zpwrmEH7ifi4tO2Ipu5kg0
	 eOcWddpre24PtDkHtLkyzoSBgRCR3dQhDSPc3F5wOtDKjdJiX11pqcMD2Sclb3Lov5
	 /s/u1DtPWOrEVrRy/94+wMV8c8zAVu7Hj14Iv+tKbnVp3/KPjDH4oX/FwRjLHKfiXF
	 ZJ82u709IguvREYEzIOL4IeZRfxMwp42q2WcFq/FmIokgr7HJK4tuNmHEjxvkWC7PF
	 fV2ZMEEj83aNVDVOWKc02cGgauyyY3niiFTtsk7Y9zrSkiNfaZBZpok8IKudypcTgw
	 8ltKFfNQs/5IQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 23 Apr 2024 12:31:54 -0400
Subject: [PATCH nfs-utils v3 2/3] nfsdctl: asciidoc source for the manpage
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240423-nfsdctl-v3-2-9e68181c846d@kernel.org>
References: <20240423-nfsdctl-v3-0-9e68181c846d@kernel.org>
In-Reply-To: <20240423-nfsdctl-v3-0-9e68181c846d@kernel.org>
To: Steve Dickson <steved@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Neil Brown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5211; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=a0EnQ378XXET5hkafaPlW5YEAn7pfqETxUy/LCo+MBw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmJ+J/fy85QsjsjrzfwDAgoYWLZgS7YUUQlxfcr
 XdtLmlIy2OJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZififwAKCRAADmhBGVaC
 FcrNEACGSxd3Xrj1wq6YOfCRIOfC6TqY8439QPQqE9ukQXg89tzHhTnzAz+1yiReqoVi9V7jx/Q
 b3TbylJsc1KaCGawSESQ5f10v74xAzVAwoEPE82eXfeKCRvXQi2RKcZ0FgPc6Vr2abz3bTyHp0B
 SEAji2SCxx/t2YqsEzWQQFbK/P5HJaMrK4samOiXvBWkjtewp2x/K7ww3wDKoYDXQG+ffs0JBfu
 ek6NUFC6BgNeUqA6o7F9cqJcqtm3jC/6r6xsb/EpdvUD0FJWJ1MTLtvJX3rVTYeOMQhuR5GS+KU
 js66dGLXt+E+cJ0scDD+mhfzAV+ya+ONmEr0+0fc0M+O/D7JQjohe68FxMiea5oqTpk5b/QF0N4
 kmyatLZJtGinmlSpAyJV+18Vf+vhTRLdw6yZQQBcucglX3LI+mYtwwinF2AX310yiWUxaex9mtB
 qZpzl5lk/K80m7xYSFzBCrND5XP5GApPVY9hzJnGxVuPBHnU406AhKdZn2a49n6fW1kIv3JJU30
 qe3ONXOf1Kb7J4xPwel+N+M76NVR+uSXiNgfeqn/MVVYMmHCbTIsk1wnzP6dXx3px1ujyrWwS+f
 9BZGmqVocZXv/KXuuDQ54NfXyx+P63bjkVf7JQXDH0rM/kczk4JN4/a8fyrXgF6kJE7i6EOqVZY
 0redbvKtVI69Mag==
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
2.44.0


