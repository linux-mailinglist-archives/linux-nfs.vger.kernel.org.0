Return-Path: <linux-nfs+bounces-6579-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD6997D9C5
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2024 21:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9A0283708
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2024 19:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4566013D26B;
	Fri, 20 Sep 2024 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggAS5iCO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105A5224CC;
	Fri, 20 Sep 2024 19:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726859616; cv=none; b=YbBiTnjMWkST1HQkpUpI6mCbjK4Y7keKa1JhCoVK692TkvMUx1Jz5hucu5yTQlcnXFGhLXPK90Ex1TJU9bONDukjBnSLrrcf7wMFiWRgt0PZaG1eDoIYPN115nQb8vwLDII7Y1bzOeSpwmul+M7+tGqk4aGFbP/xAX4n5h4YAIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726859616; c=relaxed/simple;
	bh=dmrBVZBub6z8m6i4sdtUOc56DzJE9mt3FneIdi6cMMM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ObsbSmG+Kw0OpKYls8PLYgK7qYXE95Tb/4RUec+H50b6qmVza3hVd7oRFS4QayOOG+GARTllU750kmlq7EHeyve8ldnMpKzAzCkT5xgVm+QcEVMBSbdYYTIpHQX1LWGZuGED38Sqgir7uO+Y142NtLGXQn+VZ30PdA/zfamZcPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggAS5iCO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4BEC4CEC3;
	Fri, 20 Sep 2024 19:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726859615;
	bh=dmrBVZBub6z8m6i4sdtUOc56DzJE9mt3FneIdi6cMMM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ggAS5iCOQ+vIpEBcVeClmrjs9locHEr7cMOHiRN9SEexikCdtBAhqxjmsjAzQG6OO
	 2roQT4Dg0KlpdLRJHilaW49aIomA0Oe9FzNcbYpV94NeHqH0WaAXZFf7iEZf20b+o4
	 FIbP6IUfMcc2N+mXR8/M8iP3LwtglGB807ow3C6/2QVOZEYa84wssIruKrO1OhSUZp
	 33U1yQzNw4+9uh7bfOjkCXKz3eKggroV5H177oQGrBTaJT2AV2I4g2+ux3L1Ngm1/E
	 08KCGJfZOEBh5KlC/q6LKAQyuOCMEyy8ujBxe9Ik0fJQ8OR2eh++RNDJMfjhiQWAFK
	 DDWwLuxE/4KJw==
Message-ID: <e5d19ed12bffaac5d6ac41d54836451b87b8fc2a.camel@kernel.org>
Subject: Re: [syzbot] [nfs?] KASAN: slab-use-after-free Read in
 rhashtable_walk_enter
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>
Cc: syzbot <syzbot+24cd636199753ac5e0ca@syzkaller.appspotmail.com>, Dai Ngo
 <dai.ngo@oracle.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>,  Linux NFS Mailing List
 <linux-nfs@vger.kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>, Tom
 Talpey <tom@talpey.com>
Date: Fri, 20 Sep 2024 21:13:31 +0200
In-Reply-To: <96DE704B-2EB0-43D5-B34C-3323840F1BB2@oracle.com>
References: <66eaf3f1.050a0220.252d9a.0019.GAE@google.com>
	 <18e1d9caf56a56fadabd6abb82c63e0ba0c3dc34.camel@kernel.org>
	 <172680104122.17050.16032356795670302194@noble.neil.brown.name>
	 <96DE704B-2EB0-43D5-B34C-3323840F1BB2@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-20 at 18:51 +0000, Chuck Lever III wrote:
>=20
> > On Sep 19, 2024, at 10:57=E2=80=AFPM, NeilBrown <neilb@suse.de> wrote:
> >=20
> > On Thu, 19 Sep 2024, Jeff Layton wrote:
> > > On Wed, 2024-09-18 at 08:38 -0700, syzbot wrote:
> > > > Hello,
> > > >=20
> > > > syzbot found the following issue on:
> > > >=20
> > > > HEAD commit:    a430d95c5efa Merge tag 'lsm-pr-20240911' of git://g=
it.kern..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D17c7469=
f980000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da69c66e=
868285a9d
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D24cd63619=
9753ac5e0ca
> > > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils=
 for Debian) 2.40
