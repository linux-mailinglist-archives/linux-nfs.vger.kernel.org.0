Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85DD236373
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2019 20:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfFESmJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Jun 2019 14:42:09 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:49665 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfFESmI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Jun 2019 14:42:08 -0400
Received: by mail-io1-f71.google.com with SMTP id z15so12358455ioz.16
        for <linux-nfs@vger.kernel.org>; Wed, 05 Jun 2019 11:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5KA20MEac/BauzP5Z3rFMyap7DfHakSuH0HNa8THrMI=;
        b=lTmo0PfTFQb+0Vj5RJusXqyOd1jD1imd8PBI2MDsljcYs4nscHb0AE0NrICIXYC6cz
         xW0RrWnZpmz5mJ9zprTxZgVA2WyzY/dFLL/KIbLHPROr+CxFK7wKKBHl9i+KXyk4Ul0X
         HZd/slR03tCFqWmAOo1IFJsI+iCH+30uBmxkXIUF2k4iu6oZGcvRy/zxZUbuXkoVBn78
         h4b/bS/5Zn8IJE6+6Za/4XhEM40rcs/nMQ2aeu3e7fmLaOWyONlS6+/5bjkdeFTfT5sz
         B17v3jOb0Ae+sGMXNWpDlcEsDU7NG4bXwpkqCbyo+OK4NXco6fSk8Xih8kcKzVIyaNUh
         z/sw==
X-Gm-Message-State: APjAAAUDUIGG872HwVIDDfF2O0mThDWr5Qdy3OmkyfAjLUJpvoy/FUs8
        HpruE8BmU4cu90frtInAt+rGay+xFVBZgXQFkE+HZt77D4se
X-Google-Smtp-Source: APXvYqyQSToVWrtyBHNgFhFwGOm5JXoKFHnoYyxvEB9G9+8LsxYuPtrQVn8OefRIrXAsQWOuxHoYjg0+w1iLcvYseLENP3looVku
MIME-Version: 1.0
X-Received: by 2002:a5d:958d:: with SMTP id a13mr17604654ioo.288.1559760127802;
 Wed, 05 Jun 2019 11:42:07 -0700 (PDT)
Date:   Wed, 05 Jun 2019 11:42:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005a4b99058a97f42e@google.com>
Subject: KASAN: use-after-free Read in unregister_shrinker
From:   syzbot <syzbot+83a43746cebef3508b49@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bfields@fieldses.org,
        bfields@redhat.com, chris@chrisdown.name,
        daniel.m.jordan@oracle.com, guro@fb.com, hannes@cmpxchg.org,
        jlayton@kernel.org, ktkhai@virtuozzo.com, laoar.shao@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, mgorman@techsingularity.net,
        mhocko@suse.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, yang.shi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b2924447 Add linux-next specific files for 20190605
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17e867eea00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4248d6bc70076f7d
dashboard link: https://syzkaller.appspot.com/bug?extid=83a43746cebef3508b49
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1122965aa00000

The bug was bisected to:

commit db17b61765c2c63b9552d316551550557ff0fcfd
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Fri May 17 13:03:38 2019 +0000

     nfsd4: drc containerization

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=110cd22ea00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=130cd22ea00000
console output: https://syzkaller.appspot.com/x/log.txt?x=150cd22ea00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+83a43746cebef3508b49@syzkaller.appspotmail.com
Fixes: db17b61765c2 ("nfsd4: drc containerization")

==================================================================
BUG: KASAN: use-after-free in __list_del_entry_valid+0xe6/0xf5  
lib/list_debug.c:51
Read of size 8 at addr ffff88808a5bd128 by task syz-executor.2/12471

