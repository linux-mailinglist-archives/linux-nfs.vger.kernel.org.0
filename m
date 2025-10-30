Return-Path: <linux-nfs+bounces-15810-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CFFC221C4
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 21:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7BCF634A66C
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 20:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6147524BD1A;
	Thu, 30 Oct 2025 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hcp+K7XA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC261C2BD
	for <linux-nfs@vger.kernel.org>; Thu, 30 Oct 2025 20:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761854492; cv=none; b=C/isUoT+WvSW1wldTMsMEg/xqGi5BFeHO1yFXy2z3guD21lucXWnvshOfIRlqopi6bQ0qxN/F5lynlPKpWoeYOoP5fMpwTm2/kMXfJvOroYNpMWHI4Aq5koZmaw0j8UXkskOu5DdQjga68txxDe4jyJBZDIOJdQNMVM86EeF8jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761854492; c=relaxed/simple;
	bh=Zppnayhe8WPXuVmo5T19pTJr11CzflMTHm+ckT9RDLs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j0qLwHmi+k0xvALS4UT6ENFe33o5U6iJXpGtqkNxIiigUmy48Q+IQu+1ukNE+t7mfzfYLphtzsS/5md1TVC8v6RcvfTyjYPy5hl9NDixsptNzIXUy64FvFuWnQSEsWkbhuAdR4HbSskNk1B3zj8gOzPIbrceokRD3awLwmFtLFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hcp+K7XA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDD4C4CEF1;
	Thu, 30 Oct 2025 20:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761854491;
	bh=Zppnayhe8WPXuVmo5T19pTJr11CzflMTHm+ckT9RDLs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Hcp+K7XAsMUJ7/YfjKiSC7nFaNZgxE7qwLbsBl2PoliTPm0AgArNhmRUg1Oxh2eV1
	 RyIBSrkuSujFeOd1uZMWCPw+pKb68p+SnzigwoG/08+AGV7QwkUe0+JflO5vD2abFc
	 P5IP6Hg0ZMSeHk14jALNQ8BENi3KrjA4u/UTEKKRMDu+JlwR+CHpwBsua6J1ngYbNj
	 F0ZGtn1smX9Gy+KWy931MvUwKTz1ZTcJ7HdEng/Oze7G1rxrnlDLc8fZGkPMCiMgOO
	 h6E1GUO02UaOvygk8/YKLL55F6dt6ePR3OSjd63IHtY2X0Qd640m5AnlsKgFlQlWvG
	 mT0N3yiT8D6tw==
Message-ID: <5dcf2de31679c44c1f43a50678ad8ad14cfe4b87.camel@kernel.org>
Subject: Re: [PATCH v8 11/12] NFSD: Handle kiocb->ki_flags correctly
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Chuck Lever
	 <chuck.lever@oracle.com>
Date: Thu, 30 Oct 2025 16:01:30 -0400
In-Reply-To: <20251027154630.1774-12-cel@kernel.org>
References: <20251027154630.1774-1-cel@kernel.org>
	 <20251027154630.1774-12-cel@kernel.org>
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
> > >=20
> > > If that assumption is not true, then I agree there is no
> > > technical reason to promote NFSD_IO_DIRECT writes to FILE_SYNC,
> > > and I can remove that built-in assumption for v8 of this series.
> >=20
> > It is not true, or rather only true for a tiny subset of use cases
> > (which NFS can't even query a head of time).
>=20
> So, observe the existing setting of ki_flags rather than forcing
> persistence unconditionally, and ensure that DONTCACHE is not set
> for IOCB_DIRECT writes.
>=20
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/vfs.c | 33 ++++++++++++++-------------------
>  1 file changed, 14 insertions(+), 19 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index be0688f2ab3d..3c78b3aeea4b 100644
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
> @@ -1396,33 +1398,25 @@ nfsd_buffered_write(struct svc_rqst *rqstp, struc=
t file *file,
>  }
> =20
>  static int
> -nfsd_issue_dio_write(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *st=
able_how,
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
> @@ -1446,15 +1440,16 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
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

Reviewed-by: Jeff Layton <jlayton@kernel.org>

