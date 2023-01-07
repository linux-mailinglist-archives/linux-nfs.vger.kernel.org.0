Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB726610A5
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Jan 2023 18:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjAGRmW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Jan 2023 12:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbjAGRmR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 7 Jan 2023 12:42:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513941C912
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 09:42:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EBF2B803F3
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 17:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B0CC43392
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 17:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673113332;
        bh=iC5iJ813/JQXXGsiFfoY63Sre2gF3/2UAfWfM4qknHE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PlJZA5+XRWmprFVqfb0wEcUWHNGnFVMimwtHRDNW0wwXNJu0p5HV82+NFb6Wq2MJE
         se7pHnLUpt9G2BgzKhmh1QOtzp8Ua7dBdnArUKJLsArEb+uPLnP7vVUi11yxxhkikR
         GBC7RQ+e2tORnkeoyJADSv5b152KGPU40Pb/QTkKMi0I7Ta2+pOEdURrEFiSyUFOkL
         SBGZc6BVmAivMKMk9hOAUjpgPaiB5YoC37F+rWG396+SW3KFdqmF6wmHhCbUP5dicv
         3VyjVR6omhryeO1FP/ujr8WJK8TrFlQnJ6epqLMocFNkD/1jAvOxEWi706301TmY+p
         OkKtiEMXrL2Vg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 12/17] NFS: Convert nfs_write_begin/end to use folios
Date:   Sat,  7 Jan 2023 12:36:30 -0500
Message-Id: <20230107173635.2025233-13-trondmy@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230107173635.2025233-12-trondmy@kernel.org>
References: <20230107173635.2025233-1-trondmy@kernel.org>
 <20230107173635.2025233-2-trondmy@kernel.org>
 <20230107173635.2025233-3-trondmy@kernel.org>
 <20230107173635.2025233-4-trondmy@kernel.org>
 <20230107173635.2025233-5-trondmy@kernel.org>
 <20230107173635.2025233-6-trondmy@kernel.org>
 <20230107173635.2025233-7-trondmy@kernel.org>
 <20230107173635.2025233-8-trondmy@kernel.org>
 <20230107173635.2025233-9-trondmy@kernel.org>
 <20230107173635.2025233-10-trondmy@kernel.org>
 <20230107173635.2025233-11-trondmy@kernel.org>
 <20230107173635.2025233-12-trondmy@kernel.org>
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
 fs/nfs/file.c | 75 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 34 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 9fbe27214da0..39ee7fb3f79f 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -276,27 +276,28 @@ EXPORT_SYMBOL_GPL(nfs_file_fsync);
  * and that the new data won't completely replace the old data in
  * that range of the file.
  */
-static bool nfs_full_page_write(struct page *page, loff_t pos, unsigned int len)
+static bool nfs_folio_is_full_write(struct folio *folio, loff_t pos,
+				    unsigned int len)
 {
-	unsigned int pglen = nfs_page_length(page);
-	unsigned int offset = pos & (PAGE_SIZE - 1);
+	unsigned int pglen = nfs_folio_length(folio);
+	unsigned int offset = offset_in_folio(folio, pos);
 	unsigned int end = offset + len;
 
 	return !pglen || (end >= pglen && !offset);
 }
 
