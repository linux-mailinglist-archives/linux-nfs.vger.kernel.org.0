Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A291AE571
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2020 21:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgDQTGm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Apr 2020 15:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbgDQTGl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Apr 2020 15:06:41 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D65BC061A0C
        for <linux-nfs@vger.kernel.org>; Fri, 17 Apr 2020 12:06:41 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k11so4278247wrp.5
        for <linux-nfs@vger.kernel.org>; Fri, 17 Apr 2020 12:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/Me2JTiV6ixHaW65r0VrfnP6vhpwLshDhGNXkNuO00=;
        b=lV+HRA3XQNFrYxQCYKXyhIwrlT4fWIevrJmlrYen29HbxDv2RSfWQbAg3DFzMZfwAm
         Ai9IjcL8dMi2u8NJGvj/lcQNt5wdCKRP8mkcLfBdlwxhmDhRs4IRpgRjSpkG+H3Qp7IG
         wHAaQfvxZoB3mc16AbfYeBGra5ItST6kt3ndXGk+LF/asvGYBpXDrVR/kXdFo2WDWCpR
         ojTnEERF7ACFv41hkgyzE8rfQbr7Sc5J5OcnhF4an7xp2FMDl9OuSeDNDN7U2mvpux7A
         4V5Q4ffE7EdAz14COoj+volbGTjwYC+E2oeW87B+fFMxCKj7gjF90bwYZCbm5M+1Le+J
         RZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/Me2JTiV6ixHaW65r0VrfnP6vhpwLshDhGNXkNuO00=;
        b=rotyiwGra90El9Em3XbL/j5enekxp5b9AzAgK6X5CfZZu8mcdNVu/kMpEldSHHmkWN
         CyJUhEWo4xoxtZENp2343c9qnAcrg32nDWuuTf8omxz8wpzKBnhbrNzfC6uy3l5vL3i4
         HvrnukMdtVcXDyNpXFzPdfJSvMvF32jYhqKcwndCqkR+utXfGr99rWEnooZAs/SYvBlu
         E6Ad1Vog7Wv5/76fw/Q5Pg39DbW96XSyh/V1Q+ecXprDFPxArLX7Ym0cfKrLJ2Vv1Wkx
         oyG10u7/SsTHKYR5Zr+/s6m/T+SZ87Ohy4BVGhez8PrR8BH4aCVhA5xqgkfQZc0jzja8
         iQyw==
X-Gm-Message-State: AGi0PuYPA7xOlM05hJ6/Od2GZzxLV7t/5yJL6UWePzdlau/9jla8FROR
        gXHuRG7XcxkbZsZtcDZ4d/xCtkUTRsiTyJnisNY=
X-Google-Smtp-Source: APiQypJ6ytE03eRYaiNj2N8HbKZvpgj9X6xAnV6vAbhxb6kePMR5cI8vgTVgyvneGYbCllqK+IZsV2qNlCZ0szeFsWI=
X-Received: by 2002:adf:ce0a:: with SMTP id p10mr5224673wrn.89.1587150400085;
 Fri, 17 Apr 2020 12:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200417151540.22111-1-olga.kornievskaia@gmail.com>
 <9c6c72708f360f543e2b8caaf56cc074aa825c96.camel@hammerspace.com>
 <CAN-5tyHQ_Gs-HmWLdbQYz1o8UyB2jv_oD2EtJP94qgtrfeK52Q@mail.gmail.com>
 <7dd1b9300d2a0ec1a31fb3879c62a94f535ccad5.camel@hammerspace.com>
 <CAN-5tyEbi8Z8bxU1enkkhjAyJj-nb9=j33xcLi7FE2+A79-qng@mail.gmail.com>
 <52b65780986192bb635638d4615176bbc1ad579c.camel@hammerspace.com>
 <CAN-5tyFrhwVjtDcz0X5GRysief=CTrpUsFWi_ByT2=k6LVtJXw@mail.gmail.com> <e609a66be315e5c8e663727147dd5da0d25c11bb.camel@hammerspace.com>
