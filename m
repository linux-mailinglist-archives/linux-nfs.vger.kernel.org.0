Return-Path: <linux-nfs+bounces-4785-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DA592DC6D
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 01:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA3D1C21255
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 23:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBFD14D457;
	Wed, 10 Jul 2024 23:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="n+yTLKkc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4998014B95A
	for <linux-nfs@vger.kernel.org>; Wed, 10 Jul 2024 23:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720653153; cv=none; b=FayBHCD1V3UBFC9lY15NIr4Bw0iJhrnM9BwNXVUkxuojXSyba0bLoxQ6aX7htjPWiu4VDYuXV2eTBnZTolowAY5eepK2QmLyVN2sUiQR7oVBS+rTobvPKM1LwW1HCWg6rDFo8pvTwmLM9gW2MIfvWe4v4Prsv01BTF5M18eAmuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720653153; c=relaxed/simple;
	bh=WyD/gWU+mTRRU1vVQwxnO0ndffgZxRx2FiQOEEFZgsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpywFlkh68ql4n0WTyVlVmi4tkYLQYf7PCQ1PsdjrB2LgCL+np7LJ6cNDAlP3bb15pJnkn+4vPhEpTqOHUmMsobDzu8NhivYGK/Sxxo8/DRNlF4yHwM7QvFZcvYe9OR+1btKLRbIzlyrCIi5DF5SYj9H9DsrghgQKQ1tJ0eRuO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=n+yTLKkc; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fa55dbf2e7so1594215ad.2
        for <linux-nfs@vger.kernel.org>; Wed, 10 Jul 2024 16:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1720653151; x=1721257951; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1e6jKnNkF/U+9W9nplpvt/7Wxr+XT1gg9kQWr3d2VBo=;
        b=n+yTLKkcRlgpQHTrf1ooJvWwgmuicWm3mmEEVJ/U2yOsQdoSQOZm7ZPcT6/kPzBhgG
         Q8U1GwnU8XraH7FuLAWqpZMf4EOEQ3KR1Z1C2/29xh/K7yqZNfE03GYOtkXOcDC9en2H
         WW9tIpnNyFVmcWFAvp0Hhr1C555op5D+fMuH9TLBZU4lf1i2EFgjP4xqO783MnNFCKwE
         xCftcGrbkLTJY5dzFpkLztPoec6dYnQznsdDp0x/4tXZ7/XddJAsKmlh6Nl2n2XHMQ4C
         9lLnbU7pBnUmfCRuwKVWpJ9eGsZKOZB8s5oc3SdFj6f97hi6/sE1SQUJOOsiPU0k1iM2
         WtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720653151; x=1721257951;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1e6jKnNkF/U+9W9nplpvt/7Wxr+XT1gg9kQWr3d2VBo=;
        b=ZMMn89X8sGgkxXYazk5p0/2HRtu2ftOa/sug15053abdq2AQWFkHyN5ME3ZJt1brci
         c2aqe21ZULTg02mHe3QJf9qlLMO6Ip8bqz9D4Olo3MHr+UXzieojGyvfS7Ow4vgyRQph
         ztE/fAxVTp3K7tZ5zlcAT1M1uQXYDn7U97ByXB2eLkV9rFnHdJ2LP2kONO7fDzM4vPrO
         8g5CZGOaJul7T2eOo6DvELqy4U3jCkRxtjzub85P4SkIf/p54qFm9Ws8S0LgRbxPM/wr
         I4U6Dxs0lMihSxMyv8YtlHvxRzdy0/om/mHIB1XSDvvn6c0GHGsujs5xCr3RpEmbig5q
         o9+A==
X-Forwarded-Encrypted: i=1; AJvYcCWdzqFwTYfvJXI4Jo5ErSjvWvG9FEvsSIojPqewYOHnX206JGnRVGLwB74dEBuBx1CXbGHCe6pm/Fmwk6huLVuZ//74yAqKTaqW
X-Gm-Message-State: AOJu0YzM6R411s3BETFRK/hNGk0mVsYm2oo5Gq6i1DvNdlZcejeZLvRb
	QghmkgFwnMKvkxs09WA9gdgCYWsHFnnpPyd/RIkTrHGZd5EY7fDJ+Oi7kO21Bd4=
X-Google-Smtp-Source: AGHT+IGsEtZ6tf1ZtHK29vPu0zv/Rq4w7VaWVasOLMHqQiLYpGg4hPlhLvxpMEvYjb3NTg9dK9KA8A==
X-Received: by 2002:a17:903:2444:b0:1fa:128c:4315 with SMTP id d9443c01a7336-1fbb6ea4171mr52844795ad.44.1720653151494;
        Wed, 10 Jul 2024 16:12:31 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a122a1sm39748785ad.45.2024.07.10.16.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 16:12:30 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sRgU8-00BNxd-1v;
	Thu, 11 Jul 2024 09:12:28 +1000
