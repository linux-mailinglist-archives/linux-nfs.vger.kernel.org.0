Return-Path: <linux-nfs+bounces-15759-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F626C1BBF1
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Oct 2025 16:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D2B34FC197
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Oct 2025 15:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF8FB672;
	Wed, 29 Oct 2025 15:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxydLCqJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACE52F5A25
	for <linux-nfs@vger.kernel.org>; Wed, 29 Oct 2025 15:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751335; cv=none; b=us9YxOjxwgb0tQyN9q+5IehS/Az3BC4Lq2gj7iTXp4lzGNz8EvykopOCW+Sw/SKJs/kKV9NmO6Rfu0/ZvaeJzrkK97lxbOaAlIeBQBo6ZfTxZArG7+oIeVnbrbE5CjuUcfpwFqywWLpreHAymFfLt36KAEiEeo52G8l2/KObunE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751335; c=relaxed/simple;
	bh=jkAASJStJCmWRKj1n6/q01Xpsl8KWtH+F/6L3jR3bWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MF9im6BANV8Zw8Pw+Oi4sOKCA/hpJiLYsw+foM2ebOhnqzhUZHDy2z7T9rLN7ETosq4SNEoHLzTMm6DSYU2m22RCTYavEunrAvYR8MD4f8SeQgmqmL0Ohqx7ZLYRMEBSxFhYm0sgAjG9tOdit3SI0ij6Lk+TAMvtF1L0FpmlW9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxydLCqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2C0C4CEF7;
	Wed, 29 Oct 2025 15:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761751335;
	bh=jkAASJStJCmWRKj1n6/q01Xpsl8KWtH+F/6L3jR3bWQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XxydLCqJV/aswZvcUOEgmhcKSHmWsoaSi/Y6wccJH+bVRbKNUl2WmMGPsaDPchCPA
	 CFaLcz2DcqX63rY6gqg/p9ixBsEGImaPknolSnKrebVZ107UdXBCNSWK/NLhsO3UVM
	 dbRFqu++NuMoLt3NkIvEDMZmP2YwRwRjFnxlUU5q/ZMNIVtTpH2HGaXM/cZLaL3ov/
	 1cwF+q53rfNm/8M1hksBCjrxWRFt0KLrA3ro8sXcLC3QZp5BQeB4KZ9QAdh5ndmG6P
	 TzkPTnhIRReKTv0YHEc+hlU30+8yFnCH+Q5ehEW9pYSHFwKtWZrmstH0LBNVzI7sfD
	 Smm4jhdTa/NNg==
Message-ID: <872ec54f-bcb8-4e66-9c2b-d91f1be0f82f@kernel.org>
Date: Wed, 29 Oct 2025 11:22:13 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
To: Mike Snitzer <snitzer@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 Christoph Hellwig <hch@lst.de>
References: <5017c8dc-9c14-4a92-a259-6e4cdc67d250@kernel.org>
 <aPwSS9NlfqPFqfn2@kernel.org> <aP8qPlA7BEN3nlN8@infradead.org>
 <5a2e4884bb6b31b0443bdac6174c77f7273e92b1.camel@kernel.org>
 <aP-YV2i8Y9jsrPF9@kernel.org>
 <a221755a-0868-477d-b978-d2c045011977@kernel.org>
 <aQA4AkzjlDybKzCR@kernel.org>
 <1f7b30d2-f806-400f-81d3-80b6c924c410@kernel.org>
 <aQDpjNnj47ISRItg@kernel.org>
 <b63ed4d4-8bbb-4794-ae07-64a4000e0ea9@kernel.org>
 <aQFYLKmC2Nr1QUrM@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aQFYLKmC2Nr1QUrM@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/25 7:56 PM, Mike Snitzer wrote:
