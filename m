Return-Path: <linux-nfs+bounces-15462-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 891A3BF74DC
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Oct 2025 17:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FEEA19A0E07
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Oct 2025 15:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB44C340293;
	Tue, 21 Oct 2025 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="mKUWU55+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C48341ADD
	for <linux-nfs@vger.kernel.org>; Tue, 21 Oct 2025 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060217; cv=none; b=jPnXVT3ih6ximvMR9XuEH1Y8k6/jBseDWJ+cfhKr0TwK+hMsE61XHREAc6SaADI8yVdVdOlXy+K+VDg4G5V4tRh0zNKZMLXIgwGIb1ZW8uHTikRq5e6R0K3rUFkhxL9hgYceyIi082jQv0im4cpznIA4+cxuBbxug1+AUgBZ/C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060217; c=relaxed/simple;
	bh=lswSsWMWu7IVBV4W936T+zhwQnKmehfmGT5u0ZvScJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FU0KKz5UFxdkmScyrKzmkSWTWOyXFnx/636Fd1y6sVJJuY4OT/CjyFfZeNxSjvsGLgmuIwVVRCGfcQRwtmBIrLtO8HvoTeZ+Yr+/RdO2y9DaU4qz77WlpGebb+ZCMXu8wWAhoYzv7Q7+GriV21f1gH6+4nKTqEQ6YVS+BIxKew0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=mKUWU55+; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-57d5ccd73dfso5471011e87.0
        for <linux-nfs@vger.kernel.org>; Tue, 21 Oct 2025 08:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1761060214; x=1761665014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4ODV6PRIEbSjurjrKgNJOjJ10RhDVpIDNThoGrD0DA=;
        b=mKUWU55+7GFpVym7YYjNtgoAlgoYvCHkvufgEueSnKdpwIXpLEez3tCfBYxF9RsrL4
         QQ/ngVebJq6/oEWG/k/hnp9ngxxHCBEkgDTI9BMQH7z3AMYeStj2kTlrG7UhnBx1G9rI
         w6eC126s/BtlYPMVNEPg49Uf9AjcYHvhb4NRR4ksZB4xkiP2Fb9vFTsSLzqw0Ugz8shz
         eOOskryPu9eyqM/uxRIX1TZZtNNgZ7n4KDb8Z3rHQY+cm4/XUj+ZdoMKNT5rutt6h7Yf
         7BTaVYeu3AizGTX7kAmeVgpuGq4sxKqqUnHK9nikOzwBBmDUdu+oq/T6goyJNRNFC1x1
         nm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761060214; x=1761665014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4ODV6PRIEbSjurjrKgNJOjJ10RhDVpIDNThoGrD0DA=;
        b=SQ870FC0Af5JqNK9wauU8DF1PySRraAO7kN19mAX8u9sxoOr5azxvsjbG8zEIKrTZp
         EhB1aGWyGCiI4QhDMm2/L05fuElKvErjDcSVfqeDY02Rav6dpx05mERJ/8UdRxPyC/2z
         eh0LHR3UV8lDWsoxQKWPFB8nNDZQXHs5spf9oFKH/ETG9YQxRHToDtksRhYe23sqYi7I
         Z7oPWJsZUkBtjYOmjVRsrIkV1GfN6AL1k3mfJU1yFJiRJv+SBA+r6uWuB26AbFN6QUZJ
         TnVK6OWgNjxi6qWBTa2QWp6vE5FQtIHFJmtJxfa6OxDwN9K/0M4rxsQqDGwvQWBl+31W
         BvwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh4qpU4uTUZ5xy3uL/8n932jbeGWvhqHOUMzbT3LUeVo9JAYuxJYYstER1fi1NOvvvhnwPFzXKIk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOy5h8ACtpRjkINBe+7yWWiHsmQMob7OS4SKDX5IctOUMjU9jm
	pfny4m6fBxD2U6LBug4f02Yx3Gd13BxbqH3Qo3x7ENrzT4paypebJ7L1e/IFBtSnG072qut1UKv
	1ADzZTe+nm/0uKQk2lGd6ZgQBSrJBFqP6G9J9
X-Gm-Gg: ASbGncvjDuENB5RSErLpCM5SIVoeio4NKJVbv5ldEMGnXC6GJc5Rz9epMXWkQSVs0bT
	2bbcPA+qKH5iChe+UbbenhuowPPMR1+TkBlhI6GTlq8GUbxy1Qch2uYkDgarI+N30mmTKQ3OaEn
	4y7i3m3ydNXU7twv0m5efrF7Xi4L5kJMZVO+xzhpks6xTo5O2oX42Zcj4EpP7j1HLB6zd47kEwl
	gkJAiu5t883iJwboVe4nfduUpgqWvG9fDDhLAWs3b6+gBJatsuShZmKqmQFBrbC5R+UJyWtQSdc
	5i3CG3Snnol3won2H9g=
