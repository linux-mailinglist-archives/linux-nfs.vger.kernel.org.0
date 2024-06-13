Return-Path: <linux-nfs+bounces-3790-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D328E907CF1
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 21:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2DFD1C23440
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 19:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EF713A249;
	Thu, 13 Jun 2024 19:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNMSvH7F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A953E13A243;
	Thu, 13 Jun 2024 19:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718308247; cv=none; b=j2+hO88uJNnqaaUGd9veBaEEMG8hxgR1epVvNbLgn7YYoi/dg2bGzfAxfXf2LNOe0n+jIvxeK7nQYCHVMWiD0b9/u/lCBbOV7IBmbc6ScvgUztPJwrZC3vpFj/R0O8AcmunJxic0FGT8mlhQ+uaNzhuPMdYMlg2mdclin48vmqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718308247; c=relaxed/simple;
	bh=INggdnEqk+KSdqHB5NEqSJDjqWWBOvxmtmcJ28YtG1g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mMIGEPQ84i0IXZGzgaq1jdnMbl2u08Sd77TVO4v4qxHXC+C41P2aS7ylTlQs3Ggx2lbk+NyYjIc00IsvACHMtf+kgGaPhk10j0AR7uRYxMJNzBoQh4iIpKxHhBQEGMjk6wTGTEmJrHHQd+Qw2WatJnvEvKzg3vi0WzTqIed/Fkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNMSvH7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDE9C2BBFC;
	Thu, 13 Jun 2024 19:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718308247;
	bh=INggdnEqk+KSdqHB5NEqSJDjqWWBOvxmtmcJ28YtG1g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=CNMSvH7FElVa/4C70/9bA9+LX0pWuS0WiG5ByEn/XI1Gaq723DazLwyII5G6TeQKu
	 MyNQ0GmSCpokkyKv99S/zZWqh5dgK1Tqo1CAiSJO5BC31O5IpAQ19sQgiutYVDk4Ne
	 mbhrhyuce8v573+rHz04UREvTUcm88aJhYD1CH3x7NTrp/jtQRTQJB4H/OidnL1v5u
	 euEsAfyGPxXz7IGYy48zxRmRGGz2e+zndwcInoKLWGJrEu4dPvwhQ33vPStnYTZJ9b
	 +ObMUP/7s7RbrTRdFq3aLi/8NhlXXdooJ7xju2aqa2UvVuw68E0sDZ3+bZ5pt9fOpB
	 XkdZwKBSyx/BA==
Message-ID: <219a70651e2f7ddd335d850dd807e9dde06c9747.camel@kernel.org>
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_nl_rpc_status_get_start
From: Jeff Layton <jlayton@kernel.org>
To: syzbot <syzbot+e9820daec56bcb4c41b5@syzkaller.appspotmail.com>, 
	Dai.Ngo@oracle.com, chuck.lever@oracle.com, kolga@netapp.com, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, neilb@suse.de, 
	syzkaller-bugs@googlegroups.com, tom@talpey.com
