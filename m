Return-Path: <linux-nfs+bounces-7294-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B019A4767
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 21:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B909A287DAB
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 19:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E9F204036;
	Fri, 18 Oct 2024 19:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZWdSsXQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114AA20262E
	for <linux-nfs@vger.kernel.org>; Fri, 18 Oct 2024 19:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729280992; cv=none; b=FrCRbERFL0ArAwZ6BrEa9aqxvfTLH6b/RjIemUXOySZ+PyXIA9Occm3357paiXDVHemxqAGE/T+IUx5Ls8dMT37vWp7aLwfy6ChsniUMlHz+tcQ/+RzfXAMPIJjQj1FrJ5eAHxnS/2iak/g8p1bUfO25LyIRZoAZuKT1VsVqrVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729280992; c=relaxed/simple;
	bh=gL8hX7MkSWc1JvnWml2WhlaqVZz1JOi7TXeOBK09AaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cl2Ldq8WXnaD3bWW1VJ/bO0IkoN64husqsKL0LgSSKjlYJWL5m3C0b9M/Zo2qPemlgivihQs7cTDyoUHmGEVXCVsDGmwO13zpIwo7w32ePVpOsNs4ydKuMD8gN+Juq9Jn/dsrKfh4WXmZLAa5WR31donUNGPktCskuD1ZYID828=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZWdSsXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAF3C4CEC3;
	Fri, 18 Oct 2024 19:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729280991;
	bh=gL8hX7MkSWc1JvnWml2WhlaqVZz1JOi7TXeOBK09AaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SZWdSsXQPj/cOFeXLKqytY7yjjYfXAUiZbSg5YeA+ijvEv3FyyWVdy6uO+Pbw4yVR
	 bqY0VLL4pzkN/hCu5U3xsCewqHBaFJ4g4+qVqvb3lOq9KQjMAGMNglUrUNMnVDHHuc
	 fym/fe1ytQ/Yk8geNhKp2ewYCbbzl6n2LzToX+06FYCPbl87S9V0Nh+nDygyQ+e+P/
	 m3qUSrNDlNDU3glw4LSZfUKjsNVWH9w6xMDD/8pv4untycRNmoMtACVWrEd5lwvLcU
	 FvdQ10zDAUtj2nCgYr57eaem0lFEUKFvVHveGR6qohcuCpfVLLLjYzCAM5wsByh88P
	 3M1eKLVe8lFHQ==
Date: Fri, 18 Oct 2024 15:49:50 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: nfs: avoid i_lock contention in nfs_clear_invalid_mapping
Message-ID: <ZxK73l2yAOcLe_jl@kernel.org>
References: <20241018170335.41427-1-snitzer@kernel.org>
 <e25a451540d8eb63f35b82652e197b6e207d4317.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e25a451540d8eb63f35b82652e197b6e207d4317.camel@kernel.org>

On Fri, Oct 18, 2024 at 03:39:13PM -0400, Jeff Layton wrote:
> On Fri, 2024-10-18 at 13:03 -0400, Mike Snitzer wrote:
> > Multi-threaded buffered reads to the same file exposed significant
> > inode spinlock contention in nfs_clear_invalid_mapping().
> > 
> > Eliminate this spinlock contention by checking flags without locking,
> > instead using smp_rmb and smp_load_acquire accordingly, but then take
> > spinlock and double-check these inode flags.
> > 
> > Also refactor nfs_set_cache_invalid() slightly to use
> > smp_store_release() to pair with nfs_clear_invalid_mapping()'s
> > smp_load_acquire().
> > 
> > While this fix is beneficial for all multi-threaded buffered reads
> > issued by an NFS client, this issue was identified in the context of
> > surprisingly low LOCALIO performance with 4K multi-threaded buffered
> > read IO.  This fix dramatically speeds up LOCALIO performance:
> > 
> > before: read: IOPS=1583k, BW=6182MiB/s (6482MB/s)(121GiB/20002msec)
> > after:  read: IOPS=3046k, BW=11.6GiB/s (12.5GB/s)(232GiB/20001msec)
> > 
> > Fixes: 17dfeb911339 ("NFS: Fix races in nfs_revalidate_mapping")
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfs/inode.c | 19 ++++++++++++++-----
> >  1 file changed, 14 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> > index 542c7d97b235..130d7226b12a 100644
> > --- a/fs/nfs/inode.c
> > +++ b/fs/nfs/inode.c
> > @@ -205,12 +205,14 @@ void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
> >  		nfs_fscache_invalidate(inode, 0);
> >  	flags &= ~NFS_INO_REVAL_FORCED;
> >  
> > -	nfsi->cache_validity |= flags;
> > +	if (inode->i_mapping->nrpages == 0)
> > +		flags &= ~NFS_INO_INVALID_DATA;
> >  
> > -	if (inode->i_mapping->nrpages == 0) {
> > -		nfsi->cache_validity &= ~NFS_INO_INVALID_DATA;
> > -		nfs_ooo_clear(nfsi);
> > -	} else if (nfsi->cache_validity & NFS_INO_INVALID_DATA) {
> > +	/* pairs with nfs_clear_invalid_mapping()'s smp_load_acquire() */
> > +	smp_store_release(&nfsi->cache_validity, flags);
> > +
> 
> I don't know this code that well, but it used to do an |= of flags into
> cache_validity. Now you're replacing cache_validity wholesale with
> flags. Maybe that should do something like this?
> 
>     flags |= nfsi->cache_validity;
>     smp_store_release(&nfsi->cache_validity, flags);

Ah good catch, sorry about that, will fix.

This will allow further cleanup too, will let v2 speak to that.

Thanks!
Mike

