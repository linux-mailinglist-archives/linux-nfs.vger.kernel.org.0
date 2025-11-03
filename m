Return-Path: <linux-nfs+bounces-15981-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEF6C2E541
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 23:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C11E4E7A14
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 22:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812AE2E7624;
	Mon,  3 Nov 2025 22:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Bss7LCDC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RchXUG5Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ED72FC861
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 22:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762210553; cv=none; b=JYNnr6HzVIQ8otCVBSDZoMlYpfmstKet1O4Mxzybbohiz/9nb+IaDYceH7HRDIuX0lgu99zFmOJTTjgEGDoYUJFGSETRfVXd1fvfYcMEf8PrHZMdTJgYqIHQwbL4cMRKC/GVhBORzFATofIr6pB8MCiRZcrfDaOkbPyVyvRe9OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762210553; c=relaxed/simple;
	bh=HufgfZ9gAX8oMD2zgfQ1T+69ZQ3MBsKyQf9XKW0kls4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=YWssXxtgVw4D4li6jUZiiZYWxP2T+aNJ2Ba1TkIPzRYsI4ftFzqa1k6sHiGXYYwRFgdM/X8uCUVbZ1o1xyp+KPZdBC2qO1m0XhO9/og9HhzVmWoLJ8+CLUVJrmihfN1uF/OA4EzeZ6v5w90d2XAetLaNb+3KggW3Zby8eUFRYQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Bss7LCDC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RchXUG5Z; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id BECBCEC0466;
	Mon,  3 Nov 2025 17:55:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 03 Nov 2025 17:55:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762210550; x=1762296950; bh=OmMoLSbGIBRNSSyvPRPp+NH848VtU+jmIxR
	zpIRnj9Y=; b=Bss7LCDCx34rO4fottcMXdazjjxbXPQ9K4tjKA0xlKhpcjxnpIm
	6vHZQVpNCNuThUkEusfF0VbX+n82FsgRAn8AIm6RI7S3Mw2ywfd2BY88Bea+uZ8j
	sxXfUNRhAaDx+qWlKiQoFH/rNcZLoSfh7+XtYKCuzVCHeRnSRDSZ8o/4jrpSWTKf
	k+/DJKJgWPot7lPwQVAySYjXx+FD3769tJmnM7sMrKtwwZcH4GHXx9y4dxEP/UOD
	Jz8RX5E08XHhfX2RFwQtTS4wBFEE82I87ErYQyr0JjC70JoE2QTzMaR09GAFKQWj
	AcjnOk/PxPiGSCdQd4Y9i7ZSNEw8PHWNlGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762210550; x=
	1762296950; bh=OmMoLSbGIBRNSSyvPRPp+NH848VtU+jmIxRzpIRnj9Y=; b=R
	chXUG5ZJlCrSZTjcueOLLM0A0H3HxLHItdLes0lpEPl4zauWHtLKWDA7W6pt5CDR
	6oOYffMsXQnLNGfYUSLKUQjDhnnTAW9JzFwo30fVsyx/C1mbxEHGWlhNK/udd/FS
	IX6Rxsbln01x39m/rsyjv82ehmIhkzsGvfWMMz05+niec3RcM8vBNoF0Ap5C8icZ
	ebvCVUAcYN0jJcox84YkpNXnk8s2AifmZR1n9Nvi0+RETwAXPA9bRtLI6pRfsJXJ
	ieAIx4Rim1tsUHfHFO2z9KkoKMAKXbqxXXA0+JiiKmJgZ3nCpF8+lhX8CN8OgKqM
	SZsWZeEInoIb3vlPzNk8Q==
X-ME-Sender: <xms:9jIJaT4hpf6SWrjVCdESqyIDDPGVjYenVCN7eOjxJasTKjFhQyfAFw>
    <xme:9jIJabLfIjCFP47ikjoP1jGjRT9YgRav8Sr39UIB7G0ZWs-_eWQztWgf5zIvD-spY
    aJQEw5Ro8VA-rEyJA-kwYmszHDHIXni9viwZhJli5aUgZeeuA>
X-ME-Received: <xmr:9jIJacsGL1NMyIpZ_MA6JKUjUJEnnjzqgKlPf1Mb3wTs3lVfP3iFSpJ4ruhhO7cZ-JukuSrarfFWAJKekJR5Z96AXq7USDpZ_k9hnfFpKoEl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeelfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlh
    gvrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptg
    gvlheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9jIJaaK084aIcw-i12UODkzDFGzCeYbn6gTTz54robkLfCqo1Rf_QQ>
    <xmx:9jIJaV9JGrONTs4PdtZehQaiqk9Q-3UnEUAn3OTVGfEum2NVbXhcfQ>
    <xmx:9jIJaTz3_TeJrRbrLVPpFg41jXwhTF7h30-MyrxOyipeJuH0wNuqMg>
    <xmx:9jIJaS6IbGq1vSlzR_pRRvvxQI10eYsHfzF5g0wJ4it9xSD1_D7I1w>
    <xmx:9jIJae0XMBoTYtof9COKpnqhxS17VYA2qQDeFK-QDvJtowr2HrgH2G1o>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 17:55:48 -0500 (EST)
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
 "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH v9 09/12] NFSD: Combine direct I/O feasibility check with
 iterator setup
