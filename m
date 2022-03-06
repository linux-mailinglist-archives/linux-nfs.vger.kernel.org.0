Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2C34CEECA
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Mar 2022 00:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbiCFXwS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 6 Mar 2022 18:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbiCFXwR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Mar 2022 18:52:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0CF46676;
        Sun,  6 Mar 2022 15:51:24 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 822841F37D;
        Sun,  6 Mar 2022 23:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646610683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/g0ODDKZICxfw8OkQOAdWjyHJrJLWNkQcZQcCR78ueM=;
        b=T4ukFn+wEDeh92N6fLVx9pN4gaNzy8X+S+e+lwobhcFMlsRCPQ7ggGCMUmzO6Bqosm6uJP
        xQFdmw9zoZtCmbWIBndnKIzVCiEn7NRKA2g+6iVtYnCjEMNgjzrhJscCsfkDTDB9sfk5Ze
        vCKJDgX+f4SMwDZK9mUW9Mj5dKpSrH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646610683;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/g0ODDKZICxfw8OkQOAdWjyHJrJLWNkQcZQcCR78ueM=;
        b=3y2nW3HMAtzr9BW6DPGKlFpc7QpW5ZZRZzQLJgUOj8C3vMFbWB0vZJXllGWnl+xxsKMhIx
        ED8ZXABe7j73IaDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E8D1134CD;
        Sun,  6 Mar 2022 23:51:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6Hx2EvlIJWJ1WgAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 06 Mar 2022 23:51:21 +0000
Subject: [PATCH 09/10] MM: submit multipage write for SWP_FS_OPS swap-space
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Mon, 07 Mar 2022 10:49:38 +1100
Message-ID: <164661057808.13454.2786821520388177290.stgit@noble.brown>
In-Reply-To: <164661047081.13454.11679636335222534920.stgit@noble.brown>
References: <164661047081.13454.11679636335222534920.stgit@noble.brown>
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/writeback.h |    7 ++++
 mm/page_io.c              |   78 ++++++++++++++++++++++++++++++++-------------
 mm/swap.h                 |    4 ++
 mm/vmscan.c               |    9 ++++-
 4 files changed, 74 insertions(+), 24 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index fec248ab1fec..32b35f21cb97 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -80,6 +80,13 @@ struct writeback_control {
 
 	unsigned punt_to_cgroup:1;	/* cgrp punting, see __REQ_CGROUP_PUNT */
 
+	/* To enable batching of swap writes to non-block-device backends,
+	 * "plug" can be set point to a 'struct swap_iocb *'.  When all swap
+	 * writes have been submitted, if with swap_iocb is not NULL,
+	 * swap_write_unplug() should be called.
+	 */
+	struct swap_iocb **swap_plug;
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct bdi_writeback *wb;	/* wb this writeback is issued under */
 	struct inode *inode;		/* inode being written out */
diff --git a/mm/page_io.c b/mm/page_io.c
index 4e8abbfbe388..3bf6547d6789 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -308,8 +308,9 @@ static void sio_write_complete(struct kiocb *iocb, long ret)
 {
 	struct swap_iocb *sio = container_of(iocb, struct swap_iocb, iocb);
 	struct page *page = sio->bvec[0].bv_page;
+	int p;
 
-	if (ret != PAGE_SIZE) {
+	if (ret != PAGE_SIZE * sio->pages) {
 		/*
 		 * In the case of swap-over-nfs, this can be a
 		 * temporary failure if the system has limited
@@ -320,43 +321,63 @@ static void sio_write_complete(struct kiocb *iocb, long ret)
 		 * the normal direct-to-bio case as it could
 		 * be temporary.
 		 */
-		set_page_dirty(page);
-		ClearPageReclaim(page);
 		pr_err_ratelimited("Write error %ld on dio swapfile (%llu)\n",
 				   ret, page_file_offset(page));
+		for (p = 0; p < sio->pages; p++) {
+			page = sio->bvec[p].bv_page;
+			set_page_dirty(page);
+			ClearPageReclaim(page);
+		}
 	} else
-		count_vm_event(PSWPOUT);
-	end_page_writeback(page);
+		count_vm_events(PSWPOUT, sio->pages);
+
+	for (p = 0; p < sio->pages; p++)
+		end_page_writeback(sio->bvec[p].bv_page);
+
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
+	if (wbc->swap_plug)
+		sio = *wbc->swap_plug;
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
+	if (sio->pages == ARRAY_SIZE(sio->bvec) || !wbc->swap_plug) {
+		swap_write_unplug(sio);
+		sio = NULL;
+	}
+	if (wbc->swap_plug)
+		*wbc->swap_plug = sio;
+
+	return 0;
 }
 
 int __swap_writepage(struct page *page, struct writeback_control *wbc,
-		bio_end_io_t end_write_func)
+		     bio_end_io_t end_write_func)
 {
 	struct bio *bio;
 	int ret;
@@ -393,6 +414,19 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
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
index 0389ab147837..a6da8f612904 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -16,6 +16,7 @@ static inline void swap_read_unplug(struct swap_iocb *plug)
 	if (unlikely(plug))
 		__swap_read_unplug(plug);
 }
+void swap_write_unplug(struct swap_iocb *sio);
 int swap_writepage(struct page *page, struct writeback_control *wbc);
 void end_swap_bio_write(struct bio *bio);
 int __swap_writepage(struct page *page, struct writeback_control *wbc,
@@ -71,6 +72,9 @@ static inline int swap_readpage(struct page *page, bool do_poll,
 {
 	return 0;
 }
+static inline void swap_write_unplug(struct swap_iocb *sio)
+{
+}
 
 static inline struct address_space *swap_address_space(swp_entry_t entry)
 {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ffae4ba82eae..1918650abf39 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1166,7 +1166,8 @@ typedef enum {
  * pageout is called by shrink_page_list() for each dirty page.
  * Calls ->writepage().
  */
-static pageout_t pageout(struct page *page, struct address_space *mapping)
+static pageout_t pageout(struct page *page, struct address_space *mapping,
+			 struct swap_iocb **plug)
 {
 	/*
 	 * If the page is dirty, only perform writeback if that write
@@ -1213,6 +1214,7 @@ static pageout_t pageout(struct page *page, struct address_space *mapping)
 			.range_start = 0,
 			.range_end = LLONG_MAX,
 			.for_reclaim = 1,
+			.swap_plug = plug,
 		};
 
 		SetPageReclaim(page);
@@ -1539,6 +1541,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 	unsigned int nr_reclaimed = 0;
 	unsigned int pgactivate = 0;
 	bool do_demote_pass;
+	struct swap_iocb *plug = NULL;
 
 	memset(stat, 0, sizeof(*stat));
 	cond_resched();
@@ -1819,7 +1822,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 			 * starts and then write it out here.
 			 */
 			try_to_unmap_flush_dirty();
-			switch (pageout(page, mapping)) {
+			switch (pageout(page, mapping, &plug)) {
 			case PAGE_KEEP:
 				goto keep_locked;
 			case PAGE_ACTIVATE:
@@ -1973,6 +1976,8 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 	list_splice(&ret_pages, page_list);
 	count_vm_events(PGACTIVATE, pgactivate);
 
+	if (plug)
+		swap_write_unplug(plug);
 	return nr_reclaimed;
 }
 


