Return-Path: <linux-nfs+bounces-5354-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51596951A67
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 13:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 760011C213F6
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 11:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EA519EEAF;
	Wed, 14 Aug 2024 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueV+D/ur"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB44E33D8
	for <linux-nfs@vger.kernel.org>; Wed, 14 Aug 2024 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723636369; cv=none; b=uabiEIl/1LTr5GivuKaunTlP8A9E74y++ek5rYSgJyPSzRARM17RddDEHWxmgFFogYRcslht7jZOTxcxFwkzjhfLXs4BP7raq8lEnbgKZUdbAuhzlZgZH+mdx8SO5i1ou4DWguHYvlttyWwIeCF9bBDGd0GuPva8q88SkUTqgDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723636369; c=relaxed/simple;
	bh=XLITBdH5cp7fw0a64c2AFW6rlC6QG9TY4Kgw2JhWtwQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OxP2DS0gORnCeQ19vXvjaKb6KZasnwm3HL2qkEBHXLTjhMIlAimLvZ2ZCPsqAPJeK7nkuIc+CtsfX9TuMHJGqJP7V/0s3falLwbKPyN8I4kXnO2PgrzixJRfKMaWyBv923k1/aBgMl5nciRX3y+sMNOgpRWD+ELy+e6zReTXlUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueV+D/ur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46F2C32786;
	Wed, 14 Aug 2024 11:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723636369;
	bh=XLITBdH5cp7fw0a64c2AFW6rlC6QG9TY4Kgw2JhWtwQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ueV+D/urNcVHdajfcvzDP2jUTktQ/loBaQG8MTRGJmpK26i7Ezztz5V1wdobtSXd9
	 LWS4NY8dLdP29wdsBq5g4Y78uHMthJgXU/u6LX9L4+jSZYPy7L6YphDlP3ueWETM9Y
	 05ruzDEkzv88O9VFGxs3EcVa9TixN3l13JCPOzuUhg3Xrz/JMxj8W19QE412s/efTC
	 NQ5XuDFza/hU4a0jCJrNwxmr/i5iMYmVhdCUeGTlqLkyhyQvScZdl3rFHYVaqmeI8V
	 tfbY1vhlE6UAX06P06qBBnObzQfwPMgNKyQHw6v++1is4UDJscuUrxjE1bLN2+J+XQ
	 VYZGqiNWlfePw==
Message-ID: <092702c0783b6b97b2d39b8c847556c478e58207.camel@kernel.org>
Subject: Re: [PATCH v2] SQUASH: nfsd: move error choice for incorrect object
 types to version-specific code.
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Date: Wed, 14 Aug 2024 07:52:47 -0400
In-Reply-To: <172361193894.6062.4098495640528994632@noble.neil.brown.name>
References: <172361193894.6062.4098495640528994632@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-14 at 15:05 +1000, NeilBrown wrote:
> [This should be squashed into the existing patch for the same name,
> with this commit message used instead of the current one.  It addresses
> the pynfs failures that Jeff found]
>=20
> If an NFS operation expects a particular sort of object (file, dir, link,
> etc) but gets a file handle for a different sort of object, it must
> return an error.  The actual error varies among NFS version in non-trivia=
l
> ways.
>=20
> For v2 and v3 there are ISDIR and NOTDIR errors and, for NFSv4 only,
> INVAL is suitable.
>=20
> For v4.0 there is also NFS4ERR_SYMLINK which should be used if a SYMLINK
> was found when not expected.  This take precedence over NOTDIR.
>=20
> For v4.1+ there is also NFS4ERR_WRONG_TYPE which should be used in
> preference to EINVAL when none of the specific error codes apply.
>=20
> When nfsd_mode_check() finds a symlink where it expected a directory it
> needs to return an error code that can be converted to NOTDIR for v2 or
> v3 but will be SYMLINK for v4.  It must be different from the error
> code returns when it finds a symlink but expects a regular file - that
> must be converted to EINVAL or SYMLINK.
>=20
> So we introduce an internal error code nfserr_symlink_not_dir which each
> version converts as appropriate.
>=20
> nfsd_check_obj_isreg() is similar to nfsd_mode_check() except that it is
> only used by NFSv4 and only for OPEN.  NFSERR_INVAL is never a suitable
> error if the object is the wrong time.  For v4.0 we use nfserr_symlink
> for non-dirs even if not a symlink.  For v4.1 we have nfserr_wrong_type.
> We handling this difference in-place in nfsd_check_obj_isreg() as there
> is nothing to be gained by delaying the choice to nfsd4_map_status().
>=20
> As a result of these changes, nfsd_mode_check() doesn't need an rqstp
> arg any more.
>=20
> Note that NFSv4 operations are actually performed in the xdr code(!!!)
> so to the only place that we can map the status code successfully is in
> nfsd4_encode_operation().
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4proc.c | 31 +++++++++----------------------
>  fs/nfsd/nfs4xdr.c  | 19 +++++++++++++++++++
>  2 files changed, 28 insertions(+), 22 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 2e355085e443..fc68af757080 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -158,7 +158,7 @@ do_open_permission(struct svc_rqst *rqstp, struct svc=
_fh *current_fh, struct nfs
>  	return fh_verify(rqstp, current_fh, S_IFREG, accmode);
>  }
> =20
> -static __be32 nfsd_check_obj_isreg(struct svc_fh *fh)
> +static __be32 nfsd_check_obj_isreg(struct svc_fh *fh, u32 minor_version)
>  {
>  	umode_t mode =3D d_inode(fh->fh_dentry)->i_mode;
> =20
> @@ -168,7 +168,13 @@ static __be32 nfsd_check_obj_isreg(struct svc_fh *fh=
)
>  		return nfserr_isdir;
>  	if (S_ISLNK(mode))
>  		return nfserr_symlink;
> -	return nfserr_wrong_type;
> +
> +	/* RFC 7530 - 16.16.6 */
> +	if (minor_version =3D=3D 0)
> +		return nfserr_symlink;
> +	else
> +		return nfserr_wrong_type;
> +
>  }
> =20
>  static void nfsd4_set_open_owner_reply_cache(struct nfsd4_compound_state=
 *cstate, struct nfsd4_open *open, struct svc_fh *resfh)
