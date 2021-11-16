Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412AA452807
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 03:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379141AbhKPCwp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Nov 2021 21:52:45 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37468 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357079AbhKPCun (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Nov 2021 21:50:43 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 335571FD6C;
        Tue, 16 Nov 2021 02:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637030834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VVPL+cBsnPcJ/XftWmdbCLVfibDIhJVueSGjUUmK5KU=;
        b=YUNvL1vzNP6tc4e++3cILebMtiqR5ZyisD+djv+vdV3l2KuqbnoTXfP/nevxDhMdNMbfhA
        +jyfQOjL4Q6wbJcV8mMQ7Z3CEZiE/h/FB/FxUspS2/4/WQ5Pyp7GdQjb9zwpgUWkKugyYR
        Itw+wMJ6/XhOxbz2YvQgR/FrGhUR/Xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637030834;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VVPL+cBsnPcJ/XftWmdbCLVfibDIhJVueSGjUUmK5KU=;
        b=xpPWJwj/GMiQ5fbX4bXE8GDIPorWPxEGI7Ja2YAVjUnYpTh72JtPZuQYrmI2JOOLWtGgYE
        fqaBhEG90muNWrDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D0F8313B70;
        Tue, 16 Nov 2021 02:47:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XXShI68bk2FMCQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 16 Nov 2021 02:47:11 +0000
Subject: [PATCH 13/13] MM: use AIO for DIO writes to swap
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 16 Nov 2021 13:44:04 +1100
Message-ID: <163703064458.25805.5272714590032323298.stgit@noble.brown>
In-Reply-To: <163702956672.25805.16457749992977493579.stgit@noble.brown>
References: <163702956672.25805.16457749992977493579.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When swap-out goes through the filesystem (as with NFS), we currently
perform synchronous writes with ->direct_IO.  This serializes swap
writes and causes kswapd to block waiting for a writes to complete.  This
is quite different to swap-out to a block device (always async), and
possibly hurts liveness.

So switch to AIO writes.  If the necessary kiocb structure cannot be
allocated, fall back to sync writes using a kiocb on the stack.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 mm/page_io.c |  136 ++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 103 insertions(+), 33 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 30d613881995..59a2d49e53c3 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -25,6 +25,7 @@
 #include <linux/psi.h>
 #include <linux/uio.h>
 #include <linux/sched/task.h>
+#include "internal.h"
 
 void end_swap_bio_write(struct bio *bio)
 {
@@ -288,8 +289,70 @@ struct swap_iocb {
 	struct bio_vec		bvec[SWAP_CLUSTER_MAX];
 	struct work_struct	work;
 	int			pages;
+	bool			on_stack;
 };
 
+static void sio_aio_complete(struct kiocb *iocb, long ret)
+{
+	struct swap_iocb *sio = container_of(iocb, struct swap_iocb, iocb);
+	int p;
+
+	if (ret != PAGE_SIZE * sio->pages) {
+		/*
+		 * In the case of swap-over-nfs, this can be a
+		 * temporary failure if the system has limited
+		 * memory for allocating transmit buffers.
+		 * Mark the page dirty and avoid
+		 * rotate_reclaimable_page but rate-limit the
+		 * messages but do not flag PageError like
+		 * the normal direct-to-bio case as it could
+		 * be temporary.
+		 */
+		pr_err_ratelimited("Write error on dio swapfile (%llu - %d pages)\n",
+				   page_file_offset(sio->bvec[0].bv_page),
+				   sio->pages);
+		for (p = 0; p < sio->pages; p++) {
+			set_page_dirty(sio->bvec[p].bv_page);
+			ClearPageReclaim(sio->bvec[p].bv_page);
+		}
+	}
+	for (p = 0; p < sio->pages; p++)
+		end_page_writeback(sio->bvec[p].bv_page);
+	if (!sio->on_stack)
+		kfree(sio);
+}
+
+static void sio_aio_unplug(struct blk_plug_cb *cb, bool from_schedule);
+
+static void sio_write_unplug_worker(struct work_struct *work)
+{
+	struct swap_iocb *sio = container_of(work, struct swap_iocb, work);
+	sio_aio_unplug(&sio->cb, 0);
+}
+
+static void sio_aio_unplug(struct blk_plug_cb *cb, bool from_schedule)
+{
+	struct swap_iocb *sio = container_of(cb, struct swap_iocb, cb);
+	struct address_space *mapping = sio->iocb.ki_filp->f_mapping;
+	struct iov_iter from;
+	int ret;
+	unsigned int noreclaim_flag;
+
+	if (from_schedule) {
+		INIT_WORK(&sio->work, sio_write_unplug_worker);
+		queue_work(mm_percpu_wq, &sio->work);
+		return;
+	}
+
+	noreclaim_flag = memalloc_noreclaim_save();
+	iov_iter_bvec(&from, WRITE, sio->bvec,
+		      sio->pages, PAGE_SIZE * sio->pages);
+	ret = mapping->a_ops->direct_IO(&sio->iocb, &from);
+	memalloc_noreclaim_restore(noreclaim_flag);
+	if (ret != -EIOCBQUEUED)
+		sio_aio_complete(&sio->iocb, ret);
+}
+
 int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		bio_end_io_t end_write_func)
 {
@@ -299,44 +362,51 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 
 	VM_BUG_ON_PAGE(!PageSwapCache(page), page);
 	if (data_race(sis->flags & SWP_FS_OPS)) {
-		struct kiocb kiocb;
+		struct swap_iocb *sio, sio_on_stack;
+		struct blk_plug_cb *cb;
 		struct file *swap_file = sis->swap_file;
-		struct address_space *mapping = swap_file->f_mapping;
-		struct bio_vec bv = {
-			.bv_page = page,
-			.bv_len  = PAGE_SIZE,
-			.bv_offset = 0
-		};
-		struct iov_iter from;
-
-		iov_iter_bvec(&from, WRITE, &bv, 1, PAGE_SIZE);
-		init_sync_kiocb(&kiocb, swap_file);
-		kiocb.ki_pos = page_file_offset(page);
+		loff_t pos = page_file_offset(page);
+		int p;
 
 		set_page_writeback(page);
 		unlock_page(page);
-		ret = mapping->a_ops->direct_IO(&kiocb, &from);
-		if (ret == PAGE_SIZE) {
-			count_vm_event(PSWPOUT);
-			ret = 0;
-		} else {
-			/*
-			 * In the case of swap-over-nfs, this can be a
-			 * temporary failure if the system has limited
-			 * memory for allocating transmit buffers.
-			 * Mark the page dirty and avoid
-			 * folio_rotate_reclaimable but rate-limit the
-			 * messages but do not flag PageError like
-			 * the normal direct-to-bio case as it could
-			 * be temporary.
-			 */
-			set_page_dirty(page);
-			ClearPageReclaim(page);
-			pr_err_ratelimited("Write error on dio swapfile (%llu)\n",
-					   page_file_offset(page));
+		cb = blk_check_plugged(sio_aio_unplug, swap_file, sizeof(*sio));
+		sio = container_of(cb, struct swap_iocb, cb);
+		if (cb && sio->pages &&
+		    sio->iocb.ki_pos + sio->pages * PAGE_SIZE != pos) {
+			/* Not contiguous - hide this sio from lookup */
+			cb->data = NULL;
+			cb = blk_check_plugged(sio_aio_unplug, swap_file,
+					       sizeof(*sio));
+			sio = container_of(cb, struct swap_iocb, cb);
 		}
-		end_page_writeback(page);
-		return ret;
+		if (!cb) {
+			sio = &sio_on_stack;
+			sio->pages = 0;
+			sio->on_stack = true;
+		}
+
+		if (sio->pages == 0) {
+			init_sync_kiocb(&sio->iocb, swap_file);
+			sio->iocb.ki_pos = pos;
+			if (sio != &sio_on_stack)
+				sio->iocb.ki_complete = sio_aio_complete;
+		}
+		p = sio->pages;
+		sio->bvec[p].bv_page = page;
+		sio->bvec[p].bv_len = PAGE_SIZE;
+		sio->bvec[p].bv_offset = 0;
+		p += 1;
+		sio->pages = p;
+		if (!cb)
+			sio_aio_unplug(&sio->cb, 0);
+		else if (p >= ARRAY_SIZE(sio->bvec))
+			/* Don't try to add to this */
+			cb->data = NULL;
+
+		count_vm_event(PSWPOUT);
+
+		return 0;
 	}
 
 	ret = bdev_write_page(sis->bdev, swap_page_sector(page), page, wbc);


