Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18573A06B9
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jun 2021 00:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhFHWYo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 18:24:44 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:39581 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhFHWYn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 18:24:43 -0400
Received: by mail-ej1-f47.google.com with SMTP id l1so35146558ejb.6
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jun 2021 15:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3IxG37DwNprXVt7LqEqVhOMYr1nEGxpmwMdBBvPWHrc=;
        b=B4XonXn8X9mPbqPdG7DKQDJ5iCeBjRJDyrUi5Ye5vUEyEKj1/322BYaD2IBHhM60L7
         UalS5VBx5s7ySl7/aPK55dALbs7A07PVKgS00x/1M3piwqFk0yiR01N5V9xhQIqxe4gV
         HLXH5tPFn9RJCGQ81oTmGc4ZHPSaAx3f3I5RuHZAsVv9iAjWzKL2VCGcbtaM6E8zwGKD
         QSI/20U5rCnaYZdqFf4VA/bEfuj0gSeLxSip0GtKim3Ar+Wxt5QL67fP/e+K5tFcOwKt
         BT07AFiUSqv/9eI9HSL14c/FEocG2Y5P2ktnhCiF2LiYQwDeWAkuIR9lQluoL2F5xrXy
         zqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3IxG37DwNprXVt7LqEqVhOMYr1nEGxpmwMdBBvPWHrc=;
        b=iMmKCZaAMy/7MbkayuyH+0hZo/vJsjrso/o5UnJQ/YpZJKMt7N2a86e6Vrix8Yu+8A
         Rinjz1ecn+l5QMfxqYahRy/w2WNjSVCQo0NdtQfpMhrpk7i8wJPs3HfegRDM1YEq03gs
         mA2ToXkYTVVQ8GCvX0ud+i+P8MAzuUJf5Bbyoly18xAXuH0jV1fXJ39vnlXSFKAZ6pYT
         HKvNGHKaBgbs9nKS1SZaxedogjsXym1X72Cn/cAKS5/87aNigaIzD1ZJb9NO00+qKtFM
         i6J8eS+L8CC0+0sRWQvlUGsFLB7ewbH8hpOZrfljWCqAdosMsgGA4EYrYNFUjDj0S3Dm
         RRxg==
X-Gm-Message-State: AOAM531PVZPfMgcW46KNn0iChfQg8ylr/SOm18UWA0zqPAuH/Nj00bfJ
        3GdwWsWUTUWeZIzB3VPbHg00jnCSIGZSno46pvA=
X-Google-Smtp-Source: ABdhPJyzJ2OhI33doywuNbwodayS8z/O1lIUuTy9taNO0C7GMugMWmPU5trznER3qRS950tbVuQEtVpB11FME5Lbn40=
X-Received: by 2002:a17:907:1c9e:: with SMTP id nb30mr17190419ejc.0.1623190909635;
 Tue, 08 Jun 2021 15:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210608184527.87018-1-olga.kornievskaia@gmail.com>
 <C9C7FA2C-1913-4332-91EA-B51F8E104728@oracle.com> <CAN-5tyFYyxYr4joR6uPR7zoFToYMmntNdkUkNWV=g33OVXFuOw@mail.gmail.com>
 <29835A59-A523-49FD-8D28-06CDC2F0E94C@oracle.com> <da738bdd35859aba7bdbed30da10df4e2d4087d2.camel@hammerspace.com>
 <1753b60c2cc23e6e650357fbf710ef4450310d76.camel@hammerspace.com>
 <CAN-5tyHsVprR9_0Q98X8Dd5zYgaX79V7R76KPSzDwQFMYL2qcA@mail.gmail.com> <e136a646089d862c476b555ea6b009cf19f5fadd.camel@hammerspace.com>
