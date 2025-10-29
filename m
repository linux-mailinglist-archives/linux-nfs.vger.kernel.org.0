Return-Path: <linux-nfs+bounces-15761-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6718FC1C4ED
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Oct 2025 17:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20C944E6CBB
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Oct 2025 16:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2D62F2914;
	Wed, 29 Oct 2025 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoumXnbu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BBE2F5331
	for <linux-nfs@vger.kernel.org>; Wed, 29 Oct 2025 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756890; cv=none; b=NgnFQbs0PwvKSNHxovjX3/15R1+TRhXsVVj18l8eILEogGQPQLBMp83hOgKrAV9GxKxUuJtkJIJf2yZ6SUzwFBewZpEELFdJMxjOefze/MvEu/86S96O47+idip4pt6d2sRxNLxhzEEvDF7vrtUR/1Xvnsn5ll/Y6U/RJS2jucE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756890; c=relaxed/simple;
	bh=nCzGoCnH4X5j8+wPtsQmjIJ8vZskC+7ba6+Q3uxB0xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUin8CV8oJETAeYYJIvJAF/Etxyw6Xm9fA9blcs2YysKoX0V9uxySlr0ETJ3DPGd76SIWHo0aRlCET1xXvCGWwuWxnT3BA9beEYpe68hjeyDDcmZzPxD+Expt22ulK07sAdBO4rtkPl0LdDPRWhuqMW1VVHr3MPmp/8q0AW8f70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoumXnbu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922C8C4CEF7;
	Wed, 29 Oct 2025 16:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761756889;
	bh=nCzGoCnH4X5j8+wPtsQmjIJ8vZskC+7ba6+Q3uxB0xQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RoumXnbue0yDd33SHwykri4Uy4ULdf98bQPxSGsBJxsHTizVVOsrhlsHTLR0E4TDh
	 9HUT6DUtGsuoDzonN2MTj7VlsPaBcIOtTM/aB2izvE+NxiZcqnKkt4roSHodW+EUzx
	 +2bRtwFi6eZZTCzf9CKl8Znc00cCI5j7jr2l4EWvzYnUF0T2yX78LEsknqpWHcUD7o
	 4dzyjp3lWyqlhDiro8MdF0vT6Ig4BTpKqwjW99iwxcNaAmiNye1OP9DvPY1BoPeLlq
	 CBcqQjEAZA8crcUy4Cl/k4mBaCxdhd4oU9nkIAnAFZcVtGBXWCYUeN8Apq9/yHRkCu
	 mC81hWKciFMHA==
Date: Wed, 29 Oct 2025 12:54:48 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>, jonathan.flynn@hammerspace.com,
	trondmy@hammerspace.com
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
Message-ID: <aQJG2LIuui08Bx3H@kernel.org>
References: <aP8qPlA7BEN3nlN8@infradead.org>
 <5a2e4884bb6b31b0443bdac6174c77f7273e92b1.camel@kernel.org>
 <aP-YV2i8Y9jsrPF9@kernel.org>
 <a221755a-0868-477d-b978-d2c045011977@kernel.org>
 <aQA4AkzjlDybKzCR@kernel.org>
 <1f7b30d2-f806-400f-81d3-80b6c924c410@kernel.org>
 <aQDpjNnj47ISRItg@kernel.org>
 <b63ed4d4-8bbb-4794-ae07-64a4000e0ea9@kernel.org>
 <aQFYLKmC2Nr1QUrM@kernel.org>
 <872ec54f-bcb8-4e66-9c2b-d91f1be0f82f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <872ec54f-bcb8-4e66-9c2b-d91f1be0f82f@kernel.org>

