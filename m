Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B78A674576
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jan 2023 23:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjASWDY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Jan 2023 17:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjASWCt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Jan 2023 17:02:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A446C41F8
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 13:40:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC20C61D8E
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 21:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF50CC433D2;
        Thu, 19 Jan 2023 21:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674164423;
        bh=5GfTuHolay7gFMyyIqjLDtin4lYga/Z8+eyx0gznWvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iV4sigp46IBmCkAVg3OWymh2s7QT2nt0jyp4zmBzIFq1WMZPwpBJYGRp4s1BvvwW7
         IaLZgXN226P/fwRiJbv5TYCcDb3aQZXz2g7zFyCT/hlhx/4URF/Zs0ZP+XPhWZ5wmZ
         Hh/QJwA4f7YrappAfDldOuYAvSA+6sVaZ7XMmw9F35b1b+G6jjva7SeP/rqcqnkvVT
         WLfJrQb9NbDr288DJNu0fvrFUoEsx9Z60Xh2nP708NOVXCrRz1g0+EEK+ZWNBLRdhm
         GTmjkUml2qRtlOl9/v65BIctjX/78ENXuTUoqN701370Jb5nA+xKon9IUEmW7seOTb
         jnBIuOhBei1dA==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 10/18] NFS: Convert buffered writes to use folios
Date:   Thu, 19 Jan 2023 16:33:43 -0500
Message-Id: <20230119213351.443388-11-trondmy@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119213351.443388-10-trondmy@kernel.org>
References: <20230119213351.443388-1-trondmy@kernel.org>
 <20230119213351.443388-2-trondmy@kernel.org>
 <20230119213351.443388-3-trondmy@kernel.org>
 <20230119213351.443388-4-trondmy@kernel.org>
 <20230119213351.443388-5-trondmy@kernel.org>
 <20230119213351.443388-6-trondmy@kernel.org>
 <20230119213351.443388-7-trondmy@kernel.org>
 <20230119213351.443388-8-trondmy@kernel.org>
 <20230119213351.443388-9-trondmy@kernel.org>
 <20230119213351.443388-10-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Mostly mechanical conversion of struct page and functions into struct
