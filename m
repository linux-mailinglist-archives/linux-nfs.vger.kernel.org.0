Return-Path: <linux-nfs+bounces-15809-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BF8C221B0
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 20:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1891A61B96
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 19:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11D82E54A1;
	Thu, 30 Oct 2025 19:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/XgL5+r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC2133343D
	for <linux-nfs@vger.kernel.org>; Thu, 30 Oct 2025 19:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761854363; cv=none; b=Pkf/2th8FI7rRfl7G0YuqxqNdIeSE5W4QWAMKp3Qn7RpdayLG5RLi1i2qaZ2/9tkBvFBLoDJLleDiUM0TzAyaUh78RuRog+6gwb8qryTcqW59Zz/BiHE45yDnRBqcrDwevTiWcS8GbN6Ssw9fupiGsdrxGXsZR0EtQ0ZedFZDxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761854363; c=relaxed/simple;
	bh=EAo0t27mCZ6elO4q52jVzMdw1gVQInZfG2qAzxqSRhU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GjR5TVRDxbNzisvHZWf545J38k+lYNrMKw7kCeCEnF2Dyu4JYjTmkwbWHiNC7q1xUkBxBb2wqQRpGdfLiq0snvqbpI+ylDaDoGtkxqigqZvxREq6FSt+0i0+kcVoduqN8gC9TmRl0LU09VQc9TDtcirmFAEOyuOXdoYsGvRr25g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/XgL5+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84FDC4CEF1;
	Thu, 30 Oct 2025 19:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761854363;
	bh=EAo0t27mCZ6elO4q52jVzMdw1gVQInZfG2qAzxqSRhU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=J/XgL5+ruZsAxlddunG0OE8HvqGQtB+vclUJ6TdOCaRvQQPwtUlLJb4/iTgCXIhne
	 6sI7aobXb+zVXZ70jzgRLOPgfZSO74A3g7SnvKR6fABixQzk5q2JR+I9KUzVncM/Ow
	 q2th7NPLQVRRIgk1JyleLCSeo89zbOehYRyA3q4zNgQyKZgWxAK2WwH2d06i/dFmdh
	 KkOoDzyBUXtIi54lKGfuRnBEl11aLLFz5LyUqV+TpnCZtwhlTodGr6vBhjmkFgrSmj
	 hc9NNdqHIg70hMqjqxAC8FA1y/nyle2qeGlDjfZfkud7A58bRDkcHmaZk1ImGHQxXx
	 yRgy6cI14TT6g==
Message-ID: <556644f0ea098be51063dc4414974b1c88a989a2.camel@kernel.org>
Subject: Re: [PATCH v8 10/12] NFSD: Combine direct I/O feasibility check
 with iterator setup
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Chuck Lever
	 <chuck.lever@oracle.com>