> On Tue, Oct 28, 2025 at 02:48:33PM -0400, Chuck Lever wrote:
>> On 10/28/25 12:04 PM, Mike Snitzer wrote:
>>> I'm also concerned about initiating
>>> any page cache invalidation off the back of the DIO WRITE in the
>>> middle (and its potential to fallback to buffered if that invalidation
>>> fails... any associated buffered IO fallback or ends best have O_DSYNC
>>> set it ensure everything ondisk).
>>
>> My questions:
> 
> All good questions, and I appreciate the time you spent analyzing
> these aspects.
> 
> I'm all for NFSD's IO modes being able to work with all possible
> stable_how.  Your analysis helps expand the scope of these IO modes to
> really be pushed to their limits (specifically thinking of
> NFSD_IO_DIRECT being paired with UNSTABLE and it _not_ using
> IOCB_DSYNC, interesting combo but IMO quite a risky default given
> we're only at the debugfs interface stage for NFSD_IO_DIRECT).
>  
>> A. Which filesystem code can return -ENOTBLK?
>>
>> - iomap-based DIO (fs/iomap/direct-io.c:715): XFS, ext4, f2fs, gfs2,
>>   zonefs, erofs
>> - Legacy DIO path (fs/direct-io.c:984): ext2, some ext4 code paths
>> - btrfs (has its own DIO implementation that uses -ENOTBLK)
>>
>> Code auditing shows that vfs_iocb_iter_write() never returns -ENOTBLK
>> because all filesystems that could generate this error internally
>> convert it to 0 or another error code before returning from their
>> write_iter implementation.
>>
>> Therefore NFSD itself does not need to know about or handle page cache
>> invalidation failure.
> 
> OK, good to hear; but have you reviewed if they are all using D_SYNC
> as part of their internal handling of their buffered fallback?  NFSD
> setting DSYNC just acknowledges it is required to ensure O_DIRECT
> WRITEs are ondisk upon return to client -- something I don't want to
> leave to the client to ensure via NFS_UNSTABLE's subsequent COMMIT.

As Christoph said, the application runs on the client, and it tells
the client exactly what needs to happen. Then the client tells the
server.

Essentially what forcing all writes to be slow durable writes does
is makes a special case a little faster (maybe, that has yet to be
demonstrated) at the expense of all other use cases that prefer to
write a lot and then commit.

And if I understand Jonathan's numbers correctly, this only truly
matters when the server's memory has been exhausted. The usual Linux
paradigm is to let workloads whose resident sets fit in memory go
just as fast as can be allowed. We need the additional durability
only when the server is tipping over.

The server could flush more aggressively when it recognizes it cannot
hold its working set in memory. But I think the issue there is that the
server is tipping over because it simply cannot flush fast enough to
keep up with clients.

I'd like someone to have a look at slowing down noisy clients when the
server starts to reach its limits. At least NFSD should get some
observability mechanisms to tell which clients are the troublesome ones.


> Setting O_DSYNC gives us a baseline where we don't leave some other
> subsystem to ensure data gets to disk as quickly as possible (O_DSYNC
> offers NFS_DATA_SYNC, but O_DSYNC|SYNC's NFS_FILE_SYNC offers a win by
> avoiding COMMIT, even more enticing).
> 
> So I need NFSD_IO_DIRECT to be able to require IOCB_DSYNC and possibly
> IOCB_DSYNC|IOCB_SYNC.  And I'm most comfortable with the misaligned
> DIO WRITE support using O_DSYNC for all 3 segments; so that WRITE's
> data is ondisk before returning from the WRITE (NFS_DATA_SYNC), and
> bonus if we can avoid extra COMMIT (NFS_FILE_SYNC).

This flies in the face of what the protocol mandates and what
applications have come to expect over the past 30 years.

The server is free to promote WRITE to higher durability, but that
/always/ comes at a cost. That cost is worth it, I can see, only when
the server cannot cache an UNSTABLE WRITE.

I suspect your true mission is to turn NFS into Lustre. ;-)


