Return-Path: <linux-nfs+bounces-13811-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC82B2EC5A
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 05:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4969E1725C1
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 03:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792953D81;
	Thu, 21 Aug 2025 03:50:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B762C324F
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 03:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755748243; cv=none; b=M4jouo70kpj0J25CZZGkpocxfMSdOxxpDrOgeuPZSbcZpybTBnBCSWRyG/Y5wbJj5lIQb93le+qub9aToaDvMgo2+tl+pU29wo22hdBkTeAumkYbXk9qCbtrD8kXU2X4cchLGeNGueuww3mhynl5SZIPypACJpNUZa0Eb8l8tFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755748243; c=relaxed/simple;
	bh=BvNvBbYRpuW4s5gja5GQBTZriai294XEDFv63Cc2WBM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=KT8pBzwC1FVYMgHNUedBopyIXB+ghWvV2KrWoTZC1aX8iyKRUiT+NZyz/ythCKDFI9RNCHCU4bBFgtQl4rqfY74PQl6zzzEX7MOIz/vK5nZ0Het5d+X5KZPa7PhG+2VY1lOLySN60kyylX0dYhDI1ftpCZLvLJ/9JYjy8RK3y1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uowJv-006Xoo-Up;
	Thu, 21 Aug 2025 03:50:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Cc: "Olga Kornievskaia" <okorniev@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: discard nfserr_dropit
In-reply-to: <175573864133.2234665.4220094746965657176@noble.neil.brown.name>
References: <175573864133.2234665.4220094746965657176@noble.neil.brown.name>
Date: Thu, 21 Aug 2025 13:50:37 +1000
Message-id: <175574823735.2234665.17246191584766736234@noble.neil.brown.name>

On Thu, 21 Aug 2025, NeilBrown wrote:
>=20
> nfserr_dropit hasn't been used for over a decade, since rq_dropme and
> the RQ_DROPME were introduced.
>=20
> Time to get rid of it completely.
>=20
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/lockd.c | 2 --
>  fs/nfsd/nfsd.h  | 8 +-------
>  2 files changed, 1 insertion(+), 9 deletions(-)
>=20
> diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
> index edc9f75dc75c..dca80f5de0ad 100644
> --- a/fs/nfsd/lockd.c
> +++ b/fs/nfsd/lockd.c
> @@ -57,8 +57,6 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struc=
t file **filp,
>  	switch (nfserr) {
>  	case nfs_ok:
>  		return 0;
> -	case nfserr_dropit:
> -		return nlm_drop_reply;
>  	case nfserr_stale:
>  		return nlm_stale_fh;
>  	default:
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 1cd0bed57bc2..2c9fa884ab05 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -335,14 +335,8 @@ void		nfsd_lockd_shutdown(void);
>   * cannot conflict with any existing be32 nfserr value.
>   */
>  enum {
> -	NFSERR_DROPIT =3D NFS4ERR_FIRST_FREE,
> -/* if a request fails due to kmalloc failure, it gets dropped.
> - *  Client should resend eventually
> - */
> -#define	nfserr_dropit		cpu_to_be32(NFSERR_DROPIT)
> -
>  /* end-of-file indicator in readdir */
> -	NFSERR_EOF,
> +	NFSERR_EOF, =3D NFS4ERR_FIRST_FREE,

                  ^

Please drop this incorrect comma.

NeilBrown


>  #define	nfserr_eof		cpu_to_be32(NFSERR_EOF)
> =20
>  /* replay detected */
>=20
> --=20
> 2.50.0.107.gf914562f5916.dirty
>=20
>=20
>=20


