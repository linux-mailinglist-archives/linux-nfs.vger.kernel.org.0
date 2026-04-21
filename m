Return-Path: <linux-nfs+bounces-20985-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGmTL6Ka52lj+QEAu9opvQ
	(envelope-from <linux-nfs+bounces-20985-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 17:41:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3890443CE0D
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 17:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C1CD303FFA9
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 15:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CD72BE051;
	Tue, 21 Apr 2026 15:34:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9CA29ACF6
	for <linux-nfs@vger.kernel.org>; Tue, 21 Apr 2026 15:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776785665; cv=none; b=gTQtzjgYeT3wlsLrQItNTy3LmmBNO7VF3C672KJD4CheF46nxpNf4WG7eMwTQlRomZFbcBCPyFOVbdpDkGq6M2ChA+2StdaNPQCw/tdIJdP82VAUiBDkOOzWcOt1t9iBkge9CP1+8HJHUHNkGLIF2VmjEGotLQAc1BpvvG5W2qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776785665; c=relaxed/simple;
	bh=V1GU+YBpJj9vo99oT4aguIVZddWGmT2UHna75lvcSG0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YDfw/PRD9ZluUSIpJvuILhH2Axltvpruh77ZiGJK0vHlHEKnrVWcqKoCPgFivhcq32FdBxvXsKC+VMTzr6o5WSKlWUKwLOkmzVdGt5SE5nZBP9J0Y5lmWv3CyBUWPTDA+qd90U7Adndp+KUnabv4cfZw8D5WEBjv2QBSSPzFL5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-479ef6653bbso615672b6e.2
        for <linux-nfs@vger.kernel.org>; Tue, 21 Apr 2026 08:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776785662; x=1777390462;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4+CGUJZwDKjMcrarnK/ix96nRkP8A87kwPy5JYSQJ34=;
        b=mUSBSj7FWQLG93WKU6qkGL8Ixp7UYfe60U136Do+57+7Gi67ThxBV7p4M32xE7XHZJ
         GUOAsNKCJVsTrNV5opZ63c1paXs8YvVpQNY6exI6FvUulpEucoARmjkjNv6pUGTIlkyT
         34bprg5O+d035YmgRC0SiAt0NBf7xPjxFPwv1UavyX//PHItxx3iiyyaa9r+i19ddOdL
         KkJJYly2Q0mp9HK3BEX3BL85QYVcdz57fmBb8HXXXfBaifcCqG2DC0p58Hh1W21DMY7K
         vS/QUho9tuTopTC6zvchGESD1ePyt2FaS7vTW1vWcH2VhhNFxzt13uCyWzhFVOPnjdZl
         5E/g==
X-Forwarded-Encrypted: i=1; AFNElJ+1rc+Wd8mwTCA1uKjFEzbScygdavL6lw3rSexIhRXb+yUJsycHU6YBizdjKbjZIWQQZ0wVrNDR70o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKrOCxixeNiM20pRT9pEBL1j51t8t9ZQ+8x4hnpmQRLVJOGwGO
	gGUJjel0Xam85UDHMNn+6IIfLu70p7RdfOa8rfinN1sGY42ucyZQoDnJTeD5FW8IZrf9yU1zwCP
	RTgjbHMCLNnMEbDbSVp7/5pMZK3A1mBBjWGhezpWOG61ZxjhPZgeMsKL0/8o=
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f08:b0:694:9861:ec55 with SMTP id
 006d021491bc7-6949861f2a1mr1674480eaf.10.1776785662127; Tue, 21 Apr 2026
 08:34:22 -0700 (PDT)
Date: Tue, 21 Apr 2026 08:34:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e798fe.050a0220.24bfd3.0031.GAE@google.com>
Subject: [syzbot] [net?] [nfs?] KASAN: slab-out-of-bounds Read in cache_seq_start_rcu
From: syzbot <syzbot+60cfa08822470bbebe44@syzkaller.appspotmail.com>
To: Dai.Ngo@oracle.com, anna@kernel.org, chuck.lever@oracle.com, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jlayton@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, neil@brown.name, netdev@vger.kernel.org, 
	okorniev@redhat.com, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tom@talpey.com, trondmy@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=45528449ee7e2c2f];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20985-lists,linux-nfs=lfdr.de,60cfa08822470bbebe44];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,googlegroups.com:email,goo.gl:url]
X-Rspamd-Queue-Id: 3890443CE0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    b4e07588e743 tracing: tell git to ignore the generated 'un..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14b522d2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45528449ee7e2c2f
dashboard link: https://syzkaller.appspot.com/bug?extid=60cfa08822470bbebe44
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f52c36580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13432cce580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c05a9c593011/disk-b4e07588.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/779dda6a7608/vmlinux-b4e07588.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5e7d794a3ff0/bzImage-b4e07588.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+60cfa08822470bbebe44@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in __cache_seq_start net/sunrpc/cache.c:1351 [inline]
BUG: KASAN: slab-out-of-bounds in cache_seq_start_rcu+0x3fe/0x420 net/sunrpc/cache.c:1399
Read of size 8 at addr ffff88802ae92800 by task syz.0.17/6044

