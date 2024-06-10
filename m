Return-Path: <linux-nfs+bounces-3627-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E66FA902177
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2024 14:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8D01F214C4
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2024 12:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BFF8004A;
	Mon, 10 Jun 2024 12:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhYRw+13"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548587FBDF
	for <linux-nfs@vger.kernel.org>; Mon, 10 Jun 2024 12:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718021983; cv=none; b=f7EiQbLvEQQQPQ4aXK0I3b9uK57PbStayV560KdAT5CKWL+00FBymfUzHQ4tJ2arx1E3Q+//e/VjzHOR8e7teV4eKWC8JaxDGZq5fEt3enUk6tnScNoh9edyOiSps+10+pOgAq5EoZhnkryCZtc+zZVj5Idh2XBfEgvxzVX4jN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718021983; c=relaxed/simple;
	bh=HU6U7WT9OzRLZRPUyGj7M5pDHABOxy36pLvoFTukhEM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sR8eCNX2KHRknru7gepLxPZmBLHX8NYTGEgtWl3XorAGqBlQ+x40TmKHZOImrHLPoYwlXxq6msm+s+22LjWWbbrqj3QfZkKicTfhzEnkQgsjFX0HzpQTiM2jxRh0OpQ95yzeyD0WXTT9GjVOEQjXnNF4uV0rSb+phJNopc89E/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhYRw+13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E65C2BBFC;
	Mon, 10 Jun 2024 12:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718021983;
	bh=HU6U7WT9OzRLZRPUyGj7M5pDHABOxy36pLvoFTukhEM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=PhYRw+13W6EkuJ1yn6/aAFSX8zmxP8qImqrj3SNd2V4EFoU37p0Y53q+ncFpUxCDn
	 1lUEjz7iM32HzyHF6/GFui3ICIzsX94cTBDE2uMGc2FONtQwBsTm50V7zkU96+FXb7
	 YVMLfMROyrKgJQtm11DYGvkgtm0zCBKJF2c1z1HM6uqiCKrMlODaMqtGJLR24Ky9bN
	 zVDfEV2tAH4l/pXgKOWKN4wBNpeNa1oltKaedZM0YrPi83kuZfaRZrubMRtllROEB0
	 Vt1q4AcExcsGouCqYF5eR0fGvgH49FsfpmYzXiSVTvjFx73uIfYHr5KpfjgFCzUX/h
	 aPiEVizvnO8Ww==
Message-ID: <99655e83d1b2f3fa86ab95adbe3fd1746e8b4343.camel@kernel.org>
Subject: Re: [for-6.11 PATCH 06/29] sunrpc: add rpcauth_map_to_svc_cred
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Trond Myklebust
	 <trondmy@hammerspace.com>, snitzer@hammerspace.com
Date: Mon, 10 Jun 2024 08:19:41 -0400
In-Reply-To: <20240607142646.20924-7-snitzer@kernel.org>
References: <20240607142646.20924-1-snitzer@kernel.org>
	 <20240607142646.20924-7-snitzer@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-07 at 10:26 -0400, Mike Snitzer wrote:
> From: Weston Andros Adamson <dros@primarydata.com>
>=20
> Add new funtion rpcauth_map_to_svc_cred which maps a generic rpc_cred
> to an
> svc_cred suitable for use in nfsd.
>=20
> This is needed by the localio code to map nfs client creds to nfs
> server
> credentials.
>=20
> Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
> =C2=A0include/linux/sunrpc/auth.h |=C2=A0 4 ++++
> =C2=A0net/sunrpc/auth.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 16 ++++++++++++++++
> =C2=A02 files changed, 20 insertions(+)
>=20
> diff --git a/include/linux/sunrpc/auth.h
> b/include/linux/sunrpc/auth.h
> index 61e58327b1aa..5ebf031361a1 100644
> --- a/include/linux/sunrpc/auth.h
> +++ b/include/linux/sunrpc/auth.h
> @@ -11,6 +11,7 @@
> =C2=A0#define _LINUX_SUNRPC_AUTH_H
> =C2=A0
> =C2=A0#include <linux/sunrpc/sched.h>
> +#include <linux/sunrpc/svcauth.h>
> =C2=A0#include <linux/sunrpc/msg_prot.h>
> =C2=A0#include <linux/sunrpc/xdr.h>
> =C2=A0
> @@ -184,6 +185,9 @@ int			rpcauth_uptodatecred(struct
> rpc_task *);
> =C2=A0int			rpcauth_init_credcache(struct rpc_auth *);
> =C2=A0void			rpcauth_destroy_credcache(struct rpc_auth
> *);
> =C2=A0void			rpcauth_clear_credcache(struct
> rpc_cred_cache *);
> +bool			rpcauth_map_to_svc_cred(struct rpc_auth *,
> +						const struct cred *,
> +						struct svc_cred *);
> =C2=A0char *			rpcauth_stringify_acceptor(struct rpc_cred
> *);
> =C2=A0
> =C2=A0static inline
> diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
> index 04534ea537c8..55a03a3bcac2 100644
> --- a/net/sunrpc/auth.c
> +++ b/net/sunrpc/auth.c
> @@ -308,6 +308,22 @@ rpcauth_init_credcache(struct rpc_auth *auth)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(rpcauth_init_credcache);
> =C2=A0
> +bool
> +rpcauth_map_to_svc_cred(struct rpc_auth *auth, const struct cred
> *cred,
> +			struct svc_cred *svc)
> +{
> +	svc->cr_uid =3D cred->uid;
> +	svc->cr_gid =3D cred->gid;
> +	svc->cr_flavor =3D auth->au_flavor;
> +	svc->cr_principal =3D NULL;
> +	svc->cr_gss_mech =3D NULL;

Setting the above to NULLs makes me a little nervous, but these values
are usually handled at the RPC layer during svc_authenticate. The
localio code hooks in below that, so this should hopefully not be a
problem.

=20
> +	if (cred->group_info)
> +		svc->cr_group_info =3D get_group_info(cred-
> >group_info);
> +
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(rpcauth_map_to_svc_cred);
> +
> =C2=A0char *
> =C2=A0rpcauth_stringify_acceptor(struct rpc_cred *cred)
> =C2=A0{

--=20
Jeff Layton <jlayton@kernel.org>