X-Google-Smtp-Source: AGHT+IEI4R4t7V54PFdl/IQ40wkCROQnK9sHUEhj6QcHYKDFiLTNNNjsQjnzVtCGC51qqx+8HlyXA/cTnfOEDwC7gpE=
X-Received: by 2002:a05:651c:892:b0:372:9420:9509 with SMTP id
 38308e7fff4ca-377978c6da9mr56046461fa.15.1761060213241; Tue, 21 Oct 2025
 08:23:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021130506.45065-1-okorniev@redhat.com> <33ba39d2ff01eb0e52c80aa7015d27e34dde7fd2.camel@kernel.org>
In-Reply-To: <33ba39d2ff01eb0e52c80aa7015d27e34dde7fd2.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 21 Oct 2025 11:23:21 -0400
X-Gm-Features: AS18NWCWj8XW8P_GRtXjZZgIqYk9e5rieLrLd4pKHrruIuDao2zcG91P_f9UN4E
Message-ID: <CAN-5tyEuV2UO17w97b8weJUQR7hgqX=jz-kvGR9Sr_m3NZp8ww@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] lockd: prevent UAF in nlm4svc_proc_test in
 reexport NLM
To: Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, linux-nfs@vger.kernel.org, 
	neilb@brown.name, Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 9:40=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Tue, 2025-10-21 at 09:05 -0400, Olga Kornievskaia wrote:
> > When knfsd is a reexport nfs server, it nlm4svc_proc_test() in
> > calling nlmsvc_testlock() with a lock conflict lock_release_private()
> > call would end up calling nlmsvc_put_lockowner() and then back in
> > nlm4svc_proc_test() function there will be another call to
> > nlmsvc_put_lockowner() for the same owner leading to use-after-free
> > violation (below).
> >
> > The problem only arises when the underlying file system has been
> > re-exported as different paths are taken in vfs_test_lock().
> > When it's reexport, filp->f_op->lock is set and when vfs_test_lock()
> > is done fl_lmops pointer is non-null. When it's regular export,
> > vfs_test_lock() calls posix_test_lock() which ends up calling
> > locks_copy_conflock() and it copies NULL into fl_lmops and then
> > calling into lock_release_private() does not call
> > nlmsvc_put_lockowner().
> >
> > The proposed solution is to intentionally clear fl_lmops pointer to
> > make sure that if there is a conflict (be it a local file system
> > or reexport), lock_release_private() would not call
> > nlmsvc_put_lockowner().
> >
> > kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > kernel: BUG: KASAN: slab-use-after-free in nlmsvc_put_lockowner+0x30/0x=
250 [lockd]
> > kernel: Read of size 4 at addr ffff0000bf3bca10 by task lockd/6092
> > kernel:
> > kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump: loaded Not tainted 6=
.18.0-rc1+ #23 PREEMPT(voluntary)
> > kernel: Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.00V.24=
006586.BA64.2406042154 06/04/2024
> > kernel: Call trace:
> > kernel:  show_stack+0x34/0x98 (C)
> > kernel:  dump_stack_lvl+0x80/0xa8
> > kernel:  print_address_description.constprop.0+0x90/0x310
> > kernel:  print_report+0x108/0x1f8
> > kernel:  kasan_report+0xc8/0x120
> > kernel:  kasan_check_range+0xe8/0x190
> > kernel:  __kasan_check_read+0x20/0x30
> > kernel:  nlmsvc_put_lockowner+0x30/0x250 [lockd]
> > kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
> > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > kernel:  svc_process+0x414/0x900 [sunrpc]
> > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > kernel:  lockd+0x154/0x298 [lockd]
> > kernel:  kthread+0x2f8/0x398
> > kernel:  ret_from_fork+0x10/0x20
> > kernel:
> > kernel: Allocated by task 6092:
> > kernel:  kasan_save_stack+0x3c/0x70
> > kernel:  kasan_save_track+0x20/0x40
> > kernel:  kasan_save_alloc_info+0x40/0x58
> > kernel:  __kasan_kmalloc+0xd4/0xd8
> > kernel:  __kmalloc_cache_noprof+0x1a8/0x5c0
> > kernel:  nlmsvc_locks_init_private+0xe4/0x520 [lockd]
> > kernel:  nlm4svc_retrieve_args+0x38c/0x530 [lockd]
> > kernel:  __nlm4svc_proc_test+0x194/0x318 [lockd]
> > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > kernel:  svc_process+0x414/0x900 [sunrpc]
> > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > kernel:  lockd+0x154/0x298 [lockd]
> > kernel:  kthread+0x2f8/0x398
> > kernel:  ret_from_fork+0x10/0x20
> > kernel:
> > kernel: Freed by task 6092:
> > kernel:  kasan_save_stack+0x3c/0x70
> > kernel:  kasan_save_track+0x20/0x40
> > kernel:  __kasan_save_free_info+0x4c/0x80
> > kernel:  __kasan_slab_free+0x88/0xc0
> > kernel:  kfree+0x110/0x480
> > kernel:  nlmsvc_put_lockowner+0x1b4/0x250 [lockd]
> > kernel:  nlmsvc_put_owner+0x18/0x30 [lockd]
> > kernel:  locks_release_private+0x190/0x2a8
> > kernel:  nlmsvc_testlock+0x2e0/0x648 [lockd]
> > kernel:  __nlm4svc_proc_test+0x244/0x318 [lockd]
> > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > kernel:  svc_process+0x414/0x900 [sunrpc]
> > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > kernel:  lockd+0x154/0x298 [lockd]
> > kernel:  kthread+0x2f8/0x398
> > kernel:  ret_from_fork+0x10/0x20
> > kernel:
> > kernel: The buggy address belongs to the object at ffff0000bf3bca00
> >         which belongs to the cache kmalloc-64 of size 64
> > kernel: The buggy address is located 16 bytes inside of
> >         freed 64-byte region [ffff0000bf3bca00, ffff0000bf3bca40)
> > kernel:
> > kernel: The buggy address belongs to the physical page:
> > kernel: page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 =
pfn:0x13f3bc
> > kernel: flags: 0x2fffff00000000(node=3D0|zone=3D2|lastcpupid=3D0xfffff)
> > kernel: page_type: f5(slab)
> > kernel: raw: 002fffff00000000 ffff0000800028c0 dead000000000122 0000000=
000000000
> > kernel: raw: 0000000000000000 0000000080200020 00000000f5000000 0000000=
000000000
> > kernel: page dumped because: kasan: bad access detected
> > kernel:
> > kernel: Memory state around the buggy address:
> > kernel:  ffff0000bf3bc900: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc=
 fc
