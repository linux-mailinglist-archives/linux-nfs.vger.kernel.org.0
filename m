Return-Path: <linux-nfs+bounces-13919-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61215B38EFB
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 01:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 194FA17060C
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Aug 2025 23:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1896B3112A1;
	Wed, 27 Aug 2025 23:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gg2bNUva"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B8F30F932
	for <linux-nfs@vger.kernel.org>; Wed, 27 Aug 2025 23:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756336509; cv=none; b=CuIBVcsdZH8QKgDMb9OzVPVbeq/mP6N/SlNZJq3LlyNe/PtQaPojjMFWFqbdRETLgSMuPmSCbvEk0Xua8xhEI4AkLdFqk0oCC6Hqd+XKTwFbsnAWCqE76dl6GCZior3+i6kw87ykOybu0gWxJZ+EQBHBdwL/zo1rX9ZJOtB5S8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756336509; c=relaxed/simple;
	bh=YQMJdgTOSQXhaaO9gtWk9Kr7XjIOdK6Ar+Im7ZOiJKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMsBSd9LFLxpN+a1D+Y9iVhzNq4jRhSHlGTBxsk2OX+91rY9oHUqPuelpzrbfPAj50x/N3iLGIDwDzvh+mYIsVeeLJF136QEzodVXCc2ZxcFxuLqM6jls6Gm39uX/Up+1OrqjOaJfHozjgpHfi2rA6kPhki6OIpsTfMH0s98Z40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gg2bNUva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C70AC4CEEB;
	Wed, 27 Aug 2025 23:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756336507;
	bh=YQMJdgTOSQXhaaO9gtWk9Kr7XjIOdK6Ar+Im7ZOiJKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gg2bNUva0BSWLahdKMZrBz5V4jgIdSSaOwibNB/yurZVF7AEt9j0NwUBXT6mrjoiS
	 IRzjFlzBVtkb8aAZAL5kmq6WKd8q6Zhv3t+wpNhvGxeA82SGx/byy2W6H0v0CCbsAZ
	 lg++bNtr79qTX2h1YK5EEUBe1dq8w0aYchXI8/cJ9SI709ActFXxMNZ9iWMakQgI5Z
	 dCsBi7WfFQpwCpMDwHht2tbnPJwzutTpbWHQB07ihhonvLWP1dYpOu/pVHYqSnbDFk
	 wAzNHV57CTGPv7f9bmKfHoOduja8Vg4htkB4LMb5X+GAeSxv1IUjP0EBRpGvZFTI6N
	 CjwqSb/ogcYxw==
Date: Wed, 27 Aug 2025 19:15:06 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v8 5/7] NFSD: issue READs using O_DIRECT even if IO is
 misaligned
Message-ID: <aK-Reg6g8ccscwMu@kernel.org>
References: <20250826185718.5593-1-snitzer@kernel.org>
 <20250826185718.5593-6-snitzer@kernel.org>
 <f7aee927-e4fc-44da-a2b6-7fd90f90d90e@oracle.com>
 <aK9fZR7pQxrosEfW@kernel.org>
 <6f5516a5-1954-4f77-8a07-dacba1fb570c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f5516a5-1954-4f77-8a07-dacba1fb570c@oracle.com>

