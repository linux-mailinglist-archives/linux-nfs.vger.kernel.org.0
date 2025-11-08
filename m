Return-Path: <linux-nfs+bounces-16211-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37235C42455
	for <lists+linux-nfs@lfdr.de>; Sat, 08 Nov 2025 03:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE73A1895BCA
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Nov 2025 02:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F354CB5B;
	Sat,  8 Nov 2025 02:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0Z8XGJs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31921DE3CB
	for <linux-nfs@vger.kernel.org>; Sat,  8 Nov 2025 02:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762567315; cv=none; b=fdgY0LwV0uuDIURf1WVIbQgUDF5mw2T4d3w8nO/1WVl8SGfFwijfZknTWnIfCojp8Gh/YOtviA5nCn9Jm6+d6w4CDXKpN57e89OG1K5+QGbMimKFIP5hK1eZkN7OgLS4gYGHOLdSciMa5nSHMvIaTYtgYc5dOo1oQd3GcfQwLwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762567315; c=relaxed/simple;
	bh=bVU0LXayF8qkw8gRyIP+yZGEm6zN0AsczKVZicTlbHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9NHQ6GGY5p6+ehvGlfEyaCwHcVQDtLfP05p6DtDs0h/TBcMAwUScfQzH9hrBse+2B0tpKIzNQ521MStp5Em1/OJJoPS27BtBuvOhjzti9cBF3Go621SDKqzYDK/aiP9hdA1l4fyWrqHTzYmcV3emWMn1tKDguUnM6qo+D/3XhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0Z8XGJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4891AC4CEF7;
	Sat,  8 Nov 2025 02:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762567314;
	bh=bVU0LXayF8qkw8gRyIP+yZGEm6zN0AsczKVZicTlbHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a0Z8XGJsvww48RV5qtsw2kvwEUZqeYWE2KauC5zwhEEkcqTCkhRD2+xba0mvggd9u
	 HZ6kssUif9A8OMNp32TLtM7H0mC9Y4NmCexzygPykfh3ICLWwSH/2T70RKERlPKI0g
	 XcgwxHg8U6Vauoqa0bCLmLpZWQMuYgxxottG53m2Os/DZ5vE71qFTFCyf8/9aZFfuV
	 MQYTsvqCZcHFLKSrsIYBxsjmxtn8brgtGEl09ZaquCC0IE8/bzY2Xy5yBC6t8ka5bj
	 asA0A8Gg3RZe2kKsqR93nTy3hB+0pQUShtv0IdgiWxH4PVpz03TGIH3W5/xFWfy/Vi
	 cjBS6ewfgPX6w==
Date: Fri, 7 Nov 2025 21:01:53 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@ownmail.net>
Cc: Chuck Lever <cel@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v11 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aQ6kkd74pj2aUd8b@kernel.org>
References: <20251107153422.4373-1-cel@kernel.org>
 <20251107153422.4373-3-cel@kernel.org>
 <aQ4Sr5M9dk2jGS0D@infradead.org>
 <82be5f47-77df-423d-a4f3-17f83ddb6636@kernel.org>
 <aQ5Q99Kvw0ZE09Th@kernel.org>
 <fb0d6399-ea74-462a-982a-df232e3f4be9@kernel.org>
 <aQ5SSnW9xUWj9xBi@kernel.org>
 <176255273643.634289.15333032218575182744@noble.neil.brown.name>
 <aQ5xkjIzf6uU_zLa@kernel.org>
 <176255894778.634289.2265909350991291087@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176255894778.634289.2265909350991291087@noble.neil.brown.name>

On Sat, Nov 08, 2025 at 10:42:27AM +1100, NeilBrown wrote:
> On Sat, 08 Nov 2025, Mike Snitzer wrote:
> > On Sat, Nov 08, 2025 at 08:58:56AM +1100, NeilBrown wrote:
> > > On Sat, 08 Nov 2025, Mike Snitzer wrote:
> > > > On Fri, Nov 07, 2025 at 03:08:11PM -0500, Chuck Lever wrote:
> > > > > On 11/7/25 3:05 PM, Mike Snitzer wrote:
> > > > > >> Agreed. The cover letter noted that this is still controversial.
> > > > > > Only see this, must be missing what you're referring to:
> > > > > > 
> > > > > >   Changes since v9:
> > > > > >   * Unaligned segments no longer use IOCB_DONTCACHE
> > > > > 
> > > > > From the v11 cover letter:
> > > > > 
> > > > > > One controversy remains: Whether to set DONTCACHE for the unaligned
> > > > > > segments.
> > > > 
> > > > Ha, blind as a bat...
> > > > 
> > > > hopefully the rest of my reply helps dispel the controversy
> > > > 
> > > 
> > > Unfortunately I don't think it does.  I don't think it even addresses
> > > it.
> > > 
> > > What Christoph said was:
> > > 
> > >    I'd like to sort out the discussion on why to set IOCB_DONTCACHE when
> > >    nothing is aligned, but not for the non-aligned parts as that is
> > >    extremely counter-intuitive.
> > > 
> > > You gave a lengthy (and probably valid) description on why "not for the
> > > non-aligned parts" but don't seem to address the "why to set
> > > IOCB_DONTCACHE when nothing is aligned" bit.
> > 
> > Because if the entire IO is so poorly formed that it cannot be issued
> > with DIO then at least we can provide the spirit of what was requested
> > from the admin having cared to enable NFSD_IO_DIRECT.
> 
> "so poorly formed"...  How can IO be poorly formed in a way that is
> worse than not being aligned?

