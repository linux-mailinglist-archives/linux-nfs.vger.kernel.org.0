Return-Path: <linux-nfs+bounces-2470-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 439E488B156
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Mar 2024 21:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BDE5303348
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Mar 2024 20:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD934AEF9;
	Mon, 25 Mar 2024 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=scpcom@gmx.de header.b="m28Sj9V7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA07487AE;
	Mon, 25 Mar 2024 20:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398413; cv=none; b=RPc7chL5A/rXnZi7hM/qwERnJMmbkn5YDR2UR4iMG6tTw9vbwNSgabFNx7qzoKxfsUilE/5GGhwbnSZV89pkkGARaP8KPO3BA/J9acbjA9z2sbQ0EnCwccXtOhJN9GAzgVqiwfqoWCzgZcsJPQ30tk9vHlq1vZnD7eUgn5p4MGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398413; c=relaxed/simple;
	bh=sirxy7fEgeaEeO6FTxMzd8nAXM+znP7Hzj8NSE0pTnk=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=A/zkKZdy7miNgdL+8xMr8Ki+qyN0dJnTmODld1OJ3bivH5gqtTxuFgm3oGlaeMJ3VEJUkyVg+ka/D7Cr38EZKDiOgosGufxqa9Kay1xobUxD1goduJPIPjaZlogzPDEEyQgZfrU6iih5/xlhOwqbjrS6jAtHYqELzaRBFRdp+4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=scpcom@gmx.de header.b=m28Sj9V7; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711398394; x=1712003194; i=scpcom@gmx.de;
	bh=TFWhVf6FAP0u+nZm5RqM5xg+6k2IVEXLXNjFBZXAJTg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=m28Sj9V7bEpljZpCRxs45km+eFyhrs21Dw7c4d0opxxMRdcz4T4h1iRDDUlFBzZU
	 RUFqUjJzWK3opSi9ZywTFw9dkm68jBFL6Or3SR4pT9zyyPL3uTEuUqtRzXeyX1jGk
	 p+33yUUMbygHss7qsvTcLwqg0s0qrTMLkx/gHoMNoTd89IoH+vd/Bi2BOLvwyAmOh
	 BBKkaHeu7GjRSC+GFb0Znm2roccDpzwcrxozOW34TbmfoTwOR0CjbttXfZetz25bM
	 VIfRdWDHuN5fhkKE8lg8jG1fvUtiXdTyJAAIef2vL3jeXYAZ7M7rwKHkr5pyBa0em
	 vofyXctujx24Vv8FLg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.236.12.4] ([10.236.12.4]) by msvc-mesg-gmx001 (via HTTP);
 Mon, 25 Mar 2024 21:26:34 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-77720d9d-4d5b-48c6-8b1f-0b7205ea3c2b-1711398394712@msvc-mesg-gmx021>
From: Jan Schunk <scpcom@gmx.de>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, Olga
 Kornievskaia <kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Aw: Re: [External] : nfsd: memory leak when client does many file
 operations
Content-Type: text/plain; charset=UTF-8
Importance: normal
Sensitivity: Normal
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 Mar 2024 21:26:34 +0100
In-Reply-To: <088D9CC3-C5B0-4646-A85D-B3B9ACE8C532@oracle.com>
References: <trinity-068f55c9-6088-418d-bf3a-c2778a871e98-1711310237802@msvc-mesg-gmx120>
 <E3109CAA-8261-4F66-9D1B-3546E8B797DF@oracle.com>
 <trinity-bfafb9db-d64f-4cad-8cb1-40dac0a2c600-1711313314331@msvc-mesg-gmx105>
 <567BBF54-D104-432C-99C0-1A7EE7939090@oracle.com>
 <trinity-66047013-4d84-4eef-b5d3-d710fe6be805-1711316386382@msvc-mesg-gmx005>
 <6F16BCCE-3000-4BCB-A3B4-95B4767E3577@oracle.com>
 <trinity-ad0037c0-1060-4541-a8ca-15f826a5b5a2-1711396545958@msvc-mesg-gmx024>
 <088D9CC3-C5B0-4646-A85D-B3B9ACE8C532@oracle.com>
X-Priority: 3
X-Provags-ID: V03:K1:ZFw7evkSY6o6F1YQ1W5m+DbHIfZY4qKTfHzoAohk5C8L6s9QBbeYDbswgf+ea4NuJ+gSv
 QSYKvq+1Rc25VhTi6ToUuiyOXiiyjZwHGGyHiIiAYnpTGpcYH7wYqMnqgl714kRyA2CvJTtC+Hz0
 WcwvetN7SwmszmDnlaOk/5UUgE4K/jswrHlTI0AiQiVbeWJVfEj+CkoceK9q3kGEIWdlcTXE5xWm
 5p4CKpfcGAARRDsG6gKOIWhuluvJlxxHbqv4jLCi8UHY2ctR57fhPW/cJfKhh/0gi7a3CxMyeqTd
 QM=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UsaWHKC/ZJI=;xg6p6NfN7pMdG8ExPZVQTWnGdDX
 skcEndFmF3hhdOkXiE/DrFI/ZoSeM5G4TO8G0o/TBw/M+byIa6HQJDL4efSglPX3JAOLY2Jrg
 rVIyvXnkcjIOmNdA/T9LShOvs1TassDavG8yYMZgYZoiwo6govVu7VpPvixMY7Sc4W+8fPaP0
 Wc5aIZVRH4EuVDVzjWjeua6QzSIQkF+aU0vYbNbgvdnHtcgsAKriOka+DKQ9jtSDTvScReIBB
 O8UM2/OIrT+ILwZU+j0bk6nOtgPCltEyFMYbzugcnJ8PrBsMN0qGliri8nRROM2Dx3O60GsQI
 bgdeOoMcueJ+JK+akzTJ9gRyHvORX4RS4TcWHvUrhu8ErI6+1Rhc9PFu9TdPmIlYGs0nN/nU3
 ssYvUGLUxKXUjbv7UP1uwxi4ij99aSzAzHDlgQam65yfRoQzwjYuYePO0CgfEgDXHog5MmGWh
 PfOYo7+md8IPi7CiStOmZpGywRLQrUwZKJphTXu3s6mfnl1Xn5KTBDVsenLD1FFHHz1kWRXig
 IJ4EYutg3kSpT5KftvaOtmwrKt89gvog4RJoyUQKaq8AEuknE/A84A7FP+jJ0u7KeSqEN04E7
 ehidLwjuDbKKqv0cQ3ZEsK+nEgatwnHigYfguwHv42T0lUs/xAVT5l/sqYeOwy7eMSHu5C25E
 9zb5tlWKfI3apmyZ125GgqtJ7i1PXq37YVFj+tId++tqWFcs0Pe8ssCYx9/Vuf8=

