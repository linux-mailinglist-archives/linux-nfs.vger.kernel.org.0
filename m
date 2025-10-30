Return-Path: <linux-nfs+bounces-15807-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DCCC22170
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 20:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FBC01A66ACE
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 19:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBA1329C52;
	Thu, 30 Oct 2025 19:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WENvbRRv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A7B3164D3
	for <linux-nfs@vger.kernel.org>; Thu, 30 Oct 2025 19:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761853968; cv=none; b=l0nvFsIgPzhf8/sVuRl7+HcIzA4Xr3el0FTpFBKkpltPgE7xnQsqjkuKWIDu9tFEgtKucjumO9A2TgBMeHBwnEiHNnM4wNYJhhEed8c16xudOipC+yh+f5zioZLCkifVpMPVFxUjfrcelbNA0D1NBl0+fjG5E79gbarbXwUlXvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761853968; c=relaxed/simple;
	bh=+mcgEbW+0N7+5oaDc2mI2WO5Qu34GCom2tELAej+cOU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lsn1FYLoDLAZ+/nmCQZHVSrovRngSUWSOw/ct1NqD+oMo+PyPj4BAvoTxLatqi1yGADbT7fZx+8DjIwBopCGfnbGY97L/DBmO7zz3cZKSkZulRpYwMm+KJuK1UzpMhDd6cIqBmPe+eWrZaGg1ZKE+sRaehcsaO2Q3fyATNcTK0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WENvbRRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EB7C4CEF1;
	Thu, 30 Oct 2025 19:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761853967;
	bh=+mcgEbW+0N7+5oaDc2mI2WO5Qu34GCom2tELAej+cOU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WENvbRRvlTtSjb0SS4KMr/wpURk6KXnT8G/UH17e754i/3WQ5IYo7JJPe3TaKcqgc
	 NntKpbbpAnGN4TZgj4sF4S1rHPAwZjd5qC2yesUATF+4sjrgYYnAHZ38ve/PR+9SAQ
	 n4GXtFHcohDm13l7G7i1Y+NO3xIBKRLqIbIAMT+AIDNlxuL5qiJvuswpr7oScs3tiQ
	 Yugn6hIgWUooe70SWDsUjvb9GlTThDjzlofL62zuDHekH2vftxA4/6X4RNrx1Jy1+/
	 zSegj43HfjhKB2vW6oSQpviIufZ9U5Mod8iRBaSRBW0nmaUBbrdN2pb1l6XRcp3kOA
	 OuGWalFK3pQ1A==
Message-ID: <6dcab1145acd85e0d07c11ac09ba5d7e429a364e.camel@kernel.org>
Subject: Re: [PATCH v8 09/12] NFSD: Handle both offset and memory alignment
 for direct I/O
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Chuck Lever
	 <chuck.lever@oracle.com>
Date: Thu, 30 Oct 2025 15:52:45 -0400
In-Reply-To: <20251027154630.1774-10-cel@kernel.org>
References: <20251027154630.1774-1-cel@kernel.org>
	 <20251027154630.1774-10-cel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-27 at 11:46 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Currently, nfsd_is_write_dio_possible() only considers file offset
