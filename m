Return-Path: <linux-nfs+bounces-14095-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB0AB46742
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 01:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB371C8769B
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 23:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDDD267AF2;
	Fri,  5 Sep 2025 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="EQVr/ttJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UM1DeKk2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21C825A2A1
	for <linux-nfs@vger.kernel.org>; Fri,  5 Sep 2025 23:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757115632; cv=none; b=QR/vhh+HtMvbOJ/kql8vw/k9MS9I++J+QFzZ0SdJiOFLQYf0nIU0Bu/xnYm5g7GN5cYmkgRKFqPPBM9rVwhjfRhtHKU6jSe0ueX7SufUwcsZg2Oc6CSc+YNdjz3JqlRDnYn0cPivVCeqrgVn1T+FjEV+8xplc1tFsnRYEAy7AA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757115632; c=relaxed/simple;
	bh=r7yxHdI0UrD87O1qmATb2m8tVq0sNxbP2T62dzwbjc0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=q0gVNDlx6K3Ovc33L0Quq8d6XoKZO1zzQno3bymOnKUTGU8sU2K9c91+BMNwXONCO2afkQJ/G3e9DkOB7ucT/2bo9N1KE4VFn0hzq64tzhaB0cCmoAZxRAtHAmp9b7hVCaZdoRFns9oq1pUzpZJRt75qh8ceZCjqqdIpo8fpaQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=EQVr/ttJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UM1DeKk2; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BEDE67A03A5;
	Fri,  5 Sep 2025 19:40:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 05 Sep 2025 19:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757115627;
	 x=1757202027; bh=J6ORJGUa248ekMvmqs6jP2SeBUea34k06JwKqNgyQgs=; b=
	EQVr/ttJRVLh1aFwk8lGr/iEVac1PJy+r5hfdOSYGnCzHCX/acIl/g5n6GyqLzsP
	fjepFvRAmngDiA/6TCECypDGImsGKVoayPBi/pMv/yeEu7n1sbrLGHAHPwNw2AyZ
	qw7E/3Eeqgf3u2zpd9u+mIwNQG6owAhDwfwrSqeulcxMZDC8EeAm9mnxJTzR10L9
	0MfSiLvoktbXi0qLkfUJPU7pBMYXEw7YGWAEBBsKKdEErAEiq72Rt95YGU54u1ZV
	+EMQ2pJvL+ujLQCmdggTX5nYGAcRIMbdcnm18WiBcJoZ+xonf0ZUuWg7BqF1Lom/
	kK0jOmFHOf3KnrVnUr6w/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757115627; x=
	1757202027; bh=J6ORJGUa248ekMvmqs6jP2SeBUea34k06JwKqNgyQgs=; b=U
	M1DeKk2R4oRd3J8X/CzquQ4pg0Qv7lImUxiyEep4rEwoQeHW/vu1h171iuqTzmBu
	d0XhDKtH6nwO8/VfQccfKmsj+CZNTiRloIIljxM8vPUx3BkUL8mla9fbUb9pfpB3
	wjPgt82ohUy60hvgrfIFailid4SNFE5O+ECSPPE9rWxiLw0jQO9oheBgUowsObrb
	jgCDTVc8UBmrjgU+cKQKmZG4LvOJgwC2NrfCnmVyKhsg9P8O6tWlemTDFN2g2KDH
	UnBFAlqOX/Wm3NM5JO8XpSPlEQS7MzDxDTJ3okdovG1wr6g4DjyTmt5SmCPl/SLn
	ZfvCwiBK1eMQK5/ye9MRw==
X-ME-Sender: <xms:63S7aG6A7GJ348gGvNX2-Xee28MVDwrnxSQSGe5htVL9p3OhNj-zVA>
    <xme:63S7aLYVkAZzEiT1IZd3IeQjdccrgeQlMFXRzbuX4TJ3ldiOkVSYtKppNUph-r9dB
    SQdLF4thjT0Sw>
