Return-Path: <linux-nfs+bounces-16771-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 614DDC90759
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Nov 2025 01:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29B9B4E045B
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Nov 2025 00:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FCC192B90;
	Fri, 28 Nov 2025 00:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Qe4OyHPY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o9325mao"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F9A20B22
	for <linux-nfs@vger.kernel.org>; Fri, 28 Nov 2025 00:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764291336; cv=none; b=Pi5klyyjKJBjuQZRg2HIBFrxbIPR4HtVs+PjwAxE13q7JuXhMJAGA1K8oK9SiH0Z4ZKL8+3x1HUriR8pOkETXcvME8EQ+Z2lB8Jk/CGCIBW5BjgITIxkVTL86Wx7q8KN026EuOYjeQAkmhD5Kbyq6pcgcQNdSv69TUL6jpQgtmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764291336; c=relaxed/simple;
	bh=duG4jzxPXs4UXsc6y88ySAO8OnVTcu7zi+i5Mxyn9BE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=b5v7HC2jiDRxY3CKvmMticKiIcElCQNmSoIA2d6dI6PfSjWXp+difYI5bgqsfJgbHwh/NLCvP2kqAUbZ66nR45KvbMnZgTyT/KnF5ioXhMxYLo8NLPT5+/8Sjv5hUjPmd9pS66TJleX9S4fWzUEyu8rESQfC4BFsuK2ysZaTzwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Qe4OyHPY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o9325mao; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id DBAF41D0064F;
	Thu, 27 Nov 2025 19:55:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 27 Nov 2025 19:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1764291333; x=1764377733; bh=UxdlRv09jWxaXk+G081oo5Au5N32DXVKkS+
	6OmxO+kM=; b=Qe4OyHPY9Tsa/j2/0QOqxm+YEhaf0X9UoUxwWoUdE3J+YEy4VBL
	5N3R/gpQISBpboNDslaJwCJOf5wweaP2Q40fLpjviI8gBv7IMbqvviU38Ug4Gg9S
	KUkjAI7S4Ec7rN8Qw4a4UC4o4YcW8hY+1cEqa8oHPfz4Xu0FJMmz5nbifSz3w3fx
	tbT6Z6C419WlMMDfDegw4o/VSUCs6c43HQQmO6e/umy8y/nSP/uXAfzSUreg8nGn
	q1ydh7iUGbejIfSMpBGnu60VPJqgsR6tESS141DreU+wzysgAe9eTGqsZ0yoJhMJ
	hNh25/3fexZ49ibjgEyK7fpKZJtJBptBliQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764291333; x=
	1764377733; bh=UxdlRv09jWxaXk+G081oo5Au5N32DXVKkS+6OmxO+kM=; b=o
	9325maoAed23Iq+OSJvLv8xnwhZWorKZ2ro4KCy/061V+h8i9G/ev4BLQI9+lHQr
	LfRv80QQnXqd/t/wXZ7ZPalq0yariHW9F8JunKjHEZR3DYjFX/0XgOEdzTxblakx
	seT/drG2f2cf+59wwNeVbBP051E1ISatm+WnX/yvCB0tD6QOnX/FexRBNflTBSIK
	Tf6UeHivqWCDXmPF5e/gH3ZIK6KFSYPB5OymcuaFoTSEqzLXG2U3nmEaUsvVm5Pi
	bj7E/E8b+dn61uQuMvNH61WXdoHVq1dm3Mrnv++ZGH7L0jPHyO4tAoXTk7RJGNrF
	4Sa4rITqNOdX4UUzfHfkg==
X-ME-Sender: <xms:BfMoaRUeBcIFXj82qc_5U_yYGxBDNQLzotbN-0hWikZr4EctQ7WGYQ>
    <xme:BfMoaYltv4k2fPP1EuzNDDYN-5VvBYNgrdOXk67FfbPr_DeU6QFKNfSSPS1hLzkii
    3yPfZtxSQtMOBB6wwu93bomLo3maXoCCDIUbK-3J19cMfy0x-g>
