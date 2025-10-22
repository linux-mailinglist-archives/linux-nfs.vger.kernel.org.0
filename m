Return-Path: <linux-nfs+bounces-15527-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB35BFDBBE
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 19:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1942D19A0896
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 17:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344692E88B7;
	Wed, 22 Oct 2025 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="I7Lc7fRP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2925B2E1C63
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 17:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155795; cv=none; b=bZP0b/OzDp14299S5XRCKYZgUwaoqvpUG1O5mdvHkIB8tNqHEE6VTwqWAu5VdBT5jCrsTUrxnWnkKrPiG45XRyaYHIfbf/jwKnqjAygrVqhL9wdwaImBQxA1z2xRLTXY+X4aeJhUQoB9gpafAbb5hnfkVOsNGjWO+/iVCoLCTio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155795; c=relaxed/simple;
	bh=KIfAv9NjaYNvO+LOQy0QoRI/aOAvwHWClTf8lch1kdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQjNwoAm4izB8Uk6ZcYl+CCOmbB4T2JPgSPfbM0UsmJjy31ewoZx8JbRfTvJ3FALzZMqZWk501IiMXSkDA1LlY0iUnMj55QSPMIzq9Of4yPfR8W1M2qTh3zo44E+Gv/TIUqy3nTMQQVY432AuwQ30mgedTX3PJVPJmeArRJTtfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=I7Lc7fRP; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-376466f1280so73633411fa.0
        for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 10:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1761155790; x=1761760590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMVZTmFxr14Uq2WgoVoiWuUhhg2vK/u1W1dR4W7KQ0Q=;
        b=I7Lc7fRP1+4Um1gD5WbXgWtBnjXahIWiWuD0GmQ66DApET/1dB+5PhRKdk2lc2iSmS
         oOLmbDC+X/VjLOHerPmIGTMmonIdBsUY1MrZSxd9LBKcGxoTpqPGyTtZVdROb74lQCj8
         GFlNZLOmRrFtirHF4o4eCqW2rANBZVLZb/1gHqnfDYnpsTLvEszIlOa0RVCgRGyGoPdB
         j+ddEut83Y3K50PTLODchHFGH10SzMMQqPNX3mLKQPBeyUY1SyCQ/51wpuZ2uhjPRQAT
         4IaLldqwgqsgO4CQVJZSVWnj7hekf2DkeglY7Hq7S2SLYtSKg0h1aT3w5pVaLHK7hTOZ
         T2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761155790; x=1761760590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMVZTmFxr14Uq2WgoVoiWuUhhg2vK/u1W1dR4W7KQ0Q=;
        b=h+O9Nnhll1jQDMX2ING+voDnj+sGZPWCOrTrR5SF9nxoHnDq5X4Bm/9TuLJw/YlqVV
         WD4D9PMVbhDGuo88vBFNvrHUXoNnxYV7Q5aw+bUsufdtVJm5FAVepAdhrk6eI+kYYumB
         8o9L564nq2XvuqLumckTF1kuOBEXLYAgUXkP3Urg1OckuBju60X5kgzTH2CYMlqw8DQr
         MwvXhlvH+7ZRU6K0u+mEg5rsQ/GISCK4HU2YL6wOXsGGStUVpNf1/oQRMcNBT1NNOujM
         usa6oeo+Xv+vkA2f11Mf3Rj2r5fwk7cIjfeadteKZdNThEYqj6rs6y1h/pmsQeh/QKvc
         pVRg==
X-Forwarded-Encrypted: i=1; AJvYcCVf6uS3BuuxFEjWll5ZtJHnWThEezgWzY8eP1jmCXmxu+KP5yXw++4Uq7roQBJNZngLbIKHuSr6HHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhUZWuqozOp1UAcbPmEkDG//gDqeP4HA1BZ913nXabZFFH2S4u
	fMKABZ3vi1pHvHjd97Amm2Pl77Rgnwc7mOdoASHvHoaU6DYqbrVGhqvZsUkHsKUAXjBmc0kNjae
	N64it3Tyn4o+vAjIdOQ0bJhs8Zbv409qOFw==
X-Gm-Gg: ASbGncuf95Py/IvGRkAdBaTUW8iXxoyOoQ+7y4bpjDOp9WQK5c7oGP1/TSKpevH+/2Z
	3KENGxB1NkAjBiUMdqFgpi75qwNThdP9oXQMCVFFR5U4iQLZyrwosQLzgCiYJzoXrMT9O9YOLFW
	B1oZ3G7YmUOm2Loo2PiKa0ppvcgAOy4eKMgb5Hvmi5oxfrgNJKJIw8Tu3ZwpWzf9JNF1+JAIuHE
	uQA+xD3MB028EsLaQc4muus4UnR4UoU+cfYz7xmZ6uD26Zr2N37+wWkKjpp5HwClGbq503xIulr
	BGpmIJU1Sp7i/gx4p3fd/fRyOgm95w==
