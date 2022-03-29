Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DB14EB736
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Mar 2022 01:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241401AbiC2Xz2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Mar 2022 19:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241421AbiC2XzQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Mar 2022 19:55:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB1C2220E6;
        Tue, 29 Mar 2022 16:52:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6CEF2218F9;
        Tue, 29 Mar 2022 23:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648597953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tSXrVaD5DiGK3crhV7jd+q1J1Uq8L2v4rlku+hP3up4=;
        b=Cur9229XKJzV+Tc5YNCvmaC+c6cHdL4bc4tUgccnyLIh4kWVp5RHN8HYLIY5gA9+RM97NI
        qd5IcYIt/JhdPHZgcS9wHo12fnYRcByeyEHc0j9JoJgu0imsqZRRSgsOWLvRfRuDnUuwNT
        7kgfaLgfCNfMIXu1tlXjK0p2S5sfDeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648597953;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tSXrVaD5DiGK3crhV7jd+q1J1Uq8L2v4rlku+hP3up4=;
        b=n90YQwjYGZAwzjwqYZKu3znA7VOr4WwdlNZVly/gooQogv42zYyeXdhKMkXzXVtBIVK3VV
        TZZJuLHYeS3ytiBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3415313A7E;
        Tue, 29 Mar 2022 23:52:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +53PN76bQ2JTLwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 29 Mar 2022 23:52:30 +0000
Subject: [PATCH 08/10] MM: submit multipage reads for SWP_FS_OPS swap-space
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 30 Mar 2022 10:49:41 +1100
Message-ID: <164859778127.29473.14059420492644907783.stgit@noble.brown>
In-Reply-To: <164859751830.29473.5309689752169286816.stgit@noble.brown>
References: <164859751830.29473.5309689752169286816.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

swap_readpage() is given one page at a time, but may be called
repeatedly in succession.
For block-device swap-space, the blk_plug functionality allows the
multiple pages to be combined together at lower layers.
That cannot be used for SWP_FS_OPS as blk_plug may not exist - it is
only active when CONFIG_BLOCK=y.  Consequently all swap reads over NFS
are single page reads.

With this patch we pass in a pointer-to-pointer when swap_readpage can
store state between calls - much like the effect of blk_plug.  After
calling swap_readpage() some number of times, the state will be passed
to swap_read_unplug() which can submit the combined request.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 mm/madvise.c    |    8 +++-
 mm/memory.c     |    2 +
 mm/page_io.c    |  104 ++++++++++++++++++++++++++++++++++++-------------------
 mm/swap.h       |   17 +++++++--
 mm/swap_state.c |   20 +++++++----
 5 files changed, 104 insertions(+), 47 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 4f48e48432e8..297de11f73d6 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -198,6 +198,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 	pte_t *orig_pte;
 	struct vm_area_struct *vma = walk->private;
 	unsigned long index;
+	struct swap_iocb *splug = NULL;
 
 	if (pmd_none_or_trans_huge_or_clear_bad(pmd))
 		return 0;
