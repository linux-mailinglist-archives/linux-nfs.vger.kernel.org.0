Return-Path: <linux-nfs+bounces-16879-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12233CA0F0F
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Dec 2025 19:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32F3230380F3
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Dec 2025 17:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF90340290;
	Wed,  3 Dec 2025 15:57:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87D433B968
	for <linux-nfs@vger.kernel.org>; Wed,  3 Dec 2025 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777423; cv=none; b=EZ1fqavNu3oiEg9UpAnS68dqFt0CX3/7BBAAklYJnxG9bVE96erBKibC52ub/3oHlRAUNSSJD/F6T/wm7J1q2CxIrAnlnIB90uW1lGKGaL1sizGAxNa8YTwHmI8JRPWI+NeK3H/QSc9HNqovgnvz1v/4suebWcZ2T+RQo78opTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777423; c=relaxed/simple;
	bh=P97zHKDQL5QVRzUIKynilQHwXRV6bYf1WS/8OiiU/Ig=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=aSoFKnUk2ULgkmtQf7Zz29TNv6NCG+Ps6bZlsdkVtHTIiV2oJAV9UvvnjceMh7rRDN7ui0GxBhe6IsBQOVQDCM3Szp1y5w6PXjuLb4McS9l2O4qJsjgDzD988r12J7mWzU/YmS86NLt1fugf7qAQv5+tIiqlJ+3y66ZrzJ2Q4R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-3e890e6be00so10443698fac.3
        for <linux-nfs@vger.kernel.org>; Wed, 03 Dec 2025 07:57:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764777419; x=1765382219;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P/aPnbDHyqwV7Nm7/nXajyAdwt7gmJFhG10jDKdAB64=;
        b=L880kGldsvJuHHHyG0sdolo2m02fu1N9JKB9I7scvL69KhsnFNE+gjJhZ3JaMQqlTc
         1GY5H+JBdiCABhVt7sjpzcPpCu552IPQV0llK3CheWn0RVGhkYqaDlUkyrOrIznKVMZ0
         r22vVR7CULrvES4doJKhjDeP/IKwRv8Teo2f0iSdeHYBYnxFOKJxJ1AIP3a+ui7/92cz
         plEopRyFtoG+pl6o7sze5vzNOB7GX1TM2A7ffs6x8Qu3knyyBDqt7KlbeQuLFeALjWgG
         thzqJYVxhoFZ5POBVyB731NEB0hwUy8lhvYGGyzT2YWH5I+3phIcH9U9coO4Cs50LjIm
         dJ6A==
X-Forwarded-Encrypted: i=1; AJvYcCUYnVtvo6MnBIiG9JgYrn+166Gc3/3qiqFrQUmxZlVEsokNTVF6sFprkg8tAOvsngZXcYLBiuNag/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYUSvamJvzM4pQ5RQQFjGvSF65+CFGvCjt/BOXLf61ar7+/ZHs
	b2qCgsnlojkH647LsHoCJgEaZxyTpXyTfxNs5Vq460Fh9tGMcUVMNDg24Yu1Cn/kLx0xKacZLJZ
	m7WWVDbfCZMDrkkHZvZLIcR3xZXY2b57GIkChAk19RHWhPQ2jnOCV0T7MjRg=
X-Google-Smtp-Source: AGHT+IEdFXk+QYQhLfKEjbmhGPwyR/srj/xDTzFXQHP7/kFX46+lYl8VkYI2tzSoiX0Bcl83dLcz5v0njFhUp+gNqdT6cTG7x5CY
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1509:b0:450:b947:1d8c with SMTP id
 5614622812f47-4536e61d971mr1521455b6e.67.1764777419679; Wed, 03 Dec 2025
 07:56:59 -0800 (PST)
