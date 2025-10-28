Return-Path: <linux-nfs+bounces-15726-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A095C15B35
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 17:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E324610F0
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 16:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E27F70809;
	Tue, 28 Oct 2025 16:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Perb13i5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297F427991E
	for <linux-nfs@vger.kernel.org>; Tue, 28 Oct 2025 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667470; cv=none; b=HTt1tiYyYBfDXaGBt3C5OT5I6gZVwT6c4utG7Z12flRaYQjqD3bqBkfRioliMMdAEzFgwstV6vrpFdlGlhfr2x3Q4yOVbtVg0OfXXk4ncUakGcL3UDadnucVH7wSl+TpZFrMBCPI7xKKXID0F62bF7mToZKIcFADC5JYHdg77Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667470; c=relaxed/simple;
	bh=p29DGZwx+A2BkmP3OVa7VQmXuDjZlbx0MzPKoIOKHM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUWpa+FLSfyQKLfqcOYK66gsHWu5KIa98iPyfKHKb8fiQUiQ6wxs8d/XImZ/vwE6FUAwAS5R8u3zW0wmLZYl/jvoM3K6FMtm4k7j0UlLO0z4GglcMnwv2xtceVU76D3UTf+DhGIDgbAFy69t/yCvxZKixOw+U6nFGhIh6d/KcUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Perb13i5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E23EC4CEE7;
	Tue, 28 Oct 2025 16:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761667469;
	bh=p29DGZwx+A2BkmP3OVa7VQmXuDjZlbx0MzPKoIOKHM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Perb13i5Ixj4BF1vqinDiU5JU7isyLHb/8gTCDkSViHo5n1kpwMvfECybOsTvgBf4
	 /TLprvCgD3A5U7hvekE+EFdk2Yme8DopMeSCjlF3plw2pbtKLLdTqB9a3Eizs5t01F
	 VJHBu4OIXh1xPde1aCBABXsmcrOOjB2FLY2sh37Wmbf+L7S/jJGJWieBXsVbg4MSms
	 eyR1WhYAUPlKGS3AqLlmaolunOKen8GrfWKYuzhIc6wbiO/wf7b5K1VbDpIn0EYUYi
	 sI9LV7RC8Zoj946UazJCuXFWhk3T1VfRv512nbGkIJfJAiEwlR4a291UjrdxvnzRRe
	 OPj04a0JFFfRQ==
Date: Tue, 28 Oct 2025 12:04:28 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
Message-ID: <aQDpjNnj47ISRItg@kernel.org>
References: <ab3fbc43-864a-49b1-b3fd-ba9034d0c0d2@kernel.org>
 <aPvjiwF9vcawuHzi@kernel.org>
 <5017c8dc-9c14-4a92-a259-6e4cdc67d250@kernel.org>
 <aPwSS9NlfqPFqfn2@kernel.org>
 <aP8qPlA7BEN3nlN8@infradead.org>
 <5a2e4884bb6b31b0443bdac6174c77f7273e92b1.camel@kernel.org>
 <aP-YV2i8Y9jsrPF9@kernel.org>
 <a221755a-0868-477d-b978-d2c045011977@kernel.org>
 <aQA4AkzjlDybKzCR@kernel.org>
 <1f7b30d2-f806-400f-81d3-80b6c924c410@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f7b30d2-f806-400f-81d3-80b6c924c410@kernel.org>

On Tue, Oct 28, 2025 at 11:37:52AM -0400, Chuck Lever wrote:
> On 10/27/25 11:26 PM, Mike Snitzer wrote:
> > So can we please revisit your desire to eliminate the use of
> > IOCB_DSYNC for NFSD_IO_DIRECT WRITEs?
> 
> Let's have a little less breathless panic, please. The whole point of
> review is to revisit our decisions. And nothing I've done so far is
> written in stone... even after merge, we can still apply patches. If
> the consensus is we don't like v8 or some particular patch, I will
> rewrite or replace it, as I've already said.
> 
> You might view me as a whimsical and authoritarian maintainer, but
> actually, I am resisting the urge to merge a patch that the community
> (that is now responsible for free long-term support of the patch) hasn't
> yet fully learned about and carefully reviewed. I see my role as
> enforcing a consensus process, and both learning and consensus takes
> time.

Cool, thanks for level setting.  Helps!

> >> So perhaps the issue here is that the rationale for using IOCB_DSYNC
> >> for all NFSD_IO_DIRECT writes is hazy and needs to be clarified.
> 
> > How is it still hazy?  We've had repeat discussion about the need for
> > IOCB_DSYNC (and IOCB_SYNC if we really want to honor intent of
> > NFS_FILE_SYNC).
> 
> TL;DR: it's hazy for folks who were not in the room in Raleigh.
> 
> I don't see any comments that explain /why/ the unaligned ends need to
> be durable along with the middle segment. It appears to be assumed that
> everyone agrees it's necessary. Patch review has shown that is perhaps
> not a valid assumption.

How so?  I missed any patch review that called into question the need
to ensure all segments are on stable storage.  The only was to do that
for buffered and direct I is to set IOCB_DSYNC.
 
> So far it's been discussed verbally, but we really /really/ want to have
> this documented, because we're all going to forget the rationale in a
> few months.

But it isn't so complex.  DSYNC is needed if you want data to be
ondisk when the call returns.

