Return-Path: <linux-nfs+bounces-4691-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37892929680
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jul 2024 06:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09B91F21540
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jul 2024 04:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7DE4C9F;
	Sun,  7 Jul 2024 04:37:20 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522F82914
	for <linux-nfs@vger.kernel.org>; Sun,  7 Jul 2024 04:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720327040; cv=none; b=alkRCm7sUgXDWmvbQi8akFyRbusNlxf1KZPC//7iQUwRyPRaTfdh8PXZpEulChy2Z7ST5MytFbyErDuWKwDVg6FZaE1YCcQxhQXwIS4PxjgVGay/Irk/Rz4zi4+20a1644gu6dEMRfNc5dq5P2x6xER/T0+AD0yORobrkldRXr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720327040; c=relaxed/simple;
	bh=yIKuhHGfruoPRqDEvuUTDKJvUOhkTvSw1jACis+h55Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UsvTqkTgOrdb7Dp+/unskfXaKISKF0zV3KbxVXudClpmr0Fdc8leLUavLGuSzeh8ZA/gs+uu5nHaLUA7L8/uwqWIjFh/i486x5zZAIVlJ7jGkGhd+cmiGHxyow9w8TRWuLTleaVLMbsVtuX2QAdLXjJAHLqzEm/BXj42+cfnxLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7fb19ed628aso39248139f.0
        for <linux-nfs@vger.kernel.org>; Sat, 06 Jul 2024 21:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720327037; x=1720931837;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=847Syez982U0hK7vwnP6rn1hKfKGm4NShJJm5zdQrIg=;
        b=MufRrudjxKtp/v3C+Jt8yui1004jCCVsYipwrgOn+nLisDfUY8JhtxpPxJAveEvQN8
         DANbT21p6W5QLBwOrw31LnOpS8DboTzpwy03w29dk3p4OEhKZa0RoNVxTQ7BizANF+OT
         RAhaRrC6jVdv3ulEWDq5xMYofOjQ+xQ/1ZNnQUVO7TuHm4UieIO1ineIyX2kc9y924g8
         t0TTiUlSjXCtH9JeQDdqHwQId3WbngSgtRIhyJv+F4MkfudOca4Rtu++1SzbtjAi+qgo
         bc532o1qtX+wLf4a/Tq//Vg+1t7nKsugwm3vX4oWP6/jSw5mFDOr6annWTglMwirztED
         eDHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNx7y+VmiplXXYRhs9ASPkoqud2jUcUnIgZYy25WCYUj7gCal84pdUVCqvbW3TkHE3Gnq7qALcn8Sg0m/DyKgr2fXq3wgusHFv
X-Gm-Message-State: AOJu0YxRKijQJc77XI5assbAuts/RyqaKJsFaBCKb1HT3bZXouTnfyu4
	e8cHcXh3DnNuEGWHG/zlOUiJnlE5m3hUHiVDPR7hDu+F5RMhsxzTwrO8yTtnQnXDcAKVVvYMjZa
	34PLXaTADG1gpX3HZ/AJHy9GwkR4tWC2AsQ3ssVsWbXdVbIRIp27cmLY=
X-Google-Smtp-Source: AGHT+IHegbxktD4rEG0N60jxzd3v3jWD7RbxaKu3fPtktMJBhV//64hjOub/PwNWMtJerUp5Rnh58EyWd/gg2OKLqURL+fRD43AM
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6182:b0:7f8:c131:3bf5 with SMTP id
 ca18e2360f4ac-7f8c13142c6mr33138039f.2.1720327037574; Sat, 06 Jul 2024
 21:37:17 -0700 (PDT)
Date: Sat, 06 Jul 2024 21:37:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8ed54061ca0d9a5@google.com>
Subject: [syzbot] [nfs?] INFO: task hung in nfsd_umount
From: syzbot <syzbot+b568ba42c85a332a88ee@syzkaller.appspotmail.com>
To: Dai.Ngo@oracle.com, chuck.lever@oracle.com, jlayton@kernel.org, 
	kolga@netapp.com, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	neilb@suse.de, syzkaller-bugs@googlegroups.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1dd28064d416 Merge tag 'integrity-v6.10-fix' of ssh://ra.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16814d76980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ace69f521989b1f
