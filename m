Return-Path: <linux-nfs+bounces-7586-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC879B6D3B
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 21:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734F61F2180D
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 20:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E0D1990C9;
	Wed, 30 Oct 2024 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdsxyHH1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB1A1BD9D8
	for <linux-nfs@vger.kernel.org>; Wed, 30 Oct 2024 20:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730318609; cv=none; b=q5TI6OJmXYNjdCY4rFUwFmtIsssPvMaxpFcM6y0vJyl2QRynX/bNq35hvfGsHRxixp+9Sc6q+VmB7fqqt35uMpUidSSJhURfL5zYky4P623TQNGGwM7eqUzmgeeBNT+dETDfZYKMtWJETzrAxMeoRBXFY+yrtF2som1uT6SI/Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730318609; c=relaxed/simple;
	bh=2xCyxN/t2qwjcz6dF4mFS09jOQFe2hoHep0ti7VJ6k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifBvYeFWzmi0Egp320scFPrf0UyF4U5RKC3YoBTK8Wm5K57b5freRB+JudLcagtFatGUY2sTU0jNONNa8nk5xH/8AgE6vGrUlVk10a6IK3rA47lfqtA9LWsiBR2MOrlJCqWpiF1cdojWA54K9sz9FIio2xrrUgrq4NGh1x2H97M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdsxyHH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8443FC4CECE;
	Wed, 30 Oct 2024 20:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730318605;
	bh=2xCyxN/t2qwjcz6dF4mFS09jOQFe2hoHep0ti7VJ6k0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TdsxyHH1ehudI29utXlLBrjIJ9S1rShR5L+9AtYDkyLYE2mH+1SLbTbF/bUNzgibH
	 VimucM/0wVfc5FHCpkbINK2vtMlkSAktJNXFoeTd7qHc6sfXSKxlLCQ1Qm+ZwO0myI
	 H6J4dhwi7tiq9VHV/RjPOrfiXQY3JCLgaRXrHsZ+vlNGH3XZ4Y3jiKbrS2wE0128BB
	 o3Hf/0Ix0GoG7g/Ww34XSZ4yIBa4xDHWI0PIRrQgjSH8EBrnw8HjaTb8LRQRoOnTg0
	 XwZW0+eIVIlem1Dy7S2Q4LtxKOIwb1dY1A4wS7hpB/65csG4NHsQaZoInHrqHzs3k3
	 QGKelPWSUwdiw==
Date: Wed, 30 Oct 2024 16:03:24 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: nfs: avoid i_lock contention in nfs_clear_invalid_mapping
Message-ID: <ZyKRDKeAd0m19pt_@kernel.org>
References: <20241018170335.41427-1-snitzer@kernel.org>
 <e25a451540d8eb63f35b82652e197b6e207d4317.camel@kernel.org>
 <ZxK73l2yAOcLe_jl@kernel.org>
 <ZxLVDC_C2CrWvXT7@kernel.org>
 <bedccb42-4e8a-4b9c-a0d4-982abb7a318e@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bedccb42-4e8a-4b9c-a0d4-982abb7a318e@oracle.com>

On Wed, Oct 30, 2024 at 03:51:44PM -0400, Anna Schumaker wrote:
> Hi Mike,
> 
> On 10/18/24 5:37 PM, Mike Snitzer wrote:
> > On Fri, Oct 18, 2024 at 03:49:50PM -0400, Mike Snitzer wrote:
> >> On Fri, Oct 18, 2024 at 03:39:13PM -0400, Jeff Layton wrote:
> >>> On Fri, 2024-10-18 at 13:03 -0400, Mike Snitzer wrote:
> >>>> Multi-threaded buffered reads to the same file exposed significant
> >>>> inode spinlock contention in nfs_clear_invalid_mapping().
> >>>>
> >>>> Eliminate this spinlock contention by checking flags without locking,
> >>>> instead using smp_rmb and smp_load_acquire accordingly, but then take
> >>>> spinlock and double-check these inode flags.
> >>>>
> >>>> Also refactor nfs_set_cache_invalid() slightly to use
> >>>> smp_store_release() to pair with nfs_clear_invalid_mapping()'s
> >>>> smp_load_acquire().
> >>>>
> >>>> While this fix is beneficial for all multi-threaded buffered reads
> >>>> issued by an NFS client, this issue was identified in the context of
> >>>> surprisingly low LOCALIO performance with 4K multi-threaded buffered
> >>>> read IO.  This fix dramatically speeds up LOCALIO performance:
> >>>>
> >>>> before: read: IOPS=1583k, BW=6182MiB/s (6482MB/s)(121GiB/20002msec)
> >>>> after:  read: IOPS=3046k, BW=11.6GiB/s (12.5GB/s)(232GiB/20001msec)
> >>>>
> >>>> Fixes: 17dfeb911339 ("NFS: Fix races in nfs_revalidate_mapping")
> >>>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> >>>> ---
> >>>>  fs/nfs/inode.c | 19 ++++++++++++++-----
> >>>>  1 file changed, 14 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> >>>> index 542c7d97b235..130d7226b12a 100644
> >>>> --- a/fs/nfs/inode.c
> >>>> +++ b/fs/nfs/inode.c
> >>>> @@ -205,12 +205,14 @@ void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
> >>>>  		nfs_fscache_invalidate(inode, 0);
> >>>>  	flags &= ~NFS_INO_REVAL_FORCED;
> >>>>  
> >>>> -	nfsi->cache_validity |= flags;
> >>>> +	if (inode->i_mapping->nrpages == 0)
> >>>> +		flags &= ~NFS_INO_INVALID_DATA;
> >>>>  
> >>>> -	if (inode->i_mapping->nrpages == 0) {
> >>>> -		nfsi->cache_validity &= ~NFS_INO_INVALID_DATA;
> >>>> -		nfs_ooo_clear(nfsi);
> >>>> -	} else if (nfsi->cache_validity & NFS_INO_INVALID_DATA) {
> >>>> +	/* pairs with nfs_clear_invalid_mapping()'s smp_load_acquire() */
> >>>> +	smp_store_release(&nfsi->cache_validity, flags);
> >>>> +
> >>>
> 
> I'm having some issues with non-localio NFS after applying this patch:
> 
> - cthon basic tests fail with NFS v3
> - cthon general tests fail with NFS v4.1 and v4.2
> - xfstests generic/080, generic/472, generic/615, and generic/633 fail with NFS v4.1 and v4.2
> - xfstests generic/683, and generic/684 fail with NFS v4.2
> 
> I think the problem is the call to smp_store_release(). It's overwriting nfsi->cache_validity
> with the value of 'flags', losing anything set there but not in 'flags'. Could we instead do
> something like:
>    smp_store_release(&nfsi->cache_validity, nfsi->cache_validity | flags)
> ?
> 
> Anna

Hi,

v2 addressed this issue like Jeff suggested with:

> >>>
> >>>     flags |= nfsi->cache_validity;
> >>>     smp_store_release(&nfsi->cache_validity, flags);
> >>
> >> Ah good catch, sorry about that, will fix.

I think you must not be using v2?

https://lore.kernel.org/all/20241018211541.42705-1-snitzer@kernel.org/

Jeff also provided his Reviewed-by for v2.

If you are using v2 that'll be weird (because I'm not seeing any
issues with xfstests, etc).

Thanks,
Mike

