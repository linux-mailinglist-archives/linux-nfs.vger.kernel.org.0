Return-Path: <linux-nfs+bounces-16789-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA95C937DB
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Nov 2025 05:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 368DD3AA09F
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Nov 2025 04:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E2D22FE11;
	Sat, 29 Nov 2025 04:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Di5EKUao"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30FA22F76F
	for <linux-nfs@vger.kernel.org>; Sat, 29 Nov 2025 04:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764389196; cv=none; b=BuHHHpqc3h7i4UREzxXkhgPxYTbvrOUIlsB7l+qEnnZaeYDVEcSIAhoBaI7f76ac83zY/TPGgEWxgGw4lhU17s1j+9M5aVSnDsUjBMFVLsMjdhuJ3HeqmxXZ789jbHiYZ4a5Ggyi4O29FUJVoIweP0yMc9qIBTA0nn3Ja6jCeGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764389196; c=relaxed/simple;
	bh=+1b0w7DEiEQb1vtaQiaudYxqslIM3dBwfH79iTPJnIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCzJCxTrwBE/1ApomNwELybxmzZp6BNa3qMLg9P7jd1amb/jlnyoj0OshVQGWCa4ZPOvStXU056QgWf4peH5/R2UgPcX8RnBAfwdOdKLTqIxK+6REV8zf4709O9m5LS+He+EV7cA9swJIy7XuIB7WA+tg5Qlt2JolMaphNUP288=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Di5EKUao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F33EC116C6;
	Sat, 29 Nov 2025 04:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764389196;
	bh=+1b0w7DEiEQb1vtaQiaudYxqslIM3dBwfH79iTPJnIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Di5EKUao1DQkmUnlrQJC3z4Bso5M5RTOPR3VNWML8NdjIA+WAokGyieFDqN1od82M
	 wp1woWzTSdjw6moDr3IHFBk0rOuSh7W5NzwE8fKluvjMgexaFsLV14ACjeAXWihvH9
	 TUU4cO3KPmh3H4hFsSw92B9w+yIKw/IGZrckzzNUhuZ6z1H7M+zSHW/mw1hjds9+y6
	 BwebBXP39ZfpQypuV2plarzF3G4i5P6AWwW7sRu2tO+waQHzloq66mp2CpnzXQ9eb/
	 SNBckrxjXiaQ1Q5u2GuiajZYOhfkL1trwz6IrUdy3BhTZbSp3RE5ZCI7v9+TTq8xpa
	 P9GrdCtFHrDCw==
From: Trond Myklebust <trondmy@kernel.org>
To: Alkis Georgopoulos <alkisg@gmail.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 5/6] NFS: Fix inheritance of the block sizes when automounting
Date: Fri, 28 Nov 2025 23:06:31 -0500
Message-ID: <7274a800fc6fcc6c636ca84d6426c69ba5a7af58.1764388528.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764388528.git.trond.myklebust@hammerspace.com>
References: <cbd4d74d-21c4-42d6-9442-276fd98313ee@gmail.com> <cover.1764388528.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Only inherit the block sizes that were actually specified as mount
parameters for the parent mount.

Fixes: 62a55d088cd8 ("NFS: Additional refactoring for fs_context conversion")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/client.c           | 21 +++++++++++++++++----
 fs/nfs/internal.h         |  1 -
 fs/nfs/namespace.c        |  5 ++++-
 fs/nfs/nfs4client.c       | 18 ++++++++++++++----
 fs/nfs/super.c            | 10 +++-------
 include/linux/nfs_fs_sb.h |  5 +++++
 6 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 54699299d5b1..2aaea9c98c2c 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -784,10 +784,18 @@ static int nfs_init_server(struct nfs_server *server,
 		server->fattr_valid = NFS_ATTR_FATTR_V4;
 	}
 
-	if (ctx->rsize)
+	if (ctx->bsize) {
+		server->bsize = ctx->bsize;
+		server->automount_inherit |= NFS_AUTOMOUNT_INHERIT_BSIZE;
+	}
+	if (ctx->rsize) {
 		server->rsize = nfs_io_size(ctx->rsize, clp->cl_proto);
-	if (ctx->wsize)
+		server->automount_inherit |= NFS_AUTOMOUNT_INHERIT_RSIZE;
+	}
+	if (ctx->wsize) {
 		server->wsize = nfs_io_size(ctx->wsize, clp->cl_proto);
+		server->automount_inherit |= NFS_AUTOMOUNT_INHERIT_WSIZE;
+	}
 
 	server->acregmin = ctx->acregmin * HZ;
 	server->acregmax = ctx->acregmax * HZ;
