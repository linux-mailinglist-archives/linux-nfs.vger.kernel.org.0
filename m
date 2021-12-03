Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC5E467B06
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Dec 2021 17:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbhLCQOR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Dec 2021 11:14:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42980 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229646AbhLCQOR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Dec 2021 11:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638547853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oiRD4Z7I8cHFD5ktU3T+viwnjewGMdvvcF07OGsFp+0=;
        b=VWdEFR9d+CP4m0M/Ddgki3AmTI2h0W5M/y1Bi50LzB8UOcHFysf6Ql3WXXgUkm1j14jJY+
        mPzLKGZY/mERSg8uhG2N5BwSKnL/aShxid6Wipe7nBIPJcuCclnFEg7xijaZeK0kD6fIcc
        05GhthDD20U+rVAo7vhWeT7ktY0jfeY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-LnUMKMDYPwePer_0sI04sA-1; Fri, 03 Dec 2021 11:10:51 -0500
X-MC-Unique: LnUMKMDYPwePer_0sI04sA-1
Received: by mail-ed1-f70.google.com with SMTP id v10-20020aa7d9ca000000b003e7bed57968so2914926eds.23
        for <linux-nfs@vger.kernel.org>; Fri, 03 Dec 2021 08:10:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oiRD4Z7I8cHFD5ktU3T+viwnjewGMdvvcF07OGsFp+0=;
        b=2bffd2pnwIiwhFxFQT+g14SHmyDOVhE2jzLlncqjIMjy2rC18ZG+UWvGiYh6d9rTcy
         tHyJWz0RUFsbsQAiiUSnNU7E3OYfGI+8j+P69WkNbFa7vA01DrwWqKzlJTvelNozYYoc
         9WdDPsC2/E5uwVcsviM/bV+w0wHaCww+B5n9SeQBOtnFYLXHD3d4Z2wRBxDeWqLEvz/2
         pRkaZ9QPPMVd1KqMvtQuj70PLEDNARQ+CzKtZIQ4f2n7ojgcJYSd9crV0yw9So78IIee
         1DVMcZiNHCCpe8jYmZzHrWOPb2JnvKZzXXx+dFVO6briDZrnOskV/3HKPjBoxbew2DWe
         YUdQ==
X-Gm-Message-State: AOAM530Hog9JRaTsTW0NcgSqeLi08x05mNheKXgXVLjPgcFJogKBwjlv
        KkRNTt4RRboTPb1h+ytsmKlaZyJUyOijNgstzSoUAKE4pS8NtV3jVcE6S7vxKv5he5EXFBD5C1X
        iE1b/wn3MC0Q5MaVJV901PeoNkB+4Vv5AHdPl
X-Received: by 2002:a17:907:3f95:: with SMTP id hr21mr24783354ejc.427.1638547850439;
        Fri, 03 Dec 2021 08:10:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4mX+BlzQH54Ojj9z0JDTQoQlirq18m4fdJnqcXRg2DBhsnkQwXzLI1xwZ4D2wEkcjXHRvfifoxyjqvL3btWc=
X-Received: by 2002:a17:907:3f95:: with SMTP id hr21mr24783321ejc.427.1638547850255;
 Fri, 03 Dec 2021 08:10:50 -0800 (PST)
MIME-Version: 1.0
References: <20211029200421.65090-1-trondmy@kernel.org> <20211029200421.65090-2-trondmy@kernel.org>
 <20211029200421.65090-3-trondmy@kernel.org>
