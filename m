Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5691A4EB722
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Mar 2022 01:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241331AbiC2Xx5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Mar 2022 19:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241199AbiC2Xxl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Mar 2022 19:53:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4314C2220DE;
        Tue, 29 Mar 2022 16:51:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D2912218F9;
        Tue, 29 Mar 2022 23:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648597906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sLvvpukBNWt13VBBabTsBNGnhJSKURMdgbwJ9UivCME=;
        b=1UD9aAQ8orYrMK0d0F0TErQntCJpTfs64QKgUga1VfuazRBB++sMQf8lzTP7dKndQHHGOp
        4DbHUWSK64s0l0Uwk11IgeOybARpFK+xyPMcYTnAzjRWk2bQtidgvc/iF5HluPfYchA5Sp
        CAa7jCFUKUw1pUDVqC/CaHAnyc0+Y/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648597906;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sLvvpukBNWt13VBBabTsBNGnhJSKURMdgbwJ9UivCME=;
        b=36zu8erF3HUybCY//DfF0XMJtYIgpph+i5zjMsGzt+6uxRgaFQutxNcn5EKYzSLC8tpzjS
        kP8JveVby32aqlBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3A4313A7E;
        Tue, 29 Mar 2022 23:51:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qZkrJ46bQ2I1LwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 29 Mar 2022 23:51:42 +0000
Subject: [PATCH 04/10] MM: reclaim mustn't enter FS for SWP_FS_OPS swap-space
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 30 Mar 2022 10:49:41 +1100
Message-ID: <164859778124.29473.16176717935781721855.stgit@noble.brown>
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

If swap-out is using filesystem operations (SWP_FS_OPS), then it is not
safe to enter the FS for reclaim.
So only down-grade the requirement for swap pages to __GFP_IO after
checking that SWP_FS_OPS are not being used.

This makes the calculation of "may_enter_fs" slightly more complex, so
move it into a separate function.  with that done, there is little value
in maintaining the bool variable any more.  So replace the
may_enter_fs variable with a may_enter_fs() function.  This removes any
risk for the variable becoming out-of-date.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 mm/swap.h   |    8 ++++++++
 mm/vmscan.c |   29 ++++++++++++++++++++---------
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index f8265bf0ce00..e19f185df5e2 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -50,6 +50,10 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
 struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
 			      struct vm_fault *vmf);
 
+static inline unsigned int page_swap_flags(struct page *page)
+{
+	return page_swap_info(page)->flags;
+}
 #else /* CONFIG_SWAP */
 static inline int swap_readpage(struct page *page, bool do_poll)
 {
@@ -129,5 +133,9 @@ static inline void clear_shadow_from_swap_cache(int type, unsigned long begin,
 {
 }
 
+static inline unsigned int page_swap_flags(struct page *page)
+{
+	return 0;
+}
 #endif /* CONFIG_SWAP */
 #endif /* _MM_SWAP_H */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 60378d36ec77..9150754bf2b8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1502,6 +1502,22 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
 	return nr_succeeded;
 }
 
+static bool may_enter_fs(struct page *page, gfp_t gfp_mask)
+{
+	if (gfp_mask & __GFP_FS)
+		return true;
+	if (!PageSwapCache(page) || !(gfp_mask & __GFP_IO))
+		return false;
+	/*
+	 * We can "enter_fs" for swap-cache with only __GFP_IO
+	 * providing this isn't SWP_FS_OPS.
+	 * ->flags can be updated non-atomicially (scan_swap_map_slots),
+	 * but that will never affect SWP_FS_OPS, so the data_race
+	 * is safe.
+	 */
+	return !data_race(page_swap_flags(page) & SWP_FS_OPS);
+}
+
 /*
  * shrink_page_list() returns the number of reclaimed pages
  */
@@ -1528,7 +1544,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 		struct page *page;
 		struct folio *folio;
 		enum page_references references = PAGEREF_RECLAIM;
-		bool dirty, writeback, may_enter_fs;
+		bool dirty, writeback;
 		unsigned int nr_pages;
 
 		cond_resched();
@@ -1553,9 +1569,6 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 		if (!sc->may_unmap && page_mapped(page))
 			goto keep_locked;
 
-		may_enter_fs = (sc->gfp_mask & __GFP_FS) ||
-			(PageSwapCache(page) && (sc->gfp_mask & __GFP_IO));
-
 		/*
 		 * The number of dirty pages determines if a node is marked
 		 * reclaim_congested. kswapd will stall and start writing
@@ -1598,7 +1611,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 		 *    not to fs). In this case mark the page for immediate
 		 *    reclaim and continue scanning.
 		 *
-		 *    Require may_enter_fs because we would wait on fs, which
+		 *    Require may_enter_fs() because we would wait on fs, which
 		 *    may not have submitted IO yet. And the loop driver might
 		 *    enter reclaim, and deadlock if it waits on a page for
 		 *    which it is needed to do the write (loop masks off
@@ -1630,7 +1643,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 
 			/* Case 2 above */
 			} else if (writeback_throttling_sane(sc) ||
-			    !PageReclaim(page) || !may_enter_fs) {
+			    !PageReclaim(page) || !may_enter_fs(page, sc->gfp_mask)) {
 				/*
 				 * This is slightly racy - end_page_writeback()
 				 * might have just cleared PageReclaim, then
@@ -1720,8 +1733,6 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 						goto activate_locked_split;
 				}
 
-				may_enter_fs = true;
-
 				/* Adding to swap updated mapping */
 				mapping = page_mapping(page);
 			}
@@ -1792,7 +1803,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 
 			if (references == PAGEREF_RECLAIM_CLEAN)
 				goto keep_locked;
-			if (!may_enter_fs)
+			if (!may_enter_fs(page, sc->gfp_mask))
 				goto keep_locked;
 			if (!sc->may_writepage)
 				goto keep_locked;


