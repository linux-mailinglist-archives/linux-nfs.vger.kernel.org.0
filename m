Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD17531340B
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Feb 2021 14:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhBHN4q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Feb 2021 08:56:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:36846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231712AbhBHN4c (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 8 Feb 2021 08:56:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25F6F64E05;
        Mon,  8 Feb 2021 13:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612792550;
        bh=eDppt1EGeZpg6gVhyHOJznbaSOyjCyhOfZ8iwiyc+/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BxJEFZ5JIJR9zgzu3vvQRPamJUGx8P1vxzQ2QfgZtztHJaKfkW2/ZqJjVP77Wsv7F
         JjG2xt//uehK3Cp6o2I0+t80W08TFeOnpBnGxZyEHxV1isGUhER/wNiLJKbCSreqr2
         vW3FyfWMasg770k/U1MiFlm68gbw4QeoeL3Vlv4ixH1t8fMOAganJKlAPRYpGsBNex
         iJF38fQZZrRxGBNcAMfTrHqwnkl4vnJBqVMEogdQbSMR4mDzhJsKyl+99rDPFscBEW
         VEc+N0psuhr6Vg8VPzXNbxPaR+wR2g1iBhmna9H3PeLg9b8Uihtxe1w5DsHLeyk/HB
         ywoX8MNv83C5A==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFS: Always clear an invalid mapping when attempting a buffered write
Date:   Mon,  8 Feb 2021 08:55:47 -0500
Message-Id: <20210208135547.27153-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210208135547.27153-2-trondmy@kernel.org>
References: <20210208135547.27153-1-trondmy@kernel.org>
 <20210208135547.27153-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the page cache is invalid, then we can't do read-modify-write, so
ensure that we do clear it when we know it is invalid.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/file.c          |  2 +
 fs/nfs/inode.c         | 97 +++++++++++++++++++++++-------------------
 include/linux/nfs_fs.h |  1 +
 3 files changed, 57 insertions(+), 43 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 02795a01c7ef..03fd1dcc96bd 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -632,6 +632,8 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 			goto out;
 	}
 
+	nfs_clear_invalid_mapping(file->f_mapping);
+
 	since = filemap_sample_wb_err(file->f_mapping);
 	nfs_start_io_write(inode);
 	result = generic_write_checks(iocb, from);
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 522aa10a1a3e..2533053d764a 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1257,55 +1257,19 @@ static int nfs_invalidate_mapping(struct inode *inode, struct address_space *map
 	return 0;
 }
 
-bool nfs_mapping_need_revalidate_inode(struct inode *inode)
-{
-	return nfs_check_cache_invalid(inode, NFS_INO_REVAL_PAGECACHE) ||
-		NFS_STALE(inode);
-}
-
-int nfs_revalidate_mapping_rcu(struct inode *inode)
-{
-	struct nfs_inode *nfsi = NFS_I(inode);
-	unsigned long *bitlock = &nfsi->flags;
-	int ret = 0;
-
-	if (IS_SWAPFILE(inode))
-		goto out;
-	if (nfs_mapping_need_revalidate_inode(inode)) {
-		ret = -ECHILD;
-		goto out;
-	}
-	spin_lock(&inode->i_lock);
-	if (test_bit(NFS_INO_INVALIDATING, bitlock) ||
-	    (nfsi->cache_validity & NFS_INO_INVALID_DATA))
-		ret = -ECHILD;
-	spin_unlock(&inode->i_lock);
-out:
-	return ret;
-}
-
 /**
- * nfs_revalidate_mapping - Revalidate the pagecache
- * @inode: pointer to host inode
+ * nfs_clear_invalid_mapping - Conditionally clear a mapping
  * @mapping: pointer to mapping
+ *
+ * If the NFS_INO_INVALID_DATA inode flag is set, clear the mapping.
  */
