Return-Path: <linux-nfs+bounces-4278-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC3D9153CC
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 18:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 041D5B24921
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 16:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6183B19DF65;
	Mon, 24 Jun 2024 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chORmgSC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E54B19DF57
	for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246490; cv=none; b=CK3OkaEnlFFl01/96heI32yv8zfAMX7hy79J4YqlGvauvrmKbXkLExdUDJF3+TGHySqhyeAPSrjVG+3UlDMQxrJskpB+DmCS+qCJYJ0R3oT0RbCk0UhKeE00K3n3yfXDGX9UjvWk78/DqoQdu0LEnT20JzmgnsMdi2/vv0NplgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246490; c=relaxed/simple;
	bh=le/zlUgDFxjF59g/mg6zRVtb3tIgT5pzc1iynTtjBls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxRggQwR9AwXhBNWvOSMrv+Lp5vWHy/khfztx+lJntam+BhtTs5j3k/g4WbvyKVcvjom5Ld0QZ1n6KrEAj+cg+mrM1Wz/Jc792HhZMoYZmM3w0GnZYUEZ2ncz187uPG+D/1lRTzPbVcxKgfDPH2LoNpifZERVkKDT2XloSuwRhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chORmgSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36FCC32782;
	Mon, 24 Jun 2024 16:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719246490;
	bh=le/zlUgDFxjF59g/mg6zRVtb3tIgT5pzc1iynTtjBls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=chORmgSCe9ftQ4l0I81TM1TYaBa7f1WREtQyoVFD4QbQ7DGWodUABeX6b+a2NjXT8
	 NeEMhzPvfWxv4HPnOZEM5kJATUMrxCcHlocyh4O/CXD7kVjTluERYz5iDScWmuHZeb
	 x/HYFqur6658C8DN5Fkhx8avnxbNop4YQHJBMkzlSNExdwg0mmhRDLLT8BFjlckbGL
	 1r2je33CzTqyxN80QQyBkOTRagFlj+Dfk4fr+8ERUMWkDibNSy35WboQ3jth/qj1Tc
	 HfpFah0HN1Kai8qGOi1hVce3tjcPV/JTd2OF7lDfskBjZLvy5dJZTbk6beUxIZ61v9
	 M0HHWPdbWY1qw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v7 20/20] nfs/nfsd: add Kconfig options to allow localio to be enabled
Date: Mon, 24 Jun 2024 12:27:41 -0400
Message-ID: <20240624162741.68216-21-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240624162741.68216-1-snitzer@kernel.org>
References: <20240624162741.68216-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that all the localio code is complete, allow users to enable it.

CONFIG_NFS_LOCALIO controls the client enablement and
CONFIG_NFSD_LOCALIO the server enablement.

While it is true that it doesn't make sense, on a using LOCALIO level,
to have one without the other: it is useful to allow a mix be
configured for testing purposes.  It could be that the same control
could be achieved by exposing a discrete "localio_enabled"
module_param in the server (nfsd.ko) like is already available in the
client (nfs.ko).

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/Kconfig      |  3 +++
 fs/nfs/Kconfig  | 14 ++++++++++++++
 fs/nfsd/Kconfig | 14 ++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/fs/Kconfig b/fs/Kconfig
index a46b0cbc4d8f..170083ff2a51 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -377,6 +377,9 @@ config NFS_ACL_SUPPORT
 	tristate
 	select FS_POSIX_ACL
 
+config NFS_COMMON_LOCALIO_SUPPORT
+	tristate
+
 config NFS_COMMON
 	bool
 	depends on NFSD || NFS_FS || LOCKD
diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 57249f040dfc..311ae8bc587f 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -86,6 +86,20 @@ config NFS_V4
 
 	  If unsure, say Y.
 
+config NFS_LOCALIO
+	tristate "NFS client support for the LOCALIO auxiliary protocol"
+	depends on NFS_V3 || NFS_V4
+	select NFS_COMMON_LOCALIO_SUPPORT
+	help
+	  Some NFS servers support an auxiliary NFS LOCALIO protocol
+	  that is not an official part of the NFS version 3 or 4 protocol.
+
+	  This option enables support for the LOCALIO protocol in the
+	  kernel's NFS client.  Enable this to bypass using the NFS
+	  protocol when issuing reads, writes and commits to the server.
+
+	  If unsure, say N.
+
 config NFS_SWAP
 	bool "Provide swap over NFS support"
 	default n
diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index ec2ab6429e00..a36ff66c7430 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -89,6 +89,20 @@ config NFSD_V4
 
 	  If unsure, say N.
 
+config NFSD_LOCALIO
+	tristate "NFS server support for the LOCALIO auxiliary protocol"
+	depends on NFSD || NFSD_V4
+	select NFS_COMMON_LOCALIO_SUPPORT
+	help
+	  Some NFS servers support an auxiliary NFS LOCALIO protocol
+	  that is not an official part of the NFS version 3 or 4 protocol.
+
+	  This option enables support for the LOCALIO protocol in the
+	  kernel's NFS server.  Enable this to bypass using the NFS
+	  protocol when issuing reads, writes and commits to the server.
+
+	  If unsure, say N.
+
 config NFSD_PNFS
 	bool
 
-- 
2.44.0


