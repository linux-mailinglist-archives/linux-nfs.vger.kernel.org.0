Return-Path: <linux-nfs+bounces-1332-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A250483BEA2
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 11:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 269C4B25C97
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 10:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4331CA82;
	Thu, 25 Jan 2024 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+J++ZNY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54EC1CAA1
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178335; cv=none; b=a1har9//eOPDRihGxhC/uDVdjk70/xpw6xByE/w7xmLKDgL8AhyO7BSu2eumMEovbrJXQghckVS/sYBBs5EgBZw4WJ7/zK22k6xMQSRAeLzWZkpktTVsdKxycKiprbFdJGD/dQyiYn5Ge1vlj9VwJwE2UrlD2TczeQdeIjlQrik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178335; c=relaxed/simple;
	bh=g5UWE0AKN7/FBNtFrXUkoEo7BT7j8ORM3OBR3oQpBsc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gl/UmSpVuYr/N45DSk32hfBcWubzUZa+x2/PpgAxXIv1PxfEmTeVrznmjTRkLXr2lOhb8FsqD3VZA557HqyegmtoppcsLpgTBOYjXbcQTqsjg7sAswE7pumiYu5s98YzWeLWGsJW9Tio7nmuEmYoQSlkKLO6bYqfxj1D6QYspnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+J++ZNY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD449C433F1;
	Thu, 25 Jan 2024 10:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706178335;
	bh=g5UWE0AKN7/FBNtFrXUkoEo7BT7j8ORM3OBR3oQpBsc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=U+J++ZNYJFktwGtMx4F7mN3MWlplceV/gUkshbHP7KPJcNOv1E+aOBRlMG9AMIVRt
	 p1jNHhLxu09M+T+bPDmCOuVjvF6ZBimFjVY6GP6jzkdpkHL0XQZo48Q/UZCw/le/gS
	 +7hixmSqJzaFhxHjttkH1/q8zDlv9OnoecfANALKfEhGLXlRNHrV8cafxk+yN1S390
	 +LR626ESDuQ4TutvNiwWEnwHbyIyyxzIElFG/qgWZ/uKwjo/wlAPJZj8My0S8c8W6D
	 PvPeIt5cwu+O7KAElT2WdJb+YZ71fCNE8I0wHbD8zZxWeE5+Kcc9ld3bbjzp8WiXnc
	 1DGks0upuf8BQ==
Message-ID: <6bfb3b6e6637cac4b8719950294fc0ab26fde78f.camel@kernel.org>
Subject: Re: [PATCH 2/2] nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Linux NFS Mailing List
	 <linux-nfs@vger.kernel.org>, "kernel-team@fb.com" <kernel-team@fb.com>
Date: Thu, 25 Jan 2024 05:25:33 -0500
In-Reply-To: <BF83705F-89EE-43D4-A0B3-21B05B98FCF5@oracle.com>
References: <cover.1706124811.git.josef@toxicpanda.com>
	 <71058c29683d44644aba8ab295fa028ee41365a8.1706124811.git.josef@toxicpanda.com>
	 <ZbFzxmV6zgi/TACb@tissot.1015granger.net>
	 <20240124221258.GA1243606@perftesting>
	 <e724a63a63f30f927f1780ad9018811bc45bf4e1.camel@kernel.org>
	 <20240124231811.GA1287448@perftesting>
	 <5f264d8d506835c424d5cccfc55980fa2893337e.camel@kernel.org>
	 <ZbGhiCxgpeSNi+Fw@tissot.1015granger.net>
	 <7a9e9979c5e207713673bbec827e61c1b337a91c.camel@kernel.org>
	 <BF83705F-89EE-43D4-A0B3-21B05B98FCF5@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-25 at 01:54 +0000, Chuck Lever III wrote:
