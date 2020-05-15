Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63941D4C26
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2020 13:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgEOLKp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 May 2020 07:10:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:35838 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgEOLKp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 15 May 2020 07:10:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3EC1AAE61;
        Fri, 15 May 2020 11:10:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 211BC1E056A; Fri, 15 May 2020 13:10:43 +0200 (CEST)
Date:   Fri, 15 May 2020 13:10:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     NeilBrown <neilb@suse.de>
Cc:     Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2 V4] MM: replace PF_LESS_THROTTLE with
 PF_LOCAL_THROTTLE
Message-ID: <20200515111043.GK9569@quack2.suse.cz>
References: <87tv2b7q72.fsf@notabene.neil.brown.name>
 <87v9miydai.fsf@notabene.neil.brown.name>
 <87ftdgw58w.fsf@notabene.neil.brown.name>
 <87wo6gs26e.fsf@notabene.neil.brown.name>
 <87tv1ks24t.fsf@notabene.neil.brown.name>
 <20200416151906.GQ23739@quack2.suse.cz>
 <87zhb5r30c.fsf@notabene.neil.brown.name>
 <20200422124600.GH8775@quack2.suse.cz>
 <871rnob8z3.fsf@notabene.neil.brown.name>
 <87y2pw9udb.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2pw9udb.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed 13-05-20 17:17:20, NeilBrown wrote:
> 
> PF_LESS_THROTTLE exists for loop-back nfsd (and a similar need in the
> loop block driver and callers of prctl(PR_SET_IO_FLUSHER)), where a
> daemon needs to write to one bdi (the final bdi) in order to free up
> writes queued to another bdi (the client bdi).
> 
> The daemon sets PF_LESS_THROTTLE and gets a larger allowance of dirty
> pages, so that it can still dirty pages after other processses have been
> throttled.  The purpose of this is to avoid deadlock that happen when
> the PF_LESS_THROTTLE process must write for any dirty pages to be freed,
> but it is being thottled and cannot write.
> 
> This approach was designed when all threads were blocked equally,
> independently on which device they were writing to, or how fast it was.
> Since that time the writeback algorithm has changed substantially with
> different threads getting different allowances based on non-trivial
> heuristics.  This means the simple "add 25%" heuristic is no longer
> reliable.
> 
> The important issue is not that the daemon needs a *larger* dirty page
> allowance, but that it needs a *private* dirty page allowance, so that
> dirty pages for the "client" bdi that it is helping to clear (the bdi for
> an NFS filesystem or loop block device etc) do not affect the throttling
> of the deamon writing to the "final" bdi.
> 
> This patch changes the heuristic so that the task is not throttled when
> the bdi it is writing to has a dirty page count below below (or equal
> to) the free-run threshold for that bdi.  This ensures it will always be
> able to have some pages in flight, and so will not deadlock.
> 
> In a steady-state, it is expected that PF_LOCAL_THROTTLE tasks might
> still be throttled by global threshold, but that is acceptable as it is
> only the deadlock state that is interesting for this flag.
> 
> This approach of "only throttle when target bdi is busy" is consistent
> with the other use of PF_LESS_THROTTLE in current_may_throttle(), were
> it causes attention to be focussed only on the target bdi.
> 
> So this patch
>  - renames PF_LESS_THROTTLE to PF_LOCAL_THROTTLE,
>  - removes the 25% bonus that that flag gives, and
>  - If PF_LOCAL_THROTTLE is set, don't delay at all unless the
>    global and the local free-run thresholds are exceeded.
> 
> Note that previously realtime threads were treated the same as
> PF_LESS_THROTTLE threads.  This patch does *not* change the behvaiour for
> real-time threads, so it is now different from the behaviour of nfsd and
> loop tasks.  I don't know what is wanted for realtime.
> 
> Acked-by: Chuck Lever <chuck.lever@oracle.com> (for nfsd change)
> Signed-off-by: NeilBrown <neilb@suse.de>

