Return-Path: <linux-nfs+bounces-17113-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CCBCC14FC
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Dec 2025 08:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6FF5D30047DB
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Dec 2025 07:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676B92F12D4;
	Tue, 16 Dec 2025 07:33:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D73C24CEEA
	for <linux-nfs@vger.kernel.org>; Tue, 16 Dec 2025 07:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765870416; cv=none; b=omyxRoIYAqawU3VI0bmE8n1Zzte9QC2mCP7nHafUJTGb/GrtHcNEL9CyRFwGdOeOxEQvnkDF9Ui0kITmradY+e7y/j4CNtSFnaMPzyNOW39YqLPHDfEFAd5g8rkAe1iuJnAYT+K3avDBVfK/nQZiHnVX0NSormG0QQDJm08ix90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765870416; c=relaxed/simple;
	bh=8bk7bf2hJaw94COf4YZ9f9wYZqWFUnz034hEHXDRzkg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=noUGDH858DAwwxMNR0OzeXQwFQybqBQHX6uu0CpRAyvJEifZpPim8Af7Y/PNYwCmJOA00cNRnplLnLpKh95tDwmJ5/Fr3Qq7j6nnbwH1vdh5q0Lhm0dHxQnhaoCyQb/7xkn9Xwpy8EdLhxM2fYbSrQf/k2VvCuF1nJqBXqBISV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-65b153371efso6839626eaf.1
        for <linux-nfs@vger.kernel.org>; Mon, 15 Dec 2025 23:33:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765870412; x=1766475212;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+5Jv4X+Ic1vAvXVC2xfB9bS8e+3vcdn/MZMSSUDhKXI=;
        b=dre8c91kHDkLR3xWs7TmSMybd+JpQf1jKzMgku3IqE7zb08aYANZ9SSMHqzP82pIex
         hftCJKjWd71IoBlGJWVJXIn8cbiAt2cQvItTtRizCnkEXgQkMaawoRNyv+8wDAA9+f0D
         JfmZmaQMPasTp/iEIzbCnFGMWyoN2U/gqByzXa8qn0fZevZwGTcifPiZ6y5v6PXl1TMK
         qwCTv3DXpytwDEulMRQ0Mn+mug15ncyMCHymajFYRbth6jX5/mYG60nHRAcvOvbMMMWT
         cjUxEk5suXfhy/V6ls9UPQjMwgZhXXoBvAp8n1xOWTBrLgsM4OpqsB/7jJdRwpeKr6YA
         wx+g==
X-Forwarded-Encrypted: i=1; AJvYcCVmH3RVa7GfBZOi13rS+f26TGtxACXZQ74elgOupUPMZj7baskNDzdEua0kgs+qpT54RiPXIoqYI/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjnQwesbn+rorsaxBWeUPVbb+M+nu8/7e1KrsQtWocxvbMU4CJ
	65uUANnN8sQ+nDKkzLoS3FqPsRIXrkXezVCULZWW5bp/Ofh4sMPmwRD80tup428uW8UBiSD8sPA
	bQgk1Jcevs841ElewLNeCREo/6GpDm//5Ls9wLhwKzjKqK39qjw9DSqgj4TY=
X-Google-Smtp-Source: AGHT+IGlkX+7GEhz2R8PYm4J5CyExc2fCXu7/fcPuR/xgykDxi2plhahOq2Phuk/OrMWwl7xD/wJmjVQ4XQCFqEq2oA/6ueUHPIJ
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4ed1:b0:65b:5553:8e9b with SMTP id
 006d021491bc7-65b555390bfmr3419018eaf.12.1765870411926; Mon, 15 Dec 2025
 23:33:31 -0800 (PST)
Date: Mon, 15 Dec 2025 23:33:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69410b4b.a70a0220.104cf0.0347.GAE@google.com>
Subject: [syzbot] [nfs?] memory leak in percpu_ref_init
From: syzbot <syzbot+6ee3b889bdeada0a6226@syzkaller.appspotmail.com>
To: Dai.Ngo@oracle.com, chuck.lever@oracle.com, jlayton@kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, neil@brown.name, 
	okorniev@redhat.com, syzkaller-bugs@googlegroups.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d358e5254674 Merge tag 'for-6.19/dm-changes' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=176f561a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a0268003e02068d
