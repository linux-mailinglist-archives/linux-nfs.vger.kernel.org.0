Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D372572012
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Jul 2022 17:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiGLP6M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Jul 2022 11:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiGLP6J (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Jul 2022 11:58:09 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1984C3AE7
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 08:58:08 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x91so10694185ede.1
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 08:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YkiA3aMrkX8JXodLt+NDKrOF5POPA5zEcUGu18mWm+0=;
        b=a92/QgN0KmAyPf6BZUa8Zz9y3/rdDqkJgM3yPugTuB/VO9GyCnxE1I/Snn6Utig6ZP
         +x+dce8eQpKfVz1wOySsDx82K+fHPRc+RXiqbqscrex9x2Gh7bt0o1iu4JmlKwM9lY5Y
         VNigXKWVlhERUYVxRplpwB7T4Mfd7UPSQrlYIdK3zSQgZiuICZbGPOSXAPjZnJPCSpZ2
         7wHTsCMdsMMaC2M1EUKTBBcxiEq9ubzpWTdPsZIro0cnEqkRXv2Zp5MBxr9OKH3j3PmE
         5Loa41nn4GzJOJkTU9QI25yXm43SscmN25bcS3mOSSGCWQV6DLWyEuZryhSx57XmMDZd
         kG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YkiA3aMrkX8JXodLt+NDKrOF5POPA5zEcUGu18mWm+0=;
        b=J/kIJdF5VPLuXoy96vqLN+Q7yGIdiis4CTlFlz1MAyIZjju+4VkheC5JWaDBbv682a
         VMoU/XUvAcvzu8WmrR3mbtIfnF424m9Qv31p3/wp1epLYb0bmyRp4bPexXzRbYCD/I2f
         8aP4AINkvgG/TfEMOaPkCOQJWmgvWjSaMTy+MIBM066V42RKt4/bQkyEUiZbTdVvtUmU
         tFeRMQuAq5F+y3hH/E+EhxPdqIaolQ3WP1B77dtPfwU9lyRYS2xHmRTCfnkj7+y5UhcH
         cEjnLaHls8lPKlwBDhOfIvjtLWWX0pkx02hENOKQ0C60/7ugCVMTR1Vd5wKlUYQ/3NfY
         esKw==
X-Gm-Message-State: AJIora8ZO41/igadLCu8O80BLjlfHVyT+577D27gbpuF/B/Yzo86JhRE
        +bVBh2QfeUKha48UMUOHYYq3fYCOPRR9w4xbo1U=
X-Google-Smtp-Source: AGRyM1uHuyBJCU16ivQGXNY3ycaHb1rgDbP3ji4cmKpSISZgfwz4OV0RM1zjI4ZKySPo3t3p3Z0tcVfki8t0wAgNsAk=
X-Received: by 2002:a05:6402:13:b0:439:ffe8:bec9 with SMTP id
 d19-20020a056402001300b00439ffe8bec9mr33408312edu.297.1657641487250; Tue, 12
 Jul 2022 08:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220620152407.63127-1-olga.kornievskaia@gmail.com>
 <20220620152407.63127-2-olga.kornievskaia@gmail.com> <a12b83a56c6a46cd31b75b471967f68080ce0a5a.camel@hammerspace.com>
In-Reply-To: <a12b83a56c6a46cd31b75b471967f68080ce0a5a.camel@hammerspace.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 12 Jul 2022 11:57:56 -0400
Message-ID: <CAN-5tyEYzeiNru6hZk6P1GFNCdhDCF3u--Sv5ChmyP56f8p4ag@mail.gmail.com>
Subject: Re: [PATCH v1 01/12] SUNRPC expose functions for offline remote xprt functionality
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
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

On Tue, Jul 12, 2022 at 11:12 AM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
> On Mon, 2022-06-20 at 11:23 -0400, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Re-arrange the code that make offline transport and delete transport
> > callable functions.
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  include/linux/sunrpc/xprt.h |  3 +++
> >  net/sunrpc/sysfs.c          | 28 +++++-----------------------
> >  net/sunrpc/xprt.c           | 35 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 43 insertions(+), 23 deletions(-)
> >
> > diff --git a/include/linux/sunrpc/xprt.h
> > b/include/linux/sunrpc/xprt.h
> > index 522bbf937957..0d51b9f9ea37 100644
> > --- a/include/linux/sunrpc/xprt.h
> > +++ b/include/linux/sunrpc/xprt.h
> > @@ -505,4 +505,7 @@ static inline int
> > xprt_test_and_set_binding(struct rpc_xprt *xprt)
> >         return test_and_set_bit(XPRT_BINDING, &xprt->state);
> >  }
> >
> > +void xprt_set_offline_locked(struct rpc_xprt *xprt, struct
> > rpc_xprt_switch *xps);
> > +void xprt_set_online_locked(struct rpc_xprt *xprt, struct
> > rpc_xprt_switch *xps);
> > +void xprt_delete_locked(struct rpc_xprt *xprt, struct
> > rpc_xprt_switch *xps);
> >  #endif /* _LINUX_SUNRPC_XPRT_H */
> > diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
> > index a3a2f8aeb80e..7330eb9a70cf 100644
> > --- a/net/sunrpc/sysfs.c
> > +++ b/net/sunrpc/sysfs.c
> > @@ -314,32 +314,14 @@ static ssize_t
> > rpc_sysfs_xprt_state_change(struct kobject *kobj,
> >                 goto release_tasks;
> >         }
> >         if (offline) {
> > -               if (!test_and_set_bit(XPRT_OFFLINE, &xprt->state)) {
> > -                       spin_lock(&xps->xps_lock);
> > -                       xps->xps_nactive--;
> > -                       spin_unlock(&xps->xps_lock);
> > -               }
> > +               xprt_set_offline_locked(xprt, xps);
> >         } else if (online) {
> > -               if (test_and_clear_bit(XPRT_OFFLINE, &xprt->state)) {
> > -                       spin_lock(&xps->xps_lock);
> > -                       xps->xps_nactive++;
> > -                       spin_unlock(&xps->xps_lock);
> > -               }
> > +               xprt_set_online_locked(xprt, xps);
> >         } else if (remove) {
> > -               if (test_bit(XPRT_OFFLINE, &xprt->state)) {
> > -                       if (!test_and_set_bit(XPRT_REMOVE, &xprt-
> > >state)) {
> > -                               xprt_force_disconnect(xprt);
> > -                               if (test_bit(XPRT_CONNECTED, &xprt-
> > >state)) {
> > -                                       if (!xprt->sending.qlen &&
> > -                                           !xprt->pending.qlen &&
> > -                                           !xprt->backlog.qlen &&
> > -                                           !atomic_long_read(&xprt-
> > >queuelen))
> > -
> >                                                rpc_xprt_switch_remove_
> > xprt(xps, xprt);
> > -                               }
> > -                       }
> > -               } else {
> > +               if (test_bit(XPRT_OFFLINE, &xprt->state))
> > +                       xprt_delete_locked(xprt, xps);
> > +               else
> >                         count = -EINVAL;
> > -               }
> >         }
> >
> >  release_tasks:
> > diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
> > index 86d62cffba0d..6480ae324b27 100644
> > --- a/net/sunrpc/xprt.c
> > +++ b/net/sunrpc/xprt.c
> > @@ -2152,3 +2152,38 @@ void xprt_put(struct rpc_xprt *xprt)
> >                 kref_put(&xprt->kref, xprt_destroy_kref);
> >  }
> >  EXPORT_SYMBOL_GPL(xprt_put);
> > +
> > +void xprt_set_offline_locked(struct rpc_xprt *xprt, struct
> > rpc_xprt_switch *xps)
> > +{
> > +       if (!test_and_set_bit(XPRT_OFFLINE, &xprt->state)) {
> > +               spin_lock(&xps->xps_lock);
> > +               xps->xps_nactive--;
> > +               spin_unlock(&xps->xps_lock);
> > +       }
> > +}
> > +EXPORT_SYMBOL(xprt_set_offline_locked);
> > +
> > +void xprt_set_online_locked(struct rpc_xprt *xprt, struct
> > rpc_xprt_switch *xps)
> > +{
> > +       if (test_and_clear_bit(XPRT_OFFLINE, &xprt->state)) {
> > +               spin_lock(&xps->xps_lock);
> > +               xps->xps_nactive++;
> > +               spin_unlock(&xps->xps_lock);
> > +       }
> > +}
> > +EXPORT_SYMBOL(xprt_set_online_locked);
> > +
> > +void xprt_delete_locked(struct rpc_xprt *xprt, struct
> > rpc_xprt_switch *xps)
> > +{
> > +       if (test_and_set_bit(XPRT_REMOVE, &xprt->state))
> > +               return;
> > +
> > +       xprt_force_disconnect(xprt);
> > +       if (!test_bit(XPRT_CONNECTED, &xprt->state))
> > +               return;
> > +
> > +       if (!xprt->sending.qlen && !xprt->pending.qlen &&
> > +           !xprt->backlog.qlen && !atomic_long_read(&xprt-
> > >queuelen))
> > +               rpc_xprt_switch_remove_xprt(xps, xprt);
> > +}
> > +EXPORT_SYMBOL(xprt_delete_locked);
>
> Why are these functions being exported? There is nothing outside the
> main sunrpc layer that should be using them.
>

Thank you for the comment. Make sense, will fix. It probably came from
looking at xprt_put above that code.

> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
