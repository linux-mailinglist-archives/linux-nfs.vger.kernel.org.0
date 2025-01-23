Return-Path: <linux-nfs+bounces-9541-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836D6A1A77D
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 17:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEAD416A0D5
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 16:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C0835950;
	Thu, 23 Jan 2025 16:03:37 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D4523CB
	for <linux-nfs@vger.kernel.org>; Thu, 23 Jan 2025 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737648217; cv=none; b=Zf+JgS+aZQ7S84ChMRDwIw8BZpc2B/SzlEKn0cbvaQm04UXiZ2OFy8pWZEl1+Z44WTFaOYEeb1Oc+7jhSY43+K3jVymjn7TUR4Gg6EBo2sv0503LFtfmvpQn3gP1SSwreB5L5y2g+pnB4zD+fG4/dP4jwfh536ZE5fFOshx/edI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737648217; c=relaxed/simple;
	bh=nlqNKlHzsPimr1wcOYgqlr0Ec17XrZBl1QUXfVA/D2g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CWL5MheEb4vhKFQZsfAOvPMbH01R2pPQz4ZkH2JaK0h5m3g58SsOxf6XA/UtAtZ5ToiGGBxaNu+luk/lDk47ITkBZwO15yf1iTA4hnMXSKpvBKsycYJ9mg4vnmGW+mC01vVw9O+wJ6EGQKeFYEwKkciuloQkGlxQl8uGgu7xWIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-844e3943987so66974639f.3
        for <linux-nfs@vger.kernel.org>; Thu, 23 Jan 2025 08:03:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737648214; x=1738253014;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EARnHFlnBGfXqerIzv7/6vOzyy/tHss9otquSvON5Lc=;
        b=i+6HAnE3Wre3Yj/aaIzfAs5j9B0T385K4ctsfI/V5s2lHrZsn/FGwX8XZHOTbK1HF/
         U1p8lyzGV5vyZClsn71h12ndu2eYoOdxYVFE94nP8ywj+EaPEhlcmr/Y7ICxn7/+I7Y+
         3zTEQnR+aceB5bWIxUumk7QmXEIS+dgHtxI+IK6wxCbkyqeo9aD8mGIeY9QD2ZvnzNX0
         G1dHhSNNn0in6gE1YbrKQbHhOhwMpF/3wocpjzljyL7HwNYG4ZazC3fH/56L4KcElbOa
         8UQyTSJPGpHFuTRvV73OdGogF8IWndWSEMG9jCm1l7/z1dw9hcbcKeyK7HlS7Clow4M+
         CnWg==
X-Forwarded-Encrypted: i=1; AJvYcCW2Z8KG2sfE1ynpVRsOXW+lBAtBSRu6Cwir1ER+Sp3M+zdgIwWqOH6PnVOY3tzpHp0kKPBzHDUmiCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk7ZmWt/2kcQ2dTkbMhfc6IJrDIfmGmYo0SULPQ+VgeX9AkFh8
	bG15oYej3qJ8+8IQkunaW6qHZqni8lcyDsiPkobPAK0Bzai7pB0PBx7TZh6gkxxCOCruL1L0WKc
	5isM7YtTU8Xpm4YzvNS0ZYjl+5BFVnLt3+dTFgWzSAzuGPfehQ7OBVJk=
X-Google-Smtp-Source: AGHT+IGcVMW7Vw+26cxLh/QwlQdPCMVSVgPbFeLPn0/1tc849ohoxjwuJAwb0Vq06/olTAsE+rOab44kcG4e2PJ6SJqKKeTVgi49
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190c:b0:3cf:b6ae:913d with SMTP id
 e9e14a558f8ab-3cfb6ae9172mr53971365ab.21.1737648214576; Thu, 23 Jan 2025
 08:03:34 -0800 (PST)
Date: Thu, 23 Jan 2025 08:03:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67926856.050a0220.2eae65.000b.GAE@google.com>
Subject: [syzbot] [nfs?] INFO: task hung in nfsd_nl_version_set_doit
From: syzbot <syzbot+f56732cee5a3c93a262f@syzkaller.appspotmail.com>
To: Dai.Ngo@oracle.com, chuck.lever@oracle.com, jlayton@kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, neilb@suse.de, 
	okorniev@redhat.com, syzkaller-bugs@googlegroups.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9528d418de4d Merge tag 'x86_urgent_for_v6.13' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10938618580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d2d420fd940cbc8
dashboard link: https://syzkaller.appspot.com/bug?extid=f56732cee5a3c93a262f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/78c275cb1f61/disk-9528d418.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/13bf64551a18/vmlinux-9528d418.xz
kernel image: https://storage.googleapis.com/syzbot-assets/08ff578f80f7/bzImage-9528d418.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f56732cee5a3c93a262f@syzkaller.appspotmail.com