> @@ -179,23 +185,6 @@ static void nfsd4_set_open_owner_reply_cache(struct =
nfsd4_compound_state *cstate
>  			&resfh->fh_handle);
>  }
> =20
> -static __be32 nfsd4_map_status(__be32 status, u32 minor)
> -{
> -	switch (status) {
> -	case nfs_ok:
> -		break;
> -	case nfserr_wrong_type:
> -		/* RFC 8881 - 15.1.2.9 */
> -		if (minor =3D=3D 0)
> -			status =3D nfserr_inval;
> -		break;
> -	case nfserr_symlink_not_dir:
> -		status =3D nfserr_symlink;
> -		break;
> -	}
> -	return status;
> -}
> -
>  static inline bool nfsd4_create_is_exclusive(int createmode)
>  {
>  	return createmode =3D=3D NFS4_CREATE_EXCLUSIVE ||
> @@ -478,7 +467,7 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate, stru
>  	}
>  	if (status)
>  		goto out;
> -	status =3D nfsd_check_obj_isreg(*resfh);
> +	status =3D nfsd_check_obj_isreg(*resfh, cstate->minorversion);
>  	if (status)
>  		goto out;
> =20
> @@ -2815,8 +2804,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
>  			nfsd4_encode_replay(resp->xdr, op);
>  			status =3D op->status =3D op->replay->rp_status;
>  		} else {
> -			op->status =3D nfsd4_map_status(op->status,
> -						      cstate->minorversion);
>  			nfsd4_encode_operation(resp, op);
>  			status =3D op->status;
>  		}
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 42b41d55d4ed..1c3067f46be7 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -5729,6 +5729,23 @@ __be32 nfsd4_check_resp_size(struct nfsd4_compound=
res *resp, u32 respsize)
>  	return nfserr_rep_too_big;
>  }
> =20
> +static __be32 nfsd4_map_status(__be32 status, u32 minor)
> +{
> +	switch (status) {
> +	case nfs_ok:
> +		break;
> +	case nfserr_wrong_type:
> +		/* RFC 8881 - 15.1.2.9 */
> +		if (minor =3D=3D 0)
> +			status =3D nfserr_inval;
> +		break;
> +	case nfserr_symlink_not_dir:
> +		status =3D nfserr_symlink;
> +		break;
> +	}
> +	return status;
> +}
> +
>  void
>  nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *=
op)
>  {
> @@ -5796,6 +5813,8 @@ nfsd4_encode_operation(struct nfsd4_compoundres *re=
sp, struct nfsd4_op *op)
>  						so->so_replay.rp_buf, len);
>  	}
>  status:
> +	op->status =3D nfsd4_map_status(op->status,
> +				      resp->cstate.minorversion);
>  	*p =3D op->status;
>  release:
>  	if (opdesc && opdesc->op_release)

LGTM

Reviewed-by: Jeff Layton <jlayton@kernel.org>

