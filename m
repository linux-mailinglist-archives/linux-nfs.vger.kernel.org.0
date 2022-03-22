Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A474E3639
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Mar 2022 02:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbiCVB4G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Mar 2022 21:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbiCVB4E (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Mar 2022 21:56:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A6612AE3
        for <linux-nfs@vger.kernel.org>; Mon, 21 Mar 2022 18:54:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C13360B09
        for <linux-nfs@vger.kernel.org>; Tue, 22 Mar 2022 01:54:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80805C340EE;
        Tue, 22 Mar 2022 01:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647914075;
        bh=hQqYU8IsqDxmW6S3nbP0jML+3PV2udg3I0lI/1Lhslo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bAIAa+dNk1k1UKmdeQ6D2GN6ZGtAQsatfqSmV8/10qBx0rHlS5Q/6vTREiFp059yr
         razvdnQZEXe4NvXUwZ0DrGzKX2SsJGYFgr3G7OGTqzYWJDsR/kaFXr5ZWC0MesghPI
         NF3ki6wcX66lDJTNGHCf4DUu3+dMF0HGOdI7TVIfv8El2pqLjYdqx5VkBtfzcCrUT/
         O5hWjybdZzK/e5WZardrKcl+WlmdXvT1ZsT5U0n3jr5z+BqB8Rw7sedwT9yuhYV8Py
         U0uEOHCWNMciQnIg7zPgQMGOepaHAYjYa6b3aC7IBKF+UySpPWj8oRgckb58VBhQM7
         PjOMLJjyOqyZg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Subject: [PATCH v2 5/9] NFS: nfsiod should not block forever in mempool_alloc()
Date:   Mon, 21 Mar 2022 21:47:42 -0400
Message-Id: <20220322014746.1052984-6-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322014746.1052984-5-trondmy@kernel.org>
References: <20220322014746.1052984-1-trondmy@kernel.org>
 <20220322014746.1052984-2-trondmy@kernel.org>
 <20220322014746.1052984-3-trondmy@kernel.org>
 <20220322014746.1052984-4-trondmy@kernel.org>
 <20220322014746.1052984-5-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The concern is that since nfsiod is sometimes required to kick off a
commit, it can get locked up waiting forever in mempool_alloc() instead
of failing gracefully and leaving the commit until later.

Try to allocate from the slab first, with GFP_KERNEL | __GFP_NORETRY,
then fall back to a non-blocking attempt to allocate from the memory
pool.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/internal.h      |  7 +++++++
 fs/nfs/pnfs_nfs.c      |  8 ++++++--
 fs/nfs/write.c         | 24 +++++++++---------------
 include/linux/nfs_fs.h |  2 +-
 4 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 194840a97e3a..57b0497105c8 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -587,6 +587,13 @@ nfs_write_match_verf(const struct nfs_writeverf *verf,
 		!nfs_write_verifier_cmp(&req->wb_verf, &verf->verifier);
 }
 
+static inline gfp_t nfs_io_gfp_mask(void)
+{
+	if (current->flags & PF_WQ_WORKER)
+		return GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
+	return GFP_KERNEL;
+}
+
 /* unlink.c */
 extern struct rpc_task *
 nfs_async_rename(struct inode *old_dir, struct inode *new_dir,
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 316f68f96e57..657c242a18ff 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -419,7 +419,7 @@ static struct nfs_commit_data *
 pnfs_bucket_fetch_commitdata(struct pnfs_commit_bucket *bucket,
 			     struct nfs_commit_info *cinfo)
 {
-	struct nfs_commit_data *data = nfs_commitdata_alloc(false);
+	struct nfs_commit_data *data = nfs_commitdata_alloc();
 
 	if (!data)
 		return NULL;
@@ -515,7 +515,11 @@ pnfs_generic_commit_pagelist(struct inode *inode, struct list_head *mds_pages,
 	unsigned int nreq = 0;
 
 	if (!list_empty(mds_pages)) {
-		data = nfs_commitdata_alloc(true);
+		data = nfs_commitdata_alloc();
+		if (!data) {
+			nfs_retry_commit(mds_pages, NULL, cinfo, -1);
+			return -ENOMEM;
+		}
 		data->ds_commit_index = -1;
 		list_splice_init(mds_pages, &data->pages);
 		list_add_tail(&data->list, &list);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 599a82406d38..ef47e3700e4b 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -70,27 +70,17 @@ static mempool_t *nfs_wdata_mempool;
 static struct kmem_cache *nfs_cdata_cachep;
 static mempool_t *nfs_commit_mempool;
 
-struct nfs_commit_data *nfs_commitdata_alloc(bool never_fail)
+struct nfs_commit_data *nfs_commitdata_alloc(void)
 {
 	struct nfs_commit_data *p;
 
-	if (never_fail)
-		p = mempool_alloc(nfs_commit_mempool, GFP_NOIO);
-	else {
-		/* It is OK to do some reclaim, not no safe to wait
-		 * for anything to be returned to the pool.
-		 * mempool_alloc() cannot handle that particular combination,
-		 * so we need two separate attempts.
-		 */
+	p = kmem_cache_zalloc(nfs_cdata_cachep, nfs_io_gfp_mask());
+	if (!p) {
 		p = mempool_alloc(nfs_commit_mempool, GFP_NOWAIT);
-		if (!p)
-			p = kmem_cache_alloc(nfs_cdata_cachep, GFP_NOIO |
-					     __GFP_NOWARN | __GFP_NORETRY);
 		if (!p)
 			return NULL;
+		memset(p, 0, sizeof(*p));
 	}
-
-	memset(p, 0, sizeof(*p));
 	INIT_LIST_HEAD(&p->pages);
 	return p;
 }
@@ -1826,7 +1816,11 @@ nfs_commit_list(struct inode *inode, struct list_head *head, int how,
 	if (list_empty(head))
 		return 0;
 
-	data = nfs_commitdata_alloc(true);
+	data = nfs_commitdata_alloc();
+	if (!data) {
+		nfs_retry_commit(head, NULL, cinfo, -1);
+		return -ENOMEM;
+	}
 
 	/* Set up the argument struct */
 	nfs_init_commit(data, head, NULL, cinfo);
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index c47c448befc8..db305abafc9e 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -580,7 +580,7 @@ extern int nfs_wb_all(struct inode *inode);
 extern int nfs_wb_page(struct inode *inode, struct page *page);
 extern int nfs_wb_page_cancel(struct inode *inode, struct page* page);
 extern int  nfs_commit_inode(struct inode *, int);
-extern struct nfs_commit_data *nfs_commitdata_alloc(bool never_fail);
+extern struct nfs_commit_data *nfs_commitdata_alloc(void);
 extern void nfs_commit_free(struct nfs_commit_data *data);
 bool nfs_commit_end(struct nfs_mds_commit_info *cinfo);
 
-- 
2.35.1

