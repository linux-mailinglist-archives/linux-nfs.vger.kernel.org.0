Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB8B753EAA
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jul 2023 17:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbjGNPU1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jul 2023 11:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235941AbjGNPU1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jul 2023 11:20:27 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FB72D43
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jul 2023 08:20:25 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:1c19:8f7d:cd02:4beb])
        by albert.telenet-ops.be with bizsmtp
        id M3LH2A00i1j0DkV063LHfZ; Fri, 14 Jul 2023 17:20:22 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qKKaf-001Lav-SY;
        Fri, 14 Jul 2023 17:20:17 +0200
Date:   Fri, 14 Jul 2023 17:20:17 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Benjamin Coddington <bcodding@redhat.com>
cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        aahringo@redhat.com, linux-nfs@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] NFS: Fix sysfs server name memory leak
In-Reply-To: <6702796fee0365bf399800326bbe6c88e5f73f68.1689014440.git.bcodding@redhat.com>
Message-ID: <54144a14-606a-4f2c-ca19-9b762e1f7e91@linux-m68k.org>
References: <6702796fee0365bf399800326bbe6c88e5f73f68.1689014440.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

 	Hi Benjamin,

On Mon, 10 Jul 2023, Benjamin Coddington wrote:
> Free the formatted server index string after it has been duplicated by
> kobject_rename().
>
> Fixes: 1c7251187dc0 ("NFS: add superblock sysfs entries")
> Reported-by: Alexander Aring <aahringo@redhat.com>
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>

Thanks!

This fixes the memory leaks I was seeing:

     # cat /sys/kernel/debug/kmemleak
     unreferenced object 0xc6d3b7c0 (size 64):
       comm "mount.nfs", pid 261, jiffies 4294943450 (age 1385.530s)
       hex dump (first 32 bytes):
 	73 65 72 76 65 72 2d 32 00 00 00 00 00 00 00 00  server-2........
 	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
       backtrace:
 	[<7849dbd6>] slab_post_alloc_hook.constprop.0+0x9c/0xac
 	[<bf2297e0>] __kmem_cache_alloc_node+0xc4/0x124
 	[<07299a52>] __kmalloc_node_track_caller+0x80/0xa4
 	[<1876b300>] kvasprintf+0x5c/0xcc
 	[<4fa40352>] kasprintf+0x28/0x58
 	[<68e29ee6>] nfs_sysfs_move_sb_to_server+0x18/0x50
 	[<6a98700b>] nfs_kill_super+0x18/0x34
 	[<d388276a>] deactivate_locked_super+0x50/0x88
 	[<3945c450>] cleanup_mnt+0x6c/0xc8
 	[<fb0ac980>] task_work_run+0x84/0xb4
 	[<d6ee2bd3>] do_work_pending+0x364/0x398
 	[<c7a0dcab>] slow_work_pending+0xc/0x20
     unreferenced object 0xc6cdd6c0 (size 64):
       comm "mount.nfs", pid 261, jiffies 4294943456 (age 1385.470s)
       hex dump (first 32 bytes):
 	73 65 72 76 65 72 2d 31 00 00 00 00 00 00 00 00  server-1........
 	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
       backtrace:
 	[<7849dbd6>] slab_post_alloc_hook.constprop.0+0x9c/0xac
 	[<bf2297e0>] __kmem_cache_alloc_node+0xc4/0x124
 	[<07299a52>] __kmalloc_node_track_caller+0x80/0xa4
 	[<1876b300>] kvasprintf+0x5c/0xcc
 	[<4fa40352>] kasprintf+0x28/0x58
 	[<68e29ee6>] nfs_sysfs_move_sb_to_server+0x18/0x50
 	[<6a98700b>] nfs_kill_super+0x18/0x34
 	[<d388276a>] deactivate_locked_super+0x50/0x88
 	[<3945c450>] cleanup_mnt+0x6c/0xc8
 	[<fb0ac980>] task_work_run+0x84/0xb4
 	[<d6ee2bd3>] do_work_pending+0x364/0x398
 	[<c7a0dcab>] slow_work_pending+0xc/0x20

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/fs/nfs/sysfs.c
> +++ b/fs/nfs/sysfs.c
> @@ -345,8 +345,10 @@ void nfs_sysfs_move_sb_to_server(struct nfs_server *server)
> 	int ret = -ENOMEM;
>
> 	s = kasprintf(GFP_KERNEL, "server-%d", server->s_sysfs_id);
> -	if (s)
> +	if (s) {
> 		ret = kobject_rename(&server->kobj, s);
> +		kfree(s);
> +	}
> 	if (ret < 0)
> 		pr_warn("NFS: rename sysfs %s failed (%d)\n",
> 					server->kobj.name, ret);

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
