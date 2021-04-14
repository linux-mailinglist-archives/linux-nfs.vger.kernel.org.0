Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB81F35F535
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 15:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351572AbhDNNoi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 09:44:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351601AbhDNNoW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Apr 2021 09:44:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB25861139
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 13:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618407841;
        bh=NXYi8V78A7/YKovtswQEPtV9IxSZkUuIYzFbABrofkE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Tw+a+5BUMVzmsC/p8DreX5jegZt1ymceZoVBmjZsfY9IymWQnkTv0u5WdrCXkWOfb
         kfZbOE9yeE7fqikgw96L3X9/ZJ4P/x8UZ2K6pBh3Q1+Vwnd4k0Rc4r7tqvoanrK2gv
         a1boSpO0rc62lXw6dpFKyaunKWzdZWmZZ6RolysMdyCLRCZXNL/LkW5+yXJZD7M6H5
         OQNzcLYUdeVpuvFdcjVBixuR8QX3aZ9DmVyJdRkEOEuV4lYMnZBdxdM7mDOna6DZ1Y
         rjkvRVxDX3ZU4HjHIfL1vgldVI6sNJXG5xFP8sPKY1UWWHKbPVM7nJlBF/SeG6EnYp
         kIp9R6SI0GmZQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 13/26] NFS: Separate tracking of file nlinks cache validity from the mode/uid/gid
Date:   Wed, 14 Apr 2021 09:43:40 -0400
Message-Id: <20210414134353.11860-14-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414134353.11860-13-trondmy@kernel.org>
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
 fs/nfs/inode.c         | 15 ++++++++++-----
 fs/nfs/nfs4proc.c      | 13 +++++++------
 fs/nfs/nfstrace.h      |  4 +++-
 include/linux/nfs_fs.h |  2 ++
 5 files changed, 23 insertions(+), 13 deletions(-)

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
index 3d18e66a4b8f..7bf9138330f2 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -538,7 +538,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr, st
 		if (fattr->valid & NFS_ATTR_FATTR_NLINK)
 			set_nlink(inode, fattr->nlink);
 		else if (nfs_server_capable(inode, NFS_CAP_NLINK))
-			nfs_set_cache_invalid(inode, NFS_INO_INVALID_OTHER);
+			nfs_set_cache_invalid(inode, NFS_INO_INVALID_NLINK);
 		if (fattr->valid & NFS_ATTR_FATTR_OWNER)
 			inode->i_uid = fattr->uid;
 		else if (nfs_server_capable(inode, NFS_CAP_OWNER))
@@ -801,8 +801,10 @@ static u32 nfs_get_valid_attrmask(struct inode *inode)
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
@@ -868,7 +870,9 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
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
@@ -1518,7 +1522,7 @@ static int nfs_check_inode_attributes(struct inode *inode, struct nfs_fattr *fat
 
 	/* Has the link count changed? */
 	if ((fattr->valid & NFS_ATTR_FATTR_NLINK) && inode->i_nlink != fattr->nlink)
-		invalid |= NFS_INO_INVALID_OTHER;
+		invalid |= NFS_INO_INVALID_NLINK;
 
 	ts = inode->i_atime;
 	if ((fattr->valid & NFS_ATTR_FATTR_ATIME) && !timespec64_equal(&ts, &fattr->atime))
@@ -1942,6 +1946,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 					| NFS_INO_INVALID_MTIME
 					| NFS_INO_INVALID_SIZE
 					| NFS_INO_INVALID_BLOCKS
+					| NFS_INO_INVALID_NLINK
 					| NFS_INO_INVALID_OTHER;
 				if (S_ISDIR(inode->i_mode))
 					nfs_force_lookup_revalidate(inode);
@@ -2074,7 +2079,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 		}
 	} else if (server->caps & NFS_CAP_NLINK) {
 		nfsi->cache_validity |= save_cache_validity &
-				(NFS_INO_INVALID_OTHER
+				(NFS_INO_INVALID_NLINK
 				| NFS_INO_REVAL_FORCED);
 		cache_revalidated = false;
 	}
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 8dc595ce40ca..a74c1c3c4192 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1167,14 +1167,14 @@ int nfs4_call_sync(struct rpc_clnt *clnt,
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
 
@@ -4717,11 +4717,11 @@ static int nfs4_proc_rename_done(struct rpc_task *task, struct inode *old_dir,
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

