Return-Path: <linux-nfs+bounces-4250-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 549D5914E3A
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 15:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2BA1F231DE
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 13:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDB713D89C;
	Mon, 24 Jun 2024 13:18:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B2A13D893
	for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235101; cv=none; b=C7dkJFvjRImKdPvsFeA8rRhCZOus82lRvoqh0BLfaQMr3z5EQrqVn7I9CnEAZ2JdfqgLiqupilqhwLZUN5I6kFuyHGFUWg6hJ6H59GSth9cpBji7NXMHVOdviAxtlEFFwjfjvSGHsXF4oZHtKlj9TgCAMiyo7jZiMYVVHe5RY8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235101; c=relaxed/simple;
	bh=4NmMqpXaheoJ2eP+Xne1NUKxoz3niDAQu5BZtNNH2gU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fN8dRRv3SvoIczuUt5TXyn10ZmDm0oqUsBGwnsnfO2HmJLJJivmb3o1crYTBCseuwv56cvc9fBHubx0D0zWq9bhxM4/kDxEzpgi5lb/bXXqWTMTFdixR5QUlq32yHhg+4hQIKQL+EQRM2L0eQTzJGohpRU1vzGzBvkGdnyqAues=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7e20341b122so535925339f.1
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 06:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719235099; x=1719839899;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KUgcIyJliLtvlzg+fJF2Y49udiLnpDYPMvh9V/dPt3c=;
        b=bcy0dpYyeqsNcN+DGNOfQAVVDeQsF50BIJ89Q8Kl2uKQRVo/caK0IM/gx3yTkeQNVu
         IudfGhrx/jkGhKLAPf2aGt+By6tbNMPUuFXRzOwvRwPDF8xIcBJ1drDZDvZrGbu471jh
         VcLMNtquRzSuh+00nssXn+N3v5vm1yt7oOgqfWCR166kiPgzIO1i8QnYEEuCFj/7Ym2k
         BiqutM0jnulE+qqGerR+Vyid6YENZ9Zx8U7sjW1zAiQT3dGEunAe1r6JjtxSx10KXJNO
         HQ+5QdyrFE6a5JFqH6yRm/RQ1ToPeW+V2NBDG33F/v2Ofbt3uXo8Xs4yxGP9IHCetZzA
         o6eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVweGvcAe86PgTHIojU7zcGAsb+11Tx/PowjBn8GUDUIHUSb8lVxYBO4qkkW75KTteY9BawiiD/ItFBZu2f1yacFQo9Pf8BxDSY
X-Gm-Message-State: AOJu0Yxl6Cg6qWRgq7ITQms9auvo6EF0Fvi1loGkUShjPQBeJhW3M+/i
	iXRyI+6+K1UlUL4/sca/8KdY11LvD5LdTORzVWNbDTZnbOOLkoTSrVclpKogtgIRuEDtUQHghNN
	+J9wm5RZcnWDp7Fhsau6b45TF72hZYNhiV2nHR68G4onoNGazwjmCbcg=
X-Google-Smtp-Source: AGHT+IG5jLSdDjyx8Re1F9TQ7Hravqbt2Fa9IJZVZaQE6ZebSOjuqXGqH7cAU2Qnvg1LpnMIVoJI6GgXiazIJVlOzjxJeNO3zgXB
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1605:b0:7f3:a80e:8cec with SMTP id
 ca18e2360f4ac-7f3a80e8da1mr11642639f.0.1719235099486; Mon, 24 Jun 2024
 06:18:19 -0700 (PDT)
Date: Mon, 24 Jun 2024 06:18:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000063fd99061ba29d87@google.com>
Subject: [syzbot] [nfs?] INFO: task hung in nfsd_nl_version_get_doit
From: syzbot <syzbot+41bc60511c2884783c27@syzkaller.appspotmail.com>
To: Dai.Ngo@oracle.com, chuck.lever@oracle.com, jlayton@kernel.org, 
	kolga@netapp.com, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	neilb@suse.de, syzkaller-bugs@googlegroups.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a8c3de980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c79815c08cc14227
dashboard link: https://syzkaller.appspot.com/bug?extid=41bc60511c2884783c27
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9fb20954c51e/disk-2ccbdf43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/06d78b3cf960/vmlinux-2ccbdf43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/15e5b0a8df77/bzImage-2ccbdf43.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+41bc60511c2884783c27@syzkaller.appspotmail.com

INFO: task syz-executor.2:26515 blocked for more than 144 seconds.
      Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:26328 pid:26515 tgid:26509 ppid:26207  flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x49d0 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 nfsd_nl_version_get_doit+0x181/0x780 fs/nfsd/nfsctl.c:1892
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
 ___sys_sendmsg net/socket.c:2639 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7e21a7cea9
RSP: 002b:00007f7e228320c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f7e21bb4120 RCX: 00007f7e21a7cea9
RDX: 0000000000000000 RSI: 0000000020000180 RDI: 000000000000000c
RBP: 00007f7e21aebff4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f7e21bb4120 R15: 00007ffcc0bd6078
 </TASK>

Showing all locks held in the system:
1 lock held by pool_workqueue_/3:
1 lock held by khungtaskd/30:
 #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
2 locks held by kworker/u8:6/1098:
2 locks held by getty/4840:
 #0: ffff88802abac0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f0e2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2201
2 locks held by syz-fuzzer/5091:
3 locks held by kworker/0:0/15508:
 #0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc9000429fd00 (free_ipc_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc9000429fd00 (free_ipc_work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8e339378 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:323 [inline]
 #2: ffffffff8e339378 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:939
2 locks held by kworker/u8:14/18935:
2 locks held by syz-executor.0/25819:
 #0: ffffffff8f63b9d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e600748 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
2 locks held by syz-executor.2/26515:
 #0: ffffffff8f63b9d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e600748 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_version_get_doit+0x181/0x780 fs/nfsd/nfsctl.c:1892
2 locks held by syz-executor.3/26579:
 #0: ffffffff8f63b9d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e600748 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_version_get_doit+0x181/0x780 fs/nfsd/nfsctl.c:1892
1 lock held by syz-executor.2/28062:
 #0: ffffffff8e339378 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:291 [inline]
 #0: ffffffff8e339378 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x381/0x830 kernel/rcu/tree_exp.h:939
1 lock held by syz-executor.3/28067:

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 30 Comm: khungtaskd Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xfde/0x1020 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 28056 Comm: syz-executor.0 Not tainted 6.10.0-rc3-syzkaller


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

