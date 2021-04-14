Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1912935F530
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 15:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347495AbhDNNog (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 09:44:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351588AbhDNNoS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Apr 2021 09:44:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F939611EE
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 13:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618407837;
        bh=x8CTXIZFJrmvZXu3ye5Y+/86qkLHBe2ABa2v2px5y+E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SMHgSJn+LJXNZHQUe4rZLPZqohAcpxwjFo2Dt/4+EC7tqHTTNsvYlzZqbVtnZ9pXl
         2APVXwf/yVURVwftWGs0cn5qqooSKZkFsIb6i8JFgkaEGVSCIrN84q1lOzI79B0/Og
         s7YIif4Zb3yql1hsiWjoaEwj0NNW5AhdclAqXM2bl5jCMJrUDn3Y7E+7jmwXI4pRdh
         mgLa7CcdQOaQitVCqhhrLtWTdi0auOloh5pzfjrm0pj4bLbvBOo2axgwZHXqQ4zN68
         IenCQj0EmvDHZ7D4r92pIVBU0cqRNJ7ZqdeBtgzH0r8hUOPXYIZ7ZWfHVSXrU29v4x
         MiGAxPH5s4jwQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 05/26] NFS: Fix up revalidation of space used
Date:   Wed, 14 Apr 2021 09:43:32 -0400
Message-Id: <20210414134353.11860-6-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414134353.11860-5-trondmy@kernel.org>
References: <20210414134353.11860-1-trondmy@kernel.org>
 <20210414134353.11860-2-trondmy@kernel.org>
 <20210414134353.11860-3-trondmy@kernel.org>
 <20210414134353.11860-4-trondmy@kernel.org>
 <20210414134353.11860-5-trondmy@kernel.org>
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
index a9b302b389a7..8b2f4a5eaa42 100644
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

