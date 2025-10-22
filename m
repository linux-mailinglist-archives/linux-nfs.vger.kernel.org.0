Return-Path: <linux-nfs+bounces-15517-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADFBBFCEE0
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 17:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB4AB3AC4CC
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 15:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D2A34D4EE;
	Wed, 22 Oct 2025 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="J8PMPLRS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB607212B2F
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 15:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761147516; cv=none; b=SL6alhNWSf5JyJVmPPgYURqaChzJqxG/cXybc2jvEb28KZV5ie1J1x0Cy/R8qC2U24qXhr6uvBb3Ix1C2q3xaxUwSuaUiThNNsW2sGPKAJ7/kQCZy8D/T465MKgaimmEpAIA7ozYAWDoyUz9qv9fJLYOeHTAwgfocSBGeGCyNjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761147516; c=relaxed/simple;
	bh=QHlC2yguxILjEyZzhYrHETM9HLFxuAsMqfrwFGLUOiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NSPBZ5vYgVlJPkR/e9CU9IvZq0tMjVcHb723cgIkje3Yd9+ITKn4EwKZxSO2759GPbmy3fWcz8ETWgg8smnTnhPjLVlec1Ky/9P2BTeghZJIYLC1W+T2nPf4JmbUaiOu3zp3WStB/+UZxOYZmNGQr8XAw2tzHLU8wvetAPR1Dy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=J8PMPLRS; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-36295d53a10so59238621fa.0
        for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 08:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1761147501; x=1761752301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jh6Xn8394CutXdg4H7cMHD2JEZXUUsuZHTdIJQ0cw10=;
        b=J8PMPLRS6/FjduGr6OzfaW6i2e0xq4+t8NLbzKrPuD370AZHGW+4B+DEjaolz3jBEF
         2qu7E0QrhpuafWXESGaIzM4dEnyf9LX6dnfZmub27OeYDuI9P2v4mW1kaUhpY+AeXgUm
         J5TFzYdrthh10RrHhB+uJrfXjupB2NpDXOgfa/vZPTLwwPbeQdi+2GjY1+JAA0csa9Yq
         dnBN4Xe+mGu1Pv1PMUYq322tFza44fAzYEq5j2mmPzNuHi1Q69txBFvAUKDltUc1PlR3
         WKcJdVHp+18R7sM7rToZJmfOat0nfzpVSB7YcOqcWM8WKgX19IHtKxq71IVMMnGImR/0
         g0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761147501; x=1761752301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jh6Xn8394CutXdg4H7cMHD2JEZXUUsuZHTdIJQ0cw10=;
        b=rQOJyN5H40mfxqf0Dbqc7ca/8KKj4hQgA7x+lsCcVcAi6gNNd3JprzlPcPTWe3nFXe
         4OoF9U1XbxW4N2Akr8LIF4GxDrmsxNvzw6561biVsWfX1wiJGgIWqyg3i+8NYRokeaFJ
         /Ap4C6i93Zvah2Gr+0HGJyL6vtdGZDNTTyAR8li/Rv16t5uN0g6+cNbCRENkvz9rxyKL
         2JAWUIt+LGZyX4wQB7nB0vUN/09lsO7LcOl7ZuTWnzJyJGuxvUF37xctdVJUN7Uq/Y0X
         Al1mooauSZfIQG3cTYWIS+kfkVIBY/fBRwh5ygbbuG1JCgLA5ZBi4o+MqkFD9ipTburB
         9tLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmBIGSWbAVu96H5aRq7Qwb+X4fRzyfZm0bh1YbAz0s9xiHMhp3j0yxVihD/1O29RXsd0dlau7tt+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOWvt9ict5YzUIxbm+LdarFTdrVpMnT+amOeJkftcNRaGmCuUJ
	pvy4o3EPo0rUF3R3XQXXkdR/GEmfgLejizUhZtIEZb/qC1MuvozMQ/fInEdESPIUEcVgXICiI8K
	RTDUXZkFSp4fCUmMd/km99GBQqpOvbE4=