> alignment (nf_dio_offset_align) when splitting an NFS WRITE request
> into segments. This leaves accounting for memory buffer alignment
> (nf_dio_mem_align) until nfsd_setup_write_dio_iters(). If this
> second check fails, the code falls back to cached I/O entirely,
> wasting the opportunity to use direct I/O for the bulk of the
> request.
>=20
> Enhance the logic to find a beginning segment size that satisfies
> both alignment constraints simultaneously. The search algorithm
> starts with the file offset alignment requirement and steps through
> multiples of offset_align, checking memory alignment at each step.
> The search is bounded by lcm(offset_align, mem_align) to ensure that
> it always terminates.
>=20
> Signed-off-by: Chuck Lever <cel@kernel.org>
> ---
>  fs/nfsd/filecache.c |   5 ++
>  fs/nfsd/filecache.h |   1 +
>  fs/nfsd/vfs.c       | 119 +++++++++++++++++++++++++++++---------------
>  3 files changed, 86 insertions(+), 39 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index a238b6725008..89adc4ab5b24 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -40,6 +40,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/rhashtable.h>
>  #include <linux/nfslocalio.h>
> +#include <linux/lcm.h>
> =20
>  #include "vfs.h"
>  #include "nfsd.h"
> @@ -234,6 +235,7 @@ nfsd_file_alloc(struct net *net, struct inode *inode,=
 unsigned char need,
>  	nf->nf_dio_mem_align =3D 0;
>  	nf->nf_dio_offset_align =3D 0;
>  	nf->nf_dio_read_offset_align =3D 0;
> +	nf->nf_dio_align_lcm =3D 0;
>  	return nf;
>  }
> =20
> @@ -1071,6 +1073,9 @@ nfsd_file_get_dio_attrs(const struct svc_fh *fhp, s=
truct nfsd_file *nf)
>  	if (stat.result_mask & STATX_DIOALIGN) {
>  		nf->nf_dio_mem_align =3D stat.dio_mem_align;
>  		nf->nf_dio_offset_align =3D stat.dio_offset_align;
> +		if (stat.dio_mem_align && stat.dio_offset_align)
> +			nf->nf_dio_align_lcm =3D lcm(stat.dio_mem_align,
> +						   stat.dio_offset_align);
>  	}
>  	if (stat.result_mask & STATX_DIO_READ_ALIGN)
>  		nf->nf_dio_read_offset_align =3D stat.dio_read_offset_align;
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index e3d6ca2b6030..2648aaab5a1b 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -58,6 +58,7 @@ struct nfsd_file {
>  	u32			nf_dio_mem_align;
>  	u32			nf_dio_offset_align;
>  	u32			nf_dio_read_offset_align;
> +	unsigned long		nf_dio_align_lcm;
>  };
> =20
>  int nfsd_file_cache_init(void);
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 37353fb48d58..a872be300c9f 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1261,49 +1261,73 @@ struct nfsd_write_dio_seg {
> =20
>  struct nfsd_write_dio_args {
>  	struct nfsd_file		*nf;
> -	size_t				first, middle, last;
>  	unsigned int			nsegs;
>  	struct nfsd_write_dio_seg	segment[3];
>  };
> =20
> +/*
> + * Find the minimum offset within the write request that aligns both
> + * the file offset and memory buffer for direct I/O.
> + *
> + * Returns the size of the unaligned prefix, or SIZE_MAX if no alignment
> + * is possible within reasonable bounds.
> + */
> +static size_t
> +nfsd_find_dio_aligned_offset(struct nfsd_file *nf, loff_t file_offset,
> +			     unsigned long mem_offset, size_t total_len)
> +{
> +	u32 offset_align =3D nf->nf_dio_offset_align;
> +	u32 mem_align =3D nf->nf_dio_mem_align;
> +	unsigned long search_limit;
> +	size_t first;
> +
> +	/* Start with the file offset alignment requirement */
> +	first =3D round_up(file_offset, offset_align) - file_offset;
> +
> +	/* Quick check: does this also satisfy memory alignment? */
> +	if (((mem_offset + first) & (mem_align - 1)) =3D=3D 0)
> +		return first;
> +
> +	/*
> +	 * Search for a value that satisfies both constraints by stepping
> +	 * through multiples of offset_align. Limit search to one period
> +	 * of the LCM. We need to check up through the search_limit to
> +	 * cover all possible alignments within the LCM period.
> +	 */
> +	search_limit =3D min_t(unsigned long, nf->nf_dio_align_lcm, total_len);
> +
> +	for (; first <=3D search_limit && first < total_len; first +=3D offset_=
align) {
> +		if (((mem_offset + first) & (mem_align - 1)) =3D=3D 0)
> +			return first;
> +	}
> +
> +	return SIZE_MAX;  /* No alignment found */
> +}
> +
> +/*
> + * Check if the underlying file system implements direct I/O.
> + */
>  static bool
>  nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
>  			   struct nfsd_write_dio_args *args)
>  {
> -	u32 dio_blocksize =3D args->nf->nf_dio_offset_align;
> -	loff_t first_end, orig_end, middle_end;
> +	u32 offset_align =3D args->nf->nf_dio_offset_align;
> +	u32 mem_align =3D args->nf->nf_dio_mem_align;
> =20
> -	if (unlikely(!args->nf->nf_dio_mem_align || !dio_blocksize))
> -		return false;
> -	if (unlikely(len < dio_blocksize))
> +	if (unlikely(!mem_align || !offset_align))
>  		return false;
> =20
> -	first_end =3D round_up(offset, dio_blocksize);
> -	orig_end =3D offset + len;
> -	middle_end =3D round_down(orig_end, dio_blocksize);
> +	/*
> +	 * Need enough data to potentially find an aligned segment.
> +	 * In the worst case, we might need up to
> +	 * lcm(offset_align, mem_align) bytes for the prefix.
> +	 */
> +	if (unlikely(len < max(offset_align, mem_align)))
> +		return false;
> =20
> -	args->first =3D first_end - offset;
> -	args->middle =3D middle_end - first_end;
> -	args->last =3D orig_end - middle_end;
>  	return true;
>  }
> =20
> -/*
> - * Check if the bvec iterator is aligned for direct I/O.
> - *
> - * bvecs generated from RPC receive buffers are contiguous: After the fi=
rst
> - * bvec, all subsequent bvecs start at bv_offset zero (page-aligned).
> - * Therefore, only the first bvec is checked.
> - */
> -static bool
> -nfsd_iov_iter_aligned_bvec(const struct nfsd_file *nf, const struct iov_=
iter *i)
> -{
> -	unsigned int addr_mask =3D nf->nf_dio_mem_align - 1;
> -	const struct bio_vec *bvec =3D i->bvec;
> -
> -	return !((unsigned long)(bvec->bv_offset + i->iov_offset) & addr_mask);
> -}
> -
>  static void
>  nfsd_write_dio_seg_init(struct nfsd_write_dio_seg *segment,
>  			struct bio_vec *bvec, unsigned int nvecs,
> @@ -1318,29 +1342,45 @@ nfsd_write_dio_seg_init(struct nfsd_write_dio_seg=
 *segment,
> =20
>  static bool
>  nfsd_setup_write_dio_iters(struct bio_vec *bvec, unsigned int nvecs,
> -			   unsigned long total,
> +			   loff_t offset, unsigned long total,
>  			   struct nfsd_write_dio_args *args)
>  {
> +	u32 offset_align =3D args->nf->nf_dio_offset_align;
> +	unsigned long mem_offset =3D bvec->bv_offset;
> +	loff_t prefix_end, orig_end, middle_end;
> +	size_t prefix, middle, suffix;
> +
>  	args->nsegs =3D 0;
> =20
> -	if (args->first) {
> +	prefix =3D nfsd_find_dio_aligned_offset(args->nf, offset, mem_offset,
> +					     total);
> +	if (prefix =3D=3D SIZE_MAX)
> +		return false;	/* No alignment possible */
> +
> +	prefix_end =3D offset + prefix;
> +	orig_end =3D offset + total;
> +	middle_end =3D round_down(orig_end, offset_align);
> +
> +	middle =3D middle_end - prefix_end;
> +	suffix =3D orig_end - middle_end;
> +
> +	if (prefix) {
>  		nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec,
> -					nvecs, total, 0, args->first);
> +					nvecs, total, 0, prefix);
>  		++args->nsegs;
>  	}
> =20
> +	if (!middle)
> +		return false;	/* No aligned region for DIO */
> +
>  	nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec, nvecs,
> -				total, args->first, args->middle);
> -	if (!nfsd_iov_iter_aligned_bvec(args->nf,
> -					&args->segment[args->nsegs].iter))
> -		return false;	/* no DIO-aligned IO possible */
> +				total, prefix, middle);
>  	args->segment[args->nsegs].use_dio =3D true;
>  	++args->nsegs;
> =20
> -	if (args->last) {
> +	if (suffix) {
>  		nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec,
> -					nvecs, total, args->first +
> -					args->middle, args->last);
> +					nvecs, total, prefix + middle, suffix);
>  		++args->nsegs;
>  	}
> =20
> @@ -1373,7 +1413,8 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct=
 svc_fh *fhp, u32 *stable_how
>  	ssize_t host_err;
>  	unsigned int i;
> =20
> -	if (!nfsd_setup_write_dio_iters(rqstp->rq_bvec, nvecs, *cnt, args))
> +	if (!nfsd_setup_write_dio_iters(rqstp->rq_bvec, nvecs, kiocb->ki_pos,
> +					*cnt, args))
>  		return nfsd_buffered_write(rqstp, file, nvecs, cnt, kiocb);
> =20
>  	/*

Not an easy patch to follow, but I think I get it.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