-int nfs_revalidate_mapping(struct inode *inode,
-		struct address_space *mapping)
+int nfs_clear_invalid_mapping(struct address_space *mapping)
 {
+	struct inode *inode = mapping->host;
 	struct nfs_inode *nfsi = NFS_I(inode);
 	unsigned long *bitlock = &nfsi->flags;
 	int ret = 0;
 
-	/* swapfiles are not supposed to be shared. */
-	if (IS_SWAPFILE(inode))
-		goto out;
-
-	if (nfs_mapping_need_revalidate_inode(inode)) {
-		ret = __nfs_revalidate_inode(NFS_SERVER(inode), inode);
-		if (ret < 0)
-			goto out;
-	}
-
 	/*
 	 * We must clear NFS_INO_INVALID_DATA first to ensure that
 	 * invalidations that come in while we're shooting down the mappings
@@ -1336,8 +1300,8 @@ int nfs_revalidate_mapping(struct inode *inode,
 
 	set_bit(NFS_INO_INVALIDATING, bitlock);
 	smp_wmb();
-	nfsi->cache_validity &= ~(NFS_INO_INVALID_DATA|
-			NFS_INO_DATA_INVAL_DEFER);
+	nfsi->cache_validity &=
+		~(NFS_INO_INVALID_DATA | NFS_INO_DATA_INVAL_DEFER);
 	spin_unlock(&inode->i_lock);
 	trace_nfs_invalidate_mapping_enter(inode);
 	ret = nfs_invalidate_mapping(inode, mapping);
@@ -1350,6 +1314,53 @@ int nfs_revalidate_mapping(struct inode *inode,
 	return ret;
 }
 
+bool nfs_mapping_need_revalidate_inode(struct inode *inode)
+{
+	return nfs_check_cache_invalid(inode, NFS_INO_REVAL_PAGECACHE) ||
+		NFS_STALE(inode);
+}
+
+int nfs_revalidate_mapping_rcu(struct inode *inode)
+{
+	struct nfs_inode *nfsi = NFS_I(inode);
+	unsigned long *bitlock = &nfsi->flags;
+	int ret = 0;
+
+	if (IS_SWAPFILE(inode))
+		goto out;
+	if (nfs_mapping_need_revalidate_inode(inode)) {
+		ret = -ECHILD;
+		goto out;
+	}
+	spin_lock(&inode->i_lock);
+	if (test_bit(NFS_INO_INVALIDATING, bitlock) ||
+	    (nfsi->cache_validity & NFS_INO_INVALID_DATA))
+		ret = -ECHILD;
+	spin_unlock(&inode->i_lock);
+out:
+	return ret;
+}
+
+/**
+ * nfs_revalidate_mapping - Revalidate the pagecache
+ * @inode: pointer to host inode
+ * @mapping: pointer to mapping
+ */
+int nfs_revalidate_mapping(struct inode *inode, struct address_space *mapping)
+{
+	/* swapfiles are not supposed to be shared. */
+	if (IS_SWAPFILE(inode))
+		return 0;
+
+	if (nfs_mapping_need_revalidate_inode(inode)) {
+		int ret = __nfs_revalidate_inode(NFS_SERVER(inode), inode);
+		if (ret < 0)
+			return ret;
+	}
+
+	return nfs_clear_invalid_mapping(mapping);
+}
+
 static bool nfs_file_has_writers(struct nfs_inode *nfsi)
 {
 	struct inode *inode = &nfsi->vfs_inode;
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 681ed98e4ba8..0b0d67017177 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -387,6 +387,7 @@ extern int nfs_open(struct inode *, struct file *);
 extern int nfs_attribute_cache_expired(struct inode *inode);
 extern int nfs_revalidate_inode(struct nfs_server *server, struct inode *inode);
 extern int __nfs_revalidate_inode(struct nfs_server *, struct inode *);
+extern int nfs_clear_invalid_mapping(struct address_space *mapping);
 extern bool nfs_mapping_need_revalidate_inode(struct inode *inode);
 extern int nfs_revalidate_mapping(struct inode *inode, struct address_space *mapping);
 extern int nfs_revalidate_mapping_rcu(struct inode *inode);
-- 
2.29.2