CPU: 0 PID: 12471 Comm: syz-executor.2 Not tainted 5.2.0-rc3-next-20190605  
#9
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0xd4/0x306 mm/kasan/report.c:351
  __kasan_report.cold+0x1b/0x36 mm/kasan/report.c:482
  kasan_report+0x12/0x20 mm/kasan/common.c:614
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  __list_del_entry_valid+0xe6/0xf5 lib/list_debug.c:51
  __list_del_entry include/linux/list.h:117 [inline]
  list_del include/linux/list.h:125 [inline]
  unregister_shrinker+0xb2/0x2e0 mm/vmscan.c:443
  nfsd_reply_cache_shutdown+0x26/0x360 fs/nfsd/nfscache.c:194
  nfsd_exit_net+0x170/0x4b0 fs/nfsd/nfsctl.c:1272
  ops_exit_list.isra.0+0xaa/0x150 net/core/net_namespace.c:154
  setup_net+0x400/0x740 net/core/net_namespace.c:333
  copy_net_ns+0x1df/0x340 net/core/net_namespace.c:439
  create_new_namespaces+0x400/0x7b0 kernel/nsproxy.c:107
  unshare_nsproxy_namespaces+0xc2/0x200 kernel/nsproxy.c:206
  ksys_unshare+0x444/0x980 kernel/fork.c:2718
  __do_sys_unshare kernel/fork.c:2786 [inline]
  __se_sys_unshare kernel/fork.c:2784 [inline]
  __x64_sys_unshare+0x31/0x40 kernel/fork.c:2784
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459279
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f7ae73e1c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000000000459279
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040000000
RBP: 000000000075bfc0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7ae73e26d4
R13: 00000000004c84ef R14: 00000000004decb0 R15: 00000000ffffffff

Allocated by task 12460:
  save_stack+0x23/0x90 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  __kasan_kmalloc mm/kasan/common.c:489 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:462
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:503
  __do_kmalloc mm/slab.c:3654 [inline]
  __kmalloc+0x15c/0x740 mm/slab.c:3663
  kmalloc include/linux/slab.h:552 [inline]
  kzalloc include/linux/slab.h:742 [inline]
  ops_init+0xff/0x410 net/core/net_namespace.c:120
  setup_net+0x2d3/0x740 net/core/net_namespace.c:316
  copy_net_ns+0x1df/0x340 net/core/net_namespace.c:439
  create_new_namespaces+0x400/0x7b0 kernel/nsproxy.c:107
  unshare_nsproxy_namespaces+0xc2/0x200 kernel/nsproxy.c:206
  ksys_unshare+0x444/0x980 kernel/fork.c:2718
  __do_sys_unshare kernel/fork.c:2786 [inline]
  __se_sys_unshare kernel/fork.c:2784 [inline]
  __x64_sys_unshare+0x31/0x40 kernel/fork.c:2784
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 12460:
  save_stack+0x23/0x90 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:451
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:459
  __cache_free mm/slab.c:3426 [inline]
  kfree+0x106/0x2a0 mm/slab.c:3753
  ops_init+0xd1/0x410 net/core/net_namespace.c:135
  setup_net+0x2d3/0x740 net/core/net_namespace.c:316
  copy_net_ns+0x1df/0x340 net/core/net_namespace.c:439
  create_new_namespaces+0x400/0x7b0 kernel/nsproxy.c:107
  unshare_nsproxy_namespaces+0xc2/0x200 kernel/nsproxy.c:206
  ksys_unshare+0x444/0x980 kernel/fork.c:2718
  __do_sys_unshare kernel/fork.c:2786 [inline]
  __se_sys_unshare kernel/fork.c:2784 [inline]
  __x64_sys_unshare+0x31/0x40 kernel/fork.c:2784
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88808a5bcdc0
  which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 872 bytes inside of
  1024-byte region [ffff88808a5bcdc0, ffff88808a5bd1c0)
The buggy address belongs to the page:
page:ffffea0002296f00 refcount:1 mapcount:0 mapping:ffff8880aa400ac0  
index:0x0 compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea000249ea08 ffffea000235a588 ffff8880aa400ac0
raw: 0000000000000000 ffff88808a5bc040 0000000100000007 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88808a5bd000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88808a5bd080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88808a5bd100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                   ^
  ffff88808a5bd180: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff88808a5bd200: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
