Return-Path: <linux-nfs+bounces-5416-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A0D954E16
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Aug 2024 17:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C45286FC6
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Aug 2024 15:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813891B9B25;
	Fri, 16 Aug 2024 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqPYRkJe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB5C4174C;
	Fri, 16 Aug 2024 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723823135; cv=none; b=OXE1byeT2mwyjmo8UUl/cRBcom00ARO1QU9sZ0h7KEjWEh4+O2QbiRxiwSzxplFhHaPL8kbsLok2dyA9x2KMlgEoB6B/eDoOiwJzQhpHvO9uZcCcL0jHSdC1nxajtuuOUhvPR8NVtSTHP9uYWsJxvSJGYmYsX2gSNyfS5cpqE00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723823135; c=relaxed/simple;
	bh=gXvzKQ05iOb272j5lsXx/xuLMOZmROev4aJadGAo1Mk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ASeNv9rOFz661KosCJRQX/NUxsX0BO8uZ10QFWQ3Ug9DUovo1c83REAe1+oVJXTim9Aq+38Dfu0/qhfWPcqxTYXgBuTELKqGmyfq8P2EaoMSJO3rrdEndVlXnJlrpbbtoMog5PozNIFlZVq9yY3iL8ux3FqO4mSYafTNxwleKq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqPYRkJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE13C32782;
	Fri, 16 Aug 2024 15:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723823134;
	bh=gXvzKQ05iOb272j5lsXx/xuLMOZmROev4aJadGAo1Mk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=qqPYRkJeMABHdJutBnBXPJkxs2xNQfSj2Ik2SE56CYfo/iN0MceI1yiHf2Go6ZYIu
	 GtBSSdJf5orKwi1OmrRV0ZJZ1m7focS/qmfVw3vyyLX0nRMcIcda8O1/rBeai8Zs51
	 TEZn/03rXB9068SvLZwS+TXPtbWd8R8efagZZXdUxY3sLF8DT2inzRtZ18CWwkLJ9u
	 d6GUCdTTauJG7Zmx9j+kjTnb+0bLpe6vOu9VXfo14QjhJBpODC4KUXbpBLakHF8D/6
	 tCtFZkFg6fASQ2R7lgAGVfxus6lfEgZtaNbQPhWjxc07W6d7IIgA2VRsFZOg5jEaN3
	 7HviFeVzA442w==
Message-ID: <f51cc300fe6be795d8d77b39a0218317bf6f9522.camel@kernel.org>
Subject: Re: [PATCH 1/3] nfsd: bring in support for delstid draft XDR
 encoding
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai
 Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Trond Myklebust
 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Tom Haynes
 <loghyr@gmail.com>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Date: Fri, 16 Aug 2024 11:45:32 -0400
In-Reply-To: <Zr9thPcPcqYQuXed@tissot.1015granger.net>
References: <20240816-delstid-v1-0-c221c3dc14cd@kernel.org>
	 <20240816-delstid-v1-1-c221c3dc14cd@kernel.org>
	 <Zr9thPcPcqYQuXed@tissot.1015granger.net>
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

On Fri, 2024-08-16 at 11:17 -0400, Chuck Lever wrote:
> On Fri, Aug 16, 2024 at 08:42:07AM -0400, Jeff Layton wrote:
> > This adds support for the "delstid" draft:
> >=20
> > =C2=A0=C2=A0=C2=A0 https://datatracker.ietf.org/doc/draft-ietf-nfsv4-de=
lstid/05/
> >=20
> > Most of this was autogenerated using Chuck's lkxdrgen tool with
> > some
> > by-hand tweaks to work around some symbol conflicts, and to add
> > some
> > missing pieces that were needed from nfs4_1.x.
>=20
> I haven't read delstid closely enough to comment on the approach
> you've taken in 3/3, but I do have some thoughts about code
> organization here. I will try to study that draft soon.
>=20
> And, I'm assuming you are continuing to evolve support for the draft
> and will be growing this series. So I will hold off on careful
> inspection of 3/3 for the moment.
>=20

