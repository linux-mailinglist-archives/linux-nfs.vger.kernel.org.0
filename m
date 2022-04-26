Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FF050EE74
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Apr 2022 04:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiDZCHb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Apr 2022 22:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiDZCHb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Apr 2022 22:07:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE1EBF511;
        Mon, 25 Apr 2022 19:04:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 488341F388;
        Tue, 26 Apr 2022 02:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650938663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6nYE1T80Q4pVXvl6ogOnS+yktdtMLiql/MvHNtl9Bb4=;
        b=ze2aky3/lIT7P7jgfMWCqYHYFeSA+s9O4i1l7+RT0w/caou6ubsWoQ71kZF+NQb3B1bZYt
        Ls0KJq/fVZIIAjM8jEauiUz2sR32G6APSx7wBgvPXZlbimBeOQZmoSrmbMlFrADIoaKgHL
        vXUUMd5Li/J1+BPGLObu4qJOhoW7w8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650938663;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6nYE1T80Q4pVXvl6ogOnS+yktdtMLiql/MvHNtl9Bb4=;
        b=bc9KLUdaSWZCm+iDH45UAI2nXaTTJhJNH8HqCNO+CZbuTquXNjGBvpwmlvLskuIBcRzkY4
        HF2HYY1saF7tqBDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D2EF713A97;
        Tue, 26 Apr 2022 02:04:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lVGzIyRTZ2LFEAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 26 Apr 2022 02:04:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc:     "David Howells" <dhowells@redhat.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        "Linux MM" <linux-mm@kvack.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/10] MM changes to improve swap-over-NFS support
In-reply-to: <CAMuHMdVJZmjM0yc=-iVi0y5ML6u8E4pG_RpLpwbZKu35Y9vOZQ@mail.gmail.com>
References: <164859751830.29473.5309689752169286816.stgit@noble.brown>,
 <2923577.1648635976@warthog.procyon.org.uk>,
 <164868916197.25542.11845352976146070176@noble.neil.brown.name>,
 <CAMuHMdVJZmjM0yc=-iVi0y5ML6u8E4pG_RpLpwbZKu35Y9vOZQ@mail.gmail.com>
Date:   Tue, 26 Apr 2022 12:04:17 +1000
Message-id: <165093865754.1648.10694052999744348900@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 20 Apr 2022, Geert Uytterhoeven wrote:
> Hi Neil,
>=20
> On Thu, Mar 31, 2022 at 4:54 AM NeilBrown <neilb@suse.de> wrote:
> > On Wed, 30 Mar 2022, David Howells wrote:
> > > Do you have a branch with your patches on?
> >
> > http://git.neil.brown.name/?p=3Dlinux.git;a=3Dshortlog;h=3Drefs/heads/swa=
p-nfs
> >
> > git://neil.brown.name/linux  branch swap-nfs
> >
> > Also  on https://github.com/neilbrown/linux.git same branch
> >
> > (it seems 1GB is no longer enough to run a git server for the kernel
> >  effectively)
> >
> > This contains
> >  - recent HEAD from Linus, which includes the NFS work
> >  - the patches I sent to akpm
> >  - the patch to switch NFS over to using the new swap_rw
> >  - a SUNRPC patch to fix an easy crash.  But has always been there,
> >     but recent changes to how kmalloc is called makes it much easier to
> >     trigger.
>=20
> Thanks for your series!
>=20
> I gave this a try on Renesas RSK+RZA1 (RZ/A1H with 32 MiB of RAM)
> and RZA2MEVB (RZ/A2M with 64 MiB of RAM) with a Debian nfsroot.
> Seems to work, so
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks for testing!!!!

>=20
> However, I still managed to trigger memory allocation failures,
> even on the RZ/A2, which I don't remember seeing last time I tried.
>=20
> root@rza2mevb:~# free
>               total        used        free      shared  buff/cache   avail=
able
> Mem:          57428       12400       20024        1212       25004       4=
0028
> Swap:             0           0           0
> root@rza2mevb:~# swapon /swap
> Adding 1048572k swap on /swap.  Priority:-2 extents:1 across:1048572k
> root@rza2mevb:~# apt update
> Ign:1 http://ftp.be.debian.org/debian stretch InRelease
> Get:2 http://security.debian.org stretch/updates InRelease [53.0 kB]
> Hit:3 http://ftp.be.debian.org/debian stretch Release
> Get:5 http://security.debian.org stretch/updates/main armhf Packages [738 k=
B]
> Get:6 http://security.debian.org stretch/updates/main Translation-en [356 k=
B]
> Fetched 1,147 kB in 12s (89.5 kB/s)
> apt: page allocation failure: order:0,
> mode:0x40cc0(GFP_KERNEL|__GFP_COMP), nodemask=3D(null)
> CPU: 0 PID: 455 Comm: apt Not tainted
> 5.18.0-rc3-rza2mevb-00734-g98e2a6b7a591 #186
> Hardware name: Generic R7S9210 (Flattened Device Tree)
>  unwind_backtrace from show_stack+0x10/0x14
>  show_stack from warn_alloc+0xa0/0x150
>  warn_alloc from __alloc_pages+0x3a0/0x8c0
>  __alloc_pages from ____cache_alloc+0x194/0x734
>  ____cache_alloc from kmem_cache_alloc+0x60/0xd0
>  kmem_cache_alloc from nfs_writehdr_alloc+0x28/0x70
>  nfs_writehdr_alloc from nfs_pgio_header_alloc+0x10/0x28

