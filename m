Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5C035F541
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 15:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351584AbhDNNol (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 09:44:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351621AbhDNNo1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Apr 2021 09:44:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D073611F0
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 13:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618407846;
        bh=yJ9Xuu16tbWfzBp7dc2oRgFD+fE+CFKf/gXZDjUiuf8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hkekkEk7izDgQyDN+Zt4Ieo37cMPQfeIyDWLuO6rpMGWvrbrFUS7KPL5FsZSrqPc/
         rWsJB7DgZ/svkfvD0aOkh4hl+MS52FHnHzP8ZU5GUhfmj/S5LxPw38ZUZ6DN/W1SR8
         yiB+7Kdjm6xWX3xMUfRjYGaGycSqQTGWn85B1W5QE4fzGaBy2SbxSpJFQqikHO+2+U
         Yf9ZfrBia2Yrc6MQo7KbLqr6PS5sGViKDahe9/1rMK0HTpkskdHOYw+EMRRt/xUx+1
         NPk5e1sPlP1UEpsbgzvHZ5XfiKPlAyCDorIZTJJexSWrSnV9rexww5IdnLQIFI2srA
         uZJA/CdLh86AA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 25/26] NFS: Don't store NFS_INO_REVAL_FORCED
Date:   Wed, 14 Apr 2021 09:43:52 -0400
Message-Id: <20210414134353.11860-26-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414134353.11860-25-trondmy@kernel.org>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

NFS_INO_REVAL_FORCED is intended to tell us that the cache needs
revalidation despite the fact that we hold a delegation. We shouldn't
need to store it anymore, though.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 21 +++++++++++----
 fs/nfs/delegation.h |  3 +--
 fs/nfs/inode.c      | 66 +++++++++++++++++----------------------------
 fs/nfs/nfs4proc.c   |  5 +---
 4 files changed, 43 insertions(+), 52 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 6a29de964268..e6ec6f09ac6e 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -481,6 +481,22 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 	if (freeme == NULL)
 		goto out;
 add_new:
+	/*
+	 * If we didn't revalidate the change attribute before setting
+	 * the delegation, then pre-emptively ask for a full attribute
+	 * cache revalidation.
+	 */
+	spin_lock(&inode->i_lock);
+	if (NFS_I(inode)->cache_validity & NFS_INO_INVALID_CHANGE)
+		nfs_set_cache_invalid(inode,
+			NFS_INO_INVALID_ATIME | NFS_INO_INVALID_CTIME |
+			NFS_INO_INVALID_MTIME | NFS_INO_INVALID_SIZE |
+			NFS_INO_INVALID_BLOCKS | NFS_INO_INVALID_NLINK |
+			NFS_INO_INVALID_OTHER | NFS_INO_INVALID_DATA |
+			NFS_INO_INVALID_ACCESS | NFS_INO_INVALID_ACL |
+			NFS_INO_INVALID_XATTR);
+	spin_unlock(&inode->i_lock);
+
 	list_add_tail_rcu(&delegation->super_list, &server->delegations);
 	rcu_assign_pointer(nfsi->delegation, delegation);
 	delegation = NULL;
@@ -488,11 +504,6 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 	atomic_long_inc(&nfs_active_delegations);
 
 	trace_nfs4_set_delegation(inode, type);
-
-	spin_lock(&inode->i_lock);
-	if (NFS_I(inode)->cache_validity & (NFS_INO_INVALID_ATTR|NFS_INO_INVALID_ATIME))
-		NFS_I(inode)->cache_validity |= NFS_INO_REVAL_FORCED;
-	spin_unlock(&inode->i_lock);
 out:
 	spin_unlock(&clp->cl_lock);
 	if (delegation != NULL)
diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index 9b00a0b7f832..c19b4fd20781 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -84,8 +84,7 @@ int nfs4_inode_make_writeable(struct inode *inode);
 
 static inline int nfs_have_delegated_attributes(struct inode *inode)
 {
-	return NFS_PROTO(inode)->have_delegation(inode, FMODE_READ) &&
-		!(NFS_I(inode)->cache_validity & NFS_INO_REVAL_FORCED);
+	return NFS_PROTO(inode)->have_delegation(inode, FMODE_READ);
 }
 
 #endif
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index b88e9dc72eec..7fa914e24fc4 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -200,21 +200,19 @@ void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 	if (have_delegation) {
 		if (!(flags & NFS_INO_REVAL_FORCED))
 			flags &= ~(NFS_INO_INVALID_MODE |
-				   NFS_INO_INVALID_OTHER);
-		flags &= ~(NFS_INO_INVALID_CHANGE
-				| NFS_INO_INVALID_SIZE
-				| NFS_INO_INVALID_XATTR);
+				   NFS_INO_INVALID_OTHER |
+				   NFS_INO_INVALID_XATTR);
+		flags &= ~(NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_SIZE);
 	} else if (flags & NFS_INO_REVAL_PAGECACHE)
 		flags |= NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_SIZE;
 
-	flags &= ~NFS_INO_REVAL_PAGECACHE;
-
 	if (!nfs_has_xattr_cache(nfsi))
 		flags &= ~NFS_INO_INVALID_XATTR;
 	if (flags & NFS_INO_INVALID_DATA)
 		nfs_fscache_invalidate(inode);
 	if (inode->i_mapping->nrpages == 0)
 		flags &= ~(NFS_INO_INVALID_DATA|NFS_INO_DATA_INVAL_DEFER);
+	flags &= ~(NFS_INO_REVAL_PAGECACHE | NFS_INO_REVAL_FORCED);
 	nfsi->cache_validity |= flags;
 }
 EXPORT_SYMBOL_GPL(nfs_set_cache_invalid);
@@ -560,9 +558,6 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr, st
 		} else if (fattr->size != 0)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_BLOCKS);
 
-		if (nfsi->cache_validity != 0)
-			nfsi->cache_validity |= NFS_INO_REVAL_FORCED;
-
 		nfs_setsecurity(inode, fattr, label);
 
 		nfsi->attrtimeo = NFS_MINATTRTIMEO(inode);
@@ -2032,7 +2027,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			save_cache_validity &
 			(NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_CTIME |
 			 NFS_INO_INVALID_MTIME | NFS_INO_INVALID_SIZE |
-			 NFS_INO_REVAL_FORCED);
+			 NFS_INO_INVALID_BLOCKS);
 		cache_revalidated = false;
 	}
 
@@ -2064,27 +2059,24 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			attr_changed = true;
 		}
 	} else {
-		nfsi->cache_validity |= save_cache_validity &
-				(NFS_INO_INVALID_CHANGE
-				| NFS_INO_REVAL_FORCED);
+		nfsi->cache_validity |=
+			save_cache_validity & NFS_INO_INVALID_CHANGE;
 		cache_revalidated = false;
 	}
 
 	if (fattr->valid & NFS_ATTR_FATTR_MTIME) {
 		inode->i_mtime = fattr->mtime;
 	} else if (server->caps & NFS_CAP_MTIME) {
-		nfsi->cache_validity |= save_cache_validity &
-				(NFS_INO_INVALID_MTIME
-				| NFS_INO_REVAL_FORCED);
+		nfsi->cache_validity |=
+			save_cache_validity & NFS_INO_INVALID_MTIME;
 		cache_revalidated = false;
 	}
 
 	if (fattr->valid & NFS_ATTR_FATTR_CTIME) {
 		inode->i_ctime = fattr->ctime;
 	} else if (server->caps & NFS_CAP_CTIME) {
-		nfsi->cache_validity |= save_cache_validity &
-				(NFS_INO_INVALID_CTIME
-				| NFS_INO_REVAL_FORCED);
+		nfsi->cache_validity |=
+			save_cache_validity & NFS_INO_INVALID_CTIME;
 		cache_revalidated = false;
 	}
 
