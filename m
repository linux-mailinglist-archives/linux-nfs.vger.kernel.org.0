Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C69750A34
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jul 2023 15:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjGLN6Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Jul 2023 09:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjGLN6N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Jul 2023 09:58:13 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF851BE4;
        Wed, 12 Jul 2023 06:58:05 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51e5da802afso3814328a12.3;
        Wed, 12 Jul 2023 06:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689170284; x=1691762284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQMNrclAvbBRhoVuUDnVsRXEIxi79plmNKhRa3O3DBM=;
        b=HQvvqi0OUTWIdNrva1Tjj8y2tOJS10SHIVs1TIJzV3j50yz5mHRmEzrpAqXP+VJ9QD
         An6/xGn1l/lshfiSqMikHIu7uUId2liQ9MbMYDdFljMWIf1N4uioQwA83muAgKs6+kRf
         0XH3gmfSrcx8RLiCc14vqlAHQ7CSjHTqa+mV6dkYboG9Mgj4ITzLmJiWxjZLxwbsfAJM
         aDGF07OxV52iGmj0h/MRR/EmruaoHiZL33kQ0MzVupYUx/eR0lPJIf7CZwS/DDTyd/yA
         5c6fhGHwYogiWW14EQW5DptXk11CEo+9wLsCE6wJ90HPmjlgbUTvLSBxBdMV+8FCwLka
         yJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689170284; x=1691762284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQMNrclAvbBRhoVuUDnVsRXEIxi79plmNKhRa3O3DBM=;
        b=VJUzqD44dDP40c+KaXlB8c9dse9FyS037FxzUY309mI/wqaskKazl6EoHKijenj2Gd
         /cgtFzOFf9cF7pRIYB7vmE4UA8dsnC0HoRX3sm4STNK5lIa4oozLvUKkaHE63qCXo95L
         q0XxlRfrvwbrl4Hi2208X6a2J9ORFEji6nkHHHlttHwKASJi32lU0+U0PkGd5LSa07E2
         4l1QBxbPzQB0foQc9frV8zvkzZZEieDkn/bclk6+b2bR3XB8WVwTMADZuOIlTI0HULIx
         RnxO4itwwwQjomrE5IjCZDvQa7jBkq9T+FsMSZl+xZ2zwhtyELmlJVNopCxQebJHD9PJ
         laPg==
X-Gm-Message-State: ABy/qLZjnGlWdC0SxTQPv3wIR7Wa+RGpC2pzYVn6nAr33xnSg7VxVMj4
        Uspe0vwAoUhlG44I5AzXOAuu2htpoZCy/INssfDKaUb3oDFypg==
X-Google-Smtp-Source: APBJJlHt79RDWYwWyxdwpwmNbYK4JBEubv4rtJYHkdFRlAy5aWbuuA20bhUVo7hGir8i0MlX9DbzkpHyxnnOGoV7Nkg=
X-Received: by 2002:aa7:d74f:0:b0:51d:9905:6f60 with SMTP id
 a15-20020aa7d74f000000b0051d99056f60mr16391700eds.41.1689170283768; Wed, 12
 Jul 2023 06:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230712134853.1044134-1-haowenchao2@huawei.com>
In-Reply-To: <20230712134853.1044134-1-haowenchao2@huawei.com>
From:   Wenchao Hao <haowenchao22@gmail.com>
Date:   Wed, 12 Jul 2023 21:57:55 +0800
Message-ID: <CAOptpSN6ce=1Ydmux3zrkNhOJ-JPZ+Pp-yP1CnWf5sT8Lo1qXg@mail.gmail.com>
Subject: Re: [PATCH] NFS: Fix memleak in nfs_sysfs_move_sb_to_server
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wenchao Hao <haowenchao2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jul 12, 2023 at 9:48=E2=80=AFPM Wenchao Hao <haowenchao22@gmail.com=
> wrote:
>
> call kfree() to free memory allocated in kasprintf() to fix
> memleak. It's easy to recurrent this memleak, just mount and
> remount nfs at NFS client.
>

I did not check the mail list before send this patch, Benjamin
Coddingto has fixed
it, so ignore this  please.

> The bug is detected by kmemleak with following stack:
> unreferenced object 0xffffa31a91fdf2c0 (size 16):
>   comm "mount.nfs", pid 960, jiffies 4294724478 (age 111892.067s)
>   hex dump (first 16 bytes):
>     73 65 72 76 65 72 2d 30 00 f2 fd 91 1a a3 ff ff  server-0........
>   backtrace:
>     [<00000000de9b21a9>] create_object+0x11/0x17
>     [<00000000ed17aa96>] kmemleak_alloc+0x6c/0x7a
>     [<000000009f4acc69>] slab_post_alloc_hook.constprop.0+0x81/0x99
>     [<00000000d2446455>] __kmem_cache_alloc_node+0x10c/0x13a
>     [<00000000eca4a704>] __kmalloc_node_track_caller+0x83/0xb7
>     [<0000000076cdb22f>] kvasprintf+0x65/0xc3
>     [<00000000f6f2e879>] kasprintf+0x4e/0x69
>     [<00000000e49d03be>] nfs_sysfs_move_sb_to_server+0x24/0x5f
>     [<0000000039127597>] nfs_kill_super+0x25/0x49
>     [<00000000e6ecf809>] deactivate_locked_super+0x35/0x74
>     [<000000003b9c3350>] deactivate_super+0x3c/0x44
>     [<00000000777c86be>] cleanup_mnt+0x6c/0xe7
>     [<000000009f181749>] __cleanup_mnt+0x12/0x18
>     [<00000000a709602e>] task_work_run+0x75/0x8c
>     [<0000000075da06ba>] exit_to_user_mode_prepare+0x79/0x102
>     [<0000000093a53d48>] syscall_exit_to_user_mode+0x1c/0x30
>
> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> ---
>  fs/nfs/sysfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
> index acda8f033d30..bf378ecd5d9f 100644
> --- a/fs/nfs/sysfs.c
> +++ b/fs/nfs/sysfs.c
> @@ -345,8 +345,10 @@ void nfs_sysfs_move_sb_to_server(struct nfs_server *=
server)
>         int ret =3D -ENOMEM;
>
>         s =3D kasprintf(GFP_KERNEL, "server-%d", server->s_sysfs_id);
> -       if (s)
> +       if (s) {
>                 ret =3D kobject_rename(&server->kobj, s);
> +               kfree(s);
> +       }
>         if (ret < 0)
>                 pr_warn("NFS: rename sysfs %s failed (%d)\n",
>                                         server->kobj.name, ret);
> --
> 2.35.3
>
