Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA6A14F180
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2020 18:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgAaRqj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 31 Jan 2020 12:46:39 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46788 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgAaRqj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 31 Jan 2020 12:46:39 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so9585310wrl.13
        for <linux-nfs@vger.kernel.org>; Fri, 31 Jan 2020 09:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8pUAeuR2JS2cQqGL//Et6o+puTYs7EJ52BYSB78BA4c=;
        b=cqq4SjnD+Bm949Rim0ZnC2D7IsMCwvhHX/KHCzJX1D7dbNfgN0/YS+DJYXg+4mFJgS
         BgWRTifp1853wnFJdJd9VgBC1s9PVpzLRUBBZNJtsRHY3PRWITvkvb0h5Tvu3KWQOP46
         SvbdR7c5fZFpzf3I/WfkdzbI00g1MOvslU8CM2SI4QSOm6D7D5N8zoYUdiywn62jiY1y
         CwOA9b4cPaUE/exMuWlYDFg09e/JDk7AWl7WNBTodL87UOmcI4m+jGV/I7ZUAkNVY4lc
         Gv+E3G8kWcmnkj5FViKMPgCsrAAU7bIp5KiI6AUP3gSdFOeIP+eUkPwZL8JjyOVSTlp3
         UQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8pUAeuR2JS2cQqGL//Et6o+puTYs7EJ52BYSB78BA4c=;
        b=ln2ghHfIF4imghIqYLUunQXR3XDJhnVhQ2AWFhrjMzXdJgErsCAPXmx/syXBcN9y8j
         4ztlNMu1sg6ZhY6E5wfMDqf7J/F2VT0yd5RXA/jV49CPQgrLfU/B0HRq+LAhNC0MgAZF
         C9J7sPOJLd4fBD/2JzXkaHrbpJqK4DZds9XIyC8QVSL5nbd4ConZW8t49xaunV88FkM3
         5o2WrbWGfr3RnPQSoh2Uq7OsybxaCMVinrlvKtzRXPkdKugwnI85i0mQmXidsZZbRaOT
         h7TIVg4SfP4WWjTmr5u+aZ094FBUYMN6UjSqKVE3RjAa1NB2jwCDpPD11gnKROH1+bkX
         6now==
X-Gm-Message-State: APjAAAVexmsyVhxydOOSdr52ZHQBX3+Rn+q0WSiQYc9o2boBdiYYMaOW
        mEm0BuI14ZfzG7bfiYNIZuJUypLCrw0iwS3bcq8=
X-Google-Smtp-Source: APXvYqxsKyk1AtfddzbbdCISTthzP9cZlmcrFxh/FyQ0IDyy0iTaCM3qqF2UeOTjtTOmGx1oTAVISSYFNPYggZtSTIw=
X-Received: by 2002:adf:f411:: with SMTP id g17mr12835104wro.89.1580492796423;
 Fri, 31 Jan 2020 09:46:36 -0800 (PST)
MIME-Version: 1.0
References: <20200131165702.1751-1-olga.kornievskaia@gmail.com> <45AE6B67-4B01-412B-8ABF-94E06BFB77D8@oracle.com>
In-Reply-To: <45AE6B67-4B01-412B-8ABF-94E06BFB77D8@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Fri, 31 Jan 2020 12:46:25 -0500
Message-ID: <CAN-5tyG-Mjk1pvba-9b38Nfp_jA-CUaobtLtPj1UfXyRoj-wxA@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.0 encode nconnect-enabled client into clientid
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

Thanks for the discussion!

On Fri, Jan 31, 2020 at 12:10 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> Hi Olga-
>
> > On Jan 31, 2020, at 11:57 AM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > It helps some servers to be able to identify if the incoming client is
> > doing nconnect mount or not. While creating the unique client id for
> > the SETCLIENTID operation add nconnect=X to it.
>
> This makes me itch uncomfortably.

I was asked...

> The long-form client ID string is not supposed to be used to communicate
> client implementation details. In fact, this string is supposed to be
> opaque to the server -- it can only compare these strings for equality.

Indeed, to servers it should only be using it for equality no argument
there but I don't think they are prohibited from deriving info from it
but shouldn't complain if something changed.

My reasoning was that we are currently already putting some
descriptive stuff into the clientid string. We specify what version
this client is. So why not add something that speaks about its
nconnect ability?

> IMO you would also need to write something akin to a standard that describes
> this convention so that servers can depend on the form of the string.
>
> How would a server use this information?

The server is interested in identifying whether or not client is doing
nconnect or not in order to decide whether or not to apply extra
locking for a given client mount in order to provide best performance.
In 4.1 spec, we clearly define how to bind connections to
session/clientid so server can use that information but 4.0 is lacking
that and a server is left to just deal with existence of multiple
connection (trunking) at any give time.

