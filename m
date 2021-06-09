Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF25B3A1E46
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jun 2021 22:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhFIUtw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Jun 2021 16:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhFIUtw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Jun 2021 16:49:52 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72885C061574
        for <linux-nfs@vger.kernel.org>; Wed,  9 Jun 2021 13:47:45 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ce15so40410250ejb.4
        for <linux-nfs@vger.kernel.org>; Wed, 09 Jun 2021 13:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bRxXSTuSLOdSMTX/fgrt1CLJi2fgjQJgT9Sn/TcTPHw=;
        b=b0G2MgYg7aYUZj3hGtPQHUPJCcnlC7RuSR7WNge8A+JThfw4bLXmKuVTmz+8bHkKDi
         J6xKhsbGcMvIymXfTynKqcqoDdHquaZM7P4QsxfEF3TUfMWFIMXyH0Izx1ML5Ccf+Jus
         ZEhE2ip4B9euhwyHeBA2LV5LjlMTx10DTP+umJypQpwETI5TgTAxNH1wYggYydlTpYXJ
         R5P7a5S5EywCumDrpzA19OXpLOgkMT9vBaE7VQNYoDSYXXCORfe1PJ+prPyUkqrUiCy8
         SSGHAPvu+ar3I77S/vVI/iM+oKQlr8s8rK55oCv4H5nI81zDfbmQBjrzhHOCVbsqUFhm
         ba/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bRxXSTuSLOdSMTX/fgrt1CLJi2fgjQJgT9Sn/TcTPHw=;
        b=JkTOiRzDJt2Y8xI1U0CbsLKioI9LL2MuSTM6Jp6AMslGBdZFLC9kdoSP3vdl3pZd06
         8SFJ4AuG+esQEFsiQ9TnAjkZQJdQSeQssICpZ0qdtIOMmiB7qoOWptbFG2jd7YYgP6eE
         /+J25Lyw4GzXvJpqp/KABXbBwEjBG4B/kKLQbeNrdiyj0t54yziiq8XKQo+/3VGDBCRq
         7qDo6I1vAwjeiYuvj0epdK23Nn62iwo8WT5K6r/Jazn5F7q0LSp54QzDVj/bGatfHeK0
         EjipY325I6lEzrlGMVn0FULWgaDt8vWvRbEH3gUMn6E+YatEi3YrPPVkNQy2aU1siEhm
         Zl9Q==
X-Gm-Message-State: AOAM531abi5yXFgq6kOC6RKA+v4Y22ZwbX1NzQjJ/DVat0XtFtfYC4A1
        kGrBT6EpGI8HuhNuIBHSyUXcmUPOXskmjAAVOBA=
X-Google-Smtp-Source: ABdhPJxYTrlARkOPqCYgfB1DlVe+xBxaISh296ZlQWbrsBY0JOn8lzCBR01xfSqojj/nauEieIm46u41SYLRmXagItk=
X-Received: by 2002:a17:906:998c:: with SMTP id af12mr1535253ejc.510.1623271663832;
 Wed, 09 Jun 2021 13:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210608184527.87018-1-olga.kornievskaia@gmail.com>
 <C9C7FA2C-1913-4332-91EA-B51F8E104728@oracle.com> <CAN-5tyFYyxYr4joR6uPR7zoFToYMmntNdkUkNWV=g33OVXFuOw@mail.gmail.com>
 <29835A59-A523-49FD-8D28-06CDC2F0E94C@oracle.com>
In-Reply-To: <29835A59-A523-49FD-8D28-06CDC2F0E94C@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 9 Jun 2021 16:47:32 -0400
Message-ID: <CAN-5tyF_YOGuDNG3mtm1Ua6HMwF1jXiZ7Q_Z7SjAhNzjdQ8dBg@mail.gmail.com>
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
>
> As for the behavior... Seems to me that there are going to be only
> infinitesimal gains after the first few connections, and after
> that, it's going to be a lot for both sides to manage for no real
> gain. I think you do want to cap the total number of connections
> at a reasonable number, even in the FS_LOCATIONS case.

To both Trond and Chuck,

If we were to cap the max number transports how to manage nconnect
transports and trunking transports. Are they the "same" transports? So
for instance, if somebody specified nconnect=10,max_connect=2 which
one matters more. Should nconnect be cut at 2? And that would mean all
the allowable transports are used up by nconnect.

But we've seen that there is benefit from creating multiple
connections for a single NIC. But in a multi-NIC environment, it means
multiple connections on each NIC, wouldn't it?So should we say allow
nconnect * max_connect value of transports instead? Or does the admin
need to calculate that value to make sure that max_connect reflects
that?

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
