Return-Path: <linux-nfs+bounces-10463-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 107AEA4EA5B
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 19:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018083BC2BE
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 17:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD3129C346;
	Tue,  4 Mar 2025 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="Ffqve2YV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D63299B33;
	Tue,  4 Mar 2025 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109801; cv=none; b=HrE0aUYPGU+IUGU69HZLSXovnmqo3WLKUruemyGs9x/pzW0UFNJiOR3jqU9+88B0cDiE43ufQI2q84bGK7JTowKr/lrTqs81HzKWKuupF0U++Z2YlaKokAQJ/ur53wnPZy78UEf82pLNZ5MO8xWGbWq57Q8ba/oVD5r+sd7uSbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109801; c=relaxed/simple;
	bh=l7cKm5QZLU6R25tTG/0tIfzhDXOfRW59cJPuyeFzGE8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=H4ExYcyajAVzAjDauG8FBGDxjqrhkTNkfaeb4CyM61ibmmoj47xy7vQlQjkf//FuHAUtNTBxQbTqDgJutiKpPHVYNgrTyerGVyX0qZCLA3NCbtyQpVvuPoxN6cpcgpm7uORyAFBpsHwLzvgt1eas8t+WQm2eLywp4O0dhQyXBjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=Ffqve2YV; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30797730cbdso57268111fa.3;
        Tue, 04 Mar 2025 09:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1741109797; x=1741714597; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eRclD48cPdeeU9cvhbBNfEemRhdo5oK7aSrP9o7VlCI=;
        b=Ffqve2YVFBt48sSv7j7+qo5pXNFIeeVCRNeCAV6+/8Y1bIh46xW3NnAA6MsrBNdEOu
         LHJU29ScoQtaJDAXmFxhfcnfuYr/l74N83b59wAS8oE0Lljy4BjzD4cVsJiZQ/BGqyb2
         T0Rf1YpmgGutGK8Q4fcIYjaS2C7vqfIu1Sg8amlGtNJCwMvjxG7oT6/YGlWStajymIl+
         p+gjgNRB79Juk7aCcYErJ8JWif1I8QZC00I2RHNy6G1bY3P8Ji6ta7/eWXj+ugRlzfkq
         Ksz5nw8pLqMUTBLK1kcA11+ryPvQWyCZtZETh4oPu1o8YibHw8QRDeD4UUzbWJjPsRCp
         LrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741109797; x=1741714597;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eRclD48cPdeeU9cvhbBNfEemRhdo5oK7aSrP9o7VlCI=;
        b=qVZpylQJGAWFh8eUPpR35jX+Mej7swtVqqqwYBor5qG7I4V1FqfrjKLJbk02vBFxF0
         VmRswm//IlpyPDWQaUgbnMPlGpckTXcAbtGodx6usSems2e9lD92JvL87tqG+LcFi2S0
         LTY3gARszd9986N3tFju9ryZZI8qSf9iJ+Jaoxp9M3I6Hoh4JviVe6hS4QdyqlHHJilo
         dE/eOHaEMPg00Zh2cn71GIqJLc/hGGB0NJ3PhWWEug6iUpWE9hU6ssfC0SzxTSEKB9Hy
         H2gkIA5K4skUQ4HBRXhoI2xZfFxD0FMLjilNVUr/hNYoMTS3B8hE7oTdnRoezkBPBBSi
         um6w==
X-Forwarded-Encrypted: i=1; AJvYcCUjyPzxMsvj61xJLOm7Hh+Iq5gsy1oTYaqBP4//Dx2GXxUcrxMK88O515uEly3YSo1GngE6UTRF@vger.kernel.org, AJvYcCVzMVUbJOlIktOXRQSoLui1IsIatht+VU0hGV6Fc+uCYWjngiWJXWiA80gb7W0wwyC5GCJEa7NOSok=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyXQwav9rUXCJljnFBgaePMkAtPn8mi/P+Ru5Kox618DEwZB8x
	rwINlYnLIw8UlYDKq8KD88Pyc8tvx9ayz6Xlc5Y1lhWGcRlIntl5nbdENsxj2lMjeE1v+ODTPrv
	NOpDRQSsNjMI9wZycQLlAj+wK+mY=
