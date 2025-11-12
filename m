Return-Path: <linux-nfs+bounces-16315-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEEBC54C86
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 00:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A3715345063
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 23:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126952EBB8F;
	Wed, 12 Nov 2025 23:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqVoIqu/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB542E229F
	for <linux-nfs@vger.kernel.org>; Wed, 12 Nov 2025 23:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762989257; cv=none; b=gZ4WJjGduXg/ofBuX80BYwd+OMMUicH/KdDZYhRuGhiU9SNCaYMgT/1AbA94kRI1bpCqYG13cbZ3oDXRVK7F94ck6pnkKGLuk9a9SpxTOnEsPumVMhOfktrIbS+RlteaudLRJuyRCSjQM7rLWKMU2L8gfDTlBtmgfNYTtPhj+Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762989257; c=relaxed/simple;
	bh=q6b+clI19YqeAO964kJVgsn9LXJ8GlD0KdgYLlUFyOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbITQL1hSwqnKQJljvp2tT8Yz2VvryyOsk296VUGWpE1yUj429D1FYmOwidPasnsM1R76MlWMiW1uuzVkScBHQrUQ9uyeVcLz5Fvv8ylROuEioRCRvivEldiMqZ59VNhDLNr7x/DmlT/VMmrdghFTRYhyhpHAEsNoZeQ2qxTwSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqVoIqu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4217DC4AF09;
	Wed, 12 Nov 2025 23:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762989256;
	bh=q6b+clI19YqeAO964kJVgsn9LXJ8GlD0KdgYLlUFyOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WqVoIqu/4xduBKMWG3/4/EeoRxmligyxqxkCrQyXv6d00ntmyX4XBQGng86PsL5xU
	 +X1+upbHpUwUtq4zVt+BuuAH2ovGXSmWqQnuDemJnwiYlSw6TTVoMAn46AMrM+jrLf
	 l0xJ994zoYQnpPdH2L7g4ItWNI/fDPF+72/3gtD4cS17txgIWUm8tnYekpT8aj/xXq
	 kqXFNExmrSva7vOFRFkqgjcWJ8Bsq/pBsLVjK+6rKAW3lbJ91Rw3TbjmeBK5THR61M
	 bPerlIRytRVeFx/sn5ForUk4e+LalNaUmJzsw5Gp4hVT8nrV5fwvPSWh6X4CkhcJch
	 FCbmvbIxQDRAQ==