On Wed, Oct 29, 2025 at 11:22:13AM -0400, Chuck Lever wrote:
> On 10/28/25 7:56 PM, Mike Snitzer wrote:
> > On Tue, Oct 28, 2025 at 02:48:33PM -0400, Chuck Lever wrote:
> >> On 10/28/25 12:04 PM, Mike Snitzer wrote:
> >>> I'm also concerned about initiating
> >>> any page cache invalidation off the back of the DIO WRITE in the
> >>> middle (and its potential to fallback to buffered if that invalidation
> >>> fails... any associated buffered IO fallback or ends best have O_DSYNC
> >>> set it ensure everything ondisk).
> >>
> >> My questions:
> > 
> > All good questions, and I appreciate the time you spent analyzing
> > these aspects.
> > 
> > I'm all for NFSD's IO modes being able to work with all possible
> > stable_how.  Your analysis helps expand the scope of these IO modes to
> > really be pushed to their limits (specifically thinking of
> > NFSD_IO_DIRECT being paired with UNSTABLE and it _not_ using
> > IOCB_DSYNC, interesting combo but IMO quite a risky default given
> > we're only at the debugfs interface stage for NFSD_IO_DIRECT).
> >  
> >> A. Which filesystem code can return -ENOTBLK?
> >>
> >> - iomap-based DIO (fs/iomap/direct-io.c:715): XFS, ext4, f2fs, gfs2,
> >>   zonefs, erofs
> >> - Legacy DIO path (fs/direct-io.c:984): ext2, some ext4 code paths
> >> - btrfs (has its own DIO implementation that uses -ENOTBLK)
> >>
> >> Code auditing shows that vfs_iocb_iter_write() never returns -ENOTBLK
> >> because all filesystems that could generate this error internally
> >> convert it to 0 or another error code before returning from their
> >> write_iter implementation.
> >>
> >> Therefore NFSD itself does not need to know about or handle page cache
> >> invalidation failure.
> > 
> > OK, good to hear; but have you reviewed if they are all using D_SYNC
> > as part of their internal handling of their buffered fallback?  NFSD
> > setting DSYNC just acknowledges it is required to ensure O_DIRECT
> > WRITEs are ondisk upon return to client -- something I don't want to
> > leave to the client to ensure via NFS_UNSTABLE's subsequent COMMIT.
> 
> As Christoph said, the application runs on the client, and it tells
> the client exactly what needs to happen. Then the client tells the
> server.
> 
> Essentially what forcing all writes to be slow durable writes does
> is makes a special case a little faster (maybe, that has yet to be
> demonstrated) at the expense of all other use cases that prefer to
> write a lot and then commit.
> 
> And if I understand Jonathan's numbers correctly, this only truly
> matters when the server's memory has been exhausted. The usual Linux
> paradigm is to let workloads whose resident sets fit in memory go
> just as fast as can be allowed. We need the additional durability
> only when the server is tipping over.
> 
> The server could flush more aggressively when it recognizes it cannot
> hold its working set in memory. But I think the issue there is that the
> server is tipping over because it simply cannot flush fast enough to
> keep up with clients.

Yes, network faster than storage.  Clients that can basically fill the
NFS server's page cache within seconds.

Trond has pretty solid concerns about requiring the client to take
control of ensuring the NFSD server is able to make forward progress.

The NFSD writeback and associated page reclaim hangs/stalls due to
NFSD_IO_BUFFERED are quite bad if/when they hit (due to low memory,
kswapd and kcompactd working too hard, etc).

NFSD_IO_DIRECT is doing an amazing job of mitigating those MM issues.

> I'd like someone to have a look at slowing down noisy clients when the
> server starts to reach its limits. At least NFSD should get some
> observability mechanisms to tell which clients are the troublesome ones.

Yes, having NFSD be able to communicate congestion or "pressure" to
the client to backoff would be interesting (PSI is very applicable
here, we could tie it to PSI data and trigger at configurable
thresholds).

Given that NFSD is a shared resource, with N threads.. distilling the
system's PSI data down to a per client basis is likely only doable if
each NFSD thread were to have their own cgroup? :(

But even then it is messy to wrangle that data as the basis for
per-client PSI data. But worth considering as one way forward.

> > Setting O_DSYNC gives us a baseline where we don't leave some other
> > subsystem to ensure data gets to disk as quickly as possible (O_DSYNC
> > offers NFS_DATA_SYNC, but O_DSYNC|SYNC's NFS_FILE_SYNC offers a win by
> > avoiding COMMIT, even more enticing).
> > 
> > So I need NFSD_IO_DIRECT to be able to require IOCB_DSYNC and possibly
> > IOCB_DSYNC|IOCB_SYNC.  And I'm most comfortable with the misaligned
> > DIO WRITE support using O_DSYNC for all 3 segments; so that WRITE's
> > data is ondisk before returning from the WRITE (NFS_DATA_SYNC), and
> > bonus if we can avoid extra COMMIT (NFS_FILE_SYNC).
> 
> This flies in the face of what the protocol mandates and what
> applications have come to expect over the past 30 years.

Not looking to fly in the face of anything, like you've reminded me
relative to the current NFSD_IO_DIRECT code: nothing is written in
stone, etc.

My real "need" is to expose knobs that allow discovery of best
performance with NFSD given all options at our fingertips (obviously
NFSD_IO_DIRECT is the most promising so far).  But this _is_ all
"early days" in the grand scheme of things. Understanding what works
best for workload+config X, Y and Z. Discovery phase, iterative
testing/learning/feedback to inform inplementation and minimal
required knobs to allow progress.

> The server is free to promote WRITE to higher durability, but that
> /always/ comes at a cost. That cost is worth it, I can see, only when
> the server cannot cache an UNSTABLE WRITE.
> 
> I suspect your true mission is to turn NFS into Lustre. ;-)

Lustre's "N writers to 1 file" (or "many-writers to 1 file") is
definitely a use case that is desirable to support.

> >> B. Even if NFSD had to recover from a failed page cache invalidation,
> >>    does a fallback write need to set IOCB_DSYNC (not considering the NFS
> >>    protocol requirements) ?
> >>
> >> When invalidation fails, some pages remain in the cache (dirty or with
> >> private data). The buffered fallback writes to those same pages,
> >> updating them with the correct data. There's no torn state or corruption
> >> hazard.
> >>
> >> The fallback restarts the entire write from scratch, as buffered. Any
> >> partial progress (like a buffered first segment) gets rewritten with
> >> the same data. No orphaned blocks or inconsistent state.
> >>
> >> If another process does a DIO read of this region, it will call
> >> kiocb_write_and_wait() first (see mm/filemap.c:2912), which flushes any
> >> dirty pages before reading. So they'll see correct data even if it's
> >> still dirty in cache (Jeff's concern).
> > 
> > Yes, but the point is there is extra work that involves the page
> > cache by other layers.  And O_DIRECT is intended to work expecting the
> > IO has been flushed to disk. O_DIRECT is aiming to reduce page cache> usage, to keep memory use low.  So ensuring the page cache invalidated
> > to disk by the subsequent write as a side-efffect of O_DSYNC helps
> > (more on this below [0]).
> 
> Go look at what happens after an IOCB_DIRECT write returns to its
> caller. The write buffer goes away almost immediately and there's
> nothing left in memory.

But there would be if IOCB_DIRECT IO is delayed (as would be the case
with NFS_UNSTABLE), right?

> The unaligned ends go through the page cache, but IOCB_DONTCACHE is set
> on those, so those pages are immediately evictable.

That brings up a new thread of development that I have a patch for,
streaming misaligned IO, as I mentioned I was looking at again here:
https://lore.kernel.org/linux-nfs/aP-YV2i8Y9jsrPF9@kernel.org/

I revisited this workload (last optimized/touched it ~6 months ago for
ISC2025) because it is time for the every 6 months industry bakeoff
that is IO500.  IO500's nastiest test is IOR_HARD (streaming WRITEs IO
of 47008 bytes each).

DONTCACHE is actively harmful for misaligned WRITEs due to it
immediately dropping pages from the page cache.  The pages associated
with the misaligned head/tail are best servived with traditional
NFSD_IO_BUFFERED.  Using BUFFERED instead of DONTCACHE offers a HUGE
performance improvement.

I did also reinstate my old NFSD_IO_DIRECT change to "use buffered IO
if WRITE is less than 32K".

Changed 2 things at once and got fantastic performance.  Need to
decouple and retest without the latter before I post patches that
build on your latest code.

> >> C. When setting up a three-segment write, is IOCB_DSYNC needed on the
> >>    unaligned ends (not considering the NFS protocol requirements) ?
> >>
> >> Before writing the DIO middle segment, the VFS must first invalidate the
> >> page cache, so the first (buffered) segment is flushed to durability
> >> anyway. The use of IOCB_DSYNC for the first segment is superfluous.
> > 
> > No, the first segment reflects the misaligned head of the WRITE. The
> > DIO-aligned middle segment's DIO will just invalidate pages aligned on
> > the middle segment's alignment (which is page aligned).  So the DIO
> > from the middle segment won't have any side-effect on the first
> > segment's page.  First page needs to be written out with IOCB_DSYNC.
> 
> You still haven't demonstrated why. What is the risk of not making
> the first segment durable? I don't find the arguments about a little
> extra memory usage at all convincing, especially if DONTCACHE is in
> play.

DONTCACHE isn't in play for me at the moment.  I didn't push back when
you introduced DIRECT to BUFFERED fallback in terms of DONTCACHE but
it really is a problem.

Anyway, that aside: I just want to make sure the misaligned DIO case
is safe.  Jeff and you spooked me about your concerns, etc (and it was
Christoph who quite early mentioned that mixing buffered and direct is
risky due to invalidation races).  So maybe I'm conditioned to just be
excessive about ensuring the page cache usage doesn't cause
invalidation races and such.

This rope-a-dope is kind of interesting, flipping it such that there
is no concern now is quite the 180 switch.  But I went all in on
trying to ensure misaligned DIO in terms of 3 segments that mix
buffered and direct _safe_.  That safety comes at the cost of SYNC IO.
But sure, maybe it was all paramoid theatre and isn't needed...

> So, have we decided that there is no data integrity risk with leaving
> off IOCB_DSYNC for the burnt ends? The only purpose now is a potential
> performance optimization?

I think yes, IOCB_DIRECT with NFS_UNSTABLE will work with the COMMIT
that follows.  And having the ability to tune to raise the stable_how
used like I suggested in my previous email will allow us to fully
explore relative differences.

> >> After writing the DIO middle segment, the unaligned end remains only in
> >> the page cache if IOCB_DSYNC is not used. But a subsequent DIO read will
> >> flush that to durability (via kiocb_write_and_wait) before satisfying
> >> the read. So, IOCB_DSYNC is not needed there to meet putative file data
> >> visibility mandates.
> > 
> > The same applies to both the misaligned first (head) and third (tail)
> > segments, they both need O_DSYNC to ensure their contents are ondisk.
> 
> A direct READ will write back any cached pages in the read byte range
> before it reads from the media. Full stop. There is no need for NFSD
> to add IOCB_DSYNC for reads to get the latest data.

That seems like a non-sequitor.. but OK (I can now see you're focused
on the READ aspect).

I was just pointing out that the misaligned head and tail are
identical in terms of them not being page aligned and needing to be
written to disk.

> > [0]: Again, my goal for NFSD_IO_DIRECT is to operate in terms of
> > O_DIRECT|O_DSYNC ondisk.. and not lean on the page cache more than
> > needed. This makes the VM subsystem more scalable as a side-effect of
> > it having more clean pages that are quickly dropped and/or reused if
> > something needs memory.
> 
> That's a giant claim, and it needs a lot of clear evidence to back it
> up. I think when you have code we can review, we can begin to discuss
> it further. For now, let's focus on the code to be merged now.

OK, but I've provided all the evidence in conjunction with Jonathan
Flynn's testing to scale the testing out.  So we have the data for
DSYNC+SYNC usage (first with NFS_UNSTABLE and later with NFSD server
responding NFS_FILE_SYNC to client), we can relax it to not use DSYNC
(or DSYNC+SYNC) at all and use NFS_UNSTABLE and see how it goes.

> > Anyway, I've been working to ensure NFSD_IO_DIRECT acts as if at least
> > NFS_DATA_SYNC, but preferably NFS_FILE_SYNC, set.
> 
> Clearly, but the rationale for this effort needs some work. It doesn't
> reflect the mandates of the NFS protocol and I haven't seen a use case
> for it.

Fair, thanks for helping hone the justification and keeping me honest.

> > I should have more  
> > clearly stated that.  Bypassing all caches as much possible allows for
> > enabling scalable cache coherence, e.g. intelligent applications that
> > don't rely on file locking, think multiple writers writing to their
> > own extent of a large file.
> 
> At the expense of applications that do not need or want that extra
> bit of coherence at the expense of slower writes.

Possibly, yes, devil is in the details (based on hardware config used,
etc).  But point taken.

> > Having NFSD_IO_DIRECT be handled as UNSTABLE isn't adequate for my
> > needs (immediate ondisk requirements, lowest memory and CPU usage as
> > possible).  Would you be OK with adding 2 new debugfs knobs?:
> > 
> > /sys/kernel/debug/nfsd/io_cache_read_stable_how
> 
> READs don't have a stable_how argument. I don't even know what a
> stable_how argument on a READ would do.

Sorry, yes... not sure why I had that; I was rushing to hit send
before racing to the airport to pickup my wife.
 
> > /sys/kernel/debug/nfsd/io_cache_write_stable_how
> > 
> > - Each defaults to using the stable_how that the client requested.
> > 
> > - Each will serve as a floor, and only override default if they are
> >   greater/stricter than the client requested stable_how. (so if
> >   'io_cache_write_stable_how' set to NFS_FILE_SYNC it'd override
> >   client specified UNSTABLE).
> > 
> > - Each can override the stable_how used so each IO mode behaves
> >   accordingly (e.g. I can set NFSD_IO_DIRECT and NFS_FILE_SYNC to get
> >   the bahviour I'd like).
> 
> I'm loath to add another potential administrative setting for something
> that should be determined automatically (or at least, based on the
> workload conditions). But, why not add a fourth IO_MODE setting instead
> of another debug setting?

Sure, that can work too, less knobs is good.

> But first, let's see the use cases and performance data. I think you're
> getting way ahead of yourself

I think I might be ahead of you in understanding what has worked well,
I'm apt to try a thing and see what happens.  But it follows from me
having need and pushing forward.  You have already caught up and are
asking all the right questions and more.  Appreciate your time.

> and none of this needs to be considered
> to decide when the present series is ready to be merged.

That's fine, we can take it as it comes.

> Before anyone can consider these ideas, you need to create the patches
> and show there's a value difference for some applications and
> negligible cost to everyone else.
> 
> As they say on the cop shows, let's go where the evidence leads.

Yeap.

Thanks,
Mike

