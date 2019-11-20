Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 679C61040C9
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2019 17:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbfKTQ3I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Nov 2019 11:29:08 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33337 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729442AbfKTQ3I (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Nov 2019 11:29:08 -0500
Received: by mail-vs1-f67.google.com with SMTP id c25so95290vsp.0
        for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2019 08:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8zFeytZPJ2hwodtgn+WYt+KhkY1k3R4sGeEplqalu+M=;
        b=k9beHIcpOy7+kfarhMj2IbD5f6IFWmZZ5u6o9WXKyVjbyckKr8oVxXjbq0aZMnlEQJ
         Ur+XEl9I417mcWhXilkQKt52oTPCjlv8LR0D/roQLkwpM4eYEqLt5tI9Lkt9iCOfMUmh
         axKU21ZDaUp+lFfZvaWPlJWRDL83+3CJu92k3uQWBge+fehLkGDwFsH4aViyMkW4KrVH
         mrIUfZmjsbBxIa8p9ed0bOo9UmULIxPZneC36ffRWubqLf7fIl4U0ltaltgMAFKrc1wM
         x8w0mFyUQCvvIqcciqHWEYp01TS75Wu68OQfHcjwUuWLC5/MeqN2apMEIy186dxV4Gyf
         tGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8zFeytZPJ2hwodtgn+WYt+KhkY1k3R4sGeEplqalu+M=;
        b=nYJpV6UIJ7eryiKsgwfW1b1Nt//V01WGDcd+CjbhAlWH7zNEXndl1y3inDxbPDVE/l
         Q5UFyCCdr6EQeU5ogxzPN5CJ3pg/qMtugE+0DCdjLv5rKrwTAH2B9T++sqLiH7ca/fEN
         H4vOs0WlhhacTzph3yT1WzZ/dXo9eOb+5cpLm04LvvPvyIW98QQNz/vClKfujGC36d3E
         lZqEuEX3J2h2zrow4A7nBFieXvyfmvHky3P5/p6//OsNTG8jKnnnG/AXsY8d4trmMFdh
         3HdOGChVco7V/PFiDDeO/I12Wx4Tah6aa9+mMqa4Nz+LIFz8F1P1V8AYmdWBFp9PLSFD
         VHhQ==
X-Gm-Message-State: APjAAAW0BxgkwwHnY8rzPLXXsBtu/XJOyzXob7Wrf5e3jcnZAtY0UlLH
        +LSYRhLIhp0irdXkxV99syEGW31DcJsGRPrZkRQJ2w==
X-Google-Smtp-Source: APXvYqyDlALLpaehcli1+bbQtgGJ1GZ32emLDSjmspyHZF0J0hHdE7Giin64K3KgXJsBMeWlg7lUV/WrOAaukR79WbQ=
X-Received: by 2002:a67:c097:: with SMTP id x23mr2372934vsi.164.1574267346535;
 Wed, 20 Nov 2019 08:29:06 -0800 (PST)
MIME-Version: 1.0
References: <20191108213201.66194-1-olga.kornievskaia@gmail.com> <d96b92919fdfba28f53cd2770ebb99715c3d9a04.camel@hammerspace.com>
In-Reply-To: <d96b92919fdfba28f53cd2770ebb99715c3d9a04.camel@hammerspace.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 20 Nov 2019 11:28:54 -0500
Message-ID: <CAN-5tyH7sd=pV65LpQmR1+A3TGq4yDGHP2uB82VRqTxnJWfaTw@mail.gmail.com>
Subject: Re: [RFC PATCH] NFS: allow deprecation of NFS UDP protocol
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

On Mon, Nov 18, 2019 at 4:46 AM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> Hi Olga
>
> On Fri, 2019-11-08 at 16:32 -0500, Olga Kornievskaia wrote:
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
> > +       Choose Y here to disable the use of NFS over UDP. NFS over
> > UDP
> > +       on modern networks (1Gb+) can lead to data corruption caused
> > by
> > +       fragmentation during high loads.
> > +       The default is N because many deployments still use UDP.
> > diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> > index 02110a3..24ca314 100644
> > --- a/fs/nfs/client.c
> > +++ b/fs/nfs/client.c
> > @@ -474,6 +474,7 @@ void nfs_init_timeout_values(struct rpc_timeout
> > *to, int proto,
> >                       to->to_maxval = to->to_initval;
> >               to->to_exponential = 0;
> >               break;
> > +#ifdef CONFIG_NFS_DISABLE_UDP_SUPPORT
> >       case XPRT_TRANSPORT_UDP:
> >               if (retrans == NFS_UNSPEC_RETRANS)
> >                       to->to_retries = NFS_DEF_UDP_RETRANS;
> > @@ -484,6 +485,7 @@ void nfs_init_timeout_values(struct rpc_timeout
> > *to, int proto,
> >               to->to_maxval = NFS_MAX_UDP_TIMEOUT;
> >               to->to_exponential = 1;
> >               break;
> > +#endif
> >       default:
> >               BUG();
> >       }
> > @@ -580,8 +582,10 @@ static int nfs_start_lockd(struct nfs_server
> > *server)
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
> > @@ -1011,7 +1011,9 @@ static void nfs_set_port(struct sockaddr *sap,
> > int *port,
> >  static void nfs_validate_transport_protocol(struct
> > nfs_parsed_mount_data *mnt)
> >  {
> >       switch (mnt->nfs_server.protocol) {
> > +#ifdef CONFIG_NFS_DISABLE_UDP_SUPPORT
> >       case XPRT_TRANSPORT_UDP:
> > +#endif
> >       case XPRT_TRANSPORT_TCP:
> >       case XPRT_TRANSPORT_RDMA:
> >               break;
> > @@ -1033,8 +1035,10 @@ static void
> > nfs_set_mount_transport_protocol(struct nfs_parsed_mount_data *mnt)
> >                       return;
> >       switch (mnt->nfs_server.protocol) {
> >       case XPRT_TRANSPORT_UDP:
> > +#ifdef CONFIG_NFS_DISABLE_UDP_SUPPORT
> >               mnt->mount_server.protocol = XPRT_TRANSPORT_UDP;
> >               break;
> > +#endif
>
> Don't we want to return an error here rather than defaulting to the
> TCP/RDMA behaviour?

Actually what I have here is incorrect then because I had things
silently going to TCP instead. Because
nfs_validate_transport_protocol() will set it to TCP so I think
either I change nfs_validate_transport_protocol() and
nfs_set_mount_transport_protocol() to return errors if UDP is
specified or I just leave it as is just have one chunk (below) that
checks the protocol and fails when it's UDP. Do you want less code
change or more explicit failures for UDP?


>
> >       case XPRT_TRANSPORT_TCP:
> >       case XPRT_TRANSPORT_RDMA:
> >               mnt->mount_server.protocol = XPRT_TRANSPORT_TCP;
> > @@ -2204,6 +2208,10 @@ static int nfs_validate_text_mount_data(void
> > *options,
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
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
