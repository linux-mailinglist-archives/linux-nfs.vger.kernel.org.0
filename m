Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87259182D6
	for <lists+linux-nfs@lfdr.de>; Thu,  9 May 2019 02:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfEIARH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 May 2019 20:17:07 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:55579 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfEIARH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 May 2019 20:17:07 -0400
Received: by mail-io1-f72.google.com with SMTP id v11so439359ion.22
        for <linux-nfs@vger.kernel.org>; Wed, 08 May 2019 17:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=e87X274QzI+nGsJX1NYlS+xDvqLPNZh6bmnfqFL/Rcs=;
        b=p0lG1EtP5MdVqESzZnVQtbYDV4F5JTDdUalcoaIOfTva6aNkcPZT48Z6G03N482/dH
         Vv/f83OM41hQeWJ3MIwvehkmcJ6RmTqd7mpqUFnzgU5Ui4durIc1zDqKUDMqXqLLLTJZ
         pRZ1/A5BuC52nWUehph9MLwR/j0h6KRpt4TUZkmvlZNFuLcCpaBR+Pgx7U+GVkPA8Z46
         Y1+ubTOrE7BfQmuZ8kA5mntxzX0I7rkODJa6bDzJVcHLcq1dvDGqSIGu133WYtILtCGd
         x3bJRJKEREQfwWO7D+GNbtCUgJ4nik93GFkw8fZmo/lsyaf2Tf+uS6BeDlEYDVhCsfos
         GISw==
X-Gm-Message-State: APjAAAW4bCpI6X88udJW9u+R+kbqpKBskp6j9G/Ih9SYHrgRwBFJYkDK
        xesyl92KEnsMvkuwx7z1awUjZSrZTYV5un5QNmOlYGkG6Whx
X-Google-Smtp-Source: APXvYqwwvCXOA9r67ZLdGaDwNv8X5U/qdtVWHggK/l3JkUrEAEQ2MJhIVOyxH2fDWM2+OY384WZHJC1kCyxtgXO6gmJR7hYhl/51
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2286:: with SMTP id d6mr586903iod.257.1557361026392;
 Wed, 08 May 2019 17:17:06 -0700 (PDT)
Date:   Wed, 08 May 2019 17:17:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c3e9dc0588695e22@google.com>
Subject: WARNING: locking bug in nfs_get_client
From:   syzbot <syzbot+228a82b263b5da91883d@syzkaller.appspotmail.com>
To:     anna.schumaker@netapp.com, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        trond.myklebust@hammerspace.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    31ccad9b Add linux-next specific files for 20190508
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1082d2aca00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=63cd766601c6c9fc
dashboard link: https://syzkaller.appspot.com/bug?extid=228a82b263b5da91883d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140fdce8a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134dce02a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+228a82b263b5da91883d@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(depth <= 0)
WARNING: CPU: 1 PID: 7948 at kernel/locking/lockdep.c:4052 __lock_release  
kernel/locking/lockdep.c:4052 [inline]
WARNING: CPU: 1 PID: 7948 at kernel/locking/lockdep.c:4052  
lock_release+0x667/0xa00 kernel/locking/lockdep.c:4321
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 7948 Comm: syz-executor561 Not tainted 5.1.0-next-20190508 #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x75a kernel/panic.c:218
  __warn.cold+0x20/0x47 kernel/panic.c:575
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:972
RIP: 0010:__lock_release kernel/locking/lockdep.c:4052 [inline]
RIP: 0010:lock_release+0x667/0xa00 kernel/locking/lockdep.c:4321
Code: 0f 85 a0 03 00 00 8b 35 a7 02 09 08 85 f6 75 23 48 c7 c6 e0 57 6b 87  
48 c7 c7 80 27 6b 87 4c 89 85 70 ff ff ff e8 37 7c eb ff <0f> 0b 4c 8b 85  
70 ff ff ff 4c 89 ea 4c 89 e6 4c 89 c7 e8 52 63 ff
RSP: 0018:ffff888095867730 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 1ffff11012b0ceec RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815b20c6 RDI: ffffed1012b0ced8
RBP: ffff8880958677e8 R08: ffff88809a5b83c0 R09: fffffbfff1133071
R10: fffffbfff1133070 R11: ffffffff88998383 R12: ffff888219eeb700
R13: ffffffff821668ab R14: ffffffff8a45bd40 R15: ffff8880958677c0
  __raw_spin_unlock include/linux/spinlock_api_smp.h:150 [inline]
  _raw_spin_unlock+0x1b/0x50 kernel/locking/spinlock.c:183
  spin_unlock include/linux/spinlock.h:378 [inline]
  nfs_get_client+0xc1b/0x1300 fs/nfs/client.c:412
  nfs_init_server+0x26f/0xea0 fs/nfs/client.c:675
  nfs_create_server+0x12b/0x6d0 fs/nfs/client.c:962
  nfs_try_mount+0x15a/0x910 fs/nfs/super.c:1882
  nfs_fs_mount+0x184a/0x2690 fs/nfs/super.c:2718
  legacy_get_tree+0x10a/0x220 fs/fs_context.c:665
  vfs_get_tree+0x93/0x3a0 fs/super.c:1476
  do_new_mount fs/namespace.c:2790 [inline]
  do_mount+0x138c/0x1c00 fs/namespace.c:3110
  ksys_mount+0xdb/0x150 fs/namespace.c:3319
  __do_sys_mount fs/namespace.c:3333 [inline]
  __se_sys_mount fs/namespace.c:3330 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3330
  do_syscall_64+0x103/0x670 arch/x86/entry/common.c:298
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4467d9
Code: e8 5c b3 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 0b 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f54c53e0db8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000006dbc38 RCX: 00000000004467d9
RDX: 0000000020fb5ffc RSI: 0000000020343ff8 RDI: 0000000000000000
RBP: 00000000006dbc30 R08: 000000002000a000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc3c
R13: 00007ffe22037e2f R14: 00007f54c53e19c0 R15: 20c49ba5e353f7cf
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
