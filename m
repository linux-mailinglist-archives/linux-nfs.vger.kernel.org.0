Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CDF4C5FD5
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 00:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiB0XTU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 27 Feb 2022 18:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbiB0XTR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 27 Feb 2022 18:19:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0C622505
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 15:18:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F847611CE
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56201C340EE
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646003919;
        bh=T7T3qAHYBC6n6IcP10OUbGuBwSPsDbcQkjL8l9MRltk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=abwy6UsDcFXy2lkt/QKKZsyvG0MIsUNjHxGLAponrvja5jEC1gpCPm9XBl+ex0aL/
         qJvlJ3jzrdpG1f1XnBw32OcaPE9udD0ZoiVYORLrX0hIHV8Otox+6RAdDfjFZ1kT9/
         ozO0Jnk+21C27ANSqreE00HY8vWVGFL+gLcLFdMElBDVAz7d8kh9TE78yHMX8ua05A
         YmR1p8DBlmY4wBDFKARLiNqspIIIdWM/JlXP/UmUeHEqQmd1VUhFbTrc1rAGSk6MMx
         2DmqVM23pZULgDWm8oNG/eagpbyuEo9Ps5OOkv1seoudqgyGDl7xtKvpeefXjmBMRi
         kPZAlvIY9ypPw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 14/27] NFS: Improve heuristic for readdirplus
Date:   Sun, 27 Feb 2022 18:12:14 -0500
Message-Id: <20220227231227.9038-15-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227231227.9038-14-trondmy@kernel.org>
References: <20220227231227.9038-1-trondmy@kernel.org>
 <20220227231227.9038-2-trondmy@kernel.org>
 <20220227231227.9038-3-trondmy@kernel.org>
 <20220227231227.9038-4-trondmy@kernel.org>
 <20220227231227.9038-5-trondmy@kernel.org>
 <20220227231227.9038-6-trondmy@kernel.org>
 <20220227231227.9038-7-trondmy@kernel.org>
 <20220227231227.9038-8-trondmy@kernel.org>
 <20220227231227.9038-9-trondmy@kernel.org>
 <20220227231227.9038-10-trondmy@kernel.org>
 <20220227231227.9038-11-trondmy@kernel.org>
 <20220227231227.9038-12-trondmy@kernel.org>
 <20220227231227.9038-13-trondmy@kernel.org>
 <20220227231227.9038-14-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 fs/nfs/dir.c           | 82 ++++++++++++++++++++++++++----------------
 fs/nfs/inode.c         |  4 +--
 fs/nfs/internal.h      |  4 +--
 fs/nfs/nfstrace.h      |  1 -
 include/linux/nfs_fs.h |  5 +--
 5 files changed, 58 insertions(+), 38 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 0b7d4be38452..c5c7175a257c 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -87,8 +87,7 @@ alloc_nfs_open_dir_context(struct inode *dir)
 			nfs_set_cache_invalid(dir,
 					      NFS_INO_INVALID_DATA |
 						      NFS_INO_REVAL_FORCED);
-		list_add(&ctx->list, &nfsi->open_files);
-		clear_bit(NFS_INO_FORCE_READDIR, &nfsi->flags);
+		list_add_tail_rcu(&ctx->list, &nfsi->open_files);
 		memcpy(ctx->verf, nfsi->cookieverf, sizeof(ctx->verf));
 		spin_unlock(&dir->i_lock);
 		return ctx;
