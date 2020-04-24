Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9AF1B818C
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Apr 2020 23:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgDXVLF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Apr 2020 17:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgDXVLE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Apr 2020 17:11:04 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694E1C09B048
        for <linux-nfs@vger.kernel.org>; Fri, 24 Apr 2020 14:11:04 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id s9so8639601eju.1
        for <linux-nfs@vger.kernel.org>; Fri, 24 Apr 2020 14:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4/D2zdPf99vrTJ4uFR30Ols65ZCca0DjGA0eDtjB8KU=;
        b=hCIRlemMmJAy43AUxj8OyeUWSlmRXCFTErNqd82Fmj1yB6uqFfK0S4rupgDTo0YR8H
         27U8A6hpS+KBnb+fXB36oiZAoN4jBB22CskNOqpuq8Sqiy8ehg4h2hyo/EaR+/l4c7Ly
         8zMdF6i4L1Z6z0xkag9i8C8BcEv2SyMB40tetNlLFf+WtIdoqDHxKFIpmSbkPXdMB9mJ
         YA7c05pxb7yJsjVrJYCTlmx3+XLVr9sKU01M+4ZaPqtWacSu0n+N7Z9+y506ajiWY8Yu
         +1g6YCvsTrFeHy2vHrdbCuHzYZZEh73coqOnAQa87uBtb1GlZaBCSRvB1ifKgoM8zqbm
         PKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4/D2zdPf99vrTJ4uFR30Ols65ZCca0DjGA0eDtjB8KU=;
        b=UspC6iIWZSCqZDXGsYpef0TB9vZ4plhH5JxUMwFB7l/slGF2Tg21abI0AQCnWNbUu2
         kVGC5pBydh+BSBHUleADm30zxOWZwaFWpqVki+37PGm163qT19BqIKcV0MTn+x66/gAF
         3L6o9OjzahAXmD1wyxgauEu+qF+3aVPI4EkkTRyB6EyUv++Mypfopzf08siH33XUuo1R
         ASM9wQkkgWoAQVR7JIfXghuSreeNUh0P+F4JVUd9Ih8ifkgk6cGcEu/valyNM0diQ8GU
         eeaZ1sRLChSd0wf6dY45bDOWpxZSgFP41AhoM03pDGxTnMNk60e5uKWB7mB64kW3S/Dm
         CvDA==
X-Gm-Message-State: AGi0PuYnnk06lM9BNcZvTMe7C+OShPlZxDhj0uGybgiLSidAEI+IICz1
        XjZzjQDPbN+ukE7WdjEuH/s5QMYXrRA1l4hxDxw=
X-Google-Smtp-Source: APiQypJbpQYPtArMKnQpiBAmFsuJ3F3lj5a/32+vqtS1Kl1/LklCYoKJbNhPtj1UsWxB+QpGzFTvAj8+/S12J6vYw6k=
X-Received: by 2002:a17:906:ad9a:: with SMTP id la26mr8997347ejb.128.1587762661928;
 Fri, 24 Apr 2020 14:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200424190856.30292-1-olga.kornievskaia@gmail.com> <dc483bc0dea9eab6b3fab1568fd18f710c818b39.camel@hammerspace.com>
In-Reply-To: <dc483bc0dea9eab6b3fab1568fd18f710c818b39.camel@hammerspace.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Fri, 24 Apr 2020 17:10:50 -0400
Message-ID: <CAN-5tyG3OeRevMzLEBxOiFSOjxxL-GWvDGrDNh6ieCmu10KpUw@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.1: fix handling of backchannel binding in BIND_CONN_TO_SESSION
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Apr 24, 2020 at 4:51 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> Hi Olga
>
> On Fri, 2020-04-24 at 15:08 -0400, Olga Kornievskaia wrote:
> > Currently, if the client sends BIND_CONN_TO_SESSION with
> > NFS4_CDFC4_FORE_OR_BOTH but only gets NFS4_CDFS4_FORE back it ignores
> > that it wasn't able to enable a backchannel.
> >
> > To make sure, the client sends BIND_CONN_TO_SESSION as the first
> > operation on the connections (ie., no other session compounds haven't
> > been sent before), and if the client's request to bind the
> > backchannel
> > is not satisfied, then reset the connection and retry.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  fs/nfs/nfs4proc.c           | 6 ++++++
> >  include/linux/sunrpc/clnt.h | 5 +++++
> >  2 files changed, 11 insertions(+)
> >
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 512afb1..69a5487 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -7891,6 +7891,7 @@ static int nfs4_check_cl_exchange_flags(u32
> > flags)
> >  nfs4_bind_one_conn_to_session_done(struct rpc_task *task, void
> > *calldata)
> >  {
> >       struct nfs41_bind_conn_to_session_args *args = task-
> > >tk_msg.rpc_argp;
> > +     struct nfs41_bind_conn_to_session_res *res = task-
> > >tk_msg.rpc_resp;
> >       struct nfs_client *clp = args->client;
> >
> >       switch (task->tk_status) {
> > @@ -7899,6 +7900,11 @@ static int nfs4_check_cl_exchange_flags(u32
> > flags)
> >               nfs4_schedule_session_recovery(clp->cl_session,
> >                               task->tk_status);
> >       }
> > +     if (args->dir == NFS4_CDFC4_FORE_OR_BOTH &&
> > +                     res->dir != NFS4_CDFS4_BOTH) {
> > +             rpc_task_close_connection(task);
> > +             task->tk_status = -NFS4ERR_DELAY;
>
> We don't have any error handling for NFS4ERR_DELAY in this function, so
> if your intention is to replay the RPC call, then maybe you want to
> replace this line with a call to rpc_restart_call()?

What happens is nfs4_proc_bind_conn_to_session() is errored with
ERR_DELAY which goes back into nfs4state.c which has a case for
ERR_DELAY which resets the bit and does the call again. But I can try
the rpc_restart_call().

> However it would be good to ensure that we only do this once or twice
> so that we don't loop forever. Maybe also add a variable to the struct
> nfs41_bind_conn_to_session_args that can set the number of retries
> remaining?

If I recode using rpc_restart_call, then I can add something to the
args. Otherwise, number of retries would need to be handled some other
way that I'd need to think of.

Thank you for all the help.

>
> > +     }
> >  }
> >
> >  static const struct rpc_call_ops nfs4_bind_one_conn_to_session_ops =
> > {
> > diff --git a/include/linux/sunrpc/clnt.h
> > b/include/linux/sunrpc/clnt.h
> > index ca7e108..cc20a08 100644
> > --- a/include/linux/sunrpc/clnt.h
> > +++ b/include/linux/sunrpc/clnt.h
> > @@ -236,4 +236,9 @@ static inline int rpc_reply_expected(struct
> > rpc_task *task)
> >               (task->tk_msg.rpc_proc->p_decode != NULL);
> >  }
> >
> > +static inline void rpc_task_close_connection(struct rpc_task *task)
> > +{
> > +     if (task->tk_xprt)
> > +             xprt_force_disconnect(task->tk_xprt);
> > +}
> >  #endif /* _LINUX_SUNRPC_CLNT_H */
>
> Thanks
>   Trond
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
