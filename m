Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F304780D8
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 00:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhLPXwV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Dec 2021 18:52:21 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56294 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhLPXwV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Dec 2021 18:52:21 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 165891F3A1;
        Thu, 16 Dec 2021 23:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639698740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ug4yW5gOL63SqKbbFD2vKNdEEo7P9U8FK5i/2jPwxYk=;
        b=pJGrgR6BEwcIRhGSksUqNQsRNwXGhcim6tBNCAVsbADwae8I/iY+PxMl2+Oe1IhXY6sI75
        SCfb9rfxZL6Hqvgrb5gHpQwa6CKAGbyvX16n7huUCCe3rTUTLphQJG6CZa/AyhtKnnO4Jf
        UpHISF2nWdOc3w+whip6Y+zta5Ae7X8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639698740;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ug4yW5gOL63SqKbbFD2vKNdEEo7P9U8FK5i/2jPwxYk=;
        b=fTSHn9rcYsuxjAxKyTPBELQNYHb2uC3gKPXE53GOUp81yR7qaysg1lDeBl2XfhgzenTn9n
        4xVEdjkR6jtp87Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C47E613EFD;
        Thu, 16 Dec 2021 23:52:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iYrDHzDRu2E5WwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 16 Dec 2021 23:52:16 +0000
Subject: [PATCH 01/18] Structural cleanup for filesystem-based swap
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
Message-ID: <163969850251.20885.10819272484905153807.stgit@noble.brown>
In-Reply-To: <163969801519.20885.3977673503103544412.stgit@noble.brown>
References: <163969801519.20885.3977673503103544412.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Linux primarily uses IO to block devices for swap, but can send the IO
requests to a filesystem.  This has only ever worked for NFS, and that
hasn't worked for a while due to a lack of testing.  This seems like a
good time for some tidy-up before restoring swap-over-NFS functionality.

This patch:
 - updates the documentation (both copies!) for swap_activate which
   is woefully out-of-date
 - introduces a new address_space operation "swap_rw" for swap IO.
   The code currently used ->readpage for reads and ->direct_IO for
   writes.  The former imposes a limit of one-page-at-a-time, the
   later means that direct writes and swap writes are encouraged to
   use the same path.  While similar, swap can often be simpler as
   it can assume that no allocation is needed, and coherence with the
   page cache is irrelevant.
 - move the responsibility for setting SWP_FS_OPS to ->swap_activate()
   and also requires it to always call add_swap_extent().  This makes
   it much easier to find filesystems that require SWP_FS_OPS.
 - drops the call to the filesystem for ->set_page_dirty().  These
   pages do not belong to the filesystem, and it has no interest
   in the dirty status.

writeout is switched to ->swap_rw, but read-in is not as that requires
too much change for this patch.

Both cifs and nfs set SWP_FS_OPS but neither provide a swap_rw, so both
will now fail to activate swap.  cifs never really tried to provide swap
support as ->direct_IO always returns an error.  NFS will be fixed up
with following patches.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 Documentation/filesystems/locking.rst |   18 ++++++++++++------
 Documentation/filesystems/vfs.rst     |   17 ++++++++++++-----
 fs/cifs/file.c                        |    7 ++++++-
 fs/nfs/file.c                         |   17 +++++++++++++++--
 include/linux/fs.h                    |    1 +
 include/linux/swap.h                  |    1 -
 mm/page_io.c                          |   26 ++++++--------------------
 mm/swap_state.c                       |    2 +-
 mm/swapfile.c                         |   10 +++-------
 9 files changed, 56 insertions(+), 43 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index d36fe79167b3..c2bb753bf688 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -265,8 +265,9 @@ prototypes::
 	int (*launder_page)(struct page *);
 	int (*is_partially_uptodate)(struct page *, unsigned long, unsigned long);
 	int (*error_remove_page)(struct address_space *, struct page *);
-	int (*swap_activate)(struct file *);
+	int (*swap_activate)(struct swap_info_struct *sis, struct file *f, sector_t *span)
 	int (*swap_deactivate)(struct file *);
+	int (*swap_rw)(struct kiocb *iocb, struct iov_iter *iter);
 
 locking rules:
 	All except set_page_dirty and freepage may block
@@ -295,6 +296,7 @@ is_partially_uptodate:	yes
 error_remove_page:	yes
 swap_activate:		no
 swap_deactivate:	no
