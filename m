Return-Path: <linux-nfs+bounces-16120-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BB8C3A37B
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 11:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFED461D6E
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 10:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2500A30DEDE;
	Thu,  6 Nov 2025 10:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Rz8HkzgU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mm16pD++"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5351430E0E2
	for <linux-nfs@vger.kernel.org>; Thu,  6 Nov 2025 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423923; cv=none; b=P7lzsbF59RpZwVuWUjD4FoB8l5/HdqOrYAeef6MC0p9HANZrmot7sa8cgG4yjoYK45XIMBiOaunUuD4/On9QPgz1lFShVT8AE4VN24WxHAAO+TePiwYjmqSPQkWGv5UMW+5lTOp9yGI9M9TzXtob7jD7P/xdbfH1YG2q5eMU/Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423923; c=relaxed/simple;
	bh=ZaYqEkbqzyh1LLZ/MBP93xhwxnRnrjtF5DQjQiCdkJ8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=AfV1dO+xh5amVfpAi2jKGiJbwLEmXsWvxCi4Fsqu9Prpidw959D515xFWQRRUzby1wDvjTCu8LoQ3soQ5lFJ5U2sly1iD+Up36P67fdkEULmeWuuLS2xDqfoe3X8mxhCZXQa4R3o5OTWJL06LfTCxnKOaxXwbJ2Yen0blDdbNe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Rz8HkzgU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mm16pD++; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 460177A01A9;
	Thu,  6 Nov 2025 05:11:59 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 06 Nov 2025 05:11:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762423919; x=1762510319; bh=Uc2Vl4ndbuEgFDhc1bV85pJd9WWNvcYG/75
	zy0N36Rw=; b=Rz8HkzgUBf0AUjoajCPARamjzvtQahEkXC+czLwG+oDbUxUkMU7
	mLI17prRNwHBhXKCvyUAlglhXSvG/OUKQl/PAoYCZNAlelEyUmQpdiiIqzsbdWXs
	yHj4yfvAcf6izg0M4Qcf6a1UVWOcZKP3E0sm5lZQ62DcWhbGnO4gshRc9C1GMzrs
	DbRxU4/aP1WrtpS1HYacg81SXAjyZrwxN5DvOK/DJKUJLmXAoXL5L5rKk6Dm9Xwn
	UL87f2LPKIOIssRDWXO1fpJxUw8GcJGKUIbtHya+YHRaZJnAAo7lbVXvmOr0coHU
	Th44/cYIouPjF7crx5xOKRcqDA71nKwDtHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762423919; x=
	1762510319; bh=Uc2Vl4ndbuEgFDhc1bV85pJd9WWNvcYG/75zy0N36Rw=; b=M
	m16pD++pwhHwp8beHJ2N9i1hbTw9t4/NQ9bV5DOwd/aP/mjdQi4FMRP2UwjMSHY/
	JikI7xTOpT3TG/sbBMNFYIg/Ug5VTEQU9ybc+7Iv47kHQ+858PbVlneWPMrDf0hx
	pEiKCfbCxWS3gQk2X0v/z9I/VQta5eLdV24ZUrzzbIWDyZFnFUKA8LbIwEosD7Jw
	kRCtgUkOJ4Qg6n3eS9Wv7F9LLZmLNjNL9foR9IT1P0Xd9KcwtSZqqDLpKVoHV4M4
	a03VVaMYkP6q593YQqbeMo9bRTfMVvQ92ZcXasEef54pqJNFOUCRbO0eTRc/KPyO
	ZhiH27qrgX4Ll8mwv4I8w==
X-ME-Sender: <xms:bnQMadrWxFRrIgRXPrIh5fpqjq8hUQSS6p_q8otMdDMtpw_u2tHiFQ>
    <xme:bnQMaetROJyKCnqoNf8egO05DyDOPz_n3baw_Lcmc_1hhv852272sxzRUjRAue-Ma
    r0yGZtiPwXX28cl983TLd9GgQeynhBF7BKeG33MBaMVOk_TQQ>
