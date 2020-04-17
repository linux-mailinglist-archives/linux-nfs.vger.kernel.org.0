Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F7F1AE166
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2020 17:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgDQPn3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Apr 2020 11:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729086AbgDQPn3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Apr 2020 11:43:29 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D635AC061A0C
        for <linux-nfs@vger.kernel.org>; Fri, 17 Apr 2020 08:43:28 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x18so3609691wrq.2
        for <linux-nfs@vger.kernel.org>; Fri, 17 Apr 2020 08:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v3xzyMRLzQ4kvVBTBmdEztmFOFtPIyRr/FaZT8KNOfc=;
        b=G4bf5QSwwf1nEpNgm1wS3yuv+OeIIxaBGJxnqxkc1tjQTm1J5zoDRs8ruRqvkR6PUo
         bysrqGgwyAcKNAxn5AdKWpyj4qwP4w7i7sWNZWKpQExqae9J9xxg+SvPnxL/J5BM11TZ
         4aGI4JAOyQNjl2X+r0xa83tDSazUxyB8Z6yS+4p+Bz/uLwyTjD/sn8tON9fPHEFYj5KI
         paMoTt8QbJoFXD6bd7kxUiZfBkItw87ZEFin/9wIqNC/4JeXRL1RKF7geCdlRjjI6FO6
         2RGdYsK3Rq2eumh4xJG9b12aCfHjneo8zgsPjjC3ht2BgJ8ZGDqBxoh3LM4I1udv2LK4
         Me4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v3xzyMRLzQ4kvVBTBmdEztmFOFtPIyRr/FaZT8KNOfc=;
        b=oBCTYgfkqkH976m8oeLUoo2eVcsq7aLJ2ykcUJ4pNjdFQPTX/TTFTnLT8smeIWxdE9
         MbdrsYFJJipCvnjEkZj73ekNNWJ/1oTueX0i3c/DNF6e95c2Gs7msoBLlgjkXPqFtJhE
         HcbHdoPRnK06zEECKK3Ze8UKBRxBlbqajPvtaEhGIgLVRySep60+xsrvs7DvEmQAfG5g
         pIM5tlmJlaNnmDigWC2x2bRdwOow4DbGbIlMk4XW42oSuskE6rXEPROZi2cniKSP0d2B
         WQibcTZsZMAjbrcNIeGOtandqrKCfCo9DdrUyAtEDKnSnHIRAnom+kFnZXx89rthFEcA
         4tAA==
X-Gm-Message-State: AGi0PuaI+bFwoBLQLgzQfwaZK4TC5niLY4FG6HKdAGSykUXAj+ifGHyX
        VT4qSkLzrUd50wPXg48LdKMiKuhmytE2vAsdpJw=
X-Google-Smtp-Source: APiQypI/Jm5o53xl5nkfKcQTjRmvqSQjxIBxVoVxDWJnrc02Egw0sZyYP9j6/hRAHtpFeIlcZlYuJjD8qe2CjGO9iKA=
X-Received: by 2002:adf:ce0a:: with SMTP id p10mr4388473wrn.89.1587138207420;
 Fri, 17 Apr 2020 08:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200417151540.22111-1-olga.kornievskaia@gmail.com> <9c6c72708f360f543e2b8caaf56cc074aa825c96.camel@hammerspace.com>
In-Reply-To: <9c6c72708f360f543e2b8caaf56cc074aa825c96.camel@hammerspace.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Fri, 17 Apr 2020 11:43:16 -0400
Message-ID: <CAN-5tyHQ_Gs-HmWLdbQYz1o8UyB2jv_oD2EtJP94qgtrfeK52Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.1: fix lone sequence transport assignment
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

On Fri, Apr 17, 2020 at 11:31 AM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
> Hi Olga,
>
> On Fri, 2020-04-17 at 11:15 -0400, Olga Kornievskaia wrote:
> > When nconnect is used, SEQUENCE operation currently isn't bound to
> > a particular transport. The problem is created on an idle mount,
> > where SEQUENCE is the only operation being sent and opened TPC
> > connections are slowly being close from the lack of use. If SEQUENCE
> > is not assigned to the main connection, the main connection can
> > be closed and with that so is the back channel bound to that
> > connection.
> >
> > Since the only way client handles callback_path down is by sending
> > BIND_CONN_TO_SESSION requesting to bind both backchannel and fore
> > channel on the connection that was left going, but that connection
> > was already bound to only forechannel. According to the spec, it's
> > not allowed to change channel binding after they are done.
> >
> > The fix is to make sure that a lone SEQUENCE always goes on the
> > main connection, keeping backchannel alive.
> >
> > Fixes: 5a0c257f8 ("NFS: send state management on a single
> > connection")
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  fs/nfs/nfs4proc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 99e9f2e..461f85d 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -8857,7 +8857,7 @@ static struct rpc_task
> > *_nfs41_proc_sequence(struct nfs_client *clp,
> >               .rpc_client = clp->cl_rpcclient,
> >               .rpc_message = &msg,
> >               .callback_ops = &nfs41_sequence_ops,
> > -             .flags = RPC_TASK_ASYNC | RPC_TASK_TIMEOUT,
> > +             .flags = RPC_TASK_ASYNC | RPC_TASK_TIMEOUT |
> > RPC_TASK_NO_ROUND_ROBIN,
> >       };
> >       struct rpc_task *ret;
> >
>
> This works only in the case where the client is only sending SEQUENCE
> instructions. There are other cases where it could be sending out other
> operations that also renew the lease, but is doing it very
> infrequently. Won't that also run into the same problem?

Hm... I see so main channel can still go idle and close, when
infrequent operations are happening on the other connections before
round-robin-ing to the main connection....

> Is the fundamental problem here that we're not handling the
> SEQ4_STATUS_CB_PATH_DOWN / SEQ4_STATUS_CB_PATH_DOWN_SESSION flags
> correctly or is there something else going on?

Yes the client doesn't recover properly. But the fix wasn't trivial to
me (so I thought my patch was enough but I see it's not). Say client
shuts down the main connection because it was idle. Now whatever
operations goes on a different connection is going to get callback
down. The only way the client can create a new backchannel (according
to the spec) is if it creates a brand new connection and sends
BIND_CONN_TO_SESSION there (all existing connections are already bound
to fore channel and according to the spec you can't modify the
existing binding). But then we'd need to make sure that it's the first
one in the list of connections we iterate thru (as i think 1st marks
the main connection?) as the other operations that supposed to only go
on main connection need to know which connection to pick.

The reason it's not seen against linux is because it doesn't follow
the spec is doesn't reject attempts to bind a backchannel to an
already existing connection that was only bound for fore channel.

>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
