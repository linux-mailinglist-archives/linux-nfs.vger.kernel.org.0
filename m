Return-Path: <linux-nfs+bounces-21159-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ2bCEwi72lV7gAAu9opvQ
	(envelope-from <linux-nfs+bounces-21159-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 10:46:04 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BB146F507
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 10:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19A9C3028B3F
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 08:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F00039B497;
	Mon, 27 Apr 2026 08:41:50 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C7139B482
	for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 08:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777279310; cv=none; b=YCVxHKzjDfIx3fXRrcO4LtwUXjU05WmXboBN5tFMDFroWpcgE1h79DVYSxsDajy1f0f+CU2nL2VabjtKfnpVhkedmBjkVT82J3cci2iknsbN5AzyykQu+idowyHLjDNQhLJXpEP1KJAxYXp8XV0nGjUmzFRtHwMDL7MxOMeZaf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777279310; c=relaxed/simple;
	bh=7X9AcBZwyyviSSX3jq6cqI3IBepSoYjqZ5KqR38LICM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=PTZeKuTH8mgeYaugX5hLgDp3oBkVVZywob2j7cJfCMn+CNEJLF5OWhTe1eD6Ns+jAMojHClB2p8a5PcZH9vChaGLl10e2zYiNDBU+2k1nHwPgQKSNZqXi0CKJCZS6u0cReiD8W6AWJ5sH3o7wM4LR6ckFY+hwa9oyCjYLszvOks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6961bdde2a1so6573318eaf.2
        for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 01:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777279306; x=1777884106;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdBcpS44qi77k6StUNlrMOAYrtrHxg/Ym4p6nVZOSQk=;
        b=ZrkmsMiyy2Fhpcq9ChVZ2NI2c62nfeY0tLmUEqhkO+Hm3K5ISzuogIKymy8xeP8uq+
         xWc1efaYtGjB51Z5PekosCGyKqwGzbqKR7jTrxqPpkisKPSVNIhP878N648wFLlMHOVC
         +ddTEf9fU1sLx4OsGxV3UkEWCTLDKsvapIUBYsYTu7TWu2+eME2Hpjx3QM5zGixiknmN
         dZRoWc4EWjTbrYeO9TmmtRpoGV8NVYjVxxxeUd+ECK95w8YoePZYwXzZoB2vUt3Of2PR
         /XPqjtWlFfJCmi1KUw69FeXkrJ3JRBQwSvOk4/4JpR3/E1cCkfblSXPdKirLPLx4WUOx
         XGqg==
X-Forwarded-Encrypted: i=1; AFNElJ8HDix1baxiFzVAab7yGkSeUex/QgNdl5pgskvShOONB6RUBUnEpcV/V0pSR//cih2Ej4W1gknJUTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLvtudpfEunC3QgWQ440S+d26qfe3lFxTU9neDtZKk1ljNsnSc
	rthWT/F9Ho7Ch4upWlC66aJEFFYt8DNIZf5+hjN0SkE6PA7gw3/QSsNdXdNaGFybKIlJMCVDWa2
	pNgofYnGCA0vDp+scT0v+g4qiO2xEy0z0KNtcZTEE23lcDnEp/m9yL5kqsZU=
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:612:b0:694:a02f:759a with SMTP id
 006d021491bc7-694a02f7abdmr13496797eaf.58.1777279306577; Mon, 27 Apr 2026
 01:41:46 -0700 (PDT)
Date: Mon, 27 Apr 2026 01:41:46 -0700
In-Reply-To: <20260427033527.773006-1-neilb@ownmail.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ef214a.170a0220.11de9.0018.GAE@google.com>
Subject: [syzbot ci] Re: Prepare to lift lookup out of exclusive lock for
 directory ops
From: syzbot ci <syzbot+ci6c3c228cbb300417@syzkaller.appspotmail.com>
To: amir73il@gmail.com, anna@kernel.org, ardb@kernel.org, brauner@kernel.org, 
	hch@infradead.org, jack@suse.cz, jk@ozlabs.org, jlayton@kernel.org, 
	linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, neilb@ownmail.net, 
	torvalds@linux-foundation.org, trondmy@kernel.org, viro@zeniv.linux.org.uk
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A0BB146F507
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21159-lists,linux-nfs=lfdr.de,ci6c3c228cbb300417];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,infradead.org,suse.cz,ozlabs.org,vger.kernel.org,vger.kernel,szeredi.hu,ownmail.net,linux-foundation.org,zeniv.linux.org.uk];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,googlegroups.com:email,syzbot.org:url,googlesource.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

