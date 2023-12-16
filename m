Return-Path: <linux-nfs+bounces-669-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA878157D7
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Dec 2023 06:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E576B24489
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Dec 2023 05:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26EC11CB1;
	Sat, 16 Dec 2023 05:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="OynTwoFD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651201170A;
	Sat, 16 Dec 2023 05:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1702705390;
	bh=+wHapOXox/BER7lwK/c3gIBBT3hLoNAm5iv9cDfXCd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OynTwoFDMNulnT1FKRC/3YIDVQC74pZWGE8XzoKZ1j34ObiTxOFy50juJCoff5YHN
	 JMrWPCd9nAQez89j1VdYaBRJ0VRpC4ZX94QF+YVlqUOXV6MPMYoZK8cNSXzVulPEoa
	 5bJdADWcRnNg6CvPZfnTjWpIwyx+0cAoj1HQR0YB+gickjyCF2X8X8CttsweA8Np0m
	 EWtO1fxkASRzdkh1er1oxRc7Q86T5/V/jXKckkz2J/FMRUKetNqsfGpwmFSrdTlCMI
	 ynvnsbyslEdk36fX9L40LYP3jqYwT6LDhz9bpOyj91PS7TjpYxNHjMeLeM+9p3ll54
	 /jRreNYjaNP5w==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 0209113C0A;
	Sat, 16 Dec 2023 06:43:09 +0100 (CET)
Date: Sat, 16 Dec 2023 06:43:09 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: NeilBrown <neilb@suse.de>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <kolga@netapp.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-nfs@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sunrpc: sizeof('\0') is 4, not 1
Message-ID: <ikgsiev777wvypqueii5mcshrdeftme22stfvztonxbvcrf35l@tarta.nabijaczleweli.xyz>
References: <4zlmy3qwneijnrsbygfr2wbsnvdvcgvjyvudqnuxq5zvwmyaof@tarta.nabijaczleweli.xyz>
 <170270083607.12910.2219100479356858889@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ur233i3m2n556z64"
Content-Disposition: inline
In-Reply-To: <170270083607.12910.2219100479356858889@noble.neil.brown.name>
User-Agent: NeoMutt/20231103-116-3b855e-dirty


--ur233i3m2n556z64
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 03:27:16PM +1100, NeilBrown wrote:
> On Sat, 16 Dec 2023, Ahelenia Ziemia=C5=84ska wrote:
> > To make it self-documenting, the referenced commit added the space
> > for the null terminator as sizeof('\0'). The message elaborates on
> > why only one byte is needed, so this is clearly a mistake.
> > Spell it as 1 /* NUL */ instead.
> >=20
> > Fixes: commit 1e360a60b24a ("SUNRPC: Address  buffer overrun in
> >  rpc_uaddr2sockaddr()")
> It isn't clear to me that "Fixes" is appropriate as that patch isn't
> harmful, just confused and sub-optimal.
I definitely agree, I don't like Fixes here at all,
but I don't really see another trailer in the documentation
or in the log that could be used for this.

--ur233i3m2n556z64
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV9OO0ACgkQvP0LAY0m
WPE42RAAuE2y/k1eIQefSd7rFtGSFVgZvFcRmrN8GquoYGeXs596QNnq8tAwSroo
6MB9avhWDwLI6opEuELRalbuFS30kddoRWPZxt/spkrU4hDcagWrU2wkgCb3lFAV
Xk0Q5m17j/7aKhOygEI5HlDQVvQu0lz6+8KBzUKGUWqznNZQJPOF0IL3CYO+NmbP
Jakn57ZSoT6hTWHsg6vfApSe3sZQiBbBfuxKLVfUMTdAmLl2JZj2UU0w/KXUeteW
vI7g7uigw+TXJVqcrAN6bEV4i96zQB523JGmYkhnA0/n03yTQg/mHWGqTsK7iFfC
IAakkDCWSJs+dXCnK5WJcBl/MpEGMsR9w0Nswua4CWTZAWFVW5rhKlcwyvagIH9p
FVR6osRtVRhYPHYtRXnYyuhmEDaFuLfgFc9YhuJ2JjXmRLOo1l3hITW5Al7/RC0G
o3W31S+7d/f+JB4f9WvJ7oo/3SvpzuUzqrpwpP6TR9RNyJ6nrs4Mxu5xk4dXz+vH
/v1SecxG/GUV/D005A96AfhkKpmuOClIRSpR5bOCkayoxalS1r1o2Cbj4VGgaDq3
kqYbRZ4uVcdC8EEmfYDwCZXG7ND961SYlEUDnE0EBqup4BptIoYwJudiODuKlNdb
o+JaEE4qV4S/QSxrL0tPgvfNqYpKBCdpBnQ9YLEq7fPg7ENw2QU=
=gDvI
-----END PGP SIGNATURE-----

--ur233i3m2n556z64--

