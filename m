Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1E2534C76
	for <lists+linux-nfs@lfdr.de>; Thu, 26 May 2022 11:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbiEZJWE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 May 2022 05:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiEZJWE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 May 2022 05:22:04 -0400
X-Greylist: delayed 590 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 May 2022 02:22:03 PDT
Received: from outbound-smtp23.blacknight.com (outbound-smtp23.blacknight.com [81.17.249.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA86D123
        for <linux-nfs@vger.kernel.org>; Thu, 26 May 2022 02:22:03 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp23.blacknight.com (Postfix) with ESMTPS id CEAD3BEBF9
        for <linux-nfs@vger.kernel.org>; Thu, 26 May 2022 10:12:11 +0100 (IST)
Received: (qmail 7312 invoked from network); 26 May 2022 09:12:11 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 May 2022 09:12:11 -0000
Date:   Thu, 26 May 2022 10:12:10 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux-NFS <linux-nfs@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-XFS <linux-xfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/page_alloc: Always attempt to allocate at least one page
 during bulk allocation
Message-ID: <20220526091210.GC3441@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Peter Pavlisko reported the following problem on kernel bugzilla 216007.

	When I try to extract an uncompressed tar archive (2.6 milion
	files, 760.3 GiB in size) on newly created (empty) XFS file system,
	after first low tens of gigabytes extracted the process hangs in
	iowait indefinitely. One CPU core is 100% occupied with iowait,
	the other CPU core is idle (on 2-core Intel Celeron G1610T).

It was bisected to c9fa563072e1 ("xfs: use alloc_pages_bulk_array() for
buffers") but XFS is only the messenger. The problem is that nothing
is waking kswapd to reclaim some pages at a time the PCP lists cannot
be refilled until some reclaim happens. The bulk allocator checks that
there are some pages in the array and the original intent was that a bulk
allocator did not necessarily need all the requested pages and it was
best to return as quickly as possible. This was fine for the first user
of the API but both NFS and XFS require the requested number of pages
be available before making progress. Both could be adjusted to call the
page allocator directly if a bulk allocation fails but it puts a burden on
users of the API. Adjust the semantics to attempt at least one allocation
via __alloc_pages() before returning so kswapd is woken if necessary.

It was reported via bugzilla that the patch addressed the problem and
that the tar extraction completed successfully. This may also address
bug 215975 but has yet to be confirmed.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=216007
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215975
Fixes: 387ba26fb1cb ("mm/page_alloc: add a bulk page allocator")
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Cc: <stable@vger.kernel.org> # v5.13+
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0e42038382c1..5ced6cb260ed 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5324,8 +5324,8 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		page = __rmqueue_pcplist(zone, 0, ac.migratetype, alloc_flags,
 								pcp, pcp_list);
 		if (unlikely(!page)) {
-			/* Try and get at least one page */
-			if (!nr_populated)
+			/* Try and allocate at least one page */
+			if (!nr_account)
 				goto failed_irq;
 			break;
 		}
