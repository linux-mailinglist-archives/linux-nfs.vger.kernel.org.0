Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112134EB732
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Mar 2022 01:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241410AbiC2Xym (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Mar 2022 19:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241408AbiC2XyS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Mar 2022 19:54:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D65232D2A;
        Tue, 29 Mar 2022 16:52:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 72B36218FB;
        Tue, 29 Mar 2022 23:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648597926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eZoKoyzq+mjWgFFmoZiRVp8Ge/xCx6lu4KsWyGo8HHM=;
        b=WK4ZqFzlcF4tMT+Q5HuZ+j0mqX8tYAUW7Brwlg+zCDxZlSeohFiKL7F4UKcMsQC/UZyX57
        gRlNTV9fSse1claA38oMwqGVAvkjfUfqnd+rTbpKcFdqhCn26XKQVSquHTlETlV/KPhFQb
        1EEVKC64hdhEnm9nqPlg/kN8Qdr+P4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648597926;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eZoKoyzq+mjWgFFmoZiRVp8Ge/xCx6lu4KsWyGo8HHM=;
        b=k/3H9b5rfhEwGFBsuRm7S8d3P8BCNLsEFUrE798qhjoonzahT9uqijZIQY5MjCaqzdSIGF
        Nbvs0SOXowpvrGDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B56013A7E;
        Tue, 29 Mar 2022 23:52:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Kke9NaCbQ2JBLwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 29 Mar 2022 23:52:00 +0000
Subject: [PATCH 06/10] MM: perform async writes to SWP_FS_OPS swap-space using
 ->swap_rw
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 30 Mar 2022 10:49:41 +1100
Message-ID: <164859778126.29473.12399585304843922231.stgit@noble.brown>
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

This patch switches swap-out to SWP_FS_OPS swap-spaces to use ->swap_rw
and makes the writes asynchronous, like they are for other swap spaces.

To make it async we need to allocate the kiocb struct from a mempool.
This may block, but won't block as long as waiting for the write to
complete.  At most it will wait for some previous swap IO to complete.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 mm/page_io.c |   98 ++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 58 insertions(+), 40 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 52d423c9962b..a01cc273bb00 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -303,6 +303,57 @@ int sio_pool_init(void)
 	return 0;
 }
 
+static void sio_write_complete(struct kiocb *iocb, long ret)
+{
+	struct swap_iocb *sio = container_of(iocb, struct swap_iocb, iocb);
+	struct page *page = sio->bvec.bv_page;
+
+	if (ret != PAGE_SIZE) {
+		/*
+		 * In the case of swap-over-nfs, this can be a
+		 * temporary failure if the system has limited
+		 * memory for allocating transmit buffers.
+		 * Mark the page dirty and avoid
+		 * folio_rotate_reclaimable but rate-limit the
+		 * messages but do not flag PageError like
+		 * the normal direct-to-bio case as it could
+		 * be temporary.
+		 */
+		set_page_dirty(page);
+		ClearPageReclaim(page);
+		pr_err_ratelimited("Write error %ld on dio swapfile (%llu)\n",
+				   ret, page_file_offset(page));
+	} else
+		count_vm_event(PSWPOUT);
+	end_page_writeback(page);
+	mempool_free(sio, sio_pool);
+}
+
+static int swap_writepage_fs(struct page *page, struct writeback_control *wbc)
+{
+	struct swap_iocb *sio;
+	struct swap_info_struct *sis = page_swap_info(page);
+	struct file *swap_file = sis->swap_file;
+	struct address_space *mapping = swap_file->f_mapping;
+	struct iov_iter from;
+	int ret;
+
+	set_page_writeback(page);
+	unlock_page(page);
+	sio = mempool_alloc(sio_pool, GFP_NOIO);
+	init_sync_kiocb(&sio->iocb, swap_file);
+	sio->iocb.ki_complete = sio_write_complete;
+	sio->iocb.ki_pos = page_file_offset(page);
+	sio->bvec.bv_page = page;
+	sio->bvec.bv_len = PAGE_SIZE;
+	sio->bvec.bv_offset = 0;
+	iov_iter_bvec(&from, WRITE, &sio->bvec, 1, PAGE_SIZE);
+	ret = mapping->a_ops->swap_rw(&sio->iocb, &from);
+	if (ret != -EIOCBQUEUED)
+		sio_write_complete(&sio->iocb, ret);
+	return ret;
+}
+
 int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		bio_end_io_t end_write_func)
 {
@@ -311,46 +362,13 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 	struct swap_info_struct *sis = page_swap_info(page);
 
 	VM_BUG_ON_PAGE(!PageSwapCache(page), page);
-	if (data_race(sis->flags & SWP_FS_OPS)) {
-		struct kiocb kiocb;
-		struct file *swap_file = sis->swap_file;
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
-
-		set_page_writeback(page);
-		unlock_page(page);
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
-		}
-		end_page_writeback(page);
-		return ret;
-	}
+	/*
+	 * ->flags can be updated non-atomicially (scan_swap_map_slots),
+	 * but that will never affect SWP_FS_OPS, so the data_race
+	 * is safe.
+	 */
+	if (data_race(sis->flags & SWP_FS_OPS))
+		return swap_writepage_fs(page, wbc);
 
 	ret = bdev_write_page(sis->bdev, swap_page_sector(page), page, wbc);
 	if (!ret) {


