Return-Path: <linux-nfs+bounces-21160-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKtjJXUi72lV7gAAu9opvQ
	(envelope-from <linux-nfs+bounces-21160-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 10:46:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB06346F53F
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 10:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2982B30523F9
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 08:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C1539D6C9;
	Mon, 27 Apr 2026 08:42:20 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A42839C65E
	for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777279340; cv=none; b=GSPclsB3XH9YaFqqkBrtON3VhEd7v5IBLaD7RaC7NtVecIncK0S67jymE3LVv8/7ADGyF02bF8CWd2Qx9s96EzXzuDZg1Oe2YjWdc/DYnKWc/xk7b+7eamlRUvyMymSCLQ4EQd5PwXbnxmQsYgPVMGrbwS2MVKYHLreGChnIYDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777279340; c=relaxed/simple;
	bh=a0uLTnh2t2Ux1yQISd6PE4r6OJXTaJTsSFllZtedbBU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=U9d9JZeDP8m71ObeoTshSlridifnlphTBkOze9Z74EYFFoNbGNXTbGFf2DHgYjLBYjwPJaJzQKA6fDXCQRX+vrZNK9A+IXYBfmBPdtIhPJbVPO24j8ryn8W6WlrvFf9lFlGoLd1IvOkLE9e6beAIyVKBl1AnEN9K0t9ymXrJbpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7dbd4fe0e15so21215330a34.3
        for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 01:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777279337; x=1777884137;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=touR3FXSB4f27YjmxBXvowNuddLEqhcnbm2FACxaH5A=;
        b=Zo7Ju9ejp/1YjBbZZbzcQ5glOXpQZPcg9g8XLFygRreQkZAj/+yvpHxeyOXq9dKnye
         vqHkjE3fnFZYTnv1BOppSuFFP4QQID3f2u5eLOqmvxU2dRzcO/QDk3sObaCCclW3d4nk
         Pw/RTfa1Kc2CrxOJAHEoN1CLMOvXa5jJvHHwVKrpzYW30JfUFse/KrfoZAnOCcaVekJs
         GMB9s8Q8F2VgB26QD+gTc8hHvqFjTR8sne7u0NJoMggYd8Pc72u9fgnhYDnWiLKaGRb5
         N1Qr4mkFO5hYyt/kfaqwykhrd+vYiS2yayb9fYCF5xIVTND2I7qsaqWwzD3MtFTiSk7i
         JslA==
X-Forwarded-Encrypted: i=1; AFNElJ8EsEeOyt7I4sFyEjDFjebhNm4g52ImtNexs6RKEhKsrBVEPPLZhJKZyWBSSxJWs4MwqWz+ZyOxJWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYFSrSyORWxZGGD9LP4Gnw50VcU7/ehZBOILnz1bNktJwLwMDg
	ewfJRCwsCo0NWUsprWhy+sBAG3SU1hjwZtbFPrORToKtG4c4RfLHcFvKkqr85mT57PxyiUYTgXM
	+nmLos8smlz7ahPbCD09E0u1w6DslAEgIiqT/zELyQi6b2KDj7BEiJZiw21k=
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:308c:b0:694:8bfa:7817 with SMTP id
 006d021491bc7-6948bfa7b9bmr18574665eaf.53.1777279337100; Mon, 27 Apr 2026
 01:42:17 -0700 (PDT)
Date: Mon, 27 Apr 2026 01:42:17 -0700
In-Reply-To: <20260427040517.828226-1-neilb@ownmail.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ef2169.a00a0220.316485.000b.GAE@google.com>
Subject: [syzbot ci] Re: Prepare to lift lookup out of exclusive lock for
 directory ops
From: syzbot ci <syzbot+ci916c60bd3c422196@syzkaller.appspotmail.com>
To: amir73il@gmail.com, anna@kernel.org, ardb@kernel.org, brauner@kernel.org, 
	jack@suse.cz, jk@ozlabs.org, jlayton@kernel.org, linux-efi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, miklos@szeredi.hu, 
	neilb@ownmail.net, torvalds@linux-foundation.org, trondmy@kernel.org, 
	viro@zeniv.linux.org.uk
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: EB06346F53F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21160-lists,linux-nfs=lfdr.de,ci916c60bd3c422196];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,suse.cz,ozlabs.org,vger.kernel.org,szeredi.hu,ownmail.net,linux-foundation.org,zeniv.linux.org.uk];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzbot.org:url,googlegroups.com:email,googlesource.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

syzbot ci has tested the following series

[v3] Prepare to lift lookup out of exclusive lock for directory ops
https://lore.kernel.org/all/20260427040517.828226-1-neilb@ownmail.net
* [PATCH v3 01/19] VFS: fix various typos in documentation for start_creating start_removing etc
* [PATCH v3 02/19] VFS: enhance d_splice_alias() to handle in-lookup dentries
* [PATCH v3 03/19] VFS: allow d_alloc_name() to be used with ->d_hash
* [PATCH v3 04/19] VFS: use wait_var_event for waiting in d_alloc_parallel()
* [PATCH v3 05/19] VFS: introduce d_alloc_noblock()
* [PATCH v3 06/19] VFS: add d_duplicate()
* [PATCH v3 07/19] VFS: Add LOOKUP_SHARED flag.
* [PATCH v3 08/19] VFS/xfs/ntfs: drop parent lock across d_alloc_parallel() in d_add_ci()
* [PATCH v3 09/19] ovl: stop using lookup_one() in iterate_shared() handling.
* [PATCH v3 10/19] VFS/ovl: add d_alloc_noblock_return()
* [PATCH v3 11/19] efivarfs: use d_alloc_name()
* [PATCH v3 12/19] shmem: use d_duplicate()
* [PATCH v3 13/19] nfs: remove d_drop()/d_alloc_parallel() from nfs_atomic_open()
* [PATCH v3 14/19] nfs: use d_splice_alias() in nfs_link()
* [PATCH v3 15/19] nfs: don't d_drop() before d_splice_alias()
* [PATCH v3 16/19] nfs: don't d_drop() before d_splice_alias() in atomic_create.
* [PATCH v3 17/19] nfs: Use d_alloc_noblock() in nfs_prime_dcache()
* [PATCH v3 18/19] nfs: use d_alloc_noblock() in silly-rename
* [PATCH v3 19/19] nfs: use d_duplicate()

