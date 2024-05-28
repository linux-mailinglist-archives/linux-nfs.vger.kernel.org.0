Return-Path: <linux-nfs+bounces-3447-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C218D22D3
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2024 19:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94EEB1C225A6
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2024 17:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFA145020;
	Tue, 28 May 2024 17:54:31 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33576446A1
	for <linux-nfs@vger.kernel.org>; Tue, 28 May 2024 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716918871; cv=none; b=YihRDYBkkQ6FYrEsHy8a90pwV2kjAEFtIa67FYae4MqjJjqrUVFfafDtPQXC5WLwN8IwVBZk8o9jV8WMbsoRU7Xol3IsGSocQv0XF4Q25F0LUp3IgV3wyh5PDCyX3iTtzVt3KtGcQq6PXTrRASpcJYLc92LUWxi4V0DstZ2l1fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716918871; c=relaxed/simple;
	bh=X+qAvp+k10bSBui+7XzzqngR+MoWm8T7/IWPURfscpw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=C9k2HIn/LmERpKaZeBA5HOTNJKy84oeJV+fMUdeGQXU43W4J1X5KIUN5r+T2qS8Yk7FiO32w/Z7GrM6USb8TeBHS4+OkD9y6u0zix6QKB4HPrAyUw9oWVtajybeYYLoG9VVgN7EhDsY/mCV4g642WVt9DP5IfF0ICKsq0ZoCZUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7e21af40435so5574939f.0
        for <linux-nfs@vger.kernel.org>; Tue, 28 May 2024 10:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716918868; x=1717523668;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QKERntV2zTsEL7ZO+x9sl5YK70MbdqKOLJq1f+JX/rU=;
        b=clWvateONFMyhzISgc6Nd70+TGL5oWhawuQ/Rh4YGhS4BLTOoheTg7AOQlY8ohk2de
         EBqEusJKwrKKV+lzwG0DPu9+AYPFlF+NPSrpp6SkLKeqTcl1olkbLbyLwH6fv2YwbbyU
         bBvaE77+ZQgUsOfiKbbP76Ql7utHc3/tIMNOQ22taKXuT8KOhfz/I4nB7TZ56tV6NePx
         EIPq82INrBhQV4jc+LZ0ncw0ZgbmxmooZvRCClrd+9CuKYT4NuHRIB2hv3oBqWNi0qzm
         dE67bDR0DGULDC+ya5Tl/fPlc9MrLPw2BIYuJpxoDLjuQeqTI2H7Q7t1FeQYFkNlwnN1
         lR0A==
X-Forwarded-Encrypted: i=1; AJvYcCVcmF2Sk+grhNkg2WzNQGrO83N1+x+Z8YopuSng6LBxXUEvIrKhAL8FUJD8zhMrFydIotmxXJOod+dPVBTtbRSdp2eqOX59YV9V
X-Gm-Message-State: AOJu0YzJ6GI302rgr3IEOjoNpbuT3lwtrPMqSUKZDjp+cZqncigtxF41
	bCWQQttGeEzegF/9eZxLuT8qxipz9fYfToGT7/4ePGqeFnxYBUh3XGiOIGRigV4HklG+DCgknZR
	DdzqwyJNA3SBcuF1/JkXMLcAuKzyUQ6EbrupRKEyA9gLlJP1WceupkKs=
X-Google-Smtp-Source: AGHT+IFXTfVEjKzu/i6zR+lIuwwZ27H0r3XvVuGJdWBRAPqLZuu5OipHiz6h+dWVrjs/d38v0RQRezan560ATrOyaM9OV6fgnLbr
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:60c4:b0:7e2:2f0e:5a65 with SMTP id
 ca18e2360f4ac-7e8c636bf0dmr75471639f.2.1716918868471; Tue, 28 May 2024
 10:54:28 -0700 (PDT)
Date: Tue, 28 May 2024 10:54:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004385ec06198753f8@google.com>
Subject: [syzbot] [nfs?] INFO: task hung in nfsd_nl_listener_set_doit
From: syzbot <syzbot+d1e76d963f757db40f91@syzkaller.appspotmail.com>
To: Dai.Ngo@oracle.com, chuck.lever@oracle.com, jlayton@kernel.org, 
	kolga@netapp.com, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	neilb@suse.de, syzkaller-bugs@googlegroups.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    72ece20127a3 Merge tag 'f2fs-for-6.10.rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=125f397c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6be91306a8917025
dashboard link: https://syzkaller.appspot.com/bug?extid=d1e76d963f757db40f91
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14be4d58980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e0adb12828a5/disk-72ece201.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/08a675560ce7/vmlinux-72ece201.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b7124361f0f7/bzImage-72ece201.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d1e76d963f757db40f91@syzkaller.appspotmail.com

INFO: task syz-executor:6423 blocked for more than 143 seconds.
      Not tainted 6.9.0-syzkaller-10215-g72ece20127a3 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:26544 pid:6423  tgid:6423  ppid:6410   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x4a00 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
 ___sys_sendmsg net/socket.c:2639 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3b90c7cee9
RSP: 002b:00007ffc41a63068 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f3b90dabf80 RCX: 00007f3b90c7cee9
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 00007f3b90cc949e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3b90dabf8c R14: 00007f3b90dabf80 R15: 0000000000000000
 </TASK>
INFO: task syz-executor.1:6455 blocked for more than 143 seconds.
      Not tainted 6.9.0-syzkaller-10215-g72ece20127a3 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:26544 pid:6455  tgid:6455  ppid:6425   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x4a00 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
 ___sys_sendmsg net/socket.c:2639 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f01a5c7cee9
