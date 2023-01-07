Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F02166109E
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Jan 2023 18:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjAGRmQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Jan 2023 12:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjAGRmP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 7 Jan 2023 12:42:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E0D2DF
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 09:42:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41954B801C0
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 17:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B778CC433D2
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 17:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673113330;
        bh=HxU5bJ9ShusBQQbKB9jqKDt2ciK9mqnGOdyW6s0+l+8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MSXB+40J96Pudt0RyrlMaWTbOl9jKCQTpodKhjsegP7GRFfmzh5WwaTVhd9IwZmoC
         oshQjfcQI4flrXBIoCyjd8CpGLoxJQLW/PAqaAGh1kCljmFPZm2QsPHosveplKgEGe
         /Kc0Sa7FB5roXjx0WYp9QGHKGav1PAyogAenVlsvhO1etgBixaeCb5G9hqZIB6X6qo
         Q3yL28TAkIVePKi28yZxelJL+0GXtKQAfcwu4/PlThL5Mg7GPDPq4MzI417WgtAxaa
         SwYc6FStR6afP/mqVXOP5D1ds/7GD9k3L/irS/9iVIjv50zpYwjGPZyWtJQW4v9IdM
         K+vrKAu4CjvQw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 08/17] NFS: Convert buffered reads to use folios
Date:   Sat,  7 Jan 2023 12:36:26 -0500
Message-Id: <20230107173635.2025233-9-trondmy@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230107173635.2025233-8-trondmy@kernel.org>
References: <20230107173635.2025233-1-trondmy@kernel.org>
 <20230107173635.2025233-2-trondmy@kernel.org>
 <20230107173635.2025233-3-trondmy@kernel.org>
 <20230107173635.2025233-4-trondmy@kernel.org>
 <20230107173635.2025233-5-trondmy@kernel.org>
 <20230107173635.2025233-6-trondmy@kernel.org>
 <20230107173635.2025233-7-trondmy@kernel.org>
 <20230107173635.2025233-8-trondmy@kernel.org>
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

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/internal.h        | 18 +++++++++
 fs/nfs/nfstrace.h        | 12 +++---
 fs/nfs/pagelist.c        | 30 ++++++++++++++
 fs/nfs/read.c            | 86 ++++++++++++++++++++--------------------
 include/linux/nfs_page.h |  4 ++
 5 files changed, 100 insertions(+), 50 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 6197b165c8c8..529b87336ffa 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -794,6 +794,24 @@ unsigned int nfs_page_length(struct page *page)
 	return 0;
 }
 
