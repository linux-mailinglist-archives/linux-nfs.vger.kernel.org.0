Return-Path: <linux-nfs+bounces-20394-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qG7QGL1FxGm1xwQAu9opvQ
	(envelope-from <linux-nfs+bounces-20394-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 21:29:49 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 662D432BD77
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 21:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F23DD3012810
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 20:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4850E372EF6;
	Wed, 25 Mar 2026 20:29:39 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47CD372ECF;
	Wed, 25 Mar 2026 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774470579; cv=none; b=bzqHj93ee/TbfGN4lLJqEz/x5FNFf5AOsLyAf0v4+YSZ8bsysIktgJ5iEdoor9TYeaf8SZ64g0xjI3AtHdwnzeUav20yrtNyIniLMRFYLE55yx7CVQBg5TedcmPDQycSzHkEp/ZI+rvumADC4Iz1hfUBtorAsY7B0HMHii+3GuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774470579; c=relaxed/simple;
	bh=J2KTQLJtj/cmPEnsk8n2KBtfd9UmjZewpH2hwmIc5kE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iX3k6/EfD6oKVgGWHnDm9LY+DWBEV8Y8GJIbrpIqH+eLXJ05ZBlKO8Up3X+ipaLrJZSx5Y+2HfM2NFh7S3DHp8u+UQCNxI73bqu3iMGN8Hx1JJzsgZa0Iv94Z+HUUcUx0hbZAdc3c/a2D8r1PHA/01GjhAumonqeF5cc2jMp18s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:1810:1d14:e000:db6f:81d2:6624:c91c] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1w5Uqu-001ofs-1V;
	Wed, 25 Mar 2026 20:29:19 +0000
