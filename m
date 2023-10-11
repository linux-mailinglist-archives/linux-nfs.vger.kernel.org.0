Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2193B7C5062
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Oct 2023 12:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346336AbjJKKki convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Wed, 11 Oct 2023 06:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345805AbjJKKkh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Oct 2023 06:40:37 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2D194;
        Wed, 11 Oct 2023 03:40:35 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d8168d08bebso6998274276.0;
        Wed, 11 Oct 2023 03:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697020834; x=1697625634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtGuYBlgTBTwodGa4asWZDEh9ZL8e/zNjMxyzD1YoqA=;
        b=bOFXFCWIk2W5HKQxhuXpsfFwIHoAWS5JQdWA6FAbx3d0neYg/g/zIuItM/BL4+xc/1
         +jbqTAFwKV7lcJCB9g3KthE+kUG3i+BqIe/bY8kFlM7AkFX0IoEbZspDc38QaabEYI0o
         +0szds9EmFhKKJxVnugIOCCDEjC+fbi5ejAzXBGqDZ0cuU8Hb/0aWRIxuDnMUVolM9Yx
         j89QfrhroMGVrEdSUW/n9KWIph8rqT8nsgFG3IFELtVAYoyeE+5huD7dxkdL2lM+WGFZ
         IgRibVwg9/7BE7d00aifdyRS9j4OOutvPq5BLXYAWNUfBIS5tKR92+GvnYzF9RM8QlOg
         Qvaw==
X-Gm-Message-State: AOJu0YzZdqH5foFRBE9HXdjpwuoFIy5IjkHq9gd2vH2RgFI2FKev2kI3
        wMd6KTBOQMrRnisSox21K9QP61v4FETKLg==
X-Google-Smtp-Source: AGHT+IHIExlvrDLK4rkpJ4T50qI22Dwy/QCRmv+GsAOM4DsClIeWa+lPGNjUXWhFO9bzzNQUUvMJUw==
X-Received: by 2002:a25:ae4f:0:b0:d9a:58e1:106d with SMTP id g15-20020a25ae4f000000b00d9a58e1106dmr4526527ybe.52.1697020834218;
        Wed, 11 Oct 2023 03:40:34 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id n7-20020a259f07000000b00d3596aca5bcsm4326868ybq.34.2023.10.11.03.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 03:40:33 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5a7dd65052aso8580107b3.0;
        Wed, 11 Oct 2023 03:40:33 -0700 (PDT)
X-Received: by 2002:a81:8a03:0:b0:598:9df6:1a4f with SMTP id
 a3-20020a818a03000000b005989df61a4fmr22565294ywg.39.1697020833149; Wed, 11
 Oct 2023 03:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <707e5e6dd0db9a663cf443564d1f8ee1c10a0086.1697018818.git.geert+renesas@glider.be>
In-Reply-To: <707e5e6dd0db9a663cf443564d1f8ee1c10a0086.1697018818.git.geert+renesas@glider.be>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 11 Oct 2023 12:40:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXh8ZvVFinFv0b8M9iOxTG4Estvm7Kimv-ytLHTtna_dw@mail.gmail.com>
Message-ID: <CAMuHMdXh8ZvVFinFv0b8M9iOxTG4Estvm7Kimv-ytLHTtna_dw@mail.gmail.com>
Subject: Re: [PATCH] sunrpc: Use no_printk() in dfprintk*() dummies
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 11, 2023 at 12:07 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> When building NFS with W=1 and CONFIG_WERROR=y, but
> CONFIG_SUNRPC_DEBUG=n:
>
>     fs/nfs/nfs4proc.c: In function ‘nfs4_proc_create_session’:
>     fs/nfs/nfs4proc.c:9276:19: error: variable ‘ptr’ set but not used [-Werror=unused-but-set-variable]
>      9276 |         unsigned *ptr;
>           |                   ^~~
>       CC      fs/nfs/callback.o
>     fs/nfs/callback.c: In function ‘nfs41_callback_svc’:
>     fs/nfs/callback.c:98:13: error: variable ‘error’ set but not used [-Werror=unused-but-set-variable]
>        98 |         int error;
>           |             ^~~~~
>       CC      fs/nfs/flexfilelayout/flexfilelayout.o
>     fs/nfs/flexfilelayout/flexfilelayout.c: In function ‘ff_layout_io_track_ds_error’:
>     fs/nfs/flexfilelayout/flexfilelayout.c:1230:13: error: variable ‘err’ set but not used [-Werror=unused-but-set-variable]
>      1230 |         int err;
>           |             ^~~
>       CC      fs/nfs/flexfilelayout/flexfilelayoutdev.o
>     fs/nfs/flexfilelayout/flexfilelayoutdev.c: In function ‘nfs4_ff_alloc_deviceid_node’:
>     fs/nfs/flexfilelayout/flexfilelayoutdev.c:55:16: error: variable ‘ret’ set but not used [-Werror=unused-but-set-variable]
>        55 |         int i, ret = -ENOMEM;
>           |                ^~~
>
> All these are due to variables that are set uncontionally, but are used
> only when debugging is enabled.
>
> Fix this by changing the dfprintk*() dummy macros from empty loops to
> calls to the no_printk() helper.  This informs the compiler that the
> passed debug parameters are actually used, and enables format specifier
> checking as a bonus.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  include/linux/sunrpc/debug.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/sunrpc/debug.h b/include/linux/sunrpc/debug.h
> index f6aeed07fe04e3d5..76539c6673f2fb15 100644
> --- a/include/linux/sunrpc/debug.h
> +++ b/include/linux/sunrpc/debug.h
> @@ -67,9 +67,9 @@ do {                                                                  \
>  # define RPC_IFDEBUG(x)                x
>  #else
>  # define ifdebug(fac)          if (0)
> -# define dfprintk(fac, fmt, ...)       do {} while (0)
> -# define dfprintk_cont(fac, fmt, ...)  do {} while (0)
> -# define dfprintk_rcu(fac, fmt, ...)   do {} while (0)
> +# define dfprintk(fac, fmt, ...)       no_printk(fmt, ##__VA_ARGS__)
> +# define dfprintk_cont(fac, fmt, ...)  no_printk(fmt, ##__VA_ARGS__)
> +# define dfprintk_rcu(fac, fmt, ...)   no_printk(fmt, ##__VA_ARGS__)
>  # define RPC_IFDEBUG(x)
>  #endif

Bummer, this is causing issues in fs/lockd/svclock.c
Will fix in v2.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
