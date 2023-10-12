Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DBF7C6AC6
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Oct 2023 12:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347120AbjJLKRd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Thu, 12 Oct 2023 06:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347110AbjJLKRc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Oct 2023 06:17:32 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD89C4;
        Thu, 12 Oct 2023 03:17:30 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-59f6492b415so6523687b3.0;
        Thu, 12 Oct 2023 03:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697105849; x=1697710649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7H6hbQOaTA6o7GepYq/s3qB0kUcBwxXV7q1sULTA+o=;
        b=C8UXiZTYGk9XTMAOCB1TQ4VptPRoNHqt+P/4EDNJRWMgfalk6zI1EAAT6eVYez8cjv
         tH3j+BFTDnJVEAXUKuq/7ZLqDTfBAioprH0n4lRluOMgDCr2dJfGMfLpKqjhdyqzDJrX
         35kwaRYzBk7xR1VvpUbRc4CgfD4dQvHHcPEBtcEm9JZNVAm9+lFfxpy2LcS+iBLjKqtm
         rlMRljJWMlhTzphSiRx+C68tgYkeNy7PBxM3DccHStjy4qdAvw46EoX5H6UcBdL7fnVl
         TJPAWDtUIoNsQKRoHCLOSX3mKYzSpvw0v7vLEiDQwbjSvjWv6FVSbOzsKuQPFSmBatLo
         jgtw==
X-Gm-Message-State: AOJu0YxZSxjuH4Q9Cuht3kpLBfAglLbu/NmdU+kNcIN8FwTdlPRK51lJ
        eRkxplSrfHCm1RIgHbdRy6lTvlc+AJIsFg==
X-Google-Smtp-Source: AGHT+IEiYPGfwVO62nLa5B1gm/B03Zcz2OSijEQuB3Sk37FSQ2eYN5CtHY/872NSg+hriPrf9KR0Qg==
X-Received: by 2002:a05:690c:2846:b0:5a7:b545:dcaa with SMTP id ed6-20020a05690c284600b005a7b545dcaamr5184345ywb.23.1697105849361;
        Thu, 12 Oct 2023 03:17:29 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id r135-20020a0de88d000000b005a1cc37aff1sm5729089ywe.20.2023.10.12.03.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 03:17:29 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-59f6492b415so6523607b3.0;
        Thu, 12 Oct 2023 03:17:29 -0700 (PDT)
X-Received: by 2002:a0d:d78b:0:b0:5a7:be3f:c451 with SMTP id
 z133-20020a0dd78b000000b005a7be3fc451mr5103713ywd.3.1697105848998; Thu, 12
 Oct 2023 03:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <a93de2e8afa826745746b00fc5f64e513df5d52f.1697104757.git.geert+renesas@glider.be>
In-Reply-To: <a93de2e8afa826745746b00fc5f64e513df5d52f.1697104757.git.geert+renesas@glider.be>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 Oct 2023 12:17:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXUT54XLT1hGmQM_gxPqSo1H6cyvTOByEi1eNVZEOcCBA@mail.gmail.com>
Message-ID: <CAMuHMdXUT54XLT1hGmQM_gxPqSo1H6cyvTOByEi1eNVZEOcCBA@mail.gmail.com>
Subject: Re: [PATCH -next v2] sunrpc: Use no_printk() in dfprintk*() dummies
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Oct 12, 2023 at 12:08 PM Geert Uytterhoeven
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
> declaration of nlmdbg_cookie2a(), as its reference is now visible to the
> compiler, but optimized away.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - s/uncontionally/unconditionally/,
>   - Drop CONFIG_SUNRPC_DEBUG check in fs/lockd/svclock.c to fix build
>     failure.

The robots pointed out a second build failure, which is not fixed by this v2:
https://lore.kernel.org/all/202310121759.0CF34DcN-lkp@intel.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
