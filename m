Return-Path: <linux-nfs+bounces-6075-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E479672FC
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Aug 2024 20:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE22D1F2253E
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Aug 2024 18:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F87513C3DD;
	Sat, 31 Aug 2024 18:22:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6EB14B949
	for <linux-nfs@vger.kernel.org>; Sat, 31 Aug 2024 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725128541; cv=none; b=ofto2aLatUyc8iCtlQt+UgBQwEMMNalW+5UrRgqtrhjuslOjrkFa/2uUeS8anl7v0yb9z+F06VL25zbem0RYTDW2yK49pB+3pxgNFEuA5N8Np8woIKSBuwkEvQCe1241zkS7mHiIJbUm5qIzMHqtWL2TEM/ZZin6332TjERMT28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725128541; c=relaxed/simple;
	bh=aLYhyjW62lzyVyWBQnV+BTWSzyk3bo/ww6OrMnSF1UM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=k1dAfv9fLvzq7XWF5rGJoJbkq8LVkJHYlcGVFoZ4pOo+Vd0DZHNvHhfYlmWP87nFZbAuQi05TJeU0r1i7n1hSqg0jCkWz6hZUi9qv6Z2Ym8WJuJxay8m02ddhzrd0t6/V10AzvXGSk9rr+pLcChDRZnKGromxwi9teQc54obBLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82a3fa4ecd3so38073639f.1
        for <linux-nfs@vger.kernel.org>; Sat, 31 Aug 2024 11:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725128538; x=1725733338;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZ2rI+RJYwA+tRDSFIjoqgx5o9kR6zfIPQ+R8qx1Hbk=;
        b=SCpLAn+jPo0mC8FFDK86smC+0NdUh0QIIyRzZypq+AfIa1Y7RNslv6aLQOOBYqkvfc
         PDuEbna9j4k0s2jtHNiXwwMGsrE8ybUjJSUCihcfhAvCtWfwGgOij/fgEksTyBvG+6aO
         PKKUeQeM6Ms92vKFNt9N2nsSVQ2CAY27UP0Xi3oQSlQRSigzKq5x3IpslWCVNwTF52qI
         5lO+n17cpJXnjTZSVymIb1xfXPtVB7eiEX+hG68VpCF8Uq5qYS3NNuw+SMvROxIth6f6
         hWNpU4tfx4dFIZTyAYdE8CT5dB6MqwMyF70FVj3eo+D0l5cB7ulRwvdsmGZtUnm5n9a4
         q0xw==
X-Forwarded-Encrypted: i=1; AJvYcCWOJKUiOTSbCkZIYgbhkeyhENSOhN6RUApiA6Hp8Mqrso7VEZvlacNsx1tvBgLdX5Hs2rIEamNRgeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBinFgOKHI4Eat/I2iSWiGDmI1FAkwnYZ51ONdZ0i5OxavkolB
	lLks3ZLdBSsZCBZnrxBxS5mGCHV05R14NkFZR76PpLII2u+8g9cl2A7W7+tC5XD+HmzWKXKPYUw
	9x2QWqHkMBvyLAa31i+7APmhLv2kDteDoPZpegVdIJGTWIixVY5tmUus=
X-Google-Smtp-Source: AGHT+IFJY41Tc+o0Eji4GTCPq13AywwWUlPA75MLeUzlObVwl0cMQCZM0B7i7isgXVHZT1JfZUu5srWuel1K0fc8ZaYIT2Pbb2gP
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c4c:b0:397:2946:c83c with SMTP id
 e9e14a558f8ab-39f41094f42mr4686095ab.4.1725128538167; Sat, 31 Aug 2024
 11:22:18 -0700 (PDT)
Date: Sat, 31 Aug 2024 11:22:18 -0700
In-Reply-To: <0000000000004385ec06198753f8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5ba900620fec99b@google.com>
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_nl_listener_set_doit
From: syzbot <syzbot+d1e76d963f757db40f91@syzkaller.appspotmail.com>
To: Dai.Ngo@oracle.com, chuck.lever@oracle.com, dai.ngo@oracle.com, 
	jlayton@kernel.org, kolga@netapp.com, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, lorenzo@kernel.org, neilb@suse.de, 
	netdev@vger.kernel.org, okorniev@redhat.com, syzkaller-bugs@googlegroups.com, 
	tom@talpey.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    fe1910f9337b tcp_bpf: fix return value of tcp_bpf_sendmsg()
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=100e272b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
dashboard link: https://syzkaller.appspot.com/bug?extid=d1e76d963f757db40f91
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113234fb980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11140943980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cb37d16e2860/disk-fe1910f9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/315198aa296e/vmlinux-fe1910f9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b3e6fb9fa8a4/bzImage-fe1910f9.xz

The issue was bisected to:

commit 16a471177496c8e04a9793812c187a2c1a2192fa
Author: Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Tue Apr 23 13:25:44 2024 +0000

    NFSD: add listener-{set,get} netlink command

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16af38d3980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15af38d3980000
console output: https://syzkaller.appspot.com/x/log.txt?x=11af38d3980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d1e76d963f757db40f91@syzkaller.appspotmail.com
Fixes: 16a471177496 ("NFSD: add listener-{set,get} netlink command")

