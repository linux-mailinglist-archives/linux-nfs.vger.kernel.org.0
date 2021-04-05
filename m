Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9158E35426B
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Apr 2021 15:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbhDENov (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Apr 2021 09:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbhDENov (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Apr 2021 09:44:51 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BFCC061756
        for <linux-nfs@vger.kernel.org>; Mon,  5 Apr 2021 06:44:44 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 07AE36191; Mon,  5 Apr 2021 09:44:43 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 07AE36191
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1617630283;
        bh=+PEGpkiMPvthwr0G9nHn4hdt/Mh4kYlc2z/YAyyX314=;
        h=Date:To:Subject:From:From;
        b=DX0rMKGvbR9/72Yb/z+zXLzi0x/ar7iK42GC4NHNtKO7Ekx2B/tMzmWM/X0vw1dj2
         SsJrkU4zYzW+p/TzGn9z2yhdHSzOXNFG/aF3u+NpKi+3tDFs2+hwUMa3Kg6Gh4taoC
         6gyZxc995Xu70txH+4ySPJQnwAABs/lfKisAHDAU=
Date:   Mon, 5 Apr 2021 09:44:42 -0400
To:     linux-nfs@vger.kernel.org
Subject: v5.12-rc4 slab-out-of-bounds in xdr_set_page_base
Message-ID: <20210405134442.GA17752@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'm getting the following on an NFS client under testing, is it anything
known?

Not sure yet exactly which test is triggering it or when it started
happening; I'll follow up when I figure that out.

--b.

[ 1001.688041] ==================================================================
[ 1001.689529] BUG: KASAN: slab-out-of-bounds in xdr_set_page_base+0x339/0x350 [sunrpc]
[ 1001.691017] Read of size 8 at addr ffff88800dd8fe80 by task kworker/u4:1/25

[ 1001.692517] CPU: 0 PID: 25 Comm: kworker/u4:1 Not tainted 5.12.0-rc4-45853-g62007e38c8d6 #3177
[ 1001.694121] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-1.fc33 04/01/2014
[ 1001.695676] Workqueue: rpciod rpc_async_schedule [sunrpc]
[ 1001.696776] Call Trace:
[ 1001.697176]  dump_stack+0x93/0xc2
[ 1001.697762]  print_address_description.constprop.0+0x18/0x110
[ 1001.698511]  ? xdr_set_page_base+0x339/0x350 [sunrpc]
[ 1001.699216]  ? xdr_set_page_base+0x339/0x350 [sunrpc]
[ 1001.700665]  kasan_report.cold+0x7c/0xd8
[ 1001.701420]  ? xdr_set_page_base+0x339/0x350 [sunrpc]
[ 1001.702379]  xdr_set_page_base+0x339/0x350 [sunrpc]
[ 1001.703273]  xdr_align_data+0x6e9/0xe60 [sunrpc]
[ 1001.703967]  ? __decode_op_hdr+0x24/0x4d0 [nfsv4]
[ 1001.704665]  nfs4_xdr_dec_read_plus+0x40d/0x780 [nfsv4]
[ 1001.705371]  ? nfs4_xdr_dec_offload_cancel+0x160/0x160 [nfsv4]
[ 1001.706165]  ? lock_is_held_type+0xd5/0x130
[ 1001.706702]  gss_unwrap_resp+0x145/0x220 [auth_rpcgss]
[ 1001.707355]  call_decode+0x5d2/0x830 [sunrpc]
[ 1001.707954]  ? rpc_decode_header+0x17c0/0x17c0 [sunrpc]
[ 1001.708739]  ? lock_is_held_type+0xd5/0x130
[ 1001.709268]  ? rpc_decode_header+0x17c0/0x17c0 [sunrpc]
[ 1001.709974]  __rpc_execute+0x1b8/0xda0 [sunrpc]
[ 1001.710581]  ? rpc_exit+0xb0/0xb0 [sunrpc]
[ 1001.711146]  ? lock_downgrade+0x6a0/0x6a0
[ 1001.711662]  rpc_async_schedule+0x9f/0x140 [sunrpc]
[ 1001.712355]  process_one_work+0x7ac/0x12d0
[ 1001.712903]  ? lock_release+0x6d0/0x6d0
[ 1001.713386]  ? queue_delayed_work_on+0x80/0x80
[ 1001.713986]  ? rwlock_bug.part.0+0x90/0x90
[ 1001.714507]  worker_thread+0x590/0xf80
[ 1001.714995]  ? rescuer_thread+0xb80/0xb80
[ 1001.715504]  kthread+0x375/0x450
[ 1001.715913]  ? _raw_spin_unlock_irq+0x24/0x50
[ 1001.716518]  ? kthread_create_worker_on_cpu+0xb0/0xb0
[ 1001.717161]  ret_from_fork+0x22/0x30

[ 1001.717855] Allocated by task 9075:
[ 1001.718291]  kasan_save_stack+0x1b/0x40
[ 1001.718778]  __kasan_kmalloc+0x78/0x90
[ 1001.719250]  __kmalloc+0x112/0x210
[ 1001.719679]  nfs_generic_pgio+0x99f/0xe80 [nfs]
[ 1001.720319]  nfs_generic_pg_pgios+0xea/0x3f0 [nfs]
[ 1001.720937]  nfs_pageio_doio+0x10b/0x2b0 [nfs]
[ 1001.721540]  nfs_pageio_complete+0x19d/0x550 [nfs]
[ 1001.722161]  nfs_pageio_complete_read+0x14/0x180 [nfs]
[ 1001.722823]  nfs_readpages+0x313/0x440 [nfs]
[ 1001.723372]  read_pages+0x4ab/0xa40
[ 1001.723816]  page_cache_ra_unbounded+0x361/0x620
[ 1001.724442]  filemap_get_pages+0x631/0xf60
[ 1001.724959]  filemap_read+0x24d/0x840
[ 1001.725425]  nfs_file_read+0x144/0x240 [nfs]
[ 1001.726031]  new_sync_read+0x352/0x5d0
[ 1001.726503]  vfs_read+0x202/0x3f0
[ 1001.726926]  ksys_read+0xe9/0x1b0
[ 1001.727341]  do_syscall_64+0x33/0x40
[ 1001.727797]  entry_SYSCALL_64_after_hwframe+0x44/0xae

[ 1001.728671] The buggy address belongs to the object at ffff88800dd8fe00
                which belongs to the cache kmalloc-128 of size 128
[ 1001.730853] The buggy address is located 0 bytes to the right of
                128-byte region [ffff88800dd8fe00, ffff88800dd8fe80)
[ 1001.732830] The buggy address belongs to the page:
[ 1001.733549] page:000000009a9ea03c refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xdd8f
[ 1001.734754] flags: 0x4000000000000200(slab)
[ 1001.735282] raw: 4000000000000200 ffffea00002c16a8 ffffea00001b27e8 ffff888007040400
[ 1001.736285] raw: 0000000000000000 ffff88800dd8f000 0000000100000010
[ 1001.737064] page dumped because: kasan: bad access detected

[ 1001.737981] Memory state around the buggy address:
[ 1001.738579]  ffff88800dd8fd80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 1001.739475]  ffff88800dd8fe00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 1001.740411] >ffff88800dd8fe80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 1001.741331]                    ^
[ 1001.741795]  ffff88800dd8ff00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1001.742693]  ffff88800dd8ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 1001.743589] ==================================================================

