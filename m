Return-Path: <linux-nfs+bounces-15608-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3924C06F9F
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 17:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 952494E1EF8
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 15:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D61326D4F;
	Fri, 24 Oct 2025 15:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAJ6ATNf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7AF32A3E5
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319809; cv=none; b=DnZZEI5EnJjXiMXGizX8I7VPhDsaXVoIxDHO04+1FzH5MGSIf1/dPxGN0n64zdjzE4acI6+MtaGI2GpgYehPX/haJjTXOdpcoeZrvs4DlQjuQQoaUqpJzvT/t/lITqpSXX5f8liJgtgZWiy804upi9Lh4fxHhTt6Huhh/0CTfKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319809; c=relaxed/simple;
	bh=4Qh10+ymvis9vUdTigHL8JWSBEvdwMy5YJqu9f4SMa0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P2r9bw9a80PNFdqeXrL2Ty/WZSTSXDTaKRSqR0QNTkPUypGpS56NIhotTA/uhyveZEhPKzY6JDn4HGuHNOqatjPei85//KFwB29C23pQdgBudpt4nGI84DMjKJepcQ7RXf5OedhsUp95MWaFcGGwU1sxpkIRUWm4sTnOMIg7dxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAJ6ATNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252B2C4CEF1;
	Fri, 24 Oct 2025 15:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761319806;
	bh=4Qh10+ymvis9vUdTigHL8JWSBEvdwMy5YJqu9f4SMa0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=LAJ6ATNfZrNX90rT0Z/izqXPw0xLBV7Vjftrdz4riw4BZezqTuq/Ginb/2tpxdIeX
	 hDuVjQqspGctNV/6uiuLca/e5Z3UeiU6JmsiwZ1zs7Ss1B0mRsmw3B/SLdBV1O4e8a
	 hVCsOdnTzBiXTw8p1NzP8YsK6x1ImAF2LFepqur1MOsLi6dcjKGF9sgqZGCVRwICFo
	 0C/DK7dB28r4pat3jp/Haa1Sek87GLSJ+oVGsKgD8ZK+2AjXfN4HUN2uYjY+GEJX8Y
	 RdPC7gJwDSzckOZtguMifGS+GELwuSv2zksyaKtCT0+vSk5dOVsoq2BZJRmijWmfN6
	 jSg1bxNuk9UlQ==
Message-ID: <4777b7bbc2e2da0add9e1a3e58af87498613b198.camel@kernel.org>
Subject: Re: [PATCH v7 12/14] NFSD: Introduce struct nfsd_write_dio_seg
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
 Christoph Hellwig
	 <hch@lst.de>
Date: Fri, 24 Oct 2025 11:30:05 -0400
In-Reply-To: <20251024144306.35652-13-cel@kernel.org>
References: <20251024144306.35652-1-cel@kernel.org>
	 <20251024144306.35652-13-cel@kernel.org>
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

On Fri, 2025-10-24 at 10:43 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Passing iter arrays by reference is a little risky. Instead, pass a
> struct with a fixed-size array so bounds checking can be done.
>=20
> Name each item in the array a "segment", as the term "extent"
> generally refers to a set of blocks on storage, not to a buffer.
> Each segment is processed via a single vfs_iocb_iter_write() call,
> and is either IOCB_DIRECT or buffered.
>=20
> Introduce a segment constructor function so each segment is
> initialized identically.
>=20
> Each segment has its own length. The loop that iterates over the
> segment array can simply skip over the segments of zero length.
> A count of segments is not needed.
>=20

True, but it's easy to get that sort of accounting wrong, and if we do
we're looking at a buffer overrun. Maybe it'd be reasonable to keep a
number of segments in this struct too, if only for defensive coding
reasons, and to enable proper bounds checking?


> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/vfs.c | 121 ++++++++++++++++++++++++--------------------------
>  1 file changed, 57 insertions(+), 64 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 429f5fc61ead..b7f217aa4994 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1254,12 +1254,15 @@ static int wait_for_concurrent_writes(struct file=
 *file)
