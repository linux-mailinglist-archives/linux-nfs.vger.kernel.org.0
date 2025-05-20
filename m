Return-Path: <linux-nfs+bounces-11839-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935C6ABDD9A
	for <lists+linux-nfs@lfdr.de>; Tue, 20 May 2025 16:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E673B7EE3
	for <lists+linux-nfs@lfdr.de>; Tue, 20 May 2025 14:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8380D242D84;
	Tue, 20 May 2025 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYjK6TNj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555C5335C7;
	Tue, 20 May 2025 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752218; cv=none; b=hJGFktPikYmRK2uZobOGH8xnn7h9oj6MpjKPgmrxasPrhbGDNxbaBolx29WlsQ/gTFLKn003lGNc7bZUl3UAIO5zyu/m8FlAkuv0/Ydj9XydYExs+KT9WfFKP9a0F6Rmgii+Wz74kzI+P6U6zGA9WOqGU1MH0t25AUgbvIhOC/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752218; c=relaxed/simple;
	bh=dMf1Hn1YFj52yUn5Y4UeSWZ0jKMtxnmOoQG7WaiFNhI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LCP8TUhsXKOyrJH2px2bJwisM6b+q6LWtxoPCcsjyA95zUUb0oNIdKhXMPyadZAn8qGp/zYbrH4BjTyku/LX+TwKL62pwLDgTFREA9ZbHV2iG1Le36rPX9+CvzS4rGOeE5Wv4q6eR10ME4OtgfLviE722B8NI23YO7I8KJMalOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYjK6TNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F50C4CEEA;
	Tue, 20 May 2025 14:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747752217;
	bh=dMf1Hn1YFj52yUn5Y4UeSWZ0jKMtxnmOoQG7WaiFNhI=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=WYjK6TNjU6+nDlVUtQbrEOuewTyt56yN01ehMNTUaBhvJRqpmq811mBXrh4FU83qP
	 AyJH4TyLsv7p80vyDjWrnCPiA9RP0ZiRFjmWWZLI7pTvAl5F0pWFB51XxYY4wVkIMA
	 2nWwd9OTlguVl7hkXh1Xnz/hqNbbwECMxeGLimjWrwWqTwJTyJLvJ7/MK+o8Qrdg+L
	 lQRyVCsMiAoB13VCCWoqhJBkx5zaixx1p7B7HD8PNSs8Xrg4piDNP9nzNkoIJXqMpW
	 HX7vTMuODfeHdQ0c+eSjPXZb6QxPqgXqDDuWqmCtfST8b7z0fdXET3EQQPYRQj5n5F
	 l9CnIsD48yLhQ==
Message-ID: <517ab3641097d106bfc1c7c86d4364408eac7345.camel@kernel.org>
Subject: Re: [syzbot] [net?] [nfs?] KASAN: slab-out-of-bounds Read in
 cache_clean
From: Jeff Layton <jlayton@kernel.org>
To: syzbot <syzbot+a15182e1a4094a69cbec@syzkaller.appspotmail.com>, 
	Dai.Ngo@oracle.com, anna@kernel.org, chuck.lever@oracle.com,
 davem@davemloft.net, 	edumazet@google.com, horms@kernel.org,
 kuba@kernel.org, 	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 neilb@suse.de, 	netdev@vger.kernel.org, okorniev@redhat.com,
 pabeni@redhat.com, 	syzkaller-bugs@googlegroups.com, tom@talpey.com,
 trondmy@kernel.org
Date: Tue, 20 May 2025 10:43:35 -0400
In-Reply-To: <682c32e0.a00a0220.29bc26.0274.GAE@google.com>
References: <682c32e0.a00a0220.29bc26.0274.GAE@google.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-05-20 at 00:44 -0700, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    088d13246a46 Merge tag 'kbuild-fixes-v6.15' of git://git.=
k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1047ce7058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D30181bfb60dbb=
0a9
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Da15182e1a4094a6=
9cbec
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
>=20
> Unfortunately, I don't have any reproducer for this issue yet.
>=20
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d=
900f083ada3/non_bootable_disk-088d1324.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/273390076ad5/vmlinu=
x-088d1324.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3de2f79595a2/b=
zImage-088d1324.xz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+a15182e1a4094a69cbec@syzkaller.appspotmail.com
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-out-of-bounds in hlist_empty include/linux/list.h:972 [i=
nline]
> BUG: KASAN: slab-out-of-bounds in cache_clean+0x8a0/0x990 net/sunrpc/cach=
e.c:468
> Read of size 8 at addr ffff88802ae03800 by task kworker/1:2/1335
>=20
> CPU: 1 UID: 0 PID: 1335 Comm: kworker/1:2 Not tainted 6.15.0-rc6-syzkalle=
r-00105-g088d13246a46 #0 PREEMPT(full)=20
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2~bpo12+1 04/01/2014
> Workqueue: events_power_efficient do_cache_clean
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:408 [inline]
>  print_report+0xc3/0x670 mm/kasan/report.c:521
>  kasan_report+0xe0/0x110 mm/kasan/report.c:634
>  hlist_empty include/linux/list.h:972 [inline]
>  cache_clean+0x8a0/0x990 net/sunrpc/cache.c:468
>  do_cache_clean net/sunrpc/cache.c:519 [inline]
>  do_cache_clean+0x29/0xa0 net/sunrpc/cache.c:512
>  process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
>  process_scheduled_works kernel/workqueue.c:3319 [inline]
>  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
>  kthread+0x3c2/0x780 kernel/kthread.c:464
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
>=20

This is puzzling:

hlist_empty is just checking whether hlist_head->first is a NULL
pointer, so this probably means we over or underran the hlist array
somehow. The array is allocated in cache_create_net, and is of a fixed
size. AFAICT, the accesses in cache_clean are safe and should never
overrun the allocation (they're bounded by the same value that we use
to allocate the array).

