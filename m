Return-Path: <linux-nfs+bounces-15425-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D40BF3F5D
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Oct 2025 00:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD76188E80C
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 22:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F012330B34;
	Mon, 20 Oct 2025 22:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="F7968/TS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8F231BC82
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761000397; cv=none; b=lIPhreaagM3P4M8cCccbUUtzNz6+QU2skzerHOsUrJmAExhleHLCEhgUEFlYMgcUUN3lhqlWMFxJHk/ybSLuLuqKsKWu6YaVThp5bWi/3QcoJEjiQ5hXKeYMMjBxU3xfWhods9MeYxy/o/cwN/tWOV+G/Cf5McDtTojdlgteNOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761000397; c=relaxed/simple;
	bh=tg/WtCVAyCNywj42umEUEmZjcANyQLTq/nfy6UTS1k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOGmllkb+ZpRxvOxHEGxzdYVgeFMiYXAD/ohWHLhO0MOek18mmihnXLqRjgqhKtbtCoXNzyZy6omN8donW0HOkR65itwsUo3lDU/lGJBxY4mvY7nDH4ejAUG4SceTp7G75uE6mQVclidmr6bN6m/mHdv/SweWJ6Rlv7TMZkO1ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=F7968/TS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-290c5dec559so38232395ad.3
        for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 15:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1761000394; x=1761605194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bUtWq6BwnjWVaI8PPEZSZXu56vepaxMGdapsduu3y9o=;
        b=F7968/TSCZ0GGMRJRndd+6JETozjQadJ4ZGoeaAD1kX+j1z/s/zQ1WuDkUQZJSNBKn
         DHT0g/56BH5LrNXmeUsuDbIZQE/4RdxU0eMgTo4yvO6y3y+vukthTBEXAsT9rvjwfFV/
         abkEN5hNiUkRc4wHyPBh80zC60JZTWC0UW1xQZ63m3Hw2UWqp8NJ8oYmBRjWbrL52C3a
         qbKfJ9TFFW9pvraGXvPtSvFHDfI+6cCHhOmajnyX917yptA6c0i5rwshexRcK3cV03ZF
         6DEOqwLmlL5SwZHBucwODinCOhtWjIBBWm0gn6xeFA6z/WMcKzyRPXUWoJv90gFsuLqb
         tRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761000394; x=1761605194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUtWq6BwnjWVaI8PPEZSZXu56vepaxMGdapsduu3y9o=;
        b=PkBv5bsk1CLSVxDsD7uwN6jX6PgYzLiiiLqMW6mv8db/s32PG3sZ5r6Ldz3zVDjoYI
         A5Po9CH4BQQ4Z0kZfweNDsW7qNcY+zLy/JRXXLnWZTfnP2FRsA2tiCA4lFHfMB72+lx+
         Wg9H6AE/Iu3duBwCkaia9tR7t8Rom4uVKXUX2UmUr5W011Jf5QqmyEgKZVmIMT0Qw6c8
         sD8W8hNnhUnFGQ2KO6VkBgAda9gocsP0lPCkz1KXjozFV1+ljxJ+a//2aDanMzFWEErk
         nI83tR0XlngNiTJZ3VOvyDbJZA2eQn8SC4csTnBJldWvLAt0OkK/aa07TmaAJJlLzI2x
         faIA==
X-Forwarded-Encrypted: i=1; AJvYcCX74k8RXNmojy1zCHZ6Ayf7Rw30KAJKjRfSyet+ztld7eIQn8pUl/mWRwX1ZjZfgAYnaHc3Z/VcQOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAlcgf+g9a36lLU+VSR02PCgm2WQvLCI0vQ+DNF3cT6/2cyBgQ
	II5rN1DutQyNBOfSRNta3I17H7ZOSwrxWyFA5wACIsd2DLJ0LMX2oF/h50qtMloJNkg=