Date: Thu, 11 Jul 2024 09:12:28 +1000
From: Dave Chinner <david@fromorbit.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
	it+linux-raid@molgen.mpg.de
Subject: Re: How to debug intermittent increasing md/inflight but no disk
 activity?
Message-ID: <Zo8VXAy5jTavSIO8@dread.disaster.area>
References: <4a706b9c-5c47-4e51-87fc-9a1c012d89ba@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a706b9c-5c47-4e51-87fc-9a1c012d89ba@molgen.mpg.de>

On Wed, Jul 10, 2024 at 01:46:01PM +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Exporting directories over NFS on a Dell PowerEdge R420 with Linux 5.15.86,
> users noticed intermittent hangs. For example,
> 
>     df /project/something # on an NFS client
> 
> on a different system timed out.
> 
>     @grele:~$ more /proc/mdstat
>     Personalities : [linear] [raid0] [raid1] [raid6] [raid5] [raid4]
> [multipath]
>     md3 : active raid6 sdr[0] sdp[11] sdx[10] sdt[9] sdo[8] sdw[7] sds[6]
> sdm[5] sdu[4] sdq[3] sdn[2] sdv[1]
>           156257474560 blocks super 1.2 level 6, 1024k chunk, algorithm 2
                                                   ^^^^^^^^^^^^

There's the likely source of your problem - 1MB raid chunk size for
a 10+2 RAID6 array. That's a stripe width of 10MB, and that will
only work well with really large sequential streaming IO. However,
the general NFS server IO pattern over time will be small
semi-random IO patterns scattered all over the place. 

IOWs, the average NFS server IO pattern is about the worst case IO
pattern for a massively wide RAID6 stripe....

> In that time, we noticed all 64 NFSD processes being in uninterruptible
> sleep and the I/O requests currently in process increasing for the RAID6
> device *md0*
> 
>     /sys/devices/virtual/block/md0/inflight : 10 921
> 
> but with no disk activity according to iostat. There was only “little NFS
> activity” going on as far as we saw. This alternated for around half an our,
> and then we decreased the NFS processes from 64 to 8.

Has nothing to do with the number of NFSD tasks, I think. They are
all stuck waiting for page cache IO, journal write IO or
the inode locks for the inodes that are blocked on this IO.

The most informative nfsd stack trace is this one:

# # /proc/1414/task/1414: nfsd :
# cat /proc/1414/task/1414/stack

[<0>] submit_bio_wait+0x5b/0x90
[<0>] iomap_read_page_sync+0xaf/0xe0
[<0>] iomap_write_begin+0x3d1/0x5e0
[<0>] iomap_file_buffered_write+0x125/0x250
[<0>] xfs_file_buffered_write+0xc6/0x2d0
[<0>] do_iter_readv_writev+0x14f/0x1b0
[<0>] do_iter_write+0x7b/0x1d0
[<0>] nfsd_vfs_write+0x2f3/0x640 [nfsd]
[<0>] nfsd4_write+0x116/0x210 [nfsd]
[<0>] nfsd4_proc_compound+0x2d1/0x640 [nfsd]
[<0>] nfsd_dispatch+0x150/0x250 [nfsd]
[<0>] svc_process_common+0x440/0x6d0 [sunrpc]
[<0>] svc_process+0xb7/0xf0 [sunrpc]
[<0>] nfsd+0xe8/0x140 [nfsd]
[<0>] kthread+0x124/0x150
[<0>] ret_from_fork+0x1f/0x30

That's a buffered write into the page cache blocking on a read IO
to fill the page because the NFS client is doing subpage or
unaligned IO. So there's slow, IO latency dependent small RMW write
operations happening at the page cache.

IOWs, you've got a NFS client side application performing suboptimal
unaligned IO patterns causing the incoming writes to take the slow
path through the page cache (i.e. a RMW cycle).

When these get flushed from the cache by the nfs commit operation:

# # /proc/1413/task/1413: nfsd :
# cat /proc/1413/task/1413/stack