In-reply-to: <20251103165351.10261-10-cel@kernel.org>
References: <20251103165351.10261-1-cel@kernel.org>,
 <20251103165351.10261-10-cel@kernel.org>
Date: Tue, 04 Nov 2025 09:55:46 +1100
Message-id: <176221054641.1793333.13964348212416850691@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 04 Nov 2025, Chuck Lever wrote:
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
>  fs/nfsd/vfs.c | 93 +++++++++++++++++++++++++++------------------------
>  1 file changed, 49 insertions(+), 44 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 37353fb48d58..1b1173de4f78 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1261,33 +1261,10 @@ struct nfsd_write_dio_seg {
> =20
>  struct nfsd_write_dio_args {
>  	struct nfsd_file		*nf;
> -	size_t				first, middle, last;
>  	unsigned int			nsegs;
>  	struct nfsd_write_dio_seg	segment[3];
>  };
> =20
> -static bool
> -nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
> -			   struct nfsd_write_dio_args *args)
> -{
> -	u32 dio_blocksize =3D args->nf->nf_dio_offset_align;
> -	loff_t first_end, orig_end, middle_end;
> -
> -	if (unlikely(!args->nf->nf_dio_mem_align || !dio_blocksize))
> -		return false;
> -	if (unlikely(len < dio_blocksize))
> -		return false;
> -
> -	first_end =3D round_up(offset, dio_blocksize);
> -	orig_end =3D offset + len;
> -	middle_end =3D round_down(orig_end, dio_blocksize);
> -
> -	args->first =3D first_end - offset;
> -	args->middle =3D middle_end - first_end;
> -	args->last =3D orig_end - middle_end;
> -	return true;
> -}
> -
>  /*
>   * Check if the bvec iterator is aligned for direct I/O.
>   *
> @@ -1316,35 +1293,66 @@ nfsd_write_dio_seg_init(struct nfsd_write_dio_seg *=
segment,
>  	segment->use_dio =3D false;
>  }
> =20
> -static bool
> -nfsd_setup_write_dio_iters(struct bio_vec *bvec, unsigned int nvecs,
> -			   unsigned long total,
> -			   struct nfsd_write_dio_args *args)
> +static void
> +nfsd_write_dio_iters_init(struct bio_vec *bvec, unsigned int nvecs,
> +			  loff_t offset, unsigned long total,
> +			  struct nfsd_write_dio_args *args)
>  {
> +	u32 offset_align =3D args->nf->nf_dio_offset_align;
> +	u32 mem_align =3D args->nf->nf_dio_mem_align;
> +	loff_t prefix_end, orig_end, middle_end;
> +	size_t prefix, middle, suffix;
> +
>  	args->nsegs =3D 0;
> =20
> -	if (args->first) {
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

So first, middle, last is now prefix, middle, suffix.  I do like that
more though the constant change leaves me a bit dizzy :-)

Again, a nice simplification - fewer paths and special cases so easier
to follow.

Reviewed-by: NeilBrown <neil@brown.name>

NeilBrown


> +
> +	if (!middle)
> +		goto no_dio;
> +
> +	if (prefix) {
>  		nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec,
> -					nvecs, total, 0, args->first);
> +					nvecs, total, 0, prefix);
>  		++args->nsegs;
>  	}
> =20
>  	nfsd_write_dio_seg_init(&args->segment[args->nsegs], bvec, nvecs,
> -				total, args->first, args->middle);
> +				total, prefix, middle);
>  	if (!nfsd_iov_iter_aligned_bvec(args->nf,
>  					&args->segment[args->nsegs].iter))
> -		return false;	/* no DIO-aligned IO possible */
> +		goto no_dio;
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
> @@ -1365,7 +1373,7 @@ nfsd_buffered_write(struct svc_rqst *rqstp, struct fi=
le *file,
>  }
> =20
>  static int
> -nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *stab=
le_how,
> +nfsd_issue_dio_write(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *stab=
le_how,
>  		     struct kiocb *kiocb, unsigned int nvecs, unsigned long *cnt,
>  		     struct nfsd_write_dio_args *args)
>  {
> @@ -1373,9 +1381,6 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct s=
vc_fh *fhp, u32 *stable_how
>  	ssize_t host_err;
>  	unsigned int i;
> =20
> -	if (!nfsd_setup_write_dio_iters(rqstp->rq_bvec, nvecs, *cnt, args))
> -		return nfsd_buffered_write(rqstp, file, nvecs, cnt, kiocb);
> -
>  	/*
>  	 * Any buffered IO issued here will be misaligned, use
>  	 * sync IO to ensure it has completed before returning.
> @@ -1384,6 +1389,9 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct s=
vc_fh *fhp, u32 *stable_how
>  	kiocb->ki_flags |=3D (IOCB_DSYNC|IOCB_SYNC);
>  	*stable_how =3D NFS_FILE_SYNC;
> =20
> +	nfsd_write_dio_iters_init(rqstp->rq_bvec, nvecs, kiocb->ki_pos,
> +				  *cnt, args);
> +
>  	*cnt =3D 0;
>  	for (i =3D 0; i < args->nsegs; i++) {
>  		if (args->segment[i].use_dio) {
> @@ -1422,11 +1430,8 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
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
> --=20
> 2.51.0
>=20
>=20


