Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 027BC5B6C4
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2019 10:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfGAIZ4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Jul 2019 04:25:56 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:40725 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728053AbfGAIZ4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Jul 2019 04:25:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=caspar@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TVgqG1l_1561969547;
Received: from linux.alibaba.com(mailfrom:caspar@linux.alibaba.com fp:SMTPD_---0TVgqG1l_1561969547)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Jul 2019 16:25:48 +0800
Date:   Mon, 1 Jul 2019 16:25:47 +0800
From:   Caspar Zhang <caspar@linux.alibaba.com>
To:     Yihao Wu <wuyihao@linux.alibaba.com>
Cc:     Greg KH <greg@kroah.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        caspar@linux.alibaba.com, linux-nfs@vger.kernel.org
Subject: Re: [backport request][stable] SUNRPC: Clean up initialisation of
 the struct rpc_rqst
Message-ID: <20190701082547.GA89243@linux.alibaba.com>
References: <1b4585b9-401a-9022-6bc9-5ecbe253799d@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b4585b9-401a-9022-6bc9-5ecbe253799d@linux.alibaba.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 01, 2019 at 01:27:26AM +0800, Yihao Wu wrote:
> Hi,
>
> I'm using kernel v4.19.y and find that v4.19.y panic when mounting NFSv4, which can be simply reproduced as follows:
>
>
> while :; do
> mkfs.ext4 -F /dev/vdb
> mount /dev/vdb /tmp/mymnt_server
> exportfs -o insecure,rw,sync,no_root_squash,fsid=1 127.0.0.1:/tmp/mymnt_server
> mount -t nfs4 -o minorversion=0 127.0.0.1:/tmp/mymnt_server /tmp/mymnt_client
> umount -f -l /tmp/mymnt_client
> sleep 0.5
> exportfs -r
> sleep 0.2
> umount -f -l /tmp/mymnt_server
> done
>
>
> # kernel 4.19.y
> After a while, the kernel panic.

This is a Regression, introduced by the following commit:

    NFS4: Fix v4.0 client state corruption when mount

in v4.19.46[1].

The interesting part is, looks like commit 9dc6edcf676("SUNRPC: Clean up
initialisation of the struct rpc_rqst")[2] is not targeted to fix this
regression, but a general clean-up fix, maybe that explains somehow we
missed this fix in stable tree ;-)

Since this is a Regression in stable tree, I strongly suggest we put the
fix commit into 4.19. Greg, Trond, any comments?

Thanks,
Caspar


[1] https://lore.kernel.org/patchwork/patch/1086274/
[2] https://github.com/torvalds/linux/commit/9dc6edcf676fe188430e8b119f91280bbf285163


>
> [ 6049.676833] EXT4-fs (vdb): mounted filesystem with ordered data mode. Opts: (null)
> [ 6049.747488] EXT4-fs (vdc): mounted filesystem with ordered data mode. Opts: (null)
> [ 6050.248646] NFSD: starting 90-second grace period (net f0000098)
> [ 6051.348206] BUG: unable to handle kernel NULL pointer dereference at 00000000000006d8
> [ 6051.349582] PGD 0 P4D 0
> [ 6051.350279] Oops: 0000 [#1] SMP KASAN PTI
> [ 6051.351102] CPU: 7 PID: 8168 Comm: kworker/u16:3 Kdump: loaded Not tainted 4.19.48-0.267.git.c08655b39.al7.x86_64.debug #1
> [ 6051.352534] Hardware name: Alibaba Cloud Alibaba Cloud ECS, BIOS rel-1.7.5-0-ge51488c-20140602_164612-nilsson.home.kraxel.org 04/01/2014
> [ 6051.354746] Workqueue: rpciod rpc_async_schedule [sunrpc]
> [ 6051.355844] RIP: 0010:__lock_acquire+0x2f0/0x820
> [ 6051.356892] Code: 12 05 00 00 45 31 f6 85 c9 48 8b 85 00 09 00 00 0f 85 b8 00 00 00 48 85 c0 0f 85 da 01 00 00 41 be 01 00 00 00 e9 a4 00 00 00 <49> 81 3c 24 c0 05 e1 b7 b8 00 00 00 00 44 0f 44 c0 83 fe 01 0f 87
> [ 6051.359845] RSP: 0018:ffff8883e6a4fce0 EFLAGS: 00010002
> [ 6051.361045] RAX: 0000000000000001 RBX: 0000000000000246 RCX: 0000000000000000
> [ 6051.362426] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000006d8
> [ 6051.363811] RBP: ffff8883ca280000 R08: 0000000000000001 R09: 0000000000000000
> [ 6051.365213] R10: ffffed107dd7c0f6 R11: ffffed107dd7c0f6 R12: 00000000000006d8
> [ 6051.366617] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [ 6051.368036] FS:  0000000000000000(0000) GS:ffff8883eea00000(0000) knlGS:0000000000000000
> [ 6051.369609] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 6051.370959] CR2: 00000000000006d8 CR3: 00000001ff216001 CR4: 00000000003606a0
> [ 6051.372446] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 6051.373946] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 6051.375439] Call Trace:
> [ 6051.376583]  ? kvm_sched_clock_read+0x14/0x30
> [ 6051.377891]  lock_acquire+0xc8/0x1e0
> [ 6051.379162]  ? xprt_release+0x5b/0x360 [sunrpc]
> [ 6051.380531]  _raw_spin_lock+0x39/0x70
> [ 6051.381827]  ? xprt_release+0x5b/0x360 [sunrpc]
> [ 6051.383199]  xprt_release+0x5b/0x360 [sunrpc]
> [ 6051.384565]  rpc_release_resources_task+0xe/0x40 [sunrpc]
> [ 6051.386029]  __rpc_execute+0x1fe/0x520 [sunrpc]
> [ 6051.387429]  process_one_work+0x22f/0x600
> [ 6051.388788]  ? process_one_work+0x19a/0x600
> [ 6051.390172]  worker_thread+0x179/0x3f0
> [ 6051.391514]  kthread+0x114/0x150
> [ 6051.392829]  ? process_one_work+0x600/0x600
> [ 6051.394234]  ? kthread_park+0x80/0x80
> [ 6051.395602]  ret_from_fork+0x3a/0x50
> [ 6051.396968] Modules linked in: nfsv3 nfsd rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace hid_generic usbhid button sunrpc uhci_hcd ehci_pci ehci_hcd
>
>
> # kernel 5.0.16
> Kernel doesn't panic
>
>
> rpc_task is initialized in call_reserve, but rpc_task->tk_xprt is not initialized until call_reserveresult.
> When xprt_release is called between calling call_reserve and call_reserveresult, tk_xprt is still NULL.
> So spin_lock(&xprt->recv_lock) in xprt_release causes kernel panic.
>
> I notice that v4.20 has already fixed this issue with commit 9dc6edcf676fe188430e8b119f91280bbf285163
>
> But this patch do not cc stable@vger.kernel.org (why? forgotten?). And will v4.19.y consider to backport this patch?
>
>
> Thanks,
> Yihao Wu

--
        Thanks,
        Caspar