+swap_rw:		yes, unlocks
 ======================	======================== =========	===============
 
 ->write_begin(), ->write_end() and ->readpage() may be called from
@@ -397,15 +399,19 @@ cleaned, or an error value if not. Note that in order to prevent the page
 getting mapped back in and redirtied, it needs to be kept locked
 across the entire operation.
 
-->swap_activate will be called with a non-zero argument on
-files backing (non block device backed) swapfiles. A return value
-of zero indicates success, in which case this file can be used for
-backing swapspace. The swapspace operations will be proxied to the
-address space operations.
+->swap_activate() will be called to prepare the given file for swap.  It
+should perform any validation and preparation necessary to ensure that
+writes can be performed with minimal memory allocation.  It should call
+add_swap_extent(), or the helper iomap_swapfile_activate(), and return
+the number of extents added.  If IO should be submitted through
+->swap_rw(), it should set SWP_FS_OPS, otherwise IO will be submitted
+directly to the block device ``sis->bdev``.
 
 ->swap_deactivate() will be called in the sys_swapoff()
 path after ->swap_activate() returned success.
 
+->swap_rw will be called for swap IO if ->swap_activate() set SWP_FS_OPS.
+
 file_lock_operations
 ====================
 
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index bf5c48066fac..70d7ce335565 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -751,8 +751,9 @@ cache in your filesystem.  The following members are defined:
 					      unsigned long);
 		void (*is_dirty_writeback) (struct page *, bool *, bool *);
 		int (*error_remove_page) (struct mapping *mapping, struct page *page);
-		int (*swap_activate)(struct file *);
+		int (*swap_activate)(struct swap_info_struct *sis, struct file *f, sector_t *span)
 		int (*swap_deactivate)(struct file *);
+		int (*swap_rw)(struct kiocb *iocb, struct iov_iter *iter);
 	};
 
 ``writepage``
@@ -959,15 +960,21 @@ cache in your filesystem.  The following members are defined:
 	unless you have them locked or reference counts increased.
 
 ``swap_activate``
-	Called when swapon is used on a file to allocate space if
-	necessary and pin the block lookup information in memory.  A
-	return value of zero indicates success, in which case this file
-	can be used to back swapspace.
+
+	Called to prepare the given file for swap.  It should perform
+	any validation and preparation necessary to ensure that writes
+	can be performed with minimal memory allocation.  It should call
+	add_swap_extent(), or the helper iomap_swapfile_activate(), and
+	return the number of extents added.  If IO should be submitted
+	through ->swap_rw(), it should set SWP_FS_OPS, otherwise IO will
+	be submitted directly to the block device ``sis->bdev``.
 
 ``swap_deactivate``
 	Called during swapoff on files where swap_activate was
 	successful.
 
+``swap_rw``
+	Called to read or write swap pages when swap_activate() set SWP_FS_OPS.
 
 The File Object
 ===============
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 9fee3af83a73..50bebf5f15cc 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4943,6 +4943,10 @@ static int cifs_swap_activate(struct swap_info_struct *sis,
 
 	cifs_dbg(FYI, "swap activate\n");
 
+	if (!swap_file->f_mapping->a_ops->swap_rw)
+		/* Cannot support swap */
+		return -EINVAL;
+
 	spin_lock(&inode->i_lock);
 	blocks = inode->i_blocks;
 	isize = inode->i_size;
@@ -4971,7 +4975,8 @@ static int cifs_swap_activate(struct swap_info_struct *sis,
 	 * from reading or writing the file
 	 */
 
-	return 0;
+	sis->flags |= SWP_FS_OPS;
+	return add_swap_extent(sis, 0, sis->max, 0);
 }
 
 static void cifs_swap_deactivate(struct file *file)
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 24e7dccce355..0d33c95eefb6 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -489,9 +489,14 @@ static int nfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 {
 	unsigned long blocks;
 	long long isize;
+	int ret;
 	struct rpc_clnt *clnt = NFS_CLIENT(file->f_mapping->host);
 	struct inode *inode = file->f_mapping->host;
 
+	if (!file->f_mapping->a_ops->swap_rw)
+		/* Cannot support swap */
+		return -EINVAL;
+
 	spin_lock(&inode->i_lock);
 	blocks = inode->i_blocks;
 	isize = inode->i_size;
@@ -501,9 +506,17 @@ static int nfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		return -EINVAL;
 	}
 
+	ret = rpc_clnt_swap_activate(clnt);
+	if (ret)
+		return ret;
+	ret = add_swap_extent(sis, 0, sis->max, 0);
+	if (ret < 0) {
+		rpc_clnt_swap_deactivate(clnt);
+		return ret;
+	}
 	*span = sis->pages;
-
-	return rpc_clnt_swap_activate(clnt);
+	sis->flags |= SWP_FS_OPS;
+	return ret;
 }
 
 static void nfs_swap_deactivate(struct file *file)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bbf812ce89a8..deaaf359cc49 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -415,6 +415,7 @@ struct address_space_operations {
 	int (*swap_activate)(struct swap_info_struct *sis, struct file *file,
 				sector_t *span);
 	void (*swap_deactivate)(struct file *file);
+	int (*swap_rw)(struct kiocb *iocb, struct iov_iter *iter);
 };
 
 extern const struct address_space_operations empty_aops;
