Return-Path: <linux-nfs+bounces-4997-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3105F9382EC
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Jul 2024 23:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC6A2814B1
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Jul 2024 21:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4589B146D6C;
	Sat, 20 Jul 2024 21:33:13 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605604CE09
	for <linux-nfs@vger.kernel.org>; Sat, 20 Jul 2024 21:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721511193; cv=none; b=lTIFFz6MwxPcqc5czojqlfdz9yefqhTb+0RaHTXYhLeykYSPjNevOe47AWHUXu0rq1w6s8Qy0IqGqATO/NqYrVlTN0SDYhFrYg2Uh9vznyZ1hnzNrS7VdnTvgfG7+9cIP2zzNkmEy5foMVA2nNyn5D5V7aX1GoAXZe9KpL+DX6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721511193; c=relaxed/simple;
	bh=eiO8t/161g67fZki6HGMZFC5kyTAw+3gYpQbhlADmaI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=P3TI/6cXbVxWsZvnXjm9ptC7sIOuvKiU1GRfBtbyHDLNR7rWOGQEM1SPs2uCpQgCDxOkMdA9Nn3viB4i1RTvMo9aNlo6T8h2o+C77x6MWkIHN1/Z63yRyFXMqSkLPKPFUkN/A1nGpAnb8Cr7y4OiXRBolB43QzOVTp5R3Uzx1zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-396c41de481so45240145ab.3
        for <linux-nfs@vger.kernel.org>; Sat, 20 Jul 2024 14:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721511190; x=1722115990;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ihLxrsOhIj2j4UTX6DqcbntyPixc5QK3lMbZ//Qm7Bw=;
        b=M+cBYNht5ufJfDCfNrC5A2ubyeHuqYeLry3aJq8NdNBkot8dBiEncAsnliDeOPDEiE
         iUDO8Nm2apM9qLBh+hzUmy4YdCH+8y5mfZabU1NYfvuooa4oqj/6VpEznyY2+l2JSv2D
         VaNl+XjYBnlZSaGpOE2I8LoA7SSC3aZxOX5IfqZpTHW66/rgppIlbMjTGWbMLeGefdLP
         sh5jigFQcJw/WYV6mLO0+YeaZQ9VANKAYB6uys4pT/M3aXUc4M4EY/ITZkhgBzBvpWfr
         KkyDgYSo2noFHC39L31UTP8UKnYtzlZ+49AFym3phrvhT7cAxnioIdZeT1bY6MrFVJKC
         wumw==
X-Forwarded-Encrypted: i=1; AJvYcCWyA59xvMyk5h/F3T0zu//XNgDdiwtBrNMhpRz4w1RA+Swefxu/sWqy2Mr1FE0stdV2kfjfSNHwBO/LiiHymcF/yduXYD6AzFSD
X-Gm-Message-State: AOJu0Ywlsz5m6rUf864vAHrC5qS7Sjsyzvhol+xCGaBrSMBLyebSTOl5
	0CTWU2iDCCUVdOc/GoMT2sZFliafv6MnxjCdxk7fmMLY5h2pEQSdpBlv46HF9O9/fLTb2dVGU5g
	PW+JrOm1waWP9SpYb1CruvwDuxCeaJgRUNO7T8/Hj7JdEyDPSEp4o9oo=
X-Google-Smtp-Source: AGHT+IH6LJq/qzqbcxO1ruHYTl3FHFxNrJwmPy4R/j39QN4z8JyF8Yvx/VpmZb7Do8KO7C1igoqH/swXmz6ppWPcE7jXiZ8tuQ7u
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d94:b0:382:56bd:dfbc with SMTP id
 e9e14a558f8ab-398e509bcecmr1963015ab.2.1721511190529; Sat, 20 Jul 2024
 14:33:10 -0700 (PDT)
Date: Sat, 20 Jul 2024 14:33:10 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd1bc1061db48ead@google.com>
Subject: [syzbot] [nfs?] INFO: task hung in nfsd_nl_rpc_status_get_dumpit
From: syzbot <syzbot+68f089d6e18e8b1d41eb@syzkaller.appspotmail.com>
To: Dai.Ngo@oracle.com, chuck.lever@oracle.com, jlayton@kernel.org, 
	kolga@netapp.com, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	neilb@suse.de, syzkaller-bugs@googlegroups.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d7e78951a8b8 Merge tag 'net-6.11-rc0' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=139afe79980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4420b8b2270c1b1
