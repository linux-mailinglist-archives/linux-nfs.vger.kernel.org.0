Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970894977D9
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 04:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbiAXDwJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 Jan 2022 22:52:09 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46932 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241187AbiAXDwI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 Jan 2022 22:52:08 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2EED41F3B1;
        Mon, 24 Jan 2022 03:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642996327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hXM27Ktz0q7GrqgI86euZLVhJuAWozKSUgPAu9ALmpc=;
        b=u9i5KjaF6Cn4C7Alxy2UjJlqk65gob4QWaDmCWNlnT1O4xjgGA+Z3KaH6ZGLjw6ZMxg2QY
        4qRdEQqZYJLT4JlCjLnqSzYy626J3zS783DwTjolcktJzNbfRqKX7Os4zCsqJ09CoJF4O6
        2EYKf06c+qUdHdjMGtxkaibGjoRviEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642996327;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hXM27Ktz0q7GrqgI86euZLVhJuAWozKSUgPAu9ALmpc=;
        b=wkiiDO1OlmC/xnDFA1Jecbo9BhxrJEP6/taW6KXQ22Ol8DMlaOkgSXO1Q8SQriumxjjhd3
        5wuO9Iykg35+76Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F74E13305;
        Mon, 24 Jan 2022 03:52:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yE+5N2Ei7mFCRQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 24 Jan 2022 03:52:01 +0000
Subject: [PATCH 09/23] MM: submit multipage reads for SWP_FS_OPS swap-space
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Jan 2022 14:48:32 +1100
Message-ID: <164299611278.26253.14950274629759580371.stgit@noble.brown>
In-Reply-To: <164299573337.26253.7538614611220034049.stgit@noble.brown>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

swap_readpage() is given one page at a time, but maybe called repeatedly
in succession.
For block-device swapspace, the blk_plug functionality allows the
multiple pages to be combined together at lower layers.
That cannot be used for SWP_FS_OPS as blk_plug may not exist - it is
only active when CONFIG_BLOCK=y.  Consequently all swap reads over NFS
are single page reads.

With this patch we pass in a pointer-to-pointer when swap_readpage can
store state between calls - much like the effect of blk_plug.  After
calling swap_readpage() some number of times, the state will be passed
to swap_read_unplug() which can submit the combined request.

Some caller currently call blk_finish_plug() *before* the final call to
swap_readpage(), so the last page cannot be included.  This patch moves
blk_finish_plug() to after the last call, and calls swap_read_unplug()
there too.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 mm/madvise.c    |    8 +++-
 mm/memory.c     |    2 +
 mm/page_io.c    |  102 +++++++++++++++++++++++++++++++++++--------------------
 mm/swap.h       |   16 +++++++--
 mm/swap_state.c |   19 +++++++---
 5 files changed, 98 insertions(+), 49 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 1ee4b7583379..2b1ab30af141 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -225,6 +225,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 	pte_t *orig_pte;
 	struct vm_area_struct *vma = walk->private;
 	unsigned long index;
+	struct swap_iocb *splug = NULL;
 
 	if (pmd_none_or_trans_huge_or_clear_bad(pmd))
 		return 0;
@@ -246,10 +247,11 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 			continue;
 
 		page = read_swap_cache_async(entry, GFP_HIGHUSER_MOVABLE,
-							vma, index, false);
+					     vma, index, false, &splug);
 		if (page)
 			put_page(page);
 	}
+	swap_read_unplug(splug);
 
 	return 0;
 }
