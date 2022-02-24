Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A3B4C37F3
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 22:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbiBXVkN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 16:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiBXVkM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 16:40:12 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E127184605
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 13:39:42 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id c18so4374720ioc.6
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 13:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6hP/kSjGELOkIRH04cXJflTj9DZNnV7Qw6a6BDbM05o=;
        b=aKdJevNF+QquTdbICsBFP2Fev6HoxChePxW49LKdEYVAFub87ypShjVMU6JPPhW/uS
         W6xi8Tia9z/odlIQA7VkJweag60bwDRcKemkUnxcItKrxmsEWf5hprmSRj2jCQO1DSHz
         Ne6AXxILzAxA3ZtMvMtxjsezoHQfbNETLqiegpYvktps26gLhkxK+VwpW3UZKBF+QIW1
         s2KTSBUiWT1EylbxUVCyoRLD5L10drmKpA/s1WV5zngMVy4HqxjhwmzY7/nhfCstN3CY
         FSUlkaHaQHiM7k9lz/RI+sagp/+yibUF+Oi9flX1q/j5DHatogmDKbGfkH8NQjbComEu
         n9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6hP/kSjGELOkIRH04cXJflTj9DZNnV7Qw6a6BDbM05o=;
        b=yDOAFc8v0ho1/2X9eS9aQmuL1KpwndjcA+4S2fKz62vQQdts2b7bpnqRoAjn4lft5/
         C7/gNZkEI4Ck8mV2QBTvB/5rvOxhMxGf/E+EUWEb7sWZtv+2xJFZATBEe4qC0lJh2yzx
         C9Hqo4cBuGkubjF8VSZPmmOeMoGBziHaWI33cSpUbz8ef3ySjS+QeivyBIbuia438GcN
         1H2T6yIJ9EqOj7Kmbs+T56Q1tL8A3ei4F0EZhzh33wtNrCcNZ1jKeKRs1637BRlTnN4o
         toDQTfcRiCHdHYfOUxLMhu41b7Xqfzd63vwtMmwiHX4C+T0OKsCzl7AfCkeatfESYXz1
         4eng==
X-Gm-Message-State: AOAM532OeTtEYJAkSf2xChMn+2kl0RSEhzRl7glSYfw7PoridZ2sWcLZ
        9IerVZrctj6hX4zvlAKWQqJG/7uZv/fJCgULi1Q=
X-Google-Smtp-Source: ABdhPJzhw9ZH1Z/bPgTF/Bs42BDxEeq+uGc0KuX1L5gztS5ysH9qnGi7GBl9n8AyTIWtGQOzXfmBvG3kW6AJZDkCpfA=
X-Received: by 2002:a02:ac10:0:b0:315:40bb:4ebf with SMTP id
 a16-20020a02ac10000000b0031540bb4ebfmr2805233jao.1.1645738781481; Thu, 24 Feb
 2022 13:39:41 -0800 (PST)
MIME-Version: 1.0
References: <20220224161705.1041788-1-amir73il@gmail.com> <BB7DEB92-1E3D-4BF5-A723-650C2B95877D@oracle.com>
In-Reply-To: <BB7DEB92-1E3D-4BF5-A723-650C2B95877D@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 24 Feb 2022 23:39:30 +0200
Message-ID: <CAOQ4uxgUEn0MpBYH8YU3paeJ5r0n545FuWmzb_yLEyoa1VkVtw@mail.gmail.com>
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

On Thu, Feb 24, 2022 at 10:41 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
> Hi Amir-
>
> > On Feb 24, 2022, at 11:17 AM, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > The nfsd file cache table can be pretty large and its allocation
> > may require as many as 80 contigious pages.
> >
> > Employ the same fix that was employed for similar issue that was
> > reported for the reply cache hash table allocation several years ago
> > by commit 8f97514b423a ("nfsd: more robust allocation failure handling
> > in nfsd_reply_cache_init").
> >
> > Fixes: 65294c1f2c5e ("nfsd: add a new struct file caching facility to nfsd")
> > Link: https://lore.kernel.org/linux-nfs/e3cdaeec85a6cfec980e87fc294327c0381c1778.camel@kernel.org/
> > Suggested-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Since v1:
> > - Use kvcalloc()
> > - Use kvfree()
> >
> > fs/nfsd/filecache.c | 6 +++---
> > 1 file changed, 3 insertions(+), 3 deletions(-)
>
> v2 passes some simple testing, so I've applied it to NFSD for-next.
> It should get 0-day and merge testing and is available for others
> to try out.
>
> I don't have anything that exercises low memory scenarios, though.
> Do you have anything like this to try?

Well, it is not low memory really it's fragmented memory.
I would try setting:

CONFIG_FAIL_PAGE_ALLOC=y

echo 5 > /sys/kernel/debug/fail_page_alloc/min-order
echo 100 > /sys/kernel/debug/fail_page_alloc/probability

and starting (or restarting) nfsd.
hoping that other large page allocations won't get in the way.

I gave it a shot, but couldn't figure out why nfsd4_files slab
is still there after stopping nfs-server service, meaning that
nfsd_file_cache_shutdown() was not called - I must be missing
something. I may play with this some more tomorrow.

Thanks,
Amir.
