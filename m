Return-Path: <linux-nfs+bounces-4494-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0553891E200
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 16:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279E81C22CD8
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 14:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179461607AB;
	Mon,  1 Jul 2024 14:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUJRw3lT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39C515E5A6;
	Mon,  1 Jul 2024 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843198; cv=none; b=g2tQeS+cPIv+JuRYdPY62rvE4lJJMBByx4I1L9aODTm5N4iVUmkD2i6XuiRuopxfIKd4rbKmZsUJbtHcc/NJq8XUQB8Jdv7nDrb8SVxp2cUUtoqmMOIHNVrRUIMPs7YjiP7jVQEK8s1vgBDEowF3f90D4wUg9n4jRbTE8KrqMTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843198; c=relaxed/simple;
	bh=/QG80hwbXudimGg9U07KcwVoOaj8NHFJuPslozYphHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuWxF7FH4YuBthZYYymNm5DXCHVdb8LC+qnqv5RbYXTnBekZLK4HiQ1q7BNq3tQs96lF1HrXK7LeeaicL3nKYNrnjjC+GCPBJzQP7QBFgOdcNf74FmOimh1KJR2KKw5F5aHrW6+TaFZor6Fp19LkjDuBKFhNQ6YiVJSvwMNUYJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUJRw3lT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC71C116B1;
	Mon,  1 Jul 2024 14:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719843197;
	bh=/QG80hwbXudimGg9U07KcwVoOaj8NHFJuPslozYphHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TUJRw3lT0uEJXIJ78o3uUKUR4IizSVhVM6cE/d+IeYYFTK11XE7lLgeVr/mptRC33
	 vATCu5mW+bsRWYVMVpbOi0iAPjDxvVBo7nKbgOp7OaxmsqOIQTgA7KbkD3jGwqDZL1
	 QBIaBeN49UgyAvlmh6tQwieLSmC3TIadQqLj1X/i0ahA42PSzvnxb4Bna7gw1eMi+z
	 FgqTDWaYwK2ioBLITjh+NHfiibgCd0ULwOSgBHLzk02ISBJ9cujesj4Mc3KLTIKtRI
	 qQClPBldRfVOuhjzHMcfZx9CBdTJUzCvALYgo9wK3jcrC+VF7rS3gU5RXv19wJ4MXT
	 u6zWT1n/ferYw==
Date: Mon, 1 Jul 2024 10:13:16 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-xfs@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] xfs: enable WQ_MEM_RECLAIM on m_sync_workqueue
Message-ID: <ZoK5fEz6HSU5iUSH@kernel.org>
References: <Zn7icFF_NxqkoOHR@kernel.org>
 <ZoGJRSe98wZFDK36@kernel.org>
 <ZoHuXHMEuMrem73H@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoHuXHMEuMrem73H@dread.disaster.area>

On Mon, Jul 01, 2024 at 09:46:36AM +1000, Dave Chinner wrote:
> On Sun, Jun 30, 2024 at 12:35:17PM -0400, Mike Snitzer wrote:
> > The need for this fix was exposed while developing a new NFS feature
> > called "localio" which bypasses the network, if both the client and
> > server are on the same host, see:
> > https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-6.11
> > 
> > Because NFS's nfsiod_workqueue enables WQ_MEM_RECLAIM, writeback will
> > call into NFS and if localio is enabled the NFS client will call
> > directly into xfs_file_write_iter, this causes the following
> > backtrace when running xfstest generic/476 against NFS with localio:
> 
> Oh, that's nasty.
> 
> We now have to change every path in every filesystem that NFS can
> call that might defer work to a workqueue.
> 
> IOWs, this makes WQ_MEM_RECLAIM pretty much mandatory for front end
> workqueues in the filesystem and block layers regardless of whether
> the filesystem or block layer path runs under memory reclaim context
> or not.

