Return-Path: <linux-nfs+bounces-2550-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB72890CDF
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 23:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3ABA1F25C4F
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 22:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6478513B5A3;
	Thu, 28 Mar 2024 22:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=scpcom@gmx.de header.b="YY59Dbqw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F5F1E52A;
	Thu, 28 Mar 2024 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663428; cv=none; b=S1aHz6ruxpwn8AZ7kAaN3RYMYbf6aDFgKqnM0HpCkHZno2wkEjVKQyus0uM2q8tKQSqlXoVCvrph/fqmCv2PEhO07SzM1kN5Ht8EeFMLvM9+fhmA9poW/A3f+BhEgoFAdUM3s77eP6oKKHUqPYSCtiETqb+/Qigtj7MC7APSgq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663428; c=relaxed/simple;
	bh=CS0ppGqFbnvglwBMLnip/ZMRB4UW8W2v79NabglHjCg=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=kPQ6eFD2Fvif0ewgDILqbz/E/X+WsiWEY3M3gN7NvffpuUoCHZW4XcpNgLtK2d5A7S/9qnMKN+W5bn4Pn+yaCin6tkDuVYkj4GTuvKJ2TODeziROO3fLWIN+N7PpnQEMMA2VMDV7YlP1dJ//3dKLzaxh4+GtPyEOts/k8jmtMdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=scpcom@gmx.de header.b=YY59Dbqw; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711663408; x=1712268208; i=scpcom@gmx.de;
	bh=k1Iva3U7pQT0dUGtSl5fVKHTOtnqF1C4hLtMB3Cs370=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=YY59DbqwSVQhu0fKt/SzX6lla7D3OcofdfNWIOGxqRBkGFCLgABzM+qn+s1DtEZS
	 ZekXRH8wJzgVQRHkzFz0TuJwylLFQXd4ePleVpyr0wPbBMA1ilC+7nlXkpwOEE1mH
	 IlSfhEiqEKOdSesah5bB5qYoM+nh1DKWTV5IKyyU31xztgeYisJoyHV7md++oAr9k
	 S5fWaxgHo3awTZ+m/Xn3XrFsFz0Dfl67joIxGPSr9qEMpF2+2nIh6GwXpS0xnn9a/
	 fx8fOyuRA7rruh5LuqlYAM3Nf/WX/cEPgh0S1gz1iiE2exSfPEjlF9D9Wg5Kz4nwt
	 KidnEtHjlaoPY4QOhw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.236.10.6] ([10.236.10.6]) by msvc-mesg-gmx001 (via HTTP);
 Thu, 28 Mar 2024 23:03:28 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-db344068-bb4b-4d0b-9772-ff701a2c70dd-1711663407957@msvc-mesg-gmx026>
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
Date: Thu, 28 Mar 2024 23:03:28 +0100
In-Reply-To: <51CAACAB-B6CC-4139-A350-25CF067364D3@oracle.com>
References: <trinity-068f55c9-6088-418d-bf3a-c2778a871e98-1711310237802@msvc-mesg-gmx120>
 <E3109CAA-8261-4F66-9D1B-3546E8B797DF@oracle.com>
 <trinity-bfafb9db-d64f-4cad-8cb1-40dac0a2c600-1711313314331@msvc-mesg-gmx105>
 <567BBF54-D104-432C-99C0-1A7EE7939090@oracle.com>
 <trinity-66047013-4d84-4eef-b5d3-d710fe6be805-1711316386382@msvc-mesg-gmx005>
 <6F16BCCE-3000-4BCB-A3B4-95B4767E3577@oracle.com>
 <trinity-ad0037c0-1060-4541-a8ca-15f826a5b5a2-1711396545958@msvc-mesg-gmx024>
 <088D9CC3-C5B0-4646-A85D-B3B9ACE8C532@oracle.com>
 <trinity-77720d9d-4d5b-48c6-8b1f-0b7205ea3c2b-1711398394712@msvc-mesg-gmx021>
 <51CAACAB-B6CC-4139-A350-25CF067364D3@oracle.com>