X-Gm-Gg: ASbGncuU/t4rDJWZE+ayjq0+7mNQx5ZtMjh0gF2hiDOxycegnliP8N/INPOZzfreoX4
	KHWlE44ph8WcsagMyroaY0N75rY8Zm1Pl7AdNhLfNECc1cwHHEgHcXy+1QlON1Lxrt/rwD3pST8
	lxrjOf6eQpuNvRHW5fLTWZGvspO/PFKv5s7AOSI/It6cP9BPraoYOwnCMOs4A=
X-Google-Smtp-Source: AGHT+IFuRWgeOOoG6p8UUyYBbRw9jv0DcCJRNYDuUoL6JSkkfGoPkFknvC6RsU4WBcPvh4C6lt+klAbq38Jionjah4U=
X-Received: by 2002:a2e:be91:0:b0:30b:badf:75ee with SMTP id
 38308e7fff4ca-30bd7a1e168mr118851fa.7.1741109797044; Tue, 04 Mar 2025
 09:36:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 4 Mar 2025 12:36:24 -0500
X-Gm-Features: AQ5f1JpeEgd2RMwRvcshBa7yvYEI1u_-riZrhzTEfpQLpoG_zAPRLHN0XYd2TeU
Message-ID: <CAN-5tyEsGNTgJkkG4aiTSZqn3QvTQu7hSNg2+5u7Z9Ycvk3GUA@mail.gmail.com>
Subject: circular locking between memory management and network layer (from nfs)
To: Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello memory management and networking gurus,

While doing NFS testing, we've encountered the following lockdep
warning (included below). While hit in NFS it might be problematic to
other network filesystems. The warning suggests that one mmap thread
acquired a lock doing page fault and calling into NFS which will do a
network call which will grab a socket lock. Elsewhere, there might be
a process trying to send data on a socket and thus holding a socket
lock and then needs to copy userland data which would require
mmap_lock.

Any ideas how this should be resolved/handled?

Thank you.

