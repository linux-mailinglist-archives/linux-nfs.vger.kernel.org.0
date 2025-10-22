Return-Path: <linux-nfs+bounces-15526-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85F2BFDB76
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 19:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFCD73A0F8A
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 17:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2988135B154;
	Wed, 22 Oct 2025 17:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="QK3SQguL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06592DEA79
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155578; cv=none; b=sgK8KkE8vP823ApNRq8zTu8fRv0y/G3Ow4W/D+Sd3lVT685IgOUPe4IeaX9NA07AnqVGISdnReh10+pWbVSEYk9MvC0Cbmq6VfCCPjObQkI063qGjlgPNjfV0Mw+kFCvSppUCddqmMg8xb9PeyY9jsIix418+e2NY9uRzA/y6l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155578; c=relaxed/simple;
	bh=NGfVEODzAD8oX/Z0RKdVnLCwRWHuBPVR2Yr3nBvXFaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HWkDeVud3ToYE/T3VfmA2Vcl7uCkRMM1wiL45DOirNLDaznjMLkn5TK1POCkFy3z2MQmN4lbDhJiUYkL4ODJY8t67m2gmQxkKTHxo8yUGrXOtkkAGxp1yxyn8n+n9c1Ez7XvJAG414900oUsa9AGTlgypFhwiEWQ+zCiA6umfYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=QK3SQguL; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3612c38b902so69396081fa.2
        for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 10:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1761155573; x=1761760373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/I2MJ7NTdQtCEnWsc7dB8cOZyVkfT5dt19/E3UoLrY=;
        b=QK3SQguLJydAdpSHzxWCFg2VV5NvHp0u5NXLrnyDe0yanY64tdsk1tfvOSxNrVY7oc
         Lk72+BwMQrhLBXDzLTdKUAYaJDKGORSMJEFuQIp0u6xCKIU4Zdkr9XWZ6BlRYsgxYc7v
         zfY4tp6FeDJdomH1v9GWoZwk6tqxGM5dVVDc+rtA6/TbxLsIioe3Oxzra5zraUmPAX4F
         GariO+g9sMX78gwLo2mBruIBBqOEOiWAJW+4AqQ3C27kUUmoS0IHiuzoCEKLst4/VjLv
         SZWANJ6WqJBSWZlMarvqeU1JSmmySPKI+gaavAsHPJLcVIjtovWE01N+qWnF+sLJJuBi
         dmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761155573; x=1761760373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/I2MJ7NTdQtCEnWsc7dB8cOZyVkfT5dt19/E3UoLrY=;
        b=DmopUPPRhW+Ofh5FqsKgBuwihz2ha9NVMWtKFx0cJNGhvzPw1FwFoanwZ/E1WvTk8U
         /aG8w4HEPv1kgY1I6qj9b3QogCScRAD2mE6u5LWGgmVaenoj9tOdDn+4NzlN6VH3vSr2
         y4lVYVuA+7VCaqaESzsEVnY2I8F0Lxn5Ts1FBR8Yt3NaPerpHMpxS9Zb3MPenOViWfSR
         rot7+zWMOWeEsJy+9469aEkfEeQw8mnh5dQxxiPpmModU61A5H51d68n9WUxeXACYSIY
         71CMgsB/0RhPZBHDNNHUn+0EuRFsdiPMYNlTQBpyCnYRNcnvyw/3ua5JC4WEndPn73WZ
         gBmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXQJZiPwU057/TnZFwGjRqtn6BdBo4Qhb8bCvFtitcUGopoWtTMHq5gJ9zow5KWFBnAIxWJqjVkVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOxxhg25HqTevd+o0K3/jxQ7qeRSZT77QSoNJgrhsN0knr9RHJ
	hWrefzmcrZQN9uAlM/NNomDcwhFDdXKL08sfn8ZdvjU+1RBD2T1PMRwRhyzlVVdL0AU5ig+grdm
	p3KbYYACwb5tpYQizq41vuBOpOL12CEc=
X-Gm-Gg: ASbGncsi/gntmVHxS2I3JHkNj//FchqQakj8rWjbAYYD5MFgiLwjF7SVK4nVTjZBSDL
	ucmXMk42acfgQ7+Whv5KG7QE7FSJbEXj5/lIrXrDtYVUK4GvPY6iWBCWlBYTe3VwSugcTehxzHK
	lJ9Y0wrzkyFoZQTwZ2uhdWmwyiuwEihfNIPEtIJOvSa4GQSot1d+zaWrh6C5DdaWaKfn0I6ERbe
	+bcGoxRCfiStiBpWe8ug5Be8ETPqaTL8wfnYXMH2SoMxeO1BbfQbt0SVJXDE0pHMYfurm1sqAI5
	W2xe9GKjAQP2aOmgwaFp2xmhqwjwoQ==
X-Google-Smtp-Source: AGHT+IGM330nNlt/QwModl5aTajJ/2vGV3LYXzlEPNKFhUnNqLfinnrwtU9xYbPqWl//sXUGmCeRWsCiM5qOyoYGCP8=
X-Received: by 2002:a05:651c:3256:10b0:378:d24d:c717 with SMTP id
 38308e7fff4ca-378d24dcbe0mr3609861fa.7.1761155572377; Wed, 22 Oct 2025
 10:52:52 -0700 (PDT)
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
 <CAN-5tyGyhQnymw4ADGGsjvgTNfKOxTYhYGDW2MNYsO7RQm9EXw@mail.gmail.com>
 <e7acca30361191a6a5262217942eb770de328404.camel@kernel.org>
 <CAN-5tyEp8wNwHhWR=kxeLjM+v=nt3GHHFy+C4=7UUARb3oxbHA@mail.gmail.com> <1d03bcf3b1adc51559b81027ea6ba9ac66f35ebd.camel@kernel.org>
