Return-Path: <linux-nfs+bounces-2485-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B1388CCB4
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Mar 2024 20:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 891E6B278DF
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Mar 2024 19:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E0C13D247;
	Tue, 26 Mar 2024 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=scpcom@gmx.de header.b="Im8sCB1m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A8A13D243;
	Tue, 26 Mar 2024 19:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479978; cv=none; b=DZQn11zaoPBGBU8SktCVRaA1fgnoSMnVw5ON8AaqWcTyGmMbew0yVeB/LC8/3MUXpY4EQkpaC7fzbiUUSHOHKC1Q+U3zMqa7Mg9B+r2ZTEyQ4jSvXACRUH1refBCtnfKe2X03ZxnILyxH+uUO46tUG09Brg/RUpzYtCjANbHWSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479978; c=relaxed/simple;
	bh=+NAgK4z4jmuKEFo4vsb4/qvgOB9pUCvvZOKOKaEfHME=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=cvlTB95Q9yXNvOka+O3lo3qoKfG3e1GaQvhp6FsAM2ljWSxd1O+V4O2+48zuDUDVGkaUXZNL3n7gYu8Ob1GXVdDJXlu5g0ku9keKcXuQPSSj9hU0RPtzlpFXizXyZtf2zyyKPfblEm8G3rUNQP2k4nHmuYYXeiQAEgD557SjXsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=scpcom@gmx.de header.b=Im8sCB1m; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711479957; x=1712084757; i=scpcom@gmx.de;
	bh=oSnZmj7Q+gRraBTfdrAlE3Q3+lzCwguURWUGPhBB2bo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=Im8sCB1m00AlBwPsH2raREXmwDjyNvXcrmkIORMY/02FQJKFAGNwSIpQ0sOvkhtz
	 uMndg6SU7BrwJnm9bKxN6lddisSm5VbtxNP+yQBbQgsekcnlc+7AUD/HYHyTUCp0W
	 ZuV3OlaBARaQSL+ChjDwkV7+kVF+1FbvoDiC9G0c4peg1GW7qJPz1upaiIpGYX8ih
	 e78JoPZdZwUw7N7ydGkZ4yK1bvilNC7GyxdfEFOD1GL8x7KA6+nilkw2IkvGkFx4j
	 mx/7E6tfTwmGOXxgQ67g9UiSmMG+c5C4lYnwPaiP6At/gxBSLlqaXggepLObCnwx6
	 BCHlF/gGH5WVR4E6Cw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.236.10.8] ([10.236.10.8]) by msvc-mesg-gmx022 (via HTTP);
 Tue, 26 Mar 2024 20:05:57 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-3689502e-ee11-4925-b55c-a00dcb20f31d-1711479956926@msvc-mesg-gmx022>
From: Jan Schunk <scpcom@gmx.de>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Chuck Lever III <chuck.lever@oracle.com>, Jeff Layton
 <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, Olga Kornievskaia
 <kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Aw: Re: [External] : nfsd: memory leak when client does many file
 operations
Content-Type: text/plain; charset=UTF-8
Importance: normal
Sensitivity: Normal
Date: Tue, 26 Mar 2024 20:05:57 +0100
In-Reply-To: <13E7E8AF-46DF-45BF-96BB-0C820B9FA23A@redhat.com>
References: <trinity-068f55c9-6088-418d-bf3a-c2778a871e98-1711310237802@msvc-mesg-gmx120>
 <E3109CAA-8261-4F66-9D1B-3546E8B797DF@oracle.com>
 <trinity-bfafb9db-d64f-4cad-8cb1-40dac0a2c600-1711313314331@msvc-mesg-gmx105>
 <567BBF54-D104-432C-99C0-1A7EE7939090@oracle.com>
 <trinity-66047013-4d84-4eef-b5d3-d710fe6be805-1711316386382@msvc-mesg-gmx005>
 <6F16BCCE-3000-4BCB-A3B4-95B4767E3577@oracle.com>
 <trinity-ad0037c0-1060-4541-a8ca-15f826a5b5a2-1711396545958@msvc-mesg-gmx024>
 <088D9CC3-C5B0-4646-A85D-B3B9ACE8C532@oracle.com>
 <F594EBB2-5F92-40A9-86FB-CFD58E9CE516@redhat.com>
 <trinity-0ed602bd-15d4-4110-b3f4-668c2051904a-1711472684521@msvc-mesg-gmx122>
 <1AE35F72-77CF-4F5A-9B65-72AB6A53A621@redhat.com>
 <13E7E8AF-46DF-45BF-96BB-0C820B9FA23A@redhat.com>
