Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE284BDE1D
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Feb 2022 18:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379984AbiBUQPa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Feb 2022 11:15:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379977AbiBUQP0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Feb 2022 11:15:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADAB27B03
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 08:15:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A01D61295
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 16:15:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24F4C340E9
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 16:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645460101;
        bh=bZ8UNBTsYxWYWmE7gnXiWcN3zOzzag2YsZOhsmvMArQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nnEveK3LAVh0hDxIxnQLw6IKxPUOTBLGYoJf8MQbir3MzR8hbzcRDKrTHnOwNzDAc
         lYFxSZeDiqVMr35jyfjLMXmlu0pn48vxmNWneNa5PX2qxOLeF6cG1NmT5E9ZMFtSTP
         +M8W9+QLjMu9BGMi9MzNqwf1+OOlBXUHnEWLSr17tFtUIcvFHc/EB2pAmW2gE4jzeK
         z8tkszSv14okUl1uC/fwOtawQ9CcsDHeQxgci2GrP2F4i4KJf/65uHh2C3Ig992JUN
         uj5AeIualnGDIPTT66r2Q5jSzvlFLK2KADVyLZ31zPWZv3JrU7IBpyOSVwcH3WoCcR
         ubKvl33ovEg7Q==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 06/13] NFS: Improve heuristic for readdirplus
Date:   Mon, 21 Feb 2022 11:08:44 -0500
Message-Id: <20220221160851.15508-7-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221160851.15508-6-trondmy@kernel.org>
References: <20220221160851.15508-1-trondmy@kernel.org>
 <20220221160851.15508-2-trondmy@kernel.org>
 <20220221160851.15508-3-trondmy@kernel.org>
 <20220221160851.15508-4-trondmy@kernel.org>
 <20220221160851.15508-5-trondmy@kernel.org>
 <20220221160851.15508-6-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The heuristic for readdirplus is designed to try to detect 'ls -l' and
similar patterns. It does so by looking for cache hit/miss patterns in
both the attribute cache and in the dcache of the files in a given
directory, and then sets a flag for the readdirplus code to interpret.

The problem with this approach is that a single attribute or dcache miss
can cause the NFS code to force a refresh of the attributes for the
entire set of files contained in the directory.

To be able to make a more nuanced decision, let's sample the number of
hits and misses in the set of open directory descriptors. That allows us
to set thresholds at which we start preferring READDIRPLUS over regular
READDIR, or at which we start to force a re-read of the remaining
readdir cache using READDIRPLUS.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c           | 83 ++++++++++++++++++++++++++----------------
 fs/nfs/inode.c         |  4 +-
 fs/nfs/internal.h      |  4 +-
 fs/nfs/nfstrace.h      |  1 -
 include/linux/nfs_fs.h |  5 ++-
 5 files changed, 59 insertions(+), 38 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index d0707e63ce45..c4d962bca9ef 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -87,8 +87,7 @@ alloc_nfs_open_dir_context(struct inode *dir)
 			nfs_set_cache_invalid(dir,
 					      NFS_INO_INVALID_DATA |
 						      NFS_INO_REVAL_FORCED);
-		list_add(&ctx->list, &nfsi->open_files);
-		clear_bit(NFS_INO_FORCE_READDIR, &nfsi->flags);
+		list_add_tail_rcu(&ctx->list, &nfsi->open_files);
 		spin_unlock(&dir->i_lock);
 		return ctx;
 	}
