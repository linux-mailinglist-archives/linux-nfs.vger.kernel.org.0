Return-Path: <linux-nfs+bounces-2845-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13888A71AD
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Apr 2024 18:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09C5AB21793
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Apr 2024 16:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243AC13281B;
	Tue, 16 Apr 2024 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z758CQ8B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000F613280C
	for <linux-nfs@vger.kernel.org>; Tue, 16 Apr 2024 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713286154; cv=none; b=WmglakUxXT/7fdj3QxSpGJ3kUSgyWpTLi09Ki0jdgmkNmdg295TBGkbNlp9fQzwgf9DhSxWvMuzhF2FU1FdsgqMswlgofYKhlGpEwjGaIkJcAmvPxWcTImDhAqSys8rm+ovXIper8o6nBh5JXrbXPsyXQ2JIYqhUsHCOY2BSmdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713286154; c=relaxed/simple;
	bh=vaOkTXQyXUKkW8az8N0hUjSyW8/3roLAushd/KqEbLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=coPy51fiFLbmNRSx9KFROylNZLVhvhQPc6SAWzuFSfdKtgJmkZu6QABZOyKhxrC7l8Tc2CgFlPLtAPc1iYvDNuUF6yvTggxluszCwqDkROO6IVUX3SEXofhsLe3b45ks2tNJm/jHNE6C1d+sqHXMQcB3Z6OTAfh6owompYdd0dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z758CQ8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA19C4AF07;
	Tue, 16 Apr 2024 16:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713286153;
	bh=vaOkTXQyXUKkW8az8N0hUjSyW8/3roLAushd/KqEbLk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z758CQ8BshqdyhD9GWtQmR6Rpa0tMgqnCmMeI5kKLVbGxZtgIROPCnObmSUGebkcO
	 9hKzBPpU9ytA7YlkjHm58BXvEue9tlNYRTB+1qqfFmY1U98g1W1SwRqCjq42Ts15Bd
	 3MNemQKigHnTTpdjY5K2yObUvY306HQ+C7s+ARqoIb7Xq+oWnQjSCDVrQBDmYK4XuS
	 Q7kFlCwB2dt727pQGSPYB+tVUrut3H/HAVuJdW0kiA7V4pe+6AeVR4u1+XsuJK1xqh
	 qInyUVJrDs4+khAN6MLq5268a4NlO11Pg6SlClFLGb8AsfZjXGtATQtyjlnV3FtJs6
	 het2eJ54Oyk4g==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Apr 2024 12:48:49 -0400
Subject: [PATCH nfs-utils v2 3/4] nfsdctl: asciidoc source for the manpage
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-nfsdctl-v2-3-9a4367b710d2@kernel.org>
References: <20240416-nfsdctl-v2-0-9a4367b710d2@kernel.org>
In-Reply-To: <20240416-nfsdctl-v2-0-9a4367b710d2@kernel.org>
To: Steve Dickson <steved@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Neil Brown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4573; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=vaOkTXQyXUKkW8az8N0hUjSyW8/3roLAushd/KqEbLk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmHqwGJOaumy3V3ZUTl6nwQxj8zEidCv352ABoE
 DFKCxDMvSSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZh6sBgAKCRAADmhBGVaC
 FaC4D/wNb2NV6G0DrvmHo34jRpGF8QAvko8jt60ugTuBsbKJUB6zQ/2koLObhSflP6Y1jVviw87
 BC6B2nsYZNURKWxPgy9Ec7VLfr1+xYjQslqb1hB3WNorot3IK/BGj3z6iu0cIFZ+gLEW2Feoi1C
 f3GhiSk5lfUpTB7Y+R78z+iotPcxk0X7T+nCnOinip6lJVuM1pbPgol2W/x63nLzKprob9TJ65Q
 9Dt5a8Hbotb1SWh3jshjdgoJABErsEX3+pv7Et6TG9X6yI73/Ylcig5gfxXYq2d5ymelBv74kLb
 IKyMtCAXTNlYgEgfpP4ATquKVVPZxOA/ze34vA0W8n6iNeKHNAxBb1GXaDyfjS94ZrkoWmL9h7h
 V3gkg+SuX41uRrVPwOZhwzBypVfuPedts0IO6Cj/k8kZMn8qHBVLH+jmWQRKrU33UBx0fOdxzha
 VaIF4NiJQAVGBcGXAbGM45y2BwTBVrXfpctixCfhH9Pxs6T/8yateQrm8Zglv3grRBVZKj4NnIu
 y+5SF4frYwrB06PPGWlkb7uAb5mCMFcVzSy/WVZktANwLCNRmuO1lYFcrsA7I4iJsiTPc8l9IVa
 5K30cVMlw3iaYbwR1k2px4GPSGe1iHRLZ22B+qPbiL+nYjeCR97lykmxUeDYc97cPQOHy+wn0CY
 MgM7VN3/dj04AZg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Convert to manpage with:

    asciidoctor -b manpage nfsdctl.adoc

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 utils/nfsdctl/nfsdctl.adoc | 140 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/utils/nfsdctl/nfsdctl.adoc b/utils/nfsdctl/nfsdctl.adoc
new file mode 100644
index 000000000000..07f34f7091e1
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
+  Get/set the number of running nfsd threads. Pass this subcommand a positive
+  integer to change the currently active number of threads. Passing it a value
+  of 0 will shut down the NFS server. Run this without arguments to get the
+  current number of running threads.
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
+Change the number of running threads to 256:
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


