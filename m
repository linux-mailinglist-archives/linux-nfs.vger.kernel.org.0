Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6336E3A2E41
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jun 2021 16:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhFJOeC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Jun 2021 10:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhFJOeB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Jun 2021 10:34:01 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A50C061574
        for <linux-nfs@vger.kernel.org>; Thu, 10 Jun 2021 07:31:51 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id g8so44571430ejx.1
        for <linux-nfs@vger.kernel.org>; Thu, 10 Jun 2021 07:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HT/E6REznajSpBK8YTqVDwwQrrrov2BpEnM4XwBEzno=;
        b=CTU3UYEhwoTTXbdnVmcLGjnIivQhq8sO4y6b7xuYyQegSfisBPU88t/siDmKTGqF+h
         wXUapIG1oUogVMrkimtVbf+JFGfrDjAJv/aEhVET/XfER3SsYT3gijujeL5L7Qvd7lUp
         NWdU9Hw63p2BPEI+2tFvmldqZM5695thUCDSBzrmCjnqgYSjagR52BAPqdhCV5zY/tl/
         QEpuQQ1PFzI33Ff6rqD5lHqBQ37WV3H5pyTb7AwsRyklvU7uVSIL6lPVNp0pl8MgOQbM
         CMevWckcBLEKx5Zm7e+vzWLIxbKTU5k95NltBAo8Yrp3ATOnhfF7NUIWYs/uL0SaGKAd
         Wawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HT/E6REznajSpBK8YTqVDwwQrrrov2BpEnM4XwBEzno=;
        b=V5N6VhWIyoGHW52U6QXlgXLUoyxjVmekWTkW1WdtNl8OS9kULDHG0Rw/cPNP3oFKAB
         NCsrd1galKgpzzhUINeFy6RRjrvL58mzuCjGLb/kH1/h2wrl8aRoafrSMtGOhcEkWmxl
         cfSSZhsFVGElC5zKyzkoKU3ABKEueZsCUOgw9Pjqxyu4md5CKia+7VhTwgxno8ofG5qQ
         0QeoTKXYKmSsJGrgYJSJRE/mNS80Oo9DonDIrh/TaxpNZoXErjvXLbBPWhTqlyZRd0a7
         K85cuL3RJmeogLPaTtU6dfXXBccylHx1s4xY7/UPC/Uknr6bKLY1bMmQF1JDjEsTFKqf
         0ccQ==
X-Gm-Message-State: AOAM5307aQsLl2M/UXaMiX19xJeRVQxrCgSRClCwVtBQRDEDhPgxQ5V1
        spMQ4BGuVqimgwKAWuEiCxgDzBALPz5RJyXt3Ck=
X-Google-Smtp-Source: ABdhPJwaewaR12AEbJCu66XXg9X9M5PJ599LpD2u3RgHZDBrVfvz0BwUkwj/ZdSww5Q83I14uJK1wJ365kVXxwVEhcg=
X-Received: by 2002:a17:907:3e26:: with SMTP id hp38mr4866710ejc.451.1623335509531;
 Thu, 10 Jun 2021 07:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210609215319.5518-1-olga.kornievskaia@gmail.com>
 <20210609215319.5518-3-olga.kornievskaia@gmail.com> <6C64456A-931F-4CAD-A559-412A12F0F741@oracle.com>
 <6bca80de292b5aa36734e7d942d0e9f53430903b.camel@hammerspace.com>
 <83D9342E-FDAF-4B2C-A518-20BF0A9AD073@oracle.com> <3658c226b43fb190de38c00e5199ccf35ccc4369.camel@hammerspace.com>