On Wed, Aug 27, 2025 at 04:56:08PM -0400, Chuck Lever wrote:
> On 8/27/25 3:41 PM, Mike Snitzer wrote:
> > On Wed, Aug 27, 2025 at 11:34:03AM -0400, Chuck Lever wrote:
> >> On 8/26/25 2:57 PM, Mike Snitzer wrote:
> 
> >>> +	if (WARN_ONCE(!nf->nf_dio_mem_align || !nf->nf_dio_read_offset_align,
> >>> +		      "%s: underlying filesystem has not provided DIO alignment info\n",
> >>> +		      __func__))
> >>> +		return false;
> >>> +	if (WARN_ONCE(dio_blocksize > PAGE_SIZE,
> >>> +		      "%s: underlying storage's dio_blocksize=%u > PAGE_SIZE=%lu\n",
> >>> +		      __func__, dio_blocksize, PAGE_SIZE))
> >>> +		return false;
> >>
> >> IMHO these checks do not warrant a WARN. Perhaps a trace event, instead?
> > 
> > I won't die on this hill, I just don't see the risk of these given
> > they are highly unlikely ("famous last words").
> > 
> > But if they trigger we should surely be made aware immediately.  Not
> > only if someone happens to have a trace event enabled (which would
> > only happen with further support and engineering involvement to chase
> > "why isn't O_DIRECT being used like NFSD was optionally configured
> > to!?").
> A. It seems particularly inefficient to make this check for every I/O
>    rather than once per file system
> 
> B. Once the warning has fired for one file, it won't fire again, making
>    it pretty useless if there are multiple similar mismatches. You still
>    end up with "No direct I/O even though I flipped the switch, and I
>    can't tell why."

I've removed the WARN_ON_ONCEs for read and write.  These repeat
per-IO negative checks aren't ideal but they certainly aren't costly.

> >>> +	/* Return early if IO is irreparably misaligned (len < PAGE_SIZE,
> >>> +	 * or base not aligned).
> >>> +	 * Ondisk alignment is implied by the following code that expands
> >>> +	 * misaligned IO to have a DIO-aligned offset and len.
> >>> +	 */
> >>> +	if (unlikely(len < dio_blocksize) || ((base & (nf->nf_dio_mem_align-1)) != 0))
> >>> +		return false;
> >>> +
> >>> +	init_nfsd_read_dio(read_dio);
> >>> +
> >>> +	read_dio->start = round_down(offset, dio_blocksize);
> >>> +	read_dio->end = round_up(orig_end, dio_blocksize);
> >>> +	read_dio->start_extra = offset - read_dio->start;
> >>> +	read_dio->end_extra = read_dio->end - orig_end;
> >>> +
> >>> +	/*
> >>> +	 * Any misaligned READ less than NFSD_READ_DIO_MIN_KB won't be expanded
> >>> +	 * to be DIO-aligned (this heuristic avoids excess work, like allocating
> >>> +	 * start_extra_page, for smaller IO that can generally already perform
> >>> +	 * well using buffered IO).
> >>> +	 */
> >>> +	if ((read_dio->start_extra || read_dio->end_extra) &&
> >>> +	    (len < NFSD_READ_DIO_MIN_KB)) {
> >>> +		init_nfsd_read_dio(read_dio);
> >>> +		return false;
> >>> +	}
> >>> +
> >>> +	if (read_dio->start_extra) {
> >>> +		read_dio->start_extra_page = alloc_page(GFP_KERNEL);
> >>
> >> This introduces a page allocation where there weren't any before. For
> >> NFSD, I/O pages come from rqstp->rq_pages[] so that memory allocation
> >> like this is not needed on an I/O path.
> > 
> > NFSD never supported DIO before. Yes, with this patch there is
> > a single page allocation in the misaligned DIO READ path (if it
> > requires reading extra before the client requested data starts).
> > 
> > I tried to succinctly explain the need for the extra page allocation
> > for misaligned DIO READ in this patch's header (in 2nd paragraph
> > of the above header).
> > 
> > I cannot see how to read extra, not requested by the client, into the
> > head of rq_pages without causing serious problems. So that cannot be
> > what you're saying needed.
> > 
> >> So I think the answer to this is that I want you to implement reading
> >> an entire aligned range from the file and then forming the NFS READ
> >> response with only the range of bytes that the client requested, as we
> >> discussed before.
> > 
> > That is what I'm doing. But you're taking issue with my implementation
> > that uses a single extra page.
> > 
> >> The use of xdr_buf and bvec should make that quite
> >> straightforward.
> > 
> > Is your suggestion to, rather than allocate a disjoint single page,
> > borrow the extra page from the end of rq_pages? Just map it into the
> > bvec instead of my extra page?
> 
> Yes, the extra page needs to come from rq_pages. But I don't see why it
> should come from the /end/ of rq_pages.
> 
> - Extend the start of the byte range back to make it align with the
>   file's DIO alignment constraint
> 
> - Extend the end of the byte range forward to make it align with the
>   file's DIO alignment constraint

nfsd_analyze_read_dio() does that (start_extra and end_extra).

> - Fill in the sink buffer's bvec using pages from rq_pages, as usual
> 
> - When the I/O is complete, adjust the offset in the first bvec entry
>   forward by setting a non-zero page offset, and adjust the returned
>   count downward to match the requested byte count from the client

Tried it long ago, such bvec manipulation only works when not using
RDMA.  When the memory is remote, twiddling a local bvec isn't going
to ensure the correct pages have the correct data upon return to the
client.

RDMA is why the pages must be used in-place, and RDMA is also why
the extra page needed by this patch (for use as throwaway front-pad
for expanded misaligned DIO READ) must either be allocated _or_
hopefully it can be from rq_pages (after the end of the client
requested READ payload).

Or am I wrong and simply need to keep learning about NFSD's IO path?

> > NFSD using DIO is optional. I thought the point was to get it as an
> > available option so that _others_ could experiment and help categorize
> > the benefits/pitfalls further?
> 
> Yes, that is the point. But such experiments lose value if there is no
> data collection plan to go with them.

Each user runs something they care about performing well and they
measure the result.

Literally the same thing as has been done for anything in Linux since
it all started.  Nothing unicorn or bespoke here.

> If you would rather make this drive-by, then you'll have to realize
> that you are requesting more than simple review from us. You'll have
> to be content with the pace at which us overloaded maintainers can get
> to the work.

I think I just experienced the mailing-list equivalent of the Detroit
definition of "drive-by".  Good/bad news: you're a terrible shot.

