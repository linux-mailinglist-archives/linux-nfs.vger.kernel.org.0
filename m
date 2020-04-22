Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C50A1B4553
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Apr 2020 14:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgDVMqG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Apr 2020 08:46:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:49890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgDVMqF (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 22 Apr 2020 08:46:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C0F96AD4B;
        Wed, 22 Apr 2020 12:46:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4703C1E0E53; Wed, 22 Apr 2020 14:46:00 +0200 (CEST)
Date:   Wed, 22 Apr 2020 14:46:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     NeilBrown <neilb@suse.de>
Cc:     Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2 V3] MM: replace PF_LESS_THROTTLE with
 PF_LOCAL_THROTTLE
Message-ID: <20200422124600.GH8775@quack2.suse.cz>
References: <87tv2b7q72.fsf@notabene.neil.brown.name>
 <87v9miydai.fsf@notabene.neil.brown.name>
 <87ftdgw58w.fsf@notabene.neil.brown.name>
 <87wo6gs26e.fsf@notabene.neil.brown.name>
 <87tv1ks24t.fsf@notabene.neil.brown.name>
 <20200416151906.GQ23739@quack2.suse.cz>
 <87zhb5r30c.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhb5r30c.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue 21-04-20 12:22:59, NeilBrown wrote:
> On Thu, Apr 16 2020, Jan Kara wrote:
> 
> > On Thu 16-04-20 10:30:42, NeilBrown wrote:
> >> 
> >> PF_LESS_THROTTLE exists for loop-back nfsd (and a similar need in the
> >> loop block driver and callers of prctl(PR_SET_IO_FLUSHER)), where a
> >> daemon needs to write to one bdi (the final bdi) in order to free up
> >> writes queued to another bdi (the client bdi).
> >> 
> >> The daemon sets PF_LESS_THROTTLE and gets a larger allowance of dirty
> >> pages, so that it can still dirty pages after other processses have been
> >> throttled.
> >> 
> >> This approach was designed when all threads were blocked equally,
> >> independently on which device they were writing to, or how fast it was.
> >> Since that time the writeback algorithm has changed substantially with
> >> different threads getting different allowances based on non-trivial
> >> heuristics.  This means the simple "add 25%" heuristic is no longer
> >> reliable.
> >> 
> >> The important issue is not that the daemon needs a *larger* dirty page
> >> allowance, but that it needs a *private* dirty page allowance, so that
> >> dirty pages for the "client" bdi that it is helping to clear (the bdi for
> >> an NFS filesystem or loop block device etc) do not affect the throttling
> >> of the deamon writing to the "final" bdi.
> >> 
> >> This patch changes the heuristic so that the task is only throttled if
> >> *both* the global threshhold *and* the per-wb threshold are exceeded.
> >> This is similar to the effect of BDI_CAP_STRICTLIMIT which causes the
> >> global limits to be ignored, but it isn't as strict.  A PF_LOCAL_THROTTLE
> >> task will be allowed to proceed unthrottled if the global threshold is
> >> not exceeded or if the local threshold is not exceeded.  They need to
> >> both be exceeded before PF_LOCAL_THROTTLE tasks are throttled.
> >> 
> >> This approach of "only throttle when target bdi is busy" is consistent
> >> with the other use of PF_LESS_THROTTLE in current_may_throttle(), were
> >> it causes attention to be focussed only on the target bdi.
> >> 
> >> So this patch
> >>  - renames PF_LESS_THROTTLE to PF_LOCAL_THROTTLE,
> >>  - removes the 25% bonus that that flag gives, and
> >>  - If PF_LOCAL_THROTTLE is set, don't delay at all unless both
> >>    thresholds are exceeded.
> >> 
> >> Note that previously realtime threads were treated the same as
> >> PF_LESS_THROTTLE threads.  This patch does *not* change the behvaiour for
> >> real-time threads, so it is now different from the behaviour of nfsd and
> >> loop tasks.  I don't know what is wanted for realtime.
> >> 
> >> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> >> Signed-off-by: NeilBrown <neilb@suse.de>
> >
> > ...
> >
> >> @@ -1700,6 +1699,17 @@ static void balance_dirty_pages(struct bdi_writeback *wb,
> >>  				sdtc = mdtc;
> >>  		}
> >>  
> >> +		if (current->flags & PF_LOCAL_THROTTLE)
> >> +			/* This task must only be throttled based on the bdi
> >> +			 * it is writing to - dirty pages for other bdis might
> >> +			 * be pages this task is trying to write out.  So it
> >> +			 * gets a free pass unless both global and local
> >> +			 * thresholds are exceeded.  i.e unless
> >> +			 * "dirty_exceeded".
> >> +			 */
> >> +			if (!dirty_exceeded)
> >> +				break;
> >> +
> >>  		if (dirty_exceeded && !wb->dirty_exceeded)
> >>  			wb->dirty_exceeded = 1;
> >
> > Ok, but note that this will have one sideeffect you maybe didn't realize:
> > Currently we try to throttle tasks softly - the heuristic rougly works like
> > this: If dirty < (thresh + bg_thresh)/2, leave the task alone.
> > (thresh+bg_thresh)/2 is called "freerun ceiling". If dirty is greater than
> > this, we delay the task somewhat (the aim is to delay the task as long as
> > it would take to write back the pages task has dirtied) in
> > balance_dirty_pages() so ideally 'thresh' is never hit. Only if the
> > heuristic consistently underestimates the time to writeback pages, we hit
> > 'thresh' and then block the task as long as it takes flush worker to clean
> > enough pages to get below 'thresh'. This all leads to task being usually
> > gradually slowed down in balance_dirty_pages() which generally leads to
> > smoother overall system behavior.
> >
> > What you did makes PF_LOCAL_THROTTLE tasks ignore any limits and then when
> > local bdi limit is exceeded, they'll suddently hit the wall and be blocked
> > for a long time in balance_dirty_pages().
> >
> > So I like what you suggest in principle, just I think the implementation
> > has undesirable sideeffects. I think it would be better to modify
> > wb_position_ratio() to take PF_LOCAL_THROTTLE into account. It will be
> > probably similar to how BDI_CAP_STRICTLIMIT is handled but different in
> > some ways because BDI_CAP_STRICTLIMIT takes minimum from wb_pos_ratio and
> > global pos_ratio, you rather want to take wb_pos_ratio only. Also there are
> > some early bail out conditions when we are over global dirty limit which
> > you need to handle differently for PF_LOCAL_THROTTLE. And then, when you
> > have appropriate pos_ratio computed based on your policy, you can let the
> > task wait for appropriate amount of time and things should just work (TM) ;).
> > Thinking about it, you probably also want to add 'freerun' condition for
> > PF_LOCAL_THROTTLE tasks like:
> >
> > 	if ((current->flags & PF_LOCAL_THROTTLE) &&
> > 	    wb_dirty <= dirty_freerun_ceiling(wb_thresh, wb_bg_thresh))
> > 		go the freerun path...
> >
> 
> Thanks.....
> I have 2 thoughts on this.
> One is that I'm not sure how much it really matters.
> The PF_LOCAL_THROTTLE task it always doing writeout on behalf of some
> other process.  Some process writes to NFS or to a loop block device or
> somewhere, then the PF_LOCAL_THROTTLE task writes those dirty pages out
> to a different BDI.  So the top level task will be throttled, an the
> PF_LOCAL_THROTTLE task won't get more than it can handle.
> There will be starting transients of course, but I doubt it would
> generally be a problem.  However it would still be nice to find the
> "right" solution.

