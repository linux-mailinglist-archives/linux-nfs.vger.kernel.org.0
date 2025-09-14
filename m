Return-Path: <linux-nfs+bounces-14407-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1B4B5640A
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Sep 2025 02:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E05217A5DF4
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Sep 2025 00:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED491E4AE;
	Sun, 14 Sep 2025 00:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="tbxngpC+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q+r6yG/H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B40B28E5
	for <linux-nfs@vger.kernel.org>; Sun, 14 Sep 2025 00:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757810055; cv=none; b=MB3Gyb/VhlnNmtA3DyJ1wqHecJrvUidtEsGrvTJeQJTX7+RYs5tqO2DJ19+Irmg+QR4r8xRZwqjRGFkpBSZf4DZeDs0KYYlesxdS5YXM4S9uRuK/rzdEmSh4sZzQUGDXKWpwqxy2XXtgSiPXhRKna9PzQHMnTCzHEip8WbHGRz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757810055; c=relaxed/simple;
	bh=2fODHkAFIkzu2EJc87LyiXCf/d3lEcIfGQX1nh0vhw8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=PbAmjrjAhS2+aTEqIFjopMxL9HR+kZDiCec5k4CCGICpVrlmg31o6+VFNe4jTKCF7s5R/AHRO+ajIZax97qmXTvec3le4OUZc8EuPU4D8HL71ad+bHtWGDqCsD4XJcBzT93eJ7S2tkB5Wbri093GsVxiMwpaD02TKFNa6RlGs44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=tbxngpC+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q+r6yG/H; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 379EB140006F;
	Sat, 13 Sep 2025 20:34:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 13 Sep 2025 20:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1757810051; x=1757896451; bh=ZlQmmvzlVshtNIbTqftOzxhVPq/vSzQ5xqQ
	a3AljipY=; b=tbxngpC+gGdKAEP++6TgB5nLOHGqw8tGaxyyZ6RL+Va5U+TmcZq
	wBfw1Y50mD7z1qZfARMKRgzDogjMIdB/C7wvs20jrvB/SapULqhsntqydTCN6DNZ
	rtPy/dbBbPYejlTiAfgv6k7VcZTeBzjeUl+FNHs45sLriOOzp1j8qxQNDJ2KWO4z
	eOHOKvThI/J0rFNJRE0DPNQlkJYqbQcVov5T8vHrq+7xSAX7ztTrmNdc3uqPSx51
	Upgw+5iORFPijZddR2Rgdq8bVORjVjH7hwI+yJziu13T3HgWYS7+ejhLje+/hwzG
	DHN/v8t3tmaVPmjyfPkTF0bBWnrb9XYkYrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757810051; x=
	1757896451; bh=ZlQmmvzlVshtNIbTqftOzxhVPq/vSzQ5xqQa3AljipY=; b=Q
	+r6yG/HVK16dqnUBnmSRbSJGFtBM55/HcKp9awOqDYMcP6TpjQL21SJrTtWHlXni
	vLwN1D3r2Cjsu0xQ62heky5iXqKi4Lgr7fLkYExItMlW0yiHRn9jw0v58U4vlykn
	oyPXDpAsllXh5X0XMW+1PqDmaPzz1tHrxQ6hJmzT2WUd9YW7t4GBqSNWO90FXiH6
	eq3ZV/bDho4yYzuX1aejJtD48zF1bTQ9xsm9+KsckkGEJwwEyYW0ny1TCOa9DJ6Z
	eiDALIyhTw2POwSCv8WLudhp9UrGpHxsaGevoA++MtigkV9C3r/FxCFggChmO+dA
	U/Vr1FXKpREtY+yLnFm3Q==
X-ME-Sender: <xms:gg3GaBO5iX3ZUxfBlr18igYnW7QEcUZRRbFbgDEXmr7AbdnhSxuyiQ>
    <xme:gg3GaBi7sjLUqOzWBW-9g0W8lW4mwrTxruiKZiPYxe0qjQOoLooBneJTincEkq8HE
    IGhp13NHeoqDg>