syzbot ci has tested the following series

[v2] Prepare to lift lookup out of exclusive lock for directory ops
https://lore.kernel.org/all/20260427033527.773006-1-neilb@ownmail.net
* [PATCH v2 01/19] VFS: fix various typos in documentation for start_creating start_removing etc
* [PATCH v2 02/19] VFS: enhance d_splice_alias() to handle in-lookup dentries
* [PATCH v2 03/19] VFS: allow d_alloc_name() to be used with ->d_hash
* [PATCH v2 04/19] VFS: use wait_var_event for waiting in d_alloc_parallel()
* [PATCH v2 05/19] VFS: introduce d_alloc_noblock()
* [PATCH v2 06/19] VFS: add d_duplicate()
* [PATCH v2 07/19] VFS: Add LOOKUP_SHARED flag.
* [PATCH v2 08/19] VFS/xfs/ntfs: drop parent lock across d_alloc_parallel() in d_add_ci()
* [PATCH v2 09/19] ovl: stop using lookup_one() in iterate_shared() handling.
* [PATCH v2 10/19] VFS/ovl: add d_alloc_noblock_return()
* [PATCH v2 11/19] efivarfs: use d_alloc_name()
* [PATCH v2 12/19] shmem: use d_duplicate()
* [PATCH v2 13/19] nfs: remove d_drop()/d_alloc_parallel() from nfs_atomic_open()
* [PATCH v2 14/19] nfs: use d_splice_alias() in nfs_link()
* [PATCH v2 15/19] nfs: don't d_drop() before d_splice_alias()
* [PATCH v2 16/19] nfs: don't d_drop() before d_splice_alias() in atomic_create.
* [PATCH v2 17/19] nfs: Use d_alloc_noblock() in nfs_prime_dcache()
* [PATCH v2 18/19] nfs: use d_alloc_noblock() in silly-rename
* [PATCH v2 19/19] nfs: use d_duplicate()

and found the following issues:
* KASAN: slab-out-of-bounds Read in __d_alloc_parallel
* KASAN: slab-out-of-bounds Read in __dentry_kill
* KASAN: slab-use-after-free Read in __d_alloc_parallel
* WARNING in __d_instantiate

Full report is available here:
https://ci.syzbot.org/series/772f6322-910e-4e0e-bab2-3a0a6d70bd47

***

KASAN: slab-out-of-bounds Read in __d_alloc_parallel

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      254f49634ee16a731174d2ae34bc50bd5f45e731
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/3dff1c10-f545-4da8-908f-c29deff36881/config
syz repro: https://ci.syzbot.org/findings/9214c2f3-92fc-4703-96c0-cdb9d6c95839/syz_repro

         option from the mount to silence this warning.
=======================================================
overlayfs: "xino" feature enabled using 3 upper inode bits.
==================================================================
BUG: KASAN: slab-out-of-bounds in __d_alloc_parallel+0x8c8/0x1660 fs/dcache.c:2816
Read of size 4 at addr ffff88810de94580 by task syz.0.17/5876

CPU: 0 UID: 0 PID: 5876 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 __d_alloc_parallel+0x8c8/0x1660 fs/dcache.c:2816
 ovl_cache_update+0x2c4/0xc30 fs/overlayfs/readdir.c:577
 ovl_iterate_merged fs/overlayfs/readdir.c:882 [inline]
 ovl_iterate+0x686/0x21a0 fs/overlayfs/readdir.c:930
 wrap_directory_iterator+0x96/0xe0 fs/readdir.c:67
 iterate_dir+0x399/0x570 fs/readdir.c:110
 __do_sys_getdents64 fs/readdir.c:399 [inline]
 __se_sys_getdents64+0xf1/0x280 fs/readdir.c:384
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4971d9cdd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4972c3e028 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007f4972015fa0 RCX: 00007f4971d9cdd9
RDX: 0000000000001000 RSI: 0000200000000400 RDI: 0000000000000003
RBP: 00007f4971e32d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4972016038 R14: 00007f4972015fa0 R15: 00007fff57765698
 </TASK>

