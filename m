Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6069A5365BF
	for <lists+linux-nfs@lfdr.de>; Fri, 27 May 2022 18:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbiE0QKt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 May 2022 12:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbiE0QKr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 May 2022 12:10:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6DC149AAE;
        Fri, 27 May 2022 09:10:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B992161DCE;
        Fri, 27 May 2022 16:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BE4C385B8;
        Fri, 27 May 2022 16:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653667846;
        bh=itJVIn2kS9CTYYtN7F5XJg9N57RQi68GqnXIyBbsDbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=joYS+nl4UxW45XHGqcuafMlcSrRrjugnBPqgF3oBzTltLYf6wHBeAkim+u/T4/cPR
         W/qqKoC6iLaQHzv+o9CcPfJ503d5zdPR/rKQvMbLaf4ZlTAapRUohLV6eRTtSrrGCs
         gZ82TjggIc4JwT/TUmp7C99vDIpSuaihpeqHFPzmeLtt7InLkZZh42ZPgcQxianCz9
         D7JdlFSX+RDGT2b7ySgpalSsy0YtLlgOmTA/tTBna/S5VZxdxKDhtuVfVVpjaKikLR
         hDHMPHCg61mRSEfWeF5L4hrkA3h+f3TepE8nKnCqQotBzsMmUZ4JXXp/ZtG1tMlFcw
         sww9DCcnADGvw==
Date:   Fri, 27 May 2022 09:10:45 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <YpD4BSZDgF5xv0mL@magnolia>
References: <20220526091210.GC3441@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526091210.GC3441@techsingularity.net>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Seems to have survived overnight fstests on XFS, so...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

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
