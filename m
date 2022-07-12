Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71A2572059
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Jul 2022 18:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbiGLQHs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Jul 2022 12:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbiGLQH1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Jul 2022 12:07:27 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0752DC8E8F
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 09:07:26 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id os14so15175202ejb.4
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 09:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n6q+dQEsk+MV7mg6+WdS/UFCUdGNVp5Bmdm/jJfgmFY=;
        b=Ln6VK5R0EJxis6s2Dx7+BO63N2vX9PSUSNtbtO4PX2U7ycAxAJdOct6qa2bxAXWTeu
         CzzRCQ/hnTHQqo3krZhb3jK1rWWpVspec7cc1Dk+blVFVo2ORyeYTOPqKJU7yLpf6c9G
         FA3Q5m2YWadNmArUYq0FehTxUmpa+XmSZZqUm05XmZmZCMBBrov3tbD7MsfFVGMacuq8
         kHqJUXIYRfYKUK+lWfpG3udKqVK5BbtGJmUNels0CfKX9PwWwYIJX8BrFOMzpW03TTNv
         0D9KyeSvhRPP1ohDrj4ofu47c9HR/aQjXp5NwtZSqBoEjhOLNYGilfya5hM+4GLVI1PA
         doYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n6q+dQEsk+MV7mg6+WdS/UFCUdGNVp5Bmdm/jJfgmFY=;
        b=kCDo6Tr0Nkz+2mZOH04WCJx8188EV8lZxPTh2Knct+gBmsKFLvIWuaDzXXaruPpjX4
         ZC5/dolZ/NxLBJxQZ3SYR0PZz9HB9jnkOKN2DJ1g2YqRausvhKzEbGhNdazv/VMf8GHk
         HAuaujsqvTAnVAeZHN2WZiZVAyw0WAZc4FngxeI2NHHmat9RnOqjeVbjDBS7EHcd7fn9
         FbwBJNgL3p7VZc+PhjPi2QryUFFkAERaPxr3VC1KQYHXtNJrcAHqOvbSSzbHUFkDOiZK
         nt+49ElcWII9X6bwQadKth68L14DuVJsZrmucXlWe/O7VQg1Zpqfso/DnARrkhYfiEkv
         ThZQ==
X-Gm-Message-State: AJIora/YJjH94Fu8UrS1yUt+tCYx2V6WdbjfwynCQeiepGO/KiM0mHZ5
        QikHSSeU7fz0G1W+7PoFM5uezpe09c50ecwDY5bfupTBS5E=
X-Google-Smtp-Source: AGRyM1tQOvtsYiLn/Pzpz7+zgSUIEFNMjVPKuvhSlrHtIhBd17TfT67bshZcNSzLJ/olq3Nw36mgHeBkivDSUaMkQ24=
X-Received: by 2002:a17:907:7f8c:b0:726:2c53:2f82 with SMTP id
 qk12-20020a1709077f8c00b007262c532f82mr23988004ejc.140.1657642044382; Tue, 12
 Jul 2022 09:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220620152407.63127-1-olga.kornievskaia@gmail.com>
 <20220620152407.63127-3-olga.kornievskaia@gmail.com> <ad8fdf73ef81e405b7fb0e07bff6ac41d562658e.camel@hammerspace.com>
In-Reply-To: <ad8fdf73ef81e405b7fb0e07bff6ac41d562658e.camel@hammerspace.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 12 Jul 2022 12:07:13 -0400
Message-ID: <CAN-5tyH0=SoQ-fnBY1MrjipEvky2MVxoETL2-a1PLMQNi+CQFA@mail.gmail.com>
Subject: Re: [PATCH v1 02/12] SUNRPC add function to offline remove trunkable transports
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

