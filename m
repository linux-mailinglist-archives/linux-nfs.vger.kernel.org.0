Return-Path: <linux-nfs+bounces-5012-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B93619392EA
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jul 2024 19:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A821C2161D
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jul 2024 17:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00C216EB48;
	Mon, 22 Jul 2024 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvQe1VH3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC348C2FD
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jul 2024 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721667699; cv=none; b=krjkgD7wolsN62im+MGMkhJLWvocyGq3QwQyimztkT9Idb5cZLDw3dWMd1T+d7xh0B/JoKSXxZc8Lh70Gf/dGRKuI0k1kFeNpDV71HvwU/J+4Ago02n8eTSep0e+YHtKOtfG4NVJNMJv7HeCQZXU+rGxd8L9K2Kum4Bi7gcC1H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721667699; c=relaxed/simple;
	bh=N+87GWZhocbNKOVaLk6P35GlW3T0U77icC44+SmvqIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j5RYO9R+Q0+h6+MW4+Dqf9IV3Kj56JaslO5hnnjg6uZLLJm/8LPF/p0nNiQOkZwlQkB5xnt6CPEvnQ6osk918hiD/tR7yG8Q694wLxIDuZP1eqojByqVlHWMCxPPznP2KGHMBwTfD+fiN0fYTvCIuc9NxvETPrQ0fNYSrY91lKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvQe1VH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB839C116B1;
	Mon, 22 Jul 2024 17:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721667699;
	bh=N+87GWZhocbNKOVaLk6P35GlW3T0U77icC44+SmvqIg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OvQe1VH3f91RRLIEmGvDG/WolLkHUNG8mYXc9Qj9OtYU1TzVQZPlCSUFWNRGUSNYQ
	 dRRkOLcdylRm5XVoSncQ1XnDYKx/krB1MYnU1C4H0I/lxxiZQAhOH+09XI2bc2B/EJ
	 VTBgWLar7/E/7UzwhM0cb7s+IYK/v+0Bs7w8e48MxPxXevMREZ6PWahJBQyPfILYhU
	 9VEZPdgDK1Z9hDQrTO+g7VB/ESLheqFt0MmMA7+vl6oYQcULB3XUpan1Paikh3O4T9
	 T2tVPl+FiQRNthVk4ITRs8sF9tL6NGwV+qqapsrUfoTQPEQJttg60cbBAlNJwHtEBu
	 pcu8LkX3AM5mw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 22 Jul 2024 13:01:34 -0400
Subject: [PATCH nfs-utils v6 2/3] nfsdctl: asciidoc source for the manpage
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-nfsdctl-v6-2-1b9d63710eb5@kernel.org>
References: <20240722-nfsdctl-v6-0-1b9d63710eb5@kernel.org>
In-Reply-To: <20240722-nfsdctl-v6-0-1b9d63710eb5@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Chuck Lever <chuck.lever@oracle.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5240; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=N+87GWZhocbNKOVaLk6P35GlW3T0U77icC44+SmvqIg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmnpBwt6sSx7I7YCUtlRHg58itvwaG14DP6p0Mo
 YsJ01A+teqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZp6QcAAKCRAADmhBGVaC
 FabmD/9knlnzCJWazHRz0fSadDzFvYXS4Wqi0amIYRnfQklmxuqCe0D7xu7kLjDYYVs1ftBRutK
 wPfthZDXb4zE49F9LIUsIy4w9mryem0nlUiLddKChNzzuxhvHcyq3kyNM64dm+1A7JcYOYQXA+U
 VKfobLvQIQzpQC/QcEsTcE4KowE2W4IJEF+yhhez3IrPdaoSTlB3tlDnQvESHotngPq7u89kZHY
 D+wN/LszTohdxWc2Rt3zKAPITJEKFA10bMjjyGnpVchBiJ0OjlgnMwWYu80iCOMKSnrjKcEGn8F
 cQuZt+nQ+/jSm1KyQF0ctCY4E+t5ii7+AXpUmr+MVFOY5QycDwKI9luSVg5dC2ZaMvpqOhBXJCj
 VOZbfjZn6D2pIkxrf4Aqc9ejIHH5z4T+PD/0XV4JeX1l+p6zu7GtMpVu2k/Zz+Ca7LyP9YuWt58
 lLkJkEggbBXPBqWInC+kqeGwGl+lYh0e0dXjiiWddHh78HhS4iKVdG3EF+fl43UEjkcP0SYUoaj
 nqSGLQg1HDOgVz4naO/7P9OuwIL0AjenBaDe9DLa6I5ijn9YvfMZbtUJriNitod7yk+HXoS3Jjw
 X29e1nX8f9RlspvDh833viG4TYgAFJIS+CnMY6HiDbSGxbpZM5jcC3wXysgcQoQiEfG82LCVJ30
 zKFcQKoOz1jiwbA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Convert to manpage with:

    asciidoctor -b manpage nfsdctl.adoc

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 utils/nfsdctl/nfsdctl.adoc | 158 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/utils/nfsdctl/nfsdctl.adoc b/utils/nfsdctl/nfsdctl.adoc
new file mode 100644
index 000000000000..7119b44db6d2
--- /dev/null
+++ b/utils/nfsdctl/nfsdctl.adoc
@@ -0,0 +1,158 @@
+// Convert to manpage via: asciidoctor -b manpage nfsdctl.adoc
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
+  This subcommand takes no arguments. Note that if a "threads=" value is not set in
+  nfs.conf, 16 server threads will be brought online.
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
+*pool-mode*::
+
+  Get/set the host's pool mode. This will cause the server to start threads
+  that are pinned to either the CPU or the NUMA node. This can only be set
+  when there are no nfsd threads running.
+
+  The available options are:
+    global:  single large pool
+    percpu:  pool per CPU
+    pernode: pool per NUMA node
+    auto:    choose a mode based on host configuration
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
+Set the pool-mode to "pernode":
+
+  nfsctl pool-mode pernode
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
2.45.2