I am building my own kernels, but I never tried kmemleak, is this just a Kc=
onfig option?
What do you mean with "bisect between v6=2E3 and v6=2E4"?
Everything including v6=2E4 is OK, the problem starts at v6=2E5=2E

I also looked at some code already but there are huge changes to mm that h=
appened in v6=2E5 and v6=2E6 so for me it is heavy to compare it with older=
 versions to find one or more commits that may cause the issue=2E

Btw=2E thanks for guiding me so far=2E

> Gesendet: Montag, den 25=2E03=2E2024 um 21:11 Uhr
> Von: "Chuck Lever III" <chuck=2Elever@oracle=2Ecom>
> An: "Jan Schunk" <scpcom@gmx=2Ede>
> Cc: "Jeff Layton" <jlayton@kernel=2Eorg>, "Neil Brown" <neilb@suse=2Ede>=
, "Olga Kornievskaia" <kolga@netapp=2Ecom>, "Dai Ngo" <dai=2Engo@oracle=2Ec=
om>, "Tom Talpey" <tom@talpey=2Ecom>, "Linux NFS Mailing List" <linux-nfs@v=
ger=2Ekernel=2Eorg>, "linux-kernel@vger=2Ekernel=2Eorg" <linux-kernel@vger=
=2Ekernel=2Eorg>
> Betreff: Re: [External] : nfsd: memory leak when client does many file o=
perations
>=20
>=20
>=20
> > On Mar 25, 2024, at 3:55=E2=80=AFPM, Jan Schunk <scpcom@gmx=2Ede> wrot=
e:
> >=20
> > The VM is now running 20 hours with 512MB RAM, no desktop, without the=
 "noatime" mount option and without the "async" export option=2E
> >=20
> > Currently there is no issue, but the memory usage is still contantly g=
rowing=2E It may just take longer before something happens=2E
> >=20
> > top - 00:49:49 up 3 min,  1 user,  load average: 0,21, 0,19, 0,09
> > Tasks: 111 total,   1 running, 110 sleeping,   0 stopped,   0 zombie
> > %CPU(s):  0,2 us,  0,3 sy,  0,0 ni, 99,5 id,  0,0 wa,  0,0 hi,  0,0 si=
,  0,0 st=20
> > MiB Spch:    467,0 total,    302,3 free,     89,3 used,     88,1 buff/=
cache    =20
> > MiB Swap:    975,0 total,    975,0 free,      0,0 used=2E    377,7 ava=
il Spch
> >=20
> > top - 15:05:39 up 14:19,  1 user,  load average: 1,87, 1,72, 1,65
> > Tasks: 104 total,   1 running, 103 sleeping,   0 stopped,   0 zombie
> > %CPU(s):  0,2 us,  4,9 sy,  0,0 ni, 53,3 id, 39,0 wa,  0,0 hi,  2,6 si=
,  0,0 st=20
> > MiB Spch:    467,0 total,     21,2 free,    147,1 used,    310,9 buff/=
cache    =20
> > MiB Swap:    975,0 total,    952,9 free,     22,1 used=2E    319,9 ava=
il Spch
> >=20
> > top - 20:48:16 up 20:01,  1 user,  load average: 5,02, 2,72, 2,08
> > Tasks: 104 total,   5 running,  99 sleeping,   0 stopped,   0 zombie
> > %CPU(s):  0,2 us, 46,4 sy,  0,0 ni, 11,9 id,  2,3 wa,  0,0 hi, 39,2 si=
,  0,0 st=20
> > MiB Spch:    467,0 total,     16,9 free,    190,8 used,    271,6 buff/=
cache    =20
> > MiB Swap:    975,0 total,    952,9 free,     22,1 used=2E    276,2 ava=
il Spch
>=20
> I don't see anything in your original memory dump that
> might account for this=2E But I'm at a loss because I'm
> a kernel developer, not a support guy -- I don't have
> any tools or expertise that can troubleshoot a system
> without rebuilding a kernel with instrumentation=2E My
> first instinct is to tell you to bisect between v6=2E3
> and v6=2E4, or at least enable kmemleak, but I'm guessing
> you don't build your own kernels=2E
>=20
> My only recourse at this point would be to try to
> reproduce it myself, but unfortunately I've just
> upgraded my whole lab to Fedora 39, and there's a grub
> bug that prevents booting any custom-built kernel
> on my hardware=2E
>=20
> So I'm stuck until I can nail that down=2E Anyone else
> care to help out?
>=20
>=20
> --
> Chuck Lever
>=20
>

