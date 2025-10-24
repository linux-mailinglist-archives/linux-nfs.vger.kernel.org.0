Return-Path: <linux-nfs+bounces-15618-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C604EC079A7
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 19:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7B41B849F7
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 17:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B784E3161A4;
	Fri, 24 Oct 2025 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhD6TDNW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933F51E491B
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328641; cv=none; b=mt9147KQCFSXyvcO8uombp/Y1vTxIXXm4k2rkEZSODRf+zqlD7x6DWUx+S0A3Tk7dXZOobMntkfPIR6Y89lwWxKd9YeWD9dXHavz6ADgtQaFpTzwsN/E1i+psqOoRBKf+b3ILiSjzXc5uTawJeJzyv5EISXRWFIy8ij0LpZhKzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328641; c=relaxed/simple;
	bh=MesiRkhW859Es18Li7+jcTdSkaNVZTqYMMc/Iof0ifo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rg5XZovAofmRpZHaUdwjmi7xqPsQOxYETVYJEigiN6NwmBGUnbxT2n+qp8B9/uXs/EaVFP02MpZBMHe7nb9kLBDdCvH3rpeLdMzI9vdGZ7dmnN8tTj+LoLDorIVAqDaVlbRzvTfW2mBc7uHuMqUXWJzQsVHs743a72vpqy8m0vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhD6TDNW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A7CC4CEF1;
	Fri, 24 Oct 2025 17:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761328641;
	bh=MesiRkhW859Es18Li7+jcTdSkaNVZTqYMMc/Iof0ifo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uhD6TDNWkBX3ZuRr8MI/WpxamhRYsjknQ56wShy468BC6SfpyQT4/XPVu4u3pWpjt
	 k4XvqMH32578/Ft7otDBIGYNLW1cyKGo5ipso7p56iO3qqEVtIcetCtr4u1k4GybCS
	 Zl+7P8kmVu1whjZyI9NjGqMG3HKUZ8hhzNFfJZ2UvLZR83kK5lDGhGVdB7jvph7Irs
	 xq7GkeSrp7MZuNRpoa1L4i5ZptUmWgLq7bj1q2s46IeGvB7r8x6h5CqJcVPEITb+sJ
	 biXZRriBdaWROP+cXTGSC7zh68wcyydq0M2XCJwShQuH0VjBfmNMl5h0imKWtsvfAM
	 Eyzf7fQ5oGwmw==
Date: Fri, 24 Oct 2025 13:57:19 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 12/14] NFSD: Introduce struct nfsd_write_dio_seg
Message-ID: <aPu9_9269NwH5ybG@kernel.org>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-13-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024144306.35652-13-cel@kernel.org>

On Fri, Oct 24, 2025 at 10:43:04AM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Passing iter arrays by reference is a little risky. Instead, pass a
> struct with a fixed-size array so bounds checking can be done.
> 
> Name each item in the array a "segment", as the term "extent"
> generally refers to a set of blocks on storage, not to a buffer.

Well both ondisk and memory are in play when setting up DIO and
checking alignment.  So length of associated ondisk is an extent.  SO
this is just to say, this header might do well to not get hung up on
past naming.

Not a big deal either way, we're ensuring the DIO-aligned middle
_extent_ ondisk, our alignment additional alignment checking can be
constrained to focus purely on memory segment checking.. so I agree
with your desire to flip the focus to "segment".

> Each segment is processed via a single vfs_iocb_iter_write() call,
> and is either IOCB_DIRECT or buffered.
> 
> Introduce a segment constructor function so each segment is
> initialized identically.
> 
> Each segment has its own length. The loop that iterates over the
> segment array can simply skip over the segments of zero length.
> A count of segments is not needed.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Code looks great, matches how I read Christoph's suggestion, nice
done.  Thanks for running with this.

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

ps. super small nit below.

> @@ -1373,36 +1369,33 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		     unsigned int nvecs, unsigned long *cnt)
>  {
>  	struct file *file = args->nf->nf_file;
> -	bool iter_is_dio_aligned[3];
> -	struct iov_iter iter_stack[3];
> -	struct iov_iter *iter = iter_stack;
> -	unsigned int n_iters = 0;
> -	unsigned long in_count = *cnt;
> -	loff_t in_offset = kiocb->ki_pos;
> +	struct nfsd_write_dio_seg *segment;
>  	ssize_t host_err;
> +	size_t i;
>  
> -	n_iters = nfsd_setup_write_dio_iters(&iter, iter_is_dio_aligned,
> -					     rqstp->rq_bvec, nvecs, *cnt,
> -					     args);
> -	if (unlikely(!n_iters))
> +	if (!nfsd_setup_write_dio_iters(args, rqstp->rq_bvec, nvecs, *cnt))
>  		return nfsd_iocb_write(file, rqstp->rq_bvec, nvecs,
>  				       cnt, kiocb);
>  
> -	trace_nfsd_write_direct(rqstp, fhp, in_offset, in_count);
> -
>  	*cnt = 0;
> -	for (int i = 0; i < n_iters; i++) {
> -		if (iter_is_dio_aligned[i])
> +	segment = args->segment;
> +	for (i = 0; i < ARRAY_SIZE(args->segment); i++) {
> +		if (segment->len == 0)
> +			continue;
> +		if (segment->use_dio) {
>  			kiocb->ki_flags |= IOCB_DIRECT;
> -		else
> +			trace_nfsd_write_direct(rqstp, fhp, kiocb->ki_pos,
> +						segment->len);
> +		} else
>  			kiocb->ki_flags &= ~IOCB_DIRECT;
>  
> -		host_err = vfs_iocb_iter_write(file, kiocb, &iter[i]);
> +		host_err = vfs_iocb_iter_write(file, kiocb, &segment->iter);
>  		if (host_err < 0)
>  			return host_err;
>  		*cnt += host_err;
> -		if (host_err < iter[i].count) /* partial write? */
> +		if (host_err < segment->iter.count)
>  			break;
> +		++segment;
>  	}

I think the /* partial write? */ comment helps a bit. Maybe switch to:

 		if (host_err < segment->iter.count)
  			break; /* partial write */

Or not, up to you... ;)