INFO: task syz.6.2550:17606 blocked for more than 143 seconds.
      Not tainted 6.13.0-rc7-syzkaller-00209-g9528d418de4d #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.6.2550      state:D stack:27248 pid:17606 tgid:17605 ppid:15038  flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0xe58/0x5ad0 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6848
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6905
 __mutex_lock_common kernel/locking/mutex.c:665 [inline]
 __mutex_lock+0x62b/0xa60 kernel/locking/mutex.c:735
 nfsd_nl_version_set_doit+0xc5/0x7a0 fs/nfsd/nfsctl.c:1813
 genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2542
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg net/socket.c:726 [inline]
 ____sys_sendmsg+0x9ae/0xb40 net/socket.c:2583
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2637
 __sys_sendmsg+0x16e/0x220 net/socket.c:2669
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3b3a785d29
RSP: 002b:00007f3b3b53d038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f3b3a975fa0 RCX: 00007f3b3a785d29
RDX: 0000000000004010 RSI: 00000000200004c0 RDI: 0000000000000008
RBP: 00007f3b3a801b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f3b3a975fa0 R15: 00007ffe55472c78
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8ddbad40 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8ddbad40 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8ddbad40 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6744
4 locks held by kworker/u8:8/3510:
 #0: ffff88801baed948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x12cd/0x1b30 kernel/workqueue.c:3211
 #1: ffffc9000d727d80 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x8bb/0x1b30 kernel/workqueue.c:3212
 #2: ffffffff8faad250 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xbb/0xbd0 net/core/net_namespace.c:602
 #3: ffffffff8ddc6540 (rcu_state.barrier_mutex){+.+.}-{4:4}, at: rcu_barrier+0x48/0x700 kernel/rcu/tree.c:4565
2 locks held by kworker/u8:54/7298:
2 locks held by syz-executor/15509:
 #0: ffff8880351b80e0 (&type->s_umount_key#50){++++}-{4:4}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff8880351b80e0 (&type->s_umount_key#50){++++}-{4:4}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff8880351b80e0 (&type->s_umount_key#50){++++}-{4:4}, at: deactivate_super+0xd6/0x100 fs/super.c:505
 #1: ffffffff8e1bd508 (nfsd_mutex){+.+.}-{4:4}, at: nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:625
2 locks held by syz-executor/17072:
 #0: ffff8880129060e0 (&type->s_umount_key#50){++++}-{4:4}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff8880129060e0 (&type->s_umount_key#50){++++}-{4:4}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff8880129060e0 (&type->s_umount_key#50){++++}-{4:4}, at: deactivate_super+0xd6/0x100 fs/super.c:505
 #1: ffffffff8e1bd508 (nfsd_mutex){+.+.}-{4:4}, at: nfsd_shutdown_threads+0x5b/0xf0 fs/nfsd/nfssvc.c:625
2 locks held by syz.5.2536/17543:
 #0: ffffffff8fb62850 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e1bd508 (nfsd_mutex){+.+.}-{4:4}, at: nfsd_nl_listener_set_doit+0xe3/0x1b40 fs/nfsd/nfsctl.c:1964
2 locks held by syz.6.2550/17606:
 #0: ffffffff8fb62850 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8e1bd508 (nfsd_mutex){+.+.}-{4:4}, at: nfsd_nl_version_set_doit+0xc5/0x7a0 fs/nfsd/nfsctl.c:1813
3 locks held by syz.1.2957/20062:
3 locks held by syz.4.2962/20075:
2 locks held by getty/20109:
 #0: ffff88803564a0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90003e2d2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
2 locks held by syz.0.2983/20256:
 #0: ffffffff8faad250 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x292/0x6c0 net/core/net_namespace.c:512
 #1: ffffffff8ddc6678 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock+0x282/0x3b0 kernel/rcu/tree_exp.h:297
1 lock held by dhcpcd-run-hook/20286:
 #0: ffff8880b873ed18 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:598

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.13.0-rc7-syzkaller-00209-g9528d418de4d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:234 [inline]
 watchdog+0xf14/0x1240 kernel/hung_task.c:397
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 7298 Comm: kworker/u8:54 Not tainted 6.13.0-rc7-syzkaller-00209-g9528d418de4d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:lock_acquire+0x51/0xb0 kernel/locking/lockdep.c:5822
Code: 3c 24 53 e8 61 11 ff ff 48 c7 c0 d4 5c 1d 90 48 ba 00 00 00 00 00 fc ff df 48 89 c1 83 e0 07 48 c1 e9 03 83 c0 03 0f b6 14 11 <59> 38 d0 7c 04 84 d2 75 47 8b 05 24 04 a7 0e 85 c0 74 2a 48 89 5c
RSP: 0018:ffffc90003707888 EFLAGS: 00000202
RAX: 0000000000000007 RBX: ffffffff8a90694f RCX: 1ffffffff203ab9a
RDX: 0000000000000000 RSI: ffffffff8bb19b00 RDI: ffffffff8d837ce0
RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff203a53a
R10: ffffffff901d29d7 R11: 0000000000000004 R12: 0000000000000000
R13: 0000000000000002 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd767e6468 CR3: 0000000034f4e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 rcu_read_lock include/linux/rcupdate.h:849 [inline]
 ieee80211_bss_info_update+0x1d5/0xab0 net/mac80211/scan.c:192
 ieee80211_rx_bss_info net/mac80211/ibss.c:1101 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1580 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x1956/0x3040 net/mac80211/ibss.c:1607
 ieee80211_iface_process_skb net/mac80211/iface.c:1613 [inline]
 ieee80211_iface_work+0xc0b/0xf00 net/mac80211/iface.c:1667
 cfg80211_wiphy_work+0x3de/0x560 net/wireless/core.c:440
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
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

