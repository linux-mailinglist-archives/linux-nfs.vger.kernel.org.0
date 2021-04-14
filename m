Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38E235F532
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 15:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351437AbhDNNoh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 09:44:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351594AbhDNNoV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Apr 2021 09:44:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 021C2611AD
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 13:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618407839;
        bh=bOZTbX+tB4T5FaX6OFmU9kpbUdLbdrQP8Qd3Ss/Zsos=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RsnjddzSqvo7Kig3AoKNtkUv19jQbHahCc56DcF4rkbQcRdN6Fu2W4Nb2OF6iTSYu
         jejR3qiuPhbS7CFFj1Q95WJeFsbtyWPNaPlc+L20Gp2SUQNgbKbNOpl9aVMVprdQ4y
         8GPFxw+TFWOnYIxl/pBUenYt3F0aRmK7RIFHsXAwwTMMVhFbUs4GcWerxuS7dc3lJi
         3M4jw6Y6UFtzDX58ux8lCb+VyG5rej8iUwgnQ4KWo4IlFTE9muFgLZIMQ+ZIA62pRq
         nILmNDQEkwzkOO1SkQnxVManO22Jfl4lTuSsG7TdXZ8y4mHSImn7fKBxrRMcceweUW
         Zz0wc1jWfsB1g==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 09/26] NFS: Add a cache validity flag argument to nfs_revalidate_inode()
Date:   Wed, 14 Apr 2021 09:43:36 -0400
Message-Id: <20210414134353.11860-10-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414134353.11860-9-trondmy@kernel.org>
References: <20210414134353.11860-1-trondmy@kernel.org>
 <20210414134353.11860-2-trondmy@kernel.org>
 <20210414134353.11860-3-trondmy@kernel.org>
 <20210414134353.11860-4-trondmy@kernel.org>
 <20210414134353.11860-5-trondmy@kernel.org>
 <20210414134353.11860-6-trondmy@kernel.org>
 <20210414134353.11860-7-trondmy@kernel.org>
 <20210414134353.11860-8-trondmy@kernel.org>
 <20210414134353.11860-9-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Add an argument to nfs_revalidate_inode() to allow callers to specify
which attributes they need to check for validity.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c           |  2 +-
 fs/nfs/export.c        |  6 +-----
 fs/nfs/inode.c         | 25 +++++++------------------
 fs/nfs/nfs3acl.c       |  2 +-
 fs/nfs/nfs4proc.c      |  6 +++---
 include/linux/nfs_fs.h |  2 +-
 6 files changed, 14 insertions(+), 29 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 0cd7c59a6601..e924d65c125e 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -3006,7 +3006,7 @@ int nfs_permission(struct user_namespace *mnt_userns,
 	if (mask & MAY_NOT_BLOCK)
 		return -ECHILD;
 
-	res = nfs_revalidate_inode(NFS_SERVER(inode), inode);
+	res = nfs_revalidate_inode(inode, NFS_INO_INVALID_OTHER);
 	if (res == 0)
 		res = generic_permission(&init_user_ns, inode, mask);
 	goto out;
diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index b347e3ce0cc8..37a1a88df771 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -169,11 +169,7 @@ nfs_get_parent(struct dentry *dentry)
 
 static u64 nfs_fetch_iversion(struct inode *inode)
 {
-	struct nfs_server *server = NFS_SERVER(inode);
-
-	if (nfs_check_cache_invalid(inode, NFS_INO_INVALID_CHANGE |
-						   NFS_INO_REVAL_PAGECACHE))
-		__nfs_revalidate_inode(server, inode);
+	nfs_revalidate_inode(inode, NFS_INO_INVALID_CHANGE);
 	return inode_peek_iversion_raw(inode);
 }
 
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index d34da63202cc..b9aac408f03a 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -802,16 +802,6 @@ static void nfs_readdirplus_parent_cache_hit(struct dentry *dentry)
 	dput(parent);
 }
 
