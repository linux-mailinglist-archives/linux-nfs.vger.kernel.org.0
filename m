Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009F834DCE9
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Mar 2021 02:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhC3ATP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Mar 2021 20:19:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbhC3ASq (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 29 Mar 2021 20:18:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CA0861920
        for <linux-nfs@vger.kernel.org>; Tue, 30 Mar 2021 00:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617063526;
        bh=cfANOpvP4YscWX/TxFZ4ROep2D2a2g1tUs6mzeVJXck=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=f8U9NLszGRRC2rtemUwbzfC6V1lIf9wtDbTAoLnpaG87BEg4DSw1eocRBBsqyCeP+
         rFHc+eIPzMUD+EhRA4E56oz7RcgxF5HujkVg1A/t1cvUYXmY/WnnWLaboE9lUTLHyK
         Ipri+S8y8fjp762juqhIzzyr3VK33Z5btA4nZ9azl3BOQcdcKhVniWJf2Xa0JAUJ7C
         y5qQ23lBxOzRIabth1MnnDrexAUXehNq2zA7RDe4mnP2wNQ7ooKa2OwLfiBd5Ph5nh
         3v5fXeqQUR/xGRpHumvLWnvmwQY4+o4RQQZdp+EK6u43x6tIZhGQvMH9C2EBd63gR3
         +UfGOs6z70ebQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 14/17] NFS: Simplify cache consistency in nfs_check_inode_attributes()
Date:   Mon, 29 Mar 2021 20:18:32 -0400
Message-Id: <20210330001835.41914-15-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330001835.41914-14-trondmy@kernel.org>
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
 <20210330001835.41914-12-trondmy@kernel.org>
 <20210330001835.41914-13-trondmy@kernel.org>
 <20210330001835.41914-14-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We should not be invalidating the access or acl caches in
nfs_check_inode_attributes(), since the point is we're unsure about
whether the contents of the struct nfs_fattr are fully up to date.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index f60dc562e84b..e1a1322599b8 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1497,8 +1497,7 @@ static int nfs_check_inode_attributes(struct inode *inode, struct nfs_fattr *fat
 	if (!nfs_file_has_buffered_writers(nfsi)) {
 		/* Verify a few of the more important attributes */
 		if ((fattr->valid & NFS_ATTR_FATTR_CHANGE) != 0 && !inode_eq_iversion_raw(inode, fattr->change_attr))
-			invalid |= NFS_INO_INVALID_CHANGE
-				| NFS_INO_REVAL_PAGECACHE;
+			invalid |= NFS_INO_INVALID_CHANGE;
 
 		ts = inode->i_mtime;
 		if ((fattr->valid & NFS_ATTR_FATTR_MTIME) && !timespec64_equal(&ts, &fattr->mtime))
@@ -1512,24 +1511,17 @@ static int nfs_check_inode_attributes(struct inode *inode, struct nfs_fattr *fat
 			cur_size = i_size_read(inode);
 			new_isize = nfs_size_to_loff_t(fattr->size);
 			if (cur_size != new_isize)
-				invalid |= NFS_INO_INVALID_SIZE
-					| NFS_INO_REVAL_PAGECACHE;
+				invalid |= NFS_INO_INVALID_SIZE;
 		}
 	}
 
 	/* Have any file permissions changed? */
 	if ((fattr->valid & NFS_ATTR_FATTR_MODE) && (inode->i_mode & S_IALLUGO) != (fattr->mode & S_IALLUGO))
-		invalid |= NFS_INO_INVALID_ACCESS
-			| NFS_INO_INVALID_ACL
-			| NFS_INO_INVALID_OTHER;
+		invalid |= NFS_INO_INVALID_OTHER;
 	if ((fattr->valid & NFS_ATTR_FATTR_OWNER) && !uid_eq(inode->i_uid, fattr->uid))
-		invalid |= NFS_INO_INVALID_ACCESS
-			| NFS_INO_INVALID_ACL
-			| NFS_INO_INVALID_OTHER;
+		invalid |= NFS_INO_INVALID_OTHER;
 	if ((fattr->valid & NFS_ATTR_FATTR_GROUP) && !gid_eq(inode->i_gid, fattr->gid))
-		invalid |= NFS_INO_INVALID_ACCESS
-			| NFS_INO_INVALID_ACL
-			| NFS_INO_INVALID_OTHER;
+		invalid |= NFS_INO_INVALID_OTHER;
 
 	/* Has the link count changed? */
 	if ((fattr->valid & NFS_ATTR_FATTR_NLINK) && inode->i_nlink != fattr->nlink)
-- 
2.30.2