Cc: lorenzo@kernel.org
Date: Thu, 13 Jun 2024 15:50:45 -0400
In-Reply-To: <0000000000008a444b061acaa487@google.com>
References: <0000000000008a444b061acaa487@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-13 at 12:38 -0700, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:=C2=A0=C2=A0=C2=A0 2ccbdf43d5e7 Merge tag 'for-linus' of
> git://git.kernel.org..
> git tree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 upstream
> console output:
> https://syzkaller.appspot.com/x/log.txt?x=3D158e5256980000
> kernel config:=C2=A0
> https://syzkaller.appspot.com/x/.config?x=3Dc79815c08cc14227
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=3De9820daec56bcb4c41b5
> compiler:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Debian clang version 15.0.6=
, GNU ld (GNU Binutils for
> Debian) 2.40
>=20
> Unfortunately, I don't have any reproducer for this issue yet.
>=20
> Downloadable assets:
> disk image:
> https://storage.googleapis.com/syzbot-assets/9fb20954c51e/disk-2ccbdf43.r=
aw.xz
> vmlinux:
> https://storage.googleapis.com/syzbot-assets/06d78b3cf960/vmlinux-2ccbdf4=
3.xz
> kernel image:
> https://storage.googleapis.com/syzbot-assets/15e5b0a8df77/bzImage-2ccbdf4=
3.xz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the
> commit:
> Reported-by: syzbot+e9820daec56bcb4c41b5@syzkaller.appspotmail.com
>=20
> INFO: task syz-executor.1:7517 blocked for more than 143 seconds.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Not tainted 6.10.0-rc3-syzkaller-00044-g2c=
cbdf43d5e7 #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> message.
> task:syz-executor.1=C2=A0 state:D stack:23800 pid:7517=C2=A0 tgid:7515=C2=
=A0
> ppid:6054=C2=A0=C2=A0 flags:0x00000006
> Call Trace:
> =C2=A0<TASK>
> =C2=A0context_switch kernel/sched/core.c:5408 [inline]
> =C2=A0__schedule+0x1796/0x49d0 kernel/sched/core.c:6745
> =C2=A0__schedule_loop kernel/sched/core.c:6822 [inline]
> =C2=A0schedule+0x14b/0x320 kernel/sched/core.c:6837
> =C2=A0schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
> =C2=A0__mutex_lock_common kernel/locking/mutex.c:684 [inline]
> =C2=A0__mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
> =C2=A0nfsd_nl_rpc_status_get_start+0x8d/0xe0 fs/nfsd/nfsctl.c:1476
> =C2=A0genl_start+0x4d6/0x6d0 net/netlink/genetlink.c:1005
> =C2=A0__netlink_dump_start+0x45c/0x780 net/netlink/af_netlink.c:2445
> =C2=A0genl_family_rcv_msg_dumpit net/netlink/genetlink.c:1076 [inline]
> =C2=A0genl_family_rcv_msg net/netlink/genetlink.c:1192 [inline]
> =C2=A0genl_rcv_msg+0x88c/0xec0 net/netlink/genetlink.c:1210
> =C2=A0netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
> =C2=A0genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
> =C2=A0netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
> =C2=A0netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
> =C2=A0netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
> =C2=A0sock_sendmsg_nosec net/socket.c:730 [inline]
> =C2=A0__sock_sendmsg+0x221/0x270 net/socket.c:745
> =C2=A0____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
> =C2=A0___sys_sendmsg net/socket.c:2639 [inline]
> =C2=A0__sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
> =C2=A0do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> =C2=A0do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> =C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f182b67cea9
> RSP: 002b:00007f182c48a0c8 EFLAGS: 00000246 ORIG_RAX:
> 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f182b7b3f80 RCX: 00007f182b67cea9
> RDX: 0000000000000000 RSI: 0000000020000180 RDI: 0000000000000003
> RBP: 00007f182b6ebff4 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000000b R14: 00007f182b7b3f80 R15: 00007ffd83adb8d8
> =C2=A0</TASK>
>=20
> Showing all locks held in the system:
> 5 locks held by kworker/u8:1/12:
> =C2=A0#0: ffff888015ed3148 ((wq_completion)netns){+.+.}-{0:0}, at:
> process_one_work kernel/workqueue.c:3206 [inline]
> =C2=A0#0: ffff888015ed3148 ((wq_completion)netns){+.+.}-{0:0}, at:
> process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
> =C2=A0#1: ffffc90000117d00 (net_cleanup_work){+.+.}-{0:0}, at:
> process_one_work kernel/workqueue.c:3207 [inline]
> =C2=A0#1: ffffc90000117d00 (net_cleanup_work){+.+.}-{0:0}, at:
> process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
> =C2=A0#2: ffffffff8f5c8cd0 (pernet_ops_rwsem){++++}-{3:3}, at:
> cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:594
> =C2=A0#3: ffff8880237ed408 (&wg->device_update_lock){+.+.}-{3:3}, at:
> wg_destruct+0x110/0x2e0 drivers/net/wireguard/device.c:249
> =C2=A0#4: ffffffff8e339240 (rcu_state.barrier_mutex){+.+.}-{3:3}, at:
> rcu_barrier+0x4c/0x530 kernel/rcu/tree.c:4448
> 1 lock held by khungtaskd/30:
> =C2=A0#0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at:
> rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
> =C2=A0#0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock
> include/linux/rcupdate.h:781 [inline]
> =C2=A0#0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at:
> debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
> 3 locks held by kworker/u8:4/61:
> =C2=A0#0: ffff8880b953e798 (&rq->__lock){-.-.}-{2:2}, at:
> raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
> =C2=A0#1: ffff8880b9528948 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-
> {0:0}, at: psi_task_switch+0x441/0x770 kernel/sched/psi.c:988
> =C2=A0#2: ffff8880b953e798 (&rq->__lock){-.-.}-{2:2}, at:
> raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
> 3 locks held by kworker/0:2/1156:
> =C2=A0#0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at:
> process_one_work kernel/workqueue.c:3206 [inline]
> =C2=A0#0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at:
> process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
> =C2=A0#1: ffffc90004627d00 ((linkwatch_work).work){+.+.}-{0:0}, at:
> process_one_work kernel/workqueue.c:3207 [inline]
> =C2=A0#1: ffffc90004627d00 ((linkwatch_work).work){+.+.}-{0:0}, at:
> process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
> =C2=A0#2: ffffffff8f5d5508 (rtnl_mutex){+.+.}-{3:3}, at:
> linkwatch_event+0xe/0x60 net/core/link_watch.c:276
> 2 locks held by kworker/u8:9/2839:
> 2 locks held by getty/4842:
> =C2=A0#0: ffff88802b04c0a0 (&tty->ldisc_sem){++++}-{0:0}, at:
> tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
> =C2=A0#1: ffffc90002f162f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at:
> n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2201
> 2 locks held by syz-fuzzer/5088:
> 3 locks held by kworker/0:6/5164:
> =C2=A0#0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at:
> process_one_work kernel/workqueue.c:3206 [inline]
> =C2=A0#0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at:
> process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
> =C2=A0#1: ffffc90004577d00 (free_ipc_work){+.+.}-{0:0}, at:
> process_one_work kernel/workqueue.c:3207 [inline]
> =C2=A0#1: ffffc90004577d00 (free_ipc_work){+.+.}-{0:0}, at:
> process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
> =C2=A0#2: ffffffff8e339378 (rcu_state.exp_mutex){+.+.}-{3:3}, at:
> exp_funnel_lock kernel/rcu/tree_exp.h:291 [inline]
> =C2=A0#2: ffffffff8e339378 (rcu_state.exp_mutex){+.+.}-{3:3}, at:
> synchronize_rcu_expedited+0x381/0x830 kernel/rcu/tree_exp.h:939
> 2 locks held by syz-executor.4/7353:
> =C2=A0#0: ffffffff8f63b9d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> net/netlink/genetlink.c:1218
> =C2=A0#1: ffffffff8e600748 (nfsd_mutex){+.+.}-{3:3}, at:
> nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1966
> 3 locks held by syz-executor.1/7517:
> =C2=A0#0: ffffffff8f63b9d0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> net/netlink/genetlink.c:1218
> =C2=A0#1: ffff888052998678 (nlk_cb_mutex-GENERIC){+.+.}-{3:3}, at:
> __netlink_dump_start+0x119/0x780 net/netlink/af_netlink.c:2418
> =C2=A0#2: ffffffff8e600748 (nfsd_mutex){+.+.}-{3:3}, at:
> nfsd_nl_rpc_status_get_start+0x8d/0xe0 fs/nfsd/nfsctl.c:1476
> 2 locks held by syz-executor.1/10475:
> =C2=A0#0: ffffffff8f5d5508 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock
> net/core/rtnetlink.c:79 [inline]
> =C2=A0#0: ffffffff8f5d5508 (rtnl_mutex){+.+.}-{3:3}, at:
> rtnetlink_rcv_msg+0x842/0x1180 net/core/rtnetlink.c:6632
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
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>=20
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>=20
> If you want to undo deduplication, reply with:
> #syz undup


nfsd_nl_rpc_status_get_dumpit grabs the nfsd_mutex in the ->start
netlink op, and then releases it in the ->done op. Is it possible that
something is causing ->done to not happen after ->start has?

--=20
Jeff Layton <jlayton@kernel.org>

