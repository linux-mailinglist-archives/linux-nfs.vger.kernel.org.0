Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C1C35083E
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Mar 2021 22:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbhCaUcG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 16:32:06 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:42629 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236546AbhCaUbt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Mar 2021 16:31:49 -0400
Received: by mail-lf1-f53.google.com with SMTP id o10so30966687lfb.9;
        Wed, 31 Mar 2021 13:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Svnh9cwyfYWHfl96l2PV0ag8wxa4S3QeHTKk24lJEiU=;
        b=t8fH0uEjqE1flgmvqCdtrUwPHqxDpPt9NW09/824IHmSu8UeeWqUgMiv+H6cuqgkRx
         aus0EDvkgq4p2QCWqzY44b335eKBTaE7tNlcbeXd0IG6Mbb1CQj1xSVpdutI1NsDMVWH
         cIrU6U2C/n5f0sadf76p1+EmPhsiXwHNvcP7YyrTXfjMGBxr6kaiLwmczN69/XNaBunJ
         +uZ8ytv0YXmekhdbp13FC8bN6UUfrxYnX0/SPlTtD1ocmELTday+IqbM8sTZNj6k3ipY
         Z1fcHU1GgCMwO17qTggI48AMeCDaJ2allH4gL2yJM+P0K9rFuopguM+C5qTB+VIRNv80
         JxyQ==
X-Gm-Message-State: AOAM532TdCoM7ufrKqDwzZGDJV7oU3IkJSw1jwch0q5w8Lh142s8MLGh
        ysWEvylivrBIIlBDJ/PBPewQLsj00KIng+MjW2Zh1f6EmLtkaA==
X-Google-Smtp-Source: ABdhPJxC2BoPBwu0kvAEJKl6eAP8/T7EQ0WdmNF/9C5sKDgpL0hMpGHQL0Y9/UUI+9SGlL/1X/RB8/6d39h9Kx448aQ=
X-Received: by 2002:ac2:482c:: with SMTP id 12mr3134310lft.4.1617222707865;
 Wed, 31 Mar 2021 13:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <161721926778.515226.9805598788670386587.stgit@manet.1015granger.net>
 <161721937122.515226.14731175629421422152.stgit@manet.1015granger.net> <4004f56f-3603-f56c-aea9-651230b3181e@talpey.com>
In-Reply-To: <4004f56f-3603-f56c-aea9-651230b3181e@talpey.com>
Reply-To: chucklever@gmail.com
From:   Chuck Lever <chuck.lever@oracle.com>
Date:   Wed, 31 Mar 2021 16:31:36 -0400
Message-ID: <CAFMMQGvortADqgmAzskZKcnyHDzsTEW0FtR501wpP+deUM57FA@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] xprtrdma: Do not post Receives after disconnect
To:     Tom Talpey <tom@talpey.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Mar 31, 2021 at 4:01 PM Tom Talpey <tom@talpey.com> wrote:
>
> On 3/31/2021 3:36 PM, Chuck Lever wrote:
> > Currently the Receive completion handler refreshes the Receive Queue
> > whenever a successful Receive completion occurs.
> >
> > On disconnect, xprtrdma drains the Receive Queue. The first few
> > Receive completions after a disconnect are typically successful,
> > until the first flushed Receive.
> >
> > This means the Receive completion handler continues to post more
> > Receive WRs after the drain sentinel has been posted. The late-
> > posted Receives flush after the drain sentinel has completed,
> > leading to a crash later in rpcrdma_xprt_disconnect().
> >
> > To prevent this crash, xprtrdma has to ensure that the Receive
> > handler stops posting Receives before ib_drain_rq() posts its
> > drain sentinel.
> >
> > This patch is probably not sufficient to fully close that window,
>
> "Probably" is not a word I'd like to use in a stable:cc...

Well, I could be easily convinced to remove the Cc: stable
for this one, since it's not a full fix. But this is a pretty pervasive
problem with disconnect handling.


> > but does significantly reduce the opportunity for a crash to
> > occur without incurring undue performance overhead.
> >
> > Cc: stable@vger.kernel.org # v5.7
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >   net/sunrpc/xprtrdma/verbs.c |    7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> > index ec912cf9c618..1d88685badbe 100644
> > --- a/net/sunrpc/xprtrdma/verbs.c
> > +++ b/net/sunrpc/xprtrdma/verbs.c
> > @@ -1371,8 +1371,10 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp)
> >   {
> >       struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
> >       struct rpcrdma_ep *ep = r_xprt->rx_ep;
> > +     struct ib_qp_init_attr init_attr;
> >       struct ib_recv_wr *wr, *bad_wr;
> >       struct rpcrdma_rep *rep;
> > +     struct ib_qp_attr attr;
> >       int needed, count, rc;
> >
> >       rc = 0;
> > @@ -1385,6 +1387,11 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp)
> >       if (!temp)
> >               needed += RPCRDMA_MAX_RECV_BATCH;
> >
> > +     if (ib_query_qp(ep->re_id->qp, &attr, IB_QP_STATE, &init_attr))
> > +             goto out;
>
> This call isn't completely cheap.

True, but it's done only once every 7 Receive completions.

The other option is to use re_connect_status, and add some memory
barriers to ensure we get the latest value. That doesn't help us get the
race window closed any further, though.

> > +     if (attr.qp_state == IB_QPS_ERR)
> > +             goto out;
>
> But the QP is free to disconnect or go to error right now. This approach
> just reduces the timing hole.

Agreed 100%. I just couldn't think of a better approach. I'm definitely open
to better ideas.

> Is it not possible to mark the WRs as
> being part of a batch, and allowing them to flush? You could borrow a
> bit in the completion cookie, and check it when the CQE pops out. Maybe.

It's not an issue with batching, it's an issue with posting Receives from the
Receive completion handler. I'd think that any of the ULPs that post Receives
in their completion handler would have the same issue.

The purpose of the QP drain in rpcrdma_xprt_disconnect() is to ensure there
are no more WRs in flight so that the hardware resources can be safely
destroyed. If the Receive completion handler continues to post Receive WRs
after the drain sentinel has been posted, leaks and crashes become possible.


> > +
> >       /* fast path: all needed reps can be found on the free list */
> >       wr = NULL;
> >       while (needed) {
> >
> >
> >



-- 
When the world is being engulfed by a comet, go ahead and excrete
where you want to.
