Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C873A0737
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jun 2021 00:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbhFHWl0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 18:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbhFHWlP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 18:41:15 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9ABC061574
        for <linux-nfs@vger.kernel.org>; Tue,  8 Jun 2021 15:39:11 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id u24so26355408edy.11
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jun 2021 15:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xq5H4QsQlzgn1dr2BvbW8BnaAJdEfobbqx1p5Yr8h94=;
        b=oEcVBPDSvrqL9O+Q9sooKvSss8HZFZSQfN8FfHU0mdMXNhQykLew+81GLoT5AgsFJ2
         JNwABeAR4v43tMVzmst3CoUbfgutnon8PRTzslsuPosWWlsg7eHCoBKw36UGe0jjeKxy
         6wnnFIE9ZjCSCujoQw5RhmFaiI2v4p5XJJzoEU1L5TtvSoZYm4JQJc5eFN1phajVerPz
         /vwq+NmzSmloDOmVFHjTQipNVUQpJ/bvW+ehkoz6tqoxSD5/VyNiwhCOo55kbsr2QWtd
         22dxJEVr55OuU+GcSJQ5Bglepy8Ez4gXCMGRi6IFfBMO035l+hCU23u0QG287t89WAwb
         mbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xq5H4QsQlzgn1dr2BvbW8BnaAJdEfobbqx1p5Yr8h94=;
        b=iTC7DlfgC1ztB277OQ4uXYYrSrltvEF82A39tO3B+Vjas3JGGvQ2JTlF2KW5AvPHxV
         oUJ2p/d8KP6NCFxLSdVtrqbFopULIFBBY7Q+jAIM+khWy6QY540iBwa3tlFHHveYD+1P
         oWC2DkwdM7cYpRWHwXWFq7XvmtyksMtcVBD1udrKPywcXLTuYrFLeD3dExW5Ruv/QRgs
         +UYkVTbRquGjAy3tE1J23P2nmKzZAOinRoFRB4/b0zVRbp8AxZYfl8PUwXGJ3Jit29Kn
         62T6u3OxkjDCVuVF5aRJgkwNH5M8L/83+bJxsxrSMDUVV6CNUTXBywFsRcf8NnZbt/zx
         Y/Vw==
X-Gm-Message-State: AOAM530wJaKuvx1VtF8ihWLWDVO7ztI86NwEMO66yq86113hN0fK0m6a
        UM1mJ1PqvKCdSvQDNHbVoSNmOS552sElMj1Ii4E=
X-Google-Smtp-Source: ABdhPJxeGKOLfm1L6oDa1G6XtbXL1EgSqV56dPKUuJeo5FpCM4qhomWElLiLh+T67qOrsJqVwXW01eVloiTodVmmbhM=
X-Received: by 2002:aa7:d555:: with SMTP id u21mr19751056edr.84.1623191949762;
 Tue, 08 Jun 2021 15:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210608184527.87018-1-olga.kornievskaia@gmail.com>
 <C9C7FA2C-1913-4332-91EA-B51F8E104728@oracle.com> <CAN-5tyFYyxYr4joR6uPR7zoFToYMmntNdkUkNWV=g33OVXFuOw@mail.gmail.com>
 <29835A59-A523-49FD-8D28-06CDC2F0E94C@oracle.com> <da738bdd35859aba7bdbed30da10df4e2d4087d2.camel@hammerspace.com>
 <1753b60c2cc23e6e650357fbf710ef4450310d76.camel@hammerspace.com>
 <CAN-5tyHsVprR9_0Q98X8Dd5zYgaX79V7R76KPSzDwQFMYL2qcA@mail.gmail.com>
 <e136a646089d862c476b555ea6b009cf19f5fadd.camel@hammerspace.com>
 <CAN-5tyG+fmfXsgT6rEURBKT3xUn5_pgwY=JzYCtFWKPpbnkzZQ@mail.gmail.com> <ba534fc8bb625870f31c086528c7f6d879b9156e.camel@hammerspace.com>
