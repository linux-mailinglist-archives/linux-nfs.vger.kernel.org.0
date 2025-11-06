Return-Path: <linux-nfs+bounces-16107-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AFAC3895B
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 01:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D681A24566
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 00:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EC8221F06;
	Thu,  6 Nov 2025 00:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="AYdp/zuE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mXCjJ22k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7CC21CC44;
	Thu,  6 Nov 2025 00:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762390553; cv=none; b=hIcBWydy2AemqdcEp3U2HtbeobL4NbxaeBjT6EMJ4GbLVabr+BqFz5DKRGS++vMThrOYKUtc54ceBnMK/d9oRBHGmNDN2k7aGPr9JMOvt08EZAx2fggMKw9MUiqG5ZA9Uw7M9h/f9E8+FDOIJOVsEeBMKpm4M0AYbtUu3Sfar5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762390553; c=relaxed/simple;
	bh=7H7QGaWvft+luniqx0UKd/bXeFRFlhwP/Jl882o/Zbc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=SrYqBOgqw4NvSoiV/hVJjsXZETwaYe5/lXXPltcGqavQYKW5xNDetxVegqvvlMk5V1AxFM0vHsveRNBkkOPTVrT6GKkFVXN+55zTE/B3y/FRDM403AVG0155t+5++RuFODDUYN7Ij7gyVO5DMfvop/TWXhtb/NpxxG2gms5l8l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=AYdp/zuE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mXCjJ22k; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B60AC7A01B8;
	Wed,  5 Nov 2025 19:55:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 05 Nov 2025 19:55:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762390550; x=1762476950; bh=6bwaOUosHeKjBD7IF9WTD2fjiqBFStNKmf8
	+KkU1Rdk=; b=AYdp/zuEdSIxpGxEhvYzTECQjriorRNJh+Sy4gXHFGYQm8y10gR
	LSzy6doeSKART4BdLSqMSQOZ8s2aLbsQnkjFkGCsnvRSqspmaDtXOSMR2V5JcP5O
	kyJBCTHynVqRnsSPRYg6Qx8w05bAHpTsO3YLHj597ifQfLtluoci3DEBZg5OZQGu
	1ABaDiKtL8ucy8sKwZdR/Dog4i5LnAJa+WMxMj+O155Dpf6n08DZfKYWeHYhH2y8
	LtdxPpIZMMboKcUpiH2r37FiAt9xfSwSZ22EJPPN53WHTtyl3pTiUdCT/Qvcvt1s
	lR/bbmv+Nzz/JtwE9rEsi9zI536Ns+msdkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762390550; x=
	1762476950; bh=6bwaOUosHeKjBD7IF9WTD2fjiqBFStNKmf8+KkU1Rdk=; b=m
	XCjJ22kJUH0chM64i4cS5/vOnJsTBqUBQNq6aOhVt02Eo/gOUbWwXJlpBjhWyudg
	+IEp/sN3Bq2jQl6+5/Foeysb3Msbgx9yspn8oWn89H6eGUi5T/2ozOJ2n7eYxROB
	dDwlzqBZf+C13LfvCOXLq3vgA2v/pFRkeV2KrlZRT3hJYO6duDOHc71Z1MBF7YVB
	B53ZiOtFa7oZ0ZsXky3NtNIdenAXEOq4WWSoMHFs7wGOfFnWiQ8+6PHvSDHNvG4l
	6EQ7iWQYtZcTJNSBP/KLeAbdQANsRqNaZWYSeYLLjFK+2+tqBIuVZUtEnS2uYs5w
	otwHiAomEKCmSXTiISIzA==
X-ME-Sender: <xms:FvILaWLVncfdkaMWdk73246nbmHv_psnaAR4Fwvtqd8fS8JDEqiTLQ>
    <xme:FvILaTGczouEstYRRNZOKJB0Kv2FEh1Vhw2t6IHdO_J1gULxOmiiRHI3apnjnZz0_
    xZxAC83pliYcrcb0ohkSIhy2IS2zTM-O08hc78oRcrerJwYow>
X-ME-Received: <xmr:FvILaa-2-CNMz2dNBzre1pRBv_QKfT2lf0EF7ReRZugNUeXLZgKqUDyPanVkd1qIijZwpTFmX2_E1fKNJQr1majN7-DcXfbhiNdEbotgYUqb>
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
X-ME-Proxy: <xmx:FvILabK4_AFB466RbnYVeDiuZmkDo9o5yn3mZSgAt3SRwTUfYhQ0yA>
    <xmx:FvILaQuMqU8dtPLUSk5R8XOiRLNnctF8Smox9s_CPXNECyJj8VG1Ig>
    <xmx:FvILaaBp8lrZEhZxXruy4lKmZKhSDP8IKesN1wRYuPtLOR6Hlq6c4g>
    <xmx:FvILaQPyQhc5QHsBMVdXSVyqSAAkFHatPPD5XO-stuLkGpk5gqmWlA>
    <xmx:FvILabo4z7WKdpBB_GveH2GUXd020-LvXYYTVWubVmRU7J0eItj-bGZM>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 19:55:47 -0500 (EST)
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


