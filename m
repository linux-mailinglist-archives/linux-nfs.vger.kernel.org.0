Return-Path: <linux-nfs+bounces-5786-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBA095FDE6
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 02:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0196DB20D77
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 00:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481B91C2E;
	Tue, 27 Aug 2024 00:10:34 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F9638B
	for <linux-nfs@vger.kernel.org>; Tue, 27 Aug 2024 00:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724717434; cv=none; b=uCIY/W1Er1MoHJf6+7HIilJe+mz2DLb4n0lAKFENhMvHaZn8ZbrRsDF8Spej3eMsPbFcSq5P81rKcJjMFMp0f2hrXY8i3HqEkQraX4IImXYemtOkGzLxTnV5NqHdOLB5mfuOyPoXINz6ak56fAPfG8UCfHFW5m2cq1JYnIVtZDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724717434; c=relaxed/simple;
	bh=VYnBTGWjCEsTtLFYst+pn7ckP/JVH7mKpH4gKG58tg8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Of9cNx8x3/vIqxBOsn85DXDFMEmQnf2Aoz3Opbs/IgGBRV4vzcqXGFvvT/DGsePanEGgBlM9B739ppnaFN5l79JpdEhS1uGj7baD3/8/tNdxVKjWc0xK5r657/6XpohoMKpc4OL6mdWi/Ce2E4ckzp2eDj+uPAIa63Qhl3a0uG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d5537a62dso63313395ab.2
        for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2024 17:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724717430; x=1725322230;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6tdLqS2yFoYE917A6sCkO0Q1Y/Y1IZNj2nNKFVSYQpg=;
        b=X2egYpQXY54KtUktESTGtLTyQO9FeBOih8uT59hgT0fgFyicvBHs+74Bt21jvQBn93
         w9gikbkndJfz+mxVoSp9tR0uWue79DRSsxwXETbZ5+WU1NfbgltkX4xOpRtTcHp17D8C
         10vJF41TyHDZoNHkUa7vZUL7H9DQ/fFUt+QXVMsh8ttqphB4XjAqpevJtfbt7u650NYz
         9EMoxZMIUfbn7qN++TUiV6hXvxnDRU9MsSDzw7mTDz/n7Cq7/vfgfL2NoCcNh0V12W22
         cKWj2zUkiKwBPzqi+5mQmNF/W0EMqBDA3eTb5NrR0SLBt7BOOaWePtJEcykmw248Wly9
         VaCw==
X-Forwarded-Encrypted: i=1; AJvYcCWQmUCb70GvVZufXl+N9daxZhTtbKK27yhqJG0btBC4C9ggEHkAhVYK5rxXeI9LEJFnjKL8GOhjY3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6IcSK0fbUA25wh26pV01sfN42imkvyIyya+kJdZl4Blnc0ntT
	1TRiRMl1uRjaxSn6yCWhzAyx6Cv3ANaO0hsfCDjTC1/x3bl90D8Sabb8wyfN6cLO6OrsdNqfJOX
	pfW0eLwOL4WJ2tD5n8rsaWScdnWLzsEZuc/q2bCInVnzItapcJjEgYk8=
X-Google-Smtp-Source: AGHT+IEsJuEyzsuXBZ2U0axEMkBh/sekxphdYX2+CLt5yGAyyerU+Yb4kzRHwQ8oXWE8AITRPzy8ryvuRymFEFn+POAdr4vfEQl7
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc6:b0:380:f12f:30de with SMTP id
 e9e14a558f8ab-39e3c97fee7mr7419905ab.2.1724717430177; Mon, 26 Aug 2024
 17:10:30 -0700 (PDT)
