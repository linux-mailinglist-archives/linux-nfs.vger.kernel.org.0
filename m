Return-Path: <linux-nfs+bounces-15390-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 96964BEE886
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Oct 2025 17:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0C9B345243
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Oct 2025 15:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D011DE8A4;
	Sun, 19 Oct 2025 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKvRpMav"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C209117B506
	for <linux-nfs@vger.kernel.org>; Sun, 19 Oct 2025 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760887138; cv=none; b=gtumLC0k9XChCJ0IWf3TI6/5DEi535AtdNpA3dVpwMznNki+30YaaTuQzzdSwyEfTJtWoGV0lV+CIAIljktNw+4F/42WlZ9eujvuiI7DdiScHycAq80VEa5HUKMz9yz1SN3BZyYLUVEGwa0AruMJbsryyxsqZoqckM4rhBNemv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760887138; c=relaxed/simple;
	bh=ceAP3AYCuM1krwj5l1JEthsZcZeSVPWgEqvIUC7Kx/E=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HSTBDbONkAHfTt2d3OWGGiRnxDKEUtWuCRxkFCFEJksYqU7QM/kgzwXMGsqLlfGxPB/I98W7KlexDxw9AD5bqGNikJa5oclmsJP564GXhMHQfNcB7Obe4E75HLHWoFDwT/muNr7rXV9U0jYl8VoeY5eUaVS/Tg9wYN9pkkEmGXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKvRpMav; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACA6C4CEE7;
	Sun, 19 Oct 2025 15:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760887138;
	bh=ceAP3AYCuM1krwj5l1JEthsZcZeSVPWgEqvIUC7Kx/E=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=pKvRpMavp+3rRjePYDUxfrefllP0Go0WTi2kqLgNW1l1MC2upqoblGo4nKaD14UQJ
	 LSbivvGALPPy3lmnrK7M8ptzETVefyUZZ/KZeZIHFMkvNCQ0UDp9G1o6amYOlADbxb
	 fBC8+AYw/8HRzKCgtpf/lyBIA6QfVuA7RjCv3KHqU9yasDgMiqV+laTfxqVeKfnxBj
	 ouFYGJ3mQxgZXzWh7qFE6dd3mS1IGW0BanKl3MwA+mKM/zs36dTsNyVOiQBCm+x55/
	 OlT4f0TuKKda8BeVJClpOGcOq801UXklrMCi8Pu1Dq2XnGTSBfm918aJpa1iKwbLek
	 B3mIVcCia++AQ==
Message-ID: <ed50690c04699c820873642ea38a01eec53d21af.camel@kernel.org>
Subject: Re: [Bug report] xfstests generic/323 over NFS hit BUG: KASAN:
 slab-use-after-free in nfs_local_call_read on 6.18.0-rc1
From: Trond Myklebust <trondmy@kernel.org>
To: Yongcheng Yang <yoyang@redhat.com>, linux-nfs@vger.kernel.org, Mike
 Snitzer	 <snitzer@kernel.org>
Date: Sun, 19 Oct 2025 11:18:57 -0400
In-Reply-To: <aPSvi5Yr2lGOh5Jh@dell-per750-06-vm-07.rhts.eng.pek2.redhat.com>
References: <aPSvi5Yr2lGOh5Jh@dell-per750-06-vm-07.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-10-19 at 17:29 +0800, Yongcheng Yang wrote:
> Hi All,
>=20
> There is a new nfs slab-use-after-free issue since 6.18.0-rc1.
> It appears to be reliably reproducible on my side when running
> xfstests
> generic/323 over NFSv4.2 in *debug* kernel mode:

Thanks for the report! I think I see the problem.

Mike,

When you iterate over the iocb in nfs_local_call_read(), you're calling
nfs_local_pgio_done(), nfs_local_read_done() and
nfs_local_pgio_release() multiple times.

 * You're calling nfs_local_read_aio_complete() and
   nfs_local_read_aio_complete_work() once for each and every
   asynchronous call.
 * You're calling nfs_local_pgio_done() for each synchronous call.
 * In addition, if there is a synchronous call at the very end of the
   iteration, so that status !=3D -EIOCBQUEUED, then you're also calling
   nfs_local_read_done() one extra time, and then calling
   nfs_local_pgio_release().

The same thing appears to be happening in nfs_local_call_write().

