Return-Path: <linux-nfs+bounces-15391-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8013CBEE9F4
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Oct 2025 18:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B58B3AD7A9
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Oct 2025 16:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E96A2EB848;
	Sun, 19 Oct 2025 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNjNVdEC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED3322DF9E
	for <linux-nfs@vger.kernel.org>; Sun, 19 Oct 2025 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760891186; cv=none; b=fEHmXGgkYHYcjDCC+YI8akRthLUpUIpsK0u7xgdJkvttOtyx2OH2Jdo0qLF+iX1/1XBfnfKUmcHYeheE542XqKw1j/lnrQa56Sg40yhaJsiiNzkbEB9ggOdjJ/KuXVj8DJS5w9sE3no9hOXsHNSh13+ajzXdeNDGJMQy6SCruR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760891186; c=relaxed/simple;
	bh=UdoYDRpm5sv37XCzT8Ac/j1w0V++Db4Trrnj6nF71mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmGiolad7/PIXxxS62g+9QtVNOjub23uuag+lLdBZX9jwl7G/UNLBolIp4cw2GCtfzuq0SRyCDinNuwlh4OW42RXeC1r+xkfTZeXrFt7C7kTgWwgCyulB0DDCpZqQCQ6PO9H+iS7im2aOUHTnJ7/rXdJWklfECd40KB+Dttxx6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNjNVdEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2B6C4CEE7;
	Sun, 19 Oct 2025 16:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760891186;
	bh=UdoYDRpm5sv37XCzT8Ac/j1w0V++Db4Trrnj6nF71mI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FNjNVdECM3Y5ve1bVb8BysaHOXRS15KdF/J5oBf7SPu6fOkM8ehkCD6A01SEYgEwE
	 ShZol9Yazn7GIwIPqWVglHFB+FPS1FyZ5snOUDBpmxD2EORLUJb9WS5vrPK5uBxqXx
	 3cK+saZkkc2Eic4eceePX8hAMjACPv6bzbjS26ob4pquWPbomFMlrEeRBiwA0oYmKa
	 5U6Mz7eQXS5Wftmsj01jxXQg+zcg3gyHmcxvj/IQ8S+/jx9yW1xZo0g6enEwiKDN1L
	 BPvxQE8LryJuB4c9tbPZ1hjTqAdaNpMBjPcq80XX97y1bT/DSx8Gtt5vRq+y/qMY42
	 Ss8A8eKCKoG7g==
Date: Sun, 19 Oct 2025 12:26:25 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Yongcheng Yang <yoyang@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [Bug report] xfstests generic/323 over NFS hit BUG: KASAN:
 slab-use-after-free in nfs_local_call_read on 6.18.0-rc1
Message-ID: <aPURMSaH1rXQJkdj@kernel.org>
References: <aPSvi5Yr2lGOh5Jh@dell-per750-06-vm-07.rhts.eng.pek2.redhat.com>
 <ed50690c04699c820873642ea38a01eec53d21af.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed50690c04699c820873642ea38a01eec53d21af.camel@kernel.org>

On Sun, Oct 19, 2025 at 11:18:57AM -0400, Trond Myklebust wrote:
> On Sun, 2025-10-19 at 17:29 +0800, Yongcheng Yang wrote:
> > Hi All,
> > 
> > There is a new nfs slab-use-after-free issue since 6.18.0-rc1.
> > It appears to be reliably reproducible on my side when running
> > xfstests
> > generic/323 over NFSv4.2 in *debug* kernel mode:
> 
> Thanks for the report! I think I see the problem.
> 
> Mike,
> 
> When you iterate over the iocb in nfs_local_call_read(), you're calling
> nfs_local_pgio_done(), nfs_local_read_done() and
> nfs_local_pgio_release() multiple times.

I purposely made nfs_local_pgio_done() safe to call multiple times.

And nfs_local_{read,write}_done() and nfs_local_pgio_release()
_should_ only be called once.

>  * You're calling nfs_local_read_aio_complete() and
>    nfs_local_read_aio_complete_work() once for each and every
>    asynchronous call.

There is only the possibility of a single async call for the single
aligned DIO.

For any given pgio entering LOCALIO, it may be split into 3 pieces:
The misaligned head and tail are first handled sync and only then the
aligned middle async (or possibly sync if underlying device imposes
sync, e.g. ramdisk).

>  * You're calling nfs_local_pgio_done() for each synchronous call.

Yes, which is safe.  It just updates status, deals with partial
completion.

>  * In addition, if there is a synchronous call at the very end of the
>    iteration, so that status != -EIOCBQUEUED, then you're also calling
>    nfs_local_read_done() one extra time, and then calling
>    nfs_local_pgio_release().

