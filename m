Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06FD3A36F0
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Jun 2021 00:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhFJWUD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Jun 2021 18:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhFJWUD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Jun 2021 18:20:03 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B93C061574
        for <linux-nfs@vger.kernel.org>; Thu, 10 Jun 2021 15:17:51 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ho18so1458493ejc.8
        for <linux-nfs@vger.kernel.org>; Thu, 10 Jun 2021 15:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ruRxvvAnJ1awWvNogPFSy/2yyF6UDJPwb4FvSvnjlrY=;
        b=vTT54WHC4cUdbHhMjO6wne2DVusSp/CE2g12rwlE/OShUoQ7omBAKJmk52J3COXsf4
         xuWUpv1Hvx2Ue821eab6Uti5Dhs5sQiGK2QmKOmADTeoUBHKzHQh28JOqPYRdWXkrfLs
         GqBr61qjkn4P/itN+CxtJtlb0b5qMeqFGJpstUUUbIgW4MdU8QIl4yS9Hsu5n3F1kR4R
         jCKhcq+UwaRX7Gbn7q3nmfmtldA8VLN6H7su7mH0GbtH/6k5K8hLhXbWnVi5lagFa1m3
         zpxNI0r3MSjiV22q1RmT54UVdW3pkf6spS5Xp+jctSM3cGEK6hRJbUq4UzyaEb7gVZpM
         6VHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ruRxvvAnJ1awWvNogPFSy/2yyF6UDJPwb4FvSvnjlrY=;
        b=r2aMJBPDKQEsiiwWlrox0qh0i1gzIGvzPnKCV30w8zeQ2M4Zwg5gvDas2j2QeVeePj
         VguIFy/zxpw/ie48YFOrAn0TuNnj4QW+GHjN+MquCU7+OWMdGWOazVpGfRQCEJlBeaKc
         GYSIZHa/X3cExR5gDWXUGPuyX45Gpb3AeoJWqFYn81pTnspM/KsKF8R9rrcsWEkLlAK3
         iGwTqosqkgV+co66IDgCMFE4eeBWZZXTqKoyMKRy/MTjJVxzRfNvNyfsMrFTDGyHw0GD
         kly0K3c/t/NsFTwUSZyKJW7Fzq1rUqthLKvOWOd2LzjXLz7ceQq4jtjxNGdd/XKN1HMD
         yC9A==
X-Gm-Message-State: AOAM532s3bi1+RVyv2jB1rkv/FACzy0HHfS9nq0iDLiUs0D3SR4ELfRq
        DdtoT7/50JiSRAfUpWApMWD6lakoCVeiYRH9//w=
X-Google-Smtp-Source: ABdhPJzEXMBEO2e0Prmq2njYBPkPJIKslg5s75KYK3+rNJANei4RdLeH1ep6Et/A6BGQJct+c1V4qNN0dAjvXDxyw2g=
X-Received: by 2002:a17:907:1c9e:: with SMTP id nb30mr635270ejc.0.1623363469644;
 Thu, 10 Jun 2021 15:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210609215319.5518-1-olga.kornievskaia@gmail.com>
 <20210609215319.5518-3-olga.kornievskaia@gmail.com> <6C64456A-931F-4CAD-A559-412A12F0F741@oracle.com>
 <6bca80de292b5aa36734e7d942d0e9f53430903b.camel@hammerspace.com>
 <83D9342E-FDAF-4B2C-A518-20BF0A9AD073@oracle.com> <3658c226b43fb190de38c00e5199ccf35ccc4369.camel@hammerspace.com>
 <CAN-5tyF3BSDvsegLWM6hAOY9QDMbG1LUg9YykXi8rwDcNVXqbA@mail.gmail.com>
 <c7a7a04adbe261d5ca104780c290a44ede1ed4c2.camel@hammerspace.com>
 <CAN-5tyHdciZ+TmRZmwBNeypA4i15L8w5jomCVRNJnMyuVLSUOQ@mail.gmail.com>
 <b8967b4a092feaa7eabd8c09a9dbd1ffc1707495.camel@hammerspace.com> <CAN-5tyFb1nkjJ7ESyC7PQfJhb-Lr=VB2gexhVSFv063dHAnYOw@mail.gmail.com>