X-Gm-Gg: ASbGncvxjQ/CmqhKpkfc93jhw8MSzbzj8Yt7ZZg5HeF9WbjIuDDWw3/XQXyVDmZgClZ
	0cY0jQCxHMmwJmdKiw9wxs566IV07P13oQopHui1sjcVtVoalauRr0GZWu0C/oM2YWC20tgEwqv
	bFuyZWbZipeXq1VAiy1VdWJU2Ozh76IjI/MrjDvdnK/m5om2CqOjCYk8s2zkacvWs7QoCYZo4t8
	vLc8TTb1r2JR2Ka+U0QvBlFC6mEciFHDoc6f/H3LoZtYi6SZ8chmjPjErGqMZ7+/qqw9tL5nH6U
	1r7rRSkZ48Vzp5P1Wfc=
X-Google-Smtp-Source: AGHT+IGP+cuKE/gAKVIGTv4SckMDmB0j7dGHLOnB5ZF2HMwDMvo5ccmhrCHtCEP56PGYU8NuaMqlUOAmvOs/eyeTVr8=
X-Received: by 2002:a2e:9a13:0:b0:376:2802:84ca with SMTP id
 38308e7fff4ca-37797a7e796mr64281991fa.47.1761147500971; Wed, 22 Oct 2025
 08:38:20 -0700 (PDT)
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
 <fe1489b3c55bdb32cd7ad460a2403bc23abdde81.camel@kernel.org> <f61025a96df19c64ba372cdcab8b12f3fa2fff9e.camel@kernel.org>
In-Reply-To: <f61025a96df19c64ba372cdcab8b12f3fa2fff9e.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 22 Oct 2025 11:38:07 -0400
X-Gm-Features: AS18NWDU3m6-HR6yKgC2lBQ2c8Ee7yrOXSk66upr4o0__MIzukIM1GDUhSKpJ-g
Message-ID: <CAN-5tyFWvP2ZTeYFN6ybGoxvsAw=TKFJAo0dVLU_=s_5t=LCGg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] lockd: prevent UAF in nlm4svc_proc_test in
 reexport NLM
To: Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, linux-nfs@vger.kernel.org, 
	neilb@brown.name, Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 1:45=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Tue, 2025-10-21 at 13:15 -0400, Jeff Layton wrote:
> > On Tue, 2025-10-21 at 13:03 -0400, Jeff Layton wrote:
> > > On Tue, 2025-10-21 at 12:17 -0400, Olga Kornievskaia wrote:
> > > > On Tue, Oct 21, 2025 at 11:59=E2=80=AFAM Jeff Layton <jlayton@kerne=
l.org> wrote:
> > > > >
> > > > > On Tue, 2025-10-21 at 11:23 -0400, Olga Kornievskaia wrote:
> > > > > > On Tue, Oct 21, 2025 at 9:40=E2=80=AFAM Jeff Layton <jlayton@ke=
rnel.org> wrote:
> > > > > > >
> > > > > > > On Tue, 2025-10-21 at 09:05 -0400, Olga Kornievskaia wrote:
> > > > > > > > When knfsd is a reexport nfs server, it nlm4svc_proc_test()=
 in
> > > > > > > > calling nlmsvc_testlock() with a lock conflict lock_release=
_private()
> > > > > > > > call would end up calling nlmsvc_put_lockowner() and then b=
ack in
> > > > > > > > nlm4svc_proc_test() function there will be another call to
> > > > > > > > nlmsvc_put_lockowner() for the same owner leading to use-af=
ter-free
> > > > > > > > violation (below).
> > > > > > > >
> > > > > > > > The problem only arises when the underlying file system has=
 been
