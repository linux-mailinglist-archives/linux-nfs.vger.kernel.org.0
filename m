Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D8A4EB731
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Mar 2022 01:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241231AbiC2Xy2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Mar 2022 19:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241187AbiC2Xxq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Mar 2022 19:53:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296C3227C74;
        Tue, 29 Mar 2022 16:51:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BC4A31F869;
        Tue, 29 Mar 2022 23:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648597914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oD2sx4C2K4gKivVvzHCUML/j+d0W7oIOs5nPocXITZk=;
        b=sZGZgC++vx+vHRjb4grpV6e/1XjJQrgYuKe3NcS/RD633GfUk/tuUMZ4LbRruFngnbe832
        bzW2+SUlO98rLTK3IkDIF77AfBqTdZjfv276HiP5o+mUuxc0GKqJIOgke8OcUBe5K2UDPn
        Re9+tuf3tlm6E802rubAq8m1EPGdVFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648597914;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oD2sx4C2K4gKivVvzHCUML/j+d0W7oIOs5nPocXITZk=;
        b=FIo3rehNH8R13SVRWbhCkiZXMWtJ8XC79+K/X1xWoyZ/pqMqbgINvgCX7eDyOkxJ1lfbdo
        P9HM4So+h7r00lDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B91FE13A7E;
        Tue, 29 Mar 2022 23:51:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UIV7G5ibQ2I6LwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 29 Mar 2022 23:51:52 +0000
Subject: [PATCH 05/10] MM: introduce ->swap_rw and use it for reads from
 SWP_FS_OPS swap-space
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 30 Mar 2022 10:49:41 +1100
Message-ID: <164859778125.29473.13430559328221330589.stgit@noble.brown>
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

swap currently uses ->readpage to read swap pages.  This can only
request one page at a time from the filesystem, which is not most
efficient.

swap uses ->direct_IO for writes which while this is adequate is an
inappropriate over-loading.  ->direct_IO may need to had handle allocate
space for holes or other details that are not relevant for swap.

So this patch introduces a new address_space operation: ->swap_rw.
In this patch it is used for reads, and a subsequent patch will switch
writes to use it.

No filesystem yet supports ->swap_rw, but that is not a problem because
no filesystem actually works with filesystem-based swap.
Only two filesystems set SWP_FS_OPS:
- cifs sets the flag, but ->direct_IO always fails so swap cannot work.
- nfs sets the flag, but ->direct_IO calls generic_write_checks()
  which has failed on swap files for several releases.

To ensure that a NULL ->swap_rw isn't called, ->activate_swap() for both
NFS and cifs are changed to fail if ->swap_rw is not set.  This can be
removed if/when the function is added.

Future patches will restore swap-over-NFS functionality.

To submit an async read with ->swap_rw() we need to allocate a structure
to hold the kiocb and other details.  swap_readpage() cannot handle
transient failure, so we create a mempool to provide the structures.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/cifs/file.c     |    4 +++
 fs/nfs/file.c      |    4 +++
 include/linux/fs.h |    1 +
 mm/page_io.c       |   68 +++++++++++++++++++++++++++++++++++++++++++++++-----
 mm/swap.h          |    1 +
 mm/swapfile.c      |    5 ++++
 6 files changed, 77 insertions(+), 6 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 050f463580f3..cde8466f260b 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4899,6 +4899,10 @@ static int cifs_swap_activate(struct swap_info_struct *sis,
 
 	cifs_dbg(FYI, "swap activate\n");
 
+	if (!swap_file->f_mapping->a_ops->swap_rw)
+		/* Cannot support swap */
+		return -EINVAL;
+
 	spin_lock(&inode->i_lock);
 	blocks = inode->i_blocks;
 	isize = inode->i_size;
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 66136dca0ad5..6da81a4f3bff 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -492,6 +492,10 @@ static int nfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	struct rpc_clnt *clnt = NFS_CLIENT(file->f_mapping->host);
 	struct inode *inode = file->f_mapping->host;
 
+	if (!file->f_mapping->a_ops->swap_rw)
+		/* Cannot support swap */
+		return -EINVAL;
+
 	spin_lock(&inode->i_lock);
 	blocks = inode->i_blocks;
 	isize = inode->i_size;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 183160872133..7c65e09c09a6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -409,6 +409,7 @@ struct address_space_operations {
 	int (*swap_activate)(struct swap_info_struct *sis, struct file *file,
 				sector_t *span);
 	void (*swap_deactivate)(struct file *file);
+	int (*swap_rw)(struct kiocb *iocb, struct iov_iter *iter);
 };
 
 extern const struct address_space_operations empty_aops;
diff --git a/mm/page_io.c b/mm/page_io.c
index 5ffdbda31a16..52d423c9962b 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -284,6 +284,25 @@ static void bio_associate_blkg_from_page(struct bio *bio, struct page *page)
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
+	if (!sio_pool) {
+		mempool_t *pool = mempool_create_kmalloc_pool(
+			SWAP_CLUSTER_MAX, sizeof(struct swap_iocb));
+		if (cmpxchg(&sio_pool, NULL, pool))
+			mempool_destroy(pool);
+	}
+	if (!sio_pool)
+		return -ENOMEM;
+	return 0;
+}
+
 int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		bio_end_io_t end_write_func)
 {
@@ -355,6 +374,48 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
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
+static int swap_readpage_fs(struct page *page)
+{
+	struct swap_info_struct *sis = page_swap_info(page);
+	struct file *swap_file = sis->swap_file;
+	struct address_space *mapping = swap_file->f_mapping;
+	struct iov_iter from;
+	struct swap_iocb *sio;
+	loff_t pos = page_file_offset(page);
+	int ret;
+
+	sio = mempool_alloc(sio_pool, GFP_KERNEL);
+	init_sync_kiocb(&sio->iocb, swap_file);
+	sio->iocb.ki_pos = pos;
+	sio->iocb.ki_complete = sio_read_complete;
+	sio->bvec.bv_page = page;
+	sio->bvec.bv_len = PAGE_SIZE;
+	sio->bvec.bv_offset = 0;
+
+	iov_iter_bvec(&from, READ, &sio->bvec, 1, PAGE_SIZE);
+	ret = mapping->a_ops->swap_rw(&sio->iocb, &from);
+	if (ret != -EIOCBQUEUED)
+		sio_read_complete(&sio->iocb, ret);
+	return ret;
+}
+
 int swap_readpage(struct page *page, bool synchronous)
 {
 	struct bio *bio;
@@ -383,12 +444,7 @@ int swap_readpage(struct page *page, bool synchronous)
 	}
 
 	if (data_race(sis->flags & SWP_FS_OPS)) {
-		struct file *swap_file = sis->swap_file;
-		struct address_space *mapping = swap_file->f_mapping;
-
-		ret = mapping->a_ops->readpage(swap_file, page);
-		if (!ret)
-			count_vm_event(PSWPIN);
+		ret = swap_readpage_fs(page);
 		goto out;
 	}
 
diff --git a/mm/swap.h b/mm/swap.h
index e19f185df5e2..eafac80b18d9 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -6,6 +6,7 @@
 #include <linux/blk_types.h> /* for bio_end_io_t */
 
 /* linux/mm/page_io.c */
+int sio_pool_init(void);
 int swap_readpage(struct page *page, bool do_poll);
 int swap_writepage(struct page *page, struct writeback_control *wbc);
 void end_swap_bio_write(struct bio *bio);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 8710c9c29862..2c9b4a7aecb0 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2247,6 +2247,11 @@ static int setup_swap_extents(struct swap_info_struct *sis, sector_t *span)
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
 


