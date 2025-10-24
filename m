Return-Path: <linux-nfs+bounces-15607-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D199C06F6F
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 17:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 381B14E76AF
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 15:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D9D31E101;
	Fri, 24 Oct 2025 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuppNjrw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C3331D727
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319610; cv=none; b=P7sUnu4DkkHteCx6jGHw35aTk9jBQKMbyG4b/igVadQHnvxx3S92w/W19sxqTjJUluEp8YCjt0uN6kmMeRBFKcRTHOZVxFuZSL5QDj6g4A6V+AnEFdkZsyz2D4/eL70JByBYEDLl3ojfdMRt/WK0w3rjwBVVe3uirombeCWZiWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319610; c=relaxed/simple;
	bh=Kw8JOKaxUL6c/YHekYIpb9e75+ygxc1rUwd96UKkB/8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DMYBH1ujO8oZqeRdU/xbvO7+k1peYXPdvdtYrx0cs8iQnNQGE06k049UhUkm+gxyBe2topIPaLCMGyYgKE06xCKvLflUTuTrVAWqgMK9kfG3QL+LNw2634ibN63zeDA5RRGiCvchPwgiugk2VW23ZoKuig/2Xhw6nGwg5Q191mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuppNjrw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E02C4CEF1;
	Fri, 24 Oct 2025 15:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761319609;
	bh=Kw8JOKaxUL6c/YHekYIpb9e75+ygxc1rUwd96UKkB/8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=RuppNjrwbvraHTC+Qh6hLSr3NKop9UFfBLVjS1eM0MZwvccolSvmfqbGlvtg8JVe8
	 9Wt3Er0aGdQmyJKJNxBJvBgmZ7ef1gkIBbLPte5gKbwTWQP7ZZU4Y/i4d4U78yvzyE
	 4sfpEdNopqKXJ5VkPOcGU1tSsOgTO0LL4Oko+u1gDHAercanpdLbmEgKhZfc62i3FB
	 M58pJtcvhGIJ4mOwqMgnar02epImQLPewZkoXyzJsTfGMjWAjwPY8ZRBfJwzp1J2YG
	 kPk0scaj9/BOd/Ln6TovxqDxBqTLZd32H7LQ4Sj5jVMkmliW7tKe7xmcQUIi/eYZWd
	 piukBXaw3+u3w==
Message-ID: <b3b40c48fefbf8f35efa0a3e06403f1451982719.camel@kernel.org>
Subject: Re: [PATCH v7 11/14] NFSD: Clean up struct nfsd_write_dio
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Date: Fri, 24 Oct 2025 11:26:47 -0400
In-Reply-To: <20251024144306.35652-12-cel@kernel.org>
References: <20251024144306.35652-1-cel@kernel.org>
	 <20251024144306.35652-12-cel@kernel.org>
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
> Prepare for moving more common arguments into the shared per-request
> structure.
>=20
> First step is to move the target nfsd_file into that structure, as
> it needs to be available in several functions.
>=20
> As a clean-up, adopt the common naming of a structure that carries
> the arguments for a number of functions.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/vfs.c | 61 ++++++++++++++++++++++++++-------------------------
>  1 file changed, 31 insertions(+), 30 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index e7c3458bd178..429f5fc61ead 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1254,21 +1254,22 @@ static int wait_for_concurrent_writes(struct file=
 *file)
