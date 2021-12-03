Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CD6467B87
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Dec 2021 17:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240590AbhLCQkI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Dec 2021 11:40:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55497 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230157AbhLCQkI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Dec 2021 11:40:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638549404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7SdYn/MTikIbPNl74jSYN3/4+YqLoRC+4ZJ63H1W4V8=;
        b=GW++uwx2K1fqXYUdK4YsAfbmq/0k7e/wGBjoVxoHL+w18simUcglrgU+cjkO9OutDEK/Hb
        O4cprULAiVgd/ZAYr0dw5oYjntWdnUBxdeql4jOc19pDvMK6uFLWNBEIWdMUm3OYa/Nexk
        etWsgCUmdXW76+zPAa4qzzJJQPInUv0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-TlnvGFXNMO6nuJKvkXoxaQ-1; Fri, 03 Dec 2021 11:36:42 -0500
X-MC-Unique: TlnvGFXNMO6nuJKvkXoxaQ-1
Received: by mail-ed1-f72.google.com with SMTP id bx28-20020a0564020b5c00b003e7c42443dbso3013808edb.15
        for <linux-nfs@vger.kernel.org>; Fri, 03 Dec 2021 08:36:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7SdYn/MTikIbPNl74jSYN3/4+YqLoRC+4ZJ63H1W4V8=;
        b=u4asNxl3SPyFTPW57qnm9wlxQMbS/oE1Gw/vQnDqFgMGB1HrsXG2lMW/Kt6JshG9g2
         URd+9c3dees4ynQR9SVTPmIGjn96TELPEkiTJDnQakiJdUTmsAhS4yvQeeHTIjbmBREK
         0byQs+7AILJfsarOukgHWkAZ/U5A2ahT3TG9IIgSC1jekZR8g/HkSQhcFepL75KGfnaA
         wHkzqv0xlF6MwmoNH/7Y839dEVPYJhUzYtknRwJ2QH25O5wGbwFDeFsdKP4+o92fvWZu
         VUFkRRLV703VwdmBkgcHFlP+GKYNgmIa5BXJaOw8HcsKD3dopQj85EO6xS0jVwRBFcy3
         xPQg==
X-Gm-Message-State: AOAM532rFmxRgvsd/FZw3cGScHIlekjSgmURb29X9jbU2frHsonDZ27a
        NCIeainxVbLx2ReyfE/1OiZn7+B5El34QqEcqnS3ZydZex0Fho9EKjvPuiLlGOUOCfAJasso17O
        ed7p+svk6b+vfOaf/QUPNlTU/KKXpG4zVuQOh
X-Received: by 2002:a17:907:628f:: with SMTP id nd15mr24421590ejc.389.1638549401476;
        Fri, 03 Dec 2021 08:36:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz4ImrZ5BnWHepyw1dodKvG2vgNFoLeLkJf9XYK56G4K58lYHckPCy0uWLw5531RFfmKx19MAO2sWC0pKp8xOs=
X-Received: by 2002:a17:907:628f:: with SMTP id nd15mr24421568ejc.389.1638549401221;
 Fri, 03 Dec 2021 08:36:41 -0800 (PST)
MIME-Version: 1.0
References: <20211029200421.65090-1-trondmy@kernel.org> <20211029200421.65090-2-trondmy@kernel.org>
 <20211029200421.65090-3-trondmy@kernel.org> <CALF+zOmG+nUVPX6P0TET_JibH-E2qOvbuz5Fm=7qQk_ycM7y8Q@mail.gmail.com>
