Return-Path: <linux-nfs+bounces-16032-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50831C33335
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 23:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8AF18C3190
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 22:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41E8255F57;
	Tue,  4 Nov 2025 22:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="dj8FPY1A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UrsK8jQ6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B752690D5
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 22:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762294854; cv=none; b=IP4EABSSD1IoVB2u90i+IstHqfFCLPMHOePmUNm0wbG88nt8wiGy03SPtaN0r06mKLonGZdoPjiw0kby+WrdlZC5Xf70chhNS14hEFsU56iFaC/wTelVViG+AKTwiTupQwIBnlAcuidstwNmxCTKv63iZSND2ZD79c1BU5sp9uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762294854; c=relaxed/simple;
	bh=GvfBQ8E4l8zsJoT7Rvm7+z8+0FWvJZxpcu/uZ39r1sA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Js4vPf0Ej2lIqCp+xhtrirFHu1w2grXquiNVM+/73X9mRlTdIpz0rB0uE12IzZFGL+lyLhye+n6gSsRWL+lLEjU6MyXWyDguY+nUd5YnsROyCAfTw/QKPfQcl2QI4YhMw7meClRtEamRZ2OzmroVQx/yhVWIJOCHQUPluabHMus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=dj8FPY1A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UrsK8jQ6; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BCBB7140026D;
	Tue,  4 Nov 2025 17:20:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 04 Nov 2025 17:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762294849; x=1762381249; bh=g7B9bRPFDhM9awoWjPhOjR7D8+6kLOabH4R
	Avb/lnBY=; b=dj8FPY1AQrAXP5mOTYHoRDEjC2nZyOaMNUDDq2x1ZMtehBa1Hb/
	mDaQgpEbq3Hqe5RnJYzHliLDlUstaFsviScFU7VHVegetEbkfAZUeOj3zj5hLeJ1
	eAgPkR3oizvl5pA7ACL9iLarpxbmMXNeIJ35A3Ju+pbP4VmIOyEieQqLQgAllv+v
	jr1EZJu8Mn0MRzTgLmJbbcmsmVGgcYd30Ql8AW4wS9bgSWEzyhOxdMtXaZdoGXtl
	WzOuJS+zyrF1EhZlCg0w0MJsXyovxk4IRGDUgLHAzo5u7QWzz73ARjU0WOUCoklh
	yjQbDAPFH8715PpVdzcdfwPWqcR4pAEDmow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762294849; x=
	1762381249; bh=g7B9bRPFDhM9awoWjPhOjR7D8+6kLOabH4RAvb/lnBY=; b=U
	rsK8jQ65P46kH0gq3XRql/28S8RwRvD8q2C/Y0Rsh5pop6x/AzyiNrRzeMhcnsvO
	4eg8d3Xn5GyzilY3IPT5dJdRDlJdqBwFJCmx7leEXwVlJMPGODY/AfOC2V/hD+mJ
	l4ilCrkW43HLwfI4EzQnurU7pYKMFserb1dIafzEXio4gI9Aa05oAQj9c7WgOwad
	73OS/kidE1k1pVbZyriqPFcjXPTs9EvkUfywmu84uzN3XalCtq5H8xQj0ULhMKIw
	p49b86M4p2738rT/vG9tSci9qVgPMWFRVs0HUTFqizUIPeu1eSC2fH7Z10lPAwPt
	CR9DbUIF6EcoeeBJHsl8w==
X-ME-Sender: <xms:QXwKaeOgGaBDyEGsZ0J3y5JxkOSEykkETeD2j46qQNTfrsCohwxWpg>
    <xme:QXwKafN2h1vaWn8jZbDA2ggf17Yf9vSbndkCQWA4jIJLiyEJ7pJ_YWFCbErkLdkki
    Sx6Eb4YQNjRfY5ZQmwW0fc8nfy2qmaiX1SrxxY7KbN7NgIB>
