Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF637B2049
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Sep 2023 16:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjI1O6X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Sep 2023 10:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjI1O6W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Sep 2023 10:58:22 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5236195
        for <linux-nfs@vger.kernel.org>; Thu, 28 Sep 2023 07:58:20 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-503067bd530so3877484e87.0
        for <linux-nfs@vger.kernel.org>; Thu, 28 Sep 2023 07:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1695913099; x=1696517899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7JeRqvmayjmhV4Z894X7Aad+1S2MFBLRFvn4wup2nM=;
        b=W2IFRGR3Zgn8MxQrHAo3+VPfG5A2SX+QEahrMx24+RUCuf+WtUHcgf7BWAZvYcwMfB
         2kV2QRiBHIlTLRlcCn+zwaEwjuOXjDfSUPG+ldEBgEMZ5mee418Q5qihMo8AczeU9FV8
         iZAyzhzBe0vqG26rZue2trDHKo+4myOe0m5ZkpjfpOJarSd6R+JaY1NdjaTr0d+CE2sd
         qQo/UHgfGXxkgh3InulAZQCEPavmxzStbX/rp4mf3EA1P6ZnMOEaI6XFG0CMXfcu/Fz8
         HIANf1GlJrFAhJqJY8jYhKRWXUuHtkWo751ulvjdJ/aPY2oJbKz3OZi/qNwwJd+t8Zdk
         8mHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695913099; x=1696517899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7JeRqvmayjmhV4Z894X7Aad+1S2MFBLRFvn4wup2nM=;
        b=DqXevh0J2s9DlmgY0BcQPppiSVYjWNm5U9LfB/kO2R6hvJ7KXNFtDOzgW+HqHgCdAs
         2sVkW5FYxg2LxuKYLAXBQxEEExUi+aGH3AOKyj0f0/zvnIiChsy0TpmKqWrrihE+BvbR
         d7OywLXi5fXzvT2Q/uUQFVZmY1lzWI3KY+ry5Q2z2T4G3+Vk59Gt76Ak5K6In2YuTN7f
         //mUuWzjY5sIubDTyQ+pj6qDtp1yF84b4u5i9Npp4thbT9jwcbcXN5+Hu3P7DJKKlQOJ
         Gr5y3TaV+lkANKtTzQzezDyU3OTj0eIxnZXe+2wfwBQKUdOgZU4yFDIh1T67WRepKZ0I
         owdg==
X-Gm-Message-State: AOJu0YzvBb1hZJznSkuI1NoQLVKzY3XM2ChWzvGCn/lt+u1U/D6D4d9V
        absoHbLIrXeW+//sw+18eiqJVH3oDFUKliVlM44GTlOi
X-Google-Smtp-Source: AGHT+IH0+VJV+Eh8zm31745Cyq4JtL9nCW5bVOrjSsA43lW6R/eXbiOith7iB3hAhErAPSSay2WZbq0Efe4i9ImKjOs=
X-Received: by 2002:a2e:bc83:0:b0:2c0:7d6:1349 with SMTP id
 h3-20020a2ebc83000000b002c007d61349mr1125998ljf.0.1695913098642; Thu, 28 Sep
 2023 07:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230927192712.317799-1-trondmy@kernel.org>
In-Reply-To: <20230927192712.317799-1-trondmy@kernel.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 28 Sep 2023 10:58:06 -0400
Message-ID: <CAN-5tyF9rKdu0D-7nUFQtq1BWQABb+mdY3sLrDY1-sU_Q2p8fA@mail.gmail.com>
Subject: Re: [PATCH] SUNRPC: Don't retry using the same source port if
 connection failed
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Sep 27, 2023 at 3:35=E2=80=AFPM <trondmy@kernel.org> wrote:
>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> If the TCP connection attempt fails without ever establishing a
> connection, then assume the problem may be the server is rejecting us
> due to port reuse.

Doesn't this break 4.0 replay cache? Seems too general to assume that
any unsuccessful SYN was due to a server reboot and it's ok for the
client to change the port.

>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  net/sunrpc/xprtsock.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index 71848ab90d13..1a96777f0ed5 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -62,6 +62,7 @@
>  #include "sunrpc.h"
>
>  static void xs_close(struct rpc_xprt *xprt);
> +static void xs_reset_srcport(struct sock_xprt *transport);
>  static void xs_set_srcport(struct sock_xprt *transport, struct socket *s=
ock);
>  static void xs_tcp_set_socket_timeouts(struct rpc_xprt *xprt,
>                 struct socket *sock);
> @@ -1565,8 +1566,10 @@ static void xs_tcp_state_change(struct sock *sk)
>                 break;
>         case TCP_CLOSE:
>                 if (test_and_clear_bit(XPRT_SOCK_CONNECTING,
> -                                       &transport->sock_state))
> +                                      &transport->sock_state)) {
> +                       xs_reset_srcport(transport);
>                         xprt_clear_connecting(xprt);
> +               }
>                 clear_bit(XPRT_CLOSING, &xprt->state);
>                 /* Trigger the socket release */
>                 xs_run_error_worker(transport, XPRT_SOCK_WAKE_DISCONNECT)=
;
> @@ -1722,6 +1725,11 @@ static void xs_set_port(struct rpc_xprt *xprt, uns=
igned short port)
>         xs_update_peer_port(xprt);
>  }
>
> +static void xs_reset_srcport(struct sock_xprt *transport)
> +{
> +       transport->srcport =3D 0;
> +}
> +
>  static void xs_set_srcport(struct sock_xprt *transport, struct socket *s=
ock)
>  {
>         if (transport->srcport =3D=3D 0 && transport->xprt.reuseport)
> --
> 2.41.0
>
