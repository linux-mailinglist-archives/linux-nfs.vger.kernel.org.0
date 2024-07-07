Return-Path: <linux-nfs+bounces-4693-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1A792977D
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jul 2024 12:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAA8C1F21256
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jul 2024 10:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BB31C694;
	Sun,  7 Jul 2024 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7ZVhrsG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B867D1C68C;
	Sun,  7 Jul 2024 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720349361; cv=none; b=CsQaHLNB80HVcQjmVkTamyLsCsZbPnZ01huVu8uekCLkR7EFsUTuEXX6dxIStG2ZGo37tVKuGhtMQ4OvjvfpXCJcGogjZ0TliyBYx/xE2Mz6m0pcMpbcWAg+3VahlS8Y4TTHkbgUCV+1Qf6bI/Ibk0TxgVgmHBlpfPR+ptAa+Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720349361; c=relaxed/simple;
	bh=PVeeT1vuKAzmmUc8lT97zvSGNvt7Pq7VMHk/PwTN2Vg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PxW8uVD/GP9eD11MT736OpEpowskMDduTsqPGktp/ZqJ/fdD/Ir39wgZHer5RDytdT8UdYLgLYQ12cQSIDdp9EtLk8fZbt4KyaoAkTmBMevhoqqIeSBdZdF9z73SOueQ+Zbu7nYJrnsUyYz2L4WLroQN52HMTZxXRxNGCrfR1P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7ZVhrsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770E9C3277B;
	Sun,  7 Jul 2024 10:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720349361;
	bh=PVeeT1vuKAzmmUc8lT97zvSGNvt7Pq7VMHk/PwTN2Vg=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=b7ZVhrsGSDe2E9rR9Ha7eAhR8S2/rzcyFztgnM01EfqLaggWbaCEuT3PQnRYMvSy2
	 iDyVAK8OReNsfWoUYO0dTfBJbJytdZKgQtP2x8c02nJH/lAvWNfu/CX1ZFJUYCaO88
	 F9hR7YGU8CJslyapmBKhmg6MEy2Q8UcYlWVuLmxkPu5vDPrO+4ehUjNLE4Bx2RGHPb
	 uSs26wTdQUhl9gX0HbCywRGWIfAnCUup3S3U42GkHWleufPZF9jsezAX1GTImts4z/
	 jh8vckR2MYzEieuEglHqT6L0QuaiIIN90jf7+9meHVBiwI82oQvwMUe/nAa++Wa+jx
	 UunaFPIgh0X6Q==
Message-ID: <9825cc5ff85d4a2a4ce1c955f49681bef8d03442.camel@kernel.org>
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_umount
From: Jeff Layton <jlayton@kernel.org>
To: syzbot <syzbot+b568ba42c85a332a88ee@syzkaller.appspotmail.com>, 
	Dai.Ngo@oracle.com, chuck.lever@oracle.com, kolga@netapp.com, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, neilb@suse.de, 
	syzkaller-bugs@googlegroups.com, tom@talpey.com