diff --git a/include/linux/swap.h b/include/linux/swap.h
index d1ea44b31f19..10b2a92c1aa1 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -427,7 +427,6 @@ extern int swap_writepage(struct page *page, struct writeback_control *wbc);
 extern void end_swap_bio_write(struct bio *bio);
 extern int __swap_writepage(struct page *page, struct writeback_control *wbc,
 	bio_end_io_t end_write_func);
-extern int swap_set_page_dirty(struct page *page);
 
 int add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
 		unsigned long nr_pages, sector_t start_block);
diff --git a/mm/page_io.c b/mm/page_io.c
index 9725c7e1eeea..cb617a4f59df 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -307,10 +307,9 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 
 		set_page_writeback(page);
 		unlock_page(page);
-		ret = mapping->a_ops->direct_IO(&kiocb, &from);
-		if (ret == PAGE_SIZE) {
+		ret = mapping->a_ops->swap_rw(&kiocb, &from);
+		if (ret == 0) {
 			count_vm_event(PSWPOUT);
-			ret = 0;
 		} else {
 			/*
 			 * In the case of swap-over-nfs, this can be a
@@ -378,10 +377,11 @@ int swap_readpage(struct page *page, bool synchronous)
 	}
 
 	if (data_race(sis->flags & SWP_FS_OPS)) {
-		struct file *swap_file = sis->swap_file;
-		struct address_space *mapping = swap_file->f_mapping;
+		//struct file *swap_file = sis->swap_file;
+		//struct address_space *mapping = swap_file->f_mapping;
 
-		ret = mapping->a_ops->readpage(swap_file, page);
+		/* This needs to use ->swap_rw() */
+		ret = -EINVAL;
 		if (!ret)
 			count_vm_event(PSWPIN);
 		goto out;
@@ -434,17 +434,3 @@ int swap_readpage(struct page *page, bool synchronous)
 	psi_memstall_leave(&pflags);
 	return ret;
 }
-
-int swap_set_page_dirty(struct page *page)
-{
-	struct swap_info_struct *sis = page_swap_info(page);
-
-	if (data_race(sis->flags & SWP_FS_OPS)) {
-		struct address_space *mapping = sis->swap_file->f_mapping;
-
-		VM_BUG_ON_PAGE(!PageSwapCache(page), page);
-		return mapping->a_ops->set_page_dirty(page);
-	} else {
-		return __set_page_dirty_no_writeback(page);
-	}
-}
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 8d4104242100..616eb1d75b35 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -30,7 +30,7 @@
  */
 static const struct address_space_operations swap_aops = {
 	.writepage	= swap_writepage,
-	.set_page_dirty	= swap_set_page_dirty,
+	.set_page_dirty	= __set_page_dirty_no_writeback,
 #ifdef CONFIG_MIGRATION
 	.migratepage	= migrate_page,
 #endif
diff --git a/mm/swapfile.c b/mm/swapfile.c
index e59e08ef46e1..419eacf474c5 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2397,13 +2397,9 @@ static int setup_swap_extents(struct swap_info_struct *sis, sector_t *span)
 
 	if (mapping->a_ops->swap_activate) {
 		ret = mapping->a_ops->swap_activate(sis, swap_file, span);
-		if (ret >= 0)
-			sis->flags |= SWP_ACTIVATED;
-		if (!ret) {
-			sis->flags |= SWP_FS_OPS;
-			ret = add_swap_extent(sis, 0, sis->max, 0);
-			*span = sis->pages;
-		}
+		if (ret < 0)
+			return ret;
+		sis->flags |= SWP_ACTIVATED;
 		return ret;
 	}
 