X-Google-Smtp-Source: AGHT+IHMjyR915eIWe7X+a+LfOlUsTosI+LI1aso5zp/IpXXANTz5CF18FhLrJmRyIbMUROLS0ckKzvLqeCKOGlg7tg=
X-Received: by 2002:a2e:ab89:0:b0:36e:9883:2928 with SMTP id
 38308e7fff4ca-3779777e10fmr69748291fa.16.1761155789911; Wed, 22 Oct 2025
 10:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021130506.45065-1-okorniev@redhat.com> <33ba39d2ff01eb0e52c80aa7015d27e34dde7fd2.camel@kernel.org>
 <CAN-5tyEuV2UO17w97b8weJUQR7hgqX=jz-kvGR9Sr_m3NZp8ww@mail.gmail.com>
 <d0a1a1ccec73ee56e614b91c4a75941f557398b8.camel@kernel.org>
 <CAN-5tyGK4MHgYaN1SqpygtvWM8BFrapT-rXY_y9msVfnRjN1Jw@mail.gmail.com>
 <ff353db93ca47b8fae530695ea44c0a34cd40af8.camel@kernel.org>
 <fe1489b3c55bdb32cd7ad460a2403bc23abdde81.camel@kernel.org>
 <f61025a96df19c64ba372cdcab8b12f3fa2fff9e.camel@kernel.org>
 <CAN-5tyFWvP2ZTeYFN6ybGoxvsAw=TKFJAo0dVLU_=s_5t=LCGg@mail.gmail.com> <f5073caf3e3db05702ed196042053fc864645750.camel@kernel.org>
In-Reply-To: <f5073caf3e3db05702ed196042053fc864645750.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 22 Oct 2025 13:56:18 -0400
X-Gm-Features: AS18NWBKY3XKqVwbeHAMmNMgO0HurmdjsHZKGQKel-wNKYAUyfXppQlckHZ06X4
Message-ID: <CAN-5tyHWWkmgcFCgpZR2Bqm7tAued_JPZ-i0rGaa+FzLtFhMjw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] lockd: prevent UAF in nlm4svc_proc_test in
 reexport NLM
To: Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, linux-nfs@vger.kernel.org, 
	neilb@brown.name, Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 12:06=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Wed, 2025-10-22 at 11:38 -0400, Olga Kornievskaia wrote:
> > On Tue, Oct 21, 2025 at 1:45=E2=80=AFPM Jeff Layton <jlayton@kernel.org=
> wrote:
> > >
> > > On Tue, 2025-10-21 at 13:15 -0400, Jeff Layton wrote:
> > > > On Tue, 2025-10-21 at 13:03 -0400, Jeff Layton wrote:
> > > > > On Tue, 2025-10-21 at 12:17 -0400, Olga Kornievskaia wrote:
> > > > > > On Tue, Oct 21, 2025 at 11:59=E2=80=AFAM Jeff Layton <jlayton@k=
ernel.org> wrote:
> > > > > > >
> > > > > > > On Tue, 2025-10-21 at 11:23 -0400, Olga Kornievskaia wrote:
> > > > > > > > On Tue, Oct 21, 2025 at 9:40=E2=80=AFAM Jeff Layton <jlayto=
n@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, 2025-10-21 at 09:05 -0400, Olga Kornievskaia wrot=
e:
> > > > > > > > > > When knfsd is a reexport nfs server, it nlm4svc_proc_te=
st() in
> > > > > > > > > > calling nlmsvc_testlock() with a lock conflict lock_rel=
ease_private()
> > > > > > > > > > call would end up calling nlmsvc_put_lockowner() and th=
en back in
> > > > > > > > > > nlm4svc_proc_test() function there will be another call=
 to
> > > > > > > > > > nlmsvc_put_lockowner() for the same owner leading to us=
e-after-free
> > > > > > > > > > violation (below).
> > > > > > > > > >
> > > > > > > > > > The problem only arises when the underlying file system=
 has been
> > > > > > > > > > re-exported as different paths are taken in vfs_test_lo=
ck().
> > > > > > > > > > When it's reexport, filp->f_op->lock is set and when vf=
s_test_lock()
> > > > > > > > > > is done fl_lmops pointer is non-null. When it's regular=
 export,
