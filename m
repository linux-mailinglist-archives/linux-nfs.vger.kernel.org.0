Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C689421BD20
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2020 20:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgGJSkr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Jul 2020 14:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgGJSkq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Jul 2020 14:40:46 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A29C08C5DC
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jul 2020 11:40:46 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dr13so7157113ejc.3
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jul 2020 11:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C9lGRUIWX7YkhS5N/OYgx02NUenc9uQb2fj2fq7V9fI=;
        b=DVyxC22y+8xi1Oo0lPFkFEFewfhtZ2w1vXZglrO0sGz4wAOzJFgGp5+mheg4+6L1A/
         9s6pX9c5/CAeX2fRcWpshuV9K1qUi3AGQBMxap2E9TGmF+ngGNyOq9fC973UFGICMh5n
         K9+Z80/2Th6qSocHEpzZ9bTJdB640Gb0LnCZlg0wFbE143ldsEFjBoC8ceNrzomy5lzK
         5v9lLnOIZyDUKxzihu05/91svvpu/1mTmPjr0XdFVotffut9JUzcb9zOlcBVo2nVFJpZ
         RB2mf+R3y0WgEgbby0IpatYpJCkDEN+/n6eKIv8V4Sf2bQs58pWkUrjwCD5TEgyEffMp
         +m0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C9lGRUIWX7YkhS5N/OYgx02NUenc9uQb2fj2fq7V9fI=;
        b=BeKRRM+cHtniRJ3DzFq6z30Zj6RxprB0k7mwbwRCEz75BkFvSjAiKq4Appc74HUeSN
         DMChjzYcnAapXD4hXKZdRm8P5Ap7TBQBNSMUooXvj4IG9wQKvf8H4EVMs4H3zoMl81RZ
         8oqvFAC7taLs7Y1WYQHTsG9opcvd3BO8LXzmdzGW07BFgm4MIkowVG/WQmvhnNnwPrt/
         Ib+xifoGXckjKqtRA/CXK0EtM7ZAbJfammhOR/C8hkB6+2o0y/TDdnzTm7Pa8NOH+s9q
         JgucNI8S1nsAth6twTu92bi41NoGk8il5V5N0lon2xop0li6Qdy2LnYUboYMcY1VHynh
         Umnw==
X-Gm-Message-State: AOAM530Ng3Di8DIZTFNatkiJgFvX+DjD8Cxs/Zfv5lSzLx56E6Q5kfBo
        AzV89dYxWbhpmUuUCkD/+x450Xj+7KfqQmRyl0aDzQ==
X-Google-Smtp-Source: ABdhPJzOsGlLd+yVUBMVjJAsSXaNAFjd7v5zllmQ1TOADO0/kIxlckRX6encrRf1gt46vPxLJJjpg3EdpN8oNwH6+pQ=
X-Received: by 2002:a17:906:a1c7:: with SMTP id bx7mr56669319ejb.388.1594406444556;
 Fri, 10 Jul 2020 11:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200708210514.84671-1-olga.kornievskaia@gmail.com>
 <41873966ea839cca97332df3c56612441f840e0d.camel@hammerspace.com>
 <CAN-5tyGk3aU-DRhWACMD8-NMtdfX4ANUcR3xAjjEySf-GbbA6w@mail.gmail.com>
 <3fe49121d027eaa3aa2263f24d76d72e750d8592.camel@hammerspace.com>
 <CAN-5tyFD6XuZAZ3HAvfxyr7xLsvb-04hhe4PYvO_594ZQ0TuNw@mail.gmail.com> <CAN-5tyHrd4dZEkO3CRrvcLv82Gy0fXERCPYSq0Snj3zBHh3gxw@mail.gmail.com>
