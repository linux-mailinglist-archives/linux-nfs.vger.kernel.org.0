Return-Path: <linux-nfs+bounces-15202-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E978BD5F51
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 21:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21F4D4E9AB5
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 19:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C35425783C;
	Mon, 13 Oct 2025 19:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukLk5qX6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4619B19CCF5
	for <linux-nfs@vger.kernel.org>; Mon, 13 Oct 2025 19:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760384099; cv=none; b=ZQjs1DCCJ4H+WWz08CymZICwAwJhEh0/Swl64lMfJJsASYd9oTFke8DgygQ8hSe3wSiDFZ5CE+Sc3cf46qUpasWoVx9nIDlAI8jnDDy1S4x3BOFc3BzS3NWFf6UGSazVmfPzWiOSNMz5ydEbDHxj+Yz1sCe/6EAyqGYNhQdsjtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760384099; c=relaxed/simple;
	bh=Iz3/jfyQlnD8rRPnuepOOv131Xc3Qgixg9NCwCjIGc8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WiLkgMf2Pwx/C8uxY9PS6KKLCxp2LAKctDKJE3OX+AmfcX2p3KyxFf3xHhuR/ncRRej3PQKSsnsgRKf5GXmyHTZjHaCsW7cbROX+pqhHwH+FSuLu0MIxpOUwbgTUXo4/huNWvcnnlzi4zKrK7ceiqxRGybU8BEdT/+3TOc7mJLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukLk5qX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BA6C4CEE7;
	Mon, 13 Oct 2025 19:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760384098;
	bh=Iz3/jfyQlnD8rRPnuepOOv131Xc3Qgixg9NCwCjIGc8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ukLk5qX6wWdrD9qw7MHKP/5YTUoncHnbNwgLKEPVNQJRdrzQ3hT/kwHq60cxxkk8u
	 Sf9pM8RXyvIS7uhvu4x+fiHUPdIlj4rmgCEeTGAn4IuCMn0cHvWke/mqq4mZzHsJDZ
	 GMgqcCz7D6K0PqvRV+pudBElC6Rb6J6mhjo4f0lecQT7DKSoCpaGbKRIwBAbTeSVHF
	 6rMrDMEsrR2O/oJYNZGHqiGBrLOP0JR0pPgdON8PUWSGzDzxlOE/Dz//OuwXvjsEtJ
	 Nyqo28/yPH7fDFbI4Y4pFMq2jl87yA+M75Q5Lgao4YpXKnxalrhpOQIE5bGN+sl3eA
	 Iko2C3/UhvuIQ==
Message-ID: <1b28b7a0e00688b87ff64e3f327b291fd7b8f4fc.camel@kernel.org>
Subject: Re: [PATCH v1] NFSD: Enable return of an updated stable_how to NFS
 clients
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>, Chuck
 Lever	 <chuck.lever@oracle.com>
Date: Mon, 13 Oct 2025 15:34:57 -0400
In-Reply-To: <20251013190113.252097-1-cel@kernel.org>
References: <20251013190113.252097-1-cel@kernel.org>
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

