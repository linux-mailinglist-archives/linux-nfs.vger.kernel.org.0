Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3374780E0
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 00:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhLPXwv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Dec 2021 18:52:51 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56340 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhLPXwu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Dec 2021 18:52:50 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 964391F3A1;
        Thu, 16 Dec 2021 23:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639698769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ousG1C9Pxwr7ZMS3mSr07mvDQMxv5ZghnPgeMf5y5g=;
        b=LZTBmx+YstZRDskbnMwV6zkDjYe93SBkIGqjHStCAnwzjkMxskosNMqvaccsA+Kajs/Y3e
        4TyAjP1udslAhzgZqWgznoYCzWqn0Y95H78dR0yIqzarh8rdmbErnaoKXTUpSNXPgyKvT/
        G+IUkpEySr3DlAty65nYefYOE+JC1kI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639698769;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ousG1C9Pxwr7ZMS3mSr07mvDQMxv5ZghnPgeMf5y5g=;
        b=IxGPaeBY0t2YOmBoUfLGHbsyDNeAXuMNUW8TD3DA5PWYhO6cDHdZji2FUTqXBz5ZTOh7Vx
        5QIeulAD/grm24Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87F9513EFD;
        Thu, 16 Dec 2021 23:52:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vcfFEE7Ru2FlWwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 16 Dec 2021 23:52:46 +0000
Subject: [PATCH 05/18] MM: reclaim mustn't enter FS for SWP_FS_OPS swap-space
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
Message-ID: <163969850295.20885.4255989535187500085.stgit@noble.brown>
In-Reply-To: <163969801519.20885.3977673503103544412.stgit@noble.brown>
References: <163969801519.20885.3977673503103544412.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If swap-out is using filesystem operations (SWP_FS_OPS), then it is not
safe to enter the FS for reclaim.
So only down-grade the requirement for swap pages to __GFP_IO after
checking that SWP_FS_OPS are not being used.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 mm/vmscan.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 969bcdb4ca80..5f460d174b1b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1465,6 +1465,21 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
 	return nr_succeeded;
 }
 
+static bool test_may_enter_fs(struct page *page, gfp_t gfp_mask)
+{
+	if (gfp_mask & __GFP_FS)
+		return true;
+	if (!PageSwapCache(page) || !(gfp_mask & __GFP_IO))
+		return false;
+	/* We can "enter_fs" for swap-cache with only __GFP_IO
+	 * providing this isn't SWP_FS_OPS.
+	 * ->flags can be updated non-atomicially (scan_swap_map_slots),
+	 * but that will never affect SWP_FS_OPS, so the data_race
+	 * is safe.
+	 */
+	return !data_race(page_swap_info(page)->flags & SWP_FS_OPS);
+}
+
 /*
  * shrink_page_list() returns the number of reclaimed pages
  */
@@ -1514,8 +1529,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 		if (!sc->may_unmap && page_mapped(page))
 			goto keep_locked;
 
-		may_enter_fs = (sc->gfp_mask & __GFP_FS) ||
-			(PageSwapCache(page) && (sc->gfp_mask & __GFP_IO));
+		may_enter_fs = test_may_enter_fs(page, sc->gfp_mask);
 
 		/*
 		 * The number of dirty pages determines if a node is marked
@@ -1683,7 +1697,8 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 						goto activate_locked_split;
 				}
 
-				may_enter_fs = true;
+				may_enter_fs = test_may_enter_fs(page,
+								 sc->gfp_mask);
 
 				/* Adding to swap updated mapping */
 				mapping = page_mapping(page);


