Return-Path: <linux-nfs+bounces-11823-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AB6ABC94A
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 23:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A9C1897B32
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 21:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149F5224885;
	Mon, 19 May 2025 21:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uk+Ydp/R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97BB224247;
	Mon, 19 May 2025 21:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747689728; cv=none; b=S410bSyBhtUzGy+Y++o7JQEIs9fK5Njsr3lE1NWZoxFVgjepHZk/WEeT4QO/Zt4+QlrMaK0/z39yLZ7+WaTq3AzNnioTY7bzcqJfnUNOGGMv1Dp89KuY4C1rMqP2tiF8QuoMNAYQAZ8gaDE9ehQXn2DkQyszDfw2JoquzUf9ouM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747689728; c=relaxed/simple;
	bh=jUMi/X7EtV7KPHgjiIURyFF/jxseJtRKx3n7/NlOhdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m9Fgt6c79hXZjoGJ11PJh5g5A0Cp4jhsucVsCj9oUv6LXRqEsuXziaeLpmx87prgwPnFb/kiVuyarUqTyKOTgJ9GCY5JQfu8wpbuHLRD2qbaGdsy92EnmEoICyF9AKsk3Aoqu9jgLCY//5+v9E7DI6cBa2wMob9Zbn86czBjLi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uk+Ydp/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC66C4CEED;
	Mon, 19 May 2025 21:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747689727;
	bh=jUMi/X7EtV7KPHgjiIURyFF/jxseJtRKx3n7/NlOhdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uk+Ydp/RAeerKTRa4TS1/skX/LHYXJHlLCGzIB0mx8cHIrlQ/Md3KM8TnioAzLn6U
	 HVjbJVX7hq1XTPuL18/vXdDguvRLdAy9L2LZ2WREWl/SaEvR146CoyPKQm94jiScsz
	 NrVdsHw+EEeKPVTMps164PgM1NZh5HewXmE3rxjBcDFWQDmdUNN/Quwfzk7Sob9qvi
	 MddfJrpKJSGV70YGR1uYjTQxfChDe4RaubyumgdXKu8/4P9OujgMBR/qOUJ14A3XFE
	 wKh+ef6brfKmF97M9UVXLuDyXBOHmWoyaudWWS7G4k7zIawQd5d8u9Fywx7h2hP7Nf
	 sCkohCvtb7p0A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	anna.schumaker@netapp.com,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 23/23] NFS: Avoid flushing data while holding directory locks in nfs_rename()
Date: Mon, 19 May 2025 17:21:30 -0400
Message-Id: <20250519212131.1985647-23-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519212131.1985647-1-sashal@kernel.org>
References: <20250519212131.1985647-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.7
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit dcd21b609d4abc7303f8683bce4f35d78d7d6830 ]

The Linux client assumes that all filehandles are non-volatile for
renames within the same directory (otherwise sillyrename cannot work).
However, the existence of the Linux 'subtree_check' export option has
meant that nfs_rename() has always assumed it needs to flush writes
before attempting to rename.

Since NFSv4 does allow the client to query whether or not the server
exhibits this behaviour, and since knfsd does actually set the
appropriate flag when 'subtree_check' is enabled on an export, it
should be OK to optimise away the write flushing behaviour in the cases
where it is clearly not needed.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/client.c           |  2 ++
 fs/nfs/dir.c              | 15 ++++++++++++++-
 include/linux/nfs_fs_sb.h | 12 +++++++++---
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 3b0918ade53cd..a10d39150abc8 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -1100,6 +1100,8 @@ struct nfs_server *nfs_create_server(struct fs_context *fc)
 		if (server->namelen == 0 || server->namelen > NFS2_MAXNAMLEN)
 			server->namelen = NFS2_MAXNAMLEN;
 	}
+	/* Linux 'subtree_check' borkenness mandates this setting */
+	server->fh_expire_type = NFS_FH_VOL_RENAME;
 
 	if (!(fattr->valid & NFS_ATTR_FATTR)) {
 		error = ctx->nfs_mod->rpc_ops->getattr(server, ctx->mntfh,
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 2b04038b0e405..34f3471ce813b 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2678,6 +2678,18 @@ nfs_unblock_rename(struct rpc_task *task, struct nfs_renamedata *data)
 	unblock_revalidate(new_dentry);
 }
 
+static bool nfs_rename_is_unsafe_cross_dir(struct dentry *old_dentry,
+					   struct dentry *new_dentry)
+{
+	struct nfs_server *server = NFS_SB(old_dentry->d_sb);
+
+	if (old_dentry->d_parent != new_dentry->d_parent)
+		return false;
+	if (server->fh_expire_type & NFS_FH_RENAME_UNSAFE)
+		return !(server->fh_expire_type & NFS_FH_NOEXPIRE_WITH_OPEN);
+	return true;
+}
+
 /*
  * RENAME
  * FIXME: Some nfsds, like the Linux user space nfsd, may generate a
@@ -2765,7 +2777,8 @@ int nfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 	}
 
-	if (S_ISREG(old_inode->i_mode))
+	if (S_ISREG(old_inode->i_mode) &&
+	    nfs_rename_is_unsafe_cross_dir(old_dentry, new_dentry))
 		nfs_sync_inode(old_inode);
 	task = nfs_async_rename(old_dir, new_dir, old_dentry, new_dentry,
 				must_unblock ? nfs_unblock_rename : NULL);
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 108862d81b579..8baaad2dfbe40 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -210,6 +210,15 @@ struct nfs_server {
 	char			*fscache_uniq;	/* Uniquifier (or NULL) */
 #endif
 
+	/* The following #defines numerically match the NFSv4 equivalents */
+#define NFS_FH_NOEXPIRE_WITH_OPEN (0x1)
+#define NFS_FH_VOLATILE_ANY (0x2)
+#define NFS_FH_VOL_MIGRATION (0x4)
+#define NFS_FH_VOL_RENAME (0x8)
+#define NFS_FH_RENAME_UNSAFE (NFS_FH_VOLATILE_ANY | NFS_FH_VOL_RENAME)
+	u32			fh_expire_type;	/* V4 bitmask representing file
+						   handle volatility type for
+						   this filesystem */
 	u32			pnfs_blksize;	/* layout_blksize attr */
 #if IS_ENABLED(CONFIG_NFS_V4)
 	u32			attr_bitmask[3];/* V4 bitmask representing the set
@@ -233,9 +242,6 @@ struct nfs_server {
 	u32			acl_bitmask;	/* V4 bitmask representing the ACEs
 						   that are supported on this
 						   filesystem */
-	u32			fh_expire_type;	/* V4 bitmask representing file
-						   handle volatility type for
-						   this filesystem */
 	struct pnfs_layoutdriver_type  *pnfs_curr_ld; /* Active layout driver */
 	struct rpc_wait_queue	roc_rpcwaitq;
 	void			*pnfs_ld_data;	/* per mount point data */
-- 
2.39.5