dashboard link: https://syzkaller.appspot.com/bug?extid=b568ba42c85a332a88ee
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/20c723869b92/disk-1dd28064.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c2a9a7382516/vmlinux-1dd28064.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9872fe6f2853/bzImage-1dd28064.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b568ba42c85a332a88ee@syzkaller.appspotmail.com

INFO: task syz.0.2871:13167 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc6-syzkaller-00212-g1dd28064d416 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.2871      state:D stack:26704 pid:13167 tgid:13165 ppid:10304  flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x49d0 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 nfsd_shutdown_threads+0x4e/0xd0 fs/nfsd/nfssvc.c:632
 nfsd_umount+0x43/0xd0 fs/nfsd/nfsctl.c:1412
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 put_fs_context+0x94/0x780 fs/fs_context.c:516
 fscontext_release+0x65/0x80 fs/fsopen.c:73
 __fput+0x24a/0x8a0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x360 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f11fe775bd9
RSP: 002b:00007f11ff494048 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f11fe903f60 RCX: 00007f11fe775bd9
RDX: 0000000000000000 RSI: ffffffffffffffff RDI: 0000000000000003
RBP: 00007f11fe7e4aa1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f11fe903f60 R15: 00007ffc04bba328
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e333f20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e333f20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8e333f20 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
3 locks held by kworker/u8:4/66:
 #0: ffff888015089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff888015089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3329
 #1: ffffc900020afd00 ((work_completion)(&map->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3224 [inline]
 #1: ffffc900020afd00 ((work_completion)(&map->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3329
 #2: ffffffff8e3391c0 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x4c/0x530 kernel/rcu/tree.c:4448
4 locks held by udevd/4534:
 #0: ffff88805a0fdd58 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
 #1: ffff88806542ec88 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154
 #2: ffff88805af532d8 (kn->active#5){++++}-{0:0}, at: kernfs_seq_start+0x72/0x3b0 fs/kernfs/file.c:155
 #3: ffff8880686c90e8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff8880686c90e8 (&dev->mutex){....}-{3:3}, at: uevent_show+0x17d/0x340 drivers/base/core.c:2743
2 locks held by getty/4842:
 #0: ffff88802f9d10a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000312b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2211
3 locks held by kworker/u9:10/5101:
 #0: ffff88802e1fa148 ((wq_completion)hci2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff88802e1fa148 ((wq_completion)hci2){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3329
 #1: ffffc90003827d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3224 [inline]
 #1: ffffc90003827d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3329
 #2: ffff888020eb4d88 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:322
2 locks held by syz.4.2691/12623:
 #0: ffffffff8f63ad70 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e5fff48 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1940
2 locks held by syz.0.2871/13167:
 #0: ffff88804e1920e0 (&type->s_umount_key#77){++++}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff88804e1920e0 (&type->s_umount_key#77){++++}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff88804e1920e0 (&type->s_umount_key#77){++++}-{3:3}, at: deactivate_super+0xb5/0xf0 fs/super.c:505
 #1: ffffffff8e5fff48 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_shutdown_threads+0x4e/0xd0 fs/nfsd/nfssvc.c:632
1 lock held by udevd/14823:
2 locks held by syz-executor/15993:
 #0: ffffffff8f5d4908 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f5d4908 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x842/0x1180 net/core/rtnetlink.c:6632
 #1: ffffffff8e3392f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:323 [inline]
 #1: ffffffff8e3392f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:939
1 lock held by syz.4.3895/16063:
 #0: ffff88804e1920e0 (&type->s_umount_key#77){++++}-{3:3}, at: __super_lock fs/super.c:58 [inline]
 #0: ffff88804e1920e0 (&type->s_umount_key#77){++++}-{3:3}, at: super_lock+0x27c/0x400 fs/super.c:120
