Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F4E34DCEB
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Mar 2021 02:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhC3ATP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Mar 2021 20:19:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230204AbhC3ASp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 29 Mar 2021 20:18:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2567860C41
        for <linux-nfs@vger.kernel.org>; Tue, 30 Mar 2021 00:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617063525;
        bh=WQIOev9Zy3UKdhTxeV4r5MBA9M0yKkMiqLxOwKpvlac=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jpNy+AP+TBMhWh8iNFtU6FhSYKHOFyVNTSPp3+qACWsa7Dg+vPLdURcZhM4WXNpHS
         YdmHLtpQCM8RclrLR+vwRDRlPWXyBxar+cgE6BMaY4jakXfTHwMkuCBmkeaGg0qlQr
         8gHHdaBaPvE6YNR8AKBeVJ9g7LNkkQbO9X/dnP7fXaW2bl2qWleLxG6mCa5I+tl89H
         G1VXfn4ayo4xqzp1adBLhrRriCUeg0hFlbmO2PDgeG+2ZIZ6BGpFGVHhs1OZPXmHCr
         Ok75sy5V8NLJ8GLTTAnCuEsq/pEx3sGyi7xpuwUpIF5RJfeIFC4wIb74Zy57fQ2lEj
         mkfaKH4TCTxkA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 11/17] NFS: Separate tracking of file nlinks cache validity from the mode/uid/gid
Date:   Mon, 29 Mar 2021 20:18:29 -0400
Message-Id: <20210330001835.41914-12-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330001835.41914-11-trondmy@kernel.org>
References: <20210330001835.41914-1-trondmy@kernel.org>
 <20210330001835.41914-2-trondmy@kernel.org>
 <20210330001835.41914-3-trondmy@kernel.org>
 <20210330001835.41914-4-trondmy@kernel.org>
 <20210330001835.41914-5-trondmy@kernel.org>
 <20210330001835.41914-6-trondmy@kernel.org>
 <20210330001835.41914-7-trondmy@kernel.org>
 <20210330001835.41914-8-trondmy@kernel.org>
 <20210330001835.41914-9-trondmy@kernel.org>
 <20210330001835.41914-10-trondmy@kernel.org>
 <20210330001835.41914-11-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Rename can cause us to revalidate the access cache, so lets track the