dashboard link: https://syzkaller.appspot.com/bug?extid=68f089d6e18e8b1d41eb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7f08d7d67259/disk-d7e78951.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b8fd351d830d/vmlinux-d7e78951.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1bb4a3d18f9e/bzImage-d7e78951.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+68f089d6e18e8b1d41eb@syzkaller.appspotmail.com

INFO: task syz.4.464:6984 blocked for more than 144 seconds.
      Not tainted 6.10.0-syzkaller-09703-gd7e78951a8b8 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.464       state:D stack:26160 pid:6984  tgid:6982  ppid:5094   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 nfsd_nl_rpc_status_get_dumpit+0xb1/0x1160 fs/nfsd/nfsctl.c:1550
 genl_dumpit+0x11c/0x220 net/netlink/genetlink.c:1027
 netlink_dump+0x552/0xcc0 net/netlink/af_netlink.c:2325
 __netlink_dump_start+0x6d9/0x9b0 net/netlink/af_netlink.c:2440
 genl_family_rcv_msg_dumpit+0x1e1/0x2e0 net/netlink/genetlink.c:1076
 genl_family_rcv_msg net/netlink/genetlink.c:1192 [inline]
 genl_rcv_msg+0x470/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x544/0x830 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0xab5/0xc90 net/socket.c:2597
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2651
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff23e775b59
RSP: 002b:00007ff23f596048 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ff23e905f60 RCX: 00007ff23e775b59
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 000000000000000c
RBP: 00007ff23e7e4e5d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007ff23e905f60 R15: 00007ffdc08a1768
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8dbb29a0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:327 [inline]
 #0: ffffffff8dbb29a0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:839 [inline]
 #0: ffffffff8dbb29a0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6620
3 locks held by kworker/u8:3/52:
3 locks held by kworker/u8:4/62:
 #0: ffff888029d7b948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc900015d7d80 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffffffff8f763ce8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xcf/0x1500 net/ipv6/addrconf.c:4194
3 locks held by kworker/1:2/928:
 #0: ffff888015480948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc90003c7fd80 ((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffff88802d224240 (&data->fib_lock){+.+.}-{3:3}, at: nsim_fib_event_work+0x1bb/0x26e0 drivers/net/netdevsim/fib.c:1489
2 locks held by kworker/u8:9/2475:
 #0: 
ffff8880b923ec98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested kernel/sched/core.c:568 [inline]
ffff8880b923ec98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x7e/0x130 kernel/sched/core.c:553
 #1: ffff8880b9228a48 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x2d9/0x900 kernel/sched/psi.c:989
2 locks held by getty/4849:
 #0: ffff88802f1020a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: 
ffffc900031232f0
 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc8/0x1490 drivers/tty/n_tty.c:2211
4 locks held by kworker/1:3/5137:
 #0: ffff8880b923ec98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested kernel/sched/core.c:568 [inline]
 #0: ffff8880b923ec98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x7e/0x130 kernel/sched/core.c:553
 #1: ffff8880b9328a48 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x2d9/0x900 kernel/sched/psi.c:989
 #2: ffffffff8dbb29a0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:327 [inline]
 #2: ffffffff8dbb29a0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:839 [inline]
 #2: ffffffff8dbb29a0 (rcu_read_lock){....}-{1:2}, at: check_lifetime+0x73/0xab0 net/ipv4/devinet.c:719
 #3: ffffffff94dea408 (&obj_hash[i].lock){-.-.}-{2:2}, at: debug_object_activate+0x199/0x540 lib/debugobjects.c:709
2 locks held by syz.0.392/6658:
 #0: ffffffff8f801330 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8dfb7fe8 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0xe3/0x1b30 fs/nfsd/nfsctl.c:1956
3 locks held by syz.4.464/6984:
 #0: ffffffff8f801330 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffff888078416678 (nlk_cb_mutex-GENERIC){+.+.}-{3:3}, at: __netlink_dump_start+0x154/0x9b0 net/netlink/af_netlink.c:2404
 #2: ffffffff8dfb7fe8 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_rpc_status_get_dumpit+0xb1/0x1160 fs/nfsd/nfsctl.c:1550
3 locks held by syz.3.482/7069:
 #0: ffffffff8f801330 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffff888065de7678 (nlk_cb_mutex-GENERIC){+.+.}-{3:3}, at: __netlink_dump_start+0x154/0x9b0 net/netlink/af_netlink.c:2404
 #2: ffffffff8dfb7fe8 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_rpc_status_get_dumpit+0xb1/0x1160 fs/nfsd/nfsctl.c:1550
