Return-Path: <linux-nfs+bounces-4868-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8690C92FC31
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 16:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4189028163B
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 14:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8735C16F85A;
	Fri, 12 Jul 2024 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9SOxg29"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57862125D6;
	Fri, 12 Jul 2024 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793258; cv=none; b=LMeuxfxIUtLb3OHrHhcXp87NL9W2VRMIB6dP0Coav9ZfxrlwOTkmO7jwpiLyY85yTeHfuLckTVjLUlLh60kyuTukAgw6AqZKz1w5rjwXz8UIGO8vEUPJ2wB6Tq4tbqTLVDD2hSW5PLsiNh2FNA6/dpW0liElikho0PdZdOpIKAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793258; c=relaxed/simple;
	bh=52OOix36CKxLvM3noUFlVEYxDPlAQZwjpzV0oauAbFw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I4rtJZzG0R+Zogq4bT8eW1Ke+szLEbao5RzNW2h0VN9T20cAERypmdFpH/A+3OK7JVUHhCwWZVbz51fCxW3NWxKt85DN9JKFoGZgJ6mKiEkm5ajYAMYfC/uIkbsZ6Y19xAAkh22OzyN5eO5WLng9N4VPBt4TG9QxlSvtLPaG050=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9SOxg29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45A4C32782;
	Fri, 12 Jul 2024 14:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720793258;
	bh=52OOix36CKxLvM3noUFlVEYxDPlAQZwjpzV0oauAbFw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=W9SOxg29nWaoQDDEENiM1dWok4fxDlyZHS31cRoXyYrCBlV0XILDFUkw7MIvypmZ6
	 RbOw/Xuc45wb9+uVTmIQE24FoomjDWKcH8FEK2iWmjzY7eIAMx/7S5Cqn87ccOGhIZ
	 3Afw0ok6FTLgKcKwhlhScfCH3A/FCEPHGb9LdZkU6KkLgK1JS7G8Jqxt5L4F6QCq97
	 Jmt1mxG7maIFGTzbpq8zpC/j5Vt0RGngXh2NWzeSdPvg/lj6isQ2OJO6WE7s+5V9h/
	 NYRVkQf6tRG2gsuRVgjLowVbmha/+W3QkFZXH4iqKFouPglKNgNWc8GmyaO4gYVah0
	 0g+v/CJgcALKA==
Message-ID: <090f5c1d38b249757cd459398506e10e4809dd4a.camel@kernel.org>
Subject: Re: [LTP] [PATCH 1/1] nfsstat01: Update client RPC calls for kernel
 6.9
From: Jeff Layton <jlayton@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>, Chuck Lever III
	 <chuck.lever@oracle.com>, Greg KH <greg@kroah.com>
Cc: Sherry Yang <sherry.yang@oracle.com>, Calum Mackay
 <calum.mackay@oracle.com>,  linux-stable <stable@vger.kernel.org>, Petr
 Vorel <pvorel@suse.cz>, Trond Myklebust <trondmy@hammerspace.com>,  Anna
 Schumaker <anna@kernel.org>, Linux NFS Mailing List
 <linux-nfs@vger.kernel.org>,  "kernel-team@fb.com" <kernel-team@fb.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>, Avinesh Kumar <akumar@suse.de>,
 Neil Brown <neilb@suse.de>, Josef Bacik <josef@toxicpanda.com>,  Linux
 kernel regressions list <regressions@lists.linux.dev>
Date: Fri, 12 Jul 2024 10:07:35 -0400
In-Reply-To: <868ccc20-00b3-4472-b081-0d26254a0f66@leemhuis.info>
References: <d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com>
	 <2fc3a3fd-7433-45ba-b281-578355dca64c@oracle.com>
	 <296EA0E6-0E72-4EA1-8B31-B025EB531F9B@oracle.com>
	 <2024070638-shale-avalanche-1b51@gregkh>
	 <E1A8C506-12CF-474B-9C1C-25EC93FCC206@oracle.com>
	 <2024070814-very-vitamins-7021@gregkh>
	 <64D2D29F-BCC0-4A44-BB75-D85B80B75959@oracle.com>
	 <868ccc20-00b3-4472-b081-0d26254a0f66@leemhuis.info>
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

