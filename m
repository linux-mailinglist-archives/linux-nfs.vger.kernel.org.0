Return-Path: <linux-nfs+bounces-2568-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C93892BD5
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Mar 2024 16:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59E34B2164E
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Mar 2024 15:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624A8383BF;
	Sat, 30 Mar 2024 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=scpcom@gmx.de header.b="aXbGR2HY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C73CA936;
	Sat, 30 Mar 2024 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711812391; cv=none; b=a06DZg8+rIUFqUMCpCfJ7XHSeidmCwKaU+pFj6eUq8QewgY94Mi21CCJAIVBQf1proX4IJe/QFzjRtywaELebF2iuBPeVbk/GAm2dLD0ZiKor2tSJtUm4hUxZqjRT4biJpu0dc/Z11k+R5rPYi02d+JGRPwzt+VKOYBbv8be1v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711812391; c=relaxed/simple;
	bh=vTcKlkthbHVhqLWeuszmj9ZNuv/4eToHzh8rH3dQSnQ=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=mDmkVqIlncp+56MT5MMb53g4ld5jXQhpg0hSm5ZA4EaXSBF/S35xTs6GFwatmWz4bN4aCSJ2U59RI9MI/yDU4Ug5tJTotS9/TkhJwA3xdE5rdUHGSWgux6bJ+k9bAeiAwR9f5s4R+/dw6As+Q8Yw+XLdjVhreSWac55WhhWn3+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=scpcom@gmx.de header.b=aXbGR2HY; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711812369; x=1712417169; i=scpcom@gmx.de;
	bh=5oQjf65Df8M8V/cQAMSWG48j1MP4iLtNQC3TPtc/DnE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=aXbGR2HYCbSXgJRizbXD06JsjYgVpsao0O5CEnvIeoBI9VdNixyhbQycV35ToRnT
	 zrYDtdVQT2XL/MgEERXWskdvB7tThbWP3LHph4yOUvUAKM1WYgKuLHNQij5l4aPbL
	 lzvX/UQQ6yponp9p5aPEPfgIo90LEP828l7SigAYjDjPALeXNf8BuoG7Y0jRYahRr
	 patau6NBzIu+KRAxm7BqZDIRYf/7YRFA5ngskvx0cKmxX9rg9xbNlfPMrU7W7/ZgU
	 01BxE6aJ1bjA5kfOFGms0RhFaOpJOMhsnP9SfNEVczDAsI6D7D8vM32elCjQHXzeZ
	 XL/ElgLkMl7E1/whjg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.236.10.6] ([10.236.10.6]) by msvc-mesg-gmx003 (via HTTP);
 Sat, 30 Mar 2024 16:26:09 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-157de7e0-d394-47fa-bb44-2621045a5b6e-1711812369391@msvc-mesg-gmx004>
From: Jan Schunk <scpcom@gmx.de>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Benjamin Coddington <bcodding@redhat.com>, Jeff Layton
 <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, Olga Kornievskaia
 <kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Aw: Re: [External] : nfsd: memory leak when client does many file
 operations
Content-Type: text/plain; charset=UTF-8
Importance: normal
Sensitivity: Normal
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 Mar 2024 16:26:09 +0100
In-Reply-To: <C14AC427-BD99-4A87-A311-F6FB87FFC134@oracle.com>
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
 <trinity-db344068-bb4b-4d0b-9772-ff701a2c70dd-1711663407957@msvc-mesg-gmx026>
 <C14AC427-BD99-4A87-A311-F6FB87FFC134@oracle.com>