> > > >=20
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > >=20
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/7f3aff905e=
91/disk-a430d95c.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/a468ce8431f0/=
vmlinux-a430d95c.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/80d4f115=
0155/bzImage-a430d95c.xz
> > > >=20
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by: syzbot+24cd636199753ac5e0ca@syzkaller.appspotmail.com
> > > >=20
> > > > svc: failed to register nfsdv3 RPC service (errno 111).
> > > > svc: failed to register nfsaclv3 RPC service (errno 111).
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > BUG: KASAN: slab-use-after-free in list_add include/linux/list.h:16=
9 [inline]
> > > > BUG: KASAN: slab-use-after-free in rhashtable_walk_enter+0x333/0x37=
0 lib/rhashtable.c:684
> > > > Read of size 8 at addr ffff8880773fa010 by task syz.2.11924/9970
> > > >=20
> > > > CPU: 0 UID: 0 PID: 9970 Comm: syz.2.11924 Not tainted 6.11.0-syzkal=
ler-02574-ga430d95c5efa #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 08/06/2024
> > > > Call Trace:
> > > > <TASK>
> > > > __dump_stack lib/dump_stack.c:93 [inline]
> > > > dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
> > > > print_address_description mm/kasan/report.c:377 [inline]
> > > > print_report+0xc3/0x620 mm/kasan/report.c:488
> > > > kasan_report+0xd9/0x110 mm/kasan/report.c:601
> > > > list_add include/linux/list.h:169 [inline]
> > > > rhashtable_walk_enter+0x333/0x370 lib/rhashtable.c:684
> > > > rhltable_walk_enter include/linux/rhashtable.h:1262 [inline]
> > > > __nfsd_file_cache_purge+0xad/0x490 fs/nfsd/filecache.c:805
> > > > nfsd_file_cache_shutdown+0xcf/0x480 fs/nfsd/filecache.c:897
> > > > nfsd_shutdown_generic fs/nfsd/nfssvc.c:329 [inline]
> > > > nfsd_shutdown_generic fs/nfsd/nfssvc.c:323 [inline]
> > > > nfsd_startup_net fs/nfsd/nfssvc.c:444 [inline]
> > > > nfsd_svc+0x6d4/0x970 fs/nfsd/nfssvc.c:817
> > > > nfsd_nl_threads_set_doit+0x52c/0xbc0 fs/nfsd/nfsctl.c:1714
> > > > genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
> > > > genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
> > > > genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
> > > > netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2550
> > > > genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
> > > > netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
> > > > netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
> > > > netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
> > > > sock_sendmsg_nosec net/socket.c:730 [inline]
> > > > __sock_sendmsg net/socket.c:745 [inline]
> > > > ____sys_sendmsg+0x9ae/0xb40 net/socket.c:2603
> > > > ___sys_sendmsg+0x135/0x1e0 net/socket.c:2657
> > > > __sys_sendmsg+0x117/0x1f0 net/socket.c:2686
> > > > do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > > do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
> > > > entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > RIP: 0033:0x7fd947f7def9
> > > > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 4=
8 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01=
 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > > > RSP: 002b:00007fd948e38038 EFLAGS: 00000246 ORIG_RAX: 0000000000000=
