Return-Path: <linux-nfs+bounces-9661-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AED5A1D6DA
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 14:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD3E1623AC
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 13:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7AB1FF5EF;
	Mon, 27 Jan 2025 13:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IojiV8gt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7587F1FF1CA;
	Mon, 27 Jan 2025 13:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737984740; cv=none; b=aBn79e/d94EKoTeP9dgMesP+PPiIIC4oJJucA6B3MN3OMmKVZvgpiDQF8qDJol7L+YLIKlMtHNyvcaMiWQPs60iJyiCOVTSHWwrNWlj7LsIKwO0gavUS7pV3DGCCHxmZCeRCrMQc/qZaPKJi58RpipJGqpQ7WixIS8ddRCl8zDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737984740; c=relaxed/simple;
	bh=JXnzWgOjr35/qnuXmEPRkHpH7XXxEwnMAt0gSSgNAgs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fpJ0FaIZ/iRUnoUQbbhIVlOK5Kb4Gv+n9uxk7gxlqfTDWsTNEjoBL83jK04chK+mpaSEANciUhZ67GB4vJvkOz9pBkSiQDtlCDkbSs5vyxoWi0KjSkHOdDplz3g+CCeMifBmVnc+/35KMyd5bfreBFSwM/0rZhlq0gXXXp4WmMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IojiV8gt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F414C4CED2;
	Mon, 27 Jan 2025 13:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737984739;
	bh=JXnzWgOjr35/qnuXmEPRkHpH7XXxEwnMAt0gSSgNAgs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=IojiV8gtFx9QbielOgONprZIPDmPCrI6DD2KhN8hfqEDI3oEG6PXIxBKY0gMCxnhr
	 5Ksgbugn5n41cc8Lg3/uNNWdsl+JUfyHoa4MXE3B9di2Wq1veHSLfZ98ymqw7NQVlF
	 EpTMer5rSF5uXdWwynzaN1cPRN55w1uzFrwp3OOJyH0ErTcZy/FgwNFUPFVkoE7mjP
	 UiLmYlzQQU37jenuiWSsV7gB/GLKJWNT/B1s5Z3r+sLDp31OT1pb5FkpDdO6sO68Wb
	 X4UXBZkbbndoFOrHVwYipW4169Voaq1JMOH5PDCw28/jd5V4y/F5IzR9lIzB2ZmMv7
	 8BJmcccIentDg==
Message-ID: <5923519a4c8f6bb6d5ccd2697447b313fb61bba3.camel@kernel.org>
Subject: Re: [PATCH] nfsd: validate the nfsd_serv pointer before calling
 svc_wake_up
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neilb@suse.de>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Salvatore Bonaccorso <carnil@debian.org>,
 linux-nfs@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 27 Jan 2025 08:32:18 -0500
In-Reply-To: <c70d155c-22e0-43f7-af23-241088317d94@oracle.com>
References: <> <a3ca70c78e48e1a36d29741eb8913ce85e3f51a2.camel@kernel.org>
	 <173793694589.22054.1830112177481945773@noble.neil.brown.name>
	 <06379c169fb0e891dae9d444ef0a06ea57e9af38.camel@kernel.org>
	 <c70d155c-22e0-43f7-af23-241088317d94@oracle.com>
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

On Mon, 2025-01-27 at 08:22 -0500, Chuck Lever wrote:
> On 1/27/25 8:07 AM, Jeff Layton wrote:
> > On Mon, 2025-01-27 at 11:15 +1100, NeilBrown wrote:
> > > On Mon, 27 Jan 2025, Jeff Layton wrote:
> > > > On Mon, 2025-01-27 at 08:53 +1100, NeilBrown wrote:
> > > > > On Sun, 26 Jan 2025, Jeff Layton wrote:
> > > > > > On Sun, 2025-01-26 at 13:39 +1100, NeilBrown wrote:
> > > > > > > On Sun, 26 Jan 2025, Jeff Layton wrote:
> > > > > > > > nfsd_file_dispose_list_delayed can be called from the filec=
ache
> > > > > > > > laundrette, which is shut down after the nfsd threads are s=
hut down and
> > > > > > > > the nfsd_serv pointer is cleared. If nn->nfsd_serv is NULL =
then there
> > > > > > > > are no threads to wake.
> > > > > > > >=20
> > > > > > > > Ensure that the nn->nfsd_serv pointer is non-NULL before ca=
lling
> > > > > > > > svc_wake_up in nfsd_file_dispose_list_delayed. This is safe=
 since the