4 locks held by kvm-nx-lpage-re/16077:
 #0: ffffffff8e361f28 (cgroup_mutex){+.+.}-{3:3}, at: cgroup_lock include/linux/cgroup.h:368 [inline]
 #0: ffffffff8e361f28 (cgroup_mutex){+.+.}-{3:3}, at: cgroup_attach_task_all+0x27/0xe0 kernel/cgroup/cgroup-v1.c:61
 #1: ffffffff8e1ce5b0 (cpu_hotplug_lock){++++}-{0:0}, at: cgroup_attach_lock+0x11/0x40 kernel/cgroup/cgroup.c:2413
 #2: ffffffff8e362110 (cgroup_threadgroup_rwsem){++++}-{0:0}, at: cgroup_attach_task_all+0x31/0xe0 kernel/cgroup/cgroup-v1.c:62
 #3: ffffffff8e3392f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:291 [inline]
 #3: ffffffff8e3392f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x381/0x830 kernel/rcu/tree_exp.h:939

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 30 Comm: khungtaskd Not tainted 6.10.0-rc6-syzkaller-00212-g1dd28064d416 #0
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
CPU: 0 PID: 1109 Comm: kworker/u8:6 Not tainted 6.10.0-rc6-syzkaller-00212-g1dd28064d416 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: writeback wb_workfn (flush-8:0)
RIP: 0010:bio_add_page+0xb7/0x840 block/bio.c:1118
Code: 05 00 00 8b 5d 00 45 89 f4 41 f7 d4 89 df 44 89 e6 e8 dd 6f 11 fd 44 39 e3 76 0a e8 13 6e 11 fd e9 20 04 00 00 48 89 6c 24 28 <49> 8d 5f 70 48 89 d8 48 c1 e8 03 48 89 44 24 30 42 0f b6 04 28 84
RSP: 0018:ffffc900045ce610 EFLAGS: 00000213
RAX: 0000000000000000 RBX: 000000000000a000 RCX: ffff888022311e00
RDX: ffff888022311e00 RSI: 00000000ffffefff RDI: 000000000000a000
RBP: ffff88802eb37a28 R08: ffffffff8484b8a3 R09: 1ffffd4000090b30
R10: dffffc0000000000 R11: fffff94000090b31 R12: 00000000ffffefff
R13: dffffc0000000000 R14: 0000000000001000 R15: ffff88802eb37a00
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30e11ff8 CR3: 000000000e132000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 bio_add_folio+0x52/0x80 block/bio.c:1160
 io_submit_add_bh fs/ext4/page-io.c:422 [inline]
 ext4_bio_write_folio+0x1691/0x1da0 fs/ext4/page-io.c:560
 mpage_submit_folio+0x1af/0x230 fs/ext4/inode.c:1869
 mpage_process_page_bufs+0x6c9/0x8d0 fs/ext4/inode.c:1982
 mpage_prepare_extent_to_map+0xec7/0x1c80 fs/ext4/inode.c:2490
 ext4_do_writepages+0xc52/0x3d40 fs/ext4/inode.c:2632
 ext4_writepages+0x213/0x3c0 fs/ext4/inode.c:2768
 do_writepages+0x359/0x870 mm/page-writeback.c:2656
 __writeback_single_inode+0x165/0x10b0 fs/fs-writeback.c:1651
 writeback_sb_inodes+0x99c/0x1380 fs/fs-writeback.c:1947
 __writeback_inodes_wb+0x11b/0x260 fs/fs-writeback.c:2018
 wb_writeback+0x495/0xd40 fs/fs-writeback.c:2129
 wb_check_old_data_flush fs/fs-writeback.c:2233 [inline]
 wb_do_writeback fs/fs-writeback.c:2286 [inline]
 wb_workfn+0xba1/0x1090 fs/fs-writeback.c:2314
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
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