Yes. The client pieces are already in place, and I read I get is that
the draft is all but done at this point. 3/3 is probably pretty close
to what should go in. There are really 3 parts to the delstid draft:

1/ the OPEN_XOR_DELEGATION part, which allows the server to avoid
giving out an open stateid when giving out a deleg.

2/ delegated timestamp support (which is the part I'm still looking at)

3/ FATTR4_OPEN_ARGUMENTS (which enables 1 and 2)

This patchset encompasses 1 & 3. Part 2 shouldn't have much bearing on
this set. It's really a separate feature entirely that just happens to
also depend on FATTR4_OPEN_ARGUMENTS support.

> First, I'm pleased that you found xdrgen useful for rapid
> prototyping. That's not something I had envisioned when I created
> the tool, but it's a good match, looks like.
>=20

Yeah. It has some bugs that still need fixing, but it was certainly
better than having to roll all of that by hand.

> Here you add a separate set of source files for delstid XDR...=C2=A0 That
> approach might not be scalable for adding subsequent new features in
> general, it occurs to me.
>
> We might end up with a bunch of these little code blurbs with no
> clear understanding of how they inter-relate.=C2=A0 Thoughts about how to
> manage these are welcome: xdrgen could generate only header files
> and then we would #include them where needed, for example.
>
> For now, I suggest folding the new generated XDR code into the
> existing NFSv4 "open" XDR code in fs/nfsd/nfs4xdr.c, when you have
> some time for cleaning up the patches. An alternative would be to
> leave it and I can fold these together before committing.
>=20
> (The long term, of course, will hopefully be generating all XDR code
> automatically, but we're a ways out from that, IMO).
>=20

This is where I disagree.

The nice thing about lkxdrgen is that most of what it generates is
fairly self-contained. I think we ought to try to keep the new (mostly
autogenerated) and old code (hand-rolled) separate for now.

I'm not sure what makes the most sense for a new naming scheme, but I
really don't think we should paste all of this into nfs4xdr.c, which is
just a huge jumble of hand-rolled XDR code.=20

> The generator adds __maybe_unused to some of these functions to
> avoid having to reason about which encoders/decoders are not needed.
> It assumes the C compiler will simply not generate machine code for
> unused functions.
>=20
> But that clutters the source code if you plan to mix it with hand-
> written code. You might remove that decorator to identify the
> functions that are actually not used by your implementation.
>=20

Yeah, I was planning to remove all of the __maybe_unused designations
once I had timestamp delegation support in place. Some of them can
certainly go away in advance of that though.

> ----
>=20
> On an unrelated note, do you know of a plan to add delstid-related
> unit tests to pynfs ?
>=20

No. That would be nice to have, but I'm not aware of anyone working on
it.

>=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > =C2=A0fs/nfsd/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> > =C2=A0fs/nfsd/delstid_xdr.c | 464
> > ++++++++++++++++++++++++++++++++++++++++++++++++++
> > =C2=A0fs/nfsd/delstid_xdr.h | 102 +++++++++++
> > =C2=A0fs/nfsd/nfs4xdr.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A04 files changed, 568 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> > index b8736a82e57c..187fa45640e6 100644
> > --- a/fs/nfsd/Makefile
> > +++ b/fs/nfsd/Makefile
> > @@ -18,7 +18,7 @@ nfsd-$(CONFIG_NFSD_V2) +=3D nfsproc.o nfsxdr.o
> > =C2=A0nfsd-$(CONFIG_NFSD_V2_ACL) +=3D nfs2acl.o
> > =C2=A0nfsd-$(CONFIG_NFSD_V3_ACL) +=3D nfs3acl.o
> > =C2=A0nfsd-$(CONFIG_NFSD_V4)	+=3D nfs4proc.o nfs4xdr.o nfs4state.o
> > nfs4idmap.o \
> > -			=C2=A0=C2=A0 nfs4acl.o nfs4callback.o nfs4recover.o
> > +			=C2=A0=C2=A0 nfs4acl.o nfs4callback.o nfs4recover.o
> > delstid_xdr.o
> > =C2=A0nfsd-$(CONFIG_NFSD_PNFS) +=3D nfs4layouts.o
> > =C2=A0nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) +=3D blocklayout.o blocklayoutxdr=
.o
> > =C2=A0nfsd-$(CONFIG_NFSD_SCSILAYOUT) +=3D blocklayout.o blocklayoutxdr.=
o
> > diff --git a/fs/nfsd/delstid_xdr.c b/fs/nfsd/delstid_xdr.c
> > new file mode 100644
> > index 000000000000..63494d14f5d2
> > --- /dev/null
> > +++ b/fs/nfsd/delstid_xdr.c
> > @@ -0,0 +1,464 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Generated by lkxdrgen, with hand-edits.
> > +// XDR specification modification time: Wed Aug 14 13:35:03 2024
> > +
> > +#include "delstid_xdr.h"
> > +
> > +static inline bool
> > +xdrgen_decode_void(struct xdr_stream *xdr)
> > +{
> > +	return true;
> > +}
> > +
> > +static inline bool
> > +xdrgen_decode_bool(struct xdr_stream *xdr, bool *ptr)
> > +{
> > +	__be32 *p =3D xdr_inline_decode(xdr, XDR_UNIT);
> > +
> > +	if (unlikely(!p))
> > +		return false;
> > +	*ptr =3D (*p !=3D xdr_zero);
> > +	return true;
> > +}
> > +
> > +static inline bool
> > +xdrgen_decode_int(struct xdr_stream *xdr, s32 *ptr)
> > +{
> > +	__be32 *p =3D xdr_inline_decode(xdr, XDR_UNIT);
> > +
> > +	if (unlikely(!p))
> > +		return false;
> > +	*ptr =3D be32_to_cpup(p);
> > +	return true;
> > +}
> > +
> > +static inline bool
> > +xdrgen_decode_unsigned_int(struct xdr_stream *xdr, u32 *ptr)
> > +{
> > +	__be32 *p =3D xdr_inline_decode(xdr, XDR_UNIT);
> > +
> > +	if (unlikely(!p))
> > +		return false;
> > +	*ptr =3D be32_to_cpup(p);
> > +	return true;
> > +}
> > +
> > +static inline bool
> > +xdrgen_decode_uint32_t(struct xdr_stream *xdr, u32 *ptr)
> > +{
> > +	return xdrgen_decode_unsigned_int(xdr, ptr);
> > +}
> > +
> > +static inline bool
> > +xdrgen_decode_long(struct xdr_stream *xdr, s32 *ptr)
> > +{
> > +	__be32 *p =3D xdr_inline_decode(xdr, XDR_UNIT);
> > +
> > +	if (unlikely(!p))
> > +		return false;
> > +	*ptr =3D be32_to_cpup(p);
> > +	return true;
> > +}
> > +
> > +static inline bool
> > +xdrgen_decode_unsigned_long(struct xdr_stream *xdr, u32 *ptr)
> > +{
> > +	__be32 *p =3D xdr_inline_decode(xdr, XDR_UNIT);
> > +
> > +	if (unlikely(!p))
> > +		return false;
> > +	*ptr =3D be32_to_cpup(p);
> > +	return true;
> > +}
> > +
> > +static inline bool
> > +xdrgen_decode_hyper(struct xdr_stream *xdr, s64 *ptr)
> > +{
> > +	__be32 *p =3D xdr_inline_decode(xdr, XDR_UNIT * 2);
> > +
> > +	if (unlikely(!p))
> > +		return false;
> > +	*ptr =3D get_unaligned_be64(p);
> > +	return true;
> > +}
> > +
> > +static inline bool
> > +xdrgen_decode_int64_t(struct xdr_stream *xdr, s64 *ptr)
> > +{
> > +	return xdrgen_decode_hyper(xdr, ptr);
> > +}
> > +
> > +static inline bool
> > +xdrgen_decode_unsigned_hyper(struct xdr_stream *xdr, u64 *ptr)
> > +{
> > +	__be32 *p =3D xdr_inline_decode(xdr, XDR_UNIT * 2);
> > +
> > +	if (unlikely(!p))
> > +		return false;
> > +	*ptr =3D get_unaligned_be64(p);
> > +	return true;
> > +}
> > +
> > +static bool __maybe_unused
> > +xdrgen_decode_opaque(struct xdr_stream *xdr, opaque *ptr, u32
> > maxlen)
> > +{
> > +	__be32 *p;
> > +	u32 len;
> > +
> > +	if (unlikely(xdr_stream_decode_u32(xdr, &len) !=3D
> > XDR_UNIT))
> > +		return false;
> > +	if (unlikely(maxlen && len > maxlen))
> > +		return false;
> > +	if (len !=3D 0) {
> > +		p =3D xdr_inline_decode(xdr, len);
> > +		if (unlikely(!p))
> > +			return false;
> > +		ptr->data =3D (u8 *)p;
> > +	}
> > +	ptr->len =3D len;
> > +	return true;
> > +}
> > +
> > +static bool __maybe_unused
> > +xdrgen_decode_string(struct xdr_stream *xdr, string *ptr, u32
> > maxlen)
> > +{
> > +	__be32 *p;
> > +	u32 len;
> > +
> > +	if (unlikely(xdr_stream_decode_u32(xdr, &len) !=3D
> > XDR_UNIT))
> > +		return false;
> > +	if (unlikely(maxlen && len > maxlen))
> > +		return false;
> > +	if (len !=3D 0) {
> > +		p =3D xdr_inline_decode(xdr, len);
> > +		if (unlikely(!p))
> > +			return false;
> > +		ptr->data =3D (unsigned char *)p;
> > +	}
> > +	ptr->len =3D len;
> > +	return true;
> > +}
> > +
> > +static inline bool
> > +xdrgen_encode_void(struct xdr_stream *xdr)
> > +{
> > +	return true;
> > +}
> > +
> > +static inline bool
> > +xdrgen_encode_bool(struct xdr_stream *xdr, bool val)
> > +{
> > +	__be32 *p =3D xdr_reserve_space(xdr, XDR_UNIT);
> > +
> > +	if (unlikely(!p))
> > +		return false;
> > +	*p =3D val ? xdr_one : xdr_zero;
> > +	return true;
> > +}
> > +
> > +static inline bool
> > +xdrgen_encode_int(struct xdr_stream *xdr, s32 val)
> > +{
> > +	__be32 *p =3D xdr_reserve_space(xdr, XDR_UNIT);
> > +
> > +	if (unlikely(!p))
> > +		return false;
> > +	*p =3D cpu_to_be32(val);
> > +	return true;
> > +}
> > +
> > +static inline bool
> > +xdrgen_encode_unsigned_int(struct xdr_stream *xdr, u32 val)
> > +{
> > +	__be32 *p =3D xdr_reserve_space(xdr, XDR_UNIT);
> > +
> > +	if (unlikely(!p))
> > +		return false;
> > +	*p =3D cpu_to_be32(val);
> > +	return true;
> > +}
> > +
> > +static inline bool
> > +xdrgen_encode_uint32_t(struct xdr_stream *xdr, u32 val)
> > +{
> > +	return xdrgen_encode_unsigned_int(xdr, val);
> > +}
> > +
> > +static inline bool
> > +xdrgen_encode_long(struct xdr_stream *xdr, s32 val)
> > +{
> > +	__be32 *p =3D xdr_reserve_space(xdr, XDR_UNIT);
> > +
> > +	if (unlikely(!p))
> > +		return false;
> > +	*p =3D cpu_to_be32(val);
> > +	return true;
> > +}
> > +
> > +static inline bool
> > +xdrgen_encode_unsigned_long(struct xdr_stream *xdr, u32 val)
> > +{
> > +	__be32 *p =3D xdr_reserve_space(xdr, XDR_UNIT);
> > +
> > +	if (unlikely(!p))
> > +		return false;
> > +	*p =3D cpu_to_be32(val);
> > +	return true;
> > +}
> > +
> > +static inline bool
> > +xdrgen_encode_hyper(struct xdr_stream *xdr, s64 val)
> > +{
> > +	__be32 *p =3D xdr_reserve_space(xdr, XDR_UNIT * 2);
> > +
> > +	if (unlikely(!p))
> > +		return false;
> > +	put_unaligned_be64(val, p);
> > +	return true;
> > +}
> > +
> > +static inline bool
> > +xdrgen_encode_int64_t(struct xdr_stream *xdr, s64 val)
> > +{
> > +	return xdrgen_encode_hyper(xdr, val);
> > +}
> > +
> > +static inline bool
> > +xdrgen_encode_unsigned_hyper(struct xdr_stream *xdr, u64 val)
> > +{
> > +	__be32 *p =3D xdr_reserve_space(xdr, XDR_UNIT * 2);
> > +
> > +	if (unlikely(!p))
> > +		return false;
> > +	put_unaligned_be64(val, p);
> > +	return true;
> > +}
> > +
> > +static bool __maybe_unused
> > +xdrgen_encode_opaque(struct xdr_stream *xdr, opaque val)
> > +{
> > +	__be32 *p =3D xdr_reserve_space(xdr, XDR_UNIT +
> > xdr_align_size(val.len));
> > +
> > +	if (unlikely(!p))
> > +		return false;
> > +	xdr_encode_opaque(p, val.data, val.len);
> > +	return true;
> > +}
> > +
> > +static bool __maybe_unused
> > +xdrgen_encode_string(struct xdr_stream *xdr, string val, u32
> > maxlen)
> > +{
> > +	__be32 *p =3D xdr_reserve_space(xdr, XDR_UNIT +
> > xdr_align_size(val.len));
> > +
> > +	if (unlikely(!p))
> > +		return false;
> > +	xdr_encode_opaque(p, val.data, val.len);
> > +	return true;
> > +}
> > +
> > +static bool __maybe_unused
> > +xdrgen_decode_fattr4_offline(struct xdr_stream *xdr,
> > fattr4_offline *ptr)
> > +{
> > +	return xdrgen_decode_bool(xdr, ptr);
> > +};
> > +
> > +static bool __maybe_unused
> > +xdrgen_decode_bitmap4(struct xdr_stream *xdr, bitmap4 *ptr)
> > +{
> > +	if (xdr_stream_decode_u32(xdr, &ptr->count) < 0)
> > +		return false;
> > +	for (u32 i =3D 0; i < ptr->count; i++)
> > +		if (!xdrgen_decode_uint32_t(xdr, &ptr-
> > >element[i]))
> > +			return false;
> > +	return true;
> > +};
> > +
> > +static bool __maybe_unused
> > +xdrgen_decode_open_arguments4(struct xdr_stream *xdr, struct
> > open_arguments4 *ptr)
> > +{
> > +	if (!xdrgen_decode_bitmap4(xdr, &ptr->oa_share_access))
> > +		return false;
> > +	if (!xdrgen_decode_bitmap4(xdr, &ptr->oa_share_deny))
> > +		return false;
> > +	if (!xdrgen_decode_bitmap4(xdr, &ptr-
> > >oa_share_access_want))
> > +		return false;
> > +	if (!xdrgen_decode_bitmap4(xdr, &ptr->oa_open_claim))
> > +		return false;
> > +	if (!xdrgen_decode_bitmap4(xdr, &ptr->oa_create_mode))
> > +		return false;
> > +	return true;
> > +};
> > +
> > +static bool __maybe_unused
> > +xdrgen_decode_open_args_share_access4(struct xdr_stream *xdr, enum
> > open_args_share_access4 *ptr)
> > +{
> > +	u32 val;
> > +
> > +	if (xdr_stream_decode_u32(xdr, &val) < 0)
> > +		return false;
> > +	*ptr =3D val;
> > +	return true;
> > +}
> > +
> > +static bool __maybe_unused
> > +xdrgen_decode_open_args_share_deny4(struct xdr_stream *xdr, enum
> > open_args_share_deny4 *ptr)
> > +{
> > +	u32 val;
> > +
> > +	if (xdr_stream_decode_u32(xdr, &val) < 0)
> > +		return false;
> > +	*ptr =3D val;
> > +	return true;
> > +}
> > +
> > +static bool __maybe_unused
> > +xdrgen_decode_open_args_share_access_want4(struct xdr_stream *xdr,
> > enum open_args_share_access_want4 *ptr)
> > +{
> > +	u32 val;
> > +
> > +	if (xdr_stream_decode_u32(xdr, &val) < 0)
> > +		return false;
> > +	*ptr =3D val;
> > +	return true;
> > +}
> > +
> > +static bool __maybe_unused
> > +xdrgen_decode_open_args_open_claim4(struct xdr_stream *xdr, enum
> > open_args_open_claim4 *ptr)
> > +{
> > +	u32 val;
> > +
> > +	if (xdr_stream_decode_u32(xdr, &val) < 0)
> > +		return false;
> > +	*ptr =3D val;
> > +	return true;
> > +}
> > +
> > +static bool __maybe_unused
> > +xdrgen_decode_open_args_createmode4(struct xdr_stream *xdr, enum
> > open_args_createmode4 *ptr)
> > +{
> > +	u32 val;
> > +
> > +	if (xdr_stream_decode_u32(xdr, &val) < 0)
> > +		return false;
> > +	*ptr =3D val;
> > +	return true;
> > +}
> > +
> > +static bool __maybe_unused
> > +xdrgen_decode_fattr4_open_arguments(struct xdr_stream *xdr,
> > fattr4_open_arguments *ptr)
> > +{
> > +	return xdrgen_decode_open_arguments4(xdr, ptr);
> > +};
> > +
> > +static bool __maybe_unused
> > +xdrgen_decode_nfstime4(struct xdr_stream *xdr, struct _nfstime4
> > *ptr)
> > +{
> > +	if (!xdrgen_decode_int64_t(xdr, &ptr->seconds))
> > +		return false;
> > +	if (!xdrgen_decode_uint32_t(xdr, &ptr->nseconds))
> > +		return false;
> > +	return true;
> > +};
> > +
> > +static bool __maybe_unused
> > +xdrgen_decode_fattr4_time_deleg_access(struct xdr_stream *xdr,
> > fattr4_time_deleg_access *ptr)
> > +{
> > +	return xdrgen_decode_nfstime4(xdr, ptr);
> > +};
> > +
> > +static bool __maybe_unused
> > +xdrgen_decode_fattr4_time_deleg_modify(struct xdr_stream *xdr,
> > fattr4_time_deleg_modify *ptr)
> > +{
> > +	return xdrgen_decode_nfstime4(xdr, ptr);
> > +};
> > +
> > +static bool __maybe_unused
> > +xdrgen_encode_fattr4_offline(struct xdr_stream *xdr, const
> > fattr4_offline value)
> > +{
> > +	return xdrgen_encode_bool(xdr, value);
> > +};
> > +
> > +static bool __maybe_unused
> > +xdrgen_encode_bitmap4(struct xdr_stream *xdr, const bitmap4 value)
> > +{
> > +	if (xdr_stream_encode_u32(xdr, value.count) !=3D XDR_UNIT)
> > +		return false;
> > +	for (u32 i =3D 0; i < value.count; i++)
> > +		if (!xdrgen_encode_uint32_t(xdr,
> > value.element[i]))
> > +			return false;
> > +	return true;
> > +};
> > +
> > +static bool __maybe_unused
> > +xdrgen_encode_open_arguments4(struct xdr_stream *xdr, const struct
> > open_arguments4 *value)
> > +{
> > +	if (!xdrgen_encode_bitmap4(xdr, value->oa_share_access))
> > +		return false;
> > +	if (!xdrgen_encode_bitmap4(xdr, value->oa_share_deny))
> > +		return false;
> > +	if (!xdrgen_encode_bitmap4(xdr, value-
> > >oa_share_access_want))
> > +		return false;
> > +	if (!xdrgen_encode_bitmap4(xdr, value->oa_open_claim))
> > +		return false;
> > +	if (!xdrgen_encode_bitmap4(xdr, value->oa_create_mode))
> > +		return false;
> > +	return true;
> > +};
> > +
> > +static bool __maybe_unused
> > +xdrgen_encode_open_args_share_access4(struct xdr_stream *xdr, enum
> > open_args_share_access4 value)
> > +{
> > +	return xdr_stream_encode_u32(xdr, value) =3D=3D XDR_UNIT;
> > +}
> > +
> > +static bool __maybe_unused
> > +xdrgen_encode_open_args_share_deny4(struct xdr_stream *xdr, enum
> > open_args_share_deny4 value)
> > +{
> > +	return xdr_stream_encode_u32(xdr, value) =3D=3D XDR_UNIT;
> > +}
> > +
> > +static bool __maybe_unused
> > +xdrgen_encode_open_args_share_access_want4(struct xdr_stream *xdr,
> > enum open_args_share_access_want4 value)
> > +{
> > +	return xdr_stream_encode_u32(xdr, value) =3D=3D XDR_UNIT;
> > +}
> > +
> > +static bool __maybe_unused
> > +xdrgen_encode_open_args_open_claim4(struct xdr_stream *xdr, enum
> > open_args_open_claim4 value)
> > +{
> > +	return xdr_stream_encode_u32(xdr, value) =3D=3D XDR_UNIT;
> > +}
> > +
> > +static bool __maybe_unused
> > +xdrgen_encode_open_args_createmode4(struct xdr_stream *xdr, enum
> > open_args_createmode4 value)
> > +{
> > +	return xdr_stream_encode_u32(xdr, value) =3D=3D XDR_UNIT;
> > +}
> > +
> > +static bool __maybe_unused
> > +xdrgen_encode_fattr4_open_arguments(struct xdr_stream *xdr, const
> > fattr4_open_arguments *value)
> > +{
> > +	return xdrgen_encode_open_arguments4(xdr, value);
> > +};
> > +
> > +static bool __maybe_unused
> > +xdrgen_encode_nfstime4(struct xdr_stream *xdr, const struct
> > _nfstime4 *value)
> > +{
> > +	if (!xdrgen_encode_int64_t(xdr, value->seconds))
> > +		return false;
> > +	if (!xdrgen_encode_uint32_t(xdr, value->nseconds))
> > +		return false;
> > +	return true;
> > +};
> > +
> > +static bool __maybe_unused
> > +xdrgen_encode_fattr4_time_deleg_access(struct xdr_stream *xdr,
> > const fattr4_time_deleg_access value)
> > +{
> > +	return xdrgen_encode_nfstime4(xdr, &value);
> > +};
> > +
> > +static bool __maybe_unused
> > +xdrgen_encode_fattr4_time_deleg_modify(struct xdr_stream *xdr,
> > const fattr4_time_deleg_modify value)
> > +{
> > +	return xdrgen_encode_nfstime4(xdr, &value);
> > +};
> > diff --git a/fs/nfsd/delstid_xdr.h b/fs/nfsd/delstid_xdr.h
> > new file mode 100644
> > index 000000000000..3ca8d0cc8569
> > --- /dev/null
> > +++ b/fs/nfsd/delstid_xdr.h
> > @@ -0,0 +1,102 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Generated by lkxdrgen, with hand edits. */
> > +/* XDR specification modification time: Wed Aug 14 13:35:03 2024
> > */
> > +
> > +#ifndef _DELSTID_H
> > +#define _DELSTID_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/sunrpc/xdr.h>
> > +#include <linux/sunrpc/svc.h>
> > +
> > +typedef struct {
> > +	u32 len;
> > +	unsigned char *data;
> > +} string;
> > +
> > +typedef struct {
> > +	u32 len;
> > +	u8 *data;
> > +} opaque;
> > +
> > +typedef struct {
> > +	u32 count;
> > +	uint32_t *element;
> > +} bitmap4;
> > +
> > +typedef struct _nfstime4 {
> > +	int64_t seconds;
> > +	uint32_t nseconds;
> > +} nfstime4;
> > +
> > +typedef bool fattr4_offline;
> > +
> > +#define FATTR4_OFFLINE (83)
> > +
> > +typedef struct open_arguments4 {
> > +	bitmap4 oa_share_access;
> > +	bitmap4 oa_share_deny;
> > +	bitmap4 oa_share_access_want;
> > +	bitmap4 oa_open_claim;
> > +	bitmap4 oa_create_mode;
> > +} open_arguments4;
> > +
> > +enum open_args_share_access4 {
> > +	OPEN_ARGS_SHARE_ACCESS_READ =3D 1,
> > +	OPEN_ARGS_SHARE_ACCESS_WRITE =3D 2,
> > +	OPEN_ARGS_SHARE_ACCESS_BOTH =3D 3,
> > +};
> > +
> > +enum open_args_share_deny4 {
> > +	OPEN_ARGS_SHARE_DENY_NONE =3D 0,
> > +	OPEN_ARGS_SHARE_DENY_READ =3D 1,
> > +	OPEN_ARGS_SHARE_DENY_WRITE =3D 2,
> > +	OPEN_ARGS_SHARE_DENY_BOTH =3D 3,
> > +};
> > +
> > +enum open_args_share_access_want4 {
> > +	OPEN_ARGS_SHARE_ACCESS_WANT_ANY_DELEG =3D 3,
> > +	OPEN_ARGS_SHARE_ACCESS_WANT_NO_DELEG =3D 4,
> > +	OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL =3D 5,
> > +	OPEN_ARGS_SHARE_ACCESS_WANT_SIGNAL_DELEG_WHEN_RESRC_AVAIL
> > =3D 17,
> > +	OPEN_ARGS_SHARE_ACCESS_WANT_PUSH_DELEG_WHEN_UNCONTENDED =3D
> > 18,
> > +	OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS =3D 20,
> > +	OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION =3D 21,
> > +};
> > +
> > +enum open_args_open_claim4 {
> > +	OPEN_ARGS_OPEN_CLAIM_NULL =3D 0,
> > +	OPEN_ARGS_OPEN_CLAIM_PREVIOUS =3D 1,
> > +	OPEN_ARGS_OPEN_CLAIM_DELEGATE_CUR =3D 2,
> > +	OPEN_ARGS_OPEN_CLAIM_DELEGATE_PREV =3D 3,
> > +	OPEN_ARGS_OPEN_CLAIM_FH =3D 4,
> > +	OPEN_ARGS_OPEN_CLAIM_DELEG_CUR_FH =3D 5,
> > +	OPEN_ARGS_OPEN_CLAIM_DELEG_PREV_FH =3D 6,
> > +};
> > +
> > +enum open_args_createmode4 {
> > +	OPEN_ARGS_CREATEMODE_UNCHECKED4 =3D 0,
> > +	OPEN_ARGS_CREATE_MODE_GUARDED =3D 1,
> > +	OPEN_ARGS_CREATEMODE_EXCLUSIVE4 =3D 2,
> > +	OPEN_ARGS_CREATE_MODE_EXCLUSIVE4_1 =3D 3,
> > +};
> > +
> > +typedef open_arguments4 fattr4_open_arguments;
> > +
> > +#define FATTR4_OPEN_ARGUMENTS (86)
> > +
> > +#define OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION (0x200000)
> > +
> > +#define OPEN4_RESULT_NO_OPEN_STATEID (0x00000010)
> > +
> > +typedef nfstime4 fattr4_time_deleg_access;
> > +
> > +typedef nfstime4 fattr4_time_deleg_modify;
> > +
> > +#define FATTR4_TIME_DELEG_ACCESS (84)
> > +
> > +#define FATTR4_TIME_DELEG_MODIFY (85)
> > +
> > +#define OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS (0x100000)
> > +
> > +#endif /* _DELSTID_H */
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index 643ca3f8ebb3..b3d2000c8a08 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -55,6 +55,7 @@
> > =C2=A0#include "netns.h"
> > =C2=A0#include "pnfs.h"
> > =C2=A0#include "filecache.h"
> > +#include "delstid_xdr.h"
> > =C2=A0
> > =C2=A0#include "trace.h"
> > =C2=A0
> >=20
> > --=20
> > 2.46.0
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

