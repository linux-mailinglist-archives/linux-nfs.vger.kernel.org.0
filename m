Return-Path: <linux-nfs+bounces-1795-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 171B984A1BA
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 19:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AF821C21657
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 18:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B266D481AB;
	Mon,  5 Feb 2024 18:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfEifZKL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85403481A2
	for <linux-nfs@vger.kernel.org>; Mon,  5 Feb 2024 18:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707156222; cv=none; b=CchWnfzdnWX0MCkT+zN4bEEbwk8R32AIhQjBIHg3OFKlLC9Ggp0+e9VoUgmK5w58S7pOQiC7wz9r+SxZLu4whIH0jmE6rOCCrTCTbsRT9k43rDXkNUGogGfBpfMw3iROmTF/0F0VJg6QZc+wt4EIZM8dJQIOUJjmnbWPC7RVGuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707156222; c=relaxed/simple;
	bh=XiMlq9F7pJHtcGmKQv5qAvLgWT3FWOs+PxAvmJ0k8Tg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o2CYD9EXWHHTfAFSn78gjEEFetFCzBXi7vRA/PWHNAmEU6vHBtRzDxJ9j2pwz0VAusGNPmS+Zw8aI1YIAO2REyhRqWFVykknyrb5r0qI22Fs0C0rC7RMTBHDqy9eDHXCe37gyL/B0pBgfxQV9rUmI1UpdbHchNz2C8/6yJCgthI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfEifZKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E58C433C7;
	Mon,  5 Feb 2024 18:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707156222;
	bh=XiMlq9F7pJHtcGmKQv5qAvLgWT3FWOs+PxAvmJ0k8Tg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pfEifZKLGAMrNmqas2XQI4QEyg3uiypdhleSqNZJMN2ZfwoycVAwDwECF8bdeWJaL
	 amlgPt9lDQCb41CYVg5NeNgJhw1n74Y7bG44dD2uQgY1JMbIDX7r8+xjC8zwk+SdBc
	 sSGkTIiX+cd6/YDnOZ3BJKQ8pujrU2Hcdq2jcWQTAdN8eiSEFiHFAqJLBhd9IMy/Uy
	 XXA61VwQ2D3WWTCUUt+ssWmj6KHTbHbmlzNbJ4tkemk1R2tucDzYYVLp71MNP/m2QA
	 ro42/sFVN0dki6nhfAnJoXNP4kSFsTAEDKrapJ7fW5OfbRCIEaaLlyRbtbOauSJ4m/
	 GamMxNF2JeGXg==
Message-ID: <8e69c484d0dd844453fb7144e72e8659dcb32085.camel@kernel.org>
Subject: Re: Should we establish a new nfsdctl userland program?
From: Jeff Layton <jlayton@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neilb@suse.com>, Dai
 Ngo <dai.ngo@oracle.com>, "olga.kornievskaia"
 <olga.kornievskaia@gmail.com>, Tom Talpey <tom@talpey.com>, linux-nfs
 <linux-nfs@vger.kernel.org>
Date: Mon, 05 Feb 2024 13:03:40 -0500
In-Reply-To: <ZcEeeRrYOQsKOPw_@lore-desk>
References: <8a7bbc05b6515109692cb88ad68374d14fc01eca.camel@kernel.org>
	 <Zb0hlnQmgVikeNpi@lore-rh-laptop>
	 <e706a77b4ddbceeb8b0ebac4dcbca03f8196e8a5.camel@kernel.org>
	 <ZcEQzyrZpyrMJGKg@lore-desk>
	 <799dc278c5d15605e1535303a7a15dee4eef82b3.camel@kernel.org>
	 <ZcEeeRrYOQsKOPw_@lore-desk>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-05 at 18:44 +0100, Lorenzo Bianconi wrote:
> > On Mon, 2024-02-05 at 17:46 +0100, Lorenzo Bianconi wrote:
> > > > On Fri, 2024-02-02 at 18:08 +0100, Lorenzo Bianconi wrote:
> > > > > > The existing rpc.nfsd program was designed during a different t=
ime, when
> > > > > > we just didn't require that much control over how it behaved. I=
t's
> > > > > > klunky to work with.
> > > > > >=20
> > > > > > In a response to Chuck's recent RFC patch to add knob to disabl=
e
> > > > > > READ_PLUS calls, I mentioned that it might be a good time to ma=
ke a
> > > > > > clean break from the past and start a new program for controlli=
ng nfsd.
> > > > > >=20
> > > > > > Here's what I'm thinking:
> > > > > >=20
> > > > > > Let's build a swiss-army-knife kind of interface like git or vi=
rsh:
> > > > > >=20
> > > > > > # nfsdctl=A0stats			<--- fetch the new stats that got merged
> > > > > > # nfsdctl add_listener		<--- add a new listen socket, by addres=
s or hostname
> > > > > > # nfsdctl set v3 on		<--- enable NFSv3
> > > > > > # nfsdctl set splice_read off	<--- disable splice reads (per Ch=
uck's recent patch)
> > > > > > # nfsdctl set threads 128	<--- spin up the threads
> > > > > >=20
> > > > > > We could start with just the bare minimum for now (the stats in=
terface),
> > > > > > and then expand on it. Once we're at feature parity with rpc.nf=
sd, we'd
> > > > > > want to have systemd preferentially use nfsdctl instead of rpc.=
nfsd to
> > > > > > start and stop the server. systemd will also need to fall back =
to using
> > > > > > rpc.nfsd if nfsdctl or the netlink program isn't present.
> > > > > >=20
> > > > > > Note that I think this program will have to be a compiled binar=
y vs. a
> > > > > > python script or the like, given that it'll be involved in syst=
em
> > > > > > startup.
> > > > > >=20
> > > > > > It turns out that Lorenzo already has a C program that has a lo=
t of the
> > > > > > plumbing we'd need:
> > > > > >=20
> > > > > > =A0=A0=A0=A0https://github.com/LorenzoBianconi/nfsd-netlink
> > > > >=20
> > > > > This is something I developed just for testing the new interface =
but I agree we
> > > > > could start from it.
> > > > >=20
> > > > > Regarding the kernel part I addressed the comments I received ups=
tream on v6 and
> > > > > pushed the code here [0].
> > > > > How do you guys prefer to proceed? Is the better to post v7 upstr=
eam and continue
> > > > > the discussion in order to have something usable to develop the u=
ser-space part or
> > > > > do you prefer to have something for the user-space first?
> > > > > I do not have a strong opinion on it.
> > > > >=20
> > > > > Regards,
> > > > > Lorenzo
> > > > >=20
> > > > > [0] https://github.com/LorenzoBianconi/nfsd-next/tree/nfsd-next-n=
etlink-new-cmds-public-v7
> > > > >=20
> > > > >=20
> > > >=20
> > > > My advice?
> > > >=20
> > > > Step back and spend some time working on the userland bits before
> > > > posting another revision. Experience has shown that you never reali=
ze
> > > > what sort of warts an interface like this has until you have to wor=
k
> > > > with it.
> > > >=20
> > > > You may find that you want to tweak it some once you do, and it's m=
uch
> > > > easier to do that before we merge anything. This will be part of th=
e
> > > > kernel ABI, so once it's in a shipping kernel, we're sort of stuck =
with
> > > > it.
> > > >=20
> > > > Having a userland program ready to go will allow us to do things li=
ke
> > > > set up the systemd service for this too, which is primarily how thi=
s new
> > > > program will be called.
> > >=20
> > > I agree on it. In order to proceed I guess we should define a list of
> > > requirements/expected behaviour on this new user-space tool used to
> > > configure nfsd. I am not so familiar with the user-space requirements
> > > for nfsd so I am just copying what you suggested, something like:
> > >=20
> > > $ nfsdctl=A0stats                                                 <--=
- fetch the new stats that got merged
> > > $ nfsdctl xprt add proto <udp|tcp> host <host> [port <port>]    <--- =
add a new listen socket, by address or hostname
> >=20
> > Those look fine.
> >=20
> > All of the commands should display the current state too when run with
> > no arguments. So running "nfsctl xprt" should dump out all of the
> > listening sockets. Ditto for the ones below too.
>=20
> ack
>=20

I think we might need a "nfsdctl xprt del" too. I know we don't have
that functionality now, but I think it's missing. Otherwise if you
mistakenly set the wrong socket with the interface above, how do you fix
it?

Alternately, we could provide some way to reset the server state
altogether:

     # nfsdctl reset

?

> >=20
> > > $ nfsdctl proto v3.0 v4.0 v4.1                                  <--- =
enable NFSv3 and v4.1
> >=20
> > The above would also enable v4.0 too?
> >=20
> > For this we might want to use the +/- syntax, actually. Also, there wer=
e
> > no minorversions before v4, so it probably better not to accept that fo=
r
> > v3:
> >=20
> > =A0=A0=A0=A0$ nfsdctl proto +v3 -v4.0 +4.1
>=20
> according to the previous discussion we agreed to pass to the kernel just=
 the
> protocol versions we want to enable (v3.0 v4.0 v4.1 in the previous examp=
le)
> and disable all the other ones..but I am fine to define a different seman=
tics.
> What do you think it is the best one?
>=20


The kernel interface should be declarative like you have, but the
command-line interface could be more imperative like this. It could do a
fetch of the currently enabled versions, twiddle them based on the +/-
arguments and then send the new set down to the kernel for it to act on.

One thing we haven't considered here too: Kconfig allows you to compile
out support for some versions. For instance, v2 support is disabled by
default these days.

Maybe we should rethink the kernel interface too: When querying the
versions, we could have it send the full set of all of the versions that
it supports up to userland, and report whether each version is enabled
or disabled.

So if you get a list of versions from the kernel, and v2 isn't in the
list at all, you can assume that the kernel doesn't support it.

> >=20
> > So to me, that would mean enable v3 and v4.1, and disable v4.0.
> > v2 (if supported) and v4.2 would be left unchanged.
> >=20
> > > $ nfsdctl set threads 128                                       <--- =
spin up the threads
> > >=20
> >=20
> > Maybe:
> >=20
> > =A0=A0=A0=A0$ nfsdctl threads 128
>=20
> ack
>=20
> >=20
> > ?
> > =A0
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> > > Can we start from [0] to develop them?
> > >=20
> >=20
> > Yeah, that seems like a good place to start.
>=20
> ack, I will work in it.
>=20

Very exciting!

--=20
Jeff Layton <jlayton@kernel.org>

