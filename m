Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2834C5787
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Feb 2022 19:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiBZSiA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 26 Feb 2022 13:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbiBZSh7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 26 Feb 2022 13:37:59 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E6D6251
        for <linux-nfs@vger.kernel.org>; Sat, 26 Feb 2022 10:37:24 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id d3so6921538ilr.10
        for <linux-nfs@vger.kernel.org>; Sat, 26 Feb 2022 10:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ROWC3oLZPFBkWKevWJFiGndZDNXs/VTAqJBNpj3go0k=;
        b=YMmDrf+S++1P8ZV9XlEvbqmoCHqESqlFBbbHCy+lZQ6c6i9MweDx14NCGwJAB1Ha66
         bHLng7SwKvmSR6/gbDKVkKejBFguKWQGMMeBZKS/yEGM2ENDJoIZbPfNHXxoo/y2rMTB
         HBBtWeHmD2T5pXqJLrWStivG/mB8KzvIAF5DBuoWXbXiF2TQf5C6gUyZXMPR9HV8Xu5R
         vFQpXdbgZS4yHH07+uWGSlV8nKqeCzDu4ABE76vNGggrCd6xQlpk0Qys+cTNHiV6sB2a
         v60CP3kmLyJkiaDKMk5/rec911V6ajvxEzxA2lOLDxcTi1Fnwaf2VKu+mBIdO2HPyLFw
         XbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ROWC3oLZPFBkWKevWJFiGndZDNXs/VTAqJBNpj3go0k=;
        b=GTw2s2X2bIZUryPsRkjJcaTsz60MSYzP5y6l7YnJWEILh75L4UQv7P4Gihuiv9wUBv
         D6v9XgD46RS68AR56uq/NB4sGvjZUBn9v2CTATAslk1GffAdu5wZSXWut0+1B6G73aEd
         c2a/F9UEf8WizWU22nhCymxnjmOBd1H1oh3XVVZidQ+QD9dgwsSMZ78Ro5lqWuc+Eed+
         LGPkwwJSe3bL7MMCY0tTWrrxqIh8o9Sk5wcfKUIPsyxEIrRTv2X9d2e2Vcnr84oZhg9O
         Ksh4SKGYnT+bkhb/lm6NvqXaQqnpAFk/oCYBhhNMN2d1YrI4Pbx3qORtXAu2dsmThIiv
         xpEQ==
X-Gm-Message-State: AOAM531Abfp6uhUsM7DTBXNc9Bszx7XPK7O6XfdNVxSRBbiApJpzIWwb
        ioCGVZP+Lv8uMxebXZjyFQ4U47lw/d792q7KLI4QQ3aBkrg=
X-Google-Smtp-Source: ABdhPJxASLUqUIOAQmnkE/0clwQrQ0y70r3DuKgurU4HTiMk/t+VBv/HNrB1uoynk35fnJmQqLa00ddZS2KG7nVJsYo=
X-Received: by 2002:a05:6e02:214a:b0:2bf:a442:cbff with SMTP id
 d10-20020a056e02214a00b002bfa442cbffmr11968028ilv.107.1645900643582; Sat, 26
 Feb 2022 10:37:23 -0800 (PST)
MIME-Version: 1.0
References: <20220224161705.1041788-1-amir73il@gmail.com> <BB7DEB92-1E3D-4BF5-A723-650C2B95877D@oracle.com>
 <CAOQ4uxgUEn0MpBYH8YU3paeJ5r0n545FuWmzb_yLEyoa1VkVtw@mail.gmail.com>
