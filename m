Return-Path: <linux-nfs+bounces-16669-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFBCC7D386
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 16:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1C9F4E01C3
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 15:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C438419258E;
	Sat, 22 Nov 2025 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmYVp4TW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5A9C2EA
	for <linux-nfs@vger.kernel.org>; Sat, 22 Nov 2025 15:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763826733; cv=none; b=Tk1xz1Lc3MYS9aiCoiqfGNUvf/XD9sEDWcX/r1ulvcPTJ+3Dnuku5xfe0f5H4S4RTqPd+QbzIsKrGEUDvrSo0Jx7QYEzLrcVoK3qkvwMoO1BJQTobUcNCCrAVVXHrf0kQ11XHWb44uNsEb7SzIC31gQyQ/wz5RsyztHQp4EzfdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763826733; c=relaxed/simple;
	bh=whGgJUtEqoYd5bixP3n+nSVr7olkmG+RUGCPNxZTgG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zmd+4Dfhjt6rqDdLsAwswKAQg84oLVjzoYGHG1l+L6KTqUM1TOBy0ANZValc7eHnqD0i6wYlFYUotgGRi09yZX123rLXbCEpgVpEgeUaj/RQ410E3chEL1Z4s7lMjfrid+qxPwFB19iZkvssW1140WSgmz6Q29BesILpIO0e6ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmYVp4TW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B7EC4CEF5;
	Sat, 22 Nov 2025 15:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763826732;
	bh=whGgJUtEqoYd5bixP3n+nSVr7olkmG+RUGCPNxZTgG8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CmYVp4TWB7QB0RgSZJagQ8V5Mgiddf7ztZRiSupEeF9YpOT3Jo8UAUZlejIXJKxq7
	 kIXPkUQk3M0z2cog1py/hsOOeUJLomzHl+fGTWYj+5Vo7rOHNNtxURqElx2gONtAFi
	 jzcrieNEtzKK7YVdF0Ky+yTADWlnCu0LlwTgi/vRbYeJDSgdPU2A3jNK4FDr91UF0Y
	 vF9Jh9QNbm0XneEc8WZAcAOyCbceEbh0GlvHjQcIb/lX4hOixcl91oI2goYfqAxYIi
	 n7XdnxL0GwF63GvwWrWoT7Hc9rPt59jxFPLSXZfWmDDvUOyCrcZBHaVYtWMZ8RitTx
	 av1K1mJBeSkAg==
Message-ID: <84dc1fe7-c3ff-4377-9d44-a17d0e4c34a3@kernel.org>
Date: Sat, 22 Nov 2025 10:52:10 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 3/3] NFSD: add
 Documentation/filesystems/nfs/nfsd-io-modes.rst
To: Anton Gavriliuk <antosha20xx@gmail.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Mike Snitzer <snitzer@kernel.org>
References: <20251111145932.23784-1-cel@kernel.org>
 <20251111145932.23784-4-cel@kernel.org>
 <CAAiJnjrE2TOxFvkGiq3g17795nFvA+wFZTddOpu4KiUz2_7i8Q@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <CAAiJnjrE2TOxFvkGiq3g17795nFvA+wFZTddOpu4KiUz2_7i8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Comments on client behavior go to Trond and Anna.


