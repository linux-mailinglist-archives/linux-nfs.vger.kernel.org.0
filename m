Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4350469993
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Dec 2021 15:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344642AbhLFO6j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Dec 2021 09:58:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31885 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245556AbhLFO6j (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Dec 2021 09:58:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638802509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A7Fc0usHpzy9V1LF4MIRRif9ZEL2nvt03NiTtiV4p0w=;
        b=fo0486cRFC2kp9k+hzzSlCbnWs6AkZJ45pPqfMeURWcZVYfiLGo8H6nt+JewVy5wbmus9z
        lKMDvNFx4gBb64Wr52k6CK2QgyHH4dCbBn0twHQdri8rXlxbDIK/VwZRrg3gH2bzWTQdFC
        48mG0d4Fs1XvBLYwcxR4+AAyAKTbofw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-LYz-5D8XP5yem1vRtk9E4g-1; Mon, 06 Dec 2021 09:55:08 -0500
X-MC-Unique: LYz-5D8XP5yem1vRtk9E4g-1
Received: by mail-ed1-f71.google.com with SMTP id d13-20020a056402516d00b003e7e67a8f93so8644140ede.0
        for <linux-nfs@vger.kernel.org>; Mon, 06 Dec 2021 06:55:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A7Fc0usHpzy9V1LF4MIRRif9ZEL2nvt03NiTtiV4p0w=;
        b=0hONDZA3f8xUWBKl4WbIAolR5guVVzNJuN07DAg+wCtOJNPd4t4k1oknYvR9cucXe2
         MnvNyP70GacR53Y6c5apcGc6hfSJdgWWHYdYFPFHcpSpUXmH7DjVpv1GimgfyQqoRuaR
         UvPamW3sQ9JUr105hd2pgc/Nl5kp4JwoH04CNUyOm4GDESVNhLjqj9QH7305CqMKixYZ
         o1SSy282pH/0yv7LrA732iDb3AbXFxYYU2a8GPbMfnn3sTbOONgJIsF1JGY6Zfgleyef
         CW7EHRxH2bWt88Sf4qp+UhlFqfji2Ik7I4JCY0g7DFOZ5/PzyVavbpjXX/B7PWgIZsYL
         WDQg==
X-Gm-Message-State: AOAM532aYErLP2NPx4hCn0cLeTlpB3NVLyXcZWQDeCuTOpIfgOsn2nd0
        KJ6A9F/mWVMFujypMCp+Uz06zPT9AiObFnozj2u8OiQZUSiXD2EvxqHmpxFbK3htKL8gGtKhtO7
        vFgM4TnV6hBvkQonRMjosU9Y6fnZPkm6jn7ln
X-Received: by 2002:a17:907:68e:: with SMTP id wn14mr46333732ejb.258.1638802507488;
        Mon, 06 Dec 2021 06:55:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyKJ/vW34AnuP54jCFG3JUlVoQZr0HqDReeEZ5fvru/8VnhH4aEVQGX+lwlfpmV2xpS66ni2LJp4CDIC/0coko=
X-Received: by 2002:a17:907:68e:: with SMTP id wn14mr46333706ejb.258.1638802507193;
 Mon, 06 Dec 2021 06:55:07 -0800 (PST)
MIME-Version: 1.0
References: <20211202181308.279592-1-plambri@redhat.com>
In-Reply-To: <20211202181308.279592-1-plambri@redhat.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Mon, 6 Dec 2021 09:54:30 -0500
Message-ID: <CALF+zOm32pbbnAVrVdWte1=MC_COEfUqjyDf++OqrcS0gc4dHA@mail.gmail.com>
Subject: Re: [PATCH] SUNRPC: Add source address/port to rpc_socket* traces
To:     Pierguido Lambri <plambri@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Dec 2, 2021 at 1:13 PM Pierguido Lambri <plambri@redhat.com> wrote:
>
> The rpc_socket* traces now show also the source address
> and port. An example is:
>
> kworker/u17:1-951   [005] 134218.925343: rpc_socket_close:
>    socket:[46913] srcaddr=192.168.100.187:793 dstaddr=192.168.100.129:2049
>    state=4 (DISCONNECTING) sk_state=7 (CLOSE)
> kworker/u17:0-242   [006] 134360.841370: rpc_socket_connect:
>    error=-115 socket:[56322] srcaddr=192.168.100.187:769
>    dstaddr=192.168.100.129:2049 state=2 (CONNECTING) sk_state=2 (SYN_SENT)
>        <idle>-0     [006] 134360.841859: rpc_socket_state_change: socket:[56322]
>    srcaddr=192.168.100.187:769 dstaddr=192.168.100.129:2049 state=2 (CONNECTING)
>    sk_state=1 (ESTABLISHED)
>
> Signed-off-by: Pierguido Lambri <plambri@redhat.com>
> ---
>  include/trace/events/sunrpc.h | 52 +++++++++++++++++++++--------------
>  1 file changed, 32 insertions(+), 20 deletions(-)
>
> diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
> index 3a99358c262b..c9a5babf3be8 100644
> --- a/include/trace/events/sunrpc.h
> +++ b/include/trace/events/sunrpc.h
> @@ -794,6 +794,9 @@ RPC_SHOW_SOCKET
>
>  RPC_SHOW_SOCK
>
> +
> +#include <trace/events/net_probe_common.h>
> +
>  /*
>   * Now redefine the EM() and EMe() macros to map the enums to the strings
>   * that will be printed in the output.
> @@ -816,27 +819,32 @@ DECLARE_EVENT_CLASS(xs_socket_event,
>                         __field(unsigned int, socket_state)
>                         __field(unsigned int, sock_state)
>                         __field(unsigned long long, ino)
> -                       __string(dstaddr,
> -                               xprt->address_strings[RPC_DISPLAY_ADDR])
> -                       __string(dstport,
> -                               xprt->address_strings[RPC_DISPLAY_PORT])
> +                       __array(__u8, saddr, sizeof(struct sockaddr_in6))
> +                       __array(__u8, daddr, sizeof(struct sockaddr_in6))
>                 ),
>
>                 TP_fast_assign(
>                         struct inode *inode = SOCK_INODE(socket);
> +                       const struct sock *sk = socket->sk;
> +                       const struct inet_sock *inet = inet_sk(sk);
> +
> +                       memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
> +                       memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
> +
> +                       TP_STORE_ADDR_PORTS(__entry, inet, sk);
> +
>                         __entry->socket_state = socket->state;
>                         __entry->sock_state = socket->sk->sk_state;
>                         __entry->ino = (unsigned long long)inode->i_ino;
> -                       __assign_str(dstaddr,
> -                               xprt->address_strings[RPC_DISPLAY_ADDR]);
> -                       __assign_str(dstport,
> -                               xprt->address_strings[RPC_DISPLAY_PORT]);
> +
>                 ),
>
>                 TP_printk(
> -                       "socket:[%llu] dstaddr=%s/%s "
> +                       "socket:[%llu] srcaddr=%pISpc dstaddr=%pISpcst "

Shouldn't the above scan code be the same as dstaddr below: "dstaddr=%pISpc "

>                         "state=%u (%s) sk_state=%u (%s)",
> -                       __entry->ino, __get_str(dstaddr), __get_str(dstport),
> +                       __entry->ino,
> +                       __entry->saddr,
> +                       __entry->daddr,
>                         __entry->socket_state,
>                         rpc_show_socket_state(__entry->socket_state),
>                         __entry->sock_state,
> @@ -866,29 +874,33 @@ DECLARE_EVENT_CLASS(xs_socket_event_done,
>                         __field(unsigned int, socket_state)
>                         __field(unsigned int, sock_state)
>                         __field(unsigned long long, ino)
> -                       __string(dstaddr,
> -                               xprt->address_strings[RPC_DISPLAY_ADDR])
> -                       __string(dstport,
> -                               xprt->address_strings[RPC_DISPLAY_PORT])
> +                       __array(__u8, saddr, sizeof(struct sockaddr_in6))
> +                       __array(__u8, daddr, sizeof(struct sockaddr_in6))
>                 ),
>
>                 TP_fast_assign(
>                         struct inode *inode = SOCK_INODE(socket);
> +                       const struct sock *sk = socket->sk;
> +                       const struct inet_sock *inet = inet_sk(sk);
> +
> +                       memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
> +                       memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
> +
> +                       TP_STORE_ADDR_PORTS(__entry, inet, sk);
> +
>                         __entry->socket_state = socket->state;
>                         __entry->sock_state = socket->sk->sk_state;
>                         __entry->ino = (unsigned long long)inode->i_ino;
>                         __entry->error = error;
> -                       __assign_str(dstaddr,
> -                               xprt->address_strings[RPC_DISPLAY_ADDR]);
> -                       __assign_str(dstport,
> -                               xprt->address_strings[RPC_DISPLAY_PORT]);
>                 ),
>
>                 TP_printk(
> -                       "error=%d socket:[%llu] dstaddr=%s/%s "
> +                       "error=%d socket:[%llu] srcaddr=%pISpc dstaddr=%pISpc "
>                         "state=%u (%s) sk_state=%u (%s)",
>                         __entry->error,
> -                       __entry->ino, __get_str(dstaddr), __get_str(dstport),
> +                       __entry->ino,
> +                       __entry->saddr,
> +                       __entry->daddr,
>                         __entry->socket_state,
>                         rpc_show_socket_state(__entry->socket_state),
>                         __entry->sock_state,
> --
> 2.33.1
>

This patch is useful for troubleshooting reconnect issues, making it
easier to match up tcpdumps with kernel traces.

Acked-and-tested-by: Dave Wysochanski <dwysocha@redhat.com>

