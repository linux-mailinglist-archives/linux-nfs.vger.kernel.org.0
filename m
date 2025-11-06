Return-Path: <linux-nfs+bounces-16141-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58739C3C95B
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 17:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEFCB4E100B
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 16:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BA72BFC60;
	Thu,  6 Nov 2025 16:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORLVvnjY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014FD226D1D
	for <linux-nfs@vger.kernel.org>; Thu,  6 Nov 2025 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447735; cv=none; b=EFmu58EaRlqr+syENlvB2U0TwOEYs4Z7Ih7/+091jXfK3aBHbiHHe6UnV6s63NstjLP9OmEi29w2jPHg4c6kcxR0j0vZnp68pzO45XLzWkGL/TjJAso5nT2G+tWsGyBg9OkQprTPWdkIKTYSoiv4rwRJZwr6y3gqtrgrdLC+XIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447735; c=relaxed/simple;
	bh=gBBMqcjAfgzDftnEyht7woQ2LwZg6GoGro+KgxCazsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMB5z30GaTfUGs7R6rEpkzbzy72lCIG9nqyPGKlF138azI89cly4SmctvobtaMxCj+bZzoqWxa1npRxAJix3i212ZyTTjWiHNhDk8j7XXtFqr4HXMHp7ONV8cGoRS+wY5A0/jH9VRziXENtGDxU2UgmBC+OtMHVjMr/FX7yP8xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORLVvnjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9A7C116B1;
	Thu,  6 Nov 2025 16:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762447734;
	bh=gBBMqcjAfgzDftnEyht7woQ2LwZg6GoGro+KgxCazsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ORLVvnjY+O6EOHvDKevOROQorWelCZ5zNt+rmxXDPAzbGmw/fvM2m3dYwVxS9FeeV
	 tW8Uj+wVfZP2Zkb+a6Jqu/OTYkRHgXCkv8UlrA3Da7nRf5smQmb7j92PCgdWPO6ZYI
	 EDwrVq5Y71J6JfKHqq5xBNxph2u/KuSgguyGMboalkX4SPpyJwfMO/kS4A+h2nyBdE
	 gxFxY2pfgp9mIDcnYZOmUkKP1JOgGjs8IEmRzF4SGN8LfKMk4WlL4FxtcGugsa3gWY
	 lj2LSYsOxcxJrFJUe3aL1eBTQQe7TMGu6YpCjumM2ArZE2/ysqm/IpgcsaehS42Dqj
	 c7mo4Nw4zbM8g==
Date: Thu, 6 Nov 2025 11:48:53 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: NeilBrown <neil@brown.name>, Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v10 4/5] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aQzRdTcyc2nhTWqj@kernel.org>
References: <20251105192806.77093-1-cel@kernel.org>
 <20251105192806.77093-5-cel@kernel.org>
 <176242391124.634289.8771352649615589358@noble.neil.brown.name>
 <aQyfgfWu8kPfe1uA@infradead.org>
 <aQyn-_GSL_z3a9to@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQyn-_GSL_z3a9to@infradead.org>