X-ME-Received: <xmr:gg3GaGunAANfcw48qvdJUZku0rc8vnXGRHu_HYgFld-Cz6UNjj3Hr39W7O_FeSzhBzwqgQmTtuh3jA88-kaw4_LB1zQhbvRrDSC9IMTlS8lG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeffeefkecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:gg3GaPQ-CkYfHdHt5WLkmZMMvgeuVG7gvMEUXj7NtOMsliJQxc07Yg>
    <xmx:gg3GaK1lKfru2gIf5KfDYz7HLfpsxEMLZKB1kq2FG4WJKmerG4U86g>
    <xmx:gg3GaEsUUOoPkqRJoiBi2f5iKJog0zRIWRis5TQT9CEP_twOaYBC9A>
    <xmx:gg3GaAgB4QMcxYH49YKMfKxA_kKuepFnEyJmk5pfqUShfAMELcGXAw>
    <xmx:gw3GaPBI-jFDombdqnYEgBJrLKPQitAxlboEq22kUA-hC773_xASf1Ih>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Sep 2025 20:34:08 -0400 (EDT)
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
In-reply-to: <49025423-30cc-4ac7-a37c-2767321e5982@kernel.org>
References: <20250911201858.1630-1-cel@kernel.org>,
 <175774182203.1696783.2451676793107977604@noble.neil.brown.name>,
 <49025423-30cc-4ac7-a37c-2767321e5982@kernel.org>
Date: Sun, 14 Sep 2025 10:34:07 +1000
Message-id: <175781004711.1696783.16528610177949029317@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 14 Sep 2025, Chuck Lever wrote:
> On 9/13/25 1:37 AM, NeilBrown wrote:
> >> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> >> index 714777c221ed..e2f0fe3f82c0 100644
> >> --- a/fs/nfsd/vfs.c
> >> +++ b/fs/nfsd/vfs.c
> >> @@ -1120,13 +1120,13 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, st=
ruct svc_fh *fhp,
> >>  		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++),
> >>  			      len, base);
> >>  		total -=3D len;
> >> -		++v;
> >>  		base =3D 0;
> >> +		if (++v >=3D rqstp->rq_maxpages)
> >> +			break;
> > I would have changed the head of the while loop to be
> >=20
> >   while (total > 0 && rqstp->rq_next_page < ....)
> >=20
> > and then realised that I don't know what to put there.
> > I don't think that counting up to rq_maxpages is safe when there could
> > be two READ ops in an NFSv4 Compound.
> >=20
> > And if we are cleaning up this function I woul put the increments of v
> > and rq_next_page next to each other..
> > </bikeshed>
> >=20
> > The patch is an improvement.  I wonder if it is enough.
>=20
> I'm planning a second patch that adds protection against overrunning
> the rq_pages array. Is there anything else you feel is needed?

It might be easier to review the two patches together, but if we decide
that we aren't worrying about multiple users of the page list I would
rather the code looked like:

	while (total > 0 && v < rqstp->rq_maxpages) {
		len =3D min_t(size_t, total, PAGE_SIZE - base);
		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page),
			      len, base);
		total -=3D len;
		v +=3D 1;
		rqstp->rq_nextpage +=3D 1
		base =3D 0;
	}

So all the tests are together, all the increments are together.
I don't mind if you keep "++" but as I personally don't much like it
I changed it here.
A possible alternative would be

		bvec_set_page(&rqstp->rq_bvec[v++], *(rqstp->rq_next_page++),
			      len, base);

then again all the increments would be together - I don't mind ++
in this context, I just don't much like it stand-alone.

But if you disagree, leave it as it is.  Probably the part I like the
least is the "break" and the end of the while().  Having multiple exits
from a loop is sometimes needed, but should be avoided when not needed.

Thanks,
NeilBrown