X-ME-Received: <xmr:bnQMaQbBxP8B5OlbqEMi7M4Dr3boxfUaslivIyJ7zp3UX6qsoXDLTc0c0spjGOswmOAnNLd_L9P8akBr2PzDcdOys8WNEK2-aYrFvbDi9prV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeiheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlh
    gvrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepshhnihhtiigvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjh
    hlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggvlheskhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:bnQMaVaxokbSQj5SAFtR0pGUHHKgrH8l2-ihB0aq9dbhvXG0XoJy5w>
    <xmx:bnQMaRlUH3aBntfknEFcxkrrTF1Oq8mrqAbEy3yC4S2bTE806sRnFg>
    <xmx:bnQMaY1CqYZMUUW3dqGYz9WXuuJZSJdFZlVGY1fcz91pMA5N_S2Y-w>
    <xmx:bnQMaZ1Um4rtHFLoI3bz73iPbt_tyXbB-Yx_dNzCqGOd0Z_vaZP52w>
    <xmx:b3QMaYtywMr4bvUT8Isx7ONTKuxosNrCIt0pIEYRNvbNZBaRscAngz8e>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 05:11:56 -0500 (EST)
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
 "Mike Snitzer" <snitzer@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH v10 4/5] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
In-reply-to: <20251105192806.77093-5-cel@kernel.org>
References: <20251105192806.77093-1-cel@kernel.org>,
 <20251105192806.77093-5-cel@kernel.org>
Date: Thu, 06 Nov 2025 21:11:51 +1100
Message-id: <176242391124.634289.8771352649615589358@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 06 Nov 2025, Chuck Lever wrote:
> From: Mike Snitzer <snitzer@kernel.org>
>=20
> When NFSD_IO_DIRECT is selected via the
> /sys/kernel/debug/nfsd/io_cache_write experimental tunable, split
> incoming unaligned NFS WRITE requests into a prefix, middle and
> suffix segment, as needed. The middle segment is now DIO-aligned and
> the prefix and/or suffix are unaligned. Synchronous buffered IO is
> used for the unaligned segments, and IOCB_DIRECT is used for the
> middle DIO-aligned extent.
>=20
> Although IOCB_DIRECT avoids the use of the page cache, by itself it
> doesn't guarantee data durability. For UNSTABLE WRITE requests,
> durability is obtained by a subsequent NFS COMMIT request.
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Co-developed-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/debugfs.c |   1 +
>  fs/nfsd/trace.h   |   1 +
>  fs/nfsd/vfs.c     | 170 ++++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 168 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> index 00eb1ecef6ac..7f44689e0a53 100644
> --- a/fs/nfsd/debugfs.c
> +++ b/fs/nfsd/debugfs.c
> @@ -108,6 +108,7 @@ static int nfsd_io_cache_write_set(void *data, u64 val)
>  	switch (val) {
>  	case NFSD_IO_BUFFERED:
>  	case NFSD_IO_DONTCACHE:
> +	case NFSD_IO_DIRECT:
>  		nfsd_io_cache_write =3D val;
>  		break;
>  	default:
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index bfd41236aff2..ad74439d0105 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -469,6 +469,7 @@ DEFINE_NFSD_IO_EVENT(read_io_done);
>  DEFINE_NFSD_IO_EVENT(read_done);
>  DEFINE_NFSD_IO_EVENT(write_start);
>  DEFINE_NFSD_IO_EVENT(write_opened);
> +DEFINE_NFSD_IO_EVENT(write_direct);
>  DEFINE_NFSD_IO_EVENT(write_io_done);
>  DEFINE_NFSD_IO_EVENT(write_done);
>  DEFINE_NFSD_IO_EVENT(commit_start);
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index f3be36b960e5..8158e129a560 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1254,6 +1254,161 @@ static int wait_for_concurrent_writes(struct file *=
file)
>  	return err;
>  }
> =20
> +struct nfsd_write_dio_seg {
> +	struct iov_iter			iter;
> +	bool				use_dio;

This is only used to choose which flags to use.
I think it would be neater the have 'flags' here explicitly.

> +};
> +
> +struct nfsd_write_dio_args {
> +	struct nfsd_file		*nf;
> +	int				flags_buffered;
> +	int				flags_direct;

The difference between these two is that the latter has IOCB_DIRECT.
So we don't need both.  Just have 'flags' and when we currently use
"flags_direct", use "flag | IOCB_DIRECT" instead.

> +	unsigned int			nsegs;
> +	struct nfsd_write_dio_seg	segment[3];
> +};
> +
> +/*
> + * Check if the bvec iterator is aligned for direct I/O.
> + *
> + * bvecs generated from RPC receive buffers are contiguous: After the first
> + * bvec, all subsequent bvecs start at bv_offset zero (page-aligned).
> + * Therefore, only the first bvec is checked.
> + */
> +static bool
> +nfsd_iov_iter_aligned_bvec(const struct nfsd_file *nf, const struct iov_it=
er *i)
> +{
> +	unsigned int addr_mask =3D nf->nf_dio_mem_align - 1;
> +	const struct bio_vec *bvec =3D i->bvec;
> +
> +	return ((unsigned long)(bvec->bv_offset + i->iov_offset) & addr_mask) =3D=
=3D 0;
> +}
> +
> +static void
> +nfsd_write_dio_seg_init(struct nfsd_write_dio_seg *segment,
> +			struct bio_vec *bvec, unsigned int nvecs,
> +			unsigned long total, size_t start, size_t len)