> > > > > > > > > > vfs_test_lock() calls posix_test_lock() which ends up c=
alling
> > > > > > > > > > locks_copy_conflock() and it copies NULL into fl_lmops =
and then
> > > > > > > > > > calling into lock_release_private() does not call
> > > > > > > > > > nlmsvc_put_lockowner().
> > > > > > > > > >
> > > > > > > > > > The proposed solution is to intentionally clear fl_lmop=
s pointer to
> > > > > > > > > > make sure that if there is a conflict (be it a local fi=
le system
> > > > > > > > > > or reexport), lock_release_private() would not call
> > > > > > > > > > nlmsvc_put_lockowner().
> > > > > > > > > >
> > > > > > > > > > kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > > > > > > > > kernel: BUG: KASAN: slab-use-after-free in nlmsvc_put_l=
ockowner+0x30/0x250 [lockd]
> > > > > > > > > > kernel: Read of size 4 at addr ffff0000bf3bca10 by task=
 lockd/6092
> > > > > > > > > > kernel:
> > > > > > > > > > kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump: load=
ed Not tainted 6.18.0-rc1+ #23 PREEMPT(voluntary)
> > > > > > > > > > kernel: Hardware name: VMware, Inc. VMware20,1/VBSA, BI=
OS VMW201.00V.24006586.BA64.2406042154 06/04/2024
> > > > > > > > > > kernel: Call trace:
> > > > > > > > > > kernel:  show_stack+0x34/0x98 (C)
> > > > > > > > > > kernel:  dump_stack_lvl+0x80/0xa8
> > > > > > > > > > kernel:  print_address_description.constprop.0+0x90/0x3=
10
> > > > > > > > > > kernel:  print_report+0x108/0x1f8
> > > > > > > > > > kernel:  kasan_report+0xc8/0x120
> > > > > > > > > > kernel:  kasan_check_range+0xe8/0x190
> > > > > > > > > > kernel:  __kasan_check_read+0x20/0x30
> > > > > > > > > > kernel:  nlmsvc_put_lockowner+0x30/0x250 [lockd]
> > > > > > > > > > kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
> > > > > > > > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > > > > > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > > > > > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > > > > > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > > > > > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > > > > > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > > > > > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > > > > > > > kernel:  kthread+0x2f8/0x398
> > > > > > > > > > kernel:  ret_from_fork+0x10/0x20
> > > > > > > > > > kernel:
> > > > > > > > > > kernel: Allocated by task 6092:
> > > > > > > > > > kernel:  kasan_save_stack+0x3c/0x70
> > > > > > > > > > kernel:  kasan_save_track+0x20/0x40
> > > > > > > > > > kernel:  kasan_save_alloc_info+0x40/0x58
> > > > > > > > > > kernel:  __kasan_kmalloc+0xd4/0xd8
> > > > > > > > > > kernel:  __kmalloc_cache_noprof+0x1a8/0x5c0
> > > > > > > > > > kernel:  nlmsvc_locks_init_private+0xe4/0x520 [lockd]
> > > > > > > > > > kernel:  nlm4svc_retrieve_args+0x38c/0x530 [lockd]
> > > > > > > > > > kernel:  __nlm4svc_proc_test+0x194/0x318 [lockd]
> > > > > > > > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > > > > > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > > > > > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > > > > > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > > > > > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > > > > > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > > > > > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > > > > > > > kernel:  kthread+0x2f8/0x398
> > > > > > > > > > kernel:  ret_from_fork+0x10/0x20
> > > > > > > > > > kernel:
> > > > > > > > > > kernel: Freed by task 6092:
> > > > > > > > > > kernel:  kasan_save_stack+0x3c/0x70
> > > > > > > > > > kernel:  kasan_save_track+0x20/0x40
> > > > > > > > > > kernel:  __kasan_save_free_info+0x4c/0x80
> > > > > > > > > > kernel:  __kasan_slab_free+0x88/0xc0
> > > > > > > > > > kernel:  kfree+0x110/0x480
> > > > > > > > > > kernel:  nlmsvc_put_lockowner+0x1b4/0x250 [lockd]
> > > > > > > > > > kernel:  nlmsvc_put_owner+0x18/0x30 [lockd]
> > > > > > > > > > kernel:  locks_release_private+0x190/0x2a8
> > > > > > > > > > kernel:  nlmsvc_testlock+0x2e0/0x648 [lockd]
> > > > > > > > > > kernel:  __nlm4svc_proc_test+0x244/0x318 [lockd]
> > > > > > > > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > > > > > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > > > > > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > > > > > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > > > > > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > > > > > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > > > > > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > > > > > > > kernel:  kthread+0x2f8/0x398
> > > > > > > > > > kernel:  ret_from_fork+0x10/0x20
> > > > > > > > > > kernel:
> > > > > > > > > > kernel: The buggy address belongs to the object at ffff=
0000bf3bca00
> > > > > > > > > >         which belongs to the cache kmalloc-64 of size 6=
4
> > > > > > > > > > kernel: The buggy address is located 16 bytes inside of
> > > > > > > > > >         freed 64-byte region [ffff0000bf3bca00, ffff000=
0bf3bca40)
> > > > > > > > > > kernel:
> > > > > > > > > > kernel: The buggy address belongs to the physical page:
> > > > > > > > > > kernel: page: refcount:0 mapcount:0 mapping:00000000000=
00000 index:0x0 pfn:0x13f3bc
> > > > > > > > > > kernel: flags: 0x2fffff00000000(node=3D0|zone=3D2|lastc=
pupid=3D0xfffff)
> > > > > > > > > > kernel: page_type: f5(slab)
> > > > > > > > > > kernel: raw: 002fffff00000000 ffff0000800028c0 dead0000=
00000122 0000000000000000
> > > > > > > > > > kernel: raw: 0000000000000000 0000000080200020 00000000=
f5000000 0000000000000000
> > > > > > > > > > kernel: page dumped because: kasan: bad access detected
> > > > > > > > > > kernel:
> > > > > > > > > > kernel: Memory state around the buggy address:
> > > > > > > > > > kernel:  ffff0000bf3bc900: fa fb fb fb fb fb fb fb fc f=
c fc fc fc fc fc fc
> > > > > > > > > > kernel:  ffff0000bf3bc980: fa fb fb fb fb fb fb fb fc f=
c fc fc fc fc fc fc
> > > > > > > > > > kernel: >ffff0000bf3bca00: fa fb fb fb fb fb fb fb fc f=
c fc fc fc fc fc fc
> > > > > > > > > > kernel:                          ^
> > > > > > > > > > kernel:  ffff0000bf3bca80: fa fb fb fb fb fb fb fb fc f=
c fc fc fc fc fc fc
> > > > > > > > > > kernel:  ffff0000bf3bcb00: fc fc fc fc fc fc fc fc fc f=
c fc fc fc fc fc fc
> > > > > > > > > > kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > > > > > > > > kernel: Disabling lock debugging due to kernel taint
> > > > > > > > > > kernel: AGLO: nlmsvc_put_lockowner 00000000028055fb cou=
nt=3D0
> > > > > > > > > > kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump: load=
ed Tainted: G    B               6.18.0-rc1+ #23 PREEMPT(voluntary)
> > > > > > > > > > kernel: Tainted: [B]=3DBAD_PAGE
> > > > > > > > > > kernel: Hardware name: VMware, Inc. VMware20,1/VBSA, BI=
OS VMW201.00V.24006586.BA64.2406042154 06/04/2024
> > > > > > > > > > kernel: Call trace:
> > > > > > > > > > kernel:  show_stack+0x34/0x98 (C)
> > > > > > > > > > kernel:  dump_stack_lvl+0x80/0xa8
> > > > > > > > > > kernel:  dump_stack+0x1c/0x30
> > > > > > > > > > kernel:  nlmsvc_put_lockowner+0x7c/0x250 [lockd]
> > > > > > > > > > kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
> > > > > > > > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > > > > > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > > > > > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > > > > > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > > > > > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > > > > > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > > > > > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > > > > > > > kernel:  kthread+0x2f8/0x398
> > > > > > > > > > kernel:  ret_from_fork+0x10/0x20
> > > > > > > > > > kernel: ------------[ cut here ]------------
> > > > > > > > > > kernel: refcount_t: underflow; use-after-free.
> > > > > > > > > > kernel: WARNING: CPU: 0 PID: 6092 at lib/refcount.c:87 =
refcount_dec_not_one+0x198/0x1b0
> > > > > > > > > > kernel: Modules linked in: rpcrdma rdma_cm iw_cm ib_cm =
ib_core nfsd nfsv3 nfs_acl nfs lockd grace nfs_localio netfs ext4 crc16 mbc=
ache jbd2 overlay uinput snd_seq_dummy snd_hrtimer qrtr rfkill vfat fat uvc=
video snd_hda_codec_generic videobuf2_vmalloc videobuf2_memops uvc snd_hda_=
intel videobuf2_v4l2 videobuf2_common snd_intel_dspcfg videodev snd_hda_cod=
ec snd_hda_core mc snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd s=
oundcore sg loop auth_rpcgss vsock_loopback vmw_vsock_virtio_transport_comm=
on vmw_vsock_vmci_transport vmw_vmci vsock xfs 8021q garp stp llc mrp nvme =
nvme_core nvme_keyring nvme_auth ghash_ce hkdf e1000e sr_mod cdrom vmwgfx d=
rm_ttm_helper ttm sunrpc dm_mirror dm_region_hash dm_log iscsi_tcp libiscsi=
_tcp libiscsi scsi_transport_iscsi fuse dm_multipath dm_mod nfnetlink
> > > > > > > > > > kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump: load=
ed Tainted: G    B               6.18.0-rc1+ #23 PREEMPT(voluntary)
> > > > > > > > > > kernel: Tainted: [B]=3DBAD_PAGE
> > > > > > > > > > kernel: Hardware name: VMware, Inc. VMware20,1/VBSA, BI=
OS VMW201.00V.24006586.BA64.2406042154 06/04/2024
> > > > > > > > > > kernel: pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT=
 -SSBS BTYPE=3D--)
