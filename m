Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1683A83A0
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jun 2021 17:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhFOPIa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Jun 2021 11:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhFOPIa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Jun 2021 11:08:30 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936F8C061574
        for <linux-nfs@vger.kernel.org>; Tue, 15 Jun 2021 08:06:25 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t7so6393032edd.5
        for <linux-nfs@vger.kernel.org>; Tue, 15 Jun 2021 08:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PgdJh/ogUhw3/2IMkBmzgD4iSAeBUK27ihPkI3r+n+I=;
        b=L2yhHEws03cUDim4rtXA61KcJFovIVnKHW8U7QElx4tqAej0/Uygx9/CUkhjkZtiep
         dsynP54tj0aIgfGGEbjF9W8I42KGkMqFISVpuXE+yi2qYa75gmZrNRMyMTsEhq5GT9Kd
         lLxe3/q4mAEo0sBbs1QvSAotLnv0+Qd6fmnmKbzvqdJR9Gd7bIZJcSZibIhViTODSSNa
         59YF0lbQyuugZaazpgbwrdea4k2iYw7rgF04Sl9uzlgmRBr0wFz8TwLm4K0EQWEX3fPq
         wTpq0B2fEkdAAe6Ko3VnZfPyq6wlSC5bq9N/e/lwwK4T5CvZJBFIeIR5sAYls9WkOw4b
         QoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PgdJh/ogUhw3/2IMkBmzgD4iSAeBUK27ihPkI3r+n+I=;
        b=C4YXvzvjFcyL04oE4Xr2c9GcDBlUM+kntt/cMo3G8TzWD4+mUl8/GW2CHLTQm940KG
         K6t3vmmPh/UiEA96dhO+5hMFD7pixocRZFiZcav2MUFs+dK3dVRroWqna6Y4UAobMWv5
         m80Oel+nJ2ygGyB7ylL9nqXuG4dav5UpbnIJoPhT/rEZNcldORW7S6opLnTp7aTdKPAH
         v2lVn4/de1tfPdVNEKnb6Xyg5emClFCkvVVZWez6ypL9outmVvfmFpFXBPfQKsfpFTST
         UE/tNDqYqcLOqS47Yf6UvLu5BBob8Mp59eFyAKgkoSzz9btPyoiM1W3TSHJa34Y8sK7F
         sLYQ==
X-Gm-Message-State: AOAM5336/jzPuDnyK3GSkZPxgpaHpCsGOHC/+pDb67o7GB00ZxT4a+7f
        sMXb3lFkGvSQFQqoiRfv/qh1rZBaLQJWOpY2dfaOT6PV36E=
X-Google-Smtp-Source: ABdhPJy60z0kaOstocMRRR5L37wuR8oXk7X9UL7Feb2PjfHIcNyxbtOgdUQWycV11UxZsFWjN6abQbEDlDELKFI+dOg=
X-Received: by 2002:a05:6402:158e:: with SMTP id c14mr23925814edv.128.1623769584044;
 Tue, 15 Jun 2021 08:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210603225907.19981-1-olga.kornievskaia@gmail.com>
 <20210603225907.19981-2-olga.kornievskaia@gmail.com> <183cb72f03c90ce04c52e3813697095322cdc1db.camel@hammerspace.com>
