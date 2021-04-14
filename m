Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D5C35F542
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 15:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351585AbhDNNol (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 09:44:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351622AbhDNNo2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Apr 2021 09:44:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79FE2611EE
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 13:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618407846;
        bh=Dtzj806gg2pJx777qOx+uc/x5NR7juMFhXg291cR+Mo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=o05EVxjvSAsDSMcAgzjIPDeBRNZdPnQr45xyDei/loxvZTeTjv16/N1LWSiFJQQaA
         3SZbwUCCoSm6E23g5cmAVsEVAoxLccLxLJ2b14wL0C8Bzbl0cR8jCSfNlSFXcTCDlk
         BwJuhUrF1/R22iz1E7gxgmYRjrplUGWQmK8mntzV6kzzprfgXVEcCcKkl9RHSGbgHT
         pqJwhYhPxwW38zE/704mjFlgNTZpjMg5TE9Dl9J9eHQ0LfOZx3kiAdJKf8ME9zKIDt
         yAM7N3oJHQ8XO4qV2FCetwwSdloecuAbuzRLoPnwkSyve7Gs5rcfOrjCh8MAe8bhO0
         lcsr/euvtn4vg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 26/26] NFS: Split attribute support out from the server capabilities
Date:   Wed, 14 Apr 2021 09:43:53 -0400
Message-Id: <20210414134353.11860-27-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414134353.11860-26-trondmy@kernel.org>
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
 <20210414134353.11860-15-trondmy@kernel.org>
 <20210414134353.11860-16-trondmy@kernel.org>
 <20210414134353.11860-17-trondmy@kernel.org>
 <20210414134353.11860-18-trondmy@kernel.org>
 <20210414134353.11860-19-trondmy@kernel.org>
 <20210414134353.11860-20-trondmy@kernel.org>
 <20210414134353.11860-21-trondmy@kernel.org>
 <20210414134353.11860-22-trondmy@kernel.org>
 <20210414134353.11860-23-trondmy@kernel.org>
 <20210414134353.11860-24-trondmy@kernel.org>
 <20210414134353.11860-25-trondmy@kernel.org>
 <20210414134353.11860-26-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@primarydata.com>

There are lots of attributes, and they are crowding out the bit space.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/client.c           | 15 +++++++++---
 fs/nfs/inode.c            | 51 ++++++++++++++++++++++++---------------
 fs/nfs/nfs4proc.c         | 49 +++++++++++++++++++------------------
 include/linux/nfs_fs_sb.h | 11 ++-------
 4 files changed, 70 insertions(+), 56 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 2aeb4e52a4f1..cfeaadf56bf0 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -696,9 +696,18 @@ static int nfs_init_server(struct nfs_server *server,
 	/* Initialise the client representation from the mount data */
 	server->flags = ctx->flags;
 	server->options = ctx->options;
-	server->caps |= NFS_CAP_HARDLINKS|NFS_CAP_SYMLINKS|NFS_CAP_FILEID|
-		NFS_CAP_MODE|NFS_CAP_NLINK|NFS_CAP_OWNER|NFS_CAP_OWNER_GROUP|
-		NFS_CAP_ATIME|NFS_CAP_CTIME|NFS_CAP_MTIME;
+	server->caps |= NFS_CAP_HARDLINKS | NFS_CAP_SYMLINKS;
+
+	switch (clp->rpc_ops->version) {
+	case 2:
+		server->fattr_valid = NFS_ATTR_FATTR_V2;
+		break;
+	case 3:
+		server->fattr_valid = NFS_ATTR_FATTR_V3;
+		break;
+	default:
+		server->fattr_valid = NFS_ATTR_FATTR_V4;
+	}
 
 	if (ctx->rsize)
 		server->rsize = nfs_block_size(ctx->rsize, NULL);
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 7fa914e24fc4..6d04ebb4f084 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -438,6 +438,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr, st
 		.fattr	= fattr
 	};
 	struct inode *inode = ERR_PTR(-ENOENT);
+	u64 fattr_supported = NFS_SB(sb)->fattr_valid;
 	unsigned long hash;
 
 	nfs_attr_check_mountpoint(sb, fattr);