X-ME-Received: <xmr:63S7aL7sQ5xFl7tNysaIdCQeznV-ILrlIHRQWIljGHVJqWkMV7E74VrqYthYkh9AbTmOe5zwJoLbhAh8dmid8H02KdfnjnWabnWmKDxmOoYk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffksehtqhertddttdejnecuhfhrohhmpefpvghilheurhho
    fihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepve
    euteelgfevieeihfeihfdvfedtleehhfeghfekjefhtdeggfekheegvdeifeeunecuffho
    mhgrihhnpehrvgguhhgrthdrtghomhdpshihshhtvghmugdrmhgrnhdpshhotghkvghtrd
    gsrhdpshgvrhhvihgtvgdrrhgvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepnhgvihhlsgesohifnhhmrghilhdrnhgvthdpnhgspghrtghpth
    htohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqnhhfshes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeihohihrghnghesrhgvughhrg
    htrdgtohhmpdhrtghpthhtohepshhtvghvvggusehrvgguhhgrthdrtghomhdprhgtphht
    thhopehsmhgrhihhvgifsehrvgguhhgrthdrtghomhdprhgtphhtthhopegstghougguih
    hnghesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:63S7aOA93MeZt2cn8PMUJbAFy5glXv4hyzhoLeU3D2ROdHZDLUS4tQ>
    <xmx:63S7aBfy2UaoDvSeah4P1ZNOf4UnNpKiBqQzm_CmdeAT9QjLkCUrew>
    <xmx:63S7aNIFum_3MonUMfkWVwz3bB3yriQSTa9MoP5ZJNlGmI5sr0e0RA>
    <xmx:63S7aM1neCRbKFBNYZvR4-Tu7SNZHK_I7dR2ll1msi2zPGdYGQLLqQ>
    <xmx:63S7aCZX2KgD8SkZ8CcAvzKzqsD5qg-Q4KBDUgXXDsKTuOM0si7uxndf>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 19:40:25 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Scott Mayhew" <smayhew@redhat.com>
Cc: steved@redhat.com, bcodding@redhat.com, yoyang@redhat.com,
 linux-nfs@vger.kernel.org
Subject: Re: [nfs-utils PATCH] rpc-statd.service: weaken the dependency on
 rpcbind.socket
In-reply-to: <20250905223544.1229104-1-smayhew@redhat.com>
References: <20250905223544.1229104-1-smayhew@redhat.com>
Date: Sat, 06 Sep 2025 09:40:22 +1000
Message-id: <175711562246.2850467.6098728603666668070@noble.neil.brown.name>

On Sat, 06 Sep 2025, Scott Mayhew wrote:
> In 91da135f ("systemd unit files: fix up dependencies on rpcbind"),
> Neil laid out the rationale for how the nfs services should define their
> dependencies on rpcbind.  In a nutshell:
>=20
> 1. Dependencies should only be defined using rpcbind.socket
> 2. Ordering for dependencies should only be defined usint "After=3D"
> 3. nfs-server.service should use "Wants=3Drpcbind.socket", to allow
>    rpcbind.socket to be masked in NFSv4-only setups.
> 4. rpc-statd.service should use "Requires=3Drpcbind.socket", as rpc.statd
>    is useless if it can't register with rpcbind.
>=20
> Then in https://bugzilla.redhat.com/show_bug.cgi?id=3D2100395, Ben noted
> that due to the way the dependencies are ordered, when 'systemctl stop
> rpcbind.socket' is run, systemd first sends SIGTERM to rpcbind, then
> SIGTERM to rpc.statd.  On SIGTERM, rpcbind tears down /var/run/rpcbind.sock.
> However, rpc-statd on SIGTERM attempts to unregister from rpcbind.  This
> results in a long delay:
>=20
> [root@rawhide ~]# time systemctl restart rpcbind.socket
>=20
> real	1m0.147s
> user	0m0.004s
> sys	0m0.003s
>=20
> 8a835ceb ("rpc-statd.service: Stop rpcbind and rpc.stat in an exit race")
> fixed this by changing the dependency in rpc-statd.service to use
> "After=3Drpcbind.service", bending rule #1 from above.

Thanks for the thorough and detailed explanation.

I'd like to suggest a different fix.  Change rpc-statd.service to
declare:

After=3Dnetwork-online.target nss-lookup.target rpcbind.socket rpcbind.service

i.e. it is declared to be After both the socket and the service.

"After" declarations only have effect if the units are in the same
transaction.  If the Unit is not being started or stopped, the After
declaration has no effect.

So on startup, this will ensure rpcbind.socket is started before
rpc-statd.service.
On shutdown in a transaction that stops both rpc-statd.service and
rpcbind.service, rpcbind.service won't be stopped until after
rpc-statd.service is stopped.

I agree that it isn't necessary to restart rpc-statd when rpcbind is
restarted.
Maybe that is a justification to use Wants instead of Requires.
Or maybe Upholds would be even better.

I wonder if putting

 ConditionPathIsSymbolisLink !/etc/systemd/system/rpcbind.socket

in rpc-statd.service would be a suitable way to stop rpc-statd from
starting if rpcbind.socket is masked.

In any case I think there are two separate issues here which deserve two
separate patch.
1/ shutdown ordering isn't handled correctly.  Adding the extra After
   directive should fix that
2/ rpc.statd is restarted unnecessarily.  Wants or Upholds might be part
   of the solution.

Thanks,
NeilBrown

  =20

