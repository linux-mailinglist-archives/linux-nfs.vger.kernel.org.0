Return-Path: <linux-nfs+bounces-2479-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7C888CA3A
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Mar 2024 18:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4771F822CE
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Mar 2024 17:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F28D1BC39;
	Tue, 26 Mar 2024 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=scpcom@gmx.de header.b="HNWfmjNE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE821C694;
	Tue, 26 Mar 2024 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472735; cv=none; b=PdbMhRUe7nMIRAGR30yr5c+mS3X7dQZ9JSn5r0luUY7agLOgI7dy3QualJ3FiM6bYwYeQC5DcaLSAdZvVJf1hY42r2wb/RFC0DZ1D7r9qqrWA4cgg3Ms37yZoH1CiNMr7n1mQebwfA6E46b5IVCO1fD8VrgnNnKWMgLC9Sc5SdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472735; c=relaxed/simple;
	bh=3cVHszlpUgtIFKqOc5ghUMzNZLFQmq4uEJS23k+l1jY=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=NlpHXmo6SRNPEdfMgraCJ5LR4OMgbUne1KDiXl+kY9LSldrpitu6k+NFrXDl0hS4ChjA+yPiaPa7St/SJ58E+RZNmRPU55zKLSGanVOxB5NimsikNtb/mTbtKDL9WY5tOY8Z9AQzwspAqELP2gKzEN9V0851fehMbYdUrW4EyQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=scpcom@gmx.de header.b=HNWfmjNE; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711472684; x=1712077484; i=scpcom@gmx.de;
	bh=FDJuIUgeh6X3GJbzePWjCCXAIHEqJ2emAZvka9I1lmQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=HNWfmjNE/xUe+nzudYeTrpJgMtX5i2BnfPlP3dgNIYtuxK/yzKnQiWZsPSE5P4/j
	 9bQ3ipLdbNZ1faxPPYsjleaxWpNjnqcxG42yfL65p/QFGLknsIOzGNzPU8p34N+eO
	 KlMfCGt3bw7pX0ctLE5GsOKK3vN1zOGypzSPKCuxbCELSWMi/D2vv6GHoKJmIeURq
	 Yc5MdzEDNYzIrMQ3n5Q7Vyq2XD1HdS9NBnjmTXb7PK+v+NhMC1ITvqu/ob3zOFdsh
	 voAB3ixhZh3x54EErDWa4emN3W/vT5LU4/qClbiHsQqo8t7814IyqYIjRsRQcs9An
	 wjdTA2cSMH19tn2WRQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.236.203.6] ([10.236.203.6]) by msvc-mesg-gmx123 (via
 HTTP); Tue, 26 Mar 2024 18:04:44 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-0ed602bd-15d4-4110-b3f4-668c2051904a-1711472684521@msvc-mesg-gmx122>
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
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 Mar 2024 18:04:44 +0100
In-Reply-To: <F594EBB2-5F92-40A9-86FB-CFD58E9CE516@redhat.com>
References: <trinity-068f55c9-6088-418d-bf3a-c2778a871e98-1711310237802@msvc-mesg-gmx120>
 <E3109CAA-8261-4F66-9D1B-3546E8B797DF@oracle.com>
 <trinity-bfafb9db-d64f-4cad-8cb1-40dac0a2c600-1711313314331@msvc-mesg-gmx105>
 <567BBF54-D104-432C-99C0-1A7EE7939090@oracle.com>
 <trinity-66047013-4d84-4eef-b5d3-d710fe6be805-1711316386382@msvc-mesg-gmx005>
 <6F16BCCE-3000-4BCB-A3B4-95B4767E3577@oracle.com>
 <trinity-ad0037c0-1060-4541-a8ca-15f826a5b5a2-1711396545958@msvc-mesg-gmx024>
 <088D9CC3-C5B0-4646-A85D-B3B9ACE8C532@oracle.com>
 <F594EBB2-5F92-40A9-86FB-CFD58E9CE516@redhat.com>