X-ME-Received: <xmr:QXwKaXjT0_rzwzVSMWY3_MZiHbiYdSQomWJLgctBNHY4JhEK_tGqgAqj6PfiohMXSwJ-e0RuQYGvqX0CEuBI1P6GFbrT6V4xvrO7ULclUNKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedvvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdeuteelkeejkeevteetvedtkeegleduieeftdeftefgtddtleejgfelgfevffeinecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqd
    hnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhrohhnughmhies
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheptggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghughgs
    ohhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhhnrgeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepnhgvihhlsgessghrohifnhdrnhgrmhgv
X-ME-Proxy: <xmx:QXwKaUtIfq2ZpX2TiFGlH6UEVHqAm9K6mixa-uqqCCCTUw3K4aKhOg>
    <xmx:QXwKaVT-kEqI7kPLI0_j32k0qdyEWCHhwypjbAzecTD3wRqUPQga5g>
    <xmx:QXwKaY0h-aP8ioVl9zkmKaAFoCincALV6_JpETWi73XTKXpAN61PCw>
    <xmx:QXwKaatSDk27QgXrO0Om2v05iy0Ebd9McqamMmdoki05ouIHIVyVDA>
    <xmx:QXwKaT88ehL0oBwoDc2aMD6rCdvsGmzwqX7Ydfi4eZj2VLmoiZo50PsE>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 17:20:47 -0500 (EST)
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
Cc: jlayton@kernel.org, neilb@brown.name, linux-nfs@vger.kernel.org,
 anna@kernel.org, trondmy@kernel.org,
 "Mike-SPC via Bugspray Bot" <bugbot@kernel.org>
Subject: Re: Compile Error fs/nfsd/nfs4state.o - clamp() low limit slotsize
 greater than high limit total_avail/scale_factor
In-reply-to: <9308c03f-e906-4de1-87b9-f9d90b0461b4@kernel.org>
References: <20251104-b220745c0-91170b3b3642@bugzilla.kernel.org>,
 <9308c03f-e906-4de1-87b9-f9d90b0461b4@kernel.org>
Date: Wed, 05 Nov 2025 09:20:42 +1100
Message-id: <176229484269.1793333.9105827008525809090@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 05 Nov 2025, Chuck Lever wrote:
> On 11/4/25 9:15 AM, Mike-SPC via Bugspray Bot wrote:
> > Mike-SPC writes via Kernel.org Bugzilla:
> >=20
> > Hi there,
> >=20
> > with kernel version > 6.1.156 I get the following error by compiling it (=
make bzImage) on a 32bit platform:

Which platform?  Which compiler?

I just build nfsd on 6.1.158 for mips (32 bit) with

$ /opt/cross/bin/mipsel-unknown-linux-gnu-gcc -v
Using built-in specs.
COLLECT_GCC=3D/opt/cross/bin/mipsel-unknown-linux-gnu-gcc
COLLECT_LTO_WRAPPER=3D/opt/cross/libexec/gcc/mipsel-unknown-linux-gnu/7.2.0/l=
to-wrapper
Target: mipsel-unknown-linux-gnu
Configured with: ../configure --target=3Dmipsel-unknown-linux-gnu --prefix=3D=
/opt/cross --enable-languages=3Dc --without-headers --with-gnu-ld --with-gnu-=
as --disable-shared --disable-threads --disable-libmudflap --disable-libgomp =
--disable-libssp --disable-libquadmath --disable-libatomic
Thread model: single
gcc version 7.2.0 (GCC)=20

and it worked fine.

Have you found a 6.1.y kernel for which the build doesn't fail?

There is no way that code could reasonably trigger that warning.
I suspect a compiler bug/incompatibility.
If you compiler is GCC earlier than 5.1 or Clang before 11.0.0
then upgrade your compiler.
If it is newer, then report the incompatibility to
stable@vger.kernel.org.

NeilBrown


> >=20
> >   CALL    scripts/checksyscalls.sh
> >   CC      fs/nfsd/nfs4state.o
> > In file included from <command-line>:
> > In function 'nfsd4_get_drc_mem',
> >     inlined from 'check_forechannel_attrs' at fs/nfsd/nfs4state.c:3539:16,
> >     inlined from 'nfsd4_create_session' at fs/nfsd/nfs4state.c:3612:11:
> > ././include/linux/compiler_types.h:375:38: error: call to '__compiletime_=
assert_587' declared with attribute error: clamp() low limit slotsize greater=
 than high limit total_avail/scale_factor
