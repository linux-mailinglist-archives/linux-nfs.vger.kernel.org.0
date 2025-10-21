Return-Path: <linux-nfs+bounces-15477-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D14FBF76D2
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Oct 2025 17:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFEEB3A22C7
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Oct 2025 15:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DAE32F756;
	Tue, 21 Oct 2025 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="VSJ7UIbl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9A432E6A7
	for <linux-nfs@vger.kernel.org>; Tue, 21 Oct 2025 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060952; cv=none; b=rO/ABii2eqTOnOF00cMYYOHMkVHYnRWQLLgQSrMnFW1U3cu+P7hXxLwl9cTuGG24JYn9C0dbgkwIGO6OmjKriaVJjBG7VwLGXRbwgPTslfy5YZsd4fLbGW2WNrKEvg8Se9JwqZ7J5or4ZwswGYGAVao0uzTd208QlOk/YRWLzAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060952; c=relaxed/simple;
	bh=Y5rmqf7vWlcA7AOJxnXFFMUvLyRq/lCT8EnP4uPrUm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MnEs1X2Kov6B3Cnxeg5dXPw1cdHAvVh8GP+QzCaaQ6cwzho8A8y7hjltxRSaJWCBjAsYGpgMtsA22MWcQSVPaH+Iwvvg9aMAQnAclYRcn6ETAY8oMUiN6hoeUglUP7zteyDAn8YEoqfub/1htOWFvhYxIC8fY4zhcSNbPlQqAx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=VSJ7UIbl; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-368348d30e0so57112231fa.1
        for <linux-nfs@vger.kernel.org>; Tue, 21 Oct 2025 08:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1761060949; x=1761665749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0cmBZtEKCYlJQEKl0nV1953O30D60u6J7X0g17rgFA=;
        b=VSJ7UIble0Y4ZHYEEZSdPvurOtaTY+9VBb4l544/NyEjDg30FsgJt5Rz6S1gqQssUW
         bxsFJs6lXAVoZyz17dHptfLCbKLHZy0Wraqt8xMoyus0EHMx9ZWn0yM81Bd4m8NOoePM
         LcK5/8yP3RXyBPdiD70609pJvhtMxVqZfG4WpDjjI0OAwKbvhv2cNvWQpwnmGRNezj1c
         S71W4zYOcwJTeL+hplRnToxyJ9cv9/sfLYW0ooDrlbSdWqXtdvE1vWeNw2JD+s79La9F
         K3ifbLetliQX57RGSwecLuTPn0DfJmySFoBi31AxFjw2LbzT7zilWBClTeAt4apSDuBD
         fdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761060949; x=1761665749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0cmBZtEKCYlJQEKl0nV1953O30D60u6J7X0g17rgFA=;
        b=A2jIPdscgJ4Wa0wJ27Qr2JhKHr1Uz7Pu+F4vXZCXnqUyXI5v+QjmpDbuWgANB33BS3
         cvTl0ExUAnEZQgq8JbEGc4KoRzJTC6wLLq6h8U+qcWtIhwJMqHreDaUgsKi8O9bwRQZU
         GsbUbSWp8hS9To1oI30hyZFSLDPptl5+FH+Hh0Cn5QELLthVOKmdCxUJSv+ljoUrIntu
         dIjAQLo1aPg6RyVN8lP+NHpt8ELcTnBuP50qGI5BojP8Un2re6EBy15CxUlX6CQ25NZL
         quyW22xvY0csFFVm8PVJIkxPr4XfMVt1w9xKjAbS4NmDhfhJvi7S8YD8ENcEr+Tq5WG5
         AqHg==
X-Forwarded-Encrypted: i=1; AJvYcCXIkKLRuPTL+CL/HlGf0I9Thd/Du6VDAshveRQTNOqo1PgC48BWRzC6yiY4miozYee/P89Q+cKNxjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFJIu8Rac3MGI5pgQK5cairSrwEeczBtFYxFBxT29BW80dmDrv
	0YZ8u86HtVQlAPNv5NzTlMyd4ZHuloUHanI+H5muRoFQ0vMSca9Wb6qhHQqK3kq7WWRldj9Kcmo
	zrAxrKoP1ZZacizNYCv6RAq7qUnhUQBk=
