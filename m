Return-Path: <linux-nfs+bounces-11825-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B01ABC978
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 23:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6533D7ABE30
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 21:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B7622FAD4;
	Mon, 19 May 2025 21:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6IqIWWx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B812C22F77C;
	Mon, 19 May 2025 21:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747689757; cv=none; b=hz4Q+UTigFTWsLnG1cuyVC41Il+8jbN05DxgVsq349xUdKaohUBUutBSKw4mqUnZUL6s+2SWJSsDUHZpDa6Cka8K8okFRajLPHhEupGdrf3Y0tQ8WPKiOR1fT2rfWcdvknXdAtGadm37bkqcaarP8GP1K9Ad7R2kSClxYUKlYe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747689757; c=relaxed/simple;
	bh=OSHl4uIWKgidVRiDssKehTz/7YhiYGoiz41vfgNOFzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p1uXi21Zu9E4WyOOPbPPyiA4CcZtM11XLvLPPaO66YspGw5v9tQjZFw5UsMV6j7Fy1/LkDIIxmVWyMlWruKEa9YYRn3cz2gl8RwM0yGSODEp9A9UqPcDU8x2Y1jtuHmtuGjgxkbUAPFPfoGdhG2LyrSW7qUybukqmD7l233c8D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6IqIWWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4403CC4CEEB;
	Mon, 19 May 2025 21:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747689757;
	bh=OSHl4uIWKgidVRiDssKehTz/7YhiYGoiz41vfgNOFzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d6IqIWWxIQT6OZ3Iyj0jnHKK7z8rnxHY7752EFBb4LL9pBPhNlMOejtTncrj2QV3E
	 37HoBaidgF16dylVAQwosjTKUdEQsRgIVVHoyGzs0UFym97W/TJBLiauXEepxfIv/c
	 H9oYHaueIj6KbeBUF9Fc5SZB6z8tRaSPkvhWfiwOtBme8wVJKhxbTiI5OdYBE6bWG5
	 I0ngyGffcrk3kXi/tGa3/CObnf4eM64GED/BojDrypTaMTjx5W4Rp831gbLulG6vfO
	 GQcKibNC0QGGRBe0YtgA/KqeNOnBe0LsMl+iAuCdhHx8c1JwPg/PLAoLgaLPFUpS4L
	 b2A7OG+MEVIqg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	anna.schumaker@netapp.com,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 18/18] NFS: Avoid flushing data while holding directory locks in nfs_rename()
Date: Mon, 19 May 2025 17:22:07 -0400
Message-Id: <20250519212208.1986028-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519212208.1986028-1-sashal@kernel.org>
References: <20250519212208.1986028-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.29
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
index 03ecc77656151..4503758e9594b 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -1096,6 +1096,8 @@ struct nfs_server *nfs_create_server(struct fs_context *fc)
 		if (server->namelen == 0 || server->namelen > NFS2_MAXNAMLEN)
 			server->namelen = NFS2_MAXNAMLEN;
 	}
+	/* Linux 'subtree_check' borkenness mandates this setting */
+	server->fh_expire_type = NFS_FH_VOL_RENAME;
 
 	if (!(fattr->valid & NFS_ATTR_FATTR)) {
 		error = ctx->nfs_mod->rpc_ops->getattr(server, ctx->mntfh,
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 492cffd9d3d84..f9f4a92f63e92 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2690,6 +2690,18 @@ nfs_unblock_rename(struct rpc_task *task, struct nfs_renamedata *data)
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
@@ -2777,7 +2789,8 @@ int nfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 	}
 
-	if (S_ISREG(old_inode->i_mode))
+	if (S_ISREG(old_inode->i_mode) &&
+	    nfs_rename_is_unsafe_cross_dir(old_dentry, new_dentry))
 		nfs_sync_inode(old_inode);
 	task = nfs_async_rename(old_dir, new_dir, old_dentry, new_dentry,
 				must_unblock ? nfs_unblock_rename : NULL);
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 81ab18658d72d..2cff5cafbaa78 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -211,6 +211,15 @@ struct nfs_server {
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
@@ -234,9 +243,6 @@ struct nfs_server {
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


