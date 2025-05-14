Return-Path: <linux-nfs+bounces-11707-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E96BAB60B8
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 04:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0143A46331E
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 02:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E7BBA49;
	Wed, 14 May 2025 02:28:37 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB4728EC
	for <linux-nfs@vger.kernel.org>; Wed, 14 May 2025 02:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747189717; cv=none; b=UwF3vb8yz05uzjyoTI1g+vT2Eie0N1Akqvv2jHRxc++gZTtaa7dEmhcKkxLK87Ou5vuQnzpTh6eURhkaz/QcZij7KexCvO3FND8tkhnYuDhPyVwNwI/V+PkEImQdec0AxUAusdIPNhKyiWkCRk4+DDgUnzdQZZ7kq3r8mdUUXF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747189717; c=relaxed/simple;
	bh=s1oIn4PNi5BvSdsZvwlYcXkVReV14ZkO/zEo7XiU7dU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=pj5wFAxygURj5chf2tiqJ+M4V1Lg0rRMC6JzoQv8joOn5wlO6LjFNKpVipc6pnBbXDoDhavLjXRq2rdPS+olGXdDggl6PEjmowya2SofjorEkjm8b+H9Fa4aaD6P/bGFyNbLacJEJVVFlHIDwUj0MQPkeq9HF00hZYtR60YO8bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uF1rC-003PSs-V1;
	Wed, 14 May 2025 02:28:30 +0000
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
 linux-nfs@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>
Subject:
 Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all exports
In-reply-to: <174718900620.62796.18240600261000060825@noble.neil.brown.name>
References: <20250513-master-v1-1-e845fe412715@kernel.org>,
 <174718900620.62796.18240600261000060825@noble.neil.brown.name>
Date: Wed, 14 May 2025 12:28:24 +1000
Message-id: <174718970409.62796.16127055429561662161@noble.neil.brown.name>

On Wed, 14 May 2025, NeilBrown wrote:
> On Tue, 13 May 2025, Jeff Layton wrote:
> > Back in the 80's someone thought it was a good idea to carve out a set
> > of ports that only privileged users could use. When NFS was originally
> > conceived, Sun made its server require that clients use low ports.
> > Since Linux was following suit with Sun in those days, exportfs has
> > always defaulted to requiring connections from low ports.
> >=20
> > These days, anyone can be root on their laptop, so limiting connections
> > to low source ports is of little value.
>=20
> But who is going to export any filesystem to their laptop?
>=20
> >=20
> > Make the default be "insecure" when creating exports.
>=20
> So you want to break lots of configurations that are working perfectly
> well?

Sorry - I was wrong.  You aren't breaking working configurations, but
you are removing a protection that people might be expecting.  It might
not be much protection, but it is not zero.

>=20
> I don't see any really motivation for this change.  Could you provide it
> please?

Or to put it another way: who benefits?

Thanks,
NeilBrown


>=20
> Thanks,
> NeilBrown
>=20
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > In discussion at the Bake-a-thon, we decided to just go for making
> > "insecure" the default for all exports.
> > ---
> >  support/nfs/exports.c      | 7 +++++--
> >  utils/exportfs/exports.man | 4 ++--
> >  2 files changed, 7 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/support/nfs/exports.c b/support/nfs/exports.c
> > index 21ec6486ba3d3945df0800972ba1dfd03bd65375..69f8ca8b5e2ed50b837ef287c=
a0685af3e70ed0b 100644
> > --- a/support/nfs/exports.c
> > +++ b/support/nfs/exports.c
> > @@ -34,8 +34,11 @@
> >  #include "reexport.h"
> >  #include "nfsd_path.h"
> > =20
> > -#define EXPORT_DEFAULT_FLAGS	\
> > -  (NFSEXP_READONLY|NFSEXP_ROOTSQUASH|NFSEXP_GATHERED_WRITES|NFSEXP_NOSUB=
TREECHECK)
> > +#define EXPORT_DEFAULT_FLAGS	(NFSEXP_READONLY |	\
> > +				 NFSEXP_ROOTSQUASH |	\
> > +				 NFSEXP_GATHERED_WRITES |\
> > +				 NFSEXP_NOSUBTREECHECK | \
> > +				 NFSEXP_INSECURE_PORT)
> > =20
> >  struct flav_info flav_map[] =3D {
> >  	{ "krb5",	RPC_AUTH_GSS_KRB5,	1},
> > diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
> > index 39dc30fb8290213990ca7a14b1b3971140b0d120..0b62bb3a82b0e74bc2a7eb843=
01c4ec97b14d003 100644
> > --- a/utils/exportfs/exports.man
> > +++ b/utils/exportfs/exports.man
> > @@ -180,8 +180,8 @@ understands the following export options:
> >  .TP
> >  .IR secure
> >  This option requires that requests not using gss originate on an
> > -Internet port less than IPPORT_RESERVED (1024). This option is on by def=
ault.
> > -To turn it off, specify
> > +Internet port less than IPPORT_RESERVED (1024). This option is off by de=
fault
> > +but can be explicitly disabled by specifying
> >  .IR insecure .
> >  (NOTE: older kernels (before upstream kernel version 4.17) enforced this
> >  requirement on gss requests as well.)
> >=20
> > ---
> > base-commit: 2cf015ea4312f37598efe9733fef3232ab67f784
> > change-id: 20250513-master-89974087bb04
> >=20
> > Best regards,
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20
> >=20
> >=20
>=20
>=20
>=20