> >   375 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COU=
NTER__)
> >       |                                      ^
> > ././include/linux/compiler_types.h:356:4: note: in definition of macro '_=
_compiletime_assert'
> >   356 |    prefix ## suffix();    \
> >       |    ^~~~~~
> > ././include/linux/compiler_types.h:375:2: note: in expansion of macro '_c=
ompiletime_assert'
> >   375 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COU=
NTER__)
> >       |  ^~~~~~~~~~~~~~~~~~~
> > ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compileti=
me_assert'
> >    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), m=
sg)
> >       |                                     ^~~~~~~~~~~~~~~~~~
> > ./include/linux/minmax.h:188:2: note: in expansion of macro 'BUILD_BUG_ON=
_MSG'
> >   188 |  BUILD_BUG_ON_MSG(statically_true(ulo > uhi),    \
> >       |  ^~~~~~~~~~~~~~~~
> > ./include/linux/minmax.h:195:2: note: in expansion of macro '__clamp_once'
> >   195 |  __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_)=
, __UNIQUE_ID(h_))
> >       |  ^~~~~~~~~~~~
> > ./include/linux/minmax.h:218:36: note: in expansion of macro '__careful_c=
lamp'
> >   218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo,=
 hi)
> >       |                                    ^~~~~~~~~~~~~~~
> > fs/nfsd/nfs4state.c:1825:10: note: in expansion of macro 'clamp_t'
> >  1825 |  avail =3D clamp_t(unsigned long, avail, slotsize,
> >       |          ^~~~~~~
> > make[3]: *** [scripts/Makefile.build:250: fs/nfsd/nfs4state.o] Error 1
> > make[2]: *** [scripts/Makefile.build:503: fs/nfsd] Error 2
> > make[1]: *** [scripts/Makefile.build:503: fs] Error 2
> > make: *** [Makefile:2025: .] Error 2
> >=20
> >=20
> >=20
> > I'm not a coder, so I checked it with OpenAI, which throwed out the follo=
wing patch:
> >=20
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -1822,8 +1822,12 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_=
attrs *ca, struct nfsd_net *nn
> >         */
> >         scale_factor =3D max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthrea=
ds);
> >=20
> > -       avail =3D clamp_t(unsigned long, avail, slotsize,
> > -                       total_avail/scale_factor);
> > +       /* Ensure hi >=3D lo per "give at least one slot" policy */
> > +       do {
> > +               unsigned long hi =3D total_avail / scale_factor;
> > +               if (hi < slotsize) hi =3D slotsize;
> > +               avail =3D clamp_t(unsigned long, avail, slotsize, hi);
> > +       } while (0);
> >         num =3D min_t(int, num, avail / slotsize);
> >=20
> >=20
> >=20
> > After implementing it, I'm able to compile the kernel.
> > But, as I mentioned before, I'm not a coder, so I cannot test the patch f=
rom a programming perspective.
> >=20
> > Therefore, it would be nice if a patch could be made available by a human=
. :)
> >=20
> > Thanks in advance - regards,
> > Michael
> >=20
> > View: https://bugzilla.kernel.org/show_bug.cgi?id=3D220745#c0
> > You can reply to this message to join the discussion.
>=20
> The failing code was introduced by commit 2030ca560c5f ("nfsd: degraded
> slot-count more gracefully as allocation nears exhaustion.") in v5.4. It
> is not a backport to v6.1. I don't see any changes to that code until
> b5fba969a2e4 ("nfsd: remove artificial limits on the session-based
> DRC"), when it was removed whole-sale.
>=20
> That means we don't have this code to patch in upstream. If there is a
> fix to be made in NFSD, we will have to create one-off patches for each
> of the LTS kernels.
>=20
> It appears that there have been several clean-ups to clamp_t and friends
> since v6.1, and they have been mostly backported to v6.1.y. It's hard to
> say without a bisect whether one of those is the reason for the
> breakage.
>=20
> Neil, according to the last touch rule, you're the owner of this code
> ;-) Do you have any thoughts? I'm not quite sure what the compile-time
> assertion is complaining about.
>=20
>=20
> --=20
> Chuck Lever
>=20
>=20