Date: Thu, 30 Oct 2025 15:59:21 -0400
In-Reply-To: <20251027154630.1774-11-cel@kernel.org>
References: <20251027154630.1774-1-cel@kernel.org>
	 <20251027154630.1774-11-cel@kernel.org>
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
> When direct I/O is not feasible (due to missing alignment info,
> too-small writes, or no alignment possible), pack the entire
> write payload into a single non-DIO segment and follow the usual
> direct write I/O path.
>=20
> This simplifies nfsd_direct_write() by eliminating the fallback path
> and the separate nfsd_buffered_write() call - all writes now go
> through nfsd_issue_write_dio() which handles both DIO and buffered
> segments.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/vfs.c | 69 +++++++++++++++++++++------------------------------
>  1 file changed, 28 insertions(+), 41 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index a872be300c9f..be0688f2ab3d 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1304,30 +1304,6 @@ nfsd_find_dio_aligned_offset(struct nfsd_file *nf,=
 loff_t file_offset,
>  	return SIZE_MAX;  /* No alignment found */
>  }
> =20
> -/*
> - * Check if the underlying file system implements direct I/O.
> - */
> -static bool
> -nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
> -			   struct nfsd_write_dio_args *args)
> -{
> -	u32 offset_align =3D args->nf->nf_dio_offset_align;
> -	u32 mem_align =3D args->nf->nf_dio_mem_align;
> -
> -	if (unlikely(!mem_align || !offset_align))
> -		return false;
> -
> -	/*
> -	 * Need enough data to potentially find an aligned segment.
> -	 * In the worst case, we might need up to
> -	 * lcm(offset_align, mem_align) bytes for the prefix.
> -	 */
> -	if (unlikely(len < max(offset_align, mem_align)))
> -		return false;
> -
> -	return true;
> -}
> -
>  static void
>  nfsd_write_dio_seg_init(struct nfsd_write_dio_seg *segment,
>  			struct bio_vec *bvec, unsigned int nvecs,
> @@ -1340,22 +1316,31 @@ nfsd_write_dio_seg_init(struct nfsd_write_dio_seg=
 *segment,
>  	segment->use_dio =3D false;
>  }
> =20
> -static bool
> -nfsd_setup_write_dio_iters(struct bio_vec *bvec, unsigned int nvecs,
> -			   loff_t offset, unsigned long total,
> -			   struct nfsd_write_dio_args *args)
> +static void
> +nfsd_write_dio_iters_init(struct bio_vec *bvec, unsigned int nvecs,
> +			  loff_t offset, unsigned long total,
> +			  struct nfsd_write_dio_args *args)
>  {
>  	u32 offset_align =3D args->nf->nf_dio_offset_align;
> +	u32 mem_align =3D args->nf->nf_dio_mem_align;
>  	unsigned long mem_offset =3D bvec->bv_offset;
>  	loff_t prefix_end, orig_end, middle_end;
>  	size_t prefix, middle, suffix;
> =20
>  	args->nsegs =3D 0;
> =20
> +	/*
> +	 * Check if direct I/O is feasible for this write request.
> +	 * If alignments are not available, the write is too small,
> +	 * or no alignment can be found, fall back to buffered I/O.
> +	 */
> +	if (unlikely(!mem_align || !offset_align) ||
> +	    unlikely(total < max(offset_align, mem_align)))
> +		goto no_dio;
>  	prefix =3D nfsd_find_dio_aligned_offset(args->nf, offset, mem_offset,
>  					     total);
>  	if (prefix =3D=3D SIZE_MAX)
> -		return false;	/* No alignment possible */
> +		goto no_dio;
> =20
>  	prefix_end =3D offset + prefix;
>  	orig_end =3D offset + total;
> @@ -1371,7 +1356,7 @@ nfsd_setup_write_dio_iters(struct bio_vec *bvec, un=
signed int nvecs,
>  	}
> =20
>  	if (!middle)
> -		return false;	/* No aligned region for DIO */
> +		goto no_dio;
> =20
>  	nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec, nvecs,
>  				total, prefix, middle);
> @@ -1384,7 +1369,13 @@ nfsd_setup_write_dio_iters(struct bio_vec *bvec, u=
nsigned int nvecs,
>  		++args->nsegs;
>  	}
> =20
> -	return true;
> +	return;
> +
> +no_dio:
> +	/* No alignment possible - pack into single non-DIO segment */
> +	nfsd_write_dio_seg_init(&args->segment[0], bvec, nvecs, total,
> +				0, total);
> +	args->nsegs =3D 1;
>  }
> =20
>  static int
> @@ -1405,7 +1396,7 @@ nfsd_buffered_write(struct svc_rqst *rqstp, struct =
file *file,
>  }
> =20
>  static int
> -nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *st=
able_how,
> +nfsd_issue_dio_write(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *st=
able_how,
>  		     struct kiocb *kiocb, unsigned int nvecs, unsigned long *cnt,
>  		     struct nfsd_write_dio_args *args)
>  {
> @@ -1413,10 +1404,6 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struc=
t svc_fh *fhp, u32 *stable_how
>  	ssize_t host_err;
>  	unsigned int i;
> =20
> -	if (!nfsd_setup_write_dio_iters(rqstp->rq_bvec, nvecs, kiocb->ki_pos,
> -					*cnt, args))
> -		return nfsd_buffered_write(rqstp, file, nvecs, cnt, kiocb);
> -
>  	/*
>  	 * Any buffered IO issued here will be misaligned, use
>  	 * sync IO to ensure it has completed before returning.
> @@ -1425,6 +1412,9 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct=
 svc_fh *fhp, u32 *stable_how
>  	kiocb->ki_flags |=3D (IOCB_DSYNC|IOCB_SYNC);
>  	*stable_how =3D NFS_FILE_SYNC;
> =20
> +	nfsd_write_dio_iters_init(rqstp->rq_bvec, nvecs, kiocb->ki_pos,
> +				  *cnt, args);
> +
>  	*cnt =3D 0;
>  	for (i =3D 0; i < args->nsegs; i++) {
>  		if (args->segment[i].use_dio) {
> @@ -1463,11 +1453,8 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
>  	if (args.nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
>  		kiocb->ki_flags |=3D IOCB_DONTCACHE;
> =20
> -	if (nfsd_is_write_dio_possible(kiocb->ki_pos, *cnt, &args))
> -		return nfsd_issue_write_dio(rqstp, fhp, stable_how, kiocb,
> -					    nvecs, cnt, &args);
> -
> -	return nfsd_buffered_write(rqstp, args.nf->nf_file, nvecs, cnt, kiocb);
> +	return nfsd_issue_dio_write(rqstp, fhp, stable_how, kiocb, nvecs,
> +				    cnt, &args);
>  }
> =20
>  /**

Reviewed-by: Jeff Layton <jlayton@kernel.org>