If we passed 'args' in here then:
 - we wouldn't need segment or bvec
 - we could increment nsegs in one place
 - we would have direct access to 'flags'.

possibly a 'direct' flag could be passed in which causes IOCB_DIRECT to
be set, and triggers failure if DIRECT isn't possible.

I'm not certain all the above changes are a certain win, but I ask you
to consider them and see if you think it makes the code cleaner.


> +{
> +	iov_iter_bvec(&segment->iter, ITER_SOURCE, bvec, nvecs, total);
> +	if (start)
> +		iov_iter_advance(&segment->iter, start);
> +	iov_iter_truncate(&segment->iter, len);
> +	segment->use_dio =3D false;
> +}
> +
> +static void
> +nfsd_write_dio_iters_init(struct bio_vec *bvec, unsigned int nvecs,
> +			  loff_t offset, unsigned long total,
> +			  struct nfsd_write_dio_args *args)
> +{
> +	u32 offset_align =3D args->nf->nf_dio_offset_align;
> +	u32 mem_align =3D args->nf->nf_dio_mem_align;
> +	loff_t prefix_end, orig_end, middle_end;
> +	size_t prefix, middle, suffix;
> +
> +	args->nsegs =3D 0;
> +
> +	/*
> +	 * Check if direct I/O is feasible for this write request.
> +	 * If alignments are not available, the write is too small,
> +	 * or no alignment can be found, fall back to buffered I/O.
> +	 */
> +	if (unlikely(!mem_align || !offset_align) ||
> +	    unlikely(total < max(offset_align, mem_align)))
> +		goto no_dio;
> +
> +	/* Calculate aligned segments */
> +	prefix_end =3D round_up(offset, offset_align);
> +	orig_end =3D offset + total;
> +	middle_end =3D round_down(orig_end, offset_align);
> +
> +	prefix =3D prefix_end - offset;
> +	middle =3D middle_end - prefix_end;
> +	suffix =3D orig_end - middle_end;
> +
> +	if (!middle)
> +		goto no_dio;
> +
> +	if (prefix) {
> +		nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec,
> +					nvecs, total, 0, prefix);
> +		++args->nsegs;
> +	}
> +
> +	nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec, nvecs,
> +				total, prefix, middle);
> +	if (!nfsd_iov_iter_aligned_bvec(args->nf,
> +					&args->segment[args->nsegs].iter))
> +		goto no_dio;
> +	args->segment[args->nsegs].use_dio =3D true;
> +	++args->nsegs;
> +
> +	if (suffix) {
> +		nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec,
> +					nvecs, total, prefix + middle, suffix);
> +		++args->nsegs;
> +	}
> +
> +	return;
> +
> +no_dio:
> +	/*
> +	 * No DIO alignment possible - pack into single non-DIO segment.
> +	 * IOCB_DONTCACHE preserves the intent of NFSD_IO_DIRECT.
> +	 */
> +	if (args->nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
> +		args->flags_buffered |=3D IOCB_DONTCACHE;
> +	nfsd_write_dio_seg_init(&args->segment[0], bvec, nvecs, total,
> +				0, total);
> +	args->nsegs =3D 1;
> +}
> +
> +static int
> +nfsd_issue_dio_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +		     struct kiocb *kiocb, unsigned int nvecs,
> +		     unsigned long *cnt, struct nfsd_write_dio_args *args)
> +{
> +	struct file *file =3D args->nf->nf_file;
> +	ssize_t host_err;
> +	unsigned int i;
> +
> +	nfsd_write_dio_iters_init(rqstp->rq_bvec, nvecs, kiocb->ki_pos,
> +				  *cnt, args);
> +
> +	*cnt =3D 0;
> +	for (i =3D 0; i < args->nsegs; i++) {
> +		if (args->segment[i].use_dio) {
> +			kiocb->ki_flags =3D args->flags_direct;
> +			trace_nfsd_write_direct(rqstp, fhp, kiocb->ki_pos,
> +						args->segment[i].iter.count);
> +		} else
> +			kiocb->ki_flags =3D args->flags_buffered;

Why do we trace the direct write, but not the buffered write?

Thanks,
NeilBrown



> +
> +		host_err =3D vfs_iocb_iter_write(file, kiocb,
> +					       &args->segment[i].iter);
> +		if (host_err < 0)
> +			return host_err;
> +		*cnt +=3D host_err;
> +		if (host_err < args->segment[i].iter.count)
> +			break;	/* partial write */
> +	}
> +
> +	return 0;
> +}
> +
> +static noinline_for_stack int
> +nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +		  struct nfsd_file *nf, unsigned int nvecs,
> +		  unsigned long *cnt, struct kiocb *kiocb)
> +{
> +	struct nfsd_write_dio_args args;
> +
> +	args.flags_direct =3D kiocb->ki_flags | IOCB_DIRECT;
> +	args.flags_buffered =3D kiocb->ki_flags;
> +	args.nf =3D nf;
> +
> +	return nfsd_issue_dio_write(rqstp, fhp, kiocb, nvecs, cnt, &args);
> +}
> +
>  /**
>   * nfsd_vfs_write - write data to an already-open file
>   * @rqstp: RPC execution context
> @@ -1329,25 +1484,32 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_f=
h *fhp,
>  	}
> =20
>  	nvecs =3D xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
> -	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> +
>  	since =3D READ_ONCE(file->f_wb_err);
>  	if (verf)
>  		nfsd_copy_write_verifier(verf, nn);
> =20
>  	switch (nfsd_io_cache_write) {
> -	case NFSD_IO_BUFFERED:
> +	case NFSD_IO_DIRECT:
> +		host_err =3D nfsd_direct_write(rqstp, fhp, nf, nvecs,
> +					     cnt, &kiocb);
>  		break;
>  	case NFSD_IO_DONTCACHE:
>  		if (file->f_op->fop_flags & FOP_DONTCACHE)
>  			kiocb.ki_flags |=3D IOCB_DONTCACHE;
> +		fallthrough;
> +	case NFSD_IO_BUFFERED:
> +		iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> +		host_err =3D vfs_iocb_iter_write(file, &kiocb, &iter);
> +		if (host_err < 0)
> +			break;
> +		*cnt =3D host_err;
>  		break;
>  	}
> -	host_err =3D vfs_iocb_iter_write(file, &kiocb, &iter);
>  	if (host_err < 0) {
>  		commit_reset_write_verifier(nn, rqstp, host_err);
>  		goto out_nfserr;
>  	}
> -	*cnt =3D host_err;
>  	nfsd_stats_io_write_add(nn, exp, *cnt);
>  	fsnotify_modify(file);
>  	host_err =3D filemap_check_wb_err(file->f_mapping, since);
> --=20
> 2.51.0
>=20
>=20