On Mon, 2025-10-13 at 15:01 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> In a subsequent patch, nfsd_vfs_write() will promote an UNSTABLE
> WRITE to be a FILE_SYNC WRITE. This indicates that the client does
> not need a subsequent COMMIT operation, saving a round trip and
> allowing the client to dispense with cached dirty data as soon as
> it receives the server's WRITE response.
>=20
> This patch refactors nfsd_vfs_write() to return a possibly modified
> stable_how value to its callers. No behavior change is expected.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs3proc.c |  2 +-
>  fs/nfsd/nfs4proc.c |  2 +-
>  fs/nfsd/nfsproc.c  |  3 ++-
>  fs/nfsd/vfs.c      | 11 ++++++-----
>  fs/nfsd/vfs.h      |  6 ++++--
>  fs/nfsd/xdr3.h     |  2 +-
>  6 files changed, 15 insertions(+), 11 deletions(-)
>=20
> Here's what I had in mind, based on a patch I did a year ago but
> never posted.
>=20
> If nfsd_vfs_write() promotes an NFS_UNSTABLE write to NFS_FILE_SYNC,
> it can now set *stable_how and the WRITE encoders will return the
> updated value to the client.
>=20
>=20
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index b6d03e1ef5f7..ad14b34583bb 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -236,7 +236,7 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
>  	resp->committed =3D argp->stable;
>  	resp->status =3D nfsd_write(rqstp, &resp->fh, argp->offset,
>  				  &argp->payload, &cnt,
> -				  resp->committed, resp->verf);
> +				  &resp->committed, resp->verf);
>  	resp->count =3D cnt;
>  	resp->status =3D nfsd3_map_status(resp->status);
>  	return rpc_success;
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 7f7e6bb23a90..2222bb283baf 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1285,7 +1285,7 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
>  	write->wr_how_written =3D write->wr_stable_how;
>  	status =3D nfsd_vfs_write(rqstp, &cstate->current_fh, nf,
>  				write->wr_offset, &write->wr_payload,
> -				&cnt, write->wr_how_written,
> +				&cnt, &write->wr_how_written,
>  				(__be32 *)write->wr_verifier.data);
>  	nfsd_file_put(nf);
> =20
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 8f71f5748c75..706401ed6f8d 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -251,6 +251,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
>  	struct nfsd_writeargs *argp =3D rqstp->rq_argp;
>  	struct nfsd_attrstat *resp =3D rqstp->rq_resp;
>  	unsigned long cnt =3D argp->len;
> +	u32 committed =3D NFS_DATA_SYNC;
> =20
>  	dprintk("nfsd: WRITE    %s %u bytes at %d\n",
>  		SVCFH_fmt(&argp->fh),
> @@ -258,7 +259,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
> =20
>  	fh_copy(&resp->fh, &argp->fh);
>  	resp->status =3D nfsd_write(rqstp, &resp->fh, argp->offset,
> -				  &argp->payload, &cnt, NFS_DATA_SYNC, NULL);
> +				  &argp->payload, &cnt, &committed, NULL);
>  	if (resp->status =3D=3D nfs_ok)
>  		resp->status =3D fh_getattr(&resp->fh, &resp->stat);
>  	else if (resp->status =3D=3D nfserr_jukebox)
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index f537a7b4ee01..8b2dc7a88aab 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1262,7 +1262,7 @@ static int wait_for_concurrent_writes(struct file *=
file)
>   * @offset: Byte offset of start
>   * @payload: xdr_buf containing the write payload
>   * @cnt: IN: number of bytes to write, OUT: number of bytes actually wri=
tten
> - * @stable: An NFS stable_how value
> + * @stable_how: IN: Client's requested stable_how, OUT: Actual stable_ho=
w
>   * @verf: NFS WRITE verifier
>   *
>   * Upon return, caller must invoke fh_put on @fhp.
> @@ -1274,11 +1274,12 @@ __be32
>  nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	       struct nfsd_file *nf, loff_t offset,
>  	       const struct xdr_buf *payload, unsigned long *cnt,
> -	       int stable, __be32 *verf)
> +	       u32 *stable_how, __be32 *verf)
>  {
>  	struct nfsd_net		*nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
>  	struct file		*file =3D nf->nf_file;
>  	struct super_block	*sb =3D file_inode(file)->i_sb;
> +	u32			stable =3D *stable_how;
>  	struct kiocb		kiocb;
>  	struct svc_export	*exp;
>  	struct iov_iter		iter;
> @@ -1434,7 +1435,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
>   * @offset: Byte offset of start
>   * @payload: xdr_buf containing the write payload
>   * @cnt: IN: number of bytes to write, OUT: number of bytes actually wri=
tten
> - * @stable: An NFS stable_how value
> + * @stable_how: IN: Client's requested stable_how, OUT: Actual stable_ho=
w
>   * @verf: NFS WRITE verifier
>   *
>   * Upon return, caller must invoke fh_put on @fhp.
> @@ -1444,7 +1445,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
>   */
>  __be32
>  nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
> -	   const struct xdr_buf *payload, unsigned long *cnt, int stable,
> +	   const struct xdr_buf *payload, unsigned long *cnt, u32 *stable_how,
>  	   __be32 *verf)
>  {
>  	struct nfsd_file *nf;
> @@ -1457,7 +1458,7 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *f=
hp, loff_t offset,
>  		goto out;
> =20
>  	err =3D nfsd_vfs_write(rqstp, fhp, nf, offset, payload, cnt,
> -			     stable, verf);
> +			     stable_how, verf);
>  	nfsd_file_put(nf);
>  out:
>  	trace_nfsd_write_done(rqstp, fhp, offset, *cnt);
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index fa46f8b5f132..c713ed0b04e0 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -130,11 +130,13 @@ __be32		nfsd_read(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
>  				u32 *eof);
>  __be32		nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  				loff_t offset, const struct xdr_buf *payload,
> -				unsigned long *cnt, int stable, __be32 *verf);
> +				unsigned long *cnt, u32 *stable_how,
> +				__be32 *verf);
>  __be32		nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  				struct nfsd_file *nf, loff_t offset,
>  				const struct xdr_buf *payload,
> -				unsigned long *cnt, int stable, __be32 *verf);
> +				unsigned long *cnt, u32 *stable_how,
> +				__be32 *verf);
>  __be32		nfsd_readlink(struct svc_rqst *, struct svc_fh *,
>  				char *, int *);
>  __be32		nfsd_symlink(struct svc_rqst *, struct svc_fh *,
> diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
> index 522067b7fd75..c0e443ef3a6b 100644
> --- a/fs/nfsd/xdr3.h
> +++ b/fs/nfsd/xdr3.h
> @@ -152,7 +152,7 @@ struct nfsd3_writeres {
>  	__be32			status;
>  	struct svc_fh		fh;
>  	unsigned long		count;
> -	int			committed;
> +	u32			committed;
>  	__be32			verf[2];
>  };
> =20

Looks reasonable, and with this we can have the DIO write path override
what the client requested.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

