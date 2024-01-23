Return-Path: <linux-nfs+bounces-1291-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64C9838FCD
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jan 2024 14:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91C31C24B72
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jan 2024 13:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB0B5FB8C;
	Tue, 23 Jan 2024 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGUJM/gV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F2F5FB8A;
	Tue, 23 Jan 2024 13:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016068; cv=none; b=ZkQMYgg/iuj+46Kz4BLNac4+AQ3VOMRNqNR6hHBsZh0F5yoAoflYqmKAL9wT/d+nN8om6RpmOWNc98Tzv/IH1LCbEXTgk9o08QNYjaEA494ZT7tT2U2TlUWXYPRG907fZ3r6cpC6OaYZcCc8ajWqXdvTOjv0bxMexFFeCKMsH5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016068; c=relaxed/simple;
	bh=z0O4e1iPLaTImAhBU/ThUlpcQh0I9n03dpQuUlmP4OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mT1hYF1iNPkMScL+y8mTFGMVCqyx2Oj501xz9eUOR82YAY18xD0w5C7q4QQT4RZ3r8SEtQ89oQsD6lZme0uCToRkt+8G8qBeV34y6++ZxXQ51lkDrMeRLukchTqsWZIXUfVxm/W+7Z6o1WKj0j1pOYRbqTCipPorHe+/xC3mGxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGUJM/gV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0BEC41674;
	Tue, 23 Jan 2024 13:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016067;
	bh=z0O4e1iPLaTImAhBU/ThUlpcQh0I9n03dpQuUlmP4OA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LGUJM/gVJWt91je/LmDCII96CW6VTVbEk6EdOd0vHe9ufRvI4NkWKf0kEKVyRou3i
	 XqM36ikEc46kr0jNCmaL2ZyMk/cYZiHQl1aZokrax3/hq2/uB7UCcYJbG4xxyk+f3S
	 PgOzcvNUnlC6I2HQF31aqkmEjx4AsKjA3sUWa/AYK9sv1WWcE9KG7XyVOJRBTr4Poc
	 NE45YkxeQNLHJomMVJjnKWFE/M338kvfPBOdFBWyujA0a0xQ0Eo8Goy+2UE+m7CUHQ
	 Qc2HZ7O8v+WCzVG8OHBqKsOt1MU4ftpiwDsob0VAl/62J+yBKk8uQh7cY1s+QeETJ/
	 di9SuK74qmtsw==
Date: Tue, 23 Jan 2024 14:21:03 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neilb@suse.de>,
	linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
	kuba@kernel.org, horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 3/3] NFSD: add write_ports to netlink command
Message-ID: <Za-9P0NjlIsc1PcE@lore-desk>
References: <cover.1705771400.git.lorenzo@kernel.org>
 <f7c42dae2b232b3b06e54ceb3f00725893973e02.1705771400.git.lorenzo@kernel.org>
 <9e3ae337dcf168c60c4cfd51aa0b2fc7b24bcbfb.camel@kernel.org>
 <170595930799.23031.17998490973211605470@noble.neil.brown.name>
 <Za7zHvPJdei/vWm4@tissot.1015granger.net>
 <Za-N6BxOMXTGyxmW@lore-desk>
 <85b02061798a1b750a87b0302681b86651d0c7a3.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oGji4Uj0nBLpvmk1"
Content-Disposition: inline
In-Reply-To: <85b02061798a1b750a87b0302681b86651d0c7a3.camel@kernel.org>


--oGji4Uj0nBLpvmk1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, 2024-01-23 at 10:59 +0100, Lorenzo Bianconi wrote:
> > > On Tue, Jan 23, 2024 at 08:35:07AM +1100, NeilBrown wrote:
> > > > On Tue, 23 Jan 2024, Jeff Layton wrote:
> > > > > On Sat, 2024-01-20 at 18:33 +0100, Lorenzo Bianconi wrote:
> > > > > > Introduce write_ports netlink command. For listener-set, usersp=
ace is
> > > > > > expected to provide a NFS listeners list it wants to enable (al=
l the
> > > > > > other ports will be closed).
> > > > > >=20
> > > > >=20
> > > > > Ditto here. This is a change to a declarative interface, which I =
think
> > > > > is a better way to handle this, but we should be aware of the cha=
nge.
> > > >=20
> > > > I agree it is better, and thanks for highlighting the change.
> > > >=20
> > > > > > +	/* 2- remove stale listeners */
> > > > >=20
> > > > >=20
> > > > > The old portlist interface was weird, in that it was only additiv=
e. You
> > > > > couldn't use it to close a listening socket (AFAICT). We may be a=
ble to
> > > > > support that now with this interface, but we'll need to test that=
 case
> > > > > carefully.
> > > >=20
> > > > Do we ever want/need to remove listening sockets?
> > >=20
> > > I think that might be an interesting use case. Disabling RDMA, for
> > > example, should kill the RDMA listening endpoints but leave
> > > listening sockets in place.
> > >=20
> > > But for now, our socket listeners are "any". Wondering how net
> > > namespaces play into this.
> > >=20
> > >=20
> > > > Normal practice when making any changes is to stop and restart where
> > > > "stop" removes all sockets, unexports all filesystems, disables all
> > > > versions.
> > > > I don't exactly object to supporting fine-grained changes, but I su=
spect
> > > > anything that is not used by normal service start will hardly ever =
be
> > > > used in practice, so will not be tested.
> > >=20
> > > Well, there is that. I guess until we have test coverage for NFSD
> > > administrative interfaces, we should leave well enough alone.
> >=20
> > So to summarize it:
> > - we will allow to remove enabled versions (as it is in patch v6 2/3)
> > - we will allow to add new listening sockets but we will not allow to r=
emove
> > =A0=A0them (the user/admin will need to stop/start the server).
> >=20
> > Agree? If so I will work on it and post v7.
> >=20
> >=20
>=20
> That sounds about right to me. We could eventually relax the restriction
> about removing sockets later, but for now it's probably best to prohibit
> it (like Neil suggests).

Do we want to add even the capability to specify the socket file descriptor
(similar to what we do in __write_ports_addfd())?

Regards,
Lorenzo

>=20
>=20
> >=20
> > >=20
> > >=20
> > > > So if it is easiest to support reverting previous configuration (as=
 it
> > > > probably is for version setting), then do so.  But if there is any
> > > > complexity (as maybe there is with listening sockets), then don't
> > > > add complexity that won't be used.
> > > >=20
> > > > Thanks,
> > > > NeilBrown
> > >=20
> > > --=20
> > > Chuck Lever
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--oGji4Uj0nBLpvmk1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZa+9PwAKCRA6cBh0uS2t
rLjZAP95AZ1urFqF2KP8Eg9tgPCd28subpAoaeXd5sIAEcXj5QEAt7e4wWyzT2PN
nMr5DVs6HD66u+mtplaRBQfrkdEa8wk=
=jNqe
-----END PGP SIGNATURE-----

--oGji4Uj0nBLpvmk1--

