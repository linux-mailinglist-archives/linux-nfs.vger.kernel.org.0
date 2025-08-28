Return-Path: <linux-nfs+bounces-13928-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09310B39678
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 10:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D007C2772
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 08:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C432FD7AA;
	Thu, 28 Aug 2025 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nT/eK8ZB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08282FC89A
	for <linux-nfs@vger.kernel.org>; Thu, 28 Aug 2025 08:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756368563; cv=none; b=skd4I7liqr7BI0qdsj6S7INsMdJBI5InQYKKRULH9ZU0wEAC9Xy8u8RLrqQnmlJAU8YQRiZOmHbm6MKoCCYEFCYdqCIWcPsxmEn4Wzu0V1F3W+VdUoG1Iar3Fcpxkuu+Dk6YB+vzhyRQTEU/sVeDLD7D5bvuPNp3aSPz3FpkhoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756368563; c=relaxed/simple;
	bh=jxQP2BUCr+An8aU2o9DwX6WjId/RidWXx8drFKdlZvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGJKyx+dmq3YSPczl6JXvJ8OuaE2k7RTD7ZgI2QhURJjH2otX+qMogkTxqcIxmOVzXoZT70wvQKolxhqEgNTzB8rCiUMadpGf7dHHd/rNNNesRTAAKT00qQLPd/owbxlMHbhm6zXem0nPG6TctGZVD7jOAkwdse/tBjRLJ39M8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nT/eK8ZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7190FC4AF52;
	Thu, 28 Aug 2025 08:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756368562;
	bh=jxQP2BUCr+An8aU2o9DwX6WjId/RidWXx8drFKdlZvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nT/eK8ZB5cSIVLdS7xaeFE1/Ifjv5bfHKNRHISdnZBIKIKdyKdsEHiwUs5Z7HNnLC
	 w3eac+Hq3nQeEEbhp1jWU64c7JFESxJrzT310Ms6KoT6uOARjoCSf5JKtYA5aoODoF
	 DwrENsE0X8E+SoW/oUgpwD5+PG/jpBKVZWxDlPb/qjKN2kZAAQxYnsIexcs47dI0BU
	 nK6wsgswndQKt9WRmmab6GfLa4RVCaigx6iR3R/3hlhSwqdn1n+KwX+n+Ph1pxCGM/
	 rhICsCktK9HLOQoXm95dDPW3kuS6v6jSm2R+XlgKzzBNVahxiv8fd5o7qF1V/PaNG8
	 Ym2H2vtTWKgRw==
Date: Thu, 28 Aug 2025 04:09:20 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v8 5/7] NFSD: issue READs using O_DIRECT even if IO is
 misaligned
Message-ID: <aLAOsGUIvONZvfX7@kernel.org>
References: <20250826185718.5593-1-snitzer@kernel.org>
 <20250826185718.5593-6-snitzer@kernel.org>
 <f7aee927-e4fc-44da-a2b6-7fd90f90d90e@oracle.com>
 <aK9fZR7pQxrosEfW@kernel.org>
 <6f5516a5-1954-4f77-8a07-dacba1fb570c@oracle.com>
 <aK-Reg6g8ccscwMu@kernel.org>
 <09eca412-b6e3-4011-b7dd-3a452eae6489@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09eca412-b6e3-4011-b7dd-3a452eae6489@oracle.com>

On Wed, Aug 27, 2025 at 09:57:39PM -0400, Chuck Lever wrote:
> On 8/27/25 7:15 PM, Mike Snitzer wrote:
> > On Wed, Aug 27, 2025 at 04:56:08PM -0400, Chuck Lever wrote:
> >> On 8/27/25 3:41 PM, Mike Snitzer wrote:
> >>> Is your suggestion to, rather than allocate a disjoint single page,
> >>> borrow the extra page from the end of rq_pages? Just map it into the
> >>> bvec instead of my extra page?
> >>
> >> Yes, the extra page needs to come from rq_pages. But I don't see why it
> >> should come from the /end/ of rq_pages.
> >>
> >> - Extend the start of the byte range back to make it align with the
> >>   file's DIO alignment constraint
> >>
> >> - Extend the end of the byte range forward to make it align with the
> >>   file's DIO alignment constraint
> > 
> > nfsd_analyze_read_dio() does that (start_extra and end_extra).
> > 
> >> - Fill in the sink buffer's bvec using pages from rq_pages, as usual
> >>
> >> - When the I/O is complete, adjust the offset in the first bvec entry
> >>   forward by setting a non-zero page offset, and adjust the returned
> >>   count downward to match the requested byte count from the client
> > 
> > Tried it long ago, such bvec manipulation only works when not using
> > RDMA.  When the memory is remote, twiddling a local bvec isn't going
> > to ensure the correct pages have the correct data upon return to the
> > client.
> > 
> > RDMA is why the pages must be used in-place, and RDMA is also why
> > the extra page needed by this patch (for use as throwaway front-pad
> > for expanded misaligned DIO READ) must either be allocated _or_
> > hopefully it can be from rq_pages (after the end of the client
> > requested READ payload).
> > 
> > Or am I wrong and simply need to keep learning about NFSD's IO path?
> 
> You're wrong, not to put a fine point on it.

