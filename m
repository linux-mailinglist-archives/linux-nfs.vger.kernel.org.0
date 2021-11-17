Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A129B454844
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Nov 2021 15:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbhKQOPd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Nov 2021 09:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbhKQOPb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Nov 2021 09:15:31 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA51C061764
        for <linux-nfs@vger.kernel.org>; Wed, 17 Nov 2021 06:12:33 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 30BB6A71; Wed, 17 Nov 2021 09:12:31 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 30BB6A71
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1637158351;
        bh=YeR+72LB2JUublwWLjLNwAfQLOfx1B3JvPLk7spqDFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eur6iy2/NfpXQAR1eg0Gtw1kj3w7VUlVqtSconCRovlNAMfo7fHSL6J8j/FAvp5RK
         GipD7EimGZKga7yjQrqVfGeZg9eDBOOQFeasTnDRGGNNrjQgOXN8SyZCllX1hRHFdZ
         unDMTAho4OUQ0c3pl8B0a/BaWoM692SGFa2UNPVI=
Date:   Wed, 17 Nov 2021 09:12:31 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 00/14] SUNRPC: clean up server thread management.
Message-ID: <20211117141231.GA24762@fieldses.org>
References: <163710954700.5485.5622638225352156964.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163710954700.5485.5622638225352156964.stgit@noble.brown>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Nov 17, 2021 at 11:46:49AM +1100, NeilBrown wrote:
> I have a dream of making nfsd threads start and stop dynamically.

It's a good dream!

I haven't had a chance to look at these at all yet, I just kicked off
tests to run overnight, and woke up to the below.

This happened on the client, probably the first time it attempted to do
an nfsv4 mount, so something went wrong with setup of the callback
server.

--b.

