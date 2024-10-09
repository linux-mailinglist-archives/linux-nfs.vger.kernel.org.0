Return-Path: <linux-nfs+bounces-6987-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E97997564
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 21:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6EC1F2145D
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 19:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BF41A4F0C;
	Wed,  9 Oct 2024 19:06:22 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F180EEDE
	for <linux-nfs@vger.kernel.org>; Wed,  9 Oct 2024 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728500782; cv=none; b=DnU7L2pUQM459LPEfTKBhd90zHr1JloyPb+LdKljkmRajfHY2+Po6RP3DGuRHVt9Gd7sy8Eqb2O8mbvPxVPSG2BZiGKPAZExEnW+qYATdb1LW8EG87MNhfRLNa7xMnnQ30yFoXlimy6gj4uUjPREdm+uDqdRM9tgXtXgIOTH3CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728500782; c=relaxed/simple;
	bh=zIGYQuWfA+qFJ7Xx+1ifikjU4HlY7u50zWt3+EIbEfQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=l6l36ZCp5mlNFbO7x+JqcNv0BSgIiJaj0XDwZPebDx5pgD3eL/FVRqL88DPmVhOI45WaxbzhZUyIyc5U8PYhqARaIrkaG1dOVuWKRAO8dNbx/fILTyGUmFDz6VuJ9VyzCEs0VzTDPMm7soum5pBkLhJbNObXZ7/50ACfL3DQ4DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a342e872a7so2280105ab.3
        for <linux-nfs@vger.kernel.org>; Wed, 09 Oct 2024 12:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728500780; x=1729105580;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m8+1MsHdf8XIh/QfUzj5hG+oyd4uiAdtzfmMugPu7Vk=;
        b=tPNVuN4irwvFTz7grn6aGhJVHTevDsnCYg4bOpN6upHGvBw7p1HQa8XH7XMwuvyqDl
         vf1T1slotiygvwqrLh5czdi/U1BeZaIRatYl5Kw/QfWlID8l0UqDNyOrG07L9mqVJehA
         D4QAxgbq7P9Gedz5GWYD2OIblzEwTuzELl/YQY7wsBAvKXPGufUMMUWka4X/P+myNwX3
         bWGXBQXsMYGjPse2//0GGNybBEOTWgeReg/rYaFH5X85xQF+pMWLeaf6sGUdlEuJkJAY
         84GWFP7lrBGsv8RZBCYwoov0dUyEtKN7OuGkBpzD8JTgyiykCaXee+B/yg6ipobBMca+
         2ZDA==
X-Forwarded-Encrypted: i=1; AJvYcCUt9bemhEyslnHYTB+MbhAyX/MuZfhr+4M0y5u5BOsSJzo3WyIVyNpZJ7YVCRPI3ccYN6UhkkTjBFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBHWTdhqJLfISJFEF6bxdrZZoB4yL2Z2sgBuIX+yGiAloKEdmT
	aAemQv8cudAbrsrGcRaGZzjns9THssPw3gEwEucvLXW7Nsno/BRts0K5rNGAEceK+Xr/Az8u7i3
	RBPN6et9qSx8h44jxgqKknDT6L1R/pstR8saDDaqIOr+jR+oPPB0xHNw=
X-Google-Smtp-Source: AGHT+IFuf3gOZrDMbm9O+d4ikZQfyM76iY7jexxLs1S6UKnh2ueB6OxJrYxhTfHM7lHZLJrp8e5oUjh6mc/BENoaySS1sdDDwDGV
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b02:b0:39f:36f3:1957 with SMTP id
 e9e14a558f8ab-3a397cd8897mr31317115ab.3.1728500780133; Wed, 09 Oct 2024
 12:06:20 -0700 (PDT)
Date: Wed, 09 Oct 2024 12:06:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6706d42c.050a0220.1139e6.000b.GAE@google.com>
Subject: [syzbot] [nfs?] INFO: task hung in nfsd_nl_threads_set_doit
From: syzbot <syzbot+e7baeb70aa00c22ed45e@syzkaller.appspotmail.com>
To: Dai.Ngo@oracle.com, chuck.lever@oracle.com, jlayton@kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, neilb@suse.de, 
	okorniev@redhat.com, syzkaller-bugs@googlegroups.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    75b607fab38d Merge tag 'sched_ext-for-6.12-rc2-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15e49f9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=667b897270c8ae6
dashboard link: https://syzkaller.appspot.com/bug?extid=e7baeb70aa00c22ed45e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a7759a7b0126/disk-75b607fa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/734e9758ae9d/vmlinux-75b607fa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e23bee69aa18/bzImage-75b607fa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e7baeb70aa00c22ed45e@syzkaller.appspotmail.com

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

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc2-syzkaller-00058-g75b607fab38d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xf0c/0x1240 kernel/hung_task.c:379
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 23757 Comm: syz.1.7378 Not tainted 6.12.0-rc2-syzkaller-00058-g75b607fab38d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:kernel_fpu_begin_mask+0x17b/0x270 arch/x86/kernel/fpu/core.c:443
Code: 01 31 ff 89 de e8 45 b6 59 00 85 db 0f 85 ce 00 00 00 e8 f8 b3 59 00 48 b8 00 00 00 00 00 fc ff df 48 c7 44 05 00 00 00 00 00 <48> 8b 44 24 58 65 48 2b 04 25 28 00 00 00 0f 85 c6 00 00 00 48 83
RSP: 0018:ffffc9000ac3f3d8 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc9000ac4d000
RDX: 0000000000040000 RSI: ffffffff813304c8 RDI: 0000000000000005
RBP: 1ffff92001587e7b R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
R13: 0000000000001000 R14: 0000000000001000 R15: ffffc9000ac3f500
FS:  00007faf7f5ea6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbfabe67d60 CR3: 000000002859c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 kernel_fpu_begin arch/x86/include/asm/fpu/api.h:42 [inline]
 _sha256_update arch/x86/crypto/sha256_ssse3_glue.c:73 [inline]
 _sha256_update+0xb7/0x220 arch/x86/crypto/sha256_ssse3_glue.c:58
 ima_calc_file_hash_tfm+0x302/0x3e0 security/integrity/ima/ima_crypto.c:491
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x1ba/0x490 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x8a7/0xa10 security/integrity/ima/ima_api.c:293
 process_measurement+0x1271/0x2370 security/integrity/ima/ima_main.c:372
 ima_file_mmap+0x1b1/0x1d0 security/integrity/ima/ima_main.c:462
 security_mmap_file+0x8bd/0x990 security/security.c:2977
 vm_mmap_pgoff+0xdb/0x360 mm/util.c:584
 ksys_mmap_pgoff+0x1c8/0x5c0 mm/mmap.c:542
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:79 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:79
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faf7e77dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007faf7f5ea038 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007faf7e935f80 RCX: 00007faf7e77dff9
RDX: 00004000000000df RSI: 0000002000000004 RDI: 0000000000000002
RBP: 00007faf7e7f0296 R08: 0000000000000404 R09: 0000300000000000
R10: 0000000000040eb2 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007faf7e935f80 R15: 00007fffb2184568
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