X-Gm-Gg: ASbGncsL8aNEGbun/Q6qmrxph50tfc7wopylwaU0i1Eronq5YbZzp7iOHJYsGukMl02
	QepJ61VxTtmu7AUGz1b+UdZ+6iofxqhlFVZQxz4tlCoAzLzEg+qox0nfSGK2aU2CenGiTNIMvM5
	mHJU+ILI2vG6A02/Y8K3u4mJFVk27Rd2o0krOkXZI2JKZChOzb7N1pQGm21v55f/P7h5Zb6kl9e
	vgBHnYy35PdbjEmI7JnjaYR0fzOJ84DqnhuxdZGqxSjuB6Z4LuCu3WiJiWVNDJmcVnWJULt7WQY
	j1BhHoL1LMxS/l8OL9U=
X-Google-Smtp-Source: AGHT+IHvSYxvVtTHXPKCcglnSkjOLbS8fhn65PtWrEzw4KOthyitak6PoB2y2Cy30P9T61t7PgN8SzBVe7Exo2TQEGo=
X-Received: by 2002:a2e:9fc8:0:b0:36b:42ae:2e4d with SMTP id
 38308e7fff4ca-3779783b23dmr56890721fa.2.1761060948649; Tue, 21 Oct 2025
 08:35:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021130506.45065-1-okorniev@redhat.com> <33ba39d2ff01eb0e52c80aa7015d27e34dde7fd2.camel@kernel.org>
 <CAN-5tyEuV2UO17w97b8weJUQR7hgqX=jz-kvGR9Sr_m3NZp8ww@mail.gmail.com>
In-Reply-To: <CAN-5tyEuV2UO17w97b8weJUQR7hgqX=jz-kvGR9Sr_m3NZp8ww@mail.gmail.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 21 Oct 2025 11:35:37 -0400
X-Gm-Features: AS18NWCtfvqoHvdNcOOHSkOC1RlUL3_YCvwenh2YUVvHXQCNBtFO47Dw1_mhRbM
Message-ID: <CAN-5tyGt4RbRhR2gyKhjooq6yfXe1Ry4PkfYJ+mwEPuYkgqhYw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] lockd: prevent UAF in nlm4svc_proc_test in
 reexport NLM
To: Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, linux-nfs@vger.kernel.org, 
	neilb@brown.name, Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 11:23=E2=80=AFAM Olga Kornievskaia <aglo@umich.edu>=
 wrote:
>
> On Tue, Oct 21, 2025 at 9:40=E2=80=AFAM Jeff Layton <jlayton@kernel.org> =
wrote:
> >
> > On Tue, 2025-10-21 at 09:05 -0400, Olga Kornievskaia wrote:
> > > When knfsd is a reexport nfs server, it nlm4svc_proc_test() in
> > > calling nlmsvc_testlock() with a lock conflict lock_release_private()
> > > call would end up calling nlmsvc_put_lockowner() and then back in
> > > nlm4svc_proc_test() function there will be another call to
> > > nlmsvc_put_lockowner() for the same owner leading to use-after-free
> > > violation (below).
> > >
> > > The problem only arises when the underlying file system has been
> > > re-exported as different paths are taken in vfs_test_lock().
> > > When it's reexport, filp->f_op->lock is set and when vfs_test_lock()
> > > is done fl_lmops pointer is non-null. When it's regular export,
> > > vfs_test_lock() calls posix_test_lock() which ends up calling
> > > locks_copy_conflock() and it copies NULL into fl_lmops and then
> > > calling into lock_release_private() does not call
> > > nlmsvc_put_lockowner().
> > >
> > > The proposed solution is to intentionally clear fl_lmops pointer to
> > > make sure that if there is a conflict (be it a local file system
> > > or reexport), lock_release_private() would not call
> > > nlmsvc_put_lockowner().
> > >
> > > kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > kernel: BUG: KASAN: slab-use-after-free in nlmsvc_put_lockowner+0x30/=
0x250 [lockd]
> > > kernel: Read of size 4 at addr ffff0000bf3bca10 by task lockd/6092
> > > kernel:
> > > kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump: loaded Not tainted=
 6.18.0-rc1+ #23 PREEMPT(voluntary)
