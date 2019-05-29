Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9512E498
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2019 20:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfE2Sik (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 May 2019 14:38:40 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:41485 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfE2Sik (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 May 2019 14:38:40 -0400
Received: by mail-ua1-f66.google.com with SMTP id n2so1414633uad.8
        for <linux-nfs@vger.kernel.org>; Wed, 29 May 2019 11:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FNcpLdR1gB2FKoJvwQEraWVU2LiqRZ3fWLfIQutIUng=;
        b=LpRQwP+4bD8Okvj/R3TGpPhei7ShznJD0gMGE2qMGs1g9Xzaejcf2coKhYY4CokKxc
         bNwcD4yQsFoMtgqPWRvsSdcl8M1nQQU0FJ0PWRb7/g96VvgEEIH/86uLvdC+t/C7Z2vp
         ypdnNJ6YpOZHx/5PaWf6s4IljyDEhEygU3XSgrGl5CevNE0MyBg+MGQLqnZ0/uBG2XVD
         Yta07to/B6Xpw9OM4+3o4NGclo1hgCIVtNiL8GMTB95cV4HqJjnYXsptlQ7CpDo8prh+
         CCmBc78EpBOhK8H4CHZ96wEUvCrul/9tolf1eEoKD8Iw27NCREyoGtRmbgfB4ItswBor
         JxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNcpLdR1gB2FKoJvwQEraWVU2LiqRZ3fWLfIQutIUng=;
        b=e0PmtRru1wbig6gOmM5P+xYxdkiPPYdzzbIsZR25fBSYE2rM6h+lCgj3FDX4fi61KA
         wGSajOXUZbUFoBOLxPnoXzfk0FrzVtfMZFz9O5+D35INiyEunZ6ZLMePVDTQFumZivbJ
         FYC38m1OSaG3ig/+02YO4Pj9/Pb3n2jKWf9enymPmnBV1AjkstYBxuczLIlcJ1T4nnNz
         Pg7zRmRfsMPLazmAg2kAa0k63GhqO6FvMx19SVwjhXEkzuqV+/aRjkrWUs0m9//5Pr+K
         W7L4fmU1MpCnjfPh68Y4IJfA82/WXBSN1U06L8ztO12M+qZzxP9WMC2WoV6zWNwRdXlm
         YDhA==
X-Gm-Message-State: APjAAAUekIg5UCpvq679u2blsC8dH1mTtaC8psGVtLw/VYmCukJf6CVo
        rbP3vWUVoaSGGHMLaQETwMgoctEG/dgnPavDg88=
X-Google-Smtp-Source: APXvYqw7genUfo7Rs/2N1xBWppRxzE+meRwJrjTiIShOougnvp/UiBnm+o0Vc6ZjZBqwjK5+ecaVsSFBS/eZuC8LLb4=
X-Received: by 2002:a9f:3381:: with SMTP id p1mr9185477uab.40.1559155119023;
 Wed, 29 May 2019 11:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190503111841.4391-1-trond.myklebust@hammerspace.com>
 <20190503111841.4391-2-trond.myklebust@hammerspace.com> <20190503111841.4391-3-trond.myklebust@hammerspace.com>
 <20190503111841.4391-4-trond.myklebust@hammerspace.com> <20190503111841.4391-5-trond.myklebust@hammerspace.com>
 <20190503111841.4391-6-trond.myklebust@hammerspace.com> <CAN-5tyGDV1O=kfay2iu0g6cFkDRfFQrBTn-wfQowyGrAMY5fBw@mail.gmail.com>
In-Reply-To: <CAN-5tyGDV1O=kfay2iu0g6cFkDRfFQrBTn-wfQowyGrAMY5fBw@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 29 May 2019 14:38:28 -0400
Message-ID: <CAN-5tyFPxiJ8G581ENZ+T+6y3WLx_5aVcrWDaFZRERTzHu_iZw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] SUNRPC: Reduce the priority of the xprtiod queue
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, May 28, 2019 at 4:10 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> On Fri, May 3, 2019 at 7:24 AM Trond Myklebust <trondmy@gmail.com> wrote:
> >
> > Allow more time for softirqd
> >
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > ---
> >  net/sunrpc/sched.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
> > index c7e81336620c..6b37c9a4b48f 100644
> > --- a/net/sunrpc/sched.c
> > +++ b/net/sunrpc/sched.c
> > @@ -1253,7 +1253,7 @@ static int rpciod_start(void)
> >                 goto out_failed;
> >         rpciod_workqueue = wq;
> >         /* Note: highpri because network receive is latency sensitive */
> > -       wq = alloc_workqueue("xprtiod", WQ_UNBOUND|WQ_MEM_RECLAIM|WQ_HIGHPRI, 0);
>
> I thought we needed UNBOUND otherwise there was performance
> degradation for read IO.

I remove my objection as this is for the xprtiod queue and not the
rpciod queue. The latter is the one when removing WQ_UNBOUND would
only use a single rpciod thread for doing all the crypto and thus
impact performance.

>
> > +       wq = alloc_workqueue("xprtiod", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
> >         if (!wq)
> >                 goto free_rpciod;
> >         xprtiod_workqueue = wq;
> > --
> > 2.21.0
> >