@@ -470,7 +471,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr, st
 		inode->i_mode = fattr->mode;
 		nfsi->cache_validity = 0;
 		if ((fattr->valid & NFS_ATTR_FATTR_MODE) == 0
-				&& nfs_server_capable(inode, NFS_CAP_MODE))
+				&& (fattr_supported & NFS_ATTR_FATTR_MODE))
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_MODE);
 		/* Why so? Because we want revalidate for devices/FIFOs, and
 		 * that's precisely what we have in nfs_file_inode_operations.
@@ -516,15 +517,15 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr, st
 		nfsi->attr_gencount = fattr->gencount;
 		if (fattr->valid & NFS_ATTR_FATTR_ATIME)
 			inode->i_atime = fattr->atime;
-		else if (nfs_server_capable(inode, NFS_CAP_ATIME))
+		else if (fattr_supported & NFS_ATTR_FATTR_ATIME)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_ATIME);
 		if (fattr->valid & NFS_ATTR_FATTR_MTIME)
 			inode->i_mtime = fattr->mtime;
-		else if (nfs_server_capable(inode, NFS_CAP_MTIME))
+		else if (fattr_supported & NFS_ATTR_FATTR_MTIME)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_MTIME);
 		if (fattr->valid & NFS_ATTR_FATTR_CTIME)
 			inode->i_ctime = fattr->ctime;
-		else if (nfs_server_capable(inode, NFS_CAP_CTIME))
+		else if (fattr_supported & NFS_ATTR_FATTR_CTIME)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_CTIME);
 		if (fattr->valid & NFS_ATTR_FATTR_CHANGE)
 			inode_set_iversion_raw(inode, fattr->change_attr);
@@ -536,26 +537,30 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr, st
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_SIZE);
 		if (fattr->valid & NFS_ATTR_FATTR_NLINK)
 			set_nlink(inode, fattr->nlink);
-		else if (nfs_server_capable(inode, NFS_CAP_NLINK))
+		else if (fattr_supported & NFS_ATTR_FATTR_NLINK)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_NLINK);
 		if (fattr->valid & NFS_ATTR_FATTR_OWNER)
 			inode->i_uid = fattr->uid;
-		else if (nfs_server_capable(inode, NFS_CAP_OWNER))
+		else if (fattr_supported & NFS_ATTR_FATTR_OWNER)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_OTHER);
 		if (fattr->valid & NFS_ATTR_FATTR_GROUP)
 			inode->i_gid = fattr->gid;
-		else if (nfs_server_capable(inode, NFS_CAP_OWNER_GROUP))
+		else if (fattr_supported & NFS_ATTR_FATTR_GROUP)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_OTHER);
 		if (nfs_server_capable(inode, NFS_CAP_XATTR))
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_XATTR);
 		if (fattr->valid & NFS_ATTR_FATTR_BLOCKS_USED)
 			inode->i_blocks = fattr->du.nfs2.blocks;
-		else if (fattr->valid & NFS_ATTR_FATTR_SPACE_USED) {
+		else if (fattr_supported & NFS_ATTR_FATTR_BLOCKS_USED &&
+			 fattr->size != 0)
+			nfs_set_cache_invalid(inode, NFS_INO_INVALID_BLOCKS);
+		if (fattr->valid & NFS_ATTR_FATTR_SPACE_USED) {
 			/*
 			 * report the blocks in 512byte units
 			 */
 			inode->i_blocks = nfs_calc_block_size(fattr->du.nfs3.used);
-		} else if (fattr->size != 0)
+		} else if (fattr_supported & NFS_ATTR_FATTR_SPACE_USED &&
+			   fattr->size != 0)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_BLOCKS);
 
 		nfs_setsecurity(inode, fattr, label);
@@ -1952,9 +1957,10 @@ EXPORT_SYMBOL_GPL(nfs_post_op_update_inode_force_wcc);
  */
 static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 {
-	struct nfs_server *server;
+	struct nfs_server *server = NFS_SERVER(inode);
 	struct nfs_inode *nfsi = NFS_I(inode);
 	loff_t cur_isize, new_isize;
+	u64 fattr_supported = server->fattr_valid;
 	unsigned long invalid = 0;
 	unsigned long now = jiffies;
 	unsigned long save_cache_validity;
@@ -1998,7 +2004,6 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 		goto out_err;
 	}
 
