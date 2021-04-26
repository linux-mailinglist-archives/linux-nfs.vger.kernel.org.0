Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223ED36B5CE
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Apr 2021 17:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbhDZPbF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Apr 2021 11:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbhDZPbF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Apr 2021 11:31:05 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30966C061574
        for <linux-nfs@vger.kernel.org>; Mon, 26 Apr 2021 08:30:22 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u17so85162196ejk.2
        for <linux-nfs@vger.kernel.org>; Mon, 26 Apr 2021 08:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bc4ujTVHaKGa67BitlOi8Y27H9vU7fanMAyDoatMpHI=;
        b=e5x0fXKkDLLakVJuaVPtrPbnDtNLrny0It0WU9sgQmkFVYJ8Zc7jgeETvXSE8Am3z7
         H+eq7mJ430y3I1xTrFqIeGI65GhY7PdkIQRm3rSci7TrLFS0MoaUtCAtntSsV0brNlxC
         E/AgpxSXSgWkp8HJi/f8u7SDosTNtvFR0gGfICUVjdeXgsNPrgwcqnaFS2KEY3KYGgpF
         lkSJBFogqB2ImsbbIwuElOfbrhjm1v75z76HYUfGe9qJf3XntlIsb/KRGVPhrM/z6Wgm
         aOU9vGVThCuIvkkTCBwqmoMWH77PR8mKgbiXymUf8zSzLkXT4gfRCXIz8Viyr9seOgcZ
         SJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bc4ujTVHaKGa67BitlOi8Y27H9vU7fanMAyDoatMpHI=;
        b=Gib2/L8jwtcfAa/huc6YQTWWSlyxkDru233qv/BSMJo6Buo4Fj6XpzhbHkqfSzmfhX
         nKRxgraToW7L0+et8uhdKOjcfdHDNbnbMqg4NLlN5dOe5chU3g2C8863W4Wjd6i4huGG
         7Eyyg3oSKzLwSzxLBqT/+Yw+ed+z0r2DXDuG9khBddQhFCAzkyvdf/+BHgSe2H0MgSq2
         eg9WHsqK65TBoNZwqa+eEWvjTTKmMaQEnz585YpYYIRBP/Cm7RUk/VLj2V4WkyJduNql
         HOU2qP9wYiHTWjsqal6ubuzoEg0uYvwUUg1TMTSCY/jXx8fUrToGixLi93rWpizsTRMP
         q6kA==
X-Gm-Message-State: AOAM532it8tOBfySxatycPpSqD7B529EMWpIjW/eQc3ofHgMKMza30Wk
        yObiYZqwkYwr7cy4ZOxaknpwVpIOlpcOPZ9HDrA=
X-Google-Smtp-Source: ABdhPJzncIWeIyblgvusEU/T7sCfM3xPsFKu/m5te+wUaMP4UsqJhv8W+Hbrw/hw/kLQfvFn6nLkJ+t9WdP2VzUp/Xw=
X-Received: by 2002:a17:906:d102:: with SMTP id b2mr19593352ejz.451.1619451020820;
 Mon, 26 Apr 2021 08:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210416035226.53588-1-olga.kornievskaia@gmail.com>
 <20210416035226.53588-9-olga.kornievskaia@gmail.com> <dfdff01710b336df8570e26c6ab3055169b1c103.camel@hammerspace.com>