CPU: 1 UID: 0 PID: 6044 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1d0 mm/kasan/report.c:595
 __cache_seq_start net/sunrpc/cache.c:1351 [inline]
 cache_seq_start_rcu+0x3fe/0x420 net/sunrpc/cache.c:1399
 seq_read_iter+0x2c1/0x1270 fs/seq_file.c:226
 seq_read+0x33b/0x4c0 fs/seq_file.c:163
 pde_read fs/proc/inode.c:308 [inline]
 proc_reg_read+0x240/0x330 fs/proc/inode.c:320
 vfs_read+0x1e4/0xb30 fs/read_write.c:572
 ksys_pread64 fs/read_write.c:765 [inline]
 __do_sys_pread64 fs/read_write.c:773 [inline]
 __se_sys_pread64 fs/read_write.c:770 [inline]
 __x64_sys_pread64+0x1eb/0x250 fs/read_write.c:770
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f88b8d9c819
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc567f4a98 EFLAGS: 00000246 ORIG_RAX: 0000000000000011
RAX: ffffffffffffffda RBX: 00007f88b9015fa0 RCX: 00007f88b8d9c819
RDX: 0000000000000566 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f88b8e32c91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080000002 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f88b9015fac R14: 00007f88b9015fa0 R15: 00007f88b9015fa0
 </TASK>

Allocated by task 5958:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5295 [inline]
 __kmalloc_noprof+0x301/0x850 mm/slub.c:5307
 kmalloc_noprof include/linux/slab.h:954 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 cache_create_net+0xa2/0x1f0 net/sunrpc/cache.c:1733
 nfsd_export_init+0x62/0x250 fs/nfsd/export.c:1536
 nfsd_net_init+0x69/0x3e0 fs/nfsd/nfsctl.c:2209
 ops_init+0x1e2/0x5f0 net/core/net_namespace.c:137
 setup_net+0x118/0x3a0 net/core/net_namespace.c:446
 copy_net_ns+0x46f/0x7c0 net/core/net_namespace.c:579
 create_new_namespaces+0x3ea/0xac0 kernel/nsproxy.c:132
 unshare_nsproxy_namespaces+0xf2/0x220 kernel/nsproxy.c:234
 ksys_unshare+0x438/0xab0 kernel/fork.c:3245
 __do_sys_unshare kernel/fork.c:3319 [inline]
 __se_sys_unshare kernel/fork.c:3317 [inline]
 __x64_sys_unshare+0x31/0x40 kernel/fork.c:3317
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802ae92000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 0 bytes to the right of
 allocated 2048-byte region [ffff88802ae92000, ffff88802ae92800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2ae90
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88813fe86000 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800080008 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88813fe86000 dead000000000100 dead000000000122
head: 0000000000000000 0000000800080008 00000000f5000000 0000000000000000
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5958, tgid 5958 (syz-executor), ts 108313513495, free_ts 108309100167
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x153/0x170 mm/page_alloc.c:1858
 prep_new_page mm/page_alloc.c:1866 [inline]
 get_page_from_freelist+0x11a6/0x33b0 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x27c/0x2bc0 mm/page_alloc.c:5226
 alloc_slab_page mm/slub.c:3278 [inline]
 allocate_slab mm/slub.c:3467 [inline]
 new_slab+0xa6/0x6c0 mm/slub.c:3525
 refill_objects+0x277/0x420 mm/slub.c:7251
 refill_sheaf mm/slub.c:2816 [inline]
 __pcs_replace_empty_main+0x375/0x650 mm/slub.c:4651
 alloc_from_pcs mm/slub.c:4749 [inline]
 slab_alloc_node mm/slub.c:4883 [inline]
 __kmalloc_cache_noprof+0x493/0x6f0 mm/slub.c:5410
 kmalloc_noprof include/linux/slab.h:950 [inline]
 netdev_create_hash net/core/dev.c:12922 [inline]
 netdev_init+0x151/0x3c0 net/core/dev.c:12942
 ops_init+0x1e2/0x5f0 net/core/net_namespace.c:137
 setup_net+0x118/0x3a0 net/core/net_namespace.c:446
 copy_net_ns+0x46f/0x7c0 net/core/net_namespace.c:579
 create_new_namespaces+0x3ea/0xac0 kernel/nsproxy.c:132
 unshare_nsproxy_namespaces+0xf2/0x220 kernel/nsproxy.c:234
 ksys_unshare+0x438/0xab0 kernel/fork.c:3245
 __do_sys_unshare kernel/fork.c:3319 [inline]
 __se_sys_unshare kernel/fork.c:3317 [inline]
 __x64_sys_unshare+0x31/0x40 kernel/fork.c:3317
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
page last free pid 5958 tgid 5958 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1402 [inline]
 __free_frozen_pages+0x747/0x1040 mm/page_alloc.c:2943
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x47/0xf0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x1a0/0x1f0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4569 [inline]
 slab_alloc_node mm/slub.c:4898 [inline]
 kmem_cache_alloc_node_noprof+0x25a/0x6f0 mm/slub.c:4950
 __alloc_skb+0x140/0x710 net/core/skbuff.c:702
 alloc_skb include/linux/skbuff.h:1383 [inline]
 nlmsg_new include/net/netlink.h:1055 [inline]
 netlink_ack+0x117/0xb80 net/netlink/af_netlink.c:2487
 netlink_rcv_skb+0x333/0x420 net/netlink/af_netlink.c:2556
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 __sys_sendto+0x468/0x4b0 net/socket.c:2265
 __do_sys_sendto net/socket.c:2272 [inline]
 __se_sys_sendto net/socket.c:2268 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2268
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88802ae92700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88802ae92780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88802ae92800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff88802ae92880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802ae92900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