In-Reply-To: <CAN-5tyFb1nkjJ7ESyC7PQfJhb-Lr=VB2gexhVSFv063dHAnYOw@mail.gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 10 Jun 2021 18:17:38 -0400
Message-ID: <CAN-5tyGCioFgnHUQZdOsmrj=YCSmbvg2Ahd3_eNX6G_1JM0FRA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] NFSv4 introduce max_connect mount options
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 10, 2021 at 1:30 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> On Thu, Jun 10, 2021 at 12:36 PM Trond Myklebust
> <trondmy@hammerspace.com> wrote:
> >
> > On Thu, 2021-06-10 at 12:14 -0400, Olga Kornievskaia wrote:
> > > On Thu, Jun 10, 2021 at 10:56 AM Trond Myklebust
> > > <trondmy@hammerspace.com> wrote:
> > > >
> > > > On Thu, 2021-06-10 at 10:31 -0400, Olga Kornievskaia wrote:
> > > > > On Thu, Jun 10, 2021 at 10:13 AM Trond Myklebust
> > > > > <trondmy@hammerspace.com> wrote:
> > > > > >
> > > > > > On Thu, 2021-06-10 at 13:56 +0000, Chuck Lever III wrote:
> > > > > > >
> > > > > > >
> > > > > > > > On Jun 10, 2021, at 9:34 AM, Trond Myklebust <
> > > > > > > > trondmy@hammerspace.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, 2021-06-10 at 13:30 +0000, Chuck Lever III wrote:
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > On Jun 9, 2021, at 5:53 PM, Olga Kornievskaia <
> > > > > > > > > > olga.kornievskaia@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > From: Olga Kornievskaia <kolga@netapp.com>
> > > > > > > > > >
> > > > > > > > > > This option will control up to how many xprts can the
> > > > > > > > > > client
> > > > > > > > > > establish to the server. This patch parses the value
> > > > > > > > > > and
> > > > > > > > > > sets
> > > > > > > > > > up structures that keep track of max_connect.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > > > > > > > > ---
> > > > > > > > > > fs/nfs/client.c           |  1 +
> > > > > > > > > > fs/nfs/fs_context.c       |  8 ++++++++
> > > > > > > > > > fs/nfs/internal.h         |  2 ++
> > > > > > > > > > fs/nfs/nfs4client.c       | 12 ++++++++++--
> > > > > > > > > > fs/nfs/super.c            |  2 ++
> > > > > > > > > > include/linux/nfs_fs_sb.h |  1 +
> > > > > > > > > > 6 files changed, 24 insertions(+), 2 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> > > > > > > > > > index 330f65727c45..486dec59972b 100644
> > > > > > > > > > --- a/fs/nfs/client.c
> > > > > > > > > > +++ b/fs/nfs/client.c
> > > > > > > > > > @@ -179,6 +179,7 @@ struct nfs_client
> > > > > > > > > > *nfs_alloc_client(const
> > > > > > > > > > struct nfs_client_initdata *cl_init)
> > > > > > > > > >
> > > > > > > > > >         clp->cl_proto = cl_init->proto;
> > > > > > > > > >         clp->cl_nconnect = cl_init->nconnect;
> > > > > > > > > > +       clp->cl_max_connect = cl_init->max_connect ?
> > > > > > > > > > cl_init-
> > > > > > > > > > > max_connect : 1;
> > > > > > > > >
> > > > > > > > > So, 1 is the default setting, meaning the "add another
> > > > > > > > > transport"
> > > > > > > > > facility is disabled by default. Would it be less
> > > > > > > > > surprising
> > > > > > > > > for
> > > > > > > > > an admin to allow some extra connections by default?
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > >         clp->cl_net = get_net(cl_init->net);
> > > > > > > > > >
> > > > > > > > > >         clp->cl_principal = "*";
> > > > > > > > > > diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> > > > > > > > > > index d95c9a39bc70..cfbff7098f8e 100644
> > > > > > > > > > --- a/fs/nfs/fs_context.c
> > > > > > > > > > +++ b/fs/nfs/fs_context.c
> > > > > > > > > > @@ -29,6 +29,7 @@
> > > > > > > > > > #endif
> > > > > > > > > >
> > > > > > > > > > #define NFS_MAX_CONNECTIONS 16
> > > > > > > > > > +#define NFS_MAX_TRANSPORTS 128
> > > > > > > > >
> > > > > > > > > This maximum seems excessive... again, there are
> > > > > > > > > diminishing
> > > > > > > > > returns to adding more connections to the same server.
> > > > > > > > > what's
> > > > > > > > > wrong with re-using NFS_MAX_CONNECTIONS for the maximum?
> > > > > > > > >
> > > > > > > > > As always, I'm a little queasy about adding yet another
> > > > > > > > > mount
> > > > > > > > > option. Are there real use cases where a whole-client
> > > > > > > > > setting
> > > > > > > > > (like a sysfs attribute) would be inadequate? Is there a
> > > > > > > > > way
> > > > > > > > > the client could figure out a reasonable maximum without
> > > > > > > > > a
> > > > > > > > > human intervention, say, by counting the number of NICs
> > > > > > > > > on
> > > > > > > > > the system?
> > > > > > > >
> > > > > > > > Oh, hell no! We're not tying anything to the number of
> > > > > > > > NICs...
> > > > > > >
> > > > > > > That's a bit of an over-reaction. :-) A little more
> > > > > > > explanation
> > > > > > > would be welcome. I mean, don't you expect someone to ask
> > > > > > > "How
> > > > > > > do I pick a good value?" and someone might reasonably answer
> > > > > > > "Well, start with the number of NICs on your client times 3"
> > > > > > > or
> > > > > > > something like that.
> > > > > > >
> > > > > > > IMO we're about to add another admin setting without
> > > > > > > understanding
> > > > > > > how it will be used, how to select a good maximum value, or
> > > > > > > even
> > > > > > > whether this maximum needs to be adjustable. In a previous e-
> > > > > > > mail
> > > > > > > Olga has already demonstrated that it will be difficult to
> > > > > > > explain
> > > > > > > how to use this setting with nconnect=.
> > > > > > >
> > > > > > > Thus I would favor a (moderate) soldered-in maximum to start
> > > > > > > with,
> > > > > > > and then as real world use cases arise, consider adding a
> > > > > > > tuning
> > > > > > > mechanism based on actual requirements.
> > > > > >
> > > > > > It's not an overreaction. It's insane to think that counting
> > > > > > NICs
> > > > > > gives
> > > > > > you any notion whatsoever about the network topology and
> > > > > > connectivity
> > > > > > between the client and server. It doesn't even tell you how
> > > > > > many of
> > > > > > those NICs might potentially be available to your application.
> > > > > >
> > > > > > We're not doing any automation based on that kind of layering
> > > > > > violation.
> > > > >
> > > > > I'm not suggesting to programmatically determine the number of
> > > > > NIC to
> > > > > determine the value of max_connect.
> > > > > >
> > > >
> > > > No, but that's what Chuck appeared to be suggesting in order to
> > > > avoid
> > > > the need for the mount option.
> > > >
> > > > To me, the main reason for the mount option is to allow the user to
> > > > limit the number of new IP addresses being added so that if the DNS
> > > > server is configured to hand out lots of different addresses for
> > > > the
> > > > same servername, the user can basically say 'no, I just want to use
> > > > the
> > > > one IP address that I'm already connected to' (i.e. max_connect=1).
> > > > I
> > > > can imagine that some clustered setups might need that ability in
> > > > order
> > > > to work efficiently.
> > > >
> > > > I'm fine with the idea of nconnect setting the number of
> > > > connections
> > > > per IP address, but that would need some plumbing in
> > > > rpc_clnt_test_and_add_xprt() to allow us to add up to 'nconnect'
> > > > copies
> > > > of a given transport.
> > > > Presumably rpc_xprt_switch_has_addr() would need to return a count
> > > > of
> > > > the number of copies of the transport that are already present so
> > > > that
> > > > we can decide whether or not we should add a new one.
> > >
> > > I think the last paragraph is what I'm asking for. But I would like
> > > to
> > > again confirm if you still mean "max_connect" to be the total number
> > > of connections since you say we could/will allow for nconnect number
> > > of connections per IP address. Would max_connect need to be a
> > > multiple
> > > of nconnect (max_connect = X *nconnect)?
> >
> > No. Your suggestion to make the two independent is growing on me,
> > however in that case we do want to ensure that if nconnect=X, then we
> > always add X transports when we add a new IP address.
>
> Ok. I'm glad to hear independ idea still has life. Are you still
> thinking "max_connect" is the right name for it? I guess if we explain
> the feature in the man pages the name doesn't matter so much. I would
> have still liked it to be something like "max_session_xprts".
>
> > > Actually when I said supporting (or rather allowing for) nconnect *
> > > max_connect transport, is that correct? Given how the code works now
> > > this is going to be nconnect + max_connect (only if 1st mount had
> > > nconnect option). We can't "add" nconnect connections to the new
> > > mounts (but with my patch we can add a single trunk connection). By
> > > that I mean: say the first was "mount IP1:/vol1 /mnt1" (1 connection
> > > to IP2). Now the client is doing "mount IP2:/vol2 /mnt2". IP1 and IP2
> > > are trunkable addresses of the same server so we add a trunk. We
> > > currently don't allow for doing "mount -o nconnec=2 IP2:vol2 /mnt2"
> > > and then also add "nconnect" connections to IP2 along with a trunk.
> > > In
> > > the 2nd example, we'd have 1 connections to IP1, then 2 connections
> > > to
> > > IP2. Can we allow for that (with needed code change)?  If not, then
> > > we
> > > really need to commit to only support nconnect (16) connections +
> > > some
> > > number of trunkable connections.
> >
> >
> > I think we want to have nconnect be server-global. i.e. nconnect
> > entries of each IP address.

After doing more thinking, I'm not sure I like imposing nconnect
connections on a mount that didn't ask for it when a mount is done to
a trunkable address. It feels like we are going from where we were
conserving resources to creating extra when it wasn't asked for. Note,
I'm not arguing (yet) against "having nconnect be server-global". I
don't have an alternative suggestion.

> Thank you both, Trond and Chuck.
>
> I'll work on v3.
>
>
> >
> > --
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trond.myklebust@hammerspace.com
> >
> >
