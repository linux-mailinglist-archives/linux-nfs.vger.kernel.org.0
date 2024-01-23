Return-Path: <linux-nfs+bounces-1289-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D814838B36
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jan 2024 10:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A067B1C2469E
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jan 2024 09:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7E05A0F2;
	Tue, 23 Jan 2024 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJrAOaZK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EC65A0EB;
	Tue, 23 Jan 2024 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003948; cv=none; b=EvVLXGzoI0nNr9Kz1PQzueDJUsyCsCvagLhkNBAEuEaWB5rYoNa8zK20aVJRLZzY5OrkJNojViZdc0AGLFZaqZAXa+hz734yZdAsKdK++tcrO8etVM4BZxY0gh0/4bILcHEr9OYT0L0OImixbwOMprokMdQbpgNVA0AKDWHOFu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003948; c=relaxed/simple;
	bh=6G61OmcBZ5RdbQbm3/5N5uu8dybpynbG4cXV2VBDaJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLQDhHddxJd+M3pN2Eb9lTefdNvaAgAsGNCrYHQQAMvhS5pJbtSJH4jjXpVJHzxmdk8t0XFbKTsHIjd5Vlhbtvm3bnIS7+fkzKfVM5C5GYU1jwNE4v4yUYJoCXIkiRQ/Vz2jNBZiBZ1mwNs80xGDo3+t+DAg0DKAEqdOhk1XpPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJrAOaZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D06EC433F1;
	Tue, 23 Jan 2024 09:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706003947;
	bh=6G61OmcBZ5RdbQbm3/5N5uu8dybpynbG4cXV2VBDaJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EJrAOaZKkakyMCMzbzR58I9Y7+23R48xPKwR7p+OgYcKeNYYZvC5Nt2CRjon0Enhf
	 WZuq9Df6fy+ffkUjg84DXqo48yV5OMeWjmUU6Vbit0R/+BwgvCiJowfW1alf80AXwx
	 UkilPbXCmGdAOOayWQQFa7fc05EIK00uFgUbpvqI1CyzR9DE2IoomnbqZDFkWI8JyI
	 bu5wg/NBJQXfFTNqnHT5pAk7j/LpAMvE96HMzq2NCmop+xf01/zWlpIGSYMgXoVvj9
	 Dyz722bszKX4C0//cOJ/1VR8mKVnsAjr+EbxmNu7OGjUEZUGmd/YP1EJtC3Ef4z1OF
	 PdUP4iejo1TYg==
Date: Tue, 23 Jan 2024 10:59:04 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
	kuba@kernel.org, horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 3/3] NFSD: add write_ports to netlink command
Message-ID: <Za-N6BxOMXTGyxmW@lore-desk>
References: <cover.1705771400.git.lorenzo@kernel.org>
 <f7c42dae2b232b3b06e54ceb3f00725893973e02.1705771400.git.lorenzo@kernel.org>
 <9e3ae337dcf168c60c4cfd51aa0b2fc7b24bcbfb.camel@kernel.org>
 <170595930799.23031.17998490973211605470@noble.neil.brown.name>
 <Za7zHvPJdei/vWm4@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GyC0Sk66xPHsCCpt"
Content-Disposition: inline
In-Reply-To: <Za7zHvPJdei/vWm4@tissot.1015granger.net>


--GyC0Sk66xPHsCCpt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, Jan 23, 2024 at 08:35:07AM +1100, NeilBrown wrote:
> > On Tue, 23 Jan 2024, Jeff Layton wrote:
> > > On Sat, 2024-01-20 at 18:33 +0100, Lorenzo Bianconi wrote:
> > > > Introduce write_ports netlink command. For listener-set, userspace =
is
> > > > expected to provide a NFS listeners list it wants to enable (all the
> > > > other ports will be closed).
> > > >=20
> > >=20
> > > Ditto here. This is a change to a declarative interface, which I think
> > > is a better way to handle this, but we should be aware of the change.
> >=20
> > I agree it is better, and thanks for highlighting the change.
> >=20
> > > > +	/* 2- remove stale listeners */
> > >=20
> > >=20
> > > The old portlist interface was weird, in that it was only additive. Y=
ou
> > > couldn't use it to close a listening socket (AFAICT). We may be able =
to
> > > support that now with this interface, but we'll need to test that case
> > > carefully.
> >=20
> > Do we ever want/need to remove listening sockets?
>=20
> I think that might be an interesting use case. Disabling RDMA, for
> example, should kill the RDMA listening endpoints but leave
> listening sockets in place.
>=20
> But for now, our socket listeners are "any". Wondering how net
> namespaces play into this.
>=20
>=20
> > Normal practice when making any changes is to stop and restart where
> > "stop" removes all sockets, unexports all filesystems, disables all
> > versions.
> > I don't exactly object to supporting fine-grained changes, but I suspect
> > anything that is not used by normal service start will hardly ever be
> > used in practice, so will not be tested.
>=20
> Well, there is that. I guess until we have test coverage for NFSD
> administrative interfaces, we should leave well enough alone.

So to summarize it:
- we will allow to remove enabled versions (as it is in patch v6 2/3)
- we will allow to add new listening sockets but we will not allow to remove
  them (the user/admin will need to stop/start the server).

Agree? If so I will work on it and post v7.

Regards,
Lorenzo

>=20
>=20
> > So if it is easiest to support reverting previous configuration (as it
> > probably is for version setting), then do so.  But if there is any
> > complexity (as maybe there is with listening sockets), then don't
> > add complexity that won't be used.
> >=20
> > Thanks,
> > NeilBrown
>=20
> --=20
> Chuck Lever

--GyC0Sk66xPHsCCpt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZa+N6AAKCRA6cBh0uS2t
rEN0AP9CEZYRtw1HCZkVIlYZMNwhz/H6OyqLVzwuj3PnVvPvsQEA3tSDCr3d/R/8
VUhT41xnz7h80ztViAXIKgNavp04TgI=
=6b+o
-----END PGP SIGNATURE-----

--GyC0Sk66xPHsCCpt--

