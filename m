Return-Path: <linux-nfs+bounces-5535-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C064995A3F5
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 19:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77433282721
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 17:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526EC16C685;
	Wed, 21 Aug 2024 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2qBJbhH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA1D13BAC2
	for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2024 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724261697; cv=none; b=EfC5+QKRMu/2JDu5cU3XUBCn+E7pDeOuF80tszktT5988WLEiZwkL1mXPhLWKNar1R7dKJISlNReHtl0dgrSDjBE7IUsXWL4LVGV/+Z50zUoqNJKMy4vf/q+V7KvDwQ58ceokfMCPq+2cbLdIkw2VxrT/tfWAS7UbDUoidY3bKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724261697; c=relaxed/simple;
	bh=Vt/VPr4qsOMZ7f6KMUn9UQJdm76IwV2y/XU1w/2FQA4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RxabWDdALEFT0Dm8tCoSVKWg6hk4AKpLi76Nv6kXGy/BsIifzwI9ETpYu8wTcbr/TsxKlApLdY1JLtZnW8E6Hr/0wpdNIklGrfSQgel7ty/q52KGL5w+JzldfasTEtZ7xadiG4zOKfXd5hQLPycoEX7EGjhySxBMMUPVPJcoZLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2qBJbhH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7DBC32781;
	Wed, 21 Aug 2024 17:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724261697;
	bh=Vt/VPr4qsOMZ7f6KMUn9UQJdm76IwV2y/XU1w/2FQA4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=u2qBJbhHk3RbC7wXqgyGgcPwP3AZrL0lAQXBzrxPUXungXZrHSMJBQ2Y+sM6UvGlN
	 7cxJRfvDFOxs4txewDb5W91wsC3CDpFMDxibFxvn2FCPOknMhAxxRIzVRumr4GbAGb
	 fJlSkpPB9OVdT24ad+IqcEKMsgzE90UzPNx/b1mRyeMOMBedTdMHO9aAPs46m8JXQP
	 QWVCFjGOB+Fv0tYuXnFvGc3/3BY2DxytUUNjYnPDMrpWueF1ufdKHse8CQhD++9qAY
	 SOJeQ8fOEkgxeBDURpRq8aPLWxDZ2SjAfAcLi7u0wzAYt99hxk/k52LJ2O7E0up01w
	 m0b8t6P4fL7zQ==
Message-ID: <3deb19e0da3ab3f31e8e3dd0e1f7549d27b299b6.camel@kernel.org>
Subject: Re: [RFC PATCH 2/2] NFSD: Create an initial nfs4_1.x file
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org, Trond Myklebust
	 <trondmy@hammerspace.com>, Anna Schumaker <anna@kernel.org>
Date: Wed, 21 Aug 2024 13:34:55 -0400
In-Reply-To: <ZsYd99w9wWbjI54J@tissot.1015granger.net>
References: <20240820144600.189744-1-cel@kernel.org>
	 <20240820144600.189744-3-cel@kernel.org>
	 <6a3d9288fdeb6409dca7c2ceedf249d3b40a7d97.camel@kernel.org>
	 <ZsX79e6NPi/4/rxC@tissot.1015granger.net>
	 <590b91607e15f1fecd563781a0c5390ff02da5b2.camel@kernel.org>
	 <ZsYd99w9wWbjI54J@tissot.1015granger.net>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-21 at 13:03 -0400, Chuck Lever wrote:
> On Wed, Aug 21, 2024 at 12:51:51PM -0400, Jeff Layton wrote:
> > On Wed, 2024-08-21 at 10:38 -0400, Chuck Lever wrote:
> > > On Wed, Aug 21, 2024 at 10:22:15AM -0400, Jeff Layton wrote:
> > > > On Tue, 2024-08-20 at 10:46 -0400, cel@kernel.org=C2=A0wrote:
> > > > > From: Chuck Lever <chuck.lever@oracle.com>
> > > > >=20
> > > > > Build an NFSv4 protocol snippet to support the delstid
> > > > > extensions.
> > > > > The new fs/nfsd/nfs4_1.x file can be added to over time as
> > > > > other
> > > > > parts of NFSD's XDR functions are converted to machine-
> > > > > generated
> > > > > code.
> > > > >=20
> > > > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > > > ---
> > > > > =C2=A0fs/nfsd/nfs4_1.x=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 164 ++++++=
+++++++++++++++++++++++
> > > > > =C2=A0fs/nfsd/nfs4xdr_gen.c | 236
> > > > > ++++++++++++++++++++++++++++++++++++++++++
> > > > > =C2=A0fs/nfsd/nfs4xdr_gen.h | 113 ++++++++++++++++++++
> > > > > =C2=A03 files changed, 513 insertions(+)
> > > > > =C2=A0create mode 100644 fs/nfsd/nfs4_1.x
> > > > > =C2=A0create mode 100644 fs/nfsd/nfs4xdr_gen.c
> > > > > =C2=A0create mode 100644 fs/nfsd/nfs4xdr_gen.h
> > > > >=20
> > > >=20
> > > > I see the patches in your lkxdrgen branch. I gave this a try
> > > > and
> > > > started rebasing my delstid work on top of it, but I hit the
> > > > same
> > > > symbol conflicts I hit before once I started trying to include
> > > > the
> > > > full-blown nfs4xdr_gen.h header:
> > > >=20
> > > > ------------------------8<---------------------------
> > > > In file included from fs/nfsd/nfs4xdr.c:58:
> > > > fs/nfsd/nfs4xdr_gen.h:86:9: error: redeclaration of enumerator
> > > > =E2=80=98FATTR4_OPEN_ARGUMENTS=E2=80=99
> > > > =C2=A0=C2=A0 86 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 F=
ATTR4_OPEN_ARGUMENTS =3D 86
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~
> > > > In file included from fs/nfsd/nfsfh.h:15,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from fs/nfsd/state.h:41,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from fs/nfsd/xdr4.h:40,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from fs/nfsd/nfs4xdr.c:51:
> > > > ./include/linux/nfs4.h:518:9: note: previous definition of
> > > > =E2=80=98FATTR4_OPEN_ARGUMENTS=E2=80=99 with type =E2=80=98enum <an=
onymous>=E2=80=99
> > > > =C2=A0 518 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FATTR4=
_OPEN_ARGUMENTS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =3D 86,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~
> > > > fs/nfsd/nfs4xdr_gen.h:102:9: error: redeclaration of enumerator
> > > > =E2=80=98FATTR4_TIME_DELEG_ACCESS=E2=80=99
> > > > =C2=A0 102 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FATTR4=
_TIME_DELEG_ACCESS =3D 84
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~
> > > > ./include/linux/nfs4.h:516:9: note: previous definition of
> > > > =E2=80=98FATTR4_TIME_DELEG_ACCESS=E2=80=99 with type =E2=80=98enum =
<anonymous>=E2=80=99
> > > > =C2=A0 516 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FATTR4=
_TIME_DELEG_ACCESS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 84,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~
> > > > fs/nfsd/nfs4xdr_gen.h:106:9: error: redeclaration of enumerator
> > > > =E2=80=98FATTR4_TIME_DELEG_MODIFY=E2=80=99
> > > > =C2=A0 106 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FATTR4=
_TIME_DELEG_MODIFY =3D 85
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~
> > > > ./include/linux/nfs4.h:517:9: note: previous definition of
> > > > =E2=80=98FATTR4_TIME_DELEG_MODIFY=E2=80=99 with type =E2=80=98enum =
<anonymous>=E2=80=99
> > > > =C2=A0 517 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FATTR4=
_TIME_DELEG_MODIFY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 85,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~
> > > > ------------------------8<---------------------------
> > > >=20
> > > > I'm not sure of the best way to work around this, unless we
> > > > want to
> > > > try
> > > > to split up nfs4.h.
> > >=20
> > > That header is shared with the client, so I consider it immutable
> > > for our purposes here.
> > >=20
> > >=20
> > > One option would be to namespace the generated data items. Eg,
> > > name
> > > them:
> > >=20
> > > 	XG_FATTR4_TIME_DELEG_ACCESS
> > > 	XG_FATTR4_TIME_DELEG_MODIFY
> > >=20
> > > That way they don't conflict with existing definitions.
> > >=20
> >=20
> > I'd rather avoid that if we can. Having things named exactly the
> > same
> > as in the spec makes the code easier to read and understand.
>=20
> Agreed, matching names is one of the reasons I started this work.
>=20
> My thought was that the prefixed names could be fixed eventually
> after the hand-rolled code has been replaced.
>=20
>=20
> > What might be best is to autogenerate a header from a (combined)
> > nfs4.x, and then have the old nfs4.h file include it. Then we'd
> > just
> > have to eliminate anything from nfs4.h that conflicts with the
> > autogenerated symbols.
> >=20
> > That's definitely not treating include/linux/nfs4.h as immutable,
> > but
> > we might still be able to avoid a lot of changes to the client code
> > that way.
>=20
> Include the current nfs4xdr_gen.h in nfs4.h, and then remove from
> nfs4.h anything that has a naming conflict?
>=20
> The downside of that is that approach mixes generated and
> hand-rolled code. Not an objection from me, but it was something
> that made Neil uncomfortable.
>=20

Not exactly. The hand-rolled code would become dependent on the
generated headers, but we shouldn't need make changes to the generated
headers themselves.

>=20
> > We'd need Trond and Anna to buy in on that though.
>=20
> Or the client can continue to use include/linux/nfs4.h and the
> server can start using its own copy of that header.
>=20

Sure, that would work too.
--=20
Jeff Layton <jlayton@kernel.org>