@@ -977,8 +985,13 @@ EXPORT_SYMBOL_GPL(nfs_probe_server);
 void nfs_server_copy_userdata(struct nfs_server *target, struct nfs_server *source)
 {
 	target->flags = source->flags;
-	target->rsize = source->rsize;
-	target->wsize = source->wsize;
+	target->automount_inherit = source->automount_inherit;
+	if (source->automount_inherit & NFS_AUTOMOUNT_INHERIT_BSIZE)
+		target->bsize = source->bsize;
+	if (source->automount_inherit & NFS_AUTOMOUNT_INHERIT_RSIZE)
+		target->rsize = source->rsize;
+	if (source->automount_inherit & NFS_AUTOMOUNT_INHERIT_WSIZE)
+		target->wsize = source->wsize;
 	target->acregmin = source->acregmin;
 	target->acregmax = source->acregmax;
 	target->acdirmin = source->acdirmin;
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index ffd382aa31ac..2e596244799f 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -152,7 +152,6 @@ struct nfs_fs_context {
 		struct super_block	*sb;
 		struct dentry		*dentry;
 		struct nfs_fattr	*fattr;
-		unsigned int		inherited_bsize;
 	} clone_data;
 };
 
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index dca055676c4f..9e4d94f41fc6 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -190,6 +190,10 @@ struct vfsmount *nfs_d_automount(struct path *path)
 	ctx->nfs_mod		= client->cl_nfs_mod;
 	get_nfs_version(ctx->nfs_mod);
 
+	/* Inherit block sizes if they were specified as mount parameters */
+	if (server->automount_inherit & NFS_AUTOMOUNT_INHERIT_BSIZE)
+		ctx->bsize = server->bsize;
+
 	ret = client->rpc_ops->submount(fc, server);
 	if (ret < 0) {
 		mnt = ERR_PTR(ret);
@@ -289,7 +293,6 @@ int nfs_do_submount(struct fs_context *fc)
 		return -ENOMEM;
 
 	ctx->internal		= true;
-	ctx->clone_data.inherited_bsize = ctx->clone_data.sb->s_blocksize_bits;
 
 	p = nfs_devname(dentry, buffer, 4096);
 	if (IS_ERR(p)) {
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 4e972f85d0ca..96bccefbe2cb 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1179,10 +1179,20 @@ static int nfs4_init_server(struct nfs_server *server, struct fs_context *fc)
 	if (error < 0)
 		return error;
 
-	if (ctx->rsize)
-		server->rsize = nfs_io_size(ctx->rsize, server->nfs_client->cl_proto);
-	if (ctx->wsize)
-		server->wsize = nfs_io_size(ctx->wsize, server->nfs_client->cl_proto);
+	if (ctx->bsize) {
+		server->bsize = ctx->bsize;
+		server->automount_inherit |= NFS_AUTOMOUNT_INHERIT_BSIZE;
+	}
+	if (ctx->rsize) {
+		server->rsize =
+			nfs_io_size(ctx->rsize, server->nfs_client->cl_proto);
+		server->automount_inherit |= NFS_AUTOMOUNT_INHERIT_RSIZE;
+	}
+	if (ctx->wsize) {
+		server->wsize =
+			nfs_io_size(ctx->wsize, server->nfs_client->cl_proto);
+		server->automount_inherit |= NFS_AUTOMOUNT_INHERIT_WSIZE;
+	}
 
 	server->acregmin = ctx->acregmin * HZ;
 	server->acregmax = ctx->acregmax * HZ;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 66413133b43e..57d372db03b9 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1091,8 +1091,9 @@ static void nfs_fill_super(struct super_block *sb, struct nfs_fs_context *ctx)
 	sb->s_blocksize = 0;
 	sb->s_xattr = server->nfs_client->cl_nfs_mod->xattr;
 	sb->s_op = server->nfs_client->cl_nfs_mod->sops;
-	if (ctx->bsize)
-		sb->s_blocksize = nfs_block_size(ctx->bsize, &sb->s_blocksize_bits);
+	if (server->bsize)
+		sb->s_blocksize =
+			nfs_block_size(server->bsize, &sb->s_blocksize_bits);
 
 	switch (server->nfs_client->rpc_ops->version) {
 	case 2:
@@ -1338,13 +1339,8 @@ int nfs_get_tree_common(struct fs_context *fc)
 	}
 
 	if (!s->s_root) {
-		unsigned bsize = ctx->clone_data.inherited_bsize;
 		/* initial superblock/root creation */
 		nfs_fill_super(s, ctx);
-		if (bsize) {
-			s->s_blocksize_bits = bsize;
-			s->s_blocksize = 1U << bsize;
-		}
 		error = nfs_get_cache_cookie(s, ctx);
 		if (error < 0)
 			goto error_splat_super;
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 4ba04de6b1ca..c58b870f31ee 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -172,6 +172,11 @@ struct nfs_server {
 #define NFS_MOUNT_FORCE_RDIRPLUS	0x20000000
 #define NFS_MOUNT_NETUNREACH_FATAL	0x40000000
 
+	unsigned int		automount_inherit; /* Properties inherited by automount */
+#define NFS_AUTOMOUNT_INHERIT_BSIZE	0x0001
+#define NFS_AUTOMOUNT_INHERIT_RSIZE	0x0002
+#define NFS_AUTOMOUNT_INHERIT_WSIZE	0x0004
+
 	unsigned int		caps;		/* server capabilities */
 	__u64			fattr_valid;	/* Valid attributes */
 	unsigned int		rsize;		/* read size */
-- 
2.52.0