[ 2720.332903] ======================================================
[ 2720.333945] WARNING: possible circular locking dependency detected
[ 2720.334990] 6.14.0-rc5+ #10 Not tainted
[ 2720.335667] ------------------------------------------------------
[ 2720.336711] xfs_io/48526 is trying to acquire lock:
[ 2720.337553] ffff88817231b778 (sk_lock-AF_INET-RPC){+.+.}-{0:0}, at:
tcp_sock_set_cork+0x17/0x70
[ 2720.339031]
[ 2720.339031] but task is already holding lock:
[ 2720.340013] ffff888111658200 (&mm->mmap_lock){++++}-{4:4}, at:
vm_mmap_pgoff+0x141/0x330
[ 2720.341358]
[ 2720.341358] which lock already depends on the new lock.
[ 2720.341358]
[ 2720.342703]
[ 2720.342703] the existing dependency chain (in reverse order) is:
[ 2720.343944]
[ 2720.343944] -> #1 (&mm->mmap_lock){++++}-{4:4}:
[ 2720.344973]        __lock_acquire+0xcff/0x1fc0
[ 2720.345754]        lock_acquire.part.0+0x11b/0x360
[ 2720.346579]        __might_fault+0xbd/0x120
[ 2720.347311]        _copy_from_iter+0xdf/0x1500
[ 2720.348082]        skb_do_copy_data_nocache+0x160/0x240
[ 2720.348968]        tcp_sendmsg_locked+0x903/0x3920
[ 2720.349796]        tcp_sendmsg+0x2b/0x40
[ 2720.350491]        ____sys_sendmsg+0x8e1/0xc60
[ 2720.351262]        ___sys_sendmsg+0xfd/0x180
[ 2720.352004]        __sys_sendmsg+0x122/0x1b0
[ 2720.352747]        do_syscall_64+0x92/0x180
[ 2720.353475]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 2720.354416]
[ 2720.354416] -> #0 (sk_lock-AF_INET-RPC){+.+.}-{0:0}:
[ 2720.355490]        check_prev_add+0x1b7/0x23e0
[ 2720.356258]        validate_chain+0xa8a/0xf00
[ 2720.357013]        __lock_acquire+0xcff/0x1fc0
[ 2720.357777]        lock_acquire.part.0+0x11b/0x360
[ 2720.358600]        lock_sock_nested+0x3b/0xe0
[ 2720.359359]        tcp_sock_set_cork+0x17/0x70
[ 2720.360129]        xs_tcp_send_request+0x29e/0xaa0 [sunrpc]
[ 2720.361333]        xprt_request_transmit.isra.0+0x23d/0x810 [sunrpc]
[ 2720.362481]        xprt_transmit+0x19a/0x2b0 [sunrpc]
[ 2720.363438]        call_transmit+0x1c7/0x240 [sunrpc]
[ 2720.364386]        __rpc_execute+0x2bb/0xc50 [sunrpc]
[ 2720.365357]        rpc_execute+0xb4/0x110 [sunrpc]
[ 2720.366288]        rpc_run_task+0x363/0x500 [sunrpc]
[ 2720.367224]        rpc_call_sync+0xad/0x150 [sunrpc]
[ 2720.368161]        nfs3_rpc_wrapper+0x46/0x140 [nfsv3]
[ 2720.369041]        nfs3_proc_getattr+0x13d/0x1f0 [nfsv3]
[ 2720.369933]        __nfs_revalidate_inode+0x25e/0x710 [nfs]
[ 2720.371063]        nfs_revalidate_mapping+0xde/0x160 [nfs]
[ 2720.372047]        __mmap_new_vma+0x39c/0x1050
[ 2720.372806]        __mmap_region+0x76a/0xff0
[ 2720.373545]        mmap_region+0x22f/0x300
[ 2720.374258]        do_mmap+0x9d9/0x1020
[ 2720.374925]        vm_mmap_pgoff+0x1b1/0x330
[ 2720.375671]        ksys_mmap_pgoff+0x2ec/0x440
[ 2720.376438]        do_syscall_64+0x92/0x180
[ 2720.377162]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 2720.378097]
[ 2720.378097] other info that might help us debug this:
[ 2720.378097]
[ 2720.379402]  Possible unsafe locking scenario:
[ 2720.379402]
[ 2720.380399]        CPU0                    CPU1
[ 2720.381187]        ----                    ----
[ 2720.381966]   lock(&mm->mmap_lock);
[ 2720.382597]                                lock(sk_lock-AF_INET-RPC);
[ 2720.383667]                                lock(&mm->mmap_lock);
[ 2720.384675]   lock(sk_lock-AF_INET-RPC);
[ 2720.385367]
[ 2720.385367]  *** DEADLOCK ***
[ 2720.385367]
[ 2720.386352] 1 lock held by xfs_io/48526:
[ 2720.387032]  #0: ffff888111658200 (&mm->mmap_lock){++++}-{4:4}, at:
vm_mmap_pgoff+0x141/0x330
[ 2720.388426]
[ 2720.388426] stack backtrace:
[ 2720.389184] CPU: 0 UID: 0 PID: 48526 Comm: xfs_io Not tainted 6.14.0-rc5+ #10
[ 2720.389189] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.3-2.fc40 04/01/2014
[ 2720.389196] Call Trace:
[ 2720.389202]  <TASK>
[ 2720.389211]  dump_stack_lvl+0x6f/0xb0
[ 2720.389222]  print_circular_bug.cold+0x38/0x48
[ 2720.389229]  check_noncircular+0x308/0x3f0
[ 2720.389233]  ? rcu_is_watching+0x15/0xb0
[ 2720.389239]  ? __pfx_check_noncircular+0x10/0x10
[ 2720.389243]  ? lock_release+0x288/0x350
[ 2720.389255]  check_prev_add+0x1b7/0x23e0
[ 2720.389260]  ? is_bpf_text_address+0x64/0x100
[ 2720.389264]  ? rcu_is_watching+0x15/0xb0
[ 2720.389270]  validate_chain+0xa8a/0xf00
[ 2720.389277]  ? __pfx_validate_chain+0x10/0x10
[ 2720.389281]  ? mark_lock+0x78/0x860
[ 2720.389288]  __lock_acquire+0xcff/0x1fc0
[ 2720.389298]  lock_acquire.part.0+0x11b/0x360
[ 2720.389302]  ? tcp_sock_set_cork+0x17/0x70
[ 2720.389310]  ? __pfx_lock_acquire.part.0+0x10/0x10
[ 2720.389313]  ? add_lock_to_list+0x18b/0x370
[ 2720.389319]  ? mark_lock+0x78/0x860
[ 2720.389323]  ? rcu_is_watching+0x15/0xb0
[ 2720.389327]  ? lock_acquire+0x234/0x2f0
[ 2720.389333]  lock_sock_nested+0x3b/0xe0
[ 2720.389339]  ? tcp_sock_set_cork+0x17/0x70
[ 2720.389344]  tcp_sock_set_cork+0x17/0x70
[ 2720.389348]  xs_tcp_send_request+0x29e/0xaa0 [sunrpc]
[ 2720.389454]  ? mark_lock+0x78/0x860
[ 2720.389464]  ? __pfx_xs_tcp_send_request+0x10/0x10 [sunrpc]
[ 2720.389567]  ? find_held_lock+0x34/0x120
[ 2720.389572]  ? kvm_sched_clock_read+0x11/0x20
[ 2720.389576]  ? local_clock_noinstr+0xd/0xe0
[ 2720.389581]  ? __lock_release.isra.0+0x4ba/0x9f0
[ 2720.389586]  ? __pfx___lock_release.isra.0+0x10/0x10
[ 2720.389592]  ? rcu_is_watching+0x15/0xb0
[ 2720.389599]  xprt_request_transmit.isra.0+0x23d/0x810 [sunrpc]
[ 2720.389697]  xprt_transmit+0x19a/0x2b0 [sunrpc]
[ 2720.389796]  ? __pfx_call_transmit+0x10/0x10 [sunrpc]
[ 2720.389887]  call_transmit+0x1c7/0x240 [sunrpc]
[ 2720.389986]  __rpc_execute+0x2bb/0xc50 [sunrpc]
[ 2720.390105]  rpc_execute+0xb4/0x110 [sunrpc]
[ 2720.390218]  rpc_run_task+0x363/0x500 [sunrpc]
[ 2720.390312]  rpc_call_sync+0xad/0x150 [sunrpc]
[ 2720.390406]  ? __pfx_rpc_call_sync+0x10/0x10 [sunrpc]
[ 2720.390506]  nfs3_rpc_wrapper+0x46/0x140 [nfsv3]
[ 2720.390518]  nfs3_proc_getattr+0x13d/0x1f0 [nfsv3]
[ 2720.390528]  ? __pfx_nfs3_proc_getattr+0x10/0x10 [nfsv3]
[ 2720.390539]  ? kasan_save_track+0x14/0x30
[ 2720.390543]  ? __kasan_kmalloc+0x8f/0xa0
[ 2720.390550]  __nfs_revalidate_inode+0x25e/0x710 [nfs]
[ 2720.390622]  nfs_revalidate_mapping+0xde/0x160 [nfs]
[ 2720.390692]  __mmap_new_vma+0x39c/0x1050
[ 2720.390701]  __mmap_region+0x76a/0xff0
[ 2720.390706]  ? __pfx___mmap_region+0x10/0x10
[ 2720.390722]  ? __pfx_unmapped_area_topdown+0x10/0x10
[ 2720.390726]  ? __pfx_lock_acquire.part.0+0x10/0x10
[ 2720.390752]  mmap_region+0x22f/0x300
[ 2720.390758]  do_mmap+0x9d9/0x1020
[ 2720.390765]  ? vm_mmap_pgoff+0x141/0x330
[ 2720.390770]  ? __pfx_do_mmap+0x10/0x10
[ 2720.390776]  ? __pfx_down_write_killable+0x10/0x10
[ 2720.390785]  vm_mmap_pgoff+0x1b1/0x330
[ 2720.390792]  ? __pfx_vm_mmap_pgoff+0x10/0x10
[ 2720.390797]  ? __fget_files+0x1a4/0x2e0
[ 2720.390803]  ? __fget_files+0x1ae/0x2e0
[ 2720.390809]  ksys_mmap_pgoff+0x2ec/0x440
[ 2720.390815]  do_syscall_64+0x92/0x180
[ 2720.390820]  ? mark_lock+0x78/0x860
[ 2720.390826]  ? __lock_acquire+0xcff/0x1fc0
[ 2720.390834]  ? find_held_lock+0x34/0x120
[ 2720.390838]  ? kvm_sched_clock_read+0x11/0x20
[ 2720.390842]  ? local_clock_noinstr+0xd/0xe0
[ 2720.390846]  ? __lock_release.isra.0+0x4ba/0x9f0
[ 2720.390851]  ? __pfx___lock_release.isra.0+0x10/0x10
[ 2720.390857]  ? __pfx_do_raw_spin_trylock+0x10/0x10
[ 2720.390864]  ? _raw_spin_unlock_irq+0x28/0x50
[ 2720.390869]  ? lockdep_hardirqs_on+0x78/0x100
[ 2720.390873]  ? _raw_spin_unlock_irq+0x33/0x50
[ 2720.390877]  ? __x64_sys_rt_sigprocmask+0x230/0x390
[ 2720.390883]  ? __pfx___x64_sys_rt_sigprocmask+0x10/0x10
[ 2720.390888]  ? ktime_get_coarse_real_ts64+0x12a/0x190
[ 2720.390895]  ? rcu_is_watching+0x15/0xb0
[ 2720.390900]  ? lockdep_hardirqs_on_prepare+0x171/0x400
[ 2720.390904]  ? do_syscall_64+0x9e/0x180
[ 2720.390908]  ? lockdep_hardirqs_on+0x78/0x100
[ 2720.390912]  ? do_syscall_64+0x9e/0x180
[ 2720.390917]  ? rcu_is_watching+0x15/0xb0
[ 2720.390922]  ? clear_bhb_loop+0x25/0x80
[ 2720.390927]  ? clear_bhb_loop+0x25/0x80
[ 2720.390932]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 2720.390937] RIP: 0033:0x7f61aa0a8b36
[ 2720.390948] Code: 00 00 00 90 f3 0f 1e fa 41 f7 c1 ff 0f 00 00 75
2b 55 89 cd 53 48 89 fb 48 85 ff 74 37 41 89 ea 48 89 df b8 09 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 72 5b 5d c3 0f 1f 80 00 00 00 00 48 8b
05 a1
[ 2720.390954] RSP: 002b:00007ffffc0efa68 EFLAGS: 00000246 ORIG_RAX:
0000000000000009
[ 2720.390963] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f61aa0a8b36
[ 2720.390966] RDX: 0000000000000002 RSI: 0000000000100000 RDI: 0000000000000000
[ 2720.390969] RBP: 0000000000000001 R08: 0000000000000003 R09: 000000001ec00000
[ 2720.390971] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000002
[ 2720.390980] R13: 000000001ec00000 R14: 0000000000000000 R15: 000055844a355ac0
[ 2720.390991]  </TASK>