INFO: task syz-executor388:5254 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc5-syzkaller-00151-gfe1910f9337b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor388 state:D stack:23736 pid:5254  tgid:5254  ppid:5252   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1956
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4204435ce9
RSP: 002b:00007ffea2feb278 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4204435ce9
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00000000000000a0 R09: 00000000000000a0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ffea2feb2a0 R15: 00007ffea2feb290
 </TASK>
INFO: task syz-executor388:5258 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc5-syzkaller-00151-gfe1910f9337b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor388 state:D stack:26576 pid:5258  tgid:5258  ppid:5255   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1956
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4204435ce9
RSP: 002b:00007ffea2feb278 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4204435ce9
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00000000000000a0 R09: 00000000000000a0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ffea2feb2a0 R15: 00007ffea2feb290
 </TASK>
INFO: task syz-executor388:5259 blocked for more than 144 seconds.
      Not tainted 6.11.0-rc5-syzkaller-00151-gfe1910f9337b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor388 state:D stack:26576 pid:5259  tgid:5259  ppid:5257   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1956
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4204435ce9
RSP: 002b:00007ffea2feb278 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4204435ce9
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00000000000000a0 R09: 00000000000000a0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ffea2feb2a0 R15: 00007ffea2feb290
 </TASK>
INFO: task syz-executor388:5270 blocked for more than 144 seconds.
      Not tainted 6.11.0-rc5-syzkaller-00151-gfe1910f9337b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor388 state:D stack:26576 pid:5270  tgid:5270  ppid:5253   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1956
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4204435ce9
RSP: 002b:00007ffea2feb278 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4204435ce9
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00000000000000a0 R09: 00000000000000a0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ffea2feb2a0 R15: 00007ffea2feb290
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6626
2 locks held by kworker/u8:5/1073:
4 locks held by klogd/4679:
 #0: ffff8880b893e9d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:560
 #1: ffff8880b8928948 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x441/0x770 kernel/sched/psi.c:989
 #2: ffff88807cdc6418 (&p->pi_lock){-.-.}-{2:2}, at: class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
 #2: ffff88807cdc6418 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0xb0/0x1470 kernel/sched/core.c:4051
 #3: ffff8880b893e9d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:560
2 locks held by getty/4991:
 #0: ffff8880309080a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900031332f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6ac/0x1e00 drivers/tty/n_tty.c:2211
2 locks held by syz-executor388/5254:
 #0: ffffffff8fcf11b0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8ec0b628 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1956
2 locks held by syz-executor388/5258:
 #0: ffffffff8fcf11b0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8ec0b628 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1956
2 locks held by syz-executor388/5259:
 #0: ffffffff8fcf11b0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8ec0b628 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1956
2 locks held by syz-executor388/5261:
 #0: ffffffff8fcf11b0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8ec0b628 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1956
2 locks held by syz-executor388/5270:
 #0: ffffffff8fcf11b0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8ec0b628 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1956

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.11.0-rc5-syzkaller-00151-gfe1910f9337b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 4679 Comm: klogd Not tainted 6.11.0-rc5-syzkaller-00151-gfe1910f9337b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:unwind_next_frame+0x690/0x2a00 arch/x86/kernel/unwind_orc.c:505
Code: 3c 5b 4d 01 ff 49 01 cf 0f 84 82 00 00 00 49 89 ee e8 64 5e 52 00 49 8d 6f 04 49 8d 5f 05 48 89 e8 48 c1 e8 03 42 0f b6 04 28 <84> c0 0f 85 88 1b 00 00 48 89 d8 48 c1 e8 03 42 0f b6 04 28 84 c0
RSP: 0018:ffffc90004187268 EFLAGS: 00000a02
RAX: 0000000000000000 RBX: ffffffff90a9f4f1 RCX: ffff88807c3c8000
RDX: 0000000000000000 RSI: ffffffff81faa2e5 RDI: ffffffff81faa2ea
RBP: ffffffff90a9f4f0 R08: ffffffff81412c60 R09: ffffc90004187430
R10: 0000000000000003 R11: ffffffff817f2f00 R12: ffffffff90310524
R13: dffffc0000000000 R14: 1ffff92000830e68 R15: ffffffff90a9f4ec
FS:  00007fb93ee6f380(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555557e676f8 CR3: 000000007c060000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3988 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 kmem_cache_alloc_node_noprof+0x16b/0x320 mm/slub.c:4080
 __alloc_skb+0x1c3/0x440 net/core/skbuff.c:664
 alloc_skb include/linux/skbuff.h:1320 [inline]
 alloc_skb_with_frags+0xc3/0x770 net/core/skbuff.c:6526
 sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2815
 unix_dgram_sendmsg+0x6d3/0x1f80 net/unix/af_unix.c:2030
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 __sys_sendto+0x3a4/0x4f0 net/socket.c:2204
 __do_sys_sendto net/socket.c:2216 [inline]
 __se_sys_sendto net/socket.c:2212 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2212
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb93efd19b5
Code: 8b 44 24 08 48 83 c4 28 48 98 c3 48 98 c3 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 26 45 31 c9 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 7a 48 8b 15 44 c4 0c 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffecbd3b868 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fb93efd19b5
RDX: 000000000000008b RSI: 000056134a140d80 RDI: 0000000000000003
RBP: 000056134a13c910 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000004000 R11: 0000000000000246 R12: 0000000000000013
R13: 00007fb93f15f212 R14: 00007ffecbd3b968 R15: 0000000000000000
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.486 msecs


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

