Return-Path: <linux-nfs+bounces-14736-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 919E3BA4132
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Sep 2025 16:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFF4E1B25BE8
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Sep 2025 14:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A5A7260A;
	Fri, 26 Sep 2025 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1OYPFZL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0963C8FE
	for <linux-nfs@vger.kernel.org>; Fri, 26 Sep 2025 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896117; cv=none; b=TBAYN1dHA0UptkBdckQHZKo1ciU2v6VPxclGcoapo2MfyG8MLYjVSn1cVW/RUMh2GgSoEus8Af2deNe8Ec4rSETxQaWYyJgVj5Pp0tgRPRlcEfXFG7ecpzeiLuzk6H5dNWYB7wyTUJmXR/rUZwgYjX9W5oqhqPR/iJO/74SDYiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896117; c=relaxed/simple;
	bh=hMKCpar1gdXJp0zKiMH9Hax1lEE9hVBlG208ByUja+g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PNpHgC+E27BN5C+Sb4IzK8OZiA09fKW3X0OEglFWomSehAj7s2RHyX08Iu+2MA8ZnoFiyQT6UOLHuMZlsMqJKjMM7w8iSfe9R2pcinVGsMOMmPRDX0scGcJNYQW/+3DcZEDBPFnxyPGjGxaKaXHO+De/JYpSa7tiPQPl02GPfTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1OYPFZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E41C113CF;
	Fri, 26 Sep 2025 14:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758896116;
	bh=hMKCpar1gdXJp0zKiMH9Hax1lEE9hVBlG208ByUja+g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=e1OYPFZLCtbskOcyR50GtdFv4h4LGY66KLB4S7c+GlyzVtGU2uUn8HC3z7+L5UZmZ
	 9tMDEsRSMHcBrgYeN0oWFIeBhN0nhXy7j468+vm/LPhUNifOs10lWpZB4Q+Cep3zSb
	 79TlRtlKjlRdwG1JNZ2hJUIae0Crir83qx+fqlV/zcLp4JtmKrtmNRv84By2b8fRKd
	 7PrrpBCO9amszRAyljSvLh6K2H90QIHovq38O4uIPtyKu2dj4mdqRvM8Cd4/BQZCJf
	 wH98RHQCVQOEKF/2iY8lu7QByySwH86Us+qdzj6V4jDr53IoJMR2Aa6vYCURsJ95MK
	 igmVQHul278Fw==
Message-ID: <2b1e79503919069897b6049462653b0edfa2bef0.camel@kernel.org>
Subject: Re: [PATCH v11 2/7] nfs/localio: avoid issuing misaligned IO using
 O_DIRECT
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>, 
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Date: Fri, 26 Sep 2025 10:15:14 -0400
In-Reply-To: <20250919143631.44851-3-snitzer@kernel.org>
References: <20250919143631.44851-1-snitzer@kernel.org>
	 <20250919143631.44851-3-snitzer@kernel.org>
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

