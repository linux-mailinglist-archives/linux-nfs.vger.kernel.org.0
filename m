Return-Path: <linux-nfs+bounces-11835-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4307ABD0B3
	for <lists+linux-nfs@lfdr.de>; Tue, 20 May 2025 09:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56981B645E4
	for <lists+linux-nfs@lfdr.de>; Tue, 20 May 2025 07:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389D225DB0D;
	Tue, 20 May 2025 07:44:35 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550AB25DB09
	for <linux-nfs@vger.kernel.org>; Tue, 20 May 2025 07:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747727075; cv=none; b=cTY59H9MPrGUh4dhmWJ4mvlXaKQZACl2hmbAVWhoLLfyBGFNVawLYquvn7NZJWTBZgm13YW7I2lk47xkMK2lQ5O6Xd0//hQQLe2YdHGyNQ3QZRLw+TYASQxXJ86igae0cmIIwsBB5X76ot3mvHnMD1FexknSzelKHnoC1alcP/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747727075; c=relaxed/simple;
	bh=ZorFAwBbLzmqqwLs6qQTXcA9LWMey+cSU32Dibx+Twk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jwmF5tIE5fmOivGOwbvymimUKYC5I8JlBbnYOuwnJdwKMQrdKqK6XHa4JPz/miIZ6Nv5WZQKcPzdpPD57wvSmXRYefNkKl8ZLfMN/5YGbhgNZctio7SsMQFHs6nZKtEJzK9jQTiM5QmNTDZ2w92C1iYcHFMZzLGMpqU6SP29F9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-85b5875e250so617022239f.0
        for <linux-nfs@vger.kernel.org>; Tue, 20 May 2025 00:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747727072; x=1748331872;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lXTn0uFs/zpHcdgwQzrvYgeEZBncnm7hDcWxaM7Qg4Y=;
        b=sMXc72tmq2jiFe364RERfHHpW2d5MZxl87Gfau/0FCG9iiUh+/pHX2AESCBk+1XIws
         OjMjM9j/XhnN2xlwz5oXUiNJC4j3+/l98F127E8aeLkzXV6s4IWk5D27FY6nzAQyzKkl
         xXCLd2kO3O0/9ol33kTPgh2xiBUucLETE5p6qcsG4FPvQVkPaU81pS8Ec34pCDgoEaqP
         R+N37XxrVNBXqtgNmpq4+EA4LXyRY/Kgz3SdLhMYNc+pYzFt37oAvgEnMNHvIEqoArYq
         e+CY58yxAXmio5XRhxj9yCD/Z8tq41Kbtpn6Ijyhp/xcIwGq/s1/0QFmiEr8PHRkGAdF
         4Q6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUczDu+rInuqzso6v4bFcXqzuxu1JL+7HLGaKyGpj9nehDPyXaKbX8iu36Gw/fmOkEu6eXY6lJteJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ1hfnnbCUph2JZ3CX8j06+Z2uhmrmUQexnIXWBdVkE9QuBHiP
	0fmC/kQ7KQw+3S+UaIiyKo/lHakjMB6kvjzBNDkpvjy14BtbXvG7INJ1QD6NRnrWMoUOcKXXGRQ
	U+c29XONk+S1GkVaPh4auIZmGLdulzooOARHcVZvQZnWQ2Z1AapAIDIXLIWc=
X-Google-Smtp-Source: AGHT+IEADEopJ8mYcz+ruDd+m3udPRRwUh1XWJnoOsOFne0SoVNQgOwcAnBClvDKzlH1uV17VQFaWxwYtC/PZvP51v1T9TjgLiwu
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4802:b0:864:48eb:30fd with SMTP id
 ca18e2360f4ac-86a23227308mr1743532039f.11.1747727072426; Tue, 20 May 2025
 00:44:32 -0700 (PDT)
Date: Tue, 20 May 2025 00:44:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682c32e0.a00a0220.29bc26.0274.GAE@google.com>
Subject: [syzbot] [net?] [nfs?] KASAN: slab-out-of-bounds Read in cache_clean
From: syzbot <syzbot+a15182e1a4094a69cbec@syzkaller.appspotmail.com>
To: Dai.Ngo@oracle.com, anna@kernel.org, chuck.lever@oracle.com, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jlayton@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, neilb@suse.de, netdev@vger.kernel.org, 
	okorniev@redhat.com, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tom@talpey.com, trondmy@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    088d13246a46 Merge tag 'kbuild-fixes-v6.15' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1047ce70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=30181bfb60dbb0a9
