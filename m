Return-Path: <linux-nfs+bounces-9680-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE09A1D880
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 15:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343863A32CE
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 14:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608FFDF59;
	Mon, 27 Jan 2025 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dd0Ygud8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35680747F;
	Mon, 27 Jan 2025 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737988463; cv=none; b=CpyvSnEz6AbaX9g3xSGN4l2cCFO5f7OraYUvkYlzfCFpx92lRBC8PK3uUBALcymEYgeqNaDv8phT0yDOd/JVSyZLeD4eX2HFNQOhhES9TvZm6HbQ5nMdOmgOI7PTt5k2BhAz4EFbPkZygC9YBMtX1uWweoPzJ7gPJukvZFYCs44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737988463; c=relaxed/simple;
	bh=33nU/3JDqRo1KxZPmryx5Y1e1UKEkODcxfRRU9alWuw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YEycoLGBz30LqTb9DRTyEhazsoFqjVGQVQTGSD7w6ibRukI/5fzRHkH2TKnuYXYnzp1QFI6phgJQGRaLQD0rwTF4XGZHEsFFt8UKxBSezanTPybcOjIGEvLJH4tHSUg/X2JBngKtOil9TauNgU8sZ66/C4dzPpM3rlyiL6h8bgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dd0Ygud8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6335C4CEE1;
	Mon, 27 Jan 2025 14:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737988462;
	bh=33nU/3JDqRo1KxZPmryx5Y1e1UKEkODcxfRRU9alWuw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Dd0Ygud8Dnc+zF7WaNJ2j5C3lQ80gEE9BFCdejXock8eYdn3xhSN3c9G0Afp4csW9
	 l9zXzG+x5RdUtcfhrYJuJkNLu2+e3lALCH+n8+59GmiNwb4Bejh0SCnlYiTdBGmXnf
	 JdPYALoBAsnDZTzORU6QJYb71GVlvMgcsH49VyNuJUuJydTmYtHmEIuDdFS7B246Ou
	 qDTHSti2SqDp6PZJMf3jwCgb1y3kSptXwvcjvNNsasuNHD0Nc2+NcjIePnAujLAbWT
	 ipGYFWDNRHpfaabY/mM6KYFR8lBbqoZ8dbNGk7TYp0/Z7iuvX2Ewl4wTuVsbtkUaA2
	 RFxUwaQ+2WDsw==
Message-ID: <b582a2aba4abf425b533637bd2ab8546d49784ae.camel@kernel.org>
Subject: Re: [PATCH] nfsd: validate the nfsd_serv pointer before calling
 svc_wake_up
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neilb@suse.de>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Salvatore Bonaccorso <carnil@debian.org>,
 linux-nfs@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 27 Jan 2025 09:34:20 -0500
In-Reply-To: <37fb186b-ffb6-44dc-a097-ec669079c801@oracle.com>
References: <> <a3ca70c78e48e1a36d29741eb8913ce85e3f51a2.camel@kernel.org>
	 <173793694589.22054.1830112177481945773@noble.neil.brown.name>
	 <06379c169fb0e891dae9d444ef0a06ea57e9af38.camel@kernel.org>
	 <c70d155c-22e0-43f7-af23-241088317d94@oracle.com>
	 <5923519a4c8f6bb6d5ccd2697447b313fb61bba3.camel@kernel.org>
	 <ac965f67-db15-4f93-be03-878e6a3d171b@oracle.com>
	 <37fb186b-ffb6-44dc-a097-ec669079c801@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-01-27 at 09:03 -0500, Chuck Lever wrote:
> On 1/27/25 8:39 AM, Chuck Lever wrote:
> > On 1/27/25 8:32 AM, Jeff Layton wrote:
> > > On Mon, 2025-01-27 at 08:22 -0500, Chuck Lever wrote:
> > > > On 1/27/25 8:07 AM, Jeff Layton wrote:
> > > > > On Mon, 2025-01-27 at 11:15 +1100, NeilBrown wrote:
> > > > > > On Mon, 27 Jan 2025, Jeff Layton wrote:
> > > > > > > On Mon, 2025-01-27 at 08:53 +1100, NeilBrown wrote:
> > > > > > > > On Sun, 26 Jan 2025, Jeff Layton wrote:
> > > > > > > > > On Sun, 2025-01-26 at 13:39 +1100, NeilBrown wrote:
> > > > > > > > > > On Sun, 26 Jan 2025, Jeff Layton wrote:
> > > > > > > > > > > nfsd_file_dispose_list_delayed can be called from the=
 filecache
> > > > > > > > > > > laundrette, which is shut down after the nfsd threads=
 are shut=20
> > > > > > > > > > > down and
> > > > > > > > > > > the nfsd_serv pointer is cleared. If nn->nfsd_serv is=
 NULL=20
