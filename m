Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C0E7CF1CC
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Oct 2023 09:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjJSH4e convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Thu, 19 Oct 2023 03:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbjJSH4X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Oct 2023 03:56:23 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81D918F;
        Thu, 19 Oct 2023 00:56:20 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5a877e0f0d8so4131977b3.1;
        Thu, 19 Oct 2023 00:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697702179; x=1698306979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILA4o27dVPsrTvX39+vJ0cM2vmBOHexNEBZq7C7F7Q4=;
        b=vkqwqUniFC7sHrHyeBnoLDG5xu3k0+4HgdrqzlT3kkwKs7bPqa9tx5bDjK+nbJ5bNG
         ttfftdb60tEpNzPW/0K1fmEiDwCCTBk95n1LdpMnKC2Oormn7h4X4jgOr1OK71tchw1f
         YmFUHsGN9yS/xi4RNldCttQ5Z0LxcIZiFLpHhBNIoFngYF1mB06zj+56hGruWuo2hiPY
         WIBvp+d8GdQoTh0aMz2PeF7/u40PPFSn5SYWV9TSzRBC/d23qo7OHu9FZvV+Ofy0wgM0
         irGeOelCzjbA7vUs1qtlAf5EgV2qJd16YdsbbS5M03CE+F98QObV21cGUKNMqEXl0UE3
         U7TA==
X-Gm-Message-State: AOJu0Yyi8d2S/vjBl3NE55uzryfuia5okf7k9nVLybVvDXmoq0kXAvaH
        tYxu8H6zp1C1bR4+tuiVMga7LJ/M9PYDww==
X-Google-Smtp-Source: AGHT+IG21ROdISrPbCBLp5cWx5y/1gsWfelir/oiXSoqjVmIxzGmkckdwAlHEmmxbYvw6iliPtcUYQ==
X-Received: by 2002:a05:6902:1346:b0:d9a:c54d:6fbb with SMTP id g6-20020a056902134600b00d9ac54d6fbbmr850072ybu.0.1697702179595;
        Thu, 19 Oct 2023 00:56:19 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id u66-20020a25ab48000000b00d9c7bf8f32fsm1154360ybi.42.2023.10.19.00.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 00:56:19 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-d9ac3b4f42cso441396276.0;
        Thu, 19 Oct 2023 00:56:18 -0700 (PDT)
X-Received: by 2002:a05:690c:dcb:b0:5a7:b892:b299 with SMTP id
 db11-20020a05690c0dcb00b005a7b892b299mr897843ywb.19.1697702177865; Thu, 19
 Oct 2023 00:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697460614.git.geert+renesas@glider.be> <180fd042261dcd4243fad90660b114b8f0a78dcd.1697460614.git.geert+renesas@glider.be>
In-Reply-To: <180fd042261dcd4243fad90660b114b8f0a78dcd.1697460614.git.geert+renesas@glider.be>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 19 Oct 2023 09:56:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXnnr0cH66nwtk1Tj7odMKSQyAWCezQFMzVe+xa+0Kx1w@mail.gmail.com>
Message-ID: <CAMuHMdXnnr0cH66nwtk1Tj7odMKSQyAWCezQFMzVe+xa+0Kx1w@mail.gmail.com>
Subject: Re: [PATCH -next v3 2/2] sunrpc: Use no_printk() in dfprintk*() dummies
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc:     linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
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

On Mon, Oct 16, 2023 at 3:09 PM Geert Uytterhoeven
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
> All these are due to variables that are set unconditionally, but are
> used only when debugging is enabled.
>
> Fix this by changing the dfprintk*() dummy macros from empty loops to
> calls to the no_printk() helper.  This informs the compiler that the
> passed debug parameters are actually used, and enables format specifier
> checking as a bonus.
>
> This requires removing the protection by CONFIG_SUNRPC_DEBUG of the
> declaration of nlmdbg_cookie2a() in fs/lockd/svclock.c, as its reference
> is now visible to the compiler, but optimized away.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Jeff Layton <jlayton@kernel.org>

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

I discovered a new build issue related to the use of RPC_IFDEBUG()
in fs/nfsd/nfsfh.c. So there will be a v4...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
