Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4C939D46A
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Jun 2021 07:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhFGFoR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Jun 2021 01:44:17 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:37477 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGFoR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Jun 2021 01:44:17 -0400
Received: by mail-il1-f199.google.com with SMTP id g12-20020a056e021a2cb02901dfc46878d8so11792208ile.4
        for <linux-nfs@vger.kernel.org>; Sun, 06 Jun 2021 22:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=chDCS4Sw6hIOP5jVhuCgufB3GV+DZAnpj3zjAvH362g=;
        b=lRGqxmlLFx7WZoTZwzNirZA+/l2hcksBWN9Hcc6N+Ty7r1AM953rTvQGOXXG6uExKL
         cjI3bfRlt7SRUF5CEhiEZonZiY5agPSMiCJbFFURCm7lqMHSBWP2a0MWuum2A6XJOaUg
         olPg4gpUBpBIgFVUdHBFTGBARBjT9wcGZxvZ356LQ/uqlvkWdfW+Ftr5lsrYd5fZshxt
         D4R2lsUuX12024jVQKWkSZowTKIOBMxJoeiHj5vDpdWCFAPhm/mdgaDtGl9BNlJXw5w3
         alOiZf97JcZSp3EvxqK7iJKy6zPyDPCvQ09pd22gKlrwYsFavdlNbWF6ngxWKfYBfMT2
         OXGw==
X-Gm-Message-State: AOAM531rQ8k2p8oMKeFYX1faPa15qLYhQC8CRM4dS0wq+J7uQ4bjQveo
        K/0+7xp2J91TSLdU3Xuioeoducb4IqbRIinK90cGXSygeAfK
X-Google-Smtp-Source: ABdhPJyPwqn6qaZM4S2rLPIghV3fGanVCqaU/MsNC7X/B4zODjd5OdOWsmUgMS9PI927BzDE1v7daxxxk0CB3IF4URjjgXhqXM7k
MIME-Version: 1.0
X-Received: by 2002:a6b:e303:: with SMTP id u3mr14127750ioc.177.1623044546513;
 Sun, 06 Jun 2021 22:42:26 -0700 (PDT)
Date:   Sun, 06 Jun 2021 22:42:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a6561705c42681d8@google.com>
Subject: [syzbot] general protection fault in nfsd_reply_cache_free_locked (2)
From:   syzbot <syzbot+314d9a0380418b51606b@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, chuck.lever@oracle.com,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    231bc539 Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=101f596bd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a9e9956ca52a5f6
dashboard link: https://syzkaller.appspot.com/bug?extid=314d9a0380418b51606b

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+314d9a0380418b51606b@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 0 PID: 25304 Comm: kworker/u4:12 Not tainted 5.13.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: netns cleanup_net
RIP: 0010:nfsd_reply_cache_free_locked+0x31/0x3b0 fs/nfsd/nfscache.c:123
Code: 54 49 89 fc 55 48 89 f5 53 48 89 d3 48 83 ec 08 e8 94 f5 1c ff 48 8d 7d 61 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 c3 02 00 00
RSP: 0018:ffffc90017a07b68 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888017997000 RCX: 0000000000000000
RDX: 0000000000000002 RSI: ffffffff8257e6ec RDI: 0000000000000011
RBP: ffffffffffffffb0 R08: 0000000000000800 R09: ffffffff902278af
R10: ffffffff8257f56e R11: 0000000000084087 R12: ffff888000118680
R13: 0000000000018680 R14: ffffed10000230d1 R15: ffff888000118680
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe0630ed17 CR3: 0000000017232000 CR4: 00000000001526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 nfsd_reply_cache_shutdown+0x153/0x2d0 fs/nfsd/nfscache.c:222
 nfsd_exit_net+0x15f/0x490 fs/nfsd/nfsctl.c:1503
 ops_exit_list+0xb0/0x160 net/core/net_namespace.c:175
 cleanup_net+0x4ea/0xb10 net/core/net_namespace.c:595
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2276
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2422
 kthread+0x3b1/0x4a0 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Modules linked in:
---[ end trace 0af87ae802e1324a ]---
RIP: 0010:nfsd_reply_cache_free_locked+0x31/0x3b0 fs/nfsd/nfscache.c:123
Code: 54 49 89 fc 55 48 89 f5 53 48 89 d3 48 83 ec 08 e8 94 f5 1c ff 48 8d 7d 61 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 c3 02 00 00
RSP: 0018:ffffc90017a07b68 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888017997000 RCX: 0000000000000000
RDX: 0000000000000002 RSI: ffffffff8257e6ec RDI: 0000000000000011
RBP: ffffffffffffffb0 R08: 0000000000000800 R09: ffffffff902278af
R10: ffffffff8257f56e R11: 0000000000084087 R12: ffff888000118680
R13: 0000000000018680 R14: ffffed10000230d1 R15: ffff888000118680
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005618fcbf1160 CR3: 000000001518e000 CR4: 00000000001526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
