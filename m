Return-Path: <linux-nfs+bounces-5083-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E3493DAA4
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 00:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA851F2332E
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 22:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6EC14A09A;
	Fri, 26 Jul 2024 22:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAOJddcF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76183143C6A
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 22:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722032430; cv=none; b=KAXj6tQJ3HoQqjJKI3iVi6YlzBiDhvH0lroDgb9jKSiMmWQonxozWNvLGfTr7C0L2lFa9r6nhTSJzGzk0uNSKVsJ52UV1vuOvZsAXc7L+aFEqUO3q44yArPgkUrAZoAhs+xOVEoZLZedLePO/JUvN7omM8B+zm115ATrvzm0pA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722032430; c=relaxed/simple;
	bh=7II5OPL15E1O1dWP7NO8F0G/9QtUtl2aexCTJMeiTtI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vvn4jSqFxf2GNag/lWAkTAbY1vt6cmfBcjJ6CGDlTndYYls3SSDzlPLPxtpgYQlRDOVzPOD9Mq6UkQP+ZhiCi1akaB7DGpP0WG3ncebV4kOgZ4GDI/Ogkpz16gjDt3Eu1ZP2QGsfD0J0tHLsSeiUzwCs9Fx754q9FbH8bJFZcZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAOJddcF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45080C32782;
	Fri, 26 Jul 2024 22:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722032430;
	bh=7II5OPL15E1O1dWP7NO8F0G/9QtUtl2aexCTJMeiTtI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=BAOJddcFw8uiywz/ZCPMuQtH+8y2g+5m0DBmwqU9ibzMfmubcBmicUmXF+lSSfCDj
	 ebBjjltXRHFCFzvjD+BW1IMvcXdgBW1770J6/uEIzWYO5ykY+7eZEWbHV8ESVW9sW4
	 WETiJXqFAIAvARdZ5E/gW4T65gb4jw4sre0hHPfeQR649UibMZ+OXB6Fhb2mWN9q13
	 rXVdyKYxzfPSUGIbftHmlHP26c3KT/AgKVuJuHseRpypKR6AVwLeB5/lBYPEDNz22J
	 hNCX8ohYRD3R5c/cg9fTV6+vpoutosc1ZRRJVD2ovNklykZSzqhrFZeGedYX4PmOsc
	 ylry7BSyeircw==
Message-ID: <9587ca96fc8cf49852e129857ffebefadff1c436.camel@kernel.org>
Subject: Re: [PATCH nfs-utils v6 0/3] nfsdctl: add a new nfsdctl tool to
 nfs-utils
From: Jeff Layton <jlayton@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, Neil Brown <neilb@suse.de>, Olga Kornievskaia
 <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>,  Chuck Lever <chuck.lever@oracle.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>
Date: Fri, 26 Jul 2024 18:20:28 -0400
In-Reply-To: <807d899f-56c2-46d9-81aa-d2ef4c84d3b0@redhat.com>
References: <20240722-nfsdctl-v6-0-1b9d63710eb5@kernel.org>
	 <823ebc16-caf3-4658-9951-842fda8c6cbd@redhat.com>
	 <c327208425684c14c788032b56803f05d59f1070.camel@kernel.org>
	 <807d899f-56c2-46d9-81aa-d2ef4c84d3b0@redhat.com>
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

On Fri, 2024-07-26 at 17:59 -0400, Steve Dickson wrote:
>=20
> On 7/26/24 5:32 PM, Jeff Layton wrote:
> > On Fri, 2024-07-26 at 15:40 -0400, Steve Dickson wrote:
> > > Hey!
> > >=20
> > > On 7/22/24 1:01 PM, Jeff Layton wrote:
> > > > Hi Steve,
> > > >=20
> > > > Here's an squashed version of the nfsdctl patches, that represents
> > > > the latest changes. Let me know if you run into any other problems,
> > > > and thanks for helping to test this!
> > > >=20
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > > Changes in v6:
> > > > - make the default number of threads 16 in autostart
> > > > - doc updates
> > > >=20
> > > > Changes in v5:
> > > > - add support for pool-mode setting
> > > > - fix up the handling of nfsd_netlink.h in autoconf
> > > > - Link to v4:
> > > > https://lore.kernel.org/r/20240604-nfsdctl-v4-0-a2941f782e4c@kernel=
.org
> > > >=20
> > > > Changes in v4:
> > > > - add ability to specify an array of pool thread counts in nfs.conf
> > > > - Link to v3:
> > > > https://lore.kernel.org/r/20240423-nfsdctl-v3-0-9e68181c846d@kernel=
.org
> > > >=20
> > > > Changes in v3:
> > > > - split nfsdctl.h so we can include the UAPI header as-is
> > > > - squash the patches together that added Lorenzo's version and
> > > > convert
> > > >  =C2=A0=C2=A0 it to the new interface
> > > > - adapt to latest version of netlink interface changes
> > > >  =C2=A0=C2=A0 + have THREADS_SET/GET report an array of thread coun=
ts (one per
> > > > pool)
> > > >  =C2=A0=C2=A0 + pass scope in as a string to THREADS_SET instead of=
 using
