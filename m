Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3AC3C1F0
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 06:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbfFKEFL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 00:05:11 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:51751 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729002AbfFKEFJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 00:05:09 -0400
Received: by mail-io1-f71.google.com with SMTP id c5so8978350iom.18
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jun 2019 21:05:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2UHT5+0hoHPI7lRp78iDkkxz+eTLGQdKF6m1lbfvIjk=;
        b=GlNTLOJsJjHhPlk1Zc45dHZhcZKtKp+4pwvlThmu2a2TxqU02tX5XcK+gPBvN/tgxc
         nUy4K2RqJWJtiMqhN1UmAL6qt1laCji1tA7os4IpW1iqNdy5s5P3DnKn5MoFdU5KtO+T
         JRwLoxeW4jJXEifbZmyVLpKIjOJdNCLDd4KPecy7WnurPV4ke2tN6PIlns9WcDQ0cyct
         k58VowvZRnV6LeVMkFtROCQQcSE4GZt5qiSkZsx0OlvjiDKhkY2RTOE2360lPMVfE/Ia
         a8oht9O3XtNnwuKxrjTA+lw6DAr12uMHuB6qD9mBWYRPjIJELgYQa3USM++WNfsUhWaq
         7hPg==
X-Gm-Message-State: APjAAAV4pnnYKzkUHBgavgBo7eAnMmAQa8f30+0hWRfCJNTjIhxn1cuy
        lzyrEnOmSZYvKi4PtpdQpX0jbaUWuLzcUNn9hztcLu03tRJ8
X-Google-Smtp-Source: APXvYqwsT92YNG/81/yUHOBqS38JIqYTYLvGlQ8SOb9sxCCdOcVC8dmWYH3n6S2LSvwi6GFaM3zii3WjS0wK/VgzMX/PDn2qCEff
MIME-Version: 1.0
X-Received: by 2002:a24:4d0f:: with SMTP id l15mr15340660itb.39.1560225907246;
 Mon, 10 Jun 2019 21:05:07 -0700 (PDT)
Date:   Mon, 10 Jun 2019 21:05:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8a345058b046657@google.com>
Subject: memory leak in nfs_get_client
From:   syzbot <syzbot+7fe11b49c1cc30e3fce2@syzkaller.appspotmail.com>
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

HEAD commit:    d1fdb6d8 Linux 5.2-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=117e0f71a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb38d33cd06d8d48
dashboard link: https://syzkaller.appspot.com/bug?extid=7fe11b49c1cc30e3fce2
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a46001a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174b24d1a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7fe11b49c1cc30e3fce2@syzkaller.appspotmail.com

  fl=212 nc=0 na=0]
