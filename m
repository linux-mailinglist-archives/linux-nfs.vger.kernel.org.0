Return-Path: <linux-nfs+bounces-7231-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F8A9A258D
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 16:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD19E1F26681
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 14:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC8E1DE887;
	Thu, 17 Oct 2024 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAQpdP1L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225131DE4F5;
	Thu, 17 Oct 2024 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729176647; cv=none; b=EIrLUOt9ipOw/Nbe3yp/gASQJ77Bd795rApS9r7GX8QL6MGielEe58NZAXpKvf5KODJYPjwVpcEVyOlACKaEhvIdTFW9UEbkv8r/sxAJN4d6RVDJpiQRWI+6ROxacqd2PrsEVKuYNx9W0GekdYS+gC2KW7bhdkv0ymHrTp1MnwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729176647; c=relaxed/simple;
	bh=HahQSpDe5Dat7kZO8Plgm30P81I/WiaASbyALMl4iiM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J60LHZQgkshjdt6EPdCyJz0nJg+l9vryrtakypdKEHsmoqok93f2pHAadPXBu0Wh1M16pJhoFKvzT8F1E/EqF/+MnQscHEppQfkijLdlxOnp90NT4cCsqr7cOvmlAn9LaQYqqBReV1QI12d2vCOKLdlKcABdCfbxe/qZGL0th9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAQpdP1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE647C4CEC3;
	Thu, 17 Oct 2024 14:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729176646;
	bh=HahQSpDe5Dat7kZO8Plgm30P81I/WiaASbyALMl4iiM=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=TAQpdP1LvV5BlSWIO80+VfmvV8w3v1KZbvP6M65TtogAI9rN63SUYL1I+0voIXnFb
	 4U3zd6XfWFwVMEIAgsll7WliZ38P9eMmVOno9lcwShakdwl4NyYGhVaseEeHKR/9HZ
	 XjOoIkv/bdwk8QR9Fc/HPEIVk8b0+cwUoL0zZFHFjSX0ST7/CVOrjfzOgYbz+4O6PX
	 2xputsGccBM2sbZE5H/2yNGLP5uRJGeh6H9nGte2NME1JMWwMopRU7cZR9A7qi27BB
	 Dx/We1ng8XsbclMAaDRwwJRKyH/viKYZ/q+OS1kh61qw5XrFu9u6wQTtesel1ynw9X
	 SVnsmSwgohV8g==
Message-ID: <ed109c41666a9a4257006431449ff94b342bac24.camel@kernel.org>
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_nl_threads_set_doit
From: Jeff Layton <jlayton@kernel.org>
To: syzbot <syzbot+e7baeb70aa00c22ed45e@syzkaller.appspotmail.com>, 
	Dai.Ngo@oracle.com, chuck.lever@oracle.com, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, neilb@suse.de, okorniev@redhat.com, 
	syzkaller-bugs@googlegroups.com, tom@talpey.com
