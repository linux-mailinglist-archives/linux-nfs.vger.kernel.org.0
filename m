Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19EAE2816C5
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Oct 2020 17:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387938AbgJBPil (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Oct 2020 11:38:41 -0400
Received: from mail-il1-f208.google.com ([209.85.166.208]:36291 "EHLO
        mail-il1-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgJBPiT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Oct 2020 11:38:19 -0400
Received: by mail-il1-f208.google.com with SMTP id q11so1444144ilt.3
        for <linux-nfs@vger.kernel.org>; Fri, 02 Oct 2020 08:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=PE5cBLSWtFQkLHdR6wGzlq+rKO5hHx9Bm3+Pczm/w3M=;
        b=jtEjaffH/WxeaNcnTWm5NH/4MvrWIdYd7TIbe6AoZWeEn1EgLcMEDqKouWjjqTck6Z
         vQ7Z8pCwe6wXVny3hs7rSRWsdRdpUJU9y0z8k5oMiYTz5ZcQwH/ytMQ9oWsXkEGOdwlr
         USSRxM4fwVEK4Mgsp3yPECueMQRstVAVqzLe4dsV6dfeqxsyCdJ34pMUrW0NBRwJT4pI
         VK+aUzx5TCInGQDG8PuB1RP2yL7pw2xdnB5BMlwuMdXJcApPFEM6s64Fh0ydCMV4ZT3X
         vuZPME0B5LOyl7VRIV9Pw83HEwKn0gdp2BFVLDGw6sphk0PBzFHv9nIeqMeVMxeTyrWV
         TE7Q==
X-Gm-Message-State: AOAM5306TScfVLHArvjusRGah3iMBQStdAHl0qd3jnJ0zuk/cftXu4rY
        gPM0iUMsFv4NkzvEQaDWC89a2ClINcvRlGgA1ejekXS4R5m+
X-Google-Smtp-Source: ABdhPJzfnKMduYiT0ZQ8SenI2VNULXq37MlUlg779YihyNkxKSLdyFyv8J1RzNk28gsqjwGpG5S8RtnOGVBTTOcnwbfGJFPXzMCj
MIME-Version: 1.0
X-Received: by 2002:a5e:9319:: with SMTP id k25mr2429079iom.153.1601653098822;
 Fri, 02 Oct 2020 08:38:18 -0700 (PDT)
Date:   Fri, 02 Oct 2020 08:38:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000002468205b0b1ece8@google.com>
Subject: WARNING in kvfree
From:   syzbot <syzbot+e8b76e1215d7b7214060@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, chuck.lever@oracle.com,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    60e72093 Merge tag 'clk-fixes-for-linus' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=169943a7900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89ab6a0c48f30b49
dashboard link: https://syzkaller.appspot.com/bug?extid=e8b76e1215d7b7214060
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e8b76e1215d7b7214060@syzkaller.appspotmail.com

------------[ cut here ]------------
virt_to_cache: Object is not a Slab page!
WARNING: CPU: 1 PID: 1161 at mm/slab.h:420 virt_to_cache mm/slab.h:420 [inline]
WARNING: CPU: 1 PID: 1161 at mm/slab.h:420 kfree+0x29b/0x2b0 mm/slab.c:3752
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 1161 Comm: kworker/u4:9 Not tainted 5.9.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: netns cleanup_net
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 panic+0x382/0x7fb kernel/panic.c:231
 __warn.cold+0x20/0x4b kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:virt_to_cache mm/slab.h:420 [inline]
RIP: 0010:kfree+0x29b/0x2b0 mm/slab.c:3752
Code: 05 91 b6 9d 09 01 e8 29 bf a5 ff e9 7a ff ff ff 48 c7 c6 80 70 96 88 48 c7 c7 70 c9 b2 89 c6 05 25 db 9d 09 01 e8 67 dd 8f ff <0f> 0b e9 bf fe ff ff 0f 0b 66 90 66 2e 0f 1f 84 00 00 00 00 00 41
RSP: 0018:ffffc90016137b50 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000286 RCX: 0000000000000000
RDX: ffff888061194000 RSI: ffffffff815f59d5 RDI: fffff52002c26f5c
RBP: ffff888000400000 R08: 0000000000000001 R09: ffff8880ae520f8b
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000200
R13: 000000000002bfa8 R14: ffff888000400000 R15: 0000000000000800
 kvfree+0x42/0x50 mm/util.c:603
 nfsd_reply_cache_shutdown+0x1a3/0x2c0 fs/nfsd/nfscache.c:214
 nfsd_exit_net+0x15f/0x490 fs/nfsd/nfsctl.c:1507
 ops_exit_list+0xb0/0x160 net/core/net_namespace.c:186
 cleanup_net+0x4ea/0xa00 net/core/net_namespace.c:603
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