>> B. Even if NFSD had to recover from a failed page cache invalidation,
>>    does a fallback write need to set IOCB_DSYNC (not considering the NFS
>>    protocol requirements) ?
>>
>> When invalidation fails, some pages remain in the cache (dirty or with
>> private data). The buffered fallback writes to those same pages,
>> updating them with the correct data. There's no torn state or corruption
>> hazard.
>>
>> The fallback restarts the entire write from scratch, as buffered. Any
>> partial progress (like a buffered first segment) gets rewritten with
>> the same data. No orphaned blocks or inconsistent state.
>>
>> If another process does a DIO read of this region, it will call
>> kiocb_write_and_wait() first (see mm/filemap.c:2912), which flushes any
>> dirty pages before reading. So they'll see correct data even if it's
>> still dirty in cache (Jeff's concern).
> 
> Yes, but the point is there is extra work that involves the page
> cache by other layers.  And O_DIRECT is intended to work expecting the
> IO has been flushed to disk. O_DIRECT is aiming to reduce page cache> usage, to keep memory use low.  So ensuring the page cache invalidated
> to disk by the subsequent write as a side-efffect of O_DSYNC helps
> (more on this below [0]).

Go look at what happens after an IOCB_DIRECT write returns to its
caller. The write buffer goes away almost immediately and there's
nothing left in memory.

The unaligned ends go through the page cache, but IOCB_DONTCACHE is set
on those, so those pages are immediately evictable.


>> C. When setting up a three-segment write, is IOCB_DSYNC needed on the
>>    unaligned ends (not considering the NFS protocol requirements) ?
>>
>> Before writing the DIO middle segment, the VFS must first invalidate the
>> page cache, so the first (buffered) segment is flushed to durability
>> anyway. The use of IOCB_DSYNC for the first segment is superfluous.
> 
> No, the first segment reflects the misaligned head of the WRITE. The
> DIO-aligned middle segment's DIO will just invalidate pages aligned on
> the middle segment's alignment (which is page aligned).  So the DIO
> from the middle segment won't have any side-effect on the first
> segment's page.  First page needs to be written out with IOCB_DSYNC.

You still haven't demonstrated why. What is the risk of not making
the first segment durable? I don't find the arguments about a little
extra memory usage at all convincing, especially if DONTCACHE is in
play.

So, have we decided that there is no data integrity risk with leaving
off IOCB_DSYNC for the burnt ends? The only purpose now is a potential
performance optimization?


>> After writing the DIO middle segment, the unaligned end remains only in
>> the page cache if IOCB_DSYNC is not used. But a subsequent DIO read will
>> flush that to durability (via kiocb_write_and_wait) before satisfying
>> the read. So, IOCB_DSYNC is not needed there to meet putative file data
>> visibility mandates.
> 
> The same applies to both the misaligned first (head) and third (tail)
> segments, they both need O_DSYNC to ensure their contents are ondisk.

A direct READ will write back any cached pages in the read byte range
before it reads from the media. Full stop. There is no need for NFSD
to add IOCB_DSYNC for reads to get the latest data.


> [0]: Again, my goal for NFSD_IO_DIRECT is to operate in terms of
> O_DIRECT|O_DSYNC ondisk.. and not lean on the page cache more than
> needed. This makes the VM subsystem more scalable as a side-effect of
> it having more clean pages that are quickly dropped and/or reused if
> something needs memory.

That's a giant claim, and it needs a lot of clear evidence to back it
up. I think when you have code we can review, we can begin to discuss
it further. For now, let's focus on the code to be merged now.


> Anyway, I've been working to ensure NFSD_IO_DIRECT acts as if at least
> NFS_DATA_SYNC, but preferably NFS_FILE_SYNC, set.

Clearly, but the rationale for this effort needs some work. It doesn't
reflect the mandates of the NFS protocol and I haven't seen a use case
for it.


> I should have more  
> clearly stated that.  Bypassing all caches as much possible allows for
> enabling scalable cache coherence, e.g. intelligent applications that
> don't rely on file locking, think multiple writers writing to their
> own extent of a large file.

At the expense of applications that do not need or want that extra
bit of coherence at the expense of slower writes.


> Having NFSD_IO_DIRECT be handled as UNSTABLE isn't adequate for my
> needs (immediate ondisk requirements, lowest memory and CPU usage as
> possible).  Would you be OK with adding 2 new debugfs knobs?:
> 
> /sys/kernel/debug/nfsd/io_cache_read_stable_how

READs don't have a stable_how argument. I don't even know what a
stable_how argument on a READ would do.


> /sys/kernel/debug/nfsd/io_cache_write_stable_how
> 
> - Each defaults to using the stable_how that the client requested.
> 
> - Each will serve as a floor, and only override default if they are
>   greater/stricter than the client requested stable_how. (so if
>   'io_cache_write_stable_how' set to NFS_FILE_SYNC it'd override
>   client specified UNSTABLE).
> 
> - Each can override the stable_how used so each IO mode behaves
>   accordingly (e.g. I can set NFSD_IO_DIRECT and NFS_FILE_SYNC to get
>   the bahviour I'd like).

I'm loath to add another potential administrative setting for something
that should be determined automatically (or at least, based on the
workload conditions). But, why not add a fourth IO_MODE setting instead
of another debug setting?

But first, let's see the use cases and performance data. I think you're
getting way ahead of yourself, and none of this needs to be considered
to decide when the present series is ready to be merged.

Before anyone can consider these ideas, you need to create the patches
and show there's a value difference for some applications and
negligible cost to everyone else.

As they say on the cop shows, let's go where the evidence leads.


-- 
Chuck Lever