In-Reply-To: <1d03bcf3b1adc51559b81027ea6ba9ac66f35ebd.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 22 Oct 2025 13:52:39 -0400
X-Gm-Features: AS18NWCs1qvdyXCh-_pS5VRTLtNkutsHWm0h1cS36MTNlNcPgwLX6zD-mUIJxzU
Message-ID: <CAN-5tyHQ0G+-_t7QvVaGPpYbgEP6Zf1Cypr3VEO9fHho2d-1uw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] lockd: prevent UAF in nlm4svc_proc_test in
 reexport NLM
To: Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, linux-nfs@vger.kernel.org, 
	neilb@brown.name, Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 11:57=E2=80=AFAM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Wed, 2025-10-22 at 09:33 -0400, Olga Kornievskaia wrote:
> > On Tue, Oct 21, 2025 at 4:22=E2=80=AFPM Jeff Layton <jlayton@kernel.org=
> wrote:
> > >
> > > On Tue, 2025-10-21 at 15:24 -0400, Olga Kornievskaia wrote:
> > > > On Tue, Oct 21, 2025 at 1:45=E2=80=AFPM Jeff Layton <jlayton@kernel=
.org> wrote:
> > > > >
> > > > > On Tue, 2025-10-21 at 13:15 -0400, Jeff Layton wrote:
> > > > > > On Tue, 2025-10-21 at 13:03 -0400, Jeff Layton wrote:
> > > > > > > On Tue, 2025-10-21 at 12:17 -0400, Olga Kornievskaia wrote:
> > > > > > > > On Tue, Oct 21, 2025 at 11:59=E2=80=AFAM Jeff Layton <jlayt=
on@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, 2025-10-21 at 11:23 -0400, Olga Kornievskaia wrot=
e:
> > > > > > > > > > On Tue, Oct 21, 2025 at 9:40=E2=80=AFAM Jeff Layton <jl=
ayton@kernel.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Tue, 2025-10-21 at 09:05 -0400, Olga Kornievskaia =
wrote:
> > > > > > > > > > > > When knfsd is a reexport nfs server, it nlm4svc_pro=
c_test() in
> > > > > > > > > > > > calling nlmsvc_testlock() with a lock conflict lock=
_release_private()
> > > > > > > > > > > > call would end up calling nlmsvc_put_lockowner() an=
d then back in
> > > > > > > > > > > > nlm4svc_proc_test() function there will be another =
call to
> > > > > > > > > > > > nlmsvc_put_lockowner() for the same owner leading t=
o use-after-free
> > > > > > > > > > > > violation (below).
> > > > > > > > > > > >
> > > > > > > > > > > > The problem only arises when the underlying file sy=
stem has been
> > > > > > > > > > > > re-exported as different paths are taken in vfs_tes=
t_lock().
> > > > > > > > > > > > When it's reexport, filp->f_op->lock is set and whe=
n vfs_test_lock()
> > > > > > > > > > > > is done fl_lmops pointer is non-null. When it's reg=
ular export,
> > > > > > > > > > > > vfs_test_lock() calls posix_test_lock() which ends =
up calling
> > > > > > > > > > > > locks_copy_conflock() and it copies NULL into fl_lm=
ops and then
> > > > > > > > > > > > calling into lock_release_private() does not call
> > > > > > > > > > > > nlmsvc_put_lockowner().
> > > > > > > > > > > >
> > > > > > > > > > > > The proposed solution is to intentionally clear fl_=
lmops pointer to
> > > > > > > > > > > > make sure that if there is a conflict (be it a loca=
l file system
> > > > > > > > > > > > or reexport), lock_release_private() would not call
> > > > > > > > > > > > nlmsvc_put_lockowner().
> > > > > > > > > > > >
> > > > > > > > > > > > kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > > > > > > > > > > > kernel: BUG: KASAN: slab-use-after-free in nlmsvc_p=
ut_lockowner+0x30/0x250 [lockd]
> > > > > > > > > > > > kernel: Read of size 4 at addr ffff0000bf3bca10 by =
task lockd/6092
> > > > > > > > > > > > kernel:
> > > > > > > > > > > > kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump: =
loaded Not tainted 6.18.0-rc1+ #23 PREEMPT(voluntary)
> > > > > > > > > > > > kernel: Hardware name: VMware, Inc. VMware20,1/VBSA=
, BIOS VMW201.00V.24006586.BA64.2406042154 06/04/2024
> > > > > > > > > > > > kernel: Call trace:
> > > > > > > > > > > > kernel:  show_stack+0x34/0x98 (C)
> > > > > > > > > > > > kernel:  dump_stack_lvl+0x80/0xa8
> > > > > > > > > > > > kernel:  print_address_description.constprop.0+0x90=
/0x310
> > > > > > > > > > > > kernel:  print_report+0x108/0x1f8
> > > > > > > > > > > > kernel:  kasan_report+0xc8/0x120
> > > > > > > > > > > > kernel:  kasan_check_range+0xe8/0x190
> > > > > > > > > > > > kernel:  __kasan_check_read+0x20/0x30
> > > > > > > > > > > > kernel:  nlmsvc_put_lockowner+0x30/0x250 [lockd]
> > > > > > > > > > > > kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
> > > > > > > > > > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > > > > > > > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > > > > > > > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > > > > > > > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > > > > > > > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > > > > > > > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > > > > > > > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > > > > > > > > > kernel:  kthread+0x2f8/0x398
> > > > > > > > > > > > kernel:  ret_from_fork+0x10/0x20
> > > > > > > > > > > > kernel:
> > > > > > > > > > > > kernel: Allocated by task 6092:
> > > > > > > > > > > > kernel:  kasan_save_stack+0x3c/0x70
> > > > > > > > > > > > kernel:  kasan_save_track+0x20/0x40
> > > > > > > > > > > > kernel:  kasan_save_alloc_info+0x40/0x58
> > > > > > > > > > > > kernel:  __kasan_kmalloc+0xd4/0xd8
> > > > > > > > > > > > kernel:  __kmalloc_cache_noprof+0x1a8/0x5c0
> > > > > > > > > > > > kernel:  nlmsvc_locks_init_private+0xe4/0x520 [lock=
d]
> > > > > > > > > > > > kernel:  nlm4svc_retrieve_args+0x38c/0x530 [lockd]
> > > > > > > > > > > > kernel:  __nlm4svc_proc_test+0x194/0x318 [lockd]
> > > > > > > > > > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > > > > > > > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > > > > > > > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > > > > > > > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > > > > > > > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > > > > > > > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > > > > > > > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > > > > > > > > > kernel:  kthread+0x2f8/0x398
> > > > > > > > > > > > kernel:  ret_from_fork+0x10/0x20
> > > > > > > > > > > > kernel:
> > > > > > > > > > > > kernel: Freed by task 6092:
> > > > > > > > > > > > kernel:  kasan_save_stack+0x3c/0x70
> > > > > > > > > > > > kernel:  kasan_save_track+0x20/0x40
> > > > > > > > > > > > kernel:  __kasan_save_free_info+0x4c/0x80
> > > > > > > > > > > > kernel:  __kasan_slab_free+0x88/0xc0
> > > > > > > > > > > > kernel:  kfree+0x110/0x480
> > > > > > > > > > > > kernel:  nlmsvc_put_lockowner+0x1b4/0x250 [lockd]
> > > > > > > > > > > > kernel:  nlmsvc_put_owner+0x18/0x30 [lockd]
> > > > > > > > > > > > kernel:  locks_release_private+0x190/0x2a8
> > > > > > > > > > > > kernel:  nlmsvc_testlock+0x2e0/0x648 [lockd]
> > > > > > > > > > > > kernel:  __nlm4svc_proc_test+0x244/0x318 [lockd]
> > > > > > > > > > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > > > > > > > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > > > > > > > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > > > > > > > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > > > > > > > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > > > > > > > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > > > > > > > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > > > > > > > > > kernel:  kthread+0x2f8/0x398
> > > > > > > > > > > > kernel:  ret_from_fork+0x10/0x20
> > > > > > > > > > > > kernel:
> > > > > > > > > > > > kernel: The buggy address belongs to the object at =
ffff0000bf3bca00
> > > > > > > > > > > >         which belongs to the cache kmalloc-64 of si=
ze 64
> > > > > > > > > > > > kernel: The buggy address is located 16 bytes insid=
e of
> > > > > > > > > > > >         freed 64-byte region [ffff0000bf3bca00, fff=
f0000bf3bca40)
> > > > > > > > > > > > kernel:
> > > > > > > > > > > > kernel: The buggy address belongs to the physical p=
age:
> > > > > > > > > > > > kernel: page: refcount:0 mapcount:0 mapping:0000000=
000000000 index:0x0 pfn:0x13f3bc
> > > > > > > > > > > > kernel: flags: 0x2fffff00000000(node=3D0|zone=3D2|l=
astcpupid=3D0xfffff)
> > > > > > > > > > > > kernel: page_type: f5(slab)
> > > > > > > > > > > > kernel: raw: 002fffff00000000 ffff0000800028c0 dead=
000000000122 0000000000000000
> > > > > > > > > > > > kernel: raw: 0000000000000000 0000000080200020 0000=
0000f5000000 0000000000000000
> > > > > > > > > > > > kernel: page dumped because: kasan: bad access dete=
cted
> > > > > > > > > > > > kernel:
> > > > > > > > > > > > kernel: Memory state around the buggy address:
> > > > > > > > > > > > kernel:  ffff0000bf3bc900: fa fb fb fb fb fb fb fb =
fc fc fc fc fc fc fc fc
> > > > > > > > > > > > kernel:  ffff0000bf3bc980: fa fb fb fb fb fb fb fb =
fc fc fc fc fc fc fc fc
> > > > > > > > > > > > kernel: >ffff0000bf3bca00: fa fb fb fb fb fb fb fb =
fc fc fc fc fc fc fc fc
> > > > > > > > > > > > kernel:                          ^
> > > > > > > > > > > > kernel:  ffff0000bf3bca80: fa fb fb fb fb fb fb fb =
fc fc fc fc fc fc fc fc
> > > > > > > > > > > > kernel:  ffff0000bf3bcb00: fc fc fc fc fc fc fc fc =
fc fc fc fc fc fc fc fc
> > > > > > > > > > > > kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > > > > > > > > > > > kernel: Disabling lock debugging due to kernel tain=
t
> > > > > > > > > > > > kernel: AGLO: nlmsvc_put_lockowner 00000000028055fb=
 count=3D0
> > > > > > > > > > > > kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump: =
loaded Tainted: G    B               6.18.0-rc1+ #23 PREEMPT(voluntary)
> > > > > > > > > > > > kernel: Tainted: [B]=3DBAD_PAGE
> > > > > > > > > > > > kernel: Hardware name: VMware, Inc. VMware20,1/VBSA=
, BIOS VMW201.00V.24006586.BA64.2406042154 06/04/2024
> > > > > > > > > > > > kernel: Call trace:
> > > > > > > > > > > > kernel:  show_stack+0x34/0x98 (C)
> > > > > > > > > > > > kernel:  dump_stack_lvl+0x80/0xa8
> > > > > > > > > > > > kernel:  dump_stack+0x1c/0x30
> > > > > > > > > > > > kernel:  nlmsvc_put_lockowner+0x7c/0x250 [lockd]
> > > > > > > > > > > > kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
> > > > > > > > > > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > > > > > > > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > > > > > > > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > > > > > > > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > > > > > > > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > > > > > > > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > > > > > > > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > > > > > > > > > kernel:  kthread+0x2f8/0x398
> > > > > > > > > > > > kernel:  ret_from_fork+0x10/0x20
> > > > > > > > > > > > kernel: ------------[ cut here ]------------
> > > > > > > > > > > > kernel: refcount_t: underflow; use-after-free.
> > > > > > > > > > > > kernel: WARNING: CPU: 0 PID: 6092 at lib/refcount.c=
:87 refcount_dec_not_one+0x198/0x1b0
> > > > > > > > > > > > kernel: Modules linked in: rpcrdma rdma_cm iw_cm ib=
_cm ib_core nfsd nfsv3 nfs_acl nfs lockd grace nfs_localio netfs ext4 crc16=
 mbcache jbd2 overlay uinput snd_seq_dummy snd_hrtimer qrtr rfkill vfat fat=
 uvcvideo snd_hda_codec_generic videobuf2_vmalloc videobuf2_memops uvc snd_=