Date: Wed, 12 Nov 2025 18:14:15 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, jonathan.flynn@hammerspace.com
Subject: Re: [PATCH v11 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aRUUx2c6YNnRYRZ_@kernel.org>
References: <fb0d6399-ea74-462a-982a-df232e3f4be9@kernel.org>
 <aQ5SSnW9xUWj9xBi@kernel.org>
 <176255273643.634289.15333032218575182744@noble.neil.brown.name>
 <aQ5xkjIzf6uU_zLa@kernel.org>
 <176255894778.634289.2265909350991291087@noble.neil.brown.name>
 <aQ6kkd74pj2aUd8b@kernel.org>
 <2b024928-e078-4414-a062-bbeedfeea5d9@oracle.com>
 <aRL5EPMD9VsG1n3D@infradead.org>
 <aRPPikkia5ZVZxJG@kernel.org>
 <aRShjU_Ti7f2Ci7I@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRShjU_Ti7f2Ci7I@infradead.org>

On Wed, Nov 12, 2025 at 07:02:37AM -0800, Christoph Hellwig wrote:
> On Tue, Nov 11, 2025 at 07:06:34PM -0500, Mike Snitzer wrote:
> > +	/* Mark the I/O buffer as evict-able to reduce memory contention. */
> > +	if (!use_cached_buffered_fallback &&
> > +	    nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
> > +		kiocb->ki_flags |= IOCB_DONTCACHE;
> 
> This won't work, because ki_flags get overwritten by the flags in
> the segment layer.

Thanks, yeah that was a copy-n-paste bug, should've been:
segments[0].flags |= IOCB_DONTCACHE;

I should've stated that my patch wasn't tested and was intended as
RFC.

> I walked through this to understand all the cases,
> and ended up with a slightly different version including long comments
> explaining them.  This is also untested, but I'd love to have other
> cross check the logic in it:
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index ab46301da4ae..4727235ef43f 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1292,12 +1292,23 @@ nfsd_write_dio_iters_init(struct nfsd_file *nf, struct bio_vec *bvec,
>  	unsigned int nsegs = 0;
>  
>  	/*
> -	 * Check if direct I/O is feasible for this write request.
> -	 * If alignments are not available, the write is too small,
> -	 * or no alignment can be found, fall back to buffered I/O.
> +	 * If the file system doesn't advertise any alignment requirements,
> +	 * don't try to issue direct I/O.  Fall back to uncached buffered
> +	 * I/O if possible because we'll assume it is not block based and
> +	 * doesn't need read-modify-write cycles.
>  	 */

Not sure what is implied by "not block based" in this comment.

> -	if (unlikely(!mem_align || !offset_align) ||
> -	    unlikely(total < max(offset_align, mem_align)))
> +	if (unlikely(!mem_align || !offset_align)) {
> +		if (nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
> +			segments[0].flags |= IOCB_DONTCACHE;
> +		goto no_dio;
> +	}
> +
> +	/*
> +	 * If the I/O is smaller than the larger of the memory and logical
> +	 * offset alignment, it is like to require read-modify-write cycles.
> +	 * Issue cached buffered I/O.
> +	 */

Nit: s/like/likely/ typo.

> +	if (unlikely(total < max(offset_align, mem_align)))
>  		goto no_dio;
>  
>  	prefix_end = round_up(offset, offset_align);
> @@ -1308,7 +1319,17 @@ nfsd_write_dio_iters_init(struct nfsd_file *nf, struct bio_vec *bvec,
>  	middle = middle_end - prefix_end;
>  	suffix = orig_end - middle_end;
>  
> -	if (!middle)
> +	/*
> +	 * If there is no aligned middle section, or aligned part is tiny,
> +	 * issue a single buffered I/O write instead of splitting up the
> +	 * write.
> +	 *
> +	 * Note: the middle section size here is random constant.  I suspect
> +	 * when benchmarking it we'd actually end up with a significant larger
> +	 * number, with the details depending on hardware.
> +	 */
> +	if (!middle ||
> +	    ((prefix || suffix) && middle < PAGE_SIZE * 2))
>  		goto no_dio;
>  
>  	if (prefix)

Expressing this threshold in terms of PAGE_SIZE might be a
problem for other archs like ARM (where using 64K the norm for
performance).

The "Note:" portion of the above comment might do well to address the
goal being to avoid using cached buffered for higher order
allocations. You or Chuck may have solid ideas for refining wording.

But so you're aware Jon Flynn (who kindly does the heavy lifting of
performance testing for me) agrees with you: larger will likely be
beneficial but it'll be hardware dependent.  So I'm going to expose a
knob for Jon to try various values so we can see.

From Jon's results we might elect to take further action.

> @@ -1324,16 +1345,24 @@ nfsd_write_dio_iters_init(struct nfsd_file *nf, struct bio_vec *bvec,
>  	 * bvecs generated from RPC receive buffers are contiguous: After
>  	 * the first bvec, all subsequent bvecs start at bv_offset zero
>  	 * (page-aligned). Therefore, only the first bvec is checked.
> +	 *
> +	 * If the memory is not aligned at all, but we have a large enough
> +	 * logical offset-aligned middle section, try to use uncached buffered
> +	 * I/O for that to avoid cache pollution.  If not fall back to a single
> +	 * cached buffered I/O for the entire write.
>  	 */
> -	if (iov_iter_bvec_offset(&segments[nsegs].iter) & (mem_align - 1))
> -		goto no_dio;
> -	segments[nsegs].flags |= IOCB_DIRECT;
> +	if (iov_iter_bvec_offset(&segments[nsegs].iter) & (mem_align - 1)) {
> +		if (!(nf->nf_file->f_op->fop_flags & FOP_DONTCACHE))
> +			goto no_dio;
> +		segments[nsegs].flags |= IOCB_DONTCACHE;

This is a new one for me, but its a nice catch: just because
IOCBD_DIRECT isn't possible for the middle doesn't mean that we should
avoid issuing the subpage segments in terms of buffered IO.

> +	} else {
> +		segments[nsegs].flags |= IOCB_DIRECT;
> +	}
>  	nsegs++;
>  
>  	if (suffix)
>  		nfsd_write_dio_seg_init(&segments[nsegs++], bvec, nvecs, total,
>  					prefix + middle, suffix, iocb);
> -
>  	return nsegs;
>  
>  no_dio:
> @@ -1362,16 +1391,9 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		if (kiocb->ki_flags & IOCB_DIRECT)
>  			trace_nfsd_write_direct(rqstp, fhp, kiocb->ki_pos,
>  						segments[i].iter.count);
> -		else {
> +		else
>  			trace_nfsd_write_vector(rqstp, fhp, kiocb->ki_pos,
>  						segments[i].iter.count);
> -			/*
> -			 * Mark the I/O buffer as evict-able to reduce
> -			 * memory contention.
> -			 */
> -			if (nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
> -				kiocb->ki_flags |= IOCB_DONTCACHE;
> -		}
>  
>  		host_err = vfs_iocb_iter_write(file, kiocb, &segments[i].iter);
>  		if (host_err < 0)

Overall this patch looks good.  Would welcome seeing you submit a
formal patch.  In parallel I'll work with Jon to get this tested on
Hammerspace's performance cluster to confirm all looks good.

Mike

