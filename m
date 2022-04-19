Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFBF507258
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Apr 2022 17:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354179AbiDSQAT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Apr 2022 12:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354158AbiDSQAK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Apr 2022 12:00:10 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60FE2409F;
        Tue, 19 Apr 2022 08:57:26 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id o18so12547304qtk.7;
        Tue, 19 Apr 2022 08:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g90PMh/mTMCy35563Vxly24H/NoYiw6F63ak04/+4eQ=;
        b=7tjstP+Ck1Jqe9bmKR61PO/Xeyc12WmVy0x++uB4NpQMF90Pc8QvVUTeCAcoGP/881
         xoYmnLpDSCheTlXSZqYFAs404PY28YHDcW5gvFsQzl/xj538R+5Bzwjc/Nru2Mv3T/3t
         oaV+YhYQrWciV01tWwFCUcmB7pj3GEK2xoT/IxvjVYzWudNg194VQE+Ws7rFjAGlS1EA
         I4q4VADyQ/j0WX5LhsceqTrfH0ksK9W7AvFIaXke6FUt7eNrcOtKd1N7ngD0gEfFc8zq
         6yO11jJGNCNLPFp8InNJkQu0iI+JsN7aQHwj9dYtpPKOMhKIiawpd8/tOwxzNgjx25Ex
         N2PA==
X-Gm-Message-State: AOAM533l/3ehAMX594VGeuOUfF31dps3Q6WVYftDIOMYrKhDIs3K5G5b
        s7aas4TzdYnh77T40N+kKha1x08U6UtU7g==
X-Google-Smtp-Source: ABdhPJxnGD9h0GOFV8n6o/bqmQOwf0GJRKbG9hPA0wtrsszvJd3CcylorMMd9wO6ZIRZ8Km5qcn1iw==
X-Received: by 2002:ac8:7d94:0:b0:2f1:fd15:33e1 with SMTP id c20-20020ac87d94000000b002f1fd1533e1mr7147559qtd.369.1650383845665;
        Tue, 19 Apr 2022 08:57:25 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id j12-20020ae9c20c000000b0067ec380b320sm185661qkg.64.2022.04.19.08.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 08:57:25 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id i20so31809292ybj.7;
        Tue, 19 Apr 2022 08:57:25 -0700 (PDT)
X-Received: by 2002:a25:2c89:0:b0:641:2884:b52e with SMTP id
 s131-20020a252c89000000b006412884b52emr15167372ybs.506.1650383845109; Tue, 19
 Apr 2022 08:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <164859751830.29473.5309689752169286816.stgit@noble.brown>
 <2923577.1648635976@warthog.procyon.org.uk> <164868916197.25542.11845352976146070176@noble.neil.brown.name>
In-Reply-To: <164868916197.25542.11845352976146070176@noble.neil.brown.name>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Apr 2022 17:57:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVJZmjM0yc=-iVi0y5ML6u8E4pG_RpLpwbZKu35Y9vOZQ@mail.gmail.com>
Message-ID: <CAMuHMdVJZmjM0yc=-iVi0y5ML6u8E4pG_RpLpwbZKu35Y9vOZQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] MM changes to improve swap-over-NFS support
To:     NeilBrown <neilb@suse.de>
Cc:     David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil,

On Thu, Mar 31, 2022 at 4:54 AM NeilBrown <neilb@suse.de> wrote:
> On Wed, 30 Mar 2022, David Howells wrote:
> > Do you have a branch with your patches on?
>
> http://git.neil.brown.name/?p=linux.git;a=shortlog;h=refs/heads/swap-nfs
>
> git://neil.brown.name/linux  branch swap-nfs
>
> Also  on https://github.com/neilbrown/linux.git same branch
>
> (it seems 1GB is no longer enough to run a git server for the kernel
>  effectively)
>
> This contains
>  - recent HEAD from Linus, which includes the NFS work
>  - the patches I sent to akpm
>  - the patch to switch NFS over to using the new swap_rw
>  - a SUNRPC patch to fix an easy crash.  But has always been there,
>     but recent changes to how kmalloc is called makes it much easier to
>     trigger.

Thanks for your series!

I gave this a try on Renesas RSK+RZA1 (RZ/A1H with 32 MiB of RAM)
and RZA2MEVB (RZ/A2M with 64 MiB of RAM) with a Debian nfsroot.
Seems to work, so
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

However, I still managed to trigger memory allocation failures,
even on the RZ/A2, which I don't remember seeing last time I tried.

root@rza2mevb:~# free
              total        used        free      shared  buff/cache   available
