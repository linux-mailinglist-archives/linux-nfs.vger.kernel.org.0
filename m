Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC724527F3
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 03:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357264AbhKPCuw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Nov 2021 21:50:52 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37338 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357221AbhKPCsu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Nov 2021 21:48:50 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DCE7C1FD67;
        Tue, 16 Nov 2021 02:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637030752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SCPnWzrli9uhGf5cSQnA2kslw6w9vTsO2ZaI10TRMW0=;
        b=pZE6Mn45OybuBUV0fFOy6OA0abrIA0AR+Fglj1GmFirEaWFtVDkCDYxp+ocPMp60lDJ7N2
        TaWmdEQKPcqYIl2pmPRYlaKiDIw7u0icJyyQk2e/fKk1Mzsv1R0v4/yvnKIgkZCWcNlf83
        VqbAdkFTRkcWYEkojriQxOzGfTp73+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637030752;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SCPnWzrli9uhGf5cSQnA2kslw6w9vTsO2ZaI10TRMW0=;
        b=8qHcqlPn9r3KPsRJ2cy06JSUnxN3MrXeqxOuPnS8oTruMA9u3t2SC7iQhU5U1gJPcf5I7b
        3IWDw2sfjb9aJ/Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84C4713B70;
        Tue, 16 Nov 2021 02:45:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AYUoLF0bk2HZCAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 16 Nov 2021 02:45:49 +0000
Subject: [PATCH 03/13] MM: reclaim mustn't enter FS for swap-over-NFS
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 16 Nov 2021 13:44:04 +1100
Message-ID: <163703064452.25805.16932817889703270242.stgit@noble.brown>
In-Reply-To: <163702956672.25805.16457749992977493579.stgit@noble.brown>
References: <163702956672.25805.16457749992977493579.stgit@noble.brown>
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
 mm/vmscan.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index fb9584641ac7..049ff4494081 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1513,8 +1513,14 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 		if (!sc->may_unmap && page_mapped(page))
 			goto keep_locked;
 
+		/* ->flags can be updated non-atomicially (scan_swap_map_slots),
+		 * but that will never affect SWP_FS_OPS, so the data_race
+		 * is safe.
+		 */
 		may_enter_fs = (sc->gfp_mask & __GFP_FS) ||
-			(PageSwapCache(page) && (sc->gfp_mask & __GFP_IO));
+			(PageSwapCache(page) &&
+			 !data_race(page_swap_info(page)->flags & SWP_FS_OPS) &&
+			 (sc->gfp_mask & __GFP_IO));
 
 		/*
 		 * The number of dirty pages determines if a node is marked
@@ -1682,7 +1688,9 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 						goto activate_locked_split;
 				}
 
-				may_enter_fs = true;
+				if ((sc->gfp_mask & __GFP_FS) ||
+				    !data_race(page_swap_info(page)->flags & SWP_FS_OPS))
+					may_enter_fs = true;
 
 				/* Adding to swap updated mapping */
 				mapping = page_mapping(page);