X-Priority: 3
X-Provags-ID: V03:K1:evzH4bfiFxj6Gj3tW7ucmQBukt0MHjcXEFVkMpla2Eg20vfxAFF3orFzdZeTqVTwktdBE
 f6XzK8FdDDYNK1Nhubdq8tl7jPW53gJe/IxvPQMs9LUAdR7GxV97657MFO/6jhfyFb1qSvkiRCOr
 tYsYtG1SFiK5rbq85MV8bmx97Ds3g55MBE+SpwXPyQgwv8zMVgQrFFrvwYHOO8mJuiMp03Gdf5dR
 bOGFA0cYQMHG69X/b55I2GWRCtY4XstItdSUobwiLJyedai/d8CYVOyzi6LZN5AbpaYPdWk16Js1
 lY=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WLbq3r+ZK1g=;eSve7IUapAgJsef1cz8tsfGZ73E
 d504y5REeRaVsWcyC5l8SwxSgz2B2HWKI/dPvDDyyeXbRMSBGUeGV6k+62hbx/5QhD+IF3KLc
 oXkirLYb8u5klErrjKYpHcK5/Scw4bKQBtsyeQRyLq7cmL3ooxUf3sZOjS++rVIX3LFuT29Lp
 CCmMtxC1R4yg5n2E8UTVm4LK9sMdt12YkEeNT6JZ1LcS2UD2jNpNzrGgP/OkeZtGylmm8EVhN
 A8aH+AIkpWNFfIwn5N6jrNUuO0fy5aMWkeSeHYIJLfvRmZTeWuDmVVRarCrV4EyLiC7+dMFNt
 pQ9vKoboazEIOSfMjOpw9VedOERukfz+ugR6WGgd4KWBjNmKvEX9ZYokoZSqvvAQBDeiE4GoQ
 Jvs9EciBZCtZQ/QgWHkP9pa5VosKZphnR48/om2kNlmLgf0EqEGAq2WCDuprNOVbf2yIFTlPb
 mzlMbX4vq79HR73rB6rljvCjgbObGcOqexutGQHs2oYQ6HfQ3o9ZMIyDzExtJXnA+VHm28bzT
 HZCcQOIPpjQfoZ0mL76Hn3FDC1s9gboopEA1zI6sdZdO6eEpOHckOiIFX5DYoBrC+1GUA72Xq
 HiFc5be30Op9TJLiHUhqDsbfCIuZSEd6OmtvVroAXrUgVb6EkJJFAkh2z+QzPTF2LAGGhiCUO
 cntp76l29sIoFuIde3aE0sLoP1vV+ABvi4E//nU27joPbpOXkApzKMC55kZD87A=

Before I start doing this on my own build I tried it with unmodified linux-=
image-6=2E6=2E13+bpo-amd64 from Debian 12=2E
I installed systemtap, linux-headers-6=2E6=2E13+bpo-amd64 and linux-image-=
6=2E6=2E13+bpo-amd64-dbg and tried to run stap:

user@deb:~$ sudo stap -v --all-modules kmem_alloc=2Estp nfsd_file
WARNING: Kernel function symbol table missing [man warning::symbols]
Pass 1: parsed user script and 484 library scripts using 110120virt/96896r=
es/7168shr/89800data kb, in 1360usr/1080sys/4963real ms=2E
WARNING: cannot find module kernel debuginfo: No DWARF information found [=
man warning::debuginfo]
semantic error: resolution failed in DWARF builder

