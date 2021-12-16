Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E73C4780E2
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 00:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhLPXw6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Dec 2021 18:52:58 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47116 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhLPXw5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Dec 2021 18:52:57 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A2DE7210F3;
        Thu, 16 Dec 2021 23:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639698776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=67KP7naJ3z7jU42SdmmKmZdeiUNB4x0cSuduIliqibk=;
        b=nq5IUzzHkhy9FvG8LMFqnuULQenxkPt3HSQ+PMaHf/CyZYj7tAcyVYT+ZpvjJ2iMVzzv7Q
        dvf6IDowMCdLs75Rzcq6HFsD1jt6hsnjwGvhSj2piud2DoVod2sDrsKFYgyjNm5+7td6OD
        FEeuiHIEBdI/dY9eFciXfOvfQ7uL+MI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639698776;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=67KP7naJ3z7jU42SdmmKmZdeiUNB4x0cSuduIliqibk=;
        b=NIFK0xMtiWHeN6asvz18UmH/0zQq9jvQzE495dU0e7PeoFtGDQF/Y7NziupPqyQfG5x90N
        VxS/K9E6fBbJebDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 341ED13EFD;
        Thu, 16 Dec 2021 23:52:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7dOJN1TRu2F2WwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 16 Dec 2021 23:52:52 +0000
Subject: [PATCH 06/18] MM: submit multipage reads for SWP_FS_OPS swap-space
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
Date:   Fri, 17 Dec 2021 10:48:22 +1100
Message-ID: <163969850296.20885.16043920355602134308.stgit@noble.brown>
In-Reply-To: <163969801519.20885.3977673503103544412.stgit@noble.brown>
References: <163969801519.20885.3977673503103544412.stgit@noble.brown>
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
 mm/madvise.c    |    8 +++--
 mm/memory.c     |    2 +
 mm/page_io.c    |   95 ++++++++++++++++++++++++++++++++++++-------------------
 mm/swap.h       |   13 ++++++--
 mm/swap_state.c |   31 ++++++++++++------
 5 files changed, 100 insertions(+), 49 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 724470773582..a90870c7a2df 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -191,6 +191,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 	pte_t *orig_pte;
 	struct vm_area_struct *vma = walk->private;
 	unsigned long index;
+	struct swap_iocb *splug = NULL;
 
 	if (pmd_none_or_trans_huge_or_clear_bad(pmd))
 		return 0;
