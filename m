Return-Path: <linux-nfs+bounces-6540-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E7A97BEBA
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Sep 2024 17:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60758283DFB
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Sep 2024 15:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589551C984A;
	Wed, 18 Sep 2024 15:38:28 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E023188A13
	for <linux-nfs@vger.kernel.org>; Wed, 18 Sep 2024 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726673908; cv=none; b=UYij3RLU3EVnUgOcdwiEjmQcknF3peeOupUsoRD2NSAncmnRK+OPtlqUAUx1qFjzjllz2X/QBzer7w4ALXhj6fIX73EssOuZZgoqLG7BDSQCOqJDuqccqlEgYGjYZftx0GAHXn0mOl729xQxHvNuZv9xY2ireDuVYIUIktxtn9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726673908; c=relaxed/simple;
	bh=PHchrZNwO00G4cD6SBV/rWiHFeTrAPKANH77/CTFLLE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qV/1qpBFofDNn8a7NolJPtQwXuuZZ07Sl+JY688+qF5DLSPQ9Cj24DoCmK3KZTIiuADUBcw5q3ERKwp+x6Eay9f0lOEnTwNtMc2ZW70/FavISIYHuXrAgj1+3YMbpUkmm8C2Pt+zojGgBaegjJ0BKfRXggr4um7XRLaFNYj/qfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39f510b3f81so9165855ab.0
        for <linux-nfs@vger.kernel.org>; Wed, 18 Sep 2024 08:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726673905; x=1727278705;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nZj8qocP7jmkn1d6fR4Qa2YU+VS7nEfvLKSI3AtwxIY=;
        b=cE0iRgT3clF9TozPFVAnM7ibcvPRLSBlZrZ4wQRKxDdqr8G8gT0OLC6D4Kh10EFbgY
         NpMTKS/q+pBdu7+RCURuflWL1DxuEdEEuK1W1/7cVtRxLKFWDhPAx6dmF1q8SkLt7trA
         /eA1Di8DapQtTlEsdlLY/2H4PA4E0fA+Q/r192X+C9aOuF75gR5zMGJ4cWSmbx7glxPh
         cpt2WkenI769YMkwWIXqx2tShvwhlIHhZkZiK2GrwMxlABxGTAed013VkrdjsF3gdP2F
         mbF3TPMfXrki9fLR3C+q0SBS3y+Ab/y1MA0ysu4YGvDWi9HmskDxdlYzbtadjB3YSc4+
         oV3w==
X-Forwarded-Encrypted: i=1; AJvYcCWlEUa46TKLxMhvTSmYFgkdtmmT3JkR6KuERWU4/QglA5ur9BE0DYpdjImPWIVTd2muVmR3HNUmDqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL+jqXbwXiw29uVvbGK7ellsG07IfBGM0rWJfH2GRwZFM+5umt
	bnMR8Fcke/96ld6aG6+gJ8zK0UKnIIdvA94z2M9SaydE2hz+Cc7tGbq9ZMj/J4swVP1DwMFwzx6
	6tqo08ZKPR2bqZE1/BZNDw75fTfea+z5q42NmHaABNLT4z/i3+vFNqf8=
X-Google-Smtp-Source: AGHT+IG2GsSXmO3sEdAW7A4SI04HbayGv9ELQqkyzE9qEpxjq4TNlfDPCUlZwIRH4AdSLHxbtuB0R/LugSQOjd0NWEk4Uf6CYgQW
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24c:0:b0:395:e85e:f2fa with SMTP id
 e9e14a558f8ab-3a0bef4be99mr256555ab.1.1726673905538; Wed, 18 Sep 2024
 08:38:25 -0700 (PDT)
Date: Wed, 18 Sep 2024 08:38:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66eaf3f1.050a0220.252d9a.0019.GAE@google.com>
Subject: [syzbot] [nfs?] KASAN: slab-use-after-free Read in rhashtable_walk_enter
From: syzbot <syzbot+24cd636199753ac5e0ca@syzkaller.appspotmail.com>
To: Dai.Ngo@oracle.com, chuck.lever@oracle.com, jlayton@kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, neilb@suse.de, 
	okorniev@redhat.com, syzkaller-bugs@googlegroups.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a430d95c5efa Merge tag 'lsm-pr-20240911' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c7469f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a69c66e868285a9d
dashboard link: https://syzkaller.appspot.com/bug?extid=24cd636199753ac5e0ca
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7f3aff905e91/disk-a430d95c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a468ce8431f0/vmlinux-a430d95c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/80d4f1150155/bzImage-a430d95c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+24cd636199753ac5e0ca@syzkaller.appspotmail.com

svc: failed to register nfsdv3 RPC service (errno 111).
svc: failed to register nfsaclv3 RPC service (errno 111).
==================================================================
BUG: KASAN: slab-use-after-free in list_add include/linux/list.h:169 [inline]
BUG: KASAN: slab-use-after-free in rhashtable_walk_enter+0x333/0x370 lib/rhashtable.c:684
Read of size 8 at addr ffff8880773fa010 by task syz.2.11924/9970

