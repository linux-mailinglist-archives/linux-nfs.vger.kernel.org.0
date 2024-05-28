Return-Path: <linux-nfs+bounces-3448-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A838D2310
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2024 20:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D831F24549
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2024 18:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338DF481A5;
	Tue, 28 May 2024 18:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcX/lyOE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF1F1DA4C;
	Tue, 28 May 2024 18:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716919849; cv=none; b=PX7w5FSG4sJgcFBbpWSPpps8zcO59fUH/zZ00dZA6BOujIOvlW5mx1gS+aDuXutXVWkuQCS958v/8eLOt/GtD1TDKZ9qayH/TPx7/ff20+fiY1xDY7Vv2dYiubk31fqGxvb6EgP9Muyi/bsq6LVdUumGt2kvIul2gS2IkO+KFmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716919849; c=relaxed/simple;
	bh=yVFqCIajuEI7Nbg5DBonzrZK0LtpY2t+6Aj09OVAK80=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f00INqjdxlz/+/kXg2dVmxS6AgFbkC+57elS0x7TCFVUtwh38zKImDfcSUO1gaZGIPK/6o8szPajtbAqNvjnBlFf+GFrPSL7q4MMnU46FHP1ihahnmxrtES+Xq9LqNE8BFINzqtsim+tHg1rgIgjnDCyPhSSmN3VsOOw7TCEshU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcX/lyOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17205C3277B;
	Tue, 28 May 2024 18:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716919848;
	bh=yVFqCIajuEI7Nbg5DBonzrZK0LtpY2t+6Aj09OVAK80=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=gcX/lyOEvO8x8K0OmJ4KppdZL9QzjPh+qxdTn6x22JvTUdzJKrdblpWjmWQxEyhzl
	 1fE+ap1Dp/C+38alF60792h8ZLU7BmGGdE3D4/S2eXoLTKFkRbKeH+jBSV4A0E9i9I
	 nXVpoPYSZTqG1fRgtsrcUbis0WGKonNwhevgwQPSzpNj845w5wCA4PLt9j9YYxiqZs
	 EQdZblk1ZOS33y2kMA/w8Gude4nxUuA4uC7t8//JEr4cimqwEkUhF6jp3qkew5WyAt
	 fE5sf+/3pmNKI1koWUDXruC1clsfiJT+TszyKgceMprEHbeE6uXtazb+jaHB0qCbtF
	 hs2mhoHeuUz0Q==
Message-ID: <cc8e29cf9e7a99dad41629eb8c8aeeca3837364c.camel@kernel.org>
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_nl_listener_set_doit
From: Jeff Layton <jlayton@kernel.org>
To: syzbot <syzbot+d1e76d963f757db40f91@syzkaller.appspotmail.com>, 
	Dai.Ngo@oracle.com, chuck.lever@oracle.com, kolga@netapp.com, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, neilb@suse.de, 
	syzkaller-bugs@googlegroups.com, tom@talpey.com
Date: Tue, 28 May 2024 14:10:46 -0400
In-Reply-To: <0000000000004385ec06198753f8@google.com>
References: <0000000000004385ec06198753f8@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-28 at 10:54 -0700, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:=C2=A0=C2=A0=C2=A0 72ece20127a3 Merge tag 'f2fs-for-6.10.rc1'=
 of