In-Reply-To: <CAOQ4uxgUEn0MpBYH8YU3paeJ5r0n545FuWmzb_yLEyoa1VkVtw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 26 Feb 2022 20:37:12 +0200
Message-ID: <CAOQ4uxiPYpVcL2_YpRFU58kfjPFvTY+Hwz6Z1FNvFGDaupv-cA@mail.gmail.com>
Subject: Re: [PATCH v2] nfsd: more robust allocation failure handling in nfsd_file_cache_init
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Feb 24, 2022 at 11:39 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Feb 24, 2022 at 10:41 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
> >
> > Hi Amir-
> >
> > > On Feb 24, 2022, at 11:17 AM, Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > The nfsd file cache table can be pretty large and its allocation
> > > may require as many as 80 contigious pages.
> > >
> > > Employ the same fix that was employed for similar issue that was
> > > reported for the reply cache hash table allocation several years ago
> > > by commit 8f97514b423a ("nfsd: more robust allocation failure handling
> > > in nfsd_reply_cache_init").
> > >
> > > Fixes: 65294c1f2c5e ("nfsd: add a new struct file caching facility to nfsd")
> > > Link: https://lore.kernel.org/linux-nfs/e3cdaeec85a6cfec980e87fc294327c0381c1778.camel@kernel.org/
> > > Suggested-by: Jeff Layton <jlayton@kernel.org>
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >
> > > Since v1:
> > > - Use kvcalloc()
> > > - Use kvfree()
> > >
> > > fs/nfsd/filecache.c | 6 +++---
> > > 1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > v2 passes some simple testing, so I've applied it to NFSD for-next.
> > It should get 0-day and merge testing and is available for others
> > to try out.
> >
> > I don't have anything that exercises low memory scenarios, though.
> > Do you have anything like this to try?
>
> Well, it is not low memory really it's fragmented memory.
> I would try setting:
>
> CONFIG_FAIL_PAGE_ALLOC=y
>
> echo 5 > /sys/kernel/debug/fail_page_alloc/min-order
> echo 100 > /sys/kernel/debug/fail_page_alloc/probability
>
> and starting (or restarting) nfsd.
> hoping that other large page allocations won't get in the way.
>
> I gave it a shot, but couldn't figure out why nfsd4_files slab
> is still there after stopping nfs-server service, meaning that
> nfsd_file_cache_shutdown() was not called - I must be missing
> something. I may play with this some more tomorrow.
>

Ok, I was missing some parameters.
This configuration reproduces and failure and verified that the
kvcalloc() fix solves the issue:

$ systemctl stop nfs-server
$ echo 5 > /sys/kernel/debug/fail_page_alloc/min-order
$ echo 100 > /sys/kernel/debug/fail_page_alloc/probability
$ echo 1 > /sys/kernel/debug/fail_page_alloc/times
$ echo N > /sys/kernel/debug/fail_page_alloc/ignore-gfp-wait
$ systemctl start nfs-server

[   24.410560] FAULT_INJECTION: forcing a failure.
[   24.410560] name fail_page_alloc, interval 1, probability 100,
space 0, times 1
[   24.413887] CPU: 1 PID: 1218 Comm: rpc.nfsd Not tainted
5.17.0-rc2-xfstests #5927
[   24.415625] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.13.0-1ubuntu1.1 04/01/2014
[   24.417098] Call Trace:
[   24.417098]  <TASK>
[   24.417098]  dump_stack_lvl+0x45/0x59
[   24.418999]  should_fail+0x11a/0x13d
[   24.418999]  prepare_alloc_pages.isra.0+0x97/0xc5
[   24.418999]  __alloc_pages+0x76/0x1c7
[   24.418999]  kmalloc_order+0x35/0xa7
[   24.418999]  kmalloc_order_trace+0x1b/0xf3
[   24.418999]  nfsd_file_cache_init+0x5b/0x2d8
[   24.418999]  nfsd_svc+0xcd/0x2b2
[   24.427086]  write_threads+0x6d/0xb5
[   24.427086]  ? get_int+0x70/0x70
[   24.429020]  nfsctl_transaction_write+0x4f/0x67
[   24.429020]  vfs_write+0xe3/0x14b
[   24.429020]  ksys_write+0x7f/0xcb
[   24.429020]  do_syscall_64+0x6d/0x80
[   24.429020]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   24.429020] RIP: 0033:0x7f29d80d6504
[   24.429020] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b3 0f
1f 80 00 00 00 00 48 8d 05 f9 61 0d 00 8b 00 85 c0 75 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 49 89 d4 55 48 89
f5 53
[   24.439028] RSP: 002b:00007ffe867a47f8 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[   24.439028] RAX: ffffffffffffffda RBX: 00007f29d8219560 RCX: 00007f29d80d6504
[   24.442325] RDX: 0000000000000002 RSI: 00007f29d8219560 RDI: 0000000000000003
[   24.442325] RBP: 0000000000000003 R08: 0000000000000000 R09: 00007ffe867a4557
[   24.445644] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[   24.445644] R13: 0000000000000008 R14: 0000000000000000 R15: 00007f29d83572a0
[   24.449026]  </TASK>
[   24.450496] nfsd: unable to allocate nfsd_file_hashtbl
Job for nfs-server.service canceled.

With the fix patch, nfsd starts despite the injected failure.

Thanks,
Amir.