@@ -99,9 +98,9 @@ alloc_nfs_open_dir_context(struct inode *dir)
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
@@ -594,7 +593,6 @@ static int nfs_readdir_xdr_filler(struct nfs_readdir_descriptor *desc,
 		/* We requested READDIRPLUS, but the server doesn't grok it */
 		if (error == -ENOTSUPP && desc->plus) {
 			NFS_SERVER(inode)->caps &= ~NFS_CAP_READDIRPLUS;
-			clear_bit(NFS_INO_ADVISE_RDPLUS, &NFS_I(inode)->flags);
 			desc->plus = arg.plus = false;
 			goto again;
 		}
@@ -644,51 +642,61 @@ int nfs_same_file(struct dentry *dentry, struct nfs_entry *entry)
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
@@ -1122,6 +1130,19 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
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
+	    cache_misses <= NFS_READDIR_CACHE_MISS_THRESHOLD)
+		return;
+	invalidate_mapping_pages(inode->i_mapping, page_index + 1, -1);
+}
+
 /* The file offset position represents the dirent entry number.  A
    last cookie cache takes care of the common case of reading the
    whole directory.
@@ -1133,6 +1154,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_open_dir_context *dir_ctx = file->private_data;
 	struct nfs_readdir_descriptor *desc;
+	unsigned int cache_hits, cache_misses;
 	pgoff_t page_index;
 	int res;
 
@@ -1154,7 +1176,6 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 		goto out;
 	desc->file = file;
 	desc->ctx = ctx;
-	desc->plus = nfs_use_readdirplus(inode, ctx);
 	desc->page_index_max = -1;
 
 	spin_lock(&file->f_lock);
@@ -1168,6 +1189,8 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	desc->eof = dir_ctx->eof;
 	nfs_set_dtsize(desc, dir_ctx->dtsize);
 	memcpy(desc->verf, dir_ctx->verf, sizeof(desc->verf));
+	cache_hits = atomic_xchg(&dir_ctx->cache_hits, 0);
+	cache_misses = atomic_xchg(&dir_ctx->cache_misses, 0);
 	spin_unlock(&file->f_lock);
 
 	if (desc->eof) {
@@ -1175,9 +1198,8 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 		goto out_free;
 	}
 
-	if (test_and_clear_bit(NFS_INO_FORCE_READDIR, &nfsi->flags) &&
-	    list_is_singular(&nfsi->open_files))
-		invalidate_mapping_pages(inode->i_mapping, page_index + 1, -1);
+	desc->plus = nfs_use_readdirplus(inode, ctx, cache_hits, cache_misses);
+	nfs_readdir_handle_cache_misses(inode, desc, page_index, cache_misses);
 
 	do {
 		res = readdir_search_pagecache(desc);
@@ -1196,7 +1218,6 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 			break;
 		}
 		if (res == -ETOOSMALL && desc->plus) {
-			clear_bit(NFS_INO_ADVISE_RDPLUS, &nfsi->flags);
 			nfs_zap_caches(inode);
 			desc->page_index = 0;
 			desc->plus = false;
@@ -1610,7 +1631,7 @@ nfs_lookup_revalidate_dentry(struct inode *dir, struct dentry *dentry,
 	nfs_set_verifier(dentry, dir_verifier);
 
 	/* set a readdirplus hint that we had a cache miss */
-	nfs_force_use_readdirplus(dir);
+	nfs_lookup_advise_force_readdirplus(dir);
 	ret = 1;
 out:
 	nfs_free_fattr(fattr);
@@ -1667,7 +1688,6 @@ nfs_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 				nfs_mark_dir_for_revalidate(dir);
 			goto out_bad;
 		}
-		nfs_advise_use_readdirplus(dir);
 		goto out_valid;
 	}
 
@@ -1872,7 +1892,7 @@ struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, unsigned in
 		goto out;
 
 	/* Notify readdir to use READDIRPLUS */
-	nfs_force_use_readdirplus(dir);
+	nfs_lookup_advise_force_readdirplus(dir);
 
 no_entry:
 	res = d_splice_alias(inode, dentry);
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 7cecabf57b95..bbf4357ff727 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -787,7 +787,7 @@ static void nfs_readdirplus_parent_cache_miss(struct dentry *dentry)
 	if (!nfs_server_capable(d_inode(dentry), NFS_CAP_READDIRPLUS))
 		return;
 	parent = dget_parent(dentry);
-	nfs_force_use_readdirplus(d_inode(parent));
+	nfs_readdir_record_entry_cache_miss(d_inode(parent));
 	dput(parent);
 }
 
@@ -798,7 +798,7 @@ static void nfs_readdirplus_parent_cache_hit(struct dentry *dentry)
 	if (!nfs_server_capable(d_inode(dentry), NFS_CAP_READDIRPLUS))
 		return;
 	parent = dget_parent(dentry);
-	nfs_advise_use_readdirplus(d_inode(parent));
+	nfs_readdir_record_entry_cache_hit(d_inode(parent));
 	dput(parent);
 }
 
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index b5398af53c7f..194840a97e3a 100644
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
index 691a27936849..20a4cf0acad2 100644
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

