Return-Path: <linux-nfs+bounces-3853-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5559096C4
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Jun 2024 10:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 167BB1F22F21
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Jun 2024 08:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E6418037;
	Sat, 15 Jun 2024 08:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3ArE+L2d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0771E17C9B
	for <linux-nfs@vger.kernel.org>; Sat, 15 Jun 2024 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718438914; cv=none; b=PpfQShdFV0xkJsIErOw6IKchQwh6/DuHAa3ifQ+T7i7RXFW6ZBSlULcgCnCmXNu8G5Two7ncwHZgmeMxALXyngh5tgnlrk+EK3vIMulkhyoeEvNO9XQGCuLp73akUx1JP/GddZYeQnxiRMNUv9k2wa1N+QaTYpbXLNdFCcuMfhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718438914; c=relaxed/simple;
	bh=6fsYvBehvpKrv3NTgL9xlST+JbZdeeYWc3faqYoz8kM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sCjFmDI773NV3M3+uXyzLgpt8qhV3DVyptW1SdaByxT0EI+IDqKeIYyIqOuULMZfDW4AvY0czdiRE2vOlG2SDhRhrAzWhXMdbFHZmKlSpmgMmkmR17I2J2rO9td3Bao32+Nqw3L3o/Zrp3dkmIqt9Y/wjpEF25UFVe7Ml0SAtqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3ArE+L2d; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=rQcsiwIfxaT32HQMwBP+h3n228Fx5p4ACx/JsbIau7M=; b=3ArE+L2d8oxdQb7kJcDqqEvjFK
	HZlNRFKnR+9vdgYpRSfIhwApVw+7+YvG9Cp1+En/H7hWkxRsxllFlNzfb4Bh1SVTzbcykx7P5kFgp
	oZzFwDnVERRq6Zy3gUOK+uJDuJcJc8HkFBWtf9aLhhkiMPrvYPrDYR+PKxkDNjpFBJh4M03k8hU8/
	WONMHNxqbL/tZX0GHjLr70+6zIp1bR3DPBvMs5ARCQXtdPbZsqqoSXHBkP0w4lKqtOj56uwArLRrR
	bptPaqeI0Y/oZKfJKrXo4aG6bKiJwnIZu0hiWOxSGX6TPYYA9AkM5v985dwt1tAlMNPQmHgkrR9Go
	gOFuEn4A==;