Mem:          57428       12400       20024        1212       25004       40028
Swap:             0           0           0
root@rza2mevb:~# swapon /swap
Adding 1048572k swap on /swap.  Priority:-2 extents:1 across:1048572k
root@rza2mevb:~# apt update
Ign:1 http://ftp.be.debian.org/debian stretch InRelease
Get:2 http://security.debian.org stretch/updates InRelease [53.0 kB]
Hit:3 http://ftp.be.debian.org/debian stretch Release
Get:5 http://security.debian.org stretch/updates/main armhf Packages [738 kB]
Get:6 http://security.debian.org stretch/updates/main Translation-en [356 kB]
Fetched 1,147 kB in 12s (89.5 kB/s)
apt: page allocation failure: order:0,
mode:0x40cc0(GFP_KERNEL|__GFP_COMP), nodemask=(null)
CPU: 0 PID: 455 Comm: apt Not tainted
5.18.0-rc3-rza2mevb-00734-g98e2a6b7a591 #186
Hardware name: Generic R7S9210 (Flattened Device Tree)
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from warn_alloc+0xa0/0x150
 warn_alloc from __alloc_pages+0x3a0/0x8c0
 __alloc_pages from ____cache_alloc+0x194/0x734
 ____cache_alloc from kmem_cache_alloc+0x60/0xd0
 kmem_cache_alloc from nfs_writehdr_alloc+0x28/0x70
 nfs_writehdr_alloc from nfs_pgio_header_alloc+0x10/0x28
 nfs_pgio_header_alloc from nfs_generic_pg_pgios+0x14/0xa8
 nfs_generic_pg_pgios from nfs_pageio_doio+0x2c/0x4c
 nfs_pageio_doio from __nfs_pageio_add_request+0x34c/0x3c8
 __nfs_pageio_add_request from nfs_pageio_add_request_mirror+0x18/0x44
 nfs_pageio_add_request_mirror from nfs_pageio_add_request+0x1b8/0x1c8
 nfs_pageio_add_request from nfs_direct_write_schedule_iovec+0x208/0x28c
 nfs_direct_write_schedule_iovec from nfs_file_direct_write+0x128/0x21c
 nfs_file_direct_write from nfs_swap_rw+0x24/0x28
 nfs_swap_rw from swap_write_unplug+0x54/0x94
 swap_write_unplug from __swap_writepage+0x10c/0x20c
 __swap_writepage from shrink_page_list+0x86c/0xabc
 shrink_page_list from shrink_inactive_list+0xfc/0x2b0
 shrink_inactive_list from shrink_node+0x598/0x80c
 shrink_node from try_to_free_pages+0x2bc/0x3e8
 try_to_free_pages from __alloc_pages+0x55c/0x8c0
 __alloc_pages from __filemap_get_folio+0x1b4/0x260
 __filemap_get_folio from pagecache_get_page+0x10/0x68
 pagecache_get_page from nfs_write_begin+0x30/0x148
 nfs_write_begin from generic_perform_write+0xa4/0x1b8
 generic_perform_write from nfs_file_write+0xf0/0x2a4
 nfs_file_write from vfs_write+0x140/0x19c
 vfs_write from ksys_write+0x74/0xc8
 ksys_write from ret_fast_syscall+0x0/0x54
Exception stack(0xc4c1dfa8 to 0xc4c1dff0)
dfa0:                   b6ec4025 00000000 00000004 b1d0e000 019f12ac befee52c
dfc0: b6ec4025 00000000 019f12ac 00000004 019f12ac b1d0e000 befee52c befee7ac
dfe0: 00000000 befee4d4 b6ec0b43 b6cb1cf6
Mem-Info:
active_anon:1772 inactive_anon:7471 isolated_anon:64
 active_file:679 inactive_file:392 isolated_file:0
 unevictable:0 dirty:0 writeback:2891
 slab_reclaimable:417 slab_unreclaimable:2863
 mapped:32 shmem:52 pagetables:107 bounce:0
 kernel_misc_reclaimable:0
 free:0 free_pcp:6 free_cma:0