On Thu, Nov 06, 2025 at 05:51:55AM -0800, Christoph Hellwig wrote:
> On Thu, Nov 06, 2025 at 05:15:45AM -0800, Christoph Hellwig wrote:
> > On Thu, Nov 06, 2025 at 09:11:51PM +1100, NeilBrown wrote:
> > > > +struct nfsd_write_dio_seg {
> > > > +	struct iov_iter			iter;
> > > > +	bool				use_dio;
> > > 
> > > This is only used to choose which flags to use.
> > > I think it would be neater the have 'flags' here explicitly.
> > 
> > Actually, looking at the grand unified patch now (thanks, this is so
> > much easier to review!), we can just do away with the struct entirely.
> > Just have nfsd_write_dio_iters_init return if direct I/O is possible
> > or not, and do a single vfs_iocb_iter_write on the origin kiocb/iter
> > if not.
> 
> That didn't work out too well, and indeed having flags here seems
> saner.
> 
> Chuck, below is an untested incremental patch I did while reviewing
> it.  Besides this flags thing, it adds the actual NFSD_IO_DIRECT
> definition that was missing, but otherwise mostly just folds things
> so that we don't need the extra args structure and thus simplifies
> things quite a bit.
> 
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index ea87b42894dd..bdb60ee1f1a4 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -157,6 +157,7 @@ enum {
>  	/* Any new NFSD_IO enum value must be added at the end */
>  	NFSD_IO_BUFFERED,
>  	NFSD_IO_DONTCACHE,
> +	NFSD_IO_DIRECT,
>  };
>  
>  extern u64 nfsd_io_cache_read __read_mostly;
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index bb94da333d50..8038d8d038f3 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1170,56 +1170,38 @@ static int wait_for_concurrent_writes(struct file *file)
>  
>  struct nfsd_write_dio_seg {
>  	struct iov_iter			iter;
> -	bool				use_dio;
> +	int				flags;
>  };
>  
> -struct nfsd_write_dio_args {
> -	struct nfsd_file		*nf;
> -	int				flags_buffered;
> -	int				flags_direct;
> -	unsigned int			nsegs;
> -	struct nfsd_write_dio_seg	segment[3];
> -};
> -
> -/*
> - * Check if the bvec iterator is aligned for direct I/O.
> - *
> - * bvecs generated from RPC receive buffers are contiguous: After the first
> - * bvec, all subsequent bvecs start at bv_offset zero (page-aligned).
> - * Therefore, only the first bvec is checked.
> - */
> -static bool
> -nfsd_iov_iter_aligned_bvec(const struct nfsd_file *nf, const struct iov_iter *i)
> +static unsigned long iov_iter_bvec_offset(const struct iov_iter *iter)
>  {
> -	unsigned int addr_mask = nf->nf_dio_mem_align - 1;
> -	const struct bio_vec *bvec = i->bvec;
> -
> -	return ((unsigned long)(bvec->bv_offset + i->iov_offset) & addr_mask) == 0;
> +	return (unsigned long)(iter->bvec->bv_offset + iter->iov_offset);
>  }
>  

This ^ being factored out and documented like was before is better
than the result of this patch, which then spreads the associated
documentation into the caller.

>  static void
>  nfsd_write_dio_seg_init(struct nfsd_write_dio_seg *segment,
>  			struct bio_vec *bvec, unsigned int nvecs,
> -			unsigned long total, size_t start, size_t len)
> +			unsigned long total, size_t start, size_t len,
> +			struct kiocb *iocb)
>  {
>  	iov_iter_bvec(&segment->iter, ITER_SOURCE, bvec, nvecs, total);
>  	if (start)
>  		iov_iter_advance(&segment->iter, start);
>  	iov_iter_truncate(&segment->iter, len);
> -	segment->use_dio = false;
> +	segment->flags = iocb->ki_flags;
>  }
>  
> -static void
> -nfsd_write_dio_iters_init(struct bio_vec *bvec, unsigned int nvecs,
> -			  loff_t offset, unsigned long total,
> -			  struct nfsd_write_dio_args *args)
> +static unsigned int
> +nfsd_write_dio_iters_init(struct nfsd_file *nf, struct bio_vec *bvec,
> +		unsigned int nvecs, struct kiocb *iocb, unsigned long total,
> +		struct nfsd_write_dio_seg segments[3])
>  {
> -	u32 offset_align = args->nf->nf_dio_offset_align;
> -	u32 mem_align = args->nf->nf_dio_mem_align;
> +	u32 offset_align = nf->nf_dio_offset_align;
> +	u32 mem_align = nf->nf_dio_mem_align;
> +	loff_t offset = iocb->ki_pos;
>  	loff_t prefix_end, orig_end, middle_end;
>  	size_t prefix, middle, suffix;
> -
> -	args->nsegs = 0;
> +	unsigned int nsegs = 0;
>  
>  	/*
>  	 * Check if direct I/O is feasible for this write request.
> @@ -1242,87 +1224,80 @@ nfsd_write_dio_iters_init(struct bio_vec *bvec, unsigned int nvecs,
>  	if (!middle)
>  		goto no_dio;
>  
> -	if (prefix) {
> -		nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec,
> -					nvecs, total, 0, prefix);
> -		++args->nsegs;
> -	}
> +	if (prefix)
> +		nfsd_write_dio_seg_init(&segments[nsegs++], bvec,
> +					nvecs, total, 0, prefix, iocb);
>  
> -	nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec, nvecs,
> -				total, prefix, middle);
> -	if (!nfsd_iov_iter_aligned_bvec(args->nf,
> -					&args->segment[args->nsegs].iter))
> +	nfsd_write_dio_seg_init(&segments[nsegs], bvec, nvecs,
> +				total, prefix, middle, iocb);
> +
> +	/*
> +	 * Check if the bvec iterator is aligned for direct I/O.
> +	 *
> +	 * bvecs generated from RPC receive buffers are contiguous: After the
> +	 * first bvec, all subsequent bvecs start at bv_offset zero
> +	 * (page-aligned).
> +	 * Therefore, only the first bvec is checked.
> +	 */
> +	if (iov_iter_bvec_offset(&segments[nsegs].iter) & (mem_align - 1))
>  		goto no_dio;
> -	args->segment[args->nsegs].use_dio = true;
> -	++args->nsegs;
> +	segments[nsegs].flags |= IOCB_DIRECT;
> +	nsegs++;
>  
> -	if (suffix) {
> -		nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec,
> -					nvecs, total, prefix + middle, suffix);
> -		++args->nsegs;
> -	}
> +	if (suffix)
> +		nfsd_write_dio_seg_init(&segments[nsegs++], bvec,
> +					nvecs, total, prefix + middle, suffix,
> +					iocb);
>  
> -	return;
> +	return nsegs;
>  
>  no_dio:
>  	/*
>  	 * No DIO alignment possible - pack into single non-DIO segment.
> -	 * IOCB_DONTCACHE preserves the intent of NFSD_IO_DIRECT.
>  	 */
> -	if (args->nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
> -		args->flags_buffered |= IOCB_DONTCACHE;
> -	nfsd_write_dio_seg_init(&args->segment[0], bvec, nvecs, total,
> -				0, total);
> -	args->nsegs = 1;
> +	nfsd_write_dio_seg_init(&segments[0], bvec, nvecs, total,
> +				0, total, iocb);
> +	return 1;
>  }

