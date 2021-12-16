Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D094780DC
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 00:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhLPXwg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Dec 2021 18:52:36 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56316 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhLPXwf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Dec 2021 18:52:35 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 89E8A1F3A1;
        Thu, 16 Dec 2021 23:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639698754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F0tABiaZQk9B5WXZcUDiE47XPd+0Z5cOdU9e2/lma0U=;
        b=KZSwyyuWY2VWvIvcGn7LPjf7u5kF+as1hgafoHApqb8TZij/gCuDcHnOrqNxf4dj9KzGQO
        hS1mjVQL+/Xytno7nBdjSb1t77v9Df73wvzlVNEPUS6+ZXU/rj7+hWHHYH6VXmyoZ7uaS4
        sN6qeUEEmgBiDSHl+rBnJ2X/3O7629M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639698754;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F0tABiaZQk9B5WXZcUDiE47XPd+0Z5cOdU9e2/lma0U=;
        b=0qMSxxYEfOQW5SiOR1a3Dnhzh13qBxtxIBrYxfHWzD6RFMuDAHw9EOwbCpkuTxM3+gfVlt
        Fx9Nb/8ydBgKN9Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92E1B13EFD;
        Thu, 16 Dec 2021 23:52:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4DHbEz/Ru2FSWwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 16 Dec 2021 23:52:31 +0000
Subject: [PATCH 03/18] MM: use ->swap_rw for reads from SWP_FS_OPS swap-space
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
Message-ID: <163969850289.20885.1044395970457169316.stgit@noble.brown>
In-Reply-To: <163969801519.20885.3977673503103544412.stgit@noble.brown>
References: <163969801519.20885.3977673503103544412.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

To submit an async read with ->swap_rw() we need to allocate
a structure to hold the kiocb and other details.  swap_readpage() cannot
handle transient failure, so create a mempool to provide the structures.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 mm/page_io.c  |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++------
 mm/swap.h     |    1 +
 mm/swapfile.c |    5 +++++
 3 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index a9fe5de5dc32..47d7e7866e33 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -283,6 +283,23 @@ static void bio_associate_blkg_from_page(struct bio *bio, struct page *page)
 #define bio_associate_blkg_from_page(bio, page)		do { } while (0)
 #endif /* CONFIG_MEMCG && CONFIG_BLK_CGROUP */
 
+struct swap_iocb {
+	struct kiocb		iocb;
+	struct bio_vec		bvec;
+};
+static mempool_t *sio_pool;
+
+int sio_pool_init(void)
+{
+	if (!sio_pool)
+		sio_pool = mempool_create_kmalloc_pool(
+			SWAP_CLUSTER_MAX, sizeof(struct swap_iocb));
+	if (sio_pool)
+		return 0;
+	else
+		return -ENOMEM;
+}
+
 int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		bio_end_io_t end_write_func)
 {
@@ -353,6 +370,23 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 	return 0;
 }
 
+static void sio_read_complete(struct kiocb *iocb, long ret)
+{
+	struct swap_iocb *sio = container_of(iocb, struct swap_iocb, iocb);
+	struct page *page = sio->bvec.bv_page;
+
+	if (ret != 0 && ret != PAGE_SIZE) {
+		SetPageError(page);
+		ClearPageUptodate(page);
+		pr_alert_ratelimited("Read-error on swap-device\n");
+	} else {
+		SetPageUptodate(page);
+		count_vm_event(PSWPIN);
+	}
+	unlock_page(page);
+	mempool_free(sio, sio_pool);
+}
+
 int swap_readpage(struct page *page, bool synchronous)
 {
 	struct bio *bio;
@@ -378,13 +412,25 @@ int swap_readpage(struct page *page, bool synchronous)
 	}
 
 	if (data_race(sis->flags & SWP_FS_OPS)) {
-		//struct file *swap_file = sis->swap_file;
-		//struct address_space *mapping = swap_file->f_mapping;
+		struct file *swap_file = sis->swap_file;
+		struct address_space *mapping = swap_file->f_mapping;
+		struct iov_iter from;
+		struct swap_iocb *sio;
+		loff_t pos = page_file_offset(page);
+
+		sio = mempool_alloc(sio_pool, GFP_KERNEL);
+		init_sync_kiocb(&sio->iocb, swap_file);
+		sio->iocb.ki_pos = pos;
+		sio->iocb.ki_complete = sio_read_complete;
+		sio->bvec.bv_page = page;
+		sio->bvec.bv_len = PAGE_SIZE;
+		sio->bvec.bv_offset = 0;
+
+		iov_iter_bvec(&from, READ, &sio->bvec, 1, PAGE_SIZE);
+		ret = mapping->a_ops->swap_rw(&sio->iocb, &from);
+		if (ret != -EIOCBQUEUED)
+			sio_read_complete(&sio->iocb, ret);
 
-		/* This needs to use ->swap_rw() */
-		ret = -EINVAL;
-		if (!ret)
-			count_vm_event(PSWPIN);
 		goto out;
 	}
 
diff --git a/mm/swap.h b/mm/swap.h
index 13e72a5023aa..128a1d3e5558 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -3,6 +3,7 @@
 #include <linux/blk_types.h> /* for bio_end_io_t */
 
 /* linux/mm/page_io.c */
+int sio_pool_init(void);
 int swap_readpage(struct page *page, bool do_poll);
 int swap_writepage(struct page *page, struct writeback_control *wbc);
 void end_swap_bio_write(struct bio *bio);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index f23d9ff21cf8..43539be38e68 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2401,6 +2401,11 @@ static int setup_swap_extents(struct swap_info_struct *sis, sector_t *span)
 		if (ret < 0)
 			return ret;
 		sis->flags |= SWP_ACTIVATED;
+		if ((sis->flags & SWP_FS_OPS) &&
+		    sio_pool_init() != 0) {
+			destroy_swap_extents(sis);
+			return -ENOMEM;
+		}
 		return ret;
 	}
 


