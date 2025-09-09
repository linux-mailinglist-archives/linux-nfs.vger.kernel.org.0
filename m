Return-Path: <linux-nfs+bounces-14138-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A83B4FBC3
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Sep 2025 14:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9241C20897
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Sep 2025 12:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15A233EB0A;
	Tue,  9 Sep 2025 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGCqoT9L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B954338F2F
	for <linux-nfs@vger.kernel.org>; Tue,  9 Sep 2025 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757422190; cv=none; b=m9pdOMZRqDa2eIPS9OySDiL61adT+raknU0rTFZoDe360SbDbEUELfmJaYMRUQGzKqp/aVf3huVh4YMnQ6uwos0qAliWmUm4ohxZJIs/2iiBzBXF5o/v/1DzUgDhDa8VylxCgsKT3fsZ9mO18wNVCJOV5M+Nvgg4Do8sAQD3RkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757422190; c=relaxed/simple;
	bh=XUIBdOowTAK//doe3VyuMWfRfAQO88Y0pVVNvVCQNdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dtr9JRoYqlhriZ5Ufm9P7m0q/Jn9W8XUxcz3fQP9NJbA/FAedoupNCHS8Mrw3cknxrvE0Q0NGJX7B8D9Xb3tjSFMlBFWGubRvoK8+tFmDXb52kUwXtAVbssp24yiqNdlkqO77NSSyUwPDPg/MmDdCq02AMIGAs8qur5OrXQoHOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGCqoT9L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757422187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nM/hochG2Itq5oFsuSbh46HE6b9RFtq6tZKECQZYW6U=;
	b=YGCqoT9LjdQehB15XbVSHhGTXwFVZ5sxap7xFK1wB2Kssh1CDOQ0P9YcgGO0Yk/Y8s++I7
	X/ktOJ3d3VS7a41Nh9A3hr5LNg7OZIAJTexv6l9YPO1Fzc0dGb+VpLVKKv17uhlkRUEaaA
	LvdJ8E7UBFDeRFebUq6OJH5T/rVKGYs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-03Q8r8cNNYeHAldSab7_eg-1; Tue,
 09 Sep 2025 08:49:43 -0400
X-MC-Unique: 03Q8r8cNNYeHAldSab7_eg-1
X-Mimecast-MFC-AGG-ID: 03Q8r8cNNYeHAldSab7_eg_1757422181
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A9A441800451;
	Tue,  9 Sep 2025 12:49:41 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.97])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 587E81800452;
	Tue,  9 Sep 2025 12:49:41 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 7878142FADD; Tue, 09 Sep 2025 08:49:39 -0400 (EDT)
Date: Tue, 9 Sep 2025 08:49:39 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: NeilBrown <neilb@ownmail.net>
Cc: steved@redhat.com, bcodding@redhat.com, yoyang@redhat.com,
	linux-nfs@vger.kernel.org
Subject: Re: [nfs-utils PATCH] rpc-statd.service: weaken the dependency on
 rpcbind.socket
Message-ID: <aMAiY8n7KtMnoKAz@aion>
References: <>
 <aL8pZlSMHQBZdL3k@aion>
 <175738314848.2850467.15762759585599929390@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <175738314848.2850467.15762759585599929390@noble.neil.brown.name>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, 09 Sep 2025, NeilBrown wrote:

> On Tue, 09 Sep 2025, Scott Mayhew wrote:
> > On Sat, 06 Sep 2025, NeilBrown wrote:
> >=20
> > > On Sat, 06 Sep 2025, Scott Mayhew wrote:
> > > > In 91da135f ("systemd unit files: fix up dependencies on rpcbind"),
> > > > Neil laid out the rationale for how the nfs services should define =
their
> > > > dependencies on rpcbind.  In a nutshell:
> > > >=20
> > > > 1. Dependencies should only be defined using rpcbind.socket
> > > > 2. Ordering for dependencies should only be defined usint "After=3D"
> > > > 3. nfs-server.service should use "Wants=3Drpcbind.socket", to allow
> > > >    rpcbind.socket to be masked in NFSv4-only setups.
> > > > 4. rpc-statd.service should use "Requires=3Drpcbind.socket", as rpc=
=2Estatd
> > > >    is useless if it can't register with rpcbind.
> > > >=20
> > > > Then in https://bugzilla.redhat.com/show_bug.cgi?id=3D2100395, Ben =
noted
> > > > that due to the way the dependencies are ordered, when 'systemctl s=
top
> > > > rpcbind.socket' is run, systemd first sends SIGTERM to rpcbind, then
> > > > SIGTERM to rpc.statd.  On SIGTERM, rpcbind tears down /var/run/rpcb=
ind.sock.
> > > > However, rpc-statd on SIGTERM attempts to unregister from rpcbind. =
 This
