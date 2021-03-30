Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACA434DCE3
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Mar 2021 02:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhC3ATO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Mar 2021 20:19:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230202AbhC3ASp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 29 Mar 2021 20:18:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF2F16192F
        for <linux-nfs@vger.kernel.org>; Tue, 30 Mar 2021 00:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617063524;
        bh=p/OMKjhUArmSpnat1QOTaqJaDV7aS6IGAzkiE+kmxE8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QYvOPstaB+Ppnnmlfn3Ak1vRUUvzD20LDUGnYry1pMLJ0CcWbVaGqNbfNlfV3DV54
         CtbX6vKeeG6mYGHQ7K5cLyi72ygrngVfGyfDaSfTPSy+lnqB/1SgQIQfaQLFKI6DbJ
         lEHXDPKboZvKHsNFXdRwosCHROKQFj+CffmGg4xten+b6tlo1mTDnqDtCPD9F3yj3Z
         xMHMOyPe2TNZZtB/fLC0h+hrS7s+mJ/yMQHOT9d9KZpsIk0iYUSOglQCYazVXKTVcC
         5YA2EG491XrWeRBE7OGloi6xVPJ+lvlpjmgUJ1+f+iFMDl1wW0LOKUf/ddkWUg167W
         A8rLxT0b9VsYA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 10/17] NFS: Don't set NFS_INO_REVAL_PAGECACHE in the inode cache validity
Date:   Mon, 29 Mar 2021 20:18:28 -0400
Message-Id: <20210330001835.41914-11-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330001835.41914-10-trondmy@kernel.org>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

It is no longer necessary to preserve the NFS_INO_REVAL_PAGECACHE flag.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c    | 6 ++----
 fs/nfs/nfs4proc.c | 1 -
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 484e1e3c500e..25dc70adab87 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -218,11 +218,12 @@ void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 			flags &= ~NFS_INO_INVALID_OTHER;
 		flags &= ~(NFS_INO_INVALID_CHANGE
 				| NFS_INO_INVALID_SIZE
-				| NFS_INO_REVAL_PAGECACHE
 				| NFS_INO_INVALID_XATTR);
 	} else if (flags & NFS_INO_REVAL_PAGECACHE)
 		flags |= NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_SIZE;
 
+	flags &= ~NFS_INO_REVAL_PAGECACHE;
+
 	if (!nfs_has_xattr_cache(nfsi))
 		flags &= ~NFS_INO_INVALID_XATTR;
 	if (flags & NFS_INO_INVALID_DATA)
@@ -1927,7 +1928,6 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	nfsi->cache_validity &= ~(NFS_INO_INVALID_ATTR
 			| NFS_INO_INVALID_ATIME
 			| NFS_INO_REVAL_FORCED
-			| NFS_INO_REVAL_PAGECACHE
 			| NFS_INO_INVALID_BLOCKS);
 
 	/* Do atomic weak cache consistency updates */
@@ -1966,7 +1966,6 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	} else {
 		nfsi->cache_validity |= save_cache_validity &
 				(NFS_INO_INVALID_CHANGE
-				| NFS_INO_REVAL_PAGECACHE
 				| NFS_INO_REVAL_FORCED);
 		cache_revalidated = false;
 	}
@@ -2018,7 +2017,6 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	} else {
 		nfsi->cache_validity |= save_cache_validity &
 				(NFS_INO_INVALID_SIZE
-				| NFS_INO_REVAL_PAGECACHE
 				| NFS_INO_REVAL_FORCED);
 		cache_revalidated = false;
 	}
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 2f2cea64f40a..64b3438aed78 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1191,7 +1191,6 @@ nfs4_update_changeattr_locked(struct inode *inode,
 	cache_validity |= NFS_INO_INVALID_CTIME | NFS_INO_INVALID_MTIME;
 
 	if (cinfo->atomic && cinfo->before == inode_peek_iversion_raw(inode)) {
-		nfsi->cache_validity &= ~NFS_INO_REVAL_PAGECACHE;
 		nfsi->attrtimeo_timestamp = jiffies;
 	} else {
 		if (S_ISDIR(inode->i_mode)) {
-- 
2.30.2

