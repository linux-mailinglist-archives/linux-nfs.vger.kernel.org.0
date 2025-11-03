Return-Path: <linux-nfs+bounces-15978-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D640C2E4D3
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 23:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE3844E1795
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 22:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ABA1F936;
	Mon,  3 Nov 2025 22:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="fjew80Jy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J7equJXK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA0C28E5
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 22:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762209943; cv=none; b=fzbDJtiAOVqeK4qt5Bg+kMXLmhkPUGNXdH3Ld3IrHxg9OCSJOv+JOcAt3Y3moatN8ZEYvki6ElROfS1eRUsKotazjD7gMPnHHhP1enV72L1CLmuK01JkqJ7sbwVIvCtUkEx5jrIX/WXojSSzWQedgk1elqS6gWHwhCoTEt44LK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762209943; c=relaxed/simple;
	bh=xrbEj1E9t+FZsbEPgJ3xeK2bWZlwxWw42Xs8ctSlW8o=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=HXUlr1Ms6j/z+kkxvK72juED6u+fYxa2XXBRjoVJOqrG0OkqlD7WchtTs+y/Cb1U3i/g0ar6ML6GxY56ZaeSxC3andFNyuKqMXPreXqGLqrep/7K5h3yg3h449KWHPLKsX+3B2h0D5l1hbUA5z0m+ZBd7/vYC//GnHHv6/SoCHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=fjew80Jy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J7equJXK; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6DEE4EC0274;
	Mon,  3 Nov 2025 17:45:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 03 Nov 2025 17:45:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762209940; x=1762296340; bh=kcF/tHv47DoF6gYVzrJXD5mHgpfiYBSE7Rx
	TegWXb3E=; b=fjew80Jyfd9KB2Q7aGawy3C2yIoCJMC0Y8qiYkb6INTL7B2TYEb
	gnQgx5eT/uOXjuqv7FbfAw+b1p4fB0JWGhXOS3X9cn6JCai+7Amc7wPzTId3K9fC
	LCq3N6vU82g9vlqm53NxHjzOCugEmuORv6WG0IXhNpw+3qK6rqMvG/Jvwz6mDdfA
	+Y64h35VxwjLXRndxYq950O1E8wMA+m2X8PNWdsbjOX/i1AayWDgIteA8uuXZlgB
	weaqBHzDmYDSjjcjizjr0ZCb+WR75p1ayBKRJaT2JLKNpEXHrMH9kdtaUK6HAeH3
	cyF4OY63CGq8rZsGMvNEdWKL5tiIZNAgH5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762209940; x=
	1762296340; bh=kcF/tHv47DoF6gYVzrJXD5mHgpfiYBSE7RxTegWXb3E=; b=J
	7equJXK7yfXTRubX16A3NsYWA+ZoitUt8VqODQ3/PVXpH0+vGs3O/AtlCkvelKI0
	Ak5nSL/7qB6Hd/fCPnVgkvifbm8LPkynzfty6XgLFCtLO2ZbtAUqa3eBbYa7imlp
	EGkHnyqwO3KL8/QB1Fb/kkBq1nqFsCxxJSKZn1f1PD0Cv4QxIjqMhwWZ+3vCW6Lq
	0iy0HE3O0EPMo0wo7lRaZiabKNrx8EedgkdOCF30/P0UbUgkpzR+YZzRygaKufur
	6HocDCuKe6ncgq1LrGyBabFyoOU9oCSKbVG7Rfl/7g/dlehP0epjcBaym4M0BYvn
	d18fiT34pSqrN+coZvfhA==
X-ME-Sender: <xms:lDAJabUGJZRlI6ydobxMti-4jnwBVXUa4uBYuhxDcOvQnY8DGRI__g>
    <xme:lDAJaWJZWq8krP9oG6LpLVFDRaZe4FuDzFNSD8A8gbrZ4vrpLijKQgQCrk01svGNQ
    _Y3zui0nYnYBG_xesv2yfm_BSn2M_g7LeQm_AKFUkDDRvssZg>