Date: Sun, 07 Jul 2024 06:49:19 -0400
In-Reply-To: <000000000000f8ed54061ca0d9a5@google.com>
References: <000000000000f8ed54061ca0d9a5@google.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-07-06 at 21:37 -0700, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    1dd28064d416 Merge tag 'integrity-v6.10-fix' of ssh://ra.=
k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D16814d7698000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1ace69f521989=
b1f
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Db568ba42c85a332=
a88ee
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>=20
> Unfortunately, I don't have any reproducer for this issue yet.
>=20
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/20c723869b92/dis=
k-1dd28064.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c2a9a7382516/vmlinu=
x-1dd28064.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9872fe6f2853/b=
zImage-1dd28064.xz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+b568ba42c85a332a88ee@syzkaller.appspotmail.com
>=20
> INFO: task syz.0.2871:13167 blocked for more than 143 seconds.
>       Not tainted 6.10.0-rc6-syzkaller-00212-g1dd28064d416 #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.0.2871      state:D stack:26704 pid:13167 tgid:13165 ppid:10304 =
 flags:0x00000004
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5408 [inline]
>  __schedule+0x1796/0x49d0 kernel/sched/core.c:6745
>  __schedule_loop kernel/sched/core.c:6822 [inline]
>  schedule+0x14b/0x320 kernel/sched/core.c:6837
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
>  nfsd_shutdown_threads+0x4e/0xd0 fs/nfsd/nfssvc.c:632
>  nfsd_umount+0x43/0xd0 fs/nfsd/nfsctl.c:1412
>  deactivate_locked_super+0xc4/0x130 fs/super.c:473
>  put_fs_context+0x94/0x780 fs/fs_context.c:516
>  fscontext_release+0x65/0x80 fs/fsopen.c:73
>  __fput+0x24a/0x8a0 fs/file_table.c:422
>  task_work_run+0x24f/0x310 kernel/task_work.c:180
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0x168/0x360 kernel/entry/common.c:218
>  do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f11fe775bd9
> RSP: 002b:00007f11ff494048 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
> RAX: 0000000000000000 RBX: 00007f11fe903f60 RCX: 00007f11fe775bd9
> RDX: 0000000000000000 RSI: ffffffffffffffff RDI: 0000000000000003
> RBP: 00007f11fe7e4aa1 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000000b R14: 00007f11fe903f60 R15: 00007ffc04bba328
>  </TASK>
>=20
> Showing all locks held in the system:
> 1 lock held by khungtaskd/30:
>  #0: ffffffff8e333f20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire i=
nclude/linux/rcupdate.h:329 [inline]
>  #0: ffffffff8e333f20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock incl=
ude/linux/rcupdate.h:781 [inline]
>  #0: ffffffff8e333f20 (rcu_read_lock){....}-{1:2}, at: debug_show_all_loc=
ks+0x55/0x2a0 kernel/locking/lockdep.c:6614
> 3 locks held by kworker/u8:4/66:
>  #0: ffff888015089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: pr=
ocess_one_work kernel/workqueue.c:3223 [inline]
>  #0: ffff888015089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: pr=
ocess_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3329
>  #1: ffffc900020afd00 ((work_completion)(&map->work)){+.+.}-{0:0}, at: pr=
ocess_one_work kernel/workqueue.c:3224 [inline]
>  #1: ffffc900020afd00 ((work_completion)(&map->work)){+.+.}-{0:0}, at: pr=
ocess_scheduled_works+0x945/0x1830 kernel/workqueue.c:3329
>  #2: ffffffff8e3391c0 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barr=
ier+0x4c/0x530 kernel/rcu/tree.c:4448
> 4 locks held by udevd/4534:
>  #0: ffff88805a0fdd58 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xb7/0xd6=
0 fs/seq_file.c:182
>  #1: ffff88806542ec88 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x=
53/0x3b0 fs/kernfs/file.c:154
>  #2: ffff88805af532d8 (kn->active#5){++++}-{0:0}, at: kernfs_seq_start+0x=
72/0x3b0 fs/kernfs/file.c:155
>  #3: ffff8880686c90e8 (&dev->mutex){....}-{3:3}, at: device_lock include/=
linux/device.h:1009 [inline]
>  #3: ffff8880686c90e8 (&dev->mutex){....}-{3:3}, at: uevent_show+0x17d/0x=
340 drivers/base/core.c:2743
> 2 locks held by getty/4842:
>  #0: ffff88802f9d10a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wa=
it+0x25/0x70 drivers/tty/tty_ldisc.c:243
>  #1: ffffc9000312b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_r=
ead+0x6b5/0x1e10 drivers/tty/n_tty.c:2211
> 3 locks held by kworker/u9:10/5101:
>  #0: ffff88802e1fa148 ((wq_completion)hci2){+.+.}-{0:0}, at: process_one_=
work kernel/workqueue.c:3223 [inline]
>  #0: ffff88802e1fa148 ((wq_completion)hci2){+.+.}-{0:0}, at: process_sche=
duled_works+0x90a/0x1830 kernel/workqueue.c:3329
>  #1: ffffc90003827d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:=
0}, at: process_one_work kernel/workqueue.c:3224 [inline]
>  #1: ffffc90003827d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:=
0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3329
>  #2: ffff888020eb4d88 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_wor=
k+0x1ec/0x400 net/bluetooth/hci_sync.c:322
> 2 locks held by syz.4.2691/12623:
>  #0: ffffffff8f63ad70 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/n=
etlink/genetlink.c:1218
>  #1: ffffffff8e5fff48 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_=
doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1940
> 2 locks held by syz.0.2871/13167:
>  #0: ffff88804e1920e0 (&type->s_umount_key#77){++++}-{3:3}, at: __super_l=
ock fs/super.c:56 [inline]
>  #0: ffff88804e1920e0 (&type->s_umount_key#77){++++}-{3:3}, at: __super_l=
ock_excl fs/super.c:71 [inline]
>  #0: ffff88804e1920e0 (&type->s_umount_key#77){++++}-{3:3}, at: deactivat=
e_super+0xb5/0xf0 fs/super.c:505
>  #1: ffffffff8e5fff48 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_shutdown_threads=
+0x4e/0xd0 fs/nfsd/nfssvc.c:632

Above there are two tasks that are holding/blocked on the nfsd_mutex.
The first is the stuck thread. The second is a task that took it in
nfsd_nl_listener_set_doit. I don't see a way to exit that function
without releasing that mutex, so it seems likely that thread is stuck
too for some reason. Unfortunately, we don't have a stack trace from
that task, so I can't tell what it's doing.