I was talking about the no_dio case when iov_iter_bvec_offset() isn't
aligned (case 2 below). The entire WRITE must use buffered IO even
though NFSD_IO_DIRECT configured.

> > Those IOs could be quite large.. full WRITE payload.  I have a
> > reproducer if you'd like it!
> 
> Can they?  How does that work?
> From looking at the code I can only see that "Those IOs" are too small
> to have any whole pages in them.

Huh?  You're clearly confused by the 2 cases of NFSD_IO_DIRECT's
unaligned WRITE handling (as evidenced by you solidly mixing them).

1: WRITE is split, has DIO-aligned middle and prefix and/or suffix.

prefix/suffix are the subpage IOs of a misaligned WRITE that _does_
have a DIO-aligned middle, I covered that in detail in this email:
https://lore.kernel.org/linux-nfs/aQ5Q99Kvw0ZE09Th@kernel.org/
it left you wanting, thinking I missed Christoph's point (I didn't).

2: WRITE cannot be split such that middle is DIO-aligned.

The case you wanted me to elaborate on, I did so here:
https://lore.kernel.org/linux-nfs/aQ5xkjIzf6uU_zLa@kernel.org/
when entire WRITE is misaligned it makes all the sense in the world to
use DONTCACHE.  Chuck, Christoph and I all agree on this.

But just because it makes sense for case 2's (potentially large) WRITE
to not use cached buffered IO if NFSD_IO_DIRECT, it doesn't logically
follow that case 1's two individual pages for prefix/suffix must use
DONTCACHE buffered IO too.

Now do you see the so-called "controversy"?

Christoph expects case 1 to use DONTCACHE because it best reflects
O_DIRECT semantics (avoid using caching).

Here is another way to look at it:

Q: Case 2 uses DONTCACHE, so case 1 should too right?

A: NO. There is legit benefit to having case 1 use cached buffered IO
when issuing its 2 subpage IOs; and that benefit doesn't cause harm
because order-0 page management is not causing the MM problems that
NFSD_IO_DIRECT sets out to avoid (whereas higher order cached buffered
IO is exactly what both DONTCACHE and NFSD_IO_DIRECT aim to avoid.
Otherwise MM spins and spins trying to find adequate free pages,
cannot so does dirty writeback and reclaim which causes kswapd and
kcompactd to burn cpu, etc).

NFSD_IO_DIRECT and DONTCACHE both want to avoid the pathological worst
cases of the MM subsystem when its coping with large IOs.  But
NFSD_IO_DIRECT is doing so in terms of O_DIRECT whereas DONTCACHE is
approximating O_DIRECT (uses page cache with drop-behind semantics,
without concern for DIO alignment, etc).  Both are effective in their
own way, but NFSD_IO_DIRECT only uniformly benefits from using
DONTCACHE buffered IO for case 2.

I'm advocating we make an informed decision for NFSD_IO_DIRECT to use
cached buffered IO for case 1's simple usage of order-0 allocations.
Let's please not get hung up of intent of O_DIRECT because
NFSD_IO_DIRECT achieves that intent very well -- and by using cached
buffered IO it can avoid pathological performance problems (case 1's
handling of streaming misaligned WRITEs that _must_ do RMW).

> Maybe we need a clear description of the sort of IOs that are big enough
> that they impose a performance cost on the page-cache, but that somehow
> cannot be usefully split into a prefix/middle/suffix where prefix and
> suffix are less than a page each.

So defining case 2 again: entire WRITE payload is unaligned because
each aligned logical_block_size doesn't start on a dma_alignment
boundary in memory.  (Also the definition of "the entire IO is so
poorly formed that it cannot be issued with DIO".)

Mike