X-Gm-Gg: ASbGncuKjaVV3Sej/NrKIY2/2deE67iC2sSnK7PEMvu4puQpMVbZRvMyh4CuPayhLA4
	dgdk4GVkLh/wtJ9HO/vap5mdhtxPiVxDbJFthm6bdoWYBYPYLklbloTn6kUrG4I3W8DI/rqB4bT
	igXZ5x5/7t7M5d1pcZWL4kJHhB0NXeQQcpPP1iQVjFJOlQ115cgscCGxh+GGtrkdYG6tGvKFElV
	f8P3UneqcmfYSJNdhmG/EUcY5ZDxJuBbCzt8u2DFrJFlyPWlvbgiIB/tiZXKtcLxfYJX4juKtQY
	jjyofd0Wdmq1/fQHLHXpr3IInBlFuo1IXpwDBzrchB6VCki/zppqGV+W97PrZsPxUiwgWJCWLx4
	vzGh2vE5WN9lwqLQrlWxik5C5O2wrJ8+m/gHYKkCqGmo1TNNSh6H/FdfkLs8C1QorPi+FWAV2Dh
	Ni4S+Q51NxinoL5lgOq2MRP2qqQrqZ3dL3Qh5yel0qZkn43paWCHI=
X-Google-Smtp-Source: AGHT+IFUIIz9u3gROHoyBrX9GrfKv6A6QBpIppZbYxVF4pPYqH4Q7yX35XtiJX79fRgqZ/TJvN1KGA==
X-Received: by 2002:a17:902:d4c4:b0:25b:f1f3:815f with SMTP id d9443c01a7336-290cb65f80emr187540085ad.58.1761000394302;
        Mon, 20 Oct 2025 15:46:34 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d594esm90846765ad.72.2025.10.20.15.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:46:33 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vAye6-0000000HVzd-2eTg;
	Tue, 21 Oct 2025 09:46:30 +1100
Date: Tue, 21 Oct 2025 09:46:30 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu,
	agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org,
	akpm@linux-foundation.org, willy@infradead.org, mcgrof@kernel.org,
	clm@meta.com, amir73il@gmail.com, axboe@kernel.dk, hch@lst.de,
	ritesh.list@gmail.com, djwong@kernel.org, dave@stgolabs.net,
	wangyufei@vivo.com, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com
Subject: Re: [PATCH v2 00/16] Parallelizing filesystem writeback
Message-ID: <aPa7xozr7YbZX0W4@dread.disaster.area>
References: <CGME20251014120958epcas5p267c3c9f9dbe6ffc53c25755327de89f9@epcas5p2.samsung.com>
 <20251014120845.2361-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014120845.2361-1-kundan.kumar@samsung.com>

On Tue, Oct 14, 2025 at 05:38:29PM +0530, Kundan Kumar wrote:
> Number of writeback contexts
> ============================
> We've implemented two interfaces to manage the number of writeback
> contexts:
> 1) Sysfs Interface: As suggested by Christoph, we've added a sysfs
>    interface to allow users to adjust the number of writeback contexts
>    dynamically.
> 2) Filesystem Superblock Interface: We've also introduced a filesystem
>    superblock interface to retrieve the filesystem-specific number of
>    writeback contexts. For XFS, this count is set equal to the
>    allocation group count. When mounting a filesystem, we automatically
>    increase the number of writeback threads to match this count.

This is dangerous. What happens when we mount a filesystem with
millions of AGs?


> Resolving the Issue with Multiple Writebacks
> ============================================
> For XFS, affining inodes to writeback threads resulted in a decline
> in IOPS for certain devices. The issue was caused by AG lock contention
> in xfs_end_io, where multiple writeback threads competed for the same
> AG lock.
> To address this, we now affine writeback threads to the allocation
> group, resolving the contention issue. In best case allocation happens
> from the same AG where inode metadata resides, avoiding lock contention.

Not necessarily. The allocator can (and will) select different AGs
for an inode as the file grows and the AGs run low on space. Once
they select a different AG for an inode, they don't tend to return
to the original AG because allocation targets are based on
contiguous allocation w.r.t. existing adjacent extents, not the AG
the inode is located in.

Indeed, if a user selects the inode32 mount option, there is
absolutely no relationship between the AG the inode is located in
and the AG it's data extents are allocated in. In these cases,
using the inode resident AG is guaranteed to end up with a random
mix of target AGs for the inodes queued in that AG.  Worse yet,
there may only be one AG that can have inodes allocated in it, so
all the writeback contexts for the other hundreds of AGs in the
filesystem go completely unused...

> Similar IOPS decline was observed with other filesystems under different
> workloads. To avoid similar issues, we have decided to limit
> parallelism to XFS only. Other filesystems can introduce parallelism
> and distribute inodes as per their geometry.

I suspect that the issues with XFS lock contention are related to
the fragmentation behaviour observed (see below) massively
increasing the frequency of allocation work for a given amount of
data being written rather than increasing writeback concurrency...