Date: Mon, 26 Aug 2024 17:10:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c3949f06209f1101@google.com>
Subject: [syzbot] [nfs?] BUG: sleeping function called from invalid context in dput
From: syzbot <syzbot+b7d499d78290e9ee5882@syzkaller.appspotmail.com>
To: Dai.Ngo@oracle.com, chuck.lever@oracle.com, jlayton@kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, neilb@suse.de, 
	okorniev@redhat.com, syzkaller-bugs@googlegroups.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6a7917c89f21 Add linux-next specific files for 20240822
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17e90a7b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=897bd7c53a10fcfc
dashboard link: https://syzkaller.appspot.com/bug?extid=b7d499d78290e9ee5882
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/47820545bc51/disk-6a7917c8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e300f3a38860/vmlinux-6a7917c8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9146afef58aa/bzImage-6a7917c8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b7d499d78290e9ee5882@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at fs/dcache.c:844
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 9077, name: syz.3.713
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
6 locks held by syz.3.713/9077:
 #0: ffffffff8fd2ac70 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8ec0f9c8 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1963
 #2: ffffffff8fe82868 (rpcb_create_local_mutex){+.+.}-{3:3}, at: rpcb_create_local+0x15d/0x800 net/sunrpc/rpcb_clnt.c:353
 #3: ffff88801fc03558 (&x->wait#13){-.-.}-{2:2}, at: complete_with_flags kernel/sched/completion.c:20 [inline]
 #3: ffff88801fc03558 (&x->wait#13){-.-.}-{2:2}, at: complete+0x28/0x1c0 kernel/sched/completion.c:47
 #4: ffff88802392a818 (&p->pi_lock){-.-.}-{2:2}, at: class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
 #4: ffff88802392a818 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0xb0/0x1480 kernel/sched/core.c:4150
 #5: ffff8880b903ea58 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0xb0/0x140 kernel/sched/core.c:595