>  	return err;
>  }
> =20
> +struct nfsd_write_dio_seg {
> +	struct iov_iter			iter;
> +	size_t				len;
> +	bool				use_dio;
> +};
> +
>  struct nfsd_write_dio_args {
>  	struct nfsd_file		*nf;
> -
> -	ssize_t	start_len;	/* Length for misaligned first extent */
> -	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
> -	ssize_t	end_len;	/* Length for misaligned last extent */
> +	struct nfsd_write_dio_seg	segment[3];
>  };
> =20
>  static bool
> @@ -1267,21 +1270,19 @@ nfsd_is_write_dio_possible(struct nfsd_write_dio_=
args *args, loff_t offset,
>  			   unsigned long len)
>  {
>  	const u32 dio_blocksize =3D args->nf->nf_dio_offset_align;
> -	loff_t start_end, orig_end, middle_end;
> +	loff_t first_end, orig_end, middle_end;
> =20
>  	if (unlikely(!args->nf->nf_dio_mem_align || !dio_blocksize))
>  		return false;
>  	if (unlikely(len < dio_blocksize))
>  		return false;
> =20
> -	start_end =3D round_up(offset, dio_blocksize);
> +	first_end =3D round_up(offset, dio_blocksize);
>  	orig_end =3D offset + len;
>  	middle_end =3D round_down(orig_end, dio_blocksize);
> -
> -	args->start_len =3D start_end - offset;
> -	args->middle_len =3D middle_end - start_end;
> -	args->end_len =3D orig_end - middle_end;
> -
> +	args->segment[0].len =3D first_end - offset;	/* first segment */
> +	args->segment[1].len =3D middle_end - first_end;	/* middle segment */
> +	args->segment[2].len =3D orig_end - middle_end;	/* last segment */
>  	return true;
>  }
> =20
> @@ -1308,47 +1309,42 @@ nfsd_iov_iter_aligned_bvec(const struct nfsd_file=
 *nf, const struct iov_iter *i)
