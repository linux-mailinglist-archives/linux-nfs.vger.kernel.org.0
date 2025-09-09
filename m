Return-Path: <linux-nfs+bounces-14136-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4957B49EE6
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Sep 2025 03:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21E618976C4
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Sep 2025 01:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0677423BCE4;
	Tue,  9 Sep 2025 01:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="BvgSQkAd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q4ldjSH8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22C7101DE
	for <linux-nfs@vger.kernel.org>; Tue,  9 Sep 2025 01:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757383159; cv=none; b=HfU776NHNxa2ndAj+lsl5bx0LiJe9Enz1y71vgP1fzTWYTKP4KzFlpy7EsWJ9RpnP8BNCd2oojEG25vVUegjLM2uVxIgfRqSalQgS0DXkgpzJRf8HLyItWZP327BIfXRRU2y7bPUtKSjZoGBo4TmOGHNgzpoPjohM6Fhzg2oxdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757383159; c=relaxed/simple;
	bh=acppIWSucYIzYIrVcO6nK0Ww+u6feEBhatL4zjTGT30=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=T3CWQ3mkAA9GqHcF6HGF27MDzhnBCfW91u1UsAOJOupCOpkPmdd4ROJkrb1nqT56Lzj2GO/Ce7z89vXUDDsdl2QzqdBGnYtjQFa/pz0MryMz8bcaApnpfpIwmCRPvsjqXP98Y5JhIm3xLBGZSXir3tqakGAHoUgK17xj9jaFJNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=BvgSQkAd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q4ldjSH8; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 96FF77A01BE;
	Mon,  8 Sep 2025 21:59:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 08 Sep 2025 21:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757383154;
	 x=1757469554; bh=VGo/ahZmDnvtJLMKYQ4LgvVc6wVI52Il2R0rkVH03x4=; b=
	BvgSQkAd7aFeItTb3glUW4NuPORwoahO1S2UVNe9bl1r/iI0RQhcZ4s3tmsxCO53
	FdRm5KNlgFtg2JpQh39e3FHIeQGti2mR/LrreBSpBavBs90bzgm0Ez2uarPAvVIr
	prqDACnrBnJMjtGHZypsEOfqH5vjbDGz8eOG/Ce4U8abWOPTTjx5KnJYvqkP2736
	cBsmJ74NuoJxZA2pJBorEu9xvf0jAzs4n1ly/vhVqzutKpThQQfK4vfVAulNtvy7
	lhM7+Wio1xMUsNhrumz/m3h0F7+y7g0cJ0GBV9fc6aKptnQuQy2oRKPL9bvlDfoi
	CLBFh4uTZC5AJO18DX0BbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757383154; x=
	1757469554; bh=VGo/ahZmDnvtJLMKYQ4LgvVc6wVI52Il2R0rkVH03x4=; b=Q
	4ldjSH8+CSqNCxuVGJOqOvUOGQcZ+8aK1U9w1RC8MNCqkuxtZhq3NEkT+mvspjzE
	fyPhv1UQ6FpLdNNWCjIWjTqrYHcP+4RHCQA6hGRJig2rPkg7ZEkhhJ3KbAOFFkht
	7BlRxMR2fM4JpN2a0gwCv9B+zx9+f9QffAfSvOKtxEAr6qbyQGtakLbGeuYTGiyA
	jhg3fMj2+cIWp5TTeoPR3j7bsbOSJQc35BXNGR0cbx2qwgi2fqJR4xM7PSzno8jE
	Gv9fbUlHznpvyQ4B8P21o4nX7RNtSJ5d+/8QL4OySvMO5PtzrwMnoRATBwrzA5zQ
	BhC4faG7i7WXOmAlXFgfA==
X-ME-Sender: <xms:8om_aH3hx35yIFWRe1c9wbnP6k3c0gKccb40Dxltpwkj2prgQHozBg>
    <xme:8om_aBnj_3fz2ZVKmtPdjYtPsTU2-cj1VBUL0fnvyE_Fh1pXW_Uxrd1Quc0ESaKvT
    DSO_HLPnV4dDA>
