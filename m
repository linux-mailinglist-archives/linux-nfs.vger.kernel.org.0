Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E8333177E
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Mar 2021 20:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhCHTnM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Mar 2021 14:43:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230342AbhCHTm7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 8 Mar 2021 14:42:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B55BA652B5;
        Mon,  8 Mar 2021 19:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615232579;
        bh=wF7CqdMQYwmdlB5JCqNIxSPxz4U5thdgyXyv83AMSwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VahfjflxUur9YXgMP+0WZNDboMrVQPwdnt3be9u6uAtluhq6Cfl7RVV47OwZ1qor1
         ATXqUdPYk8kE/nLQ/2RyvG3+E02jR99iZo3gcyKNGYKviGw02BzzX3CFBllP65zPZK
         1YpvX8etdPB1/QwzYbUZ9UqxP8ogmZVHd3aV8yOzYJFbasGTftk2v/9yxPVvUB6tQw
         GivmdpGtijwT3iPsDrbNKzwQQYIu2X92jn+u72NmQqB+Wj0XjXb0N9c70gbwVUUVY3
         6G989DrD9RHDVaQxPXDaMZ54ACno5tN1F4mv7q6qe58O0eakb43xSD1T4TPJTcJoGf
         llocpMNBb/YGA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Cc:     Geert Jansen <gerardu@amazon.com>
Subject: [PATCH v2 5/5] NFS: Fix open coded versions of nfs_set_cache_invalid() in NFSv4
Date:   Mon,  8 Mar 2021 14:42:55 -0500
Message-Id: <20210308194255.7873-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210308194255.7873-4-trondmy@kernel.org>
References: <20210308194255.7873-1-trondmy@kernel.org>
 <20210308194255.7873-2-trondmy@kernel.org>
 <20210308194255.7873-3-trondmy@kernel.org>
 <20210308194255.7873-4-trondmy@kernel.org>
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
 fs/nfs/inode.c     |  1 +
 fs/nfs/nfs42proc.c | 12 +++++++-----
 fs/nfs/nfs4proc.c  | 28 ++++++++++++----------------
 3 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index eb1ae77f411a..a7fb076a5f44 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -229,6 +229,7 @@ void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 	if (flags & NFS_INO_INVALID_DATA)
 		nfs_fscache_invalidate(inode);
 }
+EXPORT_SYMBOL_GPL(nfs_set_cache_invalid);
 
 /*
  * Invalidate the local caches
diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index f3fd935620fc..094024b0aca1 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -357,13 +357,15 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 	truncate_pagecache_range(dst_inode, pos_dst,
 				 pos_dst + res->write_res.count);
 	spin_lock(&dst_inode->i_lock);
-	NFS_I(dst_inode)->cache_validity |= (NFS_INO_REVAL_PAGECACHE |
-			NFS_INO_REVAL_FORCED | NFS_INO_INVALID_SIZE |
-			NFS_INO_INVALID_ATTR | NFS_INO_INVALID_DATA);
+	nfs_set_cache_invalid(
+		dst_inode, NFS_INO_REVAL_PAGECACHE | NFS_INO_REVAL_FORCED |
+				   NFS_INO_INVALID_SIZE | NFS_INO_INVALID_ATTR |
+				   NFS_INO_INVALID_DATA);
 	spin_unlock(&dst_inode->i_lock);
 	spin_lock(&src_inode->i_lock);
-	NFS_I(src_inode)->cache_validity |= (NFS_INO_REVAL_PAGECACHE |
-			NFS_INO_REVAL_FORCED | NFS_INO_INVALID_ATIME);
+	nfs_set_cache_invalid(src_inode, NFS_INO_REVAL_PAGECACHE |
+						 NFS_INO_REVAL_FORCED |
+						 NFS_INO_INVALID_ATIME);
 	spin_unlock(&src_inode->i_lock);
 	status = res->write_res.count;
 out:
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 2c8fdb911361..39d9552b7495 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1169,14 +1169,14 @@ int nfs4_call_sync(struct rpc_clnt *clnt,
 static void
 nfs4_inc_nlink_locked(struct inode *inode)
 {
-	NFS_I(inode)->cache_validity |= NFS_INO_INVALID_OTHER;
+	nfs_set_cache_invalid(inode, NFS_INO_INVALID_OTHER);
 	inc_nlink(inode);
 }
 
 static void
 nfs4_dec_nlink_locked(struct inode *inode)
 {
-	NFS_I(inode)->cache_validity |= NFS_INO_INVALID_OTHER;
+	nfs_set_cache_invalid(inode, NFS_INO_INVALID_OTHER);
 	drop_nlink(inode);
 }
 
@@ -1187,35 +1187,31 @@ nfs4_update_changeattr_locked(struct inode *inode,
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
 
-	nfsi->cache_validity |= NFS_INO_INVALID_CTIME
-		| NFS_INO_INVALID_MTIME
-		| cache_validity;
+	cache_validity |= NFS_INO_INVALID_CTIME | NFS_INO_INVALID_MTIME;
 
 	if (cinfo->atomic && cinfo->before == inode_peek_iversion_raw(inode)) {
 		nfsi->cache_validity &= ~NFS_INO_REVAL_PAGECACHE;
 		nfsi->attrtimeo_timestamp = jiffies;
 	} else {
 		if (S_ISDIR(inode->i_mode)) {
-			nfsi->cache_validity |= NFS_INO_INVALID_DATA;
+			cache_validity |= NFS_INO_INVALID_DATA;
 			nfs_force_lookup_revalidate(inode);
 		} else {
 			if (!NFS_PROTO(inode)->have_delegation(inode,
 							       FMODE_READ))
-				nfsi->cache_validity |= NFS_INO_REVAL_PAGECACHE;
+				cache_validity |= NFS_INO_REVAL_PAGECACHE;
 		}
 
 		if (cinfo->before != inode_peek_iversion_raw(inode))
-			nfsi->cache_validity |= NFS_INO_INVALID_ACCESS |
-						NFS_INO_INVALID_ACL |
-						NFS_INO_INVALID_XATTR;
+			cache_validity |= NFS_INO_INVALID_ACCESS |
+					  NFS_INO_INVALID_ACL |
+					  NFS_INO_INVALID_XATTR;
 	}
 	inode_set_iversion_raw(inode, cinfo->after);
 	nfsi->read_cache_jiffies = timestamp;
 	nfsi->attr_gencount = nfs_inc_attr_generation_counter();
+	nfs_set_cache_invalid(inode, cache_validity);
 	nfsi->cache_validity &= ~NFS_INO_INVALID_CHANGE;
-
-	if (nfsi->cache_validity & NFS_INO_INVALID_DATA)
-		nfs_fscache_invalidate(inode);
 }
 
 void
@@ -5915,9 +5911,9 @@ static int __nfs4_proc_set_acl(struct inode *inode, const void *buf, size_t bufl
 	 * so mark the attribute cache invalid.
 	 */
 	spin_lock(&inode->i_lock);
-	NFS_I(inode)->cache_validity |= NFS_INO_INVALID_CHANGE
-		| NFS_INO_INVALID_CTIME
-		| NFS_INO_REVAL_FORCED;
+	nfs_set_cache_invalid(inode, NFS_INO_INVALID_CHANGE |
+					     NFS_INO_INVALID_CTIME |
+					     NFS_INO_REVAL_FORCED);
 	spin_unlock(&inode->i_lock);
 	nfs_access_zap_cache(inode);
 	nfs_zap_acl_cache(inode);
-- 
2.29.2

