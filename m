Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6164977CD
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 04:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241136AbiAXDuj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 Jan 2022 22:50:39 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56726 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241127AbiAXDuj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 Jan 2022 22:50:39 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2D57B21992;
        Mon, 24 Jan 2022 03:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642996238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gFsUp8HKMYNcCQgqtdLRsr/SQ1VZIk4d6vfDv1KaX7Q=;
        b=pO0+LXrfPSf9dWW/VanX0xUHulM+fd1K3FfTbHbPDhGLhgNSni5zK+cAX1QPQI7qMEU63I
        gJaM5xqfn7Nzh8M7mFy/NrQa9Sbl6bvCT4dG5jDalX8gwPj0Pm9TtUNKwC+w7IxSCOA+K+
        O0Jro5AEQwI3ETSyW729heTS8bywm/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642996238;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gFsUp8HKMYNcCQgqtdLRsr/SQ1VZIk4d6vfDv1KaX7Q=;
        b=vehXOo1OzvhIHeGTbbCYYY7BPju50owculff0ll6phq6ubuMvOioyqUGUy6DgzdsgnRo6l
        1YuxCJvGuN1DY0DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 309B01331A;
        Mon, 24 Jan 2022 03:50:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id klWQNwoi7mG0RAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 24 Jan 2022 03:50:34 +0000
Subject: [PATCH 03/23] MM: drop swap_set_page_dirty
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
Message-ID: <164299611274.26253.3394253485576079921.stgit@noble.brown>
In-Reply-To: <164299573337.26253.7538614611220034049.stgit@noble.brown>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Pages that are written to swap are owned by the MM subsystem - not any
filesystem.

When such a page is passed to a filesystem to be written out to a
swap-file, the filesystem handles the data, but the page itself does not
belong to the filesystem.  So calling the filesystem's set_page_dirty
address_space operation makes no sense.  This is for pages in the given
address space, and a page to be written to swap does not exist in the
given address space.

So drop swap_set_page_dirty() which calls the address-space's
set_page_dirty, and alway use __set_page_dirty_no_writeback, which is
appropriate for pages being swapped out.

Fixes-no-auto-backport: 62c230bc1790 ("mm: add support for a filesystem to activate swap files and use direct_IO for writing swap pages")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/swap.h |    1 -
 mm/page_io.c         |   14 --------------
 mm/swap_state.c      |    2 +-
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 3f54a8941c9d..a43929f7033e 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -419,7 +419,6 @@ extern void kswapd_stop(int nid);
 
 #ifdef CONFIG_SWAP
 
-extern int swap_set_page_dirty(struct page *page);
 int add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
 		unsigned long nr_pages, sector_t start_block);
 int generic_swapfile_activate(struct swap_info_struct *, struct file *,
diff --git a/mm/page_io.c b/mm/page_io.c
index f8c26092e869..34b12d6f94d7 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -438,17 +438,3 @@ int swap_readpage(struct page *page, bool synchronous)
 	delayacct_swapin_end();
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
index 093ecf864200..d541594be1c3 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -31,7 +31,7 @@
  */
 static const struct address_space_operations swap_aops = {
 	.writepage	= swap_writepage,
-	.set_page_dirty	= swap_set_page_dirty,
+	.set_page_dirty	= __set_page_dirty_no_writeback,
 #ifdef CONFIG_MIGRATION
 	.migratepage	= migrate_page,
 #endif