>=20
> Yongcheng recently noted that when runnnig the following test:
>=20
> [root@rawhide ~]# for i in `seq 10`; do systemctl reset-failed; \
> 	systemctl stop rpcbind rpcbind.socket ; systemctl restart nfs-server ; \
> 	systemctl status rpc-statd; done
>=20
> rpc-statd.service would often fail to start:
>=20
> =C3=97 rpc-statd.service - NFS status monitor for NFSv2/3 locking.
>      Loaded: loaded (/usr/lib/systemd/system/rpc-statd.service; enabled-run=
time; preset: disabled)
>     Drop-In: /usr/lib/systemd/system/service.d
>              =E2=94=94=E2=94=8010-timeout-abort.conf
>      Active: failed (Result: exit-code) since Fri 2025-09-05 18:01:15 EDT; =
229ms ago
>    Duration: 228ms
>  Invocation: bafb2bb00761439ebc348000704e8fbb
>        Docs: man:rpc.statd(8)
>     Process: 29937 ExecStart=3D/usr/sbin/rpc.statd (code=3Dexited, status=
=3D1/FAILURE)
>    Mem peak: 1.5M
>         CPU: 7ms
>=20
> Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Version 2.8.2 starti=
ng
> Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Flags: TI-RPC
> Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Failed to register (=
statd, 1, udp): svc_reg() err: RPC: Remote system error - Connection refused
> Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Failed to register (=
statd, 1, tcp): svc_reg() err: RPC: Success
> Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Failed to register (=
statd, 1, udp6): svc_reg() err: RPC: Success
> Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: Failed to register (=
statd, 1, tcp6): svc_reg() err: RPC: Success
> Sep 05 18:01:15 rawhide.smayhew.test rpc.statd[29938]: failed to create RPC=
 listeners, exiting
> Sep 05 18:01:15 rawhide.smayhew.test systemd[1]: rpc-statd.service: Control=
 process exited, code=3Dexited, status=3D1/FAILURE
> Sep 05 18:01:15 rawhide.smayhew.test systemd[1]: rpc-statd.service: Failed =
with result 'exit-code'.
> Sep 05 18:01:15 rawhide.smayhew.test systemd[1]: Failed to start rpc-statd.=
service - NFS status monitor for NFSv2/3 locking..
>=20
> I propose we revert the change from 8a835ceb and instead turn the
> dependency into a weak dependency by using "Wants=3Drpcbind.socket"
> instead of "Requires=3Drpcbind.socket".  This bends rule #4 above and will
> make it so that systemd will try to start rpcbind.socket if it isn't
> already running when rpc-statd.service starts, but it won't restart
> rpc-statd.service whenever rpcbind is restarted.  Frankly, we shouldn't
> need to restart services whenever rpcbind is restarted (thats why
> rpcbind has the warmstart feature).  The only drawback is that now if an
> admin wants to set up an NFSv4-only server by masking rpcbind.socket,
> they'll need to mask rpc-statd.service as well.  I don't think that's
> too much to ask, so the nfs.systemd man page has been updated
> accordingly.
>=20
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  systemd/nfs.systemd.man   | 10 +++++++---
>  systemd/rpc-statd.service |  5 +++--
>  2 files changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/systemd/nfs.systemd.man b/systemd/nfs.systemd.man
> index a8476038..93fb87cd 100644
> --- a/systemd/nfs.systemd.man
> +++ b/systemd/nfs.systemd.man
> @@ -137,7 +137,9 @@ NFSv2) and does not want
>  .I rpcbind
>  to be running, the correct approach is to run
>  .RS
> -.B systemctl mask rpcbind
> +.B systemctl mask rpcbind.socket
> +.br
> +.B systemctl mask rpc-statd.service
>  .RE
>  This will disable
>  .IR rpcbind ,
> @@ -145,9 +147,11 @@ and the various NFS services which depend on it (and a=
re only needed
>  for NFSv3) will refuse to start, without interfering with the
>  operation of NFSv4 services.  In particular,
>  .I rpc.statd
> -will not run when
> +will fail to start when
>  .I rpcbind
> -is masked.
> +is masked, so
> +.I rpc-statd.service
> +should be masked as well.
>  .PP
>  .I idmapd
>  is only needed for NFSv4, and even then is not needed when the client
> diff --git a/systemd/rpc-statd.service b/systemd/rpc-statd.service
> index 660ed861..4e138f69 100644
> --- a/systemd/rpc-statd.service
> +++ b/systemd/rpc-statd.service
> @@ -3,10 +3,11 @@ Description=3DNFS status monitor for NFSv2/3 locking.
>  Documentation=3Dman:rpc.statd(8)
>  DefaultDependencies=3Dno
>  Conflicts=3Dumount.target
> -Requires=3Dnss-lookup.target rpcbind.socket
> +Requires=3Dnss-lookup.target
> +Wants=3Drpcbind.socket
>  Wants=3Dnetwork-online.target
>  Wants=3Drpc-statd-notify.service
> -After=3Dnetwork-online.target nss-lookup.target rpcbind.service
> +After=3Dnetwork-online.target nss-lookup.target rpcbind.socket
> =20
>  PartOf=3Dnfs-utils.service
>  IgnoreOnIsolate=3Dyes
> --=20
> 2.50.1
>=20
>=20


