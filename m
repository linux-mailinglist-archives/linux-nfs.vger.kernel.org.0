Return-Path: <linux-nfs+bounces-2478-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 506CA88C9CC
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Mar 2024 17:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43B41F82588
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Mar 2024 16:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A3418EB0;
	Tue, 26 Mar 2024 16:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=scpcom@gmx.de header.b="MsWCubZE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B115D14A82;
	Tue, 26 Mar 2024 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471838; cv=none; b=EA6YX/88xb1kzcUn+m45tOWzIhVAODVHKnddquJUwFjaYAN1+yxQqWeUocnf7IUId2H7XY7zsPb0MRMZd+QFvkcaKSMEZ6EBtp4fdFatd5U/Ln3YtjUWUgouLfUfXQhIPSl4D/t3ZvTTvL//snlMWzG3GESXeODrnvz4IWNsChI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471838; c=relaxed/simple;
	bh=LxlmUbax7TI7+fT/Wk9VQfkEo0fop2slPGTTM0CV57Q=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=cW23V5s6nLV88uTkCev/Xky5fbn0g0+eqy0vqXS7ePKSPJiLiKC2qejt3gXcB1vJ8Pt7sL1oAtrjcGrn4CBfpaK5ob86ES8jXKBqrHDZzmQjqOnGIm+nGRAu6PXqXJKUtNNtM/L39w+grKXoc/T8NAM4U7v6vx8Bmo8NLaNU4iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=scpcom@gmx.de header.b=MsWCubZE; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711471819; x=1712076619; i=scpcom@gmx.de;
	bh=D7hyAJXliCPkU72kxFLi3zmK776n1nYhB0f6quul2FI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=MsWCubZEWJpJSrKunzkFvtiilFD+mRQ3e5ER5RknEoTGzDmqNi+7FzHYtmjTKTjv
	 TNfBW/oS4EaYREKN9hLXNHX2nEKIYU0RMgvIPavLypNEEfH2u6/+Yut94RyoHKEZE
	 gDkCePjJnGRFpRBCCLsDf9yDZO16DEe7gSAw/kTlhbWC64lw3YND5iQNjdJV5mhjH
	 Qmy9Yo6An8zxAQ3//IbV709IbPI8q7XwMEgwmGB+u9moacf9Bm/vwnbrCvMIOg1MY
	 taYdY3svRr3yy3G9Xi7ndd5znUgR2+OrCd2KgzwwKqqK1Wo2cfA+Ef+RV3h3IVPVB
	 u/0xekLqBbpDEMaqgQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.236.203.6] ([10.236.203.6]) by msvc-mesg-gmx120 (via
 HTTP); Tue, 26 Mar 2024 17:50:19 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-db4c718f-d59d-4de4-bf45-96ad98ca2362-1711471819632@msvc-mesg-gmx122>
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
Date: Tue, 26 Mar 2024 17:50:19 +0100
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
X-Provags-ID: V03:K1:qK7L0PYkR0ABvV3aOXifK+HTJvFE9bYQAwP4De87usL/5JVhKN6ZL9H/8m0dqVC7PG4+i
 mBcweO48TgRzzgIZCQz0D9QbcquTpbg2yCXCCFacrs0G4t1GqUnvzsHQM56YnpO/flLccoXz2sBk
 x2kPEG1fyybtY6ErIEoYIVBRmKDt+xiiSKjeE0DwBH/UjpYsICp2ZZXBQDvkPYkt7Gq1adVwxJrv
 A+MKOcZ9gghEH9wpj1j42fzxqvw+G+Lw3mw9rGbOqkEHBFVcvJL5L3KekUpY5C9Zm0m6jvshJq19
 Uk=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mn/q4lFkgaE=;t+wfUvvKeQdfFjicqwysIYlwxNi
 dnq8kAYz1bFtfCNe3oGI+7+yVAUZIajHYCUNS0O5pZqQaeIwS2iUD5N/3MNN5luYEQsVfGSC9
 NhFSIh4pjneOwFYQh42Z1fRncY2Vu5TZYLFlCIwM9c1kohOrvOXWyLi1oJzCncEnpT9MNENNP
 WQ3HH2UNb6ikB4cY8NtbxwxDplLCnDMbU5Dz6EusO/5cMdvoJGI6JJXLNZBN9jPccbZSrao4X
 YMiWapJdyYymfW79fwAqwPDK3yGCuhVBsZ7T5o2wgVdPYxnqfSmBHkbXg9POJJhxXhIvC8UcZ
 rdtwqq9rzPAvL/CJtx9KBXqQNMgeRvU5r6AF+k1s4PES1LjjvRcITO3DwvdYyj9Hs1KxZjrWd
 FmsHgEYfGFVEebEc4awq33tFOEzNGNKRvtbCcEBO77oZxL2Qn/IDJ9tOu0HGHmaX/hBTahAWG
 hS8KF3AXDx6Kg2aCrJdeoluJEzPse3lMOM8uJG1BrV0UcIWWJHdmjVV6hom/BsnM6twm7ucra
 uykhFharzj2xDp0O1FRPYPbAh4suYlyIQQdK4P92sF2Ki52sCkXp7mxGI+zF4h2Sn5Emggqgo
 aUFM7VVcQrlSGU6SADYMTrgXPp/YNOiLOH/PXX+ai+/kceOLn3P3zCcDE5Jr8aE2sScKIQkNK
 ZxsWeaItBClj9u0/WzcGLAVan0NdlanlTJbaBKPDZXnlQoj9Yq5lQaYxKUI9jKw=

Thanks, I do some tests with DEBUG_KMEMLEAK enabled and git bisect now=2E

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

