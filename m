Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D7A33177B
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Mar 2021 20:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhCHTnM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Mar 2021 14:43:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230299AbhCHTm6 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 8 Mar 2021 14:42:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3031E652AC;
        Mon,  8 Mar 2021 19:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615232578;
        bh=L0Wr9TfqAZnW5Uf3pPdj2QB5+gEcD0shx11hM0QzNlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Di5Vnf339+yEN4rYFHPSeAtR/WWnYOodRWR9rmNjtXDubmBkKsWNIE88rbM5M2AKQ
         1w0LhW/CBfCzhMlkYMAyF+27uajGd0GkHSbWMH4yWIx/0pJEafh9dVRMXLS9s7BTYr
         1X0Grxcd3pZ8Tuxmaku0zUGXkjWlcn/hKP3zbW+fzmshgSkvLaDtjUhMN1tn83fJFH
         1oT7M53AtRsXyL0ICBuA0jM+NpXY1/E329fUeOeWW2kuBYaLjoYactWQf/m1IiP4iL
         kmUFzelSrwOFp6x+Kvg+r1Ip6FknU+yEtb7+Iz+304mD6tptTUrFbkO1fU+DVYspbT
         yCv7gpX82tWkQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Cc:     Geert Jansen <gerardu@amazon.com>
Subject: [PATCH v2 4/5] NFS: Fix open coded versions of nfs_set_cache_invalid()
Date:   Mon,  8 Mar 2021 14:42:54 -0500
Message-Id: <20210308194255.7873-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210308194255.7873-3-trondmy@kernel.org>
References: <20210308194255.7873-1-trondmy@kernel.org>
 <20210308194255.7873-2-trondmy@kernel.org>
 <20210308194255.7873-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

nfs_set_cache_invalid() has code to handle delegations, and other
optimisations, so let's use it when appropriate.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c    | 20 ++++++++++----------
 fs/nfs/inode.c  |  4 ++--
 fs/nfs/unlink.c |  6 +++---
 fs/nfs/write.c  |  8 ++++----
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 02ac982846f4..fc4f490f2d78 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -81,8 +81,9 @@ static struct nfs_open_dir_context *alloc_nfs_open_dir_context(struct inode *dir
 		spin_lock(&dir->i_lock);
 		if (list_empty(&nfsi->open_files) &&
 		    (nfsi->cache_validity & NFS_INO_DATA_INVAL_DEFER))
-			nfsi->cache_validity |= NFS_INO_INVALID_DATA |
-				NFS_INO_REVAL_FORCED;
+			nfs_set_cache_invalid(dir,
+					      NFS_INO_INVALID_DATA |
+						      NFS_INO_REVAL_FORCED);
 		list_add(&ctx->list, &nfsi->open_files);
 		spin_unlock(&dir->i_lock);
 		return ctx;
@@ -1700,10 +1701,9 @@ static void nfs_drop_nlink(struct inode *inode)
 	if (inode->i_nlink > 0)
 		drop_nlink(inode);
 	NFS_I(inode)->attr_gencount = nfs_inc_attr_generation_counter();
-	NFS_I(inode)->cache_validity |= NFS_INO_INVALID_CHANGE
-		| NFS_INO_INVALID_CTIME
-		| NFS_INO_INVALID_OTHER
-		| NFS_INO_REVAL_FORCED;
+	nfs_set_cache_invalid(
+		inode, NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_CTIME |
+			       NFS_INO_INVALID_OTHER | NFS_INO_REVAL_FORCED);
 	spin_unlock(&inode->i_lock);
 }
 
@@ -1715,7 +1715,7 @@ static void nfs_dentry_iput(struct dentry *dentry, struct inode *inode)
 {
 	if (S_ISDIR(inode->i_mode))
 		/* drop any readdir cache as it could easily be old */
-		NFS_I(inode)->cache_validity |= NFS_INO_INVALID_DATA;
+		nfs_set_cache_invalid(inode, NFS_INO_INVALID_DATA);
 
 	if (dentry->d_flags & DCACHE_NFSFS_RENAMED) {
 		nfs_complete_unlink(dentry, inode);
@@ -2481,9 +2481,9 @@ int nfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	if (error == 0) {
 		spin_lock(&old_inode->i_lock);
 		NFS_I(old_inode)->attr_gencount = nfs_inc_attr_generation_counter();
-		NFS_I(old_inode)->cache_validity |= NFS_INO_INVALID_CHANGE
-			| NFS_INO_INVALID_CTIME
-			| NFS_INO_REVAL_FORCED;
+		nfs_set_cache_invalid(old_inode, NFS_INO_INVALID_CHANGE |
+							 NFS_INO_INVALID_CTIME |
+							 NFS_INO_REVAL_FORCED);
 		spin_unlock(&old_inode->i_lock);
 	}
 out:
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index d21bfaac10b0..eb1ae77f411a 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1067,8 +1067,8 @@ void nfs_inode_attach_open_context(struct nfs_open_context *ctx)
 	spin_lock(&inode->i_lock);
 	if (list_empty(&nfsi->open_files) &&
 	    (nfsi->cache_validity & NFS_INO_DATA_INVAL_DEFER))
-		nfsi->cache_validity |= NFS_INO_INVALID_DATA |
-			NFS_INO_REVAL_FORCED;
+		nfs_set_cache_invalid(inode, NFS_INO_INVALID_DATA |
+						     NFS_INO_REVAL_FORCED);
 	list_add_tail_rcu(&ctx->list, &nfsi->open_files);
 	spin_unlock(&inode->i_lock);
 }
diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index b27ebdccef70..5fa11e1aca4c 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -500,9 +500,9 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
 		nfs_set_verifier(dentry, nfs_save_change_attribute(dir));
 		spin_lock(&inode->i_lock);
 		NFS_I(inode)->attr_gencount = nfs_inc_attr_generation_counter();
-		NFS_I(inode)->cache_validity |= NFS_INO_INVALID_CHANGE
-			| NFS_INO_INVALID_CTIME
-			| NFS_INO_REVAL_FORCED;
+		nfs_set_cache_invalid(inode, NFS_INO_INVALID_CHANGE |
+						     NFS_INO_INVALID_CTIME |
+						     NFS_INO_REVAL_FORCED);
 		spin_unlock(&inode->i_lock);
 		d_move(dentry, sdentry);
 		break;
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 82bdcb982186..f05a90338a76 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -303,9 +303,9 @@ static void nfs_set_pageerror(struct address_space *mapping)
 	nfs_zap_mapping(mapping->host, mapping);
 	/* Force file size revalidation */
 	spin_lock(&inode->i_lock);
-	NFS_I(inode)->cache_validity |= NFS_INO_REVAL_FORCED |
-					NFS_INO_REVAL_PAGECACHE |
-					NFS_INO_INVALID_SIZE;
+	nfs_set_cache_invalid(inode, NFS_INO_REVAL_FORCED |
+					     NFS_INO_REVAL_PAGECACHE |
+					     NFS_INO_INVALID_SIZE);
 	spin_unlock(&inode->i_lock);
 }
 
@@ -1604,7 +1604,7 @@ static int nfs_writeback_done(struct rpc_task *task,
 	/* Deal with the suid/sgid bit corner case */
 	if (nfs_should_remove_suid(inode)) {
 		spin_lock(&inode->i_lock);
-		NFS_I(inode)->cache_validity |= NFS_INO_INVALID_OTHER;
+		nfs_set_cache_invalid(inode, NFS_INO_INVALID_OTHER);
 		spin_unlock(&inode->i_lock);
 	}
 	return 0;
-- 
2.29.2

