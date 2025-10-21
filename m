Return-Path: <linux-nfs+bounces-15478-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD42BF78AD
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Oct 2025 17:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 349B11882FA7
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Oct 2025 15:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2992EE60F;
	Tue, 21 Oct 2025 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkUQj7Ou"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041102EBDC0
	for <linux-nfs@vger.kernel.org>; Tue, 21 Oct 2025 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062371; cv=none; b=W8/ObXXcdFZzK1vmsKmnk76wM7q2uG5PcBMnGm5dU75gZOSiDdSFR2atTesVLn1H+T30E+lJMydSMR7TkU7iGkV3U1y3wT9GRHdG4MHnvK62JRndOVLdsBn2PsZ7iE+hGLBqtjX6+rknyCm23Grj00hRD9Yei8iM7P9820YChjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062371; c=relaxed/simple;
	bh=RFvOs3c79i74lB4tNxrQWsBOY7WGFwrcFIGZ7Z4roxw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u2k0O1F4Nq21j1NbyT4xxCidaazWqyqwJWvDaZ2WoF+04tAb81CPIQ2hJQD3B4ai9AaiRgc8GCXLJCyHaM0mmjfcmfOXcCVa+E0NkhOEeUEShEinxKGdM+ZiGVoTajm43hmJewWlpv3rT51OhaNxzxS4IgM7dKhfRA0f7ytA36A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkUQj7Ou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F7BC4CEF1;
	Tue, 21 Oct 2025 15:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761062370;
	bh=RFvOs3c79i74lB4tNxrQWsBOY7WGFwrcFIGZ7Z4roxw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=LkUQj7Oum6VEjBct7MbaGWOs2qQE0rHrcX757D1TUZo/7CaitBfiJ+g6yckGYAW1m
	 5Utt2yafd2zZxnL7H+gcbkNnjJG6G8vogLAkv10BvwgB+hnRPV8uKxb5Vw39nTTjob
	 FLlQwJR3MGBBGqLfRMqLgE7kPBRASgB42hs1PjBORr3TjPfnzzYyM94UVNLQa4wm0Y
	 4TBTkUMQLA6y30YetSjR4Cj3dKoFCR7WK4B2eMwjVheG6ma1l2QQ8oAZErlq9dn+Yr
	 6pjUawZZ2THVrq/mGU0MYAwSEB4ybkKSu0tuU8Ii30CD1rBJnYNw1J5CjRLppIrbZM
	 Ze4IomgXAvuSA==
Message-ID: <d0a1a1ccec73ee56e614b91c4a75941f557398b8.camel@kernel.org>
Subject: Re: [RFC PATCH 1/1] lockd: prevent UAF in nlm4svc_proc_test in
 reexport NLM
From: Jeff Layton <jlayton@kernel.org>
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, 
	linux-nfs@vger.kernel.org, neilb@brown.name, Dai.Ngo@oracle.com,
 tom@talpey.com
Date: Tue, 21 Oct 2025 11:59:28 -0400
In-Reply-To: <CAN-5tyEuV2UO17w97b8weJUQR7hgqX=jz-kvGR9Sr_m3NZp8ww@mail.gmail.com>
References: <20251021130506.45065-1-okorniev@redhat.com>
	 <33ba39d2ff01eb0e52c80aa7015d27e34dde7fd2.camel@kernel.org>
	 <CAN-5tyEuV2UO17w97b8weJUQR7hgqX=jz-kvGR9Sr_m3NZp8ww@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-21 at 11:23 -0400, Olga Kornievskaia wrote:
> On Tue, Oct 21, 2025 at 9:40=E2=80=AFAM Jeff Layton <jlayton@kernel.org> =
wrote:
> >=20
> > On Tue, 2025-10-21 at 09:05 -0400, Olga Kornievskaia wrote:
> > > When knfsd is a reexport nfs server, it nlm4svc_proc_test() in
> > > calling nlmsvc_testlock() with a lock conflict lock_release_private()
> > > call would end up calling nlmsvc_put_lockowner() and then back in
> > > nlm4svc_proc_test() function there will be another call to
> > > nlmsvc_put_lockowner() for the same owner leading to use-after-free
> > > violation (below).
> > >=20
> > > The problem only arises when the underlying file system has been
> > > re-exported as different paths are taken in vfs_test_lock().
> > > When it's reexport, filp->f_op->lock is set and when vfs_test_lock()
> > > is done fl_lmops pointer is non-null. When it's regular export,
> > > vfs_test_lock() calls posix_test_lock() which ends up calling
> > > locks_copy_conflock() and it copies NULL into fl_lmops and then
> > > calling into lock_release_private() does not call
> > > nlmsvc_put_lockowner().
> > >=20
> > > The proposed solution is to intentionally clear fl_lmops pointer to
> > > make sure that if there is a conflict (be it a local file system
> > > or reexport), lock_release_private() would not call
> > > nlmsvc_put_lockowner().
> > >=20
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
> > >=20
> > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > ---
> > >  fs/lockd/svclock.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >=20
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
> > >=20
> > >       ret =3D nlm_lck_denied;
> >=20
> > The problem sounds real, but I'm not sure I like this solution.
>=20
> I have no claim that this solution is the best. I was contemplating on
> setting this to NULL only in the case when ->f_ops->lock() is NULL
> thus restricting it to the path that does not call posix_test_lock().
>=20
> > It seems like this is gaming the refcounting such that we take a
> > reference in locks_copy_conflock() but then you zero out fl_lmops
> > before that reference can be put.
>=20
> IF lock_copy_conflock() is called then fl_lmops is already NULL.
>=20
> Let me try to lay out the sequence of steps for both cases.
>=20
> Reexport
> 1. when nlmsvc_test_lock() is called file->f_file[mode]->f_ops->lock
> is set (fl_lmops is set too) prior to calling vfs_test_lock.
> 2. Because ->lock is set vfs_test_lock() calls the ->lock function
> (instead of posix_test_lock)
> 3. After vfs_test_lock() fl_lmops is still set so lock_release_private
> is called and calls nlmscv_put_lockowner().
>=20
> Normal export
> 1. when nlmsvc_test_lock() is called ->lock is not set (fl_lmops is
> set) prior to calling vfs_test_lock
> 2. Because -> is not set posix_test_lock() is called which will call
> local_copy_conflock() which will set fl_lmops to NULL.
> 3. Since fl_lmops is NULL put_lockowner isn't called.
>=20
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
>=20

To be clear, there is nothing "special" about NFS reexport here. The
NFS client just has some limitations as to what it can do when it's
being (re)exported. Exporting other sorts of network or clustered
filesystems can also be problematic for similar reasons.

So, we should focus on making this generically work, and not take -
>lock being set to mean that this is an NFS reexport.

A question: you mentioned this is a reexporting server. Are you
reexporting an NFSv4 mount as NFSv3? Or is this a v3->v3 reexport?
--=20
Jeff Layton <jlayton@kernel.org>