> 1 lock held by udevd/14823:
> 2 locks held by syz-executor/15993:
>  #0: ffffffff8f5d4908 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rt=
netlink.c:79 [inline]
>  #0: ffffffff8f5d4908 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x8=
42/0x1180 net/core/rtnetlink.c:6632
>  #1: ffffffff8e3392f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_l=
ock kernel/rcu/tree_exp.h:323 [inline]
>  #1: ffffffff8e3392f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_=
rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:939
> 1 lock held by syz.4.3895/16063:
>  #0: ffff88804e1920e0 (&type->s_umount_key#77){++++}-{3:3}, at: __super_l=
ock fs/super.c:58 [inline]
>  #0: ffff88804e1920e0 (&type->s_umount_key#77){++++}-{3:3}, at: super_loc=
k+0x27c/0x400 fs/super.c:120
> 4 locks held by kvm-nx-lpage-re/16077:
>  #0: ffffffff8e361f28 (cgroup_mutex){+.+.}-{3:3}, at: cgroup_lock include=
/linux/cgroup.h:368 [inline]
>  #0: ffffffff8e361f28 (cgroup_mutex){+.+.}-{3:3}, at: cgroup_attach_task_=
all+0x27/0xe0 kernel/cgroup/cgroup-v1.c:61
>  #1: ffffffff8e1ce5b0 (cpu_hotplug_lock){++++}-{0:0}, at: cgroup_attach_l=
ock+0x11/0x40 kernel/cgroup/cgroup.c:2413
>  #2: ffffffff8e362110 (cgroup_threadgroup_rwsem){++++}-{0:0}, at: cgroup_=
attach_task_all+0x31/0xe0 kernel/cgroup/cgroup-v1.c:62
>  #3: ffffffff8e3392f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_l=
ock kernel/rcu/tree_exp.h:291 [inline]
>  #3: ffffffff8e3392f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_=
rcu_expedited+0x381/0x830 kernel/rcu/tree_exp.h:939
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> NMI backtrace for cpu 1
> CPU: 1 PID: 30 Comm: khungtaskd Not tainted 6.10.0-rc6-syzkaller-00212-g1=
dd28064d416 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 06/07/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
>  nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
>  trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
>  watchdog+0xfde/0x1020 kernel/hung_task.c:379
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0
> CPU: 0 PID: 1109 Comm: kworker/u8:6 Not tainted 6.10.0-rc6-syzkaller-0021=
2-g1dd28064d416 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 06/07/2024
> Workqueue: writeback wb_workfn (flush-8:0)
> RIP: 0010:bio_add_page+0xb7/0x840 block/bio.c:1118
> Code: 05 00 00 8b 5d 00 45 89 f4 41 f7 d4 89 df 44 89 e6 e8 dd 6f 11 fd 4=
4 39 e3 76 0a e8 13 6e 11 fd e9 20 04 00 00 48 89 6c 24 28 <49> 8d 5f 70 48=
 89 d8 48 c1 e8 03 48 89 44 24 30 42 0f b6 04 28 84
> RSP: 0018:ffffc900045ce610 EFLAGS: 00000213
> RAX: 0000000000000000 RBX: 000000000000a000 RCX: ffff888022311e00
> RDX: ffff888022311e00 RSI: 00000000ffffefff RDI: 000000000000a000
> RBP: ffff88802eb37a28 R08: ffffffff8484b8a3 R09: 1ffffd4000090b30
> R10: dffffc0000000000 R11: fffff94000090b31 R12: 00000000ffffefff
> R13: dffffc0000000000 R14: 0000000000001000 R15: ffff88802eb37a00
> FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b30e11ff8 CR3: 000000000e132000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <NMI>
>  </NMI>
>  <TASK>
>  bio_add_folio+0x52/0x80 block/bio.c:1160
>  io_submit_add_bh fs/ext4/page-io.c:422 [inline]
>  ext4_bio_write_folio+0x1691/0x1da0 fs/ext4/page-io.c:560
>  mpage_submit_folio+0x1af/0x230 fs/ext4/inode.c:1869
>  mpage_process_page_bufs+0x6c9/0x8d0 fs/ext4/inode.c:1982
>  mpage_prepare_extent_to_map+0xec7/0x1c80 fs/ext4/inode.c:2490
>  ext4_do_writepages+0xc52/0x3d40 fs/ext4/inode.c:2632
>  ext4_writepages+0x213/0x3c0 fs/ext4/inode.c:2768
>  do_writepages+0x359/0x870 mm/page-writeback.c:2656
>  __writeback_single_inode+0x165/0x10b0 fs/fs-writeback.c:1651
>  writeback_sb_inodes+0x99c/0x1380 fs/fs-writeback.c:1947
>  __writeback_inodes_wb+0x11b/0x260 fs/fs-writeback.c:2018
>  wb_writeback+0x495/0xd40 fs/fs-writeback.c:2129
>  wb_check_old_data_flush fs/fs-writeback.c:2233 [inline]
>  wb_do_writeback fs/fs-writeback.c:2286 [inline]
>  wb_workfn+0xba1/0x1090 fs/fs-writeback.c:2314
>  process_one_work kernel/workqueue.c:3248 [inline]
>  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
>  worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
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

--=20
Jeff Layton <jlayton@kernel.org>