> > > > > > > > re-exported as different paths are taken in vfs_test_lock()=
.
> > > > > > > > When it's reexport, filp->f_op->lock is set and when vfs_te=
st_lock()
> > > > > > > > is done fl_lmops pointer is non-null. When it's regular exp=
ort,
> > > > > > > > vfs_test_lock() calls posix_test_lock() which ends up calli=
ng
> > > > > > > > locks_copy_conflock() and it copies NULL into fl_lmops and =
then
> > > > > > > > calling into lock_release_private() does not call
> > > > > > > > nlmsvc_put_lockowner().
> > > > > > > >
> > > > > > > > The proposed solution is to intentionally clear fl_lmops po=
inter to
> > > > > > > > make sure that if there is a conflict (be it a local file s=
ystem
> > > > > > > > or reexport), lock_release_private() would not call
> > > > > > > > nlmsvc_put_lockowner().
> > > > > > > >
> > > > > > > > kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > kernel: BUG: KASAN: slab-use-after-free in nlmsvc_put_locko=
wner+0x30/0x250 [lockd]
> > > > > > > > kernel: Read of size 4 at addr ffff0000bf3bca10 by task loc=
kd/6092
> > > > > > > > kernel:
> > > > > > > > kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump: loaded N=
ot tainted 6.18.0-rc1+ #23 PREEMPT(voluntary)
> > > > > > > > kernel: Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS V=
MW201.00V.24006586.BA64.2406042154 06/04/2024
> > > > > > > > kernel: Call trace:
> > > > > > > > kernel:  show_stack+0x34/0x98 (C)
> > > > > > > > kernel:  dump_stack_lvl+0x80/0xa8
> > > > > > > > kernel:  print_address_description.constprop.0+0x90/0x310
> > > > > > > > kernel:  print_report+0x108/0x1f8
> > > > > > > > kernel:  kasan_report+0xc8/0x120
> > > > > > > > kernel:  kasan_check_range+0xe8/0x190
> > > > > > > > kernel:  __kasan_check_read+0x20/0x30
> > > > > > > > kernel:  nlmsvc_put_lockowner+0x30/0x250 [lockd]
> > > > > > > > kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
> > > > > > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > > > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > > > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > > > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > > > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > > > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > > > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > > > > > kernel:  kthread+0x2f8/0x398
> > > > > > > > kernel:  ret_from_fork+0x10/0x20
> > > > > > > > kernel:
> > > > > > > > kernel: Allocated by task 6092:
> > > > > > > > kernel:  kasan_save_stack+0x3c/0x70
> > > > > > > > kernel:  kasan_save_track+0x20/0x40
> > > > > > > > kernel:  kasan_save_alloc_info+0x40/0x58
> > > > > > > > kernel:  __kasan_kmalloc+0xd4/0xd8
> > > > > > > > kernel:  __kmalloc_cache_noprof+0x1a8/0x5c0
> > > > > > > > kernel:  nlmsvc_locks_init_private+0xe4/0x520 [lockd]
> > > > > > > > kernel:  nlm4svc_retrieve_args+0x38c/0x530 [lockd]
> > > > > > > > kernel:  __nlm4svc_proc_test+0x194/0x318 [lockd]
> > > > > > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > > > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > > > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > > > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > > > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > > > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > > > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > > > > > kernel:  kthread+0x2f8/0x398
> > > > > > > > kernel:  ret_from_fork+0x10/0x20
> > > > > > > > kernel:
> > > > > > > > kernel: Freed by task 6092:
> > > > > > > > kernel:  kasan_save_stack+0x3c/0x70
> > > > > > > > kernel:  kasan_save_track+0x20/0x40
> > > > > > > > kernel:  __kasan_save_free_info+0x4c/0x80
> > > > > > > > kernel:  __kasan_slab_free+0x88/0xc0
> > > > > > > > kernel:  kfree+0x110/0x480
> > > > > > > > kernel:  nlmsvc_put_lockowner+0x1b4/0x250 [lockd]
> > > > > > > > kernel:  nlmsvc_put_owner+0x18/0x30 [lockd]
> > > > > > > > kernel:  locks_release_private+0x190/0x2a8
> > > > > > > > kernel:  nlmsvc_testlock+0x2e0/0x648 [lockd]
> > > > > > > > kernel:  __nlm4svc_proc_test+0x244/0x318 [lockd]
> > > > > > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > > > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > > > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > > > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > > > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > > > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > > > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > > > > > kernel:  kthread+0x2f8/0x398
> > > > > > > > kernel:  ret_from_fork+0x10/0x20
> > > > > > > > kernel:
> > > > > > > > kernel: The buggy address belongs to the object at ffff0000=
bf3bca00
> > > > > > > >         which belongs to the cache kmalloc-64 of size 64
> > > > > > > > kernel: The buggy address is located 16 bytes inside of
> > > > > > > >         freed 64-byte region [ffff0000bf3bca00, ffff0000bf3=
bca40)
> > > > > > > > kernel:
> > > > > > > > kernel: The buggy address belongs to the physical page:
> > > > > > > > kernel: page: refcount:0 mapcount:0 mapping:000000000000000=
0 index:0x0 pfn:0x13f3bc
> > > > > > > > kernel: flags: 0x2fffff00000000(node=3D0|zone=3D2|lastcpupi=
d=3D0xfffff)
> > > > > > > > kernel: page_type: f5(slab)
> > > > > > > > kernel: raw: 002fffff00000000 ffff0000800028c0 dead00000000=
0122 0000000000000000
> > > > > > > > kernel: raw: 0000000000000000 0000000080200020 00000000f500=
0000 0000000000000000
> > > > > > > > kernel: page dumped because: kasan: bad access detected
> > > > > > > > kernel:
> > > > > > > > kernel: Memory state around the buggy address:
> > > > > > > > kernel:  ffff0000bf3bc900: fa fb fb fb fb fb fb fb fc fc fc=
 fc fc fc fc fc