Node 0 active_anon:7088kB inactive_anon:29884kB active_file:2716kB
inactive_file:1568kB unevictable:0kB isolated(anon):256kB
isolated(file):0kB mapped:128kB dirty:0kB writeback:11564kB
shmem:208kB writeback_tmp:0kB kernel_stack:408kB pagetables:428kB
all_unreclaimable? no
Normal free:0kB boost:4096kB min:5044kB low:5280kB high:5516kB
reserved_highatomic:0KB active_anon:7088kB inactive_anon:29884kB
active_file:2716kB inactive_file:1568kB unevictable:0kB
writepending:10296kB present:65536kB managed:57428kB mlocked:0kB
bounce:0kB free_pcp:24kB local_pcp:24kB free_cma:0kB
lowmem_reserve[]: 0 0
Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB
0*1024kB 0*2048kB 0*4096kB = 0kB
7385 total pagecache pages
6262 pages in swap cache
Swap cache stats: add 6787, delete 525, find 58/74
Free swap  = 1021476kB
Total swap = 1048572kB
16384 pages RAM
0 pages HighMem/MovableOnly
2027 pages reserved
Write error -12 on dio swapfile (27660288)
Write error -12 on dio swapfile (29679616)
Write error -12 on dio swapfile (8572928)
Write error 0 on dio swapfile (8441856)
Write error 0 on dio swapfile (8704000)
Write error -12 on dio swapfile (8966144)
Write error -12 on dio swapfile (9097216)
Write error 0 on dio swapfile (8835072)
Write error 0 on dio swapfile (9228288)
Write error 0 on dio swapfile (9359360)
sio_write_complete: 2731 callbacks suppressed
Write error 0 on dio swapfile (34705408)
Write error 0 on dio swapfile (23470080)
Write error 0 on dio swapfile (23601152)
Write error 0 on dio swapfile (23732224)
Write error 0 on dio swapfile (4202496)
Write error 0 on dio swapfile (4304896)
Write error 0 on dio swapfile (4435968)
Write error 0 on dio swapfile (4567040)
Write error 0 on dio swapfile (4698112)
Write error 0 on dio swapfile (4829184)
warn_alloc: 125849 callbacks suppressed
kworker/u2:7: page allocation failure: order:0,
mode:0x60c40(GFP_NOFS|__GFP_COMP|__GFP_MEMALLOC), nodemask=(null)
CPU: 0 PID: 457 Comm: kworker/u2:7 Not tainted
5.18.0-rc3-rza2mevb-00734-g98e2a6b7a591 #186
Hardware name: Generic R7S9210 (Flattened Device Tree)
Workqueue: rpciod rpc_async_schedule
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from warn_alloc+0xa0/0x150
 warn_alloc from __alloc_pages+0x3a0/0x8c0
 __alloc_pages from ____cache_alloc+0x194/0x734
 ____cache_alloc from __kmalloc_track_caller+0x74/0xf0
 __kmalloc_track_caller from kmalloc_reserve.constprop.0+0x4c/0x60
 kmalloc_reserve.constprop.0 from __alloc_skb+0x88/0x154
 __alloc_skb from tcp_stream_alloc_skb+0x68/0x13c
 tcp_stream_alloc_skb from tcp_sendmsg_locked+0x4b8/0xabc
 tcp_sendmsg_locked from tcp_sendmsg+0x24/0x38
 tcp_sendmsg from sock_sendmsg_nosec+0x14/0x24
 sock_sendmsg_nosec from xprt_sock_sendmsg+0x1d8/0x244
 xprt_sock_sendmsg from xs_tcp_send_request+0x11c/0x20c
 xs_tcp_send_request from xprt_transmit+0x84/0x234
 xprt_transmit from call_transmit+0x6c/0x7c
 call_transmit from __rpc_execute+0xe4/0x2f0
 __rpc_execute from rpc_async_schedule+0x18/0x24
 rpc_async_schedule from process_one_work+0x170/0x210
 process_one_work from worker_thread+0x204/0x2a4
 worker_thread from kthread+0xb0/0xbc
 kthread from ret_from_fork+0x14/0x2c
Exception stack(0xc4e0dfb0 to 0xc4e0dff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
Mem-Info:
active_anon:2703 inactive_anon:6291 isolated_anon:209
 active_file:541 inactive_file:530 isolated_file:0
 unevictable:0 dirty:0 writeback:3781
 slab_reclaimable:391 slab_unreclaimable:2993
 mapped:0 shmem:0 pagetables:107 bounce:0
 kernel_misc_reclaimable:0
 free:0 free_pcp:26 free_cma:0
Node 0 active_anon:10812kB inactive_anon:25164kB active_file:2164kB
inactive_file:2120kB unevictable:0kB isolated(anon):836kB
isolated(file):0kB mapped:0kB dirty:0kB writeback:15124kB shmem:0kB
writeback_tmp:0kB kernel_stack:408kB pagetables:428kB
all_unreclaimable? yes
Normal free:0kB boost:0kB min:948kB low:1184kB high:1420kB
reserved_highatomic:0KB active_anon:10812kB inactive_anon:25164kB
active_file:2164kB inactive_file:2120kB unevictable:0kB
writepending:13284kB present:65536kB managed:57428kB mlocked:0kB
bounce:0kB free_pcp:104kB local_pcp:104kB free_cma:0kB
lowmem_reserve[]: 0 0
Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB
0*1024kB 0*2048kB 0*4096kB = 0kB
10274 total pagecache pages
9203 pages in swap cache
Swap cache stats: add 9834, delete 631, find 61/77
Free swap  = 1009180kB
Total swap = 1048572kB
16384 pages RAM
0 pages HighMem/MovableOnly
2027 pages reserved
sio_write_complete: 29066 callbacks suppressed
...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
