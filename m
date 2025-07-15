Return-Path: <linux-nfs+bounces-13076-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C90C5B05970
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 13:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB4B4E29F4
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 11:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15522E3378;
	Tue, 15 Jul 2025 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSzuHI3a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CC92E3366
	for <linux-nfs@vger.kernel.org>; Tue, 15 Jul 2025 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580659; cv=none; b=NDxQzFByadR7ZVD9KJT0BNL1iSQCSSoZlI54JUuQ7STHXe20HAhXaEYi7bUW4ueSOw7Z9PG/wHdlh5LUfsCHrCv7lPV/rAeWJiDRAg6MlmSX8qj69UZLSr+NweszqhRbGl0Kwf0ZIkwfBrm43TmZDa6Ts1xiFgarvx9uZp7kzKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580659; c=relaxed/simple;
	bh=gI8v3SsRYspM6Pl3TWlr02a3n5x5jLVnyYIUCMpkwx4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XfFONrFWXJWvTsm9ySk2BaQngzjwwEY1QY3vFcSQfcrwiKw12Y6Ix8QYk0EPu42/r1JCv32OrDpXQTg07atz6ybt8G8R8af2O5rs/MApmmRCiZktY3TPSydsNeo95plS9sl5XyoYAxnLg8/KxAyWnblZXuInJKT5fkVmcXwvb+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSzuHI3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514D0C4CEFC;
	Tue, 15 Jul 2025 11:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752580659;
	bh=gI8v3SsRYspM6Pl3TWlr02a3n5x5jLVnyYIUCMpkwx4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NSzuHI3aX99zLfUnrb6hmeg//9CgweQRV5WEk3JGGa2soU5Ahc1rFtc4YBHRferAN
	 T9Mh4UPqIQFjJ+Qqtf2OkhAuR3tBQpvIOM9IVzdQv4qKrfa7o2xL9r/xxlufkFoTiS
	 DE6TP3XAtq6gOdKEgQ4uCxNxhl2siD2L4qZEFDK4ZoE6FwIQqXVDZPC9K9mxhi9LKM
	 5e4cRyEU2yZuSN7g/7rbnk3Jr0c6EAlqK5n0ExVUwauqKCFVkqWUDDXu8YSbFwRF3K
	 vfkZEesW9KcL8uq8BlWd+XPdUxf/QWutTMFAFziJvfTxZ0Yia8EqTWrJX08+M3kNXZ
	 o18lyVyo+dFjg==
Message-ID: <44afdba79f4ea9f6424840b236bc2d61ea51ad33.camel@kernel.org>
Subject: Re: [RFC PATCH v2 6/8] NFSD: add io_cache_read controls to debugfs
 interface
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Trond Myklebust
 <trondmy@kernel.org>,  Anna Schumaker	 <anna@kernel.org>,
 linux-nfs@vger.kernel.org, linus-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Date: Tue, 15 Jul 2025 07:57:37 -0400
In-Reply-To: <aHU0qcrxvmcp0hom@kernel.org>
References: <20250708160619.64800-1-snitzer@kernel.org>
	 <20250708160619.64800-7-snitzer@kernel.org>
	 <e5a0d1e435196c55acbdc491b43b6380cbef5599.camel@kernel.org>
	 <6a05d14f-dbf6-4786-ba08-c57f8f4c64e6@oracle.com>
	 <aHU0qcrxvmcp0hom@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-14 at 12:47 -0400, Mike Snitzer wrote:
> On Thu, Jul 10, 2025 at 06:46:37PM -0400, Chuck Lever wrote:
> > On 7/10/25 10:06 AM, Jeff Layton wrote:
> > > On Tue, 2025-07-08 at 12:06 -0400, Mike Snitzer wrote:
> > > > Add 'io_cache_read' to NFSD's debugfs interface so that: Any data
> > > > read by NFSD will either be:
> > > > - cached using page cache (NFSD_IO_BUFFERED=3D0)
> > > > - cached but removed from the page cache upon completion
> > > >   (NFSD_IO_DONTCACHE=3D1).
> > > > - not cached (NFSD_IO_DIRECT=3D2)
> > > >=20
> > > > io_cache_read is 0 by default.  It may be set by writing to:
> > > >   /sys/kernel/debug/nfsd/io_cache_read
> > > >=20
> > > > If NFSD_IO_DONTCACHE is specified using 1, FOP_DONTCACHE must be
> > > > advertised as supported by the underlying filesystem (e.g. XFS),
> > > > otherwise all IO flagged with RWF_DONTCACHE will fail with
> > > > -EOPNOTSUPP.
> > > >=20
> > > > If NFSD_IO_DIRECT is specified using 2, the IO must be aligned
> > > > relative to the underlying block device's logical_block_size. Also =
the
> > > > memory buffer used to store the read must be aligned relative to th=
e
> > > > underlying block device's dma_alignment.
> > > >=20
> > > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > > ---
> > > >  fs/nfsd/debugfs.c | 53 +++++++++++++++++++++++++++++++++++++++++++=
++++
> > > >  fs/nfsd/nfsd.h    |  8 +++++++
> > > >  fs/nfsd/vfs.c     | 15 ++++++++++++++
> > > >  3 files changed, 76 insertions(+)
> > > >=20
> > > > diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> > > > index 84b0c8b559dc..709646af797a 100644
> > > > --- a/fs/nfsd/debugfs.c
> > > > +++ b/fs/nfsd/debugfs.c
> > > > @@ -27,11 +27,61 @@ static int nfsd_dsr_get(void *data, u64 *val)
> > > >  static int nfsd_dsr_set(void *data, u64 val)
> > > >  {
> > > >  	nfsd_disable_splice_read =3D (val > 0) ? true : false;
> > > > +	if (!nfsd_disable_splice_read) {
> > > > +		/*
> > > > +		 * Cannot use NFSD_IO_DONTCACHE or NFSD_IO_DIRECT
> > > > +		 * if splice_read is enabled.
> > > > +		 */
> > > > +		nfsd_io_cache_read =3D NFSD_IO_BUFFERED;
> > > > +	}
> > > >  	return 0;
> > > >  }
> > > > =20
> > > >  DEFINE_DEBUGFS_ATTRIBUTE(nfsd_dsr_fops, nfsd_dsr_get, nfsd_dsr_set=
, "%llu\n");
> > > > =20
> > > > +/*
> > > > + * /sys/kernel/debug/nfsd/io_cache_read
> > > > + *
> > > > + * Contents:
> > > > + *   %0: NFS READ will use buffered IO (default)
> > > > + *   %1: NFS READ will use dontcache (buffered IO w/ dropbehind)
> > > > + *   %2: NFS READ will use direct IO
> > > > + *
> > > > + * The default value of this setting is zero (buffered IO is
> > > > + * used). This setting takes immediate effect for all NFS
> > > > + * versions, all exports, and in all NFSD net namespaces.
> > > > + */
> > > > +
> > >=20
> > > Could we switch this to use a string instead? Maybe
> > > buffered/dontcache/direct ?
> >=20
> > That thought occurred to me too, since it would make the API a little
> > more self-documenting, and might be a harbinger of what a future
> > export option might look like.
> >=20
> >=20
> > > > +static int nfsd_io_cache_read_get(void *data, u64 *val)
> > > > +{
> > > > +	*val =3D nfsd_io_cache_read;
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int nfsd_io_cache_read_set(void *data, u64 val)
> > > > +{
> > > > +	switch (val) {
> > > > +	case NFSD_IO_DONTCACHE:
> > > > +	case NFSD_IO_DIRECT:
> > > > +		/*
> > > > +		 * Must disable splice_read when enabling
> > > > +		 * NFSD_IO_DONTCACHE or NFSD_IO_DIRECT.
> > > > +		 */
> > > > +		nfsd_disable_splice_read =3D true;
> > > > +		nfsd_io_cache_read =3D val;
> > > > +		break;
> > > > +	case NFSD_IO_BUFFERED:
> > > > +	default:
> > > > +		nfsd_io_cache_read =3D NFSD_IO_BUFFERED;
> > > > +		break;
> > >=20
> > > I think the default case should leave nfsd_io_cache_read alone and
> > > return an error. If we add new values later, and someone tries to use
> > > them on an old kernel, it's better to make that attempt error out.
> > >=20
> > > Ditto for the write side controls.
> >=20
> > +1 on both accounts.
>=20
> I started to implement this just now (so that I can kick v3 of this
> patchset out of the nest today) but soon found that debugfs doesn't
> provide string-based interface controls.
>=20
> See simple_attr_open() (which is used by DEFINE_DEBUGFS_ATTRIBUTE).
> It only allows u64 to be set/get.
>=20
> I'll fix the default case to return an error for now though.
>=20
> Once we graduate from debugfs to a proper per-export control we can
> impose string controls/mapping, e.g.:
>=20
> +static u64 nfsd_io_cache_string_to_mode(const char *nfsd_io_cache_string=
)
> +{
> +       u64 val =3D NFSD_IO_UNKNOWN;
> +
> +       if (!strncmp(nfsd_io_cache_string, NFSD_IO_BUFFERED_string,
> +                    strlen(NFSD_IO_BUFFERED_string)))
> +               val =3D NFSD_IO_BUFFERED;
> +       else if (!strncmp(nfsd_io_cache_string, NFSD_IO_DONTCACHE_string,
> +                         strlen(NFSD_IO_DONTCACHE_string)))
> +               val =3D NFSD_IO_DONTCACHE;
> +       else if (!strncmp(nfsd_io_cache_string, NFSD_IO_DIRECT_string,
> +                         strlen(NFSD_IO_DIRECT_string)))
> +               val =3D NFSD_IO_DIRECT;
> +
> +       return val;
> +}
> +
> +static const char *
> +nfsd_io_cache_mode_to_string(const char *nfsd_io_cache_string)
> +{
> +       char *nfsd_io_cache_string;
> +
> +       switch (val) {
> +       case NFSD_IO_BUFFERED:
> +               nfsd_io_cache_string =3D NFSD_IO_BUFFERED_string;
> +               break;
> +       case NFSD_IO_DONTCACHE:
> +               nfsd_io_cache_string =3D NFSD_IO_DONTCACHE_string;
> +               break;
> +       case NFSD_IO_DIRECT:
> +               nfsd_io_cache_string =3D NFSD_IO_DIRECT_string;
> +               break;
> +       case NFSD_IO_UNKNOWN:
> +               nfsd_io_cache_string =3D NFSD_IO_UNKNOWN_string;
> +               break;
> +       }
> +
> +       return nfsd_io_cache_string;
> +}


Bummer.

I guess we could just roll our own using the seqfile interfaces and put
it in the same directory. I may take a stab at that before we ship
this. For now, we can stick with the integers.

Thanks for fixing up the default case!

--=20
Jeff Layton <jlayton@kernel.org>