and found the following issues:
* KASAN: slab-out-of-bounds Read in __dentry_kill
* WARNING in __d_instantiate

Full report is available here:
https://ci.syzbot.org/series/9ec82ecc-cc80-4fe2-b595-e5c9d7c49aae

***

KASAN: slab-out-of-bounds Read in __dentry_kill

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      254f49634ee16a731174d2ae34bc50bd5f45e731
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/01f9ecd4-e5ae-4e96-aff5-2636e33c0528/config
syz repro: https://ci.syzbot.org/findings/ef8289e5-b522-4c69-bed5-f7be42e035c2/syz_repro

overlayfs: "xino" feature enabled using 3 upper inode bits.
==================================================================
BUG: KASAN: slab-out-of-bounds in __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
BUG: KASAN: slab-out-of-bounds in _raw_spin_lock_irqsave+0x40/0x60 kernel/locking/spinlock.c:166
Read of size 1 at addr ffff888119c6e5b8 by task syz.0.17/5869

CPU: 0 UID: 0 PID: 5869 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
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
RIP: 0033:0x7f7aa699cdd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7aa780a028 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007f7aa6c15fa0 RCX: 00007f7aa699cdd9
RDX: 0000000000001000 RSI: 0000200000000400 RDI: 0000000000000003
RBP: 00007f7aa6a32d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7aa6c16038 R14: 00007f7aa6c15fa0 R15: 00007ffce28f8638
 </TASK>

Allocated by task 5869:
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

The buggy address belongs to the object at ffff888119c6e468
 which belongs to the cache dentry of size 312
The buggy address is located 24 bytes to the right of
 allocated 312-byte region [ffff888119c6e468, ffff888119c6e5a0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x119c6e
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888119c6fed9
flags: 0x17ff00000000040(head|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 017ff00000000040 ffff888160417140 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800150015 00000000f5000000 ffff888119c6fed9
head: 017ff00000000040 ffff888160417140 dead000000000100 dead000000000122
head: 0000000000000000 0000000800150015 00000000f5000000 ffff888119c6fed9
head: 017ff00000000001 ffffffffffffff81 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Reclaimable, gfp_mask 0xd20d0(__GFP_RECLAIMABLE|__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5645, tgid 5645 (syz-executor), ts 69015847006, free_ts 0
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
 d_alloc+0x4b/0x190 fs/dcache.c:1887
 lookup_one_qstr_excl+0xd8/0x360 fs/namei.c:1801
 __start_dirop fs/namei.c:2915 [inline]
 start_dirop fs/namei.c:2937 [inline]
 filename_create+0x20e/0x370 fs/namei.c:4949
 filename_mkdirat+0xd2/0x510 fs/namei.c:5286
 __do_sys_mkdirat fs/namei.c:5314 [inline]
 __se_sys_mkdirat+0x35/0x150 fs/namei.c:5311
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888119c6e480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888119c6e500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888119c6e580: 00 00 00 00 fc fc fc fc fc fc fc fc fa fb fb fb
                                        ^
 ffff888119c6e600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888119c6e680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


***

WARNING in __d_instantiate

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      254f49634ee16a731174d2ae34bc50bd5f45e731
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/01f9ecd4-e5ae-4e96-aff5-2636e33c0528/config
syz repro: https://ci.syzbot.org/findings/f4cad05d-60bf-4656-a4e7-27c99f4f056b/syz_repro

loop2: detected capacity change from 0 to 16
erofs (device loop2): mounted with root inode @ nid 36.
------------[ cut here ]------------
d_in_lookup(dentry)
WARNING: fs/dcache.c:2112 at __d_instantiate+0x3ea/0x6e0 fs/dcache.c:2112, CPU#0: syz.2.19/5857
Modules linked in:
CPU: 0 UID: 0 PID: 5857 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__d_instantiate+0x3ea/0x6e0 fs/dcache.c:2112
Code: 03 41 80 f6 01 41 0f b6 ce c1 e1 0d 09 c1 89 0b 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d e9 7d 25 61 09 cc e8 87 21 7c ff 90 <0f> 0b 90 e9 7f fd ff ff e8 79 21 7c ff 41 81 cc 00 00 01 00 e9 34
RSP: 0018:ffffc900038274a0 EFLAGS: 00010293
RAX: ffffffff82498229 RBX: ffff888114bb8a48 RCX: ffff88810b5e9d80
RDX: 0000000000000000 RSI: 0000000001000000 RDI: 0000000000000000
RBP: 0000000001000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52000704e8c R12: 0000000000280000
R13: dffffc0000000000 R14: ffff888113d61960 R15: ffff888113d61964
FS:  00007fadb922c6c0(0000) GS:ffff88818dc93000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fadb8272700 CR3: 000000016d53e000 CR4: 00000000000006f0
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
RIP: 0033:0x7fadb839cdd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fadb922c028 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fadb8615fa0 RCX: 00007fadb839cdd9
RDX: 0000200000000340 RSI: 00002000000000c0 RDI: 0000000000000000
RBP: 00007fadb8432d69 R08: 0000200000000380 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fadb8616038 R14: 00007fadb8615fa0 R15: 00007ffe45be7c28
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

