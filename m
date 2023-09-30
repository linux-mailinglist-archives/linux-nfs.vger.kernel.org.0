Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0B97B447F
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Oct 2023 00:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjI3WhB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 Sep 2023 18:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjI3WhB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 Sep 2023 18:37:01 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B209FCF
        for <linux-nfs@vger.kernel.org>; Sat, 30 Sep 2023 15:36:58 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c18b0569b6so12468581fa.1
        for <linux-nfs@vger.kernel.org>; Sat, 30 Sep 2023 15:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1696113417; x=1696718217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jy8DN3Zlf3dOuVSr2y4SHxyHmlerLeAnaUPPAkN08E0=;
        b=e5B8dCAy3siJ74I0+8tpu5PwBB4wMcwohjbxetlTSrYkrcQpGUAieBw0lsfOunORYS
         Plzv8aMjd1bhYN2PB4GfwayrYHrwhGJwgiVjTe3OAnXrjY/ZObMFuopURMRTkLjwmf42
         w0VT5NkTOrQtpqoXOrcpl/2ThSf7ddrNqbiY5IYhXhTmigCTO2ICPTWYMf52BTq9yVBD
         qC5+d3LODuJMKsf9AscrAjK5l+eC3/wou4i6ucMxThqcC8LFSanH/MR1Hu6l8L8yMS13
         kgV/9wV768LWc4RYvN50iQr1ylFemNJLwYR9TNqxrdFn+sJAswck9kmnUhvy+/zVN3kS
         dNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696113417; x=1696718217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jy8DN3Zlf3dOuVSr2y4SHxyHmlerLeAnaUPPAkN08E0=;
        b=HJlX/lrzGJywrtVyjetcxILp8pqihMEcn660rt9mIcDcSTMh15nGif/jM/y87N/941
         tajjgabdt58XFHkYAFjlqU8ap87+iGsrZD1MjYYK6xv2nuSwPFHdZbCwBbMvdvKTciXE
         TwrDaEyDi2QGyfIN3vfqnW1NwMNS7EmmuilbUeepWliCiZ32ALpQd4U+1U72PsMr9Mzv
         9V61vKaMRzJQ6hoDdkaJ03XgB+E2FZ2r2FyI5E6pmrSiPIM+57hu9LzRGKvZ7DhqRrXO
         5gHqAabsgk2807wlYCQIFF8ihIXSQw3A51Y9kZty5BO1GEWREbbx2LjluRCZvuVy65FM
         vydQ==
X-Gm-Message-State: AOJu0YziwtjYHF+TtspImSGGTmepdavtvlK4X8Y16u7cdIpTxTlK1GPJ
        Ybgt7vHvBvVEhDY5ajq8kTB33cq3os9l/Q/1Enlmzvyk
X-Google-Smtp-Source: AGHT+IE6aQavGduXXXj0n8Cpm57lrPTkyk1MY1Yg+NnRlLnyMAjluaIJmB43pEEeCWx6NOsmcd9YUAM3+4CBJZZWsgk=
X-Received: by 2002:a2e:312:0:b0:2bf:f151:26ec with SMTP id
 18-20020a2e0312000000b002bff15126ecmr5098747ljd.0.1696113416581; Sat, 30 Sep
 2023 15:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230927192712.317799-1-trondmy@kernel.org> <CAN-5tyF9rKdu0D-7nUFQtq1BWQABb+mdY3sLrDY1-sU_Q2p8fA@mail.gmail.com>
 <c32aec7b2a8b226a1617ff9755b7b5ce64ad3114.camel@hammerspace.com>
In-Reply-To: <c32aec7b2a8b226a1617ff9755b7b5ce64ad3114.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Sat, 30 Sep 2023 18:36:45 -0400
Message-ID: <CAN-5tyE2_myhnzuf28gmm9ztJxb+g=fHS4wDVNE5D43BSandUA@mail.gmail.com>
Subject: Re: [PATCH] SUNRPC: Don't retry using the same source port if
 connection failed
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
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

