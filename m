Return-Path: <linux-nfs+bounces-14704-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CD2B9E8DE
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Sep 2025 12:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42A642001F
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Sep 2025 10:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B462EA15E;
	Thu, 25 Sep 2025 10:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ulPPfapw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QVB/f0fT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127D92E9ECD;
	Thu, 25 Sep 2025 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758794682; cv=none; b=o/8XGgANvHprAWIhUXqkShbR8+su7+IUiBVQDbf3Y4e4zm1Fbn4lFCn5PUcrtO7yFPzD/eLmXVi1aOrUzKt1KcAfrlUZ3Qqa4sR/ifdq/oU2NxJTUA1nciG7bDhjH2JwroNUjmeH6w8p2PzhCxv27GnKOC00oc+OiPiA2n2epZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758794682; c=relaxed/simple;
	bh=GDPy6tLI6bEpxVDkQBmNqso1NUEL9cwfZb3pOkWJe/w=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=DBVYVjtiOB/vOSaHK+tideUclLnrkd0EZBNG8qwTlhBA/EgwEjzP7n4IRiDXqqFQVW9klfk9bX1Wx+2fOL3EV2AfrioTB633pdEeqc9Iea9lEdKlo4QZhmf0sGwON6BEUauGayJ0uY0i3TYKmOkTX6vcUoFIs7vigPg4+GplhRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ulPPfapw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QVB/f0fT; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id DDB571D001AB;
	Thu, 25 Sep 2025 06:04:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 25 Sep 2025 06:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1758794678; x=1758881078; bh=OoNqSHIfiv5TvI1BH6rd89bwjr3x3HSaZHW
	bibzT0jY=; b=ulPPfapwje2HVcacmxrRfQDDNVNnarffCifSAUsM86mZa/8trim
	7mW0WZnhivvvwU6nfQbBKLdDdslPQAmQ+HaFiG3ikDQvwyN+4LwIll4pYJGSVSV7
	mUc0UBTWLouBTWF75Dvb5yzSKWEaqeyhEYWPiRcnQN79jFDL2hOx3KoC5Q+vwFua
	Q10STFXKJJk617r6JAvvmKHx2dDnD9bw8c+F09+9hnoER1qhJLU/gEIgpW+SrdUG
	L/vpV5A7HUiXz6iiSH90o7gHc4n1myscEImNDPNkWG5fmLn30xkPR19S0lR1+/BC
	Tayk5b+ayC3mleIm4c7Y215bFME6YfX4cRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758794678; x=
	1758881078; bh=OoNqSHIfiv5TvI1BH6rd89bwjr3x3HSaZHWbibzT0jY=; b=Q
	VB/f0fTeWg4v2opfBPCR6pNI6tzFGydbjHYEvG0T33XLWrzKLx7qJhCdQ15ny1FV
	qR1nu0YHX9DAD+DnbT129zb4XSMEwp8XWRMBIlyZBVbEUQUcc3INj1i8LM4bklsN
	eCgv7EY5kV/KeR2XA5+eaDoeLO4ZVjkdFb/zU8yX5hz+t6FrMpdWx5d1oYQhZsxa
	rXv+i0x6mEl3Yzt4oKIP7WGdIBqr2RCvDVRBldoc4rk0/QdoByQaSryR63EIRiWe
	ss6KQQhNDt7/wWaWpl/bkPtZxU0kaCKmml4IBGCnhgjiwPEAJyt+y48GnVhrC8Ms
	OjyRaPmcu3QaE1WUHPZ2w==
X-ME-Sender: <xms:thPVaG-v7B5PX4WjieK1rvltexyfwLtE7u-xwZtUdRPCP8qFKURQYA>
    <xme:thPVaLohRdqbmG3_lsBNiFkJZs9zjT_K82neMj56txw6SLGMWgcCEB1NQkb463aHH
    0VIdikc2mMGTaP0vfQFC1NvD7zv0zuZeti2479sZuSAw631>
