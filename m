Return-Path: <linux-nfs+bounces-15763-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8062C1D49E
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Oct 2025 21:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 785DE4E2C86
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Oct 2025 20:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6772C30B533;
	Wed, 29 Oct 2025 20:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtIYnx4r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8A88635D;
	Wed, 29 Oct 2025 20:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771015; cv=none; b=nkXK6LpxjzEqB0uabW9oKnCExfmoXjyg+a2rhpqN3a34g60G5Npl7fFvW8kBGOEbR7HQcq1QawPhurZQTNF7B1p9NZce8xPqWN+omRHhKpDPYNJ+rGv+nKl3zTHRHze/y4AOMSCHrsrZlmLwXr3297RT4CcWrqYPDTbKunRD1YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771015; c=relaxed/simple;
	bh=96hBjYLO6glNXMiHV19oAbp9mY8tSD04EESQaBrsYGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jap1NAYdcKxTgFwNggKomGLHwNGYegjkuq/3q9NiBdAijsx/d5cJg0exTvP4NB1ndytXV28vv/S7q70Vhp2Is3wSQmoXJTaHKS1AK6JOcGwYDT8NycyDijmL/lin4MOYE0cndD/s5CrkMRS0Wm9E9v3E/EYwjcBwjr6gMdimLSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtIYnx4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4CCC4CEF7;
	Wed, 29 Oct 2025 20:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761771014;
	bh=96hBjYLO6glNXMiHV19oAbp9mY8tSD04EESQaBrsYGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jtIYnx4rKzS5Bl2pKNUBoXggwIkSEPJ20qORAwi8XgSuMhop9kCpgPAP4uCBnDpSS
	 8upNL5V9ae3o52mouS6XP6vACLE0cDIF+vqa5rH1P4gxqGvzaXWUItmCpLxm6oZwh9
	 1MSmgPrq67XZB/tXpobO4z4t29HH8Rm4QygRDJYJt0hqc0zd41fOKLt9m7q+Pl/SnA
	 ORGC38bLTG6T4PLTmw4CqkRrFrQMSL61rrk3m/xLuxdzy8Z0I+0OzaSV55PXQaUQis
	 YKBWaKAw+lVT/HipXyztgC57/7/xUVVSAMuUT9eF0otIWvzdtmY7+xUm8noF00j+R1
	 vm1oTFnB1gDfg==
Date: Wed, 29 Oct 2025 16:50:13 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org
Subject: Re: [Bug report][xfstests generic/751] hang on nfs writeback
Message-ID: <aQJ-BfBblQ5hlgm1@kernel.org>
References: <20251021051408.lv7dye5wywxhl3dg@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aPkFLDsQ71BrTXt7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPkFLDsQ71BrTXt7@kernel.org>

