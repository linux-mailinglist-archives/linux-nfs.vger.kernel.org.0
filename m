Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458153A2EEA
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jun 2021 17:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhFJPEN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Jun 2021 11:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbhFJPEN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Jun 2021 11:04:13 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2350AC061760
        for <linux-nfs@vger.kernel.org>; Thu, 10 Jun 2021 08:02:03 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b11so33440839edy.4
        for <linux-nfs@vger.kernel.org>; Thu, 10 Jun 2021 08:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WluuCyMf5JpNWUd1SNHmW1b1ylImoBCTbhzEMSsHd7c=;
        b=S1Y373+El84+ZzPIaBDWvSDaw3rC4/gJctx73WvObDN442B4epCNIepSAWWYHQPjAs
         nelHGr4AcOqGrGTIjOEWldT+LlKJKAXawuBEgU0zIDcvbG/8KEDzhTqaQLRnPCa07wqz
         K7eRHCtmv5MV/9oWroGsRd/cH4TfsLHL3shT+ZPoLB9W7LjCfJfY05k3AQxFZDbR5HwR
         UdNXWV1UiLLVtm1dp64Si5FITi2R+HVz5NKQRm21AFHfECt1EAXI3GsGgrEdCEor9AUX
         b97+IR7CuCgpZj16R0YPCZTSPtKh+Mbzt0Qnmq7P2R+yoKCsjvlKyYf51d4CXLdg2+Nu
         XqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WluuCyMf5JpNWUd1SNHmW1b1ylImoBCTbhzEMSsHd7c=;
        b=jxK+6EJdBMvt8BeSRZ+eQRrTQfmub7nDLHHIIyEdAn/HuYATvQLJeZ5qlbcQH9FSLC
         mUtend6Lb294MCn+Pta4FZPmVHttYlqEkdBbD5Ezqs3lxs9ohwK+TkMitCg3k72czjpV
         hkCvkyfqqLjXJfm2v/BW8xF7JktiCQXmWjH2N6hvfr9lb+rHZzFDDB1pgYYIprzNI/FK
         XP0vXMVAq3bzbdrlbXOveUWMZAiX16TPTAAyOqm7uGPwbOBcxuhec4is/iTPa8Z8C1te
         7+yk68YLHq8pZDon9hXQHVAl+esUc+dxSDT2G9DsF9kQaUl9Xa7oe/EqOwIR0gLyxhV8
         do7w==
X-Gm-Message-State: AOAM530CGsOrdAUQH+gQEpv2QpzFpavzKhxRUiW/s3cm0vxwMRIPLk/z
        cbv/ZmzJyyMEkMA0HX6j9c9lOvEmbPcRF4KD7UQ=
X-Google-Smtp-Source: ABdhPJxl6ZDOBHRr+CEJEcUUbPP6Lzk7P1m4PWfhXLwCs0c4DtqtDDGikyRFu/z9AkaqzUkOzThIDg9t8epl9MtV0FM=
X-Received: by 2002:aa7:d555:: with SMTP id u21mr5404925edr.84.1623337320794;
 Thu, 10 Jun 2021 08:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210609215319.5518-1-olga.kornievskaia@gmail.com>
 <20210609215319.5518-3-olga.kornievskaia@gmail.com> <6C64456A-931F-4CAD-A559-412A12F0F741@oracle.com>
 <6bca80de292b5aa36734e7d942d0e9f53430903b.camel@hammerspace.com>
 <83D9342E-FDAF-4B2C-A518-20BF0A9AD073@oracle.com> <CAN-5tyGKiT9NESQUq_PxUonf565jw7ENJUa=KmQDDiNGVB1ekg@mail.gmail.com>
 <1902AFD9-76B8-44F2-928C-C830CDFAA33B@oracle.com>