nlinks separately from the mode/uid/gid.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c           |  2 +-
 fs/nfs/inode.c         | 18 ++++++++++++------
 fs/nfs/nfs4proc.c      | 13 +++++++------
 fs/nfs/nfstrace.h      |  4 +++-
 include/linux/nfs_fs.h |  2 ++
 5 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e924d65c125e..f748d2294261 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1711,7 +1711,7 @@ static void nfs_drop_nlink(struct inode *inode)
 	NFS_I(inode)->attr_gencount = nfs_inc_attr_generation_counter();
 	nfs_set_cache_invalid(
 		inode, NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_CTIME |
-			       NFS_INO_INVALID_OTHER | NFS_INO_REVAL_FORCED);
+			       NFS_INO_INVALID_NLINK | NFS_INO_REVAL_FORCED);
 	spin_unlock(&inode->i_lock);
 }
 
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 25dc70adab87..c9386981d210 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -215,7 +215,8 @@ void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 
 	if (have_delegation) {
 		if (!(flags & NFS_INO_REVAL_FORCED))
-			flags &= ~NFS_INO_INVALID_OTHER;
+			flags &= ~(NFS_INO_INVALID_OTHER |
+				   NFS_INO_INVALID_NLINK);
 		flags &= ~(NFS_INO_INVALID_CHANGE
 				| NFS_INO_INVALID_SIZE
 				| NFS_INO_INVALID_XATTR);
@@ -554,7 +555,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr, st
 		if (fattr->valid & NFS_ATTR_FATTR_NLINK)
 			set_nlink(inode, fattr->nlink);
 		else if (nfs_server_capable(inode, NFS_CAP_NLINK))
-			nfs_set_cache_invalid(inode, NFS_INO_INVALID_OTHER);
+			nfs_set_cache_invalid(inode, NFS_INO_INVALID_NLINK);
 		if (fattr->valid & NFS_ATTR_FATTR_OWNER)
 			inode->i_uid = fattr->uid;
 		else if (nfs_server_capable(inode, NFS_CAP_OWNER))
@@ -811,8 +812,10 @@ static u32 nfs_get_valid_attrmask(struct inode *inode)
 		reply_mask |= STATX_MTIME;
 	if (!(cache_validity & NFS_INO_INVALID_SIZE))
 		reply_mask |= STATX_SIZE;
+	if (!(cache_validity & NFS_INO_INVALID_NLINK))
+		reply_mask |= STATX_NLINK;
 	if (!(cache_validity & NFS_INO_INVALID_OTHER))
-		reply_mask |= STATX_UID | STATX_GID | STATX_MODE | STATX_NLINK;
+		reply_mask |= STATX_UID | STATX_GID | STATX_MODE;
 	if (!(cache_validity & NFS_INO_INVALID_BLOCKS))
 		reply_mask |= STATX_BLOCKS;
 	return reply_mask;
@@ -878,7 +881,9 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		do_update |= cache_validity & NFS_INO_INVALID_MTIME;
 	if (request_mask & STATX_SIZE)
 		do_update |= cache_validity & NFS_INO_INVALID_SIZE;
-	if (request_mask & (STATX_UID | STATX_GID | STATX_MODE | STATX_NLINK))
+	if (request_mask & STATX_NLINK)
+		do_update |= cache_validity & NFS_INO_INVALID_NLINK;
+	if (request_mask & (STATX_UID | STATX_GID | STATX_MODE))
 		do_update |= cache_validity & NFS_INO_INVALID_OTHER;
 	if (request_mask & STATX_BLOCKS)
 		do_update |= cache_validity & NFS_INO_INVALID_BLOCKS;
@@ -1528,7 +1533,7 @@ static int nfs_check_inode_attributes(struct inode *inode, struct nfs_fattr *fat
 
 	/* Has the link count changed? */
 	if ((fattr->valid & NFS_ATTR_FATTR_NLINK) && inode->i_nlink != fattr->nlink)
-		invalid |= NFS_INO_INVALID_OTHER;
+		invalid |= NFS_INO_INVALID_NLINK;
 
 	ts = inode->i_atime;
 	if ((fattr->valid & NFS_ATTR_FATTR_ATIME) && !timespec64_equal(&ts, &fattr->atime))
@@ -1952,6 +1957,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 					| NFS_INO_INVALID_MTIME
 					| NFS_INO_INVALID_SIZE
 					| NFS_INO_INVALID_BLOCKS
+					| NFS_INO_INVALID_NLINK
 					| NFS_INO_INVALID_OTHER;
 				if (S_ISDIR(inode->i_mode))
 					nfs_force_lookup_revalidate(inode);
@@ -2084,7 +2090,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 		}
 	} else if (server->caps & NFS_CAP_NLINK) {
 		nfsi->cache_validity |= save_cache_validity &
-				(NFS_INO_INVALID_OTHER
+				(NFS_INO_INVALID_NLINK
 				| NFS_INO_REVAL_FORCED);
 		cache_revalidated = false;
 	}
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 64b3438aed78..d0ca1d51be33 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1170,14 +1170,14 @@ int nfs4_call_sync(struct rpc_clnt *clnt,
 static void
 nfs4_inc_nlink_locked(struct inode *inode)
 {
-	nfs_set_cache_invalid(inode, NFS_INO_INVALID_OTHER);
+	nfs_set_cache_invalid(inode, NFS_INO_INVALID_NLINK);
 	inc_nlink(inode);
 }
 
 static void
 nfs4_dec_nlink_locked(struct inode *inode)
 {
-	nfs_set_cache_invalid(inode, NFS_INO_INVALID_OTHER);
+	nfs_set_cache_invalid(inode, NFS_INO_INVALID_NLINK);
 	drop_nlink(inode);
 }
 
@@ -4719,11 +4719,11 @@ static int nfs4_proc_rename_done(struct rpc_task *task, struct inode *old_dir,
 			/* Note: If we moved a directory, nlink will change */
 			nfs4_update_changeattr(old_dir, &res->old_cinfo,
 					res->old_fattr->time_start,
-					NFS_INO_INVALID_OTHER |
+					NFS_INO_INVALID_NLINK |
 					    NFS_INO_INVALID_DATA);
 			nfs4_update_changeattr(new_dir, &res->new_cinfo,
 					res->new_fattr->time_start,
-					NFS_INO_INVALID_OTHER |
+					NFS_INO_INVALID_NLINK |
 					    NFS_INO_INVALID_DATA);
 		} else
 			nfs4_update_changeattr(old_dir, &res->old_cinfo,
@@ -5433,8 +5433,9 @@ static void nfs4_bitmask_set(__u32 bitmask[NFS4_BITMASK_SZ], const __u32 *src,
 		bitmask[1] |= FATTR4_WORD1_TIME_ACCESS;
 	if (cache_validity & NFS_INO_INVALID_OTHER)
 		bitmask[1] |= FATTR4_WORD1_MODE | FATTR4_WORD1_OWNER |
-				FATTR4_WORD1_OWNER_GROUP |
-				FATTR4_WORD1_NUMLINKS;
+				FATTR4_WORD1_OWNER_GROUP;
+	if (cache_validity & NFS_INO_INVALID_NLINK)
+		bitmask[1] |= FATTR4_WORD1_NUMLINKS;
 	if (label && label->len && cache_validity & NFS_INO_INVALID_LABEL)
 		bitmask[2] |= FATTR4_WORD2_SECURITY_LABEL;
 	if (cache_validity & NFS_INO_INVALID_CTIME)
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index cdba6eebe3cb..a0ebc53160dd 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -48,6 +48,7 @@ TRACE_DEFINE_ENUM(NFS_INO_INVALID_OTHER);
 TRACE_DEFINE_ENUM(NFS_INO_DATA_INVAL_DEFER);
 TRACE_DEFINE_ENUM(NFS_INO_INVALID_BLOCKS);
 TRACE_DEFINE_ENUM(NFS_INO_INVALID_XATTR);
+TRACE_DEFINE_ENUM(NFS_INO_INVALID_NLINK);
 
 #define nfs_show_cache_validity(v) \
 	__print_flags(v, "|", \
@@ -65,7 +66,8 @@ TRACE_DEFINE_ENUM(NFS_INO_INVALID_XATTR);
 			{ NFS_INO_INVALID_OTHER, "INVALID_OTHER" }, \
 			{ NFS_INO_DATA_INVAL_DEFER, "DATA_INVAL_DEFER" }, \
 			{ NFS_INO_INVALID_BLOCKS, "INVALID_BLOCKS" }, \
-			{ NFS_INO_INVALID_XATTR, "INVALID_XATTR" })
+			{ NFS_INO_INVALID_XATTR, "INVALID_XATTR" }, \
+			{ NFS_INO_INVALID_NLINK, "INVALID_NLINK" })
 
 TRACE_DEFINE_ENUM(NFS_INO_ADVISE_RDPLUS);
 TRACE_DEFINE_ENUM(NFS_INO_STALE);
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 624ffd47a9d4..41165b988dfb 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -246,11 +246,13 @@ struct nfs4_copy_state {
 				BIT(13)		/* Deferred cache invalidation */
 #define NFS_INO_INVALID_BLOCKS	BIT(14)         /* cached blocks are invalid */
 #define NFS_INO_INVALID_XATTR	BIT(15)		/* xattrs are invalid */
+#define NFS_INO_INVALID_NLINK	BIT(16)		/* cached nlinks is invalid */
 
 #define NFS_INO_INVALID_ATTR	(NFS_INO_INVALID_CHANGE \
 		| NFS_INO_INVALID_CTIME \
 		| NFS_INO_INVALID_MTIME \
 		| NFS_INO_INVALID_SIZE \
+		| NFS_INO_INVALID_NLINK \
 		| NFS_INO_INVALID_OTHER)	/* inode metadata is invalid */
 
 /*
-- 
2.30.2

