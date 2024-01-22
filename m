Return-Path: <linux-nfs+bounces-1252-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F7E836DFC
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 18:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DB128CA45
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 17:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6148B47F54;
	Mon, 22 Jan 2024 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9yNLUia"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FED41767;
	Mon, 22 Jan 2024 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942924; cv=none; b=fcnyugLF1tOap98qjg+1uLMj1Pf2iqXmEpKAA6zE8BteI8Gr+c0SywBqkY403u6Fel4+zSdFmThqJpowhSYWiYj244vnok4/OSHdJZcHTR3xBLHzT9FAt8QELL7nxOKykQ1yDFEehz09D4kSaGncDKS29TUjsbWttGQ62y7ZhfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942924; c=relaxed/simple;
	bh=cNXx+pNcOPu9bakjCohGYpnVqT6iQFH/OsKqW9Y6OhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAld0YBOPZcs2LLN5/uWyFuxcxrd30BDuRmknSLDITgjHFoBkrP/KosOSYvMp1M3llSAyI6ehMQ8xshDLUNWKmrTo7JU5dK/TJUrSzqYNMOfT9zVo5iEIA+/1famXOereeLs9VzbsPrwOpLaDILWbOAUSVA3n+jF4p3ToDob/co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9yNLUia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB6BC43390;
	Mon, 22 Jan 2024 17:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705942923;
	bh=cNXx+pNcOPu9bakjCohGYpnVqT6iQFH/OsKqW9Y6OhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I9yNLUiaB8t4hTTpf4JRkwgvXD5ROAswt7yDCsQgs/9lpY4Us9b0g97oznNQ9H+Ai
	 cKN2IO7yH+a1yTQ5Rqxp28n3glie0mgTMZXqKmpFNyB9qtL+L+8SKVE0GDcdEkppWS
	 +NMbTSZNTExviZ+x/rsuYhdlBs5Li99iO49MGebBls0epm0QaBt2tz+th76cKl57/L
	 7ujgq0x7Mk7/oB26M2nGkBo+7WIniJx65/sRiv7GLVv5pLeccoADjh26K6gpORMyjd
	 JG0wAXxCw6uK6WVTcAdE80dW28uKZM5RaE53zMVoMsRFZKjud1pNHP2+YZfKRlY4LN
	 UuIhXDxaP4NIQ==
Date: Mon, 22 Jan 2024 18:01:59 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com, neilb@suse.de,
	kuba@kernel.org, chuck.lever@oracle.com, horms@kernel.org,
	netdev@vger.kernel.org, Steve Dickson <steved@redhat.com>
Subject: Re: [PATCH v6 0/3] convert write_threads, write_version and
 write_ports to netlink commands
Message-ID: <Za6fh2cd7ljGj8k4@lore-desk>
References: <cover.1705771400.git.lorenzo@kernel.org>
 <8b2054af2aa6b74e79aa898b5412b5cc44946f81.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KB9lUJ+ko+IeDdy5"
Content-Disposition: inline
In-Reply-To: <8b2054af2aa6b74e79aa898b5412b5cc44946f81.camel@kernel.org>


--KB9lUJ+ko+IeDdy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, 2024-01-20 at 18:33 +0100, Lorenzo Bianconi wrote:
> > Introduce write_threads, write_version and write_ports netlink
> > commands similar to the ones available through the procfs.
> >=20
> > Changes since v5:
> > - for write_ports and write_version commands, userspace is expected to =
provide
> >   a NFS listeners/supported versions list it want to enable (all the ot=
her
> >   ports/versions will be disabled).
> > - fix comments
> > - rebase on top of nfsd-next
> > Changes since v4:
> > - rebase on top of nfsd-next tree
> > Changes since v3:
> > - drop write_maxconn and write_maxblksize for the moment
> > - add write_version and write_ports commands
> > Changes since v2:
> > - use u32 to store nthreads in nfsd_nl_threads_set_doit
> > - rename server-attr in control-plane in nfsd.yaml specs
> > Changes since v1:
> > - remove write_v4_end_grace command
> > - add write_maxblksize and write_maxconn netlink commands
> >=20
> > This patch can be tested with user-space tool reported below:
> > https://github.com/LorenzoBianconi/nfsd-netlink.git
> >=20
> > Lorenzo Bianconi (3):
> >   NFSD: convert write_threads to netlink command
> >   NFSD: add write_version to netlink command
> >   NFSD: add write_ports to netlink command
> >=20
> >  Documentation/netlink/specs/nfsd.yaml |  94 ++++++
> >  fs/nfsd/netlink.c                     |  63 ++++
> >  fs/nfsd/netlink.h                     |  10 +
> >  fs/nfsd/nfsctl.c                      | 396 ++++++++++++++++++++++
> >  include/uapi/linux/nfsd_netlink.h     |  44 +++
> >  tools/net/ynl/generated/nfsd-user.c   | 460 ++++++++++++++++++++++++++
> >  tools/net/ynl/generated/nfsd-user.h   | 155 +++++++++
> >  7 files changed, 1222 insertions(+)
> >=20
>=20
>=20
> I think this is really close and coming together! Before we merge this
> though, I'd _really_ like to see some patches for rpc.nfsd in nfs-utils.
> Until we try to implement the userland bits, we won't know if we've
> gotten this interface right.
>=20
> ...and before that, we really need to have some sort of userland program
> packaged and available for querying the new netlink RPC stats from nfsd.
> You have the simple userland one on github, but I think we need omething
> packaged, ideally as part of nfs-utils.

Hi Jeff,

I guess we can experiment on the new APIs very easily with ynl cli.py.
Something like:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/nfsd.yaml --dum=
p rpc-status-get
[{'compound-ops': [53, 22, 9],
 'daddr4': 3232266828,
 'dport': 2049,
 'flags': 5,
 'proc': 1,
 'prog': 100003,
 'saddr4': 3232266753,
 'service_time': 81705129,
 'sport': 908,
 'version': 4,
 'xid': 0},
{'compound-ops': [53, 22, 9],
 'daddr4': 3232266828,
 'dport': 2049,
 'flags': 5,
 'proc': 1,
 'prog': 100003,
 'saddr4': 3232266753,
 'service_time': 81700496,
 'sport': 908,
 'version': 4,
 'xid': 0}]

or=20

=2E/tools/net/ynl/cli.py --spec Documentation/netlink/specs/nfsd.yaml --do =
threads-get
{'threads': 8}

(the only required package is jsonschema iirc).

Regards,
Lorenzo

>=20
> Doing that first would allow you to add the necessary autoconf/libtool
> stuff to pull in the netlink libraries, which will be a prerequisite for
> doing the userland rpc.nfsd work, and will probably be a bit simpler
> than modifying rpc.nfsd.
> --=20
> Jeff Layton <jlayton@kernel.org>

--KB9lUJ+ko+IeDdy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZa6fhwAKCRA6cBh0uS2t
rFSbAP9R1RTHvGmsRCaO4ma3HM8G2wC16u4sHfTfgVUn63DsKgD/exXFF5MxO4XG
XfjyB87e5u/fjm31dqXxjKbgOxNGWAw=
=ysUZ
-----END PGP SIGNATURE-----

--KB9lUJ+ko+IeDdy5--

