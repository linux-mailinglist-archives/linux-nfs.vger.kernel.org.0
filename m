Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4ECE1D7169
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2020 09:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgERG7O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 May 2020 02:59:14 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:42025 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgERG7O (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 May 2020 02:59:14 -0400
Received: by mail-il1-f200.google.com with SMTP id a13so8946496ila.9
        for <linux-nfs@vger.kernel.org>; Sun, 17 May 2020 23:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0DRTTMdVZ3heC4/TQ87vML96phwJC9Mo4+Jf/QtDxIs=;
        b=bIjoaYHTbS0Ph5knHJwaM2EwLc3EMw3JRA3f0qgXgtGzp4jKDs1gJuGM77X3w5Kya5
         iovUyouWLa9ujOjhdjuCewQS1nseN4f/P+qKhdgvwASW8ThnbHOYRe+Pp+4CftDPXFJx
         NLpiSYg6l4Axzk2UcbMDjbNghkM2bFFViOKIdAJQ7vmrSpenw/Hb/j7ZmPWr7ovDElRZ
         88GcnfmJouUIcOSKfjZc89y6GxMUfprYZf0zwzKR5FO1RGF6y55PKDmMo0gwaAa81X6z
         M8hGXycV0FZ8Bt14FVjem9EIjZhsRv+wWXK/w2eKsw5xMl4+g/cuzc0x5verbd/cKL9u
         zIOA==
X-Gm-Message-State: AOAM531aOEcjpXNO9KzEPYuo/TiT37OE/D2z+u2myK25LjNDUtsmVVuq
        SHF+GP2zBltrfPAHk8WNzj9+FyDkkrkQuR5OKRhFdapoflK1
X-Google-Smtp-Source: ABdhPJxv25dH3gO0w1lsIE4A8x9M7WmS6AwjpjzU3B2ogLIoYBsDEghD+K73/McTdGBMuX8tBAb4iLkViNxDRaHKaCL2EImtR872
MIME-Version: 1.0
X-Received: by 2002:a05:6638:243:: with SMTP id w3mr14673119jaq.20.1589785152982;
 Sun, 17 May 2020 23:59:12 -0700 (PDT)
Date:   Sun, 17 May 2020 23:59:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005016dd05a5e6b308@google.com>
Subject: BUG: unable to handle kernel paging request in rb_erase
From:   syzbot <syzbot+0e37e9d19bded16b8ab9@syzkaller.appspotmail.com>
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

HEAD commit:    9b1f2cbd Merge tag 'clk-fixes-for-linus' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15dfdeaa100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c14212794ed9ad24
dashboard link: https://syzkaller.appspot.com/bug?extid=0e37e9d19bded16b8ab9
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0e37e9d19bded16b8ab9@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffff887ffffffff0
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8682 Comm: syz-executor.3 Not tainted 5.7.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__rb_erase_augmented include/linux/rbtree_augmented.h:201 [inline]
RIP: 0010:rb_erase+0x37/0x18d0 lib/rbtree.c:443
Code: 89 f7 41 56 41 55 49 89 fd 48 83 c7 08 48 89 fa 41 54 48 c1 ea 03 55 53 48 83 ec 18 80 3c 02 00 0f 85 89 10 00 00 49 8d 7d 10 <4d> 8b 75 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80
RSP: 0018:ffffc900178ffb58 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff8880354d0000 RCX: ffffc9000fb6d000
RDX: 1ffff10ffffffffe RSI: ffff88800011dfe0 RDI: ffff887ffffffff8
RBP: ffff887fffffffb0 R08: ffff888057284280 R09: fffffbfff185d12e
R10: ffffffff8c2e896f R11: fffffbfff185d12d R12: ffff88800011dfe0
R13: ffff887fffffffe8 R14: 000000000001dfe0 R15: ffff88800011dfe0
FS:  00007fa002d21700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff887ffffffff0 CR3: 00000000a2164000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 nfsd_reply_cache_free_locked+0x198/0x380 fs/nfsd/nfscache.c:127
 nfsd_reply_cache_shutdown+0x150/0x350 fs/nfsd/nfscache.c:203
 nfsd_exit_net+0x189/0x4c0 fs/nfsd/nfsctl.c:1504
 ops_exit_list.isra.0+0xa8/0x150 net/core/net_namespace.c:186
 setup_net+0x50c/0x860 net/core/net_namespace.c:364
 copy_net_ns+0x293/0x590 net/core/net_namespace.c:482
 create_new_namespaces+0x3fb/0xb30 kernel/nsproxy.c:108
 unshare_nsproxy_namespaces+0xbd/0x1f0 kernel/nsproxy.c:229
 ksys_unshare+0x43d/0x8e0 kernel/fork.c:2970
 __do_sys_unshare kernel/fork.c:3038 [inline]
 __se_sys_unshare kernel/fork.c:3036 [inline]
 __x64_sys_unshare+0x2d/0x40 kernel/fork.c:3036
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45ca29
Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fa002d20c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 000000000050a1c0 RCX: 000000000045ca29
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040000000
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000c4e R14: 00000000004ce9bd R15: 00007fa002d216d4
Modules linked in:
CR2: ffff887ffffffff0
---[ end trace f929dcba0362906a ]---
RIP: 0010:__rb_erase_augmented include/linux/rbtree_augmented.h:201 [inline]
RIP: 0010:rb_erase+0x37/0x18d0 lib/rbtree.c:443
Code: 89 f7 41 56 41 55 49 89 fd 48 83 c7 08 48 89 fa 41 54 48 c1 ea 03 55 53 48 83 ec 18 80 3c 02 00 0f 85 89 10 00 00 49 8d 7d 10 <4d> 8b 75 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80
RSP: 0018:ffffc900178ffb58 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff8880354d0000 RCX: ffffc9000fb6d000
RDX: 1ffff10ffffffffe RSI: ffff88800011dfe0 RDI: ffff887ffffffff8
RBP: ffff887fffffffb0 R08: ffff888057284280 R09: fffffbfff185d12e
R10: ffffffff8c2e896f R11: fffffbfff185d12d R12: ffff88800011dfe0
R13: ffff887fffffffe8 R14: 000000000001dfe0 R15: ffff88800011dfe0
FS:  00007fa002d21700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff887ffffffff0 CR3: 00000000a2164000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
