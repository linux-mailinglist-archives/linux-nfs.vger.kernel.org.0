Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B342E1AE276
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2020 18:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgDQQrL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Apr 2020 12:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgDQQrL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Apr 2020 12:47:11 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88A4C061A0C
        for <linux-nfs@vger.kernel.org>; Fri, 17 Apr 2020 09:47:10 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u127so2602949wmg.1
        for <linux-nfs@vger.kernel.org>; Fri, 17 Apr 2020 09:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cUliEBi+ERFAFP46IFgCR44yakpNosHPlLMv4V9Zq0o=;
        b=XkW+g8uJ9yfAZkuRa67S40V7TNJ84Ams9c/2NJ11hpxzEcRvibV3zGjDVadlbDtmjH
         QF9m6ddNc/vnKrDGFYvmsxrPExVyKHO/TogeaevQHxLncC3DbS3z45nUhlu2xX7ykqZJ
         XYJHjJBckylgsYroC1D/Io8281XSMoiMWa9zmCzF7ysA3s8IAWPxirX+n33FdZMBlKHc
         amIxICsZvoC2xD/ELF7K5ijrE7aeNlnPpa307LxV6V1pBELplAMnQq8bIoiPUM5meBFn
         I0dvQUZWdJrr1manl5TPyeTs1dXMW0hYqXPBYHapi1aVzfnNawnhqW+8KBXUPAD79jQW
         nMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cUliEBi+ERFAFP46IFgCR44yakpNosHPlLMv4V9Zq0o=;
        b=etxxXyuyyC8pLfQ1L2I1k8SKjOcNew4lJccQkgVzGF246N8oX2oNe6544eO6ErEkxB
         oZEg0koBtnDsucLl8cVYAYpGmps79bXxtZbBk+1uB9hdSDYta/0uFp2RwWG6J1/d0HO1
         RwcwXhrpdrOiK5ktvPI0jh+OzmJdYmqxczP5x7+J9p7/8R+YaQfL3wpt20OnqgLn8fM1
         a2ipIc23SFAliDBrI1Gj9+GyPS1XIX9bnFs18lCYTGAyh7oLZQh89sKPYFjdStfIfJO0
         S2Xl+RRC3MO0kWO0G27uWWL0QSlO8V46KI5SFsVzwpU1EjMZfkEIRPW9Hptn5f8xN5kX
         lWVg==
X-Gm-Message-State: AGi0PuZbE9RQO25r+bY6J7Sv86i8uUpSdORZACGpMHIsYcrIGANlA9Hx
        imj9WXtLGhkPUkmiWpYuOYhv2Z1uU13Ctu2C0iBojA==
X-Google-Smtp-Source: APiQypIIgytwUJM3V4kzv4HPONCZBbnuF8nZtsncWqOmCOxozA+s9L572kvK7s4zaRmEUWURd/L83qo+Dm2B8669/VY=
X-Received: by 2002:a1c:dc0a:: with SMTP id t10mr4108434wmg.113.1587142029368;
 Fri, 17 Apr 2020 09:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200417151540.22111-1-olga.kornievskaia@gmail.com>
 <9c6c72708f360f543e2b8caaf56cc074aa825c96.camel@hammerspace.com>
 <CAN-5tyHQ_Gs-HmWLdbQYz1o8UyB2jv_oD2EtJP94qgtrfeK52Q@mail.gmail.com> <7dd1b9300d2a0ec1a31fb3879c62a94f535ccad5.camel@hammerspace.com>