In-Reply-To: <3658c226b43fb190de38c00e5199ccf35ccc4369.camel@hammerspace.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 10 Jun 2021 10:31:38 -0400
Message-ID: <CAN-5tyF3BSDvsegLWM6hAOY9QDMbG1LUg9YykXi8rwDcNVXqbA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] NFSv4 introduce max_connect mount options
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 10, 2021 at 10:13 AM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
> On Thu, 2021-06-10 at 13:56 +0000, Chuck Lever III wrote:
> >
> >
> > > On Jun 10, 2021, at 9:34 AM, Trond Myklebust <
> > > trondmy@hammerspace.com> wrote:
> > >
> > > On Thu, 2021-06-10 at 13:30 +0000, Chuck Lever III wrote:
> > > >
> > > >
> > > > > On Jun 9, 2021, at 5:53 PM, Olga Kornievskaia <
> > > > > olga.kornievskaia@gmail.com> wrote:
> > > > >
> > > > > From: Olga Kornievskaia <kolga@netapp.com>
> > > > >
> > > > > This option will control up to how many xprts can the client
> > > > > establish to the server. This patch parses the value and sets
> > > > > up structures that keep track of max_connect.
> > > > >
> > > > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > > > ---
> > > > > fs/nfs/client.c           |  1 +
> > > > > fs/nfs/fs_context.c       |  8 ++++++++
> > > > > fs/nfs/internal.h         |  2 ++
> > > > > fs/nfs/nfs4client.c       | 12 ++++++++++--
> > > > > fs/nfs/super.c            |  2 ++
> > > > > include/linux/nfs_fs_sb.h |  1 +
> > > > > 6 files changed, 24 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> > > > > index 330f65727c45..486dec59972b 100644
> > > > > --- a/fs/nfs/client.c
> > > > > +++ b/fs/nfs/client.c
> > > > > @@ -179,6 +179,7 @@ struct nfs_client *nfs_alloc_client(const
> > > > > struct nfs_client_initdata *cl_init)
> > > > >
> > > > >         clp->cl_proto = cl_init->proto;
> > > > >         clp->cl_nconnect = cl_init->nconnect;
> > > > > +       clp->cl_max_connect = cl_init->max_connect ? cl_init-
> > > > > > max_connect : 1;
> > > >
> > > > So, 1 is the default setting, meaning the "add another transport"
> > > > facility is disabled by default. Would it be less surprising for
> > > > an admin to allow some extra connections by default?
> > > >
> > > >
> > > > >         clp->cl_net = get_net(cl_init->net);
> > > > >
> > > > >         clp->cl_principal = "*";
> > > > > diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> > > > > index d95c9a39bc70..cfbff7098f8e 100644
> > > > > --- a/fs/nfs/fs_context.c
> > > > > +++ b/fs/nfs/fs_context.c
> > > > > @@ -29,6 +29,7 @@
> > > > > #endif
> > > > >
> > > > > #define NFS_MAX_CONNECTIONS 16
> > > > > +#define NFS_MAX_TRANSPORTS 128
> > > >
> > > > This maximum seems excessive... again, there are diminishing
> > > > returns to adding more connections to the same server. what's
> > > > wrong with re-using NFS_MAX_CONNECTIONS for the maximum?
> > > >
> > > > As always, I'm a little queasy about adding yet another mount
> > > > option. Are there real use cases where a whole-client setting
> > > > (like a sysfs attribute) would be inadequate? Is there a way
> > > > the client could figure out a reasonable maximum without a
> > > > human intervention, say, by counting the number of NICs on
> > > > the system?
> > >
> > > Oh, hell no! We're not tying anything to the number of NICs...
> >
> > That's a bit of an over-reaction. :-) A little more explanation
> > would be welcome. I mean, don't you expect someone to ask "How
> > do I pick a good value?" and someone might reasonably answer
> > "Well, start with the number of NICs on your client times 3" or
> > something like that.
> >
> > IMO we're about to add another admin setting without understanding
> > how it will be used, how to select a good maximum value, or even
> > whether this maximum needs to be adjustable. In a previous e-mail
> > Olga has already demonstrated that it will be difficult to explain
> > how to use this setting with nconnect=.
> >
> > Thus I would favor a (moderate) soldered-in maximum to start with,
> > and then as real world use cases arise, consider adding a tuning
> > mechanism based on actual requirements.
>
> It's not an overreaction. It's insane to think that counting NICs gives
> you any notion whatsoever about the network topology and connectivity
> between the client and server. It doesn't even tell you how many of
> those NICs might potentially be available to your application.
>
> We're not doing any automation based on that kind of layering
> violation.

I'm not suggesting to programmatically determine the number of NIC to
determine the value of max_connect.

>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
