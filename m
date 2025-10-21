Return-Path: <linux-nfs+bounces-15480-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 23620BF7A07
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Oct 2025 18:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA60B4F53F9
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Oct 2025 16:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EF1347FE4;
	Tue, 21 Oct 2025 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="ST50pybx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A3C347FF0
	for <linux-nfs@vger.kernel.org>; Tue, 21 Oct 2025 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761063491; cv=none; b=dp2EyOBJcNo3g2melMGRyJCFzwdUZm8+2EGU0miuNt2XhMBhKPXGkfO7onUfaFfhSoAe5mOALx33yaph149afrYGnh4CAzA95RJkqXQvYDIiux82kqu+JfnK5wT1Q1YWohsx2jpfQGMkQzwcK2E/JTB9PTidPldVHk5kj/IUiEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761063491; c=relaxed/simple;
	bh=Xy4wDeXnHkp72K2hS/kYyvryNACcp23E7nbYSluV0Wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JVuXjFFvjJ7jM3hpOXQB1RhO7odVsO5XmWQeBa50dy8Ak34aZnCi87Y88IDCWtlGniCpiQZMfvM5Dp5uNLIveFuBWCogulwJDOLsaZmlEhAGsq5q+Ir0daHglyFNzN9oZ17JMZ4wESH+FgXkLXULBxBDcZT5Y76NUcQKbU9vMrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=ST50pybx; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3612c38b902so56044641fa.2
        for <linux-nfs@vger.kernel.org>; Tue, 21 Oct 2025 09:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1761063485; x=1761668285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtCBwRfsnVKaR+I7j6R5Yf3NA//4qzIK2StwGeDHqIM=;
        b=ST50pybxesCRVryrjLmbYEXitXPugzyBYyGS8cK1b8aMJqTTHef06RUjewAHfhRnDy
         UGZg2LglpdEIN4LkNvu/NDyH4tuRENPZrxOWTwqOvUB9wq9/pH1+C83PE1nulhew0Xyd
         twPOgGaPb17PLPcrpMpVaaUbS1MJi4u+9pW+bU4VE3tOf5hakONc0HmF2AYiL9Ipp+qq
         0ZcI6rYNyoNXnbbK3/d6y6vH2j3tIQ5jV1pMjRdaw5Csc//hNqPUZ4qShEV4iDBzpWs+
         C5SDeHOFwS7lJCJnC/YJ1YayMliLKtAcIdVXrYXRNj8FbDt6SqWF2trJkIHLny6/HUni
         ZKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761063485; x=1761668285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtCBwRfsnVKaR+I7j6R5Yf3NA//4qzIK2StwGeDHqIM=;
        b=BpdgEHgmjjNbhmZ1hmusTc7ubzkLg3GunUv5/YjRn7lJ9g7MAZoppTqt+qCLe25BVV
         dlSS0ROhFIiWw73RGNxm7H5JDLkHuN9vAYvDXAc7BBgigFlU2SGWoxxdiIo99UNYt6wS
         X7Cwhpf7M0mazSlOOTs9Q63xsz+O3E2gB57k3DJnWLWcTGWR+R7iWVL1xUTIAnASgIHb
         3E/Kn0Fbnz3InGYdV8byLDzKmADTckk2VUvGuZ6RCAd6o02DUhIA0m6O/sSPs+F1SxwC
         3vGFG1Wn5VFNJy7iBKij7CmlUDIGWd+gVCsS65lY1bEQleb6W0ViFMBIawR6Mt43XWxm
         mn8w==
X-Forwarded-Encrypted: i=1; AJvYcCVhmWdlACH6StJoNc5BIroG7Qj4OTR9HXS16Lza/J3EzY1MacP1L9Hz/tDZGwc7GFJbCRKLsahkPZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4MHGQWLkACY2UI8RiOBJGESI9d3in4yWB/Vrzxadi7JyBO87G
	Aj4HGSI01eTrQOSscuHwobGvn+YEQa4yglciR4mhB1PenH1wWKt976pr/gUDwSR3cdSPO7gVMHw
	pOhygD98qgJ87yiH8ZIpEkimyyCk+wbU=
