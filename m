Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6CE3A0612
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 23:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbhFHVeX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 17:34:23 -0400
Received: from mail-ej1-f43.google.com ([209.85.218.43]:42689 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbhFHVeS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 17:34:18 -0400
Received: by mail-ej1-f43.google.com with SMTP id k25so29472908eja.9
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jun 2021 14:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZlCTZ5Yx0AesYA8KC58fjYHnaJgm0dIv29jyNATCkDo=;
        b=fMPAh9mfngknvNXHQl7vzC94rK81H+7NIqHeWyJH6UuZgbe3iUDlnQztk3NLvrp1Bu
         3t7QzfXphfKT+IU6kYEy+18t/lqGaIJz7ASri4dwLVbtO0u5W3DmerO+3HYnB0MbJNhs
         14hlCYTCGGcRX+GwxFVuV3QVeCEM29drEb8d6xtAZC21Ir1hA9xjP1uapo8tnMyJP0Up
         4lMOt/Gs9/suzznT+rPfRftf0xaBZIliR2I9tcX3eQhdnEWIY+uMU4i3AN9t3mSL8a7/
         m5jWlisRy6IojH5NbS+d7GWwweV8vt/P/iGMaFuqy9vKo6OnI28K2gh88fE+72THh/Zj
         ronA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZlCTZ5Yx0AesYA8KC58fjYHnaJgm0dIv29jyNATCkDo=;
        b=BoxMgw2e9QuxS3toi4nV21nwDzr+t4jVlSB2Nt1AgcrPF9BHbPFHEinmsiGhABffu5
         80EEHUj2yJneLSvm9UNK9OQuU0x2/IyUN6emGwHBTwKwgLWNOcDYc7jOy1Xv9qSsZ8H0
         iZPw64jzZpro1AAbUQyqpz3ADX8q8CqrK7HgNjW1c+Qyi0c/KH9lvo1Kf+NeHjhTitvW
         1VAeoBHXq1tjPkoRttRvNeGX4aDM5ax2lHoFimoVeJpaI0lBzXsTaGYqOrBH9rfDCgLL
         dg+/NiFLBhtiaafzkC20dHRHBkz9W+rIQL1xtqoMn4BkvM7LJQ9UzQMvn7MnMObFolNa
         VFAw==
X-Gm-Message-State: AOAM531QXHmw1TpIkI6oiFVSDLbtiY71K6d6q6H6rJmF+gLZ5BCDyJ74
        lqK68eAA8xvLFIxnrWkjDkjGKXGkMlT/caHbJlk=
X-Google-Smtp-Source: ABdhPJwIIUhz8jvUgU3GmKDi+HJpJywGEbhahdZtoIkyI/WspUtYwzt8AXOc+csgdUJ6IUG4JAL4cOStdXicPpA4p2M=
X-Received: by 2002:a17:906:278f:: with SMTP id j15mr26005674ejc.388.1623187867895;
 Tue, 08 Jun 2021 14:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210608184527.87018-1-olga.kornievskaia@gmail.com>
 <C9C7FA2C-1913-4332-91EA-B51F8E104728@oracle.com> <CAN-5tyFYyxYr4joR6uPR7zoFToYMmntNdkUkNWV=g33OVXFuOw@mail.gmail.com>
 <29835A59-A523-49FD-8D28-06CDC2F0E94C@oracle.com> <da738bdd35859aba7bdbed30da10df4e2d4087d2.camel@hammerspace.com>
 <1753b60c2cc23e6e650357fbf710ef4450310d76.camel@hammerspace.com>
In-Reply-To: <1753b60c2cc23e6e650357fbf710ef4450310d76.camel@hammerspace.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 8 Jun 2021 17:30:56 -0400
Message-ID: <CAN-5tyHsVprR9_0Q98X8Dd5zYgaX79V7R76KPSzDwQFMYL2qcA@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.1+ add trunking when server trunking detected
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 8, 2021 at 5:26 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Tue, 2021-06-08 at 21:19 +0000, Trond Myklebust wrote:
> > On Tue, 2021-06-08 at 21:06 +0000, Chuck Lever III wrote:
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
> > >
> > > As for the behavior... Seems to me that there are going to be only
> > > infinitesimal gains after the first few connections, and after
> > > that, it's going to be a lot for both sides to manage for no real
> > > gain. I think you do want to cap the total number of connections
> > > at a reasonable number, even in the FS_LOCATIONS case.
> > >
> >
> > I'd tend to agree. If you want to scale I/O then pNFS is the way to
> > go,
> > not vast numbers of connections to a single server.
> >
> BTW: AFAICS this patch will end up adding another connection every time
> we mount a new filesystem, whether or not a connection already exists
> to that IP address. That's unacceptable.

Not in my testing. Mounts to the same server (same IP) different
export volumes lead to use of a single connection.

>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