> > > > > > > > kernel:  ffff0000bf3bc980: fa fb fb fb fb fb fb fb fc fc fc=
 fc fc fc fc fc
> > > > > > > > kernel: >ffff0000bf3bca00: fa fb fb fb fb fb fb fb fc fc fc=
 fc fc fc fc fc
> > > > > > > > kernel:                          ^
> > > > > > > > kernel:  ffff0000bf3bca80: fa fb fb fb fb fb fb fb fc fc fc=
 fc fc fc fc fc
> > > > > > > > kernel:  ffff0000bf3bcb00: fc fc fc fc fc fc fc fc fc fc fc=
 fc fc fc fc fc
> > > > > > > > kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > kernel: Disabling lock debugging due to kernel taint
> > > > > > > > kernel: AGLO: nlmsvc_put_lockowner 00000000028055fb count=
=3D0
> > > > > > > > kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump: loaded T=
ainted: G    B               6.18.0-rc1+ #23 PREEMPT(voluntary)
> > > > > > > > kernel: Tainted: [B]=3DBAD_PAGE
> > > > > > > > kernel: Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS V=
MW201.00V.24006586.BA64.2406042154 06/04/2024
> > > > > > > > kernel: Call trace:
> > > > > > > > kernel:  show_stack+0x34/0x98 (C)
> > > > > > > > kernel:  dump_stack_lvl+0x80/0xa8
> > > > > > > > kernel:  dump_stack+0x1c/0x30
> > > > > > > > kernel:  nlmsvc_put_lockowner+0x7c/0x250 [lockd]
> > > > > > > > kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
> > > > > > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > > > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > > > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > > > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > > > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > > > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > > > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > > > > > kernel:  kthread+0x2f8/0x398
> > > > > > > > kernel:  ret_from_fork+0x10/0x20
> > > > > > > > kernel: ------------[ cut here ]------------
> > > > > > > > kernel: refcount_t: underflow; use-after-free.
> > > > > > > > kernel: WARNING: CPU: 0 PID: 6092 at lib/refcount.c:87 refc=
ount_dec_not_one+0x198/0x1b0
> > > > > > > > kernel: Modules linked in: rpcrdma rdma_cm iw_cm ib_cm ib_c=
ore nfsd nfsv3 nfs_acl nfs lockd grace nfs_localio netfs ext4 crc16 mbcache=
 jbd2 overlay uinput snd_seq_dummy snd_hrtimer qrtr rfkill vfat fat uvcvide=
