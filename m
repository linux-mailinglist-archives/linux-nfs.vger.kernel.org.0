Return-Path: <linux-nfs+bounces-11300-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 384BFA9E517
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 01:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87EC189A9E3
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Apr 2025 23:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECBB1BC07A;
	Sun, 27 Apr 2025 23:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlFjeW5R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD8CB663
	for <linux-nfs@vger.kernel.org>; Sun, 27 Apr 2025 23:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745794905; cv=none; b=oFG0GPO4UlphL9mMGJjQdg4VXdUIN6xrpY2/IkjOdt/MfsGTRbxJzb9INfZcUD9WBFatA2He9q+ZXDIu/HkOSc7CNWlHT0y8IQs9b7I5xBuBUvWTnxxnjSbV5N8SLTUmsB8KhSNBbEkfJG23jhRckvQ0h6W8ZaL+jvrazRgS+S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745794905; c=relaxed/simple;
	bh=3pdjFAZoNvvEyVCzeMppvXJTU83KKEnE/PfIb4mBec0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gMr5nJ501mbKpH2p2J8Ynh88wOeYcVqbXBCo3570eiyG+bqs5rnI6uStuxuoJ9Qy3svJBY4pvUc45T2yZeQpcKPlzLAlCICkAeR2vnS/5M1V8O0LD3/zn1X/jbW0Z+ds6eP3wIv4wsZJEUu0rzO93pq/UKJHXlLyJi8AxHBCM/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlFjeW5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935FBC4CEE3;
	Sun, 27 Apr 2025 23:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745794903;
	bh=3pdjFAZoNvvEyVCzeMppvXJTU83KKEnE/PfIb4mBec0=;
	h=From:To:Cc:Subject:Date:From;
	b=hlFjeW5Rd0rvFOKNiqOHfj6KDY0lDHOPHtxjTXljvXe6guAFGXNi+PQpti35jnRjs
	 3y+xXKrSoWsstIyELUthx/r1W46ODjb45ytdXv3yO/bRSMp8Qvfm3RRaz1MVEg+QE4
	 3oiv7VsVHZ2YMSlGF+VoypPGRWK+EAPU587i6F3m3OzqZ3emUF03gaffp8cIgADtRq
	 8jZhQ3KPe1U3gNbnFex9C1LEGFbJZwRMHDeqx1pMMxL6tOxTGYUjkeDaNBf+0zXFCw
	 93uKhvQo842AOHFtfA4tyXJUfF4VCQFxsWZhkQc9nJx5fjYydKsdjW2SfwKDdEFGrJ
	 LjJs2+dsCDrmA==
From: trondmy@kernel.org
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Avoid flushing data while holding directory locks in nfs_rename()
Date: Sun, 27 Apr 2025 19:01:41 -0400
Message-ID: <a804c54445a3f028007763e05285d765afcab0f9.1745794273.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

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
---
 fs/nfs/client.c           |  2 ++
 fs/nfs/dir.c              | 15 ++++++++++++++-
 include/linux/nfs_fs_sb.h |  6 ++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 2115c1189c2d..6d63b958c4bb 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -1105,6 +1105,8 @@ struct nfs_server *nfs_create_server(struct fs_context *fc)
 		if (server->namelen == 0 || server->namelen > NFS2_MAXNAMLEN)
 			server->namelen = NFS2_MAXNAMLEN;
 	}
+	/* Linux 'subtree_check' borkenness mandates this setting */
+	server->fh_expire_type = NFS_FH_VOL_RENAME;
 
 	if (!(fattr->valid & NFS_ATTR_FATTR)) {
 		error = ctx->nfs_mod->rpc_ops->getattr(server, ctx->mntfh,
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index bd23fc736b39..d0e0b435a843 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2676,6 +2676,18 @@ nfs_unblock_rename(struct rpc_task *task, struct nfs_renamedata *data)
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
@@ -2763,7 +2775,8 @@ int nfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 	}
 
-	if (S_ISREG(old_inode->i_mode))
+	if (S_ISREG(old_inode->i_mode) &&
+	    nfs_rename_is_unsafe_cross_dir(old_dentry, new_dentry))
 		nfs_sync_inode(old_inode);
 	task = nfs_async_rename(old_dir, new_dir, old_dentry, new_dentry,
 				must_unblock ? nfs_unblock_rename : NULL);
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 71319637a84e..6732c7e04d19 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -236,6 +236,12 @@ struct nfs_server {
 	u32			acl_bitmask;	/* V4 bitmask representing the ACEs
 						   that are supported on this
 						   filesystem */
+	/* The following #defines numerically match the NFSv4 equivalents */
+#define NFS_FH_NOEXPIRE_WITH_OPEN (0x1)
+#define NFS_FH_VOLATILE_ANY (0x2)
+#define NFS_FH_VOL_MIGRATION (0x4)
+#define NFS_FH_VOL_RENAME (0x8)
+#define NFS_FH_RENAME_UNSAFE (NFS_FH_VOLATILE_ANY | NFS_FH_VOL_RENAME)
 	u32			fh_expire_type;	/* V4 bitmask representing file
 						   handle volatility type for
 						   this filesystem */
-- 
2.49.0