@@ -98,9 +97,9 @@ alloc_nfs_open_dir_context(struct inode *dir)
 static void put_nfs_open_dir_context(struct inode *dir, struct nfs_open_dir_context *ctx)
 {
 	spin_lock(&dir->i_lock);
-	list_del(&ctx->list);
+	list_del_rcu(&ctx->list);
 	spin_unlock(&dir->i_lock);
-	kfree(ctx);
+	kfree_rcu(ctx, rcu_head);
 }
 
 /*
@@ -567,7 +566,6 @@ static int nfs_readdir_xdr_filler(struct nfs_readdir_descriptor *desc,
 		/* We requested READDIRPLUS, but the server doesn't grok it */
 		if (error == -ENOTSUPP && desc->plus) {
 			NFS_SERVER(inode)->caps &= ~NFS_CAP_READDIRPLUS;
-			clear_bit(NFS_INO_ADVISE_RDPLUS, &NFS_I(inode)->flags);
 			desc->plus = arg.plus = false;
 			goto again;
 		}
@@ -617,51 +615,61 @@ int nfs_same_file(struct dentry *dentry, struct nfs_entry *entry)
 	return 1;
 }
 
-static
-bool nfs_use_readdirplus(struct inode *dir, struct dir_context *ctx)
+#define NFS_READDIR_CACHE_USAGE_THRESHOLD (8UL)
+
+static bool nfs_use_readdirplus(struct inode *dir, struct dir_context *ctx,
+				unsigned int cache_hits,
+				unsigned int cache_misses)
 {
 	if (!nfs_server_capable(dir, NFS_CAP_READDIRPLUS))
 		return false;
-	if (test_and_clear_bit(NFS_INO_ADVISE_RDPLUS, &NFS_I(dir)->flags))
-		return true;
-	if (ctx->pos == 0)
+	if (ctx->pos == 0 ||
+	    cache_hits + cache_misses > NFS_READDIR_CACHE_USAGE_THRESHOLD)
 		return true;
 	return false;
 }
 
 /*
- * This function is called by the lookup and getattr code to request the
+ * This function is called by the getattr code to request the
  * use of readdirplus to accelerate any future lookups in the same
  * directory.
  */
-void nfs_advise_use_readdirplus(struct inode *dir)
+void nfs_readdir_record_entry_cache_hit(struct inode *dir)
 {
 	struct nfs_inode *nfsi = NFS_I(dir);
+	struct nfs_open_dir_context *ctx;
 
-	if (nfs_server_capable(dir, NFS_CAP_READDIRPLUS) &&
-	    !list_empty(&nfsi->open_files))
-		set_bit(NFS_INO_ADVISE_RDPLUS, &nfsi->flags);
+	if (nfs_server_capable(dir, NFS_CAP_READDIRPLUS)) {
+		rcu_read_lock();
+		list_for_each_entry_rcu (ctx, &nfsi->open_files, list)
+			atomic_inc(&ctx->cache_hits);
+		rcu_read_unlock();
+	}
 }
 
 /*
  * This function is mainly for use by nfs_getattr().
  *
  * If this is an 'ls -l', we want to force use of readdirplus.
- * Do this by checking if there is an active file descriptor
- * and calling nfs_advise_use_readdirplus, then forcing a
- * cache flush.
  */
-void nfs_force_use_readdirplus(struct inode *dir)
+void nfs_readdir_record_entry_cache_miss(struct inode *dir)
 {
 	struct nfs_inode *nfsi = NFS_I(dir);
+	struct nfs_open_dir_context *ctx;
 
-	if (nfs_server_capable(dir, NFS_CAP_READDIRPLUS) &&
-	    !list_empty(&nfsi->open_files)) {
-		set_bit(NFS_INO_ADVISE_RDPLUS, &nfsi->flags);
-		set_bit(NFS_INO_FORCE_READDIR, &nfsi->flags);
+	if (nfs_server_capable(dir, NFS_CAP_READDIRPLUS)) {
+		rcu_read_lock();
+		list_for_each_entry_rcu (ctx, &nfsi->open_files, list)
+			atomic_inc(&ctx->cache_misses);
+		rcu_read_unlock();
 	}
 }
 
+static void nfs_lookup_advise_force_readdirplus(struct inode *dir)
+{
+	nfs_readdir_record_entry_cache_miss(dir);
+}
+
 static
 void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 		unsigned long dir_verifier)