In-Reply-To: <183cb72f03c90ce04c52e3813697095322cdc1db.camel@hammerspace.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 15 Jun 2021 11:06:12 -0400
Message-ID: <CAN-5tyGkOQ9wpAXnvo21SWmq=AxT16Ze2WXn1WgUSSmzLCt4AA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] sunrpc: take a xprt offline using sysfs
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Jun 13, 2021 at 12:16 PM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
> On Thu, 2021-06-03 at 18:59 -0400, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Using sysfs's xprt_state attribute, mark a particular transport
> > offline.
> > It will not be picked during the round-robin selection. It's not
> > allowed
> > to take the main (1st created transport associated with the
> > rpc_client)
> > offline.
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  include/linux/sunrpc/xprt.h |  2 ++
> >  net/sunrpc/clnt.c           |  1 +
> >  net/sunrpc/sysfs.c          | 42 +++++++++++++++++++++++++++++++++--
> > --
> >  net/sunrpc/xprtmultipath.c  |  3 ++-
> >  4 files changed, 43 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/sunrpc/xprt.h
> > b/include/linux/sunrpc/xprt.h
> > index 13a4eaf385cf..72a858f032c7 100644
> > --- a/include/linux/sunrpc/xprt.h
> > +++ b/include/linux/sunrpc/xprt.h
> > @@ -293,6 +293,7 @@ struct rpc_xprt {
> >         struct rcu_head         rcu;
> >         const struct xprt_class *xprt_class;
> >         struct rpc_sysfs_xprt   *xprt_sysfs;
> > +       bool                    main; /* marked if it's the 1st
> > transport */
> >  };
> >
> >  #if defined(CONFIG_SUNRPC_BACKCHANNEL)
> > @@ -426,6 +427,7 @@
> > void                        xprt_release_write(struct rpc_xprt *,
> > struct rpc_task *);
> >  #define XPRT_BOUND             (4)
> >  #define XPRT_BINDING           (5)
> >  #define XPRT_CLOSING           (6)
> > +#define XPRT_OFFLINE           (7)
> >  #define XPRT_CONGESTED         (9)
> >  #define XPRT_CWND_WAIT         (10)
> >  #define XPRT_WRITE_SPACE       (11)
> > diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> > index 9bf820bad84c..408618765aa5 100644
> > --- a/net/sunrpc/clnt.c
> > +++ b/net/sunrpc/clnt.c
> > @@ -412,6 +412,7 @@ static struct rpc_clnt * rpc_new_client(const
> > struct rpc_create_args *args,
> >         }
> >
> >         rpc_clnt_set_transport(clnt, xprt, timeout);
> > +       xprt->main = true;
> >         xprt_iter_init(&clnt->cl_xpi, xps);
> >         xprt_switch_put(xps);
> >
> > diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
> > index ec06c9257c07..02c918c5061b 100644
> > --- a/net/sunrpc/sysfs.c
> > +++ b/net/sunrpc/sysfs.c
> > @@ -118,7 +118,7 @@ static ssize_t rpc_sysfs_xprt_state_show(struct
> > kobject *kobj,
> >         struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
> >         ssize_t ret;
> >         int locked, connected, connecting, close_wait, bound,
> > binding,
> > -           closing, congested, cwnd_wait, write_space;
> > +           closing, congested, cwnd_wait, write_space, offline;
> >
> >         if (!xprt)
> >                 return 0;
> > @@ -136,8 +136,9 @@ static ssize_t rpc_sysfs_xprt_state_show(struct
> > kobject *kobj,
> >                 congested = test_bit(XPRT_CONGESTED, &xprt->state);
> >                 cwnd_wait = test_bit(XPRT_CWND_WAIT, &xprt->state);
> >                 write_space = test_bit(XPRT_WRITE_SPACE, &xprt-
> > >state);
> > +               offline = test_bit(XPRT_OFFLINE, &xprt->state);
> >
> > -               ret = sprintf(buf, "state=%s %s %s %s %s %s %s %s %s
> > %s\n",
> > +               ret = sprintf(buf, "state=%s %s %s %s %s %s %s %s %s
> > %s %s\n",
> >                               locked ? "LOCKED" : "",
> >                               connected ? "CONNECTED" : "",
> >                               connecting ? "CONNECTING" : "",
> > @@ -147,7 +148,8 @@ static ssize_t rpc_sysfs_xprt_state_show(struct
> > kobject *kobj,
> >                               closing ? "CLOSING" : "",
> >                               congested ? "CONGESTED" : "",
> >                               cwnd_wait ? "CWND_WAIT" : "",
> > -                             write_space ? "WRITE_SPACE" : "");
> > +                             write_space ? "WRITE_SPACE" : "",
> > +                             offline ? "OFFLINE" : "");
> >         }
> >
> >         xprt_put(xprt);
> > @@ -223,6 +225,38 @@ static ssize_t
> > rpc_sysfs_xprt_dstaddr_store(struct kobject *kobj,
> >         goto out;
> >  }
> >
> > +static ssize_t rpc_sysfs_xprt_state_change(struct kobject *kobj,
> > +                                          struct kobj_attribute
> > *attr,
> > +                                          const char *buf, size_t
> > count)
> > +{
> > +       struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
> > +       int offline = 0;
> > +
> > +       if (!xprt)
> > +               return 0;
> > +
> > +       if (!strncmp(buf, "offline", 7))
> > +               offline = 1;
> > +       else
> > +               return -EINVAL;
> > +
> > +       if (wait_on_bit_lock(&xprt->state, XPRT_LOCKED,
> > TASK_KILLABLE)) {
> > +               count = -EINTR;
> > +               goto out_put;
> > +       }
> > +       if (offline) {
> > +               if (xprt->main)
> > +                       count = -EINVAL;
> > +               else
> > +                       set_bit(XPRT_OFFLINE, &xprt->state);
> > +       }
>
> Is there any way to put the transport back online? What say the problem
> with the downed IP address gets fixed?

I will add this in v2. Originally the thought was that offlining a
transport was just a middle step before removing it and not something
in its own right. I would like to know if it's appropriate to also
then decrement the xps_nactive counter when the xprt is offline?

>
> > +
> > +       xprt_release_write(xprt, NULL);
> > +out_put:
> > +       xprt_put(xprt);
> > +       return count;
> > +}
> > +
> >  int rpc_sysfs_init(void)
> >  {
> >         rpc_sunrpc_kset = kset_create_and_add("sunrpc", NULL,
> > kernel_kobj);
> > @@ -293,7 +327,7 @@ static struct kobj_attribute rpc_sysfs_xprt_info
> > = __ATTR(xprt_info,
> >         0444, rpc_sysfs_xprt_info_show, NULL);
> >
> >  static struct kobj_attribute rpc_sysfs_xprt_change_state =
> > __ATTR(xprt_state,
> > -       0644, rpc_sysfs_xprt_state_show, NULL);
> > +       0644, rpc_sysfs_xprt_state_show,
> > rpc_sysfs_xprt_state_change);
> >
> >  static struct attribute *rpc_sysfs_xprt_attrs[] = {
> >         &rpc_sysfs_xprt_dstaddr.attr,
> > diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
> > index 07e76ae1028a..39551b794b80 100644
> > --- a/net/sunrpc/xprtmultipath.c
> > +++ b/net/sunrpc/xprtmultipath.c
> > @@ -230,7 +230,8 @@ void xprt_iter_default_rewind(struct
> > rpc_xprt_iter *xpi)
> >  static
> >  bool xprt_is_active(const struct rpc_xprt *xprt)
> >  {
> > -       return kref_read(&xprt->kref) != 0;
> > +       return (kref_read(&xprt->kref) != 0 &&
> > +               !test_bit(XPRT_OFFLINE, &xprt->state));
> >  }
> >
> >  static
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
