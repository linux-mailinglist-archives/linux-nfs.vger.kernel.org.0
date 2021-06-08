Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE843A0564
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 22:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbhFHU65 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 16:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhFHU65 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 16:58:57 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A203DC061787
        for <linux-nfs@vger.kernel.org>; Tue,  8 Jun 2021 13:56:52 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g18so24105238edq.8
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jun 2021 13:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jYJAxRqXwg9Sl+PmcgyROGJgJ8B+/tqoGA3hlgHS02I=;
        b=RYEe6QhJ1IrVSrLJBMPm0b0Vubjd3WysCc1FkPaB0LjqzO74MqsIDyIE8K3O2mk3HS
         LDIfyb2LBKGg83wEB6o48vjRda/OJU8emprx63+r9dsq/PbT6Zw1/D5SXE4+edLolB9x
         u6ITdpZtbc0YC7Rm5wHJGPTOl0GgkP7wWuHOk7fjDqH1MpISX4iogtRwN2Ks2ID7wKVb
         fZhOzeXwTR1PmNuKgi85MlZK8u5ttHGLrmnKJEHQgEkxY6SyaTg89GncttDKUj//JwkQ
         izeO/yu/2GmAX7jfX5rtKHgTUNT1kI6FPuJraOSEvOUSf1/l60NVcIvTdUbg+TgdLrfi
         qkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jYJAxRqXwg9Sl+PmcgyROGJgJ8B+/tqoGA3hlgHS02I=;
        b=ikUoDweflbaNWswVU6gP4KS+uJ60qxhI0eMN2XviGpr8bBvVh1UEHKBULTm3yUwPEj
         sc4JfbBsWGgSC+CShXWrhEI62PRCVvlcGATCw94IWWUjcjSDoETnSq9QwYP3IKLYOcFk
         5KCVkgH/6Hpt7PgIUK01gou4SM8A+yhO0RujZc6HgFJP0X0Crz7N9Ra1H3eZW/1jAdRI
         7EGxiAaO9NDuXSGri7wB44c5+oiCu+uVVYK6MDjqeJ1LcDA60DciOEfVM0bpEX7k7VBb
         9EIeu5HN+mGy4bradFB5ZIe6wgO81oZPyhP9TeTiuuvjS7/3pHIARbmwAH4/xj1jdm3n
         oXuQ==
X-Gm-Message-State: AOAM532KgWNc/lgFZRun++za3wXUaTYt/wlTMEQklwJ2fg/Lz/WQTBKn
        BTB0xvljYLgIvFoKMiG1Bg9vE8oUFrbGEj/R+6o=
X-Google-Smtp-Source: ABdhPJy4CLxlVM3ax23db0vShn9vk00qIH6DiA293ENwArhCy46+4N6D5y9tFwV6SD3vCUJZ5GtcE58aArCDLFzyB90=
X-Received: by 2002:aa7:cb5a:: with SMTP id w26mr28070509edt.139.1623185811160;
 Tue, 08 Jun 2021 13:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210608184527.87018-1-olga.kornievskaia@gmail.com> <C9C7FA2C-1913-4332-91EA-B51F8E104728@oracle.com>
In-Reply-To: <C9C7FA2C-1913-4332-91EA-B51F8E104728@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 8 Jun 2021 16:56:39 -0400
Message-ID: <CAN-5tyFYyxYr4joR6uPR7zoFToYMmntNdkUkNWV=g33OVXFuOw@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.1+ add trunking when server trunking detected
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 8, 2021 at 4:41 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jun 8, 2021, at 2:45 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > After trunking is discovered in nfs4_discover_server_trunking(),
> > add the transport to the old client structure before destroying
> > the new client structure (along with its transport).
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> > fs/nfs/nfs4client.c | 40 ++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 40 insertions(+)
> >
> > diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> > index 42719384e25f..984c851844d8 100644
> > --- a/fs/nfs/nfs4client.c
> > +++ b/fs/nfs/nfs4client.c
> > @@ -361,6 +361,44 @@ static int nfs4_init_client_minor_version(struct nfs_client *clp)
> >       return nfs4_init_callback(clp);
> > }
> >
> > +static void nfs4_add_trunk(struct nfs_client *clp, struct nfs_client *old)
> > +{
> > +     struct sockaddr_storage clp_addr, old_addr;
> > +     struct sockaddr *clp_sap = (struct sockaddr *)&clp_addr;
> > +     struct sockaddr *old_sap = (struct sockaddr *)&old_addr;
> > +     size_t clp_salen, old_salen;
> > +     struct xprt_create xprt_args = {
> > +             .ident = old->cl_proto,
> > +             .net = old->cl_net,
> > +             .servername = old->cl_hostname,
> > +     };
> > +     struct nfs4_add_xprt_data xprtdata = {
> > +             .clp = old,
> > +     };
> > +     struct rpc_add_xprt_test rpcdata = {
> > +             .add_xprt_test = old->cl_mvops->session_trunk,
> > +             .data = &xprtdata,
> > +     };
> > +
> > +     if (clp->cl_proto != old->cl_proto)
> > +             return;
> > +     clp_salen = rpc_peeraddr(clp->cl_rpcclient, clp_sap, sizeof(clp_addr));
> > +     old_salen = rpc_peeraddr(old->cl_rpcclient, old_sap, sizeof(old_addr));
> > +
> > +     if (clp_addr.ss_family != old_addr.ss_family)
> > +             return;
> > +
> > +     xprt_args.dstaddr = clp_sap;
> > +     xprt_args.addrlen = clp_salen;
> > +
> > +     xprtdata.cred = nfs4_get_clid_cred(old);
> > +     rpc_clnt_add_xprt(old->cl_rpcclient, &xprt_args,
> > +                       rpc_clnt_setup_test_and_add_xprt, &rpcdata);
>
> Is there an upper bound on the number of transports that
> are added to the NFS client's switch?

I don't believe any limits exist right now. Why should there be a
limit? Are you saying that the client should limit trunking? While
this is not what's happening here, but say FS_LOCATION returned 100
ips for the server. Are you saying the client should be limiting how
many trunkable connections it would be establishing and picking just a
few addresses to try? What's happening with this patch is that say
there are 100mounts to 100 ips (each representing the same server or
trunkable server(s)), without this patch a single connection is kept,
with this patch we'll have 100 connections.

>
>
> > +
> > +     if (xprtdata.cred)
> > +             put_cred(xprtdata.cred);
> > +}
> > +
> > /**
> >  * nfs4_init_client - Initialise an NFS4 client record
> >  *
> > @@ -434,6 +472,8 @@ struct nfs_client *nfs4_init_client(struct nfs_client *clp,
> >                * won't try to use it.
> >                */
> >               nfs_mark_client_ready(clp, -EPERM);
> > +             if (old->cl_mvops->session_trunk)
> > +                     nfs4_add_trunk(clp, old);
> >       }
> >       clear_bit(NFS_CS_TSM_POSSIBLE, &clp->cl_flags);
> >       nfs_put_client(clp);
> > --
> > 2.27.0
> >
>
> --
> Chuck Lever
>
>
>
