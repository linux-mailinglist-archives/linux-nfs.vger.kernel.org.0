Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208214780E4
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 00:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhLPXxF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Dec 2021 18:53:05 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56362 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhLPXxE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Dec 2021 18:53:04 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 58AED1F37F;
        Thu, 16 Dec 2021 23:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639698783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N3LExyldGHyELO/KroKo4GhmR5LrcJvQOPBtDseLnKQ=;
        b=H6jrNkx0+Bn7DRZ2IS4Tt3VaJE5IFDbnKX/YlTPw0TZ58NK9DGAAumqN7CapmzSxVcFy1F
        xvxxdwjTEx6LUmVZ1RxLLZntMOe//cz9F7W3BN6FGfCnTvgI+216eoC2Mx2/NgustLouwp
        pJrUTBshb/WBIow3a72iIKdtarTILyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639698783;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N3LExyldGHyELO/KroKo4GhmR5LrcJvQOPBtDseLnKQ=;
        b=uNCZui2Jg1ABXESPZyxnWR1ftVQC8jlMBp8M1Rc6/yrWsQe0d+5nRJq+WThLboDS7xgpKd
        qPZI4pmYgBcsdADQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 556BC13EFD;
        Thu, 16 Dec 2021 23:53:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IjunBFzRu2F9WwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 16 Dec 2021 23:53:00 +0000
Subject: [PATCH 07/18] MM: submit multipage write for SWP_FS_OPS swap-space
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
Date:   Fri, 17 Dec 2021 10:48:23 +1100
Message-ID: <163969850299.20885.11549845125423716814.stgit@noble.brown>
In-Reply-To: <163969801519.20885.3977673503103544412.stgit@noble.brown>
References: <163969801519.20885.3977673503103544412.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

swap_writepage() is given one page at a time, but may be called repeatedly
in succession.
For block-device swapspace, the blk_plug functionality allows the
multiple pages to be combined together at lower layers.
That cannot be used for SWP_FS_OPS as blk_plug may not exist - it is
only active when CONFIG_BLOCK=y.  Consequently all swap reads over NFS
are single page reads.

With this patch we pass a pointer-to-pointer via the wbc.
swap_writepage can store state between calls - much like the pointer
passed explicitly to swap_readpage.  After calling swap_writepage() some
number of times, the state will be passed to swap_write_unplug() which
can submit the combined request.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/writeback.h |    7 +++
 mm/page_io.c              |   98 ++++++++++++++++++++++++++++++---------------
 mm/swap.h                 |    1 
 mm/vmscan.c               |    9 +++-
 4 files changed, 80 insertions(+), 35 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 3bfd487d1dd2..16f780b618d2 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -79,6 +79,13 @@ struct writeback_control {
 
 	unsigned punt_to_cgroup:1;	/* cgrp punting, see __REQ_CGROUP_PUNT */
 
+	/* To enable batching of swap writes to non-block-device backends,
+	 * "plug" can be set point to a 'struct swap_iocb *'.  When all swap
+	 * writes have been submitted, if with swap_iocb is not NULL,
+	 * swap_write_unplug() should be called.
+	 */
+	struct swap_iocb **plug;
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct bdi_writeback *wb;	/* wb this writeback is issued under */
 	struct inode *inode;		/* inode being written out */
diff --git a/mm/page_io.c b/mm/page_io.c
index 03fbf9463081..92a31df467a2 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -304,26 +304,30 @@ int sio_pool_init(void)
 static void sio_write_complete(struct kiocb *iocb, long ret)
 {
 	struct swap_iocb *sio = container_of(iocb, struct swap_iocb, iocb);
-	struct page *page = sio->bvec[0].bv_page;
+	int p;
 
-	if (ret != 0 && ret != PAGE_SIZE) {
-		/*
-		 * In the case of swap-over-nfs, this can be a
-		 * temporary failure if the system has limited
-		 * memory for allocating transmit buffers.
-		 * Mark the page dirty and avoid
-		 * folio_rotate_reclaimable but rate-limit the
-		 * messages but do not flag PageError like
-		 * the normal direct-to-bio case as it could
-		 * be temporary.
-		 */
-		set_page_dirty(page);
-		ClearPageReclaim(page);
-		pr_err_ratelimited("Write error %ld on dio swapfile (%llu)\n",
-				   ret, page_file_offset(page));
-	} else
-		count_vm_event(PSWPOUT);
-	end_page_writeback(page);
+	for (p = 0; p < sio->pages; p++) {
+		struct page *page = sio->bvec[p].bv_page;
+
+		if (ret != 0 && ret != PAGE_SIZE * sio->pages) {
+			/*
+			 * In the case of swap-over-nfs, this can be a
+			 * temporary failure if the system has limited
+			 * memory for allocating transmit buffers.
+			 * Mark the page dirty and avoid
+			 * folio_rotate_reclaimable but rate-limit the
+			 * messages but do not flag PageError like
+			 * the normal direct-to-bio case as it could
+			 * be temporary.
+			 */
+			set_page_dirty(page);
+			ClearPageReclaim(page);
+			pr_err_ratelimited("Write error %ld on dio swapfile (%llu)\n",
+					   ret, page_file_offset(page));
+		} else
+			count_vm_event(PSWPOUT);
+		end_page_writeback(page);
+	}
 	mempool_free(sio, sio_pool);
 }
 
@@ -336,24 +340,39 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 
 	VM_BUG_ON_PAGE(!PageSwapCache(page), page);
 	if (data_race(sis->flags & SWP_FS_OPS)) {
-		struct swap_iocb *sio;
+		struct swap_iocb *sio = NULL;
 		struct file *swap_file = sis->swap_file;
-		struct address_space *mapping = swap_file->f_mapping;
-		struct iov_iter from;
+		loff_t pos = page_file_offset(page);
 
 		set_page_writeback(page);
 		unlock_page(page);
-		sio = mempool_alloc(sio_pool, GFP_NOIO);
-		init_sync_kiocb(&sio->iocb, swap_file);
-		sio->iocb.ki_complete = sio_write_complete;
-		sio->iocb.ki_pos = page_file_offset(page);
-		sio->bvec[0].bv_page = page;
-		sio->bvec[0].bv_len = PAGE_SIZE;
-		sio->bvec[0].bv_offset = 0;
-		iov_iter_bvec(&from, WRITE, &sio->bvec[0], 1, PAGE_SIZE);
-		ret = mapping->a_ops->swap_rw(&sio->iocb, &from);
-		if (ret != -EIOCBQUEUED)
-			sio_write_complete(&sio->iocb, ret);
+
+		if (wbc->plug)
+			sio = *wbc->plug;
+		if (sio) {
+			if (sio->iocb.ki_filp != swap_file ||
+			    sio->iocb.ki_pos + sio->pages * PAGE_SIZE != pos) {
+				swap_write_unplug(sio);
+				sio = NULL;
+			}
+		}
+		if (!sio) {
+			sio = mempool_alloc(sio_pool, GFP_NOIO);
+			init_sync_kiocb(&sio->iocb, swap_file);
+			sio->iocb.ki_complete = sio_write_complete;
+			sio->iocb.ki_pos = pos;
+			sio->pages = 0;
+		}
+		sio->bvec[sio->pages].bv_page = page;
+		sio->bvec[sio->pages].bv_len = PAGE_SIZE;
+		sio->bvec[sio->pages].bv_offset = 0;
+		sio->pages += 1;
+		if (sio->pages == ARRAY_SIZE(sio->bvec) || !wbc->plug) {
+			swap_write_unplug(sio);
+			sio = NULL;
+		}
+		if (wbc->plug)
+			*wbc->plug = sio;
 
 		return ret;
 	}
@@ -380,6 +399,19 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 	return 0;
 }
 