> > > kernel: Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.00V.=
24006586.BA64.2406042154 06/04/2024
> > > kernel: Call trace:
> > > kernel:  show_stack+0x34/0x98 (C)
> > > kernel:  dump_stack_lvl+0x80/0xa8
> > > kernel:  print_address_description.constprop.0+0x90/0x310
> > > kernel:  print_report+0x108/0x1f8
> > > kernel:  kasan_report+0xc8/0x120
> > > kernel:  kasan_check_range+0xe8/0x190
> > > kernel:  __kasan_check_read+0x20/0x30
> > > kernel:  nlmsvc_put_lockowner+0x30/0x250 [lockd]
> > > kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
> > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > kernel:  lockd+0x154/0x298 [lockd]
> > > kernel:  kthread+0x2f8/0x398
> > > kernel:  ret_from_fork+0x10/0x20
> > > kernel:
> > > kernel: Allocated by task 6092:
> > > kernel:  kasan_save_stack+0x3c/0x70
> > > kernel:  kasan_save_track+0x20/0x40
> > > kernel:  kasan_save_alloc_info+0x40/0x58
> > > kernel:  __kasan_kmalloc+0xd4/0xd8
> > > kernel:  __kmalloc_cache_noprof+0x1a8/0x5c0
> > > kernel:  nlmsvc_locks_init_private+0xe4/0x520 [lockd]
> > > kernel:  nlm4svc_retrieve_args+0x38c/0x530 [lockd]
> > > kernel:  __nlm4svc_proc_test+0x194/0x318 [lockd]
> > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > kernel:  lockd+0x154/0x298 [lockd]
> > > kernel:  kthread+0x2f8/0x398
> > > kernel:  ret_from_fork+0x10/0x20
> > > kernel:
> > > kernel: Freed by task 6092:
> > > kernel:  kasan_save_stack+0x3c/0x70
> > > kernel:  kasan_save_track+0x20/0x40
> > > kernel:  __kasan_save_free_info+0x4c/0x80
> > > kernel:  __kasan_slab_free+0x88/0xc0
> > > kernel:  kfree+0x110/0x480
> > > kernel:  nlmsvc_put_lockowner+0x1b4/0x250 [lockd]
> > > kernel:  nlmsvc_put_owner+0x18/0x30 [lockd]
> > > kernel:  locks_release_private+0x190/0x2a8
> > > kernel:  nlmsvc_testlock+0x2e0/0x648 [lockd]
> > > kernel:  __nlm4svc_proc_test+0x244/0x318 [lockd]
> > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > kernel:  lockd+0x154/0x298 [lockd]
> > > kernel:  kthread+0x2f8/0x398
> > > kernel:  ret_from_fork+0x10/0x20
> > > kernel:
> > > kernel: The buggy address belongs to the object at ffff0000bf3bca00
> > >         which belongs to the cache kmalloc-64 of size 64
> > > kernel: The buggy address is located 16 bytes inside of
> > >         freed 64-byte region [ffff0000bf3bca00, ffff0000bf3bca40)
> > > kernel:
> > > kernel: The buggy address belongs to the physical page:
> > > kernel: page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x=
0 pfn:0x13f3bc
> > > kernel: flags: 0x2fffff00000000(node=3D0|zone=3D2|lastcpupid=3D0xffff=
f)
> > > kernel: page_type: f5(slab)
> > > kernel: raw: 002fffff00000000 ffff0000800028c0 dead000000000122 00000=
00000000000
> > > kernel: raw: 0000000000000000 0000000080200020 00000000f5000000 00000=
00000000000
> > > kernel: page dumped because: kasan: bad access detected
> > > kernel:
> > > kernel: Memory state around the buggy address:
> > > kernel:  ffff0000bf3bc900: fa fb fb fb fb fb fb fb fc fc fc fc fc fc =
fc fc
> > > kernel:  ffff0000bf3bc980: fa fb fb fb fb fb fb fb fc fc fc fc fc fc =
fc fc
> > > kernel: >ffff0000bf3bca00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc =
fc fc
> > > kernel:                          ^
> > > kernel:  ffff0000bf3bca80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc =
fc fc
> > > kernel:  ffff0000bf3bcb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc
> > > kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > kernel: Disabling lock debugging due to kernel taint
> > > kernel: AGLO: nlmsvc_put_lockowner 00000000028055fb count=3D0
> > > kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump: loaded Tainted: G =
   B               6.18.0-rc1+ #23 PREEMPT(voluntary)
