Return-Path: <linux-nfs+bounces-10722-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0342A6AC54
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Mar 2025 18:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B093C8A3C54
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Mar 2025 17:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358AC225793;
	Thu, 20 Mar 2025 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/A7CPUN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1204E225785
	for <linux-nfs@vger.kernel.org>; Thu, 20 Mar 2025 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492683; cv=none; b=s0belnjTy6PUMtbubJ/BtJaJsJDru7dGAtm/zh9T9uRfkD21FarJ/TSx2yG8d/GvoAMd9ldhmVxOzUePAg3naHUXU+jd8CPpGj4rh4jq9FwngmGlk5l50Jr2Dv5CQ/ojDCmSaUIXxefctuwexLrvsyqEAUi3aUG/a6AxxogAucE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492683; c=relaxed/simple;
	bh=tKQpeY+RK+uF3VsSq1lAUuwbkicudUKI6dH8jeka+0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UlalvEvLbkdaEs+GduQAliVDXX9OzSmhNKXcbBui2wBqWrKUZjbKS7rYhX5McAcbcUb83WEs0uX6n69/2vthhNmtbsF27Ht2wikkjkwV32p87i5e1mHbWYM33rKYV2jw9ueY6P0a8bgGx2B3srQqj6eYherT5ESER0gkhsrkOIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/A7CPUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33667C4CEE7;
	Thu, 20 Mar 2025 17:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742492682;
	bh=tKQpeY+RK+uF3VsSq1lAUuwbkicudUKI6dH8jeka+0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W/A7CPUNw7atWux96qUXYyI3l9xTUYhJa2hvDJ1yLm2/zE1P4ojyDxc9JCd9K7Y4F
	 QgOmKXFw+9BDYwJqdqEZBGGVldtz8Qnc6Ab2Qw27gGlDcpKRC3dPVt8YLXld38l9Ku
	 ug5EJVq13jA0LZF0wpRVZKoJo51V2PlbMqafIG8VAENeB6RMCsUHMxapQs5TG8eyHX
	 2zcWVu9r4FeEenx4WVPGLXJVbVlyI/VpXzk8KZTgzLzLB+Etu3Me8GeIT3tk4eHeQI
	 X5VC2/On3g8S/crNN9pEtXE6XvrNJ+gWXjIpll7frbtrJvGYxhOKP7im9vRSi3rH4O
	 Gv7FE055gZEjw==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RFC 1/4] NFS: Add a mount option to make ENETUNREACH errors fatal
Date: Thu, 20 Mar 2025 13:44:37 -0400
Message-ID: <491eb86d67560b30d1b31e9f085910f1dbfe02b5.1742490771.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742490771.git.trond.myklebust@hammerspace.com>
References: <cover.1742490771.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the NFS client was initially created in a container, and that
container is torn down, there is usually no possibity to go back and
destroy any NFS clients that are hung because their virtual network
devices have been unlinked.

Add a flag that tells the NFS client that in these circumstances, it
should treat ENETDOWN and ENETUNREACH errors as fatal to the NFS client.

