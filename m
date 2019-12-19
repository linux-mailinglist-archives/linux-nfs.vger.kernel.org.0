Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C94412666B
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2019 17:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfLSQKx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Dec 2019 11:10:53 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37653 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfLSQKx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Dec 2019 11:10:53 -0500
Received: by mail-vs1-f67.google.com with SMTP id x18so4102550vsq.4
        for <linux-nfs@vger.kernel.org>; Thu, 19 Dec 2019 08:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h+w1O1Iv1YuzQGcXqLi8lD0BcqU9/RjSG4ZGqCxZTxY=;
        b=FKbsxG5+3qD059hYDxiBwyFoi0jLtcDrb25yPNK/tnj+9TquKhuHPNW6Hc0BsP07CW
         cifh8llfMEypiYO4nR8MSpnyuX2jOjxJYQTl4s1+5Oxt4qvf36bty9wEueJQdE+z8jRL
         rTMNc+ej9W1gYICCZxi86tNAJmf+u8ybuvgYwTVs3FdO2AhaKgdmq0qjgmU/11lPn/ZR
         xcSwtbhIpGJ9vTphh+qoyyPBLnU2XkLWGEnRtotbjq/bALkfvou/jWlIlUSyoeQL40qC
         Od/DdhFLOHaB83fzlrj00JgJpdUg4nT4bl6yqlffn467jtavRZQLpnsNkKym67xjBqBe
         NJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+w1O1Iv1YuzQGcXqLi8lD0BcqU9/RjSG4ZGqCxZTxY=;
        b=Ke28kJRrDYvwj4FdzdGTRaK+uFFRtRI4rICas6gpqmPOQ+ui1Fi7e+XonzdLVMw9eY
         NVpn/LDP/pmLIAbJwr5IFPO62j7aUw/LxgJuM+CIpjvFt3VUkHSb2M+VtSqZR5hSlo5r
         1o5i7NzLLpVdgDpaXi97QveQyHwNIC/+OVjJPxlmUogCZtQzWa2umPSfsp18OCst7o8s
         8kAe3Rgfc/fXm3dVlEEJm1zWAyKFoTSFYaqKXJsTsMaB2H4o9/cXTvJ8/o4i/yTHlia9
         PYcW/+4nKRu6Fq9EJtdtO0HS7GTrWTZETaNXjacsMVZ467dT19JL778Eivk5wpDp1Th/
         6Nvw==
X-Gm-Message-State: APjAAAXtguxWdoEOTxkmSr/kBLsHWfY8sE6tGRuvFX6AOXY9ynhePZIv
        OGcjYO57wQkrgxADaV/SKIA6xxxlgHkjcjiS9mk=
X-Google-Smtp-Source: APXvYqxAr5eIfZNzFErS4vhq9wCaXuMeP8vRJ23K8dkF+SjHqZioVGjooCu3/l8zWZwU1NASWGp/DIL1Gqx4ZKJeLrI=
X-Received: by 2002:a67:f81a:: with SMTP id l26mr5373760vso.194.1576771849503;
 Thu, 19 Dec 2019 08:10:49 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyHR8RKtsVNdg6vrSN50Sf9x9XWn-VX0pXBPetAY4Mj7nA@mail.gmail.com>
 <5E198AD1-41F7-4211-83CA-85680D8FB115@oracle.com> <CAN-5tyEPhcE6NBktsqRKySyAUi6EeC_saWFH8A7tKFZ+Sb0jMg@mail.gmail.com>
 <7D6BD48C-E6B3-43D4-8A31-99F0B387EF77@oracle.com> <CAN-5tyHmqs2ZWZHKBbockHX_kEcXbnqB=kAfVqtkv-BLhpZHTg@mail.gmail.com>
 <44C74BBB-3181-4F00-BFD8-784555C80F23@oracle.com>
In-Reply-To: <44C74BBB-3181-4F00-BFD8-784555C80F23@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 19 Dec 2019 11:10:38 -0500
Message-ID: <CAN-5tyEh9AxGusTg1VoQ195wds43bBEQhRnojLTSiQgecm3bpQ@mail.gmail.com>
Subject: Re: rdma compile error
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Dec 19, 2019 at 10:57 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Dec 4, 2019, at 2:09 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
> >
> > On Wed, Dec 4, 2019 at 1:25 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> >>
> >>
> >>
> >>> On Dec 4, 2019, at 1:12 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
> >>>
> >>> On Wed, Dec 4, 2019 at 1:02 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> >>>>
> >>>> Hi Olga-
> >>>>
> >>>>> On Dec 4, 2019, at 11:15 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
> >>>>>
> >>>>> Hi Chuck,
> >>>>>
> >>>>> I git cloned your origin/cel-testing, it's on the following commit.
> >>>>> commit 37e235c0128566e9d97741ad1e546b44f324f108
> >>>>> Author: Chuck Lever <chuck.lever@oracle.com>
> >>>>> Date:   Fri Nov 29 12:06:00 2019 -0500
> >>>>>
> >>>>>  xprtrdma: Invoke rpcrdma_ep_create() in the connect worker
> >>>>>
> >>>>> And I'm getting the following compile error.
> >>>>>
> >>>>> CC [M]  drivers/infiniband/core/cma_trace.o
> >>>>> In file included from drivers/infiniband/core/cma_trace.h:302:0,
> >>>>>               from drivers/infiniband/core/cma_trace.c:16:
> >>>>> ./include/trace/define_trace.h:95:43: fatal error: ./cma_trace.h: No
> >>>>> such file or directory
> >>>>> #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> >>>>>                                         ^
> >>>>> Is this known?
> >>>>
> >>>> I haven't had any complaints from lkp.
> >>>>
> >>>> f73179592745 ("RDMA/cma: Add trace points in RDMA Connection Manager")
> >>>>
> >>>> should have added drivers/infiniband/core/cma_trace.h .
> >>>>
> >>>
> >>> The file "cma_trace.h" is there in the "core" directory. But for some
> >>> reason my compile expects it to be in include/trace directory (if I
> >>> were to copy it there I can compile).
> >>
> >> The end of cma_trace.h should have:
> >>
> >> #undef TRACE_INCLUDE_PATH
> >> #define TRACE_INCLUDE_PATH .
> >> #define TRACE_INCLUDE_FILE cma_trace
> >
> > It does have it.
> >
> >> That is supposed to steer the compiler to the cma_trace.h in core/ .
> >>
> >> Does a "make mrproper; git clean -d -f -x" help? Feels like there's
> >> a stale generated file somewhere that's breaking things.
> >
> > I probably do have something uncleaned. I have tried what you
> > suggested but it's not helping. This build is a tar of a git clone
> > tree then copied into an internal lab (with rdma hardware).
>
> I found a very similar compile issue yesterday. The fix is in the
> current cel-testing topic branch, if you are interested.

Thanks. I'll give it a try!

>
>
> --
> Chuck Lever
>
>
>
