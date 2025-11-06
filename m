Return-Path: <linux-nfs+bounces-16108-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3AAC3896A
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 01:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABA5D4FA077
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 00:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E191E7C12;
	Thu,  6 Nov 2025 00:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="V8XSo45f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="llHBkm6W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13AE22128D;
	Thu,  6 Nov 2025 00:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762390554; cv=none; b=shLQhDrhR6/9Qcgxpe9V/SAFqvKlRvjF25v3pgBoijIsAzXwmCXiNAkqECuDm+wsBw0EICTax8xg3EQg7PqMBo1g+PKnB6gTMClbS67rFETTPd46JMStarV+EpKXVVp7ijAy5cUpkqdPDnXc0KJzm8GysibQPzMmI/1pZdu1+Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762390554; c=relaxed/simple;
	bh=7H7QGaWvft+luniqx0UKd/bXeFRFlhwP/Jl882o/Zbc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=HTbqo0C2EZbZrnTZhbqEU4sLMzsnc/oVu3L2f/IhN9OM4Eh+fIGKIO1B8OY8gRU7ns7tscYk8ZnrhZifqqTCQrR96KsBPeXvXiRfX1RNIz9XxmB4wC32C17ptIidWEXmTJ1/pegBXmSVR77An6HanZStJPh/lYZ+OJnz3qnbmNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=V8XSo45f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=llHBkm6W; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 66FD61D0023F;
	Wed,  5 Nov 2025 19:55:51 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 05 Nov 2025 19:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762390551; x=1762476951; bh=6bwaOUosHeKjBD7IF9WTD2fjiqBFStNKmf8
	+KkU1Rdk=; b=V8XSo45fjmR8y1WxXE/4yQ+U1dnC79xAlu8z6UwvNAE7/o8llTe
	iC3KIU2BdKWgK6y04CTdqzodKg0lwpa2WYmaFP3I7oiIXJMZwYhKwGmxcNHxOA/o
	Jb4HESS8Ws+fYYhz9M/Z2TCLhXQZbRm1TRL5/4gY/Ui9KziH7e0gmlW6C7az2mny
	E7Qcw8UiJa6L0qRfSRqdJGLwd3fti7Hc9EpLpGJG+7L9PdmQoWix0usQf625qtBX
	xx1/CqrkwjbkOP/VHNyiR34iFg7JWizZhQmxZwEcRH7ZzkEczmruBCpXGuE0XMvV
	CrdiwBH7/+Jwsah77991nwUvp0FY7SWIlyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762390551; x=
	1762476951; bh=6bwaOUosHeKjBD7IF9WTD2fjiqBFStNKmf8+KkU1Rdk=; b=l
	lHBkm6WjqrTxyPsSLDK33bkp+m2XgwyOGo1uJnZ9sM1sY5n3jM7BHqlCSqVLEOOO
	qG0sU1hogW69gIErgNLJ218v9xcs1SKGhPZ/ndW+ck7GRw2bYXmmLsCuTXXDwUOf
	okJ+gu5VG7Aan6deVDESc7a2uVmwXiedpMNBdI5whfRV3OEFaRawBWEkCTVlfy3g
	sm2ECzvOhBDfVtsJscOtNyVKGUFCUYMxxP/0yC7XmXsy+av1jP6LUcTunRURNCQA
	CaQlTHxdmvdVV+VZJipBYjn1NN2yu/WhA9ujEGBK051EWEqqjmHPyd6/kfj+HnUd
	hhCmEkEJek0f9Lm7AXClA==
X-ME-Sender: <xms:FvILaS5Zz-0OGRvSQduc3Dw9pNEcqZcu0EZWaIzryybktgHwQbAuyA>
    <xme:FvILaQ0CXbPpZAd_R3wpgPB-mU-ttKelwuVVJkaMb6yeDDdtunBNV_9yM63GOrViu
    KsIr0YkDwBoOnWVfuSFCNh9P_M3lE_EZ87SHuzi6z8HAMg>