> And please do not forget that this is open source code. The code has to
> be able to be modified by developers outside our community. Right now it
> isn't well enough documented for anyone who was outside of the room in
> Raleigh two weeks ago to understand WTF is going on. The point being
> that we cannot make final decisions in a closed room -- eventually they
> need to face the larger community.
> 
> If we need to insist that NFSD_IO_DIRECT mode is always going to be
> fully durable, that design choice needs to be explained in code comments
> that are very close to the code that implements it.
> 
> 
> > Christoph has repeatedly said DSYNC is needed with O_DIRECT, yet you
> > keep removing it.
> 
> That's not what I read. Over the course of three email threads, he wrote
> that:
> 
> - IOCB_DSYNC is always needed when IOCB_SYNC is set, whether or not
>   we're using IOCB_DIRECT.
> 
> - in order to guarantee that a direct write is durable, we /either/ need
>   IOCB_DSYNC + IOCB_DIRECT, /or/ IOCB_DIRECT by itself with a follow-up
>   COMMIT.
> 
> - for some commonly deployed media types, IOCB_DSYNC with IOCB_DIRECT
>   might be slower than IOCB_DIRECT followed up with COMMIT.

Hmm, I have other quotes that stand out to me.. but I'll spare you
(especially since I'm short on time to reply at the moment).

> Therefore, we need to carefully justify why the current patches stick
> with only IOCB_DSYNC + IOCB_DIRECT, or decide it's truly not necessary
> to force all NFSD_IO_DIRECT writes to be IOCB_DSYNC.

The misaligned DIO WRITE is what I'm concerned about given the 3
segments that make up the whole of a given NFS WRITE.

We do have the ability to know a misaligned DIO WRITE is occuring
(nsegs > 1).

I would _really_ appreciate it if we could ensure setting IOCB_DSYNC
for that case.

> Christoph and I (if I may put words in his mouth) both seem to be
> interested in making NFSD_IO_DIRECT useful in contexts other than a very
> specific enterprise-grade server with esoteric NVMe devices and ultra
> high bandwidth networking. After all, one of the deep requirements for
> merging something upstream is that it is likely to be useful to more
> than a very narrow constituency (see recent discussions about merging
> TernFS).

You're fine to extend NFSD_IO_DIRECT to be broadly applicable, I
completely agree with that.  Accomplishing that by removing flags that
ensure data integrity for misaligned DIO WRITE isn't the way forward.

That's by only point.  Its typical to start with more conservtive
protection, especially for something manifesting as a new optional
debug setting like NFSD_IO_DIRECT.

Relaxing the code in a sensible and safe manner is perfectly
acceptable.  I'm just saying it is _not_ in the misaligned DIO WRITE
case (I'll stop repeating that now, promise.. heh).

> If we truly care about making NFSD_IO_DIRECT valuable for small memory
> NFSD systems, then we need to acknowledge that their durable storage is
> likely to be virtual or in some other way bandwidth-compromised, and not
> a directly-attached real NVMe device.

Not always the case, but I agree that is one possibility.

> >> Or, we might decide that, no, NFS WRITE has no data visibility mandate;
> >> applications achieve data visibility explicitly using COMMIT and file
> >> locking, so none of this matters.
> > 
> > We don't have that freedom if we cannot preserve file offset integrity
> > (as would be the case if we removed IOCB_DSYNC when handling all 3
> > segments of a misaligned DIO WRITE).  Removing IOCB_DSYNC would
> > compromise misaligned DIO WRITE as implemented.
> 
> As I understand it, IOCB_DSYNC has nothing to do with whether the three
> segments are directed to the correct file offsets. Serially initiating
> the writes with the same iocb should be sufficient to ensure
> correctness.

IOCB_DSYNC just ensures when they complete they are on-disk.  And any
failure of, or short WRITE, is trapped and immediate cause for early
return.  Whereby ensuring file offset integrity.

> The concern about integrity is that in the multi-segment case, the
> segments won't make it to durable storage at the same time, and an
> intervening NFS READ might see an intermittent file state.

Well that is one concern yes; but I'm also concerned about initiating
any page cache invalidation off the back of the DIO WRITE in the
middle (and its potential to fallback to buffered if that invalidation
fails... any associated buffered IO fallback or ends best have O_DSYNC
set it ensure everything ondisk).

> If the risk of a torn write is an actual problem for an application, it
> should serialize its reads, writes, and flushes itself. I think there
> are already plausible situations in today's non-DIRECT world where
> incomplete writes are visible, so it might be sensible not to worry too
> much about it here.
> 
> Jeff, please do clarify if I've misunderstood your concern.

Yeah, applications really shouldn't expect perfection in the face of
contended buffered READ vs DIO WRITE.. I'm most concerned about us
trying to have misaligned DIO WRITE's IO be handled as if all 3
segments are a unit (_not_ atomic) that when written will still
preserve file offset integrity.  Kills 2 birds of "integrity" (data
and file offset).

> >>> And we already showed that doing so really isn't slow.
> >>
> >> Well we don't have a comparison with "IOCB_DIRECT without IOCB_DSYNC".
> >> That might be faster than what you tested? Plus I think your test was
> >> on esoteric enterprise NVMe devices, not on the significantly more
> >> commonly deployed SSD devices.
> > 
> > IOCB_DIRECT without IOCB_DSYNC isn't an option because we must ensure
> > the data is ondisk.
> 
> You are stating the exact assumption that we are testing right now. It
> is not 100% clear from code and comments in these patches why "we must
> ensure the data is on disk".

So misaligned DIO WRITE in terms of 3 segments works.

Thank you for your attention to this matter! ;)

Mike

