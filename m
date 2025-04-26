Return-Path: <linux-nfs+bounces-11290-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E96A9DA7A
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Apr 2025 14:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595F34676DB
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Apr 2025 12:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852655A79B;
	Sat, 26 Apr 2025 12:03:32 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DEEA926
	for <linux-nfs@vger.kernel.org>; Sat, 26 Apr 2025 12:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745669012; cv=none; b=TjALOPu13Wlks/x+zqCGNU3mNwFXp8g5d5wTG4GNjKF2MoyrCls33MFBamUld2DQrdAQn8kc5t3ST0R8rZAAU7Zi2S0bNLKsq8ed4i+FNB8dxSs/tg7ZbV94OvvSGGBetNLpa0LMV49VuXw1WcDXAted6a5Wji70Ms6OUkTBkOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745669012; c=relaxed/simple;
	bh=gdH7NSXB73PA2MDOCwPDrhMfk2SIwhhjt90X+UVTFjM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=fIVuPw6cxjqdSvAyR5eGdHH/v6oQ9o9NMUNOT+9zUPX26rWkJN1I0MFg4hGsX1QMaCJpW+DaQFpPpFLHYbIG8W7N6wRPl76WPc185kl1kNUXt3FhheqI44crt8OZUtFYnTLrbwhY9nMuv4+hS948Dv8BdimB6CO8Xc12TmopqYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1u8eFa-0000G4-Mw;
	Sat, 26 Apr 2025 12:03:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: cel@kernel.org
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject:
 Re: [PATCH v3 11/11] NFSD: Remove NFSSVC_MAXBLKSIZE from .pc_xdrressize
In-reply-to: <20250423152117.5418-12-cel@kernel.org>
References: <20250423152117.5418-1-cel@kernel.org>,
 <20250423152117.5418-12-cel@kernel.org>
Date: Sat, 26 Apr 2025 14:31:02 +1000
Message-id: <174564186264.500591.13673906323063582835@noble.neil.brown.name>

On Thu, 24 Apr 2025, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> The value in the .pc_xdrressize field is used to "reserve space in
> the output queue". Relevant only to UDP transports, AFAICT.
>=20
> The fixed value of NFSSVC_MAXBLKSIZE is added to that field for
> NFSv2 and NFSv3 read requests, even though nfsd_proc_read() is
> already careful to reserve the actual size of the read payload.
> Adding the maximum payload size to .pc_xdrressize seems to be
> unnecessary.

I believe it is necessary.

svc_reserve() (and svc_reserve_auth) only ever reduces the size of the
reservation.
->rq_reserved is initialised to serv->sv_max_mesg, then reduced to
.pc_xdrressize once the proc is known, then possibly reduced further by
code in the proc.
So .pc_xdrressize must be (at least) the largest possible size.

>=20
> Also, instead of adding a constant 4 bytes for each payload's
> XDR pad, add the actual size of the pad for better accuracy of
> the reservation size.

Could we instead change svc_reserve() to add the pad, and remove all the
manual padding?

But pc_xdrressize is in xdr units - it is multiplied by 4 before passing
to svc_reserve.  So these changes don't do what you think they do...

NeilBrown


>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs3proc.c | 4 ++--
>  fs/nfsd/nfsproc.c  | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index 372bdcf5e07a..dbb750a7b5db 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -202,7 +202,7 @@ nfsd3_proc_read(struct svc_rqst *rqstp)
>  	 */
>  	resp->count =3D argp->count;
>  	svc_reserve_auth(rqstp, ((1 + NFS3_POST_OP_ATTR_WORDS + 3) << 2) +
> -			 resp->count + 4);
> +			 xdr_align_size(resp->count));
> =20
>  	fh_copy(&resp->fh, &argp->fh);
>  	resp->status =3D nfsd_read(rqstp, &resp->fh, argp->offset,
> @@ -921,7 +921,7 @@ static const struct svc_procedure nfsd_procedures3[22] =
=3D {
>  		.pc_argzero =3D sizeof(struct nfsd3_readargs),
>  		.pc_ressize =3D sizeof(struct nfsd3_readres),
>  		.pc_cachetype =3D RC_NOCACHE,
> -		.pc_xdrressize =3D ST+pAT+4+NFSSVC_MAXBLKSIZE/4,
> +		.pc_xdrressize =3D ST+pAT+3,
>  		.pc_name =3D "READ",
>  	},
>  	[NFS3PROC_WRITE] =3D {
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 6dda081eb24c..a95faf726e58 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -219,7 +219,7 @@ nfsd_proc_read(struct svc_rqst *rqstp)
>  	/* Obtain buffer pointer for payload. 19 is 1 word for
>  	 * status, 17 words for fattr, and 1 word for the byte count.
>  	 */
> -	svc_reserve_auth(rqstp, (19<<2) + argp->count + 4);
> +	svc_reserve_auth(rqstp, (19<<2) + xdr_align_size(argp->count));
> =20
>  	resp->count =3D argp->count;
>  	fh_copy(&resp->fh, &argp->fh);
> @@ -739,7 +739,7 @@ static const struct svc_procedure nfsd_procedures2[18] =
=3D {
>  		.pc_argzero =3D sizeof(struct nfsd_readargs),
>  		.pc_ressize =3D sizeof(struct nfsd_readres),
>  		.pc_cachetype =3D RC_NOCACHE,
> -		.pc_xdrressize =3D ST+AT+1+NFSSVC_MAXBLKSIZE_V2/4,
> +		.pc_xdrressize =3D ST+AT+1,
>  		.pc_name =3D "READ",
>  	},
>  	[NFSPROC_WRITECACHE] =3D {
> --=20
> 2.49.0
>=20
>=20