X-Priority: 3
X-Provags-ID: V03:K1:+aHIbI+SoGgY9iLG6LHmnuBn58hbhsNZeYmvjj01uYjfG6uVpoGPKUd1X2xWMke3hD7eA
 gGzUUeE2IE3G6mdaTe1C20WaQAFU5Avgm4Y1VGN3vrQ+a1ejEvh7carQmPqOsRD0jtSDrRdOriSK
 HY5xkwI0AjrCuLz/a+BuUztd2p1UEJHaYSdsYMEink4e5Ul8uQkL8UYvR3jlC0u63qmYuKoKfvGH
 WCc80othkGNFflKP3uY/5kg4P+3GR5Um68RxrBpa0likKcGERWFR9oi9ATnhhY6+NJrTX1c9gbEI
 bs=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bHFm+E1X3Vw=;HU0Tgxz8/mLgxXp2CVe1zdLeGES
 RXblag9zlQwwA/KQqCnG80ekKkNLPifU31RvOaqG8oZSXSkrj5n3lEFIkALBOAco+nYHg9/WC
 /bp4/qWkeWEWA4yuM+2JhNyuTry+LtaPSUdD439L8u7PLcZ8LMN7R9jlej8VywvIZHmGkO3b1
 kReP08lJnju6CJnTnrBC2INhXVk0dHWpDAutMeIwL7/YQjpiVK8WbRA5k2VbdWxgMV6EVGlNL
 E0V2hHRbyG0MeaSbNKgEZobQIGeILO+bkAtgJc8gzp7DJFBs3V73DKIBqY29le/7dl7JgMR/Y
 yIhz47YeSfG/rAYHaSJaRYfUCIw/FVSJ0BOTcY9vpxksTOMLlsoVxIvSVSeaeQVA3KAvRO2T2
 IYf5bIR3kmlzgtLlvbTpq4gawVoTaljqmtSV6Lx67qZ19wH96jpWecKm2fqdBjqoUTST0biA8
 Qh9hOUlWcB1+Ii5OiZSJCWC+0JuhEcH2IsVauIYaWUX/bkZt7kOAPXPn9UMIkBD2F5xhUeyCr
 8H2dRpkA9sFF/WjcP5WY8VQy65YEHsYtltNyBlfdZhz/1PAQqmQ+/j+U3TXw+CtvKewL/EoTC
 T2sPetr8TDcniCxE69J0hOQlQPQfkG1Flw7kVTpTVaF434yr7PTFTE/Q1YLk9ckJWNBa68LDj
 geBWc9946qqQds7+/rsGSz7nBA7h/HkRzKpFQUKGMQbhr6yUhJS74DRSe1vyb9s=
Content-Transfer-Encoding: quoted-printable

Thanks, yes this was a packaged kernel, I will try it with my own build la=
ter.

On an earlier test run I saved slabinfo to a file sometimes. On Kernel 6.6=
.x I can see nfsd_file <active_objs> and <num_objs> is growing from 72 to =
324 within 14 hours. But I can not compare it to older kernels since there=
 is no nfsd_file in the list.

top - 00:49:49 up 3 min,  1 user,  load average: 0,21, 0,19, 0,09
Tasks: 111 total,   1 running, 110 sleeping,   0 stopped,   0 zombie
%CPU(s):  0,2 us,  0,3 sy,  0,0 ni, 99,5 id,  0,0 wa,  0,0 hi,  0,0 si,  0=
,0 st
MiB Spch:    467,0 total,    302,3 free,     89,3 used,     88,1 buff/cach=
e
MiB Swap:    975,0 total,    975,0 free,      0,0 used.    377,7 avail Spc=
h

slabinfo
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagespe=
rslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_s=
labs> <num_slabs> <sharedavail>
nfsd_file             72     72    112   36    1 : tunables    0    0    0=
 : slabdata      2      2      0

top - 15:05:39 up 14:19,  1 user,  load average: 1,87, 1,72, 1,65
Tasks: 104 total,   1 running, 103 sleeping,   0 stopped,   0 zombie
%CPU(s):  0,2 us,  4,9 sy,  0,0 ni, 53,3 id, 39,0 wa,  0,0 hi,  2,6 si,  0=
,0 st
MiB Spch:    467,0 total,     21,2 free,    147,1 used,    310,9 buff/cach=
e
MiB Swap:    975,0 total,    952,9 free,     22,1 used.    319,9 avail Spc=
h