hda_intel videobuf2_v4l2 videobuf2_common snd_intel_dspcfg videodev snd_hda=
_codec snd_hda_core mc snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer s=
nd soundcore sg loop auth_rpcgss vsock_loopback vmw_vsock_virtio_transport_=
common vmw_vsock_vmci_transport vmw_vmci vsock xfs 8021q garp stp llc mrp n=
vme nvme_core nvme_keyring nvme_auth ghash_ce hkdf e1000e sr_mod cdrom vmwg=
fx drm_ttm_helper ttm sunrpc dm_mirror dm_region_hash dm_log iscsi_tcp libi=
scsi_tcp libiscsi scsi_transport_iscsi fuse dm_multipath dm_mod nfnetlink
> > > > > > > > > > > > kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump: =
loaded Tainted: G    B               6.18.0-rc1+ #23 PREEMPT(voluntary)
> > > > > > > > > > > > kernel: Tainted: [B]=3DBAD_PAGE
> > > > > > > > > > > > kernel: Hardware name: VMware, Inc. VMware20,1/VBSA=
, BIOS VMW201.00V.24006586.BA64.2406042154 06/04/2024
> > > > > > > > > > > > kernel: pstate: 61400005 (nZCv daif +PAN -UAO -TCO =
+DIT -SSBS BTYPE=3D--)
> > > > > > > > > > > > kernel: pc : refcount_dec_not_one+0x198/0x1b0
> > > > > > > > > > > > kernel: lr : refcount_dec_not_one+0x198/0x1b0
> > > > > > > > > > > > kernel: sp : ffff80008a627930
> > > > > > > > > > > > kernel: x29: ffff80008a627990 x28: ffff0000bf3bca00=
 x27: ffff0000ba5c7000
> > > > > > > > > > > > kernel: x26: 1fffe000191eeb84 x25: 1ffff000114c4f48=
 x24: ffff0000c8f75c24
> > > > > > > > > > > > kernel: x23: 0000000000000007 x22: ffff80008a627950=
 x21: 1ffff000114c4f26
> > > > > > > > > > > > kernel: x20: 00000000ffffffff x19: ffff0000bf3bca10=
 x18: 0000000000000310
> > > > > > > > > > > > kernel: x17: 0000000000000000 x16: 0000000000000000=
 x15: 0000000000000000
> > > > > > > > > > > > kernel: x14: 0000000000000000 x13: 0000000000000001=
 x12: ffff60004fd90aa3
> > > > > > > > > > > > kernel: x11: 1fffe0004fd90aa2 x10: ffff60004fd90aa2=
 x9 : dfff800000000000
> > > > > > > > > > > > kernel: x8 : 00009fffb026f55e x7 : ffff00027ec85513=
 x6 : 0000000000000001
> > > > > > > > > > > > kernel: x5 : ffff00027ec85510 x4 : ffff60004fd90aa3=
 x3 : ffff800080787bc0
> > > > > > > > > > > > kernel: x2 : 0000000000000000 x1 : 0000000000000000=
 x0 : ffff0000a75a8000
