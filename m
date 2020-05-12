Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A921CED5F
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 08:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgELGzR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 02:55:17 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:45284 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgELGzR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 02:55:17 -0400
Received: by mail-io1-f72.google.com with SMTP id y6so5886851iol.12
        for <linux-nfs@vger.kernel.org>; Mon, 11 May 2020 23:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nYuxikRQd1y8JjIoZo7imSaZgwUVBRsszkZdjA7ikeA=;
        b=sKUjSZBnylVSV13ljjqMcIaZL4CUcYpb11ZZemoH0BLq40SRvXiuQHangqxftWgsvZ
         9gPvwmlEzN5D5RCf/qsAbkjPVwrCCefoKD9A4FpVAevdG4RY4lTRynNRXJFJ6nErPY2h
         6frG8KV+yWLdWH6+l/PBy88VL2m7TF1ZxudgqnBx1pdSqMZTNFzrcaTWOdX+jggS6BHj
         mmMxmVvkLsOE1VEsLHAjvs7Qly6FefmpFu8Okgus8CET3UJWMPrUb0KfKHklgn1lYsqk
         QUQvY+l2Ay7XaN10JPupXnnZ19uat+XMkPuwZ4vbtm0nN83GdU60GFJY/ocile0BqiDB
         +0Xg==
X-Gm-Message-State: AGi0PuYypdPTJ+/7VNoRRcyMdUkGgGCttchhTbM9qs7D7ZeskUxeWZx3
        gZDTDwmfQ0AULWwg+y/5OSn7v/kekcFM2DvQ79kwiz14sg0O
X-Google-Smtp-Source: APiQypJTfjl8Mevb0+zyALKxqVwVDOoXBPw6Xzhz5l0uVnLgmpdB6UQxigcW76BTbcAmcXQnzr5NoJqJxwVI8QHzZgBDc31kCc7p
MIME-Version: 1.0
X-Received: by 2002:a02:c6c5:: with SMTP id r5mr15913250jan.133.1589266516187;
 Mon, 11 May 2020 23:55:16 -0700 (PDT)
Date:   Mon, 11 May 2020 23:55:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026a06e05a56df22f@google.com>
Subject: general protection fault in nfsd_reply_cache_free_locked
From:   syzbot <syzbot+a29df412692980277f9d@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, chuck.lever@oracle.com,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6e7f2eac Merge tag 'arm64-fixes' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14567034100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b0212dbee046bc1f
dashboard link: https://syzkaller.appspot.com/bug?extid=a29df412692980277f9d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a29df412692980277f9d@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 0 PID: 27932 Comm: kworker/u4:4 Not tainted 5.7.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: netns cleanup_net
RIP: 0010:nfsd_reply_cache_free_locked+0x2d/0x380 fs/nfsd/nfscache.c:122
Code: 56 41 55 41 54 49 89 fc 55 48 89 f5 53 48 89 d3 e8 08 c0 2f ff 48 8d 7d 61 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 a7 02 00 00
RSP: 0018:ffffc90008bb7b70 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888000026000 RCX: dffffc0000000000
RDX: 0000000000000002 RSI: ffffffff82436ea8 RDI: 0000000000000011
RBP: ffffffffffffffb0 R08: ffff888093792400 R09: fffffbfff185cf3e
R10: ffffffff8c2e79ef R11: fffffbfff185cf3d R12: ffff888000100000
R13: ffff888000100008 R14: 0000000000000000 R15: ffff888000100000
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2c531000 CR3: 00000000685a2000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 nfsd_reply_cache_shutdown+0x150/0x350 fs/nfsd/nfscache.c:203
 nfsd_exit_net+0x189/0x4c0 fs/nfsd/nfsctl.c:1504
 ops_exit_list.isra.0+0xa8/0x150 net/core/net_namespace.c:186
 cleanup_net+0x511/0xa50 net/core/net_namespace.c:603
 process_one_work+0x965/0x16a0 kernel/workqueue.c:2268
 worker_thread+0x96/0xe20 kernel/workqueue.c:2414
 kthread+0x388/0x470 kernel/kthread.c:268
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 54f06072fc6a1afa ]---
RIP: 0010:nfsd_reply_cache_free_locked+0x2d/0x380 fs/nfsd/nfscache.c:122
Code: 56 41 55 41 54 49 89 fc 55 48 89 f5 53 48 89 d3 e8 08 c0 2f ff 48 8d 7d 61 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 a7 02 00 00
RSP: 0018:ffffc90008bb7b70 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888000026000 RCX: dffffc0000000000
RDX: 0000000000000002 RSI: ffffffff82436ea8 RDI: 0000000000000011
RBP: ffffffffffffffb0 R08: ffff888093792400 R09: fffffbfff185cf3e
R10: ffffffff8c2e79ef R11: fffffbfff185cf3d R12: ffff888000100000
R13: ffff888000100008 R14: 0000000000000000 R15: ffff888000100000
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2c531000 CR3: 0000000094cfb000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
