Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1633433E892
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Mar 2021 05:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCQEvl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Mar 2021 00:51:41 -0400
Received: from condef-10.nifty.com ([202.248.20.75]:20545 "EHLO
        condef-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhCQEvf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Mar 2021 00:51:35 -0400
X-Greylist: delayed 319 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Mar 2021 00:51:35 EDT
Received: from conssluserg-03.nifty.com ([10.126.8.82])by condef-10.nifty.com with ESMTP id 12H4i9Iv016020
        for <linux-nfs@vger.kernel.org>; Wed, 17 Mar 2021 13:44:09 +0900
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 12H4hhMh018472;
        Wed, 17 Mar 2021 13:43:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 12H4hhMh018472
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1615956224;
        bh=Gfyz85RTqTFXns0z8x3WiH97tujx4/ltbOEQlYyxU58=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CZ+teX+Y0QU1wdtR8uEt/lu54OQF5ttU4T8PA+eJpQ1+ULaDv73PRTFrdemr1lzdy
         ucC91akrGCLZdj2Rhs0Y9lKQAKxn4iHI1UgeYmE38Tq01TXyxYlzxhaKL0sJtZSrO+
         12QhYcdZZU1EeOMgC8A3bi0FL2RxkBEaKnOgI+FaVLZfiAm94YJSk8CUOrm2NrEcIN
         DifvHOBU1PdR+Pp/Lw/uBfXbQNvpTBvmj8hH5C59jC/JWJL7ssUzJfU3cLPq/GNFci
         L9V3vyTHonk0SOvax4EYk78iv6uC7YCgH/fXO0BMA51w29JYBXQakBHbTGIJEryjbg
         +2pshxfbFE3Gw==
X-Nifty-SrcIP: [209.85.216.53]
Received: by mail-pj1-f53.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so2542761pjh.1;
        Tue, 16 Mar 2021 21:43:44 -0700 (PDT)
X-Gm-Message-State: AOAM533//6BOP8wI/AZeTq7cK0JLKWTJQk/pVHbb4H1GiBqoy5dfityY
        RubwaLq3LU5bosKqYo6yDbPb+EMlEj4IngJ25Z4=
X-Google-Smtp-Source: ABdhPJwJ71Q2VUrFGijNY8p0zmnxBOAs/6nlC6HRhz3ebSM0QZipQxYpnH3jV8LwrYBWxjfpDVvvwUu9s4fjWmy6PP4=
X-Received: by 2002:a17:90a:fb54:: with SMTP id iq20mr2384489pjb.153.1615956218322;
 Tue, 16 Mar 2021 21:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210223141901.1652-1-timo@rothenpieler.org> <20210316222514.erlng3lsgmqgpcv4@archlinux-ax161>
In-Reply-To: <20210316222514.erlng3lsgmqgpcv4@archlinux-ax161>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 17 Mar 2021 13:43:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNATFwpzmLJc0YFRBG-kUhgatWvG1SWp-kgLyzjix=8J3pQ@mail.gmail.com>
Message-ID: <CAK7LNATFwpzmLJc0YFRBG-kUhgatWvG1SWp-kgLyzjix=8J3pQ@mail.gmail.com>
Subject: Re: [PATCH] nfs: fix PNFS_FLEXFILE_LAYOUT Kconfig default
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Timo Rothenpieler <timo@rothenpieler.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Mar 17, 2021 at 7:25 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Tue, Feb 23, 2021 at 03:19:01PM +0100, Timo Rothenpieler wrote:
> > This follows what was done in 8c2fabc6542d9d0f8b16bd1045c2eda59bdcde13.
> > With the default being m, it's impossible to build the module into the
> > kernel.
> >
> > Signed-off-by: Timo Rothenpieler <timo@rothenpieler.org>
> > ---
> >  fs/nfs/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
> > index e2a488d403a6..14a72224b657 100644
> > --- a/fs/nfs/Kconfig
> > +++ b/fs/nfs/Kconfig
> > @@ -127,7 +127,7 @@ config PNFS_BLOCK
> >  config PNFS_FLEXFILE_LAYOUT
> >       tristate
> >       depends on NFS_V4_1 && NFS_V3
> > -     default m
> > +     default NFS_V4
> >
> >  config NFS_V4_1_IMPLEMENTATION_ID_DOMAIN
> >       string "NFSv4.1 Implementation ID Domain"
> > --
> > 2.25.1
> >
>
> Hi all,
>
> I bisected a new modpost warning that I see with 5.12-rc3 to this commit:
>
> $ make -skj"$(nproc)" ARCH=mips CROSS_COMPILE=mipsel-linux- O=build/mipsel distclean defconfig all
> ...
> WARNING: modpost: Symbol info of vmlinux is missing. Unresolved symbol check will be entirely skipped.
> ...

Thanks for the report.

MIPS defconfig enables CONFIG_TRIM_UNUSED_KSYMS.

Presumably with a0590473c5e6c4ef17,
MIPS defconfig enables CONFIG_MODULES,
but actually builds no module.

So, all symbols in vmlinux have been trimmed,
and vmlinux.symvers gets empty.

That is the reason for the warning.

I will consider how to fix this corner case.










>
> $ git bisect log
> # bad: [1e28eed17697bcf343c6743f0028cc3b5dd88bf0] Linux 5.12-rc3
> # good: [a38fd8748464831584a19438cbb3082b5a2dab15] Linux 5.12-rc2
> git bisect start 'v5.12-rc3' 'v5.12-rc2'
> # good: [f78d76e72a4671ea52d12752d92077788b4f5d50] Merge tag 'drm-fixes-2021-03-12-1' of git://anongit.freedesktop.org/drm/drm
> git bisect good f78d76e72a4671ea52d12752d92077788b4f5d50
> # bad: [420623430a7015ae9adab8a087de82c186bc9989] Merge tag 'erofs-for-5.12-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs
> git bisect bad 420623430a7015ae9adab8a087de82c186bc9989
> # good: [261410082d01f2f2d4fcd19abee6b8e84f399c51] Merge tag 'devprop-5.12-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> git bisect good 261410082d01f2f2d4fcd19abee6b8e84f399c51
> # good: [ce307084c96d0ec92c04fcc38b107241b168df11] Merge tag 'block-5.12-2021-03-12-v2' of git://git.kernel.dk/linux-block
> git bisect good ce307084c96d0ec92c04fcc38b107241b168df11
> # bad: [f296bfd5cd04cbb49b8fc9585adc280ab2b58624] Merge tag 'nfs-for-5.12-2' of git://git.linux-nfs.org/projects/anna/linux-nfs
> git bisect bad f296bfd5cd04cbb49b8fc9585adc280ab2b58624
> # good: [9afc1163794707a304f107bf21b8b37e5c6c34f4] Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> git bisect good 9afc1163794707a304f107bf21b8b37e5c6c34f4
> # bad: [fd6d3feed041e96b84680d0bfc1e7abc8f65de92] NFS: Clean up function nfs_mark_dir_for_revalidate()
> git bisect bad fd6d3feed041e96b84680d0bfc1e7abc8f65de92
> # bad: [f0940f4b3284a00f38a5d42e6067c2aaa20e1f2e] SUNRPC: Set memalloc_nofs_save() for sync tasks
> git bisect bad f0940f4b3284a00f38a5d42e6067c2aaa20e1f2e
> # bad: [ad3dbe35c833c2d4d0bbf3f04c785d32f931e7c9] NFS: Correct size calculation for create reply length
> git bisect bad ad3dbe35c833c2d4d0bbf3f04c785d32f931e7c9
> # bad: [a0590473c5e6c4ef17c3132ad08fbad170f72d55] nfs: fix PNFS_FLEXFILE_LAYOUT Kconfig default
> git bisect bad a0590473c5e6c4ef17c3132ad08fbad170f72d55
> # first bad commit: [a0590473c5e6c4ef17c3132ad08fbad170f72d55] nfs: fix PNFS_FLEXFILE_LAYOUT Kconfig default
>
> $ mipsel-linux-gcc --version
> mipsel-linux-gcc (GCC) 10.2.0
> Copyright (C) 2020 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>
> I doubt this is a bug with this specific commit but I am not sure so I
> have added Masahiro and the kbuild list as well as the MIPS list even
> though it might not be MIPS specific (although I only see it with the
> 32-bit MIPS configs)
>
> Cheers,
> Nathan



--
Best Regards
Masahiro Yamada
