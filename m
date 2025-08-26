Return-Path: <linux-nfs+bounces-13898-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E321B37077
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Aug 2025 18:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3211B210DA
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Aug 2025 16:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C4E26CE32;
	Tue, 26 Aug 2025 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rB9vjMz+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A8031A567
	for <linux-nfs@vger.kernel.org>; Tue, 26 Aug 2025 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226074; cv=none; b=irT2ycg0w0VeGPM2Qf8577pg75uPx1u2SEsdO7RXx29kiF9b33mQWWb3o8GAbFEm9hinw+b3BBROEesuLDqor5Nrp9yEWJBVobp38lWiRi6swTxSI1QpI/hZ6CuoDU0kVugxcRawsaqOvweiU3DM8xoz7LeUwz3GFGr75HJ4S0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226074; c=relaxed/simple;
	bh=8RLDc6LwSR2aKohUJkCHc2tLFL1kako6NhSJxrbUCH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXKGSZyLHu7J1WuMXN7BGyusDxmEJddzaPiMA08/r0n4xk9FLnjfyowWYicJghtZ0e+5HKj31DxD75s7uSPMLDCfbnV9kMeprcCYo+a7R4EtkB4vQh6/axIXJkiAmOwTDD/Hf4Y69j9JJ1wKJr5lfHqZT/WkXnJKh2xeEWuAup0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rB9vjMz+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051FDC4CEF1;
	Tue, 26 Aug 2025 16:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756226074;
	bh=8RLDc6LwSR2aKohUJkCHc2tLFL1kako6NhSJxrbUCH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rB9vjMz+9jdohe3ZpYXfwDQwxVat4Zzx7xskU2CzXGasjtB6sW72pt8SoTSvK1ekB
	 vti0PeqdeWFbcFy/OYduu3eNyhcSRyu2ULp9Re/fe59WOmTPYAhpJmEEbGd7PnXRLE
	 rY0Eo73ctJUjtvE6vkZ6QFsLjwpi6pzG0oRw+k7IJ2D5jsdcFjgS4uf5rXhB9J7Ubb
	 V7hVbtUUoxTExzJCt1fRIHcCmOfujumIF4ybNFVUPkh8d55vtj0NxKALCBZ0s5amfT
	 pb2V4r1qzM0mBKgDQScwj1NuwJygMZVZQxl60Y2CFA4h3tTz9fQAhosez63txh3jCX
	 FXPJXk+DG9BYA==
Date: Tue, 26 Aug 2025 12:34:31 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v7 6/7] NFSD: issue WRITEs using O_DIRECT even if IO is
 misaligned
Message-ID: <aK3iF3_807xdXZRk@kernel.org>
References: <20250815144607.50967-1-snitzer@kernel.org>
 <20250815144607.50967-7-snitzer@kernel.org>
 <e5052736e0d18f153bd3c3a9b75a7349218b5697.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5052736e0d18f153bd3c3a9b75a7349218b5697.camel@kernel.org>

