Return-Path: <linux-nfs+bounces-11677-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D975AB543E
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 14:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263C017367B
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 12:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A86A28D8E5;
	Tue, 13 May 2025 12:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORpWUOJy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1E028D85C;
	Tue, 13 May 2025 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747137745; cv=none; b=JEn8Zd6RImNTo01NweM7Boz4h8lmHOdwxWqTgALQNjAZKErYw14/O8xBwtDF+XX93KKBM72DCKmF/NaNCsKnySm9hvuxdBz7M4XaCj5IL0MXLJ9RHo5sg8ks9lhhT25D8BwdbAA2R/0RcBoGBvVgrFQ779WACYH4BRVc9cR/CK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747137745; c=relaxed/simple;
	bh=W4oRaTsVo4qhFDmv2To1zKjmQfyXhVUTJEPuBMtxfts=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MIcxtojvcL+3o6A9P+BK++VTHglAwaO6KUQtPAnovk40dsUsdU9PrfFsfop3LFHFxoaJ6RY1as3Ww95ORQkkfw78UbQtGmOPl3aTR9+xvHQOKlM85WryywtLX2RsldFUxzbwPbd21S945PNMXkNKyBUxKDi8Tvut1sdc0AIStgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORpWUOJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42BDC4CEE4;
	Tue, 13 May 2025 12:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747137744;
	bh=W4oRaTsVo4qhFDmv2To1zKjmQfyXhVUTJEPuBMtxfts=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ORpWUOJyu4WMgXSwX/By537Ku/zD0YOQWbDbX6hRenwHRF77OBkKFBenq7MGQKiBI
	 cMS5qo55uso0y6hvPaMj5VrZx6oB3xt3VyMN3v/zOKj79wBlTWO++4YOQwmQIeUrb/
	 8unpzOeJFv7qu2DeAhvjTrbXWEybE3QOEqub2Ote6p1NCwuHhErAHA6U/uqp72OL1u
	 F20L38FBK2J+5xbtlCE8QhPhZ1nNWT935SJ1/UynvynDpcoruKcY54R8bT1pM+7YTW
	 2NSyfBIk7pAlaq/tyVrqBmObfU7CSS9/Y8G1OnywNJPzuaj5tFj0aNPEKXpHhMX8wz
	 9qXDPRQAVez4w==
Message-ID: <a0f1232d29e699a40da0e41c423bcad8e99887cd.camel@kernel.org>
Subject: Re: [PATCH v5 07/19] NFSD: De-duplicate the svc_fill_write_vector()
 call sites
From: Jeff Layton <jlayton@kernel.org>
To: cel@kernel.org, NeilBrown <neil@brown.name>, Olga Kornievskaia	
 <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, Chuck Lever
	 <chuck.lever@oracle.com>
Date: Tue, 13 May 2025 07:02:22 -0500
In-Reply-To: <20250509190354.5393-8-cel@kernel.org>
References: <20250509190354.5393-1-cel@kernel.org>
	 <20250509190354.5393-8-cel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-09 at 15:03 -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> All three call sites do the same thing.
>=20
> I'm struggling with this a bit, however. struct xdr_buf is an XDR
> layer object and unmarshaling a WRITE payload is clearly a task
> intended to be done by the proc and xdr functions, not by VFS. This
> feels vaguely like a layering violation.
>=20

I think it's fine.

> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs3proc.c         |  5 +---
>  fs/nfsd/nfs4proc.c         |  8 ++----
>  fs/nfsd/nfsproc.c          |  9 +++----
>  fs/nfsd/vfs.c              | 52 +++++++++++++++++++++++++++++---------
>  fs/nfsd/vfs.h              | 10 ++++----
>  include/linux/sunrpc/svc.h |  2 +-
>  net/sunrpc/svc.c           |  4 +--
>  7 files changed, 54 insertions(+), 36 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index 8902fae8c62d..12e1eef810e7 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -220,7 +220,6 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
>  	struct nfsd3_writeargs *argp =3D rqstp->rq_argp;
>  	struct nfsd3_writeres *resp =3D rqstp->rq_resp;
>  	unsigned long cnt =3D argp->len;
> -	unsigned int nvecs;
> =20
>  	dprintk("nfsd: WRITE(3)    %s %d bytes at %Lu%s\n",
>  				SVCFH_fmt(&argp->fh),
> @@ -235,10 +234,8 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
> =20
>  	fh_copy(&resp->fh, &argp->fh);
>  	resp->committed =3D argp->stable;
> -	nvecs =3D svc_fill_write_vector(rqstp, &argp->payload);
> -
>  	resp->status =3D nfsd_write(rqstp, &resp->fh, argp->offset,
> -				  rqstp->rq_vec, nvecs, &cnt,
> +				  &argp->payload, &cnt,
>  				  resp->committed, resp->verf);
>  	resp->count =3D cnt;
>  	resp->status =3D nfsd3_map_status(resp->status);
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 2b16ee1ae461..ffd8b1d499df 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1216,7 +1216,6 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
>  	struct nfsd_file *nf =3D NULL;
>  	__be32 status =3D nfs_ok;
>  	unsigned long cnt;
> -	int nvecs;
> =20
>  	if (write->wr_offset > (u64)OFFSET_MAX ||
>  	    write->wr_offset + write->wr_buflen > (u64)OFFSET_MAX)
> @@ -1231,12 +1230,9 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
>  		return status;
> =20
>  	write->wr_how_written =3D write->wr_stable_how;
> -
> -	nvecs =3D svc_fill_write_vector(rqstp, &write->wr_payload);
> -
>  	status =3D nfsd_vfs_write(rqstp, &cstate->current_fh, nf,
> -				write->wr_offset, rqstp->rq_vec, nvecs, &cnt,
> -				write->wr_how_written,
> +				write->wr_offset, &write->wr_payload,
> +				&cnt, write->wr_how_written,
>  				(__be32 *)write->wr_verifier.data);
>  	nfsd_file_put(nf);
> =20
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 7c573d792252..65cbe04184f3 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -251,17 +251,14 @@ nfsd_proc_write(struct svc_rqst *rqstp)
>  	struct nfsd_writeargs *argp =3D rqstp->rq_argp;
>  	struct nfsd_attrstat *resp =3D rqstp->rq_resp;
>  	unsigned long cnt =3D argp->len;
> -	unsigned int nvecs;
> =20
>  	dprintk("nfsd: WRITE    %s %u bytes at %d\n",
>  		SVCFH_fmt(&argp->fh),
>  		argp->len, argp->offset);
> =20
> -	nvecs =3D svc_fill_write_vector(rqstp, &argp->payload);
> -
> -	resp->status =3D nfsd_write(rqstp, fh_copy(&resp->fh, &argp->fh),
> -				  argp->offset, rqstp->rq_vec, nvecs,
> -				  &cnt, NFS_DATA_SYNC, NULL);
> +	fh_copy(&resp->fh, &argp->fh);
> +	resp->status =3D nfsd_write(rqstp, &resp->fh, argp->offset,
> +				  &argp->payload, &cnt, NFS_DATA_SYNC, NULL);
>  	if (resp->status =3D=3D nfs_ok)
>  		resp->status =3D fh_getattr(&resp->fh, &resp->stat);
>  	else if (resp->status =3D=3D nfserr_jukebox)
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 7cfd26dec5a8..43ecc5ae0c3f 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1143,11 +1143,27 @@ static int wait_for_concurrent_writes(struct file=
 *file)
>  	return err;
>  }
> =20
> +/**
> + * nfsd_vfs_write - write data to an already-open file
> + * @rqstp: RPC execution context
> + * @fhp: File handle of file to write into
> + * @nf: An open file matching @fhp
> + * @offset: Byte offset of start
> + * @payload: xdr_buf containing the write payload
> + * @cnt: IN: number of bytes to write, OUT: number of bytes actually wri=
tten
> + * @stable: An NFS stable_how value
> + * @verf: NFS WRITE verifier
> + *
> + * Upon return, caller must invoke fh_put on @fhp.
> + *
> + * Return values:
> + *   An nfsstat value in network byte order.
> + */
>  __be32
> -nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_f=
ile *nf,
> -				loff_t offset, struct kvec *vec, int vlen,
> -				unsigned long *cnt, int stable,
> -				__be32 *verf)
> +nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +	       struct nfsd_file *nf, loff_t offset,
> +	       const struct xdr_buf *payload, unsigned long *cnt,
> +	       int stable, __be32 *verf)
>  {
>  	struct nfsd_net		*nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
>  	struct file		*file =3D nf->nf_file;
> @@ -1162,6 +1178,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_f=
h *fhp, struct nfsd_file *nf,
>  	unsigned int		pflags =3D current->flags;
>  	rwf_t			flags =3D 0;
>  	bool			restore_flags =3D false;
> +	unsigned int		nvecs;
> =20
>  	trace_nfsd_write_opened(rqstp, fhp, offset, *cnt);
> =20
> @@ -1189,7 +1206,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_f=
h *fhp, struct nfsd_file *nf,
>  	if (stable && !fhp->fh_use_wgather)
>  		flags |=3D RWF_SYNC;
> =20
> -	iov_iter_kvec(&iter, ITER_SOURCE, vec, vlen, *cnt);
> +	nvecs =3D svc_fill_write_vector(rqstp, payload);
> +	iov_iter_kvec(&iter, ITER_SOURCE, rqstp->rq_vec, nvecs, *cnt);
>  	since =3D READ_ONCE(file->f_wb_err);
>  	if (verf)
>  		nfsd_copy_write_verifier(verf, nn);
> @@ -1289,14 +1307,24 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
>  	return err;
>  }
> =20
> -/*
> - * Write data to a file.
> - * The stable flag requests synchronous writes.
> - * N.B. After this call fhp needs an fh_put
> +/**
> + * nfsd_write - open a file and write data to it
> + * @rqstp: RPC execution context
> + * @fhp: File handle of file to write into; nfsd_write() may modify it
> + * @offset: Byte offset of start
> + * @payload: xdr_buf containing the write payload
> + * @cnt: IN: number of bytes to write, OUT: number of bytes actually wri=
tten
> + * @stable: An NFS stable_how value
> + * @verf: NFS WRITE verifier
> + *
> + * Upon return, caller must invoke fh_put on @fhp.
> + *
> + * Return values:
> + *   An nfsstat value in network byte order.
>   */
>  __be32
>  nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
> -	   struct kvec *vec, int vlen, unsigned long *cnt, int stable,
> +	   const struct xdr_buf *payload, unsigned long *cnt, int stable,
>  	   __be32 *verf)
>  {
>  	struct nfsd_file *nf;
> @@ -1308,8 +1336,8 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *f=
hp, loff_t offset,
>  	if (err)
>  		goto out;
> =20
> -	err =3D nfsd_vfs_write(rqstp, fhp, nf, offset, vec,
> -			vlen, cnt, stable, verf);
> +	err =3D nfsd_vfs_write(rqstp, fhp, nf, offset, payload, cnt,
> +			     stable, verf);
>  	nfsd_file_put(nf);
>  out:
>  	trace_nfsd_write_done(rqstp, fhp, offset, *cnt);
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index f9b09b842856..eff04959606f 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -128,13 +128,13 @@ bool		nfsd_read_splice_ok(struct svc_rqst *rqstp);
>  __be32		nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  				loff_t offset, unsigned long *count,
>  				u32 *eof);
> -__be32 		nfsd_write(struct svc_rqst *, struct svc_fh *, loff_t,
> -				struct kvec *, int, unsigned long *,
> -				int stable, __be32 *verf);
> +__be32		nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +				loff_t offset, const struct xdr_buf *payload,
> +				unsigned long *cnt, int stable, __be32 *verf);
>  __be32		nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  				struct nfsd_file *nf, loff_t offset,
> -				struct kvec *vec, int vlen, unsigned long *cnt,
> -				int stable, __be32 *verf);
> +				const struct xdr_buf *payload,
> +				unsigned long *cnt, int stable, __be32 *verf);
>  __be32		nfsd_readlink(struct svc_rqst *, struct svc_fh *,
>  				char *, int *);
>  __be32		nfsd_symlink(struct svc_rqst *, struct svc_fh *,
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 538bea716c6b..dec636345ee2 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -471,7 +471,7 @@ int		   svc_encode_result_payload(struct svc_rqst *rq=
stp,
>  					     unsigned int offset,
>  					     unsigned int length);
>  unsigned int	   svc_fill_write_vector(struct svc_rqst *rqstp,
> -					 struct xdr_buf *payload);
> +					 const struct xdr_buf *payload);
>  char		  *svc_fill_symlink_pathname(struct svc_rqst *rqstp,
>  					     struct kvec *first, void *p,
>  					     size_t total);
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 2c1c4aa93f43..a8861a80bc04 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -1727,10 +1727,10 @@ EXPORT_SYMBOL_GPL(svc_encode_result_payload);
>   * Fills in rqstp::rq_vec, and returns the number of elements.
>   */
>  unsigned int svc_fill_write_vector(struct svc_rqst *rqstp,
> -				   struct xdr_buf *payload)
> +				   const struct xdr_buf *payload)
>  {
> +	const struct kvec *first =3D payload->head;
>  	struct page **pages =3D payload->pages;
> -	struct kvec *first =3D payload->head;
>  	struct kvec *vec =3D rqstp->rq_vec;
>  	size_t total =3D payload->len;
>  	unsigned int i;

Reviewed-by: Jeff Layton <jlayton@kernel.org>

