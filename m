Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DD732C68D
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 02:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355499AbhCDA3M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 19:29:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34980 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359133AbhCCNhp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Mar 2021 08:37:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614778578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=PRG44pYOCT8TBuixfsoZweOhMZzKh2b+QdLc11VmY6o=;
        b=J7ei76A7Y2zGCOinSMXs9Owlxntn5Tm9eOaCi0+FsUuNEoBZYM7JwzLvTJVn4rX9Jplyxz
        THvOOHyK/PyKZa+FDNrJiK21+FU1pbKGmLcwOqkQKSy4uvJAguDxQ0xcVvctnApzk+KXaa
        ubK0kg0hSjQtrbHIAeqihkUAoejYnvM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-nyI7YDtsPpeonvCD7AgOCQ-1; Wed, 03 Mar 2021 08:10:44 -0500
X-MC-Unique: nyI7YDtsPpeonvCD7AgOCQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A2408017FF;
        Wed,  3 Mar 2021 13:10:43 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA15E5D705;
        Wed,  3 Mar 2021 13:10:42 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: memalloc_nofs_save() only on async
Date:   Wed, 03 Mar 2021 08:10:41 -0500
Message-ID: <F9ECC07B-62B5-4242-8A93-DA4FD3FEE1C6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

I'd like to go back to setting sk->sk_allocation = GFP_NOIO (see
a1231fda7e94). That would cover sync tasks as well as async, but I'm not
sure what memalloc_nofs_save/restore gives us and if we should just try 
to
apply that to all tasks.

We're getting some folks deadlocked on the xprt_sending queue with 
stacks like:

  #0 [ffffacab45f17108] __schedule at ffffffffae4d1826
  #1 [ffffacab45f171a0] schedule at ffffffffae4d1cb8
  #2 [ffffacab45f171b0] rpc_wait_bit_killable at ffffffffc067d44e 
[sunrpc]
  #3 [ffffacab45f171c8] __wait_on_bit at ffffffffae4d216c
  #4 [ffffacab45f17200] out_of_line_wait_on_bit at ffffffffae4d2211
  #5 [ffffacab45f17250] __rpc_execute at ffffffffc067f3fc [sunrpc]
  #6 [ffffacab45f172a8] rpc_run_task at ffffffffc06732c4 [sunrpc]
  #7 [ffffacab45f172e8] nfs4_proc_layoutreturn at ffffffffc08f5d44 
[nfsv4]
  #8 [ffffacab45f17388] pnfs_send_layoutreturn at ffffffffc091946e 
[nfsv4]
  #9 [ffffacab45f173d8] _pnfs_return_layout at ffffffffc091ba8b [nfsv4]
#10 [ffffacab45f17450] nfs4_evict_inode at ffffffffc0906a05 [nfsv4]
#11 [ffffacab45f17460] evict at ffffffffadef8592
#12 [ffffacab45f17480] dispose_list at ffffffffadef86a8
#13 [ffffacab45f174a0] prune_icache_sb at ffffffffadef99a2
#14 [ffffacab45f174c8] super_cache_scan at ffffffffadede183
#15 [ffffacab45f17518] do_shrink_slab at ffffffffade3d5d8
#16 [ffffacab45f17588] shrink_slab at ffffffffade3dab5
#17 [ffffacab45f17608] shrink_node at ffffffffade42a8c
#18 [ffffacab45f17678] do_try_to_free_pages at ffffffffade42e43
#19 [ffffacab45f176c8] try_to_free_pages at ffffffffade431c8
#20 [ffffacab45f17768] __alloc_pages_slowpath at ffffffffade81981
#21 [ffffacab45f17868] __alloc_pages_nodemask at ffffffffade82555
#22 [ffffacab45f178c8] skb_page_frag_refill at ffffffffae31bea7
#23 [ffffacab45f178e0] sk_page_frag_refill at ffffffffae31c71d
#24 [ffffacab45f178f8] tcp_sendmsg_locked at ffffffffae3cbe65
#25 [ffffacab45f179a0] tcp_sendmsg at ffffffffae3cc8f7
#26 [ffffacab45f179c0] sock_sendmsg at ffffffffae317cce
#27 [ffffacab45f179d8] xs_sendpages at ffffffffc0679741 [sunrpc]
#28 [ffffacab45f17ac8] xs_tcp_send_request at ffffffffc067adb4 [sunrpc]
#29 [ffffacab45f17b20] xprt_transmit at ffffffffc067674c [sunrpc]
#30 [ffffacab45f17b90] call_transmit at ffffffffc0672064 [sunrpc]
#31 [ffffacab45f17ba0] __rpc_execute at ffffffffc067f365 [sunrpc]
#32 [ffffacab45f17bf8] rpc_run_task at ffffffffc06732c4 [sunrpc]
#33 [ffffacab45f17c38] nfs4_call_sync_custom at ffffffffc08e50bb [nfsv4]
#34 [ffffacab45f17c48] nfs4_call_sync_sequence at ffffffffc08e5143 
[nfsv4]
#35 [ffffacab45f17cb8] _nfs4_proc_getattr at ffffffffc08e7f08 [nfsv4]
#36 [ffffacab45f17d78] nfs4_proc_getattr at ffffffffc08f200a [nfsv4]
#37 [ffffacab45f17de8] __nfs_revalidate_inode at ffffffffc08741d7 [nfs]
#38 [ffffacab45f17e18] nfs_getattr at ffffffffc0874458 [nfs]
#39 [ffffacab45f17e60] vfs_statx_fd at ffffffffadedf8a4
#40 [ffffacab45f17e98] __do_sys_newfstat at ffffffffadedfedd
#41 [ffffacab45f17f38] do_syscall_64 at ffffffffadc0419b
#42 [ffffacab45f17f50] entry_SYSCALL_64_after_hwframe at 
ffffffffae6000ad
     RIP: 00007f721ddcdd37  RSP: 00007ffc0d54cab8  RFLAGS: 00000246
     RAX: ffffffffffffffda  RBX: 00007f721e09b3c0  RCX: 00007f721ddcdd37
     RDX: 00007ffc0d54cac0  RSI: 00007ffc0d54cac0  RDI: 0000000000000001
     RBP: 00007f721e09f6c0   R8: 00007f721f87cf00   R9: 0000000000000000
     R10: 00007ffc0d54a32a  R11: 0000000000000246  R12: 00007f721e09b3c0
     R13: 000055606b81376e  R14: 0000000000000013  R15: 00007f721e09b3c0
     ORIG_RAX: 0000000000000005  CS: 0033  SS: 002b

Ben

