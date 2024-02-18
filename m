Return-Path: <linux-nfs+bounces-2016-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B85859764
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Feb 2024 15:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2234F2823E5
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Feb 2024 14:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174496BB52;
	Sun, 18 Feb 2024 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AO3/wcUQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64E06BB4D
	for <linux-nfs@vger.kernel.org>; Sun, 18 Feb 2024 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708266249; cv=none; b=i2wrFjWNSLZG2FOIawQu/FfbW9OxIQ/7w8YnGLlrHDskH9I0XkJIUhjBEVy6Dh5iZNk0WqalSZg0CwoYPN/w1jT9gZQIOPRVKZDIlz8TlQ3pPpZJmjbiuDUi/X7xb3/M7Uh/SZakJtEqK+3zGepQ05wH0oPl8tD/fVr5Q/xUyeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708266249; c=relaxed/simple;
	bh=oXTYSVkX+TcDaPUR6ol5HciXO9dCb07e1NbenLsrcyE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q8ge9jRwjbpgyci8SdVnxG30jmMtipgUvbgO99HBY2sa7xkAz0yXj+Qi+bOZ5/G9Tp2lM9w8T9lTNpb4rdgck0bJkIDiytIEy4vLUTh4FVFgmZwj1J6rUjirxmfyVQqI6AHPRLLko8f/tl37nhsHP5VMNQlqgkLnC4d3N/BLE5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AO3/wcUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E609FC433F1;
	Sun, 18 Feb 2024 14:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708266248;
	bh=oXTYSVkX+TcDaPUR6ol5HciXO9dCb07e1NbenLsrcyE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=AO3/wcUQiB+bEtpc7MbpnYeoPo3EBRIN/2dm0iUXRbn8AbB9R/PhmFD98Y8pNYFSp
	 tEROYt2DYtubCRZXqTgRWDPPwZHtuRtYlYmLpAaLDAnAq1wtf4BnN7GvkfNQTtsGI1
	 X/o97y4SGk9u7qf5cyg8Aa6GMMLEDMWh2cBGMwPlQf+OXEnuBQyYQleJk6+H2+jtpQ
	 4WXecybEyHJh4rsJ5Dkn0G1xhLIuhySOUiaXPU97Lp8/B3P4m3/tOljHt9ySg8c2AQ
	 D0uOjW+UpHiYsli1DwmF4cy4Ui6dWeyskpruGKZTFubAKlsV1DW5R/Czwrqr+JcZ6/
	 aWUAvq24+CELA==
Message-ID: <6b89896530272a92d4350b21865dae8f99f07f9c.camel@kernel.org>
Subject: Re: [PATCH v2 2/2] nfsd: Fix NFSv3 atomicity bugs in nfsd_setattr()
From: Jeff Layton <jlayton@kernel.org>
To: trondmy@kernel.org, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Date: Sun, 18 Feb 2024 09:24:06 -0500
In-Reply-To: <20240216012451.22725-3-trondmy@kernel.org>
References: <20240216012451.22725-1-trondmy@kernel.org>
	 <20240216012451.22725-2-trondmy@kernel.org>
	 <20240216012451.22725-3-trondmy@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-15 at 20:24 -0500, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> The main point of the guarded SETATTR is to prevent races with other