In-Reply-To: <ba534fc8bb625870f31c086528c7f6d879b9156e.camel@hammerspace.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 8 Jun 2021 18:38:58 -0400
Message-ID: <CAN-5tyEJTfG9R7qA2JKar0mFzSNqnJT1ffavj-ik1buaZoqbAw@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.1+ add trunking when server trunking detected
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 8, 2021 at 6:31 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Tue, 2021-06-08 at 18:21 -0400, Olga Kornievskaia wrote:
> > On Tue, Jun 8, 2021 at 5:41 PM Trond Myklebust <
> > trondmy@hammerspace.com> wrote:
> > >
> > > On Tue, 2021-06-08 at 17:30 -0400, Olga Kornievskaia wrote:
> > > > On Tue, Jun 8, 2021 at 5:26 PM Trond Myklebust <
> > > > trondmy@hammerspace.com> wrote:
> > > > >
> > > > > On Tue, 2021-06-08 at 21:19 +0000, Trond Myklebust wrote:
> > > > > > On Tue, 2021-06-08 at 21:06 +0000, Chuck Lever III wrote:
> > > > > > >
> > > > > > >
> > > > > > > > On Jun 8, 2021, at 4:56 PM, Olga Kornievskaia <
> > > > > > > > olga.kornievskaia@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Jun 8, 2021 at 4:41 PM Chuck Lever III <
> > > > > > > > chuck.lever@oracle.com> wrote:
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > On Jun 8, 2021, at 2:45 PM, Olga Kornievskaia <
> > > > > > > > > > olga.kornievskaia@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > From: Olga Kornievskaia <kolga@netapp.com>
> > > > > > > > > >
> > > > > > > > > > After trunking is discovered in
> > > > > > > > > > nfs4_discover_server_trunking(),
> > > > > > > > > > add the transport to the old client structure before
> > > > > > > > > > destroying
> > > > > > > > > > the new client structure (along with its transport).
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > > > > > > > > ---
> > > > > > > > > > fs/nfs/nfs4client.c | 40
> > > > > > > > > > ++++++++++++++++++++++++++++++++++++++++
> > > > > > > > > > 1 file changed, 40 insertions(+)
> > > > > > > > > >
> > > > > > > > > > diff --git a/fs/nfs/nfs4client.c
> > > > > > > > > > b/fs/nfs/nfs4client.c
> > > > > > > > > > index 42719384e25f..984c851844d8 100644
> > > > > > > > > > --- a/fs/nfs/nfs4client.c
> > > > > > > > > > +++ b/fs/nfs/nfs4client.c
> > > > > > > > > > @@ -361,6 +361,44 @@ static int
> > > > > > > > > > nfs4_init_client_minor_version(struct nfs_client
> > > > > > > > > > *clp)
> > > > > > > > > >      return nfs4_init_callback(clp);
> > > > > > > > > > }
> > > > > > > > > >
> > > > > > > > > > +static void nfs4_add_trunk(struct nfs_client *clp,
> > > > > > > > > > struct
> > > > > > > > > > nfs_client *old)
> > > > > > > > > > +{
> > > > > > > > > > +     struct sockaddr_storage clp_addr, old_addr;
> > > > > > > > > > +     struct sockaddr *clp_sap = (struct sockaddr
> > > > > > > > > > *)&clp_addr;
> > > > > > > > > > +     struct sockaddr *old_sap = (struct sockaddr
> > > > > > > > > > *)&old_addr;
> > > > > > > > > > +     size_t clp_salen, old_salen;
> > > > > > > > > > +     struct xprt_create xprt_args = {
> > > > > > > > > > +             .ident = old->cl_proto,
> > > > > > > > > > +             .net = old->cl_net,
> > > > > > > > > > +             .servername = old->cl_hostname,
> > > > > > > > > > +     };
> > > > > > > > > > +     struct nfs4_add_xprt_data xprtdata = {
> > > > > > > > > > +             .clp = old,
> > > > > > > > > > +     };
> > > > > > > > > > +     struct rpc_add_xprt_test rpcdata = {
> > > > > > > > > > +             .add_xprt_test = old->cl_mvops-
> > > > > > > > > > > session_trunk,
> > > > > > > > > > +             .data = &xprtdata,
> > > > > > > > > > +     };
> > > > > > > > > > +
> > > > > > > > > > +     if (clp->cl_proto != old->cl_proto)
> > > > > > > > > > +             return;
> > > > > > > > > > +     clp_salen = rpc_peeraddr(clp->cl_rpcclient,
> > > > > > > > > > clp_sap,
> > > > > > > > > > sizeof(clp_addr));
> > > > > > > > > > +     old_salen = rpc_peeraddr(old->cl_rpcclient,
> > > > > > > > > > old_sap,
> > > > > > > > > > sizeof(old_addr));
> > > > > > > > > > +
> > > > > > > > > > +     if (clp_addr.ss_family != old_addr.ss_family)
> > > > > > > > > > +             return;
> > > > > > > > > > +
> > > > > > > > > > +     xprt_args.dstaddr = clp_sap;
> > > > > > > > > > +     xprt_args.addrlen = clp_salen;
> > > > > > > > > > +
> > > > > > > > > > +     xprtdata.cred = nfs4_get_clid_cred(old);
> > > > > > > > > > +     rpc_clnt_add_xprt(old->cl_rpcclient,
> > > > > > > > > > &xprt_args,
> > > > > > > > > > +
> > > > > > > > > > rpc_clnt_setup_test_and_add_xprt,
> > > > > > > > > > &rpcdata);
> > > > > > > > >
> > > > > > > > > Is there an upper bound on the number of transports
> > > > > > > > > that
> > > > > > > > > are added to the NFS client's switch?
> > > > > > > >
> > > > > > > > I don't believe any limits exist right now. Why should
> > > > > > > > there
> > > > > > > > be a
> > > > > > > > limit? Are you saying that the client should limit
> > > > > > > > trunking?
> > > > > > > > While
> > > > > > > > this is not what's happening here, but say FS_LOCATION
> > > > > > > > returned
> > > > > > > > 100
> > > > > > > > ips for the server. Are you saying the client should be
> > > > > > > > limiting
> > > > > > > > how
> > > > > > > > many trunkable connections it would be establishing and
> > > > > > > > picking
> > > > > > > > just a
> > > > > > > > few addresses to try? What's happening with this patch is
> > > > > > > > that
> > > > > > > > say
> > > > > > > > there are 100mounts to 100 ips (each representing the
> > > > > > > > same
> > > > > > > > server
> > > > > > > > or
> > > > > > > > trunkable server(s)), without this patch a single
> > > > > > > > connection
> > > > > > > > is
> > > > > > > > kept,
> > > > > > > > with this patch we'll have 100 connections.
> > > > > > >
> > > > > > > The patch description needs to make this behavior more
> > > > > > > clear.
> > > > > > > It
> > > > > > > needs to explain "why" -- the body of the patch already
> > > > > > > explains
> > > > > > > "what". Can you include your last sentence in the
> > > > > > > description
> > > > > > > as
> > > > > > > a use case?
> > > > > > >
> > > > > > > As for the behavior... Seems to me that there are going to
> > > > > > > be
> > > > > > > only
> > > > > > > infinitesimal gains after the first few connections, and
> > > > > > > after
> > > > > > > that, it's going to be a lot for both sides to manage for
> > > > > > > no
> > > > > > > real
> > > > > > > gain. I think you do want to cap the total number of
> > > > > > > connections
> > > > > > > at a reasonable number, even in the FS_LOCATIONS case.
> > > > > > >
> > > > > >
> > > > > > I'd tend to agree. If you want to scale I/O then pNFS is the
> > > > > > way
> > > > > > to
> > > > > > go,
> > > > > > not vast numbers of connections to a single server.
> > > > > >
> > > > > BTW: AFAICS this patch will end up adding another connection
> > > > > every
> > > > > time
> > > > > we mount a new filesystem, whether or not a connection already
> > > > > exists
> > > > > to that IP address. That's unacceptable.
> > > >
> > > > Not in my testing. Mounts to the same server (same IP) different
> > > > export volumes lead to use of a single connection.
> > > > >
> > >
> > > Ah... Never mind. The comparison is made by
> > > rpc_clnt_setup_test_and_add_xprt(), and the address is discarded if
> > > it
> > > is already present.
> > >
> > > However why are you running trunking detection a second time on the
> > > address you've just run trunking detection on and have decided to
> > > add?
> >
> > Because that's where we determined that these are different clients
> > and are trunkable? But I guess also for the ease of re-using existing
> > code. There is no hook to create an xprt and add it to an existing
> > RPC
> > client. One can be created.
>
> Why not rpc_clnt_add_xprt()? That's what pNFS uses for this case.

That's what this code is using.

>
>
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
