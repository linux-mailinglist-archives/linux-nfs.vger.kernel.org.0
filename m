Return-Path: <linux-nfs+bounces-16235-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7759EC49B8B
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Nov 2025 00:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E9E9E34A660
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Nov 2025 23:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20571235053;
	Mon, 10 Nov 2025 23:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="fseYXR81";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IPt204lt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6119B242D78;
	Mon, 10 Nov 2025 23:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762816710; cv=none; b=emqO4P/hXJbOxmfw0AnPv3q66kbakCSGPe+ZXIQ2piTh7ZNY+80rnxLEbasjNb1TuheVi9sM/DU9s/bqLoyDKzxUmwRAZGcFNO1moUuUl633AF8calWE/LkkRl0H1+zMqTyQtHyMW/yNnlHRk+3xE4LlP0eRHHYcBtQ7aApJDyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762816710; c=relaxed/simple;
	bh=x8wyF9KUZS67p+qkcbiNjLsonDBfnOPM5VU//pUMgXA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=p4s8Q1TKRqutzLSb2JHAiwL/12aIDXheAsEGwvEJ9uL+k+PS3gW6aLVADVgPTR65GW1oiyiTej87FsR1n8SAU5u51qSfdISI9D4dHdvlq3iHpR6SxiH8Y/iSnGSRWesKErOiCdAz8Q/dYej4t0aBF5DoUR+Py7PwR+ZVhOXw/EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=fseYXR81; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IPt204lt; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 62BA47A00F7;
	Mon, 10 Nov 2025 18:18:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 10 Nov 2025 18:18:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762816706; x=1762903106; bh=+HGKJK0puQ4xAOM/cfIuqP/yBP/Srkmb9O7
	8+GprgqI=; b=fseYXR81AQwOUb0dF31tsCxOqOoMBwT7IkTDL3wsa69EN8FgaIQ
	uVDPIpekK5Bxu4/0Bb4sz8anKxANCsDvqWrR0YckQmv5ilEmPLQwQVWk4NEr21WK
	Twmq9iR11OnBi9x2+CqlS1c854ILEECLchp3NZEwliJmDKf9oqK8VpXtasVR44Fk
	ggFdixblgNXO+9cx0kovyN5z5wivYneRUWzKO8hXMG8wiLNOOc1lfIzaKFT3p0Es
	QPJixPEzW9xEL13OE7ugtvD4fqtn1P3CksAwGIaS1mK4hxGXGT1UzAgFFfvf3CxQ
	rxm8Ft8zo7riekI2iisLQGRj+KbYP8rQAMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762816706; x=
	1762903106; bh=+HGKJK0puQ4xAOM/cfIuqP/yBP/Srkmb9O78+GprgqI=; b=I
	Pt204ltT5YqSQvDuaSzaivuZxDbKf281mYVakFWu5bYzSadgIcBNK4VYa0X1e/v5
	Enhcp+U+pxYqVHHp4Y284QnV24GsjP3kKEllBA9KY+/GzQC8wgKyR/W6m3uMzWxa
	FrysD87iYETYH7CU0HPH2O4XWslLJ4OO1tAHLkATvHEkwOlkdFBi4Rsn/8keKIa8
	zf+ypln5RHHP1sUsro8ppf4UwIRFGnVXgosAYvm7O5NCk4O+fdJLv6/xZ7IuQcPq
	OS1Z9zz546Fdcc9H8irBfPEZmKLCgNXf0D4nmuGueooFpFvpzvxPfySHE0GwQJDl
	E4Mg2312xt23SdtTqARIw==
X-ME-Sender: <xms:wXISaeHD9iWnB6qEs-jKNmujhGVLeaM0McFpwlkRIzvaAhxpjbkHlg>
    <xme:wXISaZbsxuHlnequ0FFGE9S-O5kooL3aZJYlKqPF3Zd8wEMEaXkfAwwKeZA_lOvBd
    DChqig1HegFhJUPwah8gHbpESTRCgUWSz-yWyDF_7ejdxMFKBg>
X-ME-Received: <xmr:wXISaYDbY3wemOYqoQmjxC6dIsan-yxgLCroySjJ4RMRCL_xSVqfFfjt_GFZ6kzyiMLybIOPqst4TF0FmQ8qH4NvFB9AePy4VXzFx0MccYUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleelieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdeuteelkeejkeevteetvedtkeegleduieeftdeftefgtddtleejgfelgfevffeinecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgrsghlvg
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhes
    ohhrrggtlhgvrdgtohhmpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurg
    htihhonhdrohhrghdprhgtphhtthhopehsphgvvggutghrrggtkhgvrheshhhothhmrghi
    lhdrtghomhdprhgtphhtthhopegurghvihgurdhlrghighhhthesrggtuhhlrggsrdgtoh
    hm