> 
> IOPS and throughput
> ===================
> With the affinity to allocation group we see significant improvement in
> XFS when we write to multiple files in different directories(AGs).
> 
> Performance gains:
>   A) Workload 12 files each of 1G in 12 directories(AGs) - numjobs = 12
>     - NVMe device BM1743 SSD

So, 80-100k random 4kB write IOPS, ~2GB/s write bandwidth.

>         Base XFS                : 243 MiB/s
>         Parallel Writeback XFS  : 759 MiB/s  (+212%)

As such, the baseline result doesn't feel right - it doesn't match
my experience with concurrent sequential buffered write workloads on
SSDs. My expectation is that they'd get close to device bandwidth or
run out of copy-in CPU at somewhere over 3GB/s.

So what are you actually doing to get these numbers? What is the
benchmark (CLI and conf files details, please!), what is the
mkfs.xfs output, and how many CPUs/RAM do you have on the machines
you are testing?  i.e. please document them sufficiently so that
other people can verify your results.

Also, what is the raw device performance and how close to that are
we getting through the filesystem?

>     - NVMe device PM9A3 SSD

130-180k random 4kB write IOPS, ~4GB/s write bandwidth. So roughly
double the physical throughput of the BM1743, and ....

>         Base XFS                : 368 MiB/s
>         Parallel Writeback XFS  : 1634 MiB/s  (+344%)

.... it gets roughly double the physical throughput of the BM1743.

This doesn't feel like a writeback concurrency limited workload -
this feels more like a device IOPS and IO depth limited workload.

>   B) Workload 6 files each of 20G in 6 directories(AGs)  - numjobs = 6
>     - NVMe device BM1743 SSD
>         Base XFS                : 305 MiB/s
>         Parallel Writeback XFS  : 706 MiB/s  (+131%)
> 
>     - NVMe device PM9A3 SSD
>         Base XFS                : 315 MiB/s
>         Parallel Writeback XFS  : 990 MiB/s  (+214%)
> 
> Filesystem fragmentation
> ========================
> We also see that there is no increase in filesystem fragmentation
> Number of extents per file:

Are these from running the workload on a freshly made (i.e. just run
mkfs.xfs, mount and run benchmark) filesystem, or do you reuse the
same fs for all tests?

>   A) Workload 6 files each 1G in single directory(AG)   - numjobs = 1
>         Base XFS                : 17
>         Parallel Writeback XFS  : 17

Yup, this implies a sequential write workload....

>   B) Workload 12 files each of 1G to 12 directories(AGs)- numjobs = 12
>         Base XFS                : 166593
>         Parallel Writeback XFS  : 161554

which implies 144 files, and so over 1000 extents per file. Which
means about 1MB per extent and is way, way worse than it should be
for sequential write workloads.

> 
>   C) Workload 6 files each of 20G to 6 directories(AGs) - numjobs = 6
>         Base XFS                : 3173716
>         Parallel Writeback XFS  : 3364984

36 files, 720GB and 3.3m extents, which is about 100k extents per
file for an average extent size of 200kB. That would explain why it
performed roughly the same on both devices - they both have similar
random 128kB write IO performance...

But that fragmentation pattern is bad and shouldn't be occurring fro
sequential writes. Speculative EOF preallocation should be almost
entirely preventing this sort of fragmentation for concurrent
sequential write IO and so we should be seeing extent sizes of at
least hundreds of MBs for these file sizes.

i.e. this feels to me like you test is triggering some underlying
delayed allocation defeat mechanism that is causing physical
writeback IO sizes to collapse. This turns what should be a
bandwitdh limited workload running at full device bandwidth into an
IOPS and IO depth limited workload.

In adding writeback concurrency to this situation, it enables
writeback to drive deeper IO queues and so extract more small IO
performance from the device, thereby showing better performance for
the wrokload. The issue is that baseline writeback performance is
way below where I think it should be for the given IO workload (IIUC
the workload being run, hence questions about benchmarks, filesystem
configs and test hardware).

Hence while I certainly agree that writeback concurrency is
definitely needed, I think that the results you are getting here are
a result of some other issue that writeback concurrency is
mitigating. The underlying fragmentation issue needs to be
understood (and probably solved) before we can draw any conclusions
about the performance gains that concurrent writeback actually
provides on these workloads and devices...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