> > kernel:  ffff0000bf3bc980: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc=
 fc
> > kernel: >ffff0000bf3bca00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc=
 fc
> > kernel:                          ^
> > kernel:  ffff0000bf3bca80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc=
 fc
> > kernel:  ffff0000bf3bcb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc
> > kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > kernel: Disabling lock debugging due to kernel taint
> > kernel: AGLO: nlmsvc_put_lockowner 00000000028055fb count=3D0
> > kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump: loaded Tainted: G   =
 B               6.18.0-rc1+ #23 PREEMPT(voluntary)
> > kernel: Tainted: [B]=3DBAD_PAGE
> > kernel: Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.00V.24=
006586.BA64.2406042154 06/04/2024
> > kernel: Call trace:
> > kernel:  show_stack+0x34/0x98 (C)
> > kernel:  dump_stack_lvl+0x80/0xa8
> > kernel:  dump_stack+0x1c/0x30
> > kernel:  nlmsvc_put_lockowner+0x7c/0x250 [lockd]
> > kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
> > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > kernel:  svc_process+0x414/0x900 [sunrpc]
> > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > kernel:  lockd+0x154/0x298 [lockd]
> > kernel:  kthread+0x2f8/0x398
> > kernel:  ret_from_fork+0x10/0x20
> > kernel: ------------[ cut here ]------------
> > kernel: refcount_t: underflow; use-after-free.
> > kernel: WARNING: CPU: 0 PID: 6092 at lib/refcount.c:87 refcount_dec_not=
_one+0x198/0x1b0
> > kernel: Modules linked in: rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd nfs=
v3 nfs_acl nfs lockd grace nfs_localio netfs ext4 crc16 mbcache jbd2 overla=
y uinput snd_seq_dummy snd_hrtimer qrtr rfkill vfat fat uvcvideo snd_hda_co=
dec_generic videobuf2_vmalloc videobuf2_memops uvc snd_hda_intel videobuf2_=
v4l2 videobuf2_common snd_intel_dspcfg videodev snd_hda_codec snd_hda_core =
mc snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd soundcore sg loop=
 auth_rpcgss vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmc=
i_transport vmw_vmci vsock xfs 8021q garp stp llc mrp nvme nvme_core nvme_k=
eyring nvme_auth ghash_ce hkdf e1000e sr_mod cdrom vmwgfx drm_ttm_helper tt=
m sunrpc dm_mirror dm_region_hash dm_log iscsi_tcp libiscsi_tcp libiscsi sc=
si_transport_iscsi fuse dm_multipath dm_mod nfnetlink
> > kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump: loaded Tainted: G   =
 B               6.18.0-rc1+ #23 PREEMPT(voluntary)