irq event stamp: 2182
hardirqs last  enabled at (2181): [<ffffffff816414a5>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1500 [inline]
hardirqs last  enabled at (2181): [<ffffffff816414a5>] finish_lock_switch kernel/sched/core.c:5065 [inline]
hardirqs last  enabled at (2181): [<ffffffff816414a5>] finish_task_switch+0x1e5/0x870 kernel/sched/core.c:5183
hardirqs last disabled at (2182): [<ffffffff8bbf00a3>] common_interrupt+0x13/0xd0 arch/x86/kernel/irq.c:278
softirqs last  enabled at (2128): [<ffffffff8aca8bc3>] xs_local_finish_connecting net/sunrpc/xprtsock.c:1978 [inline]
softirqs last  enabled at (2128): [<ffffffff8aca8bc3>] xs_local_setup_socket net/sunrpc/xprtsock.c:2016 [inline]
softirqs last  enabled at (2128): [<ffffffff8aca8bc3>] xs_local_connect+0x633/0x8e0 net/sunrpc/xprtsock.c:2070
softirqs last disabled at (2126): [<ffffffff89831ad0>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (2126): [<ffffffff89831ad0>] release_sock+0x30/0x1f0 net/core/sock.c:3556
Preemption disabled at:
[<ffffffff8bc75d51>] preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6880
CPU: 0 UID: 0 PID: 9077 Comm: syz.3.713 Not tainted 6.11.0-rc4-next-20240822-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 __might_resched+0x5d4/0x780 kernel/sched/core.c:8629
 dput+0x26/0x2b0 fs/dcache.c:844
 path_put fs/namei.c:568 [inline]
 terminate_walk+0x189/0x430 fs/namei.c:692
 path_lookupat+0x328/0x450 fs/namei.c:2597
 filename_lookup+0x256/0x610 fs/namei.c:2609
 kern_path+0x35/0x50 fs/namei.c:2717
 unix_find_bsd net/unix/af_unix.c:1124 [inline]
 unix_find_other+0x123/0x910 net/unix/af_unix.c:1185
 unix_stream_connect+0x3ba/0x10e0 net/unix/af_unix.c:1587
 kernel_connect+0x10b/0x160 net/socket.c:3642
 xs_local_finish_connecting net/sunrpc/xprtsock.c:1983 [inline]
 xs_local_setup_socket net/sunrpc/xprtsock.c:2016 [inline]
 xs_local_connect+0x6f0/0x8e0 net/sunrpc/xprtsock.c:2070
 xprt_connect+0x63f/0x880 net/sunrpc/xprt.c:948
 __rpc_execute+0x51f/0x1460 net/sunrpc/sched.c:949
 rpc_execute+0x1ec/0x3f0 net/sunrpc/sched.c:1025
 rpc_run_task+0x562/0x6c0 net/sunrpc/clnt.c:1250
 rpc_call_null_helper net/sunrpc/clnt.c:2873 [inline]
 rpc_ping net/sunrpc/clnt.c:2890 [inline]
 rpc_create_xprt+0x534/0xa10 net/sunrpc/clnt.c:492
 rpc_create+0x815/0xb10 net/sunrpc/clnt.c:621
 rpcb_create_af_local+0x2f9/0x520 net/sunrpc/rpcb_clnt.c:258
 rpcb_create_local_unix net/sunrpc/rpcb_clnt.c:291 [inline]
 rpcb_create_local+0x263/0x800 net/sunrpc/rpcb_clnt.c:358
 svc_rpcb_setup net/sunrpc/svc.c:425 [inline]
 svc_bind+0x187/0x1e0 net/sunrpc/svc.c:462
 nfsd_create_serv+0x631/0xae0 fs/nfsd/nfssvc.c:607
 nfsd_nl_listener_set_doit+0x135/0x1a90 fs/nfsd/nfsctl.c:1965
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
 __sys_sendmsg+0x298/0x390 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8bbd379e79
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8bbe0d7038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f8bbd516058 RCX: 00007f8bbd379e79
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000004
RBP: 00007f8bbd3e7916 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f8bbd516058 R15: 00007ffd232873a8
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 9077 at kernel/softirq.c:362 __local_bh_enable_ip+0x1be/0x200 kernel/softirq.c:362
Modules linked in:
CPU: 0 UID: 0 PID: 9077 Comm: syz.3.713 Tainted: G        W          6.11.0-rc4-next-20240822-syzkaller #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:__local_bh_enable_ip+0x1be/0x200 kernel/softirq.c:362
Code: 3b 44 24 60 75 52 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 90 0f 0b 90 e9 ca fe ff ff e8 55 00 00 00 eb 9c 90 <0f> 0b 90 e9 fa fe ff ff 48 c7 c1 4c 43 1c 90 80 e1 07 80 c1 03 38
RSP: 0018:ffffc900041be220 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 1ffff92000837c48 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000201 RDI: ffffffff8a5b29a8
RBP: ffffc900041be2d0 R08: ffffffff901c12ef R09: 1ffffffff203825d
R10: dffffc0000000000 R11: fffffbfff203825e R12: dffffc0000000000
R13: ffff88807da93800 R14: ffffc900041be260 R15: 0000000000000201
FS:  00007f8bbe0d76c0(0000) GS:ffff8880b9000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f69e04e52d8 CR3: 00000000686c0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 sock_orphan include/net/sock.h:2003 [inline]
 unix_release_sock+0x4b8/0xd00 net/unix/af_unix.c:682
 unix_stream_connect+0x94d/0x10e0 net/unix/af_unix.c:1710
 kernel_connect+0x10b/0x160 net/socket.c:3642
 xs_local_finish_connecting net/sunrpc/xprtsock.c:1983 [inline]
 xs_local_setup_socket net/sunrpc/xprtsock.c:2016 [inline]
 xs_local_connect+0x6f0/0x8e0 net/sunrpc/xprtsock.c:2070
 xprt_connect+0x63f/0x880 net/sunrpc/xprt.c:948
 __rpc_execute+0x51f/0x1460 net/sunrpc/sched.c:949
 rpc_execute+0x1ec/0x3f0 net/sunrpc/sched.c:1025
 rpc_run_task+0x562/0x6c0 net/sunrpc/clnt.c:1250
 rpc_call_null_helper net/sunrpc/clnt.c:2873 [inline]
 rpc_ping net/sunrpc/clnt.c:2890 [inline]
 rpc_create_xprt+0x534/0xa10 net/sunrpc/clnt.c:492
 rpc_create+0x815/0xb10 net/sunrpc/clnt.c:621
 rpcb_create_af_local+0x2f9/0x520 net/sunrpc/rpcb_clnt.c:258
 rpcb_create_local_unix net/sunrpc/rpcb_clnt.c:291 [inline]
 rpcb_create_local+0x263/0x800 net/sunrpc/rpcb_clnt.c:358
 svc_rpcb_setup net/sunrpc/svc.c:425 [inline]
 svc_bind+0x187/0x1e0 net/sunrpc/svc.c:462
 nfsd_create_serv+0x631/0xae0 fs/nfsd/nfssvc.c:607
 nfsd_nl_listener_set_doit+0x135/0x1a90 fs/nfsd/nfsctl.c:1965
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
 __sys_sendmsg+0x298/0x390 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8bbd379e79
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8bbe0d7038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f8bbd516058 RCX: 00007f8bbd379e79
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000004
RBP: 00007f8bbd3e7916 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f8bbd516058 R15: 00007ffd232873a8
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

