Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFC31AC920
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2020 17:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504094AbgDPPTL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Apr 2020 11:19:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:53094 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389903AbgDPPTJ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 16 Apr 2020 11:19:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 110BDAD1E;
        Thu, 16 Apr 2020 15:19:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EC4091E0E5A; Thu, 16 Apr 2020 17:19:06 +0200 (CEST)
Date:   Thu, 16 Apr 2020 17:19:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "Anna.Schumaker@Netapp.com" <Anna.Schumaker@netapp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2 V3] MM: replace PF_LESS_THROTTLE with
 PF_LOCAL_THROTTLE
Message-ID: <20200416151906.GQ23739@quack2.suse.cz>
References: <87tv2b7q72.fsf@notabene.neil.brown.name>
 <87v9miydai.fsf@notabene.neil.brown.name>
 <87ftdgw58w.fsf@notabene.neil.brown.name>
 <87wo6gs26e.fsf@notabene.neil.brown.name>
 <87tv1ks24t.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tv1ks24t.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu 16-04-20 10:30:42, NeilBrown wrote:
> 
> PF_LESS_THROTTLE exists for loop-back nfsd (and a similar need in the
> loop block driver and callers of prctl(PR_SET_IO_FLUSHER)), where a
> daemon needs to write to one bdi (the final bdi) in order to free up
> writes queued to another bdi (the client bdi).
> 
> The daemon sets PF_LESS_THROTTLE and gets a larger allowance of dirty
> pages, so that it can still dirty pages after other processses have been
> throttled.
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
> This patch changes the heuristic so that the task is only throttled if
> *both* the global threshhold *and* the per-wb threshold are exceeded.
> This is similar to the effect of BDI_CAP_STRICTLIMIT which causes the
> global limits to be ignored, but it isn't as strict.  A PF_LOCAL_THROTTLE
> task will be allowed to proceed unthrottled if the global threshold is
> not exceeded or if the local threshold is not exceeded.  They need to
> both be exceeded before PF_LOCAL_THROTTLE tasks are throttled.
> 
> This approach of "only throttle when target bdi is busy" is consistent
> with the other use of PF_LESS_THROTTLE in current_may_throttle(), were
> it causes attention to be focussed only on the target bdi.
> 
> So this patch
>  - renames PF_LESS_THROTTLE to PF_LOCAL_THROTTLE,
>  - removes the 25% bonus that that flag gives, and
>  - If PF_LOCAL_THROTTLE is set, don't delay at all unless both
>    thresholds are exceeded.
> 
> Note that previously realtime threads were treated the same as
> PF_LESS_THROTTLE threads.  This patch does *not* change the behvaiour for
> real-time threads, so it is now different from the behaviour of nfsd and
> loop tasks.  I don't know what is wanted for realtime.
> 
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: NeilBrown <neilb@suse.de>

...

> @@ -1700,6 +1699,17 @@ static void balance_dirty_pages(struct bdi_writeback *wb,
>  				sdtc = mdtc;
>  		}
>  
> +		if (current->flags & PF_LOCAL_THROTTLE)
> +			/* This task must only be throttled based on the bdi
> +			 * it is writing to - dirty pages for other bdis might
> +			 * be pages this task is trying to write out.  So it
> +			 * gets a free pass unless both global and local
> +			 * thresholds are exceeded.  i.e unless
> +			 * "dirty_exceeded".
> +			 */
> +			if (!dirty_exceeded)
> +				break;
> +
>  		if (dirty_exceeded && !wb->dirty_exceeded)
>  			wb->dirty_exceeded = 1;

Ok, but note that this will have one sideeffect you maybe didn't realize:
Currently we try to throttle tasks softly - the heuristic rougly works like
this: If dirty < (thresh + bg_thresh)/2, leave the task alone.
(thresh+bg_thresh)/2 is called "freerun ceiling". If dirty is greater than
this, we delay the task somewhat (the aim is to delay the task as long as
it would take to write back the pages task has dirtied) in
balance_dirty_pages() so ideally 'thresh' is never hit. Only if the
heuristic consistently underestimates the time to writeback pages, we hit
'thresh' and then block the task as long as it takes flush worker to clean
enough pages to get below 'thresh'. This all leads to task being usually
gradually slowed down in balance_dirty_pages() which generally leads to
smoother overall system behavior.

What you did makes PF_LOCAL_THROTTLE tasks ignore any limits and then when
local bdi limit is exceeded, they'll suddently hit the wall and be blocked
for a long time in balance_dirty_pages().

So I like what you suggest in principle, just I think the implementation
has undesirable sideeffects. I think it would be better to modify
wb_position_ratio() to take PF_LOCAL_THROTTLE into account. It will be
probably similar to how BDI_CAP_STRICTLIMIT is handled but different in
some ways because BDI_CAP_STRICTLIMIT takes minimum from wb_pos_ratio and
global pos_ratio, you rather want to take wb_pos_ratio only. Also there are
some early bail out conditions when we are over global dirty limit which
you need to handle differently for PF_LOCAL_THROTTLE. And then, when you
have appropriate pos_ratio computed based on your policy, you can let the
task wait for appropriate amount of time and things should just work (TM) ;).
Thinking about it, you probably also want to add 'freerun' condition for
PF_LOCAL_THROTTLE tasks like:

	if ((current->flags & PF_LOCAL_THROTTLE) &&
	    wb_dirty <= dirty_freerun_ceiling(wb_thresh, wb_bg_thresh))
		go the freerun path...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
