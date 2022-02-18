Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824844BC211
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Feb 2022 22:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239891AbiBRVbM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Feb 2022 16:31:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239869AbiBRVbL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Feb 2022 16:31:11 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D74377C0
        for <linux-nfs@vger.kernel.org>; Fri, 18 Feb 2022 13:30:54 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id p7so17245092qvk.11
        for <linux-nfs@vger.kernel.org>; Fri, 18 Feb 2022 13:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hexoUNGBl+D9siZmjR6DxlCYmvSY1q6HeckNUc7Ha8g=;
        b=apCMrApeTpAxNPI6wo9bwaQna0TsdwIb2lDRVqAuXKIuz925BffMy260yTTVircE3M
         DE267tAIODLNXCF/qhwCm8Vj+J1pRMmyRHThnKWJeDdWNVnr8QbKMBZwagz6LImQnL6h
         Txzv/jUOKKc7EoKmJMcPj974D6mTZRcHDYZaS1wZRulSlCQZElTzlt9KgPoqHFzzn3D4
         9sKT7fZV/C0H6W18tAUnjxQrnolxakIyM3qQ6zw3NI5vI8gxMaI97R5bDEKSQLhrBJtF
         3XSsFHhHmVTO8Gpr865byNcKTh2oXu4r/jCpptX0v61XsdJ3yQyHDxcFDkY4rK5U6gMh
         Mjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hexoUNGBl+D9siZmjR6DxlCYmvSY1q6HeckNUc7Ha8g=;
        b=cgYm092kumNXZYc+goEwOMrAkZ05dQvQAG5yCI2kuXlF7v4O+aDDOrpgpGZKQaOeNd
         I+cFJDM5AuLQgtQL/R4QyLQXMEGYsg07QFBCypdoZdZmOeLK4X6m2K0NbC3+s6oAAOMy
         POHB4KC+2haWjRbsAsAlrAn1fStq+q1k3AhMFIptCvEvHnvGlvP3GeO5HCCk8lKJy2/f
         ZxGKXNNwf5Hy/hAcThZ4++gkdQp6gSL6kfxj367f+yYlGp60iQX/J4k+Nx3kOiLvKVIM
         mGS23TK/MN/3xK8VSzl5+TJpeQeVvTwAfzTOXZcCf0hvzeXp/f9GRwXHFBu0l+aiCSeb
         VJ3A==
X-Gm-Message-State: AOAM531kgJDtLJVhMwjQN8h9CYywlxxGrxLDd53SrAWyva7+d4Be335H
        AKEhOemGWmTGiD/XvU4k1wyFw79NwA==
X-Google-Smtp-Source: ABdhPJzqkmfS7MNuyVc3NZFC0IAUp1DTdoY/uylBxXRzdYihuh03PEMHuj7GggqtbpnhtTw/t2KDeA==
X-Received: by 2002:ac8:7c4b:0:b0:2dc:a139:52c7 with SMTP id o11-20020ac87c4b000000b002dca13952c7mr8596811qtv.188.1645219852403;
        Fri, 18 Feb 2022 13:30:52 -0800 (PST)
Received: from localhost.localdomain (c-68-56-145-227.hsd1.mi.comcast.net. [68.56.145.227])
        by smtp.gmail.com with ESMTPSA id w22sm26928656qtk.7.2022.02.18.13.30.51
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 13:30:51 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 4/6] NFS: Improve heuristic for readdirplus
Date:   Fri, 18 Feb 2022 16:24:22 -0500
Message-Id: <20220218212424.1840077-5-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218212424.1840077-4-trond.myklebust@hammerspace.com>
References: <20220218212424.1840077-1-trond.myklebust@hammerspace.com>
 <20220218212424.1840077-2-trond.myklebust@hammerspace.com>
 <20220218212424.1840077-3-trond.myklebust@hammerspace.com>
 <20220218212424.1840077-4-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 fs/nfs/dir.c           | 81 ++++++++++++++++++++++++++----------------
 fs/nfs/inode.c         |  4 +--
 fs/nfs/internal.h      |  4 +--
 fs/nfs/nfstrace.h      |  1 -
 include/linux/nfs_fs.h |  5 +--
 5 files changed, 57 insertions(+), 38 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 43a559b34f4a..ba4e94b2a007 100644
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
 