X-ME-Received: <xmr:thPVaASotPCVq2V0RbJGUqOTKMGo-puGOBmjzMJK_axsVb9O2xh8RoeYrV60K4OTkenPSuCiZEo4jz0T4AD3HpsHONYzESzY3FQwbOS1JDyp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiiedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtoheptghhuhgtkh
    drlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhr
    rggtlhgvrdgtohhmpdhrtghpthhtohepkhholhhgrgesnhgvthgrphhprdgtohhmpdhrtg
    hpthhtoheplhhvtgdqphhrohhjvggttheslhhinhhugihtvghsthhinhhgrdhorhhgpdhr
    tghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlsh
    hpjedtheesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:thPVaOPXMDnf2DYfhWTlGbTdBdpT26Dbq7srYWbkMcrWjD4X4whvvw>
    <xmx:thPVaOjZDOQrYLrkLeNhMct7dyiW51HQX7WEF5EbnR5G1qXM_t38Ng>
    <xmx:thPVaLke6y7ywYLUmAy7FAnDCyGtF0aU0RJmbWTVLiMSuNRZhgwUYw>
    <xmx:thPVaKiD6GvvU2mOMj4HaZngtE2U7gcNtEKqwuKZbOdnANy0p38vLQ>
    <xmx:thPVaCIGfPpKOsstIpRQIXBsro3q2dVSIwGaC6lWWWyz4htHRkdUIOTV>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 06:04:35 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Alexandr Sapozhnkiov" <alsp705@gmail.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Alexandr Sapozhnikov" <alsp705@gmail.com>,
 lvc-project@linuxtesting.org
Subject:
 Re: [PATCH] nfsd: fix arithmetic expression overflow in decode_saddr()
In-reply-to: <20250925075653.11-1-alsp705@gmail.com>
References: <20250925075653.11-1-alsp705@gmail.com>
Date: Thu, 25 Sep 2025 20:04:31 +1000
Message-id: <175879467124.1696783.15457248781908326257@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 25 Sep 2025, Alexandr Sapozhnkiov wrote:
> From: Alexandr Sapozhnikov <alsp705@gmail.com>
>=20
> The value of an arithmetic expression 'tmp1 * NSEC_PER_USEC'=20
> is a subject to overflow because its operands are not cast=20
> to a larger data type before performing arithmetic
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

Does this matter?  What will break if tv_nsec is greater than
999,999,999 ??

>=20
> Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
> ---
>  fs/nfsd/nfsxdr.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
> index 5777f40c7353..df62ed5099de 100644
> --- a/fs/nfsd/nfsxdr.c
> +++ b/fs/nfsd/nfsxdr.c
> @@ -172,6 +172,8 @@ svcxdr_decode_sattr(struct svc_rqst *rqstp, struct xdr_=
stream *xdr,
>  	tmp1 =3D be32_to_cpup(p++);
>  	tmp2 =3D be32_to_cpup(p++);
>  	if (tmp1 !=3D (u32)-1 && tmp2 !=3D (u32)-1) {
> +		if (tmp2 > 1000000)
> +			tmp2 =3D 1000000;

1000000 isn't a valud value is it?

>  		iap->ia_valid |=3D ATTR_ATIME | ATTR_ATIME_SET;
>  		iap->ia_atime.tv_sec =3D tmp1;
>  		iap->ia_atime.tv_nsec =3D tmp2 * NSEC_PER_USEC;
> @@ -180,6 +182,8 @@ svcxdr_decode_sattr(struct svc_rqst *rqstp, struct xdr_=
stream *xdr,
>  	tmp1 =3D be32_to_cpup(p++);
>  	tmp2 =3D be32_to_cpup(p++);
>  	if (tmp1 !=3D (u32)-1 && tmp2 !=3D (u32)-1) {
> +		if (tmp2 > 1000000)
> +			tmp2 =3D 999999;

This is even more weird.  1000001 will become 999999, but 1000000 will
stay as it is.
Why is it even different?

NeilBrown


>  		iap->ia_valid |=3D ATTR_MTIME | ATTR_MTIME_SET;
>  		iap->ia_mtime.tv_sec =3D tmp1;
>  		iap->ia_mtime.tv_nsec =3D tmp2 * NSEC_PER_USEC;
> --=20
> 2.43.0
>=20
>=20
>=20