In-Reply-To: <20211029200421.65090-3-trondmy@kernel.org>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Fri, 3 Dec 2021 11:10:14 -0500
Message-ID: <CALF+zOmG+nUVPX6P0TET_JibH-E2qOvbuz5Fm=7qQk_ycM7y8Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] SUNRPC: Clean up xs_tcp_setup_sock()
To:     trondmy@kernel.org
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 29, 2021 at 4:11 PM <trondmy@kernel.org> wrote:
>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> Move the error handling into a single switch statement for clarity.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  net/sunrpc/xprtsock.c | 68 ++++++++++++++++++-------------------------
>  1 file changed, 28 insertions(+), 40 deletions(-)
>
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index 291b63136c08..7fb302e202bc 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -2159,7 +2159,6 @@ static void xs_tcp_set_connect_timeout(struct rpc_xprt *xprt,
>  static int xs_tcp_finish_connecting(struct rpc_xprt *xprt, struct socket *sock)
>  {
>         struct sock_xprt *transport = container_of(xprt, struct sock_xprt, xprt);
> -       int ret = -ENOTCONN;
>
>         if (!transport->inet) {
>                 struct sock *sk = sock->sk;
> @@ -2203,7 +2202,7 @@ static int xs_tcp_finish_connecting(struct rpc_xprt *xprt, struct socket *sock)
>         }
>
>         if (!xprt_bound(xprt))
> -               goto out;
> +               return -ENOTCONN;
>
>         xs_set_memalloc(xprt);
>
> @@ -2211,22 +2210,7 @@ static int xs_tcp_finish_connecting(struct rpc_xprt *xprt, struct socket *sock)
>
>         /* Tell the socket layer to start connecting... */
>         set_bit(XPRT_SOCK_CONNECTING, &transport->sock_state);
> -       ret = kernel_connect(sock, xs_addr(xprt), xprt->addrlen, O_NONBLOCK);
> -       switch (ret) {
> -       case 0:
> -               xs_set_srcport(transport, sock);
> -               fallthrough;
> -       case -EINPROGRESS:
> -               /* SYN_SENT! */
> -               if (xprt->reestablish_timeout < XS_TCP_INIT_REEST_TO)
> -                       xprt->reestablish_timeout = XS_TCP_INIT_REEST_TO;
> -               break;
> -       case -EADDRNOTAVAIL:
> -               /* Source port number is unavailable. Try a new one! */
> -               transport->srcport = 0;
> -       }
> -out:
> -       return ret;
> +       return kernel_connect(sock, xs_addr(xprt), xprt->addrlen, O_NONBLOCK);
>  }
>
>  /**
> @@ -2241,14 +2225,14 @@ static void xs_tcp_setup_socket(struct work_struct *work)
>                 container_of(work, struct sock_xprt, connect_worker.work);
>         struct socket *sock = transport->sock;
>         struct rpc_xprt *xprt = &transport->xprt;
> -       int status = -EIO;
> +       int status;
>
>         if (!sock) {
>                 sock = xs_create_sock(xprt, transport,
>                                 xs_addr(xprt)->sa_family, SOCK_STREAM,
>                                 IPPROTO_TCP, true);
>                 if (IS_ERR(sock)) {
> -                       status = PTR_ERR(sock);
> +                       xprt_wake_pending_tasks(xprt, PTR_ERR(sock));
>                         goto out;
>                 }
>         }
> @@ -2265,21 +2249,21 @@ static void xs_tcp_setup_socket(struct work_struct *work)
>                         xprt, -status, xprt_connected(xprt),
>                         sock->sk->sk_state);
>         switch (status) {
> -       default:
> -               printk("%s: connect returned unhandled error %d\n",
> -                       __func__, status);
> -               fallthrough;
> -       case -EADDRNOTAVAIL:
> -               /* We're probably in TIME_WAIT. Get rid of existing socket,
> -                * and retry
> -                */
> -               xs_tcp_force_close(xprt);
> -               break;
>         case 0:
> +               xs_set_srcport(transport, sock);
> +               fallthrough;
>         case -EINPROGRESS:
> +               /* SYN_SENT! */
> +               if (xprt->reestablish_timeout < XS_TCP_INIT_REEST_TO)
> +                       xprt->reestablish_timeout = XS_TCP_INIT_REEST_TO;
> +               fallthrough;
>         case -EALREADY:
> -               xprt_unlock_connect(xprt, transport);
> -               return;
> +               goto out_unlock;
> +       case -EADDRNOTAVAIL:
> +               /* Source port number is unavailable. Try a new one! */
> +               transport->srcport = 0;
> +               status = -EAGAIN;
> +               break;
>         case -EINVAL:
>                 /* Happens, for instance, if the user specified a link
>                  * local IPv6 address without a scope-id.
> @@ -2291,18 +2275,22 @@ static void xs_tcp_setup_socket(struct work_struct *work)
>         case -EHOSTUNREACH:
>         case -EADDRINUSE:
>         case -ENOBUFS:
> -               /* xs_tcp_force_close() wakes tasks with a fixed error code.
> -                * We need to wake them first to ensure the correct error code.
> -                */
> -               xprt_wake_pending_tasks(xprt, status);
> -               xs_tcp_force_close(xprt);
> -               goto out;
> +               break;
> +       default:
> +               printk("%s: connect returned unhandled error %d\n",
> +                       __func__, status);
> +               status = -EAGAIN;
>         }
> -       status = -EAGAIN;
> +
> +       /* xs_tcp_force_close() wakes tasks with a fixed error code.
> +        * We need to wake them first to ensure the correct error code.
> +        */
> +       xprt_wake_pending_tasks(xprt, status);
> +       xs_tcp_force_close(xprt);

Isn't this a problem to call xs_tcp_force_close() unconditionally at
the bottom of xs_tcp_setup_socket()?
Before this patch we only called this depending on certain returns
from kernel_connect().



>  out:
>         xprt_clear_connecting(xprt);
> +out_unlock:
>         xprt_unlock_connect(xprt, transport);
> -       xprt_wake_pending_tasks(xprt, status);
>  }
>
>  /**
> --
> 2.31.1
>

