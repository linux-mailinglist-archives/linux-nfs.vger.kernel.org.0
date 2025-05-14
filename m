Return-Path: <linux-nfs+bounces-11729-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C80AB784D
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 23:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E84637B7D3A
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 21:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D2F215067;
	Wed, 14 May 2025 21:58:09 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA427223DE2
	for <linux-nfs@vger.kernel.org>; Wed, 14 May 2025 21:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747259889; cv=none; b=G8p2XgiAY1hqTLoUoX5mL21fWWDRNN1FzOoA8uYuLJZKpVll/fGln9m0BrWSGz3GH0Gi6xQuSzgHbeYNbp9WmxwtZ9beESzYLBifiziq6hpLSfxBl0/BmnRub1V46p+1SHq8mn472o2E0rd4B6RiauX/w3PVTJP36liRGnKJ7rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747259889; c=relaxed/simple;
	bh=xYrBokOX/43CZBvpoFxQgLsjTHYm2qm/keYEo3NG31c=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=OTbSzZlLhS4WEr+f+xmZ5jaIz+B8DQyZ2AFbjxtHT6G+UQiINdLFKNm1d6BbGHvwOwQmy6SqkJRnNXsJWzDi5+wmiE9niuIPvkANBNvfIbKIags1LYNZoEuSzlObEKDdc+bYI8rNErvFRagk3DNu/4+xrec409VlaxIsGDfcF/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uFK73-0049Vs-7d;
	Wed, 14 May 2025 21:58:05 +0000
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
In-reply-to: <f1afb60ecb3ac256807c12963ac87382ad45731b.camel@kernel.org>
References: <>, <f1afb60ecb3ac256807c12963ac87382ad45731b.camel@kernel.org>
Date: Thu, 15 May 2025 07:58:05 +1000
Message-id: <174725988501.62796.4552146319250587024@noble.neil.brown.name>

On Wed, 14 May 2025, Jeff Layton wrote:
> On Wed, 2025-05-14 at 21:43 +1000, NeilBrown wrote:
> > On Wed, 14 May 2025, Jeff Layton wrote:
> > > On Wed, 2025-05-14 at 12:28 +1000, NeilBrown wrote:
> > > > On Wed, 14 May 2025, NeilBrown wrote:
> > > > > On Tue, 13 May 2025, Jeff Layton wrote:
> > > > > > Back in the 80's someone thought it was a good idea to carve out =
a set
> > > > > > of ports that only privileged users could use. When NFS was origi=
nally
> > > > > > conceived, Sun made its server require that clients use low ports.
> > > > > > Since Linux was following suit with Sun in those days, exportfs h=
as
> > > > > > always defaulted to requiring connections from low ports.
> > > > > >=20
> > > > > > These days, anyone can be root on their laptop, so limiting conne=
ctions
> > > > > > to low source ports is of little value.
> > > > >=20
> > > > > But who is going to export any filesystem to their laptop?
> > > > >=20
> > > > > >=20
> > >=20
> > > The point is that most NFS servers are run on networks where the admin
> > > may not have 100% control over every host on the network. Once you're
> > > that situation, relying on low port values for security is basically
> > > worthless.
> >=20
> > "most" ??  Where did you get that statistic?
> >=20
>=20
> Anecdotal experience.
>=20
> > "Some" are run on in-machine-room networks which are completely
> > controlled, but which allow local users to log in to unprivileged
> > accounts.  In this case it makes perfect sense to rely on "privileged"
> > ports to control access.  If you silently change nfs-utils so that
> > unprivileged users can have root-level access over NFS, then you are
> > exposing the file server completely to anyone who can log in to an
> > server in that local network.  Are you sure you want to do that?
> >=20
>=20
> These types of environments are vanishingly small these days. If you
> have a network of any size, it is _really_ hard to prevent someone from
> plugging a laptop or something else into a random network drop.

In that case you should be disabling AUTH_UNIX, not disabling "secure".


>=20
> You can prevent that with 802.1x security, or something similar, but at
> that point what is checking the source port going to give you?
>=20
> > >=20
> > > > > > Make the default be "insecure" when creating exports.
> > > > >=20
> > > > > So you want to break lots of configurations that are working perfec=
tly
> > > > > well?
> > > >=20
> > > > Sorry - I was wrong.  You aren't breaking working configurations, but
> > > > you are removing a protection that people might be expecting.  It mig=
ht
> > > > not be much protection, but it is not zero.
> > > >=20
> > >=20
> > > True. Anyone relying on this "protection" is fooling themselves though.
> >=20
> > As above: in some circumstances with physically secure networks
> > (entirely in a locked room, or entire in a virtualisation host, or a
> > VPN) it makes perfect sense.
> >=20
>=20
> Not really. If any host is compromised on your network then this
> protection goes out the window.

If any host is compromised then all protections go out the window.  Let's
make "allsquash,anonuid=3D0" the default.

>=20
> The default should also always "just work". We have to balance that
> with being secure. There is a reason we don't default to krb5, for
> instance. In this case, the added security of checking low port values
> by default is pretty worthless. I think we ought to err on the side of
> usability.

No.  nonononono.  The default should always be secure.  Many things
should be installed inactive and require explicit admin action to
enable.  A tool should "just work".  A service should do nothing unless
explicitly asked.

>=20
> Also, to be clear, this currently not even enforced in all situations
> where TCP is used. iwarp travels over TCP, but using RDMA disables this
> check.

And presumably this has always been the case so there is no case of
changing a default that people might be depending on.  So they aren't
particularly relevant.

>=20
> > If we want to make this configuration problem more easy to detect, maybe
> > we should log unprivileged port access (beyond the few requests for
> > which it can make sense).
> >=20
>=20
> I don't see any benefit in that at all. If someone wants to do that,
> they can get that via tracepoints.

You reported that a configuration error was hard to debug.  I suggested
a way to make the configuration error more visible (and hence easier to
debug).  You cannot see the benefit.......  clearly I didn't explain
myself well - sorry.

> > Ignoring source ports makes no sense at all unless you enforce some other
> > authentication, like krb5 or TLS, or unless you *know* that there are no
> > unprivileged processes running on any client machines.
> >=20
>=20
> Paying attention to source ports makes no sense at all. In the modern
> age, all sorts of middleware boxes can change the source port on a
> connection. It is essentially meaningless outside of a few tightly
> controlled environments. Those environments can always enable "secure"
> if they require it.

But they are currently using the default in the knowledge that it is
"secure" and you want to change the default for *everyone*.

Sure - change the default for yourself if that is what you want.  Update
your script which generates /etc/exports or add some new option to
/etc/nfs.conf, but don't impose your choice on everyone without asking
them (and of course you cannot ask everyone).

NeilBrown