In-Reply-To: <CAN-5tyHrd4dZEkO3CRrvcLv82Gy0fXERCPYSq0Snj3zBHh3gxw@mail.gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Fri, 10 Jul 2020 14:40:33 -0400
Message-ID: <CAN-5tyEbQ7wiKDVXbwVrjkKS33CwJRhJXxe7RymPcRQfjQwRdA@mail.gmail.com>
Subject: Re: [PATCH 1/1] SUNRPC dont update timeout value on connection reset
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jul 10, 2020 at 1:35 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> On Thu, Jul 9, 2020 at 5:07 PM Olga Kornievskaia
> <olga.kornievskaia@gmail.com> wrote:
> >
> > On Thu, Jul 9, 2020 at 1:19 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
> > >
> > > On Thu, 2020-07-09 at 11:43 -0400, Olga Kornievskaia wrote:
> > > > On Thu, Jul 9, 2020 at 8:08 AM Trond Myklebust <
> > > > trondmy@hammerspace.com> wrote:
> > > > > Hi Olga
> > > > >
> > > > > On Wed, 2020-07-08 at 17:05 -0400, Olga Kornievskaia wrote:
> > > > > > Current behaviour: every time a v3 operation is re-sent to the
> > > > > > server
> > > > > > we update (double) the timeout. There is no distinction between
> > > > > > whether
> > > > > > or not the previous timer had expired before the re-sent
> > > > > > happened.
> > > > > >
> > > > > > Here's the scenario:
> > > > > > 1. Client sends a v3 operation
> > > > > > 2. Server RST-s the connection (prior to the timeout) (eg.,
> > > > > > connection
> > > > > > is immediately reset)
> > > > > > 3. Client re-sends a v3 operation but the timeout is now 120sec.
> > > > > >
> > > > > > As a result, an application sees 2mins pause before a retry in
> > > > > > case
> > > > > > server again does not reply.
> > > > > >
> > > > > > Instead, this patch proposes to keep track off when the minor
> > > > > > timeout
> > > > > > should happen and if it didn't, then don't update the new
> > > > > > timeout.
> > > > > >
> > > > > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > > > > ---
> > > > > >  include/linux/sunrpc/xprt.h |  1 +
> > > > > >  net/sunrpc/xprt.c           | 11 +++++++++++
> > > > > >  2 files changed, 12 insertions(+)
> > > > > >
> > > > > > diff --git a/include/linux/sunrpc/xprt.h
> > > > > > b/include/linux/sunrpc/xprt.h
> > > > > > index e64bd82..a603d48 100644
> > > > > > --- a/include/linux/sunrpc/xprt.h
> > > > > > +++ b/include/linux/sunrpc/xprt.h
> > > > > > @@ -101,6 +101,7 @@ struct rpc_rqst {
> > > > > >                                                        * used in
> > > > > > the
> > > > > > softirq.
> > > > > >                                                        */
> > > > > >       unsigned long           rq_majortimeo;  /* major timeout
> > > > > > alarm */
> > > > > > +     unsigned long           rq_minortimeo;  /* minor timeout
> > > > > > alarm */
> > > > > >       unsigned long           rq_timeout;     /* Current timeout
> > > > > > value */
> > > > > >       ktime_t                 rq_rtt;         /* round-trip time
> > > > > > */
> > > > > >       unsigned int            rq_retries;     /* # of retries */
> > > > > > diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
> > > > > > index d5cc5db..c0ce232 100644
> > > > > > --- a/net/sunrpc/xprt.c
> > > > > > +++ b/net/sunrpc/xprt.c
> > > > > > @@ -607,6 +607,11 @@ static void xprt_reset_majortimeo(struct
> > > > > > rpc_rqst *req)
> > > > > >       req->rq_majortimeo += xprt_calc_majortimeo(req);
> > > > > >  }
> > > > > >
> > > > > > +static void xprt_reset_minortimeo(struct rpc_rqst *req)
> > > > > > +{
> > > > > > +     req->rq_minortimeo = jiffies + req->rq_timeout;
> > > > > > +}
> > > > > > +
> > > > > >  static void xprt_init_majortimeo(struct rpc_task *task, struct
> > > > > > rpc_rqst *req)
> > > > > >  {
> > > > > >       unsigned long time_init;
> > > > > > @@ -618,6 +623,7 @@ static void xprt_init_majortimeo(struct
> > > > > > rpc_task
> > > > > > *task, struct rpc_rqst *req)
> > > > > >               time_init = xprt_abs_ktime_to_jiffies(task-
> > > > > > >tk_start);
> > > > > >       req->rq_timeout = task->tk_client->cl_timeout->to_initval;
> > > > > >       req->rq_majortimeo = time_init + xprt_calc_majortimeo(req);
> > > > > > +     req->rq_minortimeo = time_init + req->rq_timeout;
> > > > > >  }
> > > > > >
> > > > > >  /**
> > > > > > @@ -631,6 +637,10 @@ int xprt_adjust_timeout(struct rpc_rqst
> > > > > > *req)
> > > > > >       const struct rpc_timeout *to = req->rq_task->tk_client-
> > > > > > > cl_timeout;
> > > > > >       int status = 0;
> > > > > >
> > > > > > +     if (time_before(jiffies, req->rq_minortimeo)) {
> > > > > > +             xprt_reset_minortimeo(req);
> > > > > > +             return status;
> > > > >
> > > > > Shouldn't this case be just returning without updating the timeout?
> > > > > After all, this is the case where nothing has expired yet.
> > > >
> > > > I think we perhaps should readjust the minor timeout every here but I
> > > > can't figure out what the desired behaviour should be. When should we
> > > > consider it's appropriate to double the timer. Consider the
> > > > following:
> > > >
> > > > time1: v3 op sent
> > > > time1+50s: server RSTs
> > > > We check that it's not yet the minor timeout (time1+60s)
> > > > time1+50s: v3 op re-sent  (say we don't reset the minor timeout to be
> > > > current time+60s)
> > > > time1+60s: server RSTs
> > > > Client will resend the op but now it's past the initial minor timeout
> > > > so the timeout will be doubled. Is that what we really want? Maybe it
> > > > is.
> > > > Say now the server RSTs the connection again (shortly after or in
> > > > less
> > > > than 60s), since we are not updating the minor timeout value, then
> > > > the
> > > > client will again modify the timeout before resending. Is that Ok?
> > > >
> > > > That's why my reasoning was that at every re-evaluation of the
> > > > timeout
> > > > value, we have the minor timeout set for current time+60s and we get
> > > > an RST within it then we don't modify the timeout value.
> > >
> > > So a couple of issues with that:
> > >
> > > The first is that a series of RST calls could cause the timeout to get
> > > pushed to the max value fairly quickly (btw, xprt_reset_minortimeo()
> > > does not enforce a limit right now).
> > >
> > > The second is that we end up pushing out the major timeout value, since
> > > the major timeout cannot occur unless the value of jiffies is after the
> > > minor timeout (which keeps changing on each pass).
> >
> > But dont we want to push out the major timeout?
> >
> > Actually i think, back in my example of getting the RST, at
> > (time1+50s). shouldn't minor_timeo and majortimeo be reset to
> > currenttime+appropriate value of minor/major?  If we are evaluating
> > the timer and the time difference between when the operation was sent
> > and now is less than 60s, we shouldn't say a timeout has occurried
> > (it's a pre-mature timeout) and thus its value shouldn't be modified.
> >
> > Thoughts?
>
> Do you feel that the following approach is incorrect? Sry it's just
> cut-and-paste but the logic is there. Thank you.

Scratch this... So with this we'd never timeout an operation at all.

> diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
> index e64bd82..a603d48 100644
> --- a/include/linux/sunrpc/xprt.h
> +++ b/include/linux/sunrpc/xprt.h
> @@ -101,6 +101,7 @@ struct rpc_rqst {
>   * used in the softirq.
>   */
>   unsigned long rq_majortimeo; /* major timeout alarm */
> + unsigned long rq_minortimeo; /* minor timeout alarm */
>   unsigned long rq_timeout; /* Current timeout value */
>   ktime_t rq_rtt; /* round-trip time */
>   unsigned int rq_retries; /* # of retries */
> diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
> index d5cc5db..66d412b 100644
> --- a/net/sunrpc/xprt.c
> +++ b/net/sunrpc/xprt.c
> @@ -607,6 +607,11 @@ static void xprt_reset_majortimeo(struct rpc_rqst *req)
>   req->rq_majortimeo += xprt_calc_majortimeo(req);
>  }
>
> +static void xprt_reset_minortimeo(struct rpc_rqst *req)
> +{
> + req->rq_minortimeo = jiffies + req->rq_timeout;
> +}
> +
>  static void xprt_init_majortimeo(struct rpc_task *task, struct rpc_rqst *req)
>  {
>   unsigned long time_init;
> @@ -618,6 +623,7 @@ static void xprt_init_majortimeo(struct rpc_task
> *task, struct rpc_rqst *req)
>   time_init = xprt_abs_ktime_to_jiffies(task->tk_start);
>   req->rq_timeout = task->tk_client->cl_timeout->to_initval;
>   req->rq_majortimeo = time_init + xprt_calc_majortimeo(req);
> + req->rq_minortimeo = time_init + req->rq_timeout;
>  }
>
>  /**
> @@ -631,6 +637,11 @@ int xprt_adjust_timeout(struct rpc_rqst *req)
>   const struct rpc_timeout *to = req->rq_task->tk_client->cl_timeout;
>   int status = 0;
>
> + if (time_before(jiffies, req->rq_minortimeo)) {
> + req->rq_majortimeo = jiffies + xprt_calc_majortimeo(req);
> + req->rq_minortimeo = jiffies + req->rq_timeout;
> + return status;
> + }
>   if (time_before(jiffies, req->rq_majortimeo)) {
>   if (to->to_exponential)
>   req->rq_timeout <<= 1;
> @@ -649,6 +660,7 @@ int xprt_adjust_timeout(struct rpc_rqst *req)
>   spin_unlock(&xprt->transport_lock);
>   status = -ETIMEDOUT;
>   }
> + xprt_reset_minortimeo(req);
>
>   if (req->rq_timeout == 0) {
>   printk(KERN_WARNING "xprt_adjust_timeout: rq_timeout = 0!\n");
> --
>
> > > > > > +     }
> > > > > >       if (time_before(jiffies, req->rq_majortimeo)) {
> > > > > >               if (to->to_exponential)
> > > > > >                       req->rq_timeout <<= 1;
> > > > > > @@ -638,6 +648,7 @@ int xprt_adjust_timeout(struct rpc_rqst *req)
> > > > > >                       req->rq_timeout += to->to_increment;
> > > > > >               if (to->to_maxval && req->rq_timeout >= to-
> > > > > > >to_maxval)
> > > > > >                       req->rq_timeout = to->to_maxval;
> > > > > > +             xprt_reset_minortimeo(req);
> > > > >
> > > > > ...and then perhaps this can just be moved out of the time_before()
> > > > > condition, since it looks to me as if we also want to reset req-
> > > > > > rq_minortimeo when a major timeout occurs.
> > > > > >               req->rq_retries++;
> > > > > >       } else {
> > > > > >               req->rq_timeout = to->to_initval;
> > >
> > > --
> > > Trond Myklebust
> > > Linux NFS client maintainer, Hammerspace
> > > trond.myklebust@hammerspace.com
> > >
> > >