X-Priority: 3
X-Provags-ID: V03:K1:3GaQxxYirBNxyRu6Rl7Eqo2YyTa7fLW7IDNu9XXBF2tK1ISEaG3smj0iGy4QO6VLEbzsT
 3UdLxIv1VNhI3OGn/4tPvI5UY9aFbxZkDHRPV6hsGM+X72WyokuZ+O614ruQEDXtruX/pQcbbgi8
 EUm1tGHNn9+3C+z4TWGBSZbvymnPKBOr41C29ln/FB0Fjd8mkxQK6JCfAOBmTtG/T9s9jS1V6ZXL
 PqZb6cG2vV/QHDzVVDLWbsPWeyWGk6Lo81rdJ0eDPFR5MSj4QbG4ize4PHqbpDbRd3L/dUspNaD2
 0k=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ckG2Twyj/5k=;2itTDgEh33ZEW+EmfB/tXSVraKc
 EW7aoMvyeqmYN/PshZBh036xeSEen3BmwuUFQTCb9pYxip/yu7Sw0LOCV4gRwsXZyI27iAmsS
 rt+DpZicTV7uxzMXoUwn2i461YktSMcUSxLwrh+aqCqLS6XMTvKxkn9emk/W/Hq2zaOoGVxdE
 agIqgC3XNu7RqF22mys4bUKcBzs/H/agVFTWCaccAYzO/xCysCIF+DSFUqvJLcpvSyYU6UmYE
 dg4DYbj10Hi6ClMy2z3nV3aIDe8d2msvU3FAI295MOZuqGD5BdjdcL0u3psp8KDsqLQdikc/s
 WOKYsVYnOHOSXTgNWZfQ5KanWw/p+tE4jZf6KqqWbFEXuGGHlok/BwRcIp/+dMNWIyxRr/uF2
 gWg71yE7t1DpNVRZb4zEd5HV09UNvejDMJaaqLktOHr53MT6z89WpBV7iMdj89Wg27v4Hqk92
 kP5X6K5zU895z46mkP5A5cOksuyycemIf6LqoK0YHtNCzkA+VxhHHiD7vMcwQT3TOfSL3udqx
 JPLvD6VrQF2gZCrOrc1FEaH4xlhZinGEMApDHRI1FdQmu+q+1q1v/c/UYEPGp2XNEtWJ8r3Ix
 JkdxCppSv8cEnfcpG3pUmOWPaXATECx12Ms523CZBuEsQnEHEmy5kYxoM5ghukQ1LF5QddcB3
 dgS+fi92XK9qr2zuKRafARfUV4nqwmRKq531bjaouIp52z4f4n4/2KyB6BlRmw8=

Full test result:

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
--
$ git bisect good
Bisecting: 141 revisions left to test after this (roughly 7 steps)
[8ae5d298ef2005da5454fc1680f983e85d3e1622] Merge tag '6=2E6-rc-ksmbd-fixes=
-part1' of git://git=2Esamba=2Eorg/ksmbd
--
$ git bisect good
Bisecting: 61 revisions left to test after this (roughly 6 steps)
[99d99825fc075fd24b60cc9cf0fb1e20b9c16b0f] Merge tag 'nfs-for-6=2E6-1' of =
git://git=2Elinux-nfs=2Eorg/projects/anna/linux-nfs
--
$ git bisect bad
Bisecting: 39 revisions left to test after this (roughly 5 steps)
[7b719e2bf342a59e88b2b6215b98ca4cf824bc58] SUNRPC: change svc_recv() to re=
turn void=2E
--
$ git bisect bad
Bisecting: 19 revisions left to test after this (roughly 4 steps)
[e7421ce71437ec8e4d69cc6bdf35b6853adc5050] NFSD: Rename struct svc_cachere=
p
--
$ git bisect good
Bisecting: 9 revisions left to test after this (roughly 3 steps)
[baabf59c24145612e4a975f459a5024389f13f5d] SUNRPC: Convert svc_udp_sendto(=
) to use the per-socket bio_vec array
--
$ git bisect bad
Bisecting: 4 revisions left to test after this (roughly 2 steps)
[be2be5f7f4436442d8f6bffbb97a6f438df2896b] lockd: nlm_blocked list race fi=
xes
--
$ git bisect good
Bisecting: 2 revisions left to test after this (roughly 1 step)
[d424797032c6e24b44037e6c7a2d32fd958300f0] nfsd: inherit required unset de=
fault acls from effective set
--
$ git bisect good
Bisecting: 0 revisions left to test after this (roughly 1 step)
[e18e157bb5c8c1cd8a9ba25acfdcf4f3035836f4] SUNRPC: Send RPC message on TCP=
 with a single sock_sendmsg() call