In-Reply-To: <e609a66be315e5c8e663727147dd5da0d25c11bb.camel@hammerspace.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Fri, 17 Apr 2020 15:06:28 -0400
Message-ID: <CAN-5tyE3uRJ+wCnSmZD6zCedHBB0waBKn6oqDvOLoeX=BJGVqg@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.1: fix lone sequence transport assignment
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Apr 17, 2020 at 2:41 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Fri, 2020-04-17 at 14:08 -0400, Olga Kornievskaia wrote:
> > On Fri, Apr 17, 2020 at 12:53 PM Trond Myklebust
> > <trondmy@hammerspace.com> wrote:
> > > On Fri, 2020-04-17 at 12:46 -0400, Olga Kornievskaia wrote:
> > > > On Fri, Apr 17, 2020 at 12:20 PM Trond Myklebust
> > > > <trondmy@hammerspace.com> wrote:
> > > > > On Fri, 2020-04-17 at 11:43 -0400, Olga Kornievskaia wrote:
> > > > > > Hi Trond,
> > > > > >
> > > > > > On Fri, Apr 17, 2020 at 11:31 AM Trond Myklebust
> > > > > > <trondmy@hammerspace.com> wrote:
> > > > > > > Hi Olga,
> > > > > > >
> > > > > > > On Fri, 2020-04-17 at 11:15 -0400, Olga Kornievskaia wrote:
> > > > > > > > When nconnect is used, SEQUENCE operation currently isn't
> > > > > > > > bound
> > > > > > > > to
> > > > > > > > a particular transport. The problem is created on an idle
> > > > > > > > mount,
> > > > > > > > where SEQUENCE is the only operation being sent and
> > > > > > > > opened
> > > > > > > > TPC
> > > > > > > > connections are slowly being close from the lack of use.
> > > > > > > > If
> > > > > > > > SEQUENCE
> > > > > > > > is not assigned to the main connection, the main
> > > > > > > > connection
> > > > > > > > can
> > > > > > > > be closed and with that so is the back channel bound to
> > > > > > > > that
> > > > > > > > connection.
> > > > > > > >
> > > > > > > > Since the only way client handles callback_path down is
> > > > > > > > by
> > > > > > > > sending
> > > > > > > > BIND_CONN_TO_SESSION requesting to bind both backchannel
> > > > > > > > and
> > > > > > > > fore
> > > > > > > > channel on the connection that was left going, but that
> > > > > > > > connection
> > > > > > > > was already bound to only forechannel. According to the
> > > > > > > > spec,
> > > > > > > > it's
> > > > > > > > not allowed to change channel binding after they are
> > > > > > > > done.
> > > > > > > >
> > > > > > > > The fix is to make sure that a lone SEQUENCE always goes
> > > > > > > > on
> > > > > > > > the
> > > > > > > > main connection, keeping backchannel alive.
> > > > > > > >
> > > > > > > > Fixes: 5a0c257f8 ("NFS: send state management on a single
> > > > > > > > connection")
> > > > > > > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > > > > > > ---
> > > > > > > >  fs/nfs/nfs4proc.c | 2 +-
> > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > > > > > > > index 99e9f2e..461f85d 100644
> > > > > > > > --- a/fs/nfs/nfs4proc.c
> > > > > > > > +++ b/fs/nfs/nfs4proc.c
> > > > > > > > @@ -8857,7 +8857,7 @@ static struct rpc_task
> > > > > > > > *_nfs41_proc_sequence(struct nfs_client *clp,
> > > > > > > >               .rpc_client = clp->cl_rpcclient,
> > > > > > > >               .rpc_message = &msg,
> > > > > > > >               .callback_ops = &nfs41_sequence_ops,
> > > > > > > > -             .flags = RPC_TASK_ASYNC | RPC_TASK_TIMEOUT,
> > > > > > > > +             .flags = RPC_TASK_ASYNC | RPC_TASK_TIMEOUT
> > > > > > > > |
> > > > > > > > RPC_TASK_NO_ROUND_ROBIN,
> > > > > > > >       };
> > > > > > > >       struct rpc_task *ret;
> > > > > > > >
> > > > > > >
> > > > > > > This works only in the case where the client is only
> > > > > > > sending
> > > > > > > SEQUENCE
> > > > > > > instructions. There are other cases where it could be
> > > > > > > sending
> > > > > > > out
> > > > > > > other
> > > > > > > operations that also renew the lease, but is doing it very
> > > > > > > infrequently. Won't that also run into the same problem?
> > > > > >
> > > > > > Hm... I see so main channel can still go idle and close, when
> > > > > > infrequent operations are happening on the other connections
> > > > > > before
> > > > > > round-robin-ing to the main connection....
> > > > > >
> > > > > > > Is the fundamental problem here that we're not handling the
> > > > > > > SEQ4_STATUS_CB_PATH_DOWN / SEQ4_STATUS_CB_PATH_DOWN_SESSION
> > > > > > > flags
> > > > > > > correctly or is there something else going on?
> > > > > >
> > > > > > Yes the client doesn't recover properly. But the fix wasn't
> > > > > > trivial
> > > > > > to
> > > > > > me (so I thought my patch was enough but I see it's not). Say
> > > > > > client
> > > > > > shuts down the main connection because it was idle. Now
> > > > > > whatever
> > > > > > operations goes on a different connection is going to get
> > > > > > callback
> > > > > > down. The only way the client can create a new backchannel
> > > > > > (according
> > > > > > to the spec) is if it creates a brand new connection and
> > > > > > sends
> > > > > > BIND_CONN_TO_SESSION there (all existing connections are
> > > > > > already
> > > > > > bound
> > > > > > to fore channel and according to the spec you can't modify
> > > > > > the
> > > > > > existing binding). But then we'd need to make sure that it's
> > > > > > the
> > > > > > first
> > > > > > one in the list of connections we iterate thru (as i think
> > > > > > 1st
> > > > > > marks
> > > > > > the main connection?) as the other operations that supposed
> > > > > > to
> > > > > > only
> > > > > > go
> > > > > > on main connection need to know which connection to pick.
> > > > > >
> > > > > > The reason it's not seen against linux is because it doesn't
> > > > > > follow
> > > > > > the spec is doesn't reject attempts to bind a backchannel to
> > > > > > an
> > > > > > already existing connection that was only bound for fore
> > > > > > channel.
> > > > > >
> > > > >
> > > > > Oh, I see. So the server is replying NFS4ERR_INVAL in order to
> > > > > let
> > > > > the
> > > > > client know that it is trying to change the channel bindings
> > > > > for
> > > > > that
> > > > > connection.
> > > >
> > > > Well server isn't failing because client is asking for
> > > > FORE_OR_BOTH
> > > > and it's a choice so server is returning FORE. I'm not sure we
> > > > can
> > > > ask
> > > > the server to fail the request with ERR_INVAL.... (rather I can
> > > > ask
> > > > but ) rather can we expect the server to do that always?
> > >
> > > In RFC5661, Section 18.34.3 I found the following normative text:
> > >
> > >    Invoking BIND_CONN_TO_SESSION on a connection already associated
> > > with
> > >    the specified session has no effect, and the server MUST respond
> > > with
> > >    NFS4_OK, unless the client is demanding changes to the set of
> > >    channels the connection is associated with.  If so, the server
> > > MUST
> > >    return NFS4ERR_INVAL.
> > >
> > >
> > > IOW: it sounds like your server isn't following the spec either.
> >
> > Thank you thank you! I missed that. Ok so we'll assume it does and I
> > will try to come up with what you are suggesting...
> >
> > Do we need to do reorder the connection list? After we reset the
> > connection, it will be on some random connection on the list of
> > connections. But for the NO_ROBIN connections we pick the first
> > connection in the list (which will not be the backchannel
> > connection).
> > Does it matter?
>
> That's why I suggested the rpc_task_close_connection() wrapper below.
> It should ensure that we close the same connection that got the
> NFS4ERR_INVAL, and then when we restart the RPC call (using
> rpc_restart_call_prepare()) it will just automatically create a new
> connection on that same struct xprt...

Ok let me try with an example.
Start with:
connection1 (first one on the list) (also the backchannel connection)
connection2
connection3

1. connection1 and 2 go idle and are stopped. Now backchannel is down.
2. connection3 sends a SEQUENCE (or whatever op) and gets callback_path down
3. client send BIND_CONN_TO_SESSION on connection3. gets ERR_INVAL.
Client resets the connection3 and sends new BIND_CONN_TO_SESSION and
now connection3 is our backchannel and fore channel. But connection3
is not the first one the list of transports
4. state management operations will pick connection1 out of the list
(but it's not a backchannel connection).

Is that a problem?

>
> >
> > > > > Hmm... Is there any reason why we can't just add a handler to
> > > > > nfs4_bind_one_conn_to_session_done() that intercepts
> > > > > NFS4ERR_INVAL,
> > > > > and
> > > > > disconnects the xprt before retrying?
> > > > > We should probably add a wrapper to xprt_force_disconnect() in
> > > > > include/linux/sunrpc/clnt.h. Something like the following?
> > > > >
> > > > >
> > > > > static inline void rpc_task_close_connection(struct rpc_task
> > > > > *task)
> > > > > {
> > > > >         if (task->tk_xprt)
> > > > >                 xprt_force_disconnect(task->tk_xprt);
> > > > > }
> > > > >
> > >
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
