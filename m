Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02EA6113353
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Dec 2019 19:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbfLDSM4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Dec 2019 13:12:56 -0500
Received: from mail-vk1-f174.google.com ([209.85.221.174]:39676 "EHLO
        mail-vk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730887AbfLDSMz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Dec 2019 13:12:55 -0500
Received: by mail-vk1-f174.google.com with SMTP id x199so244329vke.6
        for <linux-nfs@vger.kernel.org>; Wed, 04 Dec 2019 10:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C7Ig6JLOoHC5iSJpRzLVHI9ugBnHqMgWqttrIbLXI8g=;
        b=YDLkWG30o6fco2FuCPHeSZ1f3XWIsspnkf2Zfk8OmGGqFQGIYY159bUIBZaOwk4eua
         jh36eGnJsy6tAFB5gU/ON6IzFqlMLhfn9aWlXj8ywJuq4y2erzBnHQKg1QMd298H5tQp
         Tl1hik+20gUIERZ9wQAmrPu2uEzF5edt6ePQel+bvTbQsKzyIvjigH71sFDGErOnmdm1
         cXLg7/ZOLwOZTtbLCjEHD8mc8vl/Hy4351O3xmBh3PPMtjVUKkMnaVN65jJDfSyie+pZ
         Ji6aT5HHjc/GKWW7ed3gKxCFIQT/xIUkZFRjyfeDl9U9ss1hznqVaZdUgXcFhoDnVaXv
         dhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C7Ig6JLOoHC5iSJpRzLVHI9ugBnHqMgWqttrIbLXI8g=;
        b=sLb7L7+AyyOqgYBq6bodgC65Wxc4qo1EOL+TWHzdqDOiq7rDUCzLQh6bhIq+dqYD5O
         2DWyMeRa1FQmYYrpYfLknqbye+ASa+HjVSxHXCczQbhETM73gGgXYlGLcGd8+nlHgtvz
         /QZupxjnqWCeWnIgrEbuxO/luM2NPFZHFcslWlQ6PsldfACSAb/RjhS/nUWUS1+dKeMf
         ucjTylQ40UzitrNxB89MVoPWRhe49H4VScgbrol3zGYIBBwHgQnYFW85u1/sXTNUeO8J
         pTGGugMcne8YEj0s5Eda8V7cbR89luDDDHqmuKHG+SQIXjbfdMSqxNcX1FyMocezvgxW
         j6qA==
X-Gm-Message-State: APjAAAXGvWn7TN/yK1t1OpNxUMpZPQluFv92Mi4t7ByUIb76DaQW5pG7
        8l+kM6Df98eGbJP6rwJNaJAOEFmyxXGcIbC8Nes=
X-Google-Smtp-Source: APXvYqxwgxKGrjrAXryK+Yu8d5l7BrfFcduaXyy6KFf+ldSZ+TVM5xiGVR7IUcoEmqDYkhMHq+/GOZCvSYRulas+Cf8=
X-Received: by 2002:a1f:a245:: with SMTP id l66mr3232356vke.58.1575483174603;
 Wed, 04 Dec 2019 10:12:54 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyHR8RKtsVNdg6vrSN50Sf9x9XWn-VX0pXBPetAY4Mj7nA@mail.gmail.com>
 <5E198AD1-41F7-4211-83CA-85680D8FB115@oracle.com>
In-Reply-To: <5E198AD1-41F7-4211-83CA-85680D8FB115@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 4 Dec 2019 13:12:43 -0500
Message-ID: <CAN-5tyEPhcE6NBktsqRKySyAUi6EeC_saWFH8A7tKFZ+Sb0jMg@mail.gmail.com>
Subject: Re: rdma compile error
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Dec 4, 2019 at 1:02 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> Hi Olga-
>
> > On Dec 4, 2019, at 11:15 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
> >
> > Hi Chuck,
> >
> > I git cloned your origin/cel-testing, it's on the following commit.
> > commit 37e235c0128566e9d97741ad1e546b44f324f108
> > Author: Chuck Lever <chuck.lever@oracle.com>
> > Date:   Fri Nov 29 12:06:00 2019 -0500
> >
> >    xprtrdma: Invoke rpcrdma_ep_create() in the connect worker
> >
> > And I'm getting the following compile error.
> >
> >  CC [M]  drivers/infiniband/core/cma_trace.o
> > In file included from drivers/infiniband/core/cma_trace.h:302:0,
> >                 from drivers/infiniband/core/cma_trace.c:16:
> > ./include/trace/define_trace.h:95:43: fatal error: ./cma_trace.h: No
> > such file or directory
> > #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> >                                           ^
> > Is this known?
>
> I haven't had any complaints from lkp.
>
> f73179592745 ("RDMA/cma: Add trace points in RDMA Connection Manager")
>
> should have added drivers/infiniband/core/cma_trace.h .
>

The file "cma_trace.h" is there in the "core" directory. But for some
reason my compile expects it to be in include/trace directory (if I
were to copy it there I can compile).


>
> --
> Chuck Lever
>
>
>