slabinfo
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagespe=
rslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_s=
labs> <num_slabs> <sharedavail>
nfsd_file            324    324    112   36    1 : tunables    0    0    0=
 : slabdata      9      9      0


> Gesendet: Dienstag, den 26.03.2024 um 18:15 Uhr
> Von: "Benjamin Coddington" <bcodding@redhat.com>
> An: "Jan Schunk" <scpcom@gmx.de>
> Cc: "Chuck Lever III" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@k=
ernel.org>, "Neil Brown" <neilb@suse.de>, "Olga Kornievskaia" <kolga@netap=
p.com>, "Dai Ngo" <dai.ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>, "Li=
nux NFS Mailing List" <linux-nfs@vger.kernel.org>, linux-kernel@vger.kerne=
l.org
> Betreff: Re: [External] : nfsd: memory leak when client does many file o=
perations
>
> On 26 Mar 2024, at 13:13, Benjamin Coddington wrote:
>
> > On 26 Mar 2024, at 13:04, Jan Schunk wrote:
> >
> >> Before I start doing this on my own build I tried it with unmodified =
linux-image-6.6.13+bpo-amd64 from Debian 12.
> >> I installed systemtap, linux-headers-6.6.13+bpo-amd64 and linux-image=
-6.6.13+bpo-amd64-dbg and tried to run stap:
> >>
> >> user@deb:~$ sudo stap -v --all-modules kmem_alloc.stp nfsd_file
> >> WARNING: Kernel function symbol table missing [man warning::symbols]
> >> Pass 1: parsed user script and 484 library scripts using 110120virt/9=
6896res/7168shr/89800data kb, in 1360usr/1080sys/4963real ms.
> >> WARNING: cannot find module kernel debuginfo: No DWARF information fo=
und [man warning::debuginfo]
> >> semantic error: resolution failed in DWARF builder
> >>
> >> semantic error: while resolving probe point: identifier 'kernel' at k=
mem_alloc.stp:5:7
> >>         source: probe kernel.function("kmem_cache_alloc") {
> >>                       ^
> >>
> >> semantic error: no match
> >>
> >> Pass 2: analyzed script: 1 probe, 5 functions, 1 embed, 3 globals usi=
ng 112132virt/100352res/8704shr/91792data kb, in 30usr/30sys/167real ms.
> >> Pass 2: analysis failed.  [man error::pass2]
> >> Tip: /usr/share/doc/systemtap/README.Debian should help you get start=
ed.
> >> user@deb:~$
> >>
> >> user@deb:~$ grep -E 'CONFIG_DEBUG_INFO|CONFIG_KPROBES|CONFIG_DEBUG_FS=
|CONFIG_RELAY' /boot/config-6.6.13+bpo-amd64
> >> CONFIG_RELAY=3Dy
> >> CONFIG_KPROBES=3Dy
> >> CONFIG_KPROBES_ON_FTRACE=3Dy
> >> CONFIG_DEBUG_INFO=3Dy
> >> # CONFIG_DEBUG_INFO_NONE is not set
> >> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=3Dy
> >> # CONFIG_DEBUG_INFO_DWARF4 is not set
> >> # CONFIG_DEBUG_INFO_DWARF5 is not set
> >> # CONFIG_DEBUG_INFO_REDUCED is not set
> >> CONFIG_DEBUG_INFO_COMPRESSED_NONE=3Dy
> >> # CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
> >> # CONFIG_DEBUG_INFO_SPLIT is not set
> >> CONFIG_DEBUG_INFO_BTF=3Dy
> >> CONFIG_DEBUG_INFO_BTF_MODULES=3Dy
> >> CONFIG_DEBUG_FS=3Dy
> >> CONFIG_DEBUG_FS_ALLOW_ALL=3Dy
> >> # CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
> >> # CONFIG_DEBUG_FS_ALLOW_NONE is not set
> >> user@deb:~$
> >>
> >> Do I need to enable other options?
> >
> > You should just need DEBUG_INFO.. maybe stap can't find it?  You can t=
ry to add: -r /path/to/the/kernel/build
>
> oh, nevermind - you're using a packaged kernel.  I'm no familiar with th=
e packaged requirements for systemtap on debian.
>
> Ben
>