--
$ git bisect bad
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[2eb2b93581813b74c7174961126f6ec38eadb5a7] SUNRPC: Convert svc_tcp_sendmsg=
 to use bio_vecs directly
--
$ git bisect good
e18e157bb5c8c1cd8a9ba25acfdcf4f3035836f4 is the first bad commit
commit e18e157bb5c8c1cd8a9ba25acfdcf4f3035836f4

I found the memory loss inside /proc/meminfo only on MemAvailable
 MemTotal:         346948 kB
On a bad test run in looks like this:
-MemAvailable:     210820 kB
+MemAvailable:      26608 kB
On a good test run it looks like this:
-MemAvailable:     215872 kB
+MemAvailable:     221128 kB


> Gesendet: Freitag, den 29=2E03=2E2024 um 01:25 Uhr
> Von: "Chuck Lever III" <chuck=2Elever@oracle=2Ecom>
> An: "Jan Schunk" <scpcom@gmx=2Ede>, "Benjamin Coddington" <bcodding@redh=
at=2Ecom>
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
> > On Mar 28, 2024, at 6:03=E2=80=AFPM, Jan Schunk <scpcom@gmx=2Ede> wrot=
e:
> >=20
> > Inside the VM I was not able to reproduce the issue on v6=2E5=2Ex so I=
 keep concentrating on v6=2E6=2Ex=2E
> >=20
> > Current status:
> >=20
> > $ git bisect start v6=2E6 v6=2E5
> > Bisecting: 7882 revisions left to test after this (roughly 13 steps)
> > [a1c19328a160c80251868dbd80066dce23d07995] Merge tag 'soc-arm-6=2E6' o=
f git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/soc/soc
> >=20
> > --
> > $ git bisect good
> > Bisecting: 3935 revisions left to test after this (roughly 12 steps)
> > [e4f1b8202fb59c56a3de7642d50326923670513f] Merge tag 'for_linus' of gi=
t://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/mst/vhost
> >=20
> > --
> > $ git bisect bad
> > Bisecting: 2014 revisions left to test after this (roughly 11 steps)
> > [e0152e7481c6c63764d6ea8ee41af5cf9dfac5e9] Merge tag 'riscv-for-linus-=
6=2E6-mw1' of git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/riscv/linux
> >=20
> > --
> > $ git bisect bad
> > Bisecting: 975 revisions left to test after this (roughly 10 steps)
> > [4a3b1007eeb26b2bb7ae4d734cc8577463325165] Merge tag 'pinctrl-v6=2E6-1=
' of git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/linusw/linux-pinctrl
> >=20
> > --
> > $ git bisect good
> > Bisecting: 476 revisions left to test after this (roughly 9 steps)
> > [4debf77169ee459c46ec70e13dc503bc25efd7d2] Merge tag 'for-linus-iommuf=
d' of git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/jgg/iommufd
> >=20
> > --
> > $ git bisect good
> > Bisecting: 237 revisions left to test after this (roughly 8 steps)
> > [e7e9423db459423d3dcb367217553ad9ededadc9] Merge tag 'v6=2E6-vfs=2Esup=
er=2Efixes=2E2' of git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/vfs/vf=
s
>=20
> Good, keep going=2E
>=20
> I've tried replicating the free memory loss here, using the
> git regression suite on my nfsd-fixes branch=2E Taking a
> meminfo sample between each of four test runs, the only
> clear downward trend I see is:
>=20
> free:3019839 < start
> free:2858438 < after first run
> free:2836058 < after second run
> free:2822077 < after third run
> free:2797143 < after fourth run
>=20
> All other metrics seem to vary arbitrarily=2E
>=20
> The only slightly suspicious slab I see is buffer_head=2E
> /sys/kernel/debug/kmemleak has a single entry in it, not
> related to NFSD=2E
>=20
> At this point I'm kind of suspecting that the issue will
> not be related to NFSD or SUNRPC or any particular slab
> cache, but will be orphaned whole pages=2E Your bisect
> still seems like the best shot at localizing the
> misbehavior=2E
>=20
>=20
> --
> Chuck Lever
>=20
>