-static bool nfs_want_read_modify_write(struct file *file, struct page *page,
-			loff_t pos, unsigned int len)
+static bool nfs_want_read_modify_write(struct file *file, struct folio *folio,
+				       loff_t pos, unsigned int len)
 {
 	/*
 	 * Up-to-date pages, those with ongoing or full-page write
 	 * don't need read/modify/write
 	 */
-	if (PageUptodate(page) || PagePrivate(page) ||
-	    nfs_full_page_write(page, pos, len))
+	if (folio_test_uptodate(folio) || folio_test_private(folio) ||
+	    nfs_folio_is_full_write(folio, pos, len))
 		return false;
 
-	if (pnfs_ld_read_whole_page(file->f_mapping->host))
+	if (pnfs_ld_read_whole_page(file_inode(file)))
 		return true;
 	/* Open for reading too? */
 	if (file->f_mode & FMODE_READ)
@@ -304,6 +305,15 @@ static bool nfs_want_read_modify_write(struct file *file, struct page *page,
 	return false;
 }
 
+static struct folio *
+nfs_folio_grab_cache_write_begin(struct address_space *mapping, pgoff_t index)
+{
+	unsigned fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE;
+
+	return __filemap_get_folio(mapping, index, fgp_flags,
+				   mapping_gfp_mask(mapping));
+}
+
 /*
  * This does the "real" work of the write. We must allocate and lock the
  * page to be sent back to the generic routine, which then copies the
@@ -313,34 +323,31 @@ static bool nfs_want_read_modify_write(struct file *file, struct page *page,
  * increment the page use counts until he is done with the page.
  */
 static int nfs_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len,
-			struct page **pagep, void **fsdata)
+			   loff_t pos, unsigned len, struct page **pagep,
+			   void **fsdata)
 {
-	int ret;
-	pgoff_t index = pos >> PAGE_SHIFT;
-	struct page *page;
 	struct folio *folio;
 	int once_thru = 0;
+	int ret;
 
 	dfprintk(PAGECACHE, "NFS: write_begin(%pD2(%lu), %u@%lld)\n",
 		file, mapping->host->i_ino, len, (long long) pos);
 
 start:
-	page = grab_cache_page_write_begin(mapping, index);
-	if (!page)
+	folio = nfs_folio_grab_cache_write_begin(mapping, pos >> PAGE_SHIFT);
+	if (!folio)
 		return -ENOMEM;
-	*pagep = page;
-	folio = page_folio(page);
+	*pagep = &folio->page;
 
 	ret = nfs_flush_incompatible(file, folio);
 	if (ret) {
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 	} else if (!once_thru &&
-		   nfs_want_read_modify_write(file, page, pos, len)) {
+		   nfs_want_read_modify_write(file, folio, pos, len)) {
 		once_thru = 1;
 		ret = nfs_read_folio(file, folio);
-		put_page(page);
+		folio_put(folio);
 		if (!ret)
 			goto start;
 	}
@@ -348,12 +355,12 @@ static int nfs_write_begin(struct file *file, struct address_space *mapping,
 }
 
 static int nfs_write_end(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned copied,
-			struct page *page, void *fsdata)
+			 loff_t pos, unsigned len, unsigned copied,
+			 struct page *page, void *fsdata)
 {
-	unsigned offset = pos & (PAGE_SIZE - 1);
 	struct nfs_open_context *ctx = nfs_file_open_context(file);
 	struct folio *folio = page_folio(page);
+	unsigned offset = offset_in_folio(folio, pos);
 	int status;
 
 	dfprintk(PAGECACHE, "NFS: write_end(%pD2(%lu), %u@%lld)\n",
@@ -363,26 +370,26 @@ static int nfs_write_end(struct file *file, struct address_space *mapping,
 	 * Zero any uninitialised parts of the page, and then mark the page
 	 * as up to date if it turns out that we're extending the file.
 	 */
-	if (!PageUptodate(page)) {
-		unsigned pglen = nfs_page_length(page);
+	if (!folio_test_uptodate(folio)) {
+		size_t fsize = folio_size(folio);
+		unsigned pglen = nfs_folio_length(folio);
 		unsigned end = offset + copied;
 
 		if (pglen == 0) {
-			zero_user_segments(page, 0, offset,
-					end, PAGE_SIZE);
-			SetPageUptodate(page);
+			folio_zero_segments(folio, 0, offset, end, fsize);
+			folio_mark_uptodate(folio);
 		} else if (end >= pglen) {
-			zero_user_segment(page, end, PAGE_SIZE);
+			folio_zero_segment(folio, end, fsize);
 			if (offset == 0)
-				SetPageUptodate(page);
+				folio_mark_uptodate(folio);
 		} else
-			zero_user_segment(page, pglen, PAGE_SIZE);
+			folio_zero_segment(folio, pglen, fsize);
 	}
 
 	status = nfs_update_folio(file, folio, offset, copied);
 
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 
 	if (status < 0)
 		return status;
-- 
2.39.0

