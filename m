Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9614CEEC4
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Mar 2022 00:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiCFXvv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 6 Mar 2022 18:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbiCFXvq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Mar 2022 18:51:46 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78904D9EF;
        Sun,  6 Mar 2022 15:50:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 85AAD210EA;
        Sun,  6 Mar 2022 23:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646610649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hho5hYMZVcK40lGHI3cb8pp6oDrBWZHiLQsJyCXMoiY=;
        b=vbR6cYdNfzEdFOMI1ABWlCDfPrxzRNSW68zYSlL3B4b/EYc5O6vfI2gMEgIQQwWJvPAAq6
        Qo6qjZkecD1ssw7fpq/PZsqZGtT/GFoJLAMysx3qysAgr63wOhMpC0iYEQDwdXfnhXv+sz
        GDYJaLOE75OVowWP7lOAg6c37xB2eBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646610649;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hho5hYMZVcK40lGHI3cb8pp6oDrBWZHiLQsJyCXMoiY=;
        b=P2jg3n7kIc8sQHZwlFi+uzwuiuM3FnyBWeyGGeUTrijDJ3tT4Y8DfczCihZsDSUFNdygX4
        fP9i7/IDXlOTO6AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA7F2134CD;
        Sun,  6 Mar 2022 23:50:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hfkzGtdIJWJIWgAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 06 Mar 2022 23:50:47 +0000
Subject: [PATCH 05/10] MM: introduce ->swap_rw and use it for reads from
 SWP_FS_OPS swap-space
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Mon, 07 Mar 2022 10:49:38 +1100
Message-ID: <164661057805.13454.13608165909747405621.stgit@noble.brown>
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
index fe49f1cab018..6ae5b404b04b 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4889,6 +4889,10 @@ static int cifs_swap_activate(struct swap_info_struct *sis,
 
 	cifs_dbg(FYI, "swap activate\n");
 
+	if (!swap_file->f_mapping->a_ops->swap_rw)
+		/* Cannot support swap */
+		return -EINVAL;
+
 	spin_lock(&inode->i_lock);
 	blocks = inode->i_blocks;
 	isize = inode->i_size;
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index d5aa55c7edb0..3dbef2c31567 100644
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
index e2d892b201b0..57e3b387cb17 100644
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
index 34b12d6f94d7..e90a3231f225 100644
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
@@ -381,12 +442,7 @@ int swap_readpage(struct page *page, bool synchronous)
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
index ed6028aea8bf..c800c17bf0c8 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2350,6 +2350,11 @@ static int setup_swap_extents(struct swap_info_struct *sis, sector_t *span)
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
 