@@ -212,10 +213,11 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
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
@@ -231,6 +233,7 @@ static void force_shm_swapin_readahead(struct vm_area_struct *vma,
 	XA_STATE(xas, &mapping->i_pages, linear_page_index(vma, start));
 	pgoff_t end_index = linear_page_index(vma, end + PAGE_SIZE - 1);
 	struct page *page;
+	struct swap_iocb *splug = NULL;
 
 	rcu_read_lock();
 	xas_for_each(&xas, page, end_index) {
@@ -243,13 +246,14 @@ static void force_shm_swapin_readahead(struct vm_area_struct *vma,
 
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
index 80bbfd449b40..0ca00f2a6890 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3538,7 +3538,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 				/* To provide entry to swap_readpage() */
 				set_page_private(page, entry.val);
-				swap_readpage(page, true);
+				swap_readpage(page, true, NULL);
 				set_page_private(page, 0);
 			}
 		} else {
diff --git a/mm/page_io.c b/mm/page_io.c
index 84859132c9c6..03fbf9463081 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -285,7 +285,8 @@ static void bio_associate_blkg_from_page(struct bio *bio, struct page *page)
 
 struct swap_iocb {
 	struct kiocb		iocb;
-	struct bio_vec		bvec;
+	struct bio_vec		bvec[SWAP_CLUSTER_MAX];
+	int			pages;
 };
 static mempool_t *sio_pool;
 
@@ -303,7 +304,7 @@ int sio_pool_init(void)
 static void sio_write_complete(struct kiocb *iocb, long ret)
 {
 	struct swap_iocb *sio = container_of(iocb, struct swap_iocb, iocb);
-	struct page *page = sio->bvec.bv_page;
+	struct page *page = sio->bvec[0].bv_page;
 
 	if (ret != 0 && ret != PAGE_SIZE) {
 		/*
@@ -346,10 +347,10 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		init_sync_kiocb(&sio->iocb, swap_file);
 		sio->iocb.ki_complete = sio_write_complete;
 		sio->iocb.ki_pos = page_file_offset(page);
-		sio->bvec.bv_page = page;
-		sio->bvec.bv_len = PAGE_SIZE;
-		sio->bvec.bv_offset = 0;
-		iov_iter_bvec(&from, WRITE, &sio->bvec, 1, PAGE_SIZE);
+		sio->bvec[0].bv_page = page;
+		sio->bvec[0].bv_len = PAGE_SIZE;
+		sio->bvec[0].bv_offset = 0;
+		iov_iter_bvec(&from, WRITE, &sio->bvec[0], 1, PAGE_SIZE);
 		ret = mapping->a_ops->swap_rw(&sio->iocb, &from);
 		if (ret != -EIOCBQUEUED)
 			sio_write_complete(&sio->iocb, ret);
@@ -382,21 +383,25 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
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
 
-int swap_readpage(struct page *page, bool synchronous)
+int swap_readpage(struct page *page, bool synchronous,
+		  struct swap_iocb **plug)
 {
 	struct bio *bio;
 	int ret = 0;
@@ -421,24 +426,35 @@ int swap_readpage(struct page *page, bool synchronous)
 	}
 
 	if (data_race(sis->flags & SWP_FS_OPS)) {
-		struct file *swap_file = sis->swap_file;
-		struct address_space *mapping = swap_file->f_mapping;
-		struct iov_iter from;
-		struct swap_iocb *sio;
+		struct swap_iocb *sio = NULL;
 		loff_t pos = page_file_offset(page);
 
-		sio = mempool_alloc(sio_pool, GFP_KERNEL);
-		init_sync_kiocb(&sio->iocb, swap_file);
-		sio->iocb.ki_pos = pos;
-		sio->iocb.ki_complete = sio_read_complete;
-		sio->bvec.bv_page = page;
-		sio->bvec.bv_len = PAGE_SIZE;
-		sio->bvec.bv_offset = 0;
-
-		iov_iter_bvec(&from, READ, &sio->bvec, 1, PAGE_SIZE);
-		ret = mapping->a_ops->swap_rw(&sio->iocb, &from);
-		if (ret != -EIOCBQUEUED)
-			sio_read_complete(&sio->iocb, ret);
+		if (*plug)
+			sio = *plug;
+		if (sio) {
+			if (sio->iocb.ki_filp != sis->swap_file ||
+			    sio->iocb.ki_pos + sio->pages * PAGE_SIZE != pos) {
+				swap_read_unplug(sio);
+				sio = NULL;
+			}
+		}
+		if (!sio) {
+			sio = mempool_alloc(sio_pool, GFP_KERNEL);
+			init_sync_kiocb(&sio->iocb, sis->swap_file);
+			sio->iocb.ki_pos = pos;
+			sio->iocb.ki_complete = sio_read_complete;
+			sio->pages = 0;
+		}
+		sio->bvec[sio->pages].bv_page = page;
+		sio->bvec[sio->pages].bv_len = PAGE_SIZE;
+		sio->bvec[sio->pages].bv_offset = 0;
+		sio->pages += 1;
+		if (sio->pages == ARRAY_SIZE(sio->bvec) || !plug) {
+			swap_read_unplug(sio);
+			sio = NULL;
+		}
+		if (plug)
+			*plug = sio;
 
 		goto out;
 	}
@@ -490,3 +506,16 @@ int swap_readpage(struct page *page, bool synchronous)
 	psi_memstall_leave(&pflags);
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
index 128a1d3e5558..ce967abc5f46 100644
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
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 514b86b05488..5cb2c75fa247 100644
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
@@ -621,10 +623,12 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	unsigned long mask;
 	struct swap_info_struct *si = swp_swap_info(entry);
 	struct blk_plug plug;
+	struct swap_iocb *splug = NULL;
 	bool do_poll = true, page_allocated;
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long addr = vmf->address;
 
+	blk_start_plug(&plug);
 	mask = swapin_nr_pages(offset) - 1;
 	if (!mask)
 		goto skip;
@@ -638,7 +642,6 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	if (end_offset >= si->max)
 		end_offset = si->max - 1;
 
-	blk_start_plug(&plug);
 	for (offset = start_offset; offset <= end_offset ; offset++) {
 		/* Ok, do the async read-ahead now */
 		page = __read_swap_cache_async(
@@ -647,7 +650,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 		if (!page)
 			continue;
 		if (page_allocated) {
-			swap_readpage(page, false);
+			swap_readpage(page, false, &splug);
 			if (offset != entry_offset) {
 				SetPageReadahead(page);
 				count_vm_event(SWAP_RA);
@@ -655,11 +658,14 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 		}
 		put_page(page);
 	}
-	blk_finish_plug(&plug);
 
 	lru_add_drain();	/* Push any new pages onto the LRU now */
 skip:
-	return read_swap_cache_async(entry, gfp_mask, vma, addr, do_poll);
+	page = read_swap_cache_async(entry, gfp_mask, vma, addr, do_poll,
+				     &splug);
+	blk_finish_plug(&plug);
+	swap_read_unplug(splug);
+	return page;
 }
 
 int init_swap_address_space(unsigned int type, unsigned long nr_pages)
@@ -790,6 +796,7 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 				       struct vm_fault *vmf)
 {
 	struct blk_plug plug;
+	struct swap_iocb *splug = NULL;
 	struct vm_area_struct *vma = vmf->vma;
 	struct page *page;
 	pte_t *pte, pentry;
@@ -800,11 +807,11 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 		.win = 1,
 	};
 
+	blk_start_plug(&plug);
 	swap_ra_info(vmf, &ra_info);
 	if (ra_info.win == 1)
 		goto skip;
 
-	blk_start_plug(&plug);
 	for (i = 0, pte = ra_info.ptes; i < ra_info.nr_pte;
 	     i++, pte++) {
 		pentry = *pte;
@@ -820,7 +827,7 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 		if (!page)
 			continue;
 		if (page_allocated) {
-			swap_readpage(page, false);
+			swap_readpage(page, false, &splug);
 			if (i != ra_info.offset) {
 				SetPageReadahead(page);
 				count_vm_event(SWAP_RA);
@@ -828,11 +835,13 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 		}
 		put_page(page);
 	}
-	blk_finish_plug(&plug);
 	lru_add_drain();
 skip:
-	return read_swap_cache_async(fentry, gfp_mask, vma, vmf->address,
-				     ra_info.win == 1);
+	page = read_swap_cache_async(fentry, gfp_mask, vma, vmf->address,
+				     ra_info.win == 1, &splug);
+	blk_finish_plug(&plug);
+	swap_read_unplug(splug);
+	return page;
 }
 
 /**