This is due to a recent change in NFS code which I don't think actually
makes sense.
  Commit 0bae835b63c5 ("NFS: Avoid writeback threads getting stuck in mempool=
_alloc()")

I need to find an alternate approach which addresses Trond's concerns
but also works.  I'm just now back from leave and will try to look at
this over the next week or two.

Thanks,
NeilBrown



>  nfs_pgio_header_alloc from nfs_generic_pg_pgios+0x14/0xa8
>  nfs_generic_pg_pgios from nfs_pageio_doio+0x2c/0x4c
>  nfs_pageio_doio from __nfs_pageio_add_request+0x34c/0x3c8
>  __nfs_pageio_add_request from nfs_pageio_add_request_mirror+0x18/0x44
>  nfs_pageio_add_request_mirror from nfs_pageio_add_request+0x1b8/0x1c8
>  nfs_pageio_add_request from nfs_direct_write_schedule_iovec+0x208/0x28c
>  nfs_direct_write_schedule_iovec from nfs_file_direct_write+0x128/0x21c
>  nfs_file_direct_write from nfs_swap_rw+0x24/0x28
>  nfs_swap_rw from swap_write_unplug+0x54/0x94
>  swap_write_unplug from __swap_writepage+0x10c/0x20c
>  __swap_writepage from shrink_page_list+0x86c/0xabc
>  shrink_page_list from shrink_inactive_list+0xfc/0x2b0
>  shrink_inactive_list from shrink_node+0x598/0x80c
>  shrink_node from try_to_free_pages+0x2bc/0x3e8
>  try_to_free_pages from __alloc_pages+0x55c/0x8c0
>  __alloc_pages from __filemap_get_folio+0x1b4/0x260
>  __filemap_get_folio from pagecache_get_page+0x10/0x68
>  pagecache_get_page from nfs_write_begin+0x30/0x148
>  nfs_write_begin from generic_perform_write+0xa4/0x1b8
>  generic_perform_write from nfs_file_write+0xf0/0x2a4
>  nfs_file_write from vfs_write+0x140/0x19c
>  vfs_write from ksys_write+0x74/0xc8
>  ksys_write from ret_fast_syscall+0x0/0x54
> Exception stack(0xc4c1dfa8 to 0xc4c1dff0)
> dfa0:                   b6ec4025 00000000 00000004 b1d0e000 019f12ac befee5=
2c
> dfc0: b6ec4025 00000000 019f12ac 00000004 019f12ac b1d0e000 befee52c befee7=
ac
> dfe0: 00000000 befee4d4 b6ec0b43 b6cb1cf6
> Mem-Info:
> active_anon:1772 inactive_anon:7471 isolated_anon:64
>  active_file:679 inactive_file:392 isolated_file:0
>  unevictable:0 dirty:0 writeback:2891
>  slab_reclaimable:417 slab_unreclaimable:2863
>  mapped:32 shmem:52 pagetables:107 bounce:0
>  kernel_misc_reclaimable:0
>  free:0 free_pcp:6 free_cma:0
> Node 0 active_anon:7088kB inactive_anon:29884kB active_file:2716kB
> inactive_file:1568kB unevictable:0kB isolated(anon):256kB
> isolated(file):0kB mapped:128kB dirty:0kB writeback:11564kB
> shmem:208kB writeback_tmp:0kB kernel_stack:408kB pagetables:428kB
> all_unreclaimable? no
> Normal free:0kB boost:4096kB min:5044kB low:5280kB high:5516kB
> reserved_highatomic:0KB active_anon:7088kB inactive_anon:29884kB
> active_file:2716kB inactive_file:1568kB unevictable:0kB
> writepending:10296kB present:65536kB managed:57428kB mlocked:0kB
> bounce:0kB free_pcp:24kB local_pcp:24kB free_cma:0kB
> lowmem_reserve[]: 0 0
> Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB
> 0*1024kB 0*2048kB 0*4096kB =3D 0kB
> 7385 total pagecache pages
> 6262 pages in swap cache
> Swap cache stats: add 6787, delete 525, find 58/74
> Free swap  =3D 1021476kB
> Total swap =3D 1048572kB
> 16384 pages RAM
> 0 pages HighMem/MovableOnly
> 2027 pages reserved
> Write error -12 on dio swapfile (27660288)
> Write error -12 on dio swapfile (29679616)
> Write error -12 on dio swapfile (8572928)
> Write error 0 on dio swapfile (8441856)
> Write error 0 on dio swapfile (8704000)
> Write error -12 on dio swapfile (8966144)
> Write error -12 on dio swapfile (9097216)
> Write error 0 on dio swapfile (8835072)
> Write error 0 on dio swapfile (9228288)
> Write error 0 on dio swapfile (9359360)
> sio_write_complete: 2731 callbacks suppressed
> Write error 0 on dio swapfile (34705408)
> Write error 0 on dio swapfile (23470080)
> Write error 0 on dio swapfile (23601152)
> Write error 0 on dio swapfile (23732224)
> Write error 0 on dio swapfile (4202496)
> Write error 0 on dio swapfile (4304896)
> Write error 0 on dio swapfile (4435968)
> Write error 0 on dio swapfile (4567040)
> Write error 0 on dio swapfile (4698112)
> Write error 0 on dio swapfile (4829184)
> warn_alloc: 125849 callbacks suppressed
> kworker/u2:7: page allocation failure: order:0,
> mode:0x60c40(GFP_NOFS|__GFP_COMP|__GFP_MEMALLOC), nodemask=3D(null)
> CPU: 0 PID: 457 Comm: kworker/u2:7 Not tainted
> 5.18.0-rc3-rza2mevb-00734-g98e2a6b7a591 #186
> Hardware name: Generic R7S9210 (Flattened Device Tree)
> Workqueue: rpciod rpc_async_schedule
>  unwind_backtrace from show_stack+0x10/0x14
>  show_stack from warn_alloc+0xa0/0x150
>  warn_alloc from __alloc_pages+0x3a0/0x8c0
>  __alloc_pages from ____cache_alloc+0x194/0x734
>  ____cache_alloc from __kmalloc_track_caller+0x74/0xf0
>  __kmalloc_track_caller from kmalloc_reserve.constprop.0+0x4c/0x60
>  kmalloc_reserve.constprop.0 from __alloc_skb+0x88/0x154
>  __alloc_skb from tcp_stream_alloc_skb+0x68/0x13c
>  tcp_stream_alloc_skb from tcp_sendmsg_locked+0x4b8/0xabc
>  tcp_sendmsg_locked from tcp_sendmsg+0x24/0x38
>  tcp_sendmsg from sock_sendmsg_nosec+0x14/0x24
>  sock_sendmsg_nosec from xprt_sock_sendmsg+0x1d8/0x244
>  xprt_sock_sendmsg from xs_tcp_send_request+0x11c/0x20c
>  xs_tcp_send_request from xprt_transmit+0x84/0x234
>  xprt_transmit from call_transmit+0x6c/0x7c
>  call_transmit from __rpc_execute+0xe4/0x2f0
>  __rpc_execute from rpc_async_schedule+0x18/0x24
>  rpc_async_schedule from process_one_work+0x170/0x210
>  process_one_work from worker_thread+0x204/0x2a4
>  worker_thread from kthread+0xb0/0xbc
>  kthread from ret_from_fork+0x14/0x2c
> Exception stack(0xc4e0dfb0 to 0xc4e0dff8)
> dfa0:                                     00000000 00000000 00000000 000000=
00
> dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000000=
00
> dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> Mem-Info:
> active_anon:2703 inactive_anon:6291 isolated_anon:209
>  active_file:541 inactive_file:530 isolated_file:0
>  unevictable:0 dirty:0 writeback:3781
>  slab_reclaimable:391 slab_unreclaimable:2993
>  mapped:0 shmem:0 pagetables:107 bounce:0
>  kernel_misc_reclaimable:0
>  free:0 free_pcp:26 free_cma:0
> Node 0 active_anon:10812kB inactive_anon:25164kB active_file:2164kB
> inactive_file:2120kB unevictable:0kB isolated(anon):836kB
> isolated(file):0kB mapped:0kB dirty:0kB writeback:15124kB shmem:0kB
> writeback_tmp:0kB kernel_stack:408kB pagetables:428kB
> all_unreclaimable? yes
> Normal free:0kB boost:0kB min:948kB low:1184kB high:1420kB
> reserved_highatomic:0KB active_anon:10812kB inactive_anon:25164kB
> active_file:2164kB inactive_file:2120kB unevictable:0kB
> writepending:13284kB present:65536kB managed:57428kB mlocked:0kB
> bounce:0kB free_pcp:104kB local_pcp:104kB free_cma:0kB
> lowmem_reserve[]: 0 0
> Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB
> 0*1024kB 0*2048kB 0*4096kB =3D 0kB
> 10274 total pagecache pages
> 9203 pages in swap cache
> Swap cache stats: add 9834, delete 631, find 61/77
> Free swap  =3D 1009180kB
> Total swap =3D 1048572kB
> 16384 pages RAM
> 0 pages HighMem/MovableOnly
> 2027 pages reserved
> sio_write_complete: 29066 callbacks suppressed
> ...
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org
>=20
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like t=
hat.
>                                 -- Linus Torvalds
>=20