> > > > > > > > svc_serv is not freed until after the filecache laundrette =
is cancelled.
> > > > > > > >=20
> > > > > > > > Fixes: ffb402596147 ("nfsd: Don't leave work of closing fil=
es to a work queue")
> > > > > > > > Reported-by: Salvatore Bonaccorso <carnil@debian.org>
> > > > > > > > Closes: https://lore.kernel.org/linux-nfs/7d9f2a8aede4f7ca9=
935a47e1d405643220d7946.camel@kernel.org/
> > > > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > > ---
> > > > > > > > This is only lightly tested, but I think it will fix the bu=
g that
> > > > > > > > Salvatore reported.
> > > > > > > > ---
> > > > > > > >   fs/nfsd/filecache.c | 11 ++++++++++-
> > > > > > > >   1 file changed, 10 insertions(+), 1 deletion(-)
> > > > > > > >=20
> > > > > > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > > > > > index e91c164b5ea21507659904690533a19ca43b1b64..fb2a4469b7a=
3c077de2dd750f43239b4af6d37b0 100644
> > > > > > > > --- a/fs/nfsd/filecache.c
> > > > > > > > +++ b/fs/nfsd/filecache.c
> > > > > > > > @@ -445,11 +445,20 @@ nfsd_file_dispose_list_delayed(struct=
 list_head *dispose)
> > > > > > > >   						struct nfsd_file, nf_gc);
> > > > > > > >   		struct nfsd_net *nn =3D net_generic(nf->nf_net, nfsd_ne=
t_id);
> > > > > > > >   		struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
> > > > > > > > +		struct svc_serv *serv;
> > > > > > > >  =20
> > > > > > > >   		spin_lock(&l->lock);
> > > > > > > >   		list_move_tail(&nf->nf_gc, &l->freeme);
> > > > > > > >   		spin_unlock(&l->lock);
> > > > > > > > -		svc_wake_up(nn->nfsd_serv);
> > > > > > > > +
> > > > > > > > +		/*
> > > > > > > > +		 * The filecache laundrette is shut down after the
> > > > > > > > +		 * nn->nfsd_serv pointer is cleared, but before the
> > > > > > > > +		 * svc_serv is freed.
> > > > > > > > +		 */
> > > > > > > > +		serv =3D nn->nfsd_serv;
> > > > > > >=20
> > > > > > > I wonder if this should be READ_ONCE() to tell the compiler t=
hat we
> > > > > > > could race with clearing nn->nfsd_serv.  Would the comment st=
ill be
> > > > > > > needed?
> > > > > > >=20
> > > > > >=20
> > > > > > I think we need a comment at least. The linkage between the lau=
ndrette
> > > > > > and the nfsd_serv being set to NULL is very subtle. A READ_ONCE=
()
> > > > > > doesn't convey that well, and is unnecessary here.
> > > > >=20
> > > > > Why do you say "is unnecessary here" ?
> > > > > If the code were
> > > > >     if (nn->nfsd_serv)
> > > > >              svc_wake_up(nn->nfsd_serv);
> > > > > that would be wrong as nn->nfds_serv could be set to NULL between=
 the
> > > > > two.
> > > > > And the C compile is allowed to load the value twice because the =
C memory
> > > > > model declares that would have the same effect.
> > > > > While I doubt it would actually change how the code is compiled, =
I think
> > > > > we should have READ_ONCE() here (and I've been wrong before about=
 what
> > > > > the compiler will actually do).
> > > > >=20
> > > > >=20
> > > >=20
> > > > It's unnecessary because the outcome of either case is acceptable.
> > > >=20
> > > > When racing with shutdown, either it's NULL and the laundrette won'=
t
> > > > call svc_wake_up(), or it's non-NULL and it will. In the non-NULL c=
ase,
> > > > the call to svc_wake_up() will be a no-op because the threads are s=
hut
> > > > down.
> > > >=20
> > > > The vastly common case in this code is that this pointer will be no=
n-
> > > > NULL, because the server is running (i.e. not racing with shutdown)=
. I
> > > > don't see the need in making all of those accesses volatile.
> > >=20
> > > One of us is confused.  I hope it isn't me.
> > >=20
> >=20
> > It's probably me. I think you have a much better understanding of
> > compiler design than I do. Still...
> >=20
> > > The hypothetical problem I see is that the C compiler could generate
> > > code to load the value "nn->nfsd_serv" twice.  The first time it is n=
ot
> > > NULL, the second time it is NULL.
> > > The first is used for the test, the second is passed to svc_wake_up()=
.
> > >=20
> > > Unlikely though this is, it is possible and READ_ONCE() is designed
> > > precisely to prevent this.
> > > To quote from include/asm-generic/rwonce.h it will
> > >   "Prevent the compiler from merging or refetching reads"
> > >=20
> > > A "volatile" access does not add any cost (in this case).  What it do=
es
> > > is break any aliasing that the compile might have deduced.
> > > Even if the compiler thinks it has "nn->nfsd_serv" in a register, it
> > > won't think it has the result of READ_ONCE(nn->nfsd_serv) in that reg=
ister.
> > > And if it needs the result of a previous READ_ONCE(nn->nfsd_serv) it
> > > won't decide that it can just read nn->nfsd_serv again.  It MUST keep
> > > the result of READ_ONCE(nn->nfsd_serv) somewhere until it is not need=
ed
> > > any more.
> >=20
> > I'm mainly just considering the resulting pointer. There are two
> > possible outcomes to the fetch of nn->nfsd_serv. Either it's a valid
> > pointer that points to the svc_serv, or it's NULL. The resulting code
> > can handle either case, so it doesn't seem like adding READ_ONCE() will
> > create any material difference here.
> >=20
> > Maybe I should ask it this way: What bad outcome could result if we
> > don't add READ_ONCE() here?
>=20
> Neil just described it. The compiler would generate two load operations,
> one for the test and one for the function call argument. The first load
> can retrieve a non-NULL address, and the second a NULL address.
>=20
> I agree a READ_ONCE() is necessary.
>=20
>=20

Now I'm confused:

                struct svc_serv *serv;

		[...]

                /*
                 * The filecache laundrette is shut down after the
                 * nn->nfsd_serv pointer is cleared, but before the
                 * svc_serv is freed.
                 */
                serv =3D nn->nfsd_serv;
                if (serv)
                        svc_wake_up(serv);

This code is explicitly asking to fetch nn->nfsd_serv into the serv
variable, and then is testing that copy of the pointer and passing it
into svc_wake_up().

How is the compiler allowed to suddenly refetch a NULL pointer into
serv after testing that serv is non-NULL?
--=20
Jeff Layton <jlayton@kernel.org>