In-Reply-To: <1902AFD9-76B8-44F2-928C-C830CDFAA33B@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 10 Jun 2021 11:01:49 -0400
Message-ID: <CAN-5tyEFtOa97+vdCeCyHtdub8n5zHSP8sv7Zv2CCnd_duv5fg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] NFSv4 introduce max_connect mount options
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 10, 2021 at 10:51 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jun 10, 2021, at 10:29 AM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >
> > On Thu, Jun 10, 2021 at 9:56 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
> >>
> >>
> >>
> >>> On Jun 10, 2021, at 9:34 AM, Trond Myklebust <trondmy@hammerspace.com> wrote:
> >>>
> >>> On Thu, 2021-06-10 at 13:30 +0000, Chuck Lever III wrote:
> >>>>
> >>>>
> >>>>> On Jun 9, 2021, at 5:53 PM, Olga Kornievskaia <
> >>>>> olga.kornievskaia@gmail.com> wrote:
> >>>>>
> >>>>> From: Olga Kornievskaia <kolga@netapp.com>
> >>>>>
> >>>>> This option will control up to how many xprts can the client
> >>>>> establish to the server. This patch parses the value and sets
> >>>>> up structures that keep track of max_connect.
> >>>>>
> >>>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> >>>>> ---
> >>>>> fs/nfs/client.c           |  1 +
> >>>>> fs/nfs/fs_context.c       |  8 ++++++++
> >>>>> fs/nfs/internal.h         |  2 ++
> >>>>> fs/nfs/nfs4client.c       | 12 ++++++++++--
> >>>>> fs/nfs/super.c            |  2 ++
> >>>>> include/linux/nfs_fs_sb.h |  1 +
> >>>>> 6 files changed, 24 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> >>>>> index 330f65727c45..486dec59972b 100644
> >>>>> --- a/fs/nfs/client.c
> >>>>> +++ b/fs/nfs/client.c
> >>>>> @@ -179,6 +179,7 @@ struct nfs_client *nfs_alloc_client(const
> >>>>> struct nfs_client_initdata *cl_init)
> >>>>>
> >>>>>        clp->cl_proto = cl_init->proto;
> >>>>>        clp->cl_nconnect = cl_init->nconnect;
> >>>>> +       clp->cl_max_connect = cl_init->max_connect ? cl_init-
> >>>>>> max_connect : 1;
> >>>>
> >>>> So, 1 is the default setting, meaning the "add another transport"
> >>>> facility is disabled by default. Would it be less surprising for
> >>>> an admin to allow some extra connections by default?
> >>>>
> >>>>
> >>>>>        clp->cl_net = get_net(cl_init->net);
> >>>>>
> >>>>>        clp->cl_principal = "*";
> >>>>> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> >>>>> index d95c9a39bc70..cfbff7098f8e 100644
> >>>>> --- a/fs/nfs/fs_context.c
> >>>>> +++ b/fs/nfs/fs_context.c
> >>>>> @@ -29,6 +29,7 @@
> >>>>> #endif
> >>>>>
> >>>>> #define NFS_MAX_CONNECTIONS 16
> >>>>> +#define NFS_MAX_TRANSPORTS 128
> >>>>
> >>>> This maximum seems excessive... again, there are diminishing
> >>>> returns to adding more connections to the same server. what's
> >>>> wrong with re-using NFS_MAX_CONNECTIONS for the maximum?
> >>>>
> >>>> As always, I'm a little queasy about adding yet another mount
> >>>> option. Are there real use cases where a whole-client setting
> >>>> (like a sysfs attribute) would be inadequate? Is there a way
> >>>> the client could figure out a reasonable maximum without a
> >>>> human intervention, say, by counting the number of NICs on
> >>>> the system?
> >>>
> >>> Oh, hell no! We're not tying anything to the number of NICs...
> >>
> >> That's a bit of an over-reaction. :-) A little more explanation
> >> would be welcome. I mean, don't you expect someone to ask "How
> >> do I pick a good value?" and someone might reasonably answer
> >> "Well, start with the number of NICs on your client times 3" or
> >> something like that.
> >
> > That's what I was thinking and thank you for at least considering that
> > it's a reasonable answer.
> >
> >> IMO we're about to add another admin setting without understanding
> >> how it will be used, how to select a good maximum value, or even
> >> whether this maximum needs to be adjustable. In a previous e-mail
> >> Olga has already demonstrated that it will be difficult to explain
> >> how to use this setting with nconnect=.
> >
> > I agree that understanding on how it will be used is unknown or
> > understood but I think nconnect and max_connect represent different
> > capabilities. I agree that adding nconnect transports leads to
> > diminishing returns after a certain (relatively low) number. However,
> > I don't believe the same holds for when xprts are going over different
> > NICs. Therefore I didn't think max_connect should have been bound by
> > the same numbers as nconnect.
>
> Thanks for reminding me, I had forgotten the distinction between
> the two mount options.
>
> I think there's more going on than just the NIC -- lock contention
> on the client will also be a somewhat limiting factor, as will the
> number of local CPUs and memory bandwidth. And as Trond points out,
> the network topology between the client and server will also have
> some impact.
>
> And I'm trying to understand why an admin would want to turn off
> the "add another xprt" mechanism -- ie, the lower bound. Why is
> the default setting 1?

I think the reason for having default as 1 was to address Trond's
comment that some servers are struggling to support nconnect. So I'm
trying not to force any current setup to needing to change their mount
setup to specifically say "max_connect=1". I want environments that
can support trunking specifically allow for trunking by adding a new
mount option to increase the limit.

If this is not a concern then max_connect's default can just be the
whatever default value we pick for the it.
>
>
> > Perhaps 128 is too high of a value (for
> > reference I did 8 *nconnect_max).
> >
> >> Thus I would favor a (moderate) soldered-in maximum to start with,
> >> and then as real world use cases arise, consider adding a tuning
> >> mechanism based on actual requirements.
> >
> > Can you suggest a moderate number between 16 and 128?
>
> 16 is conservative, and there's nothing preventing us from changing
> that maximum over time as we learn more.
>
> An in-code comment explaining how the final maximum value was arrived
> at would be good to add. Even "This is just a guess" would be valuable
> to anyone in the future trying to figure out a new value, IMO.
>
> --
> Chuck Lever
>
>
>
