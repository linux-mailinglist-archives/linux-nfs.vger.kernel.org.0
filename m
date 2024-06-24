Return-Path: <linux-nfs+bounces-4251-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDD1914E3B
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 15:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64140B22A34
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 13:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EE913D893;
	Mon, 24 Jun 2024 13:18:22 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA8213B58C
	for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235102; cv=none; b=frC2hYUU/cGqi3WU4qQA7K6Q4vV1EfJoDxfaUtRHnr0FG//30SqJ9f7uV4VqGHxQ+0mjWceEyg0cg43mdaM4cxphSfjTJHeh/xeJcbW4o7ciw8YMsbkQboxyyQUrgXQS/KOf+93bqpZeM9/KQSlM/b+H4afrP6N3x/KYeA8fWyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235102; c=relaxed/simple;
	bh=VsJ4Axxe0lD9wiL7UkNBXbnaR995h96E/ihbsOZuk9E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Lj1dOlCZRDsJJ9W1T+whDEl6fKV2lesqe0aKkMjJT+GTbSJXVDVKAV1DdhKaQymmd1SD6LU3mdBN3b94nmRjQnWJv8d5IqnGW9V1EqXiA0mONJb8LXA3IVa5DhwwChp1S44wfQc2RiD9VQuDlXdXLn84j2OyqpUKQUipXKenBIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7eee84ec53dso624009839f.3
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 06:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719235100; x=1719839900;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=80o3vsdmOmtI6NOidvP3vTkB6hQktZz1ZWS/3Aeds7Y=;
        b=Iiwdqu3JENGMnxyFolrECx/yH59Lp5K73Du0cM7cwYN+c4ind8JdU6hGEJen5R/m9z
         +hWxMQz2lYqbaFyGiPXXhxI4VINKrxNuLor1RRcZlnTOpvGf6/oIbhJVDxzrKatcuDJ0
         b5qzTBie2lGheVGyw0Rc/86ZqrYKxDEqrpcpSoEQMPPkKQq+K+exiEtRrE2ZR8vJY/Vl
         4D9V+MPKIGOuJRJkm7Nnq576Xyo2Mjq4EkbQdP3uCVFJbHD4+C/QPtHWif9j7rETlEIM
         SLfuukbU5e3ulPUK6UXP+OEkJVaaeUR1vvmODTSb+gLICXazNvgw5h4XkKyLxQumVVtt
         jL6A==
X-Forwarded-Encrypted: i=1; AJvYcCXvJykuT0UYmKEvmF7RRR7RZkUiZNQ5C8qouPrDyTnaIX+LtmbWq7GE0yjpzhHFqO0yAomOZ6WDOnZndI6v01QnBupuLj43vpxf
X-Gm-Message-State: AOJu0YzRvDT/DenKdpk8/0kMPlpKeFNK1NRmUGY/8nx8ZkwAycdGcLWk
	XqaWgFUejaE54b+Yo1rUhlxj87rkD3xMSgszmGk4vcnj/PsFVVIXsA5vU6cEswBePhMcIMOtQcF
	c+dSL/jKfYF2pbCjnn82UQTjWCJEcKv8OPYCdlCBqhcg79zt0tDqr/tc=
X-Google-Smtp-Source: AGHT+IFCfmG/DoiVKsD18IF4nTM6xnfMq1OCnpEjcZqud1jjFclLuDmWDKiqpfS5gjNPSCgflquSWSLtM82q/93IHEC48Wy++WJK
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:248b:b0:4b9:6e74:bafb with SMTP id
 8926c6da1cb9f-4b9e7a0451emr272859173.0.1719235099790; Mon, 24 Jun 2024
 06:18:19 -0700 (PDT)
Date: Mon, 24 Jun 2024 06:18:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000689a2b061ba29db3@google.com>
Subject: [syzbot] [nfs?] INFO: task hung in nfsd_nl_threads_get_doit
From: syzbot <syzbot+c0831b61d6ade1e2d098@syzkaller.appspotmail.com>
To: Dai.Ngo@oracle.com, chuck.lever@oracle.com, jlayton@kernel.org, 
	kolga@netapp.com, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	neilb@suse.de, syzkaller-bugs@googlegroups.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cea2a26553ac mailmap: Add my outdated addresses to the map..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=118b1796980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8786f381e62940f