X-ME-Received: <xmr:FvILaVu97Zn99vUiY9Si6tFLi3Egfhv8hBB65WPDB0TZ4-8EkYLoPxRcMwE75ng4de5yobv7m4rm79S04R_du_mM-kjPtt5av2jALJJb2DI4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeehgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdeuteelkeejkeevteetvedtkeegleduieeftdeftefgtddtleejgfelgfevffeinecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgrsghlvg
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhomhesthgrlhhpvgihrdgtoh
    hmpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthho
    pegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopegthhhutghkrdhlvg
    hvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehsnhhithiivghrsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegtvghlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:F_ILae4X360JJFlXLLI0n8Ee99DmrqTnnkFv8Yrw9M94CuXo5zThBw>
    <xmx:F_ILaZcA7LObX-denqxhR1KhvRahTzO0mmo1AV8f6RugvhN1EI3Oyg>
    <xmx:F_ILaTzRA5nOKW1k2ZB-Om4daIMoWltuQcerJtFfA0uTCtpe8gMYEw>
    <xmx:F_ILaW83kvP42aNYDl-QqfypWxkRHr41VLiKeplVDEcf8_bfw6l-nA>
    <xmx:F_ILafZ67lMd3jJWPRHmJsuyZdDfit_euU-p-gTDnNR_aAHQCLSxo-oc>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 19:55:48 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>, "Mike Snitzer" <snitzer@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH v10 2/5] NFSD: Make FILE_SYNC WRITEs comply with spec
In-reply-to: <20251105192806.77093-3-cel@kernel.org>
References: <20251105192806.77093-1-cel@kernel.org>,
 <20251105192806.77093-3-cel@kernel.org>
Date: Thu, 06 Nov 2025 11:55:45 +1100
Message-id: <176239054580.634289.78476170437073732@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 06 Nov 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Mike noted that when NFSD responds to an NFS_FILE_SYNC WRITE, it
> does not also persist file time stamps. To wit, Section 18.32.3
> of RFC 8881 mandates:
>=20
> > The client specifies with the stable parameter the method of how
> > the data is to be processed by the server. If stable is
> > FILE_SYNC4, the server MUST commit the data written plus all file
> > system metadata to stable storage before returning results. This
> > corresponds to the NFSv2 protocol semantics. Any other behavior
> > constitutes a protocol violation. If stable is DATA_SYNC4, then
> > the server MUST commit all of the data to stable storage and
> > enough of the metadata to retrieve the data before returning.
>=20
> Commit 3f3503adb332 ("NFSD: Use vfs_iocb_iter_write()") replaced:
>=20
> -		flags |=3D RWF_SYNC;
>=20
> with:
>=20
> +		kiocb.ki_flags |=3D IOCB_DSYNC;
>=20
> which appears to be correct given:
>=20
> 	if (flags & RWF_SYNC)
> 		kiocb_flags |=3D IOCB_DSYNC;
>=20
> in kiocb_set_rw_flags(). However the author of that commit did not

"the author and reviewers of that commit"

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown


> appreciate that the previous line in kiocb_set_rw_flags() results
> in IOCB_SYNC also being set:
>=20
> 	kiocb_flags |=3D (__force int) (flags & RWF_SUPPORTED);
>=20
> RWF_SUPPORTED contains RWF_SYNC, and RWF_SYNC is the same bit as
> IOCB_SYNC. Reviewers at the time did not catch the omission.
>=20
> Reported-by: Mike Snitzer <snitzer@kernel.org>
> Closes: https://lore.kernel.org/linux-nfs/20251018005431.3403-1-cel@kernel.=
org/T/#t
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Fixes: 3f3503adb332 ("NFSD: Use vfs_iocb_iter_write()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/vfs.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index f537a7b4ee01..5333d49910d9 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1314,8 +1314,18 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh=
 *fhp,
>  		stable =3D NFS_UNSTABLE;
>  	init_sync_kiocb(&kiocb, file);
>  	kiocb.ki_pos =3D offset;
> -	if (stable && !fhp->fh_use_wgather)
> -		kiocb.ki_flags |=3D IOCB_DSYNC;
> +	if (likely(!fhp->fh_use_wgather)) {
> +		switch (stable) {
> +		case NFS_FILE_SYNC:
> +			/* persist data and timestamps */
> +			kiocb.ki_flags |=3D IOCB_DSYNC | IOCB_SYNC;
> +			break;
> +		case NFS_DATA_SYNC:
> +			/* persist data only */
> +			kiocb.ki_flags |=3D IOCB_DSYNC;
> +			break;
> +		}
> +	}
> =20
>  	nvecs =3D xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
>  	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> --=20
> 2.51.0
>=20
>=20