Date: Wed, 03 Dec 2025 07:56:59 -0800
In-Reply-To: <4bc8b687-382b-4243-b5ab-48f83d87f6c5@app.fastmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69305dcb.a70a0220.2ea503.00d2.GAE@google.com>
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_nl_version_set_doit (2)
From: syzbot <syzbot+31dce4175fcaed9dae98@syzkaller.appspotmail.com>
To: cel@kernel.org
Cc: cel@kernel.org, chuck.lever@oracle.com, dai.ngo@oracle.com, 
	jlayton@kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	neil@brown.name, okorniev@redhat.com, syzkaller-bugs@googlegroups.com, 
	tom@talpey.com
Content-Type: text/plain; charset="UTF-8"

>
>
> On Mon, Dec 1, 2025, at 5:38 PM, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    7d0a66e4bb90 Linux 6.18
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=13d52512580000
>> kernel config:  
>> https://syzkaller.appspot.com/x/.config?x=1cd7f786c0f5182f
>> dashboard link: 
>> https://syzkaller.appspot.com/bug?extid=31dce4175fcaed9dae98
>> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU 
>> Binutils for Debian) 2.40
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image: 
>> https://storage.googleapis.com/syzbot-assets/426e88dc4200/disk-7d0a66e4.raw.xz
>> vmlinux: 
>> https://storage.googleapis.com/syzbot-assets/07f64a43f087/vmlinux-7d0a66e4.xz
>> kernel image: 
>> https://storage.googleapis.com/syzbot-assets/43778a8316e2/bzImage-7d0a66e4.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+31dce4175fcaed9dae98@syzkaller.appspotmail.com
>>
>> INFO: task syz.7.3138:20679 blocked for more than 143 seconds.
>>       Tainted: G          I         syzkaller #0
>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this 
>> message.
>> task:syz.7.3138      state:D stack:27528 pid:20679 tgid:20678 
>> ppid:19956  task_flags:0x400140 flags:0x00080002
>> Call Trace:
>>  <TASK>
>>  context_switch kernel/sched/core.c:5325 [inline]
>>  __schedule+0x1190/0x5de0 kernel/sched/core.c:6929
>>  __schedule_loop kernel/sched/core.c:7011 [inline]
>>  schedule+0xe7/0x3a0 kernel/sched/core.c:7026
>>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7083
>>  __mutex_lock_common kernel/locking/mutex.c:676 [inline]
>>  __mutex_lock+0x818/0x1060 kernel/locking/mutex.c:760
>>  nfsd_nl_version_set_doit+0xc4/0x7a0 fs/nfsd/nfsctl.c:1730
>>  genl_family_rcv_msg_doit+0x209/0x2f0 net/netlink/genetlink.c:1115
>>  genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>>  genl_rcv_msg+0x55c/0x800 net/netlink/genetlink.c:1210
>>  netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
>>  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
>>  netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
>>  netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1346
>>  netlink_sendmsg+0x8c8/0xdd0 net/netlink/af_netlink.c:1896
>>  sock_sendmsg_nosec net/socket.c:727 [inline]
>>  __sock_sendmsg net/socket.c:742 [inline]
>>  ____sys_sendmsg+0xa98/0xc70 net/socket.c:2630
>>  ___sys_sendmsg+0x134/0x1d0 net/socket.c:2684
>>  __sys_sendmsg+0x16d/0x220 net/socket.c:2716
>>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>  do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7ff6b358f7c9
>> RSP: 002b:00007ff6b43f7038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
>> RAX: ffffffffffffffda RBX: 00007ff6b37e5fa0 RCX: 00007ff6b358f7c9
>> RDX: 0000000004004000 RSI: 0000200000003200 RDI: 0000000000000003
>> RBP: 00007ff6b3613f91 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>> R13: 00007ff6b37e6038 R14: 00007ff6b37e5fa0 R15: 00007fffed6dad48
>>  </TASK>
>> INFO: task syz.6.3144:20706 blocked for more than 147 seconds.
>>       Tainted: G          I         syzkaller #0
>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this 
>> message.
>> task:syz.6.3144      state:D stack:27448 pid:20706 tgid:20705 
>> ppid:19445  task_flags:0x400140 flags:0x00080002
>> Call Trace:
>>  <TASK>
>>  context_switch kernel/sched/core.c:5325 [inline]
>>  __schedule+0x1190/0x5de0 kernel/sched/core.c:6929
>>  __schedule_loop kernel/sched/core.c:7011 [inline]
>>  schedule+0xe7/0x3a0 kernel/sched/core.c:7026
>>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7083
>>  __mutex_lock_common kernel/locking/mutex.c:676 [inline]
>>  __mutex_lock+0x818/0x1060 kernel/locking/mutex.c:760
>>  nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:593
>>  nfsd_umount+0x48/0xe0 fs/nfsd/nfsctl.c:1347
>>  deactivate_locked_super+0xc1/0x1a0 fs/super.c:473
>>  deactivate_super fs/super.c:506 [inline]
>>  deactivate_super+0xde/0x100 fs/super.c:502
>>  cleanup_mnt+0x225/0x450 fs/namespace.c:1318
>>  task_work_run+0x150/0x240 kernel/task_work.c:227
>>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>>  exit_to_user_mode_loop+0xec/0x130 kernel/entry/common.c:43
>>  exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
>>  syscall_exit_to_user_mode_work include/linux/entry-common.h:175 
>> [inline]
>>  syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
>>  do_syscall_64+0x426/0xfa0 arch/x86/entry/syscall_64.c:100
>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7f70f958f7c9
>> RSP: 002b:00007f70fa3f9038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
>> RAX: fffffffffffffffe RBX: 00007f70f97e5fa0 RCX: 00007f70f958f7c9
>> RDX: 0000200000000100 RSI: 00002000000000c0 RDI: 0000000000000000
>> RBP: 00007f70f9613f91 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>> R13: 00007f70f97e6038 R14: 00007f70f97e5fa0 R15: 00007ffd32d60018
>>  </TASK>
>>
>> Showing all locks held in the system:
>> 1 lock held by khungtaskd/31:
>>  #0: ffffffff8e3c45e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire 
>> include/linux/rcupdate.h:331 [inline]
>>  #0: ffffffff8e3c45e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock 
>> include/linux/rcupdate.h:867 [inline]
>>  #0: ffffffff8e3c45e0 (rcu_read_lock){....}-{1:3}, at: 
>> debug_show_all_locks+0x36/0x1c0 kernel/locking/lockdep.c:6775
>> 2 locks held by kworker/1:4/5890:
>>  #0: ffff88813ff15948 ((wq_completion)events){+.+.}-{0:0}, at: 
>> process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3238
>>  #1: ffffc9000456fd00 (free_ipc_work){+.+.}-{0:0}, at: 
>> process_one_work+0x929/0x1b70 kernel/workqueue.c:3239
>> 2 locks held by kworker/u10:4/13138:
>>  #0: ffff88813ff29148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: 
>> process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3238
>>  #1: ffff8880b8524088 (psi_seq){-.-.}-{0:0}, at: psi_sched_switch 
>> kernel/sched/stats.h:220 [inline]
>>  #1: ffff8880b8524088 (psi_seq){-.-.}-{0:0}, at: 
>> __schedule+0x1861/0x5de0 kernel/sched/core.c:6923
>> 2 locks held by syz.4.1989/15528:
>>  #0: ffff88806018e0e0 (&type->s_umount_key#52){++++}-{4:4}, at: 
>> __super_lock fs/super.c:57 [inline]
>>  #0: ffff88806018e0e0 (&type->s_umount_key#52){++++}-{4:4}, at: 
>> __super_lock_excl fs/super.c:72 [inline]
>>  #0: ffff88806018e0e0 (&type->s_umount_key#52){++++}-{4:4}, at: 
>> deactivate_super fs/super.c:505 [inline]
>>  #0: ffff88806018e0e0 (&type->s_umount_key#52){++++}-{4:4}, at: 
>> deactivate_super+0xd6/0x100 fs/super.c:502
>>  #1: ffffffff8e7ed348 (nfsd_mutex){+.+.}-{4:4}, at: 
>> nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:593
>> 5 locks held by kworker/u10:10/18292:
>>  #0: ffff88801ba9f148 ((wq_completion)netns){+.+.}-{0:0}, at: 
>> process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3238
>>  #1: ffffc90004a9fd00 (net_cleanup_work){+.+.}-{0:0}, at: 
>> process_one_work+0x929/0x1b70 kernel/workqueue.c:3239
>>  #2: ffffffff900d52b0 (pernet_ops_rwsem){++++}-{4:4}, at: 
>> cleanup_net+0xad/0x8b0 net/core/net_namespace.c:669
>>  #3: ffffffff900eb6c8 (rtnl_mutex){+.+.}-{4:4}, at: 
>> wiphy_unregister+0x13d/0xc50 net/wireless/core.c:1165
>>  #4: ffff88805dad0788 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: wiphy_lock 
>> include/net/cfg80211.h:6343 [inline]
>>  #4: ffff88805dad0788 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: 
>> wiphy_unregister+0x147/0xc50 net/wireless/core.c:1166
>> 3 locks held by kworker/u10:12/18294:
>>  #0: ffff888030d69948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: 
>> process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3238
>>  #1: ffffc90003eefd00 
>> ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: 
>> process_one_work+0x929/0x1b70 kernel/workqueue.c:3239
>>  #2: ffffffff900eb6c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock 
>> include/linux/rtnetlink.h:130 [inline]
>>  #2: ffffffff900eb6c8 (rtnl_mutex){+.+.}-{4:4}, at: 
>> addrconf_verify_work+0x12/0x30 net/ipv6/addrconf.c:4734
>> 1 lock held by syz.1.2823/19276:
>> 2 locks held by syz.5.2942/19853:
>>  #0: ffffffff9018f490 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 
>> net/netlink/genetlink.c:1218
>>  #1: ffffffff8e7ed348 (nfsd_mutex){+.+.}-{4:4}, at: 
>> nfsd_nl_threads_set_doit+0x687/0xbc0 fs/nfsd/nfsctl.c:1590
>> 2 locks held by getty/20629:
>>  #0: ffff88803528d0a0 (&tty->ldisc_sem){++++}-{0:0}, at: 
>> tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
>>  #1: ffffc90002fd22f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: 
>> n_tty_read+0x41b/0x14f0 drivers/tty/n_tty.c:2222
>> 2 locks held by syz.7.3138/20679:
>>  #0: ffffffff9018f490 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 
>> net/netlink/genetlink.c:1218
>>  #1: ffffffff8e7ed348 (nfsd_mutex){+.+.}-{4:4}, at: 
>> nfsd_nl_version_set_doit+0xc4/0x7a0 fs/nfsd/nfsctl.c:1730
>> 2 locks held by syz.6.3144/20706:
>>  #0: ffff88805a2600e0 (&type->s_umount_key#52){++++}-{4:4}, at: 
>> __super_lock fs/super.c:57 [inline]
>>  #0: ffff88805a2600e0 (&type->s_umount_key#52){++++}-{4:4}, at: 
>> __super_lock_excl fs/super.c:72 [inline]
>>  #0: ffff88805a2600e0 (&type->s_umount_key#52){++++}-{4:4}, at: 
>> deactivate_super fs/super.c:505 [inline]
>>  #0: ffff88805a2600e0 (&type->s_umount_key#52){++++}-{4:4}, at: 
>> deactivate_super+0xd6/0x100 fs/super.c:502
>>  #1: ffffffff8e7ed348 (nfsd_mutex){+.+.}-{4:4}, at: 
>> nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:593
>> 2 locks held by syz-executor/20776:
>>  #0: ffff88805b41e0e0 (&type->s_umount_key#52){++++}-{4:4}, at: 
>> __super_lock fs/super.c:57 [inline]
>>  #0: ffff88805b41e0e0 (&type->s_umount_key#52){++++}-{4:4}, at: 
>> __super_lock_excl fs/super.c:72 [inline]
>>  #0: ffff88805b41e0e0 (&type->s_umount_key#52){++++}-{4:4}, at: 
>> deactivate_super fs/super.c:505 [inline]
>>  #0: ffff88805b41e0e0 (&type->s_umount_key#52){++++}-{4:4}, at: 
>> deactivate_super+0xd6/0x100 fs/super.c:502
>>  #1: ffffffff8e7ed348 (nfsd_mutex){+.+.}-{4:4}, at: 
>> nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:593
>> 2 locks held by syz.2.3203/21060:
>>  #0: ffff88801c3480e0 (&type->s_umount_key#52){++++}-{4:4}, at: 
>> __super_lock fs/super.c:57 [inline]
>>  #0: ffff88801c3480e0 (&type->s_umount_key#52){++++}-{4:4}, at: 
>> __super_lock_excl fs/super.c:72 [inline]
>>  #0: ffff88801c3480e0 (&type->s_umount_key#52){++++}-{4:4}, at: 
>> deactivate_super fs/super.c:505 [inline]
>>  #0: ffff88801c3480e0 (&type->s_umount_key#52){++++}-{4:4}, at: 
>> deactivate_super+0xd6/0x100 fs/super.c:502
>>  #1: ffffffff8e7ed348 (nfsd_mutex){+.+.}-{4:4}, at: 
>> nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:593
>> 2 locks held by syz.3.3291/21497:
>>  #0: ffff8880753ce0e0 (&type->s_umount_key#52){++++}-{4:4}, at: 
>> __super_lock fs/super.c:57 [inline]
>>  #0: ffff8880753ce0e0 (&type->s_umount_key#52){++++}-{4:4}, at: 
>> __super_lock_excl fs/super.c:72 [inline]
>>  #0: ffff8880753ce0e0 (&type->s_umount_key#52){++++}-{4:4}, at: 
>> deactivate_super fs/super.c:505 [inline]
>>  #0: ffff8880753ce0e0 (&type->s_umount_key#52){++++}-{4:4}, at: 
>> deactivate_super+0xd6/0x100 fs/super.c:502
>>  #1: ffffffff8e7ed348 (nfsd_mutex){+.+.}-{4:4}, at: 
>> nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:593
>> 2 locks held by syz-executor/21510:
>>  #0: ffffffff8f492c00 (&ops->srcu#2){.+.+}-{0:0}, at: srcu_lock_acquire 
>> include/linux/srcu.h:161 [inline]
>>  #0: ffffffff8f492c00 (&ops->srcu#2){.+.+}-{0:0}, at: srcu_read_lock 
>> include/linux/srcu.h:253 [inline]
>>  #0: ffffffff8f492c00 (&ops->srcu#2){.+.+}-{0:0}, at: 
>> rtnl_link_ops_get+0x113/0x2c0 net/core/rtnetlink.c:574
>>  #1: ffffffff900eb6c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock 
>> net/core/rtnetlink.c:80 [inline]
>>  #1: ffffffff900eb6c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock 
>> net/core/rtnetlink.c:341 [inline]
>>  #1: ffffffff900eb6c8 (rtnl_mutex){+.+.}-{4:4}, at: 
>> rtnl_newlink+0x600/0x2000 net/core/rtnetlink.c:4064
>> 1 lock held by syz.9.3298/21533:
>>  #0: ffffffff8e3cfb78 (rcu_state.exp_mutex){+.+.}-{4:4}, at: 
>> exp_funnel_lock+0x1a3/0x3c0 kernel/rcu/tree_exp.h:343
>> 5 locks held by syz.8.3302/21552:
>>  #0: ffff8880334d0dc8 (&hdev->req_lock){+.+.}-{4:4}, at: 
>> hci_dev_do_close+0x26/0x90 net/bluetooth/hci_core.c:499
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>>
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>>
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>>
>> If you want to undo deduplication, reply with:
>> #syz undup
>
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git nfsd-testing

This crash does not have a reproducer. I cannot test it.

>
> -- 
> Chuck Lever