> > > > > > > > > > > then there
> > > > > > > > > > > are no threads to wake.
> > > > > > > > > > >=20
> > > > > > > > > > > Ensure that the nn->nfsd_serv pointer is non-NULL bef=
ore calling
> > > > > > > > > > > svc_wake_up in nfsd_file_dispose_list_delayed. This i=
s safe=20
> > > > > > > > > > > since the
> > > > > > > > > > > svc_serv is not freed until after the filecache laund=
rette is=20
> > > > > > > > > > > cancelled.
> > > > > > > > > > >=20
> > > > > > > > > > > Fixes: ffb402596147 ("nfsd: Don't leave work of closi=
ng files=20
> > > > > > > > > > > to a work queue")
> > > > > > > > > > > Reported-by: Salvatore Bonaccorso <carnil@debian.org>
> > > > > > > > > > > Closes: https://lore.kernel.org/linux-=20
> > > > > > > > > > > nfs/7d9f2a8aede4f7ca9935a47e1d405643220d7946.camel@ke=
rnel.org/
> > > > > > > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > > > > > ---
> > > > > > > > > > > This is only lightly tested, but I think it will fix =
the bug that
> > > > > > > > > > > Salvatore reported.
> > > > > > > > > > > ---
> > > > > > > > > > > =C2=A0=C2=A0 fs/nfsd/filecache.c | 11 ++++++++++-
> > > > > > > > > > > =C2=A0=C2=A0 1 file changed, 10 insertions(+), 1 dele=
tion(-)
> > > > > > > > > > >=20
> > > > > > > > > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.=
c
> > > > > > > > > > > index=20
> > > > > > > > > > > e91c164b5ea21507659904690533a19ca43b1b64..fb2a4469b7a=
3c077de2dd750f43239b4af6d37b0 100644
> > > > > > > > > > > --- a/fs/nfsd/filecache.c
> > > > > > > > > > > +++ b/fs/nfsd/filecache.c
> > > > > > > > > > > @@ -445,11 +445,20 @@ nfsd_file_dispose_list_delayed(=
struct=20
> > > > > > > > > > > list_head *dispose)
> > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfsd_file, nf_gc);
> > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct nfsd_net *nn =3D net_generic(nf->nf_net,=20
> > > > > > > > > > > nfsd_net_id);
> > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sv=
c_serv *serv;
> > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 spin_lock(&l->lock);
> > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 list_move_tail(&nf->nf_gc, &l->freeme);
> > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 spin_unlock(&l->lock);
> > > > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 svc_wake_=
up(nn->nfsd_serv);
> > > > > > > > > > > +
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * T=
he filecache laundrette is shut down after the
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * n=
n->nfsd_serv pointer is cleared, but before the
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * s=
vc_serv is freed.
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 serv =3D =
nn->nfsd_serv;
> > > > > > > > > >=20
> > > > > > > > > > I wonder if this should be READ_ONCE() to tell the comp=
iler=20
> > > > > > > > > > that we
> > > > > > > > > > could race with clearing nn->nfsd_serv.=C2=A0 Would the=
 comment=20
> > > > > > > > > > still be
> > > > > > > > > > needed?
> > > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > I think we need a comment at least. The linkage between t=
he=20
> > > > > > > > > laundrette
> > > > > > > > > and the nfsd_serv being set to NULL is very subtle. A REA=
D_ONCE()
> > > > > > > > > doesn't convey that well, and is unnecessary here.
> > > > > > > >=20
> > > > > > > > Why do you say "is unnecessary here" ?
> > > > > > > > If the code were
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 if (nn->nfsd_serv)
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 svc_wake_up(nn->nfsd_serv);
> > > > > > > > that would be wrong as nn->nfds_serv could be set to NULL b=
etween=20
> > > > > > > > the
> > > > > > > > two.
> > > > > > > > And the C compile is allowed to load the value twice becaus=
e the=20
> > > > > > > > C memory
> > > > > > > > model declares that would have the same effect.
> > > > > > > > While I doubt it would actually change how the code is comp=
iled,=20
> > > > > > > > I think
> > > > > > > > we should have READ_ONCE() here (and I've been wrong before=
 about=20
> > > > > > > > what
> > > > > > > > the compiler will actually do).
> > > > > > > >=20
> > > > > > > >=20
> > > > > > >=20
> > > > > > > It's unnecessary because the outcome of either case is accept=
able.
> > > > > > >=20
> > > > > > > When racing with shutdown, either it's NULL and the laundrett=
e won't
> > > > > > > call svc_wake_up(), or it's non-NULL and it will. In the non-=
NULL=20
> > > > > > > case,
> > > > > > > the call to svc_wake_up() will be a no-op because the threads=
 are=20
> > > > > > > shut
> > > > > > > down.
> > > > > > >=20
> > > > > > > The vastly common case in this code is that this pointer will=
 be non-