> > > > results in a long delay:
> > > >=20
> > > > [root@rawhide ~]# time systemctl restart rpcbind.socket
> > > >=20
> > > > real	1m0.147s
> > > > user	0m0.004s
> > > > sys	0m0.003s
> > > >=20
> > > > 8a835ceb ("rpc-statd.service: Stop rpcbind and rpc.stat in an exit =
race")
> > > > fixed this by changing the dependency in rpc-statd.service to use
> > > > "After=3Drpcbind.service", bending rule #1 from above.
> > >=20
> > > Thanks for the thorough and detailed explanation.
> > >=20
> > > I'd like to suggest a different fix.  Change rpc-statd.service to
> > > declare:
> > >=20
> > > After=3Dnetwork-online.target nss-lookup.target rpcbind.socket rpcbin=
d.service
> > >=20
> > > i.e. it is declared to be After both the socket and the service.
> > >=20
> > > "After" declarations only have effect if the units are in the same
> > > transaction.  If the Unit is not being started or stopped, the After
> > > declaration has no effect.
> > >=20
> > > So on startup, this will ensure rpcbind.socket is started before
> > > rpc-statd.service.
> > > On shutdown in a transaction that stops both rpc-statd.service and
> > > rpcbind.service, rpcbind.service won't be stopped until after
> > > rpc-statd.service is stopped.
> >=20
> > That works too.
> >=20
> > >=20
> > > I agree that it isn't necessary to restart rpc-statd when rpcbind is
> > > restarted.
> > > Maybe that is a justification to use Wants instead of Requires.
> > > Or maybe Upholds would be even better.
> >=20
> > I think Upholds is confusing.... especially since there aren't any
> > existing unit files using it, at least on a stock Fedora Rawhide
> > system.  I don't see it being used on OpenSUSE Tumbleweed or Debian
> > Trixie either.  I think it's going to confuse users if they try to stop
> > rpcbind.socket and then find that it's still running.  Finally, when I =
tested
> > it, it prevented me from stopping rpc-statd.  Eventually the shutdown
> > timer hit and systemd sent rpc-statd a SIGABRT, which in turned
> > triggered the systemd-coredump handler.  That's a whole mess of syslog
> > entries that's going to more bug reports.  I'd rather stick with Wants.
>=20
> Thanks for testing.  I've never used Upholds myself but I was reading
> the man page any wondered if it might be a good fit.  Apparently it
> isn't.
>=20
>=20
> > =20
> > >=20
> > > I wonder if putting
> > >=20
> > >  ConditionPathIsSymbolisLink !/etc/systemd/system/rpcbind.socket
> >=20
> > I'm lost.  What what cause the rpcbind.socket symlink to be created
> > directly in /etc/systemd/system?  I've seen it get created in
> > /etc/systemd/system/sockets.target.wants or
> > /etc/systemd/system/multi-user.target.wants, but never directly in
> > /etc/systemd/system.
>=20
> $ sudo systemctl mask rpcbind.socket
> Created symlink '/etc/systemd/system/rpcbind.socket' =E2=86=92 '/dev/null=
'.
>=20
> I'm not sure it's a good idea.  I was mostly thinking aloud.

Doh!  Apparently I wasn't thinking at all.

>=20
> I think the After line should be changed to include both .service and
> .socket and that cleanly fixed just the observed problem about shutdown.
>=20
> And I don't think any other change should be made without a clear
> demonstrated need.

Sounds good.  Thanks for the feedback.

-Scott
>=20
> Thanks,
> NeilBrown
>=20
>=20
> >=20
> > -Scott
> > >=20
> > > in rpc-statd.service would be a suitable way to stop rpc-statd from
> > > starting if rpcbind.socket is masked.
> > >=20
> > > In any case I think there are two separate issues here which deserve =
two
> > > separate patch.
> > > 1/ shutdown ordering isn't handled correctly.  Adding the extra After
> > >    directive should fix that
> > > 2/ rpc.statd is restarted unnecessarily.  Wants or Upholds might be p=
art
> > >    of the solution.
> > >=20
> > > Thanks,
> > > NeilBrown
> > >=20
> > >   =20
> > >=20
> > > >=20
> > > > Yongcheng recently noted that when runnnig the following test:
> > > >=20
> > > > [root@rawhide ~]# for i in `seq 10`; do systemctl reset-failed; \
> > > > 	systemctl stop rpcbind rpcbind.socket ; systemctl restart nfs-serv=
er ; \
> > > > 	systemctl status rpc-statd; done
> > > >=20
> > > > rpc-statd.service would often fail to start:
> > > >=20
> > > > =C3=97 rpc-statd.service - NFS status monitor for NFSv2/3 locking.
> > > >      Loaded: loaded (/usr/lib/systemd/system/rpc-statd.service; ena=
bled-runtime; preset: disabled)
> > > >     Drop-In: /usr/lib/systemd/system/service.d
> > > >              =E2=94=94=E2=94=8010-timeout-abort.conf
> > > >      Active: failed (Result: exit-code) since Fri 2025-09-05 18:01:=
15 EDT; 229ms ago
> > > >    Duration: 228ms
> > > >  Invocation: bafb2bb00761439ebc348000704e8fbb
> > > >        Docs: man:rpc.statd(8)
> > > >     Process: 29937 ExecStart=3D/usr/sbin/rpc.statd (code=3Dexited, =
status=3D1/FAILURE)
> > > >    Mem peak: 1.5M
> > > >         CPU: 7ms
> > > >=20
> > > > Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Version 2.8.=
2 starting
> > > > Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Flags: TI-RPC
> > > > Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Failed to re=
gister (statd, 1, udp): svc_reg() err: RPC: Remote system error - Connectio=
n refused
> > > > Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Failed to re=
gister (statd, 1, tcp): svc_reg() err: RPC: Success
> > > > Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Failed to re=
gister (statd, 1, udp6): svc_reg() err: RPC: Success
> > > > Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Failed to re=
gister (statd, 1, tcp6): svc_reg() err: RPC: Success
> > > > Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: failed to cr=
eate RPC listeners, exiting
> > > > Sep 05 18:01:15 rawhide.smayhew.test systemd[1]: rpc-statd.service:=
 Control process exited, code=3Dexited, status=3D1/FAILURE
> > > > Sep 05 18:01:15 rawhide.smayhew.test systemd[1]: rpc-statd.service:=
 Failed with result 'exit-code'.
> > > > Sep 05 18:01:15 rawhide.smayhew.test systemd[1]: Failed to start rp=
c-statd.service - NFS status monitor for NFSv2/3 locking..
> > > >=20
> > > > I propose we revert the change from 8a835ceb and instead turn the
> > > > dependency into a weak dependency by using "Wants=3Drpcbind.socket"
> > > > instead of "Requires=3Drpcbind.socket".  This bends rule #4 above a=
nd will
> > > > make it so that systemd will try to start rpcbind.socket if it isn't
> > > > already running when rpc-statd.service starts, but it won't restart
> > > > rpc-statd.service whenever rpcbind is restarted.  Frankly, we shoul=
dn't
> > > > need to restart services whenever rpcbind is restarted (thats why
> > > > rpcbind has the warmstart feature).  The only drawback is that now =
if an
> > > > admin wants to set up an NFSv4-only server by masking rpcbind.socke=
t,
> > > > they'll need to mask rpc-statd.service as well.  I don't think that=
's
> > > > too much to ask, so the nfs.systemd man page has been updated
> > > > accordingly.
> > > >=20
> > > > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > > > ---
> > > >  systemd/nfs.systemd.man   | 10 +++++++---
> > > >  systemd/rpc-statd.service |  5 +++--
> > > >  2 files changed, 10 insertions(+), 5 deletions(-)
> > > >=20
> > > > diff --git a/systemd/nfs.systemd.man b/systemd/nfs.systemd.man
> > > > index a8476038..93fb87cd 100644
> > > > --- a/systemd/nfs.systemd.man
> > > > +++ b/systemd/nfs.systemd.man
> > > > @@ -137,7 +137,9 @@ NFSv2) and does not want
> > > >  .I rpcbind
> > > >  to be running, the correct approach is to run
> > > >  .RS
> > > > -.B systemctl mask rpcbind
> > > > +.B systemctl mask rpcbind.socket
> > > > +.br
> > > > +.B systemctl mask rpc-statd.service
> > > >  .RE
> > > >  This will disable
> > > >  .IR rpcbind ,
> > > > @@ -145,9 +147,11 @@ and the various NFS services which depend on i=
t (and are only needed
> > > >  for NFSv3) will refuse to start, without interfering with the
> > > >  operation of NFSv4 services.  In particular,
> > > >  .I rpc.statd
> > > > -will not run when
> > > > +will fail to start when
> > > >  .I rpcbind
> > > > -is masked.
> > > > +is masked, so
> > > > +.I rpc-statd.service
> > > > +should be masked as well.
> > > >  .PP
> > > >  .I idmapd
> > > >  is only needed for NFSv4, and even then is not needed when the cli=
ent
> > > > diff --git a/systemd/rpc-statd.service b/systemd/rpc-statd.service
> > > > index 660ed861..4e138f69 100644
> > > > --- a/systemd/rpc-statd.service
> > > > +++ b/systemd/rpc-statd.service
> > > > @@ -3,10 +3,11 @@ Description=3DNFS status monitor for NFSv2/3 lock=
ing.
> > > >  Documentation=3Dman:rpc.statd(8)
> > > >  DefaultDependencies=3Dno
> > > >  Conflicts=3Dumount.target
> > > > -Requires=3Dnss-lookup.target rpcbind.socket
> > > > +Requires=3Dnss-lookup.target
> > > > +Wants=3Drpcbind.socket
> > > >  Wants=3Dnetwork-online.target
> > > >  Wants=3Drpc-statd-notify.service
> > > > -After=3Dnetwork-online.target nss-lookup.target rpcbind.service
> > > > +After=3Dnetwork-online.target nss-lookup.target rpcbind.socket
> > > > =20
> > > >  PartOf=3Dnfs-utils.service
> > > >  IgnoreOnIsolate=3Dyes
> > > > --=20
> > > > 2.50.1
> > > >=20
> > > >=20
> > >=20
> > >=20
> >=20
> >=20
>=20