> > > > > > > > > > kernel: pc : refcount_dec_not_one+0x198/0x1b0
> > > > > > > > > > kernel: lr : refcount_dec_not_one+0x198/0x1b0
> > > > > > > > > > kernel: sp : ffff80008a627930
> > > > > > > > > > kernel: x29: ffff80008a627990 x28: ffff0000bf3bca00 x27=
: ffff0000ba5c7000
> > > > > > > > > > kernel: x26: 1fffe000191eeb84 x25: 1ffff000114c4f48 x24=
: ffff0000c8f75c24
> > > > > > > > > > kernel: x23: 0000000000000007 x22: ffff80008a627950 x21=
: 1ffff000114c4f26
> > > > > > > > > > kernel: x20: 00000000ffffffff x19: ffff0000bf3bca10 x18=
: 0000000000000310
> > > > > > > > > > kernel: x17: 0000000000000000 x16: 0000000000000000 x15=
: 0000000000000000
> > > > > > > > > > kernel: x14: 0000000000000000 x13: 0000000000000001 x12=
: ffff60004fd90aa3
> > > > > > > > > > kernel: x11: 1fffe0004fd90aa2 x10: ffff60004fd90aa2 x9 =
: dfff800000000000
> > > > > > > > > > kernel: x8 : 00009fffb026f55e x7 : ffff00027ec85513 x6 =
: 0000000000000001
> > > > > > > > > > kernel: x5 : ffff00027ec85510 x4 : ffff60004fd90aa3 x3 =
: ffff800080787bc0
> > > > > > > > > > kernel: x2 : 0000000000000000 x1 : 0000000000000000 x0 =
: ffff0000a75a8000
> > > > > > > > > > kernel: Call trace:
> > > > > > > > > > kernel:  refcount_dec_not_one+0x198/0x1b0 (P)
> > > > > > > > > > kernel:  refcount_dec_and_lock+0x1c/0xb8
> > > > > > > > > > kernel:  nlmsvc_put_lockowner+0x9c/0x250 [lockd]
> > > > > > > > > > kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
> > > > > > > > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > > > > > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > > > > > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > > > > > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > > > > > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > > > > > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > > > > > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > > > > > > > kernel:  kthread+0x2f8/0x398
> > > > > > > > > > kernel:  ret_from_fork+0x10/0x20
> > > > > > > > > > kernel: ---[ end trace 0000000000000000 ]---
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > > > > > > > > ---
> > > > > > > > > >  fs/lockd/svclock.c | 1 +
> > > > > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > > > >
> > > > > > > > > > diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> > > > > > > > > > index a31dc9588eb8..1dd0fec186de 100644
> > > > > > > > > > --- a/fs/lockd/svclock.c
> > > > > > > > > > +++ b/fs/lockd/svclock.c
> > > > > > > > > > @@ -652,6 +652,7 @@ nlmsvc_testlock(struct svc_rqst *rq=
stp, struct nlm_file *file,
> > > > > > > > > >       conflock->fl.c.flc_type =3D lock->fl.c.flc_type;
> > > > > > > > > >       conflock->fl.fl_start =3D lock->fl.fl_start;
> > > > > > > > > >       conflock->fl.fl_end =3D lock->fl.fl_end;
> > > > > > > > > > +     conflock->fl.fl_lmops =3D NULL;
> > > > > > > > > >       locks_release_private(&lock->fl);
> > > > > > > > > >
> > > > > > > > > >       ret =3D nlm_lck_denied;
> > > > > > > > >
> > > > > > > > > The problem sounds real, but I'm not sure I like this sol=
ution.
> > > > > > > >
> > > > > > > > I have no claim that this solution is the best. I was conte=
mplating on
> > > > > > > > setting this to NULL only in the case when ->f_ops->lock() =
is NULL
> > > > > > > > thus restricting it to the path that does not call posix_te=
st_lock().
> > > > > > > >
> > > > > > > > > It seems like this is gaming the refcounting such that we=
 take a
> > > > > > > > > reference in locks_copy_conflock() but then you zero out =
fl_lmops
> > > > > > > > > before that reference can be put.
> > > > > > > >
> > > > > > > > IF lock_copy_conflock() is called then fl_lmops is already =
NULL.
> > > > > > > >
> > > > > > > > Let me try to lay out the sequence of steps for both cases.
> > > > > > > >
> > > > > > > > Reexport
> > > > > > > > 1. when nlmsvc_test_lock() is called file->f_file[mode]->f_=
ops->lock
> > > > > > > > is set (fl_lmops is set too) prior to calling vfs_test_lock=
.
> > > > > > > > 2. Because ->lock is set vfs_test_lock() calls the ->lock f=
unction
> > > > > > > > (instead of posix_test_lock)
> > > > > > > > 3. After vfs_test_lock() fl_lmops is still set so lock_rele=
ase_private
> > > > > > > > is called and calls nlmscv_put_lockowner().
> > > > > > > >
> > > > > > > > Normal export
> > > > > > > > 1. when nlmsvc_test_lock() is called ->lock is not set (fl_=
lmops is
> > > > > > > > set) prior to calling vfs_test_lock
> > > > > > > > 2. Because -> is not set posix_test_lock() is called which =
will call
> > > > > > > > local_copy_conflock() which will set fl_lmops to NULL.
> > > > > > > > 3. Since fl_lmops is NULL put_lockowner isn't called.
> > > > > > > >
> > > > > > > > Reexport is where I'm hazy. I'm assuming that reexported se=
rver opened
> > > > > > > > a file and the "file" is the NFS file object and that's why
> > > > > > > > file->f_file[mode]->f_ops->lock is set? So perhaps if we ta=
ke the
> > > > > > > > presence of ->lock to mean reexport, we can do as I did (ie=
., set
> > > > > > > > fl_lmops to null), or maybe we can take an extra reference =
knowing
> > > > > > > > that we'd need to put it in lock_release_private() ( -- thi=
s
> > > > > > > > suggestion ties to your next question). I don't see any dif=
ference to
> > > > > > > > either setting it to NULL or taking an extra reference for =
when
> > > > > > > > ->lock() is set . Both are confusing and I would say warran=
t a comment
> > > > > > > > for why we are doing it.
> > > > > > > >
> > > > > > >
> > > > > > > To be clear, there is nothing "special" about NFS reexport he=
re. The
> > > > > > > NFS client just has some limitations as to what it can do whe=
n it's
> > > > > > > being (re)exported. Exporting other sorts of network or clust=
ered
> > > > > > > filesystems can also be problematic for similar reasons.
> > > > > > >
> > > > > > > So, we should focus on making this generically work, and not =
take -
> > > > > > > > lock being set to mean that this is an NFS reexport.
> > > > > >
> > > > > > I guess it doesn't matter what kind of re-export but the fact t=
hat if
> > > > > > ->lock is set we know that posix_test_lock and then
> > > > > > local_copy_conflock won't be called and thus there is a great c=
hance
> > > > > > that fl_lmops will still be set on return from vfs_test_lock().
> > > > > >
> > > > > > > A question: you mentioned this is a reexporting server. Are y=
ou
> > > > > > > reexporting an NFSv4 mount as NFSv3? Or is this a v3->v3 reex=
port?
> > > > > >
> > > > > > v3->v3 reexport.
> > > > > >
> > > > > >
> > > > >
> > > > > Ok, looking now:
> > > > >
> > > > > The test_owner in __nlm4svc_proc_test() comes from the args, whic=
h
> > > > > happens during the decode phase. That gets a valid reference to a=
n NLM
> > > > > lockowner in nlmsvc_locks_init_private(). Therefore, this call in
> > > > > __nlm4svc_proc_test() seems legit.
> > > > >
> > > > >         nlmsvc_put_lockowner(test_owner);
> > > > >
> > > > > Now, between those two gets/puts, there is the call to vfs_test_l=
ock()
> > > > > in nlmsvc_testlock(). That uses the same file_lock argument struc=
ture
> > > > > to represent both the lock and the conflock.
> > > > >
> > > > >         error =3D vfs_test_lock(file->f_file[mode], &lock->fl);
> > > > >
> > > > > ...so the flc_owner field at this point is still set to the (orig=
inal)
> > > > > nlmclient's owner.
> > > > >
> > > > > In this case, that call ends up calling down in nlmclnt_test(), w=
hich
> > > > > ignores the flc_owner field. It also ends up overwriting the othe=
r
> > > > > fields in &fl with conflock info.
> > > > >
> > > > > I think the bug is actually there. Before nlmclnt_test() overwrit=
es the
> > > > > fields in "fl", it needs to release the owner reference (and zero=
 out
> > > > > the owner). Would this patch fix the bug?
> > > > >
> > > > > ---------------------8------------------------
> > > > >
> > > > > diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
> > > > > index cebcc283b7ce..200309ee1a74 100644
> > > > > --- a/fs/lockd/clntproc.c
> > > > > +++ b/fs/lockd/clntproc.c
> > > > > @@ -438,6 +438,8 @@ nlmclnt_test(struct nlm_rqst *req, struct fil=
e_lock
> > > > > *fl)
> > > > >         if (status < 0)
> > > > >                 goto out;
> > > > >
> > > > > +       locks_release_private(&fl);
> > > > > +
> > > > >         switch (req->a_res.status) {
> > > > >                 case nlm_granted:
> > > > >                         fl->c.flc_type =3D F_UNLCK;
> > > >
> > > >
> > > > Sorry, I take it back. That alone won't fix it because of the point=
er-
> > > > saving shenanigans in __nlm4svc_proc_test. We'll need to do this a =
bit
> > > > more carefully, I think.
> > >
> > > How about this patch? The changelog still needs some work, but I thin=
k
> > > this is the most correct way to handle it:
> > >
> > > -------------------------8<----------------------------
> > >
> > > [PATCH] nlm: fix handling of conflocks by NLM
> > >
> > > The handling of conflocks can result in a refcount overput on the
> > > flc_owner in the case of a reexported NFSv3 fs.
> > >
> > > lockd will pass down a file_lock structure in its arguments with
> > > flc_owner set to an NLM owner and a valid reference. Once that gets
> > > down to the reexported NFS client, it will ignore that field and leav=
e
> > > it intact when copying in conflock info.
> > >
> > > The NLM server code will then end up releasing the conflock, and then
> > > releasing the one from the arguments, not realizing that the lock has
> > > already been released.
> > >
> > > The owner info in the arguments to vfs_test_lock() is there to give
> > > information about the requestor. Once nlmclnt_test() is going to copy=
 in
> > > the conflock info however, it needs to release the old owner.
> > >
> > > Have nlmclnt_test() do call locks_release_private() after testing the
> > > lock to release any info that was in the old file_lock structure.
> > >
> > > This creates another problem: __nlm4svc_proc_test() and
> > > __nlmsvc_proc_test() both call nlmsvc_put_lockowner() unconditionally=
 on
> > > the original lockowner that it got from decoding the args. Switch the=
m
> > > both to just call locks_release_private() on &argp->lock instead, whi=
ch
> > > should handle the case properly where the info in argp->lock has alre=
ady
> > > been released.
> > >
> > > With that changed, we can also eliminate the call to
> > > locks_release_private() in nlmsvc_testlock() since the callers will n=
ow
> > > handle that.
> > >
> > > Reported-by: Olga Kornievskaia <aglo@umich.edu>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/lockd/clntproc.c | 3 +++
> > >  fs/lockd/svc4proc.c | 4 +---
> > >  fs/lockd/svclock.c  | 1 -
> > >  fs/lockd/svcproc.c  | 5 +----
> > >  4 files changed, 5 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
> > > index cebcc283b7ce..d3dd04137677 100644
> > > --- a/fs/lockd/clntproc.c
> > > +++ b/fs/lockd/clntproc.c
> > > @@ -438,6 +438,9 @@ nlmclnt_test(struct nlm_rqst *req, struct file_lo=
ck *fl)
> > >         if (status < 0)
> > >                 goto out;
> > >
> > > +       /* Release any references held by fl before copying in conflo=
ck info */
> > > +       locks_release_private(fl);
> > > +
> > >         switch (req->a_res.status) {
> > >                 case nlm_granted:
> > >                         fl->c.flc_type =3D F_UNLCK;
> > > diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> > > index 109e5caae8c7..cbfec12296a4 100644
> > > --- a/fs/lockd/svc4proc.c
> > > +++ b/fs/lockd/svc4proc.c
> > > @@ -97,7 +97,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct =
nlm_res *resp)
> > >         struct nlm_args *argp =3D rqstp->rq_argp;
> > >         struct nlm_host *host;
> > >         struct nlm_file *file;
> > > -       struct nlm_lockowner *test_owner;
> > >         __be32 rc =3D rpc_success;
> > >
> > >         dprintk("lockd: TEST4        called\n");
> > > @@ -107,7 +106,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struc=
t nlm_res *resp)
> > >         if ((resp->status =3D nlm4svc_retrieve_args(rqstp, argp, &hos=
t, &file)))
> > >                 return resp->status =3D=3D nlm_drop_reply ? rpc_drop_=
reply :rpc_success;
> > >
> > > -       test_owner =3D argp->lock.fl.c.flc_owner;
> > >         /* Now check for conflicting locks */
> > >         resp->status =3D nlmsvc_testlock(rqstp, file, host, &argp->lo=
ck,
> > >                                        &resp->lock);
> > > @@ -116,7 +114,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struc=
t nlm_res *resp)
> > >         else
> > >                 dprintk("lockd: TEST4        status %d\n", ntohl(resp=
->status));
> > >
> > > -       nlmsvc_put_lockowner(test_owner);
> > > +       locks_release_private(&argp->lock.fl);
> > >         nlmsvc_release_host(host);
> > >         nlm_release_file(file);
> > >         return rc;
> >
> > Aren't these svc4proc changes defeat the purpose of the following commi=
t:
> >
> > commit 184cefbe62627730c30282df12bcff9aae4816ea
> > Author: Benjamin Coddington <bcodding@redhat.com>
> > Date:   Mon Jun 13 09:40:06 2022 -0400
> >
> >     NLM: Defend against file_lock changes after vfs_test_lock()
> >
> >     Instead of trusting that struct file_lock returns completely unchan=
ged
> >     after vfs_test_lock() when there's no conflicting lock, stash away =
our
> >     nlm_lockowner reference so we can properly release it for all cases=
.
> >
> >
> >     This defends against another file_lock implementation overwriting f=
l_owner
> >     when the return type is F_UNLCK.
> >
> > Not that they are the cause of the crash but I would imagine it would
> > cause a problem fixed by the patch....
> >
>
> Yes, it would. I'm not sure that patch is correct.

