Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBF58113577
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Dec 2019 20:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfLDTJy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Dec 2019 14:09:54 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:38857 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbfLDTJy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Dec 2019 14:09:54 -0500
Received: by mail-vk1-f196.google.com with SMTP id m128so299813vkb.5
        for <linux-nfs@vger.kernel.org>; Wed, 04 Dec 2019 11:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkOJcPHjGzItPhmaOdrfOBp4UY1Nn9cG74yreNltDAQ=;
        b=Albq0okO3AqnXxfbrd9FdiG18poW8hqRdGpeT7VaeF5LmJ/Hu4PNhkKrQ+samrP1iS
         TQ+1KpQveiDgiUWDyeAUWJd7ruHywHKyoY8JMCh8YObMqY+8gNl2R5F7iahtiBQGOKH4
         UDvmxX9I94BudGaad+SUVgoR+L4Hptg+TNq9XrgAIqhL4dydQTNzH5J7ugeMvP4/uLIr
         JOoa/BAHfYw+FjiTaPugdnrPcV+MMG8pr/GcJYWMF7Bif21uFJL7yO9YSSoeO8SUWyP/
         y5e/RLTfXLZSVhEseRn0AVfc1ZQsInGoRI6cCkuhoBdUhb6HFf7OaAIeYwEzeW2v4J8m
         WzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkOJcPHjGzItPhmaOdrfOBp4UY1Nn9cG74yreNltDAQ=;
        b=HvVmj1Jc66CMuadsChuuognTmtG3ohwxsh05Y6VyTmCMgZkMhmXHODHDQtuJC0Lojz
         gFWrDcmIh0e3tqF2Jxa+EPbxTcaV5/SUdOAvPSdxrJ7Mf5XNJDv0PtN0O0qHQgEoT6KQ
         HJiLyjnj1fhhxIPy4Z0vpbHpGq0Si5HU+etsV11nYWiEz/8bookwSM1XVbYov9qm+Vli
         WMVDwTKqDeWYwEqCM1Zi45Xodi2zE4EVQLrtO2n4eUggu+m9E2M4RS1bp0e0hBvuyjSG
         nl60U3QmRtWxBJzPBc30QL4jguap8f8LaRbhO1RifXYl5RIkZ9T1DIOcmhugv5Vy5/72
         tHLA==
X-Gm-Message-State: APjAAAWO0bdWpxE2DfOdlqH7Gm6fc4qBHkYbjeAFNMvLOBHfYW6c/l+p
        sf25UEtFRFqTaPPNe3RlEvN5YyD3aujpUfLwX4GOeQ==
X-Google-Smtp-Source: APXvYqxBDPaO1DYxF57JMghLjZKlIPwjw6C8PXep8Wn6uAY8LFuuJAXS8EdTPU5j70T0coEdetBUKp044zi96Uomikw=
X-Received: by 2002:a1f:f283:: with SMTP id q125mr3338777vkh.69.1575486593389;
 Wed, 04 Dec 2019 11:09:53 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyHR8RKtsVNdg6vrSN50Sf9x9XWn-VX0pXBPetAY4Mj7nA@mail.gmail.com>
 <5E198AD1-41F7-4211-83CA-85680D8FB115@oracle.com> <CAN-5tyEPhcE6NBktsqRKySyAUi6EeC_saWFH8A7tKFZ+Sb0jMg@mail.gmail.com>
 <7D6BD48C-E6B3-43D4-8A31-99F0B387EF77@oracle.com>
In-Reply-To: <7D6BD48C-E6B3-43D4-8A31-99F0B387EF77@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 4 Dec 2019 14:09:41 -0500
Message-ID: <CAN-5tyHmqs2ZWZHKBbockHX_kEcXbnqB=kAfVqtkv-BLhpZHTg@mail.gmail.com>
Subject: Re: rdma compile error
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Dec 4, 2019 at 1:25 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Dec 4, 2019, at 1:12 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
> >
> > On Wed, Dec 4, 2019 at 1:02 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> >>
> >> Hi Olga-
> >>
> >>> On Dec 4, 2019, at 11:15 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
> >>>
> >>> Hi Chuck,
> >>>
> >>> I git cloned your origin/cel-testing, it's on the following commit.
> >>> commit 37e235c0128566e9d97741ad1e546b44f324f108
> >>> Author: Chuck Lever <chuck.lever@oracle.com>
> >>> Date:   Fri Nov 29 12:06:00 2019 -0500
> >>>
> >>>   xprtrdma: Invoke rpcrdma_ep_create() in the connect worker
> >>>
> >>> And I'm getting the following compile error.
> >>>
> >>> CC [M]  drivers/infiniband/core/cma_trace.o
> >>> In file included from drivers/infiniband/core/cma_trace.h:302:0,
> >>>                from drivers/infiniband/core/cma_trace.c:16:
> >>> ./include/trace/define_trace.h:95:43: fatal error: ./cma_trace.h: No
> >>> such file or directory
> >>> #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> >>>                                          ^
> >>> Is this known?
> >>
> >> I haven't had any complaints from lkp.
> >>
> >> f73179592745 ("RDMA/cma: Add trace points in RDMA Connection Manager")
> >>
> >> should have added drivers/infiniband/core/cma_trace.h .
> >>
> >
> > The file "cma_trace.h" is there in the "core" directory. But for some
> > reason my compile expects it to be in include/trace directory (if I
> > were to copy it there I can compile).
>
> The end of cma_trace.h should have:
>
> #undef TRACE_INCLUDE_PATH
> #define TRACE_INCLUDE_PATH .
> #define TRACE_INCLUDE_FILE cma_trace

It does have it.

> That is supposed to steer the compiler to the cma_trace.h in core/ .
>
> Does a "make mrproper; git clean -d -f -x" help? Feels like there's
> a stale generated file somewhere that's breaking things.

I probably do have something uncleaned. I have tried what you
suggested but it's not helping. This build is a tar of a git clone
tree then copied into an internal lab (with rdma hardware).

>
>
> --
> Chuck Lever
>
>
>
