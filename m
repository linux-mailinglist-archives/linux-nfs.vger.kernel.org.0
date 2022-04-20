Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F3A509161
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Apr 2022 22:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382089AbiDTU1Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Apr 2022 16:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382074AbiDTU1Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Apr 2022 16:27:24 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588972E9D2
        for <linux-nfs@vger.kernel.org>; Wed, 20 Apr 2022 13:24:37 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ks6so5907253ejb.1
        for <linux-nfs@vger.kernel.org>; Wed, 20 Apr 2022 13:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aDj7aYEYa2vJUFuP9nlqXX8kfJ374HuHj2wYUbcBlvI=;
        b=WkD+iFnE2kRRwMVRKZJAH4roXztM/yIU4OD0QyUVYjbCN+JQw3GPBLl68vaYQ4k86h
         M8onw6ObgaU0KM1t0eVumew/9W3X7VB6/u98l6Xr3JqYNLXGjbIzlotCKcMHTMIn+L0M
         oKOL9InDdwAjCg00YS9Gm8sNHKbJwnxLpFdAVrbnfU3mepIi8ctB/feo3pBU8cbDsKxA
         ucNtQTLu2n8EKl2w1xkTAx+ThGm/NBBZFthAPCGygvdmi6F7hY/wr+o73l/fzqqeFWpC
         AOZD5QQLUjHdrFgezYi5PkSiedQ98pRArHIl75c91CYPCC6FVT656R3V7/Rh/p4iGDIb
         qpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aDj7aYEYa2vJUFuP9nlqXX8kfJ374HuHj2wYUbcBlvI=;
        b=CGCZeqpu3utx6CwYSIEOnR+7syosNcF7hmpOD0AjkGk8lCofUYADMjzFwpDxEE4IAQ
         Ii+6QGTcirQxLbYBACUmFwF7AxRx4yswvESUdImXdmWBDuU3yDBFYSTarreW+XO+ODVN
         okJbHR2lWi4gGVMbeiNpinC/1YCLAxkaiB4T5FAz1XjNzzrYdzxxY1BOzIG6D/f12ve/
         DpkZAHYR7/wUlQeo4QlTaMOQuFYu0SkrJ2hY9C6NqUwiXW4SEDVrGYsyga7WK0tBvmpt
         /x9xS9bnXO/zTU531QQcsjnmQS9WG8Fkn5wQEJssWrhGip0i1OddRvHALUFWKQJDAFzU
         +7UA==
X-Gm-Message-State: AOAM532S84L214YJHYgg7rFCrRrzPN0Uj7SSbBK20PEAgt5YC1hCF2Jj
        O1d0zB/iDp5MkRou4GXV10BlIwVr9TEIlLr25rJLyYTR
X-Google-Smtp-Source: ABdhPJygLxEmWCA+rt86V2aLYzNwhWzspyjAJMi0Ayfsihbr6n9gVsakTxskpByuwP4SuMAXP/hQykacRYvuexwIWHM=
X-Received: by 2002:a17:906:c110:b0:6e8:3a96:996a with SMTP id
 do16-20020a170906c11000b006e83a96996amr19969040ejc.216.1650486275666; Wed, 20
 Apr 2022 13:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220420182121.87341-1-olga.kornievskaia@gmail.com> <95d95ddaa7c2d15cbd291f56e053083282ca755f.camel@hammerspace.com>
In-Reply-To: <95d95ddaa7c2d15cbd291f56e053083282ca755f.camel@hammerspace.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 20 Apr 2022 16:24:24 -0400
Message-ID: <CAN-5tyHOgQRGojZLOTZnY1_M6nDHpWk_ctne=+Nq0t8aEqvPLw@mail.gmail.com>
Subject: Re: [PATCH 1/1] SUNRPC release the transport of a relocated task with
 an assigned transport
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Apr 20, 2022 at 2:41 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Wed, 2022-04-20 at 14:21 -0400, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > A relocated task must release its previous transport.
> >
> > Fixes: 82ee41b85cef1 ("SUNRPC don't resend a task on an offlined
> > transport")
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  net/sunrpc/clnt.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> > index af0174d7ce5a..95de454a858b 100644
> > --- a/net/sunrpc/clnt.c
> > +++ b/net/sunrpc/clnt.c
> > @@ -1067,8 +1067,10 @@ void rpc_task_set_transport(struct rpc_task
> > *task, struct rpc_clnt *clnt)
> >  {
> >         if (task->tk_xprt &&
> >                         !(test_bit(XPRT_OFFLINE, &task->tk_xprt-
> > >state) &&
> > -                        (task->tk_flags & RPC_TASK_MOVEABLE)))
> > +                       (task->tk_flags & RPC_TASK_MOVEABLE))) {
> > +                       xprt_release_write(task->tk_xprt, task);
> >                 return;
> > +       }
> >         if (task->tk_flags & RPC_TASK_NO_ROUND_ROBIN)
> >                 task->tk_xprt = rpc_task_get_first_xprt(clnt);
> >         else
>
>
> I don't think this patch is correct. It is changing the case where
> we're not changing the value of task->tk_xprt, which was never a
> problem before commit 82ee41b85cef.
>
> What needs to change is the case where task->tk_xprt is set, but we're
> going to change its value anyway because of the tests for XPRT_OFFLINE
> and RPC_TASK_MOVEABLE.
> In that case we need to call xprt_release(), followed by xprt_put().
> Otherwise we're leaking slots, locks and references to the old task-
> >tk_xprt.

Thank you Trond. It is indeed incorrect. I've sent v2.
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