RSP: 002b:00007fff7f6d4b28 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f01a5dabf80 RCX: 00007f01a5c7cee9
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 00007f01a5cc949e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f01a5dabf8c R14: 00007f01a5dabf80 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/1:0/25:
 #0: ffff8880b953e798 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
 #1: ffff8880b9528948 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x441/0x770 kernel/sched/psi.c:988
 #2: ffff8880b9529430 (krc.lock){..-.}-{2:2}, at: kvfree_rcu_bulk+0x26b/0x4e0 kernel/rcu/tree.c:3383
1 lock held by khungtaskd/30:
 #0: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
2 locks held by getty/4842:
 #0: ffff88802f00a0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900031332f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2201
4 locks held by kworker/0:4/5197:
 #0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90003b77d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90003b77d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8f5d3fc8 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
 #3: ffffffff8e3390f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:291 [inline]
 #3: ffffffff8e3390f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x381/0x830 kernel/rcu/tree_exp.h:939
2 locks held by kworker/u8:3/5328:
2 locks held by syz-executor.2/6408:
 #0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
2 locks held by syz-executor/6423:
 #0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
2 locks held by syz-executor.1/6455:
 #0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
2 locks held by syz-executor.4/6482:
 #0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
2 locks held by syz-executor.3/6486:
 #0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
2 locks held by syz-executor.2/6501:
 #0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
2 locks held by syz-executor/6506:
 #0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
2 locks held by syz-executor.1/6523:
 #0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
2 locks held by syz-executor.4/6545:
 #0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
2 locks held by syz-executor.3/6560:
 #0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
2 locks held by syz-executor.2/6584:
 #0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
2 locks held by syz-executor/6589:
 #0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
2 locks held by syz-executor.1/6611:
 #0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
2 locks held by syz-executor.4/6632:
 #0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
2 locks held by syz-executor.3/6647:
 #0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
2 locks held by syz-executor.2/6671:
 #0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
2 locks held by syz-executor/6676:
 #0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}
, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
2 locks held by syz-executor.1/6691:
 #0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
2 locks held by syz-executor.4/6713:
 #0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
2 locks held by syz-executor.3/6727:
 #0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
2 locks held by syz-executor.2/6751:
 #0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
2 locks held by syz-executor/6756:
 #0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
2 locks held by syz-executor.1/6772:
 #0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
2 locks held by syz-executor.4/6793:
 #0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
1 lock held by syz-executor.3/6795:
 #0: ffffffff8f5d3fc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f5d3fc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x842/0x10d0 net/core/rtnetlink.c:6592

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 30 Comm: khungtaskd Not tainted 6.9.0-syzkaller-10215-g72ece20127a3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 6795 Comm: syz-executor.3 Not tainted 6.9.0-syzkaller-10215-g72ece20127a3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:__slab_alloc_node mm/slub.c:3804 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:3988 [inline]
RIP: 0010:__do_kmalloc_node mm/slub.c:4120 [inline]
RIP: 0010:kmalloc_node_track_caller_noprof+0x10d/0x450 mm/slub.c:4141
Code: e4 0f 84 2b 01 00 00 85 c0 0f 85 23 01 00 00 4c 89 7c 24 10 0f 1f 44 00 00 65 48 8b 05 3c e0 14 7e 49 8b 0c 24 48 8b 54 08 08 <48> 8b 2c 08 48 85 ed 0f 84 57 01 00 00 48 8b 7c 08 10 48 85 ff 0f
RSP: 0018:ffffc9000c0068b8 EFLAGS: 00000246
RAX: ffff8880b9500000 RBX: 0000000000000000 RCX: 00000000000426d0
RDX: 000000000005bc31 RSI: 0000000000000008 RDI: ffffffff8e443c60
RBP: 0000000000000000 R08: ffffffff8fac0c6f R09: 1ffffffff1f5818d
R10: dffffc0000000000 R11: fffffbfff1f5818e R12: ffff888015041500
R13: 0000000000000cc0 R14: 00000000ffffffff R15: 0000000000000005
FS:  000055556a2ec480(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5c15af311c CR3: 000000005ebda000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 kvasprintf+0xdf/0x190 lib/kasprintf.c:25
 kobject_set_name_vargs+0x61/0x120 lib/kobject.c:274
 kobject_add_varg lib/kobject.c:368 [inline]
 kobject_init_and_add+0xde/0x190 lib/kobject.c:457
 rx_queue_add_kobject net/core/net-sysfs.c:1105 [inline]
 net_rx_queue_update_kobjects+0x1cf/0x5b0 net/core/net-sysfs.c:1160
 register_queue_kobjects net/core/net-sysfs.c:1895 [inline]
 netdev_register_kobject+0x224/0x320 net/core/net-sysfs.c:2140
 register_netdevice+0x11ff/0x1a10 net/core/dev.c:10374
 veth_newlink+0x628/0xcd0 drivers/net/veth.c:1829
 rtnl_newlink_create net/core/rtnetlink.c:3510 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3730 [inline]
 rtnl_newlink+0x158f/0x20a0 net/core/rtnetlink.c:3743
 rtnetlink_rcv_msg+0x89b/0x10d0 net/core/rtnetlink.c:6595
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 __sys_sendto+0x3a4/0x4f0 net/socket.c:2192
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5c15a7ebdc
Code: 1a 51 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 60 51 02 00 48 8b
RSP: 002b:00007ffd345dd670 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f5c166d4620 RCX: 00007f5c15a7ebdc
RDX: 0000000000000068 RSI: 00007f5c166d4670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffd345dd6c4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f5c166d4670 R15: 0000000000000000
 </TASK>


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

