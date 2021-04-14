Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C57F35F533
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 15:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351553AbhDNNoh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 09:44:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351597AbhDNNoV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Apr 2021 09:44:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D927761220
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 13:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618407840;
        bh=eWTSfJFUyDNCFE1PXB3MjMvAFXodJMQEQV4qpSD4Bqk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=h8sU9MAlp0rWysm3gt6ba5oh6Y/tuNwzePptIQptD8D61YGx1lJDI7ZjmYlnkgzUN
         f9QQ/tBFgjEbq77fqj0UDIAWDEQQcMhkdnjevSM8Htuf8JM3L2MaDx/fX6rn8cGjFv
         WdrxPP5xAiNmHHCUSNetpCjhOxRx7iGUFEAIf705GbWtigk/VQKFxMQs2ZkpVYeruW
         ZCl7PmT5IghVA62gx/JayASWL64MSzCpuqLVKtXjxv65gCfTg/AUEd7AD0Q8HT143M
         uQzgcBfs1XmBpPImytvulgFxECF8oxrz5JKLb3JOR01IubZUH/gjEDnCNFT38Ft7iZ
         9zO8sa2y0KEyw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 11/26] NFS: Don't set NFS_INO_REVAL_PAGECACHE in the inode cache validity
Date:   Wed, 14 Apr 2021 09:43:38 -0400
Message-Id: <20210414134353.11860-12-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414134353.11860-11-trondmy@kernel.org>
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
index aec402d048eb..3d18e66a4b8f 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -202,11 +202,12 @@ void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
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
@@ -1917,7 +1918,6 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	nfsi->cache_validity &= ~(NFS_INO_INVALID_ATTR
 			| NFS_INO_INVALID_ATIME
 			| NFS_INO_REVAL_FORCED
-			| NFS_INO_REVAL_PAGECACHE
 			| NFS_INO_INVALID_BLOCKS);
 
 	/* Do atomic weak cache consistency updates */
@@ -1956,7 +1956,6 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	} else {
 		nfsi->cache_validity |= save_cache_validity &
 				(NFS_INO_INVALID_CHANGE
-				| NFS_INO_REVAL_PAGECACHE
 				| NFS_INO_REVAL_FORCED);
 		cache_revalidated = false;
 	}
@@ -2008,7 +2007,6 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	} else {
 		nfsi->cache_validity |= save_cache_validity &
 				(NFS_INO_INVALID_SIZE
-				| NFS_INO_REVAL_PAGECACHE
 				| NFS_INO_REVAL_FORCED);
 		cache_revalidated = false;
 	}
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a21311520404..a490f1373765 100644
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

