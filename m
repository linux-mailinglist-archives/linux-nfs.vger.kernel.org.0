Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C4F35F536
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 15:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351573AbhDNNoi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 09:44:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351603AbhDNNoW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Apr 2021 09:44:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32AC7611EE
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 13:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618407841;
        bh=xKJymU46EqNzUiOhqZkOg7fT8IqRD5Pe1IhFYJauDUM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ec0DP01RNvPEfT2QUKQZnVZUZPzr/GuhP3tyhnB78NnQasAp5j1iPOzdulHGco1wl
         OfUSmeL99SaV5mc00CHgc8/oJg/vgzoueqky2na4L21/yITTDRXAnrGeTU6E4B8jN1
         fhDoFpf2J4zenfPvmCZc4kp2EvAAzJx/Mh1PquyjjveYSeI0el3ozVsinrRklCbKGe
         pn7VakmhoyraS5Umyb7e57fZs1/ZP58RIeOnNScoALnsFcYMpjr+74kS7lgofKqkJ8
         dr9BZTw+FQbGHh+7WJeLRan8IPro9zAIgqFXOcAR+NKZrLyzXfoo9AhDnOJkGaOiSM
         lUY1zkHUNgf0g==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 14/26] NFS: Separate tracking of file mode cache validity from the uid/gid
Date:   Wed, 14 Apr 2021 09:43:41 -0400
Message-Id: <20210414134353.11860-15-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414134353.11860-14-trondmy@kernel.org>
References: <20210414134353.11860-1-trondmy@kernel.org>
 <20210414134353.11860-2-trondmy@kernel.org>
 <20210414134353.11860-3-trondmy@kernel.org>
 <20210414134353.11860-4-trondmy@kernel.org>
 <20210414134353.11860-5-trondmy@kernel.org>
 <20210414134353.11860-6-trondmy@kernel.org>
 <20210414134353.11860-7-trondmy@kernel.org>
 <20210414134353.11860-8-trondmy@kernel.org>
 <20210414134353.11860-9-trondmy@kernel.org>
 <20210414134353.11860-10-trondmy@kernel.org>
 <20210414134353.11860-11-trondmy@kernel.org>
 <20210414134353.11860-12-trondmy@kernel.org>
 <20210414134353.11860-13-trondmy@kernel.org>
 <20210414134353.11860-14-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

chown()/chgrp() and chmod() are separate operations, and in addition,
there are mode operations that are performed automatically by the
server. So let's track mode validity separately from the file ownership
validity.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c           |  5 +++--
 fs/nfs/inode.c         | 18 ++++++++++++------
 fs/nfs/nfs4proc.c      | 14 +++++++++-----
 fs/nfs/nfstrace.h      |  4 +++-
 fs/nfs/write.c         |  2 +-
 include/linux/nfs_fs.h |  2 ++
 6 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index f748d2294261..d2835d211a73 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2948,7 +2948,7 @@ static int nfs_execute_ok(struct inode *inode, int mask)
 
 	if (S_ISDIR(inode->i_mode))
 		return 0;
