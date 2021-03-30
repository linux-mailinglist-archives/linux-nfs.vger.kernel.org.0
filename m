Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFDB34DCDE
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Mar 2021 02:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhC3ATN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Mar 2021 20:19:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229763AbhC3ASl (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 29 Mar 2021 20:18:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D25A61985
        for <linux-nfs@vger.kernel.org>; Tue, 30 Mar 2021 00:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617063521;
        bh=YMkKdjIqZ+UcrLWPBS4GKFp/4y3/49NdX+nTfAZKSDA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fvHxFLJ6jFSHlE7f+YEg+33kdEDryb8CvnYp6EyyivPAkkNKEcVgpTDN0UYYxi14B
         +4w3ZX3rq22ZPh0GdKGx+Lr1gfy39zR49LMRU8H8AmJPwRhdiYl97NyjXN7dms4L84
         06PYX/CZGHmBngVzW3UfuXNI6jbR9YxjtMp3T5Um9Be0vYWl53MovlPRTHz42UHfUS
         9j6vs0dcupeyVsarapVaUSKBjBFNWzWReVwLj//s2autaycpwSmmFkrTd43Ql2+S9l
         AWADwWcwv1gccCs2SxMKdpIidofm+Nckh+lLryRJGG52XQzU0yPnelMAwHTpJC/zrC
         gaTK+XEvo5ZPQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 05/17] NFS: Fix up revalidation of space used
Date:   Mon, 29 Mar 2021 20:18:23 -0400
Message-Id: <20210330001835.41914-6-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330001835.41914-5-trondmy@kernel.org>
References: <20210330001835.41914-1-trondmy@kernel.org>
 <20210330001835.41914-2-trondmy@kernel.org>
 <20210330001835.41914-3-trondmy@kernel.org>
 <20210330001835.41914-4-trondmy@kernel.org>
 <20210330001835.41914-5-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that when the change attribute or the size change, we also
remember to revalidate the space used.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index f0c983151f3c..138d0998fd91 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -565,12 +565,13 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr, st
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_XATTR);
 		if (fattr->valid & NFS_ATTR_FATTR_BLOCKS_USED)
 			inode->i_blocks = fattr->du.nfs2.blocks;
-		if (fattr->valid & NFS_ATTR_FATTR_SPACE_USED) {
+		else if (fattr->valid & NFS_ATTR_FATTR_SPACE_USED) {
 			/*
 			 * report the blocks in 512byte units
 			 */
 			inode->i_blocks = nfs_calc_block_size(fattr->du.nfs3.used);
-		}
+		} else if (fattr->size != 0)
+			nfs_set_cache_invalid(inode, NFS_INO_INVALID_BLOCKS);
 
 		if (nfsi->cache_validity != 0)
 			nfsi->cache_validity |= NFS_INO_REVAL_FORCED;
@@ -711,7 +712,8 @@ void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr,
 	spin_lock(&inode->i_lock);
 	NFS_I(inode)->attr_gencount = fattr->gencount;
 	if ((attr->ia_valid & ATTR_SIZE) != 0) {
-		nfs_set_cache_invalid(inode, NFS_INO_INVALID_MTIME);
+		nfs_set_cache_invalid(inode, NFS_INO_INVALID_MTIME |
+						     NFS_INO_INVALID_BLOCKS);
 		nfs_inc_stats(inode, NFSIOS_SETATTRTRUNC);
 		nfs_vmtruncate(inode, attr->ia_size);
 	}
@@ -1933,6 +1935,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 				save_cache_validity |= NFS_INO_INVALID_CTIME
 					| NFS_INO_INVALID_MTIME
 					| NFS_INO_INVALID_SIZE
+					| NFS_INO_INVALID_BLOCKS
 					| NFS_INO_INVALID_OTHER;
 				if (S_ISDIR(inode->i_mode))
 					nfs_force_lookup_revalidate(inode);
@@ -1990,6 +1993,12 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 					(long long)cur_isize,
 					(long long)new_isize);
 		}
+		if (new_isize == 0 &&
+		    !(fattr->valid & (NFS_ATTR_FATTR_SPACE_USED |
+				      NFS_ATTR_FATTR_BLOCKS_USED))) {
+			fattr->du.nfs3.used = 0;
+			fattr->valid |= NFS_ATTR_FATTR_SPACE_USED;
+		}
 	} else {
 		nfsi->cache_validity |= save_cache_validity &
 				(NFS_INO_INVALID_SIZE
-- 
2.30.2