>
>
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> > fs/nfs/nfs4proc.c | 20 +++++++++++---------
> > 1 file changed, 11 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 402410c..a90ea28 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -5950,7 +5950,7 @@ static void nfs4_init_boot_verifier(const struct nfs_client *clp,
> >               return 0;
> >
> >       rcu_read_lock();
> > -     len = 14 +
> > +     len = 14 + 12 +
> >               strlen(clp->cl_rpcclient->cl_nodename) +
> >               1 +
> >               strlen(rpc_peeraddr2str(clp->cl_rpcclient, RPC_DISPLAY_ADDR)) +
> > @@ -5972,13 +5972,15 @@ static void nfs4_init_boot_verifier(const struct nfs_client *clp,
> >
> >       rcu_read_lock();
> >       if (nfs4_client_id_uniquifier[0] != '\0')
> > -             scnprintf(str, len, "Linux NFSv4.0 %s/%s/%s",
> > +             scnprintf(str, len, "Linux NFSv4.0 nconnect=%d %s/%s/%s",
> > +                       clp->cl_nconnect,
> >                         clp->cl_rpcclient->cl_nodename,
> >                         nfs4_client_id_uniquifier,
> >                         rpc_peeraddr2str(clp->cl_rpcclient,
> >                                          RPC_DISPLAY_ADDR));
> >       else
> > -             scnprintf(str, len, "Linux NFSv4.0 %s/%s",
> > +             scnprintf(str, len, "Linux NFSv4.0 nconnect=%d %s/%s",
> > +                       clp->cl_nconnect,
> >                         clp->cl_rpcclient->cl_nodename,
> >                         rpc_peeraddr2str(clp->cl_rpcclient,
> >                                          RPC_DISPLAY_ADDR));
> > @@ -5994,7 +5996,7 @@ static void nfs4_init_boot_verifier(const struct nfs_client *clp,
> >       size_t len;
> >       char *str;
> >
> > -     len = 10 + 10 + 1 + 10 + 1 +
> > +     len = 10 + 10 + 1 + 10 + 1 + 12 +
> >               strlen(nfs4_client_id_uniquifier) + 1 +
> >               strlen(clp->cl_rpcclient->cl_nodename) + 1;
> >
> > @@ -6010,9 +6012,9 @@ static void nfs4_init_boot_verifier(const struct nfs_client *clp,
> >       if (!str)
> >               return -ENOMEM;
> >
> > -     scnprintf(str, len, "Linux NFSv%u.%u %s/%s",
> > +     scnprintf(str, len, "Linux NFSv%u.%u nconnect=%d %s/%s",
> >                       clp->rpc_ops->version, clp->cl_minorversion,
> > -                     nfs4_client_id_uniquifier,
> > +                     clp->cl_nconnect, nfs4_client_id_uniquifier,
> >                       clp->cl_rpcclient->cl_nodename);
>
> Doesn't this also change the client ID string used for EXCHANGE_ID ?

I didn't think it would hurt there. But honestly, I just didn't know
which of the 3 functions that we have to create clientid were used for
what protocols so I added nconnect to all.

>
>
> >       clp->cl_owner_id = str;
> >       return 0;
> > @@ -6030,7 +6032,7 @@ static void nfs4_init_boot_verifier(const struct nfs_client *clp,
> >       if (nfs4_client_id_uniquifier[0] != '\0')
> >               return nfs4_init_uniquifier_client_string(clp);
> >
> > -     len = 10 + 10 + 1 + 10 + 1 +
> > +     len = 10 + 10 + 1 + 10 + 1 + 12 +
> >               strlen(clp->cl_rpcclient->cl_nodename) + 1;
> >
> >       if (len > NFS4_OPAQUE_LIMIT + 1)
> > @@ -6045,9 +6047,9 @@ static void nfs4_init_boot_verifier(const struct nfs_client *clp,
> >       if (!str)
> >               return -ENOMEM;
> >
> > -     scnprintf(str, len, "Linux NFSv%u.%u %s",
> > +     scnprintf(str, len, "Linux NFSv%u.%u nconnect=%d %s",
> >                       clp->rpc_ops->version, clp->cl_minorversion,
> > -                     clp->cl_rpcclient->cl_nodename);
> > +                     clp->cl_nconnect, clp->cl_rpcclient->cl_nodename);
> >       clp->cl_owner_id = str;
> >       return 0;
> > }
> > --
> > 1.8.3.1
> >
>
> --
> Chuck Lever
>
>
>
