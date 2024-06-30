Return-Path: <linux-nfs+bounces-4450-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4E791D4CB
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 01:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7891F210F1
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 23:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C045940862;
	Sun, 30 Jun 2024 23:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="H5etN6Cm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055D238F83
	for <linux-nfs@vger.kernel.org>; Sun, 30 Jun 2024 23:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719791203; cv=none; b=Fl4RCGoa6WGwWdHIqaWs5OZSDNeDy8ylPlg/47wlMfHDviqnyfUWvqMlP7sPt8NMjm2uPpvhBlweMnxxF0b1Tvhge7eMquE01y8jy+dNkJSe+2g9w0RXdn6rA4qBDW0XgIP9ToIWdammLMVBCTldT6ojtg8nQNZSF3XeE7KuBLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719791203; c=relaxed/simple;
	bh=uFa3qZD+UxFsW343nUcGj9ThG75aYCoN4WVg+OLm6KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBxPcov2s2ntN3TFbdk8fB0ZWS2TAOhyBTyd6Ns7WgEY/+TY+BV2zwrft8vTK1p9xe2kL7Pi7DsVTnFoxLdwQo3/voZx9A/TKXEluYkYsuZhUAiz2A0vFt8Wlyx6qiWcw2uJN0kYspzPwSusIuQeEWIBWzU4Uo5JRdUshhEpQuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=H5etN6Cm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f9ffd24262so11723795ad.0
        for <linux-nfs@vger.kernel.org>; Sun, 30 Jun 2024 16:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1719791201; x=1720396001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=reQJU41ulBPt7YDuq8gy3UexUN01jSa9o9ncbG8kw30=;
        b=H5etN6CmlVoRixQfGLWZWguAk909v2B7p49Y2Jmixvqoj+O9OJiVarv6GKeAmDgFo6
         XOVugblzk/KuIo7ufUyA5DnxRY4lf2hC7lj+eIaaC2zwI4+OJUu4YzV3xLGUXc06bpAb
         ft99/hdeaVhZ6mKlfebKgweoVVmLtOuqQ8tvAv9QgnJXLchgMdu6caxl33PwS0K5cGMK
         Ww+TjK/89m667byETPceFAkyHLhn5JQ8LZwe0edLoVDTC2n8IzuMEM9Wy2f2+bSSFGBG
         PoK9JW64UW6oigwiVjM+mV5D9Xt8lEWN018lpQQonoaX9dju+NiCo5BmEdPy1qRDnPSQ
         P72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719791201; x=1720396001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reQJU41ulBPt7YDuq8gy3UexUN01jSa9o9ncbG8kw30=;
        b=jIkXFBzjTxCtCLunWn4ZAXCwYqFZYRlKAWjF8R6uNFwSEhdxvCurMpG5I7xjKL34mY
         29R0I315XORQ+HHEk0+3SyFsmXPkoNp16k25ITnYa64Pv2Cgg5jBN7s8j2Qig+hxPGzW
         Mycqh0vimP2ukWN5JyqdLaaZt4AISnBDaFHOXejlCadTf97fIBPOtqpsasyTSU5jE3CY
         iEz58eANEMCBYWG+XgPwKePkWj9/TFfV/dD/gCdd8SHVCncoaoF6dAw6PYbJIDeEmtam
         3r6e/1dFmFlF9TqZz+/Qe9OQJPZUaMPA7vulOMiM3J/aK+nIHqWVyuYbzQbE1LJxm+0M
         ZQ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDtQs7ohysH1V0Mpdr4pvm6+032KC4ZwZJ+G9YGSt2YoDptE/4ItP9S+17uKr1MDJW1y+adSOlqle6jRmM3KfZ47eFznkzWIx5
X-Gm-Message-State: AOJu0YxozG7ScQ2ZH3tZeGorU10WFhQ/CWEMgs0yTdtxpBftyqm8qgWN
	0GDF6w4A6JkYJUHwl5ePdTFnAgAvJ29Uf7aJ/cZbXk3DfubYPVfGMHG+vflT8Mk=