Date: Thu, 17 Oct 2024 10:50:44 -0400
In-Reply-To: <6706d42c.050a0220.1139e6.000b.GAE@google.com>
References: <6706d42c.050a0220.1139e6.000b.GAE@google.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-09 at 12:06 -0700, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    75b607fab38d Merge tag 'sched_ext-for-6.12-rc2-fixes' of =
g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D15e49f9f98000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D667b897270c8a=
e6
> dashboard link: https://syzkaller.appspot.com/bug?extid=3De7baeb70aa00c22=
ed45e
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
>=20
> Unfortunately, I don't have any reproducer for this issue yet.
>=20
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a7759a7b0126/dis=
k-75b607fa.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/734e9758ae9d/vmlinu=
x-75b607fa.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e23bee69aa18/b=
zImage-75b607fa.xz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+e7baeb70aa00c22ed45e@syzkaller.appspotmail.com
>=20
> INFO: task syz.2.8721:28280 blocked for more than 143 seconds.
>       Not tainted 6.12.0-rc2-syzkaller-00058-g75b607fab38d #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.2.8721      state:D stack:24848 pid:28280 tgid:28278 ppid:21973 =
 flags:0x00000004
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5322 [inline]
>  __schedule+0xef5/0x5750 kernel/sched/core.c:6682
>  __schedule_loop kernel/sched/core.c:6759 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6774
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
>  nfsd_nl_threads_set_doit+0x694/0xbe0 fs/nfsd/nfsctl.c:1671
>  genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
>  genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>  genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
>  netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2550
>  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
>  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>  netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
>  netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
>  sock_sendmsg_nosec net/socket.c:729 [inline]
>  __sock_sendmsg net/socket.c:744 [inline]
>  ____sys_sendmsg+0x9ae/0xb40 net/socket.c:2602
>  ___sys_sendmsg+0x135/0x1e0 net/socket.c:2656
>  __sys_sendmsg+0x117/0x1f0 net/socket.c:2685
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f5c35f7dff9
> RSP: 002b:00007f5c36d61038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f5c36136058 RCX: 00007f5c35f7dff9
> RDX: 0000000000008004 RSI: 0000000020000140 RDI: 0000000000000004
> RBP: 00007f5c35ff0296 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f5c36136058 R15: 00007ffcc9b7fe28
>  </TASK>
>=20
> Showing all locks held in the system:
> 2 locks held by kworker/u8:1/12:
>  #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: pr=
ocess_one_work+0x1212/0x1b30 kernel/workqueue.c:3204
>  #1: ffffc90000117d80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, a=
t: process_one_work+0x8bb/0x1b30 kernel/workqueue.c:3205
> 1 lock held by khungtaskd/30:
>  #0: ffffffff8ddb7800 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire i=
nclude/linux/rcupdate.h:337 [inline]
>  #0: ffffffff8ddb7800 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock incl=
ude/linux/rcupdate.h:849 [inline]
>  #0: ffffffff8ddb7800 (rcu_read_lock){....}-{1:2}, at: debug_show_all_loc=
ks+0x7f/0x390 kernel/locking/lockdep.c:6720
> 3 locks held by kworker/u8:9/3046:
> 2 locks held by getty/4992:
>  #0: ffff88814ba810a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wa=
it+0x24/0x80 drivers/tty/tty_ldisc.c:243
>  #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_r=
ead+0xfba/0x1480 drivers/tty/n_tty.c:2211
> 1 lock held by syz-executor/5223:
> 2 locks held by syz-executor/18087:
>  #0: ffff888066cea0e0 (&type->s_umount_key#49){++++}-{3:3}, at: __super_l=
ock fs/super.c:56 [inline]
>  #0: ffff888066cea0e0 (&type->s_umount_key#49){++++}-{3:3}, at: __super_l=
ock_excl fs/super.c:71 [inline]
>  #0: ffff888066cea0e0 (&type->s_umount_key#49){++++}-{3:3}, at: deactivat=
e_super+0xd6/0x100 fs/super.c:505
>  #1: ffffffff8e1d1868 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_shutdown_threads=
+0x5b/0xf0 fs/nfsd/nfssvc.c:625
> 1 lock held by syz.1.7378/23757:
> 2 locks held by syz.2.8721/28279:
>  #0: ffffffff8fb61250 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/n=
etlink/genetlink.c:1218
>  #1: ffffffff8e1d1868 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_=
doit+0xe3/0x1b40 fs/nfsd/nfsctl.c:1964
> 2 locks held by syz.2.8721/28280:
>  #0: ffffffff8fb61250 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/n=
etlink/genetlink.c:1218
>  #1: ffffffff8e1d1868 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_threads_set_d=
oit+0x694/0xbe0 fs/nfsd/nfsctl.c:1671
> 2 locks held by syz-executor/28836:
>  #0: ffff8880543960e0 (&type->s_umount_key#49){++++}-{3:3}, at: __super_l=
ock fs/super.c:56 [inline]
>  #0: ffff8880543960e0 (&type->s_umount_key#49){++++}-{3:3}, at: __super_l=
ock_excl fs/super.c:71 [inline]
>  #0: ffff8880543960e0 (&type->s_umount_key#49){++++}-{3:3}, at: deactivat=
e_super+0xd6/0x100 fs/super.c:505
>  #1: ffffffff8e1d1868 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_shutdown_threads=
+0x5b/0xf0 fs/nfsd/nfssvc.c:625
> 2 locks held by syz.0.8904/29170:
>  #0: ffff88807b2260e0 (&type->s_umount_key#49){++++}-{3:3}, at: __super_l=
ock fs/super.c:56 [inline]
>  #0: ffff88807b2260e0 (&type->s_umount_key#49){++++}-{3:3}, at: __super_l=
ock_excl fs/super.c:71 [inline]
>  #0: ffff88807b2260e0 (&type->s_umount_key#49){++++}-{3:3}, at: deactivat=
e_super+0xd6/0x100 fs/super.c:505
>  #1: ffffffff8e1d1868 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_shutdown_threads=
+0x5b/0xf0 fs/nfsd/nfssvc.c:625
> 2 locks held by syz-executor/29233:
>  #0: ffff88807bb580e0 (&type->s_umount_key#49){++++}-{3:3}, at: __super_l=
ock fs/super.c:56 [inline]
>  #0: ffff88807bb580e0 (&type->s_umount_key#49){++++}-{3:3}, at: __super_l=
ock_excl fs/super.c:71 [inline]
>  #0: ffff88807bb580e0 (&type->s_umount_key#49){++++}-{3:3}, at: deactivat=
e_super+0xd6/0x100 fs/super.c:505
>  #1: ffffffff8e1d1868 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_shutdown_threads=
+0x5b/0xf0 fs/nfsd/nfssvc.c:625
> 2 locks held by syz.2.8947/29381:
>  #0: ffffffff8fb61250 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/n=
etlink/genetlink.c:1218
>  #1: ffffffff8e1d1868 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_threads_set_d=
oit+0x694/0xbe0 fs/nfsd/nfsctl.c:1671
> 2 locks held by syz-executor/29390:
>  #0: ffff88802e63a0e0 (&type->s_umount_key#49){++++}-{3:3}, at: __super_l=
ock fs/super.c:56 [inline]
>  #0: ffff88802e63a0e0 (&type->s_umount_key#49){++++}-{3:3}, at: __super_l=
ock_excl fs/super.c:71 [inline]
>  #0: ffff88802e63a0e0 (&type->s_umount_key#49){++++}-{3:3}, at: deactivat=
e_super+0xd6/0x100 fs/super.c:505
>  #1: ffffffff8e1d1868 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_shutdown_threads=
+0x5b/0xf0 fs/nfsd/nfssvc.c:625
> 2 locks held by syz-executor/29649:
> 1 lock held by syz.1.9007/29775:
> 2 locks held by syz.1.9027/29961:
> 1 lock held by syz.0.9047/30028:
> 1 lock held by syz.2.9046/30029:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> NMI backtrace for cpu 1
> CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc2-syzkaller-0=
0058-g75b607fab38d #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
>  nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
>  trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
>  watchdog+0xf0c/0x1240 kernel/hung_task.c:379
>  kthread+0x2c1/0x3a0 kernel/kthread.c:389
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0
> CPU: 0 UID: 0 PID: 23757 Comm: syz.1.7378 Not tainted 6.12.0-rc2-syzkalle=
r-00058-g75b607fab38d #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
> RIP: 0010:kernel_fpu_begin_mask+0x17b/0x270 arch/x86/kernel/fpu/core.c:44=
3
> Code: 01 31 ff 89 de e8 45 b6 59 00 85 db 0f 85 ce 00 00 00 e8 f8 b3 59 0=
0 48 b8 00 00 00 00 00 fc ff df 48 c7 44 05 00 00 00 00 00 <48> 8b 44 24 58=
 65 48 2b 04 25 28 00 00 00 0f 85 c6 00 00 00 48 83