[  285.585061] divide error: 0000 [#1] PREEMPT SMP KASAN PTI
[  285.585754] CPU: 0 PID: 5864 Comm: mount.nfs Not tainted 5.16.0-rc1-00014-g659e13af1f87 #1017
[  285.586828] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-3.fc34 04/01/2014
[  285.587828] RIP: 0010:svc_pool_for_cpu+0xc7/0x1b0 [sunrpc]
[  285.588501] Code: 8b ab f0 00 00 00 48 ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 0f b6 14 11 84 d2 74 09 80 fa 03 0f 8e 8d 00 00 00 31 d2 <f7> b3 e8 00 00 00 48 83 c4 08 5b 48 8d 04 52 48 c1 e0 06 48 01 e8
[  285.590820] RSP: 0018:ffff88801526f8f8 EFLAGS: 00010246
[  285.591418] RAX: 0000000000000000 RBX: ffff88800db3bc00 RCX: 1ffff11001b6779d
[  285.592267] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88800db3bce8
[  285.593145] RBP: 0000000000000010 R08: 0000000000000001 R09: ffff888014b7403f
[  285.594057] R10: ffffed100296e807 R11: 0000000000000001 R12: ffff888014b74038
[  285.594940] R13: ffff888014b74010 R14: ffff888014b74000 R15: ffff88800db3bc00
[  285.595826] FS:  00007f489f68a440(0000) GS:ffff88806d400000(0000) knlGS:0000000000000000
[  285.596851] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  285.597578] CR2: 00007f2dffa0b198 CR3: 000000000c486003 CR4: 0000000000170ef0
[  285.598510] Call Trace:
[  285.598824]  <TASK>
[  285.599097]  svc_xprt_do_enqueue+0x164/0x900 [sunrpc]
[  285.599767]  svc_xprt_received+0x181/0x3a0 [sunrpc]
[  285.600411]  _svc_create_xprt+0x2bd/0x740 [sunrpc]
[  285.601049]  ? svc_add_new_perm_xprt+0x140/0x140 [sunrpc]
[  285.601787]  ? lock_release+0x3b8/0x6d0
[  285.602318]  ? nfs_callback_up+0x7ad/0xdb0 [nfsv4]
[  285.603617]  svc_create_xprt+0x36/0x90 [sunrpc]
[  285.604306]  nfs_callback_up+0x81f/0xdb0 [nfsv4]
[  285.604972]  nfs4_init_client+0x1db/0x450 [nfsv4]
[  285.605605]  ? nfs41_init_client+0x70/0x70 [nfsv4]
[  285.606304]  nfs4_set_client+0x25f/0x410 [nfsv4]
[  285.606912]  ? nfs4_add_trunk.isra.0+0x280/0x280 [nfsv4]
[  285.607606]  nfs4_create_server+0x5f0/0xda0 [nfsv4]
[  285.608250]  ? lock_is_held_type+0xd7/0x130
[  285.608786]  ? nfs4_server_common_setup+0x670/0x670 [nfsv4]
[  285.609505]  ? __module_get+0x47/0x60
[  285.610077]  nfs4_try_get_tree+0xd3/0x250 [nfsv4]
[  285.610690]  vfs_get_tree+0x8a/0x2d0
[  285.611152]  path_mount+0x3f9/0x19e0
[  285.611608]  ? debug_check_no_obj_freed+0x1f3/0x3c0
[  285.612227]  ? lock_is_held_type+0xd7/0x130
[  285.612757]  ? finish_automount+0x8c0/0x8c0
[  285.613281]  ? user_path_at_empty+0x45/0x50
[  285.613832]  ? rcu_read_lock_sched_held+0x3f/0x70
[  285.614456]  ? kmem_cache_free+0xd9/0x1b0
[  285.614965]  __x64_sys_mount+0x1d6/0x240
[  285.615455]  ? path_mount+0x19e0/0x19e0
[  285.615941]  ? syscall_enter_from_user_mode+0x1d/0x50
[  285.616572]  do_syscall_64+0x43/0x90
[  285.617043]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  285.617693] RIP: 0033:0x7f489fd4182e
[  285.618206] Code: 48 8b 0d 4d 16 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1a 16 0c 00 f7 d8 64 89 01 48
[  285.620595] RSP: 002b:00007ffdc3bdd5b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[  285.621532] RAX: ffffffffffffffda RBX: 00007ffdc3bdd750 RCX: 00007f489fd4182e
[  285.622492] RDX: 000055da46c0a510 RSI: 000055da46c0a550 RDI: 000055da46c0c2f0
[  285.623372] RBP: 00007ffdc3bdd750 R08: 000055da46c0d050 R09: 0037332e3232312e
[  285.624271] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  285.625158] R13: 00007ffdc3bdd660 R14: 000055da46c0ce00 R15: 000055da46c0ce90
[  285.626097]  </TASK>
[  285.626381] Modules linked in: nfsv4 rpcsec_gss_krb5 nfsv3 nfs_acl nfs lockd grace auth_rpcgss sunrpc
[  285.627622] ---[ end trace 0ea273cc87891325 ]---
[  285.628222] RIP: 0010:svc_pool_for_cpu+0xc7/0x1b0 [sunrpc]
[  285.628945] Code: 8b ab f0 00 00 00 48 ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 0f b6 14 11 84 d2 74 09 80 fa 03 0f 8e 8d 00 00 00 31 d2 <f7> b3 e8 00 00 00 48 83 c4 08 5b 48 8d 04 52 48 c1 e0 06 48 01 e8
[  285.631830] RSP: 0018:ffff88801526f8f8 EFLAGS: 00010246
[  285.632557] RAX: 0000000000000000 RBX: ffff88800db3bc00 RCX: 1ffff11001b6779d
[  285.634319] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88800db3bce8
[  285.635430] RBP: 0000000000000010 R08: 0000000000000001 R09: ffff888014b7403f
[  285.636408] R10: ffffed100296e807 R11: 0000000000000001 R12: ffff888014b74038
[  285.637369] R13: ffff888014b74010 R14: ffff888014b74000 R15: ffff88800db3bc00
[  285.638346] FS:  00007f489f68a440(0000) GS:ffff88806d400000(0000) knlGS:0000000000000000
[  285.639434] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  285.640233] CR2: 00007f2dffa0b198 CR3: 000000000c486003 CR4: 0000000000170ef0
[  285.641194] note: mount.nfs[5864] exited with preempt_count 1
[  562.003788] kworker/dying (773) used greatest stack depth: 23128 bytes left
[ 1356.888419] clocksource: timekeeping watchdog on CPU1: acpi_pm retried 2 times before success
[ 2396.888656] clocksource: timekeeping watchdog on CPU1: acpi_pm retried 2 times before success
[ 3071.387007] clocksource: timekeeping watchdog on CPU0: acpi_pm retried 2 times before success
[ 3074.395010] clocksource: timekeeping watchdog on CPU0: acpi_pm retried 2 times before success
[ 3082.395298] clocksource: timekeeping watchdog on CPU0: acpi_pm retried 2 times before success
[ 5736.389488] clocksource: timekeeping watchdog on CPU0: acpi_pm retried 2 times before success
[root@test3 ~]# uname -a
Linux test3.fieldses.org 5.16.0-rc1-00014-g659e13af1f87 #1017 SMP PREEMPT Tue Nov 16 20:51:49 EST 2021 x86_64 x86_64 x86_64 GNU/Linux