o snd_hda_codec_generic videobuf2_vmalloc videobuf2_memops uvc snd_hda_inte=
l videobuf2_v4l2 videobuf2_common snd_intel_dspcfg videodev snd_hda_codec s=
nd_hda_core mc snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd sound=
core sg loop auth_rpcgss vsock_loopback vmw_vsock_virtio_transport_common v=
mw_vsock_vmci_transport vmw_vmci vsock xfs 8021q garp stp llc mrp nvme nvme=
_core nvme_keyring nvme_auth ghash_ce hkdf e1000e sr_mod cdrom vmwgfx drm_t=
tm_helper ttm sunrpc dm_mirror dm_region_hash dm_log iscsi_tcp libiscsi_tcp=
 libiscsi scsi_transport_iscsi fuse dm_multipath dm_mod nfnetlink
> > > > > > > > kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump: loaded T=
ainted: G    B               6.18.0-rc1+ #23 PREEMPT(voluntary)
> > > > > > > > kernel: Tainted: [B]=3DBAD_PAGE
> > > > > > > > kernel: Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS V=
MW201.00V.24006586.BA64.2406042154 06/04/2024
> > > > > > > > kernel: pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SS=
BS BTYPE=3D--)
> > > > > > > > kernel: pc : refcount_dec_not_one+0x198/0x1b0
> > > > > > > > kernel: lr : refcount_dec_not_one+0x198/0x1b0
> > > > > > > > kernel: sp : ffff80008a627930
> > > > > > > > kernel: x29: ffff80008a627990 x28: ffff0000bf3bca00 x27: ff=
ff0000ba5c7000
> > > > > > > > kernel: x26: 1fffe000191eeb84 x25: 1ffff000114c4f48 x24: ff=
ff0000c8f75c24
> > > > > > > > kernel: x23: 0000000000000007 x22: ffff80008a627950 x21: 1f=
fff000114c4f26
> > > > > > > > kernel: x20: 00000000ffffffff x19: ffff0000bf3bca10 x18: 00=
00000000000310
> > > > > > > > kernel: x17: 0000000000000000 x16: 0000000000000000 x15: 00=
00000000000000
> > > > > > > > kernel: x14: 0000000000000000 x13: 0000000000000001 x12: ff=
ff60004fd90aa3
> > > > > > > > kernel: x11: 1fffe0004fd90aa2 x10: ffff60004fd90aa2 x9 : df=
ff800000000000
> > > > > > > > kernel: x8 : 00009fffb026f55e x7 : ffff00027ec85513 x6 : 00=
00000000000001
> > > > > > > > kernel: x5 : ffff00027ec85510 x4 : ffff60004fd90aa3 x3 : ff=
ff800080787bc0
> > > > > > > > kernel: x2 : 0000000000000000 x1 : 0000000000000000 x0 : ff=
ff0000a75a8000
> > > > > > > > kernel: Call trace:
> > > > > > > > kernel:  refcount_dec_not_one+0x198/0x1b0 (P)
> > > > > > > > kernel:  refcount_dec_and_lock+0x1c/0xb8
> > > > > > > > kernel:  nlmsvc_put_lockowner+0x9c/0x250 [lockd]
> > > > > > > > kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
> > > > > > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > > > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > > > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > > > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > > > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > > > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > > > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > > > > > kernel:  kthread+0x2f8/0x398
> > > > > > > > kernel:  ret_from_fork+0x10/0x20
> > > > > > > > kernel: ---[ end trace 0000000000000000 ]---
> > > > > > > >
> > > > > > > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > > > > > > ---
> > > > > > > >  fs/lockd/svclock.c | 1 +
> > > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > >
> > > > > > > > diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> > > > > > > > index a31dc9588eb8..1dd0fec186de 100644
> > > > > > > > --- a/fs/lockd/svclock.c
> > > > > > > > +++ b/fs/lockd/svclock.c
> > > > > > > > @@ -652,6 +652,7 @@ nlmsvc_testlock(struct svc_rqst *rqstp,=
 struct nlm_file *file,
> > > > > > > >       conflock->fl.c.flc_type =3D lock->fl.c.flc_type;
> > > > > > > >       conflock->fl.fl_start =3D lock->fl.fl_start;
> > > > > > > >       conflock->fl.fl_end =3D lock->fl.fl_end;
> > > > > > > > +     conflock->fl.fl_lmops =3D NULL;
> > > > > > > >       locks_release_private(&lock->fl);
> > > > > > > >
> > > > > > > >       ret =3D nlm_lck_denied;
> > > > > > >
> > > > > > > The problem sounds real, but I'm not sure I like this solutio=
n.
> > > > > >
> > > > > > I have no claim that this solution is the best. I was contempla=
ting on
> > > > > > setting this to NULL only in the case when ->f_ops->lock() is N=
ULL
> > > > > > thus restricting it to the path that does not call posix_test_l=
ock().
> > > > > >
> > > > > > > It seems like this is gaming the refcounting such that we tak=
e a
> > > > > > > reference in locks_copy_conflock() but then you zero out fl_l=
mops
> > > > > > > before that reference can be put.
> > > > > >
> > > > > > IF lock_copy_conflock() is called then fl_lmops is already NULL=
.
> > > > > >
> > > > > > Let me try to lay out the sequence of steps for both cases.
> > > > > >
> > > > > > Reexport
> > > > > > 1. when nlmsvc_test_lock() is called file->f_file[mode]->f_ops-=
>lock
> > > > > > is set (fl_lmops is set too) prior to calling vfs_test_lock.
> > > > > > 2. Because ->lock is set vfs_test_lock() calls the ->lock funct=
ion
> > > > > > (instead of posix_test_lock)
> > > > > > 3. After vfs_test_lock() fl_lmops is still set so lock_release_=
private
> > > > > > is called and calls nlmscv_put_lockowner().
> > > > > >
> > > > > > Normal export
> > > > > > 1. when nlmsvc_test_lock() is called ->lock is not set (fl_lmop=
s is
> > > > > > set) prior to calling vfs_test_lock
> > > > > > 2. Because -> is not set posix_test_lock() is called which will=
 call
> > > > > > local_copy_conflock() which will set fl_lmops to NULL.
> > > > > > 3. Since fl_lmops is NULL put_lockowner isn't called.
> > > > > >
> > > > > > Reexport is where I'm hazy. I'm assuming that reexported server=
 opened
> > > > > > a file and the "file" is the NFS file object and that's why
> > > > > > file->f_file[mode]->f_ops->lock is set? So perhaps if we take t=
he
> > > > > > presence of ->lock to mean reexport, we can do as I did (ie., s=
et
> > > > > > fl_lmops to null), or maybe we can take an extra reference know=
ing
> > > > > > that we'd need to put it in lock_release_private() ( -- this
> > > > > > suggestion ties to your next question). I don't see any differe=
nce to
> > > > > > either setting it to NULL or taking an extra reference for when
> > > > > > ->lock() is set . Both are confusing and I would say warrant a =
comment
> > > > > > for why we are doing it.
> > > > > >
> > > > >
> > > > > To be clear, there is nothing "special" about NFS reexport here. =
The
> > > > > NFS client just has some limitations as to what it can do when it=
's
> > > > > being (re)exported. Exporting other sorts of network or clustered
> > > > > filesystems can also be problematic for similar reasons.
> > > > >
> > > > > So, we should focus on making this generically work, and not take=
 -
