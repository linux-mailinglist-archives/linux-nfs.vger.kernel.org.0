Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73F451A406
	for <lists+linux-nfs@lfdr.de>; Fri, 10 May 2019 22:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfEJUkA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 May 2019 16:40:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727676AbfEJUkA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 10 May 2019 16:40:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9851C81DE6
        for <linux-nfs@vger.kernel.org>; Fri, 10 May 2019 20:39:59 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-112-5.rdu2.redhat.com [10.10.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E069817AC6
        for <linux-nfs@vger.kernel.org>; Fri, 10 May 2019 20:39:58 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: __fput and with silly delegation current_umask()
Date:   Fri, 10 May 2019 16:39:57 -0400
Message-ID: <EF8D5E82-6BDA-45CE-B115-D904422D956A@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 10 May 2019 20:39:59 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A shiney new version is out, and I just had a report of a crash:

[ 2853.916121] BUG: unable to handle kernel NULL pointer dereference at 
000000000000000c
[ 2853.917625] PGD 0 P4D 0
[ 2853.918106] Oops: 0000 [#1] SMP PTI
[ 2853.918761] CPU: 0 PID: 25711 Comm: file_exec.sh Kdump: loaded Not 
tainted 4.18.0-83.el8.x86_64 #1
[ 2853.920406] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[ 2853.921469] RIP: 0010:current_umask+0x15/0x20
[ 2853.922274] Code: 76 48 e9 3e 54 fe ff 90 90 90 90 90 90 90 90 90 90 
90 90 90 90 0f 1f 44 00 00 65 48 8b 04 25 80 5c 01 00 48 8b 80 18 0b 00 
00 <8b> 40 0c c3 0f 1f 80 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41 55
[ 2853.925675] RSP: 0018:ffffa446014d3ba8 EFLAGS: 00010246
[ 2853.926644] RAX: 0000000000000000 RBX: ffff93ccc402e000 RCX: 
0000000500000000
[ 2853.927939] RDX: 0000000000000000 RSI: 0000000500000000 RDI: 
ffff93cd494fa6d8
[ 2853.929200] RBP: ffff93cd494fa680 R08: ffff93cd7ba28160 R09: 
ffff93cd47c02380
[ 2853.930489] R10: ffffe964443aa6c0 R11: ffffffffc0967080 R12: 
0000000000000000
[ 2853.931957] R13: 0000000000000000 R14: ffff93cd54d3e800 R15: 
ffff93ccc4076400
[ 2853.933420] FS:  00007f31147b8740(0000) GS:ffff93cd7ba00000(0000) 
knlGS:0000000000000000
[ 2853.935071] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2853.936262] CR2: 000000000000000c CR3: 000000000aa0a004 CR4: 
00000000007606f0
[ 2853.937730] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[ 2853.939186] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[ 2853.940657] PKRU: 55555554
[ 2853.941226] Call Trace:
[ 2853.941729]  nfs4_opendata_alloc+0x135/0x460 [nfsv4]
[ 2853.942655]  nfs4_open_recoverdata_alloc.isra.59+0x21/0x40 [nfsv4]
[ 2853.943854]  nfs4_open_delegation_recall+0x40/0x140 [nfsv4]
[ 2853.945000]  ? __filemap_fdatawrite_range+0xc8/0xf0
[ 2853.946020]  nfs_end_delegation_return+0x15d/0x390 [nfsv4]
[ 2853.947162]  nfs_complete_unlink+0x15e/0x220 [nfs]
[ 2853.948160]  nfs_dentry_iput+0x37/0x50 [nfs]
[ 2853.949046]  __dentry_kill+0xd5/0x170
[ 2853.949807]  dentry_kill+0x4d/0x190
[ 2853.950537]  dput.part.32+0xcb/0x110
[ 2853.951285]  __fput+0x108/0x220
[ 2853.951942]  task_work_run+0x8a/0xb0
[ 2853.952665]  do_exit+0x2db/0xad0
[ 2853.953266]  ? syscall_trace_enter+0x1d3/0x2c0
[ 2853.954152]  do_group_exit+0x3a/0xa0
[ 2853.954902]  __x64_sys_exit_group+0x14/0x20
[ 2853.955742]  do_syscall_64+0x5b/0x1b0
[ 2853.956422]  entry_SYSCALL_64_after_hwframe+0x65/0xca
[ 2853.957366] RIP: 0033:0x7f3113e76a86
[ 2853.958031] Code: Bad RIP value.
[ 2853.958637] RSP: 002b:00007fff7ab7de18 EFLAGS: 00000246 ORIG_RAX: 
00000000000000e7
[ 2853.960023] RAX: ffffffffffffffda RBX: 00007f3114167740 RCX: 
00007f3113e76a86
[ 2853.961328] RDX: 000000000000007e RSI: 000000000000003c RDI: 
000000000000007e
[ 2853.962636] RBP: 000000000000007e R08: 00000000000000e7 R09: 
ffffffffffffff80
[ 2853.963941] R10: 00007fff7ab7dccc R11: 0000000000000246 R12: 
00007f3114167740
[ 2853.965240] R13: 0000000000000001 R14: 00007f3114170448 R15: 
0000000000000000

The problem seems to be that current->fs = NULL at this point, so
current_umask() in nfs4_opendata_alloc() shouldn't be used in this path. 
  We
do exit_fs before task_work_run starts us cleaning up the inode, so this
isn't /delayed/ __fput, but it does have things happening in the wrong 
order
if we want to use current->fs.

Should we check for this specific case and use a static umask, or maybe 
fix
current_umask() for all delayed fput() paths?  A umask doesn't really 
make
any sense if we're doing doing OPEN with CLAIM_DELEG_CUR_FH..

I'm feeling unhappy with any options that spring to mind.

Any other suggestions?  Maybe the fix will be obvious after a nap...

Ben