> > kernel: Tainted: [B]=3DBAD_PAGE
> > kernel: Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.00V.24=
006586.BA64.2406042154 06/04/2024
> > kernel: pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=3D-=
-)
> > kernel: pc : refcount_dec_not_one+0x198/0x1b0
> > kernel: lr : refcount_dec_not_one+0x198/0x1b0
> > kernel: sp : ffff80008a627930
> > kernel: x29: ffff80008a627990 x28: ffff0000bf3bca00 x27: ffff0000ba5c70=
00
> > kernel: x26: 1fffe000191eeb84 x25: 1ffff000114c4f48 x24: ffff0000c8f75c=
24
> > kernel: x23: 0000000000000007 x22: ffff80008a627950 x21: 1ffff000114c4f=
26
> > kernel: x20: 00000000ffffffff x19: ffff0000bf3bca10 x18: 00000000000003=
10
> > kernel: x17: 0000000000000000 x16: 0000000000000000 x15: 00000000000000=
00
> > kernel: x14: 0000000000000000 x13: 0000000000000001 x12: ffff60004fd90a=
a3
> > kernel: x11: 1fffe0004fd90aa2 x10: ffff60004fd90aa2 x9 : dfff8000000000=
00
> > kernel: x8 : 00009fffb026f55e x7 : ffff00027ec85513 x6 : 00000000000000=
01
> > kernel: x5 : ffff00027ec85510 x4 : ffff60004fd90aa3 x3 : ffff800080787b=
c0
> > kernel: x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000a75a80=
00
> > kernel: Call trace:
> > kernel:  refcount_dec_not_one+0x198/0x1b0 (P)
> > kernel:  refcount_dec_and_lock+0x1c/0xb8
> > kernel:  nlmsvc_put_lockowner+0x9c/0x250 [lockd]
> > kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
> > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > kernel:  svc_process+0x414/0x900 [sunrpc]
> > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > kernel:  lockd+0x154/0x298 [lockd]
> > kernel:  kthread+0x2f8/0x398
> > kernel:  ret_from_fork+0x10/0x20
> > kernel: ---[ end trace 0000000000000000 ]---
> >
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >  fs/lockd/svclock.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> > index a31dc9588eb8..1dd0fec186de 100644
> > --- a/fs/lockd/svclock.c
> > +++ b/fs/lockd/svclock.c
> > @@ -652,6 +652,7 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_=
file *file,
> >       conflock->fl.c.flc_type =3D lock->fl.c.flc_type;
> >       conflock->fl.fl_start =3D lock->fl.fl_start;
> >       conflock->fl.fl_end =3D lock->fl.fl_end;
> > +     conflock->fl.fl_lmops =3D NULL;
> >       locks_release_private(&lock->fl);
> >
> >       ret =3D nlm_lck_denied;
>
> The problem sounds real, but I'm not sure I like this solution.

I have no claim that this solution is the best. I was contemplating on
setting this to NULL only in the case when ->f_ops->lock() is NULL
thus restricting it to the path that does not call posix_test_lock().

> It seems like this is gaming the refcounting such that we take a
> reference in locks_copy_conflock() but then you zero out fl_lmops
> before that reference can be put.

IF lock_copy_conflock() is called then fl_lmops is already NULL.

Let me try to lay out the sequence of steps for both cases.

Reexport
1. when nlmsvc_test_lock() is called file->f_file[mode]->f_ops->lock
is set (fl_lmops is set too) prior to calling vfs_test_lock.
2. Because ->lock is set vfs_test_lock() calls the ->lock function
(instead of posix_test_lock)
3. After vfs_test_lock() fl_lmops is still set so lock_release_private
is called and calls nlmscv_put_lockowner().

Normal export
1. when nlmsvc_test_lock() is called ->lock is not set (fl_lmops is
set) prior to calling vfs_test_lock
2. Because -> is not set posix_test_lock() is called which will call
local_copy_conflock() which will set fl_lmops to NULL.
3. Since fl_lmops is NULL put_lockowner isn't called.

Reexport is where I'm hazy. I'm assuming that reexported server opened
a file and the "file" is the NFS file object and that's why
file->f_file[mode]->f_ops->lock is set? So perhaps if we take the
presence of ->lock to mean reexport, we can do as I did (ie., set
fl_lmops to null), or maybe we can take an extra reference knowing
that we'd need to put it in lock_release_private() ( -- this
suggestion ties to your next question). I don't see any difference to
either setting it to NULL or taking an extra reference for when
->lock() is set . Both are confusing and I would say warrant a comment
for why we are doing it.

> Doesn't that mean that the real bug is that we're missing taking an
> owner reference in some case?
> --
> Jeff Layton <jlayton@kernel.org>
>