@@ -1101,6 +1109,20 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 	return status;
 }
 
+#define NFS_READDIR_CACHE_MISS_THRESHOLD (16UL)
+
+static void nfs_readdir_handle_cache_misses(struct inode *inode,
+					    struct nfs_readdir_descriptor *desc,
+					    pgoff_t page_index,
+					    unsigned int cache_misses)
+{
+	if (desc->ctx->pos == 0 ||
+	    cache_misses <= NFS_READDIR_CACHE_MISS_THRESHOLD ||
+	    !nfs_readdir_may_fill_pagecache(desc))
+		return;
+	invalidate_mapping_pages(inode->i_mapping, page_index + 1, -1);
+}
+
 /* The file offset position represents the dirent entry number.  A
    last cookie cache takes care of the common case of reading the
    whole directory.
@@ -1112,6 +1134,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_open_dir_context *dir_ctx = file->private_data;
 	struct nfs_readdir_descriptor *desc;
+	unsigned int cache_hits, cache_misses;
 	pgoff_t page_index;
 	int res;
 
@@ -1137,7 +1160,6 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 		goto out;
 	desc->file = file;
 	desc->ctx = ctx;
-	desc->plus = nfs_use_readdirplus(inode, ctx);
 	desc->page_index_max = -1;
 
 	spin_lock(&file->f_lock);
@@ -1150,6 +1172,8 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	desc->page_fill_misses = dir_ctx->page_fill_misses;
 	nfs_set_dtsize(desc, dir_ctx->dtsize);
 	memcpy(desc->verf, dir_ctx->verf, sizeof(desc->verf));
+	cache_hits = atomic_xchg(&dir_ctx->cache_hits, 0);
+	cache_misses = atomic_xchg(&dir_ctx->cache_misses, 0);
 	spin_unlock(&file->f_lock);
 
 	if (desc->eof) {
@@ -1157,9 +1181,8 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 		goto out_free;
 	}
 
-	if (test_and_clear_bit(NFS_INO_FORCE_READDIR, &nfsi->flags) &&
-	    list_is_singular(&nfsi->open_files))
-		invalidate_mapping_pages(inode->i_mapping, page_index + 1, -1);
+	desc->plus = nfs_use_readdirplus(inode, ctx, cache_hits, cache_misses);
+	nfs_readdir_handle_cache_misses(inode, desc, page_index, cache_misses);
 
 	do {
 		res = readdir_search_pagecache(desc);
@@ -1178,7 +1201,6 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 			break;
 		}
 		if (res == -ETOOSMALL && desc->plus) {
-			clear_bit(NFS_INO_ADVISE_RDPLUS, &nfsi->flags);
 			nfs_zap_caches(inode);
 			desc->page_index = 0;
 			desc->plus = false;
@@ -1597,7 +1619,7 @@ nfs_lookup_revalidate_dentry(struct inode *dir, struct dentry *dentry,
 	nfs_set_verifier(dentry, dir_verifier);
 
 	/* set a readdirplus hint that we had a cache miss */
-	nfs_force_use_readdirplus(dir);
+	nfs_lookup_advise_force_readdirplus(dir);
 	ret = 1;
 out:
 	nfs_free_fattr(fattr);
@@ -1654,7 +1676,6 @@ nfs_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 				nfs_mark_dir_for_revalidate(dir);
 			goto out_bad;
 		}
-		nfs_advise_use_readdirplus(dir);
 		goto out_valid;
 	}
 
@@ -1859,7 +1880,7 @@ struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, unsigned in
 		goto out;
 
 	/* Notify readdir to use READDIRPLUS */
