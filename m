Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3061677CC3D
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Aug 2023 14:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236784AbjHOMA6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 15 Aug 2023 08:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbjHOMA1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Aug 2023 08:00:27 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790A01986;
        Tue, 15 Aug 2023 05:00:11 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-586a684e85aso58463847b3.2;
        Tue, 15 Aug 2023 05:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692100810; x=1692705610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3u5LiIkAvVxxVW8WpXnX66pDAcHsjww5QTR5ehXhYNA=;
        b=Hn453UsvfndxumrXvl0km6R3VIJcTpTQykqVCIZD9ramDszHvU6TNq7eHRJRwxOdzm
         S38ZulOMDFN/5TrQnO0+38RjA7BRnqLiRsylxACTOsp5fhucbnsb3FZaMm2eIOJEPy7Y
         X3UA6sTKu5AvcYqk2KBCqMG7TN3+9QgLJ3PnVgfq5cR9nNpTyA+up0AM+Iq6EWBJftdc
         84V3Yd+fRzcjVTYUZV99JQjLAtXWMsjWIxCzWL/2sjQZvfelnJw2ZaAy7iSdL6YkCC8y
         KFbmJ8L+vzstxPuJWA2Jd8U9L+7/6IjT9d4Mx1YkXgG7YmsFJY72KbGuS6sRVKPITDLh
         SJmw==
X-Gm-Message-State: AOJu0YxOcL2OvAUFH72rRErVQ2cMo1oirwWq21alX/6+xaszjCqZi2F5
        vccrzvh9HiSk5Xv5zE8Pj8N0WuzpH2hGZw==
X-Google-Smtp-Source: AGHT+IF7kIxXsAsVjN7i/XrmQh41p3/4MbZfd1ev637Wko1uza9drWxvSQzNxC0xBzPPNW5w/U1aOw==
X-Received: by 2002:a0d:db82:0:b0:589:f494:3e42 with SMTP id d124-20020a0ddb82000000b00589f4943e42mr5512254ywe.40.1692100808994;
        Tue, 15 Aug 2023 05:00:08 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id z16-20020a81c210000000b005463e45458bsm3339841ywc.123.2023.08.15.05.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 05:00:08 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d6d52f4f977so1444771276.2;
        Tue, 15 Aug 2023 05:00:08 -0700 (PDT)
X-Received: by 2002:a25:ac89:0:b0:d5d:4bae:6fe0 with SMTP id
 x9-20020a25ac89000000b00d5d4bae6fe0mr13355730ybi.21.1692100808320; Tue, 15
 Aug 2023 05:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <6702796fee0365bf399800326bbe6c88e5f73f68.1689014440.git.bcodding@redhat.com>
 <54144a14-606a-4f2c-ca19-9b762e1f7e91@linux-m68k.org>
In-Reply-To: <54144a14-606a-4f2c-ca19-9b762e1f7e91@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Aug 2023 13:59:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWNW4dHZmPjJ9WUqA40_4ZvAM2DqcLMe18jWgmu=9UeRw@mail.gmail.com>
Message-ID: <CAMuHMdWNW4dHZmPjJ9WUqA40_4ZvAM2DqcLMe18jWgmu=9UeRw@mail.gmail.com>
Subject: Re: [PATCH] NFS: Fix sysfs server name memory leak
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        aahringo@redhat.com, linux-nfs@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

CC regressions

On Fri, Jul 14, 2023 at 5:29 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, 10 Jul 2023, Benjamin Coddington wrote:
> > Free the formatted server index string after it has been duplicated by
> > kobject_rename().
> >
> > Fixes: 1c7251187dc0 ("NFS: add superblock sysfs entries")
> > Reported-by: Alexander Aring <aahringo@redhat.com>
> > Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>
> Thanks!
>
> This fixes the memory leaks I was seeing:
>
>      # cat /sys/kernel/debug/kmemleak
>      unreferenced object 0xc6d3b7c0 (size 64):
>        comm "mount.nfs", pid 261, jiffies 4294943450 (age 1385.530s)
>        hex dump (first 32 bytes):
>         73 65 72 76 65 72 2d 32 00 00 00 00 00 00 00 00  server-2........
>         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>        backtrace:
>         [<7849dbd6>] slab_post_alloc_hook.constprop.0+0x9c/0xac
>         [<bf2297e0>] __kmem_cache_alloc_node+0xc4/0x124
>         [<07299a52>] __kmalloc_node_track_caller+0x80/0xa4
>         [<1876b300>] kvasprintf+0x5c/0xcc
>         [<4fa40352>] kasprintf+0x28/0x58
>         [<68e29ee6>] nfs_sysfs_move_sb_to_server+0x18/0x50
>         [<6a98700b>] nfs_kill_super+0x18/0x34
>         [<d388276a>] deactivate_locked_super+0x50/0x88
>         [<3945c450>] cleanup_mnt+0x6c/0xc8
>         [<fb0ac980>] task_work_run+0x84/0xb4
>         [<d6ee2bd3>] do_work_pending+0x364/0x398
>         [<c7a0dcab>] slow_work_pending+0xc/0x20
>      unreferenced object 0xc6cdd6c0 (size 64):
>        comm "mount.nfs", pid 261, jiffies 4294943456 (age 1385.470s)
>        hex dump (first 32 bytes):
>         73 65 72 76 65 72 2d 31 00 00 00 00 00 00 00 00  server-1........
>         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>        backtrace:
>         [<7849dbd6>] slab_post_alloc_hook.constprop.0+0x9c/0xac
>         [<bf2297e0>] __kmem_cache_alloc_node+0xc4/0x124
>         [<07299a52>] __kmalloc_node_track_caller+0x80/0xa4
>         [<1876b300>] kvasprintf+0x5c/0xcc
>         [<4fa40352>] kasprintf+0x28/0x58
>         [<68e29ee6>] nfs_sysfs_move_sb_to_server+0x18/0x50
>         [<6a98700b>] nfs_kill_super+0x18/0x34
>         [<d388276a>] deactivate_locked_super+0x50/0x88
>         [<3945c450>] cleanup_mnt+0x6c/0xc8
>         [<fb0ac980>] task_work_run+0x84/0xb4
>         [<d6ee2bd3>] do_work_pending+0x364/0x398
>         [<c7a0dcab>] slow_work_pending+0xc/0x20
>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> > --- a/fs/nfs/sysfs.c
> > +++ b/fs/nfs/sysfs.c
> > @@ -345,8 +345,10 @@ void nfs_sysfs_move_sb_to_server(struct nfs_server *server)
> >       int ret = -ENOMEM;
> >
> >       s = kasprintf(GFP_KERNEL, "server-%d", server->s_sysfs_id);
> > -     if (s)
> > +     if (s) {
> >               ret = kobject_rename(&server->kobj, s);
> > +             kfree(s);
> > +     }
> >       if (ret < 0)
> >               pr_warn("NFS: rename sysfs %s failed (%d)\n",
> >                                       server->kobj.name, ret);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
