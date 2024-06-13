Return-Path: <linux-nfs+bounces-3774-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A0B907889
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 18:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12AF51C22544
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 16:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E430B1494B5;
	Thu, 13 Jun 2024 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyE41NcO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF896146A79
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718297068; cv=none; b=AkIR3glp3xvWcYltD7hRGrdRKod5A+kaiCxBN6zQOAgdlBq8iBK0j44/SmUOSQP7IykPHBdNt6ean7r6DJynTAHlJd+eLEDuokS6FDW4wwdoC0hsTnaEg1aLjNQDKYH4CUxRPNjfcS/noDr2++71rG8FZb3pCr0YgmtggTjYuu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718297068; c=relaxed/simple;
	bh=6qiwxDhQ8FRziLyT7fabl7gPHk/jpXioRkJvkXxPl/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YnvLAbXbTKM2rjmunOORg6CSZeGL2c1ZGAwJuXSBd8mt2va9n5mMGggyoQu8uleMLRbc/v0zU/bCHQFGYwOHUmeKb1vpmY/1mO5eZzhFg+EcdDgUpr9l/YVM0AOD3f07nitjjEAFL+oVIO0W6bH8TFdEst+9ZdhALrJR0HdImkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyE41NcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A34C4AF50;
	Thu, 13 Jun 2024 16:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718297068;
	bh=6qiwxDhQ8FRziLyT7fabl7gPHk/jpXioRkJvkXxPl/Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uyE41NcOontWUiojSz3cSX2zhAqwPYQSvEqeebndnvPpjhdQ4gVxDBiIcw/Y4V747
	 ymz5YF6Q/p3F18VWA+aTs2cIymAR9OwzON7K+T8HNsSRl0ZOGS1jS4RnPwKvm+Q7+J
	 rJR+j7PwlKyzUVSmiq+d68QxWgpj98kuRJpp7j+qEulIfVTwVs+9lfPwlkv64lSztH
	 oTzDbqI3Ht6YaYsWtrGNwX4idQQXDEwY5BUd5vAMwkGHA6rT40YfefGJXsaGlF725j
	 xlIXGzNCFDnSGy1czTXZjQfvRUAHXjk0xv+KL8TA7LrGBRJDRQs15NPTQa2tbtklJf
	 VEnUDFHkqF65A==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 13 Jun 2024 12:44:07 -0400
Subject: [PATCH nfs-utils v5 2/4] nfsdctl: asciidoc source for the manpage
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-nfsdctl-v5-2-0b7a39102bac@kernel.org>
References: <20240613-nfsdctl-v5-0-0b7a39102bac@kernel.org>
In-Reply-To: <20240613-nfsdctl-v5-0-0b7a39102bac@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4597; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=6qiwxDhQ8FRziLyT7fabl7gPHk/jpXioRkJvkXxPl/Q=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmayHow/PnLp8zSOMkP4jp9LaBRgKw20wOy/Pxn
 uASUfa1DFuJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZmsh6AAKCRAADmhBGVaC
 Fb1zD/9hgWVzXxtHjVdcjTzNSjRZzkTRIj+1nH4ElQiSeOLuLCLPXaDmNtCOh/WMmPJZ6K5qcGl
 umpPrY+ROdAaUo49YK4aBlBTH2KaumTIp8hV2anBDiBNqmT11LI/x6N7tcCaQXqCBUAIgkuTZFV
 92++Y8N49odpkwHMUg9qZ3De68EdFB/3i4tWR/SpwFM+JaGiCHYE7pi5YgAyDnKuLL/ZNISEAnt
 6bCS+v2Z2Y1vowD+OKcsRzaHeAhRt1XNikPXsHPu0fbkxuMFVrxrrEw4NRv4VVG15ogHzYlPZSJ
 bGGz2UJ9WWcSbRn8S4k5YqtWicPyIikBwLWgcydgmsw07sGLY068GWUCsf7+ghrlmnCooLh7qa+
 ARAQS3FbRKGG4Xqk/0+Ed703FABZka1pEuTxgya/qA8ECmsAaCh2X4ial0EF5wcJ/VXSW1H151d
 bEeJ5dtw0swD4Ea6fBsAlhyQRrR1DneA0qj7Gywt92rk1+nJjkj38yUF8Aacz7emC+jyGDlQhuN
 9AA6gaedgBdpgZXKl19OcyJdwPWHEg/aHQ+i8qI0Iw3FUAMHl+8PDP2ih7kjvx23jE5EyOjJpoC
 Y55j0vL/1iyVOAO9WnNbKj6dcDqsZIm3/Sc4mne6OSGTRaT/9E+ssSUmYqB9ptmXPgZNCxIyJH4
 uAlMa3ysJgUWhlg==
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
2.45.2


