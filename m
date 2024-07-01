Return-Path: <linux-nfs+bounces-4485-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B47AF91DD9A
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 13:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365221F22B18
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 11:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2A812E1EE;
	Mon,  1 Jul 2024 11:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tU10Q4Hy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84EF537E7
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jul 2024 11:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719832325; cv=none; b=AhSS9clGA9T0jZZdxOtou2sQkhaA2RtntODyvxBVEpAtUDL3hb67wYAXa9WOfJBLoK0DlL6rd6Sl/MfXqeZ2i0xAdjvUz3tq9tu69y3YwSHVfISDAbb5XV0uZuxMnl3uw9qYkNERSwhEC1smcEj7E6mEw+Ou37avX2XnaEdEJ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719832325; c=relaxed/simple;
	bh=rsVRvDfK6f4bfzg88qidTUZFbbVz87IxYSnjB1lEr4k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jMQBXxtQat6Wdtb/NtxZbG2XiLVLbQlOcUeMZpTBmfhGCtCMUQOpjvW7eZZsKcNyt6yj0143nJOrHqFvQjwQGOfjGzO8HMlxxbzPNaIhIK5zVki+4qkMjhLxr6D5fX064nmX5UxzIALM1GxIoRizEgds3z1GC+U9hkYc0vSrnPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tU10Q4Hy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71085C116B1;
	Mon,  1 Jul 2024 11:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719832325;
	bh=rsVRvDfK6f4bfzg88qidTUZFbbVz87IxYSnjB1lEr4k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=tU10Q4HyWVAEAhamawXbjuQl8LKZ02WL4JomGsmXcl40johZOTRfFNk+JwCCmFEi1
	 gyaDjef3tBSHWPnB/c/te5WtSjOB/GhWYYdE3ieZYBUuROnpHvAuCgfdKG+sgO8S3n
	 evVhGNl4IGus9lZBaOfjhSZB6iog3Q6ScVsWgp6LA39IuyGFe1GhYTEeno6OkLoDB9
	 XL2nGlpsjfQEcqlZrt0N4CJiclIVeUho8hAQ0VSf+3ReoKTPjWywsVgKRD4EBOJ2Mq
	 WZIJYdHemO6H1HDVngMfJhdgBMXcm/N0CrOixsE7TilKGXn5SOVBZ8IIaNegC3o7pg
	 J12wTW64YPQhw==
Message-ID: <6972322de7999d4e7e9691a86539ea47210e22b0.camel@kernel.org>
Subject: Re: [PATCH 4/6] nfsd: pass client explicitly to __fh_verify()
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Mike Snitzer
	 <snitzer@kernel.org>
Date: Mon, 01 Jul 2024 07:12:03 -0400
In-Reply-To: <20240701025802.22985-5-neilb@suse.de>
References: <20240701025802.22985-1-neilb@suse.de>
	 <20240701025802.22985-5-neilb@suse.de>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-01 at 12:53 +1000, NeilBrown wrote:
> Rather than using rqstp->rq_client pass the client explicitly to
> __fh_verify and thence to rqst_exp_find().=C2=A0 If rqst_exp_find is give=
n
> an
> explicit client it doesn't try ->rq_gssclient.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> =C2=A0fs/nfsd/export.c=C2=A0=C2=A0 | 15 ++++++++++-----
> =C2=A0fs/nfsd/export.h=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0fs/nfsd/nfs4proc.c |=C2=A0 2 +-
> =C2=A0fs/nfsd/nfsfh.c=C2=A0=C2=A0=C2=A0 | 11 ++++++-----
> =C2=A04 files changed, 18 insertions(+), 12 deletions(-)
>=20
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index a35f06b610d0..ccfe8c528bcb 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -1165,21 +1165,26 @@ rqst_exp_get_by_name(struct svc_rqst *rqstp,
> struct path *path)
> =C2=A0}
> =C2=A0

While you're in here, care to write a kerneldoc for rqst_exp_find? The
arguments to this are getting pretty complex, so it might help clarify
things.

