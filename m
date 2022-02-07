Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD41D4AB477
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Feb 2022 07:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiBGGPl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Feb 2022 01:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352033AbiBGErR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Feb 2022 23:47:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC69C043181;
        Sun,  6 Feb 2022 20:47:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5D4771F37F;
        Mon,  7 Feb 2022 04:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644209235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aJeimCLV8LLTUkUjAiRuHMND8QpvrJbpAXji1B8C5fw=;
        b=eiXhvuURk6X3oyWXqxv/Z7XIKjVfwAB5btUvlgkYVv6xaYKcPvxlZPihlbJFkFb1vePjB9
        oQEf/+ABDHHEGwAzoG11bbuQjSHu9PVN6qlAm+5QIm8FFLJov1f7iKbAHdf1Vl1Wr3z3eO
        ZeEo9g0fSq0uP6ose9eVRKTW5PXVDR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644209235;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aJeimCLV8LLTUkUjAiRuHMND8QpvrJbpAXji1B8C5fw=;
        b=SIQFoD9QKd0q3Ew15UnxNqGawIo+F+FJ8e2Bg6kfLHU/87iovD0eaiPVHn8ne9JzvZbe9k
        whcYQiYZJgiLdYBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49A9B1330E;
        Mon,  7 Feb 2022 04:47:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5j58AVCkAGIcNQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 07 Feb 2022 04:47:12 +0000
Subject: [PATCH 04/21] MM: reclaim mustn't enter FS for SWP_FS_OPS swap-space
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Hemment <markhemm@googlemail.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 07 Feb 2022 15:46:01 +1100
Message-ID: <164420916113.29374.6507434037983544219.stgit@noble.brown>
In-Reply-To: <164420889455.29374.17958998143835612560.stgit@noble.brown>
References: <164420889455.29374.17958998143835612560.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
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
index 13e72a5023aa..5c676e55f288 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -47,6 +47,10 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
 struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
 			      struct vm_fault *vmf);
 
+static inline unsigned int page_swap_flags(struct page *page)
+{
+	return page_swap_info(page)->flags;
+}
 #else /* CONFIG_SWAP */
 static inline int swap_readpage(struct page *page, bool do_poll)
 {
@@ -126,4 +130,8 @@ static inline void clear_shadow_from_swap_cache(int type, unsigned long begin,
 {
 }
 
+static inline unsigned int page_swap_flags(struct page *page)
+{
+	return 0;
+}
 #endif /* CONFIG_SWAP */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5c734ffc6057..ad5026d06aa8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1506,6 +1506,22 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
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
@@ -1531,7 +1547,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 		struct address_space *mapping;
 		struct page *page;
 		enum page_references references = PAGEREF_RECLAIM;
-		bool dirty, writeback, may_enter_fs;
+		bool dirty, writeback;
 		unsigned int nr_pages;
 
 		cond_resched();
@@ -1555,9 +1571,6 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 		if (!sc->may_unmap && page_mapped(page))
 			goto keep_locked;
 
-		may_enter_fs = (sc->gfp_mask & __GFP_FS) ||
-			(PageSwapCache(page) && (sc->gfp_mask & __GFP_IO));
-
 		/*
 		 * The number of dirty pages determines if a node is marked
 		 * reclaim_congested. kswapd will stall and start writing
@@ -1602,7 +1615,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 		 *    not to fs). In this case mark the page for immediate
 		 *    reclaim and continue scanning.
 		 *
-		 *    Require may_enter_fs because we would wait on fs, which
+		 *    Require may_enter_fs() because we would wait on fs, which
 		 *    may not have submitted IO yet. And the loop driver might
 		 *    enter reclaim, and deadlock if it waits on a page for
 		 *    which it is needed to do the write (loop masks off
@@ -1634,7 +1647,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 
 			/* Case 2 above */
 			} else if (writeback_throttling_sane(sc) ||
-			    !PageReclaim(page) || !may_enter_fs) {
+			    !PageReclaim(page) || !may_enter_fs(page, sc->gfp_mask)) {
 				/*
 				 * This is slightly racy - end_page_writeback()
 				 * might have just cleared PageReclaim, then
@@ -1724,8 +1737,6 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 						goto activate_locked_split;
 				}
 
-				may_enter_fs = true;
-
 				/* Adding to swap updated mapping */
 				mapping = page_mapping(page);
 			}
@@ -1795,7 +1806,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 
 			if (references == PAGEREF_RECLAIM_CLEAN)
 				goto keep_locked;
-			if (!may_enter_fs)
+			if (!may_enter_fs(page, sc->gfp_mask))
 				goto keep_locked;
 			if (!sc->may_writepage)
 				goto keep_locked;


