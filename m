Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD8035F53B
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 15:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351578AbhDNNoj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 09:44:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351610AbhDNNoX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Apr 2021 09:44:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 805C8611C9
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 13:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618407842;
        bh=NuyucMypCY2APiNgQqFLHlYwgxq0kw5u9O53aBrQizs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RyiVmpIGnohHI/E+uvXJWYIlANSLq86Pk9yC35qo458Wypap89aPbO4ooTIuPeml9
         kbjzKr4eY0wjj8DInNXicfXFPBhg8C+RTIpEY5q8pFU+a9t39Ey3O3KvSqoXkzedO3
         PiI6H4MX7bKc5GB2KvKWFNxPCi/padsSkZpG7W/Y1icjYsKVD7sHovoI/BIXP9mldt
         l0+0EvtHApGS5tdFV4LHpDTsEa3rvsm/RNpTBKOhiX10gThbw5XYCOj9RL5yHFkVt2
         wWC3J7FFOjeoQJTc8cjWFUzdwNGF0iuCQrFdfHksYY16g8OKg3OHgm0uwlBQxrNb1a
         lqiwJnHQPiCXA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 17/26] NFS: Simplify cache consistency in nfs_check_inode_attributes()
Date:   Wed, 14 Apr 2021 09:43:44 -0400
Message-Id: <20210414134353.11860-18-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414134353.11860-17-trondmy@kernel.org>
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
index e4333b6ab2d4..fc8e92794636 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1491,8 +1491,7 @@ static int nfs_check_inode_attributes(struct inode *inode, struct nfs_fattr *fat
 	if (!nfs_file_has_buffered_writers(nfsi)) {
 		/* Verify a few of the more important attributes */
 		if ((fattr->valid & NFS_ATTR_FATTR_CHANGE) != 0 && !inode_eq_iversion_raw(inode, fattr->change_attr))
-			invalid |= NFS_INO_INVALID_CHANGE
-				| NFS_INO_REVAL_PAGECACHE;
+			invalid |= NFS_INO_INVALID_CHANGE;
 
 		ts = inode->i_mtime;
 		if ((fattr->valid & NFS_ATTR_FATTR_MTIME) && !timespec64_equal(&ts, &fattr->mtime))
@@ -1506,24 +1505,17 @@ static int nfs_check_inode_attributes(struct inode *inode, struct nfs_fattr *fat
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
-			| NFS_INO_INVALID_MODE;
+		invalid |= NFS_INO_INVALID_MODE;
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