On Fri, Sep 29, 2023 at 10:57=E2=80=AFPM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
> On Thu, 2023-09-28 at 10:58 -0400, Olga Kornievskaia wrote:
> > On Wed, Sep 27, 2023 at 3:35=E2=80=AFPM <trondmy@kernel.org> wrote:
> > >
> > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > >
> > > If the TCP connection attempt fails without ever establishing a
> > > connection, then assume the problem may be the server is rejecting
> > > us
> > > due to port reuse.
> >
> > Doesn't this break 4.0 replay cache? Seems too general to assume that
> > any unsuccessful SYN was due to a server reboot and it's ok for the
> > client to change the port.
>
> This is where things get interesting. Yes, if we change the port
> number, then it will almost certainly break NFSv3 and NFSv4.0 replay
> caching on the server.
>
> However the problem is that once we get stuck in the situation where we
> cannot connect, then each new connection attempt is just causing the
> server's TCP layer to push back and recall that the connection from
> this port was closed.
> IOW: the problem is that once we're in this situation, we cannot easily
> exit without doing one of the following. Either we have to
>
>    1. Change the port number, so that the TCP layer allows us to
>       connect.
>    2. Or.. Wait for long enough that the TCP layer has forgotten
>       altogether about the previous connection.
>
> The problem is that option (2) is subject to livelock, and so has a
> potential infinite time out. I've seen this livelock in action, and I'm
> not seeing a solution that has predictable results.
>
> So unless there is a solution for the problems in (2), I don't see how
> we can avoid defaulting to option (1) at some point, in which case the
> only question is "when do we switch ports?".

I'm not sure how one can justify that regression that will come out of
#1 will be less of a problem then the problem in #2.

I think I'm still not grasping why the NFS server would (legitimately)
be closing a connection that is re-using the port. Can you present a
sequence of events that would lead to this?

But can't we at least arm ourselves in not unnecessarily breaking the
reply cache by at least imposing some timeout/number of retries before
resetting? If the client was retrying to unsuccessfully re-establish
connection for a (fixed) while, then 4.0 client's lease would expire
and switching the port after the lease expires makes no difference.
There isn't a solution in v3 unfortunately. But a time-based approach
would at least separate these 'peculiar' servers vs normal servers.
And if this is a 4.1 client, we can reset the port without a timeout.

Am I correct that every unsuccessful SYN causes a new source point to
be taken? If so, then a server reboot where multiple SYNs are sent
prior to connection re-establishment (times number of mounts) might
cause source port exhaustion?


>
> >
> > >
> > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > ---
> > >  net/sunrpc/xprtsock.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> > > index 71848ab90d13..1a96777f0ed5 100644
> > > --- a/net/sunrpc/xprtsock.c
> > > +++ b/net/sunrpc/xprtsock.c
> > > @@ -62,6 +62,7 @@
> > >  #include "sunrpc.h"
> > >
> > >  static void xs_close(struct rpc_xprt *xprt);
> > > +static void xs_reset_srcport(struct sock_xprt *transport);
> > >  static void xs_set_srcport(struct sock_xprt *transport, struct
> > > socket *sock);
> > >  static void xs_tcp_set_socket_timeouts(struct rpc_xprt *xprt,
> > >                 struct socket *sock);
> > > @@ -1565,8 +1566,10 @@ static void xs_tcp_state_change(struct sock
> > > *sk)
> > >                 break;
> > >         case TCP_CLOSE:
> > >                 if (test_and_clear_bit(XPRT_SOCK_CONNECTING,
> > > -                                       &transport->sock_state))
> > > +                                      &transport->sock_state)) {
> > > +                       xs_reset_srcport(transport);
> > >                         xprt_clear_connecting(xprt);
> > > +               }
> > >                 clear_bit(XPRT_CLOSING, &xprt->state);
> > >                 /* Trigger the socket release */
> > >                 xs_run_error_worker(transport,
> > > XPRT_SOCK_WAKE_DISCONNECT);
> > > @@ -1722,6 +1725,11 @@ static void xs_set_port(struct rpc_xprt
> > > *xprt, unsigned short port)
> > >         xs_update_peer_port(xprt);
> > >  }
> > >
> > > +static void xs_reset_srcport(struct sock_xprt *transport)
> > > +{
> > > +       transport->srcport =3D 0;
> > > +}
> > > +
> > >  static void xs_set_srcport(struct sock_xprt *transport, struct
> > > socket *sock)
> > >  {
> > >         if (transport->srcport =3D=3D 0 && transport->xprt.reuseport)
> > > --
> > > 2.41.0
> > >
>
> --
> Trond Myklebust Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