I'm not sure PF_LOCAL_THROTTLE "won't get more than it can handle". Once
dirty pages on NFS BDI accumulate, flush worker will start to push them out
as fast as it can. So the only thing that's limitting this is the dirty
throttling on the receiving (NFS server - thus underlying BDI) side. When
underlying BDI throttling triggers depends on that BDI dirty limits and
those are proportional part of global dirty limits scaled by writeback
throughput on underlying BDI compared to other BDIs. So depending on which
BDIs are in the system and how active they are in dirtying pages
'underlying BDI' will get different dirty limits set. It's quite imaginable
that in some configurations it will be easy to push NFS server to hit its
dirty limit even with PF_LOCAL_THROTTLE. And then having NFS server
undersponsive for couple seconds because it is blocked in
balance_dirty_pages() just is not nice...

> My second thought is that I really don't understand the writeback code.
> I think I understand the general principle, and there are lots of big
> comments that try to explain things, but it just doesn't seem to help.
> I look at the code and see more questions than answers.

I fully understand what you mean :). The logic is complex and while
Fengguang wrote a lot of comments it is still rather hard to follow.

> What are the units for "dirty_ratelimit"??  I think it is pages per
> second, because it is initialized to INIT_BW which is documented as 100
> MB/s.

Yes, that's what I think as well.

> What is the difference between dirty_ratelimit and
> balanced_dirty_ratelimit?
> The later is "balanced" I guess.  What does that mean?
> Apparently (from backing-dev-defs.h) dirty_ratelimit moves in smaller
> steps and is more smooth than balanced_dirty_ratelimit.  How is being
> less smooth, more balanced??

Yeah. So I cannot really explain the naming to you (not sure why Fengguang
chose these names). But 'balanced_dirty_ratelimit' is pages/second value we
want to limit task to based on the events in the most current time slice.
'dirty_ratelimit' is smoothed version of 'balanced_dirty_ratelimit' taking
more of history into account.

> What is pos_ratio? And what is RATELIMIT_CALC_SHIFT ???
> Maybe pos_ratio is the ratio of the actual number of dirty pages to the
> desired number?  And pos_ratio is calculated with fixed-point arithmetic
> and RATELIMIT_CALC_SHIFT tells where the point is?

So RATELIMIT_CALC_SHIFT is indeed the shift of fixed point arithmetic used
in the computations. Pos_ratio is the multiplicative "correction" factor we
apply to computed dirty_ratelimit (i.e., task_ratelimit = dirty_ratelimit *
pos_ratio) - so if we see we are able to writeout say 100 MB/s but we are
still relatively far from dirty limits, we let tasks dirty 200 MB/s
(pos_ratio is 2). As we are nearing dirty limits, pos_ratio is dropping
(it's appropriately scaled and shifted third order polynomial) so very
close to dirty limits, we let tasks dirty only say 10 MB/s even though we
are still able to write out 100 MB/s.

> I think I understand freerun - half way between the dirty limit and the
> dirty_bg limit.  Se below dirty_bg, no writeback happens.  Between there
> and freerun, writeback happens, but nothing in throttled.  From free up
> to the limit, tasks are progressively throttled.

Correct.

> "setpoint" is the midpoint of this range.  Is the goal that pos_ratio is
> computed for.
> (except that in the BDI_CAP_STRICTLIMIT part of wb_position_ratio)
> wb_setpoint is set to the bottom of this range, same as the freerun ceiling.)

Correct.

> Then we have the control lines, which are cubic(?) for global counts and
> linear for per-wb - but truncated at 1/4.  The comment says "so that
> wb_dirty can be smoothly throttled".  It'll take me a while to work out
> what a hard edge results in smooth throttling.  I suspect it makes sense
> but it doesn't jump out at me.
> 
> So, you see, I don't feel at all confident changing any of this code
> because I just don't get it.
> 
> So I'm inclined to stick with the patch that I have. :-(

OK, I'll try to write something and we'll see if it will work :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