> > > > > > lock being set to mean that this is an NFS reexport.
> > > >
> > > > I guess it doesn't matter what kind of re-export but the fact that =
if
> > > > ->lock is set we know that posix_test_lock and then
> > > > local_copy_conflock won't be called and thus there is a great chanc=
e
> > > > that fl_lmops will still be set on return from vfs_test_lock().
> > > >
> > > > > A question: you mentioned this is a reexporting server. Are you
> > > > > reexporting an NFSv4 mount as NFSv3? Or is this a v3->v3 reexport=
?
> > > >
> > > > v3->v3 reexport.
> > > >
> > > >
> > >
> > > Ok, looking now:
> > >
> > > The test_owner in __nlm4svc_proc_test() comes from the args, which
> > > happens during the decode phase. That gets a valid reference to an NL=
M
> > > lockowner in nlmsvc_locks_init_private(). Therefore, this call in
> > > __nlm4svc_proc_test() seems legit.
> > >
> > >         nlmsvc_put_lockowner(test_owner);
> > >
> > > Now, between those two gets/puts, there is the call to vfs_test_lock(=
)
> > > in nlmsvc_testlock(). That uses the same file_lock argument structure
> > > to represent both the lock and the conflock.
> > >
> > >         error =3D vfs_test_lock(file->f_file[mode], &lock->fl);
> > >
> > > ...so the flc_owner field at this point is still set to the (original=
)
> > > nlmclient's owner.
> > >
> > > In this case, that call ends up calling down in nlmclnt_test(), which
> > > ignores the flc_owner field. It also ends up overwriting the other
> > > fields in &fl with conflock info.
> > >
> > > I think the bug is actually there. Before nlmclnt_test() overwrites t=
he
> > > fields in "fl", it needs to release the owner reference (and zero out
> > > the owner). Would this patch fix the bug?
> > >
> > > ---------------------8------------------------
> > >
> > > diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
> > > index cebcc283b7ce..200309ee1a74 100644
> > > --- a/fs/lockd/clntproc.c
> > > +++ b/fs/lockd/clntproc.c
> > > @@ -438,6 +438,8 @@ nlmclnt_test(struct nlm_rqst *req, struct file_lo=
ck
> > > *fl)
> > >         if (status < 0)
> > >                 goto out;
> > >
> > > +       locks_release_private(&fl);
> > > +
> > >         switch (req->a_res.status) {
> > >                 case nlm_granted:
> > >                         fl->c.flc_type =3D F_UNLCK;
> >
> >
> > Sorry, I take it back. That alone won't fix it because of the pointer-
> > saving shenanigans in __nlm4svc_proc_test. We'll need to do this a bit
> > more carefully, I think.
>
> How about this patch? The changelog still needs some work, but I think
> this is the most correct way to handle it:
>
> -------------------------8<----------------------------
>
> [PATCH] nlm: fix handling of conflocks by NLM
>
> The handling of conflocks can result in a refcount overput on the
> flc_owner in the case of a reexported NFSv3 fs.
>
> lockd will pass down a file_lock structure in its arguments with
> flc_owner set to an NLM owner and a valid reference. Once that gets
> down to the reexported NFS client, it will ignore that field and leave
> it intact when copying in conflock info.
>
> The NLM server code will then end up releasing the conflock, and then
> releasing the one from the arguments, not realizing that the lock has
> already been released.
>
> The owner info in the arguments to vfs_test_lock() is there to give
> information about the requestor. Once nlmclnt_test() is going to copy in
> the conflock info however, it needs to release the old owner.
>
> Have nlmclnt_test() do call locks_release_private() after testing the
> lock to release any info that was in the old file_lock structure.
>
> This creates another problem: __nlm4svc_proc_test() and
> __nlmsvc_proc_test() both call nlmsvc_put_lockowner() unconditionally on
> the original lockowner that it got from decoding the args. Switch them
> both to just call locks_release_private() on &argp->lock instead, which
> should handle the case properly where the info in argp->lock has already
> been released.
>
> With that changed, we can also eliminate the call to
> locks_release_private() in nlmsvc_testlock() since the callers will now
> handle that.
>
> Reported-by: Olga Kornievskaia <aglo@umich.edu>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/lockd/clntproc.c | 3 +++
>  fs/lockd/svc4proc.c | 4 +---
>  fs/lockd/svclock.c  | 1 -
>  fs/lockd/svcproc.c  | 5 +----
>  4 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
> index cebcc283b7ce..d3dd04137677 100644
> --- a/fs/lockd/clntproc.c
> +++ b/fs/lockd/clntproc.c
> @@ -438,6 +438,9 @@ nlmclnt_test(struct nlm_rqst *req, struct file_lock *=
fl)
>         if (status < 0)
>                 goto out;
>
> +       /* Release any references held by fl before copying in conflock i=
nfo */
> +       locks_release_private(fl);
> +
>         switch (req->a_res.status) {
>                 case nlm_granted:
>                         fl->c.flc_type =3D F_UNLCK;
> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> index 109e5caae8c7..cbfec12296a4 100644
> --- a/fs/lockd/svc4proc.c
> +++ b/fs/lockd/svc4proc.c
> @@ -97,7 +97,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_=
res *resp)
>         struct nlm_args *argp =3D rqstp->rq_argp;
>         struct nlm_host *host;
>         struct nlm_file *file;
> -       struct nlm_lockowner *test_owner;
>         __be32 rc =3D rpc_success;
>
>         dprintk("lockd: TEST4        called\n");
> @@ -107,7 +106,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nl=
m_res *resp)
>         if ((resp->status =3D nlm4svc_retrieve_args(rqstp, argp, &host, &=
file)))
>                 return resp->status =3D=3D nlm_drop_reply ? rpc_drop_repl=
y :rpc_success;
>
> -       test_owner =3D argp->lock.fl.c.flc_owner;
>         /* Now check for conflicting locks */
>         resp->status =3D nlmsvc_testlock(rqstp, file, host, &argp->lock,
>                                        &resp->lock);
> @@ -116,7 +114,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nl=
m_res *resp)
>         else
>                 dprintk("lockd: TEST4        status %d\n", ntohl(resp->st=
atus));
>
> -       nlmsvc_put_lockowner(test_owner);
> +       locks_release_private(&argp->lock.fl);
>         nlmsvc_release_host(host);
>         nlm_release_file(file);
>         return rc;