Received: from [2001:4bb8:2a7:e44f:608d:bff8:1b6d:ab1d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIOSd-00000004y3Y-0VTi;
	Sat, 15 Jun 2024 08:08:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: remove dead code for the old swap over NFS implementation
Date: Sat, 15 Jun 2024 10:08:27 +0200
Message-ID: <20240615080827.1239935-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Remove the code testing folio_test_swapcache either explicitly or
implicitly in pagemap.h headers, as is now handled using the direct I/O
path and not the buffered I/O path that these helpers are located in.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/file.c                  |   6 +-
 fs/nfs/filelayout/filelayout.c |   1 -
 fs/nfs/fscache.c               |   2 +-
 fs/nfs/internal.h              |   8 +--
 fs/nfs/pagelist.c              |   2 +-
 fs/nfs/pnfs.h                  |  22 ------
 fs/nfs/pnfs_nfs.c              |  47 ------------
 fs/nfs/read.c                  |   2 +-
 fs/nfs/write.c                 | 128 +++++++--------------------------
 include/linux/nfs_page.h       |   4 +-
 10 files changed, 36 insertions(+), 186 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 6bd127e6683dce..92f671820c1356 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -425,7 +425,7 @@ static int nfs_write_end(struct file *file, struct address_space *mapping,
 static void nfs_invalidate_folio(struct folio *folio, size_t offset,
 				size_t length)
 {
-	struct inode *inode = folio_file_mapping(folio)->host;
+	struct inode *inode = folio->mapping->host;
 	dfprintk(PAGECACHE, "NFS: invalidate_folio(%lu, %zu, %zu)\n",
 		 folio->index, offset, length);
 
@@ -452,7 +452,7 @@ static bool nfs_release_folio(struct folio *folio, gfp_t gfp)
 		if ((current_gfp_context(gfp) & GFP_KERNEL) != GFP_KERNEL ||
 		    current_is_kswapd())
 			return false;
-		if (nfs_wb_folio(folio_file_mapping(folio)->host, folio) < 0)
+		if (nfs_wb_folio(folio->mapping->host, folio) < 0)
 			return false;
 	}
 	return nfs_fscache_release_folio(folio, gfp);
@@ -604,7 +604,7 @@ static vm_fault_t nfs_vm_page_mkwrite(struct vm_fault *vmf)
 			   TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
 
 	folio_lock(folio);
-	mapping = folio_file_mapping(folio);
+	mapping = folio->mapping;
 	if (mapping != inode->i_mapping)
 		goto out_unlock;
 
diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index 29d84dc66ca391..b6e9aeaf4ce289 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -1110,7 +1110,6 @@ static const struct pnfs_commit_ops filelayout_commit_ops = {
 	.clear_request_commit	= pnfs_generic_clear_request_commit,
 	.scan_commit_lists	= pnfs_generic_scan_commit_lists,
 	.recover_commit_reqs	= pnfs_generic_recover_commit_reqs,
-	.search_commit_reqs	= pnfs_generic_search_commit_reqs,
 	.commit_pagelist	= filelayout_commit_pagelist,
 };
 
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index ddc1ee0319554c..7202ce84d0eb03 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -341,7 +341,7 @@ void nfs_netfs_initiate_read(struct nfs_pgio_header *hdr)
 
 int nfs_netfs_folio_unlock(struct folio *folio)
 {
-	struct inode *inode = folio_file_mapping(folio)->host;
+	struct inode *inode = folio->mapping->host;
 
 	/*
 	 * If fscache is enabled, netfs will unlock pages.
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 9f0f4534744ba4..87ebc4608c316a 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -785,7 +785,7 @@ static inline void nfs_folio_mark_unstable(struct folio *folio,
 					   struct nfs_commit_info *cinfo)
 {
 	if (folio && !cinfo->dreq) {
-		struct inode *inode = folio_file_mapping(folio)->host;
+		struct inode *inode = folio->mapping->host;
 		long nr = folio_nr_pages(folio);
 
 		/* This page is really still in write-back - just that the
@@ -803,7 +803,7 @@ static inline void nfs_folio_mark_unstable(struct folio *folio,
 static inline
 unsigned int nfs_page_length(struct page *page)
 {
-	loff_t i_size = i_size_read(page_file_mapping(page)->host);
+	loff_t i_size = i_size_read(page->mapping->host);
 
 	if (i_size > 0) {
 		pgoff_t index = page_index(page);
@@ -821,10 +821,10 @@ unsigned int nfs_page_length(struct page *page)
  */
 static inline size_t nfs_folio_length(struct folio *folio)
 {
-	loff_t i_size = i_size_read(folio_file_mapping(folio)->host);
+	loff_t i_size = i_size_read(folio->mapping->host);
 
 	if (i_size > 0) {
-		pgoff_t index = folio_index(folio) >> folio_order(folio);
+		pgoff_t index = folio->index >> folio_order(folio);
 		pgoff_t end_index = (i_size - 1) >> folio_shift(folio);
 		if (index < end_index)
 			return folio_size(folio);
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 040b6b79c75e59..3b006bcbcc87a2 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -569,7 +569,7 @@ struct nfs_page *nfs_page_create_from_folio(struct nfs_open_context *ctx,
 
 	if (IS_ERR(l_ctx))
 		return ERR_CAST(l_ctx);
-	ret = nfs_page_create(l_ctx, offset, folio_index(folio), offset, count);
+	ret = nfs_page_create(l_ctx, offset, folio->index, offset, count);
 	if (!IS_ERR(ret)) {
 		nfs_page_assign_folio(ret, folio);
 		nfs_page_group_init(ret, NULL);
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index fa5beeaaf5daa3..4cd204f844adcd 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -193,8 +193,6 @@ struct pnfs_commit_ops {
 				  int max);
 	void (*recover_commit_reqs) (struct list_head *list,
 				     struct nfs_commit_info *cinfo);
-	struct nfs_page * (*search_commit_reqs)(struct nfs_commit_info *cinfo,
-						struct folio *folio);
 };
 
 struct pnfs_layout_hdr {
@@ -396,8 +394,6 @@ void pnfs_generic_prepare_to_resend_writes(struct nfs_commit_data *data);
 void pnfs_generic_rw_release(void *data);
 void pnfs_generic_recover_commit_reqs(struct list_head *dst,
 				      struct nfs_commit_info *cinfo);
-struct nfs_page *pnfs_generic_search_commit_reqs(struct nfs_commit_info *cinfo,
-						 struct folio *folio);
 int pnfs_generic_commit_pagelist(struct inode *inode,
 				 struct list_head *mds_pages,
 				 int how,
@@ -557,17 +553,6 @@ pnfs_recover_commit_reqs(struct list_head *head, struct nfs_commit_info *cinfo)
 		fl_cinfo->ops->recover_commit_reqs(head, cinfo);
 }
 
-static inline struct nfs_page *
-pnfs_search_commit_reqs(struct inode *inode, struct nfs_commit_info *cinfo,
-			struct folio *folio)
-{
-	struct pnfs_ds_commit_info *fl_cinfo = cinfo->ds;
-
-	if (!fl_cinfo->ops || !fl_cinfo->ops->search_commit_reqs)
-		return NULL;
-	return fl_cinfo->ops->search_commit_reqs(cinfo, folio);
-}
-
 /* Should the pNFS client commit and return the layout upon a setattr */
 static inline bool
 pnfs_ld_layoutret_on_setattr(struct inode *inode)
@@ -864,13 +849,6 @@ pnfs_recover_commit_reqs(struct list_head *head, struct nfs_commit_info *cinfo)
 {
 }
 
-static inline struct nfs_page *
-pnfs_search_commit_reqs(struct inode *inode, struct nfs_commit_info *cinfo,
-			struct folio *folio)
-{
-	return NULL;
-}
-
 static inline int pnfs_layoutcommit_inode(struct inode *inode, bool sync)
 {
 	return 0;
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 88e061bd711b74..a74ee69a2fa638 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -351,53 +351,6 @@ void pnfs_generic_recover_commit_reqs(struct list_head *dst,
 }
 EXPORT_SYMBOL_GPL(pnfs_generic_recover_commit_reqs);
 
-static struct nfs_page *
-pnfs_bucket_search_commit_reqs(struct pnfs_commit_bucket *buckets,
-			       unsigned int nbuckets, struct folio *folio)
-{
-	struct nfs_page *req;
-	struct pnfs_commit_bucket *b;
-	unsigned int i;
-
-	/* Linearly search the commit lists for each bucket until a matching
-	 * request is found */
-	for (i = 0, b = buckets; i < nbuckets; i++, b++) {
-		list_for_each_entry(req, &b->written, wb_list) {
-			if (nfs_page_to_folio(req) == folio)
-				return req->wb_head;
-		}
-		list_for_each_entry(req, &b->committing, wb_list) {
-			if (nfs_page_to_folio(req) == folio)
-				return req->wb_head;
-		}
-	}
-	return NULL;
-}
-
-/* pnfs_generic_search_commit_reqs - Search lists in @cinfo for the head request
- *				   for @folio
- * @cinfo - commit info for current inode
- * @folio - page to search for matching head request
- *
- * Return: the head request if one is found, otherwise %NULL.
- */
-struct nfs_page *pnfs_generic_search_commit_reqs(struct nfs_commit_info *cinfo,
-						 struct folio *folio)
-{
-	struct pnfs_ds_commit_info *fl_cinfo = cinfo->ds;
-	struct pnfs_commit_array *array;
-	struct nfs_page *req;
-
-	list_for_each_entry(array, &fl_cinfo->commits, cinfo_list) {
-		req = pnfs_bucket_search_commit_reqs(array->buckets,
-						     array->nbuckets, folio);
-		if (req)
-			return req;
-	}
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(pnfs_generic_search_commit_reqs);
-
 static struct pnfs_layout_segment *
 pnfs_bucket_get_committing(struct list_head *head,
 			   struct pnfs_commit_bucket *bucket,
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index a142287d86f68e..e75c9e862d01d6 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -288,7 +288,7 @@ int nfs_read_add_folio(struct nfs_pageio_descriptor *pgio,
 		       struct nfs_open_context *ctx,
 		       struct folio *folio)
 {
-	struct inode *inode = folio_file_mapping(folio)->host;
+	struct inode *inode = folio->mapping->host;
 	struct nfs_server *server = NFS_SERVER(inode);
 	size_t fsize = folio_size(folio);
 	unsigned int rsize = server->rsize;
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 2329cbb0e446b9..500576e62e7c3a 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -63,9 +63,6 @@ static void nfs_clear_request_commit(struct nfs_commit_info *cinfo,
 				     struct nfs_page *req);
 static void nfs_init_cinfo_from_inode(struct nfs_commit_info *cinfo,
 				      struct inode *inode);
-static struct nfs_page *
-nfs_page_search_commits_for_head_request_locked(struct nfs_inode *nfsi,
-						struct folio *folio);
 
 static struct kmem_cache *nfs_wdata_cachep;
 static mempool_t *nfs_wdata_mempool;
@@ -178,16 +175,16 @@ static struct nfs_page *nfs_folio_private_request(struct folio *folio)
 }
 
 /**
- * nfs_folio_find_private_request - find head request associated with a folio
+ * nfs_folio_find_head_request - find head request associated with a folio
  * @folio: pointer to folio
  *
  * must be called while holding the inode lock.
  *
  * returns matching head request with reference held, or NULL if not found.
  */
-static struct nfs_page *nfs_folio_find_private_request(struct folio *folio)
+static struct nfs_page *nfs_folio_find_head_request(struct folio *folio)
 {
-	struct address_space *mapping = folio_file_mapping(folio);
+	struct address_space *mapping = folio->mapping;
 	struct nfs_page *req;
 
 	if (!folio_test_private(folio))
@@ -202,45 +199,9 @@ static struct nfs_page *nfs_folio_find_private_request(struct folio *folio)
 	return req;
 }
 
-static struct nfs_page *nfs_folio_find_swap_request(struct folio *folio)
-{
-	struct inode *inode = folio_file_mapping(folio)->host;
-	struct nfs_inode *nfsi = NFS_I(inode);
-	struct nfs_page *req = NULL;
-	if (!folio_test_swapcache(folio))
-		return NULL;
-	mutex_lock(&nfsi->commit_mutex);
-	if (folio_test_swapcache(folio)) {
-		req = nfs_page_search_commits_for_head_request_locked(nfsi,
-								      folio);
-		if (req) {
-			WARN_ON_ONCE(req->wb_head != req);
-			kref_get(&req->wb_kref);
-		}
-	}
-	mutex_unlock(&nfsi->commit_mutex);
-	return req;
-}
-
-/**
- * nfs_folio_find_head_request - find head request associated with a folio
- * @folio: pointer to folio
- *
- * returns matching head request with reference held, or NULL if not found.
- */
-static struct nfs_page *nfs_folio_find_head_request(struct folio *folio)
-{
-	struct nfs_page *req;
-
-	req = nfs_folio_find_private_request(folio);
-	if (!req)
-		req = nfs_folio_find_swap_request(folio);
-	return req;
-}
-
 static struct nfs_page *nfs_folio_find_and_lock_request(struct folio *folio)
 {
-	struct inode *inode = folio_file_mapping(folio)->host;
+	struct inode *inode = folio->mapping->host;
 	struct nfs_page *req, *head;
 	int ret;
 
@@ -261,8 +222,6 @@ static struct nfs_page *nfs_folio_find_and_lock_request(struct folio *folio)
 		/* Ensure that nobody removed the request before we locked it */
 		if (head == nfs_folio_private_request(folio))
 			break;
-		if (folio_test_swapcache(folio))
-			break;
 		nfs_unlock_and_release_request(head);
 	}
 	return head;
@@ -272,14 +231,14 @@ static struct nfs_page *nfs_folio_find_and_lock_request(struct folio *folio)
 static void nfs_grow_file(struct folio *folio, unsigned int offset,
 			  unsigned int count)
 {
-	struct inode *inode = folio_file_mapping(folio)->host;
+	struct inode *inode = folio->mapping->host;
 	loff_t end, i_size;
 	pgoff_t end_index;
 
 	spin_lock(&inode->i_lock);
 	i_size = i_size_read(inode);
 	end_index = ((i_size - 1) >> folio_shift(folio)) << folio_order(folio);
-	if (i_size > 0 && folio_index(folio) < end_index)
+	if (i_size > 0 && folio->index < end_index)
 		goto out;
 	end = folio_file_pos(folio) + (loff_t)offset + (loff_t)count;
 	if (i_size >= end)
@@ -309,7 +268,7 @@ static void nfs_set_pageerror(struct address_space *mapping)
 
 static void nfs_mapping_set_error(struct folio *folio, int error)
 {
-	struct address_space *mapping = folio_file_mapping(folio);
+	struct address_space *mapping = folio->mapping;
 
 	folio_set_error(folio);
 	filemap_set_wb_err(mapping, error);
@@ -410,7 +369,7 @@ int nfs_congestion_kb;
 
 static void nfs_folio_set_writeback(struct folio *folio)
 {
-	struct nfs_server *nfss = NFS_SERVER(folio_file_mapping(folio)->host);
+	struct nfs_server *nfss = NFS_SERVER(folio->mapping->host);
 
 	folio_start_writeback(folio);
 	if (atomic_long_inc_return(&nfss->writeback) > NFS_CONGESTION_ON_THRESH)
@@ -419,7 +378,7 @@ static void nfs_folio_set_writeback(struct folio *folio)
 
 static void nfs_folio_end_writeback(struct folio *folio)
 {
-	struct nfs_server *nfss = NFS_SERVER(folio_file_mapping(folio)->host);
+	struct nfs_server *nfss = NFS_SERVER(folio->mapping->host);
 
 	folio_end_writeback(folio);
 	if (atomic_long_dec_return(&nfss->writeback) <
@@ -565,7 +524,7 @@ void nfs_join_page_group(struct nfs_page *head, struct nfs_commit_info *cinfo,
  */
 static struct nfs_page *nfs_lock_and_join_requests(struct folio *folio)
 {
-	struct inode *inode = folio_file_mapping(folio)->host;
+	struct inode *inode = folio->mapping->host;
 	struct nfs_page *head;
 	struct nfs_commit_info cinfo;
 	int ret;
@@ -641,7 +600,7 @@ static int nfs_page_async_flush(struct folio *folio,
 		nfs_redirty_request(req);
 		pgio->pg_error = 0;
 	} else
-		nfs_add_stats(folio_file_mapping(folio)->host,
+		nfs_add_stats(folio->mapping->host,
 			      NFSIOS_WRITEPAGES, 1);
 out:
 	return ret;
@@ -653,7 +612,7 @@ static int nfs_page_async_flush(struct folio *folio,
 static int nfs_do_writepage(struct folio *folio, struct writeback_control *wbc,
 			    struct nfs_pageio_descriptor *pgio)
 {
-	nfs_pageio_cond_complete(pgio, folio_index(folio));
+	nfs_pageio_cond_complete(pgio, folio->index);
 	return nfs_page_async_flush(folio, wbc, pgio);
 }
 
@@ -664,7 +623,7 @@ static int nfs_writepage_locked(struct folio *folio,
 				struct writeback_control *wbc)
 {
 	struct nfs_pageio_descriptor pgio;
-	struct inode *inode = folio_file_mapping(folio)->host;
+	struct inode *inode = folio->mapping->host;
 	int err;
 
 	nfs_inc_stats(inode, NFSIOS_VFSWRITEPAGE);
@@ -742,24 +701,17 @@ int nfs_writepages(struct address_space *mapping, struct writeback_control *wbc)
 static void nfs_inode_add_request(struct nfs_page *req)
 {
 	struct folio *folio = nfs_page_to_folio(req);
-	struct address_space *mapping = folio_file_mapping(folio);
+	struct address_space *mapping = folio->mapping;
 	struct nfs_inode *nfsi = NFS_I(mapping->host);
 
 	WARN_ON_ONCE(req->wb_this_page != req);
 
 	/* Lock the request! */
 	nfs_lock_request(req);
-
-	/*
-	 * Swap-space should not get truncated. Hence no need to plug the race
-	 * with invalidate/truncate.
-	 */
 	spin_lock(&mapping->i_private_lock);
-	if (likely(!folio_test_swapcache(folio))) {
-		set_bit(PG_MAPPED, &req->wb_flags);
-		folio_set_private(folio);
-		folio->private = req;
-	}
+	set_bit(PG_MAPPED, &req->wb_flags);
+	folio_set_private(folio);
+	folio->private = req;
 	spin_unlock(&mapping->i_private_lock);
 	atomic_long_inc(&nfsi->nrequests);
 	/* this a head request for a page group - mark it as having an
@@ -779,10 +731,10 @@ static void nfs_inode_remove_request(struct nfs_page *req)
 
 	if (nfs_page_group_sync_on_bit(req, PG_REMOVE)) {
 		struct folio *folio = nfs_page_to_folio(req->wb_head);
-		struct address_space *mapping = folio_file_mapping(folio);
+		struct address_space *mapping = folio->mapping;
 
 		spin_lock(&mapping->i_private_lock);
-		if (likely(folio && !folio_test_swapcache(folio))) {
+		if (likely(folio)) {
 			folio->private = NULL;
 			folio_clear_private(folio);
 			clear_bit(PG_MAPPED, &req->wb_head->wb_flags);
@@ -803,38 +755,6 @@ static void nfs_mark_request_dirty(struct nfs_page *req)
 		filemap_dirty_folio(folio_mapping(folio), folio);
 }
 
-/*
- * nfs_page_search_commits_for_head_request_locked
- *
- * Search through commit lists on @inode for the head request for @folio.
- * Must be called while holding the inode (which is cinfo) lock.
- *
- * Returns the head request if found, or NULL if not found.
- */
-static struct nfs_page *
-nfs_page_search_commits_for_head_request_locked(struct nfs_inode *nfsi,
-						struct folio *folio)
-{
-	struct nfs_page *freq, *t;
-	struct nfs_commit_info cinfo;
-	struct inode *inode = &nfsi->vfs_inode;
-
-	nfs_init_cinfo_from_inode(&cinfo, inode);
-
-	/* search through pnfs commit lists */
-	freq = pnfs_search_commit_reqs(inode, &cinfo, folio);
-	if (freq)
-		return freq->wb_head;
-
-	/* Linearly search the commit list for the correct request */
-	list_for_each_entry_safe(freq, t, &cinfo.mds->list, wb_list) {
-		if (nfs_page_to_folio(freq) == folio)
-			return freq->wb_head;
-	}
-
-	return NULL;
-}
-
 /**
  * nfs_request_add_commit_list_locked - add request to a commit list
  * @req: pointer to a struct nfs_page
@@ -941,7 +861,7 @@ static void nfs_folio_clear_commit(struct folio *folio)
 		long nr = folio_nr_pages(folio);
 
 		node_stat_mod_folio(folio, NR_WRITEBACK, -nr);
-		wb_stat_mod(&inode_to_bdi(folio_file_mapping(folio)->host)->wb,
+		wb_stat_mod(&inode_to_bdi(folio->mapping->host)->wb,
 			    WB_WRITEBACK, -nr);
 	}
 }
@@ -1126,7 +1046,7 @@ static struct nfs_page *nfs_try_to_update_request(struct folio *folio,
 	 */
 	nfs_mark_request_dirty(req);
 	nfs_unlock_and_release_request(req);
-	error = nfs_wb_folio(folio_file_mapping(folio)->host, folio);
+	error = nfs_wb_folio(folio->mapping->host, folio);
 	return (error < 0) ? ERR_PTR(error) : NULL;
 }
 
@@ -1202,7 +1122,7 @@ int nfs_flush_incompatible(struct file *file, struct folio *folio)
 		nfs_release_request(req);
 		if (!do_flush)
 			return 0;
-		status = nfs_wb_folio(folio_file_mapping(folio)->host, folio);
+		status = nfs_wb_folio(folio->mapping->host, folio);
 	} while (status == 0);
 	return status;
 }
@@ -1276,7 +1196,7 @@ bool nfs_ctx_key_to_expire(struct nfs_open_context *ctx, struct inode *inode)
  */
 static bool nfs_folio_write_uptodate(struct folio *folio, unsigned int pagelen)
 {
-	struct inode *inode = folio_file_mapping(folio)->host;
+	struct inode *inode = folio->mapping->host;
 	struct nfs_inode *nfsi = NFS_I(inode);
 
 	if (nfs_have_delegated_attributes(inode))
@@ -1354,7 +1274,7 @@ int nfs_update_folio(struct file *file, struct folio *folio,
 		     unsigned int offset, unsigned int count)
 {
 	struct nfs_open_context *ctx = nfs_file_open_context(file);
-	struct address_space *mapping = folio_file_mapping(folio);
+	struct address_space *mapping = folio->mapping;
 	struct inode *inode = mapping->host;
 	unsigned int pagelen = nfs_folio_length(folio);
 	int		status = 0;
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 1c315f854ea801..7bc31df457ea58 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -208,8 +208,8 @@ static inline struct inode *nfs_page_to_inode(const struct nfs_page *req)
 	struct folio *folio = nfs_page_to_folio(req);
 
 	if (folio == NULL)
-		return page_file_mapping(req->wb_page)->host;
-	return folio_file_mapping(folio)->host;
+		return req->wb_page->mapping->host;
+	return folio->mapping->host;
 }
 
 /**
-- 
2.43.0