> git://git.ke..
> git tree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 upstream
> console output:
> https://syzkaller.appspot.com/x/log.txt?x=3D125f397c980000
> kernel config:=C2=A0
> https://syzkaller.appspot.com/x/.config?x=3D6be91306a8917025
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=3Dd1e76d963f757db40f91
> compiler:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Debian clang version 15.0.6=
, GNU ld (GNU Binutils for
> Debian) 2.40
> syz repro:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> https://syzkaller.appspot.com/x/repro.syz?x=3D14be4d58980000
>=20
> Downloadable assets:
> disk image:
> https://storage.googleapis.com/syzbot-assets/e0adb12828a5/disk-72ece201.r=
aw.xz
> vmlinux:
> https://storage.googleapis.com/syzbot-assets/08a675560ce7/vmlinux-72ece20=
1.xz
> kernel image:
> https://storage.googleapis.com/syzbot-assets/b7124361f0f7/bzImage-72ece20=
1.xz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the
> commit:
> Reported-by: syzbot+d1e76d963f757db40f91@syzkaller.appspotmail.com
>=20
> INFO: task syz-executor:6423 blocked for more than 143 seconds.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Not tainted 6.9.0-syzkaller-10215-g72ece20=
127a3 #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> message.
> task:syz-executor=C2=A0=C2=A0=C2=A0 state:D stack:26544 pid:6423=C2=A0 tg=
id:6423=C2=A0
> ppid:6410=C2=A0=C2=A0 flags:0x00000006
> Call Trace:
> =C2=A0<TASK>
> =C2=A0context_switch kernel/sched/core.c:5408 [inline]
> =C2=A0__schedule+0x1796/0x4a00 kernel/sched/core.c:6745
> =C2=A0__schedule_loop kernel/sched/core.c:6822 [inline]
> =C2=A0schedule+0x14b/0x320 kernel/sched/core.c:6837
> =C2=A0schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
> =C2=A0__mutex_lock_common kernel/locking/mutex.c:684 [inline]
> =C2=A0__mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
> =C2=A0nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966

Looks like this line at the beginning of nfsd_nl_listener_set_doit:

	mutex_lock(&nfsd_mutex);

Which probably means that some other task is squatting on the mutex.

> =C2=A0genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
> =C2=A0genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
> =C2=A0genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
> =C2=A0netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
> =C2=A0genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
> =C2=A0netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
> =C2=A0netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
> =C2=A0netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
> =C2=A0sock_sendmsg_nosec net/socket.c:730 [inline]
> =C2=A0__sock_sendmsg+0x221/0x270 net/socket.c:745
> =C2=A0____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
> =C2=A0___sys_sendmsg net/socket.c:2639 [inline]
> =C2=A0__sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
> =C2=A0do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> =C2=A0do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
> =C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f3b90c7cee9
> RSP: 002b:00007ffc41a63068 EFLAGS: 00000246 ORIG_RAX:
> 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f3b90dabf80 RCX: 00007f3b90c7cee9
> RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000003
> RBP: 00007f3b90cc949e R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f3b90dabf8c R14: 00007f3b90dabf80 R15: 0000000000000000
> =C2=A0</TASK>
> INFO: task syz-executor.1:6455 blocked for more than 143 seconds.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Not tainted 6.9.0-syzkaller-10215-g72ece20=
127a3 #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> message.
> task:syz-executor.1=C2=A0 state:D stack:26544 pid:6455=C2=A0 tgid:6455=C2=
=A0
> ppid:6425=C2=A0=C2=A0 flags:0x00000006
> Call Trace:
> =C2=A0<TASK>
> =C2=A0context_switch kernel/sched/core.c:5408 [inline]
> =C2=A0__schedule+0x1796/0x4a00 kernel/sched/core.c:6745
> =C2=A0__schedule_loop kernel/sched/core.c:6822 [inline]
> =C2=A0schedule+0x14b/0x320 kernel/sched/core.c:6837
> =C2=A0schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
> =C2=A0__mutex_lock_common kernel/locking/mutex.c:684 [inline]
> =C2=A0__mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
> =C2=A0nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
> =C2=A0genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
> =C2=A0genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
> =C2=A0genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
> =C2=A0netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
> =C2=A0genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
> =C2=A0netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
> =C2=A0netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
> =C2=A0netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
> =C2=A0sock_sendmsg_nosec net/socket.c:730 [inline]
> =C2=A0__sock_sendmsg+0x221/0x270 net/socket.c:745
> =C2=A0____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
> =C2=A0___sys_sendmsg net/socket.c:2639 [inline]
> =C2=A0__sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
> =C2=A0do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> =C2=A0do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
> =C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f01a5c7cee9
> RSP: 002b:00007fff7f6d4b28 EFLAGS: 00000246 ORIG_RAX:
> 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f01a5dabf80 RCX: 00007f01a5c7cee9
> RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000003
> RBP: 00007f01a5cc949e R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f01a5dabf8c R14: 00007f01a5dabf80 R15: 0000000000000000
> =C2=A0</TASK>
>=20
> Showing all locks held in the system:
> 3 locks held by kworker/1:0/25:
> =C2=A0#0: ffff8880b953e798 (&rq->__lock){-.-.}-{2:2}, at:
> raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
> =C2=A0#1: ffff8880b9528948 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-
> {0:0}, at: psi_task_switch+0x441/0x770 kernel/sched/psi.c:988
> =C2=A0#2: ffff8880b9529430 (krc.lock){..-.}-{2:2}, at:
> kvfree_rcu_bulk+0x26b/0x4e0 kernel/rcu/tree.c:3383
> 1 lock held by khungtaskd/30:
> =C2=A0#0: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at:
> rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
> =C2=A0#0: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock
> include/linux/rcupdate.h:781 [inline]
> =C2=A0#0: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at:
> debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
> 2 locks held by getty/4842:
> =C2=A0#0: ffff88802f00a0a0 (&tty->ldisc_sem){++++}-{0:0}, at:
> tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
> =C2=A0#1: ffffc900031332f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at:
> n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2201
> 4 locks held by kworker/0:4/5197:
> =C2=A0#0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at:
> process_one_work kernel/workqueue.c:3206 [inline]
> =C2=A0#0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at:
> process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
> =C2=A0#1: ffffc90003b77d00 ((linkwatch_work).work){+.+.}-{0:0}, at:
> process_one_work kernel/workqueue.c:3207 [inline]
> =C2=A0#1: ffffc90003b77d00 ((linkwatch_work).work){+.+.}-{0:0}, at:
> process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
> =C2=A0#2: ffffffff8f5d3fc8 (rtnl_mutex){+.+.}-{3:3}, at:
> linkwatch_event+0xe/0x60 net/core/link_watch.c:276
> =C2=A0#3: ffffffff8e3390f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at:
> exp_funnel_lock kernel/rcu/tree_exp.h:291 [inline]
> =C2=A0#3: ffffffff8e3390f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at:
> synchronize_rcu_expedited+0x381/0x830 kernel/rcu/tree_exp.h:939
> 2 locks held by kworker/u8:3/5328:
> 2 locks held by syz-executor.2/6408:
> =C2=A0#0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> net/netlink/genetlink.c:1218
> =C2=A0#1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at:
> nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966

