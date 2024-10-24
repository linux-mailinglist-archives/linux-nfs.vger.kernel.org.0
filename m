Return-Path: <linux-nfs+bounces-7414-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4EA9ADB58
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 07:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5B31C20A82
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 05:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CFD16EBE8;
	Thu, 24 Oct 2024 05:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b="S0y5oSXT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bisque.elm.relay.mailchannels.net (bisque.elm.relay.mailchannels.net [23.83.212.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BF612CD96
	for <linux-nfs@vger.kernel.org>; Thu, 24 Oct 2024 05:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729747110; cv=pass; b=ZOlvfV9MOrgaw9ZJ5uJNwg5ph8W0RXruN24hubuWgbHvG9eFCNTk3QK/0An3t8El3urNe5hO5MttVPz7KEO9bjPehe8fsYYvsbLTSrZq+zLAhwR0t+ii5kE9JpwE3pPENerp6ZkRHTpaWOjqFf14+ernmj5b50R7r9I5OUgnGt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729747110; c=relaxed/simple;
	bh=eSQgi+XKpRHYqlo0b5Qj6eYaYaCWOZNRJ3++qBbsEQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=GqL+/qoF7Kbonwhro/gut+NDln/gJXPLQTZfwJK+VuaakOho/gMntgnZ1eZiOGyoqTyKEEzxkKfWIZYwQOe8gdUZ1WANu0Fe8BqMyABVlpA9j3feCC/aF8N8NBpyK+npLHuXz27bicd7Ts6fqm9KFIkrflwj4DXhqsJyem2ZlUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org; spf=pass smtp.mailfrom=nrubsig.org; dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b=S0y5oSXT; arc=pass smtp.client-ip=23.83.212.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2360516249A
	for <linux-nfs@vger.kernel.org>; Thu, 24 Oct 2024 05:18:26 +0000 (UTC)
Received: from pdx1-sub0-mail-a247.dreamhost.com (trex-5.trex.outbound.svc.cluster.local [100.103.26.202])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C45F316306E
	for <linux-nfs@vger.kernel.org>; Thu, 24 Oct 2024 05:18:25 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1729747105; a=rsa-sha256;
	cv=none;
	b=4Dx4ewm+3VRgg7L3wxeOtUNuuMti1WiufGlT5rbP0BxLKb24MNvI5ewm1PFHSx0ynjr23d
	1pNKfMkeW4f2CDvP6wbkBIZg5J2kao2+fIjwWmZTIqiksBksJx5osRn4UwLeHTuNJyyhjV
	mfKtD12iHKW/JmXCxVKoEY7VroJ9Fr+Yj+PbdKkU4I+vp2L/lV7VdDqWXnlTv/atb3PvIq
	AGUOyR6pRRvEEwM/o6e0f4aHxbrJjxEXCHRvLXOwjRv87TWDQ5l01d9WKzZkuyBj7qyxxn
	BS8BoZgEl0RxMHE8fJANbR6ak7ksgNXtA3Njp4dfsQ1lq6C2X3pEV7PrWgrBdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1729747105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=sRppImK9v3ypkK6+DBUV3grIhpZhePAhfiTiZPQKfUU=;
	b=D/Mq/zdRBayMgwQn0bedz9fBNB/2voWLQuIeexRAiJnO65LZRZHW1PpNATGVJi3VJG0ATe
	071lljWxtmVq4lMAP8jqiMkYWdfegZ3P9xGsTz33LWsy+xMPLIuMofqy+BMjvaq2RKZmme
	oGA6ZOyzYkp4zOxB8YdMUf7ixMBh7nKklG7Ox68KBeNoaG6P18XzI5wRJr1gLbNsDN8gHm
	wrW5oYrOpfQflBNx8PZHkfmiVquB6QIvguV1QNy7X5F29YLDKOYLAJREHJQ0C9Z4bslTVY
	Eonph9Y69FGJ2wJInGiad5aGy18QDeLXJX0MttXwpNI6e0tXF+dqPj2ntbLtdA==
