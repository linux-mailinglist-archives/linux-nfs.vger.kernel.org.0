Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86913A2E2D
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jun 2021 16:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhFJObf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Jun 2021 10:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbhFJObf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Jun 2021 10:31:35 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFA1C061574
        for <linux-nfs@vger.kernel.org>; Thu, 10 Jun 2021 07:29:23 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id dj8so33301820edb.6
        for <linux-nfs@vger.kernel.org>; Thu, 10 Jun 2021 07:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dt9TBjm040MwDM3XgIAMN7gRv79eJ8KywmKQWhc10OA=;
        b=m5AmbKFWlG/mFe1nTK8h0H3farfgZ3rhO7s5nXuQzR/nT02A5GaOmXykjypHltSQ1g
         yN/NYM/SuDer2H2Qh4So83Vi9p/QNLkpLQxJMIUg3Obf1mkH3PW9ycD3dFu4kzlXT37Y
         PYxxYvOrVhDFHQj5n1dS5JZiR9lW6JRFED0Li7z7FtzwbTRnDO8O+fyHJxejFMzMtiOY
         X6iwMJUK2uOmWgdJYbN2uwABkWrk2sz356ceYNfEE2E82ctpAZD0OP6X4JSQ2/t2UVzV
         enuMHUBIQyV+o6RgL5BwhBn5ZIyLw025X8owpNefXi9GRXRCgxWaHYLpBNGHNftZR3Qa
         9gMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dt9TBjm040MwDM3XgIAMN7gRv79eJ8KywmKQWhc10OA=;
        b=EiCy6AxifSXR6VKNPdUQiZGM1REhm3Ikzch4s72QSf1rShySU3HbAkzWKz8lqoeM5Z
         l7oLQZ7zJUEpRisJV8hBaXNQqK23lw+ZxbFrXlDVvNVEvW/O28tKdzZTZliKmS48txdI
         n9Oe3/Omu2juP4sQX0vaGxWjzN0MD4A/dmd0EiCsHtYHkcHkfOrr7Sc3K/wFhXNwxd2p
         2PT3Iqxf1wYF5QFOzhcY5n/+9VWIyjCL26Ygg57dWE3NRT3u5xb2LiHlH2vB40Kp9LRm
         DAxU/cx5PPgpi28n0YR0m2XogG5yjv3a+Paw4UCzArkH7PNMymlNDZYPxOgDJzUzpDA5
         Yx0g==
X-Gm-Message-State: AOAM533Nl5/rk9gNfudnY3m+pF9NU+oV++h/Wr/tHvkjoaZbHGf/sWAb
        0tdFfMaUMUg5PGFQ14stppmlDDgL/k6Yr0H6O53xmq49I7Y=
X-Google-Smtp-Source: ABdhPJw66Yr0koyuUUYvGzufSZKdi2T/tjSfqMqUqMZ7RdnnLWYmCqH6bsOgXUr9hdyFK1KpcYooUp5Iu2zzFwa7Cso=
X-Received: by 2002:aa7:cb02:: with SMTP id s2mr5040732edt.67.1623335362381;
 Thu, 10 Jun 2021 07:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210609215319.5518-1-olga.kornievskaia@gmail.com>
 <20210609215319.5518-3-olga.kornievskaia@gmail.com> <6C64456A-931F-4CAD-A559-412A12F0F741@oracle.com>
 <6bca80de292b5aa36734e7d942d0e9f53430903b.camel@hammerspace.com> <83D9342E-FDAF-4B2C-A518-20BF0A9AD073@oracle.com>
