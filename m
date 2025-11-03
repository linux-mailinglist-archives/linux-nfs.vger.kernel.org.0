Return-Path: <linux-nfs+bounces-15977-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 366ACC2E46A
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 23:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A233534AE0E
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 22:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D865E2367B8;
	Mon,  3 Nov 2025 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="EovA/TkN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hIbjjhry"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7813C1DED63
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 22:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762209395; cv=none; b=Rg5FWz6toovN0d4QBdU5cAPcJVAvqtETRGSumnX+fdNnkUbWsxZStrmPw8Nf3KHcxb2hPjDruKEfDux/VQyRLR3CvSwj8AmXQlDGK/hezsFXnZVTV6Q2byiZBxa7fmklqsVgS2eZq9pTicjVDlKA4QTUzohIQAYDpPjxlhZP4hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762209395; c=relaxed/simple;
	bh=oLT74p8AlRt/kQv3FsdMI4UKX1onfU7pIiGIGE6B1Hw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=e9XIhUr+ujrNv9Q6q5PL3FeVK+HUGUeNZecrIcdf9CDXbHXn7FYlOnFZF1BqQof+ghOSl0StUeTYYs6D+vqc+CW4HHcg/56K7Q5Q+v1aRLIz9Ozdi6nmsSxTFfW4JmMhvkGOLALPK5QB2NLbfSbxKzTifY/uWylw2S9MVuXLIyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=EovA/TkN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hIbjjhry; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7D9B91400276;
	Mon,  3 Nov 2025 17:36:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 03 Nov 2025 17:36:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762209392; x=1762295792; bh=yKoDLswOu8M0Con4U756Sib4cIEuRz4egDW
	X0oq+n4k=; b=EovA/TkNEwBzjZdZPzihHmXt1wXcajikgXn4q/DnA/Bxjcjaugj
	k3IZtsfBm/rIcK0zk2IY/0zO4jT0Jdbd0VcupvFk8Rfb58gCqlhaFnqx5gbXzAvV
	+8mJ612j3LGTcRcAR5kQ6KEHp6N8rkwKU+no+BHv8zktTP/c04Wx6rwzbYhC0ipK
	o4ivDIrCXS5iLbnF6IoYUnIzVaKNvzJVWHpwHg6y1fKD5alzMORtZEkWkkFYy/y4
	GROQH4B+7WWRBYELiagX640he5+Ja7rjvqC3foPygYrRfWzLz2up/iQEj4D441Gf
	d6XhYTCK5IfOvjjFoj6YAJJcXurmBmO0jBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762209392; x=
	1762295792; bh=yKoDLswOu8M0Con4U756Sib4cIEuRz4egDWX0oq+n4k=; b=h
	IbjjhrybA5GgeddvF9hPk8zIgW9rRqme2wAXzB7md05WLq87//+kGT+VqWpqzeTL
	tw561NizhD4rEkr4yE/pW7OgwCorPwBgs/+O8vrIAk6myMAfC0n9rCY6mZRLtdjf
	K4Lcavs2Eiswhb4d5HA5YQqr6KQPJgVPc1Hh24d2juBVKPqA+LjU0MEUeX+0AluA
	Bl3z22JGafrPlBC2P9sWrCtelYYPd9o+Fd+HnZHVnZVLI84VNAtVnP59z1vgJfxu
	KEvmVr5OtpbPj+uisnbZOPEtmcx3VYZXntHdcmvi3zscI9OJL0cHbJ/FBOr4nvqK
	vM1RBr3GVOa7kKPDKF0Qg==
X-ME-Sender: <xms:cC4Jaal_8WVovyzQfTsceqTVX7NPaBz9Xj8d8j7Pvw1cgk7Pxf4kOw>
    <xme:cC4JaQ4suiy40HBcpZ3WJvJdhPjYsV5W6v83f4OSWTt8ddPX0Jh0kgpF4hqogrV4U
    hetWQA0s95MeVWexDnwoij-KbHkK--5Voehjp2Khe0OzRce>
X-ME-Received: <xmr:cC4Jae0TTqN4_ikoTYKZ4-2izAN-5rxITH4Oh4d0_oennOL1Ot9dCsfg6r9N5SQGv-b81LMS0-ohRQSboIqsGSW_3rI9D6N9i0q1NTtYjhjb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeelfeehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:cC4JabGHigcoZkOrrjSNeZg0HKrBjcVoi23sTklJC0lU98FulCN-GQ>
    <xmx:cC4JadhaT2mj-bZJOozY3ARK6rP78JP1q0WSHeiol3ZPFsI-5ej_Ag>
    <xmx:cC4JaeC7PxI8cKA-pwsq4DOE8GV2XG2JgsRTbDObATGJOJ9I59Hw0A>
    <xmx:cC4JafSOMf04XG91PQUVsCe8GLVgds0SDKuZiuf8B9cSf0Qv-ogGXA>
    <xmx:cC4JaTLM0CZDmk7kZEppyG657ZwiskTaj7gKRxfXavtr2NMLmo6poXXP>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 17:36:29 -0500 (EST)
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
 "Chuck Lever" <chuck.lever@oracle.com>, "Mike Snitzer" <snitzer@kernel.org>
Subject: Re: [PATCH v9 06/12] NFSD: Clean up struct nfsd_write_dio
In-reply-to: <20251103165351.10261-7-cel@kernel.org>
References: <20251103165351.10261-1-cel@kernel.org>,
 <20251103165351.10261-7-cel@kernel.org>