@@ -2115,19 +2107,16 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			fattr->valid |= NFS_ATTR_FATTR_SPACE_USED;
 		}
 	} else {
-		nfsi->cache_validity |= save_cache_validity &
-				(NFS_INO_INVALID_SIZE
-				| NFS_INO_REVAL_FORCED);
+		nfsi->cache_validity |=
+			save_cache_validity & NFS_INO_INVALID_SIZE;
 		cache_revalidated = false;
 	}
 
-
 	if (fattr->valid & NFS_ATTR_FATTR_ATIME)
 		inode->i_atime = fattr->atime;
 	else if (server->caps & NFS_CAP_ATIME) {
-		nfsi->cache_validity |= save_cache_validity &
-				(NFS_INO_INVALID_ATIME
-				| NFS_INO_REVAL_FORCED);
+		nfsi->cache_validity |=
+			save_cache_validity & NFS_INO_INVALID_ATIME;
 		cache_revalidated = false;
 	}
 
@@ -2141,9 +2130,8 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			attr_changed = true;
 		}
 	} else if (server->caps & NFS_CAP_MODE) {
-		nfsi->cache_validity |= save_cache_validity &
-				(NFS_INO_INVALID_MODE
-				| NFS_INO_REVAL_FORCED);
+		nfsi->cache_validity |=
+			save_cache_validity & NFS_INO_INVALID_MODE;
 		cache_revalidated = false;
 	}
 
@@ -2155,9 +2143,8 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			attr_changed = true;
 		}
 	} else if (server->caps & NFS_CAP_OWNER) {
-		nfsi->cache_validity |= save_cache_validity &
-				(NFS_INO_INVALID_OTHER
-				| NFS_INO_REVAL_FORCED);
+		nfsi->cache_validity |=
+			save_cache_validity & NFS_INO_INVALID_OTHER;
 		cache_revalidated = false;
 	}
 
@@ -2169,9 +2156,8 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			attr_changed = true;
 		}
 	} else if (server->caps & NFS_CAP_OWNER_GROUP) {
-		nfsi->cache_validity |= save_cache_validity &
-				(NFS_INO_INVALID_OTHER
-				| NFS_INO_REVAL_FORCED);
+		nfsi->cache_validity |=
+			save_cache_validity & NFS_INO_INVALID_OTHER;
 		cache_revalidated = false;
 	}
 
@@ -2183,9 +2169,8 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			attr_changed = true;
 		}
 	} else if (server->caps & NFS_CAP_NLINK) {
-		nfsi->cache_validity |= save_cache_validity &
-				(NFS_INO_INVALID_NLINK
-				| NFS_INO_REVAL_FORCED);
+		nfsi->cache_validity |=
+			save_cache_validity & NFS_INO_INVALID_NLINK;
 		cache_revalidated = false;
 	}
 
@@ -2197,9 +2182,8 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	} else if (fattr->valid & NFS_ATTR_FATTR_BLOCKS_USED)
 		inode->i_blocks = fattr->du.nfs2.blocks;
 	else {
-		nfsi->cache_validity |= save_cache_validity &
-				(NFS_INO_INVALID_BLOCKS
-				| NFS_INO_REVAL_FORCED);
+		nfsi->cache_validity |=
+			save_cache_validity & NFS_INO_INVALID_BLOCKS;
 		cache_revalidated = false;
 	}
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 2215f20e0e78..bcbb057d5529 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5477,10 +5477,7 @@ static void nfs4_bitmask_set(__u32 bitmask[NFS4_BITMASK_SZ], const __u32 *src,
 	if (cache_validity & NFS_INO_INVALID_BLOCKS)
 		bitmask[1] |= FATTR4_WORD1_SPACE_USED;
 
-	if (nfs4_have_delegation(inode, FMODE_READ) &&
-	    !(cache_validity & NFS_INO_REVAL_FORCED))
-		bitmask[0] &= ~FATTR4_WORD0_SIZE;
-	else if (cache_validity & NFS_INO_INVALID_SIZE)
+	if (cache_validity & NFS_INO_INVALID_SIZE)
 		bitmask[0] |= FATTR4_WORD0_SIZE;
 
 	for (i = 0; i < NFS4_BITMASK_SZ; i++)
-- 
2.30.2