On 11/21/25 4:20 AM, Anton Gavriliuk wrote:
>> +If you experiment with NFSD's IO modes on a recent kernel and have
>> +interesting results, please report them to linux-nfs@vger.kernel.org
> 
> Hello
> 
> There are two physical boxes - NFS server and client, directly
> connected via 4x200 Gb/s ConnectX-7 ports.
> Rocky Linux 10 on both boxes, on NFS server kernel 6.18.0-rc6, on NFS
> client kernel 6.12.0-55.41.1.el10_0.x86_64
> Both boxes have 192 GB DRAM.
> On the NFS server there are 6 x CM7-V 5.0 NVMe SSD in mdadm raid0.
> Thanks to DMA, locally I'm able to read the file 87 GB/s,
> 
> [root@memverge4 ~]# fio --name=local_test --ioengine=libaio --rw=read
> --bs=3072K --numjobs=1 --direct=1 --filename=/mnt/testfile
> --iodepth=32
> local_test: (g=0): rw=read, bs=(R) 3072KiB-3072KiB, (W)
> 3072KiB-3072KiB, (T) 3072KiB-3072KiB, ioengine=libaio, iodepth=32
> fio-3.41-41-gf5b2
> Starting 1 process
> Jobs: 1 (f=1): [R(1)][100.0%][r=81.2GiB/s][r=27.7k IOPS][eta 00m:00s]
> local_test: (groupid=0, jobs=1): err= 0: pid=14009: Fri Nov 21 09:55:00 2025
>   read: IOPS=27.7k, BW=81.1GiB/s (87.1GB/s)(512GiB/6313msec)
>     slat (usec): min=4, max=1006, avg= 6.56, stdev= 5.34
>     clat (usec): min=275, max=4653, avg=1148.62, stdev=32.32
>      lat (usec): min=300, max=5659, avg=1155.19, stdev=33.71
> 
> On the NFS client share mounted with the next options,
> 
> [root@memverge3 ~]# mount -t nfs -o proto=rdma,nconnect=16,vers=3
> 1.1.1.4:/mnt /mnt
> 
> All caches (on server and client) are cleared using "sync; echo 3 >
> /proc/sys/vm/drop_caches".
> On the NFS server /sys/kernel/debug/nfsd/io_cache_read default value 0.
> 
> [root@memverge3 ~]# fio --name=local_test --ioengine=libaio --rw=read
> --bs=3072K --numjobs=1 --direct=1 --filename=/mnt/testfile
> --iodepth=32
> local_test: (g=0): rw=read, bs=(R) 3072KiB-3072KiB, (W)
> 3072KiB-3072KiB, (T) 3072KiB-3072KiB, ioengine=libaio, iodepth=32
> fio-3.41-45-g7c8d
> Starting 1 process
> Jobs: 1 (f=1): [R(1)][100.0%][r=2865MiB/s][r=955 IOPS][eta 00m:00s]
> local_test: (groupid=0, jobs=1): err= 0: pid=141930: Fri Nov 21 10:04:08 2025
>   read: IOPS=1723, BW=5170MiB/s (5421MB/s)(512GiB/101408msec)
>     slat (usec): min=84, max=528, avg=147.91, stdev=29.89
>     clat (usec): min=950, max=116978, avg=18419.36, stdev=11746.45
>      lat (usec): min=1082, max=117116, avg=18567.27, stdev=11729.90
> 
> All caches (on server and client) are cleared using "sync; echo 3 >
> /proc/sys/vm/drop_caches".
> On the NFS server /sys/kernel/debug/nfsd/io_cache_read default value 2.
> 
> [root@memverge3 ~]# fio --name=local_test --ioengine=libaio --rw=read
> --bs=3072K --numjobs=1 --direct=1 --filename=/mnt/testfile
> --iodepth=32
> local_test: (g=0): rw=read, bs=(R) 3072KiB-3072KiB, (W)
> 3072KiB-3072KiB, (T) 3072KiB-3072KiB, ioengine=libaio, iodepth=32
> fio-3.41-45-g7c8d
> Starting 1 process
> Jobs: 1 (f=1): [R(1)][100.0%][r=16.9GiB/s][r=5770 IOPS][eta 00m:00s]
> local_test: (groupid=0, jobs=1): err= 0: pid=142151: Fri Nov 21 10:07:36 2025
>   read: IOPS=5803, BW=17.0GiB/s (18.3GB/s)(512GiB/30111msec)
>     slat (usec): min=58, max=468, avg=171.72, stdev=15.26
>     clat (usec): min=264, max=9284, avg=5340.71, stdev=141.85
>      lat (usec): min=455, max=9748, avg=5512.42, stdev=145.54
> 
> 3+x times improvement!!
> 
> Now let's take a look at NFS client side, why can't I exceed 20 GB/s ?
> 
> It looks that the fio thread most of time spends on the cpu executing
> next kernel functions,
> 
>     HARDCLOCK entries
>        Count     Pct  State  Function
>          384  38.40%  SYS    nfs_page_create_from_page
>          142  14.20%  SYS    nfs_get_lock_context
>          109  10.90%  SYS    __nfs_pageio_add_request
>           70   7.00%  SYS    refcount_dec_and_lock
>           64   6.40%  SYS    nfs_page_create
>           58   5.80%  SYS    nfs_direct_read_schedule_iovec
>           39   3.90%  SYS    nfs_pageio_add_request
>           38   3.80%  SYS    kmem_cache_alloc_noprof
>           13   1.30%  SYS    rpc_execute
>           12   1.20%  SYS    nfs_generic_pg_pgios
>           10   1.00%  SYS    get_partial_node.part.0
>           10   1.00%  SYS    rmqueue_bulk
>           10   1.00%  SYS    nfs_generic_pgio
>            8   0.80%  SYS    gup_fast_fallback
>            6   0.60%  SYS    xprt_iter_next_entry_roundrobin
>            4   0.40%  SYS    allocate_slab
>            4   0.40%  SYS    nfs_file_direct_read
>            3   0.30%  SYS    rpc_task_set_transport
>            2   0.20%  SYS    __get_random_u32_below
>            2   0.20%  SYS    nfs_pgheader_init
> 
>        Count     Pct  HARDCLOCK Stack trace
>        ============================================================
>          384  38.40%  nfs_page_create_from_page
> nfs_direct_read_schedule_iovec  nfs_file_direct_read  aio_read
> io_submit_one  __x64_sys_io_submit  do_syscall_64
> entry_SYSCALL_64_after_hwframe  |  syscall
>          141  14.10%  nfs_get_lock_context  nfs_page_create_from_page
> nfs_direct_read_schedule_iovec  nfs_file_direct_read  aio_read
> io_submit_one  __x64_sys_io_submit  do_syscall_64
> entry_SYSCALL_64_after_hwframe  |  syscall
>          109  10.90%  __nfs_pageio_add_request  nfs_pageio_add_request
>  nfs_direct_read_schedule_iovec  nfs_file_direct_read  aio_read
> io_submit_one  __x64_sys_io_submit  do_syscall_64
> entry_SYSCALL_64_after_hwframe  |  syscall
>           70   7.00%  refcount_dec_and_lock  nfs_put_lock_context
> nfs_page_create_from_page  nfs_direct_read_schedule_iovec
> nfs_file_direct_read  aio_read io_submit_one  __x64_sys_io_submit
> do_syscall_64  entry_SYSCALL_64_after_hwframe  |  syscall
>           64   6.40%  nfs_page_create  nfs_page_create_from_page
> nfs_direct_read_schedule_iovec  nfs_file_direct_read  aio_read
> io_submit_one  __x64_sys_io_submit  do_syscall_64
> entry_SYSCALL_64_after_hwframe  |  syscall
>           58   5.80%  nfs_direct_read_schedule_iovec
> nfs_file_direct_read  aio_read  io_submit_one  __x64_sys_io_submit
> do_syscall_64  entry_SYSCALL_64_after_hwframe  |  syscall
>           39   3.90%  nfs_pageio_add_request
> nfs_direct_read_schedule_iovec  nfs_file_direct_read  aio_read
> io_submit_one  __x64_sys_io_submit  do_syscall_64
> entry_SYSCALL_64_after_hwframe  |  syscall
>           36   3.60%  kmem_cache_alloc_noprof  nfs_page_create
> nfs_page_create_from_page  nfs_direct_read_schedule_iovec
> nfs_file_direct_read  aio_read  io_submit_one  __x64_sys_io_submit
> do_syscall_64  entry_SYSCALL_64_after_hwframe  |  syscall
> 
> Even if I created and added 2M huge pages as fio's backing page size
> (adding --mem=mmaphuge --hugepage-size=2m), there is still
> distribution as shown above.
> 
> I might be wrong, but even with fio's huge pages, the standard
> upstream NFS client creates a struct nfs_page for every 4K chunk
> (page_size), regardless of the backing page size.
> 
> Could 2M huge pages be implemented for NFS client ??, it would even
> more improve performance using NFSD direct reads.
> 
> Anton
> 
> вт, 11 нояб. 2025 г. в 17:09, Chuck Lever <cel@kernel.org>:
>>
>> From: Mike Snitzer <snitzer@kernel.org>
>>
>> This document details the NFSD IO modes that are configurable using
>> NFSD's experimental debugfs interfaces:
>>
>>   /sys/kernel/debug/nfsd/io_cache_read
>>   /sys/kernel/debug/nfsd/io_cache_write
>>
>> This document will evolve as NFSD's interfaces do (e.g. if/when NFSD's
>> debugfs interfaces are replaced with per-export controls).
>>
>> Future updates will provide more specific guidance and howto
>> information to help others use and evaluate NFSD's IO modes:
>> BUFFERED, DONTCACHE and DIRECT.
>>
>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  .../filesystems/nfs/nfsd-io-modes.rst         | 144 ++++++++++++++++++
>>  1 file changed, 144 insertions(+)
>>  create mode 100644 Documentation/filesystems/nfs/nfsd-io-modes.rst
>>
>> diff --git a/Documentation/filesystems/nfs/nfsd-io-modes.rst b/Documentation/filesystems/nfs/nfsd-io-modes.rst
>> new file mode 100644
>> index 000000000000..e3a522d09766
>> --- /dev/null
>> +++ b/Documentation/filesystems/nfs/nfsd-io-modes.rst
>> @@ -0,0 +1,144 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=============
>> +NFSD IO MODES
>> +=============
>> +
>> +Overview
>> +========
>> +
>> +NFSD has historically always used buffered IO when servicing READ and
>> +WRITE operations. BUFFERED is NFSD's default IO mode, but it is possible
>> +to override that default to use either DONTCACHE or DIRECT IO modes.
>> +
>> +Experimental NFSD debugfs interfaces are available to allow the NFSD IO
>> +mode used for READ and WRITE to be configured independently. See both:
>> +- /sys/kernel/debug/nfsd/io_cache_read
>> +- /sys/kernel/debug/nfsd/io_cache_write
>> +
>> +The default value for both io_cache_read and io_cache_write reflects
>> +NFSD's default IO mode (which is NFSD_IO_BUFFERED=0).
>> +
>> +Based on the configured settings, NFSD's IO will either be:
>> +- cached using page cache (NFSD_IO_BUFFERED=0)
>> +- cached but removed from page cache on completion (NFSD_IO_DONTCACHE=1)
>> +- not cached stable_how=NFS_UNSTABLE (NFSD_IO_DIRECT=2)
>> +
>> +To set an NFSD IO mode, write a supported value (0 - 2) to the
>> +corresponding IO operation's debugfs interface, e.g.:
>> +  echo 2 > /sys/kernel/debug/nfsd/io_cache_read
>> +  echo 2 > /sys/kernel/debug/nfsd/io_cache_write
>> +
>> +To check which IO mode NFSD is using for READ or WRITE, simply read the
>> +corresponding IO operation's debugfs interface, e.g.:
>> +  cat /sys/kernel/debug/nfsd/io_cache_read
>> +  cat /sys/kernel/debug/nfsd/io_cache_write
>> +
>> +If you experiment with NFSD's IO modes on a recent kernel and have
>> +interesting results, please report them to linux-nfs@vger.kernel.org
>> +
>> +NFSD DONTCACHE
>> +==============
>> +
>> +DONTCACHE offers a hybrid approach to servicing IO that aims to offer
>> +the benefits of using DIRECT IO without any of the strict alignment
>> +requirements that DIRECT IO imposes. To achieve this buffered IO is used
>> +but the IO is flagged to "drop behind" (meaning associated pages are
>> +dropped from the page cache) when IO completes.
>> +
>> +DONTCACHE aims to avoid what has proven to be a fairly significant
>> +limition of Linux's memory management subsystem if/when large amounts of
>> +data is infrequently accessed (e.g. read once _or_ written once but not
>> +read until much later). Such use-cases are particularly problematic
>> +because the page cache will eventually become a bottleneck to servicing
>> +new IO requests.
>> +
>> +For more context on DONTCACHE, please see these Linux commit headers:
>> +- Overview:  9ad6344568cc3 ("mm/filemap: change filemap_create_folio()
>> +  to take a struct kiocb")
>> +- for READ:  8026e49bff9b1 ("mm/filemap: add read support for
>> +  RWF_DONTCACHE")
>> +- for WRITE: 974c5e6139db3 ("xfs: flag as supporting FOP_DONTCACHE")
>> +
>> +NFSD_IO_DONTCACHE will fall back to NFSD_IO_BUFFERED if the underlying
>> +filesystem doesn't indicate support by setting FOP_DONTCACHE.
>> +
>> +NFSD DIRECT
>> +===========
>> +
>> +DIRECT IO doesn't make use of the page cache, as such it is able to
>> +avoid the Linux memory management's page reclaim scalability problems
>> +without resorting to the hybrid use of page cache that DONTCACHE does.
>> +
>> +Some workloads benefit from NFSD avoiding the page cache, particularly
>> +those with a working set that is significantly larger than available
>> +system memory. The pathological worst-case workload that NFSD DIRECT has
>> +proven to help most is: NFS client issuing large sequential IO to a file
>> +that is 2-3 times larger than the NFS server's available system memory.
>> +The reason for such improvement is NFSD DIRECT eliminates a lot of work
>> +that the memory management subsystem would otherwise be required to
>> +perform (e.g. page allocation, dirty writeback, page reclaim). When
>> +using NFSD DIRECT, kswapd and kcompactd are no longer commanding CPU
>> +time trying to find adequate free pages so that forward IO progress can
>> +be made.
>> +
>> +The performance win associated with using NFSD DIRECT was previously
>> +discussed on linux-nfs, see:
>> +https://lore.kernel.org/linux-nfs/aEslwqa9iMeZjjlV@kernel.org/
>> +But in summary:
>> +- NFSD DIRECT can significantly reduce memory requirements
>> +- NFSD DIRECT can reduce CPU load by avoiding costly page reclaim work
>> +- NFSD DIRECT can offer more deterministic IO performance
>> +
>> +As always, your mileage may vary and so it is important to carefully
>> +consider if/when it is beneficial to make use of NFSD DIRECT. When
>> +assessing comparative performance of your workload please be sure to log
>> +relevant performance metrics during testing (e.g. memory usage, cpu
>> +usage, IO performance). Using perf to collect perf data that may be used
>> +to generate a "flamegraph" for work Linux must perform on behalf of your
>> +test is a really meaningful way to compare the relative health of the
>> +system and how switching NFSD's IO mode changes what is observed.
>> +
>> +If NFSD_IO_DIRECT is specified by writing 2 (or 3 and 4 for WRITE) to
>> +NFSD's debugfs interfaces, ideally the IO will be aligned relative to
>> +the underlying block device's logical_block_size. Also the memory buffer
>> +used to store the READ or WRITE payload must be aligned relative to the
>> +underlying block device's dma_alignment.
>> +
>> +But NFSD DIRECT does handle misaligned IO in terms of O_DIRECT as best
>> +it can:
>> +
>> +Misaligned READ:
>> +    If NFSD_IO_DIRECT is used, expand any misaligned READ to the next
>> +    DIO-aligned block (on either end of the READ). The expanded READ is
>> +    verified to have proper offset/len (logical_block_size) and
>> +    dma_alignment checking.
>> +
>> +Misaligned WRITE:
>> +    If NFSD_IO_DIRECT is used, split any misaligned WRITE into a start,
>> +    middle and end as needed. The large middle segment is DIO-aligned
>> +    and the start and/or end are misaligned. Buffered IO is used for the
>> +    misaligned segments and O_DIRECT is used for the middle DIO-aligned
>> +    segment. DONTCACHE buffered IO is _not_ used for the misaligned
>> +    segments because using normal buffered IO offers significant RMW
>> +    performance benefit when handling streaming misaligned WRITEs.
>> +
>> +Tracing:
>> +    The nfsd_read_direct trace event shows how NFSD expands any
>> +    misaligned READ to the next DIO-aligned block (on either end of the
>> +    original READ, as needed).
>> +
>> +    This combination of trace events is useful for READs:
>> +    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_vector/enable
>> +    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_direct/enable
>> +    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_io_done/enable
>> +    echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_read/enable
>> +
>> +    The nfsd_write_direct trace event shows how NFSD splits a given
>> +    misaligned WRITE into a DIO-aligned middle segment.
>> +
>> +    This combination of trace events is useful for WRITEs:
>> +    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_opened/enable
>> +    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_direct/enable
>> +    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_io_done/enable
>> +    echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_write/enable
>> --
>> 2.51.0
>>
>>


-- 
Chuck Lever