Aren't these svc4proc changes defeat the purpose of the following commit:

commit 184cefbe62627730c30282df12bcff9aae4816ea
Author: Benjamin Coddington <bcodding@redhat.com>
Date:   Mon Jun 13 09:40:06 2022 -0400

    NLM: Defend against file_lock changes after vfs_test_lock()

    Instead of trusting that struct file_lock returns completely unchanged
    after vfs_test_lock() when there's no conflicting lock, stash away our
    nlm_lockowner reference so we can properly release it for all cases.


    This defends against another file_lock implementation overwriting fl_ow=
ner
    when the return type is F_UNLCK.

Not that they are the cause of the crash but I would imagine it would
cause a problem fixed by the patch....

> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index a31dc9588eb8..7ff3d75a5ca3 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -652,7 +652,6 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_fi=
le *file,
>         conflock->fl.c.flc_type =3D lock->fl.c.flc_type;
>         conflock->fl.fl_start =3D lock->fl.fl_start;
>         conflock->fl.fl_end =3D lock->fl.fl_end;
> -       locks_release_private(&lock->fl);
>
>         ret =3D nlm_lck_denied;
>  out:
> diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
> index f53d5177f267..6f3e669a3532 100644
> --- a/fs/lockd/svcproc.c
> +++ b/fs/lockd/svcproc.c
> @@ -117,7 +117,6 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm=
_res *resp)
>         struct nlm_args *argp =3D rqstp->rq_argp;
>         struct nlm_host *host;
>         struct nlm_file *file;
> -       struct nlm_lockowner *test_owner;
>         __be32 rc =3D rpc_success;
>
>         dprintk("lockd: TEST          called\n");
> @@ -127,8 +126,6 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm=
_res *resp)
>         if ((resp->status =3D nlmsvc_retrieve_args(rqstp, argp, &host, &f=
ile)))
>                 return resp->status =3D=3D nlm_drop_reply ? rpc_drop_repl=
y :rpc_success;
>
> -       test_owner =3D argp->lock.fl.c.flc_owner;
> -
>         /* Now check for conflicting locks */
>         resp->status =3D cast_status(nlmsvc_testlock(rqstp, file, host,
>                                                    &argp->lock, &resp->lo=
ck));
> @@ -138,7 +135,7 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm=
_res *resp)
>                 dprintk("lockd: TEST          status %d vers %d\n",
>                         ntohl(resp->status), rqstp->rq_vers);
>
> -       nlmsvc_put_lockowner(test_owner);
> +       locks_release_private(&argp->lock.fl);
>         nlmsvc_release_host(host);
>         nlm_release_file(file);
>         return rc;
> --
> 2.51.0
>

