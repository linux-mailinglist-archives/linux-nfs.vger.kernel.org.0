Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F86452804
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 03:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhKPCwl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Nov 2021 21:52:41 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59500 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241303AbhKPCug (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Nov 2021 21:50:36 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 648AF2191A;
        Tue, 16 Nov 2021 02:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637030822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5S+tNHKYQRjSQpQ0rt9HAN4Yso3tuzIn6GjWJ7BDcbM=;
        b=RiR+NzovbNVimxXKnbO8sg+DB9mcHvi+oRfRQufGEKJA+HSI41DLd7/p8q7wjVwvK083Vj
        U+2Lq3jN9iy3FDtRDL+kknUUPQGwezjiXSVpsUDK18wVcKllnh8rQRMIvSJJISD8ewaP0s
        wttat1fAXecoSOuoGTG/M4gyhvrpqDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637030822;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5S+tNHKYQRjSQpQ0rt9HAN4Yso3tuzIn6GjWJ7BDcbM=;
        b=lDDHnMQnFJWN7BiK5p99csvV+JYZ9vVilNR0Qfa1eWNMUOemxSUgy1qksLpeBzfz6hGmKn
        rSXnnqtgDrv+MdAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01AEE13B70;
        Tue, 16 Nov 2021 02:46:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7pekLKMbk2E0CQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 16 Nov 2021 02:46:59 +0000
Subject: [PATCH 12/13] MM: use AIO/DIO for reads from SWP_FS_OPS swap-space
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 16 Nov 2021 13:44:04 +1100
Message-ID: <163703064458.25805.6777856691611196478.stgit@noble.brown>
In-Reply-To: <163702956672.25805.16457749992977493579.stgit@noble.brown>
References: <163702956672.25805.16457749992977493579.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When pages a read from SWP_FS_OPS swap-space, the reads are submitted as
separate reads for each page.  This is generally less efficient than
larger reads.

We can use the block-plugging infrastructure to delay submitting the
read request until multiple contigious pages have been collected.  This
requires using ->direct_IO to submit the read (as ->readpages isn't
suitable for swap).

If the caller schedules before unplugging, we hand the read-in task off
to systemwq to avoid any possible locking issues.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 mm/page_io.c |  107 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 103 insertions(+), 4 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 9725c7e1eeea..30d613881995 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -282,6 +282,14 @@ static void bio_associate_blkg_from_page(struct bio *bio, struct page *page)
 #define bio_associate_blkg_from_page(bio, page)		do { } while (0)
 #endif /* CONFIG_MEMCG && CONFIG_BLK_CGROUP */
 
+struct swap_iocb {
+	struct blk_plug_cb	cb;	/* Must be first */
+	struct kiocb		iocb;
+	struct bio_vec		bvec[SWAP_CLUSTER_MAX];
+	struct work_struct	work;
+	int			pages;
+};
+
 int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		bio_end_io_t end_write_func)
 {
@@ -353,6 +361,59 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 	return 0;
 }
 
+static void sio_read_complete(struct kiocb *iocb, long ret)
+{
+	struct swap_iocb *sio = container_of(iocb, struct swap_iocb, iocb);
+	int p;
+
+	for (p = 0; p < sio->pages; p++) {
+		struct page *page = sio->bvec[p].bv_page;
+
+		if (ret != PAGE_SIZE * sio->pages) {
+			SetPageError(page);
+			ClearPageUptodate(page);
+			pr_alert_ratelimited("Read-error on swap-device\n");
+		} else {
+			SetPageUptodate(page);
+			count_vm_event(PSWPIN);
+		}
+		unlock_page(page);
+	}
+	kfree(sio);
+}
+
+static void sio_read_unplug(struct blk_plug_cb *cb, bool from_schedule);
+
+static void sio_read_unplug_worker(struct work_struct *work)
+{
+	struct swap_iocb *sio = container_of(work, struct swap_iocb, work);
+	sio_read_unplug(&sio->cb, 0);
+}
+
+static void sio_read_unplug(struct blk_plug_cb *cb, bool from_schedule)
+{
+	struct swap_iocb *sio = container_of(cb, struct swap_iocb, cb);
+	struct address_space *mapping = sio->iocb.ki_filp->f_mapping;
+	struct iov_iter from;
+	unsigned int nofs_flag;
+	int ret;
+
+	if (from_schedule) {
+		INIT_WORK(&sio->work, sio_read_unplug_worker);
+		schedule_work(&sio->work);
+		return;
+	}
+
+	iov_iter_bvec(&from, READ, sio->bvec,
+		      sio->pages, PAGE_SIZE * sio->pages);
+	/* nofs needs as ->direct_IO may take the same mutex it takes for write */
+	nofs_flag = memalloc_nofs_save();
+	ret = mapping->a_ops->direct_IO(&sio->iocb, &from);
+	memalloc_nofs_restore(nofs_flag);
+	if (ret != -EIOCBQUEUED)
+		sio_read_complete(&sio->iocb, ret);
+}
+
 int swap_readpage(struct page *page, bool synchronous)
 {
 	struct bio *bio;
@@ -380,10 +441,48 @@ int swap_readpage(struct page *page, bool synchronous)
 	if (data_race(sis->flags & SWP_FS_OPS)) {
 		struct file *swap_file = sis->swap_file;
 		struct address_space *mapping = swap_file->f_mapping;
-
-		ret = mapping->a_ops->readpage(swap_file, page);
-		if (!ret)
-			count_vm_event(PSWPIN);
+		struct blk_plug_cb *cb;
+		struct swap_iocb *sio;
+		loff_t pos = page_file_offset(page);
+		struct blk_plug plug;
+		int p;
+
+		/* We are sometimes called without a plug active.
+		 * By calling blk_start_plug() here, we ensure blk_check_plugged
+		 * only fails if memory allocation fails.
+		 */
+		blk_start_plug(&plug);
+		cb = blk_check_plugged(sio_read_unplug, swap_file, sizeof(*sio));
+		sio = container_of(cb, struct swap_iocb, cb);
+		if (cb && sio->pages &&
+		    sio->iocb.ki_pos + sio->pages * PAGE_SIZE != pos) {
+			/* Not contiguous - hide this sio from lookup */
+			cb->data = NULL;
+			cb = blk_check_plugged(sio_read_unplug, swap_file,
+					       sizeof(*sio));
+			sio = container_of(cb, struct swap_iocb, cb);
+		}
+		if (!cb) {
+			blk_finish_plug(&plug);
+			ret = mapping->a_ops->readpage(swap_file, page);
+			if (!ret)
+				count_vm_event(PSWPIN);
+			goto out;
+		}
+		if (sio->pages == 0) {
+			init_sync_kiocb(&sio->iocb, swap_file);
+			sio->iocb.ki_pos = pos;
+			sio->iocb.ki_complete = sio_read_complete;
+		}
+		p = sio->pages;
+		sio->bvec[p].bv_page = page;
+		sio->bvec[p].bv_len = PAGE_SIZE;
+		sio->bvec[p].bv_offset = 0;
+		p += 1;
+		sio->pages = p;
+		if (p == ARRAY_SIZE(sio->bvec))
+			cb->data = NULL;
+		blk_finish_plug(&plug);
 		goto out;
 	}
 