There are a bunch of these lines that say that this lock is held. I
presume only one actually holds the lock, and the rest are blocked on
it?

Presumably one of these tasks is holding the nfsd_mutex and is stuck in
some fashion (or failed to release the mutex properly or something). It
would be helpful if we knew which task actually holds it, and to see
what its stack looks like. Is there some way to tell from this output?

> 2 locks held by syz-executor/6423:
> =C2=A0#0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> net/netlink/genetlink.c:1218
> =C2=A0#1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at:
> nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
> 2 locks held by syz-executor.1/6455:
> =C2=A0#0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> net/netlink/genetlink.c:1218
> =C2=A0#1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at:
> nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
> 2 locks held by syz-executor.4/6482:
> =C2=A0#0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> net/netlink/genetlink.c:1218
> =C2=A0#1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at:
> nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
> 2 locks held by syz-executor.3/6486:
> =C2=A0#0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> net/netlink/genetlink.c:1218
> =C2=A0#1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at:
> nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
> 2 locks held by syz-executor.2/6501:
> =C2=A0#0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> net/netlink/genetlink.c:1218
> =C2=A0#1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at:
> nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
> 2 locks held by syz-executor/6506:
> =C2=A0#0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> net/netlink/genetlink.c:1218
> =C2=A0#1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at:
> nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
> 2 locks held by syz-executor.1/6523:
> =C2=A0#0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> net/netlink/genetlink.c:1218
> =C2=A0#1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at:
> nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
> 2 locks held by syz-executor.4/6545:
> =C2=A0#0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> net/netlink/genetlink.c:1218
> =C2=A0#1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at:
> nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
> 2 locks held by syz-executor.3/6560:
> =C2=A0#0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> net/netlink/genetlink.c:1218
> =C2=A0#1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at:
> nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
> 2 locks held by syz-executor.2/6584:
> =C2=A0#0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> net/netlink/genetlink.c:1218
> =C2=A0#1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at:
> nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
> 2 locks held by syz-executor/6589:
> =C2=A0#0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> net/netlink/genetlink.c:1218
> =C2=A0#1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at:
> nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
> 2 locks held by syz-executor.1/6611:
> =C2=A0#0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> net/netlink/genetlink.c:1218
> =C2=A0#1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at:
> nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
> 2 locks held by syz-executor.4/6632:
> =C2=A0#0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> net/netlink/genetlink.c:1218
> =C2=A0#1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at:
> nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
> 2 locks held by syz-executor.3/6647:
> =C2=A0#0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> net/netlink/genetlink.c:1218
> =C2=A0#1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at:
> nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
> 2 locks held by syz-executor.2/6671:
> =C2=A0#0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> net/netlink/genetlink.c:1218
> =C2=A0#1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at:
> nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
> 2 locks held by syz-executor/6676:
> =C2=A0#0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> net/netlink/genetlink.c:1218
> =C2=A0#1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}
> , at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
> 2 locks held by syz-executor.1/6691:
> =C2=A0#0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> net/netlink/genetlink.c:1218
> =C2=A0#1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at:
> nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
> 2 locks held by syz-executor.4/6713:
> =C2=A0#0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> net/netlink/genetlink.c:1218
> =C2=A0#1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at:
> nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
> 2 locks held by syz-executor.3/6727:
> =C2=A0#0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> net/netlink/genetlink.c:1218
> =C2=A0#1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at:
> nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
> 2 locks held by syz-executor.2/6751:
> =C2=A0#0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> net/netlink/genetlink.c:1218
> =C2=A0#1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at:
> nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
> 2 locks held by syz-executor/6756:
> =C2=A0#0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> net/netlink/genetlink.c:1218
> =C2=A0#1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at:
> nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
> 2 locks held by syz-executor.1/6772:
> =C2=A0#0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> net/netlink/genetlink.c:1218
> =C2=A0#1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at:
> nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
> 2 locks held by syz-executor.4/6793:
> =C2=A0#0: ffffffff8f63a5d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> net/netlink/genetlink.c:1218
> =C2=A0#1: ffffffff8e600528 (nfsd_mutex){+.+.}-{3:3}, at:
> nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
> 1 lock held by syz-executor.3/6795:
> =C2=A0#0: ffffffff8f5d3fc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock
> net/core/rtnetlink.c:79 [inline]
> =C2=A0#0: ffffffff8f5d3fc8 (rtnl_mutex){+.+.}-{3:3}, at:
> rtnetlink_rcv_msg+0x842/0x10d0 net/core/rtnetlink.c:6592
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> NMI backtrace for cpu 0
> CPU: 0 PID: 30 Comm: khungtaskd Not tainted 6.9.0-syzkaller-10215-
> g72ece20127a3 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 04/02/2024
> Call Trace:
> =C2=A0<TASK>
> =C2=A0__dump_stack lib/dump_stack.c:88 [inline]
> =C2=A0dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
> =C2=A0nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
> =C2=A0nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
> =C2=A0trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
> =C2=A0check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
> =C2=A0watchdog+0xfde/0x1020 kernel/hung_task.c:379
> =C2=A0kthread+0x2f0/0x390 kernel/kthread.c:389
> =C2=A0ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> =C2=A0ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> =C2=A0</TASK>
> Sending NMI from CPU 0 to CPUs 1:
> NMI backtrace for cpu 1
> CPU: 1 PID: 6795 Comm: syz-executor.3 Not tainted 6.9.0-syzkaller-
> 10215-g72ece20127a3 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 04/02/2024
> RIP: 0010:__slab_alloc_node mm/slub.c:3804 [inline]
> RIP: 0010:slab_alloc_node mm/slub.c:3988 [inline]
> RIP: 0010:__do_kmalloc_node mm/slub.c:4120 [inline]
> RIP: 0010:kmalloc_node_track_caller_noprof+0x10d/0x450 mm/slub.c:4141
> Code: e4 0f 84 2b 01 00 00 85 c0 0f 85 23 01 00 00 4c 89 7c 24 10 0f
> 1f 44 00 00 65 48 8b 05 3c e0 14 7e 49 8b 0c 24 48 8b 54 08 08 <48>
> 8b 2c 08 48 85 ed 0f 84 57 01 00 00 48 8b 7c 08 10 48 85 ff 0f
> RSP: 0018:ffffc9000c0068b8 EFLAGS: 00000246
> RAX: ffff8880b9500000 RBX: 0000000000000000 RCX: 00000000000426d0
> RDX: 000000000005bc31 RSI: 0000000000000008 RDI: ffffffff8e443c60
> RBP: 0000000000000000 R08: ffffffff8fac0c6f R09: 1ffffffff1f5818d
> R10: dffffc0000000000 R11: fffffbfff1f5818e R12: ffff888015041500
> R13: 0000000000000cc0 R14: 00000000ffffffff R15: 0000000000000005
> FS:=C2=A0 000055556a2ec480(0000) GS:ffff8880b9500000(0000)
> knlGS:0000000000000000
> CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f5c15af311c CR3: 000000005ebda000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> =C2=A0<NMI>
> =C2=A0</NMI>
> =C2=A0<TASK>
> =C2=A0kvasprintf+0xdf/0x190 lib/kasprintf.c:25
> =C2=A0kobject_set_name_vargs+0x61/0x120 lib/kobject.c:274
> =C2=A0kobject_add_varg lib/kobject.c:368 [inline]
> =C2=A0kobject_init_and_add+0xde/0x190 lib/kobject.c:457
> =C2=A0rx_queue_add_kobject net/core/net-sysfs.c:1105 [inline]
> =C2=A0net_rx_queue_update_kobjects+0x1cf/0x5b0 net/core/net-sysfs.c:1160
> =C2=A0register_queue_kobjects net/core/net-sysfs.c:1895 [inline]
> =C2=A0netdev_register_kobject+0x224/0x320 net/core/net-sysfs.c:2140
> =C2=A0register_netdevice+0x11ff/0x1a10 net/core/dev.c:10374
> =C2=A0veth_newlink+0x628/0xcd0 drivers/net/veth.c:1829
> =C2=A0rtnl_newlink_create net/core/rtnetlink.c:3510 [inline]
> =C2=A0__rtnl_newlink net/core/rtnetlink.c:3730 [inline]
> =C2=A0rtnl_newlink+0x158f/0x20a0 net/core/rtnetlink.c:3743
> =C2=A0rtnetlink_rcv_msg+0x89b/0x10d0 net/core/rtnetlink.c:6595
> =C2=A0netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
> =C2=A0netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
> =C2=A0netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
> =C2=A0netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
> =C2=A0sock_sendmsg_nosec net/socket.c:730 [inline]
> =C2=A0__sock_sendmsg+0x221/0x270 net/socket.c:745
> =C2=A0__sys_sendto+0x3a4/0x4f0 net/socket.c:2192
> =C2=A0__do_sys_sendto net/socket.c:2204 [inline]
> =C2=A0__se_sys_sendto net/socket.c:2200 [inline]
> =C2=A0__x64_sys_sendto+0xde/0x100 net/socket.c:2200
> =C2=A0do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> =C2=A0do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
> =C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f5c15a7ebdc
> Code: 1a 51 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28
> 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48>
> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 60 51 02 00 48 8b
> RSP: 002b:00007ffd345dd670 EFLAGS: 00000293 ORIG_RAX:
> 000000000000002c
> RAX: ffffffffffffffda RBX: 00007f5c166d4620 RCX: 00007f5c15a7ebdc
> RDX: 0000000000000068 RSI: 00007f5c166d4670 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 00007ffd345dd6c4 R09: 000000000000000c
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
> R13: 0000000000000000 R14: 00007f5c166d4670 R15: 0000000000000000
> =C2=A0</TASK>
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ=C2=A0for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status=C2=A0for how to communicate with syzbot.
>=20
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>=20
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before
> testing.
>=20
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>=20
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>=20
> If you want to undo deduplication, reply with:
> #syz undup

--=20
Jeff Layton <jlayton@kernel.org>