The idea looks good to me. It will still have the "threads may hit hard
wall" behavior when BDI freerun threshold is crossed at the moment we are
very close to the global limit but that should be rare. So I think for now
this good enough.

The patch looks good to me so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Throttling patches usually go through mm tree so ask Andrew to pick them
up.


								Honza

> @@ -1653,8 +1652,12 @@ static void balance_dirty_pages(struct bdi_writeback *wb,
>  		if (dirty <= dirty_freerun_ceiling(thresh, bg_thresh) &&
>  		    (!mdtc ||
>  		     m_dirty <= dirty_freerun_ceiling(m_thresh, m_bg_thresh))) {
> -			unsigned long intv = dirty_poll_interval(dirty, thresh);
> -			unsigned long m_intv = ULONG_MAX;
> +			unsigned long intv;
> +			unsigned long m_intv;
> +
> +		free_running:
> +			intv = dirty_poll_interval(dirty, thresh);
> +			m_intv = ULONG_MAX;
>  
>  			current->dirty_paused_when = now;
>  			current->nr_dirtied = 0;
> @@ -1673,9 +1676,20 @@ static void balance_dirty_pages(struct bdi_writeback *wb,
>  		 * Calculate global domain's pos_ratio and select the
>  		 * global dtc by default.
>  		 */
> -		if (!strictlimit)
> +		if (!strictlimit) {
>  			wb_dirty_limits(gdtc);
>  
> +			if ((current->flags & PF_LOCAL_THROTTLE) &&
> +			    gdtc->wb_dirty <
> +			    dirty_freerun_ceiling(gdtc->wb_thresh,
> +						  gdtc->wb_bg_thresh))
> +				/*
> +				 * LOCAL_THROTTLE tasks must not be throttled
> +				 * when below the per-wb freerun ceiling.
> +				 */
> +				goto free_running;
> +		}
> +
>  		dirty_exceeded = (gdtc->wb_dirty > gdtc->wb_thresh) &&
>  			((gdtc->dirty > gdtc->thresh) || strictlimit);
>  
> @@ -1689,9 +1703,20 @@ static void balance_dirty_pages(struct bdi_writeback *wb,
>  			 * both global and memcg domains.  Choose the one
>  			 * w/ lower pos_ratio.
>  			 */
> -			if (!strictlimit)
> +			if (!strictlimit) {
>  				wb_dirty_limits(mdtc);
>  
> +				if ((current->flags & PF_LOCAL_THROTTLE) &&
> +				    mdtc->wb_dirty <
> +				    dirty_freerun_ceiling(mdtc->wb_thresh,
> +							  mdtc->wb_bg_thresh))
> +					/*
> +					 * LOCAL_THROTTLE tasks must not be
> +					 * throttled when below the per-wb
> +					 * freerun ceiling.
> +					 */
> +					goto free_running;
> +			}
>  			dirty_exceeded |= (mdtc->wb_dirty > mdtc->wb_thresh) &&
>  				((mdtc->dirty > mdtc->thresh) || strictlimit);
>  
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index a37c87b5aee2..b2f5deb3603c 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1878,13 +1878,13 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  
>  /*
>   * If a kernel thread (such as nfsd for loop-back mounts) services
> - * a backing device by writing to the page cache it sets PF_LESS_THROTTLE.
> + * a backing device by writing to the page cache it sets PF_LOCAL_THROTTLE.
>   * In that case we should only throttle if the backing device it is
>   * writing to is congested.  In other cases it is safe to throttle.
>   */
>  static int current_may_throttle(void)
>  {
> -	return !(current->flags & PF_LESS_THROTTLE) ||
> +	return !(current->flags & PF_LOCAL_THROTTLE) ||
>  		current->backing_dev_info == NULL ||
>  		bdi_write_congested(current->backing_dev_info);
>  }
> -- 
> 2.26.2
> 


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
