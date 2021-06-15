Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1F73A89C8
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jun 2021 21:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhFOTyI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Jun 2021 15:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhFOTyI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Jun 2021 15:54:08 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839B1C061574;
        Tue, 15 Jun 2021 12:52:03 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 60B1D620D; Tue, 15 Jun 2021 15:52:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 60B1D620D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1623786720;
        bh=oM0LZltQSkc1niBCAeKehrloS9a/z0+/caFSXoWiLTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DjpmFJ+vgnlPBEHHCIphRFx/JfeIpIj7sjCxXfBU42Eq91TwJ3ZTpHpn9ggq17qAj
         wSgo5xANP5mGtWCzYfxJbqTO1FZPuwcR6O1ip15ZW83GZj0xn/L7CGhsQxVV6QGDT8
         1+FPLXgjSJCMGYFu/8aIG3JKQ28FjG78Xbw2CVS0=
Date:   Tue, 15 Jun 2021 15:52:00 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     syzbot <syzbot+314d9a0380418b51606b@syzkaller.appspotmail.com>
Cc:     chuck.lever@oracle.com, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] general protection fault in
 nfsd_reply_cache_free_locked (2)
Message-ID: <20210615195200.GE11877@fieldses.org>
References: <000000000000a6561705c42681d8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a6561705c42681d8@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This isn't the first report:

	https://syzkaller.appspot.com/bug?extid=a29df412692980277f9d

but I'm not managing yet to see why it happens....

--b.

On Sun, Jun 06, 2021 at 10:42:26PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    231bc539 Merge branch 'for-linus' of git://git.kernel.org/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=101f596bd00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8a9e9956ca52a5f6
> dashboard link: https://syzkaller.appspot.com/bug?extid=314d9a0380418b51606b
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+314d9a0380418b51606b@syzkaller.appspotmail.com
> 
> general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
> CPU: 0 PID: 25304 Comm: kworker/u4:12 Not tainted 5.13.0-rc4-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: netns cleanup_net
> RIP: 0010:nfsd_reply_cache_free_locked+0x31/0x3b0 fs/nfsd/nfscache.c:123
> Code: 54 49 89 fc 55 48 89 f5 53 48 89 d3 48 83 ec 08 e8 94 f5 1c ff 48 8d 7d 61 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 c3 02 00 00
> RSP: 0018:ffffc90017a07b68 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: ffff888017997000 RCX: 0000000000000000
> RDX: 0000000000000002 RSI: ffffffff8257e6ec RDI: 0000000000000011
> RBP: ffffffffffffffb0 R08: 0000000000000800 R09: ffffffff902278af
> R10: ffffffff8257f56e R11: 0000000000084087 R12: ffff888000118680
> R13: 0000000000018680 R14: ffffed10000230d1 R15: ffff888000118680
> FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffe0630ed17 CR3: 0000000017232000 CR4: 00000000001526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  nfsd_reply_cache_shutdown+0x153/0x2d0 fs/nfsd/nfscache.c:222
>  nfsd_exit_net+0x15f/0x490 fs/nfsd/nfsctl.c:1503
>  ops_exit_list+0xb0/0x160 net/core/net_namespace.c:175
>  cleanup_net+0x4ea/0xb10 net/core/net_namespace.c:595
>  process_one_work+0x98d/0x1600 kernel/workqueue.c:2276
>  worker_thread+0x64c/0x1120 kernel/workqueue.c:2422
>  kthread+0x3b1/0x4a0 kernel/kthread.c:313
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> Modules linked in:
> ---[ end trace 0af87ae802e1324a ]---
> RIP: 0010:nfsd_reply_cache_free_locked+0x31/0x3b0 fs/nfsd/nfscache.c:123
> Code: 54 49 89 fc 55 48 89 f5 53 48 89 d3 48 83 ec 08 e8 94 f5 1c ff 48 8d 7d 61 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 c3 02 00 00
> RSP: 0018:ffffc90017a07b68 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: ffff888017997000 RCX: 0000000000000000
> RDX: 0000000000000002 RSI: ffffffff8257e6ec RDI: 0000000000000011
> RBP: ffffffffffffffb0 R08: 0000000000000800 R09: ffffffff902278af
> R10: ffffffff8257f56e R11: 0000000000084087 R12: ffff888000118680
> R13: 0000000000018680 R14: ffffed10000230d1 R15: ffff888000118680
> FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005618fcbf1160 CR3: 000000001518e000 CR4: 00000000001526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