>=20
> > On Jan 24, 2024, at 7:06=E2=80=AFPM, Jeff Layton <jlayton@kernel.org> w=
rote:
> >=20
> > On Wed, 2024-01-24 at 18:47 -0500, Chuck Lever wrote:
> > > On Wed, Jan 24, 2024 at 06:41:27PM -0500, Jeff Layton wrote:
> > > > On Wed, 2024-01-24 at 18:18 -0500, Josef Bacik wrote:
> > > > > On Wed, Jan 24, 2024 at 05:57:06PM -0500, Jeff Layton wrote:
> > > > > > On Wed, 2024-01-24 at 17:12 -0500, Josef Bacik wrote:
> > > > > > > On Wed, Jan 24, 2024 at 03:32:06PM -0500, Chuck Lever wrote:
> > > > > > > > On Wed, Jan 24, 2024 at 02:37:00PM -0500, Josef Bacik wrote=
:
> > > > > > > > > We are running nfsd servers inside of containers with the=
ir own network
> > > > > > > > > namespace, and we want to monitor these services using th=
e stats found
> > > > > > > > > in /proc.  However these are not exposed in the proc insi=
de of the
> > > > > > > > > container, so we have to bind mount the host /proc into o=
ur containers
> > > > > > > > > to get at this information.
> > > > > > > > >=20
> > > > > > > > > Separate out the stat counters init and the proc registra=
tion, and move
> > > > > > > > > the proc registration into the pernet operations entry an=
d exit points
> > > > > > > > > so that these stats can be exposed inside of network name=
spaces.
> > > > > > > >=20
> > > > > > > > Maybe I missed something, but this looks like it exposes th=
e global
> > > > > > > > stat counters to all net namespaces...? Is that an informat=
ion leak?
> > > > > > > > As an administrator I might be surprised by that behavior.
> > > > > > > >=20
> > > > > > > > Seems like this patch needs to make nfsdstats and nfsd_svcs=
tats into
> > > > > > > > per-namespace objects as well.
> > > > > > > >=20
> > > > > > > >=20
> > > > > > >=20
> > > > > > > I've got the patches written for this, but I've got a questio=
n.  There's a=20
> > > > > > >=20
> > > > > > > svc_seq_show(seq, &nfsd_svcstats);
> > > > > > >=20
> > > > > > > in nfsd/stats.c.  This appears to be an empty struct, there's=
 nothing that
> > > > > > > utilizes it, so this is always going to print 0 right?  There=
's a svc_info in
> > > > > > > the nfsd_net, and that stats block appears to get updated pro=
perly.  Should I
> > > > > > > print this out here?  I don't see anywhere we get the rpc sta=
ts out of nfsd, am
> > > > > > > I missing something?  I don't want to rip out stuff that I do=
n't quite
> > > > > > > understand.  Thanks,
> > > > > > >=20
> > > > > > >=20
> > > > > >=20
> > > > > > nfsd_svcstats ends up being the sv_stats for the nfsd service. =
The RPC
> > > > > > code has some counters in there for counting different sorts of=
 net and
> > > > > > rpc events (see svc_process_common, and some of the recv and ac=
cept
> > > > > > handlers).  I think nfsstat(8) may fetch that info via the abov=
e
> > > > > > seqfile, so it's definitely not unused (and it should be printi=
ng more
> > > > > > than just a '0').
> > > > >=20
> > > > > Ahhh, I missed this bit
> > > > >=20
> > > > > struct svc_program              nfsd_program =3D {
> > > > > #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
> > > > >        .pg_next                =3D &nfsd_acl_program,
> > > > > #endif
> > > > >        .pg_prog                =3D NFS_PROGRAM,          /* progr=
am number */
> > > > >        .pg_nvers               =3D NFSD_NRVERS,          /* nr of=
 entries in
> > > > > nfsd_version */
> > > > >        .pg_vers                =3D nfsd_version,         /* versi=
on table */
> > > > >        .pg_name                =3D "nfsd",               /* progr=
am name */
> > > > >        .pg_class               =3D "nfsd",               /* authe=
ntication class
> > > > > */
> > > > >        .pg_stats               =3D &nfsd_svcstats,       /* versi=
on table */
> > > > >        .pg_authenticate        =3D &svc_set_client,      /* expor=
t authentication
> > > > > */
> > > > >        .pg_init_request        =3D nfsd_init_request,
> > > > >        .pg_rpcbind_set         =3D nfsd_rpcbind_set,
> > > > > };
> > > > >=20
> > > > > and so nfsd_svcstats definitely is getting used.
> > > > >=20
> > > > > >=20
> > > > > > svc_info is a completely different thing: it's a container for =
the
> > > > > > svc_serv...so I'm not sure I understand your question?
> > > > >=20
> > > > > I was just confused, and still am a little bit.
> > > > >=20
> > > > > The counters are easy, I put those into the nfsd_net struct and m=
ake everything
> > > > > mess with those counters and report those from proc.
> > > > >=20
> > > > > However the nfsd_svcstats are in this svc_program thing, which ap=
pears to need
> > > > > to be global?  Or do I need to make it per net as well?  Or do I =
need to do
> > > > > something completely different to track the rpc stats per network=
 namespace?
