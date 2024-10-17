Return-Path: <linux-nfs+bounces-7230-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2709A2586
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 16:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0DB81C20C1D
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3001DE4C3;
	Thu, 17 Oct 2024 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCwm1K5w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8681DE2AD
	for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729176606; cv=none; b=D+8B8R8LSLYqYjX/5yP/qzwgHRre7yjFcBU+5e5Sd+IvwT5szYFQqpLhVF+Wj5V/4wxiuibnDsZRHazbWlLOGjgYvxdQ3uH/wDBcbj8UX8R1BhjLqyyGAuueEQeldZko0NEgBqgfc3aXSPk0/ydvCNI5Wb6C27ibZGYeykDjqe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729176606; c=relaxed/simple;
	bh=UnwSehQurdbbeoj+lNzlXqp5q+Eooql0B6kS85qSB6Y=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:Subject; b=uz2UkQjqtyLl/ajSmiDBB6YYM+oktMxeP7LoEjFUfytxVYvDS+TnHDW3hf+PYVud3aShzY63vdON+vBEQHNHLId8380/1OiBlJLMttPmkRia4S8oue240eersJmjRBVY7EmPmebozje/d91tz3SG/gSXBjm9HtNo39+PyMBMQrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCwm1K5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBE9C4CEC3;
	Thu, 17 Oct 2024 14:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729176605;
	bh=UnwSehQurdbbeoj+lNzlXqp5q+Eooql0B6kS85qSB6Y=;
	h=From:Date:To:Subject:From;
	b=OCwm1K5w9fLQUddcxKCBcvCQFNjurYj75jb4r5vpCkWaB1NF6ex9MXyejnqR640tQ
	 X3yAUgdnwOM8zQ5uRY9kPLIQGZh/79cPZ/P26MqiCC6HZLE20h9likDZj1u2cuFG9B
	 G4kbYGraWisN6DhOrL4lq0kbnjKc6gMbLqBPBXjMc7+cV1HhY15p48w2Qga9NKvCvQ
	 KmFTijlJ9RJJPwaEjlXGwFYUsr/+s4EPPCi7LkepGL6LjW+JYtXgtJ332mCbkQaf8g
	 WoTy85yLZRB0FaidTBv+WfbaqjW0KWCQlOmguCAn7aKGhoD8DZ3CqvYfPMvskiETKg
	 r0X54a5DL4/dQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 012BB3809A8A;
	Thu, 17 Oct 2024 14:50:11 +0000 (UTC)
From: Jeff Layton via Bugspray Bot <bugbot@kernel.org>
Date: Thu, 17 Oct 2024 14:50:08 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: trondmy@kernel.org, linux-nfs@vger.kernel.org, cel@kernel.org, 
 anna@kernel.org, jlayton@kernel.org
Message-ID: <20241017-b219396c0-484a6fa6f835@bugzilla.kernel.org>
Subject: task hung in nfsd_nl_threads_set_doit
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Jeff Layton writes via Kernel.org Bugzilla:

We've had a number of reports from syzkaller that show hung tasks with a stack trace similar to this:

INFO: task syz.2.8721:28280 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00058-g75b607fab38d #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.8721      state:D stack:24848 pid:28280 tgid:28278 ppid:21973  flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0xef5/0x5750 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 nfsd_nl_threads_set_doit+0x694/0xbe0 fs/nfsd/nfsctl.c:1671
 genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg net/socket.c:744 [inline]
 ____sys_sendmsg+0x9ae/0xb40 net/socket.c:2602
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2656
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2685
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5c35f7dff9
RSP: 002b:00007f5c36d61038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f5c36136058 RCX: 00007f5c35f7dff9
RDX: 0000000000008004 RSI: 0000000020000140 RDI: 0000000000000004
RBP: 00007f5c35ff0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f5c36136058 R15: 00007ffcc9b7fe28
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/u8:1/12:
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1212/0x1b30 kernel/workqueue.c:3204
 #1: ffffc90000117d80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x8bb/0x1b30 kernel/workqueue.c:3205
1 lock held by khungtaskd/30:
 #0: ffffffff8ddb7800 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8ddb7800 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8ddb7800 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6720
3 locks held by kworker/u8:9/3046:
2 locks held by getty/4992:
 #0: ffff88814ba810a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
1 lock held by syz-executor/5223:
2 locks held by syz-executor/18087:
 #0: ffff888066cea0e0 (&type->s_umount_key#49){++++}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff888066cea0e0 (&type->s_umount_key#49){++++}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff888066cea0e0 (&type->s_umount_key#49){++++}-{3:3}, at: deactivate_super+0xd6/0x100 fs/super.c:505
 #1: ffffffff8e1d1868 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:625
1 lock held by syz.1.7378/23757:
2 locks held by syz.2.8721/28279:
 #0: ffffffff8fb61250 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e1d1868 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0xe3/0x1b40 fs/nfsd/nfsctl.c:1964
2 locks held by syz.2.8721/28280:
 #0: ffffffff8fb61250 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e1d1868 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_threads_set_doit+0x694/0xbe0 fs/nfsd/nfsctl.c:1671
2 locks held by syz-executor/28836:
 #0: ffff8880543960e0 (&type->s_umount_key#49){++++}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff8880543960e0 (&type->s_umount_key#49){++++}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff8880543960e0 (&type->s_umount_key#49){++++}-{3:3}, at: deactivate_super+0xd6/0x100 fs/super.c:505
 #1: ffffffff8e1d1868 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:625
2 locks held by syz.0.8904/29170:
 #0: ffff88807b2260e0 (&type->s_umount_key#49){++++}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff88807b2260e0 (&type->s_umount_key#49){++++}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff88807b2260e0 (&type->s_umount_key#49){++++}-{3:3}, at: deactivate_super+0xd6/0x100 fs/super.c:505
 #1: ffffffff8e1d1868 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:625
2 locks held by syz-executor/29233:
 #0: ffff88807bb580e0 (&type->s_umount_key#49){++++}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff88807bb580e0 (&type->s_umount_key#49){++++}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff88807bb580e0 (&type->s_umount_key#49){++++}-{3:3}, at: deactivate_super+0xd6/0x100 fs/super.c:505
 #1: ffffffff8e1d1868 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:625
2 locks held by syz.2.8947/29381:
 #0: ffffffff8fb61250 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e1d1868 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_threads_set_doit+0x694/0xbe0 fs/nfsd/nfsctl.c:1671
2 locks held by syz-executor/29390:
 #0: ffff88802e63a0e0 (&type->s_umount_key#49){++++}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff88802e63a0e0 (&type->s_umount_key#49){++++}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff88802e63a0e0 (&type->s_umount_key#49){++++}-{3:3}, at: deactivate_super+0xd6/0x100 fs/super.c:505
 #1: ffffffff8e1d1868 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:625
2 locks held by syz-executor/29649:
1 lock held by syz.1.9007/29775:
2 locks held by syz.1.9027/29961:
1 lock held by syz.0.9047/30028:
1 lock held by syz.2.9046/30029:


...the scenario (we think) is that syzkaller is asking the kernel to add a bunch of listener sockets to nfsd, and they are getting stuck and timing out while trying to register with rpcbind.

While we are looking at some potential fixes, we currently consider this to be a low-priority bug since the netlink interfaces require elevated privileges to use, so you can only trigger this if you're already root.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219396#c0
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