On Fri, 2024-07-12 at 15:45 +0200, Thorsten Leemhuis wrote:
> On 08.07.24 19:49, Chuck Lever III wrote:
> > > On Jul 8, 2024, at 6:36=E2=80=AFAM, Greg KH <greg@kroah.com> wrote:
> > > On Sat, Jul 06, 2024 at 07:46:19AM +0000, Sherry Yang wrote:
> > > > > On Jul 6, 2024, at 12:11=E2=80=AFAM, Greg KH <greg@kroah.com> wro=
te:
> > > > > On Fri, Jul 05, 2024 at 02:19:18PM +0000, Chuck Lever III
> > > > > wrote:
> > > > > > > On Jul 2, 2024, at 6:55=E2=80=AFPM, Calum Mackay
> > > > > > > <calum.mackay@oracle.com> wrote:
> > > > > > > On 02/07/2024 5:54 pm, Calum Mackay wrote:
> > > > > > > > I noticed your LTP patch [1][2] which adjusts the
> > > > > > > > nfsstat01 test on v6.9 kernels, to account for Josef's
> > > > > > > > changes [3], which restrict the NFS/RPC stats per-
> > > > > > > > namespace.
> > > > > > > > I see that Josef's changes were backported, as far back
> > > > > > > > as longterm v5.4,
> > [...]
> > > > > > > I'm wondering if this difference between NFS client, and
> > > > > > > NFS server, stat behaviour, across kernel versions, may
> > > > > > > perhaps cause some user confusion?
> > > > > >=20
> > > > > > As a refresher for the stable folken, Josef's changes make
> > > > > > nfsstats silo'd, so they no longer show counts from the
> > > > > > whole
> > > > > > system, but only for NFS operations relating to the local
> > > > > > net
> > > > > > namespace. That is a surprising change for some users,
> > > > > > tools,
> > > > > > and testing.
> > > > > >=20
> > > > > > I'm not clear on whether there are any rules/guidelines
> > > > > > around
> > > > > > LTS backports causing behavior changes that user tools,
> > > > > > like
> > > > > > nfsstat, might be impacted by.
> > > > >=20
> > > > > The same rules that apply for Linus's tree (i.e. no userspace
> > > > > regressions.)
> > > > [...]
> > > > If no userspace regression, should we revert the Josef=E2=80=99s NF=
S
> > > > client-side changes on LTS?
> > >=20
> > > This sounds like a regression in Linus's tree too, so why isn't
> > > it
> > > reverted there first?
> >=20
> > There is a change in behavior in the upstream code, but Josef's
> > patches fix an information leak and make the statistics more
> > sensible in container environments. I'm not certain that
> > should be considered a regression, but confess I don't know
> > the regression rules to this fine a degree of detail.
>=20
> Chuck pointed me to this thread (I had an eye on it already anyway)
> and
> asked for advice. Take everything I write here with a grain of salt,
> as
> this is somewhat tricky situation which makes it hard to predict how
> Linus would actually want to see this handled. Maybe I should have
> CCed
> him, but I doubt he cares right now; but we maybe should bring him
> in,
> if an actual user complains.
>=20
> With that out of the way, let me write a few thoughts:
>=20
> * That some test breaks is not a regression, as regressions are about
> "practical issues", not some ABI/API changes that only some tests
> care
> about. So if it's just a test that broke update it.
>=20
> * If a user would reported something like "this change broke my app"
> it
> obviously would be something totally different. But that did not
> happen
> yet afaics -- or did it? But from the discussion it sounds like that
> is
> something that will likely happen down the road. If that's the case
> I'd
> say it's best to prevent that from happening.
>=20

I doubt anyone outside of automated testcases will ever notice this,
and if they do, then they probably want the new behavior. This was an
oversight when the nfs client and server were first containerized.
These stats should have been made per-net then, but never were.

Basically, the old "/proc/net/rpc/nfs{d}" files presented aggregate
stats for all of the nfsd's on the machine _and_ they presented the
same information no matter the net namespace you're in when reading
them.

Josef's patches changed it so that we collect this information on a
per-net namespace basis, and we only present the totals of the net
namespace reading the procfile.

There are 2 possibilities of breakage:

1) someone in a container expects to see stats for the entire host in
/proc/net/rpc/nfsd. This is a bug -- users in the container should
never have seen this in the first place. In practice, it's probably
pretty benign, but fixing it is the right thing to do.

2) someone in the init_net_ns reads the procfile and expects to see
global totals. Ok, this is a change, but I argue that it's a good one,
since it gives more immediate info about the server running in the
init_net_ns.

In practice most usage of these procfiles is pretty informal (mostly
acting as the source for nfsstat). Segregating this info by container
is the right outcome. It should have been done that way from the get-
go.

> * Not sure how Linus would react if a user would complain that some
> workflow broke because rpc_stat are now per net namespace and shows
> different numbers (e.g. using a format that does not break any apps).
> It
> would likely depend on the actual case and how bad he would consider
> the
> information leak.
>=20
> > If it is indeed a regression, how can we go about retaining
> > both behaviors (selectable by Kconfig or perhaps administrative
> > UI)?
>=20
> That likely might be the best idea if user report an actual
> regression
> due to this. But switching the format of any existing file creates
> quite
> some trouble, as others already mentioned in this thread. So maybe
> providing the newer format in a different file and allowing to
> disable
> the older one though a Kconfig setting might be the best way forward.
> Sure, it would take years until people would have switched over, but
> that's how it is with our "no regressions" rule.
>=20
> Does that help?
>=20
> Ciao, Thorsten

--=20
Jeff Layton <jlayton@kernel.org>