X-Gm-Gg: ASbGncuDS5JPz+9C8t/o3Rlgewng3d9XCfPrhOS4B1wG4ObhReCRIi95zGC0+FXn0hY
	Dc1u9Vv08qAQk2ysY9DqMvSpwX/2dMf6g+nXQCjNB1Uxp2xU/i+CnGuyEkYeyiGRI9+LUq/R2PN
	7sApp9B1ylatiVSHU6H85sokgcR6vq0U0i1KfFhyFPsbLYfuJuMLbvSyAf/yxAaWZ+7sXz402ZB
	jyakzXINd8Jg5nPndwhIr2nG643A97pNEvqDGcTmivyfixVby5f4BWvyDILl86Roakk6w0+Vt90
	S3+SfsAj3E2Ku8sPrSf51x+vQVk32g==
X-Google-Smtp-Source: AGHT+IHM5KAVRFNQVIbgKMmWgBZFAp7nBATVl/4VaCBODR1AWSHfzaPeRwoMC6jJdCU0BKko5LN+GHON3QqOkAbNmi8=
X-Received: by 2002:a2e:a98e:0:b0:372:a0e3:4ccf with SMTP id
 38308e7fff4ca-37797a6436amr48607641fa.37.1761063484421; Tue, 21 Oct 2025
 09:18:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021130506.45065-1-okorniev@redhat.com> <33ba39d2ff01eb0e52c80aa7015d27e34dde7fd2.camel@kernel.org>
 <CAN-5tyEuV2UO17w97b8weJUQR7hgqX=jz-kvGR9Sr_m3NZp8ww@mail.gmail.com> <d0a1a1ccec73ee56e614b91c4a75941f557398b8.camel@kernel.org>
In-Reply-To: <d0a1a1ccec73ee56e614b91c4a75941f557398b8.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 21 Oct 2025 12:17:52 -0400
X-Gm-Features: AS18NWAZb-mhy_va4BacYQQg2DOCyLGFoT0NdNGMh_9RGcDi9bgZMlA957Psy34
Message-ID: <CAN-5tyGK4MHgYaN1SqpygtvWM8BFrapT-rXY_y9msVfnRjN1Jw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] lockd: prevent UAF in nlm4svc_proc_test in
 reexport NLM
To: Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, linux-nfs@vger.kernel.org, 
	neilb@brown.name, Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 11:59=E2=80=AFAM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Tue, 2025-10-21 at 11:23 -0400, Olga Kornievskaia wrote:
> > On Tue, Oct 21, 2025 at 9:40=E2=80=AFAM Jeff Layton <jlayton@kernel.org=
> wrote:
> > >
> > > On Tue, 2025-10-21 at 09:05 -0400, Olga Kornievskaia wrote:
> > > > When knfsd is a reexport nfs server, it nlm4svc_proc_test() in
> > > > calling nlmsvc_testlock() with a lock conflict lock_release_private=
()
> > > > call would end up calling nlmsvc_put_lockowner() and then back in
> > > > nlm4svc_proc_test() function there will be another call to
> > > > nlmsvc_put_lockowner() for the same owner leading to use-after-free
> > > > violation (below).
> > > >
> > > > The problem only arises when the underlying file system has been
> > > > re-exported as different paths are taken in vfs_test_lock().
> > > > When it's reexport, filp->f_op->lock is set and when vfs_test_lock(=
)
> > > > is done fl_lmops pointer is non-null. When it's regular export,
> > > > vfs_test_lock() calls posix_test_lock() which ends up calling
> > > > locks_copy_conflock() and it copies NULL into fl_lmops and then
> > > > calling into lock_release_private() does not call
> > > > nlmsvc_put_lockowner().
> > > >
> > > > The proposed solution is to intentionally clear fl_lmops pointer to
> > > > make sure that if there is a conflict (be it a local file system
> > > > or reexport), lock_release_private() would not call
> > > > nlmsvc_put_lockowner().
> > > >
> > > > kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > kernel: BUG: KASAN: slab-use-after-free in nlmsvc_put_lockowner+0x3=
0/0x250 [lockd]
> > > > kernel: Read of size 4 at addr ffff0000bf3bca10 by task lockd/6092
> > > > kernel:
> > > > kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump: loaded Not taint=
ed 6.18.0-rc1+ #23 PREEMPT(voluntary)
> > > > kernel: Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.00=
V.24006586.BA64.2406042154 06/04/2024
> > > > kernel: Call trace:
> > > > kernel:  show_stack+0x34/0x98 (C)
> > > > kernel:  dump_stack_lvl+0x80/0xa8
> > > > kernel:  print_address_description.constprop.0+0x90/0x310
> > > > kernel:  print_report+0x108/0x1f8
> > > > kernel:  kasan_report+0xc8/0x120
> > > > kernel:  kasan_check_range+0xe8/0x190
> > > > kernel:  __kasan_check_read+0x20/0x30
> > > > kernel:  nlmsvc_put_lockowner+0x30/0x250 [lockd]
> > > > kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
> > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > kernel:  kthread+0x2f8/0x398
> > > > kernel:  ret_from_fork+0x10/0x20
> > > > kernel:
> > > > kernel: Allocated by task 6092:
> > > > kernel:  kasan_save_stack+0x3c/0x70
> > > > kernel:  kasan_save_track+0x20/0x40
> > > > kernel:  kasan_save_alloc_info+0x40/0x58
> > > > kernel:  __kasan_kmalloc+0xd4/0xd8
> > > > kernel:  __kmalloc_cache_noprof+0x1a8/0x5c0
> > > > kernel:  nlmsvc_locks_init_private+0xe4/0x520 [lockd]
> > > > kernel:  nlm4svc_retrieve_args+0x38c/0x530 [lockd]
> > > > kernel:  __nlm4svc_proc_test+0x194/0x318 [lockd]
> > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > kernel:  kthread+0x2f8/0x398
> > > > kernel:  ret_from_fork+0x10/0x20
> > > > kernel:
> > > > kernel: Freed by task 6092:
> > > > kernel:  kasan_save_stack+0x3c/0x70
> > > > kernel:  kasan_save_track+0x20/0x40
> > > > kernel:  __kasan_save_free_info+0x4c/0x80
> > > > kernel:  __kasan_slab_free+0x88/0xc0
> > > > kernel:  kfree+0x110/0x480
> > > > kernel:  nlmsvc_put_lockowner+0x1b4/0x250 [lockd]
> > > > kernel:  nlmsvc_put_owner+0x18/0x30 [lockd]
> > > > kernel:  locks_release_private+0x190/0x2a8
> > > > kernel:  nlmsvc_testlock+0x2e0/0x648 [lockd]
> > > > kernel:  __nlm4svc_proc_test+0x244/0x318 [lockd]
> > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > kernel:  kthread+0x2f8/0x398
> > > > kernel:  ret_from_fork+0x10/0x20
> > > > kernel:
> > > > kernel: The buggy address belongs to the object at ffff0000bf3bca00
> > > >         which belongs to the cache kmalloc-64 of size 64
> > > > kernel: The buggy address is located 16 bytes inside of
> > > >         freed 64-byte region [ffff0000bf3bca00, ffff0000bf3bca40)
> > > > kernel:
> > > > kernel: The buggy address belongs to the physical page:
> > > > kernel: page: refcount:0 mapcount:0 mapping:0000000000000000 index:=
0x0 pfn:0x13f3bc
> > > > kernel: flags: 0x2fffff00000000(node=3D0|zone=3D2|lastcpupid=3D0xff=
fff)
> > > > kernel: page_type: f5(slab)
> > > > kernel: raw: 002fffff00000000 ffff0000800028c0 dead000000000122 000=
0000000000000
> > > > kernel: raw: 0000000000000000 0000000080200020 00000000f5000000 000=
0000000000000
> > > > kernel: page dumped because: kasan: bad access detected
> > > > kernel:
> > > > kernel: Memory state around the buggy address:
> > > > kernel:  ffff0000bf3bc900: fa fb fb fb fb fb fb fb fc fc fc fc fc f=
c fc fc
> > > > kernel:  ffff0000bf3bc980: fa fb fb fb fb fb fb fb fc fc fc fc fc f=
c fc fc
> > > > kernel: >ffff0000bf3bca00: fa fb fb fb fb fb fb fb fc fc fc fc fc f=
c fc fc
> > > > kernel:                          ^
> > > > kernel:  ffff0000bf3bca80: fa fb fb fb fb fb fb fb fc fc fc fc fc f=
c fc fc
> > > > kernel:  ffff0000bf3bcb00: fc fc fc fc fc fc fc fc fc fc fc fc fc f=
c fc fc
> > > > kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > kernel: Disabling lock debugging due to kernel taint
> > > > kernel: AGLO: nlmsvc_put_lockowner 00000000028055fb count=3D0
> > > > kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump: loaded Tainted: =
G    B               6.18.0-rc1+ #23 PREEMPT(voluntary)
> > > > kernel: Tainted: [B]=3DBAD_PAGE
> > > > kernel: Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.00=
V.24006586.BA64.2406042154 06/04/2024
> > > > kernel: Call trace:
> > > > kernel:  show_stack+0x34/0x98 (C)
> > > > kernel:  dump_stack_lvl+0x80/0xa8
> > > > kernel:  dump_stack+0x1c/0x30
> > > > kernel:  nlmsvc_put_lockowner+0x7c/0x250 [lockd]
> > > > kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
> > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > kernel:  kthread+0x2f8/0x398
> > > > kernel:  ret_from_fork+0x10/0x20
> > > > kernel: ------------[ cut here ]------------
> > > > kernel: refcount_t: underflow; use-after-free.
> > > > kernel: WARNING: CPU: 0 PID: 6092 at lib/refcount.c:87 refcount_dec=
_not_one+0x198/0x1b0
> > > > kernel: Modules linked in: rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd=
 nfsv3 nfs_acl nfs lockd grace nfs_localio netfs ext4 crc16 mbcache jbd2 ov=