In-Reply-To: <e136a646089d862c476b555ea6b009cf19f5fadd.camel@hammerspace.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 8 Jun 2021 18:21:38 -0400
Message-ID: <CAN-5tyG+fmfXsgT6rEURBKT3xUn5_pgwY=JzYCtFWKPpbnkzZQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.1+ add trunking when server trunking detected
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 8, 2021 at 5:41 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Tue, 2021-06-08 at 17:30 -0400, Olga Kornievskaia wrote:
> > On Tue, Jun 8, 2021 at 5:26 PM Trond Myklebust <
> > trondmy@hammerspace.com> wrote:
> > >
> > > On Tue, 2021-06-08 at 21:19 +0000, Trond Myklebust wrote:
> > > > On Tue, 2021-06-08 at 21:06 +0000, Chuck Lever III wrote:
> > > > >
> > > > >
> > > > > > On Jun 8, 2021, at 4:56 PM, Olga Kornievskaia <
> > > > > > olga.kornievskaia@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, Jun 8, 2021 at 4:41 PM Chuck Lever III <
> > > > > > chuck.lever@oracle.com> wrote:
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > > On Jun 8, 2021, at 2:45 PM, Olga Kornievskaia <
> > > > > > > > olga.kornievskaia@gmail.com> wrote:
> > > > > > > >
> > > > > > > > From: Olga Kornievskaia <kolga@netapp.com>
> > > > > > > >
> > > > > > > > After trunking is discovered in
> > > > > > > > nfs4_discover_server_trunking(),
> > > > > > > > add the transport to the old client structure before
> > > > > > > > destroying
> > > > > > > > the new client structure (along with its transport).
> > > > > > > >
> > > > > > > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > > > > > > ---
> > > > > > > > fs/nfs/nfs4client.c | 40
> > > > > > > > ++++++++++++++++++++++++++++++++++++++++
> > > > > > > > 1 file changed, 40 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> > > > > > > > index 42719384e25f..984c851844d8 100644
> > > > > > > > --- a/fs/nfs/nfs4client.c
> > > > > > > > +++ b/fs/nfs/nfs4client.c
> > > > > > > > @@ -361,6 +361,44 @@ static int
> > > > > > > > nfs4_init_client_minor_version(struct nfs_client *clp)
> > > > > > > >      return nfs4_init_callback(clp);
> > > > > > > > }
> > > > > > > >
> > > > > > > > +static void nfs4_add_trunk(struct nfs_client *clp,
> > > > > > > > struct
> > > > > > > > nfs_client *old)
> > > > > > > > +{
> > > > > > > > +     struct sockaddr_storage clp_addr, old_addr;
> > > > > > > > +     struct sockaddr *clp_sap = (struct sockaddr
> > > > > > > > *)&clp_addr;
> > > > > > > > +     struct sockaddr *old_sap = (struct sockaddr
> > > > > > > > *)&old_addr;
> > > > > > > > +     size_t clp_salen, old_salen;
> > > > > > > > +     struct xprt_create xprt_args = {
> > > > > > > > +             .ident = old->cl_proto,
> > > > > > > > +             .net = old->cl_net,
> > > > > > > > +             .servername = old->cl_hostname,
> > > > > > > > +     };
> > > > > > > > +     struct nfs4_add_xprt_data xprtdata = {
> > > > > > > > +             .clp = old,
> > > > > > > > +     };
> > > > > > > > +     struct rpc_add_xprt_test rpcdata = {
> > > > > > > > +             .add_xprt_test = old->cl_mvops-
> > > > > > > > >session_trunk,
> > > > > > > > +             .data = &xprtdata,
> > > > > > > > +     };
> > > > > > > > +
> > > > > > > > +     if (clp->cl_proto != old->cl_proto)
> > > > > > > > +             return;
> > > > > > > > +     clp_salen = rpc_peeraddr(clp->cl_rpcclient,
> > > > > > > > clp_sap,
> > > > > > > > sizeof(clp_addr));
> > > > > > > > +     old_salen = rpc_peeraddr(old->cl_rpcclient,
> > > > > > > > old_sap,
> > > > > > > > sizeof(old_addr));
> > > > > > > > +
> > > > > > > > +     if (clp_addr.ss_family != old_addr.ss_family)
> > > > > > > > +             return;
> > > > > > > > +
> > > > > > > > +     xprt_args.dstaddr = clp_sap;
> > > > > > > > +     xprt_args.addrlen = clp_salen;
> > > > > > > > +
> > > > > > > > +     xprtdata.cred = nfs4_get_clid_cred(old);
> > > > > > > > +     rpc_clnt_add_xprt(old->cl_rpcclient, &xprt_args,
> > > > > > > > +                       rpc_clnt_setup_test_and_add_xprt,
> > > > > > > > &rpcdata);
> > > > > > >
> > > > > > > Is there an upper bound on the number of transports that
> > > > > > > are added to the NFS client's switch?
> > > > > >
> > > > > > I don't believe any limits exist right now. Why should there
> > > > > > be a
> > > > > > limit? Are you saying that the client should limit trunking?
> > > > > > While
> > > > > > this is not what's happening here, but say FS_LOCATION
> > > > > > returned
> > > > > > 100
> > > > > > ips for the server. Are you saying the client should be
> > > > > > limiting
> > > > > > how
> > > > > > many trunkable connections it would be establishing and
> > > > > > picking
> > > > > > just a
> > > > > > few addresses to try? What's happening with this patch is
> > > > > > that
> > > > > > say
> > > > > > there are 100mounts to 100 ips (each representing the same
> > > > > > server
> > > > > > or
> > > > > > trunkable server(s)), without this patch a single connection
> > > > > > is
> > > > > > kept,
> > > > > > with this patch we'll have 100 connections.
> > > > >
> > > > > The patch description needs to make this behavior more clear.
> > > > > It
> > > > > needs to explain "why" -- the body of the patch already
> > > > > explains
> > > > > "what". Can you include your last sentence in the description
> > > > > as
> > > > > a use case?
> > > > >
> > > > > As for the behavior... Seems to me that there are going to be
> > > > > only
> > > > > infinitesimal gains after the first few connections, and after
> > > > > that, it's going to be a lot for both sides to manage for no
> > > > > real
> > > > > gain. I think you do want to cap the total number of
> > > > > connections
> > > > > at a reasonable number, even in the FS_LOCATIONS case.
> > > > >
> > > >
> > > > I'd tend to agree. If you want to scale I/O then pNFS is the way
> > > > to
> > > > go,
> > > > not vast numbers of connections to a single server.
> > > >
> > > BTW: AFAICS this patch will end up adding another connection every
> > > time
> > > we mount a new filesystem, whether or not a connection already
> > > exists
> > > to that IP address. That's unacceptable.
> >
> > Not in my testing. Mounts to the same server (same IP) different
> > export volumes lead to use of a single connection.
> > >
>
> Ah... Never mind. The comparison is made by
> rpc_clnt_setup_test_and_add_xprt(), and the address is discarded if it
> is already present.
>
> However why are you running trunking detection a second time on the
> address you've just run trunking detection on and have decided to add?

Because that's where we determined that these are different clients
and are trunkable? But I guess also for the ease of re-using existing
code. There is no hook to create an xprt and add it to an existing RPC
client. One can be created.

>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
