Return-Path: <linux-nfs+bounces-16197-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99614C4180F
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 21:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A07D3B2C7F
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 20:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DD62DCC08;
	Fri,  7 Nov 2025 20:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ey6uaXVO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB5C2D877D
	for <linux-nfs@vger.kernel.org>; Fri,  7 Nov 2025 20:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762545914; cv=none; b=Dq7s05wVmRCjdetk6lp5JkqXqK/EI8049CyG8p9VDtPkJGJhlplIPTSglbMwtjXkUKKJtntNi+tzFHCfn0+ZJFsgHPXShvLhAYA1syzjxDkjBpPIMuGRBZhh7QjMxmVixTIf8sfy3EY3lkCDOVuzjBkFv4XhxufgLAJyqcKX7oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762545914; c=relaxed/simple;
	bh=KSPvH+g+p1/gnQywQ5lmt9n/uYRzQ4EIA0iCEkRMM28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEXR+Ds7RRcDJQHKV0lfUpUIMIMun8HdMG58JASxakajjdF42Z0lHokN54GW5LanB7vBOgTcUIdZ5S/wtncftDIlxMAohL4U909JvkPvwfDvzxMTmkBewVNNaw4cuulYO61cBEEQckYMF8X1d/WtDz/5veaEX6SMBMFJMf7gpr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ey6uaXVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10192C4CEF8;
	Fri,  7 Nov 2025 20:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762545913;
	bh=KSPvH+g+p1/gnQywQ5lmt9n/uYRzQ4EIA0iCEkRMM28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ey6uaXVOzg/rsZCcQgJpXHAWZ7W7jdyn0s22Mne6elAmWDHiunCubbMcoYgULxUrx
	 Y4SEuxZ8kFhuCTqlX4t7XSH4CHq+K2yMxgsCpsNKzByPQ9yR7lZRNlv0E796aKlpnz
	 8NCX/sQo77eRpdelLQUpHbpFElo2Gq/+7aJXzN29sV7+r1MzuJQz/LPx2umWrOwj42
	 oWMQ7I+zKv5Wyy3VJOz/pb8kluEiBuzasGMlb5r3VpXGGEeAvleSkWaL2VzCQ8h+c7
	 OkyFhd5xCFZgZboIavANGHZrnyCuRkM1gt6OwxPQ0obXdVmg4r4gOJx2pu5Ar40nWB
	 6OzQ7Bzd/Nhxg==
Date: Fri, 7 Nov 2025 15:05:11 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v11 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aQ5Q99Kvw0ZE09Th@kernel.org>
References: <20251107153422.4373-1-cel@kernel.org>
 <20251107153422.4373-3-cel@kernel.org>
 <aQ4Sr5M9dk2jGS0D@infradead.org>
 <82be5f47-77df-423d-a4f3-17f83ddb6636@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82be5f47-77df-423d-a4f3-17f83ddb6636@kernel.org>

On Fri, Nov 07, 2025 at 10:40:56AM -0500, Chuck Lever wrote:
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

NFSD_IO_DIRECT's splitting an unaligned WRITE into 3 segments is a
hybrid IO approach that consciously (_from initial design_) leverages
the page cache for the unaligned ends.

1: The ends of an unaligned write are certainly file offset unaligned.
2: The ends are also less than a page so implies unaligned in memory.

Anyway, categorizing the misalignment further enables you to do what
differently?  Any misalignment requires use of buffered IO.

At issue if whether we use DONTCACHE's drop-behind semantic or not.
That drop-behind is clearly unhelpful for the ends of each streaming
unaligned WRITE.

The page cache is beneficial for NFSD_IO_DIRECT's subpage writes on
either end of a DIO aligned middle (at most 2 pages left in page cache
for unaligned IO).  So _not_ using DONTCACHE is a key point of the
hybrid IO model NFSD_IO_DIRECT provides for handling unaligned IO.

> > Either way a tweak to suddenly use cached buffered I/O when the mode
> > asks for direct should have a comment explaining the justification
> > and explain the rationale instead of rushing it in.

Use of cached buffered wasn't sudden or rushing -- it restores a key
original design point of NFSD_IO_DIRECT (from back in July/August).

While I can appreciate your confusion, given NFSD_IO_DIRECT's intent
of avoiding caching, DONTCACHE's ability to preserve the general
"avoid caching" semantic of O_DIRECT is really besides the point
because... NFSD_IO_DIRECT does need to use the page cache for its
unaligned end segments _and_ it actually benefits from page caching.

And I completely agree this needs a comment. Hopefully adding
something like the collowing comment before "return nsegs" in
nfsd_write_dio_iters_init() helps:

/*
 * Normal buffered IO is used for the unaligned prefix/suffix
 * because these subpage writes can benefit from the page cache
 * (e.g. for optimally handling streaming unaligned WRITEs).
 */

> Agreed. The cover letter noted that this is still controversial.

Only see this, must be missing what you're referring to:

  Changes since v9:
  * Unaligned segments no longer use IOCB_DONTCACHE

