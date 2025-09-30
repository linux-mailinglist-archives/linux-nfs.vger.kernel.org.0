Return-Path: <linux-nfs+bounces-14797-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF492BAB7FE
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 07:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177B1188A9CF
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 05:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61402276046;
	Tue, 30 Sep 2025 05:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="VFjlTJ0s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cbYCapAB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857D5275B04
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 05:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759210372; cv=none; b=WRTMN/dwM0g+estY6dIkaHiqZGdDfTybzT7nXdIiWJO0MoosNoB5ft6enIPYDIOI3OSDrazQfc0xjq5yR3RDaBzGkKfape9mSttE7RBDBrB29xpLBk8t9Iy14OMvsJAPfutb37SOSOYfKw33qHLY9Ph2uNx75ns1rYBAPZft1Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759210372; c=relaxed/simple;
	bh=Ky2JJ8biyyK9xbq96MVNSSMZhMmRL6C2D/r72NY9Fuc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=iGIQSuj39wdDqWcWM9ac2oeqGEy/8wGoQ09MxrCD97aw8C09Cp8YD52ujXvxOaYy33e1IkJpbK5aNWsZFRku7pehr//qIwqrVETDt6OgcjfrFr88G+kxD9UTXCMyVu8Edv/JmVrtMsGaNv+TTGxYKWpEos2olSu1bzyLNRiViZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=VFjlTJ0s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cbYCapAB; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id AD3E5EC0185;
	Tue, 30 Sep 2025 01:32:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 30 Sep 2025 01:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1759210368; x=1759296768; bh=v/lX30RlgK8cVATNXhlsOsFVDPd3yyeqxBk
	0v+rxpds=; b=VFjlTJ0sdI4jBTjlE0BVw1+z2vrTOSw+R6XWdwC1+v7kmpvNaNu
	tybxRGjdyCKRW/uZZ1T6uQfTkzyOEbsebSQ7keyTDwLEKJkHFcNGpUZmGRLwkNah
	jl/aEBPrZzOr5brVRhhIz9sy4xC1pRbFY4F2oWyhYQvzasREPB4a/0flLX6ObECR
	oXCGM6ZplK8yCGHJ2DQS+C4s8/+fwvaiRl38wiaVfO/zwFKDhSkdv2ZHoHsAlMt0
	w27akkziWFzKRmqMrx1pDCX0HpJgXfFZieY5vbnGx56nmLA2S91Mj8el5PDwN4cv
	7uolMtZqOsT7ayF4WcYRg8KLimsMMS97p5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759210368; x=
	1759296768; bh=v/lX30RlgK8cVATNXhlsOsFVDPd3yyeqxBk0v+rxpds=; b=c
	bYCapABQhePLXSz03rtsKD7md6cEh+IdSL9joHjhgiVsIsFRIoY3JQKD/xt16aJd
	y/uDBCv7z7rkJmm/TKZX48k9XF/cPT4smBsrlgFT/m1la+LyE5DRfjGv2ioPUNta
	6iXtcUOGbfXa0bZBygjbu1KLbxav8+BAYurN0agBjKfjaypIWyloKXo8z5zgcCxi
	s/AXOqEmNCQb70ETpULsNks2AmUwqG9Hq+zHzrLE2cb0NcusH0rjcXcimB2FK3OP
	NKBdLBUWRq16m3uwi/Fjiia3Jh3p73EWKxrH5B1pBpRliJrPnyzh23mckfDk73Jx
	w0axqOr9Juk4/gxS/jgWA==
X-ME-Sender: <xms:gGvbaLXel0zOHGKP_ToOyARsnbU9LAsZqh_UYHY0GQwxxDV-hviZ-w>
    <xme:gGvbaGpyEYTs0CgVCZeFb8KxuWSkG4N11GCT98khyAB3FENa06Q7Sf49x8FAJQRC-
    VzXZd9a4jF7d-gXQz551SDyHiUIEvF2QRppgScw3raaMZdcHw>
