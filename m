Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21A86CB804
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Mar 2023 09:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjC1H2P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 28 Mar 2023 03:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjC1H2O (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Mar 2023 03:28:14 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A54B4
        for <linux-nfs@vger.kernel.org>; Tue, 28 Mar 2023 00:28:13 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id k17so13842144ybm.11
        for <linux-nfs@vger.kernel.org>; Tue, 28 Mar 2023 00:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679988492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rj/sfSGdtfFOZsxOOFXw9/0qOpT62n40nmmm7LLmxs=;
        b=zieMEbte5HCgjbLewLLJutYR2rw4E+4IzwKqelfHg2KohCqrMELJtVlMirJvZLvXBS
         mB323yNjFMa6p+twxMk1Kkzs4jASYJypzGw+3DuW3fDIykqqEQ5vYACNlpzq85JB5S9g
         63EK9OLo6oTJ1nQK09IpG+Zjcpz8mjAYW+/gRqrjU/HYgwUI7P78kIg+iF3EUqxXq2Of
         fcwmNJkAAC7N5osUGVlwaQyNrLXGZwppisLNWmKXsmX0PWQEpS1fz3rrRNiOxk5zHy7Y
         qlZxp5JjpKPgN35aHtXM/4ML5pK5AgoVGBveprI5K/kes2DFI7TK4Jbs8j14vPIKKTfE
         +t3g==
X-Gm-Message-State: AAQBX9ey1yAZ59O4bSdt6bULToygpaA69sf+xanqes8b+Cnw/aJQL/QV
        8v74qKSi4P0ynNQHiNiia1zj5qp9yBlwVA==
X-Google-Smtp-Source: AKy350Ys825XOOSnd+haEaabAYCZW/J9Q4fPxBQcYUxJa4ztVJB4W+H0CuR2WHnnmlMGXjrJlYVs7w==
X-Received: by 2002:a25:c012:0:b0:8f9:de35:80ea with SMTP id c18-20020a25c012000000b008f9de3580eamr13887083ybf.31.1679988492564;
        Tue, 28 Mar 2023 00:28:12 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id q206-20020a25d9d7000000b00b7767ca746esm2764991ybg.11.2023.03.28.00.28.12
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 00:28:12 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5445009c26bso213988927b3.8
        for <linux-nfs@vger.kernel.org>; Tue, 28 Mar 2023 00:28:12 -0700 (PDT)
X-Received: by 2002:a81:a7c4:0:b0:546:264:a375 with SMTP id
 e187-20020a81a7c4000000b005460264a375mr1618724ywh.4.1679988491879; Tue, 28
 Mar 2023 00:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <167828670993.16253.6476667874038066881.stgit@bazille.1015granger.net>
 <ZCG6tIoz0VN6d+oy@sleipner.dyn.berto.se> <2CC1BD86-2611-4052-B08D-DF255763A098@oracle.com>
In-Reply-To: <2CC1BD86-2611-4052-B08D-DF255763A098@oracle.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Mar 2023 09:28:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVcLYOEd4rbtzwjXXMXxw84+Mmge3=U10cKrWp66od42A@mail.gmail.com>
Message-ID: <CAMuHMdVcLYOEd4rbtzwjXXMXxw84+Mmge3=U10cKrWp66od42A@mail.gmail.com>
Subject: Re: [PATCH RFC] NFS & NFSD: Update GSS dependencies
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

On Mon, Mar 27, 2023 at 6:28 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
> > On Mar 27, 2023, at 11:48 AM, Niklas Söderlund <niklas.soderlund@ragnatech.se> wrote:
> > This commits seems to have been picked up already, but FWIW it produces
> > two new warnings with shmobile_defconfig.
> >
> > WARNING: unmet direct dependencies detected for RPCSEC_GSS_KRB5
> >  Depends on [n]: NETWORK_FILESYSTEMS [=y] && SUNRPC [=y] && CRYPTO [=n]
> >  Selected by [y]:
> >  - NFS_V4 [=y] && NETWORK_FILESYSTEMS [=y] && NFS_FS [=y]
> >
> > WARNING: unmet direct dependencies detected for RPCSEC_GSS_KRB5
> >  Depends on [n]: NETWORK_FILESYSTEMS [=y] && SUNRPC [=y] && CRYPTO [=n]
> >  Selected by [y]:
> >  - NFS_V4 [=y] && NETWORK_FILESYSTEMS [=y] && NFS_FS [=y]
>
> I received a bot warning about this a few days ago, but it did not
> appear that it was a priority.
>
> The easiest thing to do would be to revert it, but I'm not clear
> on what the impact of this new issue is.
>
> > On 2023-03-08 09:45:09 -0500, Chuck Lever wrote:
> >> --- a/fs/nfs/Kconfig
> >> +++ b/fs/nfs/Kconfig
> >> @@ -75,7 +75,7 @@ config NFS_V3_ACL
> >> config NFS_V4
> >>      tristate "NFS client support for NFS version 4"
> >>      depends on NFS_FS
> >> -    select SUNRPC_GSS
> >> +    select RPCSEC_GSS_KRB5

RPCSEC_GSS_KRB5 depends on CRYPTO, causing the warning.
However, NFSv4 nfsroot works fine without CRYPTO, so the select can
be conditional.  I have sent a patch to do that:
https://lore.kernel.org/r/42751e1fef65485a5441618bc39735f8b62b3a46.1679988298.git.geert+renesas@glider.be

> >>      select KEYS
> >>      help
> >>        This option enables support for version 4 of the NFS protocol
> >> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> >> index 7c441f2bd444..43b88eaf0673 100644
> >> --- a/fs/nfsd/Kconfig
> >> +++ b/fs/nfsd/Kconfig
> >> @@ -73,7 +73,7 @@ config NFSD_V4
> >>      bool "NFS server support for NFS version 4"
> >>      depends on NFSD && PROC_FS
> >>      select FS_POSIX_ACL
> >> -    select SUNRPC_GSS
> >> +    select RPCSEC_GSS_KRB5
> >>      select CRYPTO

NFSD_V4 selects CRYPTO, so there is no such issue here.

> >>      select CRYPTO_MD5
> >>      select CRYPTO_SHA256

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