@@ -219,10 +220,11 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
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
@@ -238,6 +240,7 @@ static void force_shm_swapin_readahead(struct vm_area_struct *vma,
 	XA_STATE(xas, &mapping->i_pages, linear_page_index(vma, start));
 	pgoff_t end_index = linear_page_index(vma, end + PAGE_SIZE - 1);
 	struct page *page;
+	struct swap_iocb *splug = NULL;
 
 	rcu_read_lock();
 	xas_for_each(&xas, page, end_index) {
@@ -250,13 +253,14 @@ static void force_shm_swapin_readahead(struct vm_area_struct *vma,
 
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
index 92ea8ac374a4..8de0ad307cb2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3586,7 +3586,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 				/* To provide entry to swap_readpage() */
 				set_page_private(page, entry.val);
-				swap_readpage(page, true);
+				swap_readpage(page, true, NULL);
 				set_page_private(page, 0);
 			}
 		} else {
diff --git a/mm/page_io.c b/mm/page_io.c
index a01cc273bb00..8735707ea349 100644
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
 
 	if (ret != PAGE_SIZE) {
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
@@ -395,46 +396,66 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 static void sio_read_complete(struct kiocb *iocb, long ret)
 {
 	struct swap_iocb *sio = container_of(iocb, struct swap_iocb, iocb);
-	struct page *page = sio->bvec.bv_page;
+	int p;
 
-	if (ret != 0 && ret != PAGE_SIZE) {
-		SetPageError(page);
-		ClearPageUptodate(page);
-		pr_alert_ratelimited("Read-error on swap-device\n");
+	if (ret == PAGE_SIZE * sio->pages) {
+		for (p = 0; p < sio->pages; p++) {
+			struct page *page = sio->bvec[p].bv_page;
+
+			SetPageUptodate(page);
+			unlock_page(page);
+		}
+		count_vm_events(PSWPIN, sio->pages);
 	} else {
-		SetPageUptodate(page);
-		count_vm_event(PSWPIN);
+		for (p = 0; p < sio->pages; p++) {
+			struct page *page = sio->bvec[p].bv_page;
+
+			SetPageError(page);
+			ClearPageUptodate(page);
+			unlock_page(page);
+		}
+		pr_alert_ratelimited("Read-error on swap-device\n");
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
+	if (plug)
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
@@ -462,7 +483,7 @@ int swap_readpage(struct page *page, bool synchronous)
 	}
 
 	if (data_race(sis->flags & SWP_FS_OPS)) {
-		ret = swap_readpage_fs(page);
+		swap_readpage_fs(page, plug);
 		goto out;
 	}
 
@@ -513,3 +534,16 @@ int swap_readpage(struct page *page, bool synchronous)
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
index eafac80b18d9..0389ab147837 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -7,7 +7,15 @@
 
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
@@ -41,7 +49,8 @@ struct page *find_get_incore_page(struct address_space *mapping, pgoff_t index);
 struct page *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 				   struct vm_area_struct *vma,
 				   unsigned long addr,
-				   bool do_poll);
+				   bool do_poll,
+				   struct swap_iocb **plug);
 struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 				     struct vm_area_struct *vma,
 				     unsigned long addr,
@@ -56,7 +65,9 @@ static inline unsigned int page_swap_flags(struct page *page)
 	return page_swap_info(page)->flags;
 }
 #else /* CONFIG_SWAP */
-static inline int swap_readpage(struct page *page, bool do_poll)
+struct swap_iocb;
+static inline int swap_readpage(struct page *page, bool do_poll,
+				struct swap_iocb **plug)
 {
 	return 0;
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index f3ab01801629..d41746a572a2 100644
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
@@ -656,10 +659,12 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 		put_page(page);
 	}
 	blk_finish_plug(&plug);
+	swap_read_unplug(splug);
 
 	lru_add_drain();	/* Push any new pages onto the LRU now */
 skip:
-	return read_swap_cache_async(entry, gfp_mask, vma, addr, do_poll);
+	/* The page was likely read above, so no need for plugging here */
+	return read_swap_cache_async(entry, gfp_mask, vma, addr, do_poll, NULL);
 }
 
 int init_swap_address_space(unsigned int type, unsigned long nr_pages)
@@ -790,6 +795,7 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 				       struct vm_fault *vmf)
 {
 	struct blk_plug plug;
+	struct swap_iocb *splug = NULL;
 	struct vm_area_struct *vma = vmf->vma;
 	struct page *page;
 	pte_t *pte, pentry;
@@ -820,7 +826,7 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 		if (!page)
 			continue;
 		if (page_allocated) {
-			swap_readpage(page, false);
+			swap_readpage(page, false, &splug);
 			if (i != ra_info.offset) {
 				SetPageReadahead(page);
 				count_vm_event(SWAP_RA);
@@ -829,10 +835,12 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 		put_page(page);
 	}
 	blk_finish_plug(&plug);
+	swap_read_unplug(splug);
 	lru_add_drain();
 skip:
+	/* The page was likely read above, so no need for plugging here */
 	return read_swap_cache_async(fentry, gfp_mask, vma, vmf->address,
-				     ra_info.win == 1);
+				     ra_info.win == 1, NULL);
 }
 
 /**