X-ME-Received: <xmr:gGvbaCDLDqrCMLYIDOZk5ccl2MU-scsJ86BAJjlvTJreKcNC0kPBZtRRBLaXYBoBk4oKgju7Zccwf2SvaKNjIzkHoGzcPammPGu3TT_VhqbI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdektddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtoheprghnnhgrrdhstghhuhhmrghkvghrsehorhgr
    tghlvgdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtghomhdprh
    gtphhtthhopehprghttghhvghssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthht
    ohepnhgrthhhrghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gGvbaCi0TY3gczsI5A9Q6c8sUJ5Ys1L3d70Q8w3D99-N8EkFc_hpWA>
    <xmx:gGvbaAYOklLvOTFCbM6YmXFZznY2IJM_YR0PeNP-QUpQ4lRWK0-GDQ>
    <xmx:gGvbaDltw0RQoDVULgp4dwvFNiLSJN-qXdcF7nPizq31W-eada5y8w>
    <xmx:gGvbaGh5XYM7DUOHkGAAB37wNJgHJBpodn3nba7lQlDpmgkNY6zEvg>
    <xmx:gGvbaO2R_NqfWP03Wy_5nrUmKUr7XAO10pSEdqxEa1o0A1JEvTquB4-K>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 01:32:45 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Nathan Chancellor" <nathan@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Anna Schumaker" <anna.schumaker@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Simon Horman" <horms@kernel.org>,
 linux-nfs@vger.kernel.org, patches@lists.linux.dev
Subject:
 Re: [PATCH v2] nfsd: Avoid strlen conflict in nfsd4_encode_components_esc()
In-reply-to: <20250929181134.GA685251@ax162>
References:
 <20250928-nfsd-fix-trace-printk-strlen-error-v2-1-108def6ff41c@kernel.org>,
 <175910219642.1696783.1969092567455681202@noble.neil.brown.name>,
 <4614aeaa-f366-4b53-afb4-ae6747589d05@oracle.com>,
 <20250929181134.GA685251@ax162>
Date: Tue, 30 Sep 2025 15:32:37 +1000
Message-id: <175921035791.1696783.9932533700998546063@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 30 Sep 2025, Nathan Chancellor wrote:
> On Mon, Sep 29, 2025 at 09:05:15AM -0400, Chuck Lever wrote:
> > On 9/28/25 4:29 PM, NeilBrown wrote:
> > > On Mon, 29 Sep 2025, Nathan Chancellor wrote:
> ...
> > >> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > >> index ea91bad4eee2..9fe8a413f688 100644
> > >> --- a/fs/nfsd/nfs4xdr.c
> > >> +++ b/fs/nfsd/nfs4xdr.c
> > >> @@ -2640,11 +2640,9 @@ static __be32 nfsd4_encode_components_esc(struc=
t xdr_stream *xdr, char sep,
> > >>  	__be32 *p;
> > >>  	__be32 pathlen;
> > >>  	int pathlen_offset;
> > >> -	int strlen, count=3D0;
> > >> +	int str_len, count=3D0;
> > >>  	char *str, *end, *next;
> > >> =20
> > >> -	dprintk("nfsd4_encode_components(%s)\n", components);
> > >> -
> > >>  	pathlen_offset =3D xdr->buf->len;
> > >>  	p =3D xdr_reserve_space(xdr, 4);
> > >>  	if (!p)
> > >> @@ -2670,9 +2668,9 @@ static __be32 nfsd4_encode_components_esc(struct=
 xdr_stream *xdr, char sep,
> > >>  			for (; *end && (*end !=3D sep); end++)
> > >>  				/* find sep or end of string */;
> > >> =20
> > >> -		strlen =3D end - str;
> > >> -		if (strlen) {
> > >> -			if (xdr_stream_encode_opaque(xdr, str, strlen) < 0)
> > >> +		str_len =3D end - str;
> > >> +		if (str_len) {
> > >> +			if (xdr_stream_encode_opaque(xdr, str, str_len) < 0)
> > >>  				return nfserr_resource;
> > >=20
> > > I probably should have said something earlier, and this is definitely
> > > bike-shedding material, but .... "str_len" is not a whole lot nicer than
> > > "strlen" (or "i") ...
> > >=20
> > >=20
> > >    if (end > str) {
> > > 	if (xdr_stream_encode_opaque(xdr, str, end - str) < 0)
> > >=20
> > > ??
> >=20
> > "len" is actually the typical variable name used in such cases. But I
> > didn't want to bug Nathan for a resend.
>=20
> If "len" is truly preferred, I do not mind sending a v3 with such a
> change. I had only kept "str" in the name because there is also
> "pathlen" in this function.


If you are going to send a v3 I would much prefer there were no variable
at all.  Just use
  if (end > str) {
    if (xdr_stream_encode_opaque(xdr, str, end - str) < 0)=20
 ...


If we wanted a 'len' variable then I would change "str" to "component"
or some abbreviation there-of and use "componentlen" (or e.g.  cmpnt,
cmpntlen).  This function is encoding "components" so using suitably
named variables to focus the reader on which bits are the "components"
seems wise.

But as I say, we don't need a "len" variable, so I wouldn't bother
renaming "str" to "cmpnt" at this stage.

Thanks,
NeilBrown