+static void nfs_readdir_record_dcache_miss(struct inode *dir)
+{
+	nfs_readdir_record_entry_cache_miss(dir);
+}
+
 static
 void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 		unsigned long dir_verifier)
@@ -1101,6 +1109,18 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 	return status;
 }
 
+#define NFS_READDIR_CACHE_MISS_THRESHOLD (16UL)
+
+static void nfs_readdir_handle_cache_misses(struct inode *inode,
+					    struct nfs_readdir_descriptor *desc,
+					    pgoff_t page_index,
+					    unsigned int cache_misses)
+{
+	if (desc->ctx->pos != 0 &&
+	    cache_misses > NFS_READDIR_CACHE_MISS_THRESHOLD)
+		invalidate_mapping_pages(inode->i_mapping, page_index + 1, -1);
+}
+
 /* The file offset position represents the dirent entry number.  A
    last cookie cache takes care of the common case of reading the
    whole directory.
@@ -1112,6 +1132,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_open_dir_context *dir_ctx = file->private_data;
 	struct nfs_readdir_descriptor *desc;
+	unsigned int cache_hits, cache_misses;
 	pgoff_t page_index;
 	int res;
 
@@ -1137,7 +1158,6 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 		goto out;
 	desc->file = file;
 	desc->ctx = ctx;
-	desc->plus = nfs_use_readdirplus(inode, ctx);
 	desc->page_index_max = -1;
 
 	spin_lock(&file->f_lock);
@@ -1150,6 +1170,8 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	desc->page_fill_misses = dir_ctx->page_fill_misses;
 	nfs_set_dtsize(desc, dir_ctx->dtsize);
 	memcpy(desc->verf, dir_ctx->verf, sizeof(desc->verf));
+	cache_hits = atomic_xchg(&dir_ctx->cache_hits, 0);
+	cache_misses = atomic_xchg(&dir_ctx->cache_misses, 0);
 	spin_unlock(&file->f_lock);
 
 	if (desc->eof) {
@@ -1157,9 +1179,8 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 		goto out_free;
 	}
 
-	if (test_and_clear_bit(NFS_INO_FORCE_READDIR, &nfsi->flags) &&
-	    list_is_singular(&nfsi->open_files))
-		invalidate_mapping_pages(inode->i_mapping, page_index + 1, -1);
+	desc->plus = nfs_use_readdirplus(inode, ctx, cache_hits, cache_misses);
+	nfs_readdir_handle_cache_misses(inode, desc, page_index, cache_misses);
 
 	do {
 		res = readdir_search_pagecache(desc);
@@ -1178,7 +1199,6 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 			break;
 		}
 		if (res == -ETOOSMALL && desc->plus) {
-			clear_bit(NFS_INO_ADVISE_RDPLUS, &nfsi->flags);
 			nfs_zap_caches(inode);
 			desc->page_index = 0;
 			desc->plus = false;
@@ -1602,7 +1622,7 @@ nfs_lookup_revalidate_dentry(struct inode *dir, struct dentry *dentry,
 	nfs_set_verifier(dentry, dir_verifier);
 
 	/* set a readdirplus hint that we had a cache miss */
-	nfs_force_use_readdirplus(dir);
+	nfs_readdir_record_dcache_miss(dir);
 	ret = 1;
 out:
 	nfs_free_fattr(fattr);
@@ -1659,7 +1679,6 @@ nfs_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 				nfs_mark_dir_for_revalidate(dir);
 			goto out_bad;
 		}
-		nfs_advise_use_readdirplus(dir);
 		goto out_valid;
 	}
 
@@ -1866,7 +1885,7 @@ struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, unsigned in
 		goto out;
 
 	/* Notify readdir to use READDIRPLUS */
-	nfs_force_use_readdirplus(dir);
+	nfs_readdir_record_dcache_miss(dir);
 
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