+void swap_write_unplug(struct swap_iocb *sio)
+{
+	struct iov_iter from;
+	struct address_space *mapping = sio->iocb.ki_filp->f_mapping;
+	int ret;
+
+	iov_iter_bvec(&from, WRITE, sio->bvec, sio->pages,
+		      PAGE_SIZE * sio->pages);
+	ret = mapping->a_ops->swap_rw(&sio->iocb, &from);
+	if (ret != -EIOCBQUEUED)
+		sio_write_complete(&sio->iocb, ret);
+}
+
 static void sio_read_complete(struct kiocb *iocb, long ret)
 {
 	struct swap_iocb *sio = container_of(iocb, struct swap_iocb, iocb);
diff --git a/mm/swap.h b/mm/swap.h
index ce967abc5f46..f4d0edda6e59 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -13,6 +13,7 @@ static inline void swap_read_unplug(struct swap_iocb *plug)
 	if (unlikely(plug))
 		__swap_read_unplug(plug);
 }
+void swap_write_unplug(struct swap_iocb *sio);
 int swap_writepage(struct page *page, struct writeback_control *wbc);
 void end_swap_bio_write(struct bio *bio);
 int __swap_writepage(struct page *page, struct writeback_control *wbc,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5f460d174b1b..50a363e63102 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1123,7 +1123,8 @@ typedef enum {
  * pageout is called by shrink_page_list() for each dirty page.
  * Calls ->writepage().
  */
-static pageout_t pageout(struct page *page, struct address_space *mapping)
+static pageout_t pageout(struct page *page, struct address_space *mapping,
+			 struct swap_iocb **plug)
 {
 	/*
 	 * If the page is dirty, only perform writeback if that write
@@ -1170,6 +1171,7 @@ static pageout_t pageout(struct page *page, struct address_space *mapping)
 			.range_start = 0,
 			.range_end = LLONG_MAX,
 			.for_reclaim = 1,
+			.plug = plug,
 		};
 
 		SetPageReclaim(page);
@@ -1495,6 +1497,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 	unsigned int nr_reclaimed = 0;
 	unsigned int pgactivate = 0;
 	bool do_demote_pass;
+	struct swap_iocb *plug = NULL;
 
 	memset(stat, 0, sizeof(*stat));
 	cond_resched();
@@ -1780,7 +1783,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 			 * starts and then write it out here.
 			 */
 			try_to_unmap_flush_dirty();
-			switch (pageout(page, mapping)) {
+			switch (pageout(page, mapping, &plug)) {
 			case PAGE_KEEP:
 				goto keep_locked;
 			case PAGE_ACTIVATE:
@@ -1934,6 +1937,8 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 	list_splice(&ret_pages, page_list);
 	count_vm_events(PGACTIVATE, pgactivate);
 
+	if (plug)
+		swap_write_unplug(plug);
 	return nr_reclaimed;
 }
 