3 locks held by syz.1.578/7517:
 #0: ffffffff8f801330 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffff888063317678 (nlk_cb_mutex-GENERIC){+.+.}-{3:3}, at: __netlink_dump_start+0x154/0x9b0 net/netlink/af_netlink.c:2404
 #2: ffffffff8dfb7fe8 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_rpc_status_get_dumpit+0xb1/0x1160 fs/nfsd/nfsctl.c:1550
3 locks held by syz.3.733/8134:
 #0: ffffffff8f801330 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffff888060faa678 (nlk_cb_mutex-GENERIC){+.+.}-{3:3}, at: __netlink_dump_start+0x154/0x9b0 net/netlink/af_netlink.c:2404
 #2: ffffffff8dfb7fe8 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_rpc_status_get_dumpit+0xb1/0x1160 fs/nfsd/nfsctl.c:1550
3 locks held by syz.0.772/8293:
 #0: ffffffff8f801330 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffff88801f9c1678 (nlk_cb_mutex-GENERIC){+.+.}-{3:3}, at: __netlink_dump_start+0x154/0x9b0 net/netlink/af_netlink.c:2404
 #2: ffffffff8dfb7fe8 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_rpc_status_get_dumpit+0xb1/0x1160 fs/nfsd/nfsctl.c:1550
3 locks held by syz-executor/8376:
 #0: ffffffff8f763ce8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f763ce8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
 #1: ffff888023ff5428 (&wg->device_update_lock){+.+.}-{3:3}, at: wg_open+0x203/0x4e0 drivers/net/wireguard/device.c:50
 #2: ffffffff8dbbe138 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x282/0x3b0 kernel/rcu/tree_exp.h:296
1 lock held by syz.3.811/8466:
 #0: ffffffff8dbbe000 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x48/0x6c0 kernel/rcu/tree.c:4486

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 30 Comm: khungtaskd Not tainted 6.10.0-syzkaller-09703-gd7e78951a8b8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xf86/0x1240 kernel/hung_task.c:379
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.10.0-syzkaller-09703-gd7e78951a8b8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:debug_spin_lock_before kernel/locking/spinlock_debug.c:88 [inline]
RIP: 0010:do_raw_spin_lock+0xe2/0x2c0 kernel/locking/spinlock_debug.c:115
Code: 65 48 8b 05 d0 3a 9b 7e 48 39 c2 0f 84 61 01 00 00 4c 8d 63 08 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 0f b6 14 02 <4c> 89 e0 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 68 01 00 00 8b
RSP: 0018:ffffc90000157890 EFLAGS: 00000802
RAX: dffffc0000000000 RBX: ffff888019b44600 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff8b2cb840 RDI: ffff888019b44604
RBP: 1ffff9200002af13 R08: 0000000000000000 R09: fffffbfff2856a82
R10: ffffffff942b5417 R11: 0000000000000000 R12: ffff888019b44608
R13: ffff888019b44610 R14: ffff888019b44600 R15: 0100000000000004
FS:  0000000000000000(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f9e2ff8 CR3: 000000007d8d6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
 _raw_spin_lock_irqsave+0x42/0x60 kernel/locking/spinlock.c:162
 class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
 try_to_wake_up+0x9a/0x13e0 kernel/sched/core.c:4051
 swake_up_locked kernel/sched/swait.c:29 [inline]
 swake_up_locked kernel/sched/swait.c:21 [inline]
 complete_with_flags kernel/sched/completion.c:24 [inline]
 complete+0xb0/0x200 kernel/sched/completion.c:47
 __usb_hcd_giveback_urb+0x389/0x6e0 drivers/usb/core/hcd.c:1650
 usb_giveback_urb_bh+0x28f/0x570 drivers/usb/core/hcd.c:1684
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 bh_worker+0x5a4/0x8a0 kernel/workqueue.c:3569
 workqueue_softirq_action+0x12c/0x190 kernel/workqueue.c:3596
 tasklet_action+0x14/0x70 kernel/softirq.c:810
 handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
 run_ksoftirqd kernel/softirq.c:928 [inline]
 run_ksoftirqd+0x3a/0x60 kernel/softirq.c:920
 smpboot_thread_fn+0x661/0xa10 kernel/smpboot.c:164
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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