[<0>] wait_on_page_bit_common+0xfa/0x3b0
[<0>] wait_on_page_writeback+0x2a/0x80
[<0>] __filemap_fdatawait_range+0x81/0xf0
[<0>] file_write_and_wait_range+0xdf/0x100
[<0>] xfs_file_fsync+0x63/0x250
[<0>] nfsd_commit+0xd8/0x180 [nfsd]
[<0>] nfsd4_proc_compound+0x2d1/0x640 [nfsd]
[<0>] nfsd_dispatch+0x150/0x250 [nfsd]
[<0>] svc_process_common+0x440/0x6d0 [sunrpc]
[<0>] svc_process+0xb7/0xf0 [sunrpc]
[<0>] nfsd+0xe8/0x140 [nfsd]
[<0>] kthread+0x124/0x150
[<0>] ret_from_fork+0x1f/0x30

writeback then stalls waiting for the underlying MD device to flush
the small IO to the RAID6 storage. This causes massive write
amplification at the RAID6 level, as it requires a RMW of the RAID6
stripe to recalculate the parity blocks with the new changed data in
it, and that then gets forced to disk because the NFSD is asking for
the data being written to be durable.

This is basically worst case behaviour for small write IO both in
terms of latency and write amplification.

> We captured some more data from sysfs [1].

md0 is the busy device:

# # /proc/855/task/855: md0_raid6 :
# cat /proc/855/task/855/stack

[<0>] blk_mq_get_tag+0x11d/0x2c0
[<0>] __blk_mq_alloc_request+0xe1/0x120
[<0>] blk_mq_submit_bio+0x141/0x530
[<0>] submit_bio_noacct+0x26b/0x2b0
[<0>] ops_run_io+0x7e2/0xcf0
[<0>] handle_stripe+0xacb/0x2100
[<0>] handle_active_stripes.constprop.0+0x3d9/0x580
[<0>] raid5d+0x338/0x5a0
[<0>] md_thread+0xa8/0x160
[<0>] kthread+0x124/0x150
[<0>] ret_from_fork+0x1f/0x30

This is the background stripe cache flushing getting stuck waiting
for tag space on the underlying block devices. This happens because
they have run out of IO queue depth (i.e. are at capacity and
overloaded).

The raid6-md0 slab indicates:

raid6-md0         125564 125564   4640    1    2 : tunables    8    4    0 : slabdata 125564 125564      0

there are 125k stripe head objects active which means there has been
a *lot* of partial stripe writes been done and are active in memory.
The "inflight" IOs indicate that it's bottlenecked on writeback
of dirty cached stripes.

Oh, there's CIFS server on this machine, too, and it's having the
same issues:

# # /proc/7624/task/12539: smbd : /usr/local/samba4/sbin/smbd --configfile=/etc/samba4/smb.conf-grele --daemon
# cat /proc/7624/task/12539/stack

[<0>] md_bitmap_startwrite+0x14a/0x1c0
[<0>] add_stripe_bio+0x3f6/0x6d0
[<0>] raid5_make_request+0x1dd/0xbb0
[<0>] md_handle_request+0x11f/0x1b0
[<0>] md_submit_bio+0x66/0xb0
[<0>] __submit_bio+0x162/0x200
[<0>] submit_bio_noacct+0xa8/0x2b0
[<0>] iomap_do_writepage+0x382/0x800
[<0>] write_cache_pages+0x18f/0x3f0
[<0>] iomap_writepages+0x1c/0x40
[<0>] xfs_vm_writepages+0x71/0xa0
[<0>] do_writepages+0xc0/0x1f0
[<0>] filemap_fdatawrite_wbc+0x78/0xc0
[<0>] file_write_and_wait_range+0x9c/0x100
[<0>] xfs_file_fsync+0x63/0x250
[<0>] __x64_sys_fsync+0x34/0x60
[<0>] do_syscall_64+0x40/0x90
[<0>] entry_SYSCALL_64_after_hwframe+0x61/0xcb

Yup, that looks to be a partial stripe write being started and MD
having to update the dirty bitmap and it's probably blocking because
the dirty bitmap is full. i.e. it is stuck waiting for stripe
writeback to complete and, as per the md0_raid6 stack above, this
is waiting on busy devices to complete IO.

> Of course it’s not reproducible, but any insight how to debug this next time
> is much welcomed.

Probably not a lot you can do short of reconfiguring your RAID6
storage devices to handle small IOs better. However, in general,
RAID6 /always sucks/ for small IOs, and the only way to fix this
problem is to use high performance SSDs to give you a massive excess
of write bandwidth to burn on write amplification....

You could also try to find NFS/CIFS client is doing poor/small IO
patterns and get them to do better IO patterns, but that might not
be fixable.

tl;dr: this isn't a bug in kernel code, this a result of a worst
case workload for a given sotrage configuration.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