ARC-Authentication-Results: i=1;
	rspamd-9bc7b7997-f22dl;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=roland.mainz@nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|gisburn@nrubsig.org
X-MailChannels-Auth-Id: dreamhost
X-Slimy-Bubble: 014c81f05941cae6_1729747106017_48889264
X-MC-Loop-Signature: 1729747106017:2854735320
X-MC-Ingress-Time: 1729747106016
Received: from pdx1-sub0-mail-a247.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.26.202 (trex/7.0.2);
	Thu, 24 Oct 2024 05:18:26 +0000
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: gisburn@nrubsig.org)
	by pdx1-sub0-mail-a247.dreamhost.com (Postfix) with ESMTPSA id 4XYvMP4b3dz5F
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 22:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nrubsig.org;
	s=dreamhost; t=1729747105;
	bh=sRppImK9v3ypkK6+DBUV3grIhpZhePAhfiTiZPQKfUU=;
	h=From:Date:Subject:To:Content-Type:Content-Transfer-Encoding;
	b=S0y5oSXTafb7h+j2c54J80bRYQHKbACXp+ezQLYbSJGSoGBSvj4+pXZCCewnOi6Zr
	 rHKQaD34A0DrD7AnEyfbrRoOirfeASrDf3VIVmaxdNOe4dgjgzML/CI48dz/SqAwZb
	 JcSNr7u7ZHFJ8VOAJ3CPoHLvVCjdyAnFmnV1DS05x9Q0qSUDuAoX1QNalD0Tr6bIhZ
	 ub2ucmaPzkQQhGIRS0stXopIfM37/tph8yz15S3/pYxHf3UpB4KXQASt9rgWv6guL5
	 51SeZ/m0VSUHFKUSbrsU1/picpe0WlEDNCF/ZS8Tw+euHiRcsA7JCq8PaxL4tsfQsP
	 JfNPPRXO6uPog==
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d808ae924so307524f8f.0
        for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 22:18:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUboUi5/Y3F5rabpJ1Sgb7BvWnUbq50+UhqABLfhwW836weObLXpNFzyHbZtKU8rsxWBjXfOOMxtnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW/xYcYmKX7c8g4M7hdI2sLaPm5VjPA53vYzKwrt7A4YaCvrA8
	idBGO3UX/rKlkXAZV9Cl/a1UivMc/4srD3tpjVkjl+khCcL8vbHKdj9NSE39LHXr4hZSMy4P/f8
	7hJ8NV5ybWNv/fhQihJttdZfUHBM=
X-Google-Smtp-Source: AGHT+IG4aMEWtVzNg59jkmqso9MY8O8ac4byZs/wpU3TNwI57Ko6/qS9zLlkvd+2t1/3Xm+/6/cGBlcf5ndEJ7O7D6c=
X-Received: by 2002:a05:6000:cd:b0:37d:43ad:14eb with SMTP id
 ffacd0b85a97d-3803ac969f1mr488821f8f.14.1729747104550; Wed, 23 Oct 2024
 22:18:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0Uf52aif8LyKw8Y0tsi6XYm0pEByvjrtCHdZ=Us2fw5nWA@mail.gmail.com>
In-Reply-To: <CALXu0Uf52aif8LyKw8Y0tsi6XYm0pEByvjrtCHdZ=Us2fw5nWA@mail.gmail.com>
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Thu, 24 Oct 2024 07:18:00 +0200
X-Gmail-Original-Message-ID: <CAKAoaQmueONrbr9Mv11PUz4u3t8LbsY=7oSz8O+nMziUD_5nHA@mail.gmail.com>
Message-ID: <CAKAoaQmueONrbr9Mv11PUz4u3t8LbsY=7oSz8O+nMziUD_5nHA@mail.gmail.com>
Subject: Re: NFS referral from Linux nfsd crashes Win10/32bit NFS client but
 not 64bit