Date: Tue, 04 Nov 2025 09:36:28 +1100
Message-id: <176220938803.1793333.14226405631541309883@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 04 Nov 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Prepare for moving more common arguments into the shared per-request
> structure.
>=20
> First step is to move the target nfsd_file into that structure, as
> it needs to be available in several functions.
>=20
> As a clean-up, adopt the conventional naming of a structure that
> carries the same arguments for a number of functions.
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Reviewed-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/vfs.c | 67 +++++++++++++++++++++++++++------------------------
>  1 file changed, 36 insertions(+), 31 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 80bc105eb0b6..326c60eada65 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1254,7 +1254,9 @@ static int wait_for_concurrent_writes(struct file *fi=
le)
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
> @@ -1262,12 +1264,12 @@ struct nfsd_write_dio {
> =20
>  static bool
>  nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
> -		       struct nfsd_file *nf, struct nfsd_write_dio *write_dio)
> +			   struct nfsd_write_dio_args *args)
>  {
> -	const u32 dio_blocksize =3D nf->nf_dio_offset_align;
> +	u32 dio_blocksize =3D args->nf->nf_dio_offset_align;
>  	loff_t start_end, orig_end, middle_end;
> =20
> -	if (unlikely(!nf->nf_dio_mem_align || !dio_blocksize))
> +	if (unlikely(!args->nf->nf_dio_mem_align || !dio_blocksize))
>  		return false;
>  	if (unlikely(len < dio_blocksize))
>  		return false;
> @@ -1276,16 +1278,18 @@ nfsd_is_write_dio_possible(loff_t offset, unsigned =
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
> =20
> -static bool nfsd_iov_iter_aligned_bvec(const struct iov_iter *i,
> -		unsigned int addr_mask, unsigned int len_mask)
> +static bool
> +nfsd_iov_iter_aligned_bvec(const struct nfsd_file *nf, const struct iov_it=
er *i)
>  {
> +	unsigned int len_mask =3D nf->nf_dio_offset_align - 1;
> +	unsigned int addr_mask =3D nf->nf_dio_mem_align - 1;
>  	const struct bio_vec *bvec =3D i->bvec;
>  	size_t skip =3D i->iov_offset;
>  	size_t size =3D i->count;
> @@ -1314,37 +1318,35 @@ static bool nfsd_iov_iter_aligned_bvec(const struct=
 iov_iter *i,
>  static int
>  nfsd_setup_write_dio_iters(struct iov_iter **iterp, bool *iter_is_dio_alig=
ned,
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
> -		nfsd_iov_iter_aligned_bvec(&iters[n_iters],
> -				nf->nf_dio_mem_align-1, nf->nf_dio_offset_align-1);
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
> @@ -1370,11 +1372,11 @@ nfsd_buffered_write(struct svc_rqst *rqstp, struct =
file *file,
>  }
> =20
>  static int
> -nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nf=
sd_file *nf,
> -		     u32 *stable_how, unsigned int nvecs, unsigned long *cnt,
> -		     struct kiocb *kiocb, struct nfsd_write_dio *write_dio)
> +nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *stab=
le_how,
> +		     struct kiocb *kiocb, unsigned int nvecs, unsigned long *cnt,
> +		     struct nfsd_write_dio_args *args)
>  {
> -	struct file *file =3D nf->nf_file;
> +	struct file *file =3D args->nf->nf_file;
>  	bool iter_is_dio_aligned[3];
>  	struct iov_iter iter_stack[3];
>  	struct iov_iter *iter =3D iter_stack;
> @@ -1384,7 +1386,8 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct s=
vc_fh *fhp, struct nfsd_fil
>  	ssize_t host_err;
> =20
>  	n_iters =3D nfsd_setup_write_dio_iters(&iter, iter_is_dio_aligned,
> -				rqstp->rq_bvec, nvecs, *cnt, write_dio, nf);
> +					     rqstp->rq_bvec, nvecs, *cnt,
> +					     args);
>  	if (unlikely(!n_iters))
>  		return nfsd_buffered_write(rqstp, file, nvecs, cnt, kiocb);
> =20
> @@ -1421,21 +1424,23 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
>  		  struct nfsd_file *nf, u32 *stable_how, unsigned int nvecs,
>  		  unsigned long *cnt, struct kiocb *kiocb)
>  {
> -	struct nfsd_write_dio write_dio;
> +	struct nfsd_write_dio_args args;
> +
> +	args.nf =3D nf;
> =20
>  	/*
>  	 * Check if IOCB_DONTCACHE can be used when issuing buffered IO;
>  	 * if so, set it to preserve intent of NFSD_IO_DIRECT (it will
>  	 * be ignored for any DIO issued here).
>  	 */
> -	if (nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
> +	if (args.nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)

This change from "nf->" to "args.nf->" is unnecessary and to my eye
looks weird.  I prefer the original code.

>  		kiocb->ki_flags |=3D IOCB_DONTCACHE;
> =20
> -	if (nfsd_is_write_dio_possible(kiocb->ki_pos, *cnt, nf, &write_dio))
> -		return nfsd_issue_write_dio(rqstp, fhp, nf, stable_how, nvecs,
> -					    cnt, kiocb, &write_dio);
> +	if (nfsd_is_write_dio_possible(kiocb->ki_pos, *cnt, &args))
> +		return nfsd_issue_write_dio(rqstp, fhp, stable_how, kiocb,
> +					    nvecs, cnt, &args);
> =20
> -	return nfsd_buffered_write(rqstp, nf->nf_file, nvecs, cnt, kiocb);
> +	return nfsd_buffered_write(rqstp, args.nf->nf_file, nvecs, cnt, kiocb);

This one looks particularly weird.  "args" is for dio, and here we have
decided not to use dio, but we are using args anyway.

But overall I like the change, so
Reviewed-by: NeilBrown <neil@brown.name>

with or without the two changes above that I don't like.

NeilBrown

