Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACBD427AA4
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Oct 2021 15:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhJINhe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 9 Oct 2021 09:37:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49889 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233288AbhJINhe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 9 Oct 2021 09:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633786537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ivS7XRKgWFCmcp0qqM9PhriXmSopuUYIDbFcM50lx3Q=;
        b=WDAKGdouQMlKY4wO0mlxGtvv1iZ7Ld5SdK0AWY/fXObp4QLQCVM51tAFcWsPN4ls4y3YJx
        OZWvAVNCCN/HnrWgto/RX6gdNzGbescFPha1UzzzSS9bpRnGDMkYfqE7tuHdzk60iaaEwc
        u7VPTysZrHbp56bUbbji19c2NoCpoJ0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-SJo6MoQ6PSufdyDO89ybdw-1; Sat, 09 Oct 2021 09:35:35 -0400
X-MC-Unique: SJo6MoQ6PSufdyDO89ybdw-1
Received: by mail-ed1-f72.google.com with SMTP id 2-20020a508e02000000b003d871759f5dso11652838edw.10
        for <linux-nfs@vger.kernel.org>; Sat, 09 Oct 2021 06:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ivS7XRKgWFCmcp0qqM9PhriXmSopuUYIDbFcM50lx3Q=;
        b=LIznJiwtghbi6GK3Jjsh0gfa0cQtOm5+foNkfcPZY5WYbGVy2g33p0Z3iUGV84PSsf
         MmgSXQ3Vh1DHOAZNLdw4outQ7gxQHUgVRZzqARlBrvlH9AtlSmAM/s+DPpB5OrfjbEyR
         f4X9pszcgiKgxayprOjtmgpFq6tNC7KLcxeALlVmbeGXLGIJeXVTPAnj70HsWmruG/zK
         XWH3zmnluKlYso1ov4vPEcfzt9sSPU1m1/hfCwsc9T0J7P4lk6MWQPqao0vgb+Vk75rB
         YIhbJ7jtdw06sHWZFE74G3t/wDuCpB/zVR31mrfw3fVSHHcx2KOFaHyTwf9y+sVII14E
         yaEg==
X-Gm-Message-State: AOAM5337i0JDxBUF+f+NsxqNgWBr8/BxXuGZVFZ8SMpUHxE721iwcvI4
        ryqkWJmOK2GAHhKxqjRwLOood17XKZQQK8DKcbCfvjMAgpBILOmGQmacK3NGUQGAFOh/feJjtmp
        NH5YR3kE50Vp6uTBRTtbUAGyfsp7F0x7TQPLd
X-Received: by 2002:a17:906:585a:: with SMTP id h26mr11783370ejs.31.1633786534533;
        Sat, 09 Oct 2021 06:35:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaJ32sUnCQtjKTdriX4AU181fGLRx44VwY7EBbMPNVazdCoCQzclQLxQC0tPuegvAlWPIlR4+RBAP0KFjMgBU=
X-Received: by 2002:a17:906:585a:: with SMTP id h26mr11783344ejs.31.1633786534316;
 Sat, 09 Oct 2021 06:35:34 -0700 (PDT)
MIME-Version: 1.0
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Sat, 9 Oct 2021 09:34:58 -0400
Message-ID: <CALF+zOmahudY07tTDGcu7GFvKOOYUbboKoKk6dwhuCkGTXCUcA@mail.gmail.com>
Subject: Oops in nfs_scan_commit running xfstest generic/005 with NFSv4.2 and
 hammerspace flexfiles server
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond,

I wonder if you are aware of this or not.

This week I ran a lot of xfstests with hammerspace and other servers
without any issues and just now seeing this oops (after rebuilding
from a base of your testing branch at 0abb8895b065).  I then re-built
with just your testing branch and got the same oops.  Same test passes
on 5.14.0-rc4 (vanilla), as well as previous kernels I used at
BakeAthon with the fscache and readahead patches only.  It reliably
panics for me so let me know if you want any more info or a
reproduction with tracepoints, etc.  FYI, I don't think the server
matters because I can also reproduce with a rhel8 server
(kernel-4.18.0-305.19.1.el8_4) and I can also just run 'generic/005'
directly - previous tests don't matter.

