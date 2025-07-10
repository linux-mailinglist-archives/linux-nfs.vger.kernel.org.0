Return-Path: <linux-nfs+bounces-12984-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11141B005B4
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 16:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B81E5A26F8
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 14:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A36C2749F6;
	Thu, 10 Jul 2025 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9ZyXl10"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FCF2749C1
	for <linux-nfs@vger.kernel.org>; Thu, 10 Jul 2025 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158887; cv=none; b=e3iYJWkVEsnZ4u+zwMWiubVF8u3l9ysAH3AzLtmuEKvtJc7/A+CP3BEWsb1bzVEmN3CbjbkcTF6aP21u57Kw8BVflz3X2NaoiMc2U8kLpT2DPIfBumNIb1D/eeoXBG07WBMM6J4akY9zynyKkvVvWeY6vRErCP4ziOoiFgQul3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158887; c=relaxed/simple;
	bh=4kdArUE2zfQGk+lYSDnCbURs1/85EHuS+gaZaaPVFyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+oD1ynEVQM+4xdR1tLb5v8uKcbHdueGc9EdMEcFTW52iJYYfSrnq4JEe1QFBQoWPU7pSFpPNynboCkjwZzr9y0bsY4hwiotNlOwYXYqP8lKt5j+Gib0fILqXqO2yZzHZxGxXUUJDk+/Ec+4TEkOsuIBgh4p+JlSl4lVMYq6Tws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9ZyXl10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45502C4CEFA;
	Thu, 10 Jul 2025 14:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752158886;
	bh=4kdArUE2zfQGk+lYSDnCbURs1/85EHuS+gaZaaPVFyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y9ZyXl10A4r+M0H4qFc4/M6cTSX2GJJ1FrfV2z4C/vSLmZx49CQ+h574D2B9VVf/C
	 a/DnGGrnHaCP4Y7MFsK4zD6j6kBqSlJS/SFCX7WXV/l8tivldnwh9NIGGRPoz2IK6A
	 NB1+2BNuqg142QCO7lGUJViYtUn9B4RrpOn15CEZmX/1wpCKND2pXOjODO00qBm01I
	 uGnQEnZDbicAQCfjfkmGxsIqqIpfPvFNsF4WWSo9gmEDfHg5UjxuxBym3FdILZ3E6E
	 ziJWjeyfEpePDtKnobCd0azqPiYFKtDQ8c1z/2RWBh2MYv/x0rOF+7z+R3IW8ooztd
	 a4CPpCEDjoZQQ==
Date: Thu, 10 Jul 2025 08:48:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linus-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	hch@infradead.org
Subject: Re: [RFC PATCH v2 4/8] lib/iov_iter: remove piecewise bvec length
 checking in iov_iter_aligned_bvec
Message-ID: <aG_SpLuUv4EH7fAb@kbusch-mbp>
References: <20250708160619.64800-1-snitzer@kernel.org>
 <20250708160619.64800-5-snitzer@kernel.org>
 <5819d6c5bb194613a14d2dcf05605e701683ba49.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5819d6c5bb194613a14d2dcf05605e701683ba49.camel@kernel.org>

On Thu, Jul 10, 2025 at 09:52:53AM -0400, Jeff Layton wrote:
> On Tue, 2025-07-08 at 12:06 -0400, Mike Snitzer wrote:
> > iov_iter_aligned_bvec() is strictly checking alignment of each element
> > of the bvec to arrive at whether the bvec is aligned relative to
> > dma_alignment and on-disk alignment.  Checking each element
> > individually results in disallowing a bvec that in aggregate is
> > perfectly aligned relative to the provided @len_mask.
> > 
> > Relax the on-disk alignment checking such that it is done on the full
> > extent described by the bvec but still do piecewise checking of the
> > dma_alignment for each bvec's bv_offset.
> > 
> > This allows for NFS's WRITE payload to be issued using O_DIRECT as
> > long as the bvec created with xdr_buf_to_bvec() is composed of pages
> > that respect the underlying device's dma_alignment (@addr_mask) and
> > the overall contiguous on-disk extent is aligned relative to the
> > logical_block_size (@len_mask).
> > 
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  lib/iov_iter.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> > index bdb37d572e97..b2ae482b8a1d 100644
> > --- a/lib/iov_iter.c
> > +++ b/lib/iov_iter.c
> > @@ -819,13 +819,14 @@ static bool iov_iter_aligned_bvec(const struct iov_iter *i, unsigned addr_mask,
> >  	unsigned skip = i->iov_offset;
> >  	size_t size = i->count;
> >  
> > +	if (size & len_mask)
> > +		return false;
> > +
> >  	do {
> >  		size_t len = bvec->bv_len;
> >  
> >  		if (len > size)
> >  			len = size;
> > -		if (len & len_mask)
> > -			return false;
> >  		if ((unsigned long)(bvec->bv_offset + skip) & addr_mask)
> >  			return false;
> >  
> 
> cc'ing Keith too since he wrote this helper originally.

Thanks.

There's a comment in __bio_iov_iter_get_pages that says it expects each
vector to be a multiple of the block size. That makes it easier to
slit when needed, and this patch would allow vectors that break the
current assumption when calculating the "trim" value.

But for nvme, you couldn't split such a bvec into a usable command
anyway. I think you'd have to introduce a different queue limit to check
against when validating iter alignment if you don't want to use the
logical block size. 