As you noticed later (yet didn't circle back to edit here) this is
just triggering when space is low.

But yeah, I submitted the patch knowing it was likely not viable, I
just wasn't clear on all the whys.  I appreciate your feedback, and
yes it did feel like a slippery slope (understatement) that'd force
other filesystems to follow.
 
> All WQ_MEM_RECLAIM does is create a rescuer thread at workqueue
> creation that is used as a "worker of last resort" when forking new
> worker threads fail due to ENOMEM. This prevents deadlocks when
> doing GFP_KERNEL allocations in workqueue context and potentially
> deadlocking because a GFP_KERNEL allocation is blocking waiting for
> this workqueue to allocate workers to make progress.

Right.

> >   workqueue: WQ_MEM_RECLAIM writeback:wb_workfn is flushing !WQ_MEM_RECLAIM xfs-sync/vdc:xfs_flush_inodes_worker
> >   WARNING: CPU: 6 PID: 8525 at kernel/workqueue.c:3706 check_flush_dependency+0x2a4/0x328
> >   Modules linked in:
> >   CPU: 6 PID: 8525 Comm: kworker/u71:5 Not tainted 6.10.0-rc3-ktest-00032-g2b0a133403ab #18502
> >   Hardware name: linux,dummy-virt (DT)
> >   Workqueue: writeback wb_workfn (flush-0:33)
> >   pstate: 400010c5 (nZcv daIF -PAN -UAO -TCO -DIT +SSBS BTYPE=--)
> >   pc : check_flush_dependency+0x2a4/0x328
> >   lr : check_flush_dependency+0x2a4/0x328
> >   sp : ffff0000c5f06bb0
> >   x29: ffff0000c5f06bb0 x28: ffff0000c998a908 x27: 1fffe00019331521
> >   x26: ffff0000d0620900 x25: ffff0000c5f06ca0 x24: ffff8000828848c0
> >   x23: 1fffe00018be0d8e x22: ffff0000c1210000 x21: ffff0000c75fde00
> >   x20: ffff800080bfd258 x19: ffff0000cad63400 x18: ffff0000cd3a4810
> >   x17: 0000000000000000 x16: 0000000000000000 x15: ffff800080508d98
> >   x14: 0000000000000000 x13: 204d49414c434552 x12: 1fffe0001b6eeab2
> >   x11: ffff60001b6eeab2 x10: dfff800000000000 x9 : ffff60001b6eeab3
> >   x8 : 0000000000000001 x7 : 00009fffe491154e x6 : ffff0000db775593
> >   x5 : ffff0000db775590 x4 : ffff0000db775590 x3 : 0000000000000000
> >   x2 : 0000000000000027 x1 : ffff600018be0d62 x0 : dfff800000000000
> >   Call trace:
> >    check_flush_dependency+0x2a4/0x328
> >    __flush_work+0x184/0x5c8
> >    flush_work+0x18/0x28
> >    xfs_flush_inodes+0x68/0x88
> >    xfs_file_buffered_write+0x128/0x6f0
> >    xfs_file_write_iter+0x358/0x448
> >    nfs_local_doio+0x854/0x1568
> >    nfs_initiate_pgio+0x214/0x418
> >    nfs_generic_pg_pgios+0x304/0x480
> >    nfs_pageio_doio+0xe8/0x240
> >    nfs_pageio_complete+0x160/0x480
> >    nfs_writepages+0x300/0x4f0
> >    do_writepages+0x12c/0x4a0
> >    __writeback_single_inode+0xd4/0xa68
> >    writeback_sb_inodes+0x470/0xcb0
> >    __writeback_inodes_wb+0xb0/0x1d0
> >    wb_writeback+0x594/0x808
> >    wb_workfn+0x5e8/0x9e0
> >    process_scheduled_works+0x53c/0xd90
> 
> Ah, this is just the standard backing device flusher thread that is
> running. This is the back end of filesystem writeback, not the front
> end. It was never intended to be able to directly do loop back IO
> submission to the front end filesystem IO paths like this - they are
> very different contexts and have very different constraints.
> 
> This particular situation occurs when XFS is near ENOSPC.  There's a
> very high probability it is going to fail these writes, and so it's
> doing slow path work that involves blocking and front end filesystem
> processing is allowed to block on just about anything in the
> filesystem as long as it can guarantee it won't deadlock.
> 
> Fundamentally, doing IO submission in WQ_MEM_RECLAIM context changes
> the submission context for -all- filesystems, not just XFS.

Yes, I see that.

> If we have to make this change to XFS, then -every-
> workqueue in XFS (not just this one) must be converted to
> WQ_MEM_RECLAIM, and then many workqueues in all the other
> filesystems will need to have the same changes made, too.

AFAICT they are all WQ_MEM_RECLAIM aside from m_sync_workqueue, but
that's besides the point.

> That doesn't smell right to me.
> 
> ----
> 
> So let's look at how back end filesystem IO currently submits new
> front end filesystem IO: the loop block device does this, and it
> uses workqueues to defer submitted IO so that the lower IO
> submission context can be directly controlled and made with the
> front end filesystem IO submission path behaviours.
> 
> The loop device does not use rescuer threads - that's not needed
> when you have a queue based submission and just use the workqueues
> to run the queues until they are empty. So the loop device uses
> a standard unbound workqueue for it's IO submission path, and
> then when the work is running it sets the task flags to say "this is
> a nested IO worker thread" before it starts processing the
> submission queue and submitting new front end filesystem IO:
> 
> static void loop_process_work(struct loop_worker *worker,
>                         struct list_head *cmd_list, struct loop_device *lo)
> {
>         int orig_flags = current->flags;
>         struct loop_cmd *cmd;
> 
>         current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
> 
> PF_LOCAL_THROTTLE prevents deadlocks in balance_dirty_pages() by
> lifting the dirty ratio for this thread a little, hence giving it
> priority over the upper filesystem. i.e. the upper filesystem will
> throttle incoming writes first, then the back end IO submission
> thread can still submit new front end IOs to the lower filesystem
> and they won't block in balance_dirty_pages() because the lower
> filesystem has a higher limit. hence the lower filesystem can always
> drain the dirty pages on the upper filesystem, and the system won't
> deadlock in balance_dirty_pages().

Perfect, thanks for the guidance.

> Using WQ_MEM_RECLAIM context for IO submission does not address this
> deadlock.
> 
> The PF_MEMALLOC_NOIO flag prevents the lower filesystem IO from
> causing memory reclaim to re-enter filesystems or IO devices and so
> prevents deadlocks from occuring where IO that cleans pages is
> waiting on IO to complete.
> 
> Using WQ_MEM_RECLAIM context for IO submission does not address this
> deadlock either.
> 
> IOWs, doing front IO submission like this from the BDI flusher
> thread is guaranteed to deadlock sooner or later, regardless of
> whether WQ_MEM_RECLAIM is set or not on workqueues that are flushed
> during IO submission. The WQ_MEM_RECLAIM warning is effectively your
> canary in the coal mine. And the canary just carked it.

Yes, I knew it as such, but I wanted to pin down why it died.. thanks
for your help!

FYI, this is the long-standing approach to how Trond dealt with this
WQ_MEM_RECLAIM situation. I was just hoping to avoid having to
introduce a dedicated workqueue for localio's needs (NeilBrown really
disliked the fact it mentioned how it avoids blowing the stack, but we
get that as a side-effect of needing it to avoid WQ_MEM_RECLAIM):
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/commit/?h=nfs-localio-for-6.11-testing&id=0cd25f7610df291827ad95023e03fdd4f93bbea7
(I revised the patch to add PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO and
adjusted the header to reflect our discussion in this thread).

> IMO, the only sane way to ensure this sort of nested "back-end page
> cleaning submits front-end IO filesystem IO" mechanism works is to
> do something similar to the loop device. You most definitely don't
> want to be doing buffered IO (double caching is almost always bad)
> and you want to be doing async direct IO so that the submission
> thread is not waiting on completion before the next IO is
> submitted.

Yes, follow-on work is for me to revive the directio path for localio
that ultimately wasn't pursued (or properly wired up) because it
creates DIO alignment requirements on NFS client IO:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/commit/?h=nfs-localio-for-6.11-testing&id=f6c9f51fca819a8af595a4eb94811c1f90051eab

But underlying filesystems (like XFS) have the appropriate checks, we
just need to fail gracefully and disable NFS localio if the IO is
misaligned.

Mike

