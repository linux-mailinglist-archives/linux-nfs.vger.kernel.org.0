Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737F03A06B8
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jun 2021 00:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhFHWVv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 18:21:51 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:39654 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhFHWVv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 18:21:51 -0400
Received: by mail-ed1-f50.google.com with SMTP id dj8so26342233edb.6
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jun 2021 15:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tws9NwdZvQW6BKo9r/IUCeh/1Mvxb/Duv9JfIwq/0Gk=;
        b=UovFo/cmSDH/2ZLo//Ql/F5Fm/c9YgNq598r24k87A0+DGcdkRfAk2j9ahLizwa9ph
         Z7dd7kkbCHD2g0twK4Orhe+tgTX3N3PA/vIDXJutf9BioFVNCMiwcooM12mqvil2vbWy
         0748nTrXebLq1GFd2u1eZ5DFf7wJJC9yzO3FXywoVBscuCILZsi/gZ58xDDo5PpCxgqR
         WIedL1ThkFDag3lVkk2HNK353ZLvWdSTJc2TFBjuPuAWIU1Sk8DiNwMubW546jzGmn6z
         gjzKxIHE4EmziPnuKF2R5Ig0l7HNT8BlABzf0azWINOMnq5/WUtaedkPcAAEC6cV9kdL
         Cg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tws9NwdZvQW6BKo9r/IUCeh/1Mvxb/Duv9JfIwq/0Gk=;
        b=b2sPRj3JX4AFUYwY8X3Kuwd+h2LZq8DxVZzBU9KBvbaU7+Rrimz+A8WVlpT3qzOr9z
         44mHoO/33+ceb03VpCz+XE9jD7r6XE2t45YddaeajOfOG6ldXClFwF8ECPO1cWfP6sCq
         sHM2TMzV+/BPDab0WEUXG3cizVSMzF4uh8A9F+9mbVd2W6wfqGXEqYXCk+FkbNAj5vf4
         CRpX54jbQWXgTbMtJKSF0fM3DJF5Zkd+HuyUhV00/N1aW10t99HxzFo7F0kWZQe+P+yY
         OCMJYUHrJsXl+WZ3C8CcrOUEU1phRMiZiy7EhMGCzr/+r7eHvNkP7vQRoW9fPY3S0/il
         aBMw==
X-Gm-Message-State: AOAM532KMAFBwvytaMTjhhrRGBhSQc3PeUQgACVQO6yiPGxbY2w8WJPs
        +yW0EBrcp7Q9Omt2SmbjrSyB/+gFXL9aL58ljeI=
X-Google-Smtp-Source: ABdhPJyLsYkRakovyW2sqAiynlV+A6XAjkZRDmkTOsFg7eJaijPQ77aOU0hN/gRwWPFL3bXZpvksCD5ka49vbyADtPU=
X-Received: by 2002:a50:afe4:: with SMTP id h91mr27461120edd.28.1623190725858;
 Tue, 08 Jun 2021 15:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210608184527.87018-1-olga.kornievskaia@gmail.com>
 <C9C7FA2C-1913-4332-91EA-B51F8E104728@oracle.com> <CAN-5tyFYyxYr4joR6uPR7zoFToYMmntNdkUkNWV=g33OVXFuOw@mail.gmail.com>
 <29835A59-A523-49FD-8D28-06CDC2F0E94C@oracle.com> <CAN-5tyGP7UtcWcWzNiE9k+=Er+BhjO3dMJAe484htUOSry9gow@mail.gmail.com>
 <4c73319e5b826a8f3c9a29b085c42e181150d08c.camel@hammerspace.com>