dashboard link: https://syzkaller.appspot.com/bug?extid=c0831b61d6ade1e2d098
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c2c55a2edceb/disk-cea2a265.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e3f36f58a11d/vmlinux-cea2a265.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0447e9647456/bzImage-cea2a265.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c0831b61d6ade1e2d098@syzkaller.appspotmail.com

INFO: task syz-executor.2:20070 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc3-syzkaller-00022-gcea2a26553ac #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:27840 pid:20070 tgid:20068 ppid:19010  flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 nfsd_nl_threads_get_doit+0x1c6/0x7d0 fs/nfsd/nfsctl.c:1757
 genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2564
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x542/0x820 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0xab5/0xc90 net/socket.c:2585
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2639
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2668
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8368c7cea9
RSP: 002b:00007f8369a710c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f8368db3f80 RCX: 00007f8368c7cea9
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 00007f8368cebff4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f8368db3f80 R15: 00007ffc121dd2e8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8dbb1920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8dbb1920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8dbb1920 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6614
2 locks held by getty/4834:
 #0: ffff88802a5540a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc8/0x1490 drivers/tty/n_tty.c:2201
1 lock held by syz-fuzzer/5075:
3 locks held by kworker/0:4/10299:
 #0: ffff888015480948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x12bf/0x1b60 kernel/workqueue.c:3206
 #1: ffffc900032cfd80 (free_ipc_work){+.+.}-{0:0}, at: process_one_work+0x957/0x1b60 kernel/workqueue.c:3207
 #2: ffffffff8dbbd0b8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x282/0x3b0 kernel/rcu/tree_exp.h:291
2 locks held by syz-executor.0/19218:
 #0: ffffffff8f7e9d90 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8dfb2f48 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0xe3/0x1b30 fs/nfsd/nfsctl.c:1966
1 lock held by syz-executor.1/19451:
3 locks held by kworker/u8:0/20032:
2 locks held by syz-executor.2/20070:
 #0: ffffffff8f7e9d90 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8dfb2f48 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_threads_get_doit+0x1c6/0x7d0 fs/nfsd/nfsctl.c:1757
3 locks held by syz-executor.4/20215:
 #0: ffff8880560b0d88 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_do_close+0x26/0x90 net/bluetooth/hci_core.c:554
 #1: ffff8880560b0078 (&hdev->lock){+.+.}-{3:3}, at: hci_dev_close_sync+0x339/0x1100 net/bluetooth/hci_sync.c:5050
 #2: ffffffff8f9adba8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_disconn_cfm include/net/bluetooth/hci_core.h:1982 [inline]
 #2: ffffffff8f9adba8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_hash_flush+0xc4/0x260 net/bluetooth/hci_conn.c:2584
2 locks held by syz-executor.2/20315:
3 locks held by syz-executor.3/20448:
 #0: ffff888063cf4d88 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_do_close+0x26/0x90 net/bluetooth/hci_core.c:554
 #1: ffff888063cf4078 (&hdev->lock){+.+.}-{3:3}, at: hci_dev_close_sync+0x339/0x1100 net/bluetooth/hci_sync.c:5050
 #2: ffffffff8f9adba8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_disconn_cfm include/net/bluetooth/hci_core.h:1982 [inline]
 #2: ffffffff8f9adba8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_hash_flush+0xc4/0x260 net/bluetooth/hci_conn.c:2584
1 lock held by syz-executor.0/21407:
 #0: ffffffff8dbbd0b8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x1a4/0x3b0 kernel/rcu/tree_exp.h:323

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 30 Comm: khungtaskd Not tainted 6.10.0-rc3-syzkaller-00022-gcea2a26553ac #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
NMI backtrace for cpu 1 skipped: idling at acpi_safe_halt+0x1a/0x20 drivers/acpi/processor_idle.c:112


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