The option defaults to being on when the mount happens from inside a net
namespace that is not "init_net".

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/fs_context.c       | 38 ++++++++++++++++++++++++++++++++++++++
 fs/nfs/super.c            |  2 ++
 include/linux/nfs_fs_sb.h |  1 +
 3 files changed, 41 insertions(+)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 1cabba1231d6..5eb8c0a7833b 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -50,6 +50,7 @@ enum nfs_param {
 	Opt_clientaddr,
 	Opt_cto,
 	Opt_alignwrite,
+	Opt_fatal_neterrors,
 	Opt_fg,
 	Opt_fscache,
 	Opt_fscache_flag,
@@ -97,6 +98,20 @@ enum nfs_param {
 	Opt_xprtsec,
 };
 
+enum {
+	Opt_fatal_neterrors_default,
+	Opt_fatal_neterrors_enetunreach,
+	Opt_fatal_neterrors_none,
+};
+
+static const struct constant_table nfs_param_enums_fatal_neterrors[] = {
+	{ "default",			Opt_fatal_neterrors_default },
+	{ "enetdown:enetunreach",	Opt_fatal_neterrors_enetunreach },
+	{ "enetunreach:enetdown",	Opt_fatal_neterrors_enetunreach },
+	{ "none",			Opt_fatal_neterrors_none },
+	{}
+};
+
 enum {
 	Opt_local_lock_all,
 	Opt_local_lock_flock,
@@ -153,6 +168,7 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
 	fsparam_string("clientaddr",	Opt_clientaddr),
 	fsparam_flag_no("cto",		Opt_cto),
 	fsparam_flag_no("alignwrite",	Opt_alignwrite),
+	fsparam_enum  ("fatal_errors",	Opt_fatal_neterrors, nfs_param_enums_fatal_neterrors),
 	fsparam_flag  ("fg",		Opt_fg),
 	fsparam_flag_no("fsc",		Opt_fscache_flag),
 	fsparam_string("fsc",		Opt_fscache),
@@ -896,6 +912,25 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 			goto out_of_bounds;
 		ctx->nfs_server.max_connect = result.uint_32;
 		break;
+	case Opt_fatal_neterrors:
+		trace_nfs_mount_assign(param->key, param->string);
+		switch (result.uint_32) {
+		case Opt_fatal_neterrors_default:
+			if (fc->net_ns != &init_net)
+				ctx->flags |= NFS_MOUNT_NETUNREACH_FATAL;
+			else
+				ctx->flags &= ~NFS_MOUNT_NETUNREACH_FATAL;
+			break;
+		case Opt_fatal_neterrors_enetunreach:
+			ctx->flags |= NFS_MOUNT_NETUNREACH_FATAL;
+			break;
+		case Opt_fatal_neterrors_none:
+			ctx->flags &= ~NFS_MOUNT_NETUNREACH_FATAL;
+			break;
+		default:
+			goto out_invalid_value;
+		}
+		break;
 	case Opt_lookupcache:
 		trace_nfs_mount_assign(param->key, param->string);
 		switch (result.uint_32) {
@@ -1675,6 +1710,9 @@ static int nfs_init_fs_context(struct fs_context *fc)
 		ctx->xprtsec.cert_serial	= TLS_NO_CERT;
 		ctx->xprtsec.privkey_serial	= TLS_NO_PRIVKEY;
 
+		if (fc->net_ns != &init_net)
+			ctx->flags |= NFS_MOUNT_NETUNREACH_FATAL;
+
 		fc->s_iflags		|= SB_I_STABLE_WRITES;
 	}
 	fc->fs_private = ctx;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 96de658a7886..23ed1ed67a10 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -457,6 +457,8 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
 		{ NFS_MOUNT_FORCE_RDIRPLUS, ",rdirplus=force", "" },
 		{ NFS_MOUNT_UNSHARED, ",nosharecache", "" },
 		{ NFS_MOUNT_NORESVPORT, ",noresvport", "" },
+		{ NFS_MOUNT_NETUNREACH_FATAL,
+		  ",fatal_neterrors=enetdown:enetunreach", "" },
 		{ 0, NULL, NULL }
 	};
 	const struct proc_nfs_info *nfs_infop;
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index b83d16a42afc..a6ce8590eaaf 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -168,6 +168,7 @@ struct nfs_server {
 #define NFS_MOUNT_SHUTDOWN			0x08000000
 #define NFS_MOUNT_NO_ALIGNWRITE		0x10000000
 #define NFS_MOUNT_FORCE_RDIRPLUS	0x20000000
+#define NFS_MOUNT_NETUNREACH_FATAL	0x40000000
 
 	unsigned int		fattr_valid;	/* Valid attributes */
 	unsigned int		caps;		/* server capabilities */
-- 
2.48.1