-static bool nfs_need_revalidate_inode(struct inode *inode)
-{
-	if (NFS_I(inode)->cache_validity &
-			(NFS_INO_INVALID_ATTR|NFS_INO_INVALID_LABEL))
-		return true;
-	if (nfs_attribute_cache_expired(inode))
-		return true;
-	return false;
-}
-
 static u32 nfs_get_valid_attrmask(struct inode *inode)
 {
 	unsigned long cache_validity = READ_ONCE(NFS_I(inode)->cache_validity);
@@ -1004,7 +994,6 @@ void nfs_close_context(struct nfs_open_context *ctx, int is_sync)
 {
 	struct nfs_inode *nfsi;
 	struct inode *inode;
-	struct nfs_server *server;
 
 	if (!(ctx->mode & FMODE_WRITE))
 		return;
@@ -1020,10 +1009,10 @@ void nfs_close_context(struct nfs_open_context *ctx, int is_sync)
 		return;
 	if (!list_empty(&nfsi->open_files))
 		return;
-	server = NFS_SERVER(inode);
-	if (server->flags & NFS_MOUNT_NOCTO)
+	if (NFS_SERVER(inode)->flags & NFS_MOUNT_NOCTO)
 		return;
-	nfs_revalidate_inode(server, inode);
+	nfs_revalidate_inode(inode,
+			     NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_SIZE);
 }
 EXPORT_SYMBOL_GPL(nfs_close_context);
 
@@ -1278,16 +1267,16 @@ int nfs_attribute_cache_expired(struct inode *inode)
 
 /**
  * nfs_revalidate_inode - Revalidate the inode attributes
- * @server: pointer to nfs_server struct
  * @inode: pointer to inode struct
+ * @flags: cache flags to check
  *
  * Updates inode attribute information by retrieving the data from the server.
  */
-int nfs_revalidate_inode(struct nfs_server *server, struct inode *inode)
+int nfs_revalidate_inode(struct inode *inode, unsigned long flags)
 {
-	if (!nfs_need_revalidate_inode(inode))
+	if (!nfs_check_cache_invalid(inode, flags))
 		return NFS_STALE(inode) ? -ESTALE : 0;
-	return __nfs_revalidate_inode(server, inode);
+	return __nfs_revalidate_inode(NFS_SERVER(inode), inode);
 }
 EXPORT_SYMBOL_GPL(nfs_revalidate_inode);
 
diff --git a/fs/nfs/nfs3acl.c b/fs/nfs/nfs3acl.c
index bb386a691e69..9ec560aa4a50 100644
--- a/fs/nfs/nfs3acl.c
+++ b/fs/nfs/nfs3acl.c
@@ -65,7 +65,7 @@ struct posix_acl *nfs3_get_acl(struct inode *inode, int type)
 	if (!nfs_server_capable(inode, NFS_CAP_ACLS))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	status = nfs_revalidate_inode(server, inode);
+	status = nfs_revalidate_inode(inode, NFS_INO_INVALID_CHANGE);
 	if (status < 0)
 		return ERR_PTR(status);
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 1cf98c40e3b2..6b990fe5bc1f 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5868,7 +5868,7 @@ static ssize_t nfs4_proc_get_acl(struct inode *inode, void *buf, size_t buflen)
 
 	if (!nfs4_server_supports_acls(server))
 		return -EOPNOTSUPP;
-	ret = nfs_revalidate_inode(server, inode);
+	ret = nfs_revalidate_inode(inode, NFS_INO_INVALID_CHANGE);
 	if (ret < 0)
 		return ret;
 	if (NFS_I(inode)->cache_validity & NFS_INO_INVALID_ACL)
@@ -7619,7 +7619,7 @@ static int nfs4_xattr_get_nfs4_user(const struct xattr_handler *handler,
 			return -EACCES;
 	}
 
-	ret = nfs_revalidate_inode(NFS_SERVER(inode), inode);
+	ret = nfs_revalidate_inode(inode, NFS_INO_INVALID_CHANGE);
 	if (ret)
 		return ret;
 
@@ -7650,7 +7650,7 @@ nfs4_listxattr_nfs4_user(struct inode *inode, char *list, size_t list_len)
 			return 0;
 	}
 
-	ret = nfs_revalidate_inode(NFS_SERVER(inode), inode);
+	ret = nfs_revalidate_inode(inode, NFS_INO_INVALID_CHANGE);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index eadaabd18dc7..624ffd47a9d4 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -386,7 +386,7 @@ extern void nfs_access_set_mask(struct nfs_access_entry *, u32);
 extern int nfs_permission(struct user_namespace *, struct inode *, int);
 extern int nfs_open(struct inode *, struct file *);
 extern int nfs_attribute_cache_expired(struct inode *inode);
-extern int nfs_revalidate_inode(struct nfs_server *server, struct inode *inode);
+extern int nfs_revalidate_inode(struct inode *inode, unsigned long flags);
 extern int __nfs_revalidate_inode(struct nfs_server *, struct inode *);
 extern int nfs_clear_invalid_mapping(struct address_space *mapping);
 extern bool nfs_mapping_need_revalidate_inode(struct inode *inode);
-- 
2.30.2

