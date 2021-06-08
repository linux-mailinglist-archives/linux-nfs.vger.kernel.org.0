Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AEC3A064F
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 23:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbhFHVna (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 17:43:30 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:45748 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbhFHVna (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 17:43:30 -0400
Received: by mail-ed1-f49.google.com with SMTP id r7so11837253edv.12
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jun 2021 14:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fdomybuJ2w1Ibo9c63dlZBNYtB53AoogEOrmVJ6wIy4=;
        b=hQa++V7DT6zjkx0pzRgUXqSaq80SVNN5aUP6IAM/T0cco2TY9cCNg8ZPxKiBxCN8CI
         6fG4bQoXsmXTUnuHPOgEKDRN945wJ3zKBFCXjR71qESRgOqmUkvGgeokLB6NBPP++GzF
         TbfconxkgM30xDedrmjKCkusUA9cz+tDz2Eol3coxSsgAk80c1vbmUH5v3DDBQBCiKJv
         2Oi+rzmHEf4y+Q1qtf4/Kjg5vyh0jChFlh2r9mX/+3xYkizgO3rIx+E2EtwJDiiYlgsO
         /QeHDuyMVOIE1JZEIo/OMd07pOhPZKZdlqkVVgncITC4LZtpLMC+elEXLTclo1wSOirg
         rabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fdomybuJ2w1Ibo9c63dlZBNYtB53AoogEOrmVJ6wIy4=;
        b=oAm6XnOCFwf9e1dp0IETgTXXjtuX1/hvEAvXUhh9m+JeJPlj6W5/PPdKTYnAeWoZzT
         WC/lpEN1XAziIlCivwAjlcekuIxYmco81z5gTs5F8wN+jp2ojZ8GrQ9w2Lz+0BO8sLeN
         OQAKZCYSQjuzyQG+Kp4KVFBFGy5yD+fr+bteoIlSEhcqs2+TsIfCi8lUIMtZopvBxyI1
         qPEwSYXrWm09w4j2IKuvljjzmpqImYJrCpuelZfS9lsjwMtFkeA6+WqHt9mLApOffRMS
         HDzXHPcI7cBqs1h22Vku1Yj8CtdsMa8y4DeFZlbMXgroWcmNmdGWRvsbJbjMgvDEV4o4
         FtcQ==
X-Gm-Message-State: AOAM530uB3sUCBd907Yo36bdcpnhPzQRJIihGkbObDES18wHuiGkz5El
        dRew1m5bCmK0lMh/AbPYDb7eFJ5OTtkFTL95zrw=
X-Google-Smtp-Source: ABdhPJyLxBK2qe5jMjpT91ne6Y4vBpYrDVUCYYrem2qu8Ttxoa4OhJuTL4R95gBdp6MGhM+K7aRtuX5MjgPexIJKxiI=
X-Received: by 2002:a50:cb8a:: with SMTP id k10mr27927397edi.267.1623188424818;
 Tue, 08 Jun 2021 14:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210608184527.87018-1-olga.kornievskaia@gmail.com>
 <C9C7FA2C-1913-4332-91EA-B51F8E104728@oracle.com> <CAN-5tyFYyxYr4joR6uPR7zoFToYMmntNdkUkNWV=g33OVXFuOw@mail.gmail.com>
 <29835A59-A523-49FD-8D28-06CDC2F0E94C@oracle.com>
In-Reply-To: <29835A59-A523-49FD-8D28-06CDC2F0E94C@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 8 Jun 2021 17:40:13 -0400
Message-ID: <CAN-5tyGP7UtcWcWzNiE9k+=Er+BhjO3dMJAe484htUOSry9gow@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.1+ add trunking when server trunking detected
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 8, 2021 at 5:06 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jun 8, 2021, at 4:56 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >
> > On Tue, Jun 8, 2021 at 4:41 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
> >>
> >>
> >>
> >>> On Jun 8, 2021, at 2:45 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >>>
> >>> From: Olga Kornievskaia <kolga@netapp.com>
> >>>
> >>> After trunking is discovered in nfs4_discover_server_trunking(),
> >>> add the transport to the old client structure before destroying
> >>> the new client structure (along with its transport).
> >>>
> >>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> >>> ---
> >>> fs/nfs/nfs4client.c | 40 ++++++++++++++++++++++++++++++++++++++++
> >>> 1 file changed, 40 insertions(+)
> >>>
> >>> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> >>> index 42719384e25f..984c851844d8 100644
> >>> --- a/fs/nfs/nfs4client.c
> >>> +++ b/fs/nfs/nfs4client.c
> >>> @@ -361,6 +361,44 @@ static int nfs4_init_client_minor_version(struct nfs_client *clp)
> >>>      return nfs4_init_callback(clp);
> >>> }
> >>>
> >>> +static void nfs4_add_trunk(struct nfs_client *clp, struct nfs_client *old)
> >>> +{
> >>> +     struct sockaddr_storage clp_addr, old_addr;
> >>> +     struct sockaddr *clp_sap = (struct sockaddr *)&clp_addr;
> >>> +     struct sockaddr *old_sap = (struct sockaddr *)&old_addr;
> >>> +     size_t clp_salen, old_salen;
> >>> +     struct xprt_create xprt_args = {
> >>> +             .ident = old->cl_proto,
> >>> +             .net = old->cl_net,
> >>> +             .servername = old->cl_hostname,
> >>> +     };
> >>> +     struct nfs4_add_xprt_data xprtdata = {
> >>> +             .clp = old,
> >>> +     };
> >>> +     struct rpc_add_xprt_test rpcdata = {
> >>> +             .add_xprt_test = old->cl_mvops->session_trunk,
> >>> +             .data = &xprtdata,
> >>> +     };
> >>> +
> >>> +     if (clp->cl_proto != old->cl_proto)
> >>> +             return;
> >>> +     clp_salen = rpc_peeraddr(clp->cl_rpcclient, clp_sap, sizeof(clp_addr));
> >>> +     old_salen = rpc_peeraddr(old->cl_rpcclient, old_sap, sizeof(old_addr));
> >>> +
> >>> +     if (clp_addr.ss_family != old_addr.ss_family)
> >>> +             return;
> >>> +
> >>> +     xprt_args.dstaddr = clp_sap;
> >>> +     xprt_args.addrlen = clp_salen;
> >>> +
> >>> +     xprtdata.cred = nfs4_get_clid_cred(old);
> >>> +     rpc_clnt_add_xprt(old->cl_rpcclient, &xprt_args,
> >>> +                       rpc_clnt_setup_test_and_add_xprt, &rpcdata);
> >>
> >> Is there an upper bound on the number of transports that
> >> are added to the NFS client's switch?
> >
> > I don't believe any limits exist right now. Why should there be a
> > limit? Are you saying that the client should limit trunking? While
> > this is not what's happening here, but say FS_LOCATION returned 100
> > ips for the server. Are you saying the client should be limiting how
> > many trunkable connections it would be establishing and picking just a
> > few addresses to try? What's happening with this patch is that say
> > there are 100mounts to 100 ips (each representing the same server or
> > trunkable server(s)), without this patch a single connection is kept,
> > with this patch we'll have 100 connections.
>
> The patch description needs to make this behavior more clear. It
> needs to explain "why" -- the body of the patch already explains
> "what". Can you include your last sentence in the description as
> a use case?

I sure can.

> As for the behavior... Seems to me that there are going to be only
> infinitesimal gains after the first few connections, and after
> that, it's going to be a lot for both sides to manage for no real
> gain. I think you do want to cap the total number of connections
> at a reasonable number, even in the FS_LOCATIONS case.

Do you want to cap it at 16 like we do for nconnect? I'm ok with that for now.

I don't understand why a setup where there X NICs on each side
(client/server) and X mounts are done, there won't be throughput of
close to X * throughput of a single NIC.

> >>> +
> >>> +     if (xprtdata.cred)
> >>> +             put_cred(xprtdata.cred);
> >>> +}
> >>> +
> >>> /**
> >>> * nfs4_init_client - Initialise an NFS4 client record
> >>> *
> >>> @@ -434,6 +472,8 @@ struct nfs_client *nfs4_init_client(struct nfs_client *clp,
> >>>               * won't try to use it.
> >>>               */
> >>>              nfs_mark_client_ready(clp, -EPERM);
> >>> +             if (old->cl_mvops->session_trunk)
> >>> +                     nfs4_add_trunk(clp, old);
> >>>      }
> >>>      clear_bit(NFS_CS_TSM_POSSIBLE, &clp->cl_flags);
> >>>      nfs_put_client(clp);
> >>> --
> >>> 2.27.0
> >>>
> >>
> >> --
> >> Chuck Lever
>
> --
> Chuck Lever
>
>
>
