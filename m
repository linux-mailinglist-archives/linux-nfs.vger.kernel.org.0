Return-Path: <linux-nfs+bounces-11716-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB538AB6A65
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 13:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7931883F30
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 11:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD9325D8FA;
	Wed, 14 May 2025 11:43:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63331F875A
	for <linux-nfs@vger.kernel.org>; Wed, 14 May 2025 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747223022; cv=none; b=NjoQKVngB/cHUduRFOlqF01j/h6nrHVXTKieCvrCX03B6tcGl4u8IKWrrO9CN996O2ejC6Pi3ZqDO4n9ezm+oo2Evb+kItwtj8itQmwomg76nIXTplo5XNcQ4HK8S6iX6rADL1yLIUWFpwb6zZtRD9mAGwP4U6RhvJ7NKz0Yl0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747223022; c=relaxed/simple;
	bh=kpac/k4SUBOMUITBnTTHcGNqi6b+ebnEqQV42txmiO8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=TN+Axia88sq57QBRNvdhvVm0FC69p+5W7XHLc9/JskgBXp7rGqrwHvWck+2n2zfkGw37oCW2zBrQUh+PtWSkIexAx7u2+DruTmEAYtTFhbRmQ5n514DUCER1Lr0U8LNJIUH+Hye08f5csrgj8YvubdSm77RAGAImrOBkNnlDR9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uFAWO-003m1E-9L;
	Wed, 14 May 2025 11:43:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Steve Dickson" <steved@redhat.com>, "Tom Haynes" <loghyr@gmail.com>,
 linux-nfs@vger.kernel.org
Subject:
 Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all exports
In-reply-to: <91b04852a612c651533c62f6f9fc4bd61e97be62.camel@kernel.org>
References: <>, <91b04852a612c651533c62f6f9fc4bd61e97be62.camel@kernel.org>
Date: Wed, 14 May 2025 21:43:35 +1000
Message-id: <174722301596.62796.971181010409022860@noble.neil.brown.name>

On Wed, 14 May 2025, Jeff Layton wrote:
> On Wed, 2025-05-14 at 12:28 +1000, NeilBrown wrote:
> > On Wed, 14 May 2025, NeilBrown wrote:
> > > On Tue, 13 May 2025, Jeff Layton wrote:
> > > > Back in the 80's someone thought it was a good idea to carve out a set
> > > > of ports that only privileged users could use. When NFS was originally
> > > > conceived, Sun made its server require that clients use low ports.
> > > > Since Linux was following suit with Sun in those days, exportfs has
> > > > always defaulted to requiring connections from low ports.
> > > >=20
> > > > These days, anyone can be root on their laptop, so limiting connectio=
ns
> > > > to low source ports is of little value.
> > >=20
> > > But who is going to export any filesystem to their laptop?
> > >=20
> > > >=20
>=20
> The point is that most NFS servers are run on networks where the admin
> may not have 100% control over every host on the network. Once you're
> that situation, relying on low port values for security is basically
> worthless.

"most" ??  Where did you get that statistic?

"Some" are run on in-machine-room networks which are completely
controlled, but which allow local users to log in to unprivileged
accounts.  In this case it makes perfect sense to rely on "privileged"
ports to control access.  If you silently change nfs-utils so that
unprivileged users can have root-level access over NFS, then you are
exposing the file server completely to anyone who can log in to an
server in that local network.  Are you sure you want to do that?

>=20
> > > > Make the default be "insecure" when creating exports.
> > >=20
> > > So you want to break lots of configurations that are working perfectly
> > > well?
> >=20
> > Sorry - I was wrong.  You aren't breaking working configurations, but
> > you are removing a protection that people might be expecting.  It might
> > not be much protection, but it is not zero.
> >=20
>=20
> True. Anyone relying on this "protection" is fooling themselves though.

As above: in some circumstances with physically secure networks
(entirely in a locked room, or entire in a virtualisation host, or a
VPN) it makes perfect sense.

>=20
> > >=20
> > > I don't see any really motivation for this change.  Could you provide it
> > > please?
> >=20
> > Or to put it another way: who benefits?
> >=20
>=20
> Anyone running NFS clients behind NAT?

