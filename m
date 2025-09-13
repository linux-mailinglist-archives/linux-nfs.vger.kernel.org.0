Return-Path: <linux-nfs+bounces-14405-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B038B55E95
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Sep 2025 07:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360935849E1
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Sep 2025 05:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AE53A1C9;
	Sat, 13 Sep 2025 05:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="VeEehRr8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q12k/Tg+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C4A23CB
	for <linux-nfs@vger.kernel.org>; Sat, 13 Sep 2025 05:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757741831; cv=none; b=CCwqPfJ70I2aUCduVPnRTA20xF2OpF61l7Q3WD88qP2oLIlaDDS0dbDuslrZOp0RTZJX/a2sAD3EfhFPwCG6GERjBFPLCc3UpUgBlZyQaQkz6e/0QxlgRo34hJmuvEvssO8IpgLlexpSNGyiV9Na64pSIuwfiDZcYlclUxMQeLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757741831; c=relaxed/simple;
	bh=mvhNA5WEkpxKfZDKwrSKpUFXnnptRHXe6x9132kQdnY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Jblc//h1kVT/bk0+q21Wc7u21CAXso1pNFw/WKTz8Lo3JHp4216KzCXancpT8ChK4S29e/Sbj4AhN3XsDPh85rN1napXnCxuFG6DLxEVuW0zcofqfzj1b7pb+7XJQU0WhcsDT9GccY2IRQduBxOLXqPAe/q9gpI1B2yUSDRZYQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=VeEehRr8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q12k/Tg+; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0D6C27A020A;
	Sat, 13 Sep 2025 01:37:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sat, 13 Sep 2025 01:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1757741826; x=1757828226; bh=HaMzj3iPkOJ+OQdn87eb7wM8Mk++JN0XdAb
	J182crMA=; b=VeEehRr8EnxdIXrmMGMsSP6yK4kWU5FLhZl0G1+DgQtT/fyNDaT
	+m7Q1KDjJJKFMqqqv7oBwDWwnJg+Ahu4q3mjf32RThGvjnu1NWpPLhfqbE+JA08L
	BfDDNcPi1x+Q8/LVVKzUmQxG1Eyhql1l4+zgqDY0Lt2wWmy7780SSLtnB/jA3Uij
	8ZNcVFhP1qG5kndMhJwTAKbIDCrc6vVzww85nAMRII2Qrp+hIRVtKxfDqH8bJxqu
	85bs3XV3uS3c1JbRVPhTJK/t7LrF9t1twIz7NN9Qw2Z9u0osgyzORw+RHFxMg6wH
	ntKMtN2JrM7Ce/YVu+OuXvwb8/O2Y7aCYWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757741826; x=
	1757828226; bh=HaMzj3iPkOJ+OQdn87eb7wM8Mk++JN0XdAbJ182crMA=; b=Q
	12k/Tg+fOd5yFdR9MowgTi3a1Q8Wkv59HNJS+Ndbxzmsew42V9hplfgPoL0UhsZJ
	gNDsXRFjSlNRDQsTymgIg3Bc9MgzsNp7ecninKO6HOyCEpNGe/JVvdhGAjZgTXrX
	i04PsJAI7GxvP8gsYwrWJ6BAVv/P0jkTyH2Jg/OwkxKejVhh8q9HJ/z+vAL3+8Vb
	PSu0h1eteLoTna54FUpSrouovPu0+UomCjwHVIz8loN00ONgCDSQsARp40XtRj8M
	ahOoMKac1EhbaqmDyHDP7uYc1ymT4XxAtXfGDSU87czmlFqx1z9k6MOvBj70NG57
	mAo8pNKhVII+anr5RAlqA==
X-ME-Sender: <xms:AgPFaBiSgNdOVPPrDsy-iO8hcc4v7ak1GEarne3tFSoPdZb6fhHG7A>
    <xme:AgPFaDmgY653gErELr4fXGFKRHXO-dGJfoxPrTu0XdJKCjIRxFAmnf5QH_EztGlhh
    11QvPsyXjpIig>
X-ME-Received: <xmr:AgPFaHjcmXMKMWBgVqCAqUJPBpCjfiv--KQ4ARufaOcr2-fbxzYNBkyxd1aOg0zibzCQOyjjn1TMHC4KlPmK8cRAJvDJWDiIabOcawr3TLfh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhi
    vghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvg
    drtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvg
    hlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:AgPFaH2D6woiok7Wp6bBMXZu2bieO1HEUnUyH34fMx-0AH6OmZj6yA>
    <xmx:AgPFaAKq8i2pESYlXQc-Cb5N0-32eVc9dFQ_MVGYI44eaRqwGDpRDg>
    <xmx:AgPFaHyKwn7TCvsK_TtWLTj1Hu5AO8tc0QSavQM_naMWu62QWbpgPg>
    <xmx:AgPFaOVZ-YGRH07fSM9aLyBJgK6D2NUUVlHd72foIILpWsxqwVohRg>
    <xmx:AgPFaFGBDyLAkRwCo4N45RNAOo3pUYHEdCKKfahJyB5UeRKSYWphvjO3>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Sep 2025 01:37:04 -0400 (EDT)
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
 "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH] NFSD: Remove WARN_ON_ONCE in nfsd_iter_read()
In-reply-to: <20250911201858.1630-1-cel@kernel.org>
References: <20250911201858.1630-1-cel@kernel.org>
Date: Sat, 13 Sep 2025 15:37:02 +1000
Message-id: <175774182203.1696783.2451676793107977604@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 12 Sep 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> The *count parameter does not appear to be explicitly restricted
> to being smaller than rsize, so it might be possible to overrun
> the rq_bvec array.
>=20
> Rather than overrunning the array (damage done!) and then WARNING
> once, let's harden the loop so that it terminates before the end of
> rq_bvec. This should result in a short read, which is OK (clients
> recover by sending additional READ requests for the remaining unread
> bytes).
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/vfs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> There might be a similar issue with rq_next_page in this loop?
>=20
> Suppose that nfsd4_encode_readv() encounters a second READ operation
> in a COMPOUND, and the two READ operations together comprise more
> than "rsize" total bytes of payload. Each rq_bvec is under the page
> limit, but the total number of pages consumed from rq_pages might
> exceed rq_maxpages.
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 714777c221ed..e2f0fe3f82c0 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1120,13 +1120,13 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
>  		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++),
>  			      len, base);
>  		total -=3D len;
> -		++v;
>  		base =3D 0;
> +		if (++v >=3D rqstp->rq_maxpages)
> +			break;

I would have changed the head of the while loop to be

  while (total > 0 && rqstp->rq_next_page < ....)

and then realised that I don't know what to put there.
I don't think that counting up to rq_maxpages is safe when there could
be two READ ops in an NFSv4 Compound.

And if we are cleaning up this function I woul put the increments of v
and rq_next_page next to each other..
</bikeshed>

The patch is an improvement.  I wonder if it is enough.

Thanks,
NeilBrown



>  	}
> -	WARN_ON_ONCE(v > rqstp->rq_maxpages);
> =20
> -	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
> -	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
> +	trace_nfsd_read_vector(rqstp, fhp, offset, *count - total);
> +	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count - total);
>  	host_err =3D vfs_iocb_iter_read(file, &kiocb, &iter);
>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
>  }
> --=20
> 2.50.0
>=20
>=20