> > > >=20
> > > > Making the svc_program per-net is unnecessary for this (and probabl=
y not
> > > > desirable). That structure sort of describes the nfsd rpc "program"=
 and
> > > > that is pretty much the same between containers.
> > >=20
> > > Maybe we want per-namespace svc_programs. Some RPC programs will
> > > be registered in some namespaces, some in others? That might be
> > > the simplest approach.
> > >=20
> >=20
> > That seems like a much heavier lift, and I'm not sure I see the benefit=
.
> > Here's nfsd_program today:
> >=20
> > struct svc_program              nfsd_program =3D {
> > #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
> >        .pg_next                =3D &nfsd_acl_program,
> > #endif
> >        .pg_prog                =3D NFS_PROGRAM,          /* program num=
ber */
> >        .pg_nvers               =3D NFSD_NRVERS,          /* nr of entri=
es in nfsd_version */
> >        .pg_vers                =3D nfsd_version,         /* version tab=
le */
> >        .pg_name                =3D "nfsd",               /* program nam=
e */
> >        .pg_class               =3D "nfsd",               /* authenticat=
ion class */
> >        .pg_stats               =3D &nfsd_svcstats,       /* version tab=
le */
> >        .pg_authenticate        =3D &svc_set_client,      /* export auth=
entication */
> >        .pg_init_request        =3D nfsd_init_request,
> >        .pg_rpcbind_set         =3D nfsd_rpcbind_set,
> > };
> >=20
> > All of that seems fairly constant across containers. The main exception
> > is the svc_stats, which does need to be per-program and per-net, at
> > least for nfsd.
>=20
> This would be the benefit right here: the stats need to be matrixed
> per program and per net. The stats and the program (set of RPC
> procedures) are pretty tightly interconnected.
>=20
> Some namespaces might want NFSv2 or NFSv3, some might want NFSv4 only.
>=20

I don't think you'd want to do that by changing the svc_program though.
We already have ways to enable and disable versions on a per svc_serv
basis.

> But I don't have a strong opinion about it at this point. You could
> be right that this would be the more obtuse approach. There is one
> fixed definition for each RPC program, so having one svc_program
> per RPC program, and having each live in global module memory, is
> sensible.
>=20
> The way stats work now is from a long-ago era.
>=20
>=20

Now that I look more closely, I think Josef will need to make two
different structs into per-net objects:

The nfsd_svcstats is the generic RPC stats counters for the nfsd
service, whereas nfsdstats has counters for specific nfsd operations and
events. You'll need to make both into per-net objects, I think.

> > FWIW, looking at the other services that set pg_stats, none of them hav=
e
> > a way to actually report them! They are write-only. We should probably
> > make the others just set pg_stats to NULL so we don't bother
> > incrementing on them.
> >=20
> > That should simplify reworking how this works for nfsd too...
>=20
> True, but I've been told that having NLM RPC stats available would be
> helpful for distro support teams. It would be cool to delete some lines
> of code, but we should ask around before tossing out this unused
> infrastructure.
>=20
> In fact, Josef: what do you think? Would having NLM stats for your
> NFSv3 servers be helpful?
>=20

How are they useful if there is no way to report them? Are they poking
around in vmcore dumps or BPF to get at it?

In any case, if we want to keep them, then we should probably make a new
procfile that reports the stats for them (and write a nlmstat program or
something to make them pretty).

I'd still suggest just removing that stuff for now though until and
unless we can prove that they are useful.

My suggestion for the svc_serv stuff:

1/ drop all of the svc_stats structs except for nfsd's

2/ eliminate ->pg_stats and make __svc_create and svc_create_pooled take
a svc_stats pointer arg. Most callers can pass in NULL there, but
nfsd_create_serv will want to allocate one per net namespace.

3/ Bonus points: convert svc_stats to use percpu vars

Making nfsdstats per-net are sort of a separate project, but you'll need
to do that in order for this to work correctly.
--=20
Jeff Layton <jlayton@kernel.org>