But it seems wrong that we are now considering putting a patch that
fixes one issue (ie crash on reexport) but re-introduces another issue
(that the reverted code fixed be it not in a correct manner).

> Since the flc_owner is refcounted in some cases, it's incumbent on the
> filesystem's ->lock to properly release those resources in the old file
> lock before clobbering those fields with the conflock info.
>
> Longer term, I think Neil is right and we probably need to fix
> vfs_test_lock and the lock inode_operation to take a separate conflock
> for testlock purposes. That's a bigger change though (particularly the
> ->lock operations).
>
>
> > > diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> > > index a31dc9588eb8..7ff3d75a5ca3 100644
> > > --- a/fs/lockd/svclock.c
> > > +++ b/fs/lockd/svclock.c
> > > @@ -652,7 +652,6 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nl=
m_file *file,
> > >         conflock->fl.c.flc_type =3D lock->fl.c.flc_type;
> > >         conflock->fl.fl_start =3D lock->fl.fl_start;
> > >         conflock->fl.fl_end =3D lock->fl.fl_end;
> > > -       locks_release_private(&lock->fl);
> > >
> > >         ret =3D nlm_lck_denied;
> > >  out:
> > > diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
> > > index f53d5177f267..6f3e669a3532 100644
> > > --- a/fs/lockd/svcproc.c
> > > +++ b/fs/lockd/svcproc.c
> > > @@ -117,7 +117,6 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct=
 nlm_res *resp)