X-ME-Received: <xmr:8om_aOVRqYzCNxwxmnwdCOdjmItvaHBlaMOafVG-2yXJ_wx5HS_67cLKCDqls7SMcOkOKgIsRkYhVs7YMEpZISOJ4KHx7T-mVpPT0KIP-RE1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffksehtqhertddttdejnecuhfhrohhmpedfpfgvihhluehr
    ohifnhdfuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epkeehgeejfeeftdevhfefuedvfeffheetieeuffdttdeujeevieetlefhtdeileevnecu
    ffhomhgrihhnpehrvgguhhgrthdrtghomhdpshihshhtvghmugdrmhgrnhdpshhotghkvg
    htrdgsrhdpshgvrhhvihgtvgdrrhgvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepnhgvihhlsgesohifnhhmrghilhdrnhgvthdpnhgspghrtg
    hpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqnhhf
    shesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeihohihrghnghesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtohepshhtvghvvggusehrvgguhhgrthdrtghomhdprhgt
    phhtthhopehsmhgrhihhvgifsehrvgguhhgrthdrtghomhdprhgtphhtthhopegstghoug
    guihhnghesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:8om_aHtZ3U2buIIBTl3jwFQDe_MrsYZTQ7rOq9JdfNvMhSPyT2nI3w>
    <xmx:8om_aBb1AzFPfAgy4iqKgAGZ4fT9hBE0iqr6mYGfFLa9LdTIv_yFmA>
    <xmx:8om_aGVmYseQfCrEEHBVQ5ZHEap2C5riR-QeawwL7ykK_K5XR4pBnw>
    <xmx:8om_aGSYcT_rZoWIY8ax_9wXb_EVgr_HxSDB93NBfYzaFkvfAhQPMw>
    <xmx:8om_aEFcDiLvoShqxBo-ffWmYtxU6kpBGpBX-bhr1r2OodWTVL9Fem1N>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 21:59:12 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@ownmail.net>
To: "Scott Mayhew" <smayhew@redhat.com>
Cc: steved@redhat.com, bcodding@redhat.com, yoyang@redhat.com,
 linux-nfs@vger.kernel.org
Subject: Re: [nfs-utils PATCH] rpc-statd.service: weaken the dependency on
 rpcbind.socket
In-reply-to: <aL8pZlSMHQBZdL3k@aion>
References: <>, <aL8pZlSMHQBZdL3k@aion>
Date: Tue, 09 Sep 2025 11:59:08 +1000
Message-id: <175738314848.2850467.15762759585599929390@noble.neil.brown.name>

