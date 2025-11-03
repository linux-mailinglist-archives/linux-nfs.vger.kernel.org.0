Return-Path: <linux-nfs+bounces-15982-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13894C2E5CD
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 00:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8FD3A89C4
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 23:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8272F692D;
	Mon,  3 Nov 2025 23:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="esD+wls1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ipWjmqLW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C7223184F
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 23:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762211007; cv=none; b=Qo2OZLpD7WqwZR74exYKfSlycx7XN+NmR+vbidcLt9N6Nx25UIuBXuvpkdE8Yp02UH4YfuC3GbOPjxyCkq6fDxxnFs27z6bWpOjp1rKIuSmEkWug/WQAqbqkTEKg4Xw9cwqCSVhD7Jjp9XTnOpLTnhJRcgSdHObNlTUltvAB3yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762211007; c=relaxed/simple;
	bh=Ff3O5Q8qm2Njs9dr7gM7hx9GySXoYUrnkGJjYAsppgM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=MIMYKSvbLKCv1NFaTdGaHqM4SuvPoGyKyVRnQ1j0F8Z9xymVRC606eZVS7dz7em7qTQ+X/XNlEdda2bwYkoxf3W5sfIqGfoQdHBpW43RJwEVyWTxsiLiMvKZHXqOs9WI4LMVfJoWyHvTrwbfV4EgTsuijJ53eOpAgjFZkoIkP5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=esD+wls1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ipWjmqLW; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 79E3CEC0309;
	Mon,  3 Nov 2025 18:03:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 03 Nov 2025 18:03:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762211004; x=1762297404; bh=TDyAlnll8Xb61Q2qWHox2nhQuYmGBV7iz7S
	KdJ5GBLk=; b=esD+wls1sVAKRnp2Dx3Ufd8eojc44JZJC7qtIxGeKsdcR4hL3+L
	7MqoS5Mrmqgo5EljXFwrb1Jlp5odL7xt/GjCrNsuOgYU8vELXwzC51WuFJAia0Ce
	PqmuXlR8+PkGTRFbx6MlmvzaznPygTe3Er+BeUS06ymS049Zi5hPRi9DIIHkTQJK
	2evvg48LYEexYigKKI4xZFp7BLGyhkqPddIz1YVu+Nk6RxD00DVUhPoAE7mjROZ+
	2LxaptSElAYmzv6l0dwNN3JC7k4oZZtQzbq5PnrkpUPGhy/VO7SY9y7z5t7SpSGe
	YI5U37RRAOZBbg5+JVL45KpFJgz1WmJ/F5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762211004; x=
	1762297404; bh=TDyAlnll8Xb61Q2qWHox2nhQuYmGBV7iz7SKdJ5GBLk=; b=i
	pWjmqLW6n2ZDVTSEbrdQq0296VtDxL1JNxlTsi4g81VDfCvsXzuiFg3VV42sjE1M
	bs/tyUhY4tRI6Otobxkt2MJvobCU+cM2B0tCjBO4bfphPq9Ruzw+GsiDf7rfu4N1
	JM+CAEjHGtWUfHcUNF9DMU3kBKvpqe3+pw6pq29JfJ2oSOJHjC6fSGp6nv7yy6yI
	APr8a56JS7+hbMDKnwXAgnDeABhxYEXq2V5YD/O8CSykdnpa4Xhlz+Gsgswz/B2W
	cIGq7a8pvGTX7P6TnFgEUKAHbTES7+JGJwELGDJpcNZHRCU1NU0pPpPKrM+pe1ai
	YMrurNky1Kg53q847NUfA==
X-ME-Sender: <xms:vDQJaRPbTwvkjVFrO3A7qP4EFGx029Hex06AYKG2itJAuby9jcfhYQ>
    <xme:vDQJaTBUwI2wYzG1rZju7sZAizSZ-kZ0sZ0_6mVQOSTcPPz2-lYfWhcJKjEQXgYoU
    aa_E113JFCRJALcoWJUJRPNpBoap3poOKAV64E466bGV0_d>
X-ME-Received: <xmr:vDQJaWe2U_Z7o166F3JAUnxEvG5IKesEthteZ-rZFFz-voVkjqt5O8Z5dP_JkCgvPZVoaEofyG5q3XUIFGSetuRoufbBYKhoIYQ2Ax4lYTFk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeelgedtucetufdoteggodetrf
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
    pdhrtghpthhtohephhgthheslhhsthdruggvpdhrtghpthhtohepjhhlrgihthhonheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheptggvlheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:vDQJaaNRYgUa-3UJtzddCiw7vlFzjeH1WQxAejjx_OgCBEZFqIb8gw>
    <xmx:vDQJaeLCt2QHa3-3YwACqjQTg8ZfWiwKoloHUzIN9bVSeSpVNGd_og>
    <xmx:vDQJaSIEZYBxF6TWrCPB9njdzp2enm2-W3PWZ4nph4jGY5jaTDmDkw>
    <xmx:vDQJaQ6f1Doh9343JTQSwRUXwo3TbON89FNY-cyhesx6HgyI32CHSw>
    <xmx:vDQJae_SSJzJda2PaflPZdjD3oRaF-luISrxs-Ojfl8d1O2lCXMN8jiU>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 18:03:21 -0500 (EST)
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
 "Chuck Lever" <chuck.lever@oracle.com>, "Christoph Hellwig" <hch@lst.de>