Received: from ben by deadeye with local (Exim 4.99.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1w5Uqp-00000004iOy-2hHi;
	Wed, 25 Mar 2026 21:29:15 +0100
Message-ID: <eab4db41a02c4342bd6e5397f663c4e651f22e31.camel@decadent.org.uk>
Subject: Re: Bug#1128861: [PATCH] lockd: fix TEST handling when not all
 permissions are available.
From: Ben Hutchings <ben@decadent.org.uk>
To: NeilBrown <neil@brown.name>, 1128861@bugs.debian.org, Chuck Lever
	 <cel@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Thorsten Leemhuis
	 <regressions@leemhuis.info>, Tj <tj.iam.tj@proton.me>, 
	linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>, 
	stable@vger.kernel.org
Date: Wed, 25 Mar 2026 21:29:09 +0100
In-Reply-To: <177442248735.2237155.773724155681455344@noble.neil.brown.name>
References: <c0f15088-3fc0-487a-9f24-cf89c158420d@proton.me>
	, <177266540127.7472.3460090956713656639@noble.neil.brown.name>
	, <6ba41798-9c69-44f5-9a4e-09336c75a4b9@leemhuis.info>
	, <cf78feb7ffaee6ed478afb734d2ede149597de86.camel@kernel.org>
	, <177434721528.7102.13514118512738778346@noble.neil.brown.name>
	, <d4773958-5ae5-42d4-b785-6598b5c9b27a@app.fastmail.com>
	 <177187492815.425331.14320091315652332093.reportbug@nimble>
	 <177442248735.2237155.773724155681455344@noble.neil.brown.name>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-StOfTySkQjzSGJ9fd77x"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:1810:1d14:e000:db6f:81d2:6624:c91c
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DMARC_NA(0.00)[decadent.org.uk];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-20394-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 662D432BD77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-StOfTySkQjzSGJ9fd77x
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-03-25 at 18:08 +1100, NeilBrown wrote:
> On Wed, 25 Mar 2026, Chuck Lever wrote:
> >=20
> > On Tue, Mar 24, 2026, at 6:13 AM, NeilBrown wrote:
> > > From: NeilBrown <neil@brown.name>
> > >=20
> > > The F_GETLK fcntl can work with either read access or write access or
> > > both.  It can query F_RDLCK and F_WRLCK locks in either case.
> > >=20
> > > However lockd currently treats F_GETLK similar to F_SETLK in that rea=
d
> > > access is required to query an F_RDLCK lock and write access is requi=
red
> > > to query a F_WRLCK lock.
> > >=20
> > > This is wrong and can cause problem - e.g.  when qemu accesses a
> > > read-only (e.g. iso) filesystem image over NFS (though why it queries
> > > if it can get a write lock - I don't know.  But it does, and this wor=
ks
> > > with local filesystems).
> > >=20
> > > So we need TEST requests to be handled differently.  To do this:
> > >=20
> > > - change nlm_do_fopen() to accept O_RDWR as a mode and in that case
> > >   succeed if either a O_RDONLY or O_WRONLY file can be opened.
> > > - change nlm_lookup_file() to accept a mode argument from caller,
> > >   instead of deducing base on lock time, and pass that on to nlm_do_f=
open()
> > > - change nlm4svc_retrieve_args() and nlmsvc_retrieve_args() to detect
> > >   TEST requests and pass O_RDWR as a mode to nlm_lookup_file, passing
> > >   the same mode as before for other requests.  Also set
> > >    lock->fl.c.flc_file to whichever file is available for TEST reques=
ts.
> > > - change nlmsvc_testlock() to also not calculate the mode, but to use
> > >   whenever was stored in lock->fl.c.flc_file.
> > >=20
> > > Reported-by: Tj <tj.iam.tj@proton.me>
> > > Link:  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1128861
> > > Fixes: 7f024fcd5c97 ("Keep read and write fds with each nlm_file")
> > > Signed-off-by: NeilBrown <neil@brown.name>
> >=20
> > Hi Neil, which kernels should this fix apply to?
> >=20
>=20
> v6.13 and later. So linux-6.18.y and linux-6.19.y

6.12.y is also affected since commit 4cc9b9f2bf4d was backported there
(triggering this bug report).

Ben.

>=20
> The Fixes: tag is actually wrong.  This bug has been present forever.
> However a different bug that=20
>   Commit: 4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK")
> fixed was hiding the bug.
>=20
> So it should probably be marked
>   Fixes: 4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK")
> with an explanation.
>=20
> NeilBrown

--=20
Ben Hutchings
Theory and practice are closer in theory than in practice - John Levine

--=-StOfTySkQjzSGJ9fd77x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmnERZYACgkQ57/I7JWG
EQkcsA/+P9OPKkweOPNqOeCWouseIy/CyJKqNhLGjkCMsT/c+K3UtHKmioGin2Zu
2qKNGyPkfvdGfhlMZGcjE/0ZA6N/HD24fnNTH0p0xzcIE3U6OJ+lcaqbdOvs45y8
wcLF/v8B4KD3HwzcxqIEty/yJjuzzvgii7xOHzeah59yhY2sElxYyZrNrxDaQ8hZ
SeTGvVWWJEgm3zYTykG5Yu0pdCWgj2rkbJFBebRWw41fnHBbEw28zINjQRs5usaA
40ZGQkM1F0QSOABWzuakN50XJfvs/XfKgiRAUzifeH0qaUXE2mC4Zdx+GGSwTRb8
8l/ASuz3at8lDSNglY+E956o8zekI0TUN3jrv5ViO2dwvBfh3zIYXNHytroJNjBV
ZiL+XpW94rWOSTvpSQd0a6W/2jbyiIy2brdqj71BbrbdpPcuoaEVOFodKqbcqmsd
uBm6vApisOzLX5jwOUgfnYBdpj4XQh3gGgbTm6k3khLt0Ok6I7fWCJb3gHEHHFGU
UfD185p1E1YdPXFYj8aWkKdO6RJnOIQKZ4w+s9PJDFl9h8wifCIqMOGlMIVbrWSN
ZdU1Xs/lT6xH6NDY8z+iIJkrE6LBjO2+rS4GjqXk8I4FoFgP5BCP7TlZKnBwTczc
XvNJ5reVXnDaFOcO9v420KZ8u2BbYjzk6f0jPe1omz9WJ9YJ82M=
=Dg/J
-----END PGP SIGNATURE-----

--=-StOfTySkQjzSGJ9fd77x--

