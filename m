Return-Path: <linux-nfs+bounces-5477-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6A49586C4
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2024 14:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB81285B7A
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2024 12:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A707E18F2C8;
	Tue, 20 Aug 2024 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEWsXL+w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBC118C32C;
	Tue, 20 Aug 2024 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724156289; cv=none; b=k+nbNqv9yMwukcQj2bkdfcuv5tjgELvgQ3JF3Q3ErdRoq9bDsAFQz13YBfEsnEHdTDu+ITsXMNegds60FWu9zt0MRLoQfGS+c6/6q+7xH+HQ0kn3Dv5aZ9zD3mCfgP0Koh/GvAwjxB089KdgwiQ2OiKSrwykSMbQxIUusu4r3nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724156289; c=relaxed/simple;
	bh=2tz6JBwLfmo97sCovyCNhqPS3xvG5/oolyUm6tMrAM8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ivfWNl22Tdjth+GwX7MM4GEuiLvlTB0nvErDH0C4rwNXF+UupbhRVpBu6supSUmRn/cuRRHDkpJlJDeVQRad12A+OFUcnbsKDLOkpqyF6FVfo9UbFUxMEtS0yLTkHbGaKfSqL0T8Q67FEVzWq92fyZiicdi9cpp36L+OiE3ZgLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEWsXL+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA66C4AF09;
	Tue, 20 Aug 2024 12:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724156289;
	bh=2tz6JBwLfmo97sCovyCNhqPS3xvG5/oolyUm6tMrAM8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=YEWsXL+wgdxNdg0o8XhHUzqTuVU+Pk84hM/FkF1mWuES3LY7ThQdfM8F7ln1nYXK+
	 lZjtughdS8K853O8HIZ3eFnv1GgIAETAAvaVVOjPaU2loDXrikbse35L5q87srdfoC
	 rCBToqWXOxWHGcPDvJEs8rYNoGr5jUCc8NeZiGQEFP8n0MKBxsWC4BSamHoYIsXW1s
	 Dun8dMQYeNofWjbGEpAODNrN2U2WvbrvZvdb9u/PN5PJmN0wBqvXuysS7H438MZfMT
	 t1IFgw19KZmTMpX8hkiQZMEmLn1mFZTQPttTAZ8a5BxQH9F/KVmtEeO8Fksqyegvm2
	 XNyTVgZokOsZw==
Message-ID: <256c6f2e83da546da98ca5386bd27c9dc0bbd0b1.camel@kernel.org>
Subject: Re: [PATCH 1/3] nfsd: bring in support for delstid draft XDR
 encoding
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Neil Brown <neilb@suse.de>, Dai Ngo <dai.ngo@oracle.com>, Olga
 Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>, Trond
 Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Tom
 Haynes <loghyr@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>,  Linux NFS Mailing List
 <linux-nfs@vger.kernel.org>
Date: Tue, 20 Aug 2024 08:18:07 -0400
In-Reply-To: <B222389A-F6FA-4090-B420-A9DDCD454139@oracle.com>
References: <20240816-delstid-v1-0-c221c3dc14cd@kernel.org>
	 <20240816-delstid-v1-1-c221c3dc14cd@kernel.org>
	 <172402584064.6062.2891331764461009092@noble.neil.brown.name>
	 <6c5af6011ea9adfd45abe4b5252af7319a3dbc94.camel@kernel.org>
	 <E7E5447E-AD50-437D-8069-C77FFF516DCE@oracle.com>
	 <f0ac4b0489da5f6198cb7c70f312e2889e97ea4e.camel@kernel.org>
	 <3DB9A299-B55F-45BB-8B28-65F44F14F6A2@oracle.com>
	 <b7d76076fe593b0c24ce983db9a0dbacc9fbfa5d.camel@kernel.org>
	 <B222389A-F6FA-4090-B420-A9DDCD454139@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-08-19 at 23:16 +0000, Chuck Lever III wrote:
>=20
> > On Aug 19, 2024, at 4:04=E2=80=AFPM, Jeff Layton <jlayton@kernel.org> w=
rote:
> >=20
> > On Mon, 2024-08-19 at 19:50 +0000, Chuck Lever III wrote:
> > >=20
> > >=20
> > > > On Aug 19, 2024, at 9:26=E2=80=AFAM, Jeff Layton <jlayton@kernel.or=
g>
> > > > wrote:
> > > >=20
> > > > I'm playing with the new version now and it seems to be much
> > > > improved.
> > > > Only two real bugs I've hit at this point:
> > > >=20
> > > > 1/ Some of the struct specifications need to be typedefs as well.
> > > > For
> > > > instance, the delstid draft refers to "nfstime4", but the
> > > > autogenerated
> > > > struct definition doesn't have the typedef for it. It may be best
> > > > to
> > > > just add typedefs for all of these sorts of structs.
> > >=20
> > > What's the specific symptom? I've been able to catenate nfs4_1.x
> > > and delstid.x, xdrgen builds the header and source without tossing
> > > any exceptions, and gcc compiles it without complaint.
> > >=20
> >=20
> >=20
> > Basically, I was getting this when I'd convert nfs4_1.x to a header:
> >=20
> > struct nfstime4 {
> >        int64_t seconds;
> >        uint32_t nseconds;
> > };
> >=20
> > ...but the delstid header has these:
> >=20
> > typedef nfstime4 fattr4_time_deleg_access;
> >=20
> > typedef nfstime4 fattr4_time_deleg_modify;
> >=20
> >=20
> > ...nothing defined nfstime4 in this case.
> >=20
> > > AFAICT, xdrgen will add "struct" where it's necessary.
> > >=20
> > > I've been squirrelly about using "typedef" too often because
> > > the Linux kernel's coding style is to avoid C typedefs for
> > > shorthand structure names.
> > >=20
> >=20
> > Oh, ok. I didn't concatenate the files like you did and just generated
> > the delstid files separately from the nfs4_1 ones. I guess that throws
> > off the dependency tracking that you're doing here for typedefs.
>=20
> cat'ing the two files together is the spec-recommended approach,
> but it assumes you're generating the whole protocol at once.
> Here it was just a quick and dirty way for me to build a
> reproducer.
>=20
> For an initial fs/nfsd/nfs4_1.x file, I recommend starting with
> delstid.x, and then add the pieces of the NFSv4_1 XDR until
> xdrgen and gcc can make proper sense of it.
>=20
> I can take a stab at that if you like, and send you something
> tomorrow?
>=20

I think that will probably fix the problem I was having before. I'll
respin that part of the set soon. It's probably better that I do it so
I figure this out. This is the "easy" XDR vs. CB_NOTIFY.

>=20
> Sidebar: We could go with all typedefs for structs, unions, and
> enums. That would make C code generation easier. Something like:
>=20
> typedef struct {
> 	int64_t seconds;
> 	uint32_t nseconds;
> } nfstime4;
>=20
> But like I said, I expect that approach might be frowned upon.
>=20

Agreed. I don't think it's needed. I was just using the tool wrong
before.

Thanks,

>=20
> > > > 2/ xdrgen_encode_nfstime4 want a pointer to the nfstime4, but the
> > > > autogenerated code for xdrgen_encode_fattr4_time_deleg_access and
> > > > xdrgen_encode_fattr4_time_deleg_modify try to pass it by value
> > > > instead.
> > >=20
> > > Here's my generated copy of xdrgen_encode_fattr_time_deleg_access:
> > >=20
> > > /* typedef fattr4_time_deleg_access */
> > > static bool
> > > __maybe_unused                                                    =
=20
> > > xdrgen_encode_fattr4_time_deleg_access(struct xdr_stream *xdr, const
> > > fattr4_time_deleg_access value)
> > > {
> > > /* (basic) */
> > > return xdrgen_encode_nfstime4(xdr, &value);
> > > };
> > >=20
> > > Looks like it does the right thing...?
> >=20
> > Probably another side-effect of it not knowing what to do with nfstime4
> > when I convert the delstid draft. Concatenating them seems unwieldy but
> > I guess that would work. I do like being able to keep generated code
> > from different files separate though.
>=20
> I don't think cat'ing the .x files is /required/, but it was a
> quick way to get started.
>=20
> Having a working nfs4_1.x that can generate the small piece of
> XDR code that we need, in a separate file that can be augmented
> over time, I think, is a win. I don't see that anything so far
> is preventing that.
>=20
> --
> Chuck Lever
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

