Return-Path: <linux-nfs+bounces-7416-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 143D99ADF00
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 10:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C3528A3D4
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 08:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A174D1AF0CB;
	Thu, 24 Oct 2024 08:18:07 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mta06-relay.cloud.vadesecure.com (mta06-relay.cloud.vadesecure.com [163.172.55.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945751AE005
	for <linux-nfs@vger.kernel.org>; Thu, 24 Oct 2024 08:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.55.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757887; cv=none; b=ic9A4/hqonpYQtRbl05+PXJ3x3B7uAUJmM7eb3+vUdJtskCcsCQnMKa/YnuRDWMOAwz1FZssdb3OGkx7rjwF0DqEJzDJefq5Do2JeCPMUwXCvs8hhK1MVEpeSHcboGPTPBiW+NZMpjqTdoMKvi/cFNTU10dOmbnfpHz984h8enc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757887; c=relaxed/simple;
	bh=NsTlMUAUHvIqwKHlgFXtuYyFWQ3uraiHvuucoHrlVWU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XdWxf1z9+sjyiRp95ZsSZqn8hXVLuXHQGl+tlD6UB/srSHz2f9bRkluVf21UQVsKsYNbqatGMIhLzBbVtjSdITjeCoDPLCwi+V2lmeCu8+qTakBJwKoC2eKFd/0fYqfBtjfUKP85Tixsrw2z6q+CiTBKwXkhtguUMP09sFbqolI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minesparis.psl.eu; spf=pass smtp.mailfrom=minesparis.psl.eu; arc=none smtp.client-ip=163.172.55.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minesparis.psl.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minesparis.psl.eu
Received: from smtp-out-1.mines-paristech.fr (smtp-out-1.mines-paristech.fr [77.158.173.156])
	by mta06-relay.cloud.vadesecure.com (vceu3mtao02p) with ESMTP id 4XYz73327Wz5yjp;
	Thu, 24 Oct 2024 10:07:59 +0200 (CEST)
Received: from z-smtp.mines-paristech.fr (z-smtp.mines-paristech.fr [77.158.173.137])
	by smtp-out-1.mines-paristech.fr (Postfix) with ESMTP id 5F10AC16AA;
	Thu, 24 Oct 2024 10:07:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by z-smtp.mines-paristech.fr (Postfix) with ESMTP id 5A4591C00DD;
	Thu, 24 Oct 2024 10:07:59 +0200 (CEST)
Received: from z-smtp.mines-paristech.fr ([127.0.0.1])
	by localhost (z-smtp.mines-paristech.fr [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id yGhuSYyWKJra; Thu, 24 Oct 2024 10:07:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by z-smtp.mines-paristech.fr (Postfix) with ESMTP id E2A891C00EE;
	Thu, 24 Oct 2024 10:07:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 z-smtp.mines-paristech.fr E2A891C00EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=minesparis.psl.eu;
	s=9f5ccecf-24a0-4eb3-a015-b6ac3b07c299; t=1729757278;
	bh=NsTlMUAUHvIqwKHlgFXtuYyFWQ3uraiHvuucoHrlVWU=;
	h=Message-ID:From:To:Date:MIME-Version;
	b=rd5N0t9M+CRKrvdyY2TXmVf8pT3RepqAIX1asKRHOG+WWeWF3lFWPnnpjDmPDHcXO
	 +c6m4XT39HbsdgdWlqaKbRof3WHE5OgqpD4KR7+0c7UBqZNfx85raWGpicSBWIJDAC
	 wdAeiM47J5DNSD4YhcN83Oqjntus6miRZZnfjmpzvez5LXwhW5oblGJnSZ/4HZuhca
	 B+9tcu6F4eKMYyPMJrh+DFoIc0MNIRqs830QEe/B/M6B+pvHmgcMETJoT2wa9AuhAH
	 qL5kdNDbPIesTcwPRM0Y6d0AUVJYBYmbUBw/kNXseoLKVy334E2mxp7VK7GRQU+jRQ
	 wjNp/KCU7iulw==
X-Virus-Scanned: amavisd-new at z-smtp.mines-paristech.fr
Received: from z-smtp.mines-paristech.fr ([127.0.0.1])
	by localhost (z-smtp.mines-paristech.fr [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LomSgyYYH3Jl; Thu, 24 Oct 2024 10:07:58 +0200 (CEST)
Received: from hive.interne.mines-paristech.fr (nat2-sop.mines-paristech.fr [77.158.181.2])
	by z-smtp.mines-paristech.fr (Postfix) with ESMTPSA id 696561C00DD;
	Thu, 24 Oct 2024 10:07:58 +0200 (CEST)
Message-ID: <bef86fe9904bde857ab734bebbfa2e9e60ccba37.camel@minesparis.psl.eu>
Subject: Re: nfsd stuck in D (disk sleep) state
From: =?ISO-8859-1?Q?Beno=EEt?= Gschwind <benoit.gschwind@minesparis.psl.eu>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date: Thu, 24 Oct 2024 10:07:58 +0200
In-Reply-To: <4A9BFCA9-7A15-4CA7-B198-0A15C3A24D11@oracle.com>
References: 
	<1cbdfe5e604d1e39a12bc5cca098684500f6a509.camel@minesparis.psl.eu>
	 <4A9BFCA9-7A15-4CA7-B198-0A15C3A24D11@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-VRC-SPAM-STATUS: 0,-100,gggruggvucftvghtrhhoucdtuddrgeeftddrvdeikedguddvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucggtfevpdfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegvnhhofphtucfishgthhifihhnugcuoegsvghnohhithdrghhstghhfihinhgusehmihhnvghsphgrrhhishdrphhslhdrvghuqeenucggtffrrghtthgvrhhnpeekudfggeeuleejjeffieehueelueeffeelveekffduudekhfefveehtedtfefggfenucfkphepjeejrdduheekrddujeefrdduheeipdejjedrudehkedrudekuddrvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhmrgigmhhsghhsihiivgepuddtgeekheejiedpihhnvghtpeejjedrudehkedrudejfedrudehiedphhgvlhhopehsmhhtphdqohhuthdquddrmhhinhgvshdqphgrrhhishhtvggthhdrfhhrpdhmrghilhhfrhhomhepsggvnhhoihhtrdhgshgthhifihhnugesmhhinhgvshhprghrihhsrdhpshhlrdgvuhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-VRC-SPAM-STATE: legit
X-VRC-POLICY-STATUS: t=1,a=1,l=0

Hello,

I will do it next time I get the issue, thanks by advance.

Best regards

Le mercredi 23 octobre 2024 =C3=A0 19:38 +0000, Chuck Lever III a =C3=A9cri=
t=C2=A0:
>=20
>=20
> > On Oct 23, 2024, at 3:27=E2=80=AFPM, Beno=C3=AEt Gschwind
> > <benoit.gschwind@minesparis.psl.eu> wrote:
> >=20
> > Hello,
> >=20
> > I have a nfs server using debian 11 (Linux hostname 6.1.0-25-amd64
> > #1
> > SMP PREEMPT_DYNAMIC Debian 6.1.106-3 (2024-08-26) x86_64 GNU/Linux)
> >=20
> > In some heavy workload some nfsd goes in D state and seems to never
> > leave this state. I did a python script to monitor how long a
> > process
> > stay in particular state and I use it to monitor nfsd state. I get
> > the
> > following result :
> >=20
> > [...]
> > 178056 I (idle) 0:25:24.475 [nfsd]
> > 178057 I (idle) 0:25:24.475 [nfsd]
> > 178058 I (idle) 0:25:24.475 [nfsd]
> > 178059 I (idle) 0:25:24.475 [nfsd]
> > 178060 I (idle) 0:25:24.475 [nfsd]
> > 178061 I (idle) 0:25:24.475 [nfsd]
> > 178062 I (idle) 0:24:15.638 [nfsd]
> > 178063 I (idle) 0:24:13.488 [nfsd]
> > 178064 I (idle) 0:24:13.488 [nfsd]
> > 178065 I (idle) 0:00:00.000 [nfsd]
> > 178066 I (idle) 0:00:00.000 [nfsd]
> > 178067 I (idle) 0:00:00.000 [nfsd]
> > 178068 I (idle) 0:00:00.000 [nfsd]
> > 178069 S (sleeping) 0:00:02.147 [nfsd]
> > 178070 S (sleeping) 0:00:02.147 [nfsd]
> > 178071 S (sleeping) 0:00:02.147 [nfsd]
> > 178072 S (sleeping) 0:00:02.147 [nfsd]
> > 178073 S (sleeping) 0:00:02.147 [nfsd]
> > 178074 D (disk sleep) 1:29:25.809 [nfsd]
> > 178075 S (sleeping) 0:00:02.147 [nfsd]
> > 178076 S (sleeping) 0:00:02.147 [nfsd]
> > 178077 S (sleeping) 0:00:02.147 [nfsd]
> > 178078 S (sleeping) 0:00:02.147 [nfsd]
> > 178079 S (sleeping) 0:00:02.147 [nfsd]
> > 178080 D (disk sleep) 1:29:25.809 [nfsd]
> > 178081 D (disk sleep) 1:29:25.809 [nfsd]
> > 178082 D (disk sleep) 0:28:04.444 [nfsd]
> >=20
> > All process not shown are in idle state. Columns are the following:
> > PID, state, state name, amoung of time the state did not changed
> > and
> > the process was not interrupted, and /proc/PID/status Name entry.
> >=20
> > As you can read some nfsd process are in disk sleep state since
> > more
> > than 1 hour, but looking at the disk activity, there is almost no
> > I/O.
> >=20
> > I tried to restart nfs-server but I get the following error from
> > the
> > kernel:
> >=20
> > oct. 23 11:59:49 hostname kernel: rpc-srv/tcp: nfsd: got error -104
> > when sending 20 bytes - shutting down socket
> > oct. 23 11:59:49 hostname kernel: rpc-srv/tcp: nfsd: got error -104
> > when sending 20 bytes - shutting down socket
> > oct. 23 11:59:49 hostname kernel: rpc-srv/tcp: nfsd: got error -104
> > when sending 20 bytes - shutting down socket
> > oct. 23 11:59:49 hostname kernel: rpc-srv/tcp: nfsd: got error -104
> > when sending 20 bytes - shutting down socket
> > oct. 23 11:59:49 hostname kernel: rpc-srv/tcp: nfsd: got error -104
> > when sending 20 bytes - shutting down socket
> > oct. 23 11:59:59 hostname kernel: rpc-srv/tcp: nfsd: got error -104
> > when sending 20 bytes - shutting down socket
> > oct. 23 11:59:59 hostname kernel: rpc-srv/tcp: nfsd: got error -104
> > when sending 20 bytes - shutting down socket
> > oct. 23 11:59:59 hostname kernel: rpc-srv/tcp: nfsd: got error -104
> > when sending 20 bytes - shutting down socket
> > oct. 23 11:59:59 hostname kernel: rpc-srv/tcp: nfsd: got error -104
> > when sending 20 bytes - shutting down socket
> > oct. 23 11:59:59 hostname kernel: rpc-srv/tcp: nfsd: got error -104
> > when sending 20 bytes - shutting down socket
> > oct. 23 12:00:09 hostname kernel: rpc-srv/tcp: nfsd: got error -104
> > when sending 20 bytes - shutting down socket
> > oct. 23 12:00:09 hostname kernel: rpc-srv/tcp: nfsd: got error -104
> > when sending 20 bytes - shutting down socket
> > oct. 23 12:00:09 hostname kernel: rpc-srv/tcp: nfsd: got error -104
> > when sending 20 bytes - shutting down socket
> > oct. 23 12:00:10 hostname kernel: rpc-srv/tcp: nfsd: got error -32
> > when sending 20 bytes - shutting down socket
> > oct. 23 12:00:10 hostname kernel: rpc-srv/tcp: nfsd: got error -32
> > when sending 20 bytes - shutting down socket
> >=20
> > The only way to recover seems to reboot the kernel. I guess because
> > the
> > kernel force the reboot after a given timeout.
> >=20
> > My setup involve in order :
> > - scsi driver
> > - mdraid on top of scsi (raid6)
> > - btrfs ontop of mdraid
> > - nfsd ontop of btrfs
> >=20
> >=20
> > The setup is not very fast as expected, but it seems that in some
> > situation nfsd never leave the disk sleep state. the exports
> > options
> > are: gss/krb5i(rw,sync,no_wdelay,no_subtree_check,fsid=3DXXXXX). The
> > situation is not commun but it's always happen at some point. For
> > instance in the case I report here, my server booted the 2024-10-01
> > and
> > was stuck about the 2024-10-23. I did reduced by a large amount the
> > frequency of issue by using no_wdelay (I did thought that I did
> > solved
> > the issue when I started to use this option).
> >=20
> > My guess is hadware bug, scsi bug, btrfs bug or nfsd bug ?
> >=20
> > Any clue on this topic or any advice is wellcome.
>=20
> Generate stack traces for each process on the system
> using "sudo echo t > /proc/sysrq-trigger" and then
> examine the output in the system journal. Note the
> stack contents for the processes that look stuck.
>=20
> --
> Chuck Lever
>=20
>=20