X-ME-Proxy: <xmx:wXISaZlwIpYYRj276ba6x-avQXre3RTC4VTD3ueF8ra7o3hr2ymcyA>
    <xmx:wXISaRwlbOwSheDt0LvjV4SEPMe4rVEHDqkgptjoEdkoLn2h-hHZlA>
    <xmx:wXISabQSHMbGVBc2HH08oz-zSSDUCi-V7DepyGP2QNMAYBweuNomAg>
    <xmx:wXISaR898BBYUoIDK31yYDRFX5hCvVgxT9eCdY2VxvJ-v3xuVsIbCQ>
    <xmx:wnISaXVwKiJ2UhMhHANmqlw837S0CoKV_JzHWMGreF7aMwWgxJCT-8vq>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 18:18:23 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: stable@vger.kernel.org, "Andrew Morton" <akpm@linux-foundation.org>,
 "David Laight" <David.Laight@ACULAB.COM>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "Linux List Kernel Mailing" <linux-kernel@vger.kernel.org>,
 speedcracker@hotmail.com
Subject: Re: [PATCH stable 6.1.y] nfsd: use __clamp in nfsd4_get_drc_mem()
In-reply-to: <17e85980-9af9-4320-88d1-fa0c9a7220b1@oracle.com>
References: <176272473578.634289.16492611931438112048@noble.neil.brown.name>,
 <17e85980-9af9-4320-88d1-fa0c9a7220b1@oracle.com>
Date: Tue, 11 Nov 2025 10:18:19 +1100
Message-id: <176281669984.634289.12369219545843965992@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 10 Nov 2025, Chuck Lever wrote:
> Hi Neil -
>=20
> On 11/9/25 4:45 PM, NeilBrown wrote:
> >=20
> > From: NeilBrown <neil@brown.name>
> >=20
> > A recent change to clamp_t() in 6.1.y caused fs/nfsd/nfs4state.c to fail
> > to compile with gcc-9.
>=20
> I have a comment on merge process:
>=20
> Reported on 6.1.y, but might be present in other LTS releases, since
> 2030ca560c5f exists in every LTS kernel since v5.4.y.

I thought this might be likely but I didn't have enough motivation to check.

>=20
> At least, my understanding of the stable rules is that they prefer this
> kind of patch be applied to all relevant LTS kernels. I strongly prefer
> that NFSD experts review and test this change /before/ it is merged,
> since nfsd4_get_drc_mem() is part of the NFSv4.1 session slot
> implementation, and since in this case we don't get the benefit of
> /any/ soak time in linux-next or an upstream -rc release.

The patch is deliberately written to transparent without requiring any
(export or otherwise) understand of the NFS or even of the code being
changed.
It purely removes the BUILD_BUG_ON().

>=20
> So IMHO this patch needs to target v6.12.y, not v6.1.y, and it should be
> marked

Can I leave the process management to you.
Though as you say later, the same patch should apply equally to both.

>=20
> Fixes: 2030ca560c5f ("nfsd: degraded slot-count more gracefully as
> allocation nears exhaustion.")

There is no evidence that patch is broken so it is hard to justify
saying that we fixed it.  But I honestly don't care.

>=20
> (Since the patched code hasn't changed in many years, I think the final
> patch ought to apply cleanly to both 6.12.y and 6.1.y).
>=20
> I need to take the fix into nfsd-6.12.y and run NFSD CI against it, then
> it can be sent along to stable@, and they will put it back into the
> older LTS kernels for us.
>=20
>=20
> > The code was written with the assumption that when "max < min",
> >    clamp(val, min, max)
> > would return max.  This assumption is not documented as an API promise
> > and the change cause a compile failure if it could be statically
> > determined that "max < min".
> >=20
> > The relevant code was no longer present upstream when the clamp() change
> > landed there, so there is no upstream change to backport.
> >=20
> > As there is no clear case that the code is functioning incorrectly, the
> > patch aims to restore the behaviour to exactly that before the clamp
> > change, and to match what compilers other than gcc-9 produce.
>=20
> > clamp_t(type,v,min,max) is replaced with
> >   __clamp((type)v, (type)min, (type)max)
> >=20
> > Some of those type casts are unnecessary but they are included to make
> > the code obviously correct.
> > (__clamp() is the same as clamp(), but without the static API usage
> > test).
> >=20
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220745#c0
> > Fixes: 1519fbc8832b ("minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi te=
st in clamp()")
>=20
> Stable-dep-of: 1519fbc8832b ("minmax.h: use BUILD_BUG_ON_MSG() for the
> lo < hi test in clamp()")
>=20

I haven't come across Stable-dep-of before.  I can't find it in
Documentation.  Looking at some examples I guess it makes sense.
Except that Stable-dep-of normally comes before, and Fixes normally
comes after the target...

Thanks,
NeilBrown


> might be more appropriate.
>=20
>=20
> > Signed-off-by: NeilBrown <neil@brown.name>
>=20
> --=20
> Chuck Lever
>=20


