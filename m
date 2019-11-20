Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABCB51040D5
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2019 17:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfKTQbZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Nov 2019 11:31:25 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37799 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbfKTQbY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Nov 2019 11:31:24 -0500
Received: by mail-vs1-f66.google.com with SMTP id u6so78873vsp.4
        for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2019 08:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W2FR3HIzCyf+nrxQRTRre1IjoDJwh455q/45UWuZ9eo=;
        b=KdXjMj0ixzSTnqiC6VMw+o20vx+s7deuZmK7fBTDXHHim5vLkf4891+khQ5g82Lupu
         lctY9+WVJYplqbUUJrKQaVBxhvrE9CXlVJbFHGV67Fd7iRYXk2MmZo0o3NNXmfHRH76X
         s1L55cnX4T0rSZBLwe24vwN3xeemrM8aHrnFCfXYZvS+tb+tBxpw7YP2nUGX7LZvkNOT
         30ItmAegc28CK20W+tEXrOfPZ07requdfuoloi9Zz6cXj2YGtvrS8a4pafmFHh7YE0KD
         seA/wL+pzPsXxq041wC7op7afNkw07c1ybL2TrDSobSH+GlFgZX2ZIvIXap9g1yQvPNv
         PbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W2FR3HIzCyf+nrxQRTRre1IjoDJwh455q/45UWuZ9eo=;
        b=VtXURDhSOGBEhWqfcAotyuIRjIO6O8l2FHyEWbGGzt0oQ1EFFywSqiQUnrgz4EqfO8
         ZerpWhgLlNGUrpziI12/5UU6EPLR6QVbUWEULkOUVfH35gFoXmOXSqhMCx06XP1zKFeS
         nSCUi5ulPUxdcGJKgQLPbsT3N5e5Xcns8bL521NaGbaPG8ncWgRRzIRuwhGdYelS6VrD
         YQlepeDZPelYY93KP+O3zQeaI8nhksMain88cj3oAWO2RIYg+py7RjpTJmRAHMO2IRNr
         2SXWaWi4rfA7Xo7C+8JD9AS6mHThvDcD6kzYfp7n/Q6p7mN1wH/83n8iApJggvoFBCDC
         XTSw==
X-Gm-Message-State: APjAAAV6872f+krkk2XKK4YUrnkYPJ7qRVytsD1LspxbzqiUGEd/mzqw
        FQa23LVlFUrFFmyor4YbC/uQtc8UE7vUoDS5n1s6JQ==
X-Google-Smtp-Source: APXvYqznYilk5xpFR6QkGde2Aw+L7UawCd4FCn28VBVRFQiJ8JhyxoSIXTMezOrf6t4NPI2YfLKkyk8bJ3FS+BoKgrY=
X-Received: by 2002:a67:fb02:: with SMTP id d2mr2388033vsr.194.1574267480987;
 Wed, 20 Nov 2019 08:31:20 -0800 (PST)
MIME-Version: 1.0
References: <20191108213201.66194-1-olga.kornievskaia@gmail.com> <90930069-baaa-03b7-56a5-e9012a85cae6@RedHat.com>
In-Reply-To: <90930069-baaa-03b7-56a5-e9012a85cae6@RedHat.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 20 Nov 2019 11:31:08 -0500
Message-ID: <CAN-5tyExYP8N0gvd_F_sbVHrjcau=LwR66uq0gPRaijVvywxQw@mail.gmail.com>
Subject: Re: [RFC PATCH] NFS: allow deprecation of NFS UDP protocol
To:     Steve Dickson <SteveD@redhat.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 18, 2019 at 1:42 PM Steve Dickson <SteveD@redhat.com> wrote:
>
>
>
> On 11/8/19 4:32 PM, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Add a kernel config CONFIG_NFS_DISABLE_UDP_SUPPORT to disallow NFS
> > UDP mounts.
> >
> > I took the same approach as Chuck's deprecation of DES enc types
> > to start with default to still allow but I think the ultimate
> > goal is to disable
> >
> > Question: how do we have folks trying this unless we set it to false?
> Exactly... Why not do the opposite? Off by default... instead of
> having to set the variable to turn UDP off?

OK! v2 will turn this off by default instead.

