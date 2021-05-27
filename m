Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83A7393447
	for <lists+linux-nfs@lfdr.de>; Thu, 27 May 2021 18:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbhE0Qsu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 May 2021 12:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbhE0Qst (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 May 2021 12:48:49 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680AFC061574
        for <linux-nfs@vger.kernel.org>; Thu, 27 May 2021 09:47:15 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b17so1680873ede.0
        for <linux-nfs@vger.kernel.org>; Thu, 27 May 2021 09:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rkkakjY8yMewgt4Z7DDrKG8AVtcy8vdhzphUMfjqmfM=;
        b=MdwPBbsQaj6ZAcAC1k1b32YNLrKljMgYBK2eTyLD6ywifFG0S6fA+zERoCB0IrCPgK
         571L/Oyi1c/94olTeZyZIfbOoR/e64/v1c9pIbiGmw8itLok+O1UM6Yq+OeHJckQePIl
         FSso1LaRJGs3OUEOhBiPoiqnaU7qHtY1WhR3geOqc/7jmyF/fKVP29BBVQUvIdDKVTQi
         JpzW+W8v7F46nYxI+DOdDzenRxZd0HIlkYs/uk/p13imcFWUz2EsjbEs/9OMhniGG73h
         nPM7KcMDc6PSX6Cabn1rsdymxWdvn5TvxDLHJXGBdGd0eAPlbv3NA6GGvTK7eZ5TcElA
         lnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rkkakjY8yMewgt4Z7DDrKG8AVtcy8vdhzphUMfjqmfM=;
        b=bblEqCS6dvQxqlp89jTxgUGWHugClm27ptxD6ano96QZPKbxbtT3yCre3IaGunOz2h
         vI8htH9W9NdfmKgie/FsPDBfWt7tAdQ2B9HYL9xWD6D/NKl2ZBAY/pY0cCa4FFnd98oc
         ayyVzW49rznotaJEeF4yBOAA6YXFD7DPd4EOSHAYWQPslYEyXT77AnnDgRQjFlBOhEcX
         to7Qy/B6m5BfpbqEhekL0uTbpr+9FSPuxynzS3k0e+ehf+YrWSX+fyVxPpr6HyhdjeGH
         YVVN4wg5lEqx7nKDrJCk+4lcnNDDowcU1+8OlvNOWQ3E2q0lVdNye4uphoTNtTrPbcEm
         Urew==
X-Gm-Message-State: AOAM533YRLp+FfxfNUwcBjmKGST+aIxvqOz7z/yv9pphu1+BLg9SLGJQ
        j1p8ZuLwwDOIqovN05NU5oEuNcMX3kes+nzLTcQ=
X-Google-Smtp-Source: ABdhPJwzF4jQH2ZpePKM34tYpqjrQJ6EGWflKm0n8O5ppA3EPqv1tB8tvn0+JmvtKOlXgYac6ZWuGAAiuRpb7F96JEU=
X-Received: by 2002:aa7:cd19:: with SMTP id b25mr2696264edw.84.1622134033868;
 Thu, 27 May 2021 09:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210525180033.200404-1-smayhew@redhat.com> <20210525180033.200404-3-smayhew@redhat.com>
 <490b45eb-0142-24de-e05f-79751891ddf9@RedHat.com> <YK+FH7T/ljFbuIsH@aion.usersys.redhat.com>
 <dbb64855-5ca5-0928-eda4-705a9f45c71b@RedHat.com>
In-Reply-To: <dbb64855-5ca5-0928-eda4-705a9f45c71b@RedHat.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 27 May 2021 12:47:02 -0400
Message-ID: <CAN-5tyFG2douMOvKcERHa24hWp7VvgYB9XAN1c84JLsL+81pCA@mail.gmail.com>
Subject: Re: [nfs-utils RFC PATCH 2/2] gssd: add timeout for upcall threads
To:     Steve Dickson <SteveD@redhat.com>
Cc:     Scott Mayhew <smayhew@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, May 27, 2021 at 8:52 AM Steve Dickson <SteveD@redhat.com> wrote:
>
>
>
> On 5/27/21 7:40 AM, Scott Mayhew wrote:
> > On Wed, 26 May 2021, Steve Dickson wrote:
> >> If people are going to used the -C flag they are saying they want
> >> to ignore hung threads so I'm thinking with printerr(0) we would
> >> be filling up their logs about messages they don't care about.
> >> So I'm thinking we should change this to a printerr(1)
> >
> > Note that message could pop multiple times per thread even without the
> > -C flag because cancellation isn't immediate (a thread needs to hit a
> > cancellation point, which it won't actually do that until it comes back
> > from wherever it's hanging).  My thinking was leaving it with
> > printerr(0) would make it blatantly obvious when something was wrong and
> > needed to be investigated.  I have no issue with changing it to
> > printerr(1) though.
> It would... but I've craft the debugging for a single -v
> is errors only... Maybe I should mention that in the
> man page... And looking at what you mention in the
> man page for -C, it does say it will cause an error
> to be logged... So I guess it makes sense to leave
> it as is.
>
> >
> > Alternatively we could add another flag to struct upcall_thread_info to
> > ensure that message only gets logged once per thread.
> >
> I think it is good as is...
>
> >>
> >> Overall I think the code is very well written with
> >> one exception... The lack of comments. I think it
> >> would be very useful to let the reader know what
> >> you are doing and why.... But by no means is
> >> that a show stopper. Nice work!
> >
> > I can go back and add some comments.
> Well there aren't that many comments to
> begin with.... So you are just following
> the format... ;-)
>
> Don't worry about it... How I will finish my testing
> today... and do the commit with what we got..

Hi Steve,

Can you please provide a bit more time for review to happen?

> Again... Nice work!!

Yes, nice work. But, I object to the current code that sets canceling
threads as default. This way the code hides the problems that occur
instead of forcing people to fix them.


>
> steved.
>
