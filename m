Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0959818891
	for <lists+linux-nfs@lfdr.de>; Thu,  9 May 2019 12:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfEIKzO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 May 2019 06:55:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfEIKzO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 9 May 2019 06:55:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B9F77C064293;
        Thu,  9 May 2019 10:55:13 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-112-5.rdu2.redhat.com [10.10.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D6505DF4C;
        Thu,  9 May 2019 10:55:11 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     anna.schumaker@netapp.com
Cc:     linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, trond.myklebust@hammerspace.com,
        "Roberto Bergantinos Corpas" <rbergant@redhat.com>,
        syzbot <syzbot+228a82b263b5da91883d@syzkaller.appspotmail.com>
Subject: Re: WARNING: locking bug in nfs_get_client
Date:   Thu, 09 May 2019 06:55:10 -0400
Message-ID: <C6C33F7F-8CD2-4E0F-82BA-5443133FBB54@redhat.com>
In-Reply-To: <000000000000c3e9dc0588695e22@google.com>
References: <000000000000c3e9dc0588695e22@google.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 09 May 2019 10:55:13 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We need to return from nfs_match_client() while still holding the 
nfs_client_lock, or maybe fixed with ISERR_OR_NULL in nfs_match 
client().

Anna, would you like a patch to fix it, or can that commit be pulled out 
and fixed up at this point?

Ben


On 8 May 2019, at 20:17, syzbot wrote:

> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    31ccad9b Add linux-next specific files for 20190508
> git tree:       linux-next
> console output: 
> https://syzkaller.appspot.com/x/log.txt?x=1082d2aca00000
> kernel config:  
> https://syzkaller.appspot.com/x/.config?x=63cd766601c6c9fc
> dashboard link: 
> https://syzkaller.appspot.com/bug?extid=228a82b263b5da91883d
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      
> https://syzkaller.appspot.com/x/repro.syz?x=140fdce8a00000
> C reproducer:   
> https://syzkaller.appspot.com/x/repro.c?x=134dce02a00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the 
> commit:
> Reported-by: syzbot+228a82b263b5da91883d@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> DEBUG_LOCKS_WARN_ON(depth <= 0)
> WARNING: CPU: 1 PID: 7948 at kernel/locking/lockdep.c:4052 
> __lock_release kernel/locking/lockdep.c:4052 [inline]
> WARNING: CPU: 1 PID: 7948 at kernel/locking/lockdep.c:4052 
> lock_release+0x667/0xa00 kernel/locking/lockdep.c:4321
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 7948 Comm: syz-executor561 Not tainted 5.1.0-next-20190508 
> #3
> Hardware name: Google Google Compute Engine/Google Compute Engine, 
> BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
>  panic+0x2cb/0x75a kernel/panic.c:218
>  __warn.cold+0x20/0x47 kernel/panic.c:575
>  report_bug+0x263/0x2b0 lib/bug.c:186
>  fixup_bug arch/x86/kernel/traps.c:179 [inline]
>  fixup_bug arch/x86/kernel/traps.c:174 [inline]
>  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
>  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:972
> RIP: 0010:__lock_release kernel/locking/lockdep.c:4052 [inline]
> RIP: 0010:lock_release+0x667/0xa00 kernel/locking/lockdep.c:4321
> Code: 0f 85 a0 03 00 00 8b 35 a7 02 09 08 85 f6 75 23 48 c7 c6 e0 57 
> 6b 87 48 c7 c7 80 27 6b 87 4c 89 85 70 ff ff ff e8 37 7c eb ff <0f> 0b 
> 4c 8b 85 70 ff ff ff 4c 89 ea 4c 89 e6 4c 89 c7 e8 52 63 ff
> RSP: 0018:ffff888095867730 EFLAGS: 00010082
> RAX: 0000000000000000 RBX: 1ffff11012b0ceec RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff815b20c6 RDI: ffffed1012b0ced8
> RBP: ffff8880958677e8 R08: ffff88809a5b83c0 R09: fffffbfff1133071
> R10: fffffbfff1133070 R11: ffffffff88998383 R12: ffff888219eeb700
> R13: ffffffff821668ab R14: ffffffff8a45bd40 R15: ffff8880958677c0
>  __raw_spin_unlock include/linux/spinlock_api_smp.h:150 [inline]
>  _raw_spin_unlock+0x1b/0x50 kernel/locking/spinlock.c:183
>  spin_unlock include/linux/spinlock.h:378 [inline]
>  nfs_get_client+0xc1b/0x1300 fs/nfs/client.c:412
>  nfs_init_server+0x26f/0xea0 fs/nfs/client.c:675
>  nfs_create_server+0x12b/0x6d0 fs/nfs/client.c:962
>  nfs_try_mount+0x15a/0x910 fs/nfs/super.c:1882
>  nfs_fs_mount+0x184a/0x2690 fs/nfs/super.c:2718
>  legacy_get_tree+0x10a/0x220 fs/fs_context.c:665
>  vfs_get_tree+0x93/0x3a0 fs/super.c:1476
>  do_new_mount fs/namespace.c:2790 [inline]
>  do_mount+0x138c/0x1c00 fs/namespace.c:3110
>  ksys_mount+0xdb/0x150 fs/namespace.c:3319
>  __do_sys_mount fs/namespace.c:3333 [inline]
>  __se_sys_mount fs/namespace.c:3330 [inline]
>  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3330
>  do_syscall_64+0x103/0x670 arch/x86/entry/common.c:298
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4467d9
> Code: e8 5c b3 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 
> 01 f0 ff ff 0f 83 0b 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f54c53e0db8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00000000006dbc38 RCX: 00000000004467d9
> RDX: 0000000020fb5ffc RSI: 0000000020343ff8 RDI: 0000000000000000
> RBP: 00000000006dbc30 R08: 000000002000a000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc3c
> R13: 00007ffe22037e2f R14: 00007f54c53e19c0 R15: 20c49ba5e353f7cf
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
