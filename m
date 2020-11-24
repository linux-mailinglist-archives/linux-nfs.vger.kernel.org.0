Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF742C2C80
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Nov 2020 17:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389323AbgKXQMx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 11:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389424AbgKXQMx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Nov 2020 11:12:53 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6421FC0613D6
        for <linux-nfs@vger.kernel.org>; Tue, 24 Nov 2020 08:12:53 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 78A656EA1; Tue, 24 Nov 2020 11:12:50 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 78A656EA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606234370;
        bh=9zKyfLXTEC8wW34Tb5WICt8DN1lQdo9I/ncHTFHw9/w=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=sY0wd8h3mirgos/TKJJqWZ1JrIjDm/SuYK7xMoQmeJo3HzBu9r4adhXbxyGIdzGBq
         hqq7YCfMvPnS7+lIOqg22V01HYcOXy5SS1SQ3xvPmaYSlOzBQnT1Fv6tuoTzRyimh6
         8vokVJQ06S3wKdP06vM6Q9RMGQXzc+1+4GUGag2Y=
Date:   Tue, 24 Nov 2020 11:12:50 -0500
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 0/9] Fix various issues in the SUNRPC xdr code
Message-ID: <20201124161250.GA1091@fieldses.org>
References: <20201124135025.1097571-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124135025.1097571-1-trondmy@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 24, 2020 at 08:50:16AM -0500, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> When looking at the issues raised by Tigran's testing of the NFS client
> updates, I noticed a couple of things in the generic SUNRPC xdr code
> that want to be fixed. This patch series replaces an earlier series that
> attempted to just fix the XDR padding in the NFS code.
> 
> This series fixes up a number of issues w.r.t. bounds checking in the
> xdr_stream code. It corrects the behaviour of xdr_read_pages() for the
> case where the XDR object size is larger than the buffer page array
> length and simplifies the code.

I'm seeing this on the client with recent upstream + these patches.

--b.


[  517.213581] ==================================================================
[  517.214699] BUG: KASAN: slab-out-of-bounds in xdr_set_page+0x327/0x370 [sunrpc]
[  517.215875] Read of size 8 at addr ffff888035929680 by task kworker/u4:7/1423

[  517.216958] CPU: 0 PID: 1423 Comm: kworker/u4:7 Not tainted 5.10.0-rc5-16550-gf864315df3e6 #3058
[  517.218027] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-3.fc33 04/01/2014
[  517.219124] Workqueue: rpciod rpc_async_schedule [sunrpc]
[  517.220079] Call Trace:
[  517.220485]  dump_stack+0x9a/0xcc
[  517.221030]  ? xdr_set_page+0x327/0x370 [sunrpc]
[  517.221712]  print_address_description.constprop.0+0x1c/0x1f0
[  517.222492]  ? xdr_set_page+0x327/0x370 [sunrpc]
[  517.223088]  ? xdr_set_page+0x327/0x370 [sunrpc]
[  517.223677]  kasan_report.cold+0x1f/0x37
[  517.224270]  ? xdr_set_page+0x327/0x370 [sunrpc]
[  517.224872]  xdr_set_page+0x327/0x370 [sunrpc]
[  517.225476]  xdr_align_data+0x1c9/0x8e0 [sunrpc]
[  517.226073]  ? lockdep_hardirqs_on_prepare+0x17b/0x400
[  517.226730]  ? kfree+0x118/0x220
[  517.227172]  ? lockdep_hardirqs_on+0x79/0x100
[  517.227745]  ? __decode_op_hdr+0x24/0x4d0 [nfsv4]
[  517.228427]  nfs4_xdr_dec_read_plus+0x360/0x5a0 [nfsv4]
[  517.229117]  ? nfs4_xdr_dec_offload_cancel+0x160/0x160 [nfsv4]
[  517.229877]  gss_unwrap_resp+0x145/0x220 [auth_rpcgss]
[  517.230558]  call_decode+0x5d2/0x830 [sunrpc]
[  517.231127]  ? rpc_decode_header+0x17c0/0x17c0 [sunrpc]
[  517.231785]  ? lockdep_hardirqs_on_prepare+0x400/0x400
[  517.232563]  ? rpc_decode_header+0x17c0/0x17c0 [sunrpc]
[  517.233236]  __rpc_execute+0x1b8/0xf10 [sunrpc]
[  517.233831]  ? rpc_exit+0x110/0x110 [sunrpc]
[  517.234390]  ? lock_downgrade+0x690/0x690
[  517.234918]  rpc_async_schedule+0x9f/0x140 [sunrpc]
[  517.235539]  process_one_work+0x7ac/0x12d0
[  517.236106]  ? lock_release+0x6c0/0x6c0
[  517.236601]  ? queue_delayed_work_on+0x90/0x90
[  517.237170]  ? rwlock_bug.part.0+0x90/0x90
[  517.237694]  worker_thread+0x590/0xf80
[  517.238204]  ? rescuer_thread+0xb80/0xb80
[  517.238714]  kthread+0x375/0x450
[  517.239124]  ? _raw_spin_unlock_irq+0x24/0x50
[  517.239673]  ? kthread_create_worker_on_cpu+0xb0/0xb0
[  517.240392]  ret_from_fork+0x22/0x30

[  517.241072] Allocated by task 9053:
[  517.241533]  kasan_save_stack+0x1b/0x40
[  517.242018]  __kasan_kmalloc.constprop.0+0xbf/0xd0
[  517.242667]  __kmalloc+0x11e/0x210
[  517.243111]  nfs_generic_pgio+0x943/0xe10 [nfs]
[  517.243691]  nfs_generic_pg_pgios+0xea/0x3f0 [nfs]
[  517.244375]  nfs_pageio_doio+0xe3/0x240 [nfs]
[  517.244929]  nfs_pageio_complete+0x143/0x580 [nfs]
[  517.245562]  nfs_readpages+0x331/0x5b0 [nfs]
[  517.246135]  read_pages+0x4ab/0xa40
[  517.246583]  page_cache_ra_unbounded+0x361/0x620
[  517.247165]  generic_file_buffered_read+0x377/0x1e90
[  517.247791]  nfs_file_read+0x144/0x240 [nfs]
[  517.248396]  new_sync_read+0x352/0x5d0
[  517.248870]  vfs_read+0x202/0x3f0
[  517.249290]  ksys_read+0xe9/0x1b0
[  517.249708]  do_syscall_64+0x33/0x40
[  517.251015]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[  517.252201] The buggy address belongs to the object at ffff888035929600
                which belongs to the cache kmalloc-128 of size 128
[  517.253807] The buggy address is located 0 bytes to the right of
                128-byte region [ffff888035929600, ffff888035929680)
[  517.255217] The buggy address belongs to the page:
[  517.255819] page:00000000ab6145f3 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x35929
[  517.257070] flags: 0x4000000000000200(slab)
[  517.257600] raw: 4000000000000200 ffffea00003970d8 ffffea00004582e8 ffff888007840400
[  517.258582] raw: 0000000000000000 ffff888035929000 0000000100000010
[  517.259362] page dumped because: kasan: bad access detected

[  517.260315] Memory state around the buggy address:
[  517.260912]  ffff888035929580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  517.261833]  ffff888035929600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  517.262755] >ffff888035929680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  517.263655]                    ^
[  517.264133]  ffff888035929700: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  517.265066]  ffff888035929780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  517.265967] ==================================================================