>  	return err;
>  }
> =20
> -struct nfsd_write_dio {
> +struct nfsd_write_dio_args {
> +	struct nfsd_file		*nf;
> +
>  	ssize_t	start_len;	/* Length for misaligned first extent */
>  	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
>  	ssize_t	end_len;	/* Length for misaligned last extent */
>  };
> =20
>  static bool
> -nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
> -			   struct nfsd_file *nf,
> -			   struct nfsd_write_dio *write_dio)
> +nfsd_is_write_dio_possible(struct nfsd_write_dio_args *args, loff_t offs=
et,
> +			   unsigned long len)
>  {
> -	const u32 dio_blocksize =3D nf->nf_dio_offset_align;
> +	const u32 dio_blocksize =3D args->nf->nf_dio_offset_align;
>  	loff_t start_end, orig_end, middle_end;
> =20
> -	if (unlikely(!nf->nf_dio_mem_align || !dio_blocksize))
> +	if (unlikely(!args->nf->nf_dio_mem_align || !dio_blocksize))
>  		return false;
>  	if (unlikely(len < dio_blocksize))
>  		return false;
> @@ -1277,9 +1278,9 @@ nfsd_is_write_dio_possible(loff_t offset, unsigned =
long len,
>  	orig_end =3D offset + len;
>  	middle_end =3D round_down(orig_end, dio_blocksize);
> =20
> -	write_dio->start_len =3D start_end - offset;
> -	write_dio->middle_len =3D middle_end - start_end;
> -	write_dio->end_len =3D orig_end - middle_end;
> +	args->start_len =3D start_end - offset;
> +	args->middle_len =3D middle_end - start_end;
> +	args->end_len =3D orig_end - middle_end;
> =20
>  	return true;
>  }
> @@ -1314,36 +1315,35 @@ nfsd_iov_iter_aligned_bvec(const struct nfsd_file=
 *nf, const struct iov_iter *i)
>  static int
>  nfsd_setup_write_dio_iters(struct iov_iter **iterp, bool *iter_is_dio_al=
igned,
>  			   struct bio_vec *rq_bvec, unsigned int nvecs,
> -			   unsigned long cnt, struct nfsd_write_dio *write_dio,
> -			   struct nfsd_file *nf)
> +			   unsigned long cnt, struct nfsd_write_dio_args *args)
>  {
>  	int n_iters =3D 0;
>  	struct iov_iter *iters =3D *iterp;
> =20
>  	/* Setup misaligned start? */
> -	if (write_dio->start_len) {
> +	if (args->start_len) {
>  		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
> -		iters[n_iters].count =3D write_dio->start_len;
> +		iters[n_iters].count =3D args->start_len;
>  		iter_is_dio_aligned[n_iters] =3D false;
>  		++n_iters;
>  	}
> =20
>  	/* Setup DIO-aligned middle */
>  	iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
> -	if (write_dio->start_len)
> -		iov_iter_advance(&iters[n_iters], write_dio->start_len);
> -	iters[n_iters].count -=3D write_dio->end_len;
> +	if (args->start_len)
> +		iov_iter_advance(&iters[n_iters], args->start_len);
> +	iters[n_iters].count -=3D args->end_len;
>  	iter_is_dio_aligned[n_iters] =3D
> -		nfsd_iov_iter_aligned_bvec(nf, &iters[n_iters]);
> +		nfsd_iov_iter_aligned_bvec(args->nf, &iters[n_iters]);
>  	if (unlikely(!iter_is_dio_aligned[n_iters]))
>  		return 0; /* no DIO-aligned IO possible */
>  	++n_iters;
> =20
>  	/* Setup misaligned end? */
> -	if (write_dio->end_len) {
> +	if (args->end_len) {
>  		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
>  		iov_iter_advance(&iters[n_iters],
> -				 write_dio->start_len + write_dio->middle_len);
> +				 args->start_len + args->middle_len);
>  		iter_is_dio_aligned[n_iters] =3D false;
>  		++n_iters;
>  	}
> @@ -1369,11 +1369,10 @@ nfsd_iocb_write(struct file *file, struct bio_vec=
 *bvec, unsigned int nvecs,
> =20
>  static int
>  nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		     struct nfsd_file *nf, unsigned int nvecs,
> -		     unsigned long *cnt, struct kiocb *kiocb,
> -		     struct nfsd_write_dio *write_dio)
> +		     struct nfsd_write_dio_args *args, struct kiocb *kiocb,
> +		     unsigned int nvecs, unsigned long *cnt)
>  {
> -	struct file *file =3D nf->nf_file;
> +	struct file *file =3D args->nf->nf_file;
>  	bool iter_is_dio_aligned[3];
>  	struct iov_iter iter_stack[3];
>  	struct iov_iter *iter =3D iter_stack;
> @@ -1384,7 +1383,7 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
> =20
>  	n_iters =3D nfsd_setup_write_dio_iters(&iter, iter_is_dio_aligned,
>  					     rqstp->rq_bvec, nvecs, *cnt,
> -					     write_dio, nf);
> +					     args);
>  	if (unlikely(!n_iters))
>  		return nfsd_iocb_write(file, rqstp->rq_bvec, nvecs,
>  				       cnt, kiocb);
> @@ -1414,14 +1413,15 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
>  		  struct nfsd_file *nf, unsigned int nvecs,
>  		  unsigned long *cnt, struct kiocb *kiocb)
>  {
> -	struct nfsd_write_dio write_dio;
> +	struct file *file =3D nf->nf_file;
> +	struct nfsd_write_dio_args args;
> =20
>  	/*
>  	 * Check if IOCB_DONTCACHE can be used when issuing buffered IO;
>  	 * if so, set it to preserve intent of NFSD_IO_DIRECT (it will
>  	 * be ignored for any DIO issued here).
>  	 */
> -	if (nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
> +	if (file->f_op->fop_flags & FOP_DONTCACHE)
>  		kiocb->ki_flags |=3D IOCB_DONTCACHE;
> =20
>  	/*
> @@ -1435,11 +1435,12 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
>  	 */
>  	kiocb->ki_flags |=3D IOCB_SYNC | IOCB_DSYNC;
> =20
> -	if (nfsd_is_write_dio_possible(kiocb->ki_pos, *cnt, nf, &write_dio))
> -		return nfsd_issue_write_dio(rqstp, fhp, nf, nvecs, cnt, kiocb,
> -					    &write_dio);
> +	args.nf =3D nf;
> +	if (nfsd_is_write_dio_possible(&args, kiocb->ki_pos, *cnt))
> +		return nfsd_issue_write_dio(rqstp, fhp, &args, kiocb,
> +					    nvecs, cnt);
> =20
> -	return nfsd_iocb_write(nf->nf_file, rqstp->rq_bvec, nvecs, cnt, kiocb);
> +	return nfsd_iocb_write(file, rqstp->rq_bvec, nvecs, cnt, kiocb);
>  }
> =20
>  /**

Reviewed-by: Jeff Layton <jlayton@kernel.org>

