Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18CAD24387
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2019 00:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfETWke (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 May 2019 18:40:34 -0400
Received: from mail.prgmr.com ([71.19.149.6]:42688 "EHLO mail.prgmr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfETWkd (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 20 May 2019 18:40:33 -0400
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 May 2019 18:40:28 EDT
Received: from turtle.mx (96-92-68-116-static.hfc.comcastbusiness.net [96.92.68.116])
        (Authenticated sender: adp)
        by mail.prgmr.com (Postfix) with ESMTPSA id EE7CE28C008
        for <linux-nfs@vger.kernel.org>; Mon, 20 May 2019 23:30:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.prgmr.com EE7CE28C008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prgmr.com;
        s=default; t=1558409430;
        bh=t8W8rKCl854TCyzO+Y7XG1AZp2mu9b/yNsrS1l6sWnY=;
        h=Date:From:To:Subject:From;
        b=Nll8+GMAOSy5fX5o93aCpG8i/F7Aox2OKI7mKX6BcPXzPcp5z6iT5zEJygULag+vs
         SNs3Z8V62S0O6/SFGXgSlVvGuRVfIu6uvHTRLDpu74H6OhB0jQuSzM0xlDE2mYuLT5
         BHi2aefFPj3LZbAT44OLRnLa71DNTTfxwcim/7zA=
Received: (qmail 6405 invoked by uid 1353); 20 May 2019 22:33:24 -0000
Date:   Mon, 20 May 2019 16:33:24 -0600
From:   Alan Post <adp@prgmr.com>
To:     linux-nfs@vger.kernel.org
Subject: User process NFS write hang followed by automount hang requiring
 reboot
Message-ID: <20190520223324.GL4158@turtle.email>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k4f25fnPtRuIRUb3"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

I'm working on a compute cluster with approximately 300 NFS
client machines running Linux 4.19.28[1].  These machines accept
user submitted jobs which access exported filesystems from
approximately a dozen NFS servers mostly running Linux 4.4.0 but
a couple running 4.19.28.  In all cases we mount with nfsvers=4.

From time to time one of these user submitted jobs hangs in
uninterruptible sleep (D state) while performing a write to one or
more of these NFS servers, and never complete.  Once this happens
calls to sync will themselves hang in uninterruptible sleep.
Eventually the same thing happens to automount/mount.nfs and by
that point the host is completely irrecoverable.

The problem is more common on our NFS clients when they’re
communicating with an NFS server running 4.19.28, but is not
unique to that NFS server kernel version.

A representative sample of stack traces from hung user-submitted
processes (jobs).  The first here is quite a lot more common than
the later two:

    $ sudo cat /proc/197520/stack
    [<0>] io_schedule+0x12/0x40
    [<0>] nfs_lock_and_join_requests+0x309/0x4c0 [nfs]
    [<0>] nfs_updatepage+0x2a2/0x8b0 [nfs]
    [<0>] nfs_write_end+0x63/0x4c0 [nfs]
    [<0>] generic_perform_write+0x138/0x1b0
    [<0>] nfs_file_write+0xdc/0x200 [nfs]
    [<0>] new_sync_write+0xfb/0x160
    [<0>] vfs_write+0xa5/0x1a0
    [<0>] ksys_write+0x4f/0xb0
    [<0>] do_syscall_64+0x53/0x100
    [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
    [<0>] 0xffffffffffffffff


    $ sudo cat /proc/120744/stack
    [<0>] rpc_wait_bit_killable+0x1e/0x90 [sunrpc]
    [<0>] nfs4_do_close+0x27d/0x300 [nfsv4]
    [<0>] __put_nfs_open_context+0xb9/0x110 [nfs]
    [<0>] nfs_file_release+0x39/0x40 [nfs]
    [<0>] __fput+0xb4/0x220
    [<0>] task_work_run+0x8a/0xb0
    [<0>] do_exit+0x2d7/0xb90
    [<0>] do_group_exit+0x3a/0xa0
    [<0>] get_signal+0x12e/0x720
    [<0>] do_signal+0x36/0x6d0
    [<0>] exit_to_usermode_loop+0x89/0xf0
    [<0>] do_syscall_64+0xfd/0x100
    [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
    [<0>] 0xffffffffffffffff


    $ sudo cat /proc/231018/stack
    [<0>] io_schedule+0x12/0x40
    [<0>] wait_on_page_bit_common+0xfd/0x180
    [<0>] __filemap_fdatawait_range+0xe1/0x130
    [<0>] filemap_write_and_wait_range+0x45/0x80
    [<0>] nfs_file_fsync+0x44/0x1e0 [nfs]
    [<0>] filp_close+0x31/0x60
    [<0>] __x64_sys_close+0x1e/0x50
    [<0>] do_syscall_64+0x53/0x100
    [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
    [<0>] 0xffffffffffffffff


All of these processes are user-submitted jobs that are expected to
be doing NFS writes and would under normal circumstances succeed
rather than hang.  In each case, despite the variation in the
stack traces, the problem as described in this message occurred
leading to the host being closed, drained, and reboot.

After the above D state process, sync will also hang in
uninterruptible sleep (D) with the following stack:

    $ sudo cat /proc/164581/stack
    [<0>] io_schedule+0x12/0x40
    [<0>] wait_on_page_bit_common+0xfd/0x180
    [<0>] __filemap_fdatawait_range+0xd5/0x130
    [<0>] filemap_fdatawait_keep_errors+0x1a/0x40
    [<0>] sync_inodes_sb+0x21d/0x2b0
    [<0>] iterate_supers+0x98/0x100
    [<0>] ksys_sync+0x40/0xb0
    [<0>] __ia32_sys_sync+0xa/0x10
    [<0>] do_syscall_64+0x55/0x110
    [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
    [<0>] 0xffffffffffffffff


Further sync processes will hang waiting for this sync to complete.
For one instance of this issue, I used sysrq to dump all tasks in
uninterruptible sleep.  That output is attached, as it shows more
detailed stack traces than are available from /proc/<pid>/stack.

We found a promising discussion in the following threads:

    https://marc.info/?l=linux-nfs&m=154835352315685&w=2
    https://marc.info/?l=linux-nfs&m=154836054918954&w=2

But after building a 4.20.9 kernel and applying deaa5c9 (SUNRPC:
Address Kerberos performance/behavior regression) we still get
hangs on write.  Do any of you have anything to suggest or see
something promising in these stack traces?

-A

1: In testing, I have observed this problem on our NFS clients
   running Linux 3.13.0, Linux 4.17.17, Linux 4.18.10, Linux 4.19.28,
   and Linux 4.20.9.
-- 
Alan Post | Xen VPS hosting for the technically adept
PO Box 61688 | Sunnyvale, CA 94088-1681 | https://prgmr.com/
email: adp@prgmr.com

--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sysrq

[958790.055075] sysrq: SysRq : Show Blocked State
[958790.059508]   task                        PC stack   pid father
[958790.069182] job1            D    0 144220      1 0x00000084
[958790.074781] Call Trace:
[958790.077290]  ? __schedule+0x2a2/0x870
[958790.081000]  schedule+0x28/0x80
[958790.084196]  io_schedule+0x12/0x40
[958790.087652]  wait_on_page_bit_common+0xfd/0x180
[958790.092246]  ? page_cache_tree_insert+0xe0/0xe0
[958790.096817]  __filemap_fdatawait_range+0xe1/0x130
[958790.101557]  filemap_write_and_wait_range+0x45/0x80
[958790.106508]  nfs_file_fsync+0x44/0x1e0 [nfs]
[958790.110834]  filp_close+0x31/0x60
[958790.114196]  __x64_sys_close+0x1e/0x50
[958790.117995]  do_syscall_64+0x53/0x100
[958790.121716]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958790.126812] RIP: 0033:0x155553ad8a1b
[958790.130461] Code: Bad RIP value.
[958790.133736] RSP: 002b:00007fffffef8418 EFLAGS: 00000206 ORIG_RAX: 0000000000000003
[958790.141308] RAX: ffffffffffffffda RBX: 000000000b54e5a0 RCX: 0000155553ad8a1b
[958790.148449] RDX: 0000155553dfc900 RSI: 000000000b650db0 RDI: 0000000000000016
[958790.155589] RBP: 0000155553dfd440 R08: 00001555555349c0 R09: 000000001074a9e0
[958790.162730] R10: 00000000000000b4 R11: 0000000000000206 R12: 0000000000000000
[958790.169872] R13: 000000001001a7b0 R14: 00007fffffef8460 R15: 000000000e782638
[958790.177035] sync            D    0 172932      1 0x00000084
[958790.182668] Call Trace:
[958790.185171]  ? __schedule+0x2a2/0x870
[958790.188881]  ? __switch_to_asm+0x40/0x70
[958790.192848]  ? __switch_to_asm+0x34/0x70
[958790.196816]  schedule+0x28/0x80
[958790.200011]  io_schedule+0x12/0x40
[958790.203478]  wait_on_page_bit_common+0xfd/0x180
[958790.208046]  ? page_cache_tree_insert+0xe0/0xe0
[958790.212612]  __filemap_fdatawait_range+0xe1/0x130
[958790.217354]  filemap_fdatawait_keep_errors+0x1a/0x40
[958790.222351]  sync_inodes_sb+0x22d/0x2c0
[958790.226229]  ? default_file_splice_write+0x20/0x20
[958790.231056]  iterate_supers+0x98/0x120
[958790.234850]  ksys_sync+0x40/0xb0
[958790.238130]  __ia32_sys_sync+0xa/0x10
[958790.241841]  do_syscall_64+0x53/0x100
[958790.245561]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958790.250656] RIP: 0033:0x7f3c80158577
[958790.254283] Code: Bad RIP value.
[958790.257564] RSP: 002b:00007ffe8abae448 EFLAGS: 00000206 ORIG_RAX: 00000000000000a2
[958790.265138] RAX: ffffffffffffffda RBX: 00007ffe8abae578 RCX: 00007f3c80158577
[958790.272289] RDX: 00007f3c80412e01 RSI: 00007ffe8abae578 RDI: 00007f3c801da038
[958790.279430] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[958790.286573] R10: 000000000000081f R11: 0000000000000206 R12: 0000000000000001
[958790.293715] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[958790.300889] sync            D    0 187416      1 0x00000084
[958790.306489] Call Trace:
[958790.308997]  ? __schedule+0x2a2/0x870
[958790.312738]  ? __switch_to_asm+0x34/0x70
[958790.316710]  schedule+0x28/0x80
[958790.319913]  schedule_preempt_disabled+0xa/0x10
[958790.324495]  __mutex_lock.isra.5+0x2cc/0x4b0
[958790.328805]  ? finish_wait+0x3c/0x80
[958790.332441]  ? wb_wait_for_completion+0x7f/0x90
[958790.337022]  ? default_file_splice_write+0x20/0x20
[958790.341862]  sync_inodes_sb+0x11e/0x2c0
[958790.345757]  ? default_file_splice_write+0x20/0x20
[958790.350596]  iterate_supers+0x98/0x120
[958790.354407]  ksys_sync+0x40/0xb0
[958790.357698]  __ia32_sys_sync+0xa/0x10
[958790.361422]  do_syscall_64+0x53/0x100
[958790.365147]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958790.370227] RIP: 0033:0x7f9dfc4a9577
[958790.373880] Code: Bad RIP value.
[958790.377158] RSP: 002b:00007fff6cde2c28 EFLAGS: 00000206 ORIG_RAX: 00000000000000a2
[958790.384745] RAX: ffffffffffffffda RBX: 00007fff6cde2d58 RCX: 00007f9dfc4a9577
[958790.391901] RDX: 00007f9dfc763e01 RSI: 00007fff6cde2d58 RDI: 00007f9dfc52b038
[958790.399059] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[958790.406214] R10: 000000000000081f R11: 0000000000000206 R12: 0000000000000001
[958790.413369] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[958790.420544] sync            D    0 191627      1 0x00000084
[958790.426143] Call Trace:
[958790.428682]  ? __schedule+0x2a2/0x870
[958790.432390]  ? __switch_to_asm+0x34/0x70
[958790.436368]  schedule+0x28/0x80
[958790.439609]  schedule_preempt_disabled+0xa/0x10
[958790.444175]  __mutex_lock.isra.5+0x2cc/0x4b0
[958790.448516]  ? finish_wait+0x3c/0x80
[958790.452136]  ? wb_wait_for_completion+0x7f/0x90
[958790.456721]  ? default_file_splice_write+0x20/0x20
[958790.461557]  sync_inodes_sb+0x11e/0x2c0
[958790.465452]  ? default_file_splice_write+0x20/0x20
[958790.470290]  iterate_supers+0x98/0x120
[958790.474098]  ksys_sync+0x40/0xb0
[958790.477413]  __ia32_sys_sync+0xa/0x10
[958790.481122]  do_syscall_64+0x53/0x100
[958790.484844]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958790.489947] RIP: 0033:0x7f815dd3f577
[958790.493603] Code: Bad RIP value.
[958790.496881] RSP: 002b:00007ffccb663778 EFLAGS: 00000206 ORIG_RAX: 00000000000000a2
[958790.504467] RAX: ffffffffffffffda RBX: 00007ffccb6638a8 RCX: 00007f815dd3f577
[958790.511621] RDX: 00007f815dff9e01 RSI: 00007ffccb6638a8 RDI: 00007f815ddc1038
[958790.518777] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[958790.525930] R10: 000000000000081f R11: 0000000000000206 R12: 0000000000000001
[958790.533084] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[958790.540259] sync            D    0 197099      1 0x00000084
[958790.545852] Call Trace:
[958790.548390]  ? __schedule+0x2a2/0x870
[958790.552098]  ? __switch_to_asm+0x34/0x70
[958790.556077]  schedule+0x28/0x80
[958790.559284]  schedule_preempt_disabled+0xa/0x10
[958790.563863]  __mutex_lock.isra.5+0x2cc/0x4b0
[958790.568218]  ? finish_wait+0x3c/0x80
[958790.571839]  ? wb_wait_for_completion+0x7f/0x90
[958790.576423]  ? default_file_splice_write+0x20/0x20
[958790.581261]  sync_inodes_sb+0x11e/0x2c0
[958790.585156]  ? default_file_splice_write+0x20/0x20
[958790.589996]  iterate_supers+0x98/0x120
[958790.593805]  ksys_sync+0x40/0xb0
[958790.597099]  __ia32_sys_sync+0xa/0x10
[958790.600841]  do_syscall_64+0x53/0x100
[958790.604548]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958790.609644] RIP: 0033:0x7ff61ce85577
[958790.613297] Code: Bad RIP value.
[958790.616575] RSP: 002b:00007ffe446fc3c8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a2
[958790.624161] RAX: ffffffffffffffda RBX: 00007ffe446fc4f8 RCX: 00007ff61ce85577
[958790.631315] RDX: 00007ff61d13fe01 RSI: 00007ffe446fc4f8 RDI: 00007ff61cf07038
[958790.638473] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[958790.645626] R10: 000000000000081f R11: 0000000000000202 R12: 0000000000000001
[958790.652780] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[958790.659956] sync            D    0 201310      1 0x00000084
[958790.665571] Call Trace:
[958790.668095]  ? __schedule+0x2a2/0x870
[958790.671803]  ? __switch_to_asm+0x34/0x70
[958790.675785]  schedule+0x28/0x80
[958790.678992]  schedule_preempt_disabled+0xa/0x10
[958790.683574]  __mutex_lock.isra.5+0x2cc/0x4b0
[958790.687899]  ? finish_wait+0x3c/0x80
[958790.691534]  ? _cond_resched+0x15/0x30
[958790.695376]  ? wb_wait_for_completion+0x29/0x90
[958790.699961]  ? default_file_splice_write+0x20/0x20
[958790.704783]  sync_inodes_sb+0x11e/0x2c0
[958790.708677]  ? default_file_splice_write+0x20/0x20
[958790.713536]  iterate_supers+0x98/0x120
[958790.717327]  ksys_sync+0x40/0xb0
[958790.720619]  __ia32_sys_sync+0xa/0x10
[958790.724362]  do_syscall_64+0x53/0x100
[958790.728087]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958790.733167] RIP: 0033:0x7f6837c78577
[958790.736806] Code: Bad RIP value.
[958790.740097] RSP: 002b:00007ffd0af7d7a8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a2
[958790.747683] RAX: ffffffffffffffda RBX: 00007ffd0af7d8d8 RCX: 00007f6837c78577
[958790.754837] RDX: 00007f6837f32e01 RSI: 00007ffd0af7d8d8 RDI: 00007f6837cfa038
[958790.761993] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[958790.769149] R10: 000000000000081f R11: 0000000000000202 R12: 0000000000000001
[958790.776303] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[958790.783478] sync            D    0 205411      1 0x00000084
[958790.789077] Call Trace:
[958790.791604]  ? __schedule+0x2a2/0x870
[958790.795333]  ? __switch_to_asm+0x34/0x70
[958790.799315]  schedule+0x28/0x80
[958790.802524]  schedule_preempt_disabled+0xa/0x10
[958790.807117]  __mutex_lock.isra.5+0x2cc/0x4b0
[958790.811460]  ? finish_wait+0x3c/0x80
[958790.815082]  ? _cond_resched+0x15/0x30
[958790.818889]  ? wb_wait_for_completion+0x29/0x90
[958790.823505]  ? default_file_splice_write+0x20/0x20
[958790.828330]  sync_inodes_sb+0x11e/0x2c0
[958790.832225]  ? default_file_splice_write+0x20/0x20
[958790.837090]  iterate_supers+0x98/0x120
[958790.840883]  ksys_sync+0x40/0xb0
[958790.844174]  __ia32_sys_sync+0xa/0x10
[958790.847913]  do_syscall_64+0x53/0x100
[958790.851637]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958790.856717] RIP: 0033:0x7f1bfe4d6577
[958790.860372] Code: Bad RIP value.
[958790.863648] RSP: 002b:00007ffce94bd188 EFLAGS: 00000206 ORIG_RAX: 00000000000000a2
[958790.871236] RAX: ffffffffffffffda RBX: 00007ffce94bd2b8 RCX: 00007f1bfe4d6577
[958790.878391] RDX: 00007f1bfe790e01 RSI: 00007ffce94bd2b8 RDI: 00007f1bfe558038
[958790.885547] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[958790.892702] R10: 000000000000081f R11: 0000000000000206 R12: 0000000000000001
[958790.899863] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[958790.907041] sync            D    0 205477 232152 0x00000080
[958790.912640] Call Trace:
[958790.915178]  ? __schedule+0x2a2/0x870
[958790.918884]  ? __switch_to_asm+0x34/0x70
[958790.922865]  schedule+0x28/0x80
[958790.926068]  schedule_preempt_disabled+0xa/0x10
[958790.930634]  __mutex_lock.isra.5+0x2cc/0x4b0
[958790.934959]  ? finish_wait+0x3c/0x80
[958790.938596]  ? wb_wait_for_completion+0x7f/0x90
[958790.943178]  ? default_file_splice_write+0x20/0x20
[958790.948016]  sync_inodes_sb+0x11e/0x2c0
[958790.951948]  ? default_file_splice_write+0x20/0x20
[958790.956771]  iterate_supers+0x98/0x120
[958790.960578]  ksys_sync+0x40/0xb0
[958790.963873]  __ia32_sys_sync+0xa/0x10
[958790.967596]  do_syscall_64+0x53/0x100
[958790.971319]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958790.976415] RIP: 0033:0x14d7112ce577
[958790.980073] Code: Bad RIP value.
[958790.983351] RSP: 002b:00007fff8a0910c8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a2
[958790.990937] RAX: ffffffffffffffda RBX: 00007fff8a0911f8 RCX: 000014d7112ce577
[958790.998094] RDX: 000014d711588e01 RSI: 00007fff8a0911f8 RDI: 000014d711350038
[958791.005255] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[958791.012431] R10: 000000000000081f R11: 0000000000000202 R12: 0000000000000001
[958791.019569] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[958791.026745] sync            D    0 210857      1 0x00000084
[958791.032343] Call Trace:
[958791.034883]  ? __schedule+0x2a2/0x870
[958791.038590]  ? __switch_to_asm+0x34/0x70
[958791.042570]  schedule+0x28/0x80
[958791.045773]  schedule_preempt_disabled+0xa/0x10
[958791.050339]  __mutex_lock.isra.5+0x2cc/0x4b0
[958791.054664]  ? finish_wait+0x3c/0x80
[958791.058294]  ? _cond_resched+0x15/0x30
[958791.062106]  ? wb_wait_for_completion+0x29/0x90
[958791.066675]  ? default_file_splice_write+0x20/0x20
[958791.071512]  sync_inodes_sb+0x11e/0x2c0
[958791.075408]  ? default_file_splice_write+0x20/0x20
[958791.080296]  iterate_supers+0x98/0x120
[958791.084117]  ksys_sync+0x40/0xb0
[958791.087394]  __ia32_sys_sync+0xa/0x10
[958791.091134]  do_syscall_64+0x53/0x100
[958791.094875]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958791.099959] RIP: 0033:0x7f956d6c9577
[958791.103613] Code: Bad RIP value.
[958791.106890] RSP: 002b:00007ffcb2e0a228 EFLAGS: 00000206 ORIG_RAX: 00000000000000a2
[958791.114484] RAX: ffffffffffffffda RBX: 00007ffcb2e0a358 RCX: 00007f956d6c9577
[958791.121624] RDX: 00007f956d983e01 RSI: 00007ffcb2e0a358 RDI: 00007f956d74b038
[958791.128783] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[958791.135936] R10: 000000000000081f R11: 0000000000000206 R12: 0000000000000001
[958791.143091] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[958791.150268] sync            D    0 215207      1 0x00000084
[958791.155879] Call Trace:
[958791.158404]  ? __schedule+0x2a2/0x870
[958791.162107]  ? __switch_to_asm+0x34/0x70
[958791.166091]  schedule+0x28/0x80
[958791.169281]  schedule_preempt_disabled+0xa/0x10
[958791.173862]  __mutex_lock.isra.5+0x2cc/0x4b0
[958791.178206]  ? finish_wait+0x3c/0x80
[958791.181825]  ? _cond_resched+0x15/0x30
[958791.185634]  ? wb_wait_for_completion+0x29/0x90
[958791.190215]  ? default_file_splice_write+0x20/0x20
[958791.195052]  sync_inodes_sb+0x11e/0x2c0
[958791.198947]  ? default_file_splice_write+0x20/0x20
[958791.203787]  iterate_supers+0x98/0x120
[958791.207631]  ksys_sync+0x40/0xb0
[958791.210910]  __ia32_sys_sync+0xa/0x10
[958791.214651]  do_syscall_64+0x53/0x100
[958791.218377]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958791.223457] RIP: 0033:0x7ff75a1a5577
[958791.227098] Code: Bad RIP value.
[958791.230391] RSP: 002b:00007ffe71276398 EFLAGS: 00000202 ORIG_RAX: 00000000000000a2
[958791.237981] RAX: ffffffffffffffda RBX: 00007ffe712764c8 RCX: 00007ff75a1a5577
[958791.245135] RDX: 00007ff75a45fe01 RSI: 00007ffe712764c8 RDI: 00007ff75a227038
[958791.252309] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[958791.259448] R10: 000000000000081f R11: 0000000000000202 R12: 0000000000000001
[958791.266607] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[958791.273784] sync            D    0 224997      1 0x00000084
[958791.279383] Call Trace:
[958791.281908]  ? __schedule+0x2a2/0x870
[958791.285615]  ? __switch_to_asm+0x34/0x70
[958791.289595]  schedule+0x28/0x80
[958791.292801]  schedule_preempt_disabled+0xa/0x10
[958791.297381]  __mutex_lock.isra.5+0x2cc/0x4b0
[958791.301720]  ? finish_wait+0x3c/0x80
[958791.305342]  ? wb_wait_for_completion+0x7f/0x90
[958791.309926]  ? default_file_splice_write+0x20/0x20
[958791.314765]  sync_inodes_sb+0x11e/0x2c0
[958791.318663]  ? default_file_splice_write+0x20/0x20
[958791.323488]  iterate_supers+0x98/0x120
[958791.327316]  ksys_sync+0x40/0xb0
[958791.330593]  __ia32_sys_sync+0xa/0x10
[958791.334298]  do_syscall_64+0x53/0x100
[958791.338042]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958791.343122] RIP: 0033:0x7fc39df86577
[958791.346777] Code: Bad RIP value.
[958791.350048] RSP: 002b:00007ffc44f36ae8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a2
[958791.357619] RAX: ffffffffffffffda RBX: 00007ffc44f36c18 RCX: 00007fc39df86577
[958791.364775] RDX: 00007fc39e240e01 RSI: 00007ffc44f36c18 RDI: 00007fc39e008038
[958791.371932] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[958791.379087] R10: 000000000000081f R11: 0000000000000206 R12: 0000000000000001
[958791.386240] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[958791.393416] sync            D    0 231405      1 0x00000084
[958791.399013] Call Trace:
[958791.401533]  ? __schedule+0x2a2/0x870
[958791.405240]  ? __switch_to_asm+0x34/0x70
[958791.409239]  schedule+0x28/0x80
[958791.412429]  schedule_preempt_disabled+0xa/0x10
[958791.417012]  __mutex_lock.isra.5+0x2cc/0x4b0
[958791.421338]  ? finish_wait+0x3c/0x80
[958791.424976]  ? _cond_resched+0x15/0x30
[958791.428784]  ? wb_wait_for_completion+0x29/0x90
[958791.433382]  ? default_file_splice_write+0x20/0x20
[958791.438206]  sync_inodes_sb+0x11e/0x2c0
[958791.442100]  ? default_file_splice_write+0x20/0x20
[958791.446939]  iterate_supers+0x98/0x120
[958791.450750]  ksys_sync+0x40/0xb0
[958791.454039]  __ia32_sys_sync+0xa/0x10
[958791.457748]  do_syscall_64+0x53/0x100
[958791.461504]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958791.466608] RIP: 0033:0x7fb4594b1577
[958791.470226] Code: Bad RIP value.
[958791.473503] RSP: 002b:00007ffce4b212f8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a2
[958791.481088] RAX: ffffffffffffffda RBX: 00007ffce4b21428 RCX: 00007fb4594b1577
[958791.488242] RDX: 00007fb45976be01 RSI: 00007ffce4b21428 RDI: 00007fb459533038
[958791.495397] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[958791.502553] R10: 000000000000081f R11: 0000000000000202 R12: 0000000000000001
[958791.509709] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[958791.516886] sync            D    0 236485      1 0x00000084
[958791.522483] Call Trace:
[958791.525002]  ? __schedule+0x2a2/0x870
[958791.528709]  ? __switch_to_asm+0x34/0x70
[958791.532689]  schedule+0x28/0x80
[958791.535896]  schedule_preempt_disabled+0xa/0x10
[958791.540494]  __mutex_lock.isra.5+0x2cc/0x4b0
[958791.544803]  ? finish_wait+0x3c/0x80
[958791.548441]  ? wb_wait_for_completion+0x7f/0x90
[958791.553023]  ? default_file_splice_write+0x20/0x20
[958791.557861]  sync_inodes_sb+0x11e/0x2c0
[958791.561755]  ? default_file_splice_write+0x20/0x20
[958791.566612]  iterate_supers+0x98/0x120
[958791.570407]  ksys_sync+0x40/0xb0
[958791.573696]  __ia32_sys_sync+0xa/0x10
[958791.577420]  do_syscall_64+0x53/0x100
[958791.581127]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958791.586222] RIP: 0033:0x7f856fc67577
[958791.589859] Code: Bad RIP value.
[958791.593150] RSP: 002b:00007ffdbc60c038 EFLAGS: 00000202 ORIG_RAX: 00000000000000a2
[958791.600769] RAX: ffffffffffffffda RBX: 00007ffdbc60c168 RCX: 00007f856fc67577
[958791.607910] RDX: 00007f856ff21e01 RSI: 00007ffdbc60c168 RDI: 00007f856fce9038
[958791.615068] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[958791.622223] R10: 000000000000081f R11: 0000000000000202 R12: 0000000000000001
[958791.629379] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[958791.636554] sync            D    0 240763      1 0x00000084
[958791.642148] Call Trace:
[958791.644686]  ? __schedule+0x2a2/0x870
[958791.648394]  ? __switch_to_asm+0x34/0x70
[958791.652374]  schedule+0x28/0x80
[958791.655580]  schedule_preempt_disabled+0xa/0x10
[958791.660161]  __mutex_lock.isra.5+0x2cc/0x4b0
[958791.664484]  ? finish_wait+0x3c/0x80
[958791.668121]  ? wb_wait_for_completion+0x7f/0x90
[958791.672720]  ? default_file_splice_write+0x20/0x20
[958791.677541]  sync_inodes_sb+0x11e/0x2c0
[958791.681435]  ? default_file_splice_write+0x20/0x20
[958791.686274]  iterate_supers+0x98/0x120
[958791.690083]  ksys_sync+0x40/0xb0
[958791.693375]  __ia32_sys_sync+0xa/0x10
[958791.697099]  do_syscall_64+0x53/0x100
[958791.700838]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958791.705920] RIP: 0033:0x7f7efba75577
[958791.709557] Code: Bad RIP value.
[958791.712851] RSP: 002b:00007ffce9d9aa98 EFLAGS: 00000202 ORIG_RAX: 00000000000000a2
[958791.720435] RAX: ffffffffffffffda RBX: 00007ffce9d9abc8 RCX: 00007f7efba75577
[958791.727624] RDX: 00007f7efbd2fe01 RSI: 00007ffce9d9abc8 RDI: 00007f7efbaf7038
[958791.734763] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[958791.741916] R10: 000000000000081f R11: 0000000000000202 R12: 0000000000000001
[958791.749072] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[958791.756246] sync            D    0 246022      1 0x00000084
[958791.761840] Call Trace:
[958791.764364]  ? __schedule+0x2a2/0x870
[958791.768070]  ? __switch_to_asm+0x34/0x70
[958791.772052]  schedule+0x28/0x80
[958791.775259]  schedule_preempt_disabled+0xa/0x10
[958791.779840]  __mutex_lock.isra.5+0x2cc/0x4b0
[958791.784163]  ? finish_wait+0x3c/0x80
[958791.787799]  ? wb_wait_for_completion+0x7f/0x90
[958791.792382]  ? default_file_splice_write+0x20/0x20
[958791.797220]  sync_inodes_sb+0x11e/0x2c0
[958791.801115]  ? default_file_splice_write+0x20/0x20
[958791.805955]  iterate_supers+0x98/0x120
[958791.809764]  ksys_sync+0x40/0xb0
[958791.813060]  __ia32_sys_sync+0xa/0x10
[958791.816782]  do_syscall_64+0x53/0x100
[958791.820522]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958791.825603] RIP: 0033:0x7fc5a836b577
[958791.829240] Code: Bad RIP value.
[958791.832533] RSP: 002b:00007ffc075a3a68 EFLAGS: 00000202 ORIG_RAX: 00000000000000a2
[958791.840119] RAX: ffffffffffffffda RBX: 00007ffc075a3b98 RCX: 00007fc5a836b577
[958791.847272] RDX: 00007fc5a8625e01 RSI: 00007ffc075a3b98 RDI: 00007fc5a83ed038
[958791.854459] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[958791.861598] R10: 000000000000081f R11: 0000000000000202 R12: 0000000000000001
[958791.868754] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[958791.875931] sync            D    0 250291      1 0x00000084
[958791.881526] Call Trace:
[958791.884064]  ? __schedule+0x2a2/0x870
[958791.887770]  ? __switch_to_asm+0x34/0x70
[958791.891749]  schedule+0x28/0x80
[958791.894955]  schedule_preempt_disabled+0xa/0x10
[958791.899536]  __mutex_lock.isra.5+0x2cc/0x4b0
[958791.903861]  ? finish_wait+0x3c/0x80
[958791.907497]  ? wb_wait_for_completion+0x7f/0x90
[958791.912080]  ? default_file_splice_write+0x20/0x20
[958791.916918]  sync_inodes_sb+0x11e/0x2c0
[958791.920812]  ? default_file_splice_write+0x20/0x20
[958791.925652]  iterate_supers+0x98/0x120
[958791.929460]  ksys_sync+0x40/0xb0
[958791.932752]  __ia32_sys_sync+0xa/0x10
[958791.936476]  do_syscall_64+0x53/0x100
[958791.940200]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958791.945295] RIP: 0033:0x7fbf6061a577
[958791.948932] Code: Bad RIP value.
[958791.952224] RSP: 002b:00007fffd82eb588 EFLAGS: 00000206 ORIG_RAX: 00000000000000a2
[958791.959809] RAX: ffffffffffffffda RBX: 00007fffd82eb6b8 RCX: 00007fbf6061a577
[958791.966966] RDX: 00007fbf608d4e01 RSI: 00007fffd82eb6b8 RDI: 00007fbf6069c038
[958791.974121] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[958791.981279] R10: 000000000000081f R11: 0000000000000206 R12: 0000000000000001
[958791.988467] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[958791.995626] sync            D    0 255645      1 0x00000084
[958792.001222] Call Trace:
[958792.003761]  ? __schedule+0x2a2/0x870
[958792.007467]  ? __switch_to_asm+0x34/0x70
[958792.011447]  schedule+0x28/0x80
[958792.014656]  schedule_preempt_disabled+0xa/0x10
[958792.019237]  __mutex_lock.isra.5+0x2cc/0x4b0
[958792.023579]  ? finish_wait+0x3c/0x80
[958792.027203]  ? wb_wait_for_completion+0x7f/0x90
[958792.031785]  ? default_file_splice_write+0x20/0x20
[958792.036623]  sync_inodes_sb+0x11e/0x2c0
[958792.040503]  ? default_file_splice_write+0x20/0x20
[958792.045342]  iterate_supers+0x98/0x120
[958792.049150]  ksys_sync+0x40/0xb0
[958792.052443]  __ia32_sys_sync+0xa/0x10
[958792.056166]  do_syscall_64+0x53/0x100
[958792.059888]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958792.064985] RIP: 0033:0x7f2413661577
[958792.068639] Code: Bad RIP value.
[958792.071915] RSP: 002b:00007ffeb235e638 EFLAGS: 00000202 ORIG_RAX: 00000000000000a2
[958792.079500] RAX: ffffffffffffffda RBX: 00007ffeb235e768 RCX: 00007f2413661577
[958792.086657] RDX: 00007f241391be01 RSI: 00007ffeb235e768 RDI: 00007f24136e3038
[958792.093798] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[958792.100955] R10: 000000000000081f R11: 0000000000000202 R12: 0000000000000001
[958792.108110] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[958792.115305] sync            D    0 259662      1 0x00000084
[958792.120901] Call Trace:
[958792.123453]  ? __schedule+0x2a2/0x870
[958792.127164]  ? __switch_to_asm+0x34/0x70
[958792.131143]  schedule+0x28/0x80
[958792.134346]  schedule_preempt_disabled+0xa/0x10
[958792.138911]  __mutex_lock.isra.5+0x2cc/0x4b0
[958792.143251]  ? finish_wait+0x3c/0x80
[958792.146872]  ? wb_wait_for_completion+0x7f/0x90
[958792.151454]  ? default_file_splice_write+0x20/0x20
[958792.156290]  sync_inodes_sb+0x11e/0x2c0
[958792.160182]  ? default_file_splice_write+0x20/0x20
[958792.165021]  iterate_supers+0x98/0x120
[958792.168828]  ksys_sync+0x40/0xb0
[958792.172137]  __ia32_sys_sync+0xa/0x10
[958792.175845]  do_syscall_64+0x53/0x100
[958792.179568]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958792.184662] RIP: 0033:0x7fbe99f9f577
[958792.188316] Code: Bad RIP value.
[958792.191591] RSP: 002b:00007ffdf7a52af8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a2
[958792.199175] RAX: ffffffffffffffda RBX: 00007ffdf7a52c28 RCX: 00007fbe99f9f577
[958792.206340] RDX: 00007fbe9a259e01 RSI: 00007ffdf7a52c28 RDI: 00007fbe9a021038
[958792.213495] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[958792.220651] R10: 000000000000081f R11: 0000000000000202 R12: 0000000000000001
[958792.227807] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[958792.234982] sync            D    0  2337      1 0x00000084
[958792.240492] Call Trace:
[958792.243049]  ? __schedule+0x2a2/0x870
[958792.246757]  ? __switch_to_asm+0x34/0x70
[958792.250745]  schedule+0x28/0x80
[958792.253947]  schedule_preempt_disabled+0xa/0x10
[958792.258513]  __mutex_lock.isra.5+0x2cc/0x4b0
[958792.262821]  ? finish_wait+0x3c/0x80
[958792.266468]  ? wb_wait_for_completion+0x7f/0x90
[958792.271035]  ? default_file_splice_write+0x20/0x20
[958792.275873]  sync_inodes_sb+0x11e/0x2c0
[958792.279767]  ? default_file_splice_write+0x20/0x20
[958792.284605]  iterate_supers+0x98/0x120
[958792.288411]  ksys_sync+0x40/0xb0
[958792.291704]  __ia32_sys_sync+0xa/0x10
[958792.295425]  do_syscall_64+0x53/0x100
[958792.299148]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958792.304243] RIP: 0033:0x7f4139794577
[958792.307879] Code: Bad RIP value.
[958792.311170] RSP: 002b:00007ffd7925a568 EFLAGS: 00000202 ORIG_RAX: 00000000000000a2
[958792.318766] RAX: ffffffffffffffda RBX: 00007ffd7925a698 RCX: 00007f4139794577
[958792.325907] RDX: 00007f4139a4ee01 RSI: 00007ffd7925a698 RDI: 00007f4139816038
[958792.333064] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[958792.340219] R10: 000000000000081f R11: 0000000000000202 R12: 0000000000000001
[958792.347374] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[958792.354534] sync            D    0  9919      1 0x00000084
[958792.360044] Call Trace:
[958792.362567]  ? __schedule+0x2a2/0x870
[958792.366269]  ? __switch_to_asm+0x34/0x70
[958792.370233]  schedule+0x28/0x80
[958792.373468]  schedule_preempt_disabled+0xa/0x10
[958792.378047]  __mutex_lock.isra.5+0x2cc/0x4b0
[958792.382401]  ? finish_wait+0x3c/0x80
[958792.386016]  ? wb_wait_for_completion+0x7f/0x90
[958792.390582]  ? default_file_splice_write+0x20/0x20
[958792.395404]  sync_inodes_sb+0x11e/0x2c0
[958792.399300]  ? default_file_splice_write+0x20/0x20
[958792.404136]  iterate_supers+0x98/0x120
[958792.407944]  ksys_sync+0x40/0xb0
[958792.411235]  __ia32_sys_sync+0xa/0x10
[958792.414958]  do_syscall_64+0x53/0x100
[958792.418684]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958792.423779] RIP: 0033:0x7f7c0f80b577
[958792.427430] Code: Bad RIP value.
[958792.430743] RSP: 002b:00007ffc7bbcbd38 EFLAGS: 00000202 ORIG_RAX: 00000000000000a2
[958792.438329] RAX: ffffffffffffffda RBX: 00007ffc7bbcbe68 RCX: 00007f7c0f80b577
[958792.445484] RDX: 00007f7c0fac5e01 RSI: 00007ffc7bbcbe68 RDI: 00007f7c0f88d038
[958792.452640] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[958792.459794] R10: 000000000000081f R11: 0000000000000202 R12: 0000000000000001
[958792.466949] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[958792.474124] sync            D    0 14841      1 0x00000084
[958792.479634] Call Trace:
[958792.482151]  ? __schedule+0x2a2/0x870
[958792.485859]  ? __switch_to_asm+0x34/0x70
[958792.489839]  schedule+0x28/0x80
[958792.493045]  schedule_preempt_disabled+0xa/0x10
[958792.497625]  __mutex_lock.isra.5+0x2cc/0x4b0
[958792.501974]  ? finish_wait+0x3c/0x80
[958792.505622]  ? wb_wait_for_completion+0x7f/0x90
[958792.510200]  ? default_file_splice_write+0x20/0x20
[958792.515037]  sync_inodes_sb+0x11e/0x2c0
[958792.518932]  ? default_file_splice_write+0x20/0x20
[958792.523772]  iterate_supers+0x98/0x120
[958792.527581]  ksys_sync+0x40/0xb0
[958792.530874]  __ia32_sys_sync+0xa/0x10
[958792.534598]  do_syscall_64+0x53/0x100
[958792.538300]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958792.543381] RIP: 0033:0x7f63271e4577
[958792.547017] Code: Bad RIP value.
[958792.550303] RSP: 002b:00007ffc59fc25a8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a2
[958792.557873] RAX: ffffffffffffffda RBX: 00007ffc59fc26d8 RCX: 00007f63271e4577
[958792.565028] RDX: 00007f632749ee01 RSI: 00007ffc59fc26d8 RDI: 00007f6327266038
[958792.572187] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[958792.579343] R10: 000000000000081f R11: 0000000000000202 R12: 0000000000000001
[958792.586498] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[958792.593656] sync            D    0 158138      1 0x00000084
[958792.599250] Call Trace:
[958792.601765]  ? __schedule+0x2a2/0x870
[958792.605470]  ? __switch_to_asm+0x34/0x70
[958792.609450]  schedule+0x28/0x80
[958792.612656]  schedule_preempt_disabled+0xa/0x10
[958792.617237]  __mutex_lock.isra.5+0x2cc/0x4b0
[958792.621561]  ? finish_wait+0x3c/0x80
[958792.625199]  ? _cond_resched+0x15/0x30
[958792.629032]  ? wb_wait_for_completion+0x29/0x90
[958792.633599]  ? default_file_splice_write+0x20/0x20
[958792.638441]  sync_inodes_sb+0x11e/0x2c0
[958792.642314]  ? default_file_splice_write+0x20/0x20
[958792.647138]  iterate_supers+0x98/0x120
[958792.650946]  ksys_sync+0x40/0xb0
[958792.654235]  __ia32_sys_sync+0xa/0x10
[958792.657942]  do_syscall_64+0x53/0x100
[958792.661665]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958792.666763] RIP: 0033:0x14a6a797c577
[958792.670400] Code: Bad RIP value.
[958792.673673] RSP: 002b:00007fff25f77768 EFLAGS: 00000202 ORIG_RAX: 00000000000000a2
[958792.681241] RAX: ffffffffffffffda RBX: 00007fff25f77898 RCX: 000014a6a797c577
[958792.688395] RDX: 000014a6a7c36e01 RSI: 00007fff25f77898 RDI: 000014a6a79fe038
[958792.695549] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[958792.702719] R10: 000000000000081f R11: 0000000000000202 R12: 0000000000000001
[958792.709874] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[958792.717048] sync            D    0 250160      1 0x00000084
[958792.722646] Call Trace:
[958792.725147]  ? __schedule+0x2a2/0x870
[958792.728853]  schedule+0x28/0x80
[958792.732060]  schedule_preempt_disabled+0xa/0x10
[958792.736641]  __mutex_lock.isra.5+0x2cc/0x4b0
[958792.740963]  ? finish_wait+0x3c/0x80
[958792.744599]  ? _cond_resched+0x15/0x30
[958792.748407]  ? wb_wait_for_completion+0x29/0x90
[958792.752988]  ? default_file_splice_write+0x20/0x20
[958792.757856]  sync_inodes_sb+0x11e/0x2c0
[958792.761735]  ? default_file_splice_write+0x20/0x20
[958792.766575]  iterate_supers+0x98/0x120
[958792.770385]  ksys_sync+0x40/0xb0
[958792.773672]  __ia32_sys_sync+0xa/0x10
[958792.777379]  do_syscall_64+0x53/0x100
[958792.781100]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958792.786195] RIP: 0033:0x14e398126577
[958792.789832] Code: Bad RIP value.
[958792.793124] RSP: 002b:00007ffd3eff8c28 EFLAGS: 00000206 ORIG_RAX: 00000000000000a2
[958792.800708] RAX: ffffffffffffffda RBX: 00007ffd3eff8d58 RCX: 000014e398126577
[958792.807863] RDX: 000014e3983e0e01 RSI: 00007ffd3eff8d58 RDI: 000014e3981a8038
[958792.815045] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[958792.822186] R10: 000000000000081f R11: 0000000000000206 R12: 0000000000000001
[958792.829343] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[958792.836518] sync            D    0 210955  70595 0x00000080
[958792.842114] Call Trace:
[958792.844634]  ? __schedule+0x2a2/0x870
[958792.848356]  ? __switch_to_asm+0x34/0x70
[958792.852335]  schedule+0x28/0x80
[958792.855540]  schedule_preempt_disabled+0xa/0x10
[958792.860121]  __mutex_lock.isra.5+0x2cc/0x4b0
[958792.864445]  ? finish_wait+0x3c/0x80
[958792.868081]  ? _cond_resched+0x15/0x30
[958792.871875]  ? wb_wait_for_completion+0x29/0x90
[958792.876457]  ? default_file_splice_write+0x20/0x20
[958792.881294]  sync_inodes_sb+0x11e/0x2c0
[958792.885186]  ? default_file_splice_write+0x20/0x20
[958792.890024]  iterate_supers+0x98/0x120
[958792.893817]  ksys_sync+0x40/0xb0
[958792.897096]  __ia32_sys_sync+0xa/0x10
[958792.900805]  do_syscall_64+0x53/0x100
[958792.904513]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958792.909595] RIP: 0033:0x1482c8170577
[958792.913217] Code: Bad RIP value.
[958792.916495] RSP: 002b:00007ffc299afb88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a2
[958792.924069] RAX: ffffffffffffffda RBX: 00007ffc299afcb8 RCX: 00001482c8170577
[958792.931226] RDX: 00001482c842ae01 RSI: 00007ffc299afcb8 RDI: 00001482c81f2038
[958792.938406] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[958792.945548] R10: 000000000000081f R11: 0000000000000206 R12: 0000000000000001
[958792.952704] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[958792.959992] sync            D    0 150079 149860 0x000003a4
[958792.965588] Call Trace:
[958792.968126]  ? __schedule+0x2a2/0x870
[958792.971836]  ? __switch_to_asm+0x34/0x70
[958792.975817]  schedule+0x28/0x80
[958792.979026]  schedule_preempt_disabled+0xa/0x10
[958792.983606]  __mutex_lock.isra.5+0x2cc/0x4b0
[958792.987929]  ? finish_wait+0x3c/0x80
[958792.991566]  ? _cond_resched+0x15/0x30
[958792.995374]  ? wb_wait_for_completion+0x29/0x90
[958792.999955]  ? default_file_splice_write+0x20/0x20
[958793.004793]  sync_inodes_sb+0x11e/0x2c0
[958793.008689]  ? default_file_splice_write+0x20/0x20
[958793.013528]  iterate_supers+0x98/0x120
[958793.017337]  ksys_sync+0x40/0xb0
[958793.020648]  __ia32_sys_sync+0xa/0x10
[958793.024374]  do_syscall_64+0x53/0x100
[958793.028103]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958793.033198] RIP: 0033:0x7f84efefaaf7
[958793.036852] Code: Bad RIP value.
[958793.040131] RSP: 002b:00007ffc1bc5b8b8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a2
[958793.047716] RAX: ffffffffffffffda RBX: 00007ffc1bc5b9c8 RCX: 00007f84efefaaf7
[958793.054872] RDX: 00007f84f01c7280 RSI: 0000000000404801 RDI: 00007f84eff86d40
[958793.062027] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[958793.069183] R10: 00007ffc1bc5b680 R11: 0000000000000206 R12: 0000000000401571
[958793.076341] R13: 00007ffc1bc5b9c0 R14: 0000000000000000 R15: 0000000000000000
[958793.083529] sync            D    0 208857 206594 0x000003a4
[958793.089125] Call Trace:
[958793.091664]  ? __schedule+0x2a2/0x870
[958793.095370]  schedule+0x28/0x80
[958793.098581]  schedule_preempt_disabled+0xa/0x10
[958793.103148]  __mutex_lock.isra.5+0x2cc/0x4b0
[958793.107472]  ? _cond_resched+0x15/0x30
[958793.111281]  ? wb_wait_for_completion+0x29/0x90
[958793.115868]  ? default_file_splice_write+0x20/0x20
[958793.120707]  sync_inodes_sb+0x11e/0x2c0
[958793.124619]  ? default_file_splice_write+0x20/0x20
[958793.129461]  iterate_supers+0x98/0x120
[958793.133252]  ksys_sync+0x40/0xb0
[958793.136546]  __ia32_sys_sync+0xa/0x10
[958793.140287]  do_syscall_64+0x53/0x100
[958793.144013]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958793.149093] RIP: 0033:0x7fbf0efe0af7
[958793.152746] Code: Bad RIP value.
[958793.156022] RSP: 002b:00007fff142cf888 EFLAGS: 00000206 ORIG_RAX: 00000000000000a2
[958793.163627] RAX: ffffffffffffffda RBX: 00007fff142cf998 RCX: 00007fbf0efe0af7
[958793.170772] RDX: 00007fbf0f2ad280 RSI: 0000000000404801 RDI: 00007fbf0f06cd40
[958793.177929] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[958793.185088] R10: 00007fff142cf650 R11: 0000000000000206 R12: 0000000000401571
[958793.192247] R13: 00007fff142cf990 R14: 0000000000000000 R15: 0000000000000000
[958793.199439] sync            D    0 13621  11405 0x000003a4
[958793.204952] Call Trace:
[958793.207492]  ? __schedule+0x2a2/0x870
[958793.211217]  ? __switch_to_asm+0x34/0x70
[958793.215182]  schedule+0x28/0x80
[958793.218391]  schedule_preempt_disabled+0xa/0x10
[958793.222959]  __mutex_lock.isra.5+0x2cc/0x4b0
[958793.227301]  ? finish_wait+0x3c/0x80
[958793.230924]  ? _cond_resched+0x15/0x30
[958793.234753]  ? wb_wait_for_completion+0x29/0x90
[958793.239336]  ? default_file_splice_write+0x20/0x20
[958793.244163]  sync_inodes_sb+0x11e/0x2c0
[958793.248059]  ? default_file_splice_write+0x20/0x20
[958793.252914]  iterate_supers+0x98/0x120
[958793.256709]  ksys_sync+0x40/0xb0
[958793.260021]  __ia32_sys_sync+0xa/0x10
[958793.263748]  do_syscall_64+0x53/0x100
[958793.267456]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958793.272570] RIP: 0033:0x7f782fc22af7
[958793.276208] Code: Bad RIP value.
[958793.279486] RSP: 002b:00007ffff131fc68 EFLAGS: 00000202 ORIG_RAX: 00000000000000a2
[958793.287081] RAX: ffffffffffffffda RBX: 00007ffff131fd78 RCX: 00007f782fc22af7
[958793.294240] RDX: 00007f782feef280 RSI: 0000000000404801 RDI: 00007f782fcaed40
[958793.301398] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[958793.308553] R10: 00007ffff131fa30 R11: 0000000000000202 R12: 0000000000401571
[958793.315710] R13: 00007ffff131fd70 R14: 0000000000000000 R15: 0000000000000000
[958793.322900] sync            D    0 18736  18265 0x000003a4
[958793.328412] Call Trace:
[958793.330951]  ? __schedule+0x2a2/0x870
[958793.334659]  ? __switch_to_asm+0x34/0x70
[958793.338650]  schedule+0x28/0x80
[958793.341854]  schedule_preempt_disabled+0xa/0x10
[958793.346425]  __mutex_lock.isra.5+0x2cc/0x4b0
[958793.350750]  ? finish_wait+0x3c/0x80
[958793.354391]  ? _cond_resched+0x15/0x30
[958793.358187]  ? wb_wait_for_completion+0x29/0x90
[958793.362770]  ? default_file_splice_write+0x20/0x20
[958793.367610]  sync_inodes_sb+0x11e/0x2c0
[958793.371523]  ? default_file_splice_write+0x20/0x20
[958793.376348]  iterate_supers+0x98/0x120
[958793.380158]  ksys_sync+0x40/0xb0
[958793.383438]  __ia32_sys_sync+0xa/0x10
[958793.387178]  do_syscall_64+0x53/0x100
[958793.390902]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958793.395984] RIP: 0033:0x7f3b96b03af7
[958793.399639] Code: Bad RIP value.
[958793.402915] RSP: 002b:00007ffe13184b58 EFLAGS: 00000202 ORIG_RAX: 00000000000000a2
[958793.410502] RAX: ffffffffffffffda RBX: 00007ffe13184c68 RCX: 00007f3b96b03af7
[958793.417642] RDX: 00007f3b96dd0280 RSI: 0000000000404801 RDI: 00007f3b96b8fd40
[958793.424799] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[958793.431958] R10: 00007ffe13184920 R11: 0000000000000202 R12: 0000000000401571
[958793.439113] R13: 00007ffe13184c60 R14: 0000000000000000 R15: 0000000000000000
[958793.446319] sync            D    0 23734  23169 0x000003a4
[958793.451831] Call Trace:
[958793.454333]  ? __schedule+0x2a2/0x870
[958793.458042]  ? __switch_to_asm+0x34/0x70
[958793.462020]  schedule+0x28/0x80
[958793.465228]  schedule_preempt_disabled+0xa/0x10
[958793.469809]  __mutex_lock.isra.5+0x2cc/0x4b0
[958793.474150]  ? finish_wait+0x3c/0x80
[958793.477796]  ? wb_wait_for_completion+0x7f/0x90
[958793.482383]  ? default_file_splice_write+0x20/0x20
[958793.487221]  sync_inodes_sb+0x11e/0x2c0
[958793.491135]  ? default_file_splice_write+0x20/0x20
[958793.495959]  iterate_supers+0x98/0x120
[958793.499769]  ksys_sync+0x40/0xb0
[958793.503061]  __ia32_sys_sync+0xa/0x10
[958793.506800]  do_syscall_64+0x53/0x100
[958793.510510]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958793.515623] RIP: 0033:0x7f552a50aaf7
[958793.519262] Code: Bad RIP value.
[958793.522539] RSP: 002b:00007ffea1272dc8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a2
[958793.530111] RAX: ffffffffffffffda RBX: 00007ffea1272ed8 RCX: 00007f552a50aaf7
[958793.537268] RDX: 00007f552a7d7280 RSI: 0000000000404801 RDI: 00007f552a596d40
[958793.544425] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[958793.551583] R10: 00007ffea1272b90 R11: 0000000000000202 R12: 0000000000401571
[958793.558753] R13: 00007ffea1272ed0 R14: 0000000000000000 R15: 0000000000000000
[958793.565956] sync            D    0 30422  23772 0x000003a4
[958793.571466] Call Trace:
[958793.573983]  ? __schedule+0x2a2/0x870
[958793.577691]  ? __switch_to_asm+0x34/0x70
[958793.581690]  schedule+0x28/0x80
[958793.584881]  schedule_preempt_disabled+0xa/0x10
[958793.589463]  __mutex_lock.isra.5+0x2cc/0x4b0
[958793.593787]  ? finish_wait+0x3c/0x80
[958793.597422]  ? _cond_resched+0x15/0x30
[958793.601233]  ? wb_wait_for_completion+0x29/0x90
[958793.605835]  ? default_file_splice_write+0x20/0x20
[958793.610658]  sync_inodes_sb+0x11e/0x2c0
[958793.614539]  ? default_file_splice_write+0x20/0x20
[958793.619381]  iterate_supers+0x98/0x120
[958793.623190]  ksys_sync+0x40/0xb0
[958793.626487]  __ia32_sys_sync+0xa/0x10
[958793.630206]  do_syscall_64+0x53/0x100
[958793.633918]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958793.639018] RIP: 0033:0x7f4cc275baf7
[958793.642659] Code: Bad RIP value.
[958793.645947] RSP: 002b:00007ffc90c57878 EFLAGS: 00000206 ORIG_RAX: 00000000000000a2
[958793.653521] RAX: ffffffffffffffda RBX: 00007ffc90c57988 RCX: 00007f4cc275baf7
[958793.660676] RDX: 00007f4cc2a28280 RSI: 0000000000404801 RDI: 00007f4cc27e7d40
[958793.667831] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[958793.674987] R10: 00007ffc90c57640 R11: 0000000000000206 R12: 0000000000401571
[958793.682162] R13: 00007ffc90c57980 R14: 0000000000000000 R15: 0000000000000000
[958793.689320] sbatchd         D    0 47537  68426 0x80000080
[958793.694830] Call Trace:
[958793.697354]  ? __schedule+0x2a2/0x870
[958793.701065]  schedule+0x28/0x80
[958793.704291]  autofs_wait+0x324/0x7c0 [autofs4]
[958793.708787]  ? finish_wait+0x80/0x80
[958793.712410]  ? autofs_mount_wait+0x56/0xe0 [autofs4]
[958793.717421]  autofs_mount_wait+0x56/0xe0 [autofs4]
[958793.722261]  autofs_d_automount+0xed/0x210 [autofs4]
[958793.727291]  follow_managed+0x187/0x300
[958793.731171]  walk_component+0x223/0x4a0
[958793.735067]  link_path_walk.part.42+0x2b9/0x520
[958793.739648]  path_lookupat.isra.46+0x93/0x220
[958793.744057]  filename_lookup.part.60+0xa0/0x170
[958793.748656]  ? __check_object_size+0x15d/0x189
[958793.753137]  ? audit_alloc_name+0x7e/0xd0
[958793.757204]  ? path_get+0x11/0x30
[958793.760584]  ? __audit_getname+0x96/0xb0
[958793.764581]  ? getname_flags+0xb9/0x1e0
[958793.768460]  ksys_chdir+0x3e/0xc0
[958793.771841]  __x64_sys_chdir+0xe/0x20
[958793.775582]  do_syscall_64+0x53/0x100
[958793.779302]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958793.784397] RIP: 0033:0x7f5ac1cd8e57
[958793.788053] Code: Bad RIP value.
[958793.791330] RSP: 002b:00007ffc42e03db8 EFLAGS: 00000206 ORIG_RAX: 0000000000000050
[958793.798915] RAX: ffffffffffffffda RBX: 00007ffc42e29800 RCX: 00007f5ac1cd8e57
[958793.806069] RDX: 00315f736f686c6f RSI: 00007ffc42e163a0 RDI: 0000000000c19460
[958793.813235] RBP: 00007ffc42e04fe0 R08: 0000000000000000 R09: 000000000000003e
[958793.820389] R10: 0000000000000376 R11: 0000000000000206 R12: 00000000004420f0
[958793.827546] R13: 00007ffc42e2e2f0 R14: 0000000000000000 R15: 0000000000000000
[958793.834741] mount.nfs       D    0 47549  47548 0x80000080
[958793.840268] Call Trace:
[958793.842810]  ? __schedule+0x2a2/0x870
[958793.846536]  schedule+0x28/0x80
[958793.849741]  rwsem_down_write_failed+0x183/0x3a0
[958793.854418]  call_rwsem_down_write_failed+0x13/0x20
[958793.859329]  down_write+0x29/0x40
[958793.862736]  grab_super+0x2b/0x90
[958793.866108]  ? nfs_kill_super+0x40/0x40 [nfs]
[958793.870504]  sget_userns+0x356/0x4c0
[958793.874127]  ? nfs_clone_sb_security+0xb0/0xb0 [nfs]
[958793.879143]  nfs_fs_mount_common+0x8d/0x250 [nfs]
[958793.883903]  ? nfs_clone_server+0x1aa/0x1e0 [nfs]
[958793.888659]  nfs_xdev_mount+0xe2/0x100 [nfs]
[958793.892988]  ? nfs_initialise_sb+0xc0/0xc0 [nfs]
[958793.897659]  ? nfs_set_sb_security+0x90/0x90 [nfs]
[958793.902483]  mount_fs+0x3b/0x167
[958793.905761]  vfs_kern_mount.part.35+0x54/0x120
[958793.910262]  nfs_do_submount+0xe9/0x100 [nfs]
[958793.914722]  nfs4_submount+0x84/0x760 [nfsv4]
[958793.919150]  ? __d_lookup_done+0x77/0xe0
[958793.923114]  ? d_splice_alias+0x134/0x3c0
[958793.927202]  ? nfs_lookup+0xca/0x250 [nfs]
[958793.931339]  ? _cond_resched+0x15/0x30
[958793.935167]  ? kmem_cache_alloc_trace+0x155/0x1d0
[958793.939924]  nfs_d_automount+0x71/0xe0 [nfs]
[958793.944265]  follow_managed+0x187/0x300
[958793.948144]  walk_component+0x223/0x4a0
[958793.952040]  link_path_walk.part.42+0x2b9/0x520
[958793.956642]  ? memcg_kmem_get_cache+0x6b/0x1e0
[958793.961121]  ? kmem_cache_alloc+0x15c/0x1c0
[958793.965360]  path_lookupat.isra.46+0x93/0x220
[958793.969768]  ? __d_instantiate_anon+0x7a/0x1a0
[958793.974277]  ? audit_alloc_name+0xbb/0xd0
[958793.978344]  filename_lookup.part.60+0xa0/0x170
[958793.982926]  ? kmem_cache_alloc_trace+0x155/0x1d0
[958793.987677]  ? audit_alloc_name+0x7e/0xd0
[958793.991741]  vfs_path_lookup+0x4e/0x70
[958793.995550]  mount_subtree+0x66/0xd0
[958793.999219]  nfs_follow_remote_path+0x10a/0x210 [nfsv4]
[958794.004498]  nfs4_try_mount+0x55/0x70 [nfsv4]
[958794.008933]  ? get_nfs_version+0x21/0x80 [nfs]
[958794.013447]  nfs_fs_mount+0x788/0xc20 [nfs]
[958794.017686]  ? pcpu_alloc_area+0xe2/0x130
[958794.021757]  ? nfs_clone_super+0x70/0x70 [nfs]
[958794.026256]  ? nfs_parse_mount_options+0xb50/0xb50 [nfs]
[958794.031610]  mount_fs+0x3b/0x167
[958794.034923]  vfs_kern_mount.part.35+0x54/0x120
[958794.039421]  do_mount+0x20e/0xcb0
[958794.042784]  ? __audit_syscall_entry+0x31/0x130
[958794.047364]  ? _cond_resched+0x15/0x30
[958794.051174]  ? kmem_cache_alloc_trace+0x155/0x1d0
[958794.055928]  ksys_mount+0xba/0xd0
[958794.059306]  __x64_sys_mount+0x21/0x30
[958794.063132]  do_syscall_64+0x53/0x100
[958794.066841]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958794.071938] RIP: 0033:0x7f75571a620a
[958794.075594] Code: Bad RIP value.
[958794.078870] RSP: 002b:00007ffea5a080c8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
[958794.086459] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f75571a620a
[958794.093599] RDX: 000055cf999ae1e0 RSI: 000055cf999b0200 RDI: 000055cf999ae3d0
[958794.100757] RBP: 00007ffea5a08220 R08: 000055cf999b14c0 R09: 0000000000000060
[958794.107912] R10: 0000000000000006 R11: 0000000000000202 R12: 000055cf999b1130
[958794.115067] R13: 0000000000000010 R14: 00007ffea5a08130 R15: 000055cf999b1190
[958794.122245] eexec           D    0 50840  50839 0x80000080
[958794.127772] Call Trace:
[958794.130293]  ? __schedule+0x2a2/0x870
[958794.134020]  schedule+0x28/0x80
[958794.137231]  autofs_wait+0x324/0x7c0 [autofs4]
[958794.141730]  ? finish_wait+0x80/0x80
[958794.145353]  ? autofs_mount_wait+0x56/0xe0 [autofs4]
[958794.150381]  autofs_mount_wait+0x56/0xe0 [autofs4]
[958794.155204]  autofs_d_automount+0xed/0x210 [autofs4]
[958794.160218]  follow_managed+0x187/0x300
[958794.164113]  walk_component+0x223/0x4a0
[958794.168007]  link_path_walk.part.42+0x2b9/0x520
[958794.172589]  path_lookupat.isra.46+0x93/0x220
[958794.177051]  ? __rpc_wait_for_completion_task+0x30/0x30 [sunrpc]
[958794.183078]  filename_lookup.part.60+0xa0/0x170
[958794.187677]  ? __check_object_size+0x15d/0x189
[958794.192158]  ? audit_alloc_name+0x7e/0xd0
[958794.196222]  ? path_get+0x11/0x30
[958794.199602]  ? __audit_getname+0x96/0xb0
[958794.203602]  vfs_statx+0x73/0xe0
[958794.206882]  __do_sys_newstat+0x39/0x70
[958794.210796]  ? syscall_trace_enter+0x1d3/0x2c0
[958794.215279]  ? __audit_syscall_exit+0x228/0x290
[958794.219861]  do_syscall_64+0x53/0x100
[958794.223602]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958794.228700] RIP: 0033:0x7f0866161015
[958794.232337] Code: Bad RIP value.
[958794.235615] RSP: 002b:00007ffc767c1538 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
[958794.243202] RAX: ffffffffffffffda RBX: 0000558b4e291630 RCX: 00007f0866161015
[958794.250357] RDX: 00007ffc767c1550 RSI: 00007ffc767c1550 RDI: 0000558b4e291630
[958794.257515] RBP: 00007ffc767c1550 R08: 0000558b4e25cde0 R09: 0000000000033800
[958794.264670] R10: 0000558b4d879fc0 R11: 0000000000000246 R12: 0000000000000000
[958794.271824] R13: 0000558b4e1eb0a0 R14: 00007f0867030610 R15: 00007f0867128e70
[958794.279003] eexec           D    0 50922  50920 0x00000080
[958794.284512] Call Trace:
[958794.287049]  ? __schedule+0x2a2/0x870
[958794.290773]  ? kmem_cache_alloc+0x15c/0x1c0
[958794.294997]  schedule+0x28/0x80
[958794.298203]  autofs_wait+0x324/0x7c0 [autofs4]
[958794.302685]  ? finish_wait+0x80/0x80
[958794.306307]  ? autofs_mount_wait+0x56/0xe0 [autofs4]
[958794.311301]  autofs_mount_wait+0x56/0xe0 [autofs4]
[958794.316141]  autofs_d_manage+0x95/0x1b0 [autofs4]
[958794.320896]  follow_managed+0xcf/0x300
[958794.324722]  walk_component+0x223/0x4a0
[958794.328601]  link_path_walk.part.42+0x2b9/0x520
[958794.333183]  path_lookupat.isra.46+0x93/0x220
[958794.337594]  filename_lookup.part.60+0xa0/0x170
[958794.342193]  ? __check_object_size+0x15d/0x189
[958794.346674]  ? audit_alloc_name+0x7e/0xd0
[958794.350758]  ? path_get+0x11/0x30
[958794.354115]  ? __audit_getname+0x96/0xb0
[958794.358079]  vfs_statx+0x73/0xe0
[958794.361391]  __do_sys_newstat+0x39/0x70
[958794.365271]  ? syscall_trace_enter+0x1d3/0x2c0
[958794.369766]  ? __audit_syscall_exit+0x228/0x290
[958794.374347]  do_syscall_64+0x53/0x100
[958794.378086]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958794.383166] RIP: 0033:0x7fa31a610015
[958794.386820] Code: Bad RIP value.
[958794.390092] RSP: 002b:00007ffe44793b58 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
[958794.397662] RAX: ffffffffffffffda RBX: 000055e317f7c750 RCX: 00007fa31a610015
[958794.404816] RDX: 00007ffe44793b70 RSI: 00007ffe44793b70 RDI: 000055e317f7c750
[958794.411973] RBP: 00007ffe44793b70 R08: 000055e317fa32a0 R09: 0000000000030500
[958794.419130] R10: 000055e317347fc0 R11: 0000000000000246 R12: 0000000000000000
[958794.426287] R13: 000055e317f450a0 R14: 00007fa31b4e3210 R15: 00007fa31b5d7e70
[958794.433465] eexec           D    0 51219  51218 0x00000080
[958794.438976] Call Trace:
[958794.441495]  ? __schedule+0x2a2/0x870
[958794.445221]  ? kmem_cache_alloc+0x15c/0x1c0
[958794.449442]  schedule+0x28/0x80
[958794.452652]  autofs_wait+0x324/0x7c0 [autofs4]
[958794.457148]  ? finish_wait+0x80/0x80
[958794.460786]  ? autofs_mount_wait+0x56/0xe0 [autofs4]
[958794.465795]  autofs_mount_wait+0x56/0xe0 [autofs4]
[958794.470636]  autofs_d_manage+0x95/0x1b0 [autofs4]
[958794.475374]  follow_managed+0xcf/0x300
[958794.479184]  walk_component+0x223/0x4a0
[958794.483078]  link_path_walk.part.42+0x2b9/0x520
[958794.487659]  path_lookupat.isra.46+0x93/0x220
[958794.492122]  ? __rpc_wait_for_completion_task+0x30/0x30 [sunrpc]
[958794.498171]  filename_lookup.part.60+0xa0/0x170
[958794.502760]  ? __check_object_size+0x15d/0x189
[958794.507274]  ? audit_alloc_name+0x7e/0xd0
[958794.511327]  ? path_get+0x11/0x30
[958794.514730]  ? __audit_getname+0x96/0xb0
[958794.518727]  vfs_statx+0x73/0xe0
[958794.522003]  __do_sys_newstat+0x39/0x70
[958794.525903]  ? syscall_trace_enter+0x1d3/0x2c0
[958794.530395]  ? __audit_syscall_exit+0x228/0x290
[958794.534960]  do_syscall_64+0x53/0x100
[958794.538703]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958794.543816] RIP: 0033:0x7fc470ebc015
[958794.547454] Code: Bad RIP value.
[958794.550757] RSP: 002b:00007ffc8da966e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
[958794.558328] RAX: ffffffffffffffda RBX: 000055f5d1bfaad0 RCX: 00007fc470ebc015
[958794.565485] RDX: 00007ffc8da96700 RSI: 00007ffc8da96700 RDI: 000055f5d1bfaad0
[958794.572643] RBP: 00007ffc8da96700 R08: 000055f5d1bfab00 R09: 0000000000035200
[958794.579798] R10: 000055f5d19c5fc0 R11: 0000000000000246 R12: 0000000000000000
[958794.586956] R13: 000055f5d1b530a0 R14: 00007fc471d8ab10 R15: 00007fc471e83e70
[958794.594134] eexec           D    0 51239  51237 0x00000080
[958794.599659] Call Trace:
[958794.602178]  ? __schedule+0x2a2/0x870
[958794.605902]  ? kmem_cache_alloc+0x15c/0x1c0
[958794.610125]  schedule+0x28/0x80
[958794.613350]  autofs_wait+0x324/0x7c0 [autofs4]
[958794.617845]  ? finish_wait+0x80/0x80
[958794.621467]  ? autofs_mount_wait+0x56/0xe0 [autofs4]
[958794.626479]  autofs_mount_wait+0x56/0xe0 [autofs4]
[958794.631302]  autofs_d_manage+0x95/0x1b0 [autofs4]
[958794.636071]  follow_managed+0xcf/0x300
[958794.639864]  walk_component+0x223/0x4a0
[958794.643777]  link_path_walk.part.42+0x2b9/0x520
[958794.648343]  path_lookupat.isra.46+0x93/0x220
[958794.652803]  ? __rpc_wait_for_completion_task+0x30/0x30 [sunrpc]
[958794.658829]  filename_lookup.part.60+0xa0/0x170
[958794.663431]  ? __check_object_size+0x15d/0x189
[958794.667912]  ? audit_alloc_name+0x7e/0xd0
[958794.671977]  ? path_get+0x11/0x30
[958794.675356]  ? __audit_getname+0x96/0xb0
[958794.679352]  vfs_statx+0x73/0xe0
[958794.682634]  __do_sys_newstat+0x39/0x70
[958794.686531]  ? syscall_trace_enter+0x1d3/0x2c0
[958794.691027]  ? __audit_syscall_exit+0x228/0x290
[958794.695608]  do_syscall_64+0x53/0x100
[958794.699349]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958794.704431] RIP: 0033:0x7f7c36cb8015
[958794.708086] Code: Bad RIP value.
[958794.711363] RSP: 002b:00007ffdc43e7858 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
[958794.718950] RAX: ffffffffffffffda RBX: 000055fbf7d506c0 RCX: 00007f7c36cb8015
[958794.726109] RDX: 00007ffdc43e7870 RSI: 00007ffdc43e7870 RDI: 000055fbf7d506c0
[958794.733253] RBP: 00007ffdc43e7870 R08: 000055fbf7d50690 R09: 0000000000034b00
[958794.740410] R10: 000055fbf7573fc0 R11: 0000000000000246 R12: 0000000000000000
[958794.747567] R13: 000055fbf7cab0a0 R14: 00007f7c37b82d10 R15: 00007f7c37c7ae70
[958794.754749] eexec           D    0 51750  51749 0x00000080
[958794.760279] Call Trace:
[958794.762802]  ? __schedule+0x2a2/0x870
[958794.766514]  ? kmem_cache_alloc+0x15c/0x1c0
[958794.770766]  schedule+0x28/0x80
[958794.773970]  autofs_wait+0x324/0x7c0 [autofs4]
[958794.778456]  ? finish_wait+0x80/0x80
[958794.782077]  ? autofs_mount_wait+0x56/0xe0 [autofs4]
[958794.787072]  autofs_mount_wait+0x56/0xe0 [autofs4]
[958794.791910]  autofs_d_manage+0x95/0x1b0 [autofs4]
[958794.796682]  follow_managed+0xcf/0x300
[958794.800476]  walk_component+0x223/0x4a0
[958794.804371]  link_path_walk.part.42+0x2b9/0x520
[958794.808954]  path_lookupat.isra.46+0x93/0x220
[958794.813417]  ? __rpc_wait_for_completion_task+0x30/0x30 [sunrpc]
[958794.819441]  filename_lookup.part.60+0xa0/0x170
[958794.824043]  ? __check_object_size+0x15d/0x189
[958794.828523]  ? audit_alloc_name+0x7e/0xd0
[958794.832589]  ? path_get+0x11/0x30
[958794.835967]  ? __audit_getname+0x96/0xb0
[958794.839947]  vfs_statx+0x73/0xe0
[958794.843240]  __do_sys_newstat+0x39/0x70
[958794.847153]  ? syscall_trace_enter+0x1d3/0x2c0
[958794.851632]  ? __audit_syscall_exit+0x228/0x290
[958794.856215]  do_syscall_64+0x53/0x100
[958794.859940]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958794.865039] RIP: 0033:0x7fa1fb39e015
[958794.868680] Code: Bad RIP value.
[958794.871958] RSP: 002b:00007ffc0f12e5b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
[958794.879545] RAX: ffffffffffffffda RBX: 0000557ab39125f0 RCX: 00007fa1fb39e015
[958794.886686] RDX: 00007ffc0f12e5d0 RSI: 00007ffc0f12e5d0 RDI: 0000557ab39125f0
[958794.893827] RBP: 00007ffc0f12e5d0 R08: 0000557ab3911750 R09: 0000000000033900
[958794.900983] R10: 0000557ab1c9ffc0 R11: 0000000000000246 R12: 0000000000000000
[958794.908139] R13: 0000557ab38da0a0 R14: 00007fa1fc26e5d0 R15: 00007fa1fc365e70
[958794.915317] eexec           D    0 51755  51753 0x00000080
[958794.920829] Call Trace:
[958794.923369]  ? __schedule+0x2a2/0x870
[958794.927094]  ? kmem_cache_alloc+0x15c/0x1c0
[958794.931317]  schedule+0x28/0x80
[958794.934528]  autofs_wait+0x324/0x7c0 [autofs4]
[958794.939009]  ? finish_wait+0x80/0x80
[958794.942652]  ? autofs_mount_wait+0x56/0xe0 [autofs4]
[958794.947649]  autofs_mount_wait+0x56/0xe0 [autofs4]
[958794.952487]  autofs_d_manage+0x95/0x1b0 [autofs4]
[958794.957240]  follow_managed+0xcf/0x300
[958794.961050]  walk_component+0x223/0x4a0
[958794.964944]  link_path_walk.part.42+0x2b9/0x520
[958794.969527]  path_lookupat.isra.46+0x93/0x220
[958794.973938]  filename_lookup.part.60+0xa0/0x170
[958794.978524]  ? __check_object_size+0x15d/0x189
[958794.983004]  ? audit_alloc_name+0x7e/0xd0
[958794.987070]  ? path_get+0x11/0x30
[958794.990450]  ? __audit_getname+0x96/0xb0
[958794.994434]  vfs_statx+0x73/0xe0
[958794.997708]  __do_sys_newstat+0x39/0x70
[958795.001605]  ? syscall_trace_enter+0x1d3/0x2c0
[958795.006083]  ? __audit_syscall_exit+0x228/0x290
[958795.010652]  do_syscall_64+0x53/0x100
[958795.014356]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958795.019457] RIP: 0033:0x7fdda5a98015
[958795.023111] Code: Bad RIP value.
[958795.026393] RSP: 002b:00007fff419c3068 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
[958795.033964] RAX: ffffffffffffffda RBX: 000055a16c0bebc0 RCX: 00007fdda5a98015
[958795.041118] RDX: 00007fff419c3080 RSI: 00007fff419c3080 RDI: 000055a16c0bebc0
[958795.048273] RBP: 00007fff419c3080 R08: 000055a16c0beb90 R09: 0000000000035200
[958795.055428] R10: 000055a16aa43fc0 R11: 0000000000000246 R12: 0000000000000000
[958795.062585] R13: 000055a16c0170a0 R14: 00007fdda6966b50 R15: 00007fdda6a5fe70
[958795.069747] eexec           D    0 54084  54083 0x00000080
[958795.075273] Call Trace:
[958795.077791]  ? __schedule+0x2a2/0x870
[958795.081504]  ? kmem_cache_alloc+0x15c/0x1c0
[958795.085742]  schedule+0x28/0x80
[958795.088967]  autofs_wait+0x324/0x7c0 [autofs4]
[958795.093449]  ? finish_wait+0x80/0x80
[958795.097085]  ? autofs_mount_wait+0x56/0xe0 [autofs4]
[958795.102096]  autofs_mount_wait+0x56/0xe0 [autofs4]
[958795.106935]  autofs_d_manage+0x95/0x1b0 [autofs4]
[958795.111706]  follow_managed+0xcf/0x300
[958795.115517]  walk_component+0x223/0x4a0
[958795.119397]  link_path_walk.part.42+0x2b9/0x520
[958795.123979]  path_lookupat.isra.46+0x93/0x220
[958795.128422]  ? __rpc_wait_for_completion_task+0x30/0x30 [sunrpc]
[958795.134448]  filename_lookup.part.60+0xa0/0x170
[958795.139034]  ? __check_object_size+0x15d/0x189
[958795.143514]  ? audit_alloc_name+0x7e/0xd0
[958795.147598]  ? path_get+0x11/0x30
[958795.150964]  ? __audit_getname+0x96/0xb0
[958795.154961]  vfs_statx+0x73/0xe0
[958795.158237]  __do_sys_newstat+0x39/0x70
[958795.162136]  ? syscall_trace_enter+0x1d3/0x2c0
[958795.166620]  ? __audit_syscall_exit+0x228/0x290
[958795.171205]  do_syscall_64+0x53/0x100
[958795.174933]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958795.180016] RIP: 0033:0x7fb1dd23f015
[958795.183669] Code: Bad RIP value.
[958795.186946] RSP: 002b:00007ffc03566d28 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
[958795.194532] RAX: ffffffffffffffda RBX: 000055c92e8f4750 RCX: 00007fb1dd23f015
[958795.201676] RDX: 00007ffc03566d40 RSI: 00007ffc03566d40 RDI: 000055c92e8f4750
[958795.208833] RBP: 00007ffc03566d40 R08: 000055c92e8f55f0 R09: 0000000000033900
[958795.215989] R10: 000055c92d793fc0 R11: 0000000000000246 R12: 0000000000000000
[958795.223146] R13: 000055c92e8bd0a0 R14: 00007fb1de10f5d0 R15: 00007fb1de206e70
[958795.230325] eexec           D    0 54223  54220 0x00000080
[958795.235849] Call Trace:
[958795.238392]  ? __schedule+0x2a2/0x870
[958795.242102]  ? kmem_cache_alloc+0x15c/0x1c0
[958795.246324]  schedule+0x28/0x80
[958795.249568]  autofs_wait+0x324/0x7c0 [autofs4]
[958795.254066]  ? finish_wait+0x80/0x80
[958795.257703]  ? autofs_mount_wait+0x56/0xe0 [autofs4]
[958795.262730]  autofs_mount_wait+0x56/0xe0 [autofs4]
[958795.267569]  autofs_d_manage+0x95/0x1b0 [autofs4]
[958795.272341]  follow_managed+0xcf/0x300
[958795.276136]  walk_component+0x223/0x4a0
[958795.280031]  link_path_walk.part.42+0x2b9/0x520
[958795.284612]  path_lookupat.isra.46+0x93/0x220
[958795.289022]  filename_lookup.part.60+0xa0/0x170
[958795.293622]  ? __check_object_size+0x15d/0x189
[958795.298104]  ? audit_alloc_name+0x7e/0xd0
[958795.302169]  ? path_get+0x11/0x30
[958795.305546]  ? __audit_getname+0x96/0xb0
[958795.309557]  vfs_statx+0x73/0xe0
[958795.312834]  __do_sys_newstat+0x39/0x70
[958795.316727]  ? syscall_trace_enter+0x1d3/0x2c0
[958795.321223]  ? __audit_syscall_exit+0x228/0x290
[958795.325804]  do_syscall_64+0x53/0x100
[958795.329529]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958795.334628] RIP: 0033:0x7f8ca364a015
[958795.338248] Code: Bad RIP value.
[958795.341529] RSP: 002b:00007ffe44d4f058 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
[958795.349114] RAX: ffffffffffffffda RBX: 000055ec0261c9c0 RCX: 00007f8ca364a015
[958795.356269] RDX: 00007ffe44d4f070 RSI: 00007ffe44d4f070 RDI: 000055ec0261c9c0
[958795.363424] RBP: 00007ffe44d4f070 R08: 000055ec0261c9f0 R09: 0000000000032e00
[958795.370583] R10: 000055ec01f6bfc0 R11: 0000000000000246 R12: 0000000000000000
[958795.377724] R13: 000055ec025ae0a0 R14: 00007f8ca4518890 R15: 00007f8ca4611e70
[958795.384901] eexec           D    0 54291  54289 0x00000080
[958795.390436] Call Trace:
[958795.392938]  ? __schedule+0x2a2/0x870
[958795.396663]  ? kmem_cache_alloc+0x15c/0x1c0
[958795.400905]  schedule+0x28/0x80
[958795.404098]  autofs_wait+0x324/0x7c0 [autofs4]
[958795.408615]  ? finish_wait+0x80/0x80
[958795.412238]  ? autofs_mount_wait+0x56/0xe0 [autofs4]
[958795.417249]  autofs_mount_wait+0x56/0xe0 [autofs4]
[958795.422087]  autofs_d_manage+0x95/0x1b0 [autofs4]
[958795.426856]  follow_managed+0xcf/0x300
[958795.430652]  walk_component+0x223/0x4a0
[958795.434534]  link_path_walk.part.42+0x2b9/0x520
[958795.439100]  path_lookupat.isra.46+0x93/0x220
[958795.443559]  ? __rpc_wait_for_completion_task+0x30/0x30 [sunrpc]
[958795.449590]  filename_lookup.part.60+0xa0/0x170
[958795.454192]  ? __check_object_size+0x15d/0x189
[958795.458673]  ? audit_alloc_name+0x7e/0xd0
[958795.462748]  ? path_get+0x11/0x30
[958795.466106]  ? __audit_getname+0x96/0xb0
[958795.470089]  vfs_statx+0x73/0xe0
[958795.473370]  __do_sys_newstat+0x39/0x70
[958795.477284]  ? syscall_trace_enter+0x1d3/0x2c0
[958795.481763]  ? __audit_syscall_exit+0x228/0x290
[958795.486347]  do_syscall_64+0x53/0x100
[958795.490091]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958795.495190] RIP: 0033:0x7f547f913015
[958795.498829] Code: Bad RIP value.
[958795.502100] RSP: 002b:00007ffda322d768 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
[958795.509675] RAX: ffffffffffffffda RBX: 00005618b52fb6c0 RCX: 00007f547f913015
[958795.516828] RDX: 00007ffda322d780 RSI: 00007ffda322d780 RDI: 00005618b52fb6c0
[958795.523984] RBP: 00007ffda322d780 R08: 00005618b52fb690 R09: 0000000000034b00
[958795.531139] R10: 00005618b503cfc0 R11: 0000000000000246 R12: 0000000000000000
[958795.538294] R13: 00005618b52560a0 R14: 00007f54807e2d10 R15: 00007f54808dae70
[958795.545472] eexec           D    0 54329  54327 0x00000080
[958795.550997] Call Trace:
[958795.553517]  ? __schedule+0x2a2/0x870
[958795.557226]  ? kmem_cache_alloc+0x15c/0x1c0
[958795.561483]  schedule+0x28/0x80
[958795.564681]  autofs_wait+0x324/0x7c0 [autofs4]
[958795.569195]  ? finish_wait+0x80/0x80
[958795.572837]  ? autofs_mount_wait+0x56/0xe0 [autofs4]
[958795.577832]  autofs_mount_wait+0x56/0xe0 [autofs4]
[958795.582672]  autofs_d_manage+0x95/0x1b0 [autofs4]
[958795.587412]  follow_managed+0xcf/0x300
[958795.591220]  walk_component+0x223/0x4a0
[958795.595117]  link_path_walk.part.42+0x2b9/0x520
[958795.599700]  path_lookupat.isra.46+0x93/0x220
[958795.604143]  ? __rpc_wait_for_completion_task+0x30/0x30 [sunrpc]
[958795.610186]  filename_lookup.part.60+0xa0/0x170
[958795.614774]  ? __check_object_size+0x15d/0x189
[958795.619254]  ? audit_alloc_name+0x7e/0xd0
[958795.623318]  ? path_get+0x11/0x30
[958795.626714]  ? __audit_getname+0x96/0xb0
[958795.630695]  vfs_statx+0x73/0xe0
[958795.633970]  __do_sys_newstat+0x39/0x70
[958795.637857]  ? syscall_trace_enter+0x1d3/0x2c0
[958795.642336]  ? __audit_syscall_exit+0x228/0x290
[958795.646916]  do_syscall_64+0x53/0x100
[958795.650644]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958795.655726] RIP: 0033:0x7f235a14d015
[958795.659379] Code: Bad RIP value.
[958795.662659] RSP: 002b:00007fff2e1ae888 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
[958795.670230] RAX: ffffffffffffffda RBX: 0000562017fa79c0 RCX: 00007f235a14d015
[958795.677386] RDX: 00007fff2e1ae8a0 RSI: 00007fff2e1ae8a0 RDI: 0000562017fa79c0
[958795.684544] RBP: 00007fff2e1ae8a0 R08: 0000562017fa79f0 R09: 0000000000032e00
[958795.691701] R10: 00005620168e9fc0 R11: 0000000000000246 R12: 0000000000000000
[958795.698857] R13: 0000562017f390a0 R14: 00007f235b01b890 R15: 00007f235b114e70
[958795.706033] eexec           D    0 54975  54954 0x00000080
[958795.711562] Call Trace:
[958795.714083]  ? __schedule+0x2a2/0x870
[958795.717812]  ? kmem_cache_alloc+0x15c/0x1c0
[958795.722031]  schedule+0x28/0x80
[958795.725258]  autofs_wait+0x324/0x7c0 [autofs4]
[958795.729741]  ? finish_wait+0x80/0x80
[958795.733393]  ? autofs_mount_wait+0x56/0xe0 [autofs4]
[958795.738395]  autofs_mount_wait+0x56/0xe0 [autofs4]
[958795.743218]  autofs_d_manage+0x95/0x1b0 [autofs4]
[958795.747990]  follow_managed+0xcf/0x300
[958795.751782]  walk_component+0x223/0x4a0
[958795.755678]  link_path_walk.part.42+0x2b9/0x520
[958795.760260]  path_lookupat.isra.46+0x93/0x220
[958795.764719]  ? __rpc_wait_for_completion_task+0x30/0x30 [sunrpc]
[958795.770775]  filename_lookup.part.60+0xa0/0x170
[958795.775358]  ? __check_object_size+0x15d/0x189
[958795.779837]  ? audit_alloc_name+0x7e/0xd0
[958795.783919]  ? path_get+0x11/0x30
[958795.787283]  ? __audit_getname+0x96/0xb0
[958795.791282]  vfs_statx+0x73/0xe0
[958795.794563]  __do_sys_newstat+0x39/0x70
[958795.798446]  ? syscall_trace_enter+0x1d3/0x2c0
[958795.802928]  ? __audit_syscall_exit+0x228/0x290
[958795.807510]  do_syscall_64+0x53/0x100
[958795.811253]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958795.816335] RIP: 0033:0x7fa170a93015
[958795.819989] Code: Bad RIP value.
[958795.823266] RSP: 002b:00007ffc392702c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
[958795.830851] RAX: ffffffffffffffda RBX: 000055e55f1f16a0 RCX: 00007fa170a93015
[958795.838007] RDX: 00007ffc392702e0 RSI: 00007ffc392702e0 RDI: 000055e55f1f16a0
[958795.845148] RBP: 00007ffc392702e0 R08: 000055e55f1f2690 R09: 0000000000034a00
[958795.852304] R10: 000055e55d802fc0 R11: 0000000000000246 R12: 0000000000000000
[958795.859460] R13: 000055e55f14d0a0 R14: 00007fa171962d10 R15: 00007fa171a5ae70
[958795.866624] eexec           D    0 55860  55858 0x00000080
[958795.872136] Call Trace:
[958795.874661]  ? __schedule+0x2a2/0x870
[958795.878388]  ? kmem_cache_alloc+0x15c/0x1c0
[958795.882612]  schedule+0x28/0x80
[958795.885802]  autofs_wait+0x324/0x7c0 [autofs4]
[958795.890303]  ? finish_wait+0x80/0x80
[958795.893925]  ? autofs_mount_wait+0x56/0xe0 [autofs4]
[958795.898935]  autofs_mount_wait+0x56/0xe0 [autofs4]
[958795.903775]  autofs_d_manage+0x95/0x1b0 [autofs4]
[958795.908547]  follow_managed+0xcf/0x300
[958795.912344]  walk_component+0x223/0x4a0
[958795.916238]  link_path_walk.part.42+0x2b9/0x520
[958795.920818]  path_lookupat.isra.46+0x93/0x220
[958795.925246]  filename_lookup.part.60+0xa0/0x170
[958795.929835]  ? __check_object_size+0x15d/0x189
[958795.934346]  ? audit_alloc_name+0x7e/0xd0
[958795.938399]  ? path_get+0x11/0x30
[958795.941760]  ? __audit_getname+0x96/0xb0
[958795.945758]  vfs_statx+0x73/0xe0
[958795.949038]  __do_sys_newstat+0x39/0x70
[958795.952950]  ? syscall_trace_enter+0x1d3/0x2c0
[958795.957449]  ? __audit_syscall_exit+0x228/0x290
[958795.962017]  do_syscall_64+0x53/0x100
[958795.965759]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958795.970858] RIP: 0033:0x7fb3292a4015
[958795.974483] Code: Bad RIP value.
[958795.977757] RSP: 002b:00007ffe795020f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
[958795.985349] RAX: ffffffffffffffda RBX: 0000564e2d0409c0 RCX: 00007fb3292a4015
[958795.992504] RDX: 00007ffe79502110 RSI: 00007ffe79502110 RDI: 0000564e2d0409c0
[958795.999661] RBP: 00007ffe79502110 R08: 0000564e2d0409f0 R09: 0000000000032e00
[958796.006815] R10: 0000564e2ce88fc0 R11: 0000000000000246 R12: 0000000000000000
[958796.013977] R13: 0000564e2cfd20a0 R14: 00007fb32a172890 R15: 00007fb32a26be70
[958796.021157] eexec           D    0 56776  56775 0x00000080
[958796.026684] Call Trace:
[958796.029204]  ? __schedule+0x2a2/0x870
[958796.032914]  ? kmem_cache_alloc+0x15c/0x1c0
[958796.037153]  schedule+0x28/0x80
[958796.040378]  autofs_wait+0x324/0x7c0 [autofs4]
[958796.044860]  ? finish_wait+0x80/0x80
[958796.048497]  ? autofs_mount_wait+0x56/0xe0 [autofs4]
[958796.053505]  autofs_mount_wait+0x56/0xe0 [autofs4]
[958796.058362]  autofs_d_manage+0x95/0x1b0 [autofs4]
[958796.063100]  follow_managed+0xcf/0x300
[958796.066896]  walk_component+0x223/0x4a0
[958796.070791]  link_path_walk.part.42+0x2b9/0x520
[958796.075373]  path_lookupat.isra.46+0x93/0x220
[958796.079838]  ? __rpc_wait_for_completion_task+0x30/0x30 [sunrpc]
[958796.085886]  filename_lookup.part.60+0xa0/0x170
[958796.090458]  ? __check_object_size+0x15d/0x189
[958796.094936]  ? audit_alloc_name+0x7e/0xd0
[958796.099001]  ? path_get+0x11/0x30
[958796.102391]  ? __audit_getname+0x96/0xb0
[958796.106357]  vfs_statx+0x73/0xe0
[958796.109636]  __do_sys_newstat+0x39/0x70
[958796.113535]  ? syscall_trace_enter+0x1d3/0x2c0
[958796.118048]  ? __audit_syscall_exit+0x228/0x290
[958796.122615]  do_syscall_64+0x53/0x100
[958796.126319]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958796.131404] RIP: 0033:0x7f2a5659e015
[958796.135059] Code: Bad RIP value.
[958796.138332] RSP: 002b:00007ffe6742f068 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
[958796.145911] RAX: ffffffffffffffda RBX: 000056176a71b5f0 RCX: 00007f2a5659e015
[958796.153066] RDX: 00007ffe6742f080 RSI: 00007ffe6742f080 RDI: 000056176a71b5f0
[958796.160224] RBP: 00007ffe6742f080 R08: 000056176a71a750 R09: 0000000000033900
[958796.167382] R10: 000056176a316fc0 R11: 0000000000000246 R12: 0000000000000000
[958796.174541] R13: 000056176a6e30a0 R14: 00007f2a5746e5d0 R15: 00007f2a57565e70
[958796.181709] eexec           D    0 56780  56778 0x00000080
[958796.187235] Call Trace:
[958796.189755]  ? __schedule+0x2a2/0x870
[958796.193472]  ? kmem_cache_alloc+0x15c/0x1c0
[958796.197715]  schedule+0x28/0x80
[958796.200938]  autofs_wait+0x324/0x7c0 [autofs4]
[958796.205438]  ? finish_wait+0x80/0x80
[958796.209059]  ? autofs_mount_wait+0x56/0xe0 [autofs4]
[958796.214070]  autofs_mount_wait+0x56/0xe0 [autofs4]
[958796.218909]  autofs_d_manage+0x95/0x1b0 [autofs4]
[958796.223661]  follow_managed+0xcf/0x300
[958796.227470]  walk_component+0x223/0x4a0
[958796.231364]  link_path_walk.part.42+0x2b9/0x520
[958796.235965]  path_lookupat.isra.46+0x93/0x220
[958796.240406]  ? __rpc_wait_for_completion_task+0x30/0x30 [sunrpc]
[958796.246434]  filename_lookup.part.60+0xa0/0x170
[958796.251018]  ? __check_object_size+0x15d/0x189
[958796.255500]  ? audit_alloc_name+0x7e/0xd0
[958796.259565]  ? path_get+0x11/0x30
[958796.262944]  ? __audit_getname+0x96/0xb0
[958796.266939]  vfs_statx+0x73/0xe0
[958796.270216]  __do_sys_newstat+0x39/0x70
[958796.274115]  ? syscall_trace_enter+0x1d3/0x2c0
[958796.278611]  ? __audit_syscall_exit+0x228/0x290
[958796.283195]  do_syscall_64+0x53/0x100
[958796.286924]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958796.292004] RIP: 0033:0x7f20c7942015
[958796.295667] Code: Bad RIP value.
[958796.298946] RSP: 002b:00007ffc0dff97d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
[958796.306533] RAX: ffffffffffffffda RBX: 00005607ef0fe630 RCX: 00007f20c7942015
[958796.313676] RDX: 00007ffc0dff97f0 RSI: 00007ffc0dff97f0 RDI: 00005607ef0fe630
[958796.320830] RBP: 00007ffc0dff97f0 R08: 00005607ef0959c0 R09: 0000000000033800
[958796.327989] R10: 00005607ee1d4fc0 R11: 0000000000000246 R12: 0000000000000000
[958796.335146] R13: 00005607ef0580a0 R14: 00007f20c880c610 R15: 00007f20c8904e70
[958796.342323] eexec           D    0 66106  66105 0x00000080
[958796.347849] Call Trace:
[958796.350389]  ? __schedule+0x2a2/0x870
[958796.354093]  ? kmem_cache_alloc+0x15c/0x1c0
[958796.358315]  schedule+0x28/0x80
[958796.361541]  autofs_wait+0x324/0x7c0 [autofs4]
[958796.366041]  ? finish_wait+0x80/0x80
[958796.369663]  ? autofs_mount_wait+0x56/0xe0 [autofs4]
[958796.374674]  autofs_mount_wait+0x56/0xe0 [autofs4]
[958796.379499]  autofs_d_manage+0x95/0x1b0 [autofs4]
[958796.384273]  follow_managed+0xcf/0x300
[958796.388083]  walk_component+0x223/0x4a0
[958796.391976]  link_path_walk.part.42+0x2b9/0x520
[958796.396557]  path_lookupat.isra.46+0x93/0x220
[958796.401016]  ? __rpc_wait_for_completion_task+0x30/0x30 [sunrpc]
[958796.407041]  filename_lookup.part.60+0xa0/0x170
[958796.411644]  ? __check_object_size+0x15d/0x189
[958796.416124]  ? audit_alloc_name+0x7e/0xd0
[958796.420190]  ? path_get+0x11/0x30
[958796.423568]  ? __audit_getname+0x96/0xb0
[958796.427566]  vfs_statx+0x73/0xe0
[958796.430845]  __do_sys_newstat+0x39/0x70
[958796.434774]  ? syscall_trace_enter+0x1d3/0x2c0
[958796.439253]  ? __audit_syscall_exit+0x228/0x290
[958796.443833]  do_syscall_64+0x53/0x100
[958796.447571]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958796.452651] RIP: 0033:0x7f79829e9015
[958796.456289] Code: Bad RIP value.
[958796.459581] RSP: 002b:00007fff3de70448 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
[958796.467167] RAX: ffffffffffffffda RBX: 000055db8527b5f0 RCX: 00007f79829e9015
[958796.474334] RDX: 00007fff3de70460 RSI: 00007fff3de70460 RDI: 000055db8527b5f0
[958796.481489] RBP: 00007fff3de70460 R08: 000055db8527a750 R09: 0000000000033900
[958796.488645] R10: 000055db837cffc0 R11: 0000000000000246 R12: 0000000000000000
[958796.495813] R13: 000055db852430a0 R14: 00007f79838b95d0 R15: 00007f79839b0e70
[958796.502991] eexec           D    0 75748  75747 0x00000080
[958796.508500] Call Trace:
[958796.511041]  ? __schedule+0x2a2/0x870
[958796.514765]  ? kmem_cache_alloc+0x15c/0x1c0
[958796.518987]  schedule+0x28/0x80
[958796.522190]  autofs_wait+0x324/0x7c0 [autofs4]
[958796.526674]  ? finish_wait+0x80/0x80
[958796.530290]  ? autofs_mount_wait+0x56/0xe0 [autofs4]
[958796.535286]  autofs_mount_wait+0x56/0xe0 [autofs4]
[958796.540125]  autofs_d_manage+0x95/0x1b0 [autofs4]
[958796.544879]  follow_managed+0xcf/0x300
[958796.548687]  walk_component+0x223/0x4a0
[958796.552581]  link_path_walk.part.42+0x2b9/0x520
[958796.557175]  path_lookupat.isra.46+0x93/0x220
[958796.561636]  ? __rpc_wait_for_completion_task+0x30/0x30 [sunrpc]
[958796.567661]  filename_lookup.part.60+0xa0/0x170
[958796.572260]  ? __check_object_size+0x15d/0x189
[958796.576739]  ? audit_alloc_name+0x7e/0xd0
[958796.580805]  ? path_get+0x11/0x30
[958796.584187]  ? __audit_getname+0x96/0xb0
[958796.588188]  vfs_statx+0x73/0xe0
[958796.591500]  __do_sys_newstat+0x39/0x70
[958796.595398]  ? syscall_trace_enter+0x1d3/0x2c0
[958796.599880]  ? __audit_syscall_exit+0x228/0x290
[958796.604480]  do_syscall_64+0x53/0x100
[958796.608210]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958796.613292] RIP: 0033:0x7f3dfeab9015
[958796.616947] Code: Bad RIP value.
[958796.620225] RSP: 002b:00007ffe588906f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
[958796.627810] RAX: ffffffffffffffda RBX: 0000560adc5dcfa0 RCX: 00007f3dfeab9015
[958796.634966] RDX: 00007ffe58890710 RSI: 00007ffe58890710 RDI: 0000560adc5dcfa0
[958796.642150] RBP: 00007ffe58890710 R08: 0000560adc5a8d50 R09: 0000000000033900
[958796.649305] R10: 0000560ada953fc0 R11: 0000000000000246 R12: 0000000000000000
[958796.656459] R13: 0000560adc5360a0 R14: 00007f3dff9895d0 R15: 00007f3dffa80e70
[958796.663642] umount          D    0 86049  85952 0x80000080
[958796.669153] Call Trace:
[958796.671692]  ? __schedule+0x2a2/0x870
[958796.675400]  schedule+0x28/0x80
[958796.678612]  autofs_wait+0x324/0x7c0 [autofs4]
[958796.683110]  ? finish_wait+0x80/0x80
[958796.686750]  ? autofs_mount_wait+0x56/0xe0 [autofs4]
[958796.691763]  autofs_mount_wait+0x56/0xe0 [autofs4]
[958796.696603]  autofs_d_automount+0xed/0x210 [autofs4]
[958796.701631]  follow_managed+0x187/0x300
[958796.705511]  walk_component+0x223/0x4a0
[958796.709407]  path_lookupat.isra.46+0x6d/0x220
[958796.713816]  ? terminate_walk+0x8a/0x100
[958796.717794]  filename_lookup.part.60+0xa0/0x170
[958796.722394]  ? __check_object_size+0x15d/0x189
[958796.726890]  ? audit_alloc_name+0x7e/0xd0
[958796.730940]  ? path_get+0x11/0x30
[958796.734314]  ? __audit_getname+0x96/0xb0
[958796.738281]  vfs_statx+0x73/0xe0
[958796.741575]  __do_sys_newfstatat+0x31/0x70
[958796.745746]  ? syscall_trace_enter+0x1d3/0x2c0
[958796.750243]  ? _cond_resched+0x15/0x30
[958796.754035]  do_syscall_64+0x53/0x100
[958796.757760]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958796.762858] RIP: 0033:0x7f8d4d4011cb
[958796.766499] Code: Bad RIP value.
[958796.769772] RSP: 002b:00007fffefbc26f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000106
[958796.777343] RAX: ffffffffffffffda RBX: 0000560f50079030 RCX: 00007f8d4d4011cb
[958796.784500] RDX: 00007fffefbc27b0 RSI: 0000560f50079210 RDI: ffffffffffffffff
[958796.791657] RBP: 0000000000000000 R08: 0000000000000800 R09: 0000000000000030
[958796.798813] R10: 0000000000000800 R11: 0000000000000246 R12: 0000560f50079210
[958796.805967] R13: 0000000000000001 R14: 00000000ffffffff R15: 0000000000000000
[958796.813148] eexec           D    0 132499 132498 0x00000080
[958796.818766] Call Trace:
[958796.821286]  ? __schedule+0x2a2/0x870
[958796.825012]  ? kmem_cache_alloc+0x15c/0x1c0
[958796.829234]  schedule+0x28/0x80
[958796.832459]  autofs_wait+0x324/0x7c0 [autofs4]
[958796.836943]  ? finish_wait+0x80/0x80
[958796.840581]  ? autofs_mount_wait+0x56/0xe0 [autofs4]
[958796.845590]  autofs_mount_wait+0x56/0xe0 [autofs4]
[958796.850437]  autofs_d_manage+0x95/0x1b0 [autofs4]
[958796.855191]  follow_managed+0xcf/0x300
[958796.858985]  walk_component+0x223/0x4a0
[958796.862879]  link_path_walk.part.42+0x2b9/0x520
[958796.867462]  path_lookupat.isra.46+0x93/0x220
[958796.871872]  filename_lookup.part.60+0xa0/0x170
[958796.876475]  ? __check_object_size+0x15d/0x189
[958796.880957]  ? audit_alloc_name+0x7e/0xd0
[958796.885023]  ? path_get+0x11/0x30
[958796.888401]  ? __audit_getname+0x96/0xb0
[958796.892383]  vfs_statx+0x73/0xe0
[958796.895678]  __do_sys_newstat+0x39/0x70
[958796.899589]  ? syscall_trace_enter+0x1d3/0x2c0
[958796.904070]  ? __audit_syscall_exit+0x228/0x290
[958796.908653]  do_syscall_64+0x53/0x100
[958796.912398]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958796.917495] RIP: 0033:0x7f8f67535015
[958796.921135] Code: Bad RIP value.
[958796.924416] RSP: 002b:00007fff2888cc48 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
[958796.932003] RAX: ffffffffffffffda RBX: 000055d4ea6f4990 RCX: 00007f8f67535015
[958796.939160] RDX: 00007fff2888cc60 RSI: 00007fff2888cc60 RDI: 000055d4ea6f4990
[958796.946315] RBP: 00007fff2888cc60 R08: 000055d4ea728de0 R09: 0000000000033800
[958796.953473] R10: 000055d4e878bfc0 R11: 0000000000000246 R12: 0000000000000000
[958796.960631] R13: 000055d4ea6b70a0 R14: 00007f8f68404610 R15: 00007f8f684fce70
[958796.967818] eexec           D    0 212445 212444 0x00000080
[958796.973415] Call Trace:
[958796.975954]  ? __schedule+0x2a2/0x870
[958796.979661]  ? kmem_cache_alloc+0x15c/0x1c0
[958796.983902]  schedule+0x28/0x80
[958796.987127]  autofs_wait+0x324/0x7c0 [autofs4]
[958796.991608]  ? finish_wait+0x80/0x80
[958796.995247]  ? autofs_mount_wait+0x56/0xe0 [autofs4]
[958797.000257]  autofs_mount_wait+0x56/0xe0 [autofs4]
[958797.005095]  autofs_d_manage+0x95/0x1b0 [autofs4]
[958797.009870]  follow_managed+0xcf/0x300
[958797.013664]  walk_component+0x223/0x4a0
[958797.017556]  link_path_walk.part.42+0x2b9/0x520
[958797.022137]  path_lookupat.isra.46+0x93/0x220
[958797.026569]  ? __rpc_wait_for_completion_task+0x30/0x30 [sunrpc]
[958797.032596]  filename_lookup.part.60+0xa0/0x170
[958797.037195]  ? __check_object_size+0x15d/0x189
[958797.041675]  ? audit_alloc_name+0x7e/0xd0
[958797.045741]  ? path_get+0x11/0x30
[958797.049120]  ? __audit_getname+0x96/0xb0
[958797.053102]  vfs_statx+0x73/0xe0
[958797.056398]  __do_sys_newstat+0x39/0x70
[958797.060308]  ? syscall_trace_enter+0x1d3/0x2c0
[958797.064786]  ? __audit_syscall_exit+0x228/0x290
[958797.069367]  do_syscall_64+0x53/0x100
[958797.073109]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958797.078190] RIP: 0033:0x7fbcbfbb2015
[958797.081845] Code: Bad RIP value.
[958797.085123] RSP: 002b:00007fffb688c058 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
[958797.092710] RAX: ffffffffffffffda RBX: 00005563e14b2fe0 RCX: 00007fbcbfbb2015
[958797.099869] RDX: 00007fffb688c070 RSI: 00007fffb688c070 RDI: 00005563e14b2fe0
[958797.107024] RBP: 00007fffb688c070 R08: 00005563e14b2f80 R09: 0000000000032900
[958797.114180] R10: 00005563e0ac3fc0 R11: 0000000000000246 R12: 0000000000000000
[958797.121338] R13: 00005563e14790a0 R14: 00007fbcc0a80610 R15: 00007fbcc0b79e70
[958797.128519] umount          D    0 220118 220067 0x00000080
[958797.134115] Call Trace:
[958797.136655]  ? __schedule+0x2a2/0x870
[958797.140378]  ? kmem_cache_alloc+0x15c/0x1c0
[958797.144601]  schedule+0x28/0x80
[958797.147810]  autofs_wait+0x324/0x7c0 [autofs4]
[958797.152307]  ? finish_wait+0x80/0x80
[958797.155945]  ? autofs_mount_wait+0x56/0xe0 [autofs4]
[958797.160959]  autofs_mount_wait+0x56/0xe0 [autofs4]
[958797.165801]  autofs_d_manage+0x95/0x1b0 [autofs4]
[958797.170558]  follow_managed+0xcf/0x300
[958797.174347]  walk_component+0x223/0x4a0
[958797.178228]  path_lookupat.isra.46+0x6d/0x220
[958797.182640]  ? terminate_walk+0x8a/0x100
[958797.186607]  filename_lookup.part.60+0xa0/0x170
[958797.191190]  ? __check_object_size+0x15d/0x189
[958797.195687]  ? audit_alloc_name+0x7e/0xd0
[958797.199736]  ? path_get+0x11/0x30
[958797.203114]  ? __audit_getname+0x96/0xb0
[958797.207110]  vfs_statx+0x73/0xe0
[958797.210399]  __do_sys_newfstatat+0x31/0x70
[958797.214540]  ? syscall_trace_enter+0x1d3/0x2c0
[958797.219021]  ? _cond_resched+0x15/0x30
[958797.222848]  do_syscall_64+0x53/0x100
[958797.226560]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[958797.231641] RIP: 0033:0x7f274edda1cb
[958797.235296] Code: Bad RIP value.
[958797.238574] RSP: 002b:00007fff62d65948 EFLAGS: 00000246 ORIG_RAX: 0000000000000106
[958797.246149] RAX: ffffffffffffffda RBX: 0000559ae41c2030 RCX: 00007f274edda1cb
[958797.253304] RDX: 00007fff62d65a00 RSI: 0000559ae41c2210 RDI: ffffffffffffffff
[958797.260459] RBP: 0000000000000000 R08: 0000000000000800 R09: 0000000000000030
[958797.267614] R10: 0000000000000800 R11: 0000000000000246 R12: 0000559ae41c2210
[958797.274778] R13: 0000000000000001 R14: 00000000ffffffff R15: 0000000000000000

--k4f25fnPtRuIRUb3--
