Return-Path: <linux-nfs+bounces-6648-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528A4986378
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 17:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141FD28C124
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 15:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389D350284;
	Wed, 25 Sep 2024 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="Ktwhe62L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2161CA85;
	Wed, 25 Sep 2024 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727277358; cv=none; b=pq99te5FmByLPuia3Uo90NIvAGvIjPLKTMQGNom6uOvGsKC6CcI3gklpuOBUg2IiMy9IOod+MCFyIHbmUfIUHo3La+M8SM1AHpQ0zGdFq/8Lp1Hvl/NWV7pF5/M6hWlh/B+iN15lS4oqSmPB2xBrsw5BFXXFaxJ5S7EhkJRTHhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727277358; c=relaxed/simple;
	bh=jPXETytddQOKLiox9CBonx4NSFTwxl03nKC5h9JefRw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iw7DTIO8F5U0bgP53GXqrVkAjjsAEuaQ3FGVnt8qo90B0KGA3B7qj7Nqe32eFQmrHPW0GOuGaI8X88D1zLSBU0UcJM1JcT+vYtxcRWEmAagI0gxdb9y6VbDkK+o/T65a4W5h8MxMsh/PBV/jLg4+N5/Evh2h6ox6eG1gHFNEYVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=Ktwhe62L; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1727277352;
	bh=jPXETytddQOKLiox9CBonx4NSFTwxl03nKC5h9JefRw=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=Ktwhe62LpW5fb+3wNjs4dxdIX0czSXY8/rjigbdxgXCxLjYEhjIPmqKkeIlk5gY9O
	 USb+tm0kxB9cY5QgIxa+FqEST6DvkHABjviYxpFoWNehIKLd8kkJSSQ3MYj0h2DPWz
	 ZuhFM9ushlIpwc6h1H0YlJvJ4ep1bw/quurpeiZE=
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: nfsv41: stale file handles after VM shutdown/poweron - but works
 during warm reboot
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <9937A07A-F7AE-4A99-B7DE-7CF026E0F7B8@oracle.com>
Date: Wed, 25 Sep 2024 17:15:31 +0200
Cc: Jeff Layton <jlayton@kernel.org>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3FB1C2D6-F409-44ED-B799-E2657759E455@flyingcircus.io>
References: <AFE3E539-B98A-465F-9860-EE142D00285F@flyingcircus.io>
 <9937A07A-F7AE-4A99-B7DE-7CF026E0F7B8@oracle.com>
To: Chuck Lever III <chuck.lever@oracle.com>

Hi,

> On 25. Sep 2024, at 16:32, Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>=20
> I'm not entirely certain what you mean by "cold restart" versus
> "warm restart" but for the moment I will assume that "cold restart"
> means you reboot the NFS server host, and "warm restart" means
> you simply cycle the NFS service (eg systemctl restart nfs-server).

The NFS server is a VM: the "warm reboot" keeps the hypervisor process =
active and only performs an internal start within the VM. The =E2=80=9Ccol=
d reboot=E2=80=9D performs a shutdown/poweroff, the hypervisor process =
exits and then a new VM hypervisor process is started again.

> STALE means the file handle no longer exists on the server. This
> can mean the file system was unexported and thus is no longer
> accessible.
>=20
> In your case, I'm guessing that what is happening on a cold
> restart is the exported file system is replaced; for example
> a tmpfs. Or, maybe reboot removes exported files.

And while riding my bike home and getting some fresh air I came to the =
same conclusion (after previously bashing my head against this for =
hours).

We have a step where VMs (that are booted fresh on the hypervisor) get a =
randomized UUID on their root filesystem and because of $reasons we do =
that every time, not just during first boot. Looks like we need to stop =
doing that.=20

My problem goes away once I fix the fsid in the exports, but I don=E2=80=99=
t think I want to dig a deeper hole.

Sorry for the noise and thanks for the hint (which seems even arrived =
telepathically).

Cheers,
Christian

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