> > > > > > > > > > > > kernel: Call trace:
> > > > > > > > > > > > kernel:  refcount_dec_not_one+0x198/0x1b0 (P)
> > > > > > > > > > > > kernel:  refcount_dec_and_lock+0x1c/0xb8
> > > > > > > > > > > > kernel:  nlmsvc_put_lockowner+0x9c/0x250 [lockd]
> > > > > > > > > > > > kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
> > > > > > > > > > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > > > > > > > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > > > > > > > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > > > > > > > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > > > > > > > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > > > > > > > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > > > > > > > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > > > > > > > > > kernel:  kthread+0x2f8/0x398
> > > > > > > > > > > > kernel:  ret_from_fork+0x10/0x20
> > > > > > > > > > > > kernel: ---[ end trace 0000000000000000 ]---
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.c=
om>
> > > > > > > > > > > > ---
> > > > > > > > > > > >  fs/lockd/svclock.c | 1 +
> > > > > > > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.=
c
> > > > > > > > > > > > index a31dc9588eb8..1dd0fec186de 100644
> > > > > > > > > > > > --- a/fs/lockd/svclock.c
> > > > > > > > > > > > +++ b/fs/lockd/svclock.c
> > > > > > > > > > > > @@ -652,6 +652,7 @@ nlmsvc_testlock(struct svc_rqst=
 *rqstp, struct nlm_file *file,
> > > > > > > > > > > >       conflock->fl.c.flc_type =3D lock->fl.c.flc_ty=
pe;
> > > > > > > > > > > >       conflock->fl.fl_start =3D lock->fl.fl_start;
> > > > > > > > > > > >       conflock->fl.fl_end =3D lock->fl.fl_end;
> > > > > > > > > > > > +     conflock->fl.fl_lmops =3D NULL;
> > > > > > > > > > > >       locks_release_private(&lock->fl);
> > > > > > > > > > > >
> > > > > > > > > > > >       ret =3D nlm_lck_denied;
> > > > > > > > > > >
> > > > > > > > > > > The problem sounds real, but I'm not sure I like this=
 solution.
> > > > > > > > > >
> > > > > > > > > > I have no claim that this solution is the best. I was c=
ontemplating on
> > > > > > > > > > setting this to NULL only in the case when ->f_ops->loc=
k() is NULL
> > > > > > > > > > thus restricting it to the path that does not call posi=
x_test_lock().
> > > > > > > > > >
> > > > > > > > > > > It seems like this is gaming the refcounting such tha=
t we take a
> > > > > > > > > > > reference in locks_copy_conflock() but then you zero =
out fl_lmops
> > > > > > > > > > > before that reference can be put.
> > > > > > > > > >
> > > > > > > > > > IF lock_copy_conflock() is called then fl_lmops is alre=
ady NULL.
> > > > > > > > > >
> > > > > > > > > > Let me try to lay out the sequence of steps for both ca=
ses.
> > > > > > > > > >
> > > > > > > > > > Reexport
> > > > > > > > > > 1. when nlmsvc_test_lock() is called file->f_file[mode]=
->f_ops->lock
> > > > > > > > > > is set (fl_lmops is set too) prior to calling vfs_test_=
lock.
> > > > > > > > > > 2. Because ->lock is set vfs_test_lock() calls the ->lo=
ck function
> > > > > > > > > > (instead of posix_test_lock)
> > > > > > > > > > 3. After vfs_test_lock() fl_lmops is still set so lock_=
release_private
> > > > > > > > > > is called and calls nlmscv_put_lockowner().
> > > > > > > > > >
> > > > > > > > > > Normal export
> > > > > > > > > > 1. when nlmsvc_test_lock() is called ->lock is not set =
(fl_lmops is
> > > > > > > > > > set) prior to calling vfs_test_lock
> > > > > > > > > > 2. Because -> is not set posix_test_lock() is called wh=
ich will call
> > > > > > > > > > local_copy_conflock() which will set fl_lmops to NULL.
> > > > > > > > > > 3. Since fl_lmops is NULL put_lockowner isn't called.
> > > > > > > > > >
> > > > > > > > > > Reexport is where I'm hazy. I'm assuming that reexporte=
d server opened
> > > > > > > > > > a file and the "file" is the NFS file object and that's=
 why
> > > > > > > > > > file->f_file[mode]->f_ops->lock is set? So perhaps if w=
e take the
> > > > > > > > > > presence of ->lock to mean reexport, we can do as I did=
 (ie., set
> > > > > > > > > > fl_lmops to null), or maybe we can take an extra refere=
nce knowing
> > > > > > > > > > that we'd need to put it in lock_release_private() ( --=
 this
> > > > > > > > > > suggestion ties to your next question). I don't see any=
 difference to
> > > > > > > > > > either setting it to NULL or taking an extra reference =
for when
> > > > > > > > > > ->lock() is set . Both are confusing and I would say wa=
rrant a comment
> > > > > > > > > > for why we are doing it.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > To be clear, there is nothing "special" about NFS reexpor=
t here. The
> > > > > > > > > NFS client just has some limitations as to what it can do=
 when it's