dashboard link: https://syzkaller.appspot.com/bug?extid=a15182e1a4094a69cbec
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-088d1324.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/273390076ad5/vmlinux-088d1324.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3de2f79595a2/bzImage-088d1324.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a15182e1a4094a69cbec@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in hlist_empty include/linux/list.h:972 [inline]
BUG: KASAN: slab-out-of-bounds in cache_clean+0x8a0/0x990 net/sunrpc/cache.c:468
Read of size 8 at addr ffff88802ae03800 by task kworker/1:2/1335

CPU: 1 UID: 0 PID: 1335 Comm: kworker/1:2 Not tainted 6.15.0-rc6-syzkaller-00105-g088d13246a46 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_power_efficient do_cache_clean
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 hlist_empty include/linux/list.h:972 [inline]
 cache_clean+0x8a0/0x990 net/sunrpc/cache.c:468
 do_cache_clean net/sunrpc/cache.c:519 [inline]
 do_cache_clean+0x29/0xa0 net/sunrpc/cache.c:512
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 19792:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_noprof+0x223/0x510 mm/slub.c:4339
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kmalloc_array_noprof include/linux/slab.h:948 [inline]
 cache_create_net+0x9d/0x220 net/sunrpc/cache.c:1746
 nfsd_idmap_init+0x62/0x250 fs/nfsd/nfs4idmap.c:470
 nfsd_net_init+0x69/0x3d0 fs/nfsd/nfsctl.c:2198
 ops_init+0x1df/0x5f0 net/core/net_namespace.c:138
 setup_net+0x21e/0x850 net/core/net_namespace.c:364
 copy_net_ns+0x2a6/0x5f0 net/core/net_namespace.c:518
 create_new_namespaces+0x3ea/0xad0 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xc0/0x1f0 kernel/nsproxy.c:228
 ksys_unshare+0x45b/0xa40 kernel/fork.c:3375
 __do_sys_unshare kernel/fork.c:3446 [inline]
 __se_sys_unshare kernel/fork.c:3444 [inline]
 __x64_sys_unshare+0x31/0x40 kernel/fork.c:3444
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802ae03000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 0 bytes to the right of
 allocated 2048-byte region [ffff88802ae03000, ffff88802ae03800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2ae00
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b442f00 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b442f00 0000000000000000 dead000000000001
head: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0000ab8001 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 837, tgid 837 (kworker/3:2), ts 32884542472, free_ts 32014442038
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1718
 prep_new_page mm/page_alloc.c:1726 [inline]
 get_page_from_freelist+0x135c/0x3920 mm/page_alloc.c:3688
 __alloc_frozen_pages_noprof+0x263/0x23a0 mm/page_alloc.c:4970
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2301
 alloc_slab_page mm/slub.c:2450 [inline]
 allocate_slab mm/slub.c:2618 [inline]
 new_slab+0x244/0x340 mm/slub.c:2672
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3858
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3948
 __slab_alloc_node mm/slub.c:4023 [inline]
 slab_alloc_node mm/slub.c:4184 [inline]
 __do_kmalloc_node mm/slub.c:4326 [inline]
 __kmalloc_node_track_caller_noprof+0x2ee/0x510 mm/slub.c:4346
 kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:599
 __alloc_skb+0x166/0x380 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1340 [inline]
 mld_newpack.isra.0+0x18e/0xa20 net/ipv6/mcast.c:1788
 add_grhead+0x299/0x340 net/ipv6/mcast.c:1899
 add_grec+0x112a/0x1680 net/ipv6/mcast.c:2037
 mld_send_cr net/ipv6/mcast.c:2163 [inline]
 mld_ifc_work+0x41f/0xca0 net/ipv6/mcast.c:2702
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
page last free pid 5792 tgid 5792 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1262 [inline]
 __free_frozen_pages+0x69d/0xff0 mm/page_alloc.c:2725
 discard_slab mm/slub.c:2716 [inline]
 __put_partials+0x16d/0x1c0 mm/slub.c:3185
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4147 [inline]
 slab_alloc_node mm/slub.c:4196 [inline]
 __do_kmalloc_node mm/slub.c:4326 [inline]
 __kmalloc_noprof+0x1d4/0x510 mm/slub.c:4339
 kmalloc_noprof include/linux/slab.h:909 [inline]
 tomoyo_realpath_from_path+0xc2/0x6e0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x274/0x460 security/tomoyo/file.c:822
 security_inode_getattr+0x116/0x290 security/security.c:2377
 vfs_getattr fs/stat.c:256 [inline]
 vfs_fstat+0x4b/0xd0 fs/stat.c:278
 __do_sys_newfstat+0x91/0x110 fs/stat.c:546
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88802ae03700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88802ae03780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88802ae03800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff88802ae03880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802ae03900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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