> RSP: 0018:ffffc9000ac3f3d8 EFLAGS: 00000246
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc9000ac4d000
> RDX: 0000000000040000 RSI: ffffffff813304c8 RDI: 0000000000000005
> RBP: 1ffff92001587e7b R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
> R13: 0000000000001000 R14: 0000000000001000 R15: ffffc9000ac3f500
> FS:  00007faf7f5ea6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fbfabe67d60 CR3: 000000002859c000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <NMI>
>  </NMI>
>  <TASK>
>  kernel_fpu_begin arch/x86/include/asm/fpu/api.h:42 [inline]
>  _sha256_update arch/x86/crypto/sha256_ssse3_glue.c:73 [inline]
>  _sha256_update+0xb7/0x220 arch/x86/crypto/sha256_ssse3_glue.c:58
>  ima_calc_file_hash_tfm+0x302/0x3e0 security/integrity/ima/ima_crypto.c:4=
91
>  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
>  ima_calc_file_hash+0x1ba/0x490 security/integrity/ima/ima_crypto.c:568
>  ima_collect_measurement+0x8a7/0xa10 security/integrity/ima/ima_api.c:293
>  process_measurement+0x1271/0x2370 security/integrity/ima/ima_main.c:372
>  ima_file_mmap+0x1b1/0x1d0 security/integrity/ima/ima_main.c:462
>  security_mmap_file+0x8bd/0x990 security/security.c:2977
>  vm_mmap_pgoff+0xdb/0x360 mm/util.c:584
>  ksys_mmap_pgoff+0x1c8/0x5c0 mm/mmap.c:542
>  __do_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
>  __se_sys_mmap arch/x86/kernel/sys_x86_64.c:79 [inline]
>  __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:79
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7faf7e77dff9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007faf7f5ea038 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
> RAX: ffffffffffffffda RBX: 00007faf7e935f80 RCX: 00007faf7e77dff9
> RDX: 00004000000000df RSI: 0000002000000004 RDI: 0000000000000002
> RBP: 00007faf7e7f0296 R08: 0000000000000404 R09: 0000300000000000
> R10: 0000000000040eb2 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007faf7e935f80 R15: 00007fffb2184568
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


We've had a number of reports of this. To be clear, we currently
consider these problems to be low-priority since they require abusing
privileged interfaces. Still, I've opened this bug at kernel.org to
track the issue:

    https://bugzilla.kernel.org/show_bug.cgi?id=3D219396

--=20
Jeff Layton <jlayton@kernel.org>

