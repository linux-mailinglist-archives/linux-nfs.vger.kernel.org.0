Return-Path: <linux-nfs+bounces-7153-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDCB99D009
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 17:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00411C234BF
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 15:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59371ADFF9;
	Mon, 14 Oct 2024 14:58:31 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E068C1AC8AE
	for <linux-nfs@vger.kernel.org>; Mon, 14 Oct 2024 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917911; cv=none; b=KWHn/w1QSz0uv2NTNXp2mXEkC3Wj5Vj+428oGqljfJPN/O7/kIGGtcsP4t0QV/v1srgcp3IX/BY2ovz1rv5ewDYntj9coce7tI4qQ/JyaVnEP1oc4PrnoGkbzo1FkQ7GLtyhX+oqi9IS6FhWx3trYSQStTofhUlbkKC26REYYOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917911; c=relaxed/simple;
	bh=1wR7YdaWzBIS6u0Cat88ac9y44YTUIqrEdgFxL5/gg0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Pib1P6WOUs7W2QS/ntphz6XONJ0VuFeaz4Q4dVjjFHHpXEGdfvJtjerHsP8axi+52mpttfGHUr/ISyIBTYyM/1yLWMsbYU0828zhRe+mAHS/PjhkzzMYzqyLRUR8qK1qzOsqx3754VAKJMnuaRsN64xVQE2iC+i9f7o/sOb/6JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3b9c5bcd8so15314725ab.2
        for <linux-nfs@vger.kernel.org>; Mon, 14 Oct 2024 07:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728917909; x=1729522709;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wgtJ2x4yj8vTp/yllpKOmU0ZKxEzoY4DU1ac/XOZFQE=;
        b=f4hcCwpgRCarvO7o/99RDlugrzI7JwPI1fpHKcGEVdH3S0PQCkvk3DYskWrawO9SeJ
         OvyLevVN0xg6dGATA/rU0bxTOBCzi+o9LTaTpxNzwybC5vo9wJzovzVrrC64OFSTqZ05
         DyyGGCx1b2RG5uNRq4/d95QryndltZoX91oKNFph7syI8AVzMJaOE1+X3/4I8Fj5zEHA
         eggAsVXW1xVx4eXEwTS5LFf1uwCaUF/7e+cLJmMFoBp0jpi7/NXh/fAw/PNnDILGsTlu
         CejTPJhmfyKCdKHlnZmFti0gOZglOEZQgN4v/DvJpA80GjTIcZqNmhrsNS1PgBtFGrGr
         UIpQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7oHNjfnhoWSJalCKUf0ivYKrixkafjx7IUKDx2sgeWGwlKgBr7HraPtPD+SFt42mKeyuGm3b2cvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/UUsxb9Fo3MyRizhUsldRMB4bS9rJ0ifTi8CJzjS70Ih/St0l
	EWlqfP046IDEe1sL3gL/ozNKjpZ2K62VS85FfwJ6VdfXp0fjs0XxC7iErRLQ3izWk3/1p0OovkP
	35JjHSpMoElECZkoIiMe/U3+/qQSw6bOLGBjb7Cy1nr6HenN6JxLE0jg=
X-Google-Smtp-Source: AGHT+IGhhDnTU50L00P3nzyexwLD+fRWHJDCmc8c8puq1mbo7sDM4/G+CJFyy0SPEQCZRkq+bNgIfjcOE3le0ZdbJWtuyLM0q7P9
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c88:b0:3a3:b1c4:8176 with SMTP id
 e9e14a558f8ab-3a3b5fc417amr93003495ab.24.1728917909015; Mon, 14 Oct 2024
 07:58:29 -0700 (PDT)
Date: Mon, 14 Oct 2024 07:58:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670d3194.050a0220.4cbc0.004c.GAE@google.com>
Subject: [syzbot] [nfs?] WARNING: ODEBUG bug in __cancel_work (2)
From: syzbot <syzbot+3e0cda9a4186a611611b@syzkaller.appspotmail.com>
To: Dai.Ngo@oracle.com, chuck.lever@oracle.com, jlayton@kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, neilb@suse.de, 
	okorniev@redhat.com, syzkaller-bugs@googlegroups.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e32cde8d2bd7 Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13ef139f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1671921cf1ab80dd
dashboard link: https://syzkaller.appspot.com/bug?extid=3e0cda9a4186a611611b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f8f10daca68e/disk-e32cde8d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2149fcb8bea3/vmlinux-e32cde8d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/394448ca45de/bzImage-e32cde8d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3e0cda9a4186a611611b@syzkaller.appspotmail.com

svc: failed to register nfsdv3 RPC service (errno 111).
svc: failed to register nfsaclv3 RPC service (errno 111).
------------[ cut here ]------------
ODEBUG: assert_init not available (active state 0) object: ffffffff9a462b08 object type: timer_list hint: 0x0
WARNING: CPU: 1 PID: 6772 at lib/debugobjects.c:514 debug_print_object+0x1a3/0x2b0 lib/debugobjects.c:514
Modules linked in:
CPU: 1 UID: 0 PID: 6772 Comm: syz.1.278 Not tainted 6.12.0-rc1-syzkaller-00031-ge32cde8d2bd7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:debug_print_object+0x1a3/0x2b0 lib/debugobjects.c:514
Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 54 48 8b 14 dd 60 32 b1 8b 41 56 4c 89 e6 48 c7 c7 c0 25 b1 8b e8 9e 72 c0 fc 90 <0f> 0b 90 90 58 83 05 ed 42 8f 0b 01 48 83 c4 18 5b 5d 41 5c 41 5d
RSP: 0018:ffffc90004277158 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000005 RCX: ffffffff814e2a49
RDX: ffff888026c81e00 RSI: ffffffff814e2a56 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffffffff8bb12ca0
R13: ffffffff8b4f6c60 R14: 0000000000000000 R15: ffffc90004277218
FS:  00007f08550c46c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555559c1808 CR3: 000000007ff7a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 debug_object_assert_init+0x249/0x370 lib/debugobjects.c:910
 debug_timer_assert_init kernel/time/timer.c:846 [inline]
 debug_assert_init kernel/time/timer.c:891 [inline]
 __timer_delete+0x81/0x1c0 kernel/time/timer.c:1413
 del_timer include/linux/timer.h:202 [inline]
 try_to_grab_pending+0x7d/0x850 kernel/workqueue.c:2064
 work_grab_pending kernel/workqueue.c:2157 [inline]
 __cancel_work+0xac/0x370 kernel/workqueue.c:4308
 __cancel_work_sync+0x1d/0x130 kernel/workqueue.c:4325
 nfsd_file_cache_shutdown+0xc8/0x4e0 fs/nfsd/filecache.c:928
 nfsd_shutdown_generic fs/nfsd/nfssvc.c:314 [inline]
 nfsd_shutdown_generic fs/nfsd/nfssvc.c:308 [inline]
 nfsd_startup_net fs/nfsd/nfssvc.c:429 [inline]
 nfsd_svc+0x6a9/0x940 fs/nfsd/nfssvc.c:820
 nfsd_nl_threads_set_doit+0x535/0xbe0 fs/nfsd/nfsctl.c:1722
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
RIP: 0033:0x7f085437dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f08550c4038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f0854535f80 RCX: 00007f085437dff9
RDX: 000000002000c014 RSI: 0000000020000140 RDI: 0000000000000004
RBP: 00007f08543f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f0854535f80 R15: 00007ffe830ff138
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