It isn't in addition, its only for the last piece of IO (be it sync or
async).

> The same thing appears to be happening in nfs_local_call_write().

I fully acknolwdge this isn't an easy audit.  And there could be
something wrong.  But I'm not seeing it.  Obviously this BUG report
puts onus on me to figure it out...

BUT, I have used this code extensively on non-debug and had no issues.
Is it at all possible KASAN is triggering a false-positive!?

Mike

> > 
> > [18265.311177]
> > ==================================================================
> > [18265.315831] BUG: KASAN: slab-use-after-free in
> > nfs_local_call_read+0x590/0x7f0 [nfs]
> > [18265.320135] Read of size 2 at addr ffff8881090556a2 by task
> > kworker/u9:0/667366
> > 
> > [18265.325454] CPU: 0 UID: 0 PID: 667366 Comm: kworker/u9:0 Not
> > tainted 6.18.0-rc1 #1 PREEMPT(full) 
> > [18265.325461] Hardware name: Red Hat KVM/RHEL, BIOS edk2-20241117-
> > 2.el9 11/17/2024
> > [18265.325465] Workqueue: nfslocaliod nfs_local_call_read [nfs]
> > [18265.325611] Call Trace:
> > [18265.325615]  <TASK>
> > [18265.325619]  dump_stack_lvl+0x77/0xa0
> > [18265.325629]  print_report+0x171/0x820
> > [18265.325637]  ? __virt_addr_valid+0x151/0x3a0
> > [18265.325644]  ? __virt_addr_valid+0x300/0x3a0
> > [18265.325650]  ? nfs_local_call_read+0x590/0x7f0 [nfs]
> > [18265.325770]  kasan_report+0x167/0x1a0
> > [18265.325777]  ? nfs_local_call_read+0x590/0x7f0 [nfs]
> > [18265.325900]  nfs_local_call_read+0x590/0x7f0 [nfs]
> > [18265.326027]  ? process_scheduled_works+0x7d3/0x11d0
> > [18265.326034]  process_scheduled_works+0x857/0x11d0
> > [18265.326050]  worker_thread+0x897/0xd00
> > [18265.326065]  kthread+0x51b/0x650
> > [18265.326071]  ? __pfx_worker_thread+0x10/0x10
> > [18265.326076]  ? __pfx_kthread+0x10/0x10
> > [18265.326082]  ret_from_fork+0x249/0x480
> > [18265.326087]  ? __pfx_kthread+0x10/0x10
> > [18265.326092]  ret_from_fork_asm+0x1a/0x30
> > [18265.326104]  </TASK>
> > 
> > [18265.378345] Allocated by task 681242:
> > [18265.380068]  kasan_save_track+0x3e/0x80
> > [18265.381838]  __kasan_kmalloc+0x93/0xb0
> > [18265.383587]  __kmalloc_cache_noprof+0x3eb/0x6e0
> > [18265.385532]  nfs_local_doio+0x1cb/0xeb0 [nfs]
> > [18265.387630]  nfs_initiate_pgio+0x284/0x400 [nfs]
> > [18265.389815]  nfs_generic_pg_pgios+0x6e2/0x810 [nfs]
> > [18265.391998]  nfs_pageio_complete+0x278/0x750 [nfs]
> > [18265.394146]  nfs_file_direct_read+0x78c/0x9e0 [nfs]
> > [18265.396386]  vfs_read+0x5d0/0x770
> > [18265.398043]  __x64_sys_pread64+0xed/0x160
> > [18265.399837]  do_syscall_64+0xad/0x7d0
> > [18265.401561]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > 
> > [18265.404687] Freed by task 596986:
> > [18265.406245]  kasan_save_track+0x3e/0x80
> > [18265.408013]  __kasan_save_free_info+0x46/0x50
> > [18265.409884]  __kasan_slab_free+0x58/0x80
> > [18265.411613]  kfree+0x1c1/0x620
> > [18265.413075]  nfs_local_read_aio_complete_work+0x86/0x100 [nfs]
> > [18265.415486]  process_scheduled_works+0x857/0x11d0
> > [18265.417437]  worker_thread+0x897/0xd00
> > [18265.419177]  kthread+0x51b/0x650
> > [18265.420689]  ret_from_fork+0x249/0x480
> > [18265.422331]  ret_from_fork_asm+0x1a/0x30
> > 
> > [18265.424989] Last potentially related work creation:
> > [18265.426949]  kasan_save_stack+0x3e/0x60
> > [18265.428639]  kasan_record_aux_stack+0xbd/0xd0
> > [18265.430423]  insert_work+0x2d/0x230
> > [18265.431968]  __queue_work+0x8ec/0xb50
> > [18265.433555]  queue_work_on+0xaf/0xe0
> > [18265.435126]  iomap_dio_bio_end_io+0xb5/0x160
> > [18265.436902]  blk_update_request+0x3d1/0x1000
> > [18265.438699]  blk_mq_end_request+0x3c/0x70
> > [18265.440379]  virtblk_done+0x148/0x250
> > [18265.441973]  vring_interrupt+0x159/0x300
> > [18265.443642]  __handle_irq_event_percpu+0x1c3/0x700
> > [18265.445556]  handle_irq_event+0x8b/0x1c0
> > [18265.447219]  handle_edge_irq+0x1b5/0x760
> > [18265.448881]  __common_interrupt+0xba/0x140
> > [18265.450588]  common_interrupt+0x45/0xa0
> > [18265.452258]  asm_common_interrupt+0x26/0x40
> > 
> > [18265.454941] Second to last potentially related work creation:
> > [18265.457141]  kasan_save_stack+0x3e/0x60
> > [18265.458790]  kasan_record_aux_stack+0xbd/0xd0
> > [18265.460597]  insert_work+0x2d/0x230
> > [18265.462129]  __queue_work+0x8ec/0xb50
> > [18265.463725]  queue_work_on+0xaf/0xe0
> > [18265.465289]  nfs_local_doio+0xa75/0xeb0 [nfs]
> > [18265.467220]  nfs_initiate_pgio+0x284/0x400 [nfs]
> > [18265.469226]  nfs_generic_pg_pgios+0x6e2/0x810 [nfs]
> > [18265.471310]  nfs_pageio_complete+0x278/0x750 [nfs]
> > [18265.473363]  nfs_file_direct_read+0x78c/0x9e0 [nfs]
> > [18265.475432]  vfs_read+0x5d0/0x770
> > [18265.476941]  __x64_sys_pread64+0xed/0x160
> > [18265.478648]  do_syscall_64+0xad/0x7d0
> > [18265.480240]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > 
> > [18265.483211] The buggy address belongs to the object at
> > ffff888109055600
> >                 which belongs to the cache kmalloc-rnd-14-512 of size
> > 512
> > [18265.488048] The buggy address is located 162 bytes inside of
> >                 freed 512-byte region [ffff888109055600,
> > ffff888109055800)
> > 
> > [18265.493827] The buggy address belongs to the physical page:
> > [18265.496033] page: refcount:0 mapcount:0 mapping:0000000000000000
> > index:0xffff888109050e00 pfn:0x109050
> > [18265.499353] head: order:3 mapcount:0 entire_mapcount:0
> > nr_pages_mapped:0 pincount:0
> > [18265.502198] flags:
> > 0x17ffffc0000240(workingset|head|node=0|zone=2|lastcpupid=0x1fffff)
> > [18265.505105] page_type: f5(slab)
> > [18265.506675] raw: 0017ffffc0000240 ffff88810006d540
> > ffffea0004151c10 ffff88810006e088
> > [18265.509537] raw: ffff888109050e00 000000000015000f
> > 00000000f5000000 0000000000000000
> > [18265.512418] head: 0017ffffc0000240 ffff88810006d540
> > ffffea0004151c10 ffff88810006e088
> > [18265.515326] head: ffff888109050e00 000000000015000f
> > 00000000f5000000 0000000000000000
> > [18265.518244] head: 0017ffffc0000003 ffffea0004241401
> > 00000000ffffffff 00000000ffffffff
> > [18265.521168] head: ffffffffffffffff 0000000000000000
> > 00000000ffffffff 0000000000000008
> > [18265.524113] page dumped because: kasan: bad access detected
> > 
> > [18265.527455] Memory state around the buggy address:
> > [18265.529505]  ffff888109055580: fc fc fc fc fc fc fc fc fc fc fc fc
> > fc fc fc fc
> > [18265.532292]  ffff888109055600: fa fb fb fb fb fb fb fb fb fb fb fb
> > fb fb fb fb
> > [18265.535149] >ffff888109055680: fb fb fb fb fb fb fb fb fb fb fb fb
> > fb fb fb fb
> > [18265.537930]                                ^
> > [18265.539899]  ffff888109055700: fb fb fb fb fb fb fb fb fb fb fb fb
> > fb fb fb fb
> > [18265.542713]  ffff888109055780: fb fb fb fb fb fb fb fb fb fb fb fb
> > fb fb fb fb
> > [18265.545507]
> > ==================================================================
> > [18265.554665] Disabling lock debugging due to kernel taint
> > 
> 
> -- 
> Trond Myklebust Linux NFS client maintainer, Hammerspace
> trondmy@kernel.org, trond.myklebust@hammerspace.com