Maybe that should have been in the commit message?

>=20
> The main discussion came about when we were testing against a
> hammerspace deployment. They were using knfsd as their DS's, and had
> forgotten to add "insecure" to the export options. When the (NAT'ed)
> client tried to talk to the DS's, it got back NFSERR3_PERM because of
> this. It took a little while to ascertain the cause.

"Change default to fix configuration problem"....???
The default must always be the more secure.  "fail safe".

If we want to make this configuration problem more easy to detect, maybe
we should log unprivileged port access (beyond the few requests for
which it can make sense).

>=20
> Note that Solaris' NFS server stopped checking source ports many years
> ago. We're only doing this now because we followed suit from how they
> behaved in the 90s and never changed it.

I wonder why Sun went out of business.....

Ignoring source ports makes no sense at all unless you enforce some other
authentication, like krb5 or TLS, or unless you *know* that there are no
unprivileged processes running on any client machines.

Thanks,
NeilBrown=20


>=20
> > >=20
> > > Thanks,
> > > NeilBrown
> > >=20
> > > >=20
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > > In discussion at the Bake-a-thon, we decided to just go for making
> > > > "insecure" the default for all exports.
> > > > ---
> > > >  support/nfs/exports.c      | 7 +++++--
> > > >  utils/exportfs/exports.man | 4 ++--
> > > >  2 files changed, 7 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/support/nfs/exports.c b/support/nfs/exports.c
> > > > index 21ec6486ba3d3945df0800972ba1dfd03bd65375..69f8ca8b5e2ed50b837ef=
287ca0685af3e70ed0b 100644
> > > > --- a/support/nfs/exports.c
> > > > +++ b/support/nfs/exports.c
> > > > @@ -34,8 +34,11 @@
> > > >  #include "reexport.h"
> > > >  #include "nfsd_path.h"
> > > > =20
> > > > -#define EXPORT_DEFAULT_FLAGS	\
> > > > -  (NFSEXP_READONLY|NFSEXP_ROOTSQUASH|NFSEXP_GATHERED_WRITES|NFSEXP_N=
OSUBTREECHECK)
> > > > +#define EXPORT_DEFAULT_FLAGS	(NFSEXP_READONLY |	\
> > > > +				 NFSEXP_ROOTSQUASH |	\
> > > > +				 NFSEXP_GATHERED_WRITES |\
> > > > +				 NFSEXP_NOSUBTREECHECK | \
> > > > +				 NFSEXP_INSECURE_PORT)
> > > > =20
> > > >  struct flav_info flav_map[] =3D {
> > > >  	{ "krb5",	RPC_AUTH_GSS_KRB5,	1},
> > > > diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
> > > > index 39dc30fb8290213990ca7a14b1b3971140b0d120..0b62bb3a82b0e74bc2a7e=
b84301c4ec97b14d003 100644
> > > > --- a/utils/exportfs/exports.man
> > > > +++ b/utils/exportfs/exports.man
> > > > @@ -180,8 +180,8 @@ understands the following export options:
> > > >  .TP
> > > >  .IR secure
> > > >  This option requires that requests not using gss originate on an
> > > > -Internet port less than IPPORT_RESERVED (1024). This option is on by=
 default.
> > > > -To turn it off, specify
> > > > +Internet port less than IPPORT_RESERVED (1024). This option is off b=
y default
> > > > +but can be explicitly disabled by specifying
> > > >  .IR insecure .
> > > >  (NOTE: older kernels (before upstream kernel version 4.17) enforced =
this
> > > >  requirement on gss requests as well.)
> > > >=20
> > > > ---
> > > > base-commit: 2cf015ea4312f37598efe9733fef3232ab67f784
> > > > change-id: 20250513-master-89974087bb04
> > > >=20
> > > > Best regards,
> > > > --=20
> > > > Jeff Layton <jlayton@kernel.org>
> > > >=20
> > > >=20
> > > >=20
> > >=20
> > >=20
> > >=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20