In-Reply-To: <4c73319e5b826a8f3c9a29b085c42e181150d08c.camel@hammerspace.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 8 Jun 2021 18:18:34 -0400
Message-ID: <CAN-5tyFrhpyT9_Gfz0CRDv_-ecKRGE7ma0+WUWQot0qgS38wxg@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.1+ add trunking when server trunking detected
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 8, 2021 at 6:13 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Tue, 2021-06-08 at 17:40 -0400, Olga Kornievskaia wrote:
> > On Tue, Jun 8, 2021 at 5:06 PM Chuck Lever III <
> > chuck.lever@oracle.com> wrote:
> > >
> > >
> > >
> > > > On Jun 8, 2021, at 4:56 PM, Olga Kornievskaia <
> > > > olga.kornievskaia@gmail.com> wrote:
> > > >
> > > > On Tue, Jun 8, 2021 at 4:41 PM Chuck Lever III <
> > > > chuck.lever@oracle.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > > On Jun 8, 2021, at 2:45 PM, Olga Kornievskaia <
> > > > > > olga.kornievskaia@gmail.com> wrote:
> > > > > >
> > > > > > From: Olga Kornievskaia <kolga@netapp.com>
> > > > > >
> > > > > > After trunking is discovered in
> > > > > > nfs4_discover_server_trunking(),
> > > > > > add the transport to the old client structure before
> > > > > > destroying
> > > > > > the new client structure (along with its transport).
> > > > > >
> > > > > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > > > > ---
> > > > > > fs/nfs/nfs4client.c | 40
> > > > > > ++++++++++++++++++++++++++++++++++++++++
> > > > > > 1 file changed, 40 insertions(+)
> > > > > >
> > > > > > diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> > > > > > index 42719384e25f..984c851844d8 100644
> > > > > > --- a/fs/nfs/nfs4client.c
> > > > > > +++ b/fs/nfs/nfs4client.c
> > > > > > @@ -361,6 +361,44 @@ static int
> > > > > > nfs4_init_client_minor_version(struct nfs_client *clp)
> > > > > >      return nfs4_init_callback(clp);
> > > > > > }
> > > > > >
> > > > > > +static void nfs4_add_trunk(struct nfs_client *clp, struct
> > > > > > nfs_client *old)
> > > > > > +{
> > > > > > +     struct sockaddr_storage clp_addr, old_addr;
> > > > > > +     struct sockaddr *clp_sap = (struct sockaddr
> > > > > > *)&clp_addr;
> > > > > > +     struct sockaddr *old_sap = (struct sockaddr
> > > > > > *)&old_addr;
> > > > > > +     size_t clp_salen, old_salen;
> > > > > > +     struct xprt_create xprt_args = {
> > > > > > +             .ident = old->cl_proto,
> > > > > > +             .net = old->cl_net,
> > > > > > +             .servername = old->cl_hostname,
> > > > > > +     };
> > > > > > +     struct nfs4_add_xprt_data xprtdata = {
> > > > > > +             .clp = old,
> > > > > > +     };
> > > > > > +     struct rpc_add_xprt_test rpcdata = {
> > > > > > +             .add_xprt_test = old->cl_mvops->session_trunk,
> > > > > > +             .data = &xprtdata,
> > > > > > +     };
> > > > > > +
> > > > > > +     if (clp->cl_proto != old->cl_proto)
> > > > > > +             return;
> > > > > > +     clp_salen = rpc_peeraddr(clp->cl_rpcclient, clp_sap,
> > > > > > sizeof(clp_addr));
> > > > > > +     old_salen = rpc_peeraddr(old->cl_rpcclient, old_sap,
> > > > > > sizeof(old_addr));
> > > > > > +
> > > > > > +     if (clp_addr.ss_family != old_addr.ss_family)
> > > > > > +             return;
> > > > > > +
> > > > > > +     xprt_args.dstaddr = clp_sap;
> > > > > > +     xprt_args.addrlen = clp_salen;
> > > > > > +
> > > > > > +     xprtdata.cred = nfs4_get_clid_cred(old);
> > > > > > +     rpc_clnt_add_xprt(old->cl_rpcclient, &xprt_args,
> > > > > > +                       rpc_clnt_setup_test_and_add_xprt,
> > > > > > &rpcdata);
> > > > >
> > > > > Is there an upper bound on the number of transports that
> > > > > are added to the NFS client's switch?
> > > >
> > > > I don't believe any limits exist right now. Why should there be a
> > > > limit? Are you saying that the client should limit trunking?
> > > > While
> > > > this is not what's happening here, but say FS_LOCATION returned
> > > > 100
> > > > ips for the server. Are you saying the client should be limiting
> > > > how
> > > > many trunkable connections it would be establishing and picking
> > > > just a
> > > > few addresses to try? What's happening with this patch is that
> > > > say
> > > > there are 100mounts to 100 ips (each representing the same server
> > > > or
> > > > trunkable server(s)), without this patch a single connection is
> > > > kept,
> > > > with this patch we'll have 100 connections.
> > >
> > > The patch description needs to make this behavior more clear. It
> > > needs to explain "why" -- the body of the patch already explains
> > > "what". Can you include your last sentence in the description as
> > > a use case?
> >
> > I sure can.
> >
> > > As for the behavior... Seems to me that there are going to be only
> > > infinitesimal gains after the first few connections, and after
> > > that, it's going to be a lot for both sides to manage for no real
> > > gain. I think you do want to cap the total number of connections
> > > at a reasonable number, even in the FS_LOCATIONS case.
> >
> > Do you want to cap it at 16 like we do for nconnect? I'm ok with that
> > for now.
> >
> > I don't understand why a setup where there X NICs on each side
> > (client/server) and X mounts are done, there won't be throughput of
> > close to X * throughput of a single NIC.
>
> That still does not make the patch acceptable. There are already server
> vendors seeing problems with supporting nconnect for various reasons.

Why are there servers presenting multiple IP addresses and returning
the same server identity if they can not support trunking? That seems
to be going against the spec?

> There needs to be a way to ensure that we can keep the current client
> behaviour without requiring changes to server DNS entries, etc.

Ok, how about we introduce a mount option, "enable_trunking", and if
that's present we would not collapse transports?

> >
> > > > > > +
> > > > > > +     if (xprtdata.cred)
> > > > > > +             put_cred(xprtdata.cred);
> > > > > > +}
> > > > > > +
> > > > > > /**
> > > > > > * nfs4_init_client - Initialise an NFS4 client record
> > > > > > *
> > > > > > @@ -434,6 +472,8 @@ struct nfs_client
> > > > > > *nfs4_init_client(struct nfs_client *clp,
> > > > > >               * won't try to use it.
> > > > > >               */
> > > > > >              nfs_mark_client_ready(clp, -EPERM);
> > > > > > +             if (old->cl_mvops->session_trunk)
> > > > > > +                     nfs4_add_trunk(clp, old);
> > > > > >      }
> > > > > >      clear_bit(NFS_CS_TSM_POSSIBLE, &clp->cl_flags);
> > > > > >      nfs_put_client(clp);
> > > > > > --
> > > > > > 2.27.0
> > > > > >
> > > > >
> > > > > --
> > > > > Chuck Lever
> > >
> > > --
> > > Chuck Lever
> > >
> > >
> > >
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