BUG: memory leak
unreferenced object 0xffff888121b91400 (size 1024):
   comm "syz-executor400", pid 6969, jiffies 4294941900 (age 18.210s)
   hex dump (first 32 bytes):
     01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000009c69e9c0>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000009c69e9c0>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000009c69e9c0>] slab_alloc mm/slab.c:3326 [inline]
     [<000000009c69e9c0>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<000000007d1011ce>] kmalloc include/linux/slab.h:547 [inline]
     [<000000007d1011ce>] kzalloc include/linux/slab.h:742 [inline]
     [<000000007d1011ce>] nfs_alloc_client+0x2e/0x170 fs/nfs/client.c:152
     [<000000007f1bdfa5>] nfs_get_client+0x1cb/0x500 fs/nfs/client.c:425
     [<000000004dc18603>] nfs_init_server+0xc6/0x450 fs/nfs/client.c:671
     [<0000000072615bbf>] nfs_create_server+0x83/0x1f0 fs/nfs/client.c:958
     [<00000000d12e9a98>] nfs_try_mount+0x5a/0x350 fs/nfs/super.c:1883
     [<00000000b2735769>] nfs_fs_mount+0x448/0xc52 fs/nfs/super.c:2719
     [<000000000b19c7d0>] legacy_get_tree+0x27/0x80 fs/fs_context.c:661
     [<00000000d4887a5c>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<000000008eec78b0>] do_new_mount fs/namespace.c:2790 [inline]
     [<000000008eec78b0>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<00000000d0ad59a7>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<0000000082fa14d6>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<0000000082fa14d6>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<0000000082fa14d6>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<00000000ce916bab>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000070865558>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811e758400 (size 1024):
   comm "syz-executor400", pid 6973, jiffies 4294941906 (age 18.150s)
   hex dump (first 32 bytes):
     01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000009c69e9c0>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000009c69e9c0>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000009c69e9c0>] slab_alloc mm/slab.c:3326 [inline]
     [<000000009c69e9c0>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<000000007d1011ce>] kmalloc include/linux/slab.h:547 [inline]
     [<000000007d1011ce>] kzalloc include/linux/slab.h:742 [inline]
     [<000000007d1011ce>] nfs_alloc_client+0x2e/0x170 fs/nfs/client.c:152
     [<000000007f1bdfa5>] nfs_get_client+0x1cb/0x500 fs/nfs/client.c:425
     [<000000004dc18603>] nfs_init_server+0xc6/0x450 fs/nfs/client.c:671
     [<0000000072615bbf>] nfs_create_server+0x83/0x1f0 fs/nfs/client.c:958
     [<00000000d12e9a98>] nfs_try_mount+0x5a/0x350 fs/nfs/super.c:1883
     [<00000000b2735769>] nfs_fs_mount+0x448/0xc52 fs/nfs/super.c:2719
     [<000000000b19c7d0>] legacy_get_tree+0x27/0x80 fs/fs_context.c:661
     [<00000000d4887a5c>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<000000008eec78b0>] do_new_mount fs/namespace.c:2790 [inline]
     [<000000008eec78b0>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<00000000d0ad59a7>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<0000000082fa14d6>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<0000000082fa14d6>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<0000000082fa14d6>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<00000000ce916bab>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000070865558>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888118ef9360 (size 32):
   comm "syz-executor400", pid 6973, jiffies 4294941906 (age 18.150s)
   hex dump (first 32 bytes):
     00 71 54 04 00 ea ff ff c0 6e 9a 04 00 ea ff ff  .qT......n......
     c0 0b 81 04 00 ea ff ff c0 05 86 04 00 ea ff ff  ................
   backtrace:
     [<000000003e75bb46>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000003e75bb46>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000003e75bb46>] slab_alloc mm/slab.c:3326 [inline]
     [<000000003e75bb46>] __do_kmalloc mm/slab.c:3658 [inline]
     [<000000003e75bb46>] __kmalloc_track_caller+0x15d/0x2c0 mm/slab.c:3675
     [<0000000010f1326b>] kstrdup+0x3a/0x70 mm/util.c:52
     [<0000000070b2f357>] nfs_alloc_client+0xbd/0x170 fs/nfs/client.c:169
     [<000000007f1bdfa5>] nfs_get_client+0x1cb/0x500 fs/nfs/client.c:425
     [<000000004dc18603>] nfs_init_server+0xc6/0x450 fs/nfs/client.c:671
     [<0000000072615bbf>] nfs_create_server+0x83/0x1f0 fs/nfs/client.c:958
     [<00000000d12e9a98>] nfs_try_mount+0x5a/0x350 fs/nfs/super.c:1883
     [<00000000b2735769>] nfs_fs_mount+0x448/0xc52 fs/nfs/super.c:2719
     [<000000000b19c7d0>] legacy_get_tree+0x27/0x80 fs/fs_context.c:661
     [<00000000d4887a5c>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<000000008eec78b0>] do_new_mount fs/namespace.c:2790 [inline]
     [<000000008eec78b0>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<00000000d0ad59a7>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<0000000082fa14d6>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<0000000082fa14d6>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<0000000082fa14d6>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<00000000ce916bab>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000070865558>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888121b91400 (size 1024):
   comm "syz-executor400", pid 6969, jiffies 4294941900 (age 19.230s)
   hex dump (first 32 bytes):
     01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000009c69e9c0>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000009c69e9c0>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000009c69e9c0>] slab_alloc mm/slab.c:3326 [inline]
     [<000000009c69e9c0>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<000000007d1011ce>] kmalloc include/linux/slab.h:547 [inline]
     [<000000007d1011ce>] kzalloc include/linux/slab.h:742 [inline]
     [<000000007d1011ce>] nfs_alloc_client+0x2e/0x170 fs/nfs/client.c:152
     [<000000007f1bdfa5>] nfs_get_client+0x1cb/0x500 fs/nfs/client.c:425
     [<000000004dc18603>] nfs_init_server+0xc6/0x450 fs/nfs/client.c:671
     [<0000000072615bbf>] nfs_create_server+0x83/0x1f0 fs/nfs/client.c:958
     [<00000000d12e9a98>] nfs_try_mount+0x5a/0x350 fs/nfs/super.c:1883
     [<00000000b2735769>] nfs_fs_mount+0x448/0xc52 fs/nfs/super.c:2719
     [<000000000b19c7d0>] legacy_get_tree+0x27/0x80 fs/fs_context.c:661
     [<00000000d4887a5c>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<000000008eec78b0>] do_new_mount fs/namespace.c:2790 [inline]
     [<000000008eec78b0>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<00000000d0ad59a7>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<0000000082fa14d6>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<0000000082fa14d6>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<0000000082fa14d6>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<00000000ce916bab>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000070865558>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811e758400 (size 1024):
   comm "syz-executor400", pid 6973, jiffies 4294941906 (age 19.170s)
   hex dump (first 32 bytes):
     01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000009c69e9c0>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000009c69e9c0>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000009c69e9c0>] slab_alloc mm/slab.c:3326 [inline]
     [<000000009c69e9c0>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<000000007d1011ce>] kmalloc include/linux/slab.h:547 [inline]
     [<000000007d1011ce>] kzalloc include/linux/slab.h:742 [inline]
     [<000000007d1011ce>] nfs_alloc_client+0x2e/0x170 fs/nfs/client.c:152
     [<000000007f1bdfa5>] nfs_get_client+0x1cb/0x500 fs/nfs/client.c:425
     [<000000004dc18603>] nfs_init_server+0xc6/0x450 fs/nfs/client.c:671
     [<0000000072615bbf>] nfs_create_server+0x83/0x1f0 fs/nfs/client.c:958
     [<00000000d12e9a98>] nfs_try_mount+0x5a/0x350 fs/nfs/super.c:1883
     [<00000000b2735769>] nfs_fs_mount+0x448/0xc52 fs/nfs/super.c:2719
     [<000000000b19c7d0>] legacy_get_tree+0x27/0x80 fs/fs_context.c:661
     [<00000000d4887a5c>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<000000008eec78b0>] do_new_mount fs/namespace.c:2790 [inline]
     [<000000008eec78b0>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<00000000d0ad59a7>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<0000000082fa14d6>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<0000000082fa14d6>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<0000000082fa14d6>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<00000000ce916bab>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000070865558>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888118ef9360 (size 32):
   comm "syz-executor400", pid 6973, jiffies 4294941906 (age 19.170s)
   hex dump (first 32 bytes):
     00 71 54 04 00 ea ff ff c0 6e 9a 04 00 ea ff ff  .qT......n......
     c0 0b 81 04 00 ea ff ff c0 05 86 04 00 ea ff ff  ................
   backtrace:
     [<000000003e75bb46>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000003e75bb46>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000003e75bb46>] slab_alloc mm/slab.c:3326 [inline]
     [<000000003e75bb46>] __do_kmalloc mm/slab.c:3658 [inline]
     [<000000003e75bb46>] __kmalloc_track_caller+0x15d/0x2c0 mm/slab.c:3675
     [<0000000010f1326b>] kstrdup+0x3a/0x70 mm/util.c:52
     [<0000000070b2f357>] nfs_alloc_client+0xbd/0x170 fs/nfs/client.c:169
     [<000000007f1bdfa5>] nfs_get_client+0x1cb/0x500 fs/nfs/client.c:425
     [<000000004dc18603>] nfs_init_server+0xc6/0x450 fs/nfs/client.c:671
     [<0000000072615bbf>] nfs_create_server+0x83/0x1f0 fs/nfs/client.c:958
     [<00000000d12e9a98>] nfs_try_mount+0x5a/0x350 fs/nfs/super.c:1883
     [<00000000b2735769>] nfs_fs_mount+0x448/0xc52 fs/nfs/super.c:2719
     [<000000000b19c7d0>] legacy_get_tree+0x27/0x80 fs/fs_context.c:661
     [<00000000d4887a5c>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<000000008eec78b0>] do_new_mount fs/namespace.c:2790 [inline]
     [<000000008eec78b0>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<00000000d0ad59a7>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<0000000082fa14d6>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<0000000082fa14d6>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<0000000082fa14d6>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<00000000ce916bab>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000070865558>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888121b91400 (size 1024):
   comm "syz-executor400", pid 6969, jiffies 4294941900 (age 21.200s)
   hex dump (first 32 bytes):
     01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000009c69e9c0>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000009c69e9c0>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000009c69e9c0>] slab_alloc mm/slab.c:3326 [inline]
     [<000000009c69e9c0>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<000000007d1011ce>] kmalloc include/linux/slab.h:547 [inline]
     [<000000007d1011ce>] kzalloc include/linux/slab.h:742 [inline]
     [<000000007d1011ce>] nfs_alloc_client+0x2e/0x170 fs/nfs/client.c:152
     [<000000007f1bdfa5>] nfs_get_client+0x1cb/0x500 fs/nfs/client.c:425
     [<000000004dc18603>] nfs_init_server+0xc6/0x450 fs/nfs/client.c:671
     [<0000000072615bbf>] nfs_create_server+0x83/0x1f0 fs/nfs/client.c:958
     [<00000000d12e9a98>] nfs_try_mount+0x5a/0x350 fs/nfs/super.c:1883
     [<00000000b2735769>] nfs_fs_mount+0x448/0xc52 fs/nfs/super.c:2719
     [<000000000b19c7d0>] legacy_get_tree+0x27/0x80 fs/fs_context.c:661
     [<00000000d4887a5c>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<000000008eec78b0>] do_new_mount fs/namespace.c:2790 [inline]
     [<000000008eec78b0>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<00000000d0ad59a7>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<0000000082fa14d6>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<0000000082fa14d6>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<0000000082fa14d6>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<00000000ce916bab>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000070865558>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811e758400 (size 1024):
   comm "syz-executor400", pid 6973, jiffies 4294941906 (age 21.140s)
   hex dump (first 32 bytes):
     01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000009c69e9c0>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000009c69e9c0>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000009c69e9c0>] slab_alloc mm/slab.c:3326 [inline]
     [<000000009c69e9c0>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<000000007d1011ce>] kmalloc include/linux/slab.h:547 [inline]
     [<000000007d1011ce>] kzalloc include/linux/slab.h:742 [inline]
     [<000000007d1011ce>] nfs_alloc_client+0x2e/0x170 fs/nfs/client.c:152
     [<000000007f1bdfa5>] nfs_get_client+0x1cb/0x500 fs/nfs/client.c:425
     [<000000004dc18603>] nfs_init_server+0xc6/0x450 fs/nfs/client.c:671
     [<0000000072615bbf>] nfs_create_server+0x83/0x1f0 fs/nfs/client.c:958
     [<00000000d12e9a98>] nfs_try_mount+0x5a/0x350 fs/nfs/super.c:1883
     [<00000000b2735769>] nfs_fs_mount+0x448/0xc52 fs/nfs/super.c:2719
     [<000000000b19c7d0>] legacy_get_tree+0x27/0x80 fs/fs_context.c:661
     [<00000000d4887a5c>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<000000008eec78b0>] do_new_mount fs/namespace.c:2790 [inline]
     [<000000008eec78b0>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<00000000d0ad59a7>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<0000000082fa14d6>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<0000000082fa14d6>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<0000000082fa14d6>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<00000000ce916bab>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000070865558>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888118ef9360 (size 32):
   comm "syz-executor400", pid 6973, jiffies 4294941906 (age 21.140s)
   hex dump (first 32 bytes):
     00 71 54 04 00 ea ff ff c0 6e 9a 04 00 ea ff ff  .qT......n......
     c0 0b 81 04 00 ea ff ff c0 05 86 04 00 ea ff ff  ................
   backtrace:
     [<000000003e75bb46>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000003e75bb46>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000003e75bb46>] slab_alloc mm/slab.c:3326 [inline]
     [<000000003e75bb46>] __do_kmalloc mm/slab.c:3658 [inline]
     [<000000003e75bb46>] __kmalloc_track_caller+0x15d/0x2c0 mm/slab.c:3675
     [<0000000010f1326b>] kstrdup+0x3a/0x70 mm/util.c:52
     [<0000000070b2f357>] nfs_alloc_client+0xbd/0x170 fs/nfs/client.c:169
     [<000000007f1bdfa5>] nfs_get_client+0x1cb/0x500 fs/nfs/client.c:425
     [<000000004dc18603>] nfs_init_server+0xc6/0x450 fs/nfs/client.c:671
     [<0000000072615bbf>] nfs_create_server+0x83/0x1f0 fs/nfs/client.c:958
     [<00000000d12e9a98>] nfs_try_mount+0x5a/0x350 fs/nfs/super.c:1883
     [<00000000b2735769>] nfs_fs_mount+0x448/0xc52 fs/nfs/super.c:2719
     [<000000000b19c7d0>] legacy_get_tree+0x27/0x80 fs/fs_context.c:661
     [<00000000d4887a5c>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<000000008eec78b0>] do_new_mount fs/namespace.c:2790 [inline]
     [<000000008eec78b0>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<00000000d0ad59a7>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<0000000082fa14d6>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<0000000082fa14d6>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<0000000082fa14d6>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<00000000ce916bab>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000070865558>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888121b91400 (size 1024):
   comm "syz-executor400", pid 6969, jiffies 4294941900 (age 22.200s)
   hex dump (first 32 bytes):
     01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000009c69e9c0>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000009c69e9c0>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000009c69e9c0>] slab_alloc mm/slab.c:3326 [inline]
     [<000000009c69e9c0>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<000000007d1011ce>] kmalloc include/linux/slab.h:547 [inline]
     [<000000007d1011ce>] kzalloc include/linux/slab.h:742 [inline]
     [<000000007d1011ce>] nfs_alloc_client+0x2e/0x170 fs/nfs/client.c:152
     [<000000007f1bdfa5>] nfs_get_client+0x1cb/0x500 fs/nfs/client.c:425
     [<000000004dc18603>] nfs_init_server+0xc6/0x450 fs/nfs/client.c:671
     [<0000000072615bbf>] nfs_create_server+0x83/0x1f0 fs/nfs/client.c:958
     [<00000000d12e9a98>] nfs_try_mount+0x5a/0x350 fs/nfs/super.c:1883
     [<00000000b2735769>] nfs_fs_mount+0x448/0xc52 fs/nfs/super.c:2719
     [<000000000b19c7d0>] legacy_get_tree+0x27/0x80 fs/fs_context.c:661
     [<00000000d4887a5c>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<000000008eec78b0>] do_new_mount fs/namespace.c:2790 [inline]
     [<000000008eec78b0>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<00000000d0ad59a7>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<0000000082fa14d6>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<0000000082fa14d6>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<0000000082fa14d6>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<00000000ce916bab>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000070865558>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811e758400 (size 1024):
   comm "syz-executor400", pid 6973, jiffies 4294941906 (age 22.140s)
   hex dump (first 32 bytes):
     01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000009c69e9c0>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000009c69e9c0>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000009c69e9c0>] slab_alloc mm/slab.c:3326 [inline]
     [<000000009c69e9c0>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<000000007d1011ce>] kmalloc include/linux/slab.h:547 [inline]
     [<000000007d1011ce>] kzalloc include/linux/slab.h:742 [inline]
     [<000000007d1011ce>] nfs_alloc_client+0x2e/0x170 fs/nfs/client.c:152
     [<000000007f1bdfa5>] nfs_get_client+0x1cb/0x500 fs/nfs/client.c:425
     [<000000004dc18603>] nfs_init_server+0xc6/0x450 fs/nfs/client.c:671
     [<0000000072615bbf>] nfs_create_server+0x83/0x1f0 fs/nfs/client.c:958
     [<00000000d12e9a98>] nfs_try_mount+0x5a/0x350 fs/nfs/super.c:1883
     [<00000000b2735769>] nfs_fs_mount+0x448/0xc52 fs/nfs/super.c:2719
     [<000000000b19c7d0>] legacy_get_tree+0x27/0x80 fs/fs_context.c:661
     [<00000000d4887a5c>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<000000008eec78b0>] do_new_mount fs/namespace.c:2790 [inline]
     [<000000008eec78b0>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<00000000d0ad59a7>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<0000000082fa14d6>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<0000000082fa14d6>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<0000000082fa14d6>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<00000000ce916bab>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000070865558>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888118ef9360 (size 32):
   comm "syz-executor400", pid 6973, jiffies 4294941906 (age 22.140s)
   hex dump (first 32 bytes):
     00 71 54 04 00 ea ff ff c0 6e 9a 04 00 ea ff ff  .qT......n......
     c0 0b 81 04 00 ea ff ff c0 05 86 04 00 ea ff ff  ................
   backtrace:
     [<000000003e75bb46>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000003e75bb46>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000003e75bb46>] slab_alloc mm/slab.c:3326 [inline]
     [<000000003e75bb46>] __do_kmalloc mm/slab.c:3658 [inline]
     [<000000003e75bb46>] __kmalloc_track_caller+0x15d/0x2c0 mm/slab.c:3675
     [<0000000010f1326b>] kstrdup+0x3a/0x70 mm/util.c:52
     [<0000000070b2f357>] nfs_alloc_client+0xbd/0x170 fs/nfs/client.c:169
     [<000000007f1bdfa5>] nfs_get_client+0x1cb/0x500 fs/nfs/client.c:425
     [<000000004dc18603>] nfs_init_server+0xc6/0x450 fs/nfs/client.c:671
     [<0000000072615bbf>] nfs_create_server+0x83/0x1f0 fs/nfs/client.c:958
     [<00000000d12e9a98>] nfs_try_mount+0x5a/0x350 fs/nfs/super.c:1883
     [<00000000b2735769>] nfs_fs_mount+0x448/0xc52 fs/nfs/super.c:2719
     [<000000000b19c7d0>] legacy_get_tree+0x27/0x80 fs/fs_context.c:661
     [<00000000d4887a5c>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<000000008eec78b0>] do_new_mount fs/namespace.c:2790 [inline]
     [<000000008eec78b0>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<00000000d0ad59a7>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<0000000082fa14d6>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<0000000082fa14d6>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<0000000082fa14d6>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<00000000ce916bab>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000070865558>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888121b91400 (size 1024):
   comm "syz-executor400", pid 6969, jiffies 4294941900 (age 23.180s)
   hex dump (first 32 bytes):
     01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000009c69e9c0>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000009c69e9c0>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000009c69e9c0>] slab_alloc mm/slab.c:3326 [inline]
     [<000000009c69e9c0>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<000000007d1011ce>] kmalloc include/linux/slab.h:547 [inline]
     [<000000007d1011ce>] kzalloc include/linux/slab.h:742 [inline]
     [<000000007d1011ce>] nfs_alloc_client+0x2e/0x170 fs/nfs/client.c:152
     [<000000007f1bdfa5>] nfs_get_client+0x1cb/0x500 fs/nfs/client.c:425
     [<000000004dc18603>] nfs_init_server+0xc6/0x450 fs/nfs/client.c:671
     [<0000000072615bbf>] nfs_create_server+0x83/0x1f0 fs/nfs/client.c:958
     [<00000000d12e9a98>] nfs_try_mount+0x5a/0x350 fs/nfs/super.c:1883
     [<00000000b2735769>] nfs_fs_mount+0x448/0xc52 fs/nfs/super.c:2719
     [<000000000b19c7d0>] legacy_get_tree+0x27/0x80 fs/fs_context.c:661
     [<00000000d4887a5c>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<000000008eec78b0>] do_new_mount fs/namespace.c:2790 [inline]
     [<000000008eec78b0>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<00000000d0ad59a7>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<0000000082fa14d6>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<0000000082fa14d6>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<0000000082fa14d6>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<00000000ce916bab>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000070865558>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811e758400 (size 1024):
   comm "syz-executor400", pid 6973, jiffies 4294941906 (age 23.120s)
   hex dump (first 32 bytes):
     01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000009c69e9c0>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000009c69e9c0>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000009c69e9c0>] slab_alloc mm/slab.c:3326 [inline]
     [<000000009c69e9c0>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<000000007d1011ce>] kmalloc include/linux/slab.h:547 [inline]
     [<000000007d1011ce>] kzalloc include/linux/slab.h:742 [inline]
     [<000000007d1011ce>] nfs_alloc_client+0x2e/0x170 fs/nfs/client.c:152
     [<000000007f1bdfa5>] nfs_get_client+0x1cb/0x500 fs/nfs/client.c:425
     [<000000004dc18603>] nfs_init_server+0xc6/0x450 fs/nfs/client.c:671
     [<0000000072615bbf>] nfs_create_server+0x83/0x1f0 fs/nfs/client.c:958
     [<00000000d12e9a98>] nfs_try_mount+0x5a/0x350 fs/nfs/super.c:1883
     [<00000000b2735769>] nfs_fs_mount+0x448/0xc52 fs/nfs/super.c:2719
     [<000000000b19c7d0>] legacy_get_tree+0x27/0x80 fs/fs_context.c:661
     [<00000000d4887a5c>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<000000008eec78b0>] do_new_mount fs/namespace.c:2790 [inline]
     [<000000008eec78b0>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<00000000d0ad59a7>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<0000000082fa14d6>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<0000000082fa14d6>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<0000000082fa14d6>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<00000000ce916bab>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000070865558>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888118ef9360 (size 32):
   comm "syz-executor400", pid 6973, jiffies 4294941906 (age 23.120s)
   hex dump (first 32 bytes):
     00 71 54 04 00 ea ff ff c0 6e 9a 04 00 ea ff ff  .qT......n......
     c0 0b 81 04 00 ea ff ff c0 05 86 04 00 ea ff ff  ................
   backtrace:
     [<000000003e75bb46>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000003e75bb46>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000003e75bb46>] slab_alloc mm/slab.c:3326 [inline]
     [<000000003e75bb46>] __do_kmalloc mm/slab.c:3658 [inline]
     [<000000003e75bb46>] __kmalloc_track_caller+0x15d/0x2c0 mm/slab.c:3675
     [<0000000010f1326b>] kstrdup+0x3a/0x70 mm/util.c:52
     [<0000000070b2f357>] nfs_alloc_client+0xbd/0x170 fs/nfs/client.c:169
     [<000000007f1bdfa5>] nfs_get_client+0x1cb/0x500 fs/nfs/client.c:425
     [<000000004dc18603>] nfs_init_server+0xc6/0x450 fs/nfs/client.c:671
     [<0000000072615bbf>] nfs_create_server+0x83/0x1f0 fs/nfs/client.c:958
     [<00000000d12e9a98>] nfs_try_mount+0x5a/0x350 fs/nfs/super.c:1883
     [<00000000b2735769>] nfs_fs_mount+0x448/0xc52 fs/nfs/super.c:2719
     [<000000000b19c7d0>] legacy_get_tree+0x27/0x80 fs/fs_context.c:661
     [<00000000d4887a5c>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<000000008eec78b0>] do_new_mount fs/namespace.c:2790 [inline]
     [<000000008eec78b0>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<00000000d0ad59a7>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<0000000082fa14d6>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<0000000082fa14d6>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<0000000082fa14d6>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<00000000ce916bab>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000070865558>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888121b91400 (size 1024):
   comm "syz-executor400", pid 6969, jiffies 4294941900 (age 24.200s)
   hex dump (first 32 bytes):
     01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000009c69e9c0>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000009c69e9c0>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000009c69e9c0>] slab_alloc mm/slab.c:3326 [inline]
     [<000000009c69e9c0>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<000000007d1011ce>] kmalloc include/linux/slab.h:547 [inline]
     [<000000007d1011ce>] kzalloc include/linux/slab.h:742 [inline]
     [<000000007d1011ce>] nfs_alloc_client+0x2e/0x170 fs/nfs/client.c:152
     [<000000007f1bdfa5>] nfs_get_client+0x1cb/0x500 fs/nfs/client.c:425
     [<000000004dc18603>] nfs_init_server+0xc6/0x450 fs/nfs/client.c:671
     [<0000000072615bbf>] nfs_create_server+0x83/0x1f0 fs/nfs/client.c:958
     [<00000000d12e9a98>] nfs_try_mount+0x5a/0x350 fs/nfs/super.c:1883
     [<00000000b2735769>] nfs_fs_mount+0x448/0xc52 fs/nfs/super.c:2719
     [<000000000b19c7d0>] legacy_get_tree+0x27/0x80 fs/fs_context.c:661
     [<00000000d4887a5c>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<000000008eec78b0>] do_new_mount fs/namespace.c:2790 [inline]
     [<000000008eec78b0>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<00000000d0ad59a7>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<0000000082fa14d6>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<0000000082fa14d6>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<0000000082fa14d6>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<00000000ce916bab>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000070865558>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811e758400 (size 1024):
   comm "syz-executor400", pid 6973, jiffies 4294941906 (age 24.140s)
   hex dump (first 32 bytes):
     01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000009c69e9c0>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000009c69e9c0>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000009c69e9c0>] slab_alloc mm/slab.c:3326 [inline]
     [<000000009c69e9c0>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<000000007d1011ce>] kmalloc include/linux/slab.h:547 [inline]
     [<000000007d1011ce>] kzalloc include/linux/slab.h:742 [inline]
     [<000000007d1011ce>] nfs_alloc_client+0x2e/0x170 fs/nfs/client.c:152
     [<000000007f1bdfa5>] nfs_get_client+0x1cb/0x500 fs/nfs/client.c:425
     [<000000004dc18603>] nfs_init_server+0xc6/0x450 fs/nfs/client.c:671
     [<0000000072615bbf>] nfs_create_server+0x83/0x1f0 fs/nfs/client.c:958
     [<00000000d12e9a98>] nfs_try_mount+0x5a/0x350 fs/nfs/super.c:1883
     [<00000000b2735769>] nfs_fs_mount+0x448/0xc52 fs/nfs/super.c:2719
     [<000000000b19c7d0>] legacy_get_tree+0x27/0x80 fs/fs_context.c:661
     [<00000000d4887a5c>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<000000008eec78b0>] do_new_mount fs/namespace.c:2790 [inline]
     [<000000008eec78b0>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<00000000d0ad59a7>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<0000000082fa14d6>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<0000000082fa14d6>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<0000000082fa14d6>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<00000000ce916bab>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000070865558>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888118ef9360 (size 32):
   comm "syz-executor400", pid 6973, jiffies 4294941906 (age 24.140s)
   hex dump (first 32 bytes):
     00 71 54 04 00 ea ff ff c0 6e 9a 04 00 ea ff ff  .qT......n......
     c0 0b 81 04 00 ea ff ff c0 05 86 04 00 ea ff ff  ................
   backtrace:
     [<000000003e75bb46>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000003e75bb46>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000003e75bb46>] slab_alloc mm/slab.c:3326 [inline]
     [<000000003e75bb46>] __do_kmalloc mm/slab.c:3658 [inline]
     [<000000003e75bb46>] __kmalloc_track_caller+0x15d/0x2c0 mm/slab.c:3675
     [<0000000010f1326b>] kstrdup+0x3a/0x70 mm/util.c:52
     [<0000000070b2f357>] nfs_alloc_client+0xbd/0x170 fs/nfs/client.c:169
     [<000000007f1bdfa5>] nfs_get_client+0x1cb/0x500 fs/nfs/client.c:425
     [<000000004dc18603>] nfs_init_server+0xc6/0x450 fs/nfs/client.c:671
     [<0000000072615bbf>] nfs_create_server+0x83/0x1f0 fs/nfs/client.c:958
     [<00000000d12e9a98>] nfs_try_mount+0x5a/0x350 fs/nfs/super.c:1883
     [<00000000b2735769>] nfs_fs_mount+0x448/0xc52 fs/nfs/super.c:2719
     [<000000000b19c7d0>] legacy_get_tree+0x27/0x80 fs/fs_context.c:661
     [<00000000d4887a5c>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<000000008eec78b0>] do_new_mount fs/namespace.c:2790 [inline]
     [<000000008eec78b0>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<00000000d0ad59a7>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<0000000082fa14d6>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<0000000082fa14d6>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<0000000082fa14d6>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<00000000ce916bab>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000070865558>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888121b91400 (size 1024):
   comm "syz-executor400", pid 6969, jiffies 4294941900 (age 25.180s)
   hex dump (first 32 bytes):
     01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000009c69e9c0>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000009c69e9c0>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000009c69e9c0>] slab_alloc mm/slab.c:3326 [inline]
     [<000000009c69e9c0>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<000000007d1011ce>] kmalloc include/linux/slab.h:547 [inline]
     [<000000007d1011ce>] kzalloc include/linux/slab.h:742 [inline]
     [<000000007d1011ce>] nfs_alloc_client+0x2e/0x170 fs/nfs/client.c:152
     [<000000007f1bdfa5>] nfs_get_client+0x1cb/0x500 fs/nfs/client.c:425
     [<000000004dc18603>] nfs_init_server+0xc6/0x450 fs/nfs/client.c:671
     [<0000000072615bbf>] nfs_create_server+0x83/0x1f0 fs/nfs/client.c:958
     [<00000000d12e9a98>] nfs_try_mount+0x5a/0x350 fs/nfs/super.c:1883
     [<00000000b2735769>] nfs_fs_mount+0x448/0xc52 fs/nfs/super.c:2719
     [<000000000b19c7d0>] legacy_get_tree+0x27/0x80 fs/fs_context.c:661
     [<00000000d4887a5c>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<000000008eec78b0>] do_new_mount fs/namespace.c:2790 [inline]
     [<000000008eec78b0>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<00000000d0ad59a7>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<0000000082fa14d6>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<0000000082fa14d6>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<0000000082fa14d6>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<00000000ce916bab>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000070865558>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811e758400 (size 1024):
   comm "syz-executor400", pid 6973, jiffies 4294941906 (age 25.120s)
   hex dump (first 32 bytes):
     01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000009c69e9c0>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000009c69e9c0>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000009c69e9c0>] slab_alloc mm/slab.c:3326 [inline]
     [<000000009c69e9c0>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<000000007d1011ce>] kmalloc include/linux/slab.h:547 [inline]
     [<000000007d1011ce>] kzalloc include/linux/slab.h:742 [inline]
     [<000000007d1011ce>] nfs_alloc_client+0x2e/0x170 fs/nfs/client.c:152
     [<000000007f1bdfa5>] nfs_get_client+0x1cb/0x500 fs/nfs/client.c:425
     [<000000004dc18603>] nfs_init_server+0xc6/0x450 fs/nfs/client.c:671
     [<0000000072615bbf>] nfs_create_server+0x83/0x1f0 fs/nfs/client.c:958
     [<00000000d12e9a98>] nfs_try_mount+0x5a/0x350 fs/nfs/super.c:1883
     [<00000000b2735769>] nfs_fs_mount+0x448/0xc52 fs/nfs/super.c:2719
     [<000000000b19c7d0>] legacy_get_tree+0x27/0x80 fs/fs_context.c:661
     [<00000000d4887a5c>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<000000008eec78b0>] do_new_mount fs/namespace.c:2790 [inline]
     [<000000008eec78b0>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<00000000d0ad59a7>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<0000000082fa14d6>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<0000000082fa14d6>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<0000000082fa14d6>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<00000000ce916bab>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000070865558>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888118ef9360 (size 32):
   comm "syz-executor400", pid 6973, jiffies 4294941906 (age 25.120s)
   hex dump (first 32 bytes):
     00 71 54 04 00 ea ff ff c0 6e 9a 04 00 ea ff ff  .qT......n......
     c0 0b 81 04 00 ea ff ff c0 05 86 04 00 ea ff ff  ................
   backtrace:
     [<000000003e75bb46>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000003e75bb46>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000003e75bb46>] slab_alloc mm/slab.c:3326 [inline]
     [<000000003e75bb46>] __do_kmalloc mm/slab.c:3658 [inline]
     [<000000003e75bb46>] __kmalloc_track_caller+0x15d/0x2c0 mm/slab.c:3675
     [<0000000010f1326b>] kstrdup+0x3a/0x70 mm/util.c:52
     [<0000000070b2f357>] nfs_alloc_client+0xbd/0x170 fs/nfs/client.c:169
     [<000000007f1bdfa5>] nfs_get_client+0x1cb/0x500 fs/nfs/client.c:425
     [<000000004dc18603>] nfs_init_server+0xc6/0x450 fs/nfs/client.c:671
     [<0000000072615bbf>] nfs_create_server+0x83/0x1f0 fs/nfs/client.c:958
     [<00000000d12e9a98>] nfs_try_mount+0x5a/0x350 fs/nfs/super.c:1883
     [<00000000b2735769>] nfs_fs_mount+0x448/0xc52 fs/nfs/super.c:2719
     [<000000000b19c7d0>] legacy_get_tree+0x27/0x80 fs/fs_context.c:661
     [<00000000d4887a5c>] vfs_get_tree+0x2e/0x120 fs/super.c:1476
     [<000000008eec78b0>] do_new_mount fs/namespace.c:2790 [inline]
     [<000000008eec78b0>] do_mount+0x932/0xc50 fs/namespace.c:3110
     [<00000000d0ad59a7>] ksys_mount+0xab/0x120 fs/namespace.c:3319
     [<0000000082fa14d6>] __do_sys_mount fs/namespace.c:3333 [inline]
     [<0000000082fa14d6>] __se_sys_mount fs/namespace.c:3330 [inline]
     [<0000000082fa14d6>] __x64_sys_mount+0x26/0x30 fs/namespace.c:3330
     [<00000000ce916bab>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000070865558>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

executing program


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