Allocated by task 12:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4569 [inline]
 slab_alloc_node mm/slub.c:4898 [inline]
 kmem_cache_alloc_noprof+0x2bc/0x650 mm/slub.c:4905
 dst_alloc+0x105/0x170 net/core/dst.c:90
 ip6_dst_alloc net/ipv6/route.c:342 [inline]
 ip6_rt_pcpu_alloc net/ipv6/route.c:1419 [inline]
 rt6_make_pcpu_route net/ipv6/route.c:1468 [inline]
 ip6_pol_route+0xafb/0x13d0 net/ipv6/route.c:2319
 pol_lookup_func include/net/ip6_fib.h:667 [inline]
 fib6_rule_lookup+0x556/0x730 net/ipv6/fib6_rules.c:123
 ip6_route_input_lookup net/ipv6/route.c:2352 [inline]
 ip6_route_input+0x730/0xad0 net/ipv6/route.c:2655
 ip6_rcv_finish+0x141/0x280 net/ipv6/ip6_input.c:117
 NF_HOOK+0x336/0x3c0 include/linux/netfilter.h:318
 __netif_receive_skb_one_core net/core/dev.c:6202 [inline]
 __netif_receive_skb net/core/dev.c:6315 [inline]
 process_backlog+0x7dd/0x1950 net/core/dev.c:6666
 __napi_poll+0xae/0x340 net/core/dev.c:7730
 napi_poll net/core/dev.c:7793 [inline]
 net_rx_action+0x627/0xf70 net/core/dev.c:7950
 handle_softirqs+0x22a/0x840 kernel/softirq.c:622
 do_softirq+0x76/0xd0 kernel/softirq.c:523
 __local_bh_enable_ip+0xf8/0x130 kernel/softirq.c:450
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:912 [inline]
 __dev_queue_xmit+0x1fe5/0x3950 net/core/dev.c:4905
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip6_output+0x340/0x550 net/ipv6/ip6_output.c:246
 dst_output include/net/dst.h:470 [inline]
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ndisc_send_skb+0xd0b/0x1670 net/ipv6/ndisc.c:512
 ndisc_send_ns+0xd7/0x160 net/ipv6/ndisc.c:671
 addrconf_dad_work+0xac4/0x14c0 net/ipv6/addrconf.c:4294
 process_one_work kernel/workqueue.c:3302 [inline]
 process_scheduled_works+0xb5d/0x1860 kernel/workqueue.c:3385
 worker_thread+0xa53/0xfc0 kernel/workqueue.c:3466
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88810de94480
 which belongs to the cache ip6_dst_cache of size 232