>
> steved.
>
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  fs/nfs/Kconfig  | 10 ++++++++++
> >  fs/nfs/client.c |  4 ++++
> >  fs/nfs/super.c  |  8 ++++++++
> >  3 files changed, 22 insertions(+)
> >
> > diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
> > index 295a7a2..6320113 100644
> > --- a/fs/nfs/Kconfig
> > +++ b/fs/nfs/Kconfig
> > @@ -196,3 +196,13 @@ config NFS_DEBUG
> >       depends on NFS_FS && SUNRPC_DEBUG
> >       select CRC32
> >       default y
> > +
> > +config NFS_DISABLE_UDP_SUPPORT
> > +     bool "NFS: Disable NFS UDP protocol support"
> > +     depends on NFS_FS
> > +     default n
> > +     help
> > +       Choose Y here to disable the use of NFS over UDP. NFS over UDP
> > +       on modern networks (1Gb+) can lead to data corruption caused by
> > +       fragmentation during high loads.
> > +       The default is N because many deployments still use UDP.
> > diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> > index 02110a3..24ca314 100644
> > --- a/fs/nfs/client.c
> > +++ b/fs/nfs/client.c
> > @@ -474,6 +474,7 @@ void nfs_init_timeout_values(struct rpc_timeout *to, int proto,
> >                       to->to_maxval = to->to_initval;
> >               to->to_exponential = 0;
> >               break;
> > +#ifdef CONFIG_NFS_DISABLE_UDP_SUPPORT
> >       case XPRT_TRANSPORT_UDP:
> >               if (retrans == NFS_UNSPEC_RETRANS)
> >                       to->to_retries = NFS_DEF_UDP_RETRANS;
> > @@ -484,6 +485,7 @@ void nfs_init_timeout_values(struct rpc_timeout *to, int proto,
> >               to->to_maxval = NFS_MAX_UDP_TIMEOUT;
> >               to->to_exponential = 1;
> >               break;
> > +#endif
> >       default:
> >               BUG();
> >       }
> > @@ -580,8 +582,10 @@ static int nfs_start_lockd(struct nfs_server *server)
> >               default:
> >                       nlm_init.protocol = IPPROTO_TCP;
> >                       break;
> > +#ifdef CONFIG_NFS_DISABLE_UDP_SUPPORT
> >               case XPRT_TRANSPORT_UDP:
> >                       nlm_init.protocol = IPPROTO_UDP;
> > +#endif
> >       }
> >
> >       host = nlmclnt_init(&nlm_init);
> > diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> > index a84df7d6..21e59da 100644
> > --- a/fs/nfs/super.c
> > +++ b/fs/nfs/super.c
> > @@ -1011,7 +1011,9 @@ static void nfs_set_port(struct sockaddr *sap, int *port,
> >  static void nfs_validate_transport_protocol(struct nfs_parsed_mount_data *mnt)
> >  {
> >       switch (mnt->nfs_server.protocol) {
> > +#ifdef CONFIG_NFS_DISABLE_UDP_SUPPORT
> >       case XPRT_TRANSPORT_UDP:
> > +#endif
> >       case XPRT_TRANSPORT_TCP:
> >       case XPRT_TRANSPORT_RDMA:
> >               break;
> > @@ -1033,8 +1035,10 @@ static void nfs_set_mount_transport_protocol(struct nfs_parsed_mount_data *mnt)
> >                       return;
> >       switch (mnt->nfs_server.protocol) {
> >       case XPRT_TRANSPORT_UDP:
> > +#ifdef CONFIG_NFS_DISABLE_UDP_SUPPORT
> >               mnt->mount_server.protocol = XPRT_TRANSPORT_UDP;
> >               break;
> > +#endif
> >       case XPRT_TRANSPORT_TCP:
> >       case XPRT_TRANSPORT_RDMA:
> >               mnt->mount_server.protocol = XPRT_TRANSPORT_TCP;
> > @@ -2204,6 +2208,10 @@ static int nfs_validate_text_mount_data(void *options,
> >  #endif /* CONFIG_NFS_V4 */
> >       } else {
> >               nfs_set_mount_transport_protocol(args);
> > +#ifdef CONFIG_NFS_DISABLE_UDP_SUPPORT
> > +             if (args->nfs_server.protocol == XPRT_TRANSPORT_UDP)
> > +                     goto out_invalid_transport_udp;
> > +#endif
> >               if (args->nfs_server.protocol == XPRT_TRANSPORT_RDMA)
> >                       port = NFS_RDMA_PORT;
> >       }
> >
>
