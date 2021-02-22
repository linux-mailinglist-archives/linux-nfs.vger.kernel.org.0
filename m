Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F260C32135A
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Feb 2021 10:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhBVJoq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Feb 2021 04:44:46 -0500
Received: from outbound-smtp48.blacknight.com ([46.22.136.219]:35019 "EHLO
        outbound-smtp48.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230340AbhBVJoh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Feb 2021 04:44:37 -0500
X-Greylist: delayed 510 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Feb 2021 04:44:36 EST
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp48.blacknight.com (Postfix) with ESMTPS id A3920FA9C3
        for <linux-nfs@vger.kernel.org>; Mon, 22 Feb 2021 09:35:06 +0000 (GMT)
Received: (qmail 3587 invoked from network); 22 Feb 2021 09:35:06 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Feb 2021 09:35:06 -0000
Date:   Mon, 22 Feb 2021 09:35:05 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org, kuba@kernel.org
Subject: Re: [PATCH RFC] SUNRPC: Refresh rq_pages using a bulk page allocator
Message-ID: <20210222093505.GG3697@techsingularity.net>
References: <161340498400.7780.962495219428962117.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <161340498400.7780.962495219428962117.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Feb 15, 2021 at 11:06:07AM -0500, Chuck Lever wrote:
> Reduce the rate at which nfsd threads hammer on the page allocator.
> This improves throughput scalability by enabling the nfsd threads to
> run more independently of each other.
> 

Sorry this is taking so long, there is a lot going on.

This patch has pre-requisites that are not in mainline which makes it
harder to evaluate what the semantics of the API should be.

> @@ -659,19 +659,33 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
>  		/* use as many pages as possible */
>  		pages = RPCSVC_MAXPAGES;
>  	}
> -	for (i = 0; i < pages ; i++)
> -		while (rqstp->rq_pages[i] == NULL) {
> -			struct page *p = alloc_page(GFP_KERNEL);
> -			if (!p) {
> -				set_current_state(TASK_INTERRUPTIBLE);
> -				if (signalled() || kthread_should_stop()) {
> -					set_current_state(TASK_RUNNING);
> -					return -EINTR;
> -				}
> -				schedule_timeout(msecs_to_jiffies(500));
> +
> +	for (needed = 0, i = 0; i < pages ; i++)
> +		if (!rqstp->rq_pages[i])
> +			needed++;
> +	if (needed) {
> +		LIST_HEAD(list);
> +
> +retry:
> +		alloc_pages_bulk(GFP_KERNEL, 0,
> +				 /* to test the retry logic: */
> +				 min_t(unsigned long, needed, 13),
> +				 &list);
> +		for (i = 0; i < pages; i++) {
> +			if (!rqstp->rq_pages[i]) {
> +				struct page *page;
> +
> +				page = list_first_entry_or_null(&list,
> +								struct page,
> +								lru);
> +				if (unlikely(!page))
> +					goto empty_list;
> +				list_del(&page->lru);
> +				rqstp->rq_pages[i] = page;
> +				needed--;
>  			}
> -			rqstp->rq_pages[i] = p;
>  		}
> +	}
>  	rqstp->rq_page_end = &rqstp->rq_pages[pages];
>  	rqstp->rq_pages[pages] = NULL; /* this might be seen in nfsd_splice_actor() */
>  

There is a conflict at the end where rq_page_end gets updated. The 5.11
code assumes that the loop around the allocator definitely gets all
the required pages. What tree is this patch based on and is it going in
during this merge window? While the conflict is "trivial" to resolve,
it would be buggy because on retry, "i" will be pointing to the wrong
index and pages potentially leak. Rather than guessing, I'd prefer to
base a series on code you've tested.

The slowpath for the bulk allocator also sucks a bit for the semantics
required by this caller. As the bulk allocator does not walk the zonelist,
it can return failures prematurely -- fine for an optimistic bulk allocator
that can return a subset of pages but not for this caller which really
wants those pages. The allocator may need NOFAIL-like semantics to walk
the zonelist if the caller really requires success or at least walk the
zonelist if the preferred zone is low on pages. This patch would also
need to preserve the schedule_timeout behaviour so it does not use a lot
of CPU time retrying allocations in the presense of memory pressure.

-- 
Mel Gorman
SUSE Labs
