Return-Path: <linux-nfs+bounces-21666-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kN0rNK5mC2qnHAUAu9opvQ
	(envelope-from <linux-nfs+bounces-21666-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 21:21:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0A0572CE6
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 21:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53D94304C950
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 19:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5D330CD82;
	Mon, 18 May 2026 19:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codemonkey.org.uk header.i=@codemonkey.org.uk header.b="G9wqOIe0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from scorn.kernelslacker.org (scorn.kernelslacker.org [45.56.101.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F238351C22
	for <linux-nfs@vger.kernel.org>; Mon, 18 May 2026 19:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.56.101.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779131849; cv=none; b=JfbtKSjm0Ex9BjHGsHDhU07ajyvh4VLtPcJhoJfnypRSSrE0imNBKKm0ur25vvZbNFTPXqy5e5rELRvXminUvrCmcsyVMNHY97Nz1DnNdygmxOpZHoZ/x0os3qqm8Ghm0RGueAPkkQyG31atPXHyNJICHIVwxMyEOdwRq0s42BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779131849; c=relaxed/simple;
	bh=OLGxVegMFZ2ROGZlB8t4w6A5CzjuneekYPDh46CufUU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oG2sNBLdZ7gzsNSwavWRJ3O0JSnnN/cmaM2waxv/F9jVgoVzzNeD3Qskyao7SJ0yvKRMo2JUaZnBkWr9P+Y4rQPJbNvT6bNWepq9SXWLbP7F94CsM4yF7sNiMhE62qj11npQ/66kFFYPh3n9wmFuVcXwCGPIUdOLF8Gc3zNp/k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codemonkey.org.uk; spf=pass smtp.mailfrom=codemonkey.org.uk; dkim=fail (0-bit key) header.d=codemonkey.org.uk header.i=@codemonkey.org.uk header.b=G9wqOIe0 reason="key not found in DNS"; arc=none smtp.client-ip=45.56.101.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codemonkey.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codemonkey.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codemonkey.org.uk; s=rsa1; h=Content-Type:MIME-Version:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EQ9V3XWIvlZ/1RfDE87o5b82AgbKTy4eBjpBe2jSRfQ=; b=G9wqOIe0gnnThG0bSGl19b1g/w
	Es29GMDa0AbL4xIQ1rxqGNagu2RnaGErmsSChfn1LUnUbSMzeOoPYyWi+PmyPSn+soMLj2gAjl+RB
	vvmtxh8knvhnq/2DC2jzyLx2RuFLQBS/54sBKDko1oLKZMkw+HPWtJK+Hur9/gGSs4hKN2f/AMIzI
	X+1LUfsTfKiPJ5th5AC/d+RDpjsNxAd4KIw9n9pdj/WDJXoD5ttYu5CuxmLoYswf2nnhIabBjyLzw
	EQaMZyVrbh4ALBaPwuLFW0hWtfuQzKCQ4TXRESKbwHOVw6akLxCB0Zgi43KagOooY66ARZENC9OrG
	zBqLTmzA==;
Received: from [2601:195:c900:ff9f:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
	by scorn.kernelslacker.org with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <davej@codemonkey.org.uk>)
	id 1wP2yz-00000005Mro-0i6m;
	Mon, 18 May 2026 14:46:29 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
	id 98826560187; Mon, 18 May 2026 14:46:28 -0400 (EDT)
Date: Mon, 18 May 2026 14:46:28 -0400
From: Dave Jones <davej@codemonkey.org.uk>
To: linux-nfs@vger.kernel.org
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Subject: [PATCH] NFS: write_completion: dereference loop-local req, not
 hdr->req
Message-ID: <agtehErxs5HVJJb0@codemonkey.org.uk>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	R_DKIM_PERMFAIL(0.00)[codemonkey.org.uk:s=rsa1];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DMARC_NA(0.00)[codemonkey.org.uk];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davej@codemonkey.org.uk,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21666-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[codemonkey.org.uk:~]
X-Rspamd-Queue-Id: 2E0A0572CE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5d3869a41f36 ("NFS: fix writeback in presence of errors") introduced
a dereference of hdr->req->wb_lock_context in nfs_write_completion's
per-request loop.  hdr->req is set once at nfs_pgheader_init() time
and is not refcount-protected for the lifetime of the loop; when hdr
aggregates requests from multiple page groups (common under heavy
NFSv3 writeback), a parallel COMMIT on hdr->req's group can drop the
last reference and free it while the outer loop is still iterating
requests from other groups.  KASAN catches this as an 8-byte read at
offset +24 of a freed nfs_page slab object (wb_lock_context).

All requests in a given pgio share the same open_context, so reading
the loop-local req's wb_lock_context yields the same value and is
safe -- req is still on hdr->pages and holds its writeback kref
through the commit branch.

Caught with kasan:

BUG: KASAN: slab-use-after-free in nfs_write_completion+0x8f8/0xa50 [nfs]
Read of size 8 at addr ffff888118af2058 by task kworker/u16:16/122062
CPU: 2 UID: 0 PID: 122062 Comm: kworker/u16:16 Kdump: loaded Not tainted 7.1.0-rc4+ #ge05a759574b2 PREEMPT 
Workqueue: nfsiod rpc_async_release
Call Trace:
 <TASK>
 dump_stack_lvl+0xaf/0x100
 ? nfs_write_completion+0x8f8/0xa50 [nfs]
 print_report+0x157/0x4a1
 ? __virt_addr_valid+0x1fb/0x400
 ? nfs_write_completion+0x8f8/0xa50 [nfs]
 kasan_report+0xc2/0x190
 ? nfs_write_completion+0x8f8/0xa50 [nfs]
 nfs_write_completion+0x8f8/0xa50 [nfs]
 ? nfs_commit_release_pages+0xbd0/0xbd0 [nfs]
 ? lock_acquire+0x182/0x2e0
 ? process_one_work+0x937/0x1890
 ? nfs_pgio_header_alloc+0xd0/0xd0 [nfs]
 rpc_free_task+0xee/0x160
 rpc_async_release+0x5d/0xb0
 process_one_work+0x9b0/0x1890
 ? pwq_dec_nr_in_flight+0xed0/0xed0
 ? rpc_final_put_task+0x140/0x140
 worker_thread+0x75a/0x10a0
 ? process_one_work+0x1890/0x1890
 ? kthread+0x1af/0x4d0
 ? process_one_work+0x1890/0x1890
 kthread+0x3d3/0x4d0
 ? kthread_affine_node+0x2c0/0x2c0
 ret_from_fork+0x669/0xa50
 ? native_tss_update_io_bitmap+0x660/0x660
 ? __switch_to+0x9dd/0x1310
 ? kthread_affine_node+0x2c0/0x2c0
 ret_from_fork_asm+0x11/0x20
 </TASK>

Allocated by task 121997 on cpu 3 at 31643.290294s:
 kasan_save_stack+0x1e/0x40
 kasan_save_track+0x13/0x60
 __kasan_slab_alloc+0x62/0x70
 kmem_cache_alloc_noprof+0x1ab/0x4e0
 nfs_page_create+0x152/0x460 [nfs]
 nfs_page_create_from_folio+0x7e/0x210 [nfs]
 nfs_update_folio+0x7a9/0x32a0 [nfs]
 nfs_write_end+0x290/0xc60 [nfs]
 generic_perform_write+0x4ce/0x990
 nfs_file_write+0x6b3/0xce0 [nfs]
 vfs_write+0x63c/0xfa0
 ksys_write+0x122/0x240
 do_syscall_64+0xc3/0x13f0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

Freed by task 122046 on cpu 0 at 31647.037964s:
 kasan_save_stack+0x1e/0x40
 kasan_save_track+0x13/0x60
 kasan_save_free_info+0x37/0x60
 __kasan_slab_free+0x3b/0x60
 kmem_cache_free+0x11b/0x5a0
 nfs_page_group_destroy+0x13a/0x210 [nfs]
 nfs_unlock_and_release_request+0x64/0x90 [nfs]
 nfs_commit_release_pages+0x339/0xbd0 [nfs]
 nfs_commit_release+0x51/0xb0 [nfs]
 rpc_free_task+0xee/0x160
 rpc_async_release+0x5d/0xb0
 process_one_work+0x9b0/0x1890
 worker_thread+0x75a/0x10a0
 kthread+0x3d3/0x4d0
 ret_from_fork+0x669/0xa50
 ret_from_fork_asm+0x11/0x20

The buggy address belongs to the object at ffff888118af2040\x0a which belongs to the cache nfs_page of size 96
The buggy address is located 24 bytes inside of\x0a freed 96-byte region [ffff888118af2040, ffff888118af20a0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x118af2
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4000000000000040(head|zone=2)
page_type: f5(slab)
raw: 4000000000000040 ffff88818cf2c4c0 ffffea000e61b990 ffffea0004e7d110
raw: 0000000000000000 0000000800190019 00000000f5000000 0000000000000000
head: 4000000000000040 ffff88818cf2c4c0 ffffea000e61b990 ffffea0004e7d110
head: 0000000000000000 0000000800190019 00000000f5000000 0000000000000000
head: 4000000000000001 ffffffffffffff81 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 121997, tgid 121997 (rsync), ts 31643290274577, free_ts 31642154777182
 post_alloc_hook+0xd1/0x100
 get_page_from_freelist+0xbad/0x2910
 __alloc_frozen_pages_noprof+0x1c6/0x4a0
 allocate_slab+0x330/0x620
 ___slab_alloc+0xe9/0x930
 kmem_cache_alloc_noprof+0x35b/0x4e0
 nfs_page_create+0x152/0x460 [nfs]
 nfs_page_create_from_folio+0x7e/0x210 [nfs]
 nfs_update_folio+0x7a9/0x32a0 [nfs]
 nfs_write_end+0x290/0xc60 [nfs]
 generic_perform_write+0x4ce/0x990
 nfs_file_write+0x6b3/0xce0 [nfs]
 vfs_write+0x63c/0xfa0
 ksys_write+0x122/0x240
 do_syscall_64+0xc3/0x13f0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
page last free pid 122202 tgid 122202 stack trace:
 __free_frozen_pages+0x6da/0xf30
 qlist_free_all+0x53/0x130
 kasan_quarantine_reduce+0x198/0x1f0
 __kasan_slab_alloc+0x46/0x70
 kmem_cache_alloc_noprof+0x1ab/0x4e0
 __alloc_object+0x2f/0x230
 __create_object+0x22/0x80
 kmem_cache_alloc_node_noprof+0x416/0x4d0
 __alloc_skb+0x146/0x6e0
 tcp_stream_alloc_skb+0x35/0x660
 tcp_sendmsg_locked+0x1746/0x4260
 tcp_sendmsg+0x2f/0x40
 inet_sendmsg+0x9e/0xe0
 __sock_sendmsg+0xd9/0x180
 sock_sendmsg+0x122/0x200
 xprt_sock_sendmsg+0x4ff/0x9a0

Memory state around the buggy address:
 ffff888118af1f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
 ffff888118af1f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888118af2000: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
                                                    ^
 ffff888118af2080: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888118af2100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Fixes: 5d3869a41f36 ("NFS: fix writeback in presence of errors")
Cc: Olga Kornievskaia <okorniev@redhat.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Reviewed-by Jeff Layton <jlayton@kernel.org>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Dave Jones <davej@codemonkey.org.uk>
---
 fs/nfs/write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 3134bb17f3e3..d7c399763ad9 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -927,7 +927,7 @@ static void nfs_write_completion(struct nfs_pgio_header *hdr)
 		}
 		if (nfs_write_need_commit(hdr)) {
 			struct nfs_open_context *ctx =
-				hdr->req->wb_lock_context->open_context;
+				req->wb_lock_context->open_context;
 
 			/* Reset wb_nio, since the write was successful. */
 			req->wb_nio = 0;


