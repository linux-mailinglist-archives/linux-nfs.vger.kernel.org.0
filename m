Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C76A962F4
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2019 16:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbfHTOtQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Aug 2019 10:49:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729260AbfHTOtQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 20 Aug 2019 10:49:16 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 677A318C8905;
        Tue, 20 Aug 2019 14:49:16 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-112-21.rdu2.redhat.com [10.10.112.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C2EF177D43;
        Tue, 20 Aug 2019 14:49:15 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trond.myklebust@hammerspace.com>
Cc:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Lockdep pop on nfs4_proc_link
Date:   Tue, 20 Aug 2019 10:49:13 -0400
Message-ID: <39472818-F73F-4E52-BC97-625C38CB140B@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Tue, 20 Aug 2019 14:49:16 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I just had this one pop up:

[  439.768290] ====================================
[  439.769027] WARNING: ln/1431 still has locks held!
[  439.769802] 5.3.0-rc5.d1abaeb3be #1 Not tainted
[  439.770586] ------------------------------------
[  439.771362] 3 locks held by ln/1431:
[  439.771925]  #0: 000000007cfdaccc (sb_writers#21){.+.+}, at: 
mnt_want_write+0x20/0x50
[  439.773238]  #1: 0000000082e25c62 
(&type->i_mutex_dir_key#11/1){+.+.}, at: filename_create+0x7f/0x160
[  439.774716]  #2: 00000000980e7edc 
(&sb->s_type->i_mutex_key#22){++++}, at: vfs_link+0x175/0x320
[  439.775996]
                stack backtrace:
[  439.776667] CPU: 1 PID: 1431 Comm: ln Not tainted 
5.3.0-rc5.d1abaeb3be #1
[  439.777653] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.10.2-2.fc27 04/01/2014
[  439.778977] Call Trace:
[  439.779341]  dump_stack+0x85/0xcb
[  439.779837]  nfs4_handle_exception+0x1df/0x250 [nfsv4]
[  439.780585]  nfs4_proc_link+0x7a/0xa0 [nfsv4]
[  439.781234]  nfs_link+0x74/0x230 [nfs]
[  439.781818]  vfs_link+0x22b/0x320
[  439.782338]  do_linkat+0x212/0x330
[  439.782830]  __x64_sys_linkat+0x20/0x30
[  439.783396]  do_syscall_64+0x75/0x320
[  439.783935]  ? trace_hardirqs_off_thunk+0x1a/0x20
[  439.784612]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  439.785393] RIP: 0033:0x7f5ed9fb742a
[  439.785943] Code: 48 8b 0d 59 7a 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 
66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 09 01 00 00 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 26 7a 2c 00 f7 d8 64 89 01 48
[  439.788627] RSP: 002b:00007ffec9cddd08 EFLAGS: 00000246 ORIG_RAX: 
0000000000000109
[  439.789722] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
00007f5ed9fb742a
[  439.790759] RDX: 00000000ffffff9c RSI: 00007ffec9cdf601 RDI: 
00000000ffffff9c
[  439.791807] RBP: 00000000ffffff9c R08: 0000000000000000 R09: 
0000000000000000
[  439.792833] R10: 000055a57e85f430 R11: 0000000000000246 R12: 
000055a57e85f430
[  439.793869] R13: 0000000000000000 R14: 00007ffec9cdf601 R15: 
00000000ffffff9c

When we did commit "0688e64bc600 NFS: Allow signal interruption of
NFS4ERR_DELAYed operations", we moved from
freezable_schedule_timeout_killable_unsafe() to
freezable_schedule_timeout_interruptible().  There isn't a
freezable_schedule_timeout_interruptible_unsafe(), and the comments in
freezer.h suggest we shouldn't really add one, however those comments 
are
from the same commit that added the unsafe helpers for NFS.

So far, this is the only proc that has popped that warning for me, but 
that
is likely because I don't often see NFS4ERR_DELAY.

Should we create a freezable_schedule_timeout_interruptible_unsafe() for
now, or live with the future lockdep warnings?

Ben