> WRITE and SETATTR calls. That requires that the check of the guard time
> against the inode ctime be done after taking the inode lock.
>=20
> Furthermore, we need to take into account the 32-bit nature of
> timestamps in NFSv3, and the possibility that files may change at a
> faster rate than once a second.
>=20
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfsd/nfs3proc.c  |  6 ++++--
>  fs/nfsd/nfs3xdr.c   |  5 +----
>  fs/nfsd/nfs4proc.c  |  3 +--
>  fs/nfsd/nfs4state.c |  2 +-
>  fs/nfsd/nfsproc.c   |  6 +++---
>  fs/nfsd/vfs.c       | 20 +++++++++++++-------
>  fs/nfsd/vfs.h       |  2 +-
>  fs/nfsd/xdr3.h      |  2 +-
>  8 files changed, 25 insertions(+), 21 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index b78eceebd945..dfcc957e460d 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -71,13 +71,15 @@ nfsd3_proc_setattr(struct svc_rqst *rqstp)
>  	struct nfsd_attrs attrs =3D {
>  		.na_iattr	=3D &argp->attrs,
>  	};
> +	const struct timespec64 *guardtime =3D NULL;
> =20
>  	dprintk("nfsd: SETATTR(3)  %s\n",
>  				SVCFH_fmt(&argp->fh));
> =20
>  	fh_copy(&resp->fh, &argp->fh);
> -	resp->status =3D nfsd_setattr(rqstp, &resp->fh, &attrs,
> -				    argp->check_guard, argp->guardtime);
> +	if (argp->check_guard)
> +		guardtime =3D &argp->guardtime;
> +	resp->status =3D nfsd_setattr(rqstp, &resp->fh, &attrs, guardtime);
>  	return rpc_success;
>  }
> =20
> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> index f32128955ec8..a7a07470c1f8 100644
> --- a/fs/nfsd/nfs3xdr.c
> +++ b/fs/nfsd/nfs3xdr.c
> @@ -295,17 +295,14 @@ svcxdr_decode_sattr3(struct svc_rqst *rqstp, struct=
 xdr_stream *xdr,
>  static bool
>  svcxdr_decode_sattrguard3(struct xdr_stream *xdr, struct nfsd3_sattrargs=
 *args)
>  {
> -	__be32 *p;
>  	u32 check;
> =20
>  	if (xdr_stream_decode_bool(xdr, &check) < 0)
>  		return false;
>  	if (check) {
> -		p =3D xdr_inline_decode(xdr, XDR_UNIT * 2);
> -		if (!p)
> +		if (!svcxdr_decode_nfstime3(xdr, &args->guardtime))
>  			return false;
>  		args->check_guard =3D 1;
> -		args->guardtime =3D be32_to_cpup(p);
>  	} else
>  		args->check_guard =3D 0;
> =20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index e6d8624efc83..ae48690f4c7c 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1171,8 +1171,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_=
compound_state *cstate,
>  		goto out;
>  	save_no_wcc =3D cstate->current_fh.fh_no_wcc;
>  	cstate->current_fh.fh_no_wcc =3D true;
> -	status =3D nfsd_setattr(rqstp, &cstate->current_fh, &attrs,
> -				0, (time64_t)0);
> +	status =3D nfsd_setattr(rqstp, &cstate->current_fh, &attrs, NULL);
>  	cstate->current_fh.fh_no_wcc =3D save_no_wcc;
>  	if (!status)
>  		status =3D nfserrno(attrs.na_labelerr);
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 2fa54cfd4882..538edd85b51e 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5191,7 +5191,7 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_f=
h *fh,
>  		return 0;
>  	if (!(open->op_share_access & NFS4_SHARE_ACCESS_WRITE))
>  		return nfserr_inval;
> -	return nfsd_setattr(rqstp, fh, &attrs, 0, (time64_t)0);
> +	return nfsd_setattr(rqstp, fh, &attrs, NULL);
>  }
> =20
>  static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file=
 *fp,
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index a7315928a760..36370b957b63 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -103,7 +103,7 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
>  		}
>  	}
> =20
> -	resp->status =3D nfsd_setattr(rqstp, fhp, &attrs, 0, (time64_t)0);
> +	resp->status =3D nfsd_setattr(rqstp, fhp, &attrs, NULL);
>  	if (resp->status !=3D nfs_ok)
>  		goto out;
> =20
> @@ -390,8 +390,8 @@ nfsd_proc_create(struct svc_rqst *rqstp)
>  		 */
>  		attr->ia_valid &=3D ATTR_SIZE;
>  		if (attr->ia_valid)
> -			resp->status =3D nfsd_setattr(rqstp, newfhp, &attrs, 0,
> -						    (time64_t)0);
> +			resp->status =3D nfsd_setattr(rqstp, newfhp, &attrs,
> +						    NULL);
>  	}
> =20
>  out_unlock:
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 58fab461bc00..3602e35e83d2 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -476,7 +476,6 @@ static int __nfsd_setattr(struct dentry *dentry, stru=
ct iattr *iap)
>   * @rqstp: controlling RPC transaction
>   * @fhp: filehandle of target
>   * @attr: attributes to set
> - * @check_guard: set to 1 if guardtime is a valid timestamp
>   * @guardtime: do not act if ctime.tv_sec does not match this timestamp
>   *
>   * This call may adjust the contents of @attr (in particular, this
> @@ -488,8 +487,7 @@ static int __nfsd_setattr(struct dentry *dentry, stru=
ct iattr *iap)
>   */
>  __be32
>  nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -	     struct nfsd_attrs *attr,
> -	     int check_guard, time64_t guardtime)
> +	     struct nfsd_attrs *attr, const struct timespec64 *guardtime)
>  {
>  	struct dentry	*dentry;
>  	struct inode	*inode;
> @@ -538,9 +536,6 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *f=
hp,
> =20
>  	nfsd_sanitize_attrs(inode, iap);
> =20
> -	if (check_guard && guardtime !=3D inode_get_ctime_sec(inode))
> -		return nfserr_notsync;
> -
>  	/*
>  	 * The size case is special, it changes the file in addition to the
>  	 * attributes, and file systems don't expect it to be mixed with
> @@ -558,6 +553,16 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *=
fhp,
>  	err =3D fh_fill_pre_attrs(fhp);
>  	if (err)
>  		goto out_unlock;
> +
> +	if (guardtime) {
> +		struct timespec64 ctime =3D inode_get_ctime(inode);
> +		if ((u32)guardtime->tv_sec !=3D (u32)ctime.tv_sec ||
> +		    guardtime->tv_nsec !=3D ctime.tv_nsec) {
> +			err =3D nfserr_notsync;
> +			goto out_fill_attrs;
> +		}
> +	}
> +
>  	for (retries =3D 1;;) {
>  		struct iattr attrs;
> =20
> @@ -585,6 +590,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *f=
hp,
>  		attr->na_aclerr =3D set_posix_acl(&nop_mnt_idmap,
>  						dentry, ACL_TYPE_DEFAULT,
>  						attr->na_dpacl);
> +out_fill_attrs:
>  	fh_fill_post_attrs(fhp);
>  out_unlock:
>  	inode_unlock(inode);
> @@ -1409,7 +1415,7 @@ nfsd_create_setattr(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
>  	 * if the attributes have not changed.
>  	 */
>  	if (iap->ia_valid)
> -		status =3D nfsd_setattr(rqstp, resfhp, attrs, 0, (time64_t)0);
> +		status =3D nfsd_setattr(rqstp, resfhp, attrs, NULL);
>  	else
>  		status =3D nfserrno(commit_metadata(resfhp));
> =20
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 702fbc4483bf..7d77303ef5f7 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -69,7 +69,7 @@ __be32		 nfsd_lookup_dentry(struct svc_rqst *, struct s=
vc_fh *,
>  				const char *, unsigned int,
>  				struct svc_export **, struct dentry **);
>  __be32		nfsd_setattr(struct svc_rqst *, struct svc_fh *,
> -				struct nfsd_attrs *, int, time64_t);
> +			     struct nfsd_attrs *, const struct timespec64 *);
>  int nfsd_mountpoint(struct dentry *, struct svc_export *);
>  #ifdef CONFIG_NFSD_V4
>  __be32		nfsd4_vfs_fallocate(struct svc_rqst *, struct svc_fh *,
> diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
> index 03fe4e21306c..522067b7fd75 100644
> --- a/fs/nfsd/xdr3.h
> +++ b/fs/nfsd/xdr3.h
> @@ -14,7 +14,7 @@ struct nfsd3_sattrargs {
>  	struct svc_fh		fh;
>  	struct iattr		attrs;
>  	int			check_guard;
> -	time64_t		guardtime;
> +	struct timespec64	guardtime;
>  };
> =20
>  struct nfsd3_diropargs {

I thought I sent this the other day, but...

Reviewed-by: Jeff Layton <jlayton@kernel.org>

