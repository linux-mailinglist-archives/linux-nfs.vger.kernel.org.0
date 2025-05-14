Return-Path: <linux-nfs+bounces-11718-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD32AB6AE0
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 14:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0883B189CD7A
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 12:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8460202997;
	Wed, 14 May 2025 12:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhDM+eLf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10C21E9907
	for <linux-nfs@vger.kernel.org>; Wed, 14 May 2025 12:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747224161; cv=none; b=ZLCvfBwrWeWJi9RmCuBeGjkQ3868VUQEmsisCjIhs42IAjjwt8fZol5+by6H/opae9ktllrtQoqNLZSAaOcG7a0BsqYeryQGqeSdU68F/yEyHkzdtOkRaMdv+0ZcGFvR8OweWkxR3hiCgg948vOAikIZb6JEQ0OPczk5WX9mUv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747224161; c=relaxed/simple;
	bh=umlBmGhU2hAynxyRNPgwQ2QBnclg9dTwHI89h4s0Utw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hS6ptp72wa4PZF5S2UfePdJwzOPU9oSz0xdnOLRe8VU9QLPXnAqV8FXauyfSIncsoQVaOdfArKDZfrA3k/nRsM+9uPyEJWXvROsJ/YVMHE6AXXi4XVj6sLeud33SifkJTXo4J7r89d6tI658FkolRchjaju0rpHgMnrwSgZPITs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhDM+eLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56ECC4CEE9;
	Wed, 14 May 2025 12:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747224161;
	bh=umlBmGhU2hAynxyRNPgwQ2QBnclg9dTwHI89h4s0Utw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WhDM+eLfKmYtJ5P73rG/HCwaVEttx39sBAd4a768VbFnqeOGgPZxUhKmZwe9wgOFD
	 oGVXZ8OcaPQvbIg8Mn/rMRuNsFsrmCQbreZNDQ2JPcwv0MMUshHDwtPMwfBilLd6BS
	 ntjh2yCI5eEbOakjA1b0n3OKjkM1xYQEkVIfgp58zCh6hfCl2LhgnLTg7B8GLt1kl0
	 aCHJjGXYKmR2XuXF7O5chr/dgMRld8bYsT7BGsAMcF4YaIMEw3iM24we5OggOV7MXg
	 5Pz5x65HZ6uoiHKTKredM8esOe55sKKZdZiSMVghUxZpRIn97/Qcvxs7G2nfXebV7G
	 qV4fpwouLdbuw==
Message-ID: <f1afb60ecb3ac256807c12963ac87382ad45731b.camel@kernel.org>
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Steve Dickson <steved@redhat.com>, Tom Haynes <loghyr@gmail.com>, 
	linux-nfs@vger.kernel.org
Date: Wed, 14 May 2025 08:02:39 -0400
In-Reply-To: <174722301596.62796.971181010409022860@noble.neil.brown.name>
References: <>, <91b04852a612c651533c62f6f9fc4bd61e97be62.camel@kernel.org>
	 <174722301596.62796.971181010409022860@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-05-14 at 21:43 +1000, NeilBrown wrote:
> On Wed, 14 May 2025, Jeff Layton wrote:
> > On Wed, 2025-05-14 at 12:28 +1000, NeilBrown wrote:
> > > On Wed, 14 May 2025, NeilBrown wrote:
> > > > On Tue, 13 May 2025, Jeff Layton wrote:
> > > > > Back in the 80's someone thought it was a good idea to carve out =
a set
> > > > > of ports that only privileged users could use. When NFS was origi=
nally
> > > > > conceived, Sun made its server require that clients use low ports=
.
> > > > > Since Linux was following suit with Sun in those days, exportfs h=
as
> > > > > always defaulted to requiring connections from low ports.
> > > > >=20
> > > > > These days, anyone can be root on their laptop, so limiting conne=
ctions
> > > > > to low source ports is of little value.
> > > >=20
> > > > But who is going to export any filesystem to their laptop?
> > > >=20
> > > > >=20
> >=20
> > The point is that most NFS servers are run on networks where the admin
> > may not have 100% control over every host on the network. Once you're
> > that situation, relying on low port values for security is basically
> > worthless.
>=20
> "most" ??  Where did you get that statistic?
>=20

Anecdotal experience.

> "Some" are run on in-machine-room networks which are completely
> controlled, but which allow local users to log in to unprivileged
> accounts.  In this case it makes perfect sense to rely on "privileged"
> ports to control access.  If you silently change nfs-utils so that
> unprivileged users can have root-level access over NFS, then you are
> exposing the file server completely to anyone who can log in to an
> server in that local network.  Are you sure you want to do that?
>=20

These types of environments are vanishingly small these days. If you
have a network of any size, it is _really_ hard to prevent someone from
plugging a laptop or something else into a random network drop.

You can prevent that with 802.1x security, or something similar, but at
that point what is checking the source port going to give you?

> >=20
> > > > > Make the default be "insecure" when creating exports.
> > > >=20
> > > > So you want to break lots of configurations that are working perfec=
tly
> > > > well?
> > >=20
> > > Sorry - I was wrong.  You aren't breaking working configurations, but
> > > you are removing a protection that people might be expecting.  It mig=
ht
> > > not be much protection, but it is not zero.
> > >=20
> >=20
> > True. Anyone relying on this "protection" is fooling themselves though.
>=20
> As above: in some circumstances with physically secure networks
> (entirely in a locked room, or entire in a virtualisation host, or a
> VPN) it makes perfect sense.
>=20