> > >         struct nlm_args *argp =3D rqstp->rq_argp;
> > >         struct nlm_host *host;
> > >         struct nlm_file *file;
> > > -       struct nlm_lockowner *test_owner;
> > >         __be32 rc =3D rpc_success;
> > >
> > >         dprintk("lockd: TEST          called\n");
> > > @@ -127,8 +126,6 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct=
 nlm_res *resp)
> > >         if ((resp->status =3D nlmsvc_retrieve_args(rqstp, argp, &host=
, &file)))
> > >                 return resp->status =3D=3D nlm_drop_reply ? rpc_drop_=
reply :rpc_success;
> > >
> > > -       test_owner =3D argp->lock.fl.c.flc_owner;
> > > -
> > >         /* Now check for conflicting locks */
> > >         resp->status =3D cast_status(nlmsvc_testlock(rqstp, file, hos=
t,
> > >                                                    &argp->lock, &resp=
->lock));
> > > @@ -138,7 +135,7 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct=
 nlm_res *resp)
> > >                 dprintk("lockd: TEST          status %d vers %d\n",
> > >                         ntohl(resp->status), rqstp->rq_vers);
> > >
> > > -       nlmsvc_put_lockowner(test_owner);
> > > +       locks_release_private(&argp->lock.fl);
> > >         nlmsvc_release_host(host);
> > >         nlm_release_file(file);
> > >         return rc;
> > > --
> > > 2.51.0
> > >
>
> --
> Jeff Layton <jlayton@kernel.org>

