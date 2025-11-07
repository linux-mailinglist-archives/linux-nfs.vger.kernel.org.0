Return-Path: <linux-nfs+bounces-16203-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29852C41CCD
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 23:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D223A6FF5
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 22:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6019D2F7AD0;
	Fri,  7 Nov 2025 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcfAuqTV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE382D3A6D
	for <linux-nfs@vger.kernel.org>; Fri,  7 Nov 2025 22:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762553789; cv=none; b=kyGXjPYd7oXqFXxumST7flj4eGDqICXqYZd/GnLN77eQyD/7v2seJnh57bsm0dby3lIeAuWjey+gOTPgRoeIwb+BLVb9TS9tALhB4F31OPvnBBH+o5fATF/tLRu12DiyjxUdhrdWnkzg2c15TgnFNrP+TauZBS4T4j3iZe4QLYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762553789; c=relaxed/simple;
	bh=rBRoj/aMMQrpXAGJ/tzjTFWDA5rhNLcQufhMjlVjwlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYmy6rjYVaLF3lRtXVdeCRM3VaE6QAl2aQjBEsqA5cgp7adQP91AHP+EospGq0Qm+mVQELfsqtLhyeS0+8ijDLn0gw6weBnksMeOazZI6NQxxe5OYHuR0+CQZECyKxdmtKXiMUfk5Gbr6r4LYQf+YFEbp5HXKv9WGuM/qj5CCqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcfAuqTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856AEC16AAE;
	Fri,  7 Nov 2025 22:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762553788;
	bh=rBRoj/aMMQrpXAGJ/tzjTFWDA5rhNLcQufhMjlVjwlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tcfAuqTVmfyaV/xLCnRAbz8DB5ADwkKV5No9eGU0RVW+FcQ82TqE9Uk5SgamGtmZX
	 QAr+S+6jZ3ZummHvT/ccLtY/jTwUp0yH/tMBuxa7viZo0ZmSBLEev3r3LYnyl74z43
	 iZq1G3mTMGj+XZ6c0MxPrAM+pr6wHVJpH3F2hHgGznzVMbAibwjBNubQoI2NnPcHjp
	 2UmkRmiupXg4E8sUu0bSnecQar1MVlHq/hqNWzA92spxzXj0HzFvZ0nDcZUEvJMXIP
	 I0+jhoCRMMeFgF9CR3GSfkJze6NbOyUDcDkH2r6LcYg6w8Wwc+GxW/AtveLjeLK8/C
	 VtQBDKxFKCsTg==
Date: Fri, 7 Nov 2025 17:16:27 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v11 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aQ5vu47II-ZiFsmt@kernel.org>
References: <20251107153422.4373-1-cel@kernel.org>
 <20251107153422.4373-3-cel@kernel.org>
 <aQ4Sr5M9dk2jGS0D@infradead.org>
 <4714c5d0-cc40-4442-a8af-7f29cbb1b35d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4714c5d0-cc40-4442-a8af-7f29cbb1b35d@kernel.org>

On Fri, Nov 07, 2025 at 03:28:06PM -0500, Chuck Lever wrote:
> On 11/7/25 10:39 AM, Christoph Hellwig wrote:
> > On Fri, Nov 07, 2025 at 10:34:21AM -0500, Chuck Lever wrote:
> >> +no_dio:
> >> +	/*
> >> +	 * No DIO alignment possible - pack into single non-DIO segment.
> >> +	 * IOCB_DONTCACHE preserves the intent of NFSD_IO_DIRECT.
> >> +	 */
> >> +	nfsd_write_dio_seg_init(&segments[0], bvec, nvecs, total, 0,
> >> +				total, iocb);
> > 
> > I'd like to sort out the discussion on why to set IOCB_DONTCACHE when
> > nothing is aligned, but not for the non-aligned parts as that is
> > extremely counter-intuitive.  From the other thread it might be because
> > the test case used to justify it is very unaligned and caching partial
> > pages is helpful, but if that is indeed the case the right check would
> > be for writes that are file offset unaligned vs the page or max folio
> > size and not about being able to do parts of it as direct I/O.
> > 
> > Either way a tweak to suddenly use cached buffered I/O when the mode
> > asks for direct should have a comment explaining the justification
> > and explain the rationale instead of rushing it in.
> 
> +1 for an explanatory comment, but I'm not getting what is "counter-
> intuitive" about leaving the content of the end segments in the page
> cache. The end segments are small and simply cannot be handled by direct
> I/O.
> 
> I raised a similar concern about whether NFSD needs to care about highly
> unaligned NFS WRITE requests performing well. I'm not convinced that a
> performance argument is an appropriate rationale for not using
> DONTCACHE on the ends.

Those ends lend themselves to benefitting from more capable RMW
if/when needed.  All it takes to justify not using DONTCACHE is one
workload that benefits (even if suboptimal by nature) given there is
no apparent downside (other than requiring we document/comment the
behavior).

Or is this something we make tunable?
NFSD_IO_DIRECT_DONTCACHE_UNALIGNED?

I don't think it needed but maybe ultra small systems with next to no
memory that must not use memory at all costs (including performance)?
Maybe we wait until someone asks for that? ;)

> Upshot is I'm on the fence here; I can see both sides of this
> controversy.

NFSD_IO_DIRECT using cached buffered in this subpage write case makes
enabling NFSD_IO_DIRECT by default more acceptable _because_ it
doesn't cause needless performance problems (that we know of).

Streaming misaligned WRITEs is the only workload I'm aware of where
NFSD_IO_DIRECT can be made noticably worse in comparison to
NFSD_IO_BUFFERED (but I haven't done a bucnh of small IO testing).
That's a pretty good place for NFSD_IO_DIRECT given the fix is a
really straightforward tradeoff decision.

The MM subsystem handles order-0 page allocation and reclaim really
well, making NFSD_IO_DIRECT's 3 segment hybrid IO model quite capable
even though we hope applications don't force NFSD to use it (meaning
the client application takes care to send DIO-aligned IO).