> > > kernel: Tainted: [B]=3DBAD_PAGE
> > > kernel: Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.00V.=
24006586.BA64.2406042154 06/04/2024
> > > kernel: Call trace:
> > > kernel:  show_stack+0x34/0x98 (C)
> > > kernel:  dump_stack_lvl+0x80/0xa8
> > > kernel:  dump_stack+0x1c/0x30
> > > kernel:  nlmsvc_put_lockowner+0x7c/0x250 [lockd]
> > > kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
> > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > kernel:  lockd+0x154/0x298 [lockd]
> > > kernel:  kthread+0x2f8/0x398
> > > kernel:  ret_from_fork+0x10/0x20
> > > kernel: ------------[ cut here ]------------
> > > kernel: refcount_t: underflow; use-after-free.
> > > kernel: WARNING: CPU: 0 PID: 6092 at lib/refcount.c:87 refcount_dec_n=
ot_one+0x198/0x1b0
> > > kernel: Modules linked in: rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd n=
fsv3 nfs_acl nfs lockd grace nfs_localio netfs ext4 crc16 mbcache jbd2 over=
lay uinput snd_seq_dummy snd_hrtimer qrtr rfkill vfat fat uvcvideo snd_hda_=
codec_generic videobuf2_vmalloc videobuf2_memops uvc snd_hda_intel videobuf=
2_v4l2 videobuf2_common snd_intel_dspcfg videodev snd_hda_codec snd_hda_cor=
e mc snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd soundcore sg lo=
op auth_rpcgss vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_v=
mci_transport vmw_vmci vsock xfs 8021q garp stp llc mrp nvme nvme_core nvme=
_keyring nvme_auth ghash_ce hkdf e1000e sr_mod cdrom vmwgfx drm_ttm_helper =
ttm sunrpc dm_mirror dm_region_hash dm_log iscsi_tcp libiscsi_tcp libiscsi =
scsi_transport_iscsi fuse dm_multipath dm_mod nfnetlink
> > > kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump: loaded Tainted: G =
   B               6.18.0-rc1+ #23 PREEMPT(voluntary)