semantic error: while resolving probe point: identifier 'kernel' at kmem_a=
lloc=2Estp:5:7
        source: probe kernel=2Efunction("kmem_cache_alloc") {
                      ^

semantic error: no match

Pass 2: analyzed script: 1 probe, 5 functions, 1 embed, 3 globals using 11=
2132virt/100352res/8704shr/91792data kb, in 30usr/30sys/167real ms=2E
Pass 2: analysis failed=2E  [man error::pass2]
Tip: /usr/share/doc/systemtap/README=2EDebian should help you get started=
=2E
user@deb:~$=20

user@deb:~$ grep -E 'CONFIG_DEBUG_INFO|CONFIG_KPROBES|CONFIG_DEBUG_FS|CONF=
IG_RELAY' /boot/config-6=2E6=2E13+bpo-amd64=20
CONFIG_RELAY=3Dy
CONFIG_KPROBES=3Dy
CONFIG_KPROBES_ON_FTRACE=3Dy
CONFIG_DEBUG_INFO=3Dy
# CONFIG_DEBUG_INFO_NONE is not set
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=3Dy
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
# CONFIG_DEBUG_INFO_REDUCED is not set
CONFIG_DEBUG_INFO_COMPRESSED_NONE=3Dy
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_BTF=3Dy
CONFIG_DEBUG_INFO_BTF_MODULES=3Dy
CONFIG_DEBUG_FS=3Dy
CONFIG_DEBUG_FS_ALLOW_ALL=3Dy
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
user@deb:~$=20

Do I need to enable other options?


> Gesendet: Dienstag, den 26=2E03=2E2024 um 12:15 Uhr
> Von: "Benjamin Coddington" <bcodding@redhat=2Ecom>
> An: "Chuck Lever III" <chuck=2Elever@oracle=2Ecom>
> Cc: "Jan Schunk" <scpcom@gmx=2Ede>, "Jeff Layton" <jlayton@kernel=2Eorg>=
, "Neil Brown" <neilb@suse=2Ede>, "Olga Kornievskaia" <kolga@netapp=2Ecom>,=
 "Dai Ngo" <dai=2Engo@oracle=2Ecom>, "Tom Talpey" <tom@talpey=2Ecom>, "Linu=
x NFS Mailing List" <linux-nfs@vger=2Ekernel=2Eorg>, linux-kernel@vger=2Eke=
rnel=2Eorg
> Betreff: Re: [External] : nfsd: memory leak when client does many file o=
perations
>=20
> On 25 Mar 2024, at 16:11, Chuck Lever III wrote:
>=20
> >> On Mar 25, 2024, at 3:55=E2=80=AFPM, Jan Schunk <scpcom@gmx=2Ede> wro=
te:
> >>
> >> The VM is now running 20 hours with 512MB RAM, no desktop, without th=
e "noatime" mount option and without the "async" export option=2E
> >>
> >> Currently there is no issue, but the memory usage is still contantly =
growing=2E It may just take longer before something happens=2E
> >>
> >> top - 00:49:49 up 3 min,  1 user,  load average: 0,21, 0,19, 0,09
> >> Tasks: 111 total,   1 running, 110 sleeping,   0 stopped,   0 zombie
> >> %CPU(s):  0,2 us,  0,3 sy,  0,0 ni, 99,5 id,  0,0 wa,  0,0 hi,  0,0 s=
i,  0,0 st
> >> MiB Spch:    467,0 total,    302,3 free,     89,3 used,     88,1 buff=
/cache
> >> MiB Swap:    975,0 total,    975,0 free,      0,0 used=2E    377,7 av=
ail Spch
> >>
> >> top - 15:05:39 up 14:19,  1 user,  load average: 1,87, 1,72, 1,65
> >> Tasks: 104 total,   1 running, 103 sleeping,   0 stopped,   0 zombie
> >> %CPU(s):  0,2 us,  4,9 sy,  0,0 ni, 53,3 id, 39,0 wa,  0,0 hi,  2,6 s=
i,  0,0 st
> >> MiB Spch:    467,0 total,     21,2 free,    147,1 used,    310,9 buff=
/cache
> >> MiB Swap:    975,0 total,    952,9 free,     22,1 used=2E    319,9 av=
ail Spch
> >>
> >> top - 20:48:16 up 20:01,  1 user,  load average: 5,02, 2,72, 2,08
> >> Tasks: 104 total,   5 running,  99 sleeping,   0 stopped,   0 zombie
> >> %CPU(s):  0,2 us, 46,4 sy,  0,0 ni, 11,9 id,  2,3 wa,  0,0 hi, 39,2 s=
i,  0,0 st
> >> MiB Spch:    467,0 total,     16,9 free,    190,8 used,    271,6 buff=
/cache
> >> MiB Swap:    975,0 total,    952,9 free,     22,1 used=2E    276,2 av=
ail Spch
> >
> > I don't see anything in your original memory dump that
> > might account for this=2E But I'm at a loss because I'm
> > a kernel developer, not a support guy -- I don't have
> > any tools or expertise that can troubleshoot a system
> > without rebuilding a kernel with instrumentation=2E My
> > first instinct is to tell you to bisect between v6=2E3
> > and v6=2E4, or at least enable kmemleak, but I'm guessing
> > you don't build your own kernels=2E
> >
> > My only recourse at this point would be to try to
> > reproduce it myself, but unfortunately I've just
> > upgraded my whole lab to Fedora 39, and there's a grub
> > bug that prevents booting any custom-built kernel
> > on my hardware=2E
> >
> > So I'm stuck until I can nail that down=2E Anyone else
> > care to help out?
>=20
> Sure - I can throw some stuff=2E=2E
>=20
> Can we dig into which memory slabs might be growing?  Something like:
>=20
> watch -d "cat /proc/slabinfo | grep nfsd"
>=20
> =2E=2E for a bit might show what is growing=2E
>=20
> Then use a systemtap script like the one below to trace the allocations =
- use:
>=20
> stap -v --all-modules kmem_alloc=2Estp <slab_name>
>=20
> Ben
>=20
>=20
> 8<---------------------------- save as kmem_alloc=2Estp ----------------=
------------
>=20
> # This script displays the number of given slab allocations and the back=
traces leading up to it=2E
>=20
> global slab =3D @1
> global stats, stacks
> probe kernel=2Efunction("kmem_cache_alloc") {
>         if (kernel_string($s->name) =3D=3D slab) {
>                 stats[execname()] <<< 1
>                 stacks[execname(),kernel_string($s->name),backtrace()] <=
<< 1
>         }
> }
> # Exit after 10 seconds
> # probe timer=2Ems(10000) { exit () }
> probe end {
>         printf("Number of %s slab allocations by process\n", slab)
>         foreach ([exec] in stats) {
>                 printf("%s:\t%d\n",exec,@count(stats[exec]))
>         }
>         printf("\nBacktrace of processes when allocating\n")
>         foreach ([proc,cache,bt] in stacks) {
>                 printf("Exec: %s Name: %s  Count: %d\n",proc,cache,@coun=
t(stacks[proc,cache,bt]))
>                 print_stack(bt)
>                 printf("\n----------------------------------------------=
---------\n\n")
>         }
> }
>

