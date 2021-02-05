Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F064331100E
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Feb 2021 19:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhBEQzA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Feb 2021 11:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbhBEQw3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 Feb 2021 11:52:29 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E209FC061756
        for <linux-nfs@vger.kernel.org>; Fri,  5 Feb 2021 10:34:09 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id r12so13388311ejb.9
        for <linux-nfs@vger.kernel.org>; Fri, 05 Feb 2021 10:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uYvWoXXb/xX6WF/cu+UQgzpQ8ORkfD5dpS/I/THEHD4=;
        b=EP9d8Ia/YdZmFpm+sDPl9mra0JWV7oC4y7q7/Etyx5DLUGvH4zoZjP7OE16EO0gLgH
         0kpspq5yeDHrGrUOq1P6prhdfrrd8L9su5807qSjbzf34cMBRCM+57po/ITlS/A5PX2b
         bzDxY/rbNKK504LkNck37x4VLJbnYLjcpjeLf4rm5R8nSBT1iwIT0dp/Tm4N0tc4wIkL
         cG2Q//xlI1c0c53j8/Xi6mT5uqPCQovTRBheDkpLNgJD0VAtvr/4tp0Rj2G/blDQFn7J
         pBFqh1HJymRStHDqy+jjtgktxJnwGTnfhYv4SVCpYnZyx2/a0n1bC1Qo6qgsH6wz3GjJ
         PB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uYvWoXXb/xX6WF/cu+UQgzpQ8ORkfD5dpS/I/THEHD4=;
        b=XsGm3TXfj6hgJKQ9h/b8Kkc8YYzGmfvBYzvOrM//tI7Ey3McTTAGVy9y85AEq4a5Xd
         4omb4qSi+G0k1wR3NTwhcUO24dbAGqxRI5bpGyvj4vT0cY5QYVb4H8kvwz5a7zSgeEv/
         xsDOVhVy7L0drsEnfafUZn5o0Py/gdE7kKsF8qcE6rWNiqz2uB9DIWYKHUtM0e5awfB5
         ZVqyG0OUtJ2bEPY/qkQ+zRiVmuqL1sgLAOoYRxvcyUwd5QY6CNwY/EnIYjdGujYXCFRF
         uNrUeRmNQwpwyJcgSXLZ0TFOOzRkRwW69C+yPfLA/4TXAKvOSO5+GxwqVnJjBSM6fZqt
         6akw==
X-Gm-Message-State: AOAM530YVdfiHt4rC3/DoB9nOGKY09PGmkDYvCws7xkUGRaOBmSIGf12
        zcTwrcJfpDMtNhYiwMmFARLRQIRslIJnmyDyHNS8pZKFcz0=
X-Google-Smtp-Source: ABdhPJzXMtSFPJu5lbdxdR5rif10nHgb9Qnr86ZXoclgyhZ1Sc47u6kPvS/pHkixJpHBpq8XLXMn0+Nas8VPM8L/DaQ=
X-Received: by 2002:a17:906:3e42:: with SMTP id t2mr5320518eji.439.1612550048580;
 Fri, 05 Feb 2021 10:34:08 -0800 (PST)
MIME-Version: 1.0
References: <20210202184244.288898-1-Anna.Schumaker@Netapp.com>
 <20210202184244.288898-5-Anna.Schumaker@Netapp.com> <4eaf0c288d97a2d03c5cd2a7ed728a73085b2719.camel@hammerspace.com>
 <67497ea4a7d22726112e0083893e85a17f1ca681.camel@hammerspace.com>
In-Reply-To: <67497ea4a7d22726112e0083893e85a17f1ca681.camel@hammerspace.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Fri, 5 Feb 2021 13:33:52 -0500
Message-ID: <CAFX2JfkGZbvgvxKJyPuxO9NG_RJGj-3BNH6jJDYGJV0pVhwipA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] sunrpc: Prepare xs_connect() for taking NULL tasks
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Feb 2, 2021 at 4:59 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Tue, 2021-02-02 at 16:49 -0500, Trond Myklebust wrote:
> > On Tue, 2021-02-02 at 13:42 -0500, schumaker.anna@gmail.com wrote:
> > > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > >
> > > We won't have a task structure when we go to change IP addresses,
> > > so
> > > check for one before calling the WARN_ON() to avoid crashing.
> > >
> > > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > ---
> > >  net/sunrpc/xprtsock.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> > > index c56a66cdf4ac..250abf1aa018 100644
> > > --- a/net/sunrpc/xprtsock.c
> > > +++ b/net/sunrpc/xprtsock.c
> > > @@ -2311,7 +2311,8 @@ static void xs_connect(struct rpc_xprt *xprt,
> > > struct rpc_task *task)
> > >         struct sock_xprt *transport = container_of(xprt, struct
> > > sock_xprt, xprt);
> > >         unsigned long delay = 0;
> > >
> > > -       WARN_ON_ONCE(!xprt_lock_connect(xprt, task, transport));
> > > +       if (task)
> > > +               WARN_ON_ONCE(!xprt_lock_connect(xprt, task,
> > > transport));
> >
> > Nit: That's the same as
> >    WARN_ON_ONCE(task && !xprt_lock_connect(xprt, task, transport));
> >
> > >
> > >         if (transport->sock != NULL) {
> > >                 dprintk("RPC:       xs_connect delayed xprt %p for
> > > %lu "
> >
>
> So, the problem with this patch is that you're deliberately
> circumventing the process of locking the socket. That's not going to
> work.
> What you could do is follow the example set by xprt_destroy() and
> xs_enable_swap(), to call wait_on_bit_lock() when there is no task.
> That should work, but you'd better make sure that your process holds a
> reference to the xprt->kref before doing that, or else you could easily
> end up deadlocking with xprt_destroy().

I've tried this, and the kref isn't a problem but no matter where I
put the wait_on_bit_lock() call it ends up deadlocking. I think it's
happening in the xs_tcp_setup_socket() function, but I'm still trying
to figure out exactly where.

Anna
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