In-Reply-To: <dfdff01710b336df8570e26c6ab3055169b1c103.camel@hammerspace.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Mon, 26 Apr 2021 11:30:09 -0400
Message-ID: <CAN-5tyGh=OV3Kc7D0B+A9+BkX+JUi4v2tx+ZB1+v06A=DZj0Rg@mail.gmail.com>
Subject: Re: [PATCH v2 08/13] sunrpc: add xprt_switch direcotry to sunrpc's sysfs
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Apr 23, 2021 at 5:20 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Thu, 2021-04-15 at 23:52 -0400, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Add xprt_switch directory to the sysfs and create individual
> > xprt_swith subdirectories for multipath transport group.
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  include/linux/sunrpc/xprtmultipath.h |  1 +
> >  net/sunrpc/sysfs.c                   | 97
> > ++++++++++++++++++++++++++--
> >  net/sunrpc/sysfs.h                   | 10 +++
> >  net/sunrpc/xprtmultipath.c           |  4 ++
> >  4 files changed, 105 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/sunrpc/xprtmultipath.h
> > b/include/linux/sunrpc/xprtmultipath.h
> > index ef95a6f18ccf..47b0a85cdcfa 100644
> > --- a/include/linux/sunrpc/xprtmultipath.h
> > +++ b/include/linux/sunrpc/xprtmultipath.h
> > @@ -24,6 +24,7 @@ struct rpc_xprt_switch {
> >
> >         const struct rpc_xprt_iter_ops *xps_iter_ops;
> >
> > +       void                    *xps_sysfs;
> >         struct rcu_head         xps_rcu;
> >  };
> >
> > diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
> > index d14d54f33c65..0c34330714ab 100644
> > --- a/net/sunrpc/sysfs.c
> > +++ b/net/sunrpc/sysfs.c
> > @@ -7,7 +7,7 @@
> >  #include "sysfs.h"
> >
> >  static struct kset *rpc_sunrpc_kset;
> > -static struct kobject *rpc_sunrpc_client_kobj;
> > +static struct kobject *rpc_sunrpc_client_kobj,
> > *rpc_sunrpc_xprt_switch_kobj;
> >
> >  static void rpc_sysfs_object_release(struct kobject *kobj)
> >  {
> > @@ -47,13 +47,22 @@ int rpc_sysfs_init(void)
> >         rpc_sunrpc_kset = kset_create_and_add("sunrpc", NULL,
> > kernel_kobj);
> >         if (!rpc_sunrpc_kset)
> >                 return -ENOMEM;
> > -       rpc_sunrpc_client_kobj = rpc_sysfs_object_alloc("client",
> > rpc_sunrpc_kset, NULL);
> > -       if (!rpc_sunrpc_client_kobj) {
> > -               kset_unregister(rpc_sunrpc_kset);
> > -               rpc_sunrpc_client_kobj = NULL;
> > -               return -ENOMEM;
> > -       }
> > +       rpc_sunrpc_client_kobj =
> > +               rpc_sysfs_object_alloc("rpc-clients",
> > rpc_sunrpc_kset, NULL);
> > +       if (!rpc_sunrpc_client_kobj)
> > +               goto err_client;
> > +       rpc_sunrpc_xprt_switch_kobj =
> > +               rpc_sysfs_object_alloc("xprt-switches",
> > rpc_sunrpc_kset, NULL);
> > +       if (!rpc_sunrpc_xprt_switch_kobj)
> > +               goto err_switch;
> >         return 0;
> > +err_switch:
> > +       kobject_put(rpc_sunrpc_client_kobj);
> > +       rpc_sunrpc_client_kobj = NULL;
> > +err_client:
> > +       kset_unregister(rpc_sunrpc_kset);
> > +       rpc_sunrpc_kset = NULL;
> > +       return -ENOMEM;
> >  }
> >
> >  static void rpc_sysfs_client_release(struct kobject *kobj)
> > @@ -64,20 +73,40 @@ static void rpc_sysfs_client_release(struct
> > kobject *kobj)
> >         kfree(c);
> >  }
> >
> > +static void rpc_sysfs_xprt_switch_release(struct kobject *kobj)
> > +{
> > +       struct rpc_sysfs_xprt_switch *xprt_switch;
> > +
> > +       xprt_switch = container_of(kobj, struct
> > rpc_sysfs_xprt_switch, kobject);
> > +       kfree(xprt_switch);
> > +}
> > +
> >  static const void *rpc_sysfs_client_namespace(struct kobject *kobj)
> >  {
> >         return container_of(kobj, struct rpc_sysfs_client, kobject)-
> > >net;
> >  }
> >
> > +static const void *rpc_sysfs_xprt_switch_namespace(struct kobject
> > *kobj)
> > +{
> > +       return container_of(kobj, struct rpc_sysfs_xprt_switch,
> > kobject)->net;
> > +}
> > +
> >  static struct kobj_type rpc_sysfs_client_type = {
> >         .release = rpc_sysfs_client_release,
> >         .sysfs_ops = &kobj_sysfs_ops,
> >         .namespace = rpc_sysfs_client_namespace,
> >  };
> >
> > +static struct kobj_type rpc_sysfs_xprt_switch_type = {
> > +       .release = rpc_sysfs_xprt_switch_release,
> > +       .sysfs_ops = &kobj_sysfs_ops,
> > +       .namespace = rpc_sysfs_xprt_switch_namespace,
> > +};
> > +
> >  void rpc_sysfs_exit(void)
> >  {
> >         kobject_put(rpc_sunrpc_client_kobj);
> > +       kobject_put(rpc_sunrpc_xprt_switch_kobj);
> >         kset_unregister(rpc_sunrpc_kset);
> >  }
> >
> > @@ -99,6 +128,27 @@ static struct rpc_sysfs_client
> > *rpc_sysfs_client_alloc(struct kobject *parent,
> >         return NULL;
> >  }
> >
> > +static struct rpc_sysfs_xprt_switch *
> > +rpc_sysfs_xprt_switch_alloc(struct kobject *parent,
> > +                           struct rpc_xprt_switch *xprt_switch,
> > +                           struct net *net)
> > +{
> > +       struct rpc_sysfs_xprt_switch *p;
> > +
> > +       p = kzalloc(sizeof(*p), GFP_KERNEL);
>
> Again, this needs to use the allocation mode of xprt_switch_alloc().
>
> > +       if (p) {
> > +               p->net = net;
> > +               p->kobject.kset = rpc_sunrpc_kset;
> > +               if (kobject_init_and_add(&p->kobject,
> > +                                        &rpc_sysfs_xprt_switch_type,
> > +                                        parent, "switch-%d",
> > +                                        xprt_switch->xps_id) == 0)
> > +                       return p;
> > +               kobject_put(&p->kobject);
> > +       }
> > +       return NULL;
> > +}
> > +
> >  void rpc_sysfs_client_setup(struct rpc_clnt *clnt, struct net *net)
> >  {
> >         struct rpc_sysfs_client *rpc_client;
> > @@ -110,6 +160,27 @@ void rpc_sysfs_client_setup(struct rpc_clnt
> > *clnt, struct net *net)
> >         }
> >  }
> >
> > +void rpc_sysfs_xprt_switch_setup(struct rpc_xprt_switch
> > *xprt_switch,
> > +                                struct rpc_xprt *xprt)
> > +{
> > +       struct rpc_sysfs_xprt_switch *rpc_xprt_switch;
> > +       struct net *net;
> > +
> > +       if (xprt_switch->xps_net)
> > +               net = xprt_switch->xps_net;
> > +       else
> > +               net = xprt->xprt_net;
> > +       rpc_xprt_switch =
> > +               rpc_sysfs_xprt_switch_alloc(rpc_sunrpc_xprt_switch_ko
> > bj,
> > +                                           xprt_switch, net);
> > +       if (rpc_xprt_switch) {
> > +               xprt_switch->xps_sysfs = rpc_xprt_switch;
> > +               rpc_xprt_switch->xprt_switch = xprt_switch;
> > +               rpc_xprt_switch->xprt = xprt;
> > +               kobject_uevent(&rpc_xprt_switch->kobject, KOBJ_ADD);
>
> This probably cannot be called from a locked environment.

rpc_sysfs_xprt_switch_setup() isn't called from a locked environment.
Going backwards:
rpc_sysfs_xprt_switch_setup() from xprt_switch_alloc() from
rpc_create_xprt()/rpc_switch_client_transport()  none of those are
called with a lock.

>
> > +       }
> > +}
> > +
> >  void rpc_sysfs_client_destroy(struct rpc_clnt *clnt)
> >  {
> >         struct rpc_sysfs_client *rpc_client = clnt->cl_sysfs;
> > @@ -121,3 +192,15 @@ void rpc_sysfs_client_destroy(struct rpc_clnt
> > *clnt)
> >                 clnt->cl_sysfs = NULL;
> >         }
> >  }
> > +
> > +void rpc_sysfs_xprt_switch_destroy(struct rpc_xprt_switch
> > *xprt_switch)
> > +{
> > +       struct rpc_sysfs_xprt_switch *rpc_xprt_switch = xprt_switch-
> > >xps_sysfs;
> > +
> > +       if (rpc_xprt_switch) {
> > +               kobject_uevent(&rpc_xprt_switch->kobject,
> > KOBJ_REMOVE);
> > +               kobject_del(&rpc_xprt_switch->kobject);
> > +               kobject_put(&rpc_xprt_switch->kobject);
> > +               xprt_switch->xps_sysfs = NULL;
> > +       }
> > +}
> > diff --git a/net/sunrpc/sysfs.h b/net/sunrpc/sysfs.h
> > index c46afc848993..9b6acd3fd3dc 100644
> > --- a/net/sunrpc/sysfs.h
> > +++ b/net/sunrpc/sysfs.h
> > @@ -10,10 +10,20 @@ struct rpc_sysfs_client {
> >         struct net *net;
> >  };
> >
> > +struct rpc_sysfs_xprt_switch {
> > +       struct kobject kobject;
> > +       struct net *net;
> > +       struct rpc_xprt_switch *xprt_switch;
> > +       struct rpc_xprt *xprt;
> > +};
> > +
> >  int rpc_sysfs_init(void);
> >  void rpc_sysfs_exit(void);
> >
> >  void rpc_sysfs_client_setup(struct rpc_clnt *clnt, struct net *net);
> >  void rpc_sysfs_client_destroy(struct rpc_clnt *clnt);
> > +void rpc_sysfs_xprt_switch_setup(struct rpc_xprt_switch
> > *xprt_switch,
> > +                                struct rpc_xprt *xprt);
> > +void rpc_sysfs_xprt_switch_destroy(struct rpc_xprt_switch *xprt);
> >
> >  #endif
> > diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
> > index b71dd95ad7de..1ed16e4cc465 100644
> > --- a/net/sunrpc/xprtmultipath.c
> > +++ b/net/sunrpc/xprtmultipath.c
> > @@ -19,6 +19,8 @@
> >  #include <linux/sunrpc/addr.h>
> >  #include <linux/sunrpc/xprtmultipath.h>
> >
> > +#include "sysfs.h"
> > +
> >  typedef struct rpc_xprt *(*xprt_switch_find_xprt_t)(struct
> > rpc_xprt_switch *xps,
> >                 const struct rpc_xprt *cur);
> >
> > @@ -133,6 +135,7 @@ struct rpc_xprt_switch *xprt_switch_alloc(struct
> > rpc_xprt *xprt,
> >                 xps->xps_net = NULL;
> >                 INIT_LIST_HEAD(&xps->xps_xprt_list);
> >                 xps->xps_iter_ops = &rpc_xprt_iter_singular;
> > +               rpc_sysfs_xprt_switch_setup(xps, xprt);
> >                 xprt_switch_add_xprt_locked(xps, xprt);
> >         }
> >
> > @@ -161,6 +164,7 @@ static void xprt_switch_free(struct kref *kref)
> >                         struct rpc_xprt_switch, xps_kref);
> >
> >         xprt_switch_free_entries(xps);
> > +       rpc_sysfs_xprt_switch_destroy(xps);
> >         xprt_switch_free_id(xps);
> >         kfree_rcu(xps, xps_rcu);
> >  }
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
