Return-Path: <linux-nfs+bounces-15521-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CA5BFD5F3
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 18:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53D23BB710
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 16:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA25027A107;
	Wed, 22 Oct 2025 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMJXVBw3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF55274B53;
	Wed, 22 Oct 2025 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761150253; cv=none; b=kgYglEAj605db+/ZWKZlq+BJNJlYKGkk0q6ZpUfFxX0i8Dnb2rNpxcV3repcXuCsW6dbTd+F+RIk/FvCXAWqr/e0arRnEug0+xaxtrbUko8FpcpuStMEVCBoUkHVuHRW7bBU07GebUroQZnIiVDbPsPYVjuEiIGQtDa8STrwtqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761150253; c=relaxed/simple;
	bh=z02jwRno/UnfIl7+pMdIJU2Xya4Nke8991Bxzs/7ASI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtkRB54kBoUonFGhe5CbfROkGM2N0Yun8YLak70EuqyfyUmc0qRqF14BxgcjIlw+HXMpdRUmfknxwhVKjKwCjtoAcnz9xZhkm3rYKNuz+lPQAuA964kOa7aaemSy/fo3oI1Jrh5gtSP53KrfkDuNyrS4hkO6A6Py3RlASyGL4FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMJXVBw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC1CC4CEE7;
	Wed, 22 Oct 2025 16:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761150253;
	bh=z02jwRno/UnfIl7+pMdIJU2Xya4Nke8991Bxzs/7ASI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lMJXVBw3UX92RM0gMImD/DVlINjoGu8+m1eeakkkrvD5jLWcDnTkqYW/MvpJSkgmW
	 2V04tfPp8psVE0W/Dyhqn/y18N/Bm0PVrdwdt+jHnXaMk3t2evKIkLrZPF/cjUxFWs
	 FMy4yyXNPrfoIQvY1zaf8PyU4UFkSpFcar1xATIkHA7nFgTqL8i4ge8a0NBQ13HZ+a
	 st3K+cptYGXN0KdP7ixZUeNsuz26VjfXzNakmSoi0NsvY/9vrhkBI4yFDTak/w7boB
	 4nrLpOO2asCzEXnkLvSDef2Bj3AlBr1eOLiVwT6zJa0yf8aJGBDuUM7tTq/1bjS+Ae
	 QbDjvmj+Kgh6Q==
Date: Wed, 22 Oct 2025 12:24:12 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org
Subject: Re: [Bug report][xfstests generic/751] hang on nfs writeback
Message-ID: <aPkFLDsQ71BrTXt7@kernel.org>
References: <20251021051408.lv7dye5wywxhl3dg@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021051408.lv7dye5wywxhl3dg@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Tue, Oct 21, 2025 at 01:14:08PM +0800, Zorro Lang wrote:
> Hi,
> 
> When I did xfstests regression test on nfs, it hang on generic/751 many times,
> refer to [1](on x86_64) and [2](on aarch64). I've hit it 8 times until now.

You've hit it 8 times, all on the same kernel?  Any idea if this is a
regression specific to 6.18-rc1 and later?
 
> I tested on latest linux v6.18-rc2. My underlying test device isn't loopback device,
> it's general disk, and make xfs on it:
>   meta-data=/dev/sda5              isize=512    agcount=4, agsize=983040 blks
>            =                       sectsz=4096  attr=2, projid32bit=1
>            =                       crc=1        finobt=1, sparse=1, rmapbt=1
>            =                       reflink=1    bigtime=1 inobtcount=1 nrext64=1
>            =                       exchange=0   metadir=0
>   data     =                       bsize=4096   blocks=3932160, imaxpct=25
>            =                       sunit=0      swidth=0 blks
>   naming   =version 2              bsize=4096   ascii-ci=0, ftype=1, parent=0
>   log      =internal log           bsize=4096   blocks=54324, version=2
>            =                       sectsz=4096  sunit=1 blks, lazy-count=1
>   realtime =none                   extsz=4096   blocks=0, rtextents=0
>            =                       rgcount=0    rgsize=0 extents
>            =                       zoned=0      start=0 reserved=0
> 
> Two xfs are mounted on /mnt/xfstests/test and /mnt/xfstests/scratch seperately,
> then export as:
>   # cat /etc/exports
>   /mnt/xfstests/test/nfs-server *(rw,insecure,no_root_squash)
>   /mnt/xfstests/scratch/nfs-server *(rw,insecure,no_root_squash)
> 
> The nfs mount option is only "-o vers=4.2". BTW, nfs server and client are
> in same machine/system.

Being that NFS client and server are on the same localhost, I see
NFS's LOCALIO is being used (nfslocaliod mentioned in "locks held"
section, so IO is bypassing going over the wire to NFSD and is instead
being issued directly from NFS client through LOCALIO workqueue and
then down to XFS).

I'll try to make sense of the locking (reported below) but this will
take some time.

Cc'ing XFS list because this is NFS LOCALIO ontop of XFS, could be
there is something fundamental in LOCALIO's nfslocaliod workqueue that
is setting us up for deadlock if XFS takes a specific path...

NOTE: fs/nfs/inode.c:nfsiod_start(), XFS's nature has influenced
LOCALIO workqueue config hacks already.. could be dragons lurking:

/*
 * Start the nfsiod workqueues
 */