dashboard link: https://syzkaller.appspot.com/bug?extid=6ee3b889bdeada0a6226
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a6661a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d4a1b4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e79f317bb571/disk-d358e525.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cf9e2849af10/vmlinux-d358e525.xz
kernel image: https://storage.googleapis.com/syzbot-assets/73d80a967038/bzImage-d358e525.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6ee3b889bdeada0a6226@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object (percpu) 0x607e4d6bd360 (size 8):
  comm "syz.0.17", pid 6093, jiffies 4294942369
  hex dump (first 8 bytes on cpu 0):
    00 00 00 00 00 00 00 00                          ........
  backtrace (crc 0):
    pcpu_alloc_noprof+0x82c/0xd60 mm/percpu.c:1890
    percpu_ref_init+0x36/0x1e0 lib/percpu-refcount.c:72
    nfsd_create_serv+0xbe/0x260 fs/nfsd/nfssvc.c:605
    nfsd_nl_listener_set_doit+0x62/0xb00 fs/nfsd/nfsctl.c:1882
    genl_family_rcv_msg_doit+0x11e/0x190 net/netlink/genetlink.c:1115
    genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
    genl_rcv_msg+0x2fd/0x440 net/netlink/genetlink.c:1210
    netlink_rcv_skb+0x93/0x1d0 net/netlink/af_netlink.c:2550
    genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
    netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
    netlink_unicast+0x3a3/0x4f0 net/netlink/af_netlink.c:1344
    netlink_sendmsg+0x335/0x6b0 net/netlink/af_netlink.c:1894
    sock_sendmsg_nosec net/socket.c:727 [inline]
    __sock_sendmsg net/socket.c:742 [inline]
    ____sys_sendmsg+0x562/0x5a0 net/socket.c:2592
    ___sys_sendmsg+0xc8/0x130 net/socket.c:2646
    __sys_sendmsg+0xc7/0x140 net/socket.c:2678
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88812a39dfc0 (size 64):
  comm "syz.0.17", pid 6093, jiffies 4294942369
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 80 80 59 d7 81 ff ff ff ff  .........Y......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc a2262fc6):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    __kmalloc_cache_noprof+0x3b2/0x570 mm/slub.c:5771
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    percpu_ref_init+0x94/0x1e0 lib/percpu-refcount.c:76
    nfsd_create_serv+0xbe/0x260 fs/nfsd/nfssvc.c:605
    nfsd_nl_listener_set_doit+0x62/0xb00 fs/nfsd/nfsctl.c:1882
    genl_family_rcv_msg_doit+0x11e/0x190 net/netlink/genetlink.c:1115
    genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
    genl_rcv_msg+0x2fd/0x440 net/netlink/genetlink.c:1210
    netlink_rcv_skb+0x93/0x1d0 net/netlink/af_netlink.c:2550
    genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
    netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
    netlink_unicast+0x3a3/0x4f0 net/netlink/af_netlink.c:1344
    netlink_sendmsg+0x335/0x6b0 net/netlink/af_netlink.c:1894
    sock_sendmsg_nosec net/socket.c:727 [inline]
    __sock_sendmsg net/socket.c:742 [inline]
    ____sys_sendmsg+0x562/0x5a0 net/socket.c:2592
    ___sys_sendmsg+0xc8/0x130 net/socket.c:2646
    __sys_sendmsg+0xc7/0x140 net/socket.c:2678
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object (percpu) 0x607e4d6bd368 (size 8):
  comm "syz.0.18", pid 6095, jiffies 4294942370
  hex dump (first 8 bytes on cpu 0):
    00 00 00 00 00 00 00 00                          ........
  backtrace (crc 0):
    pcpu_alloc_noprof+0x82c/0xd60 mm/percpu.c:1890
    percpu_ref_init+0x36/0x1e0 lib/percpu-refcount.c:72
    nfsd_create_serv+0xbe/0x260 fs/nfsd/nfssvc.c:605
    nfsd_nl_listener_set_doit+0x62/0xb00 fs/nfsd/nfsctl.c:1882
    genl_family_rcv_msg_doit+0x11e/0x190 net/netlink/genetlink.c:1115
    genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
    genl_rcv_msg+0x2fd/0x440 net/netlink/genetlink.c:1210
    netlink_rcv_skb+0x93/0x1d0 net/netlink/af_netlink.c:2550
    genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
    netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
    netlink_unicast+0x3a3/0x4f0 net/netlink/af_netlink.c:1344
    netlink_sendmsg+0x335/0x6b0 net/netlink/af_netlink.c:1894
    sock_sendmsg_nosec net/socket.c:727 [inline]
    __sock_sendmsg net/socket.c:742 [inline]
    ____sys_sendmsg+0x562/0x5a0 net/socket.c:2592
    ___sys_sendmsg+0xc8/0x130 net/socket.c:2646
    __sys_sendmsg+0xc7/0x140 net/socket.c:2678
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88812833c840 (size 64):
  comm "syz.0.18", pid 6095, jiffies 4294942370
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 80 80 59 d7 81 ff ff ff ff  .........Y......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc a2262fc6):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    __kmalloc_cache_noprof+0x3b2/0x570 mm/slub.c:5771
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    percpu_ref_init+0x94/0x1e0 lib/percpu-refcount.c:76
    nfsd_create_serv+0xbe/0x260 fs/nfsd/nfssvc.c:605
    nfsd_nl_listener_set_doit+0x62/0xb00 fs/nfsd/nfsctl.c:1882
    genl_family_rcv_msg_doit+0x11e/0x190 net/netlink/genetlink.c:1115
    genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
    genl_rcv_msg+0x2fd/0x440 net/netlink/genetlink.c:1210
    netlink_rcv_skb+0x93/0x1d0 net/netlink/af_netlink.c:2550
    genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
    netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
    netlink_unicast+0x3a3/0x4f0 net/netlink/af_netlink.c:1344
    netlink_sendmsg+0x335/0x6b0 net/netlink/af_netlink.c:1894
    sock_sendmsg_nosec net/socket.c:727 [inline]
    __sock_sendmsg net/socket.c:742 [inline]
    ____sys_sendmsg+0x562/0x5a0 net/socket.c:2592
    ___sys_sendmsg+0xc8/0x130 net/socket.c:2646
    __sys_sendmsg+0xc7/0x140 net/socket.c:2678
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

connection error: failed to recv *flatrpc.ExecutorMessageRawT: read tcp 127.0.0.1:36571->127.0.0.1:45172: read: connection reset by peer


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

