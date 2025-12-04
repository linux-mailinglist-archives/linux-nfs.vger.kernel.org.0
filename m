Return-Path: <linux-nfs+bounces-16896-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E93CCA2156
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Dec 2025 02:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24268300259D
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Dec 2025 01:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A35155C87;
	Thu,  4 Dec 2025 01:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1OOIjqc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D125F1DFDE
	for <linux-nfs@vger.kernel.org>; Thu,  4 Dec 2025 01:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764810471; cv=none; b=mLz2EfsPYnHMSVOfIaBnIIEnH6/fwrFrIbo/AyoG6AH+pGNOySBGB8wuj+RUA+p844JsCjdPX8mYoD7UgR555c/GGf+5O+l91GP01AQOqHencOX6LuA/ViNZqkiC2q28wRlrxQVCDVTsHQCHXcj9+lvoFCLqcZEMQ677RM+m4hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764810471; c=relaxed/simple;
	bh=hY06PDBfqjyHwMtE3v3SCaGLx34vv46S5WL6zcankg4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=j5n1iVS9MhvZVeTzrV4JV6RmKxAv8qBNORg59Ch+D35Q92gc3z3c6KfWzhfP2/JfVs4Il8jprYfWWKgLuQqrmanFE2haDfX2n+SBuvxJ495mLJOKVth+9D27SePi1iqHSZWAXioPul5R+rbSRvi9nWHzf32Nj/kAeeZ72z0+M6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1OOIjqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAB0C116B1;
	Thu,  4 Dec 2025 01:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764810471;
	bh=hY06PDBfqjyHwMtE3v3SCaGLx34vv46S5WL6zcankg4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=j1OOIjqceL5I7nI3NN6y1AY/HjRd7QHiWHn2OQJUyL/rfhzEfX5P1a5MXh6CDwrnE
	 ui1pB3cLmjlo8MbB1/KY8fbgSKZcaGNbiD7vEqC/TxR49rj+7K9Bmi+sYrgXW8YGoY
	 sog/Bv4ridX9r9RPJ5PnJtnaLSYv25w+9zRMmcx0WkHhuF3ReVM27Ja/yjcaqnw9m6
	 TLGbPf9y6pj4AbkzPiyuZELkx8rYgkfzctJLpBmDp6wjlLZOqYVroMKgs6vquG0TKR
	 W7DerLVADFzJQH1Fyt53yQlJYcz1buRi9LrW/4WgSeMvlsURW98sOOhZihVJZlgjbw
	 IGDF0R5lGvjDA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 28B8BF4006A;
	Wed,  3 Dec 2025 20:07:50 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 03 Dec 2025 20:07:50 -0500
X-ME-Sender: <xms:5t4waRyj4hnuNGS18HHHWLc2x0pvXoNwa6GAIGmQzZfuNXOXzpvsSg>
    <xme:5t4wacFuaSXuzv6XcDkkkrhiECQxFptEm7qUO2BVQYzz3HRbmtWnG_TbCQxJj3rWf
    8rwsU9E618GdWVr5wklYHOMBU7_Q9iQ6YRh1PWxiZWtGBmV9Z9Gy-c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgtkhcu
    nfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    fghfeguedtieeiveeugfevtdejfedukeevgfeggfeugfetgfeltdetueelleelteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutghklh
    gvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleelleeh
    ledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopehjlhgrhihtohhnsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdr
    tghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtth
    hopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhomhesthgr
    lhhpvgihrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:5t4waUrexlMc8M5-PTfsP_KLrDbNzL59P-EE24nBypqLZ4oUFwtkPQ>
    <xmx:5t4wabWPSv7Dwt-J23ATPwOcXcxK-FF7JeqJy8KHhSBGW6fCf5JjHA>
    <xmx:5t4waXaibPuJG8lxiFlfX115rZjcnXeTaLvTeU4liGOaiNOpB9QDOA>
    <xmx:5t4waQeQTBL65bg8Leda26Rc2zVUEz1CaiIEuoW_AFaB9rcii-3lBg>
    <xmx:5t4waZ34TeBmiUN3CMmd6HIXutXjS5NbQtmnaHujTuWtbzBigrUGELeG>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 04834780054; Wed,  3 Dec 2025 20:07:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AW-f6n96Aybc
Date: Wed, 03 Dec 2025 20:06:49 -0500
From: "Chuck Lever" <cel@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <6b45c31e-d5b8-4510-83dc-8a6578cd5ccf@app.fastmail.com>
In-Reply-To: <176480190344.16766.4086911917002460445@noble.neil.brown.name>
References: <20251202224208.4449-1-cel@kernel.org>
 <176471811359.16766.18131279195615642514@noble.neil.brown.name>
 <dc25626e-fae0-401b-93ed-1c4fdf34186c@app.fastmail.com>
 <176472909957.16766.8691035364646019081@noble.neil.brown.name>
 <eaaa46486ec7b1273adfc1a3bdbf11cb1f557e40.camel@kernel.org>
 <079ef086-fa1c-4a9f-b011-e47547b4e3bc@app.fastmail.com>
 <176480190344.16766.4086911917002460445@noble.neil.brown.name>
Subject: Re: [PATCH v2 1/2] nfsd: prevent write delegations when client has existing
 opens
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Wed, Dec 3, 2025, at 5:45 PM, NeilBrown wrote:
> On Thu, 04 Dec 2025, Chuck Lever wrote:
>>=20
>> On Wed, Dec 3, 2025, at 7:26 AM, Jeff Layton wrote:
>
>>=20
>> > I agree with Neil here (despite my questioning this on our call
>> > yesterday).
>
> Ahh.. I wondered what had triggered the about-face between one patch s=
et
> and the next.  I now see it was your off-line conversation ...
> Maybe it would help to surface this:
>
>   Jeff suggested in a private conversation that ....  so this version
>   takes a different approach and .....

The idea I took from my conversation with Jeff was that v1 might not
have actually gotten to the root of the problem. I thought it might be
evident from the higher-level fix in v2 that RCA was ongoing, but
perhaps it wasn=E2=80=99t that obvious.


>> Then you prefer the v1 patch that reuses the nfsd_file already
>> in fi_fds[O_RDONLY], and we can drop the addition of the
>> WARN_ON_ONCE ?
>
> That is the direction that I would prefer too.

I=E2=80=99ve applied v1 to nfsd-testing. As always, it is still open to =
review
comments.


--=20
Chuck Lever