Not really. If any host is compromised on your network then this
protection goes out the window.
=20
> >=20
> > > >=20
> > > > I don't see any really motivation for this change.  Could you provi=
de it
> > > > please?
> > >=20
> > > Or to put it another way: who benefits?
> > >=20
> >=20
> > Anyone running NFS clients behind NAT?
>=20
> Maybe that should have been in the commit message?
>=20

Sure. I can add that and resend.

> >=20
> > The main discussion came about when we were testing against a
> > hammerspace deployment. They were using knfsd as their DS's, and had
> > forgotten to add "insecure" to the export options. When the (NAT'ed)
> > client tried to talk to the DS's, it got back NFSERR3_PERM because of
> > this. It took a little while to ascertain the cause.
>=20
> "Change default to fix configuration problem"....???
> The default must always be the more secure.  "fail safe".
>=20

The default should also always "just work". We have to balance that
with being secure. There is a reason we don't default to krb5, for
instance. In this case, the added security of checking low port values
by default is pretty worthless. I think we ought to err on the side of
usability.

Also, to be clear, this currently not even enforced in all situations
where TCP is used. iwarp travels over TCP, but using RDMA disables this
check.

> If we want to make this configuration problem more easy to detect, maybe
> we should log unprivileged port access (beyond the few requests for
> which it can make sense).
>=20

I don't see any benefit in that at all. If someone wants to do that,
they can get that via tracepoints.

> >=20
> > Note that Solaris' NFS server stopped checking source ports many years
> > ago. We're only doing this now because we followed suit from how they
> > behaved in the 90s and never changed it.
>=20
> I wonder why Sun went out of business.....
>=20

I'm fairly certain that NFS server security had little to do with Sun's
death.

> Ignoring source ports makes no sense at all unless you enforce some other
> authentication, like krb5 or TLS, or unless you *know* that there are no
> unprivileged processes running on any client machines.
>=20

Paying attention to source ports makes no sense at all. In the modern
age, all sorts of middleware boxes can change the source port on a
connection. It is essentially meaningless outside of a few tightly
controlled environments. Those environments can always enable "secure"
if they require it.


> >=20
> > > >=20
> > > > Thanks,
> > > > NeilBrown
> > > >=20
> > > > >=20
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > > In discussion at the Bake-a-thon, we decided to just go for makin=
g
> > > > > "insecure" the default for all exports.
> > > > > ---
> > > > >  support/nfs/exports.c      | 7 +++++--
> > > > >  utils/exportfs/exports.man | 4 ++--
> > > > >  2 files changed, 7 insertions(+), 4 deletions(-)
> > > > >=20
> > > > > diff --git a/support/nfs/exports.c b/support/nfs/exports.c
> > > > > index 21ec6486ba3d3945df0800972ba1dfd03bd65375..69f8ca8b5e2ed50b8=
37ef287ca0685af3e70ed0b 100644
> > > > > --- a/support/nfs/exports.c
> > > > > +++ b/support/nfs/exports.c
> > > > > @@ -34,8 +34,11 @@
> > > > >  #include "reexport.h"
> > > > >  #include "nfsd_path.h"
> > > > > =20
> > > > > -#define EXPORT_DEFAULT_FLAGS	\
> > > > > -  (NFSEXP_READONLY|NFSEXP_ROOTSQUASH|NFSEXP_GATHERED_WRITES|NFSE=
XP_NOSUBTREECHECK)
> > > > > +#define EXPORT_DEFAULT_FLAGS	(NFSEXP_READONLY |	\
> > > > > +				 NFSEXP_ROOTSQUASH |	\
> > > > > +				 NFSEXP_GATHERED_WRITES |\
> > > > > +				 NFSEXP_NOSUBTREECHECK | \
> > > > > +				 NFSEXP_INSECURE_PORT)
> > > > > =20
> > > > >  struct flav_info flav_map[] =3D {
> > > > >  	{ "krb5",	RPC_AUTH_GSS_KRB5,	1},
> > > > > diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.=
man
> > > > > index 39dc30fb8290213990ca7a14b1b3971140b0d120..0b62bb3a82b0e74bc=
2a7eb84301c4ec97b14d003 100644
> > > > > --- a/utils/exportfs/exports.man
> > > > > +++ b/utils/exportfs/exports.man
> > > > > @@ -180,8 +180,8 @@ understands the following export options:
> > > > >  .TP
> > > > >  .IR secure
> > > > >  This option requires that requests not using gss originate on an
> > > > > -Internet port less than IPPORT_RESERVED (1024). This option is o=
n by default.
> > > > > -To turn it off, specify
> > > > > +Internet port less than IPPORT_RESERVED (1024). This option is o=
ff by default
> > > > > +but can be explicitly disabled by specifying
> > > > >  .IR insecure .
> > > > >  (NOTE: older kernels (before upstream kernel version 4.17) enfor=
ced this
> > > > >  requirement on gss requests as well.)
> > > > >=20
> > > > > ---
> > > > > base-commit: 2cf015ea4312f37598efe9733fef3232ab67f784
> > > > > change-id: 20250513-master-89974087bb04
> > > > >=20
> > > > > Best regards,
> > > > > --=20
> > > > > Jeff Layton <jlayton@kernel.org>
> > > > >=20
> > > > >=20
> > > > >=20
> > > >=20
> > > >=20
> > > >=20
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20

--=20
Jeff Layton <jlayton@kernel.org>