X-ME-Received: <xmr:lDAJabDvO7-7FlbO4AVkeFiXgNzSdRU_I9tS7V7lDF48sJfbZ15vHxRbDgS-cycPr5r1kI4AbNAnLMRyKUyhcy6Z5LuWBIsIw5yLdVbNcE-k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeelfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlh
    gvrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohephhgthheslhhsthdruggvpdhrtghpthhtohepshhnihhtiigvrheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheptggvlheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lDAJaWfjqeleRxqlum2aM9cvyWPbSKYl9rXFvSkVjyPxl2AcXQmRIQ>
    <xmx:lDAJaa2MGJZvPJghGKHpnpw0ycavfr_BdWKTZgU9W2kBa-vXnINR3Q>
    <xmx:lDAJadgJ9b26Q_pAOJFFP7Ievyy-5x2zVGL1pPUC5LWReQ8RVeeQ8A>
    <xmx:lDAJaTk9VDSFuITuQCdL_UTuFaYdTrUPkyGDaex2LwwUlZWiP_p4jg>
    <xmx:lDAJafpQP0-3LyFop5Ry7RSxLhRmea8RlRUv1P9WP-MtMhMAqIF7DBEa>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 17:45:37 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>, "Christoph Hellwig" <hch@lst.de>,
 "Mike Snitzer" <snitzer@kernel.org>
Subject: Re: [PATCH v9 07/12] NFSD: Introduce struct nfsd_write_dio_seg
In-reply-to: <20251103165351.10261-8-cel@kernel.org>
References: <20251103165351.10261-1-cel@kernel.org>,
 <20251103165351.10261-8-cel@kernel.org>
Date: Tue, 04 Nov 2025 09:45:35 +1100
Message-id: <176220993570.1793333.17159889042261464805@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 04 Nov 2025, Chuck Lever wrote:
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
> Consensus is that allowing the code to build segment arrays that
> are smaller than 3 is better than the I/O loop unconditionally
> visiting all 3 segments, skipping the zero-length ones.
>=20
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/vfs.c | 120 ++++++++++++++++++++++++--------------------------
>  1 file changed, 58 insertions(+), 62 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 326c60eada65..5d6efcceb8c9 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1254,12 +1254,16 @@ static int wait_for_concurrent_writes(struct file *=
file)
>  	return err;
>  }
> =20
> +struct nfsd_write_dio_seg {
> +	struct iov_iter			iter;
> +	bool				use_dio;
> +};
> +
>  struct nfsd_write_dio_args {
>  	struct nfsd_file		*nf;
> -
> -	ssize_t	start_len;	/* Length for misaligned first extent */
> -	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
> -	ssize_t	end_len;	/* Length for misaligned last extent */
> +	size_t				first, middle, last;
> +	unsigned int			nsegs;
> +	struct nfsd_write_dio_seg	segment[3];
>  };
> =20
>  static bool
> @@ -1267,21 +1271,20 @@ nfsd_is_write_dio_possible(loff_t offset, unsigned =
long len,
>  			   struct nfsd_write_dio_args *args)
>  {
>  	u32 dio_blocksize =3D args->nf->nf_dio_offset_align;
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
> =20
> -	args->start_len =3D start_end - offset;
> -	args->middle_len =3D middle_end - start_end;
> -	args->end_len =3D orig_end - middle_end;
> -
> +	args->first =3D first_end - offset;
> +	args->middle =3D middle_end - first_end;
> +	args->last =3D orig_end - middle_end;

The commit message didn't warn that "start" is being renamed to "first"
and that "_len" is being dropped.
I can understand the former (though I'd go for "head", "body", "tail"
myself) but I would prefer to keep _len.

>  	return true;
>  }
> =20
> @@ -1311,47 +1314,47 @@ nfsd_iov_iter_aligned_bvec(const struct nfsd_file *=
nf, const struct iov_iter *i)
>  	return true;
>  }
> =20
> -/*
> - * Setup as many as 3 iov_iter based on extents described by @write_dio.
> - * Returns the number of iov_iter that were setup.
> - */
> -static int
> -nfsd_setup_write_dio_iters(struct iov_iter **iterp, bool *iter_is_dio_alig=
ned,
> -			   struct bio_vec *rq_bvec, unsigned int nvecs,
> -			   unsigned long cnt, struct nfsd_write_dio_args *args)
> +static void
> +nfsd_write_dio_seg_init(struct nfsd_write_dio_seg *segment,
> +			struct bio_vec *bvec, unsigned int nvecs,
> +			unsigned long total, size_t start, size_t len)
>  {
> -	int n_iters =3D 0;
> -	struct iov_iter *iters =3D *iterp;
> +	iov_iter_bvec(&segment->iter, ITER_SOURCE, bvec, nvecs, total);
> +	if (start)
> +		iov_iter_advance(&segment->iter, start);

To me, this would read better as
     if (start_len)
              iov_iter......


But I don't see anything actually wrong with the patch, so
 Reviewed-by: NeilBrown <neil@brown.name>

NeilBrown



> +	iov_iter_truncate(&segment->iter, len);
> +	segment->use_dio =3D false;
> +}
> =20
> -	/* Setup misaligned start? */
> -	if (args->start_len) {
> -		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
> -		iters[n_iters].count =3D args->start_len;
> -		iter_is_dio_aligned[n_iters] =3D false;
> -		++n_iters;
> +static bool
> +nfsd_setup_write_dio_iters(struct bio_vec *bvec, unsigned int nvecs,
> +			   unsigned long total,
> +			   struct nfsd_write_dio_args *args)
> +{
> +	args->nsegs =3D 0;
> +
> +	if (args->first) {
> +		nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec,
> +					nvecs, total, 0, args->first);
> +		++args->nsegs;
>  	}
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
> +	nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec, nvecs,
> +				total, args->first, args->middle);
> +	if (!nfsd_iov_iter_aligned_bvec(args->nf,
> +					&args->segment[args->nsegs].iter))
> +		return false;	/* no DIO-aligned IO possible */
> +	args->segment[args->nsegs].use_dio =3D true;
> +	++args->nsegs;
> =20
> -	/* Setup misaligned end? */
> -	if (args->end_len) {
> -		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
> -		iov_iter_advance(&iters[n_iters],
> -				 args->start_len + args->middle_len);
> -		iter_is_dio_aligned[n_iters] =3D false;
> -		++n_iters;
> +	if (args->last) {
> +		nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec,
> +					nvecs, total, args->first +
> +					args->middle, args->last);
> +		++args->nsegs;
>  	}
> =20
> -	return n_iters;
> +	return true;
>  }
> =20
>  static int
> @@ -1377,22 +1380,12 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct=
 svc_fh *fhp, u32 *stable_how
