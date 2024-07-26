Return-Path: <linux-nfs+bounces-5080-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 366BC93DA33
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 23:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9CC81F21659
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 21:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DF343155;
	Fri, 26 Jul 2024 21:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxjjNn8b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86BD38DEE
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 21:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722029570; cv=none; b=ihfs8e7n9t+AZqnA0ZgZ2N9gsGDtZY9jspPw6oQjUARPKw86cshIo1255B+JtQOYGfkefJnLy25rAtQB7cypmCiIAdUo4jVpKVfeGPSI0STTHGIeufhJ8IQMu/ei35cDlFPQLCXM2z1uS0oFmNs0RrPUFO2c8q2j0hHR+bd0kQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722029570; c=relaxed/simple;
	bh=Os5+yYyOTEilLbtYRce2zNBDkrYAa1bsldJFkM+6HBo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jmZQwV5aXcprorPYiWWjVkvRZI/l9RHJRJpPV9tVIQ44eDxMd7BvUPTbNgJ4qXtiC51dbf3grfvZXfhIZxeeA/HyJ2fRY/5hwkyFh+IjBSupO4PGESa7ozwCODB7KiaACumfDsD+4oiLczXPbHed1m4JLXHP+alfxURt1PRQnU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxjjNn8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140D7C32782;
	Fri, 26 Jul 2024 21:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722029570;
	bh=Os5+yYyOTEilLbtYRce2zNBDkrYAa1bsldJFkM+6HBo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=LxjjNn8bIAvfuzR63XFtNO1A18C3NwvZhzD2Zd6q0RuiT/LmRi4xCYzl8FVfJEeUd
	 huk3KEl+w66rMCav7U7CJQHWCv4ZXn9Nk/oCiqTLV9KH/u+JLMYjY8TsuJvkTxZEne
	 Ksxfu4UYgKSkk6SZA1cETGqtR3AEHI47hwIu2G4RLQbd1vw8mxVKIx0rGutnNlxwQ2
	 uhkvdb7vFR85dPxr4Ma0crGOl+msdAE/9jNASHdtr+j+BSRi465NcTOhtSv4i831fT
	 3GYI/4i3tTzl7JgrGYswUjxxL2FQTMnYsdNFAq/l7rgg52+iQmCWQjbATGjXkgADy1
	 XnK+bRqkJOVPQ==
Message-ID: <c327208425684c14c788032b56803f05d59f1070.camel@kernel.org>
Subject: Re: [PATCH nfs-utils v6 0/3] nfsdctl: add a new nfsdctl tool to
 nfs-utils
From: Jeff Layton <jlayton@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, Neil Brown <neilb@suse.de>, Olga Kornievskaia
 <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>,  Chuck Lever <chuck.lever@oracle.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>
Date: Fri, 26 Jul 2024 17:32:47 -0400
In-Reply-To: <823ebc16-caf3-4658-9951-842fda8c6cbd@redhat.com>
References: <20240722-nfsdctl-v6-0-1b9d63710eb5@kernel.org>
	 <823ebc16-caf3-4658-9951-842fda8c6cbd@redhat.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-26 at 15:40 -0400, Steve Dickson wrote:
> Hey!
>=20
> On 7/22/24 1:01 PM, Jeff Layton wrote:
> > Hi Steve,
> >=20
> > Here's an squashed version of the nfsdctl patches, that represents
> > the latest changes. Let me know if you run into any other problems,
> > and thanks for helping to test this!
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > Changes in v6:
> > - make the default number of threads 16 in autostart
> > - doc updates
> >=20
> > Changes in v5:
> > - add support for pool-mode setting
> > - fix up the handling of nfsd_netlink.h in autoconf
> > - Link to v4:
> > https://lore.kernel.org/r/20240604-nfsdctl-v4-0-a2941f782e4c@kernel.org
> >=20
> > Changes in v4:
> > - add ability to specify an array of pool thread counts in nfs.conf
> > - Link to v3:
> > https://lore.kernel.org/r/20240423-nfsdctl-v3-0-9e68181c846d@kernel.org
> >=20
> > Changes in v3:
> > - split nfsdctl.h so we can include the UAPI header as-is
> > - squash the patches together that added Lorenzo's version and
> > convert
> > =C2=A0=C2=A0 it to the new interface
> > - adapt to latest version of netlink interface changes
> > =C2=A0=C2=A0 + have THREADS_SET/GET report an array of thread counts (o=
ne per
> > pool)
> > =C2=A0=C2=A0 + pass scope in as a string to THREADS_SET instead of usin=
g
> > unshare() trick
> >=20
> > Changes in v2:
> > - Adapt to latest kernel netlink interface changes (in particular,
> > send
> > =C2=A0=C2=A0 the leastime and gracetime when they are set in the config=
).
> > - More help text for different subcommands
> > - New nfsdctl(8) manpage
> > - Patch to make systemd preferentially use nfsdctl instead of
> > rpc.nfsd
> > - Link to v1:
> > https://lore.kernel.org/r/20240412-nfsdctl-v1-0-efd6dcebcc04@kernel.org
> >=20
> > ---
> > Jeff Layton (3):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsdctl: add the nfsdctl utility t=
o nfs-utils
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsdctl: asciidoc source for the m=
anpage
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 systemd: use nfsdctl to start and =
stop the nfs server
> >=20
> > =C2=A0 configure.ac=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 19 +
> > =C2=A0 systemd/nfs-server.service=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 4 +-
> > =C2=A0 utils/Makefile.am=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 4 +
> > =C2=A0 utils/nfsdctl/Makefile.am=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 13 +
> > =C2=A0 utils/nfsdctl/nfsd_netlink.h |=C2=A0=C2=A0 96 +++
> > =C2=A0 utils/nfsdctl/nfsdctl.8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 30=
4 ++++++++
> > =C2=A0 utils/nfsdctl/nfsdctl.adoc=C2=A0=C2=A0 |=C2=A0 158 +++++
> > =C2=A0 utils/nfsdctl/nfsdctl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1570
> > ++++++++++++++++++++++++++++++++++++++++++
> > =C2=A0 utils/nfsdctl/nfsdctl.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 93 +++
> > =C2=A0 9 files changed, 2259 insertions(+), 2 deletions(-)
> > ---
> > base-commit: b76dbaa48f7c239accb0c2d1e1d51ddd73f4d6be
> > change-id: 20240412-nfsdctl-fa8bd8430cfd
>=20
> The patches apply very cleaning and thank you
> for squashing them down... but... bring up the
> NFS server with 'nfsdctl autostart' v3 is not
> being registered with rpcbind which means
> v3 mount will not work.
>=20
> Just curious are you trying support my
> idea of deprecating V3 :-) (That's a joke!)
>=20
> steved.
>=20

You do need a patched kernel for this:

    https://lore.kernel.org/linux-nfs/Zp5j2DW+2BNaIPif@tissot.1015granger.n=
et/T/#e675642639c59b1c0070f4b19cd03b89cff7983ba

With a patched kernel, I get this with autostart:

[kdevops@kdevops-nfsd ~]$ rpcinfo -p
   program vers proto   port  service
    100000    4   tcp    111  portmapper
    100000    3   tcp    111  portmapper
    100000    2   tcp    111  portmapper
    100000    4   udp    111  portmapper
    100000    3   udp    111  portmapper
    100000    2   udp    111  portmapper
    100024    1   udp  42104  status
    100024    1   tcp  40159  status
    100003    3   udp   2049  nfs
    100227    3   udp   2049  nfs_acl
    100003    3   tcp   2049  nfs
    100003    4   tcp   2049  nfs
    100227    3   tcp   2049  nfs_acl
    100021    1   udp  46387  nlockmgr
    100021    3   udp  46387  nlockmgr
    100021    4   udp  46387  nlockmgr
    100021    1   tcp  36565  nlockmgr
    100021    3   tcp  36565  nlockmgr
    100021    4   tcp  36565  nlockmgr


Are you seeing different results?
--=20
Jeff Layton <jlayton@kernel.org>