> > > > > > > NULL, because the server is running (i.e. not racing with=20
> > > > > > > shutdown). I
> > > > > > > don't see the need in making all of those accesses volatile.
> > > > > >=20
> > > > > > One of us is confused.=C2=A0 I hope it isn't me.
> > > > > >=20
> > > > >=20
> > > > > It's probably me. I think you have a much better understanding of
> > > > > compiler design than I do. Still...
> > > > >=20
> > > > > > The hypothetical problem I see is that the C compiler could gen=
erate
> > > > > > code to load the value "nn->nfsd_serv" twice.=C2=A0 The first t=
ime it is=20
> > > > > > not
> > > > > > NULL, the second time it is NULL.
> > > > > > The first is used for the test, the second is passed to svc_wak=
e_up().
> > > > > >=20
> > > > > > Unlikely though this is, it is possible and READ_ONCE() is desi=
gned
> > > > > > precisely to prevent this.
> > > > > > To quote from include/asm-generic/rwonce.h it will
> > > > > > =C2=A0=C2=A0 "Prevent the compiler from merging or refetching r=
eads"
> > > > > >=20
> > > > > > A "volatile" access does not add any cost (in this case).=C2=A0=
 What it=20
> > > > > > does
> > > > > > is break any aliasing that the compile might have deduced.
> > > > > > Even if the compiler thinks it has "nn->nfsd_serv" in a registe=
r, it
> > > > > > won't think it has the result of READ_ONCE(nn->nfsd_serv) in th=
at=20
> > > > > > register.
> > > > > > And if it needs the result of a previous READ_ONCE(nn->nfsd_ser=
v) it
> > > > > > won't decide that it can just read nn->nfsd_serv again.=C2=A0 I=
t MUST keep
> > > > > > the result of READ_ONCE(nn->nfsd_serv) somewhere until it is no=
t=20
> > > > > > needed
> > > > > > any more.
> > > > >=20
> > > > > I'm mainly just considering the resulting pointer. There are two
> > > > > possible outcomes to the fetch of nn->nfsd_serv. Either it's a va=
lid
> > > > > pointer that points to the svc_serv, or it's NULL. The resulting =
code
> > > > > can handle either case, so it doesn't seem like adding READ_ONCE(=
) will
> > > > > create any material difference here.
> > > > >=20
> > > > > Maybe I should ask it this way: What bad outcome could result if =
we
> > > > > don't add READ_ONCE() here?
> > > >=20
> > > > Neil just described it. The compiler would generate two load operat=
ions,
> > > > one for the test and one for the function call argument. The first =
load
> > > > can retrieve a non-NULL address, and the second a NULL address.
> > > >=20
> > > > I agree a READ_ONCE() is necessary.
> > > >=20
> > > >=20
> > >=20
> > > Now I'm confused:
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct svc_serv *serv;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [...]
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The filecache laundrette is shut down a=
fter the
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * nn->nfsd_serv pointer is cleared, but b=
efore the
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * svc_serv is freed.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 serv =3D nn->nfsd_serv;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (serv)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 svc_wake_up(serv);
> > >=20
> > > This code is explicitly asking to fetch nn->nfsd_serv into the serv
> > > variable, and then is testing that copy of the pointer and passing it
> > > into svc_wake_up().
> > >=20
> > > How is the compiler allowed to suddenly refetch a NULL pointer into
> > > serv after testing that serv is non-NULL?
> >=20
> > There's nothing here that tells the compiler it is not allowed to
> > optimize this into two separate fetches if it feels that is better
> > code. READ_ONCE is what tells the compiler we do not want that re-
> > organization /ever/.
> >=20
> >=20
>=20
> Well, I think you can argue that even if the compiler does split this
> code into two reads of nn->nfsd_serv, it is guaranteed that the read
> value is always the same both times -- I guess that's that the comment
> is arguing, yes?
>=20

Exactly. That's why I didn't just do:

if (nn->nfsd_serv)
	svc_destroy(nn->nfsd_serv);

We just have to ensure that we don't pass a NULL pointer to
svc_destroy() and that should be guaranteed by fetching it into an
interim variable.=C2=A0

A READ_ONCE() doesn't buy us anything extra in this situation. It
ensures that it doesn't use a cached version of nn->nfsd_serv when it
does the fetch, but using a cached version is harmless here. Either way
will still work.

Plus, if this had access to a cached version of that variable in a
register, it avoided a memory fetch. Given that this should almost
never be NULL, adding READ_ONCE() seems like a waste.

> I just wonder what will happen if that guarantee should happen to change
> in the future.

I think the only way this could break would be if nfsd_destroy_serv()
started calling svc_destroy(&serv) before canceling the laundrette wq
job. Maybe it's worth a comment in there pointing out that dependency.

--=20
Jeff Layton <jlayton@kernel.org>

