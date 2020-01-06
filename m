Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAB951319FA
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 22:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgAFVBV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 16:01:21 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:40213 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgAFVBV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 16:01:21 -0500
Received: by mail-vk1-f196.google.com with SMTP id c129so12862393vkh.7
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 13:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8IJgpKJtex6z3yYjcZrDeUU+v2X4MG4hg2R/28Xmm8M=;
        b=OTFYd8pjEdt7Dn/JucDkUyGiELsqSDMdR2BCCfh80JeZEY65zGH6qLO/bf6a9Dmt0H
         RETR51Tia3YG8KIa55c9SoBVm2bLVA8pHFgX7sGacGIHKuxlc8/ivRyKunfRq981sosq
         SVq+GkPHr0Ul+1qX9MkCgvttyPQ/NuI0TJvqodRzCD4d9Xd1t0HfYr9wxPNpOGn7QH2s
         jcG4NAiFWpu1b08G/rfsVKNT4jpwP4YmFIaC2iYaHcMhGOK1fhRkWxR9z9eExQZHLEh2
         XUvdWZ/Imp7Tc04cSPeFiFpmw0Fmo/zZiLXu2Exf7+U8DHm7dVgavu+fFDfBXYErSpRV
         oyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8IJgpKJtex6z3yYjcZrDeUU+v2X4MG4hg2R/28Xmm8M=;
        b=QSAgoRg2MXV/CynaoZ7/ZizbFoXvWbbtCM3BumfLEQj7e1lZDytXTpBFvY9ULw5CJC
         eOBT9PpE1lYIibjEDAYXRbnr34o8V3kfyeiuwjdiXNu15YI3EE/2XXtl+QBdUHBdq4qr
         ycN//nNJeBlwfmMP8jbN0kM5Qph2txVaUojp5sl293KTT+5SCtwBFsXLde1PwhRaL59e
         Bi85bP/JpUqEquq20LC5S3YXS2DIzOQfD3n3eur4gIQplQHyB2pRnVkqZ0NL4OjbmV8b
         s9z+WJzOEdYMrHuTFfUuFgaj6ZI7opHRgo8Yj4XEAykUtZKBgnJXJye7Hoa3vnNSlF57
         Cpwg==
X-Gm-Message-State: APjAAAWLbW9Qr+bj2aLdkNVe2V0hoBcFP/2bIMTOGNUrsPpGc5998TXX
        tfMEBs9ZQeIVqQ6lV6dOgY5NW+hdAtXalVkdrko=
X-Google-Smtp-Source: APXvYqyQxLL8hNUEQQ1dwhXHgNFlGSt+RxaO9rKm72QSOwcvgnwxZYU0isNasjzd20GHuHQsKopeH/NECBH5jg00PmM=
X-Received: by 2002:a1f:f283:: with SMTP id q125mr58862440vkh.69.1578344480500;
 Mon, 06 Jan 2020 13:01:20 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyHR8RKtsVNdg6vrSN50Sf9x9XWn-VX0pXBPetAY4Mj7nA@mail.gmail.com>
 <5E198AD1-41F7-4211-83CA-85680D8FB115@oracle.com> <CAN-5tyEPhcE6NBktsqRKySyAUi6EeC_saWFH8A7tKFZ+Sb0jMg@mail.gmail.com>
 <7D6BD48C-E6B3-43D4-8A31-99F0B387EF77@oracle.com> <CAN-5tyHmqs2ZWZHKBbockHX_kEcXbnqB=kAfVqtkv-BLhpZHTg@mail.gmail.com>
 <44C74BBB-3181-4F00-BFD8-784555C80F23@oracle.com> <CAN-5tyEh9AxGusTg1VoQ195wds43bBEQhRnojLTSiQgecm3bpQ@mail.gmail.com>
In-Reply-To: <CAN-5tyEh9AxGusTg1VoQ195wds43bBEQhRnojLTSiQgecm3bpQ@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 6 Jan 2020 16:01:09 -0500
Message-ID: <CAN-5tyFTEhg2y3Qk5jJW6k=YKnSd2A==vL9FcPgZRV2E6R0arA@mail.gmail.com>
Subject: Re: rdma compile error
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Dec 19, 2019 at 11:10 AM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> On Thu, Dec 19, 2019 at 10:57 AM Chuck Lever <chuck.lever@oracle.com> wrote:
> >
> >
> >
> > > On Dec 4, 2019, at 2:09 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
> > >
> > > On Wed, Dec 4, 2019 at 1:25 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> > >>
> > >>
> > >>
> > >>> On Dec 4, 2019, at 1:12 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
> > >>>
> > >>> On Wed, Dec 4, 2019 at 1:02 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> > >>>>
> > >>>> Hi Olga-
> > >>>>
> > >>>>> On Dec 4, 2019, at 11:15 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
> > >>>>>
> > >>>>> Hi Chuck,
> > >>>>>
> > >>>>> I git cloned your origin/cel-testing, it's on the following commit.
> > >>>>> commit 37e235c0128566e9d97741ad1e546b44f324f108
> > >>>>> Author: Chuck Lever <chuck.lever@oracle.com>
> > >>>>> Date:   Fri Nov 29 12:06:00 2019 -0500
> > >>>>>
> > >>>>>  xprtrdma: Invoke rpcrdma_ep_create() in the connect worker
> > >>>>>
> > >>>>> And I'm getting the following compile error.
> > >>>>>
> > >>>>> CC [M]  drivers/infiniband/core/cma_trace.o
> > >>>>> In file included from drivers/infiniband/core/cma_trace.h:302:0,
> > >>>>>               from drivers/infiniband/core/cma_trace.c:16:
> > >>>>> ./include/trace/define_trace.h:95:43: fatal error: ./cma_trace.h: No
> > >>>>> such file or directory
> > >>>>> #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> > >>>>>                                         ^
> > >>>>> Is this known?
> > >>>>
> > >>>> I haven't had any complaints from lkp.
> > >>>>
> > >>>> f73179592745 ("RDMA/cma: Add trace points in RDMA Connection Manager")
> > >>>>
> > >>>> should have added drivers/infiniband/core/cma_trace.h .
> > >>>>
> > >>>
> > >>> The file "cma_trace.h" is there in the "core" directory. But for some
> > >>> reason my compile expects it to be in include/trace directory (if I
> > >>> were to copy it there I can compile).
> > >>
> > >> The end of cma_trace.h should have:
> > >>
> > >> #undef TRACE_INCLUDE_PATH
> > >> #define TRACE_INCLUDE_PATH .
> > >> #define TRACE_INCLUDE_FILE cma_trace
> > >
> > > It does have it.
> > >
> > >> That is supposed to steer the compiler to the cma_trace.h in core/ .
> > >>
> > >> Does a "make mrproper; git clean -d -f -x" help? Feels like there's
> > >> a stale generated file somewhere that's breaking things.
> > >
> > > I probably do have something uncleaned. I have tried what you
> > > suggested but it's not helping. This build is a tar of a git clone
> > > tree then copied into an internal lab (with rdma hardware).
> >
> > I found a very similar compile issue yesterday. The fix is in the
> > current cel-testing topic branch, if you are interested.
>
> Thanks. I'll give it a try!

Hi Chuck,

It took me a while to try it but I did and happy to report I no longer
see the compile issue. Thank you for fixing it.

>
> >
> >
> > --
> > Chuck Lever
> >
> >
> >