X-Priority: 3
X-Provags-ID: V03:K1:aya7AI2eeD8zsCSVeocOOkx7Fl5xZwQSuC0fMfTcMLXuX42EBnA7IsxPZ3jzxqGGfDuXK
 +gCv5qyxwY2tE/1EBGUW4daC4d6g7QsZXkAcjO8WGOl+5GPcaY0MNjzz7ZTxmNPA8/uc0e1P8wX0
 JnjA2Ih0zQo59aDqTN+MLcSpB94nGwBSOhcX/ymAt3Pd726XmlaSfEoHpLWmwpbiQMWFrur7h4Kw
 flP/0RQLF76vrNh/jJnfWYw3RkmT20MXuY4NX9GSvSb56X61+0CfsBZUBaypaBJT5/TH6c36rJ9d
 KY=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uMl+1g9NXAI=;HWc+QwHnNviUpAPUakv/EEgMy7O
 h1MM2EU0xq8bmffM5wmnQK/li+VhROyCMf9ElPcI1+S8Hl3J65k4wgL4YYLKv7YAfJQ+YzSAC
 SB7fYr7i9qJl3sLxbiRKMrbGKZ1UiSuTfFNl3Kyq0HlahpLl2rQ+dcT3LHIVpW0X73P1tEI/B
 Huy0CPceSpw6HCn4oldBtNLUF6JVrjwng1+2Lzp7x8ChU3bexbjEkfTeoahZ3v0UaqkaikDx3
 BWEaud5KdQcpBFYsXPQZe6zMRHok94fABfnka5AZTpjOLbAm4ZU8tjrwl7PSWf1OQCyCPTyw3
 u7GQahvd9AkqkztR0+7qq/JjMVASUihQW2b4ryVDb//9IlecO7YqF2gROvfv0UzPMaykHTjGT
 Xcp//eshFABAlFJa37pGDWzwtzNEfJSXNU48rWUh9JlBXxrLGM22IRpvovdb5M+Toodd8BO2C
 pEPcOPs/s5qkbr+He5S3W1rskz86YQDEYCc3uz56vtwhqF6CkEPpxNPPg34KRUqDezkUba2k4
 vvWX0fiM4j5xTW8XluLmWxQ5P5K/gCL9+VQTc/B2dvTHdsAnDR/ywDh2B1jbCrecyBjG+Fqwt
 mmLgdqyHZUcpvLS3FRkgsGqGpvtue4vMvFuVd7lkZ//JJgWvPMndUQS9SprObaXwh/xAJ7Bla
 bjq2L8GgK2oa0uOtSzfBkl8JpP39//YN+4R5NlTSKrkdoXHTQudcMq6AWsEiMA0=

Inside the VM I was not able to reproduce the issue on v6=2E5=2Ex so I keep=
 concentrating on v6=2E6=2Ex=2E

Current status:

$ git bisect start v6=2E6 v6=2E5
Bisecting: 7882 revisions left to test after this (roughly 13 steps)
[a1c19328a160c80251868dbd80066dce23d07995] Merge tag 'soc-arm-6=2E6' of gi=
t://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/soc/soc

--
$ git bisect good
Bisecting: 3935 revisions left to test after this (roughly 12 steps)
[e4f1b8202fb59c56a3de7642d50326923670513f] Merge tag 'for_linus' of git://=
git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/mst/vhost

--
$ git bisect bad
Bisecting: 2014 revisions left to test after this (roughly 11 steps)
[e0152e7481c6c63764d6ea8ee41af5cf9dfac5e9] Merge tag 'riscv-for-linus-6=2E=
6-mw1' of git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/riscv/linux

--
$ git bisect bad
Bisecting: 975 revisions left to test after this (roughly 10 steps)
[4a3b1007eeb26b2bb7ae4d734cc8577463325165] Merge tag 'pinctrl-v6=2E6-1' of=
 git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/linusw/linux-pinctrl

--
$ git bisect good
Bisecting: 476 revisions left to test after this (roughly 9 steps)
[4debf77169ee459c46ec70e13dc503bc25efd7d2] Merge tag 'for-linus-iommufd' o=
f git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/jgg/iommufd

--
$ git bisect good
Bisecting: 237 revisions left to test after this (roughly 8 steps)
[e7e9423db459423d3dcb367217553ad9ededadc9] Merge tag 'v6=2E6-vfs=2Esuper=
=2Efixes=2E2' of git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/vfs/vfs

> Gesendet: Montag, den 25=2E03=2E2024 um 21:36 Uhr
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
> > On Mar 25, 2024, at 4:26=E2=80=AFPM, Jan Schunk <scpcom@gmx=2Ede> wrot=
e:
> >=20
> > I am building my own kernels, but I never tried kmemleak, is this just=
 a Kconfig option?
>=20
>   Location:
>     -> Kernel hacking
>       -> Memory Debugging
> (1)     -> Kernel memory leak detector (DEBUG_KMEMLEAK [=3Dn])
>=20
>=20
> > What do you mean with "bisect between v6=2E3 and v6=2E4"?
>=20
> After you "git clone" the kernel source:
>=20
> $ git bisect start v6=2E4 v6=2E3
>=20
> Build the kernel and test=2E If the test fails:
>=20
> $ cd <your kernel source tree>; git bisect bad
>=20
> If the test succeeds:
>=20
> $ cd <your kernel source tree>; git bisect good
>=20
> Rebuild and try again until it lands on the first broken commit=2E
>=20
>=20
> > Everything including v6=2E4 is OK, the problem starts at v6=2E5=2E
>=20
> I misremembered=2E Use "$ git bisect start v6=2E5 v6=2E4" then=2E
>=20
>=20
> > I also looked at some code already but there are huge changes to mm th=
at happened in v6=2E5 and v6=2E6 so for me it is heavy to compare it with o=
lder versions to find one or more commits that may cause the issue=2E
>=20
> Bisection is a mechanical test-based process=2E You don't need
> to look at code until you've reached the first bad commit=2E
>=20
> --
> Chuck Lever
>=20
>

