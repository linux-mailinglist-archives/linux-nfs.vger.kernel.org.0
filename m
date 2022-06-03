Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E3653CAE8
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jun 2022 15:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244810AbiFCNvP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jun 2022 09:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiFCNvN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Jun 2022 09:51:13 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0F311A33;
        Fri,  3 Jun 2022 06:51:12 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h19so10281998edj.0;
        Fri, 03 Jun 2022 06:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aMqXqUGRfNMZQv1fI4AkbZKumYHl+MkAFWRa5Y54Goo=;
        b=f4SQWq7ubiPNLt62nB1w+QbKnddSR2UqNKrIElxz2SjAA83iXNHL+9t1MNo9eHY4IK
         wWm9AS2N2WtIf6yoXu8a4boVF1xebN16pUDiH2hbnIkIgWm4ajLhRwzjkPb71QI91Mon
         WYbqizc0uCJHV0b1lqEjGqcM0knG7Y1w+csy2rmiYiBs303QJ+r/hrViGfj4f9suWe6V
         MDmsb2LH/MkArcI29w8a05ncdgB3tlLLVciXwqCd7RtPIAlij1CGa7XvpQ+w432uNsDb
         KjWnsUct2pZEw7PUu+XOwn7GJBoi27ep32TufKW9ccrMhP4+GjOgLQ9PmQaLkQPuRMPs
         OPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aMqXqUGRfNMZQv1fI4AkbZKumYHl+MkAFWRa5Y54Goo=;
        b=m3O3neIuQ5Nib61aR9lZ8IjiWhn0jyRjy2VKHvctt8C6TURk34ZnWFzN4u3G1mrfU2
         GZIwSG9Lfa8Rkn39MjNbHvrqpzpd63juq37UXsRv2uF8dV+gVbWkmVW3iOrMj8QmTlX6
         7i0YSHqbHEH1W03ZDfVL/RfhVmIm88maPLPfU+cJSwj+eaIbJY3oDZnauoFghadVXU1w
         /mVeL70cVsS+YK6dRV1Yf/7u4Oe7mvoCrZLwym0qcqGAc4hhqRbsmVJE8MvlG2xQ21VI
         572YopsHmA4sTj6ALxx1CPyA5EYK++jiAx++NoUaYb6gg90y5tOBGF1FxxO+FKBZoW/G
         x4kQ==
X-Gm-Message-State: AOAM533OeDdzfHWZlbV3vlVNNV8hNZbA7aWziqFCEe30ap3RkTuX2C7h
        6vHPRpPcEwiP2dYgI/PfWNLIyfKp9U10ut4rrXggdo2MATE6MhRw
X-Google-Smtp-Source: ABdhPJzFX+uYM3v6+egRyESVeyRs+3DV1e5516MyxPYkV9a4MUQH/u1cf+emgdugvUANC13J/0T/9pVga1hloqRRa/M=
X-Received: by 2002:a05:6402:42c1:b0:42d:fba6:d5c5 with SMTP id
 i1-20020a05640242c100b0042dfba6d5c5mr11043283edc.295.1654264270581; Fri, 03
 Jun 2022 06:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220602055633.849545-1-dzm91@hust.edu.cn> <53417E03-4D3C-44DC-AA8A-5F9FE340483A@oracle.com>
In-Reply-To: <53417E03-4D3C-44DC-AA8A-5F9FE340483A@oracle.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Fri, 3 Jun 2022 21:50:44 +0800
Message-ID: <CAD-N9QUAvTZMFz6A+=NxvyHaO102mrc7+5gL4K9xV5j3AEuvjQ@mail.gmail.com>
Subject: Re: [PATCH] nfsd: make destory function more elegant
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Thu, Jun 2, 2022 at 10:30 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jun 2, 2022, at 1:56 AM, Dongliang Mu <dzm91@hust.edu.cn> wrote:
> >
> > From: Dongliang Mu <mudongliangabcd@gmail.com>
> >
> > In init_nfsd, the undo operation of create_proc_exports_entry is:
> >
> >        remove_proc_entry("fs/nfs/exports", NULL);
> >        remove_proc_entry("fs/nfs", NULL);
> >
> > This may lead to maintaince issue. Declare the undo function
>
> "maintenance"

Sorry for the typo.

>
>
> > destroy_proc_exports_entry based on CONFIG_PROC_FS
>
> IIUC, the issue is that if CONFIG_PROC_FS is not set,
> fs/nfsd/nfsctl.c fails to compile?

The answer is no. There is no bug in the code.

At first, I thought this might cause the miscompilation or bug. But
actually the code is fine.

Because remove_proc_entry is defined as an empty function if
CONFIG_PROC_FS is not set,

>
>
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> > fs/nfsd/nfsctl.c | 16 ++++++++++++----
> > 1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 0621c2faf242..83b34ccbef5a 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -1450,11 +1450,21 @@ static int create_proc_exports_entry(void)
> >       }
> >       return 0;
> > }
> > +
> > +static void destroy_proc_exports_entry(void)
> > +{
> > +     remove_proc_entry("fs/nfs/exports", NULL);
> > +     remove_proc_entry("fs/nfs", NULL);
> > +}
> > #else /* CONFIG_PROC_FS */
> > static int create_proc_exports_entry(void)
> > {
> >       return 0;
> > }
> > +
> > +static void destroy_proc_exports_entry(void)
> > +{
> > +}
> > #endif
> >
> > unsigned int nfsd_net_id;
> > @@ -1555,8 +1565,7 @@ static int __init init_nfsd(void)
> > out_free_subsys:
> >       unregister_pernet_subsys(&nfsd_net_ops);
> > out_free_exports:
> > -     remove_proc_entry("fs/nfs/exports", NULL);
> > -     remove_proc_entry("fs/nfs", NULL);
> > +     destroy_proc_exports_entry();
> > out_free_lockd:
> >       nfsd_lockd_shutdown();
> >       nfsd_drc_slab_free();
> > @@ -1576,8 +1585,7 @@ static void __exit exit_nfsd(void)
> >       unregister_cld_notifier();
> >       unregister_pernet_subsys(&nfsd_net_ops);
> >       nfsd_drc_slab_free();
> > -     remove_proc_entry("fs/nfs/exports", NULL);
> > -     remove_proc_entry("fs/nfs", NULL);
> > +     destroy_proc_exports_entry();
> >       nfsd_stat_shutdown();
> >       nfsd_lockd_shutdown();
> >       nfsd4_free_slabs();
> > --
> > 2.25.1
> >
>
> --
> Chuck Lever
>
>
>
