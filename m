Return-Path: <linux-nfs+bounces-18063-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 502F7D38904
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 22:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D81E310560E
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 21:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3F530B506;
	Fri, 16 Jan 2026 21:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CK+AdU7H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7052FDC3D
	for <linux-nfs@vger.kernel.org>; Fri, 16 Jan 2026 21:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768600303; cv=none; b=m9Ena2vSW+GtHzNz3fc1mkNhm80i73wERhiXro3pxqAPIRcSYTvLJE0PCNHt8Q91hQU8lc+zxB8cO9AglorgpqbOWTGd8ykdSuZmLxGxYVH/qEq/NAnBi+Jk+SDfPTEwl7xKynQvP9nQLFj9WWy1wLylRW9/iUy9e+b3eu6MvXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768600303; c=relaxed/simple;
	bh=3p1lt9w0tMAsOrAJQ76hlB5boRY3EL/ZoYZZUokXTN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jq/bJfSqXXHufRQRgJGIT7FslDRBu50LNZ71RmunnI6BtFJuzFb5608O8sw8y74VZFFHY4DXf4FINWKsK18rHF0sxU0KheSTojwagQX7sEzvKwmLr4ZVZ6Suc++39xX64k2c8+b/BZKtEhtJm5WMoAJkBO1ouqKapwl8gq09dtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CK+AdU7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016D3C116C6;
	Fri, 16 Jan 2026 21:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768600303;
	bh=3p1lt9w0tMAsOrAJQ76hlB5boRY3EL/ZoYZZUokXTN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CK+AdU7HIXSnjmuZhJ+UVKw81UDbAohKzjLn34frXyUe85VmiaUwD8D1IDL2vvMpl
	 nsZOaTxSQ2He6WpogSgwx84LCofgkr6gwALPYg/RrsyC7Pr5eHyIl+AdC283XBbT/e
	 5frqV3K9VXgDL0xxdYt9vjjqwxkuP1DWV4RqCwEmA5KmwuxbT02ZSOfqrjCxl9PduV
	 Pu1O0D2jzUAUthKqKyQ5hE0QfrRPlifffXxSWJKYZwj/HiG7r4o4EARtWjvGL3wCsr
	 ZUmNmcZOXBYGkfmdOFCfSj8jQ4mwTwqnv5HE/R7i6QxUeJopC+wR4phGUpI7ZkHCtL
	 uSdCd6yDnbC/g==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v1 13/14] NFS: Add a way to disable NFS v4.0 via KConfig
Date: Fri, 16 Jan 2026 16:51:34 -0500
Message-ID: <20260116215135.846062-14-anna@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116215135.846062-1-anna@kernel.org>
References: <20260116215135.846062-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

I introduce NFS4_MIN_MINOR_VERSION as a parallel to
NFS4_MAX_MINOR_VERSION to check if NFS v4.0 has been compiled in and
return an appropriate error if not.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/Kconfig      | 9 +++++++++
 fs/nfs/Makefile     | 3 ++-
 fs/nfs/fs_context.c | 3 ++-
 fs/nfs/nfs4_fs.h    | 6 ++++++
 fs/nfs/nfs4client.c | 3 ++-
 fs/nfs/nfs4proc.c   | 2 ++
 fs/nfs/nfs4state.c  | 2 ++
 7 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 07932ce9246c..058ed67b98cc 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -96,6 +96,15 @@ config NFS_SWAP
 	help
 	  This option enables swapon to work on files located on NFS mounts.
 
+config NFS_V4_0
+	bool "NFS client support for NFSv4.0"
+	depends on NFS_V4
+	help
+	  This option enables support for minor version 0 of the NFSv4 protocol
+	  (RFC 3530) in the kernel's NFS client.
+
+	  If unsure, say N.
+
 config NFS_V4_1
 	bool "NFS client support for NFSv4.1"
 	depends on NFS_V4
diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
index d05e69c00fe1..6a9aaf2f913b 100644
--- a/fs/nfs/Makefile
+++ b/fs/nfs/Makefile
@@ -27,9 +27,10 @@ CFLAGS_nfs4trace.o += -I$(src)
 nfsv4-y := nfs4proc.o nfs4xdr.o nfs4state.o nfs4renewd.o nfs4super.o nfs4file.o \
 	  delegation.o nfs4idmap.o callback.o callback_xdr.o callback_proc.o \
 	  nfs4namespace.o nfs4getroot.o nfs4client.o nfs4session.o \
-	  dns_resolve.o nfs4trace.o nfs40proc.o nfs40client.o
+	  dns_resolve.o nfs4trace.o
 nfsv4-$(CONFIG_NFS_USE_LEGACY_DNS) += cache_lib.o
 nfsv4-$(CONFIG_SYSCTL)	+= nfs4sysctl.o
+nfsv4-$(CONFIG_NFS_V4_0)	+= nfs40client.o nfs40proc.o
 nfsv4-$(CONFIG_NFS_V4_1)	+= pnfs.o pnfs_dev.o pnfs_nfs.o
 nfsv4-$(CONFIG_NFS_V4_2)	+= nfs42proc.o nfs42xattr.o
 
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index b4679b7161b0..86750f110053 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -806,7 +806,8 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 		ctx->mount_server.version = result.uint_32;
 		break;
 	case Opt_minorversion:
-		if (result.uint_32 > NFS4_MAX_MINOR_VERSION)
+		if (result.uint_32 < NFS4_MIN_MINOR_VERSION ||
+		    result.uint_32 > NFS4_MAX_MINOR_VERSION)
 			goto out_of_bounds;
 		ctx->minorversion = result.uint_32;
 		break;
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index a5dd4a837769..5a6728acb589 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -10,6 +10,12 @@
 #ifndef __LINUX_FS_NFS_NFS4_FS_H
 #define __LINUX_FS_NFS_NFS4_FS_H
 
+#if defined(CONFIG_NFS_V4_0)
+#define NFS4_MIN_MINOR_VERSION 0
+#else
+#define NFS4_MIN_MINOR_VERSION 1
+#endif
+
 #if defined(CONFIG_NFS_V4_2)
 #define NFS4_MAX_MINOR_VERSION 2
 #elif defined(CONFIG_NFS_V4_1)
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index c376b2420b6c..00b57e55aba8 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -203,7 +203,8 @@ struct nfs_client *nfs4_alloc_client(const struct nfs_client_initdata *cl_init)
 	if (err)
 		goto error;
 
-	if (cl_init->minorversion > NFS4_MAX_MINOR_VERSION) {
+	if (cl_init->minorversion < NFS4_MIN_MINOR_VERSION ||
+	    cl_init->minorversion > NFS4_MAX_MINOR_VERSION) {
 		err = -EINVAL;
 		goto error;
 	}
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ae14e9d65e1b..7ff036afb0e3 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10560,7 +10560,9 @@ static const struct nfs4_minor_version_ops nfs_v4_2_minor_ops = {
 #endif
 
 const struct nfs4_minor_version_ops *nfs_v4_minor_ops[] = {
+#if defined(CONFIG_NFS_V4_0)
 	[0] = &nfs_v4_0_minor_ops,
+#endif /* CONFIG_NFS_V4_0 */
 #if defined(CONFIG_NFS_V4_1)
 	[1] = &nfs_v4_1_minor_ops,
 #endif
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index c7ee5318b660..fe7c0d7cdace 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1800,9 +1800,11 @@ static int nfs4_recovery_handle_error(struct nfs_client *clp, int error)
 	switch (error) {
 	case 0:
 		break;
+#if IS_ENABLED(CONFIG_NFS_V4_0)
 	case -NFS4ERR_CB_PATH_DOWN:
 		nfs40_handle_cb_pathdown(clp);
 		break;
+#endif /* CONFIG_NFS_V4_0 */
 	case -NFS4ERR_NO_GRACE:
 		nfs4_state_end_reclaim_reboot(clp);
 		break;
-- 
2.52.0