In-Reply-To: <83D9342E-FDAF-4B2C-A518-20BF0A9AD073@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 10 Jun 2021 10:29:11 -0400
Message-ID: <CAN-5tyGKiT9NESQUq_PxUonf565jw7ENJUa=KmQDDiNGVB1ekg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] NFSv4 introduce max_connect mount options
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 10, 2021 at 9:56 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jun 10, 2021, at 9:34 AM, Trond Myklebust <trondmy@hammerspace.com> wrote:
> >
> > On Thu, 2021-06-10 at 13:30 +0000, Chuck Lever III wrote:
> >>
> >>
> >>> On Jun 9, 2021, at 5:53 PM, Olga Kornievskaia <
> >>> olga.kornievskaia@gmail.com> wrote:
> >>>
> >>> From: Olga Kornievskaia <kolga@netapp.com>
> >>>
> >>> This option will control up to how many xprts can the client
> >>> establish to the server. This patch parses the value and sets
> >>> up structures that keep track of max_connect.
> >>>
> >>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> >>> ---
> >>> fs/nfs/client.c           |  1 +
> >>> fs/nfs/fs_context.c       |  8 ++++++++
> >>> fs/nfs/internal.h         |  2 ++
> >>> fs/nfs/nfs4client.c       | 12 ++++++++++--
> >>> fs/nfs/super.c            |  2 ++
> >>> include/linux/nfs_fs_sb.h |  1 +
> >>> 6 files changed, 24 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> >>> index 330f65727c45..486dec59972b 100644
> >>> --- a/fs/nfs/client.c
> >>> +++ b/fs/nfs/client.c
> >>> @@ -179,6 +179,7 @@ struct nfs_client *nfs_alloc_client(const
> >>> struct nfs_client_initdata *cl_init)
> >>>
> >>>         clp->cl_proto = cl_init->proto;
> >>>         clp->cl_nconnect = cl_init->nconnect;
> >>> +       clp->cl_max_connect = cl_init->max_connect ? cl_init-
> >>>> max_connect : 1;
> >>
> >> So, 1 is the default setting, meaning the "add another transport"
> >> facility is disabled by default. Would it be less surprising for
> >> an admin to allow some extra connections by default?
> >>
> >>
> >>>         clp->cl_net = get_net(cl_init->net);
> >>>
> >>>         clp->cl_principal = "*";
> >>> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> >>> index d95c9a39bc70..cfbff7098f8e 100644
> >>> --- a/fs/nfs/fs_context.c
> >>> +++ b/fs/nfs/fs_context.c
> >>> @@ -29,6 +29,7 @@
> >>> #endif
> >>>
> >>> #define NFS_MAX_CONNECTIONS 16
> >>> +#define NFS_MAX_TRANSPORTS 128
> >>
> >> This maximum seems excessive... again, there are diminishing
> >> returns to adding more connections to the same server. what's
> >> wrong with re-using NFS_MAX_CONNECTIONS for the maximum?
> >>
> >> As always, I'm a little queasy about adding yet another mount
> >> option. Are there real use cases where a whole-client setting
> >> (like a sysfs attribute) would be inadequate? Is there a way
> >> the client could figure out a reasonable maximum without a
> >> human intervention, say, by counting the number of NICs on
> >> the system?
> >
> > Oh, hell no! We're not tying anything to the number of NICs...
>
> That's a bit of an over-reaction. :-) A little more explanation
> would be welcome. I mean, don't you expect someone to ask "How
> do I pick a good value?" and someone might reasonably answer
> "Well, start with the number of NICs on your client times 3" or
> something like that.

That's what I was thinking and thank you for at least considering that
it's a reasonable answer.

> IMO we're about to add another admin setting without understanding
> how it will be used, how to select a good maximum value, or even
> whether this maximum needs to be adjustable. In a previous e-mail
> Olga has already demonstrated that it will be difficult to explain
> how to use this setting with nconnect=.

I agree that understanding on how it will be used is unknown or
understood but I think nconnect and max_connect represent different
capabilities. I agree that adding nconnect transports leads to
diminishing returns after a certain (relatively low) number. However,
I don't believe the same holds for when xprts are going over different
NICs. Therefore I didn't think max_connect should have been bound by
the same numbers as nconnect. Perhaps 128 is too high of a value (for
reference I did 8 *nconnect_max).

> Thus I would favor a (moderate) soldered-in maximum to start with,
> and then as real world use cases arise, consider adding a tuning
> mechanism based on actual requirements.

Can you suggest a moderate number between 16 and 128?

>
>
> --
> Chuck Lever
>
>
>