> > > > > > > > > being (re)exported. Exporting other sorts of network or c=
lustered
> > > > > > > > > filesystems can also be problematic for similar reasons.
> > > > > > > > >
> > > > > > > > > So, we should focus on making this generically work, and =
not take -
> > > > > > > > > > lock being set to mean that this is an NFS reexport.
> > > > > > > >
> > > > > > > > I guess it doesn't matter what kind of re-export but the fa=
ct that if
> > > > > > > > ->lock is set we know that posix_test_lock and then
> > > > > > > > local_copy_conflock won't be called and thus there is a gre=
at chance
> > > > > > > > that fl_lmops will still be set on return from vfs_test_loc=
k().
> > > > > > > >
> > > > > > > > > A question: you mentioned this is a reexporting server. A=
re you
> > > > > > > > > reexporting an NFSv4 mount as NFSv3? Or is this a v3->v3 =
reexport?
> > > > > > > >
> > > > > > > > v3->v3 reexport.
> > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > > > Ok, looking now:
> > > > > > >
> > > > > > > The test_owner in __nlm4svc_proc_test() comes from the args, =
which
> > > > > > > happens during the decode phase. That gets a valid reference =
to an NLM
> > > > > > > lockowner in nlmsvc_locks_init_private(). Therefore, this cal=
l in
> > > > > > > __nlm4svc_proc_test() seems legit.
> > > > > > >
> > > > > > >         nlmsvc_put_lockowner(test_owner);
> > > > > > >
> > > > > > > Now, between those two gets/puts, there is the call to vfs_te=
st_lock()
> > > > > > > in nlmsvc_testlock(). That uses the same file_lock argument s=
tructure
> > > > > > > to represent both the lock and the conflock.
> > > > > > >
> > > > > > >         error =3D vfs_test_lock(file->f_file[mode], &lock->fl=
);
> > > > > > >
> > > > > > > ...so the flc_owner field at this point is still set to the (=
original)
> > > > > > > nlmclient's owner.
> > > > > > >
> > > > > > > In this case, that call ends up calling down in nlmclnt_test(=
), which
> > > > > > > ignores the flc_owner field. It also ends up overwriting the =
other
> > > > > > > fields in &fl with conflock info.
> > > > > > >
> > > > > > > I think the bug is actually there. Before nlmclnt_test() over=
writes the
> > > > > > > fields in "fl", it needs to release the owner reference (and =
zero out
> > > > > > > the owner). Would this patch fix the bug?
> > > > > > >
> > > > > > > ---------------------8------------------------
> > > > > > >
> > > > > > > diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
> > > > > > > index cebcc283b7ce..200309ee1a74 100644
> > > > > > > --- a/fs/lockd/clntproc.c
> > > > > > > +++ b/fs/lockd/clntproc.c
> > > > > > > @@ -438,6 +438,8 @@ nlmclnt_test(struct nlm_rqst *req, struct=
 file_lock
> > > > > > > *fl)
> > > > > > >         if (status < 0)
> > > > > > >                 goto out;
> > > > > > >
> > > > > > > +       locks_release_private(&fl);
> > > > > > > +
> > > > > > >         switch (req->a_res.status) {
> > > > > > >                 case nlm_granted:
> > > > > > >                         fl->c.flc_type =3D F_UNLCK;
> > > > > >
> > > > > >
> > > > > > Sorry, I take it back. That alone won't fix it because of the p=
ointer-
> > > > > > saving shenanigans in __nlm4svc_proc_test. We'll need to do thi=
s a bit
> > > > > > more carefully, I think.
> > > > >
> > > > > How about this patch? The changelog still needs some work, but I =
think
> > > > > this is the most correct way to handle it:
> > > > >
> > > > > -------------------------8<----------------------------
> > > > >
> > > > > [PATCH] nlm: fix handling of conflocks by NLM
> > > > >
> > > > > The handling of conflocks can result in a refcount overput on the
> > > > > flc_owner in the case of a reexported NFSv3 fs.
> > > > >
> > > > > lockd will pass down a file_lock structure in its arguments with
> > > > > flc_owner set to an NLM owner and a valid reference. Once that ge=
ts
> > > > > down to the reexported NFS client, it will ignore that field and =
leave
> > > > > it intact when copying in conflock info.
> > > > >
> > > > > The NLM server code will then end up releasing the conflock, and =
then
> > > > > releasing the one from the arguments, not realizing that the lock=
 has
> > > > > already been released.
> > > > >
> > > > > The owner info in the arguments to vfs_test_lock() is there to gi=
ve
> > > > > information about the requestor. Once nlmclnt_test() is going to =
copy in
> > > > > the conflock info however, it needs to release the old owner.
> > > > >
> > > > > Have nlmclnt_test() do call locks_release_private() after testing=
 the
> > > > > lock to release any info that was in the old file_lock structure.
> > > > >
> > > > > This creates another problem: __nlm4svc_proc_test() and
> > > > > __nlmsvc_proc_test() both call nlmsvc_put_lockowner() uncondition=
ally on
> > > > > the original lockowner that it got from decoding the args. Switch=
 them
> > > > > both to just call locks_release_private() on &argp->lock instead,=
 which
> > > > > should handle the case properly where the info in argp->lock has =
already
> > > > > been released.
> > > > >
> > > > > With that changed, we can also eliminate the call to
> > > > > locks_release_private() in nlmsvc_testlock() since the callers wi=
ll now
> > > > > handle that.
> > > > >
> > > > > Reported-by: Olga Kornievskaia <aglo@umich.edu>
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > >  fs/lockd/clntproc.c | 3 +++
> > > > >  fs/lockd/svc4proc.c | 4 +---
> > > > >  fs/lockd/svclock.c  | 1 -
> > > > >  fs/lockd/svcproc.c  | 5 +----
> > > > >  4 files changed, 5 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
> > > > > index cebcc283b7ce..d3dd04137677 100644
> > > > > --- a/fs/lockd/clntproc.c
> > > > > +++ b/fs/lockd/clntproc.c
> > > > > @@ -438,6 +438,9 @@ nlmclnt_test(struct nlm_rqst *req, struct fil=
e_lock *fl)
> > > > >         if (status < 0)
> > > > >                 goto out;
> > > > >
> > > > > +       /* Release any references held by fl before copying in co=
nflock info */
> > > > > +       locks_release_private(fl);
> > > > > +
> > > > >         switch (req->a_res.status) {
> > > > >                 case nlm_granted:
> > > > >                         fl->c.flc_type =3D F_UNLCK;
> > > > > diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> > > > > index 109e5caae8c7..cbfec12296a4 100644
> > > > > --- a/fs/lockd/svc4proc.c
> > > > > +++ b/fs/lockd/svc4proc.c
> > > > > @@ -97,7 +97,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, str=
uct nlm_res *resp)
> > > > >         struct nlm_args *argp =3D rqstp->rq_argp;
> > > > >         struct nlm_host *host;
> > > > >         struct nlm_file *file;
> > > > > -       struct nlm_lockowner *test_owner;
> > > > >         __be32 rc =3D rpc_success;
> > > > >
> > > > >         dprintk("lockd: TEST4        called\n");
> > > > > @@ -107,7 +106,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, s=
truct nlm_res *resp)
> > > > >         if ((resp->status =3D nlm4svc_retrieve_args(rqstp, argp, =
&host, &file)))
> > > > >                 return resp->status =3D=3D nlm_drop_reply ? rpc_d=
rop_reply :rpc_success;
> > > > >
> > > > > -       test_owner =3D argp->lock.fl.c.flc_owner;
> > > > >         /* Now check for conflicting locks */
> > > > >         resp->status =3D nlmsvc_testlock(rqstp, file, host, &argp=
->lock,
> > > > >                                        &resp->lock);
> > > > > @@ -116,7 +114,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, s=
truct nlm_res *resp)
> > > > >         else
> > > > >                 dprintk("lockd: TEST4        status %d\n", ntohl(=
resp->status));
> > > > >
> > > > > -       nlmsvc_put_lockowner(test_owner);
> > > > > +       locks_release_private(&argp->lock.fl);
> > > > >         nlmsvc_release_host(host);
> > > > >         nlm_release_file(file);
> > > > >         return rc;
> > > > > diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> > > > > index a31dc9588eb8..7ff3d75a5ca3 100644
> > > > > --- a/fs/lockd/svclock.c
> > > > > +++ b/fs/lockd/svclock.c
> > > > > @@ -652,7 +652,6 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struc=
t nlm_file *file,
> > > > >         conflock->fl.c.flc_type =3D lock->fl.c.flc_type;
> > > > >         conflock->fl.fl_start =3D lock->fl.fl_start;
> > > > >         conflock->fl.fl_end =3D lock->fl.fl_end;
> > > > > -       locks_release_private(&lock->fl);
> > > > >
> > > > >         ret =3D nlm_lck_denied;
> > > > >  out:
> > > > > diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
> > > > > index f53d5177f267..6f3e669a3532 100644
> > > > > --- a/fs/lockd/svcproc.c
> > > > > +++ b/fs/lockd/svcproc.c
> > > > > @@ -117,7 +117,6 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, st=
ruct nlm_res *resp)
> > > > >         struct nlm_args *argp =3D rqstp->rq_argp;
> > > > >         struct nlm_host *host;
> > > > >         struct nlm_file *file;
> > > > > -       struct nlm_lockowner *test_owner;
> > > > >         __be32 rc =3D rpc_success;
> > > > >
> > > > >         dprintk("lockd: TEST          called\n");
> > > > > @@ -127,8 +126,6 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, st=
ruct nlm_res *resp)
> > > > >         if ((resp->status =3D nlmsvc_retrieve_args(rqstp, argp, &=
host, &file)))
> > > > >                 return resp->status =3D=3D nlm_drop_reply ? rpc_d=
rop_reply :rpc_success;
> > > > >
> > > > > -       test_owner =3D argp->lock.fl.c.flc_owner;
> > > > > -
> > > > >         /* Now check for conflicting locks */
> > > > >         resp->status =3D cast_status(nlmsvc_testlock(rqstp, file,=
 host,
> > > > >                                                    &argp->lock, &=
resp->lock));
> > > > > @@ -138,7 +135,7 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, st=
ruct nlm_res *resp)
> > > > >                 dprintk("lockd: TEST          status %d vers %d\n=
",
> > > > >                         ntohl(resp->status), rqstp->rq_vers);
> > > > >
> > > > > -       nlmsvc_put_lockowner(test_owner);
> > > > > +       locks_release_private(&argp->lock.fl);
> > > > >         nlmsvc_release_host(host);
> > > > >         nlm_release_file(file);
> > > > >         return rc;
> > > >
> > > >
> > > > Results in:
> > > >
> > > > [  420.172241] Modules linked in: ext4 crc16 mbcache jbd2 rpcrdma
> > > > rdma_cm iw_cm ib_cm ib_core nfsd nfsv3 nfs_acl nfs lockd grace
> > > > nfs_localio netfs overlay uinput snd_seq_dummy snd_hrtimer qrtr rfk=
ill
> > > > vfat fat uvcvideo videobuf2_vmalloc snd_hda_codec_generic
> > > > videobuf2_memops uvc videobuf2_v4l2 videobuf2_common snd_hda_intel
> > > > videodev snd_intel_dspcfg snd_hda_codec mc snd_hda_core snd_hwdep
> > > > snd_seq snd_seq_device snd_pcm snd_timer snd soundcore sg loop
> > > > auth_rpcgss vsock_loopback vmw_vsock_virtio_transport_common
> > > > vmw_vsock_vmci_transport vmw_vmci vsock xfs 8021q garp stp llc mrp
> > > > nvme nvme_core nvme_keyring nvme_auth ghash_ce hkdf sr_mod cdrom
> > > > e1000e vmwgfx drm_ttm_helper ttm sunrpc dm_mirror dm_region_hash
> > > > dm_log iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi fuse
> > > > dm_multipath dm_mod nfnetlink
> > > > [  420.176903] CPU: 2 UID: 0 PID: 6338 Comm: lockd Kdump: loaded No=
t
> > > > tainted 6.18.0-rc1+ #40 PREEMPT(voluntary)
> > > > [  420.177437] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS
> > > > VMW201.00V.24006586.BA64.2406042154 06/04/2024
> > > > [  420.177994] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSB=
S BTYPE=3D--)
> > > > [  420.178357] pc : nlmclnt_proc+0x1bc/0x3a0 [lockd]
> > > > [  420.178627] lr : nlmclnt_proc+0x2b8/0x3a0 [lockd]
> > > > [  420.179254] sp : ffff800088da7890
> > > > [  420.179449] x29: ffff800088da7890 x28: 0000000000000004 x27: 1ff=
fe00013a1ba2e
> > > > [  420.179848] x26: ffff0000aad57970 x25: 1fffe000155aaf2e x24: fff=
f80007fa835a0
> > > > [  420.180262] x23: 0000000000000000 x22: 0000000000000005 x21: 000=
0000000000000
> > > > [  420.180656] x20: 0000000000000000 x19: ffff0000aad578e0 x18: 000=
0000000000a10
> > > > [  420.181084] x17: 000000a400000000 x16: 0000000000000000 x15: fff=
f80007ea17118
> > > > [  420.181521] x14: ffff80007fa49358 x13: ffff80007ea526c0 x12: fff=
f700010be8955
> > > > [  420.181907] x11: 1ffff00010be8954 x10: ffff700010be8954 x9 : dff=
f800000000000
> > > > [  420.182314] x8 : 00008fffef4176ac x7 : ffff800085f44aa0 x6 : 000=
0000000000001
> > > > [  420.182721] x5 : ffff800085f44aa0 x4 : ffff0000937d8600 x3 : fff=
f8001fae51000
> > > > [  420.183134] x2 : 0000000000000001 x1 : dfff800000000000 x0 : 000=
0000000000008
> > > > [  420.183519] Call trace:
> > > > [  420.183676]  nlmclnt_proc+0x1bc/0x3a0 [lockd] (P)
> > > > [  420.183936]  nfs3_proc_lock+0xd4/0x250 [nfsv3]
> > > > [  420.184547]  nfs_lock+0x50c/0x740 [nfs]
> > > > [  420.186168]  vfs_test_lock+0x8c/0x100
> > > > [  420.186675]  nlmsvc_testlock+0xf0/0x640 [lockd]
> > > > [  420.187281]  __nlm4svc_proc_test+0x258/0x390 [lockd]
> > > > [  420.187596]  nlm4svc_proc_test+0x40/0x60 [lockd]
> > > > [  420.187842]  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > [  420.188084]  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > [  420.188465]  svc_process+0x414/0x900 [sunrpc]
> > > > [  420.188714]  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > [  420.189003]  svc_recv+0x1a4/0x520 [sunrpc]
> > > > [  420.189247]  lockd+0x154/0x298 [lockd]
> > > > [  420.189471]  kthread+0x2f8/0x398
> > > > [  420.189653]  ret_from_fork+0x10/0x20
> > > > [  420.189852] Code: d2d00001 f2fbffe1 91002280 d343fc02 (38e16841)
> > > > [  420.190210] SMP: stopping secondary CPUs
> > > > [  420.191613] Starting crashdump kernel...
> > > > [  420.191863] Bye!
> > > >
> > > > > --
> > > > > 2.51.0
> > > > >
> > >
> > > I can't tell much from that stack trace. What happened? Was it a
> > > refcounting issue or did it crash someplace else?
> >
> > It crashed while trying to process the TEST lock request (coming from
> > the nfs client) but crashed in a different place than before....
> >
> > (gdb) l *(nlmclnt_proc+0x1bc)
> > 0x5f04 is in nlmclnt_proc (fs/lockd/clntproc.c:195).
> > 190 status =3D nlmclnt_unlock(call, fl);
> > 191 } else if (IS_GETLK(cmd))
> > 192 status =3D nlmclnt_test(call, fl);
> > 193 else
> > 194 status =3D -EINVAL;
> > 195 fl->fl_ops->fl_release_private(fl);
> > 196 fl->fl_ops =3D NULL;
>
>
> Let's turn lines 195 and 196 into a call to locks_release_private(fl).
> If you do that, does it work?

No crash.

> > 197
> > 198 dprintk("lockd: clnt proc returns %d\n", status);
> > 199 return status;
> >
> > So I'm not 100% certain but the patch added lock_release_private() to
> > the nlmclnt_test(). So in nlmclnt_proc() didn't we then already call
> > it and release private in line 192 and then we are trying to do it
> > again in line 195?
> > locks_release_private() set's fl->fl_ops to NULL.... I'm speculating
> > that's the reason for the oops
> >
> > >
> > > --
> > > Jeff Layton <jlayton@kernel.org>
>
> --
> Jeff Layton <jlayton@kernel.org>