You didn't even understand me.. but firmly believe I'm wrong?

> There's nothing I can think of in the RDMA or RPC/RDMA protocols that
> mandates that the first page offset must always be zero. Moving data
> at one address on the server to an entirely different address and
> alignment on the client is exactly what RDMA is supposed to do.
>
> It sounds like an implementation omission because the server's upper
> layers have never needed it before now. If TCP already handles it, I'm
> guessing it's going to be straightforward to fix.

I never said that first page offset must be zero.  I said that I
already did what you suggested and it didn't work with RDMA.  This is
recall of too many months ago now, but: the client will see the
correct READ payload _except_ IIRC it is offset by whatever front-pad
was added to expand the misaligned DIO; no matter whether
rqstp->rq_bvec updated when IO completes.

But I'll revisit it again.

> >>> NFSD using DIO is optional. I thought the point was to get it as an
> >>> available option so that _others_ could experiment and help categorize
> >>> the benefits/pitfalls further?
> >>
> >> Yes, that is the point. But such experiments lose value if there is no
> >> data collection plan to go with them.
> > 
> > Each user runs something they care about performing well and they
> > measure the result.
> 
> That assumes the user will continue to use the debug interfaces, and
> the particular implementation you've proposed, for the rest of time.
> And that's not my plan at all.
> 
> If we, in the community, cannot reproduce that result, or cannot
> understand what has been measured, or the measurement misses part or
> most of the picture, of what value is that for us to decide whether and
> how to proceed with promoting the mechanism from debug feature to
> something with a long-term support lifetime and a documented ABI-stable
> user interface?

I'll work to put a finer point on how to reproduce and enumerate the
things to look for (representative flamegraphs showing the issue,
which I already did at last Bakeathon).

But I have repeatedly offered that the pathological worst case is
client doing sequential write IO of a file that is 3-4x larger than
the NFS server's system memory.

Large memory systems with 8 or more NVMe devices, fast networks that
allow for huge data ingest capabilities.  These are the platforms that
showcase MM's dirty writeback limitions when large sequential IO is
initiated from the NFS client and its able to overrun the NFS server.

In addition, in general DIO requires significantly less memory and
CPU; so platforms that have more limited resources (and may have
historically struggled) could have a new lease on life if they switch
NFSD from buffered to DIO mode.

> > Literally the same thing as has been done for anything in Linux since
> > it all started.  Nothing unicorn or bespoke here.
> 
> So let me ask this another way: What do we need users to measure to give
> us good quality information about the page cache behavior and system
> thrashing behavior you reported?

IO throughput, CPU and memory usage should be monitored over time.

> For example: I can enable direct I/O on NFSD, but my workload is mostly
> one or two clients doing kernel builds. The latency of NFS READs goes
> up, but since a kernel build is not I/O bound and the client page caches
> hide most of the increase, there is very little to show a measured
> change.
> 
> So how should I assess and report the impact of NFSD doing direct I/O?

Your underwhelming usage isn't what this patchset is meant to help.

> See -- users are not the only ones who are involved in this experiment;
> and they will need guidance because we're not providing any
> documentation for this feature.

Users are not created equal.  Major companies like Oracle and Meta
_should_ be aware of NFSD's problems with buffered IO.  They have
internal and external stakeholders that are power users.

Jeff, does Meta ever see NFSD struggle to consistently use NVMe
devices?  Lumpy performance?  Full-blown IO stalls?  Lots of NFSD
threads hung in D state?

> >> If you would rather make this drive-by, then you'll have to realize
> >> that you are requesting more than simple review from us. You'll have
> >> to be content with the pace at which us overloaded maintainers can get
> >> to the work.
> > 
> > I think I just experienced the mailing-list equivalent of the Detroit
> > definition of "drive-by".  Good/bad news: you're a terrible shot.
> 
> The term "drive-by contribution" has a well-understood meaning in the
> kernel community. If you are unfamiliar with it, I invite you to review
> the mailing list archives. As always, no-one is shooting at you. If
> anything, the drive-by contribution is aimed at me.

It is a blatant miscategorization here. That you just doubled down
on it having relevance in this instance is flagrantly wrong.

Whatever compells you to belittle me and my contributions, just know
it is extremely hard to take. Highly unproductive and unprofessional.

Boom, done.