X-Google-Smtp-Source: AGHT+IGjoYmpCv/zLBG38MDTqxDDrkMQt6C79KjF41/PWFSsckdF2nw6eVT2nhda8ZvF/YMsxLjQUQ==
X-Received: by 2002:a17:902:ce8e:b0:1f9:9768:ea88 with SMTP id d9443c01a7336-1fadbcb2001mr18342375ad.38.1719791199973;
        Sun, 30 Jun 2024 16:46:39 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac11d8ae4sm51596165ad.104.2024.06.30.16.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 16:46:39 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sO4Fg-00HIRu-1B;
	Mon, 01 Jul 2024 09:46:36 +1000
Date: Mon, 1 Jul 2024 09:46:36 +1000
From: Dave Chinner <david@fromorbit.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-xfs@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] xfs: enable WQ_MEM_RECLAIM on m_sync_workqueue
Message-ID: <ZoHuXHMEuMrem73H@dread.disaster.area>
References: <Zn7icFF_NxqkoOHR@kernel.org>
 <ZoGJRSe98wZFDK36@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoGJRSe98wZFDK36@kernel.org>

On Sun, Jun 30, 2024 at 12:35:17PM -0400, Mike Snitzer wrote:
> The need for this fix was exposed while developing a new NFS feature
> called "localio" which bypasses the network, if both the client and
> server are on the same host, see:
> https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-6.11
> 
> Because NFS's nfsiod_workqueue enables WQ_MEM_RECLAIM, writeback will
> call into NFS and if localio is enabled the NFS client will call
> directly into xfs_file_write_iter, this causes the following
> backtrace when running xfstest generic/476 against NFS with localio:

Oh, that's nasty.

We now have to change every path in every filesystem that NFS can
call that might defer work to a workqueue.

IOWs, this makes WQ_MEM_RECLAIM pretty much mandatory for front end
workqueues in the filesystem and block layers regardless of whether
the filesystem or block layer path runs under memory reclaim context
or not.

All WQ_MEM_RECLAIM does is create a rescuer thread at workqueue
creation that is used as a "worker of last resort" when forking new
worker threads fail due to ENOMEM. This prevents deadlocks when
doing GFP_KERNEL allocations in workqueue context and potentially
deadlocking because a GFP_KERNEL allocation is blocking waiting for
this workqueue to allocate workers to make progress.

>   workqueue: WQ_MEM_RECLAIM writeback:wb_workfn is flushing !WQ_MEM_RECLAIM xfs-sync/vdc:xfs_flush_inodes_worker
>   WARNING: CPU: 6 PID: 8525 at kernel/workqueue.c:3706 check_flush_dependency+0x2a4/0x328
>   Modules linked in:
>   CPU: 6 PID: 8525 Comm: kworker/u71:5 Not tainted 6.10.0-rc3-ktest-00032-g2b0a133403ab #18502
>   Hardware name: linux,dummy-virt (DT)
>   Workqueue: writeback wb_workfn (flush-0:33)
>   pstate: 400010c5 (nZcv daIF -PAN -UAO -TCO -DIT +SSBS BTYPE=--)
>   pc : check_flush_dependency+0x2a4/0x328
>   lr : check_flush_dependency+0x2a4/0x328
>   sp : ffff0000c5f06bb0
>   x29: ffff0000c5f06bb0 x28: ffff0000c998a908 x27: 1fffe00019331521
>   x26: ffff0000d0620900 x25: ffff0000c5f06ca0 x24: ffff8000828848c0
>   x23: 1fffe00018be0d8e x22: ffff0000c1210000 x21: ffff0000c75fde00
>   x20: ffff800080bfd258 x19: ffff0000cad63400 x18: ffff0000cd3a4810
>   x17: 0000000000000000 x16: 0000000000000000 x15: ffff800080508d98
>   x14: 0000000000000000 x13: 204d49414c434552 x12: 1fffe0001b6eeab2
>   x11: ffff60001b6eeab2 x10: dfff800000000000 x9 : ffff60001b6eeab3
>   x8 : 0000000000000001 x7 : 00009fffe491154e x6 : ffff0000db775593
>   x5 : ffff0000db775590 x4 : ffff0000db775590 x3 : 0000000000000000
>   x2 : 0000000000000027 x1 : ffff600018be0d62 x0 : dfff800000000000
>   Call trace:
>    check_flush_dependency+0x2a4/0x328
>    __flush_work+0x184/0x5c8
>    flush_work+0x18/0x28
>    xfs_flush_inodes+0x68/0x88
>    xfs_file_buffered_write+0x128/0x6f0
>    xfs_file_write_iter+0x358/0x448
>    nfs_local_doio+0x854/0x1568
>    nfs_initiate_pgio+0x214/0x418
>    nfs_generic_pg_pgios+0x304/0x480
>    nfs_pageio_doio+0xe8/0x240
>    nfs_pageio_complete+0x160/0x480
>    nfs_writepages+0x300/0x4f0
>    do_writepages+0x12c/0x4a0
>    __writeback_single_inode+0xd4/0xa68
>    writeback_sb_inodes+0x470/0xcb0
>    __writeback_inodes_wb+0xb0/0x1d0
>    wb_writeback+0x594/0x808
>    wb_workfn+0x5e8/0x9e0
>    process_scheduled_works+0x53c/0xd90

