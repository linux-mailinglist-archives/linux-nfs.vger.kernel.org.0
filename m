Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35016535756
	for <lists+linux-nfs@lfdr.de>; Fri, 27 May 2022 03:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiE0BcO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 May 2022 21:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiE0BcN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 May 2022 21:32:13 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B6D5554A5;
        Thu, 26 May 2022 18:32:12 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 6ABCA10E6C82;
        Fri, 27 May 2022 11:32:09 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nuOpk-00GqFC-1C; Fri, 27 May 2022 11:32:08 +1000
Date:   Fri, 27 May 2022 11:32:08 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux-NFS <linux-nfs@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-XFS <linux-xfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/page_alloc: Always attempt to allocate at least one
 page during bulk allocation
Message-ID: <20220527013208.GT1098723@dread.disaster.area>
References: <20220526091210.GC3441@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526091210.GC3441@techsingularity.net>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=62902a1b
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=VwQbUJbxAAAA:8 a=R_Myd5XaAAAA:8
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=rgy_-LtZnV2ddjrNTikA:9
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=L2g4Dz8VuBQ37YGmWQah:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, May 26, 2022 at 10:12:10AM +0100, Mel Gorman wrote:
> Peter Pavlisko reported the following problem on kernel bugzilla 216007.
> 
> 	When I try to extract an uncompressed tar archive (2.6 milion
> 	files, 760.3 GiB in size) on newly created (empty) XFS file system,
> 	after first low tens of gigabytes extracted the process hangs in
> 	iowait indefinitely. One CPU core is 100% occupied with iowait,
> 	the other CPU core is idle (on 2-core Intel Celeron G1610T).
> 
> It was bisected to c9fa563072e1 ("xfs: use alloc_pages_bulk_array() for
> buffers") but XFS is only the messenger. The problem is that nothing
> is waking kswapd to reclaim some pages at a time the PCP lists cannot
> be refilled until some reclaim happens. The bulk allocator checks that
> there are some pages in the array and the original intent was that a bulk
> allocator did not necessarily need all the requested pages and it was
> best to return as quickly as possible. This was fine for the first user
> of the API but both NFS and XFS require the requested number of pages
> be available before making progress. Both could be adjusted to call the
> page allocator directly if a bulk allocation fails but it puts a burden on
> users of the API. Adjust the semantics to attempt at least one allocation
> via __alloc_pages() before returning so kswapd is woken if necessary.
> 
> It was reported via bugzilla that the patch addressed the problem and
> that the tar extraction completed successfully. This may also address
> bug 215975 but has yet to be confirmed.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=216007
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215975
> Fixes: 387ba26fb1cb ("mm/page_alloc: add a bulk page allocator")
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Cc: <stable@vger.kernel.org> # v5.13+
> ---
>  mm/page_alloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0e42038382c1..5ced6cb260ed 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5324,8 +5324,8 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  		page = __rmqueue_pcplist(zone, 0, ac.migratetype, alloc_flags,
>  								pcp, pcp_list);
>  		if (unlikely(!page)) {
> -			/* Try and get at least one page */
> -			if (!nr_populated)
> +			/* Try and allocate at least one page */
> +			if (!nr_account)
>  				goto failed_irq;
>  			break;
>  		}

Looks like a sane fix to me.

Acked-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