Selectively pushing the flag twiddling out to nfsd_direct_write()
ignores that we don't want to use DONTCACHE for the unaligned
prefix/suffix. Chuck and I discussed this a fair bit 1-2 days ago.

> -static int
> -nfsd_issue_dio_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		     struct kiocb *kiocb, unsigned int nvecs,
> -		     unsigned long *cnt, struct nfsd_write_dio_args *args)
> +static noinline_for_stack int
> +nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +		  struct nfsd_file *nf, unsigned int nvecs,
> +		  unsigned long *cnt, struct kiocb *kiocb)
>  {
> -	struct file *file = args->nf->nf_file;
> +	struct file *file = nf->nf_file;
> +	struct nfsd_write_dio_seg segments[3];
> +	unsigned int nsegs = 0, i;
>  	ssize_t host_err;
> -	unsigned int i;
>  
> -	nfsd_write_dio_iters_init(rqstp->rq_bvec, nvecs, kiocb->ki_pos,
> -				  *cnt, args);
> +	nsegs = nfsd_write_dio_iters_init(nf, rqstp->rq_bvec, nvecs,
> +			kiocb, *cnt, segments);
>  
>  	*cnt = 0;
> -	for (i = 0; i < args->nsegs; i++) {
> -		if (args->segment[i].use_dio) {
> -			kiocb->ki_flags = args->flags_direct;
> +	for (i = 0; i < nsegs; i++) {
> +		kiocb->ki_flags = segments[i].flags;
> +		if (kiocb->ki_flags & IOCB_DIRECT) {
>  			trace_nfsd_write_direct(rqstp, fhp, kiocb->ki_pos,
> -						args->segment[i].iter.count);
> -		} else
> -			kiocb->ki_flags = args->flags_buffered;
> +						segments[i].iter.count);
> +		} else if (nf->nf_file->f_op->fop_flags & FOP_DONTCACHE) {
> +			/*
> +			 * IOCB_DONTCACHE preserves the intent of
> +			 * NFSD_IO_DIRECT.
> +			 */
> +			kiocb->ki_flags |= IOCB_DONTCACHE;
> +		}

So this FOP_DONTCACHE branch needs to stay in
nfsd_write_dio_iters_init() no_dio: section.

>  
> -		host_err = vfs_iocb_iter_write(file, kiocb,
> -					       &args->segment[i].iter);
> +		host_err = vfs_iocb_iter_write(file, kiocb, &segments[i].iter);
>  		if (host_err < 0)
>  			return host_err;
>  		*cnt += host_err;
> -		if (host_err < args->segment[i].iter.count)
> +		if (host_err < segments[i].iter.count)
>  			break;	/* partial write */
>  	}
>  
>  	return 0;
>  }
>  
> -static noinline_for_stack int
> -nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		  struct nfsd_file *nf, unsigned int nvecs,
> -		  unsigned long *cnt, struct kiocb *kiocb)
> -{
> -	struct nfsd_write_dio_args args;
> -
> -	args.flags_direct = kiocb->ki_flags | IOCB_DIRECT;
> -	args.flags_buffered = kiocb->ki_flags;
> -	args.nf = nf;
> -
> -	return nfsd_issue_dio_write(rqstp, fhp, kiocb, nvecs, cnt, &args);
> -}
> -
>  /**
>   * nfsd_vfs_write - write data to an already-open file
>   * @rqstp: RPC execution context

Combining nfsd_direct_write and nfsd_issue_dio_write is good.  And I
like the intent of removing args but this first attempt has issues
that can be resolved by keeping the flags setup in
nfsd_write_dio_iters_init().

Mike