> > > > unshare() trick
> > > >=20
> > > > Changes in v2:
> > > > - Adapt to latest kernel netlink interface changes (in particular,
> > > > send
> > > >  =C2=A0=C2=A0 the leastime and gracetime when they are set in the c=
onfig).
> > > > - More help text for different subcommands
> > > > - New nfsdctl(8) manpage
> > > > - Patch to make systemd preferentially use nfsdctl instead of
> > > > rpc.nfsd
> > > > - Link to v1:
> > > > https://lore.kernel.org/r/20240412-nfsdctl-v1-0-efd6dcebcc04@kernel=
.org
> > > >=20
> > > > ---
> > > > Jeff Layton (3):
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsdctl: add the nfsdctl util=
ity to nfs-utils
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsdctl: asciidoc source for =
the manpage
> > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 systemd: use nfsdctl to start=
 and stop the nfs server
> > > >=20
> > > >  =C2=A0 configure.ac=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 19 +
> > > >  =C2=A0 systemd/nfs-server.service=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 =
4 +-
> > > >  =C2=A0 utils/Makefile.am=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 4 +
> > > >  =C2=A0 utils/nfsdctl/Makefile.am=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1=
3 +
> > > >  =C2=A0 utils/nfsdctl/nfsd_netlink.h |=C2=A0=C2=A0 96 +++
> > > >  =C2=A0 utils/nfsdctl/nfsdctl.8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 304 ++++++++
> > > >  =C2=A0 utils/nfsdctl/nfsdctl.adoc=C2=A0=C2=A0 |=C2=A0 158 +++++
> > > >  =C2=A0 utils/nfsdctl/nfsdctl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 157=
0
> > > > ++++++++++++++++++++++++++++++++++++++++++
> > > >  =C2=A0 utils/nfsdctl/nfsdctl.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 93 +++
> > > >  =C2=A0 9 files changed, 2259 insertions(+), 2 deletions(-)
> > > > ---
> > > > base-commit: b76dbaa48f7c239accb0c2d1e1d51ddd73f4d6be
> > > > change-id: 20240412-nfsdctl-fa8bd8430cfd
> > >=20
> > > The patches apply very cleaning and thank you
> > > for squashing them down... but... bring up the
> > > NFS server with 'nfsdctl autostart' v3 is not
> > > being registered with rpcbind which means
> > > v3 mount will not work.
> > >=20
> > > Just curious are you trying support my
> > > idea of deprecating V3 :-) (That's a joke!)
> > >=20
> > > steved.
> > >=20
> >=20
> > You do need a patched kernel for this:
> >=20
> >      https://lore.kernel.org/linux-nfs/Zp5j2DW+2BNaIPif@tissot.1015gran=
ger.net/T/#e675642639c59b1c0070f4b19cd03b89cff7983ba
> >=20
> > With a patched kernel, I get this with autostart:
> >=20
> > [kdevops@kdevops-nfsd ~]$ rpcinfo -p
> >     program vers proto   port  service
> >      100000    4   tcp    111  portmapper
> >      100000    3   tcp    111  portmapper
> >      100000    2   tcp    111  portmapper
> >      100000    4   udp    111  portmapper
> >      100000    3   udp    111  portmapper
> >      100000    2   udp    111  portmapper
> >      100024    1   udp  42104  status
> >      100024    1   tcp  40159  status
> >      100003    3   udp   2049  nfs
> >      100227    3   udp   2049  nfs_acl
> >      100003    3   tcp   2049  nfs
> >      100003    4   tcp   2049  nfs
> >      100227    3   tcp   2049  nfs_acl
> >      100021    1   udp  46387  nlockmgr
> >      100021    3   udp  46387  nlockmgr
> >      100021    4   udp  46387  nlockmgr
> >      100021    1   tcp  36565  nlockmgr
> >      100021    3   tcp  36565  nlockmgr
> >      100021    4   tcp  36565  nlockmgr
> >=20
> >=20
> > Are you seeing different results?
> Yup
> uname -r
> 6.11.0-0.rc0.20240724git786c8248dbd3.12.fc41.x86_64 (rawhide)
>=20

Did you patch that kernel by hand then? AFAICT, that git hash doesn't
have the necessary fix. I don't think Chuck has sent a PR to Linus for
it just yet.

> rpcinfo -p
>     program vers proto   port  service
>      100000    4   tcp    111  portmapper
>      100000    3   tcp    111  portmapper
>      100000    2   tcp    111  portmapper
>      100000    4   udp    111  portmapper
>      100000    3   udp    111  portmapper
>      100000    2   udp    111  portmapper
>      100005    1   udp  20048  mountd
>      100005    1   tcp  20048  mountd
>      100024    1   udp  38596  status
>      100024    1   tcp  60257  status
>      100005    2   udp  20048  mountd
>      100005    2   tcp  20048  mountd
>      100005    3   udp  20048  mountd
>      100005    3   tcp  20048  mountd
>      100021    1   udp  55966  nlockmgr
>      100021    3   udp  55966  nlockmgr
>      100021    4   udp  55966  nlockmgr
>      100021    1   tcp  40995  nlockmgr
>      100021    3   tcp  40995  nlockmgr
>      100021    4   tcp  40995  nlockmgr
>=20
> # mount -o v3 fedora:/home/tmp /mnt/tmp
> mount.nfs: requested NFS version or transport protocol is not supported=
=20
> for /mnt/tmp
>=20

--=20
Jeff Layton <jlayton@kernel.org>