CPU: 0 UID: 0 PID: 9970 Comm: syz.2.11924 Not tainted 6.11.0-syzkaller-02574-ga430d95c5efa #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 list_add include/linux/list.h:169 [inline]
 rhashtable_walk_enter+0x333/0x370 lib/rhashtable.c:684
 rhltable_walk_enter include/linux/rhashtable.h:1262 [inline]
 __nfsd_file_cache_purge+0xad/0x490 fs/nfsd/filecache.c:805
 nfsd_file_cache_shutdown+0xcf/0x480 fs/nfsd/filecache.c:897
 nfsd_shutdown_generic fs/nfsd/nfssvc.c:329 [inline]
 nfsd_shutdown_generic fs/nfsd/nfssvc.c:323 [inline]
 nfsd_startup_net fs/nfsd/nfssvc.c:444 [inline]
 nfsd_svc+0x6d4/0x970 fs/nfsd/nfssvc.c:817
 nfsd_nl_threads_set_doit+0x52c/0xbc0 fs/nfsd/nfsctl.c:1714
 genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x9ae/0xb40 net/socket.c:2603
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2657
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2686
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd947f7def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd948e38038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fd948135f80 RCX: 00007fd947f7def9
RDX: 0000000000000004 RSI: 0000000020000280 RDI: 0000000000000003
RBP: 00007fd947ff0b76 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fd948135f80 R15: 00007ffc6cab9d78
 </TASK>

Allocated by task 8716:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4159 [inline]
 __kmalloc_node_track_caller_noprof+0x20f/0x440 mm/slub.c:4178
 kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:609
 __alloc_skb+0x164/0x380 net/core/skbuff.c:678
 alloc_skb include/linux/skbuff.h:1322 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
 nsim_dev_trap_report_work+0x2a4/0xc80 drivers/net/netdevsim/dev.c:850
 process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 8716:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2250 [inline]
 slab_free mm/slub.c:4474 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4595
 skb_kfree_head net/core/skbuff.c:1086 [inline]
 skb_free_head+0x108/0x1d0 net/core/skbuff.c:1098
 skb_release_data+0x75d/0x990 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 __kfree_skb net/core/skbuff.c:1204 [inline]
 consume_skb net/core/skbuff.c:1436 [inline]
 consume_skb+0xbf/0x100 net/core/skbuff.c:1430
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:821 [inline]
 nsim_dev_trap_report_work+0x878/0xc80 drivers/net/netdevsim/dev.c:850
 process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff8880773fa000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 16 bytes inside of
 freed 4096-byte region [ffff8880773fa000, ffff8880773fb000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x773f8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000040 ffff88801ac42140 ffffea0001e63600 dead000000000002
raw: 0000000000000000 0000000000040004 00000001fdffffff 0000000000000000
head: 00fff00000000040 ffff88801ac42140 ffffea0001e63600 dead000000000002
head: 0000000000000000 0000000000040004 00000001fdffffff 0000000000000000
head: 00fff00000000003 ffffea0001dcfe01 ffffffffffffffff 0000000000000000
head: 0000000700000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5240, tgid 5240 (syz-executor), ts 74499202771, free_ts 74134964798
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1500
 prep_new_page mm/page_alloc.c:1508 [inline]
 get_page_from_freelist+0x1351/0x2e50 mm/page_alloc.c:3446
 __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4702
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x4e/0xf0 mm/slub.c:2319
 allocate_slab mm/slub.c:2482 [inline]
 new_slab+0x84/0x260 mm/slub.c:2535
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3721
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3811
 __slab_alloc_node mm/slub.c:3864 [inline]
 slab_alloc_node mm/slub.c:4026 [inline]
 __do_kmalloc_node mm/slub.c:4158 [inline]
 __kmalloc_noprof+0x379/0x410 mm/slub.c:4171
 kmalloc_noprof include/linux/slab.h:694 [inline]
 tomoyo_realpath_from_path+0xbf/0x710 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_number_perm+0x245/0x5b0 security/tomoyo/file.c:723
 security_file_ioctl+0x9b/0x240 security/security.c:2908
 __do_sys_ioctl fs/ioctl.c:901 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0xbb/0x210 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5233 tgid 5233 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1101 [inline]
 free_unref_folios+0x9e9/0x1390 mm/page_alloc.c:2667
 folios_put_refs+0x560/0x760 mm/swap.c:1039
 free_pages_and_swap_cache+0x36d/0x510 mm/swap_state.c:332
 __tlb_batch_free_encoded_pages+0xf9/0x290 mm/mmu_gather.c:136
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu mm/mmu_gather.c:373 [inline]
 tlb_finish_mmu+0x168/0x7b0 mm/mmu_gather.c:465
 unmap_region+0x342/0x420 mm/mmap.c:2441
 do_vmi_align_munmap+0x1107/0x19c0 mm/mmap.c:2754
 do_vmi_munmap+0x231/0x410 mm/mmap.c:2830
 __vm_munmap+0x142/0x330 mm/mmap.c:3109
 __do_sys_munmap mm/mmap.c:3126 [inline]
 __se_sys_munmap mm/mmap.c:3123 [inline]
 __x64_sys_munmap+0x61/0x90 mm/mmap.c:3123
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880773f9f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880773f9f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880773fa000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff8880773fa080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880773fa100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