The buggy address is located 24 bytes to the right of
 allocated 232-byte region [ffff88810de94480, ffff88810de94568)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88810de95680 pfn:0x10de94
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88810de940f9
flags: 0x17ff00000000240(workingset|head|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 017ff00000000240 ffff88817006cc80 ffff88810a72d1c8 ffff88810a72d1c8
raw: ffff88810de95680 000001800015000f 00000000f5000000 ffff88810de940f9
head: 017ff00000000240 ffff88817006cc80 ffff88810a72d1c8 ffff88810a72d1c8
head: ffff88810de95680 000001800015000f 00000000f5000000 ffff88810de940f9
head: 017ff00000000001 ffffffffffffff81 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 12, tgid 12 (kworker/u8:0), ts 77534774317, free_ts 71588863370
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1858
 prep_new_page mm/page_alloc.c:1866 [inline]
 get_page_from_freelist+0x24ba/0x2540 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5226
 alloc_slab_page mm/slub.c:3278 [inline]
 allocate_slab+0x77/0x660 mm/slub.c:3467
 new_slab mm/slub.c:3525 [inline]
 refill_objects+0x339/0x3d0 mm/slub.c:7251
 refill_sheaf mm/slub.c:2816 [inline]
 __pcs_replace_empty_main+0x321/0x720 mm/slub.c:4651
 alloc_from_pcs mm/slub.c:4749 [inline]
 slab_alloc_node mm/slub.c:4883 [inline]
 kmem_cache_alloc_noprof+0x37d/0x650 mm/slub.c:4905
 dst_alloc+0x105/0x170 net/core/dst.c:90
 ip6_dst_alloc net/ipv6/route.c:342 [inline]
 icmp6_dst_alloc+0x75/0x440 net/ipv6/route.c:3337
 ndisc_send_skb+0x44a/0x1670 net/ipv6/ndisc.c:491
 ndisc_send_ns+0xd7/0x160 net/ipv6/ndisc.c:671
 addrconf_dad_work+0xac4/0x14c0 net/ipv6/addrconf.c:4294
 process_one_work kernel/workqueue.c:3302 [inline]
 process_scheduled_works+0xb5d/0x1860 kernel/workqueue.c:3385
 worker_thread+0xa53/0xfc0 kernel/workqueue.c:3466
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
page last free pid 5621 tgid 5621 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1402 [inline]
 __free_frozen_pages+0xbc7/0xd30 mm/page_alloc.c:2943
 rcu_do_batch kernel/rcu/tree.c:2617 [inline]
 rcu_core+0x7cd/0x1070 kernel/rcu/tree.c:2869
 handle_softirqs+0x22a/0x840 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xca/0x220 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1061 [inline]
 sysvec_apic_timer_interrupt+0x57/0xc0 arch/x86/kernel/apic/apic.c:1061
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697

Memory state around the buggy address:
 ffff88810de94480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88810de94500: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
>ffff88810de94580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff88810de94600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88810de94680: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
==================================================================


***

KASAN: slab-out-of-bounds Read in __dentry_kill

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      254f49634ee16a731174d2ae34bc50bd5f45e731
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/3dff1c10-f545-4da8-908f-c29deff36881/config
syz repro: https://ci.syzbot.org/findings/446744b1-86a9-41d7-81fd-e1d04b36fdb3/syz_repro

         option from the mount to silence this warning.
=======================================================
overlayfs: "xino" feature enabled using 3 upper inode bits.
==================================================================
BUG: KASAN: slab-out-of-bounds in __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
BUG: KASAN: slab-out-of-bounds in _raw_spin_lock_irqsave+0x40/0x60 kernel/locking/spinlock.c:166
Read of size 1 at addr ffff8881b594c150 by task syz.0.17/5813

CPU: 1 UID: 0 PID: 5813 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 __kasan_check_byte+0x2a/0x40 mm/kasan/common.c:574
 kasan_check_byte include/linux/kasan.h:402 [inline]
 lock_acquire+0x84/0x350 kernel/locking/lockdep.c:5842
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
 _raw_spin_lock_irqsave+0x40/0x60 kernel/locking/spinlock.c:166
 complete_with_flags kernel/sched/completion.c:25 [inline]
 complete+0x28/0x1b0 kernel/sched/completion.c:52
 d_complete_waiters fs/dcache.c:651 [inline]
 dentry_unlist fs/dcache.c:664 [inline]
 __dentry_kill+0x552/0x690 fs/dcache.c:733
 finish_dput+0xc9/0x480 fs/dcache.c:928
 ovl_cache_update+0x68e/0xc30 fs/overlayfs/readdir.c:643
 ovl_iterate_merged fs/overlayfs/readdir.c:882 [inline]
 ovl_iterate+0x686/0x21a0 fs/overlayfs/readdir.c:930
 wrap_directory_iterator+0x96/0xe0 fs/readdir.c:67
 iterate_dir+0x399/0x570 fs/readdir.c:110
 __do_sys_getdents64 fs/readdir.c:399 [inline]
 __se_sys_getdents64+0xf1/0x280 fs/readdir.c:384
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9dc399cdd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9dc48de028 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007f9dc3c15fa0 RCX: 00007f9dc399cdd9
RDX: 0000000000001000 RSI: 0000200000000400 RDI: 0000000000000003
RBP: 00007f9dc3a32d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9dc3c16038 R14: 00007f9dc3c15fa0 R15: 00007ffdf71c5aa8
 </TASK>

Allocated by task 5813:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4569 [inline]
 slab_alloc_node mm/slub.c:4898 [inline]
 kmem_cache_alloc_lru_noprof+0x2b8/0x640 mm/slub.c:4917
 __d_alloc+0x37/0x6f0 fs/dcache.c:1808
 __d_alloc_parallel+0xe3/0x1660 fs/dcache.c:2758
 ovl_cache_update+0x2c4/0xc30 fs/overlayfs/readdir.c:577
 ovl_iterate_merged fs/overlayfs/readdir.c:882 [inline]
 ovl_iterate+0x686/0x21a0 fs/overlayfs/readdir.c:930
 wrap_directory_iterator+0x96/0xe0 fs/readdir.c:67
 iterate_dir+0x399/0x570 fs/readdir.c:110
 __do_sys_getdents64 fs/readdir.c:399 [inline]
 __se_sys_getdents64+0xf1/0x280 fs/readdir.c:384
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 __call_rcu_common kernel/rcu/tree.c:3131 [inline]
 call_rcu+0xee/0x890 kernel/rcu/tree.c:3251
 __dentry_kill+0x4a9/0x690 fs/dcache.c:738
 finish_dput+0xc9/0x480 fs/dcache.c:928
 ovl_cache_update+0x68e/0xc30 fs/overlayfs/readdir.c:643
 ovl_iterate_merged fs/overlayfs/readdir.c:882 [inline]
 ovl_iterate+0x686/0x21a0 fs/overlayfs/readdir.c:930
 wrap_directory_iterator+0x96/0xe0 fs/readdir.c:67
 iterate_dir+0x399/0x570 fs/readdir.c:110
 __do_sys_getdents64 fs/readdir.c:399 [inline]
 __se_sys_getdents64+0xf1/0x280 fs/readdir.c:384
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8881b594c000
 which belongs to the cache dentry of size 312
The buggy address is located 24 bytes to the right of
 allocated 312-byte region [ffff8881b594c000, ffff8881b594c138)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1b594c
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff8881b594ded9
flags: 0x57ff00000000040(head|node=1|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 057ff00000000040 ffff88816041a140 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800150015 00000000f5000000 ffff8881b594ded9
head: 057ff00000000040 ffff88816041a140 dead000000000100 dead000000000122
head: 0000000000000000 0000000800150015 00000000f5000000 ffff8881b594ded9
head: 057ff00000000001 ffffffffffffff81 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Reclaimable, gfp_mask 0xd20d0(__GFP_RECLAIMABLE|__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5813, tgid 5812 (syz.0.17), ts 74310503158, free_ts 68548113228
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1858
 prep_new_page mm/page_alloc.c:1866 [inline]
 get_page_from_freelist+0x24ba/0x2540 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5226
 alloc_slab_page mm/slub.c:3278 [inline]
 allocate_slab+0x77/0x660 mm/slub.c:3467
 new_slab mm/slub.c:3525 [inline]
 refill_objects+0x339/0x3d0 mm/slub.c:7251
 refill_sheaf mm/slub.c:2816 [inline]
 __pcs_replace_empty_main+0x321/0x720 mm/slub.c:4651
 alloc_from_pcs mm/slub.c:4749 [inline]
 slab_alloc_node mm/slub.c:4883 [inline]
 kmem_cache_alloc_lru_noprof+0x37c/0x640 mm/slub.c:4917
 __d_alloc+0x37/0x6f0 fs/dcache.c:1808
 __d_alloc_parallel+0xe3/0x1660 fs/dcache.c:2758
 ovl_cache_update+0x2c4/0xc30 fs/overlayfs/readdir.c:577
 ovl_iterate_merged fs/overlayfs/readdir.c:882 [inline]
 ovl_iterate+0x686/0x21a0 fs/overlayfs/readdir.c:930
 wrap_directory_iterator+0x96/0xe0 fs/readdir.c:67
 iterate_dir+0x399/0x570 fs/readdir.c:110
 __do_sys_getdents64 fs/readdir.c:399 [inline]
 __se_sys_getdents64+0xf1/0x280 fs/readdir.c:384
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5615 tgid 5615 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1402 [inline]
 free_unref_folios+0xcec/0x1480 mm/page_alloc.c:3004
 folios_put_refs+0x9ff/0xb40 mm/swap.c:1008
 free_pages_and_swap_cache+0x2b9/0x490 mm/swap_state.c:401
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:138 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:151 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:417 [inline]
 tlb_flush_mmu+0x6d3/0xa30 mm/mmu_gather.c:424
 tlb_finish_mmu+0xf9/0x230 mm/mmu_gather.c:549
 unmap_region+0x2a5/0x330 mm/vma.c:491
 vms_clear_ptes mm/vma.c:1303 [inline]
 vms_complete_munmap_vmas+0x493/0xc60 mm/vma.c:1345
 do_vmi_align_munmap+0x3b7/0x4b0 mm/vma.c:1604
 do_vmi_munmap+0x252/0x2d0 mm/vma.c:1652
 __vm_munmap+0x22c/0x3d0 mm/vma.c:3284
 __do_sys_munmap mm/mmap.c:1079 [inline]
 __se_sys_munmap mm/mmap.c:1076 [inline]
 __x64_sys_munmap+0x60/0x70 mm/mmap.c:1076
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8881b594c000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8881b594c080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8881b594c100: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc 00
                                                 ^
 ffff8881b594c180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8881b594c200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


***

KASAN: slab-use-after-free Read in __d_alloc_parallel

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      254f49634ee16a731174d2ae34bc50bd5f45e731
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/3dff1c10-f545-4da8-908f-c29deff36881/config
syz repro: https://ci.syzbot.org/findings/0d6fd7d1-dea2-45d6-8edb-eb79bf030c86/syz_repro

overlayfs: "xino" feature enabled using 3 upper inode bits.
==================================================================
BUG: KASAN: slab-use-after-free in __d_alloc_parallel+0x8c8/0x1660 fs/dcache.c:2816
Read of size 4 at addr ffff888117f3c058 by task syz.0.17/5862

CPU: 0 UID: 0 PID: 5862 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 __d_alloc_parallel+0x8c8/0x1660 fs/dcache.c:2816
 ovl_cache_update+0x2c4/0xc30 fs/overlayfs/readdir.c:577
 ovl_iterate_merged fs/overlayfs/readdir.c:882 [inline]
 ovl_iterate+0x686/0x21a0 fs/overlayfs/readdir.c:930
 wrap_directory_iterator+0x96/0xe0 fs/readdir.c:67
 iterate_dir+0x399/0x570 fs/readdir.c:110
 __do_sys_getdents64 fs/readdir.c:399 [inline]
 __se_sys_getdents64+0xf1/0x280 fs/readdir.c:384
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb245d9cdd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb246d39028 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007fb246015fa0 RCX: 00007fb245d9cdd9
RDX: 0000000000001000 RSI: 0000200000000400 RDI: 0000000000000003
RBP: 00007fb245e32d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fb246016038 R14: 00007fb246015fa0 R15: 00007ffe42640d08
 </TASK>

Allocated by task 5860:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4569 [inline]
 slab_alloc_node mm/slub.c:4898 [inline]
 kmem_cache_alloc_lru_noprof+0x2b8/0x640 mm/slub.c:4917
 __d_alloc+0x37/0x6f0 fs/dcache.c:1808
 __d_alloc_parallel+0xe3/0x1660 fs/dcache.c:2758
 ovl_cache_update+0x2c4/0xc30 fs/overlayfs/readdir.c:577
 ovl_iterate_merged fs/overlayfs/readdir.c:882 [inline]
 ovl_iterate+0x686/0x21a0 fs/overlayfs/readdir.c:930
 wrap_directory_iterator+0x96/0xe0 fs/readdir.c:67
 iterate_dir+0x399/0x570 fs/readdir.c:110
 __do_sys_getdents64 fs/readdir.c:399 [inline]
 __se_sys_getdents64+0xf1/0x280 fs/readdir.c:384
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5731:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2689 [inline]
 slab_free mm/slub.c:6246 [inline]
 kmem_cache_free+0x182/0x650 mm/slub.c:6373
 rcu_do_batch kernel/rcu/tree.c:2617 [inline]
 rcu_core+0x7cd/0x1070 kernel/rcu/tree.c:2869
 handle_softirqs+0x22a/0x840 kernel/softirq.c:622
 do_softirq+0x76/0xd0 kernel/softirq.c:523
 __local_bh_enable_ip+0xf8/0x130 kernel/softirq.c:450
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 __alloc_skb+0x1aa/0x7d0 net/core/skbuff.c:697
 alloc_skb include/linux/skbuff.h:1383 [inline]
 mld_newpack+0x14c/0xc90 net/ipv6/mcast.c:1775
 add_grhead+0x5a/0x2a0 net/ipv6/mcast.c:1886
 add_grec+0x1452/0x1740 net/ipv6/mcast.c:2025
 mld_send_initial_cr+0x288/0x550 net/ipv6/mcast.c:2268
 mld_dad_work+0x45/0x5b0 net/ipv6/mcast.c:2294
 process_one_work kernel/workqueue.c:3302 [inline]
 process_scheduled_works+0xb5d/0x1860 kernel/workqueue.c:3385
 worker_thread+0xa53/0xfc0 kernel/workqueue.c:3466
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 __call_rcu_common kernel/rcu/tree.c:3131 [inline]
 call_rcu+0xee/0x890 kernel/rcu/tree.c:3251
 __dentry_kill+0x4a9/0x690 fs/dcache.c:738
 finish_dput+0xc9/0x480 fs/dcache.c:928
 ovl_cache_update+0x68e/0xc30 fs/overlayfs/readdir.c:643
 ovl_iterate_merged fs/overlayfs/readdir.c:882 [inline]
 ovl_iterate+0x686/0x21a0 fs/overlayfs/readdir.c:930
 wrap_directory_iterator+0x96/0xe0 fs/readdir.c:67
 iterate_dir+0x399/0x570 fs/readdir.c:110
 __do_sys_getdents64 fs/readdir.c:399 [inline]
 __se_sys_getdents64+0xf1/0x280 fs/readdir.c:384
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888117f3c000
 which belongs to the cache dentry of size 312
The buggy address is located 88 bytes inside of
 freed 312-byte region [ffff888117f3c000, ffff888117f3c138)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x117f3c
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888117f3ded9
flags: 0x17ff00000000040(head|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 017ff00000000040 ffff88816041a140 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800150015 00000000f5000000 ffff888117f3ded9
head: 017ff00000000040 ffff88816041a140 dead000000000100 dead000000000122
head: 0000000000000000 0000000800150015 00000000f5000000 ffff888117f3ded9
head: 017ff00000000001 ffffffffffffff81 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Reclaimable, gfp_mask 0xd20d0(__GFP_RECLAIMABLE|__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5860, tgid 5859 (syz.1.18), ts 82425954221, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1858
 prep_new_page mm/page_alloc.c:1866 [inline]
 get_page_from_freelist+0x24ba/0x2540 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5226
 alloc_slab_page mm/slub.c:3278 [inline]
 allocate_slab+0x77/0x660 mm/slub.c:3467
 new_slab mm/slub.c:3525 [inline]
 refill_objects+0x339/0x3d0 mm/slub.c:7251
 refill_sheaf mm/slub.c:2816 [inline]
 __pcs_replace_empty_main+0x321/0x720 mm/slub.c:4651
 alloc_from_pcs mm/slub.c:4749 [inline]
 slab_alloc_node mm/slub.c:4883 [inline]
 kmem_cache_alloc_lru_noprof+0x37c/0x640 mm/slub.c:4917
 __d_alloc+0x37/0x6f0 fs/dcache.c:1808
 __d_alloc_parallel+0xe3/0x1660 fs/dcache.c:2758
 ovl_cache_update+0x2c4/0xc30 fs/overlayfs/readdir.c:577
 ovl_iterate_merged fs/overlayfs/readdir.c:882 [inline]
 ovl_iterate+0x686/0x21a0 fs/overlayfs/readdir.c:930
 wrap_directory_iterator+0x96/0xe0 fs/readdir.c:67
 iterate_dir+0x399/0x570 fs/readdir.c:110
 __do_sys_getdents64 fs/readdir.c:399 [inline]
 __se_sys_getdents64+0xf1/0x280 fs/readdir.c:384
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888117f3bf00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888117f3bf80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888117f3c000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff888117f3c080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888117f3c100: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fa
==================================================================


***

WARNING in __d_instantiate

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      254f49634ee16a731174d2ae34bc50bd5f45e731
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/3dff1c10-f545-4da8-908f-c29deff36881/config
syz repro: https://ci.syzbot.org/findings/98da1471-1b32-42f0-bc15-ed0b40bfa386/syz_repro

------------[ cut here ]------------
d_in_lookup(dentry)
WARNING: fs/dcache.c:2112 at __d_instantiate+0x3ea/0x6e0 fs/dcache.c:2112, CPU#0: syz.2.19/5816
Modules linked in:
CPU: 0 UID: 0 PID: 5816 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__d_instantiate+0x3ea/0x6e0 fs/dcache.c:2112
Code: 03 41 80 f6 01 41 0f b6 ce c1 e1 0d 09 c1 89 0b 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d e9 7d 25 61 09 cc e8 87 21 7c ff 90 <0f> 0b 90 e9 7f fd ff ff e8 79 21 7c ff 41 81 cc 00 00 01 00 e9 34
RSP: 0018:ffffc90003f674a0 EFLAGS: 00010293
RAX: ffffffff82498229 RBX: ffff88811ddbebc0 RCX: ffff8881120bbb00
RDX: 0000000000000000 RSI: 0000000001000000 RDI: 0000000000000000
RBP: 0000000001000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff520007ece8c R12: 0000000000280000
R13: dffffc0000000000 R14: ffff888112b90d50 R15: ffff888112b90d54
FS:  00007f3d2a7a46c0(0000) GS:ffff88818dc93000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000001000 CR3: 000000016ac94000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 d_make_persistent+0x8e/0x180 fs/dcache.c:3068
 shmem_mknod+0x2ea/0x360 mm/shmem.c:3881
 shmem_whiteout mm/shmem.c:4012 [inline]
 shmem_rename2+0x265/0x430 mm/shmem.c:4052
 vfs_rename+0xa96/0xeb0 fs/namei.c:6053
 ovl_do_rename_rd fs/overlayfs/overlayfs.h:372 [inline]
 ovl_check_rename_whiteout fs/overlayfs/super.c:593 [inline]
 ovl_make_workdir fs/overlayfs/super.c:713 [inline]
 ovl_get_workdir fs/overlayfs/super.c:836 [inline]
 ovl_fill_super_creds fs/overlayfs/super.c:1449 [inline]
 ovl_fill_super+0x46b7/0x5e20 fs/overlayfs/super.c:1560
 vfs_get_super fs/super.c:1327 [inline]
 get_tree_nodev+0xbb/0x150 fs/super.c:1346
 vfs_get_tree+0x92/0x2a0 fs/super.c:1754
 fc_mount fs/namespace.c:1193 [inline]
 do_new_mount_fc fs/namespace.c:3758 [inline]
 do_new_mount+0x341/0xd30 fs/namespace.c:3834
 do_mount fs/namespace.c:4167 [inline]
 __do_sys_mount fs/namespace.c:4383 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4360
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3d2999cdd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3d2a7a4028 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f3d29c15fa0 RCX: 00007f3d2999cdd9
RDX: 0000200000000080 RSI: 00002000000000c0 RDI: 0000000000000000
RBP: 00007f3d29a32d69 R08: 0000200000000400 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3d29c16038 R14: 00007f3d29c15fa0 R15: 00007ffcf097bd48
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a patch for this bug, please reply with `#syz test`
(should be on a separate line).

The patch should be attached to the email.
Note: arguments like custom git repos and branches are not supported.