On Mon, Aug 18, 2025 at 03:46:06PM -0400, Jeff Layton wrote:
> On Fri, 2025-08-15 at 10:46 -0400, Mike Snitzer wrote:
> > If NFSD_IO_DIRECT is used, split any misaligned WRITE into a start,
> > middle and end as needed. The large middle extent is DIO-aligned and
> > the start and/or end are misaligned. Buffered IO is used for the
> > misaligned extents and O_DIRECT is used for the middle DIO-aligned
> > extent.
> > 
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfsd/vfs.c | 176 +++++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 168 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 64732dc8985d6..afcc22fdddefc 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -1355,6 +1355,169 @@ static int wait_for_concurrent_writes(struct file *file)
> >  	return err;
> >  }
> >  
> > +struct nfsd_write_dio {
> > +	loff_t middle_offset;	/* Offset for start of DIO-aligned middle */
> > +	loff_t end_offset;	/* Offset for start of DIO-aligned end */
> > +	ssize_t	start_len;	/* Length for misaligned first extent */
> > +	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
> > +	ssize_t	end_len;	/* Length for misaligned last extent */
> > +};
> > +
> > +static bool
> > +nfsd_analyze_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > +		       struct nfsd_file *nf, loff_t offset,
> > +		       unsigned long len, struct nfsd_write_dio *write_dio)
> > +{
> > +	const u32 dio_blocksize = nf->nf_dio_offset_align;
> > +	loff_t orig_end, middle_end, start_end, start_offset = offset;
> > +	ssize_t start_len = len;
> > +
> > +	if (WARN_ONCE(!nf->nf_dio_mem_align || !dio_blocksize,
> > +		      "%s: underlying filesystem has not provided DIO alignment info\n",
> > +		      __func__))
> > +		return false;
> > +	if (WARN_ONCE(dio_blocksize > PAGE_SIZE,
> > +		      "%s: underlying storage's dio_blocksize=%u > PAGE_SIZE=%lu\n",
> > +		      __func__, dio_blocksize, PAGE_SIZE))
> > +		return false;
> > +	if (unlikely(len < dio_blocksize))
> > +		return false;
> > +
> > +	memset(write_dio, 0, sizeof(*write_dio));
> > +
> > +	if (((offset | len) & (dio_blocksize-1)) == 0) {
> > +		/* already DIO-aligned, no misaligned head or tail */
> > +		write_dio->middle_offset = offset;
> > +		write_dio->middle_len = len;
> > +		/* clear these for the benefit of trace_nfsd_analyze_write_dio */
> > +		start_offset = 0;
> > +		start_len = 0;
> > +		return true;
> > +	}
> > +
> > +	start_end = round_up(offset, dio_blocksize);
> > +	start_len = start_end - offset;
> > +	orig_end = offset + len;
> > +	middle_end = round_down(orig_end, dio_blocksize);
> > +
> > +	write_dio->start_len = start_len;
> > +	write_dio->middle_offset = start_end;
> > +	write_dio->middle_len = middle_end - start_end;
> > +	write_dio->end_offset = middle_end;
> > +	write_dio->end_len = orig_end - middle_end;
> > +
> > +	return true;
> > +}
> > +
> > +/*
> > + * Setup as many as 3 iov_iter based on extents described by @write_dio.
> > + * @iterp: pointer to pointer to onstack array of 3 iov_iter structs from caller.
> > + * @iter_is_dio_aligned: pointer to onstack array of 3 bools from caller.
> > + * @rq_bvec: backing bio_vec used to setup all 3 iov_iter permutations.
> > + * @nvecs: number of segments in @rq_bvec
> > + * @cnt: size of the request in bytes
> > + * @write_dio: nfsd_write_dio struct that describes start, middle and end extents.
> > + *
> > + * Returns the number of iov_iter that were setup.
> > + */
> > +static int
> > +nfsd_setup_write_dio_iters(struct iov_iter **iterp, bool *iter_is_dio_aligned,
> > +			   struct bio_vec *rq_bvec, unsigned int nvecs,
> > +			   unsigned long cnt, struct nfsd_write_dio *write_dio)
> > +{
> > +	int n_iters = 0;
> > +	struct iov_iter *iters = *iterp;
> > +
> > +	/* Setup misaligned start? */
> > +	if (write_dio->start_len) {
> > +		iter_is_dio_aligned[n_iters] = false;
> > +		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
> > +		iters[n_iters].count = write_dio->start_len;
> > +		++n_iters;
> > +	}
> > +
> > +	/* Setup DIO-aligned middle */
> > +	iter_is_dio_aligned[n_iters] = true;
> > +	iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
> > +	if (write_dio->start_len)
> > +		iov_iter_advance(&iters[n_iters], write_dio->start_len);
> > +	iters[n_iters].count -= write_dio->end_len;
> > +	++n_iters;
> > +
> > +	/* Setup misaligned end? */
> > +	if (write_dio->end_len) {
> > +		iter_is_dio_aligned[n_iters] = false;
> > +		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
> > +		iov_iter_advance(&iters[n_iters],
> > +				 write_dio->start_len + write_dio->middle_len);
> > +		++n_iters;
> > +	}
> > +
> > +	return n_iters;
> > +}
> > +
> > +static int
> > +nfsd_issue_write_buffered(struct svc_rqst *rqstp, struct file *file,
> > +			  unsigned int nvecs, unsigned long *cnt,
> > +			  struct kiocb *kiocb)
> > +{
> > +	struct iov_iter iter;
> > +	int host_err;
> > +
> > +	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> > +	host_err = vfs_iocb_iter_write(file, kiocb, &iter);
> > +	if (host_err < 0)
> > +		return host_err;
> > +	*cnt = host_err;
> > +
> > +	return 0;
> > +}
> > +
> > +static noinline int
> > +nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > +		     struct nfsd_file *nf, loff_t offset,
> > +		     unsigned int nvecs, unsigned long *cnt,
> > +		     struct kiocb *kiocb)
> > +{
> > +	struct nfsd_write_dio write_dio;
> > +	struct file *file = nf->nf_file;
> > +
> > +	if (!nfsd_analyze_write_dio(rqstp, fhp, nf, offset, *cnt, &write_dio))
> > +		return nfsd_issue_write_buffered(rqstp, file, nvecs, cnt, kiocb);
> > +	else {
> > +		bool iter_is_dio_aligned[3];
> > +		struct iov_iter iter_stack[3];
> > +		struct iov_iter *iter = iter_stack;
> > +		unsigned int n_iters = 0;
> > +		int host_err;
> > +
> > +		n_iters = nfsd_setup_write_dio_iters(&iter, iter_is_dio_aligned,
> > +				rqstp->rq_bvec, nvecs, *cnt, &write_dio);
> > +		*cnt = 0;
> > +		for (int i = 0; i < n_iters; i++) {
> > +			if (iter_is_dio_aligned[i] &&
> > +			    nfsd_iov_iter_aligned_bvec(&iter[i], nf->nf_dio_mem_align-1,
> > +						       nf->nf_dio_offset_align-1))
> > +				kiocb->ki_flags |= IOCB_DIRECT;
> > +			else
> > +				kiocb->ki_flags &= ~IOCB_DIRECT;
> > +			host_err = vfs_iocb_iter_write(file, kiocb, &iter[i]);
> > +			if (host_err < 0) {
> > +				/* Underlying FS will return -EINVAL if misaligned
> > +				 * DIO is attempted because it shouldn't be.
> > +				 */
> > +				WARN_ON_ONCE(host_err == -EINVAL);
> > +				return host_err;
> > +			}
> > +			*cnt += host_err;
> > +			if (host_err < iter[i].count) /* partial write? */
> > +				return *cnt;
> > +		}
> 
> If this ends up doing some buffered I/Os on the unaligned end bits,
> should we have it issue a vfs_fsync_range() (or maybe use IOCB_SYNC)
> here as well to ensure that those bits get written back before sending
> the reply? I worry a bit about an aligned (DIO) read of a page racing
> in and not seeing data that hasn't been written back yet.

I haven't had any issues as-is, but that doesn't mean there couldn't
be something.

For the misaligned buffered IO writes, I'm fine with clearing
IOCB_DIRECT and setting IOCB_SYNC.

Mike