-	nfs_force_use_readdirplus(dir);
+	nfs_lookup_advise_force_readdirplus(dir);
 
 no_entry:
 	res = d_splice_alias(inode, dentry);
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index f9fc506ebb29..1bef81f5373a 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -789,7 +789,7 @@ static void nfs_readdirplus_parent_cache_miss(struct dentry *dentry)
 	if (!nfs_server_capable(d_inode(dentry), NFS_CAP_READDIRPLUS))
 		return;
 	parent = dget_parent(dentry);
-	nfs_force_use_readdirplus(d_inode(parent));
+	nfs_readdir_record_entry_cache_miss(d_inode(parent));
 	dput(parent);
 }
 
@@ -800,7 +800,7 @@ static void nfs_readdirplus_parent_cache_hit(struct dentry *dentry)
 	if (!nfs_server_capable(d_inode(dentry), NFS_CAP_READDIRPLUS))
 		return;
 	parent = dget_parent(dentry);
-	nfs_advise_use_readdirplus(d_inode(parent));
+	nfs_readdir_record_entry_cache_hit(d_inode(parent));
 	dput(parent);
 }
 
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 2de7c56a1fbe..46dc97b65661 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -366,8 +366,8 @@ extern struct nfs_client *nfs_init_client(struct nfs_client *clp,
 			   const struct nfs_client_initdata *);
 
 /* dir.c */
-extern void nfs_advise_use_readdirplus(struct inode *dir);
-extern void nfs_force_use_readdirplus(struct inode *dir);
+extern void nfs_readdir_record_entry_cache_hit(struct inode *dir);
+extern void nfs_readdir_record_entry_cache_miss(struct inode *dir);
 extern unsigned long nfs_access_cache_count(struct shrinker *shrink,
 					    struct shrink_control *sc);
 extern unsigned long nfs_access_cache_scan(struct shrinker *shrink,
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 45a310b586ce..3672f6703ee7 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -36,7 +36,6 @@
 
 #define nfs_show_nfsi_flags(v) \
 	__print_flags(v, "|", \
-			{ BIT(NFS_INO_ADVISE_RDPLUS), "ADVISE_RDPLUS" }, \
 			{ BIT(NFS_INO_STALE), "STALE" }, \
 			{ BIT(NFS_INO_ACL_LRU_SET), "ACL_LRU_SET" }, \
 			{ BIT(NFS_INO_INVALIDATING), "INVALIDATING" }, \
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 3165927048e4..0a5425a58bbd 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -101,6 +101,8 @@ struct nfs_open_context {
 
 struct nfs_open_dir_context {
 	struct list_head list;
+	atomic_t cache_hits;
+	atomic_t cache_misses;
 	unsigned long attr_gencount;
 	__be32	verf[NFS_DIR_VERIFIER_SIZE];
 	__u64 dir_cookie;
@@ -110,6 +112,7 @@ struct nfs_open_dir_context {
 	unsigned int dtsize;
 	signed char duped;
 	bool eof;
+	struct rcu_head rcu_head;
 };
 
 /*
@@ -274,13 +277,11 @@ struct nfs4_copy_state {
 /*
  * Bit offsets in flags field
  */
-#define NFS_INO_ADVISE_RDPLUS	(0)		/* advise readdirplus */
 #define NFS_INO_STALE		(1)		/* possible stale inode */
 #define NFS_INO_ACL_LRU_SET	(2)		/* Inode is on the LRU list */
 #define NFS_INO_INVALIDATING	(3)		/* inode is being invalidated */
 #define NFS_INO_PRESERVE_UNLINKED (4)		/* preserve file if removed while open */
 #define NFS_INO_FSCACHE		(5)		/* inode can be cached by FS-Cache */
-#define NFS_INO_FORCE_READDIR	(7)		/* force readdirplus */
 #define NFS_INO_LAYOUTCOMMIT	(9)		/* layoutcommit required */
 #define NFS_INO_LAYOUTCOMMITTING (10)		/* layoutcommit inflight */
 #define NFS_INO_LAYOUTSTATS	(11)		/* layoutstats inflight */
-- 
2.35.1