Let us know if you see any more of these. In the meantime, I'll keep
thinking about it.

> Allocated by task 19792:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>  __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
>  kasan_kmalloc include/linux/kasan.h:260 [inline]
>  __do_kmalloc_node mm/slub.c:4327 [inline]
>  __kmalloc_noprof+0x223/0x510 mm/slub.c:4339
>  kmalloc_noprof include/linux/slab.h:909 [inline]
>  kmalloc_array_noprof include/linux/slab.h:948 [inline]
>  cache_create_net+0x9d/0x220 net/sunrpc/cache.c:1746
>  nfsd_idmap_init+0x62/0x250 fs/nfsd/nfs4idmap.c:470
>  nfsd_net_init+0x69/0x3d0 fs/nfsd/nfsctl.c:2198
>  ops_init+0x1df/0x5f0 net/core/net_namespace.c:138
>  setup_net+0x21e/0x850 net/core/net_namespace.c:364
>  copy_net_ns+0x2a6/0x5f0 net/core/net_namespace.c:518
>  create_new_namespaces+0x3ea/0xad0 kernel/nsproxy.c:110
>  unshare_nsproxy_namespaces+0xc0/0x1f0 kernel/nsproxy.c:228
>  ksys_unshare+0x45b/0xa40 kernel/fork.c:3375
>  __do_sys_unshare kernel/fork.c:3446 [inline]
>  __se_sys_unshare kernel/fork.c:3444 [inline]
>  __x64_sys_unshare+0x31/0x40 kernel/fork.c:3444
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> The buggy address belongs to the object at ffff88802ae03000
>  which belongs to the cache kmalloc-2k of size 2048
> The buggy address is located 0 bytes to the right of
>  allocated 2048-byte region [ffff88802ae03000, ffff88802ae03800)
>=20
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2ae0=
0
> head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> anon flags: 0xfff00000000040(head|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> page_type: f5(slab)
> raw: 00fff00000000040 ffff88801b442f00 0000000000000000 dead000000000001
> raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
> head: 00fff00000000040 ffff88801b442f00 0000000000000000 dead000000000001
> head: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
> head: 00fff00000000003 ffffea0000ab8001 00000000ffffffff 00000000ffffffff
> head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(=
__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), =
pid 837, tgid 837 (kworker/3:2), ts 32884542472, free_ts 32014442038
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1718
>  prep_new_page mm/page_alloc.c:1726 [inline]
>  get_page_from_freelist+0x135c/0x3920 mm/page_alloc.c:3688
>  __alloc_frozen_pages_noprof+0x263/0x23a0 mm/page_alloc.c:4970
>  alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2301
>  alloc_slab_page mm/slub.c:2450 [inline]
>  allocate_slab mm/slub.c:2618 [inline]
>  new_slab+0x244/0x340 mm/slub.c:2672
>  ___slab_alloc+0xd9c/0x1940 mm/slub.c:3858
>  __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3948
>  __slab_alloc_node mm/slub.c:4023 [inline]
>  slab_alloc_node mm/slub.c:4184 [inline]
>  __do_kmalloc_node mm/slub.c:4326 [inline]
>  __kmalloc_node_track_caller_noprof+0x2ee/0x510 mm/slub.c:4346
>  kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:599
>  __alloc_skb+0x166/0x380 net/core/skbuff.c:668
>  alloc_skb include/linux/skbuff.h:1340 [inline]
>  mld_newpack.isra.0+0x18e/0xa20 net/ipv6/mcast.c:1788
>  add_grhead+0x299/0x340 net/ipv6/mcast.c:1899
>  add_grec+0x112a/0x1680 net/ipv6/mcast.c:2037
>  mld_send_cr net/ipv6/mcast.c:2163 [inline]
>  mld_ifc_work+0x41f/0xca0 net/ipv6/mcast.c:2702
>  process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
>  process_scheduled_works kernel/workqueue.c:3319 [inline]
>  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
> page last free pid 5792 tgid 5792 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1262 [inline]
>  __free_frozen_pages+0x69d/0xff0 mm/page_alloc.c:2725
>  discard_slab mm/slub.c:2716 [inline]
>  __put_partials+0x16d/0x1c0 mm/slub.c:3185
>  qlink_free mm/kasan/quarantine.c:163 [inline]
>  qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
>  kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
>  __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
>  kasan_slab_alloc include/linux/kasan.h:250 [inline]
>  slab_post_alloc_hook mm/slub.c:4147 [inline]
>  slab_alloc_node mm/slub.c:4196 [inline]
>  __do_kmalloc_node mm/slub.c:4326 [inline]
>  __kmalloc_noprof+0x1d4/0x510 mm/slub.c:4339
>  kmalloc_noprof include/linux/slab.h:909 [inline]
>  tomoyo_realpath_from_path+0xc2/0x6e0 security/tomoyo/realpath.c:251
>  tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
>  tomoyo_path_perm+0x274/0x460 security/tomoyo/file.c:822
>  security_inode_getattr+0x116/0x290 security/security.c:2377
>  vfs_getattr fs/stat.c:256 [inline]
>  vfs_fstat+0x4b/0xd0 fs/stat.c:278
>  __do_sys_newfstat+0x91/0x110 fs/stat.c:546
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Memory state around the buggy address:
>  ffff88802ae03700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff88802ae03780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > ffff88802ae03800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>                    ^
>  ffff88802ae03880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff88802ae03900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>=20
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>=20
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>=20
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>=20
> If you want to undo deduplication, reply with:
> #syz undup

--=20
Jeff Layton <jlayton@kernel.org>