X-ME-Received: <xmr:BfMoaSbHINmZQJlYnllMp6GpOpbGDNF9T3Jx975ETlSkh96ueWh3Y_KP2HvOSwEUQDCrHydqQUDM8ocmAO4GL_jcFFTDeRgW2cf9_R8iv3xH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeekiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegrihhlihhophesshhushgvrdgtohhmpdhrtghpthhtoheptghhuhgt
    khdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepjhhlrgihthhonheskh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BfMoaTP9CEoML-MmeEWhe0t-kSo1CMAeIo_zSJhnALM7ENxjNuDRAQ>
    <xmx:BfMoaXbWlOshn11zitIcJF36xvLBjsQlzhSgvBsoGeH0VFfnD66SjA>
    <xmx:BfMoaR2ia14cuV6PEkR1jS4dVIYvoGh4P9p8y661agKp9FPn15IFdQ>
    <xmx:BfMoadcnIQhvTpVo8uVEFj_-mCRrMrXzUTEfHfK4s8nMmr3Ljucusw>
    <xmx:BfMoaStWQ_WjvP9mywSFPAA0hWMf_GfLdj2aDQemzb6YaDIdUHKe_YHB>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Nov 2025 19:55:31 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Anthony Iliopoulos" <ailiop@suse.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] nfsd: never defer requests during idmap lookup
In-reply-to: <20251127175753.134132-2-ailiop@suse.com>
References: <20251127175753.134132-1-ailiop@suse.com>,
 <20251127175753.134132-2-ailiop@suse.com>
Date: Fri, 28 Nov 2025 11:55:30 +1100
Message-id: <176429133008.634289.1589243643340647452@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 28 Nov 2025, Anthony Iliopoulos wrote:
> During v4 request compound arg decoding, some ops (e.g. SETATTR) can
> trigger idmap lookup upcalls. When those upcall responses get delayed
> beyond the allowed time limit, cache_check() will mark the request for
> deferral and cause it to be dropped.
>=20
> This prevents nfs4svc_encode_compoundres from being executed, and thus the
> session slot flag NFSD4_SLOT_INUSE never gets cleared. Subsequent client
> requests will fail with NFSERR_JUKEBOX, given that the slot will be marked
> as in-use, making the SEQUENCE op fail.
>=20
> Fix this by making sure that the RQ_USEDEFERRAL flag is always clear during
> nfs4svc_decode_compoundargs(), since no v4 request should ever be deferred.
>=20
> Fixes: 2f425878b6a7 ("nfsd: don't use the deferral service, return NFS4ERR_=
DELAY")
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> ---
>  fs/nfsd/nfs4xdr.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 6040a6145dad..0a1a46b750ef 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -5989,6 +5989,7 @@ bool
>  nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
>  {
>  	struct nfsd4_compoundargs *args =3D rqstp->rq_argp;
> +	bool ret =3D false;

This initialisation is unnecessary.  Just

        bool ret;

please.

> =20
>  	/* svcxdr_tmp_alloc */
>  	args->to_free =3D NULL;
> @@ -5997,7 +5998,11 @@ nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, =
struct xdr_stream *xdr)
>  	args->ops =3D args->iops;
>  	args->rqstp =3D rqstp;
> =20
> -	return nfsd4_decode_compound(args);
> +	clear_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
> +	ret =3D nfsd4_decode_compound(args);
> +	set_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
> +
> +	return ret;
>  }

nfs4svc_encode_compoundres doesn't need this because the encoding
actually happens from nfsd4_proc_compound on an op-by-op basis.
So only decode_compoundargs and proc_compound need to clear RQ_USEDEFERRAL.
proc_compound already does, this patch handles decode_compoundargs.

Reviewed-By: NeilBrown <neil@brown.name>

Thanks,
NeilBrown

