Return-Path: <linux-nfs+bounces-3789-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B28907CBB
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 21:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3F51C24776
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 19:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AD514D2B7;
	Thu, 13 Jun 2024 19:38:29 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F44E14D43B
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718307508; cv=none; b=MAfVGBQLyLtxL233OG9Ff2hr3Z07YmEOdO+VhPVD9zJdQm8tjL+9MEcc8bAA9WrGEKNvdAENB7yfLQZtbFLZG5xV/5GifM9GmyxtR+v7MjWyAvRBGCvL7jQAOkUrMirl1NJaxmPaaiTAlAygDBGhiafBjA7PdkTpnAJ/KNSHhTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718307508; c=relaxed/simple;
	bh=H/S6Itvy0jisfI7Obwgq98dRfRkKXMx6ORGiUDwNTn8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qdxSzDSiswbyAxYsHjtLArxvO0VL0tUlWsuz5MHWtSZGjKZPLBnlUR8P3uhjBrObphIsOQwDLAlAtZK8wecGF6VcpzIV+Lf3sbKMSlm+NZngfQPrkNBcpiz7KhHJ9YvSVA7XOXaXMs51B4lPsaAFS81z73jrMh/RiHtD4NMOHiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3746147204eso16076825ab.3
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 12:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718307506; x=1718912306;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=shcUfsSzR60MVrYZuaw9/Nxrd9k8exAnjdSt/gZq5FA=;
        b=oWWIa6EUUWLyPtkBo1b//WhVjh8Z/tWXhe60hxCbCIOaqUFbOFDOi/YYqdSvmbiHZ8
         l8bJBQkb4VIF6BF5UsyUKj6hmuZfyOXDk15cIW+xWlD8rc/+Y8jj/nFWYgATBG5hOORM
         EjUmSe757xHXgpv1C8UHpMuIRjLkZe5n4Z/xD0xHmLphP6i396l/LS98kxg8EyQHRUru
         DdYqsL0uGdXV4UviD34aPeawHBGqCOc10jT7Xyxx1RcV9O0Pp9ujyQFiwpbTqNzavMWv
         Lg/cWJDVrXcrU9SnAjGEH0S4o9+OpZWdmMhdVnrZu+5a+bbgQQzJTH557CIKvNKk6Xuk
         0qhw==
X-Forwarded-Encrypted: i=1; AJvYcCUxdxjC8ytxhm3YUtgfPTg6B7hItxPvssk2eVtqiWc4ZU4CPWrD9kABgirN4DvwlzyNsa94rHoAr5gyGm1d7JUvTgqNqt7XKgSz
X-Gm-Message-State: AOJu0YxTFEHLAIg/dczkufNKzaoOUBgR1H3uO0c/X4U7b2C9gEZVZoYD
	JCcFtHSD2kOp0Jg2vonP+x95sOcU+1UwGR5l+Nvhj9sJAj76PkYQw756Lor+nnnTFEY3QRfgjbx
	UUoJvVWsKFcFb7SngfY5dgyi8het6erfO5UochIzjcV18etjst89I+u0=
X-Google-Smtp-Source: AGHT+IEKRTYIJl4K/2L5FZ+wi/rO2ZD/NJ9La25Jt9LHYHlUMCFt1mnWd3VbnDHD1cXbC93gs8qe/JhxLYXvV8iU9bG+2hUJzQnt
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2163:b0:375:a6cd:e005 with SMTP id
 e9e14a558f8ab-375e0ec95admr232875ab.4.1718307506500; Thu, 13 Jun 2024
 12:38:26 -0700 (PDT)
Date: Thu, 13 Jun 2024 12:38:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a444b061acaa487@google.com>
Subject: [syzbot] [nfs?] INFO: task hung in nfsd_nl_rpc_status_get_start
From: syzbot <syzbot+e9820daec56bcb4c41b5@syzkaller.appspotmail.com>
To: Dai.Ngo@oracle.com, chuck.lever@oracle.com, jlayton@kernel.org, 
	kolga@netapp.com, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	neilb@suse.de, syzkaller-bugs@googlegroups.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=158e5256980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c79815c08cc14227
dashboard link: https://syzkaller.appspot.com/bug?extid=e9820daec56bcb4c41b5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9fb20954c51e/disk-2ccbdf43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/06d78b3cf960/vmlinux-2ccbdf43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/15e5b0a8df77/bzImage-2ccbdf43.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e9820daec56bcb4c41b5@syzkaller.appspotmail.com

INFO: task syz-executor.1:7517 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:23800 pid:7517  tgid:7515  ppid:6054   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x49d0 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 nfsd_nl_rpc_status_get_start+0x8d/0xe0 fs/nfsd/nfsctl.c:1476
 genl_start+0x4d6/0x6d0 net/netlink/genetlink.c:1005
 __netlink_dump_start+0x45c/0x780 net/netlink/af_netlink.c:2445
 genl_family_rcv_msg_dumpit net/netlink/genetlink.c:1076 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1192 [inline]
 genl_rcv_msg+0x88c/0xec0 net/netlink/genetlink.c:1210
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
RIP: 0033:0x7f182b67cea9
RSP: 002b:00007f182c48a0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f182b7b3f80 RCX: 00007f182b67cea9
RDX: 0000000000000000 RSI: 0000000020000180 RDI: 0000000000000003
RBP: 00007f182b6ebff4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f182b7b3f80 R15: 00007ffd83adb8d8
 </TASK>

Showing all locks held in the system:
5 locks held by kworker/u8:1/12:
 #0: ffff888015ed3148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015ed3148 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90000117d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90000117d00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8f5c8cd0 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:594
 #3: ffff8880237ed408 (&wg->device_update_lock){+.+.}-{3:3}, at: wg_destruct+0x110/0x2e0 drivers/net/wireguard/device.c:249
 #4: ffffffff8e339240 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x4c/0x530 kernel/rcu/tree.c:4448
1 lock held by khungtaskd/30:
 #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
3 locks held by kworker/u8:4/61:
 #0: ffff8880b953e798 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
 #1: ffff8880b9528948 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x441/0x770 kernel/sched/psi.c:988
 #2: ffff8880b953e798 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
3 locks held by kworker/0:2/1156:
 #0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90004627d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90004627d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8f5d5508 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
2 locks held by kworker/u8:9/2839:
2 locks held by getty/4842:
 #0: ffff88802b04c0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f162f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2201
2 locks held by syz-fuzzer/5088:
3 locks held by kworker/0:6/5164:
 #0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90004577d00 (free_ipc_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90004577d00 (free_ipc_work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8e339378 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:291 [inline]
 #2: ffffffff8e339378 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x381/0x830 kernel/rcu/tree_exp.h:939
2 locks held by syz-executor.4/7353:
 #0: ffffffff8f63b9d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e600748 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
3 locks held by syz-executor.1/7517:
 #0: ffffffff8f63b9d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffff888052998678 (nlk_cb_mutex-GENERIC){+.+.}-{3:3}, at: __netlink_dump_start+0x119/0x780 net/netlink/af_netlink.c:2418
 #2: ffffffff8e600748 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_rpc_status_get_start+0x8d/0xe0 fs/nfsd/nfsctl.c:1476
2 locks held by syz-executor.1/10475:
 #0: ffffffff8f5d5508 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f5d5508 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x842/0x1180 net/core/rtnetlink.c:6632


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