In-Reply-To: <CALF+zOmG+nUVPX6P0TET_JibH-E2qOvbuz5Fm=7qQk_ycM7y8Q@mail.gmail.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Fri, 3 Dec 2021 11:36:05 -0500
Message-ID: <CALF+zO=o0DZxiyBYzkai+50u_3PsoB0_rNqyxhvmSgxT6S1dZg@mail.gmail.com>
Subject: Re: [PATCH 3/4] SUNRPC: Clean up xs_tcp_setup_sock()
To:     trondmy@kernel.org
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 3, 2021 at 11:10 AM David Wysochanski <dwysocha@redhat.com> wrote:
>
> On Fri, Oct 29, 2021 at 4:11 PM <trondmy@kernel.org> wrote:
> >
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >
> > Move the error handling into a single switch statement for clarity.
> >
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > ---
> >  net/sunrpc/xprtsock.c | 68 ++++++++++++++++++-------------------------
> >  1 file changed, 28 insertions(+), 40 deletions(-)
> >
> > diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> > index 291b63136c08..7fb302e202bc 100644
> > --- a/net/sunrpc/xprtsock.c
> > +++ b/net/sunrpc/xprtsock.c
> > @@ -2159,7 +2159,6 @@ static void xs_tcp_set_connect_timeout(struct rpc_xprt *xprt,
> >  static int xs_tcp_finish_connecting(struct rpc_xprt *xprt, struct socket *sock)
> >  {
> >         struct sock_xprt *transport = container_of(xprt, struct sock_xprt, xprt);
> > -       int ret = -ENOTCONN;
> >
> >         if (!transport->inet) {
> >                 struct sock *sk = sock->sk;
> > @@ -2203,7 +2202,7 @@ static int xs_tcp_finish_connecting(struct rpc_xprt *xprt, struct socket *sock)
> >         }
> >
> >         if (!xprt_bound(xprt))
> > -               goto out;
> > +               return -ENOTCONN;
> >
> >         xs_set_memalloc(xprt);
> >
> > @@ -2211,22 +2210,7 @@ static int xs_tcp_finish_connecting(struct rpc_xprt *xprt, struct socket *sock)
> >
> >         /* Tell the socket layer to start connecting... */
> >         set_bit(XPRT_SOCK_CONNECTING, &transport->sock_state);
> > -       ret = kernel_connect(sock, xs_addr(xprt), xprt->addrlen, O_NONBLOCK);
> > -       switch (ret) {
> > -       case 0:
> > -               xs_set_srcport(transport, sock);
> > -               fallthrough;
> > -       case -EINPROGRESS:
> > -               /* SYN_SENT! */
> > -               if (xprt->reestablish_timeout < XS_TCP_INIT_REEST_TO)
> > -                       xprt->reestablish_timeout = XS_TCP_INIT_REEST_TO;
> > -               break;
> > -       case -EADDRNOTAVAIL:
> > -               /* Source port number is unavailable. Try a new one! */
> > -               transport->srcport = 0;
> > -       }
> > -out:
> > -       return ret;
> > +       return kernel_connect(sock, xs_addr(xprt), xprt->addrlen, O_NONBLOCK);
> >  }
> >
> >  /**
> > @@ -2241,14 +2225,14 @@ static void xs_tcp_setup_socket(struct work_struct *work)
> >                 container_of(work, struct sock_xprt, connect_worker.work);
> >         struct socket *sock = transport->sock;
> >         struct rpc_xprt *xprt = &transport->xprt;
> > -       int status = -EIO;
> > +       int status;
> >
> >         if (!sock) {
> >                 sock = xs_create_sock(xprt, transport,
> >                                 xs_addr(xprt)->sa_family, SOCK_STREAM,
> >                                 IPPROTO_TCP, true);
> >                 if (IS_ERR(sock)) {
> > -                       status = PTR_ERR(sock);
> > +                       xprt_wake_pending_tasks(xprt, PTR_ERR(sock));
> >                         goto out;
> >                 }
> >         }
> > @@ -2265,21 +2249,21 @@ static void xs_tcp_setup_socket(struct work_struct *work)
> >                         xprt, -status, xprt_connected(xprt),
> >                         sock->sk->sk_state);
> >         switch (status) {
> > -       default:
> > -               printk("%s: connect returned unhandled error %d\n",
> > -                       __func__, status);
> > -               fallthrough;
> > -       case -EADDRNOTAVAIL:
> > -               /* We're probably in TIME_WAIT. Get rid of existing socket,
> > -                * and retry
> > -                */
> > -               xs_tcp_force_close(xprt);
> > -               break;
> >         case 0:
> > +               xs_set_srcport(transport, sock);
> > +               fallthrough;
> >         case -EINPROGRESS:
> > +               /* SYN_SENT! */
> > +               if (xprt->reestablish_timeout < XS_TCP_INIT_REEST_TO)
> > +                       xprt->reestablish_timeout = XS_TCP_INIT_REEST_TO;
> > +               fallthrough;
> >         case -EALREADY:
> > -               xprt_unlock_connect(xprt, transport);
> > -               return;
> > +               goto out_unlock;
> > +       case -EADDRNOTAVAIL:
> > +               /* Source port number is unavailable. Try a new one! */
> > +               transport->srcport = 0;
> > +               status = -EAGAIN;
> > +               break;
> >         case -EINVAL:
> >                 /* Happens, for instance, if the user specified a link
> >                  * local IPv6 address without a scope-id.
> > @@ -2291,18 +2275,22 @@ static void xs_tcp_setup_socket(struct work_struct *work)
> >         case -EHOSTUNREACH:
> >         case -EADDRINUSE:
> >         case -ENOBUFS:
> > -               /* xs_tcp_force_close() wakes tasks with a fixed error code.
> > -                * We need to wake them first to ensure the correct error code.
> > -                */
> > -               xprt_wake_pending_tasks(xprt, status);
> > -               xs_tcp_force_close(xprt);
> > -               goto out;
> > +               break;
> > +       default:
> > +               printk("%s: connect returned unhandled error %d\n",
> > +                       __func__, status);
> > +               status = -EAGAIN;
> >         }
> > -       status = -EAGAIN;
> > +
> > +       /* xs_tcp_force_close() wakes tasks with a fixed error code.
> > +        * We need to wake them first to ensure the correct error code.
> > +        */
> > +       xprt_wake_pending_tasks(xprt, status);
> > +       xs_tcp_force_close(xprt);
>
> Isn't this a problem to call xs_tcp_force_close() unconditionally at
> the bottom of xs_tcp_setup_socket()?
> Before this patch we only called this depending on certain returns
> from kernel_connect().
>
Nevermind - I see the fallthroughs and out_unlock

>
>
> >  out:
> >         xprt_clear_connecting(xprt);
> > +out_unlock:
> >         xprt_unlock_connect(xprt, transport);
> > -       xprt_wake_pending_tasks(xprt, status);
> >  }
> >
> >  /**
> > --
> > 2.31.1
> >