>=20
> [18265.311177]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [18265.315831] BUG: KASAN: slab-use-after-free in
> nfs_local_call_read+0x590/0x7f0 [nfs]
> [18265.320135] Read of size 2 at addr ffff8881090556a2 by task
> kworker/u9:0/667366
>=20
> [18265.325454] CPU: 0 UID: 0 PID: 667366 Comm: kworker/u9:0 Not
> tainted 6.18.0-rc1 #1 PREEMPT(full)=20
> [18265.325461] Hardware name: Red Hat KVM/RHEL, BIOS edk2-20241117-
> 2.el9 11/17/2024
> [18265.325465] Workqueue: nfslocaliod nfs_local_call_read [nfs]
> [18265.325611] Call Trace:
> [18265.325615]=C2=A0 <TASK>
> [18265.325619]=C2=A0 dump_stack_lvl+0x77/0xa0
> [18265.325629]=C2=A0 print_report+0x171/0x820
> [18265.325637]=C2=A0 ? __virt_addr_valid+0x151/0x3a0
> [18265.325644]=C2=A0 ? __virt_addr_valid+0x300/0x3a0
> [18265.325650]=C2=A0 ? nfs_local_call_read+0x590/0x7f0 [nfs]
> [18265.325770]=C2=A0 kasan_report+0x167/0x1a0
> [18265.325777]=C2=A0 ? nfs_local_call_read+0x590/0x7f0 [nfs]
> [18265.325900]=C2=A0 nfs_local_call_read+0x590/0x7f0 [nfs]
> [18265.326027]=C2=A0 ? process_scheduled_works+0x7d3/0x11d0
> [18265.326034]=C2=A0 process_scheduled_works+0x857/0x11d0
> [18265.326050]=C2=A0 worker_thread+0x897/0xd00
> [18265.326065]=C2=A0 kthread+0x51b/0x650
> [18265.326071]=C2=A0 ? __pfx_worker_thread+0x10/0x10
> [18265.326076]=C2=A0 ? __pfx_kthread+0x10/0x10
> [18265.326082]=C2=A0 ret_from_fork+0x249/0x480
> [18265.326087]=C2=A0 ? __pfx_kthread+0x10/0x10
> [18265.326092]=C2=A0 ret_from_fork_asm+0x1a/0x30
> [18265.326104]=C2=A0 </TASK>
>=20
> [18265.378345] Allocated by task 681242:
> [18265.380068]=C2=A0 kasan_save_track+0x3e/0x80
> [18265.381838]=C2=A0 __kasan_kmalloc+0x93/0xb0
> [18265.383587]=C2=A0 __kmalloc_cache_noprof+0x3eb/0x6e0
> [18265.385532]=C2=A0 nfs_local_doio+0x1cb/0xeb0 [nfs]
> [18265.387630]=C2=A0 nfs_initiate_pgio+0x284/0x400 [nfs]
> [18265.389815]=C2=A0 nfs_generic_pg_pgios+0x6e2/0x810 [nfs]
> [18265.391998]=C2=A0 nfs_pageio_complete+0x278/0x750 [nfs]
> [18265.394146]=C2=A0 nfs_file_direct_read+0x78c/0x9e0 [nfs]
> [18265.396386]=C2=A0 vfs_read+0x5d0/0x770
> [18265.398043]=C2=A0 __x64_sys_pread64+0xed/0x160
> [18265.399837]=C2=A0 do_syscall_64+0xad/0x7d0
> [18265.401561]=C2=A0 entry_SYSCALL_64_after_hwframe+0x76/0x7e
>=20
> [18265.404687] Freed by task 596986:
> [18265.406245]=C2=A0 kasan_save_track+0x3e/0x80
> [18265.408013]=C2=A0 __kasan_save_free_info+0x46/0x50
> [18265.409884]=C2=A0 __kasan_slab_free+0x58/0x80
> [18265.411613]=C2=A0 kfree+0x1c1/0x620
> [18265.413075]=C2=A0 nfs_local_read_aio_complete_work+0x86/0x100 [nfs]
> [18265.415486]=C2=A0 process_scheduled_works+0x857/0x11d0
> [18265.417437]=C2=A0 worker_thread+0x897/0xd00
> [18265.419177]=C2=A0 kthread+0x51b/0x650
> [18265.420689]=C2=A0 ret_from_fork+0x249/0x480
> [18265.422331]=C2=A0 ret_from_fork_asm+0x1a/0x30
>=20
> [18265.424989] Last potentially related work creation:
> [18265.426949]=C2=A0 kasan_save_stack+0x3e/0x60
> [18265.428639]=C2=A0 kasan_record_aux_stack+0xbd/0xd0
> [18265.430423]=C2=A0 insert_work+0x2d/0x230
> [18265.431968]=C2=A0 __queue_work+0x8ec/0xb50
> [18265.433555]=C2=A0 queue_work_on+0xaf/0xe0
> [18265.435126]=C2=A0 iomap_dio_bio_end_io+0xb5/0x160
> [18265.436902]=C2=A0 blk_update_request+0x3d1/0x1000
> [18265.438699]=C2=A0 blk_mq_end_request+0x3c/0x70
> [18265.440379]=C2=A0 virtblk_done+0x148/0x250
> [18265.441973]=C2=A0 vring_interrupt+0x159/0x300
> [18265.443642]=C2=A0 __handle_irq_event_percpu+0x1c3/0x700
> [18265.445556]=C2=A0 handle_irq_event+0x8b/0x1c0
> [18265.447219]=C2=A0 handle_edge_irq+0x1b5/0x760
> [18265.448881]=C2=A0 __common_interrupt+0xba/0x140
> [18265.450588]=C2=A0 common_interrupt+0x45/0xa0
> [18265.452258]=C2=A0 asm_common_interrupt+0x26/0x40
>=20
> [18265.454941] Second to last potentially related work creation:
> [18265.457141]=C2=A0 kasan_save_stack+0x3e/0x60
> [18265.458790]=C2=A0 kasan_record_aux_stack+0xbd/0xd0
> [18265.460597]=C2=A0 insert_work+0x2d/0x230
> [18265.462129]=C2=A0 __queue_work+0x8ec/0xb50
> [18265.463725]=C2=A0 queue_work_on+0xaf/0xe0
> [18265.465289]=C2=A0 nfs_local_doio+0xa75/0xeb0 [nfs]
> [18265.467220]=C2=A0 nfs_initiate_pgio+0x284/0x400 [nfs]
> [18265.469226]=C2=A0 nfs_generic_pg_pgios+0x6e2/0x810 [nfs]
> [18265.471310]=C2=A0 nfs_pageio_complete+0x278/0x750 [nfs]
> [18265.473363]=C2=A0 nfs_file_direct_read+0x78c/0x9e0 [nfs]
> [18265.475432]=C2=A0 vfs_read+0x5d0/0x770
> [18265.476941]=C2=A0 __x64_sys_pread64+0xed/0x160
> [18265.478648]=C2=A0 do_syscall_64+0xad/0x7d0
> [18265.480240]=C2=A0 entry_SYSCALL_64_after_hwframe+0x76/0x7e
>=20
> [18265.483211] The buggy address belongs to the object at
> ffff888109055600
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 which belongs to the cache kmalloc-rnd-14-512 of size
> 512
> [18265.488048] The buggy address is located 162 bytes inside of
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 freed 512-byte region [ffff888109055600,
> ffff888109055800)
>=20
> [18265.493827] The buggy address belongs to the physical page:
> [18265.496033] page: refcount:0 mapcount:0 mapping:0000000000000000
> index:0xffff888109050e00 pfn:0x109050
> [18265.499353] head: order:3 mapcount:0 entire_mapcount:0
> nr_pages_mapped:0 pincount:0
> [18265.502198] flags:
> 0x17ffffc0000240(workingset|head|node=3D0|zone=3D2|lastcpupid=3D0x1fffff)
> [18265.505105] page_type: f5(slab)
> [18265.506675] raw: 0017ffffc0000240 ffff88810006d540
> ffffea0004151c10 ffff88810006e088
> [18265.509537] raw: ffff888109050e00 000000000015000f
> 00000000f5000000 0000000000000000
> [18265.512418] head: 0017ffffc0000240 ffff88810006d540
> ffffea0004151c10 ffff88810006e088
> [18265.515326] head: ffff888109050e00 000000000015000f
> 00000000f5000000 0000000000000000
> [18265.518244] head: 0017ffffc0000003 ffffea0004241401
> 00000000ffffffff 00000000ffffffff
> [18265.521168] head: ffffffffffffffff 0000000000000000
> 00000000ffffffff 0000000000000008
> [18265.524113] page dumped because: kasan: bad access detected
>=20
> [18265.527455] Memory state around the buggy address:
> [18265.529505]=C2=A0 ffff888109055580: fc fc fc fc fc fc fc fc fc fc fc f=
c
> fc fc fc fc
> [18265.532292]=C2=A0 ffff888109055600: fa fb fb fb fb fb fb fb fb fb fb f=
b
> fb fb fb fb
> [18265.535149] >ffff888109055680: fb fb fb fb fb fb fb fb fb fb fb fb
> fb fb fb fb
> [18265.537930]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> [18265.539899]=C2=A0 ffff888109055700: fb fb fb fb fb fb fb fb fb fb fb f=
b
> fb fb fb fb
> [18265.542713]=C2=A0 ffff888109055780: fb fb fb fb fb fb fb fb fb fb fb f=
b
> fb fb fb fb
> [18265.545507]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [18265.554665] Disabling lock debugging due to kernel taint
>=20

--=20
Trond Myklebust Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

