Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAF44977DB
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 04:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbiAXDwj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 Jan 2022 22:52:39 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46964 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241192AbiAXDwj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 Jan 2022 22:52:39 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0CEDE1F3B1;
        Mon, 24 Jan 2022 03:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642996358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ilA7OZh9lH4lfKt0EXiI3v3DOr+k3/ZmJc6w2w8IIto=;
        b=TUDcaGrH3IQ4jbI1LjGtfJCbku6HgfJ1SA/e6tbwpuxhP2zeP7roeBtqcf29FStJv3t1kA
        JOxNBGux+SkxQBPCG4okM7MhzqvdeTyyO4puxMZp2QQgWOQETuLMe+PB8FmMINrXEIGO5T
        vod7VaeEvCsdi4n6uSwxs8g5GqZUM74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642996358;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ilA7OZh9lH4lfKt0EXiI3v3DOr+k3/ZmJc6w2w8IIto=;
        b=nhz08CByEzBnGB2LFv8iQj+QHte3XP0ue/V1xUBzjFDMFI8LovcXTXc5TKw/QFIcbkrbAf
        mEcxnij1qU2BYLAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5DED13305;
        Mon, 24 Jan 2022 03:52:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UruJHIIi7mFkRQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 24 Jan 2022 03:52:34 +0000
Subject: [PATCH 10/23] MM: submit multipage write for SWP_FS_OPS swap-space
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
Message-ID: <164299611279.26253.12350012848236496937.stgit@noble.brown>
In-Reply-To: <164299573337.26253.7538614611220034049.stgit@noble.brown>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>
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
 mm/page_io.c              |  103 +++++++++++++++++++++++++++++----------------
 mm/swap.h                 |    1 
 mm/vmscan.c               |    9 +++-
 4 files changed, 82 insertions(+), 38 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index fec248ab1fec..6dcaa0639c0d 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -80,6 +80,13 @@ struct writeback_control {
 
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
index bcf655d650c8..b61c2cafc4f9 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -307,56 +307,74 @@ int sio_pool_init(void)
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
 
 static int swap_writepage_fs(struct page *page, struct writeback_control *wbc)
 {
-	struct swap_iocb *sio;
+	struct swap_iocb *sio = NULL;
 	struct swap_info_struct *sis = page_swap_info(page);
 	struct file *swap_file = sis->swap_file;
-	struct address_space *mapping = swap_file->f_mapping;
-	struct iov_iter from;
-	int ret;
+	loff_t pos = page_file_offset(page);
 
 	set_page_writeback(page);
 	unlock_page(page);
-	sio = mempool_alloc(sio_pool, GFP_NOIO);
-	init_sync_kiocb(&sio->iocb, swap_file);
-	sio->iocb.ki_complete = sio_write_complete;
-	sio->iocb.ki_pos = page_file_offset(page);
-	sio->bvec[0].bv_page = page;
-	sio->bvec[0].bv_len = PAGE_SIZE;
-	sio->bvec[0].bv_offset = 0;
-	iov_iter_bvec(&from, WRITE, &sio->bvec[0], 1, PAGE_SIZE);
-	ret = mapping->a_ops->swap_rw(&sio->iocb, &from);
-	if (ret != -EIOCBQUEUED)
-		sio_write_complete(&sio->iocb, ret);
-	return ret;
+	if (wbc->plug)
+		sio = *wbc->plug;
+	if (sio) {
+		if (sio->iocb.ki_filp != swap_file ||
+		    sio->iocb.ki_pos + sio->pages * PAGE_SIZE != pos) {
+			swap_write_unplug(sio);
+			sio = NULL;
+		}
+	}
+	if (!sio) {
+		sio = mempool_alloc(sio_pool, GFP_NOIO);
+		init_sync_kiocb(&sio->iocb, swap_file);
+		sio->iocb.ki_complete = sio_write_complete;
+		sio->iocb.ki_pos = pos;
+		sio->pages = 0;
+	}
+	sio->bvec[sio->pages].bv_page = page;
+	sio->bvec[sio->pages].bv_len = PAGE_SIZE;
+	sio->bvec[sio->pages].bv_offset = 0;
+	sio->pages += 1;
+	if (sio->pages == ARRAY_SIZE(sio->bvec) || !wbc->plug) {
+		swap_write_unplug(sio);
+		sio = NULL;
+	}
+	if (wbc->plug)
+		*wbc->plug = sio;
+
+	return 0;
 }
 
 int __swap_writepage(struct page *page, struct writeback_control *wbc,
-		bio_end_io_t end_write_func)
+		     bio_end_io_t end_write_func)
 {
 	struct bio *bio;
 	int ret;
@@ -388,6 +406,19 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
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
index 0c79b2478f3f..0194ac153d40 100644
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
index ad5026d06aa8..f75c71490921 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1164,7 +1164,8 @@ typedef enum {
  * pageout is called by shrink_page_list() for each dirty page.
  * Calls ->writepage().
  */
-static pageout_t pageout(struct page *page, struct address_space *mapping)
+static pageout_t pageout(struct page *page, struct address_space *mapping,
+			 struct swap_iocb **plug)
 {
 	/*
 	 * If the page is dirty, only perform writeback if that write
@@ -1211,6 +1212,7 @@ static pageout_t pageout(struct page *page, struct address_space *mapping)
 			.range_start = 0,
 			.range_end = LLONG_MAX,
 			.for_reclaim = 1,
+			.plug = plug,
 		};
 
 		SetPageReclaim(page);
@@ -1537,6 +1539,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 	unsigned int nr_reclaimed = 0;
 	unsigned int pgactivate = 0;
 	bool do_demote_pass;
+	struct swap_iocb *plug = NULL;
 
 	memset(stat, 0, sizeof(*stat));
 	cond_resched();
@@ -1817,7 +1820,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 			 * starts and then write it out here.
 			 */
 			try_to_unmap_flush_dirty();
-			switch (pageout(page, mapping)) {
+			switch (pageout(page, mapping, &plug)) {
 			case PAGE_KEEP:
 				goto keep_locked;
 			case PAGE_ACTIVATE:
@@ -1971,6 +1974,8 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 	list_splice(&ret_pages, page_list);
 	count_vm_events(PGACTIVATE, pgactivate);
 
+	if (plug)
+		swap_write_unplug(plug);
 	return nr_reclaimed;
 }
 