+/*
+ * Determine the number of bytes of data the page contains
+ */
+static inline size_t nfs_folio_length(struct folio *folio)
+{
+	loff_t i_size = i_size_read(folio_file_mapping(folio)->host);
+
+	if (i_size > 0) {
+		pgoff_t index = folio_index(folio) >> folio_order(folio);
+		pgoff_t end_index = (i_size - 1) >> folio_shift(folio);
+		if (index < end_index)
+			return folio_size(folio);
+		if (index == end_index)
+			return offset_in_folio(folio, i_size - 1) + 1;
+	}
+	return 0;
+}
+
 /*
  * Convert a umode to a dirent->d_type
  */
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 8c6cc58679ff..d83226e45335 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -936,10 +936,10 @@ TRACE_EVENT(nfs_sillyrename_unlink,
 TRACE_EVENT(nfs_aop_readpage,
 		TP_PROTO(
 			const struct inode *inode,
-			struct page *page
+			struct folio *folio
 		),
 
-		TP_ARGS(inode, page),
+		TP_ARGS(inode, folio),
 
 		TP_STRUCT__entry(
 			__field(dev_t, dev)
@@ -956,7 +956,7 @@ TRACE_EVENT(nfs_aop_readpage,
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->version = inode_peek_iversion_raw(inode);
-			__entry->offset = page_index(page) << PAGE_SHIFT;
+			__entry->offset = folio_file_pos(folio);
 		),
 
 		TP_printk(
@@ -971,11 +971,11 @@ TRACE_EVENT(nfs_aop_readpage,
 TRACE_EVENT(nfs_aop_readpage_done,
 		TP_PROTO(
 			const struct inode *inode,
-			struct page *page,
+			struct folio *folio,
 			int ret
 		),
 
-		TP_ARGS(inode, page, ret),
+		TP_ARGS(inode, folio, ret),
 
 		TP_STRUCT__entry(
 			__field(dev_t, dev)
@@ -993,7 +993,7 @@ TRACE_EVENT(nfs_aop_readpage_done,
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->version = inode_peek_iversion_raw(inode);
-			__entry->offset = page_index(page) << PAGE_SHIFT;
+			__entry->offset = folio_file_pos(folio);
 			__entry->ret = ret;
 		),
 
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 520556d6bfe2..6706e0df1963 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -542,6 +542,36 @@ nfs_create_request(struct nfs_open_context *ctx, struct page *page,
 	return ret;
 }
 
+/**
+ * nfs_page_create_from_folio - Create an NFS read/write request.
+ * @ctx: open context to use
+ * @folio: folio to write
+ * @offset: starting offset within the folio for the write
+ * @count: number of bytes to read/write
+ *
+ * The page must be locked by the caller. This makes sure we never
+ * create two different requests for the same page.
+ * User should ensure it is safe to sleep in this function.
+ */
+struct nfs_page *nfs_page_create_from_folio(struct nfs_open_context *ctx,
+					    struct folio *folio,
+					    unsigned int offset,
+					    unsigned int count)
+{
+	struct nfs_lock_context *l_ctx = nfs_get_lock_context(ctx);
+	struct nfs_page *ret;
+
+	if (IS_ERR(l_ctx))
+		return ERR_CAST(l_ctx);
+	ret = nfs_page_create(l_ctx, offset, folio_index(folio), offset, count);
+	if (!IS_ERR(ret)) {
+		nfs_page_assign_folio(ret, folio);
+		nfs_page_group_init(ret, NULL);
+	}
+	nfs_put_lock_context(l_ctx);
+	return ret;
+}
+
 static struct nfs_page *
 nfs_create_subreq(struct nfs_page *req,
 		  unsigned int pgbase,
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 8ae2c8d1219d..bf4154f9b48c 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -49,12 +49,11 @@ static void nfs_readhdr_free(struct nfs_pgio_header *rhdr)
 	kmem_cache_free(nfs_rdata_cachep, rhdr);
 }
 
-static
-int nfs_return_empty_page(struct page *page)
+static int nfs_return_empty_folio(struct folio *folio)
 {
-	zero_user(page, 0, PAGE_SIZE);
-	SetPageUptodate(page);
-	unlock_page(page);
+	folio_zero_segment(folio, 0, folio_size(folio));
+	folio_mark_uptodate(folio);
+	folio_unlock(folio);
 	return 0;
 }
 
@@ -111,18 +110,18 @@ EXPORT_SYMBOL_GPL(nfs_pageio_reset_read_mds);
 static void nfs_readpage_release(struct nfs_page *req, int error)
 {
 	struct inode *inode = d_inode(nfs_req_openctx(req)->dentry);
-	struct page *page = req->wb_page;
+	struct folio *folio = nfs_page_to_folio(req);
 
 	dprintk("NFS: read done (%s/%llu %d@%lld)\n", inode->i_sb->s_id,
 		(unsigned long long)NFS_FILEID(inode), req->wb_bytes,
 		(long long)req_offset(req));
 
 	if (nfs_error_is_fatal_on_server(error) && error != -ETIMEDOUT)
-		SetPageError(page);
+		folio_set_error(folio);
 	if (nfs_page_group_sync_on_bit(req, PG_UNLOCKPAGE)) {
-		if (PageUptodate(page))
-			nfs_fscache_write_page(inode, page);
-		unlock_page(page);
+		if (folio_test_uptodate(folio))
+			nfs_fscache_write_page(inode, &folio->page);
+		folio_unlock(folio);
 	}
 	nfs_release_request(req);
 }
@@ -135,7 +134,7 @@ struct nfs_readdesc {
 static void nfs_page_group_set_uptodate(struct nfs_page *req)
 {
 	if (nfs_page_group_sync_on_bit(req, PG_UPTODATE))
-		SetPageUptodate(req->wb_page);
+		folio_mark_uptodate(nfs_page_to_folio(req));
 }
 
 static void nfs_read_completion(struct nfs_pgio_header *hdr)
@@ -147,7 +146,7 @@ static void nfs_read_completion(struct nfs_pgio_header *hdr)
 		goto out;
 	while (!list_empty(&hdr->pages)) {
 		struct nfs_page *req = nfs_list_entry(hdr->pages.next);
-		struct page *page = req->wb_page;
+		struct folio *folio = nfs_page_to_folio(req);
 		unsigned long start = req->wb_pgbase;
 		unsigned long end = req->wb_pgbase + req->wb_bytes;
 
@@ -157,14 +156,14 @@ static void nfs_read_completion(struct nfs_pgio_header *hdr)
 			if (bytes > hdr->good_bytes) {
 				/* nothing in this request was good, so zero
 				 * the full extent of the request */
-				zero_user_segment(page, start, end);
+				folio_zero_segment(folio, start, end);
 
 			} else if (hdr->good_bytes - bytes < req->wb_bytes) {
 				/* part of this request has good bytes, but
 				 * not all. zero the bad bytes */
 				start += hdr->good_bytes - bytes;
 				WARN_ON(start < req->wb_pgbase);
-				zero_user_segment(page, start, end);
+				folio_zero_segment(folio, start, end);
 			}
 		}
 		error = 0;
@@ -281,33 +280,34 @@ static void nfs_readpage_result(struct rpc_task *task,
 		nfs_readpage_retry(task, hdr);
 }
 
-static int
-readpage_async_filler(struct nfs_readdesc *desc, struct page *page)
+static int readpage_async_filler(struct nfs_readdesc *desc, struct folio *folio)
 {
-	struct inode *inode = page_file_mapping(page)->host;
-	unsigned int rsize = NFS_SERVER(inode)->rsize;
+	struct inode *inode = folio_file_mapping(folio)->host;
+	struct nfs_server *server = NFS_SERVER(inode);
+	size_t fsize = folio_size(folio);
+	unsigned int rsize = server->rsize;
 	struct nfs_page *new;
 	unsigned int len, aligned_len;
 	int error;
 
-	len = nfs_page_length(page);
+	len = nfs_folio_length(folio);
 	if (len == 0)
-		return nfs_return_empty_page(page);
+		return nfs_return_empty_folio(folio);
 
-	aligned_len = min_t(unsigned int, ALIGN(len, rsize), PAGE_SIZE);
+	aligned_len = min_t(unsigned int, ALIGN(len, rsize), fsize);
 
-	if (!IS_SYNC(page->mapping->host)) {
-		error = nfs_fscache_read_page(page->mapping->host, page);
+	if (!IS_SYNC(inode)) {
+		error = nfs_fscache_read_page(inode, &folio->page);
 		if (error == 0)
 			goto out_unlock;
 	}
 
-	new = nfs_create_request(desc->ctx, page, 0, aligned_len);
+	new = nfs_page_create_from_folio(desc->ctx, folio, 0, aligned_len);
 	if (IS_ERR(new))
 		goto out_error;
 
-	if (len < PAGE_SIZE)
-		zero_user_segment(page, len, PAGE_SIZE);
+	if (len < fsize)
+		folio_zero_segment(folio, len, fsize);
 	if (!nfs_pageio_add_request(&desc->pgio, new)) {
 		nfs_list_remove_request(new);
 		error = desc->pgio.pg_error;
@@ -318,7 +318,7 @@ readpage_async_filler(struct nfs_readdesc *desc, struct page *page)
 out_error:
 	error = PTR_ERR(new);
 out_unlock:
-	unlock_page(page);
+	folio_unlock(folio);
 out:
 	return error;
 }
@@ -331,25 +331,24 @@ readpage_async_filler(struct nfs_readdesc *desc, struct page *page)
  */
 int nfs_read_folio(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
 	struct nfs_readdesc desc;
-	struct inode *inode = page_file_mapping(page)->host;
+	struct inode *inode = file_inode(file);
 	int ret;
 
-	trace_nfs_aop_readpage(inode, page);
+	trace_nfs_aop_readpage(inode, folio);
 	nfs_inc_stats(inode, NFSIOS_VFSREADPAGE);
 
 	/*
 	 * Try to flush any pending writes to the file..
 	 *
-	 * NOTE! Because we own the page lock, there cannot
+	 * NOTE! Because we own the folio lock, there cannot
 	 * be any new pending writes generated at this point
-	 * for this page (other pages can be written to).
+	 * for this folio (other folios can be written to).
 	 */
-	ret = nfs_wb_page(inode, page);
+	ret = nfs_wb_folio(inode, folio);
 	if (ret)
 		goto out_unlock;
-	if (PageUptodate(page))
+	if (folio_test_uptodate(folio))
 		goto out_unlock;
 
 	ret = -ESTALE;
@@ -368,24 +367,24 @@ int nfs_read_folio(struct file *file, struct folio *folio)
 	nfs_pageio_init_read(&desc.pgio, inode, false,
 			     &nfs_async_read_completion_ops);
 
-	ret = readpage_async_filler(&desc, page);
+	ret = readpage_async_filler(&desc, folio);
 	if (ret)
 		goto out;
 
 	nfs_pageio_complete_read(&desc.pgio);
 	ret = desc.pgio.pg_error < 0 ? desc.pgio.pg_error : 0;
 	if (!ret) {
-		ret = wait_on_page_locked_killable(page);
-		if (!PageUptodate(page) && !ret)
+		ret = folio_wait_locked_killable(folio);
+		if (!folio_test_uptodate(folio) && !ret)
 			ret = xchg(&desc.ctx->error, 0);
 	}
 out:
 	put_nfs_open_context(desc.ctx);
-	trace_nfs_aop_readpage_done(inode, page, ret);
+	trace_nfs_aop_readpage_done(inode, folio, ret);
 	return ret;
 out_unlock:
-	unlock_page(page);
-	trace_nfs_aop_readpage_done(inode, page, ret);
+	folio_unlock(folio);
+	trace_nfs_aop_readpage_done(inode, folio, ret);
 	return ret;
 }
 
@@ -395,7 +394,7 @@ void nfs_readahead(struct readahead_control *ractl)
 	struct file *file = ractl->file;
 	struct nfs_readdesc desc;
 	struct inode *inode = ractl->mapping->host;
-	struct page *page;
+	struct folio *folio;
 	int ret;
 
 	trace_nfs_aop_readahead(inode, readahead_pos(ractl), nr_pages);
@@ -416,9 +415,8 @@ void nfs_readahead(struct readahead_control *ractl)
 	nfs_pageio_init_read(&desc.pgio, inode, false,
 			     &nfs_async_read_completion_ops);
 
-	while ((page = readahead_page(ractl)) != NULL) {
-		ret = readpage_async_filler(&desc, page);
-		put_page(page);
+	while ((folio = readahead_folio(ractl)) != NULL) {
+		ret = readpage_async_filler(&desc, folio);
 		if (ret)
 			break;
 	}
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index b0b03ec4a209..3c71493d5cc3 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -125,6 +125,10 @@ extern	struct nfs_page *nfs_create_request(struct nfs_open_context *ctx,
 					    struct page *page,
 					    unsigned int offset,
 					    unsigned int count);
+extern struct nfs_page *nfs_page_create_from_folio(struct nfs_open_context *ctx,
+						   struct folio *folio,
+						   unsigned int offset,
+						   unsigned int count);
 extern	void nfs_release_request(struct nfs_page *);
 
 
-- 
2.39.0