02e
> > > > RAX: ffffffffffffffda RBX: 00007fd948135f80 RCX: 00007fd947f7def9
> > > > RDX: 0000000000000004 RSI: 0000000020000280 RDI: 0000000000000003
> > > > RBP: 00007fd947ff0b76 R08: 0000000000000000 R09: 0000000000000000
> > > > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > > > R13: 0000000000000000 R14: 00007fd948135f80 R15: 00007ffc6cab9d78
> > > > </TASK>
> > > >=20
> > > > Allocated by task 8716:
> > > > kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
> > > > kasan_save_track+0x14/0x30 mm/kasan/common.c:68
> > > > poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
> > > > __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
> > > > kasan_kmalloc include/linux/kasan.h:211 [inline]
> > > > __do_kmalloc_node mm/slub.c:4159 [inline]
> > > > __kmalloc_node_track_caller_noprof+0x20f/0x440 mm/slub.c:4178
> > > > kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:609
> > > > __alloc_skb+0x164/0x380 net/core/skbuff.c:678
> > > > alloc_skb include/linux/skbuff.h:1322 [inline]
> > > > nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
> > > > nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
> > > > nsim_dev_trap_report_work+0x2a4/0xc80 drivers/net/netdevsim/dev.c:8=
50
> > > > process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
> > > > process_scheduled_works kernel/workqueue.c:3312 [inline]
> > > > worker_thread+0x6c8/0xf00 kernel/workqueue.c:3393
> > > > kthread+0x2c1/0x3a0 kernel/kthread.c:389
> > > > ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> > > > ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> > > >=20
> > > > Freed by task 8716:
> > > > kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
> > > > kasan_save_track+0x14/0x30 mm/kasan/common.c:68
> > > > kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
> > > > poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
> > > > __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
> > > > kasan_slab_free include/linux/kasan.h:184 [inline]
> > > > slab_free_hook mm/slub.c:2250 [inline]
> > > > slab_free mm/slub.c:4474 [inline]
> > > > kfree+0x12a/0x3b0 mm/slub.c:4595
> > > > skb_kfree_head net/core/skbuff.c:1086 [inline]
> > > > skb_free_head+0x108/0x1d0 net/core/skbuff.c:1098
> > > > skb_release_data+0x75d/0x990 net/core/skbuff.c:1125
> > > > skb_release_all net/core/skbuff.c:1190 [inline]
> > > > __kfree_skb net/core/skbuff.c:1204 [inline]
> > > > consume_skb net/core/skbuff.c:1436 [inline]
> > > > consume_skb+0xbf/0x100 net/core/skbuff.c:1430
> > > > nsim_dev_trap_report drivers/net/netdevsim/dev.c:821 [inline]
> > > > nsim_dev_trap_report_work+0x878/0xc80 drivers/net/netdevsim/dev.c:8=
50
> > > > process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
> > > > process_scheduled_works kernel/workqueue.c:3312 [inline]
> > > > worker_thread+0x6c8/0xf00 kernel/workqueue.c:3393
> > > > kthread+0x2c1/0x3a0 kernel/kthread.c:389
> > > > ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> > > > ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> > > >=20
> > > > The buggy address belongs to the object at ffff8880773fa000
> > > > which belongs to the cache kmalloc-4k of size 4096
> > > > The buggy address is located 16 bytes inside of
> > > > freed 4096-byte region [ffff8880773fa000, ffff8880773fb000)
> > > >=20
> > > > The buggy address belongs to the physical page:
> > > > page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:=
0x773f8
> > > > head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincou=
nt:0
> > > > flags: 0xfff00000000040(head|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> > > > page_type: 0xfdffffff(slab)
> > > > raw: 00fff00000000040 ffff88801ac42140 ffffea0001e63600 dead0000000=
00002
> > > > raw: 0000000000000000 0000000000040004 00000001fdffffff 00000000000=
00000
> > > > head: 00fff00000000040 ffff88801ac42140 ffffea0001e63600 dead000000=
000002
> > > > head: 0000000000000000 0000000000040004 00000001fdffffff 0000000000=
000000
> > > > head: 00fff00000000003 ffffea0001dcfe01 ffffffffffffffff 0000000000=
000000
> > > > head: 0000000700000008 0000000000000000 00000000ffffffff 0000000000=
000000
> > > > page dumped because: kasan: bad access detected
> > > > page_owner tracks the page as allocated
> > > > page last allocated via order 3, migratetype Unmovable, gfp_mask 0x=
d2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid=
 5240, tgid 5240 (syz-executor), ts 74499202771, free_ts 74134964798
> > > > set_page_owner include/linux/page_owner.h:32 [inline]
> > > > post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1500
> > > > prep_new_page mm/page_alloc.c:1508 [inline]
> > > > get_page_from_freelist+0x1351/0x2e50 mm/page_alloc.c:3446
> > > > __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4702
> > > > __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
> > > > alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
> > > > alloc_slab_page+0x4e/0xf0 mm/slub.c:2319
> > > > allocate_slab mm/slub.c:2482 [inline]
> > > > new_slab+0x84/0x260 mm/slub.c:2535
> > > > ___slab_alloc+0xdac/0x1870 mm/slub.c:3721
> > > > __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3811
> > > > __slab_alloc_node mm/slub.c:3864 [inline]
> > > > slab_alloc_node mm/slub.c:4026 [inline]
> > > > __do_kmalloc_node mm/slub.c:4158 [inline]
> > > > __kmalloc_noprof+0x379/0x410 mm/slub.c:4171
> > > > kmalloc_noprof include/linux/slab.h:694 [inline]
> > > > tomoyo_realpath_from_path+0xbf/0x710 security/tomoyo/realpath.c:251
> > > > tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
> > > > tomoyo_path_number_perm+0x245/0x5b0 security/tomoyo/file.c:723
> > > > security_file_ioctl+0x9b/0x240 security/security.c:2908
> > > > __do_sys_ioctl fs/ioctl.c:901 [inline]
> > > > __se_sys_ioctl fs/ioctl.c:893 [inline]
> > > > __x64_sys_ioctl+0xbb/0x210 fs/ioctl.c:893
> > > > do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > > do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
> > > > entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > page last free pid 5233 tgid 5233 stack trace:
> > > > reset_page_owner include/linux/page_owner.h:25 [inline]
> > > > free_pages_prepare mm/page_alloc.c:1101 [inline]
> > > > free_unref_folios+0x9e9/0x1390 mm/page_alloc.c:2667
> > > > folios_put_refs+0x560/0x760 mm/swap.c:1039
> > > > free_pages_and_swap_cache+0x36d/0x510 mm/swap_state.c:332
> > > > __tlb_batch_free_encoded_pages+0xf9/0x290 mm/mmu_gather.c:136
> > > > tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
> > > > tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
> > > > tlb_flush_mmu mm/mmu_gather.c:373 [inline]
> > > > tlb_finish_mmu+0x168/0x7b0 mm/mmu_gather.c:465
> > > > unmap_region+0x342/0x420 mm/mmap.c:2441
> > > > do_vmi_align_munmap+0x1107/0x19c0 mm/mmap.c:2754
> > > > do_vmi_munmap+0x231/0x410 mm/mmap.c:2830
> > > > __vm_munmap+0x142/0x330 mm/mmap.c:3109
> > > > __do_sys_munmap mm/mmap.c:3126 [inline]
> > > > __se_sys_munmap mm/mmap.c:3123 [inline]
> > > > __x64_sys_munmap+0x61/0x90 mm/mmap.c:3123
> > > > do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > > do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
> > > > entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > >=20
> > > > Memory state around the buggy address:
> > > > ffff8880773f9f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > > ffff8880773f9f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > > > ffff8880773fa000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > >                         ^
> > > > ffff8880773fa080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > > ffff8880773fa100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >=20
> > > >=20
> > > > ---
> > > > This report is generated by a bot. It may contain errors.
> > > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > >=20
> > > > syzbot will keep track of this issue. See:
> > > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > > >=20
> > > > If the report is already addressed, let syzbot know by replying wit=
h:
> > > > #syz fix: exact-commit-title
> > > >=20
> > > > If you want to overwrite report's subsystems, reply with:
> > > > #syz set subsystems: new-subsystem
> > > > (See the list of subsystem names on the web dashboard)
> > > >=20
> > > > If the report is a duplicate of another one, reply with:
> > > > #syz dup: exact-subject-of-another-report
> > > >=20
> > > > If you want to undo deduplication, reply with:
> > > > #syz undup
> > >=20
> > > So we're tearing down the server and cleaning out the nfsd_file hash,
> > > and we hit a UAF. That probably means that we freed a nfsd_file witho=
ut
> > > removing it from the hash? Maybe we should add a WARN_ON() in
> > > nfsd_file_slab_free that checks whether the item is still hashed?
> > >=20
> > > It is strange though. struct nfsd_file is 112 bytes on my machine, bu=
t
> > > the warning is about a 4k allocation. I guess that just means that th=
e
> > > page got recycled into a different slabcache.
> >=20
> > The code that is crashing hasn't come close to touching anything that i=
s
> > thought to be an nfsd_file.
> > The error is detected in the list_add() in rhashtable_walk_enter() when
> > the new on-stack iterator is being attached to the bucket_table that is=
 being
> > iterated.  So that bucket_table must (now) be an invalid address.
> >=20
> > The handling of NFSD_FILE_CACHE_UP is strange.  nfsd_file_cache_init()
> > sets it, but doesn't clear it on failure.  So if nfsd_file_cache_init()
> > fails for some reason, nfsd_file_cache_shutdown() would still try to
> > clean up if it was called.
> >=20
> > So suppose nfsd_startup_generic() is called.  It increments nfsd_users
> > from 0 so continues to nfsd_file_cache_init() which fails for some
> > reason after initialising nfsd_file_rhltable and then destroying it.
> > This will leave nfsd_file_rhltable.tbl as a pointer to a large
> > allocation which has been freed.  nfsd_startup_generic() will then
> > decrement nfsd_users back to zero, but NFSD_FILE_CACHE_UP will still be
> > set.
> >=20
> > When nfsd_startup_generic() is called again, nfsd_file_cache_init() wil=
l
> > skip initialisation because NFSD_FILE_CACHE_UP is set.  When
> > nfsd_file_cache_shutdown() is then called it will clean up an rhltable
> > that has already been destroyed.  We get exactly the reported symptom.
> >=20
> > I *think* nfsd_file_cache_init() can only fail with -ENOMEM and I would
> > expect to see a warning when that happened.  In any case
> > nfsd_file_cache_init() uses pr_err() for any failure except
> > rhltable_init(), and that only fails if the params are inconsistent.
> >=20
> > So I think there are problems with NFSD_FILE_CACHE_UP settings and I
> > think they could trigger this bug if a kmalloc failed, but I don't thin=
k
> > that a kmalloc failed and I think there must be some other explanation
> > here.
>=20
> Also, the FILE_CACHE_UP logic has been around for several releases.
> Why is this UAF showing up only now? The "unable to register"
> messages suggest a possible reason.
>=20

Good point. I didn't notice those. 111 is ECONNREFUSED, so it sounds
like rpcbind isn't up in this situation. Maybe that's a hint toward a
reproducer?

--=20
Jeff Layton <jlayton@kernel.org>