static int nfsiod_start(void)
{
        dprintk("RPC:       creating workqueue nfsiod\n");
        nfsiod_workqueue = alloc_workqueue("nfsiod", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
        if (nfsiod_workqueue == NULL)
                return -ENOMEM;
#if IS_ENABLED(CONFIG_NFS_LOCALIO)
        /*
         * localio writes need to use a normal (non-memreclaim) workqueue.
         * When we start getting low on space, XFS goes and calls flush_work() on
         * a non-memreclaim work queue, which causes a priority inversion problem.
         */
        dprintk("RPC:       creating workqueue nfslocaliod\n");
        nfslocaliod_workqueue = alloc_workqueue("nfslocaliod", WQ_UNBOUND, 0);
        if (unlikely(nfslocaliod_workqueue == NULL)) {
                nfsiod_stop();
                return -ENOMEM;
        }
#endif /* CONFIG_NFS_LOCALIO */
        return 0;
}

Mike

 
> # cat local.config
> export FSTYP=nfs
> export TEST_DEV=xxxx-xxx-xxxx.xxxx.xxx.xxx:/mnt/xfstests/test/nfs-server
> export TEST_DIR=/mnt/xfstests/test/nfs-client
> export SCRATCH_DEV=xxxx-xxx-xxxx.xxxx.xxx.xxx:/mnt/xfstests/scratch/nfs-server
> export SCRATCH_MNT=/mnt/xfstests/scratch/nfs-client
> export MOUNT_OPTIONS="-o vers=4.2"
> export TEST_FS_MOUNT_OPTS="-o vers=4.2"
> 
> 
> [1]
> [23369.572660] run fstests generic/751 at 2025-10-20 23:15:24 
> [-- MARK -- Tue Oct 21 03:20:00 2025] 
> [-- MARK -- Tue Oct 21 03:25:00 2025] 
> [-- MARK -- Tue Oct 21 03:30:00 2025] 
> [-- MARK -- Tue Oct 21 03:35:00 2025] 
> [-- MARK -- Tue Oct 21 03:40:00 2025] 
> [25069.500900] INFO: task kworker/u9:73:825900 blocked for more than 122 seconds. 
> [25069.501484]       Not tainted 6.18.0-rc2 #1 
> [25069.501822] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message. 
> [25069.502385] task:kworker/u9:73   state:D stack:24712 pid:825900 tgid:825900 ppid:2      task_flags:0x4208060 flags:0x00080000 
> [25069.503258] Workqueue: writeback wb_workfn (flush-0:48) 
> [25069.782725] Call Trace: 
> [25069.787191]  <TASK> 
> [25069.787368]  __schedule+0x838/0x1890 
> [25069.799533]  ? __pfx___schedule+0x10/0x10 
> [25069.799852]  ? __blk_flush_plug+0x27b/0x4d0 
> [25069.800617]  ? find_held_lock+0x32/0x90 
> [25069.801292]  ? __lock_release.isra.0+0x1a4/0x2c0 
> [25069.801639]  schedule+0xd4/0x260 
> [25069.801902]  io_schedule+0x8f/0xf0 
> [25069.802162]  folio_wait_bit_common+0x2d9/0x780 
> [25069.802919]  ? folio_wait_bit_common+0x1dd/0x780 
> [25069.803324]  ? __pfx_folio_wait_bit_common+0x10/0x10 
> [25069.803684]  ? nfs_page_clear_headlock+0x31/0x80 [nfs] 
> [25069.804254]  ? __pfx_wake_page_function+0x10/0x10 
> [25069.804602]  ? __pfx___might_resched+0x10/0x10 
> [25069.805160]  writeback_get_folio+0x3f9/0x500 
> [25069.806221]  writeback_iter+0x136/0x720 
> [25069.806628]  nfs_writepages+0x4f8/0x9b0 [nfs] 
> [25069.807100]  ? mark_held_locks+0x40/0x70 
> [25069.807403]  ? __pfx_nfs_writepages+0x10/0x10 [nfs] 
> [25069.807846]  ? virtqueue_notify+0x68/0xc0 
> [25069.808346]  ? virtio_queue_rq+0x2b1/0x650 [virtio_blk] 
> [25069.808925]  ? __lock_acquire+0x57c/0xbd0 
> [25069.809295]  do_writepages+0x21f/0x560 
> [25069.809576]  ? __pfx_do_writepages+0x10/0x10 
> [25069.809953]  ? rcu_is_watching+0x15/0xb0 
> [25069.810587]  __writeback_single_inode+0xe2/0x5f0 
> [25069.810982]  ? __lock_release.isra.0+0x1a4/0x2c0 
> [25069.811373]  ? __pfx___writeback_single_inode+0x10/0x10 
> [25069.811815]  ? writeback_sb_inodes+0x416/0xd00 
> [25069.812194]  writeback_sb_inodes+0x535/0xd00 
> [25069.812533]  ? __pfx_stack_trace_save+0x10/0x10 
> [25069.814193]  ? local_clock_noinstr+0xd/0xe0 
> [25069.814506]  ? __pfx_writeback_sb_inodes+0x10/0x10 
> [25069.814910]  ? __lock_release.isra.0+0x1a4/0x2c0 
> [25069.815407]  ? lock_acquire+0x10b/0x150 
> [25069.815703]  ? down_read_trylock+0x4b/0x60 
> [25069.816077]  __writeback_inodes_wb+0xf4/0x270 
> [25069.816441]  ? __pfx___writeback_inodes_wb+0x10/0x10 
> [25069.816864]  ? queue_io+0x329/0x510 
> [25069.817148]  wb_writeback+0x70a/0x9c0 
> [25069.817448]  ? __pfx_wb_writeback+0x10/0x10 
> [25069.817831]  ? get_nr_dirty_inodes+0xcb/0x180 
> [25069.818264]  wb_do_writeback+0x5d4/0x8e0 
> [25069.818575]  ? __pfx_wb_do_writeback+0x10/0x10 
> [25069.818975]  ? set_worker_desc+0x16e/0x190 
> [25069.819313]  ? __pfx_set_worker_desc+0x10/0x10 
> [25069.819669]  wb_workfn+0x7c/0x200 
> [25069.819997]  process_one_work+0xd8b/0x1320 
> [25069.820342]  ? __pfx_process_one_work+0x10/0x10 
> [25069.820694]  ? assign_work+0x16c/0x240 
> [25069.821053]  worker_thread+0x5f3/0xfe0 
> [25069.821364]  ? __pfx_worker_thread+0x10/0x10 
> [25069.821697]  kthread+0x3b4/0x770 
> [25069.822122]  ? kvm_sched_clock_read+0x11/0x20 
> [25069.822457]  ? local_clock_noinstr+0xd/0xe0 
> [25069.822790]  ? __pfx_kthread+0x10/0x10 
> [25069.823079]  ? __lock_release.isra.0+0x1a4/0x2c0 
> [25069.823430]  ? rcu_is_watching+0x15/0xb0 
> [25069.823729]  ? __pfx_kthread+0x10/0x10 
> [25069.824035]  ret_from_fork+0x393/0x480 
> [25069.864794]  ? __pfx_kthread+0x10/0x10 
> [25069.865076]  ? __pfx_kthread+0x10/0x10 
> [25069.865371]  ret_from_fork_asm+0x1a/0x30 
> [25069.879905]  </TASK> 
> [25069.880145]  
> [25069.880145] Showing all locks held in the system: 
> [25069.889550] 1 lock held by khungtaskd/37: 
> [25069.889886]  #0: ffffffffa29309e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire.constprop.0+0x7/0x30 
> [25069.890603] 2 locks held by 751/825733: 
> [25069.890942]  #0: ffff888101e36440 (sb_writers#16){.+.+}-{0:0}, at: ksys_write+0xf9/0x1d0 
> [25069.891589]  #1: ffffffffa2b97fd0 (split_debug_mutex){+.+.}-{4:4}, at: split_huge_pages_write+0x124/0x430 
> [25069.892449] 3 locks held by kworker/u9:73/825900: 
> [25069.892818]  #0: ffff8881029df958 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x7f5/0x1320 
> [25069.893530]  #1: ffffc9000ad9fd10 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0xd3f/0x1320 
> [25069.894333]  #2: ffff88810b1480e8 (&type->s_umount_key#68){++++}-{4:4}, at: super_trylock_shared+0x1c/0xa0 
> [25069.895056] 2 locks held by kworker/u10:2/826054: 
> [25069.895418]  #0: ffff888103ec2158 ((wq_completion)nfsiod){+.+.}-{0:0}, at: process_one_work+0x7f5/0x1320 
> [25069.896123]  #1: ffffc90001e1fd10 ((work_completion)(&ctx->work)){+.+.}-{0:0}, at: process_one_work+0xd3f/0x1320 
> [25069.896952]  
> [25069.897085] ============================================= 
> [25069.897085]  
> [-- MARK -- Tue Oct 21 03:45:00 2025] 
> [25192.380157] INFO: task kworker/u9:73:825900 blocked for more than 245 seconds. 
> [25192.380707]       Not tainted 6.18.0-rc2 #1 
> [25192.381042] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message. 
> [25192.381605] task:kworker/u9:73   state:D stack:24712 pid:825900 tgid:825900 ppid:2      task_flags:0x4208060 flags:0x00080000 
> [25192.382516] Workqueue: writeback wb_workfn (flush-0:48) 
> [25192.382914] Call Trace: 
> [25192.383126]  <TASK> 
> [25192.383304]  __schedule+0x838/0x1890 
> [25192.383586]  ? __pfx___schedule+0x10/0x10 
> [25192.383888]  ? __blk_flush_plug+0x27b/0x4d0 
> [25192.384228]  ? find_held_lock+0x32/0x90 
> [25192.384527]  ? __lock_release.isra.0+0x1a4/0x2c0 
> [25192.384880]  schedule+0xd4/0x260 
> [25192.385150]  io_schedule+0x8f/0xf0 
> [25192.385416]  folio_wait_bit_common+0x2d9/0x780 
> [25192.385816]  ? folio_wait_bit_common+0x1dd/0x780 
> [25192.386196]  ? __pfx_folio_wait_bit_common+0x10/0x10 
> [25192.386572]  ? nfs_page_clear_headlock+0x31/0x80 [nfs] 
> [25192.387045]  ? __pfx_wake_page_function+0x10/0x10 
> [25192.387400]  ? __pfx___might_resched+0x10/0x10 
> [25192.387742]  writeback_get_folio+0x3f9/0x500 
> [25192.388092]  writeback_iter+0x136/0x720 
> [25192.388389]  nfs_writepages+0x4f8/0x9b0 [nfs] 
> [25192.388788]  ? mark_held_locks+0x40/0x70 
> [25192.389102]  ? __pfx_nfs_writepages+0x10/0x10 [nfs] 
> [25192.389530]  ? virtqueue_notify+0x68/0xc0 
> [25192.389831]  ? virtio_queue_rq+0x2b1/0x650 [virtio_blk] 
> [25192.390255]  ? __lock_acquire+0x57c/0xbd0 
> [25192.390574]  do_writepages+0x21f/0x560 
> [25192.390861]  ? __pfx_do_writepages+0x10/0x10 
> [25192.391200]  ? rcu_is_watching+0x15/0xb0 
> [25192.391502]  __writeback_single_inode+0xe2/0x5f0 
> [25192.391848]  ? __lock_release.isra.0+0x1a4/0x2c0 
> [25192.392210]  ? __pfx___writeback_single_inode+0x10/0x10 
> [25192.392596]  ? writeback_sb_inodes+0x416/0xd00 
> [25192.392935]  writeback_sb_inodes+0x535/0xd00 
> [25192.393286]  ? __pfx_stack_trace_save+0x10/0x10 
> [25192.393628]  ? local_clock_noinstr+0xd/0xe0 
> [25192.393940]  ? __pfx_writeback_sb_inodes+0x10/0x10 
> [25192.394310]  ? __lock_release.isra.0+0x1a4/0x2c0 
> [25192.394731]  ? lock_acquire+0x10b/0x150 
> [25192.395048]  ? down_read_trylock+0x4b/0x60 
> [25192.395360]  __writeback_inodes_wb+0xf4/0x270 
> [25192.395698]  ? __pfx___writeback_inodes_wb+0x10/0x10 
> [25192.396081]  ? queue_io+0x329/0x510 
> [25192.396355]  wb_writeback+0x70a/0x9c0 
> [25192.396645]  ? __pfx_wb_writeback+0x10/0x10 
> [25192.396963]  ? get_nr_dirty_inodes+0xcb/0x180 
> [25192.397314]  wb_do_writeback+0x5d4/0x8e0 
> [25192.397622]  ? __pfx_wb_do_writeback+0x10/0x10 
> [25192.397950]  ? set_worker_desc+0x16e/0x190 
> [25192.398272]  ? __pfx_set_worker_desc+0x10/0x10 
> [25192.398628]  wb_workfn+0x7c/0x200 
> [25192.398886]  process_one_work+0xd8b/0x1320 
> [25192.399222]  ? __pfx_process_one_work+0x10/0x10 
> [25192.399574]  ? assign_work+0x16c/0x240 
> [25192.399861]  worker_thread+0x5f3/0xfe0 
> [25192.400176]  ? __pfx_worker_thread+0x10/0x10 
> [25192.400497]  kthread+0x3b4/0x770 
> [25192.400747]  ? kvm_sched_clock_read+0x11/0x20 
> [25192.401089]  ? local_clock_noinstr+0xd/0xe0 
> [25192.401401]  ? __pfx_kthread+0x10/0x10 
> [25192.401684]  ? __lock_release.isra.0+0x1a4/0x2c0 
> [25192.402046]  ? rcu_is_watching+0x15/0xb0 
> [25192.402343]  ? __pfx_kthread+0x10/0x10 
> [25192.402629]  ret_from_fork+0x393/0x480 
> [25192.402910]  ? __pfx_kthread+0x10/0x10 
> [25192.403208]  ? __pfx_kthread+0x10/0x10 
> [25192.403493]  ret_from_fork_asm+0x1a/0x30 
> [25192.403808]  </TASK> 
> [25192.403994]  
> [25192.403994] Showing all locks held in the system: 
> [25192.404474] 1 lock held by khungtaskd/37: 
> [25192.404774]  #0: ffffffffa29309e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire.constprop.0+0x7/0x30 
> [25192.405487] 2 locks held by 751/825733: 
> [25192.405779]  #0: ffff888101e36440 (sb_writers#16){.+.+}-{0:0}, at: ksys_write+0xf9/0x1d0 
> [25192.406385]  #1: ffffffffa2b97fd0 (split_debug_mutex){+.+.}-{4:4}, at: split_huge_pages_write+0x124/0x430 
> [25192.407092] 4 locks held by kworker/u10:40/825850: 
> [25192.407443]  #0: ffff888103ec5158 ((wq_completion)nfslocaliod){+.+.}-{0:0}, at: process_one_work+0x7f5/0x1320 
> [25192.408175]  #1: ffffc9000b0cfd10 ((work_completion)(&iocb->work)#2){+.+.}-{0:0}, at: process_one_work+0xd3f/0x1320 
> [25192.408924]  #2: ffff88815c2c2440 (sb_writers#13){++++}-{0:0}, at: process_one_work+0xd8b/0x1320 
> [25192.409579]  #3: ffff8881a1324b58 (&sb->s_type->i_mutex_key#13){++++}-{4:4}, at: xfs_ilock+0x360/0x460 [xfs] 
> [25192.410660] 3 locks held by kworker/u9:73/825900: 
> [25192.411026]  #0: ffff8881029df958 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x7f5/0x1320 
> [25192.411724]  #1: ffffc9000ad9fd10 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0xd3f/0x1320 
> [25192.412518]  #2: ffff88810b1480e8 (&type->s_umount_key#68){++++}-{4:4}, at: super_trylock_shared+0x1c/0xa0 
> [25192.413237] 4 locks held by kworker/1:1/826103: 
> [25192.413576]  
> [25192.413706] ============================================= 
> [25192.413706]  
> [25315.259312] INFO: task kworker/u9:73:825900 blocked for more than 368 seconds. 
> [25315.259973]       Not tainted 6.18.0-rc2 #1 
> [25315.260324] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message. 
> [25315.260894] task:kworker/u9:73   state:D stack:24712 pid:825900 tgid:825900 ppid:2      task_flags:0x4208060 flags:0x00080000 
> [25315.261752] Workqueue: writeback wb_workfn (flush-0:48) 
> [25315.262153] Call Trace: 
> [25315.262369]  <TASK> 
> [25315.262551]  __schedule+0x838/0x1890 
> [25315.262840]  ? __pfx___schedule+0x10/0x10 
> [25315.263150]  ? __blk_flush_plug+0x27b/0x4d0 
> [25315.263493]  ? find_held_lock+0x32/0x90 
> [25315.263794]  ? __lock_release.isra.0+0x1a4/0x2c0 
> [25315.264151]  schedule+0xd4/0x260 
> [25315.264425]  io_schedule+0x8f/0xf0 
> [25315.264694]  folio_wait_bit_common+0x2d9/0x780 
> [25315.265100]  ? folio_wait_bit_common+0x1dd/0x780 
> [25315.265473]  ? __pfx_folio_wait_bit_common+0x10/0x10 
> [25315.265856]  ? nfs_page_clear_headlock+0x31/0x80 [nfs] 
> [25315.266332]  ? __pfx_wake_page_function+0x10/0x10 
> [25315.266692]  ? __pfx___might_resched+0x10/0x10 
> [25315.267040]  writeback_get_folio+0x3f9/0x500 
> [25315.267393]  writeback_iter+0x136/0x720 
> [25315.267693]  nfs_writepages+0x4f8/0x9b0 [nfs] 
> [25315.268106]  ? mark_held_locks+0x40/0x70 
> [25315.268425]  ? __pfx_nfs_writepages+0x10/0x10 [nfs] 
> [25315.268861]  ? virtqueue_notify+0x68/0xc0 
> [25315.269168]  ? virtio_queue_rq+0x2b1/0x650 [virtio_blk] 
> [25315.269597]  ? __lock_acquire+0x57c/0xbd0 
> [25315.269921]  do_writepages+0x21f/0x560 
> [25315.270212]  ? __pfx_do_writepages+0x10/0x10 
> [25315.270555]  ? rcu_is_watching+0x15/0xb0 
> [25315.270864]  __writeback_single_inode+0xe2/0x5f0 
> [25315.271212]  ? __lock_release.isra.0+0x1a4/0x2c0 
> [25315.271584]  ? __pfx___writeback_single_inode+0x10/0x10 
> [25315.271975]  ? writeback_sb_inodes+0x416/0xd00 
> [25315.272336]  writeback_sb_inodes+0x535/0xd00 
> [25315.272675]  ? __pfx_stack_trace_save+0x10/0x10 
> [25315.273018]  ? local_clock_noinstr+0xd/0xe0 
> [25315.273354]  ? __pfx_writeback_sb_inodes+0x10/0x10 
> [25315.273713]  ? __lock_release.isra.0+0x1a4/0x2c0 
> [25315.274107]  ? lock_acquire+0x10b/0x150 
> [25315.274426]  ? down_read_trylock+0x4b/0x60 
> [25315.274743]  __writeback_inodes_wb+0xf4/0x270 
> [25315.275083]  ? __pfx___writeback_inodes_wb+0x10/0x10 
> [25315.275470]  ? queue_io+0x329/0x510 
> [25315.275749]  wb_writeback+0x70a/0x9c0 
> [25315.276046]  ? __pfx_wb_writeback+0x10/0x10 
> [25315.276389]  ? get_nr_dirty_inodes+0xcb/0x180 
> [25315.276729]  wb_do_writeback+0x5d4/0x8e0 
> [25315.277042]  ? __pfx_wb_do_writeback+0x10/0x10 
> [25315.277401]  ? set_worker_desc+0x16e/0x190 
> [25315.277713]  ? __pfx_set_worker_desc+0x10/0x10 
> [25315.278072]  wb_workfn+0x7c/0x200 
> [25315.278352]  process_one_work+0xd8b/0x1320 
> [25315.278678]  ? __pfx_process_one_work+0x10/0x10 
> [25315.279034]  ? assign_work+0x16c/0x240 
> [25315.279346]  worker_thread+0x5f3/0xfe0 
> [25315.279650]  ? __pfx_worker_thread+0x10/0x10 
> [25315.279980]  kthread+0x3b4/0x770 
> [25315.280229]  ? kvm_sched_clock_read+0x11/0x20 
> [25315.280577]  ? local_clock_noinstr+0xd/0xe0 
> [25315.280899]  ? __pfx_kthread+0x10/0x10 
> [25315.281183]  ? __lock_release.isra.0+0x1a4/0x2c0 
> [25315.281551]  ? rcu_is_watching+0x15/0xb0 
> [25315.281886]  ? __pfx_kthread+0x10/0x10 
> [25315.282176]  ret_from_fork+0x393/0x480 
> [25315.282480]  ? __pfx_kthread+0x10/0x10 
> [25315.282770]  ? __pfx_kthread+0x10/0x10 
> [25315.283058]  ret_from_fork_asm+0x1a/0x30 
> [25315.283401]  </TASK> 
> [25315.283585]  
> [25315.283585] Showing all locks held in the system: 
> [25315.284041] 1 lock held by khungtaskd/37: 
> [25315.284360]  #0: ffffffffa29309e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire.constprop.0+0x7/0x30 
> [25315.285066] 2 locks held by 751/825733: 
> [25315.285370]  #0: ffff888101e36440 (sb_writers#16){.+.+}-{0:0}, at: ksys_write+0xf9/0x1d0 
> [25315.285974]  #1: ffffffffa2b97fd0 (split_debug_mutex){+.+.}-{4:4}, at: split_huge_pages_write+0x124/0x430 
> [25315.286683] 3 locks held by kworker/u9:73/825900: 
> [25315.287039]  #0: ffff8881029df958 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x7f5/0x1320 
> [25315.287744]  #1: ffffc9000ad9fd10 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0xd3f/0x1320 
> [25315.288534]  #2: ffff88810b1480e8 (&type->s_umount_key#68){++++}-{4:4}, at: super_trylock_shared+0x1c/0xa0 
> [25315.289261] 2 locks held by kworker/u10:2/826054: 
> [25315.289612]  #0: ffff888103ec2158 ((wq_completion)nfsiod){+.+.}-{0:0}, at: process_one_work+0x7f5/0x1320 
> [25315.290324]  #1: ffffc90001e1fd10 ((work_completion)(&ctx->work)){+.+.}-{0:0}, at: process_one_work+0xd3f/0x1320 
> [25315.291064]  
> [25315.291199] ============================================= 
> [25315.291199]  
> [25438.138585] INFO: task kworker/u9:73:825900 blocked for more than 491 seconds. 
> [25438.139167]       Not tainted 6.18.0-rc2 #1 
> [25438.139486] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message. 
> [25438.140085] task:kworker/u9:73   state:D stack:24712 pid:825900 tgid:825900 ppid:2      task_flags:0x4208060 flags:0x00080000 
> [25438.140963] Workqueue: writeback wb_workfn (flush-0:48) 
> [25438.141360] Call Trace: 
> [25438.141576]  <TASK> 
> [25438.141757]  __schedule+0x838/0x1890 
> [25438.142043]  ? __pfx___schedule+0x10/0x10 
> [25438.142347]  ? __blk_flush_plug+0x27b/0x4d0 
> [25438.142689]  ? find_held_lock+0x32/0x90 
> [25438.142987]  ? __lock_release.isra.0+0x1a4/0x2c0 
> [25438.143349]  schedule+0xd4/0x260 
> [25438.143622]  io_schedule+0x8f/0xf0 
> [25438.143891]  folio_wait_bit_common+0x2d9/0x780 
> [25438.144263]  ? folio_wait_bit_common+0x1dd/0x780 
> [25438.144639]  ? __pfx_folio_wait_bit_common+0x10/0x10 
> [25438.145021]  ? nfs_page_clear_headlock+0x31/0x80 [nfs] 
> [25438.145479]  ? __pfx_wake_page_function+0x10/0x10 
> [25438.145854]  ? __pfx___might_resched+0x10/0x10 
> [25438.146205]  writeback_get_folio+0x3f9/0x500 
> [25438.146561]  writeback_iter+0x136/0x720 
> [25438.146860]  nfs_writepages+0x4f8/0x9b0 [nfs] 
> [25438.147265]  ? mark_held_locks+0x40/0x70 
> [25438.147582]  ? __pfx_nfs_writepages+0x10/0x10 [nfs] 
> [25438.148015]  ? virtqueue_notify+0x68/0xc0 
> [25438.148319]  ? virtio_queue_rq+0x2b1/0x650 [virtio_blk] 
> [25438.148749]  ? __lock_acquire+0x57c/0xbd0 
> [25438.149072]  do_writepages+0x21f/0x560 
> [25438.149364]  ? __pfx_do_writepages+0x10/0x10 
> [25438.149705]  ? rcu_is_watching+0x15/0xb0 
> [25438.150014]  __writeback_single_inode+0xe2/0x5f0 
> [25438.150362]  ? __lock_release.isra.0+0x1a4/0x2c0 
> [25438.150731]  ? __pfx___writeback_single_inode+0x10/0x10 
> [25438.151123]  ? writeback_sb_inodes+0x416/0xd00 
> [25438.151466]  writeback_sb_inodes+0x535/0xd00 
> [25438.151825]  ? __pfx_stack_trace_save+0x10/0x10 
> [25438.152171]  ? local_clock_noinstr+0xd/0xe0 
> [25438.152504]  ? __pfx_writeback_sb_inodes+0x10/0x10 
> [25438.152864]  ? __lock_release.isra.0+0x1a4/0x2c0 
> [25438.153262]  ? lock_acquire+0x10b/0x150 
> [25438.153577]  ? down_read_trylock+0x4b/0x60 
> [25438.153894]  __writeback_inodes_wb+0xf4/0x270 
> [25438.154231]  ? __pfx___writeback_inodes_wb+0x10/0x10 
> [25438.154622]  ? queue_io+0x329/0x510 
> [25438.154899]  wb_writeback+0x70a/0x9c0 
> [25438.155193]  ? __pfx_wb_writeback+0x10/0x10 
> [25438.155536]  ? get_nr_dirty_inodes+0xcb/0x180 
> [25438.155877]  wb_do_writeback+0x5d4/0x8e0 
> [25438.156190]  ? __pfx_wb_do_writeback+0x10/0x10 
> [25438.156554]  ? set_worker_desc+0x16e/0x190 
> [25438.156865]  ? __pfx_set_worker_desc+0x10/0x10 
> [25438.157225]  wb_workfn+0x7c/0x200 
> [25438.157486]  process_one_work+0xd8b/0x1320 
> [25438.157830]  ? __pfx_process_one_work+0x10/0x10 
> [25438.158185]  ? assign_work+0x16c/0x240 
> [25438.158478]  worker_thread+0x5f3/0xfe0 
> [25438.158800]  ? __pfx_worker_thread+0x10/0x10 
> [25438.159129]  kthread+0x3b4/0x770 
> [25438.159382]  ? kvm_sched_clock_read+0x11/0x20 
> [25438.159730]  ? local_clock_noinstr+0xd/0xe0 
> [25438.160049]  ? __pfx_kthread+0x10/0x10 
> [25438.160335]  ? __lock_release.isra.0+0x1a4/0x2c0 
> [25438.160703]  ? rcu_is_watching+0x15/0xb0 
> [25438.161010]  ? __pfx_kthread+0x10/0x10 
> [25438.161303]  ret_from_fork+0x393/0x480 
> [25438.161605]  ? __pfx_kthread+0x10/0x10 
> [25438.161892]  ? __pfx_kthread+0x10/0x10 
> [25438.162184]  ret_from_fork_asm+0x1a/0x30 
> [25438.162521]  </TASK> 
> [25438.162705]  
> [25438.162705] Showing all locks held in the system: 
> [25438.163161] 1 lock held by khungtaskd/37: 
> [25438.163461]  #0: ffffffffa29309e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire.constprop.0+0x7/0x30 
> [25438.164190] 2 locks held by 751/825733: 
> [25438.164483]  #0: ffff888101e36440 (sb_writers#16){.+.+}-{0:0}, at: ksys_write+0xf9/0x1d0 
> [25438.165101]  #1: ffffffffa2b97fd0 (split_debug_mutex){+.+.}-{4:4}, at: split_huge_pages_write+0x124/0x430 
> [25438.165820] 3 locks held by kworker/u9:73/825900: 
> [25438.166177]  #0: ffff8881029df958 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x7f5/0x1320 
> [25438.166895]  #1: ffffc9000ad9fd10 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0xd3f/0x1320 
> [25438.167703]  #2: ffff88810b1480e8 (&type->s_umount_key#68){++++}-{4:4}, at: super_trylock_shared+0x1c/0xa0 
> [25438.168412] 2 locks held by kworker/u10:2/826054: 
> [25438.168783]  #0: ffff888103ec2158 ((wq_completion)nfsiod){+.+.}-{0:0}, at: process_one_work+0x7f5/0x1320 
> [25438.169473]  #1: ffffc90001e1fd10 ((work_completion)(&ctx->work)){+.+.}-{0:0}, at: process_one_work+0xd3f/0x1320 
> [25438.170230]  
> [25438.170364] ============================================= 
> [25438.170364]  
> [-- MARK -- Tue Oct 21 03:50:00 2025] 
> [25561.017812] INFO: task kworker/u9:73:825900 blocked for more than 614 seconds. 
> [25561.018375]       Not tainted 6.18.0-rc2 #1 
> [25561.018694] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message. 
> [25561.019310] task:kworker/u9:73   state:D stack:24712 pid:825900 tgid:825900 ppid:2      task_flags:0x4208060 flags:0x00080000 
> [25561.020172] Workqueue: writeback wb_workfn (flush-0:48) 
> [25561.020573] Call Trace: 
> [25561.020786]  <TASK> 
> [25561.020966]  __schedule+0x838/0x1890 
> [25561.021254]  ? __pfx___schedule+0x10/0x10 
> [25561.021560]  ? __blk_flush_plug+0x27b/0x4d0 
> [25561.021906]  ? find_held_lock+0x32/0x90 
> [25561.022200]  ? __lock_release.isra.0+0x1a4/0x2c0 
> [25561.022560]  schedule+0xd4/0x260 
> [25561.022833]  io_schedule+0x8f/0xf0 
> [25561.023102]  folio_wait_bit_common+0x2d9/0x780 
> [25561.023475]  ? folio_wait_bit_common+0x1dd/0x780 
> [25561.023844]  ? __pfx_folio_wait_bit_common+0x10/0x10 
> [25561.024216]  ? nfs_page_clear_headlock+0x31/0x80 [nfs] 
> [25561.024686]  ? __pfx_wake_page_function+0x10/0x10 
> [25561.025050]  ? __pfx___might_resched+0x10/0x10 
> [25561.025389]  writeback_get_folio+0x3f9/0x500 
> [25561.025711]  writeback_iter+0x136/0x720 
> [25561.026014]  nfs_writepages+0x4f8/0x9b0 [nfs] 
> [25561.026402]  ? mark_held_locks+0x40/0x70 
> [25561.026698]  ? __pfx_nfs_writepages+0x10/0x10 [nfs] 
> [25561.027155]  ? virtqueue_notify+0x68/0xc0 
> [25561.027462]  ? virtio_queue_rq+0x2b1/0x650 [virtio_blk] 
> [25561.027894]  ? __lock_acquire+0x57c/0xbd0 
> [25561.028213]  do_writepages+0x21f/0x560 
> [25561.028507]  ? __pfx_do_writepages+0x10/0x10 
> [25561.028849]  ? rcu_is_watching+0x15/0xb0 
> [25561.029154]  __writeback_single_inode+0xe2/0x5f0 
> [25561.029608]  ? __lock_release.isra.0+0x1a4/0x2c0 
> [25561.029982]  ? __pfx___writeback_single_inode+0x10/0x10 
> [25561.030374]  ? writeback_sb_inodes+0x416/0xd00 
> [25561.030715]  writeback_sb_inodes+0x535/0xd00 
> [25561.031072]  ? __pfx_stack_trace_save+0x10/0x10 
> [25561.031420]  ? local_clock_noinstr+0xd/0xe0 
> [25561.031761]  ? __pfx_writeback_sb_inodes+0x10/0x10 
> [25561.032121]  ? __lock_release.isra.0+0x1a4/0x2c0 
> [25561.032516]  ? lock_acquire+0x10b/0x150 
> [25561.032832]  ? down_read_trylock+0x4b/0x60 
> [25561.033149]  __writeback_inodes_wb+0xf4/0x270 
> [25561.033487]  ? __pfx___writeback_inodes_wb+0x10/0x10 
> [25561.033881]  ? queue_io+0x329/0x510 
> [25561.034157]  wb_writeback+0x70a/0x9c0 
> [25561.034452]  ? __pfx_wb_writeback+0x10/0x10 
> [25561.034794]  ? get_nr_dirty_inodes+0xcb/0x180 
> [25561.035134]  wb_do_writeback+0x5d4/0x8e0 
> [25561.035443]  ? __pfx_wb_do_writeback+0x10/0x10 
> [25561.035796]  ? set_worker_desc+0x16e/0x190 
> [25561.036105]  ? __pfx_set_worker_desc+0x10/0x10 
> [25561.036463]  wb_workfn+0x7c/0x200 
> [25561.036724]  process_one_work+0xd8b/0x1320 
> [25561.037065]  ? __pfx_process_one_work+0x10/0x10 
> [25561.037422]  ? assign_work+0x16c/0x240 
> [25561.037718]  worker_thread+0x5f3/0xfe0 
> [25561.038035]  ? __pfx_worker_thread+0x10/0x10 
> [25561.038355]  kthread+0x3b4/0x770 
> [25561.038603]  ? kvm_sched_clock_read+0x11/0x20 
> [25561.038951]  ? local_clock_noinstr+0xd/0xe0 
> [25561.039272]  ? __pfx_kthread+0x10/0x10 
> [25561.039555]  ? __lock_release.isra.0+0x1a4/0x2c0 
> [25561.039921]  ? rcu_is_watching+0x15/0xb0 
> [25561.040221]  ? __pfx_kthread+0x10/0x10 
> [25561.040511]  ret_from_fork+0x393/0x480 
> [25561.040813]  ? __pfx_kthread+0x10/0x10 
> [25561.041101]  ? __pfx_kthread+0x10/0x10 
> [25561.041392]  ret_from_fork_asm+0x1a/0x30 
> [25561.041707]  </TASK> 
> [25561.041908]  
> [25561.041908] Showing all locks held in the system: 
> [25561.042365] 1 lock held by khungtaskd/37: 
> [25561.042662]  #0: ffffffffa29309e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire.constprop.0+0x7/0x30 
> [25561.043384] 2 locks held by 751/825733: 
> [25561.043677]  #0: ffff888101e36440 (sb_writers#16){.+.+}-{0:0}, at: ksys_write+0xf9/0x1d0 
> [25561.044296]  #1: ffffffffa2b97fd0 (split_debug_mutex){+.+.}-{4:4}, at: split_huge_pages_write+0x124/0x430 
> [25561.045009] 3 locks held by kworker/u9:73/825900: 
> [25561.045362]  #0: ffff8881029df958 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x7f5/0x1320 
> [25561.046085]  #1: ffffc9000ad9fd10 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0xd3f/0x1320 
> [25561.046895]  #2: ffff88810b1480e8 (&type->s_umount_key#68){++++}-{4:4}, at: super_trylock_shared+0x1c/0xa0 
> [25561.047600] 2 locks held by kworker/u10:13/826064: 
> [25561.047970]  #0: ffff888103ec2158 ((wq_completion)nfsiod){+.+.}-{0:0}, at: process_one_work+0x7f5/0x1320 
> [25561.048657]  #1: ffffc90001e9fd10 ((work_completion)(&ctx->work)){+.+.}-{0:0}, at: process_one_work+0xd3f/0x1320 
> [25561.049410]  
> [25561.049538] ============================================= 
> [25561.049538]  
> [25683.897277] INFO: task kworker/u9:73:825900 blocked for more than 737 seconds. 
> [25683.897831]       Not tainted 6.18.0-rc2 #1 
> [25683.898182] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message. 
> [25683.898754] task:kworker/u9:73   state:D stack:24712 pid:825900 tgid:825900 ppid:2      task_flags:0x4208060 flags:0x00080000 
> [25683.899587] Workqueue: writeback wb_workfn (flush-0:48) 
> [25683.900001] Call Trace: 
> [25683.900200]  <TASK> 
> [25683.900379]  __schedule+0x838/0x1890 
> [25683.900663]  ? __pfx___schedule+0x10/0x10 
> [25683.900967]  ? __blk_flush_plug+0x27b/0x4d0 
> [25683.901308]  ? find_held_lock+0x32/0x90 
> [25683.901609]  ? __lock_release.isra.0+0x1a4/0x2c0 
> [25683.901964]  schedule+0xd4/0x260 
> [25683.902235]  io_schedule+0x8f/0xf0 
> [25683.902507]  folio_wait_bit_common+0x2d9/0x780 
> [25683.902874]  ? folio_wait_bit_common+0x1dd/0x780 
> [25683.903256]  ? __pfx_folio_wait_bit_common+0x10/0x10 
> [25683.903636]  ? nfs_page_clear_headlock+0x31/0x80 [nfs] 
> [25683.904111]  ? __pfx_wake_page_function+0x10/0x10 
> [25683.904469]  ? __pfx___might_resched+0x10/0x10 
> [25683.904819]  writeback_get_folio+0x3f9/0x500 
> [25683.905170]  writeback_iter+0x136/0x720 
> [25683.905469]  nfs_writepages+0x4f8/0x9b0 [nfs] 
> [25683.905878]  ? mark_held_locks+0x40/0x70 
> [25683.906194]  ? __pfx_nfs_writepages+0x10/0x10 [nfs] 
> [25683.906631]  ? virtqueue_notify+0x68/0xc0 
> [25683.906936]  ? virtio_queue_rq+0x2b1/0x650 [virtio_blk] 
> [25683.907368]  ? __lock_acquire+0x57c/0xbd0 
> [25683.907691]  do_writepages+0x21f/0x560 
> [25683.907999]  ? __pfx_do_writepages+0x10/0x10 
> [25683.908325]  ? rcu_is_watching+0x15/0xb0 
> [25683.908635]  __writeback_single_inode+0xe2/0x5f0 
> [25683.909013]  ? __lock_release.isra.0+0x1a4/0x2c0 
> [25683.909368]  ? __pfx___writeback_single_inode+0x10/0x10 
> [25683.909756]  ? writeback_sb_inodes+0x416/0xd00 
> [25683.910118]  writeback_sb_inodes+0x535/0xd00 
> [25683.910459]  ? __pfx_stack_trace_save+0x10/0x10 
> [25683.910807]  ? local_clock_noinstr+0xd/0xe0 
> [25683.911138]  ? __pfx_writeback_sb_inodes+0x10/0x10 
> [25683.911500]  ? __lock_release.isra.0+0x1a4/0x2c0 
> [25683.911896]  ? lock_acquire+0x10b/0x150 
> [25683.912211]  ? down_read_trylock+0x4b/0x60 
> [25683.912532]  __writeback_inodes_wb+0xf4/0x270 
> [25683.912869]  ? __pfx___writeback_inodes_wb+0x10/0x10 
> [25683.913259]  ? queue_io+0x329/0x510 
> [25683.913540]  wb_writeback+0x70a/0x9c0 
> [25683.913832]  ? __pfx_wb_writeback+0x10/0x10 
> [25683.914174]  ? get_nr_dirty_inodes+0xcb/0x180 
> [25683.914516]  wb_do_writeback+0x5d4/0x8e0 
> [25683.914831]  ? __pfx_wb_do_writeback+0x10/0x10 
> [25683.915185]  ? set_worker_desc+0x16e/0x190 
> [25683.915501]  ? __pfx_set_worker_desc+0x10/0x10 
> [25683.915860]  wb_workfn+0x7c/0x200 
> [25683.916139]  process_one_work+0xd8b/0x1320 
> [25683.916465]  ? __pfx_process_one_work+0x10/0x10 
> [25683.916822]  ? assign_work+0x16c/0x240 
> [25683.917133]  worker_thread+0x5f3/0xfe0 
> [25683.917437]  ? __pfx_worker_thread+0x10/0x10 
> [25683.917767]  kthread+0x3b4/0x770 
> [25683.918037]  ? kvm_sched_clock_read+0x11/0x20 
> [25683.918368]  ? local_clock_noinstr+0xd/0xe0 
> [25683.918687]  ? __pfx_kthread+0x10/0x10 
> [25683.918969]  ? __lock_release.isra.0+0x1a4/0x2c0 
> [25683.919334]  ? rcu_is_watching+0x15/0xb0 
> [25683.919640]  ? __pfx_kthread+0x10/0x10 
> [25683.919929]  ret_from_fork+0x393/0x480 
> [25683.920234]  ? __pfx_kthread+0x10/0x10 
> [25683.920523]  ? __pfx_kthread+0x10/0x10 
> [25683.920815]  ret_from_fork_asm+0x1a/0x30 
> [25683.921152]  </TASK> 
> [25683.921333] Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings 
> [25683.921921]  
> [25683.921921] Showing all locks held in the system: 
> [25683.922392] 1 lock held by khungtaskd/37: 
> [25683.922698]  #0: ffffffffa29309e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire.constprop.0+0x7/0x30 
> [25683.923423] 2 locks held by 751/825733: 
> [25683.923720]  #0: ffff888101e36440 (sb_writers#16){.+.+}-{0:0}, at: ksys_write+0xf9/0x1d0 
> [25683.924331]  #1: ffffffffa2b97fd0 (split_debug_mutex){+.+.}-{4:4}, at: split_huge_pages_write+0x124/0x430 
> [25683.925045] 3 locks held by kworker/u9:73/825900: 
> [25683.925398]  #0: ffff8881029df958 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x7f5/0x1320 
> [25683.926121]  #1: ffffc9000ad9fd10 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0xd3f/0x1320 
> [25683.926918]  #2: ffff88810b1480e8 (&type->s_umount_key#68){++++}-{4:4}, at: super_trylock_shared+0x1c/0xa0 
> [25683.927641] 4 locks held by kworker/u9:143/826036: 
> [25683.928022]  #0: ffff888103ec5158 ((wq_completion)nfslocaliod){+.+.}-{0:0}, at: process_one_work+0x7f5/0x1320 
> [25683.928743]  #1: ffffc90001cc7d10 ((work_completion)(&iocb->work)#2){+.+.}-{0:0}, at: process_one_work+0xd3f/0x1320 
> [25683.929514]  #2: ffff88815c2c2440 (sb_writers#13){++++}-{0:0}, at: process_one_work+0xd8b/0x1320 
> [25683.930175]  #3: ffff8881a1324b58 (&sb->s_type->i_mutex_key#13){++++}-{4:4}, at: xfs_ilock+0x360/0x460 [xfs] 
> [25683.931255]  
> [25683.931391] ============================================= 
> [25683.931391]  
> [-- MARK -- Tue Oct 21 03:55:00 2025] 
> [-- MARK -- Tue Oct 21 04:00:00 2025] 
> [-- MARK -- Tue Oct 21 04:05:00 2025] 
> 
> 
> [2]
> [12082.409406] run fstests generic/751 at 2025-10-20 19:04:12 
> [-- MARK -- Mon Oct 20 23:05:00 2025] 
> [-- MARK -- Mon Oct 20 23:10:00 2025] 
> [-- MARK -- Mon Oct 20 23:15:00 2025] 
> [13023.321998] INFO: task kworker/u17:206:858774 blocked for more than 122 seconds. 
> [13023.322058]       Tainted: G    B               6.18.0-rc2 #1 
> [13023.322062] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message. 
> [13023.322064] task:kworker/u17:206 state:D stack:23184 pid:858774 tgid:858774 ppid:2      task_flags:0x4208060 flags:0x00000210 
> [13023.322077] Workqueue: writeback wb_workfn (flush-0:56) 
> [13023.322089] Call trace: 
> [13023.322091]  __switch_to+0x1e0/0x488 (T) 
> [13023.322098]  __schedule+0x748/0x1430 
> [13023.322103]  schedule+0xd0/0x240 
> [13023.322107]  io_schedule+0xb4/0x120 
> [13023.322112]  folio_wait_bit_common+0x2c4/0x708 
> [13023.322117]  __folio_lock+0x24/0x38 
> [13023.322120]  writeback_get_folio+0x37c/0x480 
> [13023.322125]  writeback_iter+0x128/0x6d0 
> [13023.322130]  nfs_writepages+0x504/0x930 [nfs] 
> [13023.322194]  do_writepages+0x204/0x4c0 
> [13023.322198]  __writeback_single_inode+0xec/0x4f8 
> [13023.322204]  writeback_sb_inodes+0x4a4/0xab8 
> [13023.322296]  __writeback_inodes_wb+0x104/0x260 
> [13023.322301]  wb_writeback+0x840/0xce0 
> [13023.322305]  wb_do_writeback+0x69c/0x940 
> [13023.322308]  wb_workfn+0x80/0x1c0 
> [13023.322312]  process_one_work+0x774/0x12d0 
> [13023.322318]  worker_thread+0x434/0xca0 
> [13023.322322]  kthread+0x2ec/0x390 
> [13023.322326]  ret_from_fork+0x10/0x20 
> [13023.322409] INFO: lockdep is turned off. 
> [-- MARK -- Mon Oct 20 23:20:00 2025] 
> [13146.212082] INFO: task kworker/u17:206:858774 blocked for more than 245 seconds. 
> [13146.212109]       Tainted: G    B               6.18.0-rc2 #1 
> [13146.212120] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message. 
> [13146.212125] task:kworker/u17:206 state:D stack:23184 pid:858774 tgid:858774 ppid:2      task_flags:0x4208060 flags:0x00000210 
> [13146.212141] Workqueue: writeback wb_workfn (flush-0:56) 
> [13146.212160] Call trace: 
> [13146.212165]  __switch_to+0x1e0/0x488 (T) 
> [13146.212175]  __schedule+0x748/0x1430 
> [13146.212182]  schedule+0xd0/0x240 
> [13146.212189]  io_schedule+0xb4/0x120 
> [13146.212196]  folio_wait_bit_common+0x2c4/0x708 
> [13146.212203]  __folio_lock+0x24/0x38 
> [13146.212209]  writeback_get_folio+0x37c/0x480 
> [13146.212217]  writeback_iter+0x128/0x6d0 
> [13146.212222]  nfs_writepages+0x504/0x930 [nfs] 
> [13146.212287]  do_writepages+0x204/0x4c0 
> [13146.212291]  __writeback_single_inode+0xec/0x4f8 
> [13146.212294]  writeback_sb_inodes+0x4a4/0xab8 
> [13146.212298]  __writeback_inodes_wb+0x104/0x260 
> [13146.212302]  wb_writeback+0x840/0xce0 
> [13146.212306]  wb_do_writeback+0x69c/0x940 
> [13146.212309]  wb_workfn+0x80/0x1c0 
> [13146.212313]  process_one_work+0x774/0x12d0 
> [13146.212318]  worker_thread+0x434/0xca0 
> [13146.212321]  kthread+0x2ec/0x390 
> [13146.212325]  ret_from_fork+0x10/0x20 
> [13146.212360] INFO: lockdep is turned off. 
> [13269.082400] INFO: task kworker/u17:206:858774 blocked for more than 368 seconds. 
> [13269.082553]       Tainted: G    B               6.18.0-rc2 #1 
> [13269.082557] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message. 
> [13269.082559] task:kworker/u17:206 state:D stack:23184 pid:858774 tgid:858774 ppid:2      task_flags:0x4208060 flags:0x00000210 
> [13269.082570] Workqueue: writeback wb_workfn (flush-0:56) 
> [13269.082581] Call trace: 
> [13269.082583]  __switch_to+0x1e0/0x488 (T) 
> [13269.082591]  __schedule+0x748/0x1430 
> [13269.082596]  schedule+0xd0/0x240 
> [13269.082600]  io_schedule+0xb4/0x120 
> [13269.082604]  folio_wait_bit_common+0x2c4/0x708 
> [13269.082610]  __folio_lock+0x24/0x38 
> [13269.082613]  writeback_get_folio+0x37c/0x480 
> [13269.082618]  writeback_iter+0x128/0x6d0 
> [13269.082622]  nfs_writepages+0x504/0x930 [nfs] 
> [13269.082749]  do_writepages+0x204/0x4c0 
> [13269.082754]  __writeback_single_inode+0xec/0x4f8 
> [13269.082758]  writeback_sb_inodes+0x4a4/0xab8 
> [13269.082762]  __writeback_inodes_wb+0x104/0x260 
> [13269.082766]  wb_writeback+0x840/0xce0 
> [13269.082769]  wb_do_writeback+0x69c/0x940 
> [13269.082773]  wb_workfn+0x80/0x1c0 
> [13269.082777]  process_one_work+0x774/0x12d0 
> [13269.082782]  worker_thread+0x434/0xca0 
> [13269.082785]  kthread+0x2ec/0x390 
> [13269.082789]  ret_from_fork+0x10/0x20 
> [13269.082805] INFO: lockdep is turned off. 
> [-- MARK -- Mon Oct 20 23:25:00 2025] 
> [13391.972505] INFO: task kworker/u17:206:858774 blocked for more than 491 seconds. 
> [13391.972535]       Tainted: G    B               6.18.0-rc2 #1 
> [13391.972549] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message. 
> [13391.972555] task:kworker/u17:206 state:D stack:23184 pid:858774 tgid:858774 ppid:2      task_flags:0x4208060 flags:0x00000210 
> [13391.972571] Workqueue: writeback wb_workfn (flush-0:56) 
> [13391.972585] Call trace: 
> [13391.972587]  __switch_to+0x1e0/0x488 (T) 
> [13391.972595]  __schedule+0x748/0x1430 
> [13391.972600]  schedule+0xd0/0x240 
> [13391.972605]  io_schedule+0xb4/0x120 
> [13391.972609]  folio_wait_bit_common+0x2c4/0x708 
> [13391.972614]  __folio_lock+0x24/0x38 
> [13391.972618]  writeback_get_folio+0x37c/0x480 
> [13391.972624]  writeback_iter+0x128/0x6d0 
> [13391.972628]  nfs_writepages+0x504/0x930 [nfs] 
> [13391.972700]  do_writepages+0x204/0x4c0 
> [13391.972704]  __writeback_single_inode+0xec/0x4f8 
> [13391.972708]  writeback_sb_inodes+0x4a4/0xab8 
> [13391.972712]  __writeback_inodes_wb+0x104/0x260 
> [13391.972716]  wb_writeback+0x840/0xce0 
> [13391.972720]  wb_do_writeback+0x69c/0x940 
> [13391.972724]  wb_workfn+0x80/0x1c0 
> [13391.972727]  process_one_work+0x774/0x12d0 
> [13391.972733]  worker_thread+0x434/0xca0 
> [13391.972736]  kthread+0x2ec/0x390 
> [13391.972740]  ret_from_fork+0x10/0x20 
> [13391.972761] INFO: lockdep is turned off. 
> [13514.852712] INFO: task kworker/u17:206:858774 blocked for more than 614 seconds. 
> [13514.852737]       Tainted: G    B               6.18.0-rc2 #1 
> [13514.852749] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message. 
> [13514.852756] task:kworker/u17:206 state:D stack:23184 pid:858774 tgid:858774 ppid:2      task_flags:0x4208060 flags:0x00000210 
> [13514.852768] Workqueue: writeback wb_workfn (flush-0:56) 
> [13514.852779] Call trace: 
> [13514.852781]  __switch_to+0x1e0/0x488 (T) 
> [13514.852790]  __schedule+0x748/0x1430 
> [13514.852795]  schedule+0xd0/0x240 
> [13514.852808]  io_schedule+0xb4/0x120 
> [13514.852812]  folio_wait_bit_common+0x2c4/0x708 
> [13514.852818]  __folio_lock+0x24/0x38 
> [13514.852822]  writeback_get_folio+0x37c/0x480 
> [13514.852827]  writeback_iter+0x128/0x6d0 
> [13514.852831]  nfs_writepages+0x504/0x930 [nfs] 
> [13514.852897]  do_writepages+0x204/0x4c0 
> [13514.852901]  __writeback_single_inode+0xec/0x4f8 
> [13514.852905]  writeback_sb_inodes+0x4a4/0xab8 
> [13514.852908]  __writeback_inodes_wb+0x104/0x260 
> [13514.852912]  wb_writeback+0x840/0xce0 
> [13514.852916]  wb_do_writeback+0x69c/0x940 
> [13514.852919]  wb_workfn+0x80/0x1c0 
> [13514.852923]  process_one_work+0x774/0x12d0 
> [13514.852928]  worker_thread+0x434/0xca0 
> [13514.852932]  kthread+0x2ec/0x390 
> [13514.852936]  ret_from_fork+0x10/0x20 
> [13514.852955] INFO: lockdep is turned off. 
> [-- MARK -- Mon Oct 20 23:30:00 2025] 
> [13637.723028] INFO: task kworker/u17:206:858774 blocked for more than 737 seconds. 
> [13637.723055]       Tainted: G    B               6.18.0-rc2 #1 
> [13637.723067] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message. 
> [13637.723072] task:kworker/u17:206 state:D stack:23184 pid:858774 tgid:858774 ppid:2      task_flags:0x4208060 flags:0x00000210 
> [13637.723086] Workqueue: writeback wb_workfn (flush-0:56) 
> [13637.723099] Call trace: 
> [13637.723101]  __switch_to+0x1e0/0x488 (T) 
> [13637.723110]  __schedule+0x748/0x1430 
> [13637.723115]  schedule+0xd0/0x240 
> [13637.723119]  io_schedule+0xb4/0x120 
> [13637.723124]  folio_wait_bit_common+0x2c4/0x708 
> [13637.723129]  __folio_lock+0x24/0x38 
> [13637.723133]  writeback_get_folio+0x37c/0x480 
> [13637.723138]  writeback_iter+0x128/0x6d0 
> [13637.723142]  nfs_writepages+0x504/0x930 [nfs] 
> [13637.723210]  do_writepages+0x204/0x4c0 
> [13637.723213]  __writeback_single_inode+0xec/0x4f8 
> [13637.723217]  writeback_sb_inodes+0x4a4/0xab8 
> [13637.723221]  __writeback_inodes_wb+0x104/0x260 
> [13637.723225]  wb_writeback+0x840/0xce0 
> [13637.723229]  wb_do_writeback+0x69c/0x940 
> [13637.723232]  wb_workfn+0x80/0x1c0 
> [13637.723237]  process_one_work+0x774/0x12d0 
> [13637.723242]  worker_thread+0x434/0xca0 
> [13637.723246]  kthread+0x2ec/0x390 
> [13637.723250]  ret_from_fork+0x10/0x20 
> [13637.723271] INFO: lockdep is turned off. 
> [13760.603116] INFO: task kworker/u17:206:858774 blocked for more than 860 seconds. 
> [13760.603144]       Tainted: G    B               6.18.0-rc2 #1 
> [13760.603158] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message. 
> [13760.603163] task:kworker/u17:206 state:D stack:23184 pid:858774 tgid:858774 ppid:2      task_flags:0x4208060 flags:0x00000210 
> [13760.603180] Workqueue: writeback wb_workfn (flush-0:56) 
> [13760.603199] Call trace: 
> [13760.603203]  __switch_to+0x1e0/0x488 (T) 
> [13760.603214]  __schedule+0x748/0x1430 
> [13760.603221]  schedule+0xd0/0x240 
> [13760.603228]  io_schedule+0xb4/0x120 
> [13760.603234]  folio_wait_bit_common+0x2c4/0x708 
> [13760.603242]  __folio_lock+0x24/0x38 
> [13760.603248]  writeback_get_folio+0x37c/0x480 
> [13760.603341]  writeback_iter+0x128/0x6d0 
> [13760.603349]  nfs_writepages+0x504/0x930 [nfs] 
> [13760.603421]  do_writepages+0x204/0x4c0 
> [13760.603427]  __writeback_single_inode+0xec/0x4f8 
> [13760.603434]  writeback_sb_inodes+0x4a4/0xab8 
> [13760.603440]  __writeback_inodes_wb+0x104/0x260 
> [13760.603447]  wb_writeback+0x840/0xce0 
> [13760.603453]  wb_do_writeback+0x69c/0x940 
> [13760.603459]  wb_workfn+0x80/0x1c0 
> [13760.603465]  process_one_work+0x774/0x12d0 
> [13760.603472]  worker_thread+0x434/0xca0 
> [13760.603478]  kthread+0x2ec/0x390 
> [13760.603485]  ret_from_fork+0x10/0x20 
> [13760.603507] INFO: lockdep is turned off. 
> [13883.483295] INFO: task kworker/u17:206:858774 blocked for more than 983 seconds. 
> [13883.483320]       Tainted: G    B               6.18.0-rc2 #1 
> [13883.483340] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message. 
> [13883.483343] task:kworker/u17:206 state:D stack:23184 pid:858774 tgid:858774 ppid:2      task_flags:0x4208060 flags:0x00000210 
> [13883.483356] Workqueue: writeback wb_workfn (flush-0:56) 
> [13883.483368] Call trace: 
> [13883.483371]  __switch_to+0x1e0/0x488 (T) 
> [13883.483379]  __schedule+0x748/0x1430 
> [13883.483384]  schedule+0xd0/0x240 
> [13883.483388]  io_schedule+0xb4/0x120 
> [13883.483392]  folio_wait_bit_common+0x2c4/0x708 
> [13883.483397]  __folio_lock+0x24/0x38 
> [13883.483401]  writeback_get_folio+0x37c/0x480 
> [13883.483406]  writeback_iter+0x128/0x6d0 
> [13883.483411]  nfs_writepages+0x504/0x930 [nfs] 
> [13883.483477]  do_writepages+0x204/0x4c0 
> [13883.483481]  __writeback_single_inode+0xec/0x4f8 
> [13883.483485]  writeback_sb_inodes+0x4a4/0xab8 
> [13883.483489]  __writeback_inodes_wb+0x104/0x260 
> [13883.483493]  wb_writeback+0x840/0xce0 
> [13883.483496]  wb_do_writeback+0x69c/0x940 
> [13883.483500]  wb_workfn+0x80/0x1c0 
> [13883.483504]  process_one_work+0x774/0x12d0 
> [13883.483509]  worker_thread+0x434/0xca0 
> [13883.483512]  kthread+0x2ec/0x390 
> [13883.483517]  ret_from_fork+0x10/0x20 
> [13883.483538] INFO: lockdep is turned off. 
> [-- MARK -- Mon Oct 20 23:35:00 2025] 
> [14006.363497] INFO: task kworker/u17:206:858774 blocked for more than 1105 seconds. 
> [14006.363521]       Tainted: G    B               6.18.0-rc2 #1 
> [14006.363542] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message. 
> [14006.363545] task:kworker/u17:206 state:D stack:23184 pid:858774 tgid:858774 ppid:2      task_flags:0x4208060 flags:0x00000210 
> [14006.363557] Workqueue: writeback wb_workfn (flush-0:56) 
> [14006.363569] Call trace: 
> [14006.363571]  __switch_to+0x1e0/0x488 (T) 
> [14006.363579]  __schedule+0x748/0x1430 
> [14006.363584]  schedule+0xd0/0x240 
> [14006.363588]  io_schedule+0xb4/0x120 
> [14006.363592]  folio_wait_bit_common+0x2c4/0x708 
> [14006.363597]  __folio_lock+0x24/0x38 
> [14006.363601]  writeback_get_folio+0x37c/0x480 
> [14006.363606]  writeback_iter+0x128/0x6d0 
> [14006.363610]  nfs_writepages+0x504/0x930 [nfs] 
> [14006.363676]  do_writepages+0x204/0x4c0 
> [14006.363680]  __writeback_single_inode+0xec/0x4f8 
> [14006.363684]  writeback_sb_inodes+0x4a4/0xab8 
> [14006.363687]  __writeback_inodes_wb+0x104/0x260 
> [14006.363691]  wb_writeback+0x840/0xce0 
> [14006.363695]  wb_do_writeback+0x69c/0x940 
> [14006.363699]  wb_workfn+0x80/0x1c0 
> [14006.363702]  process_one_work+0x774/0x12d0 
> [14006.363707]  worker_thread+0x434/0xca0 
> [14006.363711]  kthread+0x2ec/0x390 
> [14006.363715]  ret_from_fork+0x10/0x20 
> [14006.363735] INFO: lockdep is turned off. 
> [14129.243869] INFO: task kworker/u17:206:858774 blocked for more than 1228 seconds. 
> [14129.244026]       Tainted: G    B               6.18.0-rc2 #1 
> [14129.244030] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message. 
> [14129.244033] task:kworker/u17:206 state:D stack:23184 pid:858774 tgid:858774 ppid:2      task_flags:0x4208060 flags:0x00000210 
> [14129.244045] Workqueue: writeback wb_workfn (flush-0:56) 
> [14129.244059] Call trace: 
> [14129.244061]  __switch_to+0x1e0/0x488 (T) 
> [14129.244070]  __schedule+0x748/0x1430 
> [14129.244075]  schedule+0xd0/0x240 
> [14129.244079]  io_schedule+0xb4/0x120 
> [14129.244084]  folio_wait_bit_common+0x2c4/0x708 
> [14129.244089]  __folio_lock+0x24/0x38 
> [14129.244092]  writeback_get_folio+0x37c/0x480 
> [14129.244097]  writeback_iter+0x128/0x6d0 
> [14129.244102]  nfs_writepages+0x504/0x930 [nfs] 
> [14129.244173]  do_writepages+0x204/0x4c0 
> [14129.244176]  __writeback_single_inode+0xec/0x4f8 
> [14129.244180]  writeback_sb_inodes+0x4a4/0xab8 
> [14129.244184]  __writeback_inodes_wb+0x104/0x260 
> [14129.244188]  wb_writeback+0x840/0xce0 
> [14129.244192]  wb_do_writeback+0x69c/0x940 
> [14129.244195]  wb_workfn+0x80/0x1c0 
> [14129.244199]  process_one_work+0x774/0x12d0 
> [14129.244205]  worker_thread+0x434/0xca0 
> [14129.244209]  kthread+0x2ec/0x390 
> [14129.244213]  ret_from_fork+0x10/0x20 
> [14129.244217] Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings 
> [14129.244242] INFO: lockdep is turned off. 
> [-- MARK -- Mon Oct 20 23:40:00 2025] 
> [-- MARK -- Mon Oct 20 23:45:00 2025] 
> [-- MARK -- Mon Oct 20 23:50:00 2025]
> 
> 

