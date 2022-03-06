Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BDE4CEEBE
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Mar 2022 00:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbiCFXvR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 6 Mar 2022 18:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbiCFXvQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Mar 2022 18:51:16 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B64311A28;
        Sun,  6 Mar 2022 15:50:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C5255210EA;
        Sun,  6 Mar 2022 23:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646610621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lZH8vAFfstzfM+lYeO53VVp0wab9zGxNQbH6C49Gyvo=;
        b=Svpl9q17OIjFIIBYiKhN9ZjPe7kBb9v+nX84v62isFYX+51l0P2f29/WoWZy+93aKc/v1K
        asHW6R19Xfg1sgYRyqkLSmywuoPuvcGdsxYJrjPyldtukccBo/+UsQepj103nAYHFXuPJS
        /lkHdCnT4V7gxVXsXmf0qH6zT1ns7Bo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646610621;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lZH8vAFfstzfM+lYeO53VVp0wab9zGxNQbH6C49Gyvo=;
        b=neV2R28DcJZx0P0duP5oeAVdQ23fpIrFX6HVyGz10xuP1X/c8b+zuRiLv4a1JiODBUTtLJ
        mLV3ljo3hN2eHXBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB65B134CD;
        Sun,  6 Mar 2022 23:50:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KosMKrtIJWIgWgAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 06 Mar 2022 23:50:19 +0000
Subject: [PATCH 02/10] MM: drop swap_set_page_dirty
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Mon, 07 Mar 2022 10:49:38 +1100
Message-ID: <164661057804.13454.1512972233576670792.stgit@noble.brown>
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
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
index bb38453425c7..514b86b05488 100644
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