>  	return true;
>  }
> =20
> -/*
> - * Setup as many as 3 iov_iter based on extents described by @write_dio.
> - * Returns the number of iov_iter that were setup.
> - */
> -static int
> -nfsd_setup_write_dio_iters(struct iov_iter **iterp, bool *iter_is_dio_al=
igned,
> -			   struct bio_vec *rq_bvec, unsigned int nvecs,
> -			   unsigned long cnt, struct nfsd_write_dio_args *args)
> +static void
> +nfsd_setup_write_dio_seg(struct nfsd_write_dio_seg *segment,
> +			 struct bio_vec *bvec, unsigned int nvecs,
> +			 unsigned long total, size_t start)
>  {
> -	int n_iters =3D 0;
> -	struct iov_iter *iters =3D *iterp;
> +	iov_iter_bvec(&segment->iter, ITER_SOURCE, bvec, nvecs, total);
> +	if (start)
> +		iov_iter_advance(&segment->iter, start);
> +	iov_iter_truncate(&segment->iter, segment->len);
> +	segment->use_dio =3D false;
> +}
> =20
> -	/* Setup misaligned start? */
> -	if (args->start_len) {
> -		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
> -		iters[n_iters].count =3D args->start_len;
> -		iter_is_dio_aligned[n_iters] =3D false;
> -		++n_iters;
> -	}
> +static bool
> +nfsd_setup_write_dio_iters(struct nfsd_write_dio_args *args,
> +			   struct bio_vec *bvec, unsigned int nvecs,
> +			   unsigned long total)
> +{
> +	/* first segment */
> +	if (args->segment[0].len)
> +		nfsd_setup_write_dio_seg(&args->segment[0],
> +					 bvec, nvecs, total, 0);
> =20
> -	/* Setup DIO-aligned middle */
> -	iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
> -	if (args->start_len)
> -		iov_iter_advance(&iters[n_iters], args->start_len);
> -	iters[n_iters].count -=3D args->end_len;
> -	iter_is_dio_aligned[n_iters] =3D
> -		nfsd_iov_iter_aligned_bvec(args->nf, &iters[n_iters]);
> -	if (unlikely(!iter_is_dio_aligned[n_iters]))
> -		return 0; /* no DIO-aligned IO possible */
> -	++n_iters;
> +	/* middle segment */
> +	nfsd_setup_write_dio_seg(&args->segment[1], bvec, nvecs, total,
> +				 args->segment[0].len);
> +	if (!nfsd_iov_iter_aligned_bvec(args->nf, &args->segment[1].iter))
> +		return false; /* no DIO-aligned IO possible */
> +	args->segment[1].use_dio =3D true;
> =20
> -	/* Setup misaligned end? */
> -	if (args->end_len) {
> -		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
> -		iov_iter_advance(&iters[n_iters],
> -				 args->start_len + args->middle_len);
> -		iter_is_dio_aligned[n_iters] =3D false;
> -		++n_iters;
> -	}
> +	/* last segment */
> +	if (args->segment[2].len)
> +		nfsd_setup_write_dio_seg(&args->segment[2], bvec, nvecs,
> +					 total, args->segment[0].len +
> +					 args->segment[1].len);
> =20
> -	return n_iters;
> +	return true;
>  }
> =20
>  static int
> @@ -1373,36 +1369,33 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
>  		     unsigned int nvecs, unsigned long *cnt)
>  {
>  	struct file *file =3D args->nf->nf_file;
> -	bool iter_is_dio_aligned[3];
> -	struct iov_iter iter_stack[3];
> -	struct iov_iter *iter =3D iter_stack;
> -	unsigned int n_iters =3D 0;
> -	unsigned long in_count =3D *cnt;
> -	loff_t in_offset =3D kiocb->ki_pos;
> +	struct nfsd_write_dio_seg *segment;
>  	ssize_t host_err;
> +	size_t i;
> =20
> -	n_iters =3D nfsd_setup_write_dio_iters(&iter, iter_is_dio_aligned,
> -					     rqstp->rq_bvec, nvecs, *cnt,
> -					     args);
> -	if (unlikely(!n_iters))
> +	if (!nfsd_setup_write_dio_iters(args, rqstp->rq_bvec, nvecs, *cnt))
>  		return nfsd_iocb_write(file, rqstp->rq_bvec, nvecs,
>  				       cnt, kiocb);
> =20
> -	trace_nfsd_write_direct(rqstp, fhp, in_offset, in_count);
> -
>  	*cnt =3D 0;
> -	for (int i =3D 0; i < n_iters; i++) {
> -		if (iter_is_dio_aligned[i])
> +	segment =3D args->segment;
> +	for (i =3D 0; i < ARRAY_SIZE(args->segment); i++) {
> +		if (segment->len =3D=3D 0)
> +			continue;
> +		if (segment->use_dio) {
>  			kiocb->ki_flags |=3D IOCB_DIRECT;
> -		else
> +			trace_nfsd_write_direct(rqstp, fhp, kiocb->ki_pos,
> +						segment->len);
> +		} else
>  			kiocb->ki_flags &=3D ~IOCB_DIRECT;
> =20
> -		host_err =3D vfs_iocb_iter_write(file, kiocb, &iter[i]);
> +		host_err =3D vfs_iocb_iter_write(file, kiocb, &segment->iter);
>  		if (host_err < 0)
>  			return host_err;
>  		*cnt +=3D host_err;
> -		if (host_err < iter[i].count) /* partial write? */
> +		if (host_err < segment->iter.count)
>  			break;
> +		++segment;
>  	}
> =20
>  	return 0;

--=20
Jeff Layton <jlayton@kernel.org>