> =C2=A0struct svc_export *
> -rqst_exp_find(struct svc_rqst *rqstp,=C2=A0 struct nfsd_net *nn,
> +rqst_exp_find(struct svc_rqst *rqstp, struct nfsd_net *nn,
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct auth_domain *client,
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int fsid_type, u32 *fsidv)
> =C2=A0{
> =C2=A0	struct svc_export *gssexp, *exp =3D ERR_PTR(-ENOENT);
> =C2=A0	struct cache_detail *cd;
> +	bool try_gss =3D rqstp && !client;
> =C2=A0
> =C2=A0	if (!nn)
> =C2=A0		nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
> =C2=A0	cd =3D nn->svc_export_cache;
> =C2=A0
> -	if (rqstp->rq_client =3D=3D NULL)
> +	if (!client && rqstp)
> +		client =3D rqstp->rq_client;
> +
> +	if (client =3D=3D NULL)
> =C2=A0		goto gss;
> =C2=A0
> =C2=A0	/* First try the auth_unix client: */
> -	exp =3D exp_find(cd, rqstp->rq_client, fsid_type,
> +	exp =3D exp_find(cd, client, fsid_type,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fsidv, &rqstp->rq_chandle);

The checks you've added make it appear like rqstp can be NULL, but
above you're still dereferencing it to get the ->rq_chandle. That seems
problematic?

> =C2=A0	if (PTR_ERR(exp) =3D=3D -ENOENT)
> =C2=A0		goto gss;
> @@ -1190,7 +1195,7 @@ rqst_exp_find(struct svc_rqst *rqstp,=C2=A0 struct
> nfsd_net *nn,
> =C2=A0		return exp;
> =C2=A0gss:
> =C2=A0	/* Otherwise, try falling back on gss client */
> -	if (rqstp->rq_gssclient =3D=3D NULL)
> +	if (!try_gss || rqstp->rq_gssclient =3D=3D NULL)
> =C2=A0		return exp;
> =C2=A0	gssexp =3D exp_find(cd, rqstp->rq_gssclient, fsid_type, fsidv,
> =C2=A0						&rqstp->rq_chandle);
> @@ -1224,7 +1229,7 @@ struct svc_export
> *rqst_find_fsidzero_export(struct svc_rqst *rqstp)
> =C2=A0
> =C2=A0	mk_fsid(FSID_NUM, fsidv, 0, 0, 0, NULL);
> =C2=A0
> -	return rqst_exp_find(rqstp, NULL, FSID_NUM, fsidv);
> +	return rqst_exp_find(rqstp, NULL, NULL, FSID_NUM, fsidv);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
> index 2dbd15704a86..accad9d231fd 100644
> --- a/fs/nfsd/export.h
> +++ b/fs/nfsd/export.h
> @@ -130,6 +130,6 @@ static inline struct svc_export *exp_get(struct
> svc_export *exp)
> =C2=A0}
> =C2=A0struct nfsd_net;
> =C2=A0struct svc_export * rqst_exp_find(struct svc_rqst *, struct nfsd_ne=
t
> *,
> -				=C2=A0 int, u32 *);
> +				=C2=A0 struct auth_domain *, int, u32 *);
> =C2=A0
> =C2=A0#endif /* NFSD_EXPORT_H */
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 30335cdf9e6c..8430c197c900 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2231,7 +2231,7 @@ nfsd4_getdeviceinfo(struct svc_rqst *rqstp,
> =C2=A0		return nfserr_noent;
> =C2=A0	}
> =C2=A0
> -	exp =3D rqst_exp_find(rqstp, NULL, map->fsid_type, map->fsid);
> +	exp =3D rqst_exp_find(rqstp, NULL, NULL, map->fsid_type, map-
> >fsid);
> =C2=A0	if (IS_ERR(exp)) {
> =C2=A0		dprintk("%s: could not find device id\n", __func__);
> =C2=A0		return nfserr_noent;
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index adc731bb171e..ea3d98c43a9d 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -155,7 +155,7 @@ static inline __be32 check_pseudo_root(int
> nfs_vers,
> =C2=A0 */
> =C2=A0static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct
> nfsd_net *nn,
> =C2=A0				 struct svc_cred *cred, int
> nfs_vers,
> -				 struct svc_fh *fhp)
> +				 struct auth_domain *client, struct
> svc_fh *fhp)
> =C2=A0{
> =C2=A0	struct knfsd_fh	*fh =3D &fhp->fh_handle;
> =C2=A0	struct fid *fid =3D NULL;
> @@ -199,7 +199,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst
> *rqstp, struct nfsd_net *nn,
> =C2=A0	data_left -=3D len;
> =C2=A0	if (data_left < 0)
> =C2=A0		return error;
> -	exp =3D rqst_exp_find(rqstp, nn, fh->fh_fsid_type, fh-
> >fh_fsid);
> +	exp =3D rqst_exp_find(rqstp, nn, client, fh->fh_fsid_type, fh-
> >fh_fsid);
> =C2=A0	fid =3D (struct fid *)(fh->fh_fsid + len);
> =C2=A0
> =C2=A0	error =3D nfserr_stale;
> @@ -331,7 +331,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst
> *rqstp, struct nfsd_net *nn,
> =C2=A0static __be32
> =C2=A0__fh_verify(struct svc_rqst *rqstp,
> =C2=A0	=C2=A0=C2=A0=C2=A0 struct nfsd_net *nn, struct svc_cred *cred,
> -	=C2=A0=C2=A0=C2=A0 int nfs_vers,
> +	=C2=A0=C2=A0=C2=A0 int nfs_vers, struct auth_domain *client,
> =C2=A0	=C2=A0=C2=A0=C2=A0 struct svc_fh *fhp, umode_t type, int access)
> =C2=A0{
> =C2=A0	struct svc_export *exp =3D NULL;
> @@ -339,7 +339,8 @@ __fh_verify(struct svc_rqst *rqstp,
> =C2=A0	__be32		error;
> =C2=A0
> =C2=A0	if (!fhp->fh_dentry) {
> -		error =3D nfsd_set_fh_dentry(rqstp, nn, cred,
> nfs_vers, fhp);
> +		error =3D nfsd_set_fh_dentry(rqstp, nn, cred,
> nfs_vers, client,
> +					=C2=A0=C2=A0 fhp);
> =C2=A0		if (error)
> =C2=A0			goto out;
> =C2=A0	}
> @@ -415,7 +416,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh
> *fhp, umode_t type, int access)
> =C2=A0	else /* must be NLM */
> =C2=A0		nfs_vers =3D rqstp->rq_vers =3D=3D 4 ? 3 : 2;
> =C2=A0	return __fh_verify(rqstp, net_generic(SVC_NET(rqstp),
> nfsd_net_id),
> -			=C2=A0=C2=A0 &rqstp->rq_cred, nfs_vers,
> +			=C2=A0=C2=A0 &rqstp->rq_cred, nfs_vers, rqstp-
> >rq_client,
> =C2=A0			=C2=A0=C2=A0 fhp, type, access);
> =C2=A0}
> =C2=A0

--=20
Jeff Layton <jlayton@kernel.org>

