Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696464977CA
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 04:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241145AbiAXDu1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 Jan 2022 22:50:27 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56712 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241158AbiAXDuZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 Jan 2022 22:50:25 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D5C1B212C4;
        Mon, 24 Jan 2022 03:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642996223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D6Vgok4rvR931e84UowBUSY8Jhoy2T4G53/bpYOdzRw=;
        b=qfTfxaPO9wnYVoBpIIE4Bljj6FUowggfuzi9HAhgJO5UeDZhGeWxSvTeNGMNzNdqzj5q/x
        teZTiG5lmG/qnDYcjYQYidQ+qe+3TI1dv8UU0+oBvrK7BeTJA76lg4i3JBKBPNOGgjRzae
        wRzUbqVHPc/4S7zSzgvsnBuk4jsJFGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642996223;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D6Vgok4rvR931e84UowBUSY8Jhoy2T4G53/bpYOdzRw=;
        b=fHub5mvlaa9hxdwcNnTf3ORPPh3W/K0C5TrT/E/tOmfoH8eOG+D0gqlf+Ypq4/HPKgqBC9
        mwQMdUwjy+CDuiDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D247F1331A;
        Mon, 24 Jan 2022 03:50:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id H0GBI/wh7mGkRAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 24 Jan 2022 03:50:20 +0000
Subject: [PATCH 02/23] MM: extend block-plugging to cover all swap reads with
 read-ahead
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
Message-ID: <164299611274.26253.13900771841681128440.stgit@noble.brown>
In-Reply-To: <164299573337.26253.7538614611220034049.stgit@noble.brown>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Code that does swap read-ahead uses blk_start_plug() and
blk_finish_plug() to allow lower levels to combine multiple read-ahead
pages into a single request, but calls blk_finish_plug() *before*
submitting the original (non-ahead) read request.
This missed an opportunity to combine read requests.

This patch moves the blk_finish_plug to *after* all the reads.
This will likely combine the primary read with some of the "ahead"
reads, and that may slightly increase the latency of that read, but it
should more than make up for this by making more efficient use of the
storage path.

The patch mostly makes the code look more consistent.  Performance
change is unlikely to be noticeable.

Fixes-no-auto-backport: 3fb5c298b04e ("swap: allow swap readahead to be merged")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 mm/swap_state.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index bb38453425c7..093ecf864200 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -625,6 +625,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long addr = vmf->address;
 
+	blk_start_plug(&plug);
 	mask = swapin_nr_pages(offset) - 1;
 	if (!mask)
 		goto skip;
@@ -638,7 +639,6 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	if (end_offset >= si->max)
 		end_offset = si->max - 1;
 
-	blk_start_plug(&plug);
 	for (offset = start_offset; offset <= end_offset ; offset++) {
 		/* Ok, do the async read-ahead now */
 		page = __read_swap_cache_async(
@@ -655,11 +655,12 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 		}
 		put_page(page);
 	}
-	blk_finish_plug(&plug);
 
 	lru_add_drain();	/* Push any new pages onto the LRU now */
 skip:
-	return read_swap_cache_async(entry, gfp_mask, vma, addr, do_poll);
+	page = read_swap_cache_async(entry, gfp_mask, vma, addr, do_poll);
+	blk_finish_plug(&plug);
+	return page;
 }
 
 int init_swap_address_space(unsigned int type, unsigned long nr_pages)
@@ -800,11 +801,11 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 		.win = 1,
 	};
 
+	blk_start_plug(&plug);
 	swap_ra_info(vmf, &ra_info);
 	if (ra_info.win == 1)
 		goto skip;
 
-	blk_start_plug(&plug);
 	for (i = 0, pte = ra_info.ptes; i < ra_info.nr_pte;
 	     i++, pte++) {
 		pentry = *pte;
@@ -828,11 +829,12 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 		}
 		put_page(page);
 	}
-	blk_finish_plug(&plug);
 	lru_add_drain();
 skip:
-	return read_swap_cache_async(fentry, gfp_mask, vma, vmf->address,
+	page = read_swap_cache_async(fentry, gfp_mask, vma, vmf->address,
 				     ra_info.win == 1);
+	blk_finish_plug(&plug);
+	return page;
 }
 
 /**