In-Reply-To: <7dd1b9300d2a0ec1a31fb3879c62a94f535ccad5.camel@hammerspace.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Fri, 17 Apr 2020 12:46:58 -0400
Message-ID: <CAN-5tyEbi8Z8bxU1enkkhjAyJj-nb9=j33xcLi7FE2+A79-qng@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.1: fix lone sequence transport assignment
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Apr 17, 2020 at 12:20 PM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
> On Fri, 2020-04-17 at 11:43 -0400, Olga Kornievskaia wrote:
> > Hi Trond,
> >
> > On Fri, Apr 17, 2020 at 11:31 AM Trond Myklebust
> > <trondmy@hammerspace.com> wrote:
> > > Hi Olga,
> > >
> > > On Fri, 2020-04-17 at 11:15 -0400, Olga Kornievskaia wrote:
> > > > When nconnect is used, SEQUENCE operation currently isn't bound
> > > > to
> > > > a particular transport. The problem is created on an idle mount,
> > > > where SEQUENCE is the only operation being sent and opened TPC
> > > > connections are slowly being close from the lack of use. If
> > > > SEQUENCE
> > > > is not assigned to the main connection, the main connection can
> > > > be closed and with that so is the back channel bound to that
> > > > connection.
> > > >
> > > > Since the only way client handles callback_path down is by
> > > > sending
> > > > BIND_CONN_TO_SESSION requesting to bind both backchannel and fore
> > > > channel on the connection that was left going, but that
> > > > connection
> > > > was already bound to only forechannel. According to the spec,
> > > > it's
> > > > not allowed to change channel binding after they are done.
> > > >
> > > > The fix is to make sure that a lone SEQUENCE always goes on the
> > > > main connection, keeping backchannel alive.
> > > >
> > > > Fixes: 5a0c257f8 ("NFS: send state management on a single
> > > > connection")
> > > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > > ---
> > > >  fs/nfs/nfs4proc.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > > > index 99e9f2e..461f85d 100644
> > > > --- a/fs/nfs/nfs4proc.c
> > > > +++ b/fs/nfs/nfs4proc.c
> > > > @@ -8857,7 +8857,7 @@ static struct rpc_task
> > > > *_nfs41_proc_sequence(struct nfs_client *clp,
> > > >               .rpc_client = clp->cl_rpcclient,
> > > >               .rpc_message = &msg,
> > > >               .callback_ops = &nfs41_sequence_ops,
> > > > -             .flags = RPC_TASK_ASYNC | RPC_TASK_TIMEOUT,
> > > > +             .flags = RPC_TASK_ASYNC | RPC_TASK_TIMEOUT |
> > > > RPC_TASK_NO_ROUND_ROBIN,
> > > >       };
> > > >       struct rpc_task *ret;
> > > >
> > >
> > > This works only in the case where the client is only sending
> > > SEQUENCE
> > > instructions. There are other cases where it could be sending out
> > > other
> > > operations that also renew the lease, but is doing it very
> > > infrequently. Won't that also run into the same problem?
> >
> > Hm... I see so main channel can still go idle and close, when
> > infrequent operations are happening on the other connections before
> > round-robin-ing to the main connection....
> >
> > > Is the fundamental problem here that we're not handling the
> > > SEQ4_STATUS_CB_PATH_DOWN / SEQ4_STATUS_CB_PATH_DOWN_SESSION flags
> > > correctly or is there something else going on?
> >
> > Yes the client doesn't recover properly. But the fix wasn't trivial
> > to
> > me (so I thought my patch was enough but I see it's not). Say client
> > shuts down the main connection because it was idle. Now whatever
> > operations goes on a different connection is going to get callback
> > down. The only way the client can create a new backchannel (according
> > to the spec) is if it creates a brand new connection and sends
> > BIND_CONN_TO_SESSION there (all existing connections are already
> > bound
> > to fore channel and according to the spec you can't modify the
> > existing binding). But then we'd need to make sure that it's the
> > first
> > one in the list of connections we iterate thru (as i think 1st marks
> > the main connection?) as the other operations that supposed to only
> > go
> > on main connection need to know which connection to pick.
> >
> > The reason it's not seen against linux is because it doesn't follow
> > the spec is doesn't reject attempts to bind a backchannel to an
> > already existing connection that was only bound for fore channel.
> >
>
> Oh, I see. So the server is replying NFS4ERR_INVAL in order to let the
> client know that it is trying to change the channel bindings for that
> connection.

Well server isn't failing because client is asking for FORE_OR_BOTH
and it's a choice so server is returning FORE. I'm not sure we can ask
the server to fail the request with ERR_INVAL.... (rather I can ask
but ) rather can we expect the server to do that always?

> Hmm... Is there any reason why we can't just add a handler to
> nfs4_bind_one_conn_to_session_done() that intercepts NFS4ERR_INVAL, and
> disconnects the xprt before retrying?
> We should probably add a wrapper to xprt_force_disconnect() in
> include/linux/sunrpc/clnt.h. Something like the following?
>
>
> static inline void rpc_task_close_connection(struct rpc_task *task)
> {
>         if (task->tk_xprt)
>                 xprt_force_disconnect(task->tk_xprt);
> }
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