To: ms-nfs41-client-devel@lists.sourceforge.net, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 8:25=E2=80=AFAM Cedric Blancher
<cedric.blancher@gmail.com> wrote:
>
> Good morning!
>
> msnfs41client on Windows 10/32bit crashes if I have a NFS referral
> from a Linux 6.1 or 6.6 kernel. Windows 10/64bit msnfs41client does
> not crash.
>
> But if I change to a Linux 5.10.0-22 (Debian 11) NFS server the
> problem goes away, so this might be a NFS server bug.
>
> nfsd_debug.exe output:
> 0fac: DEBUG: wintirpc_socket:
> C:\cygwin64\home\roland_mainz\work\msnfs41_uidmapping\ms-nfs41-client\lib=
tirpc\src\wintirpc.c/246:
> sock fd=3D4
> wintirpc_setnfsclientsockopts(sock=3D4): SO_RCVBUF=3D65536
> wintirpc_setnfsclientsockopts(sock=3D4): SO_SNDBUF=3D65536
> wintirpc_setnfsclientsockopts(sock=3D4): set SO_RCVBUF to 8388608
> wintirpc_setnfsclientsockopts(sock=3D4): set SO_SNDBUF to 8388608
> 0fac: started the callback thread 1828
> 1828: cb: Callback thread running
> #### FATAL: exception in
> thr=3D0fac'C:\cygwin64\home\roland_mainz\work\msnfs41_uidmapping\ms-nfs41=
-client\libtirpc\src\clnt_vc.c'/764
> ####
>
> * Versions:
> - NFS server:
> Debian Linux trixie, stock 6.1 trixie kernel, tested with 6.6LTS kernel
> - NFS client:
> msnfs41client 20240923_11h26m_gitf3955ec release
> Win10/32bit
> Cygwin 3.3/32bit

I can reproduce this with Linux 6.6.53-rt44 and ms-nfs41-client HEAD
on Win 10/32bit, it crashes because of a |free((void*)0x00000001)|.

Stack trace:
---- snip ----
0:027> kp
 # ChildEBP RetAddr