@@ -265,6 +267,7 @@ static void force_shm_swapin_readahead(struct vm_area_struct *vma,
 	XA_STATE(xas, &mapping->i_pages, linear_page_index(vma, start));
 	pgoff_t end_index = linear_page_index(vma, end + PAGE_SIZE - 1);
 	struct page *page;
+	struct swap_iocb *splug = NULL;
 
 	rcu_read_lock();
 	xas_for_each(&xas, page, end_index) {
@@ -277,13 +280,14 @@ static void force_shm_swapin_readahead(struct vm_area_struct *vma,
 
 		swap = radix_to_swp_entry(page);
 		page = read_swap_cache_async(swap, GFP_HIGHUSER_MOVABLE,
-							NULL, 0, false);
+					     NULL, 0, false, &splug);
 		if (page)
 			put_page(page);
 
 		rcu_read_lock();
 	}
 	rcu_read_unlock();
+	swap_read_unplug(splug);
 
 	lru_add_drain();	/* Push any new pages onto the LRU now */
 }
diff --git a/mm/memory.c b/mm/memory.c
index d25372340107..8bd18c54eaa4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3559,7 +3559,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 				/* To provide entry to swap_readpage() */
 				set_page_private(page, entry.val);
-				swap_readpage(page, true);
+				swap_readpage(page, true, NULL);
 				set_page_private(page, 0);
 			}
 		} else {
diff --git a/mm/page_io.c b/mm/page_io.c
index 6e32ca35d9b6..bcf655d650c8 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -286,7 +286,8 @@ static void bio_associate_blkg_from_page(struct bio *bio, struct page *page)
 
 struct swap_iocb {
 	struct kiocb		iocb;
-	struct bio_vec		bvec;
+	struct bio_vec		bvec[SWAP_CLUSTER_MAX];
+	int			pages;
 };
 static mempool_t *sio_pool;
 
@@ -306,7 +307,7 @@ int sio_pool_init(void)
 static void sio_write_complete(struct kiocb *iocb, long ret)
 {
 	struct swap_iocb *sio = container_of(iocb, struct swap_iocb, iocb);
-	struct page *page = sio->bvec.bv_page;
+	struct page *page = sio->bvec[0].bv_page;
 
 	if (ret != 0 && ret != PAGE_SIZE) {
 		/*
@@ -344,10 +345,10 @@ static int swap_writepage_fs(struct page *page, struct writeback_control *wbc)
 	init_sync_kiocb(&sio->iocb, swap_file);
 	sio->iocb.ki_complete = sio_write_complete;
 	sio->iocb.ki_pos = page_file_offset(page);
-	sio->bvec.bv_page = page;
-	sio->bvec.bv_len = PAGE_SIZE;
-	sio->bvec.bv_offset = 0;
-	iov_iter_bvec(&from, WRITE, &sio->bvec, 1, PAGE_SIZE);
+	sio->bvec[0].bv_page = page;
+	sio->bvec[0].bv_len = PAGE_SIZE;
+	sio->bvec[0].bv_offset = 0;
+	iov_iter_bvec(&from, WRITE, &sio->bvec[0], 1, PAGE_SIZE);
 	ret = mapping->a_ops->swap_rw(&sio->iocb, &from);
 	if (ret != -EIOCBQUEUED)
 		sio_write_complete(&sio->iocb, ret);
@@ -390,46 +391,60 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 static void sio_read_complete(struct kiocb *iocb, long ret)
 {
 	struct swap_iocb *sio = container_of(iocb, struct swap_iocb, iocb);
-	struct page *page = sio->bvec.bv_page;
-
-	if (ret != 0 && ret != PAGE_SIZE) {
-		SetPageError(page);
-		ClearPageUptodate(page);
-		pr_alert_ratelimited("Read-error on swap-device\n");
-	} else {
-		SetPageUptodate(page);
-		count_vm_event(PSWPIN);
+	int p;
+
+	for (p = 0; p < sio->pages; p++) {
+		struct page *page = sio->bvec[p].bv_page;
+		if (ret != 0 && ret != PAGE_SIZE * sio->pages) {
+			SetPageError(page);
+			ClearPageUptodate(page);
+			pr_alert_ratelimited("Read-error on swap-device\n");
+		} else {
+			SetPageUptodate(page);
+			count_vm_event(PSWPIN);
+		}
+		unlock_page(page);
 	}
-	unlock_page(page);
 	mempool_free(sio, sio_pool);
 }
 
-static int swap_readpage_fs(struct page *page)
+static void swap_readpage_fs(struct page *page,
+			     struct swap_iocb **plug)
 {
 	struct swap_info_struct *sis = page_swap_info(page);
-	struct file *swap_file = sis->swap_file;
-	struct address_space *mapping = swap_file->f_mapping;
-	struct iov_iter from;
-	struct swap_iocb *sio;
+	struct swap_iocb *sio = NULL;
 	loff_t pos = page_file_offset(page);
-	int ret;
-
-	sio = mempool_alloc(sio_pool, GFP_KERNEL);
-	init_sync_kiocb(&sio->iocb, swap_file);
-	sio->iocb.ki_pos = pos;
-	sio->iocb.ki_complete = sio_read_complete;
-	sio->bvec.bv_page = page;
-	sio->bvec.bv_len = PAGE_SIZE;
-	sio->bvec.bv_offset = 0;
 
-	iov_iter_bvec(&from, READ, &sio->bvec, 1, PAGE_SIZE);
-	ret = mapping->a_ops->swap_rw(&sio->iocb, &from);
-	if (ret != -EIOCBQUEUED)
-		sio_read_complete(&sio->iocb, ret);
-	return ret;
+	if (*plug)
+		sio = *plug;
+	if (sio) {
+		if (sio->iocb.ki_filp != sis->swap_file ||
+		    sio->iocb.ki_pos + sio->pages * PAGE_SIZE != pos) {
+			swap_read_unplug(sio);
+			sio = NULL;
+		}
+	}
+	if (!sio) {
+		sio = mempool_alloc(sio_pool, GFP_KERNEL);
+		init_sync_kiocb(&sio->iocb, sis->swap_file);
+		sio->iocb.ki_pos = pos;
+		sio->iocb.ki_complete = sio_read_complete;
+		sio->pages = 0;
+	}
+	sio->bvec[sio->pages].bv_page = page;
+	sio->bvec[sio->pages].bv_len = PAGE_SIZE;
+	sio->bvec[sio->pages].bv_offset = 0;
+	sio->pages += 1;
+	if (sio->pages == ARRAY_SIZE(sio->bvec) || !plug) {
+		swap_read_unplug(sio);
+		sio = NULL;
+	}
+	if (plug)
+		*plug = sio;
 }
 
-int swap_readpage(struct page *page, bool synchronous)
+int swap_readpage(struct page *page, bool synchronous,
+		  struct swap_iocb **plug)
 {
 	struct bio *bio;
 	int ret = 0;
@@ -455,7 +470,7 @@ int swap_readpage(struct page *page, bool synchronous)
 	}
 
 	if (data_race(sis->flags & SWP_FS_OPS)) {
-		ret = swap_readpage_fs(page);
+		swap_readpage_fs(page, plug);
 		goto out;
 	}
 
@@ -507,3 +522,16 @@ int swap_readpage(struct page *page, bool synchronous)
 	delayacct_swapin_end();
 	return ret;
 }
+
+void __swap_read_unplug(struct swap_iocb *sio)
+{
+	struct iov_iter from;
+	struct address_space *mapping = sio->iocb.ki_filp->f_mapping;
+	int ret;
+
+	iov_iter_bvec(&from, READ, sio->bvec, sio->pages,
+		      PAGE_SIZE * sio->pages);
+	ret = mapping->a_ops->swap_rw(&sio->iocb, &from);
+	if (ret != -EIOCBQUEUED)
+		sio_read_complete(&sio->iocb, ret);
+}
diff --git a/mm/swap.h b/mm/swap.h
index e8ee995cf8d8..0c79b2478f3f 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -4,7 +4,15 @@
 
 /* linux/mm/page_io.c */
 int sio_pool_init(void);
-int swap_readpage(struct page *page, bool do_poll);
+struct swap_iocb;
+int swap_readpage(struct page *page, bool do_poll,
+		  struct swap_iocb **plug);
+void __swap_read_unplug(struct swap_iocb *plug);
+static inline void swap_read_unplug(struct swap_iocb *plug)
+{
+	if (unlikely(plug))
+		__swap_read_unplug(plug);
+}
 int swap_writepage(struct page *page, struct writeback_control *wbc);
 void end_swap_bio_write(struct bio *bio);
 int __swap_writepage(struct page *page, struct writeback_control *wbc,
@@ -38,7 +46,8 @@ struct page *find_get_incore_page(struct address_space *mapping, pgoff_t index);
 struct page *read_swap_cache_async(swp_entry_t, gfp_t,
 				   struct vm_area_struct *vma,
 				   unsigned long addr,
-				   bool do_poll);
+				   bool do_poll,
+				   struct swap_iocb **plug);
 struct page *__read_swap_cache_async(swp_entry_t, gfp_t,
 				     struct vm_area_struct *vma,
 				     unsigned long addr,
@@ -53,7 +62,8 @@ static inline unsigned int page_swap_flags(struct page *page)
 	return page_swap_info(page)->flags;
 }
 #else /* CONFIG_SWAP */
-static inline int swap_readpage(struct page *page, bool do_poll)
+static inline int swap_readpage(struct page *page, bool do_poll,
+				struct swap_iocb **plug);
 {
 	return 0;
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index d541594be1c3..5cb2c75fa247 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -520,14 +520,16 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
  * the swap entry is no longer in use.
  */
 struct page *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
-		struct vm_area_struct *vma, unsigned long addr, bool do_poll)
+				   struct vm_area_struct *vma,
+				   unsigned long addr, bool do_poll,
+				   struct swap_iocb **plug)
 {
 	bool page_was_allocated;
 	struct page *retpage = __read_swap_cache_async(entry, gfp_mask,
 			vma, addr, &page_was_allocated);
 
 	if (page_was_allocated)
-		swap_readpage(retpage, do_poll);
+		swap_readpage(retpage, do_poll, plug);
 
 	return retpage;
 }
@@ -621,6 +623,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	unsigned long mask;
 	struct swap_info_struct *si = swp_swap_info(entry);
 	struct blk_plug plug;
+	struct swap_iocb *splug = NULL;
 	bool do_poll = true, page_allocated;
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long addr = vmf->address;
@@ -647,7 +650,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 		if (!page)
 			continue;
 		if (page_allocated) {
-			swap_readpage(page, false);
+			swap_readpage(page, false, &splug);
 			if (offset != entry_offset) {
 				SetPageReadahead(page);
 				count_vm_event(SWAP_RA);
@@ -658,8 +661,10 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 
 	lru_add_drain();	/* Push any new pages onto the LRU now */
 skip:
-	page = read_swap_cache_async(entry, gfp_mask, vma, addr, do_poll);
+	page = read_swap_cache_async(entry, gfp_mask, vma, addr, do_poll,
+				     &splug);
 	blk_finish_plug(&plug);
+	swap_read_unplug(splug);
 	return page;
 }
 
@@ -791,6 +796,7 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 				       struct vm_fault *vmf)
 {
 	struct blk_plug plug;
+	struct swap_iocb *splug = NULL;
 	struct vm_area_struct *vma = vmf->vma;
 	struct page *page;
 	pte_t *pte, pentry;
@@ -821,7 +827,7 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 		if (!page)
 			continue;
 		if (page_allocated) {
-			swap_readpage(page, false);
+			swap_readpage(page, false, &splug);
 			if (i != ra_info.offset) {
 				SetPageReadahead(page);
 				count_vm_event(SWAP_RA);
@@ -832,8 +838,9 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 	lru_add_drain();
 skip:
 	page = read_swap_cache_async(fentry, gfp_mask, vma, vmf->address,
-				     ra_info.win == 1);
+				     ra_info.win == 1, &splug);
 	blk_finish_plug(&plug);
+	swap_read_unplug(splug);
 	return page;
 }
 