> > > kernel: Tainted: [B]=3DBAD_PAGE
> > > kernel: Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.00V.=
24006586.BA64.2406042154 06/04/2024
> > > kernel: pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=
=3D--)
> > > kernel: pc : refcount_dec_not_one+0x198/0x1b0
> > > kernel: lr : refcount_dec_not_one+0x198/0x1b0
> > > kernel: sp : ffff80008a627930
> > > kernel: x29: ffff80008a627990 x28: ffff0000bf3bca00 x27: ffff0000ba5c=
7000
> > > kernel: x26: 1fffe000191eeb84 x25: 1ffff000114c4f48 x24: ffff0000c8f7=
5c24
> > > kernel: x23: 0000000000000007 x22: ffff80008a627950 x21: 1ffff000114c=
4f26
> > > kernel: x20: 00000000ffffffff x19: ffff0000bf3bca10 x18: 000000000000=
0310
> > > kernel: x17: 0000000000000000 x16: 0000000000000000 x15: 000000000000=
0000
> > > kernel: x14: 0000000000000000 x13: 0000000000000001 x12: ffff60004fd9=
0aa3
> > > kernel: x11: 1fffe0004fd90aa2 x10: ffff60004fd90aa2 x9 : dfff80000000=
0000
> > > kernel: x8 : 00009fffb026f55e x7 : ffff00027ec85513 x6 : 000000000000=
0001
> > > kernel: x5 : ffff00027ec85510 x4 : ffff60004fd90aa3 x3 : ffff80008078=
7bc0
> > > kernel: x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000a75a=
8000
> > > kernel: Call trace:
> > > kernel:  refcount_dec_not_one+0x198/0x1b0 (P)
> > > kernel:  refcount_dec_and_lock+0x1c/0xb8
> > > kernel:  nlmsvc_put_lockowner+0x9c/0x250 [lockd]
> > > kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
> > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > kernel:  lockd+0x154/0x298 [lockd]
> > > kernel:  kthread+0x2f8/0x398
> > > kernel:  ret_from_fork+0x10/0x20
> > > kernel: ---[ end trace 0000000000000000 ]---
> > >
> > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > ---
> > >  fs/lockd/svclock.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> > > index a31dc9588eb8..1dd0fec186de 100644
> > > --- a/fs/lockd/svclock.c
> > > +++ b/fs/lockd/svclock.c
> > > @@ -652,6 +652,7 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nl=
m_file *file,
> > >       conflock->fl.c.flc_type =3D lock->fl.c.flc_type;
> > >       conflock->fl.fl_start =3D lock->fl.fl_start;
> > >       conflock->fl.fl_end =3D lock->fl.fl_end;
> > > +     conflock->fl.fl_lmops =3D NULL;
> > >       locks_release_private(&lock->fl);
> > >
> > >       ret =3D nlm_lck_denied;
> >
> > The problem sounds real, but I'm not sure I like this solution.
>
> I have no claim that this solution is the best. I was contemplating on
> setting this to NULL only in the case when ->f_ops->lock() is NULL
> thus restricting it to the path that does not call posix_test_lock().
>
> > It seems like this is gaming the refcounting such that we take a
> > reference in locks_copy_conflock() but then you zero out fl_lmops
> > before that reference can be put.
>
> IF lock_copy_conflock() is called then fl_lmops is already NULL.

I realize that's not correct to say. What I meant to say is that we
are not leaking a refcount by setting fl_lmops to null. There will be
the last put in the nlm4svc_proc_test.

>
> Let me try to lay out the sequence of steps for both cases.
>
> Reexport
> 1. when nlmsvc_test_lock() is called file->f_file[mode]->f_ops->lock
> is set (fl_lmops is set too) prior to calling vfs_test_lock.
> 2. Because ->lock is set vfs_test_lock() calls the ->lock function
> (instead of posix_test_lock)
> 3. After vfs_test_lock() fl_lmops is still set so lock_release_private
> is called and calls nlmscv_put_lockowner().
>
> Normal export
> 1. when nlmsvc_test_lock() is called ->lock is not set (fl_lmops is
> set) prior to calling vfs_test_lock
> 2. Because -> is not set posix_test_lock() is called which will call
> local_copy_conflock() which will set fl_lmops to NULL.
> 3. Since fl_lmops is NULL put_lockowner isn't called.
>
> Reexport is where I'm hazy. I'm assuming that reexported server opened
> a file and the "file" is the NFS file object and that's why
> file->f_file[mode]->f_ops->lock is set? So perhaps if we take the
> presence of ->lock to mean reexport, we can do as I did (ie., set
> fl_lmops to null), or maybe we can take an extra reference knowing
> that we'd need to put it in lock_release_private() ( -- this
> suggestion ties to your next question). I don't see any difference to
> either setting it to NULL or taking an extra reference for when
> ->lock() is set . Both are confusing and I would say warrant a comment
> for why we are doing it.
>
> > Doesn't that mean that the real bug is that we're missing taking an
> > owner reference in some case?
> > --
> > Jeff Layton <jlayton@kernel.org>
> >

