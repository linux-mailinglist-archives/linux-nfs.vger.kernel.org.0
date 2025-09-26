Return-Path: <linux-nfs+bounces-14727-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2988BA2068
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Sep 2025 02:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E37D1BC4289
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Sep 2025 00:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F051388;
	Fri, 26 Sep 2025 00:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="mFiALfgb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nCf3TWm4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3589634;
	Fri, 26 Sep 2025 00:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758845384; cv=none; b=iUPI6dAlWjULjptp0gKp+UJMsPUXROw13meYy2EytC1Z8p6Mr4FHDFqepiyfj1qq0NXW9XRTX1ZsX4JEnj8phB33g3ifzIUZsV9vdVwbdwhlbO5StL6aKK6EPZ19CRI2mieiSUa1xs93tI+XwSAFA879ZjZrSWLPHvmQnJEXSCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758845384; c=relaxed/simple;
	bh=9/8sCI2153nJeyn4IUo6fUwEgJeZDHuCqm1VoJgIXDA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=uIStoHU1Ic8/6PAe5cke/kLyda4J2aE0j1Eq5XKlOm8CLmzzmhFYgmihJ1M8bB73D71mKmAJCf54hiWWwARPRn3/5UNq+2f5PRZrX07AxuViIqlihMfA4JTFdrNlzfi9FM1tWVMZCgbuJbp1d5er/jjbtbGLb7Os/EdO1uh4le4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=mFiALfgb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nCf3TWm4; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE3971400160;
	Thu, 25 Sep 2025 20:09:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 25 Sep 2025 20:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1758845380; x=1758931780; bh=o+VU/S3EXIHtWNj19MpfZBUY/JHX3mo9zyC
	te/hn2e8=; b=mFiALfgby59gEpjWQRTPDu7tJlZ535BooJYDadCWrW4+kYSz4+W
	Acokz36lwMgmA/LstmBvMBcL089l+l6iC8svDEoG+BGqwG7jUu1uL8gkqANOyyUC
	pR0Ck6/r0bO0TXuQq4NAhxe6Tu8HFusYYohcigsct+P6Lj1tDnfyz2VsEfndgMzE
	i4P3yd7UXrQFbvr5dVxatlCOj6RUq5bDo0KuaG1zilAfgGswqBKL3i7MCdZsBC6I
	1tZD4fD3hmJreXfTQI7Hof1Q6f7ik72Dg095NDGxIqqefbte2FE+U98mJ7ZEWx1w
	SaIKTeiAz7x0yNGADIxMBH2kKxulExCCamA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758845380; x=
	1758931780; bh=o+VU/S3EXIHtWNj19MpfZBUY/JHX3mo9zyCte/hn2e8=; b=n
	Cf3TWm4tcOxsYO+IngE8y1YbxO8eXJHV8qNeJYS1M55799wFVC8MnkZc8gCnjDUH
	Z6OlfrSm0jnrmMkhKbLJcvV4lVJrCsz7BOAHH7+jqbBZ9wc34tQ0NfWfYN6jrV8m
	BkDomg4mX1ui9yE2BMitb/ZiPjZ6EI32uioC94uWhJ9/ynT3bwQovpWHzZFiYL91
	CONzXF2tRtGTtwTNCg7j56oXyP7SyVSweu+DvHtDbBXbeLflpaXqe8cxu/A9MGDi
	F/TKBy/2qlk7F4V1B+IVAOcS4M8GfGW/E0P/9eAj8SRmlLRBBn2V/IxYiRxMisOl
	P3LcBKBR4H/zypqKNG7Rw==
X-ME-Sender: <xms:w9nVaGBwEsyGDizkE_Uozuz5zenLdmCuF_42alUKjxesYo_v0dFwOw>
    <xme:w9nVaFfO3FrIH-qjOhmcfRQJFT8n-k-NJ5SKYRq1EBd931D1EFSuJ2rfKRcNiSRWg
    ymZyl6_vq74Ru7ZZw78j2xNY6-PL9ktuQOoe8qBV7nCEfJkle0>
X-ME-Received: <xmr:w9nVaN00Gj0Tr8nSlA5SJlsGtkH9P6feeskU7xhZZzEbk-F3sUmbM7ErLsAbaBBHsGePqRobosV5fLt_0XnfwAtr_Llz2Lk_XCF5TMRN6HBT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijeeklecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:w9nVaEjGBAMrZ0dTb-ciDb_bXdtda5JHNawWP9rr-8d56zaKDz9_9Q>
    <xmx:w9nVaOkYlJZHZn6dzRejwm5rbLU83WlGsESNTdMPLufMyJS3iRgrWg>
    <xmx:w9nVaCbYB6hVkjH1k9DyF1QR-QWaJ8fNBmbQrnaWyM58cVdzRPn8bw>
    <xmx:w9nVaBFlN0J5hyuO6qIoOj6vfJcn35IOU5vac2wKRoLuPzvIbtmflA>
    <xmx:xNnVaC9KI83PBctZbzqPsCJAlipFSVztF-C9F3cX1o7ez4njtshCP4Kt>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 20:09:37 -0400 (EDT)
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
In-reply-to: <20250925162848.11-1-alsp705@gmail.com>
References: <20250925162848.11-1-alsp705@gmail.com>
Date: Fri, 26 Sep 2025 10:09:30 +1000
Message-id: <175884537000.1696783.18278273149263057351@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 26 Sep 2025, Alexandr Sapozhnkiov wrote:
> From: Alexandr Sapozhnikov <alsp705@gmail.com>
>=20
> The value of an arithmetic expression tmp2 * NSEC_PER_USEC=20
> is a subject to overflow because its operands are not cast=20
> to a larger data type before performing arithmetic.
> If tmp2 =3D=3D 17,000,000 then the expression tmp2 * NSEC_PER_USEC
> will overflow because expression is of type u32.
> If tmp2 > 1,000,000 then tv_nsec will give be greater=20
> than 1 second.

You didn't answer my question: why should we be bothered by an over
flow? What harm does it cause?

If we are going to bother detecting an incorrect value, we should
respond to it by returning false.  That would tell the client that the
numbers it provided weren't a valid time.



>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
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
> +		if (tmp2 > 999999)
> +			tmp2 =3D 999999;
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

Why are the two code fragments different?  This isn't an AI writing the
patch is it?

NeilBrown

>  		iap->ia_valid |=3D ATTR_MTIME | ATTR_MTIME_SET;
>  		iap->ia_mtime.tv_sec =3D tmp1;
>  		iap->ia_mtime.tv_nsec =3D tmp2 * NSEC_PER_USEC;
> --=20
> 2.43.0
>=20
>=20
>=20


