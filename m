Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8F57C6A9E
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Oct 2023 12:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbjJLKLW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Thu, 12 Oct 2023 06:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbjJLKLU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Oct 2023 06:11:20 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ECFD6;
        Thu, 12 Oct 2023 03:11:19 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d8168d08bebso768193276.0;
        Thu, 12 Oct 2023 03:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697105478; x=1697710278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayB48oEye0wkJNGcHILedrEPe86Z+o0FK5cblcxwBu4=;
        b=g20YNoiuUp3PJTtfneu/AAO3H6wREHiWkB19bYFIpP2L5qldrlaH0xB5mXOwOMG0bK
         rL0G7yOknP2XiUygWDvig3HyzyvaPK3DIHvtL1X+dsKugmYjdhutGAvNqnHLYdh4ffKU
         Cdjsv/VX7smfFBhAtCZIHoEz1SDQ85OgBaNMb81DPkiXQNJuxlvN9xOehdMuTWoOBy1y
         mPb+tGq0zS/MtuZ+OwQvstBPDBZZ56iynwUqBcI/B1GEnBD8jDpiANDiVR8njxqtt0yj
         Qzhip8FLdvPMPyC9TWbrIj6ybM9FXrcBFurx+UDT4mTI78Ghsn7ctCwtyrrlxeJSLwk0
         Oo2Q==
X-Gm-Message-State: AOJu0YxKSFPBClWODZz7s+lrMSSDSkBABySa0HGMbSF6BM0lUx99vnrP
        gdaKHigxOd2JK9de4YB2HhAcXOXzDVjacg==
X-Google-Smtp-Source: AGHT+IEL6O04651O106gAWi3QIrD9tCqu2hdglNn0tUAZClFZ/j8vJg0JK/yr/Fc5o+0D2oHUmphiw==
X-Received: by 2002:a25:c286:0:b0:d99:3a41:abec with SMTP id s128-20020a25c286000000b00d993a41abecmr12335661ybf.11.1697105478350;
        Thu, 12 Oct 2023 03:11:18 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id 85-20020a250d58000000b00d9a54e9b742sm1822370ybn.55.2023.10.12.03.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 03:11:18 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-d9a64ca9cedso754644276.1;
        Thu, 12 Oct 2023 03:11:18 -0700 (PDT)
X-Received: by 2002:a25:d345:0:b0:d9a:5d69:54b with SMTP id
 e66-20020a25d345000000b00d9a5d69054bmr7743541ybf.25.1697105477970; Thu, 12
 Oct 2023 03:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <707e5e6dd0db9a663cf443564d1f8ee1c10a0086.1697018818.git.geert+renesas@glider.be>
 <202310121404.FMC1T6FF-lkp@intel.com>
In-Reply-To: <202310121404.FMC1T6FF-lkp@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 Oct 2023 12:11:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWszZnozVi7cj7SH4R0Cv1SD7KrLOwze2xwKULtOGzQCA@mail.gmail.com>
Message-ID: <CAMuHMdWszZnozVi7cj7SH4R0Cv1SD7KrLOwze2xwKULtOGzQCA@mail.gmail.com>
Subject: Re: [PATCH] sunrpc: Use no_printk() in dfprintk*() dummies
To:     kernel test robot <lkp@intel.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Oct 12, 2023 at 9:09 AM kernel test robot <lkp@intel.com> wrote:
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on trondmy-nfs/linux-next]
> [also build test ERROR on linus/master v6.6-rc5 next-20231011]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Geert-Uytterhoeven/sunrpc-Use-no_printk-in-dfprintk-dummies/20231011-181013
> base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
> patch link:    https://lore.kernel.org/r/707e5e6dd0db9a663cf443564d1f8ee1c10a0086.1697018818.git.geert%2Brenesas%40glider.be
> patch subject: [PATCH] sunrpc: Use no_printk() in dfprintk*() dummies
> config: alpha-defconfig (https://download.01.org/0day-ci/archive/20231012/202310121404.FMC1T6FF-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231012/202310121404.FMC1T6FF-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310121404.FMC1T6FF-lkp@intel.com/
>
> All error/warnings (new ones prefixed by >>):
>
>    In file included from include/asm-generic/bug.h:22,
>                     from arch/alpha/include/asm/bug.h:23,
>                     from include/linux/bug.h:5,
>                     from include/linux/thread_info.h:13,
>                     from include/asm-generic/preempt.h:5,
>                     from ./arch/alpha/include/generated/asm/preempt.h:1,
>                     from include/linux/preempt.h:79,
>                     from include/linux/spinlock.h:56,
>                     from include/linux/mmzone.h:8,
>                     from include/linux/gfp.h:7,
>                     from include/linux/slab.h:16,
>                     from fs/lockd/svclock.c:25:
>    fs/lockd/svclock.c: In function 'nlmsvc_lookup_block':
> >> fs/lockd/svclock.c:164:33: error: implicit declaration of function 'nlmdbg_cookie2a' [-Werror=implicit-function-declaration]
>      164 |                                 nlmdbg_cookie2a(&block->b_call->a_args.cookie));
>          |                                 ^~~~~~~~~~~~~~~
>    include/linux/printk.h:427:33: note: in definition of macro 'printk_index_wrap'
>      427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
>          |                                 ^~~~~~~~~~~
>    include/linux/printk.h:129:17: note: in expansion of macro 'printk'
>      129 |                 printk(fmt, ##__VA_ARGS__);             \
>          |                 ^~~~~~
>    include/linux/sunrpc/debug.h:70:41: note: in expansion of macro 'no_printk'
>       70 | # define dfprintk(fac, fmt, ...)        no_printk(fmt, ##__VA_ARGS__)
>          |                                         ^~~~~~~~~
>    include/linux/sunrpc/debug.h:25:9: note: in expansion of macro 'dfprintk'
>       25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>          |         ^~~~~~~~
>    fs/lockd/svclock.c:160:17: note: in expansion of macro 'dprintk'
>      160 |                 dprintk("lockd: check f=%p pd=%d %Ld-%Ld ty=%d cookie=%s\n",
>          |                 ^~~~~~~
> >> fs/lockd/svclock.c:160:25: warning: format '%s' expects argument of type 'char *', but argument 7 has type 'int' [-Wformat=]

Thanks already fixed in v2.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