On Fri, 2025-09-19 at 10:36 -0400, Mike Snitzer wrote:
> Add nfsd_file_dio_alignment and use it to avoid issuing misaligned IO
> using O_DIRECT. Any misaligned DIO falls back to using buffered IO.
>=20
> Because misaligned DIO is now handled safely, remove the nfs modparam
> 'localio_O_DIRECT_semantics' that was added to require users opt-in to
> the requirement that all O_DIRECT be properly DIO-aligned.
>=20
> Also, introduce nfs_iov_iter_aligned_bvec() which is a variant of
> iov_iter_aligned_bvec() that also verifies the offset associated with
> an iov_iter is DIO-aligned.  NOTE: in a parallel effort,
> iov_iter_aligned_bvec() is being removed along with
> iov_iter_is_aligned().
>=20
> Lastly, add pr_info_ratelimited if underlying filesystem returns
> -EINVAL because it was made to try O_DIRECT for IO that is not
> DIO-aligned (shouldn't happen, so its best to be louder if it does).
>=20
> Fixes: 3feec68563d ("nfs/localio: add direct IO enablement with sync and =
async IO support")
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs/localio.c           | 65 ++++++++++++++++++++++++++++++++------
>  fs/nfsd/localio.c          | 11 +++++++
>  include/linux/nfslocalio.h |  2 ++
>  3 files changed, 68 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index 42ea50d42c995..b165922e5cb65 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -49,11 +49,6 @@ struct nfs_local_fsync_ctx {
>  static bool localio_enabled __read_mostly =3D true;
>  module_param(localio_enabled, bool, 0644);
> =20
> -static bool localio_O_DIRECT_semantics __read_mostly =3D false;
> -module_param(localio_O_DIRECT_semantics, bool, 0644);
> -MODULE_PARM_DESC(localio_O_DIRECT_semantics,
> -		 "LOCALIO will use O_DIRECT semantics to filesystem.");
> -
>  static inline bool nfs_client_is_local(const struct nfs_client *clp)
>  {
>  	return !!rcu_access_pointer(clp->cl_uuid.net);
> @@ -322,12 +317,9 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
>  		return NULL;
>  	}
> =20
> -	if (localio_O_DIRECT_semantics &&
> -	    test_bit(NFS_IOHDR_ODIRECT, &hdr->flags)) {
> -		iocb->kiocb.ki_filp =3D file;
> +	init_sync_kiocb(&iocb->kiocb, file);
> +	if (test_bit(NFS_IOHDR_ODIRECT, &hdr->flags))
>  		iocb->kiocb.ki_flags =3D IOCB_DIRECT;
> -	} else
> -		init_sync_kiocb(&iocb->kiocb, file);
> =20
>  	iocb->kiocb.ki_pos =3D hdr->args.offset;
>  	iocb->hdr =3D hdr;
> @@ -337,6 +329,30 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
>  	return iocb;
>  }
> =20
> +static bool nfs_iov_iter_aligned_bvec(const struct iov_iter *i,
> +		loff_t offset, unsigned int addr_mask, unsigned int len_mask)
> +{
> +	const struct bio_vec *bvec =3D i->bvec;
> +	size_t skip =3D i->iov_offset;
> +	size_t size =3D i->count;
> +
> +	if ((offset | size) & len_mask)
> +		return false;
> +	do {
> +		size_t len =3D bvec->bv_len;
> +
> +		if (len > size)
> +			len =3D size;
> +		if ((unsigned long)(bvec->bv_offset + skip) & addr_mask)
> +			return false;
> +		bvec++;
> +		size -=3D len;
> +		skip =3D 0;
> +	} while (size);
> +
> +	return true;
> +}
> +
>  static void
>  nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, in=
t dir)
>  {
> @@ -346,6 +362,25 @@ nfs_local_iter_init(struct iov_iter *i, struct nfs_l=
ocal_kiocb *iocb, int dir)
>  		      hdr->args.count + hdr->args.pgbase);
>  	if (hdr->args.pgbase !=3D 0)
>  		iov_iter_advance(i, hdr->args.pgbase);
> +
> +	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
> +		u32 nf_dio_mem_align, nf_dio_offset_align, nf_dio_read_offset_align;
> +		/* Verify the IO is DIO-aligned as required */
> +		nfs_to->nfsd_file_dio_alignment(iocb->localio, &nf_dio_mem_align,
> +						&nf_dio_offset_align,
> +						&nf_dio_read_offset_align);
> +		if (dir =3D=3D READ)
> +			nf_dio_offset_align =3D nf_dio_read_offset_align;
> +
> +		if (nf_dio_mem_align && nf_dio_offset_align &&
> +		    nfs_iov_iter_aligned_bvec(i, hdr->args.offset,
> +					      nf_dio_mem_align - 1,
> +					      nf_dio_offset_align - 1))
> +			return; /* is DIO-aligned */
> +
> +		/* Fallback to using buffered for this misaligned IO */
> +		iocb->kiocb.ki_flags &=3D ~IOCB_DIRECT;
> +	}
>  }
> =20
>  static void
> @@ -406,6 +441,11 @@ nfs_local_read_done(struct nfs_local_kiocb *iocb, lo=
ng status)
>  	struct nfs_pgio_header *hdr =3D iocb->hdr;
>  	struct file *filp =3D iocb->kiocb.ki_filp;
> =20
> +	if ((iocb->kiocb.ki_flags & IOCB_DIRECT) && status =3D=3D -EINVAL) {
> +		/* Underlying FS will return -EINVAL if misaligned DIO is attempted. *=
/
> +		pr_info_ratelimited("nfs: Unexpected direct I/O read alignment failure=
\n");
> +	}
> +
>  	nfs_local_pgio_done(hdr, status);
> =20
>  	/*
> @@ -598,6 +638,11 @@ nfs_local_write_done(struct nfs_local_kiocb *iocb, l=
ong status)
> =20
>  	dprintk("%s: wrote %ld bytes.\n", __func__, status > 0 ? status : 0);
> =20
> +	if ((iocb->kiocb.ki_flags & IOCB_DIRECT) && status =3D=3D -EINVAL) {
> +		/* Underlying FS will return -EINVAL if misaligned DIO is attempted. *=
/
> +		pr_info_ratelimited("nfs: Unexpected direct I/O write alignment failur=
e\n");
> +	}
> +
>  	/* Handle short writes as if they are ENOSPC */
>  	if (status > 0 && status < hdr->args.count) {
>  		hdr->mds_offset +=3D status;
> diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> index 269fa9391dc46..be710d809a3ba 100644
> --- a/fs/nfsd/localio.c
> +++ b/fs/nfsd/localio.c
> @@ -117,12 +117,23 @@ nfsd_open_local_fh(struct net *net, struct auth_dom=
ain *dom,
>  	return localio;
>  }
> =20
> +static void nfsd_file_dio_alignment(struct nfsd_file *nf,
> +				    u32 *nf_dio_mem_align,
> +				    u32 *nf_dio_offset_align,
> +				    u32 *nf_dio_read_offset_align)
> +{
> +	*nf_dio_mem_align =3D nf->nf_dio_mem_align;
> +	*nf_dio_offset_align =3D nf->nf_dio_offset_align;
> +	*nf_dio_read_offset_align =3D nf->nf_dio_read_offset_align;
> +}
> +
>  static const struct nfsd_localio_operations nfsd_localio_ops =3D {
>  	.nfsd_net_try_get  =3D nfsd_net_try_get,
>  	.nfsd_net_put  =3D nfsd_net_put,
>  	.nfsd_open_local_fh =3D nfsd_open_local_fh,
>  	.nfsd_file_put_local =3D nfsd_file_put_local,
>  	.nfsd_file_file =3D nfsd_file_file,
> +	.nfsd_file_dio_alignment =3D nfsd_file_dio_alignment,
>  };
> =20
>  void nfsd_localio_ops_init(void)
> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> index 59ea90bd136b6..3d91043254e64 100644
> --- a/include/linux/nfslocalio.h
> +++ b/include/linux/nfslocalio.h
> @@ -64,6 +64,8 @@ struct nfsd_localio_operations {
>  						const fmode_t);
>  	struct net *(*nfsd_file_put_local)(struct nfsd_file __rcu **);
>  	struct file *(*nfsd_file_file)(struct nfsd_file *);
> +	void (*nfsd_file_dio_alignment)(struct nfsd_file *,
> +					u32 *, u32 *, u32 *);
>  } ____cacheline_aligned;
> =20
>  extern void nfsd_localio_ops_init(void);

This looks reasonable to me. The nfsd bits in particular are
straightforward.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

