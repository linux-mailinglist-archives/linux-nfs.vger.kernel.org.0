Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E7142050B
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Oct 2021 05:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhJDDEg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 3 Oct 2021 23:04:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230513AbhJDDEf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 3 Oct 2021 23:04:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6962461215
        for <linux-nfs@vger.kernel.org>; Mon,  4 Oct 2021 03:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633316567;
        bh=aQQOZAOaQMlr7B3u2h/FnR10bUeMfO5A975X7uCwZH0=;
        h=From:To:Subject:Date:From;
        b=s5QTe+8mNQQiobP41tjAuTEIfEGPocw3L8KSQjFzPvspCKrUWRBhVrUQkughMrHYB
         P66jZqIh5QR/CTLTUsKQtg0irOSPSwpTOiNUP3CfVV8WpHDyEXocHLN3mDMFeKfZ0Z
         Su9Z+XC1Cy65OYM8TRZ8R3diFLbkISkd62NFEORH4FbXoGOpMdy9ql6B/5Aml6QhIo
         i9E4mVJTMTju9r1F6HzPpSWKcdmDVhFeugzWLDCqGL/y6GcpbZcYK9nCr44WefF018
         JeYeLnXI1Xy9T/hqRQpy2krzNE3NnBcJnVpGtkQeO2yXAUUBOxFCyllnrvG1Pa+Q08
         pWMWo2THMtO1Q==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Save some space in the inode
Date:   Sun,  3 Oct 2021 23:02:46 -0400
Message-Id: <20211004030246.48424-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Save some space in the nfs_inode by setting up an anonymous union with
the fields that are peculiar to a specific type of filesystem object.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c         | 26 ++++++++++++++++++--------
 include/linux/nfs_fs.h | 42 ++++++++++++++++++++++++------------------
 2 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 3bd0ae438663..23163220abba 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -431,6 +431,22 @@ nfs_ilookup(struct super_block *sb, struct nfs_fattr *fattr, struct nfs_fh *fh)
 	return inode;
 }
 
+static void nfs_inode_init_regular(struct nfs_inode *nfsi)
+{
+	atomic_long_set(&nfsi->nrequests, 0);
+	INIT_LIST_HEAD(&nfsi->commit_info.list);
+	atomic_long_set(&nfsi->commit_info.ncommit, 0);
+	atomic_set(&nfsi->commit_info.rpcs_out, 0);
+	mutex_init(&nfsi->commit_mutex);
+}
+
+static void nfs_inode_init_dir(struct nfs_inode *nfsi)
+{
+	nfsi->cache_change_attribute = 0;
+	memset(nfsi->cookieverf, 0, sizeof(nfsi->cookieverf));
+	init_rwsem(&nfsi->rmdir_sem);
+}
+
 /*
  * This is our front-end to iget that looks up inodes by file handle
  * instead of inode number.
@@ -485,10 +501,12 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr, st
 		if (S_ISREG(inode->i_mode)) {
 			inode->i_fop = NFS_SB(sb)->nfs_client->rpc_ops->file_ops;
 			inode->i_data.a_ops = &nfs_file_aops;
+			nfs_inode_init_regular(nfsi);
 		} else if (S_ISDIR(inode->i_mode)) {
 			inode->i_op = NFS_SB(sb)->nfs_client->rpc_ops->dir_inode_ops;
 			inode->i_fop = &nfs_dir_operations;
 			inode->i_data.a_ops = &nfs_dir_aops;
+			nfs_inode_init_dir(nfsi);
 			/* Deal with crossing mountpoints */
 			if (fattr->valid & NFS_ATTR_FATTR_MOUNTPOINT ||
 					fattr->valid & NFS_ATTR_FATTR_V4_REFERRAL) {
@@ -514,7 +532,6 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr, st
 		inode->i_uid = make_kuid(&init_user_ns, -2);
 		inode->i_gid = make_kgid(&init_user_ns, -2);
 		inode->i_blocks = 0;
-		memset(nfsi->cookieverf, 0, sizeof(nfsi->cookieverf));
 		nfsi->write_io = 0;
 		nfsi->read_io = 0;
 
@@ -2262,14 +2279,7 @@ static void init_once(void *foo)
 	INIT_LIST_HEAD(&nfsi->open_files);
 	INIT_LIST_HEAD(&nfsi->access_cache_entry_lru);
 	INIT_LIST_HEAD(&nfsi->access_cache_inode_lru);
-	INIT_LIST_HEAD(&nfsi->commit_info.list);
-	atomic_long_set(&nfsi->nrequests, 0);
-	atomic_long_set(&nfsi->commit_info.ncommit, 0);
-	atomic_set(&nfsi->commit_info.rpcs_out, 0);
-	init_rwsem(&nfsi->rmdir_sem);
-	mutex_init(&nfsi->commit_mutex);
 	nfs4_init_once(nfsi);
-	nfsi->cache_change_attribute = 0;
 }
 
 static int __init nfs_init_inodecache(void)
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index ca547cc5458c..5893b986fa3b 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -155,33 +155,39 @@ struct nfs_inode {
 	unsigned long		attrtimeo_timestamp;
 
 	unsigned long		attr_gencount;
-	/* "Generation counter" for the attribute cache. This is
-	 * bumped whenever we update the metadata on the
-	 * server.
-	 */
-	unsigned long		cache_change_attribute;
 
 	struct rb_root		access_cache;
 	struct list_head	access_cache_entry_lru;
 	struct list_head	access_cache_inode_lru;
 
-	/*
-	 * This is the cookie verifier used for NFSv3 readdir
-	 * operations
-	 */
-	__be32			cookieverf[NFS_DIR_VERIFIER_SIZE];
-
-	atomic_long_t		nrequests;
-	struct nfs_mds_commit_info commit_info;
+	union {
+		/* Directory */
+		struct {
+			/* "Generation counter" for the attribute cache.
+			 * This is bumped whenever we update the metadata
+			 * on the server.
+			 */
+			unsigned long	cache_change_attribute;
+			/*
+			 * This is the cookie verifier used for NFSv3 readdir
+			 * operations
+			 */
+			__be32		cookieverf[NFS_DIR_VERIFIER_SIZE];
+			/* Readers: in-flight sillydelete RPC calls */
+			/* Writers: rmdir */
+			struct rw_semaphore	rmdir_sem;
+		};
+		/* Regular file */
+		struct {
+			atomic_long_t	nrequests;
+			struct nfs_mds_commit_info commit_info;
+			struct mutex	commit_mutex;
+		};
+	};
 
 	/* Open contexts for shared mmap writes */
 	struct list_head	open_files;
 
-	/* Readers: in-flight sillydelete RPC calls */
-	/* Writers: rmdir */
-	struct rw_semaphore	rmdir_sem;
-	struct mutex		commit_mutex;
-
 #if IS_ENABLED(CONFIG_NFS_V4)
 	struct nfs4_cached_acl	*nfs4_acl;
         /* NFSv4 state */
-- 
2.31.1

