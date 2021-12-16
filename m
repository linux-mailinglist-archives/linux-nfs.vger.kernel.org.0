Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0EF34780DE
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 00:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhLPXwn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Dec 2021 18:52:43 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47104 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhLPXwn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Dec 2021 18:52:43 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 17F9E210F3;
        Thu, 16 Dec 2021 23:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639698762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GPxsJOrOMxi9W5MpZzSggupSlv/3nIfHiMP/Yesmfsw=;
        b=MuDDyFqHtBt1aEs14cVhsW02Jvy0k0wxqD7Vav6pcBvnKo58u2G5gFxBF1JFJTJliUc9zD
        NsEhT5ry7z171Jx95ixF46jUGHKwOERzUSkUQywWL+tzly0QLpb2Gd9kIgKa7PjMXvQvTD
        jv72nOc8yZo6JTO089NyMewTrp+paek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639698762;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GPxsJOrOMxi9W5MpZzSggupSlv/3nIfHiMP/Yesmfsw=;
        b=RVrKsQ2ieCeoEgWQYan3nonQiOfjW0l6/g6u/xVpJhL0hkOBOb6mn1sz/uz4zgLbbxVcVf
        TahbQpj/FtUCtaCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F273713EFD;
        Thu, 16 Dec 2021 23:52:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 09KBKkbRu2FbWwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 16 Dec 2021 23:52:38 +0000
Subject: [PATCH 04/18] MM: perform async writes to SWP_FS_OPS swap-space
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
Message-ID: <163969850292.20885.16191050558510542930.stgit@noble.brown>
In-Reply-To: <163969801519.20885.3977673503103544412.stgit@noble.brown>
References: <163969801519.20885.3977673503103544412.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Writes to SWP_FS_OPS swapspace is currently synchronous.  To make it
async we need to allocate the kiocb struct which may block, but won't
block as long as waiting for the write to complete would block.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 mm/page_io.c |   69 +++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 30 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 47d7e7866e33..84859132c9c6 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -300,6 +300,32 @@ int sio_pool_init(void)
 		return -ENOMEM;
 }
 
+static void sio_write_complete(struct kiocb *iocb, long ret)
+{
+	struct swap_iocb *sio = container_of(iocb, struct swap_iocb, iocb);
+	struct page *page = sio->bvec.bv_page;
+
+	if (ret != 0 && ret != PAGE_SIZE) {
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
 int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		bio_end_io_t end_write_func)
 {
@@ -309,42 +335,25 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 
 	VM_BUG_ON_PAGE(!PageSwapCache(page), page);
 	if (data_race(sis->flags & SWP_FS_OPS)) {
-		struct kiocb kiocb;
+		struct swap_iocb *sio;
 		struct file *swap_file = sis->swap_file;
 		struct address_space *mapping = swap_file->f_mapping;
-		struct bio_vec bv = {
-			.bv_page = page,
-			.bv_len  = PAGE_SIZE,
-			.bv_offset = 0
-		};
 		struct iov_iter from;
 
-		iov_iter_bvec(&from, WRITE, &bv, 1, PAGE_SIZE);
-		init_sync_kiocb(&kiocb, swap_file);
-		kiocb.ki_pos = page_file_offset(page);
-
 		set_page_writeback(page);
 		unlock_page(page);
-		ret = mapping->a_ops->swap_rw(&kiocb, &from);
-		if (ret == 0) {
-			count_vm_event(PSWPOUT);
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
+		sio = mempool_alloc(sio_pool, GFP_NOIO);
+		init_sync_kiocb(&sio->iocb, swap_file);
+		sio->iocb.ki_complete = sio_write_complete;
+		sio->iocb.ki_pos = page_file_offset(page);
+		sio->bvec.bv_page = page;
+		sio->bvec.bv_len = PAGE_SIZE;
+		sio->bvec.bv_offset = 0;
+		iov_iter_bvec(&from, WRITE, &sio->bvec, 1, PAGE_SIZE);
+		ret = mapping->a_ops->swap_rw(&sio->iocb, &from);
+		if (ret != -EIOCBQUEUED)
+			sio_write_complete(&sio->iocb, ret);
+
 		return ret;
 	}
 