>  		     struct nfsd_write_dio_args *args)
>  {
>  	struct file *file =3D args->nf->nf_file;
> -	bool iter_is_dio_aligned[3];
> -	struct iov_iter iter_stack[3];
> -	struct iov_iter *iter =3D iter_stack;
> -	unsigned int n_iters =3D 0;
> -	unsigned long in_count =3D *cnt;
> -	loff_t in_offset =3D kiocb->ki_pos;
>  	ssize_t host_err;
> +	unsigned int i;
> =20
> -	n_iters =3D nfsd_setup_write_dio_iters(&iter, iter_is_dio_aligned,
> -					     rqstp->rq_bvec, nvecs, *cnt,
> -					     args);
> -	if (unlikely(!n_iters))
> +	if (!nfsd_setup_write_dio_iters(rqstp->rq_bvec, nvecs, *cnt, args))
>  		return nfsd_buffered_write(rqstp, file, nvecs, cnt, kiocb);
> =20
> -	trace_nfsd_write_direct(rqstp, fhp, in_offset, in_count);
> -
>  	/*
>  	 * Any buffered IO issued here will be misaligned, use
>  	 * sync IO to ensure it has completed before returning.
> @@ -1402,18 +1395,21 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct=
 svc_fh *fhp, u32 *stable_how
>  	*stable_how =3D NFS_FILE_SYNC;
> =20
>  	*cnt =3D 0;
> -	for (int i =3D 0; i < n_iters; i++) {
> -		if (iter_is_dio_aligned[i])
> +	for (i =3D 0; i < args->nsegs; i++) {
> +		if (args->segment[i].use_dio) {
>  			kiocb->ki_flags |=3D IOCB_DIRECT;
> -		else
> +			trace_nfsd_write_direct(rqstp, fhp, kiocb->ki_pos,
> +						args->segment[i].iter.count);
> +		} else
>  			kiocb->ki_flags &=3D ~IOCB_DIRECT;
> =20
> -		host_err =3D vfs_iocb_iter_write(file, kiocb, &iter[i]);
> +		host_err =3D vfs_iocb_iter_write(file, kiocb,
> +					       &args->segment[i].iter);
>  		if (host_err < 0)
>  			return host_err;
>  		*cnt +=3D host_err;
> -		if (host_err < iter[i].count) /* partial write? */
> -			break;
> +		if (host_err < args->segment[i].iter.count)
> +			break;	/* partial write */
>  	}
> =20
>  	return 0;
> --=20
> 2.51.0
>=20
>=20