[   15.767423] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[   28.614447] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver
Registering...
[   30.024616] run fstests generic/001 at 2021-10-09 09:01:14
[   37.188167] run fstests generic/002 at 2021-10-09 09:01:21
[   38.372767] run fstests generic/003 at 2021-10-09 09:01:23
[   38.713218] run fstests generic/004 at 2021-10-09 09:01:23
[   39.065705] run fstests generic/005 at 2021-10-09 09:01:23
[   39.799076] general protection fault, probably for non-canonical
address 0xffe826e8e8e7897c: 0000 [#1] SMP PTI
[   39.805058] CPU: 0 PID: 6213 Comm: rm Kdump: loaded Not tainted
5.15.0-rc4-trond-testing+ #76
[   39.808300] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.14.0-4.fc34 04/01/2014
[   39.810819] RIP: 0010:__mutex_lock.constprop.0+0x97/0x3e0
[   39.812438] Code: 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 65 48 8b
04 25 c0 7b 01 00 48 8b 00 a8 08 75 1d 49 8b 06 48 83 e0 f8 0f 84 79
02 00 00 <8b> 50 34 85 d2 0f 85 5c 02 00 00 e8 59 8f 55 ff 65 48 8b 04
25 c0
[   39.817418] RSP: 0018:ffffbb8e4558bcd0 EFLAGS: 00010286
[   39.818546] RAX: ffe826e8e8e78948 RBX: ffffbb8e4558bd70 RCX: ffff932e89300000
[   39.820087] RDX: ffff932e89300000 RSI: ffe826e8e8e78948 RDI: ffff932eae01edf0
[   39.821583] RBP: ffffbb8e4558bd28 R08: 0000000000000001 R09: ffffbb8e4558bca0
[   39.823091] R10: 000000000000001d R11: ffffffffffffcfcf R12: 0000000000000000
[   39.824796] R13: 0000000000000000 R14: ffff932eae01edf0 R15: 0000000000000000
[   39.826318] FS:  00007fac7df09740(0000) GS:ffff932ff7c00000(0000)
knlGS:0000000000000000
[   39.828037] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.829275] CR2: 0000555f9b7e2018 CR3: 000000011dc96005 CR4: 0000000000770ef0
[   39.830787] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   39.832275] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   39.833756] PKRU: 55555554
[   39.834377] Call Trace:
[   39.836219]  ? security_inode_permission+0x30/0x50
[   39.837365]  nfs_scan_commit+0x36/0xa0 [nfs]
[   39.838367]  __nfs_commit_inode+0xf8/0x160 [nfs]
[   39.839417]  nfs_wb_all+0xa6/0xf0 [nfs]
[   39.840309]  nfs4_inode_return_delegation+0x58/0x80 [nfsv4]
[   39.841554]  nfs4_proc_remove+0xd1/0xe0 [nfsv4]
[   39.842589]  nfs_unlink+0xec/0x2d0 [nfs]
[   39.843461]  vfs_unlink+0x113/0x230
[   39.844245]  do_unlinkat+0x170/0x280
[   39.845040]  __x64_sys_unlinkat+0x33/0x60
[   39.845922]  do_syscall_64+0x3b/0x90
[   39.846726]  entry_SYSCALL_64_after_hwframe+0x44/0xae


# ./scripts/faddr2line fs/nfs/nfs.ko nfs_scan_commit+0x36
nfs_scan_commit+0x36/0xa0:
nfs_scan_commit at /mnt/build/kernel/fs/nfs/write.c:1078
(inlined by) nfs_scan_commit at /mnt/build/kernel/fs/nfs/write.c:1070


   1060 /*
   1061  * nfs_scan_commit - Scan an inode for commit requests
   1062  * @inode: NFS inode to scan
   1063  * @dst: mds destination list
   1064  * @cinfo: mds and ds lists of reqs ready to commit
   1065  *
   1066  * Moves requests from the inode's 'commit' request list.
   1067  * The requests are *not* checked to ensure that they form a
contiguous set.
   1068  */
   1069 int
   1070 nfs_scan_commit(struct inode *inode, struct list_head *dst,
   1071                 struct nfs_commit_info *cinfo)
   1072 {
   1073         int ret = 0;
   1074
   1075         if (!atomic_long_read(&cinfo->mds->ncommit))
   1076                 return 0;
   1077         mutex_lock(&NFS_I(cinfo->inode)->commit_mutex);
   1078         if (atomic_long_read(&cinfo->mds->ncommit) > 0) {
   1079                 const int max = INT_MAX;
   1080
   1081                 ret = nfs_scan_commit_list(&cinfo->mds->list, dst,
   1082                                            cinfo, max);
   1083                 ret += pnfs_scan_commit_lists(inode, cinfo, max - ret);
   1084         }
   1085         mutex_unlock(&NFS_I(cinfo->inode)->commit_mutex);
   1086         return ret;
   1087 }

