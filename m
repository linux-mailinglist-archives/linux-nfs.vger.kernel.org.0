Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51EDB19C725
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Apr 2020 18:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732412AbgDBQfE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Apr 2020 12:35:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:37148 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732404AbgDBQfE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 2 Apr 2020 12:35:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 989D8ABAD;
        Thu,  2 Apr 2020 16:35:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 19D641E11F4; Thu,  2 Apr 2020 18:35:01 +0200 (CEST)
Date:   Thu, 2 Apr 2020 18:35:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "Anna.Schumaker@Netapp.com" <Anna.Schumaker@netapp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] MM: replace PF_LESS_THROTTLE with PF_LOCAL_THROTTLE
Message-ID: <20200402163501.GC9751@quack2.suse.cz>
References: <87tv2b7q72.fsf@notabene.neil.brown.name>
 <87v9miydai.fsf@notabene.neil.brown.name>
 <87sghmyd8v.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sghmyd8v.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu 02-04-20 10:53:20, NeilBrown wrote:
> 
> PF_LESS_THROTTLE exists for loop-back nfsd, and a similar need in the
> loop block driver, where a daemon needs to write to one bdi in
> order to free up writes queued to another bdi.
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
> This patch changes the heuristic to ignore the global limits and
> consider only the limit relevant to the bdi being written to.  This
> approach is already available for BDI_CAP_STRICTLIMIT users (fuse) and
> should not introduce surprises.  This has the desired result of
> protecting the task from the consequences of large amounts of dirty data
> queued for other devices.
> 
> This approach of "only consider the target bdi" is consistent with the
> other use of PF_LESS_THROTTLE in current_may_throttle(), were it causes
> attention to be focussed only on the target bdi.
> 
> So this patch
>  - renames PF_LESS_THROTTLE to PF_LOCAL_THROTTLE,
>  - remove the 25% bonus that that flag gives, and
>  - imposes 'strictlimit' handling for any process with PF_LOCAL_THROTTLE
>    set.
> 
> Note that previously realtime threads were treated the same as
> PF_LESS_THROTTLE threads.  This patch does *not* change the behvaiour for
> real-time threads, so it is now different from the behaviour of nfsd and
> loop tasks.  I don't know what is wanted for realtime.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

This makes sense to me and the patch looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

Thanks.

								Honza

> ---
>  drivers/block/loop.c  |  2 +-
>  fs/nfsd/vfs.c         |  9 +++++----
>  include/linux/sched.h |  2 +-
>  kernel/sys.c          |  2 +-
>  mm/page-writeback.c   | 10 ++++++----
>  mm/vmscan.c           |  4 ++--
>  6 files changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 739b372a5112..2c59371ce936 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -897,7 +897,7 @@ static void loop_unprepare_queue(struct loop_device *lo)
>  
>  static int loop_kthread_worker_fn(void *worker_ptr)
>  {
> -	current->flags |= PF_LESS_THROTTLE | PF_MEMALLOC_NOIO;
> +	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
>  	return kthread_worker_fn(worker_ptr);
>  }
>  
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 0aa02eb18bd3..c3fbab1753ec 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -979,12 +979,13 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
>  
>  	if (test_bit(RQ_LOCAL, &rqstp->rq_flags))
>  		/*
> -		 * We want less throttling in balance_dirty_pages()
> -		 * and shrink_inactive_list() so that nfs to
> +		 * We want throttling in balance_dirty_pages()
> +		 * and shrink_inactive_list() to only consider
> +		 * the backingdev we are writing to, so that nfs to
>  		 * localhost doesn't cause nfsd to lock up due to all
>  		 * the client's dirty pages or its congested queue.
>  		 */
> -		current->flags |= PF_LESS_THROTTLE;
> +		current->flags |= PF_LOCAL_THROTTLE;
>  
>  	exp = fhp->fh_export;
>  	use_wgather = (rqstp->rq_vers == 2) && EX_WGATHER(exp);
> @@ -1037,7 +1038,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
>  		nfserr = nfserrno(host_err);
>  	}
>  	if (test_bit(RQ_LOCAL, &rqstp->rq_flags))
> -		current_restore_flags(pflags, PF_LESS_THROTTLE);
> +		current_restore_flags(pflags, PF_LOCAL_THROTTLE);
>  	return nfserr;
>  }
>  
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 04278493bf15..5dcd27abc8cd 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1473,7 +1473,7 @@ extern struct pid *cad_pid;
>  #define PF_KSWAPD		0x00020000	/* I am kswapd */
>  #define PF_MEMALLOC_NOFS	0x00040000	/* All allocation requests will inherit GFP_NOFS */
>  #define PF_MEMALLOC_NOIO	0x00080000	/* All allocation requests will inherit GFP_NOIO */
> -#define PF_LESS_THROTTLE	0x00100000	/* Throttle me less: I clean memory */
> +#define PF_LOCAL_THROTTLE	0x00100000	/* Throttle me less: I clean memory */
>  #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
>  #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
>  #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
> diff --git a/kernel/sys.c b/kernel/sys.c
> index d325f3ab624a..180a2fa33f7f 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2262,7 +2262,7 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
>  	return -EINVAL;
>  }
>  
> -#define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LESS_THROTTLE)
> +#define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LOCAL_THROTTLE)
>  
>  SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  		unsigned long, arg4, unsigned long, arg5)
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 2caf780a42e7..2afb09fa2fe0 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -387,8 +387,7 @@ static unsigned long global_dirtyable_memory(void)
>   * Calculate @dtc->thresh and ->bg_thresh considering
>   * vm_dirty_{bytes|ratio} and dirty_background_{bytes|ratio}.  The caller
>   * must ensure that @dtc->avail is set before calling this function.  The
> - * dirty limits will be lifted by 1/4 for PF_LESS_THROTTLE (ie. nfsd) and
> - * real-time tasks.
> + * dirty limits will be lifted by 1/4 for real-time tasks.
>   */
>  static void domain_dirty_limits(struct dirty_throttle_control *dtc)
>  {
> @@ -436,7 +435,7 @@ static void domain_dirty_limits(struct dirty_throttle_control *dtc)
>  	if (bg_thresh >= thresh)
>  		bg_thresh = thresh / 2;
>  	tsk = current;
> -	if (tsk->flags & PF_LESS_THROTTLE || rt_task(tsk)) {
> +	if (rt_task(tsk)) {
>  		bg_thresh += bg_thresh / 4 + global_wb_domain.dirty_limit / 32;
>  		thresh += thresh / 4 + global_wb_domain.dirty_limit / 32;
>  	}
> @@ -486,7 +485,7 @@ static unsigned long node_dirty_limit(struct pglist_data *pgdat)
>  	else
>  		dirty = vm_dirty_ratio * node_memory / 100;
>  
> -	if (tsk->flags & PF_LESS_THROTTLE || rt_task(tsk))
> +	if (rt_task(tsk))
>  		dirty += dirty / 4;
>  
>  	return dirty;
> @@ -1580,6 +1579,9 @@ static void balance_dirty_pages(struct bdi_writeback *wb,
>  	bool strictlimit = bdi->capabilities & BDI_CAP_STRICTLIMIT;
>  	unsigned long start_time = jiffies;
>  
> +	if (current->flags & PF_LOCAL_THROTTLE)
> +		/* This task must only be throttled by its own writeback */
> +		strictlimit = true;
>  	for (;;) {
>  		unsigned long now = jiffies;
>  		unsigned long dirty, thresh, bg_thresh;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 876370565455..c5cf25938c56 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1880,13 +1880,13 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
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
> 2.26.0
> 


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