Subject: Re: [PATCH v9 10/12] NFSD: Handle kiocb->ki_flags correctly
In-reply-to: <20251103165351.10261-11-cel@kernel.org>
References: <20251103165351.10261-1-cel@kernel.org>,
 <20251103165351.10261-11-cel@kernel.org>
Date: Tue, 04 Nov 2025 10:03:19 +1100
Message-id: <176221099980.1793333.459150691694156959@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 04 Nov 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Christoph says:
> > > +	if (file->f_op->fop_flags & FOP_DONTCACHE)
> > > +		kiocb->ki_flags |=3D IOCB_DONTCACHE;
> > IOCB_DONTCACHE isn't defined for IOCB_DIRECT.  So this should
> > move into a branch just for buffered I/O.
>=20
> and
>=20
> > > Promoting all NFSD_IO_DIRECT writes to FILE_SYNC was my idea,
> > > based on the assumption that IOCB_DIRECT writes to local file
> > > systems left nothing to be done by a later commit. My assumption
> > > is based on the behavior of O_DIRECT on NFS files.
> > >
> > > If that assumption is not true, then I agree there is no
> > > technical reason to promote NFSD_IO_DIRECT writes to FILE_SYNC,
> > > and I can remove that built-in assumption for v8 of this series.
> >
> > It is not true, or rather only true for a tiny subset of use cases
> > (which NFS can't even query a head of time).
>=20
> So, observe the existing setting of ki_flags rather than forcing
> persistence unconditionally, and ensure that DONTCACHE is not set
> for IOCB_DIRECT writes.

Of the write has no prefix or suffix and so is entirely O_DIRECT, then
we get DATASYNC for free do we not?
In that case we should tell the client that DATASYNC has been provided.
I might have missed something in all the refactoring, but this patch
seems to suggest.

In fact, with this change as it stands, the earlier change to allow a
different stable_how to be returned is not used...  but I think there
are cases where it could be used.

NeilBrown


>=20
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/vfs.c | 33 ++++++++++++++-------------------
>  1 file changed, 14 insertions(+), 19 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 1b1173de4f78..0e5e82b286f1 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1261,6 +1261,8 @@ struct nfsd_write_dio_seg {
> =20
>  struct nfsd_write_dio_args {
>  	struct nfsd_file		*nf;
> +	int				flags_buffered;
> +	int				flags_direct;
>  	unsigned int			nsegs;
>  	struct nfsd_write_dio_seg	segment[3];
>  };
> @@ -1373,33 +1375,25 @@ nfsd_buffered_write(struct svc_rqst *rqstp, struct =
file *file,
>  }
> =20
>  static int
> -nfsd_issue_dio_write(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *stab=
le_how,
> -		     struct kiocb *kiocb, unsigned int nvecs, unsigned long *cnt,
> -		     struct nfsd_write_dio_args *args)
> +nfsd_issue_dio_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +		     struct kiocb *kiocb, unsigned int nvecs,
> +		     unsigned long *cnt, struct nfsd_write_dio_args *args)
>  {
>  	struct file *file =3D args->nf->nf_file;
>  	ssize_t host_err;
>  	unsigned int i;
> =20
> -	/*
> -	 * Any buffered IO issued here will be misaligned, use
> -	 * sync IO to ensure it has completed before returning.
> -	 * Also update @stable_how to avoid need for COMMIT.
> -	 */
> -	kiocb->ki_flags |=3D (IOCB_DSYNC|IOCB_SYNC);
> -	*stable_how =3D NFS_FILE_SYNC;
> -
>  	nfsd_write_dio_iters_init(rqstp->rq_bvec, nvecs, kiocb->ki_pos,
>  				  *cnt, args);
> =20
>  	*cnt =3D 0;
>  	for (i =3D 0; i < args->nsegs; i++) {
>  		if (args->segment[i].use_dio) {
> -			kiocb->ki_flags |=3D IOCB_DIRECT;
> +			kiocb->ki_flags =3D args->flags_direct;
>  			trace_nfsd_write_direct(rqstp, fhp, kiocb->ki_pos,
>  						args->segment[i].iter.count);
>  		} else
> -			kiocb->ki_flags &=3D ~IOCB_DIRECT;
> +			kiocb->ki_flags =3D args->flags_buffered;
> =20
>  		host_err =3D vfs_iocb_iter_write(file, kiocb,
>  					       &args->segment[i].iter);
> @@ -1423,15 +1417,16 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
>  	args.nf =3D nf;
> =20
>  	/*
> -	 * Check if IOCB_DONTCACHE can be used when issuing buffered IO;
> -	 * if so, set it to preserve intent of NFSD_IO_DIRECT (it will
> -	 * be ignored for any DIO issued here).
> +	 * IOCB_DONTCACHE preserves the intent of NFSD_IO_DIRECT when
> +	 * writing unaligned segments or handling fallback I/O.
>  	 */
> +	args.flags_buffered =3D kiocb->ki_flags;
>  	if (args.nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
> -		kiocb->ki_flags |=3D IOCB_DONTCACHE;
> +		args.flags_buffered |=3D IOCB_DONTCACHE;
> =20
> -	return nfsd_issue_dio_write(rqstp, fhp, stable_how, kiocb, nvecs,
> -				    cnt, &args);
> +	args.flags_direct =3D kiocb->ki_flags | IOCB_DIRECT;
> +
> +	return nfsd_issue_dio_write(rqstp, fhp, kiocb, nvecs, cnt, &args);
>  }
> =20
>  /**
> --=20
> 2.51.0
>=20
>=20


