Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9EE31B8BC
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Feb 2021 13:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhBOMHG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Feb 2021 07:07:06 -0500
Received: from outbound-smtp14.blacknight.com ([46.22.139.231]:41883 "EHLO
        outbound-smtp14.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229994AbhBOMHD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Feb 2021 07:07:03 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp14.blacknight.com (Postfix) with ESMTPS id 6AC3A1C3421
        for <linux-nfs@vger.kernel.org>; Mon, 15 Feb 2021 12:06:10 +0000 (GMT)
Received: (qmail 31181 invoked from network); 15 Feb 2021 12:06:10 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 15 Feb 2021 12:06:10 -0000
Date:   Mon, 15 Feb 2021 12:06:09 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Mel Gorman <mgorman@suse.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: alloc_pages_bulk()
Message-ID: <20210215120608.GE3697@techsingularity.net>
References: <2A0C36E7-8CB0-486F-A8DB-463CA28C5C5D@oracle.com>
 <EEB0B974-6E63-41A0-9C01-F0DEA39FC4BF@oracle.com>
 <20210209113108.1ca16cfa@carbon>
 <20210210084155.GA3697@techsingularity.net>
 <20210210124103.56ed1e95@carbon>
 <20210210130705.GC3629@suse.de>
 <B123FB11-661F-45A6-8235-2982BF3C4B83@oracle.com>
 <20210211091235.GC3697@techsingularity.net>
 <F3CD435E-905F-4262-B4DA-0C721A4235E1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <F3CD435E-905F-4262-B4DA-0C721A4235E1@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Feb 11, 2021 at 04:20:31PM +0000, Chuck Lever wrote:
> > On Feb 11, 2021, at 4:12 AM, Mel Gorman <mgorman@techsingularity.net> wrote:
> > 
> > <SNIP>
> > 
> > Parameters to __rmqueue_pcplist are garbage as the parameter order changed.
> > I'm surprised it didn't blow up in a spectacular fashion. Again, this
> > hasn't been near any testing and passing a list with high orders to
> > free_pages_bulk() will corrupt lists too. Mostly it's a curiousity to see
> > if there is justification for reworking the allocator to fundamentally
> > deal in batches and then feed batches to pcp lists and the bulk allocator
> > while leaving the normal GFP API as single page "batches". While that
> > would be ideal, it's relatively high risk for regressions. There is still
> > some scope for adding a basic bulk allocator before considering a major
> > refactoring effort.
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index f8353ea7b977..8f3fe7de2cf7 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -5892,7 +5892,7 @@ __alloc_pages_bulk_nodemask(gfp_t gfp_mask, unsigned int order,
> > 	pcp_list = &pcp->lists[migratetype];
> > 
> > 	while (nr_pages) {
> > -		page = __rmqueue_pcplist(zone, gfp_mask, migratetype,
> > +		page = __rmqueue_pcplist(zone, migratetype, alloc_flags,
> > 								pcp, pcp_list);
> > 		if (!page)
> > 			break;
> 
> The NFS server is considerably more stable now. Thank you!
> 

Thanks for testing!

> I confirmed that my patch is requesting and getting multiple pages.
> The new NFSD code and the API seem to be working as expected.
> 
> The results are stunning. Each svc_alloc_arg() call here allocates
> 65 pages to satisfy a 256KB NFS READ request.
> 
> Before:
> 
>             nfsd-972   [000]   584.513817: funcgraph_entry:      + 35.385 us  |  svc_alloc_arg();
>             nfsd-979   [002]   584.513870: funcgraph_entry:      + 29.051 us  |  svc_alloc_arg();
>             nfsd-980   [001]   584.513951: funcgraph_entry:      + 29.178 us  |  svc_alloc_arg();
>             nfsd-983   [000]   584.514014: funcgraph_entry:      + 29.211 us  |  svc_alloc_arg();
>             nfsd-976   [002]   584.514059: funcgraph_entry:      + 29.315 us  |  svc_alloc_arg();
>             nfsd-974   [001]   584.514127: funcgraph_entry:      + 29.237 us  |  svc_alloc_arg();
> 
> After:
> 
>             nfsd-977   [002]    87.049425: funcgraph_entry:        4.293 us   |  svc_alloc_arg();
>             nfsd-981   [000]    87.049478: funcgraph_entry:        4.059 us   |  svc_alloc_arg();
>             nfsd-988   [001]    87.049549: funcgraph_entry:        4.474 us   |  svc_alloc_arg();
>             nfsd-983   [003]    87.049612: funcgraph_entry:        3.819 us   |  svc_alloc_arg();
>             nfsd-976   [000]    87.049619: funcgraph_entry:        3.869 us   |  svc_alloc_arg();
>             nfsd-980   [002]    87.049738: funcgraph_entry:        4.124 us   |  svc_alloc_arg();
>             nfsd-975   [000]    87.049769: funcgraph_entry:        3.734 us   |  svc_alloc_arg();
> 

Uhhhh, that is much better than I expected given how lame the
implementation is. Sure -- it works, but it has more overhead than it
should with the downside that reducing it requires fairly deep surgery. It
may be enough to tidy this up to handle order-0 pages only to start with
and see how far it gets. That's a fairly trivial modification.

> There appears to be little cost change for single-page allocations
> using the bulk allocator (nr_pages=1):
> 
> Before:
> 
>             nfsd-985   [003]   572.324517: funcgraph_entry:        0.332 us   |  svc_alloc_arg();
>             nfsd-986   [001]   572.324531: funcgraph_entry:        0.311 us   |  svc_alloc_arg();
>             nfsd-985   [003]   572.324701: funcgraph_entry:        0.311 us   |  svc_alloc_arg();
>             nfsd-986   [001]   572.324727: funcgraph_entry:        0.424 us   |  svc_alloc_arg();
>             nfsd-985   [003]   572.324760: funcgraph_entry:        0.332 us   |  svc_alloc_arg();
>             nfsd-986   [001]   572.324786: funcgraph_entry:        0.390 us   |  svc_alloc_arg();
> 
> After:
> 
>             nfsd-989   [002]    75.043226: funcgraph_entry:        0.322 us   |  svc_alloc_arg();
>             nfsd-988   [001]    75.043436: funcgraph_entry:        0.368 us   |  svc_alloc_arg();
>             nfsd-989   [002]    75.043464: funcgraph_entry:        0.424 us   |  svc_alloc_arg();
>             nfsd-988   [001]    75.043490: funcgraph_entry:        0.317 us   |  svc_alloc_arg();
>             nfsd-989   [002]    75.043517: funcgraph_entry:        0.425 us   |  svc_alloc_arg();
>             nfsd-988   [001]    75.050025: funcgraph_entry:        0.407 us   |  svc_alloc_arg();
> 

That is not too surprising given that there would be some additional
overhead to manage a list of 1 page. I would hope that users of the bulk
allocator are not routinely calling it with nr_pages == 1.

-- 
Mel Gorman
SUSE Labs