erlay uinput snd_seq_dummy snd_hrtimer qrtr rfkill vfat fat uvcvideo snd_hd=
a_codec_generic videobuf2_vmalloc videobuf2_memops uvc snd_hda_intel videob=
uf2_v4l2 videobuf2_common snd_intel_dspcfg videodev snd_hda_codec snd_hda_c=
ore mc snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd soundcore sg =
loop auth_rpcgss vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock=
_vmci_transport vmw_vmci vsock xfs 8021q garp stp llc mrp nvme nvme_core nv=
me_keyring nvme_auth ghash_ce hkdf e1000e sr_mod cdrom vmwgfx drm_ttm_helpe=
r ttm sunrpc dm_mirror dm_region_hash dm_log iscsi_tcp libiscsi_tcp libiscs=
i scsi_transport_iscsi fuse dm_multipath dm_mod nfnetlink
> > > > kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump: loaded Tainted: =
G    B               6.18.0-rc1+ #23 PREEMPT(voluntary)
> > > > kernel: Tainted: [B]=3DBAD_PAGE
> > > > kernel: Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.00=
V.24006586.BA64.2406042154 06/04/2024
> > > > kernel: pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=
=3D--)
> > > > kernel: pc : refcount_dec_not_one+0x198/0x1b0
> > > > kernel: lr : refcount_dec_not_one+0x198/0x1b0
> > > > kernel: sp : ffff80008a627930
> > > > kernel: x29: ffff80008a627990 x28: ffff0000bf3bca00 x27: ffff0000ba=
5c7000
> > > > kernel: x26: 1fffe000191eeb84 x25: 1ffff000114c4f48 x24: ffff0000c8=
f75c24
> > > > kernel: x23: 0000000000000007 x22: ffff80008a627950 x21: 1ffff00011=
4c4f26
> > > > kernel: x20: 00000000ffffffff x19: ffff0000bf3bca10 x18: 0000000000=
000310
> > > > kernel: x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000=
000000
> > > > kernel: x14: 0000000000000000 x13: 0000000000000001 x12: ffff60004f=
d90aa3
> > > > kernel: x11: 1fffe0004fd90aa2 x10: ffff60004fd90aa2 x9 : dfff800000=
000000
> > > > kernel: x8 : 00009fffb026f55e x7 : ffff00027ec85513 x6 : 0000000000=
000001
> > > > kernel: x5 : ffff00027ec85510 x4 : ffff60004fd90aa3 x3 : ffff800080=
787bc0
> > > > kernel: x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000a7=
5a8000
> > > > kernel: Call trace:
> > > > kernel:  refcount_dec_not_one+0x198/0x1b0 (P)
> > > > kernel:  refcount_dec_and_lock+0x1c/0xb8
> > > > kernel:  nlmsvc_put_lockowner+0x9c/0x250 [lockd]
> > > > kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
> > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > kernel:  kthread+0x2f8/0x398
> > > > kernel:  ret_from_fork+0x10/0x20
> > > > kernel: ---[ end trace 0000000000000000 ]---
> > > >
> > > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > > ---
> > > >  fs/lockd/svclock.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> > > > index a31dc9588eb8..1dd0fec186de 100644
> > > > --- a/fs/lockd/svclock.c
> > > > +++ b/fs/lockd/svclock.c
> > > > @@ -652,6 +652,7 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct =
nlm_file *file,
> > > >       conflock->fl.c.flc_type =3D lock->fl.c.flc_type;
> > > >       conflock->fl.fl_start =3D lock->fl.fl_start;
> > > >       conflock->fl.fl_end =3D lock->fl.fl_end;
> > > > +     conflock->fl.fl_lmops =3D NULL;
> > > >       locks_release_private(&lock->fl);
> > > >
> > > >       ret =3D nlm_lck_denied;
> > >
> > > The problem sounds real, but I'm not sure I like this solution.
> >
> > I have no claim that this solution is the best. I was contemplating on
> > setting this to NULL only in the case when ->f_ops->lock() is NULL
> > thus restricting it to the path that does not call posix_test_lock().
> >
> > > It seems like this is gaming the refcounting such that we take a
> > > reference in locks_copy_conflock() but then you zero out fl_lmops
> > > before that reference can be put.
> >
> > IF lock_copy_conflock() is called then fl_lmops is already NULL.
> >
> > Let me try to lay out the sequence of steps for both cases.
> >
> > Reexport
> > 1. when nlmsvc_test_lock() is called file->f_file[mode]->f_ops->lock
> > is set (fl_lmops is set too) prior to calling vfs_test_lock.
> > 2. Because ->lock is set vfs_test_lock() calls the ->lock function
> > (instead of posix_test_lock)
> > 3. After vfs_test_lock() fl_lmops is still set so lock_release_private
> > is called and calls nlmscv_put_lockowner().
> >
> > Normal export
> > 1. when nlmsvc_test_lock() is called ->lock is not set (fl_lmops is
> > set) prior to calling vfs_test_lock
> > 2. Because -> is not set posix_test_lock() is called which will call
> > local_copy_conflock() which will set fl_lmops to NULL.
> > 3. Since fl_lmops is NULL put_lockowner isn't called.
> >
> > Reexport is where I'm hazy. I'm assuming that reexported server opened
> > a file and the "file" is the NFS file object and that's why
> > file->f_file[mode]->f_ops->lock is set? So perhaps if we take the
> > presence of ->lock to mean reexport, we can do as I did (ie., set
> > fl_lmops to null), or maybe we can take an extra reference knowing
> > that we'd need to put it in lock_release_private() ( -- this
> > suggestion ties to your next question). I don't see any difference to
> > either setting it to NULL or taking an extra reference for when
> > ->lock() is set . Both are confusing and I would say warrant a comment
> > for why we are doing it.
> >
>
> To be clear, there is nothing "special" about NFS reexport here. The
> NFS client just has some limitations as to what it can do when it's
> being (re)exported. Exporting other sorts of network or clustered
> filesystems can also be problematic for similar reasons.
>
> So, we should focus on making this generically work, and not take -
> >lock being set to mean that this is an NFS reexport.

I guess it doesn't matter what kind of re-export but the fact that if
->lock is set we know that posix_test_lock and then
local_copy_conflock won't be called and thus there is a great chance
that fl_lmops will still be set on return from vfs_test_lock().

> A question: you mentioned this is a reexporting server. Are you
> reexporting an NFSv4 mount as NFSv3? Or is this a v3->v3 reexport?

v3->v3 reexport.

> --
> Jeff Layton <jlayton@kernel.org>
>