-	if (nfs_check_cache_invalid(inode, NFS_INO_INVALID_OTHER)) {
+	if (nfs_check_cache_invalid(inode, NFS_INO_INVALID_MODE)) {
 		if (mask & MAY_NOT_BLOCK)
 			return -ECHILD;
 		ret = __nfs_revalidate_inode(server, inode);
@@ -3006,7 +3006,8 @@ int nfs_permission(struct user_namespace *mnt_userns,
 	if (mask & MAY_NOT_BLOCK)
 		return -ECHILD;
 
-	res = nfs_revalidate_inode(inode, NFS_INO_INVALID_OTHER);
+	res = nfs_revalidate_inode(inode, NFS_INO_INVALID_MODE |
+						  NFS_INO_INVALID_OTHER);
 	if (res == 0)
 		res = generic_permission(&init_user_ns, inode, mask);
 	goto out;
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 7bf9138330f2..81e3e140e923 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -199,7 +199,8 @@ void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 
 	if (have_delegation) {
 		if (!(flags & NFS_INO_REVAL_FORCED))
-			flags &= ~NFS_INO_INVALID_OTHER;
+			flags &= ~(NFS_INO_INVALID_MODE |
+				   NFS_INO_INVALID_OTHER);
 		flags &= ~(NFS_INO_INVALID_CHANGE
 				| NFS_INO_INVALID_SIZE
 				| NFS_INO_INVALID_XATTR);
@@ -472,7 +473,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr, st
 		nfsi->cache_validity = 0;
 		if ((fattr->valid & NFS_ATTR_FATTR_MODE) == 0
 				&& nfs_server_capable(inode, NFS_CAP_MODE))
-			nfs_set_cache_invalid(inode, NFS_INO_INVALID_OTHER);
+			nfs_set_cache_invalid(inode, NFS_INO_INVALID_MODE);
 		/* Why so? Because we want revalidate for devices/FIFOs, and
 		 * that's precisely what we have in nfs_file_inode_operations.
 		 */
@@ -803,8 +804,10 @@ static u32 nfs_get_valid_attrmask(struct inode *inode)
 		reply_mask |= STATX_SIZE;
 	if (!(cache_validity & NFS_INO_INVALID_NLINK))
 		reply_mask |= STATX_NLINK;
+	if (!(cache_validity & NFS_INO_INVALID_MODE))
+		reply_mask |= STATX_MODE;
 	if (!(cache_validity & NFS_INO_INVALID_OTHER))
-		reply_mask |= STATX_UID | STATX_GID | STATX_MODE;
+		reply_mask |= STATX_UID | STATX_GID;
 	if (!(cache_validity & NFS_INO_INVALID_BLOCKS))
 		reply_mask |= STATX_BLOCKS;
 	return reply_mask;
@@ -872,7 +875,9 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		do_update |= cache_validity & NFS_INO_INVALID_SIZE;
 	if (request_mask & STATX_NLINK)
 		do_update |= cache_validity & NFS_INO_INVALID_NLINK;
-	if (request_mask & (STATX_UID | STATX_GID | STATX_MODE))
+	if (request_mask & STATX_MODE)
+		do_update |= cache_validity & NFS_INO_INVALID_MODE;
+	if (request_mask & (STATX_UID | STATX_GID))
 		do_update |= cache_validity & NFS_INO_INVALID_OTHER;
 	if (request_mask & STATX_BLOCKS)
 		do_update |= cache_validity & NFS_INO_INVALID_BLOCKS;
@@ -1510,7 +1515,7 @@ static int nfs_check_inode_attributes(struct inode *inode, struct nfs_fattr *fat
 	if ((fattr->valid & NFS_ATTR_FATTR_MODE) && (inode->i_mode & S_IALLUGO) != (fattr->mode & S_IALLUGO))
 		invalid |= NFS_INO_INVALID_ACCESS
 			| NFS_INO_INVALID_ACL
-			| NFS_INO_INVALID_OTHER;
+			| NFS_INO_INVALID_MODE;
 	if ((fattr->valid & NFS_ATTR_FATTR_OWNER) && !uid_eq(inode->i_uid, fattr->uid))
 		invalid |= NFS_INO_INVALID_ACCESS
 			| NFS_INO_INVALID_ACL
@@ -1947,6 +1952,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 					| NFS_INO_INVALID_SIZE
 					| NFS_INO_INVALID_BLOCKS
 					| NFS_INO_INVALID_NLINK
+					| NFS_INO_INVALID_MODE
 					| NFS_INO_INVALID_OTHER;
 				if (S_ISDIR(inode->i_mode))
 					nfs_force_lookup_revalidate(inode);
@@ -2037,7 +2043,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 		}
 	} else if (server->caps & NFS_CAP_MODE) {
 		nfsi->cache_validity |= save_cache_validity &
-				(NFS_INO_INVALID_OTHER
+				(NFS_INO_INVALID_MODE
 				| NFS_INO_REVAL_FORCED);
 		cache_revalidated = false;
 	}
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a74c1c3c4192..bc90f2a12d5d 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -302,9 +302,10 @@ static void nfs4_bitmap_copy_adjust(__u32 *dst, const __u32 *src,
 	if (!(cache_validity & NFS_INO_INVALID_CHANGE))
 		dst[0] &= ~FATTR4_WORD0_CHANGE;
 
+	if (!(cache_validity & NFS_INO_INVALID_MODE))
+		dst[1] &= ~FATTR4_WORD1_MODE;
 	if (!(cache_validity & NFS_INO_INVALID_OTHER))
-		dst[1] &= ~(FATTR4_WORD1_MODE | FATTR4_WORD1_OWNER |
-			    FATTR4_WORD1_OWNER_GROUP);
+		dst[1] &= ~(FATTR4_WORD1_OWNER | FATTR4_WORD1_OWNER_GROUP);
 }
 
 static void nfs4_setup_readdir(u64 cookie, __be32 *verifier, struct dentry *dentry,
@@ -3344,7 +3345,9 @@ static int nfs4_do_setattr(struct inode *inode, const struct cred *cred,
 	unsigned long adjust_flags = NFS_INO_INVALID_CHANGE;
 	int err;
 
-	if (sattr->ia_valid & (ATTR_MODE|ATTR_UID|ATTR_GID))
+	if (sattr->ia_valid & (ATTR_MODE | ATTR_KILL_SUID | ATTR_KILL_SGID))
+		adjust_flags |= NFS_INO_INVALID_MODE;
+	if (sattr->ia_valid & (ATTR_UID | ATTR_GID))
 		adjust_flags |= NFS_INO_INVALID_OTHER;
 
 	do {
@@ -5431,9 +5434,10 @@ static void nfs4_bitmask_set(__u32 bitmask[NFS4_BITMASK_SZ], const __u32 *src,
 		bitmask[0] |= FATTR4_WORD0_CHANGE;
 	if (cache_validity & NFS_INO_INVALID_ATIME)
 		bitmask[1] |= FATTR4_WORD1_TIME_ACCESS;
+	if (cache_validity & NFS_INO_INVALID_MODE)
+		bitmask[1] |= FATTR4_WORD1_MODE;
 	if (cache_validity & NFS_INO_INVALID_OTHER)
-		bitmask[1] |= FATTR4_WORD1_MODE | FATTR4_WORD1_OWNER |
-				FATTR4_WORD1_OWNER_GROUP;
+		bitmask[1] |= FATTR4_WORD1_OWNER | FATTR4_WORD1_OWNER_GROUP;
 	if (cache_validity & NFS_INO_INVALID_NLINK)
 		bitmask[1] |= FATTR4_WORD1_NUMLINKS;
 	if (label && label->len && cache_validity & NFS_INO_INVALID_LABEL)
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index a0ebc53160dd..41a161cd31f6 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -49,6 +49,7 @@ TRACE_DEFINE_ENUM(NFS_INO_DATA_INVAL_DEFER);
 TRACE_DEFINE_ENUM(NFS_INO_INVALID_BLOCKS);
 TRACE_DEFINE_ENUM(NFS_INO_INVALID_XATTR);
 TRACE_DEFINE_ENUM(NFS_INO_INVALID_NLINK);
+TRACE_DEFINE_ENUM(NFS_INO_INVALID_MODE);
 
 #define nfs_show_cache_validity(v) \
 	__print_flags(v, "|", \
@@ -67,7 +68,8 @@ TRACE_DEFINE_ENUM(NFS_INO_INVALID_NLINK);
 			{ NFS_INO_DATA_INVAL_DEFER, "DATA_INVAL_DEFER" }, \
 			{ NFS_INO_INVALID_BLOCKS, "INVALID_BLOCKS" }, \
 			{ NFS_INO_INVALID_XATTR, "INVALID_XATTR" }, \
-			{ NFS_INO_INVALID_NLINK, "INVALID_NLINK" })
+			{ NFS_INO_INVALID_NLINK, "INVALID_NLINK" }, \
+			{ NFS_INO_INVALID_MODE, "INVALID_MODE" })
 
 TRACE_DEFINE_ENUM(NFS_INO_ADVISE_RDPLUS);
 TRACE_DEFINE_ENUM(NFS_INO_STALE);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 7a39b3d424da..61d1174935b6 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1604,7 +1604,7 @@ static int nfs_writeback_done(struct rpc_task *task,
 	/* Deal with the suid/sgid bit corner case */
 	if (nfs_should_remove_suid(inode)) {
 		spin_lock(&inode->i_lock);
-		nfs_set_cache_invalid(inode, NFS_INO_INVALID_OTHER);
+		nfs_set_cache_invalid(inode, NFS_INO_INVALID_MODE);
 		spin_unlock(&inode->i_lock);
 	}
 	return 0;
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 41165b988dfb..ffba254d2098 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -247,12 +247,14 @@ struct nfs4_copy_state {
 #define NFS_INO_INVALID_BLOCKS	BIT(14)         /* cached blocks are invalid */
 #define NFS_INO_INVALID_XATTR	BIT(15)		/* xattrs are invalid */
 #define NFS_INO_INVALID_NLINK	BIT(16)		/* cached nlinks is invalid */
+#define NFS_INO_INVALID_MODE	BIT(17)		/* cached mode is invalid */
 
 #define NFS_INO_INVALID_ATTR	(NFS_INO_INVALID_CHANGE \
 		| NFS_INO_INVALID_CTIME \
 		| NFS_INO_INVALID_MTIME \
 		| NFS_INO_INVALID_SIZE \
 		| NFS_INO_INVALID_NLINK \
+		| NFS_INO_INVALID_MODE \
 		| NFS_INO_INVALID_OTHER)	/* inode metadata is invalid */
 
 /*
-- 
2.30.2