On Tue, Jul 12, 2022 at 11:24 AM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
> On Mon, 2022-06-20 at 11:23 -0400, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Iterate thru available transports in the xprt_switch for all
> > trunkable transports offline and possibly remote them as well.
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  include/linux/sunrpc/clnt.h |  1 +
> >  net/sunrpc/clnt.c           | 42
> > +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 43 insertions(+)
> >
> > diff --git a/include/linux/sunrpc/clnt.h
> > b/include/linux/sunrpc/clnt.h
> > index 90501404fa49..e74a0740603b 100644
> > --- a/include/linux/sunrpc/clnt.h
> > +++ b/include/linux/sunrpc/clnt.h
> > @@ -234,6 +234,7 @@
> > int         rpc_clnt_setup_test_and_add_xprt(struct rpc_clnt *,
> >                         struct rpc_xprt_switch *,
> >                         struct rpc_xprt *,
> >                         void *);
> > +void           rpc_clnt_manage_trunked_xprts(struct rpc_clnt *, void
> > *);
> >
> >  const char *rpc_proc_name(const struct rpc_task *task);
> >
> > diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> > index e2c6eca0271b..544b55a3aa20 100644
> > --- a/net/sunrpc/clnt.c
> > +++ b/net/sunrpc/clnt.c
> > @@ -2999,6 +2999,48 @@ int rpc_clnt_add_xprt(struct rpc_clnt *clnt,
> >  }
> >  EXPORT_SYMBOL_GPL(rpc_clnt_add_xprt);
> >
> > +static int rpc_xprt_offline_destroy(struct rpc_clnt *clnt,
> > +                                   struct rpc_xprt *xprt,
> > +                                   void *data)
> > +{
> > +       struct rpc_xprt *main_xprt;
> > +       struct rpc_xprt_switch *xps;
> > +       int err = 0;
> > +       int *offline_destroy = (int *)data;
> > +
> > +       xprt_get(xprt);
> > +
> > +       rcu_read_lock();
> > +       main_xprt = xprt_get(rcu_dereference(clnt->cl_xprt));
> > +       xps = xprt_switch_get(rcu_dereference(clnt-
> > >cl_xpi.xpi_xpswitch));
> > +       err = rpc_cmp_addr_port((struct sockaddr *)&xprt->addr,
> > +                               (struct sockaddr *)&main_xprt->addr);
> > +       rcu_read_unlock();
> > +       xprt_put(main_xprt);
> > +       if (err)
> > +               goto out;
> > +
> > +       if (wait_on_bit_lock(&xprt->state, XPRT_LOCKED,
> > TASK_KILLABLE)) {
> > +               err = -EINTR;
> > +               goto out;
> > +       }
> > +       xprt_set_offline_locked(xprt, xps);
> > +       if (*offline_destroy)
> > +               xprt_delete_locked(xprt, xps);
> > +
> > +       xprt_release_write(xprt, NULL);
> > +out:
> > +       xprt_put(xprt);
> > +       xprt_switch_put(xps);
> > +       return err;
> > +}
> > +
> > +void rpc_clnt_manage_trunked_xprts(struct rpc_clnt *clnt, void
> > *data)
> > +{
> > +       rpc_clnt_iterate_for_each_xprt(clnt,
> > rpc_xprt_offline_destroy, data);
> > +}
> > +EXPORT_SYMBOL_GPL(rpc_clnt_manage_trunked_xprts);
>
> Why is this function taking a 'void *' argument when
> rpc_xprt_offline_destroy() won't accept anything other than an 'int *'.
> It would be much cleaner to have 2 separate functions, neither or which
> need more than one argument. Then you can hide the pointer to the 'int'
> in each function and avoid exposing it as part of the API.

I could remove the void * altogether. As the following code only
offlines the transports. I wrote this function to be generic to be
able to do either if the need arises. It wasn't clear to me what you
meant by "have 2 separate functions". If you mean one for offline and
another for destroy, then perhaps that removes that need too. However,
if we were to have a generic one then since the majority of the code
is the same I don't see how having 2 functions is better.

> In addition, a function like this that is intended for use by
> different layer needs a proper kerneldoc comment so that we know what
> the API is for, and what it does.

Will add a comment above the function to explain what it does.

>
> > +
> >  struct connect_timeout_data {
> >         unsigned long connect_timeout;
> >         unsigned long reconnect_timeout;
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