00 02d73cb4 55984492     ucrtbased!check_bytes(unsigned char * first =3D
0xfffffffc "--- memory read error at address 0xfffffffc ---", unsigned
char value =3D 0xed '', unsigned int size =3D 4)+0x2d
[d:\th\minkernel\crts\ucrt\src\appcrt\heap\debug_heap.cpp @ 194]
01 02d73ccc 55983a81     ucrtbased!is_block_an_aligned_allocation(void
* block =3D 0x00000001)+0x22
[d:\th\minkernel\crts\ucrt\src\appcrt\heap\debug_heap.cpp @ 251]
02 02d73ce4 559866ec     ucrtbased!free_dbg_nolock(void * block =3D
0x00000001, int block_use =3D 0n1)+0x31
[d:\th\minkernel\crts\ucrt\src\appcrt\heap\debug_heap.cpp @ 870]
03 02d73d24 6381e969     ucrtbased!_free_dbg(void * block =3D
0x00000001, int block_use =3D 0n1)+0x7c
[d:\th\minkernel\crts\ucrt\src\appcrt\heap\debug_heap.cpp @ 1011]
04 02d73d94 63816f1f     libtirpc!xdr_bytes(struct __rpc_xdr * xdrs =3D
0x0de01a60, char ** cpp =3D 0x0de01a88, unsigned int * sizep =3D
0x0de01a8c, unsigned int maxsize =3D 0x190)+0x129
[C:\cygwin64\home\roland_mainz\work\msnfs41_uidmapping\ms-nfs41-client\libt=
irpc\src\xdr.c
@ 606]
05 02d73df8 6380ce19     libtirpc!xdr_opaque_auth(struct __rpc_xdr *
xdrs =3D 0x0de01a60, struct opaque_auth * ap =3D 0x0de01a84)+0x6f
[C:\cygwin64\home\roland_mainz\work\msnfs41_uidmapping\ms-nfs41-client\libt=
irpc\src\rpc_prot.c
@ 91]
06 02d73ea8 00336cf3     libtirpc!clnt_vc_call(struct __rpc_client *
cl =3D 0x008ee420, unsigned int proc =3D 1, <function> * xdr_args =3D
0x0030ab9f, void * args_ptr =3D 0x02d740e0, <function> * xdr_results =3D
0x0030a212, void * results_ptr =3D 0x02d744f0, struct timeval timeout =3D
struct timeval)+0x859
[C:\cygwin64\home\roland_mainz\work\msnfs41_uidmapping\ms-nfs41-client\libt=
irpc\src\clnt_vc.c
@ 752]
07 02d73f40 0033230c     nfsd!nfs41_send_compound(struct
__nfs41_rpc_clnt * rpc =3D 0x0081d138, char * inbuf =3D 0x02d740e0 "???",
char * outbuf =3D 0x02d744f0 "")+0x73
[C:\cygwin64\home\roland_mainz\work\msnfs41_uidmapping\ms-nfs41-client\daem=
on\nfs41_rpc.c
@ 351]
08 02d74904 00323d8f     nfsd!nfs41_exchange_id(struct
__nfs41_rpc_clnt * rpc =3D 0x0081d138, struct __client_owner4 * owner =3D
0x0083e520, unsigned int flags_in =3D 0x30001, struct
__nfs41_exchange_id_res * res_out =3D 0x02d74a88)+0x12c
[C:\cygwin64\home\roland_mainz\work\msnfs41_uidmapping\ms-nfs41-client\daem=
on\nfs41_ops.c
@ 91]
09 02d752c0 00324291     nfsd!nfs41_root_mount_addrs(struct
__nfs41_root * root =3D 0x0083e520, struct __multi_addr4 * addrs =3D
0x02d75338, int is_data =3D 0n0, unsigned int lease_time =3D 0, struct
__nfs41_client ** client_out =3D 0x02d756c4)+0x12f
[C:\cygwin64\home\roland_mainz\work\msnfs41_uidmapping\ms-nfs41-client\daem=
on\namespace.c
@ 372]
0a 02d75434 0032410e     nfsd!referral_mount_location(struct
__nfs41_root * root =3D 0x0083e520, struct __fs_location4 * loc =3D
0x00827288, struct __nfs41_client ** client_out =3D 0x02d756c4)+0xc1
[C:\cygwin64\home\roland_mainz\work\msnfs41_uidmapping\ms-nfs41-client\daem=
on\namespace.c
@ 460]
0b 02d7549c 00321fcd     nfsd!nfs41_root_mount_referral(struct
__nfs41_root * root =3D 0x0083e520, struct __fs_locations4 * locations =3D
0x02d756cc, struct __fs_location4 ** loc_out =3D 0x02d756c8, struct
__nfs41_client ** client_out =3D 0x02d756c4)+0x4e
[C:\cygwin64\home\roland_mainz\work\msnfs41_uidmapping\ms-nfs41-client\daem=
on\namespace.c
@ 481]
0c 02d776dc 00321cd5     nfsd!referral_resolve(struct __nfs41_root *
root =3D 0x0083e520, struct __nfs41_session * session_in =3D 0x0083a928,
struct lookup_referral * referral =3D 0x02d77918, struct
__nfs41_abs_path * path_out =3D 0x02d78d6c, struct __nfs41_session **
session_out =3D 0x02d77908)+0xad
[C:\cygwin64\home\roland_mainz\work\msnfs41_uidmapping\ms-nfs41-client\daem=
on\lookup.c
@ 431]
0d 02d78b30 0034eb7d     nfsd!nfs41_lookup(struct __nfs41_root * root
=3D 0x0083e520, struct __nfs41_session * session =3D 0x0083a928, struct
__nfs41_abs_path * path_inout =3D 0x02d78d6c, struct __nfs41_path_fh *
parent_out =3D 0x02d77a7c, struct __nfs41_path_fh * target_out =3D
0x02d779d4, struct __nfs41_file_info * info_out =3D 0x09434392, struct
__nfs41_session ** session_out =3D 0x00000000)+0x205
[C:\cygwin64\home\roland_mainz\work\msnfs41_uidmapping\ms-nfs41-client\daem=
on\lookup.c
@ 520]
0e 02d79d74 0034f5fc     nfsd!lookup_entry(struct __nfs41_root * root
=3D 0x0083e520, struct __nfs41_session * session =3D 0x0083a928, struct
__nfs41_path_fh * parent =3D 0x0da06608, struct __nfs41_readdir_entry *
entry =3D 0x09434382)+0x7d
[C:\cygwin64\home\roland_mainz\work\msnfs41_uidmapping\ms-nfs41-client\daem=
on\readdir.c
@ 468]
0f 02d7a6f8 0034e2c1     nfsd!readdir_copy_entry(struct
__readdir_upcall_args * args =3D 0x02d7aa98, struct
__nfs41_readdir_entry * entry =3D 0x09434382, unsigned char ** dst_pos =3D
0x02d7a78c, unsigned int * dst_len =3D 0x02d7a788)+0x11c
[C:\cygwin64\home\roland_mainz\work\msnfs41_uidmapping\ms-nfs41-client\daem=
on\readdir.c
@ 534]
10 02d7a7f0 00357a95     nfsd!handle_readdir(void * deamon_context =3D
0x00375008, struct __nfs41_upcall * upcall =3D 0x02d7aa80)+0x621
[C:\cygwin64\home\roland_mainz\work\msnfs41_uidmapping\ms-nfs41-client\daem=
on\readdir.c
@ 800]
11 02d7a854 0032f744     nfsd!upcall_handle(void * daemon_context =3D
0x00375008, struct __nfs41_upcall * upcall =3D 0x02d7aa80)+0x65
[C:\cygwin64\home\roland_mainz\work\msnfs41_uidmapping\ms-nfs41-client\daem=
on\upcall.c
@ 220]
12 02d7fb4c 0032f4dd     nfsd!nfsd_worker_thread_main(void * args =3D
0x00375008)+0x204
[C:\cygwin64\home\roland_mainz\work\msnfs41_uidmapping\ms-nfs41-client\daem=
on\nfs41_daemon.c
@ 201]
13 02d7fbc0 559a8968     nfsd!nfsd_thread_main(void * args =3D
0x00375008)+0x3d
[C:\cygwin64\home\roland_mainz\work\msnfs41_uidmapping\ms-nfs41-client\daem=
on\nfs41_daemon.c
@ 239]
14 02d7fbd4 559a867b     ucrtbased!invoke_thread_procedure(<function>
* procedure =3D 0x0032f4a0, void * context =3D 0x00375008)+0x28
[d:\th\minkernel\crts\ucrt\src\appcrt\startup\thread.cpp @ 92]
15 02d7fc1c 7774d839     ucrtbased!thread_start<unsigned int (void *
parameter =3D 0x0081bde0)+0xab
[d:\th\minkernel\crts\ucrt\src\appcrt\startup\thread.cpp @ 115]
16 02d7fc2c 77d2254d     KERNEL32!BaseThreadInitThunk+0x19
17 02d7fc88 77d22521     ntdll!__RtlUserThreadStart+0x2b
18 02d7fc98 00000000     ntdll!_RtlUserThreadStart+0x1b
---- snip ----

I'm scratching my head a bit... why does it not crash with a Debian
Bullseye (Linux 5.10.x) nfsd - did anything related to NFSv4 referrals
and/or exchange_id change between Linux 5.10.x and Linux 6.6 LTS ?

----

Bye,
Roland
--=20
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /=3D=3D\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)