Ah, this is just the standard backing device flusher thread that is
running. This is the back end of filesystem writeback, not the front
end. It was never intended to be able to directly do loop back IO
submission to the front end filesystem IO paths like this - they are
very different contexts and have very different constraints.

This particular situation occurs when XFS is near ENOSPC.  There's a
very high probability it is going to fail these writes, and so it's
doing slow path work that involves blocking and front end filesystem
processing is allowed to block on just about anything in the
filesystem as long as it can guarantee it won't deadlock.

Fundamentally, doing IO submission in WQ_MEM_RECLAIM context changes
the submission context for -all- filesystems, not just XFS.
If we have to make this change to XFS, then -every-
workqueue in XFS (not just this one) must be converted to
WQ_MEM_RECLAIM, and then many workqueues in all the other
filesystems will need to have the same changes made, too.

That doesn't smell right to me.

----

So let's look at how back end filesystem IO currently submits new
front end filesystem IO: the loop block device does this, and it
uses workqueues to defer submitted IO so that the lower IO
submission context can be directly controlled and made with the
front end filesystem IO submission path behaviours.

The loop device does not use rescuer threads - that's not needed
when you have a queue based submission and just use the workqueues
to run the queues until they are empty. So the loop device uses
a standard unbound workqueue for it's IO submission path, and
then when the work is running it sets the task flags to say "this is
a nested IO worker thread" before it starts processing the
submission queue and submitting new front end filesystem IO:

static void loop_process_work(struct loop_worker *worker,
                        struct list_head *cmd_list, struct loop_device *lo)
{
        int orig_flags = current->flags;
        struct loop_cmd *cmd;

        current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;

PF_LOCAL_THROTTLE prevents deadlocks in balance_dirty_pages() by
lifting the dirty ratio for this thread a little, hence giving it
priority over the upper filesystem. i.e. the upper filesystem will
throttle incoming writes first, then the back end IO submission
thread can still submit new front end IOs to the lower filesystem
and they won't block in balance_dirty_pages() because the lower
filesystem has a higher limit. hence the lower filesystem can always
drain the dirty pages on the upper filesystem, and the system won't
deadlock in balance_dirty_pages().

Using WQ_MEM_RECLAIM context for IO submission does not address this
deadlock.

The PF_MEMALLOC_NOIO flag prevents the lower filesystem IO from
causing memory reclaim to re-enter filesystems or IO devices and so
prevents deadlocks from occuring where IO that cleans pages is
waiting on IO to complete.

Using WQ_MEM_RECLAIM context for IO submission does not address this
deadlock either.

IOWs, doing front IO submission like this from the BDI flusher
thread is guaranteed to deadlock sooner or later, regardless of
whether WQ_MEM_RECLAIM is set or not on workqueues that are flushed
during IO submission. The WQ_MEM_RECLAIM warning is effectively your
canary in the coal mine. And the canary just carked it.

IMO, the only sane way to ensure this sort of nested "back-end page
cleaning submits front-end IO filesystem IO" mechanism works is to
do something similar to the loop device. You most definitely don't
want to be doing buffered IO (double caching is almost always bad)
and you want to be doing async direct IO so that the submission
thread is not waiting on completion before the next IO is
submitted.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