-	server = NFS_SERVER(inode);
 	/* Update the fsid? */
 	if (S_ISDIR(inode->i_mode) && (fattr->valid & NFS_ATTR_FATTR_FSID) &&
 			!nfs_fsid_equal(&server->fsid, &fattr->fsid) &&
@@ -2066,7 +2071,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 
 	if (fattr->valid & NFS_ATTR_FATTR_MTIME) {
 		inode->i_mtime = fattr->mtime;
-	} else if (server->caps & NFS_CAP_MTIME) {
+	} else if (fattr_supported & NFS_ATTR_FATTR_MTIME) {
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_MTIME;
 		cache_revalidated = false;
@@ -2074,7 +2079,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 
 	if (fattr->valid & NFS_ATTR_FATTR_CTIME) {
 		inode->i_ctime = fattr->ctime;
-	} else if (server->caps & NFS_CAP_CTIME) {
+	} else if (fattr_supported & NFS_ATTR_FATTR_CTIME) {
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_CTIME;
 		cache_revalidated = false;
@@ -2114,7 +2119,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 
 	if (fattr->valid & NFS_ATTR_FATTR_ATIME)
 		inode->i_atime = fattr->atime;
-	else if (server->caps & NFS_CAP_ATIME) {
+	else if (fattr_supported & NFS_ATTR_FATTR_ATIME) {
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_ATIME;
 		cache_revalidated = false;
@@ -2129,7 +2134,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 				| NFS_INO_INVALID_ACL;
 			attr_changed = true;
 		}
-	} else if (server->caps & NFS_CAP_MODE) {
+	} else if (fattr_supported & NFS_ATTR_FATTR_MODE) {
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_MODE;
 		cache_revalidated = false;
@@ -2142,7 +2147,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			inode->i_uid = fattr->uid;
 			attr_changed = true;
 		}
-	} else if (server->caps & NFS_CAP_OWNER) {
+	} else if (fattr_supported & NFS_ATTR_FATTR_OWNER) {
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_OTHER;
 		cache_revalidated = false;
@@ -2155,7 +2160,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			inode->i_gid = fattr->gid;
 			attr_changed = true;
 		}
-	} else if (server->caps & NFS_CAP_OWNER_GROUP) {
+	} else if (fattr_supported & NFS_ATTR_FATTR_GROUP) {
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_OTHER;
 		cache_revalidated = false;
@@ -2168,7 +2173,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			set_nlink(inode, fattr->nlink);
 			attr_changed = true;
 		}
-	} else if (server->caps & NFS_CAP_NLINK) {
+	} else if (fattr_supported & NFS_ATTR_FATTR_NLINK) {
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_NLINK;
 		cache_revalidated = false;
@@ -2179,9 +2184,15 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 		 * report the blocks in 512byte units
 		 */
 		inode->i_blocks = nfs_calc_block_size(fattr->du.nfs3.used);
-	} else if (fattr->valid & NFS_ATTR_FATTR_BLOCKS_USED)
+	} else if (fattr_supported & NFS_ATTR_FATTR_SPACE_USED) {
+		nfsi->cache_validity |=
+			save_cache_validity & NFS_INO_INVALID_BLOCKS;
+		cache_revalidated = false;
+	}
+
+	if (fattr->valid & NFS_ATTR_FATTR_BLOCKS_USED) {
 		inode->i_blocks = fattr->du.nfs2.blocks;
-	else {
+	} else if (fattr_supported & NFS_ATTR_FATTR_BLOCKS_USED) {
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_BLOCKS;
 		cache_revalidated = false;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index bcbb057d5529..21c31aebb116 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3868,12 +3868,9 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 			res.attr_bitmask[2] &= FATTR4_WORD2_NFS42_MASK;
 		}
 		memcpy(server->attr_bitmask, res.attr_bitmask, sizeof(server->attr_bitmask));
-		server->caps &= ~(NFS_CAP_ACLS|NFS_CAP_HARDLINKS|
-				NFS_CAP_SYMLINKS|NFS_CAP_FILEID|
-				NFS_CAP_MODE|NFS_CAP_NLINK|NFS_CAP_OWNER|
-				NFS_CAP_OWNER_GROUP|NFS_CAP_ATIME|
-				NFS_CAP_CTIME|NFS_CAP_MTIME|
-				NFS_CAP_SECURITY_LABEL);
+		server->caps &= ~(NFS_CAP_ACLS | NFS_CAP_HARDLINKS |
+				  NFS_CAP_SYMLINKS| NFS_CAP_SECURITY_LABEL);
+		server->fattr_valid = NFS_ATTR_FATTR_V4;
 		if (res.attr_bitmask[0] & FATTR4_WORD0_ACL &&
 				res.acl_bitmask & ACL4_SUPPORT_ALLOW_ACL)
 			server->caps |= NFS_CAP_ACLS;
@@ -3881,25 +3878,29 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 			server->caps |= NFS_CAP_HARDLINKS;
 		if (res.has_symlinks != 0)
 			server->caps |= NFS_CAP_SYMLINKS;
-		if (res.attr_bitmask[0] & FATTR4_WORD0_FILEID)
-			server->caps |= NFS_CAP_FILEID;
-		if (res.attr_bitmask[1] & FATTR4_WORD1_MODE)
-			server->caps |= NFS_CAP_MODE;
-		if (res.attr_bitmask[1] & FATTR4_WORD1_NUMLINKS)
-			server->caps |= NFS_CAP_NLINK;
-		if (res.attr_bitmask[1] & FATTR4_WORD1_OWNER)
-			server->caps |= NFS_CAP_OWNER;
-		if (res.attr_bitmask[1] & FATTR4_WORD1_OWNER_GROUP)
-			server->caps |= NFS_CAP_OWNER_GROUP;
-		if (res.attr_bitmask[1] & FATTR4_WORD1_TIME_ACCESS)
-			server->caps |= NFS_CAP_ATIME;
-		if (res.attr_bitmask[1] & FATTR4_WORD1_TIME_METADATA)
-			server->caps |= NFS_CAP_CTIME;
-		if (res.attr_bitmask[1] & FATTR4_WORD1_TIME_MODIFY)
-			server->caps |= NFS_CAP_MTIME;
+		if (!(res.attr_bitmask[0] & FATTR4_WORD0_FILEID))
+			server->fattr_valid &= ~NFS_ATTR_FATTR_FILEID;
+		if (!(res.attr_bitmask[1] & FATTR4_WORD1_MODE))
+			server->fattr_valid &= ~NFS_ATTR_FATTR_MODE;
+		if (!(res.attr_bitmask[1] & FATTR4_WORD1_NUMLINKS))
+			server->fattr_valid &= ~NFS_ATTR_FATTR_NLINK;
+		if (!(res.attr_bitmask[1] & FATTR4_WORD1_OWNER))
+			server->fattr_valid &= ~(NFS_ATTR_FATTR_OWNER |
+				NFS_ATTR_FATTR_OWNER_NAME);
+		if (!(res.attr_bitmask[1] & FATTR4_WORD1_OWNER_GROUP))
+			server->fattr_valid &= ~(NFS_ATTR_FATTR_GROUP |
+				NFS_ATTR_FATTR_GROUP_NAME);
+		if (!(res.attr_bitmask[1] & FATTR4_WORD1_SPACE_USED))
+			server->fattr_valid &= ~NFS_ATTR_FATTR_SPACE_USED;
+		if (!(res.attr_bitmask[1] & FATTR4_WORD1_TIME_ACCESS))
+			server->fattr_valid &= ~NFS_ATTR_FATTR_ATIME;
+		if (!(res.attr_bitmask[1] & FATTR4_WORD1_TIME_METADATA))
+			server->fattr_valid &= ~NFS_ATTR_FATTR_CTIME;
+		if (!(res.attr_bitmask[1] & FATTR4_WORD1_TIME_MODIFY))
+			server->fattr_valid &= ~NFS_ATTR_FATTR_MTIME;
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
-		if (res.attr_bitmask[2] & FATTR4_WORD2_SECURITY_LABEL)
-			server->caps |= NFS_CAP_SECURITY_LABEL;
+		if (!(res.attr_bitmask[2] & FATTR4_WORD2_SECURITY_LABEL))
+			server->fattr_valid &= ~NFS_ATTR_FATTR_V4_SECURITY_LABEL;
 #endif
 		memcpy(server->attr_bitmask_nl, res.attr_bitmask,
 				sizeof(server->attr_bitmask));
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index fbcdfd9f7a7f..d28d7a62864f 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -191,6 +191,8 @@ struct nfs_server {
 	dev_t			s_dev;		/* superblock dev numbers */
 	struct nfs_auth_info	auth_info;	/* parsed auth flavors */
 
+	__u64			fattr_valid;	/* Valid attributes */
+
 #ifdef CONFIG_NFS_FSCACHE
 	struct nfs_fscache_key	*fscache_key;	/* unique key for superblock */
 	struct fscache_cookie	*fscache;	/* superblock cookie */
@@ -267,16 +269,7 @@ struct nfs_server {
 #define NFS_CAP_SYMLINKS	(1U << 2)
 #define NFS_CAP_ACLS		(1U << 3)
 #define NFS_CAP_ATOMIC_OPEN	(1U << 4)
-/* #define NFS_CAP_CHANGE_ATTR	(1U << 5) */
 #define NFS_CAP_LGOPEN		(1U << 5)
-#define NFS_CAP_FILEID		(1U << 6)
-#define NFS_CAP_MODE		(1U << 7)
-#define NFS_CAP_NLINK		(1U << 8)
-#define NFS_CAP_OWNER		(1U << 9)
-#define NFS_CAP_OWNER_GROUP	(1U << 10)
-#define NFS_CAP_ATIME		(1U << 11)
-#define NFS_CAP_CTIME		(1U << 12)
-#define NFS_CAP_MTIME		(1U << 13)
 #define NFS_CAP_POSIX_LOCK	(1U << 14)
 #define NFS_CAP_UIDGID_NOMAP	(1U << 15)
 #define NFS_CAP_STATEID_NFSV41	(1U << 16)
-- 
2.30.2