folio equivalents.
The lack of support for folios in write_cache_pages(), means we still
only support order 0 folio allocations. However the rest of the
writeback code should now be ready for order n > 0.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/file.c          |  14 +-
 fs/nfs/internal.h      |  13 +-
 fs/nfs/pnfs.h          |  10 +-
 fs/nfs/pnfs_nfs.c      |  18 +--
 fs/nfs/write.c         | 350 +++++++++++++++++++++--------------------
 include/linux/nfs_fs.h |   5 +-
 6 files changed, 210 insertions(+), 200 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 8704bd071d3a..9fbe27214da0 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -319,6 +319,7 @@ static int nfs_write_begin(struct file *file, struct address_space *mapping,
 	int ret;
 	pgoff_t index = pos >> PAGE_SHIFT;
 	struct page *page;
+	struct folio *folio;
 	int once_thru = 0;
 
 	dfprintk(PAGECACHE, "NFS: write_begin(%pD2(%lu), %u@%lld)\n",
@@ -329,15 +330,16 @@ static int nfs_write_begin(struct file *file, struct address_space *mapping,
 	if (!page)
 		return -ENOMEM;
 	*pagep = page;
+	folio = page_folio(page);
 
-	ret = nfs_flush_incompatible(file, page);
+	ret = nfs_flush_incompatible(file, folio);
 	if (ret) {
 		unlock_page(page);
 		put_page(page);
 	} else if (!once_thru &&
 		   nfs_want_read_modify_write(file, page, pos, len)) {
 		once_thru = 1;
-		ret = nfs_read_folio(file, page_folio(page));
+		ret = nfs_read_folio(file, folio);
 		put_page(page);
 		if (!ret)
 			goto start;
@@ -351,6 +353,7 @@ static int nfs_write_end(struct file *file, struct address_space *mapping,
 {
 	unsigned offset = pos & (PAGE_SIZE - 1);
 	struct nfs_open_context *ctx = nfs_file_open_context(file);
+	struct folio *folio = page_folio(page);
 	int status;
 
 	dfprintk(PAGECACHE, "NFS: write_end(%pD2(%lu), %u@%lld)\n",
@@ -376,7 +379,7 @@ static int nfs_write_end(struct file *file, struct address_space *mapping,
 			zero_user_segment(page, pglen, PAGE_SIZE);
 	}
 
-	status = nfs_updatepage(file, page, offset, copied);
+	status = nfs_update_folio(file, folio, offset, copied);
 
 	unlock_page(page);
 	put_page(page);
@@ -552,6 +555,7 @@ static vm_fault_t nfs_vm_page_mkwrite(struct vm_fault *vmf)
 	unsigned pagelen;
 	vm_fault_t ret = VM_FAULT_NOPAGE;
 	struct address_space *mapping;
+	struct folio *folio = page_folio(page);
 
 	dfprintk(PAGECACHE, "NFS: vm_page_mkwrite(%pD2(%lu), offset %lld)\n",
 		filp, filp->f_mapping->host->i_ino,
@@ -582,8 +586,8 @@ static vm_fault_t nfs_vm_page_mkwrite(struct vm_fault *vmf)
 		goto out_unlock;
 
 	ret = VM_FAULT_LOCKED;
-	if (nfs_flush_incompatible(filp, page) == 0 &&
-	    nfs_updatepage(filp, page, 0, pagelen) == 0)
+	if (nfs_flush_incompatible(filp, folio) == 0 &&
+	    nfs_update_folio(filp, folio, 0, pagelen) == 0)
 		goto out;
 
 	ret = VM_FAULT_SIGBUS;
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 529b87336ffa..239ae5084774 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -760,17 +760,18 @@ void nfs_super_set_maxbytes(struct super_block *sb, __u64 maxfilesize)
  * Record the page as unstable (an extra writeback period) and mark its
  * inode as dirty.
  */
-static inline
-void nfs_mark_page_unstable(struct page *page, struct nfs_commit_info *cinfo)
+static inline void nfs_folio_mark_unstable(struct folio *folio,
+					   struct nfs_commit_info *cinfo)
 {
-	if (!cinfo->dreq) {
-		struct inode *inode = page_file_mapping(page)->host;
+	if (folio && !cinfo->dreq) {
+		struct inode *inode = folio_file_mapping(folio)->host;
+		long nr = folio_nr_pages(folio);
 
 		/* This page is really still in write-back - just that the
 		 * writeback is happening on the server now.
 		 */
-		inc_node_page_state(page, NR_WRITEBACK);
-		inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
+		node_stat_mod_folio(folio, NR_WRITEBACK, nr);
+		wb_stat_mod(&inode_to_bdi(inode)->wb, WB_WRITEBACK, nr);
 		__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
 	}
 }
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index e3e6a41f19de..d886c8226d8f 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -193,7 +193,7 @@ struct pnfs_commit_ops {
 	void (*recover_commit_reqs) (struct list_head *list,
 				     struct nfs_commit_info *cinfo);
 	struct nfs_page * (*search_commit_reqs)(struct nfs_commit_info *cinfo,
-						struct page *page);
+						struct folio *folio);
 };
 
 struct pnfs_layout_hdr {
@@ -395,7 +395,7 @@ void pnfs_generic_rw_release(void *data);
 void pnfs_generic_recover_commit_reqs(struct list_head *dst,
 				      struct nfs_commit_info *cinfo);
 struct nfs_page *pnfs_generic_search_commit_reqs(struct nfs_commit_info *cinfo,
-						 struct page *page);
+						 struct folio *folio);
 int pnfs_generic_commit_pagelist(struct inode *inode,
 				 struct list_head *mds_pages,
 				 int how,
@@ -557,13 +557,13 @@ pnfs_recover_commit_reqs(struct list_head *head, struct nfs_commit_info *cinfo)
 
 static inline struct nfs_page *
 pnfs_search_commit_reqs(struct inode *inode, struct nfs_commit_info *cinfo,
-			struct page *page)
+			struct folio *folio)
 {
 	struct pnfs_ds_commit_info *fl_cinfo = cinfo->ds;
 
 	if (!fl_cinfo->ops || !fl_cinfo->ops->search_commit_reqs)
 		return NULL;
-	return fl_cinfo->ops->search_commit_reqs(cinfo, page);
+	return fl_cinfo->ops->search_commit_reqs(cinfo, folio);
 }
 
 /* Should the pNFS client commit and return the layout upon a setattr */
@@ -864,7 +864,7 @@ pnfs_recover_commit_reqs(struct list_head *head, struct nfs_commit_info *cinfo)
 
 static inline struct nfs_page *
 pnfs_search_commit_reqs(struct inode *inode, struct nfs_commit_info *cinfo,
-			struct page *page)
+			struct folio *folio)
 {
 	return NULL;
 }
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 5d035dd2d7bf..a0112ad4937a 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -353,7 +353,7 @@ EXPORT_SYMBOL_GPL(pnfs_generic_recover_commit_reqs);
 
 static struct nfs_page *
 pnfs_bucket_search_commit_reqs(struct pnfs_commit_bucket *buckets,
-		unsigned int nbuckets, struct page *page)
+			       unsigned int nbuckets, struct folio *folio)
 {
 	struct nfs_page *req;
 	struct pnfs_commit_bucket *b;
@@ -363,11 +363,11 @@ pnfs_bucket_search_commit_reqs(struct pnfs_commit_bucket *buckets,
 	 * request is found */
 	for (i = 0, b = buckets; i < nbuckets; i++, b++) {
 		list_for_each_entry(req, &b->written, wb_list) {
-			if (req->wb_page == page)
+			if (nfs_page_to_folio(req) == folio)
 				return req->wb_head;
 		}
 		list_for_each_entry(req, &b->committing, wb_list) {
-			if (req->wb_page == page)
+			if (nfs_page_to_folio(req) == folio)
 				return req->wb_head;
 		}
 	}
@@ -375,14 +375,14 @@ pnfs_bucket_search_commit_reqs(struct pnfs_commit_bucket *buckets,
 }
 
 /* pnfs_generic_search_commit_reqs - Search lists in @cinfo for the head request
- *				   for @page
+ *				   for @folio
  * @cinfo - commit info for current inode
- * @page - page to search for matching head request
+ * @folio - page to search for matching head request
  *
  * Return: the head request if one is found, otherwise %NULL.
  */
-struct nfs_page *
-pnfs_generic_search_commit_reqs(struct nfs_commit_info *cinfo, struct page *page)
+struct nfs_page *pnfs_generic_search_commit_reqs(struct nfs_commit_info *cinfo,
+						 struct folio *folio)
 {
 	struct pnfs_ds_commit_info *fl_cinfo = cinfo->ds;
 	struct pnfs_commit_array *array;
@@ -390,7 +390,7 @@ pnfs_generic_search_commit_reqs(struct nfs_commit_info *cinfo, struct page *page
 
 	list_for_each_entry(array, &fl_cinfo->commits, cinfo_list) {
 		req = pnfs_bucket_search_commit_reqs(array->buckets,
-				array->nbuckets, page);
+						     array->nbuckets, folio);
 		if (req)
 			return req;
 	}
@@ -1180,7 +1180,7 @@ pnfs_layout_mark_request_commit(struct nfs_page *req,
 
 	nfs_request_add_commit_list_locked(req, list, cinfo);
 	mutex_unlock(&NFS_I(cinfo->inode)->commit_mutex);
-	nfs_mark_page_unstable(req->wb_page, cinfo);
+	nfs_folio_mark_unstable(nfs_page_to_folio(req), cinfo);
 	return;
 out_resched:
 	mutex_unlock(&NFS_I(cinfo->inode)->commit_mutex);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 0d63f03436d3..442aee011871 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -63,7 +63,7 @@ static void nfs_init_cinfo_from_inode(struct nfs_commit_info *cinfo,
 				      struct inode *inode);
 static struct nfs_page *
 nfs_page_search_commits_for_head_request_locked(struct nfs_inode *nfsi,
-						struct page *page);
+						struct folio *folio);
 
 static struct kmem_cache *nfs_wdata_cachep;
 static mempool_t *nfs_wdata_mempool;
@@ -170,31 +170,28 @@ nfs_cancel_remove_inode(struct nfs_page *req, struct inode *inode)
 	return 0;
 }
 
-static struct nfs_page *
-nfs_page_private_request(struct page *page)
+static struct nfs_page *nfs_folio_private_request(struct folio *folio)
 {
-	if (!PagePrivate(page))
-		return NULL;
-	return (struct nfs_page *)page_private(page);
+	return folio_get_private(folio);
 }
 
-/*
- * nfs_page_find_head_request_locked - find head request associated with @page
+/**
+ * nfs_folio_find_private_request - find head request associated with a folio
+ * @folio: pointer to folio
  *
  * must be called while holding the inode lock.
  *
  * returns matching head request with reference held, or NULL if not found.
  */
-static struct nfs_page *
-nfs_page_find_private_request(struct page *page)
+static struct nfs_page *nfs_folio_find_private_request(struct folio *folio)
 {
-	struct address_space *mapping = page_file_mapping(page);
+	struct address_space *mapping = folio_file_mapping(folio);
 	struct nfs_page *req;
 
-	if (!PagePrivate(page))
+	if (!folio_test_private(folio))
 		return NULL;
 	spin_lock(&mapping->private_lock);
-	req = nfs_page_private_request(page);
+	req = nfs_folio_private_request(folio);
 	if (req) {
 		WARN_ON_ONCE(req->wb_head != req);
 		kref_get(&req->wb_kref);
@@ -203,18 +200,17 @@ nfs_page_find_private_request(struct page *page)
 	return req;
 }
 
-static struct nfs_page *
-nfs_page_find_swap_request(struct page *page)
+static struct nfs_page *nfs_folio_find_swap_request(struct folio *folio)
 {
-	struct inode *inode = page_file_mapping(page)->host;
+	struct inode *inode = folio_file_mapping(folio)->host;
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_page *req = NULL;
-	if (!PageSwapCache(page))
+	if (!folio_test_swapcache(folio))
 		return NULL;
 	mutex_lock(&nfsi->commit_mutex);
-	if (PageSwapCache(page)) {
+	if (folio_test_swapcache(folio)) {
 		req = nfs_page_search_commits_for_head_request_locked(nfsi,
-			page);
+								      folio);
 		if (req) {
 			WARN_ON_ONCE(req->wb_head != req);
 			kref_get(&req->wb_kref);
@@ -224,29 +220,30 @@ nfs_page_find_swap_request(struct page *page)
 	return req;
 }
 
-/*
- * nfs_page_find_head_request - find head request associated with @page
+/**
+ * nfs_folio_find_head_request - find head request associated with a folio
+ * @folio: pointer to folio
  *
  * returns matching head request with reference held, or NULL if not found.
  */
-static struct nfs_page *nfs_page_find_head_request(struct page *page)
+static struct nfs_page *nfs_folio_find_head_request(struct folio *folio)
 {
 	struct nfs_page *req;
 
-	req = nfs_page_find_private_request(page);
+	req = nfs_folio_find_private_request(folio);
 	if (!req)
-		req = nfs_page_find_swap_request(page);
+		req = nfs_folio_find_swap_request(folio);
 	return req;
 }
 
-static struct nfs_page *nfs_find_and_lock_page_request(struct page *page)
+static struct nfs_page *nfs_folio_find_and_lock_request(struct folio *folio)
 {
-	struct inode *inode = page_file_mapping(page)->host;
+	struct inode *inode = folio_file_mapping(folio)->host;
 	struct nfs_page *req, *head;
 	int ret;
 
 	for (;;) {
-		req = nfs_page_find_head_request(page);
+		req = nfs_folio_find_head_request(folio);
 		if (!req)
 			return req;
 		head = nfs_page_group_lock_head(req);
@@ -260,9 +257,9 @@ static struct nfs_page *nfs_find_and_lock_page_request(struct page *page)
 			return ERR_PTR(ret);
 		}
 		/* Ensure that nobody removed the request before we locked it */
-		if (head == nfs_page_private_request(page))
+		if (head == nfs_folio_private_request(folio))
 			break;
-		if (PageSwapCache(page))
+		if (folio_test_swapcache(folio))
 			break;
 		nfs_unlock_and_release_request(head);
 	}
@@ -270,18 +267,19 @@ static struct nfs_page *nfs_find_and_lock_page_request(struct page *page)
 }
 
 /* Adjust the file length if we're writing beyond the end */
-static void nfs_grow_file(struct page *page, unsigned int offset, unsigned int count)
+static void nfs_grow_file(struct folio *folio, unsigned int offset,
+			  unsigned int count)
 {
-	struct inode *inode = page_file_mapping(page)->host;
+	struct inode *inode = folio_file_mapping(folio)->host;
 	loff_t end, i_size;
 	pgoff_t end_index;
 
 	spin_lock(&inode->i_lock);
 	i_size = i_size_read(inode);
-	end_index = (i_size - 1) >> PAGE_SHIFT;
-	if (i_size > 0 && page_index(page) < end_index)
+	end_index = ((i_size - 1) >> folio_shift(folio)) << folio_order(folio);
+	if (i_size > 0 && folio_index(folio) < end_index)
 		goto out;
-	end = page_file_offset(page) + ((loff_t)offset+count);
+	end = folio_file_pos(folio) + (loff_t)offset + (loff_t)count;
 	if (i_size >= end)
 		goto out;
 	trace_nfs_size_grow(inode, end);
@@ -307,11 +305,11 @@ static void nfs_set_pageerror(struct address_space *mapping)
 	spin_unlock(&inode->i_lock);
 }
 
-static void nfs_mapping_set_error(struct page *page, int error)
+static void nfs_mapping_set_error(struct folio *folio, int error)
 {
-	struct address_space *mapping = page_file_mapping(page);
+	struct address_space *mapping = folio_file_mapping(folio);
 
-	SetPageError(page);
+	folio_set_error(folio);
 	filemap_set_wb_err(mapping, error);
 	if (mapping->host)
 		errseq_set(&mapping->host->i_sb->s_wb_err,
@@ -358,9 +356,9 @@ nfs_page_group_search_locked(struct nfs_page *head, unsigned int page_offset)
  */
 static bool nfs_page_group_covers_page(struct nfs_page *req)
 {
+	unsigned int len = nfs_folio_length(nfs_page_to_folio(req));
 	struct nfs_page *tmp;
 	unsigned int pos = 0;
-	unsigned int len = nfs_page_length(req->wb_page);
 
 	nfs_page_group_lock(req);
 
@@ -380,11 +378,13 @@ static bool nfs_page_group_covers_page(struct nfs_page *req)
  */
 static void nfs_mark_uptodate(struct nfs_page *req)
 {
-	if (PageUptodate(req->wb_page))
+	struct folio *folio = nfs_page_to_folio(req);
+
+	if (folio_test_uptodate(folio))
 		return;
 	if (!nfs_page_group_covers_page(req))
 		return;
-	SetPageUptodate(req->wb_page);
+	folio_mark_uptodate(folio);
 }
 
 static int wb_priority(struct writeback_control *wbc)
@@ -406,35 +406,34 @@ int nfs_congestion_kb;
 #define NFS_CONGESTION_OFF_THRESH	\
 	(NFS_CONGESTION_ON_THRESH - (NFS_CONGESTION_ON_THRESH >> 2))
 
-static void nfs_set_page_writeback(struct page *page)
+static void nfs_folio_set_writeback(struct folio *folio)
 {
-	struct inode *inode = page_file_mapping(page)->host;
-	struct nfs_server *nfss = NFS_SERVER(inode);
-	int ret = test_set_page_writeback(page);
-
-	WARN_ON_ONCE(ret != 0);
+	struct nfs_server *nfss = NFS_SERVER(folio_file_mapping(folio)->host);
 
-	if (atomic_long_inc_return(&nfss->writeback) >
-			NFS_CONGESTION_ON_THRESH)
+	folio_start_writeback(folio);
+	if (atomic_long_inc_return(&nfss->writeback) > NFS_CONGESTION_ON_THRESH)
 		nfss->write_congested = 1;
 }
 
-static void nfs_end_page_writeback(struct nfs_page *req)
+static void nfs_folio_end_writeback(struct folio *folio)
 {
-	struct inode *inode = nfs_page_to_inode(req);
-	struct nfs_server *nfss = NFS_SERVER(inode);
-	bool is_done;
+	struct nfs_server *nfss = NFS_SERVER(folio_file_mapping(folio)->host);
 
-	is_done = nfs_page_group_sync_on_bit(req, PG_WB_END);
-	nfs_unlock_request(req);
-	if (!is_done)
-		return;
-
-	end_page_writeback(req->wb_page);
-	if (atomic_long_dec_return(&nfss->writeback) < NFS_CONGESTION_OFF_THRESH)
+	folio_end_writeback(folio);
+	if (atomic_long_dec_return(&nfss->writeback) <
+	    NFS_CONGESTION_OFF_THRESH)
 		nfss->write_congested = 0;
 }
 
+static void nfs_page_end_writeback(struct nfs_page *req)
+{
+	if (nfs_page_group_sync_on_bit(req, PG_WB_END)) {
+		nfs_unlock_request(req);
+		nfs_folio_end_writeback(nfs_page_to_folio(req));
+	} else
+		nfs_unlock_request(req);
+}
+
 /*
  * nfs_destroy_unlinked_subrequests - destroy recently unlinked subrequests
  *
@@ -549,7 +548,7 @@ nfs_join_page_group(struct nfs_page *head, struct inode *inode)
 
 /*
  * nfs_lock_and_join_requests - join all subreqs to the head req
- * @page: the page used to lookup the "page group" of nfs_page structures
+ * @folio: the folio used to lookup the "page group" of nfs_page structures
  *
  * This function joins all sub requests to the head request by first
  * locking all requests in the group, cancelling any pending operations
@@ -559,13 +558,12 @@ nfs_join_page_group(struct nfs_page *head, struct inode *inode)
  *
  * Returns a locked, referenced pointer to the head request - which after
  * this call is guaranteed to be the only request associated with the page.
- * Returns NULL if no requests are found for @page, or a ERR_PTR if an
+ * Returns NULL if no requests are found for @folio, or a ERR_PTR if an
  * error was encountered.
  */
-static struct nfs_page *
-nfs_lock_and_join_requests(struct page *page)
+static struct nfs_page *nfs_lock_and_join_requests(struct folio *folio)
 {
-	struct inode *inode = page_file_mapping(page)->host;
+	struct inode *inode = folio_file_mapping(folio)->host;
 	struct nfs_page *head;
 	int ret;
 
@@ -574,7 +572,7 @@ nfs_lock_and_join_requests(struct page *page)
 	 * reference to the whole page group - the group will not be destroyed
 	 * until the head reference is released.
 	 */
-	head = nfs_find_and_lock_page_request(page);
+	head = nfs_folio_find_and_lock_request(folio);
 	if (IS_ERR_OR_NULL(head))
 		return head;
 
@@ -593,9 +591,9 @@ nfs_lock_and_join_requests(struct page *page)
 static void nfs_write_error(struct nfs_page *req, int error)
 {
 	trace_nfs_write_error(nfs_page_to_inode(req), req, error);
-	nfs_mapping_set_error(req->wb_page, error);
+	nfs_mapping_set_error(nfs_page_to_folio(req), error);
 	nfs_inode_remove_request(req);
-	nfs_end_page_writeback(req);
+	nfs_page_end_writeback(req);
 	nfs_release_request(req);
 }
 
@@ -603,21 +601,21 @@ static void nfs_write_error(struct nfs_page *req, int error)
  * Find an associated nfs write request, and prepare to flush it out
  * May return an error if the user signalled nfs_wait_on_request().
  */
-static int nfs_page_async_flush(struct page *page,
+static int nfs_page_async_flush(struct folio *folio,
 				struct writeback_control *wbc,
 				struct nfs_pageio_descriptor *pgio)
 {
 	struct nfs_page *req;
 	int ret = 0;
 
-	req = nfs_lock_and_join_requests(page);
+	req = nfs_lock_and_join_requests(folio);
 	if (!req)
 		goto out;
 	ret = PTR_ERR(req);
 	if (IS_ERR(req))
 		goto out;
 
-	nfs_set_page_writeback(page);
+	nfs_folio_set_writeback(folio);
 	WARN_ON_ONCE(test_bit(PG_CLEAN, &req->wb_flags));
 
 	/* If there is a fatal error that covers this write, just exit */
@@ -635,12 +633,12 @@ static int nfs_page_async_flush(struct page *page,
 			goto out_launder;
 		if (wbc->sync_mode == WB_SYNC_NONE)
 			ret = AOP_WRITEPAGE_ACTIVATE;
-		redirty_page_for_writepage(wbc, page);
+		folio_redirty_for_writepage(wbc, folio);
 		nfs_redirty_request(req);
 		pgio->pg_error = 0;
 	} else
-		nfs_add_stats(page_file_mapping(page)->host,
-				NFSIOS_WRITEPAGES, 1);
+		nfs_add_stats(folio_file_mapping(folio)->host,
+			      NFSIOS_WRITEPAGES, 1);
 out:
 	return ret;
 out_launder:
@@ -648,21 +646,21 @@ static int nfs_page_async_flush(struct page *page,
 	return 0;
 }
 
-static int nfs_do_writepage(struct page *page, struct writeback_control *wbc,
+static int nfs_do_writepage(struct folio *folio, struct writeback_control *wbc,
 			    struct nfs_pageio_descriptor *pgio)
 {
-	nfs_pageio_cond_complete(pgio, page_index(page));
-	return nfs_page_async_flush(page, wbc, pgio);
+	nfs_pageio_cond_complete(pgio, folio_index(folio));
+	return nfs_page_async_flush(folio, wbc, pgio);
 }
 
 /*
  * Write an mmapped page to the server.
  */
-static int nfs_writepage_locked(struct page *page,
+static int nfs_writepage_locked(struct folio *folio,
 				struct writeback_control *wbc)
 {
 	struct nfs_pageio_descriptor pgio;
-	struct inode *inode = page_file_mapping(page)->host;
+	struct inode *inode = folio_file_mapping(folio)->host;
 	int err;
 
 	if (wbc->sync_mode == WB_SYNC_NONE &&
@@ -670,9 +668,9 @@ static int nfs_writepage_locked(struct page *page,
 		return AOP_WRITEPAGE_ACTIVATE;
 
 	nfs_inc_stats(inode, NFSIOS_VFSWRITEPAGE);
-	nfs_pageio_init_write(&pgio, inode, 0,
-				false, &nfs_async_write_completion_ops);
-	err = nfs_do_writepage(page, wbc, &pgio);
+	nfs_pageio_init_write(&pgio, inode, 0, false,
+			      &nfs_async_write_completion_ops);
+	err = nfs_do_writepage(folio, wbc, &pgio);
 	pgio.pg_error = 0;
 	nfs_pageio_complete(&pgio);
 	return err;
@@ -680,19 +678,22 @@ static int nfs_writepage_locked(struct page *page,
 
 int nfs_writepage(struct page *page, struct writeback_control *wbc)
 {
+	struct folio *folio = page_folio(page);
 	int ret;
 
-	ret = nfs_writepage_locked(page, wbc);
+	ret = nfs_writepage_locked(folio, wbc);
 	if (ret != AOP_WRITEPAGE_ACTIVATE)
 		unlock_page(page);
 	return ret;
 }
 
-static int nfs_writepages_callback(struct page *page, struct writeback_control *wbc, void *data)
+static int nfs_writepages_callback(struct page *page,
+				   struct writeback_control *wbc, void *data)
 {
+	struct folio *folio = page_folio(page);
 	int ret;
 
-	ret = nfs_do_writepage(page, wbc, data);
+	ret = nfs_do_writepage(folio, wbc, data);
 	if (ret != AOP_WRITEPAGE_ACTIVATE)
 		unlock_page(page);
 	return ret;
@@ -748,10 +749,11 @@ int nfs_writepages(struct address_space *mapping, struct writeback_control *wbc)
 /*
  * Insert a write request into an inode
  */
-static void nfs_inode_add_request(struct inode *inode, struct nfs_page *req)
+static void nfs_inode_add_request(struct nfs_page *req)
 {
-	struct address_space *mapping = page_file_mapping(req->wb_page);
-	struct nfs_inode *nfsi = NFS_I(inode);
+	struct folio *folio = nfs_page_to_folio(req);
+	struct address_space *mapping = folio_file_mapping(folio);
+	struct nfs_inode *nfsi = NFS_I(mapping->host);
 
 	WARN_ON_ONCE(req->wb_this_page != req);
 
@@ -763,10 +765,10 @@ static void nfs_inode_add_request(struct inode *inode, struct nfs_page *req)
 	 * with invalidate/truncate.
 	 */
 	spin_lock(&mapping->private_lock);
-	if (likely(!PageSwapCache(req->wb_page))) {
+	if (likely(!folio_test_swapcache(folio))) {
 		set_bit(PG_MAPPED, &req->wb_flags);
-		SetPagePrivate(req->wb_page);
-		set_page_private(req->wb_page, (unsigned long)req);
+		folio_set_private(folio);
+		folio->private = req;
 	}
 	spin_unlock(&mapping->private_lock);
 	atomic_long_inc(&nfsi->nrequests);
@@ -783,47 +785,43 @@ static void nfs_inode_add_request(struct inode *inode, struct nfs_page *req)
  */
 static void nfs_inode_remove_request(struct nfs_page *req)
 {
-	struct address_space *mapping = page_file_mapping(req->wb_page);
-	struct inode *inode = mapping->host;
-	struct nfs_inode *nfsi = NFS_I(inode);
-	struct nfs_page *head;
-
 	if (nfs_page_group_sync_on_bit(req, PG_REMOVE)) {
-		head = req->wb_head;
+		struct folio *folio = nfs_page_to_folio(req->wb_head);
+		struct address_space *mapping = folio_file_mapping(folio);
 
 		spin_lock(&mapping->private_lock);
-		if (likely(head->wb_page && !PageSwapCache(head->wb_page))) {
-			set_page_private(head->wb_page, 0);
-			ClearPagePrivate(head->wb_page);
-			clear_bit(PG_MAPPED, &head->wb_flags);
+		if (likely(folio && !folio_test_swapcache(folio))) {
+			folio->private = NULL;
+			folio_clear_private(folio);
+			clear_bit(PG_MAPPED, &req->wb_head->wb_flags);
 		}
 		spin_unlock(&mapping->private_lock);
 	}
 
 	if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags)) {
 		nfs_release_request(req);
-		atomic_long_dec(&nfsi->nrequests);
+		atomic_long_dec(&NFS_I(nfs_page_to_inode(req))->nrequests);
 	}
 }
 
-static void
-nfs_mark_request_dirty(struct nfs_page *req)
+static void nfs_mark_request_dirty(struct nfs_page *req)
 {
-	if (req->wb_page)
-		__set_page_dirty_nobuffers(req->wb_page);
+	struct folio *folio = nfs_page_to_folio(req);
+	if (folio)
+		filemap_dirty_folio(folio_mapping(folio), folio);
 }
 
 /*
  * nfs_page_search_commits_for_head_request_locked
  *
- * Search through commit lists on @inode for the head request for @page.
+ * Search through commit lists on @inode for the head request for @folio.
  * Must be called while holding the inode (which is cinfo) lock.
  *
  * Returns the head request if found, or NULL if not found.
  */
 static struct nfs_page *
 nfs_page_search_commits_for_head_request_locked(struct nfs_inode *nfsi,
-						struct page *page)
+						struct folio *folio)
 {
 	struct nfs_page *freq, *t;
 	struct nfs_commit_info cinfo;
@@ -832,13 +830,13 @@ nfs_page_search_commits_for_head_request_locked(struct nfs_inode *nfsi,
 	nfs_init_cinfo_from_inode(&cinfo, inode);
 
 	/* search through pnfs commit lists */
-	freq = pnfs_search_commit_reqs(inode, &cinfo, page);
+	freq = pnfs_search_commit_reqs(inode, &cinfo, folio);
 	if (freq)
 		return freq->wb_head;
 
 	/* Linearly search the commit list for the correct request */
 	list_for_each_entry_safe(freq, t, &cinfo.mds->list, wb_list) {
-		if (freq->wb_page == page)
+		if (nfs_page_to_folio(freq) == folio)
 			return freq->wb_head;
 	}
 
@@ -886,8 +884,7 @@ nfs_request_add_commit_list(struct nfs_page *req, struct nfs_commit_info *cinfo)
 	mutex_lock(&NFS_I(cinfo->inode)->commit_mutex);
 	nfs_request_add_commit_list_locked(req, &cinfo->mds->list, cinfo);
 	mutex_unlock(&NFS_I(cinfo->inode)->commit_mutex);
-	if (req->wb_page)
-		nfs_mark_page_unstable(req->wb_page, cinfo);
+	nfs_folio_mark_unstable(nfs_page_to_folio(req), cinfo);
 }
 EXPORT_SYMBOL_GPL(nfs_request_add_commit_list);
 
@@ -946,12 +943,15 @@ nfs_mark_request_commit(struct nfs_page *req, struct pnfs_layout_segment *lseg,
 	nfs_request_add_commit_list(req, cinfo);
 }
 
-static void
-nfs_clear_page_commit(struct page *page)
+static void nfs_folio_clear_commit(struct folio *folio)
 {
-	dec_node_page_state(page, NR_WRITEBACK);
-	dec_wb_stat(&inode_to_bdi(page_file_mapping(page)->host)->wb,
-		    WB_WRITEBACK);
+	if (folio) {
+		long nr = folio_nr_pages(folio);
+
+		node_stat_mod_folio(folio, NR_WRITEBACK, -nr);
+		wb_stat_mod(&inode_to_bdi(folio_file_mapping(folio)->host)->wb,
+			    WB_WRITEBACK, -nr);
+	}
 }
 
 /* Called holding the request lock on @req */
@@ -969,7 +969,7 @@ nfs_clear_request_commit(struct nfs_page *req)
 			nfs_request_remove_commit_list(req, &cinfo);
 		}
 		mutex_unlock(&NFS_I(inode)->commit_mutex);
-		nfs_clear_page_commit(req->wb_page);
+		nfs_folio_clear_commit(nfs_page_to_folio(req));
 	}
 }
 
@@ -1001,7 +1001,8 @@ static void nfs_write_completion(struct nfs_pgio_header *hdr)
 		if (test_bit(NFS_IOHDR_ERROR, &hdr->flags) &&
 		    (hdr->good_bytes < bytes)) {
 			trace_nfs_comp_error(hdr->inode, req, hdr->error);
-			nfs_mapping_set_error(req->wb_page, hdr->error);
+			nfs_mapping_set_error(nfs_page_to_folio(req),
+					      hdr->error);
 			goto remove_req;
 		}
 		if (nfs_write_need_commit(hdr)) {
@@ -1015,7 +1016,7 @@ static void nfs_write_completion(struct nfs_pgio_header *hdr)
 remove_req:
 		nfs_inode_remove_request(req);
 next:
-		nfs_end_page_writeback(req);
+		nfs_page_end_writeback(req);
 		nfs_release_request(req);
 	}
 out:
@@ -1091,10 +1092,9 @@ nfs_scan_commit(struct inode *inode, struct list_head *dst,
  * If the attempt fails, then the existing request is flushed out
  * to disk.
  */
-static struct nfs_page *nfs_try_to_update_request(struct inode *inode,
-		struct page *page,
-		unsigned int offset,
-		unsigned int bytes)
+static struct nfs_page *nfs_try_to_update_request(struct folio *folio,
+						  unsigned int offset,
+						  unsigned int bytes)
 {
 	struct nfs_page *req;
 	unsigned int rqend;
@@ -1103,7 +1103,7 @@ static struct nfs_page *nfs_try_to_update_request(struct inode *inode,
 
 	end = offset + bytes;
 
-	req = nfs_lock_and_join_requests(page);
+	req = nfs_lock_and_join_requests(folio);
 	if (IS_ERR_OR_NULL(req))
 		return req;
 
@@ -1136,7 +1136,7 @@ static struct nfs_page *nfs_try_to_update_request(struct inode *inode,
 	 */
 	nfs_mark_request_dirty(req);
 	nfs_unlock_and_release_request(req);
-	error = nfs_wb_page(inode, page);
+	error = nfs_wb_folio(folio_file_mapping(folio)->host, folio);
 	return (error < 0) ? ERR_PTR(error) : NULL;
 }
 
@@ -1147,40 +1147,42 @@ static struct nfs_page *nfs_try_to_update_request(struct inode *inode,
  * if we have to add a new request. Also assumes that the caller has
  * already called nfs_flush_incompatible() if necessary.
  */
-static struct nfs_page * nfs_setup_write_request(struct nfs_open_context* ctx,
-		struct page *page, unsigned int offset, unsigned int bytes)
+static struct nfs_page *nfs_setup_write_request(struct nfs_open_context *ctx,
+						struct folio *folio,
+						unsigned int offset,
+						unsigned int bytes)
 {
-	struct inode *inode = page_file_mapping(page)->host;
-	struct nfs_page	*req;
+	struct nfs_page *req;
 
-	req = nfs_try_to_update_request(inode, page, offset, bytes);
+	req = nfs_try_to_update_request(folio, offset, bytes);
 	if (req != NULL)
 		goto out;
-	req = nfs_create_request(ctx, page, offset, bytes);
+	req = nfs_page_create_from_folio(ctx, folio, offset, bytes);
 	if (IS_ERR(req))
 		goto out;
-	nfs_inode_add_request(inode, req);
+	nfs_inode_add_request(req);
 out:
 	return req;
 }
 
-static int nfs_writepage_setup(struct nfs_open_context *ctx, struct page *page,
-		unsigned int offset, unsigned int count)
+static int nfs_writepage_setup(struct nfs_open_context *ctx,
+			       struct folio *folio, unsigned int offset,
+			       unsigned int count)
 {
-	struct nfs_page	*req;
+	struct nfs_page *req;
 
-	req = nfs_setup_write_request(ctx, page, offset, count);
+	req = nfs_setup_write_request(ctx, folio, offset, count);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 	/* Update file length */
-	nfs_grow_file(page, offset, count);
+	nfs_grow_file(folio, offset, count);
 	nfs_mark_uptodate(req);
 	nfs_mark_request_dirty(req);
 	nfs_unlock_and_release_request(req);
 	return 0;
 }
 
-int nfs_flush_incompatible(struct file *file, struct page *page)
+int nfs_flush_incompatible(struct file *file, struct folio *folio)
 {
 	struct nfs_open_context *ctx = nfs_file_open_context(file);
 	struct nfs_lock_context *l_ctx;
@@ -1196,12 +1198,12 @@ int nfs_flush_incompatible(struct file *file, struct page *page)
 	 * dropped page.
 	 */
 	do {
-		req = nfs_page_find_head_request(page);
+		req = nfs_folio_find_head_request(folio);
 		if (req == NULL)
 			return 0;
 		l_ctx = req->wb_lock_context;
-		do_flush = req->wb_page != page ||
-			!nfs_match_open_context(nfs_req_openctx(req), ctx);
+		do_flush = nfs_page_to_folio(req) != folio ||
+			   !nfs_match_open_context(nfs_req_openctx(req), ctx);
 		if (l_ctx && flctx &&
 		    !(list_empty_careful(&flctx->flc_posix) &&
 		      list_empty_careful(&flctx->flc_flock))) {
@@ -1210,7 +1212,7 @@ int nfs_flush_incompatible(struct file *file, struct page *page)
 		nfs_release_request(req);
 		if (!do_flush)
 			return 0;
-		status = nfs_wb_page(page_file_mapping(page)->host, page);
+		status = nfs_wb_folio(folio_file_mapping(folio)->host, folio);
 	} while (status == 0);
 	return status;
 }
@@ -1282,9 +1284,9 @@ bool nfs_ctx_key_to_expire(struct nfs_open_context *ctx, struct inode *inode)
  * the PageUptodate() flag. In this case, we will need to turn off
  * write optimisations that depend on the page contents being correct.
  */
-static bool nfs_write_pageuptodate(struct page *page, struct inode *inode,
-				   unsigned int pagelen)
+static bool nfs_folio_write_uptodate(struct folio *folio, unsigned int pagelen)
 {
+	struct inode *inode = folio_file_mapping(folio)->host;
 	struct nfs_inode *nfsi = NFS_I(inode);
 
 	if (nfs_have_delegated_attributes(inode))
@@ -1298,7 +1300,7 @@ static bool nfs_write_pageuptodate(struct page *page, struct inode *inode,
 out:
 	if (nfsi->cache_validity & NFS_INO_INVALID_DATA && pagelen != 0)
 		return false;
-	return PageUptodate(page) != 0;
+	return folio_test_uptodate(folio) != 0;
 }
 
 static bool
@@ -1316,16 +1318,17 @@ is_whole_file_wrlock(struct file_lock *fl)
  * If the file is opened for synchronous writes then we can just skip the rest
  * of the checks.
  */
-static int nfs_can_extend_write(struct file *file, struct page *page,
-				struct inode *inode, unsigned int pagelen)
+static int nfs_can_extend_write(struct file *file, struct folio *folio,
+				unsigned int pagelen)
 {
-	int ret;
+	struct inode *inode = file_inode(file);
 	struct file_lock_context *flctx = locks_inode_context(inode);
 	struct file_lock *fl;
+	int ret;
 
 	if (file->f_flags & O_DSYNC)
 		return 0;
-	if (!nfs_write_pageuptodate(page, inode, pagelen))
+	if (!nfs_folio_write_uptodate(folio, pagelen))
 		return 0;
 	if (NFS_PROTO(inode)->have_delegation(inode, FMODE_WRITE))
 		return 1;
@@ -1357,33 +1360,33 @@ static int nfs_can_extend_write(struct file *file, struct page *page,
  * XXX: Keep an eye on generic_file_read to make sure it doesn't do bad
  * things with a page scheduled for an RPC call (e.g. invalidate it).
  */
-int nfs_updatepage(struct file *file, struct page *page,
-		unsigned int offset, unsigned int count)
+int nfs_update_folio(struct file *file, struct folio *folio,
+		     unsigned int offset, unsigned int count)
 {
 	struct nfs_open_context *ctx = nfs_file_open_context(file);
-	struct address_space *mapping = page_file_mapping(page);
-	struct inode	*inode = mapping->host;
-	unsigned int	pagelen = nfs_page_length(page);
+	struct address_space *mapping = folio_file_mapping(folio);
+	struct inode *inode = mapping->host;
+	unsigned int pagelen = nfs_folio_length(folio);
 	int		status = 0;
 
 	nfs_inc_stats(inode, NFSIOS_VFSUPDATEPAGE);
 
-	dprintk("NFS:       nfs_updatepage(%pD2 %d@%lld)\n",
-		file, count, (long long)(page_file_offset(page) + offset));
+	dprintk("NFS:       nfs_update_folio(%pD2 %d@%lld)\n", file, count,
+		(long long)(folio_file_pos(folio) + offset));
 
 	if (!count)
 		goto out;
 
-	if (nfs_can_extend_write(file, page, inode, pagelen)) {
+	if (nfs_can_extend_write(file, folio, pagelen)) {
 		count = max(count + offset, pagelen);
 		offset = 0;
 	}
 
-	status = nfs_writepage_setup(ctx, page, offset, count);
+	status = nfs_writepage_setup(ctx, folio, offset, count);
 	if (status < 0)
 		nfs_set_pageerror(mapping);
 out:
-	dprintk("NFS:       nfs_updatepage returns %d (isize %lld)\n",
+	dprintk("NFS:       nfs_update_folio returns %d (isize %lld)\n",
 			status, (long long)i_size_read(inode));
 	return status;
 }
@@ -1425,7 +1428,7 @@ static void nfs_redirty_request(struct nfs_page *req)
 	req->wb_nio++;
 	nfs_mark_request_dirty(req);
 	atomic_long_inc(&nfsi->redirtied_pages);
-	nfs_end_page_writeback(req);
+	nfs_page_end_writeback(req);
 	nfs_release_request(req);
 }
 
@@ -1783,18 +1786,18 @@ void nfs_retry_commit(struct list_head *page_list,
 		req = nfs_list_entry(page_list->next);
 		nfs_list_remove_request(req);
 		nfs_mark_request_commit(req, lseg, cinfo, ds_commit_idx);
-		if (!cinfo->dreq)
-			nfs_clear_page_commit(req->wb_page);
+		nfs_folio_clear_commit(nfs_page_to_folio(req));
 		nfs_unlock_and_release_request(req);
 	}
 }
 EXPORT_SYMBOL_GPL(nfs_retry_commit);
 
-static void
-nfs_commit_resched_write(struct nfs_commit_info *cinfo,
-		struct nfs_page *req)
+static void nfs_commit_resched_write(struct nfs_commit_info *cinfo,
+				     struct nfs_page *req)
 {
-	__set_page_dirty_nobuffers(req->wb_page);
+	struct folio *folio = nfs_page_to_folio(req);
+
+	filemap_dirty_folio(folio_mapping(folio), folio);
 }
 
 /*
@@ -1845,12 +1848,13 @@ static void nfs_commit_release_pages(struct nfs_commit_data *data)
 	int status = data->task.tk_status;
 	struct nfs_commit_info cinfo;
 	struct nfs_server *nfss;
+	struct folio *folio;
 
 	while (!list_empty(&data->pages)) {
 		req = nfs_list_entry(data->pages.next);
 		nfs_list_remove_request(req);
-		if (req->wb_page)
-			nfs_clear_page_commit(req->wb_page);
+		folio = nfs_page_to_folio(req);
+		nfs_folio_clear_commit(folio);
 
 		dprintk("NFS:       commit (%s/%llu %d@%lld)",
 			nfs_req_openctx(req)->dentry->d_sb->s_id,
@@ -1858,10 +1862,10 @@ static void nfs_commit_release_pages(struct nfs_commit_data *data)
 			req->wb_bytes,
 			(long long)req_offset(req));
 		if (status < 0) {
-			if (req->wb_page) {
+			if (folio) {
 				trace_nfs_commit_error(data->inode, req,
 						       status);
-				nfs_mapping_set_error(req->wb_page, status);
+				nfs_mapping_set_error(folio, status);
 				nfs_inode_remove_request(req);
 			}
 			dprintk_cont(", error = %d\n", status);
@@ -1872,7 +1876,7 @@ static void nfs_commit_release_pages(struct nfs_commit_data *data)
 		 * returned by the server against all stored verfs. */
 		if (nfs_write_match_verf(verf, req)) {
 			/* We have a match */
-			if (req->wb_page)
+			if (folio)
 				nfs_inode_remove_request(req);
 			dprintk_cont(" OK\n");
 			goto next;
@@ -2053,7 +2057,7 @@ int nfs_wb_folio_cancel(struct inode *inode, struct folio *folio)
 
 	/* blocking call to cancel all requests and join to a single (head)
 	 * request */
-	req = nfs_lock_and_join_requests(&folio->page);
+	req = nfs_lock_and_join_requests(folio);
 
 	if (IS_ERR(req)) {
 		ret = PTR_ERR(req);
@@ -2094,7 +2098,7 @@ int nfs_wb_folio(struct inode *inode, struct folio *folio)
 	for (;;) {
 		folio_wait_writeback(folio);
 		if (folio_clear_dirty_for_io(folio)) {
-			ret = nfs_writepage_locked(&folio->page, &wbc);
+			ret = nfs_writepage_locked(folio, &wbc);
 			if (ret < 0)
 				goto out_error;
 			continue;
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 66b5de42f6b8..a61bfd52d551 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -569,8 +569,9 @@ extern void nfs_complete_unlink(struct dentry *dentry, struct inode *);
 extern int  nfs_congestion_kb;
 extern int  nfs_writepage(struct page *page, struct writeback_control *wbc);
 extern int  nfs_writepages(struct address_space *, struct writeback_control *);
-extern int  nfs_flush_incompatible(struct file *file, struct page *page);
-extern int  nfs_updatepage(struct file *, struct page *, unsigned int, unsigned int);
+extern int  nfs_flush_incompatible(struct file *file, struct folio *folio);
+extern int  nfs_update_folio(struct file *file, struct folio *folio,
+			     unsigned int offset, unsigned int count);
 
 /*
  * Try to write back everything synchronously (but check the
-- 
2.39.0

