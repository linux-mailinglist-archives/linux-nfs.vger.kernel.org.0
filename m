Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88ECF1EC4A5
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jun 2020 23:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgFBVzS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Jun 2020 17:55:18 -0400
Received: from fieldses.org ([173.255.197.46]:34012 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgFBVzR (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 2 Jun 2020 17:55:17 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 15AB91BE7; Tue,  2 Jun 2020 17:55:17 -0400 (EDT)
Date:   Tue, 2 Jun 2020 17:55:17 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     syzbot <syzbot+0e37e9d19bded16b8ab9@syzkaller.appspotmail.com>
Cc:     chuck.lever@oracle.com, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: BUG: unable to handle kernel paging request in rb_erase
Message-ID: <20200602215517.GK1769@fieldses.org>
References: <0000000000005016dd05a5e6b308@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000005016dd05a5e6b308@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

As far as I know, this one's still unresolved.  I can't see the bug from
code inspection, and we don't have a reproducer.  If anyone else sees
this or has an idea what might be going wrong, I'd be interested.--b.

On Sun, May 17, 2020 at 11:59:12PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    9b1f2cbd Merge tag 'clk-fixes-for-linus' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15dfdeaa100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c14212794ed9ad24
> dashboard link: https://syzkaller.appspot.com/bug?extid=0e37e9d19bded16b8ab9
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+0e37e9d19bded16b8ab9@syzkaller.appspotmail.com
> 
> BUG: unable to handle page fault for address: ffff887ffffffff0
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0 
> Oops: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 8682 Comm: syz-executor.3 Not tainted 5.7.0-rc5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:__rb_erase_augmented include/linux/rbtree_augmented.h:201 [inline]
> RIP: 0010:rb_erase+0x37/0x18d0 lib/rbtree.c:443
> Code: 89 f7 41 56 41 55 49 89 fd 48 83 c7 08 48 89 fa 41 54 48 c1 ea 03 55 53 48 83 ec 18 80 3c 02 00 0f 85 89 10 00 00 49 8d 7d 10 <4d> 8b 75 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80
> RSP: 0018:ffffc900178ffb58 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: ffff8880354d0000 RCX: ffffc9000fb6d000
> RDX: 1ffff10ffffffffe RSI: ffff88800011dfe0 RDI: ffff887ffffffff8
> RBP: ffff887fffffffb0 R08: ffff888057284280 R09: fffffbfff185d12e
> R10: ffffffff8c2e896f R11: fffffbfff185d12d R12: ffff88800011dfe0
> R13: ffff887fffffffe8 R14: 000000000001dfe0 R15: ffff88800011dfe0
> FS:  00007fa002d21700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff887ffffffff0 CR3: 00000000a2164000 CR4: 00000000001426e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  nfsd_reply_cache_free_locked+0x198/0x380 fs/nfsd/nfscache.c:127
>  nfsd_reply_cache_shutdown+0x150/0x350 fs/nfsd/nfscache.c:203
>  nfsd_exit_net+0x189/0x4c0 fs/nfsd/nfsctl.c:1504
>  ops_exit_list.isra.0+0xa8/0x150 net/core/net_namespace.c:186
>  setup_net+0x50c/0x860 net/core/net_namespace.c:364
>  copy_net_ns+0x293/0x590 net/core/net_namespace.c:482
>  create_new_namespaces+0x3fb/0xb30 kernel/nsproxy.c:108
>  unshare_nsproxy_namespaces+0xbd/0x1f0 kernel/nsproxy.c:229
>  ksys_unshare+0x43d/0x8e0 kernel/fork.c:2970
>  __do_sys_unshare kernel/fork.c:3038 [inline]
>  __se_sys_unshare kernel/fork.c:3036 [inline]
>  __x64_sys_unshare+0x2d/0x40 kernel/fork.c:3036
>  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
>  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> RIP: 0033:0x45ca29
> Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fa002d20c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
> RAX: ffffffffffffffda RBX: 000000000050a1c0 RCX: 000000000045ca29
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040000000
> RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 0000000000000c4e R14: 00000000004ce9bd R15: 00007fa002d216d4
> Modules linked in:
> CR2: ffff887ffffffff0
> ---[ end trace f929dcba0362906a ]---
> RIP: 0010:__rb_erase_augmented include/linux/rbtree_augmented.h:201 [inline]
> RIP: 0010:rb_erase+0x37/0x18d0 lib/rbtree.c:443
> Code: 89 f7 41 56 41 55 49 89 fd 48 83 c7 08 48 89 fa 41 54 48 c1 ea 03 55 53 48 83 ec 18 80 3c 02 00 0f 85 89 10 00 00 49 8d 7d 10 <4d> 8b 75 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80
> RSP: 0018:ffffc900178ffb58 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: ffff8880354d0000 RCX: ffffc9000fb6d000
> RDX: 1ffff10ffffffffe RSI: ffff88800011dfe0 RDI: ffff887ffffffff8
> RBP: ffff887fffffffb0 R08: ffff888057284280 R09: fffffbfff185d12e
> R10: ffffffff8c2e896f R11: fffffbfff185d12d R12: ffff88800011dfe0
> R13: ffff887fffffffe8 R14: 000000000001dfe0 R15: ffff88800011dfe0
> FS:  00007fa002d21700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff887ffffffff0 CR3: 00000000a2164000 CR4: 00000000001426e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