On Wed, Oct 22, 2025 at 12:24:12PM -0400, Mike Snitzer wrote:
> On Tue, Oct 21, 2025 at 01:14:08PM +0800, Zorro Lang wrote:
> > Hi,
> > 
> > When I did xfstests regression test on nfs, it hang on generic/751 many times,
> > refer to [1](on x86_64) and [2](on aarch64). I've hit it 8 times until now.
> 
> You've hit it 8 times, all on the same kernel?  Any idea if this is a
> regression specific to 6.18-rc1 and later?
>  
> > I tested on latest linux v6.18-rc2. My underlying test device isn't loopback device,
> > it's general disk, and make xfs on it:
> >   meta-data=/dev/sda5              isize=512    agcount=4, agsize=983040 blks
> >            =                       sectsz=4096  attr=2, projid32bit=1
> >            =                       crc=1        finobt=1, sparse=1, rmapbt=1
> >            =                       reflink=1    bigtime=1 inobtcount=1 nrext64=1
> >            =                       exchange=0   metadir=0
> >   data     =                       bsize=4096   blocks=3932160, imaxpct=25
> >            =                       sunit=0      swidth=0 blks
> >   naming   =version 2              bsize=4096   ascii-ci=0, ftype=1, parent=0
> >   log      =internal log           bsize=4096   blocks=54324, version=2
> >            =                       sectsz=4096  sunit=1 blks, lazy-count=1
> >   realtime =none                   extsz=4096   blocks=0, rtextents=0
> >            =                       rgcount=0    rgsize=0 extents
> >            =                       zoned=0      start=0 reserved=0
> > 
> > Two xfs are mounted on /mnt/xfstests/test and /mnt/xfstests/scratch seperately,
> > then export as:
> >   # cat /etc/exports
> >   /mnt/xfstests/test/nfs-server *(rw,insecure,no_root_squash)
> >   /mnt/xfstests/scratch/nfs-server *(rw,insecure,no_root_squash)
> > 
> > The nfs mount option is only "-o vers=4.2". BTW, nfs server and client are
> > in same machine/system.
> 
> Being that NFS client and server are on the same localhost, I see
> NFS's LOCALIO is being used (nfslocaliod mentioned in "locks held"
> section, so IO is bypassing going over the wire to NFSD and is instead
> being issued directly from NFS client through LOCALIO workqueue and
> then down to XFS).
> 
> I'll try to make sense of the locking (reported below) but this will
> take some time.
> 
> Cc'ing XFS list because this is NFS LOCALIO ontop of XFS, could be
> there is something fundamental in LOCALIO's nfslocaliod workqueue that
> is setting us up for deadlock if XFS takes a specific path...
> 
> NOTE: fs/nfs/inode.c:nfsiod_start(), XFS's nature has influenced
> LOCALIO workqueue config hacks already.. could be dragons lurking:
> 
> /*
>  * Start the nfsiod workqueues
>  */
> static int nfsiod_start(void)
> {
>         dprintk("RPC:       creating workqueue nfsiod\n");
>         nfsiod_workqueue = alloc_workqueue("nfsiod", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
>         if (nfsiod_workqueue == NULL)
>                 return -ENOMEM;
> #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>         /*
>          * localio writes need to use a normal (non-memreclaim) workqueue.
>          * When we start getting low on space, XFS goes and calls flush_work() on
>          * a non-memreclaim work queue, which causes a priority inversion problem.
>          */
>         dprintk("RPC:       creating workqueue nfslocaliod\n");
>         nfslocaliod_workqueue = alloc_workqueue("nfslocaliod", WQ_UNBOUND, 0);
>         if (unlikely(nfslocaliod_workqueue == NULL)) {
>                 nfsiod_stop();
>                 return -ENOMEM;
>         }
> #endif /* CONFIG_NFS_LOCALIO */
>         return 0;
> }
> 
> Mike
> 
>  
> > # cat local.config
> > export FSTYP=nfs
> > export TEST_DEV=xxxx-xxx-xxxx.xxxx.xxx.xxx:/mnt/xfstests/test/nfs-server
> > export TEST_DIR=/mnt/xfstests/test/nfs-client
> > export SCRATCH_DEV=xxxx-xxx-xxxx.xxxx.xxx.xxx:/mnt/xfstests/scratch/nfs-server
> > export SCRATCH_MNT=/mnt/xfstests/scratch/nfs-client
> > export MOUNT_OPTIONS="-o vers=4.2"
> > export TEST_FS_MOUNT_OPTS="-o vers=4.2"
> > 
> > 
> > [1]
> > [23369.572660] run fstests generic/751 at 2025-10-20 23:15:24 
> > [-- MARK -- Tue Oct 21 03:20:00 2025] 
> > [-- MARK -- Tue Oct 21 03:25:00 2025] 
> > [-- MARK -- Tue Oct 21 03:30:00 2025] 
> > [-- MARK -- Tue Oct 21 03:35:00 2025] 
> > [-- MARK -- Tue Oct 21 03:40:00 2025] 
> > [25069.500900] INFO: task kworker/u9:73:825900 blocked for more than 122 seconds. 
> > [25069.501484]       Not tainted 6.18.0-rc2 #1 
> > [25069.501822] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message. 
> > [25069.502385] task:kworker/u9:73   state:D stack:24712 pid:825900 tgid:825900 ppid:2      task_flags:0x4208060 flags:0x00080000 
> > [25069.503258] Workqueue: writeback wb_workfn (flush-0:48) 
> > [25069.782725] Call Trace: 
> > [25069.787191]  <TASK> 
> > [25069.787368]  __schedule+0x838/0x1890 
> > [25069.799533]  ? __pfx___schedule+0x10/0x10 
> > [25069.799852]  ? __blk_flush_plug+0x27b/0x4d0 
> > [25069.800617]  ? find_held_lock+0x32/0x90 
> > [25069.801292]  ? __lock_release.isra.0+0x1a4/0x2c0 
> > [25069.801639]  schedule+0xd4/0x260 
> > [25069.801902]  io_schedule+0x8f/0xf0 
> > [25069.802162]  folio_wait_bit_common+0x2d9/0x780 
> > [25069.802919]  ? folio_wait_bit_common+0x1dd/0x780 
> > [25069.803324]  ? __pfx_folio_wait_bit_common+0x10/0x10 
> > [25069.803684]  ? nfs_page_clear_headlock+0x31/0x80 [nfs] 
> > [25069.804254]  ? __pfx_wake_page_function+0x10/0x10 
> > [25069.804602]  ? __pfx___might_resched+0x10/0x10 
> > [25069.805160]  writeback_get_folio+0x3f9/0x500 
> > [25069.806221]  writeback_iter+0x136/0x720 
> > [25069.806628]  nfs_writepages+0x4f8/0x9b0 [nfs] 
> > [25069.807100]  ? mark_held_locks+0x40/0x70 
> > [25069.807403]  ? __pfx_nfs_writepages+0x10/0x10 [nfs] 
> > [25069.807846]  ? virtqueue_notify+0x68/0xc0 
> > [25069.808346]  ? virtio_queue_rq+0x2b1/0x650 [virtio_blk] 
> > [25069.808925]  ? __lock_acquire+0x57c/0xbd0 
> > [25069.809295]  do_writepages+0x21f/0x560 
> > [25069.809576]  ? __pfx_do_writepages+0x10/0x10 
> > [25069.809953]  ? rcu_is_watching+0x15/0xb0 
> > [25069.810587]  __writeback_single_inode+0xe2/0x5f0 
> > [25069.810982]  ? __lock_release.isra.0+0x1a4/0x2c0 
> > [25069.811373]  ? __pfx___writeback_single_inode+0x10/0x10 
> > [25069.811815]  ? writeback_sb_inodes+0x416/0xd00 
> > [25069.812194]  writeback_sb_inodes+0x535/0xd00 
> > [25069.812533]  ? __pfx_stack_trace_save+0x10/0x10 
> > [25069.814193]  ? local_clock_noinstr+0xd/0xe0 
> > [25069.814506]  ? __pfx_writeback_sb_inodes+0x10/0x10 
> > [25069.814910]  ? __lock_release.isra.0+0x1a4/0x2c0 
> > [25069.815407]  ? lock_acquire+0x10b/0x150 
> > [25069.815703]  ? down_read_trylock+0x4b/0x60 
> > [25069.816077]  __writeback_inodes_wb+0xf4/0x270 
> > [25069.816441]  ? __pfx___writeback_inodes_wb+0x10/0x10 
> > [25069.816864]  ? queue_io+0x329/0x510 
> > [25069.817148]  wb_writeback+0x70a/0x9c0 
> > [25069.817448]  ? __pfx_wb_writeback+0x10/0x10 
> > [25069.817831]  ? get_nr_dirty_inodes+0xcb/0x180 
> > [25069.818264]  wb_do_writeback+0x5d4/0x8e0 
> > [25069.818575]  ? __pfx_wb_do_writeback+0x10/0x10 
> > [25069.818975]  ? set_worker_desc+0x16e/0x190 
> > [25069.819313]  ? __pfx_set_worker_desc+0x10/0x10 
> > [25069.819669]  wb_workfn+0x7c/0x200 
> > [25069.819997]  process_one_work+0xd8b/0x1320 
> > [25069.820342]  ? __pfx_process_one_work+0x10/0x10 
> > [25069.820694]  ? assign_work+0x16c/0x240 
> > [25069.821053]  worker_thread+0x5f3/0xfe0 
> > [25069.821364]  ? __pfx_worker_thread+0x10/0x10 
> > [25069.821697]  kthread+0x3b4/0x770 
> > [25069.822122]  ? kvm_sched_clock_read+0x11/0x20 
> > [25069.822457]  ? local_clock_noinstr+0xd/0xe0 
> > [25069.822790]  ? __pfx_kthread+0x10/0x10 
> > [25069.823079]  ? __lock_release.isra.0+0x1a4/0x2c0 
> > [25069.823430]  ? rcu_is_watching+0x15/0xb0 
> > [25069.823729]  ? __pfx_kthread+0x10/0x10 
> > [25069.824035]  ret_from_fork+0x393/0x480 
> > [25069.864794]  ? __pfx_kthread+0x10/0x10 
> > [25069.865076]  ? __pfx_kthread+0x10/0x10 
> > [25069.865371]  ret_from_fork_asm+0x1a/0x30 
> > [25069.879905]  </TASK> 
> > [25069.880145]  
> > [25069.880145] Showing all locks held in the system: 
> > [25069.889550] 1 lock held by khungtaskd/37: 
> > [25069.889886]  #0: ffffffffa29309e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire.constprop.0+0x7/0x30 
> > [25069.890603] 2 locks held by 751/825733: 
> > [25069.890942]  #0: ffff888101e36440 (sb_writers#16){.+.+}-{0:0}, at: ksys_write+0xf9/0x1d0 
> > [25069.891589]  #1: ffffffffa2b97fd0 (split_debug_mutex){+.+.}-{4:4}, at: split_huge_pages_write+0x124/0x430 
> > [25069.892449] 3 locks held by kworker/u9:73/825900: 
> > [25069.892818]  #0: ffff8881029df958 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x7f5/0x1320 
> > [25069.893530]  #1: ffffc9000ad9fd10 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0xd3f/0x1320 
> > [25069.894333]  #2: ffff88810b1480e8 (&type->s_umount_key#68){++++}-{4:4}, at: super_trylock_shared+0x1c/0xa0 
> > [25069.895056] 2 locks held by kworker/u10:2/826054: 
> > [25069.895418]  #0: ffff888103ec2158 ((wq_completion)nfsiod){+.+.}-{0:0}, at: process_one_work+0x7f5/0x1320 
> > [25069.896123]  #1: ffffc90001e1fd10 ((work_completion)(&ctx->work)){+.+.}-{0:0}, at: process_one_work+0xd3f/0x1320 
> > [25069.896952]  
> > [25069.897085] ============================================= 

I was able to test xfstests generic/751 on a server in the Red Hat
lab, but I used a different baseline kernel so far (its 6.12.53-based
but has all of NFSD, NFS and SUNRPC changes from 6.18-rc1 backported).

The test runs without deadlock but there is one lockdep splat due to
missing this commit:

commit 45f69d091bab64a332fe751da9829dcd136348fd
Author: Long Li <leo.lilong@huawei.com>
Date:   Sat Jun 22 16:26:31 2024 +0800

    xfs: eliminate lockdep false positives in xfs_attr_shortform_list

    xfs_attr_shortform_list() only called from a non-transactional context, it
    hold ilock before alloc memory and maybe trapped in memory reclaim. Since
    commit 204fae32d5f7("xfs: clean up remaining GFP_NOFS users") removed
    GFP_NOFS flag, lockdep warning will be report as [1]. Eliminate lockdep
    false positives by use __GFP_NOLOCKDEP to alloc memory
    in xfs_attr_shortform_list().

    [1] https://lore.kernel.org/linux-xfs/000000000000e33add0616358204@google.com/

    Reported-by: syzbot+4248e91deb3db78358a2@syzkaller.appspotmail.com
    Signed-off-by: Long Li <leo.lilong@huawei.com>
    Reviewed-by: Dave Chinner <dchinner@redhat.com>
    Signed-off-by: Carlos Maiolino <cem@kernel.org>

After applying that commit, a generic/751 retest comes up clean. I'll
now switch to testing latest v6.18-rcX kernel.

Mike

