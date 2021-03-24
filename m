Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D96B34823A
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Mar 2021 20:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237814AbhCXTxW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Mar 2021 15:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237892AbhCXTxN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 24 Mar 2021 15:53:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C810761A21
        for <linux-nfs@vger.kernel.org>; Wed, 24 Mar 2021 19:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616615593;
        bh=JmCSD7oLxDqvjgGxGsXifrDovFhti7Dwy8X8jVc8t7w=;
        h=From:To:Subject:Date:From;
        b=pyoQKKFU68Vbk/gj0gdgE9BOvWcj/D8mXygFPWHLYESq8ogrhmiYWnMIhdL2MlQsn
         NX6F3rOEV8dLzBKeYtEXlkxKbWgXRKBn4IlsgfD+Td65Sh4ACZqm3ZzDPA2UFrgVoD
         ZCYOqyj6F3ivLszuAVbZp0B17wczVsxsubIFHDt8XATUxHhvbR5nJmET5lBZGCcxYw
         6+nJLw5rz/OFUsRacPjcBeaMIpoxII+mTJxrd5IeUP1PmeGXNAsRAeXOT0Yzxth4XL
         ty3Eulke9H9YzBAJznoO4yd0iwzrz9ehGgC4/3ZO5rDtXIp6R3De8z8yu2z39XfyGw
         PedUHtJd/NovA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFS: Fix up revalidation of space used
Date:   Wed, 24 Mar 2021 15:53:09 -0400
Message-Id: <20210324195311.577373-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
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
index a7fb076a5f44..398f814ff8f8 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -564,12 +564,13 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr, st
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
@@ -710,7 +711,8 @@ void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr,
 	spin_lock(&inode->i_lock);
 	NFS_I(inode)->attr_gencount = fattr->gencount;
 	if ((attr->ia_valid & ATTR_SIZE) != 0) {
-		nfs_set_cache_invalid(inode, NFS_INO_INVALID_MTIME);
+		nfs_set_cache_invalid(inode, NFS_INO_INVALID_MTIME |
+						     NFS_INO_INVALID_BLOCKS);
 		nfs_inc_stats(inode, NFSIOS_SETATTRTRUNC);
 		nfs_vmtruncate(inode, attr->ia_size);
 	}
@@ -1928,6 +1930,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 				save_cache_validity |= NFS_INO_INVALID_CTIME
 					| NFS_INO_INVALID_MTIME
 					| NFS_INO_INVALID_SIZE
+					| NFS_INO_INVALID_BLOCKS
 					| NFS_INO_INVALID_OTHER;
 				if (S_ISDIR(inode->i_mode))
 					nfs_force_lookup_revalidate(inode);
@@ -1985,6 +1988,12 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
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