On Tue, 09 Sep 2025, Scott Mayhew wrote:
> On Sat, 06 Sep 2025, NeilBrown wrote:
>=20
> > On Sat, 06 Sep 2025, Scott Mayhew wrote:
> > > In 91da135f ("systemd unit files: fix up dependencies on rpcbind"),
> > > Neil laid out the rationale for how the nfs services should define their
> > > dependencies on rpcbind.  In a nutshell:
> > >=20
> > > 1. Dependencies should only be defined using rpcbind.socket
> > > 2. Ordering for dependencies should only be defined usint "After=3D"
> > > 3. nfs-server.service should use "Wants=3Drpcbind.socket", to allow
> > >    rpcbind.socket to be masked in NFSv4-only setups.
> > > 4. rpc-statd.service should use "Requires=3Drpcbind.socket", as rpc.sta=
td
> > >    is useless if it can't register with rpcbind.
> > >=20
> > > Then in https://bugzilla.redhat.com/show_bug.cgi?id=3D2100395, Ben noted
> > > that due to the way the dependencies are ordered, when 'systemctl stop
> > > rpcbind.socket' is run, systemd first sends SIGTERM to rpcbind, then
> > > SIGTERM to rpc.statd.  On SIGTERM, rpcbind tears down /var/run/rpcbind.=
sock.
> > > However, rpc-statd on SIGTERM attempts to unregister from rpcbind.  This
> > > results in a long delay:
> > >=20
> > > [root@rawhide ~]# time systemctl restart rpcbind.socket
> > >=20
> > > real	1m0.147s
> > > user	0m0.004s
> > > sys	0m0.003s
> > >=20
> > > 8a835ceb ("rpc-statd.service: Stop rpcbind and rpc.stat in an exit race=
")
> > > fixed this by changing the dependency in rpc-statd.service to use
> > > "After=3Drpcbind.service", bending rule #1 from above.
> >=20
> > Thanks for the thorough and detailed explanation.
> >=20
> > I'd like to suggest a different fix.  Change rpc-statd.service to
> > declare:
> >=20
> > After=3Dnetwork-online.target nss-lookup.target rpcbind.socket rpcbind.se=
rvice
> >=20
> > i.e. it is declared to be After both the socket and the service.
> >=20
> > "After" declarations only have effect if the units are in the same
> > transaction.  If the Unit is not being started or stopped, the After
> > declaration has no effect.
> >=20
> > So on startup, this will ensure rpcbind.socket is started before
> > rpc-statd.service.
> > On shutdown in a transaction that stops both rpc-statd.service and
> > rpcbind.service, rpcbind.service won't be stopped until after
> > rpc-statd.service is stopped.
>=20
> That works too.
>=20
> >=20
> > I agree that it isn't necessary to restart rpc-statd when rpcbind is
> > restarted.
> > Maybe that is a justification to use Wants instead of Requires.
> > Or maybe Upholds would be even better.
>=20
> I think Upholds is confusing.... especially since there aren't any
> existing unit files using it, at least on a stock Fedora Rawhide
> system.  I don't see it being used on OpenSUSE Tumbleweed or Debian
> Trixie either.  I think it's going to confuse users if they try to stop
> rpcbind.socket and then find that it's still running.  Finally, when I test=
ed
> it, it prevented me from stopping rpc-statd.  Eventually the shutdown
> timer hit and systemd sent rpc-statd a SIGABRT, which in turned
> triggered the systemd-coredump handler.  That's a whole mess of syslog
> entries that's going to more bug reports.  I'd rather stick with Wants.

Thanks for testing.  I've never used Upholds myself but I was reading
the man page any wondered if it might be a good fit.  Apparently it
isn't.


> =20
> >=20
> > I wonder if putting
> >=20
> >  ConditionPathIsSymbolisLink !/etc/systemd/system/rpcbind.socket
>=20
> I'm lost.  What what cause the rpcbind.socket symlink to be created
> directly in /etc/systemd/system?  I've seen it get created in
> /etc/systemd/system/sockets.target.wants or
> /etc/systemd/system/multi-user.target.wants, but never directly in
> /etc/systemd/system.

$ sudo systemctl mask rpcbind.socket
Created symlink '/etc/systemd/system/rpcbind.socket' =E2=86=92 '/dev/null'.

I'm not sure it's a good idea.  I was mostly thinking aloud.

I think the After line should be changed to include both .service and
.socket and that cleanly fixed just the observed problem about shutdown.

And I don't think any other change should be made without a clear
demonstrated need.

Thanks,
NeilBrown


>=20
> -Scott
> >=20
> > in rpc-statd.service would be a suitable way to stop rpc-statd from
> > starting if rpcbind.socket is masked.
> >=20
> > In any case I think there are two separate issues here which deserve two
> > separate patch.
> > 1/ shutdown ordering isn't handled correctly.  Adding the extra After
> >    directive should fix that
> > 2/ rpc.statd is restarted unnecessarily.  Wants or Upholds might be part
> >    of the solution.
> >=20
> > Thanks,
> > NeilBrown
> >=20
> >   =20
> >=20
> > >=20
> > > Yongcheng recently noted that when runnnig the following test:
> > >=20
> > > [root@rawhide ~]# for i in `seq 10`; do systemctl reset-failed; \
> > > 	systemctl stop rpcbind rpcbind.socket ; systemctl restart nfs-server ;=
 \
> > > 	systemctl status rpc-statd; done
> > >=20
> > > rpc-statd.service would often fail to start:
> > >=20
> > > =C3=97 rpc-statd.service - NFS status monitor for NFSv2/3 locking.
> > >      Loaded: loaded (/usr/lib/systemd/system/rpc-statd.service; enabled=
-runtime; preset: disabled)
> > >     Drop-In: /usr/lib/systemd/system/service.d
> > >              =E2=94=94=E2=94=8010-timeout-abort.conf
> > >      Active: failed (Result: exit-code) since Fri 2025-09-05 18:01:15 E=
DT; 229ms ago
> > >    Duration: 228ms
> > >  Invocation: bafb2bb00761439ebc348000704e8fbb
> > >        Docs: man:rpc.statd(8)
> > >     Process: 29937 ExecStart=3D/usr/sbin/rpc.statd (code=3Dexited, stat=
us=3D1/FAILURE)
> > >    Mem peak: 1.5M
> > >         CPU: 7ms
> > >=20
> > > Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Version 2.8.2 st=
arting
> > > Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Flags: TI-RPC
> > > Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Failed to regist=
er (statd, 1, udp): svc_reg() err: RPC: Remote system error - Connection refu=
sed
> > > Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Failed to regist=
er (statd, 1, tcp): svc_reg() err: RPC: Success
> > > Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Failed to regist=
er (statd, 1, udp6): svc_reg() err: RPC: Success
> > > Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Failed to regist=
er (statd, 1, tcp6): svc_reg() err: RPC: Success
> > > Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: failed to create=
 RPC listeners, exiting
> > > Sep 05 18:01:15 rawhide.smayhew.test systemd[1]: rpc-statd.service: Con=
trol process exited, code=3Dexited, status=3D1/FAILURE
> > > Sep 05 18:01:15 rawhide.smayhew.test systemd[1]: rpc-statd.service: Fai=
led with result 'exit-code'.
> > > Sep 05 18:01:15 rawhide.smayhew.test systemd[1]: Failed to start rpc-st=
atd.service - NFS status monitor for NFSv2/3 locking..
> > >=20
> > > I propose we revert the change from 8a835ceb and instead turn the
> > > dependency into a weak dependency by using "Wants=3Drpcbind.socket"
> > > instead of "Requires=3Drpcbind.socket".  This bends rule #4 above and w=
ill
> > > make it so that systemd will try to start rpcbind.socket if it isn't
> > > already running when rpc-statd.service starts, but it won't restart
> > > rpc-statd.service whenever rpcbind is restarted.  Frankly, we shouldn't
> > > need to restart services whenever rpcbind is restarted (thats why
> > > rpcbind has the warmstart feature).  The only drawback is that now if an
> > > admin wants to set up an NFSv4-only server by masking rpcbind.socket,
> > > they'll need to mask rpc-statd.service as well.  I don't think that's
> > > too much to ask, so the nfs.systemd man page has been updated
> > > accordingly.
> > >=20
> > > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > > ---
> > >  systemd/nfs.systemd.man   | 10 +++++++---
> > >  systemd/rpc-statd.service |  5 +++--
> > >  2 files changed, 10 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/systemd/nfs.systemd.man b/systemd/nfs.systemd.man
> > > index a8476038..93fb87cd 100644
> > > --- a/systemd/nfs.systemd.man
> > > +++ b/systemd/nfs.systemd.man
> > > @@ -137,7 +137,9 @@ NFSv2) and does not want
> > >  .I rpcbind
> > >  to be running, the correct approach is to run
> > >  .RS
> > > -.B systemctl mask rpcbind
> > > +.B systemctl mask rpcbind.socket
> > > +.br
> > > +.B systemctl mask rpc-statd.service
> > >  .RE
> > >  This will disable
> > >  .IR rpcbind ,
> > > @@ -145,9 +147,11 @@ and the various NFS services which depend on it (a=
nd are only needed
> > >  for NFSv3) will refuse to start, without interfering with the
> > >  operation of NFSv4 services.  In particular,
> > >  .I rpc.statd
> > > -will not run when
> > > +will fail to start when
> > >  .I rpcbind
> > > -is masked.
> > > +is masked, so
> > > +.I rpc-statd.service
> > > +should be masked as well.
> > >  .PP
> > >  .I idmapd
> > >  is only needed for NFSv4, and even then is not needed when the client
> > > diff --git a/systemd/rpc-statd.service b/systemd/rpc-statd.service
> > > index 660ed861..4e138f69 100644
> > > --- a/systemd/rpc-statd.service
> > > +++ b/systemd/rpc-statd.service
> > > @@ -3,10 +3,11 @@ Description=3DNFS status monitor for NFSv2/3 locking.
> > >  Documentation=3Dman:rpc.statd(8)
> > >  DefaultDependencies=3Dno
> > >  Conflicts=3Dumount.target
> > > -Requires=3Dnss-lookup.target rpcbind.socket
> > > +Requires=3Dnss-lookup.target
> > > +Wants=3Drpcbind.socket
> > >  Wants=3Dnetwork-online.target
> > >  Wants=3Drpc-statd-notify.service
> > > -After=3Dnetwork-online.target nss-lookup.target rpcbind.service
> > > +After=3Dnetwork-online.target nss-lookup.target rpcbind.socket
> > > =20
> > >  PartOf=3Dnfs-utils.service
> > >  IgnoreOnIsolate=3Dyes
> > > --=20
> > > 2.50.1
> > >=20
> > >=20
> >=20
> >=20
>=20
>=20


